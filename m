From: Christoph Hellwig <hch@lst.de>
Subject: fix radeon and amdgpu for addressing limited root ports
Date: Thu, 15 Aug 2019 09:26:59 +0200
Message-ID: <20190815072703.7010-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi AMD graphics maintainers,

this series fixes a problem in the radeon driver for systems where the
PCIe root port only supports limited (32-bit) addressing as reported
by Atish.  I then also fixed the same issue in amdgpu as the code was
copy and pasted there, and cleaned up the dma mask setting while
touching that area.
