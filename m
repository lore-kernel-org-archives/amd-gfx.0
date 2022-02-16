Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C09C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 11:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A024610E6C9;
	Wed, 16 Feb 2022 11:17:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB2810E6C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 11:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGFhqdUtUSRQYOJKw+4UHIM5HLxDlhN5FWf6WxN+3blhLlvbJnBtI4pe7wVAFH51oTH/EUI5hksxTw6aA03i51ZIdhhUmDTYRx2liuo2cYT7EJqTFBnarfbylctFz7rfAx/a9FGeVqFJofjtxqDPRDIdTUhb7cUwBDDoM5DT4u7gweqaUqCCRAyuH2oT8FcqJFNuSoE2XGpOEK2GC6P7Etfvtb4Cl3Cuy755qBTMlkrQN3LXTAgqih254WGH/ouh/MO1qIUorJDaSIeYRKOHGfvai0Az+WgwYvfLm5uQePEttXWeXz7CKj7v+bjgnNZqH6oDQfiBRS0j8gz8PwxWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV01Grw/tk4+d+OGrfvGGRKEQQ2pCJRV/3Vlka8PWlc=;
 b=GRE8kTVrJxyMTtLage94KK+XZhzu82toVV7KoWnjBlmIspVxMUfg5PeuAHiXg6fH+4MZjjitBpWoTLDZU9uHmygjMRaquw5JhTtrWSYutPCLWg2X+/WzEkmirpZ4f+OU6rPW7MTxg+cSAXMitX6yZ1U+r/maakmmUiWf5g1fpfFHAwaxbF3WWv7GhrHUJvRELpmwHlEkTVh7a8iWslwRvtrnKQ5VDFG2F1Lkq7hxDZI63IzSzKHQU0Pu6NJG8rsLu8zF4J0RQoCmh0SB0khNw6ClrJE/sGH4FxAV/oHsfAgsYMoiUVKlC3iJeV2V/BWdNs6Eg2l3WEnuiDeblXcgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV01Grw/tk4+d+OGrfvGGRKEQQ2pCJRV/3Vlka8PWlc=;
 b=M/uZspHrZjJNF234fH5YB1S8Hz0ZX3J9zLkFCcDQEK7h2rA9FoffQKmeIlgc7YVT8e6T0n31PICKeGmUjxAPwQYpi0PIHXF/YVPij9QtzHWa5NnJzOHQWALuOLkljbgCEowQMF8lUnBMdyMtA4fVebP/0pvqbzoAViGvz+ZhImk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1474.namprd12.prod.outlook.com (2603:10b6:405:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:17:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 11:17:28 +0000
Message-ID: <6ea78726-4121-a01a-57d1-76d496e6bcc8@amd.com>
Date: Wed, 16 Feb 2022 12:17:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: fill scheduler with device ptr
Content-Language: en-US
To: Jiawei Gu <Jiawei.Gu@amd.com>, amd-gfx@lists.freedesktop.org,
 Andrey.Grodzovsky@amd.com, Monk.Liu@amd.com, Emily.Deng@amd.com,
 Horace.Chen@amd.com
References: <20220216072223.8394-1-Jiawei.Gu@amd.com>
 <20220216072223.8394-2-Jiawei.Gu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220216072223.8394-2-Jiawei.Gu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0201CA0013.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffa21331-1d05-48c6-ab69-08d9f13deab4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1474:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1474AE9E9BE19F124FD140E083359@BN6PR12MB1474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOMiEzpqy6qbeOJ3ja5P9szGg11+uZdirSsLsK4MmXBBQxV6YwdHtP5mqsKP/wKgdT20FTzIGCYtNUIe8z6caUe18v9NWU4OanicQm+pS0MrXiUNwKAFjElZ/wln1gexxOgYqTZ1ql9AhlaGr8vjHJTWS7xRqOF27GFjZxzOpHhkqbwXwMbKKoQQ14jjQXI+k6oTY7KMC6VcIoA8IUmzeZtrXr7GAZTfCbiWmTVpWU9Vg69TSp+JjIKRHPymvXGky8zoGr/O5gydpcxUKBIAGwQ9g+TSxNNlMP/jG3kqdfNFGrgegd34HmDj0Qt3px7ns3ROZhs5FySGleRoN3zovdyFC0MY6VjBtKSeHkTW/fSwuF2VNjWbFyHwzZJoPS+uVsyypx0Y/nn3jlfdre/J1VBh+ZVZqV533X+NZOTtYb8REn2PQHjZTQLCDd3eyZN3aekODpyd7g2VSCJsf9DIIuGc/J27nz+jNxpzVvFQmPyoxojZbADEfclhfNS0SVrELozAIQSiiuovGKnBVf9s4qCqEN0paToYwf9rP4nEgiaPU5YnJMzOzcToBaADRPmWgzx2+fhSbVNLDEZ/d0/oN/0ymUSeQyXHa7yNWInB0iSnBLc5591ExrRgTNPkGfESBJ0szvqDQ5QLyF2zkZugonvRvfYYR9afnslYR76vu3hBXWWPepgarTR1pEywbGySMqqo9+ooD7dr3on5gdiQmMZd2tf8PCt5VdRSgbxVAYE1VzxLk54rOjp1cKRiOWjY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66476007)(83380400001)(66556008)(36756003)(66946007)(6512007)(86362001)(2906002)(31686004)(6506007)(6666004)(38100700002)(31696002)(6486002)(5660300002)(186003)(2616005)(26005)(508600001)(8936002)(6636002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UllTeFhlbkhrUjEvUDRGQ1MzYk5yaHkzZ2trcVJhQ2R1amljSXZFZ3g5ODBv?=
 =?utf-8?B?VWpobmRIR3IzaE9qZWp6d1FWUi9DdFU0UFdwejRQSHM5UWZ5dGxHanFiNFJy?=
 =?utf-8?B?a1RsNm9YSTFidDJwYzRrdjlxTlRSMVVEYjlZN2NuanZ1d2lEWElxNkNaRHFu?=
 =?utf-8?B?SkdEU0tvbEhDQ0FWb2JxODV3MWdQcVhWdHYxemdncktUS1ZkVzN5Q2F5alBL?=
 =?utf-8?B?YnlzMHV4clpERFNxMGZtMWxvdlN4R3JSbXMxbHBkSlBMMUN0VHJIa2FyY1NT?=
 =?utf-8?B?QS9DWEs0Nk1WWUg2aXpJYTVDRHVIZnlsMjMxanhnVXE0SVZFMGFUZ1Bqdms0?=
 =?utf-8?B?RTVTamRTNFQ5eFFUbDJ2c05qQjgySmd6OXRhRFgwbXpEWGtjeW4vV1RpZm00?=
 =?utf-8?B?dDF4R1kxNkdXM01PS3JHZXBNYnpTcTlwWDhxK3RXb0RZeCtRZjJHYXZBRk5C?=
 =?utf-8?B?citQOUo3ZGpzNGUxWWlBUjlONFBMZ0ZPdFVha0hoeENpYWRlK3ZuWkhPL2FT?=
 =?utf-8?B?R012ZzN2VnRTbzExdU5hd0M3MW85ZzI0djJ4RXB2TFhwWnF5V2Z1UFE1aEtQ?=
 =?utf-8?B?M08zV0ozU2ZMSHZuSll2b2oxRldLQXE3NDRuV2FRS3NQZ1FFS0VkeXBGRloz?=
 =?utf-8?B?ejhaa3ErWTMxamc5M0VBQlpxMm5zNWtTR0xmNHFZKzhpK1BXNFZWSmh1OHhy?=
 =?utf-8?B?YkFnZlZXa2p4VmhGRlgxZ25sbVUzNGJndmhaU3QvU2R2MWM3NDBnazNQdFBN?=
 =?utf-8?B?SVJqb3IzVW15VmVuQWhWclBNMXZlSk1WL3hnZytjQ1BOMUZQZSs0dzJKNm1u?=
 =?utf-8?B?dlg1eHBTWm5sTCttbFUvRk5jT1BZTHFSMy9sYmx5RlVIcDdoYzRzSGNUSzc0?=
 =?utf-8?B?bVZrbFo5Q09PNmdCNUErRThnWm1JOTFGbnh5VXF3M3VhbEU5NEVnSkMvQVBu?=
 =?utf-8?B?RVZiamZuVHR4YmhueThIR1l6T1oreFZaa0hXTmtoaTZRMk5JSnJ4bHprbVo0?=
 =?utf-8?B?ZG00YVl2TlVnL1dsUENFSnJuVzZGQllSMWJOampMWm5XM3RYSUNZWS9mL2hu?=
 =?utf-8?B?YU5vYUkvdVdsQ0tyQm14ckd0UWVGRGtpbmdWSmtPZU5oaEZ6REZHRmM1WjRJ?=
 =?utf-8?B?TjM1dnk2ZFNFV2kreTRrUHErSWF1LzZta2dTSjFGZFg2b0ZzSlpTclBESXh5?=
 =?utf-8?B?aWRVNVdnaTFpTjdoTHhQYTNkR3d0VVVBajA3MTJrN2FWSmdLbjMzcmZNM1c3?=
 =?utf-8?B?OXdFOGVxNlZTd3VQbVV4RVVhNml5dkFmaTVyTGxHZjFZWWJmWUh4TU1jcTF2?=
 =?utf-8?B?SE51cjFhdG05KzFnYzNoRCtOeXZ2ckxSQzIyTStTK3RwWE1JYXlYUnhsN3pp?=
 =?utf-8?B?cDFuTTVFdE5lS0hvdU9xL3grVXU5OHY2TUZ1bXphS3o2WHdxWHNIWmtWYlpC?=
 =?utf-8?B?S3RvZ0V0UkZEcTdXazArUUVTVUZZRmJYNnhCZUVHSGt4bnRFelo5RzVxRWY0?=
 =?utf-8?B?dzhoWUxpTHlZcWFlcTllRWlLVG1GVlJpUTdHdVR3VW9ER1NETEpLMkE0NmFF?=
 =?utf-8?B?cGpwOEZza3djbU1rNDJKaWdwemtNdVQwVVBhVHljRjB2Mkd0OVJVVFh3RWIv?=
 =?utf-8?B?UmVzeXo1VDN0QU80V0lFNEtpajFTNWYrQ0h3RHpVSllsYVZiaWQ0S1pQdVNy?=
 =?utf-8?B?ZXlVaURMaWNMcmRXWGdYcDRyQnV6STNLend1UTBYRnJSTHpXRGpZV3RFWkVV?=
 =?utf-8?B?VlN4UTR5V2FOSmRvWVROZ2RRblRmZ2RrYXdKbWVBajg1cHB4VkZpQWJrY1h4?=
 =?utf-8?B?c3B6akNubDJGTVBmNEZFc1ZkcjRwaG56a0I5elZ1WURuOVBxV05lYUZuUFlO?=
 =?utf-8?B?ZkdGMjJaRHAvWXB2UHdodzZMZVZoSWl6M2tyVVJGWnBSTmVQNVBUQnJZSkpV?=
 =?utf-8?B?cjNOWm5ZU3RaV2RhRHpIaytydU1OMHU5c2hEZGhFeWl6SWx0WGM1Z2Z6QnZX?=
 =?utf-8?B?Z1Z4Q0VseHlPdVdKUFhkeWJNeFBNd0R3ekJKbENyYmUwTXQvcS9SQVZZYVVR?=
 =?utf-8?B?WU1GVmJjckpiYnFOQlNUWDZ0bHcxek83WEZYL0hGWWZ3bTIyeVB0VWRvVWI4?=
 =?utf-8?Q?wlQ0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa21331-1d05-48c6-ab69-08d9f13deab4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:17:28.7643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30aHhmeEuWhF+cYnD4Lsgf+n0dsiGbqXh46KvisfZ2v5vsGaQqEeoo13aXQQB9Zo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1474
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 16.02.22 um 08:22 schrieb Jiawei Gu:
> Now scheduler contains device ptr. Add it so scheduler printing can be
> more reader-friendly under multiple GPU scenario.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 4787cb3acaed..da53983c93f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -506,6 +506,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   		break;
>   	}
>   
> +	ring->sched.dev = adev->dev;

That should probably be a parameter to drm_sched_init() instead and I'm 
not sure what happens in the print when this is NULL.

So make sure to update all other drivers which want to use 
drm_sched_init() as well.

Regards,
Christian.

>   	r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>   			   num_hw_submission, amdgpu_job_hang_limit,
>   			   timeout, sched_score, ring->name);

