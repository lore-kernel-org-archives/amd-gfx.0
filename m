Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97012C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2238010E728;
	Tue, 25 Apr 2023 12:40:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 638A810E728
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDdD8Eax547ce+w5EdL3srRzE5z+JYfJC5u8vFuQy/p1kkZsPXxcKbbfOyq3pnQXomN3ubFBY2j4FQWhVni8BbqJUbsFQ9Z3W8LCQVVvdMqRkXSejJzUZNDeIsaUlYIEgGvewOPFtLwdD0KIXUev9NbzggWEpPrhgqGmUMnOs2XaPdWyZixya5GZtUarO5f8JNnhrmFGwLiu60ppd1NukPHgHq0kLXECpT9Mj8k0BBmg+6fsKs7ug2NWFWbH8BTa/5YL0z8+VOckuemOu1GiuLcF56+m8WxrdDVIyBEeJRIKZWdJZfTK2kGvNzf/w7T/nXTilVwUlihe++hP3dXF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGLC4xaScq3Gg0ofqAbpaFyAcJw083z4mF3z0MsiYRw=;
 b=ee0Vg3r6Pn7JY7MwSLLRl0/m7QKIQm7LRdliweKnRWZbI2gqEkqj0v/VNGwysaQwfk8AVsuXbCdfU3kipuwEPhD+bUvY0d6EvyHGICwwv3DKRIMhggZ/BZLP1uyyAERoClUytuaf+4//1sRmmrxAEwPJni0fApcQZxzOJr8otkI+njnJ0nY2pCjNiP84JoW+n9Rs1CijGq4tI19KY2WkmZ83hMauArO7SZ4ILFpBh0IDvM3ipY4cvVoa3aT9xVen+FmZbbIp+mJgSU44LKD5sg7SPiGt+YDVBvV64GT/0e4qUO/YYL9A4WDr08aKmP45cxpgpUHQC9Q4EoJyalAjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGLC4xaScq3Gg0ofqAbpaFyAcJw083z4mF3z0MsiYRw=;
 b=bLj7xJ2kL6tuXasMVUx+rID7G+axj4qjWU55oNtTtUKDz0QlcVinfOu9FAm9dG4ZfeQtVhl7PAhLMMzrkQbOxvivcPcBxfOAvuT4hu2ChoDK/TlQx80SGwP0mKNOWuz9DVNWShL5oGHTtY+awE/oG429Qa+WokEiQumy21KtJdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:40:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:40:52 +0000
