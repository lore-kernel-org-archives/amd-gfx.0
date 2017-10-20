From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 00/28] DC Linux Patches Oct 19, 2017
Date: Fri, 20 Oct 2017 11:09:52 -0400
Message-ID: <79c6c0b3-86cb-b4b8-085d-c3d0fca6b093@amd.com>
References: <20171019174647.21260-1-harry.wentland@amd.com>
 <1eda1702-cdd5-ce4d-0093-81f8fe0ebf34@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1114097501=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1eda1702-cdd5-ce4d-0093-81f8fe0ebf34-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "sw.dl.display.sudo" <sw.dl.display.sudo-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1114097501==
Content-Type: multipart/alternative;
 boundary="------------FE731688159D14A5971FFC04"

This is a multi-part message in MIME format.
--------------FE731688159D14A5971FFC04
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

Also just a reminder to submit a follow up to patch 15 to fix memory leak.


Thanks,

Andrey


On 2017-10-20 10:45 AM, Harry Wentland wrote:
> Still looking for Reviewed-by for patches 2, 3, 22-24.
>
> Harry
>
> On 2017-10-19 01:46 PM, Harry Wentland wrote:
>>   * Fixed hotplug issue (mainly on HDMI, but affected DP as well)
>>   * Use new DRM state iterators
>>   * Couple of Dave's cleanups rerolled on new DML
>>   * Bunch of Raven work
>>
>> Anthony Koo (2):
>>    drm/amd/display: Add APU cap in dc_caps
>>    drm/amd/display: DMCU FW loading from PSP
>>
>> Bhawanpreet Lakha (2):
>>    drm/amd/display: Add null check for 24BPP (xfm and dpp)
>>    drm/amd/display: Atomic freesync ASSERT fix
>>
>> Dave Airlie (3):
>>    amdgpu/dc: drop dml_util_is_420
>>    amdgpu/dc: inline dml_round_to_multiple
>>    drm/amd/display: Use DRM new-style object iterators.
>>
>> Harry Wentland (6):
>>    drm/amd/display: Small comment on dc_commit_planes_to_stream
>>    amdgpu/dc: inline a bunch of the dml wrappers.
>>    drm/amd/display: Add bunch of missing license headers in DML
>>    drm/amd/display: Cleanup some fail labels in dcn10_resource
>>    drm/amd/display: Clean some unneeded defines from ddc_service_types.h
>>    drm/amd/display: Explicit casting for grph object ids
>>
>> Jerry Zuo (1):
>>    drm/amd/display: Fix no display on Fiji
>>
>> Leo (Sunpeng) Li (9):
>>    drm/amd/display: Use new DRM API where possible
>>    drm/amd/display: Unify DRM state variable namings.
>>    drm/amd/display: Unify amdgpu_dm state variable namings.
>>    drm/amd/display: Fix typo
>>    drm/amd/display: Remove useless pcrtc pointer
>>    drm/amd/display: Do not release DC state on S3 resume
>>    drm/amd/display: Cleanup code that enables freesync
>>    drm/amd/display: Should disable when new stream is null
>>    drm/amd/display: Only add stream to freesync when modeset required
>>
>> Mikita Lipski (1):
>>    drm/amd/display: Adding DCN1 registers
>>
>> Yongqiang Sun (3):
>>    drm/amd/display: Move lock to front end program.
>>    drm/amd/display: Check cursor address before program.
>>    drm/amd/display: Set cursor position as per address.
>>
>> Yue Hin Lau (1):
>>    drm/amd/display: cleaning up hubp for dcn
>>
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 441 ++++++++++-----------
>>   drivers/gpu/drm/amd/display/dc/core/dc.c           |  60 +--
>>   drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  18 +-
>>   drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
>>   drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      | 176 +++++++-
>>   drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |  12 +-
>>   .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  41 +-
>>   .../drm/amd/display/dc/dce110/dce110_resource.c    |   1 +
>>   .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   2 +
>>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |  16 +-
>>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  | 345 ++++++++--------
>>   .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  26 +-
>>   .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  62 ++-
>>   .../amd/display/dc/dcn10/dcn10_timing_generator.h  |  33 +-
>>   .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |  27 ++
>>   .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |  24 +-
>>   .../drm/amd/display/dc/dml/display_rq_dlg_calc.c   |   2 +
>>   .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |   2 +
>>   .../gpu/drm/amd/display/dc/dml/dml_common_defs.c   | 119 +-----
>>   .../gpu/drm/amd/display/dc/dml/dml_common_defs.h   |  17 -
>>   .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   | 121 ++++++
>>   .../gpu/drm/amd/display/dc/dml/soc_bounding_box.c  |   1 +
>>   drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |  16 +
>>   .../drm/amd/display/include/ddc_service_types.h    |  33 --
>>   .../gpu/drm/amd/display/include/grph_object_id.h   |  12 +-
>>   25 files changed, 894 insertions(+), 714 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------FE731688159D14A5971FFC04
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Reviewed-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E"
        href="mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
    <p>Also just a reminder to submit a follow up to patch 15 to fix
      memory leak.</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2017-10-20 10:45 AM, Harry Wentland
      wrote:<br>
    </div>
    <blockquote cite="mid:1eda1702-cdd5-ce4d-0093-81f8fe0ebf34-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <pre wrap="">Still looking for Reviewed-by for patches 2, 3, 22-24.

