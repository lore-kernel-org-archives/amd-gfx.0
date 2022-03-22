Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0025FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 13:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDFF10E6E2;
	Tue, 22 Mar 2022 13:33:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA5310E6EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 13:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBMtkpLgG9bnnCRgXz5B/Ce8hk5k9xKChW6AJhfXi1yl+mOyGI5TUzP+DS7ocazKcaT+lMlu73BJfZwdOAZPnnasJLzuAEVLJDispH4xQH6wgsZI/x/Dk+os/g/gt2QGev9uV0wsEX/eW3/zqxxLLi8ZJzGpFZN9zKkbtzUDl2DC7CPuBH+62SEufBPsuM15WvQCkTdUa2sw5PK0exhH6Kw4fIaJ80J8ctUS2oj+FqWKUvVmSt/DH8Le49nToqSx+0jvnOiWatTUR6v+FLIZG7vwbrtmhZKGeLPG0+7kqWLP2Mn/kb6eDrJqwFeLnBM1VLNgSUxrEU5ShEB1ubrj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB0xaWAu7E4C0J90wTqV+R60Pjz21fR9zoKb9xVzZO4=;
 b=n91I40eOIO00QdCqYxLKhbgZVA1WnaEGOQ7YqC46orbhetrzYaFOy4XIzUwFJa/NV/fVXlojBS+6xoahEZ1pT++DdwEGKhalc9sYh99rRkKGhWHMhzHwAv+z01dODDrJDjQm3nEo/5iURzvXP2LPgEEWKH+08WrliF1pUr3d69XvxQTRSRRMH6Cee8zNy9e3+Xy+3LyOSmmogfxnnO3ySHkKtrnlfomMsX276wUxndTFZHphfEuyCX/RaMo8Hs67Fc9HZdLsj0HMCwCzh9P2rub/RpX1NhU5ifOIYgwAuCxijdlZQraqb6xsijNBVTJDkO5B5LX19ibYDbB99q6dAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB0xaWAu7E4C0J90wTqV+R60Pjz21fR9zoKb9xVzZO4=;
 b=C5LXH4u0IJQ+xL0IjqtKuWwziJyac9dqqESvngqmCOApSqdifZAODWl+J9OWktyJC1mBpzUZKjtUA/JBjMY04/zMXcb29ZA3amsZmzXOv4kOnq0cBccBdjKrH03EjHQLKQSD729JISjoX9GYK88Ins4RGQ7eBYnqGavJ7+t9hfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Tue, 22 Mar
 2022 13:33:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 13:33:37 +0000
