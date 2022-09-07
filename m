Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0715C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 19:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0FBC10E7F5;
	Wed,  7 Sep 2022 19:01:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0653D10E682
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 19:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRA5oqV7ov9lIoyyQzShUqRAwjeAr7cI4ahmNNtQi5DaYuaGHpLfxFZwNetjuuKlF5TG1K5Z6RKtXDOWYLRqDpDhkONE0K1JvYCG++2WGUq5w/4MENM8U68MHfv+ZDXaG9g56Ox+QDT3UPbo4eWCHOReILX1OCpd1Tnp1SupDctlMguJ7dA0kp8oAD9X59TNpIu+BgdWFPNpAu9sAArFV/lF7XgGcqVSL0AnAoISJ8oDpd5gwzm7QioLE6uPmymxEouNALkJ56vtj9dDKNdA9nHXWemA6nq0sEdVQ54dKxUqRK3TFTOpBZCIWGawN+Gvd8ehcKxLgOrniN8sijkNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL1frYBZq+Z7BciK+a57yG7Ss0IpEZmjtwS8eRZehDU=;
 b=JbyEC285nPrZrNLp517h/wc81Gl+K3Vv6D/AQfbRKhUHvfrymSuPc3f3OUd/y67R5HgxphLtCr2YKfiscw1wo4lC11Dvd23zemmC3GjQki1H+ZpHjow4j1Nrkfg40il6ZiDKmRQr1L0FxVA1TW9qJXquw+Z6o7sEmKW4J15JmBXB4/w84zrGzB8TmLQ/qPt6i7NUqxOWG6vdEJUW5IC3aB7f8m/b+barBr/F2iWpLdK+AUF4knM4d0DCAvrdtrCNvB5HU7YXviTweC5MxqZC2HITDFG6b9m0gmWl9VELTSVHRnOs/DZs/5NTV6mgdosv6NteUdEkl6YXoxOHYZhl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL1frYBZq+Z7BciK+a57yG7Ss0IpEZmjtwS8eRZehDU=;
 b=kW95sAgH508a4iFw3WbqYqEeJWTs9UJWNqinMnijotXcuzR7GcROQ9zXPXLoID9UZ07Dh6J1TTmu6dUftDVxj78/wuYncOuvahPEwXpxQXd6ppwbXxkS6Y54lfKnTTeVo6M5ccnMuFYVo0RTQmIv9Vhh9jx2sqcPvQdymW4WY0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 19:01:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 19:01:44 +0000
