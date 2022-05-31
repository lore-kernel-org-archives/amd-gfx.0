Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585FCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 18:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB20112088;
	Tue, 31 May 2022 18:04:00 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A66310F68D;
 Tue, 31 May 2022 17:31:56 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CAA03B810F1;
 Tue, 31 May 2022 17:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8A9C385A9;
 Tue, 31 May 2022 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1654018313;
 bh=cM0mLgtDwe39r85Qpbwx1gsGZl9Em45suJNmKfe2840=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OKOg1WE09YZpMfWsIy3ozjQL4j7YRHDfSWT7tpHSI4MbkjXTm/nxPhAOzaTq9nu6L
 5oThGX/yQh5E/+oczf87CwQhJN1ZPq0rn6/MKsFTFqhWxZK+SEJH5R4IF5DyWaK4+e
 5hdkzB4zjrPJroW1rabz6XKjJaQAMgDQaW1OYYD4=
Date: Tue, 31 May 2022 10:31:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v4 07/13] lib: test_hmm add ioctl to get zone device type
Message-Id: <20220531103152.6b9214cc39a87020d7d7927b@linux-foundation.org>
In-Reply-To: <20220531155629.20057-8-alex.sierra@amd.com>
References: <20220531155629.20057-1-alex.sierra@amd.com>
 <20220531155629.20057-8-alex.sierra@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 31 May 2022 18:03:59 +0000
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
Cc: rcampbell@nvidia.com, willy@infradead.org, david@redhat.com,
 Felix.Kuehling@amd.com, apopple@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, linux-ext4@vger.kernel.org,
 hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 31 May 2022 10:56:23 -0500 Alex Sierra <alex.sierra@amd.com> wrote:

> new ioctl cmd added to query zone device type. This will be
> used once the test_hmm adds zone device coherent type.
> 
> @@ -1026,6 +1027,15 @@ static int dmirror_snapshot(struct dmirror *dmirror,
>  	return ret;
>  }
>  
> +static int dmirror_get_device_type(struct dmirror *dmirror,
> +			    struct hmm_dmirror_cmd *cmd)
> +{
> +	mutex_lock(&dmirror->mutex);
> +	cmd->zone_device_type = dmirror->mdevice->zone_device_type;
> +	mutex_unlock(&dmirror->mutex);

What does the locking here do?

Presumably cmd->zone_device_type can become out of date the instant the
mutex is released, so what was the point in taking the mutex?

And does it make sense to return potentially out-of-date info to
userspace?  Perhaps this interface simply shouldn't exist?
