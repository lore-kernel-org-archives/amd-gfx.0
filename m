Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74314606A32F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VRYoQuAN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD7D10FFE1;
	Wed, 18 Nov 2026 20:06:07 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8C310FFE1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 20:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScXzAupUmPbpwwW2G86CvMIv4FTIotlp2/ohOtAy2bFj4oxOPPJV31uFi1ENupTXtcvKffwDtGjWUVrmUVULPAy9cse0Ogl95VEh4qveUHMBa0glBfVMHA623mLN9evEIsgAM+AVqzTudB9Enjum5zoBwwEM1MuHaKh/T7HXlGcc++xr1v7DlxptWHgPM/BcWgfQDwdSHlET2ezLJnoc1DS4X8QmxkI69U2TKlNAUUUjmxR3YCnr/wEyKMZiQglDRcK81yMpOy9hoDX99ZTDvRFu0uqNKgT2RKKOmdfXR4prr5fGAxSBbXU5mqikM8JrEtTvj+aDMH/JYnGvazUEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gv+7wKDXqsEpKXIZGR3mkdORxZPiikSaqkKuTsvEIc=;
 b=UNJzPBrWz1BEegMFm9lmAry9l7BAsZoJCb+Tp0NChi6D/KhNmDtZakSrxxR+SLF70quRGIiH0rvhDNxxaMVhOBTaxjNm3xK8VHl67NBubwHtXfdOoXL4CrYlSAUYLFUBGXaDxVvM/LcJdAKhfDMpkEDfsWXhBbIm88es5/sRqMkbnyNAqKvdDsXKGgm6YYSHEBHoUm4pPcvR4mXaOAhgw5O6HeVkglrvEzyrdXYgLUZxe3aU4djWMfAPTFXYvoBsKUjB7EMalXCwosG8+OXW7lpD594t30ADz5zQKwFVosQWfexlOsq4tbYj6RRLK+Lx8BMopTE+JhC6YxVaCmtaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Gv+7wKDXqsEpKXIZGR3mkdORxZPiikSaqkKuTsvEIc=;
 b=VRYoQuANpA8+y7TUs6SA79xbzxBrpyHvqE81r3nu1EsWSgDw9IzFnAMdmb4r4QcXPeLu6T0UHtf2RFtQMUjpNgUXRlB9T/nYOVCaEeX7Q9KZGUwZNzt22mpch+XP6dEQTZNyUDwqKlunvhX6VK6BXxNFK9xgbz4hablm0YRzLnA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:05:54 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 20:05:51 +0000
