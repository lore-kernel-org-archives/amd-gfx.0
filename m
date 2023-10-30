Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A238C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 06:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3FE10E207;
	Mon, 30 Oct 2023 06:10:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8A310E205
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 06:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOEMYkw4HkS65t1aRGsdF1TMATKxicjdMUTeqayQREcqsroXNbxRozqFL/76o71UWrIFNYoj41CczsuzgPFaWWscbFDHQPmC/RzY0l3npf/puS/0sIrUJpMj1NSotrKLum6bUTUO198cn7iYQP7nQvNZB/ssDK8f0EANbg3zypRpSkRUWWum1zwVKCeo0q4Q5zXiIEDXdyXFguDqYQ1NaXfyzseFGf7aGL4hOy3dahWLXZNuCxSImNp5E8dg+abpSV5ByF2I3yKZQgB17E/dPBFZBBEaOFqFEON2LrjGZ5Q5Rem2q4HCitonYyJsUYmyJCrIDJHiAEx0ECqJgIz4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCX8h44yqtC+0nrssDmiMDxt2SILcilT7rGSxGIj6CE=;
 b=mOjjU7UMf8yrppVzQPwpyEO+rr/W5WNlw3NcqSl80yWw8vRVwBhz5W+ex+cy8y1p+TjcyvZZ0xnYAX0ZmeKnPKroIlzFoYxaxedKbabGQ3nKc/WgNpxal+pOjLzW0iCh0W05VLvWYh3T1QZjF5Cl3sqetCr/GPuigRhBROJPRAHBYyKkIr7IZBChr2wy1rBMIiFgvmWRMYKkU/dCzrMAo1tS86E1ZNhJYBooJ2wGL+Xr+Yuz94BAq6Pp62z2IL7eF9l9Iy2lvH5wDdR+LDok3gwQ875eLYbrGM2cmwKq+6Zf2FfO4lC79Rn0ircyx0sg6J6DGVO9X85hMu1JD7JrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCX8h44yqtC+0nrssDmiMDxt2SILcilT7rGSxGIj6CE=;
 b=gb+71jxQyodRWgjpXnw1VHsyIvIFjq4vtgy7tNg+rEDWKNYXhLGv8qO3ocQxrVj/fqFQwOIaKEbSignWb9fAOXgZGE0XqGRJmAvzoiI80hBLQ3IK7JOvQOtEDtl/eou/9wDkAraYrfitXOMDK9hodxH1qP4rTXjLHAEv6KFliQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.27; Mon, 30 Oct 2023 06:10:02 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 06:10:02 +0000
