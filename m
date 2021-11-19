Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3B0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 21:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E636E1BC;
	Fri, 19 Nov 2021 21:31:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEDE6E1BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 21:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM73gI1RasouY758sLgOMW/FyfrCly2umvV0eaUkRzaBXJWkyeVdbqBDrSQBUi/9aE1SAPWmiU9QVHk1tflQ3W2NJlfZOqVptHqmA7nvXnrwGdzwrUKd5fi2jBt//5hy3SGBne0zF05IUeoLri4RAvPrbGZyzUpP6UR4oFVucFAwtaNW0D8PxSjfKu8MzCpvd40/bL2RFY66IpfQ4yrFCrZfbTKGAzztQX0vA3H+DmLZ5WtgUStuo8leeZvNfTxW5+gVgMiQvxXCip/DJy1+5IQetlib5jK9l7jKNJJxIQiiUDMkdG5rmTLMKobjlXhEYIGzDpXNsuh1wm3x2c0BVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpgk6i2ovUlwf0me6BynUloCbmNs9cW2iCYuUTJ0vgI=;
 b=cdrq4IwtkMauF7PE55XGl3LJsMb7GmVde1RplZdhxo1e5Cz7qJj6ObzcHv7zeRYBn8L1fe8LPPtnR0zzTfs5p48wrOd94RdCqawrsYro2eOteE6KyZ6+paINB/VAQGCuFi7Pr05qippIR90sz5De1YiohCInMAXvMHdC9isowEJcqr9eaqZLJPUJVghkZmpNyN2XbLDPRMO+jof4LFJRNMuhG/0OJAO4vgY87Qq3EFYmx8hdb/IkwrW5Fzl0Ox9110kGOx0iqeSkbOMTXuT73ibX9/Kwp8fdgFrMfSWHP8S3cxtDx5mgNoaZOIM0cotwShOZJ5ZAtncPOQbXWUEXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpgk6i2ovUlwf0me6BynUloCbmNs9cW2iCYuUTJ0vgI=;
 b=dAncpx+slEVjVIY5K3nK1UD6JZYPfzD65/3GUAVTIcZU5G7PqPAzf43ftASLAHIoss+u7XY1kgamFRljMDuw7Rp5n85MAbq8BfiMXiKEmfHpeu/NBSovA1f4LMSWqwjtS5RQhYL9c/i0Hwjzi0ReQRHqypUq1iWGbwNU2BKgusY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 21:30:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 21:30:57 +0000
Subject: Re: [PATCH v2 4/4] drm/amdkfd: remove hardcoded device_info structs
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119195258.2173551-1-Graham.Sider@amd.com>
 <20211119195258.2173551-4-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <27bd8728-4519-54da-327f-a75a7cc6931c@amd.com>
