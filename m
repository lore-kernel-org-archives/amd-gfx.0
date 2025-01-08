Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD10E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F4910E03F;
	Wed,  8 Jan 2025 16:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fT4R/Dju";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCD210E03F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezd6DOU5YEtT5L82pccYQmivZo1dxvPd86+bkvPWK1Hvtb2JNJH4SoPasCoDWHqEX+qHWGXfK5Eo8mt5veJQhqkpABCiI9BToo0hMWV5dRxeTEtfFb0Fq+zW2tNwzNiAdVb4KCcX7OnuUUdNQJSrS/Mbrne2wqhUBZzFbnvSt+FrxRqj6j877Y4hybAVEW6jMWaZIcy9N8Vy0aP/TjHXt8N4ORp6gLVK2JfkCv8b6mR0cbp7103xa/mQc1xOApIwMO/T1zL7cMvfNvSrr3X1C45USQNnP6qhaudozTV/QByW7P7GHX0DSX/1ovW/DlXp/FuVYCVlmr7wr6a07r1ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACE2CGFiy6qFyR3q3ZjPXd2L7Q0oPKTyEjFYq5yifRc=;
 b=SMm3EEF/1yUnZUFwyAMkIu98x89ZI/s+GNPODizaFTNw658/FvPF4H/HGQywDRLlTvJGFAS9gB8ncH2rr7nmzGzVdayXNo76hbOwI9Kq197DsoeyiwDFTOx/A026UMEd1stgQqkxKf7WYSSeNMZKYWuE4sTeSQz1iRfVtKLy++hyZlwx119zuZByyFTZlqTaqsKCm5b4APwTp1QPCcTCraCetvG+avgd3Z8yiotmlmfnzjfpQ43K1lncQDMzY1T8VSAz2fQ0bfSkGpgDn3YaDfAwRKzJtIUW37F4RwAG9Ip6GGi/39IG5vepFZwdrTWGfQuOOATRQOfSWgt4zxrmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACE2CGFiy6qFyR3q3ZjPXd2L7Q0oPKTyEjFYq5yifRc=;
 b=fT4R/Dju1lP3gX9s/hx3HuBHIq1zZm8KAk+Zb8uXP9EbrIwNAcsRn2KjLTWLaBaU4c4ThsoIr3ThuTWw0IDtMdschWh4WxcO8QPWIbJophowjpCNbHciwo6VwA2bunHiWNbi8fMMEPeBtP0TW6t2Ti4Ad81r9tXfdvdBOmvMp78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 15:56:53 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%2]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 15:56:53 +0000
