From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 00/29] DC Linux Patches Oct 25, 2017
Date: Thu, 26 Oct 2017 23:14:05 -0400
Message-ID: <bf8dcfe1-83f1-9b06-9328-b35058fc3de7@amd.com>
References: <20171026183525.7532-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0229655174=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171026183525.7532-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0229655174==
Content-Type: multipart/alternative;
 boundary="------------769A199109B58F2CCCC2ED5A"

This is a multi-part message in MIME format.
--------------769A199109B58F2CCCC2ED5A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Patches 1,2,6,24-26,28 are

Reviewed-by: Andrey Grodzovsky<andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>


On 2017-10-26 02:34 PM, Harry Wentland wrote:
>   * Remove annoyning Freesync warning
>   * Fix Freesync and amd-stg which was broken in last set of patches
>   * Fix issue with plugging in displays during S3
>   * Bunch of generic fixes found during Raven bringup
>   * Whole bunch of Raven fixes and work
>
> Andrew Jiang (3):
>    drm/amd/display: Reject PPLib clock values if they are invalid
>    drm/amd/display: Use constants from atom.h for HDMI caps read
>    drm/amd/display: Don't reject 3D timings
>
> Anthony Koo (1):
>    drm/amd/display: Move hdr_metadata from plane to stream
>
> Charlene Liu (1):
>    drm/amd/display: correct DP is always in full range or bt609
>
> Dmytro Laktyushkin (2):
>    drm/amd/display: fix split recout calculation
>    drm/amd/display: fix split recout offset
>
> Eric Yang (1):
>    drm/amd/display: Add timing validation against dongle cap
>
> Harry Wentland (7):
>    drm/amdgpu: Remove immutable flag from freesync_capable property
>    drm/amd/display: Move conn_state to header
>    drm/amd/display: Use plane pointer to avoid line breaks
>    drm/amd/display: Use single fail label in init_drm_dev
>    drm/amd/display: Explicitly call ->reset for each object
>    drm/amd/display: Don't access legacy properties
>    drm/amd/display: Fix Freesync enablement
>
> Hersen Wu (1):
>    drm/amd/display: Handle as MST first and then DP dongle if sink
>      support both
>
> Leo (Sunpeng) Li (2):
>    drm/amd/display: Fix styling of freesync code in commit_tail
>    drm/amd/display: Complete TODO item: use new DRM iterator
>
> Roman Li (1):
>    drm/amd/display: Fix S3 topology change
>
> SivapiriyanKumarasamy (1):
>    drm/amd/display: Apply VQ adjustments in MPO case
>
> Tony Cheng (3):
>    drm/amd/display: dal 3.1.08
>    drm/amd/display: dal 3.1.09
>    drm/amd/display: dal 3.1.10
>
> Yongqiang Sun (3):
>    drm/amd/display: Power down front end in init_hw.
>    drm/amd/display: Not reset front end when program back end.
>    drm/amd/display: Added disconnect dchub.
>
> Yue Hin Lau (3):
>    drm/amd/display: create new files for hubbub functions
>    drm/amd/display: create new structure for hubbub
>    drm/amd/display: fix bug from last commit for hubbub
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   2 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 198 ++---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  13 +
>   drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |  68 +-
>   drivers/gpu/drm/amd/display/dc/core/dc.c           |  23 +-
>   drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |   4 +
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 108 ++-
>   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  21 +-
>   drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  51 +-
>   drivers/gpu/drm/amd/display/dc/dc.h                |  44 +-
>   drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   9 +
>   drivers/gpu/drm/amd/display/dc/dc_types.h          |   5 -
>   .../drm/amd/display/dc/dce/dce_stream_encoder.c    |  34 +-
>   .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   3 +-
>   drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |   3 +-
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |  31 +-
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |  47 +-
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |  44 +-
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    | 510 +++++++++++++
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    | 217 ++++++
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |   9 +
>   .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 841 +++++----------------
>   .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |   1 +
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  44 ++
>   .../amd/display/dc/dcn10/dcn10_timing_generator.c  |   3 -
>   drivers/gpu/drm/amd/display/dc/inc/core_status.h   |   2 +-
>   drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   1 +
>   drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |  10 +-
>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |   2 +
>   drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |  14 +
>   drivers/gpu/drm/amd/display/dc/inc/hw/ipp.h        |   6 +-
>   drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |   6 +-
>   32 files changed, 1468 insertions(+), 906 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
>


