Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE6606A322
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IJi6zVV+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0799A10E61D;
	Wed, 28 Oct 2026 17:37:43 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010035.outbound.protection.outlook.com
 [40.93.198.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504CF10E61D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 17:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBn1XyOrDVUW3WneTiTE7hwgMORaoqHPuGH7fRNy8CZvc8dfTsS6qcP4xFSr6Bk54AzGcO4lpdJ6LoJcDMwVFb+ookWFp3kbrhymXWGm2KEpUUqu5ySY2LMnix03h/Hra5r8Sk55FQ0qpNfLq1haEJ9CLxBK9+Qagla27khuOddIOVcTIlE84UL5gMkGV3D+KtXHkaQ66y7OkIhrjsKpID15oM4vJarD9WXoCACFynZ2FGBC7jCUCxPttDklg6t3ESdCjjpL5VHu6zT2ROk0n08QgwHkvREgYdAWJStUBnbPT5T6Dd6jY721PFYYg6fw5WxVlfPwR2lN+TqqeNk+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz7yWOzMhk/UUMPeBWH1qCdk1aXyv8EB29WMC6ulIAw=;
 b=BTFVzSM9ScnPeWiq0BA0IkeYnhflofma87guDRBSfXep9lF3g8NKfpXMVpoyQw6aJGZr3eycoxo/uh3GVFErthwc+dKhBsozHm2dvilTBGgUm7tFhL3PHJH6rCoj0Try/W1tfQGjVsK9wrC1ymWvHAITAGSLaGqn3OuvHTdjsTAqdBjvhzkHD1Y56v1xvEcOveDtZ80cQbBCGFzlhxOtGswMh2LqG94uETCu2wPw1Gnm/dk7wjVkTqonizLddcrsqnQskpPhG3mcG/ARxlZytdWu2fG4wOLqAyKTw1Pk8t372RNyvOcuD/MKTiWDmcN5Su1bQK3BGggrsLjhGFUCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz7yWOzMhk/UUMPeBWH1qCdk1aXyv8EB29WMC6ulIAw=;
 b=IJi6zVV+s0nRZ3jkpcOJG9qDOizpKh/xLAWGvZYB4R9FBdZsUKj2tKPeXkQJNGle3xTUCnsvzN2cof0w0gdiV5DrjWxNC6jDPOaIYoWYYXFMTyWTEAJkipb+8URMH2JbUr7fJMSWwyFc2HvhUeJzXOJcvWSd6D1efKBnQH0mySg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:37:33 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 17:37:32 +0000
Content-Type: multipart/alternative;
 boundary="------------w6FvK5vsRaEAPKyp0Yu6lt0i"
Message-ID: <6d43e5b7-09de-40fc-8147-028bc504e076@amd.com>
Date: Wed, 28 Oct 2026 13:37:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amdgpu: UALink add debugfs selftest
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com, Mukul.Joshi@amd.com
References: <20261023203447.2075707-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261023203447.2075707-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb8eddf-a82c-4ce6-1c78-08df351a2539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261026121527099003|5023799004|11063799006|56012099006|8096899003|261026135527099003|261022115727099003|261021135927099003|261021130227099003|261022075727099003|261022105027099003|261022113327099003|261021121427099003|261009223027099003|261021123027099003|261021133027099003|10067099003|22082099003|18002099003|6133799003|3023799007|261028144727099003|261026140227099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: yPNn4iga85zOIjzTkvcB35Fpg3VVwHVU/WSMBMpOyPSsu7WXLX0o/zHqP6YqpWMpG3mKEoIrQx5puOlQxoDuQiyHO6jmsMx9aZ/AEm45JVd/ITMTKH/XjdiTHpYp/dcaKWB2xqexH2+kVsx0+DarBFUMu2CmsSFqDE3Kr1Ku0Z+Rldw2LT4dHVdAFqtYJvvsxir4q+yWsbu9Cwj0XG1voUX1TBDkDMkpmMejcOnmRppr1WZ7CABAj5caMHMlwefTIEllC6SsY/1SCn+PCw7ne7weSl7jjJxzceZ/SXOk6geCEOZY6lzSm7tHwQgiiKopet1HYDN2BsClrd9mfVOuLArm9cTcg/yJRn09F/6ImpqHTLW/MB5oJhszqXyXCS/0z6YygGvZlLxFkZkGt+v4kIjm8lq7sVKxZdvA5pdo7mbBdZ6WXSn5FeLNGlIxUd++yla2wzHQRjtkhiX8kSvzxjzSfBZZH6qy/jWOidR0Go6geQR+iMgYh3mBimdxysFedZGmKUd3TM8OV31c+OgHtFod5vM0+2SFzYZ2DHi094GQ5aMnVh4Y+v3KLAot10nSEQCW1Kz8HTeQa+56gYp4UXmU9TgEJBLu79LjiFISkFmY79db3Aflun5j+g2Z6eafSkvAQZ4/nT5/880REMOptLTG/jYSpMdznwMEAx8Ls+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261026121527099003)(5023799004)(11063799006)(56012099006)(8096899003)(261026135527099003)(261022115727099003)(261021135927099003)(261021130227099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021121427099003)(261009223027099003)(261021123027099003)(261021133027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(261028144727099003)(261026140227099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3RTMDhoOXVSUVJ2OVpFdXc5STIzajU2ekhPUU9zU0Y2SHpVQlhMc2JUbi9V?=
 =?utf-8?B?T1ppdDh0TjJEY3BXUmFwUkVrd2g4MVZCMitrd2Q0VEF3UE11ZXNvbGdOcmFK?=
 =?utf-8?B?d2o3NXB4SkZTWGlLVHNzM1o1Z0Y5WjRZN2UrVWhiSXNDUUwvS1YxNmh6OEN3?=
 =?utf-8?B?RHk5WGU1TGsrdjNuRzNibm9renNQMVBDeEhoc3E0TXErYUxwZ3c5eFUyelFy?=
 =?utf-8?B?SklOdHNDT1VXS0JUYzllclFKNDRBNm5pS2lETG8ya2tqTTgrQ0E2MEJubmts?=
 =?utf-8?B?cHNTR2RlYWgxZ2lxODkzeEtVK1BUUW9iL1UvYm5PWjkzQ3diTG5nTC9kUmJk?=
 =?utf-8?B?eVhGSVArU081MlIwcjUrYUlRK2ZJZGlMWkJlb2lDR0dIUWpLTHkyaWpoU1lq?=
 =?utf-8?B?QlBEM0JjZm10U05JMTJDb2U5TkROdTA5YjJjMVFsN2pZQkUza3ZIN2NJSitV?=
 =?utf-8?B?WEI1OEZmNzJIMDFXNWl3Qnk0c2RESWFLZFRUL3NHSndvSEpwaWdRLzhrVHpX?=
 =?utf-8?B?M3BSNURidFpUbWxvYjFIMU4xTGIrdE9Sb0F0ZUhoOThkMTgwOHp5dHdKR3lO?=
 =?utf-8?B?bkhQcktadERRei9aSCtrNzU3WWpiYk1zM0hVUjdUUDFMS1ZBQ1lnVEp6NWJu?=
 =?utf-8?B?L3ZQM2NtM0VEazRIUjJlWWh5ZENVUkkyT0NMTWVyRUxTRGxZdFE3bmNSYkU5?=
 =?utf-8?B?TytLYjhJWlk0VkhsSVNidEJ5WFZvL2prNjd3SzMvVEZJeFlId21tUDBnVnRh?=
 =?utf-8?B?bUdrbXJWN2hWLytiZ2hmNE13TTJxNEY0RmFjOGZHSm9ERitrQjVSY2NpUnVK?=
 =?utf-8?B?UnlNaHdyWmRNV0FZNWc3Z2k2QmJjbkhRVFJ2S3FCbXdqRUIveWx4ZCtlYkd5?=
 =?utf-8?B?dENNUGkvK1ZTbWVDUkd3UzNFL1g2dEFINWppTWpNY1ZVVG5KQjNjamNRM0ZP?=
 =?utf-8?B?RTBpSE5JY0lHYmE0TnIyOFFsVzV1YVg5T2NNUmp3S3VjOWhMMnlEa2pWS2FL?=
 =?utf-8?B?VWpZZXhlM0NleS9ydjZKRml4azdaVEszVVJYS3FHZlhlOG1sQkFqaHhxRnJk?=
 =?utf-8?B?YzE2YXV1NUlFTjVQTXBNd1pqZitnbXliamwzZjhjWUx2Y0d2dlBSL2VxcU5W?=
 =?utf-8?B?RkgrK29IQndmSWZGdmtVSTJYZS9LemRtb2lIMExCanBIbkNpS05OZXA5NkVV?=
 =?utf-8?B?Qjd5a1NEWGpmMENQbjNFcnhoVVhhYllhTTRPdE04d21RcUpGYzFjU1ZydjZB?=
 =?utf-8?B?VE5jN2pmc3pxSEhIZ0dmVE9ZTmFiNUdCQUVJNkM1Y2R6d294MFhkVnZpclFV?=
 =?utf-8?B?Vm5Rd2R0S0MrWGVhbnF5bkpsR0U0V3lCYnh0eFZOWXNaT3IxRHRoRU0zN0U4?=
 =?utf-8?B?YWt0a2dmemhJQmo5UEI5eTNLei9SUjNsbnlPc2FVd3cxYXJrT25GTU43NnND?=
 =?utf-8?B?SE9rZFVLUnVCcE5MZHpzVmZQb1J2VnlqMk9xekRxeWszWEZ1T3c0MlpyQm5U?=
 =?utf-8?B?VERGK1NIZkhrOXgvei9EekxxbmdneVhxWGllODBxc1Z4V1EycXdJdkpKR0ts?=
 =?utf-8?B?Z0p0OXl5bnBIQzl6cUhuWFdxNVFnaVFOQmJYWGVWNnh3WUhxdjZsN0VpL3RZ?=
 =?utf-8?B?RkRzZnJ5dnZYbllYeERjcTZ0QmI5a3lERnp4TjAwSmFhajhMM3J3NkhBK3dF?=
 =?utf-8?B?MFltSjFQNHkvbTI1ditMWFBxb04vU2d5cEU0ajRBTlh4Z2E5cGNlY2V3WlRl?=
 =?utf-8?B?Y2dVM2hVMkovbldxQVBmTE95SFo2L0tpcjhINFE2MXl5c1o5eW9ycEJYZFl5?=
 =?utf-8?B?dXNGSlg3Z0lvZzRUc0F2WVZOUG9oTUhWZHg4eGVEYzZ1YzFEb1dJRE40ZlA2?=
 =?utf-8?B?MHdwTVlLclVQeFBSay81R2I2bFpkR3pPYm5oOFZmTGd5TzdmRnlzdGsweDNx?=
 =?utf-8?B?SjlCWGJSOUtTMHQyWFpqdkxzbGx3bHZIOWFyZ2EycFA0bVMvc3gra016RlRi?=
 =?utf-8?B?UC9rTGJNYlRaM2Q1OVQvamFjeEthYVRvYzdlenNZTE9TT25JMmdSZDZiN01J?=
 =?utf-8?B?OExkL1c3ZUJtRGRLNVVuSWM1RDdFWlV4UDhkSXhwWTB0VmJ2ckx0UDNoODNX?=
 =?utf-8?B?YUhMNDdJQVZwUW9RQlN2SkdtOGZYNDZFeW5pZGtTNnV6QzR4Lys2YjJvQlJa?=
 =?utf-8?B?T0hXL3FSck1JRVNEcXkrQk1hcDlCKzVZNmoxdFNRZmRtbkFmRFg0SlNCc0J6?=
 =?utf-8?B?bU5IK0R5M1RpMlhyandsZ2t6MFE2aURhMjVkTjlFNW9zTy9MeU80OXF3Vk16?=
 =?utf-8?Q?RIM5FCzmqi8ec7a2CQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb8eddf-a82c-4ce6-1c78-08df351a2539
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:37:32.6446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJYa+Yw+vfRY0Co2GVeJP/idCgSIKhlgKfFvg8IPY1nv03xNWrgoiiQypR1smz0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------w6FvK5vsRaEAPKyp0Yu6lt0i
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This has been verified across multiple internal test environments. 
Pinging for review.

Regard,
Philip

On 2026-10-23 16:34, Philip Yang wrote:
> Driver-side selftests for UALink bring-up: exercise the nHT firmware,
> remote interrupts, remote TLB shootdown and remote VRAM access without
> any userspace application.
>
> Add debugfs directory "amdgpu_ualink_test" to trigger UALink selftests
> with these read/write entries:
>
>    command          write the test name to run it, read to list the
>                     valid test names
>    remote_accel_id  accel_id of the remote GPU used by the tests
>    test_size        test buffer size in bytes, from 4 to 4096
>    local_test_data  the local ring buffer the remote GPU accesses
>    remote_sdma      the remote GPU ring buffer, using sdma
>    remote_lsdma     the remote GPU ring buffer, using lsdma
>
> The data entries take and return binary data, a write shorter than
> test_size is repeated to fill it, so formatting is left to userspace
> tools like printf, xxd, od and cmp.
>
> Add helper functions: ualink_test_local_data() and
> ualink_test_remote_rw() for local and remote ring buffer R/W,
> ualink_test_remote_shootdown() for TLB shootdown,
> ualink_test_send_hello() for handshake,
> ualink_test_update_interrupt_wb() and
> ualink_test_update_shootdown_wb() to read writeback results.
>
> v6: ring buffer wptr for itself is used for wptr, don't init to 0xdeadbeef
> v5: Replace the four remote access commands with local_test_data,
>      remote_sdma and remote_lsdma entries, to get the test data without
>      looking at debug logs or using xxd with physical addresses (Felix).
>      Dump and accept binary data, no parser in the driver (Felix).
>      Stage the DMA in the local ring buffer instead of the IB, which is
>      freed before the data is read back.
> v4: Use a single "command" entry taking the test name, instead of one
>      entry per test (Felix).
>      Resync the remote wptr before sending a command, the peer may have
>      rebooted.
> v3: Replace the single entry taking a test number with a debugfs
>      directory and a named entry per command.
>      Take peer->lock to update the writeback address and selftest_mutex
>      to read the test parameters.
> v2: Fix typos and issues from copilot code review.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 219 ++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  24 +-
>   5 files changed, 628 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 3dc95d9accf2..2d786639d081 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2133,9 +2133,336 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +enum amdgpu_ualink_test_cmd {
> +	UALINK_TEST_SW_INIT,
> +	UALINK_TEST_SEND_HELLO,
> +	UALINK_TEST_REMOTE_SHOOTDOWN,
> +	UALINK_TEST_FLUSH_TLB,
> +	UALINK_TEST_UPDATE_INTERRUPT_WB,
> +	UALINK_TEST_UPDATE_SHOOTDOWN_WB,
> +	UALINK_TEST_LSDMA_SELFTEST,
> +};
> +
> +/* commands talking to a remote accelerator, remote_accel_id must be set */
> +#define UALINK_TEST_NEEDS_ACCEL_ID					\
> +	(BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
> +	 BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |				\
> +	 BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
> +
> +static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
> +					  enum amdgpu_ualink_test_cmd cmd)
> +{
> +	u32 remote_accel_id = adev->ualink.test_remote_accel_id;
> +	int r = 0;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
> +	    remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
> +		dev_err(adev->dev, "set remote_accel_id first\n");
> +		return -EINVAL;
> +	}
> +
> +	adev->ualink.selftesting = true;
> +
> +	switch (cmd) {
> +	case UALINK_TEST_SW_INIT:
> +		if (adev->ualink.remote)
> +			amdgpu_ualink_sw_fini(adev);
> +
> +		dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
> +		r = amdgpu_ualink_sw_init(adev);
> +		break;
> +	case UALINK_TEST_SEND_HELLO:
> +		r = ualink_test_send_hello(adev, remote_accel_id);
> +		break;
> +	case UALINK_TEST_REMOTE_SHOOTDOWN:
> +		r = ualink_test_remote_shootdown(adev, remote_accel_id, 1UL << 30,
> +						 1, TLB_FLUSH_HEAVYWEIGHT);
> +		break;
> +	case UALINK_TEST_FLUSH_TLB:
> +		amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
> +		break;
> +	case UALINK_TEST_UPDATE_INTERRUPT_WB:
> +		r = ualink_test_update_interrupt_wb(adev, remote_accel_id);
> +		break;
> +	case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
> +		r = ualink_test_update_shootdown_wb(adev, remote_accel_id);
> +		break;
> +	case UALINK_TEST_LSDMA_SELFTEST:
> +		r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	adev->ualink.selftesting = false;
> +
> +	dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret %d\n",
> +		cmd, remote_accel_id, r);
> +
> +	return r;
> +}
> +
> +#define UALINK_TEST_CMD_NAME_MAX	32
> +
> +static const char * const amdgpu_ualink_test_cmd_name[] = {
> +	[UALINK_TEST_SW_INIT]			= "sw_init",
> +	[UALINK_TEST_SEND_HELLO]		= "send_hello",
> +	[UALINK_TEST_REMOTE_SHOOTDOWN]		= "remote_shootdown",
> +	[UALINK_TEST_FLUSH_TLB]			= "flush_tlb",
> +	[UALINK_TEST_UPDATE_INTERRUPT_WB]	= "update_interrupt_wb",
> +	[UALINK_TEST_UPDATE_SHOOTDOWN_WB]	= "update_shootdown_wb",
> +	[UALINK_TEST_LSDMA_SELFTEST]		= "lsdma_selftest",
> +};
> +
> +static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
> +						  char __user *ubuf,
> +						  size_t len, loff_t *offp)
> +{
> +	char buf[UALINK_TEST_CMD_NAME_MAX * ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
> +	unsigned int i;
> +	int n = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
> +		n += scnprintf(buf + n, sizeof(buf) - n, "%s\n",
> +			       amdgpu_ualink_test_cmd_name[i]);
> +
> +	return simple_read_from_buffer(ubuf, len, offp, buf, n);
> +}
> +
> +static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
> +						   const char __user *ubuf,
> +						   size_t len, loff_t *offp)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +	char buf[UALINK_TEST_CMD_NAME_MAX];
> +	int cmd, r;
> +
> +	if (len >= sizeof(buf))
> +		return -EINVAL;
> +
> +	if (copy_from_user(buf, ubuf, len))
> +		return -EFAULT;
> +
> +	buf[len] = '\0';
> +	cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
> +	if (cmd < 0) {
> +		dev_err(adev->dev, "unknown ualink test command\n");
> +		return cmd;
> +	}
> +
> +	r = amdgpu_debugfs_ualink_test_run(adev, cmd);
> +	if (r)
> +		return r;
> +
> +	return len;
> +}
> +
> +static const struct file_operations amdgpu_ualink_command_fops = {
> +	.owner	 = THIS_MODULE,
> +	.open	 = simple_open,
> +	.read	 = amdgpu_debugfs_ualink_command_read,
> +	.write	 = amdgpu_debugfs_ualink_command_write,
> +	.llseek	 = default_llseek,
> +};
> +
> +/* test data buffers, see amdgpu_debugfs_ualink_data_xfer() */
> +enum amdgpu_ualink_test_buf {
> +	UALINK_BUF_LOCAL,
> +	UALINK_BUF_REMOTE_SDMA,
> +	UALINK_BUF_REMOTE_LSDMA,
> +};
> +
> +static int amdgpu_debugfs_ualink_data_xfer(struct amdgpu_device *adev,
> +					   enum amdgpu_ualink_test_buf buf,
> +					   u32 *data, u32 size, bool read)
> +{
> +	u32 remote_accel_id = adev->ualink.test_remote_accel_id;
> +	int r;
> +
> +	if (remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
> +		dev_err(adev->dev, "set remote_accel_id first\n");
> +		return -EINVAL;
> +	}
> +
> +	adev->ualink.selftesting = true;
> +
> +	if (buf == UALINK_BUF_LOCAL)
> +		r = ualink_test_local_data(adev, remote_accel_id, data, size, read);
> +	else
> +		r = ualink_test_remote_rw(adev, remote_accel_id, data, size, read,
> +					  buf == UALINK_BUF_REMOTE_LSDMA);
> +
> +	adev->ualink.selftesting = false;
> +
> +	return r;
> +}
> +
> +static ssize_t amdgpu_debugfs_ualink_data_read(struct file *file,
> +					       char __user *ubuf, size_t len,
> +					       loff_t *offp,
> +					       enum amdgpu_ualink_test_buf buf)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +	ssize_t ret;
> +	u32 size;
> +	void *data;
> +	int r;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	size = adev->ualink.test_size_dwords * 4;
> +
> +	data = kmalloc(size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, true);
> +	ret = r ? r : simple_read_from_buffer(ubuf, len, offp, data, size);
> +
> +	kfree(data);
> +
> +	return ret;
> +}
> +
> +static ssize_t amdgpu_debugfs_ualink_data_write(struct file *file,
> +						const char __user *ubuf,
> +						size_t len, loff_t *offp,
> +						enum amdgpu_ualink_test_buf buf)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +	u32 i, size;
> +	void *data;
> +	int r;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	size = adev->ualink.test_size_dwords * 4;
> +
> +	if (!len)
> +		return -EINVAL;
> +
> +	len = min_t(size_t, len, size);
> +
> +	data = kmalloc(size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(data, ubuf, len)) {
> +		kfree(data);
> +		return -EFAULT;
> +	}
> +
> +	/* repeat a short pattern to fill the test size */
> +	for (i = len; i < size; i += len)
> +		memcpy(data + i, data, min_t(u32, len, size - i));
> +
> +	r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, false);
> +
> +	kfree(data);
> +
> +	return r ? r : len;
> +}
> +
> +#define UALINK_TEST_DATA_ATTR(name, buf)				\
> +static ssize_t amdgpu_debugfs_ualink_##name##_read(struct file *file,	\
> +		char __user *ubuf, size_t len, loff_t *offp)		\
> +{									\
> +	return amdgpu_debugfs_ualink_data_read(file, ubuf, len, offp, buf); \
> +}									\
> +static ssize_t amdgpu_debugfs_ualink_##name##_write(struct file *file,	\
> +		const char __user *ubuf, size_t len, loff_t *offp)	\
> +{									\
> +	return amdgpu_debugfs_ualink_data_write(file, ubuf, len, offp, buf); \
> +}									\
> +static const struct file_operations amdgpu_ualink_##name##_fops = {	\
> +	.owner	 = THIS_MODULE,						\
> +	.open	 = simple_open,						\
> +	.read	 = amdgpu_debugfs_ualink_##name##_read,			\
> +	.write	 = amdgpu_debugfs_ualink_##name##_write,		\
> +	.llseek	 = default_llseek,					\
> +}
> +
> +UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
> +UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
> +UALINK_TEST_DATA_ATTR(remote_lsdma, UALINK_BUF_REMOTE_LSDMA);
> +
> +static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	*val = adev->ualink.test_remote_accel_id;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	if (!adev->ualink.info)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	if (val >= AMDGPU_UALINK_ACCEL_MAX ||
> +	    !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
> +		dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
> +		return -EINVAL;
> +	}
> +
> +	if (val == adev->ualink.info->ppod.accel_id) {
> +		dev_err(adev->dev, "remote accel_id equals to local accel_id\n");
> +		return -EINVAL;
> +	}
> +
> +	adev->ualink.test_remote_accel_id = val;
> +	dev_info(adev->dev, "set remote accel_id to %llu, local accel_id %u\n",
> +		 val, adev->ualink.info->ppod.accel_id);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
> +			 amdgpu_debugfs_ualink_accel_id_get,
> +			 amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
> +
> +static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	*val = adev->ualink.test_size_dwords * 4;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	if (val < 4 || val > AMDGPU_UALINK_RB_SIZE)
> +		return -EINVAL;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	adev->ualink.test_size_dwords = val / 4;
> +	dev_dbg(adev->dev, "test buffer size %u bytes\n",
> +		adev->ualink.test_size_dwords * 4);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
> +			 amdgpu_debugfs_ualink_test_size_get,
> +			 amdgpu_debugfs_ualink_test_size_set, "%llu\n");
> +
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> +	struct dentry *ualink_test;
>   	struct dentry *ent;
>   	int r, i;
>   
> @@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
>   			     &adev->ualink.drop_msg_bitmap);
>   
> +	mutex_init(&adev->ualink.selftest_mutex);
> +	/* 64 bytes test size by default */
> +	adev->ualink.test_size_dwords = 16;
> +	adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
> +
> +	ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
> +	debugfs_create_file("command", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_command_fops);
> +	debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_accel_id_fops);
> +	debugfs_create_file("test_size", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_test_size_fops);
> +	debugfs_create_file("local_test_data", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_local_test_data_fops);
> +	debugfs_create_file("remote_sdma", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_remote_sdma_fops);
> +	debugfs_create_file("remote_lsdma", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_remote_lsdma_fops);
> +
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;
>   	debugfs_create_blob("amdgpu_vbios", 0444, root,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> index 05bc281216bf..1f83d9b69135 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
>   	mutex_unlock(&adev->lsdma.lock);
>   	return ret;
>   }
> +
> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ib ib;
> +	int i, r;
> +	u64 gpu_addr;
> +	char *p;
> +	u32 size = 128;
> +
> +	memset(&ib, 0, sizeof(ib));
> +	r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, &ib);
> +	if (r)
> +		return r;
> +
> +	gpu_addr = ib.gpu_addr;
> +	p = (char *)ib.ptr;
> +	memset(p, 0, 2 * size);
> +
> +	for (i = 0; i < size; i++)
> +		*(p + i) = i;
> +
> +	dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
> +		gpu_addr, gpu_addr + size, size);
> +
> +	r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
> +	if (r)
> +		goto out;
> +
> +	p += size;
> +	for (i = 0; i < size; i++) {
> +		if (*(p + i) != i) {
> +			dev_dbg(adev->dev, "data mismatch expecting 0x%x but read 0x%x\n",
> +				i, *(p + i));
> +			break;
> +		}
> +	}
> +	if (i != size)
> +		r = -EIO;
> +
> +out:
> +	amdgpu_ib_free(&ib, NULL);
> +
> +	if (r)
> +		dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
> +	else
> +		dev_dbg(adev->dev, "lsdma selftest passed\n");
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> index 34e92aaa4617..f0a5eeb3529f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
>   			  uint32_t data, uint64_t mem_size);
>   int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
>   			  uint32_t reg_val, uint32_t mask);
> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 339f639a450e..86e0dc8d728e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -39,8 +39,6 @@ static void deactivate_accelerator(struct amdgpu_device *adev);
>   static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>   				u32 remote_accel_id, u32 dw0, u32 dw1,
>   				u32 dw2, u32 dw3);
> -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
> -				    u32 flush_type);
>   static int amdgpu_ualink_reserve_npa_vm_and_bos(struct amdgpu_device *adev,
>   						struct amdgpu_bo *bos[], u32 n_bos,
>   						struct drm_exec *exec,
> @@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
>    * UALink remote interrupt and shootdown
>    */
>   
> -/* UALINK ring buffer size, same for both remote shootdown and interrupt ring */
> -#define AMDGPU_UALINK_RB_SIZE	4096
> -
>   #define AMDGPU_UALINK_METADATA_HEADER	0x4E485446
>   
>   /* 2MB NPA start address for 2MB page mapping */
> @@ -4582,7 +4577,7 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
>   	return ualink_wb_offset(adev, accel_id) + sizeof(struct amdgpu_ualink_wb);
>   }
>   
> -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
>   {
>   	u32 bit;
>   
> @@ -5281,7 +5276,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	if (status != AMDGPU_NHT_FW_ST_PREINIT &&
>   	    status != AMDGPU_NHT_FW_ST_HALT) {
>   		dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", status);
> -		return -ENODEV;
> +		if (!adev->ualink.selftesting)
> +			return -ENODEV;
>   	}
>   
>   	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
> @@ -5399,6 +5395,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	r = adev->ualink.msg_ctl->send_metadata(adev,
>   						    remote->metadata_gpu_addr,
>   						    AMDGPU_UALINK_ACCEL_MAX << 8);
> +	if (r && adev->ualink.selftesting)
> +		r = 0;
>   
>   out:
>   	if (r)
> @@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>   	adev->ualink.remote = NULL;
>   }
>   
> -int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
> +/* byte offset of the local interrupt ring a remote GPU writes to */
> +static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
> +{
> +	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
> +
> +	/* remote shootdown ring is first, remote interrupt ring follows it */
> +	return rb_size * remote_accel_id + AMDGPU_UALINK_RB_SIZE;
> +}
> +
> +/*
> + * ualink_test_local_data - read or write the local ring buffer of a remote GPU
> + *
> + * The local ring buffer is partitioned per remote GPU, @remote_accel_id selects
> + * the interrupt ring that remote GPU writes to through its NPA mapping. Read it
> + * to see what the remote GPU wrote, write it to provide the data it reads.
> + */
> +int ualink_test_local_data(struct amdgpu_device *adev, u32 remote_accel_id,
> +			   void *data, u32 size, bool read)
>   {
> +	struct amdgpu_ualink_remote *remote = to_remote(adev);
> +	void *rb;
> +
> +	if (!remote || !remote->rb_cpu_addr)
> +		return -EINVAL;
> +
> +	if (size > AMDGPU_UALINK_RB_SIZE)
> +		return -EINVAL;
> +
> +	rb = remote->rb_cpu_addr + ualink_test_local_rb_offset(remote_accel_id);
> +
> +	dev_dbg(adev->dev, "%s local rb of remote %u at 0x%p size 0x%x\n",
> +		read ? "read" : "write", remote_accel_id, rb, size);
> +
> +	if (read)
> +		memcpy(data, rb, size);
> +	else
> +		memcpy(rb, data, size);
> +
> +	return 0;
> +}
> +
> +/*
> + * ualink_test_remote_rw - read or write the remote GPU ring buffer
> + *
> + * Copy @size bytes between @data and the remote GPU ring buffer NPA address
> + * using lsdma or sdma. The DMA engines cannot access @data, the local ring
> + * buffer of the same remote GPU is used to stage it, so local_test_data shows
> + * what was sent or received.
> + *
> + * Works with or without MPNHT FW running, the copy does not update wptr and
> + * does not ring the doorbell.
> + */
> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 remote_accel_id,
> +			  void *data, u32 size, bool read, bool use_lsdma)
> +{
> +	struct amdgpu_ualink_remote *remote = to_remote(adev);
> +	struct amdgpu_ualink_peer *peer;
> +	struct amdgpu_ualink_ring *ring;
> +	struct dma_fence *fence;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
> +	u64 npa, local;
> +	u32 offset, ndw;
> +	int r;
> +
> +	if (!remote)
> +		return -EINVAL;
> +
> +	if (size > AMDGPU_UALINK_RB_SIZE)
> +		return -EINVAL;
> +
> +	peer = &remote->peer[remote_accel_id];
> +	ring = &peer->interrupt;
> +
> +	guard(mutex)(&peer->lock);
> +
> +	offset = ualink_test_local_rb_offset(remote_accel_id);
> +	local = remote->rb_gpu_addr + offset;
> +	npa = ring->rb_npa_gart;
> +
> +	if (!read)
> +		memcpy(remote->rb_cpu_addr + offset, data, size);
> +
> +	remote->use_lsdma = use_lsdma;
> +
> +	dev_dbg(adev->dev, "%s remote %u npa 0x%llx local 0x%llx size 0x%x use %s\n",
> +		read ? "read" : "write", remote_accel_id, npa, local, size,
> +		use_lsdma ? "lsdma" : "sdma");
> +
> +	if (use_lsdma) {
> +		r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
> +					  read ? local : npa, size);
> +		if (r)
> +			return r;
> +
> +		goto done;
> +	}
> +
> +	/* sdma linear copy command, align to 8 dwords boundary */
> +	ndw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +
> +	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
> +				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
> +	if (r)
> +		return r;
> +
> +	ib = job->ibs;
> +	ib->length_dw = 0;
> +
> +	amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
> +				read ? local : npa, size, 0);
> +	amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
> +	WARN_ON(ib->length_dw > ndw);
> +
> +	fence = amdgpu_job_submit(job);
> +
> +	r = dma_fence_wait_timeout(fence, false, HZ * 10);
> +	dma_fence_put(fence);
> +	if (r <= 0) {
> +		dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", r);
> +		dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
> +		remote->use_lsdma = true;
> +		return -ETIME;
> +	}
> +
> +done:
> +	if (read)
> +		memcpy(data, remote->rb_cpu_addr + offset, size);
> +
> +	return 0;
> +}
> +
> +/* The peer may have rebooted or the vpod was reconfigured, adopt the remote
> + * wptr before sending a command, same as the handshake does.
> + */
> +static int ualink_test_resync_peer(struct amdgpu_device *adev, u32 remote_accel_id)
> +{
> +	int r;
> +
> +	if (!adev->ualink.remote)
> +		return -EINVAL;
> +
> +	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
> +	if (r < 0)
> +		return r;
> +
> +	/* Peer moved, drop ready so the next command updates the wb address */
> +	if (r)
> +		amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
> +
> +	return 0;
> +}
> +
> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
> +{
> +	int r;
> +
> +	r = ualink_test_resync_peer(adev, remote_accel_id);
> +	if (r)
> +		return r;
> +
>   	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
>   }
>   
> +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id,
> +				 u64 addr, u32 size_in_pages, u32 flush_type)
> +{
> +	int r;
> +
> +	r = ualink_test_resync_peer(adev, remote_accel_id);
> +	if (r)
> +		return r;
> +
> +	return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
> +					      size_in_pages, flush_type);
> +}
> +
> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id)
> +{
> +	int r;
> +
> +	r = ualink_test_resync_peer(adev, remote_accel_id);
> +	if (r)
> +		return r;
> +
> +	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
> +
> +	/* Update interrupt completion write back address */
> +	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
> +					    RB_TYPE_REMOTE_INTERRUPT);
> +	return r;
> +}
> +
> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id)
> +{
> +	int r;
> +
> +	r = ualink_test_resync_peer(adev, remote_accel_id);
> +	if (r)
> +		return r;
> +
> +	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
> +
> +	/* Update shootdown completion write back address */
> +	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
> +					    RB_TYPE_TLB_INV);
> +	return r;
> +}
> +
>   /*
>    * The low bits of handle_lo carry the message-header field on the wire.
>    * Strip those bits and splice in @acc_id to recover the
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> index 85c9a9634a4b..90e90cd8b495 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> @@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
>   	enum amdgpu_ualink_conn_state state;
>   };
>   
> +/* UALINK ring buffer size, same for both remote shootdown and interrupt ring */
> +#define AMDGPU_UALINK_RB_SIZE	4096
> +
>   struct amdgpu_ualink_remote;
>   
>   struct amdgpu_ualink_msg_ctl {
> @@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
>   	/* For remote interrupt and shootdown */
>   	struct amdgpu_ualink_remote *remote;
>   
> +	/* true for selftest driver path, ignore FW error */
> +	bool selftesting;
> +	/* serialize the selftest debugfs entries */
> +	struct mutex selftest_mutex;
> +	u32 test_size_dwords;
> +	u32 test_remote_accel_id;
> +
>   	/* handle irq from ualink client of remote GPUs */
>   	struct amdgpu_irq_src irq;
>   
> @@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
>   	unsigned long drop_msg_bitmap;
>   };
>   
> +int ualink_test_local_data(struct amdgpu_device *adev, u32 remote_accel_id,
> +			   void *data, u32 size, bool read);
> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 remote_accel_id,
> +			  void *data, u32 size, bool read, bool use_lsdma);
> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
> +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id,
> +				 u64 addr, u32 size_in_pages, u32 flush_type);
> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id);
> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id);
> +
>   int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
>   				 unsigned int client_id, unsigned int src_id);
> -
> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type);
>   int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
>   
> -int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
> -
>   int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev);
>   int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
>   int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);

