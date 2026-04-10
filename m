Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA36FF45A0A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 20:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777E910E1C5;
	Fri, 10 Apr 2026 20:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g3aaG09f";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9435010E1C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 20:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yla1ul7pxD9cdhD2P45uidynzMohZcben03m5hSlLNAOwhUwvlbdS7L+8GK0dTGCG59G2I59UnF8mALB5YPdTfyMn10SF4zWTYKU6YgTIFy538z6KAqu0ojreIcIO4zIf0QF5A/fVpe9DtX0WSS71PdXieQvD1XvC+7Kb9OwuA+F/w73Yn7KVAAeMgrzVV8cAbSZ/a04XVN30xKtKIUy8CvrCHVQEd3dxrYAjqx9ORxoasU0YehGnvL54rXz1qtNZqyWN4Ueyat/0IH5wWl7e42krUtHMIlvu18wsPzzFH/5Gtcn7QNHHQ4DTg/o3ZMrpdmhMHfg76OVd8lrgXb0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1Lr1v9bOr7iqkiteZqWRVwdPQwIKMCAewf4pzM2hM8=;
 b=J3TydbIjc+uGuWN4bTPVFlEMBMwoD7/oNiDOlyRj4T9AzWe+S7jVFBj/9ynArQWDOJ+ONCqW8HUTUHg7OP6aXQjlJbdkah00slRGbAA7X4uM+Jw8ZuH0F3tkrFLUWDnaMByokMb0+uw0VQM5caPuYwIKhZ0CckAYzpjvg6YK7VFdpOMU4m2HGBkAY5urPLH1kxWeuxQLV4xe7cUX15KMkbiUWZfBDk68JAhCNpnYsr38iYkWpDDVdjUslfXdX8F79LK02+xlLP8sRjeEOu/dpZfWMwdhfIgxZiDhsBTDe8DXfU7Bp+ucFYKR1IAzM/VWG/1siXMRG3fZ4qDfuAj6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1Lr1v9bOr7iqkiteZqWRVwdPQwIKMCAewf4pzM2hM8=;
 b=g3aaG09fXmiSInTEJEG3EsmU6FpFV8tv2jL/gMiy95vPbFULWNikWaYpMMX6ElZtBGAklpFPePFn57KHnpYUhrzMQKQacxNKTN1lQwVveDgL2MmdRkW7mNf7ejDgtppe/pEzMmx3D/olTxUtSk5LcrRAA1qYQzXM0sTEAj7VGAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 20:06:12 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 20:06:11 +0000
Content-Type: multipart/alternative;
 boundary="------------mSaiVf0ClCf73NETNX2JeMGJ"
