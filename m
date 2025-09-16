Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6D1CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 11:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BDE610E7B9;
	Tue, 16 Sep 2025 11:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZL7xF1pO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADCA10E7B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 11:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dw6c48nEKZrTbRk28EpP6HoMWYTYAufSe5ZDDNY7mIFVrd/5rkwndGrDz+FuW3kLi7JbNV5lsuitX4QY3vBLekQAWiSdhjJzMzlU9xty7MAK72N1Lt8J6eE8azxcA7M9E50Lm7j+frour8xvEJ8rilkU3St/GXC+nvD1qjpm+B5iaBjzwJ7Af+UZW+519AIRK0EnqSPiqUuQTCaen567ZJG2C3QKr7cJZ2ajF+VntfTYlDVZVPPMuugA0CXtOu5eAUd+AtDNPd1SUSnw7rEu+6HYuMw/gUNHb92bgnvJOqDW+53TH4MDY4RZ4Y8CQXLuKgY0mN5416DQ7lZH2F9W8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHDsT/GMaX9Ue2cHJzHXQfNcNEKNmPwmh63ZculX7eQ=;
 b=Ps4gu3EVcVm2DF0kym3q3LRLIFE1lg7cnz1Y7J3J+xtt4WGYF3kZTmRMwqsLXN6QXfRB+eKTAJG+rFCRCOWZMhIGorZkXNW4ru9P0e34KXiS05tfX3F5IGwGUPfmkI/amuGBfViLffW/qfSExgwdpcKMZx8zR/AxgUd5yWmUJ+X4YJzSSWZrLpOJW822rT3Wa+nKWuydmjBCB3rX3EXvo/cHQcqpx8fZhjcbOhREM8tMVPfjl5N85mgiqpkjxj6tHfQRtd2ih40Q9dSOV9vBILS3D2m6/8U6gqnWgv0MSxCwXAVeCQ7/BuA7VaHnGgp5x1TzsLTLJmozpNuDdknhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHDsT/GMaX9Ue2cHJzHXQfNcNEKNmPwmh63ZculX7eQ=;
 b=ZL7xF1pOFsFqVOaCZ/ZJKuEp/cwLNHz6c6fXD2Co9p4KFK7WaTouKM2bjYgC5PoIYe1b9k1HGIu6J5rs46oAEVjuaT6LMOD2EjDIFBm/ohipWMkb4sfqrjEYqJfR5XNRRGceYLHMC7ejsE46o8iPxfTB1fbSvJhXS7wNDIwpIVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 11:23:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 11:23:54 +0000
