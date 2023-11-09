Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D86C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 21:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE9810E923;
	Thu,  9 Nov 2023 21:46:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A56F10E925
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 21:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW0+tpipcRHgcdkc9mruEkuTXRY+LZOawyrKFJapnv8oqY4zYmBJTyojdrNj8wKyG81q+ANiG/32bTFl29y7/ZwDS3Ctr+0ZaWokZMeXbPnYD39pgVd1YGTKwHpAlPMsiPN2GUhDpDwZua6OOCsz3JoZkyNSmbaxyS3Yd71Xq6BxiTHN1nOT7VHyO+MgrzuZdBPTNkGdkIKLQprD2Qruew8NXby2OpxoswOVbl9bDgh+J79+4OwH39y1mzBvD6Lhqf+3n5DRETV/xL/NViAu62GMBoGf3uXQrVWtAxGtLgTkj9WYLo2Cr3ttl8VN3dbhh9QqPMakk+DOgfiI3gEzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX1lv01QNZUhnCH/m//AcQti8MG+j3FJ0cmf4DoRzcQ=;
 b=gMeJ6hFxjiuAeyZDYDJJGRMrZ5MYY6OOhk42ieJqQZ4vXqsMFoBib58QQ7AC3LxFKTwHsFFhxzQ5IdvwMpb6XyV9GGyOrbEV3DFEdgjoiAoOZb5S4dzFaSuBX+cUTHU+CbfhuvyvFDyhvkRT6WsPQW6Vc6dGl035313xPkAibfCilvFs7FEzo2eBWrk8L8qzHYlyHUTAh2yK5DNdB4/J/WrZSybu16qaVRtLTzOPfu1uwoyY9FbI7aeKtxUUpVPVU3txQ3N5+oS4YL7YM8V1nHkdujFbe5UcD2p6bcS7ZY1hWiqmbDB2A8Bml0GCyB+WfaLFfqvEFMdeeGql92wKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX1lv01QNZUhnCH/m//AcQti8MG+j3FJ0cmf4DoRzcQ=;
 b=2zA6EVyGkh3uJ6ShKqbDWLPWXxek0ntw0wZh0qYq6cUkZO5CfFRIP837W0+o4he0ItDSFz8JHXzlWRTNe1ZPhMl0TVY/8pnXHXSoxy6mrI4Akw7ZlPRH6GEf0lNsHUoyc4V8F2MVnaklQxQy+XzsdZJIdUks2NTRzorS/FfsJMY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 21:45:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 21:45:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime dereference
 usage count
Thread-Topic: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime dereference
 usage count
