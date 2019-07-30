From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 03/13] nouveau: pass struct nouveau_svmm to
 nouveau_range_fault
Date: Tue, 30 Jul 2019 12:35:59 +0000
Message-ID: <20190730123554.GD24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-4-hch@lst.de>
Content-Language: en-US
Content-ID: <673CF3972C47014CA0CAB676E69F0322@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 30, 2019 at 08:51:53AM +0300, Christoph Hellwig wrote:
> This avoid having to abuse the vma field in struct hmm_range to unlock
> the mmap_sem.

I think the change inside hmm_range_fault got lost on rebase, it is
now using:

                up_read(&range->hmm->mm->mmap_sem);

But, yes, lets change it to use svmm->mm and try to keep struct hmm
opaque to drivers

Jason
