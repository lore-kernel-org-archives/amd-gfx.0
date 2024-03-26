Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283D9C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 06:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD2210ED3F;
	Tue, 26 Mar 2024 06:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzP3s7Mh";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2122.outbound.protection.outlook.com [40.107.102.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD5B10ED3F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 06:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ognJdZvFWGCU3fKWazv+Hp7bgYBNGzlmZqgIBbiOtfomhl+gp5ftTtdaIVjhPgJLs4g1sNalBMhM76k1jNMoCCQq0lz+yaIucLbu+fMEoxkL3AjM9jybwNkHCC2SLAOuOQFJR7Y+ofHqLHgtboi5nwULuDUcBTU4mqrxPcqjRMzd1JHcbnDmqbsjhY7NdmNqQy8nj9PXl8CJ7ZdhtejfMIhDrHwvIqIjH4Ss1dRQly5p1r5POntCXfu305tKSWKbe4GAVCeU3g43Jc1ZQA6Y8w3K3mPc0WjEhwCv+UUJ3SNS/5a0wLtyQ1wrEX1YraBmQU3bK9GCVk3Y/X1dZ5+ljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geKOZfEucbo7+VZVup+ay8cItHDy5Bp3OKZPVi2an4A=;
 b=bPeVhb8MABurtLijWGLTTJDaK9rTdfcuym0vfSxY3vlQrm8QENcxUKljwRTo1Tzi2pk9oc0QFn6TXLzpcAf39AN9cPLPy8ZRutkavNhl9Onx5jpkms4vW1L9j6vIKY56IoWNCVw+QWUC19DNuspIh9D7O0fvXFD/KignJER098mk5Eks24qRS0smpXNw8dyPeknUbd1nWGtUYfiVwLvVrGTtYEzZfweh7o7CbgzSpNuvfIrcJa8gpd7gx8/uz8FgfKxB0b9PtKktB87VTAWSaOJ5nlCYmF+T+ozTwJR1SGgsdUb/9hckS5nQCx2wLVEMvmb9JZlc8gbhAnzEOmqlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geKOZfEucbo7+VZVup+ay8cItHDy5Bp3OKZPVi2an4A=;
 b=hzP3s7MhEuAHuwdLwV6hJBOA/KHcY4n85jKBHLp3zMRy9+Xgtu8oK03kFuowypsLDwaxzFUtWc8SeVc6GTmLpIuumuTWimVoOluW7ncQJiIM0tiY4jULC1OMITelcrrshCtoU2SQarFHnQ7G080TVV0eQr/OmP5qK/lM9Vl0Kuc=
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 06:31:14 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c94:963b:9aa0:78c8]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c94:963b:9aa0:78c8%3]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 06:31:14 +0000
Content-Type: multipart/alternative;
 boundary="------------EULEDAEspbXYluBAIIJr1ZPX"
Message-ID: <2234e3ea-c0a2-45bc-9f74-ef77793a498e@amd.com>
Date: Tue, 26 Mar 2024 01:31:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] amd/amdkfd: add a function to wait no process running
 in kfd
