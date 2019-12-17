Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B000C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 15:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD65E2146E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 15:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I/nrD4Co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD65E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D589C6E17E;
	Tue, 17 Dec 2019 15:57:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698D96E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 15:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUnkdBQzwY64/OfyKwUbZraCgf+zqyWOhsE6x7D+FUissSYvR5LtOpNDmun/QV4D4ryoVtCfL0H6Qrg42wPXtuWHbR1GQmIUqTCwn7ZfXluiO+09s8n0tlQtT/RPIenOYU6yKJ1y2n5VP4PJDoBO0kfxrj5OY+vazJjo2mh1cjqkZyu7VtpIiBRI3DZG8aJNXcCpL/qNjvxMG8UvITe/zUpfgL2Uh7gGg3oZwoIvz62bIbLxPI8lw3z0qZVzQLq4hgmqzN9dxkoWxYqMB2KsxCqYXNah2bh2XyxdObAwDeByLx1JpBFfIXftd7X+oteW8cBKO9p05DYdEiiiTmUI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bML3IQpfZWGbrsWOpoc142Q3YOu6znfupc7E3zqgRs0=;
 b=TEamDzdlKrU+EYTdCGH1Qth/sYUzz3Hw/J3f9B7Zicxr8f31WB9uSGWSE6bz2cLrUYOS8MSLQDQ+92WFFEZURXEW2XsJ51hZ7TXNODe8Y05MCFVDKT2QFZBpsxSmaRId95FRqC8qr4z/kE7ZKm1+a1hywQiO49XT9AFxWknJPMAd+Ek8jKZKrG1YG8THZ8fr3UVDd8awfTFY/DS8hsHdMzl4Z464rvpOZfLeFYTamyzH+Dnp1ARbmcP6VJShNwpk9DfkbNH6Ed/EhMH4x9Sb1rqpkomE8E/jcPPxgl7TClizMBmulEKI+a48Q5q0c6PKz6L6O9w8UTe+TrnL4FKUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bML3IQpfZWGbrsWOpoc142Q3YOu6znfupc7E3zqgRs0=;
 b=I/nrD4CoPktPiU/G5ntI6iUNPjQMhd98BsnULlcI3ZJE9KQPCEIRIZGwNkFcn/sB7ej+68srg6tIdJPCMv6jI9rsv77U461OUe5jZ/BTjs1YkE3+J2RQfZn2tz7p/WZZzlYezb5wuzIv210JL09Jhyxwwg506iDr/SZ/BhJ9YGo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1230.namprd12.prod.outlook.com (10.169.204.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 15:57:09 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::f88c:2bc5:6549:70]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::f88c:2bc5:6549:70%3]) with mapi id 15.20.2559.012; Tue, 17 Dec 2019
 15:57:09 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: wait for all rings to drain before
 runtime suspending
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191216171834.217251-1-alexander.deucher@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <4a562357-ac45-a01c-593d-e7476d2a4a7a@amd.com>
Date: Tue, 17 Dec 2019 10:57:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20191216171834.217251-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
Received: from [172.27.231.243] (165.204.55.251) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 17 Dec 2019 15:57:08 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57b11878-b8ab-437a-a71d-08d78309c579
X-MS-TrafficTypeDiagnostic: MWHPR12MB1230:|MWHPR12MB1230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1230F1339AD8882289DB1F0EEA500@MWHPR12MB1230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(16576012)(26005)(4326008)(53546011)(956004)(2616005)(31696002)(86362001)(8936002)(6666004)(31686004)(66946007)(5660300002)(15650500001)(186003)(81166006)(81156014)(16526019)(52116002)(8676002)(6486002)(66476007)(66556008)(36756003)(2906002)(498600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1230;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEh3G2d0SRlxSCKRwRPV0Txntv4pH7QdHWEbFl5YoQsifMGw2wJPbDXXjVs0gSQb4eRf9qsVACyFhj9Fkq96SKVA6rIb+gVx30/er07lrYXegwZxSWsI/ZKUCwktaNusZ1Dwf13aHGJHoCCx0Wv7UN432/7KMkPQWTJr+zsSlguE0h/1fFNf+kaek1vKf7kBqCm3bGbdQfkCikQ1cWdMs660OrxWrAn3XgRZHg6+w72GKNef5NvIaeVCWR+Yv6GsfPXIwKNn1ol8Wu8TaZm3OG2jNgLpSP993p3ffbJAh7OCaiMa5tDhlLkH/aA0ZLP0TqEPPfuNfI/B7mbKubMLA75voWmIVfsAnIOfEd8KwtMzlTDIKFLkMxBdCGlCJY1bS7NNOB0tMusao3JWhttQIDz/XYUOrFK7dbQ3LTTgflkxddCG6tas3LsQ/hQAq7km
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b11878-b8ab-437a-a71d-08d78309c579
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 15:57:09.1121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V49I9j/boU0NcdiwA9B+/k3VdGjonZspW2M+7CE1sqSuugchertRt1nVmDKWiKXhoUD08P4E2LVIcbX0n2ZGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1230
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 12/16/19 12:18 PM, Alex Deucher wrote:
> Add a safety check to runtime suspend to make sure all outstanding
> fences have signaled before we suspend.  Doesn't fix any known issue.
>
> We already do this via the fence driver suspend function, but we
> just force completion rather than bailing.  This bails on runtime
> suspend so we can try again later once the fences are signaled to
> avoid missing any outstanding work.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d1e9946ac218..61dc26515c7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1214,13 +1214,23 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct drm_device *drm_dev = pci_get_drvdata(pdev);
>   	struct amdgpu_device *adev = drm_dev->dev_private;
> -	int ret;
> +	int ret, i;
>   
>   	if (!adev->runpm) {
>   		pm_runtime_forbid(dev);
>   		return -EBUSY;
>   	}
>   
> +	/* wait for all rings to drain before suspending */
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		if (ring && ring->sched.ready) {
> +			ret = amdgpu_fence_wait_empty(ring);
> +			if (ret)
> +				return -EBUSY;
> +		}
> +	}
> +
>   	if (amdgpu_device_supports_boco(drm_dev))
>   		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>   	drm_kms_helper_poll_disable(drm_dev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
