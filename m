From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Sep 4 (amd/display/)
Date: Thu, 5 Sep 2019 07:54:28 -0700
Message-ID: <d29463cd-0497-41f2-a502-110b02c7abc8@infradead.org>
References: <20190904233443.3f73c46b@canb.auug.org.au>
 <6b70fdfd-1f18-1e55-2574-7be5997cfb2a@infradead.org>
 <752f74d6-f6ff-6013-25ad-a8fdce934d17@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <752f74d6-f6ff-6013-25ad-a8fdce934d17@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <hwentlan@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On 9/5/19 6:17 AM, Harry Wentland wrote:
> 
> 
> On 2019-09-04 4:58 p.m., Randy Dunlap wrote:
>> On 9/4/19 6:34 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> News: this will be the last linux-next I will release until Sept 30.
>>>
>>> Changes since 20190903:
>>>
>>
>> on x86_64:
>>
>> In file included from ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c:77:0:
>> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/../dml_inline_defs.h: In function ‘dml_min’:
>> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/../dml_inline_defs.h:34:1: error: SSE register return with SSE disabled
>>
> 
> Is that fixed by Stephen's fixup here?
> 
> https://lists.freedesktop.org/archives/dri-devel/2019-September/234292.html

That patch is already in linux-next, so No, it's not.

I am using:
> gcc --version
gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538]


-- 
~Randy
