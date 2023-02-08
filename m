Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCFFC05027
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 17:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5581D10E085;
	Wed,  8 Feb 2023 17:00:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03BB510E085
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 17:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhQJCAf97edQAJQvywZc9Mxqk3dSxqus6vRBh/qctDaBz0I7aM2X1W4Mfw6DRbbhwCJnXWnYTG9AqiKqlBgNxkhMZ1DMHUUPDiFqcQtVeLLG22Fa1NtnFjVEQorpZXDRD8ozLd8rDJnyAf1Nuoc1d/KFnHrvuzDMtzXfaNA+BTBsyBLVVGo0oPTdXu9toPi8vI6LfCvX3TJCivlcVuSZ95Xa5X0nrORSZY2qxXaazuacQRdl978ae49xleHiBcvoMgUoPPLxBpvzBbFvlt0MyCqjGSBY8kdrRDCevA68X5JllOSGUrCaQeF+h323NJV/tNqdxxb6y4NtPe0hUAqu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irVtJJ7irFsBjCIZSZOsu2/Tx5lJZhK/Fq6OVa9kI1w=;
 b=XK/U0s04/11e1j0PzV06IH95zl5rlCF9T3zXiYC60sdQwJV5s6QKbeutuKRrBmpCoOvZiGMJZe2gujRrrZz7nGFM3Qp6MbGMeTzTqT5ybVMMqt53exZQyMpK6pVO9sThZFK7KbcT/aB1Wy+whobRpiZOHzRnjJtwJXO7MU5MK/ck7K4fD/J/KI9SLuuoPPGmWLL0lAvOuzh0sKpbV5yZDvssUzxeX6O3Ij9rksOTSJmW9a30ruAMKV+8ioG0XJEDPnr98gkfeOo3+DBtMH92cj0VrCZA+TauuKheCADUg5s99eYfzlI5jbk+fO+nq4Ed2E0NNnoffpmkeJexmdYCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irVtJJ7irFsBjCIZSZOsu2/Tx5lJZhK/Fq6OVa9kI1w=;
 b=PGHKkKXoIecYrpiSMiVpug55nOOBgZFNGgWd8oDJQJXDn4qUYVYZCGCqbZDwWJo/6dv6TaGjNMaemU8VvlZLe0Qcabkz0P1T5xnKjEWLvsIwnGdQ1E1RFkNDXNu+qtNj9MpIjuSIRTCSA3ESDfmCH85wunjm5Q7vnGiMlmitwsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 17:00:46 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298%7]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 17:00:46 +0000
