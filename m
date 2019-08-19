From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [bug report] drm/amd/powerplay: implement smc firmware v2.1 for
 smu11
Date: Mon, 19 Aug 2019 15:31:22 +0000
Message-ID: <MN2PR12MB3296E95A5C257028B748A3CBA2A80@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190819130357.GA1615@mwanda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1299478930=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190819130357.GA1615@mwanda>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1299478930==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296E95A5C257028B748A3CBA2A80MN2PR12MB3296namp_"

--_000_MN2PR12MB3296E95A5C257028B748A3CBA2A80MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thank you for reporting this bug to me,
I will make a  fix patch as soon as possible, when patch ready after I send=
 copies to you review,
thank you.

Best Regards,
Kevin
________________________________
From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sent: Monday, August 19, 2019 9:03 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [bug report] drm/amd/powerplay: implement smc firmware v2.1 for sm=
u11

Hello Kevin Wang,

The patch b55c83a7438d: "drm/amd/powerplay: implement smc firmware
v2.1 for smu11" from Jun 21, 2019, leads to the following static
checker warning:

        drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:390 smu_v11_0_s=
etup_pptable()
        warn: passing casted pointer '&size' to 'smu_get_atom_data_table()'=
 32 vs 16.

drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c
   357  static int smu_v11_0_setup_pptable(struct smu_context *smu)
   358  {
   359          struct amdgpu_device *adev =3D smu->adev;
   360          const struct smc_firmware_header_v1_0 *hdr;
   361          int ret, index;
   362          uint32_t size;
                ^^^^^^^^^^^^^

   363          uint8_t frev, crev;
   364          void *table;
   365          uint16_t version_major, version_minor;
   366
   367          hdr =3D (const struct smc_firmware_header_v1_0 *) adev->pm.=
fw->data;
   368          version_major =3D le16_to_cpu(hdr->header.header_version_ma=
jor);
   369          version_minor =3D le16_to_cpu(hdr->header.header_version_mi=
nor);
   370          if (version_major =3D=3D 2 && smu->smu_table.boot_values.pp=
_table_id > 0) {
   371                  switch (version_minor) {
   372                  case 0:
   373                          ret =3D smu_v11_0_set_pptable_v2_0(smu, &ta=
ble, &size);
   374                          break;
   375                  case 1:
   376                          ret =3D smu_v11_0_set_pptable_v2_1(smu, &ta=
ble, &size,
   377                                                           smu->smu_t=
able.boot_values.pp_table_id);
   378                          break;
   379                  default:
   380                          ret =3D -EINVAL;
   381                          break;
   382                  }
   383                  if (ret)
   384                          return ret;
   385
   386          } else {
   387                  index =3D get_index_into_master_table(atom_master_l=
ist_of_data_tables_v2_1,
   388                                                      powerplayinfo);
   389
   390                  ret =3D smu_get_atom_data_table(smu, index, (uint16=
_t *)&size, &frev, &crev,
                                                                  ^^^^^^^^^=
^^^^^^^^
This only initializes the highest 16 bits.

   391                                                (uint8_t **)&table);
   392                  if (ret)
   393                          return ret;
   394          }
   395
   396          if (!smu->smu_table.power_play_table)
   397                  smu->smu_table.power_play_table =3D table;
   398          if (!smu->smu_table.power_play_table_size)
   399                  smu->smu_table.power_play_table_size =3D size;
   400
   401          return 0;

regards,
dan carpenter

--_000_MN2PR12MB3296E95A5C257028B748A3CBA2A80MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Dan,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<span>Thank you for reporting this bug to me,</span>
<div><span>I will make a&nbsp; fix patch as soon as possible, when patch re=
ady after I send copies to you review,&nbsp;</span></div>
<div><span>thank you.<br>
</span><span></span>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, August 19, 2019 9:03 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Subject:</b> [bug report] drm/amd/powerplay: implement smc firmware v2.1=
 for smu11</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hello Kevin Wang,<br>
<br>
The patch b55c83a7438d: &quot;drm/amd/powerplay: implement smc firmware<br>
v2.1 for smu11&quot; from Jun 21, 2019, leads to the following static<br>
checker warning:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../po=
werplay/smu_v11_0.c:390 smu_v11_0_setup_pptable()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warn: passing casted pointer '&a=
mp;size' to 'smu_get_atom_data_table()' 32 vs 16.<br>
<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c<br>
&nbsp;&nbsp; 357&nbsp; static int smu_v11_0_setup_pptable(struct smu_contex=
t *smu)<br>
&nbsp;&nbsp; 358&nbsp; {<br>
&nbsp;&nbsp; 359&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_device *adev =3D smu-&gt;adev;<br>
&nbsp;&nbsp; 360&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cons=
t struct smc_firmware_header_v1_0 *hdr;<br>
&nbsp;&nbsp; 361&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
ret, index;<br>
&nbsp;&nbsp; 362&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ^^^^^^^^^^^^^<br>
<br>
&nbsp;&nbsp; 363&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
8_t frev, crev;<br>
&nbsp;&nbsp; 364&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void=
 *table;<br>
&nbsp;&nbsp; 365&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
16_t version_major, version_minor;<br>
&nbsp;&nbsp; 366&nbsp; <br>
&nbsp;&nbsp; 367&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =
=3D (const struct smc_firmware_header_v1_0 *) adev-&gt;pm.fw-&gt;data;<br>
&nbsp;&nbsp; 368&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vers=
ion_major =3D le16_to_cpu(hdr-&gt;header.header_version_major);<br>
&nbsp;&nbsp; 369&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vers=
ion_minor =3D le16_to_cpu(hdr-&gt;header.header_version_minor);<br>
&nbsp;&nbsp; 370&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
version_major =3D=3D 2 &amp;&amp; smu-&gt;smu_table.boot_values.pp_table_id=
 &gt; 0) {<br>
&nbsp;&nbsp; 371&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (version_minor) {<br>
&nbsp;&nbsp; 372&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
&nbsp;&nbsp; 373&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ret =3D smu_v11_0_set_pptable_v2_0(smu, &amp;table, &amp;s=
ize);<br>
&nbsp;&nbsp; 374&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp; 375&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
&nbsp;&nbsp; 376&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ret =3D smu_v11_0_set_pptable_v2_1(smu, &amp;table, &amp;s=
ize,<br>
&nbsp;&nbsp; 377&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;sm=
u_table.boot_values.pp_table_id);<br>
&nbsp;&nbsp; 378&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp; 379&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp; 380&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ret =3D -EINVAL;<br>
&nbsp;&nbsp; 381&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp; 382&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp; 383&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp; 384&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp; 385&nbsp; <br>
&nbsp;&nbsp; 386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } el=
se {<br>
&nbsp;&nbsp; 387&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D get_index_into_master=
_table(atom_master_list_of_data_tables_v2_1,<br>
&nbsp;&nbsp; 388&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplayinfo);<br>
&nbsp;&nbsp; 389&nbsp; <br>
&nbsp;&nbsp; 390&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_atom_data_table=
(smu, index, (uint16_t *)&amp;size, &amp;frev, &amp;crev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^<br>
This only initializes the highest 16 bits.<br>
<br>
&nbsp;&nbsp; 391&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
uint8_t **)&amp;table);<br>
&nbsp;&nbsp; 392&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp; 393&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp; 394&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&nbsp;&nbsp; 395&nbsp; <br>
&nbsp;&nbsp; 396&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!smu-&gt;smu_table.power_play_table)<br>
&nbsp;&nbsp; 397&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.power_play_ta=
ble =3D table;<br>
&nbsp;&nbsp; 398&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!smu-&gt;smu_table.power_play_table_size)<br>
&nbsp;&nbsp; 399&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.power_play_ta=
ble_size =3D size;<br>
&nbsp;&nbsp; 400&nbsp; <br>
&nbsp;&nbsp; 401&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn 0;<br>
<br>
regards,<br>
dan carpenter<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3296E95A5C257028B748A3CBA2A80MN2PR12MB3296namp_--

--===============1299478930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1299478930==--
