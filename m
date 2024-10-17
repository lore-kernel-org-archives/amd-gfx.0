Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBCED37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4473910E80C;
	Thu, 17 Oct 2024 12:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vx+8CboZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2963E10E80C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja6III4d8vDg7hnuH0X98yJCboWF0iYkltdVNTyV04WvldGRXeDPN7AFw6PfamqddVXjCIY2QF4A9pcNdDJuuHs5vZlPg0zmdINrMOJpvzzhQuIpvOQl5B6mC037pDFaCbggwbtwKrtUBr7VHxxbQZNOmg0ivyTSkGCmJ0NwHwov2SrzcIzNoEqpZAR3E+vUxkDpoFF+OVDGAgVGLh0GxH8v1tM8V+9+QKsR8czIXYoe15dvEt2DRBl6PLomdJ/Q7DunETL7z8013G9LlpO5d2op3VRMxWzMM5b+6sUZ06XQux7d+MP1KO7895ePVUe6AFZ/Qn2biqqpQfaXhC/44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n3DRbhmgAro27SV1S6Q5MtE2nlMPo55FP6I0R52w1U=;
 b=Q5ZqgNkM9s0PKiwE9wtzBOPCmiZVy/bvXMzOXvSrc4jr85F0mAk289L3dLIPHjEyDEgBb4vP6xrnZPELuq19sLNEjNEe+zfioonjaYRFJzkk/GywJ6mmRnS2ZzwVILPxZfNJmjzLkenmDEYLDc9FMoV08pab5p3GIyF06Nq7ed4Kix4aHCB8t2MZf7TnnJNhH0rjSTIQSKLXNAO9W+jx44tuIAPmu5YzoRSp5HXfdyvhACqUYQjhX7NYz8Zc5zOtBkpuWTqeZkdUhfmAiJ5cyYO/sH9a+HBk6UFzqPmdIsnnt2aMA4X1cMTKM460CIGPO9iO3rG/kyexMHzsuJ6PSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n3DRbhmgAro27SV1S6Q5MtE2nlMPo55FP6I0R52w1U=;
 b=vx+8CboZJqqOwl2xTyasRy7cIgIcLpfTvZLmBfVM8OJkVWcm7wYE7dAUnTLKWHhkEo+N76CNoIH6yia4s74QrNOkiMRg0CzpjyOxhXF6azpa6+/XB3fO0SdeApLAtmUAuduDUEhWUvj8JMO+p+jloW3xG+hqh++wFxNrwMuENkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 12:56:02 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 12:56:02 +0000
Subject: Re: [PATCH v4 15/15] drm/amdgpu: validate get_clockgating_state
 before use
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-16-sunil.khatri@amd.com>
 <1f534179-6ffe-446c-ba20-6b5ab4da8db3@gmail.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <58fef7b7-79cc-48ae-c632-199c44ed1f0e@amd.com>