Message-ID: <c82e4cb7-627c-a356-5659-0eb63a3e1a2b@amd.com>
Date: Mon, 30 Oct 2023 14:09:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH Resend] drm/amd/pm: only check sriov vf flag once when
 creating hwmon sysfs
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Kenneth.Feng@amd.com, Alexander.Deucher@amd.com
References: <20231026025033.1469231-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <20231026025033.1469231-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 683b335b-6fca-4232-9d8d-08dbd90eda6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3fDJWCaifKMV5E8Lbvyn/B+lnBtrYlTecFEq1ud327VjJfp8+O+m67iNtUcG1etJ7jgnuS3YMCXTjf0NmbET2HzTDMckjVGJD+b0N4KnwpcanIeb37ErNDvmt65o745HnsMa2w9oSZy2ZEQYy3SkvZbfXYWcHVniRSZYswm5xxVsRFNP9MK0puV+8NwbF6CIebsyLHOX5kEczTQNbkkGmLax2oNifdLIOg7qQoJz3RSn4VyDCdM75bqSpCH8YVIGduQ9TGK2aufUMxHWEodhO+7ENOPpoTVT5QNY6TFWfh6Kkz8mzdiNlBumoeOxDetbYQi63oa7GJryKoPhoUPcNsoFbG1l8sgLW6sI/riQfm2N+S84er9UPeeMTEgZJngxlwvxVT2GHJudU1jv7XYmaYkUzbnOENvJ3eSSbTNtTN7uvzLTkVTIF/6yXG+6tJGxcr3miTPHrKLxfSEHAdINTdPRYKgJg+YbeIxdRzWdthJKPFu0Jyc7/CC2eJ4rAqzB7VKeTIeXhgBd41/pO/6IXMZTHJIuhNncOMu8cOCGV+rvy7PzkXs8d8nqNn6S1WSvo5klEtPdrRQjsQlEGaStKOH9CMYdxV6WqiD50pqC0Yd/Yl0huJOp3YDP1r1R8BMJc5ErFQR9QRlTw3CtdY5uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(41300700001)(2906002)(66556008)(66946007)(66476007)(6486002)(8936002)(8676002)(4326008)(478600001)(316002)(6636002)(38100700002)(83380400001)(53546011)(31696002)(36756003)(31686004)(6512007)(6666004)(6506007)(26005)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3czTFJEWFFRMGY1MHpLZlltTTZ6ZG9UK3JtaUh6UjdpNTFEQUxiRkNrZWY5?=
 =?utf-8?B?dDE4L1BZb2VPQ2FuVXo5WmJDVE11cHdDTVhVajl1eTlKTDNRQ0dKL2VtdWgy?=
 =?utf-8?B?dklrUndOU3ZmREZwRFdnOS80cDA0aU1aVGhQWUpTYzNEM3NGbXVrUHJPOFBK?=
 =?utf-8?B?WkJRK1RNc3VUMkhRalkxVjJZQ2dXcldGNlRkd3NubDhQai9tMTRVSlN5TTZi?=
 =?utf-8?B?d1lJYkRlamFvcWZoanVDczFHWXdxMXMvVVFycWRsWHhVYldnMlpKMXoydDdT?=
 =?utf-8?B?RUgxcG00M3FFc3VremJEUjRyNFZERjBBem5rend4UXhpeHZIUkh1dW5RSlRu?=
 =?utf-8?B?cFA4S3E2cFZWeHZCdENaM3ZWNzAwSy9wMTAyVDAraWVoNjd3VE1vTDExcmY3?=
 =?utf-8?B?RHYwMmFUekxoczRnMFY5N205bytIY21xb1BJUnlvRS9lbnBSVHYxS0x4eEZ3?=
 =?utf-8?B?a01UWGVhdVZrTUNHSjRnTjRtNzlzMlFkaSsweXMyS3NOOHpJVXZxTkp1QmN5?=
 =?utf-8?B?VlZUZnlHb0NvTVBuK3dHQ2VJei9RUW1acG5MNDNaMlV0TitlUmc3UUx4empQ?=
 =?utf-8?B?Um5ZUVRHTFN0dkJKWjgzSTNJUWZQcXNzeGEweFVOcVFhYUd0YXlGT3pXOEJR?=
 =?utf-8?B?L3dJdkVWUU5VOHkzZ3BvS2kzenFFczByWWtORUpMSzBDQ0tPSDd4a3pZNW8x?=
 =?utf-8?B?eDdOS3hoNHVEQ2xPcm13L1ZxdTFlQUpZN0g2K1UxTFJ2WjAvSDNFRGJKd0tW?=
 =?utf-8?B?Y2hvaS96WDF4UkY0bDJ5U1dxS2ErQmkwR2F1ajR0K3V4c1ZmVGNQWkREdU1F?=
 =?utf-8?B?T3JLdXAyaFhmYjJsQ3doVm5UKzhXditHSndlMXd3aHRodUN6TUNjaWpFNk9Y?=
 =?utf-8?B?STlwbFg2NFFHWG5XYXFKL2ZzR0JVaVRGUmNueXlYZkNRR291Z1prMFIxVWJB?=
 =?utf-8?B?dTNYcmc3TDBSaTMvUUtYemRzVWttRUdnU2JvTTRuWlR3ZUJLN1RKRlFEOEIx?=
 =?utf-8?B?QlY1WG10NXRDSHdJMXJIM01ZVWFPemk4bzJuNkxHOURvMVN1K3NVVUQxWGxB?=
 =?utf-8?B?VFVteGd0VlIxVEN3L0JFQXVEcTVwV3lKMUVFUGZUQ0Y5TkRCVzg3TE5JTlFw?=
 =?utf-8?B?bFp2UVRLUHFKc3B3OXVURVg4b3NuMDBoRlI1cVNxN3hDbFJ3cHpQUEZrcURp?=
 =?utf-8?B?cTNmZXhTN0l2a3UrL25MdGJVU1FXRGtXMXpOWENUeUJhYUdqaXY2dVZkUHN0?=
 =?utf-8?B?MTB3TXZlT095enlHbWtNdktTUzdhSG1IOEpKVWVQU3p6cGJDZGRYYThGMTVB?=
 =?utf-8?B?OEdFaGhOVmpidWJvMHcvUVkvMkl3M3o0dzJURWxXeitNSjc4dFlNaTQxTStI?=
 =?utf-8?B?ZnpLUlRybFcyUUtUTnNvM1BIOHNRcFIvcnpiVDZzUkUvcU1lTlpjUUtSZS9H?=
 =?utf-8?B?SWZvODZQSjBtVW5vN2dBbWN0ZlRLQXR3KzJ6dGhWNDkxd3hpRTlXSUFzZGlO?=
 =?utf-8?B?aHF1cE4zTVpEWUVQZkdva1Z4MlF6eTNYNmZaRis3emxwYW1DQU9YanhPYmp4?=
 =?utf-8?B?MDRURlc5ajNnbTFKS0lIU3BOa3RGdjF0bEpralE3U2lhZWZKNms1a2FOa21U?=
 =?utf-8?B?T0NtZmF0RXhOTEErdGJyeEl6M0paQmdreW1uV1BzaWZPZDlkMVQwenF4b2ZU?=
 =?utf-8?B?blUyVVZBYVExS09WWkFnSFlxQlYzc0p1UVVUQXEzUDg1eFlqS2MwdExuY29H?=
 =?utf-8?B?Wkt5VTY4em5OZmxhcUc4bUVMdVYySW1HVjJIcGgwZEw1NjZuM3hXbWVqWkdN?=
 =?utf-8?B?K0VLYXdqNVd1WGJ1dmRVeER0S2xRclVZazZuUTlDWSsyNEtPTGFZZ2ZaNVJE?=
 =?utf-8?B?ZU85eXFkaFdQNVFXV0ZCbWhNTVRZMStPRC92cnN6OEZIQ2JEQlAvMWt2dVhB?=
 =?utf-8?B?cmJBS0ZDK0FuK1QrQmdnOU5CQ1pjaHZvVXg2ZFIzaFg5MWpHeEVmUFZJbXJY?=
 =?utf-8?B?MVIwSDRRckNFWUJzNmZnYm5ibytpR2x1OEpaUGJaMElGWndEdk5oYlY1MjAz?=
 =?utf-8?B?ejdLR0xxWGtCdVZwenhYVnJlSWFOZGlXUW04bFFKRjBMQlpOVlVvdkJsRmF1?=
 =?utf-8?Q?maj8DzQQYSffHmLitg2vE3Wsw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683b335b-6fca-4232-9d8d-08dbd90eda6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:10:02.1889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00fLjA/okd0luOqUO+22LfMdZKQjCXeaIhWiwhU39jTS7BkbXZ1IEhsXxReC0JXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

