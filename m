Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802D9C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 20:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24B412BAD5;
	Thu, 30 May 2024 20:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GajoiZOr";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E83812BAD5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 20:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxFpwAYAL3Pwfohe2ZARmZclfJBvECPMuO4zaP1BESoEnS9lJPcfuPUpjljnhds6ypIJ483KRjDmtwq/CGhC0Ypx8VWq8M7daJZs2YFlz1skcsOH8ZvR9cw1uZuubzzxqgPux+BZOaFQQ5ZpY8/o16loxf3o/1/ovJm8gCEefAVERsvqdwifhKDhPQdzVtMrXY54d1iMyooMvl/RO8r3jFrE0Vq7mXwNxDgDPQk7UlOXGdh2WFaTttk0stfaRtKzJNueednCfEYZrQ2tWevM0zWUaq5OsyQlXWstHluknmqeOCH8NJF4mKZo9kBbzzmUW8tggyofN4Lt8z5pEpiihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHHdeDb7SpEZ13wgkqStfv1O085aAoTqMWHcMqw9tYs=;
 b=miVx1V96VvQS/Rf6T+t0TMQpFlc0gr3TJenCX/UGfeqUqUxTMQLbPDXn0taKLqClBrQiOdJYa7aedNMaog2bPyMPNJ4uv+0STfkW7icq8M88mvIjBqrgvSDMCXWdz5CMxw2X3LTrJvyD8t1Hd9K5+0ycqUHYjX1BVrom1Tbau7MJ2x/bfWVXnrQheIL+vca8nayQbuDBSGGaFlV3YH0IUUBoNi/OmoikWFwMABBfmXL//4kFHvUMaxIJzvXxK2TCOD6f5pceb3aJ/xHXqLyQA4OJ4pvOc6yvMAETEILbQjXtFAzD2xDKqTabu022J418xFklrFw53IYeCrKI+ZkCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHHdeDb7SpEZ13wgkqStfv1O085aAoTqMWHcMqw9tYs=;
 b=GajoiZOrPv8WzZykYqHxJsDtxDMLl0OvsAhAM08+xsjT3tJNa1lvEwegeXATuiJRUQKNejduqL05T7oHctp/bW2NvE0wDvrkvLrpAdvHIY72kM+TXgCdAaf/A9uGjRyMBRLVxDqG481GbKSyvvNz41gqT/mhDQJI0AEBVsMgUvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 20:47:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 20:47:30 +0000
