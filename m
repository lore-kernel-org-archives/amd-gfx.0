Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBBBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 12:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27D060C4B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 12:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A27D060C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E916EA50;
	Wed, 13 Oct 2021 12:49:20 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE716EA50
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 12:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAJyFEc0QzIcm1AeQYJeXLA3ATKjmuUYXceBiq8TucoziWXaIsUsgkpXPhUdHJRgkrif8nkzuFUJgKVk9jotWhcn1P7yblAtMwldxiMSNoX5cFfvolcNWE3FadQPqA6+5knwZEETxywQ0fW9QqKXCX5iRtJDf65V2qKNy6+ihz+/rn8HpypO16ljLePttOD+7Q5092RmsNUIU4wlfMZ9hGvvt8vWv5kOc1PQX3PSbMELhNz1YyFfNrBUloMPn3bBzkhQfmcbzxUu9TLILlCL6dF0ZGTV29GxV1CDdI26pdmp/vWRN7GhaNH0kLb9cDfO3uPIasL1gNwWlnIdf8GGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAzYmwOSm4lvVU7zfGlwl1fLvseSjLPBAfL7K7Pq1eA=;
 b=Z0Vyg2hnm5q/HA5hqWxVdXDpiy3VuwqA68UaFBzg3C1msU2f0cjUsItoenuGuip/MIlTwaVr0bhoUF1SIXimlmBETbqxfuHO5lML5PdBXWRvIDzNiah9bab4kEKZrVu31+VT8ktRxCFyU/KmwPy3aco8LXdkvGPh2II0b5S+3pf36Anmm0jMKdnNDpS2MXEOuopvBNyibcYHqCxYm2LcvsccyEctbT2LgAIQJ+ozRooMKJDbjm96rNHT+QVKlDhkfZ7ADJRxsimSjEJeRcwwWQEXmssezWLl9eJ8+ac8gu2MdavwaScvSEf+wTWTWRcQsBnYq3hQAKholkVZEQcSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAzYmwOSm4lvVU7zfGlwl1fLvseSjLPBAfL7K7Pq1eA=;
 b=SSwZ3+6gTSVdXZHcy+9/5wPPBMLZnbWy46IEWeoIr9vpDyYUp2EOZwFQI8lF+T0vvg2jrAUB9vK7fqw18LZsxsyysNgztYWKsQPSIQ6ETXSB8iSdGUyF9pA3a6EuZkRP6PFA0JBU9pAHRR/804IHJKGPWdUao5Ed6S1VoV7M00o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 12:49:14 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 12:49:14 +0000
Content-Type: multipart/alternative;
 boundary="------------VZ0O05ofkmArItUq6YOhaXmJ"
Message-ID: <874a43ef-06ac-a44b-5e27-063432a9081d@amd.com>
Date: Wed, 13 Oct 2021 08:49:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] drm/amdkfd: fix boot failure when iommu is
 disabled in Picasso.
