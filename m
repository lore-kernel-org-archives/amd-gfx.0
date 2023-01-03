Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D768C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 14:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD24810E3E9;
	Tue,  3 Jan 2023 14:28:59 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AECFC10E3E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 14:28:56 +0000 (UTC)
Received: from [192.168.1.137] ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202301031528493080; Tue, 03 Jan 2023 15:28:49 +0100
Message-ID: <9ec01205-22d4-da6e-328e-cded87e5c810@daenzer.net>
Date: Tue, 3 Jan 2023 15:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
 <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
 <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
In-Reply-To: <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1B.63B43BA3.0016,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: mikhail.v.gavrilov@gmail.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/3/23 15:26, Alex Deucher wrote:
> On Tue, Jan 3, 2023 at 3:34 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> I assume that this was already upstreamed while I was on sick leave?
> 
> Yes.

Though there seem to be more issues still, see comments on https://gitlab.freedesktop.org/drm/amd/-/issues/2309 .


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

