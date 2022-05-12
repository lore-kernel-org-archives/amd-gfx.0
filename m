Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F60C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 21:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EEE10FA61;
	Thu, 12 May 2022 21:35:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FEC610FA53
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 21:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odpjMJxTXab68sbHExMiJJcvCIujnZ/KbnwguJKAgFQsAhZE16BEMZwd8sOwCn7aJ98ftt7rW3FQgh2pIVXOWQv1P8aZ4kmLZj/5zdFQPJToN+l10wEV8x+AZ43p04EYYK+Q9JlwhdeSrh10xSvuCC/7IcNpQfOuEzEDCcDBi5pjjZREWcLK9+plr9h+bzI9673TZcKf4NSXM5dAPuKH5HaUhSO5GGBLxafuK/vsXnsZ+tvwBT4HCHTWq1BJAnCfQhgphdDxRjemL/08KLrGUN8F6rmqtCuayaoKKcTJE815+cX1qxqoFrmtD6Cpv7LPnbYhL1EYIyf5UGuioZ6BNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On6I39pIDFploEurLmDziLe9LTzIr5PuNX+/MDYMUGw=;
 b=KJeUEfevG9moJWzxBfeZQrkH+UxtHrjvQCR+beGJ6dgd+xXFXCRQKk8krVGIbTn/bAs+XkUTrDMLRSGiwk9979EmjfQscoHg+PM4ZzTJnvpXRYce9s0r5Wb85diTqFyBgbQ0QXInqYwicRi35LZFMWSAlwdz9febfdDPwgEsFEwUkpMadJIio6y4SrJUQ5BfmUiIi5DmP/zXYe5t0OiEO9S3DwNl6XrsQArbXADh4HT50sDcESo/N0T+TISqQ94x27ivGw/bKpLoDeiKWfh+2UGK5+yeINqMrkLnUEvc3imxlBiatM1mTajLUVdbcWwB3JSZzlKaHIn+kttWsLTRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On6I39pIDFploEurLmDziLe9LTzIr5PuNX+/MDYMUGw=;
 b=bOsp0EYq6lbjsxHV/4QZ/UfE+ChiAPj45MP9QqPbeeK2BYv463u+wTvX3YIgFqZt4I5KhOOF1UG7/FuH+Q+tC28WmGBiplGR+r/8vzku2io/NhU7X6b66Y7gzEYblPXDIWoc3u2Nl/DSj60kpVy9TInhmcQtV0GqNPBrRJknoRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:35:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%8]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 21:35:29 +0000
