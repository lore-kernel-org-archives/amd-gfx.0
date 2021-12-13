Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735EAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 13:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF8310E902;
	Mon, 13 Dec 2021 13:39:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5BC10E902
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 13:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgc2o5OtcoEunbtktVYUwDyeW1keCdh1u59aIXL3KDRRaLRHY2Evns/CkXu+eIxGILp6fj5YSIJOQXpy8Ld1AWfeSoGrnR9L/rMSHn8bL3W+B4+AoTjWx74bLh3ldEewYcDw57eGGkabo3uXnj7qFwLgbBSGu9SZW+5heqc49YbAm4plb/W87Fz8T+G+2oD3LWLF8caCJ3vJ6W9VCHhLpbglgZkMO0/ZULwfoOWT+ehQ4b6lqEbD761DDVvn4EstGikeH1zURA86RzZ78zg/DnhxxlLoXWcjGwXx97NxAmF2SFkyWyyjECc9UDD8GEqgMCjvcqAyg761GczM4TE2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mMYVb6ZU7AzlTQGkcjrgOcOOKts1J0xLW/c52s6rWI=;
 b=dCEq1fPLDbYBBAJwuZvvsyL2zx+4q+OORC7mL78TUXGVx8rELocu5O5U21qzrUJ8qgUWkoE3StROeF5FWHQGQkjqhpjXs+96t6DVhOIi84XCI3ogeB62MWRWqvQ4Nl2oqIB2sWyPQW4vCNv3P5D9mNB2LmAglggHia6AtWiz5vKh6BatgfPJ7S5Aj4dW9Fyobx+feTyPr3ptAu38vqKiTCQTsuOlBjSDg+SYyvchs6mR/Hg+45FaVG5r2dQNyvWaQDl9BeCMhjvvbqplDTHNoAs/V0+RM4A7shwOooqIl87PTFilE4UJ3eWZoKVY4kUSabsnPWxn6HcpsNJuylL4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mMYVb6ZU7AzlTQGkcjrgOcOOKts1J0xLW/c52s6rWI=;
 b=hI4T9RN/PpM4RzctMm4DqbDmUPEef7erHhiZc6+YMQFWtC+rlTpapcSkG72momq0NMBcTKfkz1dtFZHNsZYkgkIH54pr1di3GypBFBEnuJ8rrttNcsDONJLETwy/gOu05N3IQ/OU7Talq+C44P0gMyWBBYjPRknGSiPNNdT/MN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 13:39:04 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::9d61:180f:e2e0:2db5]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::9d61:180f:e2e0:2db5%8]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 13:39:04 +0000
Content-Type: multipart/alternative;
 boundary="------------kHUPxxVBzTwytJB5AFL0G2d8"
