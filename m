Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D9C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8319E206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="djAOUgEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8319E206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E020D6E9AB;
	Fri, 16 Oct 2020 03:27:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6A36E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG3CkZhPCvZVBnpnfabU8RkiXEOy7+JXyqoNKg1z4JYDiRmG7IyHWABYT1gBULsCr9AV3QdiDvv54pKdhOrZ5NOtUn7ZZYD/G9nvEkEWfeBdv2n/cyg5r7HzQGSBlrdhAt/P8+wf11+AP7KibH+n3VlourfCGYi3NHQwDvCGe8gwpppY3qFgVXQPGlr89ruWZcKkY1mjQ3QhmWBvITJMqlGGlBtaXzQ8r6lNAySwFkdD2S3ZcX24UG9EyHjPW6IZ12pOvpqpdRv/Pmw4lZwlj5MQdOh0FpwEhJOi/DpSRnXpA6PzU1wa/XTCYnIBXHF9Tgh0JmKvpsOBO/oNhdvD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bEp2O4/2OsBy/lhXmt9tyawMTmbqbz0zojx9LBwouA=;
 b=bcncDnz8x1x0nVnYy1UxZVrdrpvKSMdnSUhXkyoCgtwewVRvPjOnLECFZ4pqvqvmD1MthTUFzkReyotTt0DcbmbBWiLOxn6DaZQYmUnFwnhL2Hyw219wH4T8bI3wFj745uc9fMsWmvIkS35csGqN1JbAmTRhzoPDPeMKB4X046pV7N+8kRNl7fQaBSDubheVWgvLbHzWOgqvp45FuVXpNX+/z/APb96iVg5bQ4qs6FBWqUb48lyDDB9BnCPq87KalaUzxo2LkrqQnkc2oeMzRBstSNeiJn7cMV9LpzkLMoARqAsg8qCqPv3790/kQleyVV6ty3JeRNbzpSp2eIiVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bEp2O4/2OsBy/lhXmt9tyawMTmbqbz0zojx9LBwouA=;
 b=djAOUgEv8wyivSHos7zEfJK3qK1aULVqUhXXAXbT9yrYlQ/6pwOqo/XIZL+ST3nnxF9SOGL2RCY1BFX2GvBWxuPchLaUxTX85NBzJbCOjxWuDDOmDLz8K+TtcZq28jGKy8p1kPr1ahD7jm2XoHFDSmG0okmCQZWEaiAcEiGTdEA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:26 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/40] drm/amd/pm: correct the checks for polaris kickers
Date: Fri, 16 Oct 2020 11:26:13 +0800
Message-Id: <20201016032652.507-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b1a08e4-4a62-419d-f852-08d871836752
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB46806C87B9ABEA266BD9E570E4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zPs2QQy1xY2QBA2m2eYp54Lx+AHISGbZfvM3KYfCHqs2hCpwdChAA75dIblBSRlD6+B04VwOTmPaFa5gbsYWk//0zPvPI2Cdd3r8ZbxoyNbnwNc6wUD039uzqIcyuTn4YRfZm6XIvMKHEeHmX2Y6Bb9ZCxgmQN88UFjg2XVztbWrw+C9LqEphgIyEHBUM0jG0JFxE9B/ZwoSG8N9qThrJpldgYar/NEYj2F+6byN8CE24/TjyM5GQAozGASw0RbyqySOSVgxLSbOcESOcO7l0KU2RI4rCIQR7VdXHO0Cy98T7p18VbJWExM2JiYrsE7J2QiZNN9fucgaKoUNXsjhhrC3HpJPU4GzRpiUtKjIXFaDTKgCe+mH41fpf9hyaek
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zUnQ3985Qu/cRF1tFl/GZvG/wW5ShLhbgXweXfV4MccIPg3a5ftJk/mxsh3pBzBthvB0RmS5D1+YeipA9pQWJe1jGccHToUJ189+dyPiXmdy7fp0G6Rdizv2ZjaIR+2YwTZHFPEww2+xGhIb7RdqbK7zJ3GiKka4HCJj0700ziIfwcBI7xds48QpXm41WLUGIALh483g7jqyGdvy1LqYrp8IiBSAWBNcQm75QDKhDt69nldOC3P7Zc7hurM1tmvYyZzHSLSWWm0tefa3h5oNsLadrVurVnghFiJ9hyepTiQ2pEiLlZRvNZUjTA0C8ZLHIsLOoO7+7mgfV9HXl6QPDwClm+N9N5kgDycYY4r4gy4Yxr3o29ElCoIB2ngw8HR87N6wEDnCvmYD4kTyXfu7ceU+mwYS0zghjgYNl+N5IUhq/0qIbmgm9qlVlHzdzsbKD2BFIIHRvJ7Z2shTEvEkJlJ4TPH/QbKDA2giJLeW5fpSdNgzBe8AwjbMPz4wzZpmN3+uYiCaExktSOY6SGOXXY4Bzv5BdKd1CyKvWKSPT95Vr30GzmMXsVx47m2enA0/3YNYHVzJOWfH6unM/0ICiUpFaYj9ciqbRICKk9OVITvaIf48XSI8OnN00d9vPsTAdXmxWZLKeFBoZZ5uK+lYQQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1a08e4-4a62-419d-f852-08d871836752
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:26.4838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3zldc7uottNEM8JJWUn8InR+lTlMNX4U7z4vLHV7azuc5O/vqHRq0lEt8VRABmu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By defining new Macros.

