Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64773C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 11:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD6A6056B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 11:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CD6A6056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 790A26E17F;
	Wed,  1 Sep 2021 11:04:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459E96E17F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 11:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eshkxfSSjFOsrgQWjPtpe6odiDGpUm7x7JBNFfP8eDxvucHSgvbulcTI1epW+PYR1Ep2nlvc1308ZzC8lPdlNc5fwZ/RuLbt+eYH/SGsjrKSIPem+IBLuRgStBL5X/2rz6hG/1JmREa9AWOnOBccXL1vcs5jChj+4juug5tATw9oG/jRbhYtS/Q8ql/NxKLPT0F62hvI++HK7X3mFgkRPq6Rq5TYENszPugyOlbG9KwDbHmJJ4xnD/460Dfey+eFDyF1UjKIH1hnst0Jg7SKfaGQcxCah/gUZbgLlj4gwLD9hJZp8NiS3bDSt9yHkQREMX+brMZ/GjB8eEJSYXgWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aS/xjTMMOpBvi/Ag3sMkmp4t1hPMRfFIx92T5ITnND4=;
 b=k3EN3bZ5neSq6mnkSVINpH38PiHnvbckBon7vyTNdpbbJGCPrxTAKHYPC+RWNEdbl2K/ywwqTBGsKahw/dXP1mqyNBEJvyEXBAzxXtVyHant9a/JvZ0+cr/GA+vA811d1H4qclGJwo3egYcKDP+gXMkKWuAEYweeQmTyr3HGTcUuy0YXSJf2ghKKKPoVwYsT77VP74kbugDXrDXDgPKAjPLqv9jXuAV2/DMaCLRX1CbXpNM/TvrMHcysTMi1kplRU+1Lbd2+u13EqjRpM7q095yQ3za0Joo8UIKJfVgXp8DOJDZnZmDS0EgOU48TnbZMQSkbVU1Hm0ouZxfpJN2/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS/xjTMMOpBvi/Ag3sMkmp4t1hPMRfFIx92T5ITnND4=;
 b=3FyPDFBeSKNwQ3RZu8SMOeFZhYj9TEdAVsS91gO3ZX72Brs2MYLEqAdj9YI62RC10OItd77MgFO7jBvlfL5+xLLdcBQcJj29OmWbxbkEuWdN9wqUBn5wIfkYr/aiFpim56IOV+fj49bIuJp8/PDodKloLBvdO3N4dRJTH+O1o0Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 11:04:54 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Wed, 1 Sep 2021
 11:04:54 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210831215632.195506-1-Felix.Kuehling@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <239a99fd-835f-cbbc-152f-afae6861bf60@amd.com>
