Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0B2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B351C10EE19;
	Mon, 30 May 2022 07:48:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CA810EE19
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebvIAh7N1PTvsuXa9RUHiX+LF8xeb0ED50fWtA9f+sI/l1PNzRcoU4+0M/Yc/NQJCKKqxNueTlTmkYoTHb9jpQfMqwrZ74jnSe7L0xGLDdMx0UkXZKmSWm2aXnT/B9iTFH16Eb+HOKBIFmbVsc7whKUPNvQik53afF+R2A8GYTFtjSVbxFyM7c9BxjrW9uoZ5KxsvJcgWl9OvIQKp6mCqVtbVY+dslApt0DAS/WsI2Jaj7hfqqJgdl/Csggrv+3mLxewkLXJMCuil1h8bVLtOdqkTPOfRE5qAqimsLghZG0LYQ/9sT0mM4XFVenUL/DXhFF+0MivuwbYPovoBCfCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrgTp5u4ZiimPUUd2N7lvsIkZwMGRKqT03B/9szsd1U=;
 b=T/j+dMJq2zSVuI/hcsGkbdP5Dlm1zkmP7KDZ0eUvbkbsFpV4BKZHt6coiL9WatxJz3MIjgm4ccud6vDS878Bq0SbkkONu5dhfgm98FM9yuSLpoG7sGiRoCg1+7q3Kd6Om5kTnimHPf897OZQfud8N7fdMVXUKDI+gOIT+opy+9zUYStTUsaZ7FCQbmvcOtvcf4Mda7oHWAVy/mvitZd+DTqoglhUVR8VT6IoEmaELkbWlnxTvYWwlFxdVAOCcXZ6YpE3WA0oOndfZOnCBfhKWFCytxMTrEyKxWC4UgNjGzRJ3bSiDWgEkX4Z2uOj5QfYUdFh36W7FiN9ZJFMsd23WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrgTp5u4ZiimPUUd2N7lvsIkZwMGRKqT03B/9szsd1U=;
 b=K8Z1oFYRu5O4bHtJlYsYLp/39En4KiZHtK3ESfq8B0jNXBLg9V5NfWEvU7QMUkMwT5CgzC6cVDwutTloROc/qMEmElxBylLVi9TbrD1HaYt5Zey75O1d1cyxT/f8FtlUx/5oSO6vDmt5g5SAa3UXbJy+8vliAdsAt1tMknNnKbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 07:48:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:48:00 +0000
Message-ID: <cf55966d-7352-3266-b045-b7e966fbeaca@amd.com>
Date: Mon, 30 May 2022 09:47:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/7] drm/amdgpu: Cache result of last reset at reset
 domain level.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-3-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220525190447.239867-3-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::30) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98d330f6-67ea-4e79-7144-08da4210b85d
