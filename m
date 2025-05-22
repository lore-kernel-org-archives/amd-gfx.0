Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9BEC54756
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 09:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A4C10EDE1;
	Thu, 22 May 2025 09:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3sV1ACg4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C4E10ED50
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 09:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7BqYC4++x3BJ9jLMRtjZXspshX4npjaOymaDiSbX18UUQvhpnyfNoDV8aq94KwLyZzNROKeWWadJcgsipjxq1iL4pAy/15iWGzrclQidf/1SxuF81aQnwyHb95At2LgRpgwFhK6uWCa2rgOSLHGKhG4RM4yk4hBmxjKzLiYGCD0oDhLgzF2N85bGY1grW39ixllPT38aevuiwlhRQn9IeCcvexLkJjdG16BdMCrns55Jjq7Ipxmu1UQmc5ZAjZ6M/ciALRhYcjEDE1FbOyWGRTpJWL9leia5h6Dv/YDKaERyGBGhDGL5Jy5JUh1nTELhKY1AL0cJeLxWd1N8kR0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSyzEeEiNpBDfXnbpHVYrsImCsUddWTLB7fUmZRByb8=;
 b=FDEwSMxpAobzEehhjXF3B1FD6S0z3yIdAQHuD/e759dKXdsT9Q3+WmKPsAolgdi5HyhzVGa7H+OWfAHC0odpUqer5mw6ON3BSbwbOaExaxnf59HWg5JJulmmzgv4yquqLy29nhiz2mnGXi25cYgv+OkQwiCb/oocTp6vmec7DTlik/y231+gqpfGv6bueVRYyddRmO5Pzb3pkfIBwjC9GO2rADqmTadr+EQh/g54RCjum63mL3ZJTAMn8r0joRUN66RLG1LLLpiyee8IQSVfm0kS+Z9CNiyYxB0hJ5r9jeXNlkKqsZrj6TaIqol5DTiP7bX0Q3ST/BFJ4zRGRkfrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSyzEeEiNpBDfXnbpHVYrsImCsUddWTLB7fUmZRByb8=;
 b=3sV1ACg4F/M10frIV6T9uxSNHMkTA5vRCDqay/qCy9qFqdi574YgsR8iyBk5iorBn2GZvwLUUfre4ukSJSpZV9HU/fcCVlFlu4PAZhSa44NtJEFnPl0n/r33uQzQxD3MnK4i6rgnXW3aj170tB/AVBgmz7K8SJd4s9+UxsZr5E8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 09:26:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Thu, 22 May 2025
 09:26:03 +0000
