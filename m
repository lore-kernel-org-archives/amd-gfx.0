Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9040EC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 08:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0F510E23F;
	Mon, 19 May 2025 08:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wt7memr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD1C10E23F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 08:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBX4D8e1z9TeCXjQB2CzUcWIGv9Nylfq694oIC3BnDP6WugYtHCaTtHptlC9Qg/8MoNnPEG8HZPomvnXVfMRN5waLvibssGfkQe9pN9LqdkzPhDEH1J7hAzmn7u+4aSaQuJifWJEeRdSQp9qd4vzR3g7+9dss71/pxa8Kg4uBn9h54V4vKZwujFIW80SNlw17qs9I0YTk4eM9psbRo8PpX0cn6WG883W3tTu+/PfMusn+nQNFOs/RxzFsygtch+kgSkH8qtMqXtLnlxYjH3zcBqyMS+uE72xD50NdGAFiFulCK490PGUVfo3EIBqYHPpqnoGa3k3ljgdcHJ9XuJFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZiE3n5MWAGfCk3cvnHPNXyFWiyMJ60BH0TjRTXJ+5Y=;
 b=qmXY+2s5qmZkVqOm9ghOnWB/7wzqoS6eVs6BmRw62w4QiDuHF41eehZr0zwPReipk45KWlYufybL4Wnfwh7ppvOtY4RSss/yhRY5UuNOAt0SGr2BkcBS5z0V/io1ySb/tPBOOip5rKrxaUqE6UbutCoOblEIuBj5j2adw9ztXuMOuzsR1d/tIgRx3XqpAdztcx7dUsAf/DhIqWnuBHsVpyxre/k2TDiMHomNoyiAcjkbC+nze/XwPJD3V82rGZTqCzoMTJK6YBe9vBowGQZTtjGMEpYChyUqiz/fQbPBNcPg3Jvw+yAs3yuUiGh21s8GyZPwV01MnzutxMLnBz1p+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZiE3n5MWAGfCk3cvnHPNXyFWiyMJ60BH0TjRTXJ+5Y=;
 b=3wt7memrUwWaN4w97mhcXcrfrkmhNRAQ8OEE85hujSaPiiqSy602Mwmp848RvrwwOfOHOg3ys4JKZZI84YNn1X4a+pDrQL3VhsaBf3jFLFeJioh6qUDxxcJ/peAQskf8osw10s4Ce23qHOdd6EG9qY6mx0YGJG98Mfr55bu7ets=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.32; Mon, 19 May 2025 08:27:20 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:27:20 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Owen(SRDC)"
 <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>
Subject: Re: [PATCH v5 4/4] drm/amdgpu: fix fence fallback timer expired error
Thread-Topic: [PATCH v5 4/4] drm/amdgpu: fix fence fallback timer expired error
Thread-Index: AQHbwwkJ/TRphGRme0evDl1CehVfTbPVErQAgASWDlo=
Date: Mon, 19 May 2025 08:27:11 +0000
Message-ID: <DM4PR12MB593724C2C436922F75B00364E59CA@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
 <20250512064141.387079-5-guoqing.zhang@amd.com>
 <72e81b07-c4d6-41c1-9739-56cea731a240@amd.com>
