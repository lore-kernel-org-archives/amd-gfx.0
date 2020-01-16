Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E220C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19E720663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q95qotVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19E720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3833E6EE92;
	Thu, 16 Jan 2020 18:57:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AA46EE92
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 18:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW9e3g3L/7OgLsVIY0mNu4l+TKy+H/NpF7kmRMGXfueFeL0ID13y/h0h0CvcPwawsSYYRALspuYmg6USDedtqPiGHV0fhCiOZE7z/PtE/WzTX3ntXEa+b9KZiLJzVuy0/SxISNhZzJvktfbE2YbXpEgTYXgv88jFRIjCSKY3694YAhZIWcat6yrN2iyc3VZEdcwxcAc7PMjebi9onQ7FBjeaglE9U5Nv3JrrHF6KoJkgNLmuieu7zZmwfCtJRr8Bo9IFzlAQ1BLHV8mYpwrEbTwE6uZUpoLL8s7xb+K0hYix69HSuZNxExOLizipKlpJHJLgjjc1CHA5/1Azd/uDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AHdQduXTzwTSwBC/MxzeT4IO81sLdkTFa1fyJi9MK8=;
 b=Edas5E/IC4E22hPdbtvgrdI/rJxXu+Z78IHhKLYHdMRqNjLpS86Bk46+hAbbVCDtRGhDAiPhjoYeS25XTdsjbOjIp4Gz54otd/Hb/DLxCrf2nsnwOiJ0strZUEfzdEgWvBTHr80nwLLaxaJ+aLAOcn7nu755jakbsxGdIT4+NEq1rMwvUCISJ5P74d+B3pxh0Lt/exFIaAvZIq1Eeg2gomIIS6GZro9qsEFTsbu2+oPMBiKN/OVM6EEFKnK25emPF0DfwRJmvZzS2QfhJQ5ykqBdBhZs/gBcMcZRf86P7vzbfbrBrs1drInDadoCfwmjFcVZYSCIFYDOrAnaKV8+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AHdQduXTzwTSwBC/MxzeT4IO81sLdkTFa1fyJi9MK8=;
 b=q95qotVMW/x0c8qr2of0nUS+RJjYmHNaqkNQtQ7UvY9s9WoB6YTBO7RG84EvNxtB2w5yxsN/1kKjY7ZOy5540Myd1Rrddyp9DokMj74I5BfZtokRV8XSgBgCnqqHn/RHS0F2W6sGt9vuPXPrKraOTVPtcIZCEQUOonCu5oo9K1I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2342.namprd12.prod.outlook.com (52.132.208.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 16 Jan 2020 18:57:20 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 18:57:20 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: allow init discovery tmr region per ASIC
Date: Fri, 17 Jan 2020 02:57:00 +0800
Message-Id: <1579201021-7109-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To DM5PR12MB1418.namprd12.prod.outlook.com
 (2603:10b6:3:7a::15)
MIME-Version: 1.0
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2665.6 via Frontend Transport; Thu, 16 Jan 2020 18:57:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b050a596-a3e9-41dc-074c-08d79ab5e9de
X-MS-TrafficTypeDiagnostic: DM5PR12MB2342:|DM5PR12MB2342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23427EAD711B5F49934D5638FC360@DM5PR12MB2342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(316002)(110136005)(5660300002)(81156014)(8676002)(26005)(81166006)(8936002)(6636002)(66476007)(2906002)(52116002)(478600001)(86362001)(66556008)(7696005)(66946007)(4326008)(16526019)(6666004)(956004)(36756003)(2616005)(6486002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2342;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aD8muTMYnrjSVEKxvjctNh0crcMIdYa1jD2GOyuPhYZkRteJZdXxtHCwda7W0IdgolkuN66Qwl1tvjupmvKh3TmFatf+rIjfXJ9X4t8Jbptc/rFYmthM0E1EM0tCIkj7EU3EYXZWfeU+ArtDsq27b4EvcgLJYGhflzu/Cw54OMfQQaAEAZ9k1rFNqGIlgLOB5NkQ5WU5H5X5GaCgYpKvv3qIVtXchLy7QqQMh8uH71PUn/e8cwmumT7m6taccfIl91gqEXJr9RkNlOQE+6LzdI0Ar01MgfGRn8brGZTF2PPRID1M28nBzSSCO+SFl7cXil5fbLQt31AmIeWGcFs+/kHXY2bIMG1Pgan9sTBx02ns6alH7B/1UmLZuXFs7ErkjXrjwQkYBufoNiMLiAHKbQqZK2C0VjHDWo3W7f76ZGmXYgAxSrPOSFAmINb+nIaD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b050a596-a3e9-41dc-074c-08d79ab5e9de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 18:57:20.4232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTpGdQjo+/FESzwCAEHhHDx8lswqFesrzsvoEsblrIwlsycC5YnhR5i/72gAdhCYXr3QvLAsOfHXHS6a0VWoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2342
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

discovery tmr size should be ASIC specific setting, instead
of fixed 64KB for all ASICs.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 58 ++++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 12 +++---
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 63eab0c..792fe16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -756,7 +756,6 @@ struct amdgpu_device {
 	uint8_t				*bios;
 	uint32_t			bios_size;
 	struct amdgpu_bo		*stolen_vga_memory;
-	struct amdgpu_bo		*discovery_memory;
 	uint32_t			bios_scratch_reg_offset;
 	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
 
@@ -908,7 +907,9 @@ struct amdgpu_device {
 	struct amdgpu_display_manager dm;
 
 	/* discovery */
-	uint8_t				*discovery;
+	uint8_t				*discovery_bin;
+	uint32_t			discovery_tmr_size;
+	struct amdgpu_bo		*discovery_memory;
 
 	/* mes */
 	bool                            enable_mes;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f950927..800cc78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -135,9 +135,10 @@ static int hw_id_map[MAX_HWIP] = {
 static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
 {
 	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
-	uint64_t pos = vram_size - DISCOVERY_TMR_SIZE;
+	uint64_t pos = vram_size - adev->discovery_tmr_size;
 
-	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary, DISCOVERY_TMR_SIZE, false);
+	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+				  adev->discovery_tmr_size, false);
 	return 0;
 }
 
@@ -169,17 +170,18 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
 	uint16_t checksum;
 	int r;
 
-	adev->discovery = kzalloc(DISCOVERY_TMR_SIZE, GFP_KERNEL);
-	if (!adev->discovery)
+	adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
+	adev->discovery_bin = kzalloc(adev->discovery_tmr_size, GFP_KERNEL);
+	if (!adev->discovery_bin)
 		return -ENOMEM;
 
-	r = amdgpu_discovery_read_binary(adev, adev->discovery);
+	r = amdgpu_discovery_read_binary(adev, adev->discovery_bin);
 	if (r) {
 		DRM_ERROR("failed to read ip discovery binary\n");
 		goto out;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery;
+	bhdr = (struct binary_header *)adev->discovery_bin;
 
 	if (le32_to_cpu(bhdr->binary_signature) != BINARY_SIGNATURE) {
 		DRM_ERROR("invalid ip discovery binary signature\n");
@@ -192,7 +194,7 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
 	size = bhdr->binary_size - offset;
 	checksum = bhdr->binary_checksum;
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
 					      size, checksum)) {
 		DRM_ERROR("invalid ip discovery binary checksum\n");
 		r = -EINVAL;
@@ -202,7 +204,7 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
 	info = &bhdr->table_list[IP_DISCOVERY];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
-	ihdr = (struct ip_discovery_header *)(adev->discovery + offset);
+	ihdr = (struct ip_discovery_header *)(adev->discovery_bin + offset);
 
 	if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
 		DRM_ERROR("invalid ip discovery data table signature\n");
@@ -210,7 +212,7 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
 					      ihdr->size, checksum)) {
 		DRM_ERROR("invalid ip discovery data table checksum\n");
 		r = -EINVAL;
@@ -220,9 +222,9 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
 	info = &bhdr->table_list[GC];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
-	ghdr = (struct gpu_info_header *)(adev->discovery + offset);
+	ghdr = (struct gpu_info_header *)(adev->discovery_bin + offset);
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
 				              ghdr->size, checksum)) {
 		DRM_ERROR("invalid gc data table checksum\n");
 		r = -EINVAL;
@@ -232,16 +234,16 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
 	return 0;
 
 out:
-	kfree(adev->discovery);
-	adev->discovery = NULL;
+	kfree(adev->discovery_bin);
+	adev->discovery_bin = NULL;
 
 	return r;
 }
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
-	kfree(adev->discovery);
-	adev->discovery = NULL;
+	kfree(adev->discovery_bin);
+	adev->discovery_bin = NULL;
 }
 
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
@@ -258,13 +260,13 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	int hw_ip;
 	int i, j, k;
 
