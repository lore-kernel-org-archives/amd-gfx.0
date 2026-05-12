Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9661CCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 10:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEAF10E263;
	Tue, 12 May 2026 10:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NtGTU6Q0";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B54D10E263
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 10:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op0deqAJsdq6JtU8ogEVoHt18YkOfRsblzXCf8P2G482no3MaHzgPDzer19vmCP4zqtQjyLAl4ZHL5Gf5xSe1/oSV3sqc92a9hGvKjyHz4VIhF6D5Xl32CEUgHQB+wg8ZLGjHhy1t23R/IHnlwtkRnlm5ATY1lkCME8PjJAHa4BKDDn2JjMrwAGmltl3ss/P+7VTQgDe1ioyLLSvkf0vBMZMaUgkYdd0df0e0W6D21RFcTZ28ckKw0W0X1M1cBdqdAifiOj6cBf0QhRHlC6uHeK97Y3RcZrS8UyYHlK6J3PiGW3g+BvAEcKOHyfxgsMuKfVzHurljDOSrs2AfF+PSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7UOPq1mtolziKghaYFfQs+R32LoqVzrffYFRg6usho=;
 b=SD+UqfomAVfxjEYJ1HBKgiyICsV7dtAcnnyKn0KMA+j92kVMkphmp0OCDIscGmWerGx3hySHNQ6aRC9o0rTWVmcxhD0/y1682l87OmAioM0kvCpMQaEOj0wNP5xPjeb72u7oK3zoWanJQc4GJ+RI88yk3l+1GHULgaCU+s+sPKzTLoT/bxecFwUoZHtShWkdvmsYsDm/YjOs8d2weezAvlMEDGt4Gcfw+n9acf3LEZH5hj3hmHMo50C+GiGtKU1F/T3Ud5HMapo50DsgNHsoNnRiiqWm8Dlo2Udt+T+nL+V3oMpXx6K668hPqfzDVfM6lAxjxUg7t9rY14ynZ+RnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7UOPq1mtolziKghaYFfQs+R32LoqVzrffYFRg6usho=;
 b=NtGTU6Q0ga9AgjjNm9+5YjCA+1OwGvU4n5X33FmNLqyiGnmFmw9vAg57TchysSSoVaDe2jpICQGqN3zu+3wT5uvlhvgvBoLjO3N26LuV0KMKbIKf6DcI/jTzzMhl1swq5A8jrdegJE1TH5aqjcQIFcKY0e2ZQkyjSw7a/BrFPsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 10:54:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 10:54:31 +0000
