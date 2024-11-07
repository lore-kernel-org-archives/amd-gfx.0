Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569C7D43362
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 14:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058AB10E84C;
	Thu,  7 Nov 2024 14:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EaePlba4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA3810E84C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 14:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB0bXMSE/zxTAtoF+bYh91uNcKSK1T0CVeEyNPL77ZuuFPZH18BziLraoF41Jqe37sRVCopgPy5GNlmtiRLkVVU7AKgeRSsPQQTEVXJE5ilpDOCOHhtwpYFGrL210LFCIXlJr+ot1EaMowwbm5+3657e2M4TYb25qC0rneok9V1Ppl3R8LX7kRVNMr3buRMxdBpgPtcXkgtawd+45V8Ixuj/qg14+eAxRttVTu7Lj9Qg+Cukna8x/ybxkvkgwhzTtVEtJ00JxY2L5oIkzGE+ckS2Yp7ZsG51urD3ISXh9BVqPqnhxtzH7rZGyxz27i2Nlizs5jqmNL1I7tmfW0R4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9JUMdeKOamwVsXZxbk+2+oZXZ2yG6dijQm5TyGmoaU=;
 b=Zk9bVpxzI1uABT50HXFa6+t8hKF/Q0fQV1falkjaADAKXdmlCXKx0YlF5JYPqId5Khj2yCGXbv+qMSy/cBSFwkttF5qKbUML9OPepghPVWXcJgDEuKNG6yf+6YGsDk4CGVf6vcTmXMwJwJ52uUhMFyuQfKczsh2uYqwEwUy8OsUN6JUDqdSh9EmLTZMNu+NOhM8ghugSUd4s834HzH6Fq0o3bVBeplzmoNUg5G13GiuVmnPunTT727sI/Xm4AAeeIDdzV+8KRXDDBiS32Dn4uvp7XyH/EAxcN4lP/mKvosS+3SMtExJRcCNJvq1E/XAhIAXdA+k9HUznHH2KklOlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9JUMdeKOamwVsXZxbk+2+oZXZ2yG6dijQm5TyGmoaU=;
 b=EaePlba4SU23w7xRNi4Og/Cg2Hd1wzboUd3j6wISR70Qhz/ZLItvFVtE4kEwYs/28HYoVngyASd++5MjJcs3LZUgiMuX6nZJk5xk6Y4xzfZpYEZFHmjQZIt9DyP+WJ7BizheCGwqnvHlgJcGaJoLJoMNy5DTCBOuOLSRG9Arnr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 14:15:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 14:15:41 +0000
Message-ID: <89e9520b-d651-437e-b06f-ec44626876cc@amd.com>
Date: Thu, 7 Nov 2024 08:15:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] drm/amd/display: Fix Panel Replay not update screen
 correctly
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
 <20241105202341.154036-5-hamza.mahfooz@amd.com>
 <698cdf3a-e9fa-4f90-9c06-ebd8c771fcfc@amd.com>
