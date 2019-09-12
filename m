From: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 2/4] mm/hmm: allow snapshot of the special zero page
Date: Thu, 12 Sep 2019 10:08:28 -0700
Message-ID: <6b124c6d-0fac-2a34-0542-7516de939b9e@nvidia.com>
References: <20190911222829.28874-1-rcampbell@nvidia.com>
 <20190911222829.28874-3-rcampbell@nvidia.com> <20190912082648.GB14368@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190912082648.GB14368@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: amd-gfx.lists.freedesktop.org


On 9/12/19 1:26 AM, Christoph Hellwig wrote:
> On Wed, Sep 11, 2019 at 03:28:27PM -0700, Ralph Campbell wrote:
>> Allow hmm_range_fault() to return success (0) when the CPU pagetable
>> entry points to the special shared zero page.
>> The caller can then handle the zero page by possibly clearing device
>> private memory instead of DMAing a zero page.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> ---
>>   mm/hmm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index 06041d4399ff..7217912bef13 100644
>> --- a/mm/hmm.c
>> +++ b/mm/hmm.c
>> @@ -532,7 +532,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, =
unsigned long addr,
>>   			return -EBUSY;
>>   	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte=
)) {
>>   		*pfn =3D range->values[HMM_PFN_SPECIAL];
>> -		return -EFAULT;
>> +		return is_zero_pfn(pte_pfn(pte)) ? 0 : -EFAULT;
>=20
> Any chance to just use a normal if here:
>=20
> 		if (!is_zero_pfn(pte_pfn(pte)))
> 			return -EFAULT;
> 		return 0;
>=20

Sure, no problem.
