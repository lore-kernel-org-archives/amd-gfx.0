Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF34C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 10:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372D910E012;
	Wed, 19 Mar 2025 10:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kuaUVh8O";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE1F10E012
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 10:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeTLj/vJE3VVhbSJQ7VHN000ZuosbbGGsL39m2y3LlWpjXxK5LnBRI6DqI4BF+0v1LjsW2Lnm9pBhtsVr0KZ68Ck6Uv3VCmB/Aepc4Dsvw7CIbUcPrdWN9goXHEq7mN8aP8N132BQXONnxU9MQzbuW2UVSbrKo8SJM7wRbLgWN6o+Qv35h3ZNt01j0nyEcrV/d1U49jJWUV71dvoAYDBWl15wCiMN/AjEsipLkIe6U2ZBdkge7l9cdTEn1a1LbROM81hagkVzUVB35M0KAvq7cuCCp6mc3A+yh1rIOT1h8q6xM2AsFJjH5G2eer5zTewR2bz2+E4Mr/hn4irF1lP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5ogiPE9T12jRJRzDNSLXy6L2x3csjHBbWtxd0pHl7o=;
 b=sUSMON5U3Ho8d69nDDngxxfzYpnItYZ6BWBKptaPvqy2g9/wP4smo4OS7kUx5aWAWIKoAke6Nh6HM77vU6J8YQthnXOMUMyJQOB+r8SyZpxIHHwbaKdxloDPcdFOlY1f1gMSg9ZHIexwZH2WHY3//vdMbW+54iQ5mdeJ9VpZanA3rLZlQZZU4gFkl+izTB2MdxawHQgBbol0i1uCKGNIVXumMMnk/Rr22my4k3xp2r4P0g27fk7ttpcVh1CYB5H7ibuhxKS/xIRAJKqHE92wg0WmLXUpjKlXgGltzUptGOFsWPkytDAAFwGiQniVWLBbIhdw6DJWvTkpze+JNF0NyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5ogiPE9T12jRJRzDNSLXy6L2x3csjHBbWtxd0pHl7o=;
 b=kuaUVh8O5i6e+AG7R06VlXVw4Zqp2qFifDcW++6enQ4lq5Gq2YPa5WTsjByLMeHM2mh4b/AnnGsCuN56UOf/7mkQDeA/lBVS6mluYkF5SU+KD2ofml4sgQHp7JMZATn9fnp2PKHr0qvJfj6wsyjl7db+J3BH2BALk0iuVT6Z8NA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:59:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Wed, 19 Mar 2025
 10:59:22 +0000
