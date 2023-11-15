Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6D1C07548
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 11:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639FB10E500;
	Wed, 15 Nov 2023 11:55:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6EB10E500
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 11:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRIm/tk8ez0dyaMfVOPX5B8poIWkUevP05B1Gh7qUOIPiIgtFDipkmq1gQHHJ9vtkog8KWkhUr9zjyerdvCZRu3Z1us5P8BJjsnl057/18g2ARKzXLbAXP40fmbkeKOqDhA6LyEbibMGCLHXX+T6JIyF8rRIFLO0YNQH++/mEIZiJ7SAzGO667qubweN6k6s4qaDYn3l3FT5IO4+irEODXSZnqAB/JxXYv5hLkUv9MHELHUrTfylW8jR225XNHiDZOxuO21Al0uZ+GtDdTxhpTZn5lKRoHoFJuYYUjsKO1vx3HRsqt8srfSymZNoaIR4v4I+EsaBaHe3ijINtj64dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/tG9G4pmOBFl2GeOdZZGaXyAddTdVycYAtzqSUOaS4=;
 b=F3tK4bXwNUq2oJEK7zovxtTAP65bmzn5u9gtdAhdh3nF71fmQknfYj9cL+N8JEpiG2MiDFGkSezX4eAhBRyyknPzxVlSRXVkIWouf9BGxn+k5hkTn6nxVfZQle7JBPiX9S/POFIdUbEx4KDrH+jwEIOBKp08XRcDsB0UjalApRRjxeUL2g67s2LKxTzOSlZYXxvneUUTPj1QSdfDVJALvkhP2xOWX5yXmwU0ULqUYs5SgksGNKkrM72b3fMwlRT6tuLKcykdSGryLfypqoiYcj5xaAs507AEIYKC/QLRqlqAUuupYaC75CRo7PpLA2Eu7dTZhDPZjtZrcIH91QIDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/tG9G4pmOBFl2GeOdZZGaXyAddTdVycYAtzqSUOaS4=;
 b=2+lXmZpfdW+zhujLXOHxIELrxhjYWFAcaKT56rPO9t6JFWaWjRlotJj9iI+w1jWRtFMNQw4TBZzx0xMFewNvDVfuX8Pbdp+K3F6FUWeDIy3lzTDDGKNtLlzkOHBxrYeXyb0SviYsiOEGu7ju4hck/wFkfmyqMnqEnqDYkcR9xJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 11:55:30 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510%4]) with mapi id 15.20.6977.033; Wed, 15 Nov 2023
 11:55:29 +0000
