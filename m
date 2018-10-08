From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Date: Mon, 8 Oct 2018 10:46:28 -0700
Message-ID: <20181008174628.GB11442@roeck-us.net>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <c6880c5b-e259-4923-8d5a-80c620563398@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c6880c5b-e259-4923-8d5a-80c620563398@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Peng Hao <peng.hao2@zte.com.cn>, "airlied@linux.ie" <airlied@linux.ie>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Oct 08, 2018 at 05:22:24PM +0000, Koenig, Christian wrote:
> Am 08.10.2018 um 17:57 schrieb Deucher, Alexander:
> >>>> One thing I found missing in the discussion was the reference to the
> >>>> C standard.
> >>>> The C99 standard states in section 6.7.8 (Initialization) clause 19:
> >>>> "... all
> >>>> subobjects that are not initialized explicitly shall be initialized
> >>>> implicitly the same as objects that have static storage duration".
> >>>> Clause 21 makes further reference to partial initialization,
> >>>> suggesting the same. Various online resources, including the gcc
> >>>> documentation, all state the same. I don't find any reference to a
> >>>> partial initialization which would leave members of a structure
> >>>> undefined. It would be interesting for me to understand how and why
> >>>> this does not apply here.
> >>>>
> >>>> In this context, it is interesting that the other 48 instances of the
> >>>> { { 0 } } initialization in the same driver don't raise similar
> >>>> concerns, nor seemed to have caused any operational problems.
> >>> Feel free to provide patches to replace those with memset().
> >>>
> >> Not me. As I see it, the problem, if it exists, would be a violation of the C
> >> standard. I don't believe hacking around bad C compilers. I would rather
> >> blacklist such compilers.
> 
> Well then you would need to blacklist basically all gcc variants of the 
> last decade or so.
> 
> Initializing only known members of structures is a perfectly valid 
> optimization and well known issue when you then compare the structure 
> with memcpy() or use the bytes for hashing or something similar.
> 

Isn't that about padding ? That is a completely different issue.

Guenter
