Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234CEC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 15:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3754410E188;
	Thu, 25 May 2023 15:52:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A545E10E87B;
 Thu, 25 May 2023 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GTCv05NKX7fYVfcWA9mF9yBEXPLxaqPCHQmLNCv1ZJQ=; b=TJQ/U68WU/s2VYiJ/03J7kmoh+
 YblMToMJpjlLY+OOjtRXYhlbHukydmw3PUftGnI27aU1oJMzLVXvU3OYxSMvMHmhEtzU0tY9KhA/K
 mMDtIgHzw0Us/B5mctq1KmB0zDiCzIW8QQl2oo8eWAlFZnvsVmRgQWnbRpEkwzys0xhzTWdTEzcsR
 CJ/kw8rEjWcpI1k4GxbDPAuQDGGSTcR62w2b3jTFlXr+17TQyG7fVzVmJ5ur1bFaa/RL0UA8MRnYC
 8KZaYVgF8Fb5kNlHNEvEHQ8QlrrZM88RmzzNDbkzeYR6tJsKXJ0twKVQXskmpLGw6kXepWjIlJFX4
 UWb9YshA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1q27V6-00GBCU-2n; Thu, 25 May 2023 09:43:16 +0000
Date: Thu, 25 May 2023 02:43:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: enable more strict compile checks
Message-ID: <ZG8ttJ7VFrJCk8tB@infradead.org>
References: <20230524191955.252212-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524191955.252212-1-hamza.mahfooz@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 25 May 2023 15:52:00 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Kenny Ho <kenny.ho@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> +subdir-ccflags-y += -Werror -Wunused -Wmisleading-indentation

We have a config option for -Werror.  Blindly adding this will create
problems with too new (or sometimes too old, or just too weird)
compilers all the time.  Don't do this.