X-MS-TrafficTypeDiagnostic: IA1PR12MB6139:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6139D151DEADA3FE8D53094A83DD9@IA1PR12MB6139.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5HA+5ywhSq/VrCZhcHBL4AlaqtMjIDWxA1G9lg5HM5qhGou9VWxrQHjr8ql9yVE5v45oph1itntbcpqVqSKlZiDUODp4J244Jz0qnu3oeySJm8sumble3y62PJMjr4JAzhrs9i52lLIzQjVcVdNzdh02gBrOPpcmwlLR8kRCVITfzhHdufmi1KwBlv0p1EjmuOQq6qG0d9M1gznbtco1slOowRGUou3ZZlehM4V+rbJY2smDOk2kPyyhOI7+/+AXWuhJ+0SAj4kj6tIRrIeQujQ6YIjkjpGvmWbNakzrI1x1tMmZg+RY11hwTt7di+rtZMj4XDUyTIkGyKQINiqy6S9D7gyYxrBb7hWEYk9JHsKdxlOFwGmNoSUHoJPcoYB82i4epoXwJN6t63p9swCcwsiNB8QgGGlFeAIoODQszF9NLoTK3AA2eKJvUCRhqJBXPhryDblvctDj2XFHapIJ/N/WepRcXMFDdTK8ypMqZ/IpxA/PowVStqOQJgjMgOQL2xNup3I+mUfTf63eBy+aFsAKl2sWDCMl4E1OQikxNiFWHmVsqDxp3Y0g5AvSpOU8tVthxdoG0gW4UBpX5RjaWVXlzcySuHo2KGOdb+dH0c17qKcj3iOWuF0/9lNEuO6W67XTR/7GN+o6A1mDFm1NUBqj1CJs+xdv4L+8FsC2XHO/0vADO8ZsFsMgwQYKPeNDpw3gmwExbcYwoPVSUj3YcImaFw7EauGhTRmfZb6P6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(36756003)(6666004)(8936002)(31696002)(31686004)(6486002)(508600001)(83380400001)(2906002)(316002)(6506007)(66946007)(4326008)(38100700002)(2616005)(186003)(6512007)(26005)(8676002)(66476007)(66556008)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTkzN0grVXVMYzhWcGkyVVFaOTROZi9EQS96QnNXUzVzVmxWUmR2anNkWTNS?=
 =?utf-8?B?bXJHUzVRenk1SHFjbGdFTUhjODFEbTJIVGpZNytjditxWDV4OGxpaE93UmU4?=
 =?utf-8?B?V2NDTXNSYndqTnM5ZEM1SDhyWWlrbFhGcHNlRG9kUXBxeUZSek1hQnpxSXg1?=
 =?utf-8?B?N1QrOU1pbDBjb0hVZkxBQ2lUaUNlaWpNNWROQnpNRUVsT3pCL0FtbEVPenpT?=
 =?utf-8?B?dG9SZHdQQUNOdFN3dXpEOE9IVDU4QXMyanhkN3VRZUVyUFRSVXh4emhCWHRt?=
 =?utf-8?B?M3E4Y1RXYnZxWml6WTNORkZFYTJQVFVjZjdtTXBjbkQwdGpUeG9JQkdkYkFn?=
 =?utf-8?B?b0dKWkpiUUVScVA3T3FGcUQwSGRRMW45dmlCUzZySHlWZDRranZFWDBmOHJy?=
 =?utf-8?B?Q2lhbHkxVjVKS2pwU2FGVDYzOWlXNnFrOXhmTndQbFQ3cTJuTllYYU5GdU9F?=
 =?utf-8?B?eStHeFVTakMzb01MY05vb09ZWUNqV1gxS0R0dHRML0M4ZXJXbGhlNDV6YytD?=
 =?utf-8?B?WGVocG9hSzI2eFIxcnVYaC8zWmVnaDdFKzdJTE05b1lRTUovUGY0SzJKZVFB?=
 =?utf-8?B?UktLZzZVOWZObnlOTHZJaWJJTGZvZjZsZTkrKy8rRGRac1BONTZhMzNTOTRp?=
 =?utf-8?B?eEtEazU1S1BSL3JzOC8vcHVqL2tQRWFvWk10QUh4OEp4OW15OE95aG15eE9r?=
 =?utf-8?B?S0s0NXFCMHBLTUg2MG9iVnlTNXhaZzFRSy9DU29WWHh6eTJRcXBTQkJ6am9H?=
 =?utf-8?B?VlNKWktrU1BVOFhFdmFMbDdUamNSM2FlNWlLRmpXUkdXekZWL294bVlJTXdv?=
 =?utf-8?B?UVRDQ0VKNlFRS3IxaHkzOHFzSlRNWVJwcm15ZWttV3Y1VWhOeEphVm1YdkdU?=
 =?utf-8?B?d0ZJVDRWSFFrNHdHWmMxbFhHdU5idXl0M3ZxRHgvMnRrbU10VmVnbUR3cmg2?=
 =?utf-8?B?ZGVObUUwQmlvT2gxcmxnOEc0QmR4ZjRpVE0vZmV0NGZsZHJibTBoWDl5V3hC?=
 =?utf-8?B?QmRWNUpzTjZGVHo4VkJpYzRoRU52WXA4Nmo0bjNiNXo3UDVvVkUvSHBFajBv?=
 =?utf-8?B?Y2VVQUNmRzJOTnZiTk8wTXhqbHdDcnIxUW9uaW1UaVR0bk9rZWo5ZTZsem9W?=
 =?utf-8?B?cmpaOEQ5cFVKbTVRdldtaDltUW5sQkZJaDRRSVBicFFBYVBwOUNFdkxiRGh2?=
 =?utf-8?B?VHE5T3VhVmJKejl6YVhtVjJQYmV0VGZqNkpaZjVKQXhJdGNrNEF2bEE5eHlB?=
 =?utf-8?B?amFxbUlkL0RPckVZby9wRUdYWTdKeUpZb21uM0E0dmhvdEdOVUYzcHg1Nmpn?=
 =?utf-8?B?Q2ppbW9xWW11Qk5GR1B5VlJhR3RNU1F4dHNzK3hPNXFnUXllQUFzV0VPS2pH?=
 =?utf-8?B?c3M3ckZEMisyd1hmWEpKdGttSGdJTlJmWjdrMG9oTHlzMFVGUEJ6SGhkQ0ly?=
 =?utf-8?B?bzVySDlvMStyVGpZcmJuZm1IeTd0bm5sVC9rVkZwcGxFTXpmdk9JSjdhbmlS?=
 =?utf-8?B?cnhCVjY0Q3llQ0NpdUY2S0Z3Z3diZitWSU9CSThKbWIzZVQ4czdMM2kyNG9U?=
 =?utf-8?B?a0JYckt3d29HRmZMZkR1QiszdURZRmZYTHZycUtYbTlWeDZHblFOZUlKU2xQ?=
 =?utf-8?B?Q1d4d0w2N200ZWphc0VSVlBGd29DS21lV05iNkdQMGk0SFRZUC9GaHdmNW16?=
 =?utf-8?B?WENMVkR6RXdpY09nZ1QrUkJpUm5MclI0OEFXdlNIYXNkQVVITno1NTIxbjZL?=
 =?utf-8?B?NDVsTzNyVWNNclNGMy9pTUJub2kydmVKR1QyNjRoNDRpSDVlMWJOanh1R3BL?=
 =?utf-8?B?UG01NWVvclYzOWRzeWxCR0F6NWphY2FySG5iS09TWHlRS3VCWVpaQVJ0QnJI?=
 =?utf-8?B?TWRGUnpkTGdrRDM5MWg5a2d1ZmRTb3pieGh6YXJjUE1FeHc1RitaeTU5NTJs?=
 =?utf-8?B?ZlBjeXUwR1V0YTVTSE55NnNBK1Vrbm1RUWJZSDAwUWZWUFdQR1N4dkRwb1d2?=
 =?utf-8?B?dHFvK2gwQjgxWTU3Yk9uQ0c2WGRKTFlnS290cHpEN2FxOUduUVM2dEtpdW5a?=
 =?utf-8?B?dzFiY2krazJPL0VxVGdtRDdNTk9pa0drSEFFVmJyZC8xbE9vNWU3dUxvYkZo?=
 =?utf-8?B?OUxqQkVhQXkxakdtOGxBR0dGTDdWODJqRjBIN04rR0crcnZ3ZzQwcWtOUTcx?=
 =?utf-8?B?R0o1NXhtM3phQ2JRbFVLYlFUMmlPUFI3SVViaUdROWpaNXRsS2JBUkNrQTd5?=
 =?utf-8?B?NEcyaFJWYWtUcEU1T0p2NnRDQ2JoK1QwUzB6RmVpT0xTY0lmNHhpbnlRWVA0?=
 =?utf-8?B?bnNrSmlaeGZPVDdpL2VlOFlZRGh2ZzJ0L0VQdFp1Y2RuOVV2eUtyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d330f6-67ea-4e79-7144-08da4210b85d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:48:00.8731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlrhGJ3OC7r6Qqvdp87uz+rtaN9ryx4a3DvXQ7lEFqD7sVuL4Wpavu+9PkEWjttP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 25.05.22 um 21:04 schrieb Andrey Grodzovsky:
> Will be read by executors of async reset like debugfs.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
>   3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4daa0e893965..bfdd8883089a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5307,6 +5307,8 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>   
>   	if (r)
>   		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
> +
> +	atomic_set(&adev->reset_domain->reset_res, r);
>   	return r;
>   }
>   
> @@ -5321,7 +5323,7 @@ static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
>   {
>   	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
>   
> -	recover_work->ret = amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
> +	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>   }
>   /*
>    * Serialize gpu recover into reset domain single threaded wq
> @@ -5338,7 +5340,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   	flush_work(&work.base);
>   
> -	return work.ret;
> +	return atomic_read(&adev->reset_domain->reset_res);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index c80af0889773..32c86a0b145c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -132,6 +132,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>   	}
>   
>   	atomic_set(&reset_domain->in_gpu_reset, 0);
> +	atomic_set(&reset_domain->reset_res, 0);
>   	init_rwsem(&reset_domain->sem);
>   
>   	return reset_domain;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 1949dbe28a86..9e55a5d7a825 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -82,6 +82,7 @@ struct amdgpu_reset_domain {
>   	enum amdgpu_reset_domain_type type;
>   	struct rw_semaphore sem;
>   	atomic_t in_gpu_reset;
> +	atomic_t reset_res;

Maybe we should both atomics into "active" and "result" since they are 
already part of the reset domain.

But only a nit pick, feel free to add Reviewed-by: Christian König 
<christian.koenig@amd.com> either way.

Regards,
Christian.

>   };
>   
>   

