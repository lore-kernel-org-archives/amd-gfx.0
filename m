From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH drm/amdgpu] Use correct mask in dce_v8_0_afmt_setmode()
 and fix comment typos.
Date: Mon, 22 Aug 2016 09:55:05 +0200
Message-ID: <cb4275dd-dd82-e640-b187-60783c6fed2e@vodafone.de>
References: <20160822003841.16476-1-alexandre.f.demers@gmail.com>
 <73e7bbfa-45a7-1f1e-ae19-52a6461f4a9f@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1929608911=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <73e7bbfa-45a7-1f1e-ae19-52a6461f4a9f-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1929608911==
Content-Type: multipart/alternative;
 boundary="------------F0B6F89662D5DD643EC44787"

This is a multi-part message in MIME format.
--------------F0B6F89662D5DD643EC44787
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.08.2016 um 02:41 schrieb Edward O'Callaghan:
>
> On 08/22/2016 10:38 AM, Alexandre Demers wrote:
>> We were using the same mask twice. Looking at radeon, it seems
>> we should be using HDMI_AVI_INFO_CONT instead as the second mask.
>>
>> Being there, fix typos in comments and improved readability.
>>
>> I haven't looked at other DCEs, the mask may also be wrong for them.
>>
>> Signed-off-by: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> index c7e5d5f..e424ecc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> @@ -1693,6 +1693,7 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
>>   	/* Silent, r600_hdmi_enable will raise WARN for us */
>>   	if (!dig->afmt->enabled)
>>   		return;
>> +
>>   	offset = dig->afmt->offset;
>>   
>>   	/* hdmi deep color mode general control packets setup, if bpc > 8 */
>> @@ -1817,7 +1818,7 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
>>   
>>   	WREG32_OR(mmHDMI_INFOFRAME_CONTROL0 + offset,
>>   		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK | /* enable AVI info frames */
>> -		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK); /* required for audio info values to be updated */
>> +		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_CONT_MASK); /* required for audio info values to be updated */
>>   
>>   	WREG32_P(mmHDMI_INFOFRAME_CONTROL1 + offset,
>>   		 (2 << HDMI_INFOFRAME_CONTROL1__HDMI_AVI_INFO_LINE__SHIFT), /* anything other than 0 */
>> @@ -1826,13 +1827,13 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
>>   	WREG32_OR(mmAFMT_AUDIO_PACKET_CONTROL + offset,
>>   		  AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_MASK); /* send audio packets */
>>   
>> -	/* it's unknown what these bits do excatly, but it's indeed quite useful for debugging */
>> +	/* it's unknown what these bits do exactly, but it's indeed quite useful for debugging */

You can actually completely drop this comment now. I added it when I 
originally reverse engineered the hardware to figure out how HDMI audio 
works.

With that fixed the patch is Reviewed-by: Christian König 
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Regards,
Christian.

>>   	WREG32(mmAFMT_RAMP_CONTROL0 + offset, 0x00FFFFFF);
>>   	WREG32(mmAFMT_RAMP_CONTROL1 + offset, 0x007FFFFF);
>>   	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
>>   	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
>>   
>> -	/* enable audio after to setting up hw */
>> +	/* enable audio after setting up hw */
>>   	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
>>   }
>>   
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------F0B6F89662D5DD643EC44787
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 22.08.2016 um 02:41 schrieb Edward
      O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:73e7bbfa-45a7-1f1e-ae19-52a6461f4a9f-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">

On 08/22/2016 10:38 AM, Alexandre Demers wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">We were using the same mask twice. Looking at radeon, it seems
we should be using HDMI_AVI_INFO_CONT instead as the second mask.

Being there, fix typos in comments and improved readability.

I haven't looked at other DCEs, the mask may also be wrong for them.

Signed-off-by: Alexandre Demers <a class="moz-txt-link-rfc2396E" href="mailto:alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
</pre>
      </blockquote>
      <pre wrap="">Reviewed-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a>

</pre>
      <blockquote type="cite">
        <pre wrap="">---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index c7e5d5f..e424ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1693,6 +1693,7 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 	/* Silent, r600_hdmi_enable will raise WARN for us */
 	if (!dig-&gt;afmt-&gt;enabled)
 		return;
+
 	offset = dig-&gt;afmt-&gt;offset;
 
 	/* hdmi deep color mode general control packets setup, if bpc &gt; 8 */
@@ -1817,7 +1818,7 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 
 	WREG32_OR(mmHDMI_INFOFRAME_CONTROL0 + offset,
 		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK | /* enable AVI info frames */
-		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK); /* required for audio info values to be updated */
+		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_CONT_MASK); /* required for audio info values to be updated */
 
 	WREG32_P(mmHDMI_INFOFRAME_CONTROL1 + offset,
 		 (2 &lt;&lt; HDMI_INFOFRAME_CONTROL1__HDMI_AVI_INFO_LINE__SHIFT), /* anything other than 0 */
@@ -1826,13 +1827,13 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 	WREG32_OR(mmAFMT_AUDIO_PACKET_CONTROL + offset,
 		  AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_MASK); /* send audio packets */
 
-	/* it's unknown what these bits do excatly, but it's indeed quite useful for debugging */
+	/* it's unknown what these bits do exactly, but it's indeed quite useful for debugging */</pre>
      </blockquote>
    </blockquote>
    <br>
    You can actually completely drop this comment now. I added it when I
    originally reverse engineered the hardware to figure out how HDMI
    audio works.<br>
    <br>
    With that fixed the patch is Reviewed-by: Christian König
    <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
    <br>
    Regards,<br>
    Christian. <br>
    <br>
    <blockquote
      cite="mid:73e7bbfa-45a7-1f1e-ae19-52a6461f4a9f-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <blockquote type="cite">
        <pre wrap="">
 	WREG32(mmAFMT_RAMP_CONTROL0 + offset, 0x00FFFFFF);
 	WREG32(mmAFMT_RAMP_CONTROL1 + offset, 0x007FFFFF);
 	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
 	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
 
-	/* enable audio after to setting up hw */
+	/* enable audio after setting up hw */
 	dce_v8_0_audio_enable(adev, dig-&gt;afmt-&gt;pin, true);
 }
 

</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------F0B6F89662D5DD643EC44787--

--===============1929608911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1929608911==--
