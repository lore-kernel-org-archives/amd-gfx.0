Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A35CD33990
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 14:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801E710E4D6;
	Mon, 28 Oct 2024 14:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4o86VFJs";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB89510E4C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 14:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOxuWAIGxcCxI7cf0wJAArnPbaPRX5hH7U+0fjkRodSsemsRB25LvyHbGhw112XuDwswuZQrpg07PoqlRNpCSe8UewL4xpTNCaHl36mMegGVlL57Q1sp/pVTkLaxeEa8DVzwMr5Um7FiVm9RT8mc0Hon9ZeSyYm6anxRaubqFq6MrOli3Bu4M7Z4F6tFLnAwWP24nlTttmiR6+O9szier1J1j70FFxnlcniMeSzi1eJOj8/usGI/TbZk1XXA/OOfaUMLgZ1pVDTPZW8nVOLVvvB6+0t2nCMaqvRhliILxIturZsQJqgSbfQP/wSGFdjcphFxvdW7oRI/z/yzQOUTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3MdkcJL+iQwFzq4VKLAdGSQxe7fav0cdbroeb/Ux+o=;
 b=E8AwRXU13I/Fwq8dZVW2kjx7m6y3ZMZuIw0mXyj5+KTGCBzjJVqss7AsFiJ2pG1rfbjNhYd9UjepdUG99EfdKzvG3p1tSNwBYAdmRqU2Yqal+gAU4CdII7RfRRkEj4IvJvdls+T7rdNBr0N4eTaPXCbB4M5RAY4MDmiWRGC1r9vdYtyQK42VLcfBva8TF6FWkbgClg6fA8wj7y1CdgHYE0AZEB+MuRM8EdVK8Ui4I1hEouIwXOPHyVjnbnVcsxz49R6YTACWrtEcRVIl6xBglM3JSJz0KP3Ys0doM4XGVmRnPDTur24N7RriclUHLiSI7Mdj2yRLuQY95AMG6ynQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3MdkcJL+iQwFzq4VKLAdGSQxe7fav0cdbroeb/Ux+o=;
 b=4o86VFJs+8VBqqXBju36NOOWyDsjcp3L8IuzPO7QeJmnnxxUwulZcYoUvhXH5uCJRHJ1CXc+FSDnxRJphuz0e8MncNd6E4SPu1oU+71Bc/W1Y85uA4ksz51aOI1INoOUiOpuP3v1FizLvt7qsX8zLzPGAK918KL5FkAKR2VX88k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.23; Mon, 28 Oct 2024 14:38:43 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%6]) with mapi id 15.20.8069.027; Mon, 28 Oct 2024
 14:38:39 +0000
