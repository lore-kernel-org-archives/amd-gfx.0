Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF47BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 15:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C25860F22
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 15:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C25860F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF0DD6E069;
	Mon, 18 Oct 2021 15:16:42 +0000 (UTC)
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C2B6E069
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1634570195; bh=pfWgQlyce8TmAwEyfC/FGc3o/3/Xvs0XIp6AQAlbDhI=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To;
 b=Aez5pffNFLISeLDxKx6wbndAKk7Ngs7xUb3whu/UWVEdlvtSnHIH33mpU0D6QQte5
 MsWzjdBMozZOHuuG1QH54z85Hs9C9+eGbeYpJcUEG0x79Z0puKVVFiKOd4AHRe6gP9
 lHdeh6cx+p28/t8vEC/E0CzElmpVIXXw9KoC6pr4=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Mon, 18 Oct 2021 17:16:35 +0200 (CEST)
X-EA-Auth: D8fuV49cTPY9wwMAbmCimhVfzhtBJa8U7FwgfHBdwIWpgXQzR+R7sW6LNuQJqep7owAh93j4zzv60lLN/sZbS47y2zcWGIZh
Date: Mon, 18 Oct 2021 17:16:32 +0200
From: Claudio Suarez <cssk@net-c.es>
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/3] drm/amdgpu replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
Message-ID: <YW2P0EvHDAxXJbFO@gineta.localdomain>
References: <20211017113500.7033-1-cssk@net-c.es>
 <4217d1f5-e189-e3a5-547a-9ae205c3d539@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4217d1f5-e189-e3a5-547a-9ae205c3d539@amd.com>
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

On Mon, Oct 18, 2021 at 09:37:13AM -0400, Harry Wentland wrote:
> On 2021-10-17 07:34, Claudio Suarez wrote:
> > 
> > From the TODO list Documentation/gpu/todo.rst
> > -----------------------
> > Once EDID is parsed, the monitor HDMI support information is available through
> > drm_display_info.is_hdmi. Many drivers still call drm_detect_hdmi_monitor() to
> > retrieve the same information, which is less efficient.
> > 
> > Audit each individual driver calling drm_detect_hdmi_monitor() and switch to
> > drm_display_info.is_hdmi if applicable.
> > -----------------------
> > The task is divided in three small patches. The last patch depends on the
> > first one.
> > 
> 
> Thanks.
> 
> This series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry
> 

Thanks a lot for your comments and your review, Harry!

BR
Claudio Suarez.



