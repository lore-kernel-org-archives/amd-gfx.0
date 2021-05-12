Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2876C43618
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2C5613E9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2C5613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709B36EC88;
	Wed, 12 May 2021 17:32:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDCB6EC81
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E49UC7sU+WsNFQW/I4Ug13rMFGYtmSJhJgIi8GC3EELEeiWSe7gB6ST9cTlVKVZiTZVet86PXbhDcfED6H2o8E1RNOLtkMNuKSb2DxzD9lr+3A+fRjgny8xGYa1Btv65r0dt3OEKzP4PRtXfI5pVJU2q8jw6eyC9GeTdLdQxpDpV5eJUuYkaSFGCfl69SlaUIM8fgfesNwC7NG5G91EsK4goc87uqSQkhCXkKQtKhFeP+5J7ispgxT59ZXl69iLjt9zX82KaQGHWQLnPHz1McetOHYaoYcks0y3Xs0sCrwp81ymw8hKaezwY/zzVG5NgS1cl6tGQuS+SrfTZoT7hWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCtHwzb1tv9GasZcZoNqHjK35Fvj5Ofld+0/CUSGlgA=;
 b=Qt2/T+YMH18t4n/7JlvbcztcLv1l+9nsYnN0TDUG641I4GGbC8fHie7bySYu0zVfdD3U9KOB1Iw6vctEkiLWc5Z8nIsKZRdhf/rIc9jdUYp5qwFX5SocQrU7Kt9IYwTfALKjCGAu+KGrfbM80ac90fyUdWzYzkxUBRTB87xTAb1DY0HEIcqsnDoADWS8+8fj6lFSITS24XNrqC7QIc8Coqxn2ibFEjzY9AKbBmvqu7ZSc7xPGI2WUNRVCmtBhMWrKHPybyjluUBtQ7DvNZIHs1J0TVn91oXAs9z0YaK7DOuM85ptduvOIETbcY26bfU0mek99oic6X0e5La9smoGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCtHwzb1tv9GasZcZoNqHjK35Fvj5Ofld+0/CUSGlgA=;
 b=qSQM/eKAJSG+Umr4q2nWkespOnfIAaozyys7vqBVMQNi+5HaOKdX2QWGite9YCafffLoYfDRx9496Txm0LXN2rPP/55AfKomDXMoEN23fBVfirk+vLd9AxDDiErppJ7ctv/Bh5VK3kEJXEy/8hHNTpvH9zhzk0GVYDBVhMEBXY0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Wed, 12 May
 2021 17:32:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:11 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 44/49] drm/amd/display: Add DM support for Beige Goby
