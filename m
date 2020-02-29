Return-Path: <SRS0=TA90=4R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4BDC3F2D3
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Feb 2020 10:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E332468E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Feb 2020 10:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr+DR2Di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E332468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCD26E1D8;
	Sat, 29 Feb 2020 10:13:22 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D4F6F501;
 Sat, 29 Feb 2020 01:52:02 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id o18so2304426qvf.1;
 Fri, 28 Feb 2020 17:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=QehzKiv3PwK4QKHln4i5lVby7aEXgChaUChIRuKLYGw=;
 b=dr+DR2DiuMWTVtOuehGQuDb1Ddfbuhv8EJ0XJH9h0+gVlHys1CTxUuom1VzlwqVsoE
 PXLe8WMJKzK1IIhXi/bRGPK9rpR2YnO6caU0jMDQCUXec/1TXM0b4B3piE1qEaADFzw2
 4HgBet63SGqXWGDnxH0DP0+vAY4YxbNOWsTPlTmuoQPs1+dMuo9bqgoQZS9Do5wyof2J
 FpIpPj5sxsTFkJ1E48KOcg85Nw7TZMgXSXGNcmQ8PwziUoU1XXGSI0aihkH4zW7Hl2Gd
 AuJTXRPi3l6mz81br9JajJTGDYuBR5GmwVIdOwcBrvaRk7gnqVQwzYZrzzp4PY0WGnFN
 lSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QehzKiv3PwK4QKHln4i5lVby7aEXgChaUChIRuKLYGw=;
 b=QdtkbsCCH4wZUbGsU+fawcFPRZSemZEiGxyNsz4o8zI/GfCYChmJA2ZCDcpTQGHbHZ
 LIjpbHyREhMIua3Xp8HdQxxluB/yQvRQw1bjjp8Mp8VH3T1Ik3st3B3UYwKTEOYDdXz1
 V7HVgO9xmCfQzILolq2HO0J90bCOu1UFby74ld/UE0/SWkaeD2m4EpchKcbcSW9exZyx
 m/H/9IE1FpWccifOwMCDi2cEyyBu2ekyDOD3rom4ZHyJF9mSwQ79MB+17O5ymYhw+rzv
 W9vECkLbS14841h7fB6U88ABF4/tl1nNPn9w7Q/L5YYomxKp+qGcPYwqA1BAg13LEyyq
 DBVg==
X-Gm-Message-State: APjAAAX1pJZoEqu7+l8CSNKNSfmRGkZyu+av5hYjSQ4JDYS08ix44B8B
 XAzP2CJlgEFUtlz9aViEkorPxpLfNqc=
X-Google-Smtp-Source: APXvYqyAM8T/YEH3AjXI47OO0EaKiJ0fRgW7rmxWfPjtrpCTqcvACAJGu4nhbFcNYpV74AGuFJw14A==
X-Received: by 2002:ad4:5429:: with SMTP id g9mr6007285qvt.134.1582941120710; 
 Fri, 28 Feb 2020 17:52:00 -0800 (PST)
Received: from [192.168.1.103] (173-230-163-45.cable.teksavvy.com.
 [173.230.163.45])
 by smtp.gmail.com with ESMTPSA id x19sm6017256qtm.47.2020.02.28.17.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 17:51:59 -0800 (PST)
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and impact
 on services
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <CAPj87rM76W9y_76WUHR35NS3V4_-RFi9ZM3GA=aED3dD3hWYkg@mail.gmail.com>
 <CAPM=9txN-RKGwinzsSPrmT_xFjS2J_XUhXVsRQ2pSSe529wpEA@mail.gmail.com>
 <CADaigPUjYZ-Mqd91eyR3Luo=PxLHratUhvodJmCJHf__MnPozA@mail.gmail.com>
 <CAPM=9tyhoagJmzMtwDKU-rjsCUPjokUp2ECOV0FdbkO5CQdZ2w@mail.gmail.com>
 <CAKMK7uG-HwYX4M8sSAU6Qee_hUTFZZNHngsR+_K+Ewrqu8=ZDg@mail.gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