-	if (!adev->discovery) {
+	if (!adev->discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery;
-	ihdr = (struct ip_discovery_header *)(adev->discovery +
+	bhdr = (struct binary_header *)adev->discovery_bin;
+	ihdr = (struct ip_discovery_header *)(adev->discovery_bin +
 			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
@@ -272,7 +274,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->discovery + die_offset);
+		dhdr = (struct die_header *)(adev->discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
@@ -286,7 +288,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				le16_to_cpu(dhdr->die_id), num_ips);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->discovery + ip_offset);
+			ip = (struct ip *)(adev->discovery_bin + ip_offset);
 			num_base_address = ip->num_base_address;
 
 			DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
@@ -335,24 +337,24 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
 	uint16_t num_ips;
 	int i, j;
 
-	if (!adev->discovery) {
+	if (!adev->discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery;
-	ihdr = (struct ip_discovery_header *)(adev->discovery +
+	bhdr = (struct binary_header *)adev->discovery_bin;
+	ihdr = (struct ip_discovery_header *)(adev->discovery_bin +
 			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->discovery + die_offset);
+		dhdr = (struct die_header *)(adev->discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->discovery + ip_offset);
+			ip = (struct ip *)(adev->discovery_bin + ip_offset);
 
 			if (le16_to_cpu(ip->hw_id) == hw_id) {
 				if (major)
@@ -375,13 +377,13 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct gc_info_v1_0 *gc_info;
 
-	if (!adev->discovery) {
+	if (!adev->discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery;
-	gc_info = (struct gc_info_v1_0 *)(adev->discovery +
+	bhdr = (struct binary_header *)adev->discovery_bin;
+	gc_info = (struct gc_info_v1_0 *)(adev->discovery_bin +
 			le16_to_cpu(bhdr->table_list[GC].offset));
 
 	adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->gc_num_se);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ae1b00d..967f6d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1819,15 +1819,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 
 	/*
-	 * reserve one TMR (64K) memory at the top of VRAM which holds
+	 * reserve TMR memory at the top of VRAM which holds
 	 * IP Discovery data and is protected by PSP.
 	 */
 	r = amdgpu_bo_create_kernel_at(adev,
-				       adev->gmc.real_vram_size - DISCOVERY_TMR_SIZE,
-				       DISCOVERY_TMR_SIZE,
-				       AMDGPU_GEM_DOMAIN_VRAM,
-				       &adev->discovery_memory,
-				       NULL);
+			adev->gmc.real_vram_size - adev->discovery_tmr_size,
+			adev->discovery_tmr_size,
+			AMDGPU_GEM_DOMAIN_VRAM,
+			&adev->discovery_memory,
+			NULL);
 	if (r)
 		return r;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
