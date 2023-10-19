Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E687CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 16:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A5B10E526;
	Thu, 19 Oct 2023 16:05:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5333C10E526
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 16:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzht/fsrer1FxXFOBfypBVYz6i9efR2PKJuejHJk0I2ZRaKQWD1Iam/Se/VC3GRPhWYkzmgXbpS28MqU43xIBPJ/ba/ownxJpccVFw6Y3bY2QCruQaqTN0Q3TSGn9T2j+DuLsydL2r4KuxyeSK0FLKLL+KFjgBgvyhXmdgZiigzY4vbfNWInQRt8kWVDZAmKLXVRaF38xM9RfUW2KwI3Z4p4SxgUG9eEPYuM+YtVrMeMtvDQLXYsDnb45dDSFJnPZ9Jp86RFPrC/QCBzb809GCtpfYFc87yXWiobmpotLLkWYj9CSYERJ20LlslAW3OECakiRWSBA3yb9LjO9AMAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCPMYdMHHlzgJW+KzMJVTquB1VJ4ELWjr45mHWKJatI=;
 b=PVVQ3agiMs32Csl/mOBw8nSekOiaZnVXHvpjhdk5q8jtOIwoN5cXsmPoVUOoRiR7yKsrRjrDuOcdi0KDCRoVwib0R81qptlg/Redd202tF+aI3DyATq4StbGgTMq709lLwZkyxsAvr6m3FM+BLNBSV015Qa6nIusIlPs6xImZqurzGOXt4LkVEKR0exoL6cc7tmO3/l19s1U4tAfndYwA6bg9mF1ly1n/RqfgVu99a6KGCxjF+ere0RTlxfelI0YPnlezDR1FVBmQQLqM4Are9V+YZYq8Sm2GF2+aLdbcoyizhg8drDxU0OwpHMJykn7i8U5SHp4zIFsGDVQt2bPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCPMYdMHHlzgJW+KzMJVTquB1VJ4ELWjr45mHWKJatI=;
 b=epQJ5MZdws2xCk6ucGahjHZ1QqOBL4kYCG2cqXiEzaqothNpqjDp4DMcfZtfshCVv12U/gAh77XOj1Pi5asWSun1ZzuGg3IwVoguRrKmT3STRVbuwhR4B7MgkArpBwO+eltPdGJdoBHMjiwiTFXqARds4ky/OVMoYbkz8Jh0Up8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 16:05:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 16:05:28 +0000