Message-ID: <6e2e2770-4302-e3e9-dde4-e378d6573d1c@gmail.com>
Date: Fri, 28 Feb 2020 20:51:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uG-HwYX4M8sSAU6Qee_hUTFZZNHngsR+_K+Ewrqu8=ZDg@mail.gmail.com>
Content-Language: en-US
X-Mailman-Approved-At: Sat, 29 Feb 2020 10:13:21 +0000
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
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>,
 gstreamer-devel@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/28/20 4:22 PM, Daniel Vetter wrote:
> On Fri, Feb 28, 2020 at 9:31 PM Dave Airlie <airlied@gmail.com> wrote:
>> On Sat, 29 Feb 2020 at 05:34, Eric Anholt <eric@anholt.net> wrote:
>>> On Fri, Feb 28, 2020 at 12:48 AM Dave Airlie <airlied@gmail.com> wrote:
>>>> On Fri, 28 Feb 2020 at 18:18, Daniel Stone <daniel@fooishbar.org> wrote:
>>>>> On Fri, 28 Feb 2020 at 03:38, Dave Airlie <airlied@gmail.com> wrote:
>>>>>> b) we probably need to take a large step back here.
>>>>>>
>>>>>> Look at this from a sponsor POV, why would I give X.org/fd.o
>>>>>> sponsorship money that they are just giving straight to google to pay
>>>>>> for hosting credits? Google are profiting in some minor way from these
>>>>>> hosting credits being bought by us, and I assume we aren't getting any
>>>>>> sort of discounts here. Having google sponsor the credits costs google
>>>>>> substantially less than having any other company give us money to do
>>>>>> it.
>>>>> The last I looked, Google GCP / Amazon AWS / Azure were all pretty
>>>>> comparable in terms of what you get and what you pay for them.
>>>>> Obviously providers like Packet and Digital Ocean who offer bare-metal
>>>>> services are cheaper, but then you need to find someone who is going
>>>>> to properly administer the various machines, install decent
>>>>> monitoring, make sure that more storage is provisioned when we need
>>>>> more storage (which is basically all the time), make sure that the
>>>>> hardware is maintained in decent shape (pretty sure one of the fd.o
>>>>> machines has had a drive in imminent-failure state for the last few
>>>>> months), etc.
>>>>>
>>>>> Given the size of our service, that's a much better plan (IMO) than
>>>>> relying on someone who a) isn't an admin by trade, b) has a million
>>>>> other things to do, and c) hasn't wanted to do it for the past several
>>>>> years. But as long as that's the resources we have, then we're paying
>>>>> the cloud tradeoff, where we pay more money in exchange for fewer
>>>>> problems.
>>>> Admin for gitlab and CI is a full time role anyways. The system is
>>>> definitely not self sustaining without time being put in by you and
>>>> anholt still. If we have $75k to burn on credits, and it was diverted
>>>> to just pay an admin to admin the real hw + gitlab/CI would that not
>>>> be a better use of the money? I didn't know if we can afford $75k for
>>>> an admin, but suddenly we can afford it for gitlab credits?
>>> As I think about the time that I've spent at google in less than a
>>> year on trying to keep the lights on for CI and optimize our
>>> infrastructure in the current cloud environment, that's more than the
>>> entire yearly budget you're talking about here.  Saying "let's just
>>> pay for people to do more work instead of paying for full-service
>>> cloud" is not a cost optimization.
>>>
>>>
>>>>> Yes, we could federate everything back out so everyone runs their own
>>>>> builds and executes those. Tinderbox did something really similar to
>>>>> that IIRC; not sure if Buildbot does as well. Probably rules out
>>>>> pre-merge testing, mind.
>>>> Why? does gitlab not support the model? having builds done in parallel
>>>> on runners closer to the test runners seems like it should be a thing.
>>>> I guess artifact transfer would cost less then as a result.
>>> Let's do some napkin math.  The biggest artifacts cost we have in Mesa
>>> is probably meson-arm64/meson-arm (60MB zipped from meson-arm64,
>>> downloaded by 4 freedreno and 6ish lava, about 100 pipelines/day,
>>> makes ~1.8TB/month ($180 or so).  We could build a local storage next
>>> to the lava dispatcher so that the artifacts didn't have to contain
>>> the rootfs that came from the container (~2/3 of the insides of the
>>> zip file), but that's another service to build and maintain.  Building
>>> the drivers once locally and storing it would save downloading the
>>> other ~1/3 of the inside of the zip file, but that requires a big
>>> enough system to do builds in time.
>>>
>>> I'm planning on doing a local filestore for google's lava lab, since I
>>> need to be able to move our xml files off of the lava DUTs to get the
>>> xml results we've become accustomed to, but this would not bubble up
>>> to being a priority for my time if I wasn't doing it anyway.  If it
>>> takes me a single day to set all this up (I estimate a couple of
>>> weeks), that costs my employer a lot more than sponsoring the costs of
>>> the inefficiencies of the system that has accumulated.
>> I'm not trying to knock the engineering works the CI contributors have
>> done at all, but I've never seen a real discussion about costs until
>> now. Engineers aren't accountants.
>>
>> The thing we seem to be missing here is fiscal responsibility. I know
>> this email is us being fiscally responsible, but it's kinda after the
>> fact.
>>
>> I cannot commit my employer to spending a large amount of money (> 0
>> actually) without a long and lengthy process with checks and bounds.
>> Can you?
>>
>> The X.org board has budgets and procedures as well. I as a developer
>> of Mesa should not be able to commit the X.org foundation to spending
>> large amounts of money without checks and bounds.
>>
>> The CI infrastructure lacks any checks and bounds. There is no link
>> between editing .gitlab-ci/* and cashflow. There is no link to me
>> adding support for a new feature to llvmpipe that blows out test times
>> (granted it won't affect CI budget but just an example).
> We're working to get the logging in place to know which projects
> exactly burn down the money so that we can take specific actions. If
> needed. So pretty soon you wont be able to just burn down endless
> amounts of cash with a few gitlab-ci commits. Or at least not for long
> until we catch you and you either fix things up or CI is gone for your
> project.
>
>> The fact that clouds run on credit means that it's not possible to say
>> budget 30K and say when that runs out it runs out, you end up getting
>> bills for ever increasing amounts that you have to cover, with nobody
>> "responsible" for ever reducing those bills. Higher Faster Further
>> baby comes to mind.
> We're working on this, since it's the boards responsibility to be on
> top of stuff. It's simply that we didn't expect a massive growth of
> this scale and this quickly, so we're a bit behind on the controlling
> aspect.
>
> Also I guess it wasnt clear, but the board decision yesterday was the
> stop loss order where we cut the cord (for CI at least). So yeah the
> short term budget is firmly in place now.
>
>> Has X.org actually allocated the remaining cash in it's bank account
>> to this task previously? Was there plans for this money that can't be
>> executed now because we have to pay the cloud fees? If we continue to
>> May and the X.org bank account hits 0, can XDC happen?
> There's numbers elsewhere in this thread, but if you'd read the
> original announcement it states that the stop loss would still
> guarantee that we can pay for everything for at least one year. We're
> not going to get even close to 0 in the bank account.
>
> So yeah XDC happens, and it'll also still happen next year. Also fd.o
> servers will keep running. The only thing we might need to switch off
> is the CI support.
>
>> Budgeting and cloud is hard, the feedback loops are messy. In the old
>> system the feedback loop was simple, we don't have admin time or money
>> for servers we don't get the features, cloud allows us to get the
>> features and enjoy them and at some point in the future the bill gets
>> paid by someone else. Credit cards lifestyles all the way.
> Uh ... where exactly do you get the credit card approach from? SPI is
> legally not allowed to extend us a credit (we're not a legal org
> anymore), so if we hit 0 it's out real quick. No credit for us. If SPI
> isnt on top of that it's their loss (but they're getting pretty good
> at tracking stuff with the contractor they now have and all that).
>
> Which is not going to happen btw, if you've read the announcement mail
> and all that.
>
> Cheers, Daniel
Sorry to enter mid conversation. You may want to see how the
GCC test Farm does it or the Yocto Project. I do get their different
projects but they seem to be managing fine. I'm not sure of
their funding but I do recall that a lot of the machines I use
for work on the farm are donated from IBM or some company.

Not sure if you can get a company(ies) to donate some machines
and store them in a data center like GCC or the Yocto Project,

Nick
>> Like maybe we can grow up here and find sponsors to cover all of this,
>> but it still feels a bit backwards from a fiscal pov.
>>
>> Again I'm not knocking the work people have done at all, CI is very
>> valuable to the projects involved, but that doesn't absolve us from
>> costs.
>>
>> Dave.
>
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
