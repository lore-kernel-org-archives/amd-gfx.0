Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C338DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DC610E124;
	Fri,  4 Feb 2022 18:12:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F8B10E124
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az77Dyk9eguLN3PMP32Wuqas4UT90J47NeVnye5P7pdMw7J9DV2ZC2gfOpp1mce0VqyKE2PUGaQf7aoP1TcpFR5F6t9JyRQa+dZsro0Vdlx4sJopsu5ZP1opBdmyPsXeQCKKg55GsBJEXlzeuciWN4vWFb/DXiF5iUtzdtP0e3oTTA/dVKJunDEyg98jlnehnGDP1GBRs4WGKQ6GFyeALMFthCyftzBf7+Mev4Y9f1LCFnpo84HuEhPI5Q6vjlLUU2cmIzkT+id9gt3e88V7bMaMg+3g4yuxyjCctVOssPH1OzUcJsb8O5LgksXojp3ODtDGeQ4isdsMeUUXDXcuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KYwt6raq0BalJfGRh8zkaAgKi9pbJF7gherkQQZUBQ=;
 b=arijlsyqLzX8OvQ4m4Tn6vEctnzdAouAEt/zsl+lyYhgApNHSjLMqYVOguD8zL2RsKdnpLbLFG3Nk57IZlg7uTTHqYzRmm/4am+LqT8JUat8XfNSo9CYUZVTlYObYKfiA0Ne4viS5E9OK049b5kPaR1tM6XFLUk/aRmFrlWZHn3n5CxxzIdR5GBZjS6qcVt+eDHFuDn8e176TZP4hkjTZENeUQLrBmhDzFOXRp7GUyiiUTs4r32RmPq8d1d4Ue8UMTwslNLlC5GO8glQcZ5SA0Z/3aS63y0pxTAnQwd8hPLW8g5d6iUltOfQzre1RYuva3gRbADkCuS4rJ8wNBzKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KYwt6raq0BalJfGRh8zkaAgKi9pbJF7gherkQQZUBQ=;
 b=0dQaXbxdYLb0NE90HVs+yzSr5GnGf0QAoxiWXrYCZpf6AxZlaPmG7Ik4Eso/Zqw+mRQ/oeC4Zrab7PvntK1ATw8iJQgpD1Y6S7QvUyqJHmWiOl3HtHAcW8e+qlAOKrmLuo0SiVCsBAKHBgamibX7U9RbDF7nYHWm2Eff60FF4uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) by
 DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 18:12:26 +0000