--------------w6FvK5vsRaEAPKyp0Yu6lt0i
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    This has been verified across multiple internal test environments.
    Pinging for review.<br>
    <br>
    Regard,<br>
    Philip<br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-23 16:34, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261023203447.2075707-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">Driver-side selftests for UALink bring-up: exercise the nHT firmware,
remote interrupts, remote TLB shootdown and remote VRAM access without
any userspace application.

Add debugfs directory &quot;amdgpu_ualink_test&quot; to trigger UALink selftests
with these read/write entries:

  command          write the test name to run it, read to list the
                   valid test names
  remote_accel_id  accel_id of the remote GPU used by the tests
  test_size        test buffer size in bytes, from 4 to 4096
  local_test_data  the local ring buffer the remote GPU accesses
  remote_sdma      the remote GPU ring buffer, using sdma
  remote_lsdma     the remote GPU ring buffer, using lsdma

The data entries take and return binary data, a write shorter than
test_size is repeated to fill it, so formatting is left to userspace
tools like printf, xxd, od and cmp.

Add helper functions: ualink_test_local_data() and
ualink_test_remote_rw() for local and remote ring buffer R/W,
ualink_test_remote_shootdown() for TLB shootdown,
ualink_test_send_hello() for handshake,
ualink_test_update_interrupt_wb() and
ualink_test_update_shootdown_wb() to read writeback results.

