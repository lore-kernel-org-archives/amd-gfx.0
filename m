From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
Date: Thu, 24 Aug 2017 21:30:12 +0000
Message-ID: <BN6PR1201MB0180502DC4720A3C33D642DB859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
References: <1503511940-645-1-git-send-email-kent.russell@amd.com>
 <1e64a642-411e-ea58-1639-390e4c3cd75d@vodafone.de>
 <BN6PR1201MB01801A32C06AE0DA6634F440859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <CADnq5_PD3s8HHPtr49ZJ3DXPVXgP5xyvFZj_YTzsGCi=cnOUKA@mail.gmail.com>
 <BN6PR1201MB018010027CA78E203F629BA7859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <DM5PR1201MB023503F29269CEC80DC7DAD8929A0@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <CADnq5_Piyp7mtHi+4GZ0pUw1kMNT68ZVyA6jp1TR4VhbCjWAOA@mail.gmail.com>
 <BN6PR1201MB01804846B5629D28766FDFA0859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>,
 <fa2dddb4-5ceb-87f3-6305-fb5f6e6e5c2d@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971824237=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fa2dddb4-5ceb-87f3-6305-fb5f6e6e5c2d-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1971824237==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB0180502DC4720A3C33D642DB859A0BN6PR1201MB0180_"

--_000_BN6PR1201MB0180502DC4720A3C33D642DB859A0BN6PR1201MB0180_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The plan is for the vbios version to be available through the ROCM-SMI util=
ity. We have the GPU power usage listed in the debugfs currently. If they a=
re both to be used for a userspace utility, should we be moving both of tho=
se to sysfs instead?

Kent

KENT RUSSELL
Software Engineer | Vertical Workstation/Compute
1 Commerce Valley Drive East
Markham, ON L3T 7X6
Canada
O +(1) 289-695-2122   | Ext x72122


________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Thursday, August 24, 2017 2:10:35 PM
To: Russell, Kent; Alex Deucher; Kuehling, Felix
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS

Actually the main difference is not root vs. user, but rather unstable
vs stable interface.

If you want a stable interface for an userspace tool you should use
sysfs, if you don't care about that you should use debugfs.

Christian.

Am 24.08.2017 um 18:37 schrieb Russell, Kent:
> We already access the GPU Power usage via debugfs, which is why I didn't =
think it was a huge deal to switch it over, since we already need root acce=
ss for the SMI due to that.
>
>   Kent
>
> -----Original Message-----
> From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Thursday, August 24, 2017 11:39 AM
> To: Kuehling, Felix
> Cc: Russell, Kent; Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
>
> On Thu, Aug 24, 2017 at 11:35 AM, Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org=
> wrote:
>> Debugfs is only accessible by Root. The BIOS version is already reported=
 in the kernel log, which is visible to everyone. So why hide this away in =
debugfs?
>>
>> I think Kent's intention is to add VBIOS version reporting to the rocm-s=
mi tool. I'd prefer using a stable interface like sysfs, and one that doesn=
't require root access in a tool like rocm-smi.
>>
> Ah, ok, sysfs is fine in that case.  I thought this was just general debu=
gging stuff.
>
> Alex
>
>> Regards,
>>    Felix
>> ________________________________________
>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
>> Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
>> Sent: Thursday, August 24, 2017 9:06:22 AM
>> To: Alex Deucher
>> Cc: Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: RE: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
>>
>> I can definitely add that as well.
>>
>>   Kent
>>
>> -----Original Message-----
>> From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> Sent: Thursday, August 24, 2017 8:56 AM
>> To: Russell, Kent
>> Cc: Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
>>
>> On Thu, Aug 24, 2017 at 5:58 AM, Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org> wr=
ote:
>>> No real reason for sysfs instead of debugfs, I just picked the one that=
 was more familiar with. I can definitely move it to debugfs instead. I wil=
l also clean up the commit message per Michel's comments. Thank you!
>>>
>> While you are at it, can you expose the vbios binary itself via debugfs?=
  That's been on by todo list for a while.