Harry

On 2017-10-19 01:46 PM, Harry Wentland wrote:
</pre>
      <blockquote type="cite">
        <pre wrap=""> * Fixed hotplug issue (mainly on HDMI, but affected DP as well)
 * Use new DRM state iterators
 * Couple of Dave's cleanups rerolled on new DML
 * Bunch of Raven work

Anthony Koo (2):
  drm/amd/display: Add APU cap in dc_caps
  drm/amd/display: DMCU FW loading from PSP

Bhawanpreet Lakha (2):
  drm/amd/display: Add null check for 24BPP (xfm and dpp)
  drm/amd/display: Atomic freesync ASSERT fix

Dave Airlie (3):
  amdgpu/dc: drop dml_util_is_420
  amdgpu/dc: inline dml_round_to_multiple
  drm/amd/display: Use DRM new-style object iterators.

Harry Wentland (6):
  drm/amd/display: Small comment on dc_commit_planes_to_stream
  amdgpu/dc: inline a bunch of the dml wrappers.
  drm/amd/display: Add bunch of missing license headers in DML
  drm/amd/display: Cleanup some fail labels in dcn10_resource
  drm/amd/display: Clean some unneeded defines from ddc_service_types.h
  drm/amd/display: Explicit casting for grph object ids

Jerry Zuo (1):
  drm/amd/display: Fix no display on Fiji

Leo (Sunpeng) Li (9):
  drm/amd/display: Use new DRM API where possible
  drm/amd/display: Unify DRM state variable namings.
  drm/amd/display: Unify amdgpu_dm state variable namings.
  drm/amd/display: Fix typo
  drm/amd/display: Remove useless pcrtc pointer
  drm/amd/display: Do not release DC state on S3 resume
  drm/amd/display: Cleanup code that enables freesync
  drm/amd/display: Should disable when new stream is null
  drm/amd/display: Only add stream to freesync when modeset required

Mikita Lipski (1):
  drm/amd/display: Adding DCN1 registers

Yongqiang Sun (3):
  drm/amd/display: Move lock to front end program.
  drm/amd/display: Check cursor address before program.
  drm/amd/display: Set cursor position as per address.

Yue Hin Lau (1):
  drm/amd/display: cleaning up hubp for dcn

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 441 ++++++++++-----------
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  60 +--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  18 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      | 176 +++++++-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |  12 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  41 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |   1 +
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   2 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |  16 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  | 345 ++++++++--------
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  26 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  62 ++-
 .../amd/display/dc/dcn10/dcn10_timing_generator.h  |  33 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |  27 ++
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |  24 +-
 .../drm/amd/display/dc/dml/display_rq_dlg_calc.c   |   2 +
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |   2 +
 .../gpu/drm/amd/display/dc/dml/dml_common_defs.c   | 119 +-----
 .../gpu/drm/amd/display/dc/dml/dml_common_defs.h   |  17 -
 .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   | 121 ++++++
 .../gpu/drm/amd/display/dc/dml/soc_bounding_box.c  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |  16 +
 .../drm/amd/display/include/ddc_service_types.h    |  33 --
 .../gpu/drm/amd/display/include/grph_object_id.h   |  12 +-
 25 files changed, 894 insertions(+), 714 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h

</pre>
      </blockquote>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------FE731688159D14A5971FFC04--

--===============1114097501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1114097501==--
