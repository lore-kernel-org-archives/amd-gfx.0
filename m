From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [repost] drm sync objects cleaned up
Date: Tue, 18 Apr 2017 14:55:16 -0700
Message-ID: <CAOFGe951+G9FGeEKgUpOnv6WMVTkCq7BTz10Z-8gH5KZ4jVahg@mail.gmail.com>
References: <20170411032220.21101-1-airlied@gmail.com>
 <20170414094520.GB12532@nuc-i3427.alporthouse.com>
 <CAPM=9twmJPkzEL7sFOSAURAVKd7yhKn3dEk=C=vJMQT11sAQQA@mail.gmail.com>
 <20170418203037.GB9029@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1977994366=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170418203037.GB9029-aII6DKEyn0pWYbfKqPwjAkR8Iwp7RQ6xAL8bYrjMMd8@public.gmane.org>
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
To: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1977994366==
Content-Type: multipart/alternative; boundary=001a114b446e93a14b054d77f6c3

--001a114b446e93a14b054d77f6c3
Content-Type: text/plain; charset=UTF-8

A few thoughts (from the anv perspective) that I put on IRC but may be
better in a mail.  In no particular order:

 1. Having the fd exported from a syncobj be a valid sync_file seems like a
fairly pointless feature to me.  If we can make things more sane by
throwing that out, I'm all for it.

 2. As far as sync_file interactions go, I think the far more useful thing
would be for you to be able to export a sync_file from a syncobj which
would create a sync_file that waits on the last submitted signal operation
on the syncobj and then have a way of creating a temporary syncobj that has
the fence from a sync_file.  Not sure how this would interact with future
fences.  If we can't figure it out, let's just forget it and not have any
defined interaction.

 3. I'd like to also be able to use syncobj for implementing VkFence
sharing.  Really, all this means is a drm_syncobj_wait ioctl.  Yes, with
the current sync_file stuff, you could turn it into a sync_file and poll
but I'd rather not burn the file descriptors.

 4. It would be a neat trick if drm_syncobj_wait could take a list of
syncobjs and wait on one or all of them as requested by the user.  That
said, this would be an optimization at best and I'm fine with waiting on
them one at a time.

 5. I'd like to better define what happens when someone tries to wait
twice.  I'm a big fan of the semantics of dma-buf dependencies: Each wait
operation waits on the most recently queued signal operation.  That seems
better to me than waiting causing an implicit reset and waiting twice being
invalid.  Among other things, it means that we don't have to worry bout the
semantics of exactly how execbuf fails if you ask it to wait on the same
sync file twice.  That said, it can be anything we want, I just want it to
be well-defined.

--Jason


On Tue, Apr 18, 2017 at 1:30 PM, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
wrote:

> On Wed, Apr 19, 2017 at 05:34:52AM +1000, Dave Airlie wrote:
> > On 14 April 2017 at 19:45, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
> wrote:
> > > On Tue, Apr 11, 2017 at 01:22:12PM +1000, Dave Airlie wrote:
> > >> This set of sync object patches should address most of the issues
> > >> raised in review.
> > >>
> > >> The major changes:
> > >> Race on destroy should be gone,
> > >> Documentation fixups
> > >> amdgpu internal use p instead of adev fixups
> > >>
> > >> My plans are to write some igt tests this week, and try
> > >> to get some more review on what the API should allow (should
> > >> I lock it down to drm syncobj is just semaphores for now).
> > >
> > > Having an idr of handles is much, much nicer than fd and I want the
> same
> > > for fences :)
> >
> > Okay, but what form do you want the API to take for fences?
> >
> > because I've just ported all this to using sem_file as the backend,
> instead
> > of sync_file which seems to oppose the goal of using it for fences.
> >
> > For fences do you want upfront creation, then passing created fences
> object
> > into command submission that attach the internal fence?
>
> Yes. My understanding is that fences differ from semaphores by allowing
> use prior to execution. And that userspace (Vk) wants to be able to
> create a fence, pass it to a listener (maybe different process) and then
> attach it to an out-fence from a CS.
>
> I looked at using a shared idr for fences/semaphores and the issue I hit
> first was having to create a proxy dma-fence to initialise the syncobj
> with, so that I could attach listeners before I was able to hook the
> fence upto an execbuf.
>
> > Or do you want command submission to have out fence handles that it
> creates,
> > so we don't have any explicit syncobj create for fences?
> >
> > Do you want those fences to be shareable across processes using sync_file
> > semantics?
>
> Yes. In the same vein as the semaphore syncobjs, an idr for cheap
> creation/reuse within a process and export/import via sync_file fds.
> Where these fd differ from sema is that they do support host CPU access
> (these will work just like regular sync_files in that regard).
>
> > I kinda feel like I'm going around in circles here and I'm going to just
> merge
> > something instead.
>
> Sure. It was just from the perspective of extending the i915 execbuffer2
> that adding an array for semaphore in/out could be neatly generalised to
> cover fences as well (and that the api for syncobj is a substantial
> improvement over sync_merge and passing one fence in/out).
> -Chris
>
> --
> Chris Wilson, Intel Open Source Technology Centre
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--001a114b446e93a14b054d77f6c3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>A few thoughts (from the anv pers=
pective) that I put on IRC but may be better in a mail.=C2=A0 In no particu=
lar order:<br><br></div>=C2=A01. Having the fd exported from a syncobj be a=
 valid sync_file seems like a fairly pointless feature to me.=C2=A0 If we c=