Date: Fri, 19 Nov 2021 16:30:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211119195258.2173551-4-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR0102CA0056.prod.exchangelabs.com
 (2603:10b6:208:25::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 21:30:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b882c835-c88e-4696-3136-08d9aba3df7d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5065:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50659424ADAF13CDBD279299929C9@BN9PR12MB5065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKm4iBnwKcsGHMse0buqWCTHQAi3iW7zmErLEA28EuGSNNqN1SDHudzTD4bYkrlrafsZc1gSkI6lR4DtHu322jLxRShuZ9psRklbXJa3C9w26BeLvJboWEOZKxiyn5DsaC5CQeLKGjh4HJzALHSI/U4SEliEjleMPhLNo8uX/kSd8zwufjbgb5zYwaJXbASURCnS9iP/N7SPFqqNaTkDcdAtMUs0xx3rxSIsXQKUndNhi5mA2vuMuVonfVZMoJZU+A0RlF6LM08KMnWexAYJJNdTpGHR8mRO5ujmZ3weQOT9egE3I5q4j/bjVoI189ZBtKWOMw9CXsPVGd+dnYzZnBaGo7XtJgw1RetK20kDGRwuXTdvAFcbv121Uvyo/GxxrCXev3ZH5O0orufjZqhFBibO/q6dpiZYCPhFOGJx5/LpRi6q+be29MobCCtvO+tU7+GIwZ6o6zd626dZLmq7SXUssGLaLGtqp5zRflQvi+8TKWUF2A49tp3zZGu/vWoCOyP0YtfNnvuOi5NY/FvQtY6/vfEFRXrG8NfVI2XBXw/RYi+C7N57xPA2C0Otsnr57IO+/AEsdcnv2hySLgej5xOTtmGz/QK/F3u3XX5Y5SIXnuiOPXQm73EIzu/DU07ToIgA7oChSzN/lt/I0SwKusYExH4jUIli7oz8DAgchpzu6+LRUDQ+FXqlapTPGSv+28vyumVY3//znovaurVbyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6486002)(186003)(16576012)(4326008)(66946007)(508600001)(316002)(83380400001)(66476007)(66556008)(31696002)(956004)(5660300002)(8936002)(30864003)(8676002)(53546011)(31686004)(26005)(4001150100001)(2616005)(36916002)(44832011)(2906002)(38100700002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVQ3d2hxSFBySXkzcmk2VktTV2diU09IVktOUzFBNGhJQ1B6eDZ3TW1tenc2?=
 =?utf-8?B?MEVJRjMxT241QnJROXE0ZUFqWVduMC9oNWY0Wm5UYjlWc0ZmdW1JcmFwU045?=
 =?utf-8?B?TDRkODRwUm5VdEd6R1doanIxb1FBRTZ2SncyZkJGaGlLNjJ2aU5SWU10eDBX?=
 =?utf-8?B?MkRQbjl1NGZZemhaVjlHUndNU0ZYS3JiajRUcGNSVDZsdC9vc08wdlVhUnJK?=
 =?utf-8?B?d05SSEEzbzJtdGllMm5yeXBQZS9idWtMK0NhZkIyd01DTUZnSGkvVmJ4MDJR?=
 =?utf-8?B?V21LNmFEazIwcE5vWm04UDJXRHU5N2s1QmR0R0dsRFk2QmFhUDAzSEtmYW8w?=
 =?utf-8?B?K090aWk4clpXd3A5eWtvdWlEYk1qQ3ZKR2czWTltTmVMcHZWN0N1SjBOK1A3?=
 =?utf-8?B?c2l4cDVNT0o1cEpPRUN5NTY0SmRxSGlmcEx0YVc1a2g5TU5hbGs3dTUwVFlC?=
 =?utf-8?B?TWJDL0k2NnFheDR5VzcwYUpHaFpHMFJTRGVtdEY4R0FMTGpULytBSEpBak5U?=
 =?utf-8?B?akxVcGpSYzVqWXcxVFB4OFJYRVN4ZGsrd0JRYXdtWFdTMm1SemxDK3dvVHVa?=
 =?utf-8?B?YkFvbmR5Wmg2eU1vc3paSUR3aHNtbXBmMlBlZUd3TVdSd0hpd0RSSXBVa3cw?=
 =?utf-8?B?WUFoWUVKNkpOUGFlRHQ3em9vc2lBOFBkMUxvYjFzWFlCemRqUDZ3M2xCdzBh?=
 =?utf-8?B?M0xPUG5Xb2ZReVNWQVFSMUkxSkJKSmd2S0luOExEWEhyODdmK0dqUTFYMW9I?=
 =?utf-8?B?RkJnMFlXbjkwbzBqQlFWckxmOC9uZS9QdlJvbGNHdTNsNE1nQ3pnM2RhcG1L?=
 =?utf-8?B?R0tGVjRKK21lQVRRK3UyR0oxRHdyMzBndzQrdDArY1J1NmU4RWVpNVpDYit4?=
 =?utf-8?B?cWxIR25WbkJBaTB6VFdRUEp0ZUl6MHlOY1haZlJ6ajJUTFFhZHpGaWc2Smk5?=
 =?utf-8?B?aGxzM1QrM2tNT2NTUTh5SFIxKy9STkIydUNlY2NMeUUzRmNXTUMvMEpLbVBI?=
 =?utf-8?B?TjBRc1gvai9DcVR6djVBV1grRC85ZUREL2NhVCt6RzN1UlZ0STR5TVQ1eWFi?=
 =?utf-8?B?aTc0eHZqZkZUODVPdC8yZUplYXR4L1RRL0xEMFdCWm8xWmQvVEY3RGxKYjRK?=
 =?utf-8?B?V3J2L3VXYndoYW9LYjRENjdBVW1LUjBINDB1VFZGZTFsRmtnaXNZdXhab2Zk?=
 =?utf-8?B?bFAzc0ozMEJqd2t4U05tOGZUUVZhZTdWZ3g2T1RZN21XR201UzVDRXJyK1lJ?=
 =?utf-8?B?ZEUzSjZDWVBPblgwZTRhUE5TWExuL2t5eXdwZGNjdncrOXZmbkJsVzN1L3ht?=
 =?utf-8?B?R3plSDRmNjQzRXZJak1EMUtMQ0VHWThMRCs4a2ZtMVR1WnBRV1BsY2NaK29x?=
 =?utf-8?B?QTdZYytWdWhvZGxFY3EraWx0ck5FVFdFQXpVV1FDdk4xVEx3UFZIUVV4ZnN4?=
 =?utf-8?B?U09XV3FXS3luS1BDbkdXM25ZVDVkNFAzSCtkNmZTNDk4cGorV0lnYVYxK3JN?=
 =?utf-8?B?bzR3NzF3QzJ3YldMRS95TDlMZEhFM2VzeFhKdGJRVHlpTVN2Y2tsZWNVNkYr?=
 =?utf-8?B?NnBxWG5IMEZCZ0MyR0lUb2RGOEh2QjMyZGp5dHpkQm54ZmpKd0laK2xjR3Jh?=
 =?utf-8?B?bFdldkxpTE9rUU50bjE1d0dZeFRFTjJyYXlYR3RDWVlUNVZPditwSE5DK1Ny?=
 =?utf-8?B?a21GcDVQY01TaVpXZU9objhhMWpxT0hBY3VaeDV4U1MyQlBoUml2ZHpBRDFG?=
 =?utf-8?B?N1dQcldJK3pWc0NxOXFxMEd4bUtYaGdvUGRNcTFoV3pUY2VMcWRrZzEvY05i?=
 =?utf-8?B?RFk4Ly92RDlRNGc4cTZtemJFc21RRGdGWG1KN0JwWmxwMjcyRXJXWmVVNUVk?=
 =?utf-8?B?VE1nbDFKUW0vdDl0TlZKMG8vUnZEdEpidFNjUXl0Z0FzcWNXU0R3emo0aGla?=
 =?utf-8?B?VCtvMGpRVzJwUGtFT0tRL3NhVXNZTHA1WmVyWWFqL3ZNSU92QVFuRktOZkZv?=
 =?utf-8?B?SmZBdTlIS3N6QlJxWGxHR1h6SFc3WWROZVQ1TzdzM1J5bjBxMUNzT2lZS0RV?=
 =?utf-8?B?b0liWS9SSGt2cFdDdE5zWG50V0t5SUhacUhFZGtDUS9EUVlHeUJ1QmViT2Z2?=
 =?utf-8?B?Y2N0b2NoMDNBWDBBUjQ1eExHNHM4WElCeGNwK3V0SUFlOURUREZEdmVEZGV2?=
 =?utf-8?Q?cLRcxbHGVPshw60T91tQIn8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b882c835-c88e-4696-3136-08d9aba3df7d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 21:30:56.9488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as9fRl2JO8uSnns6kjFNn+wfVNAeCxr0uahIER/uMfQWC13pwqmfhDg2Jmqd+QcU6TFHprTjLPhl8E6QlQPKvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-19 2:52 p.m., Graham Sider wrote:
> With device_info initialization being handled in kfd_device_info_init,
> these structs may be removed. Also add comments to help matching IP
> versions to asic names.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 469 +-----------------------
>   1 file changed, 17 insertions(+), 452 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 7ddea653b3d9..e36487a85c93 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -53,458 +53,6 @@ extern const struct kfd2kgd_calls aldebaran_kfd2kgd;
>   extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
>   extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
>   
> -#ifdef KFD_SUPPORT_IOMMU_V2
> -static const struct kfd_device_info kaveri_device_info = {
> -	.gfx_target_version = 70000,
> -	.max_pasid_bits = 16,
> -	/* max num of queues for KV.TODO should be a dynamic value */
> -	.max_no_of_hqd	= 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = false,
> -	.needs_iommu_device = true,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info carrizo_device_info = {
> -	.gfx_target_version = 80001,
> -	.max_pasid_bits = 16,
> -	/* max num of queues for CZ.TODO should be a dynamic value */
> -	.max_no_of_hqd	= 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = true,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info raven_device_info = {
> -	.gfx_target_version = 90002,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = true,
> -	.needs_pci_atomics = true,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -#endif
> -
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -static const struct kfd_device_info hawaii_device_info = {
> -	.gfx_target_version = 70001,
> -	.max_pasid_bits = 16,
> -	/* max num of queues for KV.TODO should be a dynamic value */
> -	.max_no_of_hqd	= 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = false,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -#endif
> -
> -static const struct kfd_device_info tonga_device_info = {
> -	.gfx_target_version = 80002,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = false,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = true,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info fiji_device_info = {
> -	.gfx_target_version = 80003,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = true,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info fiji_vf_device_info = {
> -	.gfx_target_version = 80003,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -
> -static const struct kfd_device_info polaris10_device_info = {
> -	.gfx_target_version = 80003,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = true,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info polaris10_vf_device_info = {
> -	.gfx_target_version = 80003,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info polaris11_device_info = {
> -	.gfx_target_version = 80003,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = true,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info polaris12_device_info = {
> -	.gfx_target_version = 80003,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = true,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vegam_device_info = {
> -	.gfx_target_version = 80003,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 4,
> -	.ih_ring_entry_size = 4 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_cik,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = true,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vega10_device_info = {
> -	.gfx_target_version = 90000,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vega10_vf_device_info = {
> -	.gfx_target_version = 90000,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vega12_device_info = {
> -	.gfx_target_version = 90004,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vega20_device_info = {
> -	.gfx_target_version = 90006,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd	= 24,
> -	.doorbell_size	= 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info arcturus_device_info = {
> -	.gfx_target_version = 90008,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd	= 24,
> -	.doorbell_size	= 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info aldebaran_device_info = {
> -	.gfx_target_version = 90010,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd	= 24,
> -	.doorbell_size	= 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info renoir_device_info = {
> -	.gfx_target_version = 90012,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.supports_cwsr = true,
> -	.needs_iommu_device = false,
> -	.needs_pci_atomics = false,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info navi10_device_info = {
> -	.gfx_target_version = 100100,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 145,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info navi12_device_info = {
> -	.gfx_target_version = 100101,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 145,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info navi14_device_info = {
> -	.gfx_target_version = 100102,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 145,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info sienna_cichlid_device_info = {
> -	.gfx_target_version = 100300,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 92,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info navy_flounder_device_info = {
> -	.gfx_target_version = 100301,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 92,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info vangogh_device_info = {
> -	.gfx_target_version = 100303,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 92,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info dimgrey_cavefish_device_info = {
> -	.gfx_target_version = 100302,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 92,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info beige_goby_device_info = {
> -	.gfx_target_version = 100304,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 92,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info yellow_carp_device_info = {
> -	.gfx_target_version = 100305,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.no_atomic_fw_version = 92,
> -	.num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info cyan_skillfish_device_info = {
> -	.gfx_target_version = 100103,
> -	.max_pasid_bits = 16,
> -	.max_no_of_hqd  = 24,
> -	.doorbell_size  = 8,
> -	.ih_ring_entry_size = 8 * sizeof(uint32_t),
> -	.event_interrupt_class = &event_interrupt_class_v9,
> -	.num_of_watch_points = 4,
> -	.mqd_size_aligned = MQD_SIZE_ALIGNED,
> -	.needs_iommu_device = false,
> -	.supports_cwsr = true,
> -	.needs_pci_atomics = true,
> -	.num_sdma_queues_per_engine = 8,
> -};
> -
>   static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
>   				unsigned int chunk_size);
>   static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
> @@ -632,11 +180,13 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   		break;
>   	default:
>   		switch (adev->ip_versions[GC_HWIP][0]) {
> +		/* Vega 10 */
>   		case IP_VERSION(9, 0, 1):
>   			gfx_target_version = 90000;
>   			f2g = &gfx_v9_kfd2kgd;
>   			break;
>   #ifdef KFD_SUPPORT_IOMMU_V2
> +		/* Raven */
>   		case IP_VERSION(9, 1, 0):
>   		case IP_VERSION(9, 2, 2):
>   			gfx_target_version = 90002;
> @@ -644,69 +194,84 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   				f2g = &gfx_v9_kfd2kgd;
>   			break;
>   #endif
> +		/* Vega12 */
>   		case IP_VERSION(9, 2, 1):
>   			gfx_target_version = 90004;
>   			if (!vf)
>   				f2g = &gfx_v9_kfd2kgd;
>   			break;
> +		/* Renoir */
>   		case IP_VERSION(9, 3, 0):
>   			gfx_target_version = 90012;
>   			if (!vf)
>   				f2g = &gfx_v9_kfd2kgd;
>   			break;
> +		/* Vega20 */
>   		case IP_VERSION(9, 4, 0):
>   			gfx_target_version = 90006;
>   			if (!vf)
>   				f2g = &gfx_v9_kfd2kgd;
>   			break;
> +		/* Arcturus */
>   		case IP_VERSION(9, 4, 1):
>   			gfx_target_version = 90008;
>   			f2g = &arcturus_kfd2kgd;
>   			break;
> +		/* Aldebaran */
>   		case IP_VERSION(9, 4, 2):
>   			gfx_target_version = 90010;
>   			f2g = &aldebaran_kfd2kgd;
>   			break;
> +		/* Navi10 */
>   		case IP_VERSION(10, 1, 10):
>   			gfx_target_version = 100100;
>   			if (!vf)
>   				f2g = &gfx_v10_kfd2kgd;
>   			break;
> +		/* Navi12 */
>   		case IP_VERSION(10, 1, 2):
>   			gfx_target_version = 100101;
>   			f2g = &gfx_v10_kfd2kgd;
>   			break;
> +		/* Navi14 */
>   		case IP_VERSION(10, 1, 1):
>   			gfx_target_version = 100102;
>   			if (!vf)
>   				f2g = &gfx_v10_kfd2kgd;
>   			break;
> +		/* Cyan Skillfish */
>   		case IP_VERSION(10, 1, 3):
>   			gfx_target_version = 100103;
>   			if (!vf)
>   				f2g = &gfx_v10_kfd2kgd;
>   			break;
> +		/* Sienna Cichlid */
>   		case IP_VERSION(10, 3, 0):
>   			gfx_target_version = 100300;
>   			f2g = &gfx_v10_3_kfd2kgd;
>   			break;
> +		/* Navy Flounder */
>   		case IP_VERSION(10, 3, 2):
>   			gfx_target_version = 100301;
>   			f2g = &gfx_v10_3_kfd2kgd;
>   			break;
> +		/* Van Gogh */
>   		case IP_VERSION(10, 3, 1):
>   			gfx_target_version = 100303;
>   			if (!vf)
>   				f2g = &gfx_v10_3_kfd2kgd;
>   			break;
> +		/* Dimgrey Cavefish */
>   		case IP_VERSION(10, 3, 4):
>   			gfx_target_version = 100302;
>   			f2g = &gfx_v10_3_kfd2kgd;
>   			break;
> +		/* Beige Goby */
>   		case IP_VERSION(10, 3, 5):
>   			gfx_target_version = 100304;
>   			f2g = &gfx_v10_3_kfd2kgd;
>   			break;
> +		/* Yellow Carp */
>   		case IP_VERSION(10, 3, 3):
>   			gfx_target_version = 100305;
>   			if (!vf)
