Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35726C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 06:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AE510E448;
	Wed, 17 Apr 2024 06:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W7L7qwoN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D136710E1E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 06:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx1cluPIt/Lqf+rnD6vil+DGiboC17ub7YRCb/9BkewL0VO6jjaWwQTkI1fxNePv5irVopvfd11Q11leCxh6BY729yGr0d3pi82v23IW2Wyjj03BAwRaQ/kkEvtyShCipQPsRN77rU5OzZH7NlP9I/h6kTTnuFdl2pr34Z7Pu1luXceMUhpE29gxyJFwIkF6LbFgPVguF0BN2yCv1DSBuiljct1cl96+PQvNynPat2R2PYwdM13OTDENOvbd4adhYG6qIjWJ7ozMuTbb20ai06q8m3DhI62EMg7CmQqvxfnGjXoOwZ2LkGjzC9EEgw2egVCocXC18K5jonlfZnHD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slXRCL6mMxtUPQ+u0bOOzbn5KWgBTbfi+dFQIO0/ZFA=;
 b=cpZ3ZwAf+RAuoU3ubxABiozgMg4nnZzx9AVxmrqwiusVGuFukULhlD5X7qTZ/vXiQBflzbMBPIYmc5ZEISa/2PmWeSrzS2fE20yp/Ct3oh8CZ6lmXIqqJNn0quziiA94dyx+KW5AiuaUMWnVo8LPl/RcskR4Swl9y5uG05VrA/Mid/d34LipRmUU2UMFjEp9fi9KHTFtDCgBKPpGGzVX+q1lSBrHy/CWqf0Ja/0MtgP4VgRuDL0zbG9Nc5HiQGeA9ObTPl6hhbWN6HU/JfJkG681ufzJkY0HQKqqLK0KDNQ3rO2UDJ5FKVegZaWRziBuoADgi10JhylpKWuYeeTgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slXRCL6mMxtUPQ+u0bOOzbn5KWgBTbfi+dFQIO0/ZFA=;
 b=W7L7qwoN3NRR8JRN4RHqE1waRIasheA+EJ7w43C+5YHg4yZh/PEriZZ+v8oNeo4VdFnKMj9exuI3IzZJx4B/sl2DLJB2qQJMddgCQmiqa7QvFjKGOO49IO215s8JYV5XCZKRFyjwcttreoJwFjhj0ylgWNHzivaXMa/ObnTjYyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:52:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 06:52:54 +0000
