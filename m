Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8536CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 05:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D78F10EB9C;
	Thu, 10 Mar 2022 05:28:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A75210EB9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 05:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDp5HcQTo9jO07k5U8+NFbasvvKMzHJhEPiH99FWutGFgaKMHMefyAlKI/tBXGqtobhoyHA5wJud+X+342NudnGqLqIi44JCCGEnAj0DT70ekV8x6J+nPQhS6o2uqEHH1J/jBhAMkMVgtuhJrWq2JL3nkafc0k5BCNSrFUpUof5hbwITqCQT2lU3ZQFCXLE4sVjBTSi2bhIbpLXpQbVyWy6CXk7/miW+B4XEYBB/vtcMlUrnj7beoQsRww3JHejSIzleHq5guqcwmxPc76MKSD2IwD+JNa7hWwptVmYVtEmf9ieuGFMO9PXSNJ08mGAcJDE95yz2m3fOCDuCUfX0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/OYl2tg3zsizwrZaU+r4G3DIypLSvMaqQuOsLOyclY=;
 b=Ffg+x3E/E/V8dasQeOL0kC+Gx8moUfcO8qsXa8c2sB4kMShJs+p3V2r4B2ZBs+e5O2X21iJMVSVT+2NbIP6wqCH4/XB3wDlvs+v0YHDLySQLsCQi/xn290EoZD1f/EQRF4z41m8D4aF8FFCws+lt6KR3dqrgwa9eoeZ4IsjtaYRIaSzrqHR1c7Yy+Zghmixst+COsps0eiG7XoZNXXPILm+ClB6TBkxFTxtyPf1ztx8RATm/F7L9RdG1P7L093Q/wqGa5pUuzVkVfs4NCsWYkwHGY0E/qBew+vpl5twAevnivUK5u3c+Dq68pzzSoE1cN5Lisrp2WV+j2XRBL6MyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/OYl2tg3zsizwrZaU+r4G3DIypLSvMaqQuOsLOyclY=;
 b=EOAmTHd2E8NLXnNF12CGpwTbfrD1Fu5qGiiEPl0DPmdC5tkLML3Nacr0fG9XLtLDYUX2KMvGByhBodNVZKUaL4hizWaU6AmuiyOzIpwbaiRxfjApM8k4M21zplnUdMaCUiUxcCVUdDizj9dPQgjq9LVg65M0yPRGOxGskk3iSkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 05:28:25 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 05:28:25 +0000
