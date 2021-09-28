Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B05CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 15:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97A76124A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 15:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E97A76124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD626E0AB;
	Tue, 28 Sep 2021 15:42:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1076E8AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 15:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNhGXQGrcPLVGCe2ok/bNc+yoZYGTr2JLtubU0ypzJQCTanCKvlPDt/w9zMRtdSxqLt7uToINmWGBlpHz3Mpc4AUcXD+GFq2CfT/j3OPhIB4vZJ29O8oKISg+U8bXN8a4KNiRx1o9lb06+qzSIi9QozvnV3eptauD5nlrgV9TorCbASNOATth/HT/wcGcKmJ1OBOR9pWT2OgDXQ0uc1fQ0ML2uYlYb3gRLEUv0G/5xdL0k2eg5ItyrfTjfpHCILP4hj4D7qpZtRmEloFozf55/xAX7IIVrr3vGFBVpXd5pNqlXXArYztM3IjZ+FrxMG2nhuGkSOtxyyD6g1dTvYwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=gwcgbvf71x8Q/tyYHaPkTMM2wby0kr4GD8xkhK0g5Bo=;
 b=Lqx2ps7ZmDXC9LyFf0X3JXQhWC8+bcbjfA0fQ7b9IMJ9c5Kb0bu9IevwJ5gWEtm80kJ9/G5cBv69SONM52t0jw6JHVfPT7EF0zlLIOySTe2VsZjcmC0Uo8vipEm5Wk9wSeTOzgWycEihhz40WQtMeMdK859uHdb/YslUenZsh4meGNUa2HyhS/yj4Aupq4J/314IVx/xgXLWgeYh9Hov1S/ymkwOagadYmo4qvOSSXwQpMueLOJxEAe/eudLc+eBqparj8uOdq36qGjIA5ewQtKDc58qpATKEAPCNnYnrDVZ9RsUPxlvQC5gr81nQVIjRrDfLF/NSPbsr93faNojyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwcgbvf71x8Q/tyYHaPkTMM2wby0kr4GD8xkhK0g5Bo=;
 b=1vWJJ/1+k4BwF34HVxY4oludWeZgMIzYxtVd1TYsahEvj0cj5ttJr7fWW/zhM6BdGz+8f6N5wnJHaxtrPjffpQgcTAcYf/kJXWjIf9k+fsqkGKIcdiv2DRX9E4IC9+D6UpOdAe8v4z1Svp5axuHIjXNyLPI2Vx8aWpTCaMHKpWM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 15:41:57 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%6]) with mapi id 15.20.4566.014; Tue, 28 Sep 2021
 15:41:57 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 James Zhu <jamesz@amd.com>
References: <20210928082819.205231-1-yifan1.zhang@amd.com>
 <20210928082819.205231-2-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <11cc6ad8-5c08-6846-930b-f935c1e29936@amd.com>
