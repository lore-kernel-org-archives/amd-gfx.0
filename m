Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC83DC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 22:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF9510E090;
	Wed, 13 Aug 2025 22:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="veiqRArB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5712910E090
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 22:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f62Ol++xx16tphHBotEYjbcUZC2uHxGZPcvBVA6fCGzyW8QFzPQ5HJ6d9M16N+7KD/sv9w20e+oy4g6JzwXEuBk06SY2AHjpVhGJ4hs7PaMRF2w+G0qmQ6WzMzUjQNZZYqZlvtn0L+lwwu8vasLnTo/HXcI6elZo/31icIQSU1I7hoN3icqAbKtkrwmSbrNe2Y0wf0yXiUKi2kvIyxekm9fShCOE/CzAU2u824zoX1y5TrK/ck1eCYEwmJMzIHD11G35P4drX7Y4YAuxEXfDe/oIfc2oabmyWvx1HASFJZjwa/35e9fGjy6AxtOH1XY0ba9TcdvYsx3cYZN7YXy40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mll2t0fU3VbjttH9Meut9YO36Iqs7wiV4A3xtE/24KE=;
 b=l9jXhupJP8eBDcIM3R/mBWQSvJo32YLHDBZCHrp+HfCiusVV18DjgYuAbWG4WtqY/Qkc0mP79Salbp5dkjDFDaFXhA7peD/mp3j868S5cB205nC+DtIKYPncESx0Lq2Bp7r74rGfousAOJqxFiQq8HU/V/DG0kEbWp7TovwOlR2tBLZSgA6f0Uaj6CjEMdo0FWghM5TvUIVNResXuLGhspCQSNLZQQPPCbDtEzI2AO4QHkde1bt6F6GRbung3eOO+mQYoRP1ExMuWGD233I10lUggxdTh3kVSB4jCP6xUOqLoXV3GtJ+A/mHWJLKfqO3iF6xM4qluQZGqr0WzPzwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mll2t0fU3VbjttH9Meut9YO36Iqs7wiV4A3xtE/24KE=;
 b=veiqRArBZc104kOj8zZgWq6eWKE/zAv+WNCEQquAqs42MX9izNCqmWigIGj1yh+UktqUxcJ3yolAXjhkWDSJlxuMiRzbL6qRUz3kaNbnKYfo9fvSk/AdgRmdYTiH/wzgAaOWO/hBu6cRE1GYCc+05oEPBBqifCqi1MWsvcte8GU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 22:28:19 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 22:28:17 +0000
Content-Type: multipart/alternative;
 boundary="------------t6KF7MfIHbDVeY3Ax50KI2m6"
