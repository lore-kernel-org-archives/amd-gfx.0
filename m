Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866EED3A670
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A5610E2A8;
	Tue, 29 Oct 2024 16:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nwARzKK7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC80410E2A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgwHSsoL44+GSqaY5Yee6xug4hlFSLk28XH2A2ORGXz22fXcMuSCX3a8WN+yePkpd5IsZxFKpucdeR3nwpiz2GT/u/OUuSZWz9CJNkXZ5fKr88oIUhXpf29BVM3AF3jM89fW5N2uFqG/8PCbUAPzKXOft8T1ZPCMMoHOwQlzGEkl7d0atbLhBeoHzJjnOzL1BJxSvKhAtNPagdevOAn3E/OY7bvLqyBGfFqp6X7KissXJH7L/JJ8iOlXIRj36rgBNjuA9vH2qdUVImF0aI+JnqkYEgGCbcQDuEWLdKvF/B6ZZ0avXAylYkgXN4kkAhis/DlbjmBLs2ljXeWB3uKvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9nuE57mnGWgMaKSSXbJgbzy3HkcgHelvWjEERbBykw=;
 b=BfBRpgmygbiEGVWtmSSD2ULyj7WVYCAuWVMaK6BdfWD4guvYiMlLb2wpSM1cg7HlBfoOohKDga2qdl3T0TmYI2mV9NTeNEN8Xkvgch8oLE2LRdi1huKvm6ziQSBEe/f9N2zeAeeIee6LN6wPOvMOVZn2TGZlZIbig41+uDPUqstJVP9qPd+1IO51ydtGnKze71HE1tyLnB4fq8j/qZgyNn96Yl7mBoSgtQL2adohh6EslaGwPJn5UeLB/fmAeUmDBzQcvDEIE6solvUwmrp3MU50Zsct52o1QxQ+bAH9hdM0C2WJf5hXhbfJ9wjdAQHVr75eRaYHBcDSlPXPB2sc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9nuE57mnGWgMaKSSXbJgbzy3HkcgHelvWjEERbBykw=;
 b=nwARzKK7oVu55igFT/y1+QkvdFbtCn2FpzJXbeMxUhl+rMYXyvLwC4Qf5RML1h27o1C/q7RtUK7uV+jFzN24vzJDkEvZOl+cjiwAY7L6RBjgYT2O+j+/NvYpFU7116EN/Mb4OQZu49bHg8kMfBsxRudzoWQp7bR+a5k4a52ngwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:24:41 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 16:24:41 +0000
Content-Type: multipart/alternative;
 boundary="------------I72JfkgPTX20LfG1AQlapS83"
Message-ID: <8b030c5c-e290-410b-8e1a-e3b3418ac8f9@amd.com>
Date: Tue, 29 Oct 2024 11:24:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Differentiate logging message for driver
 oversubscription
To: Mukul Joshi <mukjoshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
References: <20241028214014.59940-1-xiaogang.chen@amd.com>
 <9697eb8f-bab6-482a-ad82-0939ea9e17bc@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <9697eb8f-bab6-482a-ad82-0939ea9e17bc@amd.com>
