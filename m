Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB238ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B8210EB8E;
	Thu, 15 Sep 2022 17:02:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3959B10EB8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGFWX6L384NYz9t+210/iJUgTy3VMYKMYTPZTm9tGQ8HYZHox4WuwZRQJGRYVaNt5MBakhnXvSjRXKi0uaLy0s1iWAf1WLIxKXDZ8fk3gbjns0GDHtp2MuJPA64AsQp3MaNCI9BnBOk/pTUyQxNvaeVymp30LZ8JoII2d6VKvoM0GIbhkV5+8SgqjOzBe94y3hR6tvpmrhqkZ5YsQR9rnHLM3Db0j5KNdyaPVhAbDv/94UMyqJvRfJaLKWniRlwTAzEmCGsydHDqvYkU3hcVdaX3gTHmMQ+8qxXruV6BO9DV+1scps7y9kigfzeaUuiS22xrL9w0DyhKFiw2/EndCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=974P8cMNEBBAH/BCd5KbWso8ZU3w3OHARbFO71XP4Ew=;
 b=BDqFaOn9rzItkytV/CFXSLUYZzrFDeC5NefZJdSpK8bC+SECixu0seCscmsCWB4QeUTqMpBk+hgZLKqJw0ZTcgLf00Bgqj3ak+y8bgV4gPPdeiZMeRcIisYwOujC980vvrDATYWMQ1mI9udVmhhQUcKVCZE5oAxKzrhVU39MATQ79VBozNYyYIyoK8W8Mlk2GNY3BwO4WlpyHJV2LbQ3I2pUztsLpkSOUwYqAuTv0j72HDGKlBckUl5poTQhUbBeBuGwYLABvSjosTc1WVHcnt9Xnqhft/v59/Y4jMQNcIQzM+ceT2XKVumMlzeg1bj+xinFfuyjBrUmmPCFJ8CMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=974P8cMNEBBAH/BCd5KbWso8ZU3w3OHARbFO71XP4Ew=;
 b=ElOjR8FT8z1pWyGQh0j2axRXbZtiDvSWj/lpmpZQNSdBk5iL6krLBGA/ZsmKBkNDHftt2waXB673HUmvsgHedZ+8Z/seVEM5Cvzw6GbzKDHtoGl5q8dSckZhNCshdeCaNJMOpjWEXTP0RMRdF1+T95w3KOIe0d91hEsrV2it2p8=
Received: from CY5PR15CA0165.namprd15.prod.outlook.com (2603:10b6:930:81::7)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 15 Sep
 2022 17:02:18 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::27) by CY5PR15CA0165.outlook.office365.com
 (2603:10b6:930:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Thu, 15 Sep 2022 17:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:02:18 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:02:08 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 08/10] drm/amdgpu/gfx9: switch to amdgpu_gfx_rlc_init_microcode
Date: Fri, 16 Sep 2022 01:01:33 +0800
Message-ID: <20220915170135.23060-9-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170135.23060-1-Hawking.Zhang@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ed19c1-dc64-4d55-0306-08da973c0c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rppvAxKngbI1EA9Cy7GUh1Sy1qEAEV6Mm0kIeZJCxy4kEFxgTsespaECrWZbwAZ70sFGfaUT//eQc4pnJ6gwNqwqGfT7cf4L3WDYTIFF9pKE5WGypWk1d5BhlCQuyj6LNEIeXhfZHVOhauS5XirC2mQrNjWtuKgioDK+Q3pJjwJV/W5SHWEL6Ig2NKRTwIlsqK7wtQ7jpgbcJetL7e95W0CEUOb/XSjMKNSewvC/cXfJQFY7X8RuhJu5B2pVoLCwcCDcfnsqQg2sPOKeg4NeAGHc5s7bDOZF0sggi/23w91Oh9NAMIQhjIKhUglqr33L7pplCAFLbg9cgTYvT4xJZ2TUXhH0/rpCGE/twaIESXjURp0i3pB4mp2IiIF15DBs6glH3iwipFd8mMbUKHnN6RM8oRxXjYchahNqCxTqID9tiOJfssxpIaMebV2/KwyOT9mIS4F7+APwFLLqZsLy5N9vZ2KgTyFuEthhuH8Lukjv5g4V8RsrnfWnxsatxoD9wu7FGAB0m/M/qpRvNY2rP+MQFPBM1E/1pfJTTHbi5cCA+bu0xNduqwm3Nnr7H8d54b5YxcJDYcuO1IMrH8qkWNznvQW2/gQtKjiBu6BzZ/rsB/gXUgunLq6DeHc4TlN9tB/NhXA7YgFFlUM/Zpip/zC7RnN1q7+6FAqW9QH0CygoF0ra/Zomesh6pzAtSo3cwjAV0PpCBErX5WK+u/69L/FuxGCSMLsa9blIKehg80gO6wbJHevqTEgxfJzIlj5hQ5pZowbaErjCWt2e15Q17TU07W+e/1bQAueb5dqhvwoS895ZN77SDcH4VTK4HvJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(40480700001)(36860700001)(2906002)(1076003)(7696005)(41300700001)(6666004)(186003)(16526019)(2616005)(70586007)(8676002)(356005)(336012)(8936002)(5660300002)(40460700003)(82740400003)(70206006)(426003)(81166007)(26005)(86362001)(110136005)(316002)(83380400001)(4326008)(47076005)(6636002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:02:18.2040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ed19c1-dc64-4d55-0306-08da973c0c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
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

switch to common helper to initialize rlc firmware
for gfx9

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 106 +-------------------------
 1 file changed, 3 insertions(+), 103 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 253ffa4c62be..07c24380edf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1091,27 +1091,6 @@ static void gfx_v9_0_free_microcode(struct amdgpu_device *adev)
 	kfree(adev->gfx.rlc.register_list_format);
 }
 
