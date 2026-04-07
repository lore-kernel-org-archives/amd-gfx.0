Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED8DFB519E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 07:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B4710E335;
	Tue,  7 Apr 2026 07:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MSO7dgMA";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809C110E335
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 07:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aipohSP+qCZ5P0G54Xwh8WgRJpuC9R8kJoghW452rBbofS63Ljg93TMADGThM4FPTFszQIQtXWOjVBSbt/xeXu36t8CVCq+v5gmbdo7l00iDnGDbCkF+SofPVyeIX4OOR1oHtgSLjd8LQ3HifGGAHb6DAxyKWrEf0whiPR3Wg7wp4qa1BUHC9ofWr4n2nFzPLdbeqkh0SzMpHTpxwcIhoX4vQywaJ4U1eBHvSZeqkblz6DJUvtjGCJtULXK1rIrDjQiAAOvZCWZSyxi4cg1JxxunZ/mgyHRkUjD7+rGCZX7eplmrL53lcz6XWwnx7l78KM19J8/C0tTOewBVTA911Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzzfOCiVry77zGfP1qmY7mC2CcoKCi9bz4+7q75gRqY=;
 b=ExvM+bPLquyyDm6HK/wUq/Qz3kewNPtz2kBHKhxiNSIf/lkrix7DyLmZgTMncFFMBl6EBtL6vpTTaO3aI8HsdXU+t/5CTjUbGfswvgswiIYFgNEqGnDHV8rHJM8I6WNeKhvOsbZr4pBdF2XQX6EGCPEjGM57WPmKnob1ZIiFTq5WXhnzvyN7ch9SvZI3wI1fVVVWA6jK/lJ/PM4YAXrF9WiEyY6MVSoeoUPn6YEVz3J/bXGhH0B0yZEd3tr4FmQ6sXlubiCqyv8I4kaa537EJqBoVRqkX2vCXpcDwyAlccW9QbKea9VqwdQv1Ecnyb9oh/lYrv0cs3mraD/h0w9e6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzzfOCiVry77zGfP1qmY7mC2CcoKCi9bz4+7q75gRqY=;
 b=MSO7dgMA58/nmQwOQ/AFh1MIf0LmDmUW86MQzKA+6fZWGUxC4uxe4fXcpexb3NpA1eSkcJoKU8pA7QsTOwk0bn3hHObjXCt3Wa1kiJTiPdpcNU2fr6oZrwWqXRuqUV+k6WQvi57wUmIBjWRcdu39It6A9zItTl3aC3XtqDAOn3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 07:05:26 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 07:05:26 +0000
