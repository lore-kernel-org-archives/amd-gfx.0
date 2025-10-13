Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472FBCCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 08:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D970A10E02F;
	Mon, 13 Oct 2025 08:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kmNx4v7S";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2799510E02F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 08:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9y+/rDZIZOwzYGHov5cubh4XUmIPAd/C9wMM6dCpK+4cgbMh31AeguRv7GXjnTAxMiJBMrkQ7a0XZKd+O2maTIpBHMt10m+J3w4BwKSXmfDF1ZCTF7Kb5E6JooFIjslre687Og0+2Jdrxtqp/MyRVnqsmwG7DFmig/4vRpk+S4y4E+b0ED0KnaiSYVBFjCzs7MjfkCz4XdJ2aWQM51XIBgZrVW8AztrnpeluIvrl17CyVDSKJh9uD9zcZXpQLVFDNGgOBE0KaV+Z8mynruy6xnGfioaO9NBARtXx6lQj1KfO945TVbQP+4DoIZWg8JTuNOglcaSJTxK/Prn0cn3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yovz//Zk2ByaDFSe2QYhPRjroX36QvvlLz/QMrRmX/Q=;
 b=gu4StFZZVNOb5yJyUJptfIXS0oFm+C+rbvtkVYCY1grdbJprO0Og4y/L4GAspJfUU2cQsX9GiiBBfqUa2cJcoROqA+s1d869N3AIAOVojFGUbmkAmrWQlN6+ekiuEdXTEHt669QDCpRJQqbJAojHTflSf6vuKihY/G/DRw9D+3XiZUvo8yk7E9Vfvp7nkwBgJylOjrh5ICowy0YLXaez9OEQPU6RirgeSWKSdJ3EPu05Q9m7vd1hTDN18CvmKh0r/hkKvLtaocv7RmRJAiuci5ckI4PlAAuwyvDjZgojxyDtClqVx4Y46GTS8q1OvGdj1cKFGFJP25pdFw2tuuYzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yovz//Zk2ByaDFSe2QYhPRjroX36QvvlLz/QMrRmX/Q=;
 b=kmNx4v7SVDL2SEs31ClVmbj6b5+ZgLdbadEZ0nIeCzyvUAWJqmzsaSoYhqa+amaRbPZigt2VNJE5svcQnPsZrzVnR86m68VTe1ROJqGrKgv5OexyYanDNoibmPpUDdRZ8qVyKa3ojNjhthrCn8QmlasswpjHPfPRwDOFsy64q6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 13 Oct
 2025 08:14:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:14:03 +0000
