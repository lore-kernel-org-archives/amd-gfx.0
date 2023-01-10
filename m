Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03A9C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 04:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A10B10E525;
	Tue, 10 Jan 2023 04:21:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2FA10E525
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 04:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjMh3eMQc0R1Iyqn9O37Fck73HbCYFymjfEOqhQsVcMtf+K3HLr5XeQ8FJp5oMsUwIwUXMa/37huKyUoQnAYiIq2Ty7ufy7eKu3EBAyXW1Py4LRExNwF3otNYEhZBz+XjEopZa9U2sOZ0ytVbJ7AkzIjvLqyjX+GqK1zUTpHcjAyATkBCXZxEdTEVs/iYmWKIYEoYOnEq17HpWqgTF4Tk9g6Uq5d5fpTy7GWyUYB/Nx6WAX1OSifMXhM1ZQGnIewHlZTRfUDOjbG2c1Eo+IPC6fnkNP5g0Il836Bfry6P3ATt2WXFxbHmnkopZzigu+sWtkjeQSTkP9wAFSUlhaxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5FOZhpmP6r18pzvNQ+ACh+TUAncmkJzVlLWFNtmxSA=;
 b=jdgWIVaQewGPiNZHseU5j02y2rRUHqzVnZJLU2wY3mwUkkeQiMxcOb0U5HHDAXXA81n9sMwI4cWGswvvVRn9h3NiuQWdmxdPAArf7GZxzLBLA4p8lUR3+AtFjNmHgh2mLzBMCrTfInCkxfh2fjpWVXaSF410yEMNZv7/WiewDNFxxfqRCeGP+6QAVk07+lgcDouHecSlg2jXKC3KP9UXMurozYkT4/0iFJ8NdWNzho8cN61OAAaAY9weQBjwJDrk4lEeEEke+Bu8JbFmCMNTrnNPnk/R01wlF4nMLa3Fqz9sbfc2vEpP5cZ4LG9iwqX8N6H3U/BQZYwP4UgWjygqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5FOZhpmP6r18pzvNQ+ACh+TUAncmkJzVlLWFNtmxSA=;
 b=TIYW49n3gw2zMZgWBogk70mIQpgDmdbAk4hk/p76hMdJCKaL6csqSe1RbyEo6RMVMnjUnwFJEmnF7Gi9L7ZBVdGJVDYh5WXM0XtfN5Nsr03rvIM3GCSNOGKkDjMl9ySdXMbMBNmnQJHVrqLY/OmmvT81A7n403w1KSdyvE0kz8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 04:21:14 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 04:21:14 +0000
