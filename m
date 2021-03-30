Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2EC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 11:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B2C61928
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 11:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B2C61928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCA36E8A6;
	Tue, 30 Mar 2021 11:01:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AC66E8A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 11:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwYO/sjxfgISrljz7MDJpdPBO19plerSiZ/08PFxO90wrS9DoIM64WSekmgy1nAuUomvMhHiM92Hw9FBdRuPhiUEzbNactwV8CAbb/XBxFi1Te8BOIsrVl5jGWfPhYORqK9QcPkTBXMBwJUx88iDywLp/nzNMPEie7BYh1MySHtkTTJPa+vM8d3xAzriIKNvIDJm0NQ8957PJfhVq9+XtUOp5f5UElEL2uwuvT6p7lyRxggCLkaeWLwyTCpSyJW3ifEqAbEFsuzQ0dTvZgm6Yz0BBFAVq9NZ7sRSkd01zl2tIFhuEIKh0i74ztk3dblTZ6NNjWZNRxdiebeWUqc9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9od2wzcRzI7MFm+hSs/SGy5AQddi7nhUdkiAQzqUBE=;
 b=Ti33wg3Mt9kDfqRfes520jPQ92wouqpIy5IrodqBZfPwHb1kZX4kZaS7N2vzf2nCQmzQhOWSu6576gRvKIG1fU/bkEDowCDho6Jqakgj7QRI0jzXCBXQ0jjpdxdvYwkUZDLB6RHPMKAj0FBVqm48JBd+mJMqO8+r4r1naecZVKL3aKc2bL8u1cNSBn6MaqO/tDocWi0AvKVD/krTwWSQRcssegtRPqU4Ns4iO+7t1gw15i2N1ND8YEapIAQFevP7LCJBtOrtj5QPB+dlgtQRfN5Dtmk+NH2fEKnxJF+6tLcrodQu0HLNtP41d7M/nB2g1NLL/C8SW1ULMAfYHpEXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9od2wzcRzI7MFm+hSs/SGy5AQddi7nhUdkiAQzqUBE=;
 b=A13ER8N3UwJ11QT0lTtuqLkqcKF05oj1omk8jMKyZIZ3T8/WQG8AbgQhX113qVE39NLOJjCjepDaN1AZhIChzR4yOi2xy64oLysHMezeVUkC2UtQy1uAjF8kNvLkl/aJh9Mjnf3/ZQp9zGEGHIQw3t9xo36sMKeVj2yn8W7P45w=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3413.namprd12.prod.outlook.com (2603:10b6:a03:ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 11:01:39 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 11:01:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check whether s2idle is enabled to determine
 s0ix
Thread-Topic: [PATCH] drm/amdgpu: check whether s2idle is enabled to determine
 s0ix
Thread-Index: AQHXJMKwEJo7sIDLD0azZJxL1tJj5aqcWn4g
Date: Tue, 30 Mar 2021 11:01:39 +0000
Message-ID: <BYAPR12MB3238856746EF613BABAE4381FB7D9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210329174039.1872099-1-alexander.deucher@amd.com>
In-Reply-To: <20210329174039.1872099-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ff597063-2ef0-481c-9d5b-bb063ac44179;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-30T10:47:13Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57cecd05-60df-488b-f0f3-08d8f36b31ab
x-ms-traffictypediagnostic: BYAPR12MB3413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB341352A15DE0CFF48E65E8BEFB7D9@BYAPR12MB3413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LaHTRFf+4ksf6h+yC0ldMZDpYAsPiofY70kg3fAirbq8+/G1EMeoQ1RuDUgkMJD/8uQAet49UW12tEJdjKwPijIWkS58gNX2DWpkw/g3q80fuT7qturtns1F0jdryB9tfBI9/g24fHjj/81WQzvryPLXspjgo1nSr3X3nGFJFEtcIGFGgTOHaoyaL18cqjPL8wqHxhBD+qan60ESG3eFM3ikEh49EQfi2shXw0p0hY3MzKkA5GQEUiTbqtCJd+48ExDGlT06TdT697ejwgslDwbfvt3X1148ldGcXjHs2gEhAR41mttiTKLfVfYLlhkAkCucdnZDjpC1QfQoKKX05UZLdjEO35YLbiKsUjydf5HYiJm4jUHnXkiF+cLDmKtK7l1yQU44pd7xrpH7Av/jj/FdZ7swm1qeeE0ur4eLtZcfzKe/thPsrfPsDc+lxa8pREOYNp17nQsDaWesXoZtCxKO/NGaRYGlwA4W7vjmri2OQRfZiXFreL+IYDGQYbmQnqZSr2d1e42GVOoD2dgdp8HOsoW4BNCXfdtvZ/tJWuer9INGWodmkOkrBeKGHBZ7e1t1HXtOgcJoY+WOm+bsn6gq93i2KukBSSu8JYoKEbWeVAboLWza7ZPLmWIODCbTWWB0CXXcObK1svp/5nSuTatR3/NxhXjdscoIRo5Yl315eBpuSXt0r1jLh5H3BACwmXYkssLNy700kfmn7Xw38OUB6He4Et54cRx2FCwOXHyI05STiLpBKNHt5708ttVSd2Htriqd2GNpYSB/2vjfbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(6506007)(8936002)(53546011)(966005)(71200400001)(8676002)(66556008)(316002)(55016002)(45080400002)(5660300002)(83380400001)(33656002)(52536014)(66476007)(66446008)(7696005)(2906002)(9686003)(110136005)(186003)(38100700001)(478600001)(66946007)(86362001)(4326008)(76116006)(64756008)(26005)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8CGPS/E9ZQJvktPL9t+QRg8OrVebELSpOlc+LnkQ/8/fWJGEgkfJhh9MT82v?=
 =?us-ascii?Q?s2yu/JgcfVcyWzxv2WFKINTYx8YgHLLFEnU9eAflhPLQHv5tIMW9TlsCkmTD?=
 =?us-ascii?Q?0XR0zezVnkZnnLbTU8dkwWTtALoItEVC2J9N45tHHQklkBMcqb4PPUnNhoN+?=
 =?us-ascii?Q?QxkZhA/CwJh7daj35hUlky8yWUg7u7eF0h8N8/QGAHBNmeLvjg9va+SOefxB?=
 =?us-ascii?Q?TpRjvq4vdzbjhbFDdD03gwd3DOTbWRZBqDhqKTGxiwHEGXzFIp8SbX4GNqMO?=
 =?us-ascii?Q?2dHo9KTGUV5GiysE1XlIbeLkz9vUbK9v88CWAEF+WzXUr+AJ2N4jgZVSLSml?=
 =?us-ascii?Q?MdYp4l3r5j4m0xnFDLDYoS4MQxEALx5X5zi507EJUb3RZbNaU5TQYgLNE5bC?=
 =?us-ascii?Q?xyB5ZeYfFj75ncCCmjKe9565IMoh1GfRpZGaGg+GF9adbPQtFgo4laCat+Gz?=
 =?us-ascii?Q?4YpZsM4Td/TliDusdKcH0Eoies7D09xovkpYY48nJcJt6Y/jab1/6mY+DltK?=
 =?us-ascii?Q?u4ntcfixD88z+ItJy+JDe0mPFhWqQlPZLhrGkmtMEPeV9nA6jsY6vIl0Es+K?=
 =?us-ascii?Q?Fji32qtxmv+Wd87jxoe0E/mog5MJifF+SYvd6OFWw2IrC5O7nYPoex1WqeeP?=
 =?us-ascii?Q?sBXBX2DnA8Sa/Dg3cHvYjL3EXqMhpdjcn5zeTNCLOvfjWE33nhuDUdg13UEq?=
 =?us-ascii?Q?4iCK2uYAmsB205vIueLY/a9uX078Ie2hCOcRI6Z4wMgcHNVqL16QT12eVryA?=
 =?us-ascii?Q?M1lPlxu5q6Up4hXBNz5YZxymg5JhqqEMH9I+NH0xjawmwixFILV0A36UxK7z?=
 =?us-ascii?Q?vlNV0Gg6YJCeYKiZnPnER3NROh7GLdrSHgzgW/Hh/N19RC7Cz+xDmJQ0FIWY?=
 =?us-ascii?Q?uMzMUTI9nAJ/wEOMEldL2yxHPU3U5/dChr/BfTQFlEYi1UTmS4Q+mO4EKpoj?=
 =?us-ascii?Q?VznDaRn87N7AcifCht2yq08BJFFAI93sB+8+KXvAtSw3Z2iJUzucrcmLd2fu?=
 =?us-ascii?Q?gSVwTBAQqf2M7N3U0wkAXQZoDoMlSR0EGgTfzk9+R/Pl1bn+iOtE8+oGZTwm?=
 =?us-ascii?Q?P8YR8Tj1odF+tzjEFE0Kn/SDZWrd8BFIB/rvxbmniKr8qENPIaYQPSkmmj3o?=
 =?us-ascii?Q?p301u8dPUfBLS8bX6dyF99sHWGKiKYDoMkSDqsc/kTyNB6+cLOy6J6j4y5/R?=
 =?us-ascii?Q?UmFhDt2pl/ty6n9QKAIZBu1x4hqSpuRkJfA4FTsv7O036SeUqLKYbbBVHHbP?=
 =?us-ascii?Q?mcQrNm2BENC6xX2ddQGqn0aRvXwQgNP+NkRK22ffz4Q1/P71F9NVwVlXqIn4?=
 =?us-ascii?Q?qpSn29Fm9rnxwLy5qbCvSww0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cecd05-60df-488b-f0f3-08d8f36b31ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 11:01:39.1318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j085FKot9yY9KjsShR+ZtLUU+4b+mbZq66yuDbrDJdBq3gVgFMPv7Yffd6YTOYvv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3413
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

This issue should occur on the hybrid s0i3 system which forces mem_sleep to deep level on the s0i3 enabled platform. We may need use the acpi_target_system_state() to identify the system target sleep level and then handle AMDGPU Sx[0..5] suspend/resume respectively.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Thanks,
Prike
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, March 30, 2021 1:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: check whether s2idle is enabled to determine
> s0ix
>
> For legacy S3, we need to use different handling in the driver.
> Suggested by Heiko Przybyl.
>
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitla
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
>  if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>  if (adev->flags & AMD_IS_APU)
> -return true;
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
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
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
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
