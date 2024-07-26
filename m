Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53055C3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 14:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0637D10E9BB;
	Fri, 26 Jul 2024 14:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZmVUZbli";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B6A10E9BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 14:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x19JHKFx92vvAVD09ECNzarolbDNbie18TONP8lZYHeClb6u1ETejDm76MTCW+Vhsk8Q6zynOwtFg3W5MuxWgRPT94EnkXrMFtIM5iMGegBZmrIqVy6zs4oEH1kmJdQU45EAHUMUHDeQltJbFI14p2Z7hctJuTMNckfLjS1M3qjESnKD0rvDs7K4jae0Ht4TRfi3RZi1d1K0vC+4JaYCxIqI4pp+7Gj8Xd8Kiqkr9KLPLPoTa9IylPDKpG9g+LSMufvi+ji0Z8fAsOLiv3kaISToycFb1nMOvCLkOCQOFcTEHhpLWvuu7/5LS9AUEMGIZhrdmCmFIEgkrysSZn9dOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJgnU8MpGjWd77zurNL7B856aZ76Rg0mV0e7qQfgTRA=;
 b=NLnm+PkXiwXa8w1/W3QdDQF6FzgMaZqr6wo4RKFXWhnprk4VD0EfQdvpO6CNoZfyDCKDORrAi4REYKPWepV3WUQNf+D5dInEU4eRPbtuJZJeW4exK25OuWQ9IQUDRHG9Gk3kfE4N1J2wqjKao2DFnBlVj0HPRvkm259DYmt5g/JH1dUk+7HIQ9GbPcVYxi7p6ufbArVgy+IGKhbE6lAulSXezoi6dudQOnzV5bMeWz7Pgh+xRww1lFf5KUuw74wqTUSas0U68k9Cba41WnWCaeiCIAvuYuLrKRUXZkF1birILBOxWCY8k/l8DWIeQ8lH0rkCuZg2DiGVXC3rdOuxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJgnU8MpGjWd77zurNL7B856aZ76Rg0mV0e7qQfgTRA=;
 b=ZmVUZblilbRmGOA7CFpl8phUjfBTTJZQuyAMif/CpMzb+syaqH3QoHCtrw9CFYM4qaklEroMT1WUB1Ka/QcufQSHGZYgrYy+h+p8wtzj2Au2CWjisW3mJRzTtZlPY/g6ppvRVlNERurBeLLGg3ssifVVMS3lJHvRSsVoOh5YLv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 26 Jul
 2024 14:23:32 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 14:23:32 +0000
