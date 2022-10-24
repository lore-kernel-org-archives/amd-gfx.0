Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2119C38A2D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 06:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6501610E269;
	Mon, 24 Oct 2022 06:31:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B304210E269
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 06:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEYyLLS0H8jqek0n3cX3w0n8EOXkemZocfxoqxJseNekurjze6lNRJtYCrH++PuTEMvGoA7Ds750f2RLHI9Qn8stzKoc9Qqcv/C3ogB4/XbrZsuOKINXtRdD1ZcaCXskCfve8oxOtdpDrL1adLX499cdsiNcFHrN0N/PLUiHeb6YPO6z7QC+c5c4Ik0/RbvZ27C2DdE4r5v9voX7Q5ZF+5sAfBEE+odyQWCLR9jBBeqSqT1GhvbHlQEkb6Tnc5QFJQ69x9QUQ9ysW8/P2S3IDnOjPLJTEylUq6UMtLT0asYM0GhgG9y2UJTGwQvOqkQJAxKfYMy3kLMvN+uPIPqE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk26rbJ9eNKLd5no7S7FOiwSzC8VL0YU1fcyQyNadjI=;
 b=ZEeblojq2zHt9oKls1AG+YdyVQgQxbiYMfbNFq2fvPjp8WL9a1ULd279hZ714wiDrvL/LuO4gUqkpcWUSEo4KfPTXmJM+qN023/cPuzcLP34+zsk0jvrdXPu0qkFniqeOo0Qlr/A3WJQiMMBEGg4KgJFsPuXncwnt3IcTEDEboU9oUD534kqTbE/uD5pXr1W1rLONk+Xy1bitHYcKkDw1y74My1X0BjonRHEY1uSYQf2ivpD6URl/X6zHnJToWc//ja5mvtI8b7BMVYMmbTgrRDrAr4L9TjyHjQnAhDn9ZzTMlAk7JEisHLgEm2AZWHK28erYY+CDF0HBxh9M+FIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk26rbJ9eNKLd5no7S7FOiwSzC8VL0YU1fcyQyNadjI=;
 b=296rwbSIpGmSr5DKZr1BgCCACfvvAcTaeMjCPvfgpxjbzc+MR5WZg95xjvr4CsqLd3YME694vPP5AYbvuylcSIveT0/k7UJWEc1FazsGapMynsIzS6CgeRWC43t7HPBjS3vQ0FYlRuu00npwYQ19ra0L+MfFStgCMLlp1OybGS0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.26; Mon, 24 Oct 2022 06:31:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9655:dbcc:a395:5c6b]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9655:dbcc:a395:5c6b%4]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 06:31:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks
 complete s2idle resume
Thread-Topic: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks
 complete s2idle resume
Thread-Index: AQHY5VwXgw9iAbM5hUyMB/ovlv4Kgq4dGDUg
Date: Mon, 24 Oct 2022 06:31:00 +0000
Message-ID: <DM6PR12MB26196D74CBD6D1D8BFF5F3E5E42E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221021144728.2798803-1-Prike.Liang@amd.com>
In-Reply-To: <20221021144728.2798803-1-Prike.Liang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-24T06:30:55Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d2ee0781-3f41-47b6-ad4d-99a232dc8349;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM6PR12MB4577:EE_
x-ms-office365-filtering-correlation-id: 49fa76af-4409-46c5-ca6d-08dab5895120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trw10cDqw4NaUBeENUDqBBhOMPzal0Xp2dUTVlrfiV6QP5UaQp5wNem7VjaIuUAsDhayh8zf5S5SzWJfu/VOkLPDW7iiLPr9DwoBA+uK4L9sLCZsmGW8DZMU6Yl25O47g/6QZEgSxbajqQLpAsqPew6vsEG3tDF0tGaOpKXcXRMhlIJQV5RLOena1oslqsbisiDG2MWLikv6D537Lb8aIoaaJYy0f3u6YclNgCqJ45th2ITo69Q2ufEMWDNBdfWD8qPKxr1F7j+y0WjCGePRfccy2mljC3J63eP3ZKII69sIUIeXZdiM4LxEYff6dl2zRlrkXEkUAidq0e1L2ps0ozdEnbsjvQknK1hfLOxruX+H4kDTv1s7KD+aK4/Sg7CmpV9M+8s9UyQcViJrtKAz7g113go+TyYWdqtaMsD4RPYG6iDkcJNzopdRSI663DO3hnu/O61GrwWTincJD/aag0WAjt2mtom+qxZLWmlax0bQQi8gfGtcGFYUKLUiQGmiWlALHCY+wJin2vZuiwx6S9SHmYpW8+9KjSo0YCPimqbPzM146pMrugyMPWS5DuPFhtT9mOv8eWjn/1iyrlXYOA3U7rox4YMqHBqI0WnhtaIi75/iGDy5YxUeUpSawLhx7AOeFNBMT9/3H8AwZ4JQd+eXkJ/pd/SUg6ZQpmHbV3LX2kUqNjyl+9xJ6UyRJaTLqAqxY5KOOf4E7XeHtqhvS9V0dGNr032y7KL8REHBAfwWymsndA5Z7PfpH3UCJb+8Hsx4MScxFHJe93EEEUbqwg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(2906002)(76116006)(5660300002)(66946007)(66446008)(64756008)(66556008)(66476007)(7696005)(71200400001)(316002)(122000001)(38100700002)(8676002)(52536014)(8936002)(41300700001)(4326008)(110136005)(54906003)(55016003)(33656002)(38070700005)(86362001)(26005)(9686003)(186003)(478600001)(83380400001)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7+C7ivOFYvouU+0EJi/PH71IXRT5CKRXRVMeL8AVT+ENEsY4JRH+cPWR6v4K?=
 =?us-ascii?Q?wQ3zPc8WVLrQ/p37AW2mYFTvkF85lPq0QoEE5fLEYWvXRuRlm35jzlqTtt8n?=
 =?us-ascii?Q?GkSfajbPURWcyXCURSVVrLTjSwzC/qulkJEBRoludEaOg1B/WM+GzweK1HJI?=
 =?us-ascii?Q?9WvjzhU5ARZ3YbyvwKt9WqVY8eRxRxCxXOiiZNHcqgIb1LFHGiAgT6xunqh8?=
 =?us-ascii?Q?Cvw8LDYmB5Fm6vsxY00KQK42Tez7L4T0jq9brO+zNQaD9tbgwINdLrUgvJqi?=
 =?us-ascii?Q?B+B6aTc9nSKdlD6RelFmacvyPl82/Ea82Lamc1xRjAyWkXoVdgXGeaCjmFYV?=
 =?us-ascii?Q?4U5RzsJ9s8lOuAUBxwuimokKZRiP+gtdKXK0zAjVu4vyZ244DIgOsSP/yNeP?=
 =?us-ascii?Q?NY1+MrCOUTulLS9SPQUGbTbfa8zjv5L4BMxtJ9HsQVeSlJcQq4CPB+9eTdYf?=
 =?us-ascii?Q?2uCWNQPe+6tXiTa9Ti3j0diFBGuvzPUswxe/MQwyyQly1/DTa500ou5HppJO?=
 =?us-ascii?Q?7mjwbrakxGpkccnyjbuyoZBfjd5Wd1aEdKGd9yvN6JPMeOcuI3jb8aJ15KIH?=
 =?us-ascii?Q?MOW4UU4/jV/1BiBF0l+I6RvMDbaH+EEfzN7YKAh0GA6ITrFrgaSWhzbvwCWM?=
 =?us-ascii?Q?xEwsevukiRcSGafQ4kmCohL/Tp89tp+J/XSNe2uPjzmjR1u3gGJCPvZ3Vv5t?=
 =?us-ascii?Q?6ZFowPJ8CjZUiOWhZW0XH1Ez3gLJrZDkJvMDzTpR0hF5YRl1vb/2x0Q/JOr6?=
 =?us-ascii?Q?E7YNtakn/O93xR/OhPq9eZKksojk469qiDYiAY9Iv1KsZxIXo1IMeTlSXL21?=
 =?us-ascii?Q?s9YPdiNaXXi3LkkIHo+ZvZkPmhWiW+6grlpEmurFdkyCXcxgQiAVwfQ/EJPy?=
 =?us-ascii?Q?emMKTYrg3RXK+VLf152LUBCHR0X/1WqE1OXnX3BoZ6Ob5claSKzWbPqC+9VQ?=
 =?us-ascii?Q?4e52LeQD5YNzbcZfoq7kdp9W/fXWSVKW6NvmFCIzigibXJjRW1RwS5hkvWFe?=
 =?us-ascii?Q?B8KC8dNPyZ2n1uxnogl+9maRTBhRkylhqjeY22EuCHpIzKafXkv8mNI9mBot?=
 =?us-ascii?Q?VjIlNF2BSAo47LzTKghWrjfgMr6eXH446xIddJEg1MOIe2U/V/8MIrDkE5MV?=
 =?us-ascii?Q?qJFTwTK++htSKsiWNcV1G+paVs4zYi79RK6EvJ1/JBxZ0z8wFXFDKaox5jfx?=
 =?us-ascii?Q?HhFLSWwY136Si8hNYwfrLDTvF1Luab3Uesl41tcmzQKqBIe/UJzv/GksHBT3?=
 =?us-ascii?Q?ByJ+H5QOjcyG37T7h/HmxxGKsTQQ8taGUTxLuny63ECZTmeqRfQCAKl/XO3w?=
 =?us-ascii?Q?A9CCrapqXfW4aZZPsP+KQABHSzx4c8xJ+dxNAdbCOIhAYVejG7iTnOCH6Elo?=
 =?us-ascii?Q?0Ue7Tlqsgbi4j/y/DymWhDVWt/UDBgVgT/I6jk5qtWlvVi6obi5HKeJQMC+d?=
 =?us-ascii?Q?TNtncUEch9nS5NeOXaDEOmRbk58Y9O18Q/JciXAQqjfkSwjvXYHGTa1yYOEF?=
 =?us-ascii?Q?XgPeV1oC6NQ9y7g9Vabxc7spuMa3Mb1YohJk6/lRZxFYd+RHDG9HGG7Pmkks?=
 =?us-ascii?Q?9wyGMhGab3r7CZttTS8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa76af-4409-46c5-ca6d-08dab5895120
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 06:31:00.1972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxEATHWgFYLZCgv2O/eCGSHBQ0wyYnKk8vCar+uj0Y3XjRjFADtZSSb9/SXnaaKH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Prike Liang
> Sent: Friday, October 21, 2022 10:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks comple=
te
> s2idle resume
>=20
> In the S2idle suspend/resume phase the gfxoff is keeping functional so so=
me
> IP blocks will be likely to reinitialize at gfxoff entry and that will re=
sult in failing
> to program GC registers.Therefore, let disallow gfxoff until AMDGPU IPs
> reinitialized completely.
[Quan, Evan] It seems the issue described here has nothing related with sus=
pend. Instead it happened during resuming only. Right?
If so, I would suggest to drop the confusing "suspend" from the description=
 part.
Other than that, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
>=20
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
> -v2: Move the operation of exiting gfxoff from smu to higer layer in
> amdgpu_device.c.
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5b8362727226..36c44625932e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3210,6 +3210,12 @@ static int
> amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>  			return r;
>  		}
>  		adev->ip_blocks[i].status.hw =3D true;
> +
> +		if (adev->in_s0ix && adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_SMC) {
> +			amdgpu_gfx_off_ctrl(adev, false);
> +			DRM_DEBUG("will disable gfxoff for re-initializing
> other blocks\n");
> +		}
> +
>  	}
>=20
>  	return 0;
> @@ -4185,6 +4191,10 @@ int amdgpu_device_resume(struct drm_device
> *dev, bool fbcon)
>  	/* Make sure IB tests flushed */
>  	flush_delayed_work(&adev->delayed_init_work);
>=20
> +	if (adev->in_s0ix) {
> +		amdgpu_gfx_off_ctrl(adev, true);
> +		DRM_DEBUG("will enable gfxoff for the mission mode\n");
> +	}
>  	if (fbcon)
>=20
> 	drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
> >fb_helper, false);
>=20
> --
> 2.25.1
