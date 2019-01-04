From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] drm/amdgpu_vm: fix boolean expressions
Date: Fri, 4 Jan 2019 10:58:28 -0600
Message-ID: <040f2122-cd83-effb-3f1e-2c5755aece2a@embeddedor.com>
References: <20190103200146.GA26442@embeddedor>
 <CAAEAJfA_1tLk0nk-WOtwdpF3W70keyaT=YPQHzXo5+nvWiZR=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAEAJfA_1tLk0nk-WOtwdpF3W70keyaT=YPQHzXo5+nvWiZR=A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hi Ezequiel,

On 1/4/19 10:40 AM, Ezequiel Garcia wrote:
> Hey Gustavo,
> 
> On Thu, 3 Jan 2019 at 17:25, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>>
>> Fix boolean expressions by using logical AND operator '&&'
>> instead of bitwise operator '&'.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Fixes: 9a4b7d4c769e ("drm/amdgpu: Add vm context module param")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>   - Update Fixes tag.
>>
> 
> This just fixes a user warning that would be wrongly reported, but
> doesn't fix any other issue.
> 
> Why stable?
> 

Yeah. In this case the tag can be removed.

Happy new year.

Thanks
--
Gustavo