X-ClientProxiedBy: SA9PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:6e::7) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 2339cba8-7a28-4e56-5248-08dcf836308b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXNWT29XaXFHWVNnTmFDOC9Fa0QvRzBkdy9rNnBrRFdCdmZXcDU1b01hQ0dQ?=
 =?utf-8?B?aUduK083dTBIcDZtRTNzeVFvMnVDL3U0S1RMVGMvTGluMm9BVUIwNGRQRitM?=
 =?utf-8?B?eVFKWEl5ZmFaaFlSZFkweW53bkgzUEYrckNQaWlOSG5yUVo0MFV4aGxqOEd0?=
 =?utf-8?B?cGdzTi9ZaGxvRWt4S1hGaFZONEc5RVNxcU94SWNoMHNYN0xZZUNoOXVhNXl0?=
 =?utf-8?B?RWFVbEJnTDVKczhQWnVMTHBzeGpCMTNXeEU5V01ZTGdUYU11a1p5bU9WQjB5?=
 =?utf-8?B?YlYwbjN4WUZkMWVTaWNDM0ZvSFRzVmVtSHdoQ0VWRjFtMTlhcmFseUNFL3FD?=
 =?utf-8?B?MVV4NElWd2tlcGFFQXlITkZaK2gwUVVPaTh3UkJkZEpzdG0zS2ZGeEoxckxJ?=
 =?utf-8?B?Y0hWZHNKdy9TU1hMUmV0SC9zOUpaRmtNOGJ4OHR4RU16eVBKenJPVHV0dXBx?=
 =?utf-8?B?R2YzM1kzdTEvUDhBN2VLMVhpY0wxUnFzU3A2akxMVWw2VjBUQUJpN1VwdDVw?=
 =?utf-8?B?cFAwa25aaU9NekFlL3ZQV3FTRzhJMUEyZ2lBRWErTFJ2dzhRWWJwUnNMUmIx?=
 =?utf-8?B?d202cmtnM3FiM1pET2NZenJpY21POHRKNXB1eWdEWVpHMXliVVF0bndLTWJP?=
 =?utf-8?B?SlhITytJNmNoeGdQU1ZpaUU1RlNCc2lKaWtkQXpOM0VkYUw0bllsOFZSNlB6?=
 =?utf-8?B?SEFlakJwdEo0S2EwZU9LUjZ3WDh0bG1lUktHT2QrTjJxSWxvU3BiQ3E2MjE5?=
 =?utf-8?B?THcwR0tUNURKY3ZwalJRUFdSeGdJVzVjcG9ZV2Z5dXA0MzRiVktJbmVPSHRh?=
 =?utf-8?B?bXI0QmZmMk9LUEk3RythTDVMWFR2MEhaVnVJZklTRVVvcGJzL1FhR0FDL0g5?=
 =?utf-8?B?M1JKTlBTcllBc1VreFc2WjdVRDQ2VHEvS0NRMm42NXFaRmlFM1FSSER6UnRn?=
 =?utf-8?B?ZTNid0lEQkplM0JFK2lHSjlXWGl3RUxGLzJ4OHVjOEQ5eXJZQ20yWTIvdmFE?=
 =?utf-8?B?ajU5SFB2T2JNQTRYNHdXZ0VDTmQwVTg1Q3lMekhodHd1N3duc0plTU5vVXJ3?=
 =?utf-8?B?RzM1aXRXWFdaWnZiaytJNFd0c20vcUJlTGY1WnBLM05FbjQyeElSbDhvSTNU?=
 =?utf-8?B?Yy9zclJ6M3dvNVRLdkNmQWdJZ2l0Vk5CY3BPOWtUci93NFA4ZHl0YW4xazcx?=
 =?utf-8?B?Q2dkTmNJbW5UUGt4NlJKM0JiUUZOZzIzSUIvNTN3bE9hWm1haEhhbVdrTzB6?=
 =?utf-8?B?dTB4RFpUYk1Qek52QmRvWWNGMTR1djFSYVljWVFOOHE0SFg0WnNBZWJpUWFv?=
 =?utf-8?B?VHVSbzFCUGM4ck5BTEtrbXJURTNFcDhwZ3hhWEFGeW8rVEpXdDVOTTRwT3Iz?=
 =?utf-8?B?dUJyc21DbVhwOStBWlpWMjZpcXpuZkpYSUlkRmowMDZXNmhnTnFFdDV6aHlY?=
 =?utf-8?B?R1B3VGVWdWh1dUNqRkR4Y0dPSVIyZjN1Ym0xRXlCRk9qOFlrMisvaE5EeWdl?=
 =?utf-8?B?UjVhSTkyRDNTNGx4Z2trWjExTExva0VVRWlqbEhMWktRZWdVM0hhdFR3dkVn?=
 =?utf-8?B?amRmc2Q5VDhXM0lieDc4djF2anE0dk5YSzNRUTI1SGJjVDQ0bFgzN3NDaGds?=
 =?utf-8?B?MFdKV1VmYTU3NGNKaEREL3picFpCbEV3VVJJZTNPQStXS0cwb2N2QytyV1ho?=
 =?utf-8?B?QmhQc3pZQ29VQk9FWHNzd2pxZm9aWElDN0tFS3NBZ0xFNzB6ZDgvQ2lnTFZy?=
 =?utf-8?Q?OtstTJ1LMAlUqA3+0c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JCMDNlVi82bXB3S3dJSWR5b2tnbDVORDBFMXF5aDhIa0tKL09PUDZ0UW1W?=
 =?utf-8?B?enZlK2dlZnhYdDVHUTNqZ0RqdXBDZ1FuQ29hdDEybUhyZE15M21JREg2WVht?=
 =?utf-8?B?WFNJT3JqRjhIVTcwVjQ2cXpYQ2p0NDk0T0NCRWhrM0ZKK090emY3eWoveDlV?=
 =?utf-8?B?TDQ4aHpTaGl4TmFXQWw5eG8wWW93akYyY3FJQ2lmSi9BQ3VicGEzbjhHMFRV?=
 =?utf-8?B?VS9YN1M2NTl3L2R2V0JQRGYySjdxY2E0NzNVbW1OR2dLUHYydFIyU24vTjFS?=
 =?utf-8?B?WG5PMjFvakV0Wm5DL3U0b2VqUkVuVkI2RHptRGx2UndFMlJXcmdCc21nY0lP?=
 =?utf-8?B?bXBaZkN6aWVNMUN6K2xGMEljV3NhenM4ek50RFlJeTVjOTlTNDJWQWNnU1o2?=
 =?utf-8?B?V0hDTVpOUXl1VytlUEdGYXh1S2tLRW1ncVNHamlCVUJKak9MYUFwOXZYS2V6?=
 =?utf-8?B?TGN5Ulpua0dmdi9JMnZya0JmVXhVTUhaa2wxUTlvYnAzQ2tPYmJCb1h2SElk?=
 =?utf-8?B?MVNnVWNQQkRlcHJwcUkvWTJjM202R1F2NVd2MERjV2JGdXlnNlg4Zi9XK1Vw?=
 =?utf-8?B?dkVuYzZuZzZ4SXJkZ1VFR0RuMmtOQVBMRG83Ykt3YW5pckpUVEZSb1I5YVRN?=
 =?utf-8?B?SEY4bjc2cWhyTldySGJidVBZSzBWSVl5TGZUYm9DRWxVdW1wZ3VFZFY1em0z?=
 =?utf-8?B?a0NWZDU1TC9GQ012eDk2d1dGR09TcHA3akVtRUZwQTI2TVpQb1FaenJpRFdS?=
 =?utf-8?B?SXE2dHhYVlRvZWs1V0RWbHprdTJjdUN2d3d3bjlqZEJwUXNUZSs5dlZLdVE2?=
 =?utf-8?B?VlVRdmRpMFZDN0tFZFgxcEJyNWxxOWJNUVlqdytNZDlxYlo5ODY4ZGlEaGNu?=
 =?utf-8?B?RG0zSW9NVFE5QWJvN1Y1UWpaRmwrSWVJeTlJbU16d1BVR01tUTFldTdaNkto?=
 =?utf-8?B?Vm5RN0dGa3psajFnRGNNV0VoY2VFd0ZRRkxtQVN4ZERoeXVvSDZKQ2lHWG41?=
 =?utf-8?B?b0hEc0M5ODNyNkVLOWdxWXdqa3dqZ0xhaHROVWhFVU4ydldCaUtvQ3lXa21N?=
 =?utf-8?B?Q3NqODNsbFFZbTM0OExxd3pvWlFKWVZ5TDRGa3VXNHRoZmNrUnhtMGVMUzZp?=
 =?utf-8?B?NU5oUlZ3d0hPR2lwYy9TOXVwd2FSQ2ljMklqMzVCVW9PR3c3aS9EZi83ZXRx?=
 =?utf-8?B?NjVyd3dlNWtjOGlEU2FReGdaa3d4ZTl3czV2NWtkNm1pcFNOZ01mVldCTktV?=
 =?utf-8?B?RTRtdjlRMTBLTEkvY3VQd2FLcUxSelVrakdEcDZsbVcwSlZESndRNXJaclhP?=
 =?utf-8?B?Z083aHpzOFF5bVkybmN2ME1XNFp3OTRwZ1VKb0ZUSmFqMXFCQkNIcHk1WVlq?=
 =?utf-8?B?ZUxhdXBacXFDNlZZdFZpbGRMdWdTbUg2MVpFV2J2ZmFFT0dHdVplV3BENEpZ?=
 =?utf-8?B?VmFSQW5MbmhpWEhlcDN5M004MDhHSW9Qa0pEdWR0OXl3SDN4Q2xRTGI0WHQ3?=
 =?utf-8?B?MWZma044ZENETXA2ZnorcVhoM25xNjdtd1VHbnhsQytWSXRYanZXcGYxc1h1?=
 =?utf-8?B?b2ZETG90L2FuU0t3OUVIMUppYVY5NEN5NFU3dmtMV1FNNDBkQkN6b1ZZV0tm?=
 =?utf-8?B?aG9idi9WN2M2S1ZqUlJRUFdtRk9DU25YL1hWeDYzL1FLSlZRZHkxcWtFYUVm?=
 =?utf-8?B?dWJXODJDZkxNZ1k0ZFNyOVZzRk85dFpycHBhbmNYbDhObExTdThvdDVPaHll?=
 =?utf-8?B?ZVN1ZytWU0pBNk9TWXVMajJoNUVFdG0rR015eGhuaUpvRUVZZHFJaW5TbEh3?=
 =?utf-8?B?bnhtSUpaNFBpVU41R2dOMEZUOWZHNERVbmdneVlrZ1VXWlpPVzRscjZ4UTZU?=
 =?utf-8?B?eXd2UkN2TmoxYlBLWnhGMkZocy9GcFNObXZqenpLdVlkQ3dxeEFQcFpUc29V?=
 =?utf-8?B?a25qRDZ4VzhaZmtmdnhTM1JwR0poT1ZsTXNrNnFtRmh3cWhZSzJjQU5Xc3dT?=
 =?utf-8?B?WUY0ajhub1dmcWpGWW8zbkcxTnhmOG5wYU43SnJwbldHRTdWTmJRNWw0bDA0?=
 =?utf-8?B?bHQ0RDdnK0xPR2lxNW1XUzNRcFZ2ei9hSXUxenJMWlNxNlpQTGRLWmdFbnpC?=
 =?utf-8?Q?nOc8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2339cba8-7a28-4e56-5248-08dcf836308b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:24:40.9881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2xSfPEhqJqa7EeWRFVC1dTebxDLydYWOwdFQKflENlqfg7CRHPzgB1Dqmf/zC2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

