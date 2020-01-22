Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101A6C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 20:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B7B2073A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 20:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GowiQHd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B7B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDF06F8B2;
	Wed, 22 Jan 2020 20:18:30 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CF86F60D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579724307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CZFB953qV+gIBO5olx5LNPvRiXJZ0yhjDpEkk+yDmPc=;
 b=GowiQHd55CHiABT4nV+YwIKhVGP/FEQoJWcNfBTwb8pHj4T3DMR00gHxj/7x8HYPQptquA
 YsmwM7bkCRKvHCtYKrOqOG/GPVO3ORfwdVChes0hNfAkvI25s30MUtbm110ANjPHETBuV0
 QTYJ3Bh2ZsycyLovv2VvB9VFh1iPJ2w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-ZwLe4xXkNt2P7LUD4QqJXg-1; Wed, 22 Jan 2020 15:18:26 -0500
Received: by mail-qt1-f198.google.com with SMTP id z11so655211qts.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 12:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=CZFB953qV+gIBO5olx5LNPvRiXJZ0yhjDpEkk+yDmPc=;
 b=mTrnPj0c3YgS3JEq7H43DfanbaHOwxEhMz+jgot1pqa7IetKH+FbZp3/+nSweI8bPR
 rc8qeFxfFs/jOxQdGJ0tBpn3K3u3Da2e8IGwYqPQZ1ppyVHaTQWw0d0bB0cC44aEPPK0
 W/waI3dMvpMeV/O6SKV0x2oAL2fhgMU4akNp5T58ipm+cS9EsfSTxiGS+AXqB3foKHkd
 6PeS2kZDP6BJC9v7vEIQYtSClHqpzWiXVUdcNzSBEKktGKNpVcRiFH5BaaKPALaXQCix
 heAf7APrTfEI4bDws1yaHryUpsXY8cHzyYaceNL8UZzVSgLVD1TssOkQMws3S8d3G8iP
 aMpQ==
X-Gm-Message-State: APjAAAX46bmS9eVZWyNkIwo8oiEEYN5OFq853nrG2l7XAKTrGa3YqVTD
 HVgIiekaVQ8/bUFyX2Nymij6gsb/iT0EA/+hGPALi8yXeSPVG5ibJUMGwFAF6pXgENqBPWHHaXx
 tbtamxSi/l7OTPmE1hxXnCcl2rw==
X-Received: by 2002:a05:620a:56f:: with SMTP id
 p15mr10557838qkp.160.1579724305581; 
 Wed, 22 Jan 2020 12:18:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJt7eLOsdHLJ4QKtTD3EU7lXYZhiFee2cOwokWCRVaccEWePb8GAyHZ6oAM374sdLYV1zyoA==
X-Received: by 2002:a05:620a:56f:: with SMTP id
 p15mr10557814qkp.160.1579724305308; 
 Wed, 22 Jan 2020 12:18:25 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id m8sm21978682qtk.60.2020.01.22.12.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 12:18:24 -0800 (PST)
Message-ID: <696e7d77904ecbe86878169efa18f49d7cb1a4ec.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp_mst: Remove VCPI while disabling topology mgr
From: Lyude Paul <lyude@redhat.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, Sean Paul <sean@poorly.run>
Date: Wed, 22 Jan 2020 15:18:23 -0500
In-Reply-To: <DM6PR12MB4137A84B694D85E26F8050D8FC0C0@DM6PR12MB4137.namprd12.prod.outlook.com>
References: <20191205090043.7580-1-Wayne.Lin@amd.com>
 <a6c4db964da7e00a6069d40abcb3aa887ef5522b.camel@redhat.com>
 <ec3e020798d99ce638c05b0f3eb00ebf53c3bd7c.camel@redhat.com>
 <DM6PR12MB41371AC4B0EC24E84AB0C84DFC580@DM6PR12MB4137.namprd12.prod.outlook.com>
 <CAMavQK+pS40SQibFuirjLAmjmy8NbOcXWvNsFP8PanS6dEcXWw@mail.gmail.com>
 <31d9eabe57a25ff8f4df22e645494d57715cdc0b.camel@redhat.com>
 <CAMavQK+pOtQ62mp4DSRDW7nHDz4doW3LA5AV1NML-wFa3s3cQA@mail.gmail.com>
 <cfae7fec779bd8fa4da0ad0e7664cf797a1700ab.camel@redhat.com>
 <DM6PR12MB4137A84B694D85E26F8050D8FC0C0@DM6PR12MB4137.namprd12.prod.outlook.com>
