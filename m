Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820C5C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 15:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7BB10EC12;
	Thu, 22 Sep 2022 15:27:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3502B10EC14
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 15:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvgHN9VfpxM14MYyOH01EgvEshqibA2WWC4go20gGXGWKT9piFm1nz0YQ/o6u9eyC3ofXsujY0/9lLJNvknpYDbqYuCI1PfkRDdiEl391VblLOyvZMPGOiGyzNU5TX0xn27bT8Il4oLVnPWdY9GzRTv0+iOHMX2+7CBn5dGorgnlLafKLZarcEBIa5T6Jbp45Vp6dVYAJqVredSc5NvzWAenFROcTd0vXP7j758rtPCk8qiZ4jd9iGxxNRDhY/JezxjJ9OEAI7hRR74I7I840gZ7LnKq7akDTDZORywROjPoPc3ZIJXycSoW/un9B7APrXnj5ONtRmObjA9xK8cPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4wS1StGtSMHGt8lztYSg+3SVotr5eeocxamfBDerz4=;
 b=RYdfCCmaZLYzcSHuUQn9KC789q3s7yqfnEvYi1uHOyQqTA+6ASco4thFndgjzmsJYZJMV7KGmyBxeBsEpgBlJH4MP+TMckK1r5pUzl3P0UK38gEm4dR35pCVKmG5BhSQbMznSUUNfmj35c7y7TFJJYxCVO0Q6r1UKCzqPm8BhjjfeL2NbiWUgfGiJYP6U3nBcLHaOvLakWQ1Fb+szdxQVETno4TYz0Uk2P0M+x+EXQMXka3zcMKwwNfKiG4ygNrHkBm/U4gcia/YARA8E8ZrSeIuYkHviH9Mz2SfUi++ThmV4mmAcstLi2/L0vWAWHZ2DaJX1bXYDxm3nrsjLP5XQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4wS1StGtSMHGt8lztYSg+3SVotr5eeocxamfBDerz4=;
 b=Qy34jtiz2T2habB5ACN7qmPXXRKnLRI6+miTwUK5vokR58Dg1bA/rmN+/wTa+fglAOETDu03lBRRbiyvksPm8gYUySmdcDwPECoQ0mPZyMU3AzAPXSvolmu0rOqn2n/AlaKT7fvaiVhL3Znx0zD1k1Y/7OSe01wXUX3mF4z6BbU=
Received: from DS7PR05CA0006.namprd05.prod.outlook.com (2603:10b6:5:3b9::11)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 15:26:54 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::9) by DS7PR05CA0006.outlook.office365.com
 (2603:10b6:5:3b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7 via Frontend
 Transport; Thu, 22 Sep 2022 15:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Thu, 22 Sep 2022 15:26:54 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 22 Sep 2022 10:26:42 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix VRAM BO swap issue
Date: Thu, 22 Sep 2022 08:26:27 -0700
Message-ID: <20220922152627.265948-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 81df7ce5-b75b-43c1-6abb-08da9caee14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJj5ZtFcuyqv7Md+OFmKXQw98Qlaj4GwLj+kKfkOQp5igd/C5oDS0D+7fT/ktm7GWpdz/QZ11Ql8be6Ogz2v7Z6HL8+NhWoDKWxrAxeeWWkLWgSXnnKipRWEOAz5PofXgfqKEw71KoyHTE8sDXXiv4Vxukjv2XCAytqQS4kthdMaGl0lxb+oCswstRsojQ7C8AJPT7Qfa4kizxjAtiwQrZgrrl+yEqYUN4+/C/JSkYmarqXnAXnoHSIUHiR5lilaSBieymKynZ6dk8Xh66oPDelW/kEGTQi9FX1UOA4Bax7rWqP1yXfu0BAJ7nxx+7KAemJbHW8/zJlO9WCipbJDu5gFdnFtU0BvcCw16brf2on+XKWbmVQqsztQRJI5hz9aaPwIWl9Zfn8gj3bkRvflyFt0u59RER0IxJhR/48v/grEe8lF6CVwNHjxgszAxpUUul4cOuk670etklVAagF3bSKENNIe2Ulz24xtp4NNO3hDHDp/l/3kQmrYrzCnOTFO66CtGZ6Sb0cajItM/tvizJVxxEawMBo5Z/ZlGdDa97kLXcgGqfgZD/vHpLDtDIU44JQ5R27TA19GeB8NK1l35iAue+GXVTnU6+tGTkNdNKTH73OWALAcB5Sk2wJIDEwWzZxZuj1+iSaIm29apfK2hEwwtSp9/mLTtoBVzYNaOK4wWJjzDlWpqhfDWzRrXiV326x6m7JGrBPpjpRV/9IvG0O474OaIGBb6jXl+vnqhgkO7QS12TUlq5WIC7WnTPQS3gQ8qBFcLc77srLV3E2ofQ2WZfYypjK+TN8qpwMWttG8sKTju+Le4iPWrzocl2PD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(336012)(40460700003)(7696005)(2616005)(26005)(81166007)(478600001)(2906002)(82310400005)(5660300002)(36860700001)(86362001)(82740400003)(356005)(426003)(186003)(40480700001)(16526019)(47076005)(41300700001)(6666004)(70206006)(83380400001)(1076003)(70586007)(4326008)(6916009)(8936002)(54906003)(316002)(36756003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:26:54.2908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81df7ce5-b75b-43c1-6abb-08da9caee14c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com, christian.koenig@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DRM buddy manager allocates the contiguous memory requests in
a single block or multiple blocks. So for the ttm move operation
(incase of low vram memory) we should consider all the blocks to
compute the total memory size which compared with the struct
ttm_resource num_pages in order to verify that the blocks are
contiguous for the eviction process.

v2: Added a Fixes tag

Fixes: c9cad937c0c5 ("drm/amdgpu: add drm buddy support to amdgpu")
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b1c455329023..b1223c8e30c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -426,6 +426,7 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
 {
 	uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
 	struct amdgpu_res_cursor cursor;
+	u64 start, size, total_size = 0;
 
 	if (mem->mem_type == TTM_PL_SYSTEM ||
 	    mem->mem_type == TTM_PL_TT)
@@ -435,8 +436,23 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
 
 	amdgpu_res_first(mem, 0, mem_size, &cursor);
 
-	/* ttm_resource_ioremap only supports contiguous memory */
-	if (cursor.size != mem_size)
+	do {
+		start = cursor.start;
+		size = cursor.size;
+
+		total_size += size;
+
+		amdgpu_res_next(&cursor, cursor.size);
+
+		if (!cursor.remaining)
+			break;
+
+		/* ttm_resource_ioremap only supports contiguous memory */
+		if (start + size != cursor.start)
+			return false;
+	} while (1);
+
+	if (total_size != mem_size)
 		return false;
 
 	return cursor.start + cursor.size <= adev->gmc.visible_vram_size;
-- 
2.25.1

