Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83008C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 08:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8E064FAB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 08:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8E064FAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79CD86E233;
	Tue, 16 Mar 2021 08:14:02 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-oln040092253073.outbound.protection.outlook.com [40.92.253.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8615A89C8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 04:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8RPflSiksp4achiQz+NH/u8y86b9x42IsmmXxUo4yD+UtzVp4+POiu5Y5nwT6QSxrirTb9cIR7Ix5FYyXLArLkjVID4tUw0DVF71vJZZ/rzTB/g9N87Z1jLwV9IlH3ETz0poKJzaIAqIv0nugcim22Dm49oX4jhCOr5Xb4dGcWL1WwaQzZtU/vFxUY9sUw4h6ClVPOulLaNU1lQWx9dGs0DiUoT/bJx4z0Ncutr1vMYcdQ54NNHpUXON9GYW33Ly8FwNhPRU9ihryplC93vshsXgsCx4iI/rXmt92SiH0EWVwgio/24a8S1jhfgIoVvt2MXnb4ftRi1wsXeJwpsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCrqT3oxY2eQUDzowutXCy9t1RXh7ki1SZ69DnXI/44=;
 b=hymGesbTWc9yvN8vYddj5ViUOVWvBvPhLc2H7S7dYS2XXz0hczIdpFtDqKvAWxENt26AsXXX9D1Gn4Bous7pwJ8N0AocOFbviPOCnxbYdT6f24UN55qJ2f4T5xXMzzJGUU+WQl8dx2226Jigfm3i5pooyWOt44egfKJwkJsyExFkkS0qsnwAz2HsWqwgEWqXxtPeIxBNu8J7YMcgf227Ppp0Z/2uwRUMaukVW0OAaGdRLexj/FX+Q/h1mSRdYaVME5CWJp1qwzsdTu/26iRNPKuoyi3BeoPnsuD0k4E3rCjv9GEskQtaV+i5jVMDvYzFsLDRRua7Xnh9I0f0DqYCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT055.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::49) by
 PU1APC01HT230.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::444)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 04:57:48 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.52) by
 PU1APC01FT055.mail.protection.outlook.com (10.152.253.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 04:57:48 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:DF2D472981E597764784FEF9262C19F99BD78A9F2BC5B85CC3CF878992E886A1;
 UpperCasedChecksum:15AAD3997D4DB2D8776CE9141617083C287013BCBB7D38D1CF8A89E5DF832473;
 SizeAsReceived:7866; Count:47
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::415f:2d37:68bd:23eb]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::415f:2d37:68bd:23eb%10]) with mapi id 15.20.3933.032; Tue, 16 Mar
 2021 04:57:48 +0000
Date: Tue, 16 Mar 2021 12:57:41 +0800
From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop legacy IO bar support
Message-ID: <PSXP216MB04388E729E6A4725B30B4FEB806B9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <20210315151714.1036424-1-alexander.deucher@amd.com>
 <4e026faa-28fb-5f76-aad6-25045c3b0cad@gmail.com>
Content-Disposition: inline
In-Reply-To: <4e026faa-28fb-5f76-aad6-25045c3b0cad@gmail.com>
X-TMN: [BsPzZHEXVLmJv0ot2jlgv85CrQyQ7uFCx4V7zFlYNFYI8Ex1r6SCltkC+ruIxvag]
X-ClientProxiedBy: ME1PR01CA0114.ausprd01.prod.outlook.com
 (2603:10c6:200:19::23) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
