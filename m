Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F15C3DA7F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 22:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AE910E2B1;
	Tue, 30 Jul 2024 22:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+C7gFav";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A78610E2B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 22:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM8u3PW8F+Ax7+gZAo9mw6Amhn5sf6aPbk5OVlNhA5QqoSNF2072Qogms8aRj4h7j4FmcnDAuCkhBgPzD9bgdLRBhZgtVqn/eWMvYIwHsAomDgRII3s4O8NDDokD4Ccjzrodki9XBx8gfCVENq7QifbDV4XVqW7/piK6QuMN8sOfIVlbiVwPOyNUa0r1FPEmxw86adbjpl96kI/+DIj8UcxgdPo40yJkhButqBSHbqAc6HY5yTlwObhLbaKdt78pXD1QIKHGblimXYcJ8hPvmDd4+M8AIilzEyQ1DlocW/eLBmnSGwoYf7PVnVK8e0tfldcIwrpKWVvZ+nvCooB/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfKKPxYzfv9nSa6kxrtO1SQjtnblyhaPa53uZ3tayhw=;
 b=wdwLQEq3nTqblNNWWRIFlpY0bL50qReVrGW6Hwz5KQ4WtW9cfKUufasHir4bcXlg15pPGmbb1mdF6NMepOx7C3qO44iJvhdUlLZijno1TXXE+L/l8a2kY5n43k2z/OCF7ZnhV6f1CViSdy3KJgP5+Cn66ikqZG1JnH+RP6SxSYlKBzGHI4KXZ7Lq0WLScs9d88XJ4tA6Iv8VE+IKS420X5XirZveyqdaoPs4J4C4HSHrfkBOh9BewGObxlWVBVWjYzrHwKwiDjmq0Q0PaM0XgGt1R3Y4EGkKbFeW82IpWRT6ITjQw9GLpDj3pTg3H/Svi6O/m94UGHbmibnVyE6f8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfKKPxYzfv9nSa6kxrtO1SQjtnblyhaPa53uZ3tayhw=;
 b=w+C7gFav79BpvAIaKKms5pQkDOuZoFL4ZkRth4t/CbnNJWRzlf1PpgXkoVTIBQnd/M4yllrmuR32Z2wy4UzkQpsvtYleuGiexuWlo2mYCkwcS1bm+dc7vx0afzC4Vx9DCqdXxi3S77Fkrlkvs/jrh5ZBrTx+dyVQMh0ohTSbasY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 22:06:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 22:06:45 +0000