Message-ID: <66198170-f97e-7fd9-fd84-5046277b98d1@amd.com>
Date: Tue, 25 Apr 2023 14:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 10/10] drm/amdgpu: cleanup leftover queues
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-11-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-11-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: f475e2bf-61e2-403d-81f3-08db458a4df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vxjqVpO0JbLRE4hVQf8Err6suwD13N4CALvgu80GEizS6P0MpUekEFyr+0DHkF202B0Oc/LVAyC5WyjKwUO12pYUUgV8/iP1Db96PdlbosL2JmaHi70RW34aG/F0JjhsLaGWAUK//Pc/wAS0c1dcGVTVlNfGXYAfkS4vcdVQWfd//QuctSFxvZUuCdPb7yY1+SOzQRXFgWok7/pNtcMKF++eYc0O2z5NkT+mmL4e8d4x2Dscigo2BqKo2xec+Ul7ISHJ6RqAWuzSBIv2ibmnW28vDPGFOnZ8SlRcqdonCl2nLFbrWtsNTqVzGZBYnLezvsvUzkm+YqFAg5d7lQG2WCyuA7F/azJXfCEfz99C4AjE3tIWweF5P/naEMJnh6f7QEoNPI3kT1Buk0zenOSU+PA6uozehjmtKX4Xy8IREJUJ0eYvhRqF5mpZf2ix4J0n+Mtms9c3OlYfJo3qTlawVFTQuSVQfqfiPO0/o31r5EFEjz1QWlKqFFNikkzdGBHVdlpOCyHrYvrLcykUHwyZ/GlhXLnqVFlYlS9OA8QY1Hf6YtZ2sLA16rupG0NkhNI48/ILUFriEeTBOHaQ/nuTo+LHGo/kWc4onTSIV1lW3KnagqS+Mkhtt/qmxJf+Fk38rCZuAaowhxiedF9eqhnlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(66476007)(66556008)(66946007)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(31696002)(86362001)(186003)(6512007)(38100700002)(478600001)(6666004)(6486002)(83380400001)(31686004)(2616005)(6506007)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01ybkRkWk1zL3lSNEEwSnZFQkFkbmVkdkpxOE15eXdDWDBuVGkwc0RrNnBD?=
 =?utf-8?B?RFVRaWNjeUpBOXFoNGc1NEF6ajlVankxaDhmM3JabTIyY0NhS2p0MUs4Z0F6?=
 =?utf-8?B?d3hwS3FiOVc2ZDhHUlZObFd5a29xWkRaZkEzbUpZQXZ2S2JDWFdBQm9KMjM5?=
 =?utf-8?B?dDNlZGhlUHBIMnZkR3NtaWJKYzZwMGFoT0xrMDE0a1F1NFNPdi9QNy9ycjNK?=
 =?utf-8?B?OWRmb0ovY0dINEdqUG15ZlBQazlCaGJZbEtQWjlxUlRncVNVNTBZRVZoRlll?=
 =?utf-8?B?L1R1OHVtcldNRzVjYXlZZXQwcWNQdER4bU9FdXgzMW5jV2t0QWpVTDF0czFD?=
 =?utf-8?B?Qkg1cG9wZ3B4VkFvSEg2RDM3QWszQnFjTmx6bkJuQUpseGdYSXNXYWJsRDhN?=
 =?utf-8?B?Y3pIeG5rdXd0aHl6aE9QcUZTRHRQdG1SZTE3WXNtNFNzVnpWanVXNFlvUW85?=
 =?utf-8?B?RmwvM0FuUmw3SUM2a3V6OTVDb0ozSzI0OUE5K2V5VDNYMngxUncxWDJ5cStG?=
 =?utf-8?B?Y09kb25iYlp5RGlTVStNdXBmWmYwalFKcHJ4OW02MU56U2N0STZKaFRUcFdT?=
 =?utf-8?B?U1ROVVJhcHhiTlF1VnRkRDBqczA3b2M4TlViRmFwNXFBaDFaZGUraW54aTd3?=
 =?utf-8?B?VlZlZENQWUl1RkpiUFJ1Ymw1WHBLd1dLVHZQLy9zeWtaaU1mQkdMK05nb0JK?=
 =?utf-8?B?ZzdHV2dqSU5uTkJYWVQyZGxoZHJ6OU1PampUdU1oYmlaM2VGSUZvUFVsN21Y?=
 =?utf-8?B?K2phU3Voa2lGTitmdUl1a1lYQUxyUFV0bHlnT0ZvU1ZVQ3Z5M2JyZ0tWOUtO?=
 =?utf-8?B?R2c4VXpON3d6MFUzQ3czVHlkTDl2bGxrY3JXWit1azFUdG02WDF2aW13ck9M?=
 =?utf-8?B?QkFNR2UrQUIvN2RlbUpBcDVSdzJ2NlAzN3dGRWp3OFlYbWxKckd4NFo0M1gv?=
 =?utf-8?B?TEVlN0FXbmhKaUswaUIxNDZIbGdDMjZTRCtjSVBYQis5cE80MDRQa3ZhWnBD?=
 =?utf-8?B?OEN5aTR6cDd5dXRCc2dMSmwvUzJRbmNrNjk2K0hWSTNxbE1RMWkzTTVneTYx?=
 =?utf-8?B?RS92S0xwTWNVSWZJT1NXNitOWGlzSlZlN01JWmhSa0xPSFIrd0pqSUw5WjJp?=
 =?utf-8?B?eW1JbUNCeFlvQUZQNHhwanBIYzFKZ0lJU3ozVVl6NTJnR2VZL28wWnlSOGtl?=
 =?utf-8?B?RTJRaGJSVE93K3ByaVdnbHF1TlgvZ2ljR0ZxRmozT1dsNFU1cVNEdks1R3pw?=
 =?utf-8?B?WUFDQlNabWJiMWE0Nms3Z0FtTHA3NThrYURTeEtBOFRISm1QYWRyaVZWYzNp?=
 =?utf-8?B?S1NNZm1zK3U4c0d5Yi9JaFF5Rm0xNDRZaHVDd1VHM0VFZitEUHpiSmQ2RmRR?=
 =?utf-8?B?T3pVRVBuVTQwY2RCam04c2tsTkNlY2s3ZGRpUUdWR2IwT3dvL28zMytoOVFl?=
 =?utf-8?B?QytWekF2Mi9SMWV5c2J3Nyt1bEo2QmtXQXBhaUQrRmVGSkFTY3h1UThFY0xn?=
 =?utf-8?B?OEFNZzhpL2FiZjhvdVFsbFAzOTVYWmFjdy9yMjBWSWxpMzF3Sy9PMG80L09y?=
 =?utf-8?B?RFZoYy9OVVNGdkxEeW5jUUhrbWNBNzdrZHM4dUh0bmhDMjRJY0hDOWx6ekJw?=
 =?utf-8?B?MHhOclV0M2lvR2JYL0l0RjdXS1c3MGZoUG9YcThWQzR3dHd6YmpKdS9UNU9n?=
 =?utf-8?B?VjhsS3NNRmNtcGcxWHBuY3hzeVZCa0djb1lWa04rMkljZFVSM0xOenBxL3g0?=
 =?utf-8?B?bk5Hd0ZzeDZCZGdKQ0toNy9RSzRvSmJqdlRCR1lzMnlYVGxROUhIY0VFUnBi?=
 =?utf-8?B?L3k3dmtBQ1NUNUhmQUptaHo5cTZZZUtVeCtScVpqU200Y09MUm56ME1pZ2Nz?=
 =?utf-8?B?Vi9YSWZxSzhyV0FhTzlZNmhqT0VvZE5kdUhQalQ4dmd4Y0VxbEx5Y3c0OWx2?=
 =?utf-8?B?cmJaYml6TUtsZjJwUTlLWXBzeFRnNVBFZVR2TEM5UFJGTTV5NDQwTGNBcGcw?=
 =?utf-8?B?T29wSTZUREpqaGtZbXdBTW95QXJ3R2cvSWc0Y3NkZWZrUDRiUVlQcTJQdVU0?=
 =?utf-8?B?QnY1UWIrcXREM2ZFTWtyd2JUV21JZXhZTkV0cWp1R24yUWZIUnNtZGdOMlpK?=
 =?utf-8?B?NFBISy9mQlpLL1NVcWtUN3B0MmFSNzdySE0yWTJDSDhROFV0YXRKajRqTU9u?=
 =?utf-8?Q?OgnMxRSdgIOlb1mZzRm9z69Ql+T8NKVO6kwzAAJkVl5n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f475e2bf-61e2-403d-81f3-08db458a4df7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:40:52.1156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYVqERGyGqCsMf2W8QHqppJcJSovoeDeMsHhACvBU1lj0tUEcMLcfmeWNiutT0Eh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 24.04.23 um 19:38 schrieb Shashank Sharma:
> This patch adds code to cleanup any leftover userqueues which
> a user might have missed to destroy due to a crash or any other
> programming error.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 31 +++++++++++++++----
>   1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index fbc9cb5c24ad..27201a0b1441 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -237,6 +237,18 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>   	return -EINVAL;
>   }
>   
> +static void
> +amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
> +		uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
> +
> +	amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	kfree(queue);
> +}
> +
>   static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   {
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> @@ -249,12 +261,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   		return;
>   	}
>   
> -	mutex_lock(&uq_mgr->userq_mutex);
> -	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
> -		uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
> -	amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> -	kfree(queue);
> +	amdgpu_userqueue_cleanup(uq_mgr, queue);
>   }
>   
>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> @@ -307,8 +314,20 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>   	return 0;
>   }
>   
> +static void amdgpu_userqueue_cleanup_residue(int queue_id, void *ptr, void *data)
> +{
> +	struct amdgpu_userq_mgr *uq_mgr = data;
> +	struct amdgpu_usermode_queue *queue = ptr;
> +
> +	amdgpu_userqueue_cleanup(uq_mgr, queue);
> +}
> +
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>   {
> +	idr_for_each(&userq_mgr->userq_idr,
> +		     amdgpu_userqueue_cleanup_residue,
> +		     userq_mgr);
> +

Better use idr_for_each_entry() here.

Christian.
>   	idr_destroy(&userq_mgr->userq_idr);
>   	mutex_destroy(&userq_mgr->userq_mutex);
>   }