v6: ring buffer wptr for itself is used for wptr, don't init to 0xdeadbeef
v5: Replace the four remote access commands with local_test_data,
    remote_sdma and remote_lsdma entries, to get the test data without
    looking at debug logs or using xxd with physical addresses (Felix).
    Dump and accept binary data, no parser in the driver (Felix).
    Stage the DMA in the local ring buffer instead of the IB, which is
    freed before the data is read back.
v4: Use a single &quot;command&quot; entry taking the test name, instead of one
    entry per test (Felix).
    Resync the remote wptr before sending a command, the peer may have
    rebooted.
v3: Replace the single entry taking a test number with a debugfs
    directory and a named entry per command.
    Take peer-&gt;lock to update the writeback address and selftest_mutex
    to read the test parameters.
v2: Fix typos and issues from copilot code review.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 219 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  24 +-
 5 files changed, 628 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3dc95d9accf2..2d786639d081 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2133,9 +2133,336 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;);
 
+enum amdgpu_ualink_test_cmd {
+	UALINK_TEST_SW_INIT,
+	UALINK_TEST_SEND_HELLO,
+	UALINK_TEST_REMOTE_SHOOTDOWN,
+	UALINK_TEST_FLUSH_TLB,
+	UALINK_TEST_UPDATE_INTERRUPT_WB,
+	UALINK_TEST_UPDATE_SHOOTDOWN_WB,
+	UALINK_TEST_LSDMA_SELFTEST,
+};
+
+/* commands talking to a remote accelerator, remote_accel_id must be set */
+#define UALINK_TEST_NEEDS_ACCEL_ID					\
+	(BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
+	 BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |				\
+	 BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
+
+static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
+					  enum amdgpu_ualink_test_cmd cmd)
+{
+	u32 remote_accel_id = adev-&gt;ualink.test_remote_accel_id;
+	int r = 0;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	if ((BIT(cmd) &amp; UALINK_TEST_NEEDS_ACCEL_ID) &amp;&amp;
+	    remote_accel_id &gt;= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev-&gt;dev, &quot;set remote_accel_id first\n&quot;);
+		return -EINVAL;
+	}
+
+	adev-&gt;ualink.selftesting = true;
+
+	switch (cmd) {
+	case UALINK_TEST_SW_INIT:
+		if (adev-&gt;ualink.remote)
+			amdgpu_ualink_sw_fini(adev);
+
+		dev_dbg(adev-&gt;dev, &quot;load metadata init MPNHT firmware\n&quot;);
+		r = amdgpu_ualink_sw_init(adev);
+		break;
+	case UALINK_TEST_SEND_HELLO:
+		r = ualink_test_send_hello(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_REMOTE_SHOOTDOWN:
+		r = ualink_test_remote_shootdown(adev, remote_accel_id, 1UL &lt;&lt; 30,
+						 1, TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_FLUSH_TLB:
+		amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_UPDATE_INTERRUPT_WB:
+		r = ualink_test_update_interrupt_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
+		r = ualink_test_update_shootdown_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_LSDMA_SELFTEST:
+		r = adev-&gt;lsdma.funcs ? amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
+		break;
+	}
+
+	adev-&gt;ualink.selftesting = false;
+
+	dev_dbg(adev-&gt;dev, &quot;ualink test cmd %d remote_accel_id %u ret %d\n&quot;,
+		cmd, remote_accel_id, r);
+
+	return r;
+}
+
+#define UALINK_TEST_CMD_NAME_MAX	32
+
+static const char * const amdgpu_ualink_test_cmd_name[] = {
+	[UALINK_TEST_SW_INIT]			= &quot;sw_init&quot;,
+	[UALINK_TEST_SEND_HELLO]		= &quot;send_hello&quot;,
+	[UALINK_TEST_REMOTE_SHOOTDOWN]		= &quot;remote_shootdown&quot;,
+	[UALINK_TEST_FLUSH_TLB]			= &quot;flush_tlb&quot;,
+	[UALINK_TEST_UPDATE_INTERRUPT_WB]	= &quot;update_interrupt_wb&quot;,
+	[UALINK_TEST_UPDATE_SHOOTDOWN_WB]	= &quot;update_shootdown_wb&quot;,
+	[UALINK_TEST_LSDMA_SELFTEST]		= &quot;lsdma_selftest&quot;,
+};
+
+static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
+						  char __user *ubuf,
+						  size_t len, loff_t *offp)
+{
+	char buf[UALINK_TEST_CMD_NAME_MAX * ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
+	unsigned int i;
+	int n = 0;
+
+	for (i = 0; i &lt; ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
+		n += scnprintf(buf + n, sizeof(buf) - n, &quot;%s\n&quot;,
+			       amdgpu_ualink_test_cmd_name[i]);
+
+	return simple_read_from_buffer(ubuf, len, offp, buf, n);
+}
+
+static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
+						   const char __user *ubuf,
+						   size_t len, loff_t *offp)
+{
+	struct amdgpu_device *adev = file-&gt;private_data;
+	char buf[UALINK_TEST_CMD_NAME_MAX];
+	int cmd, r;
+
+	if (len &gt;= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
+	if (cmd &lt; 0) {
+		dev_err(adev-&gt;dev, &quot;unknown ualink test command\n&quot;);
+		return cmd;
+	}
+
+	r = amdgpu_debugfs_ualink_test_run(adev, cmd);
+	if (r)
+		return r;
+
+	return len;
+}
+
+static const struct file_operations amdgpu_ualink_command_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = simple_open,
+	.read	 = amdgpu_debugfs_ualink_command_read,
+	.write	 = amdgpu_debugfs_ualink_command_write,
+	.llseek	 = default_llseek,
+};
+
+/* test data buffers, see amdgpu_debugfs_ualink_data_xfer() */
+enum amdgpu_ualink_test_buf {
+	UALINK_BUF_LOCAL,
+	UALINK_BUF_REMOTE_SDMA,
+	UALINK_BUF_REMOTE_LSDMA,
+};
+
+static int amdgpu_debugfs_ualink_data_xfer(struct amdgpu_device *adev,
+					   enum amdgpu_ualink_test_buf buf,
+					   u32 *data, u32 size, bool read)
+{
+	u32 remote_accel_id = adev-&gt;ualink.test_remote_accel_id;
+	int r;
+
+	if (remote_accel_id &gt;= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev-&gt;dev, &quot;set remote_accel_id first\n&quot;);
+		return -EINVAL;
+	}
+
+	adev-&gt;ualink.selftesting = true;
+
+	if (buf == UALINK_BUF_LOCAL)
+		r = ualink_test_local_data(adev, remote_accel_id, data, size, read);
+	else
+		r = ualink_test_remote_rw(adev, remote_accel_id, data, size, read,
+					  buf == UALINK_BUF_REMOTE_LSDMA);
+
+	adev-&gt;ualink.selftesting = false;
+
+	return r;
+}
+
+static ssize_t amdgpu_debugfs_ualink_data_read(struct file *file,
+					       char __user *ubuf, size_t len,
+					       loff_t *offp,
+					       enum amdgpu_ualink_test_buf buf)
+{
+	struct amdgpu_device *adev = file-&gt;private_data;
+	ssize_t ret;
+	u32 size;
+	void *data;
+	int r;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	size = adev-&gt;ualink.test_size_dwords * 4;
+
+	data = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, true);
+	ret = r ? r : simple_read_from_buffer(ubuf, len, offp, data, size);
+
+	kfree(data);
+
+	return ret;
+}
+
+static ssize_t amdgpu_debugfs_ualink_data_write(struct file *file,
+						const char __user *ubuf,
+						size_t len, loff_t *offp,
+						enum amdgpu_ualink_test_buf buf)
+{
+	struct amdgpu_device *adev = file-&gt;private_data;
+	u32 i, size;
+	void *data;
+	int r;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	size = adev-&gt;ualink.test_size_dwords * 4;
+
+	if (!len)
+		return -EINVAL;
+
+	len = min_t(size_t, len, size);
+
+	data = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (copy_from_user(data, ubuf, len)) {
+		kfree(data);
+		return -EFAULT;
+	}
+
+	/* repeat a short pattern to fill the test size */
+	for (i = len; i &lt; size; i += len)
+		memcpy(data + i, data, min_t(u32, len, size - i));
+
+	r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, false);
+
+	kfree(data);
+
+	return r ? r : len;
+}
+
+#define UALINK_TEST_DATA_ATTR(name, buf)				\
+static ssize_t amdgpu_debugfs_ualink_##name##_read(struct file *file,	\
+		char __user *ubuf, size_t len, loff_t *offp)		\
+{									\
+	return amdgpu_debugfs_ualink_data_read(file, ubuf, len, offp, buf); \
+}									\
+static ssize_t amdgpu_debugfs_ualink_##name##_write(struct file *file,	\
+		const char __user *ubuf, size_t len, loff_t *offp)	\
+{									\
+	return amdgpu_debugfs_ualink_data_write(file, ubuf, len, offp, buf); \
+}									\
+static const struct file_operations amdgpu_ualink_##name##_fops = {	\
+	.owner	 = THIS_MODULE,						\
+	.open	 = simple_open,						\
+	.read	 = amdgpu_debugfs_ualink_##name##_read,			\
+	.write	 = amdgpu_debugfs_ualink_##name##_write,		\
+	.llseek	 = default_llseek,					\
+}
+
+UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
+UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
+UALINK_TEST_DATA_ATTR(remote_lsdma, UALINK_BUF_REMOTE_LSDMA);
+
+static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	*val = adev-&gt;ualink.test_remote_accel_id;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (!adev-&gt;ualink.info)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	if (val &gt;= AMDGPU_UALINK_ACCEL_MAX ||
+	    !test_bit(val, adev-&gt;ualink.info-&gt;vpod.active_accel_bits)) {
+		dev_err(adev-&gt;dev, &quot;invalid remote accel_id %llu\n&quot;, val);
+		return -EINVAL;
+	}
+
+	if (val == adev-&gt;ualink.info-&gt;ppod.accel_id) {
+		dev_err(adev-&gt;dev, &quot;remote accel_id equals to local accel_id\n&quot;);
+		return -EINVAL;
+	}
+
+	adev-&gt;ualink.test_remote_accel_id = val;
+	dev_info(adev-&gt;dev, &quot;set remote accel_id to %llu, local accel_id %u\n&quot;,
+		 val, adev-&gt;ualink.info-&gt;ppod.accel_id);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
+			 amdgpu_debugfs_ualink_accel_id_get,
+			 amdgpu_debugfs_ualink_accel_id_set, &quot;%llu\n&quot;);
+
+static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	*val = adev-&gt;ualink.test_size_dwords * 4;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (val &lt; 4 || val &gt; AMDGPU_UALINK_RB_SIZE)
+		return -EINVAL;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	adev-&gt;ualink.test_size_dwords = val / 4;
+	dev_dbg(adev-&gt;dev, &quot;test buffer size %u bytes\n&quot;,
+		adev-&gt;ualink.test_size_dwords * 4);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
+			 amdgpu_debugfs_ualink_test_size_get,
+			 amdgpu_debugfs_ualink_test_size_set, &quot;%llu\n&quot;);
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)-&gt;primary-&gt;debugfs_root;
+	struct dentry *ualink_test;
 	struct dentry *ent;
 	int r, i;
 
