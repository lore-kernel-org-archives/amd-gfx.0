Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53889E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 19:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABF810EF35;
	Thu,  9 Jan 2025 19:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dlqPd5j6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F18210E1E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 19:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8gR6535GMV7B1RBUdExylybsgeKg1zTlwINmBJoW8bCZVJ3nU48C0N9umSUZ0OgLgm8Ne3oOYMYMt/KIfbbTcry66OXzPrdRoBS4aAhlftclkA4VV+n3NiWia0k+qQdJtUwGvdsQ7yrPRcI24uo+BT/W4ePJH3TB4Xkwz7BRkN/HUcdN8Quj/pxsd3MHam2IylhG5r3BBFG0OYQCZzc1iTNkmmhpVArjx578O7b2MkEVGEF0QEou6/AFi84l1msPEqTyMjsUgrFLpKE6OWOvTY3YArgHFJLns++XELSAa2/gatq1SHXL4M/9IfEGVz7g5z/QXANurY947Sm5q1E6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=layaaMtJtaaZbQATm0EEmId5Wdr9sh/IHVUxA2ti90g=;
 b=OPzzL6fltymPW3fv+Zq/008vo5JFpuCpoFDA1fUF2TYTShjk+wMZXHY5ttWsJRQM3cmTp04JY1oFllWhdlvonOLmhN1OCoLWSw1OcfWIAiaJ8xDNb8h0agK3lVVECFIoMlEELh4XbWGrpdyfRi65Un//AMNIsAxEBdZLVlk7bYIQ3mWWGJaiUt1ceUfCTHv1TwveilKCAI2ihO9xhGju4FulfTSS6sMJ482HDCOcwi5FamBLSTkKCAkuk5BW+h1JnRFIefaSab+E1cCSFP8rpn3FIUHVDE8ff4s+uHERdwp2H801YoQnaIUG12vDXvlyCp/MDzQAFBXhF92d3wqEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=layaaMtJtaaZbQATm0EEmId5Wdr9sh/IHVUxA2ti90g=;
 b=dlqPd5j68zpQTzgvXG/obVdOm7ODQVqYanCHWZdbIVfPr//wbqd+UZCDe1KQoCXwyrLU2m9RmoRaBbB2sKqzxiJfSLSMdzilJVfnmAm7dAP/I/wxJTvvRVdejNNC9F39f4lZhZ7fUgiA+RwQrR4XiRlyVQsc2rW8OUOcvraqobI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 19:55:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 19:55:25 +0000
