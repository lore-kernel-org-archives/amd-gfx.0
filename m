Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C204C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 14:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034F110E12A;
	Mon, 14 Jul 2025 14:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mMWk/mSA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 844B610E12A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 14:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmgEVzHr72U4AIhi3hNxzJ8jCJPhT1Fj1mhyUQCERXitK0bZ0snrK886mXHNRZHLkSyHRZ8P2VJBQMvnj7G5aPwasuExNyX+wNiILjosQTaqGSsML+xCu5v/MaqtvMJQJ3zJh2cfyE9iE7xciCFAf6BsrPV+xqV3z4WldKB6YzGJEvzi1PwuoMR5uGkyusFEdbXMJhYUS5/YloHZhsj24EKv4KMKSAfJfYyqTJjsW6I37jPCV1R5dGKrX4ZJIlUT3dXNVk3xOOdAxEOqnchP6bXTgt79PZfH+uO2ZN9w9Re4mqQxqloKCVYVsprBWY1gnPIkGftRCwYKwSyr91GPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akUXCJOgS7qQBlqJvM/vMyKeIsfTzgAsF3VP2MqnGf4=;
 b=BzO7AsZAy7xSKEhFqYv7dVH2/n1zdp9aAdfART0oSID4+tMEICRUmsC89sPESMqItoTB657W+PyRXrzKTdfFcp/fO6MXO2J/43uecjJIUTJDfT7pNwIYYCCYYy1rDKQURWZ9Bo5nx94RUT3wyQ7rCR+1XqCBuocduV8UnKCeX7GfdMhi4Y4nbTmpaV2QFESnFWcKG0RrEMJ1ZHskOibNyv11SDn39PV3LYZA1ehgX9eDMXfA7u3dLrRjarpHhvBZfdWn2JEWNUEFOfr4ndzcjRKXOmt7N4mKt0Fo2D/1kKtLitwE1t6R55vryy9mV1sxuvK6ij0bGFDEqR/1tvFf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akUXCJOgS7qQBlqJvM/vMyKeIsfTzgAsF3VP2MqnGf4=;
 b=mMWk/mSA/E/eS+wKrI03vz+pWrxlkJ6tO4yOvU/Phoqc7TUb/aMp5Bqthee9O0P9hIOeNG58BME5PSXG07lYqPQhhKMRg/eOoMTFo4vYR14dKuDAiUCUodFwnTFLgcxTFKB1x3KBfMXNpM/1RQRtwolhX+uumk9fy4qLAWWnHvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 14:02:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 14:02:07 +0000
