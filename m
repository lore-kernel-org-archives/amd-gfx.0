Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D4AC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E1510F288;
	Thu,  2 Jul 2026 10:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcHQP4GF";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBC010E492
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXBUsSFavYlmC1L55JFDdWt2a1y/Aa9DIKMkzgsR4FLQ5JWSE0T6uxJdNQJsTF/kWQT2q25JLE2iO7rK/uZCMrjho6PX+byQpUERZyN8UJdLjzqDfrIYU3xoU3iBzKXp6ze1T6WgfHPuM3Kwiyr8cNdA0x4pvYcyX834nvlBVY7AjEM9ig8aNjp9T3cDVqZYoNcdYfo9faKeVL5J7VK/DXZCRoE3VVX60fJzvkuk6AKqj03nM1rUx0aZjXkfupmqDDOBHyyP4Lopv5HAUovQa0giFt5zf8DbZlqL8/9gm9gUDbKRCsuAx3fYkZmJXGVkQknUOoOju55l7yYoylLvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2pynok3TcOO5KoO1jeI8aogpTh4ZEVwJ0/WxviqY3I=;
 b=g1EKmaVm4H+QHUR8pmJeDe2vVkc9hmL/cRkbvjzy5cSENwiwWbZV27/3tjG3o3Dw+SNnf5LcXKHYvOojjQQRgLV8Y+9c0er8xWSqEBRQlFQRT7Y4S6ao3RAChdbwk1/Zdj20lGyAi4cYgZ8/9c/LepJnJuxI5tbYAF7o+PgVMCOJIFFuGUWOnnncBnQWlB7EM5paD+tJdBIUQouwaiSnVSOwkn/8tSOvVdejnMmnSWkeanFQROAV+VWNROYsVlbasTFhofRPazZ8A/LXN8E5qhcuVQdj271jCUgV1s/SSM/dH70lO1QlC1iArxIsWXXtyHRkl/Cj2pjlKu0Z0d512g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2pynok3TcOO5KoO1jeI8aogpTh4ZEVwJ0/WxviqY3I=;
 b=rcHQP4GFJ0Pz1X3WZM3SdAAt2mwhQml0Olo7+uglNaGJhJZM5dJOHtr6olGW4n4VTeNZBPwMonB+5+gMqsmvQmp18rn2CIAAXZQGu6xkfz1L0Jf6xQqy3wAiCeSe9+jFcjvMow74WcEy2aSEz9yplWh9vUhGZxl/KIHROp9wCoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:18:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:18:11 +0000
