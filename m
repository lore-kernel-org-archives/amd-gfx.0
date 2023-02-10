Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E711C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AC210EC8C;
	Fri, 10 Feb 2023 08:04:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89C910EC4F;
 Fri, 10 Feb 2023 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=4VsXfANm+kYIo05AeEA5j8t+IDPU2nct/ungBhLGgeA=; b=zDZkNlQCoG1oYpv5Yx8GSQwD72
 ysCRyQtNoBm4+WkyxQZr4qeRctvgDxbeNju2Wt5mhaiYAfFJ2Vfq+FfhF9TfeQVBNRVAi4JbrmNvZ
 a8sZo8LcSYw+TLpZSmdMPuVoc6yYuK1C+ciHAEaA8So3B0ye7MowMF96xnUd5AHCdgX6hJEtVFkdR
 psQRRgHD1bjorn83YxrM8gC5oRKffQtjMo39zhkaYuoK+CWQyw3XI2LgR3TonMCwmZqjk8oo0vFF8
 VS6ODdYFJq8U+73M+QV/rv1xTROz0P4plld8UomPNskPuPweKQBTkdfEp5m0hGHdq0PWN+N7nW7qJ
 pm7LL/sA==;
Received: from [2601:1c2:980:9ec0::df2f]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pQLBL-004D4t-9I; Fri, 10 Feb 2023 04:38:43 +0000
Message-ID: <0779deb4-7eea-e1b2-2394-7e5dd5e30d3f@infradead.org>
Date: Thu, 9 Feb 2023 20:38:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: error: 'const struct dc_dsc_config' has no member named 'is_frl'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 08:04:04 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

The 'is_frl' struct field is conditional:

#if defined(CONFIG_DRM_AMD_DC_DCN)
	bool is_frl; /* indicate if DSC is applied based on HDMI FRL sink's capability */
#endif

so code that uses it should be careful, otherwise build errors may happen:

../drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c: In function 'dp_active_dongle_validate_timing':
../drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:126:66: error: 'const struct dc_dsc_config' has no member named 'is_frl'
  126 |                         if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
      |   

Seen on arch=um and arch=riscv (RV64).

-- 
~Randy
