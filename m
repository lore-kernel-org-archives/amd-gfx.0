Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B1CA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 18:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F099810E1A6;
	Wed,  3 Sep 2025 18:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Il2J1B6R";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242DA10E1A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 18:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyURhUqY+1HO1TCiYKHuCTzACYGz46nNEsF+4oen24BecEYbq3DWznV00l/oFjxMBlmZzgJlnXNVGoTruxfqr+zHUEjblUYQ/McDB7tavwXbes1mNwC3pRdCRu4vBn8cd7gQ4RRJvRvl+hD0xLSyX06JOZ0Qfh//MbceOo+aEZATSqUR4iBxSGyrnMMKRPA//28V4rillYZOHV2RnbfveDteD8xBtCGCSpFg6N+4kamTrui23ExkG6z3zujq/Mrlm2kkhiXjeIT1Q6m2ocUYwGdsYZqdZNep/oyAL34KuOYC4GM4xxv/7r5tqSx6pjt6Uhor/Yb6EhgsULlYU8snLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEgpx/y7J3TVphLjbzQy/CR2fuofTwfE42yZw8rrptg=;
 b=cxGt4qxG9ohE8h2882QNsrKz4Kt6Pzb/LYHjaA664BN6lKJaLqAHn3XPlZaFlj36/VmxsMlZbznejAu8fBoi+7TqYKru2idsG4PmXA4gx13xCT8JIpkI2VJeZnc10M2UyO+YTkApRleX2ULZZqJOodtWqIJzv/mX+kt8ROlp93N2lX6/Ie5OEsFDPJ51Obo97wRUxhY2vUAn445S1vs2ehW83YXSS1kKIAiQxfM87OeVokHch0GUDwilKweNJ3u5yIpRtwhM3ehv0q5/gBVvo7PTfJQsABDUyuDgznyUyWxeYO9A/EU5X9ag8STGTAQl4y8YM9ucYkCxDLEs7EsGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEgpx/y7J3TVphLjbzQy/CR2fuofTwfE42yZw8rrptg=;
 b=Il2J1B6RKNWqEgRPnSqf9AvQyJ20LJM7i875uJpLdpETKFVTCxdY25CaKElJul+vcF7tp74MDC+AsoKFsygePfM08ZPE6fkTf+DlihwwlTO7KA3xbZzXaNhDSzcW3siZ3osbwFUuAis8NIsSUxmY4fdg6Ho4MN3njbboNN/AkxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 18:13:22 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 18:13:22 +0000
Content-Type: multipart/alternative;
 boundary="------------4oBm2D56rq0EsAzDEdO70LSF"
