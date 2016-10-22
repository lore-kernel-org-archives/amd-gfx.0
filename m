From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/atom: remove a bunch of unused functions
Date: Sat, 22 Oct 2016 19:48:00 +0200
Message-ID: <66ae4441-5037-8a83-9e78-fa03663bf943@vodafone.de>
References: <1477079709-10093-1-git-send-email-alexander.deucher@amd.com>
 <77779d91-8ccd-4809-3630-c15bf7c5682d@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1756458946=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <77779d91-8ccd-4809-3630-c15bf7c5682d-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1756458946==
Content-Type: multipart/alternative;
 boundary="------------F6C798A1B9096DB05FB4FA4F"

This is a multi-part message in MIME format.
--------------F6C798A1B9096DB05FB4FA4F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Am 22.10.2016 um 10:06 schrieb Edward O'Callaghan:
> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>
> On 10/22/2016 06:55 AM, Alex Deucher wrote:
>> Leftovers from the radeon.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 82 ----------------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 10 ----
>>   2 files changed, 92 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>> index 76cbb1d..56a86dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>> @@ -1115,49 +1115,6 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
>>   	return 0;
>>   }
>>   
>> -uint32_t amdgpu_atombios_get_engine_clock(struct amdgpu_device *adev)
>> -{
>> -	GET_ENGINE_CLOCK_PS_ALLOCATION args;
>> -	int index = GetIndexIntoMasterTable(COMMAND, GetEngineClock);
>> -
>> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
>> -	return le32_to_cpu(args.ulReturnEngineClock);
>> -}
>> -
>> -uint32_t amdgpu_atombios_get_memory_clock(struct amdgpu_device *adev)
>> -{
>> -	GET_MEMORY_CLOCK_PS_ALLOCATION args;
>> -	int index = GetIndexIntoMasterTable(COMMAND, GetMemoryClock);
>> -
>> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
>> -	return le32_to_cpu(args.ulReturnMemoryClock);
>> -}
>> -
>> -void amdgpu_atombios_set_engine_clock(struct amdgpu_device *adev,
>> -				      uint32_t eng_clock)
>> -{
>> -	SET_ENGINE_CLOCK_PS_ALLOCATION args;
>> -	int index = GetIndexIntoMasterTable(COMMAND, SetEngineClock);
>> -
>> -	args.ulTargetEngineClock = cpu_to_le32(eng_clock);	/* 10 khz */
>> -
>> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
>> -}
>> -
>> -void amdgpu_atombios_set_memory_clock(struct amdgpu_device *adev,
>> -				      uint32_t mem_clock)
>> -{
>> -	SET_MEMORY_CLOCK_PS_ALLOCATION args;
>> -	int index = GetIndexIntoMasterTable(COMMAND, SetMemoryClock);
>> -
>> -	if (adev->flags & AMD_IS_APU)
>> -		return;
>> -
>> -	args.ulTargetMemoryClock = cpu_to_le32(mem_clock);	/* 10 khz */
>> -
>> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
>> -}
>> -
>>   void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
>>   					     u32 eng_clock, u32 mem_clock)
>>   {
>> @@ -1256,45 +1213,6 @@ int amdgpu_atombios_get_leakage_vddc_based_on_leakage_idx(struct amdgpu_device *
>>   	return amdgpu_atombios_get_max_vddc(adev, VOLTAGE_TYPE_VDDC, leakage_idx, voltage);
>>   }
>>   
>> -void amdgpu_atombios_set_voltage(struct amdgpu_device *adev,
>> -				 u16 voltage_level,
>> -				 u8 voltage_type)
>> -{
>> -	union set_voltage args;
>> -	int index = GetIndexIntoMasterTable(COMMAND, SetVoltage);
>> -	u8 frev, crev, volt_index = voltage_level;
>> -
>> -	if (!amdgpu_atom_parse_cmd_header(adev->mode_info.atom_context, index, &frev, &crev))
>> -		return;
>> -
>> -	/* 0xff01 is a flag rather then an actual voltage */
>> -	if (voltage_level == 0xff01)
>> -		return;
>> -
>> -	switch (crev) {
>> -	case 1:
>> -		args.v1.ucVoltageType = voltage_type;
>> -		args.v1.ucVoltageMode = SET_ASIC_VOLTAGE_MODE_ALL_SOURCE;
>> -		args.v1.ucVoltageIndex = volt_index;
>> -		break;
>> -	case 2:
>> -		args.v2.ucVoltageType = voltage_type;
>> -		args.v2.ucVoltageMode = SET_ASIC_VOLTAGE_MODE_SET_VOLTAGE;
>> -		args.v2.usVoltageLevel = cpu_to_le16(voltage_level);
>> -		break;
>> -	case 3:
>> -		args.v3.ucVoltageType = voltage_type;
>> -		args.v3.ucVoltageMode = ATOM_SET_VOLTAGE;
>> -		args.v3.usVoltageLevel = cpu_to_le16(voltage_level);
>> -		break;
>> -	default:
>> -		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
>> -		return;
>> -	}
>> -
>> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
>> -}
>> -
>>   int amdgpu_atombios_get_leakage_id_from_vbios(struct amdgpu_device *adev,
>>   					      u16 *leakage_id)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
>> index e4afb16..70e9ace 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
>> @@ -163,16 +163,6 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
>>   					    bool strobe_mode,
>>   					    struct atom_mpll_param *mpll_param);
>>   
>> -uint32_t amdgpu_atombios_get_engine_clock(struct amdgpu_device *adev);
>> -uint32_t amdgpu_atombios_get_memory_clock(struct amdgpu_device *adev);
>> -void amdgpu_atombios_set_engine_clock(struct amdgpu_device *adev,
>> -				      uint32_t eng_clock);
>> -void amdgpu_atombios_set_memory_clock(struct amdgpu_device *adev,
>> -				      uint32_t mem_clock);
>> -void amdgpu_atombios_set_voltage(struct amdgpu_device *adev,
>> -				 u16 voltage_level,
>> -				 u8 voltage_type);
>> -
>>   void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
>>   					     u32 eng_clock, u32 mem_clock);
>>   
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------F6C798A1B9096DB05FB4FA4F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Am 22.10.2016 um 10:06 schrieb Edward O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:77779d91-8ccd-4809-3630-c15bf7c5682d-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">Reviewed-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a>

