Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2412C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB2010E0F3;
	Thu,  8 May 2025 05:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xdifMfcW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F2710E0F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxjQ/KMQ9cm7bA7QQwdyt5RmefAF2hLztj8Si+hY35SkTHGppgC16tDM/DdWinCjAN5J4owj5xIvnV6L1BSPKFn05o3pedjrXVFFQ/Aeth9vgXN2ugHNy+n0/Da+r/GHYl98ComP7y0albu0oxIRbw3M78KiltbWy0aPfiqzCsaL9lZD1YoRFbJdJiyrQQSlRWVejn5bQom+yaFAtILF5td7Lq0+RPyBkm7oIPUkI++TUkNe4uY3MHxrDsx3V4zYkISnk7d8PryqqBLjn5sll9YnN7qmT8fRnFczjFEKujQutqlwLWMdi47Qg3U4kVTL6gBND1dJkduENDUMUGeWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw0Pzao349U+yALBiSqTIDPj7xxb2LU8eqhxy5x/o2A=;
 b=x0Qb/K+F9orCFpDYI9hXO7udnpphf4KoPqPPsFW+oRXIgRBtwAh3CYy2zJ/XalIugLCP/R9BBpEKKBq+hD5ro41Ejqhmh1lq/1sh93QQ96gycy5kOhdhOGJ8pYllcEKZmWbbIYSiNZ2BZxoaBA08pwrgO5svIRwaOLECNQXV5M23g5i1JUOxZQY7+x4NzVKOoJ56JkupU4Ur3Y0vQ6+SEh9ZiIRizvJjht5Il8xHFxIlpqW1IKUbSGNwzrHLy/y7TqgHA+/i62iLlkbfjKsY4DlnxS+3M3G5aq7ti8mYN8FIWYjQlckfHNQ+c/rKbdM+ti0+L0Kc2GkFpUtIoJMAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw0Pzao349U+yALBiSqTIDPj7xxb2LU8eqhxy5x/o2A=;
 b=xdifMfcWN6EX5gV5c37YDk1Ove0OACzhAFs7l8MQHxMPPK3EBmAqC1EYJpG++wa7nPxMioay5HLy1mqOgqAYcnGaScdVumcXPabJxvVrO7PFIaWpBC6ItQSxqou6R+vsFgzAJXXwsl5gN/FRGtNqOqZ6m1kKt6kaV/Zh1a9LwtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 05:04:14 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 05:04:13 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
To: Alex Deucher <alexdeucher@gmail.com>, Arvind Yadav <Arvind.Yadav@amd.com>
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com,
 sunil.khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20250507183722.76789-1-Arvind.Yadav@amd.com>
 <CADnq5_N0m738JXJDzRkdZum=KteV_jTYixXQ4SCYGs-43NdhLg@mail.gmail.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <b5486ff8-171a-b02a-357f-04da917299b2@amd.com>
