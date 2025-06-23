Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DF3C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 22:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3F210E465;
	Mon, 23 Jun 2025 22:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HjLS/zVi";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BEF410E465
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 22:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCf13PhuUwOn4zP4N1khTDZznDGJggRTdZ3rqOmrdUxObQva3eA/SPOyLk8ILEcqfFAIzHryzExEMAvIc3SakQe7m3ajH6r6MUbf9AJ2wBxSy0z9383SPVRLYgxXHi75qNXU4H/jJ2PrNh60qwjWrLnoEm69ay3PorN6pxYvSf4MxyY1Jd+28PGD98kz2bJ3EhSyZCqHJVATjGsCIOsQwMaRLWpys82FuqnGK1/6de14QjXcv48d2VkF31K6TInFjmmSLDUNbGwF/rybyHIYc8aXB6BAv0wten17Z/Fkm0JQoGnUqbZcch1FYMCCtdGDUn6rTSY4NFeKHK5vfyEl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+0ipUSRLX5lnpwmEGOiyFgtVQK7FYwppbsJE34SGBA=;
 b=JsMGBEre9ibYOz3YIVWuBT1K3BU2HjoXxV/8Tngjlq24HQ05L+vSAG4nOOwRxW0OLfEt0LnbyW5NSoFfJH+SRo7jiAJSifeAf+28pdVX/ZO/PYO5p4UD7s3ATATNbPa6ZO+7HMJJeX7E8/H8bLWkUXhtOnaFVt7QNf3F9JpRHG773A1r+W0w852hd1y16TM/UiYvfJWnOgaz4uAgFID4EYm1bNdPybq2TAemB+8VU72lb/BBx4XUA0FUHqdp7GZQ9s7gPvTpvfRL1g3h29uP8716AxvHabe3xAgocZrLiM1PtdYXMoq/vvJayDHOt/hChYmFDTpH5Arwsjyau1iBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+0ipUSRLX5lnpwmEGOiyFgtVQK7FYwppbsJE34SGBA=;
 b=HjLS/zViupwif+zzOQNWHZ7URJGbdLhs4dDqxmRH2tVvhFbrU2HVnDDqBPsRetoydJIrRoEZCSvOXGsM4iG4oZJeM4zQJpKkU3f8PUxoIEnRLhmiukw+pCGz4go0QGtFOjuwDJ8V/v9I11N4jQZH1yAnUhcw+CEVK+xVKgN2Bpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 22:00:08 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 22:00:08 +0000
