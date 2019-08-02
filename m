From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v19 02/15] arm64: Introduce prctl() options to control
 the tagged user addresses ABI
Date: Fri, 2 Aug 2019 11:50:38 +0100
Message-ID: <20190802105038.GC4175@arrakis.emea.arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <1c05651c53f90d07e98ee4973c2786ccf315db12.1563904656.git.andreyknvl@google.com>
 <7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com>
 <2b274c6f-6023-8eb8-5a86-507e6000e13d@arm.com>
 <88c59d1e-eda9-fcfe-5ee3-64a331f34313@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <88c59d1e-eda9-fcfe-5ee3-64a331f34313@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>, linux-kselftest@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dmitry Vyukov <dvyukov@google.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevi>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 01, 2019 at 09:45:05AM -0700, Dave Hansen wrote:
> On 8/1/19 5:38 AM, Kevin Brodsky wrote:
> > This patch series only changes what is allowed or not at the syscall
> > interface. It does not change the address space size. On arm64, TBI (Top
> > Byte Ignore) has always been enabled for userspace, so it has never been
> > possible to use the upper 8 bits of user pointers for addressing.
> 
> Oh, so does the address space that's available already chop that out?

Yes. Currently the hardware only supports 52-bit virtual addresses. It
could be expanded (though it needs a 5th page table level) to 56-bit VA
but it's not currently on our (hardware) plans. Beyond 56-bit, it cannot
be done without breaking the software expectations (and hopefully I'll
retire before we need this ;)).

> > If other architectures were to support a similar functionality, then I
> > agree that a common and more generic interface (if needed) would be
> > helpful, but as it stands this is an arm64-specific prctl, and on arm64
> > the address tag is defined by the architecture as bits [63:56].
> 
> It should then be an arch_prctl(), no?

I guess you just want renaming SET_TAGGED_ADDR_CTRL() to
arch_prctl_tagged_addr_ctrl_set()? (similarly for 'get')

-- 
Catalin
