Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4C0CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F99010E4A7;
	Mon, 15 Sep 2025 13:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1sK7x8F";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1866110E4A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2LNQ+b+S8eXFaPCbE/OCsFjW2ly8cv5YuVeechy7CUoNy5leeki/YIA2K4H0lE+oUZJUVpDmONJvSZatV/exBlZ0oz8163xaZK9iF70Em4mQ+0F8jxkwhhFsj02VRcNUCUIQnXgpYTl7gUdkmiAPmyOlDB/2BIzsKVVZ/Nppx71R/oR45AkFfOCdtgGEbd7Rpd4nsx52zBZFZ18Q7Fvl3k2ZW2XoCSU8zpf3tHf/PZbuWDS+MJRoWMnN4u+d+9DAqQPwhG9jgqa9GswxUhKWqSPIjNJBnCrqO3TZjTXl5NjrZD50Kcu4XJMWWzScPbFXIRpT72S3YhbxMkcTlZzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDFP2Z/St2NdlTqoeyQL5BVXW1VinMTRc1y6+8wdo1Q=;
 b=uq2rG5ZQwQpOsS1zKGhbf2pDfWXA+06OFcwFpTbUa89VkOjslAG/1P432Jc8CFgdoLO5xO90RX1AXoRizvPHfNWvGKJPoOmgYsrupCpxVlEZMPSiDslfwWPhDtJW5jsHCFMJiFPb9PtwXs/5U+w6dP/H+BK4n+AAwbuQzOF58wpwvsf+NQC/LZZLPEPmG7hZ6ycLs1IAT3PwuzM+JYtUDS6afxzbgXkT0ol4qAijgMb/kJDn7C89n0X0EEYRpk0iZOrG2mvxD23fPFfcB8eCs5L8hIqI3rIWEpQ3qvJRognXL0AaPJe26/87TBs3OfokyO+TA+iIjpKElwok/OHErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDFP2Z/St2NdlTqoeyQL5BVXW1VinMTRc1y6+8wdo1Q=;
 b=r1sK7x8FrSg4Pw4zRLJlJGrP/0P4Co+KOy/7VfoRog4U8AE33KlHrS4jPxhy4fCOlsJa1MXp5eEJZfO4RiXg1fjMtqsKvGYbl4Z/bdWh71PtXPKNQL88gRDAbc/aUUjKoagUq3LD85FE+WB4zzz4noaZNDOmdGyaJJiSO+w4+14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:13:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 13:13:20 +0000
