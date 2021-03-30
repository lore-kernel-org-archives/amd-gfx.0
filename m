Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FUZZY_PRICES,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE030C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 11:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF1E61987
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 11:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF1E61987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB5F6E8B3;
	Tue, 30 Mar 2021 11:49:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AC96E8B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 11:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQleU3OhShxKZ592xuob3HuPmVOiJy8Wpvtd192sWChgToVAQhxhvg1k5GEz893Tnplhe2y0ePlB1GZETZ5MA5Mg3lFv97rZxdlX1NxAC0ZKxn4C5HqBtUPEoIvA8ThEpWT0jocn+iQzvtSFYNuig/SgiJn25kl6yb0YXEZn9lnFkitiqAy9MDrAtq3iZJSx4QRtLT60WoxaTaLEDkiKgKZlCHBSPEwmiUUFRUZBQksreOICXVpXeDq+DZZqgAWkDcaJH206SsHfsfywnW8J15HfYNkmckYUHPGNQAabCk2bzfb91jLqzig5vCvw5brudKL3JCTn2e8pYL+PEOWxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7p1QAwlh/tUf290k9NBIz8M9i8PJGo55bzd1dFGiF0=;
 b=AVIlMT5geWJhbaPhwTjuJoEICPWR+JAzHmEkxcPGIkltptzTjGkcXdqnR7VoXe/19wQRqH4NGwjfygmxWP+cxZ0T4m+qLq02nLGXvTNm155JQtQMH2Bxu/JeF4UaedhLyuSKUF+xBzUP+fEOm07HsXTlffUEwEZv47pF/8/X6PNXJ/FdxqeHxgT6b/46pD16vA+xwO29YD/qUy+sYCMXy9P3/oiQa4Nx0YruYZ43T+o+5GWKx88NG69k237SYwHsB7cmUBO+PKWvP5mDvUr96Qi+7yde+6HNRpcJzZUYYP5t2m8TcoIVJDoyn5tWAE+yn7UBIZEz1/wUECDj4CbxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7p1QAwlh/tUf290k9NBIz8M9i8PJGo55bzd1dFGiF0=;
 b=zBKeuPB0lgBlebT0ZzlioHPujqlfu23ap2Oy/Z+ty3x/I4xUEaFE4IyOcJ2YzxpCCNTYTkeFWC3SIUQdytVZqL5rwqXnsID/YO0lVonzRktZT54jdudASItuIF1QPZviWb3GDOT0GvqgT108QEC0hErvQ4iwUf0iBq/dCrqTKUU=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3838.namprd12.prod.outlook.com (2603:10b6:208:16c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Tue, 30 Mar
 2021 11:49:36 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::bc9f:d045:c79b:cc20]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::bc9f:d045:c79b:cc20%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 11:49:36 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check whether s2idle is enabled to determine
 s0ix
Thread-Topic: [PATCH] drm/amdgpu: check whether s2idle is enabled to determine
 s0ix
Thread-Index: AQHXJMKys1L6AAYDXki9bX4dpOupyKqcXpiAgAAMYPA=
Date: Tue, 30 Mar 2021 11:49:36 +0000
Message-ID: <MN2PR12MB454935F838261F8FEF010630977D9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210329174039.1872099-1-alexander.deucher@amd.com>
 <BYAPR12MB3238856746EF613BABAE4381FB7D9@BYAPR12MB3238.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3238856746EF613BABAE4381FB7D9@BYAPR12MB3238.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-30T11:49:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ff597063-2ef0-481c-9d5b-bb063ac44179;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.210.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f74cf96-7bac-46a0-12bb-08d8f371e498