Message-ID: <01cb58cd-e8d7-4e5d-b5ef-f89cfa17614c@amd.com>
Date: Thu, 30 May 2024 16:47:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdkfd: fix the kdf debugger issue
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530034720.2341171-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240530034720.2341171-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 74212f69-6b0b-4f82-1b3a-08dc80e9b96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlNla0o3R3FicVpEUXNyWDNQSTc5aExRZ1FlNDFQeUtIdHg4VVFjbm9nNHdH?=
 =?utf-8?B?WUhFUmhJQ25xWExoL3d1TlNzTVF2Vm5WU2FCU0NmbkZrTTFtOFJMSVdEYTFT?=
 =?utf-8?B?eGhZZXBrc1BSZlgvU3pheDV0RnZDVnZQanJmUERqdkpLSGJBTk1oYzl0RmZG?=
 =?utf-8?B?M0lzOFRKcU5NalVtV3ZhalhvQ1RnVkFCOHBNSDdScmZmMmYxZkptV21jTzkx?=
 =?utf-8?B?TEwzREZjYTlEUGs5ZXJyTjhhWWovUnNsQ3duM3BQK2pYdlkvNzBvdzg5RWIx?=
 =?utf-8?B?MEJ1aGhhT3VqTkh1THN1dnNmdW50b1lqT2pJbS9KOFRQUkMyOVBPSlRXN3V3?=
 =?utf-8?B?c0FyWW1QbFVndzd2TXpGQnlZNm9UMHJNMmhOck5Nc3ZPQ0RZRm80TThOQjlr?=
 =?utf-8?B?OGhtbWorMGxLS053TDEzbSsyRHJ2b0plempFaDE3VDdHdVVLMHBHR1lHZ3gy?=
 =?utf-8?B?aGcrTTJnRFc3MDJoNTZTUjh3YWZOdjRobENucVBPclFmZ2d2S2RJVzZnS3dD?=
 =?utf-8?B?WkQ4RzZ6eWRWRll3cHlQaG8xQUk2RWk2VEU1WkRib0grWlZNNzNONXY3SDQv?=
 =?utf-8?B?M052VWY2cUdOQm0wRytIbkg5Nk1CWlFvTFdVbkEvVFBmRlk3bmE5UHNwbTFV?=
 =?utf-8?B?aE1COWlJVWtydDBnN0FXY1RINmlPNUlsRFNUUjRlZytBZjIxZWhhMEpiRXRN?=
 =?utf-8?B?SElZK0d3U1ZPQUhxN2s0bUNMOGhBQm1iMlF4Y3R5aGJrY0RwRnkzZ1BGTkd4?=
 =?utf-8?B?a2txdUptVDg5N2kvNGowVElram5pclpRUXBqbzRnL3hnWWNyaG50Zmx0Q29F?=
 =?utf-8?B?UXBQaVRpb0Z5QVpxNVJZVS9pTC9DMmpyblFwQ2FhTEh0VnlMUU81enlmWlFm?=
 =?utf-8?B?U1U5SGFKUUF3VlNnUVozdFh1bFRseEdoTElhMEFtQXBESkVyRnFCRWtyU3Vs?=
 =?utf-8?B?UkM4cjMweFprYnl1OWxKd0hnVzVOUzNNL3BCT2NSRVdoeURqYUx1QWh6QmRH?=
 =?utf-8?B?SzJMdFVYWGx4OGZTN1lINEEzK1MzbmFZazNhcUp4V3d2cDJvUGJYYlJWQmt0?=
 =?utf-8?B?T1F1RVBWYjh4UkhrMWtyNTZsUkhkWTJpNlp5SjBKd0VwTXRRL3Y3SkJ4RXhC?=
 =?utf-8?B?YnovYzk3UFp4ak1pcUJsaWY2ZGhWZldMVGZaVmpQd2ovYng4TTBmVjI5ejVB?=
 =?utf-8?B?ekkxT2RsakVCWGhiTVlySDgzV3pkM0ZYTlJ5U2Z2NWE5Z25DdVFEblB6RVRu?=
 =?utf-8?B?SW0yV2dFL1ZDdzI4WXc3dUI5K3MrV21kdkloOThWSlIvYkQ2RVlneHlxZDZu?=
 =?utf-8?B?aDFXbWs0ZkhNQlZmM3NHTW5SMjV1ZWRwd1IxSHg0TmFDZFplUEJpWWhyZ2VK?=
 =?utf-8?B?OE1EZ0J5ZS9iY3B2UTU3OU9hRjMzMGU0RU0wNTdaMzZjTndUUGxEOGdpOTlR?=
 =?utf-8?B?bzQ1ZmEwek9vdE1ZUE9rY2tCeFFPck91ODRCVXFKK0ZTVTI5U0VaV0Z0eHpm?=
 =?utf-8?B?QWdmaCtzRGdBL2FIZGkwNWVHNEFOcnVzWVkwMjlFVVJLc3Noa1h5aTUzL005?=
 =?utf-8?B?QzlDRmdaN3d1TDU2MWJXdVo0Y2hJY3Z3azBCdzl3MXFIWW9sU1k0YmhlQ3Vw?=
 =?utf-8?B?ZC9YblJudWRla0MvZVpwMjNEa1RRaGIxdGpFUWxEbzFET0VQdHBQWE1pYk4x?=
 =?utf-8?B?MlZvbExZcy9UMVJxWEdDMXRqUXRaeEo0S0pSSXd5RE9GWHFIQVcxSGF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEU4VXRVUENLZ3NScEtBU3diT1V6U2lySzVYbTkxUlR6REFKQURXTEJiTnlS?=
 =?utf-8?B?S1o3U25mZGlTOTI5YVlFWUxqV0gxemVyQ3FMT3hkUVVJM1hDalVTcUJNMmZh?=
 =?utf-8?B?N1k3WTJhd0taQ3BPSVJPQ0daMzJXUjhaaFQvYktBempOa291ZjZuSGYzSG9v?=
 =?utf-8?B?bXdTdVpEdFRRdnVHRGhZKzlmUWNlT2NxQ25ZamRTUEhtayt2MmVaZlloSHVP?=
 =?utf-8?B?WUMxTS9lU0pOZEd0czRCT3RLcGVaL3psbm44a2xYUzdVVUNtQUZNZTRGVHdn?=
 =?utf-8?B?V1UxMFppV3ZRcTVxOTYwK2s3VmhDTjhLYU9UcWRuOVdMYjN5RXJTKzBUL3Vr?=
 =?utf-8?B?WlpraFRlcldCc0VMTWd5OGlnN1didllvUlprK1VsRWt6Q2xQWHNYWm1QeHBI?=
 =?utf-8?B?ZFhneWNoYXQreUE3R2doVzZHbzRGSTRmWlVNNWpkZEQwbDdqMHN4ZmZTODhx?=
 =?utf-8?B?Mkk2bWl6UWVTbXY3RFZyWFNscGtGNFRtYWFTZFdVMGJnL3ArL2hDZTVLZDk0?=
 =?utf-8?B?V01YVVJVVUhKS2pjQ0xBbklaYUx5LzlQNUU5cWdBanJlWktMUlNlODdTMG14?=
 =?utf-8?B?L1dmRlQrekRRRjdtZXljd01UTXJPb29aclBaNXQzRlBNOGhBUWtNMWZiRjlI?=
 =?utf-8?B?d0ZHMk5LRndyRXFoTmdEUFdXQnBGYjd5S2hSMTRzaWZabDUrcW82RitmQ0pw?=
 =?utf-8?B?N3VyN1I4bHJnbHpHaElYaWxsN1JqSmpJS3ZXeWZzRVZZK0kreHU3M2Nzc1N5?=
 =?utf-8?B?TWtjSWNlcnRnU2JSYmFxa0dKaHk3YXBJbGlGem9WdDJTY2NEQ2U3UTkwdTF6?=
 =?utf-8?B?YlVDRExvSEM4V1ZFTXdpa0xuUWFqZE9EUmF3aXlFNDcrMzJDOWN6NmZWbmJN?=
 =?utf-8?B?TktwWGJJV003MzQ0b2lqb2dKTXlDSjBPd0t4Q0sxSHdReXlJaGN0cG5QR0E3?=
 =?utf-8?B?YmlvSkxmbExIRldwSFdzaFFPcEl6TFVrekI5UWk0cmZsZzgxNXB1NVpuNzU1?=
 =?utf-8?B?ZFZMNHNkazFyeFc5ajJhSDRlY2tsQUl0TFlvOWh1Zkdwa3ZkZkttaU5MczdM?=
 =?utf-8?B?MHJCMGRiWmxWR093QUdwNkFhUldha0ZOcTMyYWl6Ri9lZnZEcGxRSktvV3RU?=
 =?utf-8?B?Z3FDVXgzaURLNUN0ZlFhQWFWajd3Ly8vRy9jRjYrUnJVY09Kclp6dEk3d3JI?=
 =?utf-8?B?Ulk1RVNhQTdpQm42SCtMTGVGUk5Ud0tUakVZRFlyM3dyMnpuZkpqTHdiazlh?=
 =?utf-8?B?aWpnemlRMlZsMGlNRWpWNVdONkloRFdCTndUUzNLbWJsb2hFM1UyOURXdHdi?=
 =?utf-8?B?ZklnTEVFd2JjeUFNV0tvRllKSTc3bDFoZjBHSmwrbi9lZTBCRHJ4bnd0bEtK?=
 =?utf-8?B?aVRWeTJRMlROeUQycXB5c3VaaVg4SXFHM1d1SHh6WFRRY3BIa1lsb1htMFkx?=
 =?utf-8?B?R1R6R2k5U25LZUFOVlRlZFdJWVZIbUgyM0RhME4rbXlvUGJENGp5YnY3VGZw?=
 =?utf-8?B?RmVnS25PZVJQblh4OVZpY2NJazRPby9CbE0rZVl0V05veXlXV000em9iUFJm?=
 =?utf-8?B?bW9yYkZoQmtQUHVIK3hjNWpjZmNDL3hnRWx2dElSTExjTkxKdHlsTEtZSmR5?=
 =?utf-8?B?MVZYRk9KRlNIQmJEdmQ3ZG9MSmMybUVkcS96VkxZcTRYVlF4clhqNnFYa0ts?=
 =?utf-8?B?eCs4L08rWXdTU0pzZjRidHpvYy9hb0V3WkhUNmFFUnU3cmxWTkJPelJKZjRi?=
 =?utf-8?B?SkJFU2o0Kyt6WjdtbTl2eWdleWJGbUZ4UXRUMUtzNCtRYlBoTjVFbDhoMnhq?=
 =?utf-8?B?MVZMZUYvTW04S3pYcXQrMmxqa25aM3NnRkJSaDFGTGF2MjFJaXFMaXdRWGlJ?=
 =?utf-8?B?bU1hakV2Y2R1dzRhd2JSakJNNHZuSkJxZHZkeUF5UzRHQ1pONUlRcWtlQ1p6?=
 =?utf-8?B?bWQybUI0K1Q0eTkxVStINW9aempSaERTNlVtVU0wdVpJRndzY09BYnRzZk5o?=
 =?utf-8?B?QjVyRC8vV1d4WDdscG9YUTUwZ21yOGVuTGlOSjFhUVpLd2xsRjlwVmlYZEU4?=
 =?utf-8?B?K2dIVGc5K3FIRGpLekNCYmV1ZS9zNldtS2E2QTVqL2xGNXE5STFqakQvcmdp?=
 =?utf-8?Q?B2jbPvTZcInEZmcb/s1FUVC2u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74212f69-6b0b-4f82-1b3a-08dc80e9b96b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:47:30.7623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUdgPuVgs98aJT06o64c85z2C0N9RbGszq3XO/Zea+0eqacsl+TWHAJBeXcXt/Dz5vTe5cWTVMgMtF12FrtGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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


On 2024-05-29 23:47, Jesse Zhang wrote:
> the expression caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED
> is always 1/true regardless of the values of its operand.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Please add a Fixes tag. I think this is the commit that introduced the 
problem:

commit 75de8428c3d632eacc7890b7cb39dbec04d286c3
Author: Jonathan Kim <jonathan.kim@amd.com>
Date:   Mon Aug 21 11:47:47 2023 -0400

     drm/amdkfd: enable single alu ops for gfx12

     GFX12 debugging requires setting up precise ALU operation for catching
     ALU exceptions.

     Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
     Tested-by: Lancelot Six <lancelot.six@amd.com>
     Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 3f27bab7a502..4abd275056d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -503,7 +503,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>   				kfd_topology_device_by_id(target->pdds[i]->dev->id);
>   		uint32_t caps = topo_dev->node_props.capability;
>   
> -		if (!(caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
> +		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&

Looks like the same mistake was copied and pasted for 
HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED a few lines below. 
Please fix that as well while you're at it.

Thanks,
   Felix


>   			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
>   			*flags = prev_flags;
>   			return -EACCES;
