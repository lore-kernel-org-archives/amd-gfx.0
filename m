Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E71CA5FE5
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 20:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0E110E50D;
	Fri,  2 Oct 2026 20:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONPsE2qI";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8618610E50D
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 20:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKeeUJlCFJSd7jwjA06UdbsmFTrcdnwgsIMlhNzFOSf0ECgItm5MXql5pv4COLbEjamfC2FgRZq3SkwV0idOgSjOFZmJ15hyjrfWv9GReNNKxLs9vs6yw0xs+W5RKa+RbDPvTi2AEU1SmUkzLizjovG4W/u2HCfj8iuC6R0wKCk3o0m/vbdu541crc/FpyEvtul0760k6Wht0975+HDisxORbKrkiaGBRWH+XF3/XEpOWkruaLp+vtspHsWHhhnKZ0EXracQCyTeVOZT3/VwnP3lGLHNuNBC7wvPlr3OXZ3zJJ4hAx5lb8Au7g6//k/wQGppXph5mSTBxrQWiL5/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7K4GdOSBgHqOzlXClvqhWpjBuevJkePtUZse7XLJds=;
 b=ieMyNs0P8WqfaAE7slPU5vbNKeBtopSmA7y1oVUcwZL7MUmzpf+OhGFh83e7mv3LIvEd82mMYXd1RnkKHKOmwmcAipv8CD24zMh/5ZRJCRF3i+KD9rrmuI/ZJQseaNGHHHxEC8u5SVvg8FuW0qPMNpf27KKmLxNm0BkUNi1UunvTyZ1mKcudTshuBJet5yu2iUo+qIOFTvBbvAyxxqY/ZuzKlkZ341WcewPzgmbAPHlckuseycUEglKhYTVFszjoUe9tLFcbHmS+v72luD+NLLZFbmKAT+hWw09fN7/aYiYh0c1z9EkioGtnk3AateDTCm/ldCoXL6iRUUez8Hxc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7K4GdOSBgHqOzlXClvqhWpjBuevJkePtUZse7XLJds=;
 b=ONPsE2qI69krtG7e11OzP8HQyEcQ1agXlJDmeODQM5oDuMEqQ01Z3z86naR5PfCpWbL39bc3Y9+6NdiSAjXR03OO139G8u1CIR3eXfWMrSZaiEMAcqElE7bNlgTP30XmpsjIpeux/xKiBZ/GSRCzR8ahaQs2UtreyQy2nsjAodA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA0PR12MB8279.namprd12.prod.outlook.com
 (2603:10b6:208:40c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 20:40:18 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 20:40:18 +0000
Message-ID: <27ba3acd-f9b0-4526-8bd3-807bfd3c1cdc@amd.com>
Date: Fri, 2 Oct 2026 16:40:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Reject UALink source-identification address
 mode
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261002155354.332801-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261002155354.332801-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0433.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::13) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb935cf-519d-4724-59aa-08df20c55ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: UbGVqZyvGuafAxGQ3GjGlejrqkhTqr+DogKL+DTyC+xzT6+aiISwb9aanCZ2DcDSyQDmWZlpyxCb4AJbghRMTSLaIC4PqoLdKj6O02xI18y2sK6M+xa9UtccqSOXQfsiJaRer92tFrwrt6K4LuSObhffGnTfYwFZIMJjCy/il4SGTSFveLyQkMR7FWaAsUEtUlu8WY6oE3ydr3emLC3wdY3uN0R0pSu9VcQw9sVcMqdFYAgpyMqBwyn32eUXjo95JrPDkKALhay88iUSf7FGYT2wvOo+kQNTpHrdqwYL7hxZ0z0UixoT9pqLs1E/0f5WmmNU2vfRHpGkRqkBpkUyvxy5Zm5yxrFNRMIUFFt/FsWZwvpZ1BMyGyqaFKKgHSjutHW+oFgAIw6xHp2R4GZbUmcnAN55Ta4rk9ifam9Qs0jWTe1BiEbhajii5XpN0z3w0Ew8WZTYfJIVaoWtUaav0l/pah8gctkaNXQkXg1mR7wrARV/b/GpDshpIVljWpE0OLwt7AJRBviO//+kFPjMw4uf5t6BNnhv2PYgIPOc0zk+4RT4oacThKIpaJPIVkg6x75pjJ6lg9ZhrHtFMHHTtvIMQ22LV2LBa+cR1+IvRenvvPnj9KduEi13p/xoxGcBCjEqRdbsphpSH8gfMpJSMVU3VXfD9+/lp7hqRhjq5fU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRvbkZza1ppem41VmZNZkFFNC90UUhyR05FdW5Bd2RVbjNhbGJHTXI4WU9Q?=
 =?utf-8?B?RWtjT0R6OXBON2dFMEVqUHVyNWM4TnZwV0w1YU4rcmlGckMwOVF1RVA0R3gv?=
 =?utf-8?B?dzZrdkRicTE4R0JOMUV3SkRkQWx1NnZKTVZMOWQxZzFzeUNOY3VUZEZvU0ov?=
 =?utf-8?B?aEg2Rm1aTUpvU25ac2NyK0ZmRHQ2ckduOTdSR2xkc3ZUeHFseHMreDdxNkJ3?=
 =?utf-8?B?aXM1YklyRGttSzhMNUwxVVUwK3NuaS81L3QxUUhUZExDL2Q4YnpzQzZJS1N3?=
 =?utf-8?B?NXMvZnBxUXAzRm9YSlBMMDYvMkUyemFJQzc0a3BUNDVyVWNXRkRSSzJPZWMv?=
 =?utf-8?B?dTJyYk1LRjR1MmpCL21oV2FCRU84dk00UWM3SmJEbTZaV0dOa0czVUo2emFu?=
 =?utf-8?B?MCtLLzFOT3pjTFJWbUpnd2tnZnoweUdla2NuNGFQUyt1RE5tTUt1b0pkTHoz?=
 =?utf-8?B?ODNSY2htM3FUM2RrVWtaWmJlVndWS3kzRVQ0ZWdRbW1XVXdiR1g0VHhDK05F?=
 =?utf-8?B?SlMvMlB1Y25YbEVaUnlJRkd1SVp4aDBVSStneUkwZ09LczhKMVQrVTRQVjYy?=
 =?utf-8?B?ek1SajY4V29TamE4NVV5UkZEdXl1NzIrNUNxNVJPZjhwbGt5Ly9najMvODBu?=
 =?utf-8?B?QmdRYmxTd2cwSytlcTkrOGE0amFkejg5WjROSWhsMmVaZVBTcHZxZ3BlR2lY?=
 =?utf-8?B?RVY5MWZ3WHZpbnhiRmN4YzA4U0R0T1Z0alpVR1hwbTlkYU5aVFRqTjdSbzNj?=
 =?utf-8?B?L21IdUhCcXdEcVlQQjQvY3dwYWx2RDJzUkIzOUVSWXdlMXo1MHY0T09lMUdy?=
 =?utf-8?B?UURZRGphRnlobkpzMGhXSCtldktDdEN4VHJuaGE2Y0Jad1M5bG42dzFuaDhV?=
 =?utf-8?B?OWhiaXVoVVJsZlZvSkw5MGF2VEJhSnVid29sVXNVZUc3dTJWTVozZ3pqT1ZH?=
 =?utf-8?B?MFdrOXNPTzZZTFR3NDFkRjB5WVZYS3VzamUrdHhpcDNQc2VaRlEzTGk1M3VQ?=
 =?utf-8?B?NmhTT0hKNEpwQU5tcGQ2ampNV3djYjBNR0JMcUNBTTBkRjFyZFZGY3VTK3hV?=
 =?utf-8?B?THI4bTJua3RwV0swYVZITUY2WllWZlNpZGh1SXh2SWVucTcxeWxEMUlXU3ZU?=
 =?utf-8?B?VVJLVkkvaXlOZkw2VXAvckpvN3BLZktDVk1tZTZFd2hKK2I4R2g2M2NBYXEr?=
 =?utf-8?B?NEtxM01hR2RFbWtXNEQxeGF5NW5rVVlKMTJYOENMd2o1SU51S1lGZUtqM2JI?=
 =?utf-8?B?SUhsMzloSlNnRjBUL0hwNEhlYzc4SzlTUW1OZzNUK09rWENiVDBpZFIrV0pQ?=
 =?utf-8?B?S1pWZXNNd0lMUXhJZFFNWUJrOWxZZFBDVWhpQURnNzlNY3Y3MTFlTkxqTnRx?=
 =?utf-8?B?MGdGd0dsUjlhRjBSOExwM2RJNGJyZDNVVU1uK1NXd3FlMVRpTG5vWXlHRlRI?=
 =?utf-8?B?Mm9XbXhyd0VoNHdCOVlmZExZdkRiMzA2N044MFBvTHVPajloRmtrYWM4VmJJ?=
 =?utf-8?B?ajZEN3prdXRNa2xRNXk3ZSsrVEFENHJCSE4zZGpRU0NnV0JDT0pmcjlCN2J1?=
 =?utf-8?B?VFVtS0xSc1NZZTF6WTBNRmJsWFJRU3ZQSnlaVTdnY0JiMU8wZkdVanR2SjFY?=
 =?utf-8?B?QVRmcEhoL2xkakpGY1gxR2NRRmtrMDRLTnJza2NqUDF5R05QMVVqV1NCK1c4?=
 =?utf-8?B?ei9wSmthLzZtTlF2aGtwWmViVlVGOTdERTNGbjd3UDhKL0RlOFRJOGszSnhx?=
 =?utf-8?B?aGNZYVRhc0xxcWE3d1UxYS93UHFMcFdLTllxNHQ2M2Yydi9CZG82NzBUTkVP?=
 =?utf-8?B?OVJXOG1jZXh1djlVWU1oVkpVUWFqc0hNUVJ4V3daRnZNblJWMVZOVHlSMW9s?=
 =?utf-8?B?cGlmTjBGMXozbnU5eW1BK1UzRk1KcS9EL3ZiQTBBRnhmLzNtZmttU00vQWJp?=
 =?utf-8?B?ZGJCSG5QSk16eEZWOUxDTnBVWXVod20rMmt1cWlGdWd5VDNhV3BVaTVLeTVt?=
 =?utf-8?B?ZGs0bUEyMXZqTk1MZU9ZSHQyZVRySGoxQ0hGUDEwaUM2VE1nTVl3eXcxeUc4?=
 =?utf-8?B?Um1pRldDc0dXYithbHBnUzY0dFk5MG9pdldkdjZjc0FhMjJXOWJ6NCtxa1h2?=
 =?utf-8?B?MHIrQ1FkSWMzS1JBK3lRVVlneU9hVnRZUFpxTWZUaWZuR0NxWU4zQzBNLzVB?=
 =?utf-8?B?aUlad1Qzcm9tdlNISitWOEhuZ1ozWGIydkRFSklXQ3NDRzltS2Q0eTZxQ00w?=
 =?utf-8?B?OTRZUWJXT1JUaU1NYWZpdWQvVXNOOHJac0UxWEg2b3FDTWF3RjdscFM0S2x2?=
 =?utf-8?B?Qi91RDFveEEyZHdFZEpmc0dFVnZFSWRDZVJHakpaL2tPWWxpcW1XQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb935cf-519d-4724-59aa-08df20c55ece
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:40:18.2488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ui7RZPrlXtf3I7uqkI1vwu0MCGv/2MZzGSswUO6UdeX07ulFpKKCPl+WJfmwPgDWojmwoKkcPiweUmQMij7mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