@@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_ulong(&quot;amdgpu_ualink_drop_msg_bitmap&quot;, 0600, root,
 			     &amp;adev-&gt;ualink.drop_msg_bitmap);
 
+	mutex_init(&amp;adev-&gt;ualink.selftest_mutex);
+	/* 64 bytes test size by default */
+	adev-&gt;ualink.test_size_dwords = 16;
+	adev-&gt;ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
+
+	ualink_test = debugfs_create_dir(&quot;amdgpu_ualink_test&quot;, root);
+	debugfs_create_file(&quot;command&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_command_fops);
+	debugfs_create_file(&quot;remote_accel_id&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_accel_id_fops);
+	debugfs_create_file(&quot;test_size&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_test_size_fops);
+	debugfs_create_file(&quot;local_test_data&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_local_test_data_fops);
+	debugfs_create_file(&quot;remote_sdma&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_remote_sdma_fops);
+	debugfs_create_file(&quot;remote_lsdma&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_remote_lsdma_fops);
+
 	adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios;
 	adev-&gt;debugfs_vbios_blob.size = adev-&gt;bios_size;
 	debugfs_create_blob(&quot;amdgpu_vbios&quot;, 0444, root,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index 05bc281216bf..1f83d9b69135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
 	mutex_unlock(&amp;adev-&gt;lsdma.lock);
 	return ret;
 }
