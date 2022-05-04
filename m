Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324A7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 21:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9676310EE41;
	Wed,  4 May 2022 21:17:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A0910EE41
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 21:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651699045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWnZL5lkMOKlMG9IstTlOFF7mtOt1yrr5gvQ9Zo+fU0=;
 b=eJxA3p2419st+C7UHUE/z9YYz7+hqEpm+3JGsR4YsSuKsoIyv5uajjcxYM4G8qM2XXR455
 caAtKzuUOmffuBJbSLElsjziygXuUp8QZya+nGY/7dK7I/OmDKKuhWqTtPqADeqqgF4SvO
 qIDrAYo3D9Hj+svc/696D2V5yTKfNuY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-NegCETwaM7KigbHjDUZh6w-1; Wed, 04 May 2022 17:17:25 -0400
X-MC-Unique: NegCETwaM7KigbHjDUZh6w-1
Received: by mail-qt1-f200.google.com with SMTP id
 w21-20020a05622a135500b002f3b801f51eso1964955qtk.23
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 14:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=NWnZL5lkMOKlMG9IstTlOFF7mtOt1yrr5gvQ9Zo+fU0=;
 b=DKosYQ5XtOsvNVU0uVw/SqREtbJCakPFCMatqCvimPltE4vH5RGqcArFkx3qsPFA5Y
 udd7UDH5Leix4FOkD0cSmze4Q/yUIT5C2yKUM55hZRYoBDwHQCc0I/+oPaKGiuy1pN5g
 LpxSLpI9M5zc4aTYRjlEdxYMrIYaC1GQfi/xBT+R844sCMHyayF0DlDwEgc7+2lHsfIZ
 zK6BU233DZ6iovM+yKCGlY8ePuI53CbDujAwiGW4JES4m/bFL42MDgIkVFpeIw5vZSy8
 gp/qRFBCL0D1qWR38pnZKrSoZbXnDBG38bX303vlPePn1LYw4G3EAnETwqaEa1Kr4SH7
 gpgg==
X-Gm-Message-State: AOAM532bzFLOOQlU8joKoPKtoZlPBJKnabi0VGHA3aGpxqvPt5l1SsJ5
 0hDL+6qfRiq4l0Ip3oUnWTVIbAfhbbDd7CZ3/7zy/2C0uzuaweMqj4fXaASrICnnU8vSgZMUTTm
 /12eElM5+RaaukLQx9QGKp87BFw==
X-Received: by 2002:ac8:4e95:0:b0:2e2:15e6:c10c with SMTP id
 21-20020ac84e95000000b002e215e6c10cmr20857129qtp.444.1651699044420; 
 Wed, 04 May 2022 14:17:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuqG8E0VbSM92oWVIe0tbDDcX4prN3tlL+fvEPBunjM2Y5YxWGrauQkjmXrPqUXKr6O39X+Q==
X-Received: by 2002:ac8:4e95:0:b0:2e2:15e6:c10c with SMTP id
 21-20020ac84e95000000b002e215e6c10cmr20857116qtp.444.1651699044153; 
 Wed, 04 May 2022 14:17:24 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net.
 [71.184.137.158]) by smtp.gmail.com with ESMTPSA id
 m19-20020ac866d3000000b002f39b99f696sm7914618qtp.48.2022.05.04.14.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 14:17:23 -0700 (PDT)
Message-ID: <ad4ce2ddd2f2019f360b501c092680c799cb468c.camel@redhat.com>
Subject: Re: Do we really need to increase/decrease MST VC payloads?
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, harry.wentland@amd.com, 
 amd-gfx@lists.freedesktop.org, Fangzhi Zuo <Jerry.Zuo@amd.com>