Message-ID: <922d37b6-c8c6-4e30-970c-d15f9d160fd1@amd.com>
Date: Mon, 28 Oct 2024 10:38:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: flag per-queue reset support for gfx9
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241022173657.2363931-1-jonathan.kim@amd.com>
Content-Language: en-US
From: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
In-Reply-To: <20241022173657.2363931-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0059.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::16) To CY8PR12MB7099.namprd12.prod.outlook.com
 (2603:10b6:930:61::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7099:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8863cb-8b3e-42f1-2299-08dcf75e3640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkdkMzZRemdPNUpEb0JuT1k4dEZESHk4d2dwbkN1OVBqUUs0dTlqTUhaMGhi?=
 =?utf-8?B?U3I5emk2MDNVSFNmSXYzckl5T3ZhSFluTnBtSDIzTmlDeTlxcXdNSnh0YURS?=
 =?utf-8?B?WlpIV2FIR25vUzRqZUxFRTNma3dReTVML0xtRG01UldFTm9HVVVLWkRDbE5E?=
 =?utf-8?B?eXByR2hmbHVueUJ2T0JMaHRpMFdSNllGckRoRmtpUEhkSHBtZHdraDhRaWVS?=
 =?utf-8?B?MUtNdnZoUW1YbmU1blpnWHNTQ1hiSDE5WG4rMUJUUkZjNFR3NldGbGNJOGhx?=
 =?utf-8?B?bTY0TmwwNlVRQTV2dm9lME9KeUpzSldIbjZ6akhpZHhicXREREF0cDFkeGUw?=
 =?utf-8?B?OVpueUNKVS8vQUEzVWpHdVRWWFAwK1NTL2MxWkFxTVNqeEUvS1gwaDNJMGx4?=
 =?utf-8?B?SzNMbFhLMnNtamEyMUd3amhMcEhGYWhjTU43RmtPdkNjUVpEVkFoNWxNUEpz?=
 =?utf-8?B?VzJpYUljZ2JoeWt1eVdQWVZXSE85TVg3Qk84dXd4aHZYV3ZhL1ZYc3U4MldO?=
 =?utf-8?B?aXlkZ0E1cTBUU0prRmFubWQ0cXFXdGNUdFhpYU1qYjJsOFNCTDJIV3k4UGF0?=
 =?utf-8?B?aWVYYVZpbVIyT1BHRVBOcll2ZU5HOGhtUGxlMW1oazJmNTFnMmtIb2FDT1du?=
 =?utf-8?B?TTU4QnBZUDgwd3JjVEJWcU5DRUswUGNlY1ZpeEI3Z3drWFV0UmFGR0pjeUpF?=
 =?utf-8?B?TGttRXBGLzFwSVV1N1JZaGY5cEgvNHVzdEF3RXE4eFdHc2dwTTcvL1pZWTZx?=
 =?utf-8?B?UnJ3QXFGb2E1QnlsalIwZXNVOVBYeWczRG9veXlYaGRTTEZvcHNvNzUweFk3?=
 =?utf-8?B?WlpzZWllMnhMRzJ0c3JzZDB0ZFVDeGgwZVJuOW00Y21GTzh3bWZTa3pPQUtO?=
 =?utf-8?B?R1ExMTcwTVBEYVhYMDliOE92WFI1QndxYTlDbVlGUFhXaWk4RndNdzVmektL?=
 =?utf-8?B?cmcxWE1RS1VxVGZmblN2cFlQNXJsS2U5Q1Q0b2VVdmFsN3YxUUcwQmlqQnhv?=
 =?utf-8?B?eHNpZGtrR2RKQWJtcDViRzhTMHFYa0h1ajFkWE1paFpDa0lDOEhRcXJUTzU2?=
 =?utf-8?B?QXcxUW5Hcks2NE1HWkNCNnY3cmFSeUJZTGc1Smtud3JQT1lPUEN2NlVRRVlV?=
 =?utf-8?B?TDg5QWFzSHgwQ1hJSUtIcG45a0NFN1UyT1VBRG5RUmZRQlBWMDU3dUZUOGRz?=
 =?utf-8?B?TkFMbnZPVno4YUlOdkZwY21TYTl5UVJmNEdmb0lJQnZQUmZ0aEpycEJaVmxy?=
 =?utf-8?B?VnFYM2kzbzJPOGVnUnlTQ240bjkwMng3b3c4cHFvL2thcytBNXhtMzg4aG1U?=
 =?utf-8?B?b1N5M0dtUGNoWlR4MEpqa3RkaVdWVDkyY3JmM1p5LzBJdThJMWh5UHRJdlNE?=
 =?utf-8?B?OHlQN1RYamhrNWJLYk55blVEVEIxWUJMUEx3RlRWODdMVkZ5NWsyNG8vemxt?=
 =?utf-8?B?cjJwcmgrQTlraHVBOE1LTm9aK2prVTkzYXBtTmdBRXYyUmtBK3JDbktkbDBh?=
 =?utf-8?B?eFlrU0NQNkpkKzhTT2V2OXMrcmh6OGpOa0lkdUFCRWdWSVNYSVFWSVVleFRa?=
 =?utf-8?B?eW9MdnBlNmVXVklGancrQ0dNb0paM3VPYjJEUFNoYkEzNXBBZkM3bnh0TXdR?=
 =?utf-8?B?eGh0Mko5Z0crblRaVEhIQlVKcEMxOXZqUW1OWTkzMzhqS2Vxd014K2h0RE9l?=
 =?utf-8?B?d2ZGQjBHb1IvMzQydXI5OEFab0FTeVZrdnZ4YS90aXN1dWNxaisveUxrMWFU?=
 =?utf-8?Q?w+prprDGxLtUzd3inwCSZpho/vaBTFliyj4Q15Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVCVTNBMExlYXRHRU9TTUllR1kwTkFLNXBaU1BFbytQbUJaMGFiWFUvSnJG?=
 =?utf-8?B?dUpOa1h5REhOVXlqcEsyNVdna2ZRb3hYa21rVmovbVhmUjc2UmhySVRqRW84?=
 =?utf-8?B?K1Q3V3FzVHNlb29OQ3Y3Z3pFNlMveU9ldHpZWWZZbWFMZFlOQkkvOXZPU3hu?=
 =?utf-8?B?LzFPeTJLL0JMSitIb2lnVWkwVnlFYlBGc2NaeGdFK2VlaHdodFA5MXJtM3J5?=
 =?utf-8?B?cWpoS2FvUGJlVmwyWm84Q3BOTHlCNHVBVkdTTFBCNi9rYkNKTG5xNWFvQlYz?=
 =?utf-8?B?NTJiK1R3YlJtcDFTOXdQWVVOYTJFMEJIb1k2akN4L1FrMXRDdTlSS3FnWmxs?=
 =?utf-8?B?S0h1c3I3eVZNMHZwTUMrWnh0cUNZS3dVakJKUTc5RGZKNnpWMENCcUFjL0J2?=
 =?utf-8?B?cGhoTi96eUhrVGE2cVhBemNoT0hOdTV0V2F0N2tjQTdybkJsWW9IVWhyOWFQ?=
 =?utf-8?B?QWw4dVZaS1hhS1BncEVwK1NtUG9kTFNRVzFtYm9SaUtYMExGdFpDdDEvTnN6?=
 =?utf-8?B?dDVJelErekR0SzBOWks2Qmx4bEhYdzZxWjI2a2ppajlDeDJQdFF2cUJVS1FM?=
 =?utf-8?B?QUNYbGI4bnZxYkRuTzE4azJRWFdJYXRCSllXL20wejFSM2hzREZUK21pdGp1?=
 =?utf-8?B?NkQyNU1VYlZ6eXAxVVk5UXpoQzZSSUx2ajZZNUFEdGRNNnFNYVpxRjhXUm9h?=
 =?utf-8?B?bnJrWUxIeExXZVFvT05zQmhNamg3cXFNNEk4Ym1haFZTenlwcHh1VWFYYmFP?=
 =?utf-8?B?SitMTlRydytXR1h5eEJTcExPd0EzQ1M4NERhTUJLZlAyTXljR2lPWTI5czVB?=
 =?utf-8?B?RjhoZnNMMzN1WTc0cCtycFlWN2xzelBpQ1FpOVBnU1dMdCtTTzdhK09xdHJp?=
 =?utf-8?B?eWgzeU1HM3c1ZEZNc3RvTjFWYlJrK0xUL1loVDdlYW5WWXZvNXZ2dWROblVK?=
 =?utf-8?B?aVAyT2c1c0RqYWdqRGZiaEZpVFRUT3dyNTdVeDhIOUxlem91bTZoVWFzNzlm?=
 =?utf-8?B?d2x2bm53QWczb2NkNnNXRGFaVDNXbFEzTzZGMFF5RWkzWXpKQXRzdTdYb29u?=
 =?utf-8?B?dFUzMktTN1ByOElsK1h2aW5GWTdDUlhsdGNTV25RYm5SSFZmK3I3bGE4a1N5?=
 =?utf-8?B?QUgrbVZjTFJXZzZtWmtLMFExZVZGbnUrQ2U1YTVKMStPSFp4UXZvcys5Z1Zv?=
 =?utf-8?B?TFBGM0hCRWtDbXdZNWtNZExqRnV4S1dWM0s0cFZBV3JPdVZnd3k5b0o2bjJQ?=
 =?utf-8?B?QjZ4dGpSQnozbXlSZ0MvUzcvS05ianZpa3M5SkdoRlRKenJOOWZaNFhOVnZm?=
 =?utf-8?B?R0tpYk5KM2YyQjk1aDQxU2dyRnliOXgrU2FWY2ZnNVU1THZ3ZEpSOFRJYTMr?=
 =?utf-8?B?b3MxTXowV285NHV5UEJ6UTlCOElNR0hoRUVpdUV4V0RGUlY3KzZyRHM4V1VL?=
 =?utf-8?B?a3JyZCtmSFBEelpwR2ZWY0YydmtreitBZmxkVHc5WFg1STlhZE4xR1lsQisv?=
 =?utf-8?B?NnhTY05NakVZc1ZVbDBVQ094RmRqNVNLQ3lPanZZbXY1azk0MG9nZkEzUGFL?=
 =?utf-8?B?dk1uNnk5L24wK2pheGFRSzY0V2JiWGZpcERCUXdRckhzUE5tWHgzL1BLUlZs?=
 =?utf-8?B?cWtXZFVESDRTcFE3Tm5QcUZucXBuTXhKV3psWFRoVVp6eDJRcWdWOHl3R1By?=
 =?utf-8?B?dWkxUFFMOVJETDFIZFl2OHVtV2F6NXBJWE0veGk0S2h6YzY2SmxNeEl5Tlp2?=
 =?utf-8?B?ZVJON1NKbXY4UUx6bXFmakRQb2hGcHd1OEtsd3J4UDB1Qmg3K05iV3MzbUJT?=
 =?utf-8?B?bjVmOXRyNlBJL3J6VVoxQmpzTHFBbG56YXlLaFdVajlpdE82cVlaejdsbG41?=
 =?utf-8?B?NDV4N21YT05tTFI0dkMwenJwMXFCRnp2Q08xYmMyY1Q1SFlZVXo0MmlVWnc3?=
 =?utf-8?B?dTJoU3BCeVQ5R1RFZHlvQmgzcms5UUplWWpnM1krWE5WdGdrSmVTYzdEL2ZJ?=
 =?utf-8?B?MUhpNVh4ZmFOQyt2Y1hKZmtmczlaNzJ3UnZ4T0N5Sy9Bbk1aMnZDb2xLSzN1?=
 =?utf-8?B?LzF1WTEvWWttZVJOczJjbm9tQ2hWQ0xTUXB0NjNWVi9ad3RjVU9scWpuZjVq?=
 =?utf-8?Q?01/t2nhWIta6MNYmi+gR4wvDh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8863cb-8b3e-42f1-2299-08dcf75e3640
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:38:39.0527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O1DKhXmHoR5d6zIIJZUznMd6E6bivLFKCK4OC73sbks8703KWwHA1xj2Q9sQfxHmfa8ddSLRgX2U9ds7RoK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


On 2024-10-22 13:36, Jonathan Kim wrote:
> Flag KFD support for per-queue reset on GFX9 devices.
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 ++
>  include/uapi/linux/kfd_sysfs.h            | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3871591c9aec..9476e30d6baa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1998,6 +1998,8 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>  		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 4, 2))
>  			dev->node_props.capability |=
>  				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
> +
> +		dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
>  	} else {
>  		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
>  					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
> diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
> index 5e8d28617efa..859b8e91d4d3 100644
> --- a/include/uapi/linux/kfd_sysfs.h
> +++ b/include/uapi/linux/kfd_sysfs.h
> @@ -60,7 +60,8 @@
>  #define HSA_CAP_FLAGS_COHERENTHOSTACCESS			0x10000000
>  #define HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED			0x20000000
>  #define HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED	0x40000000
> -#define HSA_CAP_RESERVED					0x800f8000
> +#define HSA_CAP_PER_QUEUE_RESET_SUPPORTED			0x80000000
> +#define HSA_CAP_RESERVED					0x000f8000
>  
>  /* debug_prop bits in node properties */
>  #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_MASK     0x0000000f
