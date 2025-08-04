Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31465C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 18:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0CF10E222;
	Mon,  4 Aug 2025 18:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YEPjgZre";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D5910E222
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 18:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDr38eIKoNsxOaDTcLC08gTa7YlkUbL80mjYQIoPDHhInSrEgHvBhYk11/gLFesoefJYZ5AKmC/F3YYyRcqYt2KU+Flh1R6c0o/eH/Ywv91Jovrya9OfYjZnTiqw6MMVVOnjCckMaLsU4Mb8GbYg8rDpCzKnMpGKXaFohlHe33ky4wmJpZNDnjeKWG/zdCzms2GID9g4knSGOowXWFf3Kmq/bpAUSXO5941trEC1L0G3rrXg8jMc/AoiFCSVGovWYvC3dpFpxeeCfN4tqFZ4lCMtip3/EjLCYnfMrJ16ucVax2IdxDmHWuBldyyJtTF+QEUWAX7q6cN3dPJSEbhZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6zlBJs5OwQTHDWNIttpVAoFn+XGsrGZnNC0DM8zBFI=;
 b=I05SiktOF2bvCdxQwv2bQfdWUtI9bPcpZYNMwTTfTmWbnjUSQqia0QmVJENBLXhrXN7I38GQB1ZftI3axGV284ijOUhDVddkeyxQxP7XFeUNRc9+xriOUCfLoGpRgiO9hjTT6JDeN6ji9FwNhUkG1IFVis11zrI9RoJNxbbM7ZdVOBhq2NYEBh7xhnbF4iLILmqs+fdfdtTSI6JWR3SSh5Erc12vxQbsP73KOLIzdrT+OmWHFjk1VcMkWnsUq5CIacDjmTOw/j1cmUV2GYdTOJPJdfL6s9TXGiqDZBYqPbCgeYlSYhIQJmjo9OQY+BSDqyanANe7Xj0FB846QOv0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6zlBJs5OwQTHDWNIttpVAoFn+XGsrGZnNC0DM8zBFI=;
 b=YEPjgZreydzjOCVjdgNqEwkJE88ys4BNPkGO5zmRgUPhU7Q7yBzlDzEV5OXcmqcB61Lugu5DDCaH48/jOsixR1QXumGZU7py92G9NvslZ4BdAcS+Mm60A0KKY5PQ2vFhZb4SIW3Qg3wJ7UdjeBYfuY2NH7SYoL7CqI0Mu2r4cyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 18:59:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 18:59:25 +0000
