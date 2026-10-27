Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3E606D708
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r3dmwl+K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7ACE10E00E;
	Tue, 27 Oct 2026 20:22:41 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360B510E00E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5PCbEginOgJpYe/gBAb1YAFYvdgV96cazms4ec6Cq5OosBlr3LfZjY/ic7YGT0TGdDNH64nsy6nx5MT+VjJzk0ugoI+xxMfCrftdPtNszJvwgMzgRcjSI0gK4fs8UJ4b52Hc9npxTuAP81HePFKxIQ5zKye4O+IlFyTymjJld+4zg9JCNh9rba0tmNNEOAluzHzznpApoJ97qyJ9kzs87FtEOLOstRvrWoocI6sOp+v54NHTI/r0IZy5y1sGrE7qmIG0EkeVq0fjrTq2BTLwHyEmL1qJrcMH+vlxzRJFC9RudWQiQ/t4C0zXrMJDhrn7otzSNQ7wVt/F05c6blFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49zE9qqbRo+YOFvYcdfNhXFEPEW7HSjHOz0frOABAAA=;
 b=lYUzIcMcj74A69FWrLoflwgUa5zaKOMzkMu9uKbfr2OWyxCzyxIrln3UVW3vW5I7w8Y6g/3ZPHjPiay2W1lycnXgLfX9zJL8rSM9m8B2MFWlgXcQ04FJo32Fb77WmGOuDENyCGLtpjN4mcCv87ktPRepN/JRu9lFtrhLT61zYt052J6h1NIw5MBQmJfh6Goi7sL/4Y3sXQdbr4wKpEXpbKcuuKGanehFeL0zbdocm3q7B7uX4aFtFSYXfc7ICUZ18zLuFBYm4cynhNb1l/s0yA1OFgO/EODOASJsqovPlsp+R5WjXJph+ggX+OBnyG/hjDsfkxG2l3uZGTXbNMTI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49zE9qqbRo+YOFvYcdfNhXFEPEW7HSjHOz0frOABAAA=;
 b=r3dmwl+KBCNvSmfWYZeFKEb9kHNw56TVJU01Ceo/KO7IsvI9tj6SEldnj+4s0ecTB2Fwcf8jWFGC5cPAv8mxLDhaXm8FSEkTiUpiBO1lFQ3Xmwo9+RCp91zC2r+B3c8tJLmNKb3ebnRrYd6wuxI7LCDL3Ui6+Eb3EsVR1Ungzrs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by FT1PR12MB863618.namprd12.prod.outlook.com
 (2603:10b6:170:e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:22:32 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:22:31 +0000
Message-ID: <ee1e254f-c322-4a75-be7d-a05a67af0e9a@amd.com>
Date: Tue, 27 Oct 2026 16:22:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-2-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027195913.1794477-2-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::11) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|FT1PR12MB863618:EE_
X-MS-Office365-Filtering-Correlation-Id: de717a45-c686-46a4-07e2-08df34680773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|261026121527099003|22082099003|18002099003|3023799007|56012099006|261022075727099003|4143699003|11063799006|10067099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: J03RrLg4EduDX4x4P16g6z3BalxaJhrlQSESnZRXhMzPTPmA/KhD/UOFKR5TJl32+vP/zusjIxAQA6iv6cKc3K8wqFOlHWlwgeq18QO+Opq0O3qoWFTqxxJGsBCvYnHrUVoO/HkN4XG6D07xxMyiWfCiS5TJJzxzn2+UBSq8wMpFa5y40ZRNshGd0hy8rUW3ArPXYnVXpjdV0+bwvBVEcsgapQJfI1gVR9/G/6Naz38sEPVMQYP0m2gAbLp0dSN9o0PEvi6zf6k/qFVxL9eq1GR/GYVjKmOOOWJExlXgNEtdjXVR0dRFTBwagrWv0yurqTuTwmbmyqR3buh2vMsCGagCzrUZTtCqmial4yTsJ8wr7uZ5LgawuZTXRExLvu19hLBj9TvnT8uyNgDbaG7/gZ0dI0Cs3tPtIMvxza67SU8gk1DvvEBZzR2ysSezXr6fMRMWHNI6saQSRX3qrW8cfzJF216VB3XCN2vJrnJgrF1yNdH2K2wHg0Z4Vm7NQdT2483VAavrJtvDbTyfMhMFIGfArfHY62uLqNdh1KXZPLG6y22o0NrEMFWu+3H5f8TBZnFo/wPWEQqX31sxfVcBW37hLxglOEGvElgo9Eo89OfDnIHqdplfOOesfF0P+ZxagS7DeM0NUxL6cUbhuV4DevEzlxUdNkwK56XT8eu46iQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(261026121527099003)(22082099003)(18002099003)(3023799007)(56012099006)(261022075727099003)(4143699003)(11063799006)(10067099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGN3K1QyNlhIMUZjbmhZOGpnMCs4RlBmN1NrZ2czQ01JUStsem5Ya1J6NThD?=
 =?utf-8?B?T245R0YyNTNKdC80VlJVcnBjYXFoNkpkM1ZDYjN3VmlmSFZLalFKZFNqZ2V1?=
 =?utf-8?B?RnhEYXI2ZCtjZmliM2xlOGFDSndZU1JXV21DLy9VRmZYemhLOWw5UWdyaGxI?=
 =?utf-8?B?MmxiWU5jMmZ1WkNjRUp2ZlR4eWFBT0RiYkgrT1RzV2VqQVhCUEdLOER1R3Ey?=
 =?utf-8?B?SzMvaXZaYitLVHhKR2hpU3dDbElXR3FLbHRmaTdBNE9BSHlybTJWRHJyQ2dt?=
 =?utf-8?B?MFJKRUNoNXI1K2ppRktNaFhjSlVFM1hQZWQrWlBwcldWeXRpbEYwUHQ5NDEz?=
 =?utf-8?B?STFYSXV4cVVtWXdKcjZkVW56ZFY2MWVRYjZqaGFZVnBBbkkwcklXUTk3NW82?=
 =?utf-8?B?QnN1WFpnVWU2ZVJsandmQXJGdG9LK2xpTlVubnFYVXhTd2g4L3ZJTE81NzhV?=
 =?utf-8?B?QVloaHc3UmxzNERPSFFNVXpVWUN4SDhtWlhmMkk0QjBmZkRpblJZMFltK0Jv?=
 =?utf-8?B?cHoydC9hV29KaWNQMVVIZlhPTGVDM2FIblhBSWZqRzhBeis0ZHc3MU5CbmVU?=
 =?utf-8?B?c0xJK002cTNpZGZUb09jVlVWZExnempYR2VnclZnMnpDSWVtLzQwQXVLcGI5?=
 =?utf-8?B?RWw5Zlp5cGNhV1dubGlVNHd1dmlSLzRBNzBHOVcwWmJhdnpWbmZOWEhJeURO?=
 =?utf-8?B?Y3NKSmtsUHM4dWxuSlErbTFZcWxZMTRpR01Va0dpSDdTdUZDVnpZZ0s1b0ZZ?=
 =?utf-8?B?MHRIL1JabjJNdkg2b1g3UmxMU2c1dTh4RzdIRFkwRVZCSlpqa2NsK21hdStR?=
 =?utf-8?B?SnluRUZnN0dadUxqTEdIT1RxTTV4bzlnL29CYlMwRVFjNThrdHIwelVaK1RF?=
 =?utf-8?B?TGVMQmFvTUJxaXZocGNtVkx1Rkdrd2xwam9XdG9LdzFkMG5pcDVzMjJHODlj?=
 =?utf-8?B?eEduSWMwVmZGMDRzNnBqbmJVc3FudlZVYnV0bGtOaHhXMWx3RjJqOWVFQXhl?=
 =?utf-8?B?OFhybXMwMGlLb3lDREc3NzRKVEdNR1pmTi9OakE0SFFiSkZSLytJeXJUeFZI?=
 =?utf-8?B?YzBBVm5JL0pZeFZqWDRYSllUc0xZTWhtSTlxK3RKckdiM1N2Q1Znb2s3UU9F?=
 =?utf-8?B?R3lqQmF5Y3Jvc1JFQUFTZGdpOE1FUEdVVVdTUFVBdVFlWVg3c21KS3FtM3Z4?=
 =?utf-8?B?VnZscFpsYVdxV3VGN2Y5M2F2VDV3ZS9BUWJzU2lUbWQ2RzlOQnhPS1cyaDQ0?=
 =?utf-8?B?NEFHM3c3ZC91NUtOTXlMZjJIVWpYTWdJUmtwVXY2dHg2QjFBSnZuT2p3T0w5?=
 =?utf-8?B?M0syWGpRYW5FdXo5eDFqajR6MVBlay8raWVobW5oZjc2QUtYTDFPRXlrdVVi?=
 =?utf-8?B?NHZaUGtuVFpZdW5oQXVTL2d0emhMNlVJNUFBMCtFc2VaY1JRemxpWVEwaGhT?=
 =?utf-8?B?NXhHV08rdTdWeWN2QWJDdndKVlR6cEpOcWtpRnNPbXd2RkJrSE16NUVja205?=
 =?utf-8?B?NmVrVnlpeUR5RHpDSTZKdkdkMVZkY3Q4ZWJDK3BwM2NMTWpVQzd6dG1DT0Fv?=
 =?utf-8?B?K2hEcWlJdzkvYU9uSlYzekFhNkZ1YnpTSVN4bHcwQy8rUXlrMDE0YjYvK1FW?=
 =?utf-8?B?SEpJVDQwUTJkNy8xMk1hNllHckh1bFBFZGgwMUhYYnhZMENxUWhGRE0vakdB?=
 =?utf-8?B?SWRKaklYdEhQaFVoM0ZVWHJlN0ozVHNoWFFFYm9pU3R3eWNPMGtYM1RUa1Zm?=
 =?utf-8?B?TkVKTXQwYVBwSEJPTnRpaDRMclh3Tk1TZmM0WUE5VGZKMWl0aEpVdEdIMmRL?=
 =?utf-8?B?NFZqclhmekxvNFl1SmM2UnNwbHNKWTc2OS9MK3FOWlQwU2tzekpKQkRQQnFE?=
 =?utf-8?B?a2ZxYUduMjR6cklJZGRscXhadTBiZUFjV3pZdzBoL2Fhb0xqRWdyUG1CbThC?=
 =?utf-8?B?ODdIb3RLK0pZTWppZVJrdTJiY2Nibm5HM2h4ZEJyKytRcTk1TUtBdGUvQ1hi?=
 =?utf-8?B?akNGVU50bTIvYTdUQVhWWTVKTU9nVmgwWUt3dkpoRFFVbDhBd1FDZ3hGSjNJ?=
 =?utf-8?B?djZiQ1RCUjAwT1RCTUZKQXd3MWhTcDNZZnZVWkZJT2I1aHZmcU51YUh3cVhE?=
 =?utf-8?B?SVlBM0FCU2RkZXZ0R2dIeE5oQWdhT1dBMFQydnlNdG0yTGVwTWplZGZlaTVt?=
 =?utf-8?B?Tnpyc0t6bmZoU2JQRjNIMDhjQTFWakpRaDdCRDdWZGpjb1Zkb21uN2VpNlVm?=
 =?utf-8?B?MW9HL1k3aCtxSzZaNldnditubERYakpROSs0WHBFcDRGdWtrb1AyOHVWQkdJ?=
 =?utf-8?B?Mm5hdzFWaUtjSmM2VmtocU5NZVltQzBHOXIrWTY1Qk5CVHIxRDJndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de717a45-c686-46a4-07e2-08df34680773
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:22:31.8317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNy7OFGyRhN87D5WT5dgMpyl7gs7Ad/AlCRWybmt6a+wsVyrv7HALwAvV/PDjWCxd5nCAnJUw4mUpC4rC6fNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB863618
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 15:54, Mukul Joshi wrote:
> Add the infrastructure for UALink loopback mode, where a single GPU
> plays both the exporter and the importer role under two fixed
> accelerator IDs:
>
> - Add struct amdgpu_ualink_loopback to track the loopback state, along
>    with the fixed exporter and importer accel IDs.
>
> - Replace ualink_accel_id() with ualink_exp_accel_id() and
>    ualink_imp_accel_id(), which return the exporter and importer accel
>    ID in loopback mode.
>
> - Add amdgpu_ualink_loopback_init(), which allocates the ordered
>    workqueue used to emulate exporter->importer messages, and destroy
>    it in amdgpu_ualink_object_fini().
>
> Loopback is not enabled yet, and outside loopback both helpers return
> ppod.accel_id, so there is no functional change.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1-v2:
> - Drop the change in find_peer_adev() as its not needed (Lijo).
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 99 +++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h | 29 +++++++
>   2 files changed, 109 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index ca6432610f71..2cd6dc71ab9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -89,8 +89,34 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/*
> + * amdgpu_ualink_loopback_init - set up UALink loopback mode
> + *
> + * Called once loopback mode has been detected. Allocates the ordered
> + * workqueue used to emulate exporter->importer interrupts in SW.
> + */
> +static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
> +{
> +	adev->ualink.loopback.wq =
> +		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
> +	if (!adev->ualink.loopback.wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>   {
> +	/* Tear down the loopback self-interrupt workqueue allocated in
> +	 * amdgpu_ualink_loopback_init(). destroy_workqueue() drains any
> +	 * pending self-interrupt work first.
> +	 */
> +	if (adev->ualink.loopback.wq) {
> +		destroy_workqueue(adev->ualink.loopback.wq);
> +		adev->ualink.loopback.wq = NULL;
> +		adev->ualink.loopback.enabled = false;
> +	}
> +
>   	if (!adev->ualink.info)
>   		return;
>   
> @@ -472,6 +498,14 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
>   		__amdgpu_ualink_activate_vpod_locked(adev);
>   	}
>   
> +	if (adev->ualink.loopback.enabled) {
> +		r = amdgpu_ualink_loopback_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to set up UALink loopback: %d\n", r);
> +			goto error;
> +		}
> +	}
> +
>   	r = amdgpu_ualink_drm_client_create(adev);
>   	if (r) {
>   		dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
> @@ -1028,6 +1062,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
>   	return NULL;
>   }
>   
> +/*
> + * Physical accelerator roles.
> + *
> + * Outside loopback a GPU owns a single accelerator, so both helpers return its
> + * ppod.accel_id and the exporter/importer distinction collapses. In loopback
> + * the one physical GPU plays both roles: the exporter owns the MP nHT and
> + * receives all HW traffic, while the importer is the (virtual) HW sender for
> + * the importer -> exporter path.
> + */
> +static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
> +{
> +	if (adev->ualink.loopback.enabled)
> +		return adev->ualink.loopback.exporter_accel_id;
> +
> +	return adev->ualink.info->ppod.accel_id;
> +}
> +
> +static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
> +{
> +	if (adev->ualink.loopback.enabled)
> +		return adev->ualink.loopback.importer_accel_id;
> +
> +	return adev->ualink.info->ppod.accel_id;
> +}
> +
>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>   					 u32 accel_id)
>   {
> @@ -4487,11 +4546,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
>   			     AMDGPU_UALINK_ACCEL_MAX);
>   }
>   
> -static inline u32 ualink_accel_id(struct amdgpu_device *adev)
> -{
> -	return adev->ualink.info->ppod.accel_id;
> -}
> -
>   static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
>   {
>   	return adev->ualink.info->vpod.addr_mode;
> @@ -4837,7 +4891,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   	u64 timeout = msecs_to_jiffies(2000);
> -	u32 dst_accel_id = ualink_accel_id(adev);
> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>   	struct amdgpu_bo *bos[2];
>   	u32 n_bos;
>   	struct dma_fence *fence;
> @@ -4956,7 +5010,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>   static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 dst_accel_id = ualink_accel_id(adev);
> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>   	u64 timeout = msecs_to_jiffies(2000);
>   	struct amdgpu_bo *bos[2];
>   	u32 n_bos;
> @@ -5241,7 +5295,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   
> -	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
> +	dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>   	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>   				      &remote->rptr_cpu_addr);
>   	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
> @@ -5288,7 +5342,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	}
>   
>   	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
> -		ualink_accel_id(adev), ualink_addr_mode(adev), status);
> +		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>   
>   	/* Alloc metadata structure for all GPUs */
>   	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
> @@ -5361,12 +5415,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	}
>   
>   	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
> -		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_accel_id(adev);
> +		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
>   
>   	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
>   		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>   
> -		if (accel_id == ualink_accel_id(adev))
> +		if (accel_id == ualink_exp_accel_id(adev))
>   			continue;
>   
>   		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
> @@ -5392,7 +5446,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   						     ualink_tlb_wptr_offset(adev, accel_id);
>   
>   		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
> -			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
> +			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
>   		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>   			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>   		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
> @@ -5806,7 +5860,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   				      u64 *wb_npa, u32 type)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 accel_id = ualink_accel_id(adev);
> +	/* The GPUID encoded in the write-back NPA address is the routing target
> +	 * the remote writes the rptr back to, i.e. THIS GPU. It must be the
> +	 * physically-owned accel_id: outside loopback that is our own accel_id,
> +	 * and in loopback it is the exporter (the only id the single GPU owns
> +	 * and can receive on). The importer is only a logical source id for the
> +	 * forward path and must never appear as an NPA GPUID.
> +	 */
> +	u32 accel_id = ualink_exp_accel_id(adev);
>   	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>   	uintptr_t wb;
>   	u64 npa;
> @@ -5981,19 +6042,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   						   &peer->shootdown, &tlb_wptr);
>   	if (r) {
>   		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
> -			ualink_accel_id(adev), remote_accel_id, r);
> +			ualink_exp_accel_id(adev), remote_accel_id, r);
>   		return r;
>   	}
>   
>   	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
>   		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
> -			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
> +			ualink_exp_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
>   		return 0;
>   	}
>   
>   	dev_dbg(adev->dev,
>   		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
> -		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
> +		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>   		remote_accel_id, int_wptr, tlb_wptr);
>   
>   	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
> @@ -6164,7 +6225,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *interrupt;
>   	struct amdgpu_ualink_ring *shootdown;
> -	u32 src_accel_id = ualink_accel_id(adev);
> +	u32 src_accel_id = ualink_exp_accel_id(adev);

