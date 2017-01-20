From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 1/3] amdgpu: verify the tested device
Date: Fri, 20 Jan 2017 19:14:18 +0000
Message-ID: <CY4PR12MB1640D78EBE9F998A00F5323FF2710@CY4PR12MB1640.namprd12.prod.outlook.com>
References: <1484866391-17175-1-git-send-email-AlexBin.Xie@amd.com>,
 <CACvgo50HCafUSw7zDjkS+_1xs67=QgHcOWcO1DDqzBL4RcRBJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0500462108=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo50HCafUSw7zDjkS+_1xs67=QgHcOWcO1DDqzBL4RcRBJA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0500462108==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1640D78EBE9F998A00F5323FF2710CY4PR12MB1640namp_"

--_000_CY4PR12MB1640D78EBE9F998A00F5323FF2710CY4PR12MB1640namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Emil,


Thanks for the comments.


Please see below.


Regards,

Alex Bin Xie


________________________________
From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, January 20, 2017 8:18 AM
To: Xie, AlexBin
Cc: amd-gfx mailing list
Subject: Re: [PATCH libdrm 1/3] amdgpu: verify the tested device

Hi Alex,

Thanks for doing this. There's a few nitpicks on top of what David and
Christian has spotted.

On 19 January 2017 at 22:53, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org> wrote:
> Verify the vender ID and driver name.
> Open all AMDGPU devices.
> Provide an option to open render node.
>
> Tested as root: PASS
> Tested as non-privileged user:
> All tests failed as expected
>
> Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
> ---
>  tests/amdgpu/amdgpu_test.c | 144 +++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 121 insertions(+), 23 deletions(-)
>
> diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c
> index 71f357c..e42ef9d 100644
> --- a/tests/amdgpu/amdgpu_test.c
> +++ b/tests/amdgpu/amdgpu_test.c
> @@ -115,6 +115,119 @@ static const char usage[] =3D "Usage: %s [-hl] [<-s=
 <suite id>> [-t <test id>]]\n"
