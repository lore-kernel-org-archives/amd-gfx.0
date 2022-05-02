Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B838C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 22:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D98510EEF8;
	Mon,  2 May 2022 22:40:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249E810EB7D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651531255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mDhP6qGElSAHD0vWPtWH/rzXFbmJCzufTOcB17z/2Ig=;
 b=ASVjFkMIms25K4Gw7KCP6qcQmoDZWsbfEbiADYlF80TfbN0cTa5W0sN5DjSEimXs1YCQCN
 G5Smy5alIlgr7pABM/sTZ1gkXRXdh4EaVJoQuwRV+cVlpb6wNSRi0Ln5Gs5FDtrq9nPIar
 34uFF5Po4WZWD46y9T87g+sFfSwMoIk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-a4-Q879hOXWJKivq8czUQA-1; Mon, 02 May 2022 18:40:54 -0400
X-MC-Unique: a4-Q879hOXWJKivq8czUQA-1
Received: by mail-qk1-f197.google.com with SMTP id
 v14-20020a05620a0f0e00b00699f4ea852cso11133502qkl.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 May 2022 15:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=mDhP6qGElSAHD0vWPtWH/rzXFbmJCzufTOcB17z/2Ig=;
 b=zJZH9P7WUMCDGFx/p2QMFD+9z9uX0wK+jI7bcFjDTLUI8lmnVMy+gl1xbgWDJxyq9l
 vrtJsl59WZ6QPMitVOwz/ZaRoW9bV9gRhe+yMXU0Fp4moTOuUJrrw94JepwgVgYgHZwY
 0Tyx7A+4Jhon8me4F4DX1uENIrRTQdAKyKLZPAn3QMIFLbiwO3f2aBTpyodZIj0ue9Ht
 yXrHnIC+GTmsXB+7uFs97ou7DgqCUPIzaNJNftFYmkTNKCUbc4M757fgtbo/4yMBLTmf
 7Src01EI1oV/yTYJMBgv6hXn5ltSfNivmknW0tMyiDJ84zxWZnsrHmTmpdSNIB8QZ3fF
 hZKg==
X-Gm-Message-State: AOAM531D/r0Cdcc67aGvaeWc+ZmGxlf7rqwER1Vdzv6UVwEwkEaPwoY6
 wIZ9tfm0mBaXrxhHJqDY60fUz420J96Cwyr3gqzbh7gNJrd3h/GFn0PTSG3Zv/bkc2h+syypxdr
 pdtHVHwnVsjjHPpPRZocdobxNlw==
X-Received: by 2002:a05:622a:1995:b0:2f3:ae2d:cd29 with SMTP id
 u21-20020a05622a199500b002f3ae2dcd29mr393689qtc.650.1651531253606; 
 Mon, 02 May 2022 15:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjvV/50nhUsXpv+mpafDtqEabi/JBIRNMf/YdorOyBOBJNgffD5bWQ9Nfu8RefqEMbVQNIFA==
X-Received: by 2002:a05:622a:1995:b0:2f3:ae2d:cd29 with SMTP id
 u21-20020a05622a199500b002f3ae2dcd29mr393669qtc.650.1651531253296; 
 Mon, 02 May 2022 15:40:53 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net.
 [71.184.137.158]) by smtp.gmail.com with ESMTPSA id
 o8-20020ac841c8000000b002f39b99f684sm4951720qtm.30.2022.05.02.15.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 15:40:52 -0700 (PDT)
Message-ID: <dd5c63923636ec2ad78483899b1e4885e2235055.camel@redhat.com>
Subject: Do we really need to increase/decrease MST VC payloads?
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, harry.wentland@amd.com, 
 amd-gfx@lists.freedesktop.org, Fangzhi Zuo <Jerry.Zuo@amd.com>
Date: Mon, 02 May 2022 18:40:51 -0400
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hi! So I kinda hate to ask this, but finding this in amdgpu completely took me
by surprise and unfortunately is (while technically correct) an enormous pain
and not really necessary as far as I'm aware.

So: it seems that amdgpu is currently the only driver that not only
allocates/deallocates payloads, but it also increases/decreases the size of
payloads as well. This was added in:

   d740e0bf8ed4 ("drm/amd/display: Add DP 2.0 MST DC Support")

This is fine, except that it's totally not at all a situation that the current
payload management code we have (which, is the first place this should have
been implemented) knows how to handle, because every other driver simply
allocates/releases payloads. Having to increase the size of payloads means
that we no longer can count on the payload table being contiguous, and means
we have to resort to coming up with a more complicated solution to actually do
payload management atomically.

I'm willing to try to do that (it should be doable by using bitmasks to track
non-contiguous allocated slots), but considering:
 * This isn't actually needed for DP 2.0 to work as far as I'm aware (if I'm
   wrong please correct me! but I see no issue with just deallocating and
   allocating payloads). It's nice to have, but not necessary.
 * This was from the DSC MST series, which included a lot of code that I
   mentioned at the time needed to not live in amdgpu and be moved into other
   helpers. That hasn't really happened yet, and there are no signs of it
   happening from amd's side - and I just plain do not want to have to be the
   person to do that when I can help it. Going through amdgpu takes a serious
   amount of energy because of all of the abstraction layers, enough so I
   honestly didn't even notice this VC table change when I looked at the
   series this was from. (Or maybe I did, but didn't fully grasp what was
   changing at the time :\).
 * Also on that note, are we even sure that this works with subsequent VC
   changes? E.g. has anyone tested this with physical hardware? I don't know
   that I actually have the hardware to test this out, but
   drm_dp_update_payload*() absolutely doesn't understand non-contiguous
   payloads which I would think could lead to the VCPI start slots getting
   miscalculated if a payload increase/decreases (happy to give further
   explanation on this if needed). Note if this is the case, please hold off a
   bit before trying to fix it and consider just not doing this for the time
   being.

I'd /very/ much like to just disable this behavior for the time being (not the
whole commit for DP 2.0 support since that'd be unreasonable, just the
increase/decrease payload changes), and eventually have someone just implement
this the proper way by adding support for this into the MST helpers and
teaching them how to handle non-contiguous payloads. I'm happy to leave as
much of the code intact as possible (maybe with #if 0 or whatever), and
ideally just add some code somewhere to avoid increasing/decreasing payloads
without a full modeset.

FWIW, the WIP of my atomic MST work is here: 

https://gitlab.freedesktop.org/lyudess/linux/-/commits/wip/mst-atomic-only-v1

I already have i915 and nouveau working with these changes JFYI.
-- 
Cheers, Lyude Paul (she/her) Software Engineer at Red Hat