Message-ID: <8aceeedc-5044-4acc-39f3-4b6db90ab8aa@amd.com>
Date: Wed, 8 Feb 2023 12:01:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amd/display: fix dm irq error message in gpu recover
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230208072539.4150546-1-tianci.yin@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230208072539.4150546-1-tianci.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::23) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d98cbd7-02d2-4305-cd63-08db09f60577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw8XJeGIJJfHwFBIfjaXRpg8AIrs4YQsVADLJ76S5o9vjNrYD3JWaUhzUNZL9Q+czVgiYcZEfB2HVbM3SyBV01+AtjUdk66lO3VxJYFbBf+G3MyYU4GbtSPJZnTqoJpz5CMeUnSwav6cFAyNRXeF1Hk7k1v1Sc+BOdRy5YjWsjpBwBeZzeX5kX/HvMTHh0QfTYgHUK1BSq/JjzvTpH3tGrmvoBmEXUQQ0ihsxa3C8wc8K/69dgx/4zPEMXpwWzAigUegmgrok9V6jg3OSxl7EQJsnkKOBMjgLf58h/8+pNsdCv8m8m/MQ4s7G3aF9Lg6vdkjy4VNHMpqTZ52yKYF563HAxU73zf8zd6MQgkQY6sYHQGWLo1EoPylCEWSqEHDNJJ6UV8QGXJcDT+GHqzmh99cggrPpit8SwkJ6mD69isIcvCluUAmS504TxHYdbz+PxHZQfhNmQq2PEuadl4ZGV9hIyChEqdqAH/n/8IDIrySeg0IgZoI0uFbpCQZfFkzzBy/3y6r8Orevycdidzury5W2IFPM8m1tipH8jLHRDc7lcYlUiRVAuD4Z6PQSlhj3ABoBphY7NN6/hg588g3jJUcQpaa59CTh27927wwkgDUFz0wUoI7Q2GVgfiyj/J2oZoUHBKmBM2X8Cx5TWtPT803QIuKb4/vQ3yCOw2LC12sL5Ufp0P+6g22kIpKX8qZFxc7WCeHUvUzUvqA9Y5nI6XfzM76WlB90XAO9aFEHBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199018)(83380400001)(316002)(53546011)(31686004)(36756003)(54906003)(86362001)(41300700001)(2906002)(15650500001)(44832011)(6666004)(6506007)(186003)(26005)(6512007)(5660300002)(8936002)(38100700002)(4326008)(8676002)(478600001)(31696002)(2616005)(66556008)(6486002)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckhlZ0pud1A5VU5nQ2RlenJQUkV2QnNNWGxwdFU0bTMxWU5wR3dFMzh5TzFI?=
 =?utf-8?B?QVNlbTBsMElMd3pGUGU1T08rZGNwN1RFenVnSTk1SXR2b2g3cjFaTWtQcUE2?=
 =?utf-8?B?ckFJSDNyenRjWWNERHZpTGhKMWFkYTBjLzNXOVpUb1l3ZGdrSUhPZWpvQndQ?=
 =?utf-8?B?OWxOd1JESUw5MGU5alcxckZDVWNEVnlKejlQNlRnc25RSHI2aU9IRjZKbzRR?=
 =?utf-8?B?Snc1bFFNTjFjMFNmOUh2bml4M1U4MFVpci9aQUNBL2VWcjE0dnlIcGZWTlhI?=
 =?utf-8?B?NTNudlgrM09nSDJIZWdYUTV0RXB3VjFIckp1aXZtSmFqcCtqK1VqbXhGVFp4?=
 =?utf-8?B?Z1FhRnpGOXA2bVVWRExCQ21XZlMvU0xiZlRUWGpWTityb1haVjNNOW9uOWRj?=
 =?utf-8?B?ckZ1VnFVOUJqMW9BRUgrbGppdkU1L1hOQnBXcmhUdGNTMFlWaVB1SldmWXg2?=
 =?utf-8?B?eVp3R0Y5bDNmMVFES2h4T1B1OTllVmRhcU5FdTluV25Fb0JvSHYvVEEzejN1?=
 =?utf-8?B?cThHaGFLRnFkbExTU0FZa2VNOVJnaTVGdjI1aEhTdDA1T3JFVVpMSUh0QkZ0?=
 =?utf-8?B?RzlhV1NBT3Judk1WK3RubVFtMCtqSmRTU05IdXdMTElvRW1Ca21rNGsyK1Fq?=
 =?utf-8?B?MVFHTks0M2xIcE1zU205K2lOZWZlYUcySWRpOVQrWGwva0xYUXl6T292VE9n?=
 =?utf-8?B?bTNFS243alhwYmRsRmJGbk96WDBndmcxTGE0dFdCaGZvQlhwendmeXNKMzVZ?=
 =?utf-8?B?WDM5YkcxMjRLVE5lUVk2dmU1eHpkaGhGSDJ4ZGp0SHhCMmJ5YWdZd0R3SUpU?=
 =?utf-8?B?ZVJrblFESXJWUkJUTnVhcEhnNzZDZVdwYjRQY2lyQ0lBbjVLWHRQbzY2WGlM?=
 =?utf-8?B?WGJWSXlSSmFMSjVMbGxMdVRlOFdQYjI2Y1ZqeU1WQzVHdURXWjk4dzZRSjA0?=
 =?utf-8?B?MytHeEFnd1QzUW1Bc1A4RkExcTBpNXFJbnhsUHJPZXVxT2ZONENkZlY1NEN0?=
 =?utf-8?B?TUhHT2c3ZURpYzZoV1NyWmJxSUtoMjlqTE9QS3dIWTJEeVl4RXlDWVJPSjBF?=
 =?utf-8?B?bVU2aC9rTVFGQkY5cWp3bFd4dEpQMXdsUU05VVNKNmRwZld2emdJSUdvT0Vx?=
 =?utf-8?B?QVNUVUtSMGVoMzdBeUtadWlZa296anlEMWVZOGhMallGaW5hRlJFN3JtOGdY?=
 =?utf-8?B?QmdybjI1NGtKTEVtU0NpRDNwdVNyWXNxZlUvc1RnUW1Cd2FPLzE1dVUvem1Z?=
 =?utf-8?B?ckNaRXZnVXZtUlgzZ1EvTFZaQ1RiTEY0TEFwbW9JekQydTZtc1hlNENmNEVT?=
 =?utf-8?B?ZGFwZnliZmpqcy85Sk8zZVpzZ0dnVnFhNVZrK1h6M1JhbHEvdjFkK2pRNGcx?=
 =?utf-8?B?Q2o2MVZGVGdNMWkzYjBLckdZTmRTSzA4enloNVA0NVE1azQ5azJabDlxSGlR?=
 =?utf-8?B?bWJ4LzBIc1pzMVM4REpkTXczZDN4UXd3d0J0QjVrOFdHNGNMUmwzQzVJMUFj?=
 =?utf-8?B?Ty9GbzVMcFBudVJxWE1SNm05K2tzREN1M0lwV2JqYnhta1crRzVrajM3d05p?=
 =?utf-8?B?SVZzQXIxbTQwb3N4Y1FTQUFpZTVJWkNCMUNBa0ppVGlyUXRXT3Y3ZVpJM1V3?=
 =?utf-8?B?UFBZNk1vOS80aVdiZDRTOXZsanB1bEVJcnFSczloZ09HMCtoQnRhcllESUxi?=
 =?utf-8?B?VVl0dE40K1UyQ0taYXFoSkhTK3lEV1B5Y3V3cDJ4YUdKYWlRWVZQUGEweHcr?=
 =?utf-8?B?WWxhOGE4ZmxwK29CcC9OaVI0a09pbXdRbkgvV01UdlBiSWg2aDdCTlE2UUtT?=
 =?utf-8?B?WGc2SmQrdU5pNHNVWUJZYUhsMkRkZElqeWFrQk0vR2JQZkI1aUZvSUtscDdu?=
 =?utf-8?B?YWN4U1hzNm9iVytZOUJZaGpLZURlR1pLM2ZIcE81UDNTQ0JEVS9FTmZkQkla?=
 =?utf-8?B?OEZOSUxwOGVXNmZmc2VGUTZpS2ZJek9wckV5ZzJ3Qm5pRnR5NGxrYXBNZktu?=
 =?utf-8?B?MDE5dTl6LzhLdGJCbWNWQnZvU1RQcXNkdmlESVFpY29jejFoZnh5QXpMNFc1?=
 =?utf-8?B?a1ZhTTNTOUF2amxpQmFwNitlNEpiYklPbTg1MDdiMDdKT01yNGZMbng2NWNm?=
 =?utf-8?Q?LO/qMX6SDOLqTZicWcexMzAKT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d98cbd7-02d2-4305-cd63-08db09f60577
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 17:00:46.4367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyruPOhNmcLdtQMqVuHhlbIKUaYeD8pt0v77efUxpeyZTNp3yt4mJYaMmm5suzO5U9W3ItVjKVDBouMS30wdKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2/8/23 02:25, Tianci Yin wrote:
> From: tiancyin <tianci.yin@amd.com>
> 
> [Why]
> Variable adev->crtc_irq.num_types was initialized as the value of
> adev->mode_info.num_crtc at early_init stage, later at hw_init stage,
> the num_crtc changed due to the display pipe harvest on some SKUs,
> but the num_types was not updated accordingly, that cause below error
> in gpu recover.
> 
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
> 
> [How]
> Defer the initialization of num_types to eliminate the error logs.
> 
> Signed-off-by: tiancyin <tianci.yin@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b31cfda30ff9..506699c0d316 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4226,6 +4226,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   	/* Update the actual used number of crtc */
>   	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
>   
> +	amdgpu_dm_set_irq_funcs(adev);
> +
>   	link_cnt = dm->dc->caps.max_links;
>   	if (amdgpu_dm_mode_config_init(dm->adev)) {
>   		DRM_ERROR("DM: Failed to initialize mode config\n");
> @@ -4714,8 +4716,6 @@ static int dm_early_init(void *handle)
>   		break;
>   	}
>   
> -	amdgpu_dm_set_irq_funcs(adev);
> -
>   	if (adev->mode_info.funcs == NULL)
>   		adev->mode_info.funcs = &dm_display_funcs;
>   

-- 
Hamza

