From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 0/3] rename file name.
Date: Mon, 12 Sep 2016 12:43:13 +0200
Message-ID: <256e828c-d1de-cef4-ca9a-57f5e931d208@vodafone.de>
References: <1473668574-20741-1-git-send-email-Rex.Zhu@amd.com>
 <72421e99-8be2-9db4-7aa4-b5d3a7639a49@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0026240481=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <72421e99-8be2-9db4-7aa4-b5d3a7639a49-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0026240481==
Content-Type: multipart/alternative;
 boundary="------------8CA5F835F95E69B6FB3972E4"

This is a multi-part message in MIME format.
--------------8CA5F835F95E69B6FB3972E4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.09.2016 um 10:36 schrieb Edward O'Callaghan:
> This series is,
> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org> for the series.

>
> On 09/12/2016 06:22 PM, Rex Zhu wrote:
>> As tonga/fiji/polaris10/11 use ppt table version 1.
>> so rename tonga_processtable to process_pptables_v1_0
>>
>>
>> Rex Zhu (3):
>>    drm/amd/powerplay: rename tonga_processpptable* to
>>      processpptable_v1_0*.
>>    drm/amd/powerplay: add pp_table_version in hwmgr.
>>    drm/amd/powerplay: add pptable point check before use it
>>
>>   drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    2 +-
>>   drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c   |   10 +-
>>   drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |    4 +-
>>   .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c  |   10 +-
>>   drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h |  436 +++++++
>>   .../amd/powerplay/hwmgr/process_pptables_v1_0.c    | 1326 ++++++++++++++++++++
>>   .../amd/powerplay/hwmgr/process_pptables_v1_0.h    |   35 +
>>   drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c  |   10 +-
>>   .../gpu/drm/amd/powerplay/hwmgr/tonga_pptable.h    |  436 -------
>>   .../amd/powerplay/hwmgr/tonga_processpptables.c    | 1326 --------------------
>>   .../amd/powerplay/hwmgr/tonga_processpptables.h    |   35 -
>>   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    8 +
>>   12 files changed, 1824 insertions(+), 1814 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
>>   create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
>>   create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.h
>>   delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_pptable.h
>>   delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_processpptables.c
>>   delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_processpptables.h
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------8CA5F835F95E69B6FB3972E4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 12.09.2016 um 10:36 schrieb Edward
      O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:72421e99-8be2-9db4-7aa4-b5d3a7639a49-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">This series is,
Reviewed-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a></pre>
    </blockquote>
    <br>
    Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> for the
    series.<br>
    <br>
    <blockquote
      cite="mid:72421e99-8be2-9db4-7aa4-b5d3a7639a49-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">

On 09/12/2016 06:22 PM, Rex Zhu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">As tonga/fiji/polaris10/11 use ppt table version 1.
so rename tonga_processtable to process_pptables_v1_0 


Rex Zhu (3):
  drm/amd/powerplay: rename tonga_processpptable* to
    processpptable_v1_0*.
  drm/amd/powerplay: add pp_table_version in hwmgr.
  drm/amd/powerplay: add pptable point check before use it

 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c   |   10 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |    4 +-
 .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c  |   10 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h |  436 +++++++
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    | 1326 ++++++++++++++++++++
 .../amd/powerplay/hwmgr/process_pptables_v1_0.h    |   35 +
 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c  |   10 +-
 .../gpu/drm/amd/powerplay/hwmgr/tonga_pptable.h    |  436 -------
 .../amd/powerplay/hwmgr/tonga_processpptables.c    | 1326 --------------------
 .../amd/powerplay/hwmgr/tonga_processpptables.h    |   35 -
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    8 +
 12 files changed, 1824 insertions(+), 1814 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_pptable.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_processpptables.c
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_processpptables.h

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

--------------8CA5F835F95E69B6FB3972E4--

--===============0026240481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0026240481==--