Date: Thu, 17 Oct 2024 18:25:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1f534179-6ffe-446c-ba20-6b5ab4da8db3@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------D9FFBA80C607AF086D0460BE"
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: bcecbd80-df03-4065-e64c-08dceeab0e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1RiOU8vbVhPYkI2S3Q2b1hGc2lWQnhlTStVV055bjB3TmFWdzlEVWRSOXd3?=
 =?utf-8?B?SEhDK25Kb1VPWEFxTkI2cXFIZ3BGMDUyNmhOVmthWm5yYkkzS0pNR1JTNU9T?=
 =?utf-8?B?SWxZR3drUzdJK2c1WHZIK21vSWtWaFJVbk45N0I0dE5Ld3U5SEFXeGNKdE1w?=
 =?utf-8?B?eVpzZ1JNMldTMXBVWGhxbEZ4azYwR21BMEV2ZEZCMWlTazdTcC9LdjNJTjdp?=
 =?utf-8?B?czVoZUFxK09tZU1ROTFhNDB0Sm1IaG1QOFlERWd0d01XeDlqWVVhVElFWTdG?=
 =?utf-8?B?ZUttcW8yRWp1ckMyNkNQSU9FNHJ3Um1WZWxGUi92dTJoSHMrN3FVY0JJamth?=
 =?utf-8?B?cHNPblpHZTk2SHlVbkJGU29JMElWVno3OERvR3pUdHZTYldkdlJIQlJFTWJC?=
 =?utf-8?B?Tm9rVkxyc0pGamtKMmRSTEZNREhEc3Z1NWJEZ3NxQnJLR3V3Qk94WlJmcWVz?=
 =?utf-8?B?K3N0czFPeWU3MzhiNmR2ZnRHZ2dpb0hqV29xamRFTlVjeGQwMFJtbERwSkZw?=
 =?utf-8?B?QlIrbk1DWmQ4dFJiUE1WMndMVDZOL3FzVVJKTjVIbWUrY1E5aGdQeUVINDZ4?=
 =?utf-8?B?b0VTVXdZTVlwakE4TU1oSVBGbjVTa1daWURVYkdMQUdNTmJPMTNGMjAxWFhl?=
 =?utf-8?B?UDJCTnhWTHBBT0JaSzc3WlA1aURWOGFONnMzM1htd3BGMUpzU2NWYUFCRklU?=
 =?utf-8?B?K3V6V2ZwQWhqckQzRmYzRVZxL3RycEN5WGRrcGRIUnhQcTRRdDFTZys4Wkhi?=
 =?utf-8?B?TzBJemdCSEIyMG53czlsU2NCcnpJQm5WOXRuOWYwWFZ6eXY0N2cwUEVKS0xj?=
 =?utf-8?B?M1poUStEUmZzTlQrRWtiL2l4ZjZ2VGNqWVljdnVtZysybXhMZ0xCQkFXTCtZ?=
 =?utf-8?B?akExUm1sbWtVbVdCMjczaVdRbVhtOEpMRHlTVmExWVU3UmpxL1F5QytENGRj?=
 =?utf-8?B?YWF4c0c4Y2tWY05Qb3g4UTNxOTBjampZQzF2d2ZjREZ6SVdFc3l5QkJ4Kzhr?=
 =?utf-8?B?VEJqZG9DdGZSODkyVnVwV0RZdUpjbDZuWlZwRzNnV0t0MUZtV2s0dG5sTzRq?=
 =?utf-8?B?Y0dhb0JGOEJTdGJXd3hMWTBzblZ6c3M5NXJQMldyKy9sdHFlTEVZbEw4SGVj?=
 =?utf-8?B?ZTNlejN2U3BwdGdsaFlVdTY4ckpDekd5cXBiQUZMWGJIVURBR0FuQ1NtQWNt?=
 =?utf-8?B?dFNqbEphcmZ3Yk1hUzhEMXY2azR4U1YxdzI3NUhYeDRrd0t3dnVkT2dCNTdN?=
 =?utf-8?B?V3BqZWRVbGQ2bEJ4elY5SGRSQ0ZaTE1uREFiUmppMDZDSWVsYnErWE9BYmVu?=
 =?utf-8?B?anNLcWJ6cDFvaGlkamN4YjF3clpGZVJqZmRDdUR0WUd5Mk1DaWVpM1ZjTmpK?=
 =?utf-8?B?UjJ3UmJMYjFJQWNBMkJWVVBkazAxOUFhZEIxNGZUTmpkYi9RYVdlakxiZTdk?=
 =?utf-8?B?Mk5ZS1pyV1Z1MU5oM2RhbWRsTml2eUdTMk4yRHBCdXQxUlBhdEhpaUJ0OTNy?=
 =?utf-8?B?SE4rOENRejJxVTZCS1dabnFTb0VKQ2c4RUs3NUZrUERxdzQrRTlVeEljazU2?=
 =?utf-8?B?QUk1U1JWcCtJUW00YjlRM0NWaUZWL2FiVnIydjNoN2l3dUdCK1lPcjEzeGJl?=
 =?utf-8?B?YjVSQnptQWx0K1NOZXdrWXNscXFmSlg5SUJDVnZDVlVNL1E5cC9HZHIzemxW?=
 =?utf-8?B?aVNxaW15QUowbmo0R1pDQ2dLc2o0cnkzc2RLYW5DcW05QmVMZEd2Q05pRFk5?=
 =?utf-8?Q?Dh/NUm1PD53B64bRDxGYUGj9fasUpLJshIFAMD8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFyeVV1UWxGa2F0MjJDMmtuanN1MGhnaXVtV0w2NzNPYlFaSDZqZFdGaWVo?=
 =?utf-8?B?dEFOWlhWQmxGQktySXFsRWlHUEhJQnFVSlFUenlZbTBxK05yd3ZSTlJuN2Y3?=
 =?utf-8?B?Z2x5NG1kQVlicjFSU0duNWNxREhPYkRnSlByVzd6WUVTQWl3eCtEQVRqUjI5?=
 =?utf-8?B?L081ZEF5aWFLR1pmWFR6TzVueC91YkJkbC9pYU8yRDJHdWxpaVcxcjUvRVdz?=
 =?utf-8?B?bk9uNERXUXBZOEZQYk45MmFpWGx3OXZRdWs0eXNxWGFFbXkzcmVVYVZ3cE4x?=
 =?utf-8?B?QkozYWlKVzJ6aHI4R2kyN1M3dW4zbGtSM2UvekVjeGJGRGUwTklsbDkraTFx?=
 =?utf-8?B?OWhMMnJYUE1vWmVIUXprdkhxV1B5YkI4di90SVdWRHhORXpBZzRoR2cyTHMr?=
 =?utf-8?B?WWpndkdVUk05Q0ZCa2lsVWtMV3FOdnB6c2s2VnNsb1ZvWElGNlQzRXdpKzl2?=
 =?utf-8?B?ODF2YnpuVWtzZ0pvamhZNzhOenc4TlJBdUs2cGJYSjE0Q01INlk5VFIrMVVw?=
 =?utf-8?B?NHFjVHZMVVduNE81dk1vVkcxWGZUYmp4SXAvNXEydWJtOTJCZkhNYzVVMGtT?=
 =?utf-8?B?RXRDUzdRN2xwc0F2aGV0OXFEQ2ptcXVqUVJ4TDE0T0JaUGpLT2FITU9lTDVU?=
 =?utf-8?B?VHZNTTgrcXE3cXZWREhidXF1OVc2QVJuUjhuVTVpZnJDdTZITFQxUTNTSWI2?=
 =?utf-8?B?UUt5bWRQTDZNdVNSYmRaM1AyQit0QTJ2WTRlUEkrd2I4VzZmZzJBZkEzbVlv?=
 =?utf-8?B?UFg0M2dycDR6NzVXMnE5dmV1NlMrN3d2aEdQWUhuWUxubXlzenNQeHVFVnJ4?=
 =?utf-8?B?NkROdDRDWVRTVmhEUE80Slp4a1RwbDMxTmxHSjluUzFOSis0cmZyVVFZK3NJ?=
 =?utf-8?B?Y3dWOUtYVVJvZSt5RVJldjFDYWo0bHBqSjhXc3Zid3RwekdjTUMvSEkzVTNh?=
 =?utf-8?B?WW85NnVFT2cvL0liRVI1b28yNWVGcStZQ2NnNm16OWtDa2F6ODFNN01idTVU?=
 =?utf-8?B?S2kyWUVWWUx5ZTczYSs1TDA2NHhzUGxiSGN4R1I5YVpuS01WZmtKN29CaFVv?=
 =?utf-8?B?dTVrNldRNnVjQXBSQXo3UE9kY2ZZcTZxdnpocHdoV2tQaXRlZ0xDNU1reTJ5?=
 =?utf-8?B?VS9haWd1Z0xjMlNwMEo4SHcyVzBDaWtpZHlXLzBDTFRjdGQ4SjVmL3dOSHhr?=
 =?utf-8?B?Nm1mem9iVUJaMkhLZFhuRHQ5SjRyTms3akQ3RmFuZHJkTHdkWkdaUEM1Q2J5?=
 =?utf-8?B?NmxiVjlJaXBaQTV3dmwvOFhyNzNVYm9PV1NTdy83Q0d1QXZEZWF6Qm1vdmYv?=
 =?utf-8?B?cUFtaVBYaFcvLzZzb0VLQkd5aGJldnhpbmxtRTZPUG43Mnh1dG9Pci9sWEVk?=
 =?utf-8?B?K2t5SmI4MlNHOTlvZ0FMZWF0djA3Rkx5QzdXRG5WbUFQaWIwanlvTWZaUWVM?=
 =?utf-8?B?akl3U0UzY0M2RFB4WXM1QnM3Q09JRkNUK0VqbEpMYXZzWWJGM1BOU2JJQjFP?=
 =?utf-8?B?QzZYZ0VKTHExU0ZmSkVJckNOcEdlMjZXOVVwZ0xNcXBSMGwwd0gvZFhmbVR3?=
 =?utf-8?B?Z3ZxN01XTHZWUDgrcFEvS3JXUU5DeEprUW1EUFQ4Y3EyR3lFUDFFdjVweTQ3?=
 =?utf-8?B?WWpWaUgzajM0L2ZoRDVCTTUvcGw5Y1A5b1Ywb1pmbkpNakV5Q3BwamZPamhv?=
 =?utf-8?B?N2dzVy9lQ0kxZTJrVEJBUFlTV1BDUU4xR1FRbG4xSFM4eEhtcjBLeUhzZHhM?=
 =?utf-8?B?MUZkRWdONVk1czVYcUh3OXNsQ3Zjd0NkbVFTUG5OMGY2T3Fway85SkRTbjJ3?=
 =?utf-8?B?RjBTcExxVXVWazBYUEpKb0ZZVDhaeVBrelk2VGRVK294WnVJaWFKVjNVb0JU?=
 =?utf-8?B?aXRFaEJsbGtsUlRZOWhXbnplcnY3MkpUcGdKRWRPQnBISWFja1R4aEVJMFYy?=
 =?utf-8?B?S1hyUFJwdWc2TG9odGZFblpkRGZIN0ZMSlBIdUx6RDhGRXZuT3RlTzN3OE9U?=
 =?utf-8?B?c3BFRVJJS2tUQTdIWUY5T05pK0thQnNUendxSDduZTV3MGczN3NYVmpUUlRD?=
 =?utf-8?B?TFRuenQ2Q2piNHU3ZjRodi81dzdnZzdIMnNlS3krUkhmYUlJZTdqbXV5N29j?=
 =?utf-8?Q?NfbXolRPvRKDDCgYBpLwDjQve?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcecbd80-df03-4065-e64c-08dceeab0e22
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:56:02.4676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vTPM8Hv7l7Plj/MeNhN4IHZSausVTzOTWYyPJKFl9d7g8bgkAmFgDpIpcMcpXJd2V8EgHSQbzz+cMHzFIs82A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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

