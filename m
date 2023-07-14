Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45131C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 07:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090D710E7DF;
	Fri, 14 Jul 2023 07:16:18 +0000 (UTC)
X-Greylist: delayed 1820 seconds by postgrey-1.36 at gabe;
 Fri, 14 Jul 2023 04:14:42 UTC
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48ABC10E1AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 04:14:42 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1qK9iy-00066l-8O; Fri, 14 Jul 2023 05:44:08 +0200
Message-ID: <55a3bbb1-5b3c-f454-b529-8ee9944cc67c@leemhuis.info>
Date: Fri, 14 Jul 2023 05:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer dereference, address:
 00000004
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>, Taketo Kabe <kkabe@vega.pgw.jp>
References: <5f8d4aa5-3b23-8965-57e3-a28bd9aa8e87@gmail.com>
 <20230713231250.35488431@rorschach.local.home>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230713231250.35488431@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1689308082;
 45c8c55a; 
X-HE-SMSGID: 1qK9iy-00066l-8O
X-Mailman-Approved-At: Fri, 14 Jul 2023 07:16:15 +0000
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Regressions <regressions@lists.linux.dev>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 14.07.23 05:12, Steven Rostedt wrote:
> On Fri, 14 Jul 2023 09:50:17 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>
>> See Bugzilla for the full thread and attached patches that fixes
>> this regression.
>>
>> Later, when bisecting, the reporter got better kernel trace:
>>
>>> [  469.825305] BUG: kernel NULL pointer dereference, address: 00000004
>>> [  469.830502] #PF: supervisor read access in kernel mode
>>> [  469.830502] #PF: error_code(0x0000) - not-present page
>>> [  469.830502] *pde = 00000000
>>> [  469.830502] Oops: 0000 [#1] PREEMPT SMP
>>> [  469.830502] CPU: 0 PID: 365 Comm: systemd-udevd Not tainted 5.14.0-221.el9.v1.i586 #1
> 
> This is a 5.14 kernel right?

And a vendor kernel that from the sound of the version number might be
heavily patched. But apparently the reporter later bisected this on a
newer kernel (Bagas, would have been good if this had been mentioned in
your earlier mail):

https://bugzilla.kernel.org/show_bug.cgi?id=217669#c5
```
I succeeded to bisect down the regressing commit found in kernel-5.18.0-rc2:

b39181f7c690 (refs/bisect/bad) ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to
avoid adding weak function

This at a glance does not relate to drm/kms code.

The attached patch effectively reverts the commit for 32bit.
This fixed the problem on kernel-5.18.0, but not enough for kernel-6.4.3 ```

That being said: That commit is not in 5.18, as Steve noticed:

>> #regzbot introduced: b39181f7c6907d https://bugzilla.kernel.org/show_bug.cgi?id=217669
>> #regzbot title: FTRACE_MCOUNT_MAX_OFFSET causes kernel NULL pointer dereference and virtual console (tty1) freeze
> That commit was added in 5.19.
> 
> So I'm confused about why it's mentioned. Was it backported?

Taketo Kabe, could you please help to clean this confusion up? Did you
mean 5.19 in https://bugzilla.kernel.org/show_bug.cgi?id=217669#c5 ? And
BTW: did you really use a vanilla kernel for your bisection?

TWIMC, there is also
https://bugzilla.kernel.org/show_bug.cgi?id=217669#c6 :
```
Attached patch sort of fixes the problem; it does not panic and
KMS console works, but printk is triggered 4 times on radeon.ko load and
when VGA connector is plugged in.

I am sort of at loss now; I need advice from people which knows better.

 --- ./drivers/gpu/drm/drm_internal.h.rd	2023-06-25 21:35:27.506967450 +0900
 +++ ./drivers/gpu/drm/drm_internal.h.rd	2023-06-25 21:36:34.758055363 +0900
 @@ -99,6 +99,10 @@ u64 drm_vblank_count(struct drm_device *
  /* drm_vblank_work.c */
  static inline void drm_vblank_flush_worker(struct drm_vblank_crtc *vblank)
  {
 +	if (!vblank->worker) {
 +		printk(KERN_WARNING "%s: vblank->worker NULL? returning\n", __func__);
 +		return;
 +	}
  	kthread_flush_worker(vblank->worker);
  }
```

Ciao, Thorsten
