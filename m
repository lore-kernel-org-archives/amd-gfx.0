From: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH 03/11] drm/amdgpu: convert amdgpu_vm_it to half closed
 intervals
Date: Fri, 4 Oct 2019 04:36:28 -0700
Message-ID: <20191004113628.GA260828@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-4-dave@stgolabs.net>
 <dc9cc8c4-7275-43be-5bed-91384e3246ae@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dc9cc8c4-7275-43be-5bed-91384e3246ae@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Davidlohr Bueso <dbueso@suse.de>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Oct 04, 2019 at 06:54:54AM +0000, Koenig, Christian wrote:
> Am 03.10.19 um 22:18 schrieb Davidlohr Bueso:
> > The amdgpu_vm interval tree really wants [a, b) intervals,
> 
> NAK, we explicitly do need an [a, b[ interval here.

Hi Christian,

Just wanted to confirm where you stand on this patch, since I think
you reconsidered your initial position after first looking at 9/11
from this series.

I do not know the amdgpu code well, but I think the changes should be
fine - in struct amdgpu_bo_va_mapping, the "end" field will hold what
was previously stored in the "last" field, plus one. The expectation
is that overflows should not be an issue there, as "end" is explicitly
declared as an uint64, and as the code was previously computing
"last + 1" in many places.

Does that seem workable to you ?

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
