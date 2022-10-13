Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0EAC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 21:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EF710E97C;
	Thu, 13 Oct 2022 21:37:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C1C10E3BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 21:36:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2u+LbBAgP9490NInRdd3DyzEdW45GXCBBIf4Xe2HeOUPSyd7PquhdYJ7wUTFiT8RwN3RPMF01dnCmKo4ViqAj7vgZmBInrDvX6HufFaIzIYwy0lFxOYnAAtNsXGNg4133t5IrATmewIiS6TF1ik4hG+IbbU9z5CVC+k3imO/AdWVzY6vu3/WcCkjlB4KZCvhBN6upyPbhw6H1x5h2XDbpoHg67VQ3qm8teuzaxUVG1pbxcTiB2x1F/hcJPKQn5o7le8SC0LwxLnRre0n05CPeKUee7ubh1JYty1HU0gPilmWF3bmOwZZpfakNQyNkGWCE3vXIdjIzXNeoN8X6qNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbPJSdzV+KW9b1IbpQamdPwdFKXRPeEVqGOTxrviA5k=;
 b=Zca9yyX8RMqwu12Kj4j9EM/gyStaKMmW7eIzN0hFMg3fuFgzQmxfirRTT9GdO7H9dnIrcR7NFYZSsHrVmLDDwl+IyiGGWRz2Y9OEALTxpt9YKm2615J6BrVekKz3o/abc1SGgoACWor28xsYDEGmMeB/VuV+nSLZJYCSl7pcywMEHo2mc1+/oCcvKXdH2jzaJk6RckLGmMeUxMWQJfT87bI1oeQv5yVzHHXx+Euyg6mS9S/gILwoaEYoWD4DiIcbCAGkWAHVXIzijsbgnxzlyOOB3/+xBKl2Fb4ABrU7flblguviJQZD62HDmdb8FX8dTFC1bAHZZxypW4SsMXCTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbPJSdzV+KW9b1IbpQamdPwdFKXRPeEVqGOTxrviA5k=;
 b=wTWx3GbBx2KDPytx4Cg1y3otrNwCZEQtcRiCAzMTt3OQuuMljlW2V3n6Wi3mFUqnZvFZ254n6TGcUf4uPPg4pvbzbkRPeMLhFtfnayYbnokqrfUYUfHI/coosTi8JcsLAINlNiK3xZvf1pLHdSEPgUrMV9A5A8CIN5bT/Cag7is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 21:36:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Thu, 13 Oct 2022
 21:36:54 +0000
