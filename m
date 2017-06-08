From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx: create a common bitmask function (v2)
Date: Thu, 8 Jun 2017 09:20:14 +0200
Message-ID: <ff35985a-bfb4-768d-5c26-b5bbb23e2249@vodafone.de>
References: <1496787583-2883-1-git-send-email-alexander.deucher@amd.com>
 <2e78fcdb-42d8-625b-f1cb-ac92eff8bec9@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1338495253=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2e78fcdb-42d8-625b-f1cb-ac92eff8bec9-5C7GfCeVMHo@public.gmane.org>
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
To: axie <axie-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1338495253==
Content-Type: multipart/alternative;
 boundary="------------8C381A31B41F0EA7A5B82C73"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8C381A31B41F0EA7A5B82C73
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Actually we should only use static inline if we have to, see "15) The 
inline disease" in the coding style document, but for this case it 
actually looks valid to me as well.

But wasn't there a macro for this in the Linux kernel headers we should use?

Regards,
Christian.

Am 07.06.2017 um 00:36 schrieb axie:
>
> Thanks for the change. "static inline" may improve speed, though this 
> patch is not a critical code path. Perhaps it will be true in future...
>
> Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
>
>
> On 2017-06-06 06:19 PM, Alex Deucher wrote:
>> The same function was duplicated in all the gfx IPs. Use
>> a single implementation for all.
>>
>> v2: use static inline (Alex Xie)
>>
>> Suggested-by: Andres Rodriguez<andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Alex Deucher<alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 13 +++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   | 11 +++--------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 19 +++----------------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 11 +++--------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 11 +++--------
>>   5 files changed, 25 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index e0204408..2d846ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -30,4 +30,17 @@ void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
>>   void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
>>   		unsigned max_sh);
>>   
>> +/**
>> + * amdgpu_gfx_create_bitmask - create a bitmask
>> + *
>> + * @bit_width: length of the mask
>> + *
>> + * create a variable length bit mask.
>> + * Returns the bitmask.
>> + */
>> +static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
>> +{
>> +	return (u32)((1ULL << bit_width) - 1);
>> +}
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> index f3e0edd..cfd3df6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> @@ -1116,11 +1116,6 @@ static void gfx_v6_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
>>   	WREG32(mmGRBM_GFX_INDEX, data);
>>   }
>>   
>> -static u32 gfx_v6_0_create_bitmask(u32 bit_width)
>> -{
>> -	return (u32)(((u64)1 << bit_width) - 1);
>> -}
>> -
>>   static u32 gfx_v6_0_get_rb_active_bitmap(struct amdgpu_device *adev)
>>   {
>>   	u32 data, mask;
>> @@ -1130,8 +1125,8 @@ static u32 gfx_v6_0_get_rb_active_bitmap(struct amdgpu_device *adev)
>>   
>>   	data = REG_GET_FIELD(data, GC_USER_RB_BACKEND_DISABLE, BACKEND_DISABLE);
>>   
>> -	mask = gfx_v6_0_create_bitmask(adev->gfx.config.max_backends_per_se/
>> -					adev->gfx.config.max_sh_per_se);
>> +	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se/
>> +					 adev->gfx.config.max_sh_per_se);
>>   
>>   	return ~data & mask;
>>   }
>> @@ -1333,7 +1328,7 @@ static u32 gfx_v6_0_get_cu_enabled(struct amdgpu_device *adev)
>>   	data = RREG32(mmCC_GC_SHADER_ARRAY_CONFIG) |
>>   		RREG32(mmGC_USER_SHADER_ARRAY_CONFIG);
>>   
>> -	mask = gfx_v6_0_create_bitmask(adev->gfx.config.max_cu_per_sh);
>> +	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh);
>>   	return ~REG_GET_FIELD(data, CC_GC_SHADER_ARRAY_CONFIG, INACTIVE_CUS) & mask;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index ae98611..4c04e9d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -1608,19 +1608,6 @@ static void gfx_v7_0_select_se_sh(struct amdgpu_device *adev,
>>   }
>>   
>>   /**
>> - * gfx_v7_0_create_bitmask - create a bitmask
>> - *
>> - * @bit_width: length of the mask
>> - *
>> - * create a variable length bit mask (CIK).
>> - * Returns the bitmask.
>> - */
>> -static u32 gfx_v7_0_create_bitmask(u32 bit_width)
>> -{
>> -	return (u32)((1ULL << bit_width) - 1);
>> -}
>> -
>> -/**
>>    * gfx_v7_0_get_rb_active_bitmap - computes the mask of enabled RBs
>>    *
>>    * @adev: amdgpu_device pointer
>> @@ -1638,8 +1625,8 @@ static u32 gfx_v7_0_get_rb_active_bitmap(struct amdgpu_device *adev)
>>   	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
>>   	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
>>   
>> -	mask = gfx_v7_0_create_bitmask(adev->gfx.config.max_backends_per_se /
>> -				       adev->gfx.config.max_sh_per_se);
>> +	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
>> +					 adev->gfx.config.max_sh_per_se);
>>   
>>   	return (~data) & mask;
>>   }
>> @@ -4157,7 +4144,7 @@ static u32 gfx_v7_0_get_cu_active_bitmap(struct amdgpu_device *adev)
>>   	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS_MASK;
>>   	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS__SHIFT;
>>   
>> -	mask = gfx_v7_0_create_bitmask(adev->gfx.config.max_cu_per_sh);
>> +	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh);
>>   
>>   	return (~data) & mask;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index afd7d65..ad2e0bb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -3635,11 +3635,6 @@ static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
>>   	WREG32(mmGRBM_GFX_INDEX, data);
>>   }
>>   
>> -static u32 gfx_v8_0_create_bitmask(u32 bit_width)
>> -{
>> -	return (u32)((1ULL << bit_width) - 1);
>> -}
>> -
>>   static u32 gfx_v8_0_get_rb_active_bitmap(struct amdgpu_device *adev)
>>   {
>>   	u32 data, mask;
>> @@ -3649,8 +3644,8 @@ static u32 gfx_v8_0_get_rb_active_bitmap(struct amdgpu_device *adev)
>>   
>>   	data = REG_GET_FIELD(data, GC_USER_RB_BACKEND_DISABLE, BACKEND_DISABLE);
>>   
>> -	mask = gfx_v8_0_create_bitmask(adev->gfx.config.max_backends_per_se /
>> -				       adev->gfx.config.max_sh_per_se);
>> +	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
>> +					 adev->gfx.config.max_sh_per_se);
>>   
>>   	return (~data) & mask;
>>   }
>> @@ -7150,7 +7145,7 @@ static u32 gfx_v8_0_get_cu_active_bitmap(struct amdgpu_device *adev)
>>   	data =  RREG32(mmCC_GC_SHADER_ARRAY_CONFIG) |
>>   		RREG32(mmGC_USER_SHADER_ARRAY_CONFIG);
>>   
>> -	mask = gfx_v8_0_create_bitmask(adev->gfx.config.max_cu_per_sh);
>> +	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh);
>>   
>>   	return ~REG_GET_FIELD(data, CC_GC_SHADER_ARRAY_CONFIG, INACTIVE_CUS) & mask;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 276dc06..cf15a350 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -1698,11 +1698,6 @@ static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh
>>   	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
>>   }
>>   
>> -static u32 gfx_v9_0_create_bitmask(u32 bit_width)
>> -{
>> -	return (u32)((1ULL << bit_width) - 1);
>> -}
>> -
>>   static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
>>   {
>>   	u32 data, mask;
>> @@ -1713,8 +1708,8 @@ static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
>>   	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
>>   	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
>>   
>> -	mask = gfx_v9_0_create_bitmask(adev->gfx.config.max_backends_per_se /
>> -				       adev->gfx.config.max_sh_per_se);
>> +	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
>> +					 adev->gfx.config.max_sh_per_se);
>>   
>>   	return (~data) & mask;
>>   }
>> @@ -4609,7 +4604,7 @@ static u32 gfx_v9_0_get_cu_active_bitmap(struct amdgpu_device *adev)
>>   	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS_MASK;
>>   	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS__SHIFT;
>>   
>> -	mask = gfx_v9_0_create_bitmask(adev->gfx.config.max_cu_per_sh);
>> +	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh);
>>   
>>   	return (~data) & mask;
>>   }
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------8C381A31B41F0EA7A5B82C73
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Actually we should only use static
      inline if we have to, see "15) The inline disease" in the coding
      style document, but for this case it actually looks valid to me as
      well.<br>
      <br>
      But wasn't there a macro for this in the Linux kernel headers we
      should use?<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 07.06.2017 um 00:36 schrieb axie:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2e78fcdb-42d8-625b-f1cb-ac92eff8bec9-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p>Thanks for the change. "static inline" may improve speed,
        though this patch is not a critical code path. Perhaps it will
        be true in future...<br>
      </p>
      <p>Reviewed-by: Alex Xie <a class="moz-txt-link-rfc2396E"
          href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
      <br>
      <div class="moz-cite-prefix">On 2017-06-06 06:19 PM, Alex Deucher
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:1496787583-2883-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
        <pre wrap="">The same function was duplicated in all the gfx IPs. Use
a single implementation for all.

v2: use static inline (Alex Xie)

Suggested-by: Andres Rodriguez <a class="moz-txt-link-rfc2396E" href="mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" moz-do-not-send="true">&lt;andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   | 11 +++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 19 +++----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 11 +++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 11 +++--------
 5 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index e0204408..2d846ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -30,4 +30,17 @@ void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
 		unsigned max_sh);
 
+/**
+ * amdgpu_gfx_create_bitmask - create a bitmask
+ *
+ * @bit_width: length of the mask
+ *
+ * create a variable length bit mask.
+ * Returns the bitmask.
+ */
+static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
+{
+	return (u32)((1ULL &lt;&lt; bit_width) - 1);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index f3e0edd..cfd3df6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1116,11 +1116,6 @@ static void gfx_v6_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	WREG32(mmGRBM_GFX_INDEX, data);
 }
 
