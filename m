Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC9EC02197
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 04:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6445E10E185;
	Wed,  5 Feb 2025 04:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gk4cPWxM";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C462510E185
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 04:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUGNm0SwoIYggAw3qvhxHp6BCRECpVBlvy8KBlcmx7yR+8AMhZ55pNuvZFEqgBaKiVuvHr7qL6aeebEHQ6XlQ/z2kUWVw1UBcjWdWeolM/BYjw5xRjXRPWkfCIgxUI64UM3qywI7Sffal0FtKcNmb71CgMMmhBvEpUNxkZH1zWxw6tB1heYTsbg+/ZbAznxeJsi7hmtZSeyovY7rntjaDxZ4Y4WVUOtw5xgt3Lnyskse8yFCzRiMTN993f4HLu2KIjnGGb8nLbF8FI9RrUHR/UjVFK+vCnUQW4ig7r4Fu7N0A+PfgECQedTe1TQSBMN/JKd5Tx9fzoJM5CRAcYM95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMyp2FydFtAUkury9aRfObxocfGkRNNfddNZM+1y0xw=;
 b=yWUrrBc922dJQ5cOKzMno97zUnV3BCoCZZWs4GgQQI4GEGGWDqvk6ywH3EK+eYxM7prG3jh4u8LPF+sSEm7f5zkgtN0wkN3viItz7GvlEG8I3qqHXPY5Y/MS/+k55XJTowNlMU/fWRJyrSOwQ98FyR7XVumYfTnltpJNFPbTtTp1csaFCxI4Q2dhlMOigvbxyOPqKa38nSAOPZmC2/hqQHgtiPHLwETkomv6w69YC31faorTHkuJt17czvSVfJofbHoBlGGEFFJ6dt+7QwWyOQtP/FTi3zWVB8QeiZ7ed1NqtNPakIqjmPAcu3Z5GWeKU23wu1SFksB90tJgMyxzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMyp2FydFtAUkury9aRfObxocfGkRNNfddNZM+1y0xw=;
 b=Gk4cPWxMrCgN1yF5GGI7a67Y9M+CR8LB7ElBuHSkZj3ORW9uorNnSfBqHo4bmU3Y61YUMckvW6Vef2FFdVUnNv9HY/NzbjbXqd5wsOK/tk5Sy8lrzhYoszcnTzYkCOPJzec9SfWC7yIqwb7Ss8tQ/0LqHzdiNQLFTrRhL9K2Xsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 04:32:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 04:32:14 +0000
Message-ID: <28824a01-ea42-43bc-9d9f-9d2fe4a77402@amd.com>
Date: Tue, 4 Feb 2025 22:32:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: add support for IP version 11.5.2
To: Ying Li <yingli12@amd.com>, amd-gfx@lists.freedesktop.org,
 ray.huang@amd.com
