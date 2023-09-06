Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28592EB8FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 11:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F0310E5E1;
	Wed,  6 Sep 2023 11:22:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E56D10E5E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 11:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEtF48zz138IRSy0lgmqf1O4+01xCpuEQ7/ZIB7sAFDaQ5SSWDLkcAzBJKCEbMlxmwHnoz2Agp6fR7mMKLZBISYd0avC0cSITnFAuvLjbzhxzNdZuEa2c6hHeJCXAIlkctYX+S8wDcz/lHLaNDy5vlvRavXdxJQggkwkRMuvKWomP+OL0oj9kMOi8jVUcOw5IQEerR2RakRPFRCsts29FSm/miK+HbQAPzrwZvxCIKMO4s3Hvcs8Czo82ff31bpEtZN8rGEWIyU1VuQHees/oo0ELmEZu+CkkeGhi/B/SIzeSQheLv3F2+vBkvngaxeO5FtZBFLGaNJ10fbSxoPaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odSE1YatQ2WyLBEHLZQ38i7TmJjmfSOnhpb0MfGFv58=;
 b=gtQUBjeN5PnUYw3fUdxBM0yr4IQEfFKFM8Koaz+u3aMRx+IY5VDRS5/JUBLEu9MZYV7ZLGT3S5sV6xJwLUbBIfi6TGucmjUwM/Zhun2/luS1SVCSlmW01DBDTupbfYs0NBW/tHln6lSYKfvrToX/6iQDYa8LAX/9lAsiPywKoLETp+wJs0IUBP9PraJ99e4xwu9JoWOt5JGhfYvLDqJSAPqZEMnAtuId799D3uKvB2MMNuzC1pDw6sOuHgA1fCauYoSMCbeR0YL7oaVvqg5rCP6f9QymnOpEN4brt/uRuTt9IIS9MRQAsdqFtxCJx8/iXBr24PFq3jzwdDI0kA2DbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odSE1YatQ2WyLBEHLZQ38i7TmJjmfSOnhpb0MfGFv58=;
 b=D/XDJ3zNo9M9kJgRSGIN+H5mJFbdw/tdJpE96Ojb4B4F2AkNd2HR4lAtYk4DC7GisLk2vYBWp7etFqTC08UYvXc8MiZVPgT1wSnsZuLytLBvZLbtz7kSwbwrSXkj/1ZJmOibNTZ+4SeJZ74HYIN6cvdKfUmAdazeITU1xmFu21o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Wed, 6 Sep
 2023 11:22:44 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 11:22:44 +0000
