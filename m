Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCAECCA490
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 01:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5ACF10E164;
	Sat, 17 Oct 2026 01:47:45 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A013010E164
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 01:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGcLk0ZCX808FC8biE5+OzOK1Nhy6//zJoymymnSY/VoniLtu9cjrNgDPHyfXhWrkPHjdYXWxXr77mfYjFiusEVY65DA/OXW+mqOJIBuZ/FhD0682jsDhn629AHyLga8LxuR0zjwjMNJjzcSo+vX4FF83WhG0aq0gvKp56BtijprNiEVTP2bSi/oLK3YmeKeceCz7FmD1vOO8SUTovj4I5FMD2MmFWl2gXsmkIYle5Iwh6jWk3BZcnhhL6lIS2sx2cFCJDDHS+sTNJRj6t6jOtpCIYH73gyHZ2qwaBkDpikofINB47fqeevk7bDgjdl9lmg5mmhl4QAE4LGb79q0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMjXr+iY/r+tZgtH4tzUy7wF4AqoLcy8s70g6xaU07U=;
 b=D8MoqJAx9JpK3yoiRsaRmOdVCczcB5Q2RjIAvUKMx71jKqzBY276WS+dbDBJCU1k9LJRrdmO0w6FMUIHj6T+qsLpZNWeo2QHRClfqPwZZH9a+1cViHw/OTDt7Kft5EcrQMmEsHp5CggamUZODZzilYcbmwGDMCw9nyUPO8K5XBLkAzUzjOB4xFsDRTY0vMbQBieebotaPUsLNN3VsPVn/uJIs72VguYa7ubiBJFVNmtMHolWsJfO4NAiTFxiVOZSWbM/RlKJXZuyj0AC27+NfZyF43LC+0gZsJCmiA/qybRiNTuwn2XPLHrO5hK4XOkpfKgTcrhAYbufkA33LCj76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMjXr+iY/r+tZgtH4tzUy7wF4AqoLcy8s70g6xaU07U=;
 b=Hz2oWqfzW1rCg8+ISsjXyEo1sm8TsliWN1Vm0OvOAYxX7LF5IIGs92zM0zrv99aaQXoieblBK5vgxpm21nkxYVZsf7F1GYIXpE1slKyqNj6OIwNcCwaEBjjhWGhgtMDtwjHoA2ul65Dvhp/kEzW8/+CsoM9ugPL4DyVN1KBzsBE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by DS0PR12MB999265.namprd12.prod.outlook.com
 (2603:10b6:8:432::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Sat, 17 Oct
 2026 01:47:36 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 01:47:35 +0000
Message-ID: <2936d195-0313-4995-bde3-752433e91413@amd.com>
Date: Fri, 16 Oct 2026 21:47:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: enable SDMA indirect buffers
To: amd-gfx@lists.freedesktop.org
References: <20261016195748.418177-1-Yongqiang.Sun@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20261016195748.418177-1-Yongqiang.Sun@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0255.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::8) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|DS0PR12MB999265:EE_
X-MS-Office365-Filtering-Correlation-Id: f066092a-91ab-4362-25da-08df2bf09e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: nDxkkQq+J92WnHSKG4cfTdifGa+wJH5owquVo5kPsmeC+Yg8DFs3tOBUK6Skt3o0uit9hLtPDRI5Ug9HmEklzG0Tu/XVWgaKxqALGMImjrZAoeuQKTkX6RqiKix3k6YCOksnpqDXEJfme78CTmkvAshP3nO3K5haDXhWTVJxVw8ywbsOvtcG0/mpNxPXWYYSz6XEY5Tzrdp3yhDRs9oM9yB8ig6TNDAXw9HrnGQPNIeN06JmeqDxaY7E0gI5aG6XGhsxyzP5Ontabq5UwsST1fRtIrGgarp74P4qLiJRetqSD2huNWVFdZjpGyAtDJeYoFvRpXuhz9UgDgzn8TPiJ+VBuoXKYI7JwrzN2BmMlEwielgpsacljBSE9j1V9eJIHG2TRy1rJVLMRoIKADwBhVtPC0j/PVfWwLOPpcfd25t5LaENeJ1LueUfbBfI+ooswbYdN4to4nG4b50bKpcg1kyGlp30gBjsr3+l3kAu3+UCMGCigLDtIlDU8yW/LdyXuAtVtanANGsNn6xZvGjhXjNQKoZDKP46QfNZPZr11qTVQmcZ5BgwEucGxsgoAVp+7SYWtnvclhQzW9X6MgQrA9WGHDODUvOK+owl+iB0U5+vjkyeK4/h1+DAAsThixhzqPvj6unBAqHdvgGEavDaSSOxRDhF7tmiuqh035l787w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5kNGdxY2VXSjY5cVZ4SkNKOWFxd3R1VkJHVUJCV0tnV3NLWkdSSyt2QzdT?=
 =?utf-8?B?M1FLNmtQL09KaWF4UkYwSHpYcEdZdUt2bG4yNXlqQkt4c1czbkNieVFjcXQ1?=
 =?utf-8?B?THZDTmpzY3A0a3VWSXBtMEQ4SG5rM0RDYzMyTnFIWmtsaWo4WGU2MlN6Y0lY?=
 =?utf-8?B?YWxabWxTN21MMlB3N2J0dGhzb1hoa2x6V0lva0Q3M0FaS3NTaFg3NllJNTBp?=
 =?utf-8?B?c1VSQVVPdlFwSFRuajZLakNEdTA2cERvcUdJYUJzaFVaU2NON1Nab2t3ZXdF?=
 =?utf-8?B?ZmxFMFFZcFM4MWQxdTc4ZnVvZitFNjNQQkl3anFQaVk4bWtKS3ZTNEpqYTU3?=
 =?utf-8?B?RjluTDFFS3BzaGw2TjRjblFvSWVDUDJYRThUemF2OXhCQ25CK0hudVdtRmxi?=
 =?utf-8?B?ZWhjRmJhY2dzc2U0cC8zclF3d1FJTXQ1aHNiS0RUejNjc3FDZ09KcG1IVTJp?=
 =?utf-8?B?MnFhQmRoRDBGV1dzNCtWS0pHdW1ld2V0VzF1bWtwV1VabEErb1FxcUVlYmhM?=
 =?utf-8?B?RmRvQVExZTZ6RVQvQ0RMT2FpZEJMdVJuSk9oRWRTWlMvdjN4aEtsakdTWFJG?=
 =?utf-8?B?QVE4Tkl1d2RZRFgxTENWYXo1UHlNelZRb1JPL0gxZFdOWkZub3RETUx5Zm5D?=
 =?utf-8?B?Y01HUS90Y3VtS2l5K3prTFNrMUo5N05SVHdDTTNJV1RrZlhpbUhTMnlteEhN?=
 =?utf-8?B?TkFOR0RQVkd4QmpxWTF5TzdVZnhVZmVremtOR1d2Qng4M0pzWHNZUnRhRVFQ?=
 =?utf-8?B?SkVsTWRCN0doc2ZlSTZKaTg1M294ck9nTVBhczRwcjFaMnBHWDRxU1pUSUI2?=
 =?utf-8?B?U0dTNk9hOUdZZk5lRGtSREdwK1V3YjNQWncvNS9ZdGNRbzVOcjc4NkhVOUsv?=
 =?utf-8?B?VHQyWUorQ1RRRTJSWHREdnhVY3pyVFBVbVlDdFVUdGJXNWQzbVJuWE5YVjhY?=
 =?utf-8?B?YUpUTnRWL3ZxZm9QWWZqenRJeW01OXllR21YalpSb1B3cWkrTWpIK1F0aWlh?=
 =?utf-8?B?ZHhvb3BjZXF2RHMyRStidlNCZldDR0dkVDgvcm9jNkRaWjdjb0s4U0hmU1BO?=
 =?utf-8?B?ZVdVdmlrYktlZ0NDUy9uaWsxL3NtNjBqN3NRRTIxNHN3RkZ6OG5LY0hwZXY1?=
 =?utf-8?B?M01VSGNrekE4QVg4eU1lOHc4dy9Ra3lWZG5QUnpoQUM5Zk5tUHBwNlhEMmhV?=
 =?utf-8?B?ZGZQK0lGL0NUUVM5YnhkbTFRZlNidVQwaW80UFByQ3FKTldlTUQ0TXprOFVF?=
 =?utf-8?B?THUvR1VGeUE0SkxFYzdUZDBiTXNFVXg0Ry9EeElzOE03Sm9weStpWWVlaTlw?=
 =?utf-8?B?NkZ4U0oyaGp1L0dGQjlqU3dISmUrbzkvU1Z5ZlQ4NjV5cmNhK0xWUlZ5czVK?=
 =?utf-8?B?RzVhTWgxM0NrcUtxWFFuZDdRbWZmc0F6ZXgyKzZJNjV6TGkxOE13TWljWFps?=
 =?utf-8?B?Tk9xQi9NU1grc2FIUUJwUDQ4VTJGSkJiNm5ldkRQb3hzL3J1a01ScWJVRFFN?=
 =?utf-8?B?clM0Tk9jS0N4K245b3ZwdUdxWnRLRSsxTTB1ZUNCbzJWbXJ1d2dGMExwZHRk?=
 =?utf-8?B?T096THJ3N3VaeUVrTUtveFpsWFRxYU9jcTRhTFNtZnZkQXdleTVTc1A5MUQ4?=
 =?utf-8?B?OUZzMklhM1NRRUwrcVNqTllkRzdjd21mVUpGM2N5YUE3cERDYU83TFZsQ2Y4?=
 =?utf-8?B?dDdZOWR6ZDFGL3Vac1dsWHhnY1RSYTVCN0ozQ1B4Z3NsK21ZRTdDMkdxSkZq?=
 =?utf-8?B?K0loU09FdnozTTE3WmZHYkZ4b1JTK0xBQlZWZlFCeFJUanl2b09XZS9hcTU1?=
 =?utf-8?B?d0ZmMjQvVEdoWW1mekQ3K1RncU43Y1ZVUlVZTCs2RHVBOGJFUHFLTkRyT1JG?=
 =?utf-8?B?OGljK3R2REhKb0F2c3QvS1Z4SDgwMW83WXg0ZHpidzZJMnIwY1pFQThVY0Iy?=
 =?utf-8?B?VEY4aTkvM3BKeTlBMmdyV3JnYlFzeG1OTlFMVGYvWk9qNS8zQ1h4dkFCVGFJ?=
 =?utf-8?B?SXB1V1pwRXlCVFYybllUOGQ1MWlaUTg0UW4yV2FCdzM4TU1LWjh1UHN5V2Rs?=
 =?utf-8?B?ZURnNFNJNkxyNjJ4bXpBbTNhd05oYVNzZVI5SWRLcmhUK0lIeVdhV0svSndu?=
 =?utf-8?B?anVFNktBaDR3OHNDME93RWsyL1lQcldLNGJyZElLQTBVVXM2Y2xzVk9iMnp6?=
 =?utf-8?B?eGljSXFVTGRlNmpHb3BmZzFkdGJCMUtUMzRhcURoaDJwUFhidXRhcjJVb2VN?=
 =?utf-8?B?OGZWYThzK0FpV1ROY0o2bmI0a1dMa3NReS8zN0djWnd5ck9JZ3ZPSnVQTlJG?=
 =?utf-8?B?ZmRMNUJLbXFIT3duL3AxUUlJeFpua09HOHZ3cFpHR2RXQU1zTm9nUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f066092a-91ab-4362-25da-08df2bf09e3c
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 01:47:35.8096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+BmRHRujGJjjwIU9uOYW0tjrX84oHw8RxCFWZT/+a75uY/SneK58UZCequsXVz9vLfG/KBUFtFo0dVSuPxEmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999265
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


