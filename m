From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: upsteam find bo api
Date: Mon, 19 Jun 2017 10:50:16 +0200
Message-ID: <6ce7c117-99d8-36b5-31cf-cc8689ed8a38@vodafone.de>
References: <59410CF8.9080409@amd.com> <59439208.10100@amd.com>
 <CADnq5_NY8pZr6JbD8GrUQatiFGz6J1dU9ug2TiFiyN+6kxozeg@mail.gmail.com>
 <431202a9-c20d-fc67-9e70-26dfb67a3792@vodafone.de> <59473586.3010206@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1041199385=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <59473586.3010206-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1041199385==
Content-Type: multipart/alternative;
 boundary="------------567B7E704AEDC89DF3BF0E6F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------567B7E704AEDC89DF3BF0E6F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.06.2017 um 04:23 schrieb zhoucm1:
>
>
> On 2017年06月17日 18:09, Christian König wrote:
>> The patch should still work on amd-staging-4.11, but drm-next has 
>> seen some changes on how the handles are stored for dma-buf.
>>
>> This can potentially break the implementation and I think we need to 
>> adapt before pushing it upstream, but I'm not 100% sure.
> Do you mean the patch needs to wait for next kernel promotion? 4.12? 4.13?

No, well maybe. The problem is that I'm not 100% sure if there isn't 
anything in drm-next which breaks this.

The easiest way to figure that out is to try to apply the patch to 
Dave's current drm-next branch and see if it still works as expected.

I think Alex plan was to setup an amd-staging-next branch to solve such 
problems, but that hasn't got very far I think.

Regards,
Christian.

>
> Regards,
> David Zhou
>>
>> Christian.
>>
>> Am 16.06.2017 um 22:35 schrieb Alex Deucher:
>>> The patches look good to me.  Christian what did you have in mind?
>>> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org 
>>> <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>>
>>>
>>> Alex
>>>
>>> On Fri, Jun 16, 2017 at 4:08 AM, zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org 
>>> <mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org>> wrote:
>>>
>>>     ping...?
>>>
>>>
>>>
>>>     -------- Forwarded Message --------
>>>     Subject: 	upsteam find bo api
>>>     Date: 	Wed, 14 Jun 2017 18:16:24 +0800
>>>     From: 	zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org> <mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org>
>>>     To: 	amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>>
>>>
>>>
>>>     Hi all,
>>>
>>>     Since patches are one feature, and contain kernel and libdrm, I attached
>>>     them not by send-mail. Hope not inconvenience.
>>>
>>>     0001-drm-amdgpu-return-bo-itself-if-userptr-is-cpu-addr-o.patch is
>>>     kernel patch.
>>>     Other three is libdrm patches including unit test.
>>>
>>>     please review.
>>>
>>>     Regards,
>>>     David Zhou
>>>
>>>
>>>
>>>
>>>     _______________________________________________
>>>     amd-gfx mailing list
>>>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>


--------------567B7E704AEDC89DF3BF0E6F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 19.06.2017 um 04:23 schrieb zhoucm1:<br>
    </div>
    <blockquote type="cite" cite="mid:59473586.3010206-5C7GfCeVMHo@public.gmane.org">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <br>
      <br>
      <div class="moz-cite-prefix">On 2017年06月17日 18:09, Christian König
        wrote:<br>
      </div>
      <blockquote
        cite="mid:431202a9-c20d-fc67-9e70-26dfb67a3792-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite">
        <meta http-equiv="Content-Type" content="text/html;
          charset=utf-8">
        <div class="moz-cite-prefix">The patch should still work on
          amd-staging-4.11, but drm-next has seen some changes on how
          the handles are stored for dma-buf.<br>
          <br>
          This can potentially break the implementation and I think we
          need to adapt before pushing it upstream, but I'm not 100%
          sure.<br>
        </div>
      </blockquote>
      Do you mean the patch needs to wait for next kernel promotion?
      4.12? 4.13?<br>
    </blockquote>
    <br>
    No, well maybe. The problem is that I'm not 100% sure if there isn't
    anything in drm-next which breaks this.<br>
    <br>
    The easiest way to figure that out is to try to apply the patch to
    Dave's current drm-next branch and see if it still works as
    expected.<br>
    <br>
    I think Alex plan was to setup an amd-staging-next branch to solve
    such problems, but that hasn't got very far I think.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:59473586.3010206-5C7GfCeVMHo@public.gmane.org"> <br>
      Regards,<br>
      David Zhou<br>
      <blockquote
        cite="mid:431202a9-c20d-fc67-9e70-26dfb67a3792-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite">
        <div class="moz-cite-prefix"> <br>
          Christian.<br>
          <br>
          Am 16.06.2017 um 22:35 schrieb Alex Deucher:<br>
        </div>
        <blockquote type="cite"
