Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E61CF649C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 04:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C7110E025;
	Mon, 30 Sep 2024 04:56:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sleJkkp/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18A810E025
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 04:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xL/PLW07SQHXqWI0F2Hgz5YHfbpo3fpWBIVGXVN7FWIhrF2KTkEQM3WnVvnWIAQ9hlutoMNSDL6Z4nRMgBOAcLVI9CW4F5QeyUxo49oAvhAkr6RTcavqdwfN4OxeOyINqjXwGC+XzKHTFXuJoyqFB9qRYFJRhKZv1vY3LuOXT3UhGId3IG2E51NgkG1W1drn/28IE7UqOpL6tYE00nXpY5RE1jzXgXsfC6xkuqVX5daFsj06ptOS98DplOTj/j2nA0yiAJE+owMcMAvU9O83yCAmTdhQfICtQPQmOmWNn0VOKdZO0/rafwjfMizwHmICjiUS5iuF9yW2VEwVkZdukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Aq+ju9cRJc715+fPXTGhOdDRiUyDDzB105Y9X0h5s4=;
 b=i+uSYxefRQWhrki2kMp5uqRVUBiLqARRQqB/Z62E8KFefdYsjDp4zJOxJUlY8ApI1GVEnQ3K2095ysIIAKe2NyAoMevmJRZKrEoBejdvbBBbolZ6rS1J+pCVGbw7J2qh1uLef6o7vf58T/JrIYDGtQYnXGeCAP9hGF+zDfRmrSWB+MVDdowfkd32msIh5yCme57XejbWgipSc09ZhQSSOCh7RKalDpENl/jAo87cadKJbGkqFggwgb8FaakVm5gDWqVoBdgLt6pf/sKMdOdTdBgh8r+5T7L60bGJezVp7DmWP2pI1mTmqV/Hnpep7w4uwYyUSagw4QozKuKz/Di4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Aq+ju9cRJc715+fPXTGhOdDRiUyDDzB105Y9X0h5s4=;
 b=sleJkkp/476aG/SeRQEEhRZMbr481Z8+bJWTavIBSjCO873CeoLE9UF7OSzHW6pp6TcZiOZ0BW7zhOBbrMrC9moRY+6fASghQwgatFSBM3IqCgFnpYOH+3L0pKc1epV4V3KeXyoSxg1OntSG2eIS9AwT+k5WKqiA6l7xFSWTOCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 04:56:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 04:56:03 +0000
