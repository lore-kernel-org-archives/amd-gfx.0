Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEE2F531C9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 19:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65B810E521;
	Mon, 13 Apr 2026 19:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H59sw1XB";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F8B10E521
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 19:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQqlWCp+k1pkJpAIX/P3esBhO0uFGlNm8dmcTHGnWrhjtDheSAIxghBMva1GQ9m9vnadOALuQArKhIpCwRt/DqpCA6MlsTovwG32soGBKqxNlQDnu431afg+cwVBr7OxHdBGQPeGwzmlG2Qo58aaT4s3TqI3XSe8LyWI03fA98TPr8hU/3Up+ZYcAGnwZfGff0j1ZCCLiNy7e/CkNnk6ZoxTa21ct2u4Kz47JDjX1w0iNnVErBE7IhyciQWH3+TfamUXg7XUR50wIW12FlA+g7eex40jV5OOw3weKEdc+6U2CASJ5Zpy+63i1QPUY86TBU58squA6bU7dl6bYsFeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1NxshYOf6YNKgSXOp6KFFL+DtQVguoI5sKY+YsnLpQ=;
 b=hnP9lIGYzQVggcxD4YVB6bKVl+jPsj7ww7hojy4bPVVJq32aiiUjhkUMDH4r2YzZWUzu448keT0dALebaQZfDAenLh6b/7/EvVLH/DN6DbS7nPVyQd9wZCynX/kD4QD06+ZVOS+/xfw1yFClWhBchO7CPiGw9XgxCRtz7ED0p8sAN+6+GXsQhbgjFMDf8cGLmAC0jUbX6jYPvLHFX1MU+4p3VPryy3m6Yr8b762I2NI7nHiGeQOzzQ7pjZogD/jhdnKRgwZ6jARcOO2pkzXhOMJe9Pr1t1Tt7A1+P/bQUW+wxEVPPdQk2hcR4G2oVzxSUBEHuyRcEAs2YfPgZC8eQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1NxshYOf6YNKgSXOp6KFFL+DtQVguoI5sKY+YsnLpQ=;
 b=H59sw1XB4lkef9hHIUZT/wJg00c+o7GpPG9NiofpPidoOTVbOsfY9Vr6ohdqTP4wGTG0YxnKNBumPjaq9PTAn6pwmzDawVjcVWQ1efAVP3Ynh8PxcoKKQTSL/EnqOLunTHM/dTjlafACvz1qQ42t6NAJFHwASvrXogOSAM0bJRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 19:32:14 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 19:32:14 +0000
