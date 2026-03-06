Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A2F01832
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 13:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F278210E25B;
	Fri,  6 Mar 2026 13:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="awiJar2h";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8351310E25B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 13:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALdzvwBxdcqO/5vKjvYF5g3RW/ucm0uR2YSOi2E6PWwCxrHoG5iuMGQ+PNo4lLeBh+AgSpF2WPOZZhNSM9OYJwzTqLoVWOGurkfTM+VKmUn6g1IMfiYyCXat/JfFpHJ162nmgrDkwTg7cXqsFhk1n/Xo2cM3FA8e3XNwz736gkGzd9q6Dqc9LzWVcmBuwS/UfUUIh584lkC0DCxeAZ3TrI7IqjwxKoRyIRKy2vngWZEt9ouPqq8RfL+x40XgDJOP8RDAd++KtPAjCEDF4Ye2tIq7iXZNVU/bTGxg9cpVTrD1cwt773G8DtSC+8PU/J/Ar1wPtDDupozQJ8OzEjFx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5BUUfYYlWcUDWM+RFWGfpWsouIhYGeqFFhhkPAAjtQ=;
 b=d9YPju1FUY1wYau/EiBgHaSqLfGn1nTHN2BbfDaqvvrXqLXO8eapiQIu7Z81Nw9oSWVZWlMkTNzhi+o8BY/P6Z5S7p2u8PKpdP6VvBHuGO+q4AAIm22P7qjxI2C35GiemoReZCV4ei2vRYf/L6Q3q1ZuPgC9XCbeyItlwBZNa+VkmeS9Nhrs4csWcWnRiqaBc1gi35ZyVUkZSTpSOSUyseMeHnFtaGiOHMRF7uanC3R+XxIb7BuS0x0RF2wWtctNRrzXP8ULEGCpApV5lfNBoyAX2gRjtYL0bFVoXSjdDUYD22KfZDFcwsLu/KHwsFvIgYDZQ3tboC6P+z0BUd9VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5BUUfYYlWcUDWM+RFWGfpWsouIhYGeqFFhhkPAAjtQ=;
 b=awiJar2he5qSAl4a7lpu5EfI9BfXsZ8kiYzKBgWkr2kiWOb9YjhC7ZzS+Sx4i9DTMZ486ZX5xUQGIAvuWMhdHBQbTaR7I5Lxj9aqVGXE82kbUavjy3WTz0Lf1w4/XqNG17YkmxUgWVArUUxaDQugC5DfWaL8QVd62kQ783DeTuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 13:05:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 13:04:59 +0000