Message-ID: <e58f6312-c0c2-4d14-935e-eabaa51de923@amd.com>
Date: Mon, 14 Jul 2025 16:02:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] drm/amdgpu: track ring state associated with a fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-9-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711224024.410506-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd5ddca-f2e3-4457-b586-08ddc2df04bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2J0dUFBa0FJb0lNSXJ0ZFJGQ3FscDNxK252SXV1NTdYZkhSZTFCd0hlRmlr?=
 =?utf-8?B?eWkxY0FtTFlxU01Jd3JrTENINGh6SWFiV01lVC9vVERuWUZTN0dqYi9XOTdN?=
 =?utf-8?B?ZUpWTFk1bmhhWTl1OE9VaW5zTjVnRENZYWhrUGpjaDRvTm9zRS9SMmI3RmRY?=
 =?utf-8?B?SjFaWVZ2R3BLNjBSUXcrM0pnUFVPcHlWd0g0aStxNVhhaHArVFMrcWZhK1V2?=
 =?utf-8?B?Y1IxeTdHU0V5MmdnZTNBdnVqTzludmF2M1ZuT3F4eHp4NG0yMCt1bGdZU1BU?=
 =?utf-8?B?Tm9uQm5oeC9ESEsrTU5IRDcyOGt4cjdQRXdiQStHRkwyYnArUGpLai94NDNK?=
 =?utf-8?B?RE9PM3JRYjJ2WHB0V0NpWEpCdmN6SXdaSXVOS2N4NkNxU1VRWkRFMkQ3Y3BW?=
 =?utf-8?B?TjdzRTNJZzA1QysrV0xPaXVyMzNuNUVKcXgyWFJMUVVOY3JmdFZ1TmNkUElG?=
 =?utf-8?B?REdOZDVDdGZIdkJMcU1meGVzMHdHRmFlOS9lK2ZwY1UyY1RzdkVDRGtxL1pN?=
 =?utf-8?B?aEVWdUJjWG8wcFZvVDZuL2RjZnQyeGwvbEFIUFowbkx5WTJXV1g4TkJ2a1Rn?=
 =?utf-8?B?NmdqcWNoWGlqaENSVmdvMnpSOHZEek5ZeDRDSlRMRW5kWkM3S09WRFpObmVh?=
 =?utf-8?B?bEtucktuNlZDamc0WFUwWlRoazUzRGJBV0J5L2k4YlpxWXVVMWNTRkZHamNu?=
 =?utf-8?B?YW1HbTR5WUhmQU5OUTAyN1dWWTBxbW9kQ0FGNjZhMEF1d25iNmtVT3ovWDFP?=
 =?utf-8?B?cXRZRC9VT0Jzd0VsUEFRSnJ2LzhaRTBqMElMZ1l5Yk1ZRlVLdXNkRHZHak5z?=
 =?utf-8?B?eVhzbDZVS2o4WEZXWVZENllrQU80Sm1Qd2Q4aFhzaXYxakIzTjlHVE1iaTZQ?=
 =?utf-8?B?ZEdjb0xSRExuUjNxQ09YS1NkNEFPNHMvNlNHTUlOQkV3ZFR2WG9ISFF2VU4w?=
 =?utf-8?B?WXg1ZllyRGVNTkRaQmM0LzVHaUhyZUc5czZ2WHRMZ011Z2o2eFpWZkVNa0hZ?=
 =?utf-8?B?bmxiRHRlZlZUUkhlWG5zZ2F4a0IxS2ErZzVRUldCNlVxUHQyYk84LzVGRk42?=
 =?utf-8?B?Q0p1VithQURuNFAveUtCaC9tcDgvQXNLVU5MTlEwQko3ZDJkeUliZEpWTnRB?=
 =?utf-8?B?Yis2WjB3WHl3UVJSczBDd2pudHgxZTRPTHhGSU5Mc3RqUEEreW9MK2VzTHBz?=
 =?utf-8?B?M1dZVnduVXI0YU5LekpkY2o2WnlrSHR0NDg0M2w3UGUrR28yQk5lSkJ1aHht?=
 =?utf-8?B?THZtMXNmMEk2bW9RQWRTUzQ3eXRrdjUrZjA4bkorTTVneVRBeTBUL2dEWm9H?=
 =?utf-8?B?bUdESXVMSTdabU42UnB6TnFuZm0yL2IrZTQwbStWRWFuMUU2aU5kVTBjNFBX?=
 =?utf-8?B?c2FIOGt0VEkyRXREZTZIeDlFcEFwZmRSWjZBdDVaaU1YT3ZFcFE0L0JxR0ky?=
 =?utf-8?B?YndOd1JoY01nK3VrRUlSMDJoUm5XamltR1VJR0FmaTVqTGVtMGk4TkxmRFIw?=
 =?utf-8?B?dGw2ai95UlRxVzhSdEZKeTNmbUMzYkliSllvVitweVUxM1E3b1VPL3piYjRn?=
 =?utf-8?B?UDFLdlBRaFBxdjV1cHF0R2FOWXBEOHdCOU5ZRXJUdkFjZDZDSW1RNE5RZ1V2?=
 =?utf-8?B?YjkySU42NnYwYzZHMGpKL0F4QmxrenRjT0U4aVE1WlF6dU1zdGluTE1qSVZE?=
 =?utf-8?B?a2R5aXI5S0RpaU1qUitpamRaVUxjWVkxbjNMZFB5Y00yT0tKY0ZJKzhCMEpk?=
 =?utf-8?B?K1ZMakplS3NFTFJCUHowNFcyYzVYWVUwL2xrdDlrQVIwT1VRWmNPZ09aUVlV?=
 =?utf-8?B?Q1NuRzFOVGNEa3FVNXZTYnNPa3ZGdFJsb2Z1VXJBeE03Rkd3QytFTDlVaCtV?=
 =?utf-8?B?Mk12VnZ5ZWdqNGZjc0ErWnozbE56SUZseXZuMmJ1aHpha0xra09BR0xkMk1t?=
 =?utf-8?Q?79vCnD11Ja8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDMvV3BqdzBHekpyWTZKR1NQSnpDRWFDdm5mbWQ4U0hyQ2dUWTVVbzBtQ2VJ?=
 =?utf-8?B?K1FYUTlkV2d3S2RiT0lzMExoOFBaYzRWdDR5NmpEN0lJMXd5bERremZxRlJz?=
 =?utf-8?B?T21GaGVDUkhaSmxJRFlVb2pqNWNkL0xUbk81UytEMFVtMDJvdTVKMXg3cTVy?=
 =?utf-8?B?d3gwZWtEU3VkN1dMRGduM3ZuY2ZxTkRrWCtEd2FLRXc4Y1QyeEtXanhjWVk2?=
 =?utf-8?B?cnhLblF3aEhqWlFPKy9hTEtaaytvcnBtM3FkOW0yU3MyazF5R1Q0d3hpQzlI?=
 =?utf-8?B?RjNib2NGZWhuL1VqNDJnWXd2UkR5NUJtMEpTdlVLRjZIQjg2R3g2UE1vank1?=
 =?utf-8?B?c01hSlV1MTdXaEFzaUFSckxJM3pNcElabDFZZUl6RTNoUVgweURrNFFIQ1Bn?=
 =?utf-8?B?RGtJdFN6QkJpTGpqMVhiT2gxQjNEQUZwU2cwZmZMaXQvV20rY05odXFZTzdO?=
 =?utf-8?B?K3BuTm8rd2tmazI4K2k2MGlsMzJjY0E3aFRSZnV2Ui9neldLdktzeXo2OXQ3?=
 =?utf-8?B?OHhkSUlPd2dyR1ozNVNSR2pvMXNFVXBtWGhYVGdKY1ZLVUxNOGF5Rk44SFBD?=
 =?utf-8?B?S05VbXRWYlAwTjM1V2ZzTWhzbStTVTNqNVEwVTRkRUs2ZVVXSlZKWGs0Rnhl?=
 =?utf-8?B?RmlsR2E1TzlaVld4SzYxMXZGT3lMU3VUSTArc2VZR3hrUjVMbXV2K0N0ckh5?=
 =?utf-8?B?WFpMUElKa01MdDBOaVptc1ppbUpHTEo2ZHNWa00wa2t2NStsMXhscjNDMHY0?=
 =?utf-8?B?RjJqYmwyMW5mSVZVWE54dVg3a0pvaW5XNFZ0dklCeGU1S1VWbERpaHo3Q2Yr?=
 =?utf-8?B?cnRrR2NLU2RiWTNUeFlEVTdqK096cm95bi9UZ3hMRTRNR2dPZGgzSUZGREtY?=
 =?utf-8?B?MkRwMlZkYkJQTEVPTGdRUlNpM0xtbEFJdTFpbjVKME4wZHBpK3ZGRzVIUVhy?=
 =?utf-8?B?V2lsU0FXZExkR2k3UVlzSTR2ZUxsb0FLQUJDUEhGMDBnMEphK0Z6NEgzdmpS?=
 =?utf-8?B?ZzVzZWZYTXcvYUN6WXBKTTVnNWVRRGhOSmkyYWNFZEhjYlRRcUdEN2RCbEV0?=
 =?utf-8?B?M3JDR1JVdVF3aW02RHZjd3BURXI5QkxHbnAvTFpwQ1BMS2VWb3o1bGlnKzJZ?=
 =?utf-8?B?eWgzUjY0U1kraE13K21MNVJHYitRNHRZM1o5RDRVeFVGcG9LVlpBcjlNL1N4?=
 =?utf-8?B?alZ1L3VST0xNb0xCTldVSVVMQTBEZEZUUWFsaTNZTFpJNTB3L0NjcGJ2T1R4?=
 =?utf-8?B?Y1JXdWZJTTlOeFlmTE1weDM3QzdZV2tQY2FPaFRVRVI1K2hDYVArT2oyV3Fw?=
 =?utf-8?B?UXA4TnJmT1U4dFBMdVZNYnFzT0xvcmtyaGlMa2l6SkhZTi94U2RmVEtnWkhK?=
 =?utf-8?B?QnVTekx2dEpwS1hoRWU0RjRnQVFsSmd6anVQZHJKWThzOHN3MGlJakttQ3l1?=
 =?utf-8?B?YlFxZGFUVjJ2TGYzUGFqRjB1L1UremFEYS85RVJLUHNBWWlIYjdCUHg5enFa?=
 =?utf-8?B?SW9yUkt5MW5IK0xmUGZxNHowbEhlWmdtWk1xSnlvdDZmY00zaXZKNTF5czhU?=
 =?utf-8?B?RlFJbTJtWnlGdUF6RGx3TWxBUjBVS0VvRTdkRTc1MFpnRVptN3RRQk5qVlBQ?=
 =?utf-8?B?NjJpYUVuTTJDL3NHeEJlb1c4VGJuQ21TSFZRMURBaTd5eXBNYW1HUThMVjNz?=
 =?utf-8?B?dWRSZXRJeFlwem1CM3BMN05xMnZ3Q1VZSDRxMjd1cW5Cb1NHTklWeEdrRjVx?=
 =?utf-8?B?aWgyOE0xYzdMMWhLY3NrakdzTERmS1FlblVnN0V3QW0rMnNpY2NjKzNGRlE1?=
 =?utf-8?B?RFU1RUhSclk0Tjk5d3JORU9IbW9wWUR5ZGhkMlJEYTdGbWU3WmM5eGh2YzZS?=
 =?utf-8?B?MzBWeUdpV0NidVJjMThBQVNuUGkzaFNyellSTlUyMWw0SXh2dEEwaTdlbGN6?=
 =?utf-8?B?NUptRHE2Y1BNYVVxWGJXL1pmOXdxM24wN3VlLzdaV3hSL0xTWG1MRzQ2SWNK?=
 =?utf-8?B?TU9QVDJpbUw4Tm1HN3NFMXFFN0lzSHZ3M0FTUFF0YUlWQXVNUHErSlJwWlEr?=
 =?utf-8?B?MzMrTklaWTc2N1JLdTNUcVA2c0VRYm1pQjNZVnZCdTAwdFF2bkZUT3lKLzN3?=
 =?utf-8?Q?RwMdTuqFLnGNMg22z00GREmXw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd5ddca-f2e3-4457-b586-08ddc2df04bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:02:07.3705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3m1WbbFiQcw6TqXGOHBrgwgwlAXE/qW45jZOGbET8HyXxANlL0i4MPHP5nucFq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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

