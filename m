From: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] Exclusive gpu access for SteamVR usecases
Date: Fri, 26 May 2017 09:02:32 +0000
Message-ID: <20E73ED4-5A64-45A5-A609-77F91CAB8425@amd.com>
References: <20170525000101.8184-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0558390428=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170525000101.8184-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0558390428==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_20E73ED45A6445A5A60977F91CAB8425amdcom_"

--_000_20E73ED45A6445A5A60977F91CAB8425amdcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Andres,
Why the fd is needed for this interface?
Why not just using the dev->fd instead of fd?
IIRC, if there are more than one fds opened in the process upon the same de=
vice, they will share the same amdgpu_device_handle which is guaranteed by =
amdgpu_device_initialize.
In other word, we should not run into the case that user creates more conte=
xts with newly opened fd after tuning the priority of existing context in t=
he same process unless the previous fd is closed.

Thanks.
Best Regards,
David

On 25 May 2017, at 8:00 AM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:and=
resx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:

When multiple environments are running simultaneously on a system, e.g.
an X desktop + a SteamVR game session, it may be useful to sacrifice
performance in one environment in order to boost it on the other.

This series provides a mechanism for a DRM_MASTER to provide exclusive
gpu access to a group of processes.

Note: This series is built on the assumption that the drm lease patch serie=
s
will extend DRM_MASTER status to lesees.

The libdrm we intend to provide is as follows:

/**
* Set the priority of all contexts in a process
*
* This function will change the priority of all contexts owned by
* the process identified by fd.
*
* \param dev             - \c [in] device handle
* \param fd              - \c [in] fd from target process
* \param priority        - \c [in] target priority AMDGPU_CTX_PRIORITY_*
*
* \return  0 on success\n
*         <0 - Negative POSIX error code
*
* \notes @fd can be *any* file descriptor from the target process.
* \notes this function requires DRM_MASTER
*/
int amdgpu_sched_process_priority_set(amdgpu_device_handle dev,
     int fd, int32_t priority);

/**
* Request to raise the minimum required priority to schedule a gpu job
*
* Submit a request to increase the minimum required priority to schedule
* a gpu job. Once this function returns, the gpu scheduler will no longer
* consider jobs from contexts with priority lower than @priority.
*
* The minimum priority considered by the scheduler will be the highest from
* all currently active requests.
*
* Requests are refcounted, and must be balanced using
* amdgpu_sched_min_priority_put()
*
* \param dev             - \c [in] device handle
* \param priority        - \c [in] target priority AMDGPU_CTX_PRIORITY_*
*
* \return  0 on success\n
*         <0 - Negative POSIX error code
*
* \notes this function requires DRM_MASTER
*/
int amdgpu_sched_min_priority_get(amdgpu_device_handle dev,
 int32_t priority);

/**
* Drop a request to raise the minimum required scheduler priority
*
* This call balances amdgpu_sched_min_priority_get()
*
* If no other active requests exists for @priority, the minimum required
* priority will decay to a lower level until one is reached with an active
* request or the lowest priority is reached.
*
* \param dev             - \c [in] device handle
* \param priority        - \c [in] target priority AMDGPU_CTX_PRIORITY_*
*
* \return  0 on success\n
*         <0 - Negative POSIX error code
*
* \notes this function requires DRM_MASTER
*/
int amdgpu_sched_min_priority_put(amdgpu_device_handle dev,
 int32_t priority);

Using this app, VRComposer can raise the priority of the VRapp and itself. =
Then
it can restrict the minimum scheduler priority in order to become exclusive=
 gpu
clients.

One of the areas I'd like feedback is the following scenario. If a VRapp op=
ens
a new fd and creates a new context after a call to set_priority, this speci=
fic
context will be lower priority than the rest. If the minimum required prior=
ity
is then raised, it is possible that this new context will be starved and
deadlock the VRapp.

One solution I had in mind to address this situation, is to make set_priori=
ty
also raise the priority of future contexts created by the VRapp. However, t=
hat
would require keeping track of the requested priority on a per-process data
structure. The current design appears to steer clean of keeping any process
specific data, and everything instead of stored on a per-file basis. Which =
is
why I did not pursue this approach. But if this is something you'd like me =
to
implement let me know.

