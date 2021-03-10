Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CF0C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 09:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E27F64ECC
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 09:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E27F64ECC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2B06E9E7;
	Wed, 10 Mar 2021 09:51:14 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700043.outbound.protection.outlook.com [40.107.70.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD026E9E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 09:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k87wObkgkr7aMLL2bXW4eSwpC8W3xD+A48HxvuzWTObrzUZhPqDKpL0SxaBWnuXCO4ov3d0CYPnZ5fxw/uoLUaL/Tc6fscXPvb7ro6mjcNDU2iOWbVLA+Rdp8u0DBJvOA2F3H1tte4afRKvBSD95ETs2jp/DDaOpc7FZYzHZFzBPnJIxe8XdA/l+VhTu9Otadzo7WlOpu2fH6TjDctaZAWqay2fhTyFwndIsw5F2kdJ64kDfvX1GXJSjIBZjfycwRaJKXkylgdSywEvz+qN1vb0ZR9yxvDojTXGvYzw2kw+UszdDP9eRoHajlpZA/ChHRD/dXafgs6WzQ8bnTsWUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwxY5bqGK/0uWhq6Z3pRpWwRuhzJRgtMtJtmUJFimEI=;
 b=gYvDAdv5oeUPjqCIcLFkvAB7rBtM2H+Fu43gJevxtIUbxpYwwjEsGX3jj50gMwGqiPks0NFGLpoMxqeNPCVkkdVP0HjMEUD7liCiAn4WEVODyiY6WKJcpalq35TMnupBk8TLt4QzXmbTBnsGxq0yyT/PhXVOyqRcMG+aSFg3yzB+11ke8fCWGb1+WhDJNT8Cn1i/aUCrcUizd3RdlOdqyhxnEKv2BYdQBxXr+S9x/1gcLMafHOtaeZhdw3mZE7vLMVB1Jze9cdL6TxFt7l8jBZuTm+SH+8XuqzFRSRfhmiAJxVwmyRXdJLZETvLmTZ7inPaToZRR1Vb+RU0P1Fk+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwxY5bqGK/0uWhq6Z3pRpWwRuhzJRgtMtJtmUJFimEI=;
 b=cijJZzRHeQw9chRW0iH9IvrXloAz8hs++v/DEF4MTTln+oLoIXOp90P5Cznj0yLp6S7NJj498dYw4RToGvI2l+2pgZkvrf5rUWXIBz7Mw4w1jts6E7c20QB+NFGhFvIuPytXuBe0/yAQAPQoZ3fmg80vmk82DMmsBOQ6/R8Dpjw=
Received: from CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20)
 by CH2PR12MB3992.namprd12.prod.outlook.com (2603:10b6:610:29::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 10 Mar
 2021 09:51:11 +0000
Received: from CH2PR12MB4890.namprd12.prod.outlook.com
 ([fe80::1dc7:1e93:5f14:be8a]) by CH2PR12MB4890.namprd12.prod.outlook.com
 ([fe80::1dc7:1e93:5f14:be8a%4]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 09:51:11 +0000
From: "S, Shirish" <Shirish.S@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query
Thread-Topic: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy
 query
Thread-Index: AQHXFWON7MZ+ZfFjC0aS17fI415xdqp81peAgAAkQvA=
Date: Wed, 10 Mar 2021 09:51:11 +0000
Message-ID: <CH2PR12MB4890F54BD9FAB8798410CB0BF2919@CH2PR12MB4890.namprd12.prod.outlook.com>
References: <20210310041150.289806-1-alexander.deucher@amd.com>
 <DM6PR12MB261978DDDF04B6F2536315FCE4919@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261978DDDF04B6F2536315FCE4919@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T07:40:45Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dd5e8ac0-3d79-4407-8578-232b5b10f203;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.158.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97a1a9ed-367e-461e-5d04-08d8e3aa09a5
x-ms-traffictypediagnostic: CH2PR12MB3992:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3992215B1B64EB5906FA8E79F2919@CH2PR12MB3992.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t85WiJHhmDMZqWu8lLog28JoD0lVNBUlDVCSxkRUvv+fP8lC2cfwLaXqktL1ku+q9APf6VLOQ7h47YfPXn69EH/hNP5wnrUjc/WGJvYG/nuuJO7SBzY8q+PJc5sSSY5twKbExe/afjrFwqiOv/GLnqUaRT7J41mH91g4mNkRBZwXF0oRQXeQ4cMlyCCTUFOuy/OD+rYgWiQhE7v0ZtJZklQfS6SPN57WMKpufAIQUxh7OXJxoJfxm7h6dJvUIXCvSy/BWjaPzMTDwUZS2BcX+69kX3y9Q3r3ccV2m9ANKUR5D6R2++YgbBkaWMbj8ZZISRCC1XJGY53+s38uPJjO3gfcQ+PoL0eCbGszYRM9Ov760p2q7//KkLTezeFRyjV8/vlPRQdPFilyTkBhNSnQqw7wjeaPdWX4xqIvVUPAafxnowb8LewrFhBKM2zMw5Xu3ZdeIj/D4WntWmsgT/2vszoWxTBua7CeL7LpLxCJbqascpnvSZ3fj84kZ4RvXCoYASRybaiq2bzCNPigGkjzZWAwGoseYRqpNSEx30Uc+XWEIGc5dDlfvP2e5TI9Tmje
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4890.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(76116006)(8936002)(6506007)(53546011)(26005)(86362001)(66556008)(66946007)(186003)(8676002)(316002)(71200400001)(83380400001)(110136005)(33656002)(66476007)(66446008)(64756008)(478600001)(4326008)(52536014)(7696005)(5660300002)(45080400002)(966005)(55016002)(2906002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r0r13czlVmoXl5+qVnQeYT1tZ3ycuhD5s2zq9n+tNX0TdWqMQzBjpJ6Tlzn3?=
 =?us-ascii?Q?VvXFe0RwiDLCGCiz2/mCawCy9v3xVs1lQfuvsNcX3JWRp5LJXvQ3/LbHBz4a?=
 =?us-ascii?Q?gtq3t4xJV/Jyh+ySl6AmgsHd0I/AbmB/2XuMAXTxkFTJhVcMS3OA6koPmVtF?=
 =?us-ascii?Q?8Y+SN06zwyZINnCjbMsOpWXgjRXth/V7k7vPh43qM1Cz/Kiw/V1fhEFF0MHg?=
 =?us-ascii?Q?rKeS8TwzMbckeGqR20NCf+OCp3m4KHQ3l2zR2Ldvg1VaZOsjNEpWL2GsUGIV?=
 =?us-ascii?Q?LMekm46zfc9K0yPagdvsJVTDXBniS4ZXeqGzXcrYalxqf3v2ezcj5bfBqTo8?=
 =?us-ascii?Q?+itfbpRLuvbQ6vNr3o4Vrr6JKyHHCQ1EY98LJeZgGxYEb/seuFeJT482ZYrY?=
 =?us-ascii?Q?LVX0TCw/Xjfu5FZ1+CxW2nl+7XhggS915DihoFjxGvDNH3ukSzfGfyIHqUL8?=
 =?us-ascii?Q?5BZHcXVqi/R4fKRbMDuNwbHmukQKBaXtwKR2b8l70B1GP+6qNoMFN5LhCzHw?=
 =?us-ascii?Q?b4Rir3Lh+SE7LcltSPBXp3CYPzzp6kCvu85S/DApcwdgm7KVZcDRP+BgFjbu?=
 =?us-ascii?Q?xkTUjqjQ36ZVNUX7G4dkmZc41VcdqcD+2wKjYtmjNPZ50R45+0eDo1qqdZzj?=
 =?us-ascii?Q?UJ7LEy49GpyPz3xzWsOhSc4ROMkYweCiPzAtzAx+rLPV3+fmU5utQOiZvr3L?=
 =?us-ascii?Q?krDGWWkNt+dmqdTmo/nF++kbcFIn6rsscCPF3/OjxaYG8+habmbkIq246K/O?=
 =?us-ascii?Q?B2u9ycW+m4MsP93zAE/mbxcpUngMWWkhgtuUzK0Eo61tnOBQIP5NMRiEmZid?=
 =?us-ascii?Q?GRpbyl+mtjn6Cjk1d/gqtuoKHnYu+aUnPwKcm/z6qXaqD5A192lc/50mjUB+?=
 =?us-ascii?Q?/gfKYn1FFtD9daA6HKEw1rR89+v7A6oh41uSIoxtzfumDn6AQUH+A4DowkcL?=
 =?us-ascii?Q?fRXRMUd3+7KXcC2I0LVw09BZjr10NEr9ih/jBteSBWW7w9WM4jcOWrGAi5al?=
 =?us-ascii?Q?bpXllwFJqofHFGokAQGMnl03iAZ4v1wJgrsk+41gUGEZZ63V2gzfoCVHqDzx?=
 =?us-ascii?Q?I9E/hfZiv6hMJoG1CeQCRAhOIxfkK3k/ggOC1UtBtN4i0AIpcyc3t13agpRc?=
 =?us-ascii?Q?SPP60aRZkQ0JagYAPr97G89iSr4bE4OUXVbwIt8nd+5WupcXI/oyRjEIJlXl?=
 =?us-ascii?Q?sZ56KgBH4vlwVsEFHIckRyMExQEwdHbwwo0PdS++K6NOwJrUfGOXnf9In14w?=
 =?us-ascii?Q?2IRw0FV0KLqulGk3bVPijCWyrd5tEUd8D9G/LC0tpDGQ3gOVv7vYsR/XZhUV?=
 =?us-ascii?Q?Ypf+1Nx/4aFyk5Ww6oSy37BM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4890.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a1a9ed-367e-461e-5d04-08d8e3aa09a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 09:51:11.7737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3NWgmRrAoESDJ32HRZNPecI3I4MD9rh/zsrp6a9tHpPA4yj+us06ix/vXzUXZO2epVwUv3baLYjm2FrIAy/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tested-by: Shirish S <shirish.s@amd.com>



Regards,
Shirish S

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Quan, Evan
Sent: Wednesday, March 10, 2021 1:11 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, March 10, 2021 12:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query

Was added in newer versions of the firmware.  Add support for it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h         |  1 +
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 30 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

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
index c932b632ddd4..52fcdec738e9 100644
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
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk); @@ -1284,6 +1296,22 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*(uint32_t *)value =  smu10_data->vcn_power_gated ? 0 : 1;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		if (has_gfx_busy) {
+			ret = smum_send_msg_to_smc(hwmgr,
+						   PPSMC_MSG_GetGfxBusy,
+						   &activity_percent);
+			if (!ret) {
+				activity_percent = activity_percent > 100 ? 100 : activity_percent;
+			} else {
+				activity_percent = 50;
+			}
+			*((uint32_t *)value) = activity_percent;
+			return 0;
+		} else {
+			return -EOPNOTSUPP;
+		}
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShirish.S%40amd.com%7C91ec8f556727479d060408d8e397d498%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509588548327792%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=rQknLutpWSubH5e1T29n2hIpYT048FFfd8gf8bAQgEQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShirish.S%40amd.com%7C91ec8f556727479d060408d8e397d498%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509588548327792%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=rQknLutpWSubH5e1T29n2hIpYT048FFfd8gf8bAQgEQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