On 10/16/2026 3:57 PM, Yongqiang Sun wrote:
> SDMA MQDs leave IB_ENABLE clear,
> causing INDIRECT packets to be ignored.
>
> Set IB_ENABLE while retaining SWITCH_INSIDE_IB.
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

Please update the patch heading to: "drm/amdkfd: Enable SDMA IB processing"

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 10 ++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 10 ++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |  7 ++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 14 +++++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  8 +++++++-
>  5 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 4f8a8a1a6186..ee7076db300a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -396,6 +396,16 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  	m->sdma_queue_id = q->sdma_queue_id;
>  	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
>  
> +	/*
> +	 * IB_ENABLE makes this user queue execute SDMA indirect-buffer
> +	 * packets. SWITCH_INSIDE_IB allows a context switch in the middle
> +	 * of a long-running command, including one fetched from an IB, so
> +	 * one queue cannot starve the engine.
> +	 * sdmax_rlcx_ib_cntl is the SDMA_RLC0_IB_CNTL register.
> +	 */
> +	 m->sdmax_rlcx_ib_cntl |= SDMA0_RLC0_IB_CNTL__IB_ENABLE_MASK |
> +	 SDMA0_RLC0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
Please check indentation here.
> +
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index bf015dc5b868..4ed00e2d7bf4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -478,6 +478,16 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  	m->sdma_queue_id = q->sdma_queue_id;
>  	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
>  
> +	/*
> +	 * IB_ENABLE makes this user queue execute SDMA indirect-buffer
> +	 * packets. SWITCH_INSIDE_IB allows a context switch in the middle
> +	 * of a long-running command, including one fetched from an IB, so
> +	 * one queue cannot starve the engine.
> +	 * sdmax_rlcx_ib_cntl is the SDMA_QUEUE0_IB_CNTL register.
> +	 */
> +	 m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
> +	 SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +
Same here, please check the indentation and make it consistent for all
ASIC versions in the patch.
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 6ea09b031caf..3f2234edb1fe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -355,9 +355,14 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  
>  	/* Allow context switch so we don't cross-process starve with a massive
>  	* command buffer of long-running SDMA commands
> +	* IB_ENABLE makes this user queue execute SDMA indirect-buffer
> +	* packets. SWITCH_INSIDE_IB allows a context switch in the middle
> +	* of a long-running command, including one fetched from an IB, so
> +	* one queue cannot starve the engine.
>  	* sdmax_rlcx_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
>  	*/
> -	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK |
> +					SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 2bbf5e63f615..e71467862436 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -457,11 +457,15 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  
>  	m->sdmax_queuen_dummy_reg1 = 1;
>  
> -	/* Allow context switch so we don't cross-process starve with a massive
> -	* command buffer of long-running SDMA commands
> -	* sdmax_queuen_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
> -	*/
> -	m->sdmax_queuen_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +	/*
> +	 * IB_ENABLE makes this user queue execute SDMA indirect-buffer
> +	 * packets. SWITCH_INSIDE_IB allows a context switch in the middle
> +	 * of a long-running command, including one fetched from an IB, so
> +	 * one queue cannot starve the engine.
> +	 * sdmax_queuen_ib_cntl is the SDMA_QUEUE0_IB_CNTL register.
> +	 */

Make the comment consistent across all versions.

Some have "Allow context switch...", some don't.

Maybe consider replacing it with less verbose message like:
/* Enable IB execution; allow context switch inside an IB so one queue
can't starve the engine. */

Regards,

Mukul

> +	m->sdmax_queuen_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
> +				 SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 6e6bc1ec0b64..c21091745869 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -571,8 +571,14 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
>  	/* Allow context switch so we don't cross-process starve with a massive
>  	 * command buffer of long-running SDMA commands
> +	 * IB_ENABLE makes this user queue execute SDMA indirect-buffer
> +	 * packets. SWITCH_INSIDE_IB allows a context switch in the middle
> +	 * of a long-running command, including one fetched from an IB, so
> +	 * one queue cannot starve the engine.
> +	 * sdmax_rlcx_ib_cntl is the SDMA_GFX_IB_CNTL register.
>  	 */
> -	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK |
> +					SDMA0_GFX_IB_CNTL__IB_ENABLE_MASK;
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
>  }
