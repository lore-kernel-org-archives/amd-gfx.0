Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25250D3DEAB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 18:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B474A10E96E;
	Fri, 18 Oct 2024 18:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQHgLZ+z";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9E410E96E
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 18:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnvpGjDHOiVxuepjG875SS7BK6knKSoX3S+ohkfLBPyZHf9I8yEYe2n94u+PGebGf6jDpdsG4eSkum9MQMLYc2An/A2sBvwGTfbTAZ1bITLXLfegEHQonwQBzCBd0JDJsK8cZL8QSCQ7Pg1MUscpO44X0MJnir3BKIZL0QhIDXsqShi4z+E/efmeCakbmXYA6iFaOaM9mjXfVIdvDwf5oojl2g1uOwPMIOVZa/CmLj0U99gpkRBSoEfaqC9rE3R5cqLkzoOPg2X5Rw59g+7EFI/XCcsPZNtjRAqKnTgJ9QDYgGxsuyUm1Nzq7Jt7OdlWMRccRz3fb2Z5bzJQujuLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw7S7PbaiVbK7dScW00aRUHK+NJQ16oAzo4fg5UlqU4=;
 b=kIEJ+E6sY43/w58YKNF8+gWgjA8Ej8EvfG2L1qyrFncT4fKdAjQCS/JdysHAL83Foc80HeTUwOP/R7pBI7/8mTmcEcuG46oricohuGRd3Wc2EXV1h2wBBIWn1YXBfjoTugkwxEFK/Y+E8VKX9Ny8qbfmX5hxJgItWBNQMbL1+mf8lDj+Nj0Dq8doFp8MqGDzwxPlcCYWI0kRuu2MzXALyzvAsXzv3YDqtVDWiOgs3FhJ3qxDI75Dd0/3ycCtydraYuAzFsBEKWMFTI2FmWak/2+GijpUVUU6k/ick4ZGTzzW4FJVijbEp+NO1tS4B3Rt0ozf6z2zsV4AxmMC7OX/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw7S7PbaiVbK7dScW00aRUHK+NJQ16oAzo4fg5UlqU4=;
 b=MQHgLZ+zihckrEOUW845LOa2wcPccwFZK6KbEo4tosxc2XNAgmNtOjy9ajpkyvl2Gd11Hw6M4Gz9yzMCgWCMrVzz8xMTBly/PBjyTsdxShvbIOzuP2Fq0/BTVEOCmLaWEQ+Y4paPIJZCPDxXZ4UmF3gNlpYPcw6jgb2dSi7VXaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 18:42:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 18:42:32 +0000
