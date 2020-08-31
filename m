Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB011C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4768206F0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DxWlCFZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4768206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491D16E41A;
	Mon, 31 Aug 2020 21:00:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53AA6E41A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 21:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Set1ZnnpLZwlhBTTOYqzo17jlW6ZEtMM0b7QxgxHFBOV8sI8cu22NNv5+HC7k9VFIoMFWcqoi41z/zE2jXmINTtENKDFvvtljwD70ZV4sYsYJvdAyOTHtlHOU32p9phmBXsG1iYqI/Nk028/7GbDHbe72BPWddoJ/NSIbcxEXF1nAWyef9IkKJQhldaQXsFhgNGeKiglnsTWh4LnA8jEmnA2igZ24bSc2CpF4m8TGesIn+9j866cZtaAnn6ibyTugVv3PAeHc4l2Dkup5BY6ZaLWOsirOzR53ADzyBKu/PmX5OcXQvkGau0T9Y/IS9XurcVriRtDyP0xc6bf2GhB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lISsW44OwTrBm3jfUqFGoc+oB7CCN0LwlqNL0KRmyws=;
 b=hsWu3oNUppbYn9t0hb0K4DD0F5Uo6lifZtszRvejIyp+GY47pLYru93hUFWFR5Sm7Rb8Oa0Wu2dofGddqOmW7JHXxzxVlyIHN05vSOfb2D4psw0F7wq/iUUA+cg9nl2u7xvRZVViGUKY/LJ/KfvNQS5/MhANkAo1S0jsPKRIzI1hkY+jtRks7BGKvMmDbFwuQspOy5WGZMDTHEp5r0WJyo09RTGop3gqBUQTCkIKeu6d/0Odn+ssA8GdXTQJdrccnOjvEcABjXRak/9kFfktQS9dJ1AAjGvfgxCnuwWoiYluYLM4TvPYBtcLnipxoTsZOyY6ImPObQjnV8ERek7Saw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lISsW44OwTrBm3jfUqFGoc+oB7CCN0LwlqNL0KRmyws=;
 b=DxWlCFZs0SITHyB/W3XzCwdbt5gq6dTOGyHoiEjD03dDrFd/WbPch5b3SjP6JeMOC/7+2aSoR2b/vfIrdkk3Y7cPvOiPLWkCPGRWSduQODIlzq+CEf5xaLbiUMJpcBETG3mETfNcNLHTU3mpxNI/eUqCyN+DdfxJqpynUg4grWA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 21:00:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 21:00:34 +0000
Subject: Re: [PATCH v3 3/8] drm/amdgpu: Block all job scheduling activity
 during DPC recovery
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598889049-28321-4-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <3f9efceb-cb2c-70a8-43aa-0039bf28c64a@amd.com>
Date: Mon, 31 Aug 2020 17:00:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
In-Reply-To: <1598889049-28321-4-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 21:00:33 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd84792a-dadb-40f3-0f12-08d84df0e724
X-MS-TrafficTypeDiagnostic: DM6PR12MB2617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2617CEECA2333EE1BEEE467899510@DM6PR12MB2617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGZVkqzRyys+BO6ST42jDdv2ZTGb4lJmEUxFB/iKqd84TyAOH7DFLstV4vT8P/oiDnHoBPhLCcpCqtkMAEVTlcCJ8gQN5D2su5BfyzR4PklgVaL3BGGwuPDVdSDQMpdcp1mL+xOPJ0w4mEm1GUd5sdsVcJnL4O5uHvajBtmTcHInIqDKKCJNzoZheKtJqFdbIkEuOANjV9YgUjigwQRzKDLWLWyfWsRcaMo7hKdzvIrM70F5FA4kbS8Rz9JT9scB3AaCmXQxounm4Z4tIFJ0/LtzitOHjTOhuzQdEFOtMQNhXD0voj4xgysKVKBN37Z1Po5DIpzahL2xXYtHhThYMP9NN5UBhRwi5i+wY3gB11VAUV/mPFwoB7rK7WJTsyCr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(8936002)(83380400001)(31696002)(16576012)(5660300002)(316002)(186003)(66946007)(8676002)(52116002)(2906002)(478600001)(4326008)(956004)(2616005)(36756003)(86362001)(53546011)(66556008)(31686004)(44832011)(6486002)(66476007)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5naWqMjOVdFdGHCDA32ZESYOobT2E35OEt/Usa0ec/rdmBbD+wWyV0EzkkaDFOSXMGyVhCXCSKqCuDuLGzjZ2z29tbLptKlCym+gxJ4jptEbLPShDKSbkFRQKzUCOuf5ROt6ENAyz/zrMVglEaNT3nom5gcygfjQ9ICj3DclPZN+Gt2soCScJeK6pSqJagzig4tuUCamU9SQLNOs35SGJiyFxOOkTD3Zu+ZN4dlPHRTSXluTFAZ3DhD2QLI1HTZwkt1dtfoawevOGlKhbiYGezIQarrW+niZ3OKvffnGvYrzwh1CFNpVBaqbDKyrD1XvNtG/VYv1C1avitiO50Qxl0vKcP2aG4avJBiLyyxK7WAclZF5Q0f+vWjiLSoRNxEusxKlu6g/9SGoHJ4W3Ogj7Ld10Bi0Z7q7dg4F3eu1M3uGHsgciMli07nWmedackG7koPEfauY9LrdOM4dPEeEJUXtJE0+6IudN6cVhlqSCyQsyLvQEzb9ncBBUbI7fX6vPmbo+3vRp87ne9uu0IDs/6nWTxkbw495bAxEptxBfFJKEQqcLGzniqPelNH0ai/im/1nG26T8zUv3OBJKQ2ln2AU5AyHXzLJAvB8S3w/z0ajOfM54KZ+J7AfykJxDsjr7HvACzehK7sBdr/q+oADrA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd84792a-dadb-40f3-0f12-08d84df0e724
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 21:00:34.0263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBOMNPzoqre8tlQ+zcYNYDZUUWxgiXfKrp7OEFJ1Luf3HmjH/SO5LJDAIflFkNXm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
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
Cc: alexander.deucher@amd.com, nirmodas@amd.com, christian.koenig@amd.com,
 Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-31 11:50 a.m., Andrey Grodzovsky wrote:
