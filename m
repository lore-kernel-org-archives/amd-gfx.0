Return-Path: <SRS0=JwSO=MJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB6CC636C9
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jul 2021 05:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305A761289
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jul 2021 05:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305A761289
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F346EA16;
	Sat, 17 Jul 2021 05:46:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A816EA16
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Jul 2021 05:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6u7inn7ZqhXTKM5nMvb9Ids5dMBKmLNUARR7ZHkAsSoTbkLIDpEQxB7fhAOdmdaDIKXw4bu4Ti+wsRTDKYfr5dNWMQJUpDTjjUozWCcktjMo6c+lV0o5XNIw/27rk2jMDxSCKZogbElo3zWbCAh7J3tUdP/GlSdf03ggYn8UtpnCclNImgVFzHPDHEMyz644hwkviYwfseVctsSv9rnKzaazhxxUUC5P+OAqnWFLB2EeGXFtDrtAqT9pxitINVU0LjJo8GuMzKILnkNww0DA9O1agQyhTJI+1ZHK/e0l3Bb3g9s+p+RakIZzUqAZihvDE+/HsqFA7seIke1ttTC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2FNcRDu0YAudNAx1/o1cW6uRD3cI/UzuL9j7pqz92w=;
 b=IK4hQRnub8GM1mWVq8Wh+0uW/3iRRJoseMN0XuXIoK9Pr55s/yR81L5bKxLkYjIJp4yhz1x/AbYNX5nNTE2JDDEmMOaq+JPIVrKRWSBXsc74pKVGYdua9NNGbq6inJXMqNdB8Ml4CoW6OSPwnDfvhqC3tGn83ooVVu1WOKJNjnFL5CzXI7yyv9T3c3KfbvRZRRxLZufPaAiRVjFaAgGWOTq/6mas/zhaSjU6g+cRXvvK8kr/p8xpCunb2L0FXBpz//KEDIpAXoWhH69+2uMYG9SE6qTdIyOt/PdoTcwgkCFqmvDRmWY5+yotvCxVwGW6txRxFCDjMntckQUrwuRIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2FNcRDu0YAudNAx1/o1cW6uRD3cI/UzuL9j7pqz92w=;
 b=Oh0SxRPDcVcDqfpL8a60T9ZLcEgjScZViyPNyCY7r+JupVpgU0jOynViZjZ8bnM5+hWupmhpt9mpCKonAuZIrwmqU54W6ewD7lshCuIeiITt92tyY0zMMiYQxGKhauTq+Z21/dkuS7nuIGcfYcVEmovQ+maq8qjZamu6ws8PEYc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Sat, 17 Jul
 2021 05:46:42 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 05:46:42 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between direct
 peers to the kfd
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210716164312.896939-1-jonathan.kim@amd.com>
 <20210716164312.896939-2-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c7b3252f-ab9d-acde-aed8-0ae23951e6c0@amd.com>
