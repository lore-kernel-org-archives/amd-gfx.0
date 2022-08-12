Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ED7C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 16:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C19593390;
	Fri, 12 Aug 2022 16:31:51 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17A093DCD
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 06:58:51 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id s129so20442065vsb.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 23:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=yLQbN4eIvQefhX3Hln/sx5dbsLg0I2kSrO5az7sqdpc=;
 b=bsLV5bOQyO367SV1HXkB+FPSEaEvXu47cCO1GXXwD2EhXsFaPDODIUebiyOI6BXqUC
 yMBk0r6hmDyd4f73vUUH/6S0y3QDIbrRKMWijquoIr+qcV8HxuTMDed9nHBPTrdTtdzT
 Jh5kqVd+3YPEplxLYtteihZ8/EJaNHVgmRMkE/2IOpEnDj6MousGNRwV6vWHUWBzrefO
 PDT3BJIEuhzoOrtVpuQIaioNte+CszSsnD6QYFO7ikZqXtIb2kc6MtuxmNy3iymwPn1p
 f8HxnVO/bYSnSs1ePuuA43xLNXRCJTsef/6Dc9ssSjSZHqs4oO0MTbWywH3SaH2XtTiV
 x+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=yLQbN4eIvQefhX3Hln/sx5dbsLg0I2kSrO5az7sqdpc=;
 b=iEmqgzpBVnCBdwg2s0Nw95ljXf2zi1VGiiz/ujISZV5iktY7uHPEMFWPPPF1pQD5SI
 4d7d1wRvKxjzdmEtu9gv9QbycjzXdsbqJzTQSS/FsSgSAqQED7lqoPWlDGT8OSEpg+VB
 2Ew/jCIjEFnMf4xd+nkISERKS3emF96TumCVLWl6zE/hxE018/7CUdjHMTVZzpxRbjHB
 zoWCBL+6to3bCy1NhF2J6OmQE6LRPQ68qaw57Gymfh1XmP/xU74k68Gazfwezq2igNZZ
 awxnzlG18nL4sZLhxBNUXGAAQ062UGlr1+VEnd5GM4XSKo5autWZ4xGHZKaMKzGLz1Ky
 UdDA==
X-Gm-Message-State: ACgBeo1TBbUSh98RxqPAmtoTmmLFjCmhkQrpurLwz88WVvUgOg7H6YWp
 5tW4laIIrviz4jcapBwZkTmTG6U0nkjiTSfv34n5Ww==
X-Google-Smtp-Source: AA6agR6weiRDIjAc6jxCYeMGsZtojNukN0w/4QxDYmJ9mktXw4XCYLps6mK2pNiS9X3OIAFgqlqKFCuauQKxiSxRu+M=
X-Received: by 2002:a67:cb0c:0:b0:357:9897:32d4 with SMTP id
 b12-20020a67cb0c000000b00357989732d4mr1296521vsl.18.1660287529563; Thu, 11
 Aug 2022 23:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <6d24ac92-7ea9-0c35-a97a-bfb53b84f655@amd.com>
In-Reply-To: <6d24ac92-7ea9-0c35-a97a-bfb53b84f655@amd.com>
From: David Gow <davidgow@google.com>
Date: Fri, 12 Aug 2022 14:58:38 +0800
Message-ID: <CABVgOSmN9dfQc9yWqWMgR=G6WuCfPCmvAmMn=ecHdK9S-9MF=g@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm/amd/display: Introduce KUnit to Display Mode
 Library
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Aug 2022 16:31:46 +0000
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
Cc: andrealmeid@riseup.net, Thomas Zimmermann <tzimmermann@suse.de>,
 siqueirajordao@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Tales Aparecida <tales.aparecida@gmail.com>,
 Trevor Woerner <twoerner@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 magalilemes00@gmail.com, Isabella Basso <isabbasso@riseup.net>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 KUnit Development <kunit-dev@googlegroups.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 7:22 PM 'Christian K=C3=B6nig' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