On 2026-10-02 11:53, Philip Yang wrote:
> Source-identification address mode has never been tested or enabled, so
> reject it in __check_vpod_info() instead of running with an untested
> config. Both the inband and the sideband vpod config paths go through
> this validation. The SOURCE_IDENT handling in the rest of the driver is
> left in place for when the mode is enabled.
>
> Also drop r from the vpod-commit error message, __check_vpod_info()
> returns bool, so r is uninitialized there.
>
> v2: use switch to check address mode.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 3051fadac50b..758265670340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -137,14 +137,21 @@ static bool __check_vpod_info(struct amdgpu_device *adev,
>   			 vpod->size, ppod->size);
>   		return false;
>   	}
> -	if (vpod->addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX) {
> +
> +	switch (vpod->addr_mode) {
> +	case AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS:
> +		break;
> +	case AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT:
>   		dev_warn(adev->dev,
> -			 "UALINK: invalid addr mode %u\n",
> +			 "UALINK: source-identification addr mode is not supported\n");
> +		return false;
> +	default:
> +		dev_warn(adev->dev, "UALINK: invalid addr mode %u\n",
>   			 vpod->addr_mode);
>   		return false;
>   	}
> -	weight =
> -		bitmap_weight(vpod->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
> +
> +	weight = bitmap_weight(vpod->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
>   	if (weight != vpod->size) {
>   		dev_warn(adev->dev,
>   			 "UALINK: vPod size doesn't match vpod_active_accels list: %u != %u\n",
> @@ -1351,8 +1358,7 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
>   	if (info->vpod.id != AMDGPU_UALINK_VPOD_ID_INVALID &&
>   	    !__check_vpod_info(adev, info)) {
>   		dev_err(adev->dev,
> -			"UALINK: vpod-commit __check_vpod_info() failed: %d\n",
> -			r);
> +			"UALINK: vpod-commit __check_vpod_info() failed\n");
>   		return -EINVAL;
>   	}
>   