Message-ID: <9d6d4d1c-7653-40bc-8b3d-151d0f969d88@amd.com>
Date: Tue, 7 Apr 2026 12:35:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: add od table upload error message parsing
 for smu v14.0.x
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260407030931.2024335-1-kevinyang.wang@amd.com>
 <20260407030931.2024335-2-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260407030931.2024335-2-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 8398d806-3482-4998-48ea-08de94740b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: uj089mVE5EPVXOc+K63Cm81c1KJBrYzGVpAmhsnA0ZoQzNwtygoiz9CNLp5mD4R+ZTPgd7nuEMigIPYsrufdtt1aXiHsQ8/a6HI//lHMScR6fZT7Yq3bKDgbB3UEhKnw4MkKV42I+TviM40IrO8zqpiqazQkwaay+VhvrCRuSvp5mAZUNOipJSEXkGR2jNUn44oacgeNbCgmEtXtvUjOinHdeBL7tClLOoASb9ze0yDQI2R3145xYQeL1M2uYtmSEy53rxh+PZjEbI9ctq0iU0Wl8SSQoUZ+kjTcXCD8CyzydiFLnqKrzCqh16tdh6H2QRMxN1qH81hd9zlt8ZMFeJfV5dkQ1BZNFXJ/8KLrgRwvXjcKryy9P09rxi+e12zUV0Dtg340N/stjtN6gGnARSPSfIqXtsI2ddEmohwEKmZEi2srHFvJy72SmLZeZNfXBT4vpGrJwvcBe/SsF0D/aChbaY8nKwe/mwbzs/e+QjcglD3LIsUBra/wPU1fl16Hpsv3Gd+SgO8m2vYu5vHMtF+P3tsL4VB+AdYeUen0dqgltkGKlGzrgDO9sDvweoNQrRgaVJ/jRq2P18dUvZGPtRm4NcZtkme783xT1dvrQCsrZicW95KXxjPFMmA0HkdDASK8CpU7CVQV2v7NQs9Izf7JqsFX8I3scLCx0/MauZHGCWJh5ZIN70SwJdkJKnLpLiBVBSWvWGkNpco28aVULxtIBq3r0/cOS4emn6dlHz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUMxTW1Mb2FwNHE1QUdSL1oxS3crNEFMS05VR3ZIbWRoQ0NaWCs5VnlmMVIv?=
 =?utf-8?B?b3NIVTRKS1lFSmtSdXd1dXYvaWtuWVhxQk9YaHIrNld1S1BIZWVoN3lFbHRo?=
 =?utf-8?B?SXE0TmdRRDB2eDBid0Q0Z3B5eHVobkxtOTNYV0ViTzJXRVMrMkhieGVuYW94?=
 =?utf-8?B?NzVQZnBuZklmTVowdnFiUWZTejdkaGh3M3FtWkR0c1FnS25INC9iQ2UxSkRl?=
 =?utf-8?B?aHV2OVd4aEJ6ZkJIOXV4SXFBb3RmU1J1c3QyditVOHlMdVIzZjc1Sm95TXpD?=
 =?utf-8?B?eUFzMmRNMnFvVlNQcWpiaXlVMVNBWnZGcEVkQndaa2lHU2k4OXE2VWhFUDVv?=
 =?utf-8?B?MTJBUDd6T3ZCWXNkaUNkVmJteW1JUnBNTzl6QStTTXhNRGlWcFB4dFd0aXJv?=
 =?utf-8?B?dXVjZnVkTW1EMGM5Ly9uZWtEQlQzUVN0RGxUQldTR3lXbHZlRWV5Zm12Mkg4?=
 =?utf-8?B?WXlLbUlJbUl0eWdPZG44UVVIeitNdHNYS3NwY21XZXFndnFNT0tIajE0anZz?=
 =?utf-8?B?ZkxKblIvRXpWOWpLOWxxcG5UUmJPaUd3TFVWcm85S0svNms2U0hzUXhnbk9O?=
 =?utf-8?B?Nnd5VFdMd2ZEWmdPQnNjR3hsT2xJQzVSRzRDWmVXSm5QcCtUWUt1MWpOY3RK?=
 =?utf-8?B?dCt5aFZPN29aemRPTVJnN2hCWldQdkVOZTFrYWhKWldNOTRhL3RlcnRydTdJ?=
 =?utf-8?B?WkplK3pkZmxsbzFmeVArTWlIQWFRM25PVFN0MEw4SE5qczI0WGlKbDY5NGFi?=
 =?utf-8?B?ZCtmM2pOc2tjODhsWVVabjliMXpPQk5qNnBtSnVGM0tDVVlHaGJJNWlzTlla?=
 =?utf-8?B?THNiY05wYkFxN0RLMTVLKzExREc1aW42MTJ1Ti9SaUo0S1lZYnZNVmtVYlMw?=
 =?utf-8?B?MkI1aWRzZGRXWFlNV2I4WHVKb3NjNnRYMlp4aVJRQ2orZFQ1eXJOVUMzQ2VQ?=
 =?utf-8?B?cVFsbk5sdFBiZGlEeU9WNWczUWhSMnEzL2Y4VEFCY0dyMWRTSERwR0dvMTZG?=
 =?utf-8?B?cjRneTNZdG4wWFVzYmFyUXhMOTRGUkl5c1JReDRvVHhMZG5nSWwycUVFQkMr?=
 =?utf-8?B?WVJzM3F6VVoyYWR4Ymw2Skcyc2xpT2dJUUQ5L25mRCtpMFpKdkk0NmpvaGYx?=
 =?utf-8?B?a1VQdE5DdnhTN2tiWUcrdFlNY0d2V1FiMVBKN3RjM3VTZXZ6VlFoMndoMVNE?=
 =?utf-8?B?N3JwYmdNVElvdDAvdEhYajRqU3plM2lPTVhpVUVxemoyMGZSb20zVmtPcnRY?=
 =?utf-8?B?UTJpTkNjbkpxdGpSNy9ralNWRDRlMnJnYkVndldJczVGQ0o1Rm5aU2UvbkNJ?=
 =?utf-8?B?NXBnc1doVTFpRVVPdy9tb01NL3orMDJPaGx0WExLOXQrbjEyUEZic3VWUW84?=
 =?utf-8?B?ejdPQWRkUmp4RFJlRTRvRUF6WjRMZDlRZ3o1bGtKVmlvOHRwNEswMnVuNGxT?=
 =?utf-8?B?SUFZdG95UW8rZVF4OGNyajBOS3dmZU1WS3JUOFJURTVpRkpLT3NLSGdKRUZE?=
 =?utf-8?B?SmxjZURSN3F3UGxUS1NZU1N4S0dXRi9tVU1HdjhMRkRaeWdTNTdsUWZDc3Np?=
 =?utf-8?B?aDFVOFlUMTRQME5oU3VqLzNkZm1TZ0ViT3IwKzVNTkljVk5xbFoxMHprbzNB?=
 =?utf-8?B?YUFBb2hKVVgzazBLQW1hU2FrRmkxeUNFN0pkenZUSzdDc2doMFNPUWVteTha?=
 =?utf-8?B?aGRjVTRQaUMxU2dCRzhFbkNYbkV6U3FHVnBwaUI5eHgwajh4OEMyWWJxL29Y?=
 =?utf-8?B?SDFvK29mNGNOaU8wK3NacGwxUTJmeUV3Z3hOZ01IK0pZemtJVi9rT041UFZU?=
 =?utf-8?B?TmpZQ1FHVEZlVWlVMEVmRnNQVGx1cndDdTIvTkJvRDNkMCtoeVRaRlM4ejAr?=
 =?utf-8?B?cEkxSHdUbVlsSmtPUmtROUxGTXk5Q2tFNzFGb3BwclQvNTlkZHZnNkNqU3pQ?=
 =?utf-8?B?NEV0M1BOL2xaemFSUlkxQ2Q5VDlrNEVMRU1UanR1dWJPNVowdVc2aXE3V0Zl?=
 =?utf-8?B?djVKOE5IdHpjWXRKcGFtcjhjbTVVREZ4RHdWUmV5Z2xyY2R5K3dpMllvaGFH?=
 =?utf-8?B?SzBMQXY1U2dyK2xuakRPcHBybFoyaWluYjlSeDlFL0p3ZDEzekJxL3lyOTV1?=
 =?utf-8?B?a2JDZ25pbTlTbjIwTlJUc1ZkdEUxYmVDaG9BVDFmcGR0bGZxZUZadTZKcVNK?=
 =?utf-8?B?T3FvR0RJTlB3TzJXNTdUUU4ySWJjMVZEWjRLY0drL2VlbTFPZTVZSFV2emF0?=
 =?utf-8?B?c1BHWTdzVjhad1dqMkVkV2Vld1NWWUk1QUU2UzJ2WjV2S0RjeTBUTFV0TlhW?=
 =?utf-8?Q?ljieJZ3wAqWbXy4BFK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8398d806-3482-4998-48ea-08de94740b04
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 07:05:25.9139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NL6qN/YXnh3rU67seGqJptVWha/w+CXx75y/6V3O5bg78dkwwF2vgdeMQIZQxZaG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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



