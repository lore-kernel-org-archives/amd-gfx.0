Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E86C12002
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 02:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9667760FE7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 02:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9667760FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F30D6E51A;
	Thu, 15 Jul 2021 02:52:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0BF6E51A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 02:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzR2hHCDZ/w+LPNM8OsxHRWJ2BSMvR2wPRndbALp8IFmukbZZhO6/tZzcoffc4q4BrEmhjSMeJfHU6kAaM9hQY3Uz5zi1pDUI2F5Msv6qQI0xMdGFDt+4+W6gbzHxb9vOfAeb/UvLWge5YVbDuVG8BbKokNFMqA/ggOwQKM7jheAYVGyQmGcYLNI/lY9xMedXZ2GGrrjFGo+SZU2c3NINJlfJULNlh4UMv0jZpTHq9nHBhkSqTzsPv29Hux6TpJ9S91oKwi72I4fmuhqnqwyaghDquWfUo1ka1CN1e/vUa6CCSWLBvXrZuQu6nrs+StyCx5MXPcNnHyF/5cMXHU1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YMnw+4Xru0+qaI5gs5/dMpMT/u+1cmq1eA6PD0MDuM=;
 b=fI93aVgkj8RlTWudcUlYwbvCzTifIQ3IYMDH39rgRwvEhVg7LEfY4j6T6AsQPPalRFBCWSi4WO2xu7Y+FYibtLfwbE/z+zvpXRh5vhHk6QaYQXTqna00e8/Kr/nE56UYm+yMXiUkCd65IfQBph5MlLuf0CmN8esELl9fsP+vkgAsSCrSGzCazDvjxmt3Jl9HueVqQi1bIuuzgVHKrnUXgSuLtgzP9EeRuwP7n6ksq4Vm6nqnkogvibnAaQFXqqb9GCeZJOG+TBF5Gf13ckJZqhGNGLDM+24ZeW117/iVIijEU0LsCdUq3lOTs2ILpLNMFsnDXOw3XvchG4Wkq67Kjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YMnw+4Xru0+qaI5gs5/dMpMT/u+1cmq1eA6PD0MDuM=;
 b=IdzDeskKDDmus64M9XQvd7dCAZUAfxsZE7A2wNMBaD3N3WFwj2kBSg0PAVi3OlmzN5nkxEkqYa5rfTg7EmttJGG/2ErLZGu0Q9u1Ocrv7tHbnhL3/MipfgNI7mAiDIXG/hdBCGGDv/DBHgw8IsD775vISVdiWIQUgm/aSglGLzs=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 02:51:54 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c%3]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 02:51:54 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zeng, Oak" <Oak.Zeng@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Fix a printing message
Thread-Topic: [PATCH 2/3] drm/amdgpu: Fix a printing message
Thread-Index: AQHXeMSN7iFzb4fhxUCvcPwEdg0/UKtCndGAgAC3YCA=
Date: Thu, 15 Jul 2021 02:51:53 +0000
Message-ID: <BY5PR12MB555790C9B5367DADD19AD75CEA129@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
 <1626276343-3552-3-git-send-email-Oak.Zeng@amd.com>
 <CADnq5_PE+K2eTtA7-RZqKuqc+8QhEm-v55Mbe8XdbhWeLevEwA@mail.gmail.com>
