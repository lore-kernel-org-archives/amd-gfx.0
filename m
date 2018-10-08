From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Date: Mon, 8 Oct 2018 10:41:02 -0700
Message-ID: <20181008174102.GA11442@roeck-us.net>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, Peng Hao <peng.hao2@zte.com.cn>, "airlied@linux.ie" <airlied@linux.ie>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Oct 08, 2018 at 03:57:07PM +0000, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Monday, October 8, 2018 10:11 AM
> > To: Koenig, Christian <Christian.Koenig@amd.com>; Peng Hao
> > <peng.hao2@zte.com.cn>
> > Cc: airlied@linux.ie; linux-kernel@vger.kernel.org; dri-
> > devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; Deucher,
> > Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
> > 
> > On 10/08/2018 06:47 AM, Koenig, Christian wrote:
> > > Am 08.10.2018 um 15:33 schrieb Guenter Roeck:
> > >> On 10/08/2018 01:00 AM, Christian König wrote:
> > >>> Am 05.10.2018 um 10:38 schrieb Guenter Roeck:
> > >>>> On 10/05/2018 01:14 AM, Koenig, Christian wrote:
> > >>>>> Am 04.10.2018 um 20:52 schrieb Guenter Roeck:
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> On Fri, Sep 14, 2018 at 06:05:52PM +0800, Peng Hao wrote:
> > >>>>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
> > >>>>>>>        In function ‘gmc_v8_0_process_interrupt’:
> > >>>>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
> > >>>>>>>        warning: missing braces around initializer
> > >>>>>>> [-Wmissing-braces]
> > >>>>>>>
> > >>>>>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > >>>>>> Was there any feedback on this patch ? The problem does affect
> > >>>>>> us, and we'll need a fix.
> > >>>>>
> > >>>>> Well as discussed using "{ { 0 } }" is as wrong as using "{ 0 }".
> > >>>>>
> > >>>>
> > >>>> Ah, sorry, I must have missed the discussion.
> > >>>>
> > >>>> It is for sure not the best solution, but at least it compiles, and
> > >>>> it seems to be proliferating.
> > >>>
> > >>> Yeah, and exactly that's the problem. As the discussion showed "{ {
> > >>> 0 } }" is buggy because it tells the compiler to only initialize the
> > >>> first member of the structure, but not all of it.
> > >>>
> > >>> That is incorrect and rather dangerous cause it can lead to
> > >>> unforeseen results and should probably trigger a warning.
> > >>>
> > >>>>
> > >>>> $ git grep "{ *{ *0 *} *}" | wc
> > >>>>      144    1180   11802
> > >>>> $ git grep "{ *{ *0 *} *}" drivers/gpu/drm/amd/ | wc
> > >>>>       50     459    5239
> > >>>>
> > >>>>> We should either use only "{ }" or even better make nails with
> > >>>>> heads and use memset().
> > >>>>
> > >>>> I'd rather leave it up to the compiler to decide what is most
> > >>>> efficient.
> > >>>
> > >>> And I would rather prefer to have a working driver :)
> > >>>
> > >>
> > >> So { } isn't correct either ?
> > >
> > > Yes, initializing structures with { } is known to be problematic as well.
> > >
> > > It doesn't necessary initialize all bytes when you have padding
> > > causing random failures when structures are memcmp().
> > >
> > >>
> > >> One thing I found missing in the discussion was the reference to the
> > >> C standard.
> > >> The C99 standard states in section 6.7.8 (Initialization) clause 19:
> > >> "... all
> > >> subobjects that are not initialized explicitly shall be initialized
> > >> implicitly the same as objects that have static storage duration".
> > >> Clause 21 makes further reference to partial initialization,
> > >> suggesting the same. Various online resources, including the gcc
> > >> documentation, all state the same. I don't find any reference to a
> > >> partial initialization which would leave members of a structure
> > >> undefined. It would be interesting for me to understand how and why
> > >> this does not apply here.
> > >>
> > >> In this context, it is interesting that the other 48 instances of the
> > >> { { 0 } } initialization in the same driver don't raise similar
> > >> concerns, nor seemed to have caused any operational problems.
> > >
> > > Feel free to provide patches to replace those with memset().
> > >
> > 
> > Not me. As I see it, the problem, if it exists, would be a violation of the C
> > standard. I don't believe hacking around bad C compilers. I would rather
> > blacklist such compilers.
> > 
> > >>
> > >> Anyway, I fixed up the code in our tree (with { }), so I'll leave it
> > >> up to you folks to decide what if anything to do about it.
> > >
> > > Well considering the known problems with {} initialization I'm
> > > certainly rejecting all patches which turns memset() into {}.
> > >
> > 
> > Please point me to specific instances of this problem.
> 
> I think there are a number of places in DC (drivers/gpu/drm/amd/display) where we applied the original proposed solution before realizing that it would only initialize the first element.  It would be nice to get them fixed up.
> 

I think this is factually incorrect. What you might want to try to say
is that padding may not be initialized when using anything but memset().
But that is a different problem.

Guenter
