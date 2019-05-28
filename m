From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix ring test failure issue during s3 in vce
 3.0
Date: Tue, 28 May 2019 09:23:40 +0200
Message-ID: <3763ca45-b90e-dac9-f2a7-35aee4dc2548@gmail.com>
References: <1558942936-16519-1-git-send-email-shirish.s@amd.com>
 <c2e96ff1-522f-4d1d-f312-9209a63e58ce@amd.com>
 <MN2PR12MB34398CEE701707E25781E9A2AA1D0@MN2PR12MB3439.namprd12.prod.outlook.com>
 <70c3ff3e-1f14-fcd6-e533-8e224fe0b976@amd.com>
 <MN2PR12MB3439645C85B84D0382352D04AA1D0@MN2PR12MB3439.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0781689964=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3439645C85B84D0382352D04AA1D0-rweVpJHSKTpimzxKl6w4wgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Li, Ching-shih (Louis)" <Ching-shih.Li-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0781689964==
Content-Type: multipart/alternative;
 boundary="------------DE0E2CF00C82A2CFA063BC64"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DE0E2CF00C82A2CFA063BC64
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Wow, really good catch!

The underlying problem is most likely that VCE block is either power or 
clock gated and because of this the readptr read always returns zero.

Now amdgpu_ring_alloc() informs the power management code that the block 
is about to be used and so the gating is turned off.

Mhm, that is probably wrong at a hole bunch of other places, at least 
the UVD and VCN code comes to mind.

I agree with Leo that you should remove the original read (so to not 
read twice) and it would be realy nice if you could double check the 
other code (UVD/VCN) for similar problems as well.

Regards,
Christian.