Organization: Red Hat
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31)
MIME-Version: 1.0
X-MC-Unique: ZwLe4xXkNt2P7LUD4QqJXg-1
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
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2020-01-22 at 04:48 +0000, Lin, Wayne wrote:
> [AMD Public Use]
> 
> Sorry for any inconvenience I brought.

Nothing to be sorry about! This happens from time to time, it's my fault for
not noticing it in the first place anyway :P. Ville from Intel is able to
review it, so there's no rush

> Thank you so much Lyude, I will have a look on that fix patch later.
> 
> > -----Original Message-----
> > From: Lyude Paul <lyude@redhat.com>
> > Sent: Saturday, January 18, 2020 4:45 AM
> > To: Sean Paul <sean@poorly.run>
> > Cc: Lin, Wayne <Wayne.Lin@amd.com>; dri-devel@lists.freedesktop.org;
> > amd-gfx@lists.freedesktop.org; Zuo, Jerry <Jerry.Zuo@amd.com>; Kazlauskas,
> > Nicholas <Nicholas.Kazlauskas@amd.com>; stable@vger.kernel.org
> > Subject: Re: [PATCH v2] drm/dp_mst: Remove VCPI while disabling topology
> > mgr
> > 
> > Yeah that's fine with me, I'll send out a revert for this in just a moment
> > 
> > On Fri, 2020-01-17 at 15:43 -0500, Sean Paul wrote:
> > > On Fri, Jan 17, 2020 at 3:27 PM Lyude Paul <lyude@redhat.com> wrote:
> > > > On Fri, 2020-01-17 at 11:19 -0500, Sean Paul wrote:
> > > > > On Mon, Dec 9, 2019 at 12:56 AM Lin, Wayne <Wayne.Lin@amd.com>
> > wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Lyude Paul <lyude@redhat.com>
> > > > > > > Sent: Saturday, December 7, 2019 3:57 AM
> > > > > > > To: Lin, Wayne <Wayne.Lin@amd.com>;
> > > > > > > dri-devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org
> > > > > > > Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>;
> > > > > > > Wentland, Harry <Harry.Wentland@amd.com>; Zuo, Jerry
> > > > > > > <Jerry.Zuo@amd.com>; stable@vger.kernel.org
> > > > > > > Subject: Re: [PATCH v2] drm/dp_mst: Remove VCPI while
> > > > > > > disabling topology mgr
> > > > > > > 
> > > > > > > On Fri, 2019-12-06 at 14:24 -0500, Lyude Paul wrote:
> > > > > > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > > > > > 
> > > > > > > > I'll go ahead and push this to drm-misc-next-fixes right
> > > > > > > > now, thanks!
> > > > > > > 
> > > > > > > Whoops-meant to say drm-misc-next here, anyway, pushed!
> > > > > > Thanks for your time!
> > > > > > 
> > > > > 
> > > > > I'm getting the following warning on unplug with this patch:
> > > > > 
> > > 
> > > \snip
> > > 
> > > > I think I've got a better fix for this that should avoid that
> > > > problem, I'll write up a patch and send it out in a bit
> > > 
> > > Thanks Lyude! Should we revert this patch for the time being?
> > > 
> > > > --
> > > > Cheers,
> > > >         Lyude Paul
> > > > 
> > --
> > Cheers,
> > 	Lyude Paul
> --
> Best regards,
> Wayne
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
