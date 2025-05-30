Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CBCC3ABB2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 05:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4994110E7C0;
	Fri, 30 May 2025 05:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P/wVLyn7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9018210E792
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 05:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvbH30/R4adxDePxBjuE2iJ80oPvJhwivLW5SlCBSlhHUm8fqGDQVmGpokvUze0BafAad0eiZ4K3GLOt3q+582lpQVTU8vzVD2obsgp5n5j8ByPIIxrDgnO0XgifEj8BjrdM6f0Wt4yl/1E+d2V/DQKzq7NMDBgg7WMPjzPEmXk5pgZDzxHNTXz+//MdZxzoZh0rb8LKxy8o27CCVigp+0oGrwdHTWsF84hJdeZWdBFwcz9fySYFUKMSe3Pi/mHZ/8Dh+w6xLqjxhpO5TKrrbwnZs6AxwfuITJcm5if6uYd3wyC0AwqRQxW1DRKCjdZMy0biNpFo2xUtiPOqAheAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy5py8W9X/XNQYLw88WAeR3B6FYHYeYYRFMgRMZCb6Q=;
 b=mDKXkXQEdbjYFgJcXA5ggWb4v1Z6Hxt8dJ/Fi+x7bnP5MtyOh65l/GW1DqnggKV8uUYCN3evadqyVbInKfhqjlruuxOxLZp++XZ9CfjSBmZiqHaE3KeuNo2g2dCD+w5nP3qLkjW8DAD7/h0Hf9aPvXvMnew2VrswnaGV5JU+fJha6J2YdLg6+S0i0JPXMXfgSJ3+jGXEQFYuB2iCjRhVpps27xCgWeSivko4isaz257t1qTYliAILd+67bwqDPKaWL4QzvEkwhs5+HueD931EhN80jj4T+TsdLSYSXxaQ64VF7f7pqf6iL7qj34p78iIec81DW2IIPzFgfLy+UQwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy5py8W9X/XNQYLw88WAeR3B6FYHYeYYRFMgRMZCb6Q=;
 b=P/wVLyn7Wpt5mKPbu0HecNkTToPkvJD5Mc8ncTPsfT+zG0TeeZBAUj7r7N2K3uXQnarzD00PE5vXxUn3W9O0YSjZWIIUkhmU2Z5pHY6kNocjnUb5dF94k+C7e+TfaxQ5yx9YQjSZz2XvP2/ZuUUjKs+CrXwR/L4pGxmeu0KMivs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 05:56:38 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 05:56:38 +0000
Message-ID: <4163aed9-f8bc-4bb9-9e5c-53a0e9891006@amd.com>
Date: Fri, 30 May 2025 11:26:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix potential dma_fence leak in
 amdgpu_ttm_clear_buffer
