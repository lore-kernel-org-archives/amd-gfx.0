Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E58FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1678E61159
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1678E61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A894B6E895;
	Wed, 10 Nov 2021 23:45:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9743F6E895
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 23:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K12f72Tcgkmhyc2lLpY6pEk5I+/lXX/qayj/n+yhgPF/cvvQl3lkXDF7Gwl0IRhEAeR7ByqNhPF81huBRkYZfbXAKopjq1ICKak5ArrQQReCuXXDWvNOJj5ImZJFsBDDCPHlAnttz/Ia7glIObPyZ+xQarkEo53ga/ohyak5dic8BehByuYw7y/EJNY3Ci7zJ30VKCy4Fysn1/7XzVnl3eY7qcOcFWRHQPLHdSmiqnn96qVaBX2edmfXCXwLnZNNolEXhaKSRuLwbK0CheDDA8Oh5XNXN6T+U/PKNG7W+W4Cd46gXYu52sYCD4ZKxs4xy+BZb5aydcCAUWr7lvZgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng45g/03yt8WgZqgwYN5oT0R95OfIRVOfcsvcj9LvVc=;
 b=e5yPqco61bUAAE77ui10pbLWyU2oiiV55ZVEFKEBwbgqktE6Bh4Sq77OlLESdTVdpNxKdtdOWXMQuQWPNKtggZdzrDLSNssz7r+bliey3uDi6eK5GuJ4lXDA8YqKm3y/JFk0Elcy4N566pYTHKhLAey/5zVvxG1calr3fZft8ANzWGQtZnbpAs5Or9hzGChsl1voiNt2hMT86DOH2ffe/RqyGuCBnTM12BDqaPNBSRgUjhVxBXADWAImtC3B9QGPyTiKOL3PJZ8AfC1AZbBINUH+YXELP978cMWvInV8jjfIZCZzIz0IN+ktvuQUVd7zo1Tnht+10gztHpSO88ifBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng45g/03yt8WgZqgwYN5oT0R95OfIRVOfcsvcj9LvVc=;
 b=dOawTrxtnMnljpJfThvLx8oKS6KxKgqtVgQv4pH+DLtXqr1y7ufOouHrFjvWiqYRioX/0I0L8HxhTcPulCIn6J5w26aUZmzqfH6H/Q49u4QIqpRe2ntoAvbpnV6vewaDcO08YwTw7V4QCPfL/d/HVK+LFMYa2cy8vWNU1suKlP8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 10 Nov
 2021 23:45:54 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 23:45:54 +0000