+
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
+{
+	struct amdgpu_ib ib;
+	int i, r;
+	u64 gpu_addr;
+	char *p;
+	u32 size = 128;
+
+	memset(&amp;ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, &amp;ib);
+	if (r)
+		return r;
+
+	gpu_addr = ib.gpu_addr;
+	p = (char *)ib.ptr;
+	memset(p, 0, 2 * size);
+
+	for (i = 0; i &lt; size; i++)
+		*(p + i) = i;
+
+	dev_dbg(adev-&gt;dev, &quot;copy src 0x%llx dst 0x%llx size %d bytes\n&quot;,
+		gpu_addr, gpu_addr + size, size);
+
+	r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
+	if (r)
+		goto out;
+
+	p += size;
+	for (i = 0; i &lt; size; i++) {
+		if (*(p + i) != i) {
+			dev_dbg(adev-&gt;dev, &quot;data mismatch expecting 0x%x but read 0x%x\n&quot;,
+				i, *(p + i));
+			break;
+		}
+	}
+	if (i != size)
+		r = -EIO;
+
+out:
+	amdgpu_ib_free(&amp;ib, NULL);
+
+	if (r)
+		dev_dbg(adev-&gt;dev, &quot;lsdma selftest failed r=%d\n&quot;, r);
+	else
+		dev_dbg(adev-&gt;dev, &quot;lsdma selftest passed\n&quot;);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index 34e92aaa4617..f0a5eeb3529f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
 			  uint32_t data, uint64_t mem_size);
 int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
 			  uint32_t reg_val, uint32_t mask);
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 339f639a450e..86e0dc8d728e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -39,8 +39,6 @@ static void deactivate_accelerator(struct amdgpu_device *adev);
 static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 				u32 remote_accel_id, u32 dw0, u32 dw1,
 				u32 dw2, u32 dw3);