Message-ID: <a05023d3-e6f2-46c1-9733-da42a3079e28@amd.com>
Date: Mon, 23 Jun 2025 16:00:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Add a trace event for brightness
 programming
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250623171114.1156451-1-mario.limonciello@amd.com>
 <20250623171114.1156451-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250623171114.1156451-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7eba2e-209d-4b98-b929-08ddb2a15167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elp4VGxrL2x3ZlpCdHp5TCtQNzFwQWJmMytKQjVjVXB0eXRPTldvUnNHZTM2?=
 =?utf-8?B?MDVHNTdmV01kYVVZODF3aUlVUXBZaVpvQXBOZkxVV0FoWnlheUhCQTAvNWlI?=
 =?utf-8?B?eDlzYWZrVUtvQkpZUG9NQ0t5R05XeEk1M2t4VVNWeTVFRlFjRFoycDRIdzJO?=
 =?utf-8?B?UWxrQ1l0ZzluK1ZMMDZGdTZaeXhuTWdRL2JHc3lJSmNicmNXd0pMVURGRG4x?=
 =?utf-8?B?Vy9vQjJDWVlFTTNjN2toN1hGK05Xc0FQM29Pb3FVNVNkUTJRckpNODdYQ1Zw?=
 =?utf-8?B?bkJtazVZRnE5WEJ5ZnZrTSszVVh4WnpaV2Vud1J4YjZuMW5uZmt0elB3clZB?=
 =?utf-8?B?K2t2enhGSXNNZHhqTkg2TklaVWN4dzVOalpDL1hBVWt1SVJjMTNScktXRk1k?=
 =?utf-8?B?OGEya3JPeitpT3V5a0hsU05hVVlBc1FxRUh5OFVuUGdnTDViMGdVNjJSSzR1?=
 =?utf-8?B?R1F3elI2cnNPSHB2ZGl4amVhcEhDZ3Y2Q2U2Z0F6TWFhZ2hKSEhkUkZSbFJT?=
 =?utf-8?B?WlViZVJUN3EwRmZnYUZNVSszMkRvSXRzSHh2WWt6a2lBWVMxUHdYNkdkVS9K?=
 =?utf-8?B?aWRqQVhaUGY4Y2FrSi8wRVk3Q3VlamhCMFVXQ0szZnpQSThsV0dNSmhIMVcy?=
 =?utf-8?B?MEk3MDVVWWJoYjFZaG1mWjdaZVBxSmRmaEpub1VvNGF3a0VmM0tOdldncnho?=
 =?utf-8?B?aTlWMEI4ZGdDTldMb0FhQXh4S2dlaXB6Q2Yyay9LakUwUTNDMVZqQ0pIVDB2?=
 =?utf-8?B?ckwrYTNYSkRTR2JTQlZwTitSY2t0S3ZVeUVnY1hjZU9TZDdEUWNSd0ZWWWxy?=
 =?utf-8?B?RWVJWk1TNldvdTNuY0RqNk1kTmkzWHhicGVaSTh6OXd5cEVnOUczbXBDdEha?=
 =?utf-8?B?MVViRWlmU1lxTzFNaXdWd2RjL0VCY1VCdHpwVGMrVjZJbWlCRFVpdkhUQ1Qz?=
 =?utf-8?B?UlhHeWNWTWVQVWFuMmUvRFFHL2JhcHZ6TUpKZGp5YkN2MURUWmRzZkhXTStX?=
 =?utf-8?B?eUlvS1lnWE8zTzdJRTNPN1RESzlKQ0dHMEZnRUNJenhMaTR4MU9yVUh2UENt?=
 =?utf-8?B?NDBDUVg5UkFwTC92Y1BYNDVWOEhjbzRjWkh3c2VIdWU0TmxWeWRneW4ySDZQ?=
 =?utf-8?B?WjFHbE1OSXlJaTUrb1E2MjNnc3hCNTAyVDlKekswR0JTdnFQekViWFg0MGdC?=
 =?utf-8?B?S1hJTkI4RnB6TGNSLyt0MFpobDgyamwzazFKTHR2YjdpcStxSUpzRHZnOXBX?=
 =?utf-8?B?NktaMFB0WWtETXVZS3Fwbmk3djBsSzR3clVkbmJkdzlwRjBicjMxUGd1TnhW?=
 =?utf-8?B?aVFOUEdJSjlweWRvYThNaUMwRWc0K2YyZFBueDNkS04xRlFoTktUYjllc05t?=
 =?utf-8?B?MFd0NVcyTHFkK1JkQ3ZKaUZTTVpIY3dRNER6QWNKV3UzNEw3bzdUQjhmY0tV?=
 =?utf-8?B?RTJGZko0cFBHY2VSWE8rRjh2TVBWeERMem45alR5NU1RMkpiSVdGdXg3TXdR?=
 =?utf-8?B?bHlnanNlS0o0eEkwaWZBNFhqaGQ3MDByR2FLTW50R0JGMG1Pc0hoSnJpUWRm?=
 =?utf-8?B?UThSbkRwVXl2RDZjMWptUVRRZ0tOSi93alhJMXdBWlNYR2ZPTlRKRGMxNUFv?=
 =?utf-8?B?aUdHOUdtTlZOUlFSenhzWitDWWpYTERqVXBPSVB1TktidldwV2xEV0Q2bUJI?=
 =?utf-8?B?ZmJ0MS84NG8zYzBsZFZvZnRoZzhBUmxiNFdCcGRNSXVwcHg4d2Q5MmRzTjAy?=
 =?utf-8?B?N2V4cXFjeTZPYjJpZ3laU3BwbDZEN0hWbzhCRjBjREtXVHJ6K2t4NHZOckxl?=
 =?utf-8?Q?LEYdXZl22DRleqO7tN0t2EepGT8FN43ijAHOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFRiQzRmZUIwZEVoMWlYS3dxdmx1NEd1ZEZHeGlTM3RRZnY5allrY244UWFG?=
 =?utf-8?B?eFFwSHczN045c2w3QkowaEZMVFR6UWRpVGd0N2hpdGNsR3NjV3hJaFIrQTBO?=
 =?utf-8?B?a3p6cXpkdUg2RmFhTlhwaGZ6YVVxWnRBRXdRUjVEdXYxZlkxUFpJNFZMTHlX?=
 =?utf-8?B?SFNLZlhsc2VEYUFTZ1k5K3FBclpKdXNCOXhmTXd3TE5za1ZWNXNFTjNVQ01N?=
 =?utf-8?B?aE9xMit2eVZldll5TFgrZXcyYSt4dE02SDZ5TlBKSFNkZG5zNG5aaW55Vk1J?=
 =?utf-8?B?NmZscklxZjZjVGJmQWM3a3lpc09QbkJoRmEwbkM5bVhYNW9QZ1NDdkd6amtO?=
 =?utf-8?B?Y3FEdUt5VHEwVkt3ekxlbmlyOEo0YTFsZVB4V2FPa3QvaFA4OWpjQ0ozeTJR?=
 =?utf-8?B?SXFWN1VUSERjTmhIeUlLa3BxZmFXMHNNZ0tTcWJDQm5seVI5MjFYWFFmTnhq?=
 =?utf-8?B?MWZiNEszdGdiZjBpUXc4MWVGbHZNZHZhSjc0RGZKR1RDL3h2dGRNTk51Ymlr?=
 =?utf-8?B?aFExMU1mTXFSL1BiVzVYL252WWdoVWhGenkxRzNBTGc0VGdLQXVXMkg3NEZV?=
 =?utf-8?B?UUtwMm1QT3V3UWlUVHpCWjJ1a1F0VGtTcEw2T295R3V1RGZhTlgrWWRDZ2xw?=
 =?utf-8?B?UithK1dWL3JKcXZKMnZXakJTNUVHMkxKUWRaelFxeDVzT3ZtMXdOVTlaTFpV?=
 =?utf-8?B?b28veFVYbGFkYmlMcmJPc1M0MmhOWkxOMHBqZlpVLzRnRzBpUmtWSUZDRDJ6?=
 =?utf-8?B?eGpnUzhMbE5CV0R4dUZyUDB3R2NzZHZOUnBmSjArNUt0WUhCMU1aam9wZWxs?=
 =?utf-8?B?OXljem5TSVZZeU02d0J0dFgzUEo4ZVlNdWhYQ2Fxa1J2ZlNjUVBqenlKcmxi?=
 =?utf-8?B?N3UzS21TREtqMTlrcVNtK2NQRXhVcW1VQVNOQTFsaGliNWc0ZXdLR1A4dzNW?=
 =?utf-8?B?Q0liRU5iK21vc25idExFaFkwelQyMGRzcm9kUFh2S202dDV1dVQyeGZzcDVs?=
 =?utf-8?B?TXRqTWpJYTBjdnJaTi9PdlNNL0hKUHJMZ0xKYkdLMEdwSXVFNGpONDZoTnVH?=
 =?utf-8?B?eGdKSk1jOURMT25vVDlCMm1NdW9zRzZlZmdMWDlxeWhEeW0wYjJHWWYzdTVB?=
 =?utf-8?B?d3lCdzZxQ1Jsc1NKZjVGSStBdmREeGtmS1dGTTZzVmh1eUxwSjZFWXRVbkpR?=
 =?utf-8?B?T2UvQnlyUjRBWG16czc1aWlsdjBkaDF0U2c5Mkd5UVEreUQvNjJkTjJBdXky?=
 =?utf-8?B?NFJKWUlOWG9icWl1MndiM1ZRS3d0VjBKYnVEdGJ4REJRdzlhcVZtdUdVaGNT?=
 =?utf-8?B?ZDBnRUlGSUhmTFREQkVHS2gxbUhkVlJvblJqNHRmRk9ERTA0aUxPVVd6RkJx?=
 =?utf-8?B?OFhRS2hDeFBpNS9DRTZxSUVSM0JIeHB6WDhieXU0cE5sYjZya1BNVklQSFg0?=
 =?utf-8?B?c2pjS0dqMUxBYXdWSWtRcXY0TGhSM04vZW5vOVdORExxK3ozV0hsdmxaamVr?=
 =?utf-8?B?V2pYYmJDOFkrcFYwZDRxVW5WZkR1ejNPd0VuRFZDTUx6S0xEa2QwdzNqRkg2?=
 =?utf-8?B?cWRjZzkzbVZFOWxOT0c2TGNYdTgveXk5VWQwZENWWTdoa2w2OVViQVBDUTZw?=
 =?utf-8?B?YitVTTNWTlR5dndhUDNvMjY4QmRNdVRlV2RrUjZ2d2dwVFAzWjkvTEY2bnhr?=
 =?utf-8?B?TnhLbjg2QkFFUzRia0dRMHlBazhwdEg5MW9EQ3gwdFdvZ3dGcmVNQ3V3VTlP?=
 =?utf-8?B?b0lNRkNneUxYY3FCVTBNZDNyLzJYdEorTEVWcThVSzdnMkFCQlV5Qy95eS82?=
 =?utf-8?B?dVVmZzZtZzgzRFB3WFBHU3FxOWIzQWV1VGJjUmhBMzVtcDdaOVpha08wNnlK?=
 =?utf-8?B?YXpmdUJoODRPRjlUa0Z0bnN0ajNWOHMvSDhoN2ZBR2ptTlRNZk5mWklwRTlj?=
 =?utf-8?B?a0Nad3NqZHNJd0xoQWFDMHZZWmVlR2J6clI4QzI5OC9IdnF0MEFvTWRXSHE2?=
 =?utf-8?B?aEhLTS90VVU2Z293L3h5cnlxb2lpdkdnS2tFN0s3OXc3elFpR3FqUitpQ1Fo?=
 =?utf-8?B?MU1Ma0FBS1cwZE5MRHRpMUpYTCtkVmNmcm5tbGJpYWRjVjRtVjc5b3BiY1JK?=
 =?utf-8?Q?pJZodxVXD+D0iUvA2Z/wkW91P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7eba2e-209d-4b98-b929-08ddb2a15167
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 22:00:08.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bf0LGydOwRQlwu3JiX8pO4xrvRyCuOZ9hfrHSgbZArulQk/D+U+jz3ElCO3iOzOUStXUSFS7NHWsadoMLSJoKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 6/23/25 11:11, Mario Limonciello wrote:
> [Why]
> Brightness programming may involve a conversion of a user requested
> brightness against what was in a custom brightness curve. The values
> might not match what a user programmed.
> 
> [How]
> Add a new trace event to show specific converted brightness values.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/gpu/amdgpu/debugging.rst        | 18 +++++++++++++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 26 +++++++++++++++++++
>   3 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/amdgpu/debugging.rst
> index 7cbfea0606e1..ac914d524741 100644
> --- a/Documentation/gpu/amdgpu/debugging.rst
> +++ b/Documentation/gpu/amdgpu/debugging.rst
> @@ -85,3 +85,21 @@ UMR
>   GPU debugging and diagnostics tool.  Please see the umr
>   `documentation <https://umr.readthedocs.io/en/main/>`_ for more information
>   about its capabilities.
> +
> +Debugging backlight brightness
> +==============================
> +Default backlight brightness is intended to be set via the policy advertised
> +by the firmware.  Firmware will often provide different defaults for AC or DC.
> +Furthermore, some userspace software will save backlight brightness during
> +the previous boot and attempt to restore it.
> +
> +Some firmware also has support for a feature called "Custom Backlight Curves"
> +where an input value for brightness is mapped along a linearly interpolated
> +curve of brightness values that better match display characteristics.
> +
> +In the event of problems happening with backlight, there is a trace event
> +that can be enabled at bootup to log every brightness change request.
> +This can help isolate where the problem is. To enable the trace event add
> +the following to the kernel command line:
> +
> +  tp_printk trace_event=amdgpu_dm:amdgpu_dm_brightness:mod:amdgpu trace_buf_size=1M
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 77302caaf24a..2ac5cd225781 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4860,6 +4860,14 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   		reallow_idle = true;
>   	}
>   
> +	if (trace_amdgpu_dm_brightness_enabled()) {
> +		trace_amdgpu_dm_brightness(__builtin_return_address(0),
> +					   user_brightness,
> +					   brightness,
> +					   caps->aux_support,
> +					   power_supply_is_system_supplied() > 0);
> +	}
> +
>   	if (caps->aux_support) {
>   		rc = dc_link_set_backlight_level_nits(link, true, brightness,
>   						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index 4686d4b0cbad..308a36176bd2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -726,6 +726,32 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
>   	    )
>   );
>   
> +TRACE_EVENT(amdgpu_dm_brightness,
> +	TP_PROTO(void *function, u32 user_brightness, u32 converted_brightness, bool aux, bool ac),
> +	TP_ARGS(function, user_brightness, converted_brightness, aux, ac),
> +	TP_STRUCT__entry(
> +		__field(void *, function)
> +		__field(u32, user_brightness)
> +		__field(u32, converted_brightness)
> +		__field(bool, aux)
> +		__field(bool, ac)
> +	),
> +	TP_fast_assign(
> +		__entry->function = function;
> +		__entry->user_brightness = user_brightness;
> +		__entry->converted_brightness = converted_brightness;
> +		__entry->aux = aux;
> +		__entry->ac = ac;
> +	),
> +	TP_printk("%ps: brightness requested=%u converted=%u aux=%s power=%s",
> +		  (void *)__entry->function,
> +		  (u32)__entry->user_brightness,
> +		  (u32)__entry->converted_brightness,
> +		  (__entry->aux) ? "true" : "false",
> +		  (__entry->ac) ? "AC" : "DC"
> +	)
> +);
> +
>   #endif /* _AMDGPU_DM_TRACE_H_ */
>   
>   #undef TRACE_INCLUDE_PATH