>  /** Specified options strings for getopt */
>  static const char options[]   =3D "hls:t:";
>
> +/* Open AMD devices.
> + * Return the number of AMD device openned.
> + */
> +static int amdgpu_open_devices(int open_render_node)
> +{
> +       drmDevicePtr devices[MAX_CARDS_SUPPORTED];
> +       int ret;
> +       int i;
> +       int j;
> +       int amd_index =3D 0;
> +       int drm_count;
> +       int fd;
> +       char *device_name;
> +       drmVersionPtr version;
> +
> +       drm_count =3D drmGetDevices2(0, devices, MAX_CARDS_SUPPORTED);
> +
> +       if (drm_count < 0) {
> +               fprintf(stderr,
> +                       "drmGetDevices2() returned an error %d\n",
> +                       drm_count);
> +               return 0;
> +       }
> +
> +       for (i =3D 0; i < drm_count; i++) {
> +               /* If this is not AMD GPU vender ID, skip*/
> +               if (devices[i]->bustype =3D=3D DRM_BUS_PCI)
> +                       if (devices[i]->deviceinfo.pci->vendor_id !=3D 0x=
1002)
> +                               continue;
> +
> +               for (j =3D 0; j < DRM_NODE_MAX; j++) {
> +                       if (devices[i]->available_nodes & 1 << j) {
> +                               fd =3D open(
> +                                       devices[i]->nodes[j],
> +                                       O_RDONLY | O_CLOEXEC,
> +                                       0);
> +                               if (fd < 0) continue;
> +                       }
You don't need to iterate over all the available nodes. Just fetch the
PRIMARY or RENDER based on open_render_node.
Note that a device can be missing some node types (say RENDER) so make
sure the available_nodes bitmask is set.

[Alex Bin Xie]:
That was my original design, but later I changed.
I knew this work for the current xf86drm.c. But is the nodes[0]  always pri=
mary?
I was afraid that this may be changed in future. I searched all drm tests. =
I did not see an example.

So amdgpu_test will be the first to access nodes like: open(devices[i]->nod=
es[DRM_NODE_PRIMARY]), for example.

> +                       if (open_render_node)
> +                               device_name =3D drmGetRenderDeviceNameFro=
mFd(fd);
> +                       else
> +                               device_name =3D drmGetPrimaryDeviceNameFr=
omFd(fd);
> +
> +                       close(fd);
> +
> +                       drm_amdgpu[amd_index] =3D open(device_name,
> +                                                       O_RDWR | O_CLOEXE=
C);
> +
> +                       if (drm_amdgpu[amd_index] >=3D 0)
> +                               amd_index++;
> +
> +                       free(device_name);
> +
With the above comment this becomes redundant.

> +                       /* We have open this device. Go to next device.*/
> +                       break;
> +               }
> +       }
> +
Here you want to initialise the remainder of drm_amdgpu[] (since
drm_count can be less than MAX_CARDS_SUPPORTED) with -1.
Otherwise you'll have fun experiences during close/print (below).

[Alex Bin Xie]: This initialization is done in existing main() function (no=
t introduced this patch).

-Emil

--_000_CY4PR12MB1640D78EBE9F998A00F5323FF2710CY4PR12MB1640namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Emil,</p>
<p><br>
</p>
<p>Thanks for the comments.</p>
<p><br>
</p>
<p>Please see below.<br>
</p>
<p><br>
</p>
<p>Regards,</p>
<p>Alex Bin Xie<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Emil Velikov &lt;em=
il.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, January 20, 2017 8:18 AM<br>
<b>To:</b> Xie, AlexBin<br>
<b>Cc:</b> amd-gfx mailing list<br>
<b>Subject:</b> Re: [PATCH libdrm 1/3] amdgpu: verify the tested device</fo=
nt>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Alex,<br>
<br>
Thanks for doing this. There's a few nitpicks on top of what David and<br>
Christian has spotted.<br>
<br>
On 19 January 2017 at 22:53, Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br=
>
&gt; Verify the vender ID and driver name.<br>
&gt; Open all AMDGPU devices.<br>
&gt; Provide an option to open render node.<br>
&gt;<br>
&gt; Tested as root: PASS<br>
&gt; Tested as non-privileged user:<br>
&gt; All tests failed as expected<br>
&gt;<br>
&gt; Signed-off-by: Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; tests/amdgpu/amdgpu_test.c | 144 &#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;--------<br>
&gt;&nbsp; 1 file changed, 121 insertions(&#43;), 23 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c<b=
r>
&gt; index 71f357c..e42ef9d 100644<br>
&gt; --- a/tests/amdgpu/amdgpu_test.c<br>
&gt; &#43;&#43;&#43; b/tests/amdgpu/amdgpu_test.c<br>
&gt; @@ -115,6 &#43;115,119 @@ static const char usage[] =3D &quot;Usage: %=
s [-hl] [&lt;-s &lt;suite id&gt;&gt; [-t &lt;test id&gt;]]\n&quot;<br>
&gt;&nbsp; /** Specified options strings for getopt */<br>
&gt;&nbsp; static const char options[]&nbsp;&nbsp; =3D &quot;hls:t:&quot;;<=
br>
&gt;<br>
&gt; &#43;/* Open AMD devices.<br>
&gt; &#43; * Return the number of AMD device openned.<br>
&gt; &#43; */<br>
&gt; &#43;static int amdgpu_open_devices(int open_render_node)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmDevicePtr devices[MAX_CAR=
DS_SUPPORTED];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int j;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int amd_index =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int drm_count;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *device_name;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmVersionPtr version;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_count =3D drmGetDevices2=
(0, devices, MAX_CARDS_SUPPORTED);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drm_count &lt; 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fprintf(stderr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;d=
rmGetDevices2() returned an error %d\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_cou=
nt);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; drm_cou=
nt; i&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* If this is not AMD GPU vender ID, skip*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (devices[i]-&gt;bustype =3D=3D DRM_BUS_PCI)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev=
ices[i]-&gt;deviceinfo.pci-&gt;vendor_id !=3D 0x1002)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; DRM_NODE_MAX; j&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev=
ices[i]-&gt;available_nodes &amp; 1 &lt;&lt; j) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd =3D open(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; devices[i]-&gt;nodes[j],<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; O_RDONLY | O_CLOEXEC,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fd &lt; 0) continue;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
You don't need to iterate over all the available nodes. Just fetch the<br>
PRIMARY or RENDER based on open_render_node.<br>
Note that a device can be missing some node types (say RENDER) so make<br>
sure the available_nodes bitmask is set.<br>
<br>
[Alex Bin Xie]:<br>
That was my original design, but later I changed.<br>
I knew this work for the current xf86drm.c. But is the nodes[0]&nbsp; alway=
s primary?<br>
I was afraid that this may be changed in future. I searched all drm tests. =
I did not see an example.<br>
<br>
So amdgpu_test will be the first to access nodes like:<font size=3D"2"><spa=
n style=3D"font-size:10pt;"><font size=3D"2"> open(<span class=3D"blob-code=
-inner">devices[i]-&gt;nodes[DRM_NODE_PRIMARY]</span>), for example.<br>
</font></span></font><br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ope=
n_render_node)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_name =3D drmGetRenderDevice=
NameFromFd(fd);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_name =3D drmGetPrimaryDevic=
eNameFromFd(fd);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(f=
d);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_amd=
gpu[amd_index] =3D open(device_name,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; O_RDWR | O_CLOEXEC);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drm=
_amdgpu[amd_index] &gt;=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd_index&#43;&#43;;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(de=
vice_name);<br>
&gt; &#43;<br>
With the above comment this becomes redundant.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We h=
ave open this device. Go to next device.*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
Here you want to initialise the remainder of drm_amdgpu[] (since<br>
drm_count can be less than MAX_CARDS_SUPPORTED) with -1.<br>
Otherwise you'll have fun experiences during close/print (below).<br>
<br>
<font size=3D"2"><span style=3D"font-size:10pt;">[Alex Bin Xie]:</span></fo=
nt> This initialization is done in existing main<font size=3D"2"><span styl=
e=3D"font-size:10pt;">() function</span></font> (not introduced this patch)=
.<br>
<br>
-Emil<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1640D78EBE9F998A00F5323FF2710CY4PR12MB1640namp_--

--===============0500462108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0500462108==--
