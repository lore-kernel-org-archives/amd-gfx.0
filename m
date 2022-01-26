Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09E2C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 07:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DE210E523;
	Wed, 26 Jan 2022 07:20:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5FB10E523
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 07:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3RvpxPo+WhKqcMlgEjQAXp1YuurNkYFDIynJEnhLw8OU7xbDIUh+M59zX4+/h16ipMZP0YMIQX/pCBzxK8OgYfqU/QoJ+so6jkflGXI6/2YufOmZ6Ghq+7j8A8r6uT6Ro0BLZMVCm3mmznsOSmdB9/f70jshcMihB+iRnhIFIWJ/iep6uSqYq30Y0ft59g5pHLfJbjC4jhpjt+SGd85+PyxZo/Ge962mACgAuxNpMu2nnNUz/dwnQlXLZeed3T08ud4kWceK2pXHR2/XE/pLFOEt8Vn6t0NBWXS3UkNBIxdlFTeO/DIfT9FLjM+8Jc0mYGxkZ9sHo/TAi7Q71ZDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYOgulU3WrbcZ0mmXSiVfV1wlCd8jVhG836YRL01YCA=;
 b=iFROkT7839lxLK4S0iEvQIGEsg3bI0FWJqqGbSprQvEDOk+lpnyZaDhH0FGAPyAHDzG7BrndARUQVcRvnX/22GKbG0rB0tv1sqe1sqsV5aai1TZLIPkbXKBSmnaKSdv5YlnHklWH+u50y+Gjfu4H97nsM0+8441FyphDuMZ+AgjlAzTWDs4SKqBb4ExumWEf+TQD4/GuCyHtcf1uug4hfY5jHTWWfhbTVweSymiJ09pdgFWIzt/etxZ2DA1/6ueouIH/G7VfY1cewOgnsCiA21OEI10YZMkGjn4hIHuJc0wt8MyMQZ4ZaGA90evpLwwIy+Qy/DzSo0k3duc7N1ktkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYOgulU3WrbcZ0mmXSiVfV1wlCd8jVhG836YRL01YCA=;
 b=LxlCGPhH99QIpzpdSQ1BHE1X5CQDhHfTgp50AfziGB+pSbWKaBypMSA172kJFDz0gG8ElUHxF7FkMwbw50wtoocWIJJCdZO/JDU8P5DTDj4JxqG95HNSMrRpp7v2fvSwtGveIpW7qxnDdiWRJ/kwFT1iv4vx0pjb4T8jP0W5Qy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Wed, 26 Jan
 2022 07:20:24 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 07:20:24 +0000