>
>
> Am 11.08.22 um 02:40 schrieb Tales Aparecida:
> > Hello,
> >
> > This series is the consolidation of an RFC sent earlier this year [RFC]
> > bringing unit testing to the AMDPGU driver. [gsoc]
> >
> > Our main goal is to bring unit testing to the AMD display driver; in
> > particular, we'll focus on the Display Mode Library (DML) for DCN2.0,
> > DMUB, and some of the DCE functions. This implementation intends to
> > help developers to recognize bugs before they are merged into the
> > mainline and also makes it possible for future code refactors of the
> > AMD display driver.
> >
> > For the implementation of the tests, we decided to go with the Kernel
> > Unit Testing Framework (KUnit). KUnit makes it possible to run test
> > suites on kernel boot or load the tests as a module. It reports all tes=
t
> > case results through a TAP (Test Anything Protocol) in the kernel log.
> > Moreover, KUnit unifies the test structure and provides tools to
> > simplify the testing for developers and CI systems.
> >
> > In regards to CI pipelines, we believe kunit_tool[kunit_tool] provides
> > ease of use, but we are also working on integrating KUnit into IGT, for
> > those already depending on the tool [igt_patch].
> >
> > We've chosen what we believe to be the simplest approach to integrate
> > KUnit tests into amdgpu [kunit_static]. We took into consideration that
> > this driver relies heavily on static functions with complex behavior
> > which would benefit from unit testing, otherwise, black-box tested
> > through public functions with dozens of arguments and sometimes high
> > cyclomatic complexity. Further than that, this approach also helps
> > beginners by avoiding the need to edit any Makefiles. Other approaches
> > are available and we would gladly receive feedback on this matter.
>
> Yeah, that approach immediately trigger goosebumps for me. We should
> absolutely not do that.
>
> The static functions are subject to change and we shouldn't need to
> change the unit tests when only the internals change.
>
> Instead black box testing and/or exposing tests as a separate module
> (e.g. for the fixed point calculations for example) is probably the way
> to go.
>
> Just my thoughts on this, essentially our display team has to take a look=
.
>
> Regards,
> Christian.
>

To jump in from a KUnit maintainer point-of-view, I think the need to
test static functions (in at least some cases) is inevitable. Ideally,
we'd have a much better way of doing so than just #include-ing the
test code into the main module, but all of the other options we have
around at the moment would require exporting the otherwise-static
functions, which seems like a greater leap at present.

Note that one of the goals of KUnit is to allow internals and
implementation details to be tested, where that makes sense. It's
certainly not going to be the right thing for every case, and there is
the overhead of having to update tests when refactoring or otherwise
changing the internals, but the benefit of being able to isolate
exactly the calculation / function/ etc. which needs to be verified is
often worth these costs.

That being said, there's no reason all of the AMDGPU tests would need
to take the same approach, and if, e.g., including the fixed-point
code in a separate test module makes more sense there, I don't think
there's anything that'd prevent you from doing that. (And having tests
in independent modules is definitely preferable where it's practical
to do so.)

Cheers,
-- David-

