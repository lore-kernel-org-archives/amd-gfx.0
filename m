Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98398606A323
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdHuICIg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C5410EEA2;
	Mon, 16 Nov 2026 09:28:42 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6972B10E05D
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Nov 2026 16:02:45 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so12075795e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Nov 2026 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794758564; x=1795363364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NHZIeryU1J/9Tg4kQWcesLp+ZRL5MdN2PYnUzIdJe2U=;
 b=xdHuICIgH0blV4KslWW9J5deWeDtdM9c2d+sCLTGeBcJnW8o0g0qrzHzufXJbvK63E
 BHQK0lCmxY1OahkWBikfUsH6e3PPr3T8a3S46Evj4xS22ABMGexj6NmQZcSQWn855wpE
 32q3L7Kt6sDL4tYxTLX7UVeetKtSrhQrYWdAQsfaDAdb50xnFTAF7LV0jkuOGot4TE0l
 UNJu1t2t4BOb8+aNYMCGfgDle2LwOGKFbHlir3jxYczIhXSNmEEG52VYAVs6EpnYpop+
 Yi8WqOdMvlS9O0eE37ALD1PTn84b9PRrxb2ho2IutQh+8DvcAw3mw8p6gnaL+8my5OiV
 LfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794758564; x=1795363364;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NHZIeryU1J/9Tg4kQWcesLp+ZRL5MdN2PYnUzIdJe2U=;
 b=FHiwlBt1ufb0Zv9fP4iHGECYX5nahHX2lJMJQb8Y8QKCcnhlBkuSPqiQ/R6g2XZMKK
 poQW9hfxA72wO0N4KknuSY0BsSMuixtw/49J9WSxvgyudZWnXsnsBaWVIMv4VG3LWwa3
 ilGGzmS9GIT0+R7KlM8ipNWCv1maxjB6ASZ8+jZbRlGQ1ThITv7yAxxfVU+PTuCPKdpO
 acvONvlgiWxw8PRruPXEJh8Us/Z6OQWNq7Tkr3S0rNh07g6s2707WZzFl9IXe5XVicKl
 o6t8sLRosJF/PPaqh/n59lbclMu7wmFlgnn8CCgkTiDlPZD7FoD7+TrETH7rUxrU9l+p
 35Uw==
X-Forwarded-Encrypted: i=1;
 AL+hErE6r8lR4bWpmE/Yt50OSqSExsoTR4xd6FE+Tsl15Dx/3xBVy3XiGRKMJkO6muXvEaV+4TAO0dvm@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9upefVmtlmtc3RHia7gUGJPQPqP6L4o/WXm5DZqVe/DftU+lx4
 nXvWQwHhz1NGBdT4nZwKuPr7NYxQ9b7MCXx6EhJCcJsG/ibqLLDMQ2JioaK2PHyy
X-Gm-Gg: AYBFou3QnLlIIuVbqSbg9bvGv51w+2ho4f4qsszJN4CSMLxc3n02VJTECzGmHjiDnCy
 LZTv5He9i8XBTa+k5DsKLpiBu44/38o3BArDOb1dQBr+VsknSpouE6X0jo3c6PNnbMLYR7lmp2t
 E7xw1z6yzd0o7uTSSUNYauWiu1dw5c5Q7Z7FKoUW4yYXuXv1KcPyTItkrSQYM1rDONg0XgKiXgi
 PiCFhE5VZiPAAIoLcaYenaV2NCUnx9Q0nEdltn4GKHgBEghcxFRWFtPPnMWCoiarqSRdNnOwQKg
 BBpwjENZyRTL3duMlA5o4p5BJXO7kAbNgh/lZ4tgN4HPUWg4xR6gKd3uNWzdOeDrS1iZKdE1nY9
 yWERxUvgOA6aENesJKLnJjNbBPoBAeGkluPT7elNa97kFtbiKgvrWGuQRIBBS9sf+cTSJfVumAE
 ioGIOTIEAteJmrpw9BzTfvWMCvUSOfuQrBiOVJEmDiboFXFf6MOoTcpz+RccunmEUlQB773rVLw
 AK2x4p8+sjli4GGswhCLiQoo+V99otDyxKsD6DwvUZ3X7fLfBlZT9eE6GrpCLpaj6NI5XAcjzJF
 kkcKztZpQ9lGBOnmJqjKxkZ+pkf2EwsN3Tv4aN5hR/mjyY9hMnpov2vfQBfBXx9VySh05dJyGml
 AusRreRAn0dDZJH+zwfnYkOy+qM8bNww3LS72TCZtxvU=