Message-ID: <a2170442-4f7d-4887-bd24-4760677cfad7@amd.com>
Date: Tue, 16 Sep 2025 13:23:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/amdgpu: Convert amdgpu userqueue management from
 IDR to XArray
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250916093617.1046358-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250916093617.1046358-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2b8403-cca7-4ffc-b0a0-08ddf51384c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUhUSE1CMFpvbXdKRXlZM2YyUHFwZ0VUem5pZmg0MXlnMThzem9hN2JTcVpJ?=
 =?utf-8?B?NTlKV1RKSk9lYm12VkxRSDNmNm9aTWFsNTAxRUNhSFBJTm5aQkszaVNiU0J2?=
 =?utf-8?B?R0V4RUpCWWc0MGZyWm4wcUVHL0ZuN1ljR2QzclozZGZrSFdSN2pKanp5K3c3?=
 =?utf-8?B?ZHNMRUxqTGdZa0YrWTVnNDVLVDFjQ0ZSU1U0ODd6VTFrWXZ4aEJCekVhc2pT?=
 =?utf-8?B?L0tVaGlNRW9GNGx3bUlUQUdFeXN5UFhsMEhTSjBMWXo3RzVBakRwRUFuOG1i?=
 =?utf-8?B?Um1MNmp4RG96UFhDWTUzbmlpMjFvNDZIZkkyelFVTEhnTytjQVB4c294UWh2?=
 =?utf-8?B?WHh0Q0xoaktoSG12MXlENFZPNnR4a2VDaHV4UW5JZnNXNDFKRmJBQ29kVkp3?=
 =?utf-8?B?UFRqL3hZWWRPSlExUzNBZUpYSE13a0FXdDZyMXZDRkFMSFF2Um53emI0aDB1?=
 =?utf-8?B?WUcwcGV0YjNRelV0dy9vQXZtUmplOGxkMnRzTGRESmI0NWo1ZU91WkhYaGE1?=
 =?utf-8?B?SFcwa1FYc1IwOTRwdG5YYkpvdHEvU0xpbEFsODVna1hnSitTT0lBV3Znazh6?=
 =?utf-8?B?cytJNHhzbmZjWXVRdXdIYzNFRklaM3dwZVFWRG8vZHp0Z20vTHNjV242LzdB?=
 =?utf-8?B?NFpHbTRaeXdjbHhTQml6VVRZQndYRG92MlBxakhwQmVDYUFkTG5ZK3FoanFH?=
 =?utf-8?B?Y3BFZkd0c3V0U2wxMzRXY1dCb3pOdGplYURKdkVxQ0NCM09xbzY5OXgrUUdr?=
 =?utf-8?B?dFRqVForUFlCSndSMWE0ZGpGeTBibEE2RmhJU3lCSG5ORmdkR2JQNjFxeUxZ?=
 =?utf-8?B?NzYraU1YUEwzM2prbE5DRE54ZVhMeUVvZ1hvUHRXbjM4WndyZVlma01BTkdz?=
 =?utf-8?B?SStjU1poSFVZdGVYanBlZE12Yjh5c1N0L1I3M1BIUXBuMEhrbjFOamx3OU9G?=
 =?utf-8?B?dnE0OUt3aEpydTFnVGYyM1NPMmJua2hDT3BrZGVoeDUvb3RrZHByOGI5R01x?=
 =?utf-8?B?dzk2SjcveGU0bTNQbC9kQ2pFQ2Jpc1h2UHJtRlJBRFNSdlRBb3FJVDg4WUNI?=
 =?utf-8?B?dSt0cTdCRWVjdTFrclJQU3VNdHZsQWFtZzVqMXE4Q1RVUXJnajh5Mm0vTVNi?=
 =?utf-8?B?cW54Rk1QTXRDMHNxbGlNS0JYdlpxRlNIb25Dd3dPZE80Uk4zUmhRaDlteVJF?=
 =?utf-8?B?a3FDcFI0aTZheFE0MTZUd1RlUTIySlRHczJldmlJWllVeVYzajZ1WGZzcmNk?=
 =?utf-8?B?V0RoUUcwSHRQMU5qUHlpNnZ4RXlXME83Z0NYTlhFYUNtdy9QSWJXKzBCNUsw?=
 =?utf-8?B?cFlRU0JINkxFc2JtNVJLeUlyNVkvY3ZhTktMY256MlFjNnZhWXRpMXR1OENL?=
 =?utf-8?B?d2xvaGJyVjdKVlN2My9QSmZtTDA3eWMzdTJuR002VTVqOWJXNjcrR1R0QStI?=
 =?utf-8?B?VUc0Vklqc0lzbElQQjR6THNBcG1XYWNEQUtUSlI4Y0cvNEFrZ1l1Z2M4SFB6?=
 =?utf-8?B?TENVQW13Tzl2QTNoTFV2SmtuNC9EVk4vTUJkOTgwK1BpbFBibmpDQnBDSDh6?=
 =?utf-8?B?cDBqQkNBdGJKVzkxZDlUUHZ4RzFMS2xuS1lveUk5b01kMWhTVzRDK1RlbVI0?=
 =?utf-8?B?QWFJb1lkMnNybXkvNnJOOUxJd0hoTmh5dXNYNEk0NDJyallNQlBuQkhhQnI5?=
 =?utf-8?B?RmdFa3BoQ2JzNmVrMmk5eEFaOHc5ZVh2RjdrcEZOWTNSUWljTUVVbHZnSCtl?=
 =?utf-8?B?TUJTRk5sa2ZlMjAxdkJqajNrT2pxOGsvQUdaRU1CM3NkN3FTUFdkRWVUcVhj?=
 =?utf-8?B?Y3JlRHlqTmZFUU0vNDhCQ0JCSGYxblhCRk94ZFBieXhUdnYyMjNaRmlzSzk1?=
 =?utf-8?B?T01MQTdXdHJidGY3c0ZHUFA2N2Fyb3dpeVU1cGJ5eUhvVzV3MnpQbnp1SWI0?=
 =?utf-8?Q?RGuI7jOyN3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC9uR25xU3YvRm5zUXhHSWlTVkUzOHJjSGJjZjJVWGVlN0dIN2E1R2FoLzJI?=
 =?utf-8?B?dVhWblV2Q1BKWjZQZUg2V3RyTnQ1NThiR0xqVG94WThtcmUyaFhiT0NSTERl?=
 =?utf-8?B?aDFPRkUwVjF1bnV5WnprTitUWE14bUJnZmRSUXViVFJzUWdsUWwwOUo3Q3BX?=
 =?utf-8?B?dDJhblo3WThJUkhKeDlJN0l3VS9YMlkraWtmU01jYkU0WWZrMXZHdHJ3M01K?=
 =?utf-8?B?T01Uc0ZlTXVHaW00YS8zYTJSUGhkcWxwbCtEK3ZKYW1kV0RCN21iWXVTSzFl?=
 =?utf-8?B?TktKZmZDa0NuN0N4SFZ4TDZMWXVlSVlTZXovSDZhUmhNd0hxcEV5Vzl0L21F?=
 =?utf-8?B?cjhKMTgxakpmaDZlVzdlNGNjQUc1OGNtYXlUUm1iRnVtbFdoWnpCRnRLK3oy?=
 =?utf-8?B?ZXRELy81T1o0NzQ0K0FsNXp0RjVkNTVja1E0MTlpQ3UvMFB4ZU9vNXk0bzMv?=
 =?utf-8?B?R09DbTRzbmxFNll6SU41VEJQWTZjZTQrWnRNN0xFZ2RJQ1duY0o2ZzltWFJX?=
 =?utf-8?B?QkFMaFNTUTBFNzhyQ1lFQlFzZ3cvUkQyTE8wb051OW9aeWtUc2xweFBWeGdi?=
 =?utf-8?B?eU5HNEdsRFM0THh3Q1BQczMvRHZER2hmZTNaM2doYjlYSjN5dkRjMEJpa1pV?=
 =?utf-8?B?Rk9rN1oxVG4yVmc3UGluUk5yMTJCV3FKcmJrZVEwaUFnakd2SFBqMEhGck5B?=
 =?utf-8?B?U1NLVS9oN251bmluYmN3dmduSkxaSm9kRjFONk13QlE3ZGtvYnpoTERRT3lq?=
 =?utf-8?B?dStrMVVtNlozeFpXSVJVb3JYMDlpZ2RFSytmbnIyQTJCcEV6TmVuRVEwUDFn?=
 =?utf-8?B?M3lJTkM0Q0l3SWFtNjRGQTBzWVhDVFNlbGg4eDlNem51aVJSaXMwc0lONXNS?=
 =?utf-8?B?NjUyVGt1MDVUenR4eko4bnlCREVvUFhUK0pyT3ZZbXhoNHFoRlpVUFJBVUxV?=
 =?utf-8?B?aXUrREdZdkU3UXUzbVVXSnhHL0k5NHhLT3V3OWtmbGE3dm5Pc1p0SVdvSmtj?=
 =?utf-8?B?MkQveEFPZ2Q0TCs3M0x5ZTI1RGNTVFdPUEFBdU8zcy8zeDdIMmt5RmVObkg2?=
 =?utf-8?B?ZlBjU1JQbTBuT0M0bk45THB6aFcyVHZ1SWtWN1QwbFVSMVFtMDZtc2RJVk52?=
 =?utf-8?B?Z3pkRzZaWmtRRnNKaTVmRTdBQnlVT0VJZ1ZMUzVkRWlrQ1hOd0VBcDRUazFH?=
 =?utf-8?B?dlhlV041VWhVbTVGekZTbzBvNloyTEIyR2Z3WTJ2aUNaN0hMeWs4dWFMOWpt?=
 =?utf-8?B?QzBhNmVyZjYvVFA0cHdpYXdoMHZYcmNGRWRoTnBYRUdJVFJ0U21tT29xanFr?=
 =?utf-8?B?TSs5aHp5RVhyVmdNVElRTU1FeS9FelY0LzdZb3RRcTVRakJPb1l2Q04vMzM1?=
 =?utf-8?B?c0Rxd1NjeVB6bFRwVDlnMWQ5eElnbzR6VEFEMFlqdDB3bzVZaEZ1T2Z4N3ZD?=
 =?utf-8?B?Z0EzRG1TSjZOeXdHRmkwK1AxTWw4ZlhnMFFZT0VoYzVWeXYrOEpoU0h0dWtW?=
 =?utf-8?B?VDBPSmw0VytFSVV0WjNKdk9Id1RBdkluTDBZUDFieDVMQnBiQ05PYndva2Yv?=
 =?utf-8?B?K1pmT1FyV2t2eEVGekFKVFMvQnlQUDh5MUtlclorT3VQK0IrcE5TUmNLMjIw?=
 =?utf-8?B?TFZTMldaN2o0QWs1RVBqYVVhMDRaNXFRRnNOamJGVDBWRVN4dDlnUk5sMG1a?=
 =?utf-8?B?TkNFT1QranFNUmRLWVI5K2x0K3VWVkZZeFBzTjVVYXZidGE3UnA3Qi9hWkMw?=
 =?utf-8?B?MW4waWtpbHNPWE9tQ0U3ajJZTVpEM3AyOXJPcjRHSEpMNWViRitZUi9UUVQ0?=
 =?utf-8?B?T0M2YUlBWTdsRDc5SDdyWkIyVWkzZWNTOVcxVk4xd1M3NEZBd2tEa1o5M3hm?=
 =?utf-8?B?MUtmendUalBEZlVRdkNZQWZVZWZNVEQxL1l3dWcwZHlFVkJYQUo2aDl0YnRy?=
 =?utf-8?B?M0xVQk9OYlk5Q2RaYUhxTURVYVVnUG9uSHl2YUhvaWNBSk5DeDN4S1VYQjhp?=
 =?utf-8?B?bVFIN2hSRTJSTWd5cEZkdXR2NDEyMjJLbVFkQ3REa2FNcjFoUFplRDVyRGJY?=
 =?utf-8?B?TlBYVU1qZ01kaEhscUozeG9BU1hQSWdVOGk5VCtuMXFWTHFVNEd1MGR3azNi?=
 =?utf-8?Q?k+Rd61EVU4sFk0b2qfUDsC+Q6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2b8403-cca7-4ffc-b0a0-08ddf51384c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:23:53.8846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eltCNWyn8c/9iPZdrH99d4exA/ltVbAwWhFQC2TSYh/eqP1Ot9ntVr3rC3m4Gjza
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
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

