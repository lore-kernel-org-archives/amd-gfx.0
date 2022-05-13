Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D87C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 08:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2457410EE40;
	Fri, 13 May 2022 08:21:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931F710EE40
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 08:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvsV1xN40hsOwNQ4zhMK6BK3GxU1iC6eK6uE40BzSHZREqXOpCA0gmQFAfA9xfp1JnAc84R5orC0cvm9E49BEhlw6m1MYggXisCrSbOgqB2sXWkpaGm917vOJlEghx6acWBQCYCg7sMOjs4eeHJQ5AeE34Dn2OjRAx//mlCdjiJ2m8L7BidcYeIg7Iy5XbliRCMcvheuQ1R5RQsd48aqnBXlx7aR4SjYXD2e59FFIc5IRXcCHTVK5knzv9Di75TfhjH9X9pnOgNTzVvfKVsIavp7MvbpVVAGFQUHcH71OXOeyL2isedOvnJX8/pTCjUzodzWTH1EQ1WTj65TN99iQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0WvLaFM9lTeCROJInJ1aWeAdVfw1weprirJBG7TPZw=;
 b=fN25p3J//rLsmCeqFORH9/RgmaDLt4bQZE4nUiq9SE67iFDYgWxlrUlWR2VVG0VKXJQKB7leFGGCZeZrwFjsSkLjDhvGpmUwZXumL4KnikuzPr5CwBipadwE57iilu+YTsSSC6T/271nSD+S7PND5DUY+lx5z9zmki5tEaCz2N+AL9lP2krrEWb2sq/YZB/TSdVzP239Max14OnfrJFiVTrjJtgK58c/0Lo2ExtTh913OkQ6H1Br692AZ4xqOiY47/GB+EfzmQ8Y5wlBH8Z0jFblnNjxJa4z1PfI/6wzpm8fxvg+LqaspjPCl1RyZiVQ7bDOqDQcEF9i/6jn37VUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0WvLaFM9lTeCROJInJ1aWeAdVfw1weprirJBG7TPZw=;
 b=NR0R7XJR0DsdPfvEIv7sEczIJhAIqMCf0CmCsdGLeOX5w2FyMGNpzjIiJU4c2IhgzAIShfsVfMqqzWWjO5QDqojSell8JMtA66Y1b5gbV0EHoM07S+N9MQDWk/k0T2318LHWJkLyzEQSILLb36Q1O+3ehF6UMsuWu82nduQvKMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 08:20:56 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 08:20:56 +0000
Message-ID: <45e3bfc2-5d4b-c84e-1191-62ef679c15e3@amd.com>
Date: Fri, 13 May 2022 10:20:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add drm-client-id to fdinfo
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220511120250.3066-1-christian.koenig@amd.com>
 <20220511120250.3066-2-christian.koenig@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20220511120250.3066-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::32) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb27e0a-61f0-4c79-2a1d-08da34b9807e
