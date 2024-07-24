Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6FAC3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 18:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91A610E15B;
	Wed, 24 Jul 2024 18:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPQGmW/v";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A226C10E15B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 18:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCrFDADXfIshb3vXpwgjZdn6MLG//yYoIl7uhVTOXh43dHxgpFx2i2+CTufSJszXOLsw2fccu11UKeavOZwQK+NDfS8m+/inEURCV7X0sU+k9GrsIEFULn77b2JkWuNq9/1HwqFJlTEOgHMQUPApeeIigv2xL4VX4zk5UMvBDezU00TM1OSxCzw5eG98VU1yCw8Tvhx5q4mWjEbUuXdNk5osuq5tk3VOgdUmBikv/fQH+qZuSscXHWRRE7ktdPFQh2Mxfns3WMqonfCcFoZqf9GIClvLyDeliRxznjbbTLlBx4Azx0G3Ysm4LuesE9Cnoi4rkdjPx1RKIGzkZJ0IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irev75a8Je4m69+fFQBeFxddjl0Mu7I/gFV1RlBHYj0=;
 b=DM5yq8yqJIwZ38MhhBcvxuTbS5VhXPiYERCqkQdgU+zJoKMDp1SIBPRczHTKbWnbMIwZYRR5ZYsqssIqHV3r9txIaOt6irRT8HinDwMfKSpGZnX9TKhzDc/Tw8acX5rPMAkGbDgvZZLIDxhd4z+l4QrTGjE97/hHd0O/2Aj5x4av+I2Ieo2NGVJx2lwuGrQiklzlkDe1mkFlfEmgiONjc5RAUfmxPTc7gcmMYzdXthmGwibpiH7ZlgVFAEO9UeP/RisZYGCiU7F13zGp5ybbsymR7KpUW4AG8AhTPGXNm+ZaA1I5DRL44aCOZv0Fz2CV1QGtYoQsn5/OmSGPJlgZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irev75a8Je4m69+fFQBeFxddjl0Mu7I/gFV1RlBHYj0=;
 b=zPQGmW/v4J3Ud4RLPtr+hWGvRjMLSP2UvKAwBpM0n339xT6ipGyIwjn6lNdJz90tLDEaLipc6Db37DhxUqneKqVJFYPN2awlJfn6rj15QH5mpyQ94C9WbinKLRTkfntyycyIcybkiKVv1Sb6K3EhIchhZXTWW8WhmJaTUn/728s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 18:42:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 18:42:44 +0000