Message-ID: <abbbf22e-b95d-4c68-b29e-e4205b8ed7fe@amd.com>
Date: Fri, 6 Mar 2026 14:04:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amdgpu: push userq debugfs function in
 amdgpu_debugfs files
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306113344.2412644-1-sunil.khatri@amd.com>
 <20260306113344.2412644-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260306113344.2412644-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c538224-8c83-44a3-afcf-08de7b80f906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: elb+Dhd9E7ySNXFTzAYOOviHSV7bsB2rAvQJsm6qUeiRgMIIvw30w9JRar0LEU16hGJlj0NSsGP/5nP5fcobdpJiYnKyhI+rV1YTR7DvocpQ+TWNhGS2qSQHpVqdSOP/VGjnImL9zVTOL0vcNK2SbCgvERuKZ5xkNBKU1blFfDWMdVxjacap78obti0ha3U0phe0EqUKl0xH2qRN3CM3YHyPVUYkDcO2IP03VfLZP1FowBJiYsDdRd2f07IHB4fiRREkA8wAkf/XZGTCRLbVWPbI86ptyWCNkAdvCjuyP9Gq/K7B6jxVEBVIsxGl/v/7HnNktZGcqpBpTgE3fWSTVJWWmzDmLi0fMAv1UyHHUry4nmA7Rnfd3N7p+72mdS/Xi0rdH1OPX8YOgn+1gItY4q3GYd2m2oYWrOjxko4Z/90Gw/ms5y/IM6reotb0T60Wcx+oAeXThkfzBa22apZXLoTI0qlpjPob3RT062PUiaXZBlyUT+JoD1gmhDD13CSeXMLqYUWZPjneHhzFcGzWsyppV4X0hA+0IsMC1KFEpjYYZhCgbPU0lDDfOK6juAR/vkkzz2fvh2tXD7SHpRhY29QDm9fgWvjiLi0rIMgCYJs9/WU9776kQqPLbQATTUC8rapVGk1szKone3Cj0VE48qYdMY2HJilMTXEcy8JNhXvDhPUgrYn9yMR/mGPNyIuYSj58AC5XcTZKmxxhI8Lsjw9icRvE6D4HpB7Joi+nSfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmN6Ky9BNXVXNGZCb2hCSWR0SHBjNkVRVzkxSnJka2Z1aDNhSXZtMDZFVDlT?=
 =?utf-8?B?RTd5YXpYeE9yZzgra2EycFlMWnNIVWtzVTBFbjcwc3lrU1NSRWV1MFpxUkw4?=
 =?utf-8?B?ekM5QlZCNHJGaE1zUmQ4ODRlajNRR2tEcHpKTDV6VUdDWkd1UU5wa0xGbU12?=
 =?utf-8?B?REVEQ29pNEpNOHZuZWt1SVlqWThPL1Y2OEJWRGtrcXVib1NNS2V6ZkVLL081?=
 =?utf-8?B?NkMrQmlSbHNIb2lKbHNuekxpWEdUejA5MUxsanV4RW9UcGQ0anhacGQ2WWQ5?=
 =?utf-8?B?VVNuZVQ0MVBaWGhOWU5NN29teC9Kbk9LbG51a0l5YS9SYk52Y0sybUlNdFJ2?=
 =?utf-8?B?L01kV2ZqdFNGUXdHQVNBak5HazZiL2k5Y1hjUnJwdW9aN1kwQk02azd3RWVp?=
 =?utf-8?B?emkxOHZ2VjFMOURoVUhMUW9VMnR2N25iL1YrSENUMmV0Q0daenVidTFXT2RI?=
 =?utf-8?B?aEVxQ3hqcW91WmR1cFpYL2E0bk96SmQvU0R6dWlMZlQ0MTgyT3JKaVkzOHNC?=
 =?utf-8?B?YWlVbzlJMDlWK1UyS1N3K3JLckFoYmUxK1IzTVVCMGRjQ0JwakNMWEE1Y2dY?=
 =?utf-8?B?TGJ4Y205WEIxZEd0eG5Tb1JYZ0oyaUV6MjYxR1kxSzNOSEhwdDBjWCs1eVNU?=
 =?utf-8?B?RExOaFk3YmdiMnFhUThVcUdudVhEVGtxZThEYUVuRmozZERsRDNtS0M4QXB4?=
 =?utf-8?B?SGl5Z1hCRi9YcWV3Ukh3Sm83MndEc3lIRW1nOThtTVI4aU1XVE5kZ3h4Rk9i?=
 =?utf-8?B?dzY1V2haSUNjRjh3VjhqMEd5NUxDc3VmUGc0MW9zUlR6Yy8zSTNCTG4rRG1p?=
 =?utf-8?B?L0c0ODc5ZzJERk5yb0lkZWxKdFdyeU8wQ1E1c0RXenM0YmtCa2dRU2Mrc0VK?=
 =?utf-8?B?YXlpd1pZb2ZkTmRXc0c2OERrTVArRTJGTEFSOEtEd0xCMWUvbTcrMGV4OWFC?=
 =?utf-8?B?Ykc0cmtqdTZybGtZbkdla0VxMnZNMjZGVVFZOEQydUdpQk5HSTAvRHZHZ1dH?=
 =?utf-8?B?NU9EZ0JqdEU5aHVhbUdVQThDa1dhYUJyVlduZzQwajlwaDdtYkVlR1Z0dmtK?=
 =?utf-8?B?QVAyQThwQnNWVmgzS21HT1lEN3dpek40aGtJY2Z4SFgyNjM4RHdrcCthY0Vj?=
 =?utf-8?B?VUlMbmw3RlF2WGwzTTczTFFGcmJiNEhMZHBnNElHMGFEaG51cTdLbitNZjBh?=
 =?utf-8?B?MVJrblpuVXBDYVQ0N2xaaFFMTmRFVkJnekRIWTg3dGVEaXdIZnhnaUtHRHBu?=
 =?utf-8?B?OWJKSWlnbnZhQUdvOHFSaDVPU0cydWxlUFZGdE96MlpVR2w3Z21HN1ZDL2tZ?=
 =?utf-8?B?ZjNkVDBKQ3lPd251Q3A3dTJRUHpkMUJCNFdKVkg2N3cxOXRvMGVFU3VMNCti?=
 =?utf-8?B?REZ1cjdpQVU2aEgxQXJqS1R4bFFoRmhGbFlBajNHbU1oVTk2TGRpaWhuUFA0?=
 =?utf-8?B?M3B3TER6L0pXb1FHcDRwbjhCTkt3MGRPcWJ5QkdVTy9kcEpaMWpZU2FCZkZl?=
 =?utf-8?B?TktZc1NtVUEwcVFmK3dBSDZzbG92YUxLNk5aL24zcG03d1Voci9nSjBWV1B1?=
 =?utf-8?B?alpxa25OWit1WkZWbTdxNGw4dE9HSzNiT2laQzVvVEtRUmtacVFCLzgxcThD?=
 =?utf-8?B?TEYrNVdrRjlodjJWWGJDbm9VY0NjdXpXd093SzVHSTlNWmhJZHlIVzRZR1pF?=
 =?utf-8?B?eVVMZ0paODN0d2JCQWk2R2xvb2ZPTHdHcWRPa2VjT1FNQ0hablU2QXMzNGdr?=
 =?utf-8?B?WWhkMmJ1d3gyaWl4amU3VXZyNkRrdjFVU3A1OXdES3FWQmNWTXZqUEdYbXRP?=
 =?utf-8?B?UExHdFRkY3ZsRnlZc1VUODVkbTdLUWsxOU92VkYxcVM1TS9UdGp0bE41OVBB?=
 =?utf-8?B?K25nMU5UbU85MFA1aHFVY1BRRFhtanBFcUc2Rmg4ZzBaTnhIdDdEQTFncnZ4?=
 =?utf-8?B?ZXVRdDJiYjlHR0FyYVQxeDhveGxYWnh1M2JwL3FGM2RYYlZmTlNtZ3ZxYzYz?=
 =?utf-8?B?b09RandGNGFVWUgya1duTnVRcTNjZkFyZmQ0WmV0emZ3OEx3Z1NsLzc3bm9W?=
 =?utf-8?B?eU1YNC9HUjFuTlNhZDNLaFR5SnBnbEE1b1hwZXY1RVZvWjI1WXBrWmg2U3hv?=
 =?utf-8?B?aGgzSXhxaVhwVFhHYW1LTzN2eDM5VWNQeml5d2FGOVZPNk5QcDdkMWVWRzdM?=
 =?utf-8?B?eERGSjZTcUVXTHVSdG5zeE1zQWZaZzUzWUJoVmdlR1g5RXlaNkEzZEFCSlFH?=
 =?utf-8?B?UjV1d1AxSVovZk80WWd6WEp5QkNEcEFoak9aZXk0QWdRajVoaS9rY2lzOGt6?=
 =?utf-8?Q?NlK5q2+0+3Zz6GEAMV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c538224-8c83-44a3-afcf-08de7b80f906
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:04:59.8405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2mrxHUt/6DMehZMw3ZuoZRshNifJtowSbm/OmtaV9pBNVMem0DnfcCQ8njle5JV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878
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

