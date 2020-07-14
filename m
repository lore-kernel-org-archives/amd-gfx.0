Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD62EC433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 16:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFC622515
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b8JwAJZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFC622515
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47FDB6E2B4;
	Tue, 14 Jul 2020 16:08:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB2A6E2B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 16:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB3y6k/NzXL6g1njaHT8n8xFl8xHL3WROs4ITTzv4gs5W6MOAXb0+uoL6NbixgVNn+uJNZK982pilvXsyeHeQ3GCQtlObsB9NkRx17AgjF04uAETY/ePD7p5LuNsV3P1Mj7d9Ue3Ghb3OQnmTNkC5bKP/iL9DLNIqHB2JvPA+BDWa5pfDWMkmHoho/lg5Lxrl0+keyF6MsQag2M8KFom7Sg5qtio+7lvIEVCo4ldrQ3TH3uPKTXYtCLJ1vJKwexhjqOFPNHVWbjO/0qRdbwznNjXe+E45mJNVTA5dRovxbsK/nhQ+cGpXnm5NOEuChjTkoAGE9b7JSE126r7giutrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APMmxT6hDjJBwtv8ZeeRG45xIYb48wa/MCT8sKOpvpU=;
 b=g9GyUKGg+mwsOBYhAVM0NlYu5Lrmni3oMCVsTt/AYbDQ4L+OW7HnyS0ATx/jElsQJDIEgCGIIy033hD/qHTx313SBNdFah7FK9DI3NDbK5AbJnQSuZbAph1gi9D4MgeNSYDGoC7Tn3sXOleGaXdnplRyzhAK+SE4u4Ggd7iEpiNH1dYKotYLA5bJItXLcKgiFostK/XoA6sB49vW+ffVZUlqu+p1HD+uBC9nTfFdYpx1uX94wQPAAQVgtIMp7l8zpsqgCw7NkNJ1MHfK+Am4DvcSm8WM+WMyVKjvweiW3SSo5KUGXQd/IrfWSp7WOsfZySKtgQPLHEwZWp3s2vUSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APMmxT6hDjJBwtv8ZeeRG45xIYb48wa/MCT8sKOpvpU=;
 b=b8JwAJZ/gPY5HQjzVJgNGD4KHuLWAdqyYeOvYI3946rQEKnsT+0Uxsp8qG+E9fO2IrtpH+sS6IkEXgoqwkWlX0CvdWQn5ezbharBsAyK8gRyeyo+rpB8v2BNEynBBCHRlAC6zCRIjLJE8yEnQB+mzU66JoOV80h1IJVWLKQrHmY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM5PR12MB1388.namprd12.prod.outlook.com (2603:10b6:3:78::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 16:08:16 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::9c20:aa3e:1b50:7ce5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::9c20:aa3e:1b50:7ce5%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 16:08:16 +0000
Subject: Re: [PATCH] drm/amdkfd: fix kernel-doc and cleanup
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200714043803.9967-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f122d043-e23f-c3b3-49df-b0e00be8c83e@amd.com>
Date: Tue, 14 Jul 2020 12:08:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200714043803.9967-1-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::16) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.53.25) by
 YQXPR01CA0087.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 16:08:16 +0000
