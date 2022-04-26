Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584D9C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE8E10F0E8;
	Tue, 26 Apr 2022 18:27:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A1F610F064
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyQg4427XDu5Qw5i5lUelvsGCHRhWXaAquPdB5DJb3c2Y/GroRn/jmjMRKF/IHF5pS9mge0BZcPWfNnNlKtc4fYN5n6WhQQERzX9oRSFH3krYq4tNhIt2tRb8SGjrRrx6tSrteA4qG9HAJqOqNKHSRUePBmNZrJhBV929sxxYpw09pDMzvy/vyDQQLPz2P3DjvA46NBeSQwAfgF0emIBBNyEZEVzLG+ifEJQLwGVyHJzL7mY/L7iGsNdjn/BWpt4lYjBnpHB3g/U/uuwWU1Vp6HbDfQGG1Cip9q23hXPwuWhm1NaNDZY/LizZ5H+0i6nHZTHoep9LKTOfedCVVuT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne5z6Q8bwkv4yugj2QoJOxKl1lGuFcMmDA3BmpRLf1c=;
 b=BB8n9G8/i2x+/tw4RuOuo8G7ZyrB52ZH74OzINyunFNr7Rd//IiMkNroQ0g40qi7OZFn11RjpG3ZMQd6aypIxV6cBrUGWk3V0VqPsCmY8tFYldTPHWFeUmwxiYcA0Ee9VI+UyiZlfA0ts2OPX1NRISYIdJeNTkcMnSwIYPANrslCw7BZ1vTC0Jk5ym301nbNWtxm6lYCzGAjRmKJT9UXscnkidf3O/y+UibR/UVV6b67g9ZzLmYJ8HHoYnqhdv+S4iUNgN/2ayYi6hQfk+pij1weBbwI4hH4y+yWdhzUSKQIpoVMdx8v/cLu3TZKtRK/n15Md9+DFea0ygHHhQ919A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne5z6Q8bwkv4yugj2QoJOxKl1lGuFcMmDA3BmpRLf1c=;
 b=yGehFM+pRTpvsPwz+unv7SozEquGTCZtiPqsUa+rYGy4/HoeTStprSUxC2XmAbCGIbTDfheUBEd0/Ii5Xkqun6wwopii+xZtngS3/oF7FZkkEaxBUX289E9pYA9EtMYVLM0TGTRtojyzuVIghlPW2KdUFm4gh7T+RqxpdCdC5nw=