Message-ID: <fb7b5202-4bbd-488b-9aea-c638fa11bd5e@amd.com>
Date: Thu, 9 Jan 2025 14:55:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, jonathan.kim@amd.com
References: <20250108225520.243160-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250108225520.243160-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c17a90f-1185-4bda-c5df-08dd30e78f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0RrZ3Vkc3VtMHRxVFYvSllDYXVkY3NRZUF1YWtHMGJEdFlJSk9HOTZCTmQx?=
 =?utf-8?B?cUdrYkRKV3gwcDVzLzhLa1hvUUdMRE9jRzVRMVkzVFhrL0h4L0tZQUxLZWkw?=
 =?utf-8?B?TVFnWTRwdEcydHgxQ2ZjalhPcHhtMi8yb2tBdVFrbXB3bHovQVV1RG1MM2px?=
 =?utf-8?B?dW1aV01Lc0JxZVFmWDJUVis4TGVVRFZyODh6UnVwUlNkQ0dwSnR2NFJYbDds?=
 =?utf-8?B?MjlSQ205TmVYQ0FTYkRiRmk3TW5SRVVKUFNtSFVOdVlBYXNQZlFzeXNvMEt3?=
 =?utf-8?B?R2tLSGp0N1VVZ3kyVFBGWGpPcjRIQmZWSXEvbHVtV3BaVWg1bzdDd0RvM0pI?=
 =?utf-8?B?YjJlbkRZNHlRaWN1UW1SVzZNa0JSa1k4Z3dwT0N5ZlI5NHJyeFhZNDRPUlZE?=
 =?utf-8?B?ekV6U3NQTHYzTHdBejUveUhvRTZXSW5lYi9EQlhrTGZBbE5KR2IzRVlFa3hY?=
 =?utf-8?B?bnV3ajNnUmo5S0dKRWp2NlFMY0czMW41V25ZWW5lOUl4NjFBVEV5WkxuL2Q0?=
 =?utf-8?B?cE1TM29SK1ZWdDNFRE1TbjZDRFp3UWc1Qy9QZDJkNFBPRHZicDRpZnl4QXpF?=
 =?utf-8?B?ZUJvTFJkeGxlZ1NBNkt1V0hZTUc0Qm51M2JkdlgyZ1lxUHBSNEFGNnFwcU5I?=
 =?utf-8?B?Szc0RGJlWlZVZVkveW04YmdBK08zVkUzdzRPQ0lHUUplUnU1cjdPdzV3VThY?=
 =?utf-8?B?dnZZME1yYVRkUEJuMU1OWkZ4bWxQSk5PWVU4VG13b2pyYzVLYTdETmdValds?=
 =?utf-8?B?THpuekNXR1FGWlVVa3lOTVAybjZvem5saEovV1E5eEVoMjlydSt5Mlo2azhu?=
 =?utf-8?B?QTJ3anZhWkIrYTdxbkR1QldqaFNRSXUrYktKUTlQamZiNldlRlRWdzV5dW93?=
 =?utf-8?B?d29UclVJNGhXdzhaTmdwVTZrWG1zL0JTWTk4bFRBb0JUcGkwOWdoeExWUk1P?=
 =?utf-8?B?UlF4NzJpWUFHMHRIU1lFUTdDcXp4ejRBZkE1MVorbHRjTndFTHhPTG5NRnRK?=
 =?utf-8?B?WlJyMytRTjhmcTdWcDlTeXhhWmF0NUcwY1NhUG9CMUJPL0lGaTd4M0J4U2F3?=
 =?utf-8?B?Wk05SDVNc2htVU9IWjNuVG5JNTBJTzd1ZlpqbFozVVpONjRXLzBDM2lpbE82?=
 =?utf-8?B?cFUwSnZvWFdJZFNhZllRZnUzRWVYcFc0bGlKcjc2TWRnOUQ0OXlvTlpYYmly?=
 =?utf-8?B?REdRR2RqVWdzR3kybUllVlpwcFZ5ZFM1cVdKQUkzTzgzVHB1TlhncVNiSlNY?=
 =?utf-8?B?RTRNdDg1ckJQL0pzdERmcFZHRDFLclBnWUtZNFAxTnpXZ20wd1JMZ1FwL3NQ?=
 =?utf-8?B?TmVTbVlLMGQ4T05PMk5RR2lMYUM4OVJUSS9tR2gzY3lhVzh2bnNSUlg3alpW?=
 =?utf-8?B?UVJaYmJBMGwzT0xlZ2NuT2JPT1NCWmJCVlRvTkRkeld6S2VrYURmZjRQQzUy?=
 =?utf-8?B?N1UzWnRjNFRoMHdPeFRlWTUrM0llSlRHWnZNTkhMc0psZVlwUHFjNEJIUzhx?=
 =?utf-8?B?U0VlcUZtVGtYZjhtUkhhSDlWWC92L1VOaURjQ1NSTitCd2kzNVoxeEd6OXps?=
 =?utf-8?B?clJhQUVpRU5KaG92MGlkaVphR2FlK3NEWEVvZjV0REdjUE85M3Y4WHBMbG9I?=
 =?utf-8?B?WEN4K3hOVzYzTllXYkFzMkdEU0JoU1laMXIxdVFjUENuUWwvZXNNY1h5QVVK?=
 =?utf-8?B?N0R4TEV4MWdiUkhPeVg1RHNFcXFSVGUrOHA4cm9IOXZLRzNrM3VnTHQvR2JD?=
 =?utf-8?B?N1dJdE82V1pMTWNiWWVadDMrYzFlbjlaT3pyaVhJclRWQ3Uzd3NRVHNZRGpw?=
 =?utf-8?B?MEZ6dlNrSjZlTmhPUHhoajBsMU1YRDRGZks2RzhCUVRmdFVQN0VuaktzaUVh?=
 =?utf-8?Q?IN00bBykugceX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnM5ZG9UbnArTEczRTYySjREM2VqYjZBcXVBQXBMeVp5UC9INkNUZWp5NENH?=
 =?utf-8?B?dkxrWjVrNE1XSXk0ckJEVkFpaUNHM0FCTWduNEpOTDMxVW5QbjNCZzdJZHly?=
 =?utf-8?B?eXpmT0pMNmZmN2d1akZsVU1JQVFhZkJXSEtMM1ZHVzRwYnU3Mmg1cWNQczEv?=
 =?utf-8?B?OWVlY0NtU05uZjZwR1Vha0FGdy9vY1RUcFdCaXBFdis4cjBRRy9saGc0T243?=
 =?utf-8?B?WWZrWTF2ZjVpZFFSanJJK3U0Z2FDb1lYdzloQWpiRGgrbG9aS1N4Y2NQbU53?=
 =?utf-8?B?RUU0UzN6am1tOEhBNnczbGhTNmJwMmJJTytVTWJodWJlSzVhT3hHZklmSXRW?=
 =?utf-8?B?UFo3NW9nTGt1S0xtTUtCOWtPMUo2L3UvclVlSVBIS2JSVjcxQ2RIRk1PWnJZ?=
 =?utf-8?B?aGVMdW9UT0orRzBiaUg2cFYvemlEKzhqOFZaQ0V1Y2ZvWGF1SnF0RlpQd3lZ?=
 =?utf-8?B?eXF5M0FRWTF4QTlDdFgySm9ZMzhFY2ZOUXZoRTBhbHZHbEN4OWR4dnJBTzhR?=
 =?utf-8?B?Um83ZUFNb0hGV2NNcnMzUVVCK3lacHZ4eTc4UEtieDI0UzFZRFAyN1pTUU9i?=
 =?utf-8?B?NE9LZGZoelNUSERiekZaWGwrRTlUOHNDUEdMd2V5aTg5bWdMa3prUENraTBz?=
 =?utf-8?B?cGI3aTJNRmZVaENoa29NdGZNWVphV2Ivd2pyOU1jNXljU29HYUZFVWI5cDRV?=
 =?utf-8?B?WGRhMElrZ3ZlSDBvNmhsdERDd1VROUt1RURIQ2RmQlQxUFNtMm11M1lScmRN?=
 =?utf-8?B?T0Y1UmxzRVZxYXhRUDBHaU43dXM2Ri9pQVdaNzZjNjBtYThvdlZydCtQd0dQ?=
 =?utf-8?B?cW1adCtoaU9jMjRaVldjVlVacGZYQ2U4d3BjSW9FZjBMaG80KysvVWhSUGFE?=
 =?utf-8?B?dUxQUUFzaTVBVXFOc0s5OTdSUW1oZ1g3ZHN4WjVTa3pHcTcrQWxsSldlckkz?=
 =?utf-8?B?SE1UMm9yZHNQRGxPWmozQU9BandIejJFUkhINVV0ZzFtUHYxR2Z1S0djanJx?=
 =?utf-8?B?bmpzTlBxZUlGWU9TN09LS1RCUDJrUEY3WVd2aFB0algxT3dWamkxNTFvc2NG?=
 =?utf-8?B?MWV0Szg5clFsdTNMRENWTXBuazN3c2dSMmZaSlJneDk4dFkrc1c4UlhoSWZ1?=
 =?utf-8?B?aXBGbnhqcDVIdTVvTTNZM2VOSjRwOXBialhxNEVRUkE0V0JPT2NweTE2U3li?=
 =?utf-8?B?b1pTV1dXLzNraVRRVXZ5WEc1azk4clZuek54dEJZQm5LMWY2cThMVGlwMTZw?=
 =?utf-8?B?RzJWcjczQitWbUFEN0dTQ1ppdnBEc1IyQ1BBNkU1dEhsTmZxbUpMUGdaQ0ZG?=
 =?utf-8?B?cy9OU2xHUldEdXk4dHo0SnRTZVFwdU1pRC83SWQ1MUxpU25SL2ZuVCtFbjYr?=
 =?utf-8?B?MEVrYVRERjAxR2lpZDloVVMxd0ZKQXRjcXIrOGhrejJtRHAydlBuZloyVUF5?=
 =?utf-8?B?dnd6MzRWaEFOb2hvS2U2ZlMrS1BWc3ZSWVMyRWdITmhyRS9uVERIZW56OXhn?=
 =?utf-8?B?d2FNZHArdVlBd05WZGtxZllNb1Qxc3JvU1VpdkJDM1o1L0d3VVB6cHk5SzlM?=
 =?utf-8?B?cjBucW5qOGhldm1oRkFFMDRHWitDUUY1SUVIMVJFSCswVHpSaWVsMXBjVTQ0?=
 =?utf-8?B?SU5lRnVjaWluL05JaVQ0bUg3QlZyTTFPR3pqSzIwTzdNcElRMDZJMkREam1h?=
 =?utf-8?B?b3NwSGY5VGVNc3BvN1lGcS9yVmx0d3J1SGFpdGJQRGFUdDBadEx1YWVDSC80?=
 =?utf-8?B?ejlIM1ZBeFlkTi80Q2IyTm0ra3U1eU93MXRpVDAralhvaHNjeTdnOS9nVmJ3?=
 =?utf-8?B?V2xIMWkwb0hRQnluQmdGRCtHeDRFTVZQTFIvSmY1SXd5YjdwOFFFcFlyN3My?=
 =?utf-8?B?UWhqR2JpamZtbW5WZHZJWnh1Wmx3RlJCcVhmOEdXUzdsVWppamp3aWR0VEFH?=
 =?utf-8?B?U1ZhZCt2VzYyVDl2WVZ5UVRsYnlYcUJnbHVHSlJYYllvWmhWVXVpUHBTZ3pO?=
 =?utf-8?B?QzVQREZWdUZqWGlJZkhnNmU5dVJEQlI2QjErNSsvQWxmdWdFTGdEaFVFYnFT?=
 =?utf-8?B?NFdLY2UxNHQ1c1I1eHFPR200YzAzKzRtbkN0a0xEVjZNekpPTlhYcm1EU0dZ?=
 =?utf-8?Q?80nBGdCXG8fEQUBUthlk17OP0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c17a90f-1185-4bda-c5df-08dd30e78f3d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 19:55:25.7478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEHtWsgbfXFUk+HQb78puW1AuLW88Q4OPDbJukADFvggVkc+GnTC1u+SPC5U71mS93oFD7cLg44+W2cPFt/tSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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

On 2025-01-08 17:55, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Current kfd driver has its own PASID value for a kfd process and uses it to
> locate vm at interrupt handler or mapping between kfd process and vm. That
> design is not working when a physical gpu device has multiple spatial
> partitions, ex: adev in CPX mode. This patch has kfd driver use same pasid
> values that graphic driver generated which is per vm per pasid.
>
> These pasid values are passed to fw/hardware. We do not need change interrupt
> handler though more pasid values are used. Also, pasid values at log are
> replaced by user process pid; pasid values are not exposed to user. Users see
> their process pids that have meaning in user space.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

One last thing I noticed: You are printing PIDs in hexadecimal in many 
places. Please change that to decimal (and without a 0x-prefix) because 
that's what people would expect and what they see in any other place 
that shows PIDs (like output from `top` or `ps`).

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  21 ----
>   .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  18 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  25 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  14 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   2 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  83 +++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  43 ++++---
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |   2 +-
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |   2 +-
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 +-
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  11 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 113 ++++++++++--------
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  10 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  19 +--
>   16 files changed, 194 insertions(+), 179 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 8af67f18500a..092dbd8bec97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>   };
>   
>   struct amdgpu_device;
> +struct kfd_process_device;
>   struct amdgpu_reset_context;
>   
>   enum kfd_mem_attachment_type {
> @@ -299,8 +300,6 @@ bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
>   	(&((struct amdgpu_fpriv *)					\
>   		((struct drm_file *)(drm_priv))->driver_priv)->vm)
>   
> -int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> -				     struct amdgpu_vm *avm, u32 pasid);
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   					struct amdgpu_vm *avm,
>   					void **process_info,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1e998f972c30..2b4d3840e5bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1529,27 +1529,6 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
>   	amdgpu_bo_unreserve(bo);
>   }
>   
> -int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> -				     struct amdgpu_vm *avm, u32 pasid)
> -
> -{
> -	int ret;
> -
> -	/* Free the original amdgpu allocated pasid,
> -	 * will be replaced with kfd allocated pasid.
> -	 */
> -	if (avm->pasid) {
> -		amdgpu_pasid_free(avm->pasid);
> -		amdgpu_vm_set_pasid(adev, avm, 0);
> -	}
> -
> -	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   					   struct amdgpu_vm *avm,
>   					   void **process_info,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 795382b55e0a..fc78c5f17c00 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -107,20 +107,30 @@ static void cik_event_interrupt_wq(struct kfd_node *dev,
>   		kfd_signal_hw_exception_event(pasid);
>   	else if (ihre->source_id == CIK_INTSRC_GFX_PAGE_INV_FAULT ||
>   		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) {
> +		struct kfd_process_device *pdd = NULL;
>   		struct kfd_vm_fault_info info;
> +		struct kfd_process *p;
>   
>   		kfd_smi_event_update_vmfault(dev, pasid);
> -		kfd_dqm_evict_pasid(dev->dqm, pasid);
> +		p = kfd_lookup_process_by_pasid(pasid, &pdd);
> +		if (!pdd)
> +			return;
> +
> +		kfd_evict_process_device(pdd);
>   
>   		memset(&info, 0, sizeof(info));
>   		amdgpu_amdkfd_gpuvm_get_vm_fault_info(dev->adev, &info);
> -		if (!info.page_addr && !info.status)
> +		if (!info.page_addr && !info.status){
> +			kfd_unref_process(p);
>   			return;
> +		}
>   
>   		if (info.vmid == vmid)
> -			kfd_signal_vm_fault_event(dev, pasid, &info, NULL);
> +			kfd_signal_vm_fault_event(pdd, &info, NULL);
>   		else
> -			kfd_signal_vm_fault_event(dev, pasid, NULL, NULL);
> +			kfd_signal_vm_fault_event(pdd, &info, NULL);
> +
> +		kfd_unref_process(p);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 065d87841459..2751d4316083 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -155,8 +155,8 @@ static int kfd_open(struct inode *inode, struct file *filep)
>   	/* filep now owns the reference returned by kfd_create_process */
>   	filep->private_data = process;
>   
> -	dev_dbg(kfd_device, "process %d opened, compat mode (32 bit) - %d\n",
> -		process->pasid, process->is_32bit_user_mode);
> +	dev_dbg(kfd_device, "process pid %d opened kfd node, compat mode (32 bit) - %d\n",
> +		process->lead_thread->pid, process->is_32bit_user_mode);
>   
>   	return 0;
>   }
> @@ -361,8 +361,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_acquire_queue_buf;
>   	}
>   
> -	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
> -			p->pasid,
> +	pr_debug("Creating queue for process pid 0x%x on gpu 0x%x\n",
> +			p->lead_thread->pid,
>   			dev->id);
>   
>   	err = pqm_create_queue(&p->pqm, dev, &q_properties, &queue_id,
> @@ -415,9 +415,9 @@ static int kfd_ioctl_destroy_queue(struct file *filp, struct kfd_process *p,
>   	int retval;
>   	struct kfd_ioctl_destroy_queue_args *args = data;
>   
> -	pr_debug("Destroying queue id %d for pasid 0x%x\n",
> +	pr_debug("Destroying queue id %d for process pid 0x%x\n",
>   				args->queue_id,
> -				p->pasid);
> +				p->lead_thread->pid);
>   
>   	mutex_lock(&p->mutex);
>   
> @@ -468,8 +468,8 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
>   	properties.pm4_target_xcc = (args->queue_percentage >> 8) & 0xFF;
>   	properties.priority = args->queue_priority;
>   
> -	pr_debug("Updating queue id %d for pasid 0x%x\n",
> -			args->queue_id, p->pasid);
> +	pr_debug("Updating queue id %d for process pid 0x%x\n",
> +			args->queue_id, p->lead_thread->pid);
>   
>   	mutex_lock(&p->mutex);
>   
> @@ -695,7 +695,7 @@ static int kfd_ioctl_get_process_apertures(struct file *filp,
>   	struct kfd_process_device_apertures *pAperture;
>   	int i;
>   
> -	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
> +	dev_dbg(kfd_device, "get apertures for process pid 0x%x", p->lead_thread->pid);
>   
>   	args->num_of_nodes = 0;
>   
> @@ -747,7 +747,8 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
>   	int ret;
>   	int i;
>   
> -	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
> +	dev_dbg(kfd_device, "get apertures for process pid 0x%x",
> +			p->lead_thread->pid);
>   
>   	if (args->num_of_nodes == 0) {
>   		/* Return number of nodes, so that user space can alloacate
> @@ -3365,12 +3366,12 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
>   
>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>   
> -	pr_debug("pasid 0x%x mapping mmio page\n"
> +	pr_debug("process pid 0x%x mapping mmio page\n"
>   		 "     target user address == 0x%08llX\n"
>   		 "     physical address    == 0x%08llX\n"
>   		 "     vm_flags            == 0x%04lX\n"
>   		 "     size                == 0x%04lX\n",
> -		 process->pasid, (unsigned long long) vma->vm_start,
> +		 process->lead_thread->pid, (unsigned long long) vma->vm_start,
>   		 address, vma->vm_flags, PAGE_SIZE);
>   
>   	return io_remap_pfn_range(vma,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index a8abc3091801..12456c61ffa5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -204,11 +204,12 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
>   				   size_t exception_data_size)
>   {
>   	struct kfd_process *p;
> +	struct kfd_process_device *pdd = NULL;
>   	bool signaled_to_debugger_or_runtime = false;
>   
> -	p = kfd_lookup_process_by_pasid(pasid);
> +	p = kfd_lookup_process_by_pasid(pasid, &pdd);
>   
> -	if (!p)
> +	if (!pdd)
>   		return false;
>   
>   	if (!kfd_dbg_ev_raise(trap_mask, p, dev, doorbell_id, true,
> @@ -238,9 +239,8 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
>   
>   			mutex_unlock(&p->mutex);
>   		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
> -			kfd_dqm_evict_pasid(dev->dqm, p->pasid);
> -			kfd_signal_vm_fault_event(dev, p->pasid, NULL,
> -							exception_data);
> +			kfd_evict_process_device(pdd);
> +			kfd_signal_vm_fault_event(pdd, NULL, exception_data);
>   
>   			signaled_to_debugger_or_runtime = true;
>   		}
> @@ -276,8 +276,8 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   		data = (struct kfd_hsa_memory_exception_data *)
>   						pdd->vm_fault_exc_data;
>   
> -		kfd_dqm_evict_pasid(pdd->dev->dqm, p->pasid);
> -		kfd_signal_vm_fault_event(pdd->dev, p->pasid, NULL, data);
> +		kfd_evict_process_device(pdd);
> +		kfd_signal_vm_fault_event(pdd, NULL, data);
>   		error_reason &= ~KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index a29374c86405..1e14ceb49f0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1558,7 +1558,7 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
>   	u32 cam_index;
>   
>   	if (entry->ih == &adev->irq.ih_soft || entry->ih == &adev->irq.ih1) {
> -		p = kfd_lookup_process_by_pasid(entry->pasid);
> +		p = kfd_lookup_process_by_pasid(entry->pasid, NULL);
>   		if (!p)
>   			return true;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 1405e8affd48..07f6a9e4a90d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -223,7 +223,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	}
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> -	queue_input.process_id = qpd->pqm->process->pasid;
> +	queue_input.process_id = pdd->pasid;
>   	queue_input.page_table_base_addr =  qpd->page_table_base;
>   	queue_input.process_va_start = 0;
>   	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
> @@ -542,6 +542,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   			struct qcm_process_device *qpd,
>   			struct queue *q)
>   {
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct device *dev = dqm->dev->adev->dev;
>   	int allocated_vmid = -1, i;
>   
> @@ -560,9 +561,9 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   
>   	pr_debug("vmid allocated: %d\n", allocated_vmid);
>   
> -	dqm->vmid_pasid[allocated_vmid] = q->process->pasid;
> +	dqm->vmid_pasid[allocated_vmid] = pdd->pasid;
>   
> -	set_pasid_vmid_mapping(dqm, q->process->pasid, allocated_vmid);
> +	set_pasid_vmid_mapping(dqm, pdd->pasid, allocated_vmid);
>   
>   	qpd->vmid = allocated_vmid;
>   	q->properties.vmid = allocated_vmid;
> @@ -814,6 +815,11 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>   		return -EOPNOTSUPP;
>   	}
>   
> +	/* taking the VMID for that process on the safe way using PDD */
> +	pdd = kfd_get_process_device_data(dev, p);
> +	if (!pdd)
> +		return -EFAULT;
> +
>   	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
>   	 * ATC_VMID15_PASID_MAPPING
>   	 * to check which VMID the current process is mapped to.
> @@ -823,23 +829,19 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>   		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
>   				(dev->adev, vmid, &queried_pasid);
>   
> -		if (status && queried_pasid == p->pasid) {
> -			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
> -					vmid, p->pasid);
> +		if (status && queried_pasid == pdd->pasid) {
> +			pr_debug("Killing wave fronts of vmid %d and process pid 0x%x\n",
> +					vmid, p->lead_thread->pid);
>   			break;
>   		}
>   	}
>   
>   	if (vmid > last_vmid_to_scan) {
> -		dev_err(dev->adev->dev, "Didn't find vmid for pasid 0x%x\n", p->pasid);
> +		dev_err(dev->adev->dev, "Didn't find vmid for process pid 0x%x\n",
> +				p->lead_thread->pid);
>   		return -EFAULT;
>   	}
>   
> -	/* taking the VMID for that process on the safe way using PDD */
> -	pdd = kfd_get_process_device_data(dev, p);
> -	if (!pdd)
> -		return -EFAULT;
> -
>   	reg_gfx_index.bits.sh_broadcast_writes = 1;
>   	reg_gfx_index.bits.se_broadcast_writes = 1;
>   	reg_gfx_index.bits.instance_broadcast_writes = 1;
> @@ -1075,8 +1077,8 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
>   	if (q->properties.is_suspended)
>   		return 0;
>   
> -	pr_debug("Suspending PASID %u queue [%i]\n",
> -			pdd->process->pasid,
> +	pr_debug("Suspending process pid %u queue [%i]\n",
> +			pdd->process->lead_thread->pid,
>   			q->properties.queue_id);
>   
>   	is_new = q->properties.exception_status & KFD_EC_MASK(EC_QUEUE_NEW);
> @@ -1123,8 +1125,8 @@ static int resume_single_queue(struct device_queue_manager *dqm,
>   
>   	pdd = qpd_to_pdd(qpd);
>   
> -	pr_debug("Restoring from suspend PASID %u queue [%i]\n",
> -			    pdd->process->pasid,
> +	pr_debug("Restoring from suspend process pid %u queue [%i]\n",
> +			    pdd->process->lead_thread->pid,
>   			    q->properties.queue_id);
>   
>   	q->properties.is_suspended = false;
> @@ -1157,8 +1159,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   		goto out;
>   
>   	pdd = qpd_to_pdd(qpd);
> -	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>   
>   	pdd->last_evict_timestamp = get_jiffies_64();
>   	/* Mark all queues as evicted. Deactivate all active queues on
> @@ -1215,8 +1217,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   	if (!pdd->drm_priv)
>   		goto out;
>   
> -	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>   
>   	/* Mark all queues as evicted. Deactivate all active queues on
>   	 * the qpd.
> @@ -1274,8 +1276,8 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   		goto out;
>   	}
>   
> -	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>   
>   	/* Update PD Base in QPD */
>   	qpd->page_table_base = pd_base;
> @@ -1358,8 +1360,8 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   	if (!pdd->drm_priv)
>   		goto vm_not_acquired;
>   
> -	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>   
>   	/* Update PD Base in QPD */
>   	qpd->page_table_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
> @@ -2151,7 +2153,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   
>   	dev_err(dqm->dev->adev->dev, "queue id 0x%0x at pasid 0x%0x is reset\n",
> -		q->properties.queue_id, q->process->pasid);
> +		q->properties.queue_id, pdd->process->lead_thread->pid);
>   
>   	pdd->has_reset_queue = true;
>   	if (q->properties.is_active) {
> @@ -2987,20 +2989,19 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
>   
>   int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id)
>   {
> -	struct kfd_process_device *pdd;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process_device *pdd = NULL;
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, &pdd);
>   	struct device_queue_manager *dqm = knode->dqm;
>   	struct device *dev = dqm->dev->adev->dev;
>   	struct qcm_process_device *qpd;
>   	struct queue *q = NULL;
>   	int ret = 0;
>   
> -	if (!p)
> +	if (!pdd)
>   		return -EINVAL;
>   
>   	dqm_lock(dqm);
>   
> -	pdd = kfd_get_process_device_data(dqm->dev, p);
>   	if (pdd) {
>   		qpd = &pdd->qpd;
>   
> @@ -3033,6 +3034,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
>   
>   out:
>   	dqm_unlock(dqm);
> +	kfd_unref_process(p);
>   	return ret;
>   }
>   
> @@ -3074,24 +3076,21 @@ static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
>   	return ret;
>   }
>   
> -int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
> +int kfd_evict_process_device(struct kfd_process_device *pdd)
>   {
> -	struct kfd_process_device *pdd;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct device_queue_manager *dqm;
> +	struct kfd_process *p;
>   	int ret = 0;
>   
> -	if (!p)
> -		return -EINVAL;
> +	p = pdd->process;
> +	dqm = pdd->dev->dqm;
> +
>   	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
> -	pdd = kfd_get_process_device_data(dqm->dev, p);
> -	if (pdd) {
> -		if (dqm->dev->kfd->shared_resources.enable_mes)
> -			ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
> -		else
> -			ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> -	}
>   
> -	kfd_unref_process(p);
> +	if (dqm->dev->kfd->shared_resources.enable_mes)
> +		ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
> +	else
> +		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index d075f24e5f9f..d41f5887e4c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -727,7 +727,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>   	 * to process context, kfd_process could attempt to exit while we are
>   	 * running so the lookup function increments the process ref count.
>   	 */
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   
>   	if (!p)
>   		return; /* Presumably process exited. */
> @@ -1139,8 +1139,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>   
>   	if (type == KFD_EVENT_TYPE_MEMORY) {
>   		dev_warn(kfd_device,
> -			"Sending SIGSEGV to process %d (pasid 0x%x)",
> -				p->lead_thread->pid, p->pasid);
> +			"Sending SIGSEGV to process pid %d",
> +				p->lead_thread->pid);
>   		send_sig(SIGSEGV, p->lead_thread, 0);
>   	}
>   
> @@ -1148,13 +1148,13 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>   	if (send_signal) {
>   		if (send_sigterm) {
>   			dev_warn(kfd_device,
> -				"Sending SIGTERM to process %d (pasid 0x%x)",
> -					p->lead_thread->pid, p->pasid);
> +				"Sending SIGTERM to process pid %d",
> +					p->lead_thread->pid);
>   			send_sig(SIGTERM, p->lead_thread, 0);
>   		} else {
>   			dev_err(kfd_device,
> -				"Process %d (pasid 0x%x) got unhandled exception",
> -				p->lead_thread->pid, p->pasid);
> +				"Process pid %d got unhandled exception",
> +				p->lead_thread->pid);
>   		}
>   	}
>   
> @@ -1168,7 +1168,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
>   	 * to process context, kfd_process could attempt to exit while we are
>   	 * running so the lookup function increments the process ref count.
>   	 */
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   
>   	if (!p)
>   		return; /* Presumably process exited. */
> @@ -1177,22 +1177,20 @@ void kfd_signal_hw_exception_event(u32 pasid)
>   	kfd_unref_process(p);
>   }
>   
> -void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
> +void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>   				struct kfd_vm_fault_info *info,
>   				struct kfd_hsa_memory_exception_data *data)
>   {
>   	struct kfd_event *ev;
>   	uint32_t id;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = pdd->process;
>   	struct kfd_hsa_memory_exception_data memory_exception_data;
>   	int user_gpu_id;
>   
> -	if (!p)
> -		return; /* Presumably process exited. */
> -
> -	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
> +	user_gpu_id = kfd_process_get_user_gpu_id(p, pdd->dev->id);
>   	if (unlikely(user_gpu_id == -EINVAL)) {
> -		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
> +		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n",
> +			  pdd->dev->id);
>   		return;
>   	}
>   
> @@ -1229,7 +1227,6 @@ void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
>   		}
>   
>   	rcu_read_unlock();
> -	kfd_unref_process(p);
>   }
>   
>   void kfd_signal_reset_event(struct kfd_node *dev)
> @@ -1264,7 +1261,8 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   		}
>   
>   		if (unlikely(!pdd)) {
> -			WARN_ONCE(1, "Could not get device data from pasid:0x%x\n", p->pasid);
> +			WARN_ONCE(1, "Could not get device data from process pid:0x%x\n",
> +				  p->lead_thread->pid);
>   			continue;
>   		}
>   
> @@ -1273,8 +1271,15 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   
>   		if (dev->dqm->detect_hang_count) {
>   			struct amdgpu_task_info *ti;
> +			struct amdgpu_fpriv *drv_priv;
> +
> +			if (unlikely(amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))) {
> +				WARN_ONCE(1, "Could not get vm for device %x from pid:0x%x\n",
> +					  dev->id, p->lead_thread->pid);
> +				continue;
> +			}
>   
> -			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
> +			ti = amdgpu_vm_get_task_info_vm(&drv_priv->vm);
>   			if (ti) {
>   				dev_err(dev->adev->dev,
>   					"Queues reset on process %s tid %d thread %s pid %d\n",
> @@ -1311,7 +1316,7 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   
>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   {
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   	struct kfd_hsa_memory_exception_data memory_exception_data;
>   	struct kfd_hsa_hw_exception_data hw_exception_data;
>   	struct kfd_event *ev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index b3f988b275a8..c5f97e6e36ff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -194,7 +194,7 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
>   	enum amdgpu_ras_block block = 0;
>   	int ret = -EINVAL;
>   	uint32_t reset = 0;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   
>   	if (!p)
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 0cb5c582ce7d..b8a91bf4ef30 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -146,7 +146,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>   {
>   	enum amdgpu_ras_block block = 0;
>   	uint32_t reset = 0;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
>   	u64 event_id;
>   	int old_poison, ret;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 1f9f5bfeaf86..d56525201155 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -47,7 +47,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
>   		packet->bitfields2.exec_cleaner_shader = 1;
>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>   	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>   	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>   	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
>   	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
> @@ -106,7 +106,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
>   		packet->bitfields2.exec_cleaner_shader = 1;
>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>   	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>   	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>   	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
>   	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index c1199d06d131..347c86e1c378 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -42,6 +42,7 @@ unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size)
>   static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>   				struct qcm_process_device *qpd)
>   {
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct pm4_mes_map_process *packet;
>   
>   	packet = (struct pm4_mes_map_process *)buffer;
> @@ -52,7 +53,7 @@ static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>   					sizeof(struct pm4_mes_map_process));
>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>   	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>   	packet->bitfields3.page_table_base = qpd->page_table_base;
>   	packet->bitfields10.gds_size = qpd->gds_size;
>   	packet->bitfields10.num_gws = qpd->num_gws;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d8cd913aa772..0a99c5c9cadc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -851,6 +851,8 @@ struct kfd_process_device {
>   
>   	/* Tracks queue reset status */
>   	bool has_reset_queue;
> +
> +	u32 pasid;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> @@ -910,8 +912,6 @@ struct kfd_process {
>   	/* We want to receive a notification when the mm_struct is destroyed */
>   	struct mmu_notifier mmu_notifier;
>   
> -	u32 pasid;
> -
>   	/*
>   	 * Array of kfd_process_device pointers,
>   	 * one for each device the process is using.
> @@ -1039,7 +1039,8 @@ void kfd_process_destroy_wq(void);
>   void kfd_cleanup_processes(void);
>   struct kfd_process *kfd_create_process(struct task_struct *thread);
>   struct kfd_process *kfd_get_process(const struct task_struct *task);
> -struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
> +struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
> +						 struct kfd_process_device **pdd);
>   struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
>   
>   int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
> @@ -1337,7 +1338,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm);
>   struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
>   					enum kfd_queue_type type);
>   void kernel_queue_uninit(struct kernel_queue *kq);
> -int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
> +int kfd_evict_process_device(struct kfd_process_device *pdd);
>   int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id);
>   
>   /* Process Queue Manager */
> @@ -1492,7 +1493,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>   int kfd_get_num_events(struct kfd_process *p);
>   int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>   
> -void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
> +void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>   				struct kfd_vm_fault_info *info,
>   				struct kfd_hsa_memory_exception_data *data);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 083f83c94531..ab77bdf08ee1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -282,8 +282,8 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   	cu_cnt = 0;
>   	proc = pdd->process;
>   	if (pdd->qpd.queue_count == 0) {
> -		pr_debug("Gpu-Id: %d has no active queues for process %d\n",
> -			 dev->id, proc->pasid);
> +		pr_debug("Gpu-Id: %d has no active queues for process pid %d\n",
> +			 dev->id, (int)proc->lead_thread->pid);
>   		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
>   	}
>   
> @@ -327,12 +327,9 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>   			       char *buffer)
>   {
> -	if (strcmp(attr->name, "pasid") == 0) {
> -		struct kfd_process *p = container_of(attr, struct kfd_process,
> -						     attr_pasid);
> -
> -		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
> -	} else if (strncmp(attr->name, "vram_", 5) == 0) {
> +	if (strcmp(attr->name, "pasid") == 0)
> +		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
> +	else if (strncmp(attr->name, "vram_", 5) == 0) {
>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>   							      attr_vram);
>   		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
> @@ -1056,9 +1053,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> -		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
> -				pdd->dev->id, p->pasid);
> -
> +		pr_debug("Releasing pdd (topology id %d, for pid 0x%0x)\n",
> +			pdd->dev->id, p->lead_thread->pid);
>   		kfd_process_device_destroy_cwsr_dgpu(pdd);
>   		kfd_process_device_destroy_ib_mem(pdd);
>   
> @@ -1174,7 +1170,6 @@ static void kfd_process_wq_release(struct work_struct *work)
>   
>   	kfd_event_free_process(p);
>   
> -	kfd_pasid_free(p->pasid);
>   	mutex_destroy(&p->mutex);
>   
>   	put_task_struct(p->lead_thread);
> @@ -1525,12 +1520,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   	atomic_set(&process->debugged_process_count, 0);
>   	sema_init(&process->runtime_enable_sema, 0);
>   
> -	process->pasid = kfd_pasid_alloc();
> -	if (process->pasid == 0) {
> -		err = -ENOSPC;
> -		goto err_alloc_pasid;
> -	}
> -
>   	err = pqm_init(&process->pqm, process);
>   	if (err != 0)
>   		goto err_process_pqm_init;
> @@ -1584,8 +1573,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   err_init_apertures:
>   	pqm_uninit(&process->pqm);
>   err_process_pqm_init:
> -	kfd_pasid_free(process->pasid);
> -err_alloc_pasid:
>   	kfd_event_free_process(process);
>   err_event_init:
>   	mutex_destroy(&process->mutex);
> @@ -1704,15 +1691,18 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	if (ret)
>   		goto err_init_cwsr;
>   
> -	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, avm, p->pasid);
> -	if (ret)
> -		goto err_set_pasid;
> +	if (unlikely(!avm->pasid)) {
> +		dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
> +				 avm);
> +		goto err_get_pasid;
> +	}
>   
> +	pdd->pasid = avm->pasid;
>   	pdd->drm_file = drm_file;
>   
>   	return 0;
>   
> -err_set_pasid:
> +err_get_pasid:
>   	kfd_process_device_destroy_cwsr_dgpu(pdd);
>   err_init_cwsr:
>   	kfd_process_device_destroy_ib_mem(pdd);
> @@ -1798,25 +1788,50 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>   		idr_remove(&pdd->alloc_idr, handle);
>   }
>   
> -/* This increments the process->ref counter. */
> -struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
> +static struct kfd_process_device *kfd_lookup_process_device_by_pasid(u32 pasid)
>   {
> -	struct kfd_process *p, *ret_p = NULL;
> +	struct kfd_process_device *ret_p = NULL;
> +	struct kfd_process *p;
>   	unsigned int temp;
> -
> -	int idx = srcu_read_lock(&kfd_processes_srcu);
> +	int i;
>   
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -		if (p->pasid == pasid) {
> -			kref_get(&p->ref);
> -			ret_p = p;
> -			break;
> +		for (i = 0; i < p->n_pdds; i++) {
> +			if (p->pdds[i]->pasid == pasid) {
> +				ret_p = p->pdds[i];
> +				break;
> +			}
>   		}
> +		if (ret_p)
> +			break;
> +	}
> +	return ret_p;
> +}
> +
> +/* This increments the process->ref counter. */
> +struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
> +                                               struct kfd_process_device **pdd)
> +{
> +	struct kfd_process_device *ret_p;
> +
> +	int idx = srcu_read_lock(&kfd_processes_srcu);
> +
> +	ret_p = kfd_lookup_process_device_by_pasid(pasid);
> +	if (ret_p) {
> +		if (pdd)
> +			*pdd = ret_p;
> +		kref_get(&ret_p->process->ref);
> +
> +		srcu_read_unlock(&kfd_processes_srcu, idx);
> +		return ret_p->process;
>   	}
>   
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   
> -	return ret_p;
> +	if (pdd)
> +		*pdd = NULL;
> +
> +	return NULL;
>   }
>   
>   /* This increments the process->ref counter. */
> @@ -1972,7 +1987,7 @@ static void evict_process_worker(struct work_struct *work)
>   	 */
>   	p = container_of(dwork, struct kfd_process, eviction_work);
>   
> -	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
> +	pr_debug("Started evicting process pid 0x%x\n", p->lead_thread->pid);
>   	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>   	if (!ret) {
>   		/* If another thread already signaled the eviction fence,
> @@ -1984,9 +1999,9 @@ static void evict_process_worker(struct work_struct *work)
>   				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>   			kfd_process_restore_queues(p);
>   
> -		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
> +		pr_debug("Finished evicting process pid 0x%x\n", p->lead_thread->pid);
>   	} else
> -		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
> +		pr_err("Failed to evict queues of process pid 0x%x\n", p->lead_thread->pid);
>   }
>   
>   static int restore_process_helper(struct kfd_process *p)
> @@ -2003,9 +2018,11 @@ static int restore_process_helper(struct kfd_process *p)
>   
>   	ret = kfd_process_restore_queues(p);
>   	if (!ret)
> -		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
> +		pr_debug("Finished restoring process pid 0x%x\n",
> +			p->lead_thread->pid);
>   	else
> -		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
> +		pr_err("Failed to restore queues of process pid 0x%x\n",
> +		      p->lead_thread->pid);
>   
>   	return ret;
>   }
> @@ -2022,7 +2039,7 @@ static void restore_process_worker(struct work_struct *work)
>   	 * lifetime of this thread, kfd_process p will be valid
>   	 */
>   	p = container_of(dwork, struct kfd_process, restore_work);
> -	pr_debug("Started restoring pasid 0x%x\n", p->pasid);
> +	pr_debug("Started restoring process pasid 0x%x\n", (int)p->lead_thread->pid);
>   
>   	/* Setting last_restore_timestamp before successful restoration.
>   	 * Otherwise this would have to be set by KGD (restore_process_bos)
> @@ -2038,8 +2055,8 @@ static void restore_process_worker(struct work_struct *work)
>   
>   	ret = restore_process_helper(p);
>   	if (ret) {
> -		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
> -			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
> +		pr_debug("Failed to restore BOs of process pid 0x%x, retry after %d ms\n",
> +			 p->lead_thread->pid, PROCESS_BACK_OFF_TIME_MS);
>   		if (mod_delayed_work(kfd_restore_wq, &p->restore_work,
>   				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>   			kfd_process_restore_queues(p);
> @@ -2055,7 +2072,7 @@ void kfd_suspend_all_processes(void)
>   	WARN(debug_evictions, "Evicting all processes");
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>   		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
> -			pr_err("Failed to suspend process 0x%x\n", p->pasid);
> +			pr_err("Failed to suspend process pid 0x%x\n", p->lead_thread->pid);
>   		signal_eviction_fence(p);
>   	}
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
> @@ -2069,8 +2086,8 @@ int kfd_resume_all_processes(void)
>   
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>   		if (restore_process_helper(p)) {
> -			pr_err("Restore process %d failed during resume\n",
> -			       p->pasid);
> +			pr_err("Restore process pid %d failed during resume\n",
> +			      p->lead_thread->pid);
>   			ret = -EFAULT;
>   		}
>   	}
> @@ -2125,7 +2142,7 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>   	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
>   	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
>   							KFD_IRQ_FENCE_CLIENTID;
> -	irq_drain_fence[3] = pdd->process->pasid;
> +	irq_drain_fence[3] = pdd->pasid;
>   
>   	/*
>   	 * For GFX 9.4.3/9.5.0, send the NodeId also in IH cookie DW[3]
> @@ -2156,7 +2173,7 @@ void kfd_process_close_interrupt_drain(unsigned int pasid)
>   {
>   	struct kfd_process *p;
>   
> -	p = kfd_lookup_process_by_pasid(pasid);
> +	p = kfd_lookup_process_by_pasid(pasid, NULL);
>   
>   	if (!p)
>   		return;
> @@ -2278,7 +2295,7 @@ int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data)
>   
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>   		seq_printf(m, "Process %d PASID 0x%x:\n",
> -			   p->lead_thread->tgid, p->pasid);
> +			   p->lead_thread->tgid, p->lead_thread->pid);
>   
>   		mutex_lock(&p->mutex);
>   		r = pqm_debugfs_mqds(m, &p->pqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 9df56f8e09f9..e07201a8dc18 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -69,8 +69,8 @@ static int find_available_queue_slot(struct process_queue_manager *pqm,
>   	pr_debug("The new slot id %lu\n", found);
>   
>   	if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
> -		pr_info("Cannot open more queues for process with pasid 0x%x\n",
> -				pqm->process->pasid);
> +		pr_info("Cannot open more queues for process with pid 0x%x\n",
> +			pqm->process->lead_thread->pid);
>   		return -ENOMEM;
>   	}
>   
> @@ -432,8 +432,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   	}
>   
>   	if (retval != 0) {
> -		pr_err("Pasid 0x%x DQM create queue type %d failed. ret %d\n",
> -			pqm->process->pasid, type, retval);
> +		pr_err("process pid 0x%x DQM create queue type %d failed. ret %d\n",
> +			pqm->process->lead_thread->pid, type, retval);
>   		goto err_create_queue;
>   	}
>   
> @@ -527,7 +527,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>   		if (retval) {
>   			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
> -				pqm->process->pasid,
> +				pdd->pasid,
>   				pqn->q->properties.queue_id, retval);
>   			if (retval != -ETIME)
>   				goto err_destroy_queue;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index bd3e20d981e0..6359e19a7677 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -563,7 +563,8 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   	int r;
>   
>   	p = container_of(prange->svms, struct kfd_process, svms);
> -	pr_debug("pasid: %x svms 0x%p [0x%lx 0x%lx]\n", p->pasid, prange->svms,
> +	pr_debug("process pid: %x svms 0x%p [0x%lx 0x%lx]\n",
> +		 p->lead_thread->pid, prange->svms,
>   		 prange->start, prange->last);
>   
>   	if (svm_range_validate_svm_bo(node, prange))
> @@ -2979,7 +2980,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		return -EFAULT;
>   	}
>   
> -	p = kfd_lookup_process_by_pasid(pasid);
> +	p = kfd_lookup_process_by_pasid(pasid, NULL);
>   	if (!p) {
>   		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
>   		return 0;
> @@ -3242,7 +3243,8 @@ void svm_range_list_fini(struct kfd_process *p)
>   	struct svm_range *prange;
>   	struct svm_range *next;
>   
> -	pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);
> +	pr_debug("process pid 0x%x svms 0x%p\n", p->lead_thread->pid,
> +		 &p->svms);
>   
>   	cancel_delayed_work_sync(&p->svms.restore_work);
>   
> @@ -3265,7 +3267,8 @@ void svm_range_list_fini(struct kfd_process *p)
>   
>   	mutex_destroy(&p->svms.lock);
>   
> -	pr_debug("pasid 0x%x svms 0x%p done\n", p->pasid, &p->svms);
> +	pr_debug("process pid 0x%x svms 0x%p done\n",
> +		p->lead_thread->pid, &p->svms);
>   }
>   
>   int svm_range_list_init(struct kfd_process *p)
> @@ -3628,8 +3631,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	bool flush_tlb;
>   	int r, ret = 0;
>   
> -	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
> -		 p->pasid, &p->svms, start, start + size - 1, size);
> +	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
> +		 p->lead_thread->pid, &p->svms, start, start + size - 1, size);
>   
>   	r = svm_range_check_attr(p, nattr, attrs);
>   	if (r)
> @@ -3737,8 +3740,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   out:
>   	mutex_unlock(&process_info->lock);
>   
> -	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
> -		 &p->svms, start, start + size - 1, r);
> +	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n",
> +		 p->lead_thread->pid, &p->svms, start, start + size - 1, r);
>   
>   	return ret ? ret : r;
>   }
