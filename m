Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BC5C27C40
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D0410E31B;
	Wed, 22 Nov 2023 22:27:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2FB10E31B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 22:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+x/6t89oLXuJM2VF9r6hRtJSv2Z/9DkKRwLhmDYCnLo09cPM6rIuX0WiraLFZOSU8WcUNdGFHjv5mTL+AW2pXcFsFVFUKcYRljUmNOK6lGFihVoni+2uJ4HT4iNc5B8rjGJlcPJc2Aa3eUCfvw2y9X/gbTu2bvsKfPb/ecl8fi1U0nxG9N5G2jwACQodqmJAuA4cMWzhG8H5fjIa5qj31FR4EOr33Pf9KfGpB2lyrYlC3pIFkpfFaiczg2WNpIY5mxY4BpjF3erSPdJQB7FNW4WI0aE8JiSVrauyi6OlFKjQ3Ird/9E2SFRUZs7Xy4vhtCOeBlEuG7+uz4nQBnVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRyzmZ+Jaqk+c0i3QB4ogyfzENvs1g/AlDFOsxd5Z2c=;
 b=YFzFsmv1NjP+ztVWjUM99z97OpRTdEP+M+CHTBOXWlx6jSPzuyzog6+B5TQeZI3EgC2FEiKMY6p2jK+G7i/GuAc9m8JhyP/VSlrP7BMz43Zh/ePsqGmAJBET6dZ/0lxEDmBfNiYWzBMoNstPkVpYcLNQeae6KWWd+piSWgtl/+tyUVZGE3zA0h6H5ESZ4E8Pm3j3JUzUEi83X8iBNdglnoXmr2ARNnMOHlg5b/EBEkad0LItVZKpt/xqbTIOukGnlYjT38Xf6JjbrYDnMeRKp+3+6tV3mh1CYqpqVdBjtYbE+PYl6NwVEHk89pXFaxY2DCnK4rs6T/IpAx1dSW2r1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRyzmZ+Jaqk+c0i3QB4ogyfzENvs1g/AlDFOsxd5Z2c=;
 b=NlvhSZOCFKo+ocQymWjh/OVAdxelday9PZPjIKxyroWJbB3W3XF3dYWeJ7uivKt+zfPFg1McTgcOMKpG33oZgRFqXFoWoWTNquYN3XXvwa5M5sCnvYJ2tetAI1QFQ8X2FRm9/g3s19z9hf7k1ZqcZRutu803gdwSINE6MXSWzbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 22:27:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 22:27:40 +0000