Change-Id: I4f7233ea27e59b61c29c52798a179abbf224fe12
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 39 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 34 ++++-----------------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 24 +++------------
 3 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f8f3e375c93e..ba65d4f2ab67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -728,6 +728,45 @@ struct amd_powerplay {
 	const struct amd_pm_funcs *pp_funcs;
 };
 
+/* polaris10 kickers */
+#define ASICID_IS_P20(did, rid)		(((did == 0x67DF) && \
+					 ((rid == 0xE3) || \
+					  (rid == 0xE4) || \
+					  (rid == 0xE5) || \
+					  (rid == 0xE7) || \
+					  (rid == 0xEF))) || \
+					 ((did == 0x6FDF) && \
+					 ((rid == 0xE7) || \
+					  (rid == 0xEF) || \
+					  (rid == 0xFF))))
+
+#define ASICID_IS_P30(did, rid)		((did == 0x67DF) && \
+					((rid == 0xE1) || \
+					 (rid == 0xF7)))
+
+/* polaris11 kickers */
+#define ASICID_IS_P21(did, rid)		(((did == 0x67EF) && \
+					 ((rid == 0xE0) || \
+					  (rid == 0xE5))) || \
+					 ((did == 0x67FF) && \
+					 ((rid == 0xCF) || \
+					  (rid == 0xEF) || \
+					  (rid == 0xFF))))
+
+#define ASICID_IS_P31(did, rid)		((did == 0x67EF) && \
+					((rid == 0xE2)))
+
+/* polaris12 kickers */
+#define ASICID_IS_P23(did, rid)		(((did == 0x6987) && \
+					 ((rid == 0xC0) || \
+					  (rid == 0xC1) || \
+					  (rid == 0xC3) || \
+					  (rid == 0xC7))) || \
+					 ((did == 0x6981) && \
+					 ((rid == 0x00) || \
+					  (rid == 0x01) || \
+					  (rid == 0x10))))
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_device {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 78ac6dbe70d8..f1a050379190 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -352,17 +352,10 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				break;
 			case CHIP_POLARIS11:
 				if (type == CGS_UCODE_ID_SMU) {
-					if (((adev->pdev->device == 0x67ef) &&
-					     ((adev->pdev->revision == 0xe0) ||
-					      (adev->pdev->revision == 0xe5))) ||
-					    ((adev->pdev->device == 0x67ff) &&
-					     ((adev->pdev->revision == 0xcf) ||
-					      (adev->pdev->revision == 0xef) ||
-					      (adev->pdev->revision == 0xff)))) {
+					if (ASICID_IS_P21(adev->pdev->device, adev->pdev->revision)) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris11_k_smc.bin");
-					} else if ((adev->pdev->device == 0x67ef) &&
-						   (adev->pdev->revision == 0xe2)) {
+					} else if (ASICID_IS_P31(adev->pdev->device, adev->pdev->revision)) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris11_k2_smc.bin");
 					} else {
@@ -374,21 +367,10 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				break;
 			case CHIP_POLARIS10:
 				if (type == CGS_UCODE_ID_SMU) {
-					if (((adev->pdev->device == 0x67df) &&
-					     ((adev->pdev->revision == 0xe0) ||
-					      (adev->pdev->revision == 0xe3) ||
-					      (adev->pdev->revision == 0xe4) ||
-					      (adev->pdev->revision == 0xe5) ||
-					      (adev->pdev->revision == 0xe7) ||
-					      (adev->pdev->revision == 0xef))) ||
-					    ((adev->pdev->device == 0x6fdf) &&
-					     ((adev->pdev->revision == 0xef) ||
-					      (adev->pdev->revision == 0xff)))) {
+					if (ASICID_IS_P20(adev->pdev->device, adev->pdev->revision)) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris10_k_smc.bin");
-					} else if ((adev->pdev->device == 0x67df) &&
-						   ((adev->pdev->revision == 0xe1) ||
-						    (adev->pdev->revision == 0xf7))) {
+					} else if (ASICID_IS_P30(adev->pdev->device, adev->pdev->revision)) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris10_k2_smc.bin");
 					} else {
@@ -399,13 +381,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				}
 				break;
 			case CHIP_POLARIS12:
-				if (((adev->pdev->device == 0x6987) &&
-				     ((adev->pdev->revision == 0xc0) ||
-				      (adev->pdev->revision == 0xc3))) ||
-				    ((adev->pdev->device == 0x6981) &&
-				     ((adev->pdev->revision == 0x00) ||
-				      (adev->pdev->revision == 0x01) ||
-				      (adev->pdev->revision == 0x10)))) {
+				if (ASICID_IS_P23(adev->pdev->device, adev->pdev->revision)) {
 					info->is_kicker = true;
 					strcpy(fw_name, "amdgpu/polaris12_k_smc.bin");
 				} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9ab65ca7df77..0f32a8002c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -230,36 +230,20 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "tonga";
 		break;
 	case CHIP_POLARIS11:
-		if (((adev->pdev->device == 0x67ef) &&
-		     ((adev->pdev->revision == 0xe0) ||
-		      (adev->pdev->revision == 0xe5))) ||
-		    ((adev->pdev->device == 0x67ff) &&
-		     ((adev->pdev->revision == 0xcf) ||
-		      (adev->pdev->revision == 0xef) ||
-		      (adev->pdev->revision == 0xff))))
-			chip_name = "polaris11_k";
-		else if ((adev->pdev->device == 0x67ef) &&
-			 (adev->pdev->revision == 0xe2))
+		if (ASICID_IS_P21(adev->pdev->device, adev->pdev->revision) ||
+		    ASICID_IS_P31(adev->pdev->device, adev->pdev->revision))
 			chip_name = "polaris11_k";
 		else
 			chip_name = "polaris11";
 		break;
 	case CHIP_POLARIS10:
-		if ((adev->pdev->device == 0x67df) &&
-		    ((adev->pdev->revision == 0xe1) ||
-		     (adev->pdev->revision == 0xf7)))
+		if (ASICID_IS_P30(adev->pdev->device, adev->pdev->revision))
 			chip_name = "polaris10_k";
 		else
 			chip_name = "polaris10";
 		break;
 	case CHIP_POLARIS12:
-		if (((adev->pdev->device == 0x6987) &&
-		     ((adev->pdev->revision == 0xc0) ||
-		      (adev->pdev->revision == 0xc3))) ||
-		    ((adev->pdev->device == 0x6981) &&
-		     ((adev->pdev->revision == 0x00) ||
-		      (adev->pdev->revision == 0x01) ||
-		      (adev->pdev->revision == 0x10))))
+		if (ASICID_IS_P23(adev->pdev->device, adev->pdev->revision))
 			chip_name = "polaris12_k";
 		else
 			chip_name = "polaris12";
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