Date: Tue, 28 Sep 2021 11:41:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210928082819.205231-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::6) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 28 Sep 2021 15:41:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ff33e26-4174-4cce-c746-08d98296811d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5179A90ACCCC68A0D971FC7592A89@BN9PR12MB5179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuWYvDOyYgFjAqKPU3u+ecedQH/QFxaMqG2l9Vl91E/WTuqex5bK+ePdbeF0DqIZN0q6M2za7ji+jcnYhFXEq8Ug1gIk2wzu4HJopA2fqpoKp9oc4gxtbAXsRjSEkDGtvD0M059+SdJsAuP5SznRKu67epg8jshIhnwhHz6HWIzD7YeARq07Ax6VNnWfsWQMf+R8gTzIecb3c01jUmi0GeNO+DAmfejIP0KJYQsSkFfyIOF7ITmhq/Ztno4GqPN3XIHvVeQTKIIJAh/bdTLNB22haoKYlL7iU5TvxY9vCuuGCuEcYZ4M0aYYl0fcibAyMiXcgHsfszjAlVax0XHnrO+7w8QuFvEZ2BCg8SMDKGOKZ/ld8epX0oPG5+cswZw+0q0CWXhlyaO+QMDXX5KubwqQ9daWXMBEabmSQ/BhQorxXL8oyhgOmCWv1dNiNhocMu6oj6oFvfulXWN/VXTupl6YOjq2ptpWhXIUYpOCsIBzrOl2tKi01qq6S4zuaQrNo3q3GQEHVVNZBFwCv1YXb1z7vWppamIT2fQTtd4E9UJwemQZg2VAKeIZ3813QzXuJBpVow1YI0EwWBdUjp70invaKQMSMC0eD5LnNXi/GTHzFhdYYkxWJukgvSWIkU/z5v3i4gjnDVH54jwjtlTO2hYC73DqXFuodWtwdACKPI8t35miGa/4VEMv4ILblxScJzt5+gT3fdyVo2aS0SsZ931ZkppSOu7nbfyi3dGbERI7Z6XooOVh5HLP+cmWItip
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(36756003)(86362001)(31686004)(2906002)(83380400001)(956004)(2616005)(66476007)(38100700002)(316002)(6486002)(44832011)(66556008)(508600001)(5660300002)(16576012)(8936002)(110136005)(186003)(26005)(8676002)(6636002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGl5YWxrRVlZTnJJQVdxMVk1T0tPdlpSY0JmeURZNDYvbEVrdmp4WGNMRHRw?=
 =?utf-8?B?enFkMDVNTGFSbW5ka0hkZjBCcUJLQ0FXSzdwQWdNa1N3bE93dUs4YUNRRzZq?=
 =?utf-8?B?UTdLNHpneitxNUVpenp3aFFDTE81V1kyOUJHWnZlamorM296N1R0ZkRlRG1n?=
 =?utf-8?B?ejR0MFA2SkdWTDJKRGVvekUxdWpySnRDZkZ2dndVQ3lDdlE2UnRtd1hoTWhs?=
 =?utf-8?B?WDh1WWxjZ1ArQnRCbWtjU1R2WVM0NGw1NE9VREtWbmZHQitMYW5ZSDBnK3A5?=
 =?utf-8?B?d1locUtaVWsrT0c4S000b0EwUTFiYmx3NElLVDlQQ1hLNStEakhDR3JTZ3hj?=
 =?utf-8?B?V3ZUYVdXZ1d1MXhNRlFhdGJEeXdBcEJtWFo2MU9jL29yd0FQK3N4d29ieVNB?=
 =?utf-8?B?dHNMOS9TaXhVWG9tc1VlWXZWdU44R3FITTliYzF5TStCckNPb3lCV1IrOFE2?=
 =?utf-8?B?VzU1MVFoTXNIMi9TdVVFUzBSSE1nbjVrN0hldURuZTM4SnpNSUhoR1c1M040?=
 =?utf-8?B?ZXlhU2xRVFdpdTUxalpYTnJENUpDODlCamhOZFJYQmJxSGc2NGVuTWFJQ2Q1?=
 =?utf-8?B?TzlIbEJFYmN5Y1ZFOFJqQTNTN0tVN0Rja04xQmpCd1kzYmM5QTF4cS91RUJs?=
 =?utf-8?B?NlNtMDQrZXZ2MzFrQ2c5Umdvc3VvQVRxb1ZRSm5RM2pNdC9VWkZ3Vjc4RTZZ?=
 =?utf-8?B?aHRka3E0ZHVXV3c3WW5DV21NVzF4RUlsRjV5VWJQYlIvR3JSYVY1SHlpWENw?=
 =?utf-8?B?TjFFaTNwUkNPNlROTjN2VlNyamg1azZWekF1d1FKOStVYm0xNHB4OUNxdmRm?=
 =?utf-8?B?R0VRSDJEYjVZSi9VVFBlYUxpVUx5Vnl2N3BJNFlLZldpK1pCQ3hMRU5XZW5n?=
 =?utf-8?B?dE5UVVdjMW41S2JXRzJ2cXgzVllvTkYwTTYrWTNUS2Q2MVdHdHo1RUlQdm01?=
 =?utf-8?B?eWdVM2ZYNDAzZ0pSVnJFZ01ZUmkrRFhZZFZPc242ZFUyZEdVRHZseUgwcXdx?=
 =?utf-8?B?TjZSYzlPNnVqdUVwYkRiZGg3ZVFCY3dNa0xQcFZiMVpIRlRaS3QvQTh0N2Iz?=
 =?utf-8?B?Rk5FNGM0RDlRUm41d1AvUjBBdmoxcC9sU1h1QnNTNE5uZGZPanBUQ1VBMGFP?=
 =?utf-8?B?S0Fmamd6cmJxWXVuR1FBK3l6U2pFYWRmd05saVV3UzNRMzZDWVNMR1hZREw3?=
 =?utf-8?B?eTIvTVFub3VQdkVUdndjMWhDbExuODBzZk13MTVySzhsM3JqdW5tYjZhMjky?=
 =?utf-8?B?dEg1M0M1MXZDbWdBcTA1OTFYZU9hVjVuNHNjUkVINlJJUnRNNHBySjZiQnBC?=
 =?utf-8?B?OTI0bUJickwvVm1SaUM5NDQyRGwzK1ZOc0wwU3lxVVZRbXJ6aWtCaW9CMUJB?=
 =?utf-8?B?NTJockdjVGo0K1QxNGN0WkpyTFhXeC9UcmNjR2pxWUlNV1RYY25ObGxYNnFI?=
 =?utf-8?B?d01HWGl6REJVdXVEa01wekE3YzZDck4ybkJ6UE93bWxxQ3NWZFBKL2JiSXph?=
 =?utf-8?B?MHI2cWFBTWNMbmpQMmpIa1lLWGdVcWhtVW9tR3d6ZVZKd21JTDQ1clg5cjA2?=
 =?utf-8?B?TDloUWwvNHptZGZSMytKOFdXRk1wcjNtT1hQbVNtYlNhM1RWR0pQYStwaUZh?=
 =?utf-8?B?cUR4TUlWRk1qbERGeHJZa0FvS0xsdTFydXpGZU02b0lDN3RHeWNndFJzbzd6?=
 =?utf-8?B?ZWRRZXd2SnBKQmxldjdGT1EvR1pnOE9UWEhnVXgyL2ptQVdJNDdlZSt6ZkpS?=
 =?utf-8?Q?iepOmW1TjdFzJYqBYfJlgVkPaHCAlVAs57/XZkB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff33e26-4174-4cce-c746-08d98296811d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 15:41:57.4465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+MNxz476+atUDUb4MeYUYXx8QXRdtd4bAj9ZHy24dKWSsjC9yEEuCWZGSy7lpTCrXxmRxImLbAi+n1wL7n9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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

[+James]

This basically undoes James's change "drm/amdgpu: move iommu_resume
before ip init/resume". I assume James made his change for a reason. Can
you please discuss the issue with him and determine a solution that
solves both your problem and his?

If James' patch series was a mistake, I'd prefer to revert his patches,
because his patches complicated the initialization sequence and exposed
the iommu init sequence in amdgpu.

Thanks,
  Felix


Am 2021-09-28 um 4:28 a.m. schrieb Yifan Zhang:
> This patch is to fix clinfo failure in Raven/Picasso:
>
> Number of platforms: 1
>   Platform Profile: FULL_PROFILE
>   Platform Version: OpenCL 2.2 AMD-APP (3364.0)
>   Platform Name: AMD Accelerated Parallel Processing
>   Platform Vendor: Advanced Micro Devices, Inc.
>   Platform Extensions: cl_khr_icd cl_amd_event_callback
>
>   Platform Name: AMD Accelerated Parallel Processing Number of devices: 0
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4c8f2f4647c0..89ed9b091386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	if (r)
>  		goto init_failed;
>  
> -	r = amdgpu_amdkfd_resume_iommu(adev);
> -	if (r)
> -		goto init_failed;
> -
>  	r = amdgpu_device_ip_hw_init_phase1(adev);
>  	if (r)
>  		goto init_failed;
> @@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	if (!adev->gmc.xgmi.pending_reset)
>  		amdgpu_amdkfd_device_init(adev);
>  
> +	r = amdgpu_amdkfd_resume_iommu(adev);
> +	if (r)
> +		goto init_failed;
> +
>  	amdgpu_fru_get_product_info(adev);
>  
>  init_failed:
