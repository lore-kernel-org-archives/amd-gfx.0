Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7CDE77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 19:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7011510E345;
	Thu,  2 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AhdRUAAa";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8AB10E345
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 19:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSRbfa9aV6Y1r3VlGcEoNTJnFaTCXEWaeMcr4T0wpkdlOtqevEpvJ2xC2kPWyt3n1trU0BmmVWeTBvYJK3MzXUywFKhsP6UP/H7MHmK+2MY0I/+FSBV6u6VKIwShjE7sryARmfbxP9/e6iN771vNKfmwGamCESwY1p5iJtukTEpF/Q9Lfea2zMByKoGSZW4X0Un0OOz2ZpNC+YibvUrOTFQ4NQ2qBSAosN2+rPcAVaDNqIrtwJfh9ymtd8zopyGg3Z3MxFJrDuyxJ9EXDa9U0Qz9b/CqsK4/1KszUi3+5KDmgIeD7jbFdd9sIqPHEY2IgXodRqYFxgpXAylh/lW72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWiAeSq1RS7pHLEjquXpTAWzz/Y3OQ5ts/8uwph3l+M=;
 b=faJDNN3u2IZ3okpnRqHvvMwTTCO1FA9PhsoKiILDmRuUuVVPEUAgCjnAacmfWdzappnGI+rzDgI3G07batKLBO2aLNRjq+jINWOgDQllKqYtIdDH+2suPn2xn+XOtMKJyyC/oCduZWAfCYfGpI51lDwjvYYYKObDi/i/vkfiKFljaEWAIfI863LO/fG/AU/vpsWKx/5QtgnDld4TD5aN3qq15RZx0etxC4mZB+7qXaju4oIwiP/AIN6C+tHcXhIqgstMFUqoY9N75BSRKRlSXSMeJZSUpKsmjDaXK4R7geURW3FY5BFDbT6vX8Vm/u0Kuie0fFaDa5ZF0Wuf3+xVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWiAeSq1RS7pHLEjquXpTAWzz/Y3OQ5ts/8uwph3l+M=;
 b=AhdRUAAaQykyMe8cKHq+dZz9S/SZg1blu5ccgtvs04ky+0bs97arAvM/AkqCb53072wFjcvroiv09a/1sDF3U/b5JxS41JlXsMxcjXCDB6ytIAg9ii3gDAWWyZznl8EuGZ6v0EzYjb9h9GxUdYDJaUSxuYxYAAd0lcc/90HiSyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 19:03:12 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 19:03:12 +0000