Message-ID: <c9542083-7d7a-45ea-9746-cdbb605fe4af@amd.com>
Date: Wed, 8 Jan 2025 16:56:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: add stucture to populate doorbell info
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, veerabadhran.gopalakrishnan@amd.com
Cc: alexander.deucher@amd.com, leo.liu@amd.com, christian.koenig@amd.com
References: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
 <20250106164530.763188-2-saleemkhan.jamadar@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20250106164530.763188-2-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::10) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a22516-5f27-41ce-d7d7-08dd2ffd11b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ME80WWVUd0FkZkUxaW5lWFhCNmxMVFhjeGZucUc0bE81Y2dOQjZDSmgrWU5w?=
 =?utf-8?B?bi9mSUQ3RnZwLzNZRFpEYktmUy9iaGZZRkZNd2NFVVVGRXU2RkFCLzRyZlFy?=
 =?utf-8?B?d1lsMzRLYnA3SkcyMUVXWm5yWE1IN05SSTBrck5lZitxb1hYN2wyUnhjRjRM?=
 =?utf-8?B?UEFnU0JiTzhMcmFWOHZJVGFWV1c4QjJpaWMwM003QXBEc3g4TUJFcTNuYVdM?=
 =?utf-8?B?MFRRaEI1VVozT1F1blRkY0VHYjloM1lXZWpoRDdqM2ZGbHNSZnZxQkgrK29k?=
 =?utf-8?B?dkd2S0xISUtKWW1QRjhEVnNQWWh0N1lmVGZhUzg1VkxwM2h4WTFpQ3BHRnJy?=
 =?utf-8?B?TmpWZkU0Ty9SY1ZWNmxMWnpUMDR5V3dlaytEcUJNWkZrYkNyVzA5R0tKL2c0?=
 =?utf-8?B?MExvaHVBK014RXl4ZEp4czk1RDEyNHQ2Qys4WTlzQm5Jc1pnUUZ3U0JEUGNH?=
 =?utf-8?B?UTdOVkVBVUhIK0NhTzJlQnJRV2VOSkJMSWRlVmw5OVQ3cy9tbkhWRE1iSEla?=
 =?utf-8?B?a2JZSGd3NEpNWmRYcDg1NVovUlhkdkQ5OVZ4cGYyc055UllMUmQ4WE5VUE00?=
 =?utf-8?B?RzkzaFhDNTRSWmt0bjZ6clp6eVZvZzNnNm5wY2dyeitHMTJQY1VmRHRUSlFv?=
 =?utf-8?B?SmJQWVVBOFhVYnJNL1JwczZMNHJQMzBIdnAzZlNVUEpLWG00MkE5YldQajYw?=
 =?utf-8?B?d3daMEFKcmpmQ3RpczhRQTlzNTBLaVlmaE5tczRUSWxzQjhmMXhoR0JXQzFk?=
 =?utf-8?B?SUh2M0JpM0w5Mi8ySTQwWTFGb0V6eUZMVEdtaUJUaGlLWW9mcUdqMTAvSUx1?=
 =?utf-8?B?VUtLbUNra3psL1Zabis0a2l4TXVlUDc0S2FuZEFBMzNJL2QwMEVudGRnNXBj?=
 =?utf-8?B?UzN0U3BxWVhHNFkxYTlwOGlBZVBBOVJNelRzMmM1WGZpajd4WUJRVEdFNDV4?=
 =?utf-8?B?MmNobU5NQmlEYURUQjV5c2NucG5DZTdocDRYMmZhSDIxN0pLY08zTndsL2Za?=
 =?utf-8?B?TGdZLzlra0R2V3pBWlB1cUZWZXI1VWJwS1d4ZnMrQWxHUWJHNU1kRGJSeGNF?=
 =?utf-8?B?V04zNGJsbmJHOUc2QkR0Wm5wTkZHUkhOQjlUR1JVdnJJeVlQd01udGdIVFU1?=
 =?utf-8?B?eXVjQUM3WlQrRk0wbnhGY0MrUm95TVVGRjNyc24yZGhQZHd4Y0tXemRZc1pT?=
 =?utf-8?B?SDVRN1o5Q2p5b3FoTTl0ZG51VC9oZWNVNHpwUGhTYmNkVm8rYW5nVlg2T2Na?=
 =?utf-8?B?eXpYT3d5b3IwMCsrdW1jbVBFTG1zVFpvZDRta011QjVudXJoRk1LOEkvZUZo?=
 =?utf-8?B?cW1mdUd4S2kvZm1YSnZFbVRsUXp0eGdkbS8rbkt2WmtnVjdMajJBYmNROS9w?=
 =?utf-8?B?bU5KWmd6bkI5cUtCUFRuWkw1eng1WnlMdC8xaW51S0xLdCtVRS8zRUtDaThJ?=
 =?utf-8?B?b1Qya3JwZUkvY1dRR3pNcGprdjdBZUJIbFI3eWR6eWR6TkU0V2lVbzNheVpa?=
 =?utf-8?B?Tmcrb1hTQ29salErc29QdGpmTFNqcVNXQlJBcmErTVl5RU1LOWNVSVpDeS9V?=
 =?utf-8?B?eFVudkxTaWNaOGd5UmFNbTVvckk5ckFHNU1jeWZkQkZ5ck4xL3pBN1F3RkRt?=
 =?utf-8?B?TTZBNFkwSExCb3FYMk8xQVBLZW0ybzNLOHVnTndHMDV1MEFDVVQzcWNzMWZD?=
 =?utf-8?B?K042bTZ0WHY3U2lyNzRJSU1ZeWUrcHBycVBXVENLdHpWZDBSMDVwSngyUTJU?=
 =?utf-8?B?K2tGeG9aQ2x1VXBBcFpyM2g1c0xDajNXVTNqSVUyOWQ1amV6QlRYdHExSlBv?=
 =?utf-8?B?WCtTQUQwcnN4ZEdNaUhUUGFMQVpKV2FSRkxDYWhpRTAyVWZBWWtMaFFIekEz?=
 =?utf-8?Q?DdfSDD8PdCRlG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWlBOVZmVDFqazc1Yjl2akVmenVNb1QyVDRtRGNkNHY2cnhtc1h5ODBITm1h?=
 =?utf-8?B?MExRQzdpL2ovMkQwOERPSlU1d2xnbjlNSVRQMytXL0s2cWJ1a0tZWFlhM0Ji?=
 =?utf-8?B?WnFLbFpsWGN5QjR6dXU2YS9rdUN3OUhyS2lvcUtXaDZYZE45b2UrczlidGM5?=
 =?utf-8?B?c2RUcmpsQk93UmMrbkU3MlQzdElRb3ZTeWRpbkI2emEyMmJ2eGV6UnJSa1VN?=
 =?utf-8?B?aThlQ0YvNUFpMi9UTGRuZDl6ckhJQXBJR2xwUGJBb0lXelRsTis3aFhjeitl?=
 =?utf-8?B?OWtWdzNrb0Q0NHI2RnNlWldJbElYa0c1MnJMdkFRcEZTNlZ1L0lyWFR2K0lH?=
 =?utf-8?B?azdmWFJFL1FLdzV3REwrdTV6WUxBZVovRWZKaElsNng4UGtBbGRtZlZURmw5?=
 =?utf-8?B?STh4Y3ozTWpJUk1TYW5jNUxWNkNqMWdSeTBvODNSSmVaSklNYldRdDdyT0dO?=
 =?utf-8?B?ZDdpbi82ejd2TENGVmZDU2dwRzcvTFRUYWtTTVc4MUMxUG5iL3JOb2FnMzlj?=
 =?utf-8?B?d3A3Vkd0N3kyZUUwcWJGWmZnQXBmR0RINlExZkdaZHdOV1d0UzQ1ZUhFVHZw?=
 =?utf-8?B?dEFXZ1BUNndHa1pVVlBXSGk1RytPcmwrQUQydm9jTlppa1AybXo3aEN1REt5?=
 =?utf-8?B?M1JJMmNWVHdKVkkyVm5MaEtlYVhkWFQvWFFUTXRWazVWMk0wTGtueW1jczZ6?=
 =?utf-8?B?bnBJa0FJcmhYZUVrdXNtdGUzWVdFUlBINjZlZzhBSmlScm9pODlCSVhSS0Qz?=
 =?utf-8?B?amRuWmQrR2lzdnlsaDRxeHRlWXgxWEJPRTJuL1licVR0WXNnb1BMSzdaM1BS?=
 =?utf-8?B?THUrQnllZ1M1b1FOL0hZbUFzcjlKOVFWSkU1QUNPOHhRVkZ2d1ZYSGNacmx5?=
 =?utf-8?B?UVJCYlVXdWQvUmFhQlQvUjdObVZ5UW02VzFOWDI5Q2NZQVFpcW5kQjQrM01V?=
 =?utf-8?B?bXNBWTRJZ1NxM3piNHljU2JnOFAyWFkwa3A4Uk1LM3M0V1hGZUFLdXNjNjZu?=
 =?utf-8?B?WG9HNjczZzVDMFB2VkR2UjZqRDl2MFFCekRvdkdkOGs5cHdLU0N0THh1UitU?=
 =?utf-8?B?MFJ6K1FTem5lQ0h5ZDN4Ty9VeTJLTXRiSlFlZzUwVHlBYU5aOVBKejlIbzYv?=
 =?utf-8?B?Nlo4NkRtRndOYUE1eXRRV2NZbW94TGY2RUplTEhLSkdtbHlTRncrbVd6aVBN?=
 =?utf-8?B?SHFRdmpKQWJzeGRjc00zenJMRk0wRGwrTlZDTEZXQ0ZWMjdjUUNIelFaWHN4?=
 =?utf-8?B?cnBGckhDYjZpOG1MK2swemcwdWhidU9DSUYwbnhwb0pYV1E2b01ZYThidWo5?=
 =?utf-8?B?ZUxVdVZBRXFkNDhIbVM2WU1ZSk5TYVhhUVd0ditLb0RxcFpRUTc3N0RoSEdP?=
 =?utf-8?B?ZjZzR015RmRzcGFia3ZZOGx5WVhPMGs2N3FqNEI2M2dhQ2IrcVpKWDZRRXBo?=
 =?utf-8?B?N0Fnb0NHbXFtZFVBczV2cEQrYXZzTVd1cE5GTXFqUFRPRmJPZDNTU2cvdGxq?=
 =?utf-8?B?OHdReFBnTE9KVG9wR1hBT3htZUtnUWxpRlNMUGpFVC8rNlBONGR2bVlwSmR0?=
 =?utf-8?B?a0NlbXp5T0puZ1pGTWZhZlV2eFI0VG5qcG5WUGxmN1c1MXJnYklKUUZxY2gw?=
 =?utf-8?B?Y0FMejI5TE40aGVlR0llVFNDSWJBWFlIa1FmMjA1SWZpSU9Zc3V2SkMwcm5W?=
 =?utf-8?B?a2JyZmtyMHhVYm9HVTI5dktMZ1JGMzBRTmtoTS8vNmJuRVUrOVFneUFwNktS?=
 =?utf-8?B?ZTZWblhQWWZGM2U1aUNFZldOOVhxU2IrZlB4ZngwRi9SL2RYM1BDYkcvK3Fi?=
 =?utf-8?B?RmJUMUdHbWRMWnZYeDZxdUx2blFaRm02aHYzWmV2cjNVM1B2bkpSVXVuOVZH?=
 =?utf-8?B?WW1WNEZPalYwTUlNSGwyWDNpUjh1WGhSaG02N09iTCthbHdGSHZDdVI5L1lj?=
 =?utf-8?B?L2l3bk42YXFhTHBXcWFEZXU2TWlneWNmTjl3ZkJVTUpkQ3Z3VlRrTjJrMWJS?=
 =?utf-8?B?UVA0d002cG44WFJHelYxTkNoaVZ0bVM0OURLVUtySm5zY0ZTWUlBd0VTejVO?=
 =?utf-8?B?c1REVjREUDd6d2tHclVnK1NpUHVOYXhtTFRzK3EvaVBqcmVvTWRNU1pXMEYy?=
 =?utf-8?Q?QMH2q/eGOSiVXrM169u4SFmyS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a22516-5f27-41ce-d7d7-08dd2ffd11b5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 15:56:53.0226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H+FzXRtmXnZiCa8FjIyqo1RsIEdqMFBw/rZ/I2HhwesajJXiHk9YfcWvI+8PT7AeG3DiariZLPsdIAsOfti+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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

Hello Saleem,

On 06/01/2025 17:45, Saleemkhan Jamadar wrote:
> This structure basically used to the populate the doorbell
> information that is required to be mapped.
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>   drivers/gpu/drm/amd/include/amdgpu_userqueue.h | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index e7e8d79b689d..1109144ed7e0 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -78,6 +78,13 @@ struct amdgpu_userq_mgr {
>   	struct delayed_work		resume_work;
>   };
>   
> +struct amdgpu_db_info {
> +	uint64_t doorbell_handle;
> +	uint32_t queue_type;
> +	uint32_t doorbell_offset;
> +	struct amdgpu_userq_obj	*db_obj;
> +};
> +

This patch can be squashed with second patch of the series.

- Shashank

>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
