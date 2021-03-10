Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD25EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD6E64FC6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD6E64FC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151BF6EA4A;
	Wed, 10 Mar 2021 17:11:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26DB6EA4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 17:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYXK61u/onrn5RllJ/fhUHA4+iz3mso9fdJ8L52ywklY0YqX90P+95Ukki7ZoZhUvln3Wi72HyT5z6bYHeOAFXrTwe27/6ARq3/VzDNHKA/uAp108CF7YK0MVCK4HUPuEwUrzUx4dcyjDwhN3DDBYrZgKdj2jd4x5UJlffkLhDnuvpOuRmeCrhvfKmaIy6KiTtnGOMezrEIWmbsGZayuT6DX4msISbyj3hDGTHmEYD8uqxUNySpnINwmofovo+OR9WzEXrA9OzOURRVv2a5O0DCnv14e2nKfIvR29zF+Qr8k1zKtl4nc6taHslV/BReGxNo55pyh06ZYmHqfGx3ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsxFngdyy7b55ES50NgoBaIdZ90gYvJlmtqUfMvM/Sc=;
 b=SCRoYvdBHud427OPb4/IXyV/fsWS5iG/YshZsKhg8KGEhIf2ve1JdhQ7z2F4xsTwrJLzBg/o6Z4IRjmTB23YpxH3lDHJ0DC6jd5rmyP+qIYy0IR2WP0bcdywUPn6z16W+jfEALCMtUOinndRcKuubbrQyivERbTKzgfK4PCZvEQwXMY7LUm7DEVuSE6EZOFYsxkf3UiE7Q8M0DSJDfStDCNEbgNnBurl5eUGPoGFL4djeXmZd69VYtmyJTaLWLwYkk6z6Vrj1FanVtQ1L6cNkRkfDddi0Cnfz9ooeCJNBuOCTEqDzofvZTqEa1lXvmfnx+cBRrEecNNSsyvyR2P0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsxFngdyy7b55ES50NgoBaIdZ90gYvJlmtqUfMvM/Sc=;
 b=SfysZppmH5lDzzQRgZB1GviXnuBcl+xuW972ucQOndUUS2hPOZBmDwRPULelvrXrrrdok6ViwgF02m/bS0Z3RX8yn7imqxXqwmYne24JdTrlbMsqyjbrxC/24/42dSTchWV9Dx/26XXtodKiogp0ZuQ1qH5BraYciuRDYffL4F8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 17:11:52 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 17:11:52 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/powerplay/smu10: add support for gpu busy
 query (v2)