This is changed to ualink_imp_accel_id in patch 5. I think we should use 
the correct function here, where it's introduced.


>   	u32 dst_accel_id;
>   	u64 npa, flags;
>   	int r = 0;
> @@ -6287,7 +6348,7 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>   {
>   	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 src_accel_id = ualink_accel_id(adev);
> +	u32 src_accel_id = ualink_exp_accel_id(adev);

This is changed to ualink_imp_accel_id in patch 5. I think we should use 
the correct function here, where it's introduced.

Regards,
   Felix


>   	u32 dst_accel_id;
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *ring;
> @@ -6374,7 +6435,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>   {
> -	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
> +	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_exp_accel_id(adev),
>   		ualink_addr_mode(adev));
>   
>   	adev->ualink.msg_ctl->send_halt(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> index 85c9a9634a4b..0b1e8dd38666 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> @@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
>   #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN		0x1
>   #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN		0x2
>   
> +/* UALink loopback support.
> + *
> + * In loopback mode a single GPU loops UALink requests back to itself for
> + * manufacturing testing. The GPU exposes two fixed accelerator IDs: it acts
> + * as the exporter on one and the importer on the other. Loopback is enabled
> + * with the amdgpu.ualink_loopback module parameter.
> + */
> +/* Fixed accelerator IDs used by a loopback GPU. */
> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID		1
> +#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID		0
> +
>   enum amdgpu_ualink_conn_state {
>   	AMDGPU_UALINK_CONN_NOT_READY			= 0,
>   	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
> @@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
>   	int (*send_halt)(struct amdgpu_device *adev);
>   };
>   
> +/* UALink loopback mode state.
> + *
> + * When @enabled is true this single GPU acts as both exporter
> + * (@exporter_accel_id) and importer (@importer_accel_id). There is no second
> + * physical GPU, so exporter->importer messages cannot be delivered by the
> + * (single) MP nHT and are instead emulated in SW by feeding them back into
> + * our own IRQ handler via @wq.
> + */
> +struct amdgpu_ualink_loopback {
> +	bool enabled;
> +	u32 exporter_accel_id;
> +	u32 importer_accel_id;
> +	struct workqueue_struct *wq;
> +};
> +
>   struct amdgpu_ualink_mgr {
>   	u64 npa_size;
>   	u32 psp_if_ver;
> @@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
>   	/* For remote interrupt and shootdown */
>   	struct amdgpu_ualink_remote *remote;
>   
> +	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
> +	struct amdgpu_ualink_loopback loopback;
> +
>   	/* handle irq from ualink client of remote GPUs */
>   	struct amdgpu_irq_src irq;
>   
