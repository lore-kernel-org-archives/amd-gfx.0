Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2DFC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 16:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A67760FE6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 16:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A67760FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CC26E175;
	Wed, 11 Aug 2021 16:32:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E82E6E17A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 16:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvhzF6ILuQ/XPUln5EOLFmv+KXaJ7mAjOiM3DjNWIyzJ7uteuZRIvv/q9gHqvwG43LS30soe/J46akdk+BWUm3voLa1lI8C+gQXh6cVIqtPeuS+xWZWNGY4+VB04mKMPMSJmjMk71sUxNdBRoqOeiPE4fsRCNYdjJqcE42x29VVQhxzDAIZsPtXa7Hol1nk77+CJ/wGCMaqrhsAyDSGndHSxRAkzyX+CMYRjWEi55lFn14nwoDqJUvpaVI1+N8ZSxRGb//sHuMpu1aToe9ibX2nqNTsyDYZUMK1gdWiY1FEMXG65bNV3l7/dAhPKy+t6UK6oJoLqVRdMbmH2IaxxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5kXE6wN06nQ8ChXr7igkrOai1yi99YhrOqftDMtvdA=;
 b=bYOhX/6Zul4am12NM07lJ2MLyKvETeJTtEdj2i7oYbd9JM3l1P7VAKmsOmx9MYsc8YLFUbAxHA0wPqa12AxGkY00tSIodWBmTJLCtHchxtZRLjmB95Okxs8aNWv5mQL+YrCoRw9nR/J9MjGSoIbIiFDwBCbmFLE4wZ6c4o3YEqfsYmXYYIb1CKFwbncR6tlp74Pg4WsL396UYRLsFqhLGZJ83ZpLmoH1NIOUYGm5LjjlG4ZBNZsjO8NU3qTc7578DfwPeExfVOwB17rGBYpzhakK77e6iqAdQZzIl4rUDMq+ceYhKDVcL6T6WA7EnTlmxnUrkQUqnjrDpRNHtD43vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5kXE6wN06nQ8ChXr7igkrOai1yi99YhrOqftDMtvdA=;
 b=KGb25aPGYZbI2se3xuidqnJ+d2oLbGJEXBug3iHnQllC9Y2X1ySwX1qFVolzEWWsyxYH1lWcyBGKkYFKGMisE8UwL0tPDQhql5c5zLPbTmU8/03qvi4wSFDcmTzhfc/5g7gz9hD+vK5tZDIXYxG8tkFMvLa70tTaYhhq9BTIGgg=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Wed, 11 Aug 2021 16:32:11 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::99e0:f44b:512e:f7a6]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::99e0:f44b:512e:f7a6%7]) with mapi id 15.20.4415.017; Wed, 11 Aug 2021
 16:32:11 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Cornwall, Jay"
 <Jay.Cornwall@amd.com>
Subject: RE: [PATCH] drm/amdkfd: CWSR with software scheduler
Thread-Topic: [PATCH] drm/amdkfd: CWSR with software scheduler
Thread-Index: AQHXjV7lejSx0kVw3USLzatEjt7N/KttgAowgADndwCAABpwYA==
Date: Wed, 11 Aug 2021 16:32:11 +0000
Message-ID: <DM6PR12MB276193260F2DF33EFEF1281C8CF89@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210809204048.2735-1-mukul.joshi@amd.com>
 <DM6PR12MB27613B1C5C6926052F80A81B8CF89@DM6PR12MB2761.namprd12.prod.outlook.com>
 <DM4PR12MB5263FE38F3ADF1C31A39BADDEEF89@DM4PR12MB5263.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5263FE38F3ADF1C31A39BADDEEF89@DM4PR12MB5263.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-11T16:32:09Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9ccec323-9df5-475a-a808-02e53911fc4c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4f8ca15-2c13-4edd-982e-08d95ce5921e
