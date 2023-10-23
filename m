Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D297C25B67
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 23:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C159710E29E;
	Mon, 23 Oct 2023 23:41:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA81310E29E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 23:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYOpOz/Cp3vMtINA52SxSvmSBVvrX9scOhTjXbQ7ZlqH/569TId1j0C1kyxE5t0xRvt7YxlBsdg6AZ9AqmzAFm+7yZXZX4kTRuWfkPNHzb+tz3o9jeAfo27zuZnTaCATuv8N4L/dTZOX497dZ83Ed+pgOBkXofWPXV9+o+1R8fygR1UqmccLmxyzn8I6aXwUkKQONKvQyS7xcyaOr52v2YFkTIjFNM7zWMIRWfYnoc80wu9KKia7VYtntgFhcZ1CvnUJ/5Q/t80nzuPmDny/B30hTDNiPUf/uz3f9L2TzKl1TGPA86DE77dZ4aLSQwIHwl5+XqHhuI6AEsQ3AWROxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUWVwkI1Gr74QvCRJiR2ADKBnqVa6LNLWUtrsIlY2xg=;
 b=G8BVBLDt5OwfBIES/TfpOoD4nqypiZiqR7pOs0pV77BdcNhf20cIPJFQJ3hFwJ4yBM+NSsfksEPdTNHFObgCMKm1WXol53vks1xWWxCpXPU8mvDwKgTy1ZtdcSLHgSlKAOdXncumz5mxQEAvVJ3ANNfVeuljjeb7CgFrnmJy5Dp0LmpnhcQxVwsGHEJIgyNPixiktrptJ+lUjEbIAUsfsoosrI//eSNuUvBzQ1gwI0uAoSCt1CYrgJHcp1xQcwnExDAJLRySK9TK5cPKVRXXKk1T+VHPrULjZsnFn/ZucDQNzk28qtHUHZkGdxMUP74KQb1wRG/3g6OIk2muWxE/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUWVwkI1Gr74QvCRJiR2ADKBnqVa6LNLWUtrsIlY2xg=;
 b=1YBqB/0cOty+4+vtsRY9/O1p+/YMV4+iixwV6PWJQfIM2LjPpS8cjHedNU1UtMaiw4QMfYQj6aZbbIESs7iA1KfoCfTpB7Z18TbBqiZymbWAGUThE0RXOacBWeWtuEx8VdYptONNXCJIlRqcCb9OBrhOqI43Mj21GEKfSA8zIVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 23:41:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 23:41:38 +0000
Content-Type: multipart/alternative;
 boundary="------------k4YFvjt734FE2BiQs9NNv0sN"
Message-ID: <5e2c00e0-5d9c-4583-95ab-a0929e01e877@amd.com>
Date: Mon, 23 Oct 2023 19:41:36 -0400
User-Agent: Mozilla Thunderbird
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Daniel Tang <danielzgtg.opensource@gmail.com>, amd-gfx@lists.freedesktop.org
References: <5984374.lOV4Wx5bFT@daniel-desktop2>
 <38742906-869c-4bc6-9cce-ea3ea98873d4@gmail.com>