Message-ID: <758d394a-9b2e-4d6e-95d0-4d110ae6de33@amd.com>
Date: Fri, 10 Apr 2026 16:06:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, JennyJing (Jenny Jing)" <JennyJing.Liu@amd.com>,
 "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20260326103656.487304-1-YuanShang.Mao@amd.com>
 <20e41c6f-811e-459e-aa33-2e864f04ab87@amd.com>
 <CO6PR12MB540914C9DBA3511BFD2B7513E050A@CO6PR12MB5409.namprd12.prod.outlook.com>
 <LV5PR12MB97772581D2D90604F36F00EE895AA@LV5PR12MB9777.namprd12.prod.outlook.com>
 <22741ffc-c355-49c4-9baf-a4940dd9cbcc@amd.com>
 <PH0PR12MB542097E50B9EEEF75CA4DC83E0592@PH0PR12MB5420.namprd12.prod.outlook.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB542097E50B9EEEF75CA4DC83E0592@PH0PR12MB5420.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: a6de3d1e-198a-4f94-ed7e-08de973c9ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: gQpy3Kruw6CvLTz1PBDH0cp9a4XNry8CQc1O59bA5KRs8sPdoKQmqCBG58wNwQx0x8YDeDUQw+5MW90azB0ZdngW46EobQOgWZRSrRlzkmhXViexmuKRohBl/hXOVYAZW4Z7T+Fikt2Fvcp28SaRlid3UQwzETzAxUvxyyxMkOGVlbC7RYVYBiPkeT3ikhMbx945bcLWa/spqK1OH8a78BdMY9otLg7nTaJSFKcvD9xpvXCNgiMdSiFqfKAJtP2uI4683XSuWnVjB/qPDdtdXKzC2qliyT7KAcy9FpmWQPBUYT45Y/bW3rUJg6WH81ee4X3mG+4sPYgzhXsjAuKPGQjKNOmVLJW2RErtMQwOnuOdo9+sdu0uHUiUV3bdj34wvhBXGIE8z0sERzyCaurySHOQ9toCRbUEdMx6FWMjZbzalrWjCsWJMQJTPX1fR6biY1UPmB8ShRYQS44fJ+KG8w59GwyTzev/OHNsrvXw3PkDNqk+vaOD7ILH322syvYSaT0hUzie1AlXcY02ersEOi3VsrB9/KRgkb7j73YpL5H/Ga2KNT310xYp+UiNM23n0WMWemk7SAb8+2ngSMfjPC0vJj8vYfU8mpo3w06MaR6cvOSo/ukRhH5yxZkzWjK5jEAxJh6/kZh/pwJYXD9ipL6UFZfSfZWa5y+OtZzBqD7x380c+KtE1siZJPmkmMPHhFo/UjokFGn5nN5bANcWDPHiRyXgu1Cli8sUiugdOp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hUR3NIdHdBTDJoTkJOSll0aHVhblFMT1R4dmRTTUNkWlR2U1EzK0NOMXNO?=
 =?utf-8?B?Yks1VFNHMlZmaXBLMEYwdzlacFFkSFlZVWdrUGxpdjZUaUpadTBnSW55ZFJW?=
 =?utf-8?B?TVVWV1NOTjcxcGhPNUc3VHEwK3RBOHlyZ2NnOGYvMU5BcUNDK0xjTUQzd2pl?=
 =?utf-8?B?YnZ6TW84bFpkcTZORDhGbnlyUFZ5NlV3RDM2b1V6ZWp0djR5dTQ5aDVxbmRx?=
 =?utf-8?B?c3EyNGJhMlppb3YvTVZvSUpWUk5oc3VhMmNkb0tGQmFoZjNJd2oxZEZ1bDJn?=
 =?utf-8?B?RHQzSFFySStzZWJTRXZmbk9qaWVZb1VRcENhaERJT1NWSzNrdExPbFQ1NWJY?=
 =?utf-8?B?MFp6K1N6WGRwUkNjZ09FZlJNL3V3bVM3ZWRyaFNSamdUaFM4RlgyUTJGZTFP?=
 =?utf-8?B?UnJUYWZ6S3NDV2dZZDNOU25rRDdvTDg4T2tuanAyQXFEQUtFMUFNZmFMbU1M?=
 =?utf-8?B?eDBjN0RCb2FwQUpYUWwwejEwQnhhYUhKWFQ1TEQ3aGcrTTVka0Z0VFZHQTFV?=
 =?utf-8?B?a21xVk85dTlvaFpEMGd2OUU0LzJWRTF1ZDgrNDllTEpuL3dKdWdDd2NsT01q?=
 =?utf-8?B?VEx4L0ZCcTNITlJIM1huYlRzRTF0ckhiK0Q4ZzRudE51dEN4emFkOVY1d2RS?=
 =?utf-8?B?bVl1UVE4NWtxU1dyOXMzVzFVZldxbzFWQjJIU0ViTWViNWlGR0dRaU9ycmZt?=
 =?utf-8?B?V2FzYmNVTEdTcE44bzRZQ1ZzNldscGh0WkRpcmttMDJhQTZjZ0l6d1B4ZDVp?=
 =?utf-8?B?ajBjSmZZMWw1bEd2UzJmLzlncmhwcEhzRENXWkJsY0o2YldKbXQ0dVBNR2JV?=
 =?utf-8?B?S3NDaXdicks3MG9GUGRobElkZXVVamVLVW5tQ1B2UGhuVGJJYTQzQXhiRU9P?=
 =?utf-8?B?TWNXRGZiOVp4Nkg4ZFFxUHBtZzJweDFzMnZ0Mk42SU9ndDFWZVREZTdJSTdV?=
 =?utf-8?B?S3FSYmdzdDJLeVU2eHdQZ3pBOGF4Tmt2cDVHazJYZDVwcDRjdUtETkQ4LzJQ?=
 =?utf-8?B?TitFeGh5b2N5dzhiODcvL2dMaG0zSTI5d0t0R0FmK0g5R1hZRFMxMHhDYlA1?=
 =?utf-8?B?bnpyZUYyLy81MlkwN0dYUmE4NnJUK096c1NKTWxIUEhGUjQ0M3U4QUlJWmdp?=
 =?utf-8?B?Y2htbFd6MkNyWHNCUm4vQ3FOUXZoWE1kQmcrMEQxdGFnTWp6d211T1hGeFRD?=
 =?utf-8?B?S1REb2IrMFZ4MlljekFYRzBWbUQ1VGx4NVB2WjQyT2FleTByc1Npem9ucDVD?=
 =?utf-8?B?d0lvUGVONE9UN3hsWGQrb2J3T3JUejFvcU1ZeWJKTXNMNTVNT1pVVVAyRmRY?=
 =?utf-8?B?TE9Zb1hkTlhJLzcwbHRrWFFsTnlKeUV1NmljdW01UlloQWVzMndiZy9vc0Vy?=
 =?utf-8?B?M3krOFJiNC9NcDZ4ZjdCOXRqZ0s4T0YyeVYxdzFKZkgvenRDcFg0Qmd0cWs4?=
 =?utf-8?B?M0pqOElHR28yazVlUmRTYmVVWHZMMXRGb0p1YitrNHJGM0JPdzJ3VVBFV05y?=
 =?utf-8?B?d2FqZGdtOXdQdVVqUmU3bjV3VVZhMHd3Y3JybGNJRnZZdDMxNSs0UVIvNXcx?=
 =?utf-8?B?VFNrUEd0Q3ZRWHByV1ZNZDk0azE0V05qb2lKUWwrL2FJcmw0RmtycWF1eDF4?=
 =?utf-8?B?VXlOUFNmZGVpR1VXQmkvNHZFWDNPUzk0cjBrQWVIKzdNdUx2a2FjTmJ3RHA4?=
 =?utf-8?B?QzJpYWNvTlJLbFpzTlBJY21mWXBYLytMYVo4akJJeW12S0ltL0xXVm96cUFY?=
 =?utf-8?B?azVPOVRMcEtFUkZPMFNRV3BoUmhXdVp5NGgzTXd4MmFqTVdzWmtrRFIwUmN3?=
 =?utf-8?B?NFB6TmE4QTViWUNzWllDRG1LRnlleHc1L1BHZ0JXN1p6eUNiUFFNRmo2SklQ?=
 =?utf-8?B?a0xIOFFJVldUYmxjUG9sYUNyUTBVWThON0cwNjQrTmhvY3JCWUYyWUtWRkpD?=
 =?utf-8?B?LytuR2Q5cUxWRVZISTNZQ05NaXRQdi8xSGxhajIweDd1eTVvWkdVaW9YUVVP?=
 =?utf-8?B?bUZqVlRzNGxuMEQ3dGVuWWp6TnY0M0ltamt0MThPamppR0ZLRkVOaC8rZUN1?=
 =?utf-8?B?R0hMVVNKZW5FdUMxZ3pWaWM0bUZPZGlubEMzQnlzREI5Z2NYZXhtTUo1aTJU?=
 =?utf-8?B?REQ0OXdwaFVoUDJCM3BsN1lnd09VemZJb1dnNGhnL3lNOU1jUnNuMlZNWDhL?=
 =?utf-8?B?TlU4RGdNZEU1VFY4bFRGMXpocEM4WVpaWEhTekZlS0VjSzVIU3J3djR5SXRr?=
 =?utf-8?B?N1hCc3ZrNDJIMUcrd0FQTURHSlZTNFFOWURvQjdraUNUeHltZWk5TXAvRFFK?=
 =?utf-8?Q?qhbl1MZPmLuRQU2I+0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6de3d1e-198a-4f94-ed7e-08de973c9ca8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 20:06:11.7626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqrkK5nWI/NVjl9K78Oa3zE1/Es+hckngT2cW0ZW2QExoXh0d9/l8jBE+fNUFWYO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
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

