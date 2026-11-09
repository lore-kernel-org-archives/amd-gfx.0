Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7347606A330
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KeDNwZxd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C3B10F3C0;
	Tue, 10 Nov 2026 11:44:13 +0000 (UTC)
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com
 [74.125.227.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3287310F456
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 17:13:32 +0000 (UTC)
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-3adfd217146so432574a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2026 09:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794244412; x=1794849212; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oeNE+sqLHyyLIoS+hr3FxhWoJgh8QINKzJXl7a9fZrI=;
 b=KeDNwZxdU8S+2XKJbfPFgxkNONBUtC5F2U+a7I1IY7uWpTYvUfLWKONYnV9CSG2FJd
 np3lljoymiwCAQd5FvR/BqLXThTNPf7bFxcW3dtXaTaKQfqTAGkYj0chYe8jNdgB0RSs
 3sWlgxGXrsVIYUPwmlL6QP87J4AU5/alDxFD6coIPdq5LjXeDrl2mRT13bN04t7FfDPc
 zDVPHrtqgmz5yK8LbI0YkNpfxjparh2rc/Ty2hjlfh4DMQDftAFXleCpEv6HmR+83AHj
 jPMJ7TqHJXoN03febAcZWT8caTsoi/el+02VPvID+nGZTewtobPG8q3nzGTUzvjC8lEP
 ohKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794244412; x=1794849212;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oeNE+sqLHyyLIoS+hr3FxhWoJgh8QINKzJXl7a9fZrI=;
 b=UoVnpNiQ7WKQxzP43PQfy5u/2wD3CY6GqV91B4sli1WFRK1dQ6onzgAnn/N5rYt70d
 kxXFq6Lol+Xf6VCHBJMrbDmDRXswlU2XfM+edjK9rdVne65K6DSDWwazJAA/7jCez4K0
 MJGJxjy2GDBMfc32DyexXOvS9WZHvsc4mbJtCDRJUOPcE7cBxRVBjhPllZU17dkGaIs8
 R0XZsgAVSvHv3w4ss9iXVpPqYpxlmWCNtofE/yn5OoUvkFcYNRI1qy2eBzaoaA1WKNjc
 I7N2MNxJ8XMX8El3faCuRNOQYlHXDnZzjTP3LBWSg8CNyyicb72KeE7WxGrWASzYdV4L
 ffoA==
X-Forwarded-Encrypted: i=1;
 AL+hErHR6TiQ3iQkH34OSGcT5NIGWqZ1uptLWWsAFUWdGBq2PrNsPyJx9nyoPmxj78ka9EK6BLkOglsA@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RZYGRChxrBZ8f737Lfl1JX5OfbJK1b5Fee6IvbhjTB6AsCWA7
 PeRQsF8TN+Y7U5I8kxOpamZoTJv2pTSLoUWe5oPEQxIHAXMvlAlA0VHZ
X-Gm-Gg: AYBFou1A1UzSMaV8FvPV6+prZCx3FuhdX1Mo+zfyhZUpdaO1aCAvpirDl9lStr8uSLO
 HPinaJKFFXDUgz4Yq6k1JSdxMOtZGq0jd7osWQ6+DjCLTfu+NzOlCc5XWzI8xGN58IgKVCPFGlj
 LQ+i/AN+OGfGJ2Px3JnPt61C09ndBtGr0ya1vLGfd3CGBRaKbfs0mjgIbqyeSUIoUkML4MJ5j5b
 EhqIbagmUCIvfK89ynHIqkrx0s4LIuGVB0YpKO764cCep9vDsuR6B+rIGL7keOvoj9+B47cYrqE
 XV48b9UelZZCiYfiSj3IeEOjgpdlD7mqlS/zmazJ56Ys2Qelx9yArt5HBL520NksqSQYCsyNFjt
 6UTE3524W4EBGvpi/JT5cVZ/uwOLnoxANjek3hw1eEQLkUSXEKSh1bDbisQnxvyhVdITUuMPctc
 L3NEKYlAgq3PbB9r/vj7xJc4fdjYXPRrTTF2Fweo9BVyyYY+tXdpSza+vpeDSHlSneeZ6vErbMH
 yiCyLdTp5nnCvCN6i1ov8ycbACo48sXQcLvAfyByhHWtJb50pZqCUehfhSiJgISusVdn8oySSrI
 wRS5ebxSFFNwlBvhRDm0XdcXkGSHOT5CS/UZYqKXuVfGFcEpuZoZOCD3maVJbBoFj9lKw56auJv
 PRwD40RXi7C1Lf68pfYIogc2EwfuVGGk0
X-Received: by 2002:a17:90b:586f:b0:3a8:cb54:e135 with SMTP id
 98e67ed59e1d1-3b166cd7343mr254891a91.19.1794244411414; 
 Mon, 09 Nov 2026 09:13:31 -0800 (PST)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1679c41aasm92356a91.0.2026.11.09.09.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:13:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 08/22] drm/amdgpu: implement SVM range notifier and
 GC helpers
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 10 Nov 2026 04:12:45 +1100
Message-Id: <179424436564.222336.1790875367286789154.b4-reply@b4>
To: Huang Rui <ray.huang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Felix Kuehling <felix.kuehling@amd.com>, Honglei Huang <honghuan@amd.com>, 
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, 
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>
In-Reply-To: <20261021025915.2433837-9-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-9-ray.huang@amd.com>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Tue, 10 Nov 2026 11:44:03 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ray,

On Wed, 21 Oct 2026 10:58:47 +0800 Huang Rui wrote:

> + * Invalidate the GPU view of @range over the notifier window: zap the
> + * affected PTEs and clear the gpu_mapped flag. The range is not removed
> + * here; structural removal if needed happens in the event-end phase.

I think this can leave stale PTEs behind when only part of a range is
invalidated. Take a one-page notifier event on a larger system-memory
range mapped with 4K PTEs. This zaps that one PTE but clears gpu_mapped
for the whole range, and then the event-end callback unmaps DMA for the
whole range. The other PTEs are still valid at that point, but their DMA
mappings are gone. A later notifier won't zap them either, because
gpu_mapped is already false.

Maybe the zap should cover the full range when its DMA mapping is
going away?

> +			if (crosses_boundary) {

Another case is GPU_RO going from 1 to 0 over a whole mapped
GPUSVM range. This branch isn't taken, so the PTEs are zapped but the
old DMA_TO_DEVICE mapping stays around. The next get_pages() sees valid
pages and reuses it, so the writable GPU PTE goes in without an
HMM_PFN_REQ_WRITE fault or a DMA_BIDIRECTIONAL remap. If it's a VM_WRITE
MAP_PRIVATE mapping whose CPU PTE still needs COW, I think it can miss
the write fault. So could the old DMA mapping be dropped before the
writable PTE goes in?

I couldn't tell from the cover which drm_gpusvm base this is on, so I
used 671b7825dbfe for both of these. I haven't reproduced either one on
a GPU, though.

Thanks,
Aveline Noir
