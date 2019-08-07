From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: replace readq/writeq with atomic64 operations
Date: Wed, 7 Aug 2019 10:55:01 +0000
Message-ID: <18cd9fa5-2d87-2f41-b5fa-927b9790287d@amd.com>
References: <20190807025640.682-1-tao.zhou1@amd.com>
 <20190807070834.GA24792@infradead.org>
 <daff9fc7-ead8-40e0-9a16-cb3b90b01722@amd.com>
 <20190807104104.GA18773@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190807104104.GA18773@infradead.org>
Content-Language: en-US
Content-ID: <38B2E3E82706954B8BB64564CFF144C3@namprd12.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel-build-reports@lists.linaro.org" <kernel-build-reports@lists.linaro.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Am 07.08.19 um 12:41 schrieb Christoph Hellwig:
> On Wed, Aug 07, 2019 at 08:53:25AM +0000, Koenig, Christian wrote:
>> Am 07.08.19 um 09:08 schrieb Christoph Hellwig:
>>> On Wed, Aug 07, 2019 at 10:56:40AM +0800, Tao Zhou wrote:
>>>> readq/writeq are not supported on all architectures
>>> NAK.  You must not use atomic_* on __iomem (MMIO) memory.
>> Well then what's the right thing to do here?
>>
>> Essentially writeq/readq doesn't seems to be available on all
>> architectures either.
> writeq/readq are provided whenever the CPU actually supports 64-bit
> atomic loads and stores.

Is there a config option which we can make the driver depend on?

I mean that ARM doesn't support 64bit atomic loads and stores on MMIO is 
quite a boomer for us.

Toa do you of hand know what we actually need the 64bit atomic stores 
for? E.g. what is the hardware background?

Regards,
Christian.

> If it doesn't provide them atomic64* is
> not going to be atomic vs the I/O device either.  And that is on top
> of the fact that for various architectures you can't simply use
> plain loads and stores on MMIO memory to start with, which is why
> we have the special accessors and the __iomem annotation.
