Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D33C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 06:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9317D10E9E0;
	Thu,  5 May 2022 06:52:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B54B10EA9E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 06:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em3hTbQy1k7CbZzUZt/4VYIJytadJr13lxjOyJtp04J9XboV1E7hpKT/VJtbMRdwyY58RFitV/CeA+N9B0rRCLGNviRrgLLxJpDtK5+BUDU/NGVa89uD4t1SlLxhc5ACWXc5sKrcolQcQiXkiDGm29jzZkQ+Ul4ekpeBMjBG2nDQJRnhK+H/+p5Hqh6YILCNDL6beKrefyOjy4QKFzEye7/IeXuM5KUjnf9KzT9DQb56bV/SWVslc3yjBzOaz6F0TuJIxCu9132lJ/XuZSbyxuJKt0xS20WH+gjNaRHoLTUhn07WlS2k7lrlT/l7+g5wvUbVlnbCrwvD6WQoYwCm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpbDBMIVRK0ov86B6twpN1IWKfKdnGSouLwRgGZofBc=;
 b=LqASLMAOQuxYx7ZMPt4oQeS9ZT7N7CUxzplLjVnCqB081jroB/Wp74U2BCdLb+Zu1aLE3F3c+Hx1tDuviP2VYfpdykVzS3bVLQHIgLBP1dvgav1pmCbxh7Jg9PsvyscadseaHxIpXQVIckqtloYaWLxqmgaCGa430KxPttv+PijJxik/vK9uXM16t8Pq9XfkPgSTGox9oN5MGV09Yk5nLfK2MzuZsDjZMp6ZeaokkI73fPuiNfn5ZGdju9Jci4H2RdQ4uILZu9KMRLHdh7kXcMssbgosE9PNumqXGKB3aruh6Ejk2YyGr8/A5gKUxrxItSLrwM1iqrxoQn5MPMa3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpbDBMIVRK0ov86B6twpN1IWKfKdnGSouLwRgGZofBc=;
 b=IjgQuPLUVHWcZ7Fnaj7OSSrOgIpCawmd4zUqtNBYUn/KzJxxzsQp/v9fnmym7+VzhdwbokUl6aF2e+Kt/DMjq8i8ATfZMIqRSlZKN67riIRwdm5kvDRNYtAa1F3tCOsUhOAU+op1XUfkNKW8VT3IkRRXUY0ymX8CItys05JKrwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR12MB1200.namprd12.prod.outlook.com (2603:10b6:300:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Thu, 5 May
 2022 06:52:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 06:52:43 +0000
Message-ID: <1cc60445-a10d-3b7e-fdac-ec3dd29a42e0@amd.com>
Date: Thu, 5 May 2022 08:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: flush delete wq after wait fence
Content-Language: en-US
To: Yiqing Yao <yiqing.yao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220505063527.957333-1-yiqing.yao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220505063527.957333-1-yiqing.yao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0221.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d69b7977-bb54-47e7-5310-08da2e63daac
X-MS-TrafficTypeDiagnostic: MWHPR12MB1200:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB120017C3529BA84C223AEAED83C29@MWHPR12MB1200.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWOnbnfKYPhmua3sOhtn3rilgVHp2ypa/KvFpvJtvGlmpnat8+LVHKpZhM37vlvVs8LgTlyonfJARgdrA8AjC9uC1nNyrWj6yAIf2bOlBIlmxC1061/2CmTme90KAY4OSJjOJtIwvN96IFkym5mVt3srRCWS3hKehfsuFDUtsuQWSHIayFQR6X/QG20cfxFilhIdtk5+a9Utl1lKQ+exjYtv2aH6ldJmX7wbMoKnyB7iHWA87V0hj/ehUIlitkkeit1vH6Zpc3bG0APIfm/aQNRSOOkzlxkTJBs3ure5cl8LiPN+K4KtaeHaojzwZoP5Jc85bl2Bgz53dEEvQqxm2ss6szQI6A40a2OTtIPoePgO5jBIzzilwqERAF+ITtkSvs1hsZGyXJJGkCyVU1dW3Yk9T+kFdNmViEgQIebgXu0LFlYgm6ihTcFxBYGD78zOjUNEv14vxQuZ303GocjztcU0y7YQsXlwxWEMjhcCQStifdFmuLCCUojTfs5FRD+fCVfvOF1OHT/v1ByO2ObwOvDQ0Wv7oPb92Z5N5MUNxkO7gqxT1rNaBMQsSWUekXkx0JWJ/uNDknHkiNFpwOJi/lL467unVkmJVlAej/DJSdjzJoFOHXje0P1vT10xkEIeAMss4iU4e75Sw3SuCZ7cP9XhHJzOJcyEGXeLdYO28YTd59pzhGo350Eh5Z+z+7Y9V8Wj8yq88i5Hxiz7mwS4hjkAIyQLYbPR6zXF5L+SfcKiunNqt+nKETdINLDZ8GQn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(8676002)(66946007)(4326008)(2616005)(66476007)(66556008)(8936002)(2906002)(66574015)(186003)(5660300002)(83380400001)(31686004)(316002)(31696002)(36756003)(6512007)(86362001)(26005)(6506007)(6666004)(38100700002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJ6a3pBSWtVTEJWb2crNi9jQ1F3NmR6bGpsdlZBR1Y2RnF2UlNvLzdubGxP?=
 =?utf-8?B?UmFnUWMvbEN4TE1HSVZoYmUwNVlzbjVjNEVUa2tQcjI2U252S1RrMWFhOXZj?=
 =?utf-8?B?aXdPdXgyNzVyUzdXancrMkZjMG9RYlFjaVZXNGNQK0dmMEFKcjMzZTBTVXBk?=
 =?utf-8?B?MkhIaWlqT0hTKzdlNVBlMm9DdytLK1Byd21NRjhUSHhBY2dNNUxxZHNrUng2?=
 =?utf-8?B?dzZINWdidm1kbUlIRnV6STBvdzhKVHFWSHpPWmpQZStVdDQ2WG9ZdGREdE5q?=
 =?utf-8?B?WEFyMkF3ZGpvKzNuUW0xOENOQjB0akV4V0F5eG94cU1xSkVSSVVkSTMzbDBj?=
 =?utf-8?B?TXFzSVRhOE5XaU0yNmZqeEZvelZkUmt1LzdUYzJtNkJQOFFCelBUT3pjL3dz?=
 =?utf-8?B?cFptR2s0MFprOUJzSm1TS096WXlFS2IxUjZiZGQzM3VYM0dHSHduOWpLL1o3?=
 =?utf-8?B?U0FHM0ZvWENWN3B1K1IzSVZ0RFp2c2VNeWF3MTRFOUgrR0dzODAwVGJwcGNU?=
 =?utf-8?B?QXMxQ1ltdUpaYmttQU16aGo3cGJabDNWR0dxSVF4SEZ4Y011enJ2RERHWVFH?=
 =?utf-8?B?NUlUa3VBd3VSMlk2Rkk1cDkzeW8zTGJDNDRNV3VXTmJLbTEvUHBiemh0YTlC?=
 =?utf-8?B?MVdsQ1NNWGRUOVlYbDB1RUZVdnJqYXM0cnd2dWJKOGtUZ2M5M0ZycEtKR3RC?=
 =?utf-8?B?eUdFMEpEaUFVazR6UUloY1RpTE9OYVlaY2dpcXVaN0lkMUZlWWNqYXpjZFNK?=
 =?utf-8?B?MTk2Wkl1TXBHWVowRW5yd1FXNDFFQzE5OXdwMlBWWmlFbzIrZUhvc1ZNWWM3?=
 =?utf-8?B?WEtoRk9UNmdvNHVXVWM4T1BpUHZJSVF3Ulh4eFFtc0hBdTFOZXpEL3Bwcmda?=
 =?utf-8?B?QndZWmxFYkpxMndyMllqN0F0c3BpSHkrTkprU2xjdjluOHdBc2twRDFQRjNk?=
 =?utf-8?B?MnZsdVVNUndqVWJvMzNHSmF5UnRZdEZXU09pbHBXNVNWdDA1VlJaQytyV1R4?=
 =?utf-8?B?NVU4SDYveDlRL3lOV1FqSC8zQ0NoQXdtelVwK2d6QkhSWmhHM3hmcFNQTVRJ?=
 =?utf-8?B?TDcxNDVZVWVqU0MxUXZVNHpNaE5XYkhGQzhrRVowVTNYeGtxVXY0dThyeGNl?=
 =?utf-8?B?Z0taaThSQjE2czYwemozNHJVZmtrUmQzNmxTU2VuNXZYNHJIUmVabUtxWFph?=
 =?utf-8?B?Z2NqdjJTdkY1VmFhTkV1Tko0U3BtMHFSSVVwQXRLWTd4ektDUEpHN1VEKzdN?=
 =?utf-8?B?VVVtbzl6WEhFVklPMGE2UmhqdUM1SlhqZHh0QjZXUE40Z0VCZnFuSkVrbGNR?=
 =?utf-8?B?d0tQQWNuTnpFSjYvaWk4bUNmbVVIWGxqREVGWTN2bzhnZzJlaDFUZ2xYbU90?=
 =?utf-8?B?VGJHVEZPVUIvTFFLdFhQRTBvZGVWREhtUTB3SE1tYUVCV2FaNlc5YUhnTFF3?=
 =?utf-8?B?Y09PQ1Q5VzlBd1ZxM2U5UU5aNE15VURYQ05ocnR2RTdCQU9nd004UkRTVXZY?=
 =?utf-8?B?WkFGUmhsaXRac210T2I3d2p4QWJyYnJHak03d1BwRGxvbThOS0dNREEwZ216?=
 =?utf-8?B?Q3d3SUlmeWlSU3RhOEo5emUzbVAxZnpOZlpHaWRxMVNQL0twUEk1c3BDM3gz?=
 =?utf-8?B?RlYxVDJGSkVNV0RONEZ0V0NOVGxTL2VwRXpxN0VoVmtRZHo2NFlTMFBweVRV?=
 =?utf-8?B?eGJrNFBxbk5oWnVkbThhYXFhcnV6NVoyVnltR2JFTzlra1Rpb1RYM1dHTG42?=
 =?utf-8?B?Tk5qejVEY0RwdHBBWWlyTzg2cmRKZW1RcDhFRVZpV215dkFJdzY4TExCYnVY?=
 =?utf-8?B?MzdTV28yQ0kwMldiVEdPU2g5S3NJb2ROSjZBN05vRFFBdVorTG5PcWJ0dnZ2?=
 =?utf-8?B?eGE3RDh3NEltTEIzd0FWRkdJdHFQd293clA1d2tIbGVXMStSRWdvYitMUHl6?=
 =?utf-8?B?OWNhTEtENDNTRngxSTQ4dXRlK3ozVXJRZWRaa1F1S0E0aHRBZUJyejQ4cEV4?=
 =?utf-8?B?NUdZVGtUTS9McDZRTkQ0aVRXWE1mczRCaldCaVg4WVUyMllTaFhrWGQrTkM4?=
 =?utf-8?B?LzY3dDlicTV1V1o3MHZuKzdZdmhudGJrQWd6SWx3VVNmK3lSNi9TZnVkcnVP?=
 =?utf-8?B?WkxxSzBqOHI5RnYyTjdDQkgraTNkckdJNHRWVnBNbmtnMDhtSWFIa3RWZkRZ?=
 =?utf-8?B?MFlKb2NGa2J6RDAwRTlIakwxdEg5WkUzSDNRU1U4NEh0bmE1amRXTGpVdkdq?=
 =?utf-8?B?djQrTzdFQndUSUJJdzVSd0kvY0RmblhSWWVMS1BudTJIMDRvcFZJRkZ5ZlJ5?=
 =?utf-8?B?VGg4R1FzVEVUZmk0elBIc012V0hnNVpyK0Q3TjRCNkN6TlZjOGsxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69b7977-bb54-47e7-5310-08da2e63daac
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 06:52:43.3900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b38j3Mrav23vXYZxKDjRIZ/z0EL372cYhb0h8eq1zEzeULMxzyjRPvijI1JzlxLX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1200
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
Cc: jingwen.chen2@amd.com, xinhui.pan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.05.22 um 08:35 schrieb Yiqing Yao:
> [why]
> lru_list not empty warning in sw fini during repeated device bind unbind.
> There should be a amdgpu_fence_wait_empty() before the flush_delayed_work()
> call as sugested.
>
> [how]
> Do flush_delayed_work for ttm bo delayed delete wq after fence_driver_hw_fini.
>
> Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>

Sounds reasonable to me now, let's just hope that we haven't missed any 
other dependency.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 14c5ccf81e80..92e5ed3ed345 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4003,10 +4003,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
>   	dev_info(adev->dev, "amdgpu: finishing device.\n");
>   	flush_delayed_work(&adev->delayed_init_work);
> -	if (adev->mman.initialized) {
> -		flush_delayed_work(&adev->mman.bdev.wq);
> -		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> -	}
>   	adev->shutdown = true;
>   
>   	/* make sure IB test finished before entering exclusive mode
> @@ -4029,6 +4025,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	}
>   	amdgpu_fence_driver_hw_fini(adev);
>   
> +	if (adev->mman.initialized) {
> +		flush_delayed_work(&adev->mman.bdev.wq);
> +		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +	}
> +
>   	if (adev->pm_sysfs_en)
>   		amdgpu_pm_sysfs_fini(adev);
>   	if (adev->ucode_sysfs_en)

