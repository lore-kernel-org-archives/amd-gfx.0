Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE0CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 15:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875C8206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 15:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hdqhrxtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875C8206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543076E0CD;
	Fri, 22 May 2020 15:43:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0DF6E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 15:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBgRHsguguY0uCXDBDA/U9oco1WMKNuJWS1vgeOeADEqVNDvEOlnZFa9CPk3FvRyBNmn7r9gSqhYfbiCo+5ZGWySAxR1V6DhtVbaExnhF/zj5vNe3ZNvWbgLbSghIg2EfI92rYrCLuQIWMZ6AS6YEk1MALeaQOe7sRedl1zYaAXoQZDr4MQpigziVHqDHBmUDCf4a5gnaGqeRSbFl5YQ9diRPcGx/2l11pYe5hl9Mrd9giwZjZQs208F6425AArcofRQpaYVNMkD7tyULSYcQIf+KGc15dJ4um2mQtHcUgB9kBpzilgcfhB2EXTOVgP4nzmfWni3HdxmFieT4ii1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXIbeSOUEupRQ1dq12gLolhf5OEfkvPtue3z2JzqcrI=;
 b=MiHdi56bxdC4c9TsSMqcPxIB9KC+1jsicUK/MV898FbbGcrhykBqICn1ljtjvrqg0tS6uIA6aO/VSdXQ8LBxFRAPHij+eWg/MgfviGHlg5WigVe4yd2GOs5Hyeki5/Jm/+QQ5K/ovIyM7evkhpM3isdPi1DLa2ozgJF3gsqC8TBYYtdyNIWcXfECavRbejrFBVEl+k8NvQvH2nKBmiwpHx7SzbSavQplIs5qZJY3F+STb4ROasOcxnl1cmc+Rtuub+owP4epCs/D75r18+KFlwhgD4PzkSoDaD9bAaHtf0+Ncj8nINQB6dUp38E6D/d9qDMwkFUieMWopEQGHuommA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXIbeSOUEupRQ1dq12gLolhf5OEfkvPtue3z2JzqcrI=;
 b=hdqhrxtmmXCpnbXYmzFwsv5iNK30cUfBkZRzGitzd8EmPRWHT+eBdgoXn17d8UZBFzJyF+kQUMcGF1ByKCrPyF8JfxS4YrLn2aH/FJ1JQGv5NtqUaImugksJ5eS2ttMe4zFS/XM9yM0KAgG0A1Cj0FHaUEu/d6EE/bNKDEGTI6A=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB3714.namprd12.prod.outlook.com (2603:10b6:a03:1a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 15:43:29 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 15:43:29 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix device attribute node create failed with
 multi gpu
Thread-Topic: [PATCH] drm/amdgpu: fix device attribute node create failed with
 multi gpu
Thread-Index: AQHWMElHqh5t2RFE7U6tnOJQSxQlHqi0N0eAgAAHJ5I=
Date: Fri, 22 May 2020 15:43:29 +0000
Message-ID: <BY5PR12MB406872EAD6071B22BE3614F8A2B40@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200522145758.13348-1-kevin1.wang@amd.com>,
 <CADnq5_NxA08DUs_3OXj1Qp3fV_0s30i9TerqH=URcrh0PAQ2-g@mail.gmail.com>
In-Reply-To: <CADnq5_NxA08DUs_3OXj1Qp3fV_0s30i9TerqH=URcrh0PAQ2-g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T15:43:30.440Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b93d0cd-ca40-46f5-72a1-08d7fe66e020
x-ms-traffictypediagnostic: BY5PR12MB3714:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3714AC80B40EBBD7F06A3A3FA2B40@BY5PR12MB3714.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1N4o8UhLQlHBN3FZr19YS7r7leswpoWJoOjw/4QRD8x5AFvEKiNh+8GxzaMfeNGzi8eATwb780/umJpVnRrdioapBnCZC52XJu6c497uP9dYQ3nvO0QH24R7gINfQx7d9RJTeqNPbXbtbUKf0Z6m7tdhPzBNko+JQ7Igrz5p7arHCp3l+6AW7BU//iz+HW3juRxhYFl2UWSOhrgG+GswaEBWtRQhBsu8sjptfaI4mAqER9qC4Jbl4PKOGLlh0uLdNJarSws4UL+Kxvlu1503oyCTSWEOZp7rLMS78Tp7dIfk+u9WUOW2ZqwxzP85ik/+nn2j2GluJzRz+ncquCxqyaty165OjuGpyvzyKQpuFzA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(19627405001)(66946007)(45080400002)(26005)(54906003)(71200400001)(5660300002)(86362001)(966005)(8936002)(478600001)(30864003)(8676002)(66476007)(76116006)(66556008)(91956017)(66446008)(316002)(33656002)(52536014)(55016002)(53546011)(2906002)(4326008)(186003)(166002)(9686003)(7696005)(64756008)(6916009)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SSAtD+6JzPuQjRHSRw7zFBWi05Dzd1yuxbkByvFih+s1SzBEVzKowa9PppoqMIhgvD5LdEf/nWbMI2DMMD83DAhlgxL3XbnP9SDzESVsM74d9sdxk5soNMOTXXunh2QalqSFyLMjVuEzTdJKAHt90wm0JnVz/7cCw5hkKqBgeESPhSMewx1M/Az+o/l9zRhfaGCgmiNkYQL3gnzsjn73eqayOMKTe6urcHBYjo65Cs2qWgTQlN216ydA7rZPY9vGqcToXlYSnjnK3OzNiU6RZHWvanrxKq/dB85VF+RBnsPD4RRNQMW3Ss2N8tRVJ7uOYaqErIKjfe62tDasEHBy4icXrPepd+JLg8rGD6lht2AFMCuEScI5M0zuDs+JCe9Loekd4KLpXRnCliCXjpAvLEZQYhv8uXecUQTsyAQqXCgyEOlj6PLcKgv5pySi6wsrrCKGF/NXzc1afgLUPQGBI90lVK8cpu41V50j5BSJx5kba2AxQF1Q6yiT1cVynUid
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b93d0cd-ca40-46f5-72a1-08d7fe66e020
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 15:43:29.4674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zB4D6HgvykIeMkBLC8CeWsjCmCJqVwd19PUpx98WL5eeisOMFmV2Q5jxPmYk+jlS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3714
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1560109615=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1560109615==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB406872EAD6071B22BE3614F8A2B40BY5PR12MB4068namp_"

--_000_BY5PR12MB406872EAD6071B22BE3614F8A2B40BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Friday, May 22, 2020 11:16 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix device attribute node create failed wi=
th multi gpu

On Fri, May 22, 2020 at 10:57 AM Kevin Wang <kevin1.wang@amd.com> wrote:
>
> the origin design will use varible of "attr->states" to save node
> supported states on current gpu device, but for multi gpu device, when
> probe second gpu device, the driver will check attribute node states
> from previous gpu device wthether to create attribute node.
> it will cause other gpu device create attribute node faild.
>
> 1. add member attr_list into amdgpu_device to link supported device attri=
bute node.
> 2. add new structure "struct amdgpu_device_attr_entry{}" to track device =
attribute state.
>
> fix:
> drm/amdgpu: optimize amdgpu device attribute code
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 75 +++++++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h | 13 +++--
>  3 files changed, 52 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index bfce0931f9c1..b84146339ea3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -995,6 +995,7 @@ struct amdgpu_device {
>         char                            serial[16];
>
>         struct amdgpu_autodump          autodump;
> +       struct list_head                attr_list;

Might want to call this pm_attr_list or even move this to the
amdgpu_pm struct, but either way, assuming you've tested this with
multiple GPUs:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


[kevin]:
thanks,  the patch v2 will fix it.
and this patch is test passed on local witl multi gpu.

>  };
>
>  static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device=
 *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.c
> index 55815b899942..ac99aa0a16a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1725,7 +1725,7 @@ static struct amdgpu_device_attr amdgpu_device_attr=
s[] =3D {
>  };
>
>  static int default_attr_update(struct amdgpu_device *adev, struct amdgpu=
_device_attr *attr,
> -                              uint32_t mask)
> +                              uint32_t mask, enum amdgpu_device_attr_sta=
tes *states)
>  {
>         struct device_attribute *dev_attr =3D &attr->dev_attr;
>         const char *attr_name =3D dev_attr->attr.name;
> @@ -1733,7 +1733,7 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
>         enum amd_asic_type asic_type =3D adev->asic_type;
>
>         if (!(attr->flags & mask)) {
> -               attr->states =3D ATTR_STATE_UNSUPPORTED;
> +               *states =3D ATTR_STATE_UNSUPPORTED;
>                 return 0;
>         }
>
> @@ -1741,34 +1741,34 @@ static int default_attr_update(struct amdgpu_devi=
ce *adev, struct amdgpu_device_
>
>         if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>                 if (asic_type <=3D CHIP_VEGA10)
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>                 if (asic_type <=3D CHIP_VEGA10 || asic_type =3D=3D CHIP_A=
RCTURUS)
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>                 if (asic_type < CHIP_VEGA20)
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
>                 if (asic_type =3D=3D CHIP_ARCTURUS)
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
> -               attr->states =3D ATTR_STATE_UNSUPPORTED;
> +               *states =3D ATTR_STATE_UNSUPPORTED;
>                 if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
>                     (!is_support_sw_smu(adev) && hwmgr->od_enabled))
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>                 if (adev->flags & AMD_IS_APU || asic_type =3D=3D CHIP_VEG=
A10)
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pcie_bw)) {
>                 /* PCIe Perf counters won't work on APU nodes */
>                 if (adev->flags & AMD_IS_APU)
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(unique_id)) {
>                 if (!adev->unique_id)
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_features)) {
>                 if (adev->flags & AMD_IS_APU || asic_type <=3D CHIP_VEGA1=
0)
> -                       attr->states =3D ATTR_STATE_UNSUPPORTED;
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
>         }
>
>         if (asic_type =3D=3D CHIP_ARCTURUS) {
> @@ -1794,22 +1794,24 @@ static int amdgpu_device_attr_create(struct amdgp=
u_device *adev,
>         int ret =3D 0;
>         struct device_attribute *dev_attr =3D &attr->dev_attr;
>         const char *name =3D dev_attr->attr.name;
> +       enum amdgpu_device_attr_states attr_states =3D ATTR_STATE_SUPPORT=
ED;
> +       struct amdgpu_device_attr_entry *attr_entry;
> +
>         int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_devi=
ce_attr *attr,
> -                          uint32_t mask) =3D default_attr_update;
> +                          uint32_t mask, enum amdgpu_device_attr_states =
*states) =3D default_attr_update;
>
>         BUG_ON(!attr);
>
>         attr_update =3D attr->attr_update ? attr_update : default_attr_up=
date;
>
> -       ret =3D attr_update(adev, attr, mask);
> +       ret =3D attr_update(adev, attr, mask, &attr_states);
>         if (ret) {
>                 dev_err(adev->dev, "failed to update device file %s, ret =
=3D %d\n",
>                         name, ret);
>                 return ret;
>         }
>
> -       /* the attr->states maybe changed after call attr->attr_update fu=
nction */
> -       if (attr->states =3D=3D ATTR_STATE_UNSUPPORTED)
> +       if (attr_states =3D=3D ATTR_STATE_UNSUPPORTED)
>                 return 0;
>
>         ret =3D device_create_file(adev->dev, dev_attr);
> @@ -1818,7 +1820,14 @@ static int amdgpu_device_attr_create(struct amdgpu=
_device *adev,
>                         name, ret);
>         }
>
> -       attr->states =3D ATTR_STATE_SUPPORTED;
> +       attr_entry =3D kmalloc(sizeof(*attr_entry), GFP_KERNEL);
> +       if (!attr_entry)
> +               return -ENOMEM;
> +
> +       attr_entry->attr =3D attr;
> +       INIT_LIST_HEAD(&attr_entry->entry);
> +
> +       list_add_tail(&attr_entry->entry, &adev->attr_list);
>
>         return ret;
>  }
> @@ -1827,14 +1836,12 @@ static void amdgpu_device_attr_remove(struct amdg=
pu_device *adev, struct amdgpu_
>  {
>         struct device_attribute *dev_attr =3D &attr->dev_attr;
>
> -       if (attr->states =3D=3D ATTR_STATE_UNSUPPORTED)
> -               return;
> -
>         device_remove_file(adev->dev, dev_attr);
> -
> -       attr->states =3D ATTR_STATE_UNSUPPORTED;
>  }
>
> +static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
> +                                            struct list_head *attr_list)=
;
> +
>  static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
>                                             struct amdgpu_device_attr *at=
trs,
>                                             uint32_t counts,
> @@ -1852,20 +1859,24 @@ static int amdgpu_device_attr_create_groups(struc=
t amdgpu_device *adev,
>         return 0;
>
>  failed:
> -       while (i--)
> -               amdgpu_device_attr_remove(adev, &attrs[i]);
> +       amdgpu_device_attr_remove_groups(adev, &adev->attr_list);
>
>         return ret;
>  }
>
>  static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
> -                                            struct amdgpu_device_attr *a=
ttrs,
> -                                            uint32_t counts)
> +                                            struct list_head *attr_list)
>  {
> -       uint32_t i =3D 0;
> +       struct amdgpu_device_attr_entry *entry, *entry_tmp;
>
> -       for (i =3D 0; i < counts; i++)
> -               amdgpu_device_attr_remove(adev, &attrs[i]);
> +       if (list_empty(&adev->attr_list))
> +               return ;
> +
> +       list_for_each_entry_safe(entry, entry_tmp, attr_list, entry) {
> +               amdgpu_device_attr_remove(adev, entry->attr);
> +               list_del(&entry->entry);
> +               kfree(entry);
> +       }
>  }
>
>  static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
> @@ -3276,6 +3287,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev=
)
>         if (adev->pm.dpm_enabled =3D=3D 0)
>                 return 0;
>
> +       INIT_LIST_HEAD(&adev->attr_list);
> +
>         adev->pm.int_hwmon_dev =3D hwmon_device_register_with_groups(adev=
->dev,
>                                                                    DRIVER=
_NAME, adev,
>                                                                    hwmon_=
groups);
> @@ -3319,9 +3332,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *ade=
v)
>         if (adev->pm.int_hwmon_dev)
>                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
>
> -       amdgpu_device_attr_remove_groups(adev,
> -                                        amdgpu_device_attrs,
> -                                        ARRAY_SIZE(amdgpu_device_attrs))=
;
> +       amdgpu_device_attr_remove_groups(adev, &adev->attr_list);
>  }
>
>  void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.h
> index 48e8086baf33..d9ae2b49a402 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> @@ -47,10 +47,14 @@ enum amdgpu_device_attr_states {
>  struct amdgpu_device_attr {
>         struct device_attribute dev_attr;
>         enum amdgpu_device_attr_flags flags;
> -       enum amdgpu_device_attr_states states;
> -       int (*attr_update)(struct amdgpu_device *adev,
> -                          struct amdgpu_device_attr* attr,
> -                          uint32_t mask);
> +       int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_devi=
ce_attr *attr,
> +                          uint32_t mask, enum amdgpu_device_attr_states =
*states);
> +
> +};
> +
> +struct amdgpu_device_attr_entry {
> +       struct list_head entry;
> +       struct amdgpu_device_attr *attr;
>  };
>
>  #define to_amdgpu_device_attr(_dev_attr) \
> @@ -59,7 +63,6 @@ struct amdgpu_device_attr {
>  #define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...) \
>         { .dev_attr =3D __ATTR(_name, _mode, _show, _store),             =
 \
>           .flags =3D _flags,                                             =
 \
> -         .states =3D ATTR_STATE_SUPPORTED,                              =
         \
>           ##__VA_ARGS__, }
>
>  #define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)                  \
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Ckevin1=
.wang%40amd.com%7Cdd2ce58bbf7f4cbc34c408d7fe6317d8%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637257573884409063&amp;sdata=3D%2FYecffjaMNwPS%2BU0QM%=
2BWkQ%2BmVBDFP9pw3eYE%2FBgfU60%3D&amp;reserved=3D0

--_000_BY5PR12MB406872EAD6071B22BE3614F8A2B40BY5PR12MB4068namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Friday, May 22, 2020 11:16 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix device attribute node create fa=
iled with multi gpu</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Fri, May 22, 2020 at 10:57 AM Kevin Wang &lt;ke=
vin1.wang@amd.com&gt; wrote:<br>
&gt;<br>
&gt; the origin design will use varible of &quot;attr-&gt;states&quot; to s=
ave node<br>
&gt; supported states on current gpu device, but for multi gpu device, when=
<br>
&gt; probe second gpu device, the driver will check attribute node states<b=
r>
&gt; from previous gpu device wthether to create attribute node.<br>
&gt; it will cause other gpu device create attribute node faild.<br>
&gt;<br>
&gt; 1. add member attr_list into amdgpu_device to link supported device at=
tribute node.<br>
&gt; 2. add new structure &quot;struct amdgpu_device_attr_entry{}&quot; to =
track device attribute state.<br>
&gt;<br>
&gt; fix:<br>
&gt; drm/amdgpu: optimize amdgpu device attribute code<br>
&gt;<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 =
&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 75 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h | 13 &#43;&#43;&#43;--<br=
>
&gt;&nbsp; 3 files changed, 52 insertions(&#43;), 37 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index bfce0931f9c1..b84146339ea3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -995,6 &#43;995,7 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seria=
l[16];<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr_list;<br>
<br>
Might want to call this pm_attr_list or even move this to the<br>
amdgpu_pm struct, but either way, assuming you've tested this with<br>
multiple GPUs:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
<br>
[kevin]:</div>
<div class=3D"PlainText">thanks,&nbsp; the patch v2 will fix it.&nbsp;</div=
>
<div class=3D"PlainText">and this patch is test passed on local witl multi =
gpu.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_b=
o_device *bdev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<br>
&gt; index 55815b899942..ac99aa0a16a8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -1725,7 &#43;1725,7 @@ static struct amdgpu_device_attr amdgpu_devi=
ce_attrs[] =3D {<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static int default_attr_update(struct amdgpu_device *adev, struc=
t amdgpu_device_attr *attr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask, enum amdgpu_device_attr_s=
tates *states)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribut=
e *dev_attr =3D &amp;attr-&gt;dev_attr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *attr_name =
=3D dev_attr-&gt;attr.name;<br>
&gt; @@ -1733,7 &#43;1733,7 @@ static int default_attr_update(struct amdgpu=
_device *adev, struct amdgpu_device_<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_asic_type asi=
c_type =3D adev-&gt;asic_type;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(attr-&gt;flags &=
amp; mask)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; attr-&gt;states =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *states =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -1741,34 &#43;1741,34 @@ static int default_attr_update(struct amdg=
pu_device *adev, struct amdgpu_device_<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_=
dpm_socclk)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type &lt;=3D CHIP_VEGA10)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR=
_IS(pp_dpm_dcefclk)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type &lt;=3D CHIP_VEGA10 || asic_type =
=3D=3D CHIP_ARCTURUS)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR=
_IS(pp_dpm_fclk)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type &lt; CHIP_VEGA20)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR=
_IS(pp_dpm_pcie)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type =3D=3D CHIP_ARCTURUS)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR=
_IS(pp_od_clk_voltage)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; attr-&gt;states =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *states =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if ((is_support_sw_smu(adev) &amp;&amp; adev-&gt;=
smu.od_enabled) ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!is_support_sw_smu(adev)=
 &amp;&amp; hwmgr-&gt;od_enabled))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR=
