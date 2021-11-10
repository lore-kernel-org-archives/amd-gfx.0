Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D59C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E058961248
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E058961248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533566EB49;
	Wed, 10 Nov 2021 16:21:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05EA76EB51
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 16:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK0S13mdnQ8uPN8o+mJRrxsBZu9Z6bfW0Hv+hXjHc88/4xBuv566wIXC5ozjyhyWjub8iKMUxRXxe0gm82EkLRzL0VHn1FoZ3E8yfPjd1amQAagFhGJ9Fa0o4vVssIuvSJt8vwG/ZSXgdPiW6MnCrYU92V9USdBA1z5nWbIALukNWnp6VEfCpzdtdZ8ZTkXwoSXtiXLvgeUgtQgd6UBx/e8PumwQSPf3ht1HpvqJdE3nSki4HZ15guNW3bNxRSvu//k10jSLZUYd5ZSj79uHMMbAR0oq4CmMJ8kBzKragwSugubzzqH1Dvjx/LVEUThDLPrEUYKyzUnXKlUbvye8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcNAGIxip7/9+s/dsmiwG8Av6OEF+TnF+jFwIVyLbvE=;
 b=ViE+BVmbb2UfwbF+iJ3rvPUyZT8Ct8BGrp8qD0XzSASGONO28sGBZzhTRYCFiQB+70V8udtmgM0zlhfzZFiuvdrWcTatEXrdwLzfDMKLf0tvSUAG/x54awofNl+qpOD6NJt4oB7ZDeSuk5/7FUkUFoo/GpBTQdkyvMkCNaHN/AEIaPUkXGWnqMnP4WxtcDah2eiK9yl4CS037qCv7gizStfDnzv2hg2o44zszII6oCacqvTScCAvy/fL5kpoIIC3uznkwcBrYGZJQWgf2rSvtNXEFgzkMAoEyXcQB54Wm0Ylw+EXqmSFXaYL4aX01n5IziRk4di7Tm4P53ai3Wc7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcNAGIxip7/9+s/dsmiwG8Av6OEF+TnF+jFwIVyLbvE=;
 b=Ea1rn86KncunKxjtKq7nCV35iTwrvj41KpVew2iGFJypDfYKISDoNdMqM8alZGOd3mm35CN+FOwTkzDlE5Cszl9O4LL6DpbPQ7Jf3JoGx3Ax66coivA9fmjJ+h1YVptQ4QuDAao/05zU4VAxiKLMR5B15m2BZhi6bWkCl30oPic=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 10 Nov
 2021 16:21:41 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 16:21:41 +0000
Subject: Re: [PATCH v2 3/3] drm/amdkfd: convert misc checks to IP version
 checking
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109224251.3484398-1-Graham.Sider@amd.com>
 <20211109224251.3484398-3-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c253d597-aa8f-dfed-8a54-2986eeb4c205@amd.com>