Message-ID: <f247fd27-5e20-402d-91f4-68fa27657b3b@amd.com>
Date: Mon, 15 Sep 2025 15:13:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add AMDGPU_IDS_FLAGS_GANG_SUBMIT
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: alexander.deucher@amd.com
Cc: timur.kristof@gmail.com, amd-gfx@lists.freedesktop.org
References: <20250905124742.11305-1-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20250905124742.11305-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: e71b813a-8086-4ad6-b00a-08ddf459a429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elVrbDNGMWs3VGN0bnpZYUYzeXZtTjdjQm55MFhBYTNZVnpRTU1uWHROeEgy?=
 =?utf-8?B?eVB3RFdiT3VXc0ViVENJTm5RK0JFd1NJYWl2QnEwbUdtY0JWTmpSOVFBaVlk?=
 =?utf-8?B?ejNyRUo5U1VhdUlVQ0F1MTd4ajdkZG9wTTk2aUFXNTg2YWEyTlRJREV4VW12?=
 =?utf-8?B?YmRjQzVrK1lnVGgwTlR0U3l4NUp4VDFuQmQvWXo3amhCUHc4Q3FyaEh5UTJj?=
 =?utf-8?B?N0Zmb0hPK3lTS3czY2RjaUtGaGR0ZXd5eWNBNkROM3RMT2JDSjc0Y2puQzVv?=
 =?utf-8?B?MTdabm5MTlhLNFhiMThQam9wWENpZkpQU2o0YWdRK2ZYWDEvNXR5MlV5MlQz?=
 =?utf-8?B?OUorRG5ZaFBoY1JyNWlCU1MrbXFRZUpwZld0LzRvS0ZNcUh5M3pNdXNKSUNq?=
 =?utf-8?B?Umx5SWhMeG94UG5XUW1oaVhnd24rSUlYTlJlZjJmNjFNdzZQNGQzWHhIN1Ry?=
 =?utf-8?B?ZUVNcmkvRzlkalIvZXhMV0VIc1BiVm9aYmh5bGQ0U1FMTCtrQ3prMGNjS21Z?=
 =?utf-8?B?ZzFtU2t4dCtGd2xqamN1QlU1dDBhOTNFQVlUQm0vc1ZoS0pXNFN2UHBtZ1Jo?=
 =?utf-8?B?RER3di9panFkZFdhbERCQU1XVXAzVENraUpqbGZMSVFnb0VSYWhVdmhnbW1p?=
 =?utf-8?B?Y2NLcU1kNWN6cEV3cWJsRXhub210YlgwSkFOTEprZEV4bCs2MmVGdEgrUm5K?=
 =?utf-8?B?c3hvQ1k4dWliWlFLc2hFd1hSZHZ6ZG1uanZMUG9jZnl1c1BFQ2Fod3h2aXBr?=
 =?utf-8?B?dGVVSnRFRXBMUWN2cW1LRG03OEE5QjZBOVQ3dmc4QjJmRVdONWREYVZyZHFR?=
 =?utf-8?B?bm00dEtuTGI4UkhEYTF4OWlOZ01tYnpWVjY3MEIwSkV0dFdteDAvWFdyRmw2?=
 =?utf-8?B?Y0VWMEllNFFjcjR5ZWdnZjNsNUlianorUTY4VGNJZ2VPNldaRVBaN1lBbXNS?=
 =?utf-8?B?WG5IaEpqdVlpeUx1UzFsbEtETTF1TWRKMVFIbStoKzUwY2VBMEFHNCtQUTVY?=
 =?utf-8?B?ZE0rUnpKdnpyK3djSmFPWnhNU0dwcnJhMU1VOUNZUCs5d0ZBalorT3hMTjJi?=
 =?utf-8?B?Y2FYa3U1UmdFSXFTM2RnaUxMK3JON29uK2lCRHdVVzNVK0Q3enVHVlY3M2lx?=
 =?utf-8?B?VzRYcW1vZ1oxa2xXTTNCVHF0NjlpUEgvSFRnN3RTc3BkOXJ2ak5nTWxZd081?=
 =?utf-8?B?ZmxocVhER0pmeXZoTXlTSDRFUnZRR1BOZmMxZktiVUxraDUxTGxiSFJ6d3hY?=
 =?utf-8?B?SU1qRmhPV3F4ZUIwWlE2NzZrVTBaMUZlRmxsTG9ic01kdzB5aFNkQU9PQzVD?=
 =?utf-8?B?eDErakJIV0tKZHNPeHo0OERiNEh0YWtFOEtQOTZUZ3FjMDBCN2U2RjAzck5I?=
 =?utf-8?B?R2Y1TjZhMWN6UlQ4RFRsVFl6MnRmUkZhUHlGbFpud3lBV1Axd1huR05rWk9Z?=
 =?utf-8?B?MWdzWmZhWnNoSWU2aXJNajRFMk1TTEdrbC9UTmUwSldGQldXMEQrL2hhVVJi?=
 =?utf-8?B?ZUtITUNOZ3grWjdBcXpWT0RXcFdEN1o5K24yL3VsQWxmTFVqcGw1Ui9CK3pm?=
 =?utf-8?B?b1pLQ3EwcHFqRk4zRVVZbmpmVEM5aG83TEl6QkJ1RnJ5UEZldHhGaXN2REdL?=
 =?utf-8?B?b09WREFBQkl4ZUplRFhkTlYzYXpPUkhHSTVsYzV1R25LeGVuYTZlenBNSk9N?=
 =?utf-8?B?NC9NaTdRZWVSbnM5OFhNWHZzSnhmT0ZyN2FLRUtvc0U0YXltK1NIWHMzeWZ3?=
 =?utf-8?B?Y2R1ZnhCL3QyVEhxa3RSSWhQYXVPdUI0WERGMXdpMDcvY2tzZ0w2RWh3SHVZ?=
 =?utf-8?B?NmMrV2VhcmxoK2RZV0VWbjF4Q0JwblVmYTVHWlljU2tjaFZSV3NHMEx0ZXVW?=
 =?utf-8?B?bTNTS2RKTlBjSGNqVUlYdjFKUVBKOVFmbHRtaFdoSm5kek1EUkVxcGdhYjVX?=
 =?utf-8?Q?rsKqcIcDC84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3BaVHhveXBKclFVcFZ6MTV5eFF5U2IrTStTdVBZdnZyVUJjOUV4T3BveTZ6?=
 =?utf-8?B?ZnVXTGlTeEVWVGRJUVBLc005UG5SSFF4WThGNlZ2b1ZSVkM1Y2RRWUQ4YWpk?=
 =?utf-8?B?SkdJN2ZJUnZvSGNLTkR5U0d5bVFBVDFPQ0xGQnhiaGNDRmV2dWFsN2NTcFJw?=
 =?utf-8?B?b2JSTUQ3MEw5UlhjUDg0aGdkc29VekFEb1dBbWlyYWhTSkUxaTVkcGtzakNx?=
 =?utf-8?B?THBZWDRqSXRCV1Z3a3pIUVI0bXM5WFdhTW5VYUt6NTRDRm5nV0h2aVRhY1BM?=
 =?utf-8?B?TzQ0Wm1KUnJ1TW9nU0JXQTFWY1JLYTR3UlVLQ3hLUE1tQStmNmg5eUN5S25w?=
 =?utf-8?B?b0ZRSHU1NWdjeFJtZXduNTBzdFhLV0hPV0tIZUp0SkFwQWVMUDRHempiWTJS?=
 =?utf-8?B?TzkvdEJoSHY5R3U5QW1rb3hiWTRhZXhnWG82R09VYURQZXd1TU9tVngzb3Rk?=
 =?utf-8?B?b2crcXhTQzdPUzRCV0hjSTE5b0EzR3VobGFZQU5YYmcyN3JPbWRTaEloRUhx?=
 =?utf-8?B?TXp3bERsNjRIWmVjR3VyN211b25jMTVqd28yRTdBdWJiNHgxRnBpempxLzZM?=
 =?utf-8?B?UDR0VmduTDduUDA0alRpS0ZMdHAwVWVVdnhmRHNmbjVLR2JmeHF2czMxU1lw?=
 =?utf-8?B?SDFTNVA1aVFDSW9EeW1LRlo1aDhTUmNHbHFXdGpKYStlQUI0NkF1Vm9EMTU2?=
 =?utf-8?B?NmNxTksxcnpxR0JoK2lFOE11SEpEZnVUZktUb0Q4SHpKOEZYUXArZi9IWGd0?=
 =?utf-8?B?VVJKZEU3RUt4WVRNT2dYU2RCNFBheWJWTnlxdHlxTkNSOFdGOU5oZTlBemNU?=
 =?utf-8?B?WjRpVVc0cVpxT3NJank0eVc3Y2o1SUVob1kveDE1YzZNRXluWUtOaWZtSVBn?=
 =?utf-8?B?M1FBYjR6cllucG1MTWdSbUk3bCt0WnVscDBLNHNxOXBPUHFRa1lFVnVXK3J6?=
 =?utf-8?B?bnlQdVZFdW9oQnRiV1B6aXEzUmttZE9vWmk4ZEZUZ0RPOGYwQmFOYUpWOFYx?=
 =?utf-8?B?amh5TTJ0MjZ2eElLcFAxS1FYaDFwZHRNdnl2VGJQTk9laFZVZ1V5N3ZyeElV?=
 =?utf-8?B?VnpPYXBBMlg5STdQOFpEK1F5d0pKekVsWGxuMW1VY1JPTWpkRmk4T0UxcytP?=
 =?utf-8?B?bytHZW9HVGY1M3o1aDQ1TVJONFkxNkVIQTZiWUpUOTAxSzdOaFBhOTlGeWRM?=
 =?utf-8?B?cWNBUlBKamxXU211RTZJc3JQQzhXYi9nSm93VUJnRUpDcEQ2MmJ4LzczMnJH?=
 =?utf-8?B?bWRHVnBZekszQ3lmT0VrbDQwL0JTbEViRWVRNzc1STlzdjBNSnNMRVNhU1BO?=
 =?utf-8?B?YTFmVVFHUW5RRFJndzB3S0V4bVlqUFBwbFRyL0hKU0Nya2lQV2dJa25Ib2Mv?=
 =?utf-8?B?bHNLWUFEaytzb0lGVjdTRkp0UnA1WkEzNFZQSFRBRW1aNk1KeGVRTXIzZlpS?=
 =?utf-8?B?cmhEbVdFN2FkUitIWFB5YlAvUlFxdjNKRFJ3TnR1MGVTTFlod2pXYklUYnU2?=
 =?utf-8?B?K3cweS9HTFBxNXoyekVrVmdTaTl0UUh0WVAxdUFUNi80ZnU1cVpiOG45aWRt?=
 =?utf-8?B?UHZoMTBMSG9sbkNsV3Fhb2t2U3RyTmd0YkRNM0tSNEwwOUozUXl4cFZ6dGZS?=
 =?utf-8?B?T2dlRENIc0pxUk4zNVRhR0tFbkNvVVVKMjFVV1lLYU9vQW5nWFRWRml0bkVX?=
 =?utf-8?B?Q09xbTVRK09EeUcvdjY2OXp2bjRScHQ4elVWRkpIRHZCb3RxU2hwVjZaN0g1?=
 =?utf-8?B?UG1hVWpXbkJKWjYrZTRwSUlWeHpHcDBmRW53NFVvb0Y0VUE4T1l6eWtNdGQy?=
 =?utf-8?B?bkl6eENySWY2WTlKNE9mWlpRaDJudWJGUjRvN2hKdEZYbGl2eFhKU3FqakMr?=
 =?utf-8?B?bU1LV3pXVFBmUHJnWGU1VWxrcENCYTA1amo3am5ZMGlmRHFFR0lhM3lhZU56?=
 =?utf-8?B?VWFUK0xLTjRYN0I3R0NKN1B2TkF1ciszRi9ERVltTWZwZXdlS0poVVhTSHBZ?=
 =?utf-8?B?UFBjYWx6b2QyRnQzQXhNQjQzcTF1dmF3Ynp1WEUyVXhuZjdHUUI3S29vb0xw?=
 =?utf-8?B?UkVNVHdmUUorL2gxS1J3Z2VkY245cDRoVjl2YllVeDRzcnZNekhZTVJrZDhD?=
 =?utf-8?Q?gqebiJ4WTlEh4iznT02bIe8So?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71b813a-8086-4ad6-b00a-08ddf459a429
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:13:20.3367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPYqJi/KQVAXwtdJyBmf1S4rloBZVQgdWFq4dI93yaVbEVJQwgAdUnZ4abFNSoXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
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

