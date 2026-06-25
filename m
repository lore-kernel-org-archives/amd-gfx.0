Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E673CDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 10:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E5D10F244;
	Thu, 25 Jun 2026 10:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YQRN8JNX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B4A10F244
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 10:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPvUZDZNpWt1m+hnoGJW6swA3Hj2r9+Y8E0m1SKjrE0S9n2ddHnLcsURq4agJuUMjwdgM42bIrRyHipP0OU8lMGmxzuuuThpn6twLWYI7DH/GbBvZhdGgpO6iC39zShXUw2HcaBdDJz4TZXGinfkPDj8YfaaQUF7CErqUjRs709LP2t/qBTklReN+I6X7/9Zhva6v4axE1R9n2aq7na+RsOIDsmgVh3JIdXS9VN/InTJNhsUnhdQdZTiNQThK3tHrWbnifBlAvMJTmiqIsO8oWHfHgFM7jeVDFt+Y8fA2sAHi8ClfXgUlIQJflRkF4/yqG4uaa4Jz96gnbohRyPeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLYhx0QWFoxUjJ7Ma6IbuU+U3Ay8gdb9HS/n8kH8Tss=;
 b=KhW5RAHQr06g7zuCuu077EhQCpRbxO2IL38GEaqXdxY5phnUQU329+kQ02SkTgSsz9r11twW7B9OavNTMNWr78oYuAUWk6HGQ52HfgMd2sGn2AQ4Fsp7cAhXEI3g0910roJdH+E3h6GH/bhex15sytUB1bj1rWW1Yq3XNP66BGRNdusaEmqY+/rmBHyqGET+Nl7eu1tt5vtFDt1i9AaEJNWujIybkc2aAvaxWLNT8PANPQr80g8/2CKWSGKG7LTLrmTtaH9yUY+g1XcpyPzJwU49ZHFS7JNgATgPQIi4dtbzNT/1c3pDAg/NROS9+2A5UH4akPxIdYeQiQ0VNKCJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLYhx0QWFoxUjJ7Ma6IbuU+U3Ay8gdb9HS/n8kH8Tss=;
 b=YQRN8JNXRMRB2+kJTaAgPliHdklLK51Uf89xmzFX6jnSs+3oNhOqSmZu2BGPCCzGaeoMZgU4TORc4IuK2KX74QgXmTdi0F/ifJ5a5pn6zh4T3tzwiN4T5nkjxAcnhLwTGCT9z4ypfY/tUYBIyVJxjvUbPhgqp15GU2Cp1g8ulb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 10:42:55 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0113.015; Thu, 25 Jun 2026
 10:42:55 +0000
