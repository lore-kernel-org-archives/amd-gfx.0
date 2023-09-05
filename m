Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949CDC83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 05:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059A810E41F;
	Tue,  5 Sep 2023 05:24:19 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DD310E41F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 05:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odOFo76HImi4lsGfnqr/aKZ6dzovxifzH4tJDu68lnAjFl9BUztppx2su4UxQKwGs54p9IXQgt75gQ+MyJXcZEfBG3JMKez3E1SdHe9MObFgdauwFJsSjcBZmVjvO0WN3N9o1Dsr+YhuynVAYQBBWqHYjHaZCrRz7gj9ePjgbzrJA05NrgTDRdGr3ggkofwvQJwPiXDO/XiJmUWPMAL6bBz8TeSH//3NuQAWmP6oygbpCNp0C6HnbVrQpvF/vw8LWRXLNWc1gI539HB3Ks5PRsEcU7jpKJUMtdsdkQeX9O/t1VPhm1iVdKD7QZtwW6AfqhzI1WCQEerzk8PevHrciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acZmHZLUGHwHaZWS+tpgUlU3UMjWSWz6Lh8T2lYQies=;
 b=jnndmYnFcykRXYRAm6XtwkUNBuelEtD3+I20I2LqtxL/OsEZO4Oae3ePuFv0OOkLbUuhgE40ZEXUD9C2GIqGcQwK67LW9jtEww4yVEqsy1LAJI6iBoq8hmeiLTEbiczuMFgFTekkqB3W4Jc4J3pQGyUjMeVTcsDJhpsSHfjJyS9aaHAEH308cJprxpuYrO/+od2V17pqkxFwH85QX7VdOhF1ouuDUgeeLVD47G7ltDcTasW0E8Ce38kXyZEPFdAOThkfFkyLn4Rc5blpV7+Kw7uFR48Nq8e3GS+hab6i7uGjZt1fV8NPiOJswOvlBlocv4/o5kcVNg+q8JIKG0/UFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acZmHZLUGHwHaZWS+tpgUlU3UMjWSWz6Lh8T2lYQies=;
 b=Bcl68Fqt7p6TB0/DEsx/Y8uPG5/9R23FhMy7YeAsLpYLPFWpAvRPqEkpwZMNKOWYdrv4bl1GMXWjo52KnOy1nbQZwfKV9nhBARYx1Uh3pa2mmKN+237vpHjptMGcDsSVpmRmyKo2UmUCOjBYtGDLSOIQ9vk/EvTE8bvpROgvN9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 05:24:15 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 05:24:15 +0000
