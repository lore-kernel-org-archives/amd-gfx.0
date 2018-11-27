From: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable UVD/VCE for some polaris 12 variants
Date: Tue, 27 Nov 2018 09:47:40 +0800
Message-ID: <962b81c0-358b-0447-d496-9b8efe817261@amd.com>
References: <20181123083227.25555-1-Jerry.Zhang@amd.com>
 <BN6PR12MB18091B4409C1DC5CD17F903CF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <b8a49f59-e466-b0e7-abf8-feedf1bf1946@amd.com>
 <b63c3263-9df8-6c3f-06aa-7b97609d21a6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0279036403=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b63c3263-9df8-6c3f-06aa-7b97609d21a6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0279036403==
Content-Type: multipart/alternative;
	boundary="------------9846CFFC88892C2AD20C0C5C"
Content-Language: en-US

--------------9846CFFC88892C2AD20C0C5C
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/18 5:28 PM, Christian König wrote:
> Am 26.11.18 um 03:38 schrieb Zhang, Jerry(Junwei):
>> On 11/24/18 3:32 AM, Deucher, Alexander wrote:
>>>
>>> Is this required? Are the harvesting fuses incorrect?  If the blocks 
>>> are harvested, we should bail out of the blocks properly during 
>>> init.  Also, please make this more explicit if we still need it.  E.g.,
>>>
>>>
>>
>> The harvest fuse is indeed disabling UVD and VCE, as it's a mining card.
>> Then any command to UVD/VCE causing NULL pointer issue, like amdgpu_test.
>
> In this case we should fix the NULL pointer issue instead. Do you have 
> a backtrace for this?

Sorry to miss the detail.
The NULL pointer is caused by UVD is not initialized as it's disabled in 
VBIOS for this kind of card.

When cs submit, it will check ring->funcs->parse_cs in amdgpu_cs_ib_fill().
However, uvd_v6_0_early_init() skip the set ring function, as 
CC_HARVEST_FUSES is set UVD/VCE disabled.
Then the access to UVD/VCE ring's funcs will cause NULL pointer issue.

BTW, Windows driver disables UVD/VCE for it as well.

Regards,
Jerry

>
> Regards,
> Christian.
>
>>
>> AFAIW, windows also disable UVD and VCE in initialization.
>>
>>>        if ((adev->pdev->device == 0x67df) &&
>>>               (adev->pdev->revision == 0xf7)) {
>>>
>>> /* Some polaris12 variants don't support UVD/VCE */
>>>
>>>       } else  {
>>>
>>> amdgpu_device_ip_block_add(adev, &uvd_v6_3_ip_block);
>>>
>>> amdgpu_device_ip_block_add(adev, &vce_v3_4_ip_block);
>>>
>>>     }
>>>
>>>
>>
>> OK, will explicit the process.
>>
>> Regards,
>> Jerry
>>>
>>> That way if we re-arrange the order later, it will be easier to track.
>>>
>>>
>>> Alex
>>>
>>> ------------------------------------------------------------------------
>>> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
>>> Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
>>> *Sent:* Friday, November 23, 2018 3:32:27 AM
>>> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> *Cc:* Zhang, Jerry
>>> *Subject:* [PATCH] drm/amdgpu: disable UVD/VCE for some polaris 12 
>>> variants
>>> Some variants don't support UVD and VCE.
>>>
>>> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/vi.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vi.c
>>> index f3a4cf1f013a..3338b013ded4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>>> @@ -1660,6 +1660,10 @@ int vi_set_ip_blocks(struct amdgpu_device *adev)
>>> amdgpu_device_ip_block_add(adev, &dce_v11_2_ip_block);
>>>                  amdgpu_device_ip_block_add(adev, &gfx_v8_0_ip_block);
>>>                  amdgpu_device_ip_block_add(adev, &sdma_v3_1_ip_block);
>>> +               /* Some polaris12 variants don't support UVD/VCE */
>>> +               if ((adev->pdev->device == 0x67df) &&
>>> +                     (adev->pdev->revision == 0xf7))
>>> +                       break;
>>>                  amdgpu_device_ip_block_add(adev, &uvd_v6_3_ip_block);
>>>                  amdgpu_device_ip_block_add(adev, &vce_v3_4_ip_block);
>>>                  break;
>>> -- 
>>> 2.17.1
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------9846CFFC88892C2AD20C0C5C
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 11/26/18 5:28 PM, Christian König wrote:<br>
    <blockquote type="cite"
      cite="mid:b63c3263-9df8-6c3f-06aa-7b97609d21a6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div class="moz-cite-prefix">Am 26.11.18 um 03:38 schrieb Zhang,
        Jerry(Junwei):<br>
      </div>
      <blockquote type="cite"
        cite="mid:b8a49f59-e466-b0e7-abf8-feedf1bf1946-5C7GfCeVMHo@public.gmane.org"> On
        11/24/18 3:32 AM, Deucher, Alexander wrote:<br>
        <blockquote type="cite"