Message-ID: <d4fc0aff-07a8-4ed3-a9db-f0bfaa335a8b@amd.com>
Date: Fri, 18 Oct 2024 14:42:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: Don't print L2 status if there's nothing to print
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jay.cornwall@amd.com
References: <20241018151214.96717-1-kent.russell@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241018151214.96717-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef0bfe5-8b16-42c7-fbcc-08dcefa4a080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzNiU3htMGVWdWFJOFJmdVd6S1YrdUprdDFVUk1iY091UmZac0RKYUY5d0JG?=
 =?utf-8?B?TkVxM0RxaWlCb1lhYkhMR2FrZU1pOVMybnY3OEdGbHdBSUxZR1E3R1h0Qm81?=
 =?utf-8?B?L3pHVkUxd3JXOFZ2VFV0Wk1FR0VlWXgzSlU1QXpiclQxZXZvTGJGalhMcjNN?=
 =?utf-8?B?cUxiYzBwMEVTT0hrMGFtTm54TUk2dXVuRDlXNjJMV3VLVWhtVmJqUC9ZcTNa?=
 =?utf-8?B?QmJnbVh4Q0FjbElvM2RRQllZYXFITlhDRkpxZnZOckppMS9OY2kyR3dKOVNC?=
 =?utf-8?B?YWg0dHFxbnlBYkNHQjV2N3BzVnVXWFJVcUVpclk0cnFnMEtwOXhFTEN3SCtr?=
 =?utf-8?B?UWdWbXpvbXRiKzdLTDFNd01OZzdYQm5LM3MrM1d3eVd4T1NRY1g4SkxwL24z?=
 =?utf-8?B?Vk9pcFprMFJxRXBSU3krQmtZRXY3djNiZ0svTmZmTWVvZVdSNGcrdHBYS01m?=
 =?utf-8?B?b21kakJ6d1UwaXlaNXE3aWp0Vk9DeDJicDkyR2VtUDNiRnVENGd6VVc5M3hp?=
 =?utf-8?B?YVdNV2pzSkxoK2Zrbm01NEhXT1Q2VjZYVjZYa3RUWW5hdFg2KzlkSzh1OWFR?=
 =?utf-8?B?b0lPUUFEMnl1MjVTcmxqL1BoL0VhdnpBaDZaTmdyWHA5WDhlaTJONG5JS0Rx?=
 =?utf-8?B?S3pGNEN0SUE2MXlrSUpWMGx6QnF0Znp6NXFNSGx5OElMa0VyMmh6QVZmK2ti?=
 =?utf-8?B?ajFCUnkxblE3MFN0ZU9WZnJUd0RRQVQ3ZDVwNnpOcHlESTNYK3RvckM3RWRu?=
 =?utf-8?B?L2ZPWkJWVnNldkQ4R3pxYittckNPaXgxQjQ4R1dvR2NpTkNpZndQTURobmxn?=
 =?utf-8?B?SnRnWUF1SlBadVJ4d01FT25ySXlhSzFkcjBzY29UZjNVTnZZaUZpTVJTb0pV?=
 =?utf-8?B?NHVrKzdoUnc4T24yU3h4a0hhWDczNDRobDZ1L0YrejlObmRkTXcvRHRnZ1FK?=
 =?utf-8?B?SFdldVFkY3dYUFRvMDdCNW05R0JEUENpMG8vb1g5aGlhbStFT1hTQmlST1RJ?=
 =?utf-8?B?UWxrYlNlVHhqV1YxaDJ4cDVrWjN1NUExejFvU0xZdGtxMk1Jbzc2OXRZalJO?=
 =?utf-8?B?aHl0SnhCYnFNY3RoOXBsWVF4dVAvcmhqaTQvR29iRmR0c01VcDZ1dG1FQnNC?=
 =?utf-8?B?UUliM1NLbFRyd2pSelI5S3NLUHlSWDl0MWsyek12RlVnVHovRTcxMmd0T3hF?=
 =?utf-8?B?ekdHUFk1bDZuTk52cW1SZHlqWlY2elUvQkNkS0JpendlQXJOaldjRUl3d2ZL?=
 =?utf-8?B?Z1NYbVNxM1JURkQ5YmpZSnZRblp3YmErblFPWVNtNXJmT3B2TlFMQUROV0Zy?=
 =?utf-8?B?anI3cTNhZ2NlWE4xZ3B5bStCS3AxbkNTcjhiMlBwdEl6c1RsZC80TWJsbGhh?=
 =?utf-8?B?eGRNNGlQanVKcVV5ZEg5TnBLcG9ZLy8vNmdNUVFkV29DR2Q5N3hhUjJqbnZF?=
 =?utf-8?B?dUFVR2xremZMcE10ZEtXaS92L2ZVc0tiQWZ6aGZLY1V0cUE3aVEweXpaQVBK?=
 =?utf-8?B?S0IvN281ZzlaTEg4Zm41MmdHYlQrMXBkYXhCYllsSVlERENJbXhlUUtXa0NN?=
 =?utf-8?B?UzBzMWg3ZGNhQ0NiUFQwUnVtNk4zTFY4T1Rjb0tWZEh4ZWpjS1BhbVZobHBT?=
 =?utf-8?B?RnZscXlCZDV1Q0JvcTF6dkJSM2FJV3FZclF2Ry9GZndvTEpRME5zUmhhQWhu?=
 =?utf-8?B?VTF6VjZJUEIzRTB1OGJpZy94ak4rMHhDUTl4bnhkYTUwVVhCNlI2NVQ3LzZM?=
 =?utf-8?Q?h3D8uVPdSE1LvGJnUPiaALNukDWVCVP9oa93ekE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFIrWklsNFhsUmRLTXBzTkNNNmwzclZNZEhLQ3VxdG9DdEhyZ0hiejNYQ28w?=
 =?utf-8?B?TFNCWk5SaDQwMFlJZGwzUmswTmtRNlN4UFREUGVkZ0ZPNHdFZEVZZEZ2QjhR?=
 =?utf-8?B?UlRKNjBjSE9CNE5JYjVpeTUzWFlxeXRwSGNTRENKVlA4REEzRE8yRm5GVnJv?=
 =?utf-8?B?bU4xRUc2aTM5WlYwN3hmaXJmd2ZuK3RzaEM4ZlkwMTZGUVVMcUZjdjRTdWUw?=
 =?utf-8?B?SmpEZEpHNzJUVFhmYlFnV3M0a2JUV1RKczJGY240VkFVMkFOYjYybTBMME1C?=
 =?utf-8?B?MW1pMnpOQ1BLVlFhT2ROcEsxL3JNbllDS3d4OUdGcktnNVJTZHFpcDFIL2cr?=
 =?utf-8?B?K3ZqblV2OUN1QVVtMXEvRVJMNnBDTTBsS25BdUw1OGZEd3NoNDFMakt3bGpH?=
 =?utf-8?B?ZkErOXVQdWIzbGhXZEpseXVVQnN0UzJMZEdKaVh5VnlJcWErenk3Y1lUeDVo?=
 =?utf-8?B?alJKQjREQU56Mnk3UGYvVTYyTk9sS1MySjdNSisxREdKRGwrUEZRNk16ZmVO?=
 =?utf-8?B?M0ZpK1oyU0NickFucHNWeGdieVFxYjhqWW91Z3FOS0hPd1U2SEdlN080bEVE?=
 =?utf-8?B?RG5rSnYyaTVnTmdqZzA3QUdybmZDMUpVWDNvUmZjQnBjaEtjQUp3VUNTMndV?=
 =?utf-8?B?bkcvbFVZUDI1N1lYUFpDc0VYdW9IVEFvOTMrWlZDS3d0T21YZzNMR0FmcitF?=
 =?utf-8?B?cHdqNnljSHBQZURzQkxXLzFKeVRaOXJtRVNmL096Sll6bW1HaTR0QjlRc2VE?=
 =?utf-8?B?aFVlV25mRWMxNHYwZmw1NDdzdUYvWUE2dmNNNG05TWhZSXdSTldKKzNUNk9m?=
 =?utf-8?B?d3FlMVB2aGVjL0lGcmFoU2FNYXdvazdCa2ZQTHBaTVhxM0lZUXZOakZhVlcz?=
 =?utf-8?B?NXdpV3hES1kxVHRzZDl5cXRhU2g3UUdjVXM5SjNZWllBRldFb2VpMzFBdW5K?=
 =?utf-8?B?d0dUTnRWbGdKQnBQcWpCbXJxdDV3RTBhZVlvNDNvcWY3a1ljR2N2VU9KZnhM?=
 =?utf-8?B?dE1sOEFJZTV0VlBvRHRaZHpGdkIrOGlPRVlkRXFRTkUwcm5DdXVWZ0g5a3Uy?=
 =?utf-8?B?OGxLSWdHWDVmK1FKYnBTWXJaY2xDWlRwZzd6c1RRbEIwdkZBamVqcU9IaGdW?=
 =?utf-8?B?ZU1jZGRCaHQyR3grS0JMcXVta1BjcmZncnFzUDJEUTBsMGxqOEM0bG1lR2ps?=
 =?utf-8?B?QlljanlIQ1hyYUdFakFpWlYvVGg2bDU1MjZhS3lwcGdPUTlVaFNqZVl6RGFI?=
 =?utf-8?B?V28zME5lSjh2bkozRDN4NU5UL21KNmJMMzZvVDAvUEtZYVo2Z2EzaHVTWnhW?=
 =?utf-8?B?cjd6LzRMMFpTV1RnUFBZeCt2NFlzTjB4dGs4QXZUZUhySjdHa0R2M01KL1Yv?=
 =?utf-8?B?ajZ0L1kxbEt1d2VTRDhUYnlaL21KdzUxdkt2V2liMktYNGJrTVJQTmFGYjl6?=
 =?utf-8?B?dzJvRzNCOHdYY3AxZHRTaFFlVVBxS05kWFkvUy9xc0srbkcxUXFUcWhuWHlC?=
 =?utf-8?B?aEtPN0pMVkYxckZMSzhjbnFUZmtOUDRtVVNOdEdsQlNGYkFLTU5zcWlOd1U0?=
 =?utf-8?B?R3p6SForSnQwWXdJRWxoZHpaNXZaWjZVaUdjUHRTbkdNMkJSSzFFNmxoY2FO?=
 =?utf-8?B?TUh0TVVnajNKSHJHNGhGbjEyQzFOTUVhdGJhZXRwMEJtT29WQkQrZTdCY09V?=
 =?utf-8?B?T1hheWVDZkZSSzBtMmJWTjFmc29PUHFSY0FqQ2xmdzIxZUkvdUpueDFQejdn?=
 =?utf-8?B?bHlWR2hxS0MvZEtSUCtPOWEwYUJVejJhSkRtN3o0SlloVUlBc3NkbXFzZ0s5?=
 =?utf-8?B?NzIxMDdyY05iV1RJT0RFc3duUkh6V1BXcTFGYjlmN2ZNcmlvWXA3VDBBVTl3?=
 =?utf-8?B?cEFCT3c3cHA3N2F6ejJzN0VrZnZ5ZHUrQlkwWHlOdUp4UU9WTFV4ZktLdVRZ?=
 =?utf-8?B?cStVNWJRWlZLRDh5eVFsdWExamtNQ2VSRVhiZktrdG44RUdwdVFic3d5dTZI?=
 =?utf-8?B?VVNhYU9tNmF1UWtTWHFjVVJWbGo2cW1iOFdCL0ppaE5GMkFVTXc3TGhXU3Yv?=
 =?utf-8?B?REdvaFdJaFNGOXdzSWE5MlJ4MlpXSDBvQ01YZmdTUVN6ZFg1VUZxVzhtQlV6?=
 =?utf-8?Q?nkTrRLYATrWMCmtGewWV4cxkG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef0bfe5-8b16-42c7-fbcc-08dcefa4a080
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:42:32.7251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6a7lUmXymI0onutwcVM5pYVFE49psDZyESgk2Ijjk9u2MkBuHa8Q0aRSPkpjjBuhZMZ4cArWFtRdUv8R/i8fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
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


