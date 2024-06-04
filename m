Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D43C27C55
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 12:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3060710E478;
	Tue,  4 Jun 2024 12:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.b="npmHiCfj";
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BE310E0E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 02:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=f3EfFFhLo7qoxvRuyPrrMwrJOpcYtQ19fIyj+M55fBk=; b=npmHiCfjKKQxF4U/dpKuH2jZIX
 1IoykyIDshxyr6HdLBkfQQfIvIVD+ELj3D8gkSfQGI49d5VEJwPBE6xKekpLdzRC5Y9JlFwHSK4LD
 s+GrOSRm5UMf7HakqSx886iq+xrUQnDSKnA8Lhez1vc5hSCAJArlo9fR4eFhDGgWIIH8QweS/FN7i
 0PKULlBYJzOPDHevd4wiXOZI957vMMuf/AzhftuJDgb8keRddqdnDQScLcjeWC7/lMGKak5Da82na
 RP+3IaYl8G9wN4sTU5OYP8XUIprRfvl2NQtFKhLx71saciwjcJUFtzQzwLJgzOVSGpIlDIubwZs19
 Fl0TU9dw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1sEJfT-00CoSv-28 for amd-gfx@lists.freedesktop.org;
 Tue, 04 Jun 2024 02:12:55 +0000
Date: Tue, 4 Jun 2024 03:12:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCHES][RFC][CFT] close_fd() misuses in amdgpu
Message-ID: <20240604021255.GO1629371@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 04 Jun 2024 12:47:58 +0000
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

	Use of close_fd() in cleanup on failure exits is
wrong; descriptor table is a shared data structure, and
as soon as you've inserted a file reference there it is
entirely possible for another thread to have move it
around, replace it or remove it.

	Fortunately, not many places are using it that
way; two of such are in amdgpu and AFAICS they are not
hard to get rid of.

	Patches are in followups; review and testing would
be very welcome - as it is, I've verified that they build,
but that's about it.