Content-Language: en-CA
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com, lijo.lazar@amd.com
References: <20240325151805.6379-1-Zhigang.Luo@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240325151805.6379-1-Zhigang.Luo@amd.com>
X-ClientProxiedBy: DS0PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:8:191::8) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MW4PR12MB5644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QPYM2NFPPiTt7MBsr4DMSH+zmeIuZQkQPqSaSFKf1y569ChaEUUIRtnLViaNpIyAl7xQWOgoPQL+FMApXf+hC4FCKtKkorpESG7Cvudo9Fvw1qlP308gjpsTY632C91FI6AcsUH8mPoEQRT9VuwP64rbWXak+8CV9ycTsfSQlywS7giFXZHBVfp74YoY2L1cCn+77IHKKfkoeRMaNpc5BWKWRgkeRYfl/NzThwjV7Cg4PGpynOvVPrkK56H7TLsc0qo+dylHJWYqu/GdHm06it1u5uAPiu6MOY77JR7zXXq3mBKH3xlfDUiYfJrPVzhwRTIb+w3GAFweOEDBYvS4Ccx6iB1Kc50e+RvrzAdca4sZU2EkxRzORQfHpHdwejNB9gEQXEAiTvv+M48cuevSpxpNnM0T/DZa1V8MrpXL66DUNQgCIw5jM5hGhaOvPM4QJCohfeYKghqlAEZYwUI0xVU65+uGa7kq0ISYuxvyQ1IxXcAdnIgT72MkkhxVNQcv3xrtoI1rDB1y4x5ln9M8vL/K3+ji5ceeUj48MEiRcKLwRWy5onlxQ3bvdM5+vthiA40FC3lY6N+oDRebqA+0UD5N7fkqRrOgLhedX8seZBrx24ESTg7ruSonBjxBZIG6FnLTMdirOAlhrxkqHV1Gy5Qwv5x/aZJ29LOngnvLqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NOVExSaE5qWk9ZdUQwRkdId2NHZExnaW8xaXI5RGJRNitVQnRsaDhmMUFF?=
 =?utf-8?B?cWQ5YU90SW93QjhwTkpnNlM5aVNXWVhhVWxQYi91T2hRVWZMOVUrMU9MenNh?=
 =?utf-8?B?bjZVcUJHbUU3VFhHVUlBTWRLV3FwajJxMVZjVUQ4M0pKZVY5Tms1emM4bkR3?=
 =?utf-8?B?My9CWmU3TW1kTUZFSU1sRG1ITVRZWVQwb09FKzNIeFdRcnkydnlDTmgwWDI1?=
 =?utf-8?B?a3QzeC9OTVNERk04YW52WXNHMnJKUjFiOE91UEdqSVJobmZnUHAwUXd6YWZu?=
 =?utf-8?B?aCsvblZycUJPRVJraUd6a2k2OFhwMXZObUorT0VpTzlBVjJCMVNpdi9yb1NC?=
 =?utf-8?B?cjdjQmlzNnFXdkhkMEtFTFZGYVFpMzlucFozUWMzRHIxbTNPdUFSVW5uMnAz?=
 =?utf-8?B?eERBekNKcHVPVnA2bGdUR0I1RVNLT2I0K0FTWVpwRHR4MUhydUhqRjNoR2l3?=
 =?utf-8?B?bXowM0g5V1RSeVFLS2ZSN1p0V2d5RUdlcm5hakZEZU1lWHNUaTJUWmY0Z1B5?=
 =?utf-8?B?cFpFSlNJTGZ0WnY2bnc2UmRybE5IQWt0RXp5bWxOOVdNcUZxaWVQN21aK29t?=
 =?utf-8?B?RDRLVkdvTEZ4VitzQUd2aTM5YjZHME00UG1BQTMyRnF2U3BCOUxNdE9VdEhZ?=
 =?utf-8?B?SjlodmZrUFl2am9GbWRDVDRDdlJrelFlM1NLam0vUC9YcEhhendlVE1kNVRz?=
 =?utf-8?B?NjhrL3l4Rjl5NVJ1eFJmQTdNU1dOWG5ueDQxMDluSnFRT05iWnVPTnNTVjU0?=
 =?utf-8?B?OXRLekIzWDJaQUpIeDNGQURuL3JBN3h5VUIvV1RzMmluZUdodFV0WmJYQWh2?=
 =?utf-8?B?aG9ucm9wb0FzMUdmcExwWnJlOFFPR05ORmdqVFBZakZGdlpSbGpSMUFRb3hw?=
 =?utf-8?B?c2h1VXAvYTliVjVESDk5M1dYMGduSVUxUFFZbEpwYnBvdDFuSmdRcXZBY0pn?=
 =?utf-8?B?SnhDb3ZvYTdzYklUUW1IT1dUQk1YcVhCUlVKN0h1Zy9YR0dQdzR6U3gvME96?=
 =?utf-8?B?NDJlMlA5czN2T2ora2lKNFdvSTlORmxYR0Qyb2d0TVduRnNiOVc0ejdrUUJ3?=
 =?utf-8?B?UGtKdXlaOWdEVGRvbTJISGU3T1BXL3dTYXo5NDl1RkdKVSs0TndiWmRUU0hJ?=
 =?utf-8?B?a2FwdGlLOFJoYVFhVCtDQkZYUUVXVWd3RkdzbEFqWFQxNFd4eURMTEI3RmhY?=
 =?utf-8?B?dW5rK3dMWnVDMGpBRnNmZDhUZXlidW5nMGpiQ3NkOHhYOVdmSWpZZnFQbWF2?=
 =?utf-8?B?ODk3NzZSejBLNzg4VVB0YlVrZ1NocG5GcVFOaUhYVnhVbExuMXFVN2I2NTBi?=
 =?utf-8?B?anc5Q3ZGaTJIeXRaRU1mME9MeTdtd1FDbGpQc0NrVUJCNis4RWZ3TjRLSy9C?=
 =?utf-8?B?cXJUUkR6SjVJbWNxRTJSMExKYnB6MVFKT0pPRUpiaGhlMzFiam9YNVRObGtL?=
 =?utf-8?B?MG1acWtIVzUwUzlQYUVoN0JrdllZT2FYWVg0QzZpM2RRZHRlQ3Z0UU1qeWNR?=
 =?utf-8?B?eTJHNVV5SFhyRkdLWGhHSmZMcTNBRm82VlBXQU1iaFlpQ2NLd2R5MDFrS3cr?=
 =?utf-8?B?Z3FSQmU5ZTh1OUNHVHNHdEMzdUxBeEExdCtNYXlSSkpYRGFUVzZ2SVd2QjFz?=
 =?utf-8?B?TWhxRjBiY0Vzd1hiTGFtUER2Zk1ybXloM1d2NG9WMFk3L0xEMjF1NkRSOFpm?=
 =?utf-8?B?NlZrRXU0b2thSkR3czRXOWNuZDZ6Q1dDckJuT05aTTh4RHYxUmZ4SFN3K094?=
 =?utf-8?B?UERtQkRJVGhHVEtCNkRTTG13SjdpSlNaNHVneCtleVJnUUNXV1psdzVHNzBx?=
 =?utf-8?B?QThhRys2QmZQa25iVWY3MCtia3JCV0ZkWGlrZ29OMm15MzVLTWhRSUZvMVFv?=
 =?utf-8?B?RytkeldBUjMyZStvRWltWFRxUWlVVHV2TlhIQmVQcmVUTU8zZHVYbXlBK0lN?=
 =?utf-8?B?aDRualZYQU1jdlROeUhZR2JyR2FkMVEvbFd4UFYybGRWdjJTOU9XdlZNL0kz?=
 =?utf-8?B?eHhYWDNGOFNBZWo3TENPWkRmTjBkVjZmSmZRUjJyQVpCL1d2RUZqUTkvbGdn?=
 =?utf-8?B?VWFubHlpK3QySzVlOENjMDNKS2tCM3llcGY4QmllcC9WdkR3MlVTOTN4dW1o?=
 =?utf-8?Q?fvpQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b2c1a3-09f0-403f-a30d-08dc4d5e55ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 06:31:14.0597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxeozAsgY9Ufqy3n49HA7T4Xo39dYM7x2SuYRxV8yUJyNEggtcRHcv3fwhEY1k87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
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