Message-ID: <5aa81ec7-ce73-435f-a9f6-ebbe475e3452@amd.com>
Date: Thu, 22 May 2025 11:25:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Lijo.Lazar@amd.com, Emily.Deng@amd.com
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
 <20250522034350.433219-4-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250522034350.433219-4-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 5495dc37-ef61-479d-f6a9-08dd9912abdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VC9ZTnJ0T29OeTlOR2xhcXhrV1d5UktNTUNwYnRISDFWOXZ3Ym1sN3VaVXY2?=
 =?utf-8?B?dEdxYU9GdFVPaitmSERqSWpOM245WE9FUlRMYVV6ZW8ySWtpUGEvYXdQMXEw?=
 =?utf-8?B?VW5KYTlZanNXNTFKcmNERjl1WDZmdzVMK3ZWbG80UE1jSUR1SGl2TWREb2ln?=
 =?utf-8?B?d3F2UE9sbjUvQnFZUTY1aldVMXFnYWY0Rncxb21rTUl0NFFyc2d6a1ZsZXA2?=
 =?utf-8?B?WGEvSVB2elhZVmlBSmFrdlh4ZzN2TVJnMGJxN2JYN2RydWl6aE95WUU1V3Q0?=
 =?utf-8?B?VDJod1JJUXJkQk9VWmxuUEtzVlp2T1JTUmJYc1Y1cE5HSkFHT2dDcit3WFkx?=
 =?utf-8?B?NFh4VjdqL3RDQWJROUszaktKMW5sazVvV3BsdFgrdUpqOFljNmxPdW1mV2lY?=
 =?utf-8?B?UGN3YVVWaVljOXRyUnJQVWx4Z3RhOFRuejFkcEVjcmc2ajhMSHFoTTk5YkdE?=
 =?utf-8?B?NkVlZUZSVXRXS0IwSFB1MWdhYXdPeTZteG9yOUdWcVJaR0ZaM3pVWHh1MWE0?=
 =?utf-8?B?bGhCN2NlQ2N3WG54a29VWEo2bURkcXI3T0FsUmRZVUVMcUlxSklrb3N5ZXJ0?=
 =?utf-8?B?SnlCMU01eTduRFN2cFg1L1JNbVlrZVpGSk8xbUp2SGlzdEEvRm4xeDE1ZUM2?=
 =?utf-8?B?UEhxNEE2NmhQNHJMN3VXTVc3ZjZzTzByK0o5RHVRczlxMWY1dEowWFl4OWd3?=
 =?utf-8?B?QlpCSnBmOUdzS0FuY21aaUdVSS9uUUhSV3YyaGtvUjk3eE5zME9hQmdLcnRk?=
 =?utf-8?B?eTREellZSkovRmJhZHhUMW9Sd3lYcGNPTmFZcXN3MlhSSGJaZnNCQU9WbDd1?=
 =?utf-8?B?NC9aUWJ3YnY3S2E2cnlXTGhaM0NOdXhqVFk3T1ZyVFFWbVRCRGNCdkdXMmo1?=
 =?utf-8?B?UjJXdGkvQ3kxZmFFSkc4SXdQVDk0K1hETk80V1FFSHdOTVAvVkpvYmwvdjNU?=
 =?utf-8?B?ZHJ5OGxDRGg1UWlrVGpUREtkbG56MTNnK1hqcVdka2pBMEZPbUg2TlAvUzZi?=
 =?utf-8?B?OURSUzRSRFRhK1JSSGNQRVBQVFJ5N20yaEYwdFZmYW1XaGI4dTZsVkdFTlJS?=
 =?utf-8?B?SHUxdnhlYjZjMzVONC9TNVMyZWkxWE5vbjYyd0NvQXd4NmdkaE92dXk4Qkxj?=
 =?utf-8?B?VVhiUWdGbHVuUC9ETTRoMGZOeVBFcVIxcnZLNmJPaW1PSUdjTERnODhrM0Zq?=
 =?utf-8?B?NDFuQ1F3UVVpNE5DbGM2SWlsUDBiek0vaGExL2pTMHlGQzk3bFlIclR1NzRF?=
 =?utf-8?B?SEdSZFE5MkJvMUovdy9XNHZYQitEcHBobURiek9FclprWFh0Q3E0RVkrR3RO?=
 =?utf-8?B?QksxRkM0aEtmYTJ2SlVMckFVT3dSV2tQNGlQR2lzTHJWM0huK1R1TGNHWVBJ?=
 =?utf-8?B?emJPSXRVb0E5UkU2cTNRR3loRzg4ZE5tY2ZFTmFnd3pvT04wM3NCeVk2bGxL?=
 =?utf-8?B?akt1QzFnUkdZbkZUYXhXQ2ZyWTdvVlJPRjd4VW9wL25uQ0ZJREptei9qMGNX?=
 =?utf-8?B?bmVnRHdvL1M0RFVZbE9GcjRwWmQ3U0pXTWwvTFpORUJNT2RtdTFMR2JhRzBv?=
 =?utf-8?B?SVFlSDdHdDRqVFVMd28xWDh2bmFDbXhPSkpLY2dOZDNjTm5PNTJHOXB6OE1L?=
 =?utf-8?B?MWh4K1E1NGhETGQ2bVNiQzVIN3BYb2VxV1JkYU9IS29wcU9IWTJRU04xMnBa?=
 =?utf-8?B?S2t4aG10N3hseTYxd2p4MFBSclh5S2RRSjJGUTZ1c3dicFJkTWdabzZkcFhE?=
 =?utf-8?B?NWdhUWErQmlBSVpHUDcvZ0tBbTFlYjRNTVZRV09jdjNrY2p2cXRDRXMyOXV5?=
 =?utf-8?B?c29CRDFvWlA3QVg5ZVpna3ZFTFpGc3hFZmY4MjlmTFBNelA1NFdXMzhYRlps?=
 =?utf-8?B?K09kc25HOTc4akRzUGJZdnQ0RkIrK2U2SHVmUlFWZ2pzc2kxdzlkUlU0dEVk?=
 =?utf-8?Q?YHmWDgpD2/k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2lCOGd0UXZFWFN4VE5OYXB2TEIrS25kamhraUV1a2M1L20zSWpZYnQ2RWZl?=
 =?utf-8?B?RndkMS91ZUFJb2xRQ29sNms0SmNxeFBQS2h4RHJROGhmalRwbmloZG9HR1U2?=
 =?utf-8?B?MWwwOU9ZVE00R0hRa1o3OG14UDRtbmpmeDFLUW5wMCtzVTJrU21lYUg2bEJE?=
 =?utf-8?B?QStyNlpPcTR5K05GR2drWkJyQlNlY25mcG9zRzFNcjF3YUtRNitmcmE3czFx?=
 =?utf-8?B?d1FEaEhrUi9mWmR4b0E3MjQ5QjV2cXRXWkUyZytBR2ttMDQycWNQNlpMUE9Y?=
 =?utf-8?B?WEJjUGN3aWFpY1BLL2lkRVFHcjQ1QkhwaUZBY0I1ajhEQWh3V1RTcnJROEJv?=
 =?utf-8?B?cXlHYWhsYW1oNkZvOFVQUm1lbDZIOEZkQ3VqZTIvWWpDRU81YWJDZUoxbnE0?=
 =?utf-8?B?Q0Q4dmdFNFM2ZDhmYXgwS1BISmxZVXdOVkpZSXhXSTI0NnRLcHdDYUMxelg5?=
 =?utf-8?B?ZmV4WjJLdUR6NXdyeE0zMnM1d2l4N0QybmRnRE9Sb0xIdSs5NmlJalNLeHpI?=
 =?utf-8?B?ZitHYSs0N2VzejFSYmpTZ00zSm5Ha2RLV0J4UE4xTUVUdi9uajlnc1JlaUpp?=
 =?utf-8?B?bVRJTmpTZEZ4c3VxMmxRK2RmRmZIN0NVbWlJcjEyK1REVWtyZzFlLzc4RzdS?=
 =?utf-8?B?N1ZLdmlmaU1XdnlGK2RDdmcrNDREaDFVWjloWkE1MlpJdHRmWUZneU5td0RY?=
 =?utf-8?B?TWdWMjlqV3FBNVlIZjk3LzZCbmg4ZHlJZXN6a2FOTzVYSTVPVFBXM1dIdGI3?=
 =?utf-8?B?aVdabjk0ZTRuM0JWbVhsUmhyalBUSlp5SjlJZ25EQSt2bS9QUW84WXJwNFp1?=
 =?utf-8?B?eFlJMGVIYUZMcGI2TG43Y25LWnlCSDgrM2dmazhHNTlrVk5ZdWU0bkYvQk04?=
 =?utf-8?B?TTliYXQ2QjJpU3QzSDJRZnZ0Z2dON2FNMUlMOGQ3ZWp1N01UbThCR3ZSTm92?=
 =?utf-8?B?NWFSbGlJN243TWI1QUNQMWtpNCtFK3d0SGJoaWw1TFl2eTdCUjl1R0didWRJ?=
 =?utf-8?B?Ukl4RkozWWRPMFlESFRIaUJTaksrYmNON2Z1QlBGeTBLZmJ4S0t0Z3ZaT0F1?=
 =?utf-8?B?TThKa3lJL25ML2dCRW5VcGtHUlBVTnJDN3Y1aTErTEVaMENsRzl2Mnh3N2Z6?=
 =?utf-8?B?NjVsaVhZMm5oaXRIUGZlcVowdTc5WE1reUJsekgvRWF4dGplOG1lWVFHZmhC?=
 =?utf-8?B?VGhEamZjNEpHK0JSa1MvMEpUTzIxSTEwNmsyTkI5aUxzNDREWjcvemQwQ053?=
 =?utf-8?B?Z0toMVlibHFKSmZjam5xazlUUU9JelU3T2FTVzBUK0xIZFhudi94N1hKUWVm?=
 =?utf-8?B?QnI1YkdTRjRVbDRXSktiNFpKK3FOODlZMG02ODBXaHAyMldGaU9lMlNleGdz?=
 =?utf-8?B?bXRXK0ZSNmkzejNrTXE5MVlZbnJEVVN5L1ZpRlZ2OHR4bTFidjBOWEV3Mlo1?=
 =?utf-8?B?MUFrVW1wS3ZsMEtJNlRmd2JXSm1pMnk4WEhZZm05cGVvL3h6aG9DNDFWdEd1?=
 =?utf-8?B?b0NyU0NQRkNpN0R4UUcrbHZJeDhrL1Qva0I1WUh0cGt2OGpjTmtGT1J4MHcy?=
 =?utf-8?B?dVRSbUl3eUc0d3VQOCs5S2pHOTRMS3BGMDNRVEczTDhUNXhRYTJRYVF1Q1ND?=
 =?utf-8?B?dCtabDBXeklmbkJzcnJFMm0vMnd3ekMvMkFLNm5EV1pveDVJZWQ2N0pWWFZX?=
 =?utf-8?B?SVpLZS82c3lwdTFTTENkY3ZST1ZXMVFiekhQYTJWbjVZODhEKzF1blUvZXdI?=
 =?utf-8?B?dFBHalNxT29lNDRaTTZReGJIaVp5T3c3bFFVUmg1bFVCNk5wMHUxcE81eDBU?=
 =?utf-8?B?RlhFbWdPTUxEMXdYWGNsblY1bXUxWHdWZGE5ck5RTVV2dmV5VGlaWmJqZVMx?=
 =?utf-8?B?VEZuK1NqREYrUjJaZ3RMcC9waDVyTHlwVTM0WnpLc2hsYlV3S095cFpvbkdP?=
 =?utf-8?B?dmVxQ1NUSE1OTXFPWVZrM1R0R2UzbHZLOWkxZXQ3ZDVMRmR0clpCT2J5RW5N?=
 =?utf-8?B?bnA3UWdidFY5RkhoZmxkY3FMZlZyNTc0L3BLdkJ4c2xvZnBwOFVpc0h4eDRx?=
 =?utf-8?B?Q3RCd0JkemN4RzJqQzFXYSt3ZVlNNlBEeGJkQVpOZUNBTWRtbmdUekJydDNH?=
 =?utf-8?Q?bDtUeRn9YHCW0kdJhFklWclI7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5495dc37-ef61-479d-f6a9-08dd9912abdb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:26:02.9779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYIYke3SiH8kTjatybyWV9rVZw9yjUwK0wyhXJcPpGt+nXRCoqxH+q4JE2dNv8io
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
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