Message-ID: <99761dc3-7814-42be-8d08-c8ff7b2a76cf@amd.com>
Date: Mon, 4 Aug 2025 20:59:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-2-timur.kristof@gmail.com>
 <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
 <aec0376f34db68c9e62d8ef5b8b5c51fe2eac5e2.camel@gmail.com>
 <CADnq5_MGRH2D1YnhxGLLLJft5FvLaNKzhDgwWu_LPb0NvCK6Tg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MGRH2D1YnhxGLLLJft5FvLaNKzhDgwWu_LPb0NvCK6Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00013DF9.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:c) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fa8a0d-0f29-4740-d247-08ddd38907a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDRXS21NbmFPVW5sL1F0UWQ0Y2hSMVFNWkxTaU1iYzBEUjRRcmFITWFpQ05r?=
 =?utf-8?B?dVlmYm5WWkw2aGh2QTdFUUpjUEhiZnlGRGhKdWtFSzh4M0RnN2txS3V2ZlVz?=
 =?utf-8?B?ZjNucVNiNWI0c1gxeW9kM0hYRkMwellpTEdwdzVkcldNaWtuUmdFWEVNZWE2?=
 =?utf-8?B?cHg5Y3BpUzJoVDAzMEVUeEIzTHF5L3NiK2xQd3MxQm92VFJibkp4SzlBZTRa?=
 =?utf-8?B?SEFTdjR0eldCS2R0OUl2NWpEUzdSQlQ5aGNvZ3FETExBTCtXQU05VDZ4cEth?=
 =?utf-8?B?citQRExjaVlDNzVMNDZpb3lzekFWcS8xNWlmemxFT1IxRlZGRFZLR25sOE9Y?=
 =?utf-8?B?V0VLcjJiMjQrNWQwaDR5MmtNSzZ1eHJtSmNFbEVBMW9RL1k1Tms2SU9Ua2dZ?=
 =?utf-8?B?QWp1cm9wcFhMNkUzY2lnSjRFQXh0V2RrTEVPUzFQajJKWTJSSzk4ZnVidUJC?=
 =?utf-8?B?RUhxN3pmNHVrSHVmc0pxM1ZOV1N5S0RIY0dONkZ4dUFkbG1YSkwxQXJzUjl3?=
 =?utf-8?B?M0ZPMjlEZ3o0WElXYWMyYzJxQjlNajExbTVQdTdSTzZaQUlubkFqTmdBSG8x?=
 =?utf-8?B?TFJnK3ZkamxvYjFQVVdrbEdPalVScTkzRndFbnp6cWlFYzY0TVplZEZ5VXd3?=
 =?utf-8?B?bGE5VEJjUzcxdGo5eCtwMHNGNkZuRFNheVE5Z2FnM3dUeFZSdlpPcVRCWVVz?=
 =?utf-8?B?MVhBVjN3WldoNStnRkd0cThTaDhUNzFwd2NFZ3BaTml2V2FqWTFwRlhnbTd4?=
 =?utf-8?B?ZnhtVzJjTzRRRkRjOXRtd1huOGJFWHBrcS9OVkhjSG93b0diQWZ3dnpmaFNw?=
 =?utf-8?B?VEFuU081c3h6WENmaVN6cHJ2RHFXM3MvTk1xTTBWRFovK2E1dDFlSktqVWpa?=
 =?utf-8?B?bHNaU3FUd1ErMHpON2lGQUJWZk0xbUphcFZoaXUyN0xhanVKYys4Z2p6QWdS?=
 =?utf-8?B?Z2tudldNN2tNVXl5SzFydmhTblFqSGVoWG1rUk9HVkhSeng0ei9HeGdEUnBn?=
 =?utf-8?B?YncxcHNzYXVTeEV3MmFJOHhCZ2x6dld3OVdnT1U3VFFhVk9adldXMXpVdldx?=
 =?utf-8?B?QmpkdVlUNkQ5NDJDbFhVYVo4bkFFUGhVdnFrMzNWakoxbXp0OHVoRjNrSlln?=
 =?utf-8?B?aEl5OWZ4dGNEWStJY1ZkdHJpd3MwNU4xcGlTdUFQMWp0dzZQc01CRnpMNnp3?=
 =?utf-8?B?Z09TRHUvRG84N1JLMjBkeENmeC9tSHo3N1Q4aDcxT2pIbnVqWEc3a0lBSEsr?=
 =?utf-8?B?MVdaalh5dzZicEpjQ0k2VDJhM1hQUkNXaTN6bTFHY1dmTkR4aUM2V3paTXBP?=
 =?utf-8?B?T1BDRDFvSWl0cTV2NHRNL1laQXgrVU9DRytOVDNPWWFJaFhVenhtcktJd1RZ?=
 =?utf-8?B?aVUxc3ZUWDk2dGF6c1N3TXpiVGZaMFVvOTV1YVNPMTR5RUVVdXpLVS9OcUtJ?=
 =?utf-8?B?U2tQUWgybGVKNjdtbUtaU0pvZUtzS21rWWNjZWRnczRqTVZYMitOUkRaRlBs?=
 =?utf-8?B?SiszRjZyT0lRWDdibDRPRVlqSGVqVllrc1Q5N1IyMDNiWlVKWm9iME5OVTNL?=
 =?utf-8?B?MDdwSVlTOTczM1NodVZZb1hrUTVIWk1mUnhZUkc5YndnKzY4N2RkTStVR0VX?=
 =?utf-8?B?SjVsNldrbXg0L1RSeWhpRkg0d2FURGw4eFVOa0FYSVRqWjQvSEN5SkNWenFS?=
 =?utf-8?B?SGZiakZpSzRJNnlwbFVhYllZbVExRkVXME12TVlsdGFPV1dCdkNMSXpFWEo4?=
 =?utf-8?B?ZkZ0Z041R2FZZlJseEdzeDBhaVo5TTRzTkROUTZtcHAydCtzV3dXNmRRejlt?=
 =?utf-8?B?WXU4MzE1WnN4TFdrZGJ3OGFBUkpadUxDNGNpR1NVV2NjREpnblNhTW5qSFhM?=
 =?utf-8?B?ZGJxSFY0M0R5RzBFUFF4SFhoOVBSTU1zazE3dGV3UnJtVE9ZeWczZHBNVHMz?=
 =?utf-8?Q?5rDymOcwGX0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdtaDV0VDgvMFFOMmUvMFVJazh5Mi9ZK3AwT0hRbVd4SXlObERiL05vNkFp?=
 =?utf-8?B?cFpJZENoZU1PL3czZ3FjTXd6Q0VOMmk3UFdHcU42Zy9QUFBxUW5kOGJJS3VF?=
 =?utf-8?B?T0I0Vk1WVjdGL2d0ZHJTRTNKNTNkbHROeFdjVmI0dktzdVBDRml4VTk2TURH?=
 =?utf-8?B?OG16S1g1R3VBWjNicDlSdDVxYi9DdnlYbnlCUjZ0V0VPaHU3dmxnemlFN1k0?=
 =?utf-8?B?akhIdEJYUk95OURhM0VDU1RhckRIMk83eEc0c2ZPa2tSZkkrV3RaREhpRnR0?=
 =?utf-8?B?Z0ZlSTRkSnZVRjAwRlgxU0ZuMjVGQjh4eDFISjZoU1d1bFNNNVZJY1gvT0lV?=
 =?utf-8?B?MS8rdEh2d1Z4ei9BNVk1aDVSSFZNSUxIQklZR281R3o1aEU3MEVDaGdHYlVa?=
 =?utf-8?B?QS9iaTlhRjN2RUNIQTlHT3c2WUptVEZRR3p5T25KY3RwQzhQbXF3SHFZeXVB?=
 =?utf-8?B?MlVTa0lmNTJ4U1NMRHBibTc5VlE4NTFXOG50ZEc0VE5pMkg1OHE1TGZFQVky?=
 =?utf-8?B?bW9ua0RKKzQvR01BVjBOdXVOeDQxNkQ2SHltTS80TU5qU201dHk4ay8yVFJQ?=
 =?utf-8?B?MlNxeTEvZFBRbXpEU2Z3TS83eTNmdXJ1emhkRnJJeWJXNzNDem13WDdBMkpR?=
 =?utf-8?B?cXhSYVJUK3lNUTZMRCtrUmdyeS91eTJTMzJYaE05M05iSFFYRENSYUt5cWVa?=
 =?utf-8?B?Y0RSQTJPNnlmLzVDQmFYZG8vTkJ5WUFYRVBQL0xhV0hZUCtkbElXSEU3NTN0?=
 =?utf-8?B?STdTallFSHJBYjRTZDl3Mm44WHJRTFZkYXAyY0lwcGRSY0t2RjE4LzMybTZJ?=
 =?utf-8?B?UnA3eHJUTjdTYnFkcEplS2ZsQ0ZWY0M1d2NjZitXQVpaUXBHak15V0NjZDNG?=
 =?utf-8?B?aVB1V09QeERhb09ZU2JGSEw4TDRyRElwek9UWGExclFISm4xUlRmQ2VEem9x?=
 =?utf-8?B?YWJuQmR5ZUV5eXhrSXpaeWpFMjE2aW0vTDVkME9yZDlHaUJTNkk2aGpQVjdy?=
 =?utf-8?B?WDluNk8wS3UzbjNZM2lmTlZkNCtRSjhRVnR6dTNYeEs0bGY5L3R6SERaekYx?=
 =?utf-8?B?OCtvdlEvTm9yYXFvVndZZDZZaHNBY2UrZSsyMXp1Ni9oN3NGUVZYajYrMEdE?=
 =?utf-8?B?Tk9WMXlQamJmTVRQMnpKRllsaERZSzNBK2hhemdQNkdSMW9JMzJJM0VmQmhx?=
 =?utf-8?B?UXpwMC9VYzNkR0JqODFRdUxLVmlOZ1ZKNXZ4WUpvR1QvTFptNEs2Qk5VNERM?=
 =?utf-8?B?eER4SEV4QkxzbkgwVStOeFFRcHVwR3U4Y2MvcUttV0xVODU0b1JjQUZ2Q2l4?=
 =?utf-8?B?U1lsNW4xcWJVenFyU1FTV05JMUJWYldYRExyZGN4OHRBTWcwcXZJS3UzbmYx?=
 =?utf-8?B?b0h6YlNRcFJhVlg3K0hqcmlHaEt1VjdGR21RemJhMCtvZllyT2dKVGhzaWpk?=
 =?utf-8?B?RGhxKzEzeGM1anBrZDBBRUw4aXIwbVJucFRFcGxmZloyUE1aM0U5d1g0eGxK?=
 =?utf-8?B?cUVPZzcyaHdpdG0zVURoS2Q5dDk5WlhjZ2x0VGJHYUs2bWhTRlI3YmxlNkNF?=
 =?utf-8?B?eWNwbnBXTTQ2N0hnWHdGeGJNQmNOL1JETmx5M1lBZW9rampSM1RQd0dTNlpt?=
 =?utf-8?B?em5HdVNjUWVhaUdRK0JaRGpvNElxcStRdFRSOGJBd2tYRDg0VzFHWCtEaU1w?=
 =?utf-8?B?aytOY1ZBWWZkSHhpbjFmeEluajlyZEprdm9idDNSaGtTbWhRazU4dlJOUzNK?=
 =?utf-8?B?WmJBV05Qbk84NTVWNE8zRHp0YWpmRXpxeUN2NGFrdUcvWFgyQWZVOWN6aGtR?=
 =?utf-8?B?ZHZVeTNnQTcyakNVVVpURmVnSmxMSjRyS1A4TFJyMW1RR1BzdmIyL2p5OHho?=
 =?utf-8?B?T3N5eHlQaWZkUXNYQUtzcktXNlBMdm42SGJRcVpnR05KSm5WODBROEUxYXdY?=
 =?utf-8?B?RitLa3ZXRm52Y281ZC9GVXNVWlF2QUFIUjFxckwxYzRNa2tXWE1FU2MxVmMy?=
 =?utf-8?B?cDgxVWNDZ2dzY0ZuTmNxNXh0WjQxRnVna1BEM0xaNFRLSGZyVVFNbjVWTXIz?=
 =?utf-8?B?Z1haWXloQk1Ya01IQjFQSFlkbVlNQ08rMVdjTDJYYlVNeVQzTTkzZ3RQc0NP?=
 =?utf-8?Q?cAx0duHkoGJGX3VvbikkqmYwa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fa8a0d-0f29-4740-d247-08ddd38907a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 18:59:25.0366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHoC1to//01hYPsLy4FE4BlIRaWKi4v74BbggeMdSgpDnHxeX1wXtHgv2swYw0ia
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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