Message-ID: <8fac76ef-d489-42e7-a570-b3a83c88d455@amd.com>
Date: Wed, 13 Aug 2025 18:28:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>
References: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
X-ClientProxiedBy: YT1P288CA0025.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::38)
 To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 929b0b5f-0fdc-4b96-0b20-08dddab8b35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlZQNFlHazFWUVMrWitkK1pqQ05vbExpL0hGVDBWaGh2RjRFUVhhWmFOS01z?=
 =?utf-8?B?S2x2Y1F0V2FBR0U1T2l4a0dPNXZ1dHZROThCcDlsZWFWY3JWQmR1RzhLMGJs?=
 =?utf-8?B?bm5jeFNQK01tdUtZbFVCbXN5amZ4RXhIUE9vWlBpaVZFU0YwZ25DN1owY0h2?=
 =?utf-8?B?djQ0SHFNZ3p5QnJMTThLN01qa3VpQ2FJb1JmWHpaNGpUOUtNTVZvOEVwVjRo?=
 =?utf-8?B?LzEzOE9DRjlyTSt5Y05tVy9BVzI5ZXJ2c2RzWk1sUmJtS2o0czRaK1NIOUN5?=
 =?utf-8?B?VEQ2dUpxT0hnZmRvL1hmOTc1WlRkbDZQK1VaenU3QjR6T3hBR09sRkRveXVB?=
 =?utf-8?B?ZUFYMmlmVVZTTTlVYkVKREVmNjJRaENuWVM3eDJ5QktrU3AzcTVBODlaREVP?=
 =?utf-8?B?TnAyd0QySWpJdWhYWE92ZE1hRHI1RkhzZWtYbTF1cFFTa0E1RkFaa0NzSEFB?=
 =?utf-8?B?NmtVd2liTy9NSjEwTXBDZW5TZ3pUZDZnWWR2djh6OW9sVElGaWxOb2ZBeldQ?=
 =?utf-8?B?cGJRY09HZzlCTWlmc3NxWlV3cjkvdTc4ZDNCeEc2Q1ZHNXRRdVJOM242Tklx?=
 =?utf-8?B?cmdIZzhlQmtBSExTNDRsSCtMUUtjQlYwS3ArRjQ2M1BaYi8vQ1ltTWJOQnM4?=
 =?utf-8?B?MFFwb1dqOFIyajNzMUJ2N2lESEJRaktSZ0pIRzUwci9jaUtEQzdRRDRlWWow?=
 =?utf-8?B?WEhZTm5STm0rK0x5dStsakJOc1ZnVSt4aXRUaGxHcmlwd3BDeTJTM3hGRVVM?=
 =?utf-8?B?NnJ1dUIyaFBtaFBvL3IwbjZveGE2MGc3VXE2alkzY3pxY0NnL1h2QnJ3WFov?=
 =?utf-8?B?Sk5tcEtFSjI3Umg4WmQ4b002bEt0TWs1aDExT2lra05ydkJZODhweDBBQnBa?=
 =?utf-8?B?Y2x0WTFUeGo2UVBBY0JGcWJ1NWJZTkxEM0lsdCtCdS9GWG83MGJtTFpYWGMw?=
 =?utf-8?B?RVlrSDRBRTRRMjV0Qi9iTG54UGk5b0ZyU1ZaZXdlWDh2UUw1SFRBMjVJVGtV?=
 =?utf-8?B?Mm40QVY5NVR0a21RSzJ0ZVlNdG1uR0JKdTNKREhjcVpWaFEyWkJuZXUveEVC?=
 =?utf-8?B?WUxvNWFLUlV6WDhjQU93aTQ3aEJtQ3pWVktaNU84blN6ckpUVisxMDg4MHo2?=
 =?utf-8?B?UzZ2N21wSmVCL3NEUEVlSkxhbVU3VEVpUHZNUEMreDNsZzNxbDBuUGQwc2tt?=
 =?utf-8?B?Z1g3SkFmVjRlMWVEaVQyZ1FnSmU4T1pVRXpUUjhIcnozSHVEalhaeFR5REFx?=
 =?utf-8?B?VFBjU240TXo2SzZlUTA5R1o2VWFrSGhtOGs1M0F3WXAzbHpqT1NiTmFLdjZv?=
 =?utf-8?B?eVRpZVVkaVRaYjgvd3RKNGx5dy9tTzh4a3duTUZ4OVQzb20vcjh4RmFuMEpU?=
 =?utf-8?B?UFlQRFNjcmsxa0N5Mi9uelZBQTQvcDQxN3dzYnhYM3ozT2poQ1lKSnBnL2hi?=
 =?utf-8?B?ZVVqdmFYb1pReUozcG03aVZ2cTJXYVU3Vlo5UVpOT0YvV0tsREFQQ1RKcjgx?=
 =?utf-8?B?VUZuOWNyM3BiTTNNY1dSM3IwbjQ2dmYrOGxrbVROYUN1Q2JIUjNMK1IyeGc3?=
 =?utf-8?B?N0xYNDJiR2JTRngrZFRtYVdNOWx3UVBia2R6SmhCMlU5dEd3VUN6YWFrM1A4?=
 =?utf-8?B?bTlYeHV5U0ZxL01LRWNlYXM2VldrWFpDekNsUU1pNFNXeVlUdlBkc3FLblN6?=
 =?utf-8?B?NVVvRmg5OG5FZHNWa3FoNDhyRlpQQm9IYUhYSlFZSGdDOEJPbGEyQUlhUmhN?=
 =?utf-8?B?VXBLa05xOEwyMGUwUEx5emhIOUJ2QlRTU3Rma1hnK2k5OWhJOGZ3YTlEQzlN?=
 =?utf-8?B?Z2dVK0kzL1VIQVpVZXEvYXFhRVVlTXE5UGM0RjBqenFndlQ4QkVxYVFUek9R?=
 =?utf-8?B?eWNkUDUxaTFVZDRLSDJ2S1k4a0dRcnRkeVpUWEwvQ2ZPUWUxTDFaRjQ5dG9Y?=
 =?utf-8?Q?vhj6bQIX2Uk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjEydTdWbUZrY2pMUmVxTUVKNCtYblNjQ1VFb1c3dDRPdkdIbm8xME1nNXYw?=
 =?utf-8?B?Yno3K2gxS0M5d0RCemEwUDUwakY4d3RQbGpaRFpNODNyRVFJeklucmdRL1M3?=
 =?utf-8?B?RnhDcFJ0L2JEMG9mYkEvbnBicEVqYkIyNTFSMmhBejQ1QWdZYWkyVjc3NmQv?=
 =?utf-8?B?Vk11Sys4dHBqUzRJc0tXQ1RQZ0VkSUFYOWZ4SjdlaWo1RzgyNXdDdFVzVjNS?=
 =?utf-8?B?Q1JINUdvQS8yWU4vODVvcjZMcWZlZXN6UDJnSjA2RDNVeHd5VHc3SXZFSUph?=
 =?utf-8?B?TitXSC90QnRIYzlPeXVXSGtTcE1xd1VPTEEzTDk3cE8xNDVpMFdlY2U1dFA5?=
 =?utf-8?B?THZ5OWFlWUE3YjY4aExQSVZlYVRZOUI3N0xVQUtMN1lzcUNUTHBpKzJXdVFI?=
 =?utf-8?B?MkVhZzlGRHBXZzMvaGR3bTh3YU0zMUdQVGYwbllaZ3VJcTJpL2RXQ2w5TmhQ?=
 =?utf-8?B?Y1Y1V2FobnJxQjJJQTNXK2kzSkoxTnRkVmEzSWZGSW1ob1F6dkNEVjZ6R1p6?=
 =?utf-8?B?S2FOYUh4cG5HcGxNNEphMyswOUJ6eE43aHM3VFhtUFlsaWlMZndYQjRWbkFD?=
 =?utf-8?B?L3BSMGlKNzVrVDRPMER1cmdUT0dIbkE3dzk5bC9abWZGK0d4bkZUWlNBY0tW?=
 =?utf-8?B?YkpIaFZxT3F2UGFPbVJPSWl2YkZ5QTlpU1NXYyszbDlWUW9Nazh5cEFTSzYr?=
 =?utf-8?B?WWF5WHp0dklxb2J3NW9IbGMrOXBZbWtHL29YRTlvWDU4ZEZ4a3ppNWI1c1VF?=
 =?utf-8?B?TEhVaTM5RVNtajlMVVhaUXJSWWFoUGRhWWVWZ0ExTDNtL0ZjODBjZzdMMkwr?=
 =?utf-8?B?QjVJY1JCVjNJeHVUbjBpWHVQcTFNT0xqMFI3RmVoYXBCeEtaZnlQYlF6cjVQ?=
 =?utf-8?B?ZkR1anFpTWhOek4zU0NqUUpMNjVmTE9EZGdQczY4T2R6T3c0OUhib2dER1V4?=
 =?utf-8?B?OVU2aUtGT2tKK2dHd3hVVVpsdEthZk1BUVpHVTFsbVgzVjdEdFk4ZlFhL1Jn?=
 =?utf-8?B?QzEyaHpDc2RWWHJVZ1hLeWVmQzBUUUhFWUM4aDE4M3gzTlpDeFV1Zm8xTkpO?=
 =?utf-8?B?d3ZWdGJDYy95SVVMNnhlVlVsRjcxZi90R3BWNFE3UWtKS0RLbnM5QjZjNUMy?=
 =?utf-8?B?eEUwMjJla2ZBMXVFVHh6dHpxZnduVkpObW1nNmo2bnF0TlBqbE5rQ3V1NFRO?=
 =?utf-8?B?dmQ1dkNOeHZlZGVVRC92QlZpNTJnTE12eEo3ekJ0WVdjWTZzVG1na0U2ajlG?=
 =?utf-8?B?TW9lck5xdVBSckVhOXIwTVBaemxlR3ZGK2pPUFVtbXJSSXR4Q01KY09CSU9w?=
 =?utf-8?B?Q1luS3QrSGhVVGRxQWw4N0l1WWlPdWZxdTU1RFBsYm1tb1ZHVFlFUUFreDZW?=
 =?utf-8?B?SURvT1ZpUWo0M2VXTXJLT3oxNGx3REpLTmQzS2g3U3BnMkplRW9SdVNKbXF4?=
 =?utf-8?B?Ynlad2ZvaGY4L1crWHdxak52QlYzemNVZ0pXc3NGRjlxb3RLbHR4T1N4Z3dY?=
 =?utf-8?B?SFRLc21vb3c5ZFNLWnlxYmtTNVB5ZndZaFQ5c0lsU2JGNEY1N1U5dnZIRWdl?=
 =?utf-8?B?aWMySExPV1R5Qy9DaWVkSldQU2I5SERBa3ZuVDNpY0dtYVdMbUFmaUJkUzFn?=
 =?utf-8?B?R3VmWEo0YVk4L1ZFR2VLbTArdm9XRVVjdW5Rd1RYeURLT01CekNjNjFtTC9S?=
 =?utf-8?B?cXMvMy9CNHBUWlYwcGNmTkhCU05LS0Y2ckIzc1lJbFhvaTlYRGtxWW1yYzkw?=
 =?utf-8?B?bVdERFErZ1U1MnNiNnVzZFpMSk90RXpVUGlBTUFxTUk4YnpUaVhVMWYwMVpl?=
 =?utf-8?B?WnFpTjhhQmNzYUFlaDlncVBQZEtSMVJrQUVETC9ENEZsYVY3Z3RIR29wQ0tC?=
 =?utf-8?B?SGhBT3YrQWNua3lSNGt5a3QvT2JBUTV3L1BtNkJUMzg3aVZMZjBhY2M5dFp5?=
 =?utf-8?B?UVlGQUFlZUkxajgzMjE3ZEpHUytRU2NLT0ZCeGl1VUhKcFlSc2tUQTZLeFVZ?=
 =?utf-8?B?RFpUeDduQnZKbDJuV0ROTm1IblZHSnBUQmlpYTRJeEpCZzdQTm16eXpCOWJw?=
 =?utf-8?B?TkttTlI4bkdldXU0SjhpanhqcElXTkpGVWk5SHhISkFLbU9lY2t3UHpHYlhV?=
 =?utf-8?Q?KcNxeF8hyZ4Ya0mJ/xO18cNPS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929b0b5f-0fdc-4b96-0b20-08dddab8b35d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 22:28:17.6315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jSIDCGbUsDrqGZ5YCqhxI8YuR18m7+mAGsoBIM0Q6Z2dFAoywXy81YiSxhsOG0GWIxpCQyEDh92+fUOe7TaKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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

