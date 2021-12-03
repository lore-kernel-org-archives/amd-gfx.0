Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5CEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 01:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370656E101;
	Fri,  3 Dec 2021 01:55:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AAA16E101
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 01:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1orfVIPt8Kcj1tLTZs4pZIBRbCSai5UnSA/Ynp3hNp4Opfr/uH/P8cgBsbUZigZmYe2Txi9heoCY8h4ZV7YlvBy2WfN4asZXz5r2NzRA6sK0eSIigAKSLKwbZgaXiViOLJ6Q/xytasuWMzCHE+DSMtI+AxNj93gXrQ3fICpop/Ej00GvFh0Kbzka5gT3zAZnsiSgHUiveyYPGQi7b5HCpMnCuIS0q7a18ylCUI4JkgjCAvL/9h/TJpvE9panpymUzvRsaFPOjcY3JDBbxnfWFk5BJC5jMtvZfg4ZfuaE8t9W033JiOMrZRgaTdAQFqfifiUC3l209BwsSAIWtBRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBEN/jBeDOyBoTycWY0z5u+YteV14eSuTejY/Jmh7bo=;
 b=ETH8ZULyzv6fEAGYklo5wcnfn9BqL2VuN0mR/g0CsuGFDnAcX4XgPmAZy/VKEcJg/OUJMS8xG0EdxH4LkFSZRUHz0Vaocj1orKq35XcH1+RdaVuUOKm8T83ymRFdXr1SmYIU4AdkiyajfnQ4OxLGiBs3rTK5O+AIszrJ5I3tI2iQzB9CIJfAsVhbGjF1Yr9hur4hZtXx9H/ABQxW+fbfSsjsMBJp86kfv1gIq6hY1vWIhGokNo4gp5K3rURGKnYNCMd8hV2HL3kIPDAOm5wwkinIeqeyuSklSMcpVteuEd8ahbZFRcOqQWM4AMXot1l2jC4gz+7YVN8L3t20kB0gCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBEN/jBeDOyBoTycWY0z5u+YteV14eSuTejY/Jmh7bo=;
 b=U3N6t69dgVOHGXICp0w4WpUV9KeVid4avKm4rye9bgNZiUhM4g89YHq9zqv4Vx8OIwjOVKsVSVowmW0KCNURzJKOKvBKvSumTUc3SwAZX+QjXfzNRktrH3g5CSsIATvTNH0TzCLsI1GAYyudUy94jsPPMoGr0ecZ34mu0D6Qh2U=
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 01:39:49 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::cb) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Fri, 3 Dec 2021 01:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 01:39:48 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 19:39:46 -0600
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix null pointer access of BO
Date: Fri, 3 Dec 2021 09:39:33 +0800
Message-ID: <20211203013933.3788-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a41f29-c7ed-4d59-8533-08d9b5fdcb0a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4549:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4549AC459D48483CE52FA637876A9@MN2PR12MB4549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYcZpT1RSRi4H1HXtceOG6qirkC7ZthpJgxdUxMyJxo2b2Di23+ooA7qMHqv6X5QtAmW1Ef/J7MEgmLaT87F+eqw5l5w2OKne9WiZc3Ivtx0TO55X65dmVZW0dgThTH9XeGu4Q86Xm0rNBQrPfmYR0lMptFusy06XOoA8CcP/qsOotTA1MnY/dDVICzFCslMnCfkW7uMcLcJJDlJLcBRr11xRTr0Sb/EnI0QthdFOOqmtlfDs6ZKvr12u0oC0MdQKgRqv5tGylqaBlY2qSYX7yjiKRzFh3RLNA9gHtUru6Hugqp3e7yWmWNDq2s2Sv4rrEamVzzheftbPApMMeO5IMxp3+uRZILNncygdAVT+bwc1cwR9EaZtIPau+uolhqPk9hrvtBc/fmXYDRbDXcXmlztSbiSCUIuerxjVKCXGJuIte/5W0+qeX4C6VporpS7Kg4X6RFQdSX2mOLolntL855CNNxpOjx+UIYYqcqiNQVY0Ycgeshq4Kk15IaeDmVroeKPXrWOZ6eFlUi/va9JSNIKHpiZ21TkVa3vE5Cq1XXHBiP2hwgBFznw1Qk5RBJX2+NMRzoYi8YOnt2X4piG85laZ9KXnzTVWPyuRasx/7O8w1k0/faoXFpswwHyAvtMbjtuG/feFNcYlpR5dqQ9dr2S2517wRehDSKoITCJQdB7sUTEUjYdrFI7auHDQMWYX+L8j7otNPCD9sCP7aQYzOV0CYGg0MHq354I6VSmpnR6JwYrDf6FDSlrjPITKvLuEBkgWFmc3Zeo+tMt9eBsYgoE7byiTujslZEZ8R6kULs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(6916009)(26005)(336012)(70586007)(426003)(40460700001)(6666004)(82310400004)(508600001)(70206006)(16526019)(5660300002)(7696005)(186003)(1076003)(54906003)(4326008)(316002)(36756003)(47076005)(8936002)(8676002)(356005)(81166007)(83380400001)(86362001)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 01:39:48.5734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a41f29-c7ed-4d59-8533-08d9b5fdcb0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TTM want bo->resource to be valid during BO's life.
But ttm_bo_mem_space might fail and bo->resource point to NULL. Many code
touch bo->resource and hit panic then.

As old and new mem might overlap, move ttm_resource_free after
ttm_bo_mem_space is not an option.
Lets create BO in CPU domain first then alloc memory from specific
domain.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c4317343967f..46036ea79335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -359,13 +359,15 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_resource *tmp_res;
 	unsigned int i;
 	int r;
 
 	offset &= PAGE_MASK;
 	size = ALIGN(size, PAGE_SIZE);
 
-	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE, domain, bo_ptr,
+	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_CPU, bo_ptr,
 				      NULL, cpu_addr);
 	if (r)
 		return r;
@@ -380,17 +382,18 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 	if (cpu_addr)
 		amdgpu_bo_kunmap(*bo_ptr);
 
-	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
-
+	amdgpu_bo_placement_from_domain(*bo_ptr, domain);
 	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
 		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
 		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
 	}
 	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
-			     &(*bo_ptr)->tbo.resource, &ctx);
+			     &tmp_res, &ctx);
 	if (r)
 		goto error;
 
+	ttm_bo_move_null(&(*bo_ptr)->tbo, tmp_res);
+
 	if (cpu_addr) {
 		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
 		if (r)
-- 
2.25.1