x-ms-traffictypediagnostic: DM6PR12MB4562:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB45625F049499B222638B206D8CF89@DM6PR12MB4562.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luW4tNVtvKzad1WN9EEceFM7ch49n3xf/IX5EP35FWzSdP+ZazfSGLmDFbN4yrUJNP5Jl2FV/vkDU7vdNdsgAWCxTkIr20jW72NFuJRnGbQTaCFcKcF9Pds83OsYykeFYUn2O9cRWJvvyTGbxa0O1OrNQI9C7fU19kkRu0bFMrdZZFG8292zb94bOhvTIvvqX0xxRv2N7cLzKZ4hAaS20gKzKNxw12K8nCZSQvfJjbWOaA7y7nfNoXf/+O8uwAIN3Te4+rsBaLl4Qj46xzwSqGhhcvqmqpXde71A84c3d61EhUuD6wLacR3mFoBbqRxyavXfSe1wT6xaNQeUobq0KeBQUQnTtQ+i38Wf5qOOz5BfRAnezEgtnD8JgidhMI8N9l5vKaggMx8MlnbFIBcadD4m0RdrV3yVdhq2F7ytSZnS1Ol1YpBayJkEIcdSLL7HvvUuFEvYrp20M5lvhRH3yerfIAZ5Yz7ZNNRsVkhJHNQdGLJG4fJEEX4L2IDNjtLROYGJpd7hcOxfMm0P/2fn8SCwXwHAdU1oS0Sahi9bfcj6zptHznfgvzO7+OT+ZICqLgeWTJkJsaQfyCpB8EcpJ1Gr3F9yC0hdNrEshp/kAnpVI5HZrT5aD3Ip4Atkf1mpCfVC6unwrOIxCkuoOGaexdnAs8ZGvhOlwIfAmtJANQP6+BiUyMmSnNYS+sZ2PJ8rjee736KouDtOn2KDXa7BSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(66946007)(122000001)(64756008)(186003)(4326008)(66476007)(66556008)(110136005)(76116006)(54906003)(83380400001)(6506007)(53546011)(66446008)(38100700002)(8676002)(316002)(2906002)(478600001)(8936002)(33656002)(30864003)(38070700005)(7696005)(5660300002)(9686003)(55016002)(52536014)(86362001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5xrRLdroGe8aD+SU699ZRAvH8vQIRwO3i1wzbeAbmc6vtIGd+WVjeukfXzZ0?=
 =?us-ascii?Q?lf/gXkVvzyjq5TDSXuFGkP6uYMiSaGvmpISCzX+UfVfHaHmUGVSnGUGFXk3F?=
 =?us-ascii?Q?WHCBvJLy6ddIZ5pgcbDo0hOasx0XYwyMLOVUkb/Lo11j50MUbjY46SVhO1lp?=
 =?us-ascii?Q?pKIhhDk3YnaglhKqUYOUSHT5oaZF3DKZDwNpqQZmxmj8vjnC5iNx45MQnc3V?=
 =?us-ascii?Q?ThFkbPnbuv0/1K32CdTwgC66xch3qJSItj4YRhpJWXsuq43BRuh1TjlCXzB+?=
 =?us-ascii?Q?iVrprLM2B2jJD5hPdP2VOKPPu1rWFHiO6WEBureTxivoTVb+EYP+hRz9vnc2?=
 =?us-ascii?Q?XU26DAKVRXoYcYRXAwwCBGJODQKRoWcWYOvis5yiZ/pPCrERMvDVmRoxstXH?=
 =?us-ascii?Q?JWTS7FCOiUXF1/VXRBo5xlMDFH44oXH6K+P98UfUQ5X5k+9YPEx2A1sZA+0o?=
 =?us-ascii?Q?Ea0CGOYwIwhGj+OXcM5RpQliJj9jgE/v3ljQ/DkO6PUAFhf09H8X+XDAYAyo?=
 =?us-ascii?Q?h5UIIRJJIcSi3WLE4lIAQ2jlX9mW90cMf3p2C0Yu25Rog+WV2XPpWKgOTBiF?=
 =?us-ascii?Q?vmMw1vR2jZlSxlrcdp0xrpQC4L6vb5WGcsJOzsCY9VQgYF8W3SfPUFHVsqlt?=
 =?us-ascii?Q?VbgQ8EKtBjyo1pVlRJ5YpDjQmjpWaRvq6c+7KYM6f3GHPxGuE0AKo/+CI4Jg?=
 =?us-ascii?Q?kGJfGduioyyWcvtoGdILk7UIX38fBHEjeBv0PMNx3eC4X5vaEP0jOmYdmzi+?=
 =?us-ascii?Q?7emJsoBnuxzMma9XB9GBTOLMhsk/xVSSbykPj5TS68h4XQ2fR1fXJqZVsi2q?=
 =?us-ascii?Q?FLSxQa49u8Vmu+dvPDc5KKvQ8Kd9Auca90azbKLy0RpOwooH8Cfhn++ksWy2?=
 =?us-ascii?Q?fqibv5AioI176/VmRn6t+r/hMmMOsEihquP4P5qFAmWuQ2wirP3OYawIYldE?=
 =?us-ascii?Q?7rbIl/T+UTHr5e+xS1actz9yltvl9NlOI6Vmf2pHeGoKIRDwynQioItEBIRG?=
 =?us-ascii?Q?FJCHo8FQSllS9oh82AtfW9pa+Zn6HDA6mDLuqjidoiCAqULvB/twbqb2WRA2?=
 =?us-ascii?Q?hhycscdlSNak3A9K3hJsv17MDLYf1j0DnN7e/183/33pvooPJgz0Z/e+kuwl?=
 =?us-ascii?Q?ISjfWDthfrBtgyuEgalpCGmrx7V8PFuqdU3S2xKYeMUUpxAcWYCdlbyKGErc?=
 =?us-ascii?Q?hK/ZrzTmzlge/n5w7UV5tpqWWUWCSozhAiEJzc87kJSRF5hppMl1Nm4Vtjlq?=
 =?us-ascii?Q?BjumemczFgS5QUIuzOxxPNBPaY5Hbzvir0qt7uzkNFmEvGMrEoAH1Lzo1J1l?=
 =?us-ascii?Q?k2CCbNUbPf5F934oEzfbadld9KaJGN4zDeHAIcmtHifLh/XrgP0Wu3zKsB4m?=
 =?us-ascii?Q?/M6eEzRVvN6Bb/VB2QUH9C3llkWU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f8ca15-2c13-4edd-982e-08d95ce5921e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 16:32:11.6531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPvnrLFZmRaR8M+nKOe4nJvie3gxObvlVexFdrxrXaVFr4ghTlhGH5aaStBS7xu1G9OMO/5H/cQWW1VB0grFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
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

[AMD Official Use Only]



-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com>=20
Sent: Wednesday, August 11, 2021 10:57 AM
To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists=
.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Cornwall, Jay <Jay.Cornwall@a=
md.com>
Subject: RE: [PATCH] drm/amdkfd: CWSR with software scheduler

[AMD Official Use Only]



> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Tuesday, August 10, 2021 9:15 PM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Cornwall, Jay=20
> <Jay.Cornwall@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: CWSR with software scheduler
>=20
> [AMD Official Use Only]
>=20
> Just few comments inline. With that acknowledged Reviewed-by: Harish=20
> Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Mukul Joshi
> Sent: Monday, August 9, 2021 4:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Cornwall, Jay=20
> <Jay.Cornwall@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCH] drm/amdkfd: CWSR with software scheduler
>=20
> This patch adds support to program trap handler settings when loading=20
> driver with software scheduler (sched_policy=3D2).
>=20
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Suggested-by: Jay Cornwall <Jay.Cornwall@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 31 +++++++++++++++++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 31 +++++++++++++++++=20
> .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 33
> ++++++++++++++++++-  .../drm/amd/amdkfd/kfd_device_queue_manager.c |
> 20 +++++++++--
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 ++
>  5 files changed, 115 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 491acdf92f73..960acf68150a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -560,6 +560,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd,=20
> void *mqd,
>  	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
>  		type =3D RESET_WAVES;
>  		break;
> +	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +		type =3D SAVE_WAVES;
> +		break;
>  	default:
>  		type =3D DRAIN_PIPE;
>  		break;
> @@ -754,6 +757,33 @@ static void set_vm_context_page_table_base(struct
> kgd_dev *kgd, uint32_t vmid,
>  	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base); }
>=20
> +static void program_trap_handler_settings(struct kgd_dev *kgd,
> +		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr) {
> +	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> +
> +	lock_srbm(kgd, 0, 0, 0, vmid);
> +
> +	/*
> +	 * Program TBA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
> +			lower_32_bits(tba_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
> +			upper_32_bits(tba_addr >> 8) |
> +			(1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +	/*
> +	 * Program TMA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
> +			lower_32_bits(tma_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
> +			upper_32_bits(tma_addr >> 8));
> +
> +	unlock_srbm(kgd);
> +}
> +
>  const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>  	.program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>  	.set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping, @@ -774,4
> +804,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>  	.get_atc_vmid_pasid_mapping_info =3D
>  			get_atc_vmid_pasid_mapping_info,
>  	.set_vm_context_page_table_base =3D
> set_vm_context_page_table_base,
> +	.program_trap_handler_settings =3D program_trap_handler_settings,
>=20
> [HK]: Naming  not consistent. program_trap_handler_settings,
> program_trap_handler_settings_v10_3 and=20
> kgd_gfx_v9_program_trap_handler_settings
>=20

I am following the naming convention for the other functions defined in the=
se files.
That's the reason the functions names are different. I don't mind naming th=
em all the same.

[HK]: Thanks for clarifying. I am fine with as it is.

>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index 1f5620cc3570..dac0d751d5af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -537,6 +537,9 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd,=20
> void *mqd,
>  	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
>  		type =3D RESET_WAVES;
>  		break;
> +	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +		type =3D SAVE_WAVES;
> +		break;
>  	default:
>  		type =3D DRAIN_PIPE;
>  		break;
> @@ -658,6 +661,33 @@ static void
> set_vm_context_page_table_base_v10_3(struct kgd_dev *kgd, uint32_t v
>  	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base); }
>=20
> +static void program_trap_handler_settings_v10_3(struct kgd_dev *kgd,
> +			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr) {
> +	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> +
> +	lock_srbm(kgd, 0, 0, 0, vmid);
> +
> +	/*
> +	 * Program TBA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
> +			lower_32_bits(tba_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
> +			upper_32_bits(tba_addr >> 8) |
> +			(1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +	/*
> +	 * Program TMA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
> +			lower_32_bits(tma_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
> +			 upper_32_bits(tma_addr >> 8));
> +
> +	unlock_srbm(kgd);
> +}
> +
>  #if 0
>  uint32_t enable_debug_trap_v10_3(struct kgd_dev *kgd,
>  				uint32_t trap_debug_wave_launch_mode, @@
> -820,6 +850,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
>  	.address_watch_get_offset =3D address_watch_get_offset_v10_3,
>  	.get_atc_vmid_pasid_mapping_info =3D NULL,
>  	.set_vm_context_page_table_base =3D
> set_vm_context_page_table_base_v10_3,
> +	.program_trap_handler_settings =3D
> program_trap_handler_settings_v10_3,
>  #if 0
>  	.enable_debug_trap =3D enable_debug_trap_v10_3,
>  	.disable_debug_trap =3D disable_debug_trap_v10_3, diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index ed3014fbb563..154244916727 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -42,7 +42,8 @@
>  enum hqd_dequeue_request_type {
>  	NO_ACTION =3D 0,
>  	DRAIN_PIPE,
> -	RESET_WAVES
> +	RESET_WAVES,
> +	SAVE_WAVES
>  };
>=20
>  static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev=20
> *kgd) @@ -566,6 +567,9 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev=20
> *kgd, void *mqd,
>  	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
>  		type =3D RESET_WAVES;
>  		break;
> +	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +		type =3D SAVE_WAVES;
> +		break;
>  	default:
>  		type =3D DRAIN_PIPE;
>  		break;
> @@ -878,6 +882,32 @@ void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev=20
> *kgd, int pasid,
>  				adev->gfx.cu_info.max_waves_per_simd;
>  }
>=20
> +static void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd=
,
> +                        uint32_t vmid, uint64_t tba_addr, uint64_t
> +tma_addr) {
> +	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> +
> +	lock_srbm(kgd, 0, 0, 0, vmid);
> +
> +	/*
> +	 * Program TBA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
> +                        lower_32_bits(tba_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
> +                        upper_32_bits(tba_addr >> 8));
> +
> +	/*
> +	 * Program TMA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
> +			lower_32_bits(tma_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
> +			upper_32_bits(tma_addr >> 8));
> +
> +	unlock_srbm(kgd);
> +}
> +
>  const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>  	.program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
>  	.set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -899,4 +929,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>  			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>  	.set_vm_context_page_table_base =3D
> kgd_gfx_v9_set_vm_context_page_table_base,
>  	.get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
> +	.program_trap_handler_settings =3D
> +kgd_gfx_v9_program_trap_handler_settings,
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a972ef5eae68..6fd6b2248992 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -211,6 +211,14 @@ static void deallocate_doorbell(struct=20
> qcm_process_device *qpd,
>  	WARN_ON(!old);
>  }
>=20
> +static void program_trap_handler_settings(struct device_queue_manager
> *dqm,
> +				struct qcm_process_device *qpd)
> +{
> +	return dqm->dev->kfd2kgd->program_trap_handler_settings(
> +						dqm->dev->kgd, qpd->vmid,
> +						qpd->tba_addr, qpd-
> >tma_addr);
>=20
> [HK]: Since, this is not defined for all GFX generations, safer to=20
> check if function pointer is not NULL. I see it is called only VEGA10+
>=20
Sure I can add that. However, I am making sure that the function is defined=
 for all ASICs after VEGA10+.

Regards,
Mukul

> +}
> +
>  static int allocate_vmid(struct device_queue_manager *dqm,
>  			struct qcm_process_device *qpd,
>  			struct queue *q)
> @@ -241,6 +249,10 @@ static int allocate_vmid(struct=20
> device_queue_manager *dqm,
>=20
>  	program_sh_mem_settings(dqm, qpd);
>=20
> +	if (dqm->dev->device_info->asic_family >=3D CHIP_VEGA10 &&
> +	    dqm->dev->cwsr_enabled)
> +		program_trap_handler_settings(dqm, qpd);
> +
>  	/* qpd->page_table_base is set earlier when register_process()
>  	 * is called, i.e. when the first queue is created.
>  	 */
> @@ -582,7 +594,9 @@ static int update_queue(struct=20
> device_queue_manager *dqm, struct queue *q)
>  		}
>=20
>  		retval =3D mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
> -				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
> +				(dqm->dev->cwsr_enabled?
> +				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
>  				KFD_UNMAP_LATENCY_MS, q->pipe, q-
> >queue);
>  		if (retval) {
>  			pr_err("destroy mqd failed\n");
> @@ -675,7 +689,9 @@ static int evict_process_queues_nocpsch(struct
> device_queue_manager *dqm,
>  			continue;
>=20
>  		retval =3D mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
> -				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
> +				(dqm->dev->cwsr_enabled?
> +				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
>  				KFD_UNMAP_LATENCY_MS, q->pipe, q-
> >queue);
>  		if (retval && !ret)
>  			/* Return the first error, but keep going to diff --git=20
> a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 95c656d205ed..c84bd7b2cf59 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -44,6 +44,7 @@ struct kgd_mem;
>  enum kfd_preempt_type {
>  	KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN =3D 0,
>  	KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
> +	KFD_PREEMPT_TYPE_WAVEFRONT_SAVE
>  };
>=20
>  struct kfd_vm_fault_info {
> @@ -298,6 +299,8 @@ struct kfd2kgd_calls {
>=20
>  	void (*get_cu_occupancy)(struct kgd_dev *kgd, int pasid, int=20
> *wave_cnt,
>  			int *max_waves_per_cu);
> +	void (*program_trap_handler_settings)(struct kgd_dev *kgd,
> +			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
>  };
>=20
>  #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
> --
> 2.17.1
