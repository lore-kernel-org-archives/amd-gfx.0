Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D88C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 11:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D788710E112;
	Mon, 13 May 2024 11:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VkTykIVa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9618810E112
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 11:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGLDSpzh6LpXuk6SjqD3M7Ta3YU2uWrobfBfiN72rfTfv8rMkJ0dS+Pm+PwpunHgIIEvgxaSPSflK4B2OjeLWg5335vv2z8z1rHBLMKBOP2I8n20wC/BVlcgdttSF201N3Y/sVHBvDGEAWLOoSIIC6+3N7Z8PSRJT/tyBCeuABkkjFaT/gUBDqYH7W+Vilf6/TRHwuW1Q4PAx3WNHn480THjIfap7w/Tr/teqmGXJAiYqq3AsKi5kO4mdg+hKoh+ARnRSq4oiRC8ziy2+unajrGHwT4/LDuwmIqm3S4BYASxwkqXeA3iCVT5FRyzAJ9c+DY4ahUkze/ZuZSjxs6oFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxDyYs6xlfU5vsHoCLMI4BN8iVW3c04gaW4sp1UiO84=;
 b=ff48IahrnUlVPuPtMpaC8JKISqNLWwTqmHMnnrzgJrju029e6B9fc+Ltbr//N2/x5RFzZrc5doSMZ18lwBsfnB8HQkAPV0iQh8pJ/n/VFhqpI0F+eo5Z5XPjSjpD4XYgA7jIQ0pJNWl6m+vdkDC9DzTyZPhZ8jMxvjftDNkzFKVeVBmfAqjVkvqLNOcmln2JTPVQ0KHpC8RfFYzwGVpj2edxsCYBD3QAvhEmCgaFCSV3ktOtogtBy8100rQFqxSetyvddZbPHzwODjNUmXxo/4P3DMHQjNvpA8IxYXbVsSYVqMlX+hD18b9SZ2YZPQzc7l3rI+UC3uk3+w4ug1nFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxDyYs6xlfU5vsHoCLMI4BN8iVW3c04gaW4sp1UiO84=;
 b=VkTykIVaS7ph00l2XY1SgSBPEUiIGBh/BTTW2gr7xpD+C6w8Lhix8NHnZDYsjZAlCk+PXotxZ29J2kq3v1GttoO1MvehajnceDaJId7WQcy/3KFh9UwcRPjLBgqlLqAVnSWFZmJ9PZk2KbkVfhLPUyKQ8loBhdl4Hi4X6pDLo/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:08:21 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:08:21 +0000