X-Received: by 2002:a05:600c:a0b:b0:4bb:6847:7927 with SMTP id
 5b1f17b1804b1-4bb68477b90mr76007525e9.7.1794758563469; 
 Sun, 15 Nov 2026 08:02:43 -0800 (PST)
Received: from rebar-v3-testedby.eml
 (host86-185-73-183.range86-185.btcentralplus.com. [86.185.73.183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56689bc2sm132025125e9.2.2026.11.15.08.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 08:02:42 -0800 (PST)
From: James R Taylor <jrtaylor11@gmail.com>
To: Geramy Loveless <gloveless@jqluv.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3] PCI: Reserve prefetchable window headroom for
 Resizable BARs
Date: Sun, 15 Nov 2026 16:02:23 +0000
Message-ID: <1794758543.190740.rebar.hermes@gmail.com>
In-Reply-To: <10fb16fb-2069-4d89-b473-1006ae5abfbc@jqluv.com>
References: <10fb16fb-2069-4d89-b473-1006ae5abfbc@jqluv.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 09:28:41 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Geramy,

On Sat, Aug 29, 2026, Geramy Loveless wrote:
> Firmware typically sizes prefetchable bridge windows for the boot-time
> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
> no room for a driver to grow a Resizable BAR afterwards

I've been running v3 since 27 October on a different kind of fabric from
yours, a USB4/Thunderbolt eGPU, and it gives the GPU its full BAR there
too. In case the data point is useful:

  Host:  Minisforum UM890 Pro (AMD Ryzen 9 8945HS, Hawk Point),
         BIOS 1.06
  Dock:  Minisforum DEG2 (Intel JHL9480 Barlow Ridge TB5 switch) over
         USB4, link 2 x 10 Gb/s
  GPU:   Intel Arc B580 12 GB, xe driver
  Kernel: 7.3.4 with v3 applied (it applies cleanly)

The firmware gives the USB4 root port 0000:00:03.1 a 64 GiB prefetchable
window, but the tunnel is enumerated as a hotplug event about 12 seconds
after boot, and without the patch the switch windows below it were sized
at 256 MiB, so the B580's BAR2 stayed at 256 MiB and a manual resize
failed.

With v3 the headroom is reserved down the chain:

  pci 0000:6a:01.0: bridge window [mem 0x400000000-0x40fffffff 64bit pref] to [bus 6b] add_size 3f0000000 add_align 400000000
  pci 0000:69:00.0: bridge window [mem 0x400000000-0x7ffffffff 64bit pref] to [bus 6a-6c] add_size 3f0000000 add_align 400000000

and xe then resizes the BAR when it binds:

  xe 0000:6b:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
  xe 0000:6b:00.0: [drm] BAR2 resized to 16384MiB

Both bridges above the GPU (69:00.0 and 6a:01.0) end up with 16 GiB
prefetchable windows, and the whole 12 GB of VRAM is CPU-visible. It has
been stable as a daily VAAPI/compute card since then. On 31 October I
also unplugged and re-plugged the dock while the system was running: it
re-enumerated, xe re-bound and BAR2 came back at 16 GiB.

One interaction that may be worth knowing about: with
pci=hpmmioprefsize=16G also on the command line, the TB5 switch's three
empty downstream (daisy-chain) ports each reserved 16 GiB as well. That
overflowed the 64 GiB root-port window, and the B580's BAR2 was briefly
assigned at 16 GiB and then rolled back with -ENOSPC. Without that
parameter it works as described above.

Tested-by: James R Taylor <jrtaylor11@gmail.com>

Thanks for the patch,
James

