Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2367C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF0264F09
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF0264F09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7960A6E87C;
	Thu, 18 Mar 2021 04:12:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327806E87C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax+KRfQQCDU4Xsb2VYXYQB3TxE+SazW9t5dEwyYq49GcT/35gZnRLeJglLJ5VDu07fbKYEIL8g2M3ZzbHdxTqxQ/GtN663pFnTvuv4cgOdZYPpGFJ4rKHiCzPJMgpb3zBxIBymcy634ao1ueRdmZeiOQt6wZ6OhBxqvlStAC6xVX5qnEVaaoj5YiffCvlewL/sT4ByMzAIrtqwgfyXm8vxnLksYIDv8JnCYX38XrMV78i7MtuxRjM3KOECj1iedJ5UUdEuCV5c+9pRu2kMQOci1c/2SDtCQHgn7YGFt9ysWu8LGaDxXN6atAfg43RleiAWtSmmAa6ITCjW1khi6YVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96/VG6nhp1UFR/5hVQtlzZleKcOaJI3oUkB5SSDq7OY=;
 b=cPW2q5IuatSzBsuooZJpBKOVnvxgs6GabTZtwQHXiufUVc0IfAb8Z1NrXFakjX2mVAmRoQM2MJ5NZRclA/FMRcmlHdnVbbBouaZtpezKj8sAXHPRyGEomxY7qLjbIDSKwp5QvDkLfcRDePQMmaGyazQamPKzTD5SVS1LQj5mnYr3DwYRNLt4RD10dUeWDZhTibqzCOca0Kfukb4RmwBFd+WaebpEqUIdeI7wIGcsY9QF9GSaoiHtdjbSWaDGFW/HlwuH/OkZQNHqC9SH7HH8ZqShz47j89YRMFu8lOKXigVtutbuskZfG3DoEQdmj33Z4wmWAAawq+6F8YLbfPQmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96/VG6nhp1UFR/5hVQtlzZleKcOaJI3oUkB5SSDq7OY=;
 b=hDCnf9Vj9BX2FGr/1v11NlTJZ1qfIpgJnB1FwUpbuC0MKwSvBOj26OiqWYxaZPEAqDNQs7gIKiSBGzkhFRXyBzaGZZJNxOfcielvm84gniOdkcRfidZGXPkhQv1aU8tnlAt4/3u2FSLCCuKkkY7KHQmVglqfqDPfG3qwnpIeO/Q=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (20.176.117.82) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (10.172.87.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Thu, 18 Mar 2021 04:11:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 04:11:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: bug fix for baco reset
Thread-Topic: [PATCH] drm/amd/pm: bug fix for baco reset
Thread-Index: AQHXG6weMbHBeCfHyEGFFQJb3PNN26qJIfxw
Date: Thu, 18 Mar 2021 04:11:58 +0000
Message-ID: <DM6PR12MB26190D4DB7146CA97350EF5EE4699@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210318040634.2848-1-kenneth.feng@amd.com>
In-Reply-To: <20210318040634.2848-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-18T04:11:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8f6f0859-79e7-4709-89e5-d85af4bdef65;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cee6bde-6e81-48b2-7d19-08d8e9c3f9a9
x-ms-traffictypediagnostic: DM5PR1201MB2504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB250471F50B49B9D7DE30E7F3E4699@DM5PR1201MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VoVaxedycA3dAIQYAzyDzB8xBVydKsKfNkBnAtt2Li0plFSYdeOp0SQKYfCkyVycRUdVbcovoeJstWHirUyE+Nl7Tzs/h6fYYsDxN240jEppW9/bFJr7XxfTrrHFYn71NMI91++NYa/grA9ZlhbBrXGW7/zZwjmHy9HGRrkM1Kkcjk6nSBpKx5DY56yny6d4REyKCoXT3moApcDLwr523Yox3GOzgotR3FtMkSY3r1cFfjKv9qiKxyWqPGis5ILaSQIhjbdfq20wuURhCP2K7HiBWATJdgEp1lWcla2UGEUFw5rl2Q0avLb27pkx0yI6/eGXKHrPQtzICyydRvvpC/EEULHjRbOZsPn9I+JX/APm0DQU56nH3qu+9vugfhKnFsPZzzIzgN4GGfyFLeQRPJ7fVNlJhw/Vwu4HMbfuU1KMGcQVDki/+gVM8KOMT/HXpkmON/fIaAsPT82qkjNzjl5Uhs/TBmEGqhEZLAXBCRUFsNASCRz0pLzz1ZPO+LfvH3Arlpvs2rLiq3BsUqI4DZNG0BgQQ1SJlG4y+G+UQAOdO8sAqY0WDVJwh8uZ3Y1jczIT+cjF++rreJOarr1LJNx+KF+483SqdR1/jbMPvWM1EUT5Mn6Q5I2QM2nwRN7LbrXFXaHwOpifovtI4gRJsV4XAN6OUmn0gBm4DF8h500=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(26005)(110136005)(316002)(186003)(86362001)(8676002)(5660300002)(38100700001)(478600001)(33656002)(45080400002)(966005)(76116006)(64756008)(66476007)(2906002)(66446008)(53546011)(66556008)(66946007)(71200400001)(7696005)(55016002)(6506007)(4326008)(9686003)(52536014)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+hWle0fcxSs9mB7gUoyNQTn9jNkoO+mZrFWO3y6gCWtRAqx4tKHbahBGR/eG?=
 =?us-ascii?Q?j8JAXg+XlY8XzGoh4a10EgAmLwaycrVHtzrAFsL4oU7oNs7VbDUfhO/0InkX?=
 =?us-ascii?Q?Bbx8QuyILOmT4Osbbu+14x/1as9yr433iAXRn2whM2RXocYPkoc+hlGGkK6R?=
 =?us-ascii?Q?OB6EOsWupD31ec1lRsXObebD9C9PB16xhvZ6WOYvE/lg4OPWarQsfDUq+iQ/?=
 =?us-ascii?Q?k2OA32eDQJRnKvvg2JezMS6BNC1Xs1mK7eOLoNkEx6fV7D5+N5CegXkwgBti?=
 =?us-ascii?Q?VLkEWo+R+3OrVy0B8IQSKrLglYIVO+Xfrf6yvpPOSs2P/eZYhDwXTtJhcN9g?=
 =?us-ascii?Q?C+vpxfBYO9C4RiF05Z9dBKVWZCembW7XYfq0W/3t4v93bERJysw1uK1ByzZK?=
 =?us-ascii?Q?g9SczTVIP26wm3/xrjblm5C3QH6/K/yNqxleVaum/zYqFE4i+ZhBdHc2PxJn?=
 =?us-ascii?Q?8Ov1IAtM+TyT1rdN3SV0nVllc8M6quS/5B2C90GU8a3cFJk2XegwbTO8AVOq?=
 =?us-ascii?Q?NL7ZKITfMbwsFcY07HosakVlnXXqt1X/gOkycD5Zm/9jtx0VhRSyI6NWesLq?=
 =?us-ascii?Q?k1lyPhWA7JfP+l0uKBLCaXGeQ3n/HheyxPJPyGSBPP31Ll0SSXYlktPHaekx?=
 =?us-ascii?Q?KCoOTfnn6D90eGWr3OA3n6A+wDkXWcc423+w0rGk4k0M/6fCPqv7qeCRvlt7?=
 =?us-ascii?Q?Y8wgaMASLy0LzBOF24Y38B/nE4E+Sel+poQI9b1ZKynbyp6Z+RKrhnOYx2hm?=
 =?us-ascii?Q?UMWqccH+HQIUgu9TEdPt8GoKDrUmUUCAu60lPhx0y9IRLdLRYVRE/dYZII2u?=
 =?us-ascii?Q?6lFiLy2qu/XdN6hhf7YkDk9BF2D14XNWw9nJvnwcm/vQZ08U5218GUBPaJBk?=
 =?us-ascii?Q?srX4UUho/5nEr39xicS1n3NQZWObBrM/bO8258l5H6BKS1Qp8m2k+ExbK7U6?=
 =?us-ascii?Q?Ned2CtuQibCan7Eg6/+GNzHvslAkqETJz3KL56TeYfp17APTPq2l0K/rQmVj?=
 =?us-ascii?Q?Ezu5ZOXz5HaN1JtnuS3u+7J27E/0QbX+9LTlY3P34v9x+tdu23MIaV/7ax1f?=
 =?us-ascii?Q?IFtwBO0rV76qDaSXAvI2u1ivFGFTeNdv5ljUWJto8CwNdyGyDAiGz9mQULsF?=
 =?us-ascii?Q?6zBH5CrwwoCP/agvpCmOT2j5NS5+Tol3bbKwLuESNZpMkLmkP3d+ENettaTr?=
 =?us-ascii?Q?5+w0mDCWKlqfoFHphit0OwaLMSU19bPt1QwW+mZblwJRHvVBRzkUI0t3dM7X?=
 =?us-ascii?Q?X5B8BRQiDH4lFbZdrllhcHL4XY2uP+gc3UzU2qqiRG3ZrFGN/goa2eIXrknW?=
 =?us-ascii?Q?4IuaDRqXxzo6N0UyPojmquX/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cee6bde-6e81-48b2-7d19-08d8e9c3f9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 04:11:58.7904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxUtP2eD2c93fAf14mVEcjoXv1q83OnkyYqCI2laXWPhdS3ZnWRzyBBUu6IuwwvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Thursday, March 18, 2021 12:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: bug fix for baco reset

On vega20, rocm-smi gets the wrong gfx voltage after baco reset.
This can be reproduced as below.
:~$ rocm-smi --showvoltage
GPU[0] : Voltage (mV): 737
:~$ rocm-smi -d0 --gpureset
GPU[0] : GPU reset was successful
:~$ rocm-smi --showvoltage
GPU[0] : Voltage (mV): 1550

Root cause: telemetry is disabled in the asic_init after baco exit.
This fix targets to re-enable telemetry then all the power and voltage
info can be fetched correctly, mp1 firmware also depends on this setting
for dpm arbitration.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.c    | 17 +++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.h    |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index 2a28c9df15a0..bb58097a925c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -28,9 +28,16 @@
 #include "vega20_ppsmc.h"
 #include "vega20_baco.h"
 #include "vega20_smumgr.h"
+#include "smuio/smuio_9_0_offset.h"
+#include "smuio/smuio_9_0_sh_mask.h"
 
 #include "amdgpu_ras.h"
 
+#define mmSMUSVI0_TFN 0x2
+#define SMUSVI0_TFN___PLANE0_MASK 0x1
+#define SMUSVI0_TFN___PLANE1_MASK 0x2
+#define mmSMUSVI0_TFN_BASE_IDX 0
+
 static const struct soc15_baco_cmd_entry clean_baco_tbl[] =
 {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_6), 0, 0, 0, 0},
