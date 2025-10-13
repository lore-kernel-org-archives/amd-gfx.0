Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16DECCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 06:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F1D10E3CD;
	Mon, 13 Oct 2025 06:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sMksqsII";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9D710E3CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 06:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue/o80VQ83XjN0TnusRSKmwaRAQTuoRR6ZSGscVENZHCAVe+TFWDtSlzWM28e48DMSIJyK40DK2c1Xh4v0hN4Ee36We+CmgLxiUFgWMRVPp83ky66+mIiiBETedlBXdByOKdIq5ibd778RFJEy8ddog8X0DQVE77ll3PG8y4C2tHX+fo7ksbs18WBFcmLQavyreUIn7MfCPmjAKMB97vAz1/e3Pg88bnLqQcTfvTUhczrCZfSzRoY1hc/B8QVNrK8cWF/gAUbsnetY7WVwU0Bj/kddWk9M5tSOldxBs9edsgSWyo5y+mJwZhTkBTi9x+miPmsSg4rspXQq0MoGHwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SRYgvjE/J5LoUIJxcYay5LKlh1Z7rmf59+aA1+wwUI=;
 b=hR34z/Lwf6+mqDvLQ5cMguQJ2+MPw7O+QadjfFHGUy+RQn+VnqO4ZdAjrWJTGB9QEeNOcZumyvVlJKyWQZOfvjQ8oIEj27pz5BYUjMq3GO3K8U3GO6JVE7DQRxlOtrosmteomJ1oLeelME5ScLudjFddPUF0AnKuNr+T0NiL0fTbL8elMAN4d18JqCPymsq6q7EL082/Bzo6Lwnb4JCQbHCXlgBoNB+xgvgByF4PZAMOTzl0REouqGwX5PtuxnjASn5rC6SVIvEboOgHDKUl+R7kNq+607m7ISe5aGbBlaG+oUvYxaO8mTRXf1G76qe0fuSu1AJENSpjwUOUX5y+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SRYgvjE/J5LoUIJxcYay5LKlh1Z7rmf59+aA1+wwUI=;
 b=sMksqsII8d0zlyrkHT5LFQY8mOlsM5yvVJOuUVilLWhipOiQx1B9NQK9Pl08K0wvzDxx0DzNk7pg6ABR7yIRo1142q9u8WbUXPGTtMt+gF2UKAkimcvkMRvt3deMGy15FG9gYu70YpbcyFt5iPMOq2xWyV0OiZcZm6kpoC1Hv5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 06:58:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:58:45 +0000
