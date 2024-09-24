Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A81ACF9C73
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 12:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFEF10E8B4;
	Tue, 24 Sep 2024 12:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0zOBJuZ4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3658610E8B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 12:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkM/m9Vs10qZS82fDeum2CqZIP/2CZz/hNtQ3TXi76937QVOg/57rG7vxRkpU1aLW/OgoPyPz9g6tqtQXGtVcaNVu8NPcvWbDi7Xp3P91huTmEf+Cyp+S2NhHzVkUoxHgGDFhmbkKa5P14+1IXAWB26XjG5dh9t2yDZowiJJzGW+IDWKSDqZt69i1ypakPrOVdDNVR77PoF3t/S5mrxKsone8/a3+kXhiWAv7sb+HOGuTSdwrU5vz39dkxnOYevmyuLqGeTmle60+pnp2YFDccnUiIQWIoBOKB+Ip+9ZFYi3c0Owfdz6LgdU2h2Tc6IokPerEt6bedXeABl1dytGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BBG3UldGzQR2+oYWda92sMRq96F+WYFEVD4RPXWEvw=;
 b=zKZU9eYm45SIrOBTSfj7nAsLBXHoh/y1JITlHs4ystSu0AHk575XZPyfSL+CUOGSZ9s8SVQpvAeaz9RHA6P/9ARBiLaTG6bSpkJ/crEBLuMhCtrovJEHGhgqNdyrDTBixubZnAryBgMbkV68iWhnq71rR35+O2Nuh7u0TeXZfjlJlEvUuhiWOGtIMxqZA5k5fGpXKmCJDhp5WWKpyk+Jm7TFqVxHZNMfRCCyCj33vT7oHgVSewy+eqcNKOWyJYTGfLS4h7EhRV++yZal29Yi1DXysm6JCbzKBUcIWtjrabgonaeK9vdW7FaRuuR+kRT8WTZC34wgoPbx3sAwfKgnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BBG3UldGzQR2+oYWda92sMRq96F+WYFEVD4RPXWEvw=;
 b=0zOBJuZ44xTzjQYqmzouh7DCIRg2XULmKPnx9KVe/ONtiWrD5NthsHeLJ0Bq7aYJb0dFOk2PjQli76CIn5wPvV6n56vuxAIU3wRobM4y/dWaT42zDekm6KjjBIa1YRw2ricn+PSVD7gdi2cCrLTcNTVoBUxCLz0QSV5hUplfmwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 12:24:49 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 12:24:48 +0000
