Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4487C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jun 2022 13:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69BB10E6CC;
	Sat, 18 Jun 2022 13:54:55 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5135E10E51D;
 Fri, 17 Jun 2022 02:19:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 206BDB823E0;
 Fri, 17 Jun 2022 02:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B77C3411A;
 Fri, 17 Jun 2022 02:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1655432368;
 bh=Yki0vBzHWKtp6dJbGwH7gUmRk173I5HAJLFYlBbmLtI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=U9nPBXKmGgZZ77OA8gwHRrq5HaWuWMnXvA4xx6OL7Qe5Q6WWAkLhRNj5c2JUuTOqP
 fC5Sfz1KP6igFDmHzTkyDdxVCfXz+BEUxESyFl0RvL9jo3cHVy1jIy83e+BVWZ/Bg5
 Ri0ktWlcrRmiQmPMePGTfamFHNmIEHqZQXsclOsA=
Date: Thu, 16 Jun 2022 19:19:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v5 00/13] Add MEMORY_DEVICE_COHERENT for coherent device
 memory mapping
Message-Id: <20220616191927.b4500e2f73500b9241009788@linux-foundation.org>
In-Reply-To: <20220531200041.24904-1-alex.sierra@amd.com>
References: <20220531200041.24904-1-alex.sierra@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 18 Jun 2022 13:54:45 +0000
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

On Tue, 31 May 2022 15:00:28 -0500 Alex Sierra <alex.sierra@amd.com> wrote:

> This is our MEMORY_DEVICE_COHERENT patch series rebased and updated
> for current 5.18.0

I plan to move this series into the non-rebasing mm-stable branch in a
few days.  Unless sternly told not to do so!
