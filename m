Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E9AC61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 21:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EC810E0D9;
	Thu, 23 Nov 2023 21:23:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3F810E0D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 21:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+gZ3KLlsoQxKb8b317qtiX/pO8uHOHBWbnCvIaLij42CWxgdQ6st4c2zVus8NYUVJoljm3ODzqJT+brq6j1q/B1dDtnQT4OlWjexyALOIBsaS5I3AkcCwwW3+UM5Lu3YRuhDtgYkjYsxHLD9RqSgUqrtSbsqNEAEp0moGFt3H0Jf7hujyustyNDKnq51ERhbN3vdkbTuvpFacJArBpdhUhwE5wz0JiC1E3Utz5JdafySPYTySNMlaHVNIwhsJidN6qZ+Y7MjSORFhj1SLREMccm/xQsmjXJABkuIkpI0QrywCa147b/TC5RDPbzMifAAWBQE82t3AXvNZi+C6c7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG1Ioik3p4q2uVC9LJpOiU1PxlZ+AlVrZMjb5HfL0Sk=;
 b=buM4THjGH0+LgZrOB1EDNHvuYXAY7T7UyavDvNZcT6ZUKEgww335VYodtwbfc1t55rUbOwm2AIDh0PdxhIJPYU1URtvfNdE+bf761QIWzkJMwY+10UqeKx4Sqe8hqI63oJwRmzQqXpM0ZwYXS2VSmpJlZwZRfCt3SKNh/c8Iahw7NYUtCVwjVrd2xsmRO6tKz1961JJGC74u55a7Jn8E7rmDI2HOgNdz6hpPPhbMPWC0MhzXR6fgcjc6X+hoMXpluc8f9BC72KwLnHgxez8wLprSCp6GfqwgrXIKlEFBICCrpCd1LT4RboS3XCUHVam8H6SBUPRcpGK04IWCoIDisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG1Ioik3p4q2uVC9LJpOiU1PxlZ+AlVrZMjb5HfL0Sk=;
 b=e6QfewX1rsqMWTpsZYM+nsxkALoa5gfqPmCZQaookusRgoqR6BWjCrtEeQ6uLX2e/s4VqL/0qK7pvL7cKrL48UdWBb1mLaRhmzHVW7eXWNom+7pSQt8VEdPAeSSuPR5Fp4PJTbIVtMa7b+MT7EnIxBjjRDdvCKS63zV4R8xrOFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 21:23:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 21:23:08 +0000
