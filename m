Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E907C38A30
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7482E21744
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZoebL6BS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7482E21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389F76E4F4;
	Mon, 20 Apr 2020 10:17:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7DA6E4F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYmLe5SUCUDIBRSgRdhonwuxuMIdmzsSH20uiaWnK6ql8c04jEWbsPN07kE2X8nIg4zQENdMxfhBoCe7JC1LOpG4GH+Zt+qw4pVzd6L3ZGTn6SLqD5GIUyprXZSS4fuUqGdWn+ejo/u06lYd5YWyWlcD/GUBd8hKl6DsckizPGSpS5tPhZ3cN44TByhUGxKRqVUE19pvll41QxREWyrtLij/aFS1qoBqGlHyVvtIDtkxs1Ddsj7z+Gv2tgGN2bLJqKSbbQVeYvj8STBNME7v5vowOQuyegSHw1v7H/RoiAQSiEzsoMPFyNpoQCGRs+l/S4d5z40ysLGdkGAsqym7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/oRk2CxC0dISw4ZTxV8ViXBW776cKZg9wh6LV7KTQs=;
 b=kvL3FfrWeWNHasiMJ6kep3QfqTlxaN+nkKOG8gJIC6eD+4HhNyWlaeVI7d+13++hJfnRoQ36YfP98yEtUZsKIJD6/wcHNMbOtxlsqOkpU7SOBzxtubMg93RaO6wJdYpQ7nPlsVsfzvPgkIaSbDahdfTkEMoFlkDm0P+n4rCrGvcuh/W7appFdP+fSiW+qP5MhQgroKJbW7IIh5BT8Wui8pEntD6my8sFrv3jQ1a6k4VebbstwUHhHbPh7ZR/QGc3ZgFBR6UOUPO75u0fFTvHnlNLhHn1Sbss6LdDQcfkSJg4nt68oBsK7Gaoapk7bYwN/tn+1NrIkzTkHaX6/xz8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/oRk2CxC0dISw4ZTxV8ViXBW776cKZg9wh6LV7KTQs=;
 b=ZoebL6BSAsa8MP4WS6uJxdiTFmekyiywR2E5HlE/t6cF7eP2EEulmP/W1K1+/PX42hNF+cRO+n5hSWh+4V2kfvjBJMQFQMF28v+pmUkDUmmDRKCDe+tHtf5smvtSv58reyZc9HrhX33M9v0Bays38dbm55wjcrgr9A/92uBZ3Ts=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:17:35 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:17:35 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: switch to helper function to init sos ucode
Date: Mon, 20 Apr 2020 18:16:43 +0800
Message-Id: <1587377804-3836-8-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:17:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a95aca5a-bc6f-4961-8a80-08d7e5140b8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32257C111DC0D6DCC6D77EF8FCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(2616005)(16526019)(956004)(316002)(186003)(6486002)(6636002)(2906002)(86362001)(478600001)(6666004)(8676002)(36756003)(4326008)(5660300002)(66556008)(66946007)(66476007)(7696005)(52116002)(110136005)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggW5HHkPeiFGEajDmOnt8dggXOBL35GxfN2GgjURalWt+noAWrLJxzDEAfmhH4CmcwWAsxo2mgUedWYQykAkcSLb1jBKJZPOWPAg+eOsJX8HNBhJV48sonwm4Poe8z5iLFsROZsCuYvUIQEd2bft4OSHurvCRqHQnfsqNhXPlKdn0Y2cIT3VvvxskMsdfboPP0BkwhKHe9L099XZr8nF/2byAjb4jwFH1Sd53gcUUrqCzEH0JTjr6QXIF+jg0ubPlVgMder83ksVDIDXIpBeTjzi2gwQj6tOqVzYsax+Kd/TjNwt9SqzodPCrAOyuOEG+RvVCcdaAy8jfRsPaD3X/49A93JSNXPJ+iyy369ohC1h51fu978ildpLlzsjrBEY8XgrgfQ/4N3Omrl+1ulqb+/YP4tQE7ZJ+ySsqgYG6c/zLSAUVY7vsv+M+tHUTSQL
X-MS-Exchange-AntiSpam-MessageData: l1qxGLGHvrhYqsDOh+QvgkXeAUh0K8dNPJqLdTDOe0vf8AZQciAC6PJCFx0Bursp90RmMjsmbRQaGUswIUvGPP3r71EY+vh6tiuUIqVlvCRkl98l6Q7W+gizc2k/2foUvmnUWSr2y87oIaAjFs1Egw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95aca5a-bc6f-4961-8a80-08d7e5140b8e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:17:35.4900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftm+xLm9vI/HN+oCI9znoc0E0Jw6MWuFm9jxQ3bqjJZskxizkSXrHXQHwqKEWx4tXw09TmT+tUHEOCI8KtpkkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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

call common helper function to init sos ucode, instead
of duplicate codes per ip version

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 56 ++--------------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c  | 34 ++-------------------
 2 files changed, 6 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 6d50da0..d2d2363 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -75,9 +75,6 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	const char *chip_name;
 	char fw_name[30];
 	int err = 0;
