Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3B7C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 05:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7710010E6C7;
	Wed, 12 Mar 2025 05:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JdNixM0O";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A61110E6C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 05:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bROG3JztzuvZ7KBg9aB7cKiKTt8xDyJ4nIJ9wCZB02EIcrtPjzx3sXwtMnmxY7lA85w3LPIyYhdFyqNhLPZMCzkxuQBi/zY7IRndEXxCcFrn8O4UGNk74RKz3bkcqEbau/icxOCKbk4/YgAhorSpnYJlq16cgZEfxQ+Ff7WRldoM2Fpp+PHIhaKQY9o2sdu9Oc8RGvcln96BL9xa1aEMQF0ofvaWu3gXF/6M9VQNfFpYA+yuQLIr52sIGVHavXxyQI/BfyOKAvbqyCVLb2f0deBUUvP+VpJkdp4iKAKmAJqwaFI5/QrU+YqJAYTVD6FgDQhWbvRCZlY13m0O0Hk1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB2lqArEsdp2HJ29ETiaNIQ0QqGGCmuPzwNIJaArL+A=;
 b=MVO7pwtGqdAtX1GxHfO+VLGtL7ROt8gB9TZshUFteYG+mabu0oXIiORqXpILaSCyhHN6hg5ZzL2K9r1ZXLdRrkgDMBeOZShlyFw4cPH4AvEUwdYtmabOfIl9P5mvvJ05TnbD4DEhavluzXaugZPuhYCYH07MOub/EiqUasCuGk5Ph6BxL8ovQgZxGPZoWrHcOZNbeYIS3Nf+ijws9LwfXdhznqu1rtJPksKpHIeJxS9B9IWzjI7D5ZZId1AjrkRGpMfH5jvAjx9s5qWZSxfn7iCfDDHSasSh2vQkUiA+bwXyP3LEOJ1h32ISIXgr4W4B9ZwJmQbE8oero7DRlSlqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB2lqArEsdp2HJ29ETiaNIQ0QqGGCmuPzwNIJaArL+A=;
 b=JdNixM0ORiJaleuTZWJzVba+HZIpos4A4YhYegOgSwdJqn5IdnarAgyPLARV6GVETktpnw5LVtMRr7c2hRJWBwOsmkxFMwXZBIH4m/oPh5zBTIO/SH7X7yIsCYYq+hx6/pr7xFSHM4jI7i4sLJe5ms8Q061IUcYtL2qVXeAXfnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Wed, 12 Mar 2025 05:37:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:37:15 +0000