Message-ID: <fa04d356-1896-4dce-9a03-8d68d018e1d5@amd.com>
Date: Tue, 30 Jul 2024 18:06:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: support per-queue reset on gfx9
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: a0550b97-0395-4a98-afc4-08dcb0e3e67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlR4ZUx6MldkZm9KL1hCUTRUc0xUbWl5U2dUWHYwNGlGWjJUOWdkdmJ3TDdr?=
 =?utf-8?B?ME5PVmZXNE1UTHJHeUliaW9pNnlpWUZPYWdrWjlzSWgwRERFZjNyL00zVm9y?=
 =?utf-8?B?YkJua2FsUHFiY2QycEwrN2xMd1VsaFNEakc5bFlSSmJ5Ymh2L2Roek8yTTZS?=
 =?utf-8?B?eEg4eENyd004SHdpa0x3WDBmaTF5RkEzK0VIVTVyTnRnRjlkTWgvSEhaeWlP?=
 =?utf-8?B?WmRlR21XSFMrNGp0SDJGbkoveWx0bllZOC9CbjhSSEVCTXBBblFvb3pHTERD?=
 =?utf-8?B?YnVZRGIzV0tCaUozdUcrZkJKckVlejd4aGhLNXdSQloyR1k3dFh2QU82Tmpx?=
 =?utf-8?B?VWxBbk1PSUNQc0xaQnNKZ0tZTnlUZm9ET2pheHI1NVRpbXVOVzBldEYxb0ow?=
 =?utf-8?B?ZjFxYVMzdDBuSXFEK3FONGNCVGliQnlsdWtUa3Y5NitGUVlSUC9waVJ5RzFZ?=
 =?utf-8?B?ZkpWOUFyanNJcmNtZ1Q5R0Jlbmg0TlJDMTd4S2VyVkk3QmlQNk8rRjZEMVBh?=
 =?utf-8?B?ZXY1Y0VrTWpjTk5ucXVOTHE3KzYxckZtYmVmSjFGU0dUdHBFcnFwbG56cDlI?=
 =?utf-8?B?Ymd0a2doM3ZJL0I0eUlCTUd1ZmJ0SEZMbXN2dEdES2tXbWVRajhsUGlFb3ZX?=
 =?utf-8?B?bGpVNm0yaUUwL3NQaFovT1d0VzVVN1JNMzRQOTlKYm0yUnFxSEN3SGQ3VVNh?=
 =?utf-8?B?L3BRL3luZGhyVERUT2daL0ZzY05kdEFLTFR5UGF2S1RwYkVmM0ljNVNxdUNh?=
 =?utf-8?B?cERRZm8wMXV0SE4rWmRMU0NaSzdJL0p3cUdkMkxHeXlNRUFXVndaaDFhbjlL?=
 =?utf-8?B?cUxEVFF6aWw5ZUY2dE5uZXVNMHhSYmEydlBtWlZHdDNpUVBabnpwSXUrME5P?=
 =?utf-8?B?dFd3Zlc0OHUzclU3eG5MTW96VDdSNkdybnd5OE9JMisxbmhPSVNuQWRLaENz?=
 =?utf-8?B?Z2t2aVBVUmFxM1ZPYnVFVEFmcVJNQ0dIK0l1T0luNnRUcDVna1JaUEhlWkpn?=
 =?utf-8?B?M3BPQ0xkNk4yQnNNYWNac1QwSjBZOVh2b2hsT3lVSDh5cFRvVlRiSGswMTVV?=
 =?utf-8?B?Z0NaT2dRTnc0ZFFuZjBHMFRYVVN0aEI3TERSdksvcElENEhpcm4xTEZGVmZL?=
 =?utf-8?B?c3Zkc3dqN2c4dGlsbG95eVlvekxWajFwMVlkVmY2VG5lZXArbXN0UWZJMGlX?=
 =?utf-8?B?QUFNTC9uRFEvTkNjdE1CMFhIaUloQzc0RFF3alNqL21SMW1kVFpyWUNaeUkx?=
 =?utf-8?B?UGYraElFcExjUDNqd0w5R1BrWGU0WWQzMmNkQzZUMmh5Zkh1Z0ZPaXF3aHpN?=
 =?utf-8?B?Vko5clFKdFIrUGJSVUdHY3U0UTNrQUdCVjFnY2NtV2ZhaXBHbkFFcmlqNnpz?=
 =?utf-8?B?dGhLamUvdzcvK2ppREhoWVdTZ0dkNkwxMXJqN1FCUDg4UUV1Rm9LSWtaTlJM?=
 =?utf-8?B?SmNCK3VKZENwUFoxTElwRDdjS2sxcVErczhzRmVlWnJHK1Z4Tm5EK2QxYjlE?=
 =?utf-8?B?Y3ZtMHhyTENLVmZidkc1cTR2a0hSeGpjU1NFejJ2R3dkak5XUVlPVHkwN0ho?=
 =?utf-8?B?MmZNTkJSREsvQWIralV0MTR2NW9sTml1TXZVeDh4VGxpSFhVMkpLWkJvbHIz?=
 =?utf-8?B?aEFmNmRma01WYW9nYWEvUzgwVXFCRzNCTis5VWZkL1NHZGtnNmwrYjFyYllw?=
 =?utf-8?B?TXVoVlo3dFJhWHM4V3pnalkvVC8wSWIya2NZYVF0Slp4VDJqeTNVakVMa2Rk?=
 =?utf-8?B?NGtCZlJkWjdzK0Q5STg5UEh6aXIzRE5mbHRPQkVIbFNLeTJ5MG1YWUo5VGZu?=
 =?utf-8?B?b1BlZGpBU3ZRdWx1LzE4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGtjQnZJNEJxeng5aEYveE9QTGRwVUZJTlpWTExIZFptT1dtR0tQSHJiSmV3?=
 =?utf-8?B?b2RuREptSjkzd1ZSN2FZSkF2R3M2T01vNWpKQktabFl1U3hsdjZKSEZYNVZN?=
 =?utf-8?B?WnN2S1p3OG9iM3VlU2ZKeWNvanpkTUJHV0pua0dFNlBDL0llTTJscUlRZWhR?=
 =?utf-8?B?SG1vUkY3QkdRc2FxMXV5OTJIakhsK0pXQ3hMTFdiM1ExTjBQNWxmQUR3bTcz?=
 =?utf-8?B?elVrQzU1ZW8zRnVXNXZJY00rd2FQMGpvdFU4VWhxT1RZREhQM0JEaVNLL1ND?=
 =?utf-8?B?TWd2VHgyZncyaHE4cmhuajVFT01GL1NCU1dDbmhVWUh0ajFBSm9mK0wrSGph?=
 =?utf-8?B?eC9vU3J0Rys4ejhxaW9lYVozN0ZqVkVOcEI2bWxWTi9uTEFRUXdkVURYMzl2?=
 =?utf-8?B?V2ExWXU3VzgrZEVIM1BWOXRBQzAyOWhKMVpQMVFtTGh0cXE4KzhRK3hUUmIr?=
 =?utf-8?B?Q29mTjR4TWhwSVROdnlFWHgycHMwbGJZV0tJSXFDWUtiR0QzSTlzZHRMK1dQ?=
 =?utf-8?B?eGk0eWJXcnNFbjdrZGZaaThxUlhrY0ZqQmVvZmFhRFdTT1JhMnNGZFp6aTdv?=
 =?utf-8?B?SnpsVDlEU0pZUXgzcGZaQVk4RFR1RG0zUnY1dHJheDY2MWFzYTBmT0x2R1Nm?=
 =?utf-8?B?ZElLd0Rwb0xiN05IcDZVcWcxM3pxOHJhdW0rMkhEKzByK2Z3TUF2UDB0Wko1?=
 =?utf-8?B?S0c1cWMzTGN1TUI3SmpGQ1lQU2FOTUt0OCtYWVY2SEc2aGFwMVhGMWs2dS9v?=
 =?utf-8?B?ZjEwWVNEMmVuc092cW15d0V2MS9IQjRqK1o0UnJqaks0T2Z4R090aEFMbG9B?=
 =?utf-8?B?VSt1RnkrRFZ1aXNpYXZuVjNFVHl1Mm45ek5xY1IzbjRMQXZVNVpySGJCdGF1?=
 =?utf-8?B?MHVrRFZrQmE3Qi92SDlxc3p5amE5Q29Va3VZQ3laZ05ldHpLN3AxeDRsTHNJ?=
 =?utf-8?B?NGpRMStDU0FFeFcvSVRmY3BON0Jnekx0YUkyclVHM2dUR1dpVDVmS25pNDgv?=
 =?utf-8?B?ZDVaekVmUlhEc1VyZ0ZhdjRnaTVQdUJieXlqSHZtSDZxZmFsV21oVGM1WGNx?=
 =?utf-8?B?ZUJxRWt3WDF4MDZqTUE5emQrVE5RejBteUlqMitQV1htZGJsMHZ6RUtVSXh1?=
 =?utf-8?B?UlUwTCtiUTQ0b1ZBRkVaR05SN29pZmgvdWs2OFV0WWVGYzFhU0t3QzBOU3FS?=
 =?utf-8?B?R3BoVUhEdGt6Qm9nVXZmSm11UUphRlZpNnhsK1prTGl4aDRMNU5JUzRINW52?=
 =?utf-8?B?ZXhkc3Z3MEVCelVjOEMzK1JJNXFRY1EvQXA1MXpvRCtRZ2NuQUVkS3gydmxs?=
 =?utf-8?B?enhkMDAyMC85cDEzUi8raURpc3VOeEFEL2xPaVNtQ0N2YUpZcHlwRStqa2tz?=
 =?utf-8?B?MnVNQVEvaXVZa2k2SXUwbGRVWVFDNXhQN3dNVFZ5WGZaQ05sOTBuUFVLTGFl?=
 =?utf-8?B?dCtWZGM5b1grNXhiQkdrMzA5YUlaV2VzR0ZsVjV2NHFzVmRjVlhXaVIyUXVL?=
 =?utf-8?B?bzZFRitCZzBSWUc5RHprZ2hHTWZuY0tGSlp3bHBYbUQ0OHBKQmg4M1NkaDVH?=
 =?utf-8?B?bnlhUU8rN3lVNnpIK25FZ0JOZlExQTN1RXkyUDZQWkJURmwydVAvMXhWbWxz?=
 =?utf-8?B?a0V6RjZNMlFnV1VvWXN1RldwVGpEbTFXdjA4SUV0YTZPY0RlTWZCTmZBWWts?=
 =?utf-8?B?ZHQ1NVhBTTBxNkgxSGRQMC8wYVZ6ZVQyY3JYSVpIME1PYXdOL1FaZmZIdUYy?=
 =?utf-8?B?amRjZ3hLalJRbzk0V2pVdHRKNG9HMmRnSURMZ3VkYitYOTRkMWNqejZNWmVF?=
 =?utf-8?B?eG5ycWNHOUhPQVYvY2haSWpLbW93Nk1KQmVOOXdlNlNIWGVJYUZXMUEwNGh3?=
 =?utf-8?B?ZU4zaytLaDhWYXJnc0FqVmZZb0pHUHNqSnhtRUxCQkZJTE9UZlpxMkdabnNK?=
 =?utf-8?B?MlFOc1RGcGt1cnkyVVJwLzgxQXd1SzhPSHcrME1FVDczN1MzREFkRlVNUGx4?=
 =?utf-8?B?NERmU1BDSDY4eUszVkRva0haWTIxUGN3eUxHZ0QxTkFLSGVkZ1JERGkrcXJ1?=
 =?utf-8?B?TnJiN2dOa3N4QW11bDMvSzBxQ3F5dGZreGJlRmIyMVYvTEpUd1c0K1o1V1lZ?=
 =?utf-8?Q?pgE3VXsdR6/N5toQe/G6JupaT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0550b97-0395-4a98-afc4-08dcb0e3e67b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 22:06:45.2158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUT5dHi//d+Mf9rNe566I1EVUZutwaV/+xvP3ShcCSl2eBac5QB4WPEmVZK2/G5ZCYFFIA7q3UhlucCE/1hMoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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


