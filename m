Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1529F01832
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 13:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7908310ED2D;
	Fri,  6 Mar 2026 13:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HAJxmXbd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8C610ED2D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 13:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTPerdBo/JxVFtQ/82BO7K5ALd8+EZba/HzQH7XifFzTrvIyekVK78zEXBP8dqAMfJXFasE461EkDXjMGc0kH9437+C2W95gdSGAIrRN3MntlO7JOd/fE4gWgZofE1GKQ3KlspFTcFy1TSmRikUb3cvlmoTOLWYedknoy1dvdncoouOjgkt0fuLOLbh5I7/h8AP8Mhb9YlAlgSYXVcSCNA6cXtBIy+9ehbGypeZpCbprqhaRdLR9038W1FrbKjeKJLkhMX/ZrtDLtOusd9wWoWFKo0is5D/bFACxL1rhw4vrxUPl9vcfcV8i1gQ1IVIJIS060WDndv/DOk05xWjqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N212xjZI1eJGul843/UHFp15XG7wt4omU8eaqJShnhU=;
 b=VPbYQzu+Vb6sLOhIYK9mR4m33kYXfQpqOXW44tZCPf+Wa9iu/3NuI2vB38TqOi9vVt/NFYobhvpziCjdYdWD7pPy/855NuLAit5/RVVTp1ljnFOvGdTcNGKcHJM2LREkqGhxOl4WCR8BYMi+3fHjflAICODsMA2toKXhnARq+9or5u3XLW3WnyNYSRDvSr2NRZ4vCMy86pPu/dq7+WqeEcNKi6cgQaOmacmR+QgNNZmdmKF2q98fVJAZLx1FkJ0bPEx3jXkCEKqJjMNvVX6+qIX7rmHrCVSD1WfrYdtnph2bm1lgX//TgsmUi8yAzQOUF+1gjp/l77sE2GGK4uMZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N212xjZI1eJGul843/UHFp15XG7wt4omU8eaqJShnhU=;
 b=HAJxmXbddljxkPPDVpvpbulsRR366uFsAYcBK1AQUFF2maTyQxibJbtjrleRgku2dQV9XJ4hQGpjxXMDNhhCfam+VUrEyx9n4ilDygxFylMoFK23UaNEXB6KpjFkociHlhI6cTdi76YcNkv6H5ptn+mmQzJ4yQ4Sdo2WnMm4Ncg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 6 Mar
 2026 13:09:16 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 13:09:16 +0000