Message-ID: <a45c7e08-2a8b-46fd-9be1-45079c72b70c@amd.com>
Date: Mon, 13 May 2024 07:06:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't register panel_power_savings on
 OLED panels
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Gergo Koteles <soyer@irl.hu>
References: <20240509170524.34811-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240509170524.34811-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 693b68c7-df7b-4f7c-d816-08dc733cffbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b05FNXAvcWw2V25PSkdPT0xuZXA0c2FpNWxOVnRCekJNa3VNZ0pmVWxtbFBs?=
 =?utf-8?B?aDVhQmZGZlROS001REhKSnNzVndoTzA3eUtQZzlBSS9jdnNYK2tWVDBvc1lv?=
 =?utf-8?B?cUZoU2NTb3FhTE12NFdERWJRUmZVczVxSG5oNFpud3ppZ2VaTlQzNFM1U29p?=
 =?utf-8?B?blRXSHFuSjdBZHVPUUJ0SVRqdENEWUU4SW1jSHVDejdkU0NyYW9zWnhrVnVx?=
 =?utf-8?B?ZlhDbjQ3OW4xUHV4dEg3RkZDSVlMR0luWG9HcjBCcHc3b3pmUncyM1dxbHFi?=
 =?utf-8?B?T0FCdkt1ejFRU1gvWTB5Y3UvS05COTd4U3M3a1BzOGEraXN0MW8zMnI3R2Yy?=
 =?utf-8?B?T3dwbzI3LzFHT0tvRVJIUzdDc2ZJeDdKNW5KbFRKYUV4SWZlQVRjSHRKOVlz?=
 =?utf-8?B?Tm82RkJFQXZBNEVoRXJjTGltVUFKTU13SlhJTExIUmF4cU0xS1VzT3JFK09s?=
 =?utf-8?B?Ny9ObjB4T3dod0R0TUlkZE95ekY3Ky9BR3lCdUIweUlPUENrUE9ZdHI0QnZL?=
 =?utf-8?B?amFadTRwalY1MGtCSThyNHJjS0s5V3pDekhuRW9IYkNFbVdqejVZaERvdmNp?=
 =?utf-8?B?d3VHbVVWS3dWN2JwQ0piaHdjZHB4c0lvR3h2RDM0Z282UnppZkQzcTBCcUgz?=
 =?utf-8?B?TUNKVDdCcGxYUldrLzA5SjdQUkkrU1hMa3l5QzlKRU1pWm1nWnIvSGJ3Y2E4?=
 =?utf-8?B?b0I5cVhoYUNzdGg2S1VWRmV1OUhqbnJkNFZVaHVmY2JGVWJUQXBwd01tRGxs?=
 =?utf-8?B?dllaZFJrRHdsRjAzNnFGenFkbHgvRjBxSG5CYnV4c0pUWlVRMjhSREZ5ZDEy?=
 =?utf-8?B?TU43MlZzem9vdExGNyt1cmpodTYxd3c1T2VzZ3ZwS3hkTjNQNGdyT1hOUHBI?=
 =?utf-8?B?ajRBOE1CSkM3dVFDVzBNd3p1VUxmRC95S0RoTUhDM0NCZ09VV0M0eU4rayt5?=
 =?utf-8?B?bjFiK01hRWY3YWRqSnZIMlgyY3o1elhHNFhVZmZmOGo1ejVaRTMvVXUyMWpZ?=
 =?utf-8?B?VXhGSVJRc3FJMkdyd0l6cVJWS09sMk9TTkd0YTA2N1p2RGRIM1Q5WWlnZXJG?=
 =?utf-8?B?NmJ5cGFnQ3pZWWhsZ01xalFhSVQ1RVFVQzg5dHhsVE1ENFVab3lCRmpQWktY?=
 =?utf-8?B?OGI3c1p4Z2hvNTFlUEUzRlNNSGQzRllSUWh5YmJ3blpPQXYweEdMLzlEUUR2?=
 =?utf-8?B?L0dpc2I3WitjaXYrdldyZTd6VE92WVpwaE9GTlhiZlFRS2VyRHZoTkFwVW5j?=
 =?utf-8?B?NFFaek12WlRoWitVemI0cXBCMmoxYjUxT0gvZWE5cUZSU1hKSVliZFdsUnBF?=
 =?utf-8?B?Qkx0SDVIQXZoMmlCeFJudXF5Z0orM0xsWjBacU05MVdrTzF0TnBkWnR1YmpJ?=
 =?utf-8?B?TGdaSTJMVzZVek1ZWFIwZDJMck9hdXNKcFk5REVUZmJzSXhEMUZ1bW1WaUpD?=
 =?utf-8?B?YUQ0Wkx5WGZ2UXdyM0RxN3hSWVc3V0VGTnJuSUpQWlNmd0ZhZDdRamRUM2E2?=
 =?utf-8?B?b001NnIwdzNIYWpGaktrclM2bGdqNXcxYnpwQktTVCtVbzlUSStOYWhNbE8w?=
 =?utf-8?B?aFFidGNjRWMvTUNBY2NGQ09zaGpiQ1dqK01zWWZtYStvVmpaSDZYNTR0dHZr?=
 =?utf-8?Q?HThpDxIVs7b+7C8tI4mZgj6wRGVIkfLuzlXY9SX5IlL8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhycEtFaXBtdFozYUEzUEtPenJHbjZodDY0WFdsRytyZHBCWUpzdk81UTJO?=
 =?utf-8?B?b1VybGhQdmtxdzhlOVNJVU4rbVVtVkZjNjROcVlocjN1T2VabWxidG9iNTVu?=
 =?utf-8?B?aSt6MWVrVnh4K3VxN0Q3UXNBNS9Ecy96M2JiRFV3NUhSd3AzSTZXN25yTk9R?=
 =?utf-8?B?STdBS0xCeXlUV2RuajcxbEpwT3Z1NXl4aWc1MmlFS3pVSHlHcUVpSmRVVlBC?=
 =?utf-8?B?eTFZSTJ1VUlud1FOcHhKZFYrWWpWaG1XVEs4VUppcytvOFJlK3MyeitNVDJY?=
 =?utf-8?B?aDljbWhWMWZzS2ltRElndnRzTjg0eEhKdktNS1lqWHpyWlhOK2trTU9hM1RJ?=
 =?utf-8?B?b0Z5RzgwRzdnSkg4NVdldnZiVG56ejhPZ1JjYjdORGptRUl0UjVHd3hRNnN1?=
 =?utf-8?B?TExLODNtRFM4V0NGTUdQYVN6QkZaWEs1MXZudWFTQW1Bb3BqejhRVUNJQWFP?=
 =?utf-8?B?V1JsQ2JiUFZoOGdST1BqUmV1aUxpdnEvUElyOVhNMFkxbDVCQU9JZGYrajVo?=
 =?utf-8?B?cFpsNHVMc0xheXZyQ2U5Nm1xeEJUemdUK05RTkI1N0tTWWlReVpiamhHZWtn?=
 =?utf-8?B?MlpGMFBuSEUrUHRjSUQ0YUl1U1RHYldSdVM5U2IyT1JoaFdRdFltK3gvMTRP?=
 =?utf-8?B?M0lXeE9vQWl0Y29MQzNRSU5OL3pLaVRqZDExdEpjSVZEaWdzekdWSUp6MVY1?=
 =?utf-8?B?Wm5iNzhIdFk0MHZDVnZZSlZqbHJoalRZWG02QjcxVFVnTlJvb0hEMTJnbSsv?=
 =?utf-8?B?a2EzK0xVTjBsakk3SXg3RngxeXNkR2pyblBrL05oYXBiZUZvcXlsd1pJcEkx?=
 =?utf-8?B?RzdiWEtqdTZRVlMrL2NTemM0TU9yWFJlZWpYcGFmRjVKZHB0NkxJaEFaWVRy?=
 =?utf-8?B?OU10MzQ2SXV3QWREK2ZJZmkyRUtTcmpiKzhaOUdUQzhNTDRjOW5mWWZrUmxk?=
 =?utf-8?B?bXg5UGttRjNkRlY2WnRJWFZXSzdNQSsxZmNmU09kLzE2b0krMXNnQVpBbXVy?=
 =?utf-8?B?eC9MbFQ5NlVkYllDeFhHY3hkTVZNTWwzRG95Zm9mS2JEWURuWUN5NXZEQ2ty?=
 =?utf-8?B?MnEvMEw5QTFpbmhibTM2Nmp6UDVlazExZ1pxKzBYSXFqWTFyOHZ1cjN2eHdZ?=
 =?utf-8?B?UkpnR3lraFZGWnJva1V4TGFXVmc2TUtaNU4yRy9wR1N3cko1emJmdW1VUHla?=
 =?utf-8?B?WkRhYlZjbDNnK0kxTlVRNnVXQXk1clVwSi9hbi95UkZzNDZTQ2J2cEF1cEk4?=
 =?utf-8?B?R013ZnlJVVZRRmhrcVlnZEs0M0x3QzZHby9pSUNEQUxRQU9qM0JCL2JGaEFW?=
 =?utf-8?B?ZkpJMHlFNUszSmdmeGsxUmswUVpLd1ROV201dTlISVhQZGFOUEJ0Njg5TlRC?=
 =?utf-8?B?SThlR3NlYWI0UUV0a2pKbi9IclNUQk1PV3RRUkpwN1Frak41a3VDU081YjE4?=
 =?utf-8?B?ZzJWbTdja05wWG9HaXFpaldqQnJ1dVN1VGNhRWEwelEzUkxwdTNiUzVaY0Fu?=
 =?utf-8?B?eUJLVFZRUzI5NDZrMDZnUTdGa2xZb1RpT0tVSWZDQzJVdmdmRFJXbmFiZWpR?=
 =?utf-8?B?S2w4U3BXRjl1L2pxekkrbEFNQlprbTRYNWxaUFJxaEoybytXTDVNM2VzOTVl?=
 =?utf-8?B?c1o5dUxpbTJSb1Z6VmdwckhBSXFhN292WXM4d1E0TXFmSmQ3d0JiNTRLR3Ew?=
 =?utf-8?B?Yng1NTZNRlNsYVNINnBnem50SE1wYnR3WVVJRkRuNDhlbURmcDdYVi9KOUNl?=
 =?utf-8?B?bzUrSVFXRXFoZUl4SGRvSExKT2dtOWtqMEovZ3dveVBMR3dMazg3TGEzYTVv?=
 =?utf-8?B?TFlBZGU4b0tWSVd3d3NiakNLOC9rcGcwRGdmY0M5bDJqSklZK0N6ek5WMXpP?=
 =?utf-8?B?S0R6WXBaOFB2ZnV0M0pWblZsdnFJOHRVZnV6dGdUT2NmTXBnakZVUFVWL0tS?=
 =?utf-8?B?cTkzVzhhaE5KL3VPeVJ0ZFdMM1dLZ0Q4bnBhVXBRQ0ljUWUvVGVVY0RYNFlZ?=
 =?utf-8?B?ZUFTWEdtWTd6ZGdkYTU2QTVRRFVEOGU3WjBkNkdyT05RSFY4SENzUDBqMzJW?=
 =?utf-8?B?SEJScVBjUzZXbVY5TlEwSUhXR1k3cWwwT1NvamdJQStSQWpyc0dyNWJLSlpN?=
 =?utf-8?Q?5xR4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693b68c7-df7b-4f7c-d816-08dc733cffbd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:08:20.7289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O6ol5d1+4nW+qdPb4HBxt1SMd99jMZB/T2HElC1mGcznn51vLJeKoLxcz/wkXp3w170NpshhHPU048w4hSc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

