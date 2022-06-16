Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E83CC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 22:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9929411A628;
	Thu, 16 Jun 2022 22:41:17 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BC511A626
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 22:41:16 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 q1-20020a056830018100b0060c2bfb668eso1970378ota.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=AWCHew8dJ92FRAa86sjZqg/7uz35kqackjChUgkNjiw=;
 b=Sbn07kQgTXlj8XatmfRNXAU72cQaXb8VxilvqYsKtyR3h6nwF007C4986DhNrSkO+s
 x5OVfHmx3rGoV5XgKxT2TDvBiqTYywKNLRUPPHlr3amgPN+UCeO9vrHZmiMMRFRthmVI
 JbtKX1fCXXSeRR/e1ecfNesPq3ruFPKsZKkL8V2LFSQWvkqSsveykkdd1YWSpsxd9sd8
 nd9TeH5H8oVeM9sjgDlwHNcLy2C6Re7a1hmMUhFs/N8GGl3OeE1cWFJLZnTPlYJ/xHoP
 9ICO8nPy8CaK+XwlEWGmW0qyAZFV/c9tu/yqBdpNFnSB9PJ+4HImJ7khcWbtRRIFOy0T
 v3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=AWCHew8dJ92FRAa86sjZqg/7uz35kqackjChUgkNjiw=;
 b=ui52HeWdfq7Mx7VxmAWbMO8BPu0oSonNfYpQD4w60fjZrxQwKmtpdMmDWvmG0n0Zo3
 g3MEfRUShQKwaBHcjvmzo/eGkaU421n3q11ItYRcN02yfTuFn+DYII+Y444u44Q/tKRe
 Nl1i9cp9Vha9JN0Tlwdi3KyP32XOZ2/WCoZfmqR4aAM3S7gPw/WzV8HrPstA7Uoj8wBA
 9ZqSp2IZ9dgis0LlKkJ/JDiVSit7WnNxd2Uy3aiMtOOW0SYnxn0ei1XDzTaXZEz3eBjh
 efl8YjFKMdeDiwn0K92n2zalTwYbvSuWcuagWnigTfbPyD8zAJNa9TQwuIMl12UOa9fs
 mYkg==
X-Gm-Message-State: AJIora8NaaqN9XyfPsMzZ3Bz3/AXXyuzx8S/pr53Jo22cDVsOLyNgQ5n
 hPGK9J1PF1GzkPtAAJtCjfAXHw==
X-Google-Smtp-Source: AGRyM1vg4mrJ0bSA38QQ60GxwD9BVX0fzA6Z6x2kYxwAP5Zg8De9eraONxzGZct4/qBV37pr7IgO+Q==
X-Received: by 2002:a05:6830:2695:b0:60c:6e16:460f with SMTP id
 l21-20020a056830269500b0060c6e16460fmr2899781otu.249.1655419275291; 
 Thu, 16 Jun 2022 15:41:15 -0700 (PDT)
Received: from ?IPV6:2804:14d:8084:84c6:fe26:c42d:aab9:fa8a?
 ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
 by smtp.gmail.com with ESMTPSA id
 ly14-20020a056870fc8e00b000e686d13889sm1532110oab.35.2022.06.16.15.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jun 2022 15:41:14 -0700 (PDT)
Message-ID: <8b040fb2-7edd-6fd1-864e-ee04115c5b1d@usp.br>
Date: Thu, 16 Jun 2022 19:41:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC 0/3] drm/amd/display: Introduce KUnit to Display Mode Library
Content-Language: en-US
To: David Gow <davidgow@google.com>
References: <20220608010709.272962-1-maira.canal@usp.br>
 <CABVgOSmesj5MGfQrtdWCgXzm1VXRoG0fAMCbkBCAvtqediqAjQ@mail.gmail.com>