Message-ID: <bcf4bb86-4b76-0b02-d0f6-2af822e5276f@amd.com>
Date: Tue, 22 Mar 2022 14:33:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Correct the parameter name of amdgpu_ring_init
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220322125308.3771732-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220322125308.3771732-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0100.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::41) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81859bdc-9509-46c8-98bf-08da0c089189
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4256DE7A9E23549BA51F01C883179@MN2PR12MB4256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3vkLKb99ATK7NyblClTO5nZyfUO+73VvDqpMVSYmarOuEuRRyenForty48tXN9DMSep1qpJAten6otHpT2C2l6LYJjyIbgTQ06B+yIaNs3Srf2kZDKOUjtbH+BvUvHgbosv7e3Licaqzyc3MsCndT3eFVjjDzzx893HEo6uTyeK8QXMwd7NlsBN0TDmkfVcg4mhyNLT6qveo/X3vnyxXzKk6ANwunfI93Ids1Sa3vEwWlDFRHmxwMEJNYw3td1Lp+C8pUzU/0C9d78N5KF+E9APzFI0mf9IkMGkh1Ui/9hK7OzJzOjw6IGBf2NWjQLAr7BPdqB8DDUGwGzICCUn0+U4JmZ4zGVZpacjm8g8/9yromu7aDnMEERlfDfqf6f5hYy3eEd/+5KC/XJBXv7PHzJ/++ZywBAB9NpUi+gNl9K84+FOkHFv0hRfdZ5tHksJDvW7OC9n1a1G2ilqhButrTp16Sighr5dhc6uf9jR3Bt6i5teDuPR7RUg3pKZUz9tWxdvsS8VmD9OwrV5V+cKd++h3F31mnOpUF6YiW1vWKe1lUeKyW4WsirWrcY8JByTh0hvmcT6lG2nPFVJFUiCNrBrero2TvGhKrJ4g2ih9UmZL7FRKOfT6+J0oLjeERDk83gDnZV0owDLFSwi02dEamiJpxJ9eOJesQMQVm6aiwKLXHO1z+8VR/N0kKtEx2KXXe+tQo+YCPOuX34JEJT6HMizoaJ2tXLlWIL6Wueg8qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(86362001)(508600001)(2906002)(66946007)(6512007)(4326008)(8676002)(66476007)(66556008)(186003)(8936002)(6506007)(5660300002)(6666004)(2616005)(31696002)(36756003)(316002)(6486002)(83380400001)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHVIU1lMQlEvMS9ZNU1iemN3Ump6eDJkc1huU0I5aGZJVGtVL2xvcWJpZE1M?=
 =?utf-8?B?L3pMb2dyb3A3N2daYURqajFJbzh3NlJOb05laHVGM3UvaXA5SC9wZGxjc2o2?=
 =?utf-8?B?QmNJVjZzWWlXU2poUmI1WGwrWHljclFlbElHeWVtc2ZZZXhuTm5NeDVhMmJv?=
 =?utf-8?B?cld3S1BvQkVIaXZHRWdjU1hrc3JmL0NaUW9DTUt0LzN1RDdvSmFGRTBZdGU5?=
 =?utf-8?B?YUlxWmMrSmtRTG9IK0RBUEQrZjFPK2x3QUxMNEkwaDl3S3gySXk4OHF3OGdR?=
 =?utf-8?B?Y0VQVmx2YzNVNUNVMURwNnF4M3pjRWVHdFRtenZxdmpIcis2RG4zL3hxTHpV?=
 =?utf-8?B?eFR6dnZZdGE1Nzh1SjJhOU1vdm1PS25HMlZIbk5vdHhaZSt3SnRqbjFSMnR0?=
 =?utf-8?B?cjJhWkJOVjJJaHhlQ1FabXhQbWgrenJUVVJZemNqVmwvaXBkaVBLTVpibFQz?=
 =?utf-8?B?bkorN0FSZFk0aGJ0SmF3NXNUc2VKaVl6alFFYkJlMEw1RmdRMW54WktnTjNM?=
 =?utf-8?B?SE1Ndytod1hTblR6NUtReFJLb2lWa3AzOEdzSDZQRHZvMG9GdkVUaENYUVhX?=
 =?utf-8?B?U1J5a0RoMTF0RnRPQUJON3VxdWdyZzJEa0h1QmI0VzU1SmxxajJPNzJaQXJI?=
 =?utf-8?B?UmdLVkdDQS9hZ0NHYkVTV3BWZFg0MngwdUM3YUt6V1lkeGNhN2xrREZyZXdE?=
 =?utf-8?B?TmR5OTFHY2VDRTVyVkdDU2hpWDlRRURVRktTMlpPTG0xQmZNenY1dGg2SmtN?=
 =?utf-8?B?MjNINEc3ZHpWUnJHVEdaSDNyeEMzRThnWlE4V0lZZ1ZOZHRIS1cwUnJMbWdv?=
 =?utf-8?B?RDBPVStCaXVrWEFlWGxmUFc5U1M1Q0ViUC9pNVJ0TzlTWlRneEt6a2lEaFNM?=
 =?utf-8?B?OXk5am9tUkZxS0dJcmVvU1Zicy9xU2t6V3RvL2RrQTMveXVLaGRzRHl6bkxv?=
 =?utf-8?B?QUx1NXBsSzJqZ2dwVDRqY1JITGhxQVE3NVI5UmVySmhOUnhERVFHUitMZ1M0?=
 =?utf-8?B?elpBdUk4Qi9XR1A0OHpFREJHTVJtbnVuL3RZL2oyTXFac3A0VFExRVlURGtF?=
 =?utf-8?B?OWZyS1h5MmF5a0ZBcXdaNjVESTNCVkduaHNRd3dHcVBHU0xob2NtN0lnaERs?=
 =?utf-8?B?Z2ZtZnRDR3Z5ZHhwUkJxQVFRMGRkcHlTcFVyQ3VkT0dsV01TVCtZNUNBalBT?=
 =?utf-8?B?em14NExyTFZKaEN4N3F6YUdEWWEzREVBbnd3dHA2c08rYlZrL3ZjMmdXWld3?=
 =?utf-8?B?TnpMeXJ1QmtLRVhUbU9tbHdkU1U0Z2dDMDRoOGJ5WVpwbDhkOHo1UC9JZTBl?=
 =?utf-8?B?cEJ3TDREWnoyc3JJWEJLMWN3V3gyN3RHNXBBN3lyL0pZTlpyZnVuY21UNDZX?=
 =?utf-8?B?bHZQSHQ1NmpIZ1B5TDRrbTExVitEaXp2eUZMaG01a3ozUmJEelI5OHdnNnRV?=
 =?utf-8?B?VHdidzNQRUEyeHlLQ1QwS0Z5SFQ2WjlocmZvODRsbFBkTnY4ZFlnOURkVWlG?=
 =?utf-8?B?V3E0TkQwTWRqSWpoZlBsTGFRMXVSaTBnY0NTL0RDZVN4cFBzd3NvZmhwdGJQ?=
 =?utf-8?B?Q1NMYW52Q2g4YitMRUpFV3RzdzlDMDBuNGo0SDhtQ1RMVENkdDdCYmo3WHdB?=
 =?utf-8?B?UUFJWFJiZFNoeDZ2VnFNbnd3RzhXUDFLY3hSQmp4azBBL0N0WkUxZW5yZmRX?=
 =?utf-8?B?eDBMSkFlSVBTcXVhWFoxeHpSVkZDcWdFNURHOFoycU1BZm9BeGhDWFJJcU44?=
 =?utf-8?B?bEgrWUVJZTZvVzgzYjFqQmFOZWx1eU43dEhqSFdGMGFGWE13V3RJTDVKQitE?=
 =?utf-8?B?dDZpT0JOQnl5c2xaSXVsU0tJNk5GOTFHMnFJWnBZVDZWT2hIQnV3ZzRSS3VH?=
 =?utf-8?B?c1dWdk8xMnVja0E5cXp2MGh1bzhYQmFIZStQSm5nOHBvRGNXOHM2TWsvOGI2?=
 =?utf-8?B?Y0dzcmpHQXFGOVZTN2hIWWNVTFpFa0pNZk80aDRPV1JqMVlDUjZGQkJ2UWJL?=
 =?utf-8?B?VTlxM0EvWlBET0kvNDRqRzFqdFQ4WENqY3M5RjFvOFBCQ09BKzFEVFVndmxh?=
 =?utf-8?Q?P97SWH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81859bdc-9509-46c8-98bf-08da0c089189
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 13:33:36.9519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2KSFsGGT6Qx53cBqIBG3K73ZYrvRb0yS1dZnaNT3VTIPGf4Kx+P5KxvSJPsHC7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.03.22 um 13:53 schrieb Ma Jun:
> Correct the parameter name of amdgpu_ring_init() in header file.

Maybe write "Sync up header and implementation to use the same parameter 
names", otherwise somebody could think that this is a real functional 
bug fix and backport it.

>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

With the commit message and subject adjusted the patch is Reviewed-by: 
Christian König <christian.koenig@amd.com>

> Change-Id: I202d76ba04b137926b456b1c8a4c05a5b1a01bff
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 5320bb0883d8..317d80209e95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -300,8 +300,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>   void amdgpu_ring_commit(struct amdgpu_ring *ring);
>   void amdgpu_ring_undo(struct amdgpu_ring *ring);
>   int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
> -		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
> -		     unsigned int irq_type, unsigned int prio,
> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int hw_prio,
>   		     atomic_t *sched_score);
>   void amdgpu_ring_fini(struct amdgpu_ring *ring);
>   void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,