--------------EULEDAEspbXYluBAIIJr1ZPX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/25/2024 10:18 AM, Zhigang Luo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Signed-off-by: Zhigang Luo<Zhigang.Luo@amd.com>
> Change-Id: I2a98d513c26107ac76ecf20e951c188afbc7ede6
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 20 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 10 +++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 11 +++++++++++
>   3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d5fde8adf19b..e02bfcec608b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -261,6 +261,26 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>          return r;
>   }
>
> +int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device *adev)
> +{
> +       unsigned long end_jiffies;
> +
> +       if (!adev->kfd.dev)
> +               return 0;
> +
> +       end_jiffies = msecs_to_jiffies(AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS) + jiffies;
> +       while (!kgd2kfd_is_processes_table_empty(adev->kfd.dev)) {
> +               if (time_after(jiffies, end_jiffies)) {
> +                       dev_err(adev->dev, "wait no process running timeout\n");
> +
> +                       return -ETIME;
> +               }
> +               schedule();
> +       }
> +
> +       return 0;
> +}
> +
>   int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>   {
>          int r = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index caee36e52a09..d46dccc5bbf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -38,6 +38,8 @@
>   #include "amdgpu_vm.h"
>   #include "amdgpu_xcp.h"
>
> +#define AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS 10000
> +
>   extern uint64_t amdgpu_amdkfd_total_mem_size;
>
>   enum TLB_FLUSH_TYPE {
> @@ -169,7 +171,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle);
>   bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
> -
> +int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device *adev);
>   int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
>
>   int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
> @@ -411,6 +413,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   void kgd2kfd_device_exit(struct kfd_dev *kfd);
>   void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>   int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> +bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd);
>   int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>   int kgd2kfd_post_reset(struct kfd_dev *kfd);
>   void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
> @@ -454,6 +457,11 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>          return 0;
>   }
>
> +static inline bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd)
> +{
> +       return true;
> +}
> +
>   static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>   {
>          return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 041ec3de55e7..2bec79e0c721 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -894,6 +894,17 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>          kfree(kfd);
>   }
>
> +bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd)
> +{
> +       bool is_empty;
> +
> +       mutex_lock(&kfd_processes_mutex);
> +       is_empty = hash_empty(kfd_processes_table);
> +       mutex_unlock(&kfd_processes_mutex);
> +
> +       return is_empty;
> +}
> +