Received: from BN9PR03CA0740.namprd03.prod.outlook.com (2603:10b6:408:110::25)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 26 Apr
 2022 18:27:46 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::1e) by BN9PR03CA0740.outlook.office365.com
 (2603:10b6:408:110::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amdgpu/discovery: add additional validation
Date: Tue, 26 Apr 2022 14:27:25 -0400
Message-ID: <20220426182728.3006737-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 554f1c3e-3d82-4ab0-a5a9-08da27b275dd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB536308EFB321E36E8BE126D4F7FB9@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aCd7jhur4ndEHBbkHOF+wvMP2Hz1A7IbwQ+kwLokS8QdyJ6Aabr2GR+fqbi6oC6VzjkQkvJFQ0rtCrpMiH7l5XMZbZX3nN/2iM1AgUGFDrOrqLoVyNKKHLEIk0pwUWtSD2F1n2X/uzqei9UNs5i2317R3NJfs+G0KEvHUq0KbPBy9IXiDb17AKgxSX2EVfM1EEXwT9Cb+bcvOTetXU3M6VznWYDhLkdSZtidTK2SNx8GQLFlrufc8n2r3txzJReEs2imZS3cP/o7pijvsqR3+p+Hqiyc+9IguqoMLRnALkr/slyy/0kQDuCJvG4PN6YSeeJ05pzX/QyNAXJxC1NbqbCIMC6BWxaoTkARgQ5eYeuqEuCExRa6cyZTvQJJ7WvXBfI5MhF4LAlDuI8pyPAP1YAOPmdSAtX5quPC1M4lOwL26vLvFzbt67Kqs0iT1vLfD2e8cLthIxZrc7h+VZwxNzNOvSurrFemBHwLuBQQLo/SkujxRCm3DymZSV0227wfCEiWShPpFOANOD+d7op5HDEaBD/fl2lgBFwTi7rxKCBhSZrL60zz5yjla2Y9b+ljeoQyOhSbgsvDqBtnKNsMayfiUqmIVbuZpkijbNYGBzPR6jlHR0iMly1JdA/tJ+d6It9c6JuhdjdVOxs29QkyXxm1drRx/F8Ew2ppz+uGMA2Y926ypRH8/4X90T82rEl7LKuwIcYKCindwLqIMUrZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(86362001)(2616005)(83380400001)(6916009)(36860700001)(8936002)(16526019)(186003)(81166007)(316002)(356005)(1076003)(6666004)(40460700003)(70586007)(70206006)(8676002)(2906002)(4326008)(36756003)(26005)(5660300002)(82310400005)(336012)(7696005)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:46.0687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 554f1c3e-3d82-4ab0-a5a9-08da27b275dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check the table signatures and checksums and verify that
the tables exist before accessing them.

v2: disable MALL table for now

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 152 +++++++++++++++---
 1 file changed, 126 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 402e125649a8..a9b5480a1d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -271,8 +271,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
 	struct binary_header *bhdr;
-	struct ip_discovery_header *ihdr;
-	struct gpu_info_header *ghdr;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
@@ -290,7 +288,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
 		dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
 		/* retry read ip discovery binary from file */
 		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin);
@@ -324,31 +322,110 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	info = &bhdr->table_list[IP_DISCOVERY];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
-	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin + offset);
 
-	if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
-		dev_err(adev->dev, "invalid ip discovery data table signature\n");
-		r = -EINVAL;
-		goto out;
-	}
+	if (offset) {
+		struct ip_discovery_header *ihdr =
+			(struct ip_discovery_header *)(adev->mman.discovery_bin + offset);
+		if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
+			dev_err(adev->dev, "invalid ip discovery data table signature\n");
+			r = -EINVAL;
+			goto out;
+		}
 
-	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-					      le16_to_cpu(ihdr->size), checksum)) {
-		dev_err(adev->dev, "invalid ip discovery data table checksum\n");
-		r = -EINVAL;
-		goto out;
+		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
+						      le16_to_cpu(ihdr->size), checksum)) {
+			dev_err(adev->dev, "invalid ip discovery data table checksum\n");
+			r = -EINVAL;
+			goto out;
+		}
 	}
 
 	info = &bhdr->table_list[GC];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
-	ghdr = (struct gpu_info_header *)(adev->mman.discovery_bin + offset);
 