Message-ID: <41ca8fd8-c22c-4581-a4db-7c116466e3f7@amd.com>
Date: Wed, 24 Jul 2024 14:42:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: allow users to target recommended SDMA engines
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240724175637.1080028-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240724175637.1080028-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b3681a-5c94-433b-4442-08dcac1067ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUJIUGRGRUFYUWFkckFtZTQ5NFhjZzJxWFQ2SGNrNDNnblFsWGRnbWR2WEJS?=
 =?utf-8?B?Njh1SzNWWXlvUzY5OEdoQW1NNHJkMzBFWGNHWUpXeHlueXZXelhmN2VlOHND?=
 =?utf-8?B?aXA2T3IxS282VVFKZGhFRURqUkdiNXdyMGhXK2RQVE1JcUJyVjhuRVltQnlJ?=
 =?utf-8?B?NlZpSExWOUhadXBXdGtJd29taDM5VnhNREc5akZlNndwTi8ya1pwNng4QUJQ?=
 =?utf-8?B?SkFGMm95UFA3TDRjeTFiS0RqSHY1Z3FJc0ZBMXh6bXFBVkdFYmVrTXlKQlB3?=
 =?utf-8?B?VVo3SFNQSVVPY1U0RTNMNityYVkzMkRUbi9GU1Z5aGIwNEpxTjk3Um1qSDFE?=
 =?utf-8?B?VkM3NU54MXI3b05CRDJQSjhCMU0yQlg3RUlCTVNKNUhvQ2lHVnNPazh0bVVC?=
 =?utf-8?B?UVRVbk1abWliQnBocGZtNVlRRlpNSkNta0x1dlpkTklpOWpTaWNacndHWnI0?=
 =?utf-8?B?cXBoRWNHN3V6aFllS1JPMkhVT0craVVvT2d5N0FMR2VPNXlFeGs0b1dLUGRr?=
 =?utf-8?B?bzVkWjlhWjFuQ01yaWxXZ0h3YWpwUURQYnJwRFBDL2R0a3MxTkU5b01TeDhN?=
 =?utf-8?B?Y1NDditlNllXSDhwTUJtUlJ5M0hITjBMT1FHRnRNaGlBSDFWbFJJblIrbVhh?=
 =?utf-8?B?aTBMS0pnWFBoeDhxaWZkSHZrT2J2QWRDS2lWSk9WdXpLTDBiL1E1UmpZcjFU?=
 =?utf-8?B?TkRibVJSMjgrTU5wS2YvOE91a29KaTdEdVZ5TVB1RU12dnVVK0d1R3RIMFky?=
 =?utf-8?B?YTNHQVlhOWtiQlM2bFlxRlhRWGRqK2x3U3V1aVBmTGRLUDFSVHBZNDh1NHhX?=
 =?utf-8?B?d3lxcVQxeXoraGxyZkVWaXcyQ3Y5VW1OOTFVZW1wVUsvQnFid0h0WStCK1NO?=
 =?utf-8?B?a3FwZVc4SGY5Q2JoNVNVcEhVTnZzZjVONDU4SEZSaFBsYXM4ZWRZQ0REcHZa?=
 =?utf-8?B?bmQ2MXNJNkdNTVdhTVNETlRxMlpHbVI0UXhLNHRKT05nd2tYZGpESXVBS3Yy?=
 =?utf-8?B?ZGI4OWRObGFNWWhsWGE3cVpNN2pQN1BkNng4dk54MFcxQTFiRVA2V003b1NW?=
 =?utf-8?B?R3RBY0ZncFRNVG9kSFRHQUxqY21kS01DSmprY0x0TENVK2NqTHhpZ3hTVExV?=
 =?utf-8?B?bTQzT3ZGWEZuTDFFbDRBQjV6cFQ4TDMvQkNGVUVISmZ4ZERjZ2FVTG1BdHY4?=
 =?utf-8?B?QVJ0ZW92WXBwUGdsT01adkFyaHJxanBhUU44TnFldndLVmUxZWRwTGFPZU9B?=
 =?utf-8?B?SEx0bmNrZythR25TTUZIRXRpMjQwWmxkbnJaMDB6QVYrbGcxUEkxcmM0bkRj?=
 =?utf-8?B?S3dtZ2h4emJ0SHFIM0dpZSs1RFljVDZHS0R6bnY4VC82cC9WcjU1TU5ieUpr?=
 =?utf-8?B?UWtRZ1JGM2Z2bUVGRlVUVFNLd2FudjFaR3RRajlkY0d0NTM5VEMzNG03eS80?=
 =?utf-8?B?S0hld1pRNTNqTlRWdVhCYjV5R1RCTHM3Zmk5SmlEZFQxc3FZRnRHS05UMjlV?=
 =?utf-8?B?SUVqcVFLcHNVYjBxRkNnUVkrM1cwdnk5dW5lOWQwaWxVMTdMTGJUZWJQblRN?=
 =?utf-8?B?Wk81Mjg0bmJjdDk4c0M3TnlqSE92dFBDSTQzQVBhdDFjN1NOOGNtaytOSUZF?=
 =?utf-8?B?R04rMnNELytkNmJJbzlvaWtxK1NsR0hScGFZaitsMStBODNiQWpodzVqZFFR?=
 =?utf-8?B?d0U3dDJHQ0U0bWtmbkY4RnZzMmxJSjhIaTh6aDBrYzIzVnF5cGNRS1ZDbVFa?=
 =?utf-8?B?c1E3cnZXMWFwSUtjNkxPN2VyMnJRSVppSXlUTkhxbGlUckJVTkZ0Vm5YNVc5?=
 =?utf-8?B?b1NQc3pFZjBvM0p6WCtadz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElWUHFxY1BtNE9HbW5lZGVmYURLZ3VsWDdSVStteUhNYTRVRHVpR0VPZ0xv?=
 =?utf-8?B?RmNjU0dyaVhSNndMejJiQnFqWm5adGFnWTNjTkhXSzd6OTlTd3FMUG1mSkxI?=
 =?utf-8?B?ZWFLSFcvNVNia0g5UnF1d1duT0JibTNDYzNnWTF6MTZkdHYrMXpKV28xQkpP?=
 =?utf-8?B?dTQwLzBYd25RVUtuekJLaVd2d1FSS3AzMUJ4MnB6OFdPMmpXaVJNanp5NlZi?=
 =?utf-8?B?TDJ3TU42K2Z3ckxxeXh1anBKempMSkgrU0djbVNjM3p0MjB4MUgwZTByZzdH?=
 =?utf-8?B?RmZ5OHcvZmVsK2RZcmlUZEdqZGtIbk5PVGtRckVPODVDMHZoYTR5RHZWcmNa?=
 =?utf-8?B?Um1YSklCeWtBMnVQdk5JV3puZERSWHM1d0hDTEpqOUpINU1ScC9ZaHhPcVpK?=
 =?utf-8?B?YUVYZ092TkpnVnJLeTdLNWthS2Z0U20rVVRQSjkrK0FLdVU2NUJRQTR2OWcy?=
 =?utf-8?B?M2VSVDAyNnNRMFFselFBQkhjR1dpQ2s2bDQ5V2lnOUJFS0dneXVqbStuUE0v?=
 =?utf-8?B?MHdzNEloMWdhZWx6WTNDNG1talViRUsrbUU4aWJiUXc0Y0taZlY5NncwUDN2?=
 =?utf-8?B?ZUJzYmZWOVF3STN0bGg0NUJkYjNvalgxeThMdUdpMHQ4UjYxalRndXZuUXVE?=
 =?utf-8?B?N0FUTHRkenI0ZlRuQVdsdUF4cEtuRDhrM2dLNWJUeU9lSlFmcWsrT3Q0dmRu?=
 =?utf-8?B?RU9FUjhPSWM1Tk1ZWjI0eTlONXpSVVRrMWMraXFleXVUSWRvYVVuSVd6RlVO?=
 =?utf-8?B?YXpCUEVOU2tNcnc4RENodm9LdDJDcVFOcko3VGdxZUpCanNUNFNoRCtUR1lQ?=
 =?utf-8?B?YmN2cVcxV01qT0NoVG5wUGNwREJJdVdoSGptM2ZOM1ZSUjNia3hRcmhQcWFE?=
 =?utf-8?B?UTMzKzdDVTdqdnFjNEdQeWplcm1qbUthZUxNc1oyMUJVWmNBRHpraXJtaWs0?=
 =?utf-8?B?YWFSQzV6WnEwdFdmWFM4RzlhRURaY1crK3pHM1h2M0JqL1NPNVhaQ1JuYzY1?=
 =?utf-8?B?QmVNWnZ0Sy9heEhRSmJXZktUWEJUeEUyK3IwN2NPSjFac3pCRXN1bWxtRW5N?=
 =?utf-8?B?aUJLYWN6Rkk3Si9xRkZmVituWit4bG5Jb0k1TS9XSXZwbWl3Y1FYcGVLaU52?=
 =?utf-8?B?M1lXU0dCNDV5cFo1YTJkT2F2cTYwV1hNODFmcDBQcmJpUEN4OGIrMVRXTVVJ?=
 =?utf-8?B?bjhpMXdVdzNtSnpFSGkvbjA5RGhBNFU0RTQrYUdmQ216VVFPVWxlMmYraUdC?=
 =?utf-8?B?QiswRTFNL0JyT1RSNGp6SUZpbnBHN25OVHVZYzRWZHdWYmc2Sm95cldkN2I5?=
 =?utf-8?B?RFJkb0E1WmRRdFp6M1pkYUw0NHRSQWdsRXdaQVZEOVpYV3dyVVhSbTNOTjF4?=
 =?utf-8?B?Q1pUM3NrUEtXTmFjczN6Ykw5OCtpeHNZOTJBWmt0WC9BMy9rbm5RMGd3aWhT?=
 =?utf-8?B?RUdVTXFpb1FMcitFWG9SUzkwTVFuL2ZaQzFxZnh5djNmdytQbngxelBGZ3N1?=
 =?utf-8?B?Qmw1WUZPWUEvdmh4LzIwbWhueDFBT2tQWWJCZXNJOHU2TWlqZ09oYnJXMGlw?=
 =?utf-8?B?d1ltd3l4MkxrNWw3bkVZTUNzbHYxRHRRclJQbUpJZGpUdHpWdnkzNUR0USsw?=
 =?utf-8?B?M3ozdFdmdkg0QWRFTFBHRzNsaVFzaVJSWEoxdVdrYXA4UVp2OERGb1hLSE1a?=
 =?utf-8?B?WVVKWEN3bDcxR1QvVFh3NWJHWnM0N0wyUC90MEQyVXRYcDR4UjJUWmxBV28r?=
 =?utf-8?B?YkZ2aXFCSjExT3JYOEIweXNpa3RYYlhWak9RbzArRUZiUlQ3Q0dPN0swbktk?=
 =?utf-8?B?Yi9YVWpCRGdjZzNHSEl1SWVHakNiM0ltejFHM1h1RE9KRnNseGhDOGVidUJW?=
 =?utf-8?B?YlA1dHpFRW9DYW53N3VNS2dFZS93dGQ3YTZjK3FLa1lLM2M5VWtVUGpoY3NL?=
 =?utf-8?B?MElCNUw1Zk91MTZKcTRnaVZQVWxXYjhsbmRhWmd5KzVxT3gwTGs2T1k4TWx0?=
 =?utf-8?B?bURhVmZBNi9uS0ZRM1pENWZNRFRhaFA5SWZSRzE2bC9pSmdTa3IrL0lCckM1?=
 =?utf-8?B?YlFCNG5Mb3dsaDNRaHpScURrT3BxMXBqdExjS284NUo3amI4MnBLMnRZUVZp?=
 =?utf-8?Q?/HDmrDsndKPuaPfdgnNNsa6uW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b3681a-5c94-433b-4442-08dcac1067ef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:42:44.4770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXb2pS9Ldq8cCkAva5+zjQ0YZn0aeEgTXU5JV9NUUOUZa7KKjpcarrZb+1e9wDKv8c8ZMhch08MbCD9cKrPnDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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