X-MS-TrafficTypeDiagnostic: CH2PR12MB5514:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5514CF46AEC1BFE71F88A600F2CA9@CH2PR12MB5514.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvqnPtKLJi4E0kXgr0cT1Mgzlca8Za7qfVheNKZinuYoizmVxOoysvayLtHUYi4h9Uee++pyIoQQRfzsHWLb7IU/XhzT6QKP3maIahW1M5Xt49gZrXT2xyh7ZBNNn02q0lfI/TVJ6T2uJBCOLjj7Yr4QI7cIQzoNZqq0pCQIKlJFbtP6vthqmfMeEoKZPspq2rJB/96OqbDsYqQ2hA//xNjGJ/4CkXG5I+nmKuhyEaGSqUFy6dxpmDDLU1RNQmWIez8MRJtqE/B835gjxVwd4TQ1QXxxe96PNfUFSJvSmu76InCvaEQSEia17QkV9U6S2rFE0iSL46V4Co9q7mfqsJGdLVp8zQBIXGl6SHgJqkG2chnOh/uGbQhfLa0SZIwGNWB6urVATii5n/tML8ljeYO7e4VhWG3LqfCXTo3aYL9efAIdnr9xspr0sgeoYOE1+9NAL9tBs/6u0U6XByiBb5bZVXvhqq47KQp1v6zfwEQZgVSp2a++UQZFTEbwn5/vfPbMsz6uNhHFC2vP2AJXyjW33IJGK4SP/78BJwxwO4NSANxjdvVtWAETfoV29UH3kd9PZKtdb0fUGJ4i95Ln9yAdcLVSXwaHu9ybpGyknwPttp9JK88+W19HdKmyajB5x+9qqoBDHA2f/Rr4KcyxEsnUfjUB0yHyGs7+SDYK7Q35HUiGrCRYy8eD4vCfu5IScJRo6wlIO1VucJ+XSFDQWmamR614L2j9TqxYajPlFW54A5tV9+R6cHbLoHQUVzvq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(186003)(36756003)(83380400001)(38100700002)(6506007)(53546011)(6666004)(66946007)(6486002)(316002)(508600001)(8676002)(2906002)(2616005)(6512007)(4326008)(8936002)(31696002)(5660300002)(86362001)(66556008)(31686004)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZkeGpkbnVYYXIrbllqQU96b2gySDhTNnoxdkFOZll1NDlSZVZVaDd4bkVo?=
 =?utf-8?B?Z0lqTTdEVmsxbXppRnpYRWJtV1BsalJwa3FRQVJXejhBV3lUMklINnFiSXhF?=
 =?utf-8?B?SUQzVmlYOU5Ga244aUtmM09JUWFpNnFER1FsTmdESGpEanZIWDREZFBNTnpa?=
 =?utf-8?B?N3hRK0JwSEZjb2RyZnl3RmVTU1ZCdmt0THN6NVk2Y1VDQzVraHZSaHZnTUNK?=
 =?utf-8?B?V0hQalhSa1l6a3c1TklaYlF1K2d3a3hUNk00RkxGcUpEQlBPdHhvWlV5Tmd3?=
 =?utf-8?B?bVZOaXlaS2hreTdjYW5LajArN3J4K0NlNmJ1dTBKaGJ3aU1VZC9IL2hSK1FS?=
 =?utf-8?B?em9JUjJYYW91ZEZlVE1Zc3ZURGNEUW4rREw0NGtDUXhiOWRuWjBsTHlnaERI?=
 =?utf-8?B?ek5jaHNRQXRCcmJPMGp3WU9iSklQMkU2d3JsaW93VXA4d1NKL3RadW1BVk9n?=
 =?utf-8?B?blZNN2lCZjd1RHdDaU5JazRkeE44d3RBOEYrYWdoL3M1dmNOQ2p6U1U4Mkg2?=
 =?utf-8?B?dThnT242clVpTDRvbXp0bmk0bHY0TEp3MEhncGtQbWJTcytiRTJhcFpSU0Vu?=
 =?utf-8?B?NmNnTEo4anhpSVZCZlMzYXdZRkg1bFpMZndpMkVTdldmQy9SYlFQS2NqWHh1?=
 =?utf-8?B?QlN1enJoKzNRdzQvTVZtN1AzKys4amRXZUNMYmR0cnV5Sm5uMncrVGQ0VnJK?=
 =?utf-8?B?SkZCTytZODJUZjdhRVZsdUs5dHNYUmdXSUcvTkUyc1hvYzlrek5DMWV3bG1N?=
 =?utf-8?B?bFFGbXlDcWlmbXNSa25YU1lhNG9MdmMvdmJOSjcvVlhyVGU3dGNuMXdZYnhu?=
 =?utf-8?B?ZjZsQzRJYjRnMUxRbUtwVzlWUVlzT1NMOHo0aU5mbXlVd1N4UFVsaTZCV3BP?=
 =?utf-8?B?TGduaVl5dlY4VnFzR1lWc1lIQndqanFOYWRGRDcwN2tsSHFoc1VGdWVCbVha?=
 =?utf-8?B?MTVhY3k5dDg5R3g5dVRtb2VzVUl5SjhNaU01WTBKbkZHbzBWN1pSbklqODJN?=
 =?utf-8?B?b0lPSWU1S0lreGw2UTlENktqQkREdUwwQkM4UmpxUWJrcjhFa3V2UFBzcFRj?=
 =?utf-8?B?dzJRNTVFU0Jia1dFK1IyMkJhRDN0QjhaQVEyY29NckFXdnF0aHBGNEpobUNR?=
 =?utf-8?B?a2ZjeUJkS1EvVXR4WGRkRVhBVFV2cW9yeGQrcVI2eWJtTTA3QmR4QS94ZGN3?=
 =?utf-8?B?OHJkVkcrRUNucW5nTmdMbVdwQlI3RmJZWEVMU2RCbUlLY3ZUeFBzalFpQnpv?=
 =?utf-8?B?aTI4dStROGE1VU13dklDWXM3SE8zS2Z2NHhHK2pxMFRBdEN4UFZURFg3YkVQ?=
 =?utf-8?B?SVQ3ZEtxTkRLa0FZY01oRUhSL2xHem9VdC91a0pxR0toazlHYmNrdjRlM0tk?=
 =?utf-8?B?NWYxL3g0aWdxL01ra0d0QzNGakk2ODV0d3ZNRlRPVDdQZkNhTVdwdHlxVFBD?=
 =?utf-8?B?NEU3K2pFVTV5K01NZHprblpxTTRKbkZiajE4aEUydjU1Vm51VE5zanMxOFY0?=
 =?utf-8?B?bGM2WEQzS3E3dUk1bHBBVzVmSTIzUkllRGJFUC9LbW1qdldJMHJyalN5ampK?=
 =?utf-8?B?KzBkWFhWc0xDV1lLdjZFTUh1N0h1eXUxRU9hSEpUY0dDS2MzemJndXdUM0RP?=
 =?utf-8?B?Y1ZIa0NEcG02UVpkTXkrL1NZOHZwaXYvYTJEQlVTN1QzNEtCUGxkVEw5WG96?=
 =?utf-8?B?U0VXQ1BlemRaTjBMclhMOE5WUEszUEVSQXFEdzBabW96cmwyc0hmeERKSmhK?=
 =?utf-8?B?dWdXbzFLT1ZFTEVKeTdaalY2UVBBaXNvT3dFSHZmVGxDazRaQTFsSHZrWHBK?=
 =?utf-8?B?b1BQM291N3llZkVpODhDcTMvMit3aEJ3aUZzRGxxTzFIL3RTeTBkeVloREMv?=
 =?utf-8?B?d3ZJQ2t2UGJVRjJ3VlB0VzgzZ1grbWcyUEJ6NlN1K2ZtYXhDYmNqSk9mUUxU?=
 =?utf-8?B?SVhUUmcrZ3dkbkNYbDBLaEhhT2FKbGxWem8xbXBhZkpJbFY2SFJzOStnR3dC?=
 =?utf-8?B?Zm9qbFJOakNGdDh2VkI0cER4bC80N2ZYOEptaTZvdlR0eDdtMmJwOElXaHp1?=
 =?utf-8?B?clRlSEM2Z1c4ZXMwQWdrdUNBNzlmbm54WnZPNG44SUxKc25ZekZ3bzc0TjFm?=
 =?utf-8?B?WWdKb1dkR0w1RXlZZjdhdlcxSGtFTWZyVGtLNWFaSm5TTnQrRjJXbVFHbFN3?=
 =?utf-8?B?MDY3b3AyQ0FQQ0tRakNlUlVPUjZEUW00WndFc2FjUXA4d2JLQnpzaXMvM08y?=
 =?utf-8?B?YVh5UThkcEpDWE5sRkZqQVZrU0lHejdSemJmcnRpVHFNcEE3aUxVUTBDZCtO?=
 =?utf-8?B?QURDNjZ5Ty9qQkZXSk9qdTg3L0VtVUtoczQ3VVVuVXFUM3ZJMWhJZG1TWkhx?=
 =?utf-8?Q?rzVm6bt60N2s/x9zneykxsS54NdgXWInURMILJUDqjorD?=