Date: Wed, 10 Nov 2021 11:21:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109224251.3484398-3-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::19) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 16:21:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf2d2d9a-99e8-419f-baba-08d9a4662dcb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52084CD53B7FED35FADDD45892939@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MW0FjSJNSiLDtUO1InH14Tiu7j8p0jbFP15HjUEywICxtWtqTZdKL4dyBSlAJKmug6yv4EEF+6VgNczJQKc5H5zW2Of56v3QqiE7e7GE2SPcv8GuS9ge5pzjXnuPLfS0Ab/9BKzfAia8/sKhWeUzR1ir6H/zVO6vqCndWiaDfiU5P8Ic/TKFDyEqb/I86enY502EGqKC90dGloDBgzid4FWNKE0mDYm2Gqtw2neubj21nVvjtmGbH+lYWu36Ri+uT4HeVknd4jGAgR72ysVddgOI3ENxSBWxOP1eiiq8eyzhipuZnEDmE1oAUSdJjZJb2zWfLef0HehICgNhSv5Kt1zuTqFdaqAqYJHNaE/IWXIFoXHWAq8R7ILyLI9kfP/8wVDiVohca2g7aXKNEDuh681UKYfBEWsZiWs/DdYVzIqF9V9a/37k41O0OOw7SzY5mHoH9rLVkPTSeS9R6hEUW0eaAsaS2sJXKh3i2AGzDf0PD2e9tk/wEDlCkgyxAu//yM5cJID+PDFlZQDnvXGEATeC8hhQOWf6sAJCXBTcIL7SJ6dSV+iW2dJpaBAn6n5tOsbP53StpMPgqHa9NriyLxzLISzK3kadwaEMb1ACd8A/vkPAFelE9QWA/hQ0EbV6ZFIme7i1KpO31xff4oAkE5pvm2cer+fj4hGDk6Evg6F3jtbaqJi+mlIeVFWFZWQqcpVz72AdsI7mV/qXaDQ0dLcnyK1bbsUU3ourW1Po+h8kT48I+JOPPjZG6r6bysEw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(30864003)(8676002)(44832011)(4326008)(8936002)(2906002)(316002)(31686004)(186003)(83380400001)(36756003)(508600001)(31696002)(66556008)(86362001)(956004)(5660300002)(66476007)(38100700002)(66946007)(6486002)(2616005)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRIQkdaZ21hcEdjSlZKQ1N6UGVxUXNiQ2xOSnJKYmppRFZDYklHS2crSFBn?=
 =?utf-8?B?QUM5UlpuaG5tVlBaMDlvaFY4ckNmMmFOM3Z3RVEySGVaMGo5bnNTb29BdnRu?=
 =?utf-8?B?ek5EMnVBM1Y0Mnc1cnRERm9hcExydWtLeXk5enZoUDc2Z0p4TkVrejlkeWJV?=
 =?utf-8?B?Ui81NWpCQWhXNm1vVjVxYWhGMHorMG9mRFJHcXdRRVN5LzVNZTZuY09ZTmNk?=
 =?utf-8?B?cjZmZTFQcEdqS2U1c3hIdW44TndJWXk2RFpkdUxQc3JmV0tCTG50eWozTVln?=
 =?utf-8?B?ekRpOFgrNUFqaDZyMnJoVzlVc0lsWE9yYmlWaFJzR1ViaFRuMXl6UHFGTFVp?=
 =?utf-8?B?ZEtQcTBkUXhzTE81eTV0b3kxbUpBMytvaUlMc1BuOVA2elJjRjNPVHM0dGlE?=
 =?utf-8?B?YVQ3RVZPTDlTclVUaWtHNGZyeXRJUTRHK0hGbEdLejF3eTdSRjIxVmMyZVFW?=
 =?utf-8?B?NlM4V0FLWjg3TWM2Q0lLL1BDeHZEOVNSdEVxckc5bVV5Q1JCbGN2MVJQZzVI?=
 =?utf-8?B?MGUyZnVhaHFRNHU0eDY2WnY2NkJFZ0tQQkxwK2Z6UktWT3dRSkVzRmU3SStw?=
 =?utf-8?B?aDVySnBNMWt0RENMdENFeERLVFJ2bGFNMzVjblF6MDdZeUNYUGRsaDN1M0dp?=
 =?utf-8?B?SjlMbjRNZFdmRllZcUw2NGxmZEE3NUc4K3E0aHdpeUV4ajg5VllCS0xxZHBF?=
 =?utf-8?B?MkI5aFB4ZHFXMWF0dEJtVDBmZE9tdHIva1ZIS1dIQWhsWG5raXUvYnkxdDd1?=
 =?utf-8?B?a0tzN0UrdHVaeHh1Z0lxQk1VNzJwOW41cm1ZZVQxVHpXbkZ3aGNhVGhVcFZn?=
 =?utf-8?B?T2JFOXREa2JvM3ljVlA2b3JvMWYyeVNjeXVhNGhqTVVWZ0U4MStITndZcDFi?=
 =?utf-8?B?RHZEUUsrQ0txRTFLVGpPWTRFYnVJRVd3Y3ErVGF6c1VuMVhPYUhyclkxRGVO?=
 =?utf-8?B?YzB5ZUorZ29pYjRocFh1MXRSVFVHQnNzV0VEUEhJTDBLdXlYOW5qQUwydUtM?=
 =?utf-8?B?TDQraWtaUXlhdnZZempQc002dFFDOFZNMkp1U0RScTBkNThzaU5ITDBRblVm?=
 =?utf-8?B?SDh4anA5WXluenVDakJoVXRZdVdiS25zSUdDdGE1cjR3WVhpYmZkTXFGWFhW?=
 =?utf-8?B?NlZML1RZSEd3TmZlY0lpRTh3cWlSTS9YbkNXYUxvT1BISWRyUHNSR3NwSG9s?=
 =?utf-8?B?eFZxQzhxZTZ4V21uNjU1ZENBQitmU2I1c2xQRHBGK1k0NDYwVjJLOWdvYVA3?=
 =?utf-8?B?OHBpMXJjOWxiVURPYWNJaUo3eGtVQjAwVFBpTGY3dHo1MmQrMTFzbmp5Vi84?=
 =?utf-8?B?YmxlZmtvQ21adzNjWHBmMlNHQzFLcWNabHlrMjU4eDJxNVhCbGZwWWlSaDRw?=
 =?utf-8?B?TkYzNmU1bHI1bTU1VWRzczJocytNT2d3bzRnZkRYak94MEJVOTQ0UVUwK0RW?=
 =?utf-8?B?WEllbHRFZHNlaGlUR2Fub0s3dXIyNUZsdGIxeU9YNzNaRm1nT015R1VlMldF?=
 =?utf-8?B?SllUNTRaeUVXV1JSZ1VNT3BNNzdId3Uxd0VDME1hWUdYWXVBTVcxQytqM1lk?=
 =?utf-8?B?VU1KaXovT0wwZmh5T1BuYXpiVDRTaGlkbVFVTUJtZmk4ZjhJNFRuS1c4eVZD?=
 =?utf-8?B?bUlkVW84WW1MVmRqL2lJVjhjamR1WS9wTVBqWGNjV0ZuNG1VNGpxVC84TG1k?=
 =?utf-8?B?ZlBDWDhnQkVMditGV1VpMkVvWnM1M2ZCMWM1KzJSdDZzZ3VtcEVtekVXZGNK?=
 =?utf-8?B?TFd0Y3lxRWhXQlQ5MXBsUzRreDFPRzZRSWRWWWdlSXNOUHgyN2IwRFhBL3dD?=
 =?utf-8?B?MXk1dHVUOUZNc0lRSE14YUE1MUxFWjdReVluNXJWNWlFMkxtb3VNR2UzbXRs?=
 =?utf-8?B?NFRXN3ZzMm9TQUtWQzFHeG03cGdXWTlLUXlnem5HSHpiZ3Bqc3o1QTc2WHJq?=
 =?utf-8?B?ckJKaTV2OWtiQ2RQdUFUbjRoUkN2Tm05WTFxajc3UWIxNDF5R0dxMVZlMXhC?=
 =?utf-8?B?ek16dDZIVksyQ1BkLzZ1M2ltUUlOZ3VuNGlJV241MExFN1FpQmRUUG1RMHdz?=
 =?utf-8?B?eVpHaEhpZ3BUa3V0VjU1aEg3TDhKb2Y2VVpkeUdwdExicGxtdWRDUndkREs1?=
 =?utf-8?B?TG1KR1FjVVA4eHBMNnQ5VUtVQUkwMGswbm5nWXE5aU5pYncwOVJUME1TbXdU?=
 =?utf-8?Q?b1kVbjwr89q79TC3eW5rLjU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2d2d9a-99e8-419f-baba-08d9a4662dcb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 16:21:41.5982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9N54xj3+PyhQbXqZU97xrYHahbDBuwf9EL8/yp81jPsj8NAp+LHyn7u48rc6+Zudc658YdORo+niL+j8YoXaEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
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
Cc: Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-11-09 um 5:42 p.m. schrieb Graham Sider:
> Switch to IP version checking instead of asic_type on various KFD
> version checks.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 27 ++++++++++---------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +--
>  .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  6 +++--
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 +++--
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 +--
>  10 files changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2466a73b8c7d..f70117b00b14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1603,7 +1603,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  	}
>  	mutex_unlock(&p->mutex);
>  
> -	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
> +	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
>  		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>  				(struct kgd_mem *) mem, true);
>  		if (err) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 19dd472e9b06..b6d887edac85 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1992,7 +1992,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
>  		sub_type_hdr->num_hops_xgmi = 1;
> -		if (kdev->adev->asic_type == CHIP_ALDEBARAN) {
> +		if (KFD_GC_VERSION(kdev) == IP_VERSION(9, 4, 2)) {
>  			sub_type_hdr->minimum_bandwidth_mbs =
>  					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
>  							kdev->adev, NULL, true);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index ee813bd57c92..594dd28a391f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -848,23 +848,23 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>  static void kfd_cwsr_init(struct kfd_dev *kfd)
>  {
>  	if (cwsr_enable && kfd->device_info->supports_cwsr) {
> -		if (kfd->device_info->asic_family < CHIP_VEGA10) {
> +		if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
> -		} else if (kfd->device_info->asic_family == CHIP_ARCTURUS) {
> +		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_arcturus_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_arcturus_hex);
> -		} else if (kfd->device_info->asic_family == CHIP_ALDEBARAN) {
> +		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
> -		} else if (kfd->device_info->asic_family < CHIP_NAVI10) {
> +		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_hex);
> -		} else if (kfd->device_info->asic_family < CHIP_SIENNA_CICHLID) {
> +		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 3, 0)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_nv1x_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_nv1x_hex);
> @@ -886,14 +886,16 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>  		return 0;
>  
>  	if (hws_gws_support
> -		|| (kfd->device_info->asic_family == CHIP_VEGA10
> +		|| (KFD_GC_VERSION(kfd) == IP_VERSION(9, 0, 1)
>  			&& kfd->mec2_fw_version >= 0x81b3)
> -		|| (kfd->device_info->asic_family >= CHIP_VEGA12
> -			&& kfd->device_info->asic_family <= CHIP_RAVEN
> +		|| ((KFD_GC_VERSION(kfd) == IP_VERSION(9, 2, 1)
> +			|| KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 0)
> +			|| KFD_GC_VERSION(kfd) == IP_VERSION(9, 1, 0)
> +			|| KFD_GC_VERSION(kfd) == IP_VERSION(9, 2, 2))

I think this could be simplified to KFD_GC_VERSION(kfd) <= IP_VERSION(9,
4, 0) if it weren't for Renoir. I wonder if the exclusion of RENOIR was
an oversight in the old code due to the weird ordering of the CHIP_...
enums. Let me start an internal email thread to confirm.


>  			&& kfd->mec2_fw_version >= 0x1b3)
> -		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
> +		|| (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
>  			&& kfd->mec2_fw_version >= 0x30)
> -		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
> +		|| (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
>  			&& kfd->mec2_fw_version >= 0x28))
>  		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
>  				kfd->adev->gds.gws_size, &kfd->gws);
> @@ -962,10 +964,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  	 * calculate max size of runlist packet.
>  	 * There can be only 2 packets at once
>  	 */
> -	map_process_packet_size =
> -			kfd->device_info->asic_family == CHIP_ALDEBARAN ?
> +	map_process_packet_size = KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2) ?
>  				sizeof(struct pm4_mes_map_process_aldebaran) :
> -					sizeof(struct pm4_mes_map_process);
> +				sizeof(struct pm4_mes_map_process);
>  	size += (KFD_MAX_NUM_OF_PROCESSES * map_process_packet_size +
>  		max_num_of_queues_per_device * sizeof(struct pm4_mes_map_queues)
>  		+ sizeof(struct pm4_mes_runlist)) * 2;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 93d41e0b9b41..c894cbe58a36 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -250,8 +250,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>  
>  	program_sh_mem_settings(dqm, qpd);
>  
> -	if (dqm->dev->device_info->asic_family >= CHIP_VEGA10 &&
> -	    dqm->dev->cwsr_enabled)
> +	if (KFD_IS_SOC15(dqm->dev) && dqm->dev->cwsr_enabled)
>  		program_trap_handler_settings(dqm, qpd);
>  
>  	/* qpd->page_table_base is set earlier when register_process()
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> index b5c3d13643f1..f20434d9980e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> @@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
>  				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
>  					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  
> -		if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN) {
> +		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2)) {
>  			/* Aldebaran can safely support different XNACK modes
>  			 * per process
>  			 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 3eea4edee355..afe72dd11325 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -935,8 +935,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
>  	/* Workaround on Raven to not kill the process when memory is freed
>  	 * before IOMMU is able to finish processing all the excessive PPRs
>  	 */
> -	if (dev->device_info->asic_family != CHIP_RAVEN &&
> -	    dev->device_info->asic_family != CHIP_RENOIR) {
> +
> +	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 1, 0) &&
> +	    KFD_GC_VERSION(dev) != IP_VERSION(9, 2, 2) &&
> +	    KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0)) {
>  		mutex_lock(&p->event_mutex);
>  
>  		/* Lookup events by type and signal them */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index aeade32ec298..d59b73f69260 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -940,7 +940,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	void *r;
>  
>  	/* Page migration works on Vega10 or newer */
> -	if (kfddev->device_info->asic_family < CHIP_VEGA10)
> +	if (!KFD_IS_SOC15(kfddev))
>  		return -EINVAL;
>  
>  	pgmap = &kfddev->pgmap;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fafc7b187fad..74c9323f32fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1317,14 +1317,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>  		 * support the SVM APIs and don't need to be considered
>  		 * for the XNACK mode selection.
>  		 */
> -		if (dev->device_info->asic_family < CHIP_VEGA10)
> +		if (!KFD_IS_SOC15(dev))
>  			continue;
>  		/* Aldebaran can always support XNACK because it can support
>  		 * per-process XNACK mode selection. But let the dev->noretry
>  		 * setting still influence the default XNACK mode.
>  		 */
> -		if (supported &&
> -		    dev->device_info->asic_family == CHIP_ALDEBARAN)
> +		if (supported && KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
>  			continue;
>  
>  		/* GFXv10 and later GPUs do not support shader preemption
> @@ -1332,7 +1331,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>  		 * management and memory-manager-related preemptions or
>  		 * even deadlocks.
>  		 */
> -		if (dev->device_info->asic_family >= CHIP_NAVI10)
> +		if (KFD_GC_VERSION(dev) > IP_VERSION(10, 1, 1))

This should be >=

Regards,
  Felix


>  			return false;
>  
>  		if (dev->noretry)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 77239b06b236..88360f23eb61 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1051,8 +1051,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
>  	if (domain == SVM_RANGE_VRAM_DOMAIN)
>  		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
>  
> -	switch (adev->asic_type) {
> -	case CHIP_ARCTURUS:
> +	switch (KFD_GC_VERSION(adev->kfd.dev)) {
> +	case IP_VERSION(9, 4, 1):
>  		if (domain == SVM_RANGE_VRAM_DOMAIN) {
>  			if (bo_adev == adev) {
>  				mapping_flags |= coherent ?
> @@ -1068,7 +1068,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
>  				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>  		}
>  		break;
> -	case CHIP_ALDEBARAN:
> +	case IP_VERSION(9, 4, 2):
>  		if (domain == SVM_RANGE_VRAM_DOMAIN) {
>  			if (bo_adev == adev) {
>  				mapping_flags |= coherent ?
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index a4c0c929444a..641e250dc95f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1239,7 +1239,7 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
>  		 */
>  		if (inbound_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
>  		    (inbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
> -		    to_dev->gpu->device_info->asic_family == CHIP_VEGA20)) {
> +		    KFD_GC_VERSION(to_dev->gpu) == IP_VERSION(9, 4, 0))) {
>  			outbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
>  			inbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
>  		}
> @@ -1463,7 +1463,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  		((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
>  		HSA_CAP_MEM_EDCSUPPORTED : 0;
>  
> -	if (dev->gpu->adev->asic_type != CHIP_VEGA10)
> +	if (KFD_GC_VERSION(dev->gpu) != IP_VERSION(9, 0, 1))
>  		dev->node_props.capability |= (dev->gpu->adev->ras_enabled != 0) ?
>  			HSA_CAP_RASEVENTNOTIFY : 0;
>  
