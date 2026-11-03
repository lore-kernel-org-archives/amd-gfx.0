Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96E606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eS6AOh9t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0792210E660;
	Tue,  3 Nov 2026 23:17:37 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A655910E00F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 23:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEuaXSsyzCKXVTOpD1hZ19qoEUUsDPjans9QXz+/X/nAkvHq3fAg17QOo893uQ7daUl1y9t6QQWpv/tQAUqQejtVBGw3mCt2WSofmYB+1eL69DhatJxmppPwzD7v7YfGffcJvY7/eVvRWC3cTeeyjJhvjnRgrGJ6XjXdH1qOfOCjh0LfMWm04HKthgCYYky+AVOi30CSMilDyYfWpusXzsFb9G/1n0xmrP0cyUSOqxumxo7OarnmUqLIGCtT0aUhYrCThje9JtQwcyyqtFBtGCBc3xQW5gAJ68hJmRaaYA/k+EoWoH/DSQpLw4SZGF1VKTEBhbOHG9nxMT6vV9pBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN0saBq6r+MV6XJ8J1ZktpgFgQkImn+caF4mYhg/G8k=;
 b=BeEJwDNbWRbRmvTG0bkk8iCpeG+8HfYdgTVWoDUDlMPtAD2YHSzjXC0nU/drmqYMi7Z0319f85H3uNkuvopGmIx93YCSli9bmLE3rmn5p7ZtTX8XjL0VVA8+OuvbfHbqTAvGQTjZxyvHJiQjUAefLdVuYtOLs+TjlcOyLb8nJE3QfZoUDTixg7GT7php/6H4JWgF23Q5jnRDtIWeU/Sk7nH7AhS7BWp6uBxdJwgJJ9rBqUJk3w4RSdk9C46xo2FOgO3/MDuybbY/yfAZvGk354ni3Id8FV0/rLC48RGMwNgPUaXciWzwz0aN4HSyBqlUcb/oxod/4K7cOyzNKvo6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN0saBq6r+MV6XJ8J1ZktpgFgQkImn+caF4mYhg/G8k=;
 b=eS6AOh9teNQn2WZBlLcs7VX7PKJ2Wot1x2eGI3d9F5tKrQVtjAgMCVQHSO6IQimCh3CJsRl6ceqVVRA6JvAx5fMYYKEFpqfSr+A6lDZ+y4LMsEqFOyQ0QGzB/oxV6FPwxb/StjS49r6MEU08TiKCsh4NhK6xtMqQ013AXNYrKcY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH5PR12MB989986.namprd12.prod.outlook.com
 (2603:10b6:510:501::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 23:17:27 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 23:17:27 +0000
Message-ID: <011558dc-9550-448a-afb0-1065562a66e6@amd.com>
Date: Tue, 3 Nov 2026 18:17:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 7/8] drm/amdgpu: Reject config updates in UALink
 loopback mode
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-8-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261102160125.2743750-8-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::29) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH5PR12MB989986:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d13bbd-4764-4867-d408-08df3a00a038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|4143699003|11063799006|56012099006|18002099003|22082099003|261102123227099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: d0cRteitWMMhdOFW7/PVmHBO9xbCvdce5Q3cB9ZCSTMKu0jLFDxug9/M4vkU0ATMhpWKg4JXJdA01TO/xy8zZ0qEMoXFjtf6hAeCvOuTJCPkCYeWMsJgkyNJ63Ju+tG27J57MHVlXqYq+z8dpt+MkvCVgYy01VLQqw7weHikK4+32icVOoKZEl//FS+rUqDD+tSFEsQRdsN/4E6piR+Tx4GH2maL9ejg4MzKQjPN4QNDzaBcuyTTK54FNpyV6SYpZQE2WlEkq4tQnMs5Zy1aX2RqW5V+tfGKQCv0lZRtBOmjo01ObIRS6SFub8OPFPe/T/+XTnWTnnH0zf33XvxrxeMP5KIsDgR3oiZn/j/CDPDL3dWYk9DgxtsVbnmj8Q8WweD56zs52oGmTVCZMEBrJibZt+giam8IbJ0k5hMD8j9CPNquc9TKwAqIR3qI0EL3D2xVceWJoXVgBDUX2olS3hAjorAsQCT/FkjH/zax9VQ6jqQX2pC4zOGJZxNAbzvIbV0YkNraZW7akrO1i41dENzBXJCxd8VAHswrwQCLDKy1H+sHxTLbzjPc48qWYWzgw7rvA3erhHWpGiJ/iU95aMHsrrNSrgTM2NNgW/6W3EF8ZCxvcxa1m0gkeOv2aDcbXRp7uxoiBYXhnryx+uJPFOfT+uJpMfnah1PLzSwnI58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(261102123227099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlDNEZubWlzT0VVNC93ZzJyQXNWTmN3dGQ4V1RBSU9WZlBaS1g5Qm03a2ZR?=
 =?utf-8?B?RmZFdjZxdUR6TFNRdGhyQXA3d0RIYnR1eU1GM045V3ltTU11ZSt0V1luQVJW?=
 =?utf-8?B?Q1VUSWkvQmZpbHRHcGcrODJ0K0d3VW1sRjhlZ0xFSFBlZ2Q4UWo5Sm5lYnBK?=
 =?utf-8?B?dm9PQVN6blp3bjhDY1NVRW4xalI4ZzJVei9pUGw5OXJwbnlNVitjWGJobDFw?=
 =?utf-8?B?MzczV295YjU4N29IYzJ0ck5ZWk5rRWp2OHhIekdTblRuYTBXb3pjRUQxVi9Y?=
 =?utf-8?B?Vk51ZG5XS1ROOW9HQkN2ekVBNklURVM2dmsxMTlyYTdURERDNlpIb1ZTLzZj?=
 =?utf-8?B?cFNnY3lIR0IxU3dtL0NOQkFack0zaDY3dkNoNkVYMlhPY3dtdHZrSVVTS3Ft?=
 =?utf-8?B?V3ZZZ2JYUVhJN0dJVnloNWh2bTlpVjNNcE1oSWF6YVlXcjNGMkkxOUM2dVBw?=
 =?utf-8?B?SEdGMkxYNGc2Vm03aW8zK1VHTk9lZjhnMFFpTkVLamRvMlAzbU11dU1Ndmc1?=
 =?utf-8?B?WllSeDJPQmNXeGV3WUZ6Y2h4c0MvOHFRazhESElFdXlwK1VyVHVETW4wajNz?=
 =?utf-8?B?RmsycjAwdVAyeDBHeGlvS3cwZHpQY0NMQ0U3STA3NnBUcTgrV3ZCaTdPdHB3?=
 =?utf-8?B?UzB1RWYrMHpBM3hxeW5TQnVsNDNZM216aFZxRFpwRi8vUHN4RHQ2am5BQnpG?=
 =?utf-8?B?Wk1uVzFLaDBsNUFFYUtYcUNCYU9Vd2VWYWsxUTVOUFBLUkVHTVpKN25xM1Z2?=
 =?utf-8?B?Sk4wZ3JCb3RMTzVWU2hFVW1aSUNkTzczeE9meDZpOGRCN1U0ZGZ2MnkxZUFN?=
 =?utf-8?B?WXZ4ZWFVNkNTb3B0SWErbm5VRE5CZ212SHNYQ1pUMnlLZncxK0N4QnU3RHRh?=
 =?utf-8?B?czJ6U0dTMUVoTlNINXJlWC8rSm1NTnduOHFHOFpCVjM5bDdWZXVBMzBrbkhx?=
 =?utf-8?B?NFluelZacnRTbllKa1J1MXdBMzYya1RzQklPcSt4K2ZaUkJVZ0FmZmFaTG5U?=
 =?utf-8?B?ZmMycWdlMUlKems1bmRKOHZNckVUZHFIUHFqaWtHc0lRc0RKVnJGNmVRR0lh?=
 =?utf-8?B?b0lPL0hnT1p6dXU0MDRWc2JDc3ZXOUhraFo5MkU1Q1Z6L3ptSHlsVmg1cjZk?=
 =?utf-8?B?SjFWbWt6MGFENUVYVW5YbDlFRSt0c1grS0U0bzVGT0FZQjE2LzE4a1VQRi9M?=
 =?utf-8?B?bThlWGxQNlZWNXJXTFJ6QnVQTGlvTWpXUW9NMnpFNEtGYWsyaUxacE1Hc2Iy?=
 =?utf-8?B?RG9BemtPbDYyYnN1L2RnOGNZQUJyNGdiTmhaTnBDVDUwUjBBd2o2TnFYcURq?=
 =?utf-8?B?R2VqYWNkcXFyRnlnMHlKVXJMSlNCUmtYWkZLY1VTNG5yYW52aWJLRWZqSHRn?=
 =?utf-8?B?VGFqTys1T2U1bXdvTFRVcktBTWxqL2lIb2JNSlc4MlN0VXpyTTh6M3BwV0pi?=
 =?utf-8?B?SEM1SGdYaFFkbHRFNnB1MXU0eU9id0h0OVFzOWdQSDRkZjMyNVNUREFONDNl?=
 =?utf-8?B?cUQ0emVQRW9DUVdwdC9BTXpZN1RwV2duS0w3bGVROHNMd2tYVXU3aCswT1U4?=
 =?utf-8?B?djE0N3VRWlZ4VWZscmdsanBrRjhQR2ExeGdkRDgxd0Y5SUJXNUVDendKeFFp?=
 =?utf-8?B?VmVRTkNYZDRTZm1RUllxd3FVeitPMlBiMzNhVCtPR00vZUdTWTFQZEhTRDl4?=
 =?utf-8?B?NWVVSGI1MjNTeE9qK2lyVmFwSnlVcEgrS1VyMmlsSWF3czFtMUFtUTA0MWdY?=
 =?utf-8?B?K04zZVFCNjYwQVNZY1VpRWdod2U4NFkxWlo2SE1vQWUxTGFqVEEySFR3dGpW?=
 =?utf-8?B?T2I0TXVNK0sybmloUjczemNscEh5UXp2QW9hRCtZOE5XRk1jTlREMFl3MTZX?=
 =?utf-8?B?OGRIVlpkQ1BGV25lNmdRbEV6Q1ZNQ1FZY3lUVmJNRWRrR1dtY2tXUitBT0xn?=
 =?utf-8?B?dHdicm5uaFBWY21BUlNqTkZFYUlibEtwVlB5d0lhdGY3bXZnWWF1dUh2dzNK?=
 =?utf-8?B?Rk4zQWxQcXhJNDlLR0xuRENDSktOYXhxUkwyY1V2NjMydGwvYXdFREVBUUV6?=
 =?utf-8?B?QXBURHVINXVKSk9sNzJhemlXRGdoVCs5V0RHRWpzRFpNWUxELytFaWV6TDdD?=
 =?utf-8?B?M1l4V3A4ZEh0OGRxb1dyM2ZyTzFmZmZaZE5kYlVwQUhzeEtoc2pPY3VXYStB?=
 =?utf-8?B?VitRWENSUi93QnppRnNTN05iWE5LZTJ0SzY5em1hTXRYclFhSGQ4YUFPbmhp?=
 =?utf-8?B?UE5KVmxzWEg1d2ZDbVlrdVRCMFc2bm15Ty83Z0xKZG1PUW1VWVA3RG9zSjV1?=
 =?utf-8?B?bG1tZUtlOWV0Vnk4bTlkYVdlWXBuaEgvS2IyL1dDaGNIaUFUNnBrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d13bbd-4764-4867-d408-08df3a00a038
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:17:27.3933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiyuhAvR3clfd9UT0HDoXmtTbQJMRMAy58c1tyBlTM37eKR73rTlcM/lVNpm8FCPzhsVAE6jaTmbysSeIdocfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR12MB989986
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-02 10:47, Mukul Joshi wrote:
> In loopback mode the driver synthesizes the pPod/vPod configuration,
> since there is no user-space agent to configure the pod. Keep anything
> else from overwriting it:
>
> - Ignore PSP config update interrupts. Re-querying the configuration
>    from PSP would replace the synthesized one. Still send the completion
>    so PSP is not left waiting.
>
> - Don't create the pPod setup, vPod config and station config sysfs
>    nodes, so the configuration can't be committed from user space. The
>    setup, config and stations directories are still created, empty, as
>    they are when the config sysfs nodes are compiled out.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v1->v2:
> - Do not create the config directory in sysfs under loopback mode.(Lijo).
>
> v2->v3:
> - Update amdgpu_ualink_sysfs_init() based on Felix's suggestion.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 68 +++++++++++++---------
>   1 file changed, 42 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 2e1e0a677e35..cf2c68cf7115 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -491,6 +491,18 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
>   			PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, status);
>   	}
>   
> +	/* The loopback pod configuration is synthesized by the driver, so
> +	 * re-querying it from PSP would overwrite it.
> +	 */
> +	if (adev->ualink.loopback.enabled) {
> +		dev_warn(adev->dev,
> +			 "UALINK: config update ignored in loopback mode\n");
> +		return psp_ual_send_completion(&adev->psp,
> +					       adev->ualink.psp_if_ver,
> +					       PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID,
> +					       0);
> +	}
> +
>   	prev_state = adev->ualink.info->accel_state;
>   	prev_vpod_id = adev->ualink.info->vpod.id;
>   
> @@ -1820,36 +1832,40 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
>   		goto err;
>   
>   #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
> -	r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj, "setup",
> -			    ualink_ppod_setup_attrs);
> -	if (r)
> -		goto err_info;
> +	/* The loopback pod configuration is synthesized by the driver. */
> +	if (!adev->ualink.loopback.enabled) {
> +		r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj,
> +				    "setup", ualink_ppod_setup_attrs);
> +		if (r)
> +			goto err_info;
>   
> -	r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj, "config",
> -			    ualink_vpod_config_attrs);
> -	if (r)
> -		goto err_setup;
> +		r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj,
> +				    "config", ualink_vpod_config_attrs);
> +		if (r)
> +			goto err_setup;
>   
> -	r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
> -			    "stations", ualink_station_config_attrs);
> -	if (r)
> -		goto err_config;
> -#else
> -	r = kobject_add(&adev->ualink.setup->kobj, &info->kobj, "%s",
> -			"setup");
> -	if (r)
> -		goto err_info;
> +		r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
> +				    "stations", ualink_station_config_attrs);
> +		if (r)
> +			goto err_config;
> +	} else
> +#endif
> +	{
> +		r = kobject_add(&adev->ualink.setup->kobj, &info->kobj, "%s",
> +				"setup");
> +		if (r)
> +			goto err_info;
>   
> -	r = kobject_add(&adev->ualink.config->kobj, &info->kobj, "%s",
> -			"config");
> -	if (r)
> -		goto err_setup;
> +		r = kobject_add(&adev->ualink.config->kobj, &info->kobj, "%s",
> +				"config");
> +		if (r)
> +			goto err_setup;
>   
> -	r = kobject_add(&adev->ualink.stations->kobj, &info->kobj, "%s",
> -			"stations");
> -	if (r)
> -		goto err_config;
> -#endif
> +		r = kobject_add(&adev->ualink.stations->kobj, &info->kobj, "%s",
> +				"stations");
> +		if (r)
> +			goto err_config;
> +	}
>   
>   	amdgpu_ualink_xcp_sysfs_init(adev);
>   	adev->ualink.sysfs_init = true;
