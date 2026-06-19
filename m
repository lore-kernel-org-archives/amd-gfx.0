Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219E2CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1A410E085;
	Fri, 19 Jun 2026 13:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Qsgq3s2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBA610E085
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HK20+VWC7wWxdjfMDRFDMaq9vVwkQmJKI1ln9YDo/XqbyfLShkWo3VxF/dr1S6088YhLre8N2BNYPoRhxs2/NpTK4zMU91tmdX2CoUIrU3WLtCBldiQfvvRYXx7Y+IIm/Wq5RSCrazKVtgIT3ykeCeqBgZXXkSRHfLzDtXzdkydhBO0ToRP9OgvlvDTa2xOcc/NVespgJ0bH1N05XpIlPttD/KTnojs/hH2M28vM8WkBB2TXj7bubuyq+r0FARHpafxfLWixNisjVZOQE80/jOjloUZet3iHUj9syWsQnTNI5WQw/ePrBT84G/ktkUu/ubX1wJGtebiarWJ2f2I0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88eJkR9ZeI8ydsjMbeKq4XiTsfuLIIYdGCodwIQN2kM=;
 b=iYkEGjHoJoXaaFnnBzuc3Zv+wxLSSKE5ov0i77azHVHf/96DtGaQahgCbizAl9nPvdlEVghmP9jf312ucOfgXuz1bQl6qQu3CDIUPDw3zBcYVicTbVXmdhks70rV7A+xjELp9Kx+W/GLLk5beOR9ZYgfvs9Jx4AbZGsVUxj7Bbifmg7JkjCYv3sTxdJiYfeF+KTP+cBoAn5nhE/0hjj7d2/IQX4xhE9oaMeD+aGIY+aIvPyDmMnznmYWr7epS+adxQoutCM86qt7Wy135t+5XobWCeeaYLpu4vCRfyfVkKGUtndJrM/mZCoOaAPITb9MWOcuAp7DG+MevEspTJ+aXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88eJkR9ZeI8ydsjMbeKq4XiTsfuLIIYdGCodwIQN2kM=;
 b=5Qsgq3s2wqiXj7bULFauXK58sWk98P4E+/h7xaLN88WhNDPl0F2VteD3rvNT4RIxkxeysu+RyuEeRODZy2LMYXw3IuswuQWUkVdXjOQrNY5IQ8qwbA/4Wc6lnCTewjHWTmIkJlvk36np8wGqmsqbZ6wmUoz7PFKNlsD8YUFAxqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 13:20:17 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:20:17 +0000