Message-ID: <eed89842-a946-4574-bafd-dd39bd471d79@amd.com>
Date: Wed, 22 Nov 2023 17:27:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] drm/amdkfd: enable pc sampling start
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-19-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231103131139.766920-19-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 427ccced-8c70-4481-4786-08dbebaa3d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RDvVPgWN6qLzsQ0bvny1qrtVRgAllVi4X9e8nUBwSMFXiMNRQsHRrh0e3o4zFBHMOiLFLZiXs7pirtdfeMlqY8QXtdwOCR4jqRajMXTw7AFyIWxmjjVfe4bRphY7SKnmPGPN7gJXw4tQWjXvq378Jg3X9yS5Cl+SlzeqFekprgSmY30F0sAbztkv9Q15wY4XZDAfQGAC7deLICBhCqWAk1LXrGHfx3OtHY5A5IYMRuM5gUlmNn6UGjTGz5vMCwk1/QwSxyh0mOLVZoO4mP7510n7axGQ8LdemC4/Tg6eMDSU5HeYkB7EiIGt1bDU2YNzK7tyToAvi+awCKoaW3rJaeDuxjeEpcPpQHWkLLPLVzbu70PRhWE3vXeudl0QiSg5ijRrkwpEgbo4IjiyEGWUZeuoZUHLat+w+Kvc7nHr91CguKVL6YoTTwLXcBzCoJkD/hi+hRwpml/r1DnbOCDifjqeuca7qKg4J01aVrPsUtnnhykd45q5K64w81A4etDs9A3KdXkpV9mle080MuEHWxRPJuTD+lS2zT8cbgNCkEOrG6+qYNyHdG2xCY1z3Q7ekFDL0B9ie1ZAZ5NCg7SvRPOhqTb4ASa1JjGThMx9tU65LjQ2ZxqdXh/mEImuGcaLaqA0fSoOdhD4larnFb2yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(31696002)(36756003)(38100700002)(86362001)(83380400001)(316002)(8936002)(4326008)(66946007)(66556008)(66476007)(5660300002)(41300700001)(44832011)(31686004)(2906002)(8676002)(53546011)(6506007)(36916002)(6512007)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzMzRWxmTzdLVG9TbnBKNjJSd0o5TTVxVDdGdHNZaUJ5ZERZRDAyMElMWlYw?=
 =?utf-8?B?RHliM0NGb1g2MWpBcGJ4NEw5dXhsM2VTN1RtOUFDTmU0WmE0cnZHbzhGd21q?=
 =?utf-8?B?VUhpdGJMaElqZWNGMzExN2RHR1Z5US9JUjRVaU0rNmR6bXZyN0xHd0VBMEw3?=
 =?utf-8?B?eHdqQUEwYXV4RC9rTkpsWHpDcVR2RmJMeXhMWWFTa0dUdzVyZ3lSTksxMHEz?=
 =?utf-8?B?MUpyMWVlRDBmTVc5bTN1bGh0c21zYXpkalF2eEFhQ0VpT0o5WU4ya0RWUjZP?=
 =?utf-8?B?Ni9jM3dzNVVsd09lcEhyV01qNzBaOFlaTUhaTVFZWE1TNWROWE1jRGNQM1Bk?=
 =?utf-8?B?d3paYm1ibTlRV0xFYVhzYWlnbzZDSXUrbUJhQmhsRmcwMlVsaW9URzg0N1Mz?=
 =?utf-8?B?ckhNVGlEQkR5L0Y0UWx5WTRzcmt3RkMvVVY4M0tyRTFxQmFEb1IxZ2ZwbEdU?=
 =?utf-8?B?ODFJVUtHQU4yc3dEYk9wWlFuKy9UV3N3bllNelhqSHh0OGZQMlNjcTJlWlZY?=
 =?utf-8?B?SHBnZXhHV3B3ekthT1k2RnhYMk9mYW5HT1FLMnZJZk1tMlFOQ09tNUpzSTVQ?=
 =?utf-8?B?THRXMlM2ZTMySk1EMDVub0dPallYQVgzeXBOd0VPdyt2aWY3aGNqeXZsZERx?=
 =?utf-8?B?NkFVUWxzN3R2ZE9MSEVFNTdyOXhTdk96QXl6aGJzSlJsNnl4a1BZUnpZNmJP?=
 =?utf-8?B?MkE5QnE0eGh3UVJKSVpSeVlHdUxVd3N1RVhTUTJ0cjR1YUYzd2RTSVNTNFB6?=
 =?utf-8?B?QWk5Zis0S3JUanJsMU8yTk8rUEQwUFZFR2JOSFNGbzdEL1hIdFRJUW1HWWZS?=
 =?utf-8?B?RkV3WFVGcERGdW5QSi9GeitRbk5UMXByVGJDU0pya3FycUhXSHhidXIvL1hi?=
 =?utf-8?B?WHNkaEV0VlJreCtXdG9jcVdiV09EbVY0YjYrbm9DcWxkVFhWdFFvMWpXQmlW?=
 =?utf-8?B?NU9QSFpBOUVSd212Rm8vOTZOeGNKaGVtTHAzdkZxOXBjUGJQYXlDUWZheEZx?=
 =?utf-8?B?eUNDWGh0b3I3UDgxNXY3WFVMTTBCNjBaSmJaOVJnem9UcjI3ZnVkNU1JYk5k?=
 =?utf-8?B?clNuODFzQU5FeHQzQ1FGWkRxbkkyU0ppanloY3ZyVFJ0cnRNcWJJMG1VakY4?=
 =?utf-8?B?ekNnd0E0bm9HYlZQdVp4ZGYxVEdoVlZQcFZTWTVnbm1oaHZiV052amFFVWpp?=
 =?utf-8?B?OGljd1lMOSt4NjB2QUJzWjNQQ2ZhUy9UcUxGdndFcDhjcURNL2tQRjV0QXcx?=
 =?utf-8?B?RE93NEdJUTQ4TVNJVWRRc3ozMkZ4NmFmL3hwUk1xdjk2NWRVcUJLdnJRQmNu?=
 =?utf-8?B?SXVodW9XeWIva2VTaEN6MDNwMlh3bE5uN2hWVnp0ak1YUXhlOFRCK1hqMXpB?=
 =?utf-8?B?bEZVb2NDVkN6cmtGVXNzSktMUDMwaFhZaERIUEZoUTZNT0tNSTRQalJEcGh4?=
 =?utf-8?B?TlE1NDZzblFZblpSNzhYRDdrbWZubUdoVlp0aXl5RjFuN0RsRDRhVTN5TkIx?=
 =?utf-8?B?elk0MlRoTlZuZ00zc1ZlbTM4ckVvZkVyb2VXeitUT29UWHZFeVlJQkZaRkc2?=
 =?utf-8?B?LzFPSm11ZEY5azJLZzBnaTZ4SDZsK0ZOV0p3RW5JdWxZWlVKNE5Fb1NzODB2?=
 =?utf-8?B?UkoyOThNUVd2RU54UXlIWHlvZE5FU3NKa1FlZkdVWmRNOHdxb0xoTi9nVlZO?=
 =?utf-8?B?YzVsUHk4bFVxK2g4VDRBYWpnWE5PYkNoMGpUQWMrZXBWcHBCeUVDcUxad2Nq?=
 =?utf-8?B?QVYrZkcyMGhFMzgrSE40NFhvKzBCUGJvQWd3TnF2RTJKNERFeUN1dExMekxI?=
 =?utf-8?B?NFRqakpLYjRvRExJa09pMWx4cVRod0U0dGZieWl3ZC80Y0syajMxaGRVMnhk?=
 =?utf-8?B?cUNSTk9nSW5jM1dneFFDNTR2ZjhBTjBTamswK1QvUXdTK0F5UnV0NksrRURp?=
 =?utf-8?B?V2VuMXdRemNVU2djMEJMd1ZSUElwcGxmTkEwMnI3RlQ5UysyamlGODJ1VUpT?=
 =?utf-8?B?dWpJYSs3N1dpQlpJSGdhSDlUVStlblNDTTFPN28xaGFta0JQRHZJdjFNb2Rj?=
 =?utf-8?B?Zm55TlQxM3JUZ0ZlbmwyWTJsUk5xeHh3OFRCMnlXT0VMNG9jQ3liTlFJbVB5?=
 =?utf-8?Q?rXJWgC3dzGiv3MgY+fAd+sLwc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427ccced-8c70-4481-4786-08dbebaa3d16
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:27:40.6090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8O/tEybI7fe7oeOGSA4HPC6+aGctzc0EHMAFu/J2lpXvaJ+5dIKteudmsYJwBd3oH42eY6pu994np9MZZb8uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225
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
Cc: joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-03 09:11, James Zhu wrote:
> Enable pc sampling start.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26 +++++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
>   2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index 60b29b245db5..33d003ca0093 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -83,9 +83,29 @@ static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
>   	return 0;
>   }
>   
> -static int kfd_pc_sample_start(struct kfd_process_device *pdd)
> +static int kfd_pc_sample_start(struct kfd_process_device *pdd,
> +					struct pc_sampling_entry *pcs_entry)
>   {
> -	return -EINVAL;
> +	bool pc_sampling_start = false;
> +
> +	pcs_entry->enabled = true;
> +	mutex_lock(&pdd->dev->pcs_data.mutex);
> +	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count)
> +		pc_sampling_start = true;
> +	pdd->dev->pcs_data.hosttrap_entry.base.active_count++;
> +	mutex_unlock(&pdd->dev->pcs_data.mutex);
> +
> +	while (pc_sampling_start) {
> +		if (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable)) {
> +			usleep_range(1000, 2000);

I don't understand why you need this synchronization through 
stop_enable. Why can't you do both the start and stop while holding the 
mutex? It's just setting a flag in the TMA, so it's not a time-consuming 
operation, and I don't see any potential for deadlocks.

Regards,
   Felix


> +		} else {
> +			kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
> +				pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
> +			break;
> +		}
> +	}
> +
> +	return 0;
>   }
>   
>   static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
> @@ -225,7 +245,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>   		if (pcs_entry->enabled)
>   			return -EALREADY;
>   		else
> -			return kfd_pc_sample_start(pdd);
> +			return kfd_pc_sample_start(pdd, pcs_entry);
>   
>   	case KFD_IOCTL_PCS_OP_STOP:
>   		if (!pcs_entry->enabled)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6670534f47b8..613910e0d440 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -258,6 +258,8 @@ struct kfd_dev;
>   
>   struct kfd_dev_pc_sampling_data {
>   	uint32_t use_count;         /* Num of PC sampling sessions */
> +	uint32_t active_count;      /* Num of active sessions */
> +	bool stop_enable;           /* pc sampling stop in process */
>   	struct idr pc_sampling_idr;
>   	struct kfd_pc_sample_info pc_sample_info;
>   };
