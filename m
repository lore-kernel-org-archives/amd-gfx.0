Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D7EC83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 22:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E6410E592;
	Mon, 28 Jul 2025 22:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NnK0BNOi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA18C10E592
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 22:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP1BZyeDgkeEYrJDFmZ9gff8VMgihfnu4iQu8CXgDqAIugeLBpa6J0JijQx0XjLHqAGYNTK+kLYrOG25Jhc9QYTJhGFp65rrDrS+EF6kH25UvyEzqKXapQr8eGumhkZB+fYE9QRR0jOAXbNJTCm9y4DULaeKZtrCmb7zwq+9DkL4SEGuB5yvlQ/UzkcT9h+GbmiWZE1l6ua/XHnleXuuupY5Rj2CaocZWTwpy9FrUBfkmEipU3/zjJ2GQScO8+cg9l3h+YyuH88OtASVq/Yiy93sJJaHISqcjqmvGGHdCkcbXKLD/oiVgiQE9D79zAaXh2bBOnUjDBE+T2RgnFv6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ2ZZMag4dfIP1OGKG7n13Rd/wzF9bUNNkysmZbkY9s=;
 b=L4v4pM4UCX6fXNCagRbZvUG4hjWQoih1ihS8z/uNoVR/jmh9/aeOIboteq55+nmLYYt4pFGUobSxv+Emcojq3AEhQPwOqZJLtPJWIwpnPXHQIM1Qr+b5MPz6354jfFdf6fwKkwy+74B+i+KIFH1i7WTC0qEBbHHYQN3+10meqnIuNep9v9rVmSk/uy7HpAuGSLBtLhmw6gO3vSatthbFvn+Y4SNvjhqjJYm7jqJ0EfWCfwM6paC25J0m1TaRKO0Z6CateBOkN/o8NimM7eUqTxnWR5HGEacd8+Rui4whRW6A1Eqb9JsRSSiTpCs14+Lx7huBAt9nsHpt7QgyE2ocvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ2ZZMag4dfIP1OGKG7n13Rd/wzF9bUNNkysmZbkY9s=;
 b=NnK0BNOicqW+4TQgZmXN43SZcCaFLxP4WssPU0DAcHSOjpCvjXDDcrW7AyXprr6JlhqKdfQk5bbVvaTOH6vgDj9iO7cAJof6TssDDbkwwo5VtszSr/OwD2tU/NpCoDha35ZotJbyJ+IAhTOo1ge1J4lBbf4mJUUOR4hJ4y4JQbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 22:40:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 22:40:49 +0000