Content-Language: en-CA
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, James.Zhu@amd.com, youling257@gmail.com
References: <20211013061604.3404343-1-yifan1.zhang@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20211013061604.3404343-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: YT3PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::13) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YT3PR01CA0079.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Wed, 13 Oct 2021 12:49:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 563e752b-eb46-4d7a-32c6-08d98e47dc37
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43386D93C4CC3E6D4E0CD647E4B79@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjeqlUc6yDRm6kiFId3vj0ql4S+q14VNiA6r2FPPQpL84IZxmmL43XCBKnmJOusAUo9ephkgmpKhyrBFEoXw3ZnOJFb10XRALbSnyxmNyc9pMUOsvgWv4Tlg48wWPrMzO3jXvZ5kYCPp5ohJSdu/nCyqe7R/VxrhtB09V8N2MlwSj3/HOzgO6+nQTzfuXtQH1qmdMkfndervv7qMca2uU5c3vu6H8Xpjmo51QjlKlWkD9x+2bhGbWl2K+iAOB+ec4VIpz9rOf12Gn+biuzQkiOm8/FozRde90kDKCiWS6bYFUyD8pa3RTDwuNh+gNAfEWkOUm7AuRUx8TUBH9K7+NMzVDjh6rkSMpMa0vGNYTJQZvj6iGHOVZOqhoAxtE02nnKNGxS1ktk8O99YBXxBdXpWEvg6ydivWI+egKGh/Kimkp8MLQkoz67fUTadTCQphLZb9MU6jpLo2vRX/ZQI02Lzql/c5AGiuM+HREI7UU7BlP5wFJ99Ak9cH0cD0Xa9lr8Zq/kvnu57Ltb+7LtwNI3nlJg5UulqpHPN/oljkne2iaM9kq76vezPTz1d0nV4Vv6lsOQHOxXPc0ExGLLZ3/LHpgMnmEGoMVOiTgbsCRM3dtc5j3KgEsGZHaFY8esHMboT8a4OcO6BziqANO1noDIDq5iWIY8sJB8C39dlPglhbvZlWFpYc5s4FwP516JQvt99XU9LqLfFBKlEpyuWmXob4xbFaFtkjZ7mYuXvpT4REK3tUH3VvRY78CkYKjiaG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(66556008)(83380400001)(8936002)(66476007)(38100700002)(508600001)(66946007)(8676002)(2616005)(4326008)(36756003)(956004)(33964004)(16576012)(316002)(186003)(2906002)(31686004)(26005)(5660300002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NksxVG5hN3V3Zkdsc3NVTjR4MTQyOXhBSHRyVGlQcnN5NCtGMGJ0djVIY0VQ?=
 =?utf-8?B?d0h5SHBidHEwdzh1TTk4T3RMUWs4NDEzOU9xYjJrazMwc1E0T1Q3K1JjUVpz?=
 =?utf-8?B?ZktyR1VRY3d4OWlqQmZMUjcrM0lEakx3MkpNK3NKQmRhZ3pqNHIzaFFOT3ZI?=
 =?utf-8?B?Zmxxa0QrQXlDcTRNQ3l5ZG9WUks4Z3Z0VlhOOS96dmRLRHZreDZJdUR1VXM0?=
 =?utf-8?B?WDlrWkQrZmUvSUwwMUpsRVpLR2hSTGt1cm5ZQ284S2ovd1J6eDBhOTJ2cUFC?=
 =?utf-8?B?bFZXVGIxZnlMaFZJdzFuVDJjMUtDMjJkWit0d1BiSGUvVnYrTkxqdkFqU1JH?=
 =?utf-8?B?TkhBYlpQUUp2Vk9xNE1BMDhRZDZNRlNMckFaTk9IWUY1QzZDUENCSEZyMnBm?=
 =?utf-8?B?MEt5VGhCNnMvWFZ0MzVLeWEvWDZIS0c4d3FXN0E2dWhocnpLV012RkZ1SXBM?=
 =?utf-8?B?aWw2aXVnejl6MGd3Tm1aUEVsdVJ0UkxsNWJMc0F1YThzQ296bEo2b3J4cGM3?=
 =?utf-8?B?TzAwbm5VTGp5V2Q2Zk8zZW9tSFpUbVpicVM4dXREVmc2c081ZTI2dndPV1gz?=
 =?utf-8?B?anFkeHZOSkNqTW9OWXRqS2kvS2MzaEJ4eitnUitkWWdyZ0pVTk41N0NzSC9V?=
 =?utf-8?B?d1o1SG5DemlJRmZRT0lDTjNKVkpRVGtQM0RFOU9zWHlpSTZkQUVZaWpEWGNm?=
 =?utf-8?B?R21LcTQwbE56RndrTUFJVGdwZGpsYjBkczhCQVNuZ1gxYyt5VmQ2SzN2emNC?=
 =?utf-8?B?cVc0VEhiZGJhK3dLWkJjSCtMNmQ0Sks2Y2pVYVdTR21OL05md0IrNXgyUVl2?=
 =?utf-8?B?MHlaV0dKTjNoQjZmSEozSHk5VUVEcERnNzlmTUJqOXFiLzFGSDBZT3g1L2Ey?=
 =?utf-8?B?ZW9rMzdyOWpodlJTbG1uRTV3SHBHY1BIRlloK1ZVRHpTS1N4d2VtZXZqKzEz?=
 =?utf-8?B?ZTdyL2wrdkUvQ1dVSkVGTXUrOUk4UWZIUXdsd1orVG5RWXVpeTl5czNPMmhm?=
 =?utf-8?B?YjBHV1hNU2oxRWFGQXRKT2s3OTVuRW5IVThOd3MvRVkrN3R3dzZMeVV4ZHRj?=
 =?utf-8?B?cnlDZ2hxRk5IL000UGFUSGNRblo3ajVVMzZzeWo2UUpSVHlON0FhdmJVeDBu?=
 =?utf-8?B?aWZXVEdyV0hJYXBoekVlUk9KQVNuR1ljVFQ5Q2V5QVZuYzVyWld2ZmxvNXdD?=
 =?utf-8?B?Vm5TVUdFWDQvK0xmVVBtbysrblkrUkMvcUJhaWJJVFpNMXNQck82QmEwaWFV?=
 =?utf-8?B?TzBiSTNzcFE1Nmt6TGdUeWZGWVY1V08vcFF2TXFuYVpVMlFpQWhBM2xkMW1F?=
 =?utf-8?B?VEwzY3hiTW9WQUZCMTNrWWEwZm4wSXpEbnJPdlMrNHpiM3FLMGQwSlFSNFlh?=
 =?utf-8?B?bTZyMkVNMXVpd2JkZ2NpMXFBR2srRjRyN0IxaG1icDZRNFBMWmJncm8yTTJj?=
 =?utf-8?B?VCtSMkh2WmlhYXZTU1RtMmVPQmtyWTJzajRaZUVLT0VrdlN3czFQMHA4Zjdv?=
 =?utf-8?B?am1ZeHhETmZheFJ2WlkzS0xhSWhmUktIMTZGS1FOV1ZMbFkvdWUwdlVjNXVO?=
 =?utf-8?B?Qm55d3U4NkJJRUlFenFnV25sT1hjZjNmS3IyTVpYd0JqTU8wS0NPTTdPOFYx?=
 =?utf-8?B?MFpucWM2VmJ1bmNueHJPRWthWkRQcEh0MkcwTEJpd3BnVUFRdDNTRnc1VEt0?=
 =?utf-8?B?ems3YldOMk1NK25wUXRLc3lYbXlVZThadVcxSWlXMnNVdmJDb0dGc0JiMXlD?=
 =?utf-8?Q?oxmZ7F+pmNFAD+4u2OpHnDoPd6ovSzMjRIdwYlG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563e752b-eb46-4d7a-32c6-08d98e47dc37
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 12:49:14.1181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyG+QvA7F0ozlKeqi6Rm6Ln5/tshpTBIv3jIQriMNmB2S6fYVIEyh7dwAWlGaVl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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

--------------VZ0O05ofkmArItUq6YOhaXmJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by:JamesZhu<James.Zhu@amd.com>fortheseries.

> When IOMMU disabled in sbios and kfd in iommuv2 path, iommuv2
> init will fail. But this failure should not block amdgpu driver init.
>
> Reported-by: youling<youling257@gmail.com>
> Tested-by: youling<youling257@gmail.com>
> Signed-off-by: Yifan Zhang<yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 3 +++
>   2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 52b24334a19e..ef467216ff8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2397,10 +2397,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	if (!adev->gmc.xgmi.pending_reset)
>   		amdgpu_amdkfd_device_init(adev);
>   
> -	r = amdgpu_amdkfd_resume_iommu(adev);
> -	if (r)
> -		goto init_failed;
> -
>   	amdgpu_fru_get_product_info(adev);
>   
>   init_failed:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 064d42acd54e..08eedbc6699d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1029,6 +1029,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   
>   	svm_migrate_init((struct amdgpu_device *)kfd->kgd);
>   
> +	if(kgd2kfd_resume_iommu(kfd))
> +		goto device_iommu_error;
> +
>   	if (kfd_resume(kfd))
>   		goto kfd_resume_error;
>   
--------------VZ0O05ofkmArItUq6YOhaXmJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">
      <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><span style=" color:#c0c0c0;"> </span><span style=" color:#ff9d04;">for</span><span style=" color:#c0c0c0;"> </span>the<span style=" color:#c0c0c0;"> </span>series.<span style=" color:#c0c0c0;"> 

</span></pre>
      <style type="text/css">p, li { white-space: pre-wrap; }</style></div>
    <blockquote type="cite" cite="mid:20211013061604.3404343-1-yifan1.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">When IOMMU disabled in sbios and kfd in iommuv2 path, iommuv2
init will fail. But this failure should not block amdgpu driver init.

Reported-by: youling <a class="moz-txt-link-rfc2396E" href="mailto:youling257@gmail.com">&lt;youling257@gmail.com&gt;</a>
Tested-by: youling <a class="moz-txt-link-rfc2396E" href="mailto:youling257@gmail.com">&lt;youling257@gmail.com&gt;</a>
Signed-off-by: Yifan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:yifan1.zhang@amd.com">&lt;yifan1.zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 52b24334a19e..ef467216ff8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2397,10 +2397,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (!adev-&gt;gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 064d42acd54e..08eedbc6699d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1029,6 +1029,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init((struct amdgpu_device *)kfd-&gt;kgd);
 
+	if(kgd2kfd_resume_iommu(kfd))
+		goto device_iommu_error;
+
 	if (kfd_resume(kfd))
 		goto kfd_resume_error;
 
</pre>
    </blockquote>
  </body>
</html>
--------------VZ0O05ofkmArItUq6YOhaXmJ--