Message-ID: <d722d2a4-081e-4a0f-a13b-3480e2c1dd44@amd.com>
Date: Wed, 17 Apr 2024 08:52:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm:amdgpu: Enable IH ring1 for IH v6.1
To: Friedrich Vock <friedrich.vock@gmx.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240416133423.3346-1-sunil.khatri@amd.com>
 <20240416133423.3346-2-sunil.khatri@amd.com>
 <9bf1d4c8-d34b-4249-99f3-6232a97ae3b8@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9bf1d4c8-d34b-4249-99f3-6232a97ae3b8@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 805d6449-01db-48fa-4d5c-08dc5eab0202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjY2TXlyTVRMT3grelRseExzN2xrTWttdFJwbmF4ZjVrMVl4VnFJYU01VEVs?=
 =?utf-8?B?VXFKR3FKN0NaTFpWbXp3TXBVUVJHcHI1Nm5WZGF6YXJaSlB5RjBDMGRoY1BE?=
 =?utf-8?B?YUtEWDd4ODloVHdOOERobjNxaWQ0a2o5bElYYU95bDZhWkdiVUdqQUZNMy9K?=
 =?utf-8?B?dldqaVlNbWpxL3hFdmlnUnhOaTFncEg0YjBRdDBDYTlpaTFSWkRkdkEvSjJv?=
 =?utf-8?B?VlRkQmp4a0RpUDdUYi9TU3B3azI4Z1Z4Yk91V1BGSmFuN3ZXM1gxU2Z5SlR5?=
 =?utf-8?B?N0hnSHJwalZKeEFRMWlEbmpwdmpyclovSEFuNk9OWlR2MG5zTENyOVhjZXhH?=
 =?utf-8?B?ZjkxQXF4TUs1a3Rod0xMb0k2aFh5L3YySTZRRHZOWDllSWxrdGY1WHZ4STQ3?=
 =?utf-8?B?WVRXcFpCbXh6UTRJdnFhSjdpYTRQeDA5MGlzMjA5MWpkcTdKYjQ5aEI1dDZp?=
 =?utf-8?B?cisxamRQeHVxdXFkQ3Q4U0lmSzBzUjM1ZzlLQUMzcDlFMzNGbS9ZQlNnMm9p?=
 =?utf-8?B?YWRER3liajhpNHd1cTA0ZGhSeXI0b2VIYVZJcFFKK3poV29Bd28wTDdEVW16?=
 =?utf-8?B?anpwRVFWSWxVL2lmdFlGT21nM3hYV00xWndadzBySjhTK09wTS9DMFVMODBJ?=
 =?utf-8?B?elptUmRKcGJ4bi8xN0IwY2JjUHZNNEpScTlwUmhpTHN2Y0gwMzFiV2JQSnl5?=
 =?utf-8?B?RU5EbkV2U2hjQzRxR1hyOW9vem1UL2NHUmtBK05SeHgxTFZ4aFl6UE5ISHJQ?=
 =?utf-8?B?eEthUGpjOEZZVHljZm5PaHpUMXFZTWtHUFN5MnJDRjdIcW0vR2FTYWhGKyt0?=
 =?utf-8?B?bXpyQWUybVg3Skg1aGNaREtLeUhWYzgzMHFOMmFFLzE2T1pZamhIK0F1NHZo?=
 =?utf-8?B?U0FUMFpsZzMvYTNoT0xqRTZGNnNXUC9kS2lScjd1SmJzMWtvbmRZblVQR1c3?=
 =?utf-8?B?NHp5NTA1dktWUlNkV1BJSm1PTGxtM3FrWEpKU2pEVm5sOVVxN084TjZtRUVr?=
 =?utf-8?B?MncyeXpITEg1NXpvUFZHSnJoR09La0tRSHo4R2JjcGVOeEFCVmlGRldKWTVZ?=
 =?utf-8?B?MlhMQW1mQzE0QlhjMitlNmxjSC9hZDRWazh4MmZKL1BSUHBpeFdidXV4R2My?=
 =?utf-8?B?ck9nd0JodzUyc29ORzMrWm1NV0hTRTkrbXpaNndUNFV0VGxGb2FUZThpWi9h?=
 =?utf-8?B?YjJUcGFqZFBtTEZpeEZGODRpMlNHdForN0V3S2QyQTZSSlRJTUFBd0p4RS9r?=
 =?utf-8?B?OFp6M2pIdzArSEo0bEtORU5mL2VkZURXeVh1VXVCU3hSTloyc3dDMjd6M0lR?=
 =?utf-8?B?QVdscHFJeXlLd05JcTVUcDhHUFJBSEZlK1dKSWJJVzBBMUdoRE04ZCs1V2xU?=
 =?utf-8?B?Sy9qTVdMVmMzK2kyaVp2dTNqSmRMU0gxSWV6eHZOQ3VlOE1FdmJhTm04VjZJ?=
 =?utf-8?B?KzY5VDE3TzZLVjRoYWo5SWNRVDVBNE1lOFc2VHo0bmNSYU1qMkhDeUxuSW5C?=
 =?utf-8?B?UnJlelZyZmtLN1puNHhJanJ1OS9Fa0FHR2d2SFVyY0dWY3BncXBsSjBMUDhB?=
 =?utf-8?B?SDRlLytXeFBRdk0wYU9VWXJUb1BhdFZIZHNhNjFDajNZVkVMSU5rd1RxNHBx?=
 =?utf-8?B?aU9pWnJadmYvdUFaUGw3SEV4TTAyWHdwRWxiYXY3VEwzcG1HdmpxbXh3T1pP?=
 =?utf-8?B?TnNPM0ZKbytia2JBb04xV1dPM3FtM3Z3MS9EcHRKa3loeUl4NmJ2SXBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJrQ2NyZjJ4TmdUV2ZiUW9HVlU2Z1hQS1lvU2R4Wml4dHFXN1dDZm4wQTFk?=
 =?utf-8?B?Lzk2TUJmVmExaWh1WitaQkJ5b1BLVExKQjZDY2JXcXZjUWgrMytCWnY3MHFr?=
 =?utf-8?B?aUVQNzJmalhCTmJObWFWZHp5WUNEUktxMkJnQXFad1lXcWU4WG0yeFR2VGVt?=
 =?utf-8?B?N2duRHpDRXd1QkVCbnRpRzFTc1ZBS3JLdHV3TXpwdWZYcU0xQVdIb21tWUpV?=
 =?utf-8?B?aDdsYmJDZnUxV3ZGNHh5VitScjFHN050dGZPTnVNaEd1QTUrdDR2YjI0NTFz?=
 =?utf-8?B?NXlrVExzUmRmYjA3blZwckptQzNGK1AwclpURTc1ZmhBNjl3K05PSGpCb05k?=
 =?utf-8?B?VmVWcDZTbm9kcDdvRlE4aDhINWxqUlAyMFZLWENncDlWWFVtNTZ1RVFESlZO?=
 =?utf-8?B?Sk9DeWRIMStWUFQ5S1llNWZHamw5NHo1RThIclhlaWR5cFhoekx5Qno1ZVlV?=
 =?utf-8?B?dlVwVmZRUDEvZzU5RkpOc0hjTWIvS0JkdWhkMG5jL0tYOUt5NVNTTWtuSWZB?=
 =?utf-8?B?ODA5Q1BpZWI0NEJiRlhsYzFlOUI4ZENkaDIyeDlSMWR1TlQxeUN4SnhURkNv?=
 =?utf-8?B?WXJXVWxhL1lxeVFLdTZhblZFZ2Mwdmd6WWlNeG1EU05TY1VmSHpzK01jVHNt?=
 =?utf-8?B?Ykd6REZFQS9hSCtRcEg4a1ovaElkbDdETEhNNVp2NmV6WFJFbHhWUXVIZHpn?=
 =?utf-8?B?OFEwWEhrR2pGdEl0RHpmaE1ZVmVmRm5Ldk9tMG1pM1pCNjQ5V0kra1VuMFNt?=
 =?utf-8?B?M25iZHZ2cWFVakthcEdKd3RHNTdaaTRsU2FDR0J6NkFJZVY0Mkg4SHYxOHdn?=
 =?utf-8?B?alBBWUk3M1BKUUsxcUVJQkg1M0FoRXgyM1o4S0cwQTd1dW1lVEdIY3pFQmFh?=
 =?utf-8?B?UEtHOThOay9pTUFGOEtDT2t2ZjEvQjVEaGoza2VSaHN5NnVKMWw5NXVmV1dJ?=
 =?utf-8?B?SHdrMTl2bjIwcWo3WWVxV1R2QmdkdXVKS3plaXluWkR0ZFdQSWZXNlhwZ3Iy?=
 =?utf-8?B?czZQSG9QZVRWN1VGTzZPL1FaUVcvdVhLTHMxU01EUzBEYlpYM1pHNkpkcU9F?=
 =?utf-8?B?dU1UL0VWZzFucGU2bG1oaEJKaTMvRjdwTVNnbjBmbTJaQyt2S3JyMm5KVWQx?=
 =?utf-8?B?R0wyUnpYc1BrN0ZBaWdZUks2Q3RYWWxoVm1pWE9oYnZXN0pRZXNRSHBYK0U4?=
 =?utf-8?B?dGJqVVVCQXp1NkVEeERaVUc4TGJPbEtrdGJCaVdhMjVaSkRGRE5uaVhPZUNy?=
 =?utf-8?B?TmdVUXYxaUpLWFpxOHVjbGdnWXh5S1c5UmhraUVtNG5yNlJUT1dhQ1BJank5?=
 =?utf-8?B?M0VSS3pGMGE1MU9RSWd4Z2d2Mk1xVU9vd0szeWRpUHVJeHc5N2FFWFNUMTRh?=
 =?utf-8?B?Si9YamFpRmhEbmdPQjUwdjRidStaNUFyZERBRFVZVUkwS2JrcHV4TjZIQ2pr?=
 =?utf-8?B?Q2ZRandTL3kwZ2JBUllHUkt4QXF1d05xV2puemw2dWc2WVlqdnlaQU5BOG9R?=
 =?utf-8?B?Ym9MbzQ3eWRLSW4ya0dqTTAzLzJLNk9FMGMzOGJHTWdyMEZYbngrcDdobnJj?=
 =?utf-8?B?SnNwbmkwb0xSOWNIeFpweUhqQ085QzRmVWNrRjBHd2pQRWthNGhqRHhRSjE1?=
 =?utf-8?B?MDE3dHFzc2FYcXl6VHZlZ1lWMmozUE9ZZmJINm9URnFyY21PTzlscTlsOVMw?=
 =?utf-8?B?eHM0NEFNM2ZWbENWdGJqRXJmdHJQOGJKQ0wzdXJieHJtUU1VbnBKZDNUcE5s?=
 =?utf-8?B?cERmTDFCc2JnM2NrWEE0UnVDYVFEWE4xcE9VejR3MmZVaHRVL1ZGb05lYnRE?=
 =?utf-8?B?QTl2SkNsQTVyakQ2aGlZNWhtSGVTWGdwOXFCbkE0T3hNVG85Y0FtbWdEYnZz?=
 =?utf-8?B?d25weVRLdzRrSjBIMnoza2tSK3dGeTMxMGFSRTd6a3ZYOS9GZ1pBUEhzc0Nt?=
 =?utf-8?B?dEhLcWEvWk5WaGQwMTQ4MHZBaXpzZm1qVW5pa0hFWlBmVERoTDFaUWZUUits?=
 =?utf-8?B?ZlZ0T1Z5YU9tamVzOWJxVmxqTDBmQlVFMGlsdFM3WEdJcmc1YWM1WXpPQXZS?=
 =?utf-8?B?Y2xUS2xxRko4TkhGNlNPRTNnZUhVWDkxTUk4VTlBbzNZYmxuRHpTT016djZj?=
 =?utf-8?Q?jieH+2dfxdktVpmgZi22hKbaW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805d6449-01db-48fa-4d5c-08dc5eab0202
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 06:52:54.8418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUH0YB1gYEsuV5tMfoIT/LtwGqKmXOEe/f4jHM5XPcLzDWUnSi571yroZXGc2UK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
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