Content-Language: en-US
In-Reply-To: <698cdf3a-e9fa-4f90-9c06-ebd8c771fcfc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0165.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 73340510-2005-4188-dc11-08dcff36a93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDJJZ0hPZlpISXQ0WlFaZit0cTZUSzl6Tm10VkRqRTFLUGdWdGNGeEYyR3Nz?=
 =?utf-8?B?QVQwck5xZ3FxZzZkeWJEVkw4RmZWVzg3V2xyRjRERHZKek52Y2RIK0IrNXNW?=
 =?utf-8?B?bCs3akJUdWYxRUlHVURYWFdqbHp4QzBVS0JLeGVCTm0xZXRYMVViT0RVSTRw?=
 =?utf-8?B?N2s0UjkveEJENlFwWDhzQmJWbTNYdS9EbkQ2TzBLNmh2Wjlpd0dpbi85d0Rw?=
 =?utf-8?B?TzdxTWMyLzV2SWZObE9INEI5MlNpSk5xTmZEN0VtRStUMUI0dmtnYTFNeXE4?=
 =?utf-8?B?TVU0dHBqN0VkellGcGFWTGJzZng4ZHNxQzRhcHJPN2ZRN05HZzFxUjlyRjZ3?=
 =?utf-8?B?WHRtT1lCb2dpMHJHY2o4Z0pYbHJ6dW9jRlgvQStGaEpSN2tJcW4rT29wYmhj?=
 =?utf-8?B?eVo2aCt1bnpLdEtzN0VyQk1oS1RLVFhQQlNFaXhNZy95WmxacUR5WFhnUFd2?=
 =?utf-8?B?RVVDOXlBT2lyWmdWc0xrTi9GTFgvM05PSDdyTEg5aTRxbW5uN05QbGtBY3JR?=
 =?utf-8?B?ajB1QlQxZGw4cXBBTmlOS0VSWm9hNWJIbnY5NnJyY0xWVnFtMlM2bktoK1BK?=
 =?utf-8?B?Nm9XYzhXQmR2N1BtMTNXYlBETmxNVkFqeEY3VE1ocWx2a2NSbGFIRkhGcytn?=
 =?utf-8?B?cDhESkplTDM2WGt0bGdkNVpwRExYSkJ2VUEwZDdvc1lnbFdHeGxKMkFadU9L?=
 =?utf-8?B?VWYrZHlsUTI3Vk9iQ29PVTMwKzQzd0EvOTNPSlNRNlZFdlN5KzRET3ZMUU5O?=
 =?utf-8?B?ZVRqUWd3dEZicHdsdEtQdFhENENaOVFOWXQ2aE9wM3l4YnBlUEY2dVJLemFl?=
 =?utf-8?B?YTFuN2c0ZklQcm5nNVhuclZ5R2tubG15azB2UmNqVlN5ZHdONXRydUwwaGE0?=
 =?utf-8?B?WWtNdElQb09vdnFyZURvRkQ4UnhLYnRHZ1AvMVIvUGVQTVVDNTdJL0w3Y2c5?=
 =?utf-8?B?TmVFQ2xEWGpoK1IySHBvYTZGQ25GK0ViMHNmbEVKWHdaNVhLaGlaZ010SXlK?=
 =?utf-8?B?WVZPbWIwaFk5cGJZdndmTWY2cHZja2phd3E0eGM2Ylh3VXBhczg1eGh4OHYr?=
 =?utf-8?B?aE4za1hJY1ZpcTJaVUNmZzNjaXJ6OXVaREtYV2lMcS9mdFZJMW5OckRrenpw?=
 =?utf-8?B?amNGbVBOdm5qcTA1eUMwZGFoQ2U1MlRRZWlGRkNFTW5IZVc1U3VPUXRxMEZQ?=
 =?utf-8?B?TzFBcHZ6KzhVZTM2RCt6SFI5RlNvQ2xMUUoxcERuOTZCOUsvbS9KbS9oMWZw?=
 =?utf-8?B?VXNreFpiUno5YzhnbDU5UCtOUFoxRDA1dHp5cWhJSE1Kd1RFZCs0alhQV0Vi?=
 =?utf-8?B?Z1docnd6Y3JBcisrM1p5ei90REVjYXo3RE8vR3N1ZzRhcFMwSFdjMnRVTlo1?=
 =?utf-8?B?SnhCRm8zZkE4aU1IL2puWlNZVjVtMDNhUmNqQVhBTWIySVFwMCthTmhKREFu?=
 =?utf-8?B?YXQ1VzgzeE1tUmhnZFFENCs5ZDJSMDBianFUZU9zU3ppQXFqTTZpbmJLeUEv?=
 =?utf-8?B?dHVVbHc1TWFlbTZlR2svaTFOYjYyUTNFRHVlYkYzSG0zWHpSY0FsdVFqdVh2?=
 =?utf-8?B?TFpvZE1YeXd2bjRhUFBGQ3IvRlh0L0hWa013MmxZbUFLTUdHTHlBL0lVT1Zp?=
 =?utf-8?B?SlNoRitqL0REa3BscWpaR254WmVYTktJaDdobnBPNUNKNEUvQjJWa0xNQlRP?=
 =?utf-8?B?S2prWFh3VU1RNW1ZQWlCYkFHVG9KQjMvTG1tUnpIOWRTbmdHOFExRHhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVyT1orck96T0g3bkJuaXZaK3B1R3NzbzBZdERRK2VkMFoxYlpEYW9qRHZz?=
 =?utf-8?B?QnUraXU0ZnBWWU1RNFNuV0dZcjhycnlOUEIxVlViSklTTUZQN29CVVFBSFY0?=
 =?utf-8?B?K3dteHk0Qnd0M0lQdTVFMklRR1dZYm5rL2t3ZllPZGtOdy9KZkFETTZnT1NM?=
 =?utf-8?B?SzBoNnFTbWJ0LzlPQ09weHIwaTJaaTZ0RWhwWDFhTklOV1V5ME4vcW9HYXd1?=
 =?utf-8?B?OWdIR1I0VERjaW9FYjd0c2ZkSk9UeC9rUVk4YVo1SDl3cGhEVU1rdjYzbkdZ?=
 =?utf-8?B?RXFJQ2hwWTZnNEsxNGExYU1RZDVZRnFTb2NWLzF1R1BheU5GVGQ3VE5HRGtJ?=
 =?utf-8?B?TktNQ0xJY01Hb3VFQ1FKeW9EL05pc3FxcXAzWlZuZ2dxWVhOYys5L2pWb2JQ?=
 =?utf-8?B?Y21IQmtWQzByVHROQzNNMFFQNmE4Vm9xcUl2RVF0MUsrOWd5SGNaeGQ4LzN6?=
 =?utf-8?B?eHc2QUNGZ05VMFFrWHBrUzc3b1pJM1R2MHpaUlNiTFhGMUw1NEJpKyttc002?=
 =?utf-8?B?S01oRTZDd0MzcXpWYVgvY25KSVhPUDEwY1BmVmszWDZ3N1lDNW1qSGZkZmVv?=
 =?utf-8?B?WXBzRG1zUGoveklWWER1QUlmMFcvNzFpeU5BMk92cUZQMXY1dUdFNmw3Y2NO?=
 =?utf-8?B?S09EVTg0Vkl3VWJrM3FWaVFkdjdjS2VOUlZpLzM0b3VZa0grbnlEcVVzbFFL?=
 =?utf-8?B?RE1TRVRjYUl6RzVYV2NyUnVZSGlleEF4M0lOa2ovSys2WnNYSWFHVnp2ZFlx?=
 =?utf-8?B?cnd2UTczSWdtUm43T0l1Y2ptdklaYWpkWFFTRHFid0tTK0dYTXF3QlQ4SFRm?=
 =?utf-8?B?Z21ZdktoTlJVbzBPVmU3c2VFaFFkbHM3U2VqMTlGOVdtM2Jaemd2Ni8xN2NH?=
 =?utf-8?B?TWRzdHFmcS95Ny84Q1dKNXVJTFhsU1p6UURVbmtPSmZuUDBrek9jNVgvWHYz?=
 =?utf-8?B?Y2dOazdvVW5nZHBFd090QXljTzEyNm52U3FvZndtQk96Mi84ZHp4Qkc5S1Y1?=
 =?utf-8?B?SlZseWhyMS93a2FzbG8rbzUrcEg4MFBaRURMR0lsbmo2bHJsMUpGNXdiRWYw?=
 =?utf-8?B?SmlaNmtmWHEvSEZuRW1kUHRjb3V0OFhUTlR3MHNmdGxUYjc3UXhSeUtnRzhV?=
 =?utf-8?B?T2h4WlF2MWhpMVdqOXpxbTE2VHA2RzFkVkJQZGEvRlgrMCtZRk5JTE41ZjN4?=
 =?utf-8?B?YkFXTUI4Q2VJMERRYnU5VlNvV0V6NzBmOFRVTG1MSGtDWUd3WDUyT3ZPWnJK?=
 =?utf-8?B?VWlKNXE4c3dGRlYvWGxTUStLQ3lGYlc4MHVlTXhPdVQ5cFJLRkNuSC9uOEs5?=
 =?utf-8?B?UzVTNDRTYTNhVDBacHlVQUxIMGZGY2RSYXVBYTk3WFFMZjBmbGx5UXBIS3Yy?=
 =?utf-8?B?REhDYmdSYkdrc29Gb3pINU9CYWRsS3NkVy9JQWQ3Z2FVNVpFRnNyaXloQjI1?=
 =?utf-8?B?MVJnaEtYd0JoQkF1ZDV1OHl0c20xVlovU2tsRUgwdEFXRk9RM05LUFJYS2Yv?=
 =?utf-8?B?aFhMZXlMSFF4c2VkSlBwQ0VJSTNGWHlVTk5QSlBhOThVTlg0NW0vaUpxaHNG?=
 =?utf-8?B?M0Q5eE1iUmh4VkZmNXZ2TTJITFZZZURhcHlaT0hZRDNUTkVvSnA4RjEzQU1W?=
 =?utf-8?B?Z3AzUUQzRzBQMDhCLzFUZDNyNC96SVhZTFVQdkZibVQxMTdxMCthZjgxQkZS?=
 =?utf-8?B?RDYrY3ZsZ1FkcWNHemYrWnlDb2RRTkdYcEVFRXFIVGE1OWNlSzFGbW9DV2NC?=
 =?utf-8?B?SkR6N05zUy9LZHp0dmpxYXdpbW51ZFYzYytrRE5EaUJwSDdGbU9MRWRYV1FP?=
 =?utf-8?B?V3F1a0ZSQ2JhWnJ4Q3hlNU5veHV2Z0szSTIvcFZCaGtIeWZ4WnNQakxkK1By?=
 =?utf-8?B?S29wVEFKdzc4dGdlQkMvdnpjbENpODBVRC8xOFVpeU5rSVhYQUdJcnhJM1c3?=
 =?utf-8?B?c2p1Sm9Ca0VSNU5ob2xLcWprRnoxdDBHZC8yeU1UNDQwK0lRcWZGbnIxN281?=
 =?utf-8?B?SjYwemxjdkxxclRJRTRRUTFsKzBraEp3Wk5XQWlnNkxOWXpJK2IyTzZYMURM?=
 =?utf-8?B?eldLSGlsL1p4dFREN3hhcStmYU1ueGRyUmtJcUJGTU5aTVhXTXNtb29SOFJW?=
 =?utf-8?Q?E+T+ApLH+3NRpAYlJBDfpS327?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73340510-2005-4188-dc11-08dcff36a93b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:15:41.7421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ5KBLQFi+1fYCHoAb/dwUMovxVJCPTemv6ahyBiXhQx0a9Vb3d2ksNFjQ8f4cRdzayZhUM4shffBdhTqASONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254
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