Message-ID: <67cde66b-51a1-4d77-bbbb-4cde6675c8a3@amd.com>
Date: Thu, 2 Jan 2025 14:03:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Optimize cursor position updates"
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: rodrigo.siqueira@amd.com
References: <20250102181631.601338-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20250102181631.601338-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::39) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 280e93d5-0509-4241-d6bc-08dd2b601aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2lHTzlOL3pFVlZZeHlIWmZqWTB0ekhxQXFaQi9nT1pwYjVpMVg3a3RwS0Q1?=
 =?utf-8?B?ZkpaUVczeXpBYllNM1hBekxKUURib01SeUIyZnpsWUJPcVBJQlVkNmdlRyt3?=
 =?utf-8?B?Y3V4REVQSkgvWFRzNVB3bnZWQWVzQ3NkYXR6ejJWQTQ2SU1FOHZzOUpHU3FT?=
 =?utf-8?B?NHlINnYyN3ZUUDFQdTJnT2RaTFVqSU5VRzhUVjRkVkNHemtWTGdSQmRTNmZZ?=
 =?utf-8?B?VG1LOTZkRHVUUm1MNkh1dTJnN3NvbkhWbi9yWngxcUltWVZzWlJ6bWt1VFRz?=
 =?utf-8?B?UVlaSE9UdXBmNDExR21WYS9HdHQvZStoMURsbEtEMDVlUWxXRUh4cTZJK3Uy?=
 =?utf-8?B?a1NxbldBcGg4OVpQOEExL3VuWW5ZaS9wRm1EN29WeC9HZXhxSmlLS2lueWpO?=
 =?utf-8?B?UmNZdWt0NVhCOUNWOUtYa0R5NmtpSk03Z2NjK0Ruc3ppWlYxV04vUlRTcU5j?=
 =?utf-8?B?dUw1Skl2WDFBQ1p4S1hPR1lFbmptN3ZZK2NIWkZjVDc4WWVJMGNiTnhjbHhK?=
 =?utf-8?B?Ri9uTnhkQlFoVDBVUzIyM2daUjJGLzhFenM1TkNwaEpUcHhXUGE4WHBiMkIz?=
 =?utf-8?B?VmxaNDlxd3dpaE03RjZWMGgvcWM1dDgxZWJsMWVNQkRvbi8venBzOGhUMVVR?=
 =?utf-8?B?eHpLKzJQNGxVUFBFNlVxaC9QZG9Bb3VGNVRKSnhOWWcxRjRKdll5VjdIUFgv?=
 =?utf-8?B?ZnlXeUVwcUtMQzhvdzZybEswR1hSOWhVZ09zMFl5QnQ5WDhpbWdlNlV2V2wv?=
 =?utf-8?B?UkhrbndiSnlVcnBXS0x1M1hMYnUwVnBYMjJkdVJxNWN5dldNU0JSNTllNVp2?=
 =?utf-8?B?YnIrdGdHUnNKNnloOW4rL2FrS2lkR3lpS0hBRHZxTVZNeCtIZ280aVVXdlhC?=
 =?utf-8?B?NHJYTmt2TDlHTUFtYzhkNnNGVWg3bVlRNHhDYXcyWG02d1FRSlBjVGxWRFow?=
 =?utf-8?B?d2dZaEdYYzY4VDBaWVBPK3UvRnkwbXo3VkNnTFFSaW5sbVJseTV6YTBzZXVC?=
 =?utf-8?B?N05ISWI1MnltMkt2NzRTOTJvYTFvV1hTbnpiZEwvajFVOGJhcGwzdE80Nkkr?=
 =?utf-8?B?NDZHVlpBdVJjM1ZtaWpuYTA3WEM1SEgxMHBST0h2R1lEVGZ0cGJPdVNLT2p4?=
 =?utf-8?B?R3FNRU1HS1VkWitHeUg4YXM5UU9IQmQ4TzM0ekp1L2NBVWRRb2FIWlNoSEU3?=
 =?utf-8?B?a1JZcW1vK1RoZDViSHFFcjd5RXlzQkpSK2UxaUFKSkNmZW1uUS81dlVVOWt4?=
 =?utf-8?B?aEhkTzB6cDEvK0dOVmgxWjRsVWtKc205cDBIcGl1WWZaZmo0dDZFRWdCMCs5?=
 =?utf-8?B?dHBRbmloa3JKdGM4aGM3T1k0L2JyMVN3L0FuUTk4dllyazZTTEszRmsxbGxz?=
 =?utf-8?B?bmQ2Y1ZjNDVvT3FqbjJ3dEo5V1dMSzJoVkt5eDJyczJTNDhGaVp4eHhjR3ZH?=
 =?utf-8?B?YjE5NVRIL0RzT21lRjF3MnpaZi9pN3oydWEvaUxhcFZGWnNmcmd0Vi9PeWNS?=
 =?utf-8?B?YmxBUk42OXdJbWQxM2laNDBobnhiamVQdEFLaWYzNkhCV3ZOK1BLQjh5T3Rw?=
 =?utf-8?B?czk0SzhoNHVzRjNvb1FJR3NXSlZXVDFTQXhia1UrS1g5djZhYzN4cXNaYklP?=
 =?utf-8?B?blR0UzU2ZVc0a2puWEtCcnJMSzcwdmRmMlJPeEFCYjBtRjZrcStrS1dqQmZW?=
 =?utf-8?B?QW1EL0owdENBRVZrL1pwRWx6QkpFYzRFR2VjaVZ6T0FGOXRmbHlJN0lWWHUr?=
 =?utf-8?B?UEFUSUo1bU5EMUNDcTd2cGM0UUhxZ09yV1h6K0tRRGFQV000dmpnbTVpWmdi?=
 =?utf-8?B?RHFycGoyVFJEM2hKMEtwOW1Qb3VwY2lsNFpzVDBrOGk0T2lkU05wMTlrdEQv?=
 =?utf-8?Q?BxIWQRfPXyWfC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZQQTdwRnNrQjBlcDJBR2ZkMmNsbEpEbnNRcklLQ3czMzVoRG9tUUN6R2ZX?=
 =?utf-8?B?blh2OEtzLzNWTWtiNVZjbHV2ZjRhTmdTN1N0OEJxRWRaM3RSekZzVGFsRExv?=
 =?utf-8?B?WUxGM0JOOEtjMTZHbmJ2aTRHVHNVU245OVNyZ3JxcDk2N3lrc3VHTk5Tc0Jm?=
 =?utf-8?B?dmpBZXdyOExrdE1DSHI0VncwUnFBRDZMaXEwa2ZQb093Y0M0UDZ2N0ZtSGRN?=
 =?utf-8?B?dEplbkpFTlB0NUoydHlHbExBWjdWOUM4QkM5alkyOElZNDd5b2Q1TTlteERZ?=
 =?utf-8?B?MDNGdjI2QkhDNHYvWWhHN29QMEVSdjdOYVhCYkNtWWl3RWMvQ1QwZEhWMkJl?=
 =?utf-8?B?MUNENjJKTVNBRDZYQVViY2FmUEdTRSs4cDlrYTRLZUZMVEhUVEIvRjNNMG00?=
 =?utf-8?B?ZktDK1FTeXhIUko3dzk1TmtGS1pNKzdybXNoLy84SHRTcDdOVmM1QWl5ZXNn?=
 =?utf-8?B?L3VYbkZ3NEM0N0gydjRyUVI4U2x5cmdjbjF0alNoZ1l0SjdWVHZtTXBENFpx?=
 =?utf-8?B?eG8vdHJac2VzZTF6MXZabllTUUU0SGR3RUlTVkJKMTBXWnF0VHpYQThmbjRC?=
 =?utf-8?B?OTVyWXdLUnJRS1lwZVpxaGplUzg1ZG05ZFNvK0d2dlI3WnFJQjBSZnQ0RTN0?=
 =?utf-8?B?UWdxVmN1aGkwNE9Jd24yQmhEelVJczBmcll6eTlTbWE3VHJBQWdqeVlYRTUy?=
 =?utf-8?B?Y2JBSk00cjdJZGpQbFdmejdyZXNWOXgzaFhwQnBVaUl6VHZuL280OFpVRkdr?=
 =?utf-8?B?V01BOG1qQXRtZjZWNzdEeWVMaHRQMThQenZ2QVdKL1FTOEZqNjhiU1duM0pi?=
 =?utf-8?B?TUd6RTFIRlYxQVdkZDJQalZHbWg5MG9VR3ZUVStpTkl4eUhUOHRpOGlzazdL?=
 =?utf-8?B?V3RMRDNZb09RS0d1U0pwQVEwYVVzRlBLVVlOUFB5T0N2OXpPMXVGWGpRaWU0?=
 =?utf-8?B?dWVzZmFwbjJNdTRoc25JWncrSmZKaDZMdmcrTTZGTXVRNjBRQUlQd2RiTVlN?=
 =?utf-8?B?UzVuay95Zm95UTNWMEpzYnBmR3FVeHRZQ2VWTzl1N1FRVTZWUlp2YzFoR1Vy?=
 =?utf-8?B?aXBoZVlwVmkxQUJZMW5rTUZGSFBleEpCN0tpaW5vSk4rckRCdThFdzhXMTk1?=
 =?utf-8?B?NzY4VXZ3Uk92NDduNlJHZXlWazVqYk1UZEZxMFdBSkhYRC9NdXJpMXNSVHM3?=
 =?utf-8?B?bTVIci9WNDdXTXVtWE4zWVZUU2xHU3VWRXQrallTdjlhVkVpK2Q2QmR2RXIy?=
 =?utf-8?B?QldlR2NJTHlRMjBKYnZ6czhXK1dUd202SlFsQWxNajlQRThNV0U0QVM1aSs4?=
 =?utf-8?B?aTB6emdrZzBxOUwwR3ppVXRnOW91dDFGWXgrU2FqV0hzd0RPeDdMUkFEbVpZ?=
 =?utf-8?B?WVU1enZtSWVrT1JHU1o5YlBLa2lpV00ybElwQ1BZWXBSeVdDS01ZQnNzeEMz?=
 =?utf-8?B?d3NVbEtkM05sT0w0ZXZaeDFSdjFWN0F1YnBMUzJzVU9tVnI1NG5RR0l2ekVQ?=
 =?utf-8?B?YzhrRTBUaVNKRjFzejFZYWxlYmVyVzhGWW53RHd4SUVMc3FNalZJRHVlemFG?=
 =?utf-8?B?Wi9yTytwZW54cjBLM0lWM3BqV25IbU9hVVA2YllVRkRhY3lmT1J5M1dJKzJz?=
 =?utf-8?B?MUppLzhFTGlxdGtKSDdCWjY0NTd1M3l1MjNhekVpU05JNjdjQ0Y1TVBSSy85?=
 =?utf-8?B?dHMvYjMyK3pRODBNYjF1RUNHUmMycmFSTXVKWDU4a2J0TXIybmpEOFdUc3Ay?=
 =?utf-8?B?VDFORi9hcGJHcHVZS2luTlJVZXNkM1VGOHg3WElWdXJrVm9TR2s0eXZFRjM5?=
 =?utf-8?B?dzlhZzJpYWMvblJEM09ubVZWQ2JXVkp4QW9xSmR3SmIwNXZ1TTdQYlR0Nmp3?=
 =?utf-8?B?Vlh6blRtc2xFcnRQQ2x5Y0I0VmRSSmlZRVpXUWhad3oxczdQVUNoRmlBeSs0?=
 =?utf-8?B?TE9zbit5Y010SzBpY1B2cFFYMnQ2eG9vRmFpblpwU3djQzhCNHBtT05yVWlU?=
 =?utf-8?B?L1NCZ2UyMXk3anNER1RJajZYcXlBT0FvbzhUK2RMWnJudHF0RWl3WTZoc2tJ?=
 =?utf-8?B?aVNRWEhkRkl6aU00ZEtja1hkdzlrUE1JbTFjV1pTaElxN3lmUmZHQTZnaWg0?=
 =?utf-8?Q?+77DFOIg8sKAye9ehaXbu2Ydr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280e93d5-0509-4241-d6bc-08dd2b601aa1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 19:03:12.1588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5nyPAyapsqOuzee0A97ubE+vYSe0dF6pSiDyil/09uEAmJnFWf0LNHo3oBP6kmB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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



