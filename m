Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC8606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nHyN1DtE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0147C10E00A;
	Tue, 27 Oct 2026 22:33:10 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F175710E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 22:33:02 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3a772ec8389so2330951fa.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793140381; x=1793745181; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wPmToGC5y+VhdITU4V4ZbBMK8thCOWUoBfhcPC5IseQ=;
 b=nHyN1DtEwE7ipAa2X/aijjlXzpRhFFKHL7WwVSGRaW9gD5kcidMJuIBTn+HreUVFWY
 xX4aBS+w/aFOMtxEcsrET80tXZVPEZiRDuM6qeuhKRByrzgKSzfonDn053sRjQZ0nOr0
 eLZlTjYruGIojeG8ixKELy3UvcsUR/jSKn0QJR8cZ31cV+DMR3n8iJXkMINluddn88Cg
 v6SQTBnJRSmV50A3y/EprnmQuyO/qnc/XCYFLMJwGZ7nQ3qx6P2jdguGgGBLgUBWu20K
 MQjQ90o6Xjhrs5v4RspVmTYloIm19WbUOzl8XoMONNz3zHVN4yMZOC7hKnON3kpT4JuX
 HGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793140381; x=1793745181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wPmToGC5y+VhdITU4V4ZbBMK8thCOWUoBfhcPC5IseQ=;
 b=i7PxPO+Q9Jp8RcRb9WXzPHwUq5UBHKIDsHBGOhZgvtKmmT46eu7LRFnE0C+eFmVGTl
 iY1AAX2LkDV8MKaDi8ZsUjzoowHyzlKGD1KJLmjnAXNRliivXvVahzvrwN4e1vcn+kTA
 RHPT5BcLTwWMow9RzQ5L0dRzSqvyDwVGGjJ4XhHFeDRtoX4WV+EJjyj9e44wQ/CbR1Y/
 WUxSJ87JfEWDHORItaChFd0yk1D7gnch6YK+STN3o+vgR1oa44J6bAwn+s8v2j76GJX1
 0jENi6J84vmF0ffuH+QKlc1VyBmtdLT6HrdpqOl+fQgAYe2hAySrPN9BJarfib7pTuxz
 Jqdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0CYLt16LUAUkLRP7PvKbWfZkoFDUGYy3uyh5DQRoOjnOoTW9aQ3sj+YM8JzmJXvZlOQj5/sT7@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIpu7q0MMJkbfBRv/hs//btng1xggaH2KcKO3I5zPn2sVd0ptPO
 UeOgdqxOcBIpYO0Qatg8lBojIl+1/lBRbIJ1EsNxAi02XUqetOSB1xHL
X-Gm-Gg: AYBFou0suxbKG56ARyYo/fep9CcfwPXAGc0gyTdcjFFdS9GvcOFUnNvVA+J4ScNhEl3
 9BYayTi7a2ZZy50+3k9SH6iUvVh1WM+6kuUCIeTPZi0664oRVxVt8AIBtBMQf4aVNPFCZD+OwEs
 7E44HC5p9ZlmgBed4+giXQbiOj4jWFXan8Q0/C5eikpk0U99rvWg7C3pVVm53L6JCpfIQvj8jEY
 qJIv26qR213eD/CM5qlbCf/5OomTjwnJF4LrrWY31KaxvlTpo0Rg/duj+/WqHXkvYxp6o+b+FoU
 h6ZJA3Mfx/KtypeIJVqGR4S9IpSyRH3nZTuiLR6inEL3ph13qFEAxh76/rL7OhozP22OX7ns5du
 SFdVhxRQ0IRPHkSxQH5Aj3hsisUkqVRtN44/O/4YXi73hmBVl6T4QIBhRRODvy3WGMcMtT4lKKF
 cgnjriSDanj9/9Rufvm3Kbx0UcCp1ckac1Ao+b0gdya9xPgNm6Iw0sWWgW/VyC/mb3MXUZPbKQi
 HGKbrdbi/UiobQzAo5fVOJomODf9zffOTs9i3eiiufRGqb5JnrFMCUoLNIpFYus+K9iormG6P/e
 a7/Fd/srP9FMYSjgM7HryOkLft7i3XRXWcNX9Vzx7rUk99F74hlo
X-Received: by 2002:a05:651c:4216:b0:3ab:690f:829f with SMTP id
 38308e7fff4ca-3ac9cf5b6d2mr759271fa.15.1793140380999; 
 Tue, 27 Oct 2026 15:33:00 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709d1c1asm27657721fa.16.2026.10.27.15.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 15:32:59 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 George Zhang <george.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Calvin Owens <calvin@wbinvd.org>
Subject: Re: [REGRESSION 7.3] drm/amd/display: single-frame scanout corruption
 on DCN32 at 120 Hz since a637a140ab86
Date: Wed, 28 Oct 2026 03:32:47 +0500
Message-ID: <20261027223247.300463-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018223905.32324-1-mikhail.v.gavrilov@gmail.com>
References: <20261018223905.32324-1-mikhail.v.gavrilov@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Calvin Owens bisected the same artefact to a637a140ab86 on his RX 7900,
with the same parent good, and posted a revert.  On his machine the
band appears within 30 minutes, and the revert removes it:

  https://lore.kernel.org/all/25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org/

#regzbot monitor: https://lore.kernel.org/all/25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org/

A correction to my earlier mails, which listed the instruction
constants and the stack among the DMUB windows that a637a140ab86 moves
to GTT.  When the firmware is loaded through the PSP, the default on
these cards, the driver neither copies the instruction constants into
its window nor programs the instruction and stack windows
(dm_dmub_hw_init(), dmub_srv_hw_init()), so the firmware does not run
from the driver's copies of those two.  The windows the driver does set
up -- BSS data, VBIOS, mailbox, trace buffer, firmware state, shared
state and the rest -- did move.

-- 
Thanks,
Mikhail