Message-ID: <914a4afa-3580-4c4a-8c42-8a51f7ffcad4@amd.com>
Date: Wed, 19 Mar 2025 11:59:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix display freezing issue when resizing apps
To: Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com, shashank.sharma@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250318145431.28944-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250318145431.28944-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d231caa-59c0-4473-7ab3-08dd66d51b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG5JRmEvSk5KSk9GNlE4Tkh6UTVHK3BGajhxY1dSNytXYkVmSE1nbXFDNUpw?=
 =?utf-8?B?V0t3TzlCQjcyRE9oVTJXUVozN2FNU0FOR3ZJbmZycXR0SFNHaUgveHdqRldr?=
 =?utf-8?B?eHZ2ZU1rZEpQcWRjUE5iU1ZOOXFBT0orRmRJTngrSFRESE1INlg5SFBWNDJz?=
 =?utf-8?B?aDFLeFFUOEJFTUNTaVlPOTcrWTdOazRYcmpzWWdTUDJKZlFhN2pMRXlhdkt0?=
 =?utf-8?B?UCtXYndFMW9rZlRnRjFkZmp2TXNyMTk5cUdMRW13KytCL1lwUWxjdGdZVndU?=
 =?utf-8?B?VjFDRjFDVm85aC9qMGpJN0hzUy9JU1QycnZsaHNEUHJkbFpybTA5b2phMnc4?=
 =?utf-8?B?ZUxRaHB3aCtvdE9yaU1Ocm1mN2xZd1dPYnVDUkRxYWQ4dkIwY0xJbHBwNWZ4?=
 =?utf-8?B?eHIvc0F6RW9adFNucWhpQkcrVk51SEZIaFNTQ1BXcUlzb3krZEorSDVodll2?=
 =?utf-8?B?ZzV6ZW94aDhaTGs2TWYvUkJZZXRZTlJkVXJrOWtvVFpQQWMwZzBiZlRlcUVq?=
 =?utf-8?B?b09KckJDdlNYSmNwZ0pSQlJsQ2FqV05UVWd5VllWM0pSYmdRcjgrNDdVU0lE?=
 =?utf-8?B?bU5iUUNOelg2cURseEg2SUNlSVB3Ry9rNVBqcHZpd3AydktoRFpBZGFLSzBx?=
 =?utf-8?B?LzZDbnJqYWU5VEN4N2Y5d20yVGQxZTlkZS9namtKRnhQdFJoWVNCa2k5bDdu?=
 =?utf-8?B?dDVNYlJQY0dRYWZDREt2UWowOXNhUVIrRXNhUWNDMDZ4ZlgwOExjZkg1TmFt?=
 =?utf-8?B?eTFibzAvTElrZEFUWUFFdzhRc3Z6dEpPMCsxSy9wY210NFN5NGxJMGJBa1o4?=
 =?utf-8?B?UWxYOGtKZngyZjZkV29uUEpRdHdFT2tzWGo3dWtNS3VYYUxRY0N5UEdqMW5i?=
 =?utf-8?B?R0FJaTh2NnFDWUNYdGIvdXZmTjkzMzVGRmtnQ20xUXVsaStpblNSem5ITFZ5?=
 =?utf-8?B?a010cUNmOEVMWFFsRjhScXpFa081N01oQ0xjV2srTjVmV3RESGVPa29sTll0?=
 =?utf-8?B?TXZ4YjlJVFdBM2thRmlIOG9Nbngzb2Fnd2ZkWjB2SVpteUZFQlZ1eFdOM0ZH?=
 =?utf-8?B?NUpITlQrb1NjdTU4eWtFNFUvNEVHYmtBMjVwazlXRW9ySWRKS0Ftd2xRS0lt?=
 =?utf-8?B?TkcrNCtwZGhHK04wSmFXdXAycXduUHZIM2RDUG1NOEdEQkZuM0pPSm5pdGpY?=
 =?utf-8?B?S0lVUDhSa1R1SUl0VXlkSnNVbmwxSlVudmRNbThLbGFJZWdwOXdxbzlHOU5N?=
 =?utf-8?B?TGFJWWZnMFV6OWwzbVRPUDZ3bE43bXdmQ0FpK1g3Y0VLS0Fod3ZSWEg1bW51?=
 =?utf-8?B?aDZmL1cwNGtPSUZVejJ4bHI2aEx0Q2dMRjZIdXRyOGlDcVpzdWliZzVWRlhs?=
 =?utf-8?B?SkwyS3JuUmpNRU1EbnVsMW50d3J2c0dPTGhzRHdlUmZGZC93Q3hDMmt4TEVu?=
 =?utf-8?B?cU5KQk1KWVlCS1NlK3RldGVrWEFPbmJkUTZUb0NlZ2NSWHY1UUtVU2cxd2pY?=
 =?utf-8?B?aGdwWEhJdTlKbldqWGlwbVIwV1VRQTFheW9oUXV1NGVTZFpZMm1CcUVZY1F2?=
 =?utf-8?B?YlRYYVJrSVZYdDBUZzFCN2hXWkRySEhDQVBSaWNKbmxJTVY2OWtVTTZNRXVB?=
 =?utf-8?B?TzVVUzJxOEk4SmRpL3V2bFJ1cHRsM2s2eDRITkVYZytVZmp1RHVMNCt1V3pT?=
 =?utf-8?B?TGpSVTJKbXpEVWQxcnFpdS9HM1JWTDZUTHd4MUl6V2licWhKY0lSNlR4WVpj?=
 =?utf-8?B?cmFOTVoxbExyVWRrNStrbW9ZK1MrOTdMY1lGUVRWckJWbm1jYkFzWit0bjdJ?=
 =?utf-8?B?Qno3WnoxZERHTHdQSmh5RzdiK2Qvc00vajZYS1FoRHd2QzAzcXNUTzJTaUpi?=
 =?utf-8?Q?XO6UwNkrNxk1B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9BT2RiTEhYVnRTaWVibWZpK1hqMGtCUVplUHJhY3Y2NzVkMGV4by9KeGtB?=
 =?utf-8?B?MGZHajFlemJOeXFrOFlMWWNFekJxd2lwLzRSaUk4MEdFbkl1UFpBYXJYZVdJ?=
 =?utf-8?B?SWNuMWZqdHRCdituT0NDTWtSeG5qZGNDekViWWFmZTZOU0JpNFp0UlpoU1Q5?=
 =?utf-8?B?SUl4VVFIU001MERBaHhrelJ4S2tPVE1xWnFBTk81WmRXcEo5a2ZvQmhmOVd4?=
 =?utf-8?B?YTNOc2N3cTVLSGdzYXY4VGFGK3JyNzBHeUlTdzZzVmJwdm1xdmg5Yit6bE13?=
 =?utf-8?B?WmJRUHFlK0UrVFo5ekh0bTIrSnlScUd4Tmo2T3VmSEF5L2Z5WW1Bc2c2bVV0?=
 =?utf-8?B?enVpMjRMcFgzVGQ1SWJtc3YvYmJRS25SQUdBWkM0am0xdzkvR1A4Q01abkla?=
 =?utf-8?B?S1ZJMGtTMnpGZjJEbXhKaFRpbGhBc3hiTTYxaytUSXg5Y0gvWDBJQjJKSzVS?=
 =?utf-8?B?OWl1c1krTmZ4Q3VsMmRaZHZubU45R2FRY2lORUtxWHNZZWdPQkZlSUhyNUFM?=
 =?utf-8?B?TjhKS0FTalJibXFjRC9UUlB0UTBBcnp2aUFKWGpjNXNUKy8vOXYyYU1QcnNH?=
 =?utf-8?B?V2ZXWkZnMXNxM0xaWnNubWxET3ZEWVlBcDV4dkRvTlVZMzBYUFpmQkxHeGZN?=
 =?utf-8?B?K1ozdzdvRkhrTmhFbndLSzE4L3NydXNEbE1kTEtlTWxJeUhRRlh3bzBnWUR3?=
 =?utf-8?B?S1phZmY2c0x3TmUyOFNWQXN1cHR3emJpMytxaFpYNjRreElqMWZ2ODZwajBD?=
 =?utf-8?B?bjNlZ0REK3dMY0txcEtMRG5iS01ndm5zTWUyNEI5S2NWOFJRNHFmaFZHR09t?=
 =?utf-8?B?ZXpvYXF0N09vTGk5UDNvTUoyY2o2d050YXZiWVNTN0VmMWFLT3RkNHNTVnpV?=
 =?utf-8?B?UXpaSjhvdUZYZ0JKWWY5Q003ZWhjSkQ5bW83bG5OUFRLV0xHY2pndzBmaFh1?=
 =?utf-8?B?OFJaSFJmaWJKck0rSTFKMEJLZUlTQlhKdDNnb0hRbWRYQ0NQM2E1N2NscHFT?=
 =?utf-8?B?KzBOYldpZEJUNHI2OHRWd0hZMDJVSHBOSGFzS0hNcG5icTlIb0RPenlVNHN1?=
 =?utf-8?B?MGdhZ0RERmxYcnU5MVdIU0pOZmtaU05zdUNSODQzMW1JQmNqK0J0NkUyUzRl?=
 =?utf-8?B?UHAvaWRJb0MyNktSRnVLMnBhQWhWSERtYnVHbE5UYm41WC9LQ0dVV3lQMEVS?=
 =?utf-8?B?NmdjMWg0eCs3N09wMFgxV2k3Y0pjR0ROMUMwMmZtaCtqSjM0bFpFK3FyTTlo?=
 =?utf-8?B?M08xeSs4QUhIaDZ6L2tDa0VBNlJmamlrWnI2UFdMNlhMMWI5TE5veEpOUWNw?=
 =?utf-8?B?TDJQMlV2NTNQK0VpZ3l1RFBMQlFDeWlESUJwd1IvdHQ0SVM2TDJ1N1ZjNEZ5?=
 =?utf-8?B?SG1QNmRWbEM5akFXM0VPOEMyeTQ2SVJKMldWblo5M0dHWnZ5V0l1L0FMcStI?=
 =?utf-8?B?WlZaSk0wSktKR0YxMXFsZWpFeTZ4amZSTHVYaGsza2xjUUtWMW1wcUNueEt5?=
 =?utf-8?B?TWFtemZGOHJIS0N3T29YTEVwUS85Vk05Tnl2cEtTenlXayszRW9jTDJkTlZV?=
 =?utf-8?B?UnFvZDVkdFBVR2VIQTVKaE0vcDJyT1c5cy9TYnNHUURrc0xBUnpoa0lpdUxt?=
 =?utf-8?B?d2g5Rm8wTXBZV2J4QzdaS2FYMzUyd2QxbVk3N1VJaWVqWC9TcVVuR29YUmsz?=
 =?utf-8?B?dnNqWUZ2QVRzMVhQS1E3OEJhR1lKMU9QaHBOMi9LeE9PekYzZUZxVlRLVVky?=
 =?utf-8?B?bndmSjRWbEk0K2hPa05OMXVzUGpaRzEzMlAvTFU3QzNYV3FINlkyMTBFdm1O?=
 =?utf-8?B?LzFqZENKemxWOTRkZkkzZS85TGVhOThLYW4yNEZGU3dvamtJdENHSTlEZmlY?=
 =?utf-8?B?WkZFUWR6QUhLNXhjdWt4V0ZxSjY5KzRFUTZ0a0gxRXkwRlZjOVdBeUxFQmxu?=
 =?utf-8?B?bmtvNHdYKzJ5VkNQaXdhWHpTbUFseS9HUHpCRFBPWWxNZHpjZnBrTm1VL0pv?=
 =?utf-8?B?WUt0cnN5NXlseWc2cm9FSmlNK3YwMzNQTzFKamJjYkw5b1BTYzJuMVpLYjda?=
 =?utf-8?B?VXE0QkkrN3VWcWlwOG1VVmUwWjhJajZvUmtkcllmUzNIN1QwTXJnTzZwS1FG?=
 =?utf-8?Q?dYRX6wTbbQCc6J+SC9NGm/kxV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d231caa-59c0-4473-7ab3-08dd66d51b18
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:59:22.6255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o6VPdzqiLQ3zjMQdnKpylI6EX7pU1kOxG0l+ikCsXo2W5I2libjXPRCTCE2/Xga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
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

Am 18.03.25 um 15:54 schrieb Arvind Yadav:
> The display is freezing because the amdgpu_userq_wait_ioctl()
> is waiting for a non-user queue fence(specifically, the PT update fence).
>
> RootCause:
> The resume_work is initiated by both amdgpu_userq_suspend and
> amdgpu_userqueue_ensure_ev_fence at same time. The amdgpu_userq_suspend
> signals a dma-fence and subsequently triggers the resume_work, which is
> intended to replace the existing fence by creating new dma-fence. However,
> following this, the amdgpu_userqueue_ensure_ev_fence schedules another
> resume_work that generates a new dma-fence, thereby replacing the one
> created by amdgpu_userq_suspend. Consequently, the original fence will
> never be signaled.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 167951aee502..0075469550b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -52,6 +52,9 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	unsigned long index;
>  	int ret;
>  
> +	if (evf_mgr->ev_fence &&
> +	    !dma_fence_is_signaled(&evf_mgr->ev_fence->base))
> +		return 0;

We might want to also have a flush_work(&evf_mgr->suspend_work) before that test as well to make sure an in flight signaling has finished as well.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>.

Thanks,
Christian.


>  	/*
>  	 * Steps to replace eviction fence:
>  	 * * lock all objects in exec (caller)

