Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9C2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 22:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFC761361
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 22:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AFC761361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC2D6E072;
	Mon,  8 Nov 2021 22:21:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8336E072
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 22:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcbizvduyeMLBybCNh83/0n9aTIrO5gcjMcQG6E+xLSzH/QbHLyWrirkuP1m1Dv6CUOKPkmKlLHPNBgpDYPEyCBVmYQQ8clQmyAbly+6jgERjV9ZIYlgUs2uxx2T/JF4QQZtzy9MtnfM0T9Tzo8pERwafR9lE/ev9aM1G9T4+zRp30YLZ6XdZN0YVfBwA3kSOaH9l+2nZut9Kvr36ceJmrxSxFcGSLgcbthHqff+RNW08MhBXyoEInA0TaI9lMWXb2PStPKpUbq6QAAOgWOcPKB9fEN8GXqC6bI6EgheSviv6qv0jQ2A53eclCxbxePgI1aK8tmgWN0LRjZrBohXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FzIGTlyF4AuUzPeWbd7+1lvBXDEWanrElPlqCUDj4E=;
 b=hu9KlD2F+S1XcAyANfdjOeMrnUs6FiMhDjVav00F3jxkRz59OXh3Weaxv65p2Qutuz7ngSGNn/MZeUQDftJLewZK+Cb+6iMChI6je/WeyDkO+2ostWb21sxccYLWSnZdIWFpQOF1RQehYGiWXIF+tNaGZtLwnipwLV/ZFUK67TjnmFqxTP2vctb3Z0MQ4hZg6DZlDfn1WXfN+CMQFxDTNxzIZBfwAClp/NfTrC/SLzvjARmaMwqCjz7yW2FXXIHo8eh9WQ2unzLmxgBMV+hUdrQHfohQKUc0GlmEpO+dR8fclQ9+tWsyav8z1AHivUSCyWRwEt+4yPXuwbDLxUc6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FzIGTlyF4AuUzPeWbd7+1lvBXDEWanrElPlqCUDj4E=;
 b=NP/IruYt5m76e6kkfMSQy0RJlVQYPq0wtdfBjWra0DiBd4SDkjz2anOFZzZbeNJ84cbP6M8Ryp7rbES+i/Fd9NB0f6rb2Ka7EtMHvYoaDj4vajL0Q1rH+mWflIEgr3zsXGXPxW3kuSLLctCFIt8w8gAJPzdAIvGLVL+0u/UDJrM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 22:21:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5174:fe56:1dec:1342]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5174:fe56:1dec:1342%9]) with mapi id 15.20.4669.015; Mon, 8 Nov 2021
 22:21:18 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: convert misc checks to IP version checking
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211105195805.2275921-1-Graham.Sider@amd.com>
 <20211105195805.2275921-2-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fff5912e-d652-a4de-fdd0-98d1eac7e0d3@amd.com>