@@ -120,3 +127,13 @@ int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr)
 
 	return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_BacoWorkAroundFlushVDCI, NULL);
 }
+
+void vega20_baco_override_telemetry_parameters(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	uint32_t data = RREG32_SOC15(SMUIO, 0, mmSMUSVI0_TFN);
+
+	data &= (~SMUSVI0_TFN___PLANE0_MASK);
+	data |= SMUSVI0_TFN___PLANE1_MASK;
+	WREG32_SOC15(SMUIO, 0, mmSMUSVI0_TFN, data);
+}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index f06471e712dc..9ca39569ba0e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -29,5 +29,5 @@ extern int vega20_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);
 extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
-
+extern void vega20_baco_override_telemetry_parameters(struct pp_hwmgr *hwmgr);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 213c9c6b4462..12830a8dd923 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -503,6 +503,7 @@ static int vega20_setup_asic_task(struct pp_hwmgr *hwmgr)
 		ret = vega20_baco_apply_vdci_flush_workaround(hwmgr);
 		if (ret)
 			pr_err("Failed to apply vega20 baco workaround!\n");
+		vega20_baco_override_telemetry_parameters(hwmgr);
 	}
 
 	return ret;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C7fee5a2166be4f31286408d8e9c33f55%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516372084403923%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KEFE61ILud7i%2F28piougWFNBBSYz%2B5mi3dBfHSghllw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
