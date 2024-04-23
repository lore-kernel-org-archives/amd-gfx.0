Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A50C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 02:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 332A6112FB8;
	Tue, 23 Apr 2024 02:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35P7i6dt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47ABA112FB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 02:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbbmiOnADE0FiNPQUY1KHDcUdaOhObM0DqFi3bYPu2AnH6czn2fnGcY9UtYfWMWeTzx2jEeCqlJXxbzRowYYy+aRrukrUOJnuWc0ZFSwne1PHaLkWwqwGjtLhnaA6Y4OBbsCpP2uExMIUp2bZLuhalMCamQVinlfI9AvMCsYMHQfcDOT1vl5WI76+M3gbja5ZaxvDQ6DT3LCt0T7dkQW2431K9KVwkwPxfax9FrfogOxES1E1s3NiMR3rTaIXPZnazxlY3SICCZYfMhGeTrISr+ZotUdBHHwvw7JqNfYVp09iZC7E+Xwwt5t9Qz1L+q5jLpALVmPdIqejyeCn/ZA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtHKMPNaoAhxIAYiJz71VGSdGXaOmflsORInNL2TxzY=;
 b=Ada0QIS3j87J3XDg1IACGx6oKs8KVh++HmqrSVqDfYDrN+YC3dhUtJwZjSWxGDO5bMiP/nAwT74jxEJ2sxXuxv977tgBX4uAnyjOWG2pF8Su5lr6QgoPEYycYAEY+gN+v7k31FPi3oBhqLRf8SB2l+f944lycdInV0bLVbeZ2wZ6xYKRP56LTtTJ3r6Xz9UTatbbIwCQXA2r7Qo+GOm7SepvAoHAREZK70nrL8EVfpeBsQlH9y0HNDlnxqHwgcy9oDlbMvubUu4nntuEJugGd1/KguqzXRF6K7n3Qhfg9zYE7Ho7zugVHcQCklMSB4SBO2XTTINg7/Wr8hrDh8xYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtHKMPNaoAhxIAYiJz71VGSdGXaOmflsORInNL2TxzY=;
 b=35P7i6dt/kXf3MGYImrzD+TemcksMvJT0N/GH3L6DPChR/aMgSPr0sbH1wzBtui6zc6JKqfzI5uklmJfnayQAy5netGnxsuS6OZzShSvXNxryVNcsDJmFhwv7F1lBNXFZhXDgVCQpJqCYu+Rm8cCQvWDXYRN4Eu7MlTnuNtx9AU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 02:54:01 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7472.037; Tue, 23 Apr 2024
 02:54:01 +0000
