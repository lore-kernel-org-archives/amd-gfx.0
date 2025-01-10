Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A4E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 19:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E1910F170;
	Fri, 10 Jan 2025 19:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CD1X/qnu";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E82810F170
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 19:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPKJkhsTWz3bvOZr95/M5k057GDc3sQxrEXB1rc+JklSbuamNcdjcKhSdJfONSW2hgDjzkccYnIoggMBg4j5aqRIxjLLNLCfP7eZzrxxT0WwOagFR360jcP6l7pGKE+rLmmlTDjYXpkMylKn49sPQM0SxleU1IWuPyPDdeVoWAVplKKvGjeG36YWDlQL9UxBCUphYKK2EU3FSbZiU5LU4fqCNU2paBgrDxZvw0302qAaAHI/Ng3VqRxDvKQE/sl+ebU3L4xWpmmBPedS9iLPzebL3Ub/ULPrb3kkvsfoW2adlZDfe82QWFc9Qk7ZX7WJgdgj8ZmR8XMMgb61ytb/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Iu1XhZyWbomyd/+WLE9lPqZR9PvQDfGBQNdVoRl6pk=;
 b=SH3FeQWHTjnBSA5n67v1nFYBodTq7IpGs+xKdyVq1xnVV0IlrD/ryGqtKF6eVLKE+dtI8uoLHP3PM9rU0ZBQy/gQAaZ25JdBa9R5Pj7xsf6mC+Y6JQxBj67UW7Gr7+WNWDovFOxtyE9bjytu+NwiYVJ2YsFX9J6/aHhOWGf4QsSzB2zN2khBoY1QhELvA4nV7rkvR7eNvZk2K5kcWQJSlh7V4HnQ9EIqu37I1OevhzFMNlJVBXVi9WG5KH86LDgD8hdF5+aIsiJp//i0ALBvL26qJvw5mWa2zpMrIRpf1UOuIeGEIqOEIgX2k9t4SiZB5kxrjKLwLeFuArKmn5GSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Iu1XhZyWbomyd/+WLE9lPqZR9PvQDfGBQNdVoRl6pk=;
 b=CD1X/qnuAeab3U2ChsCZ10uVI9RbNsGzHQhrp/ems0iTY6YZF1qaNZvAmYzNoiKq/OR0ptS4Ooh73t9Wzn88F4joVByuGZFXONSTcKsTzV1BJtBQp4SbB85X7ogUZScDpqfAB7TuoMJqHDF/zj4+OS3annfASnmbx9B8sJgS3H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Fri, 10 Jan
 2025 19:03:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 19:03:36 +0000
