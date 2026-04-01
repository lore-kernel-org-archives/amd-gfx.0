Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EF7D3517E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9475910E269;
	Wed,  1 Apr 2026 13:27:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x2qXOP9L";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B44A10E269
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ia+DeNo2N/6kOm6HZvsLBF3jv4dUKi3xaC0yX0clwz/SNXDpFzaETn9SBeLdGU7cpU2MrvQkDwy47UnxcO0NLk4eCIHc+IPa6tKoWeu3GzfGXFaoVxRdZEmFMPjdxnx3FKepkGEXRni6SiQQgmffQjRR7iyE/ZiNAud0KXHZpQg0yhZhsXz0PBE6wGyRO6qjVMw3ez8G95Yaxf/qVyslIBM3lI1bguJeh9TdZTCJaxlTCpeoJ2+MebJNkJ65TeSrri/BVcGerVsYJTtpB4FGjRweX44J2DAcMji29NC+uMvtTl5viqRF7XBjoFL4aCBDYCAAUJRuvj9vpkaubJI45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RK8NNSEaSoJ/lWSN1Lw8qxK68+OPHOAScMQUBKYXt8=;
 b=pSDUiPaYFIS1Xca/VROEakPttiUeB+L9z1Ddfjfsai75FU63KLi1SVdoNmXmq3qtitu8AGFNgEXHCU1FTSZOHq/0h0QVynT+5tcpl7lKyBi/2vEtwd7T4NhpOunJdQZJlsRPW/hGChKqwxgjHJJ6Q/XFRqWTHSDkqi8YwJLF/ICO7xD7nFPsssivNfE4TFqtffjDfkjuZz+MFogVcADeZpikpO2ujlZUek5oAMZ2oxceOdMy9GtMEwb3R3gP0YQCUxj9n0i3RHfF7X674tWG634A27DpJxFL5SgGvybUUTXIPl2JZ5IyDBGDoX1TZojNVA795Q+TdR6crtBqN0U4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RK8NNSEaSoJ/lWSN1Lw8qxK68+OPHOAScMQUBKYXt8=;
 b=x2qXOP9LjVRrfoLWa1fQULQFAPnOmXiwV3YRc62dozvVrJ8KFV9kxPlaG6/nSX3K2syRzmoSHnd1/BwouzFlR3RKcvGzsb8rmXldEFmRimXeEE+weVjVwMzawXd3j3FvpRva9oeVSWChurt3LDu+VV+UFNYu0UFP4+EdINVmJCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHXPR12MB999220.namprd12.prod.outlook.com (2603:10b6:610:2fd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 13:27:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 13:27:18 +0000
Message-ID: <89b5637d-f52d-4b67-a774-02aa99b114ed@amd.com>
Date: Wed, 1 Apr 2026 15:27:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 2/5] drm/amdgpu/userq: dont need check for return
 values in amdgpu_userq_evict
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331134654.2762805-1-sunil.khatri@amd.com>
 <20260331134654.2762805-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331134654.2762805-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHXPR12MB999220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecc5447-4118-4aa2-5b86-08de8ff26584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VaDFSpXOCKnhH6GSA/i4086n/ZsVdL/1htT4YUonTVMmHw6ABPAiPb2x7I2uaBqhDp4fq2fHoa/rB27Q6JXGZ9xXSgvA/gwrYPJobG7kinnzUMC+gjKxfZXzGnOih6ZeMjTNcEKoru94GBPwSB+PZtMyLv+40MUSlZ4ifiQg7PJpVjIUnlL/NfELEk3duZHQluWHlzIzocT5GGouTrFQctEikXLU3UbWlpWq8ZugVk8by+uHsSK0XBCBl55eg5zXI/UKLNLTTVYgPDYyqa0ZieJSrTPNGqdQIEMENKUT1c8fDYKEwuVQO6MGXw0U3xZPpxipwWyLJmEPxG/OzeD+Um6tE1FmSajl+8cFD3xwlYxV8MdBAxrzv8EA4/7F/GhR27qGlrzpZwy4w9TFn+pTLKMmqQEhzeIigALn1TX+84HheHHyqovmTox8SsXU2oJKj0jzJpm7Sw8jYD2N84T0GPcBdDWCD30vbg2zO7EvYk3FkDkp12RkJkJBrNiaeaHKaKLLpE9cIww9JvYn+AsFj0bSLow6EkC5bfwRc3L20yyIQ24TAvarUN52an+rmE4yujxAK5QqaojEfskl0Waf83eF0dm0m0FR8RNnZDvfnaphSj/g9fTax0lOgpkIbqhrBF4++JhsQPofdBMmIzNTYvfxyxiDtI3acg94Tg42wtgFvP3BP3kiE49H36Kz/UUlN6tGGtF72oTEww/RKxyyiqcW7Phb9byeQ33po8F0Xv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME1wQUpTLzdMWkljMGFNVnBpZEE0bXRSS0NUTXJCMzRUVFFOanpsNi9qRzl3?=
 =?utf-8?B?Y1pVbVBXSXFYUWwrYXY1dmlXa3lzMWNUR0FTTjFMZHFUYTB6dk01bWRWS0tF?=
 =?utf-8?B?RHRLV250cUVTanRPak9DM1VUa1JMdXB3dUp1TE5UbFlHTmxKL3pvcXNYQWVo?=
 =?utf-8?B?NHBETUZnRFRUeDU2NmwwSnNzS1BsYWJLYi9CK1o2NGU5YVA5anpYai8wUEZ1?=
 =?utf-8?B?UG4xWkc3THJ1M2lWS0FUbS85bmJNSkpXK0kyTlBKUnFNZlFLVDB3MEtyVElk?=
 =?utf-8?B?QTN3RkMzRkdPSTBOSkUvdmJhNVdlZGIwaU5WQk1JOTdVSjBkYWc0akt0MWFN?=
 =?utf-8?B?UGFBb0lpWFQ1dkpyVm5JcXp0YStYMGIwV21vUjlkR3RwVWhNSkRkUjNXcVFT?=
 =?utf-8?B?a2FZaHp5ZDl5Wjh5Z0tTc2h6bDB6MktVNzlCUmJaOW50aWZYZnBOUHNrdllk?=
 =?utf-8?B?NnE1R1lFZGJjZ3lBVS9lZlVkckg0MWhpbmtCTi9hK240NU5KeWY0Mjg1cWRD?=
 =?utf-8?B?MlVRTXk2czl3dVJYK2NNS0piMjhsdUdCZUhsR3VxOTM1Tkp0RmRRdkd1MVZT?=
 =?utf-8?B?Z2RqREMxYmtoYk8wVnVFQUlLck9XQ0hET0tWYXJNdTFMek4yK0JzS2QyR3NX?=
 =?utf-8?B?WVgyQmx3aDBZelJTcnlpYUdHUGMrRjBXQVhmQjF2SSsrODluUUU1YXBJUWhL?=
 =?utf-8?B?aXovYm45VWNyQTJ6cEczZE9kSzkwZnVnTVhINUg1UUNWWTVFdVhvYnBxUFkx?=
 =?utf-8?B?V3Vyb2ZsV0VIT29MQktMLzlDK0F4TE9lelo4L2RuT0MwazRQOGViSUM3Q0d1?=
 =?utf-8?B?eWtodm04dmVqYjFQV01Ybzc1dnpHUHFHSXhPbS92dVMxR3MyU1RXbXYwQnFJ?=
 =?utf-8?B?STZxZ0cwRk9KU2trN0JvaWFSNGJPSm9lVWF2MHd0KzFwWmlyeDlObE5YNVNs?=
 =?utf-8?B?dTBUOUQ3ODhnVFRVNVJkY2c5RG5tSGJOMmtaQmZjSnJuMGE3S1dLaTYvSUc1?=
 =?utf-8?B?cmNaUlltQThmcWpDMDBTWEkrVmNMU2M1RjRJVnhKZGRzVVZhZktudTNRdHFr?=
 =?utf-8?B?ZTFCRWxIWjZpOGVuV2Vka3VVVGlsem5seXRRZHhTcS9iMnFZbVorbmd5ci9C?=
 =?utf-8?B?aUk5YkwxR2N0QjlRaERicGI2RXJ2ZXFhYXJLdVhvYmR4OGE0eEtuejNxVWhW?=
 =?utf-8?B?NzhyOVpnUm1nbzBlR3R1UTk4WnZIRkFDUmgzMmRKRWh6Qk5hNXlCYzdWbkFU?=
 =?utf-8?B?Yk5peWtZc3Q0NG5zRG9EQnVtOTBBUlBGeEVHUGVKem1jNGVpVnBQOVhiTTJT?=
 =?utf-8?B?djFkUVAxYXp2TXVrZEFFT1pXUVp2MFN1dDFNUjJmZk5FOG92SHRzVEdzWG9z?=
 =?utf-8?B?TkM0WGlCRU1rcktPM2V3VnkrVUljTnZydkN5Tk5QeXJoSkEzUjNhMitIQ0Nh?=
 =?utf-8?B?SUpDRlErRnFGRzhDL1RjWUJGcHkraEpQMmtndHdUc0VPODI0WGFRS0hYM3JL?=
 =?utf-8?B?RkZsVndPWU56NGlQcHlJTVZ6TEhXZklRUlplZ2lPTWRQWm5xamJzd1FWVlFx?=
 =?utf-8?B?TncxbVU0bUk5Mm9xS0NuS2llYlQwcFJISWRKaWJjSjlNdEw3Q0MxbnU5dzRO?=
 =?utf-8?B?M2x3QWpiS0JBcHA4VUkzMmxvVnowZFlFSHFoRHAxYUpiNm05dnNCdTFJejRD?=
 =?utf-8?B?S1VsYVJTMmdSRm1YWm9PMXRkRXVjOUU4RjVYYzFOMURIN1g5UUxUb0E0cHBk?=
 =?utf-8?B?THRvWEhrRGlXOVc3SDFxTUZEdFc4Wi8xa3ZGblVDUjJTVzFPV0RDNkg5b2Mr?=
 =?utf-8?B?T0dkWG1iRVRJY3pPMmlIVmVNV1JFUkpxTVgxMDZIYmlXNDZtT1NHTDlsZTI5?=
 =?utf-8?B?VXN1aVo0aVJRd0ZNNy9pZWxVQTExcFNxSTVaZTlCb2Fxb2RSWVMzSkRINUJk?=
 =?utf-8?B?NDY2czNheU9BR0hpLzYvd0lvSU9CVTNyWC9SL2daY0JNdkNIL2RybzIrME1l?=
 =?utf-8?B?S09GaGVpdjdMYVVic1BWT1VYYTZ3SlNoZEVvQmdVR2dOYmRTTStCMmlTT2U1?=
 =?utf-8?B?cXMwLzNUMDhxYjhsYkd4cDBhQ09hcnRuYTNTR3NuTk1IVkkrMjN4a1VvN0s4?=
 =?utf-8?B?VThwWEdXWFJoVmpiMUJSQTZaTFRQVGpBRHFFdFNyNU4vSktqUWZYVkJMd0Ja?=
 =?utf-8?B?VFRNUTVybXlWL3paZFJUMmFqd0dIYThLc1VjL2FtcjU0WUZSYldCU0NSVGxQ?=
 =?utf-8?B?MDd5SWFVVkhRNW0vVElCQklxUHdObHJLd05WN2RRRjgxRmJTeC9FSmVpM3Bx?=
 =?utf-8?Q?oET6m6D0NQb6fXi1C/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecc5447-4118-4aa2-5b86-08de8ff26584
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:27:18.3150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9wHTmx7+WMPF+v69qpyg/Sc7nkdWD7QHsxnsYfRvluxrKqniJ+IVW1FmMx5XsXT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999220
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



On 3/31/26 15:46, Sunil Khatri wrote:
> Function of amdgpu_userq_evict function do not need to check
> for return values as we dont use them and no need to log errors
> as we are already logging in called functions.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index a98118898832..1aeaa5662dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1258,7 +1258,8 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	}
>  
>  	if (ret)
> -		drm_file_err(uq_mgr->file, "Couldn't unmap all the queues\n");
> +		drm_file_err(uq_mgr->file,
> +			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
>  	return ret;
>  }
>  
> @@ -1298,18 +1299,9 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
> -	struct amdgpu_device *adev = uq_mgr->adev;
> -	int ret;
> -
>  	/* Wait for any pending userqueue fence work to finish */
> -	ret = amdgpu_userq_wait_for_signal(uq_mgr);

That confirms my suspicion that patch #1 would cause build failures when applied alone.

Please re-order the patch before pushing them so that this one here comes first.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> -	if (ret)
> -		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
> -
> -	ret = amdgpu_userq_evict_all(uq_mgr);
> -	if (ret)
> -		dev_err(adev->dev, "Failed to evict userqueue\n");
> -
> +	amdgpu_userq_wait_for_signal(uq_mgr);
> +	amdgpu_userq_evict_all(uq_mgr);
>  }
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,

