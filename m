Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5410C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 21:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2107110E061;
	Thu,  3 Nov 2022 21:18:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF2810E061
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 21:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Meek7DPay3qX4KEA3ru8kDnkLFDKyipaEdGbvjI6CWHHnnBeAD0DcCrvyOAM9W5tsSDzcYvxfA6tSsxMntuoK3zfpEsUJ8jAGoUG6KYnfacQaOQwJciBsakqO+YhrMwfSUt5UfR55yPEV8rC3ONpp98ql6JFXY8GWSOmLNuOrf43iJRGduTIQBjvR8KH/YMkGmkROP21M5FQruEeCsIHcfLNyiOW4SpU84aY1lZcSqVZIPcLES5J4PYuoFZ1E4/40LXHgfwm4CU+sx9biJiWikkx7IpXl5pYbQdJF7lZiQ9gqEwqA7/JF5PVBorLllDJUGEPT7QMFUXXTTxC5xDXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH6RojAdbHS6qvBbaI3YqTH3Bj8BF84KqPbVews53mw=;
 b=UUQMFdmAsWWI20Cd5Txj/NHROC55SR4QzuZ/FW6etTZ47nOeMsyWgxNuTFPYpjdKIWKfHbWrAh+pWGMMhgQJ6GQrV+MfwI4QAPWN7sJYVIdVW9/v6j+qscOEgqiUhGm7b1AAzfDy0J9LnTKk7XrL1B3OeYaHG3KEx0YuUR+2h92RFVGTQEzxLZL53q74ga6Sm7yRm/J/x86dIqrHFWEgZz5npNktDGFy5EFyxkGt+xqRLPXTI71Sr4enF+vhnBVLnZksUqfeuvaOQyOxjHWbSHyilyVPqcECGhd4TLHLEdmsiPETYGBTqnntGua3YBWABuUeSSV0nkfXjuxeqQVmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH6RojAdbHS6qvBbaI3YqTH3Bj8BF84KqPbVews53mw=;
 b=wwBcoNXzGfbbghvCOXhiTB1E9fygVUXH7GXnzAnxttQyjLPeCS0Ewr0ivgETcGUrx1NUg38Gf3oel93uJ78TEL998vNPx3uF5hbXgFrRvY7Q7aVlD3u9i2YG6RBCMgzVY2lC7s/lv1nILCuEvPJ4RpjrEm8jhz7b9XrgM3zMfMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 3 Nov
 2022 21:18:07 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::7171:2174:5962:c87]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::7171:2174:5962:c87%7]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 21:18:07 +0000
