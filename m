Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A884E7716D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 23:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FCC10ED89;
	Wed,  4 Dec 2024 23:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RTzUZHP2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B123D10ED88
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 23:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQKBIm/wJcp7YEUPFuPfSKi/Jj4wf1gzMOmg59WKnqL2r70YsLxKAsSQ+mAN7920k3CIAQxBoNsGhyyIOnI38bWxTkmMqA5nKQRiOFtDMbT4aA3XcJVxy6Ri/fDuMNkCg8l8SCgS6n5plDcnDc4DZd4zEtOCyyu2e+vKP22cdnA0seciPBT3ZzXE+ZPPByVlOrA6y00CA2WeNg2DBoDz0qflyAs4XaZpXVZZdtJ52g4Lq6/k1Sn/6u6YArQQCSofbyzerBOnc1mt3xQoZCHcTOG34W/eM4+S72kOV1Xb1fOznHtprbWcMlkyvh/QKKiyeyVAxTomgCcGnGA45oFuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMNaUzbHbuWgXqtIycSz+3/ONDi3oUaGz0wyKLH+Vt8=;
 b=rsXzGUW3sQYnXRzCuecWCViEOfe010EuPuNW2oy3ve/T5aNdzxVJWz7eKepDJDi5gWGvjkGKUMSrD1JPJQK4/WHNnO9Tns8fkvhZCnG7EATYfXUYVmS3NbtAaoASxFAKuqTEgOfiNp+9NsXvN7BonsU9VjOXTiaC8zoi/RIWytmcZHTjwL9GcL1rf0r2WhhAm1Sx3SvZxAW1CVkonOHpNzpxsgVGnI/xohEGgmujPGYtPR4pzVMGMCl9eyawbYDgI287YRFpX0pY3/zRxeBWIkMt806CDWrmvU/BQewCko30uVobEvrdyOBWfZY+kdt1uxEUS9z3At4O6gvyFeA5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMNaUzbHbuWgXqtIycSz+3/ONDi3oUaGz0wyKLH+Vt8=;
 b=RTzUZHP2YTOAYdjWpvBOY5sUoOHa5WM4R4PmeWcH6Zj/WOqGOyBTnHpbPNvEH5aRXBy1cxZAIouYV+3g92FurtnB4VOvNM4yrDQvlcoHivj87wcnyZW9dLLekAeEymZOFShRVAfLfA5z8jUQF/ceOVsl5W3g3LDB9vC8VbXxXUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 23:44:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 23:44:02 +0000
Message-ID: <40948600-60c2-43bb-9030-63b49ca6be51@amd.com>
Date: Wed, 4 Dec 2024 18:44:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: pause autosuspend when creating pdd
From: Felix Kuehling <felix.kuehling@amd.com>
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, mukul.joshi@amd.com
Cc: Alexander.Deucher@amd.com
References: <20241203143046.3643-1-Yunxiang.Li@amd.com>
 <20241203143046.3643-2-Yunxiang.Li@amd.com>
 <b02ef955-f510-4067-a577-276b3882cd39@amd.com>