--------------D9FFBA80C607AF086D0460BE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/17/2024 5:50 PM, Christian König wrote:
> Am 17.10.24 um 12:06 schrieb Sunil Khatri:
>> Validate the function pointer for get_clockgating_state
>> before making a function call.
>
> Oh, I'm not sure if that is necessary or not. The NBIO, HDP and SMUIO 
> functions are not IP specific.
>
For many socs this check is added and only missing in the 
files/functions mentioned below. SOC where these functions are called 
are nv_common, soc15_common, soc21_common, soc24_common
eg: SOC15 already have these changes and its safe to add for other socs 
that i mentioned above.
soc15_common_get_clockgating_state Regards Sunil
> Christian.
>
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/nv.c    | 9 ++++++---
>>   drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++--
>>   drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++--
>>   3 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 6b72169be8f8..40c720b32c59 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -1084,11 +1084,14 @@ static void 
>> nv_common_get_clockgating_state(void *handle, u64 *flags)
>>       if (amdgpu_sriov_vf(adev))
>>           *flags = 0;
>>   -    adev->nbio.funcs->get_clockgating_state(adev, flags);
>> +    if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
>> +        adev->nbio.funcs->get_clockgating_state(adev, flags);
>>   -    adev->hdp.funcs->get_clock_gating_state(adev, flags);
>> +    if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
>> +        adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>   -    adev->smuio.funcs->get_clock_gating_state(adev, flags);
>> +    if (adev->smuio.funcs && adev->smuio.funcs->get_clock_gating_state)
>> +        adev->smuio.funcs->get_clock_gating_state(adev, flags);
>>   }
>>     static const struct amd_ip_funcs nv_common_ip_funcs = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c 
>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>> index 1c07ebdc0d1f..196286be35b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>> @@ -975,9 +975,11 @@ static void 
>> soc21_common_get_clockgating_state(void *handle, u64 *flags)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   -    adev->nbio.funcs->get_clockgating_state(adev, flags);
>> +    if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
>> +        adev->nbio.funcs->get_clockgating_state(adev, flags);
>>   -    adev->hdp.funcs->get_clock_gating_state(adev, flags);
>> +    if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
>> +        adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>   }
>>     static const struct amd_ip_funcs soc21_common_ip_funcs = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c 
>> b/drivers/gpu/drm/amd/amdgpu/soc24.c
>> index 3af10ef4b793..f4278a0fa8f7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
>> @@ -564,9 +564,11 @@ static void 
>> soc24_common_get_clockgating_state(void *handle, u64 *flags)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   -    adev->nbio.funcs->get_clockgating_state(adev, flags);
>> +    if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
>> +        adev->nbio.funcs->get_clockgating_state(adev, flags);
>>   -    adev->hdp.funcs->get_clock_gating_state(adev, flags);
>> +    if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
>> +        adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>         return;
>>   }
>