ping...

On 10/26/2023 10:50 AM, Ma Jun wrote:
> The current code checks sriov vf flag multiple times when creating
> hwmon sysfs. So fix it.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 358bb5e485f2..ee46d04549e6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3288,10 +3288,6 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>  	uint32_t tmp;
>  
> -	/* under multi-vf mode, the hwmon attributes are all not supported */
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> -		return 0;
> -
>  	/* under pp one vf mode manage of hwmon attributes is not supported */
>  	if (amdgpu_sriov_is_pp_one_vf(adev))
>  		effective_mode &= ~S_IWUSR;
> @@ -4162,6 +4158,7 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
>  
>  int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  {
> +	enum amdgpu_sriov_vf_mode mode;
>  	uint32_t mask = 0;
>  	int ret;
>  
> @@ -4173,17 +4170,21 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  	if (adev->pm.dpm_enabled == 0)
>  		return 0;
>  
> -	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
> -								   DRIVER_NAME, adev,
> -								   hwmon_groups);
> -	if (IS_ERR(adev->pm.int_hwmon_dev)) {
> -		ret = PTR_ERR(adev->pm.int_hwmon_dev);
> -		dev_err(adev->dev,
> -			"Unable to register hwmon device: %d\n", ret);
> -		return ret;
> +	mode = amdgpu_virt_get_sriov_vf_mode(adev);
> +
> +	/* under multi-vf mode, the hwmon attributes are all not supported */
> +	if (mode != SRIOV_VF_MODE_MULTI_VF) {
> +		adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
> +														DRIVER_NAME, adev,
> +														hwmon_groups);
> +		if (IS_ERR(adev->pm.int_hwmon_dev)) {
> +			ret = PTR_ERR(adev->pm.int_hwmon_dev);
> +			dev_err(adev->dev, "Unable to register hwmon device: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
> -	switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
> +	switch (mode) {
>  	case SRIOV_VF_MODE_ONE_VF:
>  		mask = ATTR_FLAG_ONEVF;
>  		break;
