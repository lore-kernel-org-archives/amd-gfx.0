Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F73C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B8F73DBF;
	Mon,  6 Dec 2021 10:19:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812E26E0DD
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 10:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZARPucUO4iEOvKflcxDOt6xnEe9G+vK7ofJwJyM9UwGOZ5u7EfggORSb4jh3Y69wM0S1WuwszovBYL+5bgrZ0L1q74xNV26lOIOrX+P2eFmuIP3aSK2GozpzFJXj+5swJbU8dDCrYnkebfFipWBdz3O2Y9Fn+u2Goed1ujBazD/VIWVyaTOilpYamYE9DoWANkUG70jsuzbsTSIgTKKzVHjdVO7oTB7iaLLRMc4dZ0QEDCrQLhRTDab5bNNJsUh0/6c1C93n16Omr9EsYPUo94ulFOrCAmalv8jYFO4cy8DNEnHJLDJd9cxW3l/mP0blSU4UEHPa0+INSzuczaeINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upc6w5cl5/TQYyaE3IKSsIgogS3sPDJPqdYW9ZwlLvU=;
 b=dChb2t8AEd5Fqnutes7BZGJK7qqZxKNJWiLh0kJwRirPH42QVNEctY3e5no2S+8am/f3sEy7OVCESwugbODWUzRSxon/jTQ9FxMjS3rD59yEKOjdERkIfw/tAGEQn09Bq1zFJ0zYzx6Lb5jkQhPk1y1+CXK6puGX1V3Pe7OSATyvtOgOaYtcY8wDIisZh3MmOkfR31S+74S7GW0sNvvBIe+tFaIM756RrZCMDBXXgc3LAGuodKdXaQEAEprrD0ZiRtYA0PTxZkGMIm+Y1Gw/2hwYx1d5les19QM5g5sZaSM10s6YukkD748trnIWwPXEwAYF+W0yf45uZt9R5TqoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upc6w5cl5/TQYyaE3IKSsIgogS3sPDJPqdYW9ZwlLvU=;
 b=Uy1M4buCZee7lxb7YzG7APLFl270kwu6FFiUpARf0yobX+8xdLXa8H1n5DFm8YhM99MlqPIqcg4EXk2HSFpC724xUfu2uUh4e5iBkI1mLV4O9jjuua3fz9pXXbqQ5/0t82MHVtqkpBg0gfD2vsWWlv+W0vTKsEbadphcSTyYj6I=
