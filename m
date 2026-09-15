Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C0CC88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 05:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3C510F95F;
	Tue, 15 Sep 2026 05:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mV10d5Fq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AAB410F95F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 05:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSZHGbKUcv3jGyPLUHgVXwVTUNw/OcRtAMla7bWOBgYGkFxQFX9sIuvDCulPR4BbdYPY4WgPZmY4WnqrYMAqRoB9pv0AMn1aesVp8Fng4tWc750GW7FbhZdmAgdLVvv21ekJjTaW5T5XYlUlVFcWZ7UhnvzEt5skG03A4k7XYRsTO809tMztwWXG2Sgfz3m3BBt0lHaJKkVTMcs4NySuAhLX7pcDoU6yCUwTz4AsVUuyvO3NMVoWzVxJ8BHbDX2zw1eCikkDWiyWsPL6eUCZpVAwGLbFqilFY4CX+i0kCEYYmrG9UU2NU1ERspcVHM1QGYlzgtKxGIRzC5LfjRehZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwAzhHQcgTzG875/TJBE1hZnBxlHcFqY1aPc4w/c5zk=;
 b=dazsLcEFq+YDGyjZ0EoiU3N4fOR/H1HOLPKimrkFNTMDiwGdk8mS7Ec1SaXkR2+oFel4uel0ZET6bHLYz3IDnhJ+dYuou/jzcjp75Uz4TX5eNIj++YtPxww3I3JNEpJ6w8gjz6OAfn7bSDBW0ML57bOo0HpRa6g4oNGHLYfIYdA26bQOoOTQ+CS7D27OExSyM6CJVawwfMl1ZBpWqSPHNX1C7nB/cE28xdGI52N9P5phbsW21LjswOvl+am5n4yeaYHddFwmIpI5R2/Xtsc0inuwh7nE1P4kOcn1S4YyUdLJxRkOa+OYOD2HfCnuQROZc4BjNnfAqfZ9R90OMzjAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwAzhHQcgTzG875/TJBE1hZnBxlHcFqY1aPc4w/c5zk=;
 b=mV10d5FqjDhFPur33njdoizpX/ud96Vrt1zWoMIao/1iaoQESrEbeGQh3Q58a/QfMM/XFBv0g99BT1J+YgrapH93KXv3fLIZlY65/FrHlgj4wGAeLSF2eyNVBjASdTFup0kMQL2SAUSLxJDgmJ1pDln7a+13ycvncK2g96kJPng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Tue, 15 Sep
 2026 05:04:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 05:04:39 +0000