On 04.08.25 19:45, Alex Deucher wrote:
> On Mon, Aug 4, 2025 at 12:00 PM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>
>> On Mon, 2025-08-04 at 11:20 -0400, Alex Deucher wrote:
>>> On Mon, Aug 4, 2025 at 9:58 AM Timur Kristóf
>>> <timur.kristof@gmail.com> wrote:
>>>>
>>>> Unlike later versions, UVD 3 has firmware validation.
>>>> For this to work, the UVD should be powered up correctly.
>>>>
>>>> When DPM is enabled and the display clock is off,
>>>> the SMU may choose a power state which doesn't power
>>>> the UVD, which can result in failure to initialize UVD.
>>>
>>> + Christian, Leo
>>>
>>> That doesn't seem right to me.  IIRC, the driver always set the UVD
>>> PLL directly on SI and I don't think SI supported any kind of UVD
>>> power gating. I guess it's probably some sort of subtle sequencing
>>> difference between radeon and amdgpu.  Unless Christian or Leo have
>>> any ideas, I think the patch is probably fine.

Oh my, that stuff was last at the front of my head a long long time ago.

>>>
>>> Alex
>>
>> Hi,
>>
>> These are my observations about how the UVD clock works on SI:
>>
>> 1. It seems that the SMC needs to know whether UVD is enabled or not,
>> and the UVD clocks are included as part of the power states. See:
>> si_convert_power_state_to_smc
>> si_convert_power_level_to_smc

