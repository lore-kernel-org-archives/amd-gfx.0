Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 06:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E916661056
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 06:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E916661056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675E289C53;
	Tue,  9 Nov 2021 06:12:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 731FB89C53
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 06:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCG3TOX8DLXzjE+L5alG3/skTaLtl6lRBLjBgk4w9PSZ6oZSNaPesB+CdF9fR9j5+iInU5kG6ZolQC8n3JIa3+5TbNg3tsc3Mp46uIJ9+TAII6INXtOapsyPyVS5fOcTnj6Ub0qP0ckwitYF0fux7i8piZhD6j43hDUb1xnfW5fnQUxk7Tn/wvzPZXchJQ18jmdDexJYieup1PB3B59QeNin3Fn6vQCAcnNwVcSEPNvPKziMsSLkmOe6DQuilWz89YBmpp2CqnuGXnBGslNhfrjYsxwN5XdgOofpLIulqiAmyAd5/0s0shk7r/ylyUEKPL6pAmLUH4AHkTQFf7dIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Zw3vlTgj57LMF5ysOE5V8DAxUnDmIhjLL9yDwkvEr8=;
 b=oLPEk2UEo9Yz5gkZuL9yVrUcWzSBYynMdNPiTgO7eWkK7Wue1VOwLHuV4RHWM3X0fBIY+Nqo7NEY/J3mhs+GQwMQUvJYVp0A+q5t620SCpuKvxZNvNW/iftpmDGfArMnp+ulWMbrweINWd3d8quAtLyNSCQihcEmth96IOJlUDB5pu/NhDTwKyLf6EW/xQ/6VfYgomm5kr+0BAVeLDHt0oj76a/a+R+aOFqwsGGeUlWWqtwl7s83Kn1voYtnBntnavBa9klcF1NmC4NviHhFX/CeXoZWfVW75VDxhMPQ1SXUvdBjcYvVIddGTbJABe3lw+VE6SbwIl9/LthXix+2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Zw3vlTgj57LMF5ysOE5V8DAxUnDmIhjLL9yDwkvEr8=;
 b=B0Wrc0fK97Tzum94Ry2N6TuCFremlP5hbHCP38skzeKNQC8OlG4zvCZfVjeEIAWUs2htkwMexGyf/A2OTRuHxE5uGDQM+1MozAJL/kiFqA2+wC2OTgXSucGFEUONCDlDfmVgqw6g2BEyW5Sf9wr9+MNvaM9820hIe2n5BfFAcb8=
Received: from SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 by SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 06:12:00 +0000
Received: from SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2]) by SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 06:12:00 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Thread-Topic: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Thread-Index: AQHX1QpvVeATLBE+YUa3UHVfmzoPjqv6qrMAgAAMUJA=
Date: Tue, 9 Nov 2021 06:12:00 +0000
Message-ID: <SA0PR12MB43995DF3EBD469BE416B1DF4E3929@SA0PR12MB4399.namprd12.prod.outlook.com>
References: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
 <YYoGmHxlugJagJ70@lang-desktop>