From: =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <CABVgOSmesj5MGfQrtdWCgXzm1VXRoG0fAMCbkBCAvtqediqAjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Harrison Chiu <harrison.chiu@amd.com>, Daniel Latypov <dlatypov@google.com>,
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Jun Lei <jun.lei@amd.com>, magalilemes00@gmail.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 mwen@igalia.com, Sean Paul <seanpaul@chromium.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Mark Yacoub <markyacoub@chromium.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Nicholas Choi <Nicholas.Choi@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 tales.aparecida@gmail.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi David,

Thank you for your feedback!

On 6/16/22 11:39, David Gow wrote:
> On Wed, Jun 8, 2022 at 9:08 AM Maíra Canal <maira.canal@usp.br> wrote:

>>
>> As kunit_test_suites() defines itself as an init_module(), it conflicts with
>> the existing one at amdgpu_drv. So, if we use kunit_test_suites(), we won't
>> be able to compile the tests as modules and, therefore, won't be able to use
>> IGT to run the tests. This problem with kunit_test_suites() was already
>> discussed in the KUnit mailing list, as can be seen in [7].
> 
> I'm not sure I fully understand why these tests need to be part of the
> amdgpu module, though admittedly I've not played with IGT much. Would
> it be possible to compile these tests as separate modules, which could
> depend on amdgpu (or maybe include the DML stuff directly), and
> therefore not have this conflict? I definitely was able to get these
> tests working under kunit_tool (albeit as built-ins) by using
> kunit_test_suites(). If each suite were built as a separate module (or
> indeed, even if all the tests were in one module, with one list of
> suites), then it should be possible to avoid the init_module()
> conflict. That'd also make it possible to run these tests without
> actually needing the driver to initialise, which seems like it might
> require actual hardware(?)

Initially, we tried the kunit_test_suites() approach. And it did work pretty well for the kunit_tool (although we didn't test any hardware-specific unit test). But when compiling the test as a module, we would get a linking error, pointing out multiple definitions of 'init_module'/'cleanup_module' at kunit_test_suites().

At this point, we thought about a couple of options to resolve this problem:
- Add EXPORT_SYMBOL to the functions we would test. But, this doesn't scale pretty well, because it would pollute AMDGPU code as the tests expand.
- Take the Thunderbolt path and add the tests to the driver stack.

We end up taking the Thunderbolt path as it would be more maintainable.

Compiling the tests as a module is essential to make the tests run at IGT, as IGT essentially loads the module, runs it, and parses the output (a very very simplified explanation of what IGT does). IGT is a very known tool for DRI developers, so we believe that IGT support is crucial for this project.

If you have any other options on how to make the module compilation viable without using the 'thunderbolt'-style, we would be glad to hear your suggestions.

> 
> There are two other reasons the 'thunderbolt'-style technique is one
> we want to avoid:
> 1. It makes it much more difficult to run tests using kunit_tool and
> KUnit-based CI tools: these tests would not run automatically, and if
> they were built-in as-is, they'd need to be
> 2. We're planning to improve module support to replace the
> init_module()-based implementation of kunit_test_suites() with one
> which won't have these conflicts, so the need for this should be
> short-lived.
> 
> If you're curious, an early version of the improved module support can
> be found here, though it's out-of-date enough it won't apply or work
> as-is:
> https://lore.kernel.org/all/101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au/
> 
> Now, that's unlikely to be ready very soon, but I'd be hesitant to
> implement too extensive a system for avoiding kunit_test_suites()
> given at some point it should work and we'll need to migrate back to
> it.

We hope to see in the near future the improved module support from KUnit as it would make the addition of tests much more simple and clean.

Could you explain more about what is missing to make this improved module support come upstream?

> 
> At the very least, having the dependency on KUNIT=m is a very bad
> idea: it should be possible to have tests built as modules, even if
> KUnit itself isn't, and ideally (even if this sort-of implementation
> is required), it _should_ be possible to have these tests be built-in
> if all their dependencies (KUnit, amdgpu) are, which would make it
> possible to run the tests without a userland.
> 

Thank you for the suggestion! We will change the KUNIT dependency.

- Maíra Canal