Message-ID: <4fbd52cb-e773-4ba0-8676-07d95c21c765@amd.com>
Date: Wed, 3 Sep 2025 14:13:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Build failures in drm/amdgpu's vcn_v5_0_0.c
To: Brahmajit Das <listout@listout.xyz>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Sonny Jiang <sonny.jiang@amd.com>
References: <x4ga2sfkszmylljox3p46ryog2owghv6hffo3rjj4o6xfjy7pd@jllj3us4heso>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <x4ga2sfkszmylljox3p46ryog2owghv6hffo3rjj4o6xfjy7pd@jllj3us4heso>
X-ClientProxiedBy: YQBPR0101CA0203.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::11) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e509ba7-1705-4f8a-5dab-08ddeb15915c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0ZvczJLcWFrSXFSd0JqTXdjR0V0Z0xtY2hVemMzMUJnOVFIelN4R29VVDlx?=
 =?utf-8?B?U21FMStXQ2dBWW8wbWt0SFllMnBCN0w3cFJzTTd6Nm5lTWJKR1FucnQ1ODVh?=
 =?utf-8?B?Z2FZU0gzQlhYT3l3Qjd4SFdjR1dMZjk1VUhUT2FSa1FreCtPOHB1R0UvRmZQ?=
 =?utf-8?B?UjZaL25ERkZ3aG9naDlwZVpvU2YzcmtjcVJRLzdaWVFEZW8rQ3NHa1BTNVZ6?=
 =?utf-8?B?VnRQb1lVQnV1VmxzSlRybVd6UjZDR2llQUg1dFg5QmVCMHNhaytSOS9NMEp1?=
 =?utf-8?B?UnpQcFhxb3ZRRlFZL204eVpzZXI0Mm1MREpEMkJEbCtjNDVRWVJOVWZSOTFW?=
 =?utf-8?B?UDRSZlpwa3Y3eFRheGFFZDlPeGVBU2hTSHVvZWI4aFRCc3RKYnRqUDk0cGR4?=
 =?utf-8?B?UnRQNFNnV3AxaGdNcEIzVE9ZYkVObkdQY09WNzRkTlJqYjRBZkdzN2J0U1Mw?=
 =?utf-8?B?dGJMVlJUR0tqQmV2K2JIN2grWGhPRUt2TWlPT1JQaHloTjdrczRFck9OOVJw?=
 =?utf-8?B?a2xvR2VyZWl6UGtBczdKVjFhY0tublpxTEt2Uk1HTUgxRzhDUWVkbFRHTGxR?=
 =?utf-8?B?cjBxb1V4a2pKNUNVZmQ5eXpEZmR0dEg3cXRKME1Bck9qSE85L09YeURzQ04w?=
 =?utf-8?B?c08zNEgwUTQzYTV3cFl1NkkvQ3ZicUtHckFPUFppOC94TGtqb2xOUE5BWDMx?=
 =?utf-8?B?NGNqaFlsUHo1bzh2NjNRY0h3L05RbFZJZVRrUDk3bjhIWDdoNjJHYzVBeUd2?=
 =?utf-8?B?U1JqUUZsR0FGYlpNZkFCa2VWSG5VK3dlZVZuam41SVUzOVJNcVJVenc5MlhD?=
 =?utf-8?B?UUI4ZWtaYXpGdmxhbHJXSmxkZFlFS3g1akdSWWVVRGFlYkhBc1BGb0F6Vk5C?=
 =?utf-8?B?bDgvVFVVd21tK3FYcDdpdDVNTzlMdGVJUnFWRnVESFJRSlhhK2RTM1E3bWwz?=
 =?utf-8?B?SGpETjlBUEFQeEo0ZmxrZ0lIalR4UXVZejJVTHpuYWZ2WmFQdGovV25zcXAx?=
 =?utf-8?B?djc0b2hVanUxdSswTkxSbjhHc2hzalJ3YTduTjExbmpxcnl6aHR3Tnp4YTJI?=
 =?utf-8?B?M01URkJQSU9ITkllRldYMFhFU1c2Z2FFTFhkNmlFZFRWb3JydHoxNUxzK0lr?=
 =?utf-8?B?dWgvd09pMUo0d1ZUWFIzM2h3YW5CN0JMZUhHZ0xrMjl3MEFieHRDVFlEOVho?=
 =?utf-8?B?NXk3UnBEa1NveFZRQkpFTUx1ay95SC9VK2kzcG5ocjJScitwODltcEh1WUxp?=
 =?utf-8?B?Q240aWJvRlk0cTAxbHE4dEVZa2FZMzBEUkpIbHFkMUhBdW9pdzlJWWtkOHl6?=
 =?utf-8?B?UkVob2ZhbUVrKzI1UFJMRWJKLzdsdUtoTkFQMUpPSjhLUi9tWmJSZVdEdWpy?=
 =?utf-8?B?Tk9hbDFUQ0NScHVUaHJDNThydHN5L0pOU1ZJVHVscjc1ODZ4N0k1R09JTVFQ?=
 =?utf-8?B?a0Fnb0RIM3dIblE2R2U3cFNucFJ5Uys5c0duSVNXbDZyNU1LRnhCNkkvd1NN?=
 =?utf-8?B?djZId3ZscENRUTJuKzlha1JxRHQ0UkdkdUhqNzQ0Vzh4VTFvVkJ6U2pHZEo1?=
 =?utf-8?B?cURaWExFWTY1aVIwQkxmZlUwN2thZ1E5bDVRa2VvM3VRSWdreWZ2NnRSdGRw?=
 =?utf-8?B?aWNpcXRncEM2Um10L1pJeVlyODZ3WHdyaW5LWXVqbVlYMjRseTFvdlNrNUNO?=
 =?utf-8?B?WE5XRjlORHhlUFFzSi8zWXRFWVFsckVnKzFRazRxZ29wUzRBcU5sdldsZ0ZT?=
 =?utf-8?B?eU50MDdhb0YxYnZGbG5iVmlHMjZYS3U3dzlEVkx4ditud21hMGVZUTdGZWJW?=
 =?utf-8?B?L1BEZzFSQjdGbkVoK3grSEVXUit4R05oaUVXamdHWk5MaUJ0byswa05JQmY0?=
 =?utf-8?B?dzhuTkVWKzlmUE9IT2kyblMxZFFaMVZUVWRST3J2L0dQaUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2hRMFJsdmdsbldFL0FXTy9pYy9YQlRqWWd1amxLOUx2cVVxRmd5cGxMcUgv?=
 =?utf-8?B?ZDNxbHRtZ3J1bTRKTkljOFFhcGN3ZGNQdjQwMDV2TTVvQnlYWDV2TUZZNldB?=
 =?utf-8?B?MStNQnRESExVRVc5dndlMmM0d3lWOTQrZVVaamo3M1pOMHdGTHo0QS9taEZs?=
 =?utf-8?B?SzQrUWlyTGdCNVc4bHBEc3VTOExRZXAzNHFGVWc5MzJPMVFjZVRGZm9mY3dj?=
 =?utf-8?B?Z2hNUTkvMXFPVnhFQ1dxMWpBWGt4c01ZNHA2Z0lrRWtJVDdjbnlXeGY4dUhK?=
 =?utf-8?B?d3grUEtRaDhWU2VYSHp2YWorOEhLdHpmREtvenVqaUM0Mmp4ZXIyN0h2WjRM?=
 =?utf-8?B?NTdPQ3VrSjZDS3FNQUlpcUl0a3lYMW52SnFTcHpRSVdWWmkvQ0VpRkxMUXM1?=
 =?utf-8?B?bUtadE13b1FoVDJCQ0RLTGUvK09VazFjZVJMbWFiNUtreHJyRnRjUGFxU1I5?=
 =?utf-8?B?TlROYk9ZVVAxMHpCVTg2NXJWNm9OTCt6dXBkWElqTUw5bnhtVFhBYTVVSjF4?=
 =?utf-8?B?VVRWYnNQSVZCOFlRSzdXSmo1N2o3dWdiTU1tVU9NVFVvUU5kTkliOEtuU2Fa?=
 =?utf-8?B?Q0tRTUY0SFZiOFcreGV0ZWhEb0phUkpPcGJOd0V1ZWNCL3F4YzhxRVpYSy8z?=
 =?utf-8?B?WDBBWFU4dVdUd3JOcElUajVzYUF5ZVdEWFJNVC9mYzVmZkpoTkhBaTVuL21C?=
 =?utf-8?B?eXZLQWk3MEdyMkRpZ1ZKbUlVNTBBb0xWeHJJaDZMZkJaTkhJRVkzenBEdVlY?=
 =?utf-8?B?UHhSQjgxd3J0Qzhud09OdGxDVkY4eGZSUFpUNXJsb2g1bVl6bnc0TnlyanNF?=
 =?utf-8?B?QVMrOEh6V1hEZGZxdXkwRHZxQ2cvb0owOFJyN2hrU0Nobmg4cjQ3Y0NvTmd4?=
 =?utf-8?B?enZEbHF6QU9jcHkvM3VmOVhSclBueGRvdFNVZC9aZWREc29FajEvS3FsNXIy?=
 =?utf-8?B?SVc5aUlPUUxpNXI4OGloMmJvUDFJZC9vVm5DSGZiaVNwT0hFRzVGdk9CelJh?=
 =?utf-8?B?b0FEcEF3SFpjSXFORDAzOStHTG82b0ltLzVpblZhVzhQV1ZnaVUwVERReTBy?=
 =?utf-8?B?UERYSEFjUjFmVDEyY1ZPMDBUb29BNU9jVEJXU2lyVytSZjdiSWtLWUw1NktK?=
 =?utf-8?B?SlZzRi9sL21ZajJuQUQxRTNvVjhQNTNKeURkbWhVSmRpa1loMlJ3UitlOFlq?=
 =?utf-8?B?UXRCaEJONmxWenE0dHkvUDJ6ZXUreXhOVmo2SEJvQVU3SW52VmhjZ3dlSnpX?=
 =?utf-8?B?b0ZkMzZrNDJpRVEyVnd5VzdBZER2QXBnZlNLS3prRHJVMlpnMmQyYWZvMVBm?=
 =?utf-8?B?aFg3YXV3UVEzaVowZ2dvbk5vNDFia21MbTkyeHhSOWVpNTVlVlQwbVNlejFk?=
 =?utf-8?B?S1lKREV0aVlvY21kczZCbFFMLzdvYXk1Q3c4L1BVQ2wzWHRTT1YycnJFcmJq?=
 =?utf-8?B?VmhwYU1qdGJvTEFFT2ZLcVJscCtXeUFmM3RTUGxjSjJycWNHT2p0SVZ3Q0dh?=
 =?utf-8?B?bHlKQ3ZCeC9OUk41UUNIRERpZFI4Y0RacU1sTHllc0NTVGYvU0FrQWV3RSsw?=
 =?utf-8?B?TU9RTm05VUFsbzlpSEwwVElMZjg3TjdZOTkzSjF2VjlmV3QvRUhuVjZQOWlE?=
 =?utf-8?B?UGZOU1RiWC9NT1pYWW5iQ09jallPRnVtcDFMckptT3BMa1RPM2l6eDBXdWp3?=
 =?utf-8?B?b3hOOEFqbmd2VEVBbmlsbkZRVzdBYXlBakpRdC8zY0k1aDk5RVlLdGovR0dn?=
 =?utf-8?B?Rm5qVEU0QmFnYVlvbndpVWtKMTZCTDRsb1NteldkckxROGFPRUxRSnZJMnh3?=
 =?utf-8?B?ZzFSZHZGWjJTcUQvVUlUOGN2R0x6SHZ4aWk2TFFteXFiRmM5N0hyN0N0YkVv?=
 =?utf-8?B?eDl5ZmZmSVQwSW81ZlhDaEhxYmJQSXdoYkwycEo3K0lnZU1abGhNWjNGb3dN?=
 =?utf-8?B?V1hHRlJXTWV6NWdWYm5ZVkRobUUzVzM0OW5iVXVzeG1kMFR3VWtGMDNacEND?=
 =?utf-8?B?R3NPRXQ1WXcxeDd4eGI1bFF0b0Z6b1hzQ0M2a0lwRUdQZmVjcjFzOTh3akVD?=
 =?utf-8?B?cHNyVnI4R21uWXcwY2RwRW1OYnE1dVBOUStEVjNqL05xdnozTVRuUGxGaWV6?=
 =?utf-8?Q?j0ucWnW9X2jhVU03VR+ccZXTe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e509ba7-1705-4f8a-5dab-08ddeb15915c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:13:22.4726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCcDZPuRCicFz/cPO8VEEFcIhZMgPthl+1z7vvqyUKBMg4Q3chN2mnpeb3tFMgAi72yMA6nPPPU1Xxe69VjQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
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