Thread-Index: AQHaEt+Q0McnWCCUQUy5sqIrQH8vWbByhYgw
Date: Thu, 9 Nov 2023 21:45:54 +0000
Message-ID: <BL1PR12MB5144F2D77CE97D32889DCBFCF7AFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231109073701.1751965-1-Prike.Liang@amd.com>
In-Reply-To: <20231109073701.1751965-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0c436cc2-2509-4ec2-baa6-315f7410e2d9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-09T21:42:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV8PR12MB9205:EE_
x-ms-office365-filtering-correlation-id: cdd7c1e0-1956-4df0-df4a-08dbe16d3fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/biiAglP5kWDrl1Rvncz7f8vzG5h4ibQmpMbDWop860/I0cE7hTEuDGEIJsoYp0bm4H6mq17v0NrP2B1QAumgI67tuYrF9f33ELhdOeh6YZh1cRgcgrQ5LFgf8/VQJt2K/ISoxlZRqcn4JeENhdJXDX8bRUDtHXaTrPzLXdchQNkuXMN15pAH+oJ6UKKs/1W29Os4V5O81JIYgt7uFHARk9Vr4zBcNAOoYTSYeF3qa00NJm6F4OmNrgTPRcfbjR7oK5aZK7b2hNjCJNY1mqy4Rx+2j8xN06hthr0KFTN36vXrMR8rYyRy20Fez1xpbvfHJvBgakfwQglhp1gHKN1LMDdanuaQnf3p/c1UAJa4VFJBEAZC2MT037fBEH09yaMhqgULMtMA7r7Q8A3ZKehhOgE7fPiAN1sNwUCJTDTEaABWo0Xj1k31gLbYhx/v4nI3J86n3Iy/8FpF5B6tAuyhlQ7JhnOudvXB7gfxV1BdoourHoCG3Nft3cYoDdDrbulzs54bY9muk1vkjVdpwIvpZkAPoDtrqS21qWxrOcYKhc+W+gjOdg0FnWpXnaWwFeBeU9p6RUF5DlEQ1UdRi1xSxt2LGJviZ8G+wQIse0E7nQkC2ieXKHEI7B85RVB2Cz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(52536014)(2906002)(41300700001)(5660300002)(478600001)(8936002)(8676002)(55016003)(66556008)(66946007)(66446008)(66476007)(110136005)(316002)(26005)(7696005)(76116006)(64756008)(86362001)(122000001)(71200400001)(9686003)(38100700002)(6506007)(38070700009)(53546011)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KSl290K39LjAWptF3zIIP7pdd1LeZylgNYJeiqBMSKfGroIqVY27Go4atGQG?=
 =?us-ascii?Q?6al3FrEW3f8GP684pmai9pHGx7E9flN8XJlPUZfEvIjL8CTKbR12EIelUzQl?=
 =?us-ascii?Q?pUs7a4oPN8juFvfFgIEf85Qfs42oaqjKOez3ywh/TTAT9iXKPyUXehNErEp2?=
 =?us-ascii?Q?r0E6UBdpbh89TE9Y/EXiQYl1QgEC/gEXmczl3G1tRSXiFEs9cRFPNFwAaLTm?=
 =?us-ascii?Q?DBjaVLXj0fbJPufJdCVPlQqXH26FRY8WvfOVfV9ND9k0exgfmIRdXiIukpVy?=
 =?us-ascii?Q?mxpRH0pHfrlqMGAHkXsTQ2zCVS9B9FPE1gjwivw6KKZl4ise09hcPy96ZmMv?=
 =?us-ascii?Q?23GBwlZjxJl8UmJy5GAYRlCW91qL/w1uSY7msSXf4MuXNCFN4F05HJM8QKGB?=
 =?us-ascii?Q?FwDlwn7ZS9meKfuKvAfW9QDbzoheWkNS4hSR9XoWkYG1KgWirOjYXKFHjLNQ?=
 =?us-ascii?Q?tAfztXpxJFFa9iAAOi6j0AcAlvPfefn8Urv7SJpjKA+seAcV7aaaUNwtpRqh?=
 =?us-ascii?Q?EMA3mkiGUht1fCOS/2i6+qRvzRVMOPLKff81TVneCRnRIVy+grjiiTaT9KcB?=
 =?us-ascii?Q?Acjs1LxtIbpw/Ycr0aUYQDxQj9vNYDxbKgr4jgb9RlCocC+qA2q6rw/9BlXt?=
 =?us-ascii?Q?0o0XnaUfKtGQGf0speCfQk5byrd2LmCia6QuI/6spH9+WUAhxuO0nVK6rP4Y?=
 =?us-ascii?Q?KGY/+apkjd3jbz4Pwp3ZX4WU7DzkdbzYZj/vOLQ48IOUjr+f+pLxWdcWTV/n?=
 =?us-ascii?Q?jFlpXbgIc75UJg9WTPurkhiz4J6qErP3MNREOJR1IZXREWDam1qgzoqx0IDL?=
 =?us-ascii?Q?/0VDOIyBV+q0RhhNnaR169NWROVkUpNvLtXy+a2ucndHSDgCV3XhtTUbwNBI?=
 =?us-ascii?Q?ALWV2D5R/Wvh71U9pAqppPA0dHbRdtM28ZXYKx4HZWEDd5SVQAJz74SyAVFo?=
 =?us-ascii?Q?MIwwBQaqOf2vrUF9QffzLEw3bLOdz7MPu3h90z+wbCdaKJgpzdl9Jp39U5uk?=
 =?us-ascii?Q?yAjpxoNQ56RBocuOIWRb800zOlxJkGwvrdzEyXKFXCO3Bn0qAG7iVvFvvRz3?=
 =?us-ascii?Q?/731DCkKMuayEmOfTE3FMXwFBCMFl7NhXB/94bUZ790OsWTXqdNbDF2gbFby?=
 =?us-ascii?Q?uryMeRUpx1kPvvQqXOCD/JMWRPk/ah6WUGJjC39qxF+ZjBtjCC7q3jVy6haj?=
 =?us-ascii?Q?3z++6bJXgq0qjVOvKgF6a9W1OwzuorrEdYoCLUetezocK2oGCIRKjxPvI9QG?=
 =?us-ascii?Q?Ujmq48vJ+SRItWiQjPV+G5bsfGlHLFKGXdUFUlSrk+yLp1BS5g+7ZZCONgSJ?=
 =?us-ascii?Q?sbGlnX8B56knWLdCU5ZWUlrcUBpt5FbPquEOdHn6Y0Lh5OtqvIv8ojPOEFDW?=
 =?us-ascii?Q?znzWo2ivWcjon7zRJgL/JtQ5evfLPBYe9OrkOT0rJW1c+jvrtrFyFlJsoHKV?=
 =?us-ascii?Q?cW734Q5+tLyorJ2hijjeFsYFN9lPgxvCBDftLikZn+h+IK8kkHtj4EApgSdQ?=
 =?us-ascii?Q?Uq5Xr/c/imO1h4x/6AZDy8imPiBvafOq2k9o/7VJu8PQCEoNExoJbqRtJlk4?=
 =?us-ascii?Q?IpJs4LhoQoJxFGC1yjM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd7c1e0-1956-4df0-df4a-08dbe16d3fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 21:45:54.2322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsCU89j4LNNhJJqrK0zs17XZDWnoCEMsWSUjYgSF4JWL9jr9z6chUiIWSJCqPyMS/fQLa8WWzPfI3mwkmXT1lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, November 9, 2023 2:37 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime dereference
> usage count
>
> Fix the amdgpu runpm dereference usage count.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index a53f436fa9f1..f6bbbbe5d9f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1992,7 +1992,7 @@ static int amdgpu_debugfs_sclk_set(void *data,
> u64 val)
>
>       ret =3D amdgpu_dpm_set_soft_freq_range(adev, PP_SCLK,
> (uint32_t)val, (uint32_t)val);
>       if (ret)
> -             ret =3D -EINVAL;
> +             goto out;

I think this hunk can be dropped.  It doesn't really change anything.  Or y=
ou could just drop the whole ret check since we just return ret at the end =
anyway.  Not sure if changing the error code is important here or not.

>
>  out:
>       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 0cacd0b9f8be..ff1f42ae6d8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -346,6 +346,7 @@ int amdgpu_display_crtc_set_config(struct
> drm_mode_set *set,
>       if (!active && adev->have_disp_power_ref) {
>               pm_runtime_put_autosuspend(dev->dev);
>               adev->have_disp_power_ref =3D false;
> +             return ret;
>       }

I think it would be cleaner to just drop the runtime_put above and update t=
he comment.  We'll just fall through to the end of the function.

Alex

>
>  out:
> --
> 2.34.1

