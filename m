Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71C7C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 23:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AD510E194;
	Mon, 28 Jul 2025 23:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAoJbDIX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0180610E194
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 23:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nkmw7IYMyGb3EuDq/KZpm29eB03z4ACvsFHw2te87YS22udrtMI+mNW1LWvsDXP6Rxu2rUU3JN2eqBWLS1gx6qYs3+4GVtC++Gbm+H7lSPN85cayQibplxrIDMbzLQ1PBw+jb9s5ItwA+YAs9gmMMPwYTqVpi0TRGDdvG6EoXKqPnn/H4du+Nw9AkUzTyrrWUfjdgkIcZp/XnDLpQFXtd0aDIDDq/MDY+1kyuii1FkCJLytFylxsch6sIZU9KeCDT3iduhetAdTrhAdLAD6gDt8ZI0rbiseP+grH29AfdKmS1GmgPY+esW5qwPVbgcQS6lrvb3kx2OoSi+iWjUNm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJPvlOnMlwm9NIOXCGwHFrCC87PHTQDiw6E1na9Ivao=;
 b=uY4G/P9QaCQC8Mb6ylTZPEMQjjTrohPZPukURex08XXQ3VCwp5ROhVsSJQJ/CWoxOGcUDMrAmF8g9SWPdR7rusfo3yqx7qr4Z5E+d4nDVv9G+DZn2LCFmpEx56j7TPQZXVEjht6bnOxDkBW28xJ8g+puvIdrZbhO+bnm9Z2e+J7qO/TpykVs6o6h8A5cF114n9i7rS3oKDfq2B07FGk8acEN9Q5i89K0b5JNCH7Vlzk7GvaMRLs8deVA40xWfuVfkTl3ji4oMgMQkD+4TvepJ+F3xGx6oLEUWrhQCPSdP70a2yYBD9o0qvJIqb7GrI5jqHpf2g8Jpa4TimRlIdUHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJPvlOnMlwm9NIOXCGwHFrCC87PHTQDiw6E1na9Ivao=;
 b=pAoJbDIX89hOPA5SwIHYmeOcLYKWM5Ypx3BnIWpRLOsfeOV0rOrFOBhGhaum/M0PNPu3bKqJ5Zlrx+GluMx/d6vZJcqbcxf8SNUgen58ux+bdjM3JP681ZjzfEZ3zDfSfCVJiUmb7Iln9/+UMa2WfiYHH/N2P5GV7CiiBJXDNyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 23:06:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 23:06:57 +0000
