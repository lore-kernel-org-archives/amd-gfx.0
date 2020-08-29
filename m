Return-Path: <SRS0=m/vD=CH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E5C433E6
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 02:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6880920809
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 02:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ia0O7Xb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6880920809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366286E09C;
	Sat, 29 Aug 2020 02:16:34 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690079.outbound.protection.outlook.com [40.107.69.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A336E09C
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2020 02:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2wwz+ae4Gxhzvqe7jijSMCm+J0UjETkYOPIMFECyuAjD+9rzlbPYM/JSLwSY4q/3INa6SG8uBcv4MelFE9x/z+ZFvdHwHdFCmaITtv40VRsTkQrRCUx+IB+zEfsr4AVzO6eBtdBSzLyGET7A7n8mvMVJuKke9qyXUMSZ+ryoOR2QqleVuNk5sa8lPtnLX3QRV93sZCgV5D2HMKi/NOWXREZRqe21uh088v9i7wgimU00PD2rpr1+c0zXpCv7U7/0cPkvNDNL2kAfUQRnwImCEpg/9RXeyM34C4YN3sSbnUx0TQPgnFJSrQyPKurk9lDgPT0hMW0iYB0UeO8SSqcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNbsqtEKlIeyHia+dVlw7JGaU0KjhZT4IquEMcdKMV4=;
 b=nydozXkTPyFI3vY+SWJmWkwEjhR4MtXZ6MCad5WW8W2B/l1SPgjilEkMw0WKAv+LMDIeSpoi+82NQ7Fbtb6B3jskKlPoUjiO+3k/uF6nXfgrpVdCgNAOZY5ynWXY0TgG9tNj5du+4ftBww/9d+p+bSv8tlrwcvpREXv6z2wix3x1x6SGG/Q/fCpF9/sfsyy4A3W65lMsYtZQELRjRsib1wOHMJ8X2QAop3G2ffkeNwvO8nr/jyPJA0T0oRAjR5FqbhU1csOEYvBnSmFkqlRQzwsvFCavn2CQVDzbeBngDmtPxbhTDhnTeThTh8/ZHZi+8mczwThE58tKEVXGRsyQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNbsqtEKlIeyHia+dVlw7JGaU0KjhZT4IquEMcdKMV4=;
 b=ia0O7Xb4D2r103MNJx9Ziv3qKDUSzGlpaGDZNEeCetAT6snsDdGd5JZti3lVYEL1MxzogREFzZwzeb30Nn29oAWHdPs08pDHSNfD5/AHjKMh3JEecb+b2EsFJ2NbZJzLxdWTgLzf0qStg2S38yDACdPHYFdItj3LBUaKdxb/d9U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Sat, 29 Aug
 2020 02:16:28 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3305.033; Sat, 29 Aug 2020
 02:16:28 +0000
Subject: Re: [PATCH 3/7] drm/amdgpu: Block all job scheduling activity during
 DPC recovery
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-4-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <3261236e-b13e-73ef-85e5-f7eabe5305b2@amd.com>
Date: Fri, 28 Aug 2020 22:16:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1598453182-6946-4-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Sat, 29 Aug 2020 02:16:27 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15700c67-5998-4822-b822-08d84bc18978
X-MS-TrafficTypeDiagnostic: DM6PR12MB3964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39649EA2D793837C4E04CEF999530@DM6PR12MB3964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sy81lZ0zX823HgPkS7SY0NjHLjL2CuLBAxMVfXlbySAHXfqvPmexcNPXpfPP5oAUlUWVwzV3Z/tRPIpIuOcbOw/WJODEL3BiYvR6IG6w8b/+AAt+/5vU03oqS0tlHA5WirVMAJ+aRkOGHcwgtzYyDvgY3WuyIf4vM1J1xYmUEWEYq0GRUgn4yyIitdw9JtsXAl9Zm34kjAnO6zRLuDPTsouSqazrJNJdvfASjYH2d7sV0LYHwFIYMqQq5NVU5xSZ4Q/9OQOE1VzdDiIYrs9TB5sDui1OWxrjStm1SBaL6epCfI6W+Dmts+SYZYv1rSU/dPugNsttUoZlhhkFIyCtcU/hL5hoWVBrA4cAvuKUj5RV1XHmSO1Z7VTJcxKollRG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(6486002)(31696002)(83380400001)(8936002)(52116002)(4326008)(86362001)(8676002)(316002)(478600001)(2906002)(31686004)(66476007)(16576012)(2616005)(956004)(66556008)(44832011)(26005)(186003)(5660300002)(53546011)(66946007)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: msu7JVwzWOM6DRM7Zxp4rDzC9zZlyYfDXTR/581TepjdIQ6VKdbH2Mh7bZF35JKM2ycykNdu+VwS7Mn1j/2lJ6x5qHMJdBclws2y/JLzYgSCY0JlCDMARg3xwKjd/68E0n6mw9JVgMRu3U6L0x/K0eBjIJ4WVR2ukigubLr1aTxrIsAdssP2hGGtODW52n1fkKvoTGLXQD2OB9/iRN8H47dkMXwgd59b6iAjKi3lJKDSf1K0OnqT2j/IaJb7c1pbnHURJEY0PnxG/og20AdISBLF9mKe+iXyPQoO54G9yvUq4gS9OQTy76l0ur69XcU/O9nYt+coRF9yQRX+asZRBz+YLHOcBkTXxyF25kZE+3ndoDBmp4WwTljh4EcL3qba7MqEV7qQLQbM8pkLiXhL/ySw5rM/C+oj4yito7j8PMfZFqCGslqgIc7J3rku5wMi3Xfkd7Kfd/CuuLmskfF5K1xGkiUpZTxNxUQHPax+kaDfcwaDGRwsy3AeDXI+t0kZJ/jLahL1lF53e04IS+1n+YlsKJGrIbfhU318e30VItEsfKnfSgGG/3OIok75bfCQhFdXJSHDzPZHFcimVOFG4CjRf+QVi+OF/uj/YGKd0lti66Fqps+fZ7zgrqhxFedML6Iau6HU8AU1N6b82q+e8A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15700c67-5998-4822-b822-08d84bc18978
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 02:16:28.1175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRuMPRUnjehbxbujNRbCYGoxL7snLL3YkriBUN+lZHq7GREEy3IvZvcfxPhbFlx+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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
Cc: alexander.deucher@amd.com, nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-26 10:46, Andrey Grodzovsky wrote:
> DPC recovery involves ASIC reset just as normal GPU recovery so block
> SW GPU shcedulers and wait on all concurent GPU resets.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e1bbefd..0a2130b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4747,6 +4747,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
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
> @@ -4760,16 +4774,38 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
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
> -	case pci_channel_io_frozen: {
> -		/* Fatal error, prepare for slot reset */
> +	case pci_channel_io_frozen: { /* Fatal error, prepare for slot reset */
> +
> +		/*
> +		 * Cancel and wait for all TDRs in progress if failing to
> +		 * set  adev->in_gpu_reset in amdgpu_device_lock_adev
> +		 *
> +		 * Locking adev->reset_sem will perevent any external access
> +		 * to GPU during PCI error recovery
> +		 */
> +		while (!amdgpu_device_lock_adev(adev, NULL))
> +			amdgpu_cancel_all_tdr(adev);

Is it possible for this to hang forever? It eventually
resolves to __cancel_work_timer() in kernel/workqueue.c
which provides no timeout.

If you cannot guarantee the TDRs to return back, then
you'd need a timeout here.

Regards,
Luben

> +
> +		/*
> +		 * Block any work scheduling as we do for regualr GPU reset
> +		 * for the duration of the recoveryq
> +		 */
> +		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +			struct amdgpu_ring *ring = adev->rings[i];
> +
> +			if (!ring || !ring->sched.thread)
> +				continue;
> +
> +			drm_sched_stop(&ring->sched, NULL);
> +		}
>  
> -		amdgpu_device_lock_adev(adev);
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	}
>  	case pci_channel_io_perm_failure:
> @@ -4902,8 +4938,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
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
