Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06D2CCD183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 18:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AB410E0E8;
	Thu, 16 Oct 2025 18:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LuLsoLiQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA08C10E0E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 18:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXriXrCMebwGltxfB4ah/LwcgWSzcTIXR57Bz1Edf7jWVx0GjloiBwMilSnnA04APYZ0cs51qCHCG59zXtEulZ80NPLoVkCDxaAmHL1VeLkAKhqJCZHmqa3esN+RQwlZkrTZDgfr3dMdtO86cRlKvnxdCXKUJGgnOKsoP9KcTWQfThRKBs7MEin3iS6tPtmCI25ISm7h5HJo33VO98y8ynC/72PuZe2auXtUajlGSjWyV56UaDKEDfpTh3XicbBkuhkQ1bb+qIdAbdAKqgylF2E/avEm+5vec4BRfnQ4CVg9vcKPqjXIOihAHEHDC3PwJS+8xLxIrW+3VDszaQf49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAD0Yq6FyrQRveFizzL4hYw37gOStyZIsaOLqmCVOVo=;
 b=Po064VqkLLPmxOO2wjsPdGjDI3wzH9uUeBDIty5qVv9cUGixCEYUk1CleGH+FM/hTZ2ejIfA8hi1oGQe2VX+I2N51Xyda4y6QY0A/Um8YUEZaCxh1Nb6Y0HSVNEgnI8/3FmLgvfLkNNUt82g31dqFGkTldKRaEsmhIvJIecLiLEeoHb6+S6m15Wpv2SvZ74yEHESEKijJHECfaAZZffAa6WRJgiiSsDkfbf9fMFecO7+YSRbDOjgD6Vfj6XCaTi6/CwzkFrywAoidywywMQ25VrmzWL4Hxn8lbPEES+Irr+e7QKT6TSD0pqE9Bp4WoT6+dAqzPehMEX0gCxfjnJ5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAD0Yq6FyrQRveFizzL4hYw37gOStyZIsaOLqmCVOVo=;
 b=LuLsoLiQyuzH2H5hA/CiGONA6MBIDFQcr30P36YICbOQb4dKS7TdkoAdSgVIm9ctIUInaAftssfO+d/xsRVwHse3CaNl8ZY/zHUYaxRh1JiCMpHZQS/ihftGLQIRs9NySGaxwlI5v4IuVLS5K5vmm7oq6/9mefYB9vjl6aLFlTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 18:01:28 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 18:01:28 +0000
