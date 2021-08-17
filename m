Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD323C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 18:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A573B60EFF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 18:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A573B60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666E96E223;
	Tue, 17 Aug 2021 18:46:54 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A7E6E221;
 Tue, 17 Aug 2021 18:42:24 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1175006a73053df3c19379.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f11:7500:6a73:53d:f3c1:9379])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67D751EC0559;
 Tue, 17 Aug 2021 20:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1629225739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=jwHmTRBxms0tT4WTh/1AEjKmHnFY2JEsZVwdmytONsI=;
 b=KUP43T/bbaLdWz5U9wKbKVFP3nxo6dCpoeUMqYVESUmDVYPqF7FOKus0G3XWX3cM5OK90C
 Z1nlDzK6oSVm6BUH703vTAa0VXAopMrWpN5FYaeDCJW+3HCE3QNA5Iw/IIGv3elLZjmMRp
 2mfXuzpSvQPweo6qtlAFOCuqNaxW0kk=
Date: Tue, 17 Aug 2021 20:43:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 06/12] x86/sev: Replace occurrences of sev_active()
 with prot_guest_has()
Message-ID: <YRwDN+hkQpuSp+Vt@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <2b3a8fc4659f2e7617399cecdcca549e0fa1dcb7.1628873970.git.thomas.lendacky@amd.com>
 <YRuJPqxFZ6ItZd++@zn.tnic>
 <b346ae1b-dbd3-cdbd-b5cd-b5ab9c304737@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b346ae1b-dbd3-cdbd-b5cd-b5ab9c304737@amd.com>
X-Mailman-Approved-At: Tue, 17 Aug 2021 18:46:53 +0000
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

On Tue, Aug 17, 2021 at 10:26:18AM -0500, Tom Lendacky wrote:
> >>  	/*
> >> -	 * If SME is active we need to be sure that kexec pages are
> >> -	 * not encrypted because when we boot to the new kernel the
> >> +	 * If host memory encryption is active we need to be sure that kexec
> >> +	 * pages are not encrypted because when we boot to the new kernel the
> >>  	 * pages won't be accessed encrypted (initially).
> >>  	 */
> > 
> > That hunk belongs logically into the previous patch which removes
> > sme_active().
> 
> I was trying to keep the sev_active() changes separate... so even though
> it's an SME thing, I kept it here. But I can move it to the previous
> patch, it just might look strange.

Oh I meant only the comment because it is a SME-related change. But not
too important so whatever.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