Message-ID: <04a53629-d720-40ad-91fd-0a7995572a29@amd.com>
Date: Tue, 15 Sep 2026 10:34:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd: Add dedicated helper for
 amdgpu_device_find_parent()
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260520154618.809699-1-mario.limonciello@amd.com>
 <20260520154618.809699-2-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260520154618.809699-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0068.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d77bd5c-c691-4994-1512-08df12e6d839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: A6Nq4ETjzjWGV5pmk+Eq9gomaEbLRSgGaZXoCw0Wc9ZjrrPnAiJhucqOHg+65f6512abkLofHdq3hhNKAO9q2RDHOVzjAF23PJ/rl4dOOuQqPqadwQ3dGIJj2avCT147Bzlk/8srKLsE8P371r6ri1j/VfMEexP3al3sYz2VLFN7mT0b9naIYVBnGW5xUCMo50A6F4Ed7D8SHMTdpZMgQXlAaBA5sd7RKHbOoTCD7H7I4Mv1ggdaFKaccMtbc6N4GBDEPwkQdgLjZtydUd448j1N+Fn2nx3kXTHiv4VdxAz5SyFqm5tb4XSCq7AKM/R4pGH7nKECznfKaKl8Bi4YKbS9nGb+VkXerzK5e+YVmG3yxUipPCecc3GPi4hX1w+7cvE1HXAwGJ0ck9gXbzCvGjSLXsiw2u/nDz+1vFFDKXK8xJDIDyiIukabd67XcDwBaDamUc7Io7d0spo6d2sHXdbZi5wVd5G+JWEm3mOIK7tUqEsXhVYCHZV7p1D9Nal4yqdT1U8hWdu1aJsxcArGyjmTgeKnO6OJalTc5GyCnksHfCZK8d/DFGfqUP6oTMnYmlCv6Rj6aDuniGolDnBPxO1v+J4NAahRScdEXNeBoKhZ/iOtnsLElLECeGVQ0knNJ3yzIvHgjZyvvhj8ji5zonx+5h6Ss0dj3hti0oumaek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1BMcm9NMmdYcnFOMnA5bnJjN2pTc2oyc3ByR0VleUhYM1NxQjlxMm9rWEsv?=
 =?utf-8?B?YXhVUEI0VWZHK0VSd0tSZ21SK2gxOHl5Z21oS2FFRU1KYnpHOFRpNTYvQ2Z1?=
 =?utf-8?B?RmZUSEx4SG8wZlBRbnRUOWlQK0F4cGc5UkxSTmswby9oME1wQnE4YmF5MC92?=
 =?utf-8?B?L3pWWUk4ekF5Wi9pVFpYWXlOS25MRy9EcGY3ME4zaWw2dzBmZkxSaG9IZlE0?=
 =?utf-8?B?UFNCSE5CbzdUbDY3M21SOHh4VVZUcTFpbmZFd3QyamxZZldUdmJzT1N0bEtF?=
 =?utf-8?B?bUtKQzkwWTBINWhJSHYxL2g2Rm5GcWErWFdiZ1NaZ1IyT0Q1aWxVbnY0dHZU?=
 =?utf-8?B?Y1JMRWk4SmxIalpsNlhVckVXYW1kd2lVS3c1NkZWUUZWa3BoczNKNkpwWGFL?=
 =?utf-8?B?L1pOV1pTU1F1azFzczJMdm96YW82bklxOTBwdTEwc3ZhRjhwYm1VaURCNzN4?=
 =?utf-8?B?ODhXSTRWeDJmY3lyWFRPKzIvRTNBOEZ5TW5KaW5TSUFKTWw1blEvUDYrOTA0?=
 =?utf-8?B?MlFMZUFOWDJHWmF0REhpbU1TeDZGaStsUUVXQTRqSW1ySzFTSE5aZUMvNzJl?=
 =?utf-8?B?Mi9WY0hYZWRBcWQ3cWxQTFE0OGRVbDJUMDZaamlqUDRnR3FHeGwxYUVUQ2tJ?=
 =?utf-8?B?ZFAzNlhOdmRyb0M3WVdJbWpNVVRRdXBPbW10WUVMOXczS1dZdVFtczV4a3dF?=
 =?utf-8?B?MFFFekp2T1ZnT2ZLMm05TXlwdktzUU0zK2c0TnRocEU4dkk4bDJqQWZRVk1L?=
 =?utf-8?B?ZVlCeXZrcm1mMlFLaGVIekd4TWo2bUlOWUk0dFBoMnF4dGVNdjVVa3hWQjBF?=
 =?utf-8?B?cG9FSmNHZFk0RGlSUVl3SFhObG5kYVllT0RqQVpzQktOSDlqb2RvZFVVRjN3?=
 =?utf-8?B?NjQxY3ZkQ1BTOWd4QmxPbXpCcy9uOExneEVqd0tsa0dCV0R5SXVFekRBNEVq?=
 =?utf-8?B?QTBsWVpxMFoxYkoyNUM2WktJUHBXNWptWllXeU1EaTB4VE1PYTVodzlWaTh6?=
 =?utf-8?B?cGlmS3praGQxQzZyLzljVUEvbUxLUExiK0xxMUJBMEltcmRIbVlHU0pTckpK?=
 =?utf-8?B?eVVkSWlaK1B0YkRMWURmc0dUaGszcEp5NWJEZHRHUzZKeHFnbExhWnVublB6?=
 =?utf-8?B?Mm0rZi90STREWU5taVZFeWRVQ1N2TFdpVTZuSldteFExZ0QvZDlQQ3dOV2ZF?=
 =?utf-8?B?Q295WVJsU1pnWWlteGMzYmR4dGNHSk9pUkNxZWZIM2ZVeTB0QjJER1c5eGR3?=
 =?utf-8?B?UEx3ODQ3MUlEdnk1SzkrdmJzR1ZzSVQxOHJiRVlJUFVTbDRBQmhGRXNRT0hs?=
 =?utf-8?B?NW1JeWZKbk8xSkNmYUdmT0d6SitMVURxc0IwZzN5d1ZHUjRSam1lTnFXZjYw?=
 =?utf-8?B?SVhpOWVyWDlkT2V3aW1oZHErL2lRMnJvL01ta0Y3YW5ONDFkbTh2dXFXTU44?=
 =?utf-8?B?UFhuSExlQTVxa0N2d0VOd2I4QTZsWkdOV2ZWbVI3Nm94Q1dIS2FEMGd6QWlL?=
 =?utf-8?B?cDkrd2tjQTh0VlJUejBYVjdjeGhNTGdrcVRCUWFsNzZ3OC9vbUNFbWJoU0Jq?=
 =?utf-8?B?N1BwNUxLcW10ZVhwWFlXQytDZ0UybU9zWTJhbnkvR3NOM3lCaVZpejJhR290?=
 =?utf-8?B?Z3RML0MrV0ZmTHZzWmg2SENLczBRRVRSbUNsTGszTDhYTkZlb0tPNnRFZDlV?=
 =?utf-8?B?T21CQm53R1Buemhtby83c0MyQ2E1ckU3Z2ovQVpsYndwWEZqZ2Z4YytUQzhz?=
 =?utf-8?B?RnBRUXlJSVlRZ1I5akpWMnY1SlFWNDNhZXJsc1A0Unk2VlV2Q2JsckZxbk1D?=
 =?utf-8?B?UEttNXM2RC9aQjZrZEVUSTlrdmhScWM4RW5sampFQUlCVURDSHoxUmJMM3Jh?=
 =?utf-8?B?Mkc4WXJXdHRzanM4R1Era202YVhud0JCWXJ4YmdKc2VnVzJ1ekM3SFM2OWtY?=
 =?utf-8?B?bTBOdkVWeGtneWZQVnovUE1TZk44U1BVc1d5QVRROEZhNmFSUDRGR0dzNHBP?=
 =?utf-8?B?TzVoL1UwMThENkVTNDJEa25wd1Z1c3FaYWtEU0JoOW5DRXN0cnphZzNKZnpF?=
 =?utf-8?B?cmdLallycmdCR0lZVjB3b0pxMTZMK2xUUFF6T1E0ZmozZ28vY1B2WHhoaWV5?=
 =?utf-8?B?TWVCTjNJSlBWMzh3NG5xamFIdFVpQ2ZqK2tFckpDWmNPNjZuMzRoamswYkEx?=
 =?utf-8?B?VHBtcHJ1d1VxVW9vZEwzd2FMbktsaDBpbW9FblJQM2l5MmFVTG9zYklLd1k1?=
 =?utf-8?B?TUZkNXpZNTR2Smh3eHp4dk5GRmp2Qkt2WTk3Wjc1Q3FONVY4M1FUOXMydWxL?=
 =?utf-8?Q?8op9AIDPZj7iGMiTb0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d77bd5c-c691-4994-1512-08df12e6d839
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 05:04:39.0347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkEs606l4LnAdL+7cnh36YBpuLoLsfViU6kRngDXLGfsRxC08fzbqVF5AKzoIQ01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
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