cite="mid:CADnq5_NY8pZr6JbD8GrUQatiFGz6J1dU9ug2TiFiyN+6kxozeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
          <div dir="ltr">
            <div>The patches look good to me.  Christian what did you
              have in mind?<br>
            </div>
            <div>Acked-by: Alex Deucher &lt;<a
                href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
            </div>
            <div><br>
            </div>
            Alex<br>
            <div>
              <div>
                <div class="gmail_extra"><br>
                  <div class="gmail_quote">On Fri, Jun 16, 2017 at 4:08
                    AM, zhoucm1 <span dir="ltr">&lt;<a
                        href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org"
                        target="_blank" moz-do-not-send="true">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
                    wrote:<br>
                    <blockquote class="gmail_quote" style="margin:0 0 0
                      .8ex;border-left:1px #ccc solid;padding-left:1ex">
                      <div text="#000000" bgcolor="#FFFFFF"> ping...?
                        <div>
                          <div class="h5"><br>
                            <div
                              class="m_-3073124277673834392moz-forward-container"><br>
                              <br>
                              -------- Forwarded Message --------
                              <table
                                class="m_-3073124277673834392moz-email-headers-table"
                                cellspacing="0" cellpadding="0"
                                border="0">
                                <tbody>
                                  <tr>
                                    <th valign="BASELINE" align="RIGHT"
                                      nowrap="nowrap">Subject: </th>
                                    <td>upsteam find bo api</td>
                                  </tr>
                                  <tr>
                                    <th valign="BASELINE" align="RIGHT"
                                      nowrap="nowrap">Date: </th>
                                    <td>Wed, 14 Jun 2017 18:16:24 +0800</td>
                                  </tr>
                                  <tr>
                                    <th valign="BASELINE" align="RIGHT"
                                      nowrap="nowrap">From: </th>
                                    <td>zhoucm1 <a
                                        class="m_-3073124277673834392moz-txt-link-rfc2396E"
href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org" target="_blank" moz-do-not-send="true">&lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a></td>
                                  </tr>
                                  <tr>
                                    <th valign="BASELINE" align="RIGHT"
                                      nowrap="nowrap">To: </th>
                                    <td><a
                                        class="m_-3073124277673834392moz-txt-link-abbreviated"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"
                                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></td>
                                  </tr>
                                </tbody>
                              </table>
                              <br>
                              <br>
                              <pre>Hi all,

Since patches are one feature, and contain kernel and libdrm, I attached 
them not by send-mail. Hope not inconvenience.

0001-drm-amdgpu-return-bo-<wbr>itself-if-userptr-is-cpu-addr-<wbr>o.patch is 
kernel patch.
Other three is libdrm patches including unit test.

please review.

Regards,
David Zhou

</pre>
                              <br>
                            </div>
                            <br>
                          </div>
                        </div>
                      </div>
                      <br>
                      ______________________________<wbr>_________________<br>
                      amd-gfx mailing list<br>
                      <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <a
                        href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                        rel="noreferrer" target="_blank"
                        moz-do-not-send="true">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
                      <br>
                    </blockquote>
                  </div>
                  <br>
                </div>
              </div>
            </div>
          </div>
          <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <br>
          <pre wrap="">_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <p><br>
        </p>
      </blockquote>
      <br>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------567B7E704AEDC89DF3BF0E6F--

--===============1041199385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1041199385==--
