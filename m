From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Wed, 25 Apr 2018 19:17:57 +0200
Message-ID: <20180425171757.GA10441@redhat.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com>
 <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com>
 <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

On 04/25, Andrey Grodzovsky wrote:
>
> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
> able to exit immediately
> and not wait for GPU jobs completion when the reason for reaching this code
> is because of KILL
> signal to the user process who opened the device file.

Can you hook f_op->flush method?

Oleg.
