Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16274C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 19:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4647010E219;
	Thu, 14 Dec 2023 19:57:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41D410E96C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 19:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYakgJDYgdweQ5lK5zxu8Y6+hjgGlg726Km8cZlZND0yF77RlnSQ2rKAw1EdhYtfLZdUBujetVabxeX5hSCLz82cl7rCyOPXSNvJauj5kcxLVpgbkGpg/I/0+3pqdgJSbh0OgDjciK255XFXvZIvUzsxbq/O9km5dC+Jjs8IVgQTOZlv7q3tl2hSUGolO/w1qwB8wRZsoyVa/ac38UnnFGUr7T/owTLDlnPa/EEy96zpw1ywiBli3H6ISwKtOmXhNmM5+YWUcv7rvAr6jgtiXSN6HJf1C/pMhSA0lmTjYOlBbSBZ2rBy0fT7vc9mrJS1iieNa7ougFISRS5KRsJoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfNg7LhjMtdcFqcHQCquXAHhltV57C9hhiJs6zJf0YU=;
 b=UR2G1JShcJfn8jR53aLB5CTIFrnQyxsweF9fQZwjO71uXOvdkavVUzbMQFy/8xkZGnS7DT2y3pK2ifz8Xow23b3yqRJYcQ6pJ2F5w3YNWpMM0vzmGqLMTCQd9VZxBVq32+K1O7Sf2+3zJXnyEshav+bfcODatVtot8PXB9hh1v0/KzQCu9oNq9csZmEoXjbrp7rzENnYeUScJ8jQ83k2FtwJu4zhRBq2UrKGL3Wa+EJSgoIrG7SEBgRrnyXDh3WxTXmEm0v2YJvglnoKiSxmfD6W9zcTsrJUQkDtNzD5T0kN9kcI4aOiSTI+RxFLWXFTuZtFJs8+ByUCeIRl3i9SrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfNg7LhjMtdcFqcHQCquXAHhltV57C9hhiJs6zJf0YU=;
 b=d3fNVt5pMklJ+WP26in7dmHTabjNx7qZPDtHZfGF4HDVTSLr/EjBHqhTp3rQsL8UU/FEtRl4FpHZkq0T04Ni5Ame3vIkVX8lvgdr397RBBUe0WhlP09I2q1lBH/+ISdZpo/JVQJTYCYvcLMpQ5XkRsc3majTYHGmfQtivjIgIUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 19:57:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 19:57:41 +0000
Message-ID: <1c318d42-c53a-4a61-9075-2fd78bbee1e3@amd.com>
Date: Thu, 14 Dec 2023 14:57:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: svm range always mapped flag not working on
 APU
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231214185832.3355-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231214185832.3355-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2707a205-8057-42a7-368b-08dbfcdeee28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDlD1sU2n8w1ccmzSn9P1stwFULtb3e2zE95owjkiZGpkZM3IClwuh4jsAq+fC+553ZeXPbDh6Xhg2zdCq8siC7EGM4rAb/QuZPHlsnYd0D0BhWy/kvsZ2oHRois6HIheMzS29w8ysxn6/QOORMu40/kYOilfkUJmHwJ3oQkV01ad1Ebog0yl9BVWYUuEArYngXCRzlvImv3qrhlGKyTzEysdfCEmpcq4mOLewtpqG651f6F76BQzJ8Gowpfg9a4UvGsBZBWYRGuBSjECYs2EygOkJgAyu8CkoicYTNLbkQwahImEitmS4dq+OPGYeX+qBBw6ztM9Mz0VdN1sNoJ6YFS/shPSvHBmc9QYsoO1GA3ofML28b3soEorA4d6dW1wrwWWxYlcXIGBgVlHD0c2pJEPuqTD6RrxVtJmjKLbwXwlkeIYj4i1+i4mRoN+DWQHp2f2O78CCwm9TIubFeXyeZVy21oUWuqdqIRw6/xIKbib3PRpbAzpF9BvQIpc79chEIb3uQYEJtBsC0TbZPXaD+YBiMhcFN1IwLaPNbapJ24Fq7EhnakMx5JORmGXLZM1Fy/SLt89VBgCgge4i3EXqWZ4bo+LyEWvWxXDZcawNNM6HKqw9Dhp/fmfwrw5J8c/9UJAm+fFsD7z7Leq2aWBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6512007)(8936002)(4326008)(8676002)(83380400001)(478600001)(31686004)(2616005)(44832011)(26005)(66556008)(66476007)(66946007)(316002)(53546011)(36916002)(6506007)(5660300002)(2906002)(41300700001)(86362001)(31696002)(4001150100001)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlZaGpCamduWkdIemtOTmVURFVoZmNNQUtHYXZ4SDBxNXRjdm12RTErMVpO?=
 =?utf-8?B?aWdZUC81TGRzeGlPS2h0dXVrR2ZvNklhSTgvMWlSbkU5N0JxRmt3eTMzejdK?=
 =?utf-8?B?cUVMSGtsc3diK1ZDcmxxUnlSREJGcThmK3E1T1RDSGVTOGUxSnZDbGhUc3g3?=
 =?utf-8?B?WExhUUx6K1h4Z2xxaFpnLzBzQjQxRXZab2JoNkVwWFM4UzdEa2dHN0VJbFhi?=
 =?utf-8?B?SWJvQnVzdDQ5NENFeSttWHViVVh5R3ZsY2h1VEFWelZiWjdLaEs1U1ZBcmxi?=
 =?utf-8?B?d2IwQ1d1eE9yTFJyMjcvVmFKSTl5WGFYSWNLREpBa3JSSFZmS3FZTU5LMDBL?=
 =?utf-8?B?YkFrWGd1UlY1RjRpSUZSYm9JU29LYjZFZzFvMnNXUUV4MEVpSkR3bEY5dG50?=
 =?utf-8?B?QUpBQmlKRDVIRGIxdlVRTUtrWXBOUys1YzdveEYzc1JxbUV6WmdVTnFFZGR0?=
 =?utf-8?B?TXNZK0hCMUhhdVdhMTJhTzJpb3d4N3U1VENYajFXdVZIdUhTM1hob3F6Vm9H?=
 =?utf-8?B?M2lEQlIrcUtWYkJKZ01IMnRpMlRLQUpYVHBNVXlSSFlpdmlCcGpsRWI3QTZV?=
 =?utf-8?B?ZmhaVVUxdTdVTHdtN3FMMUFqREdOUHN4UEtHVnhEd05ZMEFFV0hYd0NSTFJV?=
 =?utf-8?B?ZldXbjBsK2FSZ0ZsUDdtOTQ2cTNpOWFTQTlPRThMVmgzRk5xTkV2WHc5R2pz?=
 =?utf-8?B?QkxPTVc1dExDSVp0VmhMZEs5eENkNTRiYnd6MGdwZlJSSlh3cGlvT1JxQ1RU?=
 =?utf-8?B?cURHcjA0MlBRQjV6TmJtallUQVpEUlN6cEVvQ3ZoVHMrYnM2cVJPbUJsWGF3?=
 =?utf-8?B?YVlsUFkySENNcUhYVm9pbVprZDZLdzBTVHhUbG91ZFVUeWcwS1VTcUlsSUNB?=
 =?utf-8?B?ZFNKZll2K1JHV0NyZzVJc1BxaUtRKzgzOFBuaG5xWUlVcGxWQUIzamlhdWZQ?=
 =?utf-8?B?MFhCc29IMU43Z0RCYVhHNE15MFl4ZytxanpVZ2t2WC9TY0tHZ09JdndRcnVk?=
 =?utf-8?B?N3FBZlpvOU5OSVR3NktsK1BuNmVSTWRsTkQ5MHpkMDVHN2IzZzd5SWhBNDJ0?=
 =?utf-8?B?UkdDQndlMFNqeWV0NWxYVUVnM1ZzK1piZExWVDVLZ0tqb3dCbGxoZXhDWm1P?=
 =?utf-8?B?eDJDR3pack1naG0yb3MrdnZRUDhiaW1UR1oreTNVdWJJZDZSRXFIS0dsZDlw?=
 =?utf-8?B?ellnbTM2N2tETXZsMkhMZ1RGS2Y3cWV0RCtnKzhhNHdsMWo0cUp0RnBmT2pv?=
 =?utf-8?B?UUVPcGFxbnhIamM3SHhmQXVkd1RPdUFDc2hGVjJSaU92bUdidjE1alFQazk5?=
 =?utf-8?B?eENIemQvUTRWcS9zZ25kT2IzdVNYVlVlMVFGekx0bHV3aHNYTXhnVFM3UUlT?=
 =?utf-8?B?SGFlV2hRZVZPMng0VkhqSXNSNzdDSXpXN240eGJCSk43QVE2NmRWMUZrdWQw?=
 =?utf-8?B?RDVoUGxETFBUeUY0eWVXTnA5aVhQeEVQTi9TcGdrOHlxeHluRktOckQ4MlFU?=
 =?utf-8?B?ZWhhbSs3QkRZZEp4VDEvZ2lxQVJLaFRMT2hndmtlWTAreEdKV3luckg1L2Fo?=
 =?utf-8?B?MHdWVE5GaW1iQ2h0VStTU281WldXVTlhRlg2MjdBd0x1TzhITGIzY0grajM3?=
 =?utf-8?B?eFF3MVVuNUYwa0FDd1pLK283N1N3MEVlS29VTVJra2xQWWtCbDJUNTh0eUFp?=
 =?utf-8?B?bkJEWDNHcUtON1hrUGQrWStVdXpaN2NXMHRpazU0VUFkUitzMS9mWCt3dGhm?=
 =?utf-8?B?RC95bS9wNnNOL3dWSFNzWHFTY3IzYnltdG9rMnVjK0pPZU9NVTBzYlJHT2Nl?=
 =?utf-8?B?K2xaUWlRUUtuNDJtTnRreXdRVndyRytXaWpVc0VBSXpFS3dNSkRqeGRYZGFK?=
 =?utf-8?B?ZHYyajlXcTA0ZTIzb2Vjb0hDaU5DTHhiWmx5QmtTZllidW9GZWtIU1lqbElK?=
 =?utf-8?B?M2I1Y1JaRG9aZmRxVndpVHROTjNjTEgwdU5TVUZUUENFUjRrZFBpU2taQWFQ?=
 =?utf-8?B?L3JMRi9WRGdQbzJhYmtWcmRhSXhsNWZPT3AwT2RCd2g0WWJtYWdoT2JDTE1G?=
 =?utf-8?B?RTZwT2NmOTR5NFNnUW5iM0hOUGVVZjlGd2FwNGxKM2dZU3FHeTJzQTRKTlAx?=
 =?utf-8?Q?rPVUvSMWUzL7280+viELqqayl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2707a205-8057-42a7-368b-08dbfcdeee28
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 19:57:41.3666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0WGt9m3O2hRDpovgV/KeK+rSckH55P1eUJw+rRbJTU5KqWom62kTw4Ml/L9nYGkV60p2kJDEnPG6MpDq1WlPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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
Cc: rajneesh.bhardwaj@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-14 13:58, Philip Yang wrote:
> On gfx943 APU there is VRAM and page migration,