On 16.09.25 11:35, Jesse.Zhang wrote:
> This commit refactors the AMDGPU userqueue management subsystem to replace
> IDR (ID Allocation) with XArray for improved performance, scalability, and
> maintainability. The changes address several issues with the previous IDR
> implementation and provide better locking semantics.
> 
> Key changes:
> 
> 1. **Global XArray Introduction**:
>    - Added `userq_global_xa` to `struct amdgpu_device` for global queue tracking
>    - Uses doorbell_index as key for efficient global lookup
>    - Replaces the previous `userq_mgr_list` linked list approach
> 
> 2. **Per-process XArray Conversion**:
>    - Replaced `userq_idr` with `userq_xa` in `struct amdgpu_userq_mgr`
>    - Maintains per-process queue tracking with queue_id as key
>    - Uses XA_FLAGS_ALLOC for automatic ID allocation
> 
> 3. **Locking Improvements**:
>    - Removed global `userq_mutex` from `struct amdgpu_device`
>    - Replaced with fine-grained XArray locking using `xa_lock()`/`xa_unlock()`
>    - Eliminated potential deadlocks from nested mutex operations
> 
> 4. **Runtime Idle Check Optimization**:
>    - Updated `amdgpu_runtime_idle_check_userq()` to use XArray iteration
>    - Simplified logic and improved performance with direct XArray access
> 
> 5. **Queue Management Functions**:
>    - Converted all IDR operations to equivalent XArray functions:
>      - `idr_alloc()` → `xa_alloc()`
>      - `idr_find()` → `xa_load()`
>      - `idr_remove()` → `xa_erase()`
>      - `idr_for_each()` → `xa_for_each()`
> 
> 6. **Suspend/Resume Logic**:
>    - Rewrote suspend/resume functions to use XArray iteration
>    - Improved error handling and resource cleanup
>    - Fixed potential race conditions in queue state management
> 
> 7. **DebugFS and IOCTL Updates**:
>    - Updated all userqueue-related IOCTL handlers for XArray compatibility
>    - Modified debugfs functionality to work with new XArray structure
> 
> Benefits:
> - **Performance**: XArray provides better scalability for large numbers of queues
> - **Memory Efficiency**: Reduced memory overhead compared to IDR
> - **Thread Safety**: Improved locking semantics with XArray's internal spinlocks
> 
> Fixes addressed:
> - Resolves soft lockup issues in queue cleanup operations
> - Eliminates "scheduling while atomic" bugs in fini operations
> - Prevents potential deadlocks in global queue management
> - Improves error handling and resource cleanup reliability
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 150 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   9 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  28 ++--
>  7 files changed, 109 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2a0df4cabb99..2800ef816e51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1174,6 +1174,11 @@ struct amdgpu_device {
>  	 * queue fence.
>  	 */
>  	struct xarray			userq_xa;

We should maybe rename that to userq_mgr_xa to clearly distinct it.

> +	/* Global queue index,
> +	 * key: doorbell_index,
> +	 * value: struct amdgpu_usermode_queue
> +	 */
> +	struct xarray 			userq_global_xa;

And maybe name this userq_doorbell_xa.

And BTW it would be really good if we start to use kerneldoc format for comments.

>  
>  	/* df */
>  	struct amdgpu_df                df;
> @@ -1308,8 +1313,6 @@ struct amdgpu_device {
>  	 */
>  	bool                            apu_prefer_gtt;
>  
> -	struct list_head		userq_mgr_list;
> -	struct mutex                    userq_mutex;
>  	bool                            userq_halt_for_enforce_isolation;
>  	struct amdgpu_uid *uid_info;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0fdfde3dcb9f..4c9b4614be53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4483,7 +4483,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	mutex_init(&adev->gfx.userq_sch_mutex);
>  	mutex_init(&adev->gfx.workload_profile_mutex);
>  	mutex_init(&adev->vcn.workload_profile_mutex);
> -	mutex_init(&adev->userq_mutex);
>  
>  	amdgpu_device_init_apu_flags(adev);
>  
> @@ -4511,7 +4510,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
>  
> -	INIT_LIST_HEAD(&adev->userq_mgr_list);
> +	xa_init(&adev->userq_global_xa);
>  
>  	INIT_DELAYED_WORK(&adev->delayed_init_work,
>  			  amdgpu_device_delayed_init_work_handler);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ece251cbe8c3..d1d2fcbd4195 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2772,20 +2772,18 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
>  	struct drm_device *drm_dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	unsigned long queue_id;
>  	int ret = 0;
>  
> -	mutex_lock(&adev->userq_mutex);
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +	xa_lock(&adev->userq_global_xa);
> +	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
> +		if (queue) {

If I'm not completely mistaken that can be simplified by using xa_empty() now.

>  			ret = -EBUSY;
>  			goto done;
>  		}
>  	}
>  done:
> -	mutex_unlock(&adev->userq_mutex);
> -
> +	xa_unlock(&adev->userq_global_xa);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b649ac0cedff..c285bf927c46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -183,14 +183,18 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>  
>  	uq_funcs->mqd_destroy(uq_mgr, queue);
>  	amdgpu_userq_fence_driver_free(queue);
> -	idr_remove(&uq_mgr->userq_idr, queue_id);

> +	__xa_erase(&uq_mgr->userq_xa, (unsigned long)queue_id);
> +
> +	/* Remove from global XArray */
> +	__xa_erase(&adev->userq_global_xa, queue->doorbell_index);
> +

Those two need to be xa_erase() (without the __), since we are relying on XA locking now.

>  	kfree(queue);
>  }
>  
>  static struct amdgpu_usermode_queue *
>  amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>  {
> -	return idr_find(&uq_mgr->userq_idr, qid);
> +	return xa_load(&uq_mgr->userq_xa, qid);
>  }
>  
>  void
> @@ -362,6 +366,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  	int r = 0;
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
> +	xa_lock(&adev->userq_global_xa);
>  	mutex_lock(&uq_mgr->userq_mutex);

