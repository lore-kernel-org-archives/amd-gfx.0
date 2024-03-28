Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9EEC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 04:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F0D1122D0;
	Thu, 28 Mar 2024 04:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5W9HlFu";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561CD1122D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 04:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcbESDi8Y47E97k6BHA2e/oxGimvCFaNKicWr441r9tiwGUOMbhfqbk2jk+cDF4WAW6POEggqZ00Tw4jd+MtkJ/5O9LdJLxLP6vRzR3MfKZ0xRvtqftJi9fw4ya9DI23gqfzLa/+eo9F4rTXONHtO0yeBcFAEMdTEVGal4IYMzkwWcz2MpTJhXJ216/+0/uV216lzFoZY9XPnLM+3Lp50AqwWKu3dpO5JhAc+/JqQPpoIuolStE3JQziXhcuh6M1tsCUc/NPeBCBI3/gZrGqQW/AD7tHpK8Er4sqHpj0OHLxNrIwcJLfC6X7v4jA65QJiCJgbUpXBsYlV74Z35Pffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Aclc6J5iqgteLPstbP7uYxqvNBBa4uQpno9C/ESgbE=;
 b=SFkpl/hcXl0vp8UFmdfqMc95zY+hpAocf0A6n7nkOwbM93F/26aiEE2bhhKkecYKdlIsqky3xb5Kq0imMN+p1Ebp87Oy0M2n3Zs8nMnGHpRxloENHh85div50roEAL5Wtwb3YnIY2Ym0H2WRgGPHBhnXrDvS2ZxnVxCY7tI2Mu915gEfFfpQpp5PdtIDRGJB+Ju08PBqHgQZsrGViVjCYXGwD06I2Nl6zZLZCVujIZXx3roud6jJtdveSr5CuxycVWc59UTIbBSFKC/SWGX5fziO228Z08rvyv27PRKX+SxUhJ+SMiy2ogOpn9yuA4YcmlAfwIs3+7dCnWbEwgtJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Aclc6J5iqgteLPstbP7uYxqvNBBa4uQpno9C/ESgbE=;
 b=T5W9HlFumdpw9RFoSwI36gagGbTeUHhCwaiV4SMznIlNjKTRd4Ts4dldnry9J5EUlkZo5m4Av3iF/RWSZFGZLJL6+Zu3nQCxczAXB6FCWn0/WPQ8+Oh3cmulyZ88dsWYeflhOVHd54Vj0YoG1w9JHILuHhI5faYZCLKJhSBCJ9k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 04:27:08 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 04:27:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Reset dGPU if suspend got aborted
