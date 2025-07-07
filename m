Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D315CC83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 09:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8F610E315;
	Mon,  7 Jul 2025 09:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oiIbfITB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ABC710E315
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 09:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giBguPWW/OECMrSsEA7Cb2EV0Z8Z5T/V2LuW8Lszh5pG2cbn94AC/KLjJNdMdvB/F0h3pllppbe6wtdgsh9wJbiVN5+V0arnSZKKV2UJvql+b0vOLdvAzUQVUnb4liddz019fvZusNva0o+HB20+/nuZY+jk+K1Qcz6xFFGcyaw4BtLZPoCVc7U8BHlVuECylHKSxoV5/vdehAhInVLHll6le1tdQEwNASXKtcvucA3BZdEjIiSGi5JIIJQAchjxo4I1lDCJzrlHA60lc8qpQ8UFVm9DjWkvY2T/gb9uXrNmifXR+oDHhpRj9FkWiN9ACidRCi4iJeg7j9uzpEQO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxmjXfPfeKjLyhtLydSs7E3PocSuGRanItjdpgaTxAY=;
 b=iecRv/iGRzMs2zyNbL3YhdjLPtPfT/qkdX1F7jGDqGQpbGnm7PSPRNgfoPJd4Y3KZPVRcnzFPfCiv/HjkdcEcyd6ePIulAlTumuwtQdJ0Q0ErgmWFKhowYXt0QAgXv9ARrsDyG8cP00pfwPa9agw479R/Idxtg8n13Ex2EtMUUiUgD3KQLbh/CoFwb0Qv4yCxNMx/qSOsj5s6/ZOofYrAxwUGNm3rJkuvCbDSKe9UxhM6w7ypoKtVBUb4NRhkQdor8GpPZOD35s0Iwn9ClsZLedkjXYWDDR9ehyPZE4c1A/Y4MJqrN0aNWm32A+PrckxPmkKx7Bw2T913FuY4PnfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxmjXfPfeKjLyhtLydSs7E3PocSuGRanItjdpgaTxAY=;
 b=oiIbfITB0gA3Fu75G6SUEF2/XUOfPxPZkpRu0QxEOKKRZXE6Zgo7JZh2NAXHFiV0bx6g5HKaV+wRu5Vh6j7t2MtoPt7oQ3WODqjCpuPCPvVAZ5S6hF4TeTaIQoGe+Bro3QIOe8d1IHzJfOvFJcHvQ4Y2GW+zhoDsAZb7lb5uAjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 09:23:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 09:23:04 +0000