Message-ID: <e9e867ad-8f9e-797e-935d-d6f9c5ad5ab8@amd.com>
Date: Wed, 15 Nov 2023 17:25:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] drm/amd: Use the first non-dGPU PCI device for BW
 limits
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231110223452.13439-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231110223452.13439-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: f42e19ac-f5d0-4a20-dccc-08dbe5d1c33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ywK2W12Z0erRyREV8JBjfWULJnbgy1zBwhhFJIrrO5s6UMfqZucufXhFgyjwQ+3R4aQeOFeHk+Ztze5ZimDbLMu1H2jeHntScTdhipwiSzp8+Zf0rTwnI+ZZP2LHlBru47dtU2EEoR9jNV+03t0SHjAa9ab9b4EHge5RFBDQcsthqjVGswy15yaWqy3QJK7Y8kcvhkeHv8escoNrSqX+1cYPoRa5OemAWjRAeekf4wqatU4H2z2Epvkeb5bcfACOqquLqPbLucL6O9JopHtDquCHhUm/0hHhXkzZRlqkLvrCqd97PwwiW1Jbr8tepvWZbaHR659pYTflNw4TCakFWM0UOxn++Z7UQFzzS+8XdNuodNX1cxjJOCh7QfOvlvqtN2kSQzJwl2Qk5KMGOtEKlnc6u9NUwIwpzMSNm3+Gq8bGozJ72HIi80z+1AMbxA8ERtfPEnIimUPTJQwQ0oDpe7j/94mcG37OfFY1j7MKW086XAwYPz1akr8yGj0/I7UOjwDgU3PLVQ17FDTSq9UXzeZ9yaesaJuZl6rNFNDFpydiL0klFqBn8PqIWBiFsVwdogYklFFMQo1RhNY4m7CvAcchVYrBfW0ISve7UndzH/S7Ic0+o8zg9lB8Lb54k8m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(26005)(6486002)(966005)(478600001)(6666004)(31696002)(53546011)(2616005)(6506007)(6512007)(38100700002)(31686004)(86362001)(66556008)(66946007)(66476007)(316002)(8936002)(8676002)(5660300002)(2906002)(36756003)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNFSHlpMVFUYVQ0VEdEK1lmb3lOalVrRzFGSkJwSmdPNm1DT0txTDFsdzFP?=
 =?utf-8?B?NDdrT2N4YmhpRlNRcmFjZWFkUWdsWTlzUGJMUXVlQk1YeTZaMkhqMnRtejIz?=
 =?utf-8?B?OWpsaWo3UDZJbThoZ2YwUmdIRUt4ZU9MOU94TXhOc1hqOEFEWWw3QXROaHJZ?=
 =?utf-8?B?dTdjYkkvYUdMcXBqa0NhOFdWSHpOeGZ1LzB6MjBmdGVxTldTYXFMVzR1VHdr?=
 =?utf-8?B?THdCdThseTE3UVZyczBpK1hYY1lpdExMWGRET0V3Ly9YeDQxSzZkZ3hUdktx?=
 =?utf-8?B?SlNUUVpuOWc0TzJGY0FOSGJmeENJWW54NjB1dHJzUU1zc1lRYUd1RUJ2ajBU?=
 =?utf-8?B?UWNsTVBSRnV4bm9lMmVBVU9YZUU4VDFFbmtUNUx1VWVKdjdveEhIVVhKWjhQ?=
 =?utf-8?B?R25OMHkvWmV0SWFwaW9yTFlKRkM4M3FhQVZkd1Q2T0U2OEpPSk94UmY5MWRO?=
 =?utf-8?B?T2crSDRscEZpZUlHa0xkYUh0MW9uekFHeUdBajk0dSsvY1lRNHdlYXY4WDdt?=
 =?utf-8?B?U254YzBmVWdyNjdqOCtxQ0tGMk1iZndWRXpGTzlodFVXMEc3eWlpVHR0UjhB?=
 =?utf-8?B?Z0FjalRySWduS3VkMGVRaHJhVG5paEVXcUxab2U3MXR3N21TcTRkaDVWbzZ1?=
 =?utf-8?B?S3lITTF3UjJ2YitmSy8xRGhNbGpkM213bjc3U2dkS2RoZ3ludXR0RDBnaFpp?=
 =?utf-8?B?L1Z1bW56dTZCQlhXVUkwUmlBWklYNVAzQytxVUZWbVIxRGcxOTJVRER2YUIy?=
 =?utf-8?B?bFh1NlFnTjF3VUJEeEJtU3h5YlpvelVSMmhEcTc3VVAwRE9MMjBPZEFTMHpW?=
 =?utf-8?B?ejVmQ3FCMTJqVkZ1ZElPKzBuOWYvSmNYSnNFUFlKcWJJaHlWK0N1Ui9CMDdR?=
 =?utf-8?B?UHFWRkZwdGFjQnU5c0tSRVlET0V3UTlYaUhPYUR1OVhXL1dQVDZxcE1CRW1i?=
 =?utf-8?B?bUh0dUNHY1p2TkVzSXNzQzQrOWJpSi9ySVRRdk44SWw2TmRsQWJSTDFCL3lK?=
 =?utf-8?B?OE92VUVBcnRHaFppY29YdzFObE0vK0RoTFlmVTFVSlZPdDNjbCtQeGZ5WndM?=
 =?utf-8?B?M1hLUXI0QW9hcmlJazZObmRPcG5RU1RlNGFlWnlEUEZvQlFScDlCaXBhNWNp?=
 =?utf-8?B?LzBiV0NiWFlCbURsRlFUSzRTVkh5VkJzWG41cHRYL0hNcW5SZXhxS25nckNw?=
 =?utf-8?B?Q1Y5eEhDYmQwOS92MjF4V2k3UGREaEczL3FHM0hvMURKTjZKV1hucjBoNzJO?=
 =?utf-8?B?RWZraGV0cmpPTnpWSlhwa21UVUVpOG80ZXRheEJoMWFLUmZMT2RDdWdXZVR3?=
 =?utf-8?B?a1FqZDdibmRLaDdDSXJHR2VGL3NiNlpYSWhRYmVuMDdVNEFMMFVtMm1RbFRG?=
 =?utf-8?B?NUpuZ2FmQm8xRzFFYXJTOXhia2g3eTJuU3F6QlFRRG8xL25RTXB0WVo2cUdI?=
 =?utf-8?B?MWF2aVFXS0kwajZuWnlmTDRzdjNMNC9yV0tISWRPa1pRZU9VWERUR05HcEtU?=
 =?utf-8?B?OEhlM0xzMGFVd2NwRnJpZE1OKzVBcDNyaGkwTmRMNGRWQ01PQW1XVlFuemFP?=
 =?utf-8?B?L0FOTGhLVUtLcnVPQlJZSUV5Nys3MHlIRGFMMVp4NmRzZWtzcXNhcVlRcXRW?=
 =?utf-8?B?OVFvZ3EyRTNDVldwdnZDZzZmUWE5UlM4dXA5Q1kyK2ZpbW5wQTJNQlc5eDl6?=
 =?utf-8?B?RFYzQitZajl1TCtGUDROZXY4TDBPSk1RT1RFWnNLYlNqQ1F1WlR3UXo2OXh6?=
 =?utf-8?B?aW9hRll4eXZLcWFBNm0zcFRrTG53Y0U1cmtYZ0dDUm5XcDU4K0pqeTMvMm9K?=
 =?utf-8?B?enNYMnVjam5oQXJGZDVwekU1VmdTRWgzUDNnVklicE82ZStYaWdzc3F3OGlN?=
 =?utf-8?B?b0VqNmw1cHFFZzZzeHAwa0JTUTFLWElsdVFGUkg0QVpwdUhYd2EzY1hSMDl5?=
 =?utf-8?B?Y2VYS2dlSlFhbjVMV1pVUWVkM3o5RFZDZmt4clMvbC9KM0JOanU1R2tqRVhY?=
 =?utf-8?B?QjJURUxmRXhQdlJkWEYzT3BvT3p5ZHpaWmxwTnFBRkI5TFFSclNaRGRCYTRa?=
 =?utf-8?B?WFA1emo0QkNoclFaQVloT0JnTEhSVFAxdGZ5MHFkSVRuNWJEcVp1bE9YN015?=
 =?utf-8?Q?QTB2T/43e9vXquoIOlUfmMV2o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42e19ac-f5d0-4a20-dccc-08dbe5d1c33b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 11:55:29.3461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dchC66UEMKPkYOEHGIXeMeW7fWFKvumT3Tf8vAbIEwEK538gEilrvdYIfmKZrLpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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