Message-ID: <3f44a1b0-0623-4525-8797-96e947a4e1e8@amd.com>
Date: Wed, 18 Nov 2026 14:05:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
Content-Language: en-US
To: "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
 <5e22b2e1-2379-4583-968f-78217ce5525f@amd.com>
 <SA1PR12MB715234880D4B3AEDAA1AFF72F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB7152CB1DA95F6AC4190C93E6F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB71526239725978636452725DF87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <1d06a6ef-7a67-409a-bbaf-9ec9c0dd32de@amd.com>
 <SA1PR12MB71528D13366F5048D82E4841F87A2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <fb919edd-99d6-4495-93a4-d0a22024aab2@amd.com>
 <SA1PR12MB715204CFF7E0CFA0609D62FDF87A2@SA1PR12MB7152.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <SA1PR12MB715204CFF7E0CFA0609D62FDF87A2@SA1PR12MB7152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::17) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: be574dc0-61a2-4ac2-3110-08df45af582f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|6133799003|18002099003|22082099003|11063799006|56012099006|5023799004|261026140227099003|4143699003|261102123227099003|261022075727099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: +BAj77TYGjs0IgPCCEGC3HHzd16NWT1aqL11zvmNau+TIAOxW9UP79xsDByKkFqQYuAj0wD9gEI7ZGqGcTKsO13mBMGERGbfCfR76M/9GJnMav9DFdP3n61FjBtcKGm4ZIXZFt+8JvW5ZwO7OiGbQFmGC1AayyhYCLJXNf4ns8QG4EALdUVLiWqaYAmx3wqRoch/tpfqwjj7sRdnFYmpG6kStzTEEXXFBpPVyIYFyDHX5K/9f5QlDp1t8hgTnK96JLW7MZBrmSwNRrRgX53upSIPggE8UcQN1qjp2iZ8vThzP5CMAYZk4/6fh5GCcywT2I4fVXqRIOtLqp1bSM6swg8eIsSFW+s1aaUyw+JtSnEVaNpBEBIDlliyMO3NXpZuL4ogqV5IL7DKRcfqB/kErEv3QgGAKT7fZ/7Fx4fRMboMl0TjczF8JxBHMpllbzk+bxoAgyx/IDMDkOCTuZpzBEXE2oOjSx3wrMQKpQ1n3NH/9wAVVafvHT/Rq2/w8j61Wrdi2Md13EbJx9M3UlXCgYfoA8CVS8fZTyyeBogVEN9mvS2LPhf4bmHd6It2YZkX2Pn8rsELuYE6nGjWOkhdG4hqcSxkXSAErmNE5TyprlRk3fmVd20GTrgX8WY2DXLI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(261026140227099003)(4143699003)(261102123227099003)(261022075727099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNqRW5MVWZvd3FMbW9zNm43eDg2b09FaStmYmhoSmJWaE1PSW1LdFFnZ0RP?=
 =?utf-8?B?L2JHNHlyZ01IK1JlQlZkMlFsV2lTUXdTanJkVWNsYUpEbTM4cVo4NWUzUUxM?=
 =?utf-8?B?UEs4ZEFWeko5WlhoeEovUXBSNWkzaGNzTUpMaWJBT0lTT3d6T2wzQU1oeVd3?=
 =?utf-8?B?UnJaTXVBMlJpNExBWEZ6Zm5oZnpPMk1CUnRpeEgxK3N6RE5LRytrLzQwcGtL?=
 =?utf-8?B?MCtKYS9sQVg1N2ptWDZES0FvVXdTd3ppbzMvY0hpOU9EdVlNSzNkVlBkN0R3?=
 =?utf-8?B?UDd3QThsRDdCVTU5YkRMbVZqOXRDdHVIQXYyVXAzOFovYXk0NkphRUMwd09P?=
 =?utf-8?B?bXZ2Rm1sODhrbnJYWjZRb3BYanZaNGlVRlc1N2x5a1FLRE16OGk3NUNmaU1Y?=
 =?utf-8?B?T2hhNTcxVENzcE9GQ09idmRiNEJtUWVyOTF3NXNBU0NyeG5QQVJHaHhHSUt3?=
 =?utf-8?B?R05RbUNUNFp4M0lMVFlDV0k0NGZWZ0kzRnZITi85d2pJbG1xSWdCK2tnR3d4?=
 =?utf-8?B?NTJzT0Eydnl1RW9JSVYwSERPYnJ2REV1bzhNc2JwRlpiRlRSaVVYa0k5bkVP?=
 =?utf-8?B?aEhCVXlXTHhiY3hyRE43bFVzS0xrb2xVZ21JSWtpSFhEaVh2TStnQUtoYm1q?=
 =?utf-8?B?SnhoRXdMSzFabE1OWjc0aUVvUGZaa0NhRDh2bmNodDVQVkJOL0twOHV3eU9Q?=
 =?utf-8?B?YjZHZjVaL2E2Z1VEeDl5Y2t4SFVZZUpabEdicm1pVnN3VDZFbUZqbFVvNVpL?=
 =?utf-8?B?VGw4b1FEUHlTWXJBd0gxcGJOU0hPelhjaG12ejFTbEhMNTVlRHl5YW0zd1pm?=
 =?utf-8?B?bkczSVN0SzZQM0IwTnplYWlXeWJRWU55R1pVOFFHZUJMdGVyT04yT3pKWFZn?=
 =?utf-8?B?YjBHSVZMcEkrc094MVRVR05yd2JDREhpTXBIcW1SL25iYkt5ejBKVC9vdmlF?=
 =?utf-8?B?ODdoc2YvTTdEejBGWGlwS25VQzIwUnFNVzNnSk1tWTlTaXVCTmpuS1M0TFp1?=
 =?utf-8?B?c0kwNlNKc09lbkcrV1Rpbldqc2cvZGRNUzAzOWs4aFdYT1BRd3dXYmV3ME5S?=
 =?utf-8?B?YkVXZ29ta2g0SHVIc01LZnZlOE1JeUoyMWNUM2N5bVNGd05jMFh5LzJMN0hv?=
 =?utf-8?B?a0VoY3JVQnBqV2d5TDc1U3dvNHJNWmlFYW9qMDljZkR1b2lYS0poamNmUmpS?=
 =?utf-8?B?bE0vZVlxYnhSemd2YWFPWmlKQ20wTDRuc1NMc1c2T2s2Qy96eGkrUEUyQ2tz?=
 =?utf-8?B?a0ZyeWxpaEFpVGh2Nlc0WDVoWGJ1dVhnL2NBRUM4cFM5ak1sTXZmOHI2akUz?=
 =?utf-8?B?bGxMbHNrSEViam1UbjhSTG50MStpaFdEbUlOUUpHSkFPdFNLWU43YmJSeFc2?=
 =?utf-8?B?dEQzdkxEOE9zaitIZjJmL0V3bjF0cFFDVUdOeTJRMDVwU3lhMEdiTXVlajR1?=
 =?utf-8?B?NGdLRjdFWmxwZmJiYno1a05qNC9GWUpJTHpXa1hheXNLS0t6OC9oTnNYTXls?=
 =?utf-8?B?K0JHY3lBTVM1bVhpakpzSXU5N0oyTWdCMHB2eWdhYWtPZUZQcXM0QmVISE1U?=
 =?utf-8?B?dlhtcHRPc21JVXVBN3g1ejVzWlUrY2prYXRKMFdaUmNwSWUza3BCOHlIOStR?=
 =?utf-8?B?dGVJSW5CemV4dk5qOVp6RTZRUlJsb2FhVUFrM2w0M0c5d3k0TVZtaldRQXNL?=
 =?utf-8?B?RmdPdmszS2M4N2tGTjk4MVZiMGNOQ3FiMHA2MmczZndrMlRmRE9uNjBEVXNH?=
 =?utf-8?B?b1hXWmFsWFZqbi96cDZvaEs1L3VsRkVZNGFvbTc2YXAwYjg5SGxCQlRXSXZa?=
 =?utf-8?B?ZUxlWTNCYURvT0xGOXAvbHZSTERFRXo2L1ZaUjU4M0xobWEzVWdwYm82UVR6?=
 =?utf-8?B?WUZ0UEhRdHVmWkYrWWxwVEdjdzFmbDk3Z3VMSG4vejFFTm5DWXpwbWEzOCs3?=
 =?utf-8?B?clV1RnNTd2k5OWpsZmhTRHRrNzJkMG14aVhJcHQ2S3Z5MTNCalBDWlZ1LzUw?=
 =?utf-8?B?d2w2Yi9PU25JekQ2eDNtblZqY3Z3S2ljS0Mzc1ZJZjZvbS81QllHcEhYS2Zo?=
 =?utf-8?B?TmRoSENsOUN2QVA1VnhBS0x4eVgyenlpbVRpQ21JczBDRlRGb2Eyc2l1ekU2?=
 =?utf-8?B?ckEvVnRpc01aMmthUGhtNVpZbFpBeGtSb3Q3YTFEUDFWZ01CcnE1OGZnWW1O?=
 =?utf-8?B?czFtZ21mKzZVVjFuRDFLdFZUTlJaQ2lNZUZhVEZ1THhqQU0zL3RoOEF2UE8x?=
 =?utf-8?B?KzZ2Tkp1ZmhlY1V2RGFXQWI2aEIzSDVydnNROTNhQjQzd3dBSTNGVFVSWWtP?=
 =?utf-8?B?MTNVTFI5bnhvWG0zaXIrRjIrSEZ0NVY1WTFUQ3UyNWlMbWVEYUN6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be574dc0-61a2-4ac2-3110-08df45af582f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:05:51.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Hun82BqKeyTidKDo2jkapNokh1UuKL3djSB2ahoCQzjf36qPeEssjaLgI84W9Q/rtOF1U3rwudCCADQz1EiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/26 14:04, Thothiralingam, Logatharshan wrote:
> AMD General
> 
> HI Mario,
> 
> Agreed. However, the customer is on the 6.18.8 kernel. Does the review also apply to that older version? They are pushing for a fix ASAP because this affects their field product, and they have already waited a few weeks. I am considering giving them the patch for testing with a caveat: it is a developer-level patch that has not been fully validated, and I am in the process of upstreaming it.

That's fine as long as they understand that.

> 
> Where should I post the patch for review? Also, is the review for upstream code only? Please provide guidance.

This mailing list.

Please rebase on amd-staging-drm-next: 
https://gitlab.freedesktop.org/agd5f/linux/-/tree/amd-staging-drm-next

Then send it here as it's own inline patch.

> 
> Thanks,
> Tharshan
> 
> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, November 18, 2026 2:44 PM
> To: Thothiralingam, Logatharshan <Logatharshan.Thothiralingam@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
> 
> 
> 
> On 11/18/26 13:01, Thothiralingam, Logatharshan wrote:
>> AMD General
>>
>> Hi Christian,
>>
>> You are right, amdgpu_vm_wait_idle() is not needed. I was thinking of that before, but I added it in the previous patch per your request. But now, I have removed it.
>>
>> Please see the attached patch. I have tested it, and the hang is not seen. Please let me know if the patch is good to go so that I can share the solution with our customer.
>>
>> Then, I can create another patch against upstream and work on getting it pushed.
> 
> IMV - I don't think you should share the patch to anyone to claim to fix a problem until we've successfully merged it.
> 
> I would post it for review like any other patch.  Let Sashiko bang on it.  Get review tags, merge it internally and let CI bang on it.
> 
> When all looks good there you can be confident in sharing it.
> 
>>
>> Thanks,
>> Tharshan
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, November 18, 2026 5:15 AM
>> To: Thothiralingam, Logatharshan
>> <Logatharshan.Thothiralingam@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>> suspend
>>
>> Hi Tharshan,
>>
>> oh that is a really good point, using amdgpu_vm_wait_idle() here is not correct either because of the same problems as with the context flush.
>>
>>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
>>> DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT);
>>
>> That looks like the right thing to do, yes.
>>
>> It only might be necessary to replace DMA_RESV_USAGE_READ with DMA_RESV_USAGE_BOOKKEEP, but I'm not sure if KFD/userqueue suspend resume is actually fully implemented and handling this.
>>
>> Maybe we should stick with DMA_RESV_USAGE_READ for now and I will let my team double check the KFD/userqueu thing later on.
>>
>> Thanks,
>> Christian.
>>
>> On 11/17/26 21:08, Thothiralingam, Logatharshan wrote:
>>> AMD General
>>>
>>> Hi Christian,
>>>
>>> So adding dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT); before the amdgpu_vm_wait_idle() fixes that gfx reset. So it seems like amdgpu_vm_wait_idle() alone is not enough.
>>>
>>> Attached the patch again. Please let me know if it's good.
>>>
>>> Thanks,
>>> Tharshan
>>>
>>> -----Original Message-----
>>> From: Thothiralingam, Logatharshan
>>> Sent: Tuesday, November 17, 2026 12:52 PM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>>> suspend
>>>
>>> Hi Chistian,
>>>
>>> Just having the amdgpu_vm_wait_idle() doesn't solve the issue. I
>>> tested it and I do see the reset. I have attached a patch with the
>>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
>>> DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT); I am building it
>>> now to test.  Please let me know your thoughts
>>>
>>> Thanks,
>>> Tharshan
>>>
>>> -----Original Message-----
>>> From: Thothiralingam, Logatharshan
>>> Sent: Tuesday, November 17, 2026 8:39 AM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>>> suspend
>>>
>>> Hi Chistian,
>>>
>>> I looked a the amdgpu_vm_wait_idle() function and noticed that starting commit 1f02f20 (https://github.com/eseiker/kernel-asahi/commit/1f02f2044bda1db1fd995bc35961ab075fa7b5a2)  the wait on the VM's root page table fence list is removed. So correct me if I am wrong, this alone won't wait on the gfx jobs right?
>>>
>>> So should I add this before the idle call?
>>>
>>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
>>> DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT);
>>>
>>>
>>> Thanks,
>>> Tharshan
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Tuesday, November 17, 2026 4:37 AM
>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Thothiralingam, Logatharshan
>>> <Logatharshan.Thothiralingam@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>>> suspend
>>>
>>> On 11/16/26 21:40, Mario Limonciello wrote:
>>>> At suspend, amdgpu_fence_driver_hw_fini() only waits for the last
>>>> fence emitted to each ring. Jobs still queued in a scheduler entity
>>>> have not reached run_job() yet and so have no hardware fence.
>>>> Userspace is frozen at this point, but such jobs can become runnable
>>>> later, for example once a dependency signals, and the scheduler then
>>>> pushes them into the ring after the hardware wait has finished and
>>>> before the IP blocks are torn down. On resume the ring write pointer
>>>> is reset, those jobs never signal and the GFX ring times out and hangs.
>>>>
>>>> This was observed as a rare (about 2 in 400 cycles) GFX hang on S3
>>>> resume on Picasso.
>>>>
>>>> Flush the context and VM scheduler entities of every open file
>>>> before evicting resources, mirroring what amdgpu_flush() does on file close.
>>>> Like for any other dma_fence there is no timeout, the wait is not
>>>> bounded.
>>>>
>>>> Reported-by: Logatharshan Thothiralingam
>>>> <Logatharshan.Thothiralingam@amd.com>
>>>> Closes:
>>>> https://lore.kernel.org/amd-gfx/SA1SPRMB0073292C113C6B98D9282092F87F
>>>> 2 @ SA1SPRMB0073.namprd12.prod.outlook.com/
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>>>> ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 19a566187dfb5..d18348116d3f1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>>>>         }
>>>>    }
>>>>
>>>> +/**
>>>> + * amdgpu_device_flush_file_entities - drain scheduler entities of
>>>> +open files
>>>> + * @adev: amdgpu device object
>>>> + *
>>>> + * Wait for the scheduler entities owned by all open files (the
>>>> +context
>>>> + * entities used for command submission and the VM entities used
>>>> +for page
>>>> + * table updates) to run out of queued jobs, so that nothing can
>>>> +slip into
>>>> + * the rings after the hardware fences were waited on at suspend time.
>>>> + */
>>>> +static void amdgpu_device_flush_file_entities(struct amdgpu_device
>>>> +*adev) {
>>>> +     struct drm_device *ddev = adev_to_drm(adev);
>>>> +     struct drm_file *file;
>>>> +
>>>> +     guard(mutex)(&ddev->filelist_mutex);
>>>> +     list_for_each_entry(file, &ddev->filelist, lhead) {
>>>> +             struct amdgpu_fpriv *fpriv = file->driver_priv;
>>>> +
>>>> +             amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
>>>> +                                         MAX_SCHEDULE_TIMEOUT);
>>>
>>> That is actually superfluous and even a little bit dangerous.
>>>
>>> amdgpu_ctx_mgr_entity_flush() is only supposed to be called from the process which has the file descriptor open and is closing it.
>>>
>>> We use that to detect if that process using the file descriptor was killed and we should discard queued up work instead of waiting for it to finish executing.
>>>
>>>> +             amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
>>>
>>> That here should be enough to wait for all work to complete.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +     }
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_device_suspend - initiate device suspend
>>>>     *
>>>> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>>>         if (r)
>>>>                 goto unwind_ip_phase1;
>>>>
>>>> +     amdgpu_device_flush_file_entities(adev);
>>>> +
>>>>         r = amdgpu_device_evict_resources(adev);
>>>>         if (r)
>>>>                 goto unwind_userq;
>>>>
>>>> ---
>>>> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
>>>> change-id: 20261116-superm1-drain-submissions-17d4414ab3b9
>>>>
>>>> Best regards,
>>>> --
>>>> Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>
>>
> 