Date: Wed, 10 Mar 2021 12:11:36 -0500
Message-Id: <20210310171137.1056593-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0286.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::21) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0286.namprd13.prod.outlook.com (2603:10b6:208:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Wed, 10 Mar 2021 17:11:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55a472ee-43e8-4d99-28c2-08d8e3e79967
X-MS-TrafficTypeDiagnostic: MN2PR12MB4581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4581D1876A6202A8BC91C661F7919@MN2PR12MB4581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jI4xsq887i+vvacDh0WhI1afRQJWQDed5WUHxxGRC6DJ4P66tV9aZeYoh49vG3gksdgNJXLOodh6U3cBUACMPLoLtRq0gTe8nHGPTHk2KtglbrjWU4dMB4i/TM9MUWOe6DxuGcijFJJB9n/Z6PnErAT37KpTkerNWgruMv1VuIPsIWfbNs+FWKr9C8Mn4zDppouraCzlZa8R1fwsgvbFXxYckSmJes9y05YhTeUrsDTUuYHzzNciE44WZM4l0KZKu+GIOQ5tCkFKP7Ds5l+cnvTXsnIN8ey1aaC/4GWfiJGPUDLpXOfdV/uyIwItYX/T7qX+F4jfNzU1zo47qeqksDmmcAMZVRLbgvvVSCrwUg9MzPYxkEwZUfZK1iPkzugyCqugi1T+1MnStMnpskmHWRDLPA4bbg+5JovQ4kgLQ97uC2fV0rpvOjErn9p9g0jY3+nA1+jB8wUyuXmGdDcRJkIkCfft47lq1IrXoQLoFMDQbN10cmLlw6V2gJ+3vdGV9WrxFF2u/83rB1GottQSaiJ+/1PfDAtR+SynfwsMWl6Fvty4DpyJPfNXhpow8VWwVqEHGYqor3T/mOp4aMRN3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(86362001)(1076003)(2906002)(52116002)(478600001)(6512007)(8676002)(6916009)(8936002)(316002)(5660300002)(83380400001)(36756003)(6506007)(2616005)(956004)(4326008)(26005)(6666004)(6486002)(69590400012)(66556008)(66946007)(66476007)(186003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XDkk2N4s7hwqs2K/YjfDPFZz8ObU6MkzBJ9Q7BayX7qyZ8hOsbHoTJBOxMAF?=
 =?us-ascii?Q?kGwbJRD4pJXiJyrOZSJ64zaeTnHI/xzjA9Xm6+iHtt64PtnOv5Pn1thtyCvF?=
 =?us-ascii?Q?7pGQSpxuabYI3PdhJFZtOEu6fFZUGyRgDYntQGNtv4Xt7r2Umaf91WlVLkZ8?=
 =?us-ascii?Q?pmKGFYk5uTx27H4vjexJgkQbZoSr8Hbd8k/YumpS6zB94qYx60KauWHOnJRH?=
 =?us-ascii?Q?mOZk7P5jmim1sgzTmnrt42azUrRasrcbNQr/quT8tfPuVoLozuI1GDlmR7Oe?=
 =?us-ascii?Q?4Oofay9L5cEvMnNhxnKK0bFCbGX8HnrefnjvPA7CuDT0gucryFqH7CHNURKo?=
 =?us-ascii?Q?bvFMMcu5ZO7dkw2puqR8XQ2bHehR0/taNQa5xaaBQiFwV5lmByufw3l79DGT?=
 =?us-ascii?Q?xIqda3P33cKq3s+Imm72WTfIvPluLn2BSfrIPMvNR5AZW/4ubB/9RCLQTrpC?=
 =?us-ascii?Q?WxrlE1dGrvGSr+LxhiRPE/NJUHs8BkXFUtMxVhgccJ9NTez74W6iRxUjspSC?=
 =?us-ascii?Q?40ADm293QRRhpzPTufdRpwg02q0F++kHM+KvD0HT0mdFV+bvcR+ijAI7wPOO?=
 =?us-ascii?Q?iBV5XWoaL4/RJJr+WUVZPw++HAXq79QaXjysnoOgGGqPRUwPubzjV9ZbCEEp?=
 =?us-ascii?Q?NEiN+BcuKY1/qxjZwuvgyb26t0hsS4xraSKFzWVjtWkiN7jXcR+r053Firpk?=
 =?us-ascii?Q?YqKltQBQIKQx+nU9nkUaHEJlSgkG3Z7U0/qzoncXak0nYfcrtVHCoLXe8Kpw?=
 =?us-ascii?Q?oiCPjF2KTLdtp4fq7qJ9OwLNCRuf+tPmNrhEqmmoYD+7khXvvH6iIzSGpaV1?=
 =?us-ascii?Q?3uKdkkGP9hhrYiK68tqE7Qlet+xd6GdkozsTEskTyDaSm/Rzsa7sY/bFPmfr?=
 =?us-ascii?Q?p2VWxz6u3J1zVZ+NVgZIy4zuzS5pYWIA1Z2AtCZmdrmfCDH7Dg4Usa12RalU?=
 =?us-ascii?Q?HLmSM8J1PTfjz0zNkAja/FXOhKV+eNRLbGTKOjt6q7uiVdhnfHswIAvMTQFN?=
 =?us-ascii?Q?k4amwn2I5VkGAgxarMGL0dB39w4IoaVJ4XKKb91dt7A69OfNI1eB3bKvMLMd?=
 =?us-ascii?Q?PN/983u3+2KZvjVVlleD5dCu8xTge81OY2iOp1YHtK30piKgtA6RKoTNaeix?=
 =?us-ascii?Q?lpJQL90Ra+52Oz66HX9aw6qRgU8e21eFv9lCmj9R0xvxAcybIYMpF/92F/i0?=
 =?us-ascii?Q?ppaV2Yj8SG7unkmnkpoBqXBq8SNogxWdpDygYV3ag8W8rrl7TJqDd/nh5eo7?=
 =?us-ascii?Q?6EI3+KDGKR6TQsy4pypfkOVSHs09flrewvPY0fNAR3FTaY7JmkbVlyiwSaqb?=
 =?us-ascii?Q?fwQ9MFmQrP4J24RChqd4sWY2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a472ee-43e8-4d99-28c2-08d8e3e79967
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 17:11:52.6567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/lzRFBZVbQd6PPSxiAo9gETO31+7HhAVZld1DHptYrlzccVyXQnnQmGpSU+TpN3QfiQeUCsCOEraiGkdVqKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Was added in newer versions of the firmware.  Add support
for it.

v2: return an error in SMU error, drop needless break.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h         |  1 +
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 28 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
index 4c7e08ba5fa4..171f12b82716 100644
--- a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
@@ -84,6 +84,7 @@
 #define PPSMC_MSG_PowerGateMmHub                0x35
 #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
 #define PPSMC_MSG_GpuChangeState                0x37
+#define PPSMC_MSG_GetGfxBusy                    0x3D
 #define PPSMC_Message_Count                     0x42
 
 typedef uint16_t PPSMC_Result;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index c932b632ddd4..f5d59fa3a030 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1261,9 +1261,21 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			  void *value, int *size)
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
-	uint32_t sclk, mclk;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t sclk, mclk, activity_percent;
+	bool has_gfx_busy;
 	int ret = 0;
 
+	/* GetGfxBusy support was added on RV SMU FW 30.85.00 and PCO 4.30.59 */
+	if ((adev->apu_flags & AMD_APU_IS_PICASSO) &&
+	    (hwmgr->smu_version >= 0x41e3b))
+		has_gfx_busy = true;
+	else if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
+		 (hwmgr->smu_version >= 0x1e5500))
+		has_gfx_busy = true;
+	else
+		has_gfx_busy = false;
+
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk);
@@ -1284,6 +1296,20 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*(uint32_t *)value =  smu10_data->vcn_power_gated ? 0 : 1;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		if (has_gfx_busy) {
+			ret = smum_send_msg_to_smc(hwmgr,
+						   PPSMC_MSG_GetGfxBusy,
+						   &activity_percent);
+			if (!ret)
+				activity_percent = activity_percent > 100 ? 100 : activity_percent;
+			else
+				return -EIO;
+			*((uint32_t *)value) = activity_percent;
+			return 0;
+		} else {
+			return -EOPNOTSUPP;
+		}
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