Message-ID: <b5cf1085-5a0b-4b32-8e6a-348f173a247b@amd.com>
Date: Mon, 7 Jul 2025 11:23:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace HQD terminology with slots naming
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Marek.Olsak@amd.com
References: <20250704072657.553572-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250704072657.553572-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efdd299-6805-4cae-0cf2-08ddbd37e098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlNkcWJ5WFRWT0xJTktrSUljN00ra3lWajJYSlFkVGQ2WDN5TE5jczNXYmNK?=
 =?utf-8?B?VHJyT2pYMk1KVmRWaW5HOTZxWnQrd3ZIcmFnV3hxOC9HSHlGKzRxc2pXcG5W?=
 =?utf-8?B?bjVPZW11QjAyckxKaSswN3hVbDhaTkQyZ0t1L0EzMzNHRGw5WnZGN1YvNjNU?=
 =?utf-8?B?R09JMWlvOWFsR0RFQ0t6UjZac0xLUHhvWjM1TVhkSzJEeGRvNFlnRXRqbU52?=
 =?utf-8?B?dUZialF1UFp5cWhqc2k1TXRRWTlpSktnb0F2c29HcXJESExXcVpmWkdBMHJ2?=
 =?utf-8?B?UFZMdEJFOHp2ZWNYMWQ4TE1HR3pPaTBYcXVuWXhvaUZENUQ0b3lyQ24xZDhL?=
 =?utf-8?B?M2EwaFZPSXA4cU9EQTRJOU5DZHFVUmU5YWZHbWhRMlhWemRBdlkvL3hEaGJv?=
 =?utf-8?B?VDN1OGhDNzNtY2lvL0paTkxHUUNWNUM2UElGN3JxNHVEZzJTZDNGVHdjeDFv?=
 =?utf-8?B?K1RJRDdlMXFFNzBKVnJGdmllODFkd2NxSXFlRzc4QUQyc2tyNm5XeTVKRFl3?=
 =?utf-8?B?cU1kcFJmY0FtN09oMm11NGlwT0lvNEtLZXAzSGx6M3kvdHRTd1E4djhlMDd2?=
 =?utf-8?B?bnBNSnFacEZ6Wkszem81U1Y5elo3VHFRSGFvK3lPeUlQbU9kaGJ1bFFhMmVB?=
 =?utf-8?B?QUJ1VHBIekRwNXloUE03eWcrZE43TlRNaDhtQTB4MCtyaXRLWmJsaVBrWmJO?=
 =?utf-8?B?NmEvbjJOa2tFOEUrQ3pJSkJnUXNqNW8zSDNSa2ZqSHNtMlBFWHdMTThtUDA5?=
 =?utf-8?B?cW1xSnpIbzdONWdxSUlnMGR3emdlT2JVVEh5SkxUK0xTMUFpVUw1dTNCck5n?=
 =?utf-8?B?WkFtaE90bkFmenExbktwLzJmZ0VwUTVJem9ZbXdZOXRadmZHblpyaXByVG9o?=
 =?utf-8?B?d2VuUHF6SzNrVG9teG5iS2QxMllsQWluSDFNbUU2dTMzZk5kTmRhYTQ1VllM?=
 =?utf-8?B?Tjk0ell3emlsNjlWQVViZ3V2a09TMTRSK1FUSXliVld0bmp0dzBTRFdoUjdv?=
 =?utf-8?B?Nm5GSkM2Zk90QUhaZzVvZ1gyOWZ6U0FQUEwxbTZZL09rQWVTWDR4OXAzeWY0?=
 =?utf-8?B?enYzTzBYaENrL3Fud0JyTUw2Y1FSUDlEdXVoR3ZzcTI0ZjVpbldhVWtUYVcv?=
 =?utf-8?B?dVUzNXJmWEl2Nzhsd0JQWm1lYWtXWUphTC9GUlR4QWFnNmpJWEh1RE92aWI4?=
 =?utf-8?B?VGZmUW51RUlWNlFYQlh1bTZ5bHlsaWRsZlpBMEVQOUw0VVhta0hVWSsvdS93?=
 =?utf-8?B?SEhMM1NEUkRCa3crVVdCcTAwRnkvNXc1ZitZL1h5OUhObmUwdzZxcnBVNE8v?=
 =?utf-8?B?N1hlSlp4SzZxdmJJYlM1akpEc0grL1pBZTdqaWNHQUp2VDFobnpWVmo2dWRa?=
 =?utf-8?B?N2JGNDZiakhaUGdadFdvVHpOT1FIWTF1Vi9ncGtUOExyV1NqejVmelhOczA4?=
 =?utf-8?B?RUhxbWtGNWZFR2VOV3hRa1BtY2ZBMEJZNnVxaWZRQXNRbk9nNWQwV1dMZzkv?=
 =?utf-8?B?ZGJuSzFhUlhMNlJkallCOGpocmxvbDNWemh5SVZGbDNOSXc0YmsvSlhzMTdK?=
 =?utf-8?B?WUlnbDMrazNmaDFEOUs3M0NBamRUaWtsOHcydlhnR1BwR3hjYmYzbkJPZ2w5?=
 =?utf-8?B?OU5hd0kvUDI4Nm12ZmZ0a2tRb2VCeUQ0bk5pN05xVTZibmNlckZpNWdTVkJn?=
 =?utf-8?B?T0J2RUtpdmRNYytBRnVmQ2g4N2l4UlFQOEhyVzBDb29ZWnhxMUwyNmZrKzlt?=
 =?utf-8?B?d0lRT29QeW1Ed1FDNjhQS0ZPT3FXR0lqUVhwQWtVTXQ5bndRUVdiazZ6N0Ew?=
 =?utf-8?B?cWQxeHJUUDkvbEUrdDg1Mkp5bzZ5VHZJUnUwbzhPanJLQUVvcHRSdFNzeW1Z?=
 =?utf-8?B?T2ZucEJPOUxMRy9leGFlWGR2THF2QWJ2OU10SzhZcHQ1cWlsRDNNRUVtc1Q1?=
 =?utf-8?Q?Z3tsu4H0yZw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVtRlp1Y1NTenJqMmQwYUNQemNoKzM0SHNKTnhkT2JwbE5teXloSUwxUGVv?=
 =?utf-8?B?U3FoclpRVm03T3JKc3ZSYWhmd2VpVUxXQ240NndudkhnK0tyUlZZTE81cERx?=
 =?utf-8?B?cmZkeUxkZU5YNGRNUjB1QW5YbEFJMFlRV3ZsRGJGYi9ZeXhoVW85MHFQQjlx?=
 =?utf-8?B?NFJ0SXp1NFFrTVFpMThGQVRVYTR4Wk9PU0hMcDdTaXF0RW9NZ2paR25uaTF3?=
 =?utf-8?B?ZmRvZ1lYWHJXOCs1Z05DNnJaZEZpaE9PclRvcklIZUd5Zk9Zd0hZKzRRMGln?=
 =?utf-8?B?VDR4Ry9RbUttM0VLUEo0ZVlGQ0JmMHhmSzkwYUdRN2VaeFBTWFZmSzJtTy9L?=
 =?utf-8?B?bUFiamIwTStWZ1J5RytXeXFZRk5hbEVQaDhXSG5CbUZOK2RHaGxVOGpscEZo?=
 =?utf-8?B?NEM0eGZZWjd0N2VyazZvNko1V0I2SkFDaG01eUkyQmszK3A3QkRLVjhUTS8v?=
 =?utf-8?B?YXQyMGNCN1pBcTk3bHlUWmJtZHNSTTJUaDc4eUJNUTNmVlJ2Umx0aExGRU5I?=
 =?utf-8?B?bFJXWmtOSlByRXE0QSsxc1FYdjUwM01aYU5GRDdwMzViei9oelQvcmV1blQ5?=
 =?utf-8?B?alNoTHN4VXlFRDZrS2pDLzdyS2MwZ3dRbHlBdTV5T2g3eStKSmtnbUFpOHcy?=
 =?utf-8?B?VVJXSnF6YlRIWkd0MjdGMC9JYkhXVW4xaTFqMlhCenMza1JxTkNkc0NXdSts?=
 =?utf-8?B?VlZXTS9nYkp4TnR1MzdzdW1kNGhZWWdVdERqUU9WRldKdVdqZVJJVEVySGVw?=
 =?utf-8?B?WWE3YVRPejR3QWVLWlBzbGFnZTBUaWNENmVndkVtOTdXdzB5Z1RNZTUzU0RE?=
 =?utf-8?B?OXA4REZUdEZjYnF0WXNyc1hydWNHRmsvSmFxWTdRWkRZdkRieW5qWWxoUFlN?=
 =?utf-8?B?c0xtZnoyaS9xNzhVT0FFMXhaaUJML3J2SWZwZFZIZFZiNUNVWkprQjQraUgx?=
 =?utf-8?B?UXVoS1FXR3JwQkVzRVcvU29kUlExNVczZHdyUDVQTUZZTGtYTzZjSXhUMktU?=
 =?utf-8?B?Z282M1JJUzFMRDdXbVVmRXRPUnRIbGRNTHh2Z2s1WDhleEdGZHpkNXdrd0Nj?=
 =?utf-8?B?OEFzYzJ5R0F6VytNb0doVURaYVJLRGJEcUZMcmRSbnZ6SXdCL1NJTWsvM2Jr?=
 =?utf-8?B?eWRxelNGajVHYzh4MHg1L1BZNUJ6cERhdGJQZlVFaE9FaUlCcTdzY3l3c0lV?=
 =?utf-8?B?cGdXS1pNRzlwNFRDRDhVTExFb2VTNTZQTW5NcFFYVFN1SDRXcldQU2tBdG9J?=
 =?utf-8?B?U0U3aU9QeXZPMkttSW1EREJxc0lOZmU4RzN0V0dGK3Zwb2dmNTNMeitYVTEv?=
 =?utf-8?B?L2ZRUy93OWlYWDE1WGRoQmRZQWZNU2dma296ZlBaWVUzclNjOFhkM1I2TWtj?=
 =?utf-8?B?aENCUDEwQVlOMFZTYzRTWnVxdWV6MnNLVzFvT1E4SzNpUEpzaHA3ejR4MnVi?=
 =?utf-8?B?KzY4SFNHSi9EQTJySVJ1a3kxSkhPNWx1RFZsL3BoRW9UY1EydVhuenlOZXJE?=
 =?utf-8?B?VVhqaG9TOThHRVBpejhBTG85amJMTTUwUEZzby9vbU5WZWJWM3hFdW94QVRl?=
 =?utf-8?B?aHJLZjBRa2VoU3VETzluV3pRWGdqTHhvTWNhRGxGdjZLMnI3ZTlYQU5NSE5U?=
 =?utf-8?B?eFBRdVNmd1NvU0MrZDFGUU50STAvTTJyZmJGV1RHb3hxMU04QjNSOExWV2U0?=
 =?utf-8?B?aUZCWGkzMGtSZE56STR2UVZpanpFdDgyUFQyelIxajNLL3lXbVFSaVNnaDQ1?=
 =?utf-8?B?V2NNdFpuZ2tCTVQ1aTJvNUhGODB3a1FCR0MrZVQvSVJlNmZhZVV3dEhSS0x1?=
 =?utf-8?B?RTBiczBTTklZZHdrdllKeU9sUDBqamlKYVVDSW9hUlI4M29YYk4zaUpGSWc4?=
 =?utf-8?B?Z3BaeWhSbUhJTGx6bEVnblZ4K2Z3cncyN29idWovdU02eHhBenVqK2l0eXdn?=
 =?utf-8?B?WjdIUGV4VmJPczNwY3lkeG9NeGp3enZZY2tSQVhYb1NybnlxOEt1YlBuM1F3?=
 =?utf-8?B?V2k5NVpzcU5aSHFaYUxEZjQ1djk5TWgxbUJvUm85TzVtakFiaVpkV2h6S2J4?=
 =?utf-8?B?WCtiaEgrQXpMV0dwcWtkZlo0VFB0OTYyd3ExZ3B4aGp1dlBvK3RUZEpuYVBX?=
 =?utf-8?Q?IVfh0TqrNLOdaphCKTJwRSTc7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efdd299-6805-4cae-0cf2-08ddbd37e098
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:23:04.7289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFFLBxkONY15yJo6szFWyjMiZDsAlIwU0B5SaByV9cJ7yBw0G2eUc7BNAhWJuIum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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