On 11/11/2023 4:04 AM, Mario Limonciello wrote:
> When bandwidth limits are looked up using pcie_bandwidth_available()
> virtual links such as USB4 are analyzed which might not represent the
> real speed. Furthermore devices may change speeds autonomously which
> may introduce conditional variation to the results reported in the
> status registers.
> 
> Instead look at the capabilities of first PCI device outside of
> dGPU to decide upper limits that the dGPU will work at.
> 
> For eGPU this effectively means that it will use the speed of the link
> partner.  As the new semenatics of this are unique to AMD dGPUs, create
> a new local symbol instead of changing pcie_bandwidth_available().

The last line may be removed. As discussed in the thread with Mike, 
looking at link partner's capabilities is the right thing to do 
regardless of the issue. pcie_bandwidth_available() api doesn't need to 
be blamed :)

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925#note_2145860
> Link: https://www.usb.org/document-library/usb4r-specification-v20
>        USB4 V2 with Errata and ECN through June 2023
>        Section 11.2.1
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1fc73bb4ec73..683ea2284827 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5721,6 +5721,39 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_device_partner_bandwidth - find the bandwidth of appropriate partner
> + *
> + * @adev: amdgpu_device pointer
> + * @speed: pointer to the speed of the link
> + * @width: pointer to the width of the link
> + *
> + * Evaluate the hierarchy to find the speed and bandwidth capabilities of the
> + * first physical partner to an AMD dGPU.
> + * This will exclude any virtual switches and links.
> + */
> +static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
> +					    enum pci_bus_speed *speed,
> +					    enum pcie_link_width *width)
> +{
> +	struct pci_dev *parent = adev->pdev;
> +
> +	if (!speed || !width)
> +		return;
> +
> +	*speed = PCI_SPEED_UNKNOWN;
> +	*width = PCIE_LNK_WIDTH_UNKNOWN;
> +
> +	while ((parent = pci_upstream_bridge(parent))) {
> +		/* skip upstream/downstream switches internal to dGPU*/
> +		if (parent->vendor == PCI_VENDOR_ID_ATI)
> +			continue;
> +		*speed = pcie_get_speed_cap(parent);
> +		*width = pcie_get_width_cap(parent);
> +		break;
> +	}
> +}
> +
>   /**
>    * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
>    *
> @@ -5754,8 +5787,8 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
>   	if (adev->pm.pcie_gen_mask && adev->pm.pcie_mlw_mask)
>   		return;
>   
> -	pcie_bandwidth_available(adev->pdev, NULL,
> -				 &platform_speed_cap, &platform_link_width);
> +	amdgpu_device_partner_bandwidth(adev, &platform_speed_cap,
> +					&platform_link_width);
>   
>   	if (adev->pm.pcie_gen_mask == 0) {
>   		/* asic caps */