On 20-May-26 9:16 PM, Mario Limonciello wrote:
> There are a few cases that code walks up the topology to find the
> link partner of the integrated switch in a dGPU.  Split this out
> to a helper and call in all places.
> 
> This does have a functional change that amdgpu_device_gpu_bandwidth()
> doesn't cache the internal link but only the parent.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++++-----------
>   1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 073f632f295a3..b6a24faaf78dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1913,6 +1913,19 @@ static void amdgpu_uid_fini(struct amdgpu_device *adev)
>   	adev->uid_info = NULL;
>   }
>   
> +static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
> +{
> +	struct pci_dev *parent = adev->pdev;
> +
> +	/* skip upstream/downstream switches internal to dGPU */
> +	while ((parent = pci_upstream_bridge(parent))) {
> +		if (parent->vendor == PCI_VENDOR_ID_ATI)
> +			continue;
> +	}
> +
> +	return parent;
> +}
> +
>   /**
>    * amdgpu_device_ip_early_init - run early init for hardware IPs
>    *
> @@ -5913,8 +5926,6 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
>   					    enum pci_bus_speed *speed,
>   					    enum pcie_link_width *width)
>   {
> -	struct pci_dev *parent = adev->pdev;
> -
>   	if (!speed || !width)
>   		return;
>   
> @@ -5922,13 +5933,11 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
>   	*width = PCIE_LNK_WIDTH_UNKNOWN;
>   
>   	if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
> -		while ((parent = pci_upstream_bridge(parent))) {
> -			/* skip upstream/downstream switches internal to dGPU*/
> -			if (parent->vendor == PCI_VENDOR_ID_ATI)
> -				continue;
> +		struct pci_dev *parent = amdgpu_device_find_parent(adev);
> +
> +		if (parent) {
>   			*speed = pcie_get_speed_cap(parent);
>   			*width = pcie_get_width_cap(parent);
> -			break;
>   		}
>   	} else {
>   		/* use the current speeds rather than max if switching is not supported */
> @@ -5955,22 +5964,15 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>   	if (!speed || !width)
>   		return;
>   
> -	parent = pci_upstream_bridge(parent);
> -	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
> -		/* use the upstream/downstream switches internal to dGPU */
> +	/* use the device itself */
> +	*speed = pcie_get_speed_cap(adev->pdev);
> +	*width = pcie_get_width_cap(adev->pdev);
> +
> +	/* use the link outside the device */
> +	parent = amdgpu_device_find_parent(adev);

This is for GPU device's bandwidth and not the parent device. Suggest to 
cache both pdevs separately as link_dev (device which is connected to 
actual physical link) and link_partner (the other end of link) one-time 
during init. That will avoid confusion.

Thanks,
Lijo

> +	if (parent) {
>   		*speed = pcie_get_speed_cap(parent);
>   		*width = pcie_get_width_cap(parent);
> -		while ((parent = pci_upstream_bridge(parent))) {
> -			if (parent->vendor == PCI_VENDOR_ID_ATI) {
> -				/* use the upstream/downstream switches internal to dGPU */
> -				*speed = pcie_get_speed_cap(parent);
> -				*width = pcie_get_width_cap(parent);
> -			}
> -		}
> -	} else {
> -		/* use the device itself */
> -		*speed = pcie_get_speed_cap(adev->pdev);
> -		*width = pcie_get_width_cap(adev->pdev);
>   	}
>   }
>   