Message-ID: <1d42937a-2b8e-4718-aec8-46a58886b62b@amd.com>
Date: Thu, 25 Jun 2026 16:12:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
To: amd-gfx@lists.freedesktop.org
References: <20260625031252.298647-1-Prike.Liang@amd.com>
 <20260625031252.298647-2-Prike.Liang@amd.com>
 <32c5afa2-f24e-4d8c-8872-72826e7d3d08@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <32c5afa2-f24e-4d8c-8872-72826e7d3d08@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::51) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: ca09d354-6429-48bc-8bf2-08ded2a683a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6zBJpzDYLsSr2YfyovjLBY6HHPyCPSuBCAh+I6IMkVEB4dqlxZGZBGDwm9nWRJ5pQpctnjxH37T0rme7CRsUgJrEo3VT9FjkCDdb1DRv1kkkZWimYXqcfhh/z+6M0NpuATRq+Or3gYEMMTwEUOaUeZRGOktfQDY6EdYOXvoIujB/s9I5WlKsCIQEfQJTMbZY4HBAGZHiFAs6AoAWM90hTOGIoEAatWUfWAxStwuu2cs+qEvH+CkNxzZKpYwb7m53lf1CMiPBja+Vuu873IKAxeFN1HpFMSVmxNDy2RzOXancZgjA3nqnJxBYTVY3G3j7vefgDzVT8H9+pWbVmI7IPu5M8KGPjEJW1AFre5wP8sGzyCi6tAm8FHnEMZjhM4EOi1rxy3htG9pbhkAGCexs2Q4hzskSEnLEIse6QlhUD8BEh8kO/Pt0/OuoarP+6XwZwjrcayXwA15bH127p9ag0eOvy+DgN+VZRJ2eMmdrO/qb9Zha45QY7KEfLzOq+NenHc8OW7bTeD8IFd8GpbOU1FYmVyPRoAlRFCx/aT7FZ0xDTCA/w8BGAZyl2I6puJF8xYWiZb1KRZpReGfWx1YzhOtQLzrDfEqzQv8pcwmtQ1+4RIqULbFHlOLag0ljbJfWGCKY9V4+SI1qFBFFZuTYnOvylYWubEhPGWkGqcz4/aQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlZc3ArajlHQTlBQXNXaE12emZhTlN6cFN3dFNqV3JoblNNbXdaNnlibUd1?=
 =?utf-8?B?QUQ4SVNYNHJsaUEybEk2aGRzcTk0NitXdlE1TlJEaGQzM2pEa2N4UFNDd2Zu?=
 =?utf-8?B?cDh2ME1MOGgrRysxQTdIV1JwRDVRaTJHNmNmM3BHNGd1bWxWcGhGZVRNMC9F?=
 =?utf-8?B?eGdUZDloaEFMYnhjUTFubnpHTS9JeUhLSTRyenFrLytoR1VsTmgxWkJzZlZn?=
 =?utf-8?B?Y2hHWHc2UjBwU3FVZjBMbnVqQ3QvQWk2R3ZPd2NhV0l2RzhsckRFdlF3OEVl?=
 =?utf-8?B?cWZXSmNyMzBrTnBFc21lSUsvWk9xZE14SGlHMXRsNDdoNDhWRzB6TWhmaTV4?=
 =?utf-8?B?YkY0WTRRNDNKdXl5MnNPejlQY2Q1c2l5blRqTlR4TG9PeXBpK0FFNnM2RFlu?=
 =?utf-8?B?RVdvM01ma3VBOGtoKzZtb1BjdXVKZDc2Q3pWdzU3OEVMVFE0ZGJ1b29KQzUv?=
 =?utf-8?B?ZW5GT3NKMmk5clVBL3FRUU9VNlFySnNJN2p2MGk3SGpOYXFUckRudHlMN1BY?=
 =?utf-8?B?RitIVnhycTl2ZnQ1c0E5ellkM1FadmxaK21uZjU4NXJLbWNSR05aZG5IcG04?=
 =?utf-8?B?YzhRQlRPbXdxNHRDTHFxNlhYVldjVGNDemZFcWl1QXRHVUFldmJhM2lrc3lD?=
 =?utf-8?B?SzNMYkEvMTlNRzIwcGFXQjZEbHAwSDRGdjhFRW5rRDRuak1tT0NDUHlGMEJr?=
 =?utf-8?B?bFJWUVl3S3lMdkxBZnJhc2FtSWZ0Nyt3RnJOQklsT0ZkOGZnd2FFL0NQb21W?=
 =?utf-8?B?UFp6amdUM1MzS3ROdFh6MzYyV1ZJaUZLOUx4dUdkb3hEVkVBNmtjM1VMYzR0?=
 =?utf-8?B?dE0rb2I1TTFEZ0NqbUxIY1hYYW00eGw1MzJYWlN4RHZXTkRMSGl2S1RKOXU2?=
 =?utf-8?B?bCtnSGpOWGlIQVl4UnJ5SGVyb2tPMG9VTllzRWZxRlZaYko3eUREVHBsZEc5?=
 =?utf-8?B?a1JtSEdzV1dlZ04veWpGV0dSdDFsTk5DNjNNUzEwUlhhY2xBVXNjeE0wTlp2?=
 =?utf-8?B?elE2UkJ2dCtxQTB2YmNRRWFtMXhCZnpQWnRLTXNUdU54N0NiWkRXSUFqMW93?=
 =?utf-8?B?K2YyRmFRNVk0dVhXR0xiUWRaMUhpc0pHWWRzZUd0WGdDWHk5Y2cxYkJlRURu?=
 =?utf-8?B?ZmxON1prMVdKamhscmZnRWM1a2kxSmxhV1doQjZDWjVkVGdCOElCTDB2UjQ1?=
 =?utf-8?B?V0RIZGVyZzdJWmE1YVg2V0N6dERRM1dFMTVlTzBCcW5reHdQdTNrS082VmVm?=
 =?utf-8?B?VmRJZ01STEtZVWFHcnBDeWFLM0RkSE5idzEwS3dlekc5ekRTMDJPYTIzemZ2?=
 =?utf-8?B?ME91U1FIM3piWnJ1TzBnR1F1dG8zaFlHR0RqWDIrSU9EYVJ3SWt3TmhnN2Ja?=
 =?utf-8?B?L0RhVDRUTDQ0YnRJZDBVUlNGdmdiZEpjTkNuM2RKU2hNRlBBNUFET0t5aE9Y?=
 =?utf-8?B?a3Mxc2FtR0phelNaTWdoSGNLc21KR084eE1nRG1WM0k4MzZlYTdJWktvejkx?=
 =?utf-8?B?QTR1dklnV3dadzY0STMyNHpyWHdxYVRmNnVoKzM0TmNTYWdudUN5bVZxaGlB?=
 =?utf-8?B?b0k4NGxwY0FYVS9DMHFIM3J0RDFMMktTazgxRUhmbDJLa3czQ3FVSk4xVWgr?=
 =?utf-8?B?VnRtcVJKUW1XL0F1UEhrR0JoUXNqcUlnY0l5SEVtWXREcko1NFBaRE1nM2VP?=
 =?utf-8?B?SzlNdzVqT3A1TWljelhNYzBWN3ZhM0ttd3pJQlJFSUVSTEd2dTVkU0dhQS95?=
 =?utf-8?B?ZSsvU0RBMklkUi80OWxOYk9BWVN5Sk41SW56VjQrSTJRSjBDRzVQWGUybTBk?=
 =?utf-8?B?MlYySWxmTlNHc2Rja2trRkl2QUxYcVMyeUVkbGw0YmFTTXd2SXRHYkdidy8y?=
 =?utf-8?B?S1dxSmNyeWo2dWtyTUNKejJOaStUbFI3SkhFRDhmSjFxcnpYRlNpTm51N25a?=
 =?utf-8?B?clhHTkQwUkJsZ3M0aGIxMUZtNlN4WkdmWEp4YTlrQUhaa053RXNPUHltSjg1?=
 =?utf-8?B?YzByeEpMWEtxT0hLMDBIY2ZXamlraDZlTFc1bjhKYWRwRTdINW5jNFVXWDdF?=
 =?utf-8?B?d1FPRnNMRjNYQzBHVlFOVmtQLy9welZUaGkvZlNCbkJXbFB3Qi9hYVo5dmVO?=
 =?utf-8?B?M050RTRFZ3hPUnQya084WExOSVRVMzJ6WEU1RjdRNm9VamxtdlhHREQybFdM?=
 =?utf-8?B?TjBLWXBvd0w2bEp4bm8rZGM3TkJCaFd6NXdJb1FZbXJ0RlB1YllwY3luL3px?=
 =?utf-8?B?REdkcDJZbWVkOVBYazAydFNvUzljNGZFZ1Q3Nk50YUlTWFdJRlRrM1NxWndw?=
 =?utf-8?B?WkxBanR1bzVmMzhYUzVKeGQ0bUhoVzJYTVM1dGE5cXl3TnkvaW4ydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca09d354-6429-48bc-8bf2-08ded2a683a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:42:55.1891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyO4oUavSJrsTMd4OwnFWCEclaLmzISzowU9Qqtiev9hdsE4ZS00nTXlEOaIU6FuK/mEUeeg3WXW1bPdZhQRMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
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


