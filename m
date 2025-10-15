Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76F4CCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 21:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DEC10E0CC;
	Wed, 15 Oct 2025 21:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xWqTeqMc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2956F10E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 21:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPfdH33Z9ZsQYZQJB9Yta1+NvoQpD8nuVa7+A6FPxFefeSc9UksO3hjqM08ASmkk3BIfkUvhaa7rX0dePIhecJRpmz8hi0686mDOyB77nByO/qTTqExNmSHqF5qndoXAq7mtcSDp6Xau+O7LssQbj9u79TbKlBrq0JkxwZXvXzwMlr61IdYyUuPfl4Z/PuM0/xjTzNAhjNQQowzRNJWXv24p3Gv4amACD0RW6/7txmlvAG+YMw9RIVGJrHysYEtHA9raGTSX4eXR3mz2vK0Q9Mk5EYGcNvq1qHi/ouXpuHGKufHfWm6IKVUVwtlZ5NCG+Vd4F1QcG/qcuF1ee9zZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3VAivy4btC7V1ZNkb8pkcQdm+d7FQ07XEshX+UIlr0=;
 b=KxWOFk0sai76UXUzhCCG4dBSnunR6ioUy6MtDvpuM0w+dvFpl1BtIF0BUrmKS3WWX52Ko7M8H75fCBhbHtni5jxy8WplWPwk6isQygVvV5oVmcrBONcPmYlKXhN7LJrwurByvY08miTHMd/JbVFzNmbLr8laZ4fGvNx0TJfhB+2tDS9U2KgxqxljuBkyjRZXKa3G1y0ncGdUgjoyw/YWptacabQX5RAp/G0Bcon66XOSRTX1avySjyNJSUQHrivTazWp8mjQ2pUEA+oul3xAWWvGH9/czOmd9z8GyTCOXn1y0x2UXkF8QiWsfLG1rJal8yfxyARFBc1fR2bwxKjgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3VAivy4btC7V1ZNkb8pkcQdm+d7FQ07XEshX+UIlr0=;
 b=xWqTeqMcUhYp0XPNPoiWLfUOlztuYNkPScfE5+THGBb737jJ0RyLUJJ74VArfFYTfIFMRQxFd/cGUVoxym66DR07BKu/GiASJvoa7w+X1ngyj0NUBKBLBIxZXfpnhmz+nXnknsViW14sR0eWfdKfJNAz6wKREAbGDcgiVFjYU6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 21:33:34 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 21:33:34 +0000