Date: Wed, 04 May 2022 17:17:22 -0400
In-Reply-To: <dd5c63923636ec2ad78483899b1e4885e2235055.camel@redhat.com>
References: <dd5c63923636ec2ad78483899b1e4885e2235055.camel@redhat.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Some good news: I actually came up with a way of handling this in the new MST
code pretty nicely, so I think we should be able to move forward without
having to disable this (although it would be very nice to know whether or not
this is necessary for amdgpu to work, since it'd still be nice to split this
into separate changes to make reviewing my big MST patch series easier. More
comments down below:

On Mon, 2022-05-02 at 18:40 -0400, Lyude Paul wrote:
> Hi! So I kinda hate to ask this, but finding this in amdgpu completely took
> me
> by surprise and unfortunately is (while technically correct) an enormous
> pain
> and not really necessary as far as I'm aware.
> 
> So: it seems that amdgpu is currently the only driver that not only
> allocates/deallocates payloads, but it also increases/decreases the size of
> payloads as well. This was added in:
> 
>    d740e0bf8ed4 ("drm/amd/display: Add DP 2.0 MST DC Support")
> 
> This is fine, except that it's totally not at all a situation that the
> current
> payload management code we have (which, is the first place this should have
> been implemented) knows how to handle, because every other driver simply
> allocates/releases payloads. Having to increase the size of payloads means
> that we no longer can count on the payload table being contiguous, and means
> we have to resort to coming up with a more complicated solution to actually
> do
> payload management atomically.
> 
> I'm willing to try to do that (it should be doable by using bitmasks to
> track
> non-contiguous allocated slots), but considering:
>  * This isn't actually needed for DP 2.0 to work as far as I'm aware (if I'm
>    wrong please correct me! but I see no issue with just deallocating and
>    allocating payloads). It's nice to have, but not necessary.
>  * This was from the DSC MST series, which included a lot of code that I
>    mentioned at the time needed to not live in amdgpu and be moved into
> other
>    helpers. That hasn't really happened yet, and there are no signs of it
>    happening from amd's side - and I just plain do not want to have to be
> the
>    person to do that when I can help it. Going through amdgpu takes a
> serious
>    amount of energy because of all of the abstraction layers, enough so I
>    honestly didn't even notice this VC table change when I looked at the
>    series this was from. (Or maybe I did, but didn't fully grasp what was
>    changing at the time :\).
>  * Also on that note, are we even sure that this works with subsequent VC
>    changes? E.g. has anyone tested this with physical hardware? I don't know
>    that I actually have the hardware to test this out, but
>    drm_dp_update_payload*() absolutely doesn't understand non-contiguous
>    payloads which I would think could lead to the VCPI start slots getting
>    miscalculated if a payload increase/decreases (happy to give further
>    explanation on this if needed). Note if this is the case, please hold off
> a
>    bit before trying to fix it and consider just not doing this for the time
>    being.

Sorry for being a bit vague with this! I typed this email at the end of
the workday and didn't feel like going super into detail on this. So I
guess I'll do that now (hopefully I didn't misread the MST spec
somewhere):

For reference: the issue I was mentioning here was regarding the fact
that the current payload management code we have doesn't keep track of
exactly which VC slots are in use by a payload at any given time - only
the starting slots and total slot counts of each payload. Which means
that once we increase a MST payload, since the additional VC slots will
be put at the end of the VC table regardless of the start of the
payload. As such, it's possible that said payload will no longer be
contiguous. An example, note for simplicity sake this example pretends
we only have 8 VC slots instead of 64:

Payloads: #1 == 2 slots, #2 == 1 slot, #3 == 2 slots

VC table looks like this, where each number corresponds to a VCPI and
X means unused:

        |1 1 2 3 3 X X X|

We decide we need to increase payload #1 from 2 slots to 3. The MST spec
mandates that new slots always are added to the end, so we end up with
this surprising VC table:

        |1 1 2 3 3 1 X X|

Now, let's say we increase payload #2 to 2 slots:

        |1 1 2 3 3 1 2 X|

Surprise - the monitor for payload #1 was unplugged, so we need to
remove it's payload. Note the MST spec doesn't allow holes between
allocations, and makes branches repsonsible for automatically moving
payloads to fill in the gaps which we have to keep track of locally.
Normally the handling of holes would be fine, as our current payload
management code loops through each payload to fill in any holes. But
these payloads aren't contiguous and we only kept track of their start
slots and total slot counts. So we would end up thinking we now have a
VC table like this:

        |2 2 3 3 X X X X|

But that's wrong, in reality the table will look like this on the MST
hub:

        |2 3 3 2 X X X X|

Now things are broken, because we now have the wrong start slot for
payload #3.

Just figured I'd clarify :). if anyone is curious, I ended up fixing
this by adding a bitmask of assigned VC slots to our atomic payload
struct - and using that to keep track of the current start slots for
each payload. Since we have a max of 64 VC slots which fits into a u64,
this works rather elegantly!

> 
> I'd /very/ much like to just disable this behavior for the time being (not
> the
> whole commit for DP 2.0 support since that'd be unreasonable, just the
> increase/decrease payload changes), and eventually have someone just
> implement
> this the proper way by adding support for this into the MST helpers and
> teaching them how to handle non-contiguous payloads. I'm happy to leave as
> much of the code intact as possible (maybe with #if 0 or whatever), and
> ideally just add some code somewhere to avoid increasing/decreasing payloads
> without a full modeset.
> 
> FWIW, the WIP of my atomic MST work is here: 
> 
> https://gitlab.freedesktop.org/lyudess/linux/-/commits/wip/mst-atomic-only-v1
> 
> I already have i915 and nouveau working with these changes JFYI.

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