On 07-Apr-26 8:39 AM, Yang Wang wrote:
> parse and print detailed reasons for od table upload failures to
> help users understand error causes.
> 
> example:
> $ echo "0 30 40" | sudo tee fan_curve
> $ echo "1 40 30" | sudo tee fan_curve
> $ echo "c" | sudo tee fan_curve
> 
> kernel log:
> [   75.040174] amdgpu 0000:0a:00.0: Failed to upload overdrive table, ret:-5
> [   75.040178] amdgpu 0000:0a:00.0: Invalid overdrive table content: OD_FAN_CURVE_PWM_ERROR (13)
> [   75.040181] amdgpu 0000:0a:00.0: Failed to upload overdrive table!
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 60 ++++++++++++++++---
>   1 file changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 0bad56a44f5c..0ccad0b48c09 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2230,17 +2230,61 @@ static void smu_v14_0_2_dump_od_table(struct smu_context *smu,
>   		 od_table->OverDriveTable.FanMode);
>   }
>   
> +#define OD_ERROR_MSG_MAP(msg) \
> +	[msg] = #msg
> +
> +static const char *od_error_message[] = {
> +	OD_ERROR_MSG_MAP(OD_REQUEST_ADVANCED_NOT_SUPPORTED),
> +	OD_ERROR_MSG_MAP(OD_UNSUPPORTED_FEATURE),
> +	OD_ERROR_MSG_MAP(OD_INVALID_FEATURE_COMBO_ERROR),
> +	OD_ERROR_MSG_MAP(OD_GFXCLK_VF_CURVE_OFFSET_ERROR),
> +	OD_ERROR_MSG_MAP(OD_VDD_GFX_VMAX_ERROR),
> +	OD_ERROR_MSG_MAP(OD_VDD_SOC_VMAX_ERROR),
> +	OD_ERROR_MSG_MAP(OD_PPT_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FAN_MIN_PWM_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FAN_ACOUSTIC_TARGET_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FAN_ACOUSTIC_LIMIT_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FAN_TARGET_TEMP_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FAN_ZERO_RPM_STOP_TEMP_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FAN_CURVE_PWM_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FAN_CURVE_TEMP_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FULL_CTRL_GFXCLK_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FULL_CTRL_UCLK_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FULL_CTRL_FCLK_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FULL_CTRL_VDD_GFX_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FULL_CTRL_VDD_SOC_ERROR),
> +	OD_ERROR_MSG_MAP(OD_TDC_ERROR),
> +	OD_ERROR_MSG_MAP(OD_GFXCLK_ERROR),
> +	OD_ERROR_MSG_MAP(OD_UCLK_ERROR),
> +	OD_ERROR_MSG_MAP(OD_FCLK_ERROR),
> +	OD_ERROR_MSG_MAP(OD_OP_TEMP_ERROR),
> +	OD_ERROR_MSG_MAP(OD_OP_GFX_EDC_ERROR),
> +	OD_ERROR_MSG_MAP(OD_OP_GFX_PCC_ERROR),
> +	OD_ERROR_MSG_MAP(OD_POWER_FEATURE_CTRL_ERROR),
> +};
> +
>   static int smu_v14_0_2_upload_overdrive_table(struct smu_context *smu,
>   					      OverDriveTableExternal_t *od_table)
>   {
> -	int ret;
> -	ret = smu_cmn_update_table(smu,
> -				   SMU_TABLE_OVERDRIVE,
> -				   0,
> -				   (void *)od_table,
> -				   true);
> -	if (ret)
> -		dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
> +	uint32_t read_arg = 0;
> +	int ret, od_error_type;
> +
> +	ret = smu_cmn_update_table_read_arg(smu,
> +					    SMU_TABLE_OVERDRIVE,
> +					    0,
> +					    (void *)od_table,
> +					    &read_arg,
> +					    true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to upload overdrive table, ret:%d\n", ret);
> +		if ((read_arg & 0xff) == TABLE_TRANSFER_FAILED) {
> +			od_error_type = read_arg >> 16;
> +			dev_err(smu->adev->dev, "Invalid overdrive table content: %s (%d)\n",
> +				od_error_type < ARRAY_SIZE(od_error_message) ?
> +				od_error_message[od_error_type] : "unknown",
> +				od_error_type);
> +		}
> +	}
>   
>   	return ret;
>   }