On 3/6/26 12:33, Sunil Khatri wrote:
> Debugfs files for amdgpu are better to be handled in the dedicated
> amdgpu_debugfs.c/.h files.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 53 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   | 47 +-----------------
>  3 files changed, 58 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f51c3443159d..63b702ec972b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -39,6 +39,7 @@
>  
>  #include "amdgpu_reset.h"
>  #include "amdgpu_psp_ta.h"
> +#include "amdgpu_userq.h"
>  
>  #if defined(CONFIG_DEBUG_FS)
>  
> @@ -2156,6 +2157,53 @@ static const struct file_operations amdgpu_pt_info_fops = {
>  	.release = single_release,
>  };
>  
> +static int amdgpu_mqd_info_read(struct seq_file *m, void *unused)
> +{
> +	struct amdgpu_usermode_queue *queue = m->private;
> +	struct amdgpu_bo *bo;
> +	int r;
> +
> +	if (!queue || !queue->mqd.obj)
> +		return -EINVAL;
> +
> +	bo = amdgpu_bo_ref(queue->mqd.obj);
> +	r = amdgpu_bo_reserve(bo, true);
> +	if (r) {
> +		amdgpu_bo_unref(&bo);
> +		return -EINVAL;
> +	}
> +
> +	seq_printf(m, "queue_type: %d\n", queue->queue_type);
> +	seq_printf(m, "mqd_gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(queue->mqd.obj));
> +
> +	amdgpu_bo_unreserve(bo);
> +	amdgpu_bo_unref(&bo);
> +
> +	return 0;
> +}
> +
> +static int amdgpu_mqd_info_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, amdgpu_mqd_info_read, inode->i_private);
> +}
> +
> +static const struct file_operations amdgpu_mqd_info_fops = {
> +	.owner = THIS_MODULE,
> +	.open = amdgpu_mqd_info_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +void amdgpu_debugfs_userq_init(struct drm_file *file, struct amdgpu_usermode_queue *queue, int qid)
> +{
> +	char queue_name[32];
> +
> +	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
> +	queue->debugfs_queue = debugfs_create_dir(queue_name, file->debugfs_client);
> +	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
> +}
> +
>  void amdgpu_debugfs_vm_init(struct drm_file *file)
>  {
>  	debugfs_create_file("vm_pagetable_info", 0444, file->debugfs_client, file,
> @@ -2174,4 +2222,9 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>  void amdgpu_debugfs_vm_init(struct drm_file *file)
>  {
>  }
> +void amdgpu_debugfs_userq_init(struct drm_file *file,
> +			       struct amdgpu_usermode_queue *queue,
> +			       int qid)
> +{
> +}
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index e7b3c38e5186..e88b4a1e564c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -25,6 +25,7 @@
>  /*
>   * Debugfs
>   */
> +struct amdgpu_usermode_queue;
>  
>  int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>  int amdgpu_debugfs_init(struct amdgpu_device *adev);
> @@ -34,4 +35,7 @@ void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_vm_init(struct drm_file *file);
> +void amdgpu_debugfs_userq_init(struct drm_file *file,
> +			       struct amdgpu_usermode_queue *queue,
> +			       int qid);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1543ca324f43..472936f90c19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -709,46 +709,6 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
>  	return -EACCES;
>  }
>  
> -#if defined(CONFIG_DEBUG_FS)
> -static int amdgpu_mqd_info_read(struct seq_file *m, void *unused)
> -{
> -	struct amdgpu_usermode_queue *queue = m->private;
> -	struct amdgpu_bo *bo;
> -	int r;
> -
> -	if (!queue || !queue->mqd.obj)
> -		return -EINVAL;
> -
> -	bo = amdgpu_bo_ref(queue->mqd.obj);
> -	r = amdgpu_bo_reserve(bo, true);
> -	if (r) {
> -		amdgpu_bo_unref(&bo);
> -		return -EINVAL;
> -	}
> -
> -	seq_printf(m, "queue_type: %d\n", queue->queue_type);
> -	seq_printf(m, "mqd_gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(queue->mqd.obj));
> -
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> -
> -	return 0;
> -}
> -
> -static int amdgpu_mqd_info_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, amdgpu_mqd_info_read, inode->i_private);
> -}
> -
> -static const struct file_operations amdgpu_mqd_info_fops = {
> -	.owner = THIS_MODULE,
> -	.open = amdgpu_mqd_info_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -};
> -#endif
> -
>  static int
>  amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  {
> @@ -886,12 +846,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	up_read(&adev->reset_domain->sem);
>  
>  #if defined(CONFIG_DEBUG_FS)
> -	char queue_name[32];
> -
> -	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
> -	/* Queue dentry per client to hold MQD information   */
> -	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
> -	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
> +	amdgpu_debugfs_userq_init(filp, queue, qid);
>  #endif

That #if defined protection can now be dropped.

With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

>  	amdgpu_userq_init_hang_detect_work(queue);
>  