Message-ID: <814565b4-4872-4af1-aa96-029524e73d0f@amd.com>
Date: Mon, 13 Oct 2025 08:58:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/amdgpu: Fix NULL pointer dereference in VRAM logic
 for APU devices
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251013062343.1550737-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251013062343.1550737-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1c38ea-9e38-4a2d-5f50-08de0a25f34d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1B1ZTdPSUJCaHJzeEQyK2RGajRxZm1rcGRaR2FncUl2MGF4K2dPREp0N3Mw?=
 =?utf-8?B?cG53RG50alJQVmdPVkUwb3hCOW9rMDUzd3c1WGUvTDl2c3NGSno1T3o2UEVV?=
 =?utf-8?B?VVFRY3dUYnMzdXJiaUEyQ1BaNngvcVpqVEUxaHJncWFEYzIxTWF1V1JTa2Rh?=
 =?utf-8?B?ZDU1c2o1dXJ0R0tlaytCclMxcUZrYXNVeWVBdG9JTGN3WWVDZDhrUzN3SmFi?=
 =?utf-8?B?UjV0RDVmeGRjM3VmanNpY25MM2E4ZEcxV1VIenhjNlpTdlFvMHFZSTFaM1RX?=
 =?utf-8?B?Q2g5UWUzVmNYMTAxMTJXUVVYNExKdjFTTGhhUmVpS0EzUXNJcGNaRVEzRjlw?=
 =?utf-8?B?WlFCZFphS0hIaWhVR3pOZXJtNnFnVk5QTTAzQWpNblRHeEpERm1DRWUxRFZw?=
 =?utf-8?B?ZGREbHBweXVCWFBqdEptc0NZNmd5bzFyZkxTTWpQYVluYzRBVUNIQUVyUGcr?=
 =?utf-8?B?Rlg3OG1HRlFhcE5iK21YOTRmR21mWUxzbUQ1ZWVnMGdoTHpGMnJydjJSYTEy?=
 =?utf-8?B?Y1c1dGxWOVZUOWZCVmthbWpDZFZrdVdCTVhoeXRuMEpqNXZqcjZiSkIraDlh?=
 =?utf-8?B?UmhPcTdORUN0TGNSZUtVc284NDFMdkhKNTVSN3VyeGwyQjJJSEZCNzN6cmVo?=
 =?utf-8?B?WmMxNTFkMjRaZk1zMDBwZkxIcEJVNm91d3JEeDJIRHAvTkdZaU91NHUzSUtY?=
 =?utf-8?B?QnNWeUkvOFB1U0Q5b2EzdmQ4cjl0SUREK1V4U2xQT1RjaEtvWTZQTDhRbDBj?=
 =?utf-8?B?SW9BUlFiZXRwSFNZRUM2Y3dYVjRpeWtYbEVWL2Z0VjZCOVBCQmJVbkJYRFI5?=
 =?utf-8?B?UllXV2tZa3lIMnV4cjdnYXllajBKZ1c2NGExU1p6OUExOXFiVUQxM2JYbjBR?=
 =?utf-8?B?V1AwN0dOQ1Fya3U1dVVYb1pRZ1M3STJvSVFRRUh0bDNxU2RaYUF5TjhoeitJ?=
 =?utf-8?B?NGpOaENTUWVRWEY2R3VoT3N5OXB3dUF1SlpvMHY0TXpWQ2dMOVpHcXlWWnVU?=
 =?utf-8?B?UlAwNndjVUZKYlNmazNRZjh0SUtLMUVPV282WEQyYXFXVG1PZTdLVDRuRk1j?=
 =?utf-8?B?Vy9ZQ1VSdWljTzBSdThHdUZqemZRY1M2OEVoMWg3ZUVibks4dzJ2L1FyRGt6?=
 =?utf-8?B?S29aUXd6NXFreXRBZjM2NW5nbCt6VGk5eS8vQkNCTkFkWVZmWkdMc0I2Ly85?=
 =?utf-8?B?eHFRcTlGOFgxNElpNGZPK2VPQmdjQjF4bURQQ1psamV5T09iMld5WU53Nzkw?=
 =?utf-8?B?bUtMa3NJdWVMcFplb2gwakkzdUpHUDNxdU1zNkZLbldmYnljK2V6UmR3R0N4?=
 =?utf-8?B?aTVCRzhhVThRN0h6anhnQ2tZb3NlOVF1YmVlcFVlNmNYVzcwTEFmdi9xeWJW?=
 =?utf-8?B?czM3RVhnajZVd2R6bTlIbG1LMUlxVUNlUCtoZ1EzekQ4SStVOWJ2dGVVR0Rk?=
 =?utf-8?B?LzhabGwxV3F5ckpzVnBVZURpc2NYUjRrWVBHMFh3QmtSWmQrNXo2eC83dzBP?=
 =?utf-8?B?akVPb2dteUxaWUZwYnEyd1lDcWd4aWE5TFFpdjBFZkEwOVpNV2pESUNadFF6?=
 =?utf-8?B?eGpCV2RoY3hraHdabFhUUUs2OW1mbTNaTkorSnJGYk5idWhiR1ZuNXVEbUlp?=
 =?utf-8?B?VGdTZXVVZ3F6YVdldEU2WjQrTXJJM1o5TU02V3BzOXdpOVQ2V1VHUlQzZmNs?=
 =?utf-8?B?T2VPZ2dTZ203bzJ2YXI2UU9RYWczOTI2cGRTb2J1aFRkc3JWc1FBOWFuQWcz?=
 =?utf-8?B?dWZnZU1uckJHU0U3NUJ3eFpjckFURlh6ZVgrNDZQckZOb2tzU29QMkU2Zm9W?=
 =?utf-8?B?QnpIV0MrM1V0NW9vZE1FV3pqbzlwNzBrTjc0NmNEV0JvZ1hzY0xyZlZrOWpX?=
 =?utf-8?B?Nm9tWCtHTWliK3k1ZjFKVjhiMzFYNlRlWEtkalFFYmwwQURGYzZmRnRUa0d2?=
 =?utf-8?Q?ZzCdWXmpI7UUA5YytrOJmFRO+avEELZO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WllXcWNoQ2JnMnN1Y25CSFRwSVZQbS9pMU9QbmQ4anpaUW1vaVUyaTN4VTY0?=
 =?utf-8?B?NUZaSTF4M2g5c1h5a0tPalBCM3dXSTAvcElzRVVOWkw5Tzc5T2R3eFJpSmVE?=
 =?utf-8?B?bEM0dEJheTExMS9uMU83ZGdJOW9xR2lIZGxUY1ovcmlaK2pBY2hNTnh0VGgv?=
 =?utf-8?B?aThyY3J0RTNLQWtpbUFuOUJoUXRzU2J6YnVmS3lmWUlpMmFMQzdFdVlRYitp?=
 =?utf-8?B?ZExvZTVVOG8wQm1IUFZ6ZEkzdTl2c3NmVWNDQkE2emxhSThrb0NJcUExbUNS?=
 =?utf-8?B?cE5aQWF0N1F4K1dvSytyQlNsM1dsV0dqaEQyd1RLSHMzK2RORGtVaE9MdmZl?=
 =?utf-8?B?RGZibFhNbU1VZXR0eHQxeWJLamROZXdReWNFVmEvT3ZoUzlKa2xKbWcvRFhq?=
 =?utf-8?B?VGJGQ2M1TVdzU0hwYU8yZCthM2pJeFBubFd5cHU3cTV0OFFiVnBZTU5xN1hV?=
 =?utf-8?B?NjRORXNEMVQrUnJuMWVGYUVpcVh3OTNuTG5BVFdSd3pUQU1xVkNYM1M1N0sx?=
 =?utf-8?B?U2ErRTRzaDZhRVVyL2F3MVl4MnE0Zk12ejdGZmRwKy9YdzNSSlFKQTJVdUpH?=
 =?utf-8?B?WE8reERvNUZlNVB0UHNadnRJcE5iY3QyR1BZd21TdTNyMURvMXh2bVUraDRa?=
 =?utf-8?B?bkxGdm5tNXgxV3g5TDU4cWg2SVhDYUV3djg3QkRrQ1IwOU5UNUJxdFYrQjEz?=
 =?utf-8?B?dnZCdS9zSmNlRThJMHcyVGZnZVA5QTNtRzdhQ3B6NDBkS1VCNy9tYWt3SEtQ?=
 =?utf-8?B?TnJwZ2g2dTl5WUhicHljMzBiUVJxNWNqZ2U3SW0vM1hCNThFV21KN3Q0MjZU?=
 =?utf-8?B?OG1ua0ozbjhyU2NrRHQ3OCtvSi82YlFKVnh3ZWFjV2tLeVVOMzJTZHV6UFVn?=
 =?utf-8?B?cjkvWDVJcUtXZW1EdzA4Z3p3Q1RYMFhpVkV3OUx6S1F6OTdHU3ZmcGJab0hP?=
 =?utf-8?B?djFwOXJrbitlZTl4QkorMUxZOThLTWxuZ3ZFRitFVlRhM0czQ0oyVFEyaUdr?=
 =?utf-8?B?VHRVa1Jmd2lBSGVWTXQvaWFqRUMvYmFhdW5wSXpteUQyRjFORk8yRzZmUThJ?=
 =?utf-8?B?eWxqK3JPS2FESy9DR2FIQi9lYzZtVFppNDhUQzZWWWVLby9iL1Y5cVAvUmxL?=
 =?utf-8?B?TmVyTTNqOGRCYlpwRXJKUHFTR0ZOVlZOdnQ0VFpYcjJRMTV2K2lUZjk0VVZt?=
 =?utf-8?B?d1VmZkc1OTFxQ1RUVkdPMmltYk0rRmc1WjQyTUpsRDZsZktOcitKa28wOGdU?=
 =?utf-8?B?MGwyd1hNRjl1Yzg3VG51aGgyYXRtQlErYU83eGZCTE5rOUpPVnNsTDZhdStN?=
 =?utf-8?B?ZkY2dDZxWjY4VTBxSndXS25mNENOc3VvbkpvOUNKLzVVV1E0cGptR0h5WmRH?=
 =?utf-8?B?Zzd3VzhhdzJ2TnJqWWtKMUNUaVgyT0FmYTRvbjIzZVpwN1h6RlZuR2d1d2hM?=
 =?utf-8?B?Y1kyOWJKOGIyWEVYQkVtT2xQVGhnM0pzWXNwNHpleGRjUnNMakphaDVSMk8v?=
 =?utf-8?B?aDFWOWF4MWZ5UlZsSHd3RFZBOUErN0VoQ3crdFdocUovYUlYREdDYU5ycUtr?=
 =?utf-8?B?dlVOMk9Pd3puWWhlQmhVdk1NYTRhbWwvZ3dBM3pGZitidkpTb0NhWnFhWXJ6?=
 =?utf-8?B?aU52OWkxZ2VvME5Pc2hod3VOTktwem1jcDl3TWlWcmhiRkY4anBLNXF4MkJn?=
 =?utf-8?B?bDhJbGF6RnR4blRjR2taRkJjcWp5cGVia0dHamdEUGdlS29FQ3JEbEVHeEpq?=
 =?utf-8?B?NmxTYk1hdlpHVnFFaVNsUXJJYzEzRkRObzlYUVdDZWZoMzlCczBqaTFxSlJE?=
 =?utf-8?B?bnRzMEswZ2VwSEhMWEU2NitPekdVZHVkS2piWFczaFdZZzdIM2ljRFo3dVlT?=
 =?utf-8?B?NG5UaUo5cmdtbERIZHlJTFFkSlh5a2J1OXl3dGNPcThpQzZidS9LNHNiaTJG?=
 =?utf-8?B?RFZZZm5jcGpMV3N0OXRmK28veDFJQnhwSk1XV0RoZVlaaGNZSG9RK0ZUOFY3?=
 =?utf-8?B?Q3pHcmpTVTZqWnVrRjhaeXh0U2l4Tm45YW0wVVNNN2drVGtHRENQNEdiTVNk?=
 =?utf-8?B?bGoxNmxhdzdlNnJTSnJvVlpkWDlpWXBqR3RjTjg1YXROVzRQYzM5cGM3dlVl?=
 =?utf-8?Q?TQ9w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1c38ea-9e38-4a2d-5f50-08de0a25f34d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:58:44.8907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9FCxIeuW72oySnpKI+j9sEp/cra1OVDal0Hxq9hR0UTWlsbmyDBAsq4DkJaoMgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
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