On 2024-10-18 11:12, Kent Russell wrote:
> If a 2nd fault comes in before the 1st is handled, the 1st fault will
> clear out the FAULT STATUS registers before the 2nd fault is handled.
> Thus we get a lot of zeroes. If status=0, just skip the L2 fault status
> information, to avoid confusion of why some VM fault status prints in
> dmesg are all zeroes.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 10 ++++++++++
>   4 files changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 5cf2002fcba8..14a52c33bffa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -175,6 +175,16 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   			addr, entry->client_id,
>   			soc15_ih_clientid_name[entry->client_id]);
>   
> +	/* If status=0, we don't have anything to process. Most often, this is
> +	 * caused by a 2nd fault coming in before the 1st one is handled.
> +	 * Once the 1st fault is handled, the fault registers are cleared, so
> +	 * we have nothing to print for fault #2. In that case, don't try to
> +	 * print the fault status information. The information above is
> +	 * sufficient to note that another fault occurred.
> +	 */
> +	if (!status)
> +		return 0;

I'm not sure if this lengthy comment needs to be duplicated in so many 
places. If you check for status == 0, you also don't need the 
amdgpu_sriov_vf condition below any more, because it doesn't read the 
status register under SRIOV and status is 0-initialized. So you could 
just do this:

	/* Only print L2 fault status if the status register could be read and
	 * contains useful information
	 */
	if (status != 0)
		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
  								   status);