Wrong order, first mutex_lock(&uq_mgr->userq_mutex) and then xa_lock(&adev->userq_global_xa).

It's probably best to not take that lock here at all and just use the right xa function in amdgpu_userq_cleanup().

You should also start testing patches with LOCKDEP enabled, that throws automatically warnings if something like that here is wrong.

>  
>  	queue = amdgpu_userq_find(uq_mgr, queue_id);
> @@ -389,6 +394,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  	}
>  	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>  	mutex_unlock(&uq_mgr->userq_mutex);
> +	xa_unlock(&adev->userq_global_xa);
>  
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -462,8 +468,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	struct amdgpu_db_info db_info;
>  	char *queue_name;
>  	bool skip_map_queue;
> +	u32 qid;
>  	uint64_t index;
> -	int qid, r = 0;
> +	int r = 0;
>  	int priority =
>  		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
>  		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
> @@ -471,7 +478,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	r = amdgpu_userq_priority_permit(filp, priority);
>  	if (r)
>  		return r;
> -
>  	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (r < 0) {
>  		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
> @@ -486,7 +492,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	 *
>  	 * This will also make sure we have a valid eviction fence ready to be used.
>  	 */
> -	mutex_lock(&adev->userq_mutex);
>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>  
>  	uq_funcs = adev->userq_funcs[args->in.ip_type];
> @@ -546,9 +551,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> +	xa_lock(&adev->userq_global_xa);
> +	r =xa_err(__xa_store(&adev->userq_global_xa, index, queue, GFP_KERNEL));
> +	xa_unlock(&adev->userq_global_xa);

Just use xa_err(xa_store()) here.

> +	if (r) {
> +		kfree(queue);
> +		goto unlock;
> +	}
>  
> -	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
> -	if (qid < 0) {
> +	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue, XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> +	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
>  		amdgpu_userq_fence_driver_free(queue);
>  		uq_funcs->mqd_destroy(uq_mgr, queue);
> @@ -568,7 +580,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(uq_mgr, queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			idr_remove(&uq_mgr->userq_idr, qid);
> +			xa_erase(&uq_mgr->userq_xa, qid);
>  			amdgpu_userq_fence_driver_free(queue);
>  			uq_funcs->mqd_destroy(uq_mgr, queue);
>  			kfree(queue);
> @@ -591,7 +603,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
> -	mutex_unlock(&adev->userq_mutex);
>  
>  	return r;
>  }
> @@ -689,11 +700,11 @@ static int
>  amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> -	int queue_id;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	/* Resume all the queues for this process */
> -	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>  		r = amdgpu_userq_restore_helper(uq_mgr, queue);
>  		if (r)
>  			ret = r;
> @@ -846,11 +857,11 @@ static int
>  amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> -	int queue_id;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	/* Try to unmap all the queues in this process ctx */
> -	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>  		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
>  		if (r)
>  			ret = r;
> @@ -865,9 +876,10 @@ static int
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> -	int queue_id, ret;
> +	unsigned long queue_id;
> +	int ret;
>  
> -	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>  		struct dma_fence *f = queue->last_fence;
>  
>  		if (!f || dma_fence_is_signaled(f))
> @@ -920,14 +932,10 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>  			  struct amdgpu_device *adev)
>  {
>  	mutex_init(&userq_mgr->userq_mutex);
> -	idr_init_base(&userq_mgr->userq_idr, 1);
> +	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>  	userq_mgr->adev = adev;
>  	userq_mgr->file = file_priv;
>  
> -	mutex_lock(&adev->userq_mutex);
> -	list_add(&userq_mgr->list, &adev->userq_mgr_list);
> -	mutex_unlock(&adev->userq_mutex);
> -
>  	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>  	return 0;
>  }
> @@ -936,28 +944,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  {
>  	struct amdgpu_device *adev = userq_mgr->adev;
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	uint32_t queue_id;
> +	unsigned long queue_id;
>  
>  	cancel_delayed_work_sync(&userq_mgr->resume_work);
>  
> -	mutex_lock(&adev->userq_mutex);
> -	mutex_lock(&userq_mgr->userq_mutex);
> -	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> +	xa_lock(&adev->userq_global_xa);
> +	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {

>  		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);

That can't be called while holding the XA lock and will raise lockdep warnings.

But the XA lock is not necessary here any more since we are destroying the userq_mgr and nobody else can concurrently modify it.

So just drop the xa_lock().

>  		amdgpu_userq_unmap_helper(userq_mgr, queue);
>  		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
>  	}
>  
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -		if (uqm == userq_mgr) {
> -			list_del(&uqm->list);
> -			break;
> -		}
> -	}
> -	idr_destroy(&userq_mgr->userq_idr);
> -	mutex_unlock(&userq_mgr->userq_mutex);
> -	mutex_unlock(&adev->userq_mutex);
> +	xa_destroy(&userq_mgr->userq_xa);
> +	xa_unlock(&adev->userq_global_xa);
>  	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  
> @@ -965,25 +964,24 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	struct amdgpu_userq_mgr *uqm;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	if (!ip_mask)
>  		return 0;
>  
> -	mutex_lock(&adev->userq_mutex);
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +	xa_lock(&adev->userq_global_xa);
> +	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
> +		uqm = queue->userq_mgr;

