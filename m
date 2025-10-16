Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6791CCD195
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 14:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDF910E2ED;
	Thu, 16 Oct 2025 14:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o4RvNsGh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC9410E2ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 14:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7ApyUW1vigi3Z9s+0StAQ8oyjQZgopdlol3byRd6OPnWeDAb8PSuyAxD17GNkfZTngNtlp7zcYvRgu/860xmeroVzTSuNXd92LR4nVw+X5/2jxBZAEUukKqbqQ9kUuats7TjsC/2CglR0xegwOtOJNryiHCd8b2i69O2TLIxH68kHKtC5ZYRj78+14xZogc/+5ambO6OmAzDKK2enG9CYNPCamleT2mQkM+O8MN1nYfhjSGbBu/QkxE3ZPP6TsbT3ti3ULbFkWZRB0wMlTHCbRcBfY/q7DMhOv/EHWPxipzz6iU8T0lisHMFSsJp0s4SSItP+mCEEsMfcm8j8Vj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv4H3QgIm8hLXwnHz1Q8fkrJW0xjtuaiYO3VM6V7DXI=;
 b=iKvnHu5sQiwdCLDhvZnDfjfT3WfTuZHLinyiwHd0jCdCvFzmYy8aI2EhTWSVdRwOg9s7QqXHvAYkKcRdn7x3v09zBcFDBwGkwwajTNN630aoJNhZHwoMoEPasVwDkU60QZGYt3+ClF0w45obuoPPdUuCt8SNVS3PnFAPD9ddaPDYs1Yvh1mw+i9xRf4cSfzHboWA3byZ5eL0zmluzabuZjBAzqwP8/4b/dGHqvW0hIR+OIiaz5QUu9WgGBPCT63qZ6RoPRBgqrmuivg3Ak9llGuyuReSZqV3WKpQPc8x1podu0/rqaTZFM2qmhxklrByuHQRNVrZKUBvU53OnoWyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv4H3QgIm8hLXwnHz1Q8fkrJW0xjtuaiYO3VM6V7DXI=;
 b=o4RvNsGhZxGmPBch7hwK9yw7HuIZz+ciURxVJur219jBffv6HkOoLZVon0JuCJMmi+vXPvAIrDbpChYXLA6smTEOxEZCCAA+4u/R58pPhX9Jq0FfTynGOfgCNps2KzEP9R0qB/XaHYbZLyGxAqcZLc03KGolAQtV28vi0maVG5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 14:46:53 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 14:46:53 +0000