Message-ID: <85969471-6869-4854-a19f-24520365d1e6@amd.com>
Date: Fri, 6 Mar 2026 18:39:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amdgpu: push userq debugfs function in
 amdgpu_debugfs files
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306113344.2412644-1-sunil.khatri@amd.com>
 <20260306113344.2412644-3-sunil.khatri@amd.com>
 <abbbf22e-b95d-4c68-b29e-e4205b8ed7fe@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <abbbf22e-b95d-4c68-b29e-e4205b8ed7fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0130.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: a52382d9-236f-4e5f-b22d-08de7b8191a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: kW1c7IflYwmfGp9sukExSA6eFoa49zcQeMyaXJ1eaANsrRRcL3PliJz+xcL4fHn6uItgOqytT7W3x8U/tRCJfewg1lRs0TCHLHNagn0p2+K03s8E9fvRptTCfDJZKmfOI6UYSTneSG8FIZ8j5lcLWsfgZyo/d0Gp2LoF/VbQ4bYMpNkDKdTJ1t2T92jKuoLnH+hnQ/lUIM3ttDgPw6W8ygYRqLqfpt7sfvFtQpDEie2vCDvQyTCTSx4vjbngt3vtK34ZuaPkuxb/E3v0a6dG3yZ8HPLOVEfKBQorgQZn/OrRRSO6h7jvhWyE30qWJSKP68vnwRmUtPDL1xgBBrb7+FZHMAxtLI8/G1IEqnalCY+aaqKZe0IsdK2rpAk79yeZe4ql9iBiCm6B8zN6R4MxiHc8pfXvygtwdEm/MJ79o2YIg1VYwHxIKYrzgruwbz7bwXntKLvvSWbk5nB2bw3hLTPu0NHW06y1eG3vlZlQy8eKEZODu2f801L0PEldek8mffaDMun7p4LjYWklK6W1V6uS6o9QOghVQRXteXkktEngrnzoNTgFFu124xDbq1jPcmZBp/TChhH95EYa/cbdXiVLUt8WWvrFXUV/qhifmrQd1M4PaHacma5VBeML4kG59qoAhzUeuDwrgqmnZ/42hcMGgdpYQZD2RlB5MN+jileWzl5BhqvwKjTL+BiZkgh36D0oqn3l4ZpkNEo8YSE8uNJYBiyfWF8ivuZLWmhjneE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNSZlBreUIvQzRScUlkZ3BNYVVBNCtsVHNOcDB0V0h5eWhROWFVSWxwdWth?=
 =?utf-8?B?VmljU2dJUDZKa0dmejI3RWZ6d0NHNTgwSTJtNGgzOWN2akRsRVZpQ3BYQnN4?=
 =?utf-8?B?anQyNjVNdTZOUWZqRmFHVkZPQkRxbnRsOFl6bkVVNkdzOWxZVlRWa1pZRDFs?=
 =?utf-8?B?cUZtSzlkWnhzQU91UStsNGFWd0lpeUpRUkpNMUlFYU83WHYySDZzTTRVRHBY?=
 =?utf-8?B?U0JJTjhpUys4eFFQWXpzSFV1Y3hZOWMvdWRlT1ExeTMxVUo0UmxWRU9RNGdz?=
 =?utf-8?B?M0FXMGYxdnUrZWJXVXBYcnhoQmxmUnZ3Y1I2VURGa1d4Szk5TlArclJ3c3l3?=
 =?utf-8?B?K2ltSXVpVU93ZmhRbTVNaEZQTUxoUW4yOFFJbThsQzE3d3VzR0VVcS9VSFZD?=
 =?utf-8?B?Si9CTGpBZjY1ak1Oc0J5RmJPaUhEQnpnUVRVbmNoQjFBRTcrUWZtK3NpM2pI?=
 =?utf-8?B?ZFMrbjkzMGVGUVVBM2JzeW1mdHdPd3RpUEh4eERmUThEQkVmTXk0eWlEd2hZ?=
 =?utf-8?B?SS85UmFiM0dXaHJxV1RkWEVJa0VLMlVNMmhIOU9EZW4xNy9DQVBRekt4dDVh?=
 =?utf-8?B?MTQ2TzRFcThkMTdCeEFMKy92WS9NbFJNZ1pEVyt6a1NBNmV3dzJyK04za3pQ?=
 =?utf-8?B?L2NRbUxvdkc4Tnh2ZTV4L2FaWXJiLzVyRkExaVoxZW84eHcxRFhwakw2MG9h?=
 =?utf-8?B?TFo4d1JYOEY5OGpoVVNza0E4Nkl3UjhLMnNIUEFsTGRLNEpJYjE0YjcxbTdZ?=
 =?utf-8?B?NnBkOFRsbk4vaytjalIvNmhrQ3RlTjEyMjQ4VXVTM2ZyU2QvcytPdFZhUkNm?=
 =?utf-8?B?QlNwKzUzaklLSS8yUUEwdW91TEN3a1AyQXZuSCtwdmxBa05qM1hQWUNDN2R4?=
 =?utf-8?B?QWltKzdFU2l6MmxFNUErWXI1cjJmRmVUYUtJdGdUWmYvVk5IMUthUEVOeU5Q?=
 =?utf-8?B?R0xOQ0pNb2c3ajcyR1dEb2hvSmxWcjhXNVc5U3pIL3dNVkovRm5MMnJsSDFl?=
 =?utf-8?B?enIyOFh1K1ljWDA2TU9HR2VzWm16bkxXOVFqTjZ0U042L2ZCY1hrN0RGODdh?=
 =?utf-8?B?ZHhjajhYZzY2a2E4U2oyOWZoMk83dCtPVnZYLzBPVHFRU25DeGxzeVdOZ1pv?=
 =?utf-8?B?RTF6a1BsTFNXTEp5VmUwTjU1U2kwTWtZeGtNUGk0WnJsTzVVY2JYU05Vc0FV?=
 =?utf-8?B?cUFaSEVOQ0N3eHNxUjBnN2dneWpxdmp0TWgyNHZkZHM2SDd5ZjFjUEJ3cC8w?=
 =?utf-8?B?K2p2K08wMmF3enNMenRqSTFQd2s5eUtqTUQ0em4zM25maktDclNta2U4RTh0?=
 =?utf-8?B?d2JmK2FuOU10YTJHYVlLMFB6VjRoNWxFcEo2Zm9nREE3dnAxNnM5NVNUOVYx?=
 =?utf-8?B?eXUrOEpJdDEzTDVhK2tBbUM4bVU3MzVUWXdGUjcyT1RKbzQ3akREMjMrK1Q3?=
 =?utf-8?B?K1Q2L3hCYklpWUR5S2gvMmRRa2p4b3RpYU1DZ2lNVm9Uck1kb3dLVzQ0Qmxx?=
 =?utf-8?B?WGN0NFpkYzdOT2dpUU8rdEJwcUs1RTd1c01zcW5ERStYRE1zcUVXWHBFalJ1?=
 =?utf-8?B?ZWRsUnpPMnBXV0hDQXFNTFg2andETFNQRnNyd0tBVFZ4aVV0aENSRldPbTVG?=
 =?utf-8?B?MkRLb3ZibGovb2FUaFJtNFhmbTNjUzZvaC9QZUhhakhheHBMbEdhUTg1Tkoy?=
 =?utf-8?B?UElFT3ZJNVhPM3FtYzBrTlBYTE5JRHorZ0VqSmdGWmRzQXJlbkZvZkJHNFZN?=
 =?utf-8?B?cjBqWGZjcmMzbjdtTXhKd3hZQjk1YUNWZlBUdmRrM1BLSGNUVEZKSWErQXBL?=
 =?utf-8?B?aHF6N2c1OWo3SXZ5b1JTNDFEMUNiNi9GMkIyZSt5eEd0MGVCUUlCZmhxKzJn?=
 =?utf-8?B?dVJqVml1QUtBN00yVVp0bCtaeVBQeTA1YlBJTW4xb1lTZ1RVUW52K3Z6L1BE?=
 =?utf-8?B?eDJOVExjNGkvZkJ0NHROMjk1T1IwQmZaV2g0ZXdPL1JJcFdrL2NCUDlHdkF3?=
 =?utf-8?B?SmNiLzdJK3hVL2lxaUE0WjE5bGFOcXdWVmk0MUtPVGFHV09yKzBHMFVzcXlE?=
 =?utf-8?B?bWhqNnVoT1R4dVJZMzRYelNDV1UvVlpJYzk0cnJjQjEvUGZyOFd1QU5qVG5S?=
 =?utf-8?B?TjF6Z285eWNDZTRoVWpsRnhLaU9ESy9qSFdUZ015cjR3UUY4S0c3bVBJMTRI?=
 =?utf-8?B?OTBKZkFMeXA2UUJxY3BmaVN3NnVPNTh5MEsxY3ovWFVTbWpnM0E3TTRkK2ha?=
 =?utf-8?B?RXFrSUpMbm55YUVTN3lxSm10dXA0a3J3NE9mZ1VMVFFTQmlJZVBxSW5vNGRr?=
 =?utf-8?B?U0ZwY3NEbkZHV3p4ZnlHS2lDRVNzbnQ5MHE2dHRDT0tRNmpxaUdFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52382d9-236f-4e5f-b22d-08de7b8191a5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:09:15.9461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3yvyJEhsMl+FfZ3wlQG2V11T2yeMLjGIwyiTdALscTZqOLc5TJ61KXDfleH8QWERzrUUMgzEawnDrC74lZsnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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