Message-ID: <c0daed21-77b2-664b-ed63-ae188fff2f06@amd.com>
Date: Wed, 15 Oct 2025 17:33:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Stop user queues when process mm
 released
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <20251015201134.2540-2-Philip.Yang@amd.com>
 <29dd1aad-26de-49ac-9d25-c3dffa862705@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <29dd1aad-26de-49ac-9d25-c3dffa862705@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::25) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5004d9-de1d-4043-3340-08de0c327e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3o1TGN4MURQb2w0WEhhWFNyNkExNzhNOUg3QzF0UU1SbUU1ck9WNTRjK1hq?=
 =?utf-8?B?N1YvVFpiSnNsM1h2N0d4MVRKTjN6MGkzbmpSRzF0elFmUGxDUDFOOWV3N25P?=
 =?utf-8?B?eVIzdkthOEJEcW9FUHhDZG5rQUZEMklsRitGL2xFbVRVNXNXdXJ3QWgwZWJY?=
 =?utf-8?B?N3dSL0ZlaFVnTjZDT1l5aXFuaGlPQjNSWHYyN21VT3daa2FzUnh1OE5idlQw?=
 =?utf-8?B?cExXKzV1ZVJlSDZBVzc1N2ZDcDc4dGJMYUwwOXZMM1FUTGpuOUFrcW05ZW9R?=
 =?utf-8?B?bHZLUnkxeGpQQnNoaXNvUkZiSVNmTjJ4NHZYdVVsU1VSUllmcWl6YXJoTVo3?=
 =?utf-8?B?U0c1ZDV2Rjk2M2ViaHBhVWFYMHRCemxYQXpmRFFhZXBmM2pLbmJZdlpMdVpE?=
 =?utf-8?B?WHhjcTdIanJPeUVadXRlRDV1TUFnYXJtQTF5R1RzbnlDaUw2M3BrVUN2Q2lY?=
 =?utf-8?B?QTlPOWhVUEdid3lkR2p1WS81cGJac3JpcVFQQVo5UWFqWE5XRkxqaG1GSTYv?=
 =?utf-8?B?ZFNSWE9pKytvRDRYdWI0WjgyMldiNWF2RVB2V05FdzF4KzMvM2dlTGtVbURT?=
 =?utf-8?B?ckpUR3VuTHEyLzBNYXdXVWgraGRjVEVSb1pZVk9JWHg3NkJXRXQ2L3lCS3Fv?=
 =?utf-8?B?Wkd4Qk9TWXNScHhpWjBhRi9ER1ROWHB0UVZlTVVFNzdqK0FtZWpCOEVqL3I3?=
 =?utf-8?B?V1ljQ3VkT3V2SlBRc0RzK3JxaDlONWRlRDUvNUEyVXNoOWtGMzc4MU8vdmQ1?=
 =?utf-8?B?S1Uydm1lNGJTazcyU2NWei9NV2I1WFBuU2JnOWdpTFR4WkxFWlJ0Z2RTZm9t?=
 =?utf-8?B?OVRxaWpSUTJKRnc2S2JvNXJuY3Q4dEhMSmZKQkF2TlBrZDVqZWtQMXVRTVBX?=
 =?utf-8?B?bmJ0NEp3RGRSWmJwYUVOSXJBMVFpV2MzQndmR2NLY3A0QTJ4MDNIS0VqRlUx?=
 =?utf-8?B?MFlXTXU0b3N3SUdVZVFzaHVCNVRIWndrQzkyU3FURk5uZlJNUE5WcVFyWWhm?=
 =?utf-8?B?SUZoZ0V0enh4V0ppYW9lSzJwcTEvb1FMUU5FMFF3REluV0lGQUVRcDdHeXV1?=
 =?utf-8?B?SUVPUnpieXhhOGwrRW8vSldUQ1V6dTh0QTliZkFkOWFhL2MwMWROcXc4dTdH?=
 =?utf-8?B?N2FLbGpBelZ0ZGhCTmJ1cFBERFVGQnBpUVdwdjFYcnNkWEpzNWFETERYbWlB?=
 =?utf-8?B?N3BrQUpsOVduNFEvMDU1Y3BTcGpERGxrY3FFQkd6YWdWYWZCZW9LSnFhN3lD?=
 =?utf-8?B?VnY3OElqNzN6Nm51T25sejUwVEhhMnNvcU9uRUlRU05ONFJnM1I0TkgrR2tG?=
 =?utf-8?B?YmNWbDZCTmJtWE9GdUE2elEzd1VwaVA4d3BtaHg5Y0JPRW9NcXErdDk4RldG?=
 =?utf-8?B?U2tWN2lES0pZRTd2eUxUREJvZDlPL0I4Qm1ZRmJhSEs1NnJtcThGazVsL3Vw?=
 =?utf-8?B?WGJPeitjS2svY09wa2xHQ01KOXFGZXIzaDJqZmFCTk03amUwUTUzZlFKdDhT?=
 =?utf-8?B?eUhqN2VmT2owZjRyMTRFalRnWVdNYkt4blNBbmNwa1dIRUc0UFh2Q1NCTkt0?=
 =?utf-8?B?OVdKeGRtenpJeHQvbjdJSVpJeVlMS2FEaTZKNm9uci9VcFBTeU1weU9DVEJa?=
 =?utf-8?B?cFdCdXViZlRKd0JHR2c2RFFvVm1KbDFTZWNBU25oU1VjVXZJRXE2a0ljYms2?=
 =?utf-8?B?RG82UDJKZ0RNMzdTQ0JudDJ2RENqdERBdVhwelRDYmJ5Qkl6cGlGa0pRdWJC?=
 =?utf-8?B?YnFNVjNkT2ZkTkR3ZHAreWltb3ZDVXBNOTB4b2JCMllpbmcyeUhEK2FsajBu?=
 =?utf-8?B?KzNhT2xsQzJveUFzQTR1bWs4MlpkU3J5V29XSEFSR1RpU09xWHZKTzY2OS80?=
 =?utf-8?B?Ykp1ZzRWMHg3M090ZlRMc3NjQ20xZlJvSUdDVFdjdXFDNjJ5a0NBYmtkWW9t?=
 =?utf-8?Q?caKC0RNduIQmgCx0z3G811ePfdnkabYW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9HSDNNOWxrTThPZ09vWnR5UHU3NjRyRmIyeDZtVEdIWEJSdHdOWG8zNnVT?=
 =?utf-8?B?TkE4UFdUcUtjeCsyMGtBb3ZqSFU5bmo4TVhhcm1MZkV3djI2TGZzTGhPdktL?=
 =?utf-8?B?bCtVbVU4dVpORWp1ZEpVenRCOUtsZm8zNkJ5bXc5QzJtM2RtempWZTczU215?=
 =?utf-8?B?MS80d2RtczdnT3I3OGZMREFuV01LTUJlTVlRR0xFQThOZjZOa0RpYUlOYll4?=
 =?utf-8?B?L2hmbVVIWnl4WVJSM1RhMURrMXBGMVVkQ3pUWTJ2TGtvNUp2MVFldVBRSVM4?=
 =?utf-8?B?YlJjSnVwOUk4VVVxSkN1L3pLMGt2dHowQlIxa2dpQzZHZXl1d254ejViQmZT?=
 =?utf-8?B?VWlaeCt2bXR0YmV5SzhMbVFGdVVEYUNMZDR6Wjdoc2xWWlVpWVZWZytFT1g2?=
 =?utf-8?B?VUg5RXErdE1OMTBveUg3ZlZHV0RucEY5L1NCOXU1SGFPaTk5aGhsZmYwOEhO?=
 =?utf-8?B?b3VrcStVN05kNEFjU3pNOS9UeTFsWFFTZ09FRWR2M2ZiQ1VFWGZEYnQ0RmpI?=
 =?utf-8?B?V0xmK3hFOXBtbDJGY0lvdkNMZHd4YWZtaHlxMUQ3MzQ4YmdQSW8rcmtqazNO?=
 =?utf-8?B?Ynp6SHlyRWthcmFUUXNkOGhaWFNVdU92eGQvOFgyTTE1L2dEeDJKTUw1ejJx?=
 =?utf-8?B?QTdKcGRubWlYcEFpRUFCN0dhMVIzNkRLTGpJZ0hxRWgzRHVBRk9pcCtBQm1L?=
 =?utf-8?B?MHY3Vi9KV3JVRnhsb2VsVGFBS0wzNC92ZEdZS0g5c0RZejRLNys0b28xcnBP?=
 =?utf-8?B?MlRvcEt3VGNwbjNLYU4reGtYMGFVcE5NYUI4cXpOa2dwQ0JtZGtaY3h4S3Rr?=
 =?utf-8?B?T0RyZGlXWFVjditsdHQ1OXVOSFJ6RmRQN1pZaTRRY2MvZ0F1eHFCVjh5Q2lU?=
 =?utf-8?B?MXdXL21SclJRTy9BZk5Vek9KckxCWHNxNXlxUUliQTFDK0tCcHVOMlJjWnFK?=
 =?utf-8?B?Vm5NSWRaRSt2L0l4ZU82endsM2tDZFpqSkR4ZFBRRmdlQ0dpYnM4ZDZpUFZz?=
 =?utf-8?B?REdnUkowQ01YRnp2bDdodW1nOCt0ak5zSXhYNzBYNG01eTdZaUMrTlkxcEZu?=
 =?utf-8?B?U3pEa3RxL2dUNWFwSmNUT0tkTWNKVWJVVmQvUUxIOXhJbFE5ZFE5YjZBKzJQ?=
 =?utf-8?B?bzNxY1gvQnZjWGtGcWpjbHg3SzYzWllMWEJQMElXbVhTRWhFVTFkVkhRR1dl?=
 =?utf-8?B?ckJCUDFhUzJoTWZ5dDY0WWFCeW4wWlR3dFhMYVB0bERJZU1HVXRFU1I5akJE?=
 =?utf-8?B?YWRrNnRIQjZFTVVwUS9yVTFVOHBuMmV0LzIvNHYvemNacHp6ci8vY0dnYXpN?=
 =?utf-8?B?OVlRREhmLy9tV1lrbWtmeGRWQ2FiL055dDh0aXJDRXN5MGpYUjNTQlAwOTFI?=
 =?utf-8?B?TTB1ZW9mZGFGR1p4WDI1TzJkVDl1TGZUejB6bis4VVVxa1VneTNYbytJdTZD?=
 =?utf-8?B?RHV0UWRqNVphRi9xVElpUmlxcUJLSDJaeWVBQ3JScVZ5SEkyVlhXWW9kU1RJ?=
 =?utf-8?B?Ly9WdnI4Y1dLNE0xTmFObWwwcTQwQU11cG1oNW9HSDlyWm4xL0wzMjg2dlJj?=
 =?utf-8?B?WHA1dXdKNkhFeUtyK3hQclZTcDZobVowK1dsaDJJaE12dlJVMmZZY3VKUm1L?=
 =?utf-8?B?UjA2VnNtY2xza21OclhYckxJNnh0WThlMS9jbUlOc0h3NDZhSjlBazZJTzFi?=
 =?utf-8?B?WEhpbWdhakQ3R1ZqMlpXYmk1ZFk2cStrTU9Lem40RlROUFFOZFNWMkhmMGUw?=
 =?utf-8?B?ODVQUXVoU0VrcWVKOU9pcllJTStNM1BkaVE3MzFCYm1EVGlCMTBXQThIM3o1?=
 =?utf-8?B?aWdURXBsaGRUMjF6RXpYc2JETjlwendOcWlDaDJYRzQ4SUVHc0ZWQzdtWkkr?=
 =?utf-8?B?NEtiem5USi94VEkxV3VyL1lZR0xHRmpQdGdoOGhHYmY0VThoSUk5b1ZpdjE0?=
 =?utf-8?B?M3RMbWs4VUUwUFg2cG5nZDJ3T0w4M21JNzc1U2VXSlFIbUFaNWdyQzVmL1Bu?=
 =?utf-8?B?THZBSStOeHlEVVZ2NEtZb2RFaDhJMFlGTzdmeDRoU2xXaVhIT09GT2E2S0hT?=
 =?utf-8?B?NVV3UUpnN1pKblJ1eWdSdWJOSWVpOEduMDgzT2pPNHdvRDVFcm1scDltZE52?=
 =?utf-8?Q?P4v4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5004d9-de1d-4043-3340-08de0c327e5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:33:34.4149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxqn/hPRwVo7amXECwGZeQbEKbLIZuD3EMhAGt5GgZ1z2R0WWxPcgyWebIL2q6hh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
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