Regards,
   Felix


> +
>   	if (!amdgpu_sriov_vf(adev))
>   		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
>   								   status);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 4df4d73038f8..c5fe31070cf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -144,6 +144,16 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>   				addr, entry->client_id);
>   
> +		/* If status=0, we don't have anything to process. Most often, this is
> +		 * caused by a 2nd fault coming in before the 1st one is handled.
> +		 * Once the 1st fault is handled, the fault registers are cleared, so
> +		 * we have nothing to print for fault #2. In that case, don't try to
> +		 * print the fault status information. The information above is
> +		 * sufficient to note that another fault occurred.
> +		 */
> +		if (!status)
> +			return 0;
> +
>   		if (!amdgpu_sriov_vf(adev))
>   			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index e33f9e9058cc..fcfe512f1271 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -137,6 +137,16 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>   				addr, entry->client_id);
>   
> +		/* If status=0, we don't have anything to process. Most often, this is
> +		 * caused by a 2nd fault coming in before the 1st one is handled.
> +		 * Once the 1st fault is handled, the fault registers are cleared, so
> +		 * we have nothing to print for fault #2. In that case, don't try to
> +		 * print the fault status information. The information above is
> +		 * sufficient to note that another fault occurred.
> +		 */
> +		if (!status)
> +			return 0;
> +
>   		if (!amdgpu_sriov_vf(adev))
>   			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 010db0e58650..6da2ca28375e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -675,6 +675,16 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!amdgpu_sriov_vf(adev))
>   		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>   
> +	/* If status=0, we don't have anything to process. Most often, this is
> +	 * caused by a 2nd fault coming in before the 1st one is handled.
> +	 * Once the 1st fault is handled, the fault registers are cleared, so
> +	 * we have nothing to print for fault #2. In that case, don't try to
> +	 * print the fault status information. The information above is
> +	 * sufficient to note that another fault occurred.
> +	 */
> +	if (!status)
> +		return 0;
> +
>   	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
>   
>   	dev_err(adev->dev,