Message-ID: <260b5793-68bf-4a65-b4db-594184572c1a@amd.com>
Date: Thu, 19 Oct 2023 12:05:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add timeout for sync wait
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231019093103.100939-1-Emily.Deng@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231019093103.100939-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0450.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 94be2088-0547-4cab-e889-08dbd0bd3679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlnejCcj7UR/+iFeS+g6sMIF3Xe/ifTOoP8OcL2BZn4h00KmZjc6GzOpQ39re0ODhWM535gTJND+fcE+IOp8UBF7yhsWHCVHg7RI2eeadZTyDD8Nvsv+4c9uw9vYULvf2fHFLSKwuN3DXXDxmTY4RgQ61J6eyA/HRZjZ7pGi0H5DvoQwKz0eNh5wzOB65WNFfzE/UlmFbwdK+kTl4CbgZbcvsjxjj9DI+mS6ioPHKLb1arcvCYo4ZIBbk+H0iaWwIN7RdPu6UonWYcva1BEeQwQLhNeXf+KVUytImNqlNKDVPVQQllQcM7eG3uLoufT4wThCt4jQtWNP1iD9vITK3kkkd9eXZG5zMvhJByoyTsSez+jm3Avxt0wbFuzkOg62T+MG+UaKG8nsSB9/yMsc64RgmzaDDiuIbnV279NfWd17diO1HzfE5gpxeAg5wLDaf3i75kgeZJ5ZVWdGCOCQFmcxZnmfxeV+IkRZayrJdG3Dr3SbC0ca2eP12FWLoCAISt4Bi0yCX0NX+pwK7eFWiv+8CvPy7drDQZR0FKa+ZLX08dCd/RWg2Kx7/gJNfMIXNaKraj9WUrR5xAg506svuLOduWgJNxbOkqu56Xi19DoC8hrIZd4Hk1edbUvSlU94Dq9sAffN9mQ/JvODHOukrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(83380400001)(66476007)(38100700002)(31696002)(36756003)(2616005)(6512007)(2906002)(4001150100001)(86362001)(66556008)(316002)(8676002)(41300700001)(8936002)(66946007)(5660300002)(44832011)(478600001)(6506007)(53546011)(36916002)(6486002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhKM0cvTitONGhMbnRUNGcyeDRiTW5XZTZqb0Z2V2UvcEorVDBPYlZIZ05z?=
 =?utf-8?B?d0lFZTZEY3Q3cGR6dWV6Rzc1MFdIanBUT2N2YkljYVdhUEdBMU81WldZbVg4?=
 =?utf-8?B?a3RGUGg0QmFManFDNTBBZkY0YnFrWi8zRXA5NERHS1Y2am82UHNtaU1lQ21I?=
 =?utf-8?B?cUl6ZU1pajBkdFBJaEVvTnlNY2RKRWlyeDdNdk1vWWFWUFJKblFhSGxuZUlH?=
 =?utf-8?B?ajRDRjNhM1RUa1Foa0pBUCtXbGlyUktRS1ludVBObERlQW11aGdZakxhejRI?=
 =?utf-8?B?MGdCSCtBUGJnUmNQaVkrQ0dMMTlOcFNtdm9Xai83cjhScDZ4M0h6WFJLSVZj?=
 =?utf-8?B?MW5rdkNlQWhDNE53dUlFTFZFbEc5dTV5WlZGRmdJSWtvckJhcHBRNGQ3Yno3?=
 =?utf-8?B?VzMzQzNjekowMnloYlE1Sjd2Q1Ric0FDNDZydGxrMGJmM3M3RngrcWIyNG1x?=
 =?utf-8?B?SFp0RVQxVEVmQ1p0bGpwdmNvYXhha1dFRGIreit2clBhd21uMGJEUWZDaEo4?=
 =?utf-8?B?czdWUlg0NGpNeG9SREpYb1JqalpuN2RMc25JY2kvSXV3VStmdWtrTTJpVk5C?=
 =?utf-8?B?Y1ZZZGFWMXlBK3JzYkZycExMRC8yUWNsUDdmbytXaG92QjBoOHl6c2JkM2F3?=
 =?utf-8?B?MW1SQ0kzWm54S0tKUFRlNld2L1licWh1L2hCZmtrYnMrdFpLbG8ydU1ld0pz?=
 =?utf-8?B?NHErcEwzK01JMVRLTDQ1cU9WTmw3M2tJMk92cWtPY09KSzJaaEdFelFtL0Fl?=
 =?utf-8?B?RDFWRlM4RGFsUk0yS0lLTFN0bU5DL0toaXJDRGtyVXFOZzBJMDgwUDlYOFVh?=
 =?utf-8?B?bkdNNEppVXQ5dE14MHFaVUtiTWU0T25JWUJ4SW5xTTRkV2pId2Fobmw1ZG8w?=
 =?utf-8?B?S2gyTmNCRUR0djlLTGdaS3dLK3NmWDN2UlZ0Q1ZTbjROY25aT3BLaGRpOFhS?=
 =?utf-8?B?bUxzOHhXb1BHeVEvcDU3VThGU1ArZklza2JjY3RwbXJQbTlFVUlSNHlXeVhO?=
 =?utf-8?B?QkFEWS9xUHI1VmJQMHV5dDU0TVg1UU1na1REVWRTb2lTVDJ4ZnlkWEduZ2hz?=
 =?utf-8?B?VG13dTFWZVlNMW4zUzk1OXdna3JiZlhqZFRoMnpoNDdjajYrZFVNeEFZNUx1?=
 =?utf-8?B?SGNpZVR6K21rVm15cFM5cU16c2ZBY3AyWUlwZ1puV3JWWkhNZUlZYjVSbkJP?=
 =?utf-8?B?Y005alhubjhuVDdoWG1IYzFqRGR1eFVwejZYY01qSHZKK0ZjOUlmVXBkUG5G?=
 =?utf-8?B?eDBGd0g2Y29DUnNqdkRVL0ZvbC9ZS3N3TFYrdktURHBZdWNlQ1hNVS9lSU9G?=
 =?utf-8?B?UDlnaDhRbkxYVnAwb1IrT3hocnJhZGFFb2x6dDhVRVh4YTArVkIxV0l0cjh3?=
 =?utf-8?B?OFFoaTZjRjhpU0tGaGpNUlNVbjFCMm4rTG5kUVlCd3ZhdmVpaU1KeG04VlBD?=
 =?utf-8?B?MXI5L1hrQlZLamJLYkEraFExM0tVSzY4T2E1WndOSXI2NVVoVUxSb0hNaTFD?=
 =?utf-8?B?OUFXVU5FdTBDaHRDMEQyRUQrWnljSHhtMHZHckRpQ1JLdk1SUi9sUWJyblB3?=
 =?utf-8?B?MUxLL3l4V3R5YXlLdG84VlFJc2d3YWVXL0tzcGhyVHRZbzdZNmI0Q2NTOW5k?=
 =?utf-8?B?M1pzb3czbjJvTEVIK2xjc1IzMDlJa0syM1Y5Wmd1R21kbDNvOGc1Ym44alM1?=
 =?utf-8?B?bXAwN05EVzFNQ3FIUXdRMi9aekUzNGZMK1lDakgrUUdkUENhNFBCSWN0NEtW?=
 =?utf-8?B?Y1V5UlhCTlg1dXNYUHJQdFJWNDVjODJJSEk2OUlaazFoU0NXQzlETnZkcDJP?=
 =?utf-8?B?dUZiT3JGNGEzRThKY2E2bkRHaWJzYnhvN1hwbU91dHpUa1AvUXlCTjN4OXl5?=
 =?utf-8?B?ekpyYUkwU0k5Zy9FY2w0SVZSYTd2WFBqOVI1Umw2Vi9zVlJzMlVtWGh3aUg0?=
 =?utf-8?B?UDFnd05OQk52bURnbU1MTjR0SFdJeGgxYytTeEZpTUdiOXZGeFZFRE5ZY1VZ?=
 =?utf-8?B?Z0JxWDErWVg3ZkRBRDM4U1RQQ0IyTVUxMW9hbnVJR0ZsMUVFUTdNMnluY3ZD?=
 =?utf-8?B?SUZHRHBIWHAwVHpMMTFSNWxZc3VEVzRzWlArTGFqaVkvQWpLMEFzek11TDNH?=
 =?utf-8?Q?NpUE0D7YG429E0DCIeLCIln/G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94be2088-0547-4cab-e889-08dbd0bd3679
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 16:05:28.5698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlrWPBGg7rvQkzf3HzbsCk76Qh7+2C7eKgG8CfOEIrIfdLvayWwrKZzaFOmHalKzEye5H0h3BDfN74df1MGXJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
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

On 2023-10-19 05:31, Emily Deng wrote:
> Issue: Dead heappen during gpu recover
>
> [56433.829492] amdgpu 0000:04:00.0: amdgpu: GPU reset begin!
> [56550.499625] INFO: task kworker/u80:0:10 blocked for more than 120 seconds.
> [56550.520215]       Tainted: G           OE      6.2.0-34-generic #34~22.04.1-Ubuntu
> [56550.542883] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [56550.566313] task:kworker/u80:0   state:D stack:0     pid:10    ppid:2      flags:0x00004000
> [56550.591318] Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
> [56550.611391] Call Trace:
> [56550.618698]  <TASK>
> [56550.624968]  __schedule+0x2b7/0x5f0
> [56550.635416]  schedule+0x68/0x110
> [56550.645090]  schedule_timeout+0x151/0x160
> [56550.657096]  ? amdgpu_vm_bo_update+0x46e/0x660 [amdgpu]
> [56550.673245]  dma_fence_default_wait+0x1a2/0x1e0
> [56550.686818]  ? __pfx_dma_fence_default_wait_cb+0x10/0x10
> [56550.702728]  dma_fence_wait_timeout+0x117/0x140
> [56550.716301]  amdgpu_sync_wait+0x62/0xa0 [amdgpu]
> [56550.730654]  amdgpu_amdkfd_gpuvm_restore_process_bos+0x59e/0x770 [amdgpu]
> [56550.751668]  ? newidle_balance+0x298/0x490
> [56550.763936]  restore_process_worker+0x42/0x270 [amdgpu]
> [56550.780183]  process_one_work+0x21f/0x440
> [56550.792193]  worker_thread+0x50/0x3f0
> [56550.803165]  ? __pfx_worker_thread+0x10/0x10
> [56550.815934]  kthread+0xee/0x120
> [56550.825342]  ? __pfx_kthread+0x10/0x10
> [56550.836548]  ret_from_fork+0x2c/0x50
> [56550.847262]  </TASK>
> [ 1935.215502] Call Trace:
> [ 1935.222827]  <TASK>
> [ 1935.229121]  __schedule+0x23d/0x5a0
> [ 1935.239583]  schedule+0x4e/0xc0
> [ 1935.248983]  schedule_timeout+0x103/0x140
> [ 1935.261002]  __wait_for_common+0xae/0x150
> [ 1935.273008]  ? usleep_range_state+0x90/0x90
> [ 1935.285546]  wait_for_completion+0x24/0x30
> [ 1935.297813]  __flush_work.isra.0+0x175/0x280
> [ 1935.310611]  ? worker_detach_from_pool+0xc0/0xc0
> [ 1935.324436]  flush_delayed_work+0x31/0x50
> [ 1935.336455]  kfd_suspend_all_processes+0x96/0x150 [amdgpu]
> [ 1935.353429]  kgd2kfd_suspend+0xb8/0xe0 [amdgpu]
> [ 1935.367469]  kgd2kfd_pre_reset+0x81/0xf0 [amdgpu]
> [ 1935.382036]  amdgpu_amdkfd_pre_reset+0x1a/0x30 [amdgpu]
> [ 1935.398156]  amdgpu_device_gpu_recover.cold+0x210/0xcf2 [amdgpu]
> [ 1935.416722]  amdgpu_job_timedout+0x19f/0x1e0 [amdgpu]
> [ 1935.432367]  drm_sched_job_timedout+0x6f/0x120 [amd_sched]
> [ 1935.448792]  process_one_work+0x22b/0x3d0
> [ 1935.460806]  worker_thread+0x53/0x420
> [ 1935.471777]  ? process_one_work+0x3d0/0x3d0
> [ 1935.484307]  kthread+0x12a/0x150
> [ 1935.493993]  ? set_kthread_struct+0x50/0x50
> [ 1935.506513]  ret_from_fork+0x22/0x30

Looking at the time stamps, this seems to be a mash-up of two different 
logs. I think you're trying to show how a restore_processes worker is 
stuck on a fence, and that's causing kgd2kfd_pre_reset to hang when it 
tries to flush the work.

The fence it's hanging on is probably something related to a page table 
update that got caught up in the GPU hang. Adding a timeout here seems 
reasonable. There may be another problem, because 
amdgpu_amdkfd_gpuvm_restore_process_bos ignores the return value of 
amdgpu_sync_wait. We shouldi probably handle the timeout gracefully with 
a "goto validate_map_fail".

Regards,
   Felix


>
> It is because the amdgpu_sync_wait is waiting for the bad job's fence, and
> never return, so the recover couldn't continue.
>
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index dcd8c066bc1f..c922867c5675 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -406,9 +406,19 @@ int amdgpu_sync_wait(struct amdgpu_sync *sync, bool intr)
>   	int i, r;
>   
>   	hash_for_each_safe(sync->fences, i, tmp, e, node) {
> -		r = dma_fence_wait(e->fence, intr);
> -		if (r)
> -			return r;
> +		struct drm_sched_fence *s_fence = to_drm_sched_fence(e->fence);
> +
> +		if (s_fence) {
> +			r = dma_fence_wait_timeout(e->fence, intr, s_fence->sched->timeout);
> +			if (r == 0)
> +				r = -ETIMEDOUT;
> +			if (r < 0)
> +				return r;
> +		} else {
> +			r = dma_fence_wait(e->fence, intr);
> +			if (r)
> +				return r;
> +		}
>   
>   		amdgpu_sync_entry_free(e);
>   	}
