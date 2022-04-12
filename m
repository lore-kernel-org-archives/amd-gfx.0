Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60057C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 04:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E154910EE12;
	Tue, 12 Apr 2022 04:29:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806BA10EDEA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 04:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlYA4lyK/fdKnT/FcBIOs3+icgG9thUS7psEdgnkk70lMFbwAzQ++iOBe0Z012cAw4hd0I47JeJHlNEPWv43qmT9os84AGSQNS1SA3ke/Nt+ORXreVLy7sljbocLfRdpbbT1x5dFPksprqbg60CmPuUtt2pm2I2LF8HAkvtAGwIFR4SrydZG/iy3YMYLMzmrMHFOaIq5M7qy4QJHzO+dk97D+q55v0HKIosrnUf+bcxDBkeaat9ly+zx6+09D32rACwd84rVKjXn9Lks8UXlN8el8snFt9xl4d4fAE0XvKIscX0tq6I6ww6Q2/H8BCv72+P5fHw1IZUeUoyv6h6fCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucYuFuV/QO65XIZHzKspexhZp8yNo+BxdzsbQSfMads=;
 b=bL50a03iBaZccdXzWWPhA1X9sC+wrfxa2CItzo8+C6rHPagzRIX28X7BOlWYpQ8s9L7iAPKHF6aB5Opldvi3jFQg9wkE5ZJF6DEZ7Zi+tCuYgFdkOJCl0NR59wgJp2BpDv3OphDnU4/NyPONJKeYmqEV9CkrD/MxoGLxLRz5sjhouqjsCQnItJpQk2ahTlOQir4k7Xo5x5Ys8a3qeyAC39vXiTvOWIJt00xilDEKDtgm3yBw3d37wR+1/eBKVSvE6mXS+axJB3UXBKCRjc+cebRYX0fuFVmIkFUljoXvDaPCZ/dSnibJLCiZpKRN5WLnCx7zXXIW2CS5zrIX6OMbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucYuFuV/QO65XIZHzKspexhZp8yNo+BxdzsbQSfMads=;
 b=aMhW35I/h73gYQ1JP2GVS/KnJeibnoHv+EfySUMiRnkdAEs2l4A+vTnCf1j7hJHJPEhQ6l0nTdjBZVpMeedzZL2DijHeaNbuhcnCeXwlK+x8impPFqABsrVgp9C753S3RUtWApzLUVOFAB8k/huThL9JgXtEh+vH5pr8N6naii8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Tue, 12 Apr 2022 04:28:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%7]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 04:28:56 +0000