Message-ID: <12cd56fd-e287-929c-e319-94b5173fbea5@amd.com>
Date: Wed, 26 Jan 2022 08:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Wipe all VRAM on free when RAS is enabled
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220125155802.938003-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220125155802.938003-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0201CA0022.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::32) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a00f9ba8-9a7d-4e79-88e2-08d9e09c51ad
X-MS-TrafficTypeDiagnostic: CY4PR12MB1462:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1462D860B7EA20574145965883209@CY4PR12MB1462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8o0N27fBixDrZnk/prhSujJ+oobl9RRYtDg3862WaDlwUsMvjY6O1cnIsEhoEwsmRd40KMH447EoFDFdtoTvCQ07Lmm2AWNsxBBlIPd7bydU5wjEAZFTQXNGNQxFhwQJ2nvjaIrRQM6n9USYmaE9+TZC7LLNU4VuxmdGDjCkjh1FUCrCo5/l1QeIZap4pw0gQ7Pr0+qcI2Ti2LWNJivLuL7gZKsONX+VHIGcrps+ZzIThE4aCrM5+joIhS2qRzi0+GGS69BawUdzwvqHsE8uGNyUCzIgWFWRZRHFiQa4nIwE7gQMpd6Ps7Z9TlUycyz4q2bCxNTiHRt1Ut5V1z78UQ2VPMme8nB30IvZWl/wP67sfcznCDkxfl5zQnSmdaf/7b6OSf4oQt8/NXL+oxUgTlau+c8WutK0FnGOR6HnivxS4oriOcQHAqMcMh/oKSiVDtGcO9HbUbmVPQN+CkHIhy8BYFuGxK9FoNH1MNanfAabEcZIawl6rIp5tjI+HiYgTyTOalpzxZ1yLB8G8iDFeNT8fwqDHVdf0S1Y7Bga6mcrAwQ8V3tKx1Fbp3FCZWYoTg7Cjyx1J/K7wf9Udxm9ZnXEY1sDsPpS+CXFRd2jBMy9SX4imwcwJse3ch3gKl+BxAcNtrQNs7n5CBUnOrvj+oia7BjdRk3zM3eS51RI38eOx26jtgWwHrj9gQP+CeInGQHnnMYWqTS/MTEqiw0A4UplMa1GqWMvqXyXyP6F+Jq0PyFaY4oBMmORUR7oRqo5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(6512007)(6506007)(86362001)(6666004)(66946007)(36756003)(508600001)(31686004)(2616005)(5660300002)(66476007)(66556008)(8936002)(186003)(2906002)(8676002)(6486002)(38100700002)(83380400001)(316002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjUrbmxRdmJ2UEJOeEJWTkNkWlJlY2RVcVU4YmdvR1ZEMXpWTC84djN5ZzFx?=
 =?utf-8?B?MUp0aDBzQmxvS2JzKzJRcWh5WEd4VWNadU1BdVl1TEpvWGlQTjdYdGFKZlhi?=
 =?utf-8?B?VWhpY1FRaHBNeWVDejVpanZlZzJNSTVpUFJOTnhSb3NWN3JIOGVHci9nVnJ3?=
 =?utf-8?B?dVpUK09haWpENGxGK2JZdzZ6S1R6MjAzcTAzeUxFbFJrd1hyd3QvWDFvSmk3?=
 =?utf-8?B?QWFVRmkrekFXb1BaZENxRUZUY3A4ckFNamlhMUp2dW5WY0E5MUt6NG9qZ09R?=
 =?utf-8?B?bjM0SThiblBwMWtZeFBiRlgvcUhwWndaYlY5d3hWSXRMOXoxSFhZVWVUWW1y?=
 =?utf-8?B?bmFhODlTZUp2QkFXTlJEV0UrcTcxK044czZWUGtOOGkxR0owYjJwQ0piWjdo?=
 =?utf-8?B?bTBERkN6ajJUbzFUZ1lXUE5wczlhSVdON3FCL05uMVMvQXlqdjF5VS8wZFJk?=
 =?utf-8?B?VHNObmNmeFZyNGJvbEhDYTJmOVpBRTJPTENQcVYxYkZUNDgzVHFMeWp3SUtG?=
 =?utf-8?B?cU9Od2lIR3NSZzZla1NJYlpkMGVlWFlOaVpTUm84N2ZXSTRUb2hUSUpNWnBR?=
 =?utf-8?B?cWFlYkJzL2ZVQ29sbFBqRU8xUWFwMld0OFlnR0EzbVVsL2hqc2UrZkFiUXZR?=
 =?utf-8?B?YStYZnhNUmZDSTd4YjF6NE1JUEFJR3RaazJ2MFhqR0g4elJmSk9TRGhZcDJo?=
 =?utf-8?B?WnJVNjVubXBWZlB0T081c2NIWDZFUml0dUxhVGp0NDVUODlaSFZyd3RoN0Nv?=
 =?utf-8?B?NDlLMTJPQnpuczZQS21YU2lVQXZYZm4yRVcvTFYxQzk3UDBtTnl3dTMxcVhG?=
 =?utf-8?B?ZjFwZFROL3JPMVJ0UUUyeGJxV01RdlI3bE1pOGNNVTRPaDRJNmNpZVo2VU5X?=
 =?utf-8?B?ajcwV3lpeGZSYlRHN2xDOUpmcWZ6cCszWWdFN3dyZHgwWWp3Rkdrc0Z0QWpW?=
 =?utf-8?B?QmM0ZGZlOGlMVWJXWStkYS9EYi9xZDIyTVZpS2VMdER5NkNIeXhJcnd1QVpF?=
 =?utf-8?B?Z1ZHek0zZFo0cU5tei90MmxnQ1FqNmppckVXMC9vTnpGYTUyREhnRmxBNVFS?=
 =?utf-8?B?MHk3ZnljRHBDdDFPUlZSU25QdGlVYk9ZUEk5UnE0bnR4ZldLUDFhdFU2a3lm?=
 =?utf-8?B?RlNKa2dLemhKZWZsVXlJRXNZdnRkaDlvd3l6MmNxc2N6VHR2RFpGTVAzOGNB?=
 =?utf-8?B?V0hyOHRIQmRXc0ZKZ3VqME0rOEYyWHlUSlRkY3pha0FzYndYSGJtek84MDVV?=
 =?utf-8?B?STN0Y1llWDJobDZ1WStra2N2N2VVbkhTWGtNd1h1N1gwZmd3MjV6MUJBRFNU?=
 =?utf-8?B?dTlUVEF4b0N6bVZ0Unl4eWNBZitrMGdRV0xZZGs3VG5iZVZvVkpkUW9MMm93?=
 =?utf-8?B?YU1qaDRkdlo0bHhPTCtnclllY2Iyd0NSN0FMWWtrVHk3cmlBM3lodk9TNUxy?=
 =?utf-8?B?VkRyRGUxc3FwRnN0ZHRhT1ZCMzVKbmZuTTEvdTZTeE9JSTZabk9SYk9scWRE?=
 =?utf-8?B?MGNoOTlDZ1RydDhzZGNNTzZmbVBrNGRjbEQ3RTFTMHNYL0NYZy9Sc2lxdVhv?=
 =?utf-8?B?SGs1TXhjRXNNR3EyanMwazFheW1remhaMWk2MGlYU2QrazBpNnFpQWVvWTVP?=
 =?utf-8?B?SVo1RjhIbTZxYXJ5MXdsOXd0TXh6L2k1LzRPOGt5NktJVU1IVTNCTUJqanhT?=
 =?utf-8?B?bEV0VlFnRzFtVkk3eXp1Ky8yYzBQVDNLRXhHMG5YdEpDeGNYT1Q1bHhuQ3hv?=
 =?utf-8?B?TjUrNTJKM1cvYjhTWE93OE94OG4vWUdnQ2lzRlJUblk3NENBS0pvRzNIY3Uv?=
 =?utf-8?B?REN4cUVDOUNjSFZ0TXEvN1lybndocFdubUY4RHBsK3dibFljRTZrdFJjVmpJ?=
 =?utf-8?B?bUI1bFloL2tvenp4ZHJlaUhjRHMxY0N5UEhYODdNdzlyRDk2d1NvdzB5c3dt?=
 =?utf-8?B?WVhYWlQvWndDNWtQS05OQjMybTdKYW5zZEpGMlZuV3JlT0Zzc2d0RTdFbzZp?=
 =?utf-8?B?czJJVUExMkdWVDl2TXVGMGllYlpadnN6MldSVXBrZnJEUklxbmxUZTBZSzVD?=
 =?utf-8?B?S0NRUUpFVkZYcy95dHZqMzVhQy9HVzNhV3lWOFNUeDhhc1RCdFoyL0ZuMG5V?=
 =?utf-8?B?cU1FeTdSdlI0REpJYTNjRkw2YnlyMEc0KzVMbllKZ3RSVXNaKzJrdFR2NjRY?=
 =?utf-8?Q?5MPdhBlWyqwVK94H739G2wg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00f9ba8-9a7d-4e79-88e2-08d9e09c51ad
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 07:20:24.1670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOyKC5kCjsHJm67739a2XVelgEW5VmaNVT7psc2rmk/7WbXoCaZiHeXG/X0Y9+5y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: Vilas.Sridharan@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.01.22 um 16:58 schrieb Felix Kuehling:
> On GPUs with RAS, poison can propagate between processes if VRAM is not
> cleared when it is freed or allocated. The reason is, that not all write
> accesses clear RAS poison. 32-byte writes by the SDMA engine do clear RAS
> poison. Clearing memory in the background when it is freed should avoid
> major performance impact. KFD has been doing this already for a long time.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

That looks even better than what I had in mind. Reviewed-by: Christian 
König <christian.koenig@amd.com>.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ff9dc377a3a0..36bb41b027ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -575,6 +575,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	if (!amdgpu_bo_support_uswc(bo->flags))
>   		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   
> +	if (adev->ras_enabled)
> +		bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> +
>   	bo->tbo.bdev = &adev->mman.bdev;
>   	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
>   			  AMDGPU_GEM_DOMAIN_GDS))

