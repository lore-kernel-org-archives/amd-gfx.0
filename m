Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B555C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 22:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B3160F56
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 22:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7B3160F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662F689F5F;
	Tue, 31 Aug 2021 22:22:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C541089F5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 22:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAniSysnIg6VDk4OwQOo8XLjJE9Cr/gjcCgR6CWCyTerTe7LMX7KmoIkAghhHXqgEO609VUZfuSbqMtDeTNxmLOYusaBQ4nHTRsifA/bunv7/EjKPaBz5dqpKHcZlemTxGR6WPMuDDhTGVgv/4cK/VpLGRlBOVlluzKNaELCsI6NPxwjxUN6rbmWmrMmXrucagdN7cKS+gPTA94gLTki7kgv96BF25M/AWhxu+0jbiXhNS3hwwKNcLnjD2vSuqPWwEVUr+Yw2lELouGsLCfcgZPg+OcwpPJIwcF1WFnjplYVwFZ64kZHanNFOKdW/YnH4EzCjMhRjuFWLBHOqd1hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PYEMQiLjBF0IctIODRKkU/KGXBXjVxhAHOvkU9NzLE=;
 b=TKlUfmjvgVxhC2it3Epg5ak6fHPjvUcYo5Hw7RUxjI/PcRTyN6unkLqspyGxTeD9gX3Xw9m8o5hQ9FAe7QVvNsXosfNQRMtHwmwQobYJeJaVHBUzMQy5z47nl+aAioTmkHsaf2Z5xZDDlSgz7eRouf7a7GgnG7YEUqRBi5K413LK0MS4rLcUmZ8xSdartUP6EUHjewrlzpguIGvFRM26K9fIF84j4VZ2L5uS96eMjK9OcYuXTlvQ7pi4JC18xSjPzwYe4syZisdiufCR9nRmJstjcyV73ITrQQnytFWoecx+6X7gnhyk4AFs7LrE837viV6ZzaMoWoDpXj3AeXJIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PYEMQiLjBF0IctIODRKkU/KGXBXjVxhAHOvkU9NzLE=;
 b=ozY1zHsT2ZhaixzIbKWp/x6TqfSjGwdsp3sGome11lztjxbbFKZ+eG3yZ6fdwMDaC0n/Xt0m7dqSyAtp7GFqw0rFzIlm+XjuRL8O8PqX9PldE805u/dkCxuO39jAJUXM43B2qVxjjhoRaqorPNOk/I2mIDY7eVhICEQ89xAzLzk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Tue, 31 Aug
 2021 22:22:20 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 22:22:20 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
To: "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210831215632.195506-1-Felix.Kuehling@amd.com>
 <A98C3522-21DE-4872-8FA5-512D65D1A1B9@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <88cb1c84-6930-a9a5-d645-44b8ec4f70b8@amd.com>