-static u32 gfx_v6_0_create_bitmask(u32 bit_width)
-{
-	return (u32)(((u64)1 &lt;&lt; bit_width) - 1);
-}
-
 static u32 gfx_v6_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 {
 	u32 data, mask;
@@ -1130,8 +1125,8 @@ static u32 gfx_v6_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 
 	data = REG_GET_FIELD(data, GC_USER_RB_BACKEND_DISABLE, BACKEND_DISABLE);
 
-	mask = gfx_v6_0_create_bitmask(adev-&gt;gfx.config.max_backends_per_se/
-					adev-&gt;gfx.config.max_sh_per_se);
+	mask = amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_backends_per_se/
+					 adev-&gt;gfx.config.max_sh_per_se);
 
 	return ~data &amp; mask;
 }
@@ -1333,7 +1328,7 @@ static u32 gfx_v6_0_get_cu_enabled(struct amdgpu_device *adev)
 	data = RREG32(mmCC_GC_SHADER_ARRAY_CONFIG) |
 		RREG32(mmGC_USER_SHADER_ARRAY_CONFIG);
 
-	mask = gfx_v6_0_create_bitmask(adev-&gt;gfx.config.max_cu_per_sh);
+	mask = amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_cu_per_sh);
 	return ~REG_GET_FIELD(data, CC_GC_SHADER_ARRAY_CONFIG, INACTIVE_CUS) &amp; mask;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index ae98611..4c04e9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1608,19 +1608,6 @@ static void gfx_v7_0_select_se_sh(struct amdgpu_device *adev,
 }
 
 /**
- * gfx_v7_0_create_bitmask - create a bitmask
- *
- * @bit_width: length of the mask
- *
- * create a variable length bit mask (CIK).
- * Returns the bitmask.
- */
-static u32 gfx_v7_0_create_bitmask(u32 bit_width)
-{
-	return (u32)((1ULL &lt;&lt; bit_width) - 1);
-}
-
-/**
  * gfx_v7_0_get_rb_active_bitmap - computes the mask of enabled RBs
  *
  * @adev: amdgpu_device pointer
@@ -1638,8 +1625,8 @@ static u32 gfx_v7_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 	data &amp;= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
 	data &gt;&gt;= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
 
-	mask = gfx_v7_0_create_bitmask(adev-&gt;gfx.config.max_backends_per_se /
-				       adev-&gt;gfx.config.max_sh_per_se);
+	mask = amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_backends_per_se /
+					 adev-&gt;gfx.config.max_sh_per_se);
 
 	return (~data) &amp; mask;
 }
@@ -4157,7 +4144,7 @@ static u32 gfx_v7_0_get_cu_active_bitmap(struct amdgpu_device *adev)
 	data &amp;= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS_MASK;
 	data &gt;&gt;= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS__SHIFT;
 
-	mask = gfx_v7_0_create_bitmask(adev-&gt;gfx.config.max_cu_per_sh);
+	mask = amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_cu_per_sh);
 
 	return (~data) &amp; mask;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index afd7d65..ad2e0bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3635,11 +3635,6 @@ static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
 	WREG32(mmGRBM_GFX_INDEX, data);
 }
 
-static u32 gfx_v8_0_create_bitmask(u32 bit_width)
-{
-	return (u32)((1ULL &lt;&lt; bit_width) - 1);
-}
-
 static u32 gfx_v8_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 {
 	u32 data, mask;
@@ -3649,8 +3644,8 @@ static u32 gfx_v8_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 
 	data = REG_GET_FIELD(data, GC_USER_RB_BACKEND_DISABLE, BACKEND_DISABLE);
 
-	mask = gfx_v8_0_create_bitmask(adev-&gt;gfx.config.max_backends_per_se /
-				       adev-&gt;gfx.config.max_sh_per_se);
+	mask = amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_backends_per_se /
+					 adev-&gt;gfx.config.max_sh_per_se);
 
 	return (~data) &amp; mask;
 }
@@ -7150,7 +7145,7 @@ static u32 gfx_v8_0_get_cu_active_bitmap(struct amdgpu_device *adev)
 	data =  RREG32(mmCC_GC_SHADER_ARRAY_CONFIG) |
 		RREG32(mmGC_USER_SHADER_ARRAY_CONFIG);
 
-	mask = gfx_v8_0_create_bitmask(adev-&gt;gfx.config.max_cu_per_sh);
+	mask = amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_cu_per_sh);
 
 	return ~REG_GET_FIELD(data, CC_GC_SHADER_ARRAY_CONFIG, INACTIVE_CUS) &amp; mask;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 276dc06..cf15a350 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1698,11 +1698,6 @@ static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh
 	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 }
 
-static u32 gfx_v9_0_create_bitmask(u32 bit_width)
-{
-	return (u32)((1ULL &lt;&lt; bit_width) - 1);
-}
-
 static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 {
 	u32 data, mask;
@@ -1713,8 +1708,8 @@ static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 	data &amp;= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
 	data &gt;&gt;= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
 
-	mask = gfx_v9_0_create_bitmask(adev-&gt;gfx.config.max_backends_per_se /
-				       adev-&gt;gfx.config.max_sh_per_se);
+	mask = amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_backends_per_se /
+					 adev-&gt;gfx.config.max_sh_per_se);
 
 	return (~data) &amp; mask;
 }
@@ -4609,7 +4604,7 @@ static u32 gfx_v9_0_get_cu_active_bitmap(struct amdgpu_device *adev)
 	data &amp;= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS_MASK;
 	data &gt;&gt;= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS__SHIFT;
 
-	mask = gfx_v9_0_create_bitmask(adev-&gt;gfx.config.max_cu_per_sh);
+	mask = amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_cu_per_sh);
 
 	return (~data) &amp; mask;
 }
</pre>
      </blockquote>
      <br>
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

--------------8C381A31B41F0EA7A5B82C73--

--===============1338495253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1338495253==--