Date: Thu, 8 May 2025 10:34:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CADnq5_N0m738JXJDzRkdZum=KteV_jTYixXQ4SCYGs-43NdhLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::11) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: c320d2ef-e7fe-47a0-50af-08dd8dedc676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmlaUjlpMXhYdTZaalZGZzNuQU91cEtPaEdDOVNYRjJ6Uy9FNzd2dXNlaHFY?=
 =?utf-8?B?dFJMTHFGcG52cC9hQ0ZOVDBKNEVReW1LbWFGSy9ZbXM3d3l0VUZaMEg0V1kw?=
 =?utf-8?B?QXhJQWIyTXRzSmtuWmEvOXdkbmp3RHErVEhIYS9iZGhuUmtubjJjQ2d2UXdi?=
 =?utf-8?B?K2Y2NGVjc2RGbEZhemltTkVHc3dZbmdLcjN6OUpVNTg3eFJPOE5USTdzQVRy?=
 =?utf-8?B?RUF0N28vTTVMVEQyaml4aFA1Njh1NnI3MFRmWXh4SWhPR0NTYjZuMW1sQkx6?=
 =?utf-8?B?NXpuMGoxcE1LcGc4cmxSRFNyaUJjVmVsZmpETnVTTjA4bUhWOWppSThrMVVF?=
 =?utf-8?B?WVppbEpjK01wU0RQT2pPOUdaN1lzeVJyT2pua1VaOUZWR2d3QndGNk9jL1dy?=
 =?utf-8?B?V1ZoRElETWhuL2x4SGRSdlRidU02OVRqZlZ3VEROVXlxNEx3aTMvMEw0MWhj?=
 =?utf-8?B?VytJeGZYcWVZN0ZUazdOZlRKTWZYUTh5ZGx4VHNEK3JZK1JJRGZIeERTUGlP?=
 =?utf-8?B?N0xmTzRTUW15R0tPUHpNREpYa3k3Q1dYeE9lRmdndFFvdWpTWGMrcHJqU0dB?=
 =?utf-8?B?UDRIZ2FkdHdUWlVyQnpnQ291eUVQSlVOcU9LMXUvTTl4dFRhU2VwYnVOZTFz?=
 =?utf-8?B?QUhHY0h5YTh0c250SWx1Q0VxUFdwVTdqcGRmT1FxUkZSeXhGV3VLRm84S3lu?=
 =?utf-8?B?R0dXOXZYR3ZLaHJTeFNYNjhPblJZYUhwQTZocVArVFN2dEUxc3ZlVXVyUkNk?=
 =?utf-8?B?OWFBTDVyTlZLL1pXc0JBWWVTQ0gxVm9tV2F5a3Q0N0x1MEFjRUlDUEI4OGNj?=
 =?utf-8?B?ZW1MYUJsUWhEV05jQnVDUE5IWTRncWpCMnhESzNDQTAvQ0Yxem54Y3lrcS9H?=
 =?utf-8?B?elBjeHpCbkVPd3V0bWhPTkh4d3hIdkh2Y0ZPN2phMEV3dzFCMkVCVGI1VlYr?=
 =?utf-8?B?QWVqU2ZEOXpCenluQXp0MWpQanlZb3pOcitZMHl4dHcvcGhBRUZXWW9aWlVZ?=
 =?utf-8?B?amZ1TVZCNkZzdU5PZUdoMkFTUzlPU05HRWc4WitLcUFwQjJET21vYTNnNjh0?=
 =?utf-8?B?elI5YmVzaWErU0dJUE5RcUNwSzJnVFBwekdXeWZETUY5VytRbzlVZ3lTbTJQ?=
 =?utf-8?B?RzlUTXA3dWpMUDlXR2NuYThUelAzWUhWWkd3dzRXNHcxSUF0SHVGR1J5NVhk?=
 =?utf-8?B?ejd5TE16NFpBNE8raEtFb0FVU21qUVk2ejdtbHcrWHNzZVo0VDB2SWZpTHRG?=
 =?utf-8?B?UGtqZXM3NTJtRGVqblVHNUd0TFhObitiWG5uZjdnb0JWRjd1ajZPWk5ISFhX?=
 =?utf-8?B?cTJsbDZ5YzQ0WU1HSkhOQURmdTV5dXg4OUxHVG1TY05GbU9zeXE5N3lSU1BH?=
 =?utf-8?B?MHBnMGpTYkdEcXBhMmo3RFBnMVVnTGRJMWZSL2ZaOXhkSXFUSmc2UFlrTUNi?=
 =?utf-8?B?bjhJbzFGMDBxckhDenhtUS93Sis2TTltdVh3RmFTdG5hSUR3RmtaNjJNaDVJ?=
 =?utf-8?B?MTVzWUx6bjBCL1JoZ2RyazErM2xuYWZNQ2RqSXJ6clM3bnF2MDFLbE1tZVRo?=
 =?utf-8?B?eG1lVXNHb29SeTA1N3RtZ2NieWRpbVg2eGpYYU4wVEtxTS9RVmFsNHRyN1g3?=
 =?utf-8?B?Z2FwWnpRU2xZU1l6ZjFFMG16TGtlTXdINUI1M0p3TFVoNndDblpUdHVqR0w4?=
 =?utf-8?B?cUl0Zmc3RTZwS1ZOZzY5a1V3dFJjdi8rUFJoOE93K3hJcVJHMkpwZnc5Q2dz?=
 =?utf-8?B?bFJFVnk3K0FRejFpWExPSTVkVzZKbGhzd3Y0V1l3Ly9oazFtc0ltdm5INW5i?=
 =?utf-8?B?Wm94V2tpY0d1WkROb1RGWnMvbFFUY2d6N1dkSVFpdGlLblJLZDJNRWlPbWFW?=
 =?utf-8?B?OC8wYkhHZm9aN0hvdHlyYVZGRStmY3ZhWlhKUVVpQ0tFbGJicXNST3RCWDFj?=
 =?utf-8?Q?7gZXknaXN40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkRTaXY4RjRTc0Z5TUJCeW9MWHJYckhzdmc2SmpJRnJMSXNJZjJFTmpjSEE5?=
 =?utf-8?B?aWxKbzFHQVBLS3NzS01NbmVBU2JDdFlBa09nd1gzME1EUVloTmpKbnd5dXFm?=
 =?utf-8?B?Q0EzdTBUK1d1c09FbVliSTJ6cml3MFVHbldHTlN4aGxVSVdCbU1FbnAzOWUz?=
 =?utf-8?B?V1VwZ3ZPenJabExjVnZOZWd2SzlWM1FtTWlQeHRTcXlTQVMwNnlQR1I5NDMx?=
 =?utf-8?B?YmRZay9TZVVVR2tmSzQ3dzhKWDVUdDNIaFBoVnNNc2wzN3NhTW9ySU9kU2hv?=
 =?utf-8?B?dHR1eHZWSXN0c1liVXN4SkxMeWY0Qm5EZm9oVmxQVlptb0ZFcTJIU1lXWkh2?=
 =?utf-8?B?Tk5nU3c4SEMyQStYZ2x2ZTdiZ2V2Ti9hSzV2b09XVFJMOUxvWVNhMHcra3lq?=
 =?utf-8?B?aHhBMTFtQjl4VEdIK3RhZ05UZXZGeFAzcGd3ZTRQYzZSejVsbyttSjJhUXNG?=
 =?utf-8?B?ZjBGVlRXaEtrRVRlbDVsTnZtYkRsb012TVZmOTJ5QU9QZUR4dGRWQ3F4dzJL?=
 =?utf-8?B?UmVZU25DNFJLZWxOYUtONFZSMGp0TVFmM1BtMys2UEttdmJyNlI1YlNxRjRw?=
 =?utf-8?B?czBjS1EyWmgyL2RiK2cxclgyUzlYa0JKaDBXamhVejJrV2E3VWhhWXVmL1ph?=
 =?utf-8?B?Q3BrejE2WSt1ZkxUK1VMd1BpaUZuNk5SL3Vma2lOSm9ZTVZkazgralZFY3RL?=
 =?utf-8?B?bXhReDJuVVM4YzJUMWxOWVI3RDV6QVJMSEhUN3JnN2k5WmxuYTIxUTdzaEZC?=
 =?utf-8?B?MDlIRWpRVE9mYlo2bkljOXpBbm9kNTN1TUtoNHJpL3lETnVQeHMxaU5HRlRq?=
 =?utf-8?B?VndvcjB0TzkyV3ErTTIxTHhRWjBqQTBGNDBVVWdMd01sdUJuQnNWaEE5TnpT?=
 =?utf-8?B?b2txVERDdVdxd05XUXBQYk5uZURpbFdGeDhxd0hMdkNoMUJ6WlNhbHcvU0dy?=
 =?utf-8?B?cEhTTDZJZGVzbVNjOStqRGhNTXAzOVdyVmNIanpwSlVHZVY5ajFtU2ozUFYw?=
 =?utf-8?B?NmtsQmRYcWFYQm9VUWNGQmZOWXFIWXJnc3BCNnBreUVIYVdnUHNVeWR4U0N1?=
 =?utf-8?B?UlVLSzk5VGppenNtWkVXNVU2TlZVSENLamNzOFcrYnZZakorOE93cHRBT01u?=
 =?utf-8?B?Q1lSaHd5SnU1eVE2V1dXdm1hdHZoZzJZOGdNd0IxMUtsZlZCYkc2b3dOYXZk?=
 =?utf-8?B?WWNobUNXUUltMzJzTmdNM3pzNU1XRGNoUWw2N1hlUldxbHU0a0dDMnBNNUgx?=
 =?utf-8?B?NWJ1em1KMWJvWjZEb2NXM2ZtT1p6WFpwUS80YXpWM1pHaEc2YVU3K1R6enBL?=
 =?utf-8?B?c29WbnE5Q3hSeGVXdml3TzkwQk5PdE8xNTkxVkR3eXIzNll0d2g0bThQaE54?=
 =?utf-8?B?Rm5UVHdqR3BwbTg2MFp0QmROaGRLVGdSSEdGbkU0M3ZYYWdtU3hLL0ozWlNY?=
 =?utf-8?B?L1pqbUVJcWNRalhJQjhYZk9mZDArdWxiMGE1eTlPWWZtMDEvZlo3WWNhamJB?=
 =?utf-8?B?QUljZWRXYjJjSUsrYjVzQjgxM3dCajIvWFFkMkNoMzhzRzdxVHRFdndPaGp4?=
 =?utf-8?B?c3I2Q0s2dnNMc2NHb1NMcnlZRXJvTFZXZE5jRlFsL2xtdE9WNVY5NzFORWxD?=
 =?utf-8?B?UmtLVi9CQ212MS9UV1JDSlhJMEpFc25UVDdXU0h1NVdqZytSMFRqdXhJOXAz?=
 =?utf-8?B?K1pTVjFRNFYyR3JJZWtUTXZjd3F3NzduVmdnN2dpZ2tHR0Vqd0ZNU0VjWHdF?=
 =?utf-8?B?bm5jSUlnYnNWRWh4T0JvUlN6U1IvajlZY2UvakFqc3FmUWRCbGVBUENhclZC?=
 =?utf-8?B?Qk8rTjBhMXdmZXBvV1BXS1p0VjBVT25CRnczQ0FGSUlaV05JN29pV3Vnc2Iz?=
 =?utf-8?B?ZlU3WWFXQ1Jyb0JqQWR3YXlKazB4V3hHN0RpU2I5QXZsb0FMSkZtNSsrd3JF?=
 =?utf-8?B?dzVTYU44NXFmRjZaaHRsWTQvR2JrOGpSdWJZWUdiR3VGR3M1RmdaSFJJOWkv?=
 =?utf-8?B?VUtUVWVpNG51RVNRc0xsbVVBRFppeEVnMnFKRGV1a1kwdkxqREw0bUR4VjBw?=
 =?utf-8?B?SzV1c3dPTnIwOHkweTJVWE1wSHM2ZENHRHFadFFmVnBFOWNVUDZnclYyYXhs?=
 =?utf-8?Q?nhDfoxWwl003yLxT4QtdfDR4h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c320d2ef-e7fe-47a0-50af-08dd8dedc676
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:04:13.6165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qqGeZvi1xoTqJEaKivLC09N5B1JZ47hQWVcJvkCeFDKKPGLF/EjsEIMKn33TB1Czk1pxsUpmORvTKIG58x/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
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