Message-ID: <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
Date: Fri, 26 Jul 2024 19:53:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 86480358-9321-410f-85bc-08dcad7e86c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mml6UTRIRlptUkVKTjExVWRsQVQ5b3F2czZtRlpDclZBbDRMdHNrUGpTOGI2?=
 =?utf-8?B?RW8vdmorRzd3STNvaFU1VzFmRlk4eFBlaDR0MnhwU1Y1NWZaM1AyTkR1eDFU?=
 =?utf-8?B?TnE0UnExTW9idVBnU1pDRGJ3ZGFibzJwbWVyRkdZN3plYnlNWUZFeGo4OUlH?=
 =?utf-8?B?TFNnYWhGdEl1eWhJS05iWU9ib3RiOVhjREwxeWVIejkraFczemIrYU8yNnBU?=
 =?utf-8?B?SXZ3aFF2U2ZJUFRSTjl4WVpkZUJOaW13Tjk3VjRmdHlWUGFybjVzaTlzUHRm?=
 =?utf-8?B?Qm1wc0VmMStGeFlDRUlnWEJpYzlSeTM3dUYwS0NXOEZzMnFaWm1qcXU1c0lv?=
 =?utf-8?B?dHJvWXJ1djFsTlRqb0dpOXBVSC9ncmN5MlVQRndFSm9DQVVqbXhYaFVkL2M3?=
 =?utf-8?B?eUpadzNML3EvNWJxUkREODRMVm1XM0piTEJpbUdhazBIV1lKWmRPbEthdjNZ?=
 =?utf-8?B?TDZzVGt3K3dmV1poTUxnTVE2YUljdFNiTnRZNkFMbmtmVkFUTklpaWkwOVlV?=
 =?utf-8?B?NkJrTVVkbkFVbitITlJZR3ZMSVRrTmxBNkZKWHhCc3hreCsxRFl5M09lTmRS?=
 =?utf-8?B?QjRDblR2VnhpdldOcEZTLy8wNDlJdkpuYnQvVU1oZWdiMnhpK0h6emxPa3Ux?=
 =?utf-8?B?Q09QcFQ1Qk5PWXBoSjl3b00ydHFmbVBHNVJaMVlxTFVsN3RFMEpTbDVVQ25n?=
 =?utf-8?B?ai9MWmpwTHZDSllNa1lLM0FsWXhaSzVHYktoMys0UmRnZlJqbFdUSmt0dHJq?=
 =?utf-8?B?RVZIK3FHS2xGZFNGQTFIeFpWemVMbGdYZmZxMUJmNFVORXJCeWdlWDRJZkh6?=
 =?utf-8?B?TFl5NjZGU0pHdnZtd1RORHBjd2VsZTkyMkRFN2RMRmRwYitQWWhEcWo1N2VD?=
 =?utf-8?B?NWdCTTdxWXJTbGFxaWh5TEt5QUFTYXV3L3gzeXNIclByYjhrNXVhM1FiTmNw?=
 =?utf-8?B?UU1LeDVWN045aU80cXYyVjhpcG9nbWc0MUQxSTd1cUl1SThTdTQ3R2RsK285?=
 =?utf-8?B?MlBjNjh5MmwyUWkvTDVPYmgybEVwNmhnZXJOUnIzdEMyQjdxV1JSOTQzV3pC?=
 =?utf-8?B?bWMvcmFTQTV6elVJeXpONkJ5K0NXNzJnOTlIQmcxMXdQZk12Y0tKSWZpdUt1?=
 =?utf-8?B?cExZN1ZpMGI3R3JJNGRZSk41akh4YTYrYi94aHFGVzFWS0xSVG54a1E4by9Y?=
 =?utf-8?B?cy9CSzBjSHdZNEF6VUMwd2tnRDBhR3pVSW4yOCtpL2hTdnNJOC8vbG01T3pI?=
 =?utf-8?B?RXVFbmlsdHE2d1NlRVk2TUV3bUNtY3FuUUNLTHgyYWMyWldhU1JYZkF4L3k2?=
 =?utf-8?B?K05FYXgzOW9GRzN4VXZwTzUvNWVCNHM5UE5OM0tuWGhCYXByNENFODBqeUJJ?=
 =?utf-8?B?K0FDVndzcnplUUV4TzM5ZXNlNmlVUTgwdkdZcnE3eFBIUnFhdktIOExHM0U5?=
 =?utf-8?B?RFNCYVZqNmhvbkkwZkVwbTFrcCtNa3J2Q014MVppM3hPbmhDUlVvenVrUjNo?=
 =?utf-8?B?MWxaMThjdVZGQVEyMFA3L0NMN0hHVTRoYUx3VGh5YlFVVzhkUkR1WXNtSXkx?=
 =?utf-8?B?U2VPYkVlYlJoWlVGMUdpcVl3VjFWcktnMzFkcWVhcWZwM3VGbVBHNHNhVFpL?=
 =?utf-8?B?VGFNaFVNV0liNnRYMDB0Z3Y0blpmVERxbWhXYXNJYkpZRFVnTmw3V3drM01p?=
 =?utf-8?B?a0hGendFZ2ZJVEFyRXVLUkx2UlpCUjZ3citSMEhBWEkxcjdTNnRLR3lKdHJZ?=
 =?utf-8?B?Z1V5a3dvalZwT0FIV3pPNDlEY3pBUnFlaEhRcXNadk04VXpkYmhWU3dPRnRU?=
 =?utf-8?B?Wkg5bTk0NGwyc2tFUTF5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNmeUd6M3Bic2lkaHJhSVRKb3BvTW5IdWxuSHRQVFZHS1N6OFJtR25YQ2FM?=
 =?utf-8?B?WjJaWm05VW8wY2dCWGJMSzlVblM1SGVUZkJWS0ZkQ1Npemh5M1NnektrcXox?=
 =?utf-8?B?RkFEVlg2eGZiWFdWMy9ndVFOb1E2dHhYc1JiUXlVNlN6N2M0TW9RQUlqa0k4?=
 =?utf-8?B?enNXT1RMMzRNVHZkNS9XL0FSYzVYTWQ1bGRKd2x1aXJHR1RsQ0hGQzV6aFl1?=
 =?utf-8?B?YXQ2QklGMVNtQlNvamJIdGlYRmFNbkdqd0RqRzRKQWd1SjZ3NnlDaW5SRU1Z?=
 =?utf-8?B?L1REalZDRVMrQXNxNVRjUjB6aWN4WUFwV3BIeDBjQ3ZPUDZtc3lYWjBreXJj?=
 =?utf-8?B?WEJiUnV3VHpMVVJyZUV6c0xpWGJiQ0RGdmhVVFpSejc2Y1dzbW43WDQ0QjlH?=
 =?utf-8?B?Qm9kS2RXNXQxK0F4OEdlbmVCT2RYMjFJY04wMGlCMU5hSzhjT2V0dDlyQXNj?=
 =?utf-8?B?cUdOWHcyVkp6bUl4Nm9MOHdPOVFaZjZpdGdESThuei9rcmVDMDhLd1g3U3Y5?=
 =?utf-8?B?WGliNFNHNVRIRFNMR0pLa1d5MjlIbnB3ZktwRDI0cldCdHNIMVpjSlI0N0pD?=
 =?utf-8?B?YXlxMURpS0FXcjkyR0NLTWhqQWgycGR2WG91V2NEOUdiKytRR0E1NEpBbmNk?=
 =?utf-8?B?Ni9sY2NjRkpVKzJxZnVmS0FiNE1TR3IvS2lBckYvRHd5U2NVb3ZqSFcwc3dH?=
 =?utf-8?B?dlRmN0xNa0NiSEpuQjZJOGFiSm9KMWw2c0tkUW9QOGlobUNFNSt4Rm44M2tZ?=
 =?utf-8?B?NzBVNHdiR0xHRE5XOHd6dzlzdDl6Q0Q4MjFXZWNJS2I1dENBdUg0OC93S3Nk?=
 =?utf-8?B?bWZjb0pVdkk1ZU9wQVlvaEduVkk0NU51UWp4cThNeHByUUdJUGNIN09sc0s0?=
 =?utf-8?B?VnA0ZEgxZXo4UllxUkRQL2Q0SGQ2OFdDNjlGcGpiNE1TTnE2bXAvZXVadlhz?=
 =?utf-8?B?SDlBVXlxbmY0TkpqRzlnSnkvZmMzR2FPSGw1ZGwrWm1EeG1CeUR4dk1HSnhX?=
 =?utf-8?B?dUxVVDJNWDdSU29EWHZXMC9IYkQ4TDJYUFFERGpkdTc4a24rY0FGdmdVMTZr?=
 =?utf-8?B?aktmSGJvNnpIcmtXVWQ1czlhWUZpMWVaeVNvVVp1UUhZVm5CU0Y1TUNCb2oz?=
 =?utf-8?B?cUlTZGxSNFRtdHRQYzlEZjZtWmtqUjVOb1RndGdTOGlqMEZNQW1ZTGQ2eU8x?=
 =?utf-8?B?Zm5iQnI3em5lOUVxa3ZpcTV1Vm1sWkR5U0xYZ1NNSTNFTVlTVyswNmt4SmlI?=
 =?utf-8?B?aVE3OWhBQkNZUlNQNHU1NjBmaU5sYVJiV1pEb0M0YUVteklSWXBnM0JEOVpo?=
 =?utf-8?B?QnJidkg2Mm5wVVk1NVZvbEFZRjh4cGpwdWZRNU0reTJQOGdZK2FKMlY3cEFr?=
 =?utf-8?B?LytWSFFtanZMa01ncWVsRUJHUWF2OEtET3IyczcrMXVsMXRSMFZyWXdkekRT?=
 =?utf-8?B?NnczbkZIcURZdXZnZGsvSFoxNzdOTWZNaTBLclZPZFRSZ1JKTUU2cHM4TlIw?=
 =?utf-8?B?R3JROW96WVY5eTJIRFBNZWZHTlo0VWRjZ3pVUVFBZko5RUNLblRDNENWbFdF?=
 =?utf-8?B?d1Yyd29hVm9maFF3ZnN0b3p4ZFhmMXkwb1VSYUNhRDJFbVVhUS9rd3dza0Vo?=
 =?utf-8?B?RXB1bmI4U3IxRWlZT3dQOEQ4UmRoOFREbWxOcjNYYkdpNmwxOTlTMUFPMGdt?=
 =?utf-8?B?TGtVR0hUbTlWdkQxcjl2T0lUbkI3MHU4R05xY0xLMWwrYlpKektkUW5FeW0v?=
 =?utf-8?B?QXk2cFNtVDVHRXNEQ1JabjZSNDduTFVqTEZOTU10a0l0dmplWUpkc0Q0Mmkv?=
 =?utf-8?B?VUJxYitqTzcxU0JYcExveG9sOFpyTFJXR1VxNmI0ajRINDlLMVN1Z3p3NVFx?=
 =?utf-8?B?Yyt3RUgrS2c1ZTFBTC8yV2tRaFBHWjJLd2tHSVVLOU9jR1Q2eVRDelM4ZEZj?=
 =?utf-8?B?NkliOU1lQ3pZcUxsZTRjbEdueDhYQXFTaWtBOG05WmNqYzZpei9FNUNSdUdp?=
 =?utf-8?B?Q29NM0MwREZKcjJFZUxHMzVMWDlrTjQzdVVPd2RHSFlBeXM2OU1ZTVBiKzlX?=
 =?utf-8?B?QXpwbVVoWC8xdHF6MFlIS1dmRjNIbkdEQ3Mxa0s3T0lGOTFudERsbGJSam1J?=
 =?utf-8?Q?xSxT42RjeMkamjAtOGX+l6dgK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86480358-9321-410f-85bc-08dcad7e86c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:23:32.1712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDkEadSc5+fbq2EQQGKBqjkqk57IWWS4FSn/tBi3REl8CHlM1vUcE+DD4a5P6y9eiAKRY8D5FFUz/YWqbwPmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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


