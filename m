From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH ARM] selftests, arm64: fix uninitialized symbol in
 tags_test.c
Date: Mon, 19 Aug 2019 16:03:43 +0100
Message-ID: <20190819150342.sxk3zzxvrxhkpp6j@willie-the-truck>
References: <00eb8ba84205c59cac01b1b47615116a461c302c.1566220355.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00eb8ba84205c59cac01b1b47615116a461c302c.1566220355.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Martin <Dave.Martin@arm.com>, E
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Aug 19, 2019 at 03:14:42PM +0200, Andrey Konovalov wrote:
> Fix tagged_ptr not being initialized when TBI is not enabled.
> 
> Dan Carpenter <dan.carpenter@oracle.com>

Guessing this was Reported-by, or has Dan introduced his own tag now? ;)

Got a link to the report?

Will
