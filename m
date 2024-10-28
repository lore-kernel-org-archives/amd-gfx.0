Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5390AD3E2C1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857D310E560;
	Mon, 28 Oct 2024 19:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n7bBDVh6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7EB10E560
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkscO4xnGbSxhQBfXf+/MhrwjS7BWr/eFUgglcwIf5CpqdWmRzEClHNn2y85u28Gojv2x3V7DzmJ+R9mfttpoO9usyY5M4pu92vkjw9xJzzK1OAMXNO3erW9oIsHKWE9rHPT7WyXntWgs+f0LHF5qRwJUBjNY30XYC429xE03PLC4Q0J/D9Jhr+cg54PkKIoKuswrYalWbVh59rjgxR8/C7vMIr2f8n+fLGDSdOkphPCinwce5kaTG/Q+2jJoYcKw+UNEZKv2KhCYQk2OsQyIq6MMufIYDg0MChvU8JP9M0SftFEVvS68pc6Wonyi4T9+C0yJAFNNmT4cLBvXElECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grtbhNEs4jZmQX8sQNPwCx6fiNAD2VPU/FSjeYZZo00=;
 b=rvRB3SjKfMhLEH01jtz37PmAYbIMTZ38m+hxDIoLPHzLx6V2+1E9bqBAvYsjx/e1B8uRp8vMoJ9Pwq0Ud+oanOnHU1NkceHfGueDrIypsL+8Gpf0SIy7L2X/5G8bo4nMT8WPrd3xAEaT84drBeOqXQ7Z5ugk1miy3JnCEmPh9mDsEuUhyJmnCm8A69Bo00nSYC34DMgeOfsGS74OZOwZxPCg90MLe5aWUUyxb3WR1rk2WgpIY1/xJyK2q4NrepCc/GFRHEsOkBrsKDejEPbwIQsGpxTD4XHI2AgRUHTpDB4l5GKxkMlfY18g2xLbhRctNAWdVOu5xbWDYqLUEliFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grtbhNEs4jZmQX8sQNPwCx6fiNAD2VPU/FSjeYZZo00=;
 b=n7bBDVh6iT0FtMPn6GF4qbkpdzZVkd9cF5qWtn8O7pUdx8k0vilO2b4aflToH5wpHpt5ZSZm4h6OilKLVgGyRSZoJzlNhxmJIwCeXULOtCNhi/sbkKChVf+uCObBu5s78b2t7N99YgMG0JcgOW9+gqYlFaKCGGleud7+c6aa2aM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 19:53:39 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 19:53:38 +0000