Content-Language: en-US
Organization: AMD Inc.
In-Reply-To: <b02ef955-f510-4067-a577-276b3882cd39@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0479.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8e2228-f2a1-4bd5-a304-08dd14bd8862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmtneVdHaHlCZnA3TXM0YURVczRZQURuTVFpbWt5WFNZbEMvNyszbzRKRk5t?=
 =?utf-8?B?L2NzMlhPVVI5WHZCN0NETUNUTnJaeDJDK0JkWEpYQ2U4OVBLM1dGd1Byb2lZ?=
 =?utf-8?B?S2owcDlQbmZ0NFZvcVFSbDYvaUgzbUcrV3RNbUlmcWJkcWN2ekI0MERPZVkw?=
 =?utf-8?B?SEZOZG5iSXBnb1JKVFhUQ2FEeUtZeFRCYzREaFc2Y2FrUnIyZW1rOE9uZFVY?=
 =?utf-8?B?eG1mWFF6WkJtSTdGTldld1FUNjBzYWtibG5LMnpESjgwN0VYMjFvTi9PckUx?=
 =?utf-8?B?NDhXdzRQTkxSTnpBUXN6VWRzS3ZNZVpNaUhWcEdQUE5saXRYZmpNSDNRWjBO?=
 =?utf-8?B?YUJlK2FHdzVSYnBEa0ZzRGpnUEF3UDJyT1JrUkVhelZyN1QyVjRCbUVHK25z?=
 =?utf-8?B?ZDE4UDRMb0NGRkVXdlRRbFhxMXJ5Vy9rdDB2b2lXT0srUnJtR2JsUXR6d1Y2?=
 =?utf-8?B?Tld5VjJ5L0lDR3BkTUFaNkFTU0ZVb1ZQazd2MVJJS1pPU0NHdk96RmM3a01E?=
 =?utf-8?B?RXRHRmhleGZBb0ZLZjJwV0ZTZE1oeUdNeUl2bVF2QkdkdW1MY004VENNRDli?=
 =?utf-8?B?YkJQeS9veXhRWC9NbjE3M1ZXdTFsaE5WaFpuS0paRUpGV1R3amdkSEg1M1ly?=
 =?utf-8?B?Z0M2RFNKT0J5RjE1SEYzRXNEMlRxQ3Z1TmMwTnpKL2tDWHVsSHFvVlRJV29m?=
 =?utf-8?B?UkhMT0lJT2xDK3cydyt0N3ZiM01IMzVFMEFVRzVJS2NJME9jRjNiODJzZFNo?=
 =?utf-8?B?VHFoWFFLS1lVSW81R3FHaExWc3pNMis0ZVIwaHcyOHo0WXpWaUNxUElxcjI4?=
 =?utf-8?B?YnhtUmR1aDZZRU5tV2VqU0VPNlhnS1ZZSW5NY3NCOU9HQm00c2puVi94bU1a?=
 =?utf-8?B?bXBBZGdYQUlTeFlkT002aUlxWlNpQk1pYWgyZUVxQTN2TlVhZW90eEN3VHYy?=
 =?utf-8?B?YlFKRi9OMU1zcytsT1EyQ0FZNEI0QUR4MCt3eE9HS2RqRStWcTYzN1J1WGhN?=
 =?utf-8?B?eldPNDBiUFNTa2NnZEVpN3lGNDQ1Uk5BbWtneDFqUG9QQjFlNW1RbzJhamhh?=
 =?utf-8?B?a2ZhVUo3bzhMYnY0aHpLUkQwQmZVa2JlbXBoSkJkL1o5RjVyNWRlR0FlN1RO?=
 =?utf-8?B?UHZCWGlmbDhiUTNTTmh4WWUwNlg1RitjVUJYUDBpMHRtejcrQ1ZEZ1FNVXN2?=
 =?utf-8?B?WGJxY2R4SjRqdll0RHAydktoaEdFekRVYmJ2ckN0bnNSMGV3Vklod3Q0SHYy?=
 =?utf-8?B?NWVwVGx4dE5SbVEyVi94TjhFR05UN0NnZG1CWDVIRE5GR21mcjVxZzdBaG9R?=
 =?utf-8?B?eDRzdllRRjNyRGpXZk44VHVZb1drcUdIdWFhWjF0bWEvSlBpR0ZHVU02Zncw?=
 =?utf-8?B?ZFA2KzVJNDhGaFpvRCtWTVR1OFV1c1hJbk9meFBZVnQ0K2xJSWVnaTJ1dzhz?=
 =?utf-8?B?bmtuUEE1Q3RnN21EODFsREkvYlJDOVJoclpYWkRiT05ObWQ3QjV3bXc0ZGpP?=
 =?utf-8?B?Vkprbzk4Tkd2V3E2WHRmQTRHSUJQWnVTbE41ZTVxbFRCM2lGdWhoeUhxa1BQ?=
 =?utf-8?B?VDVUdjg5L2JMNmZyL25paDMzdFVOZEY3enNaM3l0MWdQMGM1OU1CUVlLRzhL?=
 =?utf-8?B?MUlaenlaZUZsM1hGbDVnUkRrdDRuMTB4aU0rUWY5bXFRWlFxTkZvZkZTc294?=
 =?utf-8?B?WHR2NTVRRFFFSStEWlFNeUYvSWpvc3hUenNzZ0NoelR6SmtpUFJZd3Z2YkxM?=
 =?utf-8?B?U1dEM1RNT3BEQWlnWnJVK0lJVkpFRVNSN3J6QkRIRjZSSUdEZnFRYnpwYnhZ?=
 =?utf-8?Q?YpA1pHPeCURVbR8sdUYUWDoRFUZreUluMmvXk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9UUWdkc1FkWCtJUE9VM295QWlmRkdTVFlxK0owSEI0RHRlZzlFa2Ridllz?=
 =?utf-8?B?VUErU0RNQ24vNUhRQlJJazNUY3VTZmZDY3pFYVpXQy9BN2lib3JwcHFjd1J5?=
 =?utf-8?B?N1IvbGJZRTRsSWJkelEya2xQKy82Y2ozRzkrRysreXNOcDBjSmRJL1Y4TStQ?=
 =?utf-8?B?a1RUaFZGbllNQ0hEVGkyVVNmOGpGc3Q2eU1Qa2dqcmNQcnd0dHoxeG4rOEVG?=
 =?utf-8?B?amV1TjJYazVtWWpxWnB4RklBVVpueXJFWHdheXNRWUx4bml3Ri9reUt4V0lx?=
 =?utf-8?B?dThoQXRSS1ZuQXBIL21iMXp0djF6WitxMVFVdXlRWXluRlBYalRpbmg5cGsx?=
 =?utf-8?B?dVI2UGQvVVpsREZoR2Vhd1VpbmdZNzlmMmh5Tmw5ZDN2OFk1Z0lyVzdmS0Qr?=
 =?utf-8?B?Wm82RXZpY3NnbXFubmU0dXFIY2JEam9KUkRzT09WYWpPVXlQSXQ0MjNhM1Vz?=
 =?utf-8?B?TkordW9lZW5VaVAwSDNjMnVzd09ITGNJTzRZVkY0aENncThiQklwWEpST3Vy?=
 =?utf-8?B?RXp5bkFaUllyZnFwbmVWN3lUZi9zdEs2WGk3L0dXbGc3UWZyakIrdFJVRGtm?=
 =?utf-8?B?aHpaN0UzNkFTbk9CanJSTDdhR0N0T3I4ejR0UmpEbk82ZUNXUXRzV1ZUNHdl?=
 =?utf-8?B?V2c5a0VxVFdiK1hPWitYTzZ6Umt0RE5LS3dOZWsvdXY5dlVOOXVja1JpVU1L?=
 =?utf-8?B?OEgzZmR4b1pkNkRTcXlhdEFBTzhEU21UOUVPL2Ura2NqY3YxQm5kVVgzb3M4?=
 =?utf-8?B?eS9RUzNQYnFpVVJEZ0ZWMWlzS2hxYk1tYXhZaUw3NVNUbmNTc3krWmwydlBR?=
 =?utf-8?B?c0RuNnJjRmZXU0tuVXM5WFNyTE52R3huUzRFZUQzRW0wbVV6dDZ6WXE0SkN4?=
 =?utf-8?B?RFFkOU4rWVpCQjVMQy9xdjVFd2F6Yjh5MjFqVVJCVHVVZVQzNGhDS3F2dFRZ?=
 =?utf-8?B?ZjZRTnl6VGo1K2tjc3o1Q0NuUVM4QjYwSXowVlh3R2NtY21VQ1JJZFlQNUlr?=
 =?utf-8?B?eUV1c2xQSVN3Q3ZMNm5pMjVwYnhETEZyZ3VPS1ZHWjNCV0dVNmd4bytZOUpq?=
 =?utf-8?B?dHpLcG1tejNmT29aRmNYdTFhVUVqUUZFbUFCUVc4UkZtcEFXSjhob1JSSVRr?=
 =?utf-8?B?RkNKaWh4TzRlaVNINW1BdkZZSjVDV3ZoMStybEQybnRvRkdkc1BhMTNvY3c0?=
 =?utf-8?B?NlJqd09TbHFIYjBIdUorYVN0NDRVdFVOUVIyanlPQU8yMWtPTjgzQXpoZ2lw?=
 =?utf-8?B?dldab3NNUVZ1T1ZtMEtGVitrZUdvT2FwSzlkY0FqeGtNUG9YcFdvdkR4NzhM?=
 =?utf-8?B?b2U5a05nbW1mdjZlb3o0bE85ekRmYitVNkpmRXlya2ZIbmVCUksweGpJYVJ1?=
 =?utf-8?B?Qmk3aUk5YzdyUzNaNkVCaUg2S1RndFZaa0hkNHBZcjdXYkNXWVhmRm5JMUUy?=
 =?utf-8?B?THJaLzZFTWVCMndXUUQxRHh1TXBHNCtIeW81b2cwcEpHTERxNEpoL1JCNk5R?=
 =?utf-8?B?dnVjUmVoTXNLSnRCbjVzWkR0N1J5WUlmT2s0ekFvNkNZZGt2YThwTndZMnYy?=
 =?utf-8?B?cWNxcnVxYncwUVNpMUlaMlA4Q0t1QjFOTm5TNTZJc3hnZ2FlaDkraUF0SnpU?=
 =?utf-8?B?RUEvTzg5QVNVYzNQdWp1MFlKK1IrdklmK1VPaUtLanZxS215UUJmaXMyb1F4?=
 =?utf-8?B?V3BtaDgrdXFUQjNML2RsdG5qbDFKZytZSk0za1B2dFAyOUo2NTJZaXB2UVps?=
 =?utf-8?B?NVdxU1JNK2h4bWV1NHk3ZldwSVNCdVpPKzh1ODBrUHVjWTRGdEZEbjM0THVa?=
 =?utf-8?B?NlBZdmZ6aURuMDdjd2UyTUFmRFFadjMwclV5L1hpaGtRRzE4UWZpR1hjMS84?=
 =?utf-8?B?WS81QmF0TWloOVV0aXlkbEUzaUlDcGJIaG43MmtjaXFManVTWWJ6WlJUM1Fk?=
 =?utf-8?B?bW9YTXNsdmpScWYrZWxYdTlCL0JEeDlHSDdvTS9FcUFKeDFOaE1qM1oxV2du?=
 =?utf-8?B?NHNMSGNmSEtDc0lVRTlsWk1RZkZJNXJyOEhKdzhHbmlFeE5Qamo2TUlsSDhm?=
 =?utf-8?B?cHBJOG96TTUwSVoxdXNVMlRKaXZpYmpKdHZOYTZLdUY1UkpzUTM1bFBoMkRw?=
 =?utf-8?Q?00YsVCv6H+kSp6KI9fKTbrGVT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8e2228-f2a1-4bd5-a304-08dd14bd8862
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:44:02.7272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TyUuGHTpaGtdPA87EmvzbIE1BHve9kNY9olZOiWB78QT430sqWWoPPNXETbu/0NtyCt7xhSXPng8uJAoh3eeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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


