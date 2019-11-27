From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Deadlock on PTEs update for HMM
Date: Wed, 27 Nov 2019 16:02:00 +0100
Message-ID: <10b23ec2-f91e-51db-6d31-ba8a654e78bb@amd.com>
References: <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0874596129=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB26216A095D9839500242F489FD440-kxOKjb6HO/GMiSxbuvOENgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0874596129==
Content-Type: multipart/alternative;
 boundary="------------71D9C9EA1D2E0834E3097FCF"
Content-Language: en-US

--------------71D9C9EA1D2E0834E3097FCF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alejandro,

yes I'm very aware of this issue, but unfortunately can't give an easy 
solution either.

I'm working for over a year now on getting this fixed, but unfortunately 
it turned out that this problem is much bigger than initially thought.

Setting the appropriate GFP flags for the job allocation is actually the 
trivial part.

The really really hard thing is that we somehow need to add a lock to 
prevent the page tables from being evicted. And as you also figured out 
that lock can't be taken easily anywhere else.

I've already wrote a prototype for this, but didn't had time to hammer 
it into shape for upstreaming yet.

Regards,
Christian.

Am 27.11.19 um 15:55 schrieb Sierra Guiza, Alejandro (Alex):
>
> Hi Christian,
>
> As you know, we’re working on the HMM enablement. Im working on the 
> dGPU page table entries invalidation on the userptr mapping case. 
> Currently, the MMU notifiers handle stops all user mode queues, 
> schedule a delayed worker to re-validate userptr mappings and restart 
> the queues.
>
> Part of the HMM functionality, we need to invalidate the page table 
> entries instead of stopping the queues. At the same time we need to 
> move the revalidation of the userptr mappings into the page fault handler.
>
> We’re seeing a deadlock warning after we try to invalidate the PTEs 
> inside the MMU notifier handler. More specific, when we try to update 
> the BOs to invalidate PTEs using amdgpu_vm_bo_update. This uses 
> kmalloc on the amdgpu_job_alloc which seems to be causing this problem.
>
> Based on @Kuehling, Felix <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> comments, 
> kmalloc without any special flags can cause memory reclaim. Doing that 
> inside an MMU notifier is problematic, because an MMU notifier may be 
> called inside a memory-reclaim operation itself. That would result in 
> recursion. Also, reclaim shouldn't be done while holding a lock that 
> can be taken in an MMU notifier for the same reason. If you cause a 
> reclaim while holding that lock, then an MMU notifier called by the 
> reclaim can deadlock trying to take the same lock.
>
> Please let us know if you have any advice to enable this the right way
>
> Thanks in advanced,
>
> Alejandro
>


--------------71D9C9EA1D2E0834E3097FCF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Alejandro,<br>
      <br>
      yes I'm very aware of this issue, but unfortunately can't give an
      easy solution either.<br>
      <br>
      I'm working for over a year now on getting this fixed, but
      unfortunately it turned out that this problem is much bigger than
      initially thought.<br>
      <br>
      Setting the appropriate GFP flags for the job allocation is
      actually the trivial part.<br>
      <br>
      The really really hard thing is that we somehow need to add a lock
      to prevent the page tables from being evicted. And as you also
      figured out that lock can't be taken easily anywhere else.<br>
      <br>
      I've already wrote a prototype for this, but didn't had time to
      hammer it into shape for upstreaming yet.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 27.11.19 um 15:55 schrieb Sierra Guiza, Alejandro (Alex):<br>
    </div>
    <blockquote type="cite" cite="mid:SN6PR12MB26216A095D9839500242F489FD440-kxOKjb6HO/GMiSxbuvOENgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:106%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">Hi Christian,<o:p></o:p></p>
        <p class="MsoNormal">As you know, we’re working on the HMM
          enablement. Im working on the dGPU page table entries
          invalidation on the userptr mapping case. Currently, the MMU
          notifiers handle stops all user mode queues, schedule a
          delayed worker to re-validate userptr mappings and restart the
          queues. <o:p></o:p></p>
        <p class="MsoNormal">Part of the HMM functionality, we need to
          invalidate the page table entries instead of stopping the
          queues. At the same time we need to move the revalidation of
          the userptr mappings into the page fault handler.<o:p></o:p></p>
        <p class="MsoNormal">We’re seeing a deadlock warning after we
          try to invalidate the PTEs inside the MMU notifier handler.
          More specific, when we try to update the BOs to invalidate
          PTEs using amdgpu_vm_bo_update. This uses kmalloc on the
          amdgpu_job_alloc which seems to be causing this problem.<o:p></o:p></p>
        <p class="MsoNormal">Based on <a id="OWAAMBC6F9A316D814AE993661FC111776926" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">
            <span style="font-family:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Kuehling,
              Felix</span></a> comments,
          <span style="font-size:10.5pt;line-height:106%;font-family:&quot;Segoe
            UI&quot;,sans-serif">
            kmalloc without any special flags can cause memory reclaim.
            Doing that inside an MMU notifier is problematic, because an
            MMU notifier may be called inside a memory-reclaim operation
            itself. That would result in recursion. Also, reclaim
            shouldn't be done while holding a lock that can be taken in
            an MMU notifier for the same reason. If you cause a reclaim
            while holding that lock, then an&nbsp;MMU notifier called by the
            reclaim can&nbsp;deadlock trying to take the same lock.<o:p></o:p></span></p>
        <p class="MsoNormal">Please let us know if you have any advice
          to enable this the right way<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Thanks in advanced,<o:p></o:p></p>
        <p class="MsoNormal">Alejandro<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------71D9C9EA1D2E0834E3097FCF--

--===============0874596129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0874596129==--