-	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-				              le32_to_cpu(ghdr->size), checksum)) {
-		dev_err(adev->dev, "invalid gc data table checksum\n");
-		r = -EINVAL;
-		goto out;
+	if (offset) {
+		struct gpu_info_header *ghdr =
+			(struct gpu_info_header *)(adev->mman.discovery_bin + offset);
+
+		if (le32_to_cpu(ghdr->table_id) != GC_TABLE_ID) {
+			dev_err(adev->dev, "invalid ip discovery gc table id\n");
+			r = -EINVAL;
+			goto out;
+		}
+
+		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
+						      le32_to_cpu(ghdr->size), checksum)) {
+			dev_err(adev->dev, "invalid gc data table checksum\n");
+			r = -EINVAL;
+			goto out;
+		}
+	}
+
+	info = &bhdr->table_list[HARVEST_INFO];
+	offset = le16_to_cpu(info->offset);
+	checksum = le16_to_cpu(info->checksum);
+
+	if (offset) {
+		struct harvest_info_header *hhdr =
+			(struct harvest_info_header *)(adev->mman.discovery_bin + offset);
+
+		if (le32_to_cpu(hhdr->signature) != HARVEST_TABLE_SIGNATURE) {
+			dev_err(adev->dev, "invalid ip discovery harvest table signature\n");
+			r = -EINVAL;
+			goto out;
+		}
+
+		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
+						      sizeof(struct harvest_table), checksum)) {
+			dev_err(adev->dev, "invalid harvest data table checksum\n");
+			r = -EINVAL;
+			goto out;
+		}
+	}
+
+	info = &bhdr->table_list[VCN_INFO];
+	offset = le16_to_cpu(info->offset);
+	checksum = le16_to_cpu(info->checksum);
+
+	if (offset) {
+		struct vcn_info_header *vhdr =
+			(struct vcn_info_header *)(adev->mman.discovery_bin + offset);
+
+		if (le32_to_cpu(vhdr->table_id) != VCN_INFO_TABLE_ID) {
+			dev_err(adev->dev, "invalid ip discovery vcn table id\n");
+			r = -EINVAL;
+			goto out;
+		}
+
+		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
+						      le32_to_cpu(vhdr->size_bytes), checksum)) {
+			dev_err(adev->dev, "invalid vcn data table checksum\n");
+			r = -EINVAL;
+			goto out;
+		}
+	}
+
+	info = &bhdr->table_list[MALL_INFO];
+	offset = le16_to_cpu(info->offset);
+	checksum = le16_to_cpu(info->checksum);
+
+	if (0 && offset) {
+		struct mall_info_header *mhdr =
+			(struct mall_info_header *)(adev->mman.discovery_bin + offset);
+
+		if (le32_to_cpu(mhdr->table_id) != MALL_INFO_TABLE_ID) {
+			dev_err(adev->dev, "invalid ip discovery mall table id\n");
+			r = -EINVAL;
+			goto out;
+		}
+
+		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
+						      le32_to_cpu(mhdr->size_bytes), checksum)) {
+			dev_err(adev->dev, "invalid mall data table checksum\n");
+			r = -EINVAL;
+			goto out;
+		}
 	}
 
 	return 0;
@@ -441,11 +518,19 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 {
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
+	u16 offset;
 	int i;
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
-			le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset));
+	offset = le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset);
+
+	if (!offset) {
+		dev_err(adev->dev, "invalid harvest table offset\n");
+		return;
+	}
+
+	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin + offset);
+
 	for (i = 0; i < 32; i++) {
 		if (le16_to_cpu(harvest_info->list[i].hw_id) == 0)
 			break;
@@ -1176,6 +1261,7 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
 	union gc_info *gc_info;
+	u16 offset;
 
 	if (!adev->mman.discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
@@ -1183,8 +1269,15 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	}
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	gc_info = (union gc_info *)(adev->mman.discovery_bin +
-			le16_to_cpu(bhdr->table_list[GC].offset));
+	offset = le16_to_cpu(bhdr->table_list[GC].offset);
+
+	if (!offset) {
+		dev_err(adev->dev, "invalid GC table offset\n");
+		return -EINVAL;
+	}
+
+	gc_info = (union gc_info *)(adev->mman.discovery_bin + offset);
+
 	switch (le16_to_cpu(gc_info->v1.header.version_major)) {
 	case 1:
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v1.gc_num_se);
@@ -1260,6 +1353,7 @@ int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 	union mall_info *mall_info;
 	u32 u, mall_size_per_umc, m_s_present, half_use;
 	u64 mall_size;
+	u16 offset;
 
 	if (!adev->mman.discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
@@ -1267,8 +1361,14 @@ int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 	}
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	mall_info = (union mall_info *)(adev->mman.discovery_bin +
-			le16_to_cpu(bhdr->table_list[MALL_INFO].offset));
+	offset = le16_to_cpu(bhdr->table_list[MALL_INFO].offset);
+
+	if (!offset) {
+		dev_err(adev->dev, "invalid mall table offset\n");
+		return -EINVAL;
+	}
+
+	mall_info = (union mall_info *)(adev->mman.discovery_bin + offset);
 
 	switch (le16_to_cpu(mall_info->v1.header.version_major)) {
 	case 1:
-- 
2.35.1