Correct, yes. The design was that either the KMD or the SMC could program the PLLs.

>>
>> On SI the default power state doesn't set the UVD clocks,
>> and SI has a specific power state to be used with UVD. Actually
>> amdgpu_dpm_enable_uvd has a special case code path for SI, where it
>> sets this power state. If I print the power states from
>> si_parse_power_table, it indeed confirms that there is only one power
>> state that has non-zero UVD clocks, and the rest of them just have the
>> UVD clocks at zero.
>>
>> It's unclear to me what happens if we try to enable UVD clocks when we
>> selected a power state that doesn't include them (ie. when we don't
>> tell the SMC that UVD is active).

IIRC there were two possibilities.

Either you let the SMC handle the clocks in which case it would lower the GFX clock in favor of stable UVD clocks.

Or the KMD would lock the SMC to the highest level and then program the UVD clocks manually.

The later was not really validated but requested by a lot of people because otherwise you got a GFX performance reduction whenever you used UVD.

>>
>> 2. When setting a power state that enables UVD, the UVD clock is
>> enabled either before or after the engine clock by si_dpm. This is done
>> so in both radeon and amdgpu, see:
>> si_dpm_set_power_state
>> ni_set_uvd_clock_before_set_eng_clock
>> ni_set_uvd_clock_after_set_eng_clock
>>
>> The specific sequence in which the UVD clock is enabled by
>> si_dpm_set_power_state leads me to the conclusion that
>> amdgpu_asic_set_uvd_clocks should not be directly called on SI outside
>> of the DPM code.
>>
>> Please correct me if I misunderstood the code.