Message-ID: <65d6961e-c376-4b76-9b2c-47b56dd2e770@amd.com>
Date: Fri, 10 Jan 2025 13:03:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 3/5] drm/amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736474822.git.gerry@linux.alibaba.com>
 <3b84aafd838898a1de248f57359e3d23d2a64fe4.1736474822.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3b84aafd838898a1de248f57359e3d23d2a64fe4.1736474822.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:806:120::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8ea632-0a8b-449c-1931-08dd31a97c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDRScDAydlVSZlM5STB0YWZ3QnpIZksvWlhoTnV4WUJPZVFXZFhRRUgvYmh4?=
 =?utf-8?B?c3hwUk4wYzFsWnNiVk5ndU5oMms2K2VNdzhWSWkvMjdoV1k4N0FyYlFoUngz?=
 =?utf-8?B?by9SNFlpa0gwV1R1L2R0aTQ5YjVaQ1NnQU9YbEpjZ284L1B4L1Vid2doTUFl?=
 =?utf-8?B?Mi9vak1GUlVaZW9hNVNRUStmbWpoaHNqRnBsQ1YzNWJFaFNwV014WVFEalF6?=
 =?utf-8?B?eWRZM0tWcnl0Sjh3L0NwVURmQmFkaUM2N2pjakJ1b082ZjBpOExnN0htWGtB?=
 =?utf-8?B?ZFBOenAxT0JYczNzVGRITEFPY0pzN1Y5bVJ4NmFyVWZGOTNmSjFuMm9wQ2VN?=
 =?utf-8?B?TjFaQmxCWUpVdTVlVWg1d01rRkFVV0JIZ2l5UTU4UXVaVHhXUDNNSVhNRmVQ?=
 =?utf-8?B?QlFBOUFDd1RZRVA5YTNhMXFodHYzcjhzbTJNTXV4SWhlbTErdkdZMmkxV1Ar?=
 =?utf-8?B?WDRiMEgyUzRjbTg1YXFXdGJwN3FBamhQVFJTNFlVc0o5M0xsS0ZSd0tZNm00?=
 =?utf-8?B?akFxay8vcjdsZ3F6akM5SWpCbE5PMURXSFFlL3dvTWI5aVdmVGxoK1lLcnFn?=
 =?utf-8?B?LzR5ZGkvUmhNSmlsb0pXN21pVGJGQkNKbXloWGN0NG5pcmdCbFpxSTdMcDNq?=
 =?utf-8?B?aHZQOTk2MDg0SEQwNC9LUEhrZjQ1OGlLdjlncE9SaGNWN091TUx6VUtkZTRO?=
 =?utf-8?B?OFFRUERXUURPRzQvZ0hVYzVCZUZpQXc4R2cxZTdTTXpYdVNyU3pSTFRmQVNG?=
 =?utf-8?B?aUNiWjhuV3UvQmNPOUtyTlQ3K2U3VnRBWGZwSWY2T29HTklHMWpJR2Jkb2Ji?=
 =?utf-8?B?UjNVcmhZSEdFZmFldG82R1NjTVN3ZXJZRDBLeUM5V2pzSFJqN3hnb1ZwT2hR?=
 =?utf-8?B?dXFLTlUxeExjZVBUZy9DbzF1L3p0Qyt4MDQ1azUyZjlDTDErYU9hQ0tVMmhX?=
 =?utf-8?B?eFRraWc4dDR0ZVErN2tXWEZjNmZsVVZFcTcxRUhwTlFhRWRESTk3aGJpVldi?=
 =?utf-8?B?dHY4RlIwcUJGelNiN0MwRnVSOEZ0QkU2VGRSbnlzRTVZSkh5SmVtSml6aFhW?=
 =?utf-8?B?QjNZSkhjTUFmNkJySnhYNFFRRXJNU0JSMFdxTjNCZzBKNmFyN0lQc1EzaVNw?=
 =?utf-8?B?a3Q3OWYrVW9EN2FmUTdEWlk0TjNBM01sNHZteGJvZkdvR3B6TVNLR0xYZUZl?=
 =?utf-8?B?UHphQ1dxbnU4bGtGY25iSENEVEp2SytFTk9iNXAzQmxEUU85SmtXWllkWW1v?=
 =?utf-8?B?R2pkY0NFbnRtR2xnTkFpTGpPVTFXbmNDMUw1TEh1UG9LSzEzNE96Rk9CcnJY?=
 =?utf-8?B?UStycnl0ampDamhEOVA2ZDlEaldhVGV6NzZsQzl4NWQrVnpEOG5jRDYrdnN3?=
 =?utf-8?B?R3VMZG9KNEVNVkVlUVpiMStQODdaUVBxVkxlMEJYUzgrTzN0WWdrWjFXSFdq?=
 =?utf-8?B?UHE1QjZpOGRveDhJdVdyUjBSdDk1bVFQK240aG5vNm50MHhRM2RWNEw3b2ZN?=
 =?utf-8?B?NWxYWnRnZUI4Um9KYUh2dGxTQmVkRDNkUjEzMk9lZzM3a3JudHNFK2RkYjZs?=
 =?utf-8?B?NXA0ektOMC9FbnJwRGpieE9xVEczajAwZjJhcHpiS1U3OXhEOXBCTUcxNnd3?=
 =?utf-8?B?eVFnK2ZTSVRmV01QUllwTXd2bWUxdUI4WDl1bm5OblhvakloN28rUXpUZWhV?=
 =?utf-8?B?ZTIwbUZzMXlINkVpWmZoZ0Y4alFoVmVwckE2NUZSRTVCSHdVOTBwYkFHZHZt?=
 =?utf-8?B?ODNSZ3J6WTFBTHhoSU1CYW9IcG5TNWJ1dC9OUHdYS0NZc3pCdGplWnpoK2lp?=
 =?utf-8?B?L2hTVTU0dlh0K1VvU1hZcHZBNGcxa21qNFJIaW9KTTFGamloYnRWNHYyN0dt?=
 =?utf-8?B?MnBla1ZFOGhRT0NERzZOZTZiUVpOd1FrRjYwalZ5RU9DRDBNU3ZGdGxpNHUw?=
 =?utf-8?Q?orMpokyPvP0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZpTWU4OHAzZytYUGI4TmcrdzVUNmVKWmlabXlUUk5Ia3lVZlVVaThmdWU4?=
 =?utf-8?B?bnZzd0FMamt2TXk1TWJzSFhEUGJvTURtbGRMZlFWUms1K2duS2NudTJBNFVT?=
 =?utf-8?B?MExVVVlzNTJ1MVI0VTFwdzZmL3d1SmR4K1JORkdONC80ZGlTYnNWWTZrMXdD?=
 =?utf-8?B?WktqT0g0T2hveUpmRzUwNGtRVStQem5OdDFueklLSmNLbzR0anJiTGxDSlg5?=
 =?utf-8?B?dnhqNmpnbFRwTkVMRXhNaE9PTE5GQ0ljWk13WDFwZzdpNEJZNFVFS05qeGdu?=
 =?utf-8?B?ZnhIVXdtdk9hMUJGQWRQTTY0VW9PcDFZaWQwRjUrL0lPWU1MYUxQNkU5V0lt?=
 =?utf-8?B?UW9oR1JUSjBzejAyYXQ4ODMvdEpvbWhPWndkKzVobktvSzdPT1RNYWJOVUlH?=
 =?utf-8?B?YlhCeSszNzlRVnphUnhRT2tNdEN6Vm5PNHMwb0hidlhiTUdMbWJ5YjlrbGpY?=
 =?utf-8?B?dHgxUWExcUgyNjhXSm41ME01alFpNmd6anpmSDhSRWJxTEZldFVhdURwMGNt?=
 =?utf-8?B?SmJrVUNjWUxnYkNVNHRWTkdIdldFb1RsYllqTnA1RmE5dU9PTVFRYzdTRjBn?=
 =?utf-8?B?Kzh6cEgvYStkNWxXWEJNSWpIUktBM2hDcmptenFmd3MzUkxadHQzdmkzanVE?=
 =?utf-8?B?QXNNbnVYMXVEUnpCTjA3QkVoeFdja0FRWm85bVFUanNRS1ZmMC83V202eWFq?=
 =?utf-8?B?ZEd6WGVOWjJXNVV3TDRIbGlvcWgxd0p2MFFNZGtwR08xUVg1UnV6ZXllb2FP?=
 =?utf-8?B?U3l0SkdGVkF1QmlOWXlqcFI3eG0xMmV2azVpRm5PaWNvNG5IRFJVbFVKaCtt?=
 =?utf-8?B?WFNkVi9uaitWbjdXYXg4ZEFISU5XdHc0b0taMVRYSzhLVUZnQ0R6Q1JkMjRj?=
 =?utf-8?B?Ty9kSEQyd2R1Yi9BY2xTUWErVkNIbGF2RWphQzNqQnNLN2ZVMXF3azRBUkFa?=
 =?utf-8?B?NDRvckxLQWZDQnQrQXVTbWNFUFlLTkdjRXhZeWJqUUcrdUc3NlRSYmQ4TlZT?=
 =?utf-8?B?VnVHei8rU2t3SVNyQ2FhVEtxMDR6cnlUSGtvaitTR0pPSDk2d1NXc2hpMjBC?=
 =?utf-8?B?THZ0Znp0OEROblJGL0NFSzFZeENsbzU5czlGaG1iL2hQN0JHcHpxeXdSMGVr?=
 =?utf-8?B?ZUg5ZDYwOHpaQVhqWUtGalhCNnZhZEkrSHlCbi9zWDZoL2l6M3h3amc0T1ps?=
 =?utf-8?B?RkVVR0xldzRMUldLcm9BTWl3SWhBUlUzUGV2N0h2aEkzK00wRGRha05HbXBC?=
 =?utf-8?B?MkdsNW1kYkRua1ZFdW5zMGhpM1dNWktwYmRCMFlJOVJkeExBVXJmTHJJVTBn?=
 =?utf-8?B?Ym5NU2pZQ3ZvbEwxNmtRU25mS0FPcW1RR1R6YVZBR05nMjhWaEcyOFVxUnlt?=
 =?utf-8?B?T0xSdjlLWDJNQ2FhY0pGTVJ2MkgxSzI5dUtoVmlMdGhBYWlNUVdVS09rbXNF?=
 =?utf-8?B?eU1KbDkremp5OFlUNytwRDIxaTA3QWZKdC9hRFJ5N3dGczF0cUVpSHZDMzJ5?=
 =?utf-8?B?QlRCelIxaW9US2xwZnRJRGpaNmJIaUN4UjBTQjNaTUNZNTJHVWNidUpXbHg5?=
 =?utf-8?B?ZFdiRWs2czA5TElOcEtoSXhGUzh1RklUZXBNcVQyMVNnN3NmMElWQURhR0Q5?=
 =?utf-8?B?aXJFdm5wUFlwbUdwQjIvci84NGI1b2lkbGdNWU5XcUQ3SmZHcEdFSEtZZitk?=
 =?utf-8?B?bVhuNlNaejBaMUlVT1RQenVoMWZid3ZrditObGJqVldvakZRYUx3Nm5Bd2VX?=
 =?utf-8?B?aFp0bmVRK3MvQ1BpWlEyOWdYU3BlSjlTNk9sUzVIZjM2VHZQRkNHN3NMbzZh?=
 =?utf-8?B?Qk9wMXdId2o3V3k1Z3ZEbGhIOG1TamlycG4yZHpMMFF5R1hQSTgxTkhVMDdu?=
 =?utf-8?B?S0xhL1ZiMGxXS0d2Z2tpQ2dVWG1RMmtZUmp1QytEUTRZanB3QXVhSTJtOWNH?=
 =?utf-8?B?UFF6dWozdFVVZ1U3Y0pCWFVnZzRqOW9qMG9MVnQyWHBtZEg4UU5KNEFZSE1y?=
 =?utf-8?B?N2E4MWJFOXJ6dCtvVkkrbjY0dkRxNG81N0xrQWtnTURkS3B4M2pOOWhmZ3kz?=
 =?utf-8?B?NFUweFZ3aFJXUE52OWU5YTd2RGpNdG42RGpxaWhoWXp0aXpvdmgrS1doOWR5?=
 =?utf-8?Q?EQl3isD2RUOWlNsR0J5mRfL71?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8ea632-0a8b-449c-1931-08dd31a97c1e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:03:36.0100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqnsxXcuao8aQld4uMFL0bnBkp2F0gJ6gGYI9PvBxVaE5k7pnDIB7U7DaCdJCN2f46mfByT3rdRKRIGjBbNB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
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