--------------4oBm2D56rq0EsAzDEdO70LSF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brahmajit,

Have you tried by adding "internal_reg_offset;" as below? ( it may help 
- see here Statement Exprs (Using the GNU Compiler Collection (GCC)) 
<https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html>)

internal_reg_offset >>= 2;                            \
*internal_reg_offset;                                  \*
     })

Regards,
David
On 9/1/2025 1:57 PM, Brahmajit Das wrote:
> Hello devs,
>
> While building the -next tree with allyesconfig and GCC 16, I got this
> build error:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:164:26: error: variable ‘internal_reg_offset’ set but not used [-Werror=unused-but-set-variable=]
>    164 |                 uint32_t internal_reg_offset, addr;                                             \
>        |                          ^~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:208:33: note: in definition of macro ‘WREG32_SOC24_DPG_MODE’
>    208 |                                 offset;                                                 \
>        |                                 ^~~~~~
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:751:41: note: in expansion of macro ‘SOC24_DPG_MODE_OFFSET’
>    751 |         WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
>        |                                         ^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> The WREG32_SOC24_DPG_MODE macro is calling the SOC24_DPG_MODE_OFFSET.
> The variable internal_reg_offset, while not being used in
> SOC24_DPG_MODE_OFFSET, is used in WREG32_SOC24_DPG_MODE. I might be
> wrong though. So I'm wondering is there any *easy* way to fix this?
>