Is there a "no" missing here?


>   queue CWSR area, svm
> range with always mapped flag, is not mapped to GPU correctly. This
> works fine if retry fault on CWSR area can be recovered, but could cause
> deadlock if there is another retry fault recover waiting for CWSR to
> finish.
>
> Fix this by mapping svm range with always mapped flag to GPU with ACCESS
> attribute if XNACK ON.
>
> There is side effect, because all GPUs have ACCESS attribute by default
> on new svm range with XNACK on, the CWSR area will be mapped to all GPUs
> after this change. This side effect will be fixed with Thunk change to
> set CWSR svm range with ACCESS_IN_PLACE attribute on the GPU that user
> queue is created.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

With the commit description fixed, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2834fb351818..41656e85ee57 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1607,18 +1607,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			if (test_bit(gpuidx, prange->bitmap_access))
>   				bitmap_set(ctx->bitmap, gpuidx, 1);
>   		}
> +
> +		/*
> +		 * If prange is already mapped or with always mapped flag,
> +		 * update mapping on GPUs with ACCESS attribute
> +		 */
> +		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> +			if (prange->mapped_to_gpu ||
> +			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> +				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> +		}
>   	} else {
>   		bitmap_or(ctx->bitmap, prange->bitmap_access,
>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);
>   	}
>   
>   	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> -		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> -		if (!prange->mapped_to_gpu ||
> -		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> -			r = 0;
> -			goto free_ctx;
> -		}
> +		r = 0;
> +		goto free_ctx;
>   	}
>   
>   	if (prange->actual_loc && !prange->ttm_res) {
