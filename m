From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Add curly braces around
 idr_for_each_entry_continue loop
Date: Tue, 5 Mar 2019 16:17:17 +0000
Message-ID: <BN6PR12MB18090A1A16094239EBEAF109F7720@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190305112004.12369-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0035035618=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190305112004.12369-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?Windows-1252?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0035035618==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18090A1A16094239EBEAF109F7720BN6PR12MB1809namp_"

--_000_BN6PR12MB18090A1A16094239EBEAF109F7720BN6PR12MB1809namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Tuesday, March 5, 2019 6:20 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amdkfd: Add curly braces around idr_for_each_entry_con=
tinue loop

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

The compiler pointed out that one if block unintentionally wasn't part
of the loop:

In file included from ./include/linux/kernfs.h:14,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/device.h:16,
                 from ./include/linux/node.h:18,
                 from ./include/linux/memory.h:19,
                 from drivers/gpu/drm//amd/amdgpu/../amdkfd/kfd_events.c:30=
:
drivers/gpu/drm//amd/amdgpu/../amdkfd/kfd_events.c: In function =91kfd_sign=
al_reset_event=92:
./include/linux/idr.h:212:2: warning: this =91for=92 clause does not guard.=
.. [-Wmisleading-indentation]
  for ((entry) =3D idr_get_next((idr), &(id));   \
  ^~~
drivers/gpu/drm//amd/amdgpu/../amdkfd/kfd_events.c:1038:3: note: in expansi=
on of macro =91idr_for_each_entry_continue=92
   idr_for_each_entry_continue(&p->event_idr, ev, id)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm//amd/amdgpu/../amdkfd/kfd_events.c:1043:4: note: ...this st=
atement, but the latter is misleadingly indented as if it were guarded by t=
he =91for=92
    if (ev->type =3D=3D KFD_EVENT_TYPE_MEMORY &&
    ^~

Fixes: "drm/amdkfd: add RAS ECC event support"
Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---

This is one reason why I think it's better to always use curly braces
around multiple lines, even if it happens to be a single statement.

 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index 97c984684973..6e1d41c5bf86 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1035,7 +1035,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev)
         hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
                 mutex_lock(&p->event_mutex);
                 id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
-               idr_for_each_entry_continue(&p->event_idr, ev, id)
+               idr_for_each_entry_continue(&p->event_idr, ev, id) {
                         if (ev->type =3D=3D KFD_EVENT_TYPE_HW_EXCEPTION) {
                                 ev->hw_exception_data =3D hw_exception_dat=
a;
                                 set_event(ev);
@@ -1045,6 +1045,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev)
                                 ev->memory_exception_data =3D memory_excep=
tion_data;
                                 set_event(ev);
                         }
+               }
                 mutex_unlock(&p->event_mutex);
         }
         srcu_read_unlock(&kfd_processes_srcu, idx);
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18090A1A16094239EBEAF109F7720BN6PR12MB1809namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Tuesday, March 5, 2019 6:20 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Add curly braces around idr_for_each_en=
try_continue loop</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
The compiler pointed out that one if block unintentionally wasn't part<br>
of the loop:<br>
<br>
In file included from ./include/linux/kernfs.h:14,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/sysfs.h:16,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/kobject.h:20,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/device.h:16,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/node.h:18,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/memory.h:19,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from drivers/gpu/drm//amd/amdgpu/../amdkfd/kfd_events=
.c:30:<br>
drivers/gpu/drm//amd/amdgpu/../amdkfd/kfd_events.c: In function =91kfd_sign=
al_reset_event=92:<br>
./include/linux/idr.h:212:2: warning: this =91for=92 clause does not guard.=
.. [-Wmisleading-indentation]<br>
&nbsp; for ((entry) =3D idr_get_next((idr), &amp;(id));&nbsp;&nbsp; \<br>
&nbsp; ^~~<br>
drivers/gpu/drm//amd/amdgpu/../amdkfd/kfd_events.c:1038:3: note: in expansi=
on of macro =91idr_for_each_entry_continue=92<br>
&nbsp;&nbsp; idr_for_each_entry_continue(&amp;p-&gt;event_idr, ev, id)<br>
&nbsp;&nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
drivers/gpu/drm//amd/amdgpu/../amdkfd/kfd_events.c:1043:4: note: ...this st=
atement, but the latter is misleadingly indented as if it were guarded by t=
he =91for=92<br>
&nbsp;&nbsp;&nbsp; if (ev-&gt;type =3D=3D KFD_EVENT_TYPE_MEMORY &amp;&amp;<=
br>
&nbsp;&nbsp;&nbsp; ^~<br>
<br>
Fixes: &quot;drm/amdkfd: add RAS ECC event support&quot;<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
<br>
This is one reason why I think it's better to always use curly braces<br>
around multiple lines, even if it happens to be a single statement.<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c<br>
index 97c984684973..6e1d41c5bf86 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
@@ -1035,7 &#43;1035,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_for_each_rcu(kfd_proc=
esses_table, temp, p, kfd_processes) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;p-&gt;event_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; idr_for_each_entry_continue(&amp;p-&gt;event_idr, ev, id)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; idr_for_each_entry_continue(&amp;p-&gt;event_idr, ev, id) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (e=
v-&gt;type =3D=3D KFD_EVENT_TYPE_HW_EXCEPTION) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ev-&gt;hw_exception_data =3D hw_=
exception_data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_event(ev);<br>
@@ -1045,6 &#43;1045,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ev-&gt;memory_exception_data =3D=
 memory_exception_data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_event(ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;event_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srcu_read_unlock(&amp;kfd_=
processes_srcu, idx);<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18090A1A16094239EBEAF109F7720BN6PR12MB1809namp_--

--===============0035035618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0035035618==--
