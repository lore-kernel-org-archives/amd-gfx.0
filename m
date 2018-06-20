From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add parsing SQ_EDC_INFO to SQ IH v2.
Date: Wed, 20 Jun 2018 11:02:02 -0400
Message-ID: <6f9d3c60-2050-f13c-df72-bff240d669b9@amd.com>
References: <1529505781-9004-1-git-send-email-andrey.grodzovsky@amd.com>
 <1529505781-9004-2-git-send-email-andrey.grodzovsky@amd.com>
 <d96fc78e-ef3d-fb3a-8548-7a6a7cc3d52f@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1374121763=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d96fc78e-ef3d-fb3a-8548-7a6a7cc3d52f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David.Panariti-5C7GfCeVMHo@public.gmane.org, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org

This is a multi-part message in MIME format.
--===============1374121763==
Content-Type: multipart/alternative;
 boundary="------------663A55BB841F2A94DA288397"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------663A55BB841F2A94DA288397
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Are you referring to insert_work->smp_mb(); ?

Andrey


On 06/20/2018 10:50 AM, Christian König wrote:
>> +     * Try to submit work so SQ_EDC_INFO can be accessed from
>> +     * BH. If previous work submission hasn't finished yet
>> +     * just print whatever info is possible directly from the ISR.
>> +     */
>> +    if (work_pending(&adev->gfx.sq_work.work)) {
>> +        gfx_v8_0_parse_sq_irq(adev, ih_data);
>> +    } else {
>> +        adev->gfx.sq_work.ih_data = ih_data;
>> +        /* Verify the new value visible in BH handler */
>> +        smp_wmb();
>
> You can drop the barrier here and in gfx_v8_0_sq_irq_work_func(), the 
> schedule_work() function is a barrier itself for both reads and writes 
> anyway.
>
> Apart from that the both patches are Acked-by: Christian König 
> <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
> Regards,
> Christian. 


--------------663A55BB841F2A94DA288397
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Are you referring to insert_work-&gt;smp_mb(); ?</p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 06/20/2018 10:50 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:d96fc78e-ef3d-fb3a-8548-7a6a7cc3d52f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <blockquote type="cite" style="color: #000000;">+     * Try to
        submit work so SQ_EDC_INFO can be accessed from
        <br>
        +     * BH. If previous work submission hasn't finished yet
        <br>
        +     * just print whatever info is possible directly from the
        ISR.
        <br>
        +     */
        <br>
        +    if (work_pending(&amp;adev-&gt;gfx.sq_work.work)) {
        <br>
        +        gfx_v8_0_parse_sq_irq(adev, ih_data);
        <br>
        +    } else {
        <br>
        +        adev-&gt;gfx.sq_work.ih_data = ih_data;
        <br>
        +        /* Verify the new value visible in BH handler */
        <br>
        +        smp_wmb();
        <br>
      </blockquote>
      <br>
      You can drop the barrier here and in gfx_v8_0_sq_irq_work_func(),
      the schedule_work() function is a barrier itself for both reads
      and writes anyway.
      <br>
      <br>
      Apart from that the both patches are Acked-by: Christian König <a
        class="moz-txt-link-rfc2396E"
        href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.
      <br>
      <br>
      Regards,
      <br>
      Christian.
    </blockquote>
    <br>
  </body>
</html>

--------------663A55BB841F2A94DA288397--

--===============1374121763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1374121763==--