Message-ID: <e27e3d07-b971-41e7-84e4-4a1178c7e3ea@amd.com>
Date: Tue, 12 May 2026 12:54:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/userq: update the vm task info during
 signal ioctl
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260512105143.1017809-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512105143.1017809-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:208:237::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ed9b4a-2455-48aa-3c64-08deb014d8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: ze13N0NTC5Jf8TxcamGe5pzTXYHYo3u5chyLscPHdo2o+YF8BI2d3A8jXqnItLWgv6XXfnmJ3KQXasqcesdhPUJ173oCMnsBWLCvAKriPJVY56wlY89upuDYPZ1cuCA4xGDTYP9canNS2xDExSUKMo5pjCZMwcsmlBS/aNILR0zUxN7kOh394l7bX/K0XU/fN9HHyaoS83RmWUAb3e7bTYHFeSFp1tkmNaiIF/R0snzT1eaG9OMOA9BcfrOvqCxTUgn+UaSbcNYp4ziAZ+vKhjNwgPdM+PCqOLm+Cel7pG96GoS2uSkBN2OwqJaEzyy4mejtp0NcQzdYbnsPwn8Q/OZaAArbskd1aj6cinwVayUCxaEzGKuuqLTtwDIQnvhwOm055ZVvn9US4d1Uow1zoZzV3G7dUPvQuRPD+WMJnTmmSQ9wYUteXlutBormQVXbsEYk8wZyCL/oFV2quayLr1v4IQpAJUotRSyNbPnyc+77a2MnpAvICL8/qGU6jtkDK8VaEA9IzgsN/l7V+9fKlcoJKMhdQx5cRiyMqA8PMhGFECVzQL/VxEeReo1xuLM7lqRhSnmPXrV0vQ3dJ3JobaFQeWBI4kE0Si0Wblf/B/9ARATJ0zQGiKVZkj/Lp9aMDOGC8W6IYPNsBjBjervGI80tkePQjPSUkm5XxhgzviK3OZy6+JD2v2K1rUc7SsaX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNyVTVmRnJwZmlxUlU5UVRRU290TjlUeDZETTdEajUxVGJUc05Nc3l0aWpQ?=
 =?utf-8?B?bTl1Vm5mNm5CZ04xaFRDaFNzSk41UHdEL21xTDZVM2ZjanVyUWQybm1mc2tr?=
 =?utf-8?B?TVc4b2JSMHJpVlZQZytGV2xjRWRHVXd2M2hOY3hiYUI0M3llNENXUTF1MVRZ?=
 =?utf-8?B?RzN0WmdPNzZQSWI4VDhaZ25OaXhMeUcrZWluNWxnN0psaUlGSENQVXhvR2NT?=
 =?utf-8?B?bmdMYklrQzYrdllWQ0VtOWdidG5DdzRnaDVjVThmeEhaTTQ4NnFUWWgvbDI2?=
 =?utf-8?B?YjUxSDYydy9nZTVpTEFNSnhYV0VYbjJUV2ZkZjVHckl6M3IwbjBFMjVrRnVO?=
 =?utf-8?B?ZG1UVTVpRU9PZGovRzRqZkxrSCt5T2s3c3NJL0FObVg2N29pa0lCMHJRL3p3?=
 =?utf-8?B?RTVsemVYY21hQzVJWUhXMU1tNGc3ZU4xNUoxQVpxbDNtMDZNWkczWkRQZU5R?=
 =?utf-8?B?ZjlUZjJGL3NaZXUwWjROVVR2ZDR5WUZwWVBXZklXb2p5akQwM1FVem5OUWt5?=
 =?utf-8?B?aHVTTkNaenMrRyt0ZTh3SCtFZjlCdjU1bloxN1FyTzRoWThzdUFYVGxOZnNz?=
 =?utf-8?B?cEJmY3A4azZCMkFKYmg3YmVsYk1MRHdheWl1NEgrTUcvZFAwWnRacmFIeHph?=
 =?utf-8?B?RHVJNVUrbUY0c0xZM2ZENjEvbEVieFhpRWdmaW1CeWVzZFV5cFdvSytKRzA5?=
 =?utf-8?B?eE5WbVBsL3JWdFlVK0pqYVhoMXRRYzRFTHljK2tpWFppMDJGejQ5emlVNmxX?=
 =?utf-8?B?ZkErNjBubndvY0c5Tkd2bzVSaXlhQlhISVBwazVNYno2b2RVWGVSWXF0QU9L?=
 =?utf-8?B?encvUDdhd0pnMjRiZis4em9zVHRwdE5CK3lXS3B0MUFPZDNWT09Xd3JOQzkz?=
 =?utf-8?B?WDFucVZrUk1BVUNCRWVlN3hFSVp5RXBjWkc5NkhibnF6WllVL3lPeTZsTlRC?=
 =?utf-8?B?eWx1SUNRdW1RSFZURTRUdjRhcTZoMW5vdm9YcGtNdlBJUkVWVkJFK1Vzc2JU?=
 =?utf-8?B?RWhvaVYrQTJSR1lyUjVuTXBlVE81U0VlaGdMZURiYmg5UGVjVTlFK1pEL0k3?=
 =?utf-8?B?RlRuTnZuWXRjOHBGTTcxL0x1b29rcFlrcnhoa0tSTDAvSHhCOUxpTnBLblhq?=
 =?utf-8?B?RG0xcjFaTkoyM0lNRVNZSjNlZEdHWWxnelVpd1BQeVQ0VkZlREl0YnZrcWpS?=
 =?utf-8?B?Tm0vT2ZrQnRCcU95d2lsaThrenhqL3BMc1J3Y1hCc0ZQRE4yYlM5VzBIMjZy?=
 =?utf-8?B?eGZGRzlVdDI5ZHFSQmNBZzBZdzUrSHN5ejQwU0hmdVVCSnRacXdKRk0ySFIr?=
 =?utf-8?B?RTZ2SXNkdEFIQk5mN1BqdnFBKzFnVVpLYlc1cUJ5YXdGK2RnWUw2WVNadXJL?=
 =?utf-8?B?cnl6ZUZ2RytJeXE3M05aR0tLcnRKa2IvUjY0K0pUdnJhb0t4SVZRWVE4VUJ2?=
 =?utf-8?B?enBsdjA3YjYzRkdOcHBDVGd4TjJzVUZ2MzNFOGcvcVc3MjJZNUo1bnJYMlEr?=
 =?utf-8?B?MkdlT05hSzdJcE41dFNDK1dvOTFOOERaM2ZRbnpSRm5QNU5EeGpDamtGTEVV?=
 =?utf-8?B?TDBUcVVkOW81QzVYSlhzbGhhVXhUMVdYTkIrMW10emVDQzI4akJzbWVTSTZj?=
 =?utf-8?B?Qk12eFNOMXhCT3gvWTYxTHcvYnRBUHZRVEtIdXJub2Npd1ZmUkNTT01tMlVw?=
 =?utf-8?B?K0hoaG1yRlUxVWVDN2t1cnNJN2haQ01OdFk1ZXAzRGQ1cWk2Z05PUmNLS2Ri?=
 =?utf-8?B?ZzUvbmZva05iM0U3dmg1dmtJZXJlTnlvR29HRVZNdUlCbWtZLzM4c241VkVE?=
 =?utf-8?B?THFZZlFlM1g2UEJpR2pEcDkrRDFTK1hGcStSWUo2S2hORkJrVXhRdkJrUXhD?=
 =?utf-8?B?bmNvRnJUTCszMWg0YnFrejlIbEV1ZmRBRlRNRkZXck9DSWlSVy85QzB1M2ZN?=
 =?utf-8?B?bExTYnYxdXR4a2IxM2kwOEE0ZXFya29QZGhqTjVkZURDdkV6dnJ2TERzSEc2?=
 =?utf-8?B?RkIxZzQ0WWpwalQrU2tWNkRMcGhUaU5pOWtJVVFodU5QWCtqVWVrQ3NzS1JV?=
 =?utf-8?B?eXdhWlIySjVQbkYrcGptRmtRUm9VSVFxYnc3ZjVKVHRHOVZoK2ZMQ2F3LzhB?=
 =?utf-8?B?dHNZdG9QS3MwSTREV2pYMGF2aU4wbmhTUkYrdE0xemROM2c4aWZXcXJVa0xn?=
 =?utf-8?B?cmNsNGhTQ0g4ZTFBdTV6YWVsdnYzRWE0MWFScGwycTlXQ1BSQnVyb1ZUdzdj?=
 =?utf-8?B?SDNzQ3RnTm1OdHo1aEFhbklFdTJiYzBoeDFoeXE5cTRzdGJHRkVrU2lCV1FI?=
 =?utf-8?Q?VIdDOiWx4DK84ibumy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ed9b4a-2455-48aa-3c64-08deb014d8be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:54:31.8550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ln/zsmd3Hrv5URnNa2Js1aHTMR92kIc8chaas6fd32YZpbeKCmGyxiLZRa3RxWGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

On 5/12/26 12:51, Sunil Khatri wrote:
> Pagefaults does not have process information correctly populated
> as vm->task is not set during vm_init but should be updated while
> real submission. So setting that up during signal_ioctl to get
> the correct submission process details.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6000dee5ee3d..f62163917f70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -802,6 +802,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto clean_fence_driver;
>  	}
>  
> +	/* Update VM owner at userq submit-time for page-fault attribution. */
> +	amdgpu_vm_set_task_info(&fpriv->vm);
> +
>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>  
>  	/* don't map the queue if scheduling is halted */

