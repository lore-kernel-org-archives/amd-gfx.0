From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Mon, 30 Apr 2018 17:29:41 +0200
Message-ID: <20180430152941.GA10583@redhat.com>
References: <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com>
 <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com>
 <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
 <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, David.Panariti@amd.com, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com, akpm@linux-foundation.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

On 04/30, Christian König wrote:
>
> Well when the process is killed we don't care about correctness any more, we
> just want to get rid of it as quickly as possible (OOM situation etc...).

OK,

> But it is perfectly possible that a process submits some render commands and
> then calls exit() or terminates because of a SIGTERM, SIGINT etc..

This doesn't differ from SIGKILL. I mean, any unhandled fatal signal translates
to SIGKILL and I think this is fine.

but this doesn't really matter,

> So what we essentially need is to distinct between a SIGKILL (which means
> stop processing as soon as possible) and any other reason because then we
> don't want to annoy the user with garbage on the screen (even if it's just
> for a few milliseconds).

For what?

OK, I see another email from Andrey, I'll reply to that email...

Oleg.