Message-ID: <2255aa72-682a-134a-eccc-e7c939c678df@amd.com>
Date: Thu, 13 Oct 2022 16:36:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [2/2] drm/amd/pm: add SMU IP v13.0.4 IF version define to V7
Content-Language: en-US
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221013054619.3979464-2-tim.huang@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221013054619.3979464-2-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:610:57::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 646241ed-e26d-47f6-a055-08daad630be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEEvZ3Y3byu+VxuqrKOEPSdL8ExBF/MpgYjwzqyE4kVZCuFFsMNnJXRlxCuMEvQHrTlIVxajiW6xp6Ip06fAaBK95rVcRUgUusITJZn7492Rq+VZtbJq9dkfgZtkbz1+Kego6eujXlz6rBKK3j/lcGUgEAunV/6Tx+GY1wnMHWxmIwtEg1EZwD3OsKkd45MJl9ikpJUQP07d55yiLcaL6a4BOs/csqREX8NCcuSYVR4hYkNvr2b6wTOAdJb5voLvhCiRLKhqsUQixdjrsBhDdjaNFLqpbIk4kPRmB2i/Jn/34l0teWcK8VQdDfquqtXYVWraMwKoTGkvi2vmzTrt90eaRXKGIaV5jnKoSKMxxqyRvGYFZazJwPUS/UJRrAd81VCcViT0kOo59BG4BNpP8LyJnty96qxcJcWdcguXK/jkDkNyzbxB7oKNjlz35o+htqarjJOijTf4yqhrEbnQ6CTPCMeyzeS0x9kQk3HJEYIlT2frMuvd6E30/lKjPrcp+fGvY97xaeu1cHdiX7UxOlKXmUadQ1A12oGHpchqmIxznHdC5Ewb31xQ9WLW4SBHSSnrMmldAF4GQBvDT79Jdn3SCJvlIYgVpkSSYtyuwMMZaHcRnk8wt2//iezlq9epCxnn6QYJjQPX5IGZDA6cWjnt9ao7fnl5rQHnBnnys9urTuncFoIgm6QfJGHMT69d7cJx/lbV/zAQFGUwX2+DL74rzBD4Qlj/NEU9wKPErKo+Xv+QkyDzDhsYEGusq8xyRzb1rVXmMlu3JXrl06cSw6dOfPRA1Phoj+JuKOU5Avs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(478600001)(31686004)(6486002)(5660300002)(8936002)(8676002)(86362001)(4326008)(38100700002)(31696002)(41300700001)(2906002)(83380400001)(66946007)(53546011)(2616005)(66476007)(66556008)(6666004)(36756003)(6506007)(26005)(316002)(6512007)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NURqdlhMalFNQm0xTlQ4Qm1ScGtOWi9iQjBCSGxlcGdnVzgrbXl5WnE0Wm8w?=
 =?utf-8?B?SEdEemJNNStKbHkySUNISGxyMFZtc0RINzlsZ3NjaTEvNVlnMHdlWkxsdzNL?=
 =?utf-8?B?alZieGdtdmJYTHU4Q1hkdDRSWkJyNlIxSVZqL2hQOUtGaU5QUEV6WU1CZ1ha?=
 =?utf-8?B?Z2hLR3dLTXZURm1jTHhETHFieVIxeGhPRTd2UEZscysrd25JYmkzZEc3ZnJS?=
 =?utf-8?B?VUxPYmg0c1lrVWVWVFd1QmNNT3RrZE9YUnNGRTl4MzNGRHFGTWdjRTM5MzRy?=
 =?utf-8?B?Z0tWNnNpL0x1OVBydk1NczEwS2ovMndCR2FzbFE3a1lPWUlWNDJ3MFJSL2p4?=
 =?utf-8?B?Tk12b0FPVmgzV3VmcDY0NGljTHBrY3dWS0JEUUtRamNLYmVuV3FXZWtqR2VI?=
 =?utf-8?B?NzNhQXg3QWRKUDNqRWZ1TGp3ZmxPNlpuOUpUcGlKVWdlZUJ0VnVOeWJNUDlZ?=
 =?utf-8?B?d1l1UGRxTW5OM1habFBlSnA3bWNMcjNPQ0MrS1YzTG5jS3c5K0F6Y0pBZVQz?=
 =?utf-8?B?ZTZLcm1NZU4wdDF0RURsQWNndUVGaEdhUUkvR3Q1aDNwRHNzVE91ek9RMWNY?=
 =?utf-8?B?dERDSkdUZE0xdjJqM0J4cGRSTUZPVDZsMU1FZDM4LzllQzc2V2lSUG5RM3Zh?=
 =?utf-8?B?eDBVVGpnamo1Mi9zSk80Q0xzMlRCLzFxaWxKUnhlNkdURUNTa2QvZmlUM00v?=
 =?utf-8?B?SUZKdm1XcjZENXB4b1d3dkdmMGJmZ1FqNTloM2lXVDlUU3FDZkdMN3BmKzVD?=
 =?utf-8?B?S1RiSEFyL0tMSk9QNnQvVTAva1MxUGY3ZHVXRHQ2UWdoZzNBbGprdFR5YmxK?=
 =?utf-8?B?b3MramY1TjhNRWt3VzN2bWhzSVpkc3BnRlNqeE5aVVdHVTVTbDhkOXFYMEhY?=
 =?utf-8?B?cHkzSlZLYWZwQzN6YnpCNG1YL3RJWHRjOE5qV1hqVCtyVnU0c0ZLRjhaT3Nx?=
 =?utf-8?B?Q2dvWUlDYWV5QkFRZGQxTWw5NitSbVdQN1ZVTEtwVmxjbS8vTHNqeWhITytI?=
 =?utf-8?B?eHZBbmVkMXk3dzFzalhRdk1mT294TUN2aU1tclVxTk40RVJpNm9SbTF3MGRD?=
 =?utf-8?B?Y1llZStwUVJIbU1tU09MRW1ESVZuMEdRSEIxNHNFclhEV0U2SEZNRmtxSzF1?=
 =?utf-8?B?dERIYjdGL0JHVHdvSHVZK0xyVmtjbXBFeXh5WE9kei84NExBOEpXcU9UT05C?=
 =?utf-8?B?ZWhjTjRDdWs4V2IwRi9rUlVCMlh2ZzdBY3ZZUWlzNE5VQ01BRVdvN3JHNHl4?=
 =?utf-8?B?cENBWElrUEFPU24wVFdHcmZ6Ulh5WDdwaXZJNVliVDZ3cnNlenNMQk9XbVJZ?=
 =?utf-8?B?SVN5bnVmZ1hWQUtMS2M4Q0ltc0ZSaDh3U3hCeEVIT1pOOEpUWGVHaktvT2RG?=
 =?utf-8?B?aGxwamZCSThyaVM3Z0V6d1phZytGb3lrKzI3eEkvZHpwQVVYcyt1eEl3dWQw?=
 =?utf-8?B?WllZSTlRR1FwRkthSHlnRkR2UVRwRktGQ0JEYmREaDZtd0FSWU4zb21QcGdz?=
 =?utf-8?B?djdVNGhYTDJTejZYTUVCN3VKTEt5c2ZSb004MVk1QUFTbVBmN3kyN3RTanhv?=
 =?utf-8?B?NmRTVEs3S2RYUzd2VXdpTXNMZC9SV3FKMzlZS1M1S2ZreDVJQ05PY05pNUh3?=
 =?utf-8?B?Zm5XbjJLbGo1cFUwNnRReXVoZTc3TkYxSUdpYmg2enJRNTdQNjAzUURkZnhx?=
 =?utf-8?B?QWlmWXZIZTQrYmdkci8zVGd5ZkZKa2hpWERjQWVMc0xkek8xQ2M2K0N4ZWlz?=
 =?utf-8?B?Ni9mV0NwL05LdWFNa2ZxeVJRcDF3QXE5SWp2YUdPRG9Sc1Uwc3Bwb1N6WGpN?=
 =?utf-8?B?bzMwTHpHNDJJdDAzakQvWTQ4SjZCdXJxTjhOUWJwWkZuNlNQbEZWbXdnTEoy?=
 =?utf-8?B?NFlCNENjdDJpNzlWSGN0OUlmQldsMUR5VGZJQ0ZWczliaHg5TDZqQ0ZVeExu?=
 =?utf-8?B?bjJ6UG1aSXB6Mlp5MU11U2FDZE1zVjEwaCtsVmp3NFJzd2VOSWVESlhKMyt5?=
 =?utf-8?B?THJKMWJJKzM1ODAvV2FnQVJSb3BtaDIyTktmVHJBSUV2TndIa0dwWHAvVldR?=
 =?utf-8?B?bWU0Y3B4VlpYNVR3WTAxR1ZFLzNLWUxOWGRTdjQwZTdVdW1ZMEs0NlhNQVBY?=
 =?utf-8?Q?ZyPFOsFZZUeTC01qLP9KUM3Lt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646241ed-e26d-47f6-a055-08daad630be9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 21:36:54.0668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AaOvCsknUXrTtddlmbiF8P49T1g6hybFXxpF/x1AyEoyamrshbviV08qrkcNcuD9eJ88oKOPEnrJI0g4eE9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Richard Gong <richard.gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/13/2022 00:46, Tim Huang wrote:
> The pmfw has changed the driver interface version, so keep same with the
> fw.
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>

Cc: stable@vger.kernel.org #6.0
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 9d62ea2af132..8f72202aea8e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -28,7 +28,7 @@
>   #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
>   #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
>   #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
> -#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x05
> +#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
>   #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
>   #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x30
>   #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C

