Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26B7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 14:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E84613CE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 14:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90E84613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBA36EA6E;
	Wed, 29 Sep 2021 14:32:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A9E6EA6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 14:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDcBE8MDFe4kD8kJuxyzecxhFKLveeaEoXnLhHEqh0VY8NHHM6hUBUzMHrHtxAEGzwsZDhvpW6zA9wZO2iYesWib7M4AHXKaT1uXiuRbrwYHI4XXDSJgWca9XgxEc779SD9YDLI8SaeTC14VwJv+dUBBFR7hftOVUe92sTjCGcj6zFMiJqlQIOuRJWw88w8kQ71myllx3EUchmc1G0pvcDcdWMSLCaqqAv7qEc2QHmplb1Z0M3PKOg5MUSRBbTBHItCTZXZABbbo8jJhjdy86yri3OmNaFQ2PGWt4hkwKTJwOa34ACanxXF9igXIjeWm29sxvoRSKPGIQdQXy11BBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=43iFDVFQ8CG1TG5F4fXZdgMKKa3JLfhanvwMMBVVg+w=;
 b=IThohz4DciMLYVz6zqP3ehAhWqRKVH1g454E/S4vflm/A3VRNwDJbfb+PJeKz78kWfYJvyVTJ1cnrhQos8UktlT5W6Nsxfcj3nLoMX5l3LcIWSLWnavvF9+IkpfNLDN7eQUTs4NMO5LiK0DUav/FGsWk8EB6orMw+BeeL0YKgC+ySWmabFmoCs8ckG4flJXYhs6Gb6cfQVtggrJWUKQYg/qdJktydibCbHSWestaBADUsIKU8+kp18xn9YBZbidBqRvEUcAfAJflMAYQ6fhbf30GIBQHI/TYMCwXcd86lX4EBa6sT/AXhql4weMd9+K3if6xYFeG6CMzlJivlbS0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43iFDVFQ8CG1TG5F4fXZdgMKKa3JLfhanvwMMBVVg+w=;
 b=E9y4xU87xccfsGmYAI4EOj3Dj6r1NuGjjj12BBFn688xF292BfNZVtPM6LA7MxIr0ARDoKl2z4n8TWooEM+ocHfp3lp7vvaWO/z4HtqKB9jnb72lI1V+fqGb6B5yjpE+8ULB6SzxDB89BDJPekBppMKSlc59bYzY8pa5DrG+GeA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB2764.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 14:32:19 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4544.021; Wed, 29 Sep
 2021 14:32:19 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Do irq_fini_hw after ip_fini_early
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Evan Quan <Evan.Quan@amd.com>, horace.chen@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Jack Xiao
 <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>
