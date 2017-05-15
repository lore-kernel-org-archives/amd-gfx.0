From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: cleanup adjust_mc_addr handling
Date: Mon, 15 May 2017 11:37:45 +0200
Message-ID: <244d4206-affc-434d-e5f8-32b5c3d3ea82@vodafone.de>
References: <1494596880-3968-1-git-send-email-deathsimple@vodafone.de>
 <1494596880-3968-3-git-send-email-deathsimple@vodafone.de>
 <674b18c3-045e-2c77-1349-b1f24e72067c@amd.com> <59191B2D.7000604@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0651043120=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <59191B2D.7000604-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0651043120==
Content-Type: multipart/alternative;
 boundary="------------0E59316D41B905271FF51D57"

This is a multi-part message in MIME format.
--------------0E59316D41B905271FF51D57
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.05.2017 um 05:06 schrieb zhoucm1:
> On 2017年05月13日 02:57, Felix Kuehling wrote:
>> [SNIP]
>>>   					amdgpu_vm_do_set_ptes(&params,
>>>   							      last_shadow,
>>> -							      pt_addr, count,
>>> -							      incr,
>>> -							      AMDGPU_PTE_VALID);
>>> +							      entry, count,
>>> +							      incr, 0);
>> [FK] For count >=3 this would result in an SDMA_OP_PTEPDE packet with
>> flags=0 and the flags included in the address. Could SDMA mask out the
>> flags bits from the address before it applies the flags? The SDMA 4.0
>> MAS includes pseudo code that looks like it wouldn't.
>
>         5.
>
>
>                   Generate PTE/PDE
>
> It would work like this in C pseudo code:
>
> For (i = 0; i < count; i++)
>
> {
>
> Write ( Mask | ( Initial Value + ( i * Increment ) ) ) to Dest Addr  
> // result is a 64 bit value
>
> Dest Addr += 8 bytes;
>
> }
>
> Yes, it wouldn't.
>
Well Felix is right with the point that this is actually at least a 
little bit ugly and not the intended use.

I will just keep setting the valid bit outside of that function.

Regards,
Christian.

--------------0E59316D41B905271FF51D57
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 15.05.2017 um 05:06 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:59191B2D.7000604-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      On 2017年05月13日 02:57, Felix Kuehling wrote:<br>
      <blockquote
        cite="mid:674b18c3-045e-2c77-1349-b1f24e72067c-5C7GfCeVMHo@public.gmane.org"
        type="cite">[SNIP]<br>
        <blockquote type="cite">
          <pre wrap=""> 					amdgpu_vm_do_set_ptes(&amp;params,
 							      last_shadow,
-							      pt_addr, count,
-							      incr,
-							      AMDGPU_PTE_VALID);
+							      entry, count,
+							      incr, 0);
</pre>
        </blockquote>
        <pre wrap="">[FK] For count &gt;=3 this would result in an SDMA_OP_PTEPDE packet with
flags=0 and the flags included in the address. Could SDMA mask out the
flags bits from the address before it applies the flags? The SDMA 4.0
MAS includes pseudo code that looks like it wouldn't.</pre>
      </blockquote>
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <ol>
        <ol>
          <ol start="5">
            <li>
              <h3 class="western"><a moz-do-not-send="true"
                  name="_Toc415065276"></a>Generate PTE/PDE</h3>
            </li>
          </ol>
        </ol>
      </ol>
      <p class="western" style="line-height: 100%"><font color="#000000">It
          would work like this in C pseudo code:</font></p>
      <p class="western" style="line-height: 100%"><font color="#000000">For
          (i = 0; i &lt; count; i++)</font></p>
      <p class="western" style="line-height: 100%"><font color="#000000">{</font></p>
      <p class="western" style="line-height: 100%"><font color="#000000">               
          Write ( Mask | ( Initial Value + ( i * Increment ) ) ) to Dest
          Addr  // result is a 64 bit value</font></p>
      <p class="western" style="line-height: 100%"><font color="#000000">               
          Dest Addr += 8 bytes;</font></p>
      <p class="western" style="line-height: 100%"><font color="#000000">}<br>
        </font></p>
      <p class="western" style="line-height: 100%"><font color="#000000">Yes,
          it wouldn't.<br>
        </font></p>
    </blockquote>
    Well Felix is right with the point that this is actually at least a
    little bit ugly and not the intended use.<br>
    <br>
    I will just keep setting the valid bit outside of that function.<br>
    <br>
    Regards,<br>
    Christian.<br>
  </body>
</html>

--------------0E59316D41B905271FF51D57--

--===============0651043120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0651043120==--