One could also argue that preventing an application deadlock should be hand=
led
between the VRComposer and the VRApp. It is not the kernel's responsibility=
 to
babysit userspace applications and prevent themselves from shooting themsel=
ves
in the foot. The same could be achieved by improper usage of shared fences
between processes.

Thoughts/feedback/comments on this issue, or others, are appreciated.

Regards,
Andres


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_20E73ED45A6445A5A60977F91CAB8425amdcom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <5DFC45447815034A8F787158B9FC6523-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;" class=3D"">
<font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"">Hi Andres,</fo=
nt>
<div class=3D""><font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"=
">Why the fd is needed for this interface?</font></div>
<div class=3D""><font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"=
">Why not just using the dev-&gt;fd instead of fd?</font></div>
<div class=3D""><font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"=
">IIRC, if there are more than one fds opened in the process upon the same =
device, they will share the same amdgpu_device_handle which is guaranteed b=
y amdgpu_device_initialize.</font></div>
<div class=3D""><font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"=
">In other word, we should not run into the case that user creates more con=
texts with newly opened fd after tuning the priority of existing context in=
 the same process unless the previous fd
 is closed.&nbsp;</font></div>
<div class=3D""><font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"=
"><br class=3D"">
</font></div>
<div class=3D""><font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"=
">Thanks.</font></div>
<div class=3D""><font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"=
">Best Regards,</font></div>
<div class=3D""><font face=3D"Calibri" style=3D"font-size: 14px;" class=3D"=
">David</font></div>
<div class=3D""><br class=3D"">
<div>
<blockquote type=3D"cite" class=3D"">
<div class=3D"">On 25 May 2017, at 8:00 AM, Andres Rodriguez &lt;<a href=3D=
"mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" class=3D"">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:</d=
iv>
<br class=3D"Apple-interchange-newline">
<div class=3D"">
<div class=3D"">When multiple environments are running simultaneously on a =
system, e.g.<br class=3D"">
an X desktop &#43; a SteamVR game session, it may be useful to sacrifice<br=
 class=3D"">
performance in one environment in order to boost it on the other.<br class=
=3D"">
<br class=3D"">
This series provides a mechanism for a DRM_MASTER to provide exclusive<br c=
lass=3D"">
gpu access to a group of processes.<br class=3D"">
<br class=3D"">
Note: This series is built on the assumption that the drm lease patch serie=
s<br class=3D"">
will extend DRM_MASTER status to lesees.<br class=3D"">
<br class=3D"">
The libdrm we intend to provide is as follows:<br class=3D"">
<br class=3D"">
/**<br class=3D"">
* Set the priority of all contexts in a process<br class=3D"">
*<br class=3D"">
* This function will change the priority of all contexts owned by<br class=
=3D"">
* the process identified by fd.<br class=3D"">
*<br class=3D"">
* \param dev &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;- \c [in] device handle<br class=3D"">
* \param fd &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;- \c [in] fd from target process<br class=3D"">
* \param priority &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- \c [in] targe=
t priority AMDGPU_CTX_PRIORITY_*<br class=3D"">
*<br class=3D"">
* \return &nbsp;0 on success\n<br class=3D"">
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;0 - Negative POSIX er=
ror code<br class=3D"">
*<br class=3D"">
* \notes @fd can be *any* file descriptor from the target process.<br class=
=3D"">
* \notes this function requires DRM_MASTER<br class=3D"">
*/<br class=3D"">
int amdgpu_sched_process_priority_set(amdgpu_device_handle dev,<br class=3D=
"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span><span class=
=3D"Apple-tab-span" style=3D"white-space:pre"></span><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre"></span><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int fd, int32_=
t
 priority);<br class=3D"">