x-ms-traffictypediagnostic: MN2PR12MB3838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3838C73EEB6E025AD91D9353977D9@MN2PR12MB3838.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WEoZ4ZJNZMqnq23F1S5ia24RW7jWcNLMdVt1vYUMM8Fs6CRJP5xs8ir5a1TvcZayxmWTQ+UjCYjPSiyJbwGM0/Mgi7Y2by7ZzDvtp4u/ZV9qKTuTQJ02P1D+9YTfY5r0GwUcwpGaavim7a6voF51R0hDsp/8/8DqyDPBIrYIcS7EGRMVbMbGNbTMzoaObuasWzsyDKyZ/yGpQoSbKn4qCoFy4IGRrB6nPPl5nrJFstOtTsrMOS7kpCirfc3iTKemsjuNToJhnz/D0N3/VY8+J7Rf76JoAw0NmJGlVASCHE2SzuToPpNo6jKgxX09h2WQvhLY1VNYld6vFU7MdK2llYpyf+wG7vUBd+MJoRh220MJ/Fq3pmKAacWEoc+/LVKgWevsHHvV4tjz9Tb/i+6+S04A0nBp/sb7PByUaVBo+fyEFwJWtHQtQp6LeB5o32aaG5a3JZLoyLh4b7UX61T+rZz+5Shj5stwVaIS5+v55nNqD9rKAik3imyU7FH0QzT2qTGTJtTyeg5hxp8jPWAUDhCW7RKmw6It98LwUU9sD2/qbWUDEj/32OlBNhxrGUs2aahE61CE5ACX5fRBC2CTCQ7QBRg8iaH24S2aF84whxymZHanyibXkwLNVLPmvxC8PiA/FRRPye5er1OwyKgVWEyv5duCQiINY+xIbM47YXyfwrlqCDPOrqln4PnvxzgWgjzWTssTOzZMpGMSUjtSRThrWH+r/qAXDMwpyxSZatz4jbjbrFSLVhgI+PV07DdaGyRpF60rVU4BNyeCk/ngg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(33656002)(966005)(38100700001)(26005)(66476007)(64756008)(86362001)(8676002)(110136005)(83380400001)(7696005)(6506007)(2906002)(76116006)(71200400001)(55016002)(5660300002)(66446008)(9686003)(52536014)(66946007)(66556008)(8936002)(186003)(45080400002)(53546011)(4326008)(316002)(55236004)(478600001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D3Mrihs6jKRHeA2Q3GLA/70uDBOCIBmw3miXKFRsYjhBi8q37jsJR+mDghc1?=
 =?us-ascii?Q?fmhsQ0GZOx9FctyrhErnnKjP5CAFEiuYFdZ51Di3L9+D7kP7aFCtvepora7t?=
 =?us-ascii?Q?LtO0zkvmNfZucx3SiffNBKI9SfO3X1SzCCXUx4szJqa0vi9ZN/7QbjcLgE6i?=
 =?us-ascii?Q?fdnnhMCdRC/a2Rd5ZX0BDnBr5lpnsm5yVFQOsmhozEPQRlcyNeNET8SJlLqQ?=
 =?us-ascii?Q?+0OJ0SnEld2zE68JVDh6qc6YleeV7SrmAcuZBmO5P6+tDr2ugkUtV4qHDGdY?=
 =?us-ascii?Q?KT40TI0eknQ8wCX0d4g+jxj+X1sP0fOjj1SeEM54jJpyNH0ACREdxzmVC2Q7?=
 =?us-ascii?Q?ZauziSVQ7sTEXrxzbDRw9yD0swN3g4AkGWprmiT5+y7nP1OHFoxE35mkVIKW?=
 =?us-ascii?Q?48lJ4hcn545lxOOVaD61j2Krq1WEZzf829UrwxPff763mXtbLpzL8ENQYbfy?=
 =?us-ascii?Q?u5psRSfbZZhwTiQTii4vMWNucQhIhA/qDyqwpY2pVFdAe6fued9WMER3RR44?=
 =?us-ascii?Q?vcBFLwjo/wOoZmVeUnKJy/I1HYV8mPkPfrhlb7mrc3Jn4H37PI5Ikkf2/nGg?=
 =?us-ascii?Q?zFCe6uEgtF9nYaYFKFOlLyGspfZPTf5pkIZ9H4mmPIXJ5lISFS2Lnfyzueat?=
 =?us-ascii?Q?fV2j+eccoModDf8QyopuKzb5C9neZW42GE6YLX6MUUHoO3SslpK6bsdtjwLt?=
 =?us-ascii?Q?VjrlrasYWRa538yl6GBs9aN7bhlZ04thdVVfU23zhYcjYoBqvDavoTnjQ3rV?=
 =?us-ascii?Q?s7tgJpZr1k9SOejxtHCPf+TppeoszwL9n5LymRLP3/GcLC5IGNci15QqMXke?=
 =?us-ascii?Q?m4YSXg0TN+dbTF8XvlbCwxu7CKPTqtRS0j6BZo2VWbalAfEbu51xrGlIujj8?=
 =?us-ascii?Q?cY8IK0sSMvM+JiHMdCYNT+zln65/gsyan/la/jCTwhojG8QBz3PRP4vhoIlG?=
 =?us-ascii?Q?afAQT8MYcQzX4+0fEv2COnaHR9YyhmiTOH6dSuEHG15nMwhn01g+TtQNp4eB?=
 =?us-ascii?Q?rtLzxxvQLEWi1DxedinR5rfTYLVppQwMfgJMUdTJRh3LtOhkmrn1k32YkrGN?=
 =?us-ascii?Q?Ci+FbDUH8HsCW45m8uIknPBFAryqPQehymwbnIUo+m8PUvZwR+MukrdaIAit?=
 =?us-ascii?Q?25R+l7LqSGTcsqUintC38+/PX43APLMMGlKHFtVn4oDx/ug8tXxUlyTWjD4H?=
 =?us-ascii?Q?rUMrZWrfQsyPBvpoUI492yGsxcZ354nIX/xuiGjhlBVZ7NR2Nqz6EosHAJf1?=
 =?us-ascii?Q?P82smUNgUifmiTsKmOHaxzz1b2qBO5j53edcukMxL7PPeC9HG3Fk4toyIm2R?=
 =?us-ascii?Q?j7djfjLYfqsEDvIYcvSgxMQk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f74cf96-7bac-46a0-12bb-08d8f371e498
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 11:49:36.3875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSIUQ2RYInfqCkGIFFeg+pFTnZkuGPmPaR9pLQ1/tdzj4sKrERy5Y+LKyJNiBsJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
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

[AMD Public Use]

Maybe just check the global (pm_suspend_target_state == PM_SUSPEND_TO_IDLE) and decide whether it's going to s0ix.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang, Prike
Sent: Tuesday, March 30, 2021 4:32 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check whether s2idle is enabled to determine s0ix

[AMD Public Use]

[AMD Public Use]

This issue should occur on the hybrid s0i3 system which forces mem_sleep to deep level on the s0i3 enabled platform. We may need use the acpi_target_system_state() to identify the system target sleep level and then handle AMDGPU Sx[0..5] suspend/resume respectively.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Thanks,
Prike
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Alex Deucher
> Sent: Tuesday, March 30, 2021 1:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: check whether s2idle is enabled to 
> determine s0ix
>
> For legacy S3, we need to use different handling in the driver.
> Suggested by Heiko Przybyl.
>
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> a
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1553&amp;data=04%7C01%7CPrike.Liang%40amd.com%7Ce0a
> 7dd7c6958449814c508d8f2d9d1c1%7C3dd8961fe4884e608e11a82d994e183d
> %7C0%7C0%7C637526364636883173%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=SHtEYsQz5%2FgkSGXE%2B9OFzN4yaRgkw6A2xs9IxVy3e5Q%
> 3D&amp;reserved=0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 2e9b16fb3fcd..b64c002b9aa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/power_supply.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/suspend.h>
>  #include <acpi/video.h>
>  #include <acpi/actbl.h>
>
> @@ -906,7 +907,7 @@ bool amdgpu_acpi_is_s0ix_supported(struct
> amdgpu_device *adev)  #if defined(CONFIG_AMD_PMC) ||
> defined(CONFIG_AMD_PMC_MODULE)
>  if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {  if (adev->flags 
> & AMD_IS_APU) -return true;
> +return pm_suspend_default_s2idle();
>  }
>  #endif
>  return false;
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7Ce0a7dd7c69584498
> 14c508d8f2d9d1c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637526364636883173%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat
> a=BZF35Ev5P7Guzwd3HYUGksztE30D4Cc9mhWk%2FjbaTyA%3D&amp;reserv
> ed=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C4287492ad9c8471d393608d8f36b354d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637526989080007698%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=g5VKbmTjSdMssg0OVEB9fYbDh8cn%2F5LJx%2FzKGSi7%2BLE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
