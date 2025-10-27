Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839A6CCF9E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 07:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BF310E2DA;
	Mon, 27 Oct 2025 07:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJSm7mAI";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD9910E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 07:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPzFU+2BKMqELa5HRvaV7TZAaa69RvO8ksrkvVPa824uICZE4/58vR1nP1zS/7PB5/s9Le1O8drdUtCYM/DnFJckrBlVuKKrBcyopzI3WJARIDUeKi34jaIfXd1af/47E6MQeZ5R4x08FD4yJI9eYzAUwM13reAt82jZ059DxPfBPtmpfnsxJkS4apWChJ5qe3CMWHRrXZsqsgaKly3w3wa8j3sQ1fc/EqARM1zW3n7rIlYP5exuhARroHnS4QGWsSVL9VCEDMHaMX0XhRFv+tPqDukqSWiJltUHRpvRylSWX2JW9j8YiYGDQ8V9CIZTRDpUNOOp14qa5yEcN1g4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MUULkjk4YNOy/GN1jPg6BjQ4veg8w1kUuhENGL5YtQ=;
 b=qovzjpkJNRE69NFTbZxTQY9Sr2vHtb4HvwO2YAVCly3Dxj4++EUW2jTww2C9dhS7fY/8kaVUdChfV9wyAxY3hr6ty/z5DHCcJOE1qf7uOdvc2CkxcSjISfqzWDUSJkdTvNiqv9vOLkQ8oZeCgz0QNn4JFmHOqulDlI/KwzqbNbf+2gyvZNHiK19WAx990uK+QCFFY6oAROrDUcUGFHBXSHBubjHbh0BZBwFL6D7YvlaHhVKgWIviU2S5Am+HNQopAq81HNrW3z36b7rqoYe+H8oMXQZl/JTDNZZRyiWuxqx1dlYxZZ2g7XAzhYX7plvol/XNrCuqmdxAQCd0XsgJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MUULkjk4YNOy/GN1jPg6BjQ4veg8w1kUuhENGL5YtQ=;
 b=JJSm7mAIBoquSD1bvdf8KTyGUWh9EbGqAqEDmShExcwN50r0J2FR4XxG2chb3LPH8Or/rLNZV5UrFrWeeKCI+WCJc6cMMXUgaw+CDJh8Xi74wDPBjFfJTq8AZvByIdINlhyJy3gU3eGmpdFDbWQDI09RKL7ksaI1aIG8mqb7qVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.17; Mon, 27 Oct 2025 07:44:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 07:44:01 +0000