Date: Sat, 17 Jul 2021 01:46:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210716164312.896939-2-jonathan.kim@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::30) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 05:46:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c90aed96-e97c-49e5-6e96-08d948e64166
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53685CFB690684140C02AF1F92109@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qn3vk5HTNZOdFV0bPJGiXgMfMk7nKMP1fafkVN3/9h8eMfp2iaMxIp0xplmzitBVYeltP31NSPryV7biRwN7r5R7U+4qUngAQzHHNd6my/ZW8rRaa9NtwNtKK2kT/+pqT4b3AN76xK9qcm3YTX3/6KLks2ISYBcTjtMY2miYSWBL+SIkZSTERDT/zzCxXKJgNCVifrFv6GHehaOdTR09w39GBWpKKDpOJGkYPEj1JJ9VzS47Wt6WB6SO3Q5BtbMrdVBDSjhPpsNSxqAurZuH6PNgDpQThj1bNTOIW05RDDUs6ymfxVD4sR7/H5rOLM66CC6LuE7AWHfnJSfQnagG7DLSXTdNNfoFHwUMYgoSxXiGCvyFLN9O39buZ4NA6zuFWYdkaEeEhfqng6FLVmoFOAD0BBnAG9U0ZKZnk/JaSRLM/rm1H+5U7i6tLYOvHPUxIYOJT5xD6tzCct4CpJlH47zN2lBLPZCnNg6GCqwNz+xAfDuAMOBGJ7wSya6fBjLY5DQiGWqghfPQZ9yoMDDpjFIhmaqfxC4ABbI0b/67wT10RrtGEvvEswowbeLp+vwGXP43aB8Yh6vCgbBnYsJi9VDEOrLFQhp9WzbI/gPRd4PXRjz8z6qUPsP1SjEcoOaxtz6z5gxzJ1UYXu+NcU3OUH4HyJ3UL1R3lfbCkRbIoC4/78QHEw3Bp+3IsHyaIyFyhpeN8n20efTk7G1T6zw4rpYc4/HkaK6CqIULFZjhr7lylAdXaVIBpmSaH4chj5e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(66476007)(956004)(44832011)(83380400001)(66556008)(36756003)(2616005)(86362001)(2906002)(31696002)(316002)(31686004)(16576012)(186003)(26005)(38100700002)(66946007)(6486002)(5660300002)(478600001)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGtYQkdheWRnWnlkLzZPTjZ5aTMyWU0xNlV5UEVGVElUUDNneC9EZ08vdEpj?=
 =?utf-8?B?WVc5a2JuTW5HaldxbEFJZm5rd0RPU0UzUk9hMWRDb0tESXRCTVBaenpmeWRs?=
 =?utf-8?B?SURGSWpvZ2M4dUs1OGkvc0tFOSs1OThvcklTNGRqVVhYeENGejRmM3EzbG54?=
 =?utf-8?B?UDR4TFRBZ01mM0htaEF4WWZFdElKVzllTmhKcG81Qzk1VmY4MFFpejVvNFc4?=
 =?utf-8?B?dWtjcjJnN1FrdnNiRXZwdTRkdG5JSEc5ZSsrVWd1c29GdmRvcEFjUGo4ank5?=
 =?utf-8?B?N2l0T2I5cWg5MGJwaEx1bkxFV0JOcDhIY0VNYUhFOUJzQTQ1bmVPdHZCOEVV?=
 =?utf-8?B?TFdGTkVXbUh1elhZMXFkK2FkM2pQSjdhTWZiT0pheURJWVlmeUMyb29RUlVS?=
 =?utf-8?B?a2pEU3FZUEkyV0IzaTJIOTFtTnpmc1B2ZFFTRnNNUDI2cHNRWkRNOHlMcnZh?=
 =?utf-8?B?RzBOTFFueGxncHAxMGphbFBKOUZnb0RNdnlFUFVwS2pqUjNKS0t1Z0ZmSzRE?=
 =?utf-8?B?NXZjU1VRL2x4U0lJdEY1NjI1blZmZGxZanFuUFdSdm9qZlNadURhRkRhODI5?=
 =?utf-8?B?N05QdmMrVHJnVTk2S3piaXZiVUZ6bXpzTGtCMFR1bHcwTlo0V3drMFl6K1Zo?=
 =?utf-8?B?eUZxMDIrR1MrQjR3Q1FpOVNhdm5veitPdkYvZHFha2x3VnU5Q3RiRWd2Tzc1?=
 =?utf-8?B?K0NYL2NrUGh3MkFaenJpbGd5ejRpQk1jNHBCc0RFRWZLWnZEOExXUmRXMTB0?=
 =?utf-8?B?dEdSUEtGb3QwclNtWlBPdXpwY0J1b3Z2QmxkWVZMMU9xN1A5RHJHMWxVc2h5?=
 =?utf-8?B?SkVoTVZYZFlHaVh3TitEbFRKRTJoaVJFTnR3cXBUSUtPUis0Y3NyMkxQbFNJ?=
 =?utf-8?B?L2xqeFozL2ltQkFzTUxNMHJyZDUvWjBJTmxnUFc2SHo0TDNpSk1MbFhpVWVs?=
 =?utf-8?B?K1ZLYjdYbWlCLzlzZ2N2RUE5bDM5VUc3ZEFGWFZ6Z0gyVDhaOG5wQlU1bGN0?=
 =?utf-8?B?Y2M0c0NHaHhoMnIzMmhGZlNOeDBiOCt0QmtOOFZxeFQ1UXpidStyUjdUajBZ?=
 =?utf-8?B?bXhaanpOMEJ0cndsajVCQkx3WjZLejlKZ0w5NVRZODl4K2dKK0prU0hJWWt5?=
 =?utf-8?B?ODNFV3BMUmxJelVBa0NkQTlnUmZaM01hS2Z0Q0t6NVMwU2NvVjk1anpVei81?=
 =?utf-8?B?ZEIvcWoyYmJsSFVZSTkyeEpYTVJZQ1RtRGdxb29NWnYyem5hUEI5cnU0Z3Jt?=
 =?utf-8?B?R3hzSWJDaElIbVFxK2FaNlpDZXdEL1VFYkVSRVNjU1J0ekxycXZZb1JxYnZq?=
 =?utf-8?B?NG12bFZzL0I0Tk9CTUpnWjB6ZWVLd2ZZdmFZdGZ2bnhDKzBRRkliaVF6QXlk?=
 =?utf-8?B?cjFjOXFNU2FoT0thTUF3Syt5NXN1ejU5d1doNmtSaklKalRad3J0Wm52cTJN?=
 =?utf-8?B?QWdnb0ZoZDNyeFJ6SklVUzZERlNnQzVkZTdFYjRhSXdLLzcvRzlMV1c1U3pn?=
 =?utf-8?B?SVRaUjkwbFJ1dVNFNzhLRnI5SFJDOUVNMCttaDVJM2lzV3g1OFpSNnFHOExz?=
 =?utf-8?B?cjl0SU15NGwxQkh4RExzcE1zbVVsbVBWcUwzK0FkV1JtdGU0UFl1ZTUrZHll?=
 =?utf-8?B?LzBNMFNGS2Z4dFF6bVlUZ0VDSlFPMU5JTzBkSUdxMnRuMTRNK1hUOU9oZldQ?=
 =?utf-8?B?Wkt5NlRVeXJxRmlUM1hXOC9udi9YUjVQRC9vMHVsTWoxeG1UT296RGhJOHJF?=
 =?utf-8?Q?Vlns4mXxQHEpMu9jbmT26gdjnzkcYSiLXDxUugE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90aed96-e97c-49e5-6e96-08d948e64166
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 05:46:42.7631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfzYvXL6g+l0Z88oyIk0YI8Rst+2EZW+CIfonvDtb47KKyjm9Fm4CqV9m252FDUvn7NdoKnlkiXY0UnF3DJNbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-07-16 um 12:43 p.m. schrieb Jonathan Kim:
> Report the min/max bandwidth in megabytes to the kfd for direct
> xgmi connections only.