That sounds correct to me.

> 
> Yeah, I don't remember the clock dependencies.  I thought that you
> should be able to program the UVD PLLs any time you wanted and the
> ordering only mattered when you were also changing the sclk.
> Programming the PLLs directly works as is in radeon, but I guess maybe
> we init DPM in a different order in radeon vs amdgpu.
> 
> It would also probably be a good idea to disable the UVD clocks again
> after IP init to save power. E.g., something like:
> 
>        if (adev->pm.dpm_enabled)
>                amdgpu_dpm_enable_uvd(adev, false);
>        else
>                amdgpu_asic_set_uvd_clocks(adev, 0, 0);

IIRC we always disabled the PLL manually when UVD was unused because the SMC sometimes failed to do this.

Regards,
Christian.

> 
> Alex
> 
> 
>>
>> Thanks,
>> Timur
>>
>>
>>>
>>>>
>>>> Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 9 ++++++---
>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> index 5dbaebb592b3..9ad06c1e150d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> @@ -633,6 +633,12 @@ static int uvd_v3_1_hw_init(struct
>>>> amdgpu_ip_block *ip_block)
>>>>         int r;
>>>>
>>>>         uvd_v3_1_mc_resume(adev);
>>>> +       uvd_v3_1_enable_mgcg(adev, true);
>>>> +
>>>> +       if (adev->pm.dpm_enabled)
>>>> +               amdgpu_dpm_enable_uvd(adev, true);
>>>> +       else
>>>> +               amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
>>>>
>>>>         r = uvd_v3_1_fw_validate(adev);
>>>>         if (r) {
>>>> @@ -640,9 +646,6 @@ static int uvd_v3_1_hw_init(struct
>>>> amdgpu_ip_block *ip_block)
>>>>                 return r;
>>>>         }
>>>>
>>>> -       uvd_v3_1_enable_mgcg(adev, true);
>>>> -       amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
>>>> -
>>>>         uvd_v3_1_start(adev);
>>>>
>>>>         r = amdgpu_ring_test_helper(ring);
>>>> --
>>>> 2.50.1
>>>>