Message-ID: <fc5a13a8-12aa-46c9-a660-12ea7e99b3b4@amd.com>
Date: Mon, 27 Oct 2025 13:13:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix incomplete null pointer issue for smu
 v13.0.6
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com, asad.kamal@amd.com
References: <20251027072757.1267995-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251027072757.1267995-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b59902-c7fb-4cd9-3cb9-08de152c982d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3VEdm1zalpHWFRoV0IxQkdTTnhmaHVJN20xK3h1QXJteXJTWnpGaEFYSXNO?=
 =?utf-8?B?WEJsMHdSWThHTzZWWVdRc2dwWU5Va2JndmN3RkJDOXhORENWd2lqdUZWaG0w?=
 =?utf-8?B?NFEzeUY1VytqeTVZZ1BwYzJia0JBNCtjRzdMUE1XSkwwYk45eHpTOTRzaXEy?=
 =?utf-8?B?N2MzR2x4azgrMTBaUllCdGxGaWZ3dTlkNUxmWU1LbS9hcmxxRHk3TTkxMW9p?=
 =?utf-8?B?WTMvZjZuV2NLUUkydU9naG1sNXlEK1ZNOG1tMnd6ajJQSmVsOEdGUkNQcnk0?=
 =?utf-8?B?T1hDeEpWMU54Qi8xTnFXVVJhdU5acGtLWU00aUs0L2VvL1pGM01wNUZvdUVR?=
 =?utf-8?B?OTVsTUtNSGlwTHdPaTdhVDlMaFdETVUwSjNvb3lHNjRENFYvVnQ4V2FoL1R4?=
 =?utf-8?B?aTcwMUhrMFZVUmNQV3FtRlFpeHlQRWozQ3BGU2JoSTAvU1V4UG9vdXYyY3dp?=
 =?utf-8?B?MU14dWk0Y2p6cXVESk43cVdBajNUYVhWeFFkSU9ZeGJPa2ErM1lUQk9lbHdm?=
 =?utf-8?B?b0dTcEhMQS9HVUx0czFWb1Nxc0gxVkxYb20zRnFDVU55dFllWUkwakNQZ2g2?=
 =?utf-8?B?MnBjbVh6MTFmQmNKWHNDb0JIL3Q5ZTBncWluSks3NUkzcDA1OE1jZDJsRTY2?=
 =?utf-8?B?cEUzaFltMVpsUVlVZG01NWZiUk9pdkcxNWt4YlpVaHZVdll0dGptK2FZMmQw?=
 =?utf-8?B?bURpRW1xTmNUWE1TUEgwK1ZhZ2J0YW9zSWtVc0J4VDlaVUJZUFkzVHpIZTN1?=
 =?utf-8?B?L05qdWE5VWZxOHl0SVQxS1lxekJVMlIrdVdiaHhjSVpiQlNkQkJzT1pLKzZ0?=
 =?utf-8?B?VnU1ZGxYbXkrZzBqSndSOW5qaVVRQzJsMHV0ZHhBWDV1endqUEhWQzlOUTZu?=
 =?utf-8?B?Z3lyZkdDdGxXZm1jOFNBeHN0dUJCMlM0QjFtejBYT2Z3UDRybTZlQ2NPb0Rp?=
 =?utf-8?B?ekFxQnB5S2NpNTBFdlhBM1BmeDJpUkhHcW9HS09NekExb3BXOFJqUGtJSjZR?=
 =?utf-8?B?K0NhdXlhNkdsMitrdzBaZDArWGJ2M0dxSTZwZllZVSt1cXcwQUlNbTRjR05Y?=
 =?utf-8?B?OFo5ZTR0MXVKVTZIamRCcTFQUTRCcmdKWUtpbFgyam8yRm91dU1BQWtNM0Fm?=
 =?utf-8?B?eFBHbWlCWC9vaUNySEtoTW9qUEd6NkZSNVM3WTlBdHM0d2hmUVREUWN6Qjg5?=
 =?utf-8?B?YUZ3OHZnZDAzOUFGanNtMzJIRmtBbDlQeHNyRXpzUktjV095U2Z5RzROQk9M?=
 =?utf-8?B?YTlTMHlUU0xWV2krajZkU2RUendKelRqcU90YWswa1ZJK0NLQ0UzQlR4N2Zq?=
 =?utf-8?B?ZjZZTGVHeUNzbTFXTTFjRkJDZ29ad3lVU213dW1FUTlGMCtIeGw2clpNSmFW?=
 =?utf-8?B?VjBkd3ZZZ0N0TDhhK0VuOWFNODhXMWYvMGVFSjl4c3hpV1RZaHUxdEZZVlBV?=
 =?utf-8?B?MnIxOUxhcXVrTnU2Rks4U1ZtdEt1WWY1Q0Jnd1NKalhodzNYeUJtN1lQSVgr?=
 =?utf-8?B?NkRlRFFicitxRzU5cy9rUjg2MUFpTFNYRUszT3ZGK2FKVHI2bnRKdkFhRG5D?=
 =?utf-8?B?SDBnM3pCL3Avbk5BcXR0QTVHMjN5SzJsZXZKb08xa3hpdmpySUQ5azlEZjQx?=
 =?utf-8?B?T0FLa21mbm45czNaMVlXdWtJT3RXQWlsQVJ0QjdCYkJqNWhMd2NsUWVFbW9w?=
 =?utf-8?B?cUhQN2UyTTJMTjhJTjVoR0JLWEtCaFI2eEJ1UFFRWWZLdVFVa2orUEFUNDFo?=
 =?utf-8?B?VWFZSkJvbUVoblJGNVk3WUZ1OGg1Mm1lYVZDSXk0dlZZSmNpSXlwdzV0Tzdw?=
 =?utf-8?B?YVF0VWZaWE1nM3c2QXg4V2lZako5RDAyMFRDRDFVK3Nxa0tHdjUwc2FhenY2?=
 =?utf-8?B?M1ZDM1hzaGRVUjZmUjBVRGR2bUtZcFhqREZRaGZIendXcFRIeUoyaGJEdytF?=
 =?utf-8?Q?ELX4gzjJk7F3Mp2G+FsOmpBBSbrJbRw5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm41NVZWM1djN2pIekNaRmx5U1h4VW8rMmlVR2JiYXF5eEdpM2x4d3dPWWR2?=
 =?utf-8?B?ZG94bEZ3ckttUzRXVlVpY1RGWm40cGRDMENFVGZYa0NVbnlwSlc1aS8zdHlk?=
 =?utf-8?B?cGd0a2dZTTVEZC9TQmJkS3N1Rzd3czZRK1pNUS82WktzSEpEbitMaUJJamJP?=
 =?utf-8?B?ZFNVOFB1RzFLWGc5L2VUVGFUdS9EZEp2R2ozRXExenVFbDhObVdXVmEzaWo4?=
 =?utf-8?B?SjhlbG1CcUpQRldOMHIvdUE4ME55emF3Ujh1M1R1ODMzNmw1QnlqRWtISTJr?=
 =?utf-8?B?UlRtSWVyZUc2ekwxOURMNTc3czRySEVjbEdQYTRlMTY3Rlk0ZlRQNTd0b045?=
 =?utf-8?B?UzF3UW5HM1VsMkxnc2NSRHlkd28vMXgwRU90RHJlZ1diczhRTDRod0Y4RGtF?=
 =?utf-8?B?TG5KZnMwS1JVU3VubHFsQ2Zrd0xkeEwxVEFMbFQ3b1NtclRoYzVWYTJ5bWJq?=
 =?utf-8?B?MzJ3NnJtRnZva3BsUGVtejgxZWYwS1NveFhhRk5WV0N3YUVOZFQyK1IweXVB?=
 =?utf-8?B?UlFkTkI1NjhkKzROZDZNTXgxZ1lPalkrSi9XT0NsTm42RW8xNDlLL3NmUlpV?=
 =?utf-8?B?NE5JcXQyNFYxQWZ0dU9vNmtpdFFmN0IyL0l2WUVwRjRLaEl1Sk9QenpSeUJV?=
 =?utf-8?B?eXFCNU81TTJGdEdyUTNKemNQSWU2b0tPVVRuRGM1VzNhdDlrTXUxUkU0OXhy?=
 =?utf-8?B?SFdEUXJ3bHJzVEdXSGc3SlhwWE9rSUROdWRxR1MrUVhhV051VTB2RStENk12?=
 =?utf-8?B?dnhYMG5Dbi9OcEhOL0dFMUN6SGV0TmZka1N5dEdzV0Y4ejd5V0Fia2dtR3lZ?=
 =?utf-8?B?UWhCZndIcFZpNEJWOTJybSsrZW9TS1hBMlpTTkRUODVacEh5MUQ3bUFiazU1?=
 =?utf-8?B?V2s5eUVWUllLUnpyZWxxaHVQdVhuU2ZnZithMnYyOFI5UG5ybVRSZnRZZ0ds?=
 =?utf-8?B?aTZGSGhFcEExa1hkUUNYZER1d0tZZlpoV2E0NUpqeW5sS1VoaHlPNkRHdjdC?=
 =?utf-8?B?ZllmOS9XR2lxRHFjTnpHamVUSDlyeENEbzZ6YldxOEE3MEFhbTZkOHUrQUg1?=
 =?utf-8?B?cUt6LzdpcG5ibkRXcHlIazg5K2twMEU5S3pCajRsSXlUSFEzanNkQnRoelFK?=
 =?utf-8?B?dkNQQkcycDNGcExmbDNra3QzeXVDOVd5a2cwb0J0VCtCTmJPaUtCd1lqSU1K?=
 =?utf-8?B?RUJkOWFwNVZmRnptbG1lUUxYZjMveGM5T0ZUTFBqcEFjYXFNOTBIOXNCRDNx?=
 =?utf-8?B?YkZWam5kNlhhNG5tOTZvdHZKUlhUNVhodk9hNDlERDlBQTVHaVM5NUl1dnoz?=
 =?utf-8?B?VEJjdWVJYUhFbzY1cmpNQTF5ZzU4QTRBdkhtTXVSY2xYcEtzUW9NbUlqZmc0?=
 =?utf-8?B?cnA5ekJxWXV0WGdobkppZ2dvVmc4clBEQmRIelVwcHlDVWxxWTRTWERnQWNx?=
 =?utf-8?B?aG8vSHF1SWVJcVVVeUJCVmZNa0ZTclhaLytQMjYzSTlWNk0rQVphS3luMmJO?=
 =?utf-8?B?cVRuQThYK3NtMU91NCtTMTlydGZBeGFPR0JIQWlWVUVzTEFLb1BQUzE2eXVB?=
 =?utf-8?B?eGtobDA1UlpVUUJaWjR3a2JTSDBiSURxK2gvVyt3eVlTdzhqOHc0dEgreko1?=
 =?utf-8?B?a2huV0ZFMEQxRWRzVzRQRmg4Zk9GTm9WaDBrWkhhS1ZPZHpUeE1UdmZwd3cw?=
 =?utf-8?B?d1JFTWJNRUU3SUhUbERsbmZDQ1JKQTZEVTV1VlUyTnphOWpGSFRvRUpVK2dj?=
 =?utf-8?B?Vm1QYXB0NTBDWFh2UmloMDEvNDVlOE9tcFhhMGJFYWdydzIzOW9oM2lrV1hC?=
 =?utf-8?B?YTY0VTA5eEpLbFp1MGp3SlpTcUZoS1VPdkxLSCthWHAzT0w3Q0gwUTBQamF1?=
 =?utf-8?B?MEVWZmtZN3BWRnlFckw2cVd2aUNSMEZ3QTEva2ZvMWJ0ZGt1cGcwOU0vSzgw?=
 =?utf-8?B?VW9zUjNlU1ZBWUF2M0N6VHI3WWs2OFpPUjFGc2Y1RTZTZFpLYU10RFBkb2w0?=
 =?utf-8?B?MElMVnF2cWR0RU96Y0JZd0VFZXExRCswV1VOWkl4dmZ5TWFNcytqWHVnQWpr?=
 =?utf-8?B?ZVlrOFYvRG9xd2I0cG5ERmJ1ZWZralVnaXNaWm5WSHJPTkx1TDNFUzRIL3A4?=
 =?utf-8?Q?x78PStFbRKXh9Za/7AYBzIKFe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b59902-c7fb-4cd9-3cb9-08de152c982d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 07:44:01.0805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByrUepY3GlmPj6ZEzY/w0X3slZSvuDqvrw9hhRQhPME7sxZdTgX2dKMJPZl4IbGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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