--------------mSaiVf0ClCf73NETNX2JeMGJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-04-10 01:51, YuanShang Mao (River) wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Hi @Yang, Philip <mailto:Philip.Yang@amd.com>
> Here is the log:
>
> [ 2 17 16:41:58 2026 <   24.787659>] [drm:amddrm_sched_entity_push_job 
> [amd_sched]] *ERROR* Trying to push to a killed entity
> [ 2 17 16:42:43 2026 <    0.000000>] amdgpu 0000:00:08.0: clean up the 
> vf2pf work item
> [ 2 17 16:42:51 2026 <    7.951077>] amdgpu 0000:00:08.0: ring sdma0 
> timeout, signaled seq=2567, emitted seq=2568
> [ 2 17 16:42:51 2026 <    0.001734>] amdgpu 0000:00:08.0:  Process 
> quark pid 8325 thread quark pid 8328
> [ 2 17 16:42:51 2026 <    0.001475>] amdgpu 0000:00:08.0: GPU reset 
> begin!. Source:  1
> [ 2 17 16:42:51 2026 <    0.000026>] amdgpu 0000:00:08.0: Suspending 
> all queues failed
> [ 2 17 16:42:51 2026 <    0.008520>] amdgpu 0000:00:08.0: [drm] PCIE 
> GART of 512M enabled (table at 0x000000800D300000).
> [ 2 17 16:42:51 2026 <    0.204760>] amdgpu 0000:00:08.0: GPU reset(6) 
> succeeded!
> [ 2 17 16:42:51 2026 <    0.000010>] amdgpu 0000:00:08.0: [drm] device 
> wedged, but recovered through reset
> *[ 2 17 16:44:02 2026 <    0.000000>] INFO: task kworker/10:3:7194 
> blocked for more than 122 seconds.*
> [ 2 17 16:44:02 2026 <    0.001502>]       Tainted: G           OE     
>  6.8.0-90-generic #91~22.04.1-Ubuntu
> [ 2 17 16:44:02 2026 <    0.001533>] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2 17 16:44:02 2026 <    0.001597>] task:kworker/10:3    state:D 
> stack:0     pid:7194  tgid:7194  ppid:2      flags:0x00004000
> *[ 2 17 16:44:02 2026 <    0.000006>] Workqueue: events_freezable 
> svm_range_restore_work [amdgpu]
> [ 2 17 16:44:02 2026 <    0.000282>] Call Trace:*
> [ 2 17 16:44:02 2026 <    0.000002>]  <TASK>
> [ 2 17 16:44:02 2026 <    0.000004>]  __schedule+0x27c/0x6a0
> [ 2 17 16:44:02 2026 <    0.000008>]  schedule+0x33/0x110
> [ 2 17 16:44:02 2026 <    0.000003>]  schedule_timeout+0x157/0x170
> [ 2 17 16:44:02 2026 <    0.000005>]  dma_fence_default_wait+0x13d/0x210
> [ 2 17 16:44:02 2026 <    0.000004>]  ? 
> __pfx_dma_fence_default_wait_cb+0x10/0x10
> [ 2 17 16:44:02 2026 <    0.000003>]  dma_fence_wait_timeout+0x116/0x140
> [ 2 17 16:44:02 2026 <    0.000003>] 
>  svm_range_validate_and_map+0xf7c/0x19c0 [amdgpu]
> [ 2 17 16:44:02 2026 <    0.000218>] 
>  svm_range_restore_work+0xe5/0x340 [amdgpu]
> [ 2 17 16:44:02 2026 <    0.000197>]  process_one_work+0x181/0x3a0
> [ 2 17 16:44:02 2026 <    0.000005>]  worker_thread+0x306/0x440
> [ 2 17 16:44:02 2026 <    0.000003>]  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> [ 2 17 16:44:02 2026 <    0.000004>]  ? _raw_spin_lock_irqsave+0xe/0x20
> [ 2 17 16:44:02 2026 <    0.000003>]  ? __pfx_worker_thread+0x10/0x10
> [ 2 17 16:44:02 2026 <    0.000002>]  kthread+0xef/0x120
> [ 2 17 16:44:02 2026 <    0.000005>]  ? __pfx_kthread+0x10/0x10
> [ 2 17 16:44:02 2026 <    0.000003>]  ret_from_fork+0x44/0x70
> [ 2 17 16:44:02 2026 <    0.000004>]  ? __pfx_kthread+0x10/0x10
> [ 2 17 16:44:02 2026 <    0.000003>]  ret_from_fork_asm+0x1b/0x30
> [ 2 17 16:44:02 2026 <    0.000005>]  </TASK>
> [ 2 17 16:46:05 2026 <  122.874606>] INFO: task kworker/10:3:7194 
> blocked for more than 245 seconds.
>
>
> drm sched entitycould be destroyed by *amdgpu_flush* if the process is 
> killed forcibly even vm refcountis  not zero.
>
I see, patch "drm/amdkfd: Don't clear PT after process killed" fixed one 
path, this patch fix another different path.

