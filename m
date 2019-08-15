From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Apply flags after amdgpu_device_ip_init()
Date: Thu, 15 Aug 2019 11:28:01 -0400
Message-ID: <CADnq5_MqvH-jUdDUOeBM6zgwYKiv21Wuejw4sR5TwY7bJss_ow@mail.gmail.com>
References: <20190815051117.24003-1-kai.heng.feng@canonical.com>
 <BN6PR12MB180950AE744B37AAFADC2FEAF7AC0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <8D8229FF-933A-43CF-AE05-52E969E3B942@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8D8229FF-933A-43CF-AE05-52E969E3B942@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "anthony.wong@canonical.com" <anthony.wong@canonical.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 15, 2019 at 10:59 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 21:33, Deucher, Alexander <Alexander.Deucher@amd.com> wrote:
>
> > Thanks for finding this!  I think the attached patch should fix the iss=
ue
> > and it's much less invasive.
>
> Yes it also fix the issue, please add by tested-by:
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>

Thanks!

> I took this more or less future proof approach because I think this won=
=E2=80=99t
> be the last chip that needs firmware information, which isn=E2=80=99t ava=
ilable in
> early init, to decides its flags.
>
> Yes it=E2=80=99s intrusive to carve out all flags from early init callbac=
ks, but I
> don=E2=80=99t think it=E2=80=99s that ugly.

Not a bad approach, but I'd prefer to keep the power and clock gating
flags in the asic specifc code rather than in the common code.

Alex