On 2024-07-24 13:56, Jonathan Kim wrote:
> Certain GPUs have better copy performance over xGMI on specific
> SDMA engines depending on the source and destination GPU.
> Allow users to create SDMA queues on these recommended engines.
> Close to 2x overall performance has been observed with this
> optimization.
>
> v2: remove unnecessary crat updates and refactor sdma resource
> bit setting logic.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 16 ++++++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 38 +++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +-
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 52 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |  1 +
>   include/uapi/linux/kfd_ioctl.h                |  6 ++-
>   7 files changed, 116 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 32e5db509560..9610cb90a47e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -255,6 +255,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   			args->ctx_save_restore_address;
>   	q_properties->ctx_save_restore_area_size = args->ctx_save_restore_size;
>   	q_properties->ctl_stack_size = args->ctl_stack_size;
> +	q_properties->sdma_engine_id = args->sdma_engine_id;
>   	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE ||
>   		args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
>   		q_properties->type = KFD_QUEUE_TYPE_COMPUTE;
> @@ -262,6 +263,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   		q_properties->type = KFD_QUEUE_TYPE_SDMA;
>   	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_XGMI)
>   		q_properties->type = KFD_QUEUE_TYPE_SDMA_XGMI;
> +	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID)
> +		q_properties->type = KFD_QUEUE_TYPE_SDMA_BY_ENG_ID;
>   	else
>   		return -ENOTSUPP;
>   
> @@ -334,6 +337,18 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> +	if (q_properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
> +		int max_sdma_eng_id = kfd_get_num_sdma_engines(dev) +
> +				      kfd_get_num_xgmi_sdma_engines(dev) - 1;
> +
> +		if (q_properties.sdma_engine_id > max_sdma_eng_id) {
> +			err = -EINVAL;
> +			pr_err("sdma_engine_id %i exceeds maximum id of %i\n",
> +			       q_properties.sdma_engine_id, max_sdma_eng_id);
> +			goto err_sdma_engine_id;
> +		}
> +	}
> +
>   	if (!pdd->qpd.proc_doorbells) {
>   		err = kfd_alloc_process_doorbells(dev->kfd, pdd);
>   		if (err) {
> @@ -425,6 +440,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	if (wptr_bo)
>   		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>   err_wptr_map_gart:
> +err_sdma_engine_id:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4f48507418d2..69315885519d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1534,6 +1534,41 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   			q->sdma_id % kfd_get_num_xgmi_sdma_engines(dqm->dev);
>   		q->properties.sdma_queue_id = q->sdma_id /
>   			kfd_get_num_xgmi_sdma_engines(dqm->dev);
> +	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
> +		int i, num_queues, num_engines, eng_offset = 0, start_engine;
> +		bool free_bit_found = false, is_xgmi = false;
> +
> +		if (q->properties.sdma_engine_id < kfd_get_num_sdma_engines(dqm->dev)) {
> +			num_queues = get_num_sdma_queues(dqm);
> +			num_engines = kfd_get_num_sdma_engines(dqm->dev);
> +			q->properties.type = KFD_QUEUE_TYPE_SDMA;
> +		} else {
> +			num_queues = get_num_xgmi_sdma_queues(dqm);
> +			num_engines = kfd_get_num_xgmi_sdma_engines(dqm->dev);
> +			eng_offset = kfd_get_num_sdma_engines(dqm->dev);
> +			q->properties.type = KFD_QUEUE_TYPE_SDMA_XGMI;
> +			is_xgmi = true;
> +		}
> +
> +		/* Scan available bit based on target engine ID. */
> +		start_engine = q->properties.sdma_engine_id - eng_offset;
> +		for (i = start_engine; i < num_queues; i += num_engines) {
> +
> +			if (!test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap))
> +				continue;
> +
> +			clear_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap);
> +			q->sdma_id = i;
> +			q->properties.sdma_queue_id = q->sdma_id / num_engines;
> +			free_bit_found = true;
> +			break;
> +		}
> +
> +		if (!free_bit_found) {
> +			dev_err(dev, "No more SDMA queue to allocate for target ID %i\n",
> +				q->properties.sdma_engine_id);
> +			return -ENOMEM;
> +		}
>   	}
>   
>   	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
> @@ -1786,7 +1821,8 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   	}
>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
> -		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> +		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI ||
> +		q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
>   		dqm_lock(dqm);
>   		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
>   		dqm_unlock(dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2b3ec92981e8..7d26e71dfd04 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -414,13 +414,16 @@ enum kfd_unmap_queues_filter {
>    * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
>    *
>    * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
> + *
> + * @KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:  SDMA user mode queue with target SDMA engine ID.
>    */
>   enum kfd_queue_type  {
>   	KFD_QUEUE_TYPE_COMPUTE,
>   	KFD_QUEUE_TYPE_SDMA,
>   	KFD_QUEUE_TYPE_HIQ,
>   	KFD_QUEUE_TYPE_DIQ,
> -	KFD_QUEUE_TYPE_SDMA_XGMI
> +	KFD_QUEUE_TYPE_SDMA_XGMI,
> +	KFD_QUEUE_TYPE_SDMA_BY_ENG_ID
>   };
>   
>   enum kfd_queue_format {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 21f5a1fb3bf8..8adf20760e67 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -345,6 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   	switch (type) {
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
> +	case KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:
>   		/* SDMA queues are always allocated statically no matter
>   		 * which scheduler mode is used. We also do not need to
>   		 * check whether a SDMA queue can be allocated here, because
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 6f89b06f89d3..f6effaabd4b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -292,6 +292,8 @@ static ssize_t iolink_show(struct kobject *kobj, struct attribute *attr,
>   			      iolink->max_bandwidth);
>   	sysfs_show_32bit_prop(buffer, offs, "recommended_transfer_size",
>   			      iolink->rec_transfer_size);
> +	sysfs_show_32bit_prop(buffer, offs, "recommended_sdma_engine_id_mask",
> +			      iolink->rec_sdma_eng_id_mask);
>   	sysfs_show_32bit_prop(buffer, offs, "flags", iolink->flags);
>   
>   	return offs;
> @@ -1265,6 +1267,55 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
>   	}
>   }
>   
> +#define REC_SDMA_NUM_GPU	8
> +static const int rec_sdma_eng_map[REC_SDMA_NUM_GPU][REC_SDMA_NUM_GPU] = {
> +							{ -1, 14, 12, 2, 4, 8, 10, 6 },
> +							{ 14, -1, 2, 10, 8, 4, 6, 12 },
> +							{ 10, 2, -1, 12, 14, 6, 4, 8 },
> +							{ 2, 12, 10, -1, 6, 14, 8, 4 },
> +							{ 4, 8, 14, 6, -1, 10, 12, 2 },
> +							{ 8, 4, 6, 14, 12, -1, 2, 10 },
> +							{ 10, 6, 4, 8, 12, 2, -1, 14 },
> +							{ 6, 12, 8, 4, 2, 10, 14, -1 }};
> +
> +static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
> +					     struct kfd_iolink_properties *outbound_link,
> +					     struct kfd_iolink_properties *inbound_link)
> +{
> +	struct kfd_node *gpu = outbound_link->gpu;
> +	struct amdgpu_device *adev = gpu->adev;
> +	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
> +	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
> +		adev->aid_mask && num_xgmi_nodes &&
> +		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_NONE) ==
> +		      AMDGPU_SPX_PARTITION_MODE) &&
> +		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
> +
> +	if (support_rec_eng) {
> +		int src_socket_id = adev->gmc.xgmi.physical_node_id;
> +		int dst_socket_id = to_dev->gpu->adev->gmc.xgmi.physical_node_id;
> +
> +		outbound_link->rec_sdma_eng_id_mask =
> +			1 << rec_sdma_eng_map[src_socket_id][dst_socket_id];
> +		inbound_link->rec_sdma_eng_id_mask =
> +			1 << rec_sdma_eng_map[dst_socket_id][src_socket_id];
> +	} else {
> +		int num_sdma_eng = kfd_get_num_sdma_engines(gpu);
> +		int i, eng_offset = 0;
> +
> +		if (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
> +		    kfd_get_num_xgmi_sdma_engines(gpu) && to_dev->gpu) {
> +			eng_offset = num_sdma_eng;
> +			num_sdma_eng = kfd_get_num_xgmi_sdma_engines(gpu);
> +		}
> +
> +		for (i = 0; i < num_sdma_eng; i++) {
> +			outbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
> +			inbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
> +		}
> +	}
> +}
> +
>   static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   {
>   	struct kfd_iolink_properties *link, *inbound_link;
> @@ -1303,6 +1354,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
>   			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
>   			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
> +			kfd_set_recommended_sdma_engines(peer_dev, link, inbound_link);
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 2d1c9d771bef..43ba67890f2c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -121,6 +121,7 @@ struct kfd_iolink_properties {
>   	uint32_t		min_bandwidth;
>   	uint32_t		max_bandwidth;
>   	uint32_t		rec_transfer_size;
> +	uint32_t		rec_sdma_eng_id_mask;
>   	uint32_t		flags;
>   	struct kfd_node		*gpu;
>   	struct kobject		*kobj;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 285a36601dc9..71a7ce5f2d4c 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -42,9 +42,10 @@
>    * - 1.14 - Update kfd_event_data
>    * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
>    * - 1.16 - Add contiguous VRAM allocation flag
> + * - 1.17 - Add SDMA queue creation with target SDMA engine ID
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 16
> +#define KFD_IOCTL_MINOR_VERSION 17
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
> @@ -56,6 +57,7 @@ struct kfd_ioctl_get_version_args {
>   #define KFD_IOC_QUEUE_TYPE_SDMA			0x1
>   #define KFD_IOC_QUEUE_TYPE_COMPUTE_AQL		0x2
>   #define KFD_IOC_QUEUE_TYPE_SDMA_XGMI		0x3
> +#define KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID	0x4
>   
>   #define KFD_MAX_QUEUE_PERCENTAGE	100
>   #define KFD_MAX_QUEUE_PRIORITY		15
> @@ -78,6 +80,8 @@ struct kfd_ioctl_create_queue_args {
>   	__u64 ctx_save_restore_address; /* to KFD */
>   	__u32 ctx_save_restore_size;	/* to KFD */
>   	__u32 ctl_stack_size;		/* to KFD */
> +	__u32 sdma_engine_id;		/* to KFD */
> +	__u32 pad;
>   };
>   
>   struct kfd_ioctl_destroy_queue_args {
