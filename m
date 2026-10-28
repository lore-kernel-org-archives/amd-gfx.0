Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498FF606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YIsj3W/K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBCB10FC20;
	Wed, 28 Oct 2026 12:59:57 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D73E10E497
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 00:09:10 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36a17a332ecso525267eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793146149; x=1793750949; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rYaht9shbFWxq4kumOpndSaFwe2UdArezXMn/5BLyPQ=;
 b=YIsj3W/KaZBXuFx0CcUpWMVNmelk2ajCtOTITGfxbKcxlwegWUoSQulpZ/b9vxKcfg
 8PTQronEyF1aXX5X2Wvmh6NIQCRsL1X68+yRjQH5vR7loTraeZD2rOPGxrs4Vx7HMPVj
 rgUv8eX+/+T7dQ4g6k/5fmCrFtHzej3Lj0OG/AoTDBxJpnwAWuZdLQ4Xi2P77W8OlqiR
 0Lo8eHa/fmT3M6udzniTAb7r4Eks62nwf5s87a2qfwDDxXaMzIoSyXXpsDkCOGms1c65
 Ff2Cq+bpRKz5BG84Clfaa/s6XnF56dVQCqYAgDdlsio8wHAFr37VUFoXvEjrpk2UHfH+
 WBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793146149; x=1793750949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rYaht9shbFWxq4kumOpndSaFwe2UdArezXMn/5BLyPQ=;
 b=oMOSg8KK4xNMUvISlGlclihlrwVcsg4sSewJjUa91CPcvRwZ+JMeZN2zTaDi3nWtuA
 tcGZ9hW/pz0xXjVNlrA7+y6/morzVcj0M3Tr8KqesJvRJppa7PM9eeeiuGlxKtQ4z152
 Q02cA7xQvmiKEf0yX1w3wcQezOvnIN8fJ/ZJSl7geRhnCww7Ys0R4xNizh4PVs3ZMZmF
 Lc//P+dbex/9cl8cptAnI09imm34xsELjxsHyFfwTN4a1rDYmO8xO/q7bEjumglkx/8S
 hIUp7Q5WdyS6hnl/QtMTxv0cOCClPVkc40T2qCigaazLi6+1WMRqvIFkarQXXt9yM1vb
 45+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByKRMUeYtHKWsI4R6wAnwYkKP7nnEHzzQ7EI/LWpCYCAt+ndohJ5JSkToSc3rvtYqG/A7FFA6bw@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKhQJdelRrDyg7jyFs5lUMdK8mFX4+FFbSHmYTlsllAfyr0Ybfi
 ccL9Ms9WScQ5axMLg+RrhPSPFA2faqFpxEQkR49Hjq2ssRstbHtx4vg=
X-Gm-Gg: AYBFou0tMKCr3SeX56FzLmCKc3SRHXQeT6XG5O6o7lLZsCJRRhZzYhx9+J3Nh/YNBKO
 Lj9XifB/FucdX7vDzdzPbmVjjydFjNpFpgB2YjrqK7ndCUuxRKocz3/a68Yto8acprsxw/rB+jW
 1jfA0xc7IUnItca+MNj9ufoIj0RQIlRyrmQ/Iqd5KgPFi3Xwxjv3qwZ5uAy9/rrM7vHlQfdj2E2
 L+RU9xrivokoGw30bYGPbFro5JXvepyO0Lx0LzqTtQrolCQd4NrgbYyqi7oKRGN+B8czJNYD+M7
 vHCo8y3y7ZzrtSPLhQ3eKumm3h8kb8a6gMSdiCDUOue3QeI4FXPGwkJ8HPbO/Go0Xpt3e7+IU0Q
 VssL/i53YNNsDR1RFaZqpoTrSfxNgOH3iAmTIlIFmUU1U4qY9dMIREP9b3VzpiesULFCQUJ182u
 tSEFgxLx8rUG6venu+/yCVMu2URNH424Tur/R1w3/uEBNGFgLrKdWcvz8K8EewLPjxA6cPNLCRe
 oefWMMz7nAfUJf2HFr/CsqJicUIgHroC5Nb27zPKVwe7mEyjREbNWxxsjSMisBScUnc4z7oGVQC
 vLUv+N2TYJ/L2DwTIQ==
X-Received: by 2002:a05:7300:c7c3:b0:369:9af5:7bc9 with SMTP id
 5a478bee46e88-36a2017929amr1084712eec.23.1793146149163; 
 Tue, 27 Oct 2026 17:09:09 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.118.107])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a239198c9sm336354eec.15.2026.10.27.17.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 17:09:08 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: helgaas@kernel.org
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 bhelgaas@google.com, bp@alien8.de, christian.koenig@amd.com,
 dave.hansen@linux.intel.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com,
 hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com,
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH 02/13] PCI: Disable pcie port and access on D3 on specific
 amd devices
Date: Tue, 27 Oct 2026 20:08:41 -0400
Message-ID: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027230042.GA516670@bhelgaas>
References: <20261027230042.GA516670@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 12:59:51 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Reading or writing to PCI devices in D3cold is a problem on every
> system and we should avoid it in generic ways.  I don't know what's
> special about these MacBooks.

I did not know about, i will try to remove the ignore_access code, and
will tell you the results, i added it as a failsafe

> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -688,7 +688,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> >  	int type = pci_pcie_type(dev);
> >  	int status;
> >  
> > -	if (!pci_is_pcie(dev) ||
> > +	if (!pci_is_pcie(dev) || dev->no_pcie_port ||
> >  	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
> >  	     (type != PCI_EXP_TYPE_UPSTREAM) &&
> >  	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
> 
> Nor does this.  I don't know what the purpose of this is.

This is however nessacary, without this The CPU just catters, so something
used the PCIE address space or the config space of the bridges, unfortunately
dmesg dosent show anything or journalctl.