_IS(mem_busy_percent)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || asic_type =
=3D=3D CHIP_VEGA10)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR=
_IS(pcie_bw)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* PCIe Perf counters won't work on APU nodes */<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR=
_IS(unique_id)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;unique_id)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR=
_IS(pp_features)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || asic_type =
&lt;=3D CHIP_VEGA10)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;st=
ates =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type =3D=3D C=
HIP_ARCTURUS) {<br>
&gt; @@ -1794,22 &#43;1794,24 @@ static int amdgpu_device_attr_create(struc=
t amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribut=
e *dev_attr =3D &amp;attr-&gt;dev_attr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name =3D d=
ev_attr-&gt;attr.name;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_device_attr_stat=
es attr_states =3D ATTR_STATE_SUPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_attr_en=
try *attr_entry;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*attr_update)(str=
uct amdgpu_device *adev, struct amdgpu_device_attr *attr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t mask) =3D default_attr_update;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t mask, enum amdgpu_device_attr_states *states) =3D defau=
lt_attr_update;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!attr);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_update =3D attr-&=
gt;attr_update ? attr_update : default_attr_update;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D attr_update(adev, attr, =
mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D attr_update(adev, at=
tr, mask, &amp;attr_states);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;failed to update devi=
ce file %s, ret =3D %d\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n=
ame, ret);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the attr-&gt;states maybe cha=
nged after call attr-&gt;attr_update function */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attr-&gt;states =3D=3D ATTR_=
STATE_UNSUPPORTED)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attr_states =3D=3D ATTR_=
STATE_UNSUPPORTED)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_=
file(adev-&gt;dev, dev_attr);<br>
&gt; @@ -1818,7 &#43;1820,14 @@ static int amdgpu_device_attr_create(struct=
 amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n=
