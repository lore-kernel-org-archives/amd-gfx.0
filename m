From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] drm/amdgpu: replace readq/writeq with atomic64 operations
Date: Wed, 7 Aug 2019 06:00:43 -0700
Message-ID: <20190807130043.GA6023@infradead.org>
References: <20190807025640.682-1-tao.zhou1@amd.com>
 <20190807070834.GA24792@infradead.org>
 <daff9fc7-ead8-40e0-9a16-cb3b90b01722@amd.com>
 <20190807104104.GA18773@infradead.org>
 <18cd9fa5-2d87-2f41-b5fa-927b9790287d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <18cd9fa5-2d87-2f41-b5fa-927b9790287d@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel-build-reports@lists.linaro.org" <kernel-build-reports@lists.linaro.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Aug 07, 2019 at 10:55:01AM +0000, Koenig, Christian wrote:
> >> Essentially writeq/readq doesn't seems to be available on all
> >> architectures either.
> > writeq/readq are provided whenever the CPU actually supports 64-bit
> > atomic loads and stores.
> 
> Is there a config option which we can make the driver depend on?
> 
> I mean that ARM doesn't support 64bit atomic loads and stores on MMIO is 
> quite a boomer for us.

The model is to cheack if readq/writeq are defined, and if not to
include the one of io-64-nonatomic-hi-lo.h or io-64-nonatomic-lo-hi.h.
The reason for that is that hardware is supposed to be able to deal with
two 32-bit writes, but it depends on the hardware if the lower or upper
half is what commits the write.

The only 32-bit platform that claims support for readq/writeq is sh,
and I have doubts if that actually works as expected.