--------------t6KF7MfIHbDVeY3Ax50KI2m6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sathish,
       Please see inline.
David
On 8/12/2025 10:56 AM, Sathishkumar S wrote:
> There is a race condition which leads to dpm video power
> profile switch (disable and enable) during active video
> decode on multi-instance VCN hardware.
>
> This patch aims to fix/skip step 3 in the below sequence:
>
>   - inst_1       power_on
>   - inst_0(idle) power_off
>   - inst_0(idle) video_power_profile OFF (step 3)
>   - inst_1       video_power_profile ON during next begin_use
>
> Add flags to track ON/OFF vcn instances and check if all
> instances are off before disabling video power profile.
>
> Protect workload_profile_active also within pg_lock and ON it
> during first use and OFF it when last VCN instance is powered
> OFF. VCN workload_profile_mutex can be removed after similar
> clean up is done for vcn2_5.
>
> Signed-off-by: Sathishkumar S<sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
>   2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c18..da372dd7b761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>   		mutex_lock(&vcn_inst->vcn_pg_lock);
>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> -		mutex_unlock(&vcn_inst->vcn_pg_lock);
> -		mutex_lock(&adev->vcn.workload_profile_mutex);
keep these 2 lines
> -		if (adev->vcn.workload_profile_active) {
> +		adev->vcn.flags &= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->inst);
> +		if (adev->vcn.workload_profile_active &&
> +		    !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
>   			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   							    false);
>   			if (r)
>   				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
>   			adev->vcn.workload_profile_active = false;
>   		}
> -		mutex_unlock(&adev->vcn.workload_profile_mutex);
keep it
> +		mutex_unlock(&vcn_inst->vcn_pg_lock);
remove it
>   	} else {
>   		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>   	}
> @@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   	cancel_delayed_work_sync(&vcn_inst->idle_work);
>   
> -	/* We can safely return early here because we've cancelled the
> -	 * the delayed work so there is no one else to set it to false
> -	 * and we don't care if someone else sets it to true.
> -	 */
> -	if (adev->vcn.workload_profile_active)
> -		goto pg_lock;
> +	mutex_lock(&vcn_inst->vcn_pg_lock);
remove this mutex_lock
> -	mutex_lock(&adev->vcn.workload_profile_mutex);
keep it
>   	if (!adev->vcn.workload_profile_active) {
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   						    true);
> @@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>   		adev->vcn.workload_profile_active = true;
>   	}
> -	mutex_unlock(&adev->vcn.workload_profile_mutex);
keep it
> -pg_lock:
> -	mutex_lock(&vcn_inst->vcn_pg_lock);
> -	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
keep 2 lines above
> +	if (!(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst))) {
> +		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> +		adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);
> +	}
remove them and add the following before 
mutex_lock(&adev->vcn.workload_profile_mutex);

        adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);

