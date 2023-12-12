Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18807C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 10:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94D710E56A;
	Tue, 12 Dec 2023 10:36:48 +0000 (UTC)
X-Greylist: delayed 557 seconds by postgrey-1.36 at gabe;
 Tue, 12 Dec 2023 10:36:46 UTC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E0F10E5DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 10:36:46 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SqFDG1T0dz9scX;
 Tue, 12 Dec 2023 11:27:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702376846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58P3JNEYx9mmRZIOmo8kasp3J+9hMC6Zn51UD4g+cZ0=;
 b=kMveWgR/2QCGS6ptl94VUDYEgDMH+9M2rCqtsW4a7JKRZ3CT4iMPD6StvSEghuk/A07tOH
 nUcNGzRmQen5Tfz3VLdp6h9ri4vNESqW76dKwpv3Vyl3GAmfTndH3b43Wm1s2R4mxg4YAA
 EHNBs+l6wayLN8yIKABPj2XdZ9Yk0w9vgQ4bwQNfAy+ASLwXoxWj1JlXMZi5ywJE3WOX3m
 TzBHnd5VfGKfCCbjKqsBjopPTvkLWlVMdvALIx7HwJITXsiCKesEtErYv9YjRQERitlWc9
 3990eiOF0fGTXSMCaT0un2PMNIWeV7ws/j4d0CaLf9hCqnSVYninLB2wMzNX6Q==
Message-ID: <01dfba7e-59f8-4d82-938f-38ed2c2a68e9@mailbox.org>
Date: Tue, 12 Dec 2023 11:27:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>, Joshua Ashton <joshua@froggi.es>
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
 <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
 <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
 <CAAxE2A6Kdj5TBCdZRoT_t+cABzf9tsNCvJLZAVCE66F5pz5yXQ@mail.gmail.com>
 <5de028e5-d24c-4e98-96aa-e3d18720ab6a@froggi.es>
 <CADnq5_PrvUZXvsLY6fsvigrF+SEwwKZCN5MCF=Zo-RggGJrd1A@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CADnq5_PrvUZXvsLY6fsvigrF+SEwwKZCN5MCF=Zo-RggGJrd1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ea12223fad331156142
X-MBO-RS-META: m7p6peqjtmjogbuos4wgs95rtuj8tep5
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-12-08 18:59, Alex Deucher wrote:
> On Fri, Dec 8, 2023 at 12:27 PM Joshua Ashton <joshua@froggi.es> wrote:
>>
>> I heard some musings about dmabuf deadline kernel work recently, but not
>> sure if any of that is applicable to AMD.
> 
> I think something like a workload hint would be more useful.  We did a
> few patch sets to allow userspace to provide a hint to the kernel
> about the workload type so the kernel could adjust the power
> management heuristics accordingly, but there were concerns that the
> UMDs would have to maintain application lists to select which
> heuristic worked best for each application.  Maybe it would be better
> to provide a general classification?  E.g., if the GL or vulkan app
> uses these extensions, it's probably a compute type application vs
> something more graphics-y.  The usual trade-off between power and
> performance.  In general, just letting the firmware pick the clock
> based on perf counters generally seems to work the best.  Maybe a
> general workload hint set by the compositor based on the content type
> it's displaying would be a better option (video vs gaming vs desktop)?

Low clocks can be an issue even for normal desktop workloads, so doubtful that this would be a complete solution.


> The deadline stuff doesn't really align well with what we can do with
> our firmware and seems ripe for abuse.  Apps can just ask for high
> clocks all the time which is great for performance, but not great for
> power.

Maybe the firmware power management heuristics could be derived from the system power profile and fence deadline? E.g. the power profile defines the upper and lower boundaries, the upper boundary is used while there's a pending fence deadline, otherwise the lower boundary.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

