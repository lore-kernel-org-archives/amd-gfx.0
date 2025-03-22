Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CFCC35FFC
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 08:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FD710E267;
	Sat, 22 Mar 2025 08:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DJDWgnOG";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFB010E0B4
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 08:04:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0C72C5C4ACA;
 Sat, 22 Mar 2025 08:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E66C4CEDD;
 Sat, 22 Mar 2025 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742630664;
 bh=VS372D8YXF4lFI5XBSp4Hy/qPdaRBi+3DN7mmyIgP0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DJDWgnOG5GeFJ1htESs7PkFg92n66kfjC0mSg6jV1TUXlJu9lcI5p+zBB63mksbNz
 iKQZ1MYdfpzmgUIjPWzv8eICHv+iTm/1hHDeMtjOgrEryf/21Uv8OkwanvJv0EqRcC
 ERvrUL+mpxcy+grxbuZ7xT0Gh+FbwfI2bDX+D+WDtY+1wyMihhda5nKwPDC8rspl32
 Adj0b3v1yIBQJ6JGs6U1yVvRDb1ITFy6868FgQL25DvO1nz2WEBrVW3KVg6weArn5G
 AoR7NFWOC/nBXPeuyYkoqXY/+ACxQ4Lg3/dWeQRjwE7G7WwCCWxc1ARHBFJYlO5cSx
 gKIq0Q2nUVWhA==
Date: Sat, 22 Mar 2025 09:04:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: commit 7ffb791423c7 breaks steam game
Message-ID: <Z95vAzzNOlXvZeJH@gmail.com>
References: <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <Z9vZYIbXOz2wF59j@gmail.com>
 <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>
 <Z90-VOyC5oanCC8z@gmail.com>
 <01414c31-82c8-4de7-920f-87020610580b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01414c31-82c8-4de7-920f-87020610580b@nvidia.com>
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


* Balbir Singh <balbirs@nvidia.com> wrote:

> > How frequently does this happen and what is the impact to users if 
> > this happens?
> 
> It happens a 100% of the time when the BAR space lies beyond the 
> 10TiB region.

And how frequently is the BAR space beyond the 10TiB region, on modern 
systems?

Thanks,

	Ingo