Message-ID: <73c9fb38-fb4b-4e3d-84c2-bf5553b26758@amd.com>
Date: Thu, 2 Jul 2026 12:18:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] drm/amdgpu/gmc12: Pass cam_index to retry fault
 handler
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-9-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-9-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da260be-c347-4da0-863c-08ded823382e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: bwMDIh4UkoVnH3V0SCZZpfnJoeaM59IMdCsaO9SpnHIVgdVwpdonbtY1WrERCTeezkWMP3JPQ9umiOydH0awV7efILsbOwYlzhJxUfzrL7o5nBoKEwZwj55Ms2rTSwPT5xD8FYNjimYQf2Fz98YvH/oyN8WrofYDxBYf0XFZz1NBJQy/SR8gT7yXxq2H2DnOoAy0smotv5yJpVaZeaKascoEFHSd1oCnE0QahfrlxvhTNXZlDDaH1227wpIAC7y5Ppm06aVJ4RG2BWl7rjJXHqQ/h7a07eghYjDhud/5qSfovjJI/TevvlFi0AWGBGwm6+nOMqoW/BgEmwQH/6O3ZfvEoxXt/npHjt1VWBH5UmV3Ed7P3TFTpHb21M1Btk6gvdmSWR5BT5C9FcdVJWFuwQgROtdi/tL2yGe7EBTHcxVuyzfHzlYnjU6F26LL+U11SpArG2CwWaIU0sBHKITj0QfKPOeAmnZGm07KDXpYdiDt6cJxxgYG5s+X4eNe2HbLWSwBxhxNd3yt04nY0YekSC1DfJGYgp4hkLCE3thVxc7H3j/e+XeQ9MQCeJz0RsEsAkXgE11aqG46l22HB/+NphydbhfbokZv62MNeUEPT/shTfEHWK6jAvOvvgCbnEJV5g2hMGFVKzkkAbzk2FnhRvX0UHwdw5tDGh8mEM+Ti0f85Hyq6I1LRSYTeqCW0exqESIhIR2wRN8NtdHlCwM51w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEg2YXFJbE5IQzY4YVZSeW1DNEFTKzVxdFVVNS9ZQnZhYzI2YTZqaFk4ajZv?=
 =?utf-8?B?dllNRFByYVZBVHNBamk5eDBUTllVeXptSU16eXhPNVhTbko3T1Z4UkFxYWZX?=
 =?utf-8?B?aDFBWGhwMGZVZmMrMzB4NTAvczlTU3hOWEpydVRFRG1SVXR1aE5nMngvZHQv?=
 =?utf-8?B?VWRsbE0yT1lZN01nLzJMVmJPRGV5RmdVN2h5WTBmVFVwc3hkTS9RMVdyWXRI?=
 =?utf-8?B?by9vWDRvNUp2T3AzTVBqdmNOSnovayszcmFZQWQ2TkwvQU13OHNxL080OTZO?=
 =?utf-8?B?cFZMc0lwL3cwS0xJNndTbUlmaVUzazZ4VEJrM2pUdndScG5jb2hEZkFqRVhN?=
 =?utf-8?B?Z0VpaEt3UEpvSXZuYTVoeWMyVkJoekU4Z2M4VjBJQ0MyL0FyZ2Z3RWRxV0lJ?=
 =?utf-8?B?WWFweEEvTFJoYUwwV2pEYmF6UUNEZ1ZNN1VIQkI2TW9WSVU4Um5sYTZWWVhQ?=
 =?utf-8?B?ZlRKMTk1VmFNd2VvN2pGS1V6bGtndm1ST2t5MWp4WGhocytRaHppakZQSVNq?=
 =?utf-8?B?QVE2cmt3TzVKdUtXdUpNYTEzRXllbWE4aXp4Rndsc3J5V3RWbGYrdFNaaGpo?=
 =?utf-8?B?eXdpQjU5TjZCeDBud0ZsY3dnaGY2a1hOZG1KcVR5ZzkrQktUT3UySE5wVWM1?=
 =?utf-8?B?TjV0a2w5T1Q3bzlORFBNeHRxMkRNaXRmWDBJdDFMd01kNWFBK1RUeW5WcjFx?=
 =?utf-8?B?K2pmVHdTWUx2VVJxdHpzY0I2SDRzcndwRlgyaXp2UWwvOXpxeWRvVVo2RGU5?=
 =?utf-8?B?cVNDSWwzTSttcmovLy9rVmNOdnZjZW5uQUNxeEdRV29ydXQwdG5hcnkxS1ZD?=
 =?utf-8?B?dEY1U3BqNXhOQ3NGc1psM2RxK3cvUFFiendCL05DRXFhQTBiM1E3bWpsTEZm?=
 =?utf-8?B?bjNXc3RyT090NkJzZjBwQWlWclNHTFlYcVJZbmJUOFNLTnhZdGp4RktEWG93?=
 =?utf-8?B?bFJGRDV0SW1CMEEraEpoRTZ3K1lTc3h5MW5RcG1qYUdJYVRlSEs4MVAyM1dT?=
 =?utf-8?B?OFUxOHpSSjNrRE02cXVjRUVQaHI3SndRS1VsbURidnVlYUdBanZ1ME1LTlFW?=
 =?utf-8?B?UHFNVTZGalhYUjdJZVFFb1c1c3d5V1AyTnU1ZmxvQWx0bTdSU2ZHVXZxSEFv?=
 =?utf-8?B?VURFVlEzSXVVWnhyUUtiV0Z4NGNLeTJTMW1oSzNmTlJacG5qOXRPZERhVitY?=
 =?utf-8?B?VWU1OU5HWi9BdmYwOGw5dlJsNnZJWUFtUUFJeWlSUXBlS1NPdlZ6aDRHNFFJ?=
 =?utf-8?B?UzBVOXRlMUdIMFlpdlZvYzZWcUxrQ1UxTEdXc3hsYUtEQW1DaWhmTWk1Wnc0?=
 =?utf-8?B?VVdEWGZ5bldCZjRyQWFTYmdJbXg3T2kwR0liRVpNYlh5Q3lFOUJ6cGVqdXo4?=
 =?utf-8?B?eisxeGR0RnozQUNJazZsdlZHTXVSWUd4ZGg4c044Y1RLNEg5K3ZJcWQxTUla?=
 =?utf-8?B?Vklwd21UL0NFT3pWL21tN3lTYXowTUJ6NVFiSVRwOUFHU1BhazJxazF4clY3?=
 =?utf-8?B?clNBUk1FOW5rRlQrVHM5VW91QlQreG1BTkFiZ1liYWZZNHI0UjA4MFNmcmx5?=
 =?utf-8?B?aHlOVFF4VTVhOFFobUhIRzAzVXZCNWZ3czQvREJ2b0M2cFNQY1BxRnlLVXNI?=
 =?utf-8?B?UE5HMmNITzZ3M0gxSXYvQ21KbklhWGRYOUloN0ZjNjFjWXR0NlhGQXRTNHpQ?=
 =?utf-8?B?T0Y5end0Yi9jOXZHbWNaUVoxNWV0OTVKUTNjNmFjZERtWVFFYnl0R25JN0lm?=
 =?utf-8?B?eC83eGRWSDJWQ3hTNjBVOVFVUzRNbkJ2QlFoN014SGh3eHVjSktoQy9vTnRu?=
 =?utf-8?B?dVVhRXBrWVNqa3Z4UkVMMGhRTCt6bjJ2U2NnZDN2Nk02SzFmOTluYjdkSFk2?=
 =?utf-8?B?bDR2TFV2YXNlbUhBcGpPSWJEMGlFME91aHo0L0xsdjJSQlRzZnNEakpDdThO?=
 =?utf-8?B?bE1qcDlHdlM0VUg5czlVRnJvY2tHMld0dHdkUGpTaDI4ZUpiODljS0tDaVVH?=
 =?utf-8?B?RnBJTzN1dmJJQ3NPdytPeWo5RnVpeEI0VWJ4Z2lndlFtYlBKb3NqTzllYmhs?=
 =?utf-8?B?UWZrdzFSVE9oN3M4RHlmVzZjUzEyLzV6MnQ4bUp6cnNqcHQ0TUFGcjg3UTg1?=
 =?utf-8?B?dGVFazFueWZ0U04wckloalJFUDFQVU1SWFRCNEQ3enVobFNBQmpaTVRQUCsr?=
 =?utf-8?B?UnRjRW43MmNIek5ORGx2VG0yTkwyaTdlY1NFZUxCWmc2MDFxVnhOYzJtY052?=
 =?utf-8?B?RmJPdWo1a1YrYnhvcjZFa1lsVDQ0RlErRU5mWnJHVml6V1pCWXBpSW5KMmZB?=
 =?utf-8?Q?7VZjq4W2JTJ7WWkQtU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da260be-c347-4da0-863c-08ded823382e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:18:11.2743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkYA79PLRGi76pHT4YWYjzGvJfH02qXzWMMoCEhv04kS0ZO0iCz0hDfBBLTYg8SY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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



On 7/1/26 18:17, Timur Kristóf wrote:
> This is necessary if we want to make use of the filter CAM.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 84c93364d220..299fe960b99e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -99,6 +99,7 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
>  	bool write_fault = !!(entry->src_data[1] &
>  			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
>  	uint32_t status = 0;
> +	uint32_t cam_index;
>  	u64 addr;

Same as patch #7, declare "int ret;" here instead.

Christian.

>  
>  	addr = (u64)entry->src_data[0] << 12;
> @@ -110,7 +111,9 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
>  		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>  
>  	if (retry_fault) {
> -		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
> +		cam_index = entry->src_data[2] & 0x3ff;
> +
> +		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, 0,
>  							write_fault);
>  		/* Returning 1 here also prevents sending the IV to the KFD */
>  		if (ret == 1)