Message-ID: <7028da96-ca19-3ec5-b9a1-b2640157ba19@amd.com>
Date: Thu, 3 Nov 2022 17:18:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: workaround for TLB seq race
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20221102145811.17968-1-christian.koenig@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20221102145811.17968-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:52::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 36dc279a-ae5e-4318-366f-08dabde0e6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbIKhgdEE6nnzq+kvhefxKDbQRa7stNfkGB45LRbj9FZ29L6zY4ob3fMAjMSU3xps28guysxqyvmMEdYjjZimfZRHw8OUsrX9MMCB+1QwB5h0sFpEF14q5QNrCWgwR8YXGqB02sbGWbgEcxzo+5e35IfmRoABYp6CmtH/jAURoVRbGdz0wL8CdRINmTjW1+u7OqTuNdZmoVQ2L5MG7LkYPTU6Kq+R+XdpO9kNfGjq9qLmJg/A1KQQ64JmwMrC72XkR9I24fS9jl3KnY1bzdpUH4FcJE+BnTlyMbePrHP6IRnjh52XSuxR46koHWmclnl+TqdAg6HJzeu1ix2cwfGztxc/kTya+MMGWL4SL6n6IoIxfKcP90AE0gM902drtdEVmBlEMuTLWDckcDTBV8h04YlhHBRlVXFIVptx3Jgki9GniLSOT1aA58b5Ff6zpLqu2Z33vInr5P5t4VOKjJ4xlNQZ8vqbHTcnQGSWNFHipqCeeUXUoslbY/75zc3o/2Ex/3KJjQxAdiF3QKhzbtrtvy1QgdguHro6P6dYZS1Q2Ip/3tuRHyoKmX3Wao1kh6zvEwvQKU/0UgFMDHhC4dyHffmkQHZ6EjUMfJ8Mr1ivhFRDTX3mndPKbfrCPVNsbYaQUeyyirBNPlfAaCAsTYOyPYUE5mEXJnpdKWQdfVB/MwY+Kj2kignHy9TJdW6LgdR4SwiF3pP1FctEnLyEPF918SlyhwdAtEWhyG9j7CeGvGOzYGzE02SVGWXF9v5NfC7uFArNI3HSYmto/Gv8hinZw5xIbQv4dv/rl9W5VTEpVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(26005)(38100700002)(478600001)(2906002)(186003)(66574015)(4326008)(6506007)(6512007)(36756003)(316002)(2616005)(83380400001)(31686004)(66946007)(31696002)(8676002)(66476007)(5660300002)(6486002)(53546011)(66556008)(41300700001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enEzemhidzVFRTh6RW1zWHdyWFhhNGNMcDlLSmFSTm9IRlpkT3J0MlUvaGRa?=
 =?utf-8?B?aG1zdVg0Q2lEQUJaT2ErVUFwMjJuZTlLdElKKzZrRzdKeGJ1bk9mRE5YdE1J?=
 =?utf-8?B?VHFKR2tqUXJxUWc2MFk3aXBscFlwNzZpTnJkdmJQZURtcXNBcXh3YVFRMEtm?=
 =?utf-8?B?ditkL2lmUzJYS1I3K0FpaCtnVWY0SU9FMkF5K1ZIa3Rncm1GempwQ0JneW9I?=
 =?utf-8?B?Ung3N2VQWHVXb2ZnVXZVbnU2L0kzVnBTS0plU0lWbWE2bHNBWXU5a25pek1L?=
 =?utf-8?B?aTl3WVU2aHVNMS9mbDAvZEYvMFFIb280Z3EyU25pWGZUN0F6bnZydko4eG12?=
 =?utf-8?B?Q080S2Mwa29EQTBpYlZsVjZkM3RUbHgvY1RHNWNCNzNXQ212UE1ZRWpVbG1E?=
 =?utf-8?B?Wmh5MlgzNEIxaERiWmZhNDZNLzRsMmFYSXByaTVuZ3BhNHhzN3RoY1QwTTdi?=
 =?utf-8?B?eXpEdnFENjZNdnZXQmIyR1d3S09ZZDhTbnM4ZGR2c0ZsMlpTa3pJMC9lemNY?=
 =?utf-8?B?ZE5CTmE4VWxGU1NPSTRqN3BLUjNtSHhoR2RiT1NMeWVFWDlLNGhkcWVQUGZl?=
 =?utf-8?B?bjVaR1RtZ2t0b2Nsa0FLUlBVOFRoYmk2QTZicW9QNjZvZUpvL0J6ZnJPRXZr?=
 =?utf-8?B?enQ1aUdiQk95ejhsZWZ0ak9MVmJPdTJLQmpCOE9EWG9ITEVad3dLMUVzL3pW?=
 =?utf-8?B?ZlNlL0swem1XUnR5c2tBNHFQaDY2aHRVUGZ1clZYNDY1RDJhVGx4Q3pnQkFy?=
 =?utf-8?B?YlBWdzl2R05aWExsQ09kWG00eFk4VG8yT0s1ZDBuYUlEYnhSVTdWeXUrY2J2?=
 =?utf-8?B?N1gwVER2bkI5TStRQ3JCckwySmZma1JlZGNWTU5uM0ZVOUZLMWgxdTh5M1Bm?=
 =?utf-8?B?VExWNkNLY2piVzM5Z01XYmN4UU8wT3Y4cGxOVE9hVTV5QmIyeUtHNjBSVVNC?=
 =?utf-8?B?M3Roajl2Z0FaaHBxTHM5RENyamY2aFd0dVlGNnZGbWowdndGbUlDOTlDUVBo?=
 =?utf-8?B?TndFb3haVWVBOTRiVzY1cEZ5L2pDWTVqY0xmaStzL0xvQnFDaSthTjF6bU16?=
 =?utf-8?B?TzFJbEZjZ0lCeU82a0M0T0ZaREpMSGRxTzlBbVBYd3JQQUVTbEEvVlY2QkF0?=
 =?utf-8?B?NWExRGpxbWs3Y21MdEFRRDdwMFd4K1plVGtFZk9RS2lHd2J1YlRWL2VWZDdw?=
 =?utf-8?B?WVZUSXMxUXJKbWI1eWF6Q0FHQlg3L0ltWEs2NU1MWTRjamlGV0sxUnp2cnVJ?=
 =?utf-8?B?MmtGbEhZVDhxOWV2bmd3QnhUdi9DZENhbHNzZEFBc0xuYjV6NlhUWStDMFVk?=
 =?utf-8?B?QjBGbFh6K054V1VaUjJqcXZ6azUxOXhiVEZ4SllFZDVRWTlMM1VTRWJsa0NP?=
 =?utf-8?B?M2pPWmREdXZlOFFpcmxENHdsT0tKeUxjY1lUMG40b2lhK3pFK01nbSt5aUVv?=
 =?utf-8?B?UkUyMVRsOTNFem5QMjF3bkE3MjR5ZTQ2R0VqdWp2VDdWREFMRkJGZ3puRDN3?=
 =?utf-8?B?RXdxc0QrT1dOUmRYM1ptV0RiZHl1N1RVZmVtOWkzbXZiT3NTWHlhVXlYYTR1?=
 =?utf-8?B?bitTWVB5TU43QUpQRGVCdTA4ME8zWGY1aExERERmYmVUZFVKT2VBVkRCSTlx?=
 =?utf-8?B?L092QjA1aHl5TUZKTUlNbTQrbmNYamswTUUyZDlZdlpNcnpJTWF6bVFBMDJL?=
 =?utf-8?B?U0ZvT3VwQ01KL2x0bmxJbUM0OFE1MkorT0ZHZFk2a2V6Nk1ubzV1cUpEN2Rv?=
 =?utf-8?B?djAwTGZFcUtwRDlaSG5qMGdGVEpCUllzLzg5TkFqMW5JbmRYTDh1L29nazZh?=
 =?utf-8?B?TktZbTFkTnQ1dFQzYk9ZZmlqVTRRY0FWNGdyOGhzOVQzMXJaUEVGN2M5VWdI?=
 =?utf-8?B?cDM2eC9EZVN3Z2xHdFlZUktEZ0pqTG51RmFhdVRuNXVaS2YxYmNpNnZ5RlRL?=
 =?utf-8?B?YVhvUU5OM3dkL0F1VkNWa0xzOUJuMnBiYzZ1aDFRY2dHWUd6ZVUwWUJ3QlMz?=
 =?utf-8?B?YTZXdHdLdURhSHdZL0FzdDdKV0MwL2xJQ1dwbU1wMHhrUXM1czBiRTB4b0NO?=
 =?utf-8?B?NEQ5M3dnWFZpUE1uL2ZyWmo3c0FDN0NuRnVBdUx3WkFmRzMweGZvQjI1SG1s?=
 =?utf-8?Q?ztGU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dc279a-ae5e-4318-366f-08dabde0e6eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 21:18:07.1938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqgfmAVVwjVqfnuDZGEAWLPgRS+TfpOxIFJ3shC1OEXjiNyTqYN+vDr/jkSm523E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-11-02 10:58, Christian König wrote:
> It can happen that we query the sequence value before the callback
> had a chance to run.
>
> Work around that by grabbing the fence lock and releasing it again.
> Should be replaced by hw handling soon.

kfd_flush_tlb is always called after waiting for map/unmap to GPU fence 
signalled, that means the callback is already executed and the sequence 
is increased if tlb flush is needed, so no such race from KFD.

I am not sure but seems the race does exist for amdgpu to grab vm and 
schedule job.

Acked-by: Philip Yang <Philip.Yang@amd.com>

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..e51a46c9582b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -485,6 +485,21 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>    */
>   static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>   {
> +	unsigned long flags;
> +	spinlock_t *lock;
> +
> +	/*
> +	 * Work around to stop racing between the fence signaling and handling
> +	 * the cb. The lock is static after initially setting it up, just make
> +	 * sure that the dma_fence structure isn't freed up.
> +	 */
> +	rcu_read_lock();
> +	lock = vm->last_tlb_flush->lock;
> +	rcu_read_unlock();
> +
> +	spin_lock_irqsave(lock, flags);
> +	spin_unlock_irqrestore(lock, flags);
> +
>   	return atomic64_read(&vm->tlb_seq);
>   }
>   