On 1/9/2025 20:08, Jiang Liu wrote:
> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
> after free bug related to amdgpu_driver_release_kms() as:
> [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [16002.093792] #PF: supervisor read access in kernel mode
> [16002.099993] #PF: error_code(0x0000) - not-present page
> [16002.106188] PGD 0 P4D 0
> [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
> [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
> [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
> [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
> [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
> [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
> [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
> [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
> [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
> [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
> [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
> [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> dxcp]
> [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
> [16002.344324]  do_syscall_64+0x5d/0x170
> [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
> 
> Fix it by removing xcp drm devices when failed to probe GPU devices.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

I have one nit below, but otherwise LGTM.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 70 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  4 +-
>   4 files changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ff53a3b9851..f29a4ad3c6d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4777,6 +4777,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   	amdgpu_reset_put_reset_domain(adev->reset_domain);
>   	adev->reset_domain = NULL;
>   
> +	amdgpu_xcp_mgr_fini(adev);
> +
>   	kfree(adev->pci_state);
>   
>   }
> @@ -6682,7 +6684,7 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
>   	struct pci_dev *pdev = adev->pdev;
>   	struct drm_device *ddev = adev_to_drm(adev);
>   
> -	amdgpu_xcp_dev_unplug(adev);
> +	amdgpu_xcp_dev_deregister(adev);
>   	drm_dev_unplug(ddev);
>   
>   	amdgpu_irq_disable_all(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 62de668e9ff8..41d1b06be600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2435,7 +2435,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   	struct drm_device *dev = pci_get_drvdata(pdev);
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   
> -	amdgpu_xcp_dev_unplug(adev);
> +	amdgpu_xcp_dev_deregister(adev);
>   	amdgpu_gmc_prepare_nps_mode_change(adev);
>   	drm_dev_unplug(dev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index e209b5e101df..21993aff0dbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -268,21 +268,34 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
>   			return ret;
>   		}
>   
> -		/* Redirect all IOCTLs to the primary device */
> -		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
> -		adev->xcp_mgr->xcp[i].pdev = p_ddev->primary->dev;
> -		adev->xcp_mgr->xcp[i].driver = (struct drm_driver *)p_ddev->driver;
> -		adev->xcp_mgr->xcp[i].vma_offset_manager = p_ddev->vma_offset_manager;
> -		p_ddev->render->dev = ddev;
> -		p_ddev->primary->dev = ddev;
> -		p_ddev->vma_offset_manager = ddev->vma_offset_manager;
> -		p_ddev->driver = &amdgpu_partition_driver;
>   		adev->xcp_mgr->xcp[i].ddev = p_ddev;
>   	}
>   
>   	return 0;
>   }
>   
> +static void amdgpu_xcp_dev_free(struct amdgpu_device *adev)
> +{
> +	struct drm_device *p_ddev;
> +	int i;
> +
> +	if (!adev->xcp_mgr)
> +		return;
> +
> +	for (i = 1; i < MAX_XCP; i++) {
> +		if (!adev->xcp_mgr->xcp[i].ddev)
> +			break;
> +
> +		p_ddev = adev->xcp_mgr->xcp[i].ddev;
> +		adev->xcp_mgr->xcp[i].ddev = NULL;
> +
> +		amdgpu_xcp_drm_dev_free(p_ddev);
> +	}
> +
> +	adev->xcp_mgr->xcp->ddev = NULL;
> +}
> +
> +

You only need one newline here.

>   int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
>   			int init_num_xcps,
>   			struct amdgpu_xcp_mgr_funcs *xcp_funcs)
> @@ -310,6 +323,13 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
>   	return amdgpu_xcp_dev_alloc(adev);
>   }
>   
> +void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_xcp_dev_free(adev);
> +	kfree(adev->xcp_mgr);
> +	adev->xcp_mgr = NULL;
> +}
> +
>   int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
>   			     enum AMDGPU_XCP_IP_BLOCK ip, int instance)
>   {
> @@ -348,23 +368,44 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>   			const struct pci_device_id *ent)
>   {
>   	int i, ret;
> +	struct drm_device *p_ddev;
> +	struct drm_device *ddev;
>   
>   	if (!adev->xcp_mgr)
>   		return 0;
>   
> +	ddev = adev_to_drm(adev);
> +
>   	for (i = 1; i < MAX_XCP; i++) {
> -		if (!adev->xcp_mgr->xcp[i].ddev)
> +		if (!adev->xcp_mgr->xcp[i].ddev || adev->xcp_mgr->xcp[i].driver)
>   			break;
>   
> +		/* Redirect all IOCTLs to the primary device */
> +		p_ddev = adev->xcp_mgr->xcp[i].ddev;
> +		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
> +		adev->xcp_mgr->xcp[i].pdev = p_ddev->primary->dev;
> +		adev->xcp_mgr->xcp[i].driver = (struct drm_driver *)p_ddev->driver;
> +		adev->xcp_mgr->xcp[i].vma_offset_manager = p_ddev->vma_offset_manager;
> +		p_ddev->render->dev = ddev;
> +		p_ddev->primary->dev = ddev;
> +		p_ddev->driver = &amdgpu_partition_driver;
> +		p_ddev->vma_offset_manager = ddev->vma_offset_manager;
> +
>   		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
> -		if (ret)
> +		if (ret) {
> +			p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
> +			p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
> +			p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
> +			p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +			adev->xcp_mgr->xcp[i].driver = NULL;
>   			return ret;
> +		}
>   	}
>   
>   	return 0;
>   }
>   
> -void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
> +void amdgpu_xcp_dev_deregister(struct amdgpu_device *adev)
>   {
>   	struct drm_device *p_ddev;
>   	int i;
> @@ -373,15 +414,18 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>   		return;
>   
>   	for (i = 1; i < MAX_XCP; i++) {
> -		if (!adev->xcp_mgr->xcp[i].ddev)
> +		if (!adev->xcp_mgr->xcp[i].ddev || !adev->xcp_mgr->xcp[i].driver)
>   			break;
>   
> +		// Restore and free the original drm_device.
>   		p_ddev = adev->xcp_mgr->xcp[i].ddev;
>   		drm_dev_unplug(p_ddev);
> +
>   		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
>   		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>   		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
>   		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +		adev->xcp_mgr->xcp[i].driver = NULL;
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index b63f53242c57..be22d4398463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -101,6 +101,7 @@ struct amdgpu_xcp {
>   	uint8_t id;
>   	uint8_t mem_id;
>   	bool valid;
> +	bool registered;
>   	atomic_t	ref_cnt;
>   	struct drm_device *ddev;
>   	struct drm_device *rdev;
> @@ -155,6 +156,7 @@ int amdgpu_xcp_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
>   
>   int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
>   			int init_xcps, struct amdgpu_xcp_mgr_funcs *xcp_funcs);
> +void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev);
>   int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode);
>   int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
>   int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode);
> @@ -168,7 +170,7 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
>   
>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>   				const struct pci_device_id *ent);
> -void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
> +void amdgpu_xcp_dev_deregister(struct amdgpu_device *adev);
>   int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>   			   struct amdgpu_fpriv *fpriv,
>   			   struct drm_file *file_priv);