Message-ID: <a5c53f56-0ebb-2f9b-0509-8273772247fa@amd.com>
Date: Tue, 12 Apr 2022 00:28:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: shrink bitmap size in struct
 svm_validate_context
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220412030626.557729-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220412030626.557729-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abd9f416-7827-428a-b12b-08da1c3cf522
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1657697317FA79AF1E40094692ED9@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZsX82s68drcqso7zAjI4x8jClvwr3gi1Z4u2p9R5OTxg/THKcK55mWkbbKivy8bapxrxi6BitduIY+ymBT81rMCKy+/NE0RFJBqdxdBn1qriZ4MEhCzNMCJJiK9/wbBTp2Yko/QR+tq8TwxtWRiKDdBI3odUrxgEjVLIE5Zq0Zo6L7WN1j3Oi+2hs/lQeyVnox12lKvHYHpM3CINmxUnG0hgVxZPDhShuWfkxexiSJk7/z/p8m93oTG9Tu9Cu9qsjSjOtjdvLK4Uwai7CAsZQ0kyZFQAjlXCzGRBdGytGMnd7JAfDH66tfNK8NTiSNDBJ0V0uDqmHYCbcQD79R8bSGhdsl+s6PSQh6bME3Wr0EgFJ7WV8/muNdDu8j1sHjJRV6HEYrus99Tyfs1UP4nsXjRLRAp8mHH309vPn7Wmz3Ge5ReReq7CotY8RXdJEiJ+Tni068wFTt7UaKYKb3wCh+hG0EEG6reMbwFtarVKAwL8WchhONqmu/bpfSAnWK+AglFAOOXI6RRObFtkTwPAdw3z0lqYkphPBhRIdL+AuCEhF+u5mouWeIUc1GSQA6uTgdqOGU+h00H3k88gMBFcGvzIcxdf/1wM4bI+lh7e0l6VSusXfdraK0Bbz/+lCfpn+/WtfcbK7Sn7xkVDve7l1IvSibior73JcNb8DOsMpJ9DTiJiR/ozpsEQUm74gDcacI1iWjQlNuqeKyVl0IqhR+Qs00u0Y48YfO9lXEc3s6n/DUMKjMPHQeFwWRhj0/4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(2616005)(4326008)(6486002)(186003)(26005)(4744005)(5660300002)(2906002)(36756003)(31686004)(31696002)(508600001)(316002)(44832011)(83380400001)(86362001)(66946007)(66556008)(66476007)(54906003)(6506007)(6512007)(38100700002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTFRTGlpbEF3ai8weDhjODA3ZE1tUHZicUt3NUFUOWdSSkNxd3BmY3lvL1FT?=
 =?utf-8?B?Zi9ud3U1Nms5ZGRQemlEK2ZJakxickJ3a3QvZFRMMXdiR1NHNURVU1cveFJu?=
 =?utf-8?B?TDN0WFZQS2JBY2c1NmlwMTBVaDcwdmlOM0NPTFhuMWpJdnJsTXlMSk1LWDNk?=
 =?utf-8?B?RXNseW5XcTBubkNjV21KR0ZRbkhCVkxpTStjOU9hZXRCZGZRRkVPelpEWXA2?=
 =?utf-8?B?OHlPdGEzcGpvZytNTUJxVDMzckd1TEtrNlFsVnZzM0ZsQW85Vi9mb3VzTGRq?=
 =?utf-8?B?WVpYRkk5b0hMZnVlblR4S1p2eWJVQkw4QVZONDBtaXN1T1ovelNvSllRVnl3?=
 =?utf-8?B?TXJaUTZKa095akZ0bVFHUmVHc3BkL0krMnhpS2s0VDVBTFBIbVNXQW8zT3pY?=
 =?utf-8?B?QU1OZXMrVFFUdDJyblh4VStrZlREUWExUWl5UzdHbVJiMnJ3M1IrQ2dJWHlo?=
 =?utf-8?B?MDEyZk9lRGMwTjhvODR6NU1mbGR4WjhETWozR3dualB4ZTFKVml4aERxcjc1?=
 =?utf-8?B?NDRUTXc2TTRiOG96a0VrVG8yVGh1UVhQcmFDUXN6Ny9NVTM2bm5JQ3RLUVFB?=
 =?utf-8?B?eDBIK2h3VXV5b1dYaGZVVHFGL3R2Mkh5ZzZ2d3FjbWVKUTdOTWtVUzcwSWcz?=
 =?utf-8?B?S2czTjVLSkFmSWhOcHJvREhYajJHTU5qNzNHSnRueE52V3oxYXRJRE84eDRw?=
 =?utf-8?B?Q2cweTRlSWNPN0pzdkc1dE9TWnZHNkZ2ZmtCWlBNMklEVUpjUExpMW4zTW04?=
 =?utf-8?B?MXJMdUd1Wnc2Nk1Pb3o1T0xjSCtscEU2YUJIR3dPZG10SlBSOTljTmhGa2Nu?=
 =?utf-8?B?Ums0YytVZ29YTnA2RStMcktPQno5eFlEWWdGdFJINVF3VGdjbUpwMmV3V1E2?=
 =?utf-8?B?dTBub0JNUm5HNTdOTkJFLzJVajN6MmhibHk0MUZtQU9KTmpxMXBObGdBbTRN?=
 =?utf-8?B?eFBORXl6ZlliME1Id3FyR2hRSnUxd0pvcFBWNk1WTVFoWXlFS21abVdKbmh2?=
 =?utf-8?B?clByVW5LaldmQjRtWi9hMTllUkk4RHFySTNndU9FRVhmS0JkTGhLb3hWYUlw?=
 =?utf-8?B?ZzNXVm4rWHdaMmExSVRwMlgrSjZITElYais5Wk1zdlphdEZmRTdXb0lVclZj?=
 =?utf-8?B?aEk1SE5vMmJzOG45TG1EeDZkbVMwTk1IT0dlTjY3cE1zeVo0MTdpVlRDejVP?=
 =?utf-8?B?cGtWOTFQRnR4MFNKOVJFK0UxbjhmQ3o1UFJRQVYrZWlCSGh2Wnc1SjNVRjFh?=
 =?utf-8?B?RlphQ2xQM09zdTk0YW1paU5VaHZDTnpuREJLNzV2SjNmZXJLQ0NSYmduUzdI?=
 =?utf-8?B?VEdWMmdCSFNKSTVEK0FONEt0dkR6R1ZMcHpxeDFtTzdnVjNuWkp4N3QvMGtD?=
 =?utf-8?B?NEdsdUhXeXhvSnNldE45cUx6bUc2K3dtQUszc1dsRG9lcDE5bzFVVkZhOGVa?=
 =?utf-8?B?YlczVkNFZFVJazg3ejZXRzZOZUh3aXUvZkt2WE5mMWdlcjk2MjU2bUpMMTl6?=
 =?utf-8?B?NmhNcjk5ZUFDcUNFQ1NML2ZlWGdaOTdaVWZUcitoNldYWGdHQzJCbE43dEk3?=
 =?utf-8?B?Y3RZS0IwalRqYzBMQjl3WUlWa2VTQlh2VDN1Y1YreERHVHdGd205NXAzUkk5?=
 =?utf-8?B?QU1BeWgra1pUMWpqYlUxUDh0RTMweFhMZ285M214NkZSK05rUHVpbDI0TmdZ?=
 =?utf-8?B?ZCt2Y2lTNmlLUUJzaWhHODJiYmI4TWxOSWtXN0J2ditkSERPSHUzbi9VejRH?=
 =?utf-8?B?L1Y4WjlYVmtOTzJnOW9LZFFWaE1aRlhBQ216R3JRUkJrRTdYOS9UZS9XWW54?=
 =?utf-8?B?d2pPRGhaU2E3S2lrTnVqRDBnZGVoRkp2cTNIZFFqR3Z4dkNybG53Tk9iYWo5?=
 =?utf-8?B?YjhCTnlOR0xwdytIWlRmQURWZDZMQTJuQ0E0S1Z1ZjBMakN3TmYrSUNVbWQr?=
 =?utf-8?B?RXhVNkI2dDNvbDNFVURTTS93RUdqdnVNd3JhbXJxVHkxVVBjcmdxWmpiZGE1?=
 =?utf-8?B?L0Mwdjl5Y2djMVZJMDA5VnVyVVdTU1RqenpyMmpiSkN3bmM4QXJuTlo2dzV4?=
 =?utf-8?B?L3p6Q000MmFXdFVTSys5MUNqQ0xRQm5XNXN2dHZDQndncE1HREt6K1BMRHpX?=
 =?utf-8?B?eEhHaTFpT0w4U2pqTjRKS0Q2am00SmdtK2p3NGxHdWJEUlZPSUR2ZHhxMDhk?=
 =?utf-8?B?cUtwRUpPWndqZmdxbnhtMk96RUhyeHhYYkVPUnN4UURGamtIR0FTbFdyamxP?=
 =?utf-8?B?NlRKNUFWQjU3aFJRN1I2Q3ZUZFl3N0ZRZy9GbUgvN2tSMWpncWppWTQzRHR5?=
 =?utf-8?B?bHBaZk9LMXNqWnY3QTdRWWtLUHA3WE55UEJ1dTFJdFBoWDM5TmZ2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd9f416-7827-428a-b12b-08da1c3cf522
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:28:56.3590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5FKXoHiEYyXRJWiJiNwtrVoxi0jnkfjMCF9NdqUPCBC6zp/vs+skxkiIaWPfQVb/jpDE5sjm82jfQpEJNnEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-04-11 um 23:06 schrieb Lang Yu:
> A MAX_GPU_INSTANCE bits bitmap will suffice.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Thanks for catching that. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 8b6adc142e25..459fa07a3bcc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1370,7 +1370,7 @@ struct svm_validate_context {
>   	struct kfd_process *process;
>   	struct svm_range *prange;
>   	bool intr;
> -	unsigned long bitmap[MAX_GPU_INSTANCE];
> +	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
>   	struct ttm_validate_buffer tv[MAX_GPU_INSTANCE];
>   	struct list_head validate_list;
>   	struct ww_acquire_ctx ticket;