On 2024-07-26 11:30, Jonathan Kim wrote:
> Support per-queue reset for GFX9.  The recommendation is for the driver
> to target reset the HW queue via a SPI MMIO register write.
> 
> Since this requires pipe and HW queue info and MEC FW is limited to
> doorbell reports of hung queues after an unmap failure, scan the HW
> queue slots defined by SET_RESOURCES first to identify the user queue
> candidates to reset.
> 
> Only signal reset events to processes that have had a queue reset.
> 
> If queue reset fails, fall back to GPU reset.
> 
> v2: move reset queue flag for house keeping to process device.
> split detect and reset into separate functions.
> make reset call safe during power saving modes.
> clean up some other nitpicks.

Some more nit-picks inline.

> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   2 +
>  .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   4 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   4 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  16 ++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   9 +
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   4 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  18 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  85 +++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   9 +
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 172 +++++++++++++++++-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  12 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  21 +++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   6 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |   6 +
>  16 files changed, 360 insertions(+), 13 deletions(-)
> 
[snip]
> @@ -1680,6 +1700,14 @@ static int start_cpsch(struct device_queue_manager *dqm)
>  					&dqm->wait_times);
>  	}
>  
> +	/* setup per-queue reset detection buffer  */
> +	num_hw_queue_slots =  dqm->dev->kfd->shared_resources.num_queue_per_pipe *
> +			      dqm->dev->kfd->shared_resources.num_pipe_per_mec *
> +			      NUM_XCC(dqm->dev->xcc_mask);
> +
> +	dqm->detect_hang_info_size = num_hw_queue_slots * sizeof(struct dqm_detect_hang_info);
> +	dqm->detect_hang_info = kzalloc(dqm->detect_hang_info_size, GFP_KERNEL);