In-Reply-To: <72e81b07-c4d6-41c1-9739-56cea731a240@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-19T08:24:18.3844462Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|DM4PR12MB6640:EE_
x-ms-office365-filtering-correlation-id: b870ba4d-4656-4ff7-fd1c-08dd96aef8e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HinRkt0xjseOkVKYnVNpZstyWRUSqRGDe6tHuGvjLNHuf30fFkovMzZNLFaj?=
 =?us-ascii?Q?n1nXVujnJxO1OIwyGUHMfIc6QsLLsj6acl2zo86L9NgQRfDQCdwj9PaMM96N?=
 =?us-ascii?Q?VUfmfshrWuOz4mMb5j6uScIfxuhXQ/9bp+pdHDgfSMHjNkRpNejmno5RH7Ab?=
 =?us-ascii?Q?AH0/9b2mMhQDQLZSXz9ZGev7fnftgJ7GdZt6/26mzMCVhSIC7mj8N+hLubIy?=
 =?us-ascii?Q?18/1jGgpxGNv0AIGHou2g3JjZ3S6H95RuIhS9EtbqU53D6CiF0xo6CB4G880?=
 =?us-ascii?Q?LctWiCNARks5hWtc7OK0V65PfO17TL3n2saK1MRY+Tpy5CZ4hLR6LH4FzkvY?=
 =?us-ascii?Q?zuSUu+7Nk/5onIqVRfQ9UMahK22Y+SfAx5QJ1RqE4OdF/jZbS19JpiKVXSu/?=
 =?us-ascii?Q?M40CcQvJqhb+g2o8IjGIMM+EsikW/VExJE4403V4kEqxW5uiMSVy/nRTsUy2?=
 =?us-ascii?Q?UwPDzi1PyS9rhDnVetCCstQWZeNZ68DGx9QRS1fQQWguNz1p8bMqSU05FpPs?=
 =?us-ascii?Q?LntaquKMbWbcx/9H5JnB62oXc+Idvfp3t8OoJQSpgPFQnipvIgmZIRSEN7n2?=
 =?us-ascii?Q?qAN+7qI5BUpBErI9/9auAelt4yX/Ovcul2uwIeuLk+yWSpD4rxQN07GmNa6n?=
 =?us-ascii?Q?0bE2iPFAlmin9G9c0Tf/BhEsMYK255EOyXCuDzvsi5I42Y37KNqBUldKZZHn?=
 =?us-ascii?Q?ou4tXRIA4xa3U6RJNIgZUDAc44TOhu2NCt5KG7GstedOUCh7kZvS4XZ6FyOs?=
 =?us-ascii?Q?AmMDEmV6DnG1UuCev8I8V0FU9j7ZDrQ1kcoIo9e7ttt2E2b4Aow5BIiF1yJ5?=
 =?us-ascii?Q?3H5hlBox+g8OXBmtwBll4p3HYjtt6OvbG5QKS19r++Eb/ugzDcxRcmOFoWhB?=
 =?us-ascii?Q?4ZrcyKESiSzQ/h5OnUOMO4D7ZMresYtps1j0k2zc41Y85x50Dz2SYkIxCsGV?=
 =?us-ascii?Q?MJebB5YBZ04ZAnZbxPJUHlcbS+kV2CHCVa0Mu5IF+WVClkYBQdFAqJ1yL+ND?=
 =?us-ascii?Q?iETn3ounJHiPUMv/FzwaMQj3N0bTZToj7yKz2GWcR9ZRC9vEBY/DPe9J3n0U?=
 =?us-ascii?Q?ULCa6IMpFCoFby+X5kImf8yZVeZeYAYjHCVNclErQHb4z+qU+nvM0Fya+Hn9?=
 =?us-ascii?Q?pvl4VX1lXqzRSxGe5rSmfUQ3BWQL11WnzzPSdm0jqcYJ0IU2o9ZcrLzDTxLw?=
 =?us-ascii?Q?cc2Pm0TUUkPyDAPo8w0L75QCjCnmeVjZa3pmkGops2KQ2eIUHrZ3zVxjDoHI?=
 =?us-ascii?Q?hofH5sr92PPiMXsL/gAFav5/IO/SJhAau168nGGgLWYDyli46yMjYoUYq5dV?=
 =?us-ascii?Q?e+JysyjOig4ySxjG+1pB/dR2q2G+KN8pjyBzoyEf+vqLUkfBfpgAzjCobGPL?=
 =?us-ascii?Q?x7iTejrmCIM/m7tYMT6ATN13+w1b9wj6egaPCyzvX+y6VsCr/tV2pJdiKpio?=
 =?us-ascii?Q?m0k6HKfrELH+GtibilDpUbCTlfCHrqArCsmDaE5BkjypO6BEVPm3mQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gn/72+6h+udTjH+Q7A9CtdL1kqe8BaychmLQhbXZclw0cJtFCMWGk/zPyGt/?=
 =?us-ascii?Q?8zyUly59zTntH6pthch8CqZqnrtlQsBcDOOQ6gI5fMafZv7OUCPeEzxSjZE9?=
 =?us-ascii?Q?p3E4CMPY8c8jT09rfxZspdrRZmrvhoGLT38J5K0B5zlPxjrFuC1q7JlngC55?=
 =?us-ascii?Q?rnW5bkAAVGON98Z7YhB7Nr+o3saiLhQGUjFnoV/UWUOvWq2oT25QRj61U8kF?=
 =?us-ascii?Q?erJVmRTX5RbJPRSMhDrn988Yx1+a3V3MAQ33K2t2SVVBfCPeTo+VI99rF4Jo?=
 =?us-ascii?Q?IOokL6GXtwgTPD9nyaMvlnWzpFSxeN0eLvPru8U1r2YpTnI5Xil4Eztq8ZO8?=
 =?us-ascii?Q?YM/Ldg28K4cQUKSlCcrIKR7nagRSUxd84ko2ms7vzmUN/ye0wP+DybI0H/Vz?=
 =?us-ascii?Q?gJMGVhL5Hekz2cgs66H2juaBY7VYUVvP4ALslnQ+AHbaPQ5mvlJ0LaMZk1dT?=
 =?us-ascii?Q?yl4iqv3EhY7VbNhA2j4vAbCAj3vox1IIxJic3rzTl2gHLmmS3vB37RN9Dp2k?=
 =?us-ascii?Q?OGokhlsSePb/p+Evq4JpAG6ROdolTUTYN9+44jVAl5CWgGFQzmfiPGV/hsvr?=
 =?us-ascii?Q?LNAAzLZ/N+bxb2Pa5aT3X1nVJTWBFsnzT3ZslwddZQjn0Q8Cw202l5XHRhfk?=
 =?us-ascii?Q?eKGELnYxlRUORCdbAvKQdlWjpJffpve1zxMgewmXTteMkzRC5EhJVUi9N85E?=
 =?us-ascii?Q?gox/grNPoUOMg5ke/9rfg+BRLWIdRsOywspzZjNNOQ7fGr/WRWbZE+t8PekQ?=
 =?us-ascii?Q?MMSqVeTAJAmaJBSV3N9NeG7Ygnbo5HKNSHFN0yo3HjFIR/fJL1Fl1u5+3XM/?=
 =?us-ascii?Q?NbKuGw46jJlc43C9Xo4JCUJB9KUkTYaK2IesjvbNUDUFJaupEYKauqg5pmV/?=
 =?us-ascii?Q?cbjNK1BhUH2f9gtbQLb6GiZ7sQ0RAa3cwSMmht4jMxA4YHSLYfKk9bkRx+Fp?=
 =?us-ascii?Q?nxnMOlKDuMvfNYQkaXj2w2lQqq6gZKsd2jgBE98nVGhrQ/8szTkdR3Npe9+f?=
 =?us-ascii?Q?cY2VuZvFbEgbFBHYMq5nC7dCFBKOAI3VrFznpKmcan8ASjJLqOIRu1q4S1uV?=
 =?us-ascii?Q?Uwa5rM3Vf1E8xFBIpDO6fy87DLwiMobZqJOVNO+A37MEbJlVvBgjLZI5oGmH?=
 =?us-ascii?Q?e7tr5foxG8VXQ46jijb3L0nX06iUEuhQZhG1oObzAVCduaFVbsZKxXPg6XB/?=
 =?us-ascii?Q?KmrLBNki8hlHPRayXGZWCrVppAhgFwnbuOzlYZI7txFXQTTJjE33N5rpjAkh?=
 =?us-ascii?Q?jXY/i+lT/b3C223O6eYCMRN9sBIkqF9zr85s2AcVI9LochRVNxxA931g+0V/?=
 =?us-ascii?Q?QQVtb4J5ccuhkxt/RxottrtLSllteSy1YnvOFjSP/G/CdZzydcRVT3IV8VpM?=
 =?us-ascii?Q?gviHBtzINAmtStGPxIAl3qgfEI3ne+J8MhL12sj4k53qCLTxOZNIi8veUWQ7?=
 =?us-ascii?Q?MM1xenV1g+i4Bt58PTWaCTEO3QJeH5ILvEIOSKWgxWzi9uKRp9OY06nWxr5F?=
 =?us-ascii?Q?dxaRlETZjNbZzqsJsX92VwIhGliEATypZ9Sdth0ff4LTpzn0rw0yd6UJNohC?=
 =?us-ascii?Q?kSRszeiJQRlSwL8tVY2A9HpyoG0wfntlzeW6ShkU?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB593724C2C436922F75B00364E59CADM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b870ba4d-4656-4ff7-fd1c-08dd96aef8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 08:27:20.0510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/cc9itCAWos03RUYT8G2VxxmM69/qmWMHxfdQmAqqpMQPglvHJ4VjYNR7J9t1StvxJtCGWBefJAKrh9b8sR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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

