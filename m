Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2A4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 16:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8057B89617;
	Mon, 31 Jan 2022 16:24:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A18A89617
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 16:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlJNcmGS+hSi9BXstWiB27McGA5qDM3O5FSFxvonkN2CKct8Dc/YHVxErbEEsPBYkQ+AOk91r9/amEDpEmWQqqjEKGQSyz/j87f3cqLG4LpHyl+Tzug+edKyMN6gpNPFzvXch/6xiJ+EdDIw/u77VVtsK9YahdbusGmldMiUKao/Dp8atmCS4CPZ0P3VybZguC1XbOLaqGZqkmECw+8b2ZXQIHr73COidTo/W2Uugk6zVGJHlBcN+b6QTlUjxjiggOIS8V1PXk/c5Xk6xTU2muW/623ZTla4zv1L+j0I5lJ+REDTUFy3icBFYY1MWuIAysLSULoq3P7kXzBLhWknQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxMTcsVTTr0H7WOYPMBVk4DvcV47HYqmptCgxjsJEa0=;
 b=KNhnOtbPrNzN29ooN+jkJepCfBloXpxq0oe+ZFBP8+1inEW98upc+SYeeg+ZuUEX9q/w246lkewPF45r0uxRvOIuXyYfPTOeEoXWYMgWQNrEsgJFRbCJ1ohzLTww2+Im6eXnTL2DhNyPH4NDAQRoYnqmNoEqXETW9Cbt64MjbMsiFcMhIA3x2czkPJ8FPXHJn7UK0swvoJE/JkmqhQ5JvqOt4x+FDcG+DZwac/74hO2z37BZMaTubw4ojDuKnywo5lVIcCJZIWv7Yoa0nZXKjzPOt4Bpb//noyVC/vWRdp4ofYQo2GDX3nByKN1k9aRTJ4JRjamHGnHdZ8+7BR8zdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxMTcsVTTr0H7WOYPMBVk4DvcV47HYqmptCgxjsJEa0=;
 b=kTk9JAoHKapFcLQV6GnjuZryL86w3w8Erse/S/54MQw8Udymvjy+5egpguMzr14JVHtIXoDLu3LrNMakmQL1NQp1tSVaSS9z5WBwJ3qNHqlCPttQqxJxY0YGrB3eju64ujQ44CJRfgfq5pWPB56eGX8hbUmZzXyog98OesI9T4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB2982.namprd12.prod.outlook.com (2603:10b6:a03:a8::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 16:24:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 16:24:23 +0000
Message-ID: <1d6422b4-634e-f478-664a-50093feab95c@amd.com>
Date: Mon, 31 Jan 2022 11:24:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
 infinite loop
Content-Language: en-US
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220129123352.3765260-1-YiPeng.Chai@amd.com>
 <DM5PR12MB1770916E530D42230CFB4B9AB0249@DM5PR12MB1770.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM5PR12MB1770916E530D42230CFB4B9AB0249@DM5PR12MB1770.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b71f8f78-27d4-4f6b-bbb7-08d9e4d62413
X-MS-TrafficTypeDiagnostic: BYAPR12MB2982:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2982C6C58E4D1F2F604B7FE492259@BYAPR12MB2982.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJhe6aRm24dl50goodzJIBfCsKsixC52VDqXwVsEK7qz74lddspUc8nH8pn+beI1V14pMcAKPapagQAQMzENK5oVN6x03VPMQA04ZGUbByQgLcMQ4+Oya55Sw02AfXyxRlFrzT6mqSRoj+uSW0IffEr8W+pt3ZjUFNzmcnYH0e9Z3ZUnEhcQe7XO7wIeCg3Y7d/zscxqBruhOIS5SBqpjYMfbQu6O8k8NTDRcqnNoAWt1ieYhbrNabItzU5RN2h+W1PiP0l+LojvUoECOZn2vfqkGfKbD2w6k5YF2lWsIct4F3lbC0orkg1HXDmA7f7O9qkw2UTbShEb9PJ/cG2I68sAvmmxfgbHuQtStwrNwW11xzk5pJs8yPZkiQcIvOSCSbTfVebx/ynRh4ZsfRWM1iz+eu35r9luKNuO5y32CjT9TZbHRyAsANuv7nGU0aGYfzn5X3Vfva2JK9jFZbm/vPJM9T77pETLudRUMNYCVPTOBUTlYITsDz3YezP2CctD8MFvVdX2qcW85kqd2lxltTZUm4h5Tli/SJX1n3jya8WNsUFRPU7ohLonODZ5jKnmd2LWj9weXO9w3iYbT3PzfrjGjduM/u4zwpGijW0sDbypBhbMxMqZSbzI3xYys23ciqvALzySDXL+RhhEp7jG8vFMANDkhiYdE6BeLRipFCCbjgjGJiZvhX5UN/Cq9JEAkPl90cGb1dqBrF6hY/T5LiOftIcsGvw2oE4eSV3RRCy6hVT7bMqvun+osh564Fug
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(38100700002)(2616005)(83380400001)(508600001)(316002)(2906002)(186003)(26005)(36756003)(6486002)(5660300002)(66476007)(44832011)(66946007)(4326008)(8676002)(110136005)(8936002)(31686004)(53546011)(86362001)(66556008)(6506007)(6512007)(54906003)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzJTekN4OXBDdTJ5YmxYMWw2WGlIUXQ5eW8xREhOcVFzL0lWd2tnaXRHNkpl?=
 =?utf-8?B?U0JMZkU1ZEluY3dTWHJ2a1haNU1vNitPakVlL3hNbytPcUpoMVRqUjRZS3hy?=
 =?utf-8?B?VkwrOURGVkZSa2VVcFhQbFZpS0RUeGFtcDYwdkk0OEZ6M1preHF0bWpnWitF?=
 =?utf-8?B?K3BMQWFlQndSdzFOYllzUEJjbjZUdmxpQXduenpTY0xEVXBzQ1NlZnVBMklU?=
 =?utf-8?B?ejk4QXpRRHZScENRa3hvNFZtT3dydWlUajZIY2FzNXk1dmdLc3F0UTZHNTF0?=
 =?utf-8?B?aTNVdTd1anNzSFpQN0txZnFheEI1ZVVTNTNxZDIrTUZRWjRQeUYremNCcml2?=
 =?utf-8?B?Tmpibk1CMUptMmtoSVIyTEZQZWNOdHc5QzNXMDFnVWRzcnJoTSsxTnJZUmhk?=
 =?utf-8?B?OElWLy9ldFBxWG1zdGx5ZWhWMkVQVDRmbVd4V3ZldFduNGJSRDhVT05ic2FP?=
 =?utf-8?B?QVJYTjVvaUducXpMVTMxUG84RzVJYXc1MzNKdVROcU80QkVnUEFRVUVaMkNk?=
 =?utf-8?B?d3RqU1FscG9tNkxPRzJoY2NUai93NWtUSUIwUCtMVlpJMGJ3S2x5elJWazZL?=
 =?utf-8?B?WTVTc25JMnRrbTZnUXpXZ3IveG04ZkhtQVoxc0FsOEE3WHlqVlJpc010K3Br?=
 =?utf-8?B?Yk55bnhhb29tYlFFaHRieHNJN0dtckFwS2VITUR4aW1WdnQxSElGRVA2SkFl?=
 =?utf-8?B?YmNURWVXWjZLOUpSM1RMWHlKR2Z3VFpEOGtTcUc3ZnFMK1E1a3MzUzhPbXpt?=
 =?utf-8?B?RFJsVy9zNDRQTlpYNzdMSmxzV0c2TlNTYldXWmN1eGk0VVNiTk5LZEc3dXdB?=
 =?utf-8?B?UlhuNXZ1NUNKVnR6amRRRTB3cUdoZ3ZsUWppQmhmaGhvV0xJaktPUGZSY3NF?=
 =?utf-8?B?UEpwL1VFU05GZ1VsaHIvbEhXbnFKVzhwMHVPL0ZJcjVtZjkrUURnRXFFY2xn?=
 =?utf-8?B?QjNvUHVtanNWZXliYVovRlZhSGt2Z080Nm02eFRqanIranpCVzBqSmt3d25R?=
 =?utf-8?B?NUVXRkRzU3VJSGxLR3VsSWJpN0t4NUUxVjgvZDIrdXdHa2cva3VWTEUxd3Bw?=
 =?utf-8?B?UG1pY1lxb081bGUyR05lNFZmbzJZdHhPVHpIYnBvbk1kUXEyRDcwSkp4cjFG?=
 =?utf-8?B?ajhKWjJqdk9iOGpnNm5TRWpTTGV0Qzl5VTB5eFVJR1VaWm05Tzd1SWRMV2or?=
 =?utf-8?B?Z3dEeGFQZ1JPT3JPU1oxUkhnU3EzWjIyZzRhWkMwUG5KMFE2QjNyNTY5aUlC?=
 =?utf-8?B?SUV6RjMwUmEwV0FwNEtpbzc3TGZlb2lyb0M1M0Uzc0N1Uk0rMGZFMlovM255?=
 =?utf-8?B?WVNnQ25RZSsrYWpRbEN2WGI2Ym5heEt4LzFCYWZ6Q1NRb2xEdHpKVlFkUm1p?=
 =?utf-8?B?ZmZzSmtTUVA1YjRXRER5N2VWL1p0NTJQZnp2R2JIUWR3VWwyenJKRGxqZVFJ?=
 =?utf-8?B?Rm8xYmZ0SnFHK0lGUUxNYkVxcmJORDN3TXVWaUl2QWkwRjFYODluTWlEV2xy?=
 =?utf-8?B?d2RJZlNlU2pmVzlWVExBMzQxQThNbnpCTmpwTnNhMWhOSW1CczIzYTk2SCta?=
 =?utf-8?B?ZUVnZS9ZUS9NMVlwMkYyN2VITFdhNDRHOENPM2VmRkl1RWtyR2hUeXhONUVu?=
 =?utf-8?B?RUZrZHJFS0Z5UmxzSEZUbHUxK1dVaFgvcFRPdldrajNHZmp2YkRDTHpGTGF2?=
 =?utf-8?B?RVlrYUJqbzNEWW1iRjBhZHJWeFR3cHN0bGFET0xNSXJ2c0lzb0RZOVBOVWs0?=
 =?utf-8?B?b2NxQkxkN1ZiTW04YmFveGpUWEt3ampHT3I4SkdGeTJpK1k5NWFkVjR3a0lo?=
 =?utf-8?B?Rm4wOWpaQUpvYVNlQkxnV2J5bU1hRGhWazZFMnJFdVFXbnJWYWNSN3oxL2w5?=
 =?utf-8?B?YXdzdFVKWU1HMXJpbDVOQXdWWjRRR05RZ0JwaW5vTkdySEJONHo0VnN0VjBn?=
 =?utf-8?B?VmVLYStQaTE0aXN6K2VLd25MZXdIaHRJbWFsejdraUdHUjlhUWZMRzY4Tzgz?=
 =?utf-8?B?ZGxKdEdwbGdpSzM1UU9hQ2ErQ1VLU25VcmZ4cFVTQ0QyV3NKblFIU1NhaXRV?=
 =?utf-8?B?T3dKcWQ4VVdsdUV6WjkrRmZJVzdPVklYWHZxS2hDR0RjQjlrMzU3V0NQZ0cx?=
 =?utf-8?B?cnlsTEJ4SjZ6TzNqZFllenlYRGhTdnEySjlXWHZSMkJSbVRITy92dVE1M1ZV?=
 =?utf-8?Q?x9jHs3KmdUa37SJVunaKQLw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71f8f78-27d4-4f6b-bbb7-08d9e4d62413
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 16:24:23.3578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJPRqHVlZPYuEONWEsAgEM9Z7QctTE+r5dqkqR9Lfu0ZfDwu63TyVIl3WgCQbPyqWgcLwY1SY5kxc7gqlPbo8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2982
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-01-29 um 22:19 schrieb Zhou1, Tao:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Chai, Thomas <YiPeng.Chai@amd.com>
>> Sent: Saturday, January 29, 2022 8:34 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
>> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
>> Subject: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
>> infinite loop
>>
>> 1. The infinite loop case only occurs on multiple cards support
>>     ras functions.
>> 2. The explanation of root cause refer to 76641cbbf196523b5752c6cf68f86.
>> 3. Create new node to manage each unique ras instance to guarantee
>>     each device .ras_list is completely independent.
>> 4. Fixes:7a6b8ab3231b511915cb94cac1debabf093.
>> 5. The soft locked logs are as follows:
>> [  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           OE
>> 5.13.0-27-generic #29~20.04.1-Ubuntu
>> [  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU,
>> BIOS T20200717143848 07/17/2020 [  262.165698] Workqueue: events
>> amdgpu_ras_do_recovery [amdgpu] [  262.165980] RIP:
>> 0010:amdgpu_ras_get_ras_block+0x86/0xd0 [amdgpu] [  262.166239] Code: 68
>> d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 38 48 85 c0 74 32 44 89 fa 44 89 e6 4c 89
>> ef e8 82 e4 9b dc 85 c0 74 3c 49 8b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8 28 48
>> 39 d3 74 25 49 89 c6 49 8b 45 [  262.166243] RSP: 0018:ffffac908fa87d80
>> EFLAGS: 00000202 [  262.166247] RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e20
>> RCX: ffffffffc1394248 [  262.166249] RDX: ffff91e4aa356e20 RSI:
>> 000000000000000e RDI: ffff91e4ab8c0000 [  262.166252] RBP:
>> ffffac908fa87da8 R08: 0000000000000007 R09: 0000000000000001
>> [  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12:
>> 000000000000000e [  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc1394320
>> R15: 0000000000000003 [  262.166258] FS:  0000000000000000(0000)
>> GS:ffff92238fb40000(0000) knlGS:0000000000000000 [  262.166261] CS:  0010
>> DS: 0000 ES: 0000 CR0: 0000000080050033 [  262.166264] CR2:
>> 00000001004865d0 CR3: 000000406d796000 CR4: 0000000000350ee0
>> [  262.166267] Call Trace:
>> [  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu]
>> [  262.166529]  ? psi_task_switch+0xd2/0x250 [  262.166537]  ?
>> __switch_to+0x11d/0x460 [  262.166542]  ? __switch_to_asm+0x36/0x70
>> [  262.166549]  process_one_work+0x220/0x3c0 [  262.166556]
>> worker_thread+0x4d/0x3f0 [  262.166560]  ? process_one_work+0x3c0/0x3c0
>> [  262.166563]  kthread+0x12b/0x150 [  262.166568]  ?
>> set_kthread_struct+0x40/0x40 [  262.166571]  ret_from_fork+0x22/0x30
>>
>> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++++++++++++--
>> -  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 --
>>   2 files changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 9d7c778c1a2d..b0aa67308c31 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -75,6 +75,13 @@ const char *ras_mca_block_string[] = {
>>   	"mca_iohc",
>>   };
>>
>> +struct amdgpu_ras_block_list {
>> +	/* ras block link */
>> +	struct list_head node;
>> +
>> +	struct amdgpu_ras_block_object *ras_obj; };
>> +
>>   const char *get_ras_block_str(struct ras_common_if *ras_block)  {
>>   	if (!ras_block)
>> @@ -880,7 +887,8 @@ static struct amdgpu_ras_block_object
>> *amdgpu_ras_get_ras_block(struct amdgpu_de
>>   					enum amdgpu_ras_block block,
>> uint32_t sub_block_index)  {
>>   	int loop_cnt = 0;
>> -	struct amdgpu_ras_block_object *obj, *tmp;
>> +	struct amdgpu_ras_block_list *node, *tmp;
>> +	struct amdgpu_ras_block_object *obj;
>>
>>   	if (block >= AMDGPU_RAS_BLOCK__LAST)
>>   		return NULL;
>> @@ -888,7 +896,13 @@ static struct amdgpu_ras_block_object
>> *amdgpu_ras_get_ras_block(struct amdgpu_de
>>   	if (!amdgpu_ras_is_supported(adev, block))
>>   		return NULL;
>>
>> -	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
>> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
>> +		if (!node->ras_obj) {
>> +			DRM_ERROR("Warning: abnormal ras list node");
> [Tao]: dev_warn is recommended.
>
>> +			continue;
>> +		}
>> +
>> +		obj = node->ras_obj;
>>   		if (obj->ras_block_match) {
>>   			if (obj->ras_block_match(obj, block, sub_block_index)
>> == 0)
>>   				return obj;
>> @@ -2527,6 +2541,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>>
>>   int amdgpu_ras_fini(struct amdgpu_device *adev)  {
>> +	struct amdgpu_ras_block_list *ras_node, *tmp;
>>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>
>>   	if (!adev->ras_enabled || !con)
>> @@ -2545,6 +2560,12 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>>   	amdgpu_ras_set_context(adev, NULL);
>>   	kfree(con);
>>
>> +	/* Clear ras blocks from ras_list and free ras block list node */
>> +	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
>> +		list_del(&ras_node->node);
>> +		kfree(ras_node);
>> +	}
>> +
>>   	return 0;
>>   }
>>
>> @@ -2754,14 +2775,22 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
>> *adev)  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>>   		struct amdgpu_ras_block_object *ras_block_obj)  {
>> +	struct amdgpu_ras_block_list *ras_node;
>>   	if (!adev || !ras_block_obj)
>>   		return -EINVAL;
>>
>>   	if (!amdgpu_ras_asic_supported(adev))
>>   		return 0;
>>
>> -	INIT_LIST_HEAD(&ras_block_obj->node);
>> -	list_add_tail(&ras_block_obj->node, &adev->ras_list);
>> +	ras_node = kzalloc(sizeof(*ras_node), GFP_KERNEL);
>> +	if (!ras_node) {
>> +		DRM_ERROR("Failed to allocate ras_node");
> [Tao] dev_err is better.

You should not print error messages after failed memory allocation. 
Out-of-memory errors already produce noisy log messages of their own. 
checkpatch.pl warns about such redundant error messages with "Possible 
unnecessary 'out of memory' message".

Regards,
   Felix


>
>> +		return -EINVAL;
> [Tao]: how about return -ENOMEM here?
>
>> +	}
>> +
>> +	INIT_LIST_HEAD(&ras_node->node);
>> +	ras_node->ras_obj = ras_block_obj;
>> +	list_add_tail(&ras_node->node, &adev->ras_list);
>>
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> index a51a281bd91a..a55743b12d57 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> @@ -493,9 +493,6 @@ struct amdgpu_ras_block_object {
>>
>>   	uint32_t sub_block_index;
>>
>> -	/* ras block link */
>> -	struct list_head node;
>> -
>>   	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>>   				enum amdgpu_ras_block block, uint32_t
>> sub_block_index);
>>   	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
>> --
>> 2.25.1