X-MS-Exchange-AntiSpam-MessageData-1: genFFwg6aPUH+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb27e0a-61f0-4c79-2a1d-08da34b9807e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:20:55.8348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+uUqJThxlC/gKp2yPhViqZuEsP3ATAKoEKcISKx/odlrsoXagWxIkqzQFa72kTQcE72io99GDT7ca+CAZVS8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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
Cc: Alexander.Deucher@amd.com, tvrtko.ursulin@linux.intel.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, daniel@ffwll.ch
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/2022 2:02 PM, Christian König wrote:
> This is enough to get gputop working :)
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 52c2b90925a0..780a48259682 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -55,17 +55,15 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
>   
>   void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   {
> -	struct amdgpu_fpriv *fpriv;
>   	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
>   	struct drm_file *file = f->private_data;
>   	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +	struct amdgpu_fpriv *fpriv = file->driver_priv;
> +	struct amdgpu_vm *vm = &fpriv->vm;
>   	uint32_t bus, dev, fn, domain, hw_ip;
>   	struct amdgpu_bo *root;
>   	int ret;
>   
> -	ret = amdgpu_file_to_fpriv(f, &fpriv);
> -	if (ret)
> -		return;
>   	bus = adev->pdev->bus->number;
>   	domain = pci_domain_nr(adev->pdev->bus);
>   	dev = PCI_SLOT(adev->pdev->devfn);
> @@ -93,6 +91,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
>   	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
>   			dev, fn, fpriv->vm.pasid);
> +	seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
>   	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
>   	seq_printf(m, "drm-memory-gtt:\t%llu KiB\n", gtt_mem/1024UL);
>   	seq_printf(m, "drm-memory-cpu:\t%llu KiB\n", cpu_mem/1024UL);

Lgtm, please feel free to use
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