Ping?

Alex can we commit this until we have found a solution for SRIOV?

Regards,
Christian.

On 05.09.25 14:47, Christian König wrote:
> Add a UAPI flag indicating if gang submit is supported or not.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
>  include/uapi/drm/amdgpu_drm.h           | 9 +++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8a76960803c6..8676400834fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -939,6 +939,10 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
>  			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
>  
> +		/* Gang submit is not supported under SRIOV currently */
> +		if (!amdgpu_sriov_vf(adev))
> +			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_GANG_SUBMIT;
> +
>  		if (amdgpu_passthrough(adev))
>  			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_PT <<
>  						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9cebd072a042..7a228c4d1325 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1084,10 +1084,11 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>   *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>   *
>   */
> -#define AMDGPU_IDS_FLAGS_FUSION         0x1
> -#define AMDGPU_IDS_FLAGS_PREEMPTION     0x2
> -#define AMDGPU_IDS_FLAGS_TMZ            0x4
> -#define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD 0x8
> +#define AMDGPU_IDS_FLAGS_FUSION			0x01
> +#define AMDGPU_IDS_FLAGS_PREEMPTION		0x02
> +#define AMDGPU_IDS_FLAGS_TMZ			0x04
> +#define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD	0x08
> +#define AMDGPU_IDS_FLAGS_GANG_SUBMIT		0x10
>  
>  /*
>   *  Query h/w info: Flag identifying VF/PF/PT mode

