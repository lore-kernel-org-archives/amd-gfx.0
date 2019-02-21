From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable bulk moves for now
Date: Thu, 21 Feb 2019 09:11:04 +0100
Message-ID: <023b3804-30d8-ac8b-c221-ff91e5146260@gmail.com>
References: <20190220141606.8832-1-christian.koenig@amd.com>
 <20190221030938.GY10616@sasha-vm>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190221030938.GY10616@sasha-vm>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Am 21.02.19 um 04:09 schrieb Sasha Levin:
> On Wed, Feb 20, 2019 at 03:16:06PM +0100, Christian König wrote:
>> The changes to fix those are two invasive for backporting.
>>
>> Just disable the feature in 4.20 and 5.0.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Cc: <stable@vger.kernel.org>    [4.20+]
>
> For the sake of having it in the log, could you point to the upstream
> commit(s) that fix it?

That turned out to be a larger set of patches and won't go upstream 
before the 5.1 cycle.

Christian.

>
> -- 
> Thanks,
> Sasha