>  		cancel_delayed_work_sync(&uqm->resume_work);

Same here. Any *_sync() function can't be called while holding the XA lock.

When exactly is that called? Only during suspend when userspace is frozen anyway?

If yes you don't need the xa_lock() anyway.

>  		mutex_lock(&uqm->userq_mutex);
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -			r = amdgpu_userq_unmap_helper(uqm, queue);
> -			if (r)
> -				ret = r;
> -		}
> -		mutex_unlock(&uqm->userq_mutex);
> +		r = amdgpu_userq_unmap_helper(uqm, queue);
> +		if (r)
> +			ret = r;
> +		mutex_lock(&uqm->userq_mutex);
>  	}
> -	mutex_unlock(&adev->userq_mutex);
> +	xa_unlock(&adev->userq_global_xa);
>  	return ret;
>  }
>  
> @@ -991,24 +989,23 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	struct amdgpu_userq_mgr *uqm;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	if (!ip_mask)
>  		return 0;
>  
> -	mutex_lock(&adev->userq_mutex);
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +	xa_lock(&adev->userq_global_xa);
> +	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
> +		uqm = queue->userq_mgr;
>  		mutex_lock(&uqm->userq_mutex);
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -			r = amdgpu_userq_map_helper(uqm, queue);
> -			if (r)
> -				ret = r;
> -		}
> +		r = amdgpu_userq_map_helper(uqm, queue);