-static void gfx_v9_0_init_rlc_ext_microcode(struct amdgpu_device *adev)
-{
-	const struct rlc_firmware_header_v2_1 *rlc_hdr;
-
-	rlc_hdr = (const struct rlc_firmware_header_v2_1 *)adev->gfx.rlc_fw->data;
-	adev->gfx.rlc_srlc_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_cntl_ucode_ver);
-	adev->gfx.rlc_srlc_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_cntl_feature_ver);
-	adev->gfx.rlc.save_restore_list_cntl_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_cntl_size_bytes);
-	adev->gfx.rlc.save_restore_list_cntl = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_cntl_offset_bytes);
-	adev->gfx.rlc_srlg_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_gpm_ucode_ver);
-	adev->gfx.rlc_srlg_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_gpm_feature_ver);
-	adev->gfx.rlc.save_restore_list_gpm_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_gpm_size_bytes);
-	adev->gfx.rlc.save_restore_list_gpm = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_gpm_offset_bytes);
-	adev->gfx.rlc_srls_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_srm_ucode_ver);
-	adev->gfx.rlc_srls_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_srm_feature_ver);
-	adev->gfx.rlc.save_restore_list_srm_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_srm_size_bytes);
-	adev->gfx.rlc.save_restore_list_srm = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_srm_offset_bytes);
-	adev->gfx.rlc.reg_list_format_direct_reg_list_length =
-			le32_to_cpu(rlc_hdr->reg_list_format_direct_reg_list_length);
-}
-
 static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 {
 	adev->gfx.me_fw_write_wait = false;
@@ -1353,11 +1332,7 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 {
 	char fw_name[30];
 	int err;
-	struct amdgpu_firmware_info *info = NULL;
-	const struct common_firmware_header *header = NULL;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
-	unsigned int *tmp = NULL;
-	unsigned int i = 0;
 	uint16_t version_major;
 	uint16_t version_minor;
 	uint32_t smu_version;
@@ -1386,88 +1361,13 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
+	if (err)
+		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 
 	version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 	version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
-	if (version_major == 2 && version_minor == 1)
-		adev->gfx.rlc.is_rlc_v2_1 = true;
-
-	adev->gfx.rlc_fw_version = le32_to_cpu(rlc_hdr->header.ucode_version);
-	adev->gfx.rlc_feature_version = le32_to_cpu(rlc_hdr->ucode_feature_version);
-	adev->gfx.rlc.save_and_restore_offset =
-			le32_to_cpu(rlc_hdr->save_and_restore_offset);
-	adev->gfx.rlc.clear_state_descriptor_offset =
-			le32_to_cpu(rlc_hdr->clear_state_descriptor_offset);
-	adev->gfx.rlc.avail_scratch_ram_locations =
-			le32_to_cpu(rlc_hdr->avail_scratch_ram_locations);
-	adev->gfx.rlc.reg_restore_list_size =
-			le32_to_cpu(rlc_hdr->reg_restore_list_size);
-	adev->gfx.rlc.reg_list_format_start =
-			le32_to_cpu(rlc_hdr->reg_list_format_start);
-	adev->gfx.rlc.reg_list_format_separate_start =
-			le32_to_cpu(rlc_hdr->reg_list_format_separate_start);
-	adev->gfx.rlc.starting_offsets_start =
-			le32_to_cpu(rlc_hdr->starting_offsets_start);
-	adev->gfx.rlc.reg_list_format_size_bytes =
-			le32_to_cpu(rlc_hdr->reg_list_format_size_bytes);
-	adev->gfx.rlc.reg_list_size_bytes =
-			le32_to_cpu(rlc_hdr->reg_list_size_bytes);
-	adev->gfx.rlc.register_list_format =
-			kmalloc(adev->gfx.rlc.reg_list_format_size_bytes +
-				adev->gfx.rlc.reg_list_size_bytes, GFP_KERNEL);
-	if (!adev->gfx.rlc.register_list_format) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	tmp = (unsigned int *)((uintptr_t)rlc_hdr +
-			le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
-	for (i = 0 ; i < (adev->gfx.rlc.reg_list_format_size_bytes >> 2); i++)
-		adev->gfx.rlc.register_list_format[i] =	le32_to_cpu(tmp[i]);
-
-	adev->gfx.rlc.register_restore = adev->gfx.rlc.register_list_format + i;
-
-	tmp = (unsigned int *)((uintptr_t)rlc_hdr +
-			le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
-	for (i = 0 ; i < (adev->gfx.rlc.reg_list_size_bytes >> 2); i++)
-		adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
-
-	if (adev->gfx.rlc.is_rlc_v2_1)
-		gfx_v9_0_init_rlc_ext_microcode(adev);
-
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
-		info->ucode_id = AMDGPU_UCODE_ID_RLC_G;
-		info->fw = adev->gfx.rlc_fw;
-		header = (const struct common_firmware_header *)info->fw->data;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
-
-		if (adev->gfx.rlc.is_rlc_v2_1 &&
-		    adev->gfx.rlc.save_restore_list_cntl_size_bytes &&
-		    adev->gfx.rlc.save_restore_list_gpm_size_bytes &&
-		    adev->gfx.rlc.save_restore_list_srm_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.save_restore_list_cntl_size_bytes, PAGE_SIZE);
-
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.save_restore_list_gpm_size_bytes, PAGE_SIZE);
-
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.save_restore_list_srm_size_bytes, PAGE_SIZE);
-		}
-	}
-
+	err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
 out:
 	if (err) {
 		dev_err(adev->dev,
-- 
2.17.1