Message-ID: <237ec5cb-44e3-0f94-c439-9b6742e7740b@amd.com>
Date: Thu, 10 Mar 2022 10:58:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] amdgpu/pm: Don't show `smartshift_*_power` files for APUs
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220309220548.2541074-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220309220548.2541074-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a174211-c831-4d50-da4c-08da0256cca6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5988:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB59888557EC767F4D00D69F93970B9@DM4PR12MB5988.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3HOQbsdNXyQ/9Fc5y7NxZwxKlX639P8yUw+YlRmVFJs0cobfB9Jkf9xxDF7xe9c2Ny0C3sstjwSr/z3bB4tct/K8aLn6WS/5jAF6oWCSPL1QyqY/BGE66QoBleyAf/LjhX8qnf4gXW7kChxHM4iUmmg1ydjZyAgbT10zFXOzQtC5Lwx0zTSrewS7/VjyDchoslfZz/JAbScKMLBt0u50D+/ucUf1Z3sbteX5JUchxR9XyPX0wAOGtxMMWrezqgduNByGdXs4rBNHwYNxPdrsbqKMS8IQdQByFsuC9VkXAk6KTR9D2IuQuuZ+g8lEGTBgRZV6jGeQElssRcQ2XwU+GsxZsllFE3WgPMAT7q7LyVNCvqjdPO4lYBNUhgs4/1I8juITUJezRtVPQntJPIf15mrc2USDqT7zVwbtlRVt/gVfhTYwqvlSkcy/duFXaoipjA4ZHMF/W5o7Db3Asqb9FjwbvzAG/Fo818Du1i95nBTk/BQ+sVNW0CERoJmgJmR50AbrxeVuXckmKHKOWhmPtOLOosw7F5COOoCx93SMqjRTpg71Xffc/Nf7raMP97NXUyUsvHJpH8vTFIZyXKuWSV+4xb4ySWMEN/rWCHDKD+s355vXBdldVs53o3QR3hL8H7pKxPTmOIz9y+36XdmH7yWb3UMsyTwCx+Yl8V2fMdwF2OSWBExPXgTE/DmUyQRC/VVUm1xKvkUHQR+lToRX7ZR5/N3oYgHLXhnLBPIpM1SOJLZP1Kx1eiEzaCJp67pWWn1Q/y9Khp0AKTivyEnpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66476007)(8936002)(66946007)(83380400001)(66556008)(31686004)(31696002)(2906002)(316002)(86362001)(36756003)(5660300002)(38100700002)(6506007)(6512007)(6666004)(2616005)(508600001)(53546011)(6486002)(26005)(186003)(81973001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdNamdBVlRVT1JSTFBVMDJ1ZEp4bnIzc3lLVS9NaUlFZEhpYmJSOU5IQTF6?=
 =?utf-8?B?MEpEcUx3YmQ4U2NYSWJTdWV0Y1lFS1N4Ykc0UmRuUkltYW9Gb1M5UGJEOXRy?=
 =?utf-8?B?U2hnWnFQOFVCR21sOXFBNms0Skp4b3JjR2krN29FZEpkVWJ6SVk4WkRTN0gw?=
 =?utf-8?B?V25oNU5KYjYxZVdIcWNCanRVVWhRUkM4TWRLT3RBYVZMenBLcFdsQ3R6QmRv?=
 =?utf-8?B?b2J2ek1NSFc0eFRUSWcyMEcrMVZUS01KNmY3b3pRbXhKREk0a0ZwMExXWDZQ?=
 =?utf-8?B?ZTVDNEFiYTdWcTNocVBuRUpiSFZ1dDlvMkpvaCtSNGRhenlFWStNMXllZ3Uy?=
 =?utf-8?B?VjRJRFRSMTdkUmN1V0hDU2hiRmU4bU9wVFZ0aXZDUGJ4ZzdmVVVTVE9sOEhq?=
 =?utf-8?B?bVBFSHdTbnhxL3F2aWpkWU9Mc1R3Y3VTTWN1T25iL2RJMUk1Q3l6OGJIWGU2?=
 =?utf-8?B?MXdLNjA0c2ZHbHdJeW9NUVVIQlRjZkUyb3E3MzdQS2ZQOTZtTzlXWE50NUZn?=
 =?utf-8?B?bGFWd3NMK0d3WGNtaTE5cWN2ajZ6TUVDYWdHRWZxcHhuazF3bkkvSW4wa0hJ?=
 =?utf-8?B?Y0d1a0ZCWERubllrVGRZMTJpdE4vczV6RURPeUt6YVZ4R3MzU0FtbGtsbTlh?=
 =?utf-8?B?V1JEc25xZDBGR0MrbU5HZGliN1ZnZFFTN2xzNHFmMWZscDYzd3BiMTM3TnlF?=
 =?utf-8?B?dFhPd3lWVzNhQnU4SUw2T0UwQ3cvN1ZNRHRsWGNjaEg4MDd1WnBIUnlIR0l1?=
 =?utf-8?B?UFdOeHJPZURRMXFUK1hXUVhpTWd1QnM1VHBaRUlTV1hxRHBUTm4vVmUrckxU?=
 =?utf-8?B?S3NXak5Bdnoyalo5dlRCNW8xRVNyb1ZYNzU0dHdva0IrSmRUaVA2V2duYnhO?=
 =?utf-8?B?cy9sdVF4SkgwYUp5am9DVHdtTWI0L0VRMUd5SXV5Tk51ajdnbkNhYTZBMEhZ?=
 =?utf-8?B?Qmc4MVZ0N3lGbC9GTUxpU1FJaVRFVi9lSGxPT1ZIc3hJVVBaVU1RVUwzWWtk?=
 =?utf-8?B?RStWcCtSN0x0TXlIaElXR01pVmNwUXRkd3BQK29nbitqMFE1c25yeEZUNDFU?=
 =?utf-8?B?ZlZWdDg0akd1THlJTTFYQmNRVGdTSjNaRFgvM2REdTRYaHZORUlWdDZYL2RP?=
 =?utf-8?B?MzRQb0RLY2hPbTdDTHNzSFMrRytpRWhGOHE3MDJvUDJTd1FjaGlURkU0U29V?=
 =?utf-8?B?eHEwNXE2cXNQNVRpbExJSlYyaTFRaW1maVdrZVNzWGhTblI5M21xRTc1NW1U?=
 =?utf-8?B?dWF2eFZFYjF6UzRKSW1LQW1vMC8zWXJkTUdTWklpUjRxbXg1R1g2ZVNMYm5Q?=
 =?utf-8?B?VkZpWFpmRXAzRnRVL0FWb1hBaU10a3VXSXpIYk1HNCtlbVVaVlpDemk4Vkg5?=
 =?utf-8?B?YVZ2Y3hsWEl4OGloSW9uNm5Vd01Edm5zeTYrWElxNjZPNUhGWDc2dnlPS21Y?=
 =?utf-8?B?VHY1SEdtbW9MUjIzME8xM1NxL0s5eFdmeVcxVlRTUGk5NCt0ZEhTTllBNHZy?=
 =?utf-8?B?d2I3L0JIOVlPR2tMOS9qeFArZkZBMWR2N0h1QktraFNneHM3NHJuQXNsQXBm?=
 =?utf-8?B?YkFFempvWjVDdkVGZFNOQmJhaVhsaGp0RkJZalVkUGlLcUFuTkFTWGNJWFlT?=
 =?utf-8?B?MFFGSWIzeXpjS0YyWENESUU0S3U3Ujl4cjBTcVJSL2MyUkoyZ3BFd0x6ZjlL?=
 =?utf-8?B?SC9qYmlydis0SnlkdHZKS0Q2SVAxaVgzMXJTdHB2UHdKU0dwM2FZZXlGSlY2?=
 =?utf-8?B?ZGZUdC91YUhrT3FiSmpRS0Fwb2tXNlVlNElTaDZCVlptYkNzWU5ITUMrYVI5?=
 =?utf-8?B?cDF2MXRNQ1ZaYzFhVlZTdWI1ZHNQczVDYkVtaFlDY0tJaXdpc0R0T2lVcnRW?=
 =?utf-8?B?QXVHQnBsRGV4Z3dYWm9WMTBKVWxybWZod3NRUmhSMlFGbFpPYnV4d2JrUThz?=
 =?utf-8?B?UkxHbUJraHBmaHMvNHlBZUNnNGRYbGNuaDlBVXdJdTh0OTE2bTQ3MXhOZkNa?=
 =?utf-8?B?ZTFGeEdFWWZZZmJ4aFc4cW83Y0ZaSndZQk9BQWNvWVdUY3hnNjJ3RTlZM2Jh?=
 =?utf-8?B?RW9SS3pMbWV2UDJaaFRBb0JUNXpZMWl1RkdpU2VSQmwvUXVnSk1zaXBWWDZJ?=
 =?utf-8?Q?pS1Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a174211-c831-4d50-da4c-08da0256cca6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 05:28:25.4182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FN/pwdvijm51E0uCUaiqEB7LjwaxVFrZTKZjiet07Yv7QlMyEHv8D2Dg0BhIqs10
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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



On 3/10/2022 3:35 AM, Mario Limonciello wrote:
> `smartshift_*_power` files are showing up on some OEM programs on
> the APU instead of the dGPU.
> 
> Adjust the logic to the function `ss_power_attr_update`
> to detect whether or not the attributes should be exported.
> 
> The existing checks that are dropped are already included in
> `amdgpu_device_support_smart_shift`, so this can be simplified.
> This causes attributes to not be shown on APUs.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index cbbbd4079249..ccd0648c6789 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1884,10 +1884,7 @@ static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device
>   {
>   	uint32_t ss_power, size;
>   
> -	if (!amdgpu_acpi_is_power_shift_control_supported())
> -		*states = ATTR_STATE_UNSUPPORTED;
> -	else if ((adev->flags & AMD_IS_PX) &&
> -		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
> +	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>   		*states = ATTR_STATE_UNSUPPORTED;

SS 1.0 attributes are supported on APU devices. Will this work on those?

Thanks,
Lijo

>   	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
>   		 (void *)&ss_power, &size))
> 