--------------D9FFBA80C607AF086D0460BE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/17/2024 5:50 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1f534179-6ffe-446c-ba20-6b5ab4da8db3@gmail.com">Am
      17.10.24 um 12:06 schrieb Sunil Khatri:
      <br>
      <blockquote type="cite">Validate the function pointer for
        get_clockgating_state
        <br>
        before making a function call.
        <br>
      </blockquote>
      <br>
      Oh, I'm not sure if that is necessary or not. The NBIO, HDP and
      SMUIO functions are not IP specific.
      <br>
      <br>
    </blockquote>
    For many socs this check is added and only missing in the
    files/functions mentioned below. SOC where these functions are
    called are nv_common, soc15_common, soc21_common, soc24_common<br>
    eg: SOC15 already have these changes and its safe to add for other
    socs that i mentioned above.<br>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #dcdcaa;">soc15_common_get_clockgating_state

Regards
Sunil 
</span></div></div>
    <blockquote type="cite" cite="mid:1f534179-6ffe-446c-ba20-6b5ab4da8db3@gmail.com">Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp; | 9 ++++++---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++--
        <br>
        &nbsp; 3 files changed, 14 insertions(+), 7 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
        b/drivers/gpu/drm/amd/amdgpu/nv.c
        <br>
        index 6b72169be8f8..40c720b32c59 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/nv.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
        <br>
        @@ -1084,11 +1084,14 @@ static void
        nv_common_get_clockgating_state(void *handle, u64 *flags)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags = 0;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
        flags);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs &amp;&amp;
        adev-&gt;nbio.funcs-&gt;get_clockgating_state)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
        flags);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
        flags);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;hdp.funcs &amp;&amp;
        adev-&gt;hdp.funcs-&gt;get_clock_gating_state)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
        flags);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_clock_gating_state(adev,
        flags);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;smuio.funcs &amp;&amp;
        adev-&gt;smuio.funcs-&gt;get_clock_gating_state)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_clock_gating_state(adev,
        flags);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static const struct amd_ip_funcs nv_common_ip_funcs = {
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
        b/drivers/gpu/drm/amd/amdgpu/soc21.c
        <br>
        index 1c07ebdc0d1f..196286be35b4 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
        <br>
        @@ -975,9 +975,11 @@ static void
        soc21_common_get_clockgating_state(void *handle, u64 *flags)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
        *)handle;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
        flags);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs &amp;&amp;
        adev-&gt;nbio.funcs-&gt;get_clockgating_state)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
        flags);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
        flags);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;hdp.funcs &amp;&amp;
        adev-&gt;hdp.funcs-&gt;get_clock_gating_state)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
        flags);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static const struct amd_ip_funcs soc21_common_ip_funcs = {
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c
        b/drivers/gpu/drm/amd/amdgpu/soc24.c
        <br>
        index 3af10ef4b793..f4278a0fa8f7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
        <br>
        @@ -564,9 +564,11 @@ static void
        soc24_common_get_clockgating_state(void *handle, u64 *flags)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
        *)handle;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
        flags);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs &amp;&amp;
        adev-&gt;nbio.funcs-&gt;get_clockgating_state)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
        flags);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
        flags);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;hdp.funcs &amp;&amp;
        adev-&gt;hdp.funcs-&gt;get_clock_gating_state)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
        flags);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; }
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------D9FFBA80C607AF086D0460BE--
