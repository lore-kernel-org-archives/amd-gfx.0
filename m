Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E413EA4FD8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 15:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD7110E3C9;
	Mon, 23 Feb 2026 15:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vMCcJ7au";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF86610E3C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 15:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7s2nCUy8o+9hzr6FqJ7NbDGoY+sWNE7mV02+gsPTUPkmB24nfCYzd5xIKUlCg9zKvAT+bPPDybmRtw1lHdJuLXQWk2o273BagNNil3OHpJazEsxFgMKlD++3JEe0R7e+c3cKTphfb40NeGzn4SOkbj10fk6h6tGAe5uoPpNHXSQQY+IOv5nmIXqEvTZhyBXovEYLhjpcGL16HV6XaTI145hRFOaCjE9HcIHnbf1XTABp4foukWGM8FCdBPRAf5f0ufYYX850WM5NQsbG5Yht8FWjo7YwOrUZvU1/3WmkxSq+KZE/KT+INsUWgDx0BaEn70gew5nPA5Cs/q2CVNVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/WbWWUruwtnQb8jM8R4opAeLdRh/b1Bkl+m7aoZyfc=;
 b=l6ulSuLaP3Psy/7GxKVvRIFKeKxTgQSU4YYxeb2KNjIae2nyVzusXsvZYwCioGKZnd8uTvsRpRBPsK0fPPjRPLYYmbHfxUq8usvf4IqRWdmfBuQuk1XPBXDptqISKVBEUEsdy+S4Pt14wtC4NCU3eNGBMTHMdmP5dxT3a3gi5wApGNbuddC1zbraSOTzchEDvOLiT0uSfhzAHeHqJtMx2KaLU5Gb5ulmTLsHoFAE+YDHtJyVZJVRekAaneQ4sfhVaE56/OP/f5cLo8xV+uSKeipvfcNMEOIUZVrwsmCx2uKnPyeulT1+4ieoH9zJsyWZGFw4rACuWtjl/n9sURyTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/WbWWUruwtnQb8jM8R4opAeLdRh/b1Bkl+m7aoZyfc=;
 b=vMCcJ7autmiUAgHzpkl89WjkEIbMaVEqWo3+l4EbTRi676qcOsjzx7kWr6FMW6v1ECyMz0RHlKbXRHCfswJ9Z/FgIMsPQY9O81VMvDNnOdx5u3dwLxe2g7IkVNDDh9acnQW4DaznOVo4emL5sluEuCpUrqxcQJeQtSjvu8ljHs8=