Message-ID: <826e98e0-5e6a-cc87-0690-b444e34bb367@amd.com>
Date: Mon, 13 Dec 2021 08:39:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Content-Language: en-CA
To: "Gong, Curry" <Curry.Gong@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
 <f1f996f4-0bc3-aa01-f9da-3664b14f7861@amd.com>
 <BN7PR12MB2641CA6290B6CEFB4A5016EF9D749@BN7PR12MB2641.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <BN7PR12MB2641CA6290B6CEFB4A5016EF9D749@BN7PR12MB2641.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR19CA0067.namprd19.prod.outlook.com
 (2603:10b6:208:19b::44) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c6ef83c-b020-434d-166e-08d9be3dede1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3737198D1704651FE599C03FE4749@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hjfT9BK3zx9Q14Oft5cUM4KSr4yJmaFE9Dv+Q1oNd3zE1XtmniUvbg12CjaU+JMfSNFrUEVg4zufClZL3841VovFctsAW7ZExOQZmhb2mYyHDs1YpdUZZqmxyJWwav39W1E9kIqzl1bsRo/p4DIFMdV21jrKcJ86PEz3yQ1/UtoveRC6SBZ1HdkekrQaA7FgpgGuPFiDIcO6jX/L2N/nTDWmcclFVwyZR+K7IEs5a470IMw2Jf68wiltPTk7vMu0AdSOgrJlURskRSYTaTSwT9KEUmwWWMKAmi6Zxnvt0apUSSBpcY8LZ3CaPcJ0yik1N8vEXolJUprMGmICg4H0latKcT9r0SbtYVvCNsRrkCrJJF58GNX6uNvBcbd7bpfkr0BwENbr7LiQNvqeYM2aRwIrmxjDi7jRv5xJrJcDO+0GMsU9a57W0DkI6Zdjqyer7EmJ9M0lyG5oO2JB/PRBhF6u0T2IhQc2xsCUjHoctZ9O2kendHzuyTrfqG2JhAaj2a59TtyFNM2TnR389IfPYDBSkcRAUCTIuoFBply+XPgWyC/2n6TbkugCqSR/25E52Gxp/414VaN/+YViC5CKClTJzSzIKMh1AgJ1mZRU2VV0b9nABiS3XzCi4XoypADMgi72fl4dDCziXnu94ISy5R2h1c2/cUJkCcbqASEuIIwabOxpnP3e/4sCwM3YSNXSMYASHeZEygufjSdvfLBFSKamPuSUApLuMRSD4tt66k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(83380400001)(2616005)(33964004)(2906002)(38100700002)(54906003)(15650500001)(5660300002)(508600001)(31696002)(110136005)(4326008)(4001150100001)(36756003)(8676002)(186003)(26005)(53546011)(66556008)(6512007)(30864003)(6486002)(6506007)(66476007)(66946007)(31686004)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdLdk04UzU1Y3JQN2EyemdlazVsNTBjdVJtdWFBKzEzcDh5cjc5YW5BVFNC?=
 =?utf-8?B?NW9ramVIOHdzMjZ3eHBOWGJMZzFNclN0MlNrWTd6QUN4T1BTRXNvM1NEZWVm?=
 =?utf-8?B?YWY1Mmk4QnZ6enJ3Q1JVYzh3WkRteVFFeWJLQUZEZXNQa3VrTTByNFdjR2dj?=
 =?utf-8?B?Nmx1bXQ3THJ3RnhRZzBDN2VRcjNOeGtNZmFBOHF6bWgxTE0veXg0cVZPTHd0?=
 =?utf-8?B?eW5uSHhCb3hMR2tieFNHYnhJajl2NkxVb3BhbCtsN0xEcFpVMVBSc09xb2I5?=
 =?utf-8?B?dmN5MnpQS0hwS1FxZldodEhBL09hQURFTlcyUjZPejhjRjRnS1pYMXA1d1ov?=
 =?utf-8?B?bVpUYzM0aWtGem9Da2trZTBrSmVtS0swNjRsdUlYQ1YyR0JJUTFCZFB4UWdI?=
 =?utf-8?B?RDFsVmNsaDVjeGk0OUIySFV3QWh3L0R5Y3FsZnpUaDk1YzhzeWpaZkZPS3lY?=
 =?utf-8?B?WGNZTTE1NU8yVWYybkdBRGxLdzU5VWc2TFUwRWQ0L0FicnE3TElURngrRzRV?=
 =?utf-8?B?MTdCaTRDR1RNTmc5NGY0M1NHUW9IUGtUOWlaeXdDemdQM0R4QktCb2pSNkg3?=
 =?utf-8?B?UnRHNCtaRmk0YWU5VEFDZW93Zm5Da29DVEtYbEx0bWQ2eVZ5U0JYMHpSaG9q?=
 =?utf-8?B?L3FBd1B5L1V3aFRtZlEwbGZ5YjlONndRZEp0KzN2S1FyZDN6dmp3Y0owY1VP?=
 =?utf-8?B?VXhSbWI1WXNLYzFJbHZOYXZqbXVhRk53Q3VqNXhEaGJ2S2ZIWHNGcXpNKzFD?=
 =?utf-8?B?Z3hFK1BlMzdlNnBzM2xlUndFRDJ5TWJxRzdDN1lmeE9XdTRwcXZEMW84N0k2?=
 =?utf-8?B?SG02QzJXUzZ4Z3RsZExGQTI0V1VUZ2dDcTV3Z3J6dkpweXpTQkpHanZsV0Fk?=
 =?utf-8?B?b0I0MWRYczVsMmk5OWJYQzUwRE5lc2VQSUwwcHVaMzBJUVU2NTVBRlVXdk5Y?=
 =?utf-8?B?dUR0bFBlNURMQlNrbWRqUTFrQXJLN3kxNUx1Q2FLOC9iMGpsNmFOaEtYdTE0?=
 =?utf-8?B?b0pyTThlWHBlNVZqVlB0VDZHbDFCZm4vdXZ0MEdENzM3T1c4MWcveW52VFRh?=
 =?utf-8?B?OFc4cVprNHZvMng1MzFBY0VSVUpOVnVTdTgxV1Z2Z2NsQnJDaC9HbnBVTFN0?=
 =?utf-8?B?cGdDdkhRckIwQ0g1bElBdHVJNFpWK255ZlBFSkMrbUdYZ0dxbFNyTWxuamJr?=
 =?utf-8?B?UHo1RGJWMlhVYkZaU0dCbE03QzR0azNkbkRETlNFVlVoekxDV2l5QUh3MUUw?=
 =?utf-8?B?N2lTN3pxUU5tMWU0TkxFM2prcHFGM1ZhRkpLMnNPTFZwSE9acjNvYW9lbUla?=
 =?utf-8?B?TDg2bXhuNENVZSszNk14WmtnZDFVcjl1ZFlJbGwza251VE5NMlFlZG1sdjhZ?=
 =?utf-8?B?SVE0V3o5QW1oUFJWeHVqSXFsME9EZm9RdWxCekd5dldyc0N6VUEwb1RGTVlu?=
 =?utf-8?B?dzN0SjRCZjVYeWJvSEJHcE0rbTJIWmYrNFZwWURSRGJPbXRFRnhsUkFZSzNJ?=
 =?utf-8?B?eXBmZEp6VFRKbVkyVVRjbnBxbWY2TUkvOVFYMmIvSXR6UEhTZ3d1dllGQzhC?=
 =?utf-8?B?d1l2OUFhSlRPa0dINjdlVUNRc1htWFBybC9uMTdiRlk3c0t5VVdpdmQ5TDNi?=
 =?utf-8?B?dWhucUZ1TFhLV2I0VzVKWCtyT28zTHkyZHMzOGN2bUhOZk05Q2JkaWRjVkJq?=
 =?utf-8?B?YUJtTmt0L3VpOC9iSGhTZ3pta2FBbWxxeGk5QW1hYUk0dEhGZGVKQmdBN3Q4?=
 =?utf-8?B?MzNubS9IT2t2UFdGUDNFTStUOUlLdEx4NkFiYkJZY3VNaHNRc3BINlhLdngy?=
 =?utf-8?B?WjF2RW5SWk1RR1hPekhLQVQ3bDJqRUI5S0lSWStqc2Y4bitxbE1pVGJRYXVq?=
 =?utf-8?B?SENCWEo3Z1I5aFBXUDlvZDVxenpyajRKL3cwaEptcUh4d1NKa0JyUjdxdGVr?=
 =?utf-8?B?Y2cwMUhiZUVsS3dGZ0dqMVpTWk5xY3k5QjJMSWYyL29yQURwVDRIWnhpZUlm?=
 =?utf-8?B?MUFuS1B6NEkyckhqb28vUEJFQ284RXFXcFhOb3k3empDWjFzQmltV0hLd1FF?=
 =?utf-8?B?NkNQOGtjL3RPN0k5MnV1dVFveDV2Z1ZRWHRXd3Z2VldzY1llbGV3N3A4aHhj?=
 =?utf-8?Q?b5D8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6ef83c-b020-434d-166e-08d9be3dede1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 13:39:04.5228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+No29jHwD+O9ZsqP8rlLRanAtoIYNbVpDDoUH9rIjAYxCohMgFT2CLfI2E5PFZ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------kHUPxxVBzTwytJB5AFL0G2d8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Curry, Evan,