Date: Wed, 1 Sep 2021 16:34:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210831215632.195506-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::16) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0011.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 11:04:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef3118cb-ac98-4725-131c-08d96d385393
X-MS-TrafficTypeDiagnostic: BL1PR12MB5127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5127E690A10BC09E8A0ADB9997CD9@BL1PR12MB5127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ep311VwEPTqVQ4NGibsSpDIgS1ei/sRPUxmzee2D7iXXV9sdq/cgEk5t+pVgTaNw1FvDUx165spz9iVUp7j+0WeH/OHV3yOcyymyx/ANAf2oi2KOuMwc9UkQG65tzWCPiieJEh+iSpAQTvPvkgTGDKdgNROn5z+hhFLsMCH2voiSQnTJwdTVY3Mk568HE4qBYqe9w7U+VH2//wGEG0ZLh3+fJBKf2Jrb2f2k0H2JBTqzyhOF0Js1Z6W+IMV8HGcG63ig87N6snl13B0bVx2EhHwc8sXAaRgoV8eE4us44Rskcu6+b/vnYDyFsENX7Sfpz5gbVFUC0UyamSLXItV45KyB8y/tUkolYSHfa8/LS+RxKvfiqIo67LWE0VgcQlCO1NU1TDi/hYuq/75AzpnYnCRjidlbI6082TRrmwuWX41x4KYl4R1LhHoekL0Y7abu5eOIlUVrYwV67q5qBswOFwFMLby9/Bt5hqJdoalVH8pl/itMe8PbW65sYjcuAIYsfIH9fz4Rwnghihr2Gd/klt2ICV0rZu6NNozg7DZXFTBjMQn0MPNg5Z2rOOox0XsLzaSv8yny/ilqaFjw3PXwS7p3v+X+lK7B4s09VCxH3IEbEb7QKYcXcC/VUwX+hoc1G9ib5NLXNqlLaxo66/fssJEG5CD0a+BFugr7Rn9KYk6cxjbfVJz06MCx9cmEWHQMJGQ5DrI9T7l0nIbqQqDEY8VsaJqcki1yd8ZKC2QZavU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(5660300002)(31686004)(38100700002)(8676002)(36756003)(2906002)(66476007)(66556008)(8936002)(478600001)(6486002)(66946007)(956004)(26005)(86362001)(31696002)(53546011)(83380400001)(2616005)(16576012)(6666004)(316002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xVSTU2RitsUUZWZVYrZ3pMenBScTM4YVR3T3hQdTJtWGNlZG1ldGw3UW9K?=
 =?utf-8?B?WThidFZtK2FLSmpjY1FaOFhzdUVzM0hOWGs0Z2VxL045ditGYUdJcWYyZDgv?=
 =?utf-8?B?M0VqTGxBa2lVSUk0Z2lMZTlmeFJYN3J1RzlyS3JKNzNiRm0rVXFiSjlwT25M?=
 =?utf-8?B?QkpSTWJjSVJkOHpNZDFrV3Y0ckZ5WGVqQVdhZ2N0YTJzTVdnRGJPZ0cxOGFh?=
 =?utf-8?B?bWlzUzVLeThoVFRqZDlETEl2SHFUME5DTnFkS0hjWm9Wb1NrcGhqVUlCeFBK?=
 =?utf-8?B?b0U2YThyOFhXMnpJWEpoTE9MSW5UdEE3RW9XZGJWUCt5YllvTnl0bXN4VHRh?=
 =?utf-8?B?anp4N25adDkxc2dEaXp1ZFFLOXdWK0ZsZUVIdHB3SmQ3YVh6SUFJakxoM0xs?=
 =?utf-8?B?bndBZWxnRXRlL0ZPd01abTgwMXpRbC9GTnJ6REVPTVc5cG1jZFJ5cDhGWlpO?=
 =?utf-8?B?NC9WRkVKekVCTkVLWmdHNXJ4STZja3IvSWRHeDhydmxyYUhORnF3R3czenNy?=
 =?utf-8?B?ekg5eXJUeFVRdmZVMlk4UGZHYUlHM2xkSnY0czh4THM3a2tuTmduaXRkUTV1?=
 =?utf-8?B?ZUcyY245MnVGc1k0dzd5NUtKTU9WQWtadXh6QVlUR1ZJVDFDNndsR1d1UDJD?=
 =?utf-8?B?ekgvUFErMVV2Vkw5Q3hMWjJlT1ZaL1p1R0ZHZWJ5Z0REVlBjS3prMitNUzZt?=
 =?utf-8?B?aU5YT2R4cklmbE5SbzZ4VHEwTkp3NllUVG01eTlFL0VUVElSMjJmYjJ1blY0?=
 =?utf-8?B?Kys3bDU0RGVWcDJnOUNFZjRRazZ4elN5ckYrZ09PTWxBMW9KdWFsZXYwcThE?=
 =?utf-8?B?dGtHSGQ3YzJmQU9ETWRjNWFjaVV3b1dxd2F3NkVncWtwNCtIdldLbitscUp6?=
 =?utf-8?B?WHJWSWJGMnFtbndSNk9FNFZXRXh5eGgwUjR6Q3ZDWkt2aEltbXIwNE0wa01P?=
 =?utf-8?B?MUhsQjdUQlRJcVdVeXNmUFdvVDBGMkdQdUdReXIzYzhtSWtLRmRpSE8ybm51?=
 =?utf-8?B?K0RkY1JGMGtrM3o5eGZSUHV0eG9LcUpIa3BqT1lxb0ZVeUhwa1lRQzRUSlZE?=
 =?utf-8?B?endSdXlEMjlsZVA5Szh0NmVkUVVnRjFlS0NKNVFocHM2bVlKSGNYTVF0Zzd0?=
 =?utf-8?B?Ym5vR2Yyai9xMlA5c0dJM2dhMUY4K0gwT1dUb2svaVo0N3I1czlNeXhlWGI5?=
 =?utf-8?B?NWcrbmFlK2pwSmN1SStnbVFhYk5scUZkOWg4ejJMUm5CNmRjWExWekl1Risv?=
 =?utf-8?B?NlhpNFFveWNtYW5KYUx1UXh6NWM4ZkFGaGErdVZuNllGcncxWW5SeXY4TlJq?=
 =?utf-8?B?eDhhQ0JjYUI4WjJLNmFVL0xlQ0ZTTVA0aERqa0svTmZpL3FLbjhINTY0eWNK?=
 =?utf-8?B?bWdqbnpHU0FMZGxhUGkvQlpGUkc1bEQvVURGcWNVN0JVa3d2ZGovZi96RUNO?=
 =?utf-8?B?dEVvcE5zak5zOTc3bEp6aHMvOUpBbHFhaUR3RzdqMXpkKy9ObDZGSFNWQXJB?=
 =?utf-8?B?MHhpZDhtSjNZUE9yZ0pMQW4rK3pteVZOdGliQzFpa28zRWdYMU0rZkxzRWh5?=
 =?utf-8?B?elMwaHIrNDJsVGsxc1NXU09QaDNidFQzRS9TTGEwU3grOXc1OEhZaElmNlE4?=
 =?utf-8?B?TDhSc3RtTXRxbk1FRE5OMTV4SStDR0l3YmtTQ3hwOVF4OVdOUE9DQmpFdmxs?=
 =?utf-8?B?UUlzMU5mWDQ2bmlmRkZRaGxtRjQrNFNDMWJrZ29DZUkyY3ZwWHNtbWJZRUVU?=
 =?utf-8?Q?BO2l+UouBNqIuy8r7ln+PEpia7/5dfshQS8RfIA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3118cb-ac98-4725-131c-08d96d385393
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 11:04:53.9649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8q6uLYljdltRVCSa7S7SsQpinNSQXM+3i4l9XkXwsujYOLAWXDXEKsMc2y87ndv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5127
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