-static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
-				    u32 flush_type);
 static int amdgpu_ualink_reserve_npa_vm_and_bos(struct amdgpu_device *adev,
 						struct amdgpu_bo *bos[], u32 n_bos,
 						struct drm_exec *exec,
@@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
  * UALink remote interrupt and shootdown
  */
 
-/* UALINK ring buffer size, same for both remote shootdown and interrupt ring */
-#define AMDGPU_UALINK_RB_SIZE	4096
-
 #define AMDGPU_UALINK_METADATA_HEADER	0x4E485446
 
 /* 2MB NPA start address for 2MB page mapping */
@@ -4582,7 +4577,7 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
 	return ualink_wb_offset(adev, accel_id) + sizeof(struct amdgpu_ualink_wb);
 }
 
-static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
+void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
 {
 	u32 bit;
 
@@ -5281,7 +5276,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	if (status != AMDGPU_NHT_FW_ST_PREINIT &amp;&amp;
 	    status != AMDGPU_NHT_FW_ST_HALT) {
 		dev_dbg(adev-&gt;dev, &quot;fw status 0x%x not preinit or halt\n&quot;, status);
-		return -ENODEV;
+		if (!adev-&gt;ualink.selftesting)
+			return -ENODEV;
 	}
 
 	dev_dbg(adev-&gt;dev, &quot;accel_id %u addr_mode %d fw status 0x%x\n&quot;,
@@ -5399,6 +5395,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	r = adev-&gt;ualink.msg_ctl-&gt;send_metadata(adev,
 						    remote-&gt;metadata_gpu_addr,
 						    AMDGPU_UALINK_ACCEL_MAX &lt;&lt; 8);
+	if (r &amp;&amp; adev-&gt;ualink.selftesting)
+		r = 0;
 
 out:
 	if (r)
@@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev-&gt;ualink.remote = NULL;
 }
 
-int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
+/* byte offset of the local interrupt ring a remote GPU writes to */
+static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
+{
+	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
+
+	/* remote shootdown ring is first, remote interrupt ring follows it */
+	return rb_size * remote_accel_id + AMDGPU_UALINK_RB_SIZE;
+}
+
+/*
+ * ualink_test_local_data - read or write the local ring buffer of a remote GPU
+ *
+ * The local ring buffer is partitioned per remote GPU, @remote_accel_id selects
+ * the interrupt ring that remote GPU writes to through its NPA mapping. Read it
+ * to see what the remote GPU wrote, write it to provide the data it reads.
+ */
+int ualink_test_local_data(struct amdgpu_device *adev, u32 remote_accel_id,
+			   void *data, u32 size, bool read)
 {
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	void *rb;
+
+	if (!remote || !remote-&gt;rb_cpu_addr)
+		return -EINVAL;
+
+	if (size &gt; AMDGPU_UALINK_RB_SIZE)
+		return -EINVAL;
+
+	rb = remote-&gt;rb_cpu_addr + ualink_test_local_rb_offset(remote_accel_id);
+
+	dev_dbg(adev-&gt;dev, &quot;%s local rb of remote %u at 0x%p size 0x%x\n&quot;,
+		read ? &quot;read&quot; : &quot;write&quot;, remote_accel_id, rb, size);
+
+	if (read)
+		memcpy(data, rb, size);
+	else
+		memcpy(rb, data, size);
+
+	return 0;
+}
+
+/*
+ * ualink_test_remote_rw - read or write the remote GPU ring buffer
+ *
+ * Copy @size bytes between @data and the remote GPU ring buffer NPA address
+ * using lsdma or sdma. The DMA engines cannot access @data, the local ring
+ * buffer of the same remote GPU is used to stage it, so local_test_data shows
+ * what was sent or received.
+ *
+ * Works with or without MPNHT FW running, the copy does not update wptr and
+ * does not ring the doorbell.
+ */
+int ualink_test_remote_rw(struct amdgpu_device *adev, u32 remote_accel_id,
+			  void *data, u32 size, bool read, bool use_lsdma)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	u64 npa, local;
+	u32 offset, ndw;
+	int r;
+
+	if (!remote)
+		return -EINVAL;
+
+	if (size &gt; AMDGPU_UALINK_RB_SIZE)
+		return -EINVAL;
+
+	peer = &amp;remote-&gt;peer[remote_accel_id];
+	ring = &amp;peer-&gt;interrupt;
+
+	guard(mutex)(&amp;peer-&gt;lock);
+
+	offset = ualink_test_local_rb_offset(remote_accel_id);
+	local = remote-&gt;rb_gpu_addr + offset;
+	npa = ring-&gt;rb_npa_gart;
+
+	if (!read)
+		memcpy(remote-&gt;rb_cpu_addr + offset, data, size);
+
+	remote-&gt;use_lsdma = use_lsdma;
+
+	dev_dbg(adev-&gt;dev, &quot;%s remote %u npa 0x%llx local 0x%llx size 0x%x use %s\n&quot;,
+		read ? &quot;read&quot; : &quot;write&quot;, remote_accel_id, npa, local, size,
+		use_lsdma ? &quot;lsdma&quot; : &quot;sdma&quot;);
+
+	if (use_lsdma) {
+		r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
+					  read ? local : npa, size);
+		if (r)
+			return r;
+
+		goto done;
+	}
+
+	/* sdma linear copy command, align to 8 dwords boundary */
+	ndw = ALIGN(adev-&gt;mman.buffer_funcs-&gt;copy_num_dw, 8);
+
+	r = amdgpu_job_alloc_with_ib(adev, &amp;peer-&gt;entity, AMDGPU_FENCE_OWNER_VM,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &amp;job);
+	if (r)
+		return r;
+
+	ib = job-&gt;ibs;
+	ib-&gt;length_dw = 0;
+
+	amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
+				read ? local : npa, size, 0);
+	amdgpu_ring_pad_ib(&amp;adev-&gt;sdma.instance[0].ring, ib);
+	WARN_ON(ib-&gt;length_dw &gt; ndw);
+
+	fence = amdgpu_job_submit(job);
+
+	r = dma_fence_wait_timeout(fence, false, HZ * 10);
+	dma_fence_put(fence);
+	if (r &lt;= 0) {
+		dev_dbg(adev-&gt;dev, &quot;remote sdma fence wait timeout %d\n&quot;, r);
+		dev_dbg(adev-&gt;dev, &quot;use lsdma for testing afterwards\n&quot;);
+		remote-&gt;use_lsdma = true;
+		return -ETIME;
+	}
+
+done:
+	if (read)
+		memcpy(data, remote-&gt;rb_cpu_addr + offset, size);
+
+	return 0;
+}
+
+/* The peer may have rebooted or the vpod was reconfigured, adopt the remote
+ * wptr before sending a command, same as the handshake does.
+ */
+static int ualink_test_resync_peer(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	if (!adev-&gt;ualink.remote)
+		return -EINVAL;
+
+	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
+	if (r &lt; 0)
+		return r;
+
+	/* Peer moved, drop ready so the next command updates the wb address */
+	if (r)
+		amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
+
+	return 0;
+}
+
+int ualink_test_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_test_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
 	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
 }
 