Message-ID: <a123025c-c748-4f8d-8ddb-e19ceafc1e27@amd.com>
Date: Fri, 19 Jun 2026 18:50:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Guard reads in pcie state readout
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 candice.li@amd.com
References: <20260617093518.753118-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260617093518.753118-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0270.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 3334add1-73c2-4c1e-9ee8-08dece058125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: YuvTvY6T9cUt4OI4yxe4bBH4WypLWdo3xU6E0hEThEzatXzSCmv4h6IRFVJj5hqR4BNUbc/abvHKEeCgFAn7XfdQE7kaZOs6fG73dNtFWq0ig3FHvXU5HSA43/dvRtLoEaar6REVPhyT58IQ7L2Xv1ToPfVdgFRDlOIzu+9s+GDNSUXvFEDnlsIKP94uxIKwIIO6b0ztER4JYkUIbPXnCXE2zM+JXBHq5ig79x8rL0HLXy6G58EybiHM4CmIxegwWDRVCgRbbVlsL4PyrXvMIr8ddfXsaVSv9vTcLScgeTZW/Ni8/Tdvzim+U4uGncfL5EklEUbAqVHcU1pfQSIv879jhgeoWSp3nXT/TX8NbPiMYv9sU+/JGludMz+ZRI/GZ9zFlbHjcArqZZTtwlr1tMO65JM8W+OIxxVrEeQv1y96WPButwrpaJhVihQYszROOlxz/GGPYl8Ll4WGRv7uYUUtgWhBnCGOyeIQ2tKpTBBmABmFiGiIZMX+d4ga8ZQX7mh4pQgKhannu0jBjOaKH/eGJCqHgxKdEpIfbZH9etf9vVgq2uin+Kcj8vlOnIQZf+60RhrISE5r+RaNxa4nDN6YmZTLZuMUwQe+9yZg+xLwGiM1IJKZYAieJ1MiU+uYA+MBGA+06bTz3nONMejdeSKiUJO66gIeI7n5osNTLKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlnSVY2dUVpTzBHV3hPeDQzRW9oN1RCZWhDWFM4QjRyb2l3QW14SmdVdDZN?=
 =?utf-8?B?VU12MU0xb2JsR1NiM05scmZEelpOVjNvbXFTV3l4ZFJGRVVXM0xRUGdkUEw4?=
 =?utf-8?B?Q3I4VU1WVmRMdkcwSkF3NXM0d1ZWV2cvcmMxeXFVby9QWm5Mb1FieDBVQzhi?=
 =?utf-8?B?SU9ncVE5Nm5IZkIzY0hkMTZiNTNYUzk3cXBXMXdDSnIyb3JzOUU5dm9yY1pa?=
 =?utf-8?B?VVpSd1hZKzhRWE9ZWi9PclFvdTFQMzAyaXBDOXVzdm5WRnEvckYwK3o1SlNr?=
 =?utf-8?B?N3orMVVkRWlxRElSOVkzYU95NjNUTW9BUnBjcnpTSUE1R3o2NjFaYkxLOTYr?=
 =?utf-8?B?SlN6NlRFWWRNajlROHR6RnM0VmF4WE9FT0VGaE5UUDBENnl4cjJuS2FCNWc4?=
 =?utf-8?B?RFVoakxsNFFSVkxSbXlTSUJ0Q0xqSWNscGc4b1o2alVlb0RIc0JlRi9YeS91?=
 =?utf-8?B?WWZTK2tBdG9PSXh3eDhSMTYxY3Q2UFhlRDdCQ3dXVUJtaE44Q044a1JFdUlv?=
 =?utf-8?B?OHNqUERCd1o1Tlh2dWNLOVQ0N2hzVjVNMUJYQ3dtQUF2VkFETDZPdnoxSnhs?=
 =?utf-8?B?MnFqd0UxeVJ0d2VJalBEQUQyS2JicjJvVTFwQXZXRGxJVGtja1g0Mms3Mmxk?=
 =?utf-8?B?ei9PV25lVG8reXNsN25JK29WRDdMZjRSZzhkdXBFZ0hYa0htN3MreVNUNlRZ?=
 =?utf-8?B?dkZGcnc1OThtQWN6cEh5UkVlYWVtd0IxNTFpUW90b2JVUU1GRE0wVmJIUTBP?=
 =?utf-8?B?UlN2aE9obHBwazFkUUVTcVpsRVpKaXdmVlJuNWJOY3ZEQ3N4QmY4YWpDTTcr?=
 =?utf-8?B?aHRpK1NSTmd4aCtCYVNobGtNNFpxbmpCM0NVd1NaYVVmMGZ6eXlqc2JDUjlS?=
 =?utf-8?B?V1h0SmZwcFVuL1FUMFdQazFxK1M5NTRTQ1Y1U3ZIa2xxVVNZRTVjOS9BRmU1?=
 =?utf-8?B?NmlUSmNLS0lHNzQzcG0vS3BGZTlhcUIvVXBZQXdpZXVWSEVHazc3T1pNUGNY?=
 =?utf-8?B?R1h3aG14M2d2d3YzVllOMEZMVWx0d05EQ3k0cnNiYmZVUjJVMkNjUDdLSGt6?=
 =?utf-8?B?RnBWWHduUk14Tmc4dHNoSWFpQVQrYzZJdXE2a29JU0RkRXVBNEFHdFNGaGdL?=
 =?utf-8?B?SDFLaXFzelh6d3pVakowVDFHWDFsV2tiY1FnU2tHaHB3STBPSEk1ckUzcUEr?=
 =?utf-8?B?cGRpOXVjM2F2UW0zTW5FemVDZGR1dWEyaEorQXJ0a3M1QW8zdkhINGF4RGx2?=
 =?utf-8?B?b2I4dmZ2cFhWcitYeXBMTVZyTXlaNUxkSmEvQ1RBUldPbkZuakxqckNHZ3J5?=
 =?utf-8?B?UU41Rlh4QVk5aTJhQmxYY2w0TkpIUUhtREMyai8wUXYrRGJrZmRjZGZ2SWFw?=
 =?utf-8?B?eXBlbVlKYzhKVzI4eVlNd2xUWnZhcXdlb1lMTEhPVXhVYUlXbGhEbDJsYTgr?=
 =?utf-8?B?VEwwUVZDQlJqNWtwaDA2dDBWZEw2eEtwOTIzaGUxUE5xRTFmUDVzdHRjM0VE?=
 =?utf-8?B?Z3ZSR284UE8vSDN1RWpvV2VOaEg0N2ZzdkxKamFoNVRJaXQ3dG1zSURUazhs?=
 =?utf-8?B?Ty9EQys4UFdOejVVdUo0a204RU15bHcrc2QxRUVaZTVMRmw1MG5BbVQzZGs5?=
 =?utf-8?B?S3k3dzRHWHJ6U3pXdHltZTNUT2pYdWsyWTVnK0xmN0RnbWFXL0M2SDJJZVpn?=
 =?utf-8?B?TlVCL2VQcmR4dmRnTzgyNEs5Mi9iWjhBcHJGT29KSXZEZDNkWDJRUmRPSHEw?=
 =?utf-8?B?ajVNVjZCQzMzN01BY28vRlJvaUN6NGN4ejJBZmtoRTh3T3JncHQweWUyejJx?=
 =?utf-8?B?RW5mL0dvMEtvR2ZUckZqZDlzQVNqSStKMFoyVUc0THl5T0w5YnpraFZwRzBt?=
 =?utf-8?B?YllTZllSSzdzelRsa3VGdkV2Unh3cExLazZBL3N6S0NYbW9tZ0dwNkZIL0ov?=
 =?utf-8?B?Uk9KK0d6NFM5ZXo4L0pWTCtoM05lV1NjbXBLbmN5K3VGYW1WaitQNEo3Nm5p?=
 =?utf-8?B?NEVyWTdkd296QjgrYWVnMUliZUNkV1N5bldhejIvbS96YitvU25Ob2M2K0Js?=
 =?utf-8?B?bmhNVW5hRWJHb0UrZnJUZUdaL0R3K3M5ZmRYMFdRdEFYSGhXVERVTVA0RnRs?=
 =?utf-8?B?NU5QUE91M2txR2pSL0VTUklLK0NHVW1KTHN6MmUrRzVhdW9YeEoxS3pmMDB0?=
 =?utf-8?B?NWozM3N6aVMzanhmNUhQdDJWZzRMVG45SFlLT3VhUGJsVjlEZVFEeVF2VkZy?=
 =?utf-8?B?MFBGc1FwM25zRUsxS09WUmRwZjVqUnR0dW13SUdLQnIwZGFuVjdqNElQQ1JL?=
 =?utf-8?B?NTB1QmQ1TDdSSlh4S3QrSDhjV2NRdGh1ZGJjeW8zUTd4YS9JaElrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3334add1-73c2-4c1e-9ee8-08dece058125
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:20:17.1558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxoFq90gMtIalyMl87c3n55jUsPriMndlHJf4gjZYya7ZU3UjaFyfAAQgssYCS/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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