Message-ID: <476e4c97-e0a9-8e56-57a4-411be1620da7@amd.com>
Date: Wed, 6 Sep 2023 19:22:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] drm/amd: Fix the flag setting code for interrupt
 request
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20230906065532.3340082-1-Jun.Ma2@amd.com>
 <9c792b2e-5c2d-840c-e14c-b225880a0d65@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <9c792b2e-5c2d-840c-e14c-b225880a0d65@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d8ddb7-3653-41c8-e579-08dbaecb977a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Um19fs/r9FG4K9y0Lq/o9IFp4caKkuWE70z+jHd5Yso8fA0LhN58LgdbBwVMnq9xX4c25co+NaqcC+wF5s80pPRv5GAW9VClG+CZEhjoqQycZzDqbu0KYJG6qu5WC7m0Uhbk91xHxDUxryV0CmjQ+Gh2ICx7iF4dgyMxw/4dsP98K5+qLXo0EqBx3DDJM8GiBe4rnvHk5H4/PVlVdClbvdUvpea1mVQiH7NOi2cgmOWPkcOaX1U0H21hStRbK4UNfe5E9mL/w8hK6Msj5OUpuIf344Hl+FJK+3FIxJfLSwZiKoGXR/X/4P1+lJJe2cigLHlw3Cf5fulc5+Ve5XLur80u1jkfTQ7BhJheewtzdgf2s1JMNBMv/Phw4eYTjatk9/s6GJv6B7bMxupZ3vYIZHCEyxuR0rPm80/80k7QkDlTqtPzOJbRrjbqw1h8vfn98OgadbIUuONQGyYVg3vTRA01Mq5wfAMPQIQOZMr6U7kdoJYmVjuq92UnJjAXiZMA3DNNIF+vZs1hTrzlzEYp1/QH/QUQCutCGUa3ZftPFCJseQa+La7XRZbJdKp20+Z7l0J2pAZEoEFQsSCzkSdcrgSzPcWQ0W5tCIR17sSNgGVAnXyLdQXYIvJrDzQtYp13w1pu1n7XcmTyj5cyUAxXiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(1800799009)(186009)(451199024)(2616005)(110136005)(6666004)(66556008)(66946007)(38100700002)(26005)(478600001)(66476007)(6512007)(316002)(6506007)(2906002)(8936002)(8676002)(53546011)(6636002)(4326008)(36756003)(31696002)(5660300002)(83380400001)(41300700001)(66574015)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJ5ZnFVUVJYWDNwZTZjQ0kzUy8zR1QvbjNYVnBLVFlQMEM5WGdMOVNEUGFw?=
 =?utf-8?B?M1ZPbnd4Tmw4NElCWFllU1QvRjRYRlpBbXRiNUFTM3ltTlZwVEcxYm10Ykp3?=
 =?utf-8?B?Uk8vYjJ2SGhqb3NGS2g2WW54WWtNSEpLK0YyNDRuWEpUeHYxV3hXcE81YSsw?=
 =?utf-8?B?RENpbjhTMmh5S0o4M0lvSjYxdW9wWmQwM2dHV2w5Um4rZDNoVEQyQVJ3anFF?=
 =?utf-8?B?blZtaFVHQUJqbnZjUkhKV1hTNDRMSHlyWmpobG1oZ2ZrRVY4ejhLSTFOWW9W?=
 =?utf-8?B?RTFseVNnTWFVT1Z2VlFuRjB0S1N5N214clZsRkdFSTdzNTd6ZEZmVDJPbXU3?=
 =?utf-8?B?V2Q2ZUY0SVAxbDQ1MGtTZEU1d1lxTXZUemJpNSsxeFMyUmZFNG9CSUxxS0o4?=
 =?utf-8?B?cTRXRFpGYmY4dW5ENk96N1oxSFdUTlNWTGZzVXZVUEt4ZHUyeXRzRWFCODVQ?=
 =?utf-8?B?SitLSVZUV08xZkd1Qk9EVVh0L2xteVJQWjBFdjFGb2x0RHFXeTJQcEl3Y054?=
 =?utf-8?B?LzRUMzd3bWhxWWdaT1ZaMzlSeDByOE9hcHZJMGNoMjdLQ0sxS3FhNXkyNFRl?=
 =?utf-8?B?Nm4yRHJrOHBBU3JSamF4ZHRnK0lkd3I5V05tSzVmaEcyRlpoWHE0bUxwN2Qy?=
 =?utf-8?B?MFkzYnMwajNuK0V0SlYvR2xqZGVENTgrc1ZWdHlNNXJzcDU2UDhxYW1Nelli?=
 =?utf-8?B?RldJWm15ZUU2RUVpTVc0enpuaUdzTHFjbmNrcmc1WTlXRGhYdU5rcDZKcGFM?=
 =?utf-8?B?NERGNlZ3ZXZWWHFRd3VEalVsZm1FYS9DeVMzN3BuTmlXcjA5K011bXJ4c0xa?=
 =?utf-8?B?WU1pdUEzVlBGcTBTRndISnVIYXFmSmdkTWRKRFlJa0ZPNEZmZWhMZCsvL2hT?=
 =?utf-8?B?bHBMbXJXVmh1SVFIN2F6Z2ZzYldneXpXUWhTU2lwT1RwK1dPY3h2Uno1MFcr?=
 =?utf-8?B?OFlwWlVIK0ZVdWxya2szNGdJQUZJK2pNTXZnR09RSFdlT0x1aVpGeng4NUt1?=
 =?utf-8?B?U3p3QzErZjRZdjU1UE00THBKZUN1VWt3a0tZaUZyNnJ1WElHUWFOL25Kandp?=
 =?utf-8?B?NWFaWUVKZnRIeWdJempCZ0tjenZSMU10ZnlVNlN3SlU3MXV4aHdBRlYydXVT?=
 =?utf-8?B?bmdWRE1iVE5xT1ZWOWhVWU1jb08wbTIrb3lhcjVLQmVJUUtyL2JPcDRUdHU5?=
 =?utf-8?B?MmRVR3hhSDZhd0VXZExXQ29ramc3RTVPMDY1RWRsL054OUFpelhCUko5TzJW?=
 =?utf-8?B?SWpjdVVpSmY5OTFUZEZ2V0xidWFPZjQ4V21QYm5UUHAxbXEvdWRYWVBGcmZZ?=
 =?utf-8?B?STZrK1hYT2Q0cm9qTXRuMkJFQXJqTXJZNzdnZC9XU0ZNcHUzSzJZTTdydzN5?=
 =?utf-8?B?a2U2UmJLSFIyOHNwTDcwRVhlUTQrR0FzOXBYM0VYd1JYWUp3SE5NL1YyYlhv?=
 =?utf-8?B?Q2NCRGg3VUhUMGxZVzNXVS9oZVA1RHdBdm1hVXZhUUE3RDM4R2FmR2MrbERN?=
 =?utf-8?B?ZUNPWW5yUUcvV1pTSFlUMHpsVFNJNTZYOXAxZGZpN1c0aTRHK0tPYU9IVDhE?=
 =?utf-8?B?QW5TVXZuTkJFc0dPOGpRWWVteCtvY2M3ek9xQWExcTIvNkxMLzhCSUFuRnBJ?=
 =?utf-8?B?V0FiSjNjSzBwcVJodzB2c2c5VUZyWC9FZlJ1ZWxuM2VVOVlXTC9JRkk5UUww?=
 =?utf-8?B?YStTZTNmaVBQYnVhNyt3MnBabGVzQ2p1VUltNyt3NGdTaGIxTTkza2dhdTFF?=
 =?utf-8?B?ZHI0anlIYVpROTBhbmljd0U1cmlGSUEweGF5aXFmQU1HTUNOWFZyQ3BqUXNp?=
 =?utf-8?B?Y2xuSGF6NUg4WG4vTHoxYW9rem9SdHBNK2xyeGwzdG1xNlBXUHlBUnd4RkEw?=
 =?utf-8?B?K0gwU2xNWGpxVnZEYS80QnRMYVJUTEN0dXZoOXdab0pqczJ5RnRoQ0tIWEdw?=
 =?utf-8?B?cWFZZHRVSW5MNVJZS0dOK3NFcDc5UFpHeWw0LzVHOXZMZ0ErV0FiQUpEZWtK?=
 =?utf-8?B?Nm0wN0JQSUc0L1Z0YVh5RHlHMFFSdlFxTitaVlgzTmUybElsUGpkM2ZMZ1pP?=
 =?utf-8?B?V0hFQmk3L05BaU14eHpHNEVPZ1ZhZjN6SzgyNUI5MVhJTWhIenQ5UU45VnlO?=
 =?utf-8?Q?vptbfZbqoQsJJZHGCTm01xW6f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d8ddb7-3653-41c8-e579-08dbaecb977a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:22:44.7250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGFWYSHnRZ8OWm2MSsWriJ1n4nS6oNewPCAN6bLhXgsVd0liXM8NP02e5pl4PwFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
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