>>
>> Alex
>>
>>>   Kent
>>>
>>> -----Original Message-----
>>> From: Christian K=F6nig [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
>>> Sent: Thursday, August 24, 2017 2:22 AM
>>> To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
>>>
>>> Am 23.08.2017 um 20:12 schrieb Kent Russell:
>>>> This won't change after initialization, so we can add the
>>>> information when we parse the atombios information. This ensures
>>>> that we can find out the VBIOS, even when the dmesg buffer fills up,
>>>> and makes it easier to associate which VBIOS is for which GPU on
>>>> mGPU configurations. Set the size to 20 characters in case of some
>>>> weird VBIOS suffix that exceeds the expected 17 character format
>>>> (3-8-3\0)
>>> Is there any reason that needs to be sysfs? Sounds more like an use cas=
e for debugfs.
>>>
>>> Christian.
>>>
>>>> Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++++++++++=
++++
>>>>    drivers/gpu/drm/amd/amdgpu/atom.c          |  5 ++++-
>>>>    drivers/gpu/drm/amd/amdgpu/atom.h          |  1 +
>>>>    3 files changed, 28 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index a1f9424..f40be71 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -888,6 +888,20 @@ static uint32_t cail_ioreg_read(struct card_info =
*info, uint32_t reg)
>>>>        return r;
>>>>    }
>>>>
>>>> +static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
>>>> +                                              struct device_attribute=
 *attr,