Subject: Re: [PATCH v3 3/3] drm/amdkfd: convert misc checks to IP version
 checking
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211110230704.3792868-3-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <013fac35-b676-6c21-abc4-9f537e9c2b39@amd.com>
Date: Wed, 10 Nov 2021 18:45:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211110230704.3792868-3-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0260.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::32)
 To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 PR0P264CA0260.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 23:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e13c261-d88f-40ec-f57c-08d9a4a43bd5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111D4A2009AEDAF42A1766392939@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fLF6PVzfW/+Zs8ELClCNfBWHSJDlMU/c0onOFKf7wMugIIgbp1SccaFLeVq9lZkhMFdo9G+6ErX6nIfdq85EAANEW0fLeSQMeERD4IjJnW3ZTdR9mnsK7SQBx31NVzXN057mvONNLQG3wFSnq+DJ3oxgZhTpHj9pbHiu4N6eN8RK6UVXrzMRTl0DczKD359eaDevjVNiYuBDQLm9FNaCLJ09ItMDMgpHzWmbjD2n98k3uRm+JPSKnkcWpG3LdMa7Tj2+IiT1ZviIgKYsnYHV65JjglOqCUBSPMAII9zO/pZVrw5dEbOX5dpst1LabJyky1GVVRxd+Ml2yvqQ+2kSb879XrJ0rnvKLvX4+FvB/UVRf/5KqjMHx8f90XzCidTa6ShZvPC3NnCMa6S2UZcoBIC8J3tQnEMF5wsyoIri0JFiJ+1P8gr3HOXJ920y3LpEMwQZTU5F+VZqX+yWVOM/L+tvbseV6J1o9kcTA5/ZcCrlq+M5CTycZIxSADNqOaXzPoudfEb0FKu8LFw+0Zy0l1CHon7ZTG9OzcqH4Ek3DilxyGNLWm6uS2xNZ8S4P/NzHsTrnTH5M/WL139Wnb6bfCDWw87EnSvMyTiyWMl+7ft790VAXLxCdZKA1mNsQhBV6NI+Tdelr2IHk3NvAlUEMsHZlf2xuk/WrQBVFNLvrvZfu70n90Espm5/fWGGVbpJqNKz0KRK/DhT//4PW8AKejxzVYL/uxXTz3oJEBtRHmoEBHANe2a4CsBqs/Rybtu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(86362001)(5660300002)(6666004)(8936002)(36916002)(44832011)(30864003)(2616005)(26005)(508600001)(31686004)(36756003)(66946007)(2906002)(31696002)(83380400001)(186003)(8676002)(66476007)(66556008)(956004)(38100700002)(53546011)(316002)(16576012)(4001150100001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmt0ODdHcThDQjlsYVRmZjRRNHcybXZ1MWlwMjVodVgyTmFZVVhvc3RXV09h?=
 =?utf-8?B?VWQwYURMVlRqSHlGOGdrMjNWSzA0M2M0RUtlTzNFVG1kYlFzZ3Q3TldpRWVu?=
 =?utf-8?B?UGlyR2l1OVpUZzhYRlFjSjBTYTMwL2ZscWwzVHhOSWNPT0lIUEUvWDNleXVn?=
 =?utf-8?B?V2w3b1BSdHdST1paYUtZSHloZHNDNU9KbzNkRUkrMmdRR3Q2ZGFwc21HVzRD?=
 =?utf-8?B?dHpiY1lUYWR3NjYwUys0ZVVKZmYxNGUxamc5c1huNEhlb0ovWVE4TjI0b3do?=
 =?utf-8?B?U3dkamhpWktyRXVQZ0tXUjkrZnRlbHpzcTIwdmV1MllSRDdOTFlIaDlYUGIv?=
 =?utf-8?B?dzdZNkEvTlRlbVRmcEpSOW1oWjNNazNUNk1CbGdOMlJERVZhR2pOR1hKVzN0?=
 =?utf-8?B?QS9OVnJBbzZpMUs3c0t6UitqaVZDdjZGMVN3WFcxcGxFaVdmZFl0cUV0aDYv?=
 =?utf-8?B?RFloZytOWXFKeVlLRU0wYmY2WlhSbEFuNy92ZlRXK2FnZ1RqWmpKN2d3NWtY?=
 =?utf-8?B?ZGF3THVqbkhrRjJic3pNWHBHMzNWMDR0NnQwdnNLc1o3TE9iTk54N3hyQkNI?=
 =?utf-8?B?Zk1UUTlhRGVINlh3UHgxNm5OT2RQNlJlYTdPRlV3WC83Um95UUc1S04xSno2?=
 =?utf-8?B?UUlHOUN1aHJZYUJ6akZ5LzZic2RmQVljcGJtT3lLSjBUcHBaMmp6TEEwbm1H?=
 =?utf-8?B?NW5pbjFBUUowUHUwMmp6M0E3dkl3dHlNVjlHczVaV2M4bzlOR0d5REZCcmlp?=
 =?utf-8?B?UUxNcnRyYW56eDY1NFpZd3VFdHEwMmpZWEhpRmVjN0xJcVg4a1VPUjAvcklI?=
 =?utf-8?B?dFluZ2MzaDBIeGp6bXVmcmI0WmExMFZ1blluTmNnWnhPektCalZiTUEwV1lS?=
 =?utf-8?B?ZWtXdVp4MmhBamFDQ3VVcmw4VXBRbmhEdndTQ2k3SktyT2UrNHgwQ0ZiM3NP?=
 =?utf-8?B?U1phZGJ3TlJyQXBoNmc2VFVoMDY3WmVJWm9GUmw1aFZsMGxjVDNnTmZmemZE?=
 =?utf-8?B?aW1jT0MzZjZSTlJCdFBGcERGTU9YN1JRMjlvaW5EeVlBbW5zTXBYMW8xc0NY?=
 =?utf-8?B?RXY4SGc2WnlmVnBiaEVPWm5SeHRmU0d3NWtxdHNsWUkrVUVjUERVa3V1M2tM?=
 =?utf-8?B?M1BRM3YvSjdzRlo1dm5JS3NXSStaMzFZZmhSYlJiejZMa0ZLQXROSWVwVU1B?=
 =?utf-8?B?b011QldFMStyaXByRlBXOG94aURYd2QvSjlRVTdLTUhRZFcwL0hUT2pBb1A3?=
 =?utf-8?B?ejdqVUNEY0E0ZE1reGYvNFZjV00xSWNWbWdGWW94NzEwNC81bFJIOVNCekpF?=
 =?utf-8?B?TE9LZlNOYlVYL1RmNmp1S2xzNytWU1FhVHFJeFNUdmwvWHVpVHZHV21MK1Rt?=
 =?utf-8?B?L0pvcS9jcUV2SklWcXpXdHlVRy9MejFpbWVtRFpqT3dTaHdZUC93MmxMdzhr?=
 =?utf-8?B?aUh2cUl2QTNaRzJ2RlZyRnNiOFp4RS9qZW9MWTlJeVk4akNOd3lpSm8wazBY?=
 =?utf-8?B?aVppRS9MMHhpWjlJUnRZMFI4QVdtc1B0V0xiMzhGbERGTWNZMG5XMzgzc0pJ?=
 =?utf-8?B?d3ErdDdBUWl5cXZsZ3RhYWJ0ZzNYNFhKNmNVd3JaRm4wNk1ONmVvZFNhK2w0?=
 =?utf-8?B?cnF0RmR4cHVlNlJaUVFnc3JBZ0FtNDd3OThtclduRjQrUC8zbjBTaWx2eVhs?=
 =?utf-8?B?dUg0R2hYUnJoQjQ0eDlVcWljMGNlUFh5aE1SOElIdUJhNnJKaVI2VnBLUCtE?=
 =?utf-8?B?TlBPRUJBWktoeWFqL1NDK2xLK1Q0b05PbWpPdmtQay94K3dKV0NrSUR0dGJX?=
 =?utf-8?B?eGd1ajdRSEUzN2E1UEVwcUdTUTU2SHVNMHVtS2gxczlKNlRWQS84VUNKa0p2?=
 =?utf-8?B?MElXVnNZaXhsVVVCSmF3N0psNHZFbCtUVUR3dVRCZWdvMkZoUXN4OHdjS20v?=
 =?utf-8?B?Nlg5R0dtWnRZVk41RjhxZmpZSWZJOGxBMnhKK1IwRERXSXMrdDJrZ3MxZzlS?=
 =?utf-8?B?bktHZ2FUZlgzYUY3SXVIMVF4M2VBSWxSbndyQUZxck9ZUjdOVzR4SVZaMUgx?=
 =?utf-8?B?OVVlWHVvbVpZbHBaeHM1K1hMMlVlQjVIMjZGTVZ1eVNGdURSMFRHTURwUmc0?=
 =?utf-8?B?eVRqMXVWNWduZm4zaXRIa2hpK1k1ZXF6WlZWMkIvQmxHVzVKbzdTcVI4Z2Fh?=
 =?utf-8?Q?qeG0F3YedhjTAAEdYA+vQXA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e13c261-d88f-40ec-f57c-08d9a4a43bd5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 23:45:54.4882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXit/O0vf5LSrfY/eRM+aLEmbGdg4qjwak/UeGDdzWOW3lB6hUAUEiBbMqVRTVy8yB+hJg+8iAUWd6AVRvIFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-10 6:07 p.m., Graham Sider wrote:
> Switch to IP version checking instead of asic_type on various KFD
> version checks.
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 34 +++++++++----------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
>   .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  6 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 +--
>   10 files changed, 33 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2466a73b8c7d..f70117b00b14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1603,7 +1603,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   	}
>   	mutex_unlock(&p->mutex);
>   
> -	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
> +	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
>   		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>   				(struct kgd_mem *) mem, true);
>   		if (err) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 19dd472e9b06..b6d887edac85 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1992,7 +1992,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>   		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
>   		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
>   		sub_type_hdr->num_hops_xgmi = 1;
> -		if (kdev->adev->asic_type == CHIP_ALDEBARAN) {
> +		if (KFD_GC_VERSION(kdev) == IP_VERSION(9, 4, 2)) {
>   			sub_type_hdr->minimum_bandwidth_mbs =
>   					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
>   							kdev->adev, NULL, true);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index ee813bd57c92..feebd652a7a1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -848,23 +848,23 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   static void kfd_cwsr_init(struct kfd_dev *kfd)
>   {
>   	if (cwsr_enable && kfd->device_info->supports_cwsr) {
> -		if (kfd->device_info->asic_family < CHIP_VEGA10) {
> +		if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
>   			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
>   			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
> -		} else if (kfd->device_info->asic_family == CHIP_ARCTURUS) {
> +		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)) {
>   			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE_SIZE);
>   			kfd->cwsr_isa = cwsr_trap_arcturus_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_arcturus_hex);
> -		} else if (kfd->device_info->asic_family == CHIP_ALDEBARAN) {
> +		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)) {
>   			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
>   			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
> -		} else if (kfd->device_info->asic_family < CHIP_NAVI10) {
> +		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
>   			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
>   			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_hex);
> -		} else if (kfd->device_info->asic_family < CHIP_SIENNA_CICHLID) {
> +		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 3, 0)) {
>   			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZE);
>   			kfd->cwsr_isa = cwsr_trap_nv1x_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_nv1x_hex);
> @@ -885,16 +885,15 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>   	if (kfd->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
>   		return 0;
>   
> -	if (hws_gws_support
> -		|| (kfd->device_info->asic_family == CHIP_VEGA10
> -			&& kfd->mec2_fw_version >= 0x81b3)
> -		|| (kfd->device_info->asic_family >= CHIP_VEGA12
> -			&& kfd->device_info->asic_family <= CHIP_RAVEN
> -			&& kfd->mec2_fw_version >= 0x1b3)
> -		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
> -			&& kfd->mec2_fw_version >= 0x30)
> -		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
> -			&& kfd->mec2_fw_version >= 0x28))
> +	if (hws_gws_support || (KFD_IS_SOC15(kfd) &&
> +		((KFD_GC_VERSION(kfd) == IP_VERSION(9, 0, 1)
> +			&& kfd->mec2_fw_version >= 0x81b3) ||
> +		(KFD_GC_VERSION(kfd) <= IP_VERSION(9, 4, 0)
> +			&& kfd->mec2_fw_version >= 0x1b3)  ||
> +		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
> +			&& kfd->mec2_fw_version >= 0x30)   ||
> +		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
> +			&& kfd->mec2_fw_version >= 0x28))))
>   		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
>   				kfd->adev->gds.gws_size, &kfd->gws);
>   
> @@ -962,10 +961,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	 * calculate max size of runlist packet.
>   	 * There can be only 2 packets at once
>   	 */
> -	map_process_packet_size =
> -			kfd->device_info->asic_family == CHIP_ALDEBARAN ?
> +	map_process_packet_size = KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2) ?
>   				sizeof(struct pm4_mes_map_process_aldebaran) :
> -					sizeof(struct pm4_mes_map_process);
> +				sizeof(struct pm4_mes_map_process);
>   	size += (KFD_MAX_NUM_OF_PROCESSES * map_process_packet_size +
>   		max_num_of_queues_per_device * sizeof(struct pm4_mes_map_queues)
>   		+ sizeof(struct pm4_mes_runlist)) * 2;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 93d41e0b9b41..c894cbe58a36 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -250,8 +250,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   
>   	program_sh_mem_settings(dqm, qpd);
>   
> -	if (dqm->dev->device_info->asic_family >= CHIP_VEGA10 &&
> -	    dqm->dev->cwsr_enabled)
> +	if (KFD_IS_SOC15(dqm->dev) && dqm->dev->cwsr_enabled)
>   		program_trap_handler_settings(dqm, qpd);
>   
>   	/* qpd->page_table_base is set earlier when register_process()
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> index b5c3d13643f1..f20434d9980e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> @@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
>   				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
>   					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>   
> -		if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN) {
> +		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2)) {
>   			/* Aldebaran can safely support different XNACK modes
>   			 * per process
>   			 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 3eea4edee355..afe72dd11325 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -935,8 +935,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
>   	/* Workaround on Raven to not kill the process when memory is freed
>   	 * before IOMMU is able to finish processing all the excessive PPRs
>   	 */
> -	if (dev->device_info->asic_family != CHIP_RAVEN &&
> -	    dev->device_info->asic_family != CHIP_RENOIR) {
> +
> +	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 1, 0) &&
> +	    KFD_GC_VERSION(dev) != IP_VERSION(9, 2, 2) &&
> +	    KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0)) {
>   		mutex_lock(&p->event_mutex);
>   
>   		/* Lookup events by type and signal them */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index aeade32ec298..d59b73f69260 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -940,7 +940,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   	void *r;
>   
>   	/* Page migration works on Vega10 or newer */
> -	if (kfddev->device_info->asic_family < CHIP_VEGA10)
> +	if (!KFD_IS_SOC15(kfddev))
>   		return -EINVAL;
>   
>   	pgmap = &kfddev->pgmap;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fafc7b187fad..d4c8a6948a9f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1317,14 +1317,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>   		 * support the SVM APIs and don't need to be considered
>   		 * for the XNACK mode selection.
>   		 */
> -		if (dev->device_info->asic_family < CHIP_VEGA10)
> +		if (!KFD_IS_SOC15(dev))
>   			continue;
>   		/* Aldebaran can always support XNACK because it can support
>   		 * per-process XNACK mode selection. But let the dev->noretry
>   		 * setting still influence the default XNACK mode.
>   		 */
> -		if (supported &&
> -		    dev->device_info->asic_family == CHIP_ALDEBARAN)
> +		if (supported && KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
>   			continue;
>   
>   		/* GFXv10 and later GPUs do not support shader preemption
> @@ -1332,7 +1331,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>   		 * management and memory-manager-related preemptions or
>   		 * even deadlocks.
>   		 */
> -		if (dev->device_info->asic_family >= CHIP_NAVI10)
> +		if (KFD_GC_VERSION(dev) >= IP_VERSION(10, 1, 1))
>   			return false;
>   
>   		if (dev->noretry)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 77239b06b236..88360f23eb61 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1051,8 +1051,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
>   	if (domain == SVM_RANGE_VRAM_DOMAIN)
>   		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
>   
> -	switch (adev->asic_type) {
> -	case CHIP_ARCTURUS:
> +	switch (KFD_GC_VERSION(adev->kfd.dev)) {
> +	case IP_VERSION(9, 4, 1):
>   		if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			if (bo_adev == adev) {
>   				mapping_flags |= coherent ?
> @@ -1068,7 +1068,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
>   				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>   		}
>   		break;
> -	case CHIP_ALDEBARAN:
> +	case IP_VERSION(9, 4, 2):
>   		if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			if (bo_adev == adev) {
>   				mapping_flags |= coherent ?
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index a4c0c929444a..641e250dc95f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1239,7 +1239,7 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
>   		 */
>   		if (inbound_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
>   		    (inbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
> -		    to_dev->gpu->device_info->asic_family == CHIP_VEGA20)) {
> +		    KFD_GC_VERSION(to_dev->gpu) == IP_VERSION(9, 4, 0))) {
>   			outbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
>   			inbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
>   		}
> @@ -1463,7 +1463,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   		((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
>   		HSA_CAP_MEM_EDCSUPPORTED : 0;
>   
> -	if (dev->gpu->adev->asic_type != CHIP_VEGA10)
> +	if (KFD_GC_VERSION(dev->gpu) != IP_VERSION(9, 0, 1))
>   		dev->node_props.capability |= (dev->gpu->adev->ras_enabled != 0) ?
>   			HSA_CAP_RASEVENTNOTIFY : 0;
>   