Message-ID: <af4bef03-66bf-4762-8d43-e2bed60802b7@amd.com>
Date: Mon, 30 Sep 2024 10:25:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/sdma4.4.2: implement ring reset callback
 for sdma4.4.2
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240929104856.46010-1-jiadong.zhu@amd.com>
 <20240929104856.46010-3-jiadong.zhu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240929104856.46010-3-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e408ff4-994f-46a1-36cf-08dce10c2fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCsvVmtpNE5zOWRleGZnQ1lUaXcvdjBuL3l4eHR5bCtwS3Z0YlZRVVJFeGRw?=
 =?utf-8?B?U3RNL21TRXVOeGdtdWtSZW1KRXJhMG96eUFJTGlFUFZ3OGcrNW1XV0Z2L1JF?=
 =?utf-8?B?cWUvS1VSd3NkVlROZGlwd0FZeklkSXkyOTJBVEZxZzNhbjR0MExTckVKYkIw?=
 =?utf-8?B?N2xoTExYbUR4ZkhhbllpcE4yN3JGRjF6em1iOVBwc0tZRFVjbDlDbzlTUW83?=
 =?utf-8?B?R0NTWjczUVpvRWFCd05ob3U5R1N1WVkyMmZBQlBVa1NXTTFaZVN3OXUrOVhI?=
 =?utf-8?B?SGhzYzBJYWt6RkYzMEVUWW5lb2hMbUwxZzIyRlZRMGRtc3laczNyWEc5M3ZP?=
 =?utf-8?B?RjBCNWExK1RnOGZxMk0wSnJWWE9rdUEvY2E5L2VQTnplZGJTVU5US2tEeEdS?=
 =?utf-8?B?bXJwTU0wSG5uaDE5NGJkenV5bnZLaDFHbDJDU0dyRDE1c09LS0NvL09iZ2Fn?=
 =?utf-8?B?bk1heC9ndEZVSFE1ZGxPc3BvSDNxRUtiaXN5eVU1UThTOTRRemNuUzA2UmV6?=
 =?utf-8?B?eGIzY28zQnNMRmtjVXNIcjBtUmhIK21iM0N1ZHdtRVJ1V3BaV2MxV0FwQkdp?=
 =?utf-8?B?QVFDUFhMcjVJeSs1SThSVEpTZGJYZUkzQ1FOSnlyVWVEdzNPYzBuOTZJZXlL?=
 =?utf-8?B?RlJJWXBhRGR6SHQ2b2RyMjVmNytGQWMrUXh6eEFPUStKelRKTnY1UXN6M2JZ?=
 =?utf-8?B?Qi9JUXlteWkzMy9ZQVlERmxXd1EyNzhCb2pCa3Z5OVh2S1dubFJzMENVVWZt?=
 =?utf-8?B?cFBWQno5T2xySFJGWTQzK2ZHSmhRdTltMkFtYTg2VlpGRUt4SGUrdWgyeFEv?=
 =?utf-8?B?T0ZNd2g5Ymt3R2s2bGNnZUNIUTJGa28zcmxEWlE2ckZLVDRpTkJHc2t0THJi?=
 =?utf-8?B?ODNpYTEvd25iR3JMcWZRZmxMZHRkRHB4ajNNT3I2N1NSeHZCYngrN2RGZFNi?=
 =?utf-8?B?bk53SVMxc01ZRTdmZkZ6WVcrb0lGM1p3MUZBVzBUK2hkTUpFcWwyM1d0eUZZ?=
 =?utf-8?B?dmNBQmRvY2V2K0xXUDVXTnZVTmFOemw1QWNEYVIvRTY1ZXZyVTVEUExPWU83?=
 =?utf-8?B?WUtPTDBEbUd2QUg2L2tHQml4RGdIeTVqOFBzaDY4N1dIa3BVeFNYRUxOQW45?=
 =?utf-8?B?dFZqM1RNcndTaWNENVJ3NDRyVlM0eEJMVU1wR1NVRmp6Ymt1N2VrOUx2K1RX?=
 =?utf-8?B?TzBRT1JRN29FWGs2T0VDSm4yNVNTbW02a0JVdzdITVJKME9kVGJqTVRzeDM2?=
 =?utf-8?B?U09jTGRCT1dVNGkvSjV2RjIrMm5xNU9nSHFmbjJQUVpmMlZMYTdwcDVWMm4x?=
 =?utf-8?B?Sk5WL1VvM09ScFZZUm1TdjVMdEh5a2VxZFJBdzBmT2Vyc2MrS3JuSnZUTDRI?=
 =?utf-8?B?YXUzR2NPQmVkUFk3OFd6S0N4elBoNTc3eFV4Z29vUFkrd2dQTDNWd2YvQ3Iy?=
 =?utf-8?B?dDlMc05CMlo0QjlBT1F6UGlYRlZDb0N1SE9tM043TlFlRmFQdVB3RGloa3hv?=
 =?utf-8?B?WHhEREVEY2xlbklpNExUOFVZcjk5eTNSZWhCRjZtcjZXMVBOK3ovZUUrVUcw?=
 =?utf-8?B?T2JFU1JDdEM0MWpPOHhTVWRNV01MQlFxRUVQNUJFZXR3akMxdjFLZDlNdTJ0?=
 =?utf-8?B?eVBCMDJIZm1CSGN3cURQaS9ONW1iY0REdXhXVkRpeDZIckMzSjVOeFBteEZx?=
 =?utf-8?B?QkRoT1J6L0Z4YTV5bk9Db0I2dGdEY1JzMjdSSFFua2JXbW9UWmNkT0dnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpnbUxHT3d2YjhVQzkxTE0ySVJtTWV1NWJmaGNYQXJlWjJXeFUvYXZTVHB4?=
 =?utf-8?B?eEhLRWpOQ3E2WDJ0Y1lCZk5hVHhLODhmNEUwR3g5UzdXUnpHeTBlWXZmVG1j?=
 =?utf-8?B?dmhkQjBIai9pNk1WamZDVGQyYjFtUC9RNHZrdnMvSmlLUHdHTUt4Q1N2Q1JT?=
 =?utf-8?B?aThoNWRhYnkyK1ZPa0ZOakZrb1hiQUhwanc2SUZsWGpSODhBVFkrVmxkYVRY?=
 =?utf-8?B?TXNwSEJKTzh4Q3gzOUZuZ09tUlYyZmhzMGMvTnpHTmJ0Z3ladGttV1E5ZTVJ?=
 =?utf-8?B?aU1kbWRFcFM0NEJIdmgxcEJRdTNqbm9nbjV1Z1RpQzJrK3VTelkzV1MwOXpu?=
 =?utf-8?B?c3ZUSC9iR21BVGl4cW5pdGlKU2VhUHRSak9iblRHcDBGSW1GTnFESWpFcWwx?=
 =?utf-8?B?SkhGUlkvQW9nOXprbVUwdmphVlNSMUt2Z2dhWHNmWWFub1F2aGlEeVdVUW9G?=
 =?utf-8?B?M2RQalIxVk9LRjhnMHdGQ2tXWXVac3dKeHA2bkIyQjhZMHUzb0k1Y0Q3Um9K?=
 =?utf-8?B?d1Zxc1h3cG9Cb1NEM2FsWGhrY2xsaXk3SmwwL3dvNzdoZG9ITmwxVGRuV1dx?=
 =?utf-8?B?dFY2dEJHbVE0MTc2RG91a3VMSlE3YUN6RzVtZXptdU9weVkzTTBMeXpqVElR?=
 =?utf-8?B?R2tDbE9aYTNVNWZZWVNlbTM2dnlPdFd0WEdoYTFqYnV6bXFHZm1Kdnl2UXBn?=
 =?utf-8?B?Y1V4TkErQ3pMdzdDaG5uTE1ZdjRSaTRnNlEzS0Vyc21Tem5TdlBTb0lXZkd4?=
 =?utf-8?B?V3I3QnBXSEovNTczemJIRHVXTmVGYmc5NlloUUM2dnRiTS9VUm81ZXJmMkhJ?=
 =?utf-8?B?TmZraHo0aWdocFRadWFuckQySGlabjJCajcrOXoyb0l4amNWSFVHZFVXY3FQ?=
 =?utf-8?B?UW4vNkE1ajZ1ZURaNDluSjlQNEVqNVlVdW5QVUtpZDRwZGwwRTUyeVJ6djZV?=
 =?utf-8?B?cTEyMlhtbmRqSFJmeGxDT0RDeUFTQm5sdituSWRWUUorcnpXTlY1VXdyQ3Zq?=
 =?utf-8?B?SDZPR2pXYjVyak5JRElaa3FYYit0anJCbUJIU1UzZWdRU0RXY25TVk42ZnJi?=
 =?utf-8?B?WWFYdkdQeE1CcTlzQTdJL3Zxd3ZYWU5qSGtSQXFQR2ZNeVZySThsYVdId0Yz?=
 =?utf-8?B?VUNseUlrTE9TK2RHb2VUQ2FGUUpJWGl6WW0zQ2FVYWNCYy8yY1lnVFZaRWhr?=
 =?utf-8?B?YjlkVzVRb1RWQVlQWkJ5T3ROMWFIeC9PazlpR2p5cWpGNmprelVtcFJLbGhR?=
 =?utf-8?B?SzQ5bk5VeXVqdTFqRjkwNVEwSXpPdWhYb2ZMc1l4b2lidnlMd3BML3RJRXAw?=
 =?utf-8?B?N08vQ0RjV1o4UlhhUURwOEY2RURwaHpNS2lsaUVIYlhhdkZQZHY2WmlCM2VC?=
 =?utf-8?B?VS9Ha1Z5UFpldlkzL0J1VzJuMjBBNEhFOTBpY0tPUXMxRGhUL2lwNmVHY09Y?=
 =?utf-8?B?cTVRNURTS1JqLzNxenlTdGU4bG5lWU42YU5qdnRERmpPYSsxRzhyZW9nNGwy?=
 =?utf-8?B?WmFnWm5MdlRFMy9TMnV0cW5XNU1SbElnc2dOMTlYMHg2cWdoSFJ6TC9lZzJQ?=
 =?utf-8?B?RFBQZEh0eG5NV3NiMDNQZHFoNGp5QkRWTHpjYmlKd3lQdndqdHlOS3ZyYTZj?=
 =?utf-8?B?elJFM3NJYU9SSGhnemNFbEpXWkpMNE9wbkRLY0RhTDVYS0dEL2E2SnV5WEky?=
 =?utf-8?B?MVlkZUN6ZVdLTGNJR0xVaWpkTDhERTBnRmowM3RkRnZzNFhRWXhnZzBUemd2?=
 =?utf-8?B?UmNjVU1WWXNrdmZUbzFMemozNlJqUmZGNEZEbmNFTk5PK1dQWVdQaG8xMk9V?=
 =?utf-8?B?ZkQ2bzVPYXdIR2lUVnNyZUpzd0p1SEpsdVVXYVhXNURXenkyMG85Nk01c2p3?=
 =?utf-8?B?TXZRbUJNamVkQlFKckN1VFh2Qk9xa1ZOSVJZNTRndjFBQ0tMMEZLcTZRbkNz?=
 =?utf-8?B?TzhvTUplakQvMUJCQWFMR2FRamwwM0ZHK25iSWxqZ0p1RGk0K0hEOUtIYWth?=
 =?utf-8?B?MU94eWFhY1R3cU5EL1JTNmZkbnBYVzFGNTF1UDBDMElmQzlEZUJCeHlCTllz?=
 =?utf-8?B?Zy9hSmEzMUUwcEFEcGxqd1Zja1UzU3FtK1dwZmlGOHB1Ri9EdUkyOUFpUC9E?=
 =?utf-8?Q?YMPTdnmML6yQ+MsT6WYElVgUA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e408ff4-994f-46a1-36cf-08dce10c2fb9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 04:56:03.7259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVsg3n81mdFUy+SlDDS0Y6WB57dfRg6mlp/2MwLZ16nt8AbXUjJqvwhqFp/BMBWW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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