hash table kfd_processes_table being empty does not mean all kfd 
processes have been terminated. kfd process got terminated through a 
specific workqueue: kfd_process_wq that is async from 
kfd_processes_table getting empty. The resources and data structure that 
kfd processes use may still not released though kfd_processes_table is 
empty.

I think a solid method to know all kfd process have been terminated is 
by checking the kobject under /sys: /sys/class/kfd/kfd/proc. When this 
directory is empty we know there is no any kfd process or all kfd 
processes had been terminated.

Regard

Xiaogang

>   int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>   {
>          struct kfd_node *node;
> --
> 2.25.1
>
--------------EULEDAEspbXYluBAIIJr1ZPX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/25/2024 10:18 AM, Zhigang Luo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240325151805.6379-1-Zhigang.Luo@amd.com">
      <pre class="moz-quote-pre" wrap="">Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.


Signed-off-by: Zhigang Luo <a class="moz-txt-link-rfc2396E" href="mailto:Zhigang.Luo@amd.com">&lt;Zhigang.Luo@amd.com&gt;</a>
Change-Id: I2a98d513c26107ac76ecf20e951c188afbc7ede6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 10 +++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 11 +++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d5fde8adf19b..e02bfcec608b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -261,6 +261,26 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
        return r;
 }

+int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device *adev)
+{
+       unsigned long end_jiffies;
+
+       if (!adev-&gt;kfd.dev)
+               return 0;
+
+       end_jiffies = msecs_to_jiffies(AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS) + jiffies;
+       while (!kgd2kfd_is_processes_table_empty(adev-&gt;kfd.dev)) {
+               if (time_after(jiffies, end_jiffies)) {
+                       dev_err(adev-&gt;dev, &quot;wait no process running timeout\n&quot;);
+
+                       return -ETIME;
+               }
+               schedule();
+       }
+
+       return 0;
+}
+
 int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
 {
        int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index caee36e52a09..d46dccc5bbf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -38,6 +38,8 @@
 #include &quot;amdgpu_vm.h&quot;
 #include &quot;amdgpu_xcp.h&quot;

+#define AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS 10000
+
 extern uint64_t amdgpu_amdkfd_total_mem_size;

 enum TLB_FLUSH_TYPE {
@@ -169,7 +171,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle);
 bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);

 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
-
+int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device *adev);
 int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);

 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
@@ -411,6 +413,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
+bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
@@ -454,6 +457,11 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
        return 0;
 }

+static inline bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd)
+{
+       return true;
+}
+
 static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 {
        return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 041ec3de55e7..2bec79e0c721 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -894,6 +894,17 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
        kfree(kfd);
 }

+bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd)
+{
+       bool is_empty;
+
+       mutex_lock(&amp;kfd_processes_mutex);
+       is_empty = hash_empty(kfd_processes_table);
+       mutex_unlock(&amp;kfd_processes_mutex);
+
+       return is_empty;
+}
+</pre>
    </blockquote>
    <p>hash table <span style="white-space: pre-wrap">kfd_processes_table</span>
      being empty does not mean all kfd processes have been terminated.
      kfd process got terminated through a specific workqueue:
      kfd_process_wq that is async from kfd_processes_table getting
      empty. The resources and data structure that kfd processes use may
      still not released though <span style="white-space: pre-wrap">kfd_processes_table</span>
      is empty.<br>
    </p>
    <p>I think a solid method to know all kfd process have been
      terminated is by checking the kobject under
      /sys:&nbsp;/sys/class/kfd/kfd/proc. When this directory is empty we
      know there is no any kfd process or all kfd processes had been
      terminated.<br>
    </p>
    <p>Regard</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:20240325151805.6379-1-Zhigang.Luo@amd.com">
      <pre class="moz-quote-pre" wrap="">
 int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 {
        struct kfd_node *node;
--
2.25.1

</pre>
    </blockquote>
  </body>
</html>

--------------EULEDAEspbXYluBAIIJr1ZPX--
