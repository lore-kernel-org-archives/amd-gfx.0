Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DDCC761A4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 12:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6146020725
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 12:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhX9Fvjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6146020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AEC6E93C;
	Mon, 17 Feb 2020 12:38:23 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226966E93B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581943101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqMBDnjtgJXs9y1zDOliEOPPbRt8+sVAoM4mP1P4Ch8=;
 b=BhX9Fvjpg5//KZMJYi7m0MrAZKL+WjHJihicK51TcHna7eCsGIGLSmNG0DJguBBgQFCiqR
 LtZV2w1EiCWI/8RECIG7tmNzNxW0CW5qvAaw3hqZPCQicnOq70IXZhYcX/kC7zn0v2LgDo
 +stzRAmpaH3QR9ik01gUCI/FyedSthc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-ZRhC3oYpMJqpzyd0gdxD6Q-1; Mon, 17 Feb 2020 07:38:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7A52801A06;
 Mon, 17 Feb 2020 12:38:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBD94867F9;
 Mon, 17 Feb 2020 12:38:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 049F616E16; Mon, 17 Feb 2020 13:38:14 +0100 (CET)
Date: Mon, 17 Feb 2020 13:38:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
Subject: Re: [PATCH 5/7] drm/qxl: don't use ttm bo->offset
Message-ID: <20200217123813.wei55fxm3j7c6ux6@sirius.home.kraxel.org>
References: <20200217101841.7437-1-nirmoy.das@amd.com>
 <20200217101841.7437-6-nirmoy.das@amd.com>
MIME-Version: 1.0
In-Reply-To: <20200217101841.7437-6-nirmoy.das@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ZRhC3oYpMJqpzyd0gdxD6Q-1
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

On Mon, Feb 17, 2020 at 11:18:39AM +0100, Nirmoy Das wrote:
> This patch also removes slot->gpu_offset which is not required as
> VRAM and PRIV slot are in separate PCI bar

Well, gpu_offset is still in struct qxlslot ...

Other than that the patch looks fine, and this is minor enough
that I'll happily

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