X-Microsoft-Original-Message-ID: <YFA6xf3yhCJU5xzS@nicholas-dell-linux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nicholas-dell-linux (2001:4479:c200:d00:be34:878c:be91:5d31) by
 ME1PR01CA0114.ausprd01.prod.outlook.com (2603:10c6:200:19::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 04:57:46 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 31a1c754-c79a-451e-a3d9-08d8e8380b46
X-MS-TrafficTypeDiagnostic: PU1APC01HT230:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: na3bB60rcEM0jIvUuvsANko8MmO3hO6xJC9Y4w/vJL2V9mWkBaAqEQyGFJW+JqwwVUgAIEfBmcyUKvsrx3c6mmYHV6SzCn8CI5oPCAx/FLfvsi1ltNpBDisuqcWBTDIOIWuK4tdznjBPP8akZ+6ukj7hvL1meLLPGdu2qqRbULIRZsforPNjssRw4nXu+x7TsxmKKtXrQx/0fxIZMgp6cjQCCuKhSnEoyEEJP6ilCw0IGQHOCe6ffJ+8aj4JIqKJ5h1/pf8FrqfkhqeQJvjdTSeooeeAvpplmBbu0FxORcOlhwDRDHPJ1xlrFYVfpXKijlJnOEAd3Kj+Lh8qMVTDT3XciLo9J9z8BTYEjssGzEvhIvg2AabgEoGtFVTmIl/hWpV+jjNL4uSCJHnjNbGWsw==
X-MS-Exchange-AntiSpam-MessageData: d3P9TPZXLOeCPUfGQYe75ocOSH1drGjYgBSGczlHKaKcBUGgSHAeOL8PSVf39+qLcRuBfawsRc7hWu2SPCPL3m0BSWlhgy4OGM2uLGedtLyFmBz/S++LkJy9pMeW/XMx8VrbhvajH2QAVLs92EWScq+Hna8jO5N8xebCaUhTMYqtCNI+twu9NEDmN5lFXmvFLTZGg2lP4XtWJmnsjxdqcA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a1c754-c79a-451e-a3d9-08d8e8380b46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 04:57:48.5643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT055.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT230
X-Mailman-Approved-At: Tue, 16 Mar 2021 08:13:59 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 15, 2021 at 04:26:49PM +0100, Christian K=F6nig wrote:
> Am 15.03.21 um 16:17 schrieb Alex Deucher:
> > It was leftover from radeon where it was required for some
> > specific old hardware.  It hasn't been required for ages
> > and the driver already falls back to MMIO when legacy IO
> > is not available.  Legacy IO also seems to be problematic on
> > on some thunderbolt devices.  Drop it.
Nitpick, "Thunderbolt" pronoun
> =

> Oh my, that stuff was still around?
> =

> And yes that is expected, there is probably no legacy IO space allocated =
to
> the thunderbolt hardware.
Sometimes there is legacy IO space allocated with Thunderbolt; that is =

when the issue occurs. It is possible that there is a Thunderbolt bug =

and the legacy IOs are black-holed or something. When no legacy IO space =

is allocated by Thunderbolt, amdgpu.ko uses MMIO instead, and everything =

works.

This patch to remove legacy IO support does not apply cleanly against =

v5.12-rc3, but patch -p1 managed to adapt it. I tested it. It solves my =

issue (instant amdgpu init when eGPU attached) and does not seem to have =

broken anything. Now I wish I had brought this issue up ages ago!

Tested-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Cheers!

Kind regards,
Nicholas Johnson
> =

> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> =

> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> =

> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  7 ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 43 ---------------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 57 --------------------
> >   drivers/gpu/drm/amd/amdgpu/atom.c            |  4 +-
> >   drivers/gpu/drm/amd/amdgpu/atom.h            |  2 -
> >   5 files changed, 2 insertions(+), 111 deletions(-)
> > =

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index f69e6389bdc6..e738ebbe738a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -876,8 +876,6 @@ struct amdgpu_device {
> >   	spinlock_t audio_endpt_idx_lock;
> >   	amdgpu_block_rreg_t		audio_endpt_rreg;
> >   	amdgpu_block_wreg_t		audio_endpt_wreg;
> > -	void __iomem                    *rio_mem;
> > -	resource_size_t			rio_mem_size;
> >   	struct amdgpu_doorbell		doorbell;
> >   	/* clock/pll info */
> > @@ -1109,9 +1107,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device=
 *adev,
> >   void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uin=
t8_t value);
> >   uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
> > -u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg);
> > -void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v);
> > -
> >   u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
> >   				u32 pcie_index, u32 pcie_data,
> >   				u32 reg_addr);
> > @@ -1202,8 +1197,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
> >   	} while (0)
> >   #define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\=
n", amdgpu_device_rreg((adev), (reg), false))
> > -#define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
> > -#define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
> >   #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
> >   #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atombios.c
> > index 86add0f4ea4d..e05648a8a145 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > @@ -1905,40 +1905,6 @@ static uint32_t cail_reg_read(struct card_info *=
info, uint32_t reg)
> >   	return r;
> >   }
> > -/**
> > - * cail_ioreg_write - write IO register
> > - *
> > - * @info: atom card_info pointer
> > - * @reg: IO register offset
> > - * @val: value to write to the pll register
> > - *
> > - * Provides a IO register accessor for the atom interpreter (r4xx+).
> > - */
> > -static void cail_ioreg_write(struct card_info *info, uint32_t reg, uin=
t32_t val)
> > -{
> > -	struct amdgpu_device *adev =3D drm_to_adev(info->dev);
> > -
> > -	WREG32_IO(reg, val);
> > -}
> > -
> > -/**
> > - * cail_ioreg_read - read IO register
> > - *
> > - * @info: atom card_info pointer
> > - * @reg: IO register offset
> > - *
> > - * Provides an IO register accessor for the atom interpreter (r4xx+).
> > - * Returns the value of the IO register.
> > - */
> > -static uint32_t cail_ioreg_read(struct card_info *info, uint32_t reg)
> > -{
> > -	struct amdgpu_device *adev =3D drm_to_adev(info->dev);
> > -	uint32_t r;
> > -
> > -	r =3D RREG32_IO(reg);
> > -	return r;
> > -}
> > -
> >   static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
> >   						 struct device_attribute *attr,
> >   						 char *buf)
> > @@ -1998,15 +1964,6 @@ int amdgpu_atombios_init(struct amdgpu_device *a=
dev)
> >   	atom_card_info->dev =3D adev_to_drm(adev);
> >   	atom_card_info->reg_read =3D cail_reg_read;
> >   	atom_card_info->reg_write =3D cail_reg_write;
> > -	/* needed for iio ops */
> > -	if (adev->rio_mem) {
> > -		atom_card_info->ioreg_read =3D cail_ioreg_read;
> > -		atom_card_info->ioreg_write =3D cail_ioreg_write;
> > -	} else {
> > -		DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\=
n");
> > -		atom_card_info->ioreg_read =3D cail_reg_read;
> > -		atom_card_info->ioreg_write =3D cail_reg_write;
> > -	}
> >   	atom_card_info->mc_read =3D cail_mc_read;
> >   	atom_card_info->mc_write =3D cail_mc_write;
> >   	atom_card_info->pll_read =3D cail_pll_read;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index e04ec3c83485..112749549c00 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -466,49 +466,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device =
*adev,
> >   	}
> >   }
> > -/**
> > - * amdgpu_io_rreg - read an IO register
> > - *
> > - * @adev: amdgpu_device pointer
> > - * @reg: dword aligned register offset
> > - *
> > - * Returns the 32 bit value from the offset specified.
> > - */
> > -u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
> > -{
> > -	if (adev->in_pci_err_recovery)
> > -		return 0;
> > -
> > -	if ((reg * 4) < adev->rio_mem_size)
> > -		return ioread32(adev->rio_mem + (reg * 4));
> > -	else {
> > -		iowrite32((reg * 4), adev->rio_mem + (mmMM_INDEX * 4));
> > -		return ioread32(adev->rio_mem + (mmMM_DATA * 4));
> > -	}
> > -}
> > -
> > -/**
> > - * amdgpu_io_wreg - write to an IO register
> > - *
> > - * @adev: amdgpu_device pointer
> > - * @reg: dword aligned register offset
> > - * @v: 32 bit value to write to the register
> > - *
> > - * Writes the value specified to the offset specified.
> > - */
> > -void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
> > -{
> > -	if (adev->in_pci_err_recovery)
> > -		return;
> > -
> > -	if ((reg * 4) < adev->rio_mem_size)
> > -		iowrite32(v, adev->rio_mem + (reg * 4));
> > -	else {
> > -		iowrite32((reg * 4), adev->rio_mem + (mmMM_INDEX * 4));
> > -		iowrite32(v, adev->rio_mem + (mmMM_DATA * 4));
> > -	}
> > -}
> > -
> >   /**
> >    * amdgpu_mm_rdoorbell - read a doorbell dword
> >    *
> > @@ -3361,17 +3318,6 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,
> >   	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
> >   	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
> > -	/* io port mapping */
> > -	for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
> > -		if (pci_resource_flags(adev->pdev, i) & IORESOURCE_IO) {
> > -			adev->rio_mem_size =3D pci_resource_len(adev->pdev, i);
> > -			adev->rio_mem =3D pci_iomap(adev->pdev, i, adev->rio_mem_size);
> > -			break;
> > -		}
> > -	}
> > -	if (adev->rio_mem =3D=3D NULL)
> > -		DRM_INFO("PCI I/O BAR is not found.\n");
> > -
> >   	/* enable PCIE atomic ops */
> >   	r =3D pci_enable_atomic_ops_to_root(adev->pdev,
> >   					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> > @@ -3693,9 +3639,6 @@ void amdgpu_device_fini(struct amdgpu_device *ade=
v)
> >   	}
> >   	if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
> >   		vga_client_register(adev->pdev, NULL, NULL, NULL);
> > -	if (adev->rio_mem)
> > -		pci_iounmap(adev->pdev, adev->rio_mem);
> > -	adev->rio_mem =3D NULL;
> >   	iounmap(adev->rmmio);
> >   	adev->rmmio =3D NULL;
> >   	amdgpu_device_doorbell_fini(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/am=
dgpu/atom.c
> > index 515890f4f5a0..3dcb8b32f48b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> > @@ -114,11 +114,11 @@ static uint32_t atom_iio_execute(struct atom_cont=
ext *ctx, int base,
> >   			base++;
> >   			break;
> >   		case ATOM_IIO_READ:
> > -			temp =3D ctx->card->ioreg_read(ctx->card, CU16(base + 1));
> > +			temp =3D ctx->card->reg_read(ctx->card, CU16(base + 1));
> >   			base +=3D 3;
> >   			break;
> >   		case ATOM_IIO_WRITE:
> > -			ctx->card->ioreg_write(ctx->card, CU16(base + 1), temp);
> > +			ctx->card->reg_write(ctx->card, CU16(base + 1), temp);
> >   			base +=3D 3;
> >   			break;
> >   		case ATOM_IIO_CLEAR:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/am=
dgpu/atom.h
> > index 4205bbe5d8d7..d279759cab47 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> > @@ -116,8 +116,6 @@ struct card_info {
> >   	struct drm_device *dev;
> >   	void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  fi=
lled by driver */
> >   	uint32_t (* reg_read)(struct card_info *, uint32_t);          /*  fi=
lled by driver */
> > -	void (* ioreg_write)(struct card_info *, uint32_t, uint32_t);   /*  f=
illed by driver */
> > -	uint32_t (* ioreg_read)(struct card_info *, uint32_t);          /*  f=
illed by driver */
> >   	void (* mc_write)(struct card_info *, uint32_t, uint32_t);   /*  fil=
led by driver */
> >   	uint32_t (* mc_read)(struct card_info *, uint32_t);          /*  fil=
led by driver */
> >   	void (* pll_write)(struct card_info *, uint32_t, uint32_t);   /*  fi=
lled by driver */
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