-	const struct psp_firmware_header_v1_0 *sos_hdr;
-	const struct psp_firmware_header_v1_1 *sos_hdr_v1_1;
-	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
 	const struct ta_firmware_header_v1_0 *ta_hdr;
 
 	DRM_DEBUG("\n");
@@ -102,54 +99,13 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
-	err = request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
+	err = psp_init_sos_microcode(psp, chip_name);
 	if (err)
-		goto out;
-
-	err = amdgpu_ucode_validate(adev->psp.sos_fw);
-	if (err)
-		goto out;
-
-	sos_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
-	amdgpu_ucode_print_psp_hdr(&sos_hdr->header);
-
-	switch (sos_hdr->header.header_version_major) {
-	case 1:
-		adev->psp.sos_fw_version = le32_to_cpu(sos_hdr->header.ucode_version);
-		adev->psp.sos_feature_version = le32_to_cpu(sos_hdr->ucode_feature_version);
-		adev->psp.sos_bin_size = le32_to_cpu(sos_hdr->sos_size_bytes);
-		adev->psp.sys_bin_size = le32_to_cpu(sos_hdr->sos_offset_bytes);
-		adev->psp.sys_start_addr = (uint8_t *)sos_hdr +
-				le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
-		adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
-				le32_to_cpu(sos_hdr->sos_offset_bytes);
-		if (sos_hdr->header.header_version_minor == 1) {
-			sos_hdr_v1_1 = (const struct psp_firmware_header_v1_1 *)adev->psp.sos_fw->data;
-			adev->psp.toc_bin_size = le32_to_cpu(sos_hdr_v1_1->toc_size_bytes);
-			adev->psp.toc_start_addr = (uint8_t *)adev->psp.sys_start_addr +
-					le32_to_cpu(sos_hdr_v1_1->toc_offset_bytes);
-			adev->psp.kdb_bin_size = le32_to_cpu(sos_hdr_v1_1->kdb_size_bytes);
-			adev->psp.kdb_start_addr = (uint8_t *)adev->psp.sys_start_addr +
-					le32_to_cpu(sos_hdr_v1_1->kdb_offset_bytes);
-		}
-		if (sos_hdr->header.header_version_minor == 2) {
-			sos_hdr_v1_2 = (const struct psp_firmware_header_v1_2 *)adev->psp.sos_fw->data;
-			adev->psp.kdb_bin_size = le32_to_cpu(sos_hdr_v1_2->kdb_size_bytes);
-			adev->psp.kdb_start_addr = (uint8_t *)adev->psp.sys_start_addr +
-						    le32_to_cpu(sos_hdr_v1_2->kdb_offset_bytes);
-		}
-		break;
-	default:
-		dev_err(adev->dev,
-			"Unsupported psp sos firmware\n");
-		err = -EINVAL;
-		goto out;
-	}
+		return err;
 
 	err = psp_init_asd_microcode(psp, chip_name);
 	if (err)
-		goto out;
+		return err;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
@@ -216,12 +172,6 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 out2:
 	release_firmware(adev->psp.ta_fw);
 	adev->psp.ta_fw = NULL;
-out:
-	dev_err(adev->dev,
-		"psp v11.0: Failed to load firmware \"%s\"\n", fw_name);
-	release_firmware(adev->psp.sos_fw);
-	adev->psp.sos_fw = NULL;
-
 	return err;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 14d17b1..7e3a2f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -59,9 +59,7 @@ static int psp_v3_1_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0;
-	const struct psp_firmware_header_v1_0 *hdr;
 
 	DRM_DEBUG("\n");
 
@@ -75,41 +73,15 @@ static int psp_v3_1_init_microcode(struct psp_context *psp)
 	default: BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
-	err = request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
+	err = psp_init_sos_microcode(psp, chip_name);
 	if (err)
-		goto out;
-
-	err = amdgpu_ucode_validate(adev->psp.sos_fw);
-	if (err)
-		goto out;
-
-	hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
-	adev->psp.sos_fw_version = le32_to_cpu(hdr->header.ucode_version);
-	adev->psp.sos_feature_version = le32_to_cpu(hdr->ucode_feature_version);
-	adev->psp.sos_bin_size = le32_to_cpu(hdr->sos_size_bytes);
-	adev->psp.sys_bin_size = le32_to_cpu(hdr->header.ucode_size_bytes) -
-					le32_to_cpu(hdr->sos_size_bytes);
-	adev->psp.sys_start_addr = (uint8_t *)hdr +
-				le32_to_cpu(hdr->header.ucode_array_offset_bytes);
-	adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
-				le32_to_cpu(hdr->sos_offset_bytes);
+		return err;
 
 	err = psp_init_asd_microcode(psp, chip_name);
 	if (err)
-		goto out;
+		return err;
 
 	return 0;
-out:
-	if (err) {
-		dev_err(adev->dev,
-			"psp v3.1: Failed to load firmware \"%s\"\n",
-			fw_name);
-		release_firmware(adev->psp.sos_fw);
-		adev->psp.sos_fw = NULL;
-	}
-
-	return err;
 }
 
 static int psp_v3_1_bootloader_load_sysdrv(struct psp_context *psp)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