--_000_DM4PR12MB593724C2C436922F75B00364E59CADM4PR12MB5937namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>,

Thank you for the review and feedback. I have revised the patch list accord=
ing to your feedback and sent out the v6 patch list. Please take another lo=
ok. Thank you!

v6 patch list mail titles
[PATCH v6 0/4] enable xgmi node migration support for hibernate on SRIOV.
[PATCH v6 1/4] drm/amdgpu: update xgmi info and vram_base_offset on resume
[PATCH v6 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
[PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
[PATCH v6 4/4] drm/amdgpu: fix fence fallback timer expired error

Regards
Sam

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Date: Friday, May 16, 2025 at 18:22
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Koenig, Christian <Christian.Koenig@amd.com>, Deucher, Alexander <Alexan=
der.Deucher@amd.com>, Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>, Ma, Qing (Ma=
rk) <Qing.Ma@amd.com>
Subject: Re: [PATCH v5 4/4] drm/amdgpu: fix fence fallback timer expired er=
ror


On 5/12/2025 12:11 PM, Samuel Zhang wrote:
> IH is not working after switching a new gpu index for the first time.
>
> The msix table in virtual machine is faked. The real msix table will be
> programmed by QEMU when guest enable/disable msix interrupt. But QEMU
> accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
> by nBIF protection if the VF isn't in exclusive access at that time.
>
> call amdgpu_restore_msix on resume to restore msix table.
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 4 ++++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 0e890f2785b1..f080354efec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>        return true;
>  }
>
> -static void amdgpu_restore_msix(struct amdgpu_device *adev)
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
>  {
>        u16 ctrl;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.h
> index aef5c216b191..f52bd7e6d988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu=
_device *adev);
>  int amdgpu_irq_add_domain(struct amdgpu_device *adev);
>  void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
>  unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned =
src_id);
> +void amdgpu_restore_msix(struct amdgpu_device *adev);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index faa0dd75dd6d..53c253102449 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -648,6 +648,10 @@ static int vega20_ih_suspend(struct amdgpu_ip_block =
*ip_block)
>
>  static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
>  {
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +
> +     if (amdgpu_sriov_vf(adev))
> +             amdgpu_restore_msix(adev);

You may consider consolidating these under amdgpu_device_resume() ->
amdgpu_virt_resume_after_migration()

amdgpu_virt_resume_after_migration()
{
        virt_update_xgmi_info
        virt_vram_offset_update
        restore_msix
}

Thanks,
Lijo

>        return vega20_ih_hw_init(ip_block);
>  }
>

