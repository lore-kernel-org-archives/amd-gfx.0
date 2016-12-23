From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 02/22] drm/amd/display: Refactor to move color helper into
 module
Date: Fri, 23 Dec 2016 09:58:39 -0500
Message-ID: <cd4bc209-31cb-05d2-9e77-63600caa17ab@amd.com>
References: <20161221163016.970-1-harry.wentland@amd.com>
 <20161221163016.970-3-harry.wentland@amd.com>
 <CACiKqBc-FNYgbZ1uVyMiaCr8VXHj1XxsdMJEXMSMot9r29sMsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------4E2A9328E22EF8F7C92E1170"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACiKqBc-FNYgbZ1uVyMiaCr8VXHj1XxsdMJEXMSMot9r29sMsA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Andreas Boll <andreas.boll.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Anthony Koo <anthony.koo-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--------------4E2A9328E22EF8F7C92E1170
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andreas,

On 2016-12-21 12:21 PM, Andreas Boll wrote:
> Hi,
>
> 2016-12-21 17:29 GMT+01:00 Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>:
>> From: Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>
>>
>> Refactor part 2 - Moving color helper into color module
>>
>> The color module will need table defined in the helper in order to calculate
>> the logical regamma curve, and also to fully handle gamut remapping.
>>
>> Change-Id: I826335cd42a9d5d0a872f9206fae83daeb1c45a6
>> Signed-off-by: Anthony Koo <anthony.koo-5C7GfCeVMHo@public.gmane.org>
>> Reviewed-by: Aric Cyr <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>
>> Acked-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  .../drm/amd/display/modules/color/color_helper.c   | 199 +++++++++++++++++++++
>>  .../drm/amd/display/modules/color/color_helper.h   |  50 ++++++
>>  .../gpu/drm/amd/display/modules/inc/mod_color.h    |   4 +-
>>  3 files changed, 251 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/gpu/drm/amd/display/modules/color/color_helper.c
>>  create mode 100644 drivers/gpu/drm/amd/display/modules/color/color_helper.h
>>
>> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_helper.c b/drivers/gpu/drm/amd/display/modules/color/color_helper.c
>> new file mode 100644
>> index 000000000000..c47d2962c6d4
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/display/modules/color/color_helper.c
>> @@ -0,0 +1,199 @@
>> +
>> +/**
>> + *  @file
>> + *  @date Copyright (c) 2008 Advanced Micro Devices, Inc. (unpublished)
>> + *
>> + *  @brief Helper functions for color gamut calculation
>> + *
>> + *  @internal
>> + *  All rights reserved.  This notice is intended as a precaution against
>> + *  inadvertent publication and does not imply publication or any waiver
>> + *  of confidentiality.  The year included in the foregoing notice is the
>> + *  year of creation of the work.
>> + */
>
> This copyright header needs to be fixed.

Thanks for spotting this.

>
>> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_helper.h b/drivers/gpu/drm/amd/display/modules/color/color_helper.h
>> new file mode 100644
>> index 000000000000..c0e6334b947e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/display/modules/color/color_helper.h
>> @@ -0,0 +1,50 @@
>> +/**
>> + *  @file
>> + *  @date Copyright (c) 2008 Advanced Micro Devices, Inc. (unpublished)
>> + *
>> + *  @brief Helper functions for color gamut calculation
>> + *
>> + *  @internal
>> + *  All rights reserved.  This notice is intended as a precaution against
>> + *  inadvertent publication and does not imply publication or any waiver
>> + *  of confidentiality.  The year included in the foregoing notice is the
>> + *  year of creation of the work.
>> + */
>
> same here

All fixed in attached patch.

Harry

>
> Thanks,
> Andreas
>

--------------4E2A9328E22EF8F7C92E1170
Content-Type: text/x-patch;
	name="0010-drm-amd-display-Fix-licensing-header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0010-drm-amd-display-Fix-licensing-header.patch"

>From 536192a936450689fceba2b3867afcbdbac5c776 Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 22 Dec 2016 10:25:57 -0500
Subject: [PATCH 10/14] drm/amd/display: Fix licensing header

Change-Id: I571f298c0b4c01f1df8ebaf020daac3ea8e2974c
Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>
Acked-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
---
 .../drm/amd/display/modules/color/color_helper.c   | 31 +++++++++++++++-------
 .../drm/amd/display/modules/color/color_helper.h   | 30 ++++++++++++++-------
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_helper.c b/drivers/gpu/drm/amd/display/modules/color/color_helper.c
index c47d2962c6d4..ff6779cdd623 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_helper.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_helper.c
@@ -1,15 +1,26 @@
-
-/**
- *  @file
- *  @date Copyright (c) 2008 Advanced Micro Devices, Inc. (unpublished)
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
  *
- *  @brief Helper functions for color gamut calculation
+ * Authors: AMD
  *
- *  @internal
- *  All rights reserved.  This notice is intended as a precaution against
- *  inadvertent publication and does not imply publication or any waiver
- *  of confidentiality.  The year included in the foregoing notice is the
- *  year of creation of the work.
  */
 
 #include "dm_services.h"
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_helper.h b/drivers/gpu/drm/amd/display/modules/color/color_helper.h
index b7a7ca4debd7..76575c1dc043 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_helper.h
+++ b/drivers/gpu/drm/amd/display/modules/color/color_helper.h
@@ -1,14 +1,26 @@
-/**
- *  @file
- *  @date Copyright (c) 2008 Advanced Micro Devices, Inc. (unpublished)
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
  *
- *  @brief Helper functions for color gamut calculation
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
  *
- *  @internal
- *  All rights reserved.  This notice is intended as a precaution against
- *  inadvertent publication and does not imply publication or any waiver
- *  of confidentiality.  The year included in the foregoing notice is the
- *  year of creation of the work.
  */
 
 #ifndef COLOR_MOD_COLOR_HELPER_H_
-- 
2.9.3


--------------4E2A9328E22EF8F7C92E1170
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------4E2A9328E22EF8F7C92E1170--