Message-ID: <9bb72711-0739-4732-bc58-69563dd624a8@amd.com>
Date: Mon, 13 Oct 2025 10:13:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 2/2] drm/amdgpu/userqueue: validate userptrs for
 userqueues
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251013075424.33883-1-sunil.khatri@amd.com>
 <20251013075424.33883-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251013075424.33883-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0552.namprd03.prod.outlook.com
 (2603:10b6:408:138::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0e96c1-1e37-45ce-975d-08de0a3078d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlRYbVRTb21zQUI1SHZ0U0ZpbzBKdHVUMEJCTEFSWUtReGJ4WFRFblFEd0l4?=
 =?utf-8?B?aWdIS1h4MWcxTGlnQkZLUGhZSnZtbkdRcjVIQWpFZTlOOEZmWFV0VDN0Sm81?=
 =?utf-8?B?bFdmdnpib3drMURMVGlDSkVCdERabnZ5MWtzekoxeUtld21jdDZVSDJVNjRL?=
 =?utf-8?B?K3NaNWM3WWRyNzRUeGVKazRyeFRxYVcxQW55VFRhdXNBS1NBMXBnTUlyMUdw?=
 =?utf-8?B?QU9KTHJjb29zUTd2Yjg0TW9VQnh0ZWIwK01GdkphNVF1OVBDaTVWcjNNdTNx?=
 =?utf-8?B?N0taN2tLdU16dll4UWtyWmsxNFd5a3AwVVd0aVVieFR0b1JVdXBOeUQzaW9Q?=
 =?utf-8?B?a3Zwck8rTDg2VE1ReWc5YXlGRmlkaFNZeXVJak1NWnlUMEIvTDFRd0E5YzZn?=
 =?utf-8?B?bjJZOTZjTVZ2ekIzWW5LWlMxU1ZJYkZlZTdSUnRUUTYvVWc4dkxQY2tHdU9Q?=
 =?utf-8?B?ZGNUcWtrN2h0L0xhdGhzTU0vWWRTNTdJZ0VwN0lObGxXWjE4eHBxN2Z6NDRw?=
 =?utf-8?B?THhsak9UTkZiZHBuY2w1NjNtMG1QQ1RTc3pub1VVMGwrZTdnc3VNLytwQlF5?=
 =?utf-8?B?L1l4RXdTRGZoaUtEdXpWUFp1c0dGblVYT1BIalF4VDQxd3BuWTVJejRkWTJY?=
 =?utf-8?B?VzNONmowOGYwRWtjOEFSSnYyc050cTRBRmNkNThFZnRxMCtWekxQbTV1ejZR?=
 =?utf-8?B?VzJZVWJCR2xxREpyVlhPSCtMdmpUV1FvNXIyWTBWTFVSVGFCdFFGbnk2V2c4?=
 =?utf-8?B?a3JHWkEwZDhReGtUc1hxMDJ0YnM5bUVLTUw2M2IxdHdHdUVrbVZMZUF6bjZJ?=
 =?utf-8?B?WmtnSytsd0VTUmt6L1hIS1ROekpNTUJDa0FnZi8xUkNKdXpxL1c0aWNmZ0dM?=
 =?utf-8?B?RU1kVWgrcVBYWjRFL0pQMmwrSGZqSm1CYmx5d0VRRzlsZmZCLy8yZlR0K0x1?=
 =?utf-8?B?dUZyYkxYNHFSbzFLRUN6clovM2dWSE5aS0Vkdy8vWldIczJQY2FwWVh3d053?=
 =?utf-8?B?N3lwV0RKeUdjU0VOUktiYkN0WERDOWQ1ZGxIWGhYVEdkV3BSdFByZGxSaTJ3?=
 =?utf-8?B?MmZyT2E5WC9PNEhYbS9paUlTdFV5K1hzK3A1L3oydFdIZTZ3a1kwZGd4dWJC?=
 =?utf-8?B?NkR2RWppSmlkeUZUc2NmZkxsQVpZNDVRbzh3Zm9ra3dTMkl0NDNBSFMydHpk?=
 =?utf-8?B?MW9wdnVBOXl1STFGaFg1ZHh3QTFaR0RRRUV6UmVzRE5JMUc4WVM5VlFpU2tC?=
 =?utf-8?B?b3ZnT0ZsbkhjSUtXRlpmVkxoVmZNc2paNzNOYUZVN0JuMzBXQjV4Rm90OUxU?=
 =?utf-8?B?WHByLzNFVGs2bk5zQnRBczVXK0s2UmYrVGl1dnRHcE8wVE5hWTZBMVhNaXZt?=
 =?utf-8?B?UFh0SFlyMHFRcEowUGE4KzN3Rnh6VWI5U0FrL1ZGZ1NTVEEzcy9EYzdQTTh2?=
 =?utf-8?B?RWVkSG50YmhSdXUrd0N1L01ESGFUUjIzc0ltZGpJemliT3o3NE1sWWY5WlU1?=
 =?utf-8?B?UlN5QjBvQ0swN1E3blRyNURLenlDL3BsUzNkdzVOTHVSOTNCL05JZjJmSitU?=
 =?utf-8?B?T3ovOW5uUHM4M3JrOGJqTS8vSGhOakJieEF3ZGhLNlZNQnk4WFVMWUJXNUp3?=
 =?utf-8?B?Ykc4UkFmc05ENm1vM2tyYW50bXNkZFZhNndaTFZjdlF3d3FvS1dqNE51cVhN?=
 =?utf-8?B?VWszMlltRXZaeVUxNnl4V2FIdUNHa1NYYmhRSTFCVFVaWnpjOHR1Q1F3ZlpR?=
 =?utf-8?B?MTY0M05hRTJQUU9FM0hHbXM2NGJTb0tVWHdXc0VjSU45aExqcEJ2Q1gvMlJM?=
 =?utf-8?B?bXFaajNFNHdwQkVVaWxSNUxQQmxmQlVzY3hTbUk4a3dyR3o2NFptZjBtK0RC?=
 =?utf-8?B?TVNkWCtoN005aDZCaERXZ0ZjSFJQUlMyN09yM0ZpS0djY045ek02UjJLWjZ6?=
 =?utf-8?Q?6sE2TAVhOMx9qxYAdXvBeB2attcFu/eE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdVcHR0MnpTa0dZL2JEUVYxK043ZWEvclNwOTZLVEFpNjVoL3Q2Y0VpQk5M?=
 =?utf-8?B?bWZFU1pndG1tRzNFVC9qbXNDWjZKY04yUENqeWlBQ0phckR6QUNMY1lJQ0pG?=
 =?utf-8?B?QitSQzZaak9CMFY0NGFDS3BORFZWZnEzRS9CMXM1alpWclg4bDVQUW0yMWtV?=
 =?utf-8?B?QXoyNHpZWWVXNWkwYWJFUE9OeVdMZW1ZbW5XOExsdUtURkxXbzE5MUtRcGw5?=
 =?utf-8?B?YnM2L3ROUVh3NUd3NjdhMjNGMHpwMGQ2KzBJOWpPRUowSTV6UmRQbFVuRW5t?=
 =?utf-8?B?RTk0ZWUrcFk2RVJkdThhZzlkME1hNVltM2N6RXZJTHREVVpnTHBsaGoxbkdE?=
 =?utf-8?B?OEduc0Q5SmVqTFBGM1NVMEpNYmVUN1o4L0RLT3ljTEtROVMyTm5WWUVwdGFx?=
 =?utf-8?B?c1k2VWVwUnN3VTdzQXBHYVN6U0g1Q0dUNFFjNE1rdHhsZ1pscTVKNHdPVlhp?=
 =?utf-8?B?eFA3a3NXQi83cDRNOE9pOFREUGxTWHEzOGVMMUFVQy9WbFBreFVqUitxcUo5?=
 =?utf-8?B?ZzVuQkxXaXNDK2ZOcW5aZ1lnOTRDYzZTek1tblZvZzZ3aXloUVR2bEhWWUdV?=
 =?utf-8?B?YTMraVhsR3RMbzRzREtDSTBxL1NOWWRsQmhNNzhMRGRqTWVFR21hN2hGWU5C?=
 =?utf-8?B?OGZWOUM1UmV1SmwrdC9seEtjUmJMMFdxbXRueGVVbC82WWM4REN4TkR6ZlpH?=
 =?utf-8?B?cGZYWEM4ZWtQanM0bWpKUDRkd1JTRXR0WXBWd2NsYThZbUlTWUVxTDNNc2R6?=
 =?utf-8?B?V3dpQmpQWFFCczVpU1pCeTA1N2NkaTZzWno0ZUFPUDVnNWp4bVpGQjZCaUlB?=
 =?utf-8?B?TVcvRy9SM1pXVTY2Q0lkbzN2TSt3YldPOUZIeC9hQXhFcnZydTFSZzY2YWRL?=
 =?utf-8?B?SDZZMGFZSk9seHdwNmtqQUlnckpXZzFKKzJxcXcyYTZCODAzdkZiVkNJdWxL?=
 =?utf-8?B?VFFBRis1UnZPQXZwYk10S3Fnc1RTL0xza2l6bytPSTRFZms2a0F5UTl4ajMw?=
 =?utf-8?B?VjluTzdrbUlzU0RHZkJUS2tOK2l2dXpxQUVZdFMrRlc3Q04xZ0U2dlhmWXRa?=
 =?utf-8?B?YnFFU3FuVmdZdjZWR0NrRHZMSk1obWZmeitjT0lUUFhKMnQ2UHFicktQOUx6?=
 =?utf-8?B?WGJCVTl0ajU3cGl2ZElHWVB6T2hCOTNpMkRvMTU4MkpSTW0zNzQ0azY4eVlh?=
 =?utf-8?B?Q2ZFNFlCcWhoNXY5NytiRTQrL3lmUmpXeU5LZzcra01KenJST2ExeE14N1dJ?=
 =?utf-8?B?KzhNYm5JcEVrZS8zUFBlQy9naGdzcGpuSkVoZlBDS3JWbDZEVzBXV3k4b3E5?=
 =?utf-8?B?bDBYSHBuN2VRZ2FhUG4xcEU0d0cySmFuWFZ4ZHd5T0htQmJraGFLOHdlVjhG?=
 =?utf-8?B?eDZ1aTZQOU1QcURVR1d3d2ovN2hDTURFd2pqYTV0QVRweTB5YnlFNkxGaCtL?=
 =?utf-8?B?Q1FrNWNFM2J3dmpMUWdHOVhieWd0MWlBRGtzbnRDWHFObkR5SGFTemVkcUVz?=
 =?utf-8?B?dVNGdUUxZmp6Zi85SlBmbG9zZjdJQ3Y1bzhxTldJcmd0a2h3b2d6L3dReERH?=
 =?utf-8?B?RUFLSFBuUVJ1TnIzY0ZIMlBlK0xOdElNczhWb3pXQlNQdjl2RlVZSEtoUTRl?=
 =?utf-8?B?KzcyL2t2RUlqeUYxVWpvR0FQRUJpMnRqS1ZhdzVlNGpCQ0VNcWFLcElYLzNX?=
 =?utf-8?B?dHBLZTZraDdPbjVORXdlUkRkUDU0SzRrbW9LNnhvcFFjcHFrUCs3R2xFamRZ?=
 =?utf-8?B?Y1pWci81TkdZT2tzaXB3Vzd3SzRac3FCTnNKMmt5bXoxV2JWb1hhR2NiZWFX?=
 =?utf-8?B?L1Ara2NDM2pxUisvcURiMmZodTZ1Rml1UC9ZZWJIR2U3cXQ5ZEhSRjlrOUVP?=
 =?utf-8?B?RXFxRWt1bzVuSGZrS3lHVkRZVVJrM1cxWXRhVlRnTjkwV0ZZL3NVNGUxaUJ5?=
 =?utf-8?B?azJuQ1JFQ1dQNmdRaVNWMVk3Q3BUaGxNK3ZxOTB3WkcxM1lvSmE5NGJ6Q2RP?=
 =?utf-8?B?Q3F3aHdOMnVKTmh2aXg3cjkwQTh3ZlZwL2dycXhLOFNwV3BVTCtPaUxSRUtQ?=
 =?utf-8?B?NDlkcU5sL3Fsc3ljMFVrNFRXVnBBa1VreHlCZHRJQTBMNHBuS1dOY2g5L2di?=
 =?utf-8?Q?9iime3WHwukcSs1aX+LJt42X+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0e96c1-1e37-45ce-975d-08de0a3078d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 08:14:03.7079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wfOaF5E4xA0DAPg1AEhzeNudOsQAeMJo/1J1g6MuXwISgVI3vyudCaHxMJ7QQtt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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

On 13.10.25 09:54, Sunil Khatri wrote:
> userptrs could be changed by the user at any time and
> hence while locking all the bos before GPU start processing
> validate all the userptr bos.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 79 +++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8dc12064da49..89a789abd3ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -29,6 +29,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
> @@ -758,12 +759,21 @@ static int
>  amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	bool invalidated = false, new_addition = false;
> +	struct ttm_operation_ctx ctx = { true, false };
>  	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_hmm_range *range;
>  	struct amdgpu_vm *vm = &fpriv->vm;
> +	unsigned long key, tmp_key;
>  	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo *bo;
>  	struct drm_exec exec;
> +	struct xarray xa;
>  	int ret;
>  
> +	xa_init(&xa);
> +
> +retry_lock:
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
> @@ -790,10 +800,72 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  			goto unlock_all;
>  	}
>  
> +	if (invalidated) {
> +		xa_for_each(&xa, tmp_key, range) {
> +			bo = range->bo;
> +			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +			if (ret)
> +				goto unlock_all;
> +
> +			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
> +
> +			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +			if (ret)
> +				goto unlock_all;
> +		}
> +		invalidated = false;
> +	}
> +
>  	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
>  	if (ret)
>  		goto unlock_all;
>  
> +	key = 0;
> +	/* Validate User Ptr BOs */
> +	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +		bo = bo_va->base.bo;
> +
> +		if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
> +			continue;
> +
> +		range = xa_load(&xa, key);
> +		if (range && range->bo != bo) {
> +			xa_erase(&xa, key);
> +			amdgpu_hmm_range_free(range);
> +			range = NULL;
> +		}
> +
> +		if (!range) {
> +			range = amdgpu_hmm_range_alloc(bo);
> +			if (!range) {
> +				ret = -ENOMEM;
> +				goto unlock_all;
> +			}
> +
> +			xa_store(&xa, key, range, GFP_KERNEL);
> +			new_addition = true;
> +		}
> +		key++;
> +	}
> +
> +	if (new_addition) {
> +		drm_exec_fini(&exec);
> +		xa_for_each(&xa, tmp_key, range) {
> +			if (!range)
> +				continue;
> +			bo = range->bo;
> +			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
> +			if (ret)
> +				goto unlock_all;
> +		}
> +
> +		invalidated = true;
> +		new_addition = false;
> +		goto retry_lock;
> +	}
> +
>  	ret = amdgpu_vm_update_pdes(adev, vm, false);
>  	if (ret)
>  		goto unlock_all;
> @@ -813,6 +885,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  
>  unlock_all:
>  	drm_exec_fini(&exec);
> +	xa_for_each(&xa, tmp_key, range) {
> +		if (!range)
> +			continue;
> +		bo = range->bo;
> +		amdgpu_hmm_range_free(range);
> +	}
> +	xa_destroy(&xa);
>  	return ret;
>  }
>  