Message-ID: <f3568ed2-4dc5-4b6f-99e0-6cc0c17b17ba@amd.com>
Date: Tue, 29 Jul 2025 04:10:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: add RDNA4 dGPUs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250728173733.27723-1-alexander.deucher@amd.com>
 <20250728173733.27723-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250728173733.27723-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: be3a824c-a479-4d1e-c570-08ddce27cc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGJ6VWF2cWFtRjZwM2I0MVVDRDJLVjNRV08waXlhb0taaFhTY21hYlIrZlF2?=
 =?utf-8?B?VnBNVWxNVUw4WXRNWHpTMUhOZlJ5RTVOb3BzenVKOXpCUzBpYTUxRElmZ0tL?=
 =?utf-8?B?UmZNd3gxdlhZK0hPU2Y1YlpiNGJkaDNKWHE2R1p2VjNuOVpjRXRpTFZraWpq?=
 =?utf-8?B?UlRhZU0xLzJPRlNHekI3MFVFRFV5NE11VHFCVFNPTnM5V1VJWTZMU1VOcEx1?=
 =?utf-8?B?UHZMSFJlLzQzeDhGdG5zMExaSTdGdmRPZUJ1L1hkTGJyMmpIWkpGQzRoSWgv?=
 =?utf-8?B?QVdhY2xnMGxQeWpyM3dGS293U01hTTBsTzIycCsrc0N2OEdhelA2U1k5ZDZU?=
 =?utf-8?B?U1l3TWN3dG9LSlRFdFF4emRpSU9wVmx0aG5tZUVLSFppT1J2MmNkQm5PaG9s?=
 =?utf-8?B?d3RsRm9oc3AydVk5VUVtb1BqSVFEV29sSXJsN05RY3diRnVHMHR4MklPZFQw?=
 =?utf-8?B?UGc0N0dzVWZWVG1XaGRiczBCRjFnam8zWmVzaUJsQVJlL2xXSWYrT3h5M0Y4?=
 =?utf-8?B?R3FnMGZZaW14ekU4SFBTTGVjRWh6UVNja1A3Q3BkQ0lBWExxWFEraVdKMVQv?=
 =?utf-8?B?U3FyL0Y2aURFaWVDY0JySTdGeFN5U3N5WHpGSjB1N0JrN1R0dWFUV0dHcmRH?=
 =?utf-8?B?NFhudnBNNTBaMVdKeERqRDhVWHVkVzlsTEtGQnZZcUk4R1doVFlCeGZNRnVR?=
 =?utf-8?B?N0xISWFlM2tyOCtVOU5Wd2RCZWFzQk5ZUUMvWHJ4U24wZUY3UFBvdHY2UVpS?=
 =?utf-8?B?STdCVGxWUzM0Vk51cXFkMVBSbTRHeWI5dHBlR2U3YWVhRkJjTnorU3liR1FN?=
 =?utf-8?B?VmpZUDVZdE81Y0srU0FFVFdwT294M050cFFMVEJFaitXYndsTU4yMGlrc0l5?=
 =?utf-8?B?cll4SWtXTEY4cGErN1VRazNSSHk5RHJQM1lqSmxIN2xmUUxWV3MrMjFGaWJ2?=
 =?utf-8?B?dkhDWmhYTWphbkxDeDNheTBaZW1wTnZPQzNwSFBaVFc2L3NFQUNIckhZQ1V2?=
 =?utf-8?B?ME1PQm9vck1qVWMrVnZ0K1VaZS9IdndKRkpnVS95bTBrZXVvdlhuY0VwN00z?=
 =?utf-8?B?cmFtSkxlaG9PeHhjTzluaVUzMkRSeUgwL0JOelcyM2xIRUdGZGM0aHNRMG5Y?=
 =?utf-8?B?VzRPbElXTk9RYVlZK3FDcTh5a0diWDNDVmxRbDRZaGRBcnl5Y0xXL3FnK2pr?=
 =?utf-8?B?TmVpN0dKeVd0a21oWHVSTE1NaUhYS2RMVW50eWIvRnppVW1kZnAyU3JjTm01?=
 =?utf-8?B?UXFhbmFkWi9IYVZGbzU3VWZLeU5XRGhxZDFsVjNpNEoyYkdpTFhpK21Lb0Nj?=
 =?utf-8?B?aXFadk8rdUJxbDY1N3FoV1VDOFEwcDJkcjVCQzF0ZUx0bTU0a1lLbTRMYy90?=
 =?utf-8?B?L1lkN2FsRExWTEJZUmp5MFBhT21HNUNCam5JdFlKR2IvTlNHUHI4SHJnc3J3?=
 =?utf-8?B?TGo4SGF6eEppbG9JcktWazVNNXFrRkl1ZDdBSW9aYlV5enhHMmpBd0JxSGNm?=
 =?utf-8?B?TDFLQmJkclVhbE05T24yMEJIRFhyaFhIYmt2NTdJVmU3NktHY3BrcjU5SW5h?=
 =?utf-8?B?WEVDa3BRWC81WGpuM2NsZnhERS9Kb1VjdDhLNktmenIralpNd0NaUHloS2Ja?=
 =?utf-8?B?bWg5cTY5by9hL1JEc0VPZkNZTmJLMXVwbHNJejdTendScno2KzRXdlhid2c5?=
 =?utf-8?B?YSs5TnRXcDJ5KzJVdFc5MjFBRUY3aE5YSnZnUXlaQWYzUGRLTHA3V2tJNGRS?=
 =?utf-8?B?dHlzRG12YVJwZDdHNVp5WVRsSHB0ZUlvL05nWE1sTno3TGJwK0YyT015WEht?=
 =?utf-8?B?TTFXQXlCY2pud1NNUDNkM0NOMVhQek1mdFRJbXRrekIyNjI3T01OVXNhUHdx?=
 =?utf-8?B?c1ZCaGxRNG4xdkxQS1R0eWxJKzJEc2htaW1hRUlRT010UUo4eHVFUmRscStN?=
 =?utf-8?Q?NvHWShTs4zI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2p2SHFHWEg5bDhYOWpOYXdCMXBWU2o2a3VPMHFma2oxRG9TZU12NTVpc3hi?=
 =?utf-8?B?ODBQVmxkNlZuTWxyclJqWXJ2TXNBemVSUFVhcjNhcTY3WThIeXNaelRKbUlB?=
 =?utf-8?B?b2wrWWlHOXlIdWwzdU1paWkyRXJXNlFqMUlocU56OXFCbVN5d2JYT2tzRDN4?=
 =?utf-8?B?eHR0czRmZms1elN2UDNpUDUzejZHb0xkRlpaK1dhMVg2dFBCVWwvWmNuOXBo?=
 =?utf-8?B?YVBsSHBVRVA5M3R4M1V4b1dWenUrK2pRVUlyNVpsY210cUlKUTY5WS9MaXUw?=
 =?utf-8?B?ZU53OWdLM0JLbDRGNlVnMjlNRmg0V09ibitpenhCVjJGSWVwQlprd3lVc0RJ?=
 =?utf-8?B?bEhpQ2w5RWxUNHQ4KzQ2SVVDWjVWVUZIZ3RuQmdvVFA1RFU3bmpoUFlmem9p?=
 =?utf-8?B?L2JSd0lWWXJEeTNGU2d1N3lvQzFrbDhPbE1kZUVubzltWDhNL0p2dkdhS3Nv?=
 =?utf-8?B?WG9ScCtpNlNTUlZhWEFRVHJoVGhNTEhmMGZyNmN4VFBqbVRNYzBjZEdpdnQ3?=
 =?utf-8?B?QTl4aEwrSE4wUThsREt1RWMwQ085cmp2eGRHS3M3azRlRlNYUFFOcDcxS3dO?=
 =?utf-8?B?MC9Jbm0rZ21SL0ozTlJQbU4rZlpVRStVeHNuRVFWM0xtdUk0SUhxVWFBU29B?=
 =?utf-8?B?Tm1qL0tyMUxDeEhlWkVqYUtWcXpNc05mWXEzQlBEWHY2UzlKM3lZMkpvazZ3?=
 =?utf-8?B?blV5Qzg0aitwMlNHdWg0aG5DWmxrTHBXaFk0ZU1DaDM0cjAzSXVrcVQ2WElV?=
 =?utf-8?B?WFNIRktsbTJBWFJvZzFPbzJVRE5RTzR1aXQ2bUNWOEFPb2ttQ0tSdUVNTUlR?=
 =?utf-8?B?amM3YWpUbUN6U1FqL3J5cEZlKzJGT1RNY0dqVVgwd3AvdlNRNy9GL3gxZlV4?=
 =?utf-8?B?bjRjTzUyMlBRbDgwalRuVTJNYmluWkcrZVVwMFdhUitLTXBQRmJOVjRjbTg4?=
 =?utf-8?B?VWZrUERJRHgvWWdxdVB6bVpVeFN3bUNDbVRZdlhoVmJxSnIyWHFFMktPSWsr?=
 =?utf-8?B?bXJQZGZPQWhXaUhSVENmQjdJOWFwZCtoK2ZVQS9saGY3Y2IyajZwZzNXcVQy?=
 =?utf-8?B?RG9vQzZzKzNtTURaRlRCZGpiak5WRFJxL3VpOGp6RnhHNjVicm0rZ0FUZGkr?=
 =?utf-8?B?RjJJbHlOVG1jajBhVTRYRGd0WktEdGpkWUtZSHpUbDhRYXdEeDBEdWYzZHZC?=
 =?utf-8?B?a04xQkNaYklGdXhZQlI0Q1oxamlUSE1LM3BEamdnTTRDdFdiaXZra2JHZUlw?=
 =?utf-8?B?T1dENUZQaTdVajZScXYyYmhFM091YTFzbVlSRlJGT0dRNndzRDlvaS9XODBS?=
 =?utf-8?B?KytLeW9JYmQ4Nkg0akdrcjFZZFd5azBPWG9mSkpQUm9abkFRNGF2WWM4OUtu?=
 =?utf-8?B?WTJkZmpZNUZPQjRiRUplWkxXSjJuK2NDR2hJcjhmeTNwMS85ZnJjazdNeUEv?=
 =?utf-8?B?c09oNkpSK3RJZEVmYms1TjZoaHJPVVpPUHhRbkxjSEJGZ2xUQk9neDd4L2dH?=
 =?utf-8?B?aFl2ZkpCc1R0S093SklGV3poR25aeVdPOGRWRUNxSHNUazRZcjBkRkpBaEZo?=
 =?utf-8?B?YldLbUVhUWFpZkc4OGwzbWFDOW1FRGxBQnJJOExqdnBCT0c3Q3RwbUFXSmhh?=
 =?utf-8?B?QzZ2blJrMnpYbXRpekFpYXlyZlFuU1diMytzcnpqeVBuVnBvcUVxTDVza2Ja?=
 =?utf-8?B?aEExNXJrU0lNOWpXV0pyLzFDNjhWM3gzaHB5dk5uSFhCcGNqR1ExYU1VbDl3?=
 =?utf-8?B?TDBmZFFCU1dXa1l0Q21neFg1QlV6Y1lGaTNRU2JYMjVpQ1JaWWd3bG5tM2kv?=
 =?utf-8?B?T0pFaXZJdHVSVUZjK3lycEJiZUFhTWE4UmxXSk4xb0pkM2xQNHRRNnpPamxD?=
 =?utf-8?B?Wm01b0VrdHgxamFRUFBVeU1wVW5HVTRWWnVkY05TNlZveE9lM0dEblBjOGxt?=
 =?utf-8?B?V3FuYm1kWGJreFBoQ2REWFFMd0VZSkxrdXRwMlhVZHlpY0xmaGt1RXFZVHFv?=
 =?utf-8?B?bDR6N1ZvNVhpUVRVdE4vMG5XeHMyYTRtU3ZRU1BZQWtSbzhIYVFMeEMvdXFr?=
 =?utf-8?B?ZS96ODMxTnZkKzBTNjZVbzhDamZzWXhwNzVaRGVDeGlBSXE5cDIzQ25hVjJ0?=
 =?utf-8?Q?Sl+0MMhacTvWgilK3HV12mW2t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3a824c-a479-4d1e-c570-08ddce27cc8a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 22:40:49.1029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcIKfi24fqeo+QZBldVLSH+mrNEMmruKqS6q5y72pgnVHxKT2grrhtE0Q4IiWVl1IfgUj6299Xzwk48SZ+otBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

On 7/28/2025 11:07 PM, Alex Deucher wrote:
> Add RDNA4 dGPUs to the dGPU table.
> 
> https://www.amd.com/en/products/graphics/desktops/radeon/9000-series/amd-radeon-rx-9070xt.html
> https://www.amd.com/en/products/graphics/desktops/radeon/9000-series/amd-radeon-rx-9070.html
> https://www.amd.com/en/products/graphics/desktops/radeon/9000-series/amd-radeon-rx-9060xt.html
> https://www.amd.com/en/products/graphics/desktops/radeon/9000-series/amd-radeon-rx-9060xt-8gb.html

These should have Link: prefixes.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> index 0f822a252fcb3..a3796daec9ec3 100644
> --- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> @@ -26,3 +26,5 @@ AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3
>   AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0, 13.0.0, 13.0.0
>   AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3, 13.0.10, 13.0.10
>   AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2, 13.0.7, 13.0.7
> +AMD Radeon RX 9070 (XT), , DCN 4.0.1, 12.0.1, VCN 5.0.0, 7.0.1, 14.0.3, 14.0.3
> +AMD Radeon RX 9060 XT, , DCN 4.0.1, 12.0.0, VCN 5.0.0, 7.0.0, 14.0.2, 14.0.2

