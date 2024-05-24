Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90706C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 09:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9657610E443;
	Fri, 24 May 2024 09:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QrpF3xvy";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D84310E03E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 04:50:44 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-1f44b594deeso3110865ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716526243; x=1717131043; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=OIptIV19IdFhks5FxO4qOze6Xd4kuAo9MJ+XTfG/tCk=;
 b=QrpF3xvy3gNcxr6zYFNDPx4onQnWv3QeY4J7JJexf2cTUloPUOEeJc32c5TD9OoIVq
 IAa3IYQNY6i7ygqsUa7y3ZIHGoxJNqks3z/DyTE2p4J9xCQ8vIYDTaWPB/ZF6ULqDUsn
 VcchkuaI/67aDXmlckSaCY0PcSlDYJEJriqtWj9L0CzJO4ZPBty7blfk/L67OdkyLQzT
 cvwPQGO/1H9mHK8AeUKlAWA8m32SJEa8ZGkBMpnugQovv/tC/Wy5vhCrl6/mSa7dzw4D
 aUQJjbn2Hm+5c7S4Jb1yJhkRCsp4qwzfQisaPJfo+zqg59sBDkcbX2Do2oPVy0QJzGAG
 LpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716526243; x=1717131043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIptIV19IdFhks5FxO4qOze6Xd4kuAo9MJ+XTfG/tCk=;
 b=lGG5dzqpSAJB8nka4MLie9gCK5uPpns5aaWfEwYYGLFNeMVNPsmFxtg5WGRtZYBhqy
 nf1GzKIvY/OSNSUd5a+jDCg9XQ+UeYennZKWa1UIqKxAARzJvISZpEsFXplOoTAFLJLJ
 9FpcQjXXBOSF/aKvDXL2bEblhaC97j14UGlBFQmUSUL60op+rAuiinbswh5zIUmE9flo
 zDkEA9hhA+8b7JYABZfvb4M5BtbEmZlYaIi9k2fj8mkjY0jraaGVJ/E0BYytBnnD5np8
 vk7QV+XTVgl37z1oOplRsY/E9vz2MctlC99kinSCF6JuNamTa1wzb5GP5Txzx+AeVcek
 wVUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXabLXI86nowSyssKB3pOD+oKCQ8DjfhAoFi6yRiHs0KzVZm+GcywFDO1NlVkGfPqhPRULm1jURZMtECT3bS7s4ks2PdFDoStGy/JgBuA==
X-Gm-Message-State: AOJu0Yw0O/0f61aAazy74cLqw6JK1yrcUSd1ZfDcRQhsD6Dl3K+mcGYo
 6l/s88k1L2RrxgLI9w7O6v6dWQ6Td6qc94AyzjRUkOmDbnpQM31+
X-Google-Smtp-Source: AGHT+IGph2ngJGkIc2ZoYCJl38SlsP/yXGoytXnEgHL9Q+wVYFcQgbKU4AH+MCEZUe8DoMBNd28k3w==
X-Received: by 2002:a17:902:64d7:b0:1f3:3f33:2873 with SMTP id
 d9443c01a7336-1f4486ed8afmr11797375ad.25.1716526243411; 
 Thu, 23 May 2024 21:50:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7ab7fasm4449235ad.81.2024.05.23.21.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 21:50:42 -0700 (PDT)
Date: Thu, 23 May 2024 21:50:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329072441.591471-14-samuel.holland@sifive.com>
X-Mailman-Approved-At: Fri, 24 May 2024 09:16:14 +0000
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

Hi,

On Fri, Mar 29, 2024 at 12:18:28AM -0700, Samuel Holland wrote:
> Now that all previously-supported architectures select
> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
> of the existing list of architectures. It can also take advantage of the
> common kernel-mode FPU API and method of adjusting CFLAGS.
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

With this patch in the mainline kernel, I get the following build error
when trying to build powerpc:ppc32_allmodconfig.

powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o

[ repeated many times ]

The problem is no longer seen after reverting this patch.

Guenter
