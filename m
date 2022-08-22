Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E0DC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 14:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B331989DA9;
	Mon, 22 Aug 2022 14:10:23 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586828FBF4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 14:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1shTNXNYxM7Hv7zuvLcSDVqU9EF6FcJHL9OXfPtDyfGzUKKpKu8Vvzm0n85sWdAwlZpTHEJlBp8ik4PKRCD4nsx1MO0ng5+vh13FrqjQAayYPcO9FDg6elGjZhwQMJfS1MXwuY3thEi0FXokaEL6HzZy0aKSyBDVx+CT5ccsmam2SL3W5YasbHNWfhKL10yNFqA4mHIUR/tVMGGQZR0+RcuqSKhg2OgXXXPyWq4+/ob6ogjFlDdjMrpwNMVeMh9VieK0xb2F8BwClhVD9tQjPqNKkkzpwQ5CLOPreVQwNyEBz7g9gXW/4oVPTdgUyz4gEgfj2cc+kdllXbEMX+eHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56bc91vVU6v/1fdP2dvXKFKw09mtXCDtAdpVQGmYe2w=;
 b=lcPGBtY+bHO8f2UuXmwCTNrihmB4xocxKuBXKdJIICWvkdaA22x6zSlfYqbcHzghBNVdP1oFaF81jnCSl1fhmrvaPXcma+rz4R3b04M5t0UNOgx7wNeqGws5tPwOgmqB16pOLHn3qR15fqeiKZLavz7ejf0ur7h1eceboyF9D1Z4H5bR3Mq9yT0sDL8yeOWSE8Ps+STdk45qDThMheA795/mJ8VneSnKbagMDuiHoeo5ReUTz4SULnWkBS87g/uCY0M+xuAYJ00on4TV4miN+xa9LmGFnBXCejZpDuoEfy5i5ivczzAZZ0jIXZcJ1pPtDC5YbdsEjhMnwDTsdk5vMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56bc91vVU6v/1fdP2dvXKFKw09mtXCDtAdpVQGmYe2w=;
 b=wIxLNp3CgJGieBdizNrhPrPb2XpPxBjIOL5WLdGACam6+va8OkUk8oNZCdY+q1VKvmzUDMsE8JGseuXlhfyxtQdoqk8vxcst0rzv6huy2FRGRzcY6gq6BQTF1Ukiq4hh5/kI4Eayo3k3OE45vm2vMk6/Y6plTCd/zZaRyna+q1k=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.22; Mon, 22 Aug 2022 14:10:04 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 14:10:04 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Allocate doorbells only when needed