>>>> +                                              char *buf) {
>>>> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
>>>> +     struct amdgpu_device *adev =3D ddev->dev_private;
>>>> +     struct atom_context *ctx =3D adev->mode_info.atom_context;
>>>> +
>>>> +     return snprintf(buf, PAGE_SIZE, "%s\n", ctx->vbios_version); }
>>>> +
>>>> +static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_ver=
sion,
>>>> +                NULL);
>>>> +
>>>>    /**
>>>>     * amdgpu_atombios_fini - free the driver info and callbacks for at=
ombios
>>>>     *
>>>> @@ -907,6 +921,7 @@ static void amdgpu_atombios_fini(struct amdgpu_dev=
ice *adev)
>>>>        adev->mode_info.atom_context =3D NULL;
>>>>        kfree(adev->mode_info.atom_card_info);
>>>>        adev->mode_info.atom_card_info =3D NULL;
>>>> +     device_remove_file(adev->dev, &dev_attr_vbios_version);
>>>>    }
>>>>
>>>>    /**
>>>> @@ -923,6 +938,7 @@ static int amdgpu_atombios_init(struct amdgpu_devi=
ce *adev)
>>>>    {
>>>>        struct card_info *atom_card_info =3D
>>>>            kzalloc(sizeof(struct card_info), GFP_KERNEL);
>>>> +     int ret;
>>>>
>>>>        if (!atom_card_info)
>>>>                return -ENOMEM;
>>>> @@ -959,6 +975,13 @@ static int amdgpu_atombios_init(struct amdgpu_dev=
ice *adev)
>>>>                amdgpu_atombios_scratch_regs_init(adev);
>>>>                amdgpu_atombios_allocate_fb_scratch(adev);
>>>>        }
>>>> +
>>>> +     ret =3D device_create_file(adev->dev, &dev_attr_vbios_version);
>>>> +     if (ret) {
>>>> +             DRM_ERROR("Failed to create device file for VBIOS versio=
n\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>>        return 0;
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
>>>> b/drivers/gpu/drm/amd/amdgpu/atom.c
>>>> index d69aa2e..69500a8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
>>>> @@ -1343,8 +1343,11 @@ struct atom_context *amdgpu_atom_parse(struct c=
ard_info *card, void *bios)
>>>>                idx =3D 0x80;
>>>>
>>>>        str =3D CSTR(idx);
>>>> -     if (*str !=3D '\0')
>>>> +     if (*str !=3D '\0') {
>>>>                pr_info("ATOM BIOS: %s\n", str);
>>>> +             strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_versi=
on));
>>>> +     }
>>>> +
>>>>
>>>>        return ctx;
>>>>    }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h
>>>> b/drivers/gpu/drm/amd/amdgpu/atom.h
>>>> index ddd8045..a391709 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
>>>> @@ -140,6 +140,7 @@ struct atom_context {
>>>>        int io_mode;
>>>>        uint32_t *scratch;
>>>>        int scratch_size_bytes;
>>>> +     char vbios_version[20];
>>>>    };
>>>>
>>>>    extern int amdgpu_atom_debug;
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_BN6PR1201MB0180502DC4720A3C33D642DB859A0BN6PR1201MB0180_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>The plan is for the vbios version to be available through the ROCM-SMI=
 utility. We have the GPU power usage listed in the debugfs currently. If t=
hey are both to be used for a userspace utility, should we be moving both o=
f those to sysfs instead?<br>
<br>
Kent<br>
<br>
KENT RUSSELL<br>
Software Engineer | Vertical Workstation/Compute<br>
1 Commerce Valley Drive East<br>
Markham, ON L3T 7X6<br>
Canada<br>
O &#43;(1) 289-695-2122&nbsp;&nbsp; | Ext x72122<br>
<br>
<br>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &=
lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 24, 2017 2:10:35 PM<br>
<b>To:</b> Russell, Kent; Alex Deucher; Kuehling, Felix<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Actually the main difference is not root vs. user,=
 but rather unstable
<br>
vs stable interface.<br>
<br>
If you want a stable interface for an userspace tool you should use <br>
sysfs, if you don't care about that you should use debugfs.<br>
<br>
Christian.<br>
<br>
Am 24.08.2017 um 18:37 schrieb Russell, Kent:<br>
&gt; We already access the GPU Power usage via debugfs, which is why I didn=
't think it was a huge deal to switch it over, since we already need root a=
ccess for the SMI due to that.<br>
&gt;<br>
&gt;&nbsp;&nbsp; Kent<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher [<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt; Sent: Thursday, August 24, 2017 11:39 AM<br>
&gt; To: Kuehling, Felix<br>
&gt; Cc: Russell, Kent; Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br=
>
&gt; Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS<br>
&gt;<br>
&gt; On Thu, Aug 24, 2017 at 11:35 AM, Kuehling, Felix &lt;Felix.Kuehling@a=
md.com&gt; wrote:<br>
&gt;&gt; Debugfs is only accessible by Root. The BIOS version is already re=
ported in the kernel log, which is visible to everyone. So why hide this aw=
ay in debugfs?<br>
&gt;&gt;<br>
&gt;&gt; I think Kent's intention is to add VBIOS version reporting to the =
rocm-smi tool. I'd prefer using a stable interface like sysfs, and one that=
 doesn't require root access in a tool like rocm-smi.<br>
&gt;&gt;<br>
&gt; Ah, ok, sysfs is fine in that case.&nbsp; I thought this was just gene=
ral debugging stuff.<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; Felix<br>
&gt;&gt; ________________________________________<br>
&gt;&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on beh=
alf of<br>
&gt;&gt; Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; Sent: Thursday, August 24, 2017 9:06:22 AM<br>
&gt;&gt; To: Alex Deucher<br>
&gt;&gt; Cc: Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; Subject: RE: [PATCH] drm/amdgpu: Add sysfs file for VBIOS<br>
&gt;&gt;<br>
&gt;&gt; I can definitely add that as well.<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; Kent<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Alex Deucher [<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailt=
o:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt;&gt; Sent: Thursday, August 24, 2017 8:56 AM<br>
&gt;&gt; To: Russell, Kent<br>
&gt;&gt; Cc: Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Aug 24, 2017 at 5:58 AM, Russell, Kent &lt;Kent.Russell@am=
d.com&gt; wrote:<br>
&gt;&gt;&gt; No real reason for sysfs instead of debugfs, I just picked the=
 one that was more familiar with. I can definitely move it to debugfs inste=
ad. I will also clean up the commit message per Michel's comments. Thank yo=
u!<br>
&gt;&gt;&gt;<br>
&gt;&gt; While you are at it, can you expose the vbios binary itself via de=
bugfs?&nbsp; That's been on by todo list for a while.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp; Kent<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt; From: Christian K=F6nig [<a href=3D"mailto:deathsimple@vodafon=
e.de">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]<br>
&gt;&gt;&gt; Sent: Thursday, August 24, 2017 2:22 AM<br>
&gt;&gt;&gt; To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 23.08.2017 um 20:12 schrieb Kent Russell:<br>
&gt;&gt;&gt;&gt; This won't change after initialization, so we can add the<=
br>
&gt;&gt;&gt;&gt; information when we parse the atombios information. This e=
nsures<br>
&gt;&gt;&gt;&gt; that we can find out the VBIOS, even when the dmesg buffer=
 fills up,<br>
&gt;&gt;&gt;&gt; and makes it easier to associate which VBIOS is for which =
GPU on<br>
&gt;&gt;&gt;&gt; mGPU configurations. Set the size to 20 characters in case=
 of some<br>
&gt;&gt;&gt;&gt; weird VBIOS suffix that exceeds the expected 17 character =
format<br>
&gt;&gt;&gt;&gt; (3-8-3\0)<br>
&gt;&gt;&gt; Is there any reason that needs to be sysfs? Sounds more like a=
n use case for debugfs.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Kent Russell &lt;kent.russell-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c | 23 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/atom.c&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 &#43;&#43;&#43;&#=
43;-<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/atom.h&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 3 files changed, 28 insertions(&#43;), 1=
 deletion(-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br=
>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt;&gt; index a1f9424..f40be71 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c<br>
&gt;&gt;&gt;&gt; @@ -888,6 &#43;888,20 @@ static uint32_t cail_ioreg_read(s=
truct card_info *info, uint32_t reg)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &#43;static ssize_t amdgpu_atombios_get_vbios_version(stru=
ct device *dev,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
device_attribute *attr,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *b=
uf) {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D =
dev_get_drvdata(dev);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ddev-&gt;dev_private;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *ctx =3D=
 adev-&gt;mode_info.atom_context;<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SI=
ZE, &quot;%s\n&quot;, ctx-&gt;vbios_version); }<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombi=
os_get_vbios_version,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_atombios_fini - free the =
driver info and callbacks for atombios<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt; @@ -907,6 &#43;921,7 @@ static void amdgpu_atombios_fini(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_in=
fo.atom_context =3D NULL;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;m=
ode_info.atom_card_info);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_in=
fo.atom_card_info =3D NULL;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;=
dev, &amp;dev_attr_vbios_version);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt; @@ -923,6 &#43;938,7 @@ static int amdgpu_atombios_init(st=
ruct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct card_info=
 *atom_card_info =3D<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; kzalloc(sizeof(struct card_info), GFP_KERNEL);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!atom_card_i=
nfo)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&gt;&gt;&gt; @@ -959,6 &#43;975,13 @@ static int amdgpu_atombios_init(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_init(adev);<br=
>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_allocate_fb_scratch(adev);<=
br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(a=
dev-&gt;dev, &amp;dev_attr_vbios_version);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to create device file for VBIOS =
version\n&quot;);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt;&gt;&gt;&gt; index d69aa2e..69500a8 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt;&gt;&gt;&gt; @@ -1343,8 &#43;1343,11 @@ struct atom_context *amdgpu_ato=
m_parse(struct card_info *card, void *bios)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx =3D 0x80;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str =3D CSTR(idx=
);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (*str !=3D '\0')<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (*str !=3D '\0') {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;ATOM BIOS: %s\n&quot;, str);<=
br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; strlcpy(ctx-&gt;vbios_version, str, sizeof(ctx-&gt;vbio=
s_version));<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ctx;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt;&gt;&gt;&gt; index ddd8045..a391709 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt;&gt;&gt;&gt; @@ -140,6 &#43;140,7 @@ struct atom_context {<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int io_mode;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *scratc=
h;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int scratch_size=
_bytes;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; char vbios_version[20];<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; extern int amdgpu_atom_debug;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_BN6PR1201MB0180502DC4720A3C33D642DB859A0BN6PR1201MB0180_--

--===============1971824237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1971824237==--