References: <20210929092200.783889-1-YuBiao.Wang@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <4e0a25ad-b74a-afc9-6b9b-35e5484b3fc9@amd.com>
Date: Wed, 29 Sep 2021 10:32:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210929092200.783889-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::21) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:147d:1cf0:1371:2dc0]
 (2607:fea8:3edf:49b0:147d:1cf0:1371:2dc0) by
 YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 14:32:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b8de5d-e154-41f3-995f-08d98355f0ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB2764:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27645F3FAE81BBB2B586F4EEEAA99@DM6PR12MB2764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLLdK+pQlBuyEBwwKtJe8HbiDXv87FK78+KDm+LDKKanFYGd6UBsptfZBg7LM1BtjQnZA4mnv6mlrF2VkkdcXXUMSegvos9XYVmU5DDzINOdNc/U3vmg/CBTnPPy1wprmi8RA4gIV2nBOZJ4TP4+5YqpeMJNT4EVnkF7Pf+lJCQ5aXRFeOMPUVn3o2P/SYfJPGhZp96l+pUGpMk/JGU3I2O2lsHajJdOhcQrNMMThERjD1BDDvj7pSg9WBaPjzmfarxRTzyOEKdrn7sZE8TUdoCvLa/ih/Pb4LTKcIgGQkpnAS6u0PynEGTnmBe0dQgxTYMfSaAkDz4nAQpKHRaRCQOeKFLX9wfFPJn/iHgCey9h4tlgRFwCKFPSe41Ete048mNS6sBQUKzfInA1HUk/5F/YnB+10TuLQ2CSOYyhWNFwyYmChMVQycRLppFxMOaNTTEY4MNbRc6UCYv5dvVOwN7/iT9rR/VLFilx5cPYFYIVMZGR4PtPikjwjCfC7kf6pTJLVLobfdYoxqEoolciworvZB0OxMg+tLkfl7wvi66eAfJ4odQMOozwGQ0iga/sdf2WkviJ5podTSxDeiCctS5LZUn7iWv8mmpP6bd4JXY6BUmvkS3rvV26EeNyrbTw36luLvNhiKOiazto3sXOBYQA2vW9XEUgni9xQmdOWZfuU41i50hsHTsS4j8NP41loxuGv6tMPDwNCoLopQqSsDV2akrkEAqCVUITiQ9vC1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(86362001)(38100700002)(508600001)(66556008)(66476007)(36756003)(66946007)(966005)(2906002)(83380400001)(8676002)(2616005)(4326008)(54906003)(44832011)(316002)(6486002)(8936002)(53546011)(5660300002)(186003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFSVFRsLzM5bGYzeE4wZkpxaXhObzI4WGs0RkVUbVdsb0NKZ2hOdXJWYWZ2?=
 =?utf-8?B?WThGZG1Tc01oSDhaOUs4eDNmNjAvQVVSUEx3WnBURmoreHFRdG1xVGg0SFhW?=
 =?utf-8?B?UXh1SjQ2UVFsK3JlZWRnZW1IbFNYbjVmRUpJL1RGY1ZyTkE0NlFMSmx0d3pF?=
 =?utf-8?B?V21JVWZzOXB6bmt6R1h4amJJVVFhT2J3MkdhcmFZTUVqZCs1RWVIMk44UDRJ?=
 =?utf-8?B?cmkzOXNFa0pXcTdMbFM0TWZMYW1FZDFsckh5dzFLekx0dGZyZTNOemFRQksr?=
 =?utf-8?B?cmpSVkE1Tm9RYlE3dUg5Q2NBcWxVSy9GVE5VMkNZOG1EZENIcFl0d0RsMG5I?=
 =?utf-8?B?SHY2RDdydyt4MitRQVp6MlBpNERyc3VxNWs5ODZMcFoxQkRBSlB5T2N5YUpE?=
 =?utf-8?B?b2h2bXg1U09GcFY2anZOYU5nMitDc2s3eFRXN2RKNEoyaFNWVlIvbGQwTXVq?=
 =?utf-8?B?VEV2VXNNRFJRN3BBblJrNHJPNVlCMGFRQTdrcktjMnMwaFNGdU9LSWNmMzN6?=
 =?utf-8?B?UFlVb1I5aFdLU055RVY4T1VBM0x0THgzS2Z3dXBob3htY0FpOVVxdUdZcEFT?=
 =?utf-8?B?ZGVzTmR5RmlkMEMvSzVRT0xCSzhvOS9ITlJWYi9KWGFrRlVSNWhWSWUyTVBk?=
 =?utf-8?B?M3lEVEt4Sjl6amlUUEd0ZSs5Lzd5eitsMlUrQ0lrV0ZBc0hKakRDbFhPZm5h?=
 =?utf-8?B?dmU5bXNTSldFbXJTb2hQdDBJZGk1elMwMEwzRkZIeTUwYmlXdFJDUVZLYU1P?=
 =?utf-8?B?a0ZPYkVmZVZTazJtb25vQ1g3N3NTYmxYc2k3SkNSczM3elRLRFJLaXY3aG1E?=
 =?utf-8?B?SHBJbWtWaVg4R0NjQ3h6SURtWTUzTGRoVmdiKytDYzNpNG03d3UraGJIeDEr?=
 =?utf-8?B?Z2JvVC8vQXNwWDViTHFZQ3NHUHo3NjQ1ZVFLbkUwTTVabWt6aURxeDZwVWkw?=
 =?utf-8?B?aVozUHZRVEYvR0tFczNoSi8vc0FqNzdYL2dKOU9keDlDSVpkbC9NaWk0OUo1?=
 =?utf-8?B?UFZadnFiTytHazFSVEoxV0p2V0IwVFdLOW1yRk9TejBudVlZNVRjVjFmMTYy?=
 =?utf-8?B?Y2hSOWNWRmMyVGNXdm1wSzRjZUNsUlRaNmxmNS9YdzZZamN3NDBXcVp4d1NT?=
 =?utf-8?B?TjV6QWExbnFxMDMwUit0cmFuR0lNVUthRC8vckU5K1ptd0ovTGU1R3hobko4?=
 =?utf-8?B?ZzlGZ0hoK2Z4QmQyOVY3SnpaNTB2Y290YThpazVzTVBqMTQwbzFkelAva1hZ?=
 =?utf-8?B?RVQ0VjM0OTdTK0p0cER5cmJJaE14ellYMWxvYVdLK1h3RWNvenBYV2FJV0Nn?=
 =?utf-8?B?U09LRm5iUzIrbngxMnJHTEpBRnNSRUpSUlR0SVovOWI1eGRJOGlkMDQrOU54?=
 =?utf-8?B?WHhaeHkyVHRIWTFOOEtRWHdDUXhyaDQ4cDBqdWgxZUNoRktURW4ycExheE9M?=
 =?utf-8?B?bnczcWRRSUg0Y2N3NUdoVktiTkNVaitmdzdJSUhSelNuRm9jMU1jc3RnSE9o?=
 =?utf-8?B?NnhkOHEwZUhMM3lDWTlESnFKZFE0NEVXdVdzdzRiSFRsWjFGRGJPNXpOM0F1?=
 =?utf-8?B?WHBCNDlvMktDTmRMY3NPcDVuUEdNcisyRWdtcE9tOXJ1L0J4Slh5SS95eVVI?=
 =?utf-8?B?UkdRRmMzNFR6MmtLR2pDWExPeENsYWxZR20rVCtEQUFINW5ESnRoMDQ5SklU?=
 =?utf-8?B?eURRNlhKYjhYQml6aHVNT21NV1QySWI2OC9oNHJVVEViTU1XWkZ3WVFjdzlT?=
 =?utf-8?B?Y24rbERPeHl4MUZlcmNRZFdvcGtLYjBlRmY1d3JGUDYyWTJaN1BaNG44MGwy?=
 =?utf-8?B?SkQrd0JHNFNZbXZKVUVzRHhBdy9IZU9GNVB0cjdTV1RacGxnd1hHbFU4N2pW?=
 =?utf-8?Q?4A+Q2KbRHzg4Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b8de5d-e154-41f3-995f-08d98355f0ef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 14:32:18.9178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/0B8hi7CyHoGjcWMuV2WnxQA6xnGV33XmtutHBG4Z/LhhxUsJHLvq3NfiT/c36hU+CQeeuDMbKiGCGmpCJ3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2764
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

Can you test  this change with hotunplug tests in libdrm ?
Since the tests are still in disabled mode until latest fixes propagate
to drm-next upstream you will need to comment out 
https://gitlab.freedesktop.org/mesa/drm/-/blob/main/tests/amdgpu/hotunplug_tests.c#L65
I recently fixed a few regressions in amdgpu so hopefully there isn't 
more regressions
which will interfere with your testing.

Andrey

On 2021-09-29 5:22 a.m., YuBiao Wang wrote:
> Some IP such as SMU need irq_put to perform hw_fini.
> So move irq_fini_hw after ip_fini.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4c8f2f4647c0..18e26a78ef82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3864,10 +3864,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		amdgpu_ucode_sysfs_fini(adev);
>   	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>   
> -	amdgpu_irq_fini_hw(adev);
> -
>   	amdgpu_device_ip_fini_early(adev);
>   
> +	amdgpu_irq_fini_hw(adev);
> +
>   	ttm_device_clear_dma_mappings(&adev->mman.bdev);
>   
>   	amdgpu_gart_dummy_page_fini(adev);
