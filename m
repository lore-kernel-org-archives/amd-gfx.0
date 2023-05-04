Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343C5C7EE21
	for <amd-gfx@archiver.kernel.org>; Thu,  4 May 2023 14:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85AD10E13B;
	Thu,  4 May 2023 14:11:14 +0000 (UTC)
X-Greylist: delayed 539 seconds by postgrey-1.36 at gabe;
 Thu, 04 May 2023 14:11:13 UTC
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B25010E13B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 May 2023 14:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 94DD33FBB2;
 Thu,  4 May 2023 16:02:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
 dkim=pass (1024-bit key) header.d=shipmail.org
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
 by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4JwO5kl3RK6X; Thu,  4 May 2023 16:02:10 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id A839A3F803;
 Thu,  4 May 2023 16:02:09 +0200 (CEST)
Received: from [192.168.0.209] (unknown [134.191.233.202])
 by mail1.shipmail.org (Postfix) with ESMTPSA id 3567736320A;
 Thu,  4 May 2023 16:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1683208929; bh=wji9d2iAOOfk/BDD0gA06+mO4zEdjUMCmHKkhpt8hVs=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=pgB3P/BH7h6fI9TW2wAwf2gZnsmk4m9bUiZ/+gTmciz8402U81jADeURWsaWkzwRE
 TzdF7Oi0LooH1VyuO+gAbY7GxKWgYXigb4BOMdKZeqc2OkT0PUPe2IQmn835gaWQmX
 YYf5uIoiDn/7mZKmAbwfZZmXunfU9kFN+mY+m0PM=
Message-ID: <dcbeab9f-489e-a9f8-b749-a0c40c4ec139@shipmail.org>
Date: Thu, 4 May 2023 16:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/13] drm: execution context for GEM buffers v4
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 francois.dugast@intel.com, felix.kuehling@amd.com,
 arunpravin.paneerselvam@amd.com, dakr@redhat.com, luben.tuikov@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20230504115159.2245-1-christian.koenig@amd.com>
 <20230504115159.2245-2-christian.koenig@amd.com>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
In-Reply-To: <20230504115159.2245-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/4/23 13:51, Christian König wrote:
> This adds the infrastructure for an execution context for GEM buffers
> which is similar to the existing TTMs execbuf util and intended to replace
> it in the long term.
>
> The basic functionality is that we abstracts the necessary loop to lock
> many different GEM buffers with automated deadlock and duplicate handling.
>
> v2: drop xarray and use dynamic resized array instead, the locking
>      overhead is unecessary and measurable.
> v3: drop duplicate tracking, radeon is really the only one needing that.
> v4: fixes issues pointed out by Danilo, some typos in comments and a
>      helper for lock arrays of GEM objects.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
...
> +/**
> + * struct drm_exec - Execution context
> + */
> +struct drm_exec {
> +	/**
> +	 * @interruptible: If locks should be taken interruptible
> +	 */
> +	bool			interruptible;
> +
> +	/**
> +	 * @ticket: WW ticket used for acquiring locks
> +	 */
> +	struct ww_acquire_ctx	ticket;
> +
> +	/**
> +	 * @num_objects: number of objects locked
> +	 */
> +	unsigned int		num_objects;
> +
> +	/**
> +	 * @max_objects: maximum objects in array
> +	 */
> +	unsigned int		max_objects;
> +
> +	/**
> +	 * @objects: array of the locked objects
> +	 */
> +	struct drm_gem_object	**objects;

Hi, Christian. Did you consider using a list here with links embedded in 
gem objects, now that only locked objects are to be put on the list / array.

That should work as only the process owning the lock may access the list 
link. Apart from getting rid of reallocing this is beneficial for the 
more general types of ww transactions that are used by i915 (and to a 
minor extent xe as well, I think).

In those cases we would want to unlock a temporary held object within 
the while_not_all_locked() loop and would then have to search the entire 
array for the correct pointer. Instead one could just remove it from the 
list of locked objects.

Thanks,

Thomas