On 9/29/2024 4:18 PM, jiadong.zhu@amd.com wrote:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
> 
> Implement sdma queue reset callback via SMU interface.
> 
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 137 ++++++++++++++++++++---
>  1 file changed, 123 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c77889040760..9485f1a1986c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
> + * @restore: used to restore wptr when restart
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -698,16 +699,24 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
>  	WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
>  
> -	ring->wptr = 0;
> +	if (!restore)
> +		ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +	if (restore) {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +	} else {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +	}
>  
>  	doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
>  	doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
> @@ -759,7 +768,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -775,10 +784,17 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +	if (restore) {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +	} else {
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +	}
>  
>  	/* set the wb address whether it's enabled or not */
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI,
> @@ -792,7 +808,8 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >> 40);
>  
> -	ring->wptr = 0;
> +	if (!restore)
> +		ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1);
> @@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  		uint32_t temp;
>  
>  		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -		sdma_v4_4_2_gfx_resume(adev, i);
> +		sdma_v4_4_2_gfx_resume(adev, i, false);
>  		if (adev->sdma.has_page_queue)
> -			sdma_v4_4_2_page_resume(adev, i);
> +			sdma_v4_4_2_page_resume(adev, i, false);
>  
>  		/* set utc l1 enable flag always to 1 */
>  		temp = RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1566,6 +1583,97 @@ static int sdma_v4_4_2_soft_reset(void *handle)
>  	return 0;
>  }
>  
> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	int i, j, r;
> +	u32 rb_cntl, ib_cntl, cntl, preempt;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		return -EINVAL;
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		if (ring == &adev->sdma.instance[i].ring)
> +			break;
> +	}
> +
> +	if (i == adev->sdma.num_instances) {
> +		DRM_ERROR("sdma instance not found\n");
> +		return -EINVAL;
> +	}
> +
Above logic is not required. ring->me gives the SDMA instance.