Message-ID: <aad023d3-eb89-4a04-b31a-5d7e181677ec@amd.com>
Date: Mon, 13 Apr 2026 15:32:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] add SPM profiling feature
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Bing.Ma@amd.com, David.Francis@amd.com
Cc: Jesse.Zhang@amd.com, Jenny-Jing.Liu@amd.com
References: <20260324212030.822932-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0252.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::24) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e60167a-175f-434f-3c55-08de99935d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: NbcomPGiX3rJ8KSek0Sb9npOY+RX/9PLISnIVw1PNuGMlk7n+DV5PQhDtQRUEjx3mlCoyaNbmRHcZ7zuDiCH+BXFf/gvsF1RPC01TUVrLOZFz3BMO3ZUHKcBCU1h1a3pVqI8S/nuAFlnHuc4cXX+DLdt9qeLUZzGtGcC5gJvHAc4dlKBqizxrMdDqLrGpRk/RzD5NaNtO0lf2JY/SkcKJiVp8sbves0iyv1eHgtxxYJBVp3zrjUvpzwrjKJeEpQXe2k0cxuUU4YT77NP2lZw4FgFDS+FhtpuE7pXFWANJ82U9BddSdnR53dILEKPtb9ZcOBOi3x7G0vFTmS7nzIuokCQhqhXhI06lSWTTbMhuWt32tlrlcB49tJLV846W/XF/MfG1cnwNY11vdCMTHpiNB6Z8CgI8YeuAkNm0oTqrUY/J2A4q9ahy3yIUOS+tMAzYMSeiuIxEL0YFIB33fIoMy/jAu7XboJV2mmfHpobvfKQ5OcHN1K0Jrz9E6e7ieRu7Ug50z0tsgWNcQstUBVgnj0uIhW3rL5jtN5YP1w0zmrZOqy1z+bE01EeSlqUXwq17iixRlVqQupvsU/3qYVSCgnLJ6jbgvzJs3dWumG0mgYYIOeqe1oMVj9sZHcUoaDvOEq07141TqwdMKtCJMSvpyh37FiM1CZlFigAtI2z0T+9mJBJ3WGPc/sA94H/SiUnlQorB7bj7S10mQqNs9ZwvSniJ20WtP/ML5uihIr21zQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0dSM1Rjb29mOWtwY2J6aGdPVUhKQWxlTHBodnNKa3F2SVg2T1B0dDBhVnNR?=
 =?utf-8?B?T3FSbDhnYTY0TThlc3dTRW9NYncxUFNEd0ppM3JCaEZyOWRROStLZi91bndl?=
 =?utf-8?B?V1VMUFBVcmlhZ1R3YzJ2NFp6bUViL3d5RElrYm4wVGgrU2dDdW1BQVMzZ3hT?=
 =?utf-8?B?cDBQd2YwT2YzaXczVzlLNGR2RWtnaWRyMFdwT2RJd3hkRldldjhLdkdjTGJM?=
 =?utf-8?B?OHJYU3hMQlZBYmo3MFVSWFZGTXZtbysydDIxNExCU1Iyc1ZmeFBNdklDTmtE?=
 =?utf-8?B?OFY5czJuSjNzZGdJR0pSUHNHRnp4UUtEN2VTU3ZZL3NjYzc2K3JacE5EU05U?=
 =?utf-8?B?RkFlVlA2SkdaVFFqT0cwb3RZc1dBQk80V0pYMzJJRk9WdVVoVWpNNm1mUExv?=
 =?utf-8?B?ekJEcTdsekpybUhNbmFmY0d6OTRFb0tqSkdXckJXR1Z3bWJ4ZU1IOGl1SjFV?=
 =?utf-8?B?UEx4WTNvb21xV3c4SVh2bUZORGt5aXhrV0taWGRGT1BjakNzS0taMzBsTEpK?=
 =?utf-8?B?cHJ2cnlHUEQzM2JYTlFpeHU0YjFvTFhEYzEzeUdINCt1ZzBKOVhtcjBjbCtC?=
 =?utf-8?B?U3l3UW8xUjVId2t5OHc0cnhmaHRYbW9lOUxFeG44dGV2UmhTZVUxTVNSb25l?=
 =?utf-8?B?SzluWnFSU2JJVXIwYVJXKzl2N3prdDFsSFRSdkVwSTVFeXlCeEduS1ZGYTZ0?=
 =?utf-8?B?dUZsOUlqQ092RTBlaWZwOTBtRnJVakNwd2VEeVFZN1RvVVZma2RhMncycFJ0?=
 =?utf-8?B?d1FZWEJKODlYYUZpSUYrZU02SlJYTnZGdStuMG1EbUJMbGNZU2gxemZnRWcy?=
 =?utf-8?B?OHB1a2VFRzBqQjh2aTlicmkyNEtZTlI0VmRvMU9zVGdzbDVJOE1tODNjaE1Y?=
 =?utf-8?B?Y0EyTk5hL2N3M0RFODhWUjN5aVhtMHFmc3R1c2VkaXRhSjdTQjJkWVlxd2Nl?=
 =?utf-8?B?SDNYSGVWRWhpTWprMkViOEYxWTVFU1BYMnF2MUpwd20zYVdHSnpnTE5BYWYv?=
 =?utf-8?B?RTJGNlFBcC9Lc0h3Umdka2ZvWFFnZm83YSt5RW9BRVF1KzNEVWdNcWhhLzdS?=
 =?utf-8?B?Z1llTWNrNXZ5eUF0MWVXN0IwREdOc0dJSWhuZmJ0a2R6RC94Y0FFYjRFWnJl?=
 =?utf-8?B?RlJmMkZNQTFRYjNmdkxOVlE3eUU3OGYydG51cmFHcVFRWTdUaWFaZWowTnNR?=
 =?utf-8?B?MEtOZFJZWTlTQ1Q3azVtR05rQjB4NzlONW9lSzd6VG1OaTVtRmEvNGxueVRS?=
 =?utf-8?B?YXR6TkdFMVlTWXNhYjJPcCtNQnpqNzFxcmp3YWFVNkc5OC9WTytRdGFIM0xS?=
 =?utf-8?B?SGV6bGV5b1pySitBZmhYOGEvV2NZbUZuQkYzR2VpekxGZ2pxL2hpRHRGalVy?=
 =?utf-8?B?bkdXeHkzV0J2VEZmUGRkQ0l6Z1BKR05NdDhwUCtmSWhObFlQZUFjTzY5alRm?=
 =?utf-8?B?WWUva3BkQ2R1TVQwOFNUVVN2Q1YwdVNLNDNUZjN3K2hUQ1QvcUlZbzNHakpN?=
 =?utf-8?B?QWJWNEN1Z0srb205aUtrTzFsRFZPeEpDSHR6YW9UVEcwTDVmSlFrR00xMHMv?=
 =?utf-8?B?ZW9TOFdGdGtWTjVUbWNFemFEQmdJaGh2TnB3d1krV3FRQjEyelh1RzhVT0ow?=
 =?utf-8?B?dUZha0sxLzEvdEp2UGFiUjdQSmNaM25VU2IrSUUxWWJ2NlZZOXNwL0I5dkE1?=
 =?utf-8?B?KzkzTk41dGkvU1Y5bHlmYy9wRWRlcFo1bCs2RXZmcjlRa0hhVGNPaFVzVjFq?=
 =?utf-8?B?RWZ4TXQvdmYyM3VaSXRKOTdXUXI1UmVOK0JiWEFjUG5LRWlkSW1vYzFjOXVU?=
 =?utf-8?B?Y3RqZTJ1RlJyeGo5OUVLelkvSytkeWRxY1RrMjl1MVR3cWhFNGg5bWlVTDJB?=
 =?utf-8?B?RGNwSlFmNnR4ejNmQkYvcHdPK0phdEFOOC91TXVCL2M1SkFMdE1ueXYvVG96?=
 =?utf-8?B?dnUxc3ZLYUVQMmxaMDQwVHp3WXZtTjRSNGRnSmlMcHgxZ3M3ejlFVzVudzJG?=
 =?utf-8?B?Q0dTQzB3MVdvYTRybkJsWjhTcEVHT25nejF3UUt2Rkc1WGlheGViMW10S2Zt?=
 =?utf-8?B?bjlZNGk3U3ArdmIxbi9xTUhnOXNhMlZRRlExemNUUGYvaWxzNFVZUEpZNzhB?=
 =?utf-8?B?dUFEMTVsY3ptOXplbFdCOUFEQ3ozVlA1U1FCVVZndEhKRDlWZmRKTzhpcDBj?=
 =?utf-8?B?eE1EcE9IQTNaUE5BRGZ2bGpIMTZ1dTJuVGd2UU5mcUg3L2pzNlFMVS91Qkky?=
 =?utf-8?B?SDRYZGFsZjNVbVJWN0o1SkpTWXZ0cit1NTZFZWlxRUgxQnhhc1NNU0VlOWty?=
 =?utf-8?Q?c4NDMJsyhfQvLzUo50?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e60167a-175f-434f-3c55-08de99935d60
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 19:32:14.4194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndWkjVqkEtVBWv7UmatxIeuEZH1N7Aj12Wy5ABcdFnG1q65tty+0HK3FuJtVdfjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
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

