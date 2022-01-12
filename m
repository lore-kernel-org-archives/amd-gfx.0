Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D2EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 03:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A88810E461;
	Wed, 12 Jan 2022 03:15:46 +0000 (UTC)
X-Greylist: delayed 306 seconds by postgrey-1.36 at gabe;
 Wed, 12 Jan 2022 01:17:10 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4A210E30D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 01:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1641950228;
 bh=uMqFVhn3qC7iE5mJlB4udn7UImbczL+pY06FCppG66c=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
 b=oE7XrirbiWvf9qTYrO/fvys3ec5jiowmUTFpDYw7r8rwV4cvPJ7bOqCpZSVLoV3vr
 3RU8wKvoCDdlXhf0NYOjLAhK4ixLCcWDkSY/WUBBNSDTvdTSq9exAxUBZh5/3ZKXmU
 /RMgt3woay1EKOBq6cCpoLfMpwxjYMQgpayGslsA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.101] ([88.152.98.65]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1mdqzp0N9Y-00lhuO; Wed, 12
 Jan 2022 02:11:57 +0100
Message-ID: <c0ac94855d1119e398c5607263d06c750249300f.camel@web.de>
Subject: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on DCN20/DCN21
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Wed, 12 Jan 2022 02:11:37 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:H1JCgYOqddI/as6u1tjlAiBghsVT3gSZDe8mqadxWzOrin1WgHb
 SI8kg791hMHRUMptS4qUXAb9weFvXn+vVaMPjIzASwEsiTbGzL1OgAQfGTD4tl3bMEfJZOJ
 IIc/sWMxOl86EEiEXZ98thu3d6ZW26Gbko+DdKhyM0Mtu8wnSUDuqTRQiaF+2T8Kcp2r1I3
 LZLXFRgTBFwKldtUqHXcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OsCWo8vxfgM=:qeykzL3wAb1H8tTcFVHiob
 AMAnHATx2ojUj6B84lPSelDzuUEy3CRBOLpPx1f/eMeucmI9yxZx3iq0/9TqOm6JpLDGw3hwI
 83oWcnqCCyr/Emg9eewhbwZAnbT9BH4TqjBobFx4IkZ9+xjs7aysguv6cFMSoTE2OmW4+CvZG
 buMHvvXHFjWp0CfESMzUCkbkFa4mrZfoAfF9VqqnxAZx7TM0b6AcKh0kIPokgOwWILSWzUe6O
 x+2HdhULrfzR07Lm/Ag+lB9JJJ1x9y8KaqLQo+EgoKXl7FMmL3QhmeQoXilkU7ErZkBUPsCsV
 +OW9yeIE0cEkv/6eZZ2fWonQqzFFrkUkbq3S0Td6HWO5J3MmXR2Ev5RitgpAO+Qn7AT1z1aoP
 ENgFp9i0Fltyib6ZjGJPzJFZiLt9h49aU00CvlaF7UOcOf7rwLGXOQikESMKWQUFM9HBKI65v
 8rSDjccv8hNhJbIYmf2NLvmoGKTAmdyH+QLa25xVLUjEF3ieYKarp60MiD7w7RkBa3nVDGLGq
 uAIEXgcYhEvSV64gUqbr0j/0Q+RREi2kMPe2K+QeEponStj/fK9MQHC06cNFtNEi36HhxuUvo
 Njuz/uRdtmiNTHyEYXpBRzFCLRTprGTyny7bkxKmLP1uxP7V4lzIcfCrU9hQ/760ehHQyyaU1
 9IXut0CSqiitwkz/vouZocm9cv1BzosfKeJwzWpBcg9gN1616Gve34ksJcdJbhVZ24V8S8JSU
 /umpnT1xXv3lZFtQ3LWJILp75/3Aro71Nbb+tXI3v/ENQnn2PlkipkbPJjCZ8K1/89pHuj0xF
 /UcQ1Ux7sPbEbY8bnSSuSth6SeHuu2FOFIFH7IGsTi3+cF58Zsd0TJUCBc5vIYmuv00o2KneA
 7fFHVkjLwu7pVkIv9EYrMHDgNcl/EHxL01mZEHTEALtAEVzjFCJQqteKRLwNN+Y0y+ssySveN
 OQVPHNUCXqMAJeAJNhouFPbJA8AXHsPh8Pu/SPXWb5URjLj1J2jJbxXc9ozvEyNlxG8PxEsh3
 zAcx0+zCchurdMr3Z8RTjA7EBrPL64HF1r/j++0kLvFOfu4Dqh/dU/tD8oVA1Tj0VKt7OH78u
 oXrl09Wm3vhhY4=
X-Mailman-Approved-At: Wed, 12 Jan 2022 03:15:44 +0000
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>,
 Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I just tested patch v5 applied to amd-staging-drm-next (with HEAD
26c981e27e698c251ef3241f73ac846e66ad7fc3) and suspend and resume work
fine. But as amd-staging-drm-next is still based on linux-5.13 I had to
replace the mediatek wlan driver by the version from linux-5.16.
