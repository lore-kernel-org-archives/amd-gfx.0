Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C46E7718E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 08:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146B310E429;
	Mon, 23 Dec 2024 08:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MSNn1fMq";
	dkim-atps=neutral
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C290910F009
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 17:27:39 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862b364538so1264386f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734715658; x=1735320458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
 b=MSNn1fMqxJO4L4QLAj09v32Ouiqnzt9yNWL7f9AVtL/ViM4bL9p22oY0gi1eN0yXhv
 oioQpiap2WK4oY3Akp1XemQ+Cj7GctPPhcc0IhJlaZ7uaCxgMVyoMdt40ARbaVmpNwR6
 m0wpaoPLDaisAosdWiHMDSkneGQwEvhIF6jTOvwzVFTy4lxEvTE9sNpGoI/wsgigLADa
 ImPZGYAYrh8RRxKmQEM7xW8d8u8DkI7paxjSsHA2B/ckxKzmaYfi4oaKoS0aaPOdmasI
 VigCJSJRazbUrOGQQ+IWhfKJYMWNFmYAPqjuHdNkmJwIb6QehUuWt2MfQXVrobRuiogU
 6s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734715658; x=1735320458;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
 b=VQe6bxIRZaDswtc1MI0hPWNExEclLI0Jpqscq+BKk3zggV9Sspj7fNgJfIDuYVAgVX
 QTXIOWT8Ce5X/p1DKbvOPNNYD8JZFjpwIZ187kYEcvJMK8ADqxvzoahrJKVs+c5uAH7Y
 SCPYGtB0btHPJl2P7sIhuW08FagbDZNZltH065khm3NjG1nmyHqcXfpmKVfSZFJZudh7
 sQBI+lgLdlXrTYvfpwfAGDZTFPyKiLqo+5nHM4sb7V8OHmBELJYLcUb5ao3x7+pN9SZC
 6C8tjTCL8ggzVxmUOtLWwRek729RPldLymFgZnY+sHsZWrj2FcHIfzrmbrSGTyEoGJYb
 I0Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdEXvz28pEQjRW5wcXv/cgQzlE5jA1Aq+2WlsqgalgdSM7E8HmnUUozoHRN3RrGtyu3/OIxLAG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLWiEJHUwjIshOmFH5LosDU0FTeOXQEZNWXZEUpEKmUdXI5NYR
 Y+CVyEyeWfQvtMa1zP1ZVzRzhj5TKeJ/TfnFKks3YAzWhtihYYIOvOfrAQLHjzw=
X-Gm-Gg: ASbGnct/R/Esx1jgL6k/zA5Jv/rOvKdllXBCR0tghvdCu+7ZD1bOfv3uy5hejmBiUp/
 sGQGNYpAfUq/tzpmEmiKe7s2H8ik2EFqNj6F6SnNWrJ2Gk7r6A1fbPQaj7WJezN70LnunFMLqb8
 G0mLPZf46zuAZgCb0Ca91atz82VtHinnP8V3EuoLCIZ73XQ234BvGJlVWdIYuTHk/TM0QszapuR
 staOse1WeinjmYPol3zg4B6Q0Mw7KN6opGbOVDTDUHwnxSc64rVcZbP7jEvC+kU6pXp+3jM72s=
X-Google-Smtp-Source: AGHT+IHQofl14bIpVpiQqz6qAEwAjKsEmWVjRCOjis6wH9jKfvKMjWLHCbYlsDgmYPDOjR7ci+Y7xw==
X-Received: by 2002:a5d:47c3:0:b0:388:cacf:24b0 with SMTP id
 ffacd0b85a97d-38a1a1f7253mr6745803f8f.2.1734715658179; 
 Fri, 20 Dec 2024 09:27:38 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e357sm4642915f8f.72.2024.12.20.09.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 09:27:37 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, audit@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-usb@vger.kernel.org, linux-mm@kvack.org, 
 maple-tree@lists.infradead.org, alsa-devel@alsa-project.org, 
 Sanyog Kale <sanyog.r.kale@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, dccp@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
 drbd-dev@lists.linbit.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-leds@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, tipc-discussion@lists.sourceforge.net, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/35] Reorganize kerneldoc parameter names
Message-Id: <173471565665.227782.7244101246430956449.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 17:27:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Mailman-Approved-At: Mon, 23 Dec 2024 08:56:35 +0000
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


On Mon, 30 Sep 2024 13:20:46 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> The misordered cases were identified using the following
> Coccinelle semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> [...]

Applied, thanks!

[31/35] slimbus: messaging: Reorganize kerneldoc parameter names
        commit: 52d3d7f7a77ee9afc6a846b415790e13e1434847

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