Thread-Topic: [PATCH v2] drm/amdgpu: Reset dGPU if suspend got aborted
Thread-Index: AQHagMc9KhIEcXeHMU+V9MVY0PLyF7FMjksQ
Date: Thu, 28 Mar 2024 04:27:08 +0000
Message-ID: <BL1PR12MB5144F81CBEF359727559F869F73B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240328041936.825960-1-lijo.lazar@amd.com>
In-Reply-To: <20240328041936.825960-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a4fe41df-52de-4af5-b368-db903748690a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-28T04:26:43Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB6483:EE_
x-ms-office365-filtering-correlation-id: a4ac0fa1-59c9-46e7-6f5d-08dc4edf548f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzfvAHdX9rh8R68BYJxxO8gZ49+7veWJYIr6LlrabKg8RcGVaG5Bn1A5sONcM+HdLpZXqnTssbD4JU5Y51/R4SNDwnU2NTUAn+ITP4Vv0g8aSqakd+pUibqb7MeoA2LNkFxZTbQFP0+4tViwukxLwPajpIWcFs6AO+c9ifttC/tlifmb7cdMhHpL+Cnw2fBZVZciADNKTVbiVi0WucN/z7i3jHZTYU8YUdtEAvTbbeom6ou34XnZ7KpRSuIP3bUtPbZ4YKNbnQxxkhDKl+/N9+j5r02HRnMGLZo935VzgpFaACvVIW5EnFx9yNQm1vgBNUI/7MfFjookAUbfCvAW1yGOa0QO93ThVEGcPjWGVQgnwv8M7nohvHH2ukWxjS1viHJpgEFQde3Lmg2rPqsEnmqgCpyE4dXZOAeXJSt3J1kZ0Ljc4YvPEmVsn7PrIY++HbodCylc6hXo+riNEzuIrZVRljQVJWc0pQEICbLgm4WkyZ13DaktISvKcEK51BgPbSCP65F73xdhA4BUx0S5FowWgbccx5L+NkvJNenaMuvC2Ma+lIOpyBgbrvKOxa92VyHqHkn6P8MiZO7xNBa+Pig51XVqyeEAdiLhgDkHk7Y8ErAlEwhaOIzcvisGkb/TvqGWPhpn2I5wYzJpZlnfKC5faUk93uAAjp1peGd/IUmavOhEPmaHYWNK5Zomkjm8/B0KEyz3KESo60ErP4YvE4rqklVrQOykek1uD6/X4Es=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HENf6sRsZfEYS2m0quvg+gfxcdTDG/KpMdzPWpgw/uAX426m+NUaQo7UhS2h?=
 =?us-ascii?Q?xZHE1WQdLLizrHxcvMWeCj6S0dHGG2fuyZRKjkkCYTfD/pPa+nVTSLWA0oka?=
 =?us-ascii?Q?2EFdcNWJpfw4ru2OS9olpBTygHom8/PvghKX4XjwrzWoVxNi01AA5ZKoy97S?=
 =?us-ascii?Q?kgj9h1SeP2T+orZljBJZ/0gseGWB/lYzdppHLahQRINMwiYH1iLrn8ejEpUp?=
 =?us-ascii?Q?dwsJ9L8QYIIiS7fGQbezNama7aNpSNlnt/HrDZnR6zrz3V/i1QEBMUSNlYwp?=
 =?us-ascii?Q?4BeMQPRrKtoKgSWGYhRr28I77dLbaelMjLmcwJPbCjIyGEx8bvS+sEs74mKk?=
 =?us-ascii?Q?Ifky6/eVN+GpNyjTjKaWG1J5y3Ulf2QsrP5UZXaPVKum+ZUckdsErDyFam4+?=
 =?us-ascii?Q?oVxOHLtdxSJRpILY8i8Zy2GcHnhAmsCI9xZP0xYRG4We8dmAcJkioq0egi22?=
 =?us-ascii?Q?CyFjuyDqqGebm3c99bNdLzdNEZC9N5y78dDMayHFxAYQDb3iTFvYTpByMKXq?=
 =?us-ascii?Q?s6pcyzPgyfeeno0+MPkisqdaE+fVln+RFYyndQ4cMM2dRe2OI0kU+sw4oa/p?=
 =?us-ascii?Q?g7B9aBX5+BZGeI07KpGxMJW1z+uX4tu8DsQ2UBjkOgp4okY80p5pMiU9KWSL?=
 =?us-ascii?Q?REqySJOmRYZYXEHqvGdqAH6/wgYzaJQ24kQjAUrpicMkzqs5m1uJrm0vHrMx?=
 =?us-ascii?Q?aHH/4MFn3YjQeLtTxgbKA7kfeZJGhy3tWySq7x+rwF7elBQdHwykr+DGlNea?=
 =?us-ascii?Q?ikb8pQLLjSGMfchVf4e5oFOhjX0YMtyCe9p3Yu+dP86TU0iFZ6VK/AjjFCPG?=
 =?us-ascii?Q?njrQxDZ7tg2yMJQWMZY1iyG9Gvv5S2I83Ky/2tEL7KRsbVLq7lWTFd/pkXuK?=
 =?us-ascii?Q?H/B0BQtmO4+1LR97E+2GsUOOak89wyzpMXGTo3GSiYuAjIkydAsmpbsD5aGu?=
 =?us-ascii?Q?LDiHGKsNTSHhBRAEAOipMyJzPMJe7i9gozquG03GkTRTOLOaCsvxxD6nn9hU?=
 =?us-ascii?Q?LfC4PacGY6WFv+X8cpMOSyMjfvT5tA0oCJRTOLAcHypoPKoMqoAtNifOeCBb?=
 =?us-ascii?Q?gBeNhas0l0VGHsU/Csvxj2Un8Ea4kZvz7qY+UEa+ajdT6+bvoiWO6JYZ0WWj?=
 =?us-ascii?Q?SgT0VDv7tBN4qlSeNjty2uASPngcJlwm2AuGQQj1KNY2IKElLsQL70PDt+/8?=
 =?us-ascii?Q?3v9k3+j7PWnuAm1kexUNOIdN/1z70ctp6DQ/vly0pB5TZuq26oo/3tLWRb/+?=
 =?us-ascii?Q?Mt5n1ZhL80+V10cIHbPIUvepCrWtF26f29JDXAarZNPi47/qAQMWEz3to8wr?=
 =?us-ascii?Q?IcBgNSe5xHe2+UhPd2J0UBcpmEPIYAGwIAnkdMRu3CLwP8Ih59erufUd+L7q?=
 =?us-ascii?Q?YgAA5fOfERyyuV8Ky1aLEygtM1XQhE5kSswlJ1nP844y4p5CxQWfpPGOL+TH?=
 =?us-ascii?Q?z6TO7Tq6FOe7B6l93+f2fN/oySuLfEG4nuGZCEJdaJvUXh+Fy+TbVQE8YwJR?=
 =?us-ascii?Q?wLYiDnnP80DoLMeCrb7QWYdIUHxRybg/8SmuxFrneSZBEtdRSn2cGmlF0oxc?=
 =?us-ascii?Q?9WzB53/U+7HdnMflvcg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ac0fa1-59c9-46e7-6f5d-08dc4edf548f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 04:27:08.3101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsYsjWLSsJVbgO+S8f8+vFjwrwvcaN0kag8+3m/fKapsPyajpwW4g14ZCBzxHUDyaR6uYz0WPMiFR/MDiaZj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Thursday, March 28, 2024 12:20 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Reset dGPU if suspend got aborted