Message-ID: <22adf274-ba4e-63d5-df8f-f7cafdb1075b@amd.com>
Date: Tue, 5 Sep 2023 07:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amd: Fix the flag setting code for interrupt request
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20230904060501.2942018-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230904060501.2942018-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e9badd-1120-4253-cafc-08dbadd057f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGjuiaTThlozae/pvJBteE8S3aQ4BbCKDh5RNnTl34PTqste+txHWN4QCgPUBdcTT39jJKrh0B683+5K+YRLcoYIf5S6VbJKFvozjG8PsT2YlZ7J5zmUUMfhw4QagdQ2Iz3ImJOpbLSnXBkvjLKj3l2cx0aYCefXIQfdwILtxEJQFPDYE3wr5RUmvq2tX+Qg8HcXuTrjr6oTMvo7EzUHYaQOTB5bNVYmMnNYPBiZZ2ItY2Q5Y/IFsKaQNcSQBNE8uvPoOe6NqTB0WG7/y5fI/rXHnJ+UJPpkSTU5gITX9NCDsn3NqHl1xWu3c0otzMbPnD6SmMrX+6MVTmB49DELxwECkKti8ZMCoQ0MdwZc616OiMOVAXMNKuy9W5sMeDlmgy7lbRVSZ2CmPJJt05XNNgMRMczbJDiuszUOuL8tIK4b+CVxXqW/RMo/s2VJlPc3QlH2Q8lxfq687w1eAPWTsaYhXM68yzC6YrCYD7sMBMwnrKv2lCNilpciMRjQWw2ec2dpZzU1V0X/Z85jlaAjlJa7Ls8+fHAibzyvyUVh5FF94nMZpQCkxAvgg3FHYURF6DwzOC9fOVwKasot5ej7QWruseqFgShcrQUU9Biuh8Ko8ceSri+uzPbBTrcdPRNX17uIx9AOeuteJK3qc2miGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(31686004)(36756003)(83380400001)(86362001)(31696002)(41300700001)(5660300002)(4326008)(8676002)(8936002)(6506007)(6666004)(6486002)(2616005)(26005)(6512007)(478600001)(316002)(2906002)(38100700002)(66476007)(66556008)(66946007)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckkrNmtZS1hVUERSSUFYRFNrcEY1TjZqREJRcjNrcUNKQUdaZmlLcDl6WVg2?=
 =?utf-8?B?d3NoYjRtK3VFdEtQaDcwY2xuR2M4R1ozZzZuTXUxVWM3WnZRVHVoaXQydlAv?=
 =?utf-8?B?blNsN1pJYzZSVEZhcDNUTzN5WDRNeFJOKzdWTk8rTHl0QlVkMHZTOUU2b3VZ?=
 =?utf-8?B?SGEwa3VKWmNldVhIN25ENTNUdEQ3N0VhVWgyWFVPVlludDJxYXpGeVZIN0xU?=
 =?utf-8?B?eVA4YzQranlyREFhV0ZSQWwzS1FvUkFka3A2UnFOQnpzbjMzb2grWjMxcDd3?=
 =?utf-8?B?N0ZkbGVQeERONytBM0VidVJXdmU2a2twMVJjejJDdmk1NDB6VjJCWlhXT29q?=
 =?utf-8?B?U0ZLQUpXNGJJcHJxUzR3cjF3R3lTVFcwTGpMU1owcStMN1ZTNzJkYkZrNW9p?=
 =?utf-8?B?Y0ZmazBBaU9PWVVZakZGZ3YrdGVYeDVoZmhFVUdMTUovYllqUU4rRXphcXgw?=
 =?utf-8?B?Vm00NUkxWCsvYllpdnJkeGg1VTdCTTQybGxWaEswL3l4VklOWXpLeXNnK052?=
 =?utf-8?B?eUFHZXB5ZmRYNUxNajhKLy9Fa05TN2I3RDZ3ekRMV2dPbVpHck13ZTAxZnFB?=
 =?utf-8?B?ZmRDaHNYbVY3UmV1NFlpS21YTEY4REtJS1V5VUZ0c3BFMDZjaFJ3QUovU2w1?=
 =?utf-8?B?b0tNTnFOY0crbE9XWmFBa3FkMEVSYlVPVGkvdjZlbGV1VGtmRzBSRVE1K1Vr?=
 =?utf-8?B?YnRKazJkZGRqT2NvbHcreXhTNzNNYWFQSEU2bk9TZHhNTC85N0RScmxuUFRi?=
 =?utf-8?B?bGRMbitFZFkrZkZOajdJYmsxWStiZDZMKzQvaVdaRWwzc3BYVm4xYTlFQU9D?=
 =?utf-8?B?QmtzRFlPbElkVVVwQk5JMFJoMEdjQUlwaGNWV1BkbzFqTXR0bWwrVGZjL2VJ?=
 =?utf-8?B?aWdkZUFkK201UmtTWnpnTS9Zdy9sSFdFWlAvUVRON1ZDS01wTEQ5L2JyWkta?=
 =?utf-8?B?cUZ6aHJ2bzJMNlZPU2E5RGQxSlN5WUZnUkpyU2dJQXlXdS9ZVEI1Q21NbGJN?=
 =?utf-8?B?YkZVU3FSeFArVzhHUzNuMVhRZFk0Y1FUSDdzRk10c2pBUWR5WTl6TnhaZTlw?=
 =?utf-8?B?N1hCVHhTSEwwWm9MSzV0R0VtRExHZkRBVTR5UW9hZHFXOUp4QnJHakE4ZjNG?=
 =?utf-8?B?THNkeHAzRUl5U0RQTUFFeWsyN0tFYXN0ZmwwTlNJbXVHdjdkN1JEaHNiTVY4?=
 =?utf-8?B?VlZsNS9wMktra1VpVXBLNXl5QUo0N3g5bTBNSXVvTnlGbGxLbDdWOFhGaU14?=
 =?utf-8?B?RjhpWkNEdDdxaHZrRzVzc0ZzRlRsQzJPU0FjQ2JCbVpxd2ZoNk9VaUhDeWJm?=
 =?utf-8?B?SkZFbjFtSkxxM2RxeThLbDJqOHJvK3Z1SnpsR2s2VXAycFB1alJ6L05zdHhE?=
 =?utf-8?B?blRBM2xKTDRHYTI3YTNPeVVxdng1YS9PT0k1M1pzQnRTT1NORTB4WWd5WnR3?=
 =?utf-8?B?NDdnNmJTUFlWSTJENnFyUHR6Wm1zaEpoSW94dFR5MkhSSnJTZGlsVmRPZHNZ?=
 =?utf-8?B?OEtmbXcrUHQ3UjB1eE1ya2FMK0RtMkhpQ0dBcXBJcGptUzZWWGZiVjJVdDhJ?=
 =?utf-8?B?RDUvQk41Z3k3QTlwKzZqaFFTQzZZaTdPakV5K2Y5azRGcHhjYXhFRmpUOTdj?=
 =?utf-8?B?cEQ4Mk5KeS9CTG1zTEpITWZGWFJEbVJ5UExLdDRjeDJRK3MyTmlmcG1nM2VT?=
 =?utf-8?B?bkNaRVFBRG9ldkhid1hjeThhQ0Y2MXZUZmluSWI3VDYxVno4WDRxckYyYVR2?=
 =?utf-8?B?V1NoN2NiRDJaQnVxN1dlNzhZTmZNUC8xTmNRdHF5ZExyWGNPK3FqOTN6RnEr?=
 =?utf-8?B?ZENkQ2Jrc2N5SXNMcklxOFdnVGRWejRQT1JoSWJqR2xjVGl1UDVDVUMwTGc4?=
 =?utf-8?B?R0I2RDVEQU43N25zd1JyL1Nvamhhc3VESVErZ2JCR0RjNVBxQWl0cU9JUUto?=
 =?utf-8?B?Zmx6cVZVTW51eklsVElqeFFCVUloNzR4WlBnWW1iY1lmek85UjByYm0yRGc0?=
 =?utf-8?B?aC9rVEdxWU5QZTB6bUk0VGZBL1hSQk5OcWpxV1ZSNDROYWwzbjBlaGNFZkU0?=
 =?utf-8?B?eTVxZHRnMnBkak1YaEl1Y0oyTUp5emxDMjNyMkZsWThyU1pOT25aNzVVamw0?=
 =?utf-8?Q?DKwc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e9badd-1120-4253-cafc-08dbadd057f1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 05:24:14.6609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dVRAYvbrpUE2J8/rNslEL+GM6L8zZ5zSL6cvkkvzXbgy2X3Zxe2lZ86j+HF2gMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