In-Reply-To: <YYoGmHxlugJagJ70@lang-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-09T06:11:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e169b400-fd6f-4b9d-8798-bcd6d04b5dcb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1fd341b-f6c8-4cfd-7089-08d9a347d7a2
x-ms-traffictypediagnostic: SN6PR12MB2847:
x-microsoft-antispam-prvs: <SN6PR12MB2847B9A4BEEED786F615A53FE3929@SN6PR12MB2847.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vou8nM01xXYl4j4Zv0Od67qx/emtlMg644vjEHa3PQIKq1f/4K5u8qOaRTgcjOlSFKohg0qb1vGIcIxbDS/UoiSm288mnBnhyzFxLzmkZOMSZ91ikU7t6f1TQIILGEcZBQYGRg5eoYdmiUI8z4/GJNitSSJC/LHhNpHEhXjYjQgNlnwQhy3/xfcFx9qhGcK1RVuIhfarM3H0BTz9/Dul8XOFoOY0g98dNqMJStcYcFXK7VbOzqRO9ukmM9b4bBwkmewxXgXKA+OBKWV0U8x4g8O+DbgkhUzPMknYmzwWKCg+/8tA6V9fW8GQL6Nak+IqO5wF+stybG61ZG/n19U0BISgRjwqxe+rqko44CJOMsihZviTQ48i90ns7qGTcJ0I3c+97SqTN7Xnd8iwewSlqOCEnolFa/UA4I768GwgLBUyPJtMJF/+ORo0BpsUd5cJmb613ulvbKNNOfu8Qq5D1s+EF/EuxsQuUxiBtmrDrYeabgWkQZV1wKjZ8duKBoVCRLkaqPGP8WnYPOJaLPyDVa+HMaeyklm6bRCau7O0uCLC0vfeCJrz502emiSycQB5njXH0SLOUiEg99nc/GTHjc6ZT2CcgFmwlWbLoAhtQML0nLOUrhHfChs3E743OYV78PJyTToKP8mbEBRUOS2pzqpqIVdQ9SUV2Ycyw7sNR1a3niLpf5URvbQxmO8vZeaIzu1SK/Iax2BrXmnF+WipXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(33656002)(52536014)(5660300002)(7696005)(9686003)(2906002)(76116006)(4326008)(6636002)(508600001)(122000001)(66446008)(66476007)(66556008)(64756008)(83380400001)(316002)(6506007)(8936002)(38070700005)(6862004)(8676002)(38100700002)(53546011)(71200400001)(186003)(55016002)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EcuS3DrDP41NY9XdIc9KEoNPMeGObj+rNFFTIT12YkMhxJyWcF8cEp9+2jEl?=
 =?us-ascii?Q?RsSJgytFVEQS7U/8quN2aaWRPN2vmKVIzlCbluZlzyc20K+5hTtTmWrgAwoS?=
 =?us-ascii?Q?Dpg+4st7/+rfeABUe3Zvg+yQuMdnFqmV5fAJCbmYy10bIiigd70bxTB+xzfn?=
 =?us-ascii?Q?IhlspgYAEKSYNxLwMRJR9AywEPfj9E3cHxpPvqnUUhEB+twlVFV8i3/LZ0Gt?=
 =?us-ascii?Q?c82KjnyYMqx7DvwpN3JkSWg1FvKJ8P2WCVwsyVskVjA0Hydzzj/mz+s9Sp9P?=
 =?us-ascii?Q?VSdNevEkSlSHHijGCii9ao5M6uDiVHOeD0wK+bEvyxOeCZ/fDI8wkoozD+pv?=
 =?us-ascii?Q?sfdCbN789w0d2rVr0k5C++hxK2JRQIQzGa2bSR0iHeqTAU9cEW6HF6SY0WvW?=
 =?us-ascii?Q?oJZTPaTGjni2CIxYA4IQ/kSXRynLaSroYaMVamW2d+5U3GKihwg2FtR5/5c+?=
 =?us-ascii?Q?CDE+hXi9nBkkfODvITMe6uQshjh7DEaq0F+sGqty6B/siET5+75azsk0eyxy?=
 =?us-ascii?Q?s/6LZV9jPC5Nl92966bqFlUxKIY6AVb4Ynuktpks0lWPp+J0DtIRXF7hICQU?=
 =?us-ascii?Q?l5aZ/E47U5hmVESBMRqaHZxnY0ETTl+HtCgmIy4TN0rPlexP82YUb/Yoxmu7?=
 =?us-ascii?Q?VJm4jrKV2721cW3abP24SEL36HvOTmgVSYL1ykm8yrfdD/7C6D52LuL5JHhW?=
 =?us-ascii?Q?sxXV+IR8aZ36tpHwcAzHOI4DXnq/CDZGymDR6M39jwfx6XoPUhlXjhDbNvMD?=
 =?us-ascii?Q?YtVtVXWvhRIGgy5HX4AQjOfZ9kGJuNcuW7hVMIpANwG6yriDLdD0441LLNqZ?=
 =?us-ascii?Q?67NO965ae2ePZcIlDPVBVv2Du1CrmMuITXDgxet+rdQYeOdJltbuz8zZLhIS?=
 =?us-ascii?Q?obEPyLWX4+sVo4ThS4iI1J8PF70f+BqFyPzGnNEPwKdeYdSIXpW8VwrJF5oW?=
 =?us-ascii?Q?FhC09Vcv9GAP9JZrCcDyV34Ebqcc8QisPLsGRm3gyPzUsCN88jV2jbzbSa3c?=
 =?us-ascii?Q?/iqz35fth+SIOQXcvGZcQHw6Lj/22cELA2nzFx89XJY540NNLQI7H/LKe543?=
 =?us-ascii?Q?eex9j9k9mFm9GGsjWWFSAI41V4RiI5VoZW6DkRaYeZGXjOcFfuf/y86kIID+?=
 =?us-ascii?Q?3aQffcGluIJkYOQR1HRnZhyyOLkQ77PhBO3KS1jRv4U0wnhIRXX88DeV0E+8?=
 =?us-ascii?Q?kppipB2G6RMpy4Nz7bF5o9R93PS4EsX+TQnZ+bOepJWFLt8hILeMjZh8Y+2N?=
 =?us-ascii?Q?5r4e1i6A0NUQWU6Yu1RVLyeL8a9AbaZkMDEQ4NI6Fe/KFSnQ4m31mAxv1G2g?=
 =?us-ascii?Q?iRik/1Jz1FDj0BjqWVQYVi3yezjyMfWB5GnvT6Op0mK4LKhIchoLEQIRLlBv?=
 =?us-ascii?Q?sqjNGSuQalkK+G9n6xPM24D91n9t+7ExgTu+1jWLp56Zmzse2ow/dpKmSb6w?=
 =?us-ascii?Q?WGJQaWAKb9MqXRjlfHicggaAe8Ga5XS/IaTs+S+3tlEQWQyto0Dqt48atGdB?=
 =?us-ascii?Q?ynmOlEYS5QLWg/qkIs1tiR1pLlIRs5/RwdiNOdEkWxdoF2GsVwzNqgjJqOgS?=
 =?us-ascii?Q?ThuFhV2VoLf1cg6gVfiYmVbsr82w6hQO8sTN9moDkHnU5ayWmaAb8VRjzN1L?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fd341b-f6c8-4cfd-7089-08d9a347d7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 06:12:00.3506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49UDNWJNpJFxeGW+CulmGICxJaOiiDB9RnhosjYU2UjTyGGDUX1BcxuA/i6zpI24JKlrgS3dxMMCKfdtF19RLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Responses in line

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>=20
Sent: Monday, November 8, 2021 11:27 PM
To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain

On Mon, Nov 08, 2021 at 07:37:44PM -0600, Ramesh Errabolu wrote:
> MMIO/DOORBELL BOs encode control data and should be pinned in GTT=20
> domain before enabling PCIe connected peer devices in accessing it
>=20
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 25 +++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 55=20
> +++++++++++++++++++
>  2 files changed, 80 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h=20
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4c1d6536a7a5..d9a1cfd7876f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -300,6 +300,31 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_=
device *adev,
>  				      uint64_t va, void *drm_priv,
>  				      struct kgd_mem **mem, uint64_t *size,
>  				      uint64_t *mmap_offset);
> +
> +/**
> + * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
> + * @bo: Handle of buffer object being pinned
> + * @domain: Domain into which BO should be pinned
> + *
> + *   - USERPTR BOs are UNPINNABLE and will return error
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count incremented. It is valid to PIN a BO multiple times
> + *
> + * Return: ZERO if successful in pinning, Non-Zero in case of error.
> + * Will return -EINVAL if input BO parameter is a USERPTR type.
> + */
> +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain);
> +
> +/**
> + * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following=20
> +criteria
> + * @bo: Handle of buffer object being unpinned
> + *
> + *   - Is a illegal request for USERPTR BOs and is ignored
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count decremented. Calls to UNPIN must balance calls to PIN
> + */
> +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo);
> +
>  int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
>  				struct tile_config *config);
>  void amdgpu_amdkfd_ras_poison_consumption_handler(struct=20
> amdgpu_device *adev); diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c=20
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4fa814358552..f4ffc41873dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1299,6 +1299,36 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void =
**process_info,
>  	return ret;
>  }
> =20
> +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain) {
> +	int ret =3D 0;
> +
> +	ret =3D amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	ret =3D amdgpu_bo_pin_restricted(bo, domain, 0, 0);
> +	if (ret)
> +		pr_err("Error in Pinning BO to domain: %d\n", domain);
> +
> +	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return ret;
> +}
> +
> +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo) {
> +	int ret =3D 0;
> +
> +	ret =3D amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return;
> +
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +}
> +
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					   struct file *filp, u32 pasid,
>  					   void **process_info,
> @@ -1525,6 +1555,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  	if (offset)
>  		*offset =3D amdgpu_bo_mmap_offset(bo);
> =20
> +	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		ret =3D amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
> +		if (ret) {
> +			pr_err("Validating MMIO/DOORBELL BO during ALLOC FAILED\n");
> +			goto err_node_allow;
> +		}

amdgpu_amdkfd_gpuvm_pin_bo() will do ttm_bo_validate(),
amdgpu_amdkfd_bo_validate() seems redundant here.

Ramesh: In my experiments I recall seeing an issue if BO was not validated =
in GTT domain prior to pinning. If my memory serves me correctly, the call =
to PIN will fail

Regards,
Lang

> +
> +		ret =3D amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
> +		if (ret) {
> +			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
> +			goto err_node_allow;
> +		}
> +		bo->allowed_domains =3D AMDGPU_GEM_DOMAIN_GTT;
> +		bo->preferred_domains =3D AMDGPU_GEM_DOMAIN_GTT;
> +	}
> +
>  	return 0;
> =20
>  allocate_init_user_pages_failed:
> @@ -1561,6 +1608,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	bool is_imported =3D false;
> =20
>  	mutex_lock(&mem->lock);
> +
> +	/* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
> +	if (mem->alloc_flags &
> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> +	}
> +
>  	mapped_to_gpu_memory =3D mem->mapped_to_gpu_memory;
>  	is_imported =3D mem->is_imported;
>  	mutex_unlock(&mem->lock);
> --
> 2.31.1
>=20