Message-ID: <bc5d2901-59fb-f241-1d68-7372c59c170d@amd.com>
Date: Thu, 16 Oct 2025 14:01:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <682f9477-ae2c-4022-be84-620cb02e388a@amd.com>
 <42c82bf6-e100-076f-18a6-43a50e758d8d@amd.com>
 <39f7504e-a162-42bb-a481-6c2c7aa8e416@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <39f7504e-a162-42bb-a481-6c2c7aa8e416@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfcaa5b-33c5-4d1c-d57c-08de0cde0756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1NhSExXWUJNalBsRmpJQnZHTkpUODVQVEIzZTNQaU51SXJGa091b0VIUGtT?=
 =?utf-8?B?U3FEei9WRXhacVhsVitJbk50aHZnd25iWnJLZ3BEWUU2Vm0weVZvRWZGbWFh?=
 =?utf-8?B?NEc5ZEloN3ZDemF5OUQ5aVZPdmF6eERibzg0Z3NQWVZIRWdUR3Y3NFBoc3I5?=
 =?utf-8?B?SmdxQWRTN3RrcUxMUU9JWmhacHpERklJVjEzM1IwY2RYTDkrNFFIVmVHRW1l?=
 =?utf-8?B?WmlZd21MeStINkpiZm5IZlhDdnBmeFRlSWcvcHkzRzRiVEpqQitiTzZtc25P?=
 =?utf-8?B?dWQybmFRYlFQbXhHYTJHZWdHRk5VV2w2a0NBT05nNFFGcXpBQjV5bXduVVZ3?=
 =?utf-8?B?Ym9Wci8vdlZBNm82YlVybzI1aWxadzI0K29aZDVid1I4VWRjK0dqV2gvZzc1?=
 =?utf-8?B?N1pxY2c3ZW05ZGxhQklwT01sRU4yWnNOOGpnaml6S2s4Y2VLY1pkY0tPNVNI?=
 =?utf-8?B?MS9RNWxOS3doYWdrblExTDNkcUdNaWVGL0hrM2szbTBXL2pBUWIxUmdkSGdE?=
 =?utf-8?B?ci9nN0dMODJHT1lpNUpvWlV1NE56UjRGTTV1b0ZIMWt1OE1NbE5mWkVUaFRU?=
 =?utf-8?B?RXdjL3FWTzJlbUlpY2NFMjY5OGpYdXB4K1ZSRDR5d0ROWEJSOGdHYXp5Qy9v?=
 =?utf-8?B?ZTJzbXB1Q0djd1dHbTN0NEMvY0pCejJFcWxyQm9tZXduTjlOOEZIYVF1elJS?=
 =?utf-8?B?OXM1Z0R4RjVIZURvRER4SmhhV2tzdkhxOUpqMGQ2ZnRWRC9JTnQrQThhcHk5?=
 =?utf-8?B?WVpyenBVUXBmVWRZekczaWhLSmNPY3JvM1RTelNDcGNjK2NOL2lYZHhQRmRI?=
 =?utf-8?B?NG5NSGdMZHhHZjdyY242dnpGWGZoMUMwdGJ6VWVCWEp6Sk5LT0kwYllkUlAz?=
 =?utf-8?B?QStKWlZQdlkxSXJQSVVrR3JWVTlzMnRwNDhJSGpYdjEvY3ZCZXg5Nzgwb2Fh?=
 =?utf-8?B?dmNlUUc2RmFkVGNkQmpxQktsZjVCWm5wWUVhVnhBSDNzY0RMa0pkZzdCVnhv?=
 =?utf-8?B?ZzZzWHAxNkRzR2kwajhJMUErcVJBWTZVcFJXeDJoK1ZBMlk2WXFockx4bWdS?=
 =?utf-8?B?b1FvWEp3Z2dRbFRBRGkxZ2FZMzRPYTd6OTNiSC9VTGR5N2lETXE4ODF3Rm1r?=
 =?utf-8?B?Nysxb0djcDBVaS9qRklLWGU1ZzFRM283MEg0bzlDaGI2a0FiWk8xaXMzTFNt?=
 =?utf-8?B?QzJDR0U3bTlzOEw3SzltSXk4d3pud3hkREhpcEl0dEJYbVkwRmc4MWEzMjY5?=
 =?utf-8?B?Q2xqcjhBNlB2SEVxMDVzWTJucUlKeityR050QzFSSmVkSkVkenptMjVoWGlI?=
 =?utf-8?B?QVhpK2tJMEhlMEI5STh2Y3hzRVdpWmVXM1RMZnRCb0JIeHFiN3ZyWnJNMzFV?=
 =?utf-8?B?ME9QcW5MWUIyVVU1anFGZ2N6ZytkazZYbUpnYmxVMktWd1VQY20zN01LcTdo?=
 =?utf-8?B?V1ZBdDUyOVJ3V0cvMXNLSlBWT2pwMFBCb3ZNdDc3ejBYZWJsc3haTk4wNHha?=
 =?utf-8?B?Q1FmYjZtNDdKTDlGS3BzSFhkcDh6L1NYb3VkelZpSjZsNUFkL3pwb2FkeEU0?=
 =?utf-8?B?bjNHampYY1pRSXEzRSs1RlF6KytESWxiTGxEeEtqeTBEZkFkTEMranJ6QmZ5?=
 =?utf-8?B?Wkd3b014eTZxYnliVjZCM29OeTl0Y2l0UE9LWjk2TGZSM1pkUnR3QStScmFs?=
 =?utf-8?B?cWF2ZXNJUnNHTDFQMHJLUlh6OU44SmFPNVV3bTFOc2FZM2twanpzMXl3M3ZT?=
 =?utf-8?B?L3Mvd1d3Rk05Qy93UlpBN1QzbTNXUEhJVDdLQjFzU09YWXEveTZxZ3FZb0Vo?=
 =?utf-8?B?YXJVanVuQ1Y4RkJWZmlGM0dSTFdEK1dMN2lhRmNHelNqRGdsa2t4RGp3dDEx?=
 =?utf-8?B?djFKOHdwTVJyY0gwWkEvWE10WHhwbStzN3owZkNpdHdFUzBqUTdNMjVJT24v?=
 =?utf-8?Q?tvSY4dVxxMi7d0lNZ50excStXLmtDSFR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVBGV0MrWFh1VlRma0dMMUpPQ0ZsLy9DTXpUbE1aMXM2UnBzaEJLTURlWm5G?=
 =?utf-8?B?K0lVUGxpcm9lWno5NnFGWUI0TVordkU1L0NpNGVycklwKzA4SytPVVp6N0V3?=
 =?utf-8?B?WjBKU0VuQzMzMVdhc3ltUDRvQkxSSUlwWVZuL0luUkhxK0dKS2J0WHRnU25m?=
 =?utf-8?B?eVJocy9YQ0NTSmg1czVNTVd0MlA3bTVwQkRFdGNUQUhMNE1VcUZHcllsMGg0?=
 =?utf-8?B?cFA4WnVzVWdxTzIrcGM5WEYrT00vNHR0ZXVrT2szRjZVMzNRdEFVVTBGUDJT?=
 =?utf-8?B?bDJzNW9pckxMRHRmZHlQdnJRaXJ1aGpZUjR0S3d0YjRyWnZYVkVqRFovZHJh?=
 =?utf-8?B?Q1JlTi9XQlF3WWJvS0dMLzErRTdPS2pzLzF4bDNtWUVhMm41TlVOdUdBbmhV?=
 =?utf-8?B?SlpkYnJKQXltMVUwZzhXTGhMNks2UVpSMlVGZUJ1UXRGVFgvcDdsUkVjOFdF?=
 =?utf-8?B?NFpVTUtaRStkU3pDT0F0SEhwNU1WRlhJMkVsVEF4TlptenJRRE5EcVBBOWlo?=
 =?utf-8?B?U1pKQ3I3VEc1ZkVJenN5UnpBK0lUcUs2aDVDMS8wcEhMWlNPeHZmRHYwNXNr?=
 =?utf-8?B?Z2FoeE9GOUloYzJhK0EzbjZtcWROUWtVMDNUSHE5OUpBYXBQbnB4QVo0ZEdp?=
 =?utf-8?B?UGliTGlmTjlJaUJYRUV5UGZGK252ZGxXM1BaR0hTb0FDc1NHOUNCRGtDdndo?=
 =?utf-8?B?QSsxOWNvTkZCZ0VRNTNIT242WmNSZTJGSHdWS2pNODdCY0szenEvMEhTRXVU?=
 =?utf-8?B?bE5hdDIwR1lFKzZXZzlQWXl1OEw5Ny9oMHplQ0c1c0J4U3E1R3VONXFDUlVS?=
 =?utf-8?B?TWZQdkwxMzBURzVhVExJL1NDWGlCSjBHN3hkTUYyU3NDNXVGM2F5T0IrZ2Mx?=
 =?utf-8?B?bFkzYmNaWHJHV09LV2FKK05kL2pYNVVvRDBVV1RIWjNkZDBLQU53MzBBOXlk?=
 =?utf-8?B?Qm1oOEdVdnJnS1l4SURpSTErK0t5d1FxOUJFS042SkdzdEJudkFvN2NlcTFM?=
 =?utf-8?B?NGpubVJJMnRpcVNSY3B1NXRySWZqTEZtWk9BOHlWb25QWS9IZFVXM3gvVm83?=
 =?utf-8?B?MTZETGdDUy9UQi9aa1JMdmZsSGxOSitTcWNtRlZIRis1R0JmUkpqamFLZjhX?=
 =?utf-8?B?a3h5MWdmbXg1bVh6NDE5WVVOazRHY2oxYWJUTGlSb1BBWDV3blVGUnN2T0ZU?=
 =?utf-8?B?VGZBTFM3ZGlTV1dHR3VzeS95bEExazBUR1AvbkloNys2Zy8vajIwcERvV3pr?=
 =?utf-8?B?VVdrbDdwRWtnY1NiUG5ia0ZGZEtBY0thRlVtelB4T2ZYQVp5THF2QzNsYUpz?=
 =?utf-8?B?QzQwaHdiMktFRW9sVG5XeTJyaVVJNXB1QWovdmxWRWJmcXNPNkhkdlBPT0hU?=
 =?utf-8?B?THhRMDdicXUxVHI1UEVRRzl4VXJMS1dJVXV3cm8zV3FXTlZOVVNBRnd3OTNh?=
 =?utf-8?B?WmxIeUlJRjdDalBoYlYraHBOOWRUZGpkSlpVSU5veityNWZ2NFMrTUNxcDZi?=
 =?utf-8?B?M3diY29jVlhadXJkSVR3REQyWW5oWC9xSEh4VzRtSm85bVgzQ25zSXhtVktS?=
 =?utf-8?B?Qk1YOXZFRDFNSnJqd1JGbXJ1UFViVHZmYVBZb0RVUE1qMk5QaVR5eks3cDhJ?=
 =?utf-8?B?RVI0ZHAzNkY2TC90UjA1a0FqM3JLa05tZHYydUIxb2V1bFFrRXA0UDcyM3FB?=
 =?utf-8?B?ckRnUnRVUHpUdk9UTnp0RW5Rdi8ybjVnVlNwNmluOFNvN1dRYTlBZEJRVHlK?=
 =?utf-8?B?b29qKzVkd3Z1Y3J5aENNbHFvNmtjVnNoN3RqOTlSVXk4Y1gvWDBEVlBMK2ty?=
 =?utf-8?B?MVBRcy9yK0FySmYyU1Fsd25VWjI3RWdlUncvSDVRTFM1VWxHNUdUaVNkWCtX?=
 =?utf-8?B?UjYxckxoeG51UldFbmZ6akRTblNwMTM1TjJINzIxV0gxVmNrUXFHT0x1bHQy?=
 =?utf-8?B?RjdERDB5MlRwNUtqS0ZKQTRFeHVYNTdUZUVQNVBkSENjUDNoVnVmcGgyZFJi?=
 =?utf-8?B?VEthcEN6Q0FIWFRyaWpWT29reHE3U0lVWjFFQU5LWXdjVERyRE9FS2RUWlJk?=
 =?utf-8?B?RFI1Rm5GOTU2VHdIZWVEK0dTTGZSR05oZGY5V2k3RnROY1Y4UzRiQVR2TFdj?=
 =?utf-8?Q?vm1g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfcaa5b-33c5-4d1c-d57c-08de0cde0756
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:01:28.0481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a22eyiMoMnuelO4qeAJc1VJqcmdlvXLJikmHgInYsdudXT411SMapyPvBzer73JA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
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