You need to check the return value and handle allocation failures.

> +
>  	dqm_unlock(dqm);
>  
>  	return 0;
> @@ -1713,6 +1741,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>  	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>  	if (!dqm->dev->kfd->shared_resources.enable_mes)
>  		pm_uninit(&dqm->packet_mgr);
> +	kfree(dqm->detect_hang_info);

Reset dqm->detect_hang_info to NULL to avoid a dangling pointer.

>  	dqm_unlock(dqm);
>  
>  	return 0;
> @@ -1929,6 +1958,131 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
>  	return retval;
>  }
>  
> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
> +			       struct qcm_process_device *qpd)
> +{
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
> +
> +	pr_err("queue id 0x%0x at pasid 0x%0x is reset\n",
> +	       q->properties.queue_id, q->process->pasid);
> +
> +	pdd->has_reset_queue = true;
> +	if (q->properties.is_active) {
> +		q->properties.is_active = false;
> +		decrement_queue_count(dqm, qpd, q);
> +	}
> +}
> +
> +static int detect_queue_hang(struct device_queue_manager *dqm)
> +{
> +	int i;
> +
> +	memset(dqm->detect_hang_info, 0, dqm->detect_hang_info_size);

Set dqm->detect_hang_count to 0 to avoid overflows in case multiple hand detections get kicked off. Or if that's not possible, just print a WARN_ON if detect_hang_count is not 0 and return.

> +
> +	for (i = 0; i < AMDGPU_MAX_QUEUES; ++i) {
> +		uint32_t mec, pipe, queue;
[snip]
> @@ -1244,12 +1245,32 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>  	idx = srcu_read_lock(&kfd_processes_srcu);
>  	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>  		int user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
> +		struct kfd_process_device *pdd = kfd_get_process_device_data(dev, p);
>  
>  		if (unlikely(user_gpu_id == -EINVAL)) {
>  			WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
>  			continue;
>  		}
>  
> +		if (unlikely(!pdd)) {
> +			WARN_ONCE(1, "Could not get device data from pasid:0x%x\n", p->pasid);
> +			continue;
> +		}
> +
> +		if (dev->dqm->detect_hang_count && !pdd->has_reset_queue)
> +			continue;
> +
> +		if (dev->dqm->detect_hang_count) {
> +			struct amdgpu_task_info *ti;
> +
> +			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
> +			if (ti) {
> +				DRM_ERROR("Process info: process %s tid %d thread %s pid %d\n",
> +				ti->process_name, ti->tgid, ti->task_name, ti->pid);

This looks like debug code that's not meant to be checked in. If you mean to check it in, the message needs more information. Use dev_err or dev_info to print the affected GPU and put something about a queue reset into the message.

Regards,
  Felix


> +				amdgpu_vm_put_task_info(ti);
> +			}
> +		}
> +
>  		rcu_read_lock();
>  
>  		id = KFD_FIRST_NONSIGNAL_EVENT_ID;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 66c73825c0a0..84e8ea3a8a0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -321,8 +321,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>  static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>  {
>  	struct v9_mqd *m = (struct v9_mqd *)mqd;
> +	uint32_t doorbell_id = m->queue_doorbell_id0;
>  
> -	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
> +	m->queue_doorbell_id0 = 0;
> +
> +	return kfd_check_hiq_mqd_doorbell_id(mm->dev, doorbell_id, 0);
>  }
>  
>  static int get_wave_state(struct mqd_manager *mm, void *mqd,
> @@ -624,6 +627,7 @@ static bool check_preemption_failed_v9_4_3(struct mqd_manager *mm, void *mqd)
>  		m = get_mqd(mqd + hiq_mqd_size * inst);
>  		ret |= kfd_check_hiq_mqd_doorbell_id(mm->dev,
>  					m->queue_doorbell_id0, inst);
> +		m->queue_doorbell_id0 = 0;
>  		++inst;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b5cae48dff66..892a85408c09 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -843,6 +843,9 @@ struct kfd_process_device {
>  	void *proc_ctx_bo;
>  	uint64_t proc_ctx_gpu_addr;
>  	void *proc_ctx_cpu_ptr;
> +
> +	/* Tracks queue reset status */
> +	bool has_reset_queue;
>  };
>  
>  #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 9e29b92eb523..a902950cc060 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1851,6 +1851,8 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
>  			goto fail;
>  		}
>  		n_evicted++;
> +
> +		pdd->dev->dqm->is_hws_hang = false;
>  	}
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 6d094cf3587d..7744ca3ef4b1 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -318,6 +318,12 @@ struct kfd2kgd_calls {
>  	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
>  			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
>  			uint32_t inst);
> +	uint64_t (*hqd_get_pq_addr)(struct amdgpu_device *adev,
> +				    uint32_t pipe_id, uint32_t queue_id,
> +				    uint32_t inst);
> +	uint64_t (*hqd_reset)(struct amdgpu_device *adev,
> +			      uint32_t pipe_id, uint32_t queue_id,
> +			      uint32_t inst, unsigned int utimeout);
>  };
>  
>  #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