>
> For SOC21 ASICs, there is an issue in re-enabling PM features if a suspen=
d got
> aborted. In such cases, reset the device during resume phase. This is a
> workaround till a proper solution is finalized.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2: Read TOS status only if required (Kevin).
>     Refine log message.
>
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 25
> +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
> b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 8526282f4da1..abe319b0f063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -867,10 +867,35 @@ static int soc21_common_suspend(void *handle)
>       return soc21_common_hw_fini(adev);
>  }
>
> +static bool soc21_need_reset_on_resume(struct amdgpu_device *adev) {
> +     u32 sol_reg1, sol_reg2;
> +
> +     /* Will reset for the following suspend abort cases.
> +      * 1) Only reset dGPU side.
> +      * 2) S3 suspend got aborted and TOS is active.
> +      */
> +     if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
> +         !adev->suspend_complete) {
> +             sol_reg1 =3D RREG32_SOC15(MP0, 0,
> regMP0_SMN_C2PMSG_81);
> +             msleep(100);
> +             sol_reg2 =3D RREG32_SOC15(MP0, 0,
> regMP0_SMN_C2PMSG_81);
> +
> +             return (sol_reg1 !=3D sol_reg2);
> +     }
> +
> +     return false;
> +}
> +
>  static int soc21_common_resume(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> +     if (soc21_need_reset_on_resume(adev)) {
> +             dev_info(adev->dev, "S3 suspend aborted, resetting...");
> +             soc21_asic_reset(adev);
> +     }
> +
>       return soc21_common_hw_init(adev);
>  }
>
> --
> 2.25.1

