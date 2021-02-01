Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D077EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F62264EA4
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F62264EA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C636E5CF;
	Mon,  1 Feb 2021 15:00:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE236E5CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Aw1hmSKC4YxyO3lOz7P68NHIb/INdiyXBcaTyRm+G7TzSAwqZprAiisRKsmM60ythP0sgogmFqYQJHVsAjh/yUPrckgp4ayFVVrR/DpXI7YsOqXkBVwrOKvz6ykyjCBVYzRrTou6uxC7KsgDvnhIJxUfGdW/7L45pc8tdf7WUPEwFDaSdfeQjXv3X+QUx4nzQxMGwZGDMWjbLSw0d5y4K5wCNuzYxdokKu4i/uoMmeO1WC2HTtmqYnUyBmbSmhGyzrXsMVkx/Hf9HT0JYQnd/ZZObM2UziDTZtdbCmvxhH+HVneaJHhtI1rOFxby+IegCOlq646mSlMPgd/Virkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69MIuJHCuZ2SXdRW2LPI1gP4FmEydHaLOKnWo0dR3xk=;
 b=Wfoq44TtKy33T9iD1M5mFbfbiAhMw3e21LvtqF1A712FGRf99emJsEsU1MhI0wmc842kYk8FCWbUEnZajFDYtZDIy+ZlGGTloTx4FvYVADiRhr2m2oCIwcYh/Dt1dKyhMRIDm53l77zGCLZxjkD7MzEUJAVgBzrZfCV765tYP5fPQKWYpfpn7V0FoPoWkZn56/F8DR20yaWL/uHK5SKrXz8NAWuyZlNi2jm+ygFFdmqANCUu9Y32HGaUZyubKDAJ+p1G3dOw9Rlskb098RNIvv64hnqJR0i4e18DSDhXla6FHgxQXhMEwgrO24ClRml8GH3QLpV9PzeRTxt20w9vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69MIuJHCuZ2SXdRW2LPI1gP4FmEydHaLOKnWo0dR3xk=;
 b=5U3q9VK79BYJ23fjwvbPlKUGFiuFEoQ4nqdmgz7hwHivIvsGTmcqBck4ggggwUxBjVpMAVaOqKyJQ0qNeOgpC4QfnIpEV5N9q7LqalvpqJFXkLgyiag80N1JjLcZd0MdiOTRqtD+pRtRpHwxksp+BDq8NUJ6LHE7Gi3T4uVEcr8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 15:00:51 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 15:00:51 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: fix ring priority assignment
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201143800.26908-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <46571899-9beb-0348-5711-6c146e316fb0@amd.com>
Date: Mon, 1 Feb 2021 16:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210201143800.26908-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM9P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::10) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM9P193CA0005.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 15:00:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aaa9a3d9-4c8c-4f7c-0ee1-08d8c6c22a64
X-MS-TrafficTypeDiagnostic: MN2PR12MB4374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43742C79F50F62929DF512E683B69@MN2PR12MB4374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZiC5dtMqGnm8nmRGll6Nh0W0eSGiJHIdDsiSmAwOG2PCpX9Ka5XOZXpaXh7Ms8I95qVUvIQO8bzvRltjgb4EfLtqqk4VQrwQBTcCBWlv3Ip8sBK6LLlukPKAK4IlUek6tZtsblZON9DX4MVd3jOr2ksVhkLE6WhxUBktJUQlmA27dvZH82pdv/Yl9X8ceCIAHES2L1dsHLNxx9ykJEY7bhYWIsZTbXTPuEBzx+oTMEgUb3xncEGhB2BomU0+LRbKeMBLsOwuGUB9G3ql0xAuvD4jv3dL+8ktpsx6+9u4Ijj5aJ6sxWBPwSvJMM8jB3XpXnyPb35uXPMkdNNv4vWl/61ib/5qcvR3S2LvJ0DTSVZNYkweEzbG4BHdVKiKSUb9/8Z2YaRn+lilbJO4GCLaq8CNMo6P7YqbwviHvsMCLyUNyjjM1igolT+c2C2hggBW5Pd8g3Mo8mrUufAWWqroLeIUorKJoCB2mEX059ziGACHRNnLvqAPrM3brCBNSfD3wDcVwy5KNpnmURORgUYSQghcljlsCCMjoPeBPnVG8HZLHCLzXTuvm0J8n7OEmIxeL34wuaVdGtN/nRwu95NQpEyXKQ08paoXaWeaBiaydI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(316002)(6666004)(36756003)(8936002)(6486002)(83380400001)(31686004)(52116002)(4326008)(186003)(2906002)(478600001)(86362001)(31696002)(66476007)(8676002)(66556008)(66946007)(5660300002)(16526019)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WUVvZTY3Q1Q2eURzRnpXQ0JqcVZINDVQN3lEMkUyT3pzTkhwYUdMcEozaDds?=
 =?utf-8?B?TlpwMi95eG1RRWNaNVBiNmUxR0pSRUllOUdjc2JBblVNN3ZkQXhQcVdlN3ZY?=
 =?utf-8?B?YWhmVVpUV1pUenVqWE44MGJyVmhqK3FYS0NraWp3L1FVZHR6eVhRd0Jucktl?=
 =?utf-8?B?QlpDdVRIQmtKTmZodHdldERLUnJlOTh3SXYvNWtBUXFpb1hPaldzZnZtSUxt?=
 =?utf-8?B?cVlHSnNNQ3VwL0hSckI1cnpoYjA2ck1JRmt5VlZ0bzA5Z2Rsamk2aHhPYTBh?=
 =?utf-8?B?bTNhQzZLdEl4VWRsUlpSeTNpb2J0TXowRzFUS1JJV2ZjUGl6c1VPc3FuYTJP?=
 =?utf-8?B?YVdMVmV2eUwyT1dWaTBCd0VCY1RPMXVoWWlpYTdZbHlXWkE2cllpU2c1ak5U?=
 =?utf-8?B?REcxT25mSmFnSS96UEVIay9EbWEzQ25wTWNxVWVVUXFtaCtIb0tSc3QrMnBI?=
 =?utf-8?B?alhWREJoYzY1cFpYK09oVzg0SWlqT1hIcFNvK1VZMmhRWVVTQlRWRzE0WXVC?=
 =?utf-8?B?VUdYSGZWUHhaaTJETXA2eGE4VTRJcndDT0NoOVFoK0pyVXBtelJPdWNJYncw?=
 =?utf-8?B?Q3c4T0ZtcmUraXVtUlN4Unl6SW5JUUtyMURHbGo5eDlJL21pTlVYblJUME5h?=
 =?utf-8?B?NWM5YjZ0Qk41TmlLWTUwd2k5SkxTRXBkZDI4SzFuV1RwQkVLZTVIekY4M3Ex?=
 =?utf-8?B?Y1ZidkU2QTBFR2R0a3NhTnhIUk00bU1WaTQrSGk3OThGZDBKY2ZUbHFlV1Ax?=
 =?utf-8?B?WHpXQ1RBenZUa3k1YU1UY3locFZQSlNyZTlFdHM1UGpWUTQ0dm5remZDTUlW?=
 =?utf-8?B?M0xUSnFLR0NSTm03YTFEak4wYkduVHZleFJnMTREMnF3bHdEbHZ2VCtpYUlt?=
 =?utf-8?B?dmsvSW5Kelo2aU5oQ1h0eitLdTdlQ0tOMWFtV1RMR2h4T3d0Z2l5VnU5ZDVz?=
 =?utf-8?B?bXBqSFdJZStaK3dWS2hYZElxV2hBR2JOTmMzbitEK2h0eXRSVTFqSVVKMWE3?=
 =?utf-8?B?MVFYbDlkNFpNSDcvKzVGUndWYWpOYk5EekxHOHJIVnpYYTM0RDhOZmNDM2hn?=
 =?utf-8?B?ZnRsSkl0MUtrQkt5Q3V6dzJhUVBsSS9CN2c4ZE93NURzek5xcG1sVlNGNHE5?=
 =?utf-8?B?UmpPZC9uYU4wdEx1QVArL0NWVHFPd1lZY09rbG5GNUhyaHJsV3NLTkh1cGdy?=
 =?utf-8?B?NzNFSFo2bWlMNDVMd2RHQnpmNVY5UVdmb2duVmVDVGtWVGNJeURhVVpDWS9Q?=
 =?utf-8?B?czRoblZxaFZPNFhJem5MOTMvWFR4NVRSVlRLZU1NSTE3TWxOQjdkWVhUOFNv?=
 =?utf-8?B?WlpHYk5XeGx1YzhYUXNvYXIxc1pOZDZUZmQ0WmxyTExYYWhOdzBaNVNqRWVW?=
 =?utf-8?B?aXdKUWRaRnJFRFVZV2JWa0NxckFTem5VNy91czdZQitreHhYL3Q2bG92aTli?=
 =?utf-8?B?alJzQ0lEbG9OYkNpcW9SbEFXa2xKc0hnNmVkM05zUllJNkN1UXV0SjZIZytW?=
 =?utf-8?Q?khktqQ97F58HjcX+1LVJ6UB0oDw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa9a3d9-4c8c-4f7c-0ee1-08d8c6c22a64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:00:51.2879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQTd6skR2XqIjIGY8DtVPwrFRx9ZKCTxc2LjK/03jeSsrkiidF8hXp+N+K+Z+bBl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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
Cc: Alexander.Deucher@amd.com, Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.02.21 um 15:37 schrieb Nirmoy Das:
> Assign correct ring priority.
>
> Fixes: 33abcb1f5a17 ("drm/amdgpu: set compute queue priority at mqd_init")
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 1a612f51ecd9..b3d064383807 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -258,7 +258,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	}
>   
>   	ring->max_dw = max_dw;
> -	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
> +	ring->priority = (hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH) ?
> +		DRM_SCHED_PRIORITY_HIGH : DRM_SCHED_PRIORITY_NORMAL;
>   	mutex_init(&ring->priority_mutex);

I think we should rather nuke the ring->priority and priority_mutex 
fields here, cause that is completely unused right now.

(We can of course keep the priority field around, but I suggest to use 
the hw priority directly).

Christian.

>   
>   	if (!ring->no_scheduler) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