> DPC recovery involves ASIC reset just as normal GPU recovery so blosk

Again, typo: "blosk" --> "blocks".

> SW GPU schedulers and wait on all concurrent GPU resets.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 43ce473..c569523 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4743,6 +4743,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>  	return 0;
>  }
>  
> +static void amdgpu_cancel_all_tdr(struct amdgpu_device *adev)
> +{
> +	int i;
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || !ring->sched.thread)
> +			continue;
> +
> +		cancel_delayed_work_sync(&ring->sched.work_tdr);
> +	}
> +}
> +
>  /**
>   * amdgpu_pci_error_detected - Called when a PCI error is detected.
>   * @pdev: PCI device struct
> @@ -4756,15 +4770,37 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int i;
>  
>  	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
>  
>  	switch (state) {
>  	case pci_channel_io_normal:
>  		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> -		/* Fatal error, prepare for slot reset */
> -		amdgpu_device_lock_adev(adev);
> +	/* Fatal error, prepare f
> +	case pci_channel_io_frozen:		
> +		/*		
> +		 * Cancel and wait for all TDRs in progress if failing to
> +		 * set  adev->in_gpu_reset in amdgpu_device_lock_adev
> +		 *
> +		 * Locking adev->reset_sem will prevent any external access
> +		 * to GPU during PCI error recovery
> +		 */
> +		while (!amdgpu_device_lock_adev(adev, NULL))
> +			amdgpu_cancel_all_tdr(adev);

As in v1, I don't see how this is protected from
polling forever. "amdgpu_cancel_all_tdr()" defined above,
doesn't actively cancel anything--it just waits.

"amdgpu_device_lock_adev()" similarly only modifies
a few variables.

Neither of those two functions seem to escalate or otherwise
reset the hardware. If the reset/hw blocks for whatever
reason, this loop will hang forever.

Regards,
Luben

> +
> +		/*
> +		 * Block any work scheduling as we do for regular GPU reset
> +		 * for the duration of the recovery
> +		 */
> +		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +			struct amdgpu_ring *ring = adev->rings[i];
> +
> +			if (!ring || !ring->sched.thread)
> +				continue;
> +
> +			drm_sched_stop(&ring->sched, NULL);
> +		}
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	case pci_channel_io_perm_failure:
>  		/* Permanent error, prepare for device removal */
> @@ -4897,8 +4933,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int i;
>  
> -	amdgpu_device_unlock_adev(adev);
>  
>  	DRM_INFO("PCI error: resume callback!!\n");
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || !ring->sched.thread)
> +			continue;
> +
> +
> +		drm_sched_resubmit_jobs(&ring->sched);
> +		drm_sched_start(&ring->sched, true);
> +	}
> +
> +	amdgpu_device_unlock_adev(adev);
>  }
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