On 12.07.25 00:39, Alex Deucher wrote:
> We need to know the wptr and sequence number associated
> with a fence so that we can re-emit the unprocessed state
> after a ring reset.  Pre-allocate storage space for
> the ring buffer contents and add helpers to save off
> and re-emit the unprocessed state so that it can be
> re-emitted after the queue is reset.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This clearly needs a follow up cleanup, but Reviewed-by: Christian König <christian.koenig@amd.com> for now.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 90 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 15 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 67 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 18 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +
>  6 files changed, 195 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2d6b2b486baf7..3f2080aecd5a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -120,6 +120,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>  		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
>  		if (!am_fence)
>  			return -ENOMEM;
> +		am_fence->context = 0;
>  	} else {
>  		am_fence = af;
>  	}
> @@ -127,6 +128,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>  	am_fence->ring = ring;
>  
>  	seq = ++ring->fence_drv.sync_seq;
> +	am_fence->seq = seq;
>  	if (af) {
>  		dma_fence_init(fence, &amdgpu_job_fence_ops,
>  			       &ring->fence_drv.lock,
> @@ -141,6 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>  
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>  			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> +	amdgpu_fence_save_wptr(fence);
>  	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>  	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>  	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -253,6 +256,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  
>  	do {
>  		struct dma_fence *fence, **ptr;
> +		struct amdgpu_fence *am_fence;
>  
>  		++last_seq;
>  		last_seq &= drv->num_fences_mask;
> @@ -265,6 +269,12 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  		if (!fence)
>  			continue;
>  
> +		/* Save the wptr in the fence driver so we know what the last processed
> +		 * wptr was.  This is required for re-emitting the ring state for
> +		 * queues that are reset but are not guilty and thus have no guilty fence.
> +		 */
> +		am_fence = container_of(fence, struct amdgpu_fence, base);
> +		drv->signalled_wptr = am_fence->wptr;
>  		dma_fence_signal(fence);
>  		dma_fence_put(fence);
>  		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -727,6 +737,86 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>  	amdgpu_fence_process(ring);
>  }
>  
> +
> +/**
> + * Kernel queue reset handling
> + *
> + * The driver can reset individual queues for most engines, but those queues
> + * may contain work from multiple contexts.  Resetting the queue will reset
> + * lose all of that state.  In order to minimize the collateral damage, the
> + * driver will save the ring contents which are not associated with the guilty
> + * context prior to resetting the queue.  After resetting the queue the queue
> + * contents from the other contexts is re-emitted to the rings so that it can
> + * be processed by the engine.  To handle this, we save the queue's write
> + * pointer (wptr) in the fences associated with each context.  If we get a
> + * queue timeout, we can then use the wptrs from the fences to determine
> + * which data needs to be saved out of the queue's ring buffer.
> + */
> +
> +/**
> + * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
> + *
> + * @fence: fence of the ring to signal
> + *
> + */
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
> +{
> +	dma_fence_set_error(&fence->base, -ETIME);
> +	amdgpu_fence_write(fence->ring, fence->seq);
> +	amdgpu_fence_process(fence->ring);
> +}
> +
> +void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +{
> +	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
> +
> +	am_fence->wptr = am_fence->ring->wptr;
> +}
> +
> +static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
> +						   u64 start_wptr, u32 end_wptr)
> +{
> +	unsigned int first_idx = start_wptr & ring->buf_mask;
> +	unsigned int last_idx = end_wptr & ring->buf_mask;
> +	unsigned int i;
> +
> +	/* Backup the contents of the ring buffer. */
> +	for (i = first_idx; i != last_idx; ++i, i &= ring->buf_mask)
> +		ring->ring_backup[ring->ring_backup_entries_to_copy++] = ring->ring[i];
> +}
> +
> +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> +					     struct amdgpu_fence *guilty_fence)
> +{
> +	struct dma_fence *unprocessed;
> +	struct dma_fence __rcu **ptr;
> +	struct amdgpu_fence *fence;
> +	u64 wptr, i, seqno;
> +
> +	seqno = amdgpu_fence_read(ring);
> +	wptr = ring->fence_drv.signalled_wptr;
> +	ring->ring_backup_entries_to_copy = 0;
> +
> +	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
> +		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
> +		rcu_read_lock();
> +		unprocessed = rcu_dereference(*ptr);
> +
> +		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
> +			fence = container_of(unprocessed, struct amdgpu_fence, base);
> +
> +			/* save everything if the ring is not guilty, otherwise
> +			 * just save the content from other contexts.
> +			 */
> +			if (!guilty_fence || (fence->context != guilty_fence->context))
> +				amdgpu_ring_backup_unprocessed_command(ring, wptr,
> +								       fence->wptr);
> +			wptr = fence->wptr;
> +		}
> +		rcu_read_unlock();
> +	}
> +}
> +
>  /*
>   * Common fence implementation
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 206b70acb29a0..7d9bcb72e8dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -139,7 +139,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	int vmid = AMDGPU_JOB_GET_VMID(job);
>  	bool need_pipe_sync = false;
>  	unsigned int cond_exec;
> -
>  	unsigned int i;
>  	int r = 0;
>  
> @@ -156,6 +155,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		gds_va = job->gds_va;
>  		init_shadow = job->init_shadow;
>  		af = &job->hw_fence;
> +		/* Save the context of the job for reset handling.
> +		 * The driver needs this so it can skip the ring
> +		 * contents for guilty contexts.
> +		 */
> +		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>  	} else {
>  		vm = NULL;
>  		fence_ctx = 0;
> @@ -307,8 +311,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>  		ring->funcs->emit_wave_limit(ring, false);
>  
> +	/* Save the wptr associated with this fence.
> +	 * This must be last for resets to work properly
> +	 * as we need to save the wptr associated with this
> +	 * fence so we know what rings contents to backup
> +	 * after we reset the queue.
> +	 */
> +	amdgpu_fence_save_wptr(*f);
> +
>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index f0b7080dccb8d..45febdc2f3493 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -89,8 +89,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  {
>  	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
> -	struct amdgpu_task_info *ti;
>  	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_task_info *ti;
>  	int idx, r;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> @@ -135,7 +135,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
> -		r = amdgpu_ring_reset(ring, job->vmid, NULL);
> +		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
>  		if (!r) {
>  			atomic_inc(&ring->adev->gpu_reset_counter);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 426834806fbf2..09d7681b7a754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -99,6 +99,29 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>  	return 0;
>  }
>  
> +/**
> + * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for reemit
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ndw: number of dwords to allocate in the ring buffer
> + *
> + * Allocate @ndw dwords in the ring buffer (all asics).
> + * doesn't check the max_dw limit as we may be reemitting
> + * several submissions.
> + */
> +static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
> +{
> +	/* Align requested size with padding so unlock_commit can
> +	 * pad safely */
> +	ndw = (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
> +
> +	ring->count_dw = ndw;
> +	ring->wptr_old = ring->wptr;
> +
> +	if (ring->funcs->begin_use)
> +		ring->funcs->begin_use(ring);
> +}
> +
>  /** amdgpu_ring_insert_nop - insert NOP packets
>   *
>   * @ring: amdgpu_ring structure holding ring information
> @@ -333,6 +356,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	/*  Initialize cached_rptr to 0 */
>  	ring->cached_rptr = 0;
>  
> +	if (!ring->ring_backup) {
> +		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
> +		if (!ring->ring_backup)
> +			return -ENOMEM;
> +	}
> +
>  	/* Allocate ring buffer */
>  	if (ring->ring_obj == NULL) {
>  		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
> @@ -342,6 +371,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  					    (void **)&ring->ring);
>  		if (r) {
>  			dev_err(adev->dev, "(%d) ring create failed\n", r);
> +			kvfree(ring->ring_backup);
>  			return r;
>  		}
>  		amdgpu_ring_clear_ring(ring);
> @@ -385,6 +415,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  	amdgpu_bo_free_kernel(&ring->ring_obj,
>  			      &ring->gpu_addr,
>  			      (void **)&ring->ring);
> +	kvfree(ring->ring_backup);
> +	ring->ring_backup = NULL;
>  
>  	dma_fence_put(ring->vmid_wait);
>  	ring->vmid_wait = NULL;
> @@ -753,3 +785,38 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>  
>  	return true;
>  }
> +
> +void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> +				    struct amdgpu_fence *guilty_fence)
> +{
> +	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
> +	drm_sched_wqueue_stop(&ring->sched);
> +	/* back up the non-guilty commands */
> +	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> +}
> +
> +int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> +				 struct amdgpu_fence *guilty_fence)
> +{
> +	unsigned int i;
> +	int r;
> +
> +	/* verify that the ring is functional */
> +	r = amdgpu_ring_test_ring(ring);
> +	if (r)
> +		return r;
> +
> +	/* signal the fence of the bad job */
> +	if (guilty_fence)
> +		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
> +	/* Re-emit the non-guilty commands */
> +	if (ring->ring_backup_entries_to_copy) {
> +		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
> +		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
> +			amdgpu_ring_write(ring, ring->ring_backup[i]);
> +		amdgpu_ring_commit(ring);
> +	}
> +	/* Start the scheduler again */
> +	drm_sched_wqueue_start(&ring->sched);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 784ba2ec354c7..309e7bb6001bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
>  	/* sync_seq is protected by ring emission lock */
>  	uint32_t			sync_seq;
>  	atomic_t			last_seq;
> +	u64				signalled_wptr;
>  	bool				initialized;
>  	struct amdgpu_irq_src		*irq_src;
>  	unsigned			irq_type;
> @@ -141,6 +142,12 @@ struct amdgpu_fence {
>  	/* RB, DMA, etc. */
>  	struct amdgpu_ring		*ring;
>  	ktime_t				start_timestamp;
> +
> +	/* wptr for the fence for resets */
> +	u64				wptr;
> +	/* fence context for resets */
> +	u64				context;
> +	uint32_t			seq;
>  };
>  
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> @@ -148,6 +155,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
> +void amdgpu_fence_save_wptr(struct dma_fence *fence);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -284,6 +293,9 @@ struct amdgpu_ring {
>  
>  	struct amdgpu_bo	*ring_obj;
>  	uint32_t		*ring;
> +	/* backups for resets */
> +	uint32_t		*ring_backup;
> +	unsigned int		ring_backup_entries_to_copy;
>  	unsigned		rptr_offs;
>  	u64			rptr_gpu_addr;
>  	volatile u32		*rptr_cpu_addr;
> @@ -550,4 +562,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> +					     struct amdgpu_fence *guilty_fence);
> +void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> +				    struct amdgpu_fence *guilty_fence);
> +int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> +				 struct amdgpu_fence *guilty_fence);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f042372d9f2e6..ea9b0f050f799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -765,6 +765,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	bool cleaner_shader_needed = false;
>  	bool pasid_mapping_needed = false;
>  	struct dma_fence *fence = NULL;
> +	struct amdgpu_fence *af;
>  	unsigned int patch;
>  	int r;
>  
> @@ -830,6 +831,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>  		if (r)
>  			return r;
> +		/* this is part of the job's context */
> +		af = container_of(fence, struct amdgpu_fence, base);
> +		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>  	}
>  
>  	if (vm_flush_needed) {