Message-ID: <9e7f56e7-1fbb-1e9e-3611-204f2eb6ae1d@amd.com>
Date: Tue, 10 Jan 2023 09:50:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm/smu13: BACO is supported when it's in BACO
 state
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com
References: <20230110033733.127420-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230110033733.127420-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 301bae0c-adfb-4434-b1e5-08daf2c21c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnIDh3GNI9e2K92rxXLGNbVnQeACVOYLKj0zUKnawAtZlP4AJpB5dl5gQRfLl6GxZKOamZ8cOanLXDKS0wUICD9VdZwUfOu7DOhgDpH0dqq0x0liC+qJt/jFo2dXSfgaqdLs5mhT6N4L+PnRRU7/BkHgLrrb1b6hcgPg2+oakc8Sfxey/azkdHpREoknyMPJxcI0EgsAwkqmBIVSkgBTQY1Se8KDWnVkDhE7qanjCIyo0mGt9BDRQMdB0K31yoGAP8Nb2tqVaQZ0Z8NFBRatYNGXLe8vgODglkmuhjcNvwRYKQKswXy6J61fCdUDwMPd8HxbaklqYn97rmSlmaJXIUGXMlLJ6zxb+E5kQel2ESJKk/1WcG30msZ873eWLZm5YH+s+DDyMdS8meED9VBDrmgMogY2m39pwDYHx6dcx5xFRNX84Dn3f3CQjAr9ZAPTC8tYJta1kFcQX5/c4tIND9JRF1OiFl4GjxRLydGcYJhAAzCLmhdydzAHHLfONX2CijPNVDRKqOBIE1B9VHn3oMT2oYhPLWStNVsP0he1Qvt1TXuw1aTJ8PQPAb1G2lSlFAW05r47nj0BCioWI8Afhi67ioaFNUmNKduzECH8NILGV/T5BBVxyFN7BLF3ddG7qiwjxlTZGbho4pRy7qvDDGGhgNVm5tWlqmLGv11Lh8n2QtKEiJvaBEViYbnLpszexdx2YLvO1lWZOTUoVso30vxYUjyD+pLNIrh/VuAeCOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(53546011)(2906002)(6506007)(6486002)(478600001)(26005)(6512007)(186003)(6666004)(31686004)(6636002)(316002)(2616005)(8676002)(66476007)(66946007)(66556008)(36756003)(41300700001)(5660300002)(38100700002)(31696002)(86362001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJhUnpZbGFXK2hPNkcvOTlIVC8xb2xPSG1Hcm94L3JmUFdHdVp1elVIOWVG?=
 =?utf-8?B?aDFOdXprZHpaT0hiTHJjTTJWQ2MwdHZhNGlaSG9CTDFOdmo2MU1kME1hWlNB?=
 =?utf-8?B?UjJBb1NsZmQzUzU3OHlDVDJpT1c0b3pURFcwV3FpN1VTNUtWT0JOcGY2MEtP?=
 =?utf-8?B?OWNNZkJYclljWVZrMWpMMllRQjltZTU0OVF2N2I5WEUvc0dWNWROZHJjaXAy?=
 =?utf-8?B?UTY0SEhjSlVYOG5ndUtvUXViTzRzRDk1ZzZJSDZMdjZsN2FnVFJ1UzJaV01C?=
 =?utf-8?B?VjA5RThyNlYrQ0YzSm9qQjI1Vi9VWTNhc25ZVTJNK2RjMjFWMUVQQTRqdy8z?=
 =?utf-8?B?TE9qR3NWUkV5dE1Pd29uMzVCa2lCMGw2NlhLelVhaHRreXFaTE1tcGFhZHZY?=
 =?utf-8?B?bko1L3VzUDIwUkowQnBTWFRsSk5OVDBSd1BvYm9JWDl3bmlmMUNpdHdPOXB6?=
 =?utf-8?B?ZURaT1Q1VzhKM1Z3K3VaWXRvZ0p0VVFkS2t0MVNwWFc1MlFtcjd3OVdKV2Rq?=
 =?utf-8?B?MEt0MW1yTldzK204SENWeXBqazJNV1ZWSnh5cGJPU2E1MnYzdUwrVDVRamhx?=
 =?utf-8?B?eFE3VjN6Q1JuSC9TSjBGNm45YjNzb1ZHK2ZTMXZ6VlZkYmwyMkIwcHNqY2NZ?=
 =?utf-8?B?Ym55Zys3eW1JaU1QUjIrdytQWkRLdWdwYUppUnFxWk5jcCtFRHl5ZUJ1Qkwz?=
 =?utf-8?B?Z1dmUG41emJpcnIxRXFlZE9zemJWUU1JK0pFcER6blNQdFFDTUt0bERjWEhE?=
 =?utf-8?B?TU1vOGZ1TmhLVGNvSk9wb1lXclMwWEIzbDBOTktDRlk5eG41Y25Zc1dXSzdz?=
 =?utf-8?B?aG1odDZsWTBhZVBVK0JHcGtqMDZQN0RyVzdFRWtwUXdXQUFWMVpCS2xlVHhR?=
 =?utf-8?B?UEZhYXZWbDBvZGw5U3JoWEVtZE1lZi9Yc0VjT1RSUUZ6Z0UwUk01UERFcTRH?=
 =?utf-8?B?aForQjhrNHJkWldtaFVObDh6T0toMkJDTHQwMzBBWVNEY1pwQTNOWVQ2Wnc0?=
 =?utf-8?B?SUQ5aWNKdHpjWWN3OVliYjJDM05PY3VnaTVmNUJ5WXZ5TXVVUlpoTmZRU29N?=
 =?utf-8?B?SU1oRmVLMWYvYzltUzRQRVNlcnJMaDVuNDlHTHNJcllrK1BQMEtWVC9KdGlk?=
 =?utf-8?B?Ny95Zmx4OThZVU90WWhXRFYwb0VtRys0M0g5SDlGZm44R3pLZGw4cXZoVFd3?=
 =?utf-8?B?MFhZcHI2aU5MeTI5SWlzV1dwQkFXVFZrbVNodzdhOU16RFhrdDZjOUZoRk9w?=
 =?utf-8?B?aS85Tlg3UURGQlgxTXBDakk2K0gyZE5UVnNPMzJtYm5IL2dmNGMrRzYyRGxH?=
 =?utf-8?B?c1h0ZWxWRGIwZ0hOR3ZpM2tWcE1XaVRmZjhpMTFaTlNDZGZMTU0zUGFZbzRO?=
 =?utf-8?B?THhzOUlvUHppMHdwQUJmdDc5UmcwUWpqaUxNRjZWbXpBSHZUeHhsaGUyOWlM?=
 =?utf-8?B?OHNJMzJkaXVtYkd3N1RMcnVDeDJzY2tBM0lCN2xSZ2tZaHpwNWo3dlowQi80?=
 =?utf-8?B?N2lKKzdhbWxmTG9uamd2V2tWUmhRZ2hDdUUxbUNZOGxKNnZJdG1pdTlrY3dN?=
 =?utf-8?B?L3hGcHNoWmxFZmN5UEhmb0R4anJvazRIdk5KNXdDOE96SG9sYnFZMDVORVRW?=
 =?utf-8?B?WERNVXg3YldwNUdBcnkvRUZjNUZGV3RhVk8zaTBDWXRnb2g1WG5kbG5FZzl1?=
 =?utf-8?B?b25nblkxTFJjcVI2Z0M2R3pBaGlDVTJiY0JvblJSN2ExVGxOY1RLcmEyd3M4?=
 =?utf-8?B?S3pVbDJQYjhqQjlYZUNJRVZIc2RmdFUvNFhXS1hPYkxnRUlJenFmaUpQa0tk?=
 =?utf-8?B?UldhZElYWW1HbkhMZkdHNHgrdlVhWC8zOGRja3RzdXNmZHVVci9Odmh1TFRv?=
 =?utf-8?B?OUFiWG13Y1hQYU0yVGZwK2pVdXMwQUV0b2tjNGdpUWkyL0lwdGlaRXNubUEw?=
 =?utf-8?B?OVZmYlVrZFlWelB4QzlsWXhQOVpnQkdHdmpQQk5Pb3dCVXFVUGVNclBMdS9W?=
 =?utf-8?B?eU9NMjdJeUNVL0dwL1hvTGx0cGoxemc0cVVnZ2RnZjJ3UndBcjZXZS9HdEli?=
 =?utf-8?B?cXFCaHlsM2FaUzV6YWlZbFZJSUxVVll3dkt1NENmQWRpYTA3VDlDc2tWVzdF?=
 =?utf-8?Q?0vWs0lL7QD2fymNtM1/ouXSVV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301bae0c-adfb-4434-b1e5-08daf2c21c29
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 04:21:14.0011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+WxQVG4GXUoJr0JPSzNpqudHHUrUPvmnf5geChXxQlvfvD5dnF8nw6eSQGosHS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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



On 1/10/2023 9:07 AM, Guchun Chen wrote:
> This leverages the logc in smu11. No need to talk to SMU to
> check BACO enablement as it's in BACO state already.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index ccaedfcf977e..78945e79dbee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2243,6 +2243,10 @@ bool smu_v13_0_baco_is_support(struct smu_context *smu)
>   	    !smu_baco->platform_support)
>   		return false;
>   
> +	/* return true if ASIC is in BACO state already */
> +	if (smu_v13_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
> +		return true;
> +
>   	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
>   	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
>   		return false;
