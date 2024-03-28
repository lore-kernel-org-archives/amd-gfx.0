Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FECFC47DD9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 03:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58F410ED65;
	Thu, 28 Mar 2024 03:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GOqFxtX9";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5531510ED65
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 03:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2KAWk01uGctqirrKa+bvzr7Mcc0BOJCoix3MPWoOQm3hb/Hh+/kARgcDW8rMwv/tennVJ7IwNM6vQYFe3FRm4wzpITyOd2yifEFsacCyMniGSWrgiRGdIQ8B41RIT0jq+8OtAxaRqhMaIJsVtXGpLf7vyYiG1ah4hFfn6KVqWP7JdVztggaZcNGfiNvDuDr5PV3Psar1UaDn8SxK359FxfPd6a1lcVhGLMnWWcmjZjOmmQlY7lUJGxO2eeTy3bdHOB/d5XlfJo0Kkp/lcsxGlz4bQ7hbkU499lWzHYuf0gpgs4BqI/GwUxSeFAE5/NwIq9zOxy7FHMjaHsQQxE4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krEbPlGKXvaa5rmRjmu51BjScy3bI8J+lazWgQ5Jx+E=;
 b=QuxTBUqKXKFCXP7UxeRuWiHgAblBSgi5m+MnYnvZxnqFoUYX906mYFCk3rdUqoqUS0nJJbyxsXmm/4xhnZRJ1ueBWl9m7GrknGEHQ5W4radS5G1cCh0y0LeiPCsRjUUESBMB4ihsEQ1+gW9YZUPPiYlHkxSuf9WFMxUAXyhRgzjcPi/IzWCvryWIKuEE42Xn6gU+3UA/DTe5nhTBKWTjKgdlQSsIBI082vQCeVdPxDjD+4g1S9Ilgl0wvZr5P7qg8Nnjpiroy+qd2YQQr1jeh/pENwV5RKfhR0G+JrYYJNtSh4s1fIhrpi0PZ/rV2OFJlkGI0el97N8Q5kJDx9KCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krEbPlGKXvaa5rmRjmu51BjScy3bI8J+lazWgQ5Jx+E=;
 b=GOqFxtX9051Mnrn8ZERS45X8GQY9J8ycaqKCK9/VMgbnr7OL63iZEOYIVXWgH0Vw1PngeGdPHu5Z/ka1Kx4GS/hmTbIXW5Hd23yz7xSdtqN5gM/wH9sO06lqs4yhKWOKONeAJ9VOr7zpEf40k2WjZpJ+Y/KHtuDGGCvyxmOCeIA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 03:19:42 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 03:19:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Reset dGPU if suspend got aborted