On 25-06-2026 04:10 pm, Christian König wrote:
>
> On 6/25/26 05:12, Prike Liang wrote:
>> Updating the union MESAPI__SUSPEND and union MESAPI__RESUME to
>> add the doorbell offset for suspending userq.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
>>   drivers/gpu/drm/amd/include/mes_v11_api_def.h | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 9e27d01cbfa3..ab0de6d04ff8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -783,6 +783,7 @@ static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
>>   	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
>>   	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
>>   	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
>> +	mes_suspend_gang_pkt.doorbell_offset = input->doorbell_offset;
>>   
>>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>>   			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
>> @@ -802,6 +803,7 @@ static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
>>   
>>   	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
>>   	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
>> +	mes_resume_gang_pkt.doorbell_offset = input->doorbell_offset;
>>   
>>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>>   			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
>> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> index 6644fabeb0b7..b06412ac8583 100644
>> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> @@ -428,6 +428,7 @@ union MESAPI__SUSPEND {
>>   		uint32_t		suspend_fence_value;
>>   
>>   		struct MES_API_STATUS	api_status;
>> +		uint32_t		doorbell_offset;
>>   	};
>>   
>>   	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
>> @@ -445,6 +446,7 @@ union MESAPI__RESUME {
>>   		uint64_t		gang_context_addr;
>>   
>>   		struct MES_API_STATUS	api_status;
>> +		uint32_t		doorbell_offset;
If my understanding is correct only while adding a queue for the first 
time doorbell offset is needed, not for anything else but you can check 
with fw requirements.

Regards
Sunil khatri
> Is this backward compatible?
>
> Keep in mind that we can't break the FW interface.
>
> Regards,
> Christian.
>
>>   	};
>>   
>>   	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