Thanks, this patch is

Reviewed-by: Philip Yang <philip.yang@amd.com>

>
> Thanks
> River
>
> *From:*Yang, Philip <Philip.Yang@amd.com>
> *Sent:* Thursday, April 9, 2026 11:33 PM
> *To:* Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>; YuanShang Mao 
> (River) <YuanShang.Mao@amd.com>; Yang, Philip <Philip.Yang@amd.com>; 
> Koenig, Christian <Christian.Koenig@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org; Liu, JennyJing (Jenny Jing) 
> <JennyJing.Liu@amd.com>
> *Subject:* Re: [PATCH] drm/amdkfd: check if vm ready in svm map and 
> unmap to gpu
>
> On 2026-04-07 03:45, Zhang, Tiantian (Celine) wrote:
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     Hi @Yang, Philip <mailto:Philip.Yang@amd.com>,
>
>     Could you please help to review this patch, thanks a lot~
>
>     Best Regards,
>
>     Celine Zhang
>
>     -----Original Message-----
>     From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
>     <mailto:YuanShang.Mao@amd.com>
>     Sent: Wednesday, April 1, 2026 5:56 PM
>     To: Yang, Philip <Philip.Yang@amd.com> <mailto:Philip.Yang@amd.com>
>     Cc: Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org;
>     Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>
>     <mailto:Tiantian.Zhang@amd.com>
>     Subject: RE: [PATCH] drm/amdkfd: check if vm ready in svm map and
>     unmap to gpu
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     Hi @Yang, Philip
>
>     Could help review this patch?
>
>     Thanks
>
>     River
>
>     -----Original Message-----
>
>     From: Koenig, Christian <Christian.Koenig@amd.com
>     <mailto:Christian.Koenig@amd.com>>
>
>     Sent: Tuesday, March 31, 2026 7:32 PM
>
>     To: YuanShang Mao (River) <YuanShang.Mao@amd.com
>     <mailto:YuanShang.Mao@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>; Yang, Philip
>     <Philip.Yang@amd.com <mailto:Philip.Yang@amd.com>>
>
>     Subject: Re: [PATCH] drm/amdkfd: check if vm ready in svm map and
>     unmap to gpu
>
>     On 3/26/26 11:36, YuanShang wrote:
>
>     > Don't map or unmap svm range to gpu if vm is not ready for updates.
>
>     >
>
>     > Why: DRM entity may already be killed when the svm worker try to
>
>     > update gpu vm.
>
>     >
>
>     > Signed-off-by: YuanShang <YuanShang.Mao@amd.com
>     <mailto:YuanShang.Mao@amd.com>>
>
>     Looks correct to me, but I think somebody else already added those
>     checks.
>
>     @Philip is that correct? If not please help reviewing the patch.
>
>     Thanks,
>
>     Christian.
>
>     > ---
>
>     > drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++++
>
>     >  1 file changed, 11 insertions(+)
>
>     >
>
>     > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     > b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     > index 8167fe642341..7f905a7805fa 100644
>
>     > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     > @@ -1366,6 +1366,12 @@ svm_range_unmap_from_gpu(struct
>     amdgpu_device
>
>     > *adev, struct amdgpu_vm *vm,
>
>     >
>
>     >       pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n",
>     start, last,
>
>     >               gpu_start, gpu_end);
>
>     > +
>
>     > +     if (!amdgpu_vm_ready(vm)) {
>
>     > +             pr_debug("VM not ready, canceling unmap\n");
>
>     > +             return -EINVAL;
>
>     > +     }
>
>     > +
>
> The change looks fine, but it is unnecessary after checking the 
> details of amdgpu_vm_ready.
>
> It is impossible the "DRM entity may already be killed when the svm 
> worker try to update gpu vm",
> guessing the svm worker is p->svms.restore_work, svm_range_list_fini 
> cancel the work or wait for
> it to finish. kfd_process_wq_release does svm_range_list_fini first, 
> then fput(pdd->drm_file) to reduce
> the vm refcount, then calls amdgpu_vm_fini, to destroy drm sched entity.
>
> If you see the real issue, please post the dmesg log to help understand.
>
> Regards,
> Philip
>
>
>
>     >       return amdgpu_vm_update_range(adev, vm, false, true, true,
>     false, NULL, gpu_start,
>
>     > gpu_end, init_pte_value, 0, 0, NULL, NULL,
>
>     > fence); @@ -1443,6 +1449,11 @@
>
>     > svm_range_map_to_gpu(struct kfd_process_device *pdd, struct
>     svm_range *prange,
>
>     >       pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n",
>     prange->svms,
>
>     >                last_start, last_start + npages - 1, readonly);
>
>     >
>
>     > +     if (!amdgpu_vm_ready(vm)) {
>
>     > +             pr_debug("VM not ready, canceling map\n");
>
>     > +             return -EINVAL;
>
>     > +     }
>
>     > +
>
>     >       for (i = offset; i < offset + npages; i++) {
>
>     >               uint64_t gpu_start;
>
>     >               uint64_t gpu_end;
>

--------------mSaiVf0ClCf73NETNX2JeMGJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-10 01:51, YuanShang Mao
      (River) wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB542097E50B9EEEF75CA4DC83E0592@PH0PR12MB5420.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	color:black;
	mso-ligatures:standardcontextual;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;
	mso-ligatures:standardcontextual;}span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}span.EmailStyle23
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="color:windowtext">Hi <a id="OWAAMDAA6BAE4941449119FEF7C7D072B74B2" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">
                <span style="font-family:&quot;Aptos&quot;,sans-serif;text-decoration:none">@Yang,
                  Philip</span></a>
              <br>
              Here is the log:<br>
              <br>
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext">[ 2 17
              16:41:58 2026 &lt; &nbsp; 24.787659&gt;]
              [drm:amddrm_sched_entity_push_job [amd_sched]] *ERROR*
              Trying to push to a killed entity<br>
              [ 2 17 16:42:43 2026 &lt; &nbsp; &nbsp;0.000000&gt;] amdgpu
              0000:00:08.0: clean up the vf2pf work item<br>
              [ 2 17 16:42:51 2026 &lt; &nbsp; &nbsp;7.951077&gt;] amdgpu
              0000:00:08.0: ring sdma0 timeout, signaled seq=2567,
              emitted seq=2568<br>
              [ 2 17 16:42:51 2026 &lt; &nbsp; &nbsp;0.001734&gt;] amdgpu
              0000:00:08.0: &nbsp;Process quark pid 8325 thread quark pid
              8328<br>
              [ 2 17 16:42:51 2026 &lt; &nbsp; &nbsp;0.001475&gt;] amdgpu
              0000:00:08.0: GPU reset begin!. Source: &nbsp;1<br>
              [ 2 17 16:42:51 2026 &lt; &nbsp; &nbsp;0.000026&gt;] amdgpu
              0000:00:08.0: Suspending all queues failed<br>
              [ 2 17 16:42:51 2026 &lt; &nbsp; &nbsp;0.008520&gt;] amdgpu
              0000:00:08.0: [drm] PCIE GART of 512M enabled (table at
              0x000000800D300000).<br>
              [ 2 17 16:42:51 2026 &lt; &nbsp; &nbsp;0.204760&gt;] amdgpu
              0000:00:08.0: GPU reset(6) succeeded!<br>
              [ 2 17 16:42:51 2026 &lt; &nbsp; &nbsp;0.000010&gt;] amdgpu
              0000:00:08.0: [drm] device wedged, but recovered through
              reset<br>
              <b>[ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000000&gt;] INFO: task
                kworker/10:3:7194 blocked for more than 122 seconds.</b><br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.001502&gt;] &nbsp; &nbsp; &nbsp; Tainted:
              G &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; OE &nbsp; &nbsp; &nbsp;6.8.0-90-generic #91~22.04.1-Ubuntu<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.001533&gt;] &quot;echo 0 &gt;
              /proc/sys/kernel/hung_task_timeout_secs&quot; disables this
              message.<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.001597&gt;]
              task:kworker/10:3 &nbsp; &nbsp;state:D stack:0 &nbsp; &nbsp; pid:7194
              &nbsp;tgid:7194 &nbsp;ppid:2 &nbsp; &nbsp; &nbsp;flags:0x00004000<br>
              <b>[ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000006&gt;] Workqueue:
                events_freezable svm_range_restore_work [amdgpu]<br>
                [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000282&gt;] Call Trace:</b><br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000002&gt;] &nbsp;&lt;TASK&gt;<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000004&gt;]
              &nbsp;__schedule+0x27c/0x6a0<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000008&gt;]
              &nbsp;schedule+0x33/0x110<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000003&gt;]
              &nbsp;schedule_timeout+0x157/0x170<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000005&gt;]
              &nbsp;dma_fence_default_wait+0x13d/0x210<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000004&gt;] &nbsp;?
              __pfx_dma_fence_default_wait_cb+0x10/0x10<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000003&gt;]
              &nbsp;dma_fence_wait_timeout+0x116/0x140<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000003&gt;]
              &nbsp;svm_range_validate_and_map+0xf7c/0x19c0 [amdgpu]<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000218&gt;]
              &nbsp;svm_range_restore_work+0xe5/0x340 [amdgpu]<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000197&gt;]
              &nbsp;process_one_work+0x181/0x3a0<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000005&gt;]
              &nbsp;worker_thread+0x306/0x440<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000003&gt;] &nbsp;?
              srso_alias_return_thunk+0x5/0xfbef5<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000004&gt;] &nbsp;?
              _raw_spin_lock_irqsave+0xe/0x20<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000003&gt;] &nbsp;?
              __pfx_worker_thread+0x10/0x10<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000002&gt;]
              &nbsp;kthread+0xef/0x120<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000005&gt;] &nbsp;?
              __pfx_kthread+0x10/0x10<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000003&gt;]
              &nbsp;ret_from_fork+0x44/0x70<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000004&gt;] &nbsp;?
              __pfx_kthread+0x10/0x10<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000003&gt;]
              &nbsp;ret_from_fork_asm+0x1b/0x30<br>
              [ 2 17 16:44:02 2026 &lt; &nbsp; &nbsp;0.000005&gt;] &nbsp;&lt;/TASK&gt;<br>
              [ 2 17 16:46:05 2026 &lt; &nbsp;122.874606&gt;] INFO: task
              kworker/10:3:7194 blocked for more than 245 seconds.<br>
              <br>
              <br>
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span style="mso-ligatures:none">drm
              sched entity</span><span style="mso-ligatures:none"> could
              be destroyed by
              <b>amdgpu_flush</b> if the process is killed forcibly even
            </span><span style="mso-ligatures:none">vm refcount</span><span style="mso-ligatures:none"> is &nbsp;not zero.&nbsp;<br>
            </span></p>
        </div>
      </div>
    </blockquote>
    I see, patch &quot;drm/amdkfd: Don't clear PT after process killed&quot; fixed
    one path, this patch fix another different path.<br>
    <br>
    Thanks, this patch is&nbsp;<br>
    <br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <br>
    <blockquote type="cite" cite="mid:PH0PR12MB542097E50B9EEEF75CA4DC83E0592@PH0PR12MB5420.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="mso-ligatures:none"><br>
              Thanks<br>
              River</span><span style="color:windowtext"><o:p></o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext;mso-ligatures:none">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext;mso-ligatures:none">
                  Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Thursday, April 9, 2026 11:33 PM<br>
                  <b>To:</b> Zhang, Tiantian (Celine)
                  <a class="moz-txt-link-rfc2396E" href="mailto:Tiantian.Zhang@amd.com">&lt;Tiantian.Zhang@amd.com&gt;</a>; YuanShang Mao (River)
                  <a class="moz-txt-link-rfc2396E" href="mailto:YuanShang.Mao@amd.com">&lt;YuanShang.Mao@amd.com&gt;</a>; Yang, Philip
                  <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Koenig, Christian
                  <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
                  <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Liu,
                  JennyJing (Jenny Jing) <a class="moz-txt-link-rfc2396E" href="mailto:JennyJing.Liu@amd.com">&lt;JennyJing.Liu@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdkfd: check if vm
                  ready in svm map and unmap to gpu<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal" style="margin-bottom:12.0pt"><span style="mso-ligatures:none"><o:p>&nbsp;</o:p></span></p>
          <div>
            <p class="MsoNormal">On 2026-04-07 03:45, Zhang, Tiantian
              (Celine) wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
            <p class="MsoNormal"><span style="mso-ligatures:none"><o:p>&nbsp;</o:p></span></p>
            <div>
              <p class="MsoPlainText">Hi <a id="OWAAM29C89DAFD5E14DD4AF1FCC5361A59632" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">
                  <span style="font-family:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Yang,
                    Philip</span></a>,<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">Could you please help to review
                this patch, thanks a lot~<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">Best
                  Regards,</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">Celine
                  Zhang</span><o:p></o:p></p>
              <p class="MsoPlainText">-----Original Message-----<br>
                From: YuanShang Mao (River) <a href="mailto:YuanShang.Mao@amd.com" moz-do-not-send="true">&lt;YuanShang.Mao@amd.com&gt;</a>
                <br>
                Sent: Wednesday, April 1, 2026 5:56 PM<br>
                To: Yang, Philip <a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a><br>
                Cc: Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                Zhang, Tiantian (Celine)
                <a href="mailto:Tiantian.Zhang@amd.com" moz-do-not-send="true">&lt;Tiantian.Zhang@amd.com&gt;</a><br>
                Subject: RE: [PATCH] drm/amdkfd: check if vm ready in
                svm map and unmap to gpu<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">[AMD Official Use Only - AMD
                Internal Distribution Only]<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">Hi @Yang, Philip<o:p></o:p></p>
              <p class="MsoPlainText">Could help review this patch?<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">Thanks<o:p></o:p></p>
              <p class="MsoPlainText">River<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">-----Original Message-----<o:p></o:p></p>
              <p class="MsoPlainText">From: Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">Christian.Koenig@amd.com</span></a>&gt;<o:p></o:p></p>
              <p class="MsoPlainText">Sent: Tuesday, March 31, 2026 7:32
                PM<o:p></o:p></p>
              <p class="MsoPlainText">To: YuanShang Mao (River) &lt;<a href="mailto:YuanShang.Mao@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">YuanShang.Mao@amd.com</span></a>&gt;;
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">amd-gfx@lists.freedesktop.org</span></a>;
                Yang, Philip &lt;<a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">Philip.Yang@amd.com</span></a>&gt;<o:p></o:p></p>
              <p class="MsoPlainText">Subject: Re: [PATCH] drm/amdkfd:
                check if vm ready in svm map and unmap to gpu<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">On 3/26/26 11:36, YuanShang wrote:<o:p></o:p></p>
              <p class="MsoPlainText">&gt; Don't map or unmap svm range
                to gpu if vm is not ready for updates.<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; Why: DRM entity may already
                be killed when the svm worker try to
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; update gpu vm.<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; Signed-off-by: YuanShang &lt;<a href="mailto:YuanShang.Mao@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">YuanShang.Mao@amd.com</span></a>&gt;<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">Looks correct to me, but I think
                somebody else already added those checks.<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">@Philip is that correct? If not
                please help reviewing the patch.<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">Thanks,<o:p></o:p></p>
              <p class="MsoPlainText">Christian.<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; ---<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;
                drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++++<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp; 1 file changed, 11
                insertions(+)<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; diff --git
                a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></p>
              <p class="MsoPlainText">&gt; index
                8167fe642341..7f905a7805fa 100644<o:p></o:p></p>
              <p class="MsoPlainText">&gt; ---
                a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +++
                b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></p>
              <p class="MsoPlainText">&gt; @@ -1366,6 +1366,12 @@
                svm_range_unmap_from_gpu(struct amdgpu_device
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; *adev, struct amdgpu_vm *vm,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;CPU[0x%llx
                0x%llx] -&gt; GPU[0x%llx 0x%llx]\n&quot;, start, last,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_start,
                gpu_end);<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if
                (!amdgpu_vm_ready(vm)) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VM
                not ready, canceling unmap\n&quot;);<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +<o:p></o:p></p>
            </div>
          </blockquote>
          <p class="MsoNormal"><span style="mso-ligatures:none">The
              change looks fine, but it is unnecessary after checking
              the details of amdgpu_vm_ready.<br>
              <br>
              It is impossible the &quot;DRM entity may already be killed
              when the svm worker try to update gpu vm&quot;,<br>
              guessing the svm worker is p-&gt;svms.restore_work,
              svm_range_list_fini cancel the work or wait for<br>
              it to finish. kfd_process_wq_release does
              svm_range_list_fini first, then fput(pdd-&gt;drm_file) to
              reduce<br>
              the vm refcount, then calls amdgpu_vm_fini, to destroy drm
              sched entity.<br>
              <br>
              If you see the real issue, please post the dmesg log to
              help understand.<br>
              <br>
              Regards,<br>
              Philip<br>
              <br>
              <br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
                amdgpu_vm_update_range(adev, vm, false, true, true,
                false, NULL, gpu_start,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                gpu_end, init_pte_value, 0, 0, NULL, NULL,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                fence); @@ -1443,6 +1449,11 @@
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; svm_range_map_to_gpu(struct
                kfd_process_device *pdd, struct svm_range *prange,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p
                [0x%lx 0x%lx] readonly %d\n&quot;, prange-&gt;svms,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start,
                last_start + npages - 1, readonly);<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if
                (!amdgpu_vm_ready(vm)) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VM
                not ready, canceling map\n&quot;);<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt; +<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = offset; i &lt;
                offset + npages; i++) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t
                gpu_start;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t
                gpu_end;<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
            </div>
          </blockquote>
          <p class="MsoNormal"><span style="mso-ligatures:none"><o:p>&nbsp;</o:p></span></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------mSaiVf0ClCf73NETNX2JeMGJ--