Same here. Don't call xa_lock() at all.

> +		if (r)
> +			ret = r;
>  		mutex_unlock(&uqm->userq_mutex);
>  	}
> -	mutex_unlock(&adev->userq_mutex);
> +	xa_unlock(&adev->userq_global_xa);
>  	return ret;
>  }
>  
> @@ -1017,33 +1014,33 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	struct amdgpu_userq_mgr *uqm;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	/* only need to stop gfx/compute */
>  	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
>  		return 0;
>  
> -	mutex_lock(&adev->userq_mutex);
>  	if (adev->userq_halt_for_enforce_isolation)
>  		dev_warn(adev->dev, "userq scheduling already stopped!\n");
>  	adev->userq_halt_for_enforce_isolation = true;
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +	xa_lock(&adev->userq_global_xa);
> +	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
>  		cancel_delayed_work_sync(&uqm->resume_work);
> +		uqm = queue->userq_mgr;
>  		mutex_lock(&uqm->userq_mutex);
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> -			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> -			    (queue->xcp_id == idx)) {
> -				r = amdgpu_userq_preempt_helper(uqm, queue);
> -				if (r)
> -					ret = r;
> -			}
> +		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> +		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> +		    (queue->xcp_id == idx)) {
> +			r = amdgpu_userq_preempt_helper(uqm, queue);
> +			if (r)
> +				ret = r;
>  		}
>  		mutex_unlock(&uqm->userq_mutex);
>  	}
> -	mutex_unlock(&adev->userq_mutex);
> +	xa_unlock(&adev->userq_global_xa);
> +
>  	return ret;
>  }
>  
> @@ -1052,21 +1049,21 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	struct amdgpu_userq_mgr *uqm;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	/* only need to stop gfx/compute */
>  	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
>  		return 0;
>  
> -	mutex_lock(&adev->userq_mutex);
>  	if (!adev->userq_halt_for_enforce_isolation)
>  		dev_warn(adev->dev, "userq scheduling already started!\n");
>  	adev->userq_halt_for_enforce_isolation = false;
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -		mutex_lock(&uqm->userq_mutex);
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +	xa_lock(&adev->userq_global_xa);
> +	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
> +		uqm = queue->userq_mgr;
> +		mutex_lock(&queue->userq_mgr->userq_mutex);
>  			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>  			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>  			    (queue->xcp_id == idx)) {
> @@ -1074,9 +1071,8 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  				if (r)
>  					ret = r;
>  			}
> -		}
> -		mutex_unlock(&uqm->userq_mutex);
> +		mutex_unlock(&queue->userq_mgr->userq_mutex);
>  	}
> -	mutex_unlock(&adev->userq_mutex);
> +	xa_unlock(&adev->userq_global_xa);
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index c027dd916672..77125bbe3abc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -88,11 +88,16 @@ struct amdgpu_userq_funcs {
>  
>  /* Usermode queues for gfx */
>  struct amdgpu_userq_mgr {
> -	struct idr			userq_idr;
> +	//struct idr			userq_idr;
> +	/* In-process queue index,
> +	 * key: queue_id
> +	 * value: struct amdgpu_usermode_queue
> +	 */
> +	struct xarray			userq_xa;
>  	struct mutex			userq_mutex;
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
> -	struct list_head		list;
> +	//struct list_head		list;
>  	struct drm_file			*file;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 95e91d1dc58a..32625079042d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -537,7 +537,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	/* Retrieve the user queue */
> -	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
> +	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
>  	if (!queue) {
>  		r = -ENOENT;
>  		goto put_gobj_write;
> @@ -899,7 +899,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		 */
>  		num_fences = dma_fence_dedup_array(fences, num_fences);
>  
> -		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
> +		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
>  		if (!waitq) {
>  			r = -EINVAL;
>  			goto free_fences;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 2db9b2c63693..0794bbb944ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -205,9 +205,9 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>  	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
>  	struct mes_detect_and_reset_queue_input input;
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
>  	unsigned int hung_db_num = 0;
> -	int queue_id, r, i;
> +	unsigned long queue_id;
> +	int r, i;
>  	u32 db_array[4];
>  
>  	if (db_array_size > 4) {
> @@ -227,20 +227,24 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>  	if (r) {
>  		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
>  	} else if (hung_db_num) {
> -		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -				if (queue->queue_type == queue_type) {
> -					for (i = 0; i < hung_db_num; i++) {
> -						if (queue->doorbell_index == db_array[i]) {
> -							queue->state = AMDGPU_USERQ_STATE_HUNG;
> -							atomic_inc(&adev->gpu_reset_counter);
> -							amdgpu_userq_fence_driver_force_completion(queue);
> -							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> -						}
> +		xa_lock(&adev->userq_global_xa);
> +		xa_for_each(&adev->userq_global_xa, queue_id, queue) {
> +			mutex_lock(&queue->userq_mgr->userq_mutex);

Same here. You can't lock an mutex while holding the XA lock.

Regards,
Christian.

> +			if (queue->queue_type == queue_type) {
> +				for (i = 0; i < hung_db_num; i++) {
> +					if (queue->doorbell_index == db_array[i]) {
> +						queue = xa_load(&adev->userq_global_xa, db_array[i]);
> +						queue->state = AMDGPU_USERQ_STATE_HUNG;
> +						queue->state = AMDGPU_USERQ_STATE_HUNG;
> +						atomic_inc(&adev->gpu_reset_counter);
> +						amdgpu_userq_fence_driver_force_completion(queue);
> +						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
>  					}
>  				}
>  			}
> +			mutex_unlock(&queue->userq_mgr->userq_mutex);
>  		}
> +		xa_unlock(&adev->userq_global_xa);
>  	}
>  
>  	return r;