On 10/27/2025 12:57 PM, Yang Wang wrote:
> the smu v13.0.6 driver should handle return value of smu_v13_0_6_print_clks()
> to avoid null pointer issue.
> 
> Fixes: 0354cd650daa ("drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage`")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 41 ++++++++++++++-----
>   1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 39ae6701147c..22fe4d3508fd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1514,9 +1514,14 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "mclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "mclk");

Probably the fix needs to be in smu_v13_0_6_print_clks?


                         size += sysfs_emit_at(buf, size, "%d: %uMhz 
%s\n", i,
                                               clk1, (level == i) ? "*" 
: "");

'size += to size =' so that it returns only the total size emitted by 
the function.

That is the case for this condition now -

if (curr_clk < SMU_13_0_6_DSCLK_THRESHOLD)

Thanks,
Lijo

> +		if (ret < 0)
> +			return ret;
> +
> +		size += ret;
>   
> +		break;
>   	case SMU_SOCCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
>   								&now);
> @@ -1528,9 +1533,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "socclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "socclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	case SMU_FCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
>   								&now);
> @@ -1542,9 +1551,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "fclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "fclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	case SMU_VCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
>   								&now);
> @@ -1556,9 +1569,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "vclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "vclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	case SMU_DCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
>   							       &now);
> @@ -1570,9 +1587,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "dclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "dclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	default:
>   		break;
>   	}

