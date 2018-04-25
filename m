From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Wed, 25 Apr 2018 15:55:52 +0200
Message-ID: <20180425135552.GD7592@redhat.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com>
 <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877eowa5qh.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

On 04/24, Eric W. Biederman wrote:
>
> Let me respectfully suggest that the wait_event_killable on that code
> path is wrong.

I tend to agree even if I don't know this code.

But if it can be called from f_op->release() then any usage of "current" or
signals looks suspicious. Simply because "current" can be completely irrelevant
task which does the last fput(), say, cat /proc/pid/fdinfo/... or even a kernel
thread.

Oleg.