On 5/8/2025 12:36 AM, Alex Deucher wrote:
> On Wed, May 7, 2025 at 2:38 PM Arvind Yadav <Arvind.Yadav@amd.com> wrote:
>> Switch cancel_delayed_work() to cancel_delayed_work_sync() to ensure
>> the delayed work has finished executing before proceeding with
>> resource cleanup. This prevents a potential use-after-free or
>> NULL dereference if the resume_work is still running during finalization.
> There are several other places with similar patterns that look
> suspect.  E.g., amdgpu_userq_destroy() and amdgpu_userq_evict().
Noted, I will do the changes.
~arvind
> Alex
>
>> BUG: kernel NULL pointer dereference, address: 0000000000000140
>> [  +0.000050] #PF: supervisor read access in kernel mode
>> [  +0.000019] #PF: error_code(0x0000) - not-present page
>> [  +0.000021] PGD 0 P4D 0
>> [  +0.000015] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>> [  +0.000021] CPU: 17 UID: 0 PID: 196299 Comm: kworker/17:0 Tainted: G     U             6.14.0-org-staging #1
>> [  +0.000032] Tainted: [U]=USER
>> [  +0.000015] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F39 03/22/2024
>> [  +0.000029] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>> [  +0.000426] RIP: 0010:drm_exec_lock_obj+0x32/0x210 [drm_exec]
>> [  +0.000025] Code: e5 41 57 41 56 41 55 49 89 f5 41 54 49 89 fc 48 83 ec 08 4c 8b 77 30 4d 85 f6 0f 85 c0 00 00 00 4c 8d 7f 08 48 39 77 38 74 54 <49> 8b bd f8 00 00 00 4c 89 fe 41 f6 04 24 01 75 3c e8 08 50 bc e0
>> [  +0.000046] RSP: 0018:ffffab1b04da3ce8 EFLAGS: 00010297
>> [  +0.000020] RAX: 0000000000000001 RBX: ffff930cc60e4bc0 RCX: 0000000000000000
>> [  +0.000025] RDX: 0000000000000004 RSI: 0000000000000048 RDI: ffffab1b04da3d88
>> [  +0.000028] RBP: ffffab1b04da3d10 R08: ffff930cc60e4000 R09: 0000000000000000
>> [  +0.000022] R10: ffffab1b04da3d18 R11: 0000000000000001 R12: ffffab1b04da3d88
>> [  +0.000023] R13: 0000000000000048 R14: 0000000000000000 R15: ffffab1b04da3d90
>> [  +0.000023] FS:  0000000000000000(0000) GS:ffff9313dea80000(0000) knlGS:0000000000000000
>> [  +0.000024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  +0.000021] CR2: 0000000000000140 CR3: 000000018351a000 CR4: 0000000000350ef0
>> [  +0.000025] Call Trace:
>> [  +0.000018]  <TASK>
>> [  +0.000015]  ? show_regs+0x69/0x80
>> [  +0.000022]  ? __die+0x25/0x70
>> [  +0.000019]  ? page_fault_oops+0x15d/0x510
>> [  +0.000024]  ? do_user_addr_fault+0x312/0x690
>> [  +0.000024]  ? sched_clock_cpu+0x10/0x1a0
>> [  +0.000028]  ? exc_page_fault+0x78/0x1b0
>> [  +0.000025]  ? asm_exc_page_fault+0x27/0x30
>> [  +0.000024]  ? drm_exec_lock_obj+0x32/0x210 [drm_exec]
>> [  +0.000024]  drm_exec_prepare_obj+0x21/0x60 [drm_exec]
>> [  +0.000021]  amdgpu_vm_lock_pd+0x22/0x30 [amdgpu]
>> [  +0.000266]  amdgpu_userq_validate_bos+0x6c/0x320 [amdgpu]
>> [  +0.000333]  amdgpu_userq_restore_worker+0x4a/0x120 [amdgpu]
>> [  +0.000316]  process_one_work+0x189/0x3c0
>> [  +0.000021]  worker_thread+0x2a4/0x3b0
>> [  +0.000022]  kthread+0x109/0x220
>> [  +0.000018]  ? __pfx_worker_thread+0x10/0x10
>> [  +0.000779]  ? _raw_spin_unlock_irq+0x1f/0x40
>> [  +0.000560]  ? __pfx_kthread+0x10/0x10
>> [  +0.000543]  ret_from_fork+0x3c/0x60
>> [  +0.000507]  ? __pfx_kthread+0x10/0x10
>> [  +0.000515]  ret_from_fork_asm+0x1a/0x30
>> [  +0.000515]  </TASK>
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index afbe01149ed3..711e190a6a82 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -774,7 +774,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>          struct amdgpu_userq_mgr *uqm, *tmp;
>>          uint32_t queue_id;
>>
>> -       cancel_delayed_work(&userq_mgr->resume_work);
>> +       cancel_delayed_work_sync(&userq_mgr->resume_work);
>>
>>          mutex_lock(&userq_mgr->userq_mutex);
>>          idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>> --
>> 2.34.1
>>