> +	/* 2 instances on each xcc, inst0, 1 on xcc0 */
> +	amdgpu_gfx_rlc_enter_safe_mode(adev, i >> 1);
> +

What is the purpose of preventing GFX CGCG? SDMA 4.4.2 is not in GFX domain.

> +	/* stop queue */
> +	ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
> +	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
> +	WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
> +
> +	rb_cntl = RREG32_SDMA(i, regSDMA_GFX_RB_CNTL);
> +	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_GFX_RB_CNTL, RB_ENABLE, 0);
> +	WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);
> +
> +	if (adev->sdma.has_page_queue) {
> +		ib_cntl = RREG32_SDMA(i, regSDMA_PAGE_IB_CNTL);
> +		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_PAGE_IB_CNTL, IB_ENABLE, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_IB_CNTL, ib_cntl);
> +
> +		rb_cntl = RREG32_SDMA(i, regSDMA_PAGE_RB_CNTL);
> +		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_PAGE_RB_CNTL, RB_ENABLE, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
> +	}
> +

Since resume is called after reset, can't these be replaced with
sdma_v4_4_2_inst_gfx_stop/sdma_v4_4_2_inst_page_stop?

> +	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0*/
> +	preempt = RREG32_SDMA(i, regSDMA_GFX_PREEMPT);
> +	preempt = REG_SET_FIELD(preempt, SDMA_GFX_PREEMPT, IB_PREEMPT, 0);
> +	WREG32_SDMA(i, regSDMA_GFX_PREEMPT, preempt);
> +
> +	r = amdgpu_dpm_reset_sdma(adev, 1 << i);