Date: Tue, 31 Aug 2021 18:22:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <A98C3522-21DE-4872-8FA5-512D65D1A1B9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Tue, 31 Aug 2021 22:22:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2282dfe3-856d-4336-e6dc-08d96ccdcc7d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51952011548DA44635D466CB92CC9@BN9PR12MB5195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pU9IJEmnB6vAad740sDL4XXS+2kOR6adbMCvguGcQaO7KBGfbS2YFU6VN1hukMwdNuwWbJV9DOmJTJwIUTgWEd7Dx+F5wjFyCKZDBqYfbuhONr2G5Uk0YvFN7o0i0HACdvsvjtu1Be4vJtrQj1Pe1uTI3qu9yUHnY2Owj7UR1fCDgD/wyT131wb6cHSL6EZEke3hoR2DZjgPTptgkD+CCmGcU3Bmd8M4f49yc8mrGh0c7pziilvoonQgFQKJ7anei7zB4Ik6J19XxspHML6JhdUhtOMU61MJ/61G9QeALHMHZGo8haJJ5j/uWWDn4wgDA33D3GblWyU4tsbwmutGZasbsQnkVEN7LEeESXMNS+YG6AiccPDD29cT7+/Mn870LBdz17K2ZWZ/Mfc5EB76NKwGfa1kDfJLNl0Nmyi1oeCnyg//E7aIT7CvbM4YHN/O150g8xavEqQWJx12L8Uq9FjMLnEYM9ccthIHvnZTYTLIAnSPA1/DKISkdZdh/wN/Q+qmftt90iBcDk+2sZxpD0SW+8dNXZIoa5UAS8jYKSG2wk8pq/4r1mWShKqjURe9hZr/1ZtMlRi2naIE3XjanhXfueRg9iEoEc7/pr/xaCRUlMgSpDcmpPLst84F0NFM4Tyr4aCe1Lg/79wLxOXYjMHZo+qlUPlQ7eIoZpoeAJy7RjbVPhi+dLkgYcvL1S6yz4RPETxiD0DKIIlUEr32gNjOqZ7uRuHnirquwvBoXR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(36916002)(38100700002)(478600001)(53546011)(5660300002)(86362001)(16576012)(83380400001)(36756003)(316002)(110136005)(6486002)(44832011)(66556008)(66476007)(26005)(2616005)(186003)(2906002)(31686004)(8676002)(8936002)(31696002)(956004)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFNOU9SaHZ1WjBrdXB6ZUN4NGVaVnNzK29nNmJCRlFqOXg1NUZEYTFnRGpx?=
 =?utf-8?B?R2FGV1NyNkR6ZE1BQnFKV2JKYlQvcVRidTFZSDRrOFN3bHJEbTVHOVNCcU9H?=
 =?utf-8?B?Q1BKai9NdmNCMmwwMXE5ajFUWjJYZkxvdmFCVG9QblRVR0crbVZBR1E4dTlo?=
 =?utf-8?B?MG5pVE0xQnVUbDVlNXVUbEhRaUFLdUtnTURvdzk5bXRKS0hSanVraU5mY1pt?=
 =?utf-8?B?N0c4LzlINUxucE15M3dPWDVPaGplNEIxQVIrTk5FS2hPenhhbzFIVjZFVUM0?=
 =?utf-8?B?Z25ISHZGSXl1c1FVN1NrNWhvRjU3ejFzYTZNR3lwVFlJaHVzU2daTGpFaXJY?=
 =?utf-8?B?VW9pZWZkM0FrQ2F0YmIwWWJUL3c3NG9rb0czTHZHamt0QTZwcUFtRGlRRk0r?=
 =?utf-8?B?dy9YaWcvV2JQSlNxNG9TWkJndCtmZ094aHNGdWJIS1FjNC9oQkJaVjVEUVVn?=
 =?utf-8?B?RW5PRWpsSlFrOG8wWHpZWCtOU2o4N1RtcENuZS92RGFua3JYMkhxWFc4WS9V?=
 =?utf-8?B?ZUdEUGdiMlBLTGpnSFh3Z1RleVpWeUc1ZmpjYTVLdmVnT3Q2NHdsdHlPb1Uw?=
 =?utf-8?B?cmdNbmt3TVgvMHJJZDhaN1B3OStwaDFCYUJBS2M1dUpNMExZenBCK0tsRitj?=
 =?utf-8?B?MFNJdXBKU2thNG5GWTB2ZWtlRkxRSHFZR09LeHkxVWJ4dzZDL1ZMaU1MUDUv?=
 =?utf-8?B?enNjWlpaU0hWSE5IYkhGNWFyWlgraHNIYUZCVzhRQzdwL3BNdzdhM2NJam9K?=
 =?utf-8?B?N1cra2x1b1R4cEkxOWZsNVB5aFZFdE1JMW9KVEpHUFJnb2R0MjU5dVdleVNM?=
 =?utf-8?B?VkNlTHQrZFpKeCsvdzFNVzhwOFFkTEpRM3dmdE0yL29ta1NxbmpCNUdOYmxw?=
 =?utf-8?B?b0s3aCtzU0U4YWJsV1EyRkZPNGhCUVBSYzJkWFg3VTBRRGYzdTFGZEhpQnFM?=
 =?utf-8?B?UWRlL1FjeExyTEh5RFd0MW8vdnFkMDJKUC9jdGpKdFp6cEw5WVR0T3FoajNX?=
 =?utf-8?B?SmdQYStEaVdHbmZYWDNYeCsrUjVFQzBveFQ3NklhNkZZUjBpWnBUZE83clRk?=
 =?utf-8?B?ZXdwZUx5cVlUdis1MjVmbnVDMytIajVXT2tJWlRpRGRiV3R5NlU2SGtHb2JC?=
 =?utf-8?B?aDdmVjVic3FxUnQ0NzIrL0EvYTJGWXVWZTRUY1YwZ1VKNGdmQm9XMDU4TWtP?=
 =?utf-8?B?QThJaGQ3b2lOQ1pWbXJidE9TOG1sUm8xTkVDNlFGblh5U1BPUnNTTExsYzVC?=
 =?utf-8?B?VFpLLytVOXc1ZW43Q3JrQkp3RVI5ak5zVktRWjVmUjBqZGxyRnYxVVZ3aHh4?=
 =?utf-8?B?Zmp0TEk2eWY1UHVwRjlkQUlBbmxFY3ZpVS9vbmVyT1o3K0hlLytySUxic3BE?=
 =?utf-8?B?MkJ0TFExcFc3MUQ1UmpUSEFISXhwTWJwUGg3WE5xVy9SWmI0KzdhSnVXMTAr?=
 =?utf-8?B?andGN3F4RW1rNnZTMU9lYW4yaDV3MGJzSTNBako0b1hNcXVLME8xNjI5c2do?=
 =?utf-8?B?OFNaK0pNWVcwNEt2dlJnV1oxUG5qQWNWdHJPNys4a2srT0tPMWFOdy9rb2tj?=
 =?utf-8?B?WTdBd041QXMwZ2VWL044a213U2FUeVRpeGtDeWw1cVU2QTRkVmMxSWFHMWNF?=
 =?utf-8?B?SDd6Nm95SFlTNnk4cW1tRUpLOVFaNkZZNTJIVkJzRWlkQk5td2lxOFU5a2t0?=
 =?utf-8?B?V01idlpRdGhVcEVBWHdST25USmFtVnNRNmtjVlJjSjB6TnhMVDRlOGthYXJZ?=
 =?utf-8?Q?ts/xOY9AifceZC9ep6Z/3/AW0geF3XSuxwSITFl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2282dfe3-856d-4336-e6dc-08d96ccdcc7d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 22:22:20.7501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fCnU2gVkyuZ5ixHx42PWlRWpgGj+JzvXF/dm7vD+HSyzrwsGn7/yqy+vWnlcuLmuCszWUcrTLdzb0OMmOCMpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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