there is no need to test this flag.
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc..a876a182ff88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -366,6 +366,10 @@ struct amdgpu_vcn {
>   	struct mutex            workload_profile_mutex;
>   	u32 reg_count;
>   	const struct amdgpu_hwip_reg_entry *reg_list;
> +#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
> +#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
> +#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
> +	u32 flags;
>   };
>   
>   struct amdgpu_fw_shared_rb_ptrs_struct {

--------------t6KF7MfIHbDVeY3Ax50KI2m6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi Sathish,<br>
      &nbsp; &nbsp; &nbsp; Please see inline.<br>
      David<br>
      On 8/12/2025 10:56 AM, Sathishkumar S wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">There is a race condition which leads to dpm video power
profile switch (disable and enable) during active video
decode on multi-instance VCN hardware.

This patch aims to fix/skip step 3 in the below sequence:

 - inst_1       power_on
 - inst_0(idle) power_off
 - inst_0(idle) video_power_profile OFF (step 3)
 - inst_1       video_power_profile ON during next begin_use

Add flags to track ON/OFF vcn instances and check if all
instances are off before disabling video power profile.

Protect workload_profile_active also within pg_lock and ON it
during first use and OFF it when last VCN instance is powered
OFF. VCN workload_profile_mutex can be removed after similar
clean up is done for vcn2_5.

Signed-off-by: Sathishkumar S <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..da372dd7b761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (!fences &amp;&amp; !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt)) {
 		mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
 		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);