Date: Mon, 8 Nov 2021 17:21:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211105195805.2275921-2-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 22:21:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a314115b-192b-44ef-e672-08d9a30615bf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5241:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52416994B1D1F6DC497A94B192919@BN9PR12MB5241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: We36gDkWJ3RygaF4aX7/ApPK1gkS+CZLKcD9GmKPQjvgCtGH6guZPA/QEEVsIdTRxGZULL1VDm6v7lI5BylQ4jS0OT5LvueYDHvWFVN5S5BKPFulgn0+4FnKgvLAWT+/QUTvBahfDgdaXF1oYA0BxXcedrdrnJf27bQuaKfdkcKSpOPCYJhOiub5SB2JRKOCkvMFHqQH8VwBXwHHnOw7Pbt95VLDTGiu+OPN+jyD01IP9EKxcPBe+6Uxy9jujiKYqKqi2D9iWFGacYzrjnf7v4U67+oAm0rrLk6o730N+9Ax/L9L6tauRv6hhp19j0gSiSFNN8jpqPVSh/TsIvQNeBRWTPTmjhVSY/LieR4ZEMKLKxXm4m5w+J/QXjl6Wj7BptDt7rkAotc08nJEjUTHZArIt91KAG0bG2mptyVFqqpYoe6vZ7kEoQCBBKEnMRNAPRJAZU9t4d/YI8n/RggoXn/FIR/isvZeD0D0Ek2/Ta1vr+8zdfiRCjhAeSsBUUeZ/eBhU9Q46arIOGBSbx87ty017FaHH76hC8HloeO364xmOSS3kOU1hiA4TTo9t26Oq9XCplnTzBoepPxi8sHWDWTyD2VeZ/TFuleidvPwwBxCEcuVsT/YsVYcdPhSk0gva+MoKVr1DnJXC2PyZ8usLkrcWQGyowy/ikw7W8Kx6DiE7Wh9d7gm5F8IqpQmweXj55Pisvlrf/wL2W6z/s1XzsVlR07miRR1mttCsCMyZOOmuJO58xbV/gXNvtUqMvuA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(83380400001)(86362001)(16576012)(31696002)(2616005)(956004)(36756003)(26005)(2906002)(44832011)(186003)(30864003)(31686004)(5660300002)(4326008)(8936002)(38100700002)(6486002)(8676002)(66556008)(508600001)(66476007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9NRWlaK3RYWXpxak03S09ZMDdoL1BMQUQ4aHFhOUdYYXF3czlJTHFlSEhP?=
 =?utf-8?B?TDdRdEJsTlhCMlBrY1lPZk92QllVWGJWWHpBT3duZU5yVmdxWlljRGlyUTIv?=
 =?utf-8?B?SWZzemFTN0twWkpPeXlCS2V2MWlra0kzYXFQQmx2YW0wRENqblZTQXFtN0p3?=
 =?utf-8?B?R3JSRENyVzdEdDB6ZERxMzlZNGhYcGN4aUNEYmt0QmdzbGx5NEFHeHJ5U0lF?=
 =?utf-8?B?ZjhkTGliejJwbCtoeTQ1Y2xuUGdNTXJLa2J5T1NkR2x5SHdaRG1aMm1ZbkN3?=
 =?utf-8?B?RHpPbS9PNDQyc3dzVHVBU1BsMHFoTE5xVDBpQkRIenpzZ0tFSDBrNUlyRld0?=
 =?utf-8?B?ZHE5dGtlM25KZHhhbXJLUWhVaXd3cVpzQlp5cUVjVnQwQWVZTFJLVzhyTVNO?=
 =?utf-8?B?Q0RHN0hwZWM3YmhuMytXNndMUDNiNHVwZk5XK1hKdHNiS3IrRGNHdU4wdGVT?=
 =?utf-8?B?eHRVL0ZscFRTVG92ZUxIdWcyVnJyRmVKRjUrdDIrNnFTWGFxUkRwYVh2RzRa?=
 =?utf-8?B?M3g0UlhrN1F2OTdYNnRHZERhNnpidEtMOG5KR3czUEFPWXV6bVlISXJDbytz?=
 =?utf-8?B?Ny9SNUR6RmVIcHRycHhRMG5PdmdnWU1uYWhpQ1NEWlRmNU1qQ2N2Yk9TZEtH?=
 =?utf-8?B?RWVFYmhHQ05tZDBOYUdEanIxSi9YY1lYNnhueXdvQU8yQ0hBYW80Y3hEOW41?=
 =?utf-8?B?TzVqaDhJelBmWDJmNFluSExUUFRPUWNjZGw3aHBIdG0rSC9TSkVqOU8yaDg4?=
 =?utf-8?B?bWJZcVJrVUpsTldRVElSK1F6dmR5UkxpVVFJSVlNU0ttYnlLSkF0d05QVlRm?=
 =?utf-8?B?SEc1NGVIV1BUcUpyWnZXRFNUTWJHbHRibGlOVldaV090djMxY2FwWFY4QnFu?=
 =?utf-8?B?K3JrcGFYRW1mZ25mbS84M3ZRRVlSTzV6K2VMM3EyMDFuelJVaXZxQnlLZVAz?=
 =?utf-8?B?eks3RkIrNjhjMHRhdEFmRUlnbVZCOVNFSVFNcUxBNStac0hwMS9vN0RxM2Fx?=
 =?utf-8?B?UWtWQzdwNEdtcUlIRURhYzhIdTNFMk50dGJZOXRtajB5TTFyOXJvc3prVzN5?=
 =?utf-8?B?elVFRXJVamkrOWJRK2R5UXhkZG5xczYzajd2ODFJWEFpbmtWc3hqMjBMUUhr?=
 =?utf-8?B?dHNMdDhzVUp0b3F1bmFIYWV4SU16dlBpTitwR0xvbC9NMDRtejNqdUZUSmZn?=
 =?utf-8?B?cjFwUjF5UURHajFTQ0t4NlI5emhLamxrak0wSmk4emhTdllGdVdLLy83QzU2?=
 =?utf-8?B?UDJpR3VXU1E2T2JWWVFxbktkc01rN1VEVlk2ZDdmbzRaajVHYnZZWC9JeE5S?=
 =?utf-8?B?N2pjaTNKOVp6aWh1MXI2UG1ubndWcCt0a0JFZk1lNTVlek1ENzMwb2Q3MDhz?=
 =?utf-8?B?bjZkaE85NG5iajhLUUNaS1FuNk1tQ3QyT1dDSml3TVhVL1huU1VQZW0zaW1P?=
 =?utf-8?B?WVNidE1TdFhZNC9KRVI1RlJyTU03bEhhTjhXT05XK2tmRFhyMFVpZnlGQVhR?=
 =?utf-8?B?M0gvWjhKVm1vQUZrUkRnSTFyWHJoRjFBQitPNzV6SWh0UVE5SWdIcFk2Mldx?=
 =?utf-8?B?czI2UzBiYmlIY0tPaSs5VDdvTFN4RmRMWEV4RVA1b2FmM2gxM3BlZklFTDNz?=
 =?utf-8?B?T3VGWVlGQzdHVkl0ZnF6U2RIRXRTcUYySDI3V1dyNlk3dVMwOXA0TTlrTVNw?=
 =?utf-8?B?TFdTc3lDSXIrRk95V1R3NE82R0RzbEpuc29TTXBKWk5qUGpwQUUzd0N4and6?=
 =?utf-8?B?SEZMM3Z2eTdTM0g3UFZqWXdOREZoVExvcDJtRFZLeTg0eFpyV2ZnUXFVdVFD?=
 =?utf-8?B?V3Z0cGpvSUNyUFQ2Vk0xR2VwRitwSTBZcHVOWU1xcFJOWlBvbmJTdUNYRVZS?=
 =?utf-8?B?dnFMNzRDZHJlUG9rYVpMbmtJeEZwR2FJTTUzMkZsaXBRWnlNVXZpMGlndWEw?=
 =?utf-8?B?WnlodnZoREEySWQvcDZaWUFKZThqN2hpMFQrNFBSaHk3V0dyMk1LVnRNalZM?=
 =?utf-8?B?TVFHY0xBSnVaRlZHT3d1dkNBOTJjSjhMVjQ5SHFmYkVtSUFuL3h6YnpONlFv?=
 =?utf-8?B?d0JEQ1d4elZQM2o1K2pjNzhzblZmK0lNbGVoSnpMTWgxOUZDWHhCV3JiWXlN?=
 =?utf-8?B?cks0QmFualJoR2ZtYWVQUy9MMHp1U0N2dTYyWEIyNGNqZENTazBRTWpxUG9Z?=
 =?utf-8?Q?eiQGcqxaSQ4OWLcgMrOoXhg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a314115b-192b-44ef-e672-08d9a30615bf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 22:21:18.1357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv118qmE6D1vdhK42JURlcDjiEOIQjoyIRVJwmb5MHAQ9lZ/tS68+dwwcLkDDu3lYxSzQLjKjLiYd9oyrJjspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
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


Am 2021-11-05 um 3:58 p.m. schrieb Graham Sider:
> Switch to IP version checking instead of asic_type on various KFD
> version checks.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 24 ++++++++++---------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++---
>  .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  6 +++--
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  8 +++----
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 ++--
>  11 files changed, 35 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2e3d74f7fbfb..f66c78fda5be 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -321,7 +321,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>  	/* Return gpu_id as doorbell offset for mmap usage */
>  	args->doorbell_offset = KFD_MMAP_TYPE_DOORBELL;
>  	args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
> -	if (KFD_IS_SOC15(dev->device_info->asic_family))
> +	if (KFD_IS_SOC15(dev->adev->ip_versions[GC_HWIP][0]))

Given the way this is used, you can probably change the definition of
KFD_IS_SOC15 to take "dev" as its parameter. It saves you some typing.
Or better yet, replace it with a more general macro you can use in the
other places as well:

#define KFD_GC_VERSION(dev) ((dev)->adev->ip_versions[GC_HWIP][0])

...

    if (KFD_GC_VERSION(dev) >= IP_VERSION(9,0,1)) {
        ...

Regards,
  Felix


>  		/* On SOC15 ASICs, include the doorbell offset within the
>  		 * process doorbell frame, which is 2 pages.
>  		 */
> @@ -1603,7 +1603,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  	}
>  	mutex_unlock(&p->mutex);
>  
> -	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
> +	if (dev->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
>  		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>  				(struct kgd_mem *) mem, true);
>  		if (err) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 500bc7e40309..b41e62a324f6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1992,7 +1992,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
>  		sub_type_hdr->num_hops_xgmi = 1;
> -		if (kdev->adev->asic_type == CHIP_ALDEBARAN) {
> +		if (kdev->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
>  			sub_type_hdr->minimum_bandwidth_mbs =
>  					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
>  							kdev->adev, NULL, true);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b752dc36a2cd..29f8fcd4b779 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -844,23 +844,23 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>  static void kfd_cwsr_init(struct kfd_dev *kfd)
>  {
>  	if (cwsr_enable && kfd->device_info->supports_cwsr) {
> -		if (kfd->device_info->asic_family < CHIP_VEGA10) {
> +		if (kfd->adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
> -		} else if (kfd->device_info->asic_family == CHIP_ARCTURUS) {
> +		} else if (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_arcturus_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_arcturus_hex);
> -		} else if (kfd->device_info->asic_family == CHIP_ALDEBARAN) {
> +		} else if (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
> -		} else if (kfd->device_info->asic_family < CHIP_NAVI10) {
> +		} else if (kfd->adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 1, 1)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_hex);
> -		} else if (kfd->device_info->asic_family < CHIP_SIENNA_CICHLID) {
> +		} else if (kfd->adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_nv1x_hex;
>  			kfd->cwsr_isa_size = sizeof(cwsr_trap_nv1x_hex);
> @@ -882,14 +882,16 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>  		return 0;
>  
>  	if (hws_gws_support
> -		|| (kfd->device_info->asic_family == CHIP_VEGA10
> +		|| (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 0, 1)
>  			&& kfd->mec2_fw_version >= 0x81b3)
> -		|| (kfd->device_info->asic_family >= CHIP_VEGA12
> -			&& kfd->device_info->asic_family <= CHIP_RAVEN
> +		|| ((kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 2, 1)
> +			|| kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0)
> +			|| kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 1, 0)
> +			|| kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 2, 2))
>  			&& kfd->mec2_fw_version >= 0x1b3)
> -		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
> +		|| (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1)
>  			&& kfd->mec2_fw_version >= 0x30)
> -		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
> +		|| (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)
>  			&& kfd->mec2_fw_version >= 0x28))
>  		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
>  				kfd->adev->gds.gws_size, &kfd->gws);
> @@ -959,7 +961,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  	 * There can be only 2 packets at once
>  	 */
>  	map_process_packet_size =
> -			kfd->device_info->asic_family == CHIP_ALDEBARAN ?
> +			kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ?
>  				sizeof(struct pm4_mes_map_process_aldebaran) :
>  					sizeof(struct pm4_mes_map_process);
>  	size += (KFD_MAX_NUM_OF_PROCESSES * map_process_packet_size +
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 8a39494fa093..7cadcdd9ffd2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -157,7 +157,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
>  {
>  	struct kfd_dev *dev = qpd->dqm->dev;
>  
> -	if (!KFD_IS_SOC15(dev->device_info->asic_family)) {
> +	if (!KFD_IS_SOC15(dev->adev->ip_versions[GC_HWIP][0])) {
>  		/* On pre-SOC15 chips we need to use the queue ID to
>  		 * preserve the user mode ABI.
>  		 */
> @@ -202,7 +202,7 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
>  	unsigned int old;
>  	struct kfd_dev *dev = qpd->dqm->dev;
>  
> -	if (!KFD_IS_SOC15(dev->device_info->asic_family) ||
> +	if (!KFD_IS_SOC15(dev->adev->ip_versions[GC_HWIP][0]) ||
>  	    q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>  	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>  		return;
> @@ -250,7 +250,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>  
>  	program_sh_mem_settings(dqm, qpd);
>  
> -	if (dqm->dev->device_info->asic_family >= CHIP_VEGA10 &&
> +	if (dqm->dev->adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 0, 1) &&
>  	    dqm->dev->cwsr_enabled)
>  		program_trap_handler_settings(dqm, qpd);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> index b5c3d13643f1..0f7471796667 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> @@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
>  				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
>  					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  
> -		if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN) {
> +		if (dqm->dev->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
>  			/* Aldebaran can safely support different XNACK modes
>  			 * per process
>  			 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 3eea4edee355..20745086308e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -935,8 +935,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
>  	/* Workaround on Raven to not kill the process when memory is freed
>  	 * before IOMMU is able to finish processing all the excessive PPRs
>  	 */
> -	if (dev->device_info->asic_family != CHIP_RAVEN &&
> -	    dev->device_info->asic_family != CHIP_RENOIR) {
> +
> +	if (dev->adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 1, 0) &&
> +	    dev->adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 2, 2) &&
> +	    dev->adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 3, 0)) {
>  		mutex_lock(&p->event_mutex);
>  
>  		/* Lookup events by type and signal them */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index aeade32ec298..c376c43a6c16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -940,7 +940,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	void *r;
>  
>  	/* Page migration works on Vega10 or newer */
> -	if (kfddev->device_info->asic_family < CHIP_VEGA10)
> +	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
>  		return -EINVAL;
>  
>  	pgmap = &kfddev->pgmap;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2a5b4d86bf40..013678fabc0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -183,7 +183,7 @@ enum cache_policy {
>  	cache_policy_noncoherent
>  };
>  
> -#define KFD_IS_SOC15(chip) ((chip) >= CHIP_VEGA10)
> +#define KFD_IS_SOC15(gcipv) ((gcipv) >= (IP_VERSION(9, 0, 1)))
>  
>  struct kfd_event_interrupt_class {
>  	bool (*interrupt_isr)(struct kfd_dev *dev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index f29b3932e3dc..f260f30b996c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1317,14 +1317,14 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>  		 * support the SVM APIs and don't need to be considered
>  		 * for the XNACK mode selection.
>  		 */
> -		if (dev->device_info->asic_family < CHIP_VEGA10)
> +		if (dev->adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
>  			continue;
>  		/* Aldebaran can always support XNACK because it can support
>  		 * per-process XNACK mode selection. But let the dev->noretry
>  		 * setting still influence the default XNACK mode.
>  		 */
>  		if (supported &&
> -		    dev->device_info->asic_family == CHIP_ALDEBARAN)
> +		    dev->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>  			continue;
>  
>  		/* GFXv10 and later GPUs do not support shader preemption
> @@ -1332,7 +1332,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>  		 * management and memory-manager-related preemptions or
>  		 * even deadlocks.
>  		 */
> -		if (dev->device_info->asic_family >= CHIP_NAVI10)
> +		if (dev->adev->ip_versions[GC_HWIP][0] > IP_VERSION(10, 1, 1))
>  			return false;
>  
>  		if (dev->noretry)
> @@ -1431,7 +1431,7 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
>  	int range_start = dev->shared_resources.non_cp_doorbells_start;
>  	int range_end = dev->shared_resources.non_cp_doorbells_end;
>  
> -	if (!KFD_IS_SOC15(dev->device_info->asic_family))
> +	if (!KFD_IS_SOC15(dev->adev->ip_versions[GC_HWIP][0]))
>  		return 0;
>  
>  	qpd->doorbell_bitmap =
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 065fa2a74c78..3be0ccb7a880 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1051,8 +1051,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
>  	if (domain == SVM_RANGE_VRAM_DOMAIN)
>  		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
>  
> -	switch (adev->asic_type) {
> -	case CHIP_ARCTURUS:
> +	switch (adev->ip_versions[GC_HWIP][0]) {
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
> index 5353f43c67f3..27c4d2599990 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1239,7 +1239,7 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
>  		 */
>  		if (inbound_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
>  		    (inbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
> -		    to_dev->gpu->device_info->asic_family == CHIP_VEGA20)) {
> +		    to_dev->gpu->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0))) {
>  			outbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
>  			inbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
>  		}
> @@ -1487,7 +1487,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  		((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
>  		HSA_CAP_MEM_EDCSUPPORTED : 0;
>  
> -	if (dev->gpu->adev->asic_type != CHIP_VEGA10)
> +	if (dev->gpu->adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 0, 1))
>  		dev->node_props.capability |= (dev->gpu->adev->ras_enabled != 0) ?
>  			HSA_CAP_RASEVENTNOTIFY : 0;
>  