Received: from MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23)
 by BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 10:20:56 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::a) by MWHPR07CA0013.outlook.office365.com
 (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Sat, 4 Dec 2021 10:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 10:20:56 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 4 Dec 2021 04:20:54 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: read and authenticate ip discovery binary
Date: Sat, 4 Dec 2021 18:20:32 +0800
Message-ID: <20211204102032.3063-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211204102032.3063-1-Hawking.Zhang@amd.com>
References: <20211204102032.3063-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 974ab833-dadc-45f4-ba3f-08d9b70fc25c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3041:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3041CB4C7AAFF8431D1BCE31FC6B9@BN8PR12MB3041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYNlodG0q7txt25vh/6Y2W9llPkbHlyFPLZXQ9ydioQNnBP11a9PBETwTl78y7dvKu5etFTd/JWCPTyLqkGFZYHEPnv+MwRXYsMOoNI0CmseayVxb8x4PBSqrcUtubf1eE0GQeCQ/+hiabv5m5NH0NgxuyGEIbg3CZ1aa7n1jOSjFJRQIxGRUat4cutpMFBc3VCmD2f0LlJdwk2eKf9+torhZ6uzaYZNEf0cCpMW8ySfu9pV7izKDIhA3WM+PD/pOjd71L86Yq474ZHlpKScl8FrTrU761Mq8xnqter0sbQu+FV8KHz/SrTf/I+qMGowYJgvdviHDu7W5pHYTpYrPVCIRzx8fwTpfiR3DEMSwJs5IGBCW/nvwvY95J/XTVmbWBxv33JRUrRWSPtH94qZwNTiUqgbeO0RFpg69t/Zy/chzig750M6vgx3uJuY9CuVT4kDSM6xjbpMy/LBjSOl2dG5dIJXWSNdInWfkuCvGdFMYzGWJzrGDkI5peiXI58a1/WyRPI8apFskfSzQU8iOcjXGTzHPVAibfPTzA/9N3xshVzofACfUZwOyGcKPyxdhPhKQ9duNGJZvJ1NoI2+7/wPsbDdICYhPUOs7a0kvFOA7DkMk4cU4gLuqhGGU4orD4/x1d3NTm01GW3HLqP1j5Gy0Q6Lik8CGqL5NYOGwE5m1sAm6ScNge/qzAfs2XJWbMcnakD+7m0qNo2l6WvoayK4aZEoEXWIk/6hyZFmeZfKysX8wv3Q0RtJY+tyrTHkbDedkxqPtXYtCF6mTQH/wjtG/MZJI1qo5mcTy7ESWyk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(8936002)(86362001)(336012)(6666004)(5660300002)(2906002)(82310400004)(7696005)(36860700001)(186003)(36756003)(4326008)(16526019)(40460700001)(1076003)(26005)(8676002)(356005)(70206006)(70586007)(83380400001)(426003)(316002)(2616005)(81166007)(6916009)(47076005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 10:20:56.1322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974ab833-dadc-45f4-ba3f-08d9b70fc25c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3041
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

read and authenticate ip discovery binary getting from
vram first, if it is not valid, read and authenticate
the one getting from file

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 44 +++++++++----------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f507cd70ab86..45f38ae6e53c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -247,7 +247,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct gpu_info_header *ghdr;
-	const struct firmware *fw;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
@@ -258,31 +257,28 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	if (!adev->mman.discovery_bin)
 		return -ENOMEM;
 
-	if (amdgpu_discovery == 2) {
-		r = request_firmware(&fw, "amdgpu/ip_discovery.bin", adev->dev);
-		if (r)
-			goto get_from_vram;
-		dev_info(adev->dev, "Using IP discovery from file\n");
-		memcpy((u8 *)adev->mman.discovery_bin, (u8 *)fw->data,
-		       adev->mman.discovery_tmr_size);
-		release_firmware(fw);
-	} else {
-get_from_vram:
-		r = amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
+	r = amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
+	if (r) {
+		dev_err(adev->dev, "failed to read ip discovery binary from vram\n");
+		goto out;
+	}
+
+	if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+		dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
+		/* retry read ip discovery binary from file */
+		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin);
 		if (r) {
-			DRM_ERROR("failed to read ip discovery binary\n");
+			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
+			goto out;
+		}
+		/* check the ip discovery binary signature */
+		if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+			dev_warn(adev->dev, "get invalid ip discovery binary signature from file\n");
 			goto out;
 		}
 	}
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-
-	if (le32_to_cpu(bhdr->binary_signature) != BINARY_SIGNATURE) {
-		DRM_ERROR("invalid ip discovery binary signature\n");
-		r = -EINVAL;
-		goto out;
-	}
-
 	offset = offsetof(struct binary_header, binary_checksum) +
 		sizeof(bhdr->binary_checksum);
 	size = bhdr->binary_size - offset;
@@ -290,7 +286,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      size, checksum)) {
-		DRM_ERROR("invalid ip discovery binary checksum\n");
+		dev_err(adev->dev, "invalid ip discovery binary checksum\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -301,14 +297,14 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin + offset);
 
 	if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
-		DRM_ERROR("invalid ip discovery data table signature\n");
+		dev_err(adev->dev, "invalid ip discovery data table signature\n");
 		r = -EINVAL;
 		goto out;
 	}
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      ihdr->size, checksum)) {
-		DRM_ERROR("invalid ip discovery data table checksum\n");
+		dev_err(adev->dev, "invalid ip discovery data table checksum\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -320,7 +316,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 				              ghdr->size, checksum)) {
-		DRM_ERROR("invalid gc data table checksum\n");
+		dev_err(adev->dev, "invalid gc data table checksum\n");
 		r = -EINVAL;
 		goto out;
 	}
-- 
2.17.1

