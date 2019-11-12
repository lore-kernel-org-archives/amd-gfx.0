From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/2] drm: replace incorrect Compliance/Margin magic
 numbers with PCI_EXP_LNKCTL2 definitions
Date: Tue, 12 Nov 2019 17:45:15 +0100
Message-ID: <6d86246e-504a-b762-aff8-0449dd6f3d31@daenzer.net>
References: <20191111192932.36048-1-helgaas@kernel.org>
 <20191111192932.36048-2-helgaas@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111192932.36048-2-helgaas@kernel.org>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Frederick Lawler <fred@fredlawl.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: amd-gfx.lists.freedesktop.org

On 2019-11-11 8:29 p.m., Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add definitions for these PCIe Link Control 2 register fields:
> 
>   Enter Compliance
>   Transmit Margin
> 
> and use them in amdgpu and radeon.
> 
> NOTE: This is a functional change because "7 << 9" was apparently a typo.
> That mask included the high order bit of Transmit Margin, the Enter
> Modified Compliance bit, and the Compliance SOS bit, but I think what
> was intended was the 3-bit Transmit Margin field at bits 9:7.

Can you split out the functional change into a separate patch 1? That
could make things easier for anyone who bisects the functional change
for whatever reason.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