ame, ret);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;states =3D ATTR_STATE_S=
UPPORTED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_entry =3D kmalloc(sizeo=
f(*attr_entry), GFP_KERNEL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!attr_entry)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_entry-&gt;attr =3D attr=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;attr_ent=
ry-&gt;entry);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;attr_entr=
y-&gt;entry, &amp;adev-&gt;attr_list);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; @@ -1827,14 &#43;1836,12 @@ static void amdgpu_device_attr_remove(stru=
ct amdgpu_device *adev, struct amdgpu_<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribut=
e *dev_attr =3D &amp;attr-&gt;dev_attr;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attr-&gt;states =3D=3D ATTR_=
STATE_UNSUPPORTED)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(ade=
v-&gt;dev, dev_attr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr-&gt;states =3D ATTR_STATE_U=
NSUPPORTED;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static void amdgpu_device_attr_remove_groups(struct amdgpu_device=
 *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *attr_list);<b=
r>
&gt; &#43;<br>
&gt;&nbsp; static int amdgpu_device_attr_create_groups(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_attr *attr=
s,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t counts,<br>
&gt; @@ -1852,20 &#43;1859,24 @@ static int amdgpu_device_attr_create_group=
s(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt;&nbsp; failed:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i--)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_attr_remove(adev, &amp;attrs[i]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_attr_remove_gr=
oups(adev, &amp;adev-&gt;attr_list);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; static void amdgpu_device_attr_remove_groups(struct amdgpu_devic=
e *adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_attr *attrs,<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t counts)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *attr_list)<br=
>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_attr_en=
try *entry, *entry_tmp;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; counts; i&#=
43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_attr_remove(adev, &amp;attrs[i]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;adev-&gt=
;attr_list))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(ent=
ry, entry_tmp, attr_list, entry) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_device_attr_remove(adev, entry-&gt;attr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; list_del(&amp;entry-&gt;entry);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfree(entry);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; static ssize_t amdgpu_hwmon_show_temp(struct device *dev,<br>
&gt; @@ -3276,6 &#43;3287,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_en=
abled =3D=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;adev-&gt=
;attr_list);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.int_hwmon_=
dev =3D hwmon_device_register_with_groups(adev-&gt;dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_NAME, adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmon_groups);<br>
&gt; @@ -3319,9 &#43;3332,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.int_hw=
mon_dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmon_device_unregister(adev-&gt;pm.int_hwmon_dev=
);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_attr_remove_groups=
(adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_attrs,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ARRAY_SIZE(amdgpu_device_attrs));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_attr_remove_gr=
oups(adev, &amp;adev-&gt;attr_list);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.h<br>
&gt; index 48e8086baf33..d9ae2b49a402 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h<br>
&gt; @@ -47,10 &#43;47,14 @@ enum amdgpu_device_attr_states {<br>
&gt;&nbsp; struct amdgpu_device_attr {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribut=
e dev_attr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_device_att=
r_flags flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_device_attr_states s=
tates;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*attr_update)(struct amdgpu=
_device *adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amdgpu_device_attr* attr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*attr_update)(struct am=
dgpu_device *adev, struct amdgpu_device_attr *attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t mask, enum amdgpu_device_attr_states *states);<br>
&gt; &#43;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;struct amdgpu_device_attr_entry {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head entry;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_attr *a=
ttr;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; #define to_amdgpu_device_attr(_dev_attr) \<br>
&gt; @@ -59,7 &#43;63,6 @@ struct amdgpu_device_attr {<br>
&gt;&nbsp; #define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags=
, ...) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .dev_attr =3D __ATTR=
(_name, _mode, _show, _store),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D=
 _flags,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .states =3D ATTR_STA=
TE_SUPPORTED,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ##__VA_ARG=
S__, }<br>
&gt;<br>
&gt;&nbsp; #define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; \<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D02%7C01%7Ckevin1.wang%40amd.com%7Cdd2ce58bbf7f4cbc34c408d7fe6317d8%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257573884409063&amp;amp;sdata=3D=
%2FYecffjaMNwPS%2BU0QM%2BWkQ%2BmVBDFP9pw3eYE%2FBgfU60%3D&amp;amp;reserved=
=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Ckevi=
n1.wang%40amd.com%7Cdd2ce58bbf7f4cbc34c408d7fe6317d8%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637257573884409063&amp;amp;sdata=3D%2FYecffjaMNwPS%2=
BU0QM%2BWkQ%2BmVBDFP9pw3eYE%2FBgfU60%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB406872EAD6071B22BE3614F8A2B40BY5PR12MB4068namp_--

--===============1560109615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1560109615==--
