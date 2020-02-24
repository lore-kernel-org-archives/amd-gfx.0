Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC67C11D27
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 08:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B0820661
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 08:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXCVLhmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B0820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2D66E17D;
	Mon, 24 Feb 2020 08:01:40 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28EFA6E17D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582531298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgCzQmsJb+H+XtPAL7gPbmk0MI3Fi0ma8DPexkLFHIQ=;
 b=WXCVLhmpPosVHzNowqlZE5Er2GVgzPkavGi1pHD7HiGUNWAjvgsCLHTOWHYXY5POqFBttw
 Dva8KW5v0aySvoxWXsjo9HkhgJdND4lGf1fXdVkkpD0IlXaCAS/SW3CQrnLqdeGpDmmzdy
 aUGVcrGHZpSSrm1rtQiBeVLTKi5roR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-DzbuQNHAPx-BuVBkBuFYDA-1; Mon, 24 Feb 2020 03:01:34 -0500
X-MC-Unique: DzbuQNHAPx-BuVBkBuFYDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CFF0477;
 Mon, 24 Feb 2020 08:01:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-87.ams2.redhat.com
 [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8B025D9C9;
 Mon, 24 Feb 2020 08:01:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DACEE1747F; Mon, 24 Feb 2020 09:01:29 +0100 (CET)
Date: Mon, 24 Feb 2020 09:01:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
Subject: Re: [PATCH 6/8] drm/vram-helper: don't use ttm bo->offset
Message-ID: <20200224080129.uebrxirglfl7ai6t@sirius.home.kraxel.org>
References: <20200217150427.49994-1-nirmoy.das@amd.com>
 <20200217150427.49994-7-nirmoy.das@amd.com>
MIME-Version: 1.0
In-Reply-To: <20200217150427.49994-7-nirmoy.das@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, amd-gfx@lists.freedesktop.org,
 airlied@linux.ie, kenny.ho@amd.com, brian.welty@intel.com,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 nirmoy.das@amd.com, linux-graphics-maintainer@vmware.com, bskeggs@redhat.com,
 daniel@ffwll.ch, alexander.deucher@amd.com, sean@poorly.run,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 17, 2020 at 04:04:25PM +0100, Nirmoy Das wrote:
> Calculate GPU offset within vram-helper without depending on
> bo->offset
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
