From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Date: Fri, 19 Oct 2018 10:56:13 +0200
Message-ID: <CAKMK7uHg-o6CUREz+egJVPwAeHB_rF229vKkqFENxAZRjdGcZg@mail.gmail.com>
References: <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com> <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com> <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com> <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <c6880c5b-e259-4923-8d5a-80c620563398@amd.com> <20181008174628.GB11442@roeck-us.net>
 <4a1faa3b-8c42-b742-9b55-9d2711f7ecc1@amd.com> <20181019085308.GY31561@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019085308.GY31561@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, Guenter Roeck <linux@roeck-us.net>, Peng Hao <peng.hao2@zte.com.cn>, Dave Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <Alexander.Deucher@amd.com>, "Peres, Martin" <martin.peres@linux.intel.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Oct 19, 2018 at 10:53 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Oct 08, 2018 at 06:13:56PM +0000, Koenig, Christian wrote:
> > Am 08.10.2018 um 19:46 schrieb Guenter Roeck:
> > > On Mon, Oct 08, 2018 at 05:22:24PM +0000, Koenig, Christian wrote:
> > >> Am 08.10.2018 um 17:57 schrieb Deucher, Alexander:
> > >>>>>> One thing I found missing in the discussion was the reference to the
> > >>>>>> C standard.
> > >>>>>> The C99 standard states in section 6.7.8 (Initialization) clause 19:
> > >>>>>> "... all
> > >>>>>> subobjects that are not initialized explicitly shall be initialized
> > >>>>>> implicitly the same as objects that have static storage duration".
> > >>>>>> Clause 21 makes further reference to partial initialization,
> > >>>>>> suggesting the same. Various online resources, including the gcc
> > >>>>>> documentation, all state the same. I don't find any reference to a
> > >>>>>> partial initialization which would leave members of a structure
> > >>>>>> undefined. It would be interesting for me to understand how and why
> > >>>>>> this does not apply here.
> > >>>>>>
> > >>>>>> In this context, it is interesting that the other 48 instances of the
> > >>>>>> { { 0 } } initialization in the same driver don't raise similar
> > >>>>>> concerns, nor seemed to have caused any operational problems.
> > >>>>> Feel free to provide patches to replace those with memset().
> > >>>>>
> > >>>> Not me. As I see it, the problem, if it exists, would be a violation of the C
> > >>>> standard. I don't believe hacking around bad C compilers. I would rather
> > >>>> blacklist such compilers.
> > >> Well then you would need to blacklist basically all gcc variants of the
> > >> last decade or so.
> > >>
> > >> Initializing only known members of structures is a perfectly valid
> > >> optimization and well known issue when you then compare the structure
> > >> with memcpy() or use the bytes for hashing or something similar.
> > >>
> > > Isn't that about padding ? That is a completely different issue.
> >
> > Correct, yes. But that is the reason why I recommend using memset() for
> > zero initialization.
> >
> > See we don't know the inner layout of the structure, could be another
> > structure or an union.
> >
> > If it's a structure everything is fine because if you initialize one
> > structure member all other get their default type (whatever that means),
> > but if it's an union.....
> >
> > Not sure if compilers still react allergic to that, but its the status
> > I've learned the hard way when the C99 standard came out and it still
> > seems like people are working around that so I recommend everybody to
> > stick with memset().
>
> Went boom:
>
> https://bugs.freedesktop.org/show_bug.cgi?id=108490
>
> Can we revert?
>
> Also, can we properly igt this so that intel-gfx-ci could test this before
> it's all fireworks?

Please disregard this reply, that was the wrong thread.

Sorry, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