Message-ID: <69ceb132-9cd4-45ef-973f-6dab0dfe1dab@amd.com>
Date: Mon, 28 Oct 2024 15:53:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/29] drm/amdgpu: track instances of the same IP block
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-10-boyuan.zhang@amd.com>
 <CADnq5_OQ=Nj_U5gYODLkHnoPpvKBpWrtVQynKJ=z=1E7_QUeBw@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_OQ=Nj_U5gYODLkHnoPpvKBpWrtVQynKJ=z=1E7_QUeBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::28) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f1344e-e355-4fa0-cc1f-08dcf78a2502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0ROT1NPamx5L0g1VkRsY1Foc2JUYTFNVnFaeFdDSXdjMGw3aHgvWUVveldh?=
 =?utf-8?B?OXd3T3RqK1ZrMDhiNHRjdGtLZ1BUR05HVkZkZ3EzVEJpWmFwQ3dseTQxTXZM?=
 =?utf-8?B?bStYUGxHb1MyWEhWZmZHR3JTK05CdUtDaGxxdVJyMnlRVVF3Z0tacDFOWDY1?=
 =?utf-8?B?TWVPdjB2eTc5akhzazI4VkZUUWNud0tTRTlLU1BHSGVqelZXRTI2NXBkVUVY?=
 =?utf-8?B?aGEzdHcxUmlaZi9pSlNwY1RLT3B2QWhJRzAwbk1TNlEyVThDdHRrOE5sVU5n?=
 =?utf-8?B?RUdpZXZvTGNmWGViYnlPZXFWMlhYODUwSjlRdHpuQnc1cFN4Nlp0UzdZRDRD?=
 =?utf-8?B?WURUYzdCdVhkWWQ2YXIyNkVGdndMNDAzSTBvdXVraXgvYThIMnM2MXRpb1dk?=
 =?utf-8?B?bVBPTUtPQlMzczZ0eGQwQStlazlxZE45MzBvTnIrS1c4WU9RM0wvK3FUa3Bt?=
 =?utf-8?B?WVgvaFQvclRFaE52bnNsREFqVUVyOTdUU2hiOG9SWjNlVzB5THcrS25sWUY0?=
 =?utf-8?B?QU9uOHNzaU95SjdFOUpCMTF2RXFsbVdGck56NVpnOHVHa3lTTmVrTHJTTGJN?=
 =?utf-8?B?NEdqdW96V1ZSNzhWN3BhdGVGY3Bxc1p2SlZBdXdNVGMwcEZENktxZG1xRFE5?=
 =?utf-8?B?S3F3bFRyaVNCMkhkWmpra1NFa3VNNUNSd0x3ZkEvVkpqdDgwbUZsYmo2T1F2?=
 =?utf-8?B?dGtaamljaGlaVG9BV1hPQy94amlNekI0SXpmRXRWTXg2ODkzekFQNGJKQWVh?=
 =?utf-8?B?UXgwejRRTHVZQ05FbnBmWDJRR29FbG9Jc3E3cEIySWxRVVVFd2RGcURGbXpJ?=
 =?utf-8?B?MjR6cVRVak16YnhDNGY1b1F5b29nd2V0cFFOUndpd0tEcGU4THdrRVVqRnFT?=
 =?utf-8?B?N0JQZkEyalM4cWEvZ0YxN2lsZzhFVlpsK1dLekpRZTc2bWxTNnhTVjBiL3A3?=
 =?utf-8?B?bm1jcW5TOHZraFBPWDRiOUJOcjB0eTR1NFpLYlZqRUN5bUpSUU5pUzE0Rk5a?=
 =?utf-8?B?bC82ZTNicTRwYTUzVUxkQXY4NGN6VjBrT25EZ2UrTnM0K0dkbXBzNmZPczgx?=
 =?utf-8?B?WXJNTVJmSDZwc1BvRkZTUnQ4ZUpNQllPK2VuMFlUUnhPMFZiUTAyWUxiK1VL?=
 =?utf-8?B?QjYrbFJOWVB5c3Y0ZldKUGFLanM3ZVRicnhqOHU4empvSE5pN3VycjY3WEhQ?=
 =?utf-8?B?bUtOdngvVkgzSy9xTnZ3NDMzZGZJdHYvb2ZSMFFtbE9oUGhPclFxaVFRNTFO?=
 =?utf-8?B?TTdmTXYrTUFGQ09ySWV4d0g3WDJ2VmFhUUEvUm1IQ1dwbmFEU3EyNm1TMk5X?=
 =?utf-8?B?WVNURWpuckNWOThrYS9IU0dtOHFrUU8wSlhBVU1iM05YaG8rZjltL0tqUTJC?=
 =?utf-8?B?ZnhSVTgvZXlsSkF1WGk1ZzZkbE10czlHNFZKNW9nc3FkWXREcmZaSEVlMjZJ?=
 =?utf-8?B?cm9VVmcxNW4rb3gwWlQ3ZVRXK1M1eEFOWkdJSEVrZFpyUlY4eEZueUViNXow?=
 =?utf-8?B?bjNCTHcvanJkTHRaalJkNFE5SDYyczBpdy9jeU9QT1FhUU1oZ1lJcytneTNv?=
 =?utf-8?B?YjNoR094MkFVZmVXeDBhS3J5aXYvM2hpQjQ5emwwMEtpb2pCUWI5T2J5Ni91?=
 =?utf-8?B?RG9rSWJESlZPOWJVblRST2IrZ0hFUVlnSnZoVkxobDcrYnBqSFJ4Y2xCcHNC?=
 =?utf-8?B?TGZnSXV5bFpHQ3A5dEZwN0pNTWVUNVNJQXExRjRQcW1peXFHRnNncTZKSUh6?=
 =?utf-8?Q?U/+gtM7PxnmUUwgPd6cHl7ZcN9C96KR+3pAV4lQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRaWlRCMUtGMmNWMzFiS0hTVjJIM3FuTm1RNXBSVnRaeWVEeEVuTXJrMzBF?=
 =?utf-8?B?a2dITkwzeTFRQ1hvdWV0cWM5ZFhJK0c1WG9PemR2dml1TmxQVmliY01xQXFZ?=
 =?utf-8?B?RzJSeWE3RnF6dzY2NThFODFqdktYa3gwR3hnMmxQWU9SNDRMMzNhcGJZTTAw?=
 =?utf-8?B?QjZnQnNKSTJTV2ZSYmhZVkoxRzgyQjgvTmdmelRlL1RoZWlqZERkV2ZEV3Rz?=
 =?utf-8?B?V0JBcjdXb20wNENVVzRHOUZVRldHRi9ldmRSTmZvZFlGRHE3ckhST3Yxdy82?=
 =?utf-8?B?TFZ4Sy9sb01XejJIRjI4SFFKMm04azdCQWVFKy9FWGNRSVlXZlhwUldZcXdV?=
 =?utf-8?B?Q0xQVmJUcjZlcHhmM2o2MEI0MTVTU3hyZVBYQUFWUDFkQWNJaGpQMlFrSFJ2?=
 =?utf-8?B?MHR0bFN5Zks3ZDBqenpJM2FUTkkvc1AxOVFkYTlCa1ZUWWlpL2wxSXFVUXhw?=
 =?utf-8?B?Y1Q3NUhSb0R1bmxwVGl3NkpVZUVqK1Nja24wRWpKajlockpIVkJjSjNpUzRV?=
 =?utf-8?B?QW42c0l0K3VGRGlLTGFxN2NnNHVINnI5bG1oWDdteTIvVEZrMVZtamd5YmhQ?=
 =?utf-8?B?ZkxzSHkyZHd1TEoxRTFVWDk2U0tSdmFpUHFGUllROUZsQ1RXRE5RaUczKzAy?=
 =?utf-8?B?RkZybWxIZDlGbGdrb1QxMmc5RGQ4a1d1QW96R1ZBTkIxOVkzeWorN3RvVTdT?=
 =?utf-8?B?dUJiVVlEK2R1ZnVuNko4a3RUb3Z6bjZMbk5BUFE4N1IyckRXYWVwTjFSWTRG?=
 =?utf-8?B?WnlZWjJQcnhEckpJV1FlSGgycE1OVzhwM3VGMllLRncvRmU4S1N4YUZ1WjFv?=
 =?utf-8?B?b0R2cEJCSFozV2dLTkZ1Zmkwa056SFVBeURJT1hFNWNveldvanpVbFVLbnZy?=
 =?utf-8?B?dDZ5aTZUSHlGczk1NTloUnpvVWp6Ym5oUGJ3clJvRTh1MnBLaXdoSHFTZGNK?=
 =?utf-8?B?N3JwQnhWMWFtYTZTSXZLc1kyRkxWYlQ2eVpRb1JuTlNibHVNOGlsUjlBZC9w?=
 =?utf-8?B?TWM1d0JGdHpvWW1FbE1icjJzMEhNcTc5V2RvQzlDdXNLQU1say9tWU5pVzJ1?=
 =?utf-8?B?QWVWR2tJRjk0RmxPRmFkR3IwTHhGVkNDSFNHSmZJeDdkMHNDUEorcnlPeEx4?=
 =?utf-8?B?bFFZLzdiTW12YkpYcmFreGt0c01obHd4c1gzZ3RxTTRCaXlnK3VkVWFUelUw?=
 =?utf-8?B?ZVdMYWlqbXlnZGQyZUpneUlwNWFOL3BocTY2Nm5xUUVtMDdHdW16Nk55RHl4?=
 =?utf-8?B?azZLempOd1F6M01NNmVENVJIcmkrV0dNeVdYT3ZJWVFhdjIwOE5QMHU0ZHdj?=
 =?utf-8?B?bmc3ak5hekdWN0JRN0VCRSs2ZUZYL0FqRytMTEQyMlVma1VydktOdjFoaENP?=
 =?utf-8?B?eFhUbXpVbTFRQTJCRXpveDd0YTBOUVZiTjVIMWt4UGg3L2hRMWFxSHhKbFlQ?=
 =?utf-8?B?N1FURS80UHFnM05Ha1ZCR2xDUTQ4SExDVDBYNGdDQWJ5WXNXWnMxSVhvSWdq?=
 =?utf-8?B?QkRETVg5MTNIYjczVmIvNk9aSjJGbUNSQ1A1SWFkTmNGSkFibkt1WjU5enh6?=
 =?utf-8?B?Z2hkQ0tibWZaTWRaNWhOK2ZPQ0gxV1FhRmlsSVZxRC9TQW42VFNtRGFaMDVk?=
 =?utf-8?B?Mk16OFhBalo5M1JNMENjVkRrWFh0dFI3Ky9HcmFIdnFqNnM3Y1BLSmtmMkc0?=
 =?utf-8?B?UmFoanBYVlN6c054dlFsaDY3WkloVWpuZ2xnVFczd2hGQ0p0QlNORVFOQ0RN?=
 =?utf-8?B?SUE0ajlrbnVYYWk5d1M0Qzh5RzhDRE1ZeXVPVXhmeVNCL0lXYzZkM2Z5UHFp?=
 =?utf-8?B?Z1A3L0dpRUxxM2xVeloxcUZpYzk0TGxQeFZaa1dZOXBnbDFBY0ZTTTFXYkVl?=
 =?utf-8?B?T3gwc1J5NUt6WkFrNmxDTFE4VmV6ZnRvbnEyazdLYk5OZ1l2OXhjZCtUR3hP?=
 =?utf-8?B?UWppUkNORGdBVjNOVFV0VnVGVUkxV1oyNGtpV2ZCTlJWUnJoYUp6SjNNNVBZ?=
 =?utf-8?B?MnQwTGo1M0FpMXNnL3FDQ2M0ZUtBOXZqYXVMY2NGckFBNlNBZTZRYzROQS9E?=
 =?utf-8?B?RVdkbUdwazZUbDN4YkNaU0x1dXlmcjY2ZFFCdFNjTWluZmNWeDNxL1dnc0hT?=
 =?utf-8?Q?BPrpbfyOaSAnMQzthcuBkjxe8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f1344e-e355-4fa0-cc1f-08dcf78a2502
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:53:22.6562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+c7r5jT2n7MKsNyHuvECUcYBILuoZePWyXhRavtnUWQmSqOjJI5OMnPOomBiL9vopNu8AD6qOejNEAbXit0cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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