On 10/22/2016 06:55 AM, Alex Deucher wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Leftovers from the radeon.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 82 ----------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 10 ----
 2 files changed, 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 76cbb1d..56a86dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1115,49 +1115,6 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 	return 0;
 }
 
-uint32_t amdgpu_atombios_get_engine_clock(struct amdgpu_device *adev)
-{
-	GET_ENGINE_CLOCK_PS_ALLOCATION args;
-	int index = GetIndexIntoMasterTable(COMMAND, GetEngineClock);
-
-	amdgpu_atom_execute_table(adev-&gt;mode_info.atom_context, index, (uint32_t *)&amp;args);
-	return le32_to_cpu(args.ulReturnEngineClock);
-}
-
-uint32_t amdgpu_atombios_get_memory_clock(struct amdgpu_device *adev)
-{
-	GET_MEMORY_CLOCK_PS_ALLOCATION args;
-	int index = GetIndexIntoMasterTable(COMMAND, GetMemoryClock);
-
-	amdgpu_atom_execute_table(adev-&gt;mode_info.atom_context, index, (uint32_t *)&amp;args);
-	return le32_to_cpu(args.ulReturnMemoryClock);
-}
-
-void amdgpu_atombios_set_engine_clock(struct amdgpu_device *adev,
-				      uint32_t eng_clock)
-{
-	SET_ENGINE_CLOCK_PS_ALLOCATION args;
-	int index = GetIndexIntoMasterTable(COMMAND, SetEngineClock);
-
-	args.ulTargetEngineClock = cpu_to_le32(eng_clock);	/* 10 khz */
-
-	amdgpu_atom_execute_table(adev-&gt;mode_info.atom_context, index, (uint32_t *)&amp;args);
-}
-
-void amdgpu_atombios_set_memory_clock(struct amdgpu_device *adev,
-				      uint32_t mem_clock)
-{
-	SET_MEMORY_CLOCK_PS_ALLOCATION args;
-	int index = GetIndexIntoMasterTable(COMMAND, SetMemoryClock);
-
-	if (adev-&gt;flags &amp; AMD_IS_APU)
-		return;
-
-	args.ulTargetMemoryClock = cpu_to_le32(mem_clock);	/* 10 khz */
-
-	amdgpu_atom_execute_table(adev-&gt;mode_info.atom_context, index, (uint32_t *)&amp;args);
-}
-
 void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
 					     u32 eng_clock, u32 mem_clock)
 {
@@ -1256,45 +1213,6 @@ int amdgpu_atombios_get_leakage_vddc_based_on_leakage_idx(struct amdgpu_device *
 	return amdgpu_atombios_get_max_vddc(adev, VOLTAGE_TYPE_VDDC, leakage_idx, voltage);
 }
 
-void amdgpu_atombios_set_voltage(struct amdgpu_device *adev,
-				 u16 voltage_level,
-				 u8 voltage_type)
-{
-	union set_voltage args;
-	int index = GetIndexIntoMasterTable(COMMAND, SetVoltage);
-	u8 frev, crev, volt_index = voltage_level;
-
-	if (!amdgpu_atom_parse_cmd_header(adev-&gt;mode_info.atom_context, index, &amp;frev, &amp;crev))
-		return;
-
-	/* 0xff01 is a flag rather then an actual voltage */
-	if (voltage_level == 0xff01)
-		return;
-
-	switch (crev) {
-	case 1:
-		args.v1.ucVoltageType = voltage_type;
-		args.v1.ucVoltageMode = SET_ASIC_VOLTAGE_MODE_ALL_SOURCE;
-		args.v1.ucVoltageIndex = volt_index;
-		break;
-	case 2:
-		args.v2.ucVoltageType = voltage_type;
-		args.v2.ucVoltageMode = SET_ASIC_VOLTAGE_MODE_SET_VOLTAGE;
-		args.v2.usVoltageLevel = cpu_to_le16(voltage_level);
-		break;
-	case 3:
-		args.v3.ucVoltageType = voltage_type;
-		args.v3.ucVoltageMode = ATOM_SET_VOLTAGE;
-		args.v3.usVoltageLevel = cpu_to_le16(voltage_level);
-		break;
-	default:
-		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
-		return;
-	}
-
-	amdgpu_atom_execute_table(adev-&gt;mode_info.atom_context, index, (uint32_t *)&amp;args);
-}
-
 int amdgpu_atombios_get_leakage_id_from_vbios(struct amdgpu_device *adev,
 					      u16 *leakage_id)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index e4afb16..70e9ace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -163,16 +163,6 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 					    bool strobe_mode,
 					    struct atom_mpll_param *mpll_param);
 
-uint32_t amdgpu_atombios_get_engine_clock(struct amdgpu_device *adev);
-uint32_t amdgpu_atombios_get_memory_clock(struct amdgpu_device *adev);
-void amdgpu_atombios_set_engine_clock(struct amdgpu_device *adev,
-				      uint32_t eng_clock);
-void amdgpu_atombios_set_memory_clock(struct amdgpu_device *adev,
-				      uint32_t mem_clock);
-void amdgpu_atombios_set_voltage(struct amdgpu_device *adev,
-				 u16 voltage_level,
-				 u8 voltage_type);
-
 void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
 					     u32 eng_clock, u32 mem_clock);
 

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

--------------F6C798A1B9096DB05FB4FA4F--

--===============1756458946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1756458946==--