Thread-Topic: [PATCH] drm/amdkfd: Allocate doorbells only when needed
Thread-Index: AQHYp2rCo23YZ8/qaUKYa4PjLqPqkq27Eq/A
Date: Mon, 22 Aug 2022 14:10:04 +0000
Message-ID: <DM5PR12MB13080A78CC402FE1079EDB7285719@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220803185543.36786-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220803185543.36786-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-22T14:10:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=783ec88d-eda7-42d8-9b91-bd7d678cf9bf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 493f7013-aa05-4dad-cb8f-08da84480299
x-ms-traffictypediagnostic: CY5PR12MB6201:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMXACbPG0xMb2+3aupo3rg8rAi7g3A5KzLTsHeBhT/T8GPe/fh6yLrVVWcIrGAnNIod7JTIlD+48l54gLmFxHOlsSO3JknCo3iY93Ieb/235kB3+Cfe228F+MPLuK2iboqSexd280j4qxR9nK9OAxbW47vhFVhERG8gCW3AfvAO/H3eIxEv0fa+mseE0PsW87qeH65DCklSgRBlqB8mpv4cnJKUZzzJm93OtdQyP9fjYEGR+jUmn1hpJ1DcKhp0oxD2lFLeTyajTt77FjB8klmtU5VxTBYvZWEooI1uiwdavrIaCur+4MA82TJNzceJh3CM4wO5oQBDukCRecW6+ddeC/4jCxcG7Oq98Fdqra4iqZHISRLmOmnlo8y7MZm9CEbRFPMoBp2sPp25W4RI0vUi3cyExjsxkXW8OH/c1fs17Ma+8PbHTXrZ8kyz1dDGKrwalvN5lWAHXBMBg8Ae7hZofvo+/4JJJdnujanyed+9bethrG9u7ULCH0a9OUrIIJtpn9DAoAFR83ACVWAMDQsFTh/rgzrLxNax7FZJNETNwdjjn+rTlKCYgNRp/CP5fatClVUTip0eOMJqoQhM7CeKythbLXokkX4yKoJow9ooocVa83UmDbmj+0JnRQqg0agU3tXLr+kb+gZIxhs5qFvNr/gyRt42hjX9oFP/3S1GxC/PZi8uNJeyVIf+Iu2CvKROaYxpUx8l0yNAAliqpK4giuWSe2s8DzUcSW2qWN4PIxwzb51N+WNO7RuWl8XPmf9KY6CKLCTFmPC2ErS3wjg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(6506007)(7696005)(71200400001)(41300700001)(478600001)(186003)(8936002)(83380400001)(9686003)(26005)(52536014)(53546011)(2906002)(5660300002)(55016003)(316002)(110136005)(76116006)(64756008)(66446008)(66556008)(66946007)(8676002)(66476007)(86362001)(38100700002)(122000001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aD1sGByrTG7o7f0dNgi128TdAOU3IDfI0F0zbj3uQsIlOTBqg+HuDhd3bE3K?=
 =?us-ascii?Q?pvgGuC7ckmMeNdyXL3tdn8tC4Z/2N0vUr3BjQnNcvzYUpa3aGlqJZ/IThFKx?=
 =?us-ascii?Q?8mi3t9oR0qKqBTAvnVomyFcrYYI/Szo2C3J7X+7r1WFIsEEv+mF7U3L2FQGl?=
 =?us-ascii?Q?jn0ui6ySGSJFi6JGz0qGk5DD/vz+F4c5tGFbmuz4Jsp8bHrjm2uufxp1At2+?=
 =?us-ascii?Q?55fWFCy5cKsGp2xFqWSYMmHdEGkp1cBMVBERSCoG+zxOrI4V4qdXrBSs+yzo?=
 =?us-ascii?Q?FP+TBtvUKzdr+O5VaDH8cAJLfgMH2hxUjkQAHAgOK8YueSIJ56XvpuMsWMc/?=
 =?us-ascii?Q?6eA9UUzYOMU+pLkrUnDwNZviUj9RbAkD4DGPeUSq3tsdfhM/CARb8MS5BxSo?=
 =?us-ascii?Q?XfmccHmXt7fY7Owkgg/QS8Ym9r9LEtVPlra7XdL+HKUG70TY7yZhVk7nPbB0?=
 =?us-ascii?Q?D1kAplUroimx7VckNRmBcr89bPlcZFPwFT1mRou510wGXX9lmOHvo6gPbBee?=
 =?us-ascii?Q?8esxX6LRPK+M+jIPWGxSjaBpZsUzlMch6DcIwtAvpXkDq6SwtqkCx3aH1a2W?=
 =?us-ascii?Q?L1p9sf/gbKLhTRbsczs3cM0TsexdWXz2Hdu9S99OtV56Sfk65x1xs/i0ik6W?=
 =?us-ascii?Q?S5tOVJRdkfY9scfWEo2EAhTJvTkjiDnytn7PwMIDEUq4Yumhfsz4740ndRdn?=
 =?us-ascii?Q?bgPIt405zu5I7MEjjCAHPby+lKjnY77nXCveqJpQRzKLF3rmnZjSXjXlFsKH?=
 =?us-ascii?Q?lEl32uxJjCyGGfjBslRgGc471lCVx+Br/h+RD6eVkygqdzffntG+T1wK5kvy?=
 =?us-ascii?Q?zdud5hcshUceM180+aEu7XngTr6fCKBvZ548jr77o9oan5qKI8HpJIi8NWPO?=
 =?us-ascii?Q?tG6HUDU++6cGqNJNeIZsbPb6AY1yohnObbZq8Vsg2ULd3FT8jjlBmJ1T//Z6?=
 =?us-ascii?Q?QH4sPOqc8Fqg3O5Ap4VPsAxH1z34f6k9AiWxHTLwoZnOGCUCL56nDj88EPJQ?=
 =?us-ascii?Q?hg/fYp0reYVkOru0kQ9CFTfJ17Ui7Li8fH3f7DSeoFlIcBNktHQVV8IgdYih?=
 =?us-ascii?Q?z4Z9Vk/B3MsV9ZyH1bBl2+oL8YG051FE6uUj63wtvoorSbqDBeQ4NJPukIar?=
 =?us-ascii?Q?u0JNYdXiL5qyZnOYSAb0PerDHrqbpGy7Aad2LjkTySv5Sadfj+rWnOe4FTpF?=
 =?us-ascii?Q?1i9EdsY7nJeTu8keSKwPhShvdFjhcJWI6Dp+SyWd2HuX6Ab/XbU3EuM51gRZ?=
 =?us-ascii?Q?3E3R/W0DL4ha9Y7Qp4WO/f44ia1IAF+iQzcMp82MPmHDlENMdcVzNMkpqIyu?=
 =?us-ascii?Q?JkmFdQ13pgz/g0E8fu9CdSDRgl6Ov8ukhhx4XI8WK4qfUqE1XhHeg/jModx5?=
 =?us-ascii?Q?zmBfcgrcW0Y5lCfVWzTMCFVkWI5i//9mgzmVTd7qqFJ7p1dB0Ts/we/y4h7E?=
 =?us-ascii?Q?D7eptMXJthieJP3xBXfqVh6hLamQwnlX3MpDfhORm3hxItFVa1FTw04m1I3e?=
 =?us-ascii?Q?c6w3XtW460tVoHtxyW+bQWsev7P2xQDI8sbGH/odGIlykivv3Nt8xzvtg9VK?=
 =?us-ascii?Q?MJlgOsubN6z71I195OE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493f7013-aa05-4dad-cb8f-08da84480299
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 14:10:04.2023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9UEvNuac/DNJK0g514oKKauYrb6p41E8ul2oAQsaRYtm+X6eQytwWFyfNiNikcm1ExHYRsSL/B0u8bx4pVubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201
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

[AMD Official Use Only - General]

I can throw an Acked-by: Kent Russell <kent.russell@amd.com> since we don't=
 have an RB yet.

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Wednesday, August 3, 2022 2:56 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdkfd: Allocate doorbells only when needed
>=20
> Only allocate doorbells when the first queue is created on a GPU or the
> doorbells need to be mapped into CPU or GPU virtual address space. This
> avoids allocating doorbells unnecessarily and can allow more processes
> to use KFD on multi-GPU systems.
>=20
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 13 +++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c |  9 +++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  5 -----
>  3 files changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2b3d8bc8f0aa..907f4711abce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -327,6 +327,12 @@ static int kfd_ioctl_create_queue(struct file *filep=
,
> struct kfd_process *p,
>  		goto err_bind_process;
>  	}
>=20
> +	if (!pdd->doorbell_index &&
> +	    kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> +		err =3D -ENOMEM;
> +		goto err_alloc_doorbells;
> +	}
> +
>  	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to
> determine work
>  	 * on unmapped queues for usermode queue oversubscription (no
> aggregated doorbell)
>  	 */
> @@ -404,6 +410,7 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct
> kfd_process *p,
>  	if (wptr_bo)
>  		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>  err_wptr_map_gart:
> +err_alloc_doorbells:
>  err_bind_process:
>  err_pdd:
>  	mutex_unlock(&p->mutex);
> @@ -1092,6 +1099,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct fi=
le
> *filep,
>  			goto err_unlock;
>  		}
>  		offset =3D kfd_get_process_doorbells(pdd);
> +		if (!offset) {
> +			err =3D -ENOMEM;
> +			goto err_unlock;
> +		}
>  	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
>  		if (args->size !=3D PAGE_SIZE) {
>  			err =3D -EINVAL;
> @@ -2173,6 +2184,8 @@ static int criu_restore_memory_of_gpu(struct
> kfd_process_device *pdd,
>  			return -EINVAL;
>=20
>  		offset =3D kfd_get_process_doorbells(pdd);
> +		if (!offset)
> +			return -ENOMEM;
>  	} else if (bo_bucket->alloc_flags &
> KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
>  		/* MMIO BOs need remapped bus address */
>  		if (bo_bucket->size !=3D PAGE_SIZE) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index cb3d2ccc5100..b33798f89ef0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -157,6 +157,8 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct
> kfd_process *process,
>=20
>  	/* Calculate physical address of doorbell */
>  	address =3D kfd_get_process_doorbells(pdd);
> +	if (!address)
> +		return -ENOMEM;
>  	vma->vm_flags |=3D VM_IO | VM_DONTCOPY | VM_DONTEXPAND |
> VM_NORESERVE |
>  				VM_DONTDUMP | VM_PFNMAP;
>=20
> @@ -275,6 +277,13 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>=20
>  phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>  {
> +	if (!pdd->doorbell_index) {
> +		int r =3D kfd_alloc_process_doorbells(pdd->dev,
> +						    &pdd->doorbell_index);
> +		if (r)
> +			return 0;
> +	}
> +
>  	return pdd->dev->doorbell_base +
>  		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 6c83a519b3a1..951b63677248 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1499,11 +1499,6 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_dev *dev,
>  	if (!pdd)
>  		return NULL;
>=20
> -	if (kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> -		pr_err("Failed to alloc doorbell for pdd\n");
> -		goto err_free_pdd;
> -	}
> -
>  	if (init_doorbell_bitmap(&pdd->qpd, dev)) {
>  		pr_err("Failed to init doorbell for process\n");
>  		goto err_free_pdd;
> --
> 2.32.0