<ping>

On 17-Jun-26 3:05 PM, Lijo Lazar wrote:
> Internal US/DS switch may not be exposed in passthrough. Guard the
> upstream port reads to avoid a NULL dereference.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 59 +++++++++++++++-------
>   1 file changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 72ea37dbfea8..5f1389901504 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -589,6 +589,29 @@ static struct aqua_reg_list pcie_reg_addrs[] = {
>   	{ smreg_0x1A380088, 6, DW_ADDR_INCR },
>   };
>   
> +/*
> + * Return the GPU's internal US switch port, or NULL if it is not visible
> + * (e.g. passthrough) or the EP is parented under an unrelated bridge.
> + */
> +static struct pci_dev *aqua_vanjaram_get_us_pdev(struct amdgpu_device *adev)
> +{
> +	struct pci_dev *ds_pdev, *us_pdev;
> +
> +	ds_pdev = pci_upstream_bridge(adev->pdev);
> +	if (!ds_pdev || ds_pdev->vendor != PCI_VENDOR_ID_ATI ||
> +	    pci_pcie_type(ds_pdev) != PCI_EXP_TYPE_DOWNSTREAM)
> +		return NULL;
> +
> +	us_pdev = pci_upstream_bridge(ds_pdev);
> +	if (!us_pdev ||
> +	    (us_pdev->vendor != PCI_VENDOR_ID_ATI &&
> +	     us_pdev->vendor != PCI_VENDOR_ID_AMD) ||
> +	    pci_pcie_type(us_pdev) != PCI_EXP_TYPE_UPSTREAM)
> +		return NULL;
> +
> +	return us_pdev;
> +}
> +
>   static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>   					     void *buf, size_t max_size)
>   {
> @@ -596,7 +619,7 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>   	uint32_t start_addr, incrx, num_regs, szbuf;
>   	struct amdgpu_regs_pcie_v1_0 *pcie_regs;
>   	struct amdgpu_smn_reg_data *reg_data;
> -	struct pci_dev *us_pdev, *ds_pdev;
> +	struct pci_dev *us_pdev;
>   	int aer_cap, r, n;
>   
>   	if (!buf || !max_size)
> @@ -628,25 +651,27 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	ds_pdev = pci_upstream_bridge(adev->pdev);
> -	us_pdev = pci_upstream_bridge(ds_pdev);
> +	us_pdev = aqua_vanjaram_get_us_pdev(adev);
> +	if (us_pdev) {
> +		pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
> +					  &pcie_regs->device_status);
> +		pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
> +					  &pcie_regs->link_status);
> +
> +		aer_cap = pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
> +		if (aer_cap) {
> +			pci_read_config_dword(us_pdev,
> +					      aer_cap + PCI_ERR_COR_STATUS,
> +					      &pcie_regs->pcie_corr_err_status);
> +			pci_read_config_dword(us_pdev,
> +					      aer_cap + PCI_ERR_UNCOR_STATUS,
> +					      &pcie_regs->pcie_uncorr_err_status);
> +		}
>   
> -	pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
> -				  &pcie_regs->device_status);
> -	pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
> -				  &pcie_regs->link_status);
> -
> -	aer_cap = pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
> -	if (aer_cap) {
> -		pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_COR_STATUS,
> -				      &pcie_regs->pcie_corr_err_status);
> -		pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
> -				      &pcie_regs->pcie_uncorr_err_status);
> +		pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
> +				      &pcie_regs->sub_bus_number_latency);
>   	}
>   
> -	pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
> -			      &pcie_regs->sub_bus_number_latency);
> -
>   	pcie_reg_state->common_header.structure_size = szbuf;
>   	pcie_reg_state->common_header.format_revision = 1;
>   	pcie_reg_state->common_header.content_revision = 0;