Message-ID: <f9d949d3-5de3-d383-f286-2f755883aa4e@amd.com>
Date: Thu, 12 May 2022 17:35:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdkfd: Fix static checker warning on MES queue type
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220512191632.3975470-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220512191632.3975470-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a20d1951-06c6-4dae-525d-08da345f55c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41752A51A5EACD5C43ADC04C92CB9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CZ92D/iCv9lTjoxZsbjvXxb65HIx0pfRzmTVnEQGvphZwD7JiR/00BILpvJv7kgOdz0w89OYGBj8qjhlNHNKsJSxnmw8Dk+rkXMz3wJ2VtlUxSsJlAKvNqZkp5J148jdjyIgInYpUzADInW84GyvEyc6HOKuqVqAfFge8u2Q8tkmhksGXnRXVRKOPEczSpRYdDa34abNBCN6IHpn/UFif38JTfsc6+C34vbZ6GScDjffX4WuMXPu6DD0y5ha9yWs6NwaJz4Jjn/73IC3TDt1XzuJ1fy7e/5ygsRm5wOyIKmHB1rASDa9wYvwOFbtyletYDlnfpl9ZuX//F9pEOnrc0p+pbSJtYz4ybFAlfVW4h+w17Yj/QMNidtliz6p2MrN2lL0M5NySr1xkEG3jh2g7mkQ2IJLkR8XpdwftPX4RQVeuGyPwEsfBdfwDHQK4w9Mg+APwxnIvxCyMnBbIRMCE0srJ1ydXqX5i2aPP6E7nNArNVioTVdYyObg1uHaKvX9XrD0i9QMvBchHBKAVBswHPUThGum2g/xoFaiI8KDeTGr6XWlZg+dGw1zp9IaXU6HR6M6Zp/0Atr6UYrcOwKOIJZ9CC6sCdHKhhEiD2wMY6P42sHYt6AtnSxvt45YmtaV6Izv0Tmae9KjlfhANa6JxC2w8X3dXN0RXMeLhN9VfsOBmIeXwS+jchVIxniteWZgcq6x1OFkl6BeTv4nlINX9ODgQdQ1qpU6WMWEEJn3k8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(31696002)(86362001)(8936002)(508600001)(5660300002)(186003)(6486002)(2616005)(6512007)(44832011)(26005)(38100700002)(66946007)(8676002)(66556008)(66476007)(4326008)(316002)(31686004)(2906002)(83380400001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjh2aDBId3RVdlo3cTlTNkQvSU13VzUycWJZY01XVitZZ3lxZk5RUkNRRS85?=
 =?utf-8?B?V1JOc2ZjWkRaRXZaak9teGFCdEpQYksxK09Bdk95RG1ha0ppQzY0K1Y1SW0x?=
 =?utf-8?B?enh4T3o5OEVOdmMyQzBadmtPVkRWVXVldFNheFZHNWFkcnY2VHluODBMSytC?=
 =?utf-8?B?cnV3MkN4M2F0Yk5HRFpaUDlTY1FTRTM3R0RiQkRCNjdWK292OTduMG0rNmpk?=
 =?utf-8?B?WWFaelFlbVg2Nmx2Y0cvY1JENGVKa0piQTJ1NERRQzNKSDZkZnUrVnZhNlZx?=
 =?utf-8?B?UWU0S0Q3Y2ZjSDdZS3hzWlArZVl5cTBDc3lXRW5Qb2VTc01WY3c0ZWlYYkxz?=
 =?utf-8?B?Tkh1MnVkd2l4VlhGRU1Ia2dVdU0vSmFiYURzTnZ4QjhveWxKdU4zUWxpY1hX?=
 =?utf-8?B?N1MxczYwN1V3NXRUMHRsU1lpRlhoV21EanJrK3RJRXdYSE5BbkZqajZnbGRr?=
 =?utf-8?B?dXN0aU1YdTVNQk9IMkpoR0J3Y2hENkMrUWtmUm8rYk9RaFFpWTEvWFF0R0I2?=
 =?utf-8?B?UEZFSTlwMitoTjU3SXZxNDhBZlpmRDN2RXVlMCt3OWl6bGJMejFCVWNhNDUx?=
 =?utf-8?B?Zld3blRxVFpxZ2FZQXViSFVmaDB1QWZaUkY2YkdaRTdhcjBqT3FhaGZPNHdO?=
 =?utf-8?B?dzRIMzZscFp1YTRWbWZ3OGcyVmpBZnFPbUVEaU9vNFFlb0lMczJrSUpNWlZE?=
 =?utf-8?B?Q2czSlA0c1M1c2kyeXZvSzRrV1NVRkZnM1pEN29JN1F3d0kwQm53TzE3N2RC?=
 =?utf-8?B?SmNhUUpoVWFRL2g0cjZpNDJ6NUZCZENSRmRtejgrK3lEU2Rud3lyb1VUTnhU?=
 =?utf-8?B?UWthWDdKbTR3Zisxbk9mV2tGbnpuZS9ldUEzd29GcENvaFM0Q3BpM1diNU5L?=
 =?utf-8?B?Q0dBLzhaeDJzbE5vZHJBTlVXWUtuQS90TVp5NzEvbFZ1YmtxYmt6VlFxRmUw?=
 =?utf-8?B?eWp0eWI0RGd4REtkSlJpS2diZ2trdmR5eU5lOC80RWZwZVFPUmM0eUVQMHNl?=
 =?utf-8?B?RDhEK3dvK0I3TGlqbzJCZXFpU0VNQ1FJMnJpMFNzSGw3eWc0b2JqTUdDb3JU?=
 =?utf-8?B?WnQ2aURsU05GcDlSM0Q5K21qT2U1YVdtUjB0ZVRvcGpZY0cvZC9TMGN2UjY0?=
 =?utf-8?B?SkVrSXFoV05mZ2VpNVNIaExSVi83TWhRTnZneHg0VFdmdlRuKzJreGVGZ0p6?=
 =?utf-8?B?dFd0V1B1d3NzR21NaVR1ZStvaDZkVFgwQVArOGNxVStjYkZSM3h1Yjhwd1RS?=
 =?utf-8?B?TzlXWHJDUGoxTEJkZlZRWEVGVlZieWoyUTFqeGNieTRhVWtLZDFldVVTaDVy?=
 =?utf-8?B?RmxLWXNhK3ZUM0hFcE9EWllYK3VSL25FOHRCbFdBM1lnOVJ2RllHc0s5cDBk?=
 =?utf-8?B?OUNpME8zbmVTdnI1VzZVOS9yL3NoOE4rSWhQQjI3N296T0Z4WHlQQmJtTTBZ?=
 =?utf-8?B?Q2VtajFnZ3hDZ3FTSmJjYmhFSnVvdUJWajVpckhXaHlUamo2THhCMGcwNmZN?=
 =?utf-8?B?Z3h2VU5ZWktRVlp1VW0yOS9RSWhTYVVjMzgrMVZGTGpwcFNZS2wyODZIekhV?=
 =?utf-8?B?YWxUYWJrK0hROUlneDhVSmY4SEI2UHBiZVpIOFBuL0UyVEl4KzFyNTVkaUxq?=
 =?utf-8?B?K0NETWkzbmJXV1JIdzVoY2FLRkFINmozc0xCYVFIQU9GMDNLU3ZOZ3Q1Rmxo?=
 =?utf-8?B?bWFIL0F3N0tEZWJpRFdCRE1URVJXN0FqM040ZDZDN1lLZEF4UG9URzRxSXgr?=
 =?utf-8?B?RUVha1RRV1pxeGVZMGljV1NQOTNhcmtZY2pOM3dJL1YzMXdNK0NzWmNzbVB6?=
 =?utf-8?B?VmpmalMwT1lQV1Mrbk5nR0dSbTRySkFSNXgwTkdOTnV1cC9rWVhTeFVlc05R?=
 =?utf-8?B?MDZYSVF2TGpwSGFOQWlyK0JWWXZnMnFoeWtYc0pna09Ia3VRZnQwaW5FdnhC?=
 =?utf-8?B?a05OZWlkcW4yemU2ZGtORVlST3JvaElSZ1BPUllKYkVnSjZJV3Z3NU9DcUhl?=
 =?utf-8?B?b3AwZTdhMlY4eVdHS0tqOGJjNHR6SHpabTZpUC9DSDlwWnIwOUtuQVVqakdq?=
 =?utf-8?B?UlVHRnB3bThxUFp5ZXAxMkJGbVlJZnVWZTd2VjBHcW9DODR1QWIrb2dhUHIx?=
 =?utf-8?B?K2NodUVrQ3lFTzlyV2hmRUlCTDZxd0FjeVdsQU8vQ0pTY21LcjhZN3JlTUxZ?=
 =?utf-8?B?cVJBTk1BcXVaR2pVSXZnNXJPUXZZSEFVQWJMNWFvK01MeVJ5ekU1dGh6YmhN?=
 =?utf-8?B?bEQ0dkxkTHRTeGxNYk1CVUVoSEJnZXBYdWVNV0UrVTIvUzZjc2ZHVHFSZDQ5?=
 =?utf-8?B?cXJoQzNmUFpZMkgrcDhOYVkxMFRWeU9yNG8vWU9xdDhvcVBkRGg0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20d1951-06c6-4dae-525d-08da345f55c0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:35:29.2801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bm6DPTUub2MucSxFfHw710jYCYwshuv8lesuYnhNy5o9++bTbTyzLYRhBvc7a4ZUYcrWFsl7XW1aYxCC+jZyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Mukul.Joshi@amd.com, dan.carpenter@oracle.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-05-12 um 15:16 schrieb Graham Sider:
> convert_to_mes_queue_type return can be negative, but
> queue_input.queue_type is uint32_t. Put return in integer var and cast
> to unsigned after negative check.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e9c9a3a67ab0..e1797657b04c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -176,7 +176,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct mes_add_queue_input queue_input;
> -	int r;
> +	int r, queue_type;
>   
>   	if (dqm->is_hws_hang)
>   		return -EIO;
> @@ -201,12 +201,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
>   
> -	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
> -	if (queue_input.queue_type < 0) {
> +	queue_type = convert_to_mes_queue_type(q->properties.type);
> +	if (queue_type < 0) {
>   		pr_err("Queue type not supported with MES, queue:%d\n",
>   				q->properties.type);
>   		return -EINVAL;
>   	}
> +	queue_input.queue_type = (uint32_t)queue_type;
>   
>   	if (q->gws) {
>   		queue_input.gws_base = 0;
