Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52530C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A37810E908;
	Tue, 28 Mar 2023 15:15:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F8D10E915
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyRtuW4Wfe0hRO0RiXq/jF6Lu2yOAWXKgv6Rfae9YuzQB3bAw7p24j4Ua8lfhib274oFmHjDSRX0W6YcEADNRXV/mw3I0V6UDtJqtoNHZ47mBShEqUMvNkRKEIorSGXz9ox2Q1qaAp7qpEiSNoNEZTKEvVV6/E2V5wCoHf9MzK9TwXYXiYKIpA6UiZXHi2Kk2zktLi/spFPBnEyv4SXs9B7g590RjeIEL2qiZtLPQJpzq8od37icURugh1FLC92/l4LqANfDktX8KCs0DHJHmU4aJJ+TWLL300VBsNJvYW8V1L8jrQkTPWf8ovZvet5YtsUaPXoP1uFpyFmAtv/CoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8r3ow1p5TUzTeRZDLJNkZeZAdVzKklRuLE54wWMpFw=;
 b=g2IXRCwtUkOS+GBskLE/XRFRSepctBQxZqFGyIMQRc2ycz+XXbcCQFpvjHMjNqPOkpP3XDHiBJxowErhyl9F/PNj6T4n8z8yn/UflBnPINoDlwdYiunubcTB3mpw8AevoAf0rkNbE96NiCzbfZuQA5VmObXS4G+G8Dsyf4c9A0ucBuhHMd9tBrba3hs9spOqfU3MwGSJSZrI2Q6Hg2U/KFu1p6xJ53bISRwnkOu7yDgQRMEeIEr/bwoFDRk3s6Vv5DhUOVMx0PLl584JzbRANXnJQqQ668Cd2ukklCMwikX0N306HX4j3lVgYT5R+Pcv8j0NbroiK/66LhF2LgOmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8r3ow1p5TUzTeRZDLJNkZeZAdVzKklRuLE54wWMpFw=;
 b=ZVwWHCCXaquFn0pGHp7WDho3CTnJfJt1N4y62IaOD5JxzZ6fpJp2YQhiGvei9qvOYx7jox8MAjDWKMwgWHG5tVjW3yHxSQz2fMBDwg708wuKLxwD7iUeC8mNcggSKcq/Yc/nF7QY8sMbV78chocZSD0glft+Ay3qWsrio7Ipt7U=
Received: from BL1PR13CA0070.namprd13.prod.outlook.com (2603:10b6:208:2b8::15)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 15:14:45 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::f7) by BL1PR13CA0070.outlook.office365.com
 (2603:10b6:208:2b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/32] drm/amdgpu: assign the doorbell index in 1st page to
 sdma page queue
Date: Tue, 28 Mar 2023 11:13:33 -0400
Message-ID: <20230328151344.1934291-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: b85df66d-916e-4c02-67e9-08db2f9f29bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Gy1jmUulL4lHz6uuqHTCROLjZxHTatV5NovX7yfDsV401fN2ntQaaOSO/qIP96GtWY6P5WvWmd5pLpYHcq0LkkmoGCFXVrU50Jl36hOP6lxCM0dIO+7Ut8w48d/T2vfz339cfKwt0GB2Za3NEs691lsVEkxuoE9E/D3C0CYl6Iu+iNnuq0AHFH/oM32/WUjONVlFrPk45x2/s1dKBrMKEyUHm6zlgjk6NVsP2AjzjO+iLcpMGFwhpg1bEeL+CFIaTyhtYpr/KUoQpz2vtef/dibamkDnVushfp4A6l6zv035kM8Qz6Hulu7tyRHPJSYT4QNusfbEimmxbvAum11gNq4L7zNrm8+QShw47XTMIyfTZvLlZBOlFrQLSF4qmLuy+NFwjzCk3u0nwYa7iS1wGKUe05KkjU0crKlFmAYf6kAXzAs/w3r2qucWUvGhLv/sALlT/q4NUyqHUystLCTH85s1JPTujgA9GWBPWvu7/vgSF7MvYaevEI4qXgIAfq2iO+C5GRchrp4WWDuFSDlsTzJeNE2azTr7L71Vue18GuT6bjCa2eh+T8x7+L+V6TUASSzQwB8wfwqj8zdOgZ/UeFTpkMiye04Gfn13+FU70kEyA/HtfzneSspK/+jsfc6vnf1sQGhQzvGLcmJKgYS4ulHFJONslHUAOLwf3+Y0rpiTrDgAvnjqpY6gFs0nPpgtTl7l3mRmyLdUK8CcBmDFKgvu47i85IfVAvcV57H7s8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(426003)(83380400001)(336012)(2616005)(41300700001)(36860700001)(36756003)(86362001)(5660300002)(356005)(81166007)(40460700003)(82740400003)(478600001)(40480700001)(54906003)(7696005)(70586007)(2906002)(8676002)(6916009)(70206006)(4326008)(16526019)(6666004)(82310400005)(186003)(316002)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:44.9041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b85df66d-916e-4c02-67e9-08db2f9f29bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Previously for vega10, the sdma_doorbell_range is only enough for sdma
gfx queue, thus the index on second doorbell page is allocated for sdma
page queue. From vega20, the sdma_doorbell_range on 1st page is enlarged.
Therefore, just leverage these index instead of allocation on 2nd page.

v2: change "(x << 1) + 2" to "(x + 1) << 1" for readability and add comments.

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 14 ++++++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  7 +++----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1c657273d9ee..518e89a7d9ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1090,7 +1090,8 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 		 * doorbells are in the first page. So with paging queue enabled,
 		 * the max num_doorbells should + 1 page (0x400 in dword)
 		 */
-		if (adev->asic_type >= CHIP_VEGA10)
+		if (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(4, 0, 0) &&
+		    adev->ip_versions[SDMA0_HWIP][0] < IP_VERSION(4, 2, 0))
 			adev->doorbell.num_doorbells += 0x400;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index dfe91ebc7b43..68c6d0c8fe76 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1847,8 +1847,18 @@ static int sdma_v4_0_sw_init(void *handle)
 			/* paging queue use same doorbell index/routing as gfx queue
 			 * with 0x400 (4096 dwords) offset on second doorbell page
 			 */
-			ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
-			ring->doorbell_index += 0x400;
+			if (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(4, 0, 0) &&
+			    adev->ip_versions[SDMA0_HWIP][0] < IP_VERSION(4, 2, 0)) {
+				ring->doorbell_index =
+					adev->doorbell_index.sdma_engine[i] << 1;
+				ring->doorbell_index += 0x400;
+			} else {
+				/* From vega20, the sdma_doorbell_range in 1st
+				 * doorbell page is reserved for page queue.
+				 */
+				ring->doorbell_index =
+					(adev->doorbell_index.sdma_engine[i] + 1) << 1;
+			}
 
 			if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) && i >= 5)
 				ring->vm_hub = AMDGPU_MMHUB1(0);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 7efe7c43fffb..441d6911fd20 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1323,11 +1323,10 @@ static int sdma_v4_4_2_sw_init(void *handle)
 			ring->ring_obj = NULL;
 			ring->use_doorbell = true;
 
-			/* paging queue use same doorbell index/routing as gfx queue
-			 * with 0x400 (4096 dwords) offset on second doorbell page
+			/* doorbell index of page queue is assigned right after
+			 * gfx queue on the same instance
 			 */
-			ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
-			ring->doorbell_index += 0x400;
+			ring->doorbell_index = (adev->doorbell_index.sdma_engine[i] + 1) << 1;
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 
 			sprintf(ring->name, "page%d", i);
-- 
2.39.2