Cc: Richard <Richardqi.Liang@amd.com>
References: <20250205024837.976890-1-yingli12@amd.com>
 <20250205024837.976890-2-yingli12@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205024837.976890-2-yingli12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:806:a7::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 227c342b-33c5-4495-61bb-08dd459e10a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2V0QjlmMEVhcFg3UU5hMkJUbWJManM5UEUxNFJJc21pa2RYSjFaMUQ0VElp?=
 =?utf-8?B?dVFCWFpWbGo2VVl4UmtxUFNzTm4xWGFLeTFXd3hCZXJyQ1NRQ1lCNEM2WTVI?=
 =?utf-8?B?UEJoVXc1Ui82MTZKTnkwbEpTRU1VMStad1VaUW13c0JabUI1eGV4UkJpZWVh?=
 =?utf-8?B?dmhyQ0xjZXdnQnpOVXY4QkcwN3RoQjlhYVloQ0R3bVhmbDlrcEJ0Qkw4Q25L?=
 =?utf-8?B?dGJVd1ZiNXhOS3B2d1VWck5mVkc1N1hTSFR4QmN3bmRCaXBNM3dLTCs4RTQ4?=
 =?utf-8?B?Yjg5Wmt4bnE4MDhpWk5kVWJmUWlRR0RNNGNNSUdONFNVMEt3OTJYN3ZQdDIy?=
 =?utf-8?B?a0ZrVGNiL0ZYU09LL0dmUW1tbXNkMDBjYktlYzZ4SnkwTjdZSXp4cXBpTjBJ?=
 =?utf-8?B?STVDekE4SEJKeGtWakdxOFJWdGZ1MnlmR3RpQ1I5VE4xSzNHd043TEdqN0NH?=
 =?utf-8?B?ZFc3L1VLMnliOUtsemIrTG1ZS0owVTk4c1I1OTl5MmFZbThDTXVodjloUEUw?=
 =?utf-8?B?RmVvc0d0SnJaMTZaZ2NzNitnLzU1Nng5cHdobFpGSjliNUd2WWlPM1FuK0Ur?=
 =?utf-8?B?N1NVVmdZUXZnc2cvclVzUU1TVHplNElUeHg4NHBjSTR2cWlEYlBaMUh0dTlp?=
 =?utf-8?B?bGh3NC9mSlh4TG5zS1FsMTU1cmRQVmxVRWVIMkpMd0JOR296VC9FbHdpQ3dT?=
 =?utf-8?B?Z1kxZlpRMnBjOWhyVW83QVRFRWVRT2dCVXh6VlNFZzNCRkJ6b1BvSEcrdVFr?=
 =?utf-8?B?VGF6SkswUFpKTlh1OGFkc2RQRzViOVBaTXNkSG1XSWxMb3ZiSEx4c0RoaXVQ?=
 =?utf-8?B?ME53cUNaYnp6UytYd1pOYmFMUE5xclRlb040b294WTE3R3BkQTJxOVRQUDln?=
 =?utf-8?B?UUI2bmZQTzNtN0RRNGJZeC9Fc2xuRWZjWDlnSnV2RytLc1VhVWhGTnVyYnlR?=
 =?utf-8?B?U21PUlduVWhlR04rYjQ4UFVzc3FQOTNWa2xDQ082K05XbE5tMVE1VlVBS0tC?=
 =?utf-8?B?Vkc5cUFEaDJPOVo4SDgrSTdKeVV0djZObWlZSGlTVWI4cGg4QklrU1RCRHRY?=
 =?utf-8?B?ZG1UQVNBZHZHdG5XQkRYTnFJTmRmRmdQb3d5dlp4VUFESzFIRjIrV2dUakJq?=
 =?utf-8?B?Y1JoQk5CaVR2Nkh0VTFuWlg5dVphQi9jSDY5ZGIxV2FkdFRjR3JVY21CSHV3?=
 =?utf-8?B?a3dLSVBZNUU3YUZPbmlDRjE2S2h4WlBwU0g3amIzWGZkQnFPTTl2Y3o5R2VL?=
 =?utf-8?B?QmppMG9CL213TllvL3JaNkJHRlBSMnFBTC9yWk83bi9hY3lNWGo3R1BTZU9W?=
 =?utf-8?B?c1AzQ3dEbmZZbC9sVUl4NEEzeWJyVWdwU3FialhpaHdoL0h5ZFVzOVhRdjVV?=
 =?utf-8?B?T3NVallOZmVpWUxGQlJMMWFyMFk4V0EyNjJXdmZydTBkcHA5a3RWK1pCSnBl?=
 =?utf-8?B?N29nUjRwMk5ZSmtjT3U1ZEZ6TC9veGVCK2RZckZ2ZVlwL2NxajdSTGsyOGxU?=
 =?utf-8?B?bktjYXE5SVVpNmVyYVoxOHFpSWFMM09rOCtTQ3p5amVVOC9RaVpsTjAwSzVp?=
 =?utf-8?B?YTRScXhIbUJkKzZoYWdHMk00b0lXQnVGanJRZ3c5ZzdmSlJNaGhmdlA5ZFpR?=
 =?utf-8?B?ajQxdU1IYmxOY1N2WEJGdldQK2Uva0dVN0d2MWN6K21mcFUxM0JUd3VSZnZw?=
 =?utf-8?B?NkRJMEFqN3dDckZhME4xR3czSEh2QXNXZUgvcFNTbloxNDc0eDljdkY0VWky?=
 =?utf-8?B?THp5MHJmWW9Ka3FaNTJHVGtrc1FxNklRUnFRT0I5TmY1aE52UlpJRUxtQzd3?=
 =?utf-8?B?SytESngwWXk2SVJnWHozakIyNXZtc3B1Ti9RdDFOSTBza016SjZvYVBXaEpn?=
 =?utf-8?Q?+Sf0tNiGKCCol?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRkSU1Fa0VHWjVjOU5OTjc0UEtBQWhCQThxUlhHV3JFZUJoYUQrNWdLcmpL?=
 =?utf-8?B?QkpNVHMxNE8rN3pwTEFpRjVmRHdvV29vZHByVloxRkl3WXlmZ200WCtEckx2?=
 =?utf-8?B?Z0lSK3lVS1Q2VnR2aGo0VzE5bTE5MHBkNU5zVUJCb1FnUDdhUGhkUHNkNXZa?=
 =?utf-8?B?VTFWRWdwNTJGNENrUGFiMEM0WnNhWlltY0ZvNU9yRlp1M0xMbWIrb0FmeDMy?=
 =?utf-8?B?MEdZbFRrTWhyNzBMZHlGRUtNdGtHc2FjR2lEempMWGFmdjcyR2w2RVRaeFhY?=
 =?utf-8?B?V0J1bE1UTHBQRmxLR0hnL09nYll6dFhBY0xNQ092ekpBSjdDT0VqYUFnUnpE?=
 =?utf-8?B?WVBaY2VwSm9FTGNVOXhpeDY5MDY3NTJlM0dGb0dUQ3F2K3VMYWVzYVNucGU5?=
 =?utf-8?B?WFhmZDZhS0xvd3lJMnlvTnJLYzRDaC9Fbk1GTnRpRlhpQS9IMC9UTXZvRjZi?=
 =?utf-8?B?S0ZUamJha21vZ3BEQ2JhRDRodm1mVmFvajdiSkdSY2dIdVI1STRXcUF6Y1p2?=
 =?utf-8?B?Znp4NG4ra0pMbFZOZ3hRclZUaENTY01uUlh5cjdjRlJnM1ZhYXpmYldlbVk1?=
 =?utf-8?B?OHErZ3lyTmhtTkh0akxBQTIzeW9waGYwMVdkenVhRUhCVHFhR0NCZFVtaVg5?=
 =?utf-8?B?eXRCb1EvcjM1eURMemZTWHhZTm9JTTZNYVpGdGxlT0NDL1FhVjlBWGZOc1lX?=
 =?utf-8?B?MlhDM2s4Y3BQaFZzY0svY1FaUFJ3QlZ0c1dYLzRES0cvcXdxRDhtb3o4bTZQ?=
 =?utf-8?B?NWRkMHBSNlkvWGZtLzU1aG9yTUlSSGt4UWNWbm83T0FvcTlxN3RhNElMOXg5?=
 =?utf-8?B?QU9uTE1UQnBRYlRnWnE2N09uU1pRV1BGbnA3NkJGVTdvNFE5VmRZbDNkOTZZ?=
 =?utf-8?B?dzNlcFNBTlRDMG5hYzJmQUNWWlAyUzJGOStnVTVMR1BDK2JIYysxYm9YWkZl?=
 =?utf-8?B?M0w0VnUwTnY3UGE5LzNTc21KM2VWOFRqODRqbVphVEFmQ2VBWXFBRXdvZGhi?=
 =?utf-8?B?a21yNzZ5VFZpYmtSSDZIdHN2c1QweW8wMGZJQmZxVkdVRDBUR2RFd0lNUnN0?=
 =?utf-8?B?V21GUXQzOFZLRWptdzJ6bWpadHVvZjcyVUdNOWczdEVGRzduSjJnbWV0Tno0?=
 =?utf-8?B?N1orbmJSaE1nOXF6UERDcjRwWE0zZXNuaytUKzVka1ZJRGl3RXg3S21VcmYw?=
 =?utf-8?B?L0JoKzFmOTJRd2pxQUdKOFBvOFNYakJhc3VNQmljT1lBeStkWkFnSzF5cmRH?=
 =?utf-8?B?cG1RN0dZMEF6Z2hUR0tzUDZab1BScWlEcU1KMDl6a1NKcGd5TVZEektkS0w2?=
 =?utf-8?B?T0ZUN3ZVaVByVllUQ0JZTTc5N2VHZng3YWh3aUJvcHlzK3FyeFlIdEtCY08w?=
 =?utf-8?B?WVFzc0JFazJDUGdnTm1vMXFxbFZDT1d3SmZZY2NxU2grT085eHlLTFFzTzY1?=
 =?utf-8?B?ekdtNTdVdUFKTGp4QUdLN0MvNXdCdFBCVkVpWGxveGtJQlJsUUdTTUh2TDRV?=
 =?utf-8?B?VndoUGY3MmdLcklQbHIyYjBtZWFYRlEzeHAwRi9GMUhWZ25aTW5mV3U1K1I5?=
 =?utf-8?B?R2p6bzN4Wk44TVd4b01xZjF6b1JDd0gvNnVnTUhuYXh6TGV1Tnl4NWlNbVZx?=
 =?utf-8?B?NjFGYmlUYWxzZkpEUzZ0WldGUFdROGxPWi9uTDdGZ3RsR0d1TXJaeTdBTmVH?=
 =?utf-8?B?RHBITlBKSFJXSU9VNTFtLzkvM21nWXV5TGwvTHFPUmJMZ3VDZUJiSDFUeEVT?=
 =?utf-8?B?OTBaV2tsMUJMMUpyb2h5d3NCSHhNZzY0NVBlTGRlamlMb3JiZ21IdE5tRVc0?=
 =?utf-8?B?c1RzbUQreitTbDdyVVFoNHFrTi9wNlBxRHNuM0lKV1Q3SE9HWHpFNUlQN1B6?=
 =?utf-8?B?UjhSRkpOMFBZdUFZQmN3dER4aHQrMHcrMXE1WjJEOVlvMWdLckNEdzFGOHBo?=
 =?utf-8?B?Uk5JWXhVeWpXZDQrUGtwYmVLMTRRbTY3ZkxUVVdsUlF3bExHbU52MHhvSkhY?=
 =?utf-8?B?bG1BUVlpQ3dNN1Z3Vlk1K0MyelF2T3hleEg0eUcza3ZyaFFDanBYMCtPQ3dP?=
 =?utf-8?B?RTNHVmNwZnZNMURSS1lCY3hlOWNHTUNpREZTTWtPVHhtNkczdWFlMVFhUWQ3?=
 =?utf-8?Q?apFb2Jdld9hII2dKvhqbiwWKo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227c342b-33c5-4495-61bb-08dd459e10a9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 04:32:14.4692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVCk6w2fTYL9RLibJc7b+olZ+I3ucC2nw7E4IeilqpEDhb9t6uCq2lbqhu1nD+CXYla2Rsm+8d20kKQngNdhsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