On 2024-10-28 15:27, Alex Deucher wrote:
> On Thu, Oct 24, 2024 at 10:48 PM <boyuan.zhang@amd.com> wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> Add a new function to count the number of instance of the same IP block
>> in the current ip_block list, then use the returned count value to set
>> the newly defined instance variable in ip_block, to track the instance
>> number of each ip_block.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++++++++++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index fba10ad44be9..2e2c6a556cc8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -390,6 +390,7 @@ struct amdgpu_ip_block {
>>          struct amdgpu_ip_block_status status;
>>          const struct amdgpu_ip_block_version *version;
>>          struct amdgpu_device *adev;
>> +       unsigned int instance;
> Thinking towards future work, we should add a `bool harvested;` member
> to the structure so that we can skip harvested instances in the common
> code going forward.
>
> Alex


OK, so do you suggest to add it in this patch set, or a separated patch 
set when we implement it later on?

Boyuan


>
>>   };
>>
>>   int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 7c06e3a9146c..065463b5d6a9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2322,6 +2322,28 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
>>          return 1;
>>   }
>>
>> +/**
>> + * amdgpu_device_ip_get_num_instances - get number of instances of an IP block
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
>> + *
>> + * Returns the count of the hardware IP blocks structure for that type.
>> + */
>> +static unsigned int
>> +amdgpu_device_ip_get_num_instances(struct amdgpu_device *adev,
>> +                                   enum amd_ip_block_type type)
>> +{
>> +       unsigned int i, count = 0;
>> +
>> +       for (i = 0; i < adev->num_ip_blocks; i++) {
>> +               if (adev->ip_blocks[i].version->type == type)
>> +                       count++;
>> +       }
>> +
>> +       return count;
>> +}
>> +
>>   /**
>>    * amdgpu_device_ip_block_add
>>    *
>> @@ -2354,7 +2376,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>>                    ip_block_version->funcs->name);
>>
>>          adev->ip_blocks[adev->num_ip_blocks].adev = adev;
>> -
>> +       adev->ip_blocks[adev->num_ip_blocks].instance =
>> +               amdgpu_device_ip_get_num_instances(adev, ip_block_version->type);
>>          adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
>>
>>          return 0;
>> --
>> 2.34.1
>>