Message-ID: <3bf66993-7a24-4657-a264-cc44df5fb560@amd.com>
Date: Thu, 16 Oct 2025 09:46:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Stop user queues when process mm
 released
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <20251015201134.2540-2-Philip.Yang@amd.com>
 <29dd1aad-26de-49ac-9d25-c3dffa862705@amd.com>
 <c0daed21-77b2-664b-ed63-ae188fff2f06@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <c0daed21-77b2-664b-ed63-ae188fff2f06@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0114.namprd11.prod.outlook.com
 (2603:10b6:806:d1::29) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 992b5f56-0268-411a-a0b1-08de0cc2d88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3llQkovL0dCWUdDSWVRSWhaUVlqZTRPaE1QdENWdllIYzhWZkZ5Z0ZEZ3RG?=
 =?utf-8?B?ZmJ5UkE3Ujd2d1dOU3QzQ2l0L0lIMnYwNm55RXA4cm5vcDMybWlnZUpFZ1dk?=
 =?utf-8?B?VDZmUURoTnVKYS9tRk9iQ0NSQUt6cmp6T3k4amR0ZXdValU2N2pSU0t5aDJ6?=
 =?utf-8?B?MThkcFZ4WjArb2lBVmhzVTAvYWFOaXNZQ3dCNVJXdmNUZXJEV1YrRDlMNmFv?=
 =?utf-8?B?aHNCbmFBUG83VGJQSCt5akZmZ0U0VU1ETVNydXlmbWVTT2QreGc0bEd1RGl3?=
 =?utf-8?B?WTBHM2lpeC9xZUx1ajBMRDNMQTJqeWtCd2d3Ky91RE14clJFVkRVU3F1YXZx?=
 =?utf-8?B?WlNqSTJXbVFTRDBpNyswYTRFZkhQVGRBOEV3WFd2SWN5Q1BDT0JKOFFNSVdN?=
 =?utf-8?B?ODRWYmpwTDU0aVVKYUpXZng3UDI0MllQRStlUTFsanU0TTVBWkFlY2thSTFG?=
 =?utf-8?B?NUFrY3ppWFhLUVpxSy9CTjdqcjcxNHA5K0hFc01PdWJONTQ1TDFNUWNwRzlV?=
 =?utf-8?B?di9NL25MQVBscTJWazAyTVRpRjdyd1RZRTl0YmdNUUk5VlFsMkFORzN1TVVK?=
 =?utf-8?B?UjQ3K2FNSFo5djJRZThMWXRFR3ZCSTRKaVUvSEQyKzJuUkhIN0hmWnhKOFUx?=
 =?utf-8?B?cEVBdGFYVVM4azRzZGxxL25ZeXI0Q1pDY3FGTnFFV3VvVVYrY2tWS2RlY21h?=
 =?utf-8?B?OFlKUmxuSUJDVGR4dEEzZi9oOU4xN25PRE1UaDRZcUl5QjR1QVphZlZxRkEz?=
 =?utf-8?B?anVzeUpPVy8raUVvb3BKbU1pRmVyNlcxREhQTitNMVhIdnZkZnNJaWpBZFJ6?=
 =?utf-8?B?SXhMVElqU2ZTcFNzNXBIbXU4bENrTEYrbUNyNkhDWGxJaDRYYTdnWTlnQzVV?=
 =?utf-8?B?dWo4WlVxS1hTRFZwKys3SW9QTkV1dThpWkI0YVVkcjcrbnh1VFlqRW5ycml1?=
 =?utf-8?B?MWYyZU5BNXlBKzFsZktFWlF6ZVo5SHE0ajNEVlVWZ0VPN2JySTRnV0pnUGZr?=
 =?utf-8?B?cHhQakp1cHRjUUp1eERNNHJ3SUtEc3VTZGVCSis3K3RRRVlodnRWbzk1WjZH?=
 =?utf-8?B?TDhHZjlNd0x1dlErVC9hbVJ3cDVaTHZ5ZVRiRGk0VG9RREJJRS9aS3lVT1dw?=
 =?utf-8?B?akt6MWNtVlR0RFIzbmxZRklod0t3ODc2MjNJNzNVZ1BBRnRVdCtMcnozSnly?=
 =?utf-8?B?L3kzSzNETmFrZUxBUXZ6T08vbzV1RDF4cVkveU8vKytUZ2JLR0o0aEJoTVFy?=
 =?utf-8?B?NnUvdFFVN2Jrcmd5ZWsvdDhyVUNUM3g4bVorOTRJUitNaUQxVHl0WCtNYS9l?=
 =?utf-8?B?eFgvbXJmbVlGdFlsemlERWs0K3BpVloxWHR2UEZsK1Zwa1FoODhQam4vQ285?=
 =?utf-8?B?QWpsa0dqdERKQWlhS0RwNEVrLytUeWplRW03NkdpWW15V0Y0TEpvOUU4Y1Az?=
 =?utf-8?B?UlpTL3Joak5LYmFWd3NhSVJ3RUxVeGxpMlIzQllHWTZTUWxJY3I0ZkxPOThL?=
 =?utf-8?B?VnRZU3VVSkNva2VWM1BoSDdvSTdZR291aGpqODFqaHM1Tm5pYnlYbXhrbU8y?=
 =?utf-8?B?alFpOTVSWjBtbVZJaGorREFxZWRRZFNPdTNIWk1GbjB1MWZHMksrRStqUloz?=
 =?utf-8?B?U2cweUxDS1R5WFJEWG5NZEFXUFIwOTRPMUExRm9iWEp1b3huQWZKNlZXSWp1?=
 =?utf-8?B?SHAvb3FPQlR2RWZDU0s3N0I3WE5TNU41RkZTSThvYmNjTTFuaVpmQ0ZWejFW?=
 =?utf-8?B?d3gwZkZmN0c0K1M2RmZYdm9LaHJyY3ovK2RyS3NObG83bmhmUm94NlhKR2xq?=
 =?utf-8?B?bHRLZ09Gc1ZkeXFLUGYya3lqemdQYTlSTEo4RXRYSEdKbjhtRjJOQVhwUStK?=
 =?utf-8?B?RmFyWlVmbk1zR3pQZVcyYVJWK0VTK2JRMlNUUzhGMlhaS1VOSGJNWUFLbjRu?=
 =?utf-8?Q?ldnC2TAwAxolF317zBdSZfCg/mnXfJDR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhJNkg2QUFWbFVVMWh3dGd3ZWdSNVR3d2dEME9MUlNKckY5SGJwV2YxTGtP?=
 =?utf-8?B?aW5aVWx2WjF5WXllTGkyMCtHRFFaaUU4bDJ6aU13YnM1R1NONUd6Q2pRdHZO?=
 =?utf-8?B?MU9Qa2h5OWdPNWJKZ2pxNDZYRk5oNk5KTHZxbjhNWlpCbmRjODBtbnBtS2VR?=
 =?utf-8?B?OTBablRSTUlCSWdGbDRSRG0yem83TjBwbjAycGhCWUtIK1FVTDl1MW82OWdl?=
 =?utf-8?B?dGtPblZqc25BWXJBcUNLZkkrbHJYckxwWGtRUldJN0xZdTVuOFc1TS8waWJz?=
 =?utf-8?B?NzEvaU9mSFVGbS95NkZUNkM2eFgwUlpHMnk1T0NuNEd1VWJta3NNOXNnMi9z?=
 =?utf-8?B?SzBrZDFURkhIdkFyV2c2WElqZWx3dWhMZGMyMG9YUDIwVEM1KzZiQUVCOHBK?=
 =?utf-8?B?OHY5bW9hZjhyZ1R5N3pRRTNOZk5KN1d4VGhpL1Z3bTB1WTd3QlhLYk5QUzJT?=
 =?utf-8?B?ci84TStrSzIwcDlvb1NWdlBBb3d5bEFTWGF4eHR1NHZnMzdwSTdPckhyN0VE?=
 =?utf-8?B?blRIV25mM1BpdmozNExNemhadit0SnE5T1EwWk94SmhCbFp0b0RnejFCR0d3?=
 =?utf-8?B?RVhXbkhRWUxSWENLNk5haHJvV1NXTzBRL3JwUGUwdU02SDRSd1NtSzRrMW9u?=
 =?utf-8?B?d2JJeUtaN280SUpjV093MlQ3aC9ZeGlsRnI4TTg2bGtoYXdJdkFRZGZYdkRD?=
 =?utf-8?B?dmM1L3BhN0xWajduaEl6VjRUU2txczBldmRUTEJCbkFEMkFpczV0eXkrc283?=
 =?utf-8?B?QjRPZ0lFVktKZWdlTXovdFhpbkVPQmhiczNscWtLWHVuMDFTdG5FWjAvY0t3?=
 =?utf-8?B?ZkZFV3NEbCswU3daNEhObW1jNmltS1IzdFIrRE9QUFNMZmVFN0w4MEpLU1NF?=
 =?utf-8?B?dWcyQkxqck8vQjNHNnJVSksxRVEyKzBoNHhVNTRoL3g5cE9DUFdMMmpmc3dF?=
 =?utf-8?B?c3d0U3NGOW05MUtYUFo1aGRIVURVM0VsSWZ6dzlWQkx0RHA1ZFVGZ1VtYi9Q?=
 =?utf-8?B?Z2pwNVUrUTVNQVpYMTRDYllKQ3JnOFp5WURTZE9iaW54cGswMDBncmFaMEl3?=
 =?utf-8?B?elZwVEZ0YjZTOHJMcGpzLzREcENGYXJVRk4xd01SVUUzV3R1aHBYNzA2UlQy?=
 =?utf-8?B?eVUva2pDYnM1VjJoZGxIZWlNbkhyTlFOREdlM2ltMStJRmFWaXdCM3kwaWNM?=
 =?utf-8?B?cmVMREUwY2ZZS3NpQXgyWklkdW9ucmpVd1RNTytLVW9iK0taa0JyOHFHWENV?=
 =?utf-8?B?bVRhMmRoRHh0cEdhZzA1RHVRakg0TFIvRzdabFBzRU9MZEVXcWJJRmlJRmhY?=
 =?utf-8?B?VW85TldQMDhWRUlodUFNV05mczFNaVdKa0hHUXlmd2ttUThCMTZTSCtCd3E2?=
 =?utf-8?B?MUovREZDc2xOaXNNNHp6akpDZERjNVFWMGRMd3dvbEp1TTlTQ1kzQ0ZIWEhW?=
 =?utf-8?B?cmtqT3hNNFJRSzNGQ08wbUNmdGxWMkZsUnhvaUttSGdtWXVNY3B3eWpOakpL?=
 =?utf-8?B?QVVWRmRxbzMrTkc5ZlA3MklqNm53WUJZZzl5dkJjczcwNGZGTmlnOTgrRUpH?=
 =?utf-8?B?UXBrWWw1VkJlUS9KY3BxWVhMR29SbVZkLzJiaWY0TWZMWmMrcTdrSmdXZm5W?=
 =?utf-8?B?bTJoTTVPMHpVbEpsMG9tZUJBTlpwRWk5MkxVWE5xeHh3RE1mV2plZ1ZScUl6?=
 =?utf-8?B?ekRFeG1QOFR4SFhkc0xmN3VmMFhOT1FDWDZqdFpVbmlWOVIydmpjRTFnbVJn?=
 =?utf-8?B?RHVDUXY1NzM4RGp0YVRhdDRUNHVueExMUTZFMGtKL2dKUTNyVXBRRmdOZElv?=
 =?utf-8?B?dUM0SWVTNXV2amhHME1TSUQyL01nNitFZk8wR0d3dDlRQ1krQkV3dUdLcUIy?=
 =?utf-8?B?MzZJOWlZVUVWVWV3UTM0cWVvMXVqem9sQXIzdWVpUEtnOGZIZ0Y3TEFOMnhL?=
 =?utf-8?B?dmI4S0N4L2hZVEdTcXFWNjg5NWwrKzhBZHIwVkZhRlpiN0xMY2dxY2YzajU0?=
 =?utf-8?B?TERCWWw1eUhUcm0wSk5CT3VRN2lQTDNpWmpPWDdFZUN2Zmxad2V0d2UyREVp?=
 =?utf-8?B?eCtBT0FraWgrMWxVQ2tpZWx3d2FPTDVPci9CSUlyVlloeDJIbjVsRyt2Q3FO?=
 =?utf-8?Q?SVJM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b5f56-0268-411a-a0b1-08de0cc2d88e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:46:53.1941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPFD9/luXDbpb3b/43KGZgWW75qi3nVypJ1AxOs1WAk+bav7+oacIyo7pl/G1QNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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