On 06-03-2026 06:34 pm, Christian König wrote:
> On 3/6/26 12:33, Sunil Khatri wrote:
>> Debugfs files for amdgpu are better to be handled in the dedicated
>> amdgpu_debugfs.c/.h files.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 53 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   | 47 +-----------------
>>   3 files changed, 58 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index f51c3443159d..63b702ec972b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -39,6 +39,7 @@
>>   
>>   #include "amdgpu_reset.h"
>>   #include "amdgpu_psp_ta.h"
>> +#include "amdgpu_userq.h"
>>   
>>   #if defined(CONFIG_DEBUG_FS)
>>   
>> @@ -2156,6 +2157,53 @@ static const struct file_operations amdgpu_pt_info_fops = {
>>   	.release = single_release,
>>   };
>>   
>> +static int amdgpu_mqd_info_read(struct seq_file *m, void *unused)
>> +{
>> +	struct amdgpu_usermode_queue *queue = m->private;
>> +	struct amdgpu_bo *bo;
>> +	int r;
>> +
>> +	if (!queue || !queue->mqd.obj)
>> +		return -EINVAL;
>> +
>> +	bo = amdgpu_bo_ref(queue->mqd.obj);
>> +	r = amdgpu_bo_reserve(bo, true);
>> +	if (r) {
>> +		amdgpu_bo_unref(&bo);
>> +		return -EINVAL;
>> +	}
>> +
>> +	seq_printf(m, "queue_type: %d\n", queue->queue_type);
>> +	seq_printf(m, "mqd_gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(queue->mqd.obj));
>> +
>> +	amdgpu_bo_unreserve(bo);
>> +	amdgpu_bo_unref(&bo);
>> +
>> +	return 0;
>> +}
>> +
>> +static int amdgpu_mqd_info_open(struct inode *inode, struct file *file)
>> +{
>> +	return single_open(file, amdgpu_mqd_info_read, inode->i_private);
>> +}
>> +
>> +static const struct file_operations amdgpu_mqd_info_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = amdgpu_mqd_info_open,
>> +	.read = seq_read,
>> +	.llseek = seq_lseek,
>> +	.release = single_release,
>> +};
>> +
>> +void amdgpu_debugfs_userq_init(struct drm_file *file, struct amdgpu_usermode_queue *queue, int qid)
>> +{
>> +	char queue_name[32];
>> +
>> +	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
>> +	queue->debugfs_queue = debugfs_create_dir(queue_name, file->debugfs_client);
>> +	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
>> +}
>> +
>>   void amdgpu_debugfs_vm_init(struct drm_file *file)
>>   {
>>   	debugfs_create_file("vm_pagetable_info", 0444, file->debugfs_client, file,
>> @@ -2174,4 +2222,9 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>>   void amdgpu_debugfs_vm_init(struct drm_file *file)
>>   {
>>   }
>> +void amdgpu_debugfs_userq_init(struct drm_file *file,
>> +			       struct amdgpu_usermode_queue *queue,
>> +			       int qid)
>> +{
>> +}
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index e7b3c38e5186..e88b4a1e564c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -25,6 +25,7 @@
>>   /*
>>    * Debugfs
>>    */
>> +struct amdgpu_usermode_queue;
>>   
>>   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>>   int amdgpu_debugfs_init(struct amdgpu_device *adev);
>> @@ -34,4 +35,7 @@ void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_vm_init(struct drm_file *file);
>> +void amdgpu_debugfs_userq_init(struct drm_file *file,
>> +			       struct amdgpu_usermode_queue *queue,
>> +			       int qid);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 1543ca324f43..472936f90c19 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -709,46 +709,6 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
>>   	return -EACCES;
>>   }
>>   
>> -#if defined(CONFIG_DEBUG_FS)
>> -static int amdgpu_mqd_info_read(struct seq_file *m, void *unused)
>> -{
>> -	struct amdgpu_usermode_queue *queue = m->private;
>> -	struct amdgpu_bo *bo;
>> -	int r;
>> -
>> -	if (!queue || !queue->mqd.obj)
>> -		return -EINVAL;
>> -
>> -	bo = amdgpu_bo_ref(queue->mqd.obj);
>> -	r = amdgpu_bo_reserve(bo, true);
>> -	if (r) {
>> -		amdgpu_bo_unref(&bo);
>> -		return -EINVAL;
>> -	}
>> -
>> -	seq_printf(m, "queue_type: %d\n", queue->queue_type);
>> -	seq_printf(m, "mqd_gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(queue->mqd.obj));
>> -
>> -	amdgpu_bo_unreserve(bo);
>> -	amdgpu_bo_unref(&bo);
>> -
>> -	return 0;
>> -}
>> -
>> -static int amdgpu_mqd_info_open(struct inode *inode, struct file *file)
>> -{
>> -	return single_open(file, amdgpu_mqd_info_read, inode->i_private);
>> -}
>> -
>> -static const struct file_operations amdgpu_mqd_info_fops = {
>> -	.owner = THIS_MODULE,
>> -	.open = amdgpu_mqd_info_open,
>> -	.read = seq_read,
>> -	.llseek = seq_lseek,
>> -	.release = single_release,
>> -};
>> -#endif
>> -
>>   static int
>>   amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   {
>> @@ -886,12 +846,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	up_read(&adev->reset_domain->sem);
>>   
>>   #if defined(CONFIG_DEBUG_FS)
>> -	char queue_name[32];
>> -
>> -	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
>> -	/* Queue dentry per client to hold MQD information   */
>> -	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
>> -	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
>> +	amdgpu_debugfs_userq_init(filp, queue, qid);
>>   #endif
> That #if defined protection can now be dropped.
Ah, yes this ain't needed anymore. Will drop that check and push the 
code. Thanks for the review Christian.

Thanks
Sunil Khatri
>
> With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
>>   	amdgpu_userq_init_hang_detect_work(queue);
>>   