This may not work if PMFW is expecting actual physical SDMA instance. In
that case, this needs to pass a mask of (1U << GET_INST(SDMA, i))

> +	if (r) {
> +		DRM_ERROR("amdgpu_dpm_reset_sdma failed(%d).\n", r);

Please replace all DRM_ERROR with dev_err.

> +		goto err0;
> +	}
> +
> +	udelay(50);
> +
> +	for (j = 0; j < adev->usec_timeout; j++) {
> +		if (!REG_GET_FIELD(RREG32_SDMA(i, regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (j == adev->usec_timeout) {
> +		DRM_ERROR("waiting for unhalt failed.\n");
> +		r = -ETIMEDOUT;
> +		goto err0;
> +	}
> +
> +	/* queue start*/
> +	cntl = RREG32_SDMA(i, regSDMA_CNTL);
> +	cntl = REG_SET_FIELD(cntl, SDMA_CNTL, UTC_L1_ENABLE, 1);
> +	WREG32_SDMA(i, regSDMA_CNTL, cntl);
> +
> +	sdma_v4_4_2_gfx_resume(adev, i, true);
> +	r = amdgpu_ring_test_helper(ring);
> +	if (r) {
> +		DRM_ERROR("sdma gfx resume failed(%d).\n", r);
> +		return r;
> +	}
> +	if (adev->sdma.has_page_queue) {
> +		sdma_v4_4_2_page_resume(adev, i, true);
> +		r = amdgpu_ring_test_helper(&adev->sdma.instance[i].page);
> +		if (r)
> +			DRM_ERROR("sdma page resume failed ret=%d.\n", r);
> +	}
> +

Is the above sequence valid for SRIOV? If yes, consider using
sdma_v4_4_2_inst_start(), the delta doesn't look that much.

Thanks,
Lijo
> +err0:
> +	/* 2 instances on each xcc */
> +	amdgpu_gfx_rlc_exit_safe_mode(adev, i >> 1);
> +	return r;
> +}
> +
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>  					struct amdgpu_irq_src *source,
>  					unsigned type,
> @@ -1948,6 +2056,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = sdma_v4_4_2_reset_queue,
>  };
>  
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