Date: Wed, 12 May 2021 13:30:48 -0400
Message-Id: <20210512173053.2347842-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bedaf60-f902-4ad8-56b1-08d9156bcdc3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4567BA02E3AC0E7A16BE6863F7529@MN2PR12MB4567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BA/lW2hzNHN5CXzWdcG/wHffmmULs7GxYeUxaeKdIxm/oZ1QfkosWNb9BhsYI98M+LKNmA8bSz2F3G+hUQkUTfusa4Ko/2Any6iXQVDFK28lRZgEvVKxjMxbDCBUW6BwE/1c3xgjqXEAxEfl2hWAZMnRAOfC2qnbIBqJAvWuNgKWqbZS47DpoJXs/dJvPZISReDUCCPcSYzhwKE86zeICi8riq6nIBq9fNm5jdv/C4/FToMl6B1GdXlriLIOrrGrKm/+u4MuUsTLcWBzc6BzNSlzvaF926AuJ06NvWozeZLNl+X7VMhi5eGAzv6PVwnVjGHizZfjhsj9DMGMXAl0eRou94VpEB5/Lt9jJfh7ZB6uHTlmSKshqgwsuYvBZY28PDou2d/IYHxjKsEbi8aWnyL/UxNih7D2ZVqdUpDnxXcpKy1wr7Iy/LrV1gSb+ZaSxg0FxnOvIpV+3q+YEjwwaAkZauXVS3T6rnxd5rItcg9CAfPrVP+Engrg8mw0QlUpRvPHzySL5vPnxye0l+eoKg3esfzpGtAfkO050Mk+Z9jIsxN8gTRSIhlWwUE/BK/kglfu6UCWjn6QB9lwzgIocMkGSNUHVBBzIJqdvjK6tD1FrvppVHcorFMil2TVg3b06/IigWmsGWMfGFlWnEzS0R7br1w3UjNhntrU2Z5/NMkfV4TjiR2cD1bvHUlzWk7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(4326008)(66946007)(16526019)(54906003)(36756003)(5660300002)(26005)(6486002)(186003)(38350700002)(66556008)(66476007)(38100700002)(86362001)(6916009)(478600001)(956004)(2616005)(52116002)(6506007)(1076003)(6512007)(2906002)(8936002)(8676002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PAgLtt9BTRG9nPtM1rd6VC13/i/AdlRSpBhzpG9iYuz3i0o5wjT655gpSqvE?=
 =?us-ascii?Q?gMA7db5OPiseaQRc3mnVGJOqe6PMysqM+zWZejkaByYpmvDhtWU5NJYSTsMN?=
 =?us-ascii?Q?gFtMeJUoMUbBY/TTft1XBL/3Ixsw4nXySQALuON2umFeXtynliu7ZYgvVMGI?=
 =?us-ascii?Q?/xFUXz8a0EvWI5kM9SGD1mjWNyoz9OPOpcfhD13haJOiDfbMWWEWZYAryA0a?=
 =?us-ascii?Q?T93+skomnVHBG1d+QsDlSyTf5Ty8zZD/67VJckO7xsDqLN/w8y9akxFdJ0JV?=
 =?us-ascii?Q?Oa+wI3WshkQKOdcWkRRsiNfv0nD+q/RbQavMsAfPkM9oCrJMOrWIKgBNafmx?=
 =?us-ascii?Q?iChca8hkryK4Ut0C8/FOkytO9z30bauqTS49jeV9EuayGDtmSb+g1jsntGF1?=
 =?us-ascii?Q?RjW1YxdcjLyECWFwwNAmVv19MhbPfvXsE7WNO44UtQHMAEXv3uvoRa4vvWJN?=
 =?us-ascii?Q?My0bsbK1wrpHC9rmxAw2WRxrZKKajMdEfl23X8stxUAos4GAVFBw6RIUTZO1?=
 =?us-ascii?Q?z99tIOU013q1Lq9bjw2thHKf5AGgmYLI2Qpn99viMtThojLCY7LKIg2fGwkx?=
 =?us-ascii?Q?wjxlUmf7ZQ5HVrgKgDWbmNiHVELEAiDg7IMe7lmXzhM/M5ul+EtGGZ03tEIG?=
 =?us-ascii?Q?PNPqXJms5UEfg10yd8lN2UqaSTwmfRMuEAK/33UGSRP02p21k57XBPCPkJ4t?=
 =?us-ascii?Q?kVJIjo4q08vKc5h5lhIxopHx8ey6fgZjpELuM3B2QKySHZZiQuvj/7JrIHWm?=
 =?us-ascii?Q?dynhYZsdT+qbJVil6smV13NLvXPMVyWudQ61g4bXKv501lkEzzuZHEE+Fgbq?=
 =?us-ascii?Q?KhcHoKQTRX3IvrH0Q/36gDM52t0O1Cdbl8tiQkiovaT6TWOdajWk/JpMWk/b?=
 =?us-ascii?Q?AefyTikVjVe6VPYqeWS2CCAUcX7UzlafdaLwPb3WE2j6DsU0kFGicfzkIPUz?=
 =?us-ascii?Q?iRtbwUeCtVXLKN/Zmdvk+/IDqi+ANywde3uSqAEO1p+0kJCmxe6KeTCRnGl0?=
 =?us-ascii?Q?dUyWqPkOJdrrktoy3/TOM+odFWv5pA440u97TY1YpcC6EYcn6+QNoJcfOmA5?=
 =?us-ascii?Q?vXWsOIYd7l0Plr8wttugFDa6Z9FqFUJ5W2AMe60XPgfl6PezZc7tzx1sFNTQ?=
 =?us-ascii?Q?qqZ2wpAqPcaq7m4tqkbrA3sEZzqGoRpIOZ3TzUAXDzxC3/GHJ/kPPJ5pbRY5?=
 =?us-ascii?Q?lltgOiBc2tHq7GzaMTnSU0DF4d6rgyvWDSoG29T0kc1qvMN286t4qEV34ob+?=
 =?us-ascii?Q?LYvy1tcbjV8K0xp51xipD5f/Pu3TC9T2EIjr3lqF90KSePqeHzsp9kpFWzkf?=
 =?us-ascii?Q?G/U4OWWibOQoUHLovSmCNCGu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bedaf60-f902-4ad8-56b1-08d9156bcdc3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:40.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8TvFLbHYMSB1SVvF5yo3tCZWNEkKf764AlvwpaIwLxKzuEkQE7Mezi97amSPlC4jl+mP9PqeBAbYmaXYm7VNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]

Adds the firmware definition and missing cases statement
hooks for Beige Goby support in AMDGPU DM.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e1dc10ae277..387f0c46c4a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -104,6 +104,8 @@ MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
 MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
 #define FIRMWARE_DIMGREY_CAVEFISH_DMUB "amdgpu/dimgrey_cavefish_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH_DMUB);
+#define FIRMWARE_BEIGE_GOBY_DMUB "amdgpu/beige_goby_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY_DMUB);
 
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
@@ -1358,6 +1360,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
 		return 0;
 	case CHIP_NAVI12:
@@ -1473,6 +1476,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		dmub_asic = DMUB_ASIC_DCN302;
 		fw_name_dmub = FIRMWARE_DIMGREY_CAVEFISH_DMUB;
 		break;
+	case CHIP_BEIGE_GOBY:
+		dmub_asic = DMUB_ASIC_DCN303;
+		fw_name_dmub = FIRMWARE_BEIGE_GOBY_DMUB;
+		break;
 
 	default:
 		/* ASIC doesn't support DMUB. */
@@ -3735,6 +3742,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
 		if (dcn10_register_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -3987,6 +3995,11 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_hpd = 5;
 		adev->mode_info.num_dig = 5;
 		break;
+	case CHIP_BEIGE_GOBY:
+		adev->mode_info.num_crtc = 2;
+		adev->mode_info.num_hpd = 2;
+		adev->mode_info.num_dig = 2;
+		break;
 #endif
 	default:
 		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
@@ -4212,6 +4225,7 @@ fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
 	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
 	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
 	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
+	    adev->asic_type == CHIP_BEIGE_GOBY ||
 	    adev->asic_type == CHIP_VANGOGH)
 		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
 }
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