On 2024-12-04 18:36, Felix Kuehling wrote:
>
> On 2024-12-03 09:30, Yunxiang Li wrote:
>> When using MES creating a pdd will require talking to the GPU to setup
>> the relevant context. The code here forgot to wake up the GPU in case it
>> was in suspend, this causes KVM to EFAULT for passthrough GPU for
>> example. This issue can be masked if the GPU was woken up by other
>> things (e.g. opening the KMS node) first and have not yet gone to sleep.
>>
>> Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>> ---
>> v3: remove the cleanup in kfd_bind_process_to_device and document why
>> this issue doesn't always happen
>>
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 555a892fcf963..c81c020af75d1 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1635,12 +1635,19 @@ struct kfd_process_device 
>> *kfd_create_process_device_data(struct kfd_node *dev,
>>       atomic64_set(&pdd->evict_duration_counter, 0);
>>         if (dev->kfd->shared_resources.enable_mes) {
>> +        retval = pm_runtime_resume_and_get(bdev);
>> +        if (retval < 0) {
>> +            pr_err("failed to stop autosuspend\n");
>> +            goto err_free_pdd;
>> +        }
>>           retval = amdgpu_amdkfd_alloc_gtt_mem(adev,
>>                           AMDGPU_MES_PROC_CTX_SIZE,
>>                           &pdd->proc_ctx_bo,
>>                           &pdd->proc_ctx_gpu_addr,
>>                           &pdd->proc_ctx_cpu_ptr,
>>                           false);
>
> As far as I can see from grepping the code, this BO is never used. It 
> is allocated here and freed in kfd_process_destroy_pdds, and that's it.
>
> I see a different proc_ctx_bo allocation in amdgpu_mes_create_process 
> but I don't see that function being called anywhere. Either my grep-Fu 
> is getting rusty, or there is some dead code and data structures 
> surrounding MES here.
>
> So unless I'm missing something, we can just remove this proc_ctx_bo 
> completely.

OK, I was missing that proc_ctx_gpu_addr is used in add_queue_mes.

One other suggestion would be to do the allocation of proc_ctx_bo in a 
lazy fashion when the first queue is created in a process. Then it would 
naturally happen after the GPU has been taken out of runtime-PM in 
kfd_bind_process_to_device. This would avoid unnecessarily waking up all 
GPUs in the system every time a KFD process is started.

Regards,
   Felix


>
> Regards,
>   Felix
>
>
>
>> +        pm_runtime_mark_last_busy(bdev);
>> +        pm_runtime_put_autosuspend(bdev);
>>           if (retval) {
>>               dev_err(bdev,
>>                   "failed to allocate process context bo\n");