cite="mid:BN6PR12MB18091B4409C1DC5CD17F903CF7D40-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
          <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
          <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
            dir="ltr">
            <p style="margin-top:0;margin-bottom:0">Is this required? 
              Are the harvesting fuses incorrect?  If the blocks are
              harvested, we should bail out of the blocks properly
              during init.  Also, please make this more explicit if we
              still need it.  E.g.,</p>
            <p style="margin-top:0;margin-bottom:0"><font size="2"><span
                  style="font-size:11pt;"><br>
                </span></font></p>
          </div>
        </blockquote>
        <br>
        The harvest fuse is indeed disabling UVD and VCE, as it's a
        mining card.<br>
        Then any command to UVD/VCE causing NULL pointer issue, like
        amdgpu_test.<br>
      </blockquote>
      <br>
      In this case we should fix the NULL pointer issue instead. Do you
      have a backtrace for this?<br>
    </blockquote>
    <br>
    Sorry to miss the detail.<br>
    The NULL pointer is caused by UVD is not initialized as it's
    disabled in VBIOS for this kind of card.<br>
    <br>
    When cs submit, it will check ring-&gt;funcs-&gt;parse_cs in
    amdgpu_cs_ib_fill().<br>
    However, uvd_v6_0_early_init() skip the set ring function, as
    CC_HARVEST_FUSES is set UVD/VCE disabled.<br>
    Then the access to UVD/VCE ring's funcs will cause NULL pointer
    issue.<br>
    <br>
    BTW, Windows driver disables UVD/VCE for it as well.<br>
    <br>
    Regards,<br>
    Jerry<br>
    <br>
    <blockquote type="cite"
      cite="mid:b63c3263-9df8-6c3f-06aa-7b97609d21a6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"> <br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite"
        cite="mid:b8a49f59-e466-b0e7-abf8-feedf1bf1946-5C7GfCeVMHo@public.gmane.org"> <br>
        AFAIW, windows also disable UVD and VCE in initialization.<br>
        <br>
        <blockquote type="cite"
cite="mid:BN6PR12MB18091B4409C1DC5CD17F903CF7D40-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
          <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
            dir="ltr">
            <p style="margin-top:0;margin-bottom:0"><font size="2"><span
                  style="font-size:11pt;">        if
                  ((adev-&gt;pdev-&gt;device == 0x67df) &amp;&amp;<br>
                                (adev-&gt;pdev-&gt;revision == 0xf7)) {<br>
                </span></font></p>
            <p style="margin-top:0;margin-bottom:0"><font size="2"><span
                  style="font-size:11pt;">        <font size="2"><span
                      style="font-size:11pt;">/* Some polaris12 variants
                      don't support UVD/VCE */</span></font><br>
                </span></font></p>
            <p style="margin-top:0;margin-bottom:0"><font size="2"><span
                  style="font-size:11pt;">      } else  {<br>
                </span></font></p>
            <p style="margin-top:0;margin-bottom:0"><font size="2"><span
                  style="font-size:11pt;">                
                  amdgpu_device_ip_block_add(adev,
                  &amp;uvd_v6_3_ip_block);</span></font></p>
            <p style="margin-top:0;margin-bottom:0"><font size="2"><span
                  style="font-size:11pt;">                
                  amdgpu_device_ip_block_add(adev,
                  &amp;vce_v3_4_ip_block);</span></font></p>
            <p style="margin-top:0;margin-bottom:0">    }</p>
            <p style="margin-top:0;margin-bottom:0"><br>
            </p>
          </div>
        </blockquote>
        <br>
        OK, will explicit the process.<br>
        <br>
        Regards,<br>
        Jerry<br>
        <blockquote type="cite"
cite="mid:BN6PR12MB18091B4409C1DC5CD17F903CF7D40-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
          <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
            dir="ltr">
            <p style="margin-top:0;margin-bottom:0"> </p>
            <p style="margin-top:0;margin-bottom:0">That way if we
              re-arrange the order later, it will be easier to track.</p>
            <p style="margin-top:0;margin-bottom:0"><br>
            </p>
            <p style="margin-top:0;margin-bottom:0">Alex<br>
            </p>
          </div>
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E"
                href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
              on behalf of Junwei Zhang <a
                class="moz-txt-link-rfc2396E"
                href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Friday, November 23, 2018 3:32:27 AM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Zhang, Jerry<br>
              <b>Subject:</b> [PATCH] drm/amdgpu: disable UVD/VCE for
              some polaris 12 variants</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">Some variants don't support UVD
                  and VCE.<br>
                  <br>
                  Signed-off-by: Junwei Zhang <a
                    class="moz-txt-link-rfc2396E"
                    href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  ---<br>
                   drivers/gpu/drm/amd/amdgpu/vi.c | 4 ++++<br>
                   1 file changed, 4 insertions(+)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
                  b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
                  index f3a4cf1f013a..3338b013ded4 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
                  @@ -1660,6 +1660,10 @@ int vi_set_ip_blocks(struct
                  amdgpu_device *adev)<br>
                                          
                  amdgpu_device_ip_block_add(adev,
                  &amp;dce_v11_2_ip_block);<br>
                                   amdgpu_device_ip_block_add(adev,
                  &amp;gfx_v8_0_ip_block);<br>
                                   amdgpu_device_ip_block_add(adev,
                  &amp;sdma_v3_1_ip_block);<br>
                  +               /* Some polaris12 variants don't
                  support UVD/VCE */<br>
                  +               if ((adev-&gt;pdev-&gt;device ==
                  0x67df) &amp;&amp;<br>
                  +                     (adev-&gt;pdev-&gt;revision ==
                  0xf7))<br>
                  +                       break;<br>
                                   amdgpu_device_ip_block_add(adev,
                  &amp;uvd_v6_3_ip_block);<br>
                                   amdgpu_device_ip_block_add(adev,
                  &amp;vce_v3_4_ip_block);<br>
                                   break;<br>
                  -- <br>
                  2.17.1<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated"
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                </div>
              </span></font></div>
        </blockquote>
        <br>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------9846CFFC88892C2AD20C0C5C--

--===============0279036403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0279036403==--