+int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id,
+				 u64 addr, u32 size_in_pages, u32 flush_type)
+{
+	int r;
+
+	r = ualink_test_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
+					      size_in_pages, flush_type);
+}
+
+int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_test_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);
+
+	/* Update interrupt completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_REMOTE_INTERRUPT);
+	return r;
+}
+
+int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_test_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);
+
+	/* Update shootdown completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_TLB_INV);
+	return r;
+}
+
 /*
  * The low bits of handle_lo carry the message-header field on the wire.
  * Strip those bits and splice in @acc_id to recover the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..90e90cd8b495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
 	enum amdgpu_ualink_conn_state state;
 };
 
+/* UALINK ring buffer size, same for both remote shootdown and interrupt ring */
+#define AMDGPU_UALINK_RB_SIZE	4096
+
 struct amdgpu_ualink_remote;
 
 struct amdgpu_ualink_msg_ctl {
@@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* true for selftest driver path, ignore FW error */
+	bool selftesting;
+	/* serialize the selftest debugfs entries */
+	struct mutex selftest_mutex;
+	u32 test_size_dwords;
+	u32 test_remote_accel_id;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
@@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
 	unsigned long drop_msg_bitmap;
 };
 
+int ualink_test_local_data(struct amdgpu_device *adev, u32 remote_accel_id,
+			   void *data, u32 size, bool read);
+int ualink_test_remote_rw(struct amdgpu_device *adev, u32 remote_accel_id,
+			  void *data, u32 size, bool read, bool use_lsdma);
+int ualink_test_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
+int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id,
+				 u64 addr, u32 size_in_pages, u32 flush_type);
+int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
 				 unsigned int client_id, unsigned int src_id);
-
+void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type);
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
-int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
-
 int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev);
 int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
 int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------w6FvK5vsRaEAPKyp0Yu6lt0i--