Received: from DM5PR12MB1531.namprd12.prod.outlook.com
 ([fe80::d01b:f78:ca43:12cb]) by DM5PR12MB1531.namprd12.prod.outlook.com
 ([fe80::d01b:f78:ca43:12cb%11]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 18:12:26 +0000
Message-ID: <668b5be7-de6c-4c47-9756-6452f316cd7e@amd.com>
Date: Fri, 4 Feb 2022 13:12:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
References: <20220204085201.30615-1-christian.koenig@amd.com>
 <32b9cdf2-3d71-4228-3471-38584575f41b@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <32b9cdf2-3d71-4228-3471-38584575f41b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:208:d4::25) To DM5PR12MB1531.namprd12.prod.outlook.com
 (2603:10b6:4:f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 775b81cd-f807-437b-9984-08d9e809e5e8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5278:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5278A2B5CB0FD6531AEAD212FE299@DM4PR12MB5278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5yZzWMeNPsgOUqvrpD5Dd8pOKV7A4cl+A50deSf5rUxTthFsr8KpHyv46Cd6dvtDyj2dN5ZdYu5pGMMfmS6l8QYN81p8tudhayCakmdBZg7Ki+QnQXalTZRJUgUpBCcz5oDctO5trU7pMcJrU6c8TVuTgFSD+9X9xm6jNIB5SmXs/CYCBZtpR1i/DW9M1LwW0aq/m1upWYpzfsN1fkvwgRWoY4S6H/0F0UDQ0QUIjrk32wvpi0LuHjy986+RXIIuLmQtGqGskCHI3s/wh5pb0XxBLz/PbKyO9dl5xTbfDp/U81PmsUXED4i+XLcN0H06YQDhErFELxzw+QOyKmTGDZ+lKYZQGcyhz6kdt6huRL4r972cB9o7pDBYITpKOXkVgIRDZ6TCM+Sg8ovNlYgWOIKRp8RpSYSjUkUUFdB/jF2wg96tBocmz6HmtfPshwjn/CGJCbpVFcfl0t6IZWBx3YX6dO/iER53Z6eTbqGBVwRL6BE01PhcfBn8Rl4jdi0jYgTZxccuLLMPd4uBtjKclxnf4JAiq3o60rvTS5nyYu3C6I002N1aE71GWmllZbI2sZv2LnyOIoC/BTvPwORkzC3TuijtLIYIGxHWkeIB0oXEuilDdOTLgNnX50ojcX/eunZyAk36YNXYIhbxG/Fnmf+bVmAqJ2bXgqC2zsiG3vXtFuluvABb0yHkGu8B+c15JiRRw+0JwJZN+318DPE8meRtgspW5Yhu9Jb4PfEqkOmoiam6cu8ZSciZ2JAgXUT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(8936002)(66476007)(66556008)(2906002)(66946007)(83380400001)(5660300002)(6512007)(26005)(2616005)(186003)(36756003)(53546011)(66574015)(6666004)(6506007)(31686004)(508600001)(86362001)(31696002)(316002)(6636002)(6486002)(38100700002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdTWXQyTmJxclpySktBUm0rRnpnMjBBdzg1bXlWL3hiWDBiUW5XRkxEc2ZO?=
 =?utf-8?B?MGd6aFJGU2hVUkIrUWMyb3ZITTNpNVg5Yk5XeG5yS204VkJCY291MU1oK3Vs?=
 =?utf-8?B?YWVFcmY0ci9IZ3FGcEppV085VFhxdTZMbGRYNHVON2JWc2s4bG9jL2Y1U1M4?=
 =?utf-8?B?blI5THBjNm5jZ0pZSkFSUnp4RkRVOXVlSHNuK2ppK2tMcmRnZGFKVE1QMllw?=
 =?utf-8?B?NnFQNk1ma3k2VndCdzZPVTNxR3dYbFE3czF2N3J3RmpqdXBjbkIvbEJYUjdq?=
 =?utf-8?B?MVo0N2J2VUxpd29IOWNKK25qSVhMMlZqNXlqM0xRM3FYNWpnTnB4emxrdXc0?=
 =?utf-8?B?WnM5M0pUcG9QcGs1R05aR0NidTdQUm9IY2dRUk1JNk9qNjUzaklWVitLcFlM?=
 =?utf-8?B?Z3BKd1pqU0ZSUy9zM2dRVUNTaXMzVWZZZXdnZ29YMGM4UExwUzlNbkNUdXhr?=
 =?utf-8?B?QjRmcHcxNS8zZ2dMTjg4OHcvME0yT1dQN0RzMFNjdXJlWDhJT3BMRC94Mmt6?=
 =?utf-8?B?ZTM3ZUszb0pqMDBhQ24wbDFiamFodVI1d3I5N1FlczluckpzOTRYL2JIZzA3?=
 =?utf-8?B?MTNoOWNQSThlcFc5WE9xeGkrYjBYenRGb3dEcEQ3dEQrUWRrSjVucmpSSXBa?=
 =?utf-8?B?Z0dYem8vK2Fab3MwMGFhcUl3QmZyYVJpVWh0U2cwTnIyWmZSdnFmamR5QmpK?=
 =?utf-8?B?dlh2ai96byt5VEIyc3BCMTJMVUxzcEhXd3VFTVJrOW84WmxGcUFsbmJFaTht?=
 =?utf-8?B?U1NRdDA2c25TQzFtWDE4RHFvai9kb1NQckJXZTR2Vk1rRENYQk5LSzh5NW9q?=
 =?utf-8?B?K3h1K2JxRkw5UXYrUm1pS2trckszU0FxTkpvNitwdGZleCtkZ2psbmhEcnRi?=
 =?utf-8?B?dUZNN2UzUVJtZnlTZG1zZTd3MUFLTzlsT3NCY3V6Q1VGZ2oxbi9wMVFrSGlB?=
 =?utf-8?B?bXBpRmdka3hUR21IdHRQdXB0UTFTRlhkSUc1cXhPSENqQk1VNG9EZ3V1eGx2?=
 =?utf-8?B?cFlrZDJ2OGgraThmYnJUUFlKK0lYV0FNTENpL3NJN29ESzdFOCs4RUUzMWt4?=
 =?utf-8?B?WVkvTTN5WWE1ZkEycVhBc1VBb1RtTmUwbWZ2M05aZ0dHSmg2eXA4dWdDRVpj?=
 =?utf-8?B?eFphSnFXU2ljc0UyRGk1S0FkUHpCbFlLN1F0MExNOFlFQWlMY2NEbzczOGh5?=
 =?utf-8?B?U0JZcG5veml3aWdlc3ZIT2dBQ1kwaHhISFAvazJjZ2tDUVZHM0k2U3NXVG1O?=
 =?utf-8?B?dFJWeFoyNkRDdzgxSEdNa1czRFAxVEJiRW8yT3FnUXNSb1FvSGVmbjB1TVc1?=
 =?utf-8?B?YldMY2M3NmsvYXVTUmVaSHpreVo5RzE2U2dYZXNNM2M4MTVhR2hicHIrNUFI?=
 =?utf-8?B?ckhsdWovbXErc1dHUlQ2V0gzQ0s2ZWdHYmpkenFMWVlrZ2NwbCtxNEtFc0wz?=
 =?utf-8?B?c2RMVWsvek1aamg0VW95NGZoSWNlZEYzUEUrYWdob0gxNVE0MXFKTnY3aDJJ?=
 =?utf-8?B?Vnc0dnk5RHJFU2ZYcmtSZytkMGVEMDhyNkQ1MEZNS2tpcWROenJ6L0NsbXJp?=
 =?utf-8?B?WXIvK3VuTlR1ZDNMR2ZWVmFLSUliRC81VEE0TEhUOXZia3JBdjRjMU1pQTdH?=
 =?utf-8?B?dUtNbThROWZXMXFEK3NMdU5kOTkzcDNDdEUrYU5HVkhXYXRwcGFzdUMzV2Q2?=
 =?utf-8?B?dnlKSC9PWHFIUTV4a0NDUllLRDFJZ0hyYjJNaVB4THFGdnlBMVJ5elQzSTVV?=
 =?utf-8?B?NUhoZmNaOWNBTm1INngvUlY0V0hWQ0NiNFRjZEN0N2hjQVl2SG9MM0lIeG9N?=
 =?utf-8?B?SXhOcmtrdHRqbFBaYzR4M3JEU1hmTnU5SHY0d0xYQVBLbGY3cWJhT1NrY3BP?=
 =?utf-8?B?eWlXTmp3NFE2ODIvL29NSXdzamFoMVYxRVNSUEtucmJ4TURpV3RCUE8zdnlQ?=
 =?utf-8?B?WGk3NmpaWHlObkJQWkZ2RlhNWC9aTTh5NWJFZk9EcGlUUmZleW05dWJzOTJ3?=
 =?utf-8?B?WG9rZWVGMTlWbk5ZcUhpdVdlR3I3T0JSVU5ocC9oZVBBQ0FoN2ZNSjVHeTI1?=
 =?utf-8?B?ZUh6d3FNQ2NRNVZINjByclFUdmNQNFpJVVFYZ25Md1M3SmV2ZXFFbkhyOWF6?=
 =?utf-8?B?aUIzdHRnejdFWXI2YXpUQ3B3ek5McmxsRXFNcVRLZFh0WkRYNk1zekRnZFBB?=
 =?utf-8?Q?3Xk6iTDoV/zoVGt8Hqizuyk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775b81cd-f807-437b-9984-08d9e809e5e8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:12:26.0461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93z1fEXOFy1gDjybJrC5aViU9weKb8yhB6WTwAa43HzSrzMoZae1O8H1Q3AWx3ASRq9CR3kqrzo+Q6hKXuCCYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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

[Sorry for top posting]

Hi Christian

I think you forgot the below hunk, without which the issue is not fixed 
completely on a multi GPU system.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dcc80d6e099e..6f68fc9da56a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2670,8 +2670,6 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
         struct amdgpu_vm *vm = bo_va->base.vm;
         struct amdgpu_vm_bo_base **base;

-       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
-
         if (bo) {
                 dma_resv_assert_held(bo->tbo.base.resv);
                 if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)


If you chose to include the above hunk, please feel free to add

Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 2/4/2022 11:27 AM, Felix Kuehling wrote:
>
> Am 2022-02-04 um 03:52 schrieb Christian König:
>> Since newly added BOs don't have any mappings it's ok to add them
>> without holding the VM lock. Only when we add per VM BOs the lock is
>> mandatory.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index fdc6a1fd74af..dcc80d6e099e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct 
>> amdgpu_vm_bo_base *base,
>>       if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>           return;
>>   +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> +
>>       vm->bulk_moveable = false;
>>       if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>>           amdgpu_vm_bo_relocated(base);
>> @@ -2260,8 +2262,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct 
>> amdgpu_device *adev,
>>   {
>>       struct amdgpu_bo_va *bo_va;
>>   -    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> -
>>       bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>>       if (bo_va == NULL) {
>>           return NULL;