On 9/6/2023 3:23 PM, Christian König wrote:
> Am 06.09.23 um 08:55 schrieb Ma Jun:
>> [1] Remove the irq flags setting code since pci_alloc_irq_vectors()
>> handles these flags.
>> [2] Free the msi vectors in case of error.
>>
>> v2:
>> - Remove local variable initializing code (Christian)
>> - Use PCI_IRQ_ALL_TYPES (Alex)
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 45 ++++++++++++++-----------
>>   1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index fa6d0adcec20..64c245015e17 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -270,29 +270,29 @@ static void amdgpu_restore_msix(struct amdgpu_device *adev)
>>    */
>>   int amdgpu_irq_init(struct amdgpu_device *adev)
>>   {
>> -	int r = 0;
>> -	unsigned int irq;
>> +	int r;
>> +	unsigned int irq, flags;
> 
> It's also good style to define variables like "r" and "i" last. Some 
> upstream maintainers even require reverse xmas tree style defines (e.g. 
> longest first, shortest last).
> 
> With that changed the patch is Acked-by: Christian König 
> <christian.koenig@amd.com>
> 

Thanks, I will update it when push.

Regards,
Ma Jun
> Regards,
> Christian.
> 
>>   
>>   	spin_lock_init(&adev->irq.lock);
>>   
>>   	/* Enable MSI if not disabled by module parameter */
>>   	adev->irq.msi_enabled = false;
>>   
>> +	if (!amdgpu_msi_ok(adev))
>> +		flags = PCI_IRQ_LEGACY;
>> +	else
>> +		flags = PCI_IRQ_ALL_TYPES;
>> +
>> +	/* we only need one vector */
>> +	r = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>> +	if (r < 0) {
>> +		dev_err(adev->dev, "Failed to alloc msi vectors\n");
>> +		return r;
>> +	}
>> +
>>   	if (amdgpu_msi_ok(adev)) {
>> -		int nvec = pci_msix_vec_count(adev->pdev);
>> -		unsigned int flags;
>> -
>> -		if (nvec <= 0)
>> -			flags = PCI_IRQ_MSI;
>> -		else
>> -			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
>> -
>> -		/* we only need one vector */
>> -		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>> -		if (nvec > 0) {
>> -			adev->irq.msi_enabled = true;
>> -			dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>> -		}
>> +		adev->irq.msi_enabled = true;
>> +		dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>>   	}
>>   
>>   	INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
>> @@ -302,22 +302,29 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>>   	/* Use vector 0 for MSI-X. */
>>   	r = pci_irq_vector(adev->pdev, 0);
>>   	if (r < 0)
>> -		return r;
>> +		goto free_vectors;
>>   	irq = r;
>>   
>>   	/* PCI devices require shared interrupts. */
>>   	r = request_irq(irq, amdgpu_irq_handler, IRQF_SHARED, adev_to_drm(adev)->driver->name,
>>   			adev_to_drm(adev));
>>   	if (r)
>> -		return r;
>> +		goto free_vectors;
>> +
>>   	adev->irq.installed = true;
>>   	adev->irq.irq = irq;
>>   	adev_to_drm(adev)->max_vblank_count = 0x00ffffff;
>>   
>>   	DRM_DEBUG("amdgpu: irq initialized.\n");
>>   	return 0;
>> -}
>>   
>> +free_vectors:
>> +	if (adev->irq.msi_enabled)
>> +		pci_free_irq_vectors(adev->pdev);
>> +
>> +	adev->irq.msi_enabled = false;
>> +	return r;
>> +}
>>   
>>   void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>>   {
> 
