Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBC1C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5E910E256;
	Thu, 28 Dec 2023 10:02:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA2410E067
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 06:27:24 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id CB7F168D05; Thu, 28 Dec 2023 07:20:57 +0100 (CET)
Date: Thu, 28 Dec 2023 07:20:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 13/14] selftests/fpu: Move FP code to a separate
 translation unit
Message-ID: <20231228062057.GE12475@lst.de>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
 <20231228014220.3562640-14-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228014220.3562640-14-samuel.holland@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Thu, 28 Dec 2023 10:02:14 +0000
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

