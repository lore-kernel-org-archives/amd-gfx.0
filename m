From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
Date: Tue, 21 May 2019 07:57:36 -0500
Message-ID: <5a9089f3-501b-24a1-202b-5a2b2ae62de6@embeddedor.com>
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
 <SN6PR12MB2800A7AEC22121C8704CBB09870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190520162807.GE21222@phenom.ffwll.local>
 <SN6PR12MB28007ED8F5C6838F2C25A9D587060@SN6PR12MB2800.namprd12.prod.outlook.com>
 <CADnq5_O=PAK3qZJ-kHUX9jQDkmEYOX+iOhOX7gNaaXp+tC7nUg@mail.gmail.com>
 <CAKMK7uHS837L9Ze_K5q-AsFgOtAMD+n_i_Y404BX-_CwJeP08Q@mail.gmail.com>
 <36de7e05-9055-6d8b-fb2c-fa5a4e94274b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36de7e05-9055-6d8b-fb2c-fa5a4e94274b@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: christian.koenig@amd.com, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
List-Id: amd-gfx.lists.freedesktop.org



On 5/21/19 3:59 AM, Christian König wrote:

> BTW: Is there actually good documentation how to correctly do the variable length array at end of structure thing in the kernel?
> 
> I do know that I've seen a lot of different variants like array[] array[0] or array[1] and I have also seen a bunch of gcc versions failing to generate correct
> code for some of them.
> 
> So we should probably nail down how to do things correctly.
> 

A flexible array member is the preferred[1] mechanism:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190520&id=76497732932f15e7323dc805e8ea8dc11bb587cf

Thanks
--
Gustavo

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
