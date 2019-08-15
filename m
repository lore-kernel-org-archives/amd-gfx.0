From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] drm/radeon: handle PCIe root ports with addressing
 limitations
Date: Thu, 15 Aug 2019 12:06:10 +0200
Message-ID: <20190815100610.GA28728@lst.de>
References: <20190815072703.7010-1-hch@lst.de> <20190815072703.7010-2-hch@lst.de> <d1cf1435-92e3-edb5-c239-18c71f2d27c7@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d1cf1435-92e3-edb5-c239-18c71f2d27c7@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 15, 2019 at 08:34:10AM +0000, Koenig, Christian wrote:
> Looks sane to me. Reviewed-by: Christian König <christian.koenig@amd.com>.
> 
> Should we merge this through our normal amdgpu/radeon branches or do you 
> want to send this upstream somehow else?

This is intended for your trees.
