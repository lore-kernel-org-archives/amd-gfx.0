Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19320C33C9E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 20:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DB42072E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 20:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNpvdjJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DB42072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC286F919;
	Fri, 17 Jan 2020 20:45:35 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97CB6F919
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579293932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9UtGNfD9714SZL8iiH6wa7e0RDh+4SCb7LDHbL19gs=;
 b=XNpvdjJcN/PkzTrk9q/ItJhieJ6vRU9h9poXgatNzv3ZssE+bgFSQ+Je0hWCLzGwfI9Trn
 PAt4HJnZVE96unJAQBPhosKMBTiJa86jRjGdivqN+cIhsPHHsHx1DezgQXk6ATTIaVammh
 smvd38JrLhgFNCG9PCasqvZn4bs7ngw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-BM5HbZL8NVC3YPdqNTPgqA-1; Fri, 17 Jan 2020 15:45:31 -0500
Received: by mail-qt1-f200.google.com with SMTP id e37so16720808qtk.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 12:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=b9UtGNfD9714SZL8iiH6wa7e0RDh+4SCb7LDHbL19gs=;
 b=juEZJoNkBRmLngNwDAv+ngj0Oj/lT/NDKux1sPRmsD3qmreRkUDB6p4rK44C4m3sKs
 B+SRQ+VXtRztwsM6MB0oqtrbCNxb/dtrDWmzXQebNb7IQVjXIxuY2rK7WTM0hnUoU3vx
 kjLcSvA27ePuMn4qam8OpODgJFICbXXtg9TH7mS8pgkIBf76VVR8ha3U5uKSP0SeFLGC
 1vVelBe/l26zpSRixH1+6+6JgTGdIIVMHrXZIvtFKUxsi6AehPtWTKlb0KS4GRrEkFPU
 BM3D8DZB+VFBA1l+JIIvlG26rKPukqbRx3Vk9SnKIFkxk+iHkldeEuYhECXAmeLK5ZRW
 pCew==
X-Gm-Message-State: APjAAAUte5WZMUhdlnUzwRs34oNAXYWUZglYDvOwSg6MoAIfybTk2k3D
 MTjetWMPGyA7bcTpCzkj8nCtUB5zzIi99N130u4jS89WGHVr3Oj1qZg6apXoy59Gwec3mbXIPV8
 ZKY7+pISTlcMs/q0l+67aMJTkzg==
X-Received: by 2002:a05:620a:849:: with SMTP id
 u9mr40542371qku.414.1579293930791; 
 Fri, 17 Jan 2020 12:45:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzm/epyHbhox0dOOjWR6cniA2F6Xix11eqF5HHeDcHB2CLPPeLs9GN2puOuNQjMJ5WcdKj0YA==
X-Received: by 2002:a05:620a:849:: with SMTP id
 u9mr40542346qku.414.1579293930540; 
 Fri, 17 Jan 2020 12:45:30 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id n32sm13469727qtk.66.2020.01.17.12.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 12:45:29 -0800 (PST)
Message-ID: <cfae7fec779bd8fa4da0ad0e7664cf797a1700ab.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp_mst: Remove VCPI while disabling topology mgr
From: Lyude Paul <lyude@redhat.com>
To: Sean Paul <sean@poorly.run>
Date: Fri, 17 Jan 2020 15:45:28 -0500
In-Reply-To: <CAMavQK+pOtQ62mp4DSRDW7nHDz4doW3LA5AV1NML-wFa3s3cQA@mail.gmail.com>
References: <20191205090043.7580-1-Wayne.Lin@amd.com>
 <a6c4db964da7e00a6069d40abcb3aa887ef5522b.camel@redhat.com>
 <ec3e020798d99ce638c05b0f3eb00ebf53c3bd7c.camel@redhat.com>
 <DM6PR12MB41371AC4B0EC24E84AB0C84DFC580@DM6PR12MB4137.namprd12.prod.outlook.com>
 <CAMavQK+pS40SQibFuirjLAmjmy8NbOcXWvNsFP8PanS6dEcXWw@mail.gmail.com>
 <31d9eabe57a25ff8f4df22e645494d57715cdc0b.camel@redhat.com>
 <CAMavQK+pOtQ62mp4DSRDW7nHDz4doW3LA5AV1NML-wFa3s3cQA@mail.gmail.com>
Organization: Red Hat
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31)
MIME-Version: 1.0
X-MC-Unique: BM5HbZL8NVC3YPdqNTPgqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah that's fine with me, I'll send out a revert for this in just a moment

On Fri, 2020-01-17 at 15:43 -0500, Sean Paul wrote:
> On Fri, Jan 17, 2020 at 3:27 PM Lyude Paul <lyude@redhat.com> wrote:
> > On Fri, 2020-01-17 at 11:19 -0500, Sean Paul wrote:
> > > On Mon, Dec 9, 2019 at 12:56 AM Lin, Wayne <Wayne.Lin@amd.com> wrote:
> > > > 
> > > > > -----Original Message-----
> > > > > From: Lyude Paul <lyude@redhat.com>
> > > > > Sent: Saturday, December 7, 2019 3:57 AM
> > > > > To: Lin, Wayne <Wayne.Lin@amd.com>; dri-devel@lists.freedesktop.org;
> > > > > amd-gfx@lists.freedesktop.org
> > > > > Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Wentland,
> > > > > Harry
> > > > > <Harry.Wentland@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>;
> > > > > stable@vger.kernel.org
> > > > > Subject: Re: [PATCH v2] drm/dp_mst: Remove VCPI while disabling
> > > > > topology
> > > > > mgr
> > > > > 
> > > > > On Fri, 2019-12-06 at 14:24 -0500, Lyude Paul wrote:
> > > > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > > > 
> > > > > > I'll go ahead and push this to drm-misc-next-fixes right now,
> > > > > > thanks!
> > > > > 
> > > > > Whoops-meant to say drm-misc-next here, anyway, pushed!
> > > > Thanks for your time!
> > > > 
> > > 
> > > I'm getting the following warning on unplug with this patch:
> > > 
> 
> \snip
> 
> > I think I've got a better fix for this that should avoid that problem,
> > I'll
> > write up a patch and send it out in a bit
> 
> Thanks Lyude! Should we revert this patch for the time being?
> 
> > --
> > Cheers,
> >         Lyude Paul
> > 
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
