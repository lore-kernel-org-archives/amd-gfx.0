From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Date: Thu, 1 Aug 2019 14:48:37 +0200
Message-ID: <CAAeHK+zTFqsLiB3Wf0bAi5A8ukQX5ZuvfUg4td-=r5UhBsUBOQ@mail.gmail.com>
References: <cover.1563904656.git.andreyknvl@google.com> <8c618cc9-ae68-9769-c5bb-67f1295abc4e@intel.com>
 <13b4cf53-3ecb-f7e7-b504-d77af15d77aa@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13b4cf53-3ecb-f7e7-b504-d77af15d77aa@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Yishai Hadas <yishaih@mellanox.com>, Felix Kuehling <Felix.Kuehling@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 1, 2019 at 2:11 PM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
> On 31/07/2019 17:50, Dave Hansen wrote:
> > On 7/23/19 10:58 AM, Andrey Konovalov wrote:
> >> The mmap and mremap (only new_addr) syscalls do not currently accept
> >> tagged addresses. Architectures may interpret the tag as a background
> >> colour for the corresponding vma.
> > What the heck is a "background colour"? :)
>
> Good point, this is some jargon that we started using for MTE, the idea being that
> the kernel could set a tag value (specified during mmap()) as "background colour" for
> anonymous pages allocated in that range.
>
> Anyway, this patch series is not about MTE. Andrey, for v20 (if any), I think it's
> best to drop this last sentence to avoid any confusion.

Sure, thanks!

>
> Kevin