Message-ID: <04ec0f68-36e7-4dca-b75c-9dd98d78db69@amd.com>
Date: Thu, 23 Nov 2023 16:23:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231107220540.3711990-1-Felix.Kuehling@amd.com>
 <DM4PR12MB5165AF7B85556C13497C405E87AEA@DM4PR12MB5165.namprd12.prod.outlook.com>
 <DM4PR12MB5165B2A20C60872AD4AA1F0787AEA@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <DM4PR12MB5165B2A20C60872AD4AA1F0787AEA@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e99d47-7263-4912-ca75-08dbec6a633c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+DL1WvWIYh6ruEn/ic8TCYaKVts+sqZixUEvGrnQoJPO4ZCVZspX3GlPPgFEiCfvSQC9VXgI+rYoO3QeaQMcRArQ8c8CYvKnGr5uu/PH/OtD4qYihky5FR6BidtVraUm63zNuU4gzmUIDfH0GaqmK5fhi3VLiPKEel+PcxwEm8IsYO8mGJiw+rKifPvNQv6JucHTSB8mCR2aPdadH48m4VLTEwFqst/sIiZeGuLiY0c/j1CZad3tkfS/JyWihR9qkPMIJk14uwyXrFIulDqBu8b2Sb/HGqy1e+edZ9evOokZu+Ino4BoKgkomj8atU7MNcBtdqK9RQwhzj7g6FZgh83ibzzS4Url0lYfz5cUlZkc/TETyAOdwsznYbGrwlvOIYMRZa0JSbGg6gAVXhYxP/Z7+AQzKxSzIzRFDvHTwxSFY8C88S63y2u7imstS1cAqvTx3OeTFdixyO4Gltd5BdyO04i4ksNn4181ge1Gucebis8WKnEgDPt9OvOGr1fVp53sDOQERPIpW+hVnmQYF0ssI/w0FLTxkhJW46kBKtQCMoG/4ZhM4Lkwc1iiNNsIa1BNDVJph+186P6LxgUSCzVZ++jFtkWghYzgcbyyQXvUHWtLVrng8nSoAdpzFy+JkWzIF5905rUszt7kYPtQmEcCS7YK+xarB6paVKIihnKDlIutyfQVs4ZFzokojiw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(26005)(2616005)(45080400002)(6512007)(478600001)(36916002)(6506007)(4001150100001)(44832011)(2906002)(30864003)(5660300002)(66946007)(110136005)(41300700001)(66556008)(66476007)(8936002)(6486002)(316002)(8676002)(4326008)(54906003)(53546011)(38100700002)(31696002)(86362001)(36756003)(31686004)(66899024)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFdta3M4ZkVMcWhTekppK1RON2c4bTdpaG1WUzBmSzUrZWFsMndxWWVCSnM5?=
 =?utf-8?B?dzdDaUx2bCtrY3ZiUjBkWGlrL0puL3ZnRUZYdU1zVW4wVkVBRG50SU5vcitO?=
 =?utf-8?B?UVkvZ2dTclZVYlduMjBCUXN6U3BvSVZVemFQQys0Z2ZTTU54eWlEK0wxMTl4?=
 =?utf-8?B?L1hTVUpVQ1B4aFlsQWkzVFZxRUtaNmh3dm40ekUrSGpkVHBYN2RBa0dMb0xh?=
 =?utf-8?B?cmVFSWNkM1ZGa29yb0cyMEd5S09xM1VaRnE4NnczUmMyZFp4R3JrdHhuYTBo?=
 =?utf-8?B?UzA0TzBLQjdoNkpxSFdaZUZoOUU1TVVsT3JVSnQycnpFWk8xS3loRzhRMllH?=
 =?utf-8?B?NVBRTGxua2JoS25PdXlGd0Fxc25XeEFFYVl4RlZkemxCcnNKcUpxMVQ1R3dV?=
 =?utf-8?B?VyttaFAxUFIzZnhlZXpvQ051NVc1M0cxMk1vV3ZCZ1pMQ3l4RDJzZThUNVRO?=
 =?utf-8?B?dDh2eFlPSEJmZjhhYjd6UHdDSmN4Z09odStOak03YVU3eE1TbDA2ZHM4VmtH?=
 =?utf-8?B?UnNtOE5GZk1KNW1QYTMvczh1b0RKWUpQNTFlanFmcDNLSDY5WFF3RHBCemtI?=
 =?utf-8?B?Y2I3cUtCN3VQUzh0RmhSdlB1Z3pkWGVuQXg0bWNodldldkJjTmpsOXlIUE9h?=
 =?utf-8?B?UDJEL2lzU2UzOUxhZDNhVTVMNk9nV2pUSU1iMWtMUFUzazdTTU1jbDc4djV1?=
 =?utf-8?B?VXBMMG85eGFxRk0zS25PVUtoU0JIdnZzUEdQTXg1dWRvU3V0Q0xqTXJYc0tu?=
 =?utf-8?B?aW5zOUo2NzhJM2FJdUhxeUVxSnEzbURnUUc2VWVQbGwzbCtIRVNTNVJXQlpE?=
 =?utf-8?B?cFVmZDRPN3JJMk5hczZDY2tUZS9Ndkk1WWVCb2tyMkxDWE9QeDBCTzl2V2VD?=
 =?utf-8?B?QkJoRXo4UXI2R3FrQkdKSU1ySHhUZE5GL0VoOVVIWXhRbm1abW9UeWM0c1RH?=
 =?utf-8?B?NzIyQ1h3YXhQTVZ2NVNoeXRLMW95dC9BRFdIamxDYjNVNFA0U0lUUDNyb2Z1?=
 =?utf-8?B?M0h3Skd0ZXV5ZEtIcTg0V0tZc1BXU0lncWNsVlhRbHpOM2RWdVRSazI5MkpI?=
 =?utf-8?B?T1BFVWRkT1k2d1J4bWNteUIyMVJzQzMrTGFuSHBkTU4zQTYzMVMvT3V6TTJz?=
 =?utf-8?B?RUFib2ZWaSs3TWRodG1mU0UvTzFCKzBRaU5zb01BUHJ1dGVzb01mejVYZkRo?=
 =?utf-8?B?ZnhZei9kM1d4SmxwNVZwUmYyYWFNQjVUYjBvc1VlbExxcmdMN0N5WEY4b1dW?=
 =?utf-8?B?WmpJZ0ljR0lTakNVaUhCUDVWcHd0cFZqVnR2eFVaSnBlcFNQcExZb20wMENY?=
 =?utf-8?B?U2Yvd2Z4Sng0ZFhRS29pZHd0bmRpeG1TVHMySUZTSmh0VFNKN1VkVjQxU1lY?=
 =?utf-8?B?S0NtWnV2Sy90cGw0d2VIYjB4NkpqdUtDRHhVQkNJQ2tWYWV3RE5HdEVFU3dS?=
 =?utf-8?B?TTFYTDdMU3ZQRTZydlZLRHM5QVlRV3IybUNVV254TVNNaUVuMnBsekk3YnMw?=
 =?utf-8?B?SU5XZ3p2cGxYSlBCRHV5bU1kKzY5Sm9ZUU1ndnhhZ2RIenROckhaeFVSSDl1?=
 =?utf-8?B?MkV6OHBySUs3Y3BZMVBpUDlHNWVGTG5HS28rM0pXZGZGL200Z0VmMjZzT0lE?=
 =?utf-8?B?bkpjTHAzMGtGeVdKUzcrM051cVp1S0FFcmU2YW1CaEtTOTVmaE8raXMrS01a?=
 =?utf-8?B?YUdmaEVabktQb09CdUlPcjQ2VlZ2b2htUExsc1EvaGFuY29XUnFnUlBBa2ha?=
 =?utf-8?B?S3Y1UmhLdTVHT0xzeGhtbTNsajlqSFUrVldYQnVDZlRjRWtPM0JjalhKWEZi?=
 =?utf-8?B?dFNBb1BoK1VZa00rSjdJYnRBRU9EZlY2SGlSbnhBTkNVVFpTazFWZmM2YXpG?=
 =?utf-8?B?QThIbnFOOFJpd2pQTUNzb2xSc0FGVVk2NC9odmNCbEg2eVR1b2c5Y3BqU1Ni?=
 =?utf-8?B?UnVaaENjOWdzOW1OMEhST0hSTjVWNERGcUFnVCtlOGU3eDBVbHpEcGNwNnhD?=
 =?utf-8?B?YjNSRWZ0S09peDZDbnFCSmQzZ1JKVFltVHFOdmhQdVBUYUltNDYya243MVpX?=
 =?utf-8?B?TFNzTVVUL3JOZ2duQkFmSmRqN21yeTZjTi9Sak1IeldZcnBCMEUvbWxmQ29z?=
 =?utf-8?Q?tTy7vIaLqk9x9S0bgfRfsk2c7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e99d47-7263-4912-ca75-08dbec6a633c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:23:07.9865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gt+ePx+HNuIrBNfGTzORUV6VoSV6re8mZ6ijVgFVdog4RTlWvKrnzQSxLToGO5YIlcOI2oyajaEt1CMcVQ2yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-10 07:07, Pan, Xinhui wrote:
> [AMD Official Use Only - General]
>
> Wait, I think we need a small fix below.
>
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2036,6 +2036,7 @@ int kfd_resume_all_processes(void)
>          int ret = 0, idx = srcu_read_lock(&kfd_processes_srcu);
>
>          hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +               cancel_delayed_work_sync(&p->restore_work);

I think this would also be problematic and not race free. Restore work 
could be scheduled again between cancel and restore_process_helper. A 
better solution would be to deal with the situation that I already have 
an unsignaled eviction fence. I'm looking into this right now. I hope to 
have an updated patch later today.

Regards,
   Felix


>                  if (restore_process_helper(p)) {
>                          pr_err("Restore process %d failed during resume\n",
>                                 p->pasid);
>
> Felix,
>    restore_process_helper is called both in resume and restore-work. Which calls into amdgpu_amdkfd_gpuvm_restore_process_bos to create a new ef.
> So there is one race below.
> resume create a new ef and soon the restore-work which is freezed during suspend create another new ef.
> Then there is one warning when you call replace_eviction_fence.
>
> [   83.865870] Replacing unsignaled eviction fence
> [   83.872452] WARNING: CPU: 5 PID: 9 at drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2838 amdgpu_amdkfd_gpuvm_restore_pro
> cess_bos+0xa9e/0xfe0 [amdgpu]
> [snip]
> [   83.896776] Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
> [   83.989171] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [   84.004699]
> [   84.004701] RIP: 0010:amdgpu_amdkfd_gpuvm_restore_process_bos+0xa9e/0xfe0 [amdgpu]
> [   84.046060] Code: 48 83 05 8c aa ea 00 01 44 89 8d 08 fe ff ff 48 89 95 18 fe ff ff c6 05 3a 82 d9 00 01 e8 ba 80 d1 d0 48
> 83 05 72 aa ea 00 01 <0f> 0b 48 83 05 70 aa ea 00 01 44 8b 8d 08 fe ff ff 48 8b 95 18 fe
> [   84.046062] RSP: 0018:ffffa1e2c00c7bf0 EFLAGS: 00010202
> [   84.046064] RAX: 0000000000000000 RBX: ffff8c58558d9c00 RCX: 0000000000000000
> [   84.046066] RDX: 0000000000000002 RSI: ffffffff9370d98a RDI: 00000000ffffffff
> [   84.046067] RBP: ffffa1e2c00c7e00 R08: 0000000000000003 R09: 0000000000000001
> [   84.046069] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8c58555ad008
> [   84.046070] R13: 0000000004000000 R14: ffff8c58542f9510 R15: ffff8c5854cbeea8
> [   84.046071] FS:  0000000000000000(0000) GS:ffff8c676dc80000(0000) knlGS:0000000000000000
> [   84.046073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   84.046074] CR2: 00007ffd279bb0c8 CR3: 0000000fde856003 CR4: 00000000003706e0
> [   84.046076] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   84.046077] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   84.046078] Call Trace:
> [   84.046079]  <TASK>
> [   84.046081]  ? show_regs+0x6a/0x80
> [   84.046085]  ? amdgpu_amdkfd_gpuvm_restore_process_bos+0xa9e/0xfe0 [amdgpu]
> [   84.156138]  ? __warn+0x8d/0x180
> [   84.156142]  ? amdgpu_amdkfd_gpuvm_restore_process_bos+0xa9e/0xfe0 [amdgpu]
> [   84.166431]  ? report_bug+0x1e8/0x240
> [   84.166435]  ? __wake_up_klogd.part.0+0x64/0xa0
> [   84.166440]  ? handle_bug+0x46/0x80
> [   84.166444]  ? exc_invalid_op+0x19/0x70
> [   84.166447]  ? asm_exc_invalid_op+0x1b/0x20
> [   84.166457]  ? amdgpu_amdkfd_gpuvm_restore_process_bos+0xa9e/0xfe0 [amdgpu]
> [   84.166917]  ? __lock_acquire+0x5f3/0x28c0
> [   84.166921]  ? __this_cpu_preempt_check+0x13/0x20
> [   84.166938]  restore_process_helper+0x33/0x110 [amdgpu]
> [   84.167292]  restore_process_worker+0x40/0x130 [amdgpu]
> [   84.167644]  process_one_work+0x26a/0x550
> [   84.167654]  worker_thread+0x58/0x3c0
> [   84.167659]  ? __pfx_worker_thread+0x10/0x10
> [   84.167661]  kthread+0x105/0x130
> [   84.167664]  ? __pfx_kthread+0x10/0x10
> [   84.167669]  ret_from_fork+0x29/0x50
> [   84.167681]  </TASK>
> [   84.167683] irq event stamp: 1343665
> [   84.167684] hardirqs last  enabled at (1343671): [<ffffffff91f9bd7b>] vprintk_emit+0x37b/0x3a0
> [   84.167687] hardirqs last disabled at (1343676): [<ffffffff91f9bd67>] vprintk_emit+0x367/0x3a0
> [   84.167689] softirqs last  enabled at (1342680): [<ffffffff91ee2c33>] __irq_exit_rcu+0xd3/0x140
> [   84.167691] softirqs last disabled at (1342671): [<ffffffff91ee2c33>] __irq_exit_rcu+0xd3/0x140
> [   84.167692] ---[ end trace 0000000000000000 ]---
> [   84.189957] PM: suspe
>
> Thanks
> xinhui
>
> -----Original Message-----
> From: Pan, Xinhui
> Sent: Friday, November 10, 2023 12:51 PM
> To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs
>
> I once replaced the queue with the freezable one, but got hang in flush.
> Looks like Felix has fixed it.
>
> Acked-and-tested-by: xinhui pan <xinhui.pan@amd.com>
>
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Wednesday, November 8, 2023 6:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs
>
> Make restore workers freezable so we don't have to explicitly flush them in suspend and GPU reset code paths, and we don't accidentally try to restore BOs while the GPU is suspended. Not having to flush restore_work also helps avoid lock/fence dependencies in the GPU reset case where we're not allowed to wait for fences.
>
> A side effect of this is, that we can now have multiple concurrent threads trying to signal the same eviction fence. Rework eviction fence signaling and replacement to account for that.
>
> The GPU reset path can no longer rely on restore_process_worker to resume queues because evict/restore workers can run independently of it. Instead call a new restore_process_helper directly.
>
> This is an RFC and request for testing.
>
> v2:
> - Reworked eviction fence signaling
> - Introduced restore_process_helper
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 87 +++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
>   3 files changed, 81 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 54f31a420229..1b33ddc0512e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1405,7 +1405,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>                                    amdgpu_amdkfd_restore_userptr_worker);
>
>                  *process_info = info;
> -               *ef = dma_fence_get(&info->eviction_fence->base);
>          }
>
>          vm->process_info = *process_info;
> @@ -1436,6 +1435,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>          list_add_tail(&vm->vm_list_node,
>                          &(vm->process_info->vm_list_head));
>          vm->process_info->n_vms++;
> +
> +       *ef = dma_fence_get(&vm->process_info->eviction_fence->base);
>          mutex_unlock(&vm->process_info->lock);
>
>          return 0;
> @@ -1447,10 +1448,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   reserve_pd_fail:
>          vm->process_info = NULL;
>          if (info) {
> -               /* Two fence references: one in info and one in *ef */
>                  dma_fence_put(&info->eviction_fence->base);
> -               dma_fence_put(*ef);
> -               *ef = NULL;
>                  *process_info = NULL;
>                  put_pid(info->pid);
>   create_evict_fence_fail:
> @@ -1644,7 +1642,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
>                  goto out_unlock;
>          }
>          WRITE_ONCE(pinfo->block_mmu_notifications, false);
> -       schedule_delayed_work(&pinfo->restore_userptr_work, 0);
> +       queue_delayed_work(system_freezable_wq,
> +                          &pinfo->restore_userptr_work, 0);
>
>   out_unlock:
>          mutex_unlock(&pinfo->lock);
> @@ -2458,7 +2457,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>                                         KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>                  if (r)
>                          pr_err("Failed to quiesce KFD\n");
> -               schedule_delayed_work(&process_info->restore_userptr_work,
> +               queue_delayed_work(system_freezable_wq,
> +                       &process_info->restore_userptr_work,
>                          msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>          }
>          mutex_unlock(&process_info->notifier_lock);
> @@ -2793,7 +2793,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>
>          /* If validation failed, reschedule another attempt */
>          if (evicted_bos) {
> -               schedule_delayed_work(&process_info->restore_userptr_work,
> +               queue_delayed_work(system_freezable_wq,
> +                       &process_info->restore_userptr_work,
>                          msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>
>                  kfd_smi_event_queue_restore_rescheduled(mm);
> @@ -2802,6 +2803,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>          put_task_struct(usertask);
>   }
>
> +static void replace_eviction_fence(struct dma_fence **ef,
> +                                  struct dma_fence *new_ef)
> +{
> +       struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
> +               /* protected by process_info->lock */);
> +
> +       /* If we're replacing an unsignaled eviction fence, that fence will
> +        * never be signaled, and if anyone is still waiting on that fence,
> +        * they will hang forever. This should never happen. We should only
> +        * replace the fence in restore_work that only gets scheduled after
> +        * eviction work signaled the fence.
> +        */
> +       WARN_ONCE(!dma_fence_is_signaled(old_ef),
> +                 "Replacing unsignaled eviction fence");
> +       dma_fence_put(old_ef);
> +}
> +
>   /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the given
>    *   KFD process identified by process_info
>    *
> @@ -2956,7 +2974,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>          }
>          dma_fence_put(&process_info->eviction_fence->base);
>          process_info->eviction_fence = new_fence;
> -       *ef = dma_fence_get(&new_fence->base);
> +       replace_eviction_fence(ef, dma_fence_get(&new_fence->base));
>
>          /* Attach new eviction fence to all BOs except pinned ones */
>          list_for_each_entry(mem, &process_info->kfd_bo_list, diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fbf053001af9..568c49f2f0ab 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
>          if (!kfd_process_wq)
>                  kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
>          if (!kfd_restore_wq)
> -               kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
> +               kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
> +                                                        WQ_FREEZABLE);
>
>          if (!kfd_process_wq || !kfd_restore_wq) {
>                  kfd_process_destroy_wq();
> @@ -1637,6 +1638,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>          struct amdgpu_fpriv *drv_priv;
>          struct amdgpu_vm *avm;
>          struct kfd_process *p;
> +       struct dma_fence *ef;
>          struct kfd_node *dev;
>          int ret;
>
> @@ -1656,11 +1658,12 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>
>          ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
>                                                       &p->kgd_process_info,
> -                                                    &p->ef);
> +                                                    &ef);
>          if (ret) {
>                  pr_err("Failed to create process VM object\n");
>                  return ret;
>          }
> +       RCU_INIT_POINTER(p->ef, ef);
>          pdd->drm_priv = drm_file->private_data;
>          atomic64_set(&pdd->tlb_seq, 0);
>
> @@ -1904,6 +1907,21 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
>          return -EINVAL;
>   }
>
> +static int signal_eviction_fence(struct kfd_process *p) {
> +       struct dma_fence *ef;
> +       int ret;
> +
> +       rcu_read_lock();
> +       ef = dma_fence_get_rcu_safe(&p->ef);
> +       rcu_read_unlock();
> +
> +       ret = dma_fence_signal(ef);
> +       dma_fence_put(ef);
> +
> +       return ret;
> +}
> +
>   static void evict_process_worker(struct work_struct *work)  {
>          int ret;
> @@ -1916,31 +1934,46 @@ static void evict_process_worker(struct work_struct *work)
>           * lifetime of this thread, kfd_process p will be valid
>           */
>          p = container_of(dwork, struct kfd_process, eviction_work);
> -       WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
> -                 "Eviction fence mismatch\n");
> -
> -       /* Narrow window of overlap between restore and evict work
> -        * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
> -        * unreserves KFD BOs, it is possible to evicted again. But
> -        * restore has few more steps of finish. So lets wait for any
> -        * previous restore work to complete
> -        */
> -       flush_delayed_work(&p->restore_work);
>
>          pr_debug("Started evicting pasid 0x%x\n", p->pasid);
>          ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>          if (!ret) {
> -               dma_fence_signal(p->ef);
> -               dma_fence_put(p->ef);
> -               p->ef = NULL;
> -               queue_delayed_work(kfd_restore_wq, &p->restore_work,
> +               /* If another thread already signaled the eviction fence,
> +                * they are responsible stopping the queues and scheduling
> +                * the restore work.
> +                */
> +               if (!signal_eviction_fence(p))
> +                       queue_delayed_work(kfd_restore_wq, &p->restore_work,
>                                  msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
> +               else
> +                       kfd_process_restore_queues(p);
>
>                  pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
>          } else
>                  pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);  }
>
> +static int restore_process_helper(struct kfd_process *p) {
> +       int ret = 0;
> +
> +       /* VMs may not have been acquired yet during debugging. */
> +       if (p->kgd_process_info) {
> +               ret = amdgpu_amdkfd_gpuvm_restore_process_bos(
> +                       p->kgd_process_info, &p->ef);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = kfd_process_restore_queues(p);
> +       if (!ret)
> +               pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
> +       else
> +               pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
> +
> +       return ret;
> +}
> +
>   static void restore_process_worker(struct work_struct *work)  {
>          struct delayed_work *dwork;
> @@ -1966,24 +1999,15 @@ static void restore_process_worker(struct work_struct *work)
>           */
>
>          p->last_restore_timestamp = get_jiffies_64();
> -       /* VMs may not have been acquired yet during debugging. */
> -       if (p->kgd_process_info)
> -               ret = amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
> -                                                            &p->ef);
> +
> +       ret = restore_process_helper(p);
>          if (ret) {
>                  pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
>                           p->pasid, PROCESS_BACK_OFF_TIME_MS);
>                  ret = queue_delayed_work(kfd_restore_wq, &p->restore_work,
>                                  msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS));
>                  WARN(!ret, "reschedule restore work failed\n");
> -               return;
>          }
> -
> -       ret = kfd_process_restore_queues(p);
> -       if (!ret)
> -               pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
> -       else
> -               pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>   }
>
>   void kfd_suspend_all_processes(void)
> @@ -1994,14 +2018,9 @@ void kfd_suspend_all_processes(void)
>
>          WARN(debug_evictions, "Evicting all processes");
>          hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -               cancel_delayed_work_sync(&p->eviction_work);
> -               flush_delayed_work(&p->restore_work);
> -
>                  if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>                          pr_err("Failed to suspend process 0x%x\n", p->pasid);
> -               dma_fence_signal(p->ef);
> -               dma_fence_put(p->ef);
> -               p->ef = NULL;
> +               signal_eviction_fence(p);
>          }
>          srcu_read_unlock(&kfd_processes_srcu, idx);  } @@ -2013,7 +2032,7 @@ int kfd_resume_all_processes(void)
>          int ret = 0, idx = srcu_read_lock(&kfd_processes_srcu);
>
>          hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -               if (!queue_delayed_work(kfd_restore_wq, &p->restore_work, 0)) {
> +               if (restore_process_helper(p)) {
>                          pr_err("Restore process %d failed during resume\n",
>                                 p->pasid);
>                          ret = -EFAULT;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fe937670c927..aa6c34127be9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct work_struct *work)
>          /* If validation failed, reschedule another attempt */
>          if (evicted_ranges) {
>                  pr_debug("reschedule to restore svm range\n");
> -               schedule_delayed_work(&svms->restore_work,
> +               queue_delayed_work(system_freezable_wq, &svms->restore_work,
>                          msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>
>                  kfd_smi_event_queue_restore_rescheduled(mm);
> @@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>                          pr_debug("failed to quiesce KFD\n");
>
>                  pr_debug("schedule to restore svm %p ranges\n", svms);
> -               schedule_delayed_work(&svms->restore_work,
> +               queue_delayed_work(system_freezable_wq, &svms->restore_work,
>                          msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>          } else {
>                  unsigned long s, l;
> --
> 2.34.1
>
