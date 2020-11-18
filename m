Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18283C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 11:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76873207D3
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 11:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76873207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettle.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4636E3F9;
	Wed, 18 Nov 2020 11:52:26 +0000 (UTC)
X-Greylist: delayed 763 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2020 11:52:25 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D0AB6E3F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 11:52:25 +0000 (UTC)
Received: from bender.cb.ettle ([143.159.226.37]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1Mz9hF-1kJqXq46r5-00wElS; Wed, 18 Nov 2020 12:39:38 +0100
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
 <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
 <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
 <967f82b1-cf5b-473b-c9b3-d9f9df588cc7@amd.com>
 <ad59a8c59d52c40a89b7b4fd032df043e0747f27.camel@ettle.org.uk>
 <6583647a-7147-4f5b-0412-d3be77ca7fe2@gmail.com>
 <aa941ec6-994e-30c0-74fc-0d13734204bf@amd.com>
From: James Ettle <james@ettle.org.uk>
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
Message-ID: <501e7203-b47e-7635-025f-0d03e08600f7@ettle.org.uk>
Date: Wed, 18 Nov 2020 11:39:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <aa941ec6-994e-30c0-74fc-0d13734204bf@amd.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:kx6DKKKuhbwsOMgTprjxos/h5kM2PWDfrlWLZlCSy0zH8mWoYAs
 WMvgnV6eysXRN+Sj9/LpK+YNtQgvVNSJ7FmKAERm0/w4gYD+2P8aSPoAuyTbvrpWaWxzk17
 2XZ4hO7QdZJIRiS2fX9uhpK9PmHpsEdiw9e6bypW0iy9/wx/UPiy107Pi7obV8aMzoyj1NR
 YIFnG/sWBl53YJpaBCHpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wSc+e/2IqYU=:5Ufiks+f0SX0odrzbzp4Ws
 KU3CbHAaycvDVtepZokxqf9JVbklvxWrvNCgjQVFepucFbMf1TJEd/JVosbxyQfdBTVL4ybUm
 rzRHrkb94mU+AME31rKzGvZTE7LyQ+ti2BXut6fNHNTZQe2+Uve8NePme8dtq9slDloSD/Uc+
 3kZEKMu+H5InX5jkBmx0YcxCmgTjSjAzCm7IKBwLyaATvmmjwkm8S0vLM9aiIMupDPONgrdDS
 YdaEPYCQ1mDuCtHK/+aO/p2yJStSw2fL6jRsC3NOEy0o1vyJ1LBeGMWHs31+/o6E76TthFNyP
 Nol1IIOQppmu55ExkVHq/DTKbTKLgtIimVdh1kvuylR2LXSz7MSnI3FkYazwXPCJUcIAncOQe
 AHyqcJagi36nbT5rRriueoGphZpu23oGazrUxsclCR2E+ORqKGu9uv+7Pt92NEnpZhb+yLfqh
 v2mzdCbLqA==
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
Cc: Harry Wentland <hwentlan@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 28/09/2020 21:12, Kazlauskas, Nicholas wrote:
> 
> DRM modes don't specify the encoding. The property as part of this patch 
> lets userspace override it but the userspace GUI support isn't there on 
> Wayland IIRC.
> 
> I'm fine with adding the properties but I don't think the module 
> parameter is the right solution here. I think it's better if we try to 
> get this into atomic userspace as well or revive efforts that have been 
> already started before.
> 
> The problem with the module parameters is that it'd be applying a 
> default to every DRM connector. No way to specify different defaults per 
> DRM connector, nor do we know the full connector set at driver 
> initialization. The list is dynamic and can change when you plug/unplug 
> MST displays.
> 
What about using the existing "video=" kernel command-line option? I 
looks like this acts at the DRM level and is a driver-neutral mechanism 
for specifying defaults on a per-connector basis.

It also has a straightforward means for parsing additional arbitrary 
options that could be used -- from what I can make out this would 
require adding pixel encoding to struct drm_cmdline_mode.

Regards,

-James
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