Message-ID: <1cae725a-412d-4b28-b5a1-705e55157983@amd.com>
Date: Tue, 23 Apr 2024 10:53:53 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix Uninitialized scalar variable warning
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240422094908.537208-1-Jun.Ma2@amd.com>
 <20240422094908.537208-3-Jun.Ma2@amd.com>
 <3303e24e-d423-47f7-aa01-62fb7a1bed87@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <3303e24e-d423-47f7-aa01-62fb7a1bed87@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cb39bd-a44f-44ad-5ede-08dc6340a108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFNvK29DbGxaOFpjcmhZUkowb1hCNDcyY3lGdi8xZERTREYwNGFjM2dpTGVw?=
 =?utf-8?B?R3dmekkxK1hwa2hkSWFWbU9KU3JUVzVRc3kyLzJCSnRUaU5LbktwQTNsS004?=
 =?utf-8?B?QWxHM3BqTlExNVpGV25oRkJhWENPVWhibkdXTHNWM1BKUHVXSW5lRFpudXlF?=
 =?utf-8?B?aHkwQUtQa2s2VVF6QjYyTEZHWldVWWhESFNlK0NPNEJqdjlRUGZHUlJjQ3RH?=
 =?utf-8?B?NU1Zb2xlU0NaNENNMi9OSldMTUNWMDdsc3V1T1BmcHNCOWZBWkhCMVdKVksv?=
 =?utf-8?B?VlhXeFdBRTFVMVRJZ09IU1Vpd2t2TUFkVkpmMXdBM0NjL21TM3dGVlVKS0hW?=
 =?utf-8?B?Y2t6dnQ1VW1xTnptelRQeGQxZm9uNmVVTC9Yek4yNzVyOC9NVE1MTWJobXBW?=
 =?utf-8?B?TGpXTjErVGh1Zk5YeUR4RmcrdFdUS1Fva1ZuU0VqeFNlMno2ODh5ZVVLL21X?=
 =?utf-8?B?QjIxMGpTK3Z5NjE5bFJua2VxVzBjcGxObnNudk5pYUxGSkVJdCtkTTVjdTlj?=
 =?utf-8?B?N0Z2ZkN5M281eU9WbDgvQkhrdzVnZmk2aDBxMXFkRXczVnkrM3RGVzBQM1dX?=
 =?utf-8?B?b3V3YkVTN1RYeEJUb1AwUTY5cTlrQlV2Ump6dG5PREZpR2VtQTN2ZWxySVJL?=
 =?utf-8?B?TnVVenorZk9wYlFrdFV6ajN2ek9ZYTQ1amg5blVDVHdlTHk2VDMwQUlnTzlL?=
 =?utf-8?B?T0U2VytZbGxtYUhSWVFDaVZ1Y0FFU2tmZm0zUUN6Yk9HVlJLN1pobTJPcEdQ?=
 =?utf-8?B?UklGMHJ2ZWk1aEZrNXE3K1lPZXlNRisvbnYwbUlvUkYxZFEvY3NER1BybGJt?=
 =?utf-8?B?Q3hMckR3RFo5YzQ4MkQ4UHVJa283V2F2RkhQVHovQm54cHNtSk5HOGJWellZ?=
 =?utf-8?B?dnNIMUJiYTVKSldpMXpZbjZFZ2xXZWVGa0RIejNTN2VQUW1YbDZNRFVzcTRZ?=
 =?utf-8?B?QlJlTDlyVnl2bGVrRm9ZcW9VRU4rUkdXL3dVZFRXSUpmTWJzQkhmaVFhZ2kz?=
 =?utf-8?B?MTE1cFh0a2Y3SU42ODdSbzIzY0I5VHNEc3E0Yzl3NmpPT1hEeFNVUlBRbjlx?=
 =?utf-8?B?K004WFphSmZpSGdvUHZQRW5FNVFTREtGNkZYbzRzUE5GSER2dkxYVGFWVnZj?=
 =?utf-8?B?MXBUazMwZVVBdzVOSWhsR2RYUmkxRWZQUTkrNVBBdHIxRDh4cGszNmMvSS92?=
 =?utf-8?B?cUo4VHBIMC9DOXJGelMxUGxhQkV1bDM2U0FSUTFuQ1kzcWYzenRSdmpMbDAv?=
 =?utf-8?B?MnpuRkdPSTB4T244VnhZV1R3bkxxSnc1VE5wSWg0ZCsvMkpYRUkwWUxtMy9B?=
 =?utf-8?B?N3VLTG1sSXdyQWM3STB1Zk1yemNsM084UjRNaGwzVEFadTZWaWRnNE5tRzhr?=
 =?utf-8?B?M0ZRblNWQ0VMK1Z1cEhaV1hEWEpQd1dlOUs4TGNGbk4xR3VGcmZqZjh3YUV1?=
 =?utf-8?B?VzJycVVxYS94U3hZSE1hNTBZbVA5VCtjTHd6QngzN3N6UWp5NDBEajljbnhk?=
 =?utf-8?B?NHdrSjNQNm5KNXRHaXJabUZKRW1oc0szZmNDK2NDejVzMjJLWUJURW9KcWNn?=
 =?utf-8?B?T3pVUHNwNGJ3L0V2QVBrcitTckp2ajUvbzNBZlQyWFEzTjhWZ1QxQzVsN3pl?=
 =?utf-8?B?dFZzcWp6UmV0UCtxZFdHbTlpbXkxdzA4ZVkzVVVMdDQ2QTd2RFdqVDB2ak1H?=
 =?utf-8?B?d2NZdWJQQUU0c0lveDdEZ1VRTUkxa2xYKzd1T2J1ME1SSWdZK3pYRzBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWlOOCtKWVRwMjJIM3BmTUMxVTI0TTA3RHk3dDBiQ3U5ZUk4ODhLbXExUHd6?=
 =?utf-8?B?R2ZuL2puNTRtQnlKcmxiaCs4YlNFTEtDMWZ3UzZSTXYzMFhxRmJXWlo4d0VG?=
 =?utf-8?B?TGl4NGhzdk96MEFmcStpcXJBUjVwSDhBWDU1ajgybGJKdkZlSHNaK1BYa3Av?=
 =?utf-8?B?TE5RMjNNa1BUaHBpSmIraTYxeTJmN29ra2hYUlJKMnRIY1IvV0tGUW9jN1RY?=
 =?utf-8?B?b25Ed0VkNjlwT1lvR0UvQVVHUTZsS1FMa3hKQlYreHozc3hnVGJxUzJGOTBw?=
 =?utf-8?B?aUZ5NnJndDlvNm44L1lwOUZuQ0plYUpNVXdxa09ya2lWa28reUMxS1Z4bzI0?=
 =?utf-8?B?QTdHbDgzV1RiSWNOUDMzdkpGMXJRUTdQNXlzamlsS2pXcDVhbk5nMzZWT0lk?=
 =?utf-8?B?SW1yUUFLcmtEOUc3cHVJNXVabkRGQXRxd3BrS2R5aml6ZE5qL3BQdlROQnBW?=
 =?utf-8?B?UTFWd1pscEViZ1REQXZuaXZxR1FtN20yNnFTdkgrQlF2MHg1bEQrajQrY2dx?=
 =?utf-8?B?VUtydVFWem1OQjBuSU96KzlpbmNWci9zYWU4TWtCTFNNYmtnUFhYQkU5OU9k?=
 =?utf-8?B?Y1Vtcy9EQ3VLR3hoK28wQUY2MWxseVdrZmd1U002UkViWmdqM1gyL0U0SDh1?=
 =?utf-8?B?VE9rZ1NUL2hieTY2WXNqRlN0aGJCa0xpY2xRNmtYeittWERFcmJZNmMwUGhB?=
 =?utf-8?B?a0l3eUN6T3o5T043OW1iTFVmVk5pUy8rUEVjSEpiWVFqOFpiRGU0cFU1Vmt6?=
 =?utf-8?B?Y0FCM211eitONW5vWkxUaUgwYTcweVI1R1p3MTFOa3JmK0NsQXU0S3lNdkRE?=
 =?utf-8?B?Y09rQ0w2UUs4RDUrWUZyVUZYKzdxNkU4Z0c4NjI1TDdrMGZSbk42bk9obmoy?=
 =?utf-8?B?OHJySnNTYkdjYnRnNVBQbGRmMm1PQ2NSazBHbmtSWitSQk5rcDFLYzVjQ2dl?=
 =?utf-8?B?aEQrZXBvdVR6OG1lSE80dm1GaHRIVmk4ZEpkRnR4akFYdEcva1BIYmVJTXBY?=
 =?utf-8?B?TXlKb1JwMjVSVWsxcFZTYmVScXZicEtCUHYwTW9MQWd5aWYrSHZkUERmSjZj?=
 =?utf-8?B?b3B4dHAyRElpdUtNY0JLYkN3bE9sQ3F4V2hFK3hUaTl4cFEzdWd2UGVxVUF5?=
 =?utf-8?B?VDdEOGVzZzBaSmFZbnhSbGdyWTJaNUU1Q1ZzSVRtZlZIZWNud1NqemJBampk?=
 =?utf-8?B?d2tIL0dwMEt1alFIMnFKczRmVzNJakdDN0RhT3ZRUTh0bms3UW0vRjdQRXdT?=
 =?utf-8?B?RFhtcVQzMVBDcnVuWlBYWGNRc2E3NmkxLzhGY25SQlZHN2xJR1lOV082TkRw?=
 =?utf-8?B?KzVtY3FhUGlQZ2dpUFJrZzB0QUpSV0ZDd0dJSGhUT21lZVE4dExaak9MbHhx?=
 =?utf-8?B?ei9RT0pyRVNqbE5uU3FQc2NiUlkvN0NtWlJWcjVFUjNwS3BXcm5oYzdPNWhW?=
 =?utf-8?B?VDdKM1l2cGJtczVrc0pUOXg4WHlCVHcvc0ZHYXZ2b1oxSG5sTGdYTXF6UGlS?=
 =?utf-8?B?Rm1hSE1CbjQvbDZwcTYxZGZtQXp3ZkhzSnlTdUI1Mys0VGQ4bmM2M1M0MC9E?=
 =?utf-8?B?Yk5hR25QMkhKbGJEZnVsdE1DaW5RemhGR0laQ2hvZWorQ0tSQk1YZ3B0YThv?=
 =?utf-8?B?N0NDTnNFTWJyUGtwaEpiM3BZVWowRVZkL2ZYSnNuVFhTdGdhRXp5U3dOZ0dW?=
 =?utf-8?B?MWV5RFhmTHpQUWdWR25pK0ppZGdhYWhidWZVeU5Ka3VXcytJTXNlK0IxZnNI?=
 =?utf-8?B?dG5jWUVBN1hEQzdaVnZUaHVaWXZDUnJzQ0IvZ0lyUlRvbTFJNXNWdnYrcmp5?=
 =?utf-8?B?NXRVY1JKdlQvNXNKRWN2ZlRzZkdLbDJuSllhNGJRVkp4VXFjTmlKTkIrS0sv?=
 =?utf-8?B?YSsrVzF4bmx6bUJIdVNPK21kNjUrTnR5Nkt2ZlpZUUJRZ0cwcXRLYkpienBx?=
 =?utf-8?B?Wm5mV3R0WFJRdCs0OS9aMzJwV0h3T1JmQllEOVc0MloxMmp1KzkwM2k0anJP?=
 =?utf-8?B?c01aaUd5OVhVWHpiN1lEMHh3djVFb3FycC9sRkJ0RVhiM2tEazNjSCs5Vktk?=
 =?utf-8?B?OFQzYU5QWnZDUGtLZFkwVWltTVd6Sm5qNUF6QTR6dGxtaWRrS2MzYXUzZXpQ?=
 =?utf-8?Q?IxocG7Sw1Z6tTUZ5so/vfsadk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cb39bd-a44f-44ad-5ede-08dc6340a108
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:54:01.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDMBCbZdyjt3HvTDAZN0MbT6d4vt8/yOAYFGpnngKShz1dIMVSn5b/cQ+82CqcmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
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