It seems vcn1.0 power gate sequence are special.

if the original solution is thread safe, then the following solution 
will be thread safe also.

static int vcn_v1_0_hw_fini(void *handle)
{
     struct amdgpu_device *adev = (struct amdgpu_device *)handle;

     cancel_delayed_work_sync(&adev->vcn.idle_work);

     if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
         (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
          RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
+        if (adev->pm.dpm_enabled)
+            amdgpu_dpm_enable_uvd(adev, false);
+        else
+            vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
     }

Best Regards!

James

On 2021-12-13 3:55 a.m., Gong, Curry wrote:
>
> [AMD Official Use Only]
>
>
> Hi James:
>
> With the following patch, an error will be reported when the driver is 
> loaded
>
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
> @@ -1202,6 +1204,9 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev)
>
> else
>
> r = vcn_v1_0_stop_spg_mode(adev);
>
> c
>
> return r;
>
> }
>
> $ dmesg
>
> [ 363.181081] INFO: task kworker/3:2:223 blocked for more than 120 
> seconds.
>
> [ 363.181150]       Tainted: G           OE 5.11.0-41-generic 
> #45~20.04.1-Ubuntu
>
> [ 363.181208] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
>
> [ 363.181266] task:kworker/3:2     state:D stack:    0 pid: 223 
> ppid:     2 flags:0x00004000
>
> [ 363.181276] Workqueue: events vcn_v1_0_idle_work_handler [amdgpu]
>
> [ 363.181612] Call Trace:
>
> [ 363.181618]  __schedule+0x44c/0x8a0
>
> [ 363.181627]  schedule+0x4f/0xc0
>
> [ 363.181631]  schedule_preempt_disabled+0xe/0x10
>
> [ 363.181636]  __mutex_lock.isra.0+0x183/0x4d0
>
> [ 363.181643]  __mutex_lock_slowpath+0x13/0x20
>
> [ 363.181648]  mutex_lock+0x32/0x40
>
> [ 363.181652]  amdgpu_dpm_set_powergating_by_smu+0x9c/0x180 [amdgpu]
>
> [ 363.182055]  amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]
>
> [ 363.182454]  vcn_v1_0_set_powergating_state+0x2e7e/0x3cf0 [amdgpu]
>
> [ 363.182776] amdgpu_device_ip_set_powergating_state+0x6c/0xc0 [amdgpu]
>
> [ 363.183028]  smu10_powergate_vcn+0x2a/0x80 [amdgpu]
>
> [ 363.183361]  pp_set_powergating_by_smu+0xc5/0x2b0 [amdgpu]
>
> [ 363.183699]  amdgpu_dpm_set_powergating_by_smu+0xb6/0x180 [amdgpu]
>
> [ 363.184040]  amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]
>
> [ 363.184391]  vcn_v1_0_idle_work_handler+0xe1/0x130 [amdgpu]
>
> [ 363.184667]  process_one_work+0x220/0x3c0
>
> [ 363.184674]  worker_thread+0x4d/0x3f0
>
> [ 363.184677]  ? process_one_work+0x3c0/0x3c0
>
> [ 363.184680]  kthread+0x12b/0x150
>
> [ 363.184685]  ? set_kthread_struct+0x40/0x40
>
> [ 363.184690]  ret_from_fork+0x22/0x30
>
> [ 363.184699] INFO: task kworker/2:2:233 blocked for more than 120 
> seconds.
>
> [ 363.184739]       Tainted: G           OE 5.11.0-41-generic 
> #45~20.04.1-Ubuntu
>
> [ 363.184782] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
>
> [ 363.184825] task:kworker/2:2     state:D stack:    0 pid: 233 
> ppid:     2 flags:0x00004000
>
> [ 363.184831] Workqueue: events 
> amdgpu_device_delayed_init_work_handler [amdgpu]
>
> [ 363.185085] Call Trace:
>
> [ 363.185087]  __schedule+0x44c/0x8a0
>
> [ 363.185092]  schedule+0x4f/0xc0
>
> [ 363.185095]  schedule_timeout+0x202/0x290
>
> [ 363.185099]  ? sched_clock_cpu+0x11/0xb0
>
> [ 363.185105]  wait_for_completion+0x94/0x100
>
> [ 363.185110]  __flush_work+0x12a/0x1e0
>
> [ 363.185113]  ? worker_detach_from_pool+0xc0/0xc0
>
> [ 363.185119]  __cancel_work_timer+0x10e/0x190
>
> [ 363.185123]  cancel_delayed_work_sync+0x13/0x20
>
> [ 363.185126]  vcn_v1_0_ring_begin_use+0x20/0x70 [amdgpu]
>
> [ 363.185401]  amdgpu_ring_alloc+0x48/0x60 [amdgpu]
>
> [ 363.185640]  amdgpu_ib_schedule+0x493/0x600 [amdgpu]
>
> [ 363.185884]  amdgpu_job_submit_direct+0x3c/0xd0 [amdgpu]
>
> [ 363.186186]  amdgpu_vcn_dec_send_msg+0x105/0x210 [amdgpu]
>
> [ 363.186460]  amdgpu_vcn_dec_ring_test_ib+0x69/0x110 [amdgpu]
>
> [ 363.186734]  amdgpu_ib_ring_tests+0xf5/0x160 [amdgpu]
>
> [ 363.186978] amdgpu_device_delayed_init_work_handler+0x15/0x30 [amdgpu]
>
> [ 363.187206]  process_one_work+0x220/0x3c0
>
> [ 363.187210]  worker_thread+0x4d/0x3f0
>
> [ 363.187214]  ? process_one_work+0x3c0/0x3c0
>
> [ 363.187217]  kthread+0x12b/0x150
>
> [ 363.187221]  ? set_kthread_struct+0x40/0x40
>
> [ 363.187226]  ret_from_fork+0x22/0x30
>
> BR
>
> Curry Gong
>
> *From:* Zhu, James <James.Zhu@amd.com>
> *Sent:* Saturday, December 11, 2021 5:07 AM
> *To:* Gong, Curry <Curry.Gong@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Liu, Leo <Leo.Liu@amd.com>; Zhu, James <James.Zhu@amd.com>; 
> Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is 
> suspended, powergating is explicitly enabled
>
> On 2021-12-10 6:41 a.m., chen gong wrote:
>
>     Play a video on the raven (or PCO, raven2) platform, and then do the S3
>
>     test. When resume, the following error will be reported:
>
>     amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
>
>     vcn_dec test failed (-110)
>
>     [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
>
>     <vcn_v1_0> failed -110
>
>     amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
>
>     PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110
>
>     [why]
>
>     When playing the video: The power state flag of the vcn block is set to
>
>     POWER_STATE_ON.
>
>     When doing suspend: There is no change to the power state flag of the
>
>     vcn block, it is still POWER_STATE_ON.
>
>     When doing resume: Need to open the power gate of the vcn block and set
>
>     the power state flag of the VCN block to POWER_STATE_ON.
>
>     But at this time, the power state flag of the vcn block is already
>
>     POWER_STATE_ON. The power status flag check in the "8f2cdef drm/amd/pm:
>
>     avoid duplicate powergate/ungate setting" patch will return the
>
>     amdgpu_dpm_set_powergating_by_smu function directly.
>
>     As a result, the gate of the power was not opened, causing the
>
>     subsequent ring test to fail.
>
>     [how]
>
>     In the suspend function of the vcn block, explicitly change the power
>
>     state flag of the vcn block to POWER_STATE_OFF.
>
>     Signed-off-by: chen gong<curry.gong@amd.com>  <mailto:curry.gong@amd.com>
>
>     ---
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
>
>       1 file changed, 7 insertions(+)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
>     index d54d720..d73676b 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
>     @@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
>
>       {
>
>        int r;
>
>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>     + bool cancel_success;
>
>     +
>
>     + cancel_success = cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> [JZ] Can you refer to vcn_v3_0_stop , and add 
> amdgpu_dpm_enable_uvd(adev, false); to the end of vcn_v1_0_stop?
>
> See if it also can help.
>
>     + if (cancel_success) {
>
>     +        if (adev->pm.dpm_enabled)
>
>     +                amdgpu_dpm_enable_uvd(adev, false);
>
>     + }
>
>       
>
>        r = vcn_v1_0_hw_fini(adev);
>
>        if (r)
>
--------------kHUPxxVBzTwytJB5AFL0G2d8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Curry, Evan,</p>
    <p>It seems vcn1.0 power gate sequence are special.</p>
    <p>if the original solution is thread safe, then the following
      solution will be thread safe also. <br>
    </p>
    static int vcn_v1_0_hw_fini(void *handle) <br>
    { <br>
    &nbsp;&nbsp; &nbsp;struct amdgpu_device *adev = (struct amdgpu_device *)handle;
<br>
    &nbsp;<br>
    &nbsp;&nbsp; &nbsp;cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
<br>
    &nbsp;<br>
    &nbsp;&nbsp; &nbsp;if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
<br>
    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
<br>
    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
<br>
    +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled)
<br>
    +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd(adev, false);
<br>
    +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else
<br>
    +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; vcn_v1_0_set_powergating_state(adev,
    AMD_PG_STATE_GATE);
<br>
    &nbsp;&nbsp; &nbsp;}<br>
    <p>Best Regards!</p>
    <p>James<br>
    </p>
    <div class="moz-cite-prefix">On 2021-12-13 3:55 a.m., Gong, Curry
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BN7PR12MB2641CA6290B6CEFB4A5016EF9D749@BN7PR12MB2641.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">Hi James:<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">With the
              following patch, an error will be reported when the driver
              is loaded<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">+++
              b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">@@
              -1202,6 +1204,9 @@ static int vcn_v1_0_stop(struct
              amdgpu_device *adev)<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              else<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              r = vcn_v1_0_stop_spg_mode(adev);<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          c<span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              return r;<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">}<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">$
              dmesg<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181081] INFO: task kworker/3:2:223 blocked for more
              than 120 seconds.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181150]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp;
              5.11.0-41-generic #45~20.04.1-Ubuntu<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181208] &quot;echo 0 &gt;
              /proc/sys/kernel/hung_task_timeout_secs&quot; disables this
              message.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181266] task:kworker/3:2&nbsp;&nbsp;&nbsp;&nbsp; state:D stack:&nbsp;&nbsp; &nbsp;0 pid:&nbsp;
              223 ppid:&nbsp;&nbsp;&nbsp;&nbsp; 2 flags:0x00004000<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181276] Workqueue: events vcn_v1_0_idle_work_handler
              [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181612] Call Trace:<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181618]&nbsp; __schedule+0x44c/0x8a0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181627]&nbsp; schedule+0x4f/0xc0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181631]&nbsp; schedule_preempt_disabled+0xe/0x10<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181636]&nbsp; __mutex_lock.isra.0+0x183/0x4d0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181643]&nbsp; __mutex_lock_slowpath+0x13/0x20<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181648]&nbsp; mutex_lock+0x32/0x40<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.181652]&nbsp; amdgpu_dpm_set_powergating_by_smu+0x9c/0x180
              [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.182055]&nbsp; amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.182454]&nbsp; vcn_v1_0_set_powergating_state+0x2e7e/0x3cf0
              [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.182776]&nbsp;
              amdgpu_device_ip_set_powergating_state+0x6c/0xc0 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.183028]&nbsp; smu10_powergate_vcn+0x2a/0x80 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.183361]&nbsp; pp_set_powergating_by_smu+0xc5/0x2b0 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.183699]&nbsp; amdgpu_dpm_set_powergating_by_smu+0xb6/0x180
              [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184040]&nbsp; amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184391]&nbsp; vcn_v1_0_idle_work_handler+0xe1/0x130
              [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184667]&nbsp; process_one_work+0x220/0x3c0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184674]&nbsp; worker_thread+0x4d/0x3f0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184677]&nbsp; ? process_one_work+0x3c0/0x3c0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184680]&nbsp; kthread+0x12b/0x150<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184685]&nbsp; ? set_kthread_struct+0x40/0x40<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184690]&nbsp; ret_from_fork+0x22/0x30<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184699] INFO: task kworker/2:2:233 blocked for more
              than 120 seconds.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184739]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp;
              5.11.0-41-generic #45~20.04.1-Ubuntu<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184782] &quot;echo 0 &gt;
              /proc/sys/kernel/hung_task_timeout_secs&quot; disables this
              message.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184825] task:kworker/2:2&nbsp;&nbsp;&nbsp;&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid:&nbsp;
              233 ppid:&nbsp;&nbsp;&nbsp;&nbsp; 2 flags:0x00004000<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.184831] Workqueue: events
              amdgpu_device_delayed_init_work_handler [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185085] Call Trace:<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185087]&nbsp; __schedule+0x44c/0x8a0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185092]&nbsp; schedule+0x4f/0xc0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185095]&nbsp; schedule_timeout+0x202/0x290<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185099]&nbsp; ? sched_clock_cpu+0x11/0xb0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185105]&nbsp; wait_for_completion+0x94/0x100<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185110]&nbsp; __flush_work+0x12a/0x1e0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185113]&nbsp; ? worker_detach_from_pool+0xc0/0xc0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185119]&nbsp; __cancel_work_timer+0x10e/0x190<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185123]&nbsp; cancel_delayed_work_sync+0x13/0x20<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185126]&nbsp; vcn_v1_0_ring_begin_use+0x20/0x70 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185401]&nbsp; amdgpu_ring_alloc+0x48/0x60 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185640]&nbsp; amdgpu_ib_schedule+0x493/0x600 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.185884]&nbsp; amdgpu_job_submit_direct+0x3c/0xd0 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.186186]&nbsp; amdgpu_vcn_dec_send_msg+0x105/0x210 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.186460]&nbsp; amdgpu_vcn_dec_ring_test_ib+0x69/0x110
              [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.186734]&nbsp; amdgpu_ib_ring_tests+0xf5/0x160 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.186978]&nbsp;
              amdgpu_device_delayed_init_work_handler+0x15/0x30 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.187206]&nbsp; process_one_work+0x220/0x3c0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.187210]&nbsp; worker_thread+0x4d/0x3f0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.187214]&nbsp; ? process_one_work+0x3c0/0x3c0<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.187217]&nbsp; kthread+0x12b/0x150<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.187221]&nbsp; ? set_kthread_struct+0x40/0x40<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">[&nbsp;
              363.187226]&nbsp; ret_from_fork+0x22/0x30</span><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">BR<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">Curry
              Gong<o:p></o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> Zhu, James
                <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a> <br>
                <b>Sent:</b> Saturday, December 11, 2021 5:07 AM<br>
                <b>To:</b> Gong, Curry <a class="moz-txt-link-rfc2396E" href="mailto:Curry.Gong@amd.com">&lt;Curry.Gong@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <b>Cc:</b> Liu, Leo <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu@amd.com">&lt;Leo.Liu@amd.com&gt;</a>; Zhu, James
                <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>; Quan, Evan
                <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com">&lt;Evan.Quan@amd.com&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: When the
                VCN(1.0) block is suspended, powergating is explicitly
                enabled<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <p class="MsoNormal">On 2021-12-10 6:41 a.m., chen gong
              wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre>Play a video on the raven (or PCO, raven2) platform, and then do the S3<o:p></o:p></pre>
            <pre>test. When resume, the following error will be reported:<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring<o:p></o:p></pre>
            <pre>vcn_dec test failed (-110)<o:p></o:p></pre>
            <pre>[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block<o:p></o:p></pre>
            <pre>&lt;vcn_v1_0&gt; failed -110<o:p></o:p></pre>
            <pre>amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).<o:p></o:p></pre>
            <pre>PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>[why]<o:p></o:p></pre>
            <pre>When playing the video: The power state flag of the vcn block is set to<o:p></o:p></pre>
            <pre>POWER_STATE_ON.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>When doing suspend: There is no change to the power state flag of the<o:p></o:p></pre>
            <pre>vcn block, it is still POWER_STATE_ON.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>When doing resume: Need to open the power gate of the vcn block and set<o:p></o:p></pre>
            <pre>the power state flag of the VCN block to POWER_STATE_ON.<o:p></o:p></pre>
            <pre>But at this time, the power state flag of the vcn block is already<o:p></o:p></pre>
            <pre>POWER_STATE_ON. The power status flag check in the &quot;8f2cdef drm/amd/pm:<o:p></o:p></pre>
            <pre>avoid duplicate powergate/ungate setting&quot; patch will return the<o:p></o:p></pre>
            <pre>amdgpu_dpm_set_powergating_by_smu function directly.<o:p></o:p></pre>
            <pre>As a result, the gate of the power was not opened, causing the<o:p></o:p></pre>
            <pre>subsequent ring test to fail.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>[how]<o:p></o:p></pre>
            <pre>In the suspend function of the vcn block, explicitly change the power<o:p></o:p></pre>
            <pre>state flag of the vcn block to POWER_STATE_OFF.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Signed-off-by: chen gong <a href="mailto:curry.gong@amd.com" moz-do-not-send="true">&lt;curry.gong@amd.com&gt;</a><o:p></o:p></pre>
            <pre>---<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++<o:p></o:p></pre>
            <pre> 1 file changed, 7 insertions(+)<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
            <pre>index d54d720..d73676b 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
            <pre>@@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  int r;<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = (struct amdgpu_device *)handle;<o:p></o:p></pre>
            <pre>+ bool cancel_success;<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>+ cancel_success = cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);<o:p></o:p></pre>
          </blockquote>
          <p><span style="color:#288AEB">[JZ] Can you refer to
              vcn_v3_0_stop , and add amdgpu_dpm_enable_uvd(adev,
              false); to the end of vcn_v1_0_stop?</span><o:p></o:p></p>
          <p><span style="color:#288AEB">See if it also can help. </span><o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>+ if (cancel_success) {<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled)<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd(adev, false);<o:p></o:p></pre>
            <pre>+ }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>&nbsp; r = vcn_v1_0_hw_fini(adev);<o:p></o:p></pre>
            <pre>  if (r)<o:p></o:p></pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>
--------------kHUPxxVBzTwytJB5AFL0G2d8--