To: Li Ma <li.ma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Perry.Yuan@amd.com
References: <20250529130738.2352725-1-li.ma@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20250529130738.2352725-1-li.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 3814925a-ea3a-4beb-8492-08dd9f3ebdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmhjYUk1WE9HcndNOTNIOVBIa3FESStsMSt5Q2UxK3VES1dPU29KdGx0amxO?=
 =?utf-8?B?c2lVTU9PZnVIU28xSkxJdEs4blRhUFRWb2M2Tm12UzZiS0RMc3FsTnF3RUlC?=
 =?utf-8?B?N2d0Zk9rWUtBUjN3Y1ljSFNhWDJDMThUcVhKY09OY3I5TCtGY0VIQytoRW1J?=
 =?utf-8?B?cHhOOG9OWUV2dEN6aDN3MWdZbkRPdENhR2Y5Y3ZLaHBLQ1MvbmsxSmFkNEMv?=
 =?utf-8?B?NEsxbDJRR01ZckRZQWtaQ0lJRGtqQ0ZCTEpLZnFLYzMvYjFKcklQNkdpSEEx?=
 =?utf-8?B?R2NJd3JLNGtwSnJ3ZmFIdFk5bDJIVEI5WVpJR0IvOEZPdEFOTENkc21lbHVV?=
 =?utf-8?B?REpEQlRTS0F4cXpTMC95Nzg0bUZhL2N3SEpGdlJNeTQwNzJhWWpjVDM1aDlq?=
 =?utf-8?B?Y0pyZiszdVFpWHFlU1d6S0RNOStTMkRQNFlRQlJRNFBSb3ZldnpLWm93MDJK?=
 =?utf-8?B?Y1ZTaXVLVWV3d2NqT29ENUdMd0l0Vk8vTEJJM3ZSTGNLaWZrZ0F4Y0thelpY?=
 =?utf-8?B?Z3EzcWxBa29meGMydTFNbkpIWGxqbHpjbVc0QjBOZGQ5Y1RQbUdHQWsrT2tF?=
 =?utf-8?B?V3FZUTBsekJybTkzNlVUcGsrU3B5RXJEOEtDbTZaVmQxVW1YQXE5c2VNeVBa?=
 =?utf-8?B?TDVOcnJNOFVkcGtteWNYaXJneEoyVHp2a2ZMY1FEdWRKcEllQndncnVXcDFm?=
 =?utf-8?B?WHlmbmdYR0pXT1IrNEprc1ZnTnVCWFpBSm5kdzNTY1hPQnY1Zm1yVksvRXd6?=
 =?utf-8?B?QnlHQ1FJeDFjd0tOT1NONjRhV0VzaGJTd214NDQ5dkxzTWdYMEFhNHhabTNr?=
 =?utf-8?B?RkxpZlFicEo0akc4YkNLc0VVUDJCcktuTERGUFhMSkluUVBvK1hlSTdOUmVn?=
 =?utf-8?B?NE1rUHFaem55N1BsSlp6S28vRlQxdEVrWHFEZ290d1VZZE9jd2tKSmo2Ui9O?=
 =?utf-8?B?K2xMQnhFT0JGZWduTk4xVnFzTjhPcWQ1ZHpFQVYzYU4raW5QN1JZMXBLdVZo?=
 =?utf-8?B?LzBLTVBsV25lL3FlTGNOTTJMdkdlSkJ2TUJ1TWFPK1pDK2FaYmNNU2lCMEVk?=
 =?utf-8?B?UDRLUitKb2xpd2hvZCtTOGFOd2hvaVJWZFk3bThXM2RXcnNwclVJek9QK0Ix?=
 =?utf-8?B?UEJBMEpqOEhiRHR3eWk3c2o3NVFBNXBCakhLemtJQmh0d0F0N3krdnRRSFJ3?=
 =?utf-8?B?VWZ3TzRSWFVyN1FLN0kyaFBCejlZYmdPYnM1UGQ2K2tONlVZZDdjWTRZWUNq?=
 =?utf-8?B?THZrbjZnUllYWm5leGZqdmp2NFBxOVlpdUVUVFdneEJ5RWlNekc3enBSMDFw?=
 =?utf-8?B?aS9yNGpDSmlVMGlOa1puTlBuREw3cElpcXpVS3l4SWxWTnBsR0hqVzl5QTUy?=
 =?utf-8?B?S3pmL1d5dHk2RGJJYjQwQkNDSHpuQlBOZ3hEVUw5RURsWkswa0ZhNWZ0V1FD?=
 =?utf-8?B?azNmSm5aYXJUZklSQUFScGRia2l5WFA2ZTZoVW44anlHZDRObEdSVDJJMFZG?=
 =?utf-8?B?U1JNamFleWRyWU9mK2syZDIxUHZ2d1VIbXdDU0xmWHhFcStyWjNxZ084N1pX?=
 =?utf-8?B?SytjYkJRZi9wNVU0UXIvZi9DZmdYeXl4dTBWRjZVcnMya2RES21IMC90L3NB?=
 =?utf-8?B?WHFGQWZEREM1ME1rS2hnbFJ5WkVubDNXVW1jbkZwWS8yTXBOTm9QYUpvVHF6?=
 =?utf-8?B?Z3A1cUtzOCtXVlNSQmNCdUgwc1BSblByMGYxZDZHN1h5VjFzOUhOVlRJOHVF?=
 =?utf-8?B?VVo3cTFvVUw4OHh4ajJFVVUvUGE0QjR0Nkl5MnlHbVJ0YWd2NEhmZHkyNHFv?=
 =?utf-8?B?dWVTMkdnNGhpWkhEdG43Vnk2NERTZ24rbVgzaXc0ZXFvR1E0VjNBdUYwa3A5?=
 =?utf-8?B?bG95RlpPRURvNmRrQzIzQUpmbGhYQ2NHRWxlTks3cDBDd0Zzc2NnTnhPcWox?=
 =?utf-8?Q?zNXeEo2ey5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXF3aTVaREMvNlFZZE9DR0R4OXFNLzVPWURCcEFvYStTSlZrQzExN0tMamlC?=
 =?utf-8?B?Rnlab3ZmSzBDWTFpR3drM0NVWVpEd0tqS2I1NnM5ZDJXQnM5aENwdDdaMzEr?=
 =?utf-8?B?RDNzTkxzdkU2dExXcVFVSERTbGVzS085SEdUVXIzRmVqN0JhQ3lTREdla2VN?=
 =?utf-8?B?MzdoU1phS3ltdk9uL09HaElqUXlST2VMN2VrN3cvL2F2K3h3bStaK3FvQjh5?=
 =?utf-8?B?bUhIanQwNGo1VUxxZnZtN0krSmxrTGVHT2NwMHYzK3l4U1E1Kzl5dEFKRHM1?=
 =?utf-8?B?Qlg0ZmFaZE53MXFNN1ZCZ20zZnNtYjdHNlg0VTJ5VFVvcVRqeUlST3B5c05K?=
 =?utf-8?B?amdXOVNmZFJkYnBIaExsMnhsSUVCTTNkRGZPQ0tPb2I1UGdqU0pIZzNDQkZN?=
 =?utf-8?B?alpVVFMwUko5c3RaekdJd20xUW9TVUVBUjZNbUxQbFpheGwxbjFMMXB4K1pM?=
 =?utf-8?B?THZjQWc1aTU4bVRSWWFVa1Y5cXNEQ0YyK0tEVjBNWWY0RksyTUtkdXNIaEsz?=
 =?utf-8?B?anJhMXd0Q0NuQkxJMFZZQUwrdlNzYzNvc050bElaKzh5SXBHWXdGWWYwb3k2?=
 =?utf-8?B?cXhVdThGTFRTUVZvdWJoOCtEeEpyU1FxVEo4ci96R3AzTGE0UnRBa1hLYllT?=
 =?utf-8?B?azFHekdTb2gzeXFvYnJSTmtHRlY2NnZjWHdSdVZZamt4N214RnduUzBPZHk5?=
 =?utf-8?B?Ly9WckNGaDgwVkdhbzQrbVRWdXhTWmRUeFBFdlpkNmJCK2xuNktwTjRBNTFu?=
 =?utf-8?B?Wjlxb2NVclhMR3Q2TFFjbjhJcjI0QkpPWUJLaDdtUHNWTS9XQ3FTYkNvZkZq?=
 =?utf-8?B?MitRUWtQWlZJeE1nS3VMck9QU1ZVVjhCaDg3SmhWK09kWG5tdmVWR2UzbFRK?=
 =?utf-8?B?TWdadWIybmR1bkFTckliSHYyVDRXS0VpTG1wZWx4clZhMDl3N21iVlJyanp2?=
 =?utf-8?B?TWQ2SGhpTFlpREhkYk55RFo3UXVJdmUrYVpITFRIV3ZYOFNrWXdFUEJGMG5Z?=
 =?utf-8?B?bVN1MzZ1bUV2VForbXNGam9yVlBZN1ZzSU1hSm5JakRUcTJHOVl2dEIxV1JI?=
 =?utf-8?B?Y2ZTWTkwdDc1dzlSSHlqN0tZUTN2OThhdEtqQkxvVHBqNVhDU2VmckxraVg2?=
 =?utf-8?B?enZZNkhhaFhKcWY3ZEpqblEwNk40Ty9nbzFYcWJQa3NLTnc3WWhUS0dxOUQr?=
 =?utf-8?B?a0x6S1BYVHZuUzdJNnpTMk9nRkk3NThWK0UrVDAydGora3lUWDFxYXpEMUNZ?=
 =?utf-8?B?TmxpaERQVHd4djh4dy9qY09nNHRHWlVEZ3htSHVyMG1Bd2g0YXRzUHRVS29Q?=
 =?utf-8?B?cm9oWmRDTWw2ZVNkZCszbFBUU0o3aFU4RTEvalk2Tlk0VGw5UVN0ZFVONUF2?=
 =?utf-8?B?ME9GWUZITHl6OXJCUnNkdHZwR3hFd2JGWGlxa1pXeExlMTNTSHhwV3RoUHY4?=
 =?utf-8?B?bXBBOG5DbmNRQlIzZUR3TVYxQTY3RnRDOXlHUWFZSmJyRGZka1BKenBWak1H?=
 =?utf-8?B?d1djZGRBRmhNOUk3R3lQNGQ3RmhTVGFVQ1NKRlRJMGpuTHNTMzVJNVZFTWRG?=
 =?utf-8?B?MCtCWXVqSlhobUpac2xxRXhJZFpIdjdpTkxyOENwVkVMNmFqQXFRZm5ZTDJ0?=
 =?utf-8?B?cVRDdmhYVnpaL0xHdGVWQThPV3M2SWNLS2JGVFoybDh4R2h3VXd1aFNFWnl1?=
 =?utf-8?B?S2RLR1c1ZTY4S1hBanRNZ3U1NXAydXFSeDBzT1JwYW12YzBOSlE4TzZCTi9y?=
 =?utf-8?B?b2ZTQXhXUnRRV3J6VjBlNjFEMEtqOWZMbnEvNkxMOE9HWjhlQ043VVlGKzJo?=
 =?utf-8?B?Z0hEeDE5aUtoWjBDcEIyQnJBdVg1VGZZcXZaS3poc0Y3d1JVT3R0ZWZGTWRq?=
 =?utf-8?B?YW54Y0F1amY1MEE4eGVKZEpUU0V5aENkUjU1ZkFsMjNsK2JLNU05RFJpaG5S?=
 =?utf-8?B?ZzNGblpCL0k4K09HZkhsUm1jbkhhTnhEZ3RwQzY2SkUxWktLRDIwdWFBZzNm?=
 =?utf-8?B?b3pJMVRwMEZna2l0T0JmZWU5cW8wdTRiL2YxQk9hcksyRisvdkxDS20vNGFz?=
 =?utf-8?B?Vy9QSFRpcUhXejdnTDN2ZWF6N1FtTXgwbXFkRGhmT0FvNHZpb2NDaUVsbFo0?=
 =?utf-8?Q?QUkveBU7qqENu3AzLGAMsk0dH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3814925a-ea3a-4beb-8492-08dd9f3ebdd8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 05:56:38.3085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP0hwvlw97YVzflkzCA7giI7QyDPnUruOGP9NTGXUS2ERzTp7DVd4bAyG4m+wcrB3J+iZzJK9/GFyko+bnriFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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