On 2025-10-15 18:46, Chen, Xiaogang wrote:
>
> On 10/15/2025 4:45 PM, Philip Yang wrote:
>>
>> On 2025-10-15 17:01, Chen, Xiaogang wrote:
>>>
>>> On 10/15/2025 3:11 PM, Philip Yang wrote:
>>>> Only show warning message if process mm is still alive when queue
>>>> buffer is freed to evcit the queues.
>>>>
>>>> If kfd_lookup_process_by_mm return NULL, means the process is already
>>>> exited and mm is gone, it is fine to free queue buffer.
>>>
>>> But another question is why a prange is still alive, its kfd process 
>>> is gone?
>> It is application process exited, kfd process structure still exist 
>> and available. The issue is race condition:
>>
>>    do_exit
>>       exit_mmap
>> a.          mmu mm release notifier, schedule kfd release wq to 
>> destroy queue
>>              unmap_vmas
>> b.                mmu_notifier_range(.. MMU_NOTIFY_UNMAP...)
>>
>> the step b is executed to unmap CWSR svm range, before step a kfd 
>> release wq destroy queue.
>>
>>
>>>
>>> When unmap a prange the queues that use it should have been stopped. 
>>> If not, there is problem somewhere. This warning message need be 
>>> sent no matter kfd process exists or not.
>>>
>>> I think a real problem here is kfd process need be alive as long as 
>>> any of its resource is still alive. In this case since prange is 
>>> still alive its kfd process should not be released(p should not be 
>>> null). If not we need wait all pranges from this process got 
>>> released, then release this kfd process.
>>
>> kfd process structure is freed in kfd_process_wq_release after 
>> svm_range_list_fini.
>
> I wanted to say: delay remove kfd process p from kfd_processes_table 
> until all resources of p got released. So when any p's resources is 
> getting released p is available. That needs change kfd process release 
> logic.