On 9/1/2021 3:26 AM, Felix Kuehling wrote:
> On some GPUs the PCIe atomic requirement for KFD depends on the MEC
> firmware version. Add a firmware version check for this. The minimum
> firmware version that works without atomics can be updated in the
> device_info structure for each GPU type.
> 
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 16a57b70cc1a..655ee5733229 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>   	struct kfd_dev *kfd;
>   	const struct kfd_device_info *device_info;
>   	const struct kfd2kgd_calls *f2g;
> +	uint32_t fw_version;
>   
>   	if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void *) * 2)
>   		|| asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
> @@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>   	 * supported.
>   	 */
>   	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kgd);

Should the check be grouped inside amdgpu_amdkfd_have_atomics_support?

This flag is used for setting some link properties. If there is HW 
support but comes with incompatible firmware, should the link be still 
marked as atomic?

Thanks,
Lijo

> -	if (device_info->needs_pci_atomics &&
> -	    !kfd->pci_atomic_requested) {
> +	fw_version = amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1);
> +	if (!kfd->pci_atomic_requested &&
> +	    device_info->needs_pci_atomics &&
> +	    (!device_info->no_atomic_fw_version ||
> +	      amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1) <
> +			device_info->no_atomic_fw_version)) {
>   		dev_info(kfd_device,
>   			 "skipped device %x:%x, PCI rejects atomics\n",
>   			 pdev->vendor, pdev->device);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ab83b0de6b22..6d8f9bb2d905 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -207,6 +207,7 @@ struct kfd_device_info {
>   	bool supports_cwsr;
>   	bool needs_iommu_device;
>   	bool needs_pci_atomics;
> +	uint32_t no_atomic_fw_version;
>   	unsigned int num_sdma_engines;
>   	unsigned int num_xgmi_sdma_engines;
>   	unsigned int num_sdma_queues_per_engine;
> 