> >
> > The first three patches add KUnit represent what we intend to do on the
> > rest of the DML modules: systematic testing of the DML functions,
> > especially mathematically complicated functions. Also, it shows how
> > simple it is to add new tests to the DML.
> >
> > Among the tests, we highlight the dcn20_fpu_test, which, had it existed
> > then, could catch the defects introduced to dcn20_fpu.c by
> > 8861c27a6c [dcn20_bug] later fixed by 9ad5d02c2a [dcn20_fix].
> >
> > In this series, there's also an example of how unit tests can help avoi=
d
> > regressions and keeping track of changes in behavior.
> >
> > Applying this series on top of the amd-staging-drm-next (2305916dca04)
> > and running its tests will result in a failure in the `dc_dmub_srv`
> > test, you can verify that with:
> >
> > $ ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
> >               --kunitconfig=3Ddrivers/gpu/drm/amd/display/tests
> >
> > ```
> > ...
> > [20:19:00] # Subtest: populate_subvp_cmd_drr_info_test
> > [20:19:00] # populate_subvp_cmd_drr_info_test: pass:0 fail:5 skip:0 tot=
al:5
> > [20:19:00] not ok 1 - populate_subvp_cmd_drr_info_test
> > [20:19:00] =3D=3D=3D=3D=3D=3D=3D=3D [FAILED] populate_subvp_cmd_drr_inf=
o_test =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [20:19:00] # Subtest: dc_dmub_srv
> > [20:19:00] 1..1
> > [20:19:00] # Totals: pass:0 fail:5 skip:0 total:5
> > [20:19:00] not ok 8 - dc_dmub_srv
> > [20:19:00] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [F=
AILED] dc_dmub_srv =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [20:19:00] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [20:19:00] Testing complete. Passed: 59, Failed: 5, Crashed: 0, Skipped=
: 0, Errors: 0
> > ```
> > Full output at: https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fshare.riseup.net%2F%23SOggjANeLfbibdiHu2e_Ug&amp;data=3D05%7C0=
1%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&amp;sdata=3Dkiaq3dfpSMiFGkMIXKHhHsMyr7o%2FuvKgny0ifF%2FzrmA%3D&=
amp;reserved=3D0
> >
> > This is due to a known regression introduced by commit 5da7f4134357
> > ("drm/amd/display: fix 32 bit compilation errors in dc_dmub_srv.c")
> > [dmub_bug], which resulted in the struct's members being zero.  As an
> > exercise, you can revert the offending patch and run the tests again,
> > but that would still result in failure, albeit with a different output.
> >
> > Full output when reverted: https://nam11.safelinks.protection.outlook.c=
om/?url=3Dhttps%3A%2F%2Fshare.riseup.net%2F%23EEBgtgXjAmof5vZ_qs7_sg&amp;da=
ta=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c=
7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D%2Flv%2FAOosByeD8vPteKdqGqv2QHf50S6nTNTq=
ma91fm8%3D&amp;reserved=3D0
> >
> > This regression is currently being worked on [dmub_fix], and this
> > test-series will result in a success if applied alongside the
> > fix-series, particularly the patches 1-13/32.
> >
> > ```
> > [17:48:14] Testing complete. Passed: 64, Failed: 0, Crashed: 0, Skipped=
: 0, Errors: 0
> > ```
> > Full successful output: https://nam11.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fshare.riseup.net%2F%23migyN1Xpy3Gyq1it84HhNw&amp;data=
=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7=
CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn=
0%3D%7C3000%7C%7C%7C&amp;sdata=3DzMOuzPypnx6oH9rMUYZwLpHELZd%2FaId4Tdh93LRr=
8bM%3D&amp;reserved=3D0
> >
> > This series depends on a couple of Kunit patches already merged into
> > torvalds/master, which themselves depends on older patches:
> >
> > commit 61695f8c5d51 ("kunit: split resource API from test.h into new re=
source.h")
> > commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> > commit cfc1d277891e ("module: Move all into module/")
> > commit cdebea6968fa ("kunit: split resource API impl from test.c into n=
ew resource.c")
> > commit cae56e1740f5 ("kunit: rename print_subtest_{start,end} for clari=
ty (s/subtest/suite)")
> > commit 1cdba21db2ca ("kunit: add ability to specify suite-level init an=
d exit functions")
> > commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run"=
)
> > commit 3d6e44623841 ("kunit: unify module and builtin suite definitions=
")
> > commit a02353f49162 ("kunit: bail out of test filtering logic quicker i=
f OOM")
> > commit 1b11063d32d7 ("kunit: fix executor OOM error handling logic on n=
on-UML")
> > commit e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in=
 .kunit_test_suites")
> > commit 94681e289bf5 ("kunit: executor: Fix a memory leak on failure in =
kunit_filter_tests")
> >
> > You can get a for branch ready for compilation at
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
lab.freedesktop.org%2Fisinyaaa%2Flinux%2F-%2Ftags%2Fintroduce-kunit-for-amd=
-v1&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d0=
8da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DhqIFUFjM1UDOTXYsckuoLP9nyxAvlV=
B4iCMs8FWkGnc%3D&amp;reserved=3D0
> >
> > Thanks in advance for your time taking a look and sending any feedback!
> >
> > Best regards,
> > Isabella Basso, Magali Lemes, Ma=C3=ADra Canal, and Tales Aparecida
> >
> > [RFC] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flore.kernel.org%2Famd-gfx%2F20220608010709.272962-1-maira.canal%40usp.br=
%2F&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d0=
8da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DXEk%2FNJacxlhjCymXuo3tVQHle9Mt=
iSCKIOXyP%2B4Pa3M%3D&amp;reserved=3D0
> > [gsoc] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fsummerofcode.withgoogle.com%2Fprograms%2F2022%2Forganizations%2Fxorg-fo=
undation&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b=
078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6379577522849=
93982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I=
k1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZxjFnl5bjczfWxzpHOEKDU314=
QS4hmbIxTgvjPxqmJs%3D&amp;reserved=3D0
> > [kunit_tool] https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fdev-tools%2Fkunit%2Fkunit-=
tool.html&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425=
b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284=
993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6=
Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D0jUQGUFKW8BVVgpD4sNkkLdq=
Mn23X1S67y7Fj0RqZKY%3D&amp;reserved=3D0
> > [igt_patch] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Farchives%2Figt-dev%2F2022-June%2F042895.ht=
ml&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08=
da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DJmOfrDfQIWohsDCg%2F1BLyFckeG1CW=
fmM3NPwcpE5WFQ%3D&amp;reserved=3D0
> > [kunit_static] https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Fdocs.kernel.org%2Fdev-tools%2Fkunit%2Fusage.html%23testing-stat=
ic-functions&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628=
425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752=
284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT=
iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DIWA0KRuA1T3YCZIpq9JD8=
wTxE8gTZi%2B9aLJywU1Os4k%3D&amp;reserved=3D0
> > [dcn20_bug] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220603185042.3408844-6-Rodrigo.Sique=
ira%40amd.com%2F&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd=
3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63795=
7752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Db7B7QscRHX2STfVGR=
iE09RxYSvZTDLW59vi7lQTPrM0%3D&amp;reserved=3D0
> > [dcn20_fix] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220608164856.1870594-1-sunpeng.li%40=
amd.com%2F&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd362842=
5b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63795775228=
4993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI=
6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DyQR9AxoguAvVR%2BGni9GUh=
SdhgHKujcUXujFL30QZqAc%3D&amp;reserved=3D0
> > [dmub_bug] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220708052650.1029150-1-alexander.deuc=
her%40amd.com%2F&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd=
3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63795=
7752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DWUb4zaBIhOd8oAjmc=
n19itKTbulUFepGfAtY%2FWLmrq8%3D&amp;reserved=3D0
> > [dmub_fix] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220805175826.2992171-14-chiahsuan.chu=
ng%40amd.com%2FT%2F&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7Cb4478=
7cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
7957752285150231%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZ4AWumNHtXuHo8=
h7%2Fh%2Bdd0VqBQeywtbaD35pCKs0neQ%3D&amp;reserved=3D0
> >
> > Isabella Basso (1):
> >    drm/amd/display: Introduce Kunit tests to display_rq_dlg_calc_20
> >
> > Magali Lemes (1):
> >    drm/amd/display: Introduce KUnit tests for dcn20_fpu
> >
> > Ma=C3=ADra Canal (5):
> >    drm/amd/display: Introduce KUnit tests to the bw_fixed library
> >    drm/amd/display: Introduce KUnit tests to the display_mode_vba libra=
ry
> >    drm/amd/display: Introduce KUnit to dcn20/display_mode_vba_20 librar=
y
> >    drm/amd/display: Introduce KUnit tests to dc_dmub_srv library
> >    Documentation/gpu: Add Display Core Unit Test documentation
> >
> > Tales Aparecida (1):
> >    drm/amd/display: Introduce KUnit tests for fixed31_32 library
> >
> >   .../gpu/amdgpu/display/display-test.rst       |  73 ++
> >   Documentation/gpu/amdgpu/display/index.rst    |   1 +
> >   drivers/gpu/drm/amd/display/Kconfig           |  25 +
> >   .../drm/amd/display/dc/basics/fixpt31_32.c    |   5 +
> >   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
> >   .../drm/amd/display/dc/dml/calcs/bw_fixed.c   |   3 +
> >   .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +
> >   .../dc/dml/dcn20/display_mode_vba_20.c        |   4 +
> >   .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   4 +
> >   .../drm/amd/display/dc/dml/display_mode_vba.c |   3 +
> >   .../gpu/drm/amd/display/tests/.kunitconfig    |   7 +
> >   .../dc/basics/dc_basics_fixpt31_32_test.c     | 232 ++++++
> >   .../amd/display/tests/dc/dc_dmub_srv_test.c   | 285 +++++++
> >   .../tests/dc/dml/calcs/bw_fixed_test.c        | 323 ++++++++
> >   .../tests/dc/dml/dcn20/dcn20_fpu_test.c       | 560 +++++++++++++
> >   .../dc/dml/dcn20/display_mode_vba_20_test.c   | 227 ++++++
> >   .../dml/dcn20/display_rq_dlg_calc_20_test.c   | 112 +++
> >   .../tests/dc/dml/display_mode_vba_test.c      | 741 +++++++++++++++++=
+
> >   18 files changed, 2613 insertions(+)
> >   create mode 100644 Documentation/gpu/amdgpu/display/display-test.rst
> >   create mode 100644 drivers/gpu/drm/amd/display/tests/.kunitconfig
> >   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/basics/dc_bas=
ics_fixpt31_32_test.c
> >   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_t=
est.c
> >   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/calcs/bw_=
fixed_test.c
> >   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dcn=
20_fpu_test.c
> >   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dis=
play_mode_vba_20_test.c
> >   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dis=
play_rq_dlg_calc_20_test.c
> >   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/display_m=
ode_vba_test.c
> >
> >
> > base-commit: 2305916dca043ed69bd464f74a886b0216780aa6
> > prerequisite-patch-id: 83185f6c5da6070e7b0b608bc705a2d3bf295ae6
> > prerequisite-patch-id: 65407777e3bb20dfe5051f4f4cc7deb6a3c2ed34
> > prerequisite-patch-id: 60af3dadcfd4a778f10dd09fafbde6061d98528b
> > prerequisite-patch-id: 92d9259125f2982da5945be995b4ae2af1ca7c32
> > prerequisite-patch-id: f35acb6c07c0bd5496df919214351399d9aed5b5
> > prerequisite-patch-id: 8a9637d89966e51adfe11e3fd3d17fcf1328b472
> > prerequisite-patch-id: ea6f40f1cfb61fddb9d1562111897e184da49bf7
> > prerequisite-patch-id: ae79651ae7b2e02520b18fc7eded463afea757e5
> > prerequisite-patch-id: ba795b981f3e94890540f452e658e28408b500d2
> > prerequisite-patch-id: abd5e51f483a9afb08af468db043e2ebc7ce6867
> > prerequisite-patch-id: a31028824a461f8b4a6b9244035e246efbee9c71
> > prerequisite-patch-id: a65dfe200981f8584ba3b1f9813faa4f0022a13e
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/6d24ac92-7ea9-0c35-a97a-bfb53b84f655%40amd.com.
