From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH drm/amdgpu] Fix indentation in
 dce_v8_0_audio_write_sad_regs()
Date: Mon, 22 Aug 2016 09:52:40 +0200
Message-ID: <c834bb0d-39b7-cf4b-ac76-819b69934f5d@vodafone.de>
References: <20160822003826.16418-1-alexandre.f.demers@gmail.com>
 <c67885c8-c2dc-3628-75b2-800384a43a96@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0016715311=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c67885c8-c2dc-3628-75b2-800384a43a96-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
--===============0016715311==
Content-Type: multipart/alternative;
 boundary="------------352E8959C921FAE3F5F07BED"

This is a multi-part message in MIME format.
--------------352E8959C921FAE3F5F07BED
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.08.2016 um 02:41 schrieb Edward O'Callaghan:
> On 08/22/2016 10:38 AM, Alexandre Demers wrote:
>> Fixed indentation for readability.
>>
>> Signed-off-by: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> index 3ff1258..c7e5d5f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> @@ -1501,13 +1501,13 @@ static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
>>   
>>   			if (sad->format == eld_reg_to_type[i][1]) {
>>   				if (sad->channels > max_channels) {
>> -				value = (sad->channels <<
>> -				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SHIFT) |
>> -				(sad->byte2 <<
>> -				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_2__SHIFT) |
>> -				(sad->freq <<
>> -				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENCIES__SHIFT);
>> -				max_channels = sad->channels;
>> +					value = (sad->channels <<
>> +						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SHIFT) |
>> +					        (sad->byte2 <<
>> +						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_2__SHIFT) |
>> +					        (sad->freq <<
>> +						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENCIES__SHIFT);
>> +					max_channels = sad->channels;
>>   				}
>>   
>>   				if (sad->format == HDMI_AUDIO_CODING_TYPE_PCM)
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------352E8959C921FAE3F5F07BED
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
      cite="mid:c67885c8-c2dc-3628-75b2-800384a43a96-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">
On 08/22/2016 10:38 AM, Alexandre Demers wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Fixed indentation for readability.

Signed-off-by: Alexandre Demers <a class="moz-txt-link-rfc2396E" href="mailto:alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
</pre>
      </blockquote>
      <pre wrap="">Reviewed-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a></pre>
    </blockquote>
    <br>
    Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
    <br>
    <blockquote
      cite="mid:c67885c8-c2dc-3628-75b2-800384a43a96-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 3ff1258..c7e5d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1501,13 +1501,13 @@ static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 
 			if (sad-&gt;format == eld_reg_to_type[i][1]) {
 				if (sad-&gt;channels &gt; max_channels) {
-				value = (sad-&gt;channels &lt;&lt;
-				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SHIFT) |
-				(sad-&gt;byte2 &lt;&lt;
-				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_2__SHIFT) |
-				(sad-&gt;freq &lt;&lt;
-				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENCIES__SHIFT);
-				max_channels = sad-&gt;channels;
+					value = (sad-&gt;channels &lt;&lt;
+						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SHIFT) |
+					        (sad-&gt;byte2 &lt;&lt;
+						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_2__SHIFT) |
+					        (sad-&gt;freq &lt;&lt;
+						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENCIES__SHIFT);
+					max_channels = sad-&gt;channels;
 				}
 
 				if (sad-&gt;format == HDMI_AUDIO_CODING_TYPE_PCM)

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

--------------352E8959C921FAE3F5F07BED--

--===============0016715311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0016715311==--