prange->queue_refcount will be 0 after queue is destroyed (not evicted), 
we should warn user space and evict queues if prange is freed with 
prange->queue_refcount not zero. This patch is to fix the race that 
generate false warning after process exited to free prange. I don't 
think that keep kfd process in kfd_processes_table after mmu release 
notifier will solve this race issue.

Regards,

Philip

>
>
> Regards
>
> Xiaogang
>
>
>
>
>>
>> Regards,
>>
>> Philip
>>
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>>
>>>> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory 
>>>> residency")
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 4d4a47313f5b..d1b2f8525f80 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct 
>>>> *mm, struct svm_range *prange,
>>>>       bool unmap_parent;
>>>>       uint32_t i;
>>>>   -    if (atomic_read(&prange->queue_refcount)) {
>>>> +    p = kfd_lookup_process_by_mm(mm);
>>>> +
>>>> +    if (p && atomic_read(&prange->queue_refcount)) {
>>>>           int r;
>>>>             pr_warn("Freeing queue vital buffer 0x%lx, queue 
>>>> evicted\n",
>>>> @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct 
>>>> *mm, struct svm_range *prange,
>>>>               pr_debug("failed %d to quiesce KFD queues\n", r);
>>>>       }
>>>>   -    p = kfd_lookup_process_by_mm(mm);
>>>>       if (!p)
>>>>           return;
>>>>       svms = &p->svms;