an make things more sane by throwing that out, I&#39;m all for it.<br><br><=
/div><div>=C2=A02. As far as sync_file interactions go, I think the far mor=
e useful thing would be for you to be able to export a sync_file from a syn=
cobj which would create a sync_file that waits on the last submitted signal=
 operation on the syncobj and then have a way of creating a temporary synco=
bj that has the fence from a sync_file.=C2=A0 Not sure how this would inter=
act with future fences.=C2=A0 If we can&#39;t figure it out, let&#39;s just=
 forget it and not have any defined interaction.<br></div><div><br></div>=
=C2=A03. I&#39;d like to also be able to use syncobj for implementing VkFen=
ce sharing.=C2=A0 Really, all this means is a drm_syncobj_wait ioctl.=C2=A0=
 Yes, with the current sync_file stuff, you could turn it into a sync_file =
and poll but I&#39;d rather not burn the file descriptors.<br><br></div>=C2=
=A04. It would be a neat trick if drm_syncobj_wait could take a list of syn=
cobjs and wait on one or all of them as requested by the user.=C2=A0 That s=
aid, this would be an optimization at best and I&#39;m fine with waiting on=
 them one at a time.<br><br></div>=C2=A05. I&#39;d like to better define wh=
at happens when someone tries to wait twice.=C2=A0 I&#39;m a big fan of the=
 semantics of dma-buf dependencies: Each wait operation waits on the most r=
ecently queued signal operation.=C2=A0 That seems better to me than waiting=
 causing an implicit reset and waiting twice being invalid.=C2=A0 Among oth=
er things, it means that we don&#39;t have to worry bout the semantics of e=
xactly how execbuf fails if you ask it to wait on the same sync file twice.=
=C2=A0 That said, it can be anything we want, I just want it to be well-def=
ined.<br><br></div><div>--Jason<br><br></div></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Tue, Apr 18, 2017 at 1:30 PM, Chris Wi=
lson <span dir=3D"ltr">&lt;<a href=3D"mailto:chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org" targ=
et=3D"_blank">chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><span class=3D"">On Wed, Apr 19, 2017 at 05:34:52AM +10=
00, Dave Airlie wrote:<br>
&gt; On 14 April 2017 at 19:45, Chris Wilson &lt;<a href=3D"mailto:chris@ch=
ris-wilson.co.uk">chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; On Tue, Apr 11, 2017 at 01:22:12PM +1000, Dave Airlie wrote:<br>
&gt; &gt;&gt; This set of sync object patches should address most of the is=
sues<br>
&gt; &gt;&gt; raised in review.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The major changes:<br>
&gt; &gt;&gt; Race on destroy should be gone,<br>
&gt; &gt;&gt; Documentation fixups<br>
&gt; &gt;&gt; amdgpu internal use p instead of adev fixups<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; My plans are to write some igt tests this week, and try<br>
&gt; &gt;&gt; to get some more review on what the API should allow (should<=
br>
&gt; &gt;&gt; I lock it down to drm syncobj is just semaphores for now).<br=
>
&gt; &gt;<br>
&gt; &gt; Having an idr of handles is much, much nicer than fd and I want t=
he same<br>
&gt; &gt; for fences :)<br>
&gt;<br>
&gt; Okay, but what form do you want the API to take for fences?<br>
&gt;<br>
&gt; because I&#39;ve just ported all this to using sem_file as the backend=
, instead<br>
&gt; of sync_file which seems to oppose the goal of using it for fences.<br=
>
&gt;<br>
&gt; For fences do you want upfront creation, then passing created fences o=
bject<br>
&gt; into command submission that attach the internal fence?<br>
<br>
</span>Yes. My understanding is that fences differ from semaphores by allow=
ing<br>
use prior to execution. And that userspace (Vk) wants to be able to<br>
create a fence, pass it to a listener (maybe different process) and then<br=
>
attach it to an out-fence from a CS.<br>
<br>
I looked at using a shared idr for fences/semaphores and the issue I hit<br=
>
first was having to create a proxy dma-fence to initialise the syncobj<br>
with, so that I could attach listeners before I was able to hook the<br>
fence upto an execbuf.<br>
<span class=3D""><br>
&gt; Or do you want command submission to have out fence handles that it cr=
eates,<br>
&gt; so we don&#39;t have any explicit syncobj create for fences?<br>
&gt;<br>
&gt; Do you want those fences to be shareable across processes using sync_f=
ile<br>
&gt; semantics?<br>
<br>
</span>Yes. In the same vein as the semaphore syncobjs, an idr for cheap<br=
>
creation/reuse within a process and export/import via sync_file fds.<br>
Where these fd differ from sema is that they do support host CPU access<br>
(these will work just like regular sync_files in that regard).<br>
<span class=3D""><br>
&gt; I kinda feel like I&#39;m going around in circles here and I&#39;m goi=
ng to just merge<br>
&gt; something instead.<br>
<br>
</span>Sure. It was just from the perspective of extending the i915 execbuf=
fer2<br>
that adding an array for semaphore in/out could be neatly generalised to<br=
>
cover fences as well (and that the api for syncobj is a substantial<br>
improvement over sync_merge and passing one fence in/out).<br>
<span class=3D"im HOEnZb">-Chris<br>
<br>
--<br>
Chris Wilson, Intel Open Source Technology Centre<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">____________________________=
__<wbr>_________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.<wbr>org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</div></div></blockquote></div><br></div>

--001a114b446e93a14b054d77f6c3--

--===============1977994366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1977994366==--