Am 04.09.23 um 08:05 schrieb Ma Jun:
> [1] Remove the irq flags setting code since pci_alloc_irq_vectors()
> handles these flags.
> [2] Free the msi vectors in case of error.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 43 ++++++++++++++-----------
>   1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index fa6d0adcec20..17043a1e37a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -271,28 +271,28 @@ static void amdgpu_restore_msix(struct amdgpu_device *adev)
>   int amdgpu_irq_init(struct amdgpu_device *adev)
>   {
>   	int r = 0;

While at it please remove the assignment here.

Unless really necessary initializing local variables is rather frowned upon.

Apart from that Alex needs to take a look at this, I'm not that familiar 
with this code.

Christian.

> -	unsigned int irq;
> +	unsigned int irq, flags;
>   
>   	spin_lock_init(&adev->irq.lock);
>   
>   	/* Enable MSI if not disabled by module parameter */
>   	adev->irq.msi_enabled = false;
>   
> +	if (amdgpu_msi_ok(adev))
> +		flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> +	else
> +		flags = PCI_IRQ_LEGACY;
> +
> +	/* we only need one vector */
> +	r = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> +	if (r < 0) {
> +		dev_err(adev->dev, "Failed to alloc msi vectors\n");
> +		return r;
> +	}
> +
>   	if (amdgpu_msi_ok(adev)) {
> -		int nvec = pci_msix_vec_count(adev->pdev);
> -		unsigned int flags;
> -
> -		if (nvec <= 0)
> -			flags = PCI_IRQ_MSI;
> -		else
> -			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -
> -		/* we only need one vector */
> -		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> -		if (nvec > 0) {
> -			adev->irq.msi_enabled = true;
> -			dev_dbg(adev->dev, "using MSI/MSI-X.\n");
> -		}
> +		adev->irq.msi_enabled = true;
> +		dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>   	}
>   
>   	INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
> @@ -302,22 +302,29 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>   	/* Use vector 0 for MSI-X. */
>   	r = pci_irq_vector(adev->pdev, 0);
>   	if (r < 0)
> -		return r;
> +		goto free_vectors;
>   	irq = r;
>   
>   	/* PCI devices require shared interrupts. */
>   	r = request_irq(irq, amdgpu_irq_handler, IRQF_SHARED, adev_to_drm(adev)->driver->name,
>   			adev_to_drm(adev));
>   	if (r)
> -		return r;
> +		goto free_vectors;
> +
>   	adev->irq.installed = true;
>   	adev->irq.irq = irq;
>   	adev_to_drm(adev)->max_vblank_count = 0x00ffffff;
>   
>   	DRM_DEBUG("amdgpu: irq initialized.\n");
>   	return 0;
> -}
>   
> +free_vectors:
> +	if (adev->irq.msi_enabled)
> +		pci_free_irq_vectors(adev->pdev);
> +
> +	adev->irq.msi_enabled = false;
> +	return r;
> +}
>   
>   void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>   {

