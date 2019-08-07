From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] drm/amdgpu: replace readq/writeq with atomic64 operations
Date: Wed, 7 Aug 2019 00:08:34 -0700
Message-ID: <20190807070834.GA24792@infradead.org>
References: <20190807025640.682-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190807025640.682-1-tao.zhou1@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tao Zhou <tao.zhou1@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org, amd-gfx@lists.freedesktop.org, broonie@kernel.org, linux-next@vger.kernel.org, alexander.deucher@amd.com, akpm@linux-foundation.org, christian.koenig@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Aug 07, 2019 at 10:56:40AM +0800, Tao Zhou wrote:
> readq/writeq are not supported on all architectures

NAK.  You must not use atomic_* on __iomem (MMIO) memory.
