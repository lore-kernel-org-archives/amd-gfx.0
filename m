Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71104C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 07:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1455F10E31E;
	Wed, 27 Apr 2022 07:13:10 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BBE10E0F9;
 Wed, 27 Apr 2022 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=EqlJFrirIuN6/jFpvQBt0qkjkLubUZLlF1k8KoDAy4k=; b=uhu0BxlOHFONUbyZvFxJlzeAMW
 kXw4JpR+R/pH8QNJyVrPbbge+XLRJzZAoUdN3Z2PkZHBH2XWYS1a7krBMS7pb9n+A2LNJPhI1QiNK
 hX+/NQW4/6U4rFdwMZ9epoM7TI43iMKifmrse7Db8Ru2VXKiz0XgzbpLE3H571/AdTCQjOLRXipTS
 AaG9IuxWM02eFPoZ0d4Q/lxCAXOy4tiiirhS9yRxu3h4abyfEi5Iw809hEnBC3C6uzZroiBaSWlAN
 DgLLIc6LTREGsB/sELD7dWuYWQ03KvhXI63UcSIoD0Eh9eiH01t2Z+tHPgYHboF+Wv1JGz94haSe0
 SkZGa4+A==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njWdi-00ABKS-3m; Wed, 27 Apr 2022 01:38:46 +0000
Message-ID: <88d7b912-a12f-4bc9-abe6-e221a37f2eb2@infradead.org>
Date: Tue, 26 Apr 2022 18:38:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdgpu: debugfs: fix NULL dereference in
 ta_if_invoke_debugfs_write()
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <Ymexw96moFElQvqG@kili> <YmeyEF4djrguNMEF@kili>
 <CADnq5_PmoHWzJ9Mh=-ghMzOexv20h-Du2hGsoaR0owdDBnc8iw@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADnq5_PmoHWzJ9Mh=-ghMzOexv20h-Du2hGsoaR0owdDBnc8iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 27 Apr 2022 07:13:09 +0000
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
Cc: Tao Zhou <tao.zhou1@amd.com>, David Airlie <airlied@linux.ie>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Candice Li <candice.li@amd.com>, John Clements <john.clements@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Alex--

On 4/26/22 07:47, Alex Deucher wrote:
> Applied the series.  Thanks!
> 
> Alex
> 

I just saw a build warning here when CONFIG_DEBUG_FS is not enabled:

../drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c:281:23: warning: 'amdgpu_ta_if_debugfs_create' defined but not used [-Wunused-function]
  281 | static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *adev)
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~


-- 
~Randy