Message-ID: <93d0b2e0-e803-4349-a5be-8151a76c8638@amd.com>
Date: Mon, 28 Jul 2025 19:06:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdkfd: return migration pages from copy
 function
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: christian.koenig@amd.com, jamesz@amd.com
References: <20250528171908.82639-2-James.Zhu@amd.com>
 <20250722125950.7574-1-James.Zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250722125950.7574-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a8b9bf-a138-4ffb-a737-08ddce2b7315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm5leVAzTjNDL2luRS9wb1o5UGMyUDExWkNqVUdhS2tOYlBvWHlhT0t1L0Z6?=
 =?utf-8?B?aWJEZ0djWVhCc2NoMjF2ekNpTC8vUW50ZjJuallPekptaWc0MkVFWjlDMGFS?=
 =?utf-8?B?eXlkY2l0TUZyN2NqUXB2QWZJRmpKSXFqd0Z5SEdaVUc0NWxHeXBPU3loSEUr?=
 =?utf-8?B?Y2prdUdVc09NOXhsdUV2bXVoSHJ0aExYaTZ1OTQvcmRUdW5XWGdrbGMzN2lw?=
 =?utf-8?B?RlNsR3ZqTUR5QTY3eENyMU5VNGxjUTQzaEh5cXdyOFZsU28rcHd3MDJDM1Ft?=
 =?utf-8?B?cTJPdVR5Wk16bXdYUHF4NkdXTGJyZlFMbXVtbi9Fd1UwTkpnTUNiQ3I0OU5w?=
 =?utf-8?B?NndCa0cwcUQxcUlKKzA2OC96a2R6a0FlbmlyOVJlYitmclE5dnBMcDg5c3BK?=
 =?utf-8?B?RVZhWXBrOFVsZkNkdHZSZTVlbWVoSU1wWnNxNVl0cnJFZXY4RzI5UnJYZVhj?=
 =?utf-8?B?SkFOQStPMVE4bjYrQnRPNkg1TjFNYkFLRjVVU3Z2WUZVUGcwMWFGcnlVSTNz?=
 =?utf-8?B?TXRmUjdseUdVTmZVYXc3NW9WMktsanFaak4vdzM0VmRsdElSbkc2bittcFJ4?=
 =?utf-8?B?RGt5ZlVOTDN0TlkvUnpObFBrMXNPSHlQcWJNSmZuTlNvMUFlV1p0Z2drZVEv?=
 =?utf-8?B?bjhuWndVNmdGZHJ5K0hCWVZUYlVnKzJxanljcTFKQVZRWGsrVitXQ093VXA1?=
 =?utf-8?B?THVUUnhlMEtscmc1ejY1aGhBcVJYeHNPeThtTTZmcDJzZ01JWUtpYTY5WWxq?=
 =?utf-8?B?R2VqK3J3T2M1Z0JUUDBZMWt4dE1aKzB6TlYxbzFDM0ZlSGd5U293WmcwNVhM?=
 =?utf-8?B?UlVrZC9VTEJRbU9seDQxL21yYWRoUnRVMlBaUW1uYnJSb0pCaTB6R0tDNGF4?=
 =?utf-8?B?NzVURUJ0b0xlUjFrMkVQd2tVZkRuRlB1cnAra2xaTmhMcjJlZDJObkZlWEdF?=
 =?utf-8?B?eG4renV6aFozbFpoSUZOTzhOSzBtMkZXZi9wS1NuZVBLOFpsUjJIcEJKRnZQ?=
 =?utf-8?B?eDZRakZvYWRRSDZ0a0J4d2N1dFppdmgzQVQyWThqSndZa2xKRDFoa3VyaXAy?=
 =?utf-8?B?eFlTSlM1S1U1UER5cVZWRWJFRjlwMzdaZEs5QUdjWTE3OUJkb3kxRHg2bzhk?=
 =?utf-8?B?M1VLeDZmVWs0alNHMGljRVgrR1k4a0R5Mit1L2U1aUdDTVJJQVZiL1VjWlEr?=
 =?utf-8?B?aFNsT1VZY2JGUEdDeGRQdWVES0dTaTZpbHhLTjU0VmJjVWpXc3hiMlR3WW5m?=
 =?utf-8?B?KzAvMGEzWGNIMFp0ZTFDQkM2Y3pnaUpFSGk3NHMzUlh3QTRXSnZYMkNWVW1L?=
 =?utf-8?B?RVpZd2tjWjZJaHlBV2puUEx6ZWlITTl2MUJUaXpkUmpMWkRZZG5kd0FMUE5U?=
 =?utf-8?B?TGNISnpCMmZmc3d2bzYvUi9FZithSjcwQU5xcHNzaU1sVEc0NFhUTVowTFdp?=
 =?utf-8?B?NVpSL2tZYzNXRnBlWHo4OEQ3SFQrM0NnZjVwNWZTdUFqbGFyTlpwU0NuU3NB?=
 =?utf-8?B?OUlnZkoxMVNZbEprcElQL09SQXJIdUlvRmc0MWo1WmgrSzRxRHh1MUwwWkh1?=
 =?utf-8?B?ZjhEUjhkOU1ua3o1dXltdjcwak1leWVZdFVOaDhsUVczVnVNUUFKQXR1cGRk?=
 =?utf-8?B?eWUwUFV6dVdMam9nRjRibFN2a3BIQ2RmWHFDbFc5MXNkOHRUTXdPUVB1S2lE?=
 =?utf-8?B?S0FVa0V6U1Y4bUZmQU5hN2l4SUIzR0NXVC9wT2dsSE5UbzdmdXdYemRES1JW?=
 =?utf-8?B?dlVqVUZ2MUVhVUdWSUdaNXlaeWl5aUtpTEdFcVZoYW82U2EyWDRVekRBdmJi?=
 =?utf-8?B?SEJScEV2TDZmNlRCYmUySCtaRUkxQ1FKb2tYNW5XM25XK2dSL2UzUVE5cTFv?=
 =?utf-8?B?dE83aGZHS1lScFJhcHZSQi9iYzBVZjVvNTVTejdnVi9ZNUV6eHY1d05VMXg0?=
 =?utf-8?Q?PODZfU9FY20=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHhOQnEvUUtZRzlHMEdXUjFFa0wwMUtwMEZyTHQ5NXJONWJNOE9hdXA0UXRE?=
 =?utf-8?B?YUl6VFN6Qm5VandpdS8vbzBpZTc2VUpuWm5PSnhMUnRkUm1vWHVSTU1WUytZ?=
 =?utf-8?B?NHAwNmFIUEVpeS9zcXI0VGZXeUorM0M3Qm8rUzRSY0QwRXkybmkyVVdBdzhj?=
 =?utf-8?B?T1RmUVBuSWIzc3loRXp5ZG11bndRLzRscklGNzZlYlgrOFNEUUZ1K3hUUE96?=
 =?utf-8?B?LzN2b2xabytvY3YvbUZzYlgvT1RNeUlZdmdiVzFUR0t6YUIzOUJGcTJhSnpB?=
 =?utf-8?B?WVpYbjEwSDlZaTl0ZzNkTHlxOXR6Q3B1aG9uRXo2cGtmNFp2K25TQmNrcGNK?=
 =?utf-8?B?WUVSRFZjQ1FDOGZ2K2p0UXE2dEl4L3A4NzNwYzNuRnEvNmJzOEFoSHhjaVZU?=
 =?utf-8?B?SmJwTVZSemM5YzBxd1BoRENkWG9tZUV3bThYMHcvRmhQWk1Fa3dpTHpTSkVF?=
 =?utf-8?B?WjlUVEVBYXpOWFVrZW5OMlNWODJES3JrdzlIZENZYUJ4QjkvSnpxNnFWUUhv?=
 =?utf-8?B?M25DUEpwa0U3Sk9PUERmTDdhTUNmbDAyNXVZN0hPUGpQMjdhZEtaaWxIOW5Z?=
 =?utf-8?B?Z1NKVlpCK1RjMkNMUlZKMFZaeW9VaERlTldnbjRRN1hJbllxeE8wRjZ2c1dp?=
 =?utf-8?B?TzgwZy9TblgzUHRSUXRmS0E0OFk2UDBTNFNNQkNjQzlhSzBmb29FaWdCSmdZ?=
 =?utf-8?B?VjhkaGFiNTJ0YzFvaWlUcnA1eWNDeTI5R1hZSG0rZDBrYkVMYSswa2xsTzVL?=
 =?utf-8?B?TE5WcXhFdzgxcGJteE45TmVBeGpqTHdBekEwVXZXMVoyQXJmM3BEMDUrVTY4?=
 =?utf-8?B?akRkQ0VpKzd2NDhqZTR2ek9LUnE3OTdwUFgxTDM2M3E0cDhITnVySU5zajNn?=
 =?utf-8?B?WVBPUHRxSkMrL3dodFdhVUluMU9ERUpDNW5pUnFjYjFwblFvdk1vN05wNjJo?=
 =?utf-8?B?dytJWElKSnRRUFpVOWVhSmFZdjZnZGVaZ3NZcmJjOEV3SmxEaUhFNGN4TFpV?=
 =?utf-8?B?TTlPY3hHODJ5azltaVlkQzBFTG9tSzVUS1kzZFlSQU9jMit3ZDN3dHMwSzAw?=
 =?utf-8?B?T2xoSk9CWmRTZW9CQnZlbk10cHZmK2V4bVY0REZoYzFSdWFhUWpndVl4YlMx?=
 =?utf-8?B?NlBlUGp3NDVZVzY5MGF1SzBxNHgwVHR1Z2J4SGdBbFR0aUtYSWxPNU1pcnh0?=
 =?utf-8?B?T0VSdGxTTS9TN3lUT2JQY0poV0duUmhDS3RpNWp2eXFqMWVZaks3MlB0ZXB4?=
 =?utf-8?B?Ky80QzdUM0dEbWk5ZFU4d1RIZHkrTzlwV0NBOVZ4K0JqY0FXS2FSUXdVTFNx?=
 =?utf-8?B?MzQwZ1Y5WnFCalZWRWxqWnFWeERaVU5FaWtDSVplYVFiVnFaQVY4d0ZYSGsv?=
 =?utf-8?B?RGM0VjM1MktWRjNaRUtiSEtwNXcvRTJYL1A4V0c0bGx6S3JrWHV3U21qU3Ni?=
 =?utf-8?B?cmdLdGpQS2U0RFdtMEM2dUo5alorY09sdEVxd2VUNXV1YXk1Nm1SZkFSTFJU?=
 =?utf-8?B?enI3TnB6WUthZWovS0FPalczOGhGYUtLU1JTNTZXQWZwWmtVV3lUbWxMaE8v?=
 =?utf-8?B?RS9tenVwWU9LcUY4QUdBcVl4RXFrMlNUZ2EvR0djcmx4SnFMSnorbEtyZ21I?=
 =?utf-8?B?TGhHNFZuRW8yTlFyVWdlTGlMeUFlYVpwa1BXSWRWOVVaTVF0dk5zODB3RURa?=
 =?utf-8?B?SDFnUmVmaU8zbmJmMndjeDJCV3FORmF6eGI2NHNFS1F0QmpGN0JpU3ErQjRv?=
 =?utf-8?B?WHM0Rmk1cHVYbHQyZFcySEtNMHFCcWVjRXhEcEk1eXA3ZFdNRVJzOWxZcUU4?=
 =?utf-8?B?L2pJa3BoaUwvemVOYzRnelduVmJuOEthM2xkQ3NTemE1cjNBNGxuSmduK21H?=
 =?utf-8?B?MTlVQzVzajhTenR4MFdnc1ZCWFJjVXE4ZTltcEtETm81Sk5jK1RyUXMyNy9K?=
 =?utf-8?B?WnF0bnliMk1lMzJ1UVZsc3hLejhFUTN2Z0s1VlVaR0lIYmNxV3U4ekdxdFhP?=
 =?utf-8?B?aUQxSmtnczNDQUdES3VkMVB4dU5nZVF4aTg1V0RkdktWVUhUaUlUMk1waW9x?=
 =?utf-8?B?eUNVNVNxZ2sxSUxrSnQ4VnBrTzBNNzdhNngrQUxyRjNEMlZkaDhHZkJFRFdl?=
 =?utf-8?Q?KxT/xFofmAoy/NFXp/0zqQuiV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a8b9bf-a138-4ffb-a737-08ddce2b7315
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 23:06:57.0850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xVMdWTBtARC0jQ+rl0GbdnmLTnhpdvQzzwWQh2b1aRnp5qdv4LDmBQWZ49zUzVs4xHg9Z0dpbnBwjsFBJNceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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