Ping

Thanks!

James Zhu

On 2026-03-24 17:20, James Zhu wrote:
> SPM stands for Stream Performance Monitor which can collect
> stream counters through RLC (Run List Control) Hardware block
> to profile application stream.
>
> -v2: add more descriptive commit descriptions
>       move new GTT memory alloc/free to amdgpu_object
>
> James Zhu (17):
>    drm/amdgpu: add UAPI to support profiler
>    drm/amdgpu: add profiler manager initialization and release
>    drm/amdgpu: implement profiler ioctl
>    drm/amdgpu: add UAPI to support profiler/SPM
>    drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and amdgpu_bo_free_gtt_mem
>    drm/amdgpu: add RLC SPM interface to
>    drm/amdgpu: add profiler/spm manager initialization and release
>    drm/amdgpu: add profiler/spm interrupt handler
>    drm/amdgpu: add profiler/spm ioctl
>    drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_ACQUIRE
>    drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_SET_DEST_BUF
>    drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_RELEASE
>    drm/amdgpu: implement data dump from spm ring buffer
>    drm/amdgpu: workaround for spm ring buffer overflow
>    drm/amdgpu: workaround for hw stall issue
>    drm/amdgpu: add profiler/spm support for gfx9
>    drm/amdgpu: add profiler/spm support for gfx9_4_3
>
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |  12 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  97 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 120 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  73 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c      |  93 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h      |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 703 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  77 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       |   1 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 135 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c      | 194 ++++-
>   include/uapi/drm/amdgpu_drm.h                | 110 +++
>   18 files changed, 1625 insertions(+), 14 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
>
