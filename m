Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97FDCCA482
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595BA94B10;
	Tue, 12 Jul 2022 14:21:41 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C7294AF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k2oIXUfjJQ7MnASxyn6ML/1gHakRG0HfyUiSodCKAyQ=; b=bW4XHhR0C7u9b0N8SG/S4Eg0T1
 UW+62YIDumm4SmgAOuyLNue+VAm2SGwS30MKNGFm930SxG49ZtXOQnEDz7IhYk7Ugrso2cEFdTv6Y
 HWrY6YkmS7ew2sRVNn/9MYcAuY/+jj6g2KddOL307tPNtv97cuDl5/BDnTIGNjtbnwtNoLGeGK1UL
 8gMmVyndM708XoY0vi3DZ1wbPK6S+aigUxuo1ydn96Zc9JznGkddDhK8Lhy7DbopM4BbsosJNU64H
 dONrSKAx6SrdvAxCxbMNEbc2sDKiww0EhxB2NM1ITHq5mgK/NTLyPjseYCeIyNLGwYP0QqIdhNHba
 q2FOWXvg==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oBGla-00Dd43-Od; Tue, 12 Jul 2022 16:21:34 +0200
Message-ID: <07125dd2-9730-5e93-f53c-ea9d18b640f8@igalia.com>
Date: Tue, 12 Jul 2022 11:21:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: remove duplicate dcn314 includes
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712135543.2639877-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220712135543.2639877-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: kernel test robot <yujie.liu@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 10:55 de 12/07/22, Alex Deucher escreveu:
> Several headers were included twice.  Fix that.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>


In the future, for new files, it's a good practice to keep includes sorted.