On 2025-07-22 08:59, James Zhu wrote:
> dst MIGRATE_PFN_VALID bit and src MIGRATE_PFN_MIGRATE bit
> should always be set when migration success. cpage includes
> src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID bit
> unset pages for both ram and vram when memory is only allocated
> without being populated before migration, those ram pages should
> be counted as migrate pages and those vram pages should not be
> counted as migrate pages. Here migration pages refer to how many
> vram pages invloved.
>
> -v2 use dst to check MIGRATE_PFN_VALID bit (suggested-by Philip)
> -v3 add warning when vram pages is less than migration pages
>      return migration pages directly from copy function
> -v4 correct comments and copy fucntion return mpage (suggested-by Felix)
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 72 ++++++++++++------------
>   1 file changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f0b690d4bb46..5d7eb0234002 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -260,20 +260,7 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>   	put_page(page);
>   }
>   
> -static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
> -{
> -	unsigned long upages = 0;
> -	unsigned long i;
> -
> -	for (i = 0; i < migrate->npages; i++) {
> -		if (migrate->src[i] & MIGRATE_PFN_VALID &&
> -		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
> -			upages++;
> -	}
> -	return upages;
> -}
> -
> -static int
> +static long
>   svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
>   			 dma_addr_t *scratch, uint64_t ttm_res_offset)
> @@ -282,7 +269,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct amdgpu_device *adev = node->adev;
>   	struct device *dev = adev->dev;
>   	struct amdgpu_res_cursor cursor;
> -	uint64_t mpages = 0;
> +	long mpages;
>   	dma_addr_t *src;
>   	uint64_t *dst;
>   	uint64_t i, j;
> @@ -296,6 +283,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
> +	mpages = 0;
>   	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
>   		struct page *spage;
>   
> @@ -356,13 +344,14 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   out_free_vram_pages:
>   	if (r) {
>   		pr_debug("failed %d to copy memory to vram\n", r);
> -		for (i = 0; i < npages && mpages; i++) {
> +		while (i-- && mpages) {
>   			if (!dst[i])
>   				continue;
>   			svm_migrate_put_vram_page(adev, dst[i]);
>   			migrate->dst[i] = 0;
>   			mpages--;
>   		}
> +		mpages = r;
>   	}
>   
>   #ifdef DEBUG_FORCE_MIXED_DOMAINS
> @@ -380,7 +369,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	}
>   #endif
>   
> -	return r;
> +	return mpages;
>   }
>   
>   static long
> @@ -395,7 +384,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
>   	unsigned long cpages = 0;
> -	unsigned long mpages = 0;
> +	long mpages = 0;
>   	dma_addr_t *scratch;
>   	void *buf;
>   	int r = -ENOMEM;
> @@ -441,15 +430,17 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages collected\n", cpages);
>   
> -	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
> +	mpages = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
>   	migrate_vma_pages(&migrate);
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +	if (mpages >= 0)
> +		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);
> +	else
> +		r = mpages;
>   
>   	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>   
> @@ -459,14 +450,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    0, node->id, trigger, r);
>   out:
> -	if (!r && mpages) {
> +	if (!r && mpages > 0) {
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_in, pdd->page_in + mpages);
> -
> -		return mpages;
>   	}
> -	return r;
> +
> +	return r ? r : mpages;
>   }
>   
>   /**
> @@ -577,7 +567,7 @@ static void svm_migrate_page_free(struct page *page)
>   	}
>   }
>   
> -static int
> +static long
>   svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct migrate_vma *migrate, struct dma_fence **mfence,
>   			dma_addr_t *scratch, uint64_t npages)
> @@ -586,6 +576,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	uint64_t *src;
>   	dma_addr_t *dst;
>   	struct page *dpage;
> +	long mpages;
>   	uint64_t i = 0, j;
>   	uint64_t addr;
>   	int r = 0;
> @@ -598,6 +589,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	src = (uint64_t *)(scratch + npages);
>   	dst = scratch;
>   
> +	mpages = 0;
>   	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
>   		struct page *spage;
>   
> @@ -646,6 +638,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>   
>   		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
> +		mpages++;
>   		j++;
>   	}
>   
> @@ -655,13 +648,17 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   out_oom:
>   	if (r) {
>   		pr_debug("failed %d copy to ram\n", r);
> -		while (i--) {
> +		while (i-- && mpages) {
> +			if (!migrate->dst[i])
> +				continue;
>   			svm_migrate_put_sys_page(dst[i]);
>   			migrate->dst[i] = 0;
> +			mpages--;
>   		}
> +		mpages = r;
>   	}
>   
> -	return r;
> +	return mpages;
>   }
>   
>   /**
> @@ -688,9 +685,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> -	unsigned long upages = npages;
>   	unsigned long cpages = 0;
> -	unsigned long mpages = 0;
> +	long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
> @@ -744,13 +740,15 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages collected\n", cpages);
>   
> -	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> +	mpages = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>   				    scratch, npages);
>   	migrate_vma_pages(&migrate);
>   
> -	upages = svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> -		 upages, cpages, migrate.npages);
> +	if (mpages >= 0)
> +		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
> +		 mpages, cpages, migrate.npages);
> +	else
> +		r = mpages;
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> @@ -763,8 +761,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    node->id, 0, trigger, r);
>   out:
> -	if (!r && cpages) {
> -		mpages = cpages - upages;
> +	if (!r && mpages > 0) {
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
> @@ -847,6 +844,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	}
>   
>   	if (r >= 0) {
> +		WARN_ONCE(prange->vram_pages < mpages,
> +			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
> +			prange->vram_pages, mpages);
>   		prange->vram_pages -= mpages;
>   
>   		/* prange does not have vram page set its actual_loc to system