Content-Language: en-US
In-Reply-To: <38742906-869c-4bc6-9cce-ea3ea98873d4@gmail.com>
X-ClientProxiedBy: YQBP288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 877b11a4-7753-49fd-e774-08dbd42199d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzpnrMrnHkNGV39nL73VF9y2pddA6Xnwx/b41rHLBMcUfxW5vs5dHD0Zo90SBEplx93wEq0pAvQgL4yhJjM7GjE0ZQabPAhAxLxkTAmmEiaQPE+tFXni9NFfNasVk3I073MjSsYgALOzxQpCuGfwjW/EetVAIGjsfF9wKupmNSa6obQdZsydGv+vRxluoSGa4FXLuHWLShHdq6wHkiyduEgGB7kSj0Neh4bQXeXKw4nIGWQ6VUczLJn3awFCKn5XwzvtfGnha/gaGb+FJSRMf1wJ+i8o2po8e/b48e5YHwLh0EdpCDDKqdWhvK+RMFLLBNjf8RFLV5T6+zibw/E90jtaYU6AZ+WXYWIQAkqbJYUwvAARRsakJ6rtZcdpW0BgkcQwezn5LdgX9mUyq3HZEqEJkwXXIFEls2v78IETq/lI9p9jDilBw89lnDpaeyVIA6D8G37wpTXltMlKrb9wuS4rdilZQKl7jkWLtMTyRQi93aeFHb8bOt2ycW1BKzK/0SjICnnHrLF6VMbzBL+TUmztCQeg/sDlfOeUF4pNaQWq4dz/Us0YFKpLWoYxR1YWjlZ3tGAHBNudEhxIcitHIqP8X98dBqT6aoPObMgAd0xc5x6PEUV4WCbFXJQ0abnyhoR8Ur74hGCm6wu3CQoY9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(31686004)(4001150100001)(38100700002)(166002)(2906002)(41300700001)(44832011)(86362001)(5660300002)(36756003)(31696002)(4326008)(8936002)(8676002)(2616005)(66946007)(6506007)(54906003)(33964004)(478600001)(110136005)(316002)(66556008)(66476007)(6486002)(83380400001)(6512007)(66574015)(966005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxxZVAyWVFQdkdKSk1DbVJUN0FwTHlnZ1F6TXZYTG1vcWo1UWdzSXgzaFl4?=
 =?utf-8?B?dTZoTGRXYlBRWVY2S2lCSTZrWlN3TUdwdGZudmlNR2dPazdaSHNSSzhQbjVa?=
 =?utf-8?B?N2FOdmMzV0hIVVlpdUZrVko3bVZUQkFURkZWV0kyaXU2RmNpV3dCR0h2SFVD?=
 =?utf-8?B?KzdseDBiMDNRWjd5YkppUm9GMU5EckpOSkZyY0RxbnM2RHFEazBTWmxoUmh0?=
 =?utf-8?B?MkxVNTNLa0FQczZPRVB2UThuVTBxUkYvOGFMRGwwdVN0M0J1YmVFQ1RiVzBF?=
 =?utf-8?B?YUtnWW4zUWxsdGpISU1LcFc5OHdRbmFuM2lybjRNQWtNS3NabVJaVFpleTZI?=
 =?utf-8?B?VFZDdDdGOFJRbmlSYlk2Sm9qamw2L3hCRXdPM2R4M09SVzlkSThkaVR3eVBy?=
 =?utf-8?B?S0IrNXIwSG9NM0pnUGlMSmpxQnJqWnBaR3JYWjBlVXF2S3d4WC9BZ2dqVTR3?=
 =?utf-8?B?OENUNFF1SjZQdzNGZDBJTS8yVjFnT3dyd29kU3JIN2RqeHdwTjdqNHhreEt4?=
 =?utf-8?B?bEJCQkxXM0NzNkdCemZ1ei90cUM3YUQvQnpZOWdVSEwxak9IYUpKQk1RdFFW?=
 =?utf-8?B?VlVzd2pzVU4reXBoSEZPcE9VQXdGSHlqUDRteHBHVkxFL3dUOWNDU09DN0Rl?=
 =?utf-8?B?a2xQd20yeGd0SEREQWNnVkdKck9PT1RMWVVxTS9RK2V3Wno3bzBIWUpkK2FC?=
 =?utf-8?B?OGZ0dlJmVStmcVBTM1prYzE2d2xCak5PL0lCMVVSaHNSKzhYU3dEWE5NbzIx?=
 =?utf-8?B?TTNqUlRHQW91VWZHMUlaNS8yek1JdGlXY2pyNW1tdjRlcCtoYWFZci9DeWtk?=
 =?utf-8?B?K01pNHRCVnU3MjlzQmNleVZDSUJ4Ui9uempualNnTGFubkZIbzFtV1R3NHBP?=
 =?utf-8?B?aTVGZmlRc1RNRG0yUTZMZTRxa2ozYUZCMVJ3TVRpY3lyNWtpM2dXOXl2cVJT?=
 =?utf-8?B?RDZkdXpDS1dFU2V2MnNqUVFMRnRqMzc1cDM4aEZGbDhBTUMxeHNiUXl3bzdj?=
 =?utf-8?B?a0NVSFhTbUhPRDdabHYzdWl4dXlKaTNMdUdnOTdmeWp5Z2ErbTdGSGhBU1pU?=
 =?utf-8?B?RGRkNnBqYVkyTFVQTlZkbW9oWHhiVzhscXVyT3N6ZmRFbktWek51akRibjc5?=
 =?utf-8?B?VTlqVnRKVUQ4bEtqT1BFdnBxTjRzRkhTMXlqcmdDMDNRbUVVbWt5T0lhSUJS?=
 =?utf-8?B?U0VkOVVDQUxMa256TXAxOE1wWnNsd1M1dS9iSTl4TGxIZjc0S0hOcDdndFA2?=
 =?utf-8?B?Q085ekFmKzVDUWpBODR5L3FaS3NEVG5YVUNrOUNjVW9GU1M2TUo3clRUazVG?=
 =?utf-8?B?NE9OUllycGcrMEVDUEo2WEpJT0MrT3h0c1FhUnlvYzNKMVFZVml2QkozRW0x?=
 =?utf-8?B?b2dXOVJOQWtNdVNOazc1a3BnZjNURHoxY0x2VVBQTFdPWkUvUzhFaDlRL0Qy?=
 =?utf-8?B?Y2dsWVZhR3lNUE5rZ041bHJEZmdRU1YzQkVKNUYzeTZEVmtUZmJiTnR1Vllp?=
 =?utf-8?B?Ym83SENvSUIrRHNneXdrYUFKeUdqNDJLS2R6cnFvUWtpVFgwcnhSUy9ibXZM?=
 =?utf-8?B?b0dQOEF1eW5ZUnhIL2ZCRDBZaCs3UVRvWG44VlJ1Z1BLV0hpVWZORDN5Smov?=
 =?utf-8?B?VlZKdmZrelVmMFAwQ3hRZW0zL1NBQWZNeXE4YkZ2NkpCencwV0xaNXBxSjdw?=
 =?utf-8?B?eFpsaVN6dk1QdEtPdjZsa0NDL3ZhTHZ4SWlCVFozMHIzVHVVdm9uZFNPSGFa?=
 =?utf-8?B?c29FN0t1Q1VRMnR4bFFGNlVGcTZVWkpnT3FMYkRrVFp2ajkxOHB4ZDFvZkxx?=
 =?utf-8?B?NG1WY0V5YlB3UDAxUHkrSXBHTllQZy9JaEJ0alpzaFNlOUJOTFVGa0I5aU9J?=
 =?utf-8?B?QXlnMExPNkZZYS9xMU4vclR2MzYyTG5DWmV6WmJaeE8raVdOYytMd0RnT0Fh?=
 =?utf-8?B?SWxlM1BKZ0JMRjZSUEZhTysrdUE1VmpML1N1WWUyRitpVUtzOWcwZ0k1N0Nh?=
 =?utf-8?B?M01QaVkvS2NER3VtSERqMEZGNFR5NVRCZ1dGOUdSQ0RlS3RFZDFqYUVRMTEw?=
 =?utf-8?B?bnhaOUcyOC9UOFNDMVQ4UDhBZkFzbGFlQW1ZaDArQ3RySzMreVR5c0ZNQWZI?=
 =?utf-8?Q?Hsh2L1/9m9xmqcrBpQI9PrYad?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877b11a4-7753-49fd-e774-08dbd42199d1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 23:41:38.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpCwyniIFJoUiBFFFfGzRbpEsn/Iw702+QjR0uN5CgN8ApoI+qYmouR5ODXkKo/oo6FGYYgJIs9m5B4tpu+/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------k4YFvjt734FE2BiQs9NNv0sN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[sorry, I hit send too early]


On 2023-10-23 11:15, Christian König wrote:
> Am 23.10.23 um 15:06 schrieb Daniel Tang:
>> That commit causes the screen to freeze a few moments after running
>> clinfo on v6.6-rc7 and ROCm 5.6. Sometimes the rest of the computer
>> including ssh also freezes. On v6.5-rc1, it only results in a NULL 
>> pointer
>> deference message in dmesg and the process to become a zombie whose
>> unkillableness prevents shutdown without REISUB. Although llama.cpp and
>> hashcat were working in v6.2 and ROCm 5.6, broke, and are not fixed by
>> this revert, pytorch-rocm is now working with stability and without
>> whole-computer freezes caused by any accidental running of clinfo.
>>
>> This reverts commit 1d7776cc148b9f2f3ebaf1181662ba695a29f639.
>
> That result doesn't make much sense. Felix please correct me, but 
> AFAIK the ATS stuff was completely removed by now.
>
> Are you sure that this is pure v6.6-rc7 and not some other patches 
> applied? If yes than we must have missed something.

This revert doesn't really affect systems with ATS. It moves the sanity 
check back out of the ATS-specific code.

The Null pointer dereference in the bug report comes from the CPU page 
table update code:

[10089.267556] BUG: kernel NULL pointer dereference, address: 0000000000000000
[10089.267563] #PF: supervisor write access in kernel mode
[10089.267566] #PF: error_code(0x0002) - not-present page
[10089.267569] PGD 0 P4D 0
[10089.267574] Oops: 0002 [#1] PREEMPT SMP NOPTI
[10089.267578] CPU: 23 PID: 18191 Comm: clinfo Tainted: G           OE      6.5.0-9-generic #9-Ubuntu
[10089.267582] Hardware name: Micro-Star International Co., Ltd. MS-7C37/X570-A PRO (MS-7C37), BIOS H.I0 08/10/2022
[10089.267585] RIP: 0010:amdgpu_gmc_set_pte_pde+0x23/0x40 [amdgpu]
[10089.267820] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 48 b8 00 f0 ff ff ff ff 00 00 55 48 21 c1 8d 04 d5 00 00 00 00 4c 09 c1 48 01 c6 48 89 e5 <48> 89 0e 31 c0 5d 31 d2 31 c9 31 f6 45 31 c0 e9 89 7e 27 fb 66 0f
[10089.267823] RSP: 0018:ffffb49805eeb8b0 EFLAGS: 00010246
[10089.267827] RAX: 0000000000000000 RBX: 0000000000200000 RCX: 0040000000000480
[10089.267830] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9890d4380000
[10089.267832] RBP: ffffb49805eeb8b0 R08: 0040000000000480 R09: 0000000000200000
[10089.267835] R10: 0000000800100200 R11: 0000000800100200 R12: ffffb49805eeba98
[10089.267837] R13: 0000000000000001 R14: 0000000000200000 R15: 0000000000000001
[10089.267840] FS:  00007f8ca9f09740(0000) GS:ffff9897befc0000(0000) knlGS:0000000000000000
[10089.267843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10089.267846] CR2: 0000000000000000 CR3: 00000002e0746000 CR4: 0000000000750ee0
[10089.267849] PKRU: 55555554
[10089.267851] Call Trace:
[10089.267853]  <TASK>
[10089.267858]  ? show_regs+0x6d/0x80
[10089.267865]  ? __die+0x24/0x80
[10089.267870]  ? page_fault_oops+0x99/0x1b0
[10089.267876]  ? do_user_addr_fault+0x316/0x6b0
[10089.267879]  ? srso_alias_return_thunk+0x5/0x7f
[10089.267884]  ? scsi_dispatch_cmd+0x91/0x240
[10089.267891]  ? exc_page_fault+0x83/0x1b0
[10089.267896]  ? asm_exc_page_fault+0x27/0x30
[10089.267904]  ? amdgpu_gmc_set_pte_pde+0x23/0x40 [amdgpu]
[10089.268140]  amdgpu_vm_cpu_update+0xa9/0x130 [amdgpu]
...

This revert is just a roundabout way of disabling CPU page table updates 
for compute VMs. But I don't think it really addresses the root cause.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Closes: https://github.com/RadeonOpenCompute/ROCm/issues/2596
>> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 82f25996ff5e..602f311ab766 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2243,16 +2243,16 @@ int amdgpu_vm_make_compute(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>       if (r)
>>           return r;
>>   +    /* Sanity checks */
>> +    if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
>> +        r = -EINVAL;
>> +        goto unreserve_bo;
>> +    }
>> +
>>       /* Check if PD needs to be reinitialized and do it before
>>        * changing any other state, in case it fails.
>>        */
>>       if (pte_support_ats != vm->pte_support_ats) {
>> -        /* Sanity checks */
>> -        if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
>> -            r = -EINVAL;
>> -            goto unreserve_bo;
>> -        }
>> -
>>           vm->pte_support_ats = pte_support_ats;
>>           r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
>>                          false);
>> -- 2.40.1
>>
>>
>>
>
--------------k4YFvjt734FE2BiQs9NNv0sN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>[sorry, I hit send too early]</p>
    <p><br>
    </p>
    On 2023-10-23 11:15, Christian König wrote:<br>
    <blockquote type="cite">Am 23.10.23 um 15:06 schrieb Daniel Tang:<br>
      <blockquote type="cite">That commit causes the screen to freeze a
        few moments after running<br>
        clinfo on v6.6-rc7 and ROCm 5.6. Sometimes the rest of the
        computer<br>
        including ssh also freezes. On v6.5-rc1, it only results in a
        NULL pointer<br>
        deference message in dmesg and the process to become a zombie
        whose<br>
        unkillableness prevents shutdown without REISUB. Although
        llama.cpp and<br>
        hashcat were working in v6.2 and ROCm 5.6, broke, and are not
        fixed by<br>
        this revert, pytorch-rocm is now working with stability and
        without<br>
        whole-computer freezes caused by any accidental running of
        clinfo.<br>
        <br>
        This reverts commit 1d7776cc148b9f2f3ebaf1181662ba695a29f639.<br>
      </blockquote>
      <br>
      That result doesn't make much sense. Felix please correct me, but
      AFAIK the ATS stuff was completely removed by now.<br>
      <br>
      Are you sure that this is pure v6.6-rc7 and not some other patches
      applied? If yes than we must have missed something.<br>
    </blockquote>
    <br>
    This revert doesn't really affect systems with ATS. It moves the
    sanity check back out of the ATS-specific code.<br>
    <br>
    The Null pointer dereference in the bug report comes from the CPU
    page table update code:<br>
    <pre>[10089.267556] BUG: kernel NULL pointer dereference, address: 0000000000000000
[10089.267563] #PF: supervisor write access in kernel mode
[10089.267566] #PF: error_code(0x0002) - not-present page
[10089.267569] PGD 0 P4D 0 
[10089.267574] Oops: 0002 [#1] PREEMPT SMP NOPTI
[10089.267578] CPU: 23 PID: 18191 Comm: clinfo Tainted: G           OE      6.5.0-9-generic #9-Ubuntu
[10089.267582] Hardware name: Micro-Star International Co., Ltd. MS-7C37/X570-A PRO (MS-7C37), BIOS H.I0 08/10/2022
[10089.267585] RIP: 0010:amdgpu_gmc_set_pte_pde+0x23/0x40 [amdgpu]
[10089.267820] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 48 b8 00 f0 ff ff ff ff 00 00 55 48 21 c1 8d 04 d5 00 00 00 00 4c 09 c1 48 01 c6 48 89 e5 &lt;48&gt; 89 0e 31 c0 5d 31 d2 31 c9 31 f6 45 31 c0 e9 89 7e 27 fb 66 0f
[10089.267823] RSP: 0018:ffffb49805eeb8b0 EFLAGS: 00010246
[10089.267827] RAX: 0000000000000000 RBX: 0000000000200000 RCX: 0040000000000480
[10089.267830] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9890d4380000
[10089.267832] RBP: ffffb49805eeb8b0 R08: 0040000000000480 R09: 0000000000200000
[10089.267835] R10: 0000000800100200 R11: 0000000800100200 R12: ffffb49805eeba98
[10089.267837] R13: 0000000000000001 R14: 0000000000200000 R15: 0000000000000001
[10089.267840] FS:  00007f8ca9f09740(0000) GS:ffff9897befc0000(0000) knlGS:0000000000000000
[10089.267843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10089.267846] CR2: 0000000000000000 CR3: 00000002e0746000 CR4: 0000000000750ee0
[10089.267849] PKRU: 55555554
[10089.267851] Call Trace:
[10089.267853]  &lt;TASK&gt;
[10089.267858]  ? show_regs+0x6d/0x80
[10089.267865]  ? __die+0x24/0x80
[10089.267870]  ? page_fault_oops+0x99/0x1b0
[10089.267876]  ? do_user_addr_fault+0x316/0x6b0
[10089.267879]  ? srso_alias_return_thunk+0x5/0x7f
[10089.267884]  ? scsi_dispatch_cmd+0x91/0x240
[10089.267891]  ? exc_page_fault+0x83/0x1b0
[10089.267896]  ? asm_exc_page_fault+0x27/0x30
[10089.267904]  ? amdgpu_gmc_set_pte_pde+0x23/0x40 [amdgpu]
[10089.268140]  amdgpu_vm_cpu_update+0xa9/0x130 [amdgpu]
...
</pre>
    This revert is just a roundabout way of disabling CPU page table
    updates for compute VMs. But I don't think it really addresses the
    root cause.<br>
    <br>
    Regards,<br>
    &nbsp; Felix
    <p><br>
    </p>
    <blockquote type="cite"><br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite"><br>
        Closes: <a class="moz-txt-link-freetext" href="https://github.com/RadeonOpenCompute/ROCm/issues/2596">https://github.com/RadeonOpenCompute/ROCm/issues/2596</a><br>
        Signed-off-by: Daniel Tang
        <a class="moz-txt-link-rfc2396E" href="mailto:danielzgtg.opensource@gmail.com">&lt;danielzgtg.opensource@gmail.com&gt;</a><br>
        ---<br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------<br>
        &nbsp; 1 file changed, 6 insertions(+), 6 deletions(-)<br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
        index 82f25996ff5e..602f311ab766 100644<br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
        @@ -2243,16 +2243,16 @@ int amdgpu_vm_make_compute(struct
        amdgpu_device *adev, struct amdgpu_vm *vm)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /* Sanity checks */<br>
        +&nbsp;&nbsp;&nbsp; if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo;<br>
        +&nbsp;&nbsp;&nbsp; }<br>
        +<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if PD needs to be reinitialized and do it before<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * changing any other state, in case it fails.<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pte_support_ats != vm-&gt;pte_support_ats) {<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Sanity checks */<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL;<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo;<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        -<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pte_support_ats = pte_support_ats;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_pt_clear(adev, vm,
        to_amdgpu_bo_vm(vm-&gt;root.bo),<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false);<br>
        -- 2.40.1<br>
        <br>
        <br>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------k4YFvjt734FE2BiQs9NNv0sN--
