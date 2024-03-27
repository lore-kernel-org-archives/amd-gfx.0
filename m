Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4917C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 06:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BB710F2E8;
	Wed, 27 Mar 2024 06:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xrCPrFSx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2094.outbound.protection.outlook.com [40.107.94.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7901410F2E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 06:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewhmKK9n4Erfyl4uTg0YXlj6Y9x/rLQMZQ60ed1Qoxt0/EQevg9uVNck1VY87eO086cIz5J0HYV2gqVI+LNwre7IBIrw2FB0JIl57b4WKEDwzhebtj2fND/Ii/IuTsqe3HSkdvcprDRnM14SSdqvXov+bNsNZA1s5nO8u7Oo0gGadgKehiixLS8mh4tLWkuNvbjby3VLi9sVOCMDSqiZfHXaOu2Z67UiIfOXv+4h2a3U+vPF/TsWRpClkla2RlsaPT7dqGC98V/l1WlxiNZBWYNE3Cns8T/eOXeordiqT9faVbqpKtrSt2IHaVx9GIJt7DchEO6iHDLKyEZ8LLWfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEYViZMTmWlc6/BvpL/FN+9o5DeK/IXjlDTAY+pd6bQ=;
 b=d5+AZ5kBc3dBJQLwrxy8KwuEycDbtXnMR5ttWsuE8Ou/3zIE68Y8LZY00AvV4rfaFqBUAZTXJmjdERRKxbu0vX6hdOcZlDkvrRJE2XtcYnblcJ4ayhguQsXcrSlovzxmR0jligNf+4a1NuM7I0oVglCC7AOh3ZYdtHXtsLT0bVcNR+M9tiXzWxoknBYBNS2emyFXNJvRca6tzprQqP2M14+GcjB0psYCqcvohWbfZ68k2dqB5qKPnKPbCuv3S6XEiSlkCf7o84QquRRmO83PfJSesMmIFMoyPOWO0INhgopkXKjMLminTaLGdkNC5u2KZOixYrHY1R1i7LI6w8ulmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEYViZMTmWlc6/BvpL/FN+9o5DeK/IXjlDTAY+pd6bQ=;
 b=xrCPrFSx8j+q7pG0GgYQJnd7NBVja9jVuisPwXtYRXGRZ+FIk3YL275pylgi45rhxxz3XnD5796fe1D5oIbSq2bdZPp+mpyN2VnUeYSwG4hTWlsOvOUT4GysB8/t6iF/6mydeVctB2+sVcwIdFRXHCGWNwS7XrlL3eyy43Uujk4=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Wed, 27 Mar 2024 06:13:16 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 06:13:16 +0000
Message-ID: <dbb77dfd-f227-475f-ab1e-19f97506953e@amd.com>
Date: Wed, 27 Mar 2024 14:13:09 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, hawking.zhang@amd.com, alexander.deucher@amd.com
Subject: Re: [PATCH] drm/amdgpu: make amdgpu device attr_update() function
 more efficient
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240326090255.77211-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <20240326090255.77211-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA0PR12MB4365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9U11gQvaAO3AoS/r3aMiR9J2rAcH1myhr9zVC+KuIsAv6uKRp9us6bJUHJvIsrDcJJfwF7VPvHYqK1IDIXxRNEM7l/nn5CFtsNWbXSvaZ9CHwIduCmoUSpeNlr0SCdSUjoWxdYSD0TV7MP2OhBDmIuz/0V9uArXfjoq7sNK0SjG+mKxpvsk5ubOxDQdvn9EknagpEUmtqq1bJIYkYXoPUP7fyZLgRqPdDiaN1i4RMRMSiVax0kzx4PdmH91i3mxkomirheuzT++/xWT3Fn310hwevJmeHVw8QLmtt2jko2fjjNSXOQSZMzzTwV4fH02ZHRxEm7GAFv7219/sUsMwkh0bE2bou3MvwK7hMPedK3w/z+dmPFAlpNJqnQQX+Bi8Z/M/QfXb6nOJSgcWOgy8505NN//jyFkFXjINQ1tPqUcNmCOw0GwyuemsF+qMYyW+UsbRhvQZmtTsn0rPza4I2dhKLS+HRozqG1iW8GjWeNyiD7aDlYPDJws4Gblg33L5Xm6A3+W/uSDvcgYKcR6gHY+8GK1YpeulXoSjC4cQlHipSXEgPlPqxFSGddQHZ1tn25w/8zbfu7qz78Fs3dyJQwe05t6DKsdp6gcZLNz5sby5UfbR7DaUEs8Awp17TOB3Nw/2Bn0zpayrkdp+cqKI0S6+bNg5oK2FyO8rO6S26+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0pyQ2dYRHVJc1dwUlZOSzJHUjRtY09uK2FDL1ZSTk1mb2trUHVtQVV2N1Yv?=
 =?utf-8?B?NWFWeHUvQ0tHT2NTZjlSdW1jVWFhOGdYZVppbUw3UUhtUk5CdTdqblBBb1kr?=
 =?utf-8?B?Mjh3UVMxaUVIWHRPVW1keVVsZ3RaWnRTNDJIdEVtK2hIZ1NEcEY0dFV0SGph?=
 =?utf-8?B?WmVoUHRreHNPNk0yTngyN1dXdjR1Yk44ckc5MFNONndSMWpwbWxNRTVmT1E5?=
 =?utf-8?B?d3ZpZ0lHOXJvdVpoYnUzSzJPQWVGbldWeVBBb0RVRCtOQmsxVjdRTDB4dkJk?=
 =?utf-8?B?V2pjcnJhM1dVVjU1Z0dDUUZpbmhkUVo0dlZ2RlhZL0hibjJzcm8yamE4L0Rp?=
 =?utf-8?B?V0tXc05oSU9JNy9Nc2ZIMUVlQVJ4YytKY2FQZEJyZS9Dd2pkRzl2Ly9JSWd1?=
 =?utf-8?B?MFhkT0tZN1Y5aHlndEhhNU0xbVRzekxEcHZ5SWRQbmR1SHJmQVlSc3lBMTEv?=
 =?utf-8?B?ZnlsdFBES2tWd3JScjA3VXZLR3JOVUlzZlVlb1dnTHpRK0RKUkorNVJaUk00?=
 =?utf-8?B?Q2RSQXhZeWxweXZEWWZLMGpnbm43VHJ1MEdjdnlySktRN2U1cFRXbjBOUENR?=
 =?utf-8?B?R2RwSndWdU5oYzdldFpDb0FUa2xUeVZnTUtQcVFoaTZhMWdDcmJ4aThOMkFh?=
 =?utf-8?B?MDZQdzBqendVamNtNmtZVXZTakZJcE1rYm10c3A4alhaWk41aW9WQWtiVGhE?=
 =?utf-8?B?MG1lSXhMYWZWU2crVGNzOGE5cDhDUWFrOWVDd3ZOZVNqL3lQNk05S0JENDA4?=
 =?utf-8?B?VVFSTDlUZnpNL2hkQmIzeXlseFR0d2ozSWJGYXlEZjNOeFRFUlZnRm1YZEVS?=
 =?utf-8?B?V0tHWml5NTJiWWNxbGIrSTVYYkQ5d1lvaG5RMk45aHV3RmFqVEVrcEFJN2ZC?=
 =?utf-8?B?VmxVSFY0cnRZK0lqUllIOW1vc05QSllkNnMzOHFzQ0dCcm5wLzBLR09xWFlV?=
 =?utf-8?B?Q0lDUW5SU2YxRldEQjZ5a2hvRlYzaW9ub3JwUkFrQ1hmaWp6Z0haTEF6TEhJ?=
 =?utf-8?B?bEh3WXpXY0VmZVBwV29MUDdsdkRRK0kxMEUxLythQXdXYi9RNTNxZVdEb1ZO?=
 =?utf-8?B?VDVXWDdkMXFFVWlqbmhTeXpKQXk0a1BRcnlqVnJvTEMwVUdvVjl4dnNQOGVN?=
 =?utf-8?B?VGQwWVVBNVRXaW5yejFGVmphZldHY0hVY1BWQ05NT0gyaVZNQmw3T0N2aTVL?=
 =?utf-8?B?VmVyUnoyZmQ0MVZldndRLzNpQm9hYVRzMzJuMnVIUjhyRVhoeWxPVndPMlR5?=
 =?utf-8?B?N1ZuUGt3cjJVU2l6ditKbGl2YnpidUE1ckZpa2dhWTZEZU5xSkRwMnNGcjEr?=
 =?utf-8?B?VEZtM3J0Nm5mRUQ5V1hERUFDd0JEZysvRzRiVHc1N0N3b2dQSVI4ZFpDWDlH?=
 =?utf-8?B?OC9XWGo2LzFxM25TRU9qQUwwTXEwRmg5TVZxOWlpU00vL3hleVMzc2Q5VnIz?=
 =?utf-8?B?M3FJVFNiVlpuSTg0U0RmcFoxUEJyNEZHemx1TWovVnp1c2NJbXRTeGRXYmV4?=
 =?utf-8?B?cmVHYjZGTEZ0dlE3ZU9iSFVvaVFidHBRTGZ5aWNSbkVyeFI2dVpLMllyR2po?=
 =?utf-8?B?L25vYmpWZjhGNGZlMlg3RFhleTgyM0Z0SHlMZTMvV0hJdU41TVQ2SDlUcUNh?=
 =?utf-8?B?UWRiWFN1YVp2REZwcTJiTTZDRy9NWUt5eUptL05xWVk1Z2NJV05sSFYxSFY3?=
 =?utf-8?B?VHVZNDRlcGEraSt6QnVsS0NUL0V1czJHcjYyK052M2daSGRDdVlGa2luTERS?=
 =?utf-8?B?TDd5RzB1U3l4UUVORTNncVlqYzAwbkVKQzVvbW5IajV4NWR3MjFxaEltVlN3?=
 =?utf-8?B?ZnZkUHhVYndpL3IxZFNBSUFKa1pGZEFhTmNhelQrV0dBVmFkOEZvZnhZYnd4?=
 =?utf-8?B?V1VHTXpXdCtscjU2MG1Vb3Z2Tm5CODlLbHB1OERWa0orZ0d5WWVJaEJzQTNE?=
 =?utf-8?B?WjMwMmVNcnUvRWpocDRVODduM3dGR0hNWDl3cVBiWk1HNXlDc1VJcXhrSzlM?=
 =?utf-8?B?YStpcENMSWx6WnRTNzdmN2V0WmcwVTFkYytYOVZoUjgyVjVmSXE3OVFEbStt?=
 =?utf-8?B?dWs2d2YwLzNmSC9ZalExL25zZFJWNy9SS2xhcjFBdkdtRWswbzkvcDZBL1Yv?=
 =?utf-8?Q?O3Y7p6tyKWkUg/UX4u+NVA+u0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb161856-7e32-48c0-24e7-08dc4e24fdcb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 06:13:16.6446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27eS+sOXFqlWJBk2CPN/Gn4uGdtrLAfZ2k6jtmH+SAzuo+X3Oy2hfks07/sbmY9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Reviewed-by: Ma Jun <majun@amd.com>

On 3/26/2024 5:02 PM, Yang Wang wrote:
> add a new enumeration type to identify device attribute node,
> this method is relatively more efficient compared with 'strcmp' in
> update_attr() function.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c     |  4 +--
>  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 41 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 85e935556d7d..04f53f2667fe 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2226,16 +2226,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  			       uint32_t mask, enum amdgpu_device_attr_states *states)
>  {
>  	struct device_attribute *dev_attr = &attr->dev_attr;
> +	enum amdgpu_device_attr_type type = attr->type;
>  	uint32_t mp1_ver = amdgpu_ip_version(adev, MP1_HWIP, 0);
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> -	const char *attr_name = dev_attr->attr.name;
>  
>  	if (!(attr->flags & mask)) {
>  		*states = ATTR_STATE_UNSUPPORTED;
>  		return 0;
>  	}
>  
> -#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
> +#define DEVICE_ATTR_IS(_name)		(type == device_attr_type__##_name)
>  
>  	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>  		if (gc_ver < IP_VERSION(9, 0, 0))
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> index eec816f0cbf9..157330c379be 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -43,8 +43,48 @@ enum amdgpu_device_attr_states {
>  	ATTR_STATE_SUPPORTED,
>  };
>  
> +enum amdgpu_device_attr_type {
> +	device_attr_type__unknown = -1,
> +	device_attr_type__power_dpm_state = 0,
> +	device_attr_type__power_dpm_force_performance_level,
> +	device_attr_type__pp_num_states,
> +	device_attr_type__pp_cur_state,
> +	device_attr_type__pp_force_state,
> +	device_attr_type__pp_table,
> +	device_attr_type__pp_dpm_sclk,
> +	device_attr_type__pp_dpm_mclk,
> +	device_attr_type__pp_dpm_socclk,
> +	device_attr_type__pp_dpm_fclk,
> +	device_attr_type__pp_dpm_vclk,
> +	device_attr_type__pp_dpm_vclk1,
> +	device_attr_type__pp_dpm_dclk,
> +	device_attr_type__pp_dpm_dclk1,
> +	device_attr_type__pp_dpm_dcefclk,
> +	device_attr_type__pp_dpm_pcie,
> +	device_attr_type__pp_sclk_od,
> +	device_attr_type__pp_mclk_od,
> +	device_attr_type__pp_power_profile_mode,
> +	device_attr_type__pp_od_clk_voltage,
> +	device_attr_type__gpu_busy_percent,
> +	device_attr_type__mem_busy_percent,
> +	device_attr_type__vcn_busy_percent,
> +	device_attr_type__pcie_bw,
> +	device_attr_type__pp_features,
> +	device_attr_type__unique_id,
> +	device_attr_type__thermal_throttling_logging,
> +	device_attr_type__apu_thermal_cap,
> +	device_attr_type__gpu_metrics,
> +	device_attr_type__smartshift_apu_power,
> +	device_attr_type__smartshift_dgpu_power,
> +	device_attr_type__smartshift_bias,
> +	device_attr_type__xgmi_plpd_policy,
> +	device_attr_type__pm_metrics,
> +	device_attr_type__count,
> +};
> +
>  struct amdgpu_device_attr {
>  	struct device_attribute dev_attr;
> +	enum amdgpu_device_attr_type type;
>  	enum amdgpu_device_attr_flags flags;
>  	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
>  			   uint32_t mask, enum amdgpu_device_attr_states *states);
> @@ -61,6 +101,7 @@ struct amdgpu_device_attr_entry {
>  
>  #define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
>  	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
> +	  .type = device_attr_type__##_name,				\
>  	  .flags = _flags,						\
>  	  ##__VA_ARGS__, }
>  