Message-ID: <b3a07869-88d0-d010-e219-75394ffcf5a2@amd.com>
Date: Wed, 7 Sep 2022 15:01:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix CRIU restore op due to doorbell offset
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220907183624.26018-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220907183624.26018-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:610:59::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beed9391-caf3-4588-2f82-08da91036843
X-MS-TrafficTypeDiagnostic: CH0PR12MB5073:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cb4EQj3mB9A66scKBYON2W6HyojCfQq/9mojRqecSHEImIX7jhRtW2GvG00vv3v5eGmV9MZe8DXpVQw/SsBfyer+s3jgWOAyrtqctY4cJHZCKULv9KMAv+Zpr7TeM2L1zIh9jUzCfmcNteCoKz2TRgFlQjm9yVp+5uGd4QrvMfqXHMj31JaaIcg71kg1/C4RqkPDZ4j9Bd6vfSSPC710+0Umo7WY7yvVw3MdLQQMdhrriv9Ip72S/LSYzAzplDyDbcc5POnuSVQchjJ9qzbtEJ6wd16lslkxTl66cwqXsBCs0SDBaZ6ImWfcIjIcUjLx7pK1TfPtGsR1kFOnPhxcQ0+TGHIRU2eDlcUNOeJvlUw08HIBrMDRlO1yioHrkax79NEQOp8BOVHvtdnGaligW/zrDGDrnd/DvA0ylV29ZpkxNFhgns2OC+cqh4+5GQycbdfu3WVh9aActUvhKmKTe9ZlBemdMvckNrMlvnwjxy8JNoKn46fRTjBxxqdxq8oLT0AdpWQnmIFupoZ6sFN2bFQSZbYYdeJjSpjH047X1CU5rP/kkjywW5QzjzgBe8cTmzBjSj0X0opnc5k/bpuQvl587bHfDdDqCg1+IPtctAxIht8dOi71ZqnPoks+Usn5ThSuhb/Ar/tfp8JShcYqgDA2AgIsWTlbomkvp+/voL/CIBGOYozbrS2JCFRQVbhxdFd9zbZh7GZLwSmcZVBKK1dekSFb6t8cPCFh5oP3YOl0C33WWRqP4OT9N9QWUVAdK4kF1Kk8Tx6FDIqipWtTGWk0SAybtJWcQtkYySYZAb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(2616005)(186003)(5660300002)(2906002)(66946007)(4326008)(8676002)(66476007)(66556008)(8936002)(44832011)(53546011)(36916002)(36756003)(6506007)(31686004)(86362001)(6512007)(26005)(41300700001)(478600001)(6486002)(83380400001)(31696002)(316002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1M5Q2xob1A4STd3Y3BtQkhEUUZsQmh2YTZkdGE4bWpRTERtQWFxeVJqVklM?=
 =?utf-8?B?ckFwSXVyMlhqa3VWVkR5aUt4SFBXSTlSbWx2TVpNdTc1djd3ZGsvZEs5RElN?=
 =?utf-8?B?NjYxK0h1MmtZaFZUUm4vRTVLRjlUc0tZZmJWVHY1dW1ZRzU4Qm4zT3JLaXk0?=
 =?utf-8?B?WVpuRnE3Q1dhYmE1dk9xbFhDdHh1U3BtYU5ETVluOVQ4bVJMT3RZR1dIVDZt?=
 =?utf-8?B?cFRINGZEdTdPMGpzMTRKMVVSNkFlVEpFeXZTTnBNKzYzc1g5Z0NTaXM0ZkVI?=
 =?utf-8?B?MVpyUVlYUEVjbWhRR0FWenJDaUNuQ0lUelhDa1dZSW00TDhvTmpJZlUwUStJ?=
 =?utf-8?B?NVZ3czZuZEk1b0FFMmx5My8xSkd4eEpBRVJwWGtCeG5wSTRqVlF1SlpXVnY5?=
 =?utf-8?B?aldSdmJPNlpuUkZONDBPdUpUNk5BbXBraE1sZEhJV3dRbFpkeEhickZ1bGpN?=
 =?utf-8?B?NEtOMm56ck1iQkpHZjJsMHdQZy9xV3JUQm9MNmJmdDJlY1ozRVNGNk9kZUdS?=
 =?utf-8?B?YjVycG0yaDRiNkpwSjV3bm83Sk8vcjZSZGVkSm5jR2YxMWFWcU4zTkZtaGE1?=
 =?utf-8?B?eHJUZTFuYWIrMDVuOUtUMUIxSVVBcEtTejFWTmJpQ1M1VTlyYmRCa1F1dXdu?=
 =?utf-8?B?Q01DQ0E0NjNudVJwQUdVRjFTOTBjbXo1UzRUTnlmalFhQnNpZFNrSWI2YkxN?=
 =?utf-8?B?cUJlQW0waTcwNkNVOVNOTzFSMHBWeUFTbmxTMXZnT3lxbW1oRHV5TWZiSUt1?=
 =?utf-8?B?djc5VTMweHZWVWU0REhCUUxiNTM5NHY0Y2x3Rzc1b2NBcUtsT091UzBYM0hi?=
 =?utf-8?B?dnZlUkdHbVFGNUVVbGtldE9PQjNGUGc4OG1HY0lBQ2pRb1lYWGRIVFdGMG12?=
 =?utf-8?B?NXI0Z1BrYit6WGU4bXRXR2szY1ZvVGVSVnR3UldPampBT29XWkN2eXVrZnZY?=
 =?utf-8?B?eVlGejd5aUdCSWpmS3gvaXVFZ1FCVDN5OFlpTFpQaDljMFBidW5hWWQwcFpL?=
 =?utf-8?B?MFlHUzcyZHhiQzBwbVJqUlI1R2ZQRTNKcW4rQndVZDFGMWdLUlF4YXI2Tm1m?=
 =?utf-8?B?YW9CYmNkYjVYSVVlVzJnY1EzMFZxRklFclhtcmlUZndJVDlTNEZJL2dQNFlm?=
 =?utf-8?B?YWFDNXN6Rk82OHFnbWd6eVVHaW9qVU00WHprc0hjT1VKK1NJa0ZnRGRnaHNO?=
 =?utf-8?B?Wng5dXpvN0JFSzdHWHhaZ01zQXFwWGdKTVM4NnZXemluZ1Q2QmNlK2FGYTNq?=
 =?utf-8?B?MkRsSFdUemRkclhaQ1dxZTRmWWc1U05aRUFaTXdMdDhQVXdBaDA0ZndIb2tG?=
 =?utf-8?B?QXFZdlBiNzZHeVY4V0pxbEF2T1NUeWFqam9hTGtReWxNWER0OUFtUDJZK3RU?=
 =?utf-8?B?UzE3ZEwwcUh1TFgwb2d1aHUvWjByTTFaaTRUc1VDakt5cTZwK2RKSEFvazhF?=
 =?utf-8?B?aUo1bTZjZ3pTUytOTjZqZDNld0EwQldMVitQZHB4Ty91THJKcWlHRWVjUk03?=
 =?utf-8?B?NzZNczZCSWV4K0hGTTZRVHdqVWlVd2hKQnNmbHVjUmhoL0lPUDBjQTNUaGNP?=
 =?utf-8?B?Y2hOTnVpQzcyaExKVmdxYmxIRTVMTXRiNG1NVmpDSnlGbGo5S3NzVnFUemVU?=
 =?utf-8?B?QktwakFKRlZtR2dyWHluNFhuNUpvVVIveFVQWXVrRHhPd0VLcThSYVRWUk5z?=
 =?utf-8?B?WUE1RC9yME44M25JNWZtaWdjRzQ1aDN5NVFEc1daUElYRXE5MnVhc21KVDJ6?=
 =?utf-8?B?WGVCSlZRMW1aWTNJWGh1SzJNaC9SYkxIbXZBZFBDR2VndG1DYVJITVJJOG8y?=
 =?utf-8?B?VjZQSjBrK2F1cSs1NTJsaVV3c2JTMjZYcFJsakZub3hFL0N2Y2ZhUHFPUXVV?=
 =?utf-8?B?K2xma1Nmdm1jVTh6S0J3K3plZTF6ekRMUlBqTisxY0NGbEdUTnBkbUQyK3BT?=
 =?utf-8?B?UFc4amlFSk43djNJNHR5a0lycEkwMktNU29taHlmbnczNDdDdG9RcllzQmky?=
 =?utf-8?B?blF3ZTVSY1NneVZ1Ti8yZlRBa0I5NU5RMk91RU0vUzgvQTBySzNBa1dnZ0F4?=
 =?utf-8?B?bHg2KzdYa0JGNjliblNwZlhSc1Zoay9DQmRaTVRibzBqY3V4S0VOS3lGMlVs?=
 =?utf-8?Q?Wu+NmTXc05qRVFoNb6hlNcSez?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beed9391-caf3-4588-2f82-08da91036843
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:01:44.8539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0oeGT+68CofDgobdqCjgc2D7v6CSvKSh3n5+d1AMU2LGfw8G04kUxTqHb9xfnmIxw0o/Mdbg7eRJqcymr9WmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-07 14:36, Rajneesh Bhardwaj wrote:
> Recently introduced change to allocate doorbells only when the first
> queue is created or mapped for CPU / GPU access, did not consider
> Checkpoint Restore scenario completely. This fix allows the CRIU restore
> operation by extedning the doorbell optimization to CRIU restore
> scenario.

typo: extending

A few more nit-picks inline.


>
> Fixes: 'commit 15bcfbc55b57 ("drm/amdkfd: Allocate doorbells only when needed")'
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               | 8 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c              | 4 +++-
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++++
>   3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 84da1a9ce37c..c476993e3927 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2153,6 +2153,13 @@ static int criu_restore_devices(struct kfd_process *p,
>   			ret = PTR_ERR(pdd);
>   			goto exit;
>   		}
> +
> +		if (!pdd->doorbell_index &&
> +			kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> +			pr_err("Failed to allocate process doorbells\n");
> +			ret = -ENOMEM;
> +			goto err_alloc_doorbells;
> +	}

Incorrect indentation. The closing brace should be indented one more 
tab. And the if condition would be more readable if the second line was 
aligned under the !pdd->doorbell_index.

You don't need a new err_alloc_doorbells label. Just goto exit.


>   	}
>   
>   	/*
> @@ -2161,6 +2168,7 @@ static int criu_restore_devices(struct kfd_process *p,
>   	 */
>   	*priv_offset += args->num_devices * sizeof(*device_privs);
>   
> +err_alloc_doorbells:
>   exit:
>   	kfree(device_buckets);
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index b33798f89ef0..7690514c4eb3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -157,8 +157,10 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
>   
>   	/* Calculate physical address of doorbell */
>   	address = kfd_get_process_doorbells(pdd);
> -	if (!address)
> +	if (!address) {
> +		pr_err("Failed to  get physical address of process doorbell\n");

Please use the same error message as above for consistency. Or better 
yet, move the error printing into kfd_alloc_process_doorbells, so you 
don't have to duplicate the same error message in multiple places.


>   		return -ENOMEM;
> +	}
>   	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
>   				VM_DONTDUMP | VM_PFNMAP;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6e3e7f54381b..9f05f64c5af8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -857,6 +857,14 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   		ret = -EINVAL;
>   		goto exit;
>   	}
> +
> +	if (!pdd->doorbell_index &&
> +	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> +		pr_err("Failed to alloc process doorbells\n");

Same as above.


> +		ret = -ENOMEM;
> +		goto err_alloc_doorbells;

You don't need a new err_alloc_doorbells label. Just goto exit.


> +	}
> +
>   	/* data stored in this order: mqd, ctl_stack */
>   	mqd = q_extra_data;
>   	ctl_stack = mqd + q_data->mqd_size;
> @@ -876,6 +884,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   	if (q_data->gws)
>   		ret = pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws);
>   
> +err_alloc_doorbells:
>   exit:
>   	if (ret)
>   		pr_err("Failed to restore queue (%d)\n", ret);