On 2/4/2025 20:48, Ying Li wrote:
> This initializes drm/amd/pm version 11.5.2
> 
> Signed-off-by: YING LI <yingli12@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 3 +++
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 51c2a7f4aba2..dd4cffd94a90 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -693,6 +693,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>   		renoir_set_ppt_funcs(smu);
>   		break;
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		vangogh_set_ppt_funcs(smu);
>   		break;
>   	case IP_VERSION(13, 0, 1):
> @@ -1565,6 +1566,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   	case IP_VERSION(11, 0, 7):
>   	case IP_VERSION(11, 0, 11):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 0, 12):
>   		if (adev->in_suspend && smu_is_dpm_running(smu)) {
>   			dev_info(adev->dev, "dpm has been enabled\n");
> @@ -1918,6 +1920,7 @@ static int smu_disable_dpms(struct smu_context *smu)
>   		case IP_VERSION(11, 0, 7):
>   		case IP_VERSION(11, 0, 11):
>   		case IP_VERSION(11, 5, 0):
> +		case IP_VERSION(11, 5, 2):
>   		case IP_VERSION(11, 0, 12):
>   		case IP_VERSION(11, 0, 13):
>   			return 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 189c6a32b6bd..48912c7295ab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -227,6 +227,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>   		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
>   		break;
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
>   		break;
>   	case IP_VERSION(11, 0, 12):
> @@ -472,7 +473,7 @@ int smu_v11_0_init_power(struct smu_context *smu)
>   	struct amdgpu_device *adev = smu->adev;
>   	struct smu_power_context *smu_power = &smu->smu_power;
>   	size_t size = amdgpu_ip_version(adev, MP1_HWIP, 0) ==
> -				      IP_VERSION(11, 5, 0) ?
> +				      (IP_VERSION(11, 5, 0) || IP_VERSION(11, 5, 2)) ?
>   			      sizeof(struct smu_11_5_power_context) :
>   			      sizeof(struct smu_11_0_power_context);
>   
> @@ -731,6 +732,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
>   	 */
>   	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 11) ||
>   	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
> +	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2) ||
>   	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 12) ||
>   	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 13))
>   		return 0;
> @@ -1110,6 +1112,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
>   	case IP_VERSION(11, 0, 12):
>   	case IP_VERSION(11, 0, 13):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>   			return 0;
>   		if (enable)