On 10/15/2025 4:33 PM, Philip Yang wrote:
>
> On 2025-10-15 16:40, Chen, Xiaogang wrote:
>>
>>
>> On 10/15/2025 3:11 PM, Philip Yang wrote:
>>> In mmu notifier release callback, stop user queues to be safe because
>>> the SVM memory is going to unmap from CPU.
>>>
>>> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 0341f570f3d1..e2a0ae0394b8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1221,11 +1221,16 @@ static void kfd_process_free_notifier(struct 
>>> mmu_notifier *mn)
>>>     static void kfd_process_notifier_release_internal(struct 
>>> kfd_process *p)
>>>   {
>>> -    int i;
>>> +    int i, r;
>>>         cancel_delayed_work_sync(&p->eviction_work);
>>>       cancel_delayed_work_sync(&p->restore_work);
>>>   +    WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>>
>> Use warning message or debug message? I saw this WARN are used 
>> several places. If the queues from kfd process p are still running 
>> when come here we need to stop them. It is not error. debug message 
>> is more suitable I think.
>>
> The module parameter debug_evictions can be set to true, use WARN to 
> dump call back trace to help understand why queue is evicted, by 
> default debug_evictions is false.
I agree stopping  kfd process's queues during kfd process release. Just 
wonder if change WARN to debug message form. We can use dump_stack() to 
dump stack anyway, but it is not relevant to this patch.

>>> +    r = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SVM);
>>
>> The evict reason KFD_QUEUE_EVICTION_TRIGGER_SVM is not good here as 
>> it is general kfd process release. Maybe need another enum value.
>>
> Define new profiling event requires rocprofiler API change, 
> KFD_QUEUE_EVICTION_TRIGGER_SVM seems the closest event from mmu notifier.

That is awkward. We may add a emu value at end that rocprofile would not 
know for now.

Regards

Xiaogang


>
> Regards,
>
> Philip
>
>> Regards
>>
>> Xiaogagn
>>
>>> +    if (r)
>>> +        pr_debug("failed %d to quiesce KFD queues\n", r);
>>> +
>>>       for (i = 0; i < p->n_pdds; i++) {
>>>           struct kfd_process_device *pdd = p->pdds[i];
