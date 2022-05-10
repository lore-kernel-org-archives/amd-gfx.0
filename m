Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1409C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 22:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C20A10E1DE;
	Tue, 10 May 2022 22:14:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DCB10E1DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 22:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652220859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8TmSJqX6o2npdPCOpPoEbctgCzRPZf89rsdNqiOHgA=;
 b=cc0SuAWm4il7BTNm68o4d1RL8D7O533eGkgClfKU2JH90gGhjmnk8hphLJJk3M3qaIfI86
 ohs9vqLpScGNutC/X2yReSqEGJCbbuVH+koEMxr7IOcX8v3+OjB7CdMXKgNpfaYlLeFjvv
 DYYfbcJF0TagsGwrZbzvYJNj+2FbE8g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-xyzgMDJEPLGfxdXVRmtXFA-1; Tue, 10 May 2022 18:14:15 -0400
X-MC-Unique: xyzgMDJEPLGfxdXVRmtXFA-1
Received: by mail-qt1-f200.google.com with SMTP id
 i11-20020ac85e4b000000b002f3d8c3a96dso135125qtx.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=k8TmSJqX6o2npdPCOpPoEbctgCzRPZf89rsdNqiOHgA=;
 b=Aa8dCvBc9DKSn61eROj/M/TBf8eBVn8vTxLWqoH7kORPHgBOq2BVUAAb7yeDXyZetS
 mt7nmZWYzxSnDJYKkM8Xn+yu7hwDlSrT3o2Jr94I1hEZNdYuT3kCb2kx9rrZhnWh9+M8
 Rsc+6Se9EATt6pEwvGEJEgOd2QQlchQsD1XACIUOSCQ3dW5wRxbErBDcx0TK8csNEL+9
 JgoOIuyCKjr1BI1hqmlnTUBJdWDIoqJWSUGN/8E+4mF6zz0SQZoF29/j7hrONQOg/bTu
 wz4ZYX+5H8q3T+fHcjuv6myAnSg1mezWbFnGP8q3u08D43/6RQGjCS2l5u0pFvKgL4r5
 O8Sw==
X-Gm-Message-State: AOAM533M/knwOnLPVGaH1Z4u803tSun0CijmXVKL0eLjVp6k8nDZdGIf
 sNK4Axr0muBZVJ3eHyHIjlYCOBUsFgwYPvMdSQLQU7KM31S3YK///ToIdajrrJBLqeRFsJ/7wgI
 mzvPecfK8m/DXop3Fgr6Y2SFFWg==
X-Received: by 2002:a05:622a:13c6:b0:2f3:a7e5:2c5f with SMTP id
 p6-20020a05622a13c600b002f3a7e52c5fmr21578648qtk.558.1652220854209; 
 Tue, 10 May 2022 15:14:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWccxydvsndTbYGmvUlDvKfrjxYIeMAfAjgV4BgKOT//MuNNtmpdub/gM/3MlZkZpy3crq5Q==
X-Received: by 2002:a05:622a:13c6:b0:2f3:a7e5:2c5f with SMTP id
 p6-20020a05622a13c600b002f3a7e52c5fmr21578628qtk.558.1652220853943; 
 Tue, 10 May 2022 15:14:13 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net.
 [71.184.137.158]) by smtp.gmail.com with ESMTPSA id
 w5-20020ac857c5000000b002f3d52d57bcsm144082qta.26.2022.05.10.15.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 15:14:13 -0700 (PDT)
Message-ID: <5697660b5ca61a4c4288eb2b641403a631d17400.camel@redhat.com>
Subject: Re: Do we really need to increase/decrease MST VC payloads?
From: Lyude Paul <lyude@redhat.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Tue, 10 May 2022 18:14:12 -0400
In-Reply-To: <CO6PR12MB54893ACC396FBC017AD2E276FCC29@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <dd5c63923636ec2ad78483899b1e4885e2235055.camel@redhat.com>
 <ad4ce2ddd2f2019f360b501c092680c799cb468c.camel@redhat.com>
 <BN8PR12MB334859526DE2D862EBBA0128E5C29@BN8PR12MB3348.namprd12.prod.outlook.com>
 <CO6PR12MB54893ACC396FBC017AD2E276FCC29@CO6PR12MB5489.namprd12.prod.outlook.com>
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