Thread-Topic: [PATCH] drm/amdgpu: Reset dGPU if suspend got aborted
Thread-Index: AQHagL0uBrA6caLN7kKK/hGceBE5UrFMe4gg
Date: Thu, 28 Mar 2024 03:19:42 +0000
Message-ID: <PH7PR12MB5997CB50A22EB9EA4999DDF0823B2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240328030629.820663-1-lijo.lazar@amd.com>
In-Reply-To: <20240328030629.820663-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c969b0b0-9c43-4029-a487-ffb358bbf6f7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T03:17:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4235:EE_
x-ms-office365-filtering-correlation-id: 62407216-ad3c-408c-affa-08dc4ed5e911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ajIcZhQWI8Zq+Jn0iCcg5r9DLwR+jN+hU5M0JIELo5en8kq/7Tdfjohdq7aTHNwZoD3Io8IeAG+7RTs3owKAs251OgYI6VIeWoCzqKAyb/e8eqz1CgzT326inQwdg20oYHoGZXlXzmY7rYo5GmKn1pb5PXWxQWlO1FZyQSPeEd9EX4SIQUYm2yd3qMz5drXO001IDIvyvK44zpwKtyijTzHiAt70T22Vs0OplXlXjV0ikWrUDfphcaMVZeQGqBIDstKJ4M7IZ2fEpf4ZaXOVpqu9+xsjCPx8tG+Xbkv7XbqI+Nar7CgIY2wnMYGnHWqIqPhWByW+4T8Gbjbwf+b70DeOF/rwzuCtr+Q8T7wGeOi3bQzMeonnIehNYQ5UWdkDxNsx523dzr+SWJNc703/6f5sHoD0NDTZIG3q82Xu9pGVkZEd9o+aZMfvaohHDnyJinVM5660wDqbxGq7pg39WqojHEyqL5Rd8TlpAhmCD0i2C5xsPsghm4pjsXGEqtmh582jFLqBGFMGaXOf+Qtf6bv+mWpFhyvl8w/0aph2E6LXo4GG2ZJ7NSheQGst0c6lKjfsUwMhqqqoVJkeO0ruNzaAm6IVro9t85JdEIifz9VUcf7pA8DGqAAkXK68Bi+qIotQ9DJpJLFatDgRRNBhY1Wqto790AAzYRfD7bFdbqtjUouisSqrKdUZRjvK15KIg9X4QBtXh4+U1I+lfGX3Cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ysfFv4oi9y3J42Fq+gM+sbgeytZhYYrOHuNjbnzh/s4QDIdnvrTHGAkalhw9?=
 =?us-ascii?Q?MADekYw3MdUXIVo+VOOLsTym0e6ajAGMqpe8CheDMsj3wTK7EvuZI62COHzF?=
 =?us-ascii?Q?u5EGrNIDtZlcRpm1Sema7Ml2tMaq6+R8ssxAHSkxe3ejDphAgNQqmLLUda/2?=
 =?us-ascii?Q?rEOyLAN9VK12Ehphy/pc/ug7jaARp7XeErC8p+SQ3N+XTs5va5o1D7w7v4Wu?=
 =?us-ascii?Q?ht/WVmUjV6A4MjkcIsxRbcZ2zpds+n1gr/VuztQjWv3011wIHRDXGV1wTMcz?=
 =?us-ascii?Q?NHQ4kTpg6mHWIChEDF4gGnFHtoi5eHMJjqFpA9NFVB/m14KXMrYitYHvW/87?=
 =?us-ascii?Q?gmy75hHUoegk7QWJ+FjuBL7+gqDw8ndU/v+nHNfutcdGwtelZ6MIU6elj8op?=
 =?us-ascii?Q?uMcreN+bgpC1ep+DsuozwaLSJB4rffGud1sFztHNq/dim8PTW7xqiPckIEIV?=
 =?us-ascii?Q?ht1w+ZdJoWzFlYNNmlfFREJqh/H+6FRp6x3LlEDNukteg9G6Nr0WDV05lC6b?=
 =?us-ascii?Q?tVbZwIEz5btlszbcuP0StQyIk7Zb6CSZQ09qw65bPC6jS++8OQJL8rZniaJY?=
 =?us-ascii?Q?L6WpCtbkoOLIE4K1xc3NFBfb0lJRgAXvfxGxTvdXwSwOOA10qWfMVsLDAVPf?=
 =?us-ascii?Q?SRt+Knh8+htisaAAv7R0p9Vg+ghhBCUQ2KNLEU9XpIMvkAPLR2zlfdA4Un2z?=
 =?us-ascii?Q?wOQcfOT1wOG10v68qxyR9atkQQIOTk4r2k3gEM0MWdqXSCrF6t5gEipzX9gM?=
 =?us-ascii?Q?3s8BJTtBT5Ntj7YaYkCuAz3y0Jct9L5nWgT8t7McT+7xstfrAK5w9FDb7bGj?=
 =?us-ascii?Q?wHZdpZak7BqKD880gcFVi1rUUlSWvuICwyLFMOHQrcMUitQdaEfnEcKoNPY7?=
 =?us-ascii?Q?AHSCybkkA2UcBP9yrDRfzht7qdcCge+4LdKi9HaywiqaXWxL6L/AH0lMBqBF?=
 =?us-ascii?Q?jQnwnULWe8Hr//VB3Xmg5N+zjIwZxXFH2euAQVBoidO7E0N//v66B6vYlbtk?=
 =?us-ascii?Q?xy7/qTQ8H53ryB3/ActZlLkVA4gCWTi9QX4pPlkICouJxkzYHyUKS/HM1UwP?=
 =?us-ascii?Q?Khw1fSDMpoCkXzrISHRRpq1mBr40eAYyI2HzXb+izJL6j9np/V/YHuBMVj6l?=
 =?us-ascii?Q?Sr9yeikUyllqXgX9FIjUn1bQiDDu2r6Q8aIfi1U6jH0aaXSjU1vgNuFjGysL?=
 =?us-ascii?Q?T32a1dmLUrvKUwwOBqbTG8u3e7DkHoqOPqkQmX523PZLniOuEMvhDaDOd7Jw?=
 =?us-ascii?Q?/hhG4Y4r5mlJzz4PPfdx2mplKS0OioOUqX0mtQcBKLsvmeqBlQygFtloYVOu?=
 =?us-ascii?Q?A4haRMacqCtVy3T63BS02pK/0qJ4lCjf12w4mZy02xv6kexFyaSZuWxjWrDt?=
 =?us-ascii?Q?XpAzFREGHd5SG1nfDjG0Ft9sUj5sJbh9CQuPz6RnxCN3j//SvaGyTL4+s9Ip?=
 =?us-ascii?Q?8x97Zf/uGwnSy95Dqs8DAzUsXWm9suAJP3Agwu3O76AUckICUwXf6I8ioqUy?=
 =?us-ascii?Q?yi9zrFVU+CmwrjKK9jSvfuRsraDCrR4RIYCRrDGDpQtq/+U+7wSAFll8tEJ8?=
 =?us-ascii?Q?6G8nM/GNRQni4AxvYgc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62407216-ad3c-408c-affa-08dc4ed5e911
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 03:19:42.4999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGoY0UBmY9tyid+NBWjPt5knF5q863G75K6A3/ruWD+qdiGceaooNfCqWmKLjRTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, March 28, 2024 11:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Reset dGPU if suspend got aborted

For SOC21 ASICs, there is an issue in re-enabling PM features if a suspend =
got aborted. In such cases, reset the device during resume phase. This is a=
 workaround till a proper solution is finalized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 8526282f4da1..a5305ce9b4bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -867,10 +867,37 @@ static int soc21_common_suspend(void *handle)
        return soc21_common_hw_fini(adev);
 }

+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev) {
+       u32 sol_reg1, sol_reg2;
+       bool sos_alive;
+
+       sol_reg1 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+       msleep(100);
+       sol_reg2 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+       sos_alive =3D (sol_reg1 !=3D sol_reg2);
+
+       /* Will reset for the following suspend abort cases.
+        * 1) Only reset dGPU side.
+        * 2) S3 suspend abort and TOS already launched.
+        */
+       if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+           !adev->suspend_complete && sos_alive)
+               return true;

[kevin]:
I think we can adjust the code order and only read registers when needed, t=
hus saving function process time.

Best Regards,
Kevin
+
+       return false;
+}
+
 static int soc21_common_resume(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       if (soc21_need_reset_on_resume(adev)) {
+               dev_info(adev->dev,
+                        "S3 suspend abort case, let's reset ASIC.\n");
+               soc21_asic_reset(adev);
+       }
+
        return soc21_common_hw_init(adev);
 }

--
2.25.1