On 2025-10-15 16:40, Chen, Xiaogang wrote:
>
>
> On 10/15/2025 3:11 PM, Philip Yang wrote:
>> In mmu notifier release callback, stop user queues to be safe because
>> the SVM memory is going to unmap from CPU.
>>
>> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 0341f570f3d1..e2a0ae0394b8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1221,11 +1221,16 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
>>   
>>   static void kfd_process_notifier_release_internal(struct kfd_process *p)
>>   {
>> -	int i;
>> +	int i, r;
>>   
>>   	cancel_delayed_work_sync(&p->eviction_work);
>>   	cancel_delayed_work_sync(&p->restore_work);
>>   
>> +	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>
> Use warning message or debug message? I saw this WARN are used several 
> places. If the queues from kfd process p are still running when come 
> here we need to stop them. It is not error. debug message is more 
> suitable I think.
>
The module parameter debug_evictions can be set to true, use WARN to 
dump call back trace to help understand why queue is evicted, by default 
debug_evictions is false.
>> +	r = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SVM);
>
> The evict reason KFD_QUEUE_EVICTION_TRIGGER_SVM is not good here as it 
> is general kfd process release. Maybe need another enum value.
>
Define new profiling event requires rocprofiler API change, 
KFD_QUEUE_EVICTION_TRIGGER_SVM seems the closest event from mmu notifier.

Regards,

Philip

> Regards
>
> Xiaogagn
>
>> +	if (r)
>> +		pr_debug("failed %d to quiesce KFD queues\n", r);
>> +
>>   	for (i = 0; i < p->n_pdds; i++) {
>>   		struct kfd_process_device *pdd = p->pdds[i];
>>   
