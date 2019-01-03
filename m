From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu_vm: fix boolean expressions
Date: Thu, 3 Jan 2019 13:52:33 -0600
Message-ID: <84e1befb-3cce-f85a-2b90-71f42c445eda@embeddedor.com>
References: <20190103173418.GA18739@embeddedor>
 <08f2d5c0-0e97-f44e-c07d-6a8cdfd277bb@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <08f2d5c0-0e97-f44e-c07d-6a8cdfd277bb@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 1/3/19 1:17 PM, Kuehling, Felix wrote:
> On 2019-01-03 12:34 p.m., Gustavo A. R. Silva wrote:
>> Fix boolean expressions by using logical AND operator '&&'
>> instead of bitwise operator '&'.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Fixes: c8c5e569c5b0 ("drm/amdgpu: Consolidate visible vs. real vram check v2.")
> Actually, this bug goes back further, to 9a4b7d4c769e ("drm/amdgpu: Add
> vm context module param").
> 

You're right. I'll fix that and send v2 shortly. I'll add your RB.

> Anyway, the patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 

Thanks
--
Gustavo