Received: from BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 15:28:07 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::cf) by BL0PR02CA0049.outlook.office365.com
 (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 15:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 15:28:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 09:28:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 07:28:05 -0800
Received: from [10.254.94.150] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Feb 2026 09:28:04 -0600
Message-ID: <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
Date: Mon, 23 Feb 2026 10:27:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>, <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <rodrigo.siqueira@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 3665399c-4600-454d-fc43-08de72f0242f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|82310400026|36860700013|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWMrVHlOSlVmMjJpQUJueGpuS3F5aEY3M3JVRHhVQ01PSlRRaTc3MU40Ykhw?=
 =?utf-8?B?ZHFBaWdIWXZNclo1Y3NVdVFHYjY2elprQmxGK2Nucm5JbWhibzN4K0tjZVg0?=
 =?utf-8?B?TlBVOWZiVDdyVFJxTWpmSDQ1VmsvSjQwQWdTSW56LzYxaWxDOW4ySi9LU3Rl?=
 =?utf-8?B?ZExyUVdNQ1JhK2o3M0REai93dDVmak82RDdqTzVJRXk2Ni90bnh1TCtMSGRl?=
 =?utf-8?B?cERUQ0tEM016MElHVFBLYWNqaTZnb0F5UDNON3dUSkRPNVB0b1B4VCtPYzJK?=
 =?utf-8?B?bzJvVEV4OUpqaDdjY0Z2eWZiR2hJd2FicFYvQnlXc21uU2RiaHBNUW9jUktj?=
 =?utf-8?B?NmMyUmNzM3A5eE4yaGFIdHoxQmZxQW5ZdVZDV0FFRGh5QmtXRklUeFh5bWV5?=
 =?utf-8?B?YmEwaGsrSGE2bWxxQ0sxQiszempoUENCQ0lnbjVmTFlCd0ZaSll0RmJ0Sldn?=
 =?utf-8?B?b0Zsbk9XdDZMMTNmWHJjZEs1cGRtWWkyR0lURUVDcVZ1dElVN1pjNVJCQS9m?=
 =?utf-8?B?MkZNOEZtS0V2bjlGYkRTWm01R1d3ZzRHRE1scm5MakJvVmd2UUN1RUtyei9L?=
 =?utf-8?B?NW1MNEF4VEZNc0lpbTlKQWszTGU4bnVGS1pSbmZVN0IxRlpnWFVJcC90b3Ax?=
 =?utf-8?B?dFJWQTZhUTVLN0IzMTlRTDlkdCtTMnZRSmt4RWltOURtb0dVeEw0SUdReHg4?=
 =?utf-8?B?ZG9iOGU5TmtGMDFoMTVNR3ZuS2FCRGcwQ3NBd2RhdFl4M2NZT1p3NDNiNmJq?=
 =?utf-8?B?QUMzSjh3RmJSL3NKS2VJeGZ2RmhSVVlIcXNLVUdaZ3ZIZGZ3eTRSUkwyV1dk?=
 =?utf-8?B?NWU4Y0RaSllOVlNKZld4U0ZKelNzTnJLdzRWUHRtTXZ3bmlRMDhDTEpkK1JN?=
 =?utf-8?B?R2kvMHJac1V3RkNwQnBVRkFraVhvWWpxUFNwbWRSaWd0WlNaSFFlbG0wTW1k?=
 =?utf-8?B?TEZ4My9XWU9Rd29NTFpqSEFnSWw5SUMxZlhya3dvMFBMaENzRzl4VXVIejZX?=
 =?utf-8?B?Q2tkQnlqdmF5QlFJUjBhYWNjTEI3eDljTUVWVThibTcrbGhLNHkrWHBTb2Fr?=
 =?utf-8?B?MldldmJxb2xEQXJ4YzVQYlRjMjZUQTJhWFg2SmFaYk42ZkF0R2cvTUl1eUtC?=
 =?utf-8?B?elhSSlpibVB3N0l5ZnZiU3FMSlZCT0Z6UzJHTW53MHZicWROUFFQaXRVM1V5?=
 =?utf-8?B?d0ZEZmMrdFJnYi9kQ1J4cU9hdno5WHVxdkRNRTZ3WnhiS3E5ZTFaczA0M0Jp?=
 =?utf-8?B?bVlrTTdSTjMzdjdHOVJ2V2RrZDBJTmFmUnFJb2dLQ2xvUXNiZGJPUThUemcy?=
 =?utf-8?B?WEhjYmd5cjIzdDZEYmRJSGIxQkNkRUF4V3FBYTBmRDNZaENhMGp2c1BnWjgr?=
 =?utf-8?B?WnJ3blo2RW4zOGluaVZCMkJHYzBlMkE5ODBkNlgrNVNyVXlZR0RuQ1FYZjFk?=
 =?utf-8?B?cU85UDFDaEFINzJwdHR3T1BSeWJiR3hnMEd6TDU2c2twbWxqTlZkQVJwSjFu?=
 =?utf-8?B?Wm9CRjNUZnlrSXdpSWtvSVlFT25ZMmRUQlh6eUFmVHhLakFDdS9PWDkyN2tX?=
 =?utf-8?B?MHNGalNMZnF5YnUzcVpqNGhlTW55d3FIWUFrbm1LV2l1eFExdVdpNUlqVU55?=
 =?utf-8?B?QkpNY1Z2eFF1alk1dEZKL09wcmh0Y2tBdS9xa2tlekIrMlkyNE5SZlBEWDN0?=
 =?utf-8?B?Q1RQUXNhQUFjbTI1eFZpQVJaNTNtTWYyS3BRZkk5OHdyc1JtUG1TbzVmcEI4?=
 =?utf-8?B?OGFxZ1RuOEljZkl1QlF4bXBFYTBma0JRelpLaW5UVmRJSkM2c3dXZWZHdTB4?=
 =?utf-8?B?bDRVNUozQWRTYkxLNGI0NWZ3SGJVUWZPS3pYSXJjQWZLOTJKczNKL29EQXFu?=
 =?utf-8?B?NmZMaWJ2Q1RlSisxR2dDWjg5Q01XWThkeFJ4REk0NFVTOStCOEFoVEh4Wksr?=
 =?utf-8?B?WkFKSnhOWnVRVEJOSDFMK2RDNmI5ekEwUml4aFNzekNVK0d3WFRqcW5STHFy?=
 =?utf-8?B?a3ZWSHNETGZLeGJWYzAxRXg5UDBMbzJBODNpMUxLc1Fwb2pMREJYeHEvUFNR?=
 =?utf-8?B?eFJjTHFGYm1tZEhRM0dKYXVTNGlHd20yN1RTbkdpT1JwSEJxTWtyeHRqNUdO?=
 =?utf-8?B?Q3haUzVYWVNsYjRPVzVVb0NmSEkwcnkzSUc1RmV2Sk9PRVlJTStwajFvRno4?=
 =?utf-8?B?MkE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(82310400026)(36860700013)(376014)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Zw9Kkb3xHl+i4z6sqMw+maQhtppUnrPcjvoOSJNOdmbiX7ZzeoS5ZVGpZIHWgWeewu5srvVkwAKnP68HIXLCVfY/FVINkls7fnvUS0dK8qt2GdRI+epNU07iDFK3N/7Paq17p1d4cM6P0BN8XY94r3Ioevb6Cz7eamYFTPB3yeGEDSg7YmeLiXimkb2iSZO0ugVU3PthPw2FQhl0lkj+bwE7UjW3N/Ay3lSquniKOlwMl46UlAYnjuKIcQ8eWwoUe6QT2JP1E/htAuy+syN98q34FoJlmSgzfHG6PSfnnUIZ/77gu34QF8O9Qkken4gYUDj91oDK8tyI2Fhr3HrORLWP8H3dZu5L2aLDR0KHAwabaHWTXpXSRYTd7+HHgKHGdFnQFgEJggszStOGcVdsJd7obhyd2ibPBx5SlhU35jmh05RAQHth+WgrML5T6x5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 15:28:05.7603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3665399c-4600-454d-fc43-08de72f0242f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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



On 2026-02-17 14:16, Michele Palazzi wrote:
> Intermittent flip_done timeouts have been observed on AMD GPUs
> since kernel 6.12.
> 
> Analysis with bpftrace reveals that amdgpu_dm_crtc_handle_vblank() can
> incorrectly consume events meant for plane flips during cursor-only
> updates. This happens because cursor commits defer event delivery to
> the vblank handler, which checks (pflip_status != SUBMITTED). Since
> AMDGPU_FLIP_NONE also matches this, cursor events can "steal" the
> event slot for subsequent plane flips, leading to timeouts.
> 
> The potential for a race was present since commit 473683a03495
> ("drm/amd/display: Create a file dedicated for CRTC"), then
> commit 58a261bfc967 ("drm/amd/display: use a more lax vblank enable
> policy for older ASICs") made it happen by reducing vblank
> off-delay and making disables happen much more frequently
> between commits.
> 
> Fix this by sending cursor-only vblank events immediately in
> amdgpu_dm_commit_planes(). Since cursor updates are committed to
> hardware immediately, deferring the event is unnecessary and
> creates race windows for event stealing or starvation if vblank
> is disabled before the handler runs.
> 
> Tested on DCN 2.1, 3.2, and 3.5.
> 
> Fixes: 58a261bfc967 ("drm/amd/display: use a more lax vblank enable policy for older ASICs")
> Signed-off-by: Michele Palazzi <sysdadmin@m1k.cloud>
> ---
> I've been chasing intermittent flip_done timeouts on AMD GPUs (7900 GRE first, 9070 XT now)
> since kernel 6.12. The hang occurs during normal desktop usage but is much easier to
> trigger under specific conditions involving cursor movements and plane updates.
> 
> Partially tracked in https://gitlab.freedesktop.org/drm/amd/-/issues/3787
> 
> Hardware: Ryzen 7 7800X3D, Radeon RX 9070 XT
> Dual DP monitors, 2560x1440, 144Hz
> Desktop: KDE Plasma Wayland
> 
> The hang was initially observed while using Cisco Webex
> (XDG_SESSION_TYPE=x11 /opt/Webex/bin/CiscoCollabHost %U), start a meeting
> and screen share a window running Omnissa Horizon client. Then move the cursor
> around between the two monitors and the shared window.
> Under these conditions the hang usually occurs within a few hours.
> 
> Enabling drm.debug masks the issue entirely, the overhead
> changes timing enough to close the race window.
> So i added debug printks to amdgpu_dm.c and used a small bpftrace script to log the
> pageflip lifecycle with per-thread tracking to debug.
> 
> bpftrace script:
> 
>   config = { missing_probes = "warn" }
>   BEGIN { printf("=== flip_done tracer started ===\n"); }
>   kprobe:drm_crtc_vblank_on_config       { printf("%lu drm_crtc_vblank_on_config\n", nsecs/1000000); }
>   kprobe:drm_vblank_disable_and_save     { printf("%lu drm_vblank_disable_and_save\n", nsecs/1000000); }
>   kprobe:dm_pflip_high_irq               { printf("%lu dm_pflip_high_irq\n", nsecs/1000000); }
>   kprobe:drm_crtc_send_vblank_event      { printf("%lu drm_crtc_send_vblank_event\n", nsecs/1000000); }
>   kprobe:drm_vblank_put                  { printf("%lu drm_vblank_put\n", nsecs/1000000); }
>   kprobe:drm_atomic_helper_commit_hw_done { printf("%lu drm_atomic_helper_commit_hw_done\n", nsecs/1000000); }
>   kprobe:manage_dm_interrupts            { printf("%lu manage_dm_interrupts\n", nsecs/1000000); }
>   kprobe:drm_atomic_helper_wait_for_flip_done {
>       @wait_start[tid] = nsecs;
>       printf("%lu drm_atomic_helper_wait_for_flip_done ENTER [tid=%d]\n", nsecs/1000000, tid);
>   }
>   kretprobe:drm_atomic_helper_wait_for_flip_done {
>       $start = @wait_start[tid];
>       $ms = $start > 0 ? (nsecs - $start) / 1000000 : 0;
>       if ($ms > 100) {
>           printf("%lu drm_atomic_helper_wait_for_flip_done TIMEOUT waited %lums [tid=%d]\n",
>                  nsecs/1000000, $ms, tid);
>       } else {
>           printf("%lu drm_atomic_helper_wait_for_flip_done EXIT %lums [tid=%d]\n",
>                  nsecs/1000000, $ms, tid);
>       }
>       delete(@wait_start[tid]);
>   }
>   interval:s:60 { printf("%lu HEARTBEAT\n", nsecs/1000000); }
>   END { printf("=== stopped ===\n"); clear(@wait_start); }
> 
> The timeout was captured at 17:35:41 CET. The trace timestamps
> match dmesg exactly (9942110ms = dmesg 9942.110s).
> 
> dmesg output from the timeout:
> 
>   [ 9942.110360] [FLIP_DEBUG] wait_for_flip_done took 10329ms!
>   [ 9942.110380] [FLIP_DEBUG]  crtc:0 pflip_status=0 event=00000000a0636a23
>                   vbl_enabled=1 vbl_refcount=1 vbl_count=1428659
>                   disable_immediate=0 active_planes=1
> 
> pflip_status=0 (AMDGPU_FLIP_NONE) but event is still non-NULL. The flip was never completed
> but the status was already reset to NONE. vblank was enabled, refcount was held, so vblank
> IRQs were firing throughout the wait.
> 
> The bpftrace captured the exact sequence leading up to the hang. Here's the critical
> timeline at ~17:35:31 (9931771), about 10 seconds before the timeout fired:
> 
>   9931755 drm_atomic_helper_commit_hw_done
>   9931755 drm_atomic_helper_wait_for_flip_done ENTER [tid=35929]
>   9931756 dm_pflip_high_irq                           <- normal plane flip, last good one
>   9931756 drm_crtc_send_vblank_event
>   9931756 drm_vblank_put
>   9931756 drm_atomic_helper_wait_for_flip_done EXIT 1ms [tid=35929]
>   9931771 drm_vblank_disable_and_save                 <- vblank timer fires
>   9931771 drm_crtc_send_vblank_event                  <- event sent WITHOUT dm_pflip_high_irq
>   9931771 drm_vblank_put
>   9931771 drm_atomic_helper_commit_hw_done
>   9931771 drm_atomic_helper_wait_for_flip_done ENTER [tid=35929]
>   9931771 drm_atomic_helper_wait_for_flip_done EXIT 0ms [tid=35929]  <- instant, already done
>   9931773 drm_atomic_helper_commit_hw_done
>   9931773 drm_atomic_helper_wait_for_flip_done ENTER [tid=36929]     <- new commit
>   9931777 dm_pflip_high_irq                           <- pflip fires, completes the wrong one
>   9931777 drm_crtc_send_vblank_event
>   9931777 drm_vblank_put
>   9931777 drm_atomic_helper_wait_for_flip_done EXIT 3ms [tid=36929]
>   9931781 drm_atomic_helper_commit_hw_done
>   9931781 drm_atomic_helper_wait_for_flip_done ENTER [tid=36929]     <- THIS ONE HANGS
>   ... 10328ms of silence ...
>   9942110 drm_atomic_helper_wait_for_flip_done TIMEOUT waited 10328ms [tid=36929]
> 
> The drm_crtc_send_vblank_event at 9931771 fires without dm_pflip_high_irq. This is
> amdgpu_dm_crtc_handle_vblank() sending a cursor-only event. The problem is that the
> cursor-only commit path in amdgpu_dm_commit_planes() stores the event in acrtc->event
> and defers delivery to the vblank handler. This creates two race conditions:
> 
> - The vblank handler checks (pflip_status != SUBMITTED) which also
>   matches NONE, so it can consume events meant for plane flips. The subsequent
>   dm_pflip_high_irq finds no event, and the next commit hangs.
> 
> - If vblank is disabled by the off-delay timer before the handler
>   runs, the PENDING cursor event is never delivered and the commit hangs.
> 
> The fix is to send cursor-only events immediately via drm_crtc_send_vblank_event()
> in amdgpu_dm_commit_planes() instead of deferring to the vblank handler. The cursor
> update is already committed to hardware at this point, so immediate delivery is correct.
> This eliminates both race conditions by removing cursor events from the deferred
> delivery path entirely:
> 
> - Plane flips: SUBMITTED -> dm_pflip_high_irq delivers (unchanged)
> - Cursor updates: sent immediately in commit_planes (no deferral, no races)
> 
> From git history the check in amdgpu_dm_crtc_handle_vblank() has been like this since
> 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC", 2022)
> which moved this code from amdgpu_dm.c, but it was practically impossible to trigger
> because the default drm_vblank_offdelay was 5000ms.
> Commit 58a261bfc967("drm/amd/display: use a more lax vblank enable policy for older ASICs") in 6.12
> changed all ASICs to use drm_crtc_vblank_on_config() with a computed off-delay
> of roughly 2 frames (~14ms at 144Hz).
> This made drm_vblank_disable_and_save fire hundreds of times more often, turning
> a theoretical race into reality. The bpftrace log is full of drm_vblank_disable_and_save
> events interleaved with the commit sequence.
> 
> This fix was tested on DCN 2.1 (4700U), DCN 3.2 (7600M XT), and DCN 3.5 (9070 XT).
> Under high-frequency glxgears + cursor jiggling test the patch successfully intercepted
> the race thousands of times without a single timeout.
> Also running this on the main system without issues.
> 
> This instead https://lists.freedesktop.org/archives/amd-gfx/2026-February/138636.html was
> my previously rushed attempt to do something about this that is no longer needed.
> 
> Patch applies cleanly on top of tag v6.19.

Really nice debuging work, thanks for catching this!

Ideally, the cursor event should be delivered when hardware latches onto the new
cursor info and starts scanning it out. The latching event fires an interrupt
that should be handled by dm_crtc_high_irq().

dm_pflip_high_irq() handles an interrupt specifically for when hardware latches
onto a new fb address; I don't think it actually fires when there's a
cursor-only update. I think if we really want to do it right, we can have
another "acrtc_attach->cursor_event" just for cusror-only updates, and deliver
the event in crtc_high_irq().

In any case, I don't foresee any major issues with delivering the event early.
And since it fixes an ongoing issue:

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!
Leo

> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a8a59126b2d2..35987ce80c71 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10168,8 +10168,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  	} else if (cursor_update && acrtc_state->active_planes > 0) {
>  		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>  		if (acrtc_attach->base.state->event) {
> -			drm_crtc_vblank_get(pcrtc);
> -			acrtc_attach->event = acrtc_attach->base.state->event;
> +			drm_crtc_send_vblank_event(pcrtc, acrtc_attach->base.state->event);
>  			acrtc_attach->base.state->event = NULL;
>  		}
>  		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);