Hi Ma,

On 5/29/2025 6:37 PM, Li Ma wrote:
> The original code did not properly release the dma_fence `next` in case
> amdgpu_ttm_fill_mem failed during buffer clearing.
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 9c5df35f05b7..b7284f0a5ac0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2296,6 +2296,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>   	struct amdgpu_res_cursor cursor;
> +	struct dma_fence *next = NULL;
>   	u64 addr;
>   	int r = 0;
>   
> @@ -2311,7 +2312,6 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>   
>   	mutex_lock(&adev->mman.gtt_window_lock);
>   	while (cursor.remaining) {
> -		struct dma_fence *next = NULL;
>   		u64 size;
>   
>   		if (amdgpu_res_cleared(&cursor)) {
> @@ -2334,10 +2334,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>   
>   		dma_fence_put(*fence);
>   		*fence = next;
> +		next = NULL;
>   
>   		amdgpu_res_next(&cursor, size);
>   	}
>   err:
> +	if (next)
> +		dma_fence_put(next);
Since you are observing use-after-free warning for the compute dispatch 
test in amdgpu_test with this patch,
can we try the below code in amdgpu_bo_create() function,

r = amdgpu_ttm_clear_buffer(bo, bo->tbo.base.resv, &fence);
                 if (unlikely(r)) {
                         if (fence)
                                 dma_fence_put(fence);

                         goto fail_unreserve;
                 }
Regards,
Arun.
>   	mutex_unlock(&adev->mman.gtt_window_lock);
>   
>   	return r;