<br class=3D"">
/**<br class=3D"">
* Request to raise the minimum required priority to schedule a gpu job<br c=
lass=3D"">
*<br class=3D"">
* Submit a request to increase the minimum required priority to schedule<br=
 class=3D"">
* a gpu job. Once this function returns, the gpu scheduler will no longer<b=
r class=3D"">
* consider jobs from contexts with priority lower than @priority.<br class=
=3D"">
*<br class=3D"">
* The minimum priority considered by the scheduler will be the highest from=
<br class=3D"">
* all currently active requests.<br class=3D"">
*<br class=3D"">
* Requests are refcounted, and must be balanced using<br class=3D"">
* amdgpu_sched_min_priority_put()<br class=3D"">
*<br class=3D"">
* \param dev &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;- \c [in] device handle<br class=3D"">
* \param priority &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- \c [in] targe=
t priority AMDGPU_CTX_PRIORITY_*<br class=3D"">
*<br class=3D"">
* \return &nbsp;0 on success\n<br class=3D"">
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;0 - Negative POSIX er=
ror code<br class=3D"">
*<br class=3D"">
* \notes this function requires DRM_MASTER<br class=3D"">
*/<br class=3D"">
int amdgpu_sched_min_priority_get(amdgpu_device_handle dev,<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span><span class=
=3D"Apple-tab-span" style=3D"white-space:pre"></span><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre"></span><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre"></span>&nbsp;int32_t priority);<br class=3D"">
<br class=3D"">
/**<br class=3D"">
* Drop a request to raise the minimum required scheduler priority<br class=
=3D"">
*<br class=3D"">
* This call balances amdgpu_sched_min_priority_get()<br class=3D"">
*<br class=3D"">
* If no other active requests exists for @priority, the minimum required<br=
 class=3D"">
* priority will decay to a lower level until one is reached with an active<=
br class=3D"">
* request or the lowest priority is reached.<br class=3D"">
*<br class=3D"">
* \param dev &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;- \c [in] device handle<br class=3D"">
* \param priority &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- \c [in] targe=
t priority AMDGPU_CTX_PRIORITY_*<br class=3D"">
*<br class=3D"">
* \return &nbsp;0 on success\n<br class=3D"">
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;0 - Negative POSIX er=
ror code<br class=3D"">
*<br class=3D"">
* \notes this function requires DRM_MASTER<br class=3D"">
*/<br class=3D"">
int amdgpu_sched_min_priority_put(amdgpu_device_handle dev,<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span><span class=
=3D"Apple-tab-span" style=3D"white-space:pre"></span><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre"></span><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre"></span>&nbsp;int32_t priority);<br class=3D"">
<br class=3D"">
Using this app, VRComposer can raise the priority of the VRapp and itself. =
Then<br class=3D"">
it can restrict the minimum scheduler priority in order to become exclusive=
 gpu<br class=3D"">
clients.<br class=3D"">
<br class=3D"">
One of the areas I'd like feedback is the following scenario. If a VRapp op=
ens<br class=3D"">
a new fd and creates a new context after a call to set_priority, this speci=
fic<br class=3D"">
context will be lower priority than the rest. If the minimum required prior=
ity<br class=3D"">
is then raised, it is possible that this new context will be starved and<br=
 class=3D"">
deadlock the VRapp.<br class=3D"">
<br class=3D"">
One solution I had in mind to address this situation, is to make set_priori=
ty<br class=3D"">
also raise the priority of future contexts created by the VRapp. However, t=
hat<br class=3D"">
would require keeping track of the requested priority on a per-process data=
<br class=3D"">
structure. The current design appears to steer clean of keeping any process=
<br class=3D"">
specific data, and everything instead of stored on a per-file basis. Which =
is<br class=3D"">
why I did not pursue this approach. But if this is something you'd like me =
to<br class=3D"">
implement let me know.<br class=3D"">
<br class=3D"">
One could also argue that preventing an application deadlock should be hand=
led<br class=3D"">
between the VRComposer and the VRApp. It is not the kernel's responsibility=
 to<br class=3D"">
babysit userspace applications and prevent themselves from shooting themsel=
ves<br class=3D"">
in the foot. The same could be achieved by improper usage of shared fences<=
br class=3D"">
between processes.<br class=3D"">
<br class=3D"">
Thoughts/feedback/comments on this issue, or others, are appreciated.<br cl=
ass=3D"">
<br class=3D"">
Regards,<br class=3D"">
Andres<br class=3D"">
<br class=3D"">
<br class=3D"">
_______________________________________________<br class=3D"">
amd-gfx mailing list<br class=3D"">
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"">amd-gfx@lists.f=
reedesktop.org</a><br class=3D"">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<br class=3D"">
</div>
</div>
</blockquote>
</div>
<br class=3D"">
</div>
</body>
</html>

--_000_20E73ED45A6445A5A60977F91CAB8425amdcom_--

--===============0558390428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0558390428==--