--_000_DM4PR12MB593724C2C436922F75B00364E59CADM4PR12MB5937namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
<a id=3D"OWAAM8B554688781D18499DED09243CACDABB" href=3D"mailto:Lijo.Lazar@a=
md.com"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decora=
tion:none">@Lazar, Lijo</span></a>,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thank you for the review and feedback. I have revised t=
he patch list according to your feedback and sent out the v6 patch list. Pl=
ease take another look. Thank you!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">v6 patch list mail titles<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">[PATCH v6 0/4] enable xgmi node migration support for h=
ibernate on SRIOV.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">[PATCH v6 1/4] drm/amdgpu: update xgmi info and vram_ba=
se_offset on resume<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">[PATCH v6 2/4] drm/amdgpu: update GPU addresses for SMU=
 and PSP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">[PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation =
on SRIOV<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">[PATCH v6 4/4] drm/amdgpu: fix fence fallback timer exp=
ired error<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Date: </b>Friday, May 16, 2025 at 18:22<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Koenig, Christian &lt;Christian.Koenig@amd.com&gt;, D=
eucher, Alexander &lt;Alexander.Deucher@amd.com&gt;, Zhang, Owen(SRDC) &lt;=
Owen.Zhang2@amd.com&gt;, Ma, Qing (Mark) &lt;Qing.Ma@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH v5 4/4] drm/amdgpu: fix fence fallback timer exp=
ired error<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
<br>
On 5/12/2025 12:11 PM, Samuel Zhang wrote:<br>
&gt; IH is not working after switching a new gpu index for the first time.<=
br>
&gt; <br>
&gt; The msix table in virtual machine is faked. The real msix table will b=
e<br>
&gt; programmed by QEMU when guest enable/disable msix interrupt. But QEMU<=
br>
&gt; accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked<br=
>
&gt; by nBIF protection if the VF isn't in exclusive access at that time.<b=
r>
&gt; <br>
&gt; call amdgpu_restore_msix on resume to restore msix table.<br>
&gt; <br>
&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp; | 4 ++++<br>
&gt;&nbsp; 3 files changed, 6 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c<br>
&gt; index 0e890f2785b1..f080354efec8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt; @@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *ad=
ev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -static void amdgpu_restore_msix(struct amdgpu_device *adev)<br>
&gt; +void amdgpu_restore_msix(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 ctrl;<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.h<br>
&gt; index aef5c216b191..f52bd7e6d988 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; @@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amd=
gpu_device *adev);<br>
&gt;&nbsp; int amdgpu_irq_add_domain(struct amdgpu_device *adev);<br>
&gt;&nbsp; void amdgpu_irq_remove_domain(struct amdgpu_device *adev);<br>
&gt;&nbsp; unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, u=
nsigned src_id);<br>
&gt; +void amdgpu_restore_msix(struct amdgpu_device *adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/=
amd/amdgpu/vega20_ih.c<br>
&gt; index faa0dd75dd6d..53c253102449 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt; @@ -648,6 +648,10 @@ static int vega20_ih_suspend(struct amdgpu_ip_blo=
ck *ip_block)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)<br=
>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_block-&gt;=
adev;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_restore_msix(adev);<br>
<br>
You may consider consolidating these under amdgpu_device_resume() -&gt;<br>
amdgpu_virt_resume_after_migration()<br>
<br>
amdgpu_virt_resume_after_migration()<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virt_update_xgmi_info<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virt_vram_offset_update<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; restore_msix<br>
}<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_init(ip_=
block);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB593724C2C436922F75B00364E59CADM4PR12MB5937namp_--