Message-ID: <36ceca0e-d099-4650-8bad-a75618b928ab@amd.com>
Date: Wed, 12 Mar 2025 11:05:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu/pm: add VCN activity for renoir
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250311204459.23864-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250311204459.23864-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017D.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::48) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: cc46ed3c-4b3a-49f8-9dc8-08dd6127b1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnB1c3c2dDAyZ1JYc3psMkdvZWRuVkFpbmE2VDJvcHlHd3RGOUxVbzU0eldH?=
 =?utf-8?B?WG9VUU83YWxnaVdXWmpjV3cwZHBQb1ZjcExhd1JWejBqZG1pclBweC9PWHBs?=
 =?utf-8?B?U0d5Y0hodHFLbEMzYmJyNENuakpiS09kM29mVHlISlRYUlEvMWlpWnpNUE9N?=
 =?utf-8?B?UjhuYnp3NEJvNFc3U1MxYTMybDhLbWpPb2szMGhDZFJsWnY5NjlMaXZQTjM2?=
 =?utf-8?B?OW1oUjEvRjJGYndZNlcwMnhMNEhoVHQzNGJhOWJaRnpvRWh3cFIzM0dldEJp?=
 =?utf-8?B?cTIzOXBLRXgwQ0hMQ1ZEcHdpQkduSEdEYitxcHpDMEpyaEhIVDQ4NFNEYmkz?=
 =?utf-8?B?SytoU1JsZEhCbFc4eVJDVDExcGY2VXQ0TFhYM2RjMTQ4aktlV2xMcCsxQ0RY?=
 =?utf-8?B?Y21wKzNCTzZ5Rm9lZHlKelpFSXNvVDY1eDVtQVBtWmEvMFBuaGxwRnQ2OWVq?=
 =?utf-8?B?TTlpby84bWNUdDlwVHoxYzYxd2dVcEJoekg4R20vS0NyUUZYME1tc1d1YmFO?=
 =?utf-8?B?WmNOdjAzV3NGOGdHdkVnU3NQVW1GNGFLcUluSkhYaTJPVUpoR3ZQRjlITHhr?=
 =?utf-8?B?bmxvSElDbFp2Y2pRbFpqcVEwWjFtUEkreTFzTjUyYVBFV0hwSjJ3RFQyVHVl?=
 =?utf-8?B?S29hU25ULzhleFRMS1lYYXlyc3ErZ1hxam10QisxU3VDOTY2eUxWMEhBSTky?=
 =?utf-8?B?bzUzdmpiTFdlckhVMWdqOUE0N1cvMTh4YVEvVTdJR0t5RWVDaFcraXptUkM0?=
 =?utf-8?B?UFlEK1ZXcWVQMHBkR2RmUTVOcDlsVmpoUWllaG1pU1JkdEp2RXM4b24wRXlq?=
 =?utf-8?B?NU0wNDFaTkQ4NmN2MWt2WlBlT01takZCeS9qVW0wTFFWa1BuMVkxLzc2S1l6?=
 =?utf-8?B?RDllU3VxeFlEbCtXNzQ0ZXoyZnl1SGt0Q2tyQlZxdFdUSVJjUFV6eXlZQm1F?=
 =?utf-8?B?Z0I1SDNWeHZIWjIvN0owUERXZlNHQXdGa0k4bHlJcXk5SFJtRkhCaG14UDRu?=
 =?utf-8?B?N0NLM0gyS25WY1I5dlZZeTd0Y0VTSzRrOUtOYWlqVHVmUEZOVmxPUVpSclFF?=
 =?utf-8?B?cWZ0bEFhVTRLRlkrWEpLdEtqRW5DTlEzRG1JNUN0MUZDczNiWERWL2RqYks1?=
 =?utf-8?B?QnFKMis4NFNmSG9GUys2aGZJVlYxbWVqRWVuVjVyRWZ3bnc3ZkMraE5MS2Jq?=
 =?utf-8?B?d0RPTG1TZnhCNHNzYnFUT1VtTW9ZNEFLYkZRU0tGcUdhU04zU3BNVnFGWXZ1?=
 =?utf-8?B?ZEgrODk2dy9Pd3l4dlYrbHJBNXIyamtVblhUM0RZQ3JueDFsVDNWOUp0SU95?=
 =?utf-8?B?cnBXZ0JKUTI0THhpTjVialhPL1NLdlFGSk4wek5oQmVLQ1hwVU5wNHArUklW?=
 =?utf-8?B?bERxQWRwVUk5dkNSUFVzVHRDU25uOHVPY1VjaHk0VjI5WjYyZGNqNDFYUVJx?=
 =?utf-8?B?d25Va2xzZFFWMWxKQmlBMkVuL3d3M2pYQVo5N0NSZ1dDckhnWEt0SUcyZzdU?=
 =?utf-8?B?TkV1eFdrSjQrR2ZpUlo3a1ByZXRWaWI2QWlqZnRLeWNqTFk1QVpZalE4QnZT?=
 =?utf-8?B?K3A3UDg2NEdkU3Z4dmNXK3JJdlB5L29WNnVXOWJwcnliZ3cvc3lvSlNUVzFN?=
 =?utf-8?B?SGpiWjBCWjJ3NHd0Tmpxb3Q1dUVLMEdUbVJmOFEwMDJCTkJjbXRpdC8rekF4?=
 =?utf-8?B?aDB5WEJxTG5KZ3dGZHAwcy8wbDJydFJzOW5Ra1JyaWg5dVN4ZTR4RGptSFAz?=
 =?utf-8?B?elBPS2p0cXFLSlhudkFnT3QrMnkrRjVzWFAwVnBYbzRXWXczcHlKbnY2NHdC?=
 =?utf-8?B?WkZtODVKbjhLWUtXdFYwZ0NGK29oVkRaYXFLbmw5RG1BYnNiaWx3YkJKSklC?=
 =?utf-8?Q?YvNFE9K1x61rT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2hMVDBWcytQcFVEVGtDekJmNlVEMzIrOXV0MTUrclFhMkN0eFd6cjBFc0lD?=
 =?utf-8?B?d1J3ZUNhZm9TY01IL1pwbFhWM1p4d2IvWHFCbHlCVmJJSjBWR3MrKzlyK3BV?=
 =?utf-8?B?VXdrazhsUWpUSDl4dmo1SDNuV3cxTS9CQWJrSmVxZkwrVDkvOWpYSVB3TUR1?=
 =?utf-8?B?amJMT1phWXhqNnFtYjZOeWM5N3hLRFVLSE5TTk1RSUNwOURiKzVBRjBDbE5P?=
 =?utf-8?B?TzNzbUxuTVRNQ3pCT2V5OTN2SGpwVkZBUzlrVTZBbHFwWHkvUUhRZmkyNHhq?=
 =?utf-8?B?TEdsT0Z6bThpYWJEUnQ1UG9ZbUZjSytFWHYvaHptS0hrOXlkRm1PcGNOQTA4?=
 =?utf-8?B?MGR2bW5aMmx6TC9BSHJXVWtBSzBPTjgwQUVBTElhR1BHU09BSlQ1WkhKU1Iy?=
 =?utf-8?B?NlppcE9SMHVwUGdiZTFpRklIRjFZaFpmblRFYjFpOUNpZUlXSGhIblVZTmNJ?=
 =?utf-8?B?VDlpcEFhRUM5L09HamRCNVlqU01wdGVWNldOS3JsQlRvRjRXdFhKUnR0TktR?=
 =?utf-8?B?M1I3U054WGRGT0l3UFp6bjB1L1VFY1pTblVLNzFPamhNMHhaU3RpcjhwMDI1?=
 =?utf-8?B?Q21MK2ErWlVWY1lpR2szWWVFZmxhZUxCWDJHT0dDZWl6b0xTSW53ZVl2SjRM?=
 =?utf-8?B?bHJseWU5ZmdYRFdSN09XQW16RzBLeWgyb0IrdUJsRUQ5SDJET3lJQ0Erc1VV?=
 =?utf-8?B?LzFqOHkzUklzOURvUjNDbUM0bk5TU25NTzNVcllQa3RiaFp6ekQ3LzRiUFBU?=
 =?utf-8?B?dGdPbUdZVy9ENDNqTlF3K3dsS1FOWXVPVkZSNjNrSjBNeFltbUNOeURHZ2tW?=
 =?utf-8?B?eE5SZlo3Zm9nc0hya2tkWU5lM3gzUEl6RXRWbDA0dkgwQ2VDODZDN3FnV3E0?=
 =?utf-8?B?Sk1UbE1ldUp3QlFlTVFsVlBhVVowRzJVd2xmK3dVNmRqMkdDVUg1RkhSSkpK?=
 =?utf-8?B?YU1KTmdlNjdiQXVxZElVd2dnSlM3ZjVnemZSR09HaVhJSldxMGlzV2JIaHVV?=
 =?utf-8?B?V29ZWU9TUXdZZUtwK1JWSSthQnFBWm9UcHpzalUwUkhVclJTSHJiazMxUUtU?=
 =?utf-8?B?WnIrZGpsUmpjd0Q2TGhxM2tKRi9hdUwvajhhVzZjTW9jK0VTN09ZT2Mweld0?=
 =?utf-8?B?T1ZUVXFGMGd2cUlsNVdRdkM3cUdRSy9WMWRmZ25vaTZaS3hwYXlHQStzdnUw?=
 =?utf-8?B?cjVpQzRLeTlRemJybDdrQWY4NlpoeXFyU1RyUDE2MmpKdXpMNUZlL1Z2Tk0w?=
 =?utf-8?B?Q25Sb1Fkbjl1cXRFSTFYaEFobGgyb0RMekxCZ3JndTNVbnRuMVhzWWZxaXk3?=
 =?utf-8?B?UjVPTjBTVTdZUGtVekhJS0Y1VmJNblpxSFdURHlzb3RLNzFJdk5uQ0dCS2Nj?=
 =?utf-8?B?d1ZNSnFvS2tYZXFCc2kwMENrZWVYMzNaNHk1em5sUi9WTE1lQ0cxTktDeWtE?=
 =?utf-8?B?NXhuK1IydDVTV1RzQm5uNjNpVHlxREVacjBQbFc0QmZVYXBXdURqLzRSK212?=
 =?utf-8?B?UHg4VXUzcWVHMm5zdUhtU2Myd1JNSzlzQlpLREYvNkNFK29rVUl6SExnVkcy?=
 =?utf-8?B?RGNMNmw4R0dBSW1ZdXFhQW1HdDU0MFBIam1NaU84NjZWRTBBYnRDcHpacCt0?=
 =?utf-8?B?Tlgxc1RySWF3c05Pb2k2d0dvQTNWWld0WUhtQXlyMkY3Y3IvV0drbDFQTWdS?=
 =?utf-8?B?NE9KN3BJWm02M1k4S2k5V1pqTEQ4c1ZoUWNWY045bzFITVNJcWpkdmFZMG05?=
 =?utf-8?B?OGhBOXd3U3ZtZzlSTnpVN1U3ZWFsS1BEQTZkTTVqc3M5Z0x2WGJ5SlQvZVZL?=
 =?utf-8?B?a0Zvb3N0OXdGZWVzQnpUUXJmTzZmV1BpYWtuTXhYUzN3cXFXOFBtWS9jZnVV?=
 =?utf-8?B?OE9aMUt4dTYwdXlXam9LMW5WdmQzS0c5eXptMG9UZDRZTmpwV01JdDFHUGhh?=
 =?utf-8?B?NkxQQW8zTzBZM0JRdTlnaWdibVhacVdwRXFjSlNiT2VIQWhPM3dWakJ5bVhx?=
 =?utf-8?B?WGkwOUs4TnlzMTVTci9rd3o5ZlpDZ2NRZVpJQ25vTVVOZ2pGcUlBWkZCOFJh?=
 =?utf-8?B?UFlZSHhFTkVLR3VZeW1qaUM5eFVDaldXK3daRU1QVFR0SnJZL2haM3IvcEV4?=
 =?utf-8?Q?O12LDXyypG459NIAI0BZm7xZx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc46ed3c-4b3a-49f8-9dc8-08dd6127b1c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:37:15.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pw2n/zk6FhSw7/du6BRtEsWCmUuhD1zS2yrXFdjE7XQv39jau+ATNZApDsciC2UL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
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



On 3/12/2025 2:14 AM, Alex Deucher wrote:
> Wire up the query.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 37d82a71a2d7c..9481f897432d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1285,6 +1285,12 @@ static int renoir_read_sensor(struct smu_context *smu,
>  						  (uint32_t *)data);
>  		*size = 4;
>  		break;
> +	case AMDGPU_PP_SENSOR_VCN_LOAD:
> +		ret = renoir_get_smu_metrics_data(smu,
> +						  METRICS_AVERAGE_VCNACTIVITY,
> +						  (uint32_t *)data);
> +		*size = 4;
> +		break;
>  	case AMDGPU_PP_SENSOR_EDGE_TEMP:
>  		ret = renoir_get_smu_metrics_data(smu,
>  						  METRICS_TEMPERATURE_EDGE,