--------------4oBm2D56rq0EsAzDEdO70LSF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <font face="Helvetica, Arial, sans-serif">Hi&nbsp;</font>Brahmajit,<br>
    <br>
    <font face="Helvetica, Arial, sans-serif">Have you tried by adding &quot;</font><font face="Helvetica, Arial, sans-serif">internal_reg_offset;&quot; as
      below? (</font>&nbsp;it may help -&nbsp;<font face="Helvetica, Arial, sans-serif">see here&nbsp;</font><a href="https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html">Statement
      Exprs (Using the GNU Compiler Collection (GCC))</a>)<br>
    <font face="Helvetica, Arial, sans-serif"><br>
    </font><font face="Helvetica, Arial, sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;
      internal_reg_offset &gt;&gt;= 2;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \<br>
    </font><font face="Helvetica, Arial, sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; <b>internal_reg_offset;&nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\</b></font><br>
    <font face="Helvetica, Arial, sans-serif">&nbsp; &nbsp; })<br>
    </font><br>
    Regards,<br>
    David
    <div class="moz-cite-prefix">On 9/1/2025 1:57 PM, Brahmajit Das
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:x4ga2sfkszmylljox3p46ryog2owghv6hffo3rjj4o6xfjy7pd@jllj3us4heso">
      <pre wrap="" class="moz-quote-pre">Hello devs,

While building the -next tree with allyesconfig and GCC 16, I got this
build error:

drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:164:26: error: variable ‘internal_reg_offset’ set but not used [-Werror=unused-but-set-variable=]
  164 |                 uint32_t internal_reg_offset, addr;                                             \
      |                          ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:208:33: note: in definition of macro ‘WREG32_SOC24_DPG_MODE’
  208 |                                 offset;                                                 \
      |                                 ^~~~~~
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:751:41: note: in expansion of macro ‘SOC24_DPG_MODE_OFFSET’
  751 |         WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
      |                                         ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The WREG32_SOC24_DPG_MODE macro is calling the SOC24_DPG_MODE_OFFSET.
The variable internal_reg_offset, while not being used in
SOC24_DPG_MODE_OFFSET, is used in WREG32_SOC24_DPG_MODE. I might be
wrong though. So I'm wondering is there any *easy* way to fix this?

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------4oBm2D56rq0EsAzDEdO70LSF--