X-Originating-IP: [142.117.53.25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67511d07-213e-4199-e4bf-08d828101e57
X-MS-TrafficTypeDiagnostic: DM5PR12MB1388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13887B82C779C1D05453B2A992610@DM5PR12MB1388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pMLGmPzNNoHZI024lIC6nrcV6jokYWERLK6+7OqU/Z++odvt+p4ZpL1ijm04zPgwM76cRaSDwDlesviDtJi2M907QfpZOJ5TZyGp3mIXLUM/aEub+ROos5EMKZN5zlYF+9HRfZQoK8fK+WEPS8Snss7fPnyRWeV/bYu9yWy3OgMga6Qk9WdepSnzL7x9vD1oAx6tsTniDcPSKNi6TQZbltBow28iBOcv/Bv5eqnLziZGYCfmGC9K/QMCY94u6lULgONdlDtQdlUPqFlBWTaEDABkB9p1oscBP8dMtkf257LW1I4nKlElpUQ1ECUW8+Gy110NnoJwovEcGNKrd/io+MOrQ2Om6rSfk0xlHB8EbuMIUkIxOqNQ4FdNsc1ej0m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(83380400001)(66476007)(66946007)(2906002)(8676002)(44832011)(16576012)(6486002)(31686004)(66556008)(2616005)(316002)(36756003)(26005)(4326008)(86362001)(16526019)(186003)(5660300002)(52116002)(8936002)(478600001)(956004)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: s+vDSAcWGTCshksa2z5LjYK3NGVjS0v3zSaRWZ7EQ43Ct2Zs4UaReq++GSdWPJvIY3OvqIgmFXHHUr0TAoxCQWQnRVyv/EFI5oDLa+A7o8w8ijOQNBR5U27XEjTPk28YVBz3vlpol0a5E6ePaLRWoMmqt7MEyszHQVSDxPW+TZoQBVGcrDB73LmyIoI0xK8QXJPz4yzFJBSFquDtO/Yd28gMc5Yblcu10OwGR2n8lZBBstkPwHzlw0P6Amr30oMPC3RJsu5xqMcI5kfYPh+0+Qq7ICP1Rse7uoF2c1SHtNMi80U/6NcWowgpVHx9rzoe8P2PoxgwBX4sYwsu7PvmBa2RkZU0H4ImQFgMVm9Ih5uA2gBo6Jxq6q+WCkx8KTvDwjA7iwNvUmgm9850w+M4ba+4jHQL8ajnmJOv0Xmw3DdY7jhRzPyYGRsNBg31maYuBVamGTBSKq0f+oNkvTwAAA6k+CeSyd0QBkBI3050AkCWBdd43CyjQMz6Xa9e1UjL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67511d07-213e-4199-e4bf-08d828101e57
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 16:08:16.7988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDreBMQHP2p74QkpyHZjrqvx/AeXzpwCuLiWBkdTTVc5ifNBtjnX6InLz3fqEGPVq3jXs7IopLVo2gt2bazptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1388
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-07-14 um 12:38 a.m. schrieb Rajneesh Bhardwaj:
>  - fix some styling issues
>  - fixes for kernel-doc type
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 61 +++++++++++----------------
>  1 file changed, 25 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 51ba2020732e..4b86d912a5e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -97,7 +97,7 @@
>   * Size of the per-process TBA+TMA buffer: 2 pages
>   *
>   * The first page is the TBA used for the CWSR ISA code. The second
> - * page is used as TMA for daisy changing a user-mode trap handler.
> + * page is used as TMA for user-mode trap handler setup in daisy-chain mode.
>   */
>  #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>  #define KFD_CWSR_TMA_OFFSET PAGE_SIZE
> @@ -157,29 +157,19 @@ extern int debug_largebar;
>   */
>  extern int ignore_crat;
>  
> -/*
> - * Set sh_mem_config.retry_disable on Vega10
> - */
> +/* Set sh_mem_config.retry_disable on GFX v9 */
>  extern int amdgpu_noretry;
>  
> -/*
> - * Halt if HWS hang is detected
> - */
> +/* Halt if HWS hang is detected */
>  extern int halt_if_hws_hang;
>  
> -/*
> - * Whether MEC FW support GWS barriers
> - */
> +/* Whether MEC FW support GWS barriers */
>  extern bool hws_gws_support;
>  
> -/*
> - * Queue preemption timeout in ms
> - */
> +/* Queue preemption timeout in ms */
>  extern int queue_preemption_timeout_ms;
>  
> -/*
> - * Enable eviction debug messages
> - */
> +/* Enable eviction debug messages */
>  extern bool debug_evictions;
>  
>  enum cache_policy {
> @@ -301,7 +291,7 @@ struct kfd_dev {
>  
>  	/* xGMI */
>  	uint64_t hive_id;
> -    
> +
>  	/* UUID */
>  	uint64_t unique_id;
>  
> @@ -313,7 +303,7 @@ struct kfd_dev {
>  	/* Compute Profile ref. count */
>  	atomic_t compute_profile;
>  
> -	/* Global GWS resource shared b/t processes*/
> +	/* Global GWS resource shared between processes */
>  	void *gws;
>  
>  	/* Clients watching SMI events */
> @@ -333,7 +323,7 @@ void kfd_chardev_exit(void);
>  struct device *kfd_chardev(void);
>  
>  /**
> - * enum kfd_unmap_queues_filter
> + * enum kfd_unmap_queues_filter - Enum for queue filters.
>   *
>   * @KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE: Preempts single queue.
>   *
> @@ -352,15 +342,17 @@ enum kfd_unmap_queues_filter {
>  };
>  
>  /**
> - * enum kfd_queue_type
> + * enum kfd_queue_type - Enum for various queue types.
>   *
>   * @KFD_QUEUE_TYPE_COMPUTE: Regular user mode queue type.
>   *
> - * @KFD_QUEUE_TYPE_SDMA: Sdma user mode queue type.
> + * @KFD_QUEUE_TYPE_SDMA: SDMA user mode queue type.
>   *
>   * @KFD_QUEUE_TYPE_HIQ: HIQ queue type.
>   *
>   * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
> + *
> + * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
>   */
>  enum kfd_queue_type  {
>  	KFD_QUEUE_TYPE_COMPUTE,
> @@ -406,9 +398,9 @@ enum KFD_QUEUE_PRIORITY {
>   *
>   * @write_ptr: Defines the number of dwords written to the ring buffer.
>   *
> - * @doorbell_ptr: This field aim is to notify the H/W of new packet written to
> - * the queue ring buffer. This field should be similar to write_ptr and the
> - * user should update this field after he updated the write_ptr.
> + * @doorbell_ptr: Notifies the H/W of new packet written to the queue ring
> + * buffer. This field should be similar to write_ptr and the user should
> + * update this field after updating the write_ptr.
>   *
>   * @doorbell_off: The doorbell offset in the doorbell pci-bar.
>   *
> @@ -477,7 +469,7 @@ struct queue_properties {
>   *
>   * @list: Queue linked list.
>   *
> - * @mqd: The queue MQD.
> + * @mqd: The queue MQD (memory queue descriptor).
>   *
>   * @mqd_mem_obj: The MQD local gpu memory object.
>   *
> @@ -486,7 +478,7 @@ struct queue_properties {
>   * @properties: The queue properties.
>   *
>   * @mec: Used only in no cp scheduling mode and identifies to micro engine id
> - *	 that the queue should be execute on.
> + *	 that the queue should be executed on.
>   *
>   * @pipe: Used only in no cp scheduling mode and identifies the queue's pipe
>   *	  id.
> @@ -527,9 +519,6 @@ struct queue {
>  	struct kobject kobj;
>  };
>  
> -/*
> - * Please read the kfd_mqd_manager.h description.
> - */
>  enum KFD_MQD_TYPE {
>  	KFD_MQD_TYPE_HIQ = 0,		/* for hiq */
>  	KFD_MQD_TYPE_CP,		/* for cp queues and diq */
> @@ -587,9 +576,7 @@ struct qcm_process_device {
>  	 */
>  	bool mapped_gws_queue;
>  
> -	/*
> -	 * All the memory management data should be here too
> -	 */
> +	/* All the memory management data should be here too */
>  	uint64_t gds_context_area;
>  	/* Contains page table flags such as AMDGPU_PTE_VALID since gfx9 */
>  	uint64_t page_table_base;
> @@ -789,11 +776,13 @@ extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
>  extern struct srcu_struct kfd_processes_srcu;
>  
>  /**
> - * Ioctl function type.
> + * typedef amdkfd_ioctl_t - typedef for ioctl function pointer.
> + *
> + * @filep: pointer to file structure.
> + * @p: amdkfd process pointer.
> + * @data: pointer to arg that was copied from user.
>   *
> - * \param filep pointer to file structure.
> - * \param p amdkfd process pointer.
> - * \param data pointer to arg that was copied from user.
> + * Return: returns ioctl completion code.
>   */
>  typedef int amdkfd_ioctl_t(struct file *filep, struct kfd_process *p,
>  				void *data);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