On 2024-05-09 13:05, Mario Limonciello wrote:
> OLED panels don't support the ABM, they shouldn't offer the
> panel_power_savings attribute to the user. Check whether aux BL
> control support was enabled to decide whether to offer it.
> 
> Reported-by: Gergo Koteles <soyer@irl.hu>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3359
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 ++++++++++++++++---
>   1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3054bf79fc99..ce2ec857b8a6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6532,12 +6532,34 @@ static const struct attribute_group amdgpu_group = {
>   	.attrs = amdgpu_attrs
>   };
>   
> +static bool
> +amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
> +{
> +	if (amdgpu_dm_abm_level >= 0)
> +		return false;
> +
> +	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
> +		return false;
> +
> +	/* check for OLED panels */
> +	if (amdgpu_dm_connector->bl_idx >= 0) {
> +		struct drm_device *drm = amdgpu_dm_connector->base.dev;
> +		struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
> +		struct amdgpu_dm_backlight_caps *caps;
> +
> +		caps = &dm->backlight_caps[amdgpu_dm_connector->bl_idx];
> +		if (caps->aux_support)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
>   {
>   	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
>   
> -	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
> -	    amdgpu_dm_abm_level < 0)
> +	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
>   		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
>   
>   	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
> @@ -6644,8 +6666,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
>   		to_amdgpu_dm_connector(connector);
>   	int r;
>   
> -	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
> -	    amdgpu_dm_abm_level < 0) {
> +	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector)) {
>   		r = sysfs_create_group(&connector->kdev->kobj,
>   				       &amdgpu_group);
>   		if (r)