On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>
> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>> Problem:
>>> IP dump right now is done post suspend of
>>> all IP's which for some IP's could change power
>>> state and software state too which we do not want
>>> to reflect in the dump as it might not be same at
>>> the time of hang.
>>>
>>> Solution:
>>> IP should be dumped as close to the HW state when
>>> the GPU was in hung state without trying to reinitialize
>>> any resource.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++-----------
>>>   1 file changed, 30 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 730dae77570c..74f6f15e73b5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>>          return ret;
>>>   }
>>>
>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>> +{
>>> +       int i;
>>> +
>>> +       lockdep_assert_held(&adev->reset_domain->sem);
>>> +
>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>> +                       RREG32(adev->reset_info.reset_dump_reg_list[i]);
> A suspend also involves power/clock ungate. When reg dump is moved
> earlier, I'm not sure if this read works for all. If it's left to
> individual IP call backs, they could just do the same or better to move
> these up before a dump.
Suspend also put the status.hw = false and each IP in their respective 
suspend state which i feel does change the state of the HW.
To get the correct snapshot of the GPU register we should not be 
fiddling with the HW IP at least till we capture the dump and that is 
the intention behind the change.

Do you think there is a problem in this approach?
>
>          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
Adding this does sounds better to enable just before we dump the 
registers but i am not very sure if ungating would be clean here or not. 
i Could try quickly adding these two calls just before dump.

All i am worried if it does change some register reflecting the original 
state of registers at dump.

What u suggest ?
Regards
Sunil

>
> Thanks,
> Lijo
>
>>> +
>>> +               trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>> +                                            adev->reset_info.reset_dump_reg_value[i]);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>                                   struct amdgpu_reset_context *reset_context)
>>>   {
>>>          int i, r = 0;
>>>          struct amdgpu_job *job = NULL;
>>> +       struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
>>>          bool need_full_reset =
>>>                  test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
>>>
>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>                          }
>>>                  }
>>>
>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>> +
>>> +                       dev_info(tmp_adev->dev, "Dumping IP State\n");
>>> +                       /* Trigger ip dump before we reset the asic */
>>> +                       for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>> +                               if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>> +                                       tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>> +                                                       (void *)tmp_adev);
>>> +                       dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>>> +               }
>>> +
>>>                  if (need_full_reset)
>>>                          r = amdgpu_device_ip_suspend(adev);
>>>                  if (need_full_reset)
>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>          return r;
>>>   }
>>>
>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>> -{
>>> -       int i;
>>> -
>>> -       lockdep_assert_held(&adev->reset_domain->sem);
>>> -
>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>> -                       RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>> -
>>> -               trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>> -                                            adev->reset_info.reset_dump_reg_value[i]);
>>> -       }
>>> -
>>> -       return 0;
>>> -}
>>> -
>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>                           struct amdgpu_reset_context *reset_context)
>>>   {
>>>          struct amdgpu_device *tmp_adev = NULL;
>>>          bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>          int r = 0;
>>> -       uint32_t i;
>>>
>>>          /* Try reset handler method first */
>>>          tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>>>                                      reset_list);
>>>
>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>> -
>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>> -               /* Trigger ip dump before we reset the asic */
>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>> -                       if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>> -                               tmp_adev->ip_blocks[i].version->funcs
>>> -                               ->dump_ip_state((void *)tmp_adev);
>>> -               dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>>> -       }
>>> -
>>>          reset_context->reset_device_list = device_list_handle;
>>>          r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>>>          /* If reset handler not implemented, continue; otherwise return */
>>> --
>>> 2.34.1
>>>