On 2025-01-02 13:16, Aurabindo Pillai wrote:
> This reverts commit 742d670b416b272e42f6674e30e393bbb8ffa6d1.
> 
> SW and HW state are not always matching in some cases causing cursor to
> be disabled.

With your SOB, this is

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |  7 +++----
>   .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |  6 ++----
>   drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |  8 +++-----
>   .../gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 10 ++++------
>   4 files changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
> index 8f6529a98f31f..e1da48b05d009 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
> @@ -480,11 +480,10 @@ void dpp1_set_cursor_position(
>   	if (src_y_offset + cursor_height <= 0)
>   		cur_en = 0;  /* not visible beyond top edge*/
>   
> -	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
> -		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
> +	REG_UPDATE(CURSOR0_CONTROL,
> +			CUR0_ENABLE, cur_en);
>   
> -		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
> -	}
> +	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
>   }
>   
>   void dpp1_cnv_set_optional_cursor_attributes(
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> index 1236e0f9a2560..3b6ca7974e188 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> @@ -154,11 +154,9 @@ void dpp401_set_cursor_position(
>   	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
>   	uint32_t cur_en = pos->enable ? 1 : 0;
>   
> -	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
> -		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
> +	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
>   
> -		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
> -	}
> +	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
>   }
>   
>   void dpp401_set_optional_cursor_attributes(
> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
> index d537d0c53cf03..c74f6a3313a27 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
> @@ -1058,13 +1058,11 @@ void hubp2_cursor_set_position(
>   	if (src_y_offset + cursor_height <= 0)
>   		cur_en = 0;  /* not visible beyond top edge*/
>   
> -	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
> -		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
> -			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
> +	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
> +		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
>   
> -		REG_UPDATE(CURSOR_CONTROL,
> +	REG_UPDATE(CURSOR_CONTROL,
>   			CURSOR_ENABLE, cur_en);
> -	}
>   
>   	REG_SET_2(CURSOR_POSITION, 0,
>   			CURSOR_X_POSITION, pos->x,
> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
> index 3595c74a3a2fb..d38e3f3a1107c 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
> @@ -730,13 +730,11 @@ void hubp401_cursor_set_position(
>   			dc_fixpt_from_int(dst_x_offset),
>   			param->h_scale_ratio));
>   
> -	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
> -		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
> -			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
> +	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
> +		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
>   
> -		REG_UPDATE(CURSOR_CONTROL,
> -			CURSOR_ENABLE, cur_en);
> -	}
> +	REG_UPDATE(CURSOR_CONTROL,
> +		CURSOR_ENABLE, cur_en);
>   
>   	REG_SET_2(CURSOR_POSITION, 0,
>   		CURSOR_X_POSITION, x_pos,

