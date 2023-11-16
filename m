Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F29C47071
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 21:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC3D10E101;
	Thu, 16 Nov 2023 21:29:33 +0000 (UTC)
Received: from mail.praveen.org.uk (mail.praveen.org.uk [78.141.237.212])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DFB010E6E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 20:47:55 +0000 (UTC)
Received: by mail.praveen.org.uk (OpenSMTPD) with ESMTPSA id c278f320
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
 for <amd-gfx@lists.freedesktop.org>;
 Thu, 16 Nov 2023 20:47:19 +0000 (GMT)
Date: Thu, 16 Nov 2023 20:47:49 +0000
From: Abhinav Praveen <abhinav@praveen.org.uk>
To: amd-gfx@lists.freedesktop.org
Subject: Re: page fault GCVM_L2_PROTECTION_FAULT_STATUS on 7900xtx Linux
 6.7-rc1 with Mesa 23.3.0-rc3
Message-ID: <20231116204749.5cfszmushua3blwx@praveen.org.uk>
References: <20231114045156.qymbztbq5x57crsd@praveen.org.uk>
 <fdca133c-c151-47f4-578d-2f4a423c57b5@suse.cz>
 <CADnq5_NgUQqo+dKr6D4wv2k6GRkysH9hoQJiWRzNtq8vNgbp8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_NgUQqo+dKr6D4wv2k6GRkysH9hoQJiWRzNtq8vNgbp8w@mail.gmail.com>
X-Mailman-Approved-At: Thu, 16 Nov 2023 21:29:30 +0000
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

On Thu, Nov 16, 2023 at 02:34:50PM -0500, Alex Deucher wrote:
> I think this series should fix it:
> https://patchwork.freedesktop.org/series/126220/

This patch does not fix the issue for me but the patch [1] that you
mentioned in another thread does fix it (errors are no longer printed).

[1] - https://patchwork.freedesktop.org/patch/567101/

-- 
Abhinav Praveen