In-Reply-To: <CADnq5_PE+K2eTtA7-RZqKuqc+8QhEm-v55Mbe8XdbhWeLevEwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7b2848d8-1da2-43f9-bab2-2067a64de65d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-15T02:46:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08988eae-be36-4357-ccce-08d9473b80eb
x-ms-traffictypediagnostic: BY5PR12MB5544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5544EA0F32932D0E10AD5462EA129@BY5PR12MB5544.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TTcXMzQ/rWofAJAmMV0Gzq2+kxBaOMVNIKKv/FfS4JXae0lBISnumGsjMpmDazKlO0yC0y9JZVVilTcSEzydSxFcUFFNa6aKgzv1vD9gndcEApACec5YXeUn06h+gbupwaaG6Cgc7ASFPNMxKphlAfSGhfk+6XhkSOfCr6KD9xwXLPkol/KhX+g9Cox+/kFR02CgoarYump0rrKoP3CRVtTWKorzpbH+QiAsqODIJKCUlAcP3PXYBlQy3YJ5VepAWm0oh/lghz7ZOIYcpb67i5+J/JxbtmGVrJsNBROI9B9bwKNbd2H2OtuopPFPMj8MFL+Ciz9BpNPerRgXhWSr2WhsQO1QzqUBpjkwyN3qbbM4ZMMX/7InBt7jJEg5QbyBRq9Bh6Q24WceI8aw/iuQDFQLeX+YH88LAodWj2NYuLiblljsmSlmr6opUS5vfheOAdrZK/I1GIBRZJ351WrllGTIVxHm8Uhtr2Q6IGCK0KhC2kbxgJdvXnw/4RA/X+aN4vCu/xfHORaXhLzvI03t6zIVjcnB0USiugR+MwvmPHKOtvP9aEGteeIbg9XLWebKU4KIowOCf+H0n+URc2cugGwvXzaYF9WrwFQCW7hT9mvUN0nmb5XDhCanxxQv8FNCEJYK9WMFwrDMQfWZzqiJ39e6wFWP4CzHNIVZBeH80/RZPfvHpMK19wRRhGHu0KkvUrV+fPdssn3fBK6HdW+tG83YdLHB9PqRVDktbNffdygKJKxFYwgxmnRnS49NBWd8KoFhVYGIdzE8vkrfD9zoz0A2lajAtOHAINHOxWxoHDc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(45080400002)(316002)(86362001)(15650500001)(33656002)(6506007)(83380400001)(26005)(9686003)(4326008)(2906002)(38100700002)(122000001)(6636002)(478600001)(966005)(53546011)(186003)(71200400001)(110136005)(66476007)(66556008)(64756008)(66446008)(54906003)(76116006)(8936002)(66946007)(7696005)(55016002)(52536014)(8676002)(5660300002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dirjqMzNQoOzxY3cEYegNk8rgu/xQbe/YGSTDoEvlMzCKZIu5R2TSAwiSpaR?=
 =?us-ascii?Q?wqNUgchbjfJ5/l0ZTkZCKm9aLL5zuVNazk5Yz5vjOcY22IgE5Lh70+GXSX6n?=
 =?us-ascii?Q?vECXbwmwfTBIiyomxz49HyBxZp3bRdsfMOMKlcy2WTzDZMuMnQbO2gv0goo9?=
 =?us-ascii?Q?Xx0cbxX3jsZ3pTzsW8ws0i9UTsz0Hhxl9jhO5G+1i48wYmjwBblNKZfzP0nK?=
 =?us-ascii?Q?7j/RpsyznAW4fhJ5bqHuLeYN9g6Cqs0kJXNuCEaGWMcE3LdIxxUgbLNkiArM?=
 =?us-ascii?Q?Dd8PVVAGqhfqkW7OC1+EHur6VkFH7QWi0XQLE3zgfnu9Tps1Z+x5JoOE0Km1?=
 =?us-ascii?Q?LoiDyUlM5PUYZ3KjqkKjp5mV32xx/tw0xFwAjXVmvNOCniVWArCtelSGNZ74?=
 =?us-ascii?Q?cuG8tAW0JC5bMiqETAhlAoYm9qGOXX49CWRZ5Id4mf2OUxSOyRZudkGu3nGn?=
 =?us-ascii?Q?h25SdbgRzM/lnupLXLyQaf+hUFseP8jx06xQE/z+gBZxutg1lzUF1iJZ4nLF?=
 =?us-ascii?Q?8zhwD61l+fIG1DMxHPx4cb2o8HHo+3BVZLS/+nYypZbI0Gv14VXeDALCqPfg?=
 =?us-ascii?Q?ethhpnTMQ4GIuHr539R4YBCQab0VasGdLg23e7iF/r3WI9N2J6KiWvhjwmam?=
 =?us-ascii?Q?F0qNXTQ+4Bw1QB9i+U3W301PRi+f6U5AhCA6CDXGj+t+RRl0mkgbJtnowYQw?=
 =?us-ascii?Q?CtjrHNW9a12kG5GtJV77Gyrx9mJbrzX1W/8p1iJ434N15zm1P4n2viiVgTft?=
 =?us-ascii?Q?k2X6ZZqtkUkkNhZRmXGPFrFtx027IQrX7jwhFgIPSCebvGwdQvA2xtWZkJX9?=
 =?us-ascii?Q?27VA0AnIQR5cZcFhwrNuNNnrON1nMAW48MhDO5fMZviOdLZZ8L5knDlVKHJo?=
 =?us-ascii?Q?mXLE73YQHpC/KLUfYaPHcabOarKB278kkPAE9oymEBqTpoL/5VJHCBGse1vE?=
 =?us-ascii?Q?d4kY65edQ15hL259viocTOs28nLtS9fHFRdUp7PJ+79wiTyYYFyne8DwQvpp?=
 =?us-ascii?Q?PDXyc+B/6hI4nL8AQZWoSwdGE/0A+alXcnXsHXzJfLlbfph7KsE/B9FNXqRD?=
 =?us-ascii?Q?euTXV5E2tfOEbPG1LxAXcwUDxA5ZYzcdOilGPw9bP5LwAxNlV34ITDYs8MNC?=
 =?us-ascii?Q?dce1W9SlS9yg5J9+T0BLbmnFo0ZhUiZRcnJ+3+Sq3ChYU7xlw5dX8mDxjHze?=
 =?us-ascii?Q?QacPTiq8/VBalHPjYQKn7ar8al2VYGUcFlJPaLuur4aF8RxhcjV6PTkZpdUh?=
 =?us-ascii?Q?3l5nhbFixxd5p4mDVXIf4aVaERgTrcPYyCdHWhy8zXcbnyUVayFCQj8QyUGp?=
 =?us-ascii?Q?kbzoqA5kvwqqn9qEwybRr/Bz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08988eae-be36-4357-ccce-08d9473b80eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 02:51:53.9373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYI4HnkA5YB+0cf8Di6Cra8qlMySnz4XSivFrUyIHx6HJMDbvPAR73XJP3ePgtHsBHrHi9OR6DzxrtT4dpcCFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5544
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Alex,
Is DRM_DEV_INFO more suitable than dev_info as far as DRM subsystem is concerned? Thanks!

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, July 14, 2021 11:48 PM
To: Zeng, Oak <Oak.Zeng@amd.com>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Leo <Leo.Liu@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message

On Wed, Jul 14, 2021 at 11:25 AM Oak Zeng <Oak.Zeng@amd.com> wrote:
>
> The printing message "PSP loading VCN firmware" is mis-leading because
> people might think driver is loading VCN firmware. Actually when this
> message is printed, driver is just preparing some VCN ucode, not
> loading VCN firmware yet. The actual VCN firmware loading will be in
> the PSP block hw_init. Fix the printing message
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 284bb42..1f8e902 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)
>                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
>                 adev->firmware.fw_size +=
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 1.0: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8af567c..ebe4f2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)
>                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
>                 adev->firmware.fw_size +=
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 2.0: Will use PSP to load VCN
> + firmware\n");

While you are here, switch to dev_info() so we get the device information in the output (in case we have multiple GPUs in a system).

Alex

>         }
>
>         r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 888b17d..5741504 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)
>                         adev->firmware.fw_size +=
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>                 }
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 2.5: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r = amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c3580de..b81eae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)
>                         adev->firmware.fw_size +=
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>                 }
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 3.0: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r = amdgpu_vcn_resume(adev);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJi
> ansong.Chen%40amd.com%7C051da5b064d944f4c0a908d946ded869%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637618745208108548%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=WpGaXXjVSQEjcRgg0E%2FUjRMZT%2FDRe05nwG6xiDJjRbk%3D&
> amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C051da5b064d944f4c0a908d946ded869%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618745208108548%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WpGaXXjVSQEjcRgg0E%2FUjRMZT%2FDRe05nwG6xiDJjRbk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