On 4/22/2024 7:25 PM, Christian König wrote:
> Am 22.04.24 um 11:49 schrieb Ma Jun:
>> Initialize the variables which were not initialized
>> to fix the coverity issue "Uninitialized scalar variable"
> 
> Feel free to add my Acked-by to the first two patches, but this here 
> clearly doesn't looks like a good idea to me.
> 
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index 7e6d09730e6d..7b28b6b8982b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -437,7 +437,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>>   			 struct amdgpu_ih_ring *ih)
>>   {
>>   	u32 ring_index = ih->rptr >> 2;
>> -	struct amdgpu_iv_entry entry;
>> +	struct amdgpu_iv_entry entry = {0};
> 
> When this needs to be initialized there is clearly something wrong with 
> the code. I would guess similar for the other two.
>

Yes. Some decode_iv functions did't assign value to entry.timestamp.
I will check this.

> What exactly does coverity complains about?

Coverity warning:
Using uninitialized value entry.timestamp


> 
> Regards,
> Christian.
> 
>>   	unsigned int client_id, src_id;
>>   	struct amdgpu_irq_src *src;
>>   	bool handled = false;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 924baf58e322..f0a63d084b4d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1559,7 +1559,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>>   {
>>   	struct amdgpu_device *adev = m->private;
>>   	struct drm_amdgpu_info_firmware fw_info;
>> -	struct drm_amdgpu_query_fw query_fw;
>> +	struct drm_amdgpu_query_fw query_fw = {0};

Coverity warning:
uninit_use_in_call Using uninitialized value query_fw.index when calling amdgpu_firmware_info

Even though qeuery_fw.index was assigned a value before it's used, there is still an coverity warning.
We need to initialize query_fw when declare it.

>>   	struct atom_context *ctx = adev->mode_info.atom_context;
>>   	uint8_t smu_program, smu_major, smu_minor, smu_debug;
>>   	int ret, i;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index 2b99eed5ba19..41ac3319108b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -120,7 +120,7 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
>>   int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
>>   {
>>   	struct amdgpu_device *adev = xcp_mgr->adev;
>> -	struct amdgpu_xcp_ip ip;
>> +	struct amdgpu_xcp_ip ip = {0};
Coverity Warning:
Using uninitialized value ip. Field ip.valid is uninitialized when calling __amdgpu_xcp_add_block

The code is ok. We just need to initialize the variable ip.

Regards,
Ma Jun


>>   	uint8_t mem_id;
>>   	int i, j, ret;
>>   
> 