On 5/22/25 05:43, Samuel Zhang wrote:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
> 
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 23 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 13 ++++++++----
>  4 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e5bb46effb6c..97389168c90f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5065,6 +5065,10 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>  	adev->vm_manager.vram_base_offset +=
>  		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>  
> +	/* fb_start/fb_end may be reset in get_fb_location(), set it again on resume */
> +	adev->gmc.fb_start = 0;
> +	adev->gmc.fb_end = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes - 1;
Why do we need that in the first place? Updating the fb_start/end in get_fb_location() is actually fine.

Or are the fb_start/fb_end values still used anywhere they shouldn't?

> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..35df4be6ef2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -38,6 +38,8 @@
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
>  
> +static const u64 four_gb = 0x100000000ULL;
> +
>  /**
>   * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>   *
> @@ -251,7 +253,17 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	mc->gart_start = hive_vram_end + 1;
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* set mc->vram_start to 0 to switch the returned GPU address of
> +		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
> +		 */
> +		mc->vram_start = 0;
> +		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
> +		if (mc->real_vram_size < mc->visible_vram_size)
> +			mc->visible_vram_size = mc->real_vram_size;
Make that here mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size).

> +	}
> +	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	mc->fb_start = hive_vram_start;
>  	mc->fb_end = hive_vram_end;
> @@ -276,7 +288,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  			      enum amdgpu_gart_placement gart_placement)
>  {
> -	const uint64_t four_gb = 0x100000000ULL;
>  	u64 size_af, size_bf;
>  	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
>  	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
> @@ -1068,6 +1079,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* always start from current device so that the GART address can keep
> +		 * consistent when hibernate-resume with different GPUs.
> +		 */
> +		vram_addr = adev->vm_manager.vram_base_offset;
> +		vram_end = vram_addr + vram_size;
> +	}
> +
Please make an else branch here for the XGMI connected GPU case, or maybe code it like this:

/*
 * ....
 */
if (!amdgpu_virt_xgmi_migrate_enabled(adev))
	vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size

vram_end = vram_start + vram_size;



> +		vram_addr = adev->vm_manager.vram_base_offset;
> +		vram_end = vram_addr + vram_size;
> +	}
> 

>  	/* The first n PDE0 entries are used as PTE,
>  	 * pointing to vram
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..e6165f6d0763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  		/* In the case squeezing vram into GART aperture, we don't use
>  		 * FB aperture and AGP aperture. Disable them.
>  		 */
> -		if (adev->gmc.pdb0_bo) {
> +		if (adev->gmc.pdb0_bo && !amdgpu_virt_xgmi_migrate_enabled(adev)) {
Better check for adev->gmc.xgmi.connected_to_cpu here.

Regards,
Christian.

>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..23d02965ad65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -413,6 +413,11 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
>  	(0x001d43e0 + 0x00001800),
>  };
>  
> +static inline bool gmc_v9_0_is_pdb0_enabled(struct amdgpu_device *adev)
> +{
> +	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
> +}
> +
>  static inline bool gmc_v9_0_is_multi_chiplet(struct amdgpu_device *adev)
>  {
>  	return !!adev->aid_mask;
> @@ -1726,7 +1731,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  
>  	/* add the xgmi offset of the physical node */
>  	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (gmc_v9_0_is_pdb0_enabled(adev)) {
>  		amdgpu_gmc_sysvm_location(adev, mc);
>  	} else {
>  		amdgpu_gmc_vram_location(adev, mc, base);
> @@ -1841,7 +1846,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (gmc_v9_0_is_pdb0_enabled(adev)) {
>  		adev->gmc.vmid0_page_table_depth = 1;
>  		adev->gmc.vmid0_page_table_block_size = 12;
>  	} else {
> @@ -1867,7 +1872,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  
> -		if (adev->gmc.xgmi.connected_to_cpu)
> +		if (gmc_v9_0_is_pdb0_enabled(adev))
>  			r = amdgpu_gmc_pdb0_alloc(adev);
>  	}
>  
> @@ -2372,7 +2377,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	if (adev->gmc.xgmi.connected_to_cpu)
> +	if (gmc_v9_0_is_pdb0_enabled(adev))
>  		amdgpu_gmc_init_pdb0(adev);
>  
>  	if (adev->gart.bo == NULL) {