On 04.07.25 09:26, Jesse Zhang wrote:
> The term "HQD" is CP-specific and doesn't
> accurately describe the queue resources for other IP blocks like SDMA,
> VCN, or VPE. This change:
> 
> 1. Renames `num_hqds` to `num_slots` in amdgpu_kms.c to better reflect
>    the generic nature of the resource counting
> 2. Updates the UAPI struct member from `userq_num_hqds` to `userq_num_slots`
> 3. Maintains the same functionality while using more appropriate terminology
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

BTW: Why userspace needs to know that in the first place?

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++++-----
>  include/uapi/drm/amdgpu_drm.h           |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4aab5e394ce2..e2aa2264fa0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -399,7 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	uint32_t ib_size_alignment = 0;
>  	enum amd_ip_block_type type;
>  	unsigned int num_rings = 0;
> -	uint32_t num_hqds = 0;
> +	uint32_t num_slots = 0;
>  	unsigned int i, j;
>  
>  	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
> @@ -415,7 +415,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  
>  		if (!adev->gfx.disable_uq) {
>  			for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> -				num_hqds += hweight32(adev->mes.gfx_hqd_mask[i]);
> +				num_slots += hweight32(adev->mes.gfx_hqd_mask[i]);
>  		}
>  
>  		ib_start_alignment = 32;
> @@ -430,7 +430,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  
>  		if (!adev->sdma.disable_uq) {
>  			for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> -				num_hqds += hweight32(adev->mes.compute_hqd_mask[i]);
> +				num_slots += hweight32(adev->mes.compute_hqd_mask[i]);
>  		}
>  
>  		ib_start_alignment = 32;
> @@ -445,7 +445,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  
>  		if (!adev->gfx.disable_uq) {
>  			for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> -				num_hqds += hweight32(adev->mes.sdma_hqd_mask[i]);
> +				num_slots += hweight32(adev->mes.sdma_hqd_mask[i]);
>  		}
>  
>  		ib_start_alignment = 256;
> @@ -589,7 +589,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	}
>  	result->capabilities_flags = 0;
>  	result->available_rings = (1 << num_rings) - 1;
> -	result->userq_num_hqds = num_hqds;
> +	result->userq_num_slots = num_slots;
>  	result->ib_start_alignment = ib_start_alignment;
>  	result->ib_size_alignment = ib_size_alignment;
>  	return 0;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 66c4a03ac9f9..bdedbaccf776 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1493,8 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
>  	__u32  available_rings;
>  	/** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
>  	__u32  ip_discovery_version;
> -	/* Userq available hqds */
> -	__u32  userq_num_hqds;
> +	/* Userq available slots */
> +	__u32  userq_num_slots;
>  };
>  
>  /* GFX metadata BO sizes and alignment info (in bytes) */