--------------769A199109B58F2CCCC2ED5A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Patches 1,2,6,24-26,28 are <br>
    </p>
    <pre wrap="">Reviewed-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a></pre>
    <br>
    <div class="moz-cite-prefix">On 2017-10-26 02:34 PM, Harry Wentland
      wrote:<br>
    </div>
    <blockquote cite="mid:20171026183525.7532-1-harry.wentland-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <pre wrap=""> * Remove annoyning Freesync warning
 * Fix Freesync and amd-stg which was broken in last set of patches
 * Fix issue with plugging in displays during S3
 * Bunch of generic fixes found during Raven bringup
 * Whole bunch of Raven fixes and work

Andrew Jiang (3):
  drm/amd/display: Reject PPLib clock values if they are invalid
  drm/amd/display: Use constants from atom.h for HDMI caps read
  drm/amd/display: Don't reject 3D timings

Anthony Koo (1):
  drm/amd/display: Move hdr_metadata from plane to stream

Charlene Liu (1):
  drm/amd/display: correct DP is always in full range or bt609

Dmytro Laktyushkin (2):
  drm/amd/display: fix split recout calculation
  drm/amd/display: fix split recout offset

Eric Yang (1):
  drm/amd/display: Add timing validation against dongle cap

Harry Wentland (7):
  drm/amdgpu: Remove immutable flag from freesync_capable property
  drm/amd/display: Move conn_state to header
  drm/amd/display: Use plane pointer to avoid line breaks
  drm/amd/display: Use single fail label in init_drm_dev
  drm/amd/display: Explicitly call -&gt;reset for each object
  drm/amd/display: Don't access legacy properties
  drm/amd/display: Fix Freesync enablement

Hersen Wu (1):
  drm/amd/display: Handle as MST first and then DP dongle if sink
    support both

Leo (Sunpeng) Li (2):
  drm/amd/display: Fix styling of freesync code in commit_tail
  drm/amd/display: Complete TODO item: use new DRM iterator

Roman Li (1):
  drm/amd/display: Fix S3 topology change

SivapiriyanKumarasamy (1):
  drm/amd/display: Apply VQ adjustments in MPO case

Tony Cheng (3):
  drm/amd/display: dal 3.1.08
  drm/amd/display: dal 3.1.09
  drm/amd/display: dal 3.1.10

Yongqiang Sun (3):
  drm/amd/display: Power down front end in init_hw.
  drm/amd/display: Not reset front end when program back end.
  drm/amd/display: Added disconnect dchub.

Yue Hin Lau (3):
  drm/amd/display: create new files for hubbub functions
  drm/amd/display: create new structure for hubbub
  drm/amd/display: fix bug from last commit for hubbub

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 198 ++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  13 +
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |  68 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  23 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |   4 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 108 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  21 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  51 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  44 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   9 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   5 -
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |  34 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |  31 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |  47 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |  44 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    | 510 +++++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    | 217 ++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |   9 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 841 +++++----------------
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  44 ++
 .../amd/display/dc/dcn10/dcn10_timing_generator.c  |   3 -
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |  10 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |  14 +
 drivers/gpu/drm/amd/display/dc/inc/hw/ipp.h        |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |   6 +-
 32 files changed, 1468 insertions(+), 906 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------769A199109B58F2CCCC2ED5A--

--===============0229655174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0229655174==--