Am 17.04.24 um 08:43 schrieb Friedrich Vock:
> On 16.04.24 15:34, Sunil Khatri wrote:
>> We need IH ring1 for handling the pagefault
>> interrupts which over flow in default
>> ring for specific usecases.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> index b8da0fc29378..73dba180fabd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> @@ -550,8 +550,15 @@ static int ih_v6_1_sw_init(void *handle)
>>       adev->irq.ih.use_doorbell = true;
>>       adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
>>
>> -    adev->irq.ih1.ring_size = 0;
>> -    adev->irq.ih2.ring_size = 0;
>> +    if (!(adev->flags & AMD_IS_APU)) {
>
> Why restrict this to dGPUs? Page faults can overflow the default ring on
> APUs too (e.g. for Vangogh).

Because APUs don't have the necessary hw. In other words they have no 
secondary IH ring buffer :(

But we are working on a fw fix for them and Navi 1x and 2x as well.

Regards,
Christian.

>
> Regards,
> Friedrich
>
>> +        r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, IH_RING_SIZE,
>> +                    use_bus_addr);
>> +        if (r)
>> +            return r;
>> +
>> +        adev->irq.ih1.use_doorbell = true;
>> +        adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) 
>> << 1;
>> +    }
>>
>>       /* initialize ih control register offset */
>>       ih_v6_1_init_register_offset(adev);