Am 27.05.19 um 19:20 schrieb Li, Ching-shih (Louis):
>
> I don’t mean to read it twice. The solution is to make first read 
> later. I didn’t modify the original code to make code difference less 
> and simple. I guess it should work to remove the original read there.
>
> *From:*Liu, Leo <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Tuesday, May 28, 2019 12:40 AM
> *To:* Li, Ching-shih (Louis) <Ching-shih.Li-5C7GfCeVMHo@public.gmane.org>; S, Shirish 
> <Shirish.S-5C7GfCeVMHo@public.gmane.org>; Grodzovsky, Andrey <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>; 
> Zhang, Jerry <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>; Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; 
> Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amdgpu: fix ring test failure issue during 
> s3 in vce 3.0
>
> int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
> {
>     struct amdgpu_device *adev = ring->adev;
>
>     uint32_t rptr = amdgpu_ring_get_rptr(ring);
>
>     unsigned i;
>     int r, timeout = adev->usec_timeout;
>
>     /* skip ring test for sriov*/
>     if (amdgpu_sriov_vf(adev))
>         return 0;
>
>     r = amdgpu_ring_alloc(ring, 16);
>     if (r)
>         return r;
>
>     amdgpu_ring_write(ring, VCE_CMD_END);
>     amdgpu_ring_commit(ring);
>
> Above is original code, rptr is updated when called, and below is your 
> patch, my question is why do you need to get rptr twice?
>
> @@ -1084,6 +1084,8 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
>          if (r)
>                 return r;
>   
> +       rptr = amdgpu_ring_get_rptr(ring);
> +
>          amdgpu_ring_write(ring, VCE_CMD_END);
>          amdgpu_ring_commit(ring);
>   
>
> On 5/27/19 12:22 PM, Li, Ching-shih (Louis) wrote:
>
>     Hi Leo,
>
>     Yes, I confirm it is the root cause *for the Chrome S3 issue*.
>     Whenever system is resumed, the original instruction always gets
>     zero. However, I have no idea why it fails, and didn’t verify this
>     problem on CRB or any other Linux platform yet.
>
>     Although I think the ideal solution is an indicator, e.g. a
>     register, for driver to check if related firmware and hardware are
>     ready to work. So driver can make sure it is ok to read rptr.
>     Without any reference document, I can only try to solve the
>     problem by modifying driver. Debug traces reveal that only first
>     rptr read fails, but the read in check loop is ok. Therefore, a
>     solution comes to mind: to update rptr later for initial rptr
>     value. Tests prove it working in Chrome platforms. Fyi~
>
>     BR,
>
>     Louis
>
>     *From:*Liu, Leo <Leo.Liu-5C7GfCeVMHo@public.gmane.org> <mailto:Leo.Liu-5C7GfCeVMHo@public.gmane.org>
>     *Sent:* Monday, May 27, 2019 9:01 PM
>     *To:* S, Shirish <Shirish.S-5C7GfCeVMHo@public.gmane.org> <mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org>;
>     Grodzovsky, Andrey <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
>     <mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>; Zhang, Jerry
>     <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org> <mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>; Deng, Emily
>     <Emily.Deng-5C7GfCeVMHo@public.gmane.org> <mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Deucher,
>     Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
>     <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
>     *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Li, Ching-shih (Louis)
>     <Ching-shih.Li-5C7GfCeVMHo@public.gmane.org> <mailto:Ching-shih.Li-5C7GfCeVMHo@public.gmane.org>
>     *Subject:* Re: [PATCH] drm/amdgpu: fix ring test failure issue
>     during s3 in vce 3.0
>
>     On 5/27/19 3:42 AM, S, Shirish wrote:
>
>         From: Louis Li<Ching-shih.Li-5C7GfCeVMHo@public.gmane.org>  <mailto:Ching-shih.Li-5C7GfCeVMHo@public.gmane.org>
>
>           
>
>         [What]
>
>         vce ring test fails consistently during resume in s3 cycle, due to
>
>         mismatch read & write pointers.
>
>         On debug/analysis its found that rptr to be compared is not being
>
>         correctly updated/read, which leads to this failure.
>
>         Below is the failure signature:
>
>            [drm:amdgpu_vce_ring_test_ring] *ERROR* amdgpu: ring 12 test failed
>
>            [drm:amdgpu_device_ip_resume_phase2] *ERROR* resume of IP block <vce_v3_0> failed -110
>
>            [drm:amdgpu_device_resume] *ERROR* amdgpu_device_ip_resume failed (-110).
>
>           
>
>         [How]
>
>         fetch rptr appropriately, meaning move its read location further down
>
>         in the code flow.
>
>         With this patch applied the s3 failure is no more seen for >5k s3 cycles,
>
>         which otherwise is pretty consistent.
>
>           
>
>         Signed-off-by: Louis Li<Ching-shih.Li-5C7GfCeVMHo@public.gmane.org>  <mailto:Ching-shih.Li-5C7GfCeVMHo@public.gmane.org>
>
>         ---
>
>           drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 ++
>
>           1 file changed, 2 insertions(+)
>
>           
>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>
>         index c021b11..92f9d46 100644
>
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>
>         @@ -1084,6 +1084,8 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
>
>            if (r)
>
>                   return r;
>
>           
>
>         + rptr = amdgpu_ring_get_rptr(ring);
>
>         +
>
>     The rptr update is there:
>
>     |        uint32_t rptr = amdgpu_ring_get_rptr(ring);|
>
>     ||
>
>     |Are you sure this is the root cause?|
>
>     ||
>
>     |Regards,|
>
>     |Leo|
>
>     ||
>
>           
>
>            amdgpu_ring_write(ring, VCE_CMD_END);
>
>            amdgpu_ring_commit(ring);
>
>           
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------DE0E2CF00C82A2CFA063BC64
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Wow, really good catch!<br>
      <br>
      The underlying problem is most likely that VCE block is either
      power or clock gated and because of this the readptr read always
      returns zero.<br>
      <br>
      Now amdgpu_ring_alloc() informs the power management code that the
      block is about to be used and so the gating is turned off.<br>
      <br>
      Mhm, that is probably wrong at a hole bunch of other places, at
      least the UVD and VCN code comes to mind.<br>
      <br>
      I agree with Leo that you should remove the original read (so to
      not read twice) and it would be realy nice if you could double
      check the other code (UVD/VCN) for similar problems as well.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 27.05.19 um 19:20 schrieb Li, Ching-shih (Louis):<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB3439645C85B84D0382352D04AA1D0-rweVpJHSKTpimzxKl6w4wgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:新細明體;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@新細明體";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	color:black;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="color:windowtext">I don’t mean
            to read it twice. The solution is to make first read later.
            I didn’t modify the original code to make code difference
            less and simple. I guess it should work to remove the
            original read there.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                style="color:windowtext"> Liu, Leo
                <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Leo.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>
                <br>
                <b>Sent:</b> Tuesday, May 28, 2019 12:40 AM<br>
                <b>To:</b> Li, Ching-shih (Louis)
                <a class="moz-txt-link-rfc2396E" href="mailto:Ching-shih.Li-5C7GfCeVMHo@public.gmane.org">&lt;Ching-shih.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>; S, Shirish
                <a class="moz-txt-link-rfc2396E" href="mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org">&lt;Shirish.S-5C7GfCeVMHo@public.gmane.org&gt;</a>; Grodzovsky, Andrey
                <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a>; Zhang, Jerry
                <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a>; Deng, Emily
                <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: fix ring test
                failure issue during s3 in vce 3.0<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p>int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)<br>
          {<br>
              struct amdgpu_device *adev = ring-&gt;adev;<o:p></o:p></p>
        <p><span style="color:red">    uint32_t rptr =
            amdgpu_ring_get_rptr(ring);</span><o:p></o:p></p>
        <p>    unsigned i;<br>
              int r, timeout = adev-&gt;usec_timeout;<br>
          <br>
              /* skip ring test for sriov*/<br>
              if (amdgpu_sriov_vf(adev))<br>
                  return 0;<br>
          <br>
              r = amdgpu_ring_alloc(ring, 16);<br>
              if (r)<br>
                  return r;<br>
          <br>
              amdgpu_ring_write(ring, VCE_CMD_END);<br>
              amdgpu_ring_commit(ring);<o:p></o:p></p>
        <p><o:p> </o:p></p>
        <p>Above is original code, rptr is updated when called, and
          below is your patch, my question is why do you need to get
          rptr twice?<o:p></o:p></p>
        <pre>@@ -1084,6 +1084,8 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)<o:p></o:p></pre>
        <pre>        if (r)<o:p></o:p></pre>
        <pre>               return r;<o:p></o:p></pre>
        <pre> <o:p></o:p></pre>
        <pre>+       rptr = amdgpu_ring_get_rptr(ring);<o:p></o:p></pre>
        <pre>+<o:p></o:p></pre>
        <pre>        amdgpu_ring_write(ring, VCE_CMD_END);<o:p></o:p></pre>
        <pre>        amdgpu_ring_commit(ring);<o:p></o:p></pre>
        <pre> <o:p></o:p></pre>
        <p><o:p> </o:p></p>
        <div>
          <p class="MsoNormal">On 5/27/19 12:22 PM, Li, Ching-shih
            (Louis) wrote:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal"><span style="color:windowtext">Hi Leo,</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">Yes, I
              confirm it is the root cause
              <b>for the Chrome S3 issue</b>. Whenever system is
              resumed, the original instruction always gets zero.
              However, I have no idea why it fails, and didn’t verify
              this problem on CRB or any other Linux platform yet.</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">Although I
              think the ideal solution is an indicator, e.g. a register,
              for driver to check if related firmware and hardware are
              ready to work. So driver can make sure it is ok to read
              rptr. Without any reference document, I can only try to
              solve the problem by modifying driver. Debug traces reveal
              that only first rptr read fails, but the read in check
              loop is ok. Therefore, a solution comes to mind: to update
              rptr later for initial rptr value. Tests prove it working
              in Chrome platforms. Fyi~</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">BR,</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">Louis</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                  style="color:windowtext"> Liu, Leo
                  <a href="mailto:Leo.Liu-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Leo.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a> <br>
                  <b>Sent:</b> Monday, May 27, 2019 9:01 PM<br>
                  <b>To:</b> S, Shirish <a
                    href="mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Shirish.S-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Grodzovsky, Andrey
                  <a href="mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Zhang, Jerry
                  <a href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Deng, Emily <a href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">
                    &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>; Deucher, Alexander <a
                    href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">
                    &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Cc:</b> <a
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                  Li, Ching-shih (Louis)
                  <a href="mailto:Ching-shih.Li-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Ching-shih.Li-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: fix ring test
                  failure issue during s3 in vce 3.0</span><o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p> <o:p></o:p></p>
          <div>
            <p class="MsoNormal">On 5/27/19 3:42 AM, S, Shirish wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre>From: Louis Li <a href="mailto:Ching-shih.Li-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Ching-shih.Li-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>[What]<o:p></o:p></pre>
            <pre>vce ring test fails consistently during resume in s3 cycle, due to<o:p></o:p></pre>
            <pre>mismatch read &amp; write pointers.<o:p></o:p></pre>
            <pre>On debug/analysis its found that rptr to be compared is not being<o:p></o:p></pre>
            <pre>correctly updated/read, which leads to this failure.<o:p></o:p></pre>
            <pre>Below is the failure signature:<o:p></o:p></pre>
            <pre>  [drm:amdgpu_vce_ring_test_ring] *ERROR* amdgpu: ring 12 test failed<o:p></o:p></pre>
            <pre>  [drm:amdgpu_device_ip_resume_phase2] *ERROR* resume of IP block &lt;vce_v3_0&gt; failed -110<o:p></o:p></pre>
            <pre>  [drm:amdgpu_device_resume] *ERROR* amdgpu_device_ip_resume failed (-110).<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>[How]<o:p></o:p></pre>
            <pre>fetch rptr appropriately, meaning move its read location further down<o:p></o:p></pre>
            <pre>in the code flow.<o:p></o:p></pre>
            <pre>With this patch applied the s3 failure is no more seen for &gt;5k s3 cycles,<o:p></o:p></pre>
            <pre>which otherwise is pretty consistent.<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>Signed-off-by: Louis Li <a href="mailto:Ching-shih.Li-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Ching-shih.Li-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></pre>
            <pre>---<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 ++<o:p></o:p></pre>
            <pre> 1 file changed, 2 insertions(+)<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<o:p></o:p></pre>
            <pre>index c021b11..92f9d46 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<o:p></o:p></pre>
            <pre>@@ -1084,6 +1084,8 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)<o:p></o:p></pre>
            <pre>  if (r)<o:p></o:p></pre>
            <pre>         return r;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>+ rptr = amdgpu_ring_get_rptr(ring);<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
          </blockquote>
          <p>The rptr update is there:<o:p></o:p></p>
          <pre><code>        uint32_t rptr = amdgpu_ring_get_rptr(ring);</code><o:p></o:p></pre>
          <pre><code> </code><o:p></o:p></pre>
          <pre><code>Are you sure this is the root cause?</code><o:p></o:p></pre>
          <pre><code> </code><o:p></o:p></pre>
          <pre><code>Regards,</code><o:p></o:p></pre>
          <pre><code>Leo</code><o:p></o:p></pre>
          <pre><code> </code><o:p></o:p></pre>
          <p> <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre> <o:p></o:p></pre>
            <pre>  amdgpu_ring_write(ring, VCE_CMD_END);<o:p></o:p></pre>
            <pre>  amdgpu_ring_commit(ring);<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
          </blockquote>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------DE0E2CF00C82A2CFA063BC64--

--===============0781689964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0781689964==--
