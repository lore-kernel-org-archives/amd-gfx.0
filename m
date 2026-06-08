Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73168CD8CA7
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 07:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C97210E11B;
	Tue,  9 Jun 2026 07:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="Tjvb2C1d";
	dkim-atps=neutral
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D592F10F3DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SdtSMqQc9/9L4hcYUe8DcymDKslCu6j35bSDbEa+jUk=; b=Tjvb2C1d3qxle08aU/I+4amIZ6
 sLrjUuu9sXXkGad3Rrn6q8QcwakwcxehKexft/dCvYWExhikne1426f+TpTpSHnYWV2e4P1txR3cs
 DN5k3ynCTSzEwBcIAC9WTbuIayPVphq2rcDjG5R7RuUoTUOKbuq2bNe38sKHAHWVfm/zQ4H2MPJNb
 KnQvbIWQxwcdnNqSNfm8kyfJ5IiZV0dEHmzI/NWlg64LdSrHeXjrRN1W3djS7Mc/dXNqE4aWV+8O/
 yvi2dGWxnNRKe2VNIzmedmBM+tT5vKZeBlyfmwPSWRyXunjXqq46Rc4owBTGlQNA+Uamk5Yn1F7th
 WzPKFfhQ==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr
 ([90.63.246.187]:18145 helo=archlinux)
 by pf-012.whm.fr-par.scw.cloud with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
 id 1wWa8I-00000002voj-3WJo; Mon, 08 Jun 2026 15:35:14 +0200
Date: Mon, 8 Jun 2026 15:35:12 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: "Kamal, Asad" <Asad.Kamal@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Message-ID: <aibDIZvSA9lPzjNx@archlinux>
References: <20260603114459.938031-1-asad.kamal@amd.com>
 <aiaEMl-b5qo6dmL6@archlinux>
 <DM4PR12MB5038BE603641525F68C9C3018E1C2@DM4PR12MB5038.namprd12.prod.outlook.com>
 <aialwv31-f-Rt06W@archlinux>
 <DM4PR12MB5038B0755743FC22E25C80FC8E1C2@DM4PR12MB5038.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5038B0755743FC22E25C80FC8E1C2@DM4PR12MB5038.namprd12.prod.outlook.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id:
 nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Tue, 09 Jun 2026 07:16:41 +0000
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


On Mon, Jun 08, 2026 at 11:48:52AM +0000, Kamal, Asad wrote:
> AMD General
> 
> Hi Nicolas,
> 
> Agreed that pci_read_config() has no lockdown check, standardized PCI
> config space reads are not blocked under [integrity]. But amdgpu_regs
> is not equivalent to config space reads. It provides arbitrary read
> access to the full GPU MMIO register space via RREG32, which is the
> same class of access as pci_mmap_resource(), a user-space mapping of
> the PCI BAR. That function is explicitly blocked at integrity with
> LOCKDOWN_PCI_ACCESS:
> 
> /* drivers/pci/pci-sysfs.c */
> static int pci_mmap_resource(struct kobject *kobj, ...)
> {
>     ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
>     if (ret)
>         return ret;
>     ...
> }
> 
> pci_mmap_resource() is blocked not only because the mapping enables writes, but because it grants direct, unmediated access to the BAR, the same unmediated hardware access that amdgpu_regs provides through a serial interface. The distinction is not read vs. write, it is mediated (config space via kernel abstractions) vs. unmediated (direct BAR/MMIO access).
> 
> The /dev/mem precedent reinforces this. open_port() checks LOCKDOWN_DEV_MEM (which is before LOCKDOWN_INTEGRITY_MAX) on open, blocking both reads and writes unconditionally, because raw hardware memory access of any kind bypasses the kernel's protection model:
> 
> /* drivers/char/mem.c */
> static int open_port(struct inode *inode, struct file *filp)
> {
>     rc = security_locked_down(LOCKDOWN_DEV_MEM);
>     if (rc)
>         return rc;
>     ...
> }
> 
> RREG32 on an arbitrary register offset is the GPU equivalent of a /dev/mem read of a BAR-mapped region. Blocking it at integrity with LOCKDOWN_PCI_ACCESS is consistent with both of these existing kernel precedents.
> 
> We prefer to keep the current approach.
> 
> Thanks & Regards
> Asad
> 
> -----Original Message-----
> From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
> Sent: Monday, June 8, 2026 4:58 PM
> To: Kamal, Asad <Asad.Kamal@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; StDenis, Tom <Tom.StDenis@amd.com>
> Subject: Re: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
> 
> [You don't often get email from nicolas.bouchinet@oss.cyber.gouv.fr. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Mon, Jun 08, 2026 at 11:03:05AM +0000, Kamal, Asad wrote:
> > AMD General
> >
> > Hi @Nicolas Bouchinet
> >
> > Thank you for the review.
> >
> > The commit message references v1 behavior and is no longer accurate. Writes are already blocked, the existing debugfs_locked_down() in fs/debugfs/file.c handles writes when FMODE_WRITE is set, the early-return guard fails and security_locked_down(LOCKDOWN_DEBUGFS) blocks the open under [integrity].

I didn't saw that your patch changed that much, sorry for that.
With the v3 version of your patch, since the debugfs regs files are not
even created it is indeed correct to use an `integrity` lockdown_reason
like `LOCKDOWN_PCI_ACCESS`.

Nicolas