-		mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);</pre>
    </blockquote>
    keep these 2 lines
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">-		if (adev-&gt;vcn.workload_profile_active) {
+		adev-&gt;vcn.flags &amp;= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst-&gt;inst);
+		if (adev-&gt;vcn.workload_profile_active &amp;&amp;
+		    !(adev-&gt;vcn.flags &amp; AMDGPU_VCN_FLAG_VINST_MASK(adev-&gt;vcn.num_vcn_inst))) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
 				dev_warn(adev-&gt;dev, &quot;(%d) failed to disable video power profile mode\n&quot;, r);
 			adev-&gt;vcn.workload_profile_active = false;
 		}
-		mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);</pre>
    </blockquote>
    keep it
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);</pre>
    </blockquote>
    remove it
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	} else {
 		schedule_delayed_work(&amp;vcn_inst-&gt;idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&amp;vcn_inst-&gt;idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev-&gt;vcn.workload_profile_active)
-		goto pg_lock;
+	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);</pre>
    </blockquote>
    remove this&nbsp;<span style="white-space: pre-wrap">mutex_lock</span><span style="white-space: pre-wrap"> 
</span>
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">-	mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);</pre>
    </blockquote>
    keep it
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre"> 	if (!adev-&gt;vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
@@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 			dev_warn(adev-&gt;dev, &quot;(%d) failed to switch to video power profile mode\n&quot;, r);
 		adev-&gt;vcn.workload_profile_active = true;
 	}
-	mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);</pre>
    </blockquote>
    keep it<span style="white-space: pre-wrap"> 
</span>
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">-pg_lock:
-	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
-	vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);</pre>
    </blockquote>
    keep 2 lines above
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">+	if (!(adev-&gt;vcn.flags &amp; AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst))) {
+		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+		adev-&gt;vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst);
+	}</pre>
    </blockquote>
    remove them and add the following before&nbsp;<span style="white-space: pre-wrap">mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);</span>
    <pre wrap="" class="moz-quote-pre">       adev-&gt;vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst);</pre>
    there is no need to test this flag.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre"> 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..a876a182ff88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -366,6 +366,10 @@ struct amdgpu_vcn {
 	struct mutex            workload_profile_mutex;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
+#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
+#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
+	u32 flags;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------t6KF7MfIHbDVeY3Ax50KI2m6--