On 2021-08-31 6:09 p.m., Zeng, Oak wrote:
> A nit-pick inline. Otherwise this patch is Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
>
> Regards,
> Oak
>
>   
>
> ﻿On 2021-08-31, 5:57 PM, "amd-gfx on behalf of Felix Kuehling" <amd-gfx-bounces@lists.freedesktop.org on behalf of Felix.Kuehling@amd.com> wrote:
>
>      On some GPUs the PCIe atomic requirement for KFD depends on the MEC
>      firmware version. Add a firmware version check for this. The minimum
>      firmware version that works without atomics can be updated in the
>      device_info structure for each GPU type.
>
>      Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>      ---
>       drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--
>       drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
>       2 files changed, 8 insertions(+), 2 deletions(-)
>
>      diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>      index 16a57b70cc1a..655ee5733229 100644
>      --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>      +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>      @@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>       	struct kfd_dev *kfd;
>       	const struct kfd_device_info *device_info;
>       	const struct kfd2kgd_calls *f2g;
>      +	uint32_t fw_version;
>
>       	if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void *) * 2)
>       		|| asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
>      @@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>       	 * supported.
>       	 */
>       	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kgd);
>      -	if (device_info->needs_pci_atomics &&
>      -	    !kfd->pci_atomic_requested) {
>      +	fw_version = amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1);
>      +	if (!kfd->pci_atomic_requested &&
>      +	    device_info->needs_pci_atomics &&
>      +	    (!device_info->no_atomic_fw_version ||
>      +	      amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1) <
> You already get the fw_version above __

I'll fix that. I forgot to remove the local variable after I decided to 
move the function call into the condition.

Thanks,
   Felix


>      +			device_info->no_atomic_fw_version)) {
>       		dev_info(kfd_device,
>       			 "skipped device %x:%x, PCI rejects atomics\n",
>       			 pdev->vendor, pdev->device);
>      diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>      index ab83b0de6b22..6d8f9bb2d905 100644
>      --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>      +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>      @@ -207,6 +207,7 @@ struct kfd_device_info {
>       	bool supports_cwsr;
>       	bool needs_iommu_device;
>       	bool needs_pci_atomics;
>      +	uint32_t no_atomic_fw_version;
>       	unsigned int num_sdma_engines;
>       	unsigned int num_xgmi_sdma_engines;
>       	unsigned int num_sdma_queues_per_engine;
>      --
>      2.32.0
>
>