By "direct XGMI connections", you mean this doesn't work for links with
more than one hop? Will that spew out DRM_ERROR messages for such links?
Then it's probably better to downgrade that to an INFO.


>
> v2: change reporting from num links to bandwidth
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

This patch is OK to provide bandwidth information on Aldebaran. What can
we do on older GPUs? Can we assume num_links = 1? Or maybe have some
hard-coded numbers depending on the number of nodes in the hive?

Either way, patch 1 and 2 are

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 23 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 12 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 12 +++++++++++
>  5 files changed, 50 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index bfab2f9fdd17..3978578a1c49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -553,6 +553,29 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
>  	return  (uint8_t)ret;
>  }
>  
> +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dst, *peer_adev;
> +	int num_links;
> +
> +	if (adev->asic_type != CHIP_ALDEBARAN)
> +		return 0;
> +
> +	if (src)
> +		peer_adev = (struct amdgpu_device *)src;
> +
> +	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
> +	if (num_links < 0) {
> +		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d. ret = %d\n",
> +			adev->gmc.xgmi.physical_node_id,
> +			peer_adev->gmc.xgmi.physical_node_id, num_links);
> +		num_links = 0;
> +	}
> +
> +	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
> +	return (num_links * 16 * 25000)/BITS_PER_BYTE;
> +}
> +
>  uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 81264517d532..e12fccb2d2c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -226,6 +226,7 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
>  uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
>  int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
>  uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
> +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min);
>  
>  /* Read user wptr from a specified user address space with page fault
>   * disabled. The memory must be pinned and mapped to the hardware when
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 8567d5d77346..258cf86b32f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -486,6 +486,18 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
>  	return	-EINVAL;
>  }
>  
> +int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> +		struct amdgpu_device *peer_adev)
> +{
> +	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
> +	int i;
> +
> +	for (i = 0 ; i < top->num_nodes; ++i)
> +		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
> +			return top->nodes[i].num_links;
> +	return	-EINVAL;
> +}
> +
>  int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>  {
>  	struct psp_xgmi_topology_info *top_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 12969c0830d5..d2189bf7d428 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -59,6 +59,8 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
>  int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
>  int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
>  		struct amdgpu_device *peer_adev);
> +int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> +		struct amdgpu_device *peer_adev);
>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
>  					   uint64_t addr);
>  static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index c6b02aee4993..40ce6239c813 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1989,6 +1989,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
>  		sub_type_hdr->num_hops_xgmi = 1;
> +		if (adev->asic_type == CHIP_ALDEBARAN) {
> +			sub_type_hdr->minimum_bandwidth_mbs =
> +					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> +							kdev->kgd, NULL, true);
> +			sub_type_hdr->maximum_bandwidth_mbs =
> +					sub_type_hdr->minimum_bandwidth_mbs;
> +		}
>  	} else {
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
>  	}
> @@ -2033,6 +2040,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
>  	sub_type_hdr->proximity_domain_to = proximity_domain_to;
>  	sub_type_hdr->num_hops_xgmi =
>  		amdgpu_amdkfd_get_xgmi_hops_count(kdev->kgd, peer_kdev->kgd);
> +	sub_type_hdr->maximum_bandwidth_mbs =
> +		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, peer_kdev->kgd, false);
> +	sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
> +		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, NULL, true) : 0;
> +
>  	return 0;
>  }
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