On 11/6/2024 14:25, Mario Limonciello wrote:
> On 11/5/2024 14:22, Hamza Mahfooz wrote:
>> From: Tom Chung <chiahsuan.chung@amd.com>
>>
>> [Why]
>> In certain use case such as KDE login screen, there will be no atomic
>> commit while do the frame update.
>> If the Panel Replay enabled, it will cause the screen not updated and
>> looks like system hang.
>>
>> [How]
>> Delay few atomic commits before enabled the Panel Replay just like PSR.
>>
>> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> 
> As this is an issue reported in the drm/amd tracker and we have panel 
> replay in 6.11.y with active reports of this issue a few other tags that 
> this should close and associate with.
> 
> Cc: stable@vger.kernel.org # 6.11+
> Fixes: be64336307a6c ("drm/amd/display: Re-enable panel replay feature")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3686
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3682

And one of the reporterers for those bugs tested it helps their issue,
so here is a tag for them.

Tested-By: Corey Hickey <bugfood-c@fatooh.org>

> 
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 111 +++++++++---------
>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   5 +-
>>   2 files changed, 59 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/ 
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 570640c25b4b..fdc1d2d1afd9 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -8863,6 +8863,56 @@ static void amdgpu_dm_update_cursor(struct 
>> drm_plane *plane,
>>       }
>>   }
>> +static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc 
>> *acrtc_attach,
>> +                      const struct dm_crtc_state *acrtc_state,
>> +                      const u64 current_ts)
>> +{
>> +    struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
>> +    struct replay_settings *pr = &acrtc_state->stream->link- 
>> >replay_settings;
>> +    struct amdgpu_dm_connector *aconn =
>> +        (struct amdgpu_dm_connector *)acrtc_state->stream- 
>> >dm_stream_context;
>> +
>> +    if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
>> +        if (pr->config.replay_supported && !pr->replay_feature_enabled)
>> +            amdgpu_dm_link_setup_replay(acrtc_state->stream->link, 
>> aconn);
>> +        else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
>> +                 !psr->psr_feature_enabled)
>> +            if (!aconn->disallow_edp_enter_psr)
>> +                amdgpu_dm_link_setup_psr(acrtc_state->stream);
>> +    }
>> +
>> +    /* Decrement skip count when SR is enabled and we're doing fast 
>> updates. */
>> +    if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
>> +        (psr->psr_feature_enabled || pr->config.replay_supported)) {
>> +        if (aconn->sr_skip_count > 0)
>> +            aconn->sr_skip_count--;
>> +
>> +        /* Allow SR when skip count is 0. */
>> +        acrtc_attach->dm_irq_params.allow_sr_entry = !aconn- 
>> >sr_skip_count;
>> +
>> +        /*
>> +         * If sink supports PSR SU/Panel Replay, there is no need to 
>> rely on
>> +         * a vblank event disable request to enable PSR/RP. PSR SU/RP
>> +         * can be enabled immediately once OS demonstrates an
>> +         * adequate number of fast atomic commits to notify KMD
>> +         * of update events. See `vblank_control_worker()`.
>> +         */
>> +        if (acrtc_attach->dm_irq_params.allow_sr_entry &&
>> +#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>> +            !amdgpu_dm_crc_window_is_activated(acrtc_state- 
>> >base.crtc) &&
>> +#endif
>> +            (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 
>> 500000000) {
>> +            if (pr->replay_feature_enabled && !pr->replay_allow_active)
>> +                amdgpu_dm_replay_enable(acrtc_state->stream, true);
>> +            if (psr->psr_version >= DC_PSR_VERSION_SU_1 &&
>> +                !psr->psr_allow_active && !aconn- 
>> >disallow_edp_enter_psr)
>> +                amdgpu_dm_psr_enable(acrtc_state->stream);
>> +        }
>> +    } else {
>> +        acrtc_attach->dm_irq_params.allow_sr_entry = false;
>> +    }
>> +}
>> +
>>   static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>                       struct drm_device *dev,
>>                       struct amdgpu_display_manager *dm,
>> @@ -9191,9 +9241,12 @@ static void amdgpu_dm_commit_planes(struct 
>> drm_atomic_state *state,
>>               bundle->stream_update.abm_level = &acrtc_state->abm_level;
>>           mutex_lock(&dm->dc_lock);
>> -        if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
>> -                acrtc_state->stream->link- 
>> >psr_settings.psr_allow_active)
>> -            amdgpu_dm_psr_disable(acrtc_state->stream);
>> +        if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
>> +            if (acrtc_state->stream->link- 
>> >replay_settings.replay_allow_active)
>> +                amdgpu_dm_replay_disable(acrtc_state->stream);
>> +            if (acrtc_state->stream->link- 
>> >psr_settings.psr_allow_active)
>> +                amdgpu_dm_psr_disable(acrtc_state->stream);
>> +        }
>>           mutex_unlock(&dm->dc_lock);
>>           /*
>> @@ -9234,57 +9287,7 @@ static void amdgpu_dm_commit_planes(struct 
>> drm_atomic_state *state,
>>               dm_update_pflip_irq_state(drm_to_adev(dev),
>>                             acrtc_attach);
>> -        if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
>> -            if (acrtc_state->stream->link- 
>> >replay_settings.config.replay_supported &&
>> -                    !acrtc_state->stream->link- 
>> >replay_settings.replay_feature_enabled) {
>> -                struct amdgpu_dm_connector *aconn =
>> -                    (struct amdgpu_dm_connector *)acrtc_state- 
>> >stream->dm_stream_context;
>> -                amdgpu_dm_link_setup_replay(acrtc_state->stream- 
>> >link, aconn);
>> -            } else if (acrtc_state->stream->link- 
>> >psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
>> -                    !acrtc_state->stream->link- 
>> >psr_settings.psr_feature_enabled) {
>> -
>> -                struct amdgpu_dm_connector *aconn = (struct 
>> amdgpu_dm_connector *)
>> -                    acrtc_state->stream->dm_stream_context;
>> -
>> -                if (!aconn->disallow_edp_enter_psr)
>> -                    amdgpu_dm_link_setup_psr(acrtc_state->stream);
>> -            }
>> -        }
>> -
>> -        /* Decrement skip count when SR is enabled and we're doing 
>> fast updates. */
>> -        if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
>> -            acrtc_state->stream->link- 
>> >psr_settings.psr_feature_enabled) {
>> -            struct amdgpu_dm_connector *aconn =
>> -                (struct amdgpu_dm_connector *)acrtc_state->stream- 
>> >dm_stream_context;
>> -
>> -            if (aconn->sr_skip_count > 0)
>> -                aconn->sr_skip_count--;
>> -
>> -            /* Allow SR when skip count is 0. */
>> -            acrtc_attach->dm_irq_params.allow_sr_entry = !aconn- 
>> >sr_skip_count;
>> -
>> -            /*
>> -             * If sink supports PSR SU/Panel Replay, there is no need 
>> to rely on
>> -             * a vblank event disable request to enable PSR/RP. PSR 
>> SU/RP
>> -             * can be enabled immediately once OS demonstrates an
>> -             * adequate number of fast atomic commits to notify KMD
>> -             * of update events. See `vblank_control_worker()`.
>> -             */
>> -            if (acrtc_state->stream->link->psr_settings.psr_version 
>> >= DC_PSR_VERSION_SU_1 &&
>> -                acrtc_attach->dm_irq_params.allow_sr_entry &&
>> -#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>> -                !amdgpu_dm_crc_window_is_activated(acrtc_state- 
>> >base.crtc) &&
>> -#endif
>> -                !acrtc_state->stream->link- 
>> >psr_settings.psr_allow_active &&
>> -                !aconn->disallow_edp_enter_psr &&
>> -                (timestamp_ns -
>> -                acrtc_state->stream->link- 
>> >psr_settings.psr_dirty_rects_change_timestamp_ns) >
>> -                500000000)
>> -                amdgpu_dm_psr_enable(acrtc_state->stream);
>> -        } else {
>> -            acrtc_attach->dm_irq_params.allow_sr_entry = false;
>> -        }
>> -
>> +        amdgpu_dm_enable_self_refresh(acrtc_attach, acrtc_state, 
>> timestamp_ns);
>>           mutex_unlock(&dm->dc_lock);
>>       }
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/ 
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index 31441f0ec4b0..64a041c2af05 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -265,11 +265,10 @@ static void 
>> amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
>>        * where the SU region is the full hactive*vactive region. See
>>        * fill_dc_dirty_rects().
>>        */
>> -    if (vblank_work->stream && vblank_work->stream->link) {
>> +    if (vblank_work->stream && vblank_work->stream->link && 
>> vblank_work->acrtc) {
>>           amdgpu_dm_crtc_set_panel_sr_feature(
>>               vblank_work, vblank_work->enable,
>> -            vblank_work->acrtc->dm_irq_params.allow_sr_entry ||
>> -            vblank_work->stream->link- 
>> >replay_settings.replay_feature_enabled);
>> +            vblank_work->acrtc->dm_irq_params.allow_sr_entry);
>>       }
>>       if (dm->active_vblank_irq_count == 0)
> 

