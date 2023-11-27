Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89184C07CB1
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 13:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B946610E2A5;
	Mon, 27 Nov 2023 13:54:33 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC3A10E24E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 11:44:09 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1A39440E0031; 
 Mon, 27 Nov 2023 11:44:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jX3lP-NCWyzG; Mon, 27 Nov 2023 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1701085444; bh=ELUYa989rs/Q1r1rMywu+qeroXaCS1TWL2jrEJWHU/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F9s9/X26C/Ph1w0ByD8+3ZfuBni82sHS+PZZQGhOjHo9mS2lG7eNWR7Mz9XD9Vq5j
 6MQHqt5O4u4aOadL7lRzoCplG+zmulYwF/G+CRspKgli0frzKixPTswX14g3g+/0ZE
 OQN/byGnJnVOcN1nI6bWr3+x6ddxiZMZ8AN17FaA2PEoCOU9XTfmcfd8ivhtBwDnqb
 pomyoGGn1gr/5sf9AAwphLVxZGUHcWyT2AWOeoc/4OyAt7DXuoXc0jmkpm1Nttr6PD
 ci5h+Pm3DlG43yZZDCyPytiFb/IenmIJRaEGNL1IyHVviTaYi3TEF5ehHhZftQBGHu
 16tcvitSASIsfZnUmHuXkV77jy/7rFOThAUN8pfWfB9VZjCZu3w12LuAOsRqHU0C3d
 gikrjfbunIk0FIJ9vI22EJJ5M/Rhevcfqt0UCs6YYq2VmQhRS3lg7ZFAXOVvwwxZNO
 iAJMuNhjfO6dKtnasl2JFTeFzg8QM5v2XODy4bTPU3B4fBQTlnzOqApZxQwEZa5WE+
 Rd4xZRXD2BcRNH24H68NeDFDa/lOFb/erIsa3dd5bv9a92AGTAjj6AtyWEnrCUBPuB
 GLx1ity7vFD0pgYZNsnCBG+zrDKnb26rRb4AorjVAnfjCT9hyk39bvBCI2wSchU5Vj
 p7vWocI9Ym1Ad0c6dGO4QaY4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84EA040E01A5;
 Mon, 27 Nov 2023 11:43:55 +0000 (UTC)
Date: Mon, 27 Nov 2023 12:43:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 05/20] x86/mce/amd: Use helper for UMC bank type check
Message-ID: <20231127114349.GMZWSA9QADGqCXnTYe@fat_crate.local>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-6-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231118193248.1296798-6-yazen.ghannam@amd.com>
X-Mailman-Approved-At: Mon, 27 Nov 2023 13:54:32 +0000
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
Cc: tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, linux-trace-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Nov 18, 2023 at 01:32:33PM -0600, Yazen Ghannam wrote:
> @@ -714,14 +721,10 @@ static bool legacy_mce_is_memory_error(struct mce *m)
>   */
>  static bool smca_mce_is_memory_error(struct mce *m)
>  {
> -	enum smca_bank_types bank_type;
> -
>  	if (XEC(m->status, 0x3f))
>  		return false;
>  
> -	bank_type = smca_get_bank_type(m->extcpu, m->bank);
> -
> -	return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
> +	return smca_umc_bank_type(m->ipid);

	return FIELD_GET(MCI_IPID_HWID, ipid) == IPID_TYPE_UMC;

after having done:

#define IPID_TYPE_UMC	0x96;

and you don't need that silly helper.

And then you can do more cleanups ontop by doing

        /* Unified Memory Controller MCA type */
        { SMCA_UMC,      HWID_MCATYPE(IPID_TYPE_UMC, 0x0)        },
        { SMCA_UMC_V2,   HWID_MCATYPE(IPID_TYPE_UMC, 0x1)        },

and have all the numbering properly defined and abstracted away.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
