From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v19 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
Date: Wed, 24 Jul 2019 16:25:04 -0300
Message-ID: <20190724192504.GA5716@ziepe.ca>
References: <cover.1563904656.git.andreyknvl@google.com>
 <7969018013a67ddbbf784ac7afeea5a57b1e2bcb.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <7969018013a67ddbbf784ac7afeea5a57b1e2bcb.1563904656.git.andreyknvl@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>, linux-kselftest@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Dmitry Vyukov <dvyukov@google.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Alex
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 23, 2019 at 07:58:48PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pass
> tagged user pointers (with the top byte set to something else other than
> 0x00) as syscall arguments.
> 
> mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> only by done with untagged pointers.
> 
> Untag user pointers in this function.
> 
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to rdma-for next, please don't sent it via other trees :)

Thanks,
Jason