On 13.10.25 08:21, Jesse.Zhang wrote:
> APU platforms (identified by `adev->gmc.is_app_apu`) do not initialize dedicated
> VRAM management structures (`adev->mman.vram_mgr.manager`) because they rely on
> system memory instead of discrete VRAM. Accessing this uninitialized structure
> via `ttm_resource_manager_usage()` triggers a NULL pointer dereference (typically
> in `_raw_spin_lock()` when trying to acquire the manager's lock), leading to
> kernel OOPS—especially when tools like rocm-smi query VRAM usage or during
> power/VM operations.
> 
> Fix this by adding explicit APU checks in all code paths that access VRAM
> manager structures:
> 
> 1. **amdgpu_cs.c**: Extend the existing bandwidth control check in
>    `amdgpu_cs_get_threshold_for_moves()` to include APU devices. Return 0 for
>    migration thresholds immediately, skipping VRAM-specific logic that would
>    access uninitialized data.
> 
> 2. **amdgpu_kms.c**: Modify the `AMDGPU_INFO_VRAM_USAGE` ioctl and memory info
>    reporting to return 0 for VRAM usage on APUs. This avoids calling
>    `ttm_resource_manager_usage()` with an invalid manager pointer.
> 
> 3. **amdgpu_virt.c**: Skip VRAM usage calculation for APUs when writing vf2pf
>    (virtual function to physical function) data. Use 0 for `fb_usage` since APUs
>    have no discrete framebuffer memory to report.
> 
> These changes ensure APUs never access uninitialized VRAM manager structures,
> resolving the NULL dereference while preserving correct behavior for discrete
> GPUs (which retain full VRAM usage tracking).
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5f515fdcc775..d80414b32015 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -709,7 +709,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>  	 */
>  	const s64 us_upper_bound = 200000;
>  
> -	if (!adev->mm_stats.log2_max_MBps) {
> +	if ((!adev->mm_stats.log2_max_MBps) || adev->gmc.is_app_apu) {
>  		*max_bytes = 0;
>  		*max_vis_bytes = 0;
>  		return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a9327472c651..e6bf9f6a2713 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -758,7 +758,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		ui64 = atomic64_read(&adev->num_vram_cpu_page_faults);
>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>  	case AMDGPU_INFO_VRAM_USAGE:
> -		ui64 = ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
> +		ui64 = adev->gmc.is_app_apu ? 0 : ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);

Please use ttm_resource_manager_used(&adev->mman.vram_mgr.manager) instead of checking the adev->gmc.is_app_apu flag.

It could be that we will get more use cases for not having the VRAM manager initialized.

Apart from that good catch.

Thanks,
Christian.

>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>  	case AMDGPU_INFO_VIS_VRAM_USAGE:
>  		ui64 = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
> @@ -805,7 +805,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  			atomic64_read(&adev->vram_pin_size) -
>  			AMDGPU_VM_RESERVED_VRAM;
>  		mem.vram.heap_usage =
> -			ttm_resource_manager_usage(vram_man);
> +			adev->gmc.is_app_apu ? 0 : ttm_resource_manager_usage(vram_man);
>  		mem.vram.max_allocation = mem.vram.usable_heap_size * 3 / 4;
>  
>  		mem.cpu_accessible_vram.total_heap_size =
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3328ab63376b..5ff856bef199 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -599,7 +599,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
>  	vf2pf_info->os_info.all = 0;
>  
>  	vf2pf_info->fb_usage =
> -		ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20;
> +		adev->gmc.is_app_apu ? 0 : ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20;
>  	vf2pf_info->fb_vis_usage =
>  		amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
>  	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;