On Thu, 2022-05-05 at 10:02 +0000, Lin, Wayne wrote:
> 
> I think this shouldn't happen. Please refer to the figure 2-98 of DP spec
> 1.4.
> The payload id table should be changed to below I think.
> 
>         |1 1 1 2 3 3 X X|
> 
> I skimmed over a bit of the implementation in drm. I think it should work
> fine
> except that we have to revise function drm_dp_init_vcpi() a bit.
> Since increasing/decreasing time slots should still use the same payload id,
> we should add logic to skip trying to assign a new payload id under this
> case.

I'm not sure about that tbh, since the example you gave also still mentions VC
#1 which is supposed to be disabled here.

FWIW, I was alerted to this pecularity when I noticed Figure 2-93 from chapter
2.6.5 of the DP 2.0 spec. Notice that on the diagram it mentions time slots 1-
20 allocated to VC1, time slots 21-32 being allocated to VC2, and then
(confusingly in a different color) mentions that time slots 33-47 are
allocated to VC1 again.

At first I honestly thought this was a typo in the spec, but it's done
multiple times and it _does_ actually make sense when you think about it for a
little while. Consider that the advantage of having VC allocations work this
way would be that you're able to increase the time slots allocated to a VC
without having to even change their start slots - meaning those other payloads
don't need to be disrupted in any way. This is only as far as I can tell if
you have non-contiguous payloads.

> 
> > > 
> > >         |1 1 2 3 3 1 X X|
> > > 
> > > Now, let's say we increase payload #2 to 2 slots:
> > > 
> > >         |1 1 2 3 3 1 2 X|
> > > 
> > > Surprise - the monitor for payload #1 was unplugged, so we need to
> > > remove
> > > it's payload. Note the MST spec doesn't allow holes between allocations,
> > > and
> > > makes branches repsonsible for automatically moving payloads to fill in
> > > the
> > > gaps which we have to keep track of locally.
> > > Normally the handling of holes would be fine, as our current payload
> > > management code loops through each payload to fill in any holes. But
> > > these
> > > payloads aren't contiguous and we only kept track of their start slots
> > > and
> > > total slot counts. So we would end up thinking we now have a VC table
> > > like
> > > this:
> > > 
> > >         |2 2 3 3 X X X X|
> > > 
> > > But that's wrong, in reality the table will look like this on the MST
> > > hub:
> > > 
> > >         |2 3 3 2 X X X X|
> > > 
> > > Now things are broken, because we now have the wrong start slot for
> > > payload #3.
> > > 
> > > Just figured I'd clarify :). if anyone is curious, I ended up fixing
> > > this by adding
> > > a bitmask of assigned VC slots to our atomic payload struct - and using
> > > that
> > > to keep track of the current start slots for each payload. Since we have
> > > a max
> > > of 64 VC slots which fits into a u64, this works rather elegantly!
> > > 
> > > > 
> > > > I'd /very/ much like to just disable this behavior for the time being
> > > > (not the whole commit for DP 2.0 support since that'd be unreasonable,
> > > > just the increase/decrease payload changes), and eventually have
> > > > someone just implement this the proper way by adding support for this
> > > > into the MST helpers and teaching them how to handle non-contiguous
> > > > payloads. I'm happy to leave as much of the code intact as possible
> > > > (maybe with #if 0 or whatever), and ideally just add some code
> > > > somewhere to avoid increasing/decreasing payloads without a full
> > > > modeset.
> > > > 
> > > > FWIW, the WIP of my atomic MST work is here:
> > > > 
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> > > > ab.freedesktop.org%2Flyudess%2Flinux%2F-%2Fcommits%2Fwip%2Fmst-
> > > atomic-
> > > > only-
> > > v1&amp;data=05%7C01%7Cjerry.zuo%40amd.com%7Cf669121b53414c0dbc9
> > > 40
> > > > 
> > > 8da2e137e85%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378
> > > 729585141
> > > > 
> > > 60092%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> > > MzIiLCJB
> > > > 
> > > TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=IBn%2BF5
> > > 0r9WIeUfG
> > > > 9MUGStbACr5Kolu3PB5K0dyiiYwg%3D&amp;reserved=0
> > > > 
> > > > I already have i915 and nouveau working with these changes JFYI.
> > > 
> > > --
> > > Cheers,
> > >  Lyude Paul (she/her)
> > >  Software Engineer at Red Hat
> 
> --
> Regards,
> Wayne Lin
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

