From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v19 02/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
Date: Wed, 31 Jul 2019 10:05:15 -0700
Message-ID: <7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <1c05651c53f90d07e98ee4973c2786ccf315db12.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1c05651c53f90d07e98ee4973c2786ccf315db12.1563904656.git.andreyknvl@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Yishai Hadas <yishaih@mellanox.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Leon Romanovsky <leon@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@>
List-Id: amd-gfx.lists.freedesktop.org

On 7/23/19 10:58 AM, Andrey Konovalov wrote:
> +long set_tagged_addr_ctrl(unsigned long arg)
> +{
> +	if (!tagged_addr_prctl_allowed)
> +		return -EINVAL;
> +	if (is_compat_task())
> +		return -EINVAL;
> +	if (arg & ~PR_TAGGED_ADDR_ENABLE)
> +		return -EINVAL;
> +
> +	update_thread_flag(TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
> +
> +	return 0;
> +}

Instead of a plain enable/disable, a more flexible ABI would be to have
the tag mask be passed in.  That way, an implementation that has a
flexible tag size can select it.  It also ensures that userspace
actually knows what the tag size is and isn't surprised if a hardware
implementation changes the tag size or position.

Also, this whole set deals with tagging/untagging, but there's an
effective loss of address space when you do this.  Is that dealt with
anywhere?  How do we ensure that allocations don't get placed at a
tagged address before this gets turned on?  Where's that checking?