--------------I72JfkgPTX20LfG1AQlapS83
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/29/2024 10:01 AM, Mukul Joshi wrote:
>
>
> On 10/28/2024 5:40 PM, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> To allow user better understand the cause triggering runlist oversubscription.
>> No function change.
>>
>> Signed-off-by: Xiaogang ChenXiaogang.Chen@amd.com
>> ---
>>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 55 ++++++++++++++-----
>>   1 file changed, 42 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> index 37930629edc5..e22be6da23b7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> @@ -28,6 +28,10 @@
>>   #include "kfd_kernel_queue.h"
>>   #include "kfd_priv.h"
>>   
>> +#define OVER_SUBSCRIPTION_PROCESS_COUNT 1 << 0
>> +#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT 1 << 1
>> +#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT 1 << 2
>> +
>>   static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>>   				unsigned int buffer_size_bytes)
>>   {
>> @@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>>   
>>   static void pm_calc_rlib_size(struct packet_manager *pm,
>>   				unsigned int *rlib_size,
>> -				bool *over_subscription)
>> +				int *over_subscription)
>>   {
>>   	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
>>   	unsigned int map_queue_size;
>> @@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
>>   	 * hws_max_conc_proc has been done in
>>   	 * kgd2kfd_device_init().
>>   	 */
>> -	*over_subscription = false;
>> +	*over_subscription = 0;
>>   
>>   	if (node->max_proc_per_quantum > 1)
>>   		max_proc_per_quantum = node->max_proc_per_quantum;
>>   
>> -	if ((process_count > max_proc_per_quantum) ||
>> -	    compute_queue_count > get_cp_queues_num(pm->dqm) ||
>> -	    gws_queue_count > 1) {
>> -		*over_subscription = true;
>> +	if (process_count > max_proc_per_quantum)
>> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_PROCESS_COUNT;
>
> I think you want to use the Bitwise OR (|) and not the Logical OR (||) 
> here. This will always set over_subscription to 1.

yes, actually should use |=.

Regards

Xiaogang

> Regards,
> Mukul
>
>> +	if (compute_queue_count > get_cp_queues_num(pm->dqm))
>> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
>> +	if (gws_queue_count > 1)
>> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
>> +
>> +	if (*over_subscription)
>>   		dev_dbg(dev, "Over subscribed runlist\n");
>> -	}
>>   
>>   	map_queue_size = pm->pmf->map_queues_size;
>>   	/* calculate run list ib allocation size */
>> @@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
>>   				unsigned int **rl_buffer,
>>   				uint64_t *rl_gpu_buffer,
>>   				unsigned int *rl_buffer_size,
>> -				bool *is_over_subscription)
>> +				int *is_over_subscription)
>>   {
>>   	struct kfd_node *node = pm->dqm->dev;
>>   	struct device *dev = node->adev->dev;
>> @@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>>   	struct qcm_process_device *qpd;
>>   	struct queue *q;
>>   	struct kernel_queue *kq;
>> -	bool is_over_subscription;
>> +	int is_over_subscription;
>>   
>>   	rl_wptr = retval = processes_mapped = 0;
>>   
>> @@ -212,16 +219,38 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>>   	dev_dbg(dev, "Finished map process and queues to runlist\n");
>>   
>>   	if (is_over_subscription) {
>> -		if (!pm->is_over_subscription)
>> -			dev_warn(
>> +		if (!pm->is_over_subscription) {
>> +
>> +			if (is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT) {
>> +				dev_warn(
>>   				dev,
>> -				"Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
>> +				"process number is more than maximum number of processes that"
>> +				" HWS can schedule concurrently. Runlist is getting"
>> +				" oversubscribed. Expect reduced ROCm performance.\n");
>> +			}
>> +
>> +			if (is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT) {
>> +				dev_warn(
>> +				dev,
>> +				"compute queue number is more than assigned compute queues."
>> +				" Runlist is getting"
>> +				" oversubscribed. Expect reduced ROCm performance.\n");
>> +			}
>> +
>> +			if (is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT) {
>> +				dev_warn(
>> +				dev,
>> +				"compute queue for cooperative workgroup is more than allowed."
>> +				" Runlist is getting"
>> +				" oversubscribed. Expect reduced ROCm performance.\n");
>> +			}
>> +		}
>>   		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
>>   					*rl_gpu_addr,
>>   					alloc_size_bytes / sizeof(uint32_t),
>>   					true);
>>   	}
>> -	pm->is_over_subscription = is_over_subscription;
>> +	pm->is_over_subscription = is_over_subscription ? true : false;
>>   
>>   	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
>>   		pr_debug("0x%2X ", rl_buffer[i]);
--------------I72JfkgPTX20LfG1AQlapS83
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/29/2024 10:01 AM, Mukul Joshi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9697eb8f-bab6-482a-ad82-0939ea9e17bc@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 10/28/2024 5:40 PM, Xiaogang.Chen
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20241028214014.59940-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com" moz-do-not-send="true">&lt;xiaogang.chen@amd.com&gt;</a>

To allow user better understand the cause triggering runlist oversubscription.
No function change.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">Xiaogang.Chen@amd.com</a>
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 55 ++++++++++++++-----
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 37930629edc5..e22be6da23b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -28,6 +28,10 @@
 #include &quot;kfd_kernel_queue.h&quot;
 #include &quot;kfd_priv.h&quot;
 
+#define OVER_SUBSCRIPTION_PROCESS_COUNT 1 &lt;&lt; 0
+#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT 1 &lt;&lt; 1
+#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT 1 &lt;&lt; 2
+
 static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 				unsigned int buffer_size_bytes)
 {
@@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 
 static void pm_calc_rlib_size(struct packet_manager *pm,
 				unsigned int *rlib_size,
-				bool *over_subscription)
+				int *over_subscription)
 {
 	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
 	unsigned int map_queue_size;
@@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	 * hws_max_conc_proc has been done in
 	 * kgd2kfd_device_init().
 	 */
-	*over_subscription = false;
+	*over_subscription = 0;
 
 	if (node-&gt;max_proc_per_quantum &gt; 1)
 		max_proc_per_quantum = node-&gt;max_proc_per_quantum;
 
-	if ((process_count &gt; max_proc_per_quantum) ||
-	    compute_queue_count &gt; get_cp_queues_num(pm-&gt;dqm) ||
-	    gws_queue_count &gt; 1) {
-		*over_subscription = true;
+	if (process_count &gt; max_proc_per_quantum)
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_PROCESS_COUNT;</pre>
      </blockquote>
      <br>
      <pre><font size="5" face="monospace">I think you want to use the Bitwise OR (|) and not
        the Logical OR (||) here. This will always set over_subscription
        to 1.</font></pre>
    </blockquote>
    <pre><font size="5" face="monospace">yes, actually should use |=.</font></pre>
    <pre><font size="5" face="monospace">Regards</font></pre>
    <pre><font size="5" face="monospace">Xiaogang
</font></pre>
    <blockquote type="cite" cite="mid:9697eb8f-bab6-482a-ad82-0939ea9e17bc@amd.com">
      <pre>
<font size="5" face="monospace">Regards,</font></pre>
      <pre>
<font size="5"><font face="monospace">Mukul</font></font></pre>
      <font size="5"> </font><br>
      <blockquote type="cite" cite="mid:20241028214014.59940-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">+	if (compute_queue_count &gt; get_cp_queues_num(pm-&gt;dqm))
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
+	if (gws_queue_count &gt; 1)
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
+
+	if (*over_subscription)
 		dev_dbg(dev, &quot;Over subscribed runlist\n&quot;);
-	}
 
 	map_queue_size = pm-&gt;pmf-&gt;map_queues_size;
 	/* calculate run list ib allocation size */
@@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 				unsigned int **rl_buffer,
 				uint64_t *rl_gpu_buffer,
 				unsigned int *rl_buffer_size,
-				bool *is_over_subscription)
+				int *is_over_subscription)
 {
 	struct kfd_node *node = pm-&gt;dqm-&gt;dev;
 	struct device *dev = node-&gt;adev-&gt;dev;
@@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	struct qcm_process_device *qpd;
 	struct queue *q;
 	struct kernel_queue *kq;
-	bool is_over_subscription;
+	int is_over_subscription;
 
 	rl_wptr = retval = processes_mapped = 0;
 
@@ -212,16 +219,38 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	dev_dbg(dev, &quot;Finished map process and queues to runlist\n&quot;);
 
 	if (is_over_subscription) {
-		if (!pm-&gt;is_over_subscription)
-			dev_warn(
+		if (!pm-&gt;is_over_subscription) {
+
+			if (is_over_subscription &amp; OVER_SUBSCRIPTION_PROCESS_COUNT) {
+				dev_warn(
 				dev,
-				&quot;Runlist is getting oversubscribed. Expect reduced ROCm performance.\n&quot;);
+				&quot;process number is more than maximum number of processes that&quot;
+				&quot; HWS can schedule concurrently. Runlist is getting&quot;
+				&quot; oversubscribed. Expect reduced ROCm performance.\n&quot;);
+			}
+
+			if (is_over_subscription &amp; OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT) {
+				dev_warn(
+				dev,
+				&quot;compute queue number is more than assigned compute queues.&quot;
+				&quot; Runlist is getting&quot;
+				&quot; oversubscribed. Expect reduced ROCm performance.\n&quot;);
+			}
+
+			if (is_over_subscription &amp; OVER_SUBSCRIPTION_GWS_QUEUE_COUNT) {
+				dev_warn(
+				dev,
+				&quot;compute queue for cooperative workgroup is more than allowed.&quot;
+				&quot; Runlist is getting&quot;
+				&quot; oversubscribed. Expect reduced ROCm performance.\n&quot;);
+			}
+		}
 		retval = pm-&gt;pmf-&gt;runlist(pm, &amp;rl_buffer[rl_wptr],
 					*rl_gpu_addr,
 					alloc_size_bytes / sizeof(uint32_t),
 					true);
 	}
-	pm-&gt;is_over_subscription = is_over_subscription;
+	pm-&gt;is_over_subscription = is_over_subscription ? true : false;
 
 	for (i = 0; i &lt; alloc_size_bytes / sizeof(uint32_t); i++)
 		pr_debug(&quot;0x%2X &quot;, rl_buffer[i]);
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------I72JfkgPTX20LfG1AQlapS83--