Message-ID: <a9bff99d-6d93-46bd-a13f-43a145adf93d@amd.com>
Date: Tue, 24 Sep 2024 17:54:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/powerplay: skip enable mgpu fan boost in SRIOV
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, yifan.zha@amd.com
References: <20240924034012.237955-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240924034012.237955-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be9e91f-9f2a-4fae-3504-08dcdc93e1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTRDQlowa1hpTlptYW1LRjBicy9WUWlxN2JZNktpR2pKZlk3RW9LOTdzRXNa?=
 =?utf-8?B?SGt3cHBtTjJaa1RaOCt6Q29lcWpZZmh3VFpZNU5oSVVvbGZWZ0FkeExMaUpU?=
 =?utf-8?B?aGJTczVFZlNVVkJSRE5OaDllbkNUaHJEeEdldGttQ1pEc1cvREhKR1dtWW5q?=
 =?utf-8?B?ME5XL2YxVVgxY2dkOGlzci82TFduMTBYTnJQQkZKUThyNVl1NlJJMlc3dVNK?=
 =?utf-8?B?OS9oNEJPeVZOTTQwdnVkZmJkdVJ5SDRzMy9lZ05wK0U2azNHcjNpbDY3MUN0?=
 =?utf-8?B?SVRVclk0OXgxQktFWFB1RkgvZkVoaWtFN3hCSnYraGtLTU40NkV0bG1mY2wr?=
 =?utf-8?B?SEFTTWhBakdNSTZ6cUdGR0NhQjVzdHJYczNKeENwSGdIc2xKZ3pBNjJPTHNu?=
 =?utf-8?B?cm1QcEdncytwdTR2ZXA3a1UvNzMvSnFBM3R4aE1jL1ZmelROdXBOM0dIMzdp?=
 =?utf-8?B?a1U3U0dFODlHWWhMaUVrQUpjeWhQOXREREYydFNmSndhSGhNNkJGQXpWSHZU?=
 =?utf-8?B?Z01Ma0UvbWZBUmhqdzM1T294VjNtWVNIaXZVTEx0TllxN3QxcXNjMzE4WTZF?=
 =?utf-8?B?WS9kVm4wUk5LVTVXdGphL08zR0NSZjJFQlUxNEgzMHJNdUZPYnZ2MGg4TW5X?=
 =?utf-8?B?OVZSRUpwdm00Q1RQRjF3ZEpyY0Z5K2kxb1JZaXBMaVNhZEdtZFQ3V2NyT05y?=
 =?utf-8?B?cEFvQXhxdFB5M3JScjFiOSswNmJZOGNyVWllUTVCZUhUangyZThtaWFaUDdF?=
 =?utf-8?B?MWJVdGczb05XeUtMZkYvK3gwYVBPQTlmbjRERjRPQ1RCWjM1TDYzYjVBMklp?=
 =?utf-8?B?Z3IrejZDVXZCKzh0TFVja3pxTEZ2WjVKakd5Q3MwYzBmNGlKUGdrbjZaRmVH?=
 =?utf-8?B?MWxTMVFBRFNkSGRNZlJjNS9JL1kxVFJLaGoxZ3VtcW1JdUxJLy9LNlprUnp3?=
 =?utf-8?B?L2VNOGI2QXRxZk9HUTJaS1AyQnRyUy9rZ211YlVQZWFvOFFwN2xkNjZaR284?=
 =?utf-8?B?S1lMaFRLdm5pYlZCSlRKTTg1V2dhZ3BIVXgzNmlhSllySkRLV0ZyNnkwS25q?=
 =?utf-8?B?OUZXTHEySGpQNW5JZTE4YUVXSDM3My9iRlR5YVlQblVBazdmL3BweXdIL2Vw?=
 =?utf-8?B?Z01ueWdseGVZQzFMM2dyejVaMmNPS3JrZTNxWGZiRHV4K1IxdlR0SmJRVUNa?=
 =?utf-8?B?ZXZOUFA0K1ZYY1g0RHNQSDVrQnhpbzNkK2hYd2tacko1bWE1aDZQMzJ6MFBF?=
 =?utf-8?B?T0FXb2ordHRTcDhSTjlzTmhsSUNJenBXYXprcEN3Z08xanhPSWJodFVoVHB1?=
 =?utf-8?B?a2laYnlqNmpYeWhQWm1pbVdJZzM2UThwcnVPK2xTdU0zNk1WR0doZkltV1Yz?=
 =?utf-8?B?ODhCVGZpNEpSZGZGc1BwRGcxbjlOTEZCM2YydnlUVkhzVThNcmJrOUpiY0pH?=
 =?utf-8?B?eEZjQnZkOEdVRmlZU3d3UGdrbmRGQmRMMDYvOW5lZ1ZUdVA0ZnYrbDlRQUxz?=
 =?utf-8?B?QVRrSzIxdDdLQ0VkYXFHN3ZXMEQvdDU4bDQxL3lxcVhIOGhoUzZkN0x5N1dr?=
 =?utf-8?B?L3I4WlFDaVdGeXlabUoxYmJYZGR3cCtZWEo5YUlsS3Q3Z21HS2tZeXZkc2hk?=
 =?utf-8?B?UXkyZnUwVXBFQUtTTE1XMDJiU2JnQ0tkNmJ4b2tlWHltb2QreUwzeUtnTDF3?=
 =?utf-8?B?U3BudXdHUklhbXVJN1M4azZCMHdseUdsbFM0bWpTdEpNNnA5ZFoySmJaUlFT?=
 =?utf-8?B?alFHM3VRUU45RVIrL3gwRUtVZmtmYnVpMEJXSEd2eWpFNklOcjg4SnIzQjBy?=
 =?utf-8?B?NEdYckp3d3d5c05WQnNtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnBPT29wRGtESlhna3dScHh2NU8xWGI1RXpVSmc5WmUyanZsNzhEaHJLVGs2?=
 =?utf-8?B?N3RkTldlVEVIc2lydHZvR2JCZHRiSURxUEFQeDlZRzRHVURXOW1TNXNtanpj?=
 =?utf-8?B?YUdHSDduaW1wdXhlRWtMMmtNbXk5ZDg3MkJXWE0wSDMyejh6ZUVCWDJUNjl0?=
 =?utf-8?B?SC9YMnZWSDRhZXJjVk04czNBc0x6WFJqa1gyVGhkYkJ1VzVuWWdaeUtFZzF2?=
 =?utf-8?B?Q3FZN2JGRElDcWxJVVgwOUwxVzNkNEJjTjNKQ3pHZnUyYUo0ek1XU3puMWRk?=
 =?utf-8?B?UnRaYk95UG4xNi9zdm5KalM3Y1Rzbk1SWWdta0Z1cUt6NnJhTVVuc05XcVpO?=
 =?utf-8?B?NDlXVXE4OEY4dlJUbit6NzNTQWs3eTJDdUFMNnB1ZWJSN3FvQ1MyWUhycVJB?=
 =?utf-8?B?S25RYXhnQ2htTXdzZlhXUmxUNlZhZzgvUVpTWTd0a0RyNnVVM0tXRjR4dnhE?=
 =?utf-8?B?bjc0bG1RYTY1MENsa3l1aXY5Q1JhNjQyTllmOTB0aUxMRGpTdjdNS01JTVFk?=
 =?utf-8?B?dG1hV2lDdnpOMTZXUGJNbnFNRVk3UExzUEcwTHQ1ZzEwL2V4ME9HSk1rNVky?=
 =?utf-8?B?cEpVbjQvTERxNVFhY0dIU2hzNUFoTDc5M09WVWZDRWtCeVBLeWNRV2ZKb05P?=
 =?utf-8?B?aFpRTHAzMGZUNzdyRVdkL040bHdTT092VC9zRWhocStiYWtKdG1Ybk50UUlh?=
 =?utf-8?B?YnJmeXpzZ1FQdVc1QVhpeGNPZzlpaElmcGpUbU42S0JNc0s2dnpaejFXMkR1?=
 =?utf-8?B?SEVLM0l6WVp4ZWZMTGFseC9SWDJVa2lDZVoyZ2ZLb0UwdVpIYWcrLzJRdlJl?=
 =?utf-8?B?eXZkaXVBaDcvWXRueFpDYS9kTkwxMHE2c2dzRDEvMzlrRDBPLzRHREdtZ1NB?=
 =?utf-8?B?TEZ4djZ4QXU5NHFkdW9wdFFxdThXak5ONGJ1akFLV3c4a0UvNEtBQUR5QTZ1?=
 =?utf-8?B?RjM3bTliWWpYa1VBOXFsQzVtd0Q1WHg1VXVqc0wwS2hPSDMyZVZtMzYvYnQy?=
 =?utf-8?B?V2w3VlgvYk1kOVVXajMzOVZXUVVmZHc3NEk2TkhjQVR4TGlweFdMcWVOT21O?=
 =?utf-8?B?a2RoOUhMby9QZGl6MUkxUnR0OGNZazlsbW5USWhiS2tWamxlbzJJMUhkYTk4?=
 =?utf-8?B?aDBJTCtNTGpDRVF6dW9pUkhSQkwycHdXVjdxbHlobGxXUVY2Y3IyL3BOYjVN?=
 =?utf-8?B?d1E1RXQxMXRmQisrbWIxRzJCcm94SnJ2Rmt1bStSNjV6dGcwS1lwV3YzejJh?=
 =?utf-8?B?YitYQnY3RHkzREIzRjd0RjFrbEZwNlBvaEJSeVRMd2U1SS9naTRWZUtSZmZ2?=
 =?utf-8?B?TGdYcUZ0dG5JcG5UcGtZNmdOZGZTcC9FcVI4Q0hkd2c0bkRIeUVxUDg2VHAy?=
 =?utf-8?B?M3l5NDk5WFljcDYrSDJnUEVHQU9yQXlCcEU1Ti81TnNsbGFDc053YlJpREhU?=
 =?utf-8?B?Wnh4UjZVc0FyaWJZTWlHS0ZpbmhWdHFHUUFtRmRpa1h1dHF6Um1aOEU5WjV1?=
 =?utf-8?B?ejMrN1RVZ3FWY3lCTHVzdTRObWhlZ1lqT2hVa0hHTWlPRFhibU0wdjZSRk9r?=
 =?utf-8?B?bmZ5YmZ3bGltMFQ5cGRrbGpGT2ZLcUtna05Fdm0wL1BTTWlGYzF1UHVFQnN6?=
 =?utf-8?B?WE9BcTBCT0Q4amhiZ0FleFRLUjJrVFc4a2I0RDAxZ0pGdzM4Q2pnS0dlVkxI?=
 =?utf-8?B?cFZGWHNvQTB5dFZSLytMUzFYS3VwM3phZEVCdjRjdUgwanJpOTIxcXlYdzhz?=
 =?utf-8?B?RkJ6UkNJV0V5VytGR2xRMFZSTXkrd20waTJ0UGVGd1VYc3JFaWVwTmZPejA5?=
 =?utf-8?B?WG03b1V2MkNmWDhkdmFZWXBXYThlRkVwRmFlWDJrMlphbjh1SFVoNW1waFhk?=
 =?utf-8?B?YmJPelJhQlI2WTZvQUhCTi9uVC9jclYvREFBUmZMNnVleDJXQXhIOTdFTlht?=
 =?utf-8?B?eWdoRWN1dFpHdWR2UFh1anNYMEN1dmc5ME00Zlo5V1JzdVlCK0E1R3R3L0Rx?=
 =?utf-8?B?ME4zMjR3UU52dEVnQU5yemJBa0szS2VvcnYxZ3U3VlZHaFRUMGxhMHhhNlhK?=
 =?utf-8?B?TG4yS3NYQ1pFODA3QVBXMGszQXpyR25pNHRuT282K3lRNXkxV0ZiVkJRQTVu?=
 =?utf-8?Q?IRM4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be9e91f-9f2a-4fae-3504-08dcdc93e1db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 12:24:48.8935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA829Rhs9IP+/ysKIAzEek6Q48qdXFPuOpRCgqL4yMbBV+qBvs+Axa83i0EBrf0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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



On 9/24/2024 9:10 AM, ZhenGuo Yin wrote:
> SMU_MSG_SetMGpuFanBoostLimitRpm is unsupported for VF,
> skip enabling mgpu fan boost in SRIOV.
> 
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index dee57f15719e..49f320fc974a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3178,7 +3178,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(void)
>  	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>  		gpu_ins = &(mgpu_info.gpu_ins[i]);
>  		adev = gpu_ins->adev;
> -		if (!(adev->flags & AMD_IS_APU) &&
> +		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev) &&
>  		    !gpu_ins->mgpu_fan_enabled) {
>  			ret = amdgpu_dpm_enable_mgpu_fan_boost(adev);

Better to move the fix inside amdgpu_dpm_enable_mgpu_fan_boost() so that
any other call to this coming from some other piece of code also doesn't
do anything for this.

Thanks,
Lijo

>  			if (ret)
