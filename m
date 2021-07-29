Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4BDC4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 08:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E04361074
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 08:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E04361074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4346ECED;
	Thu, 29 Jul 2021 08:39:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711396ECEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 08:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYBCn7IyCPcSdutYmT21orQJUDLg8pd9LlrfIS/Iie58Ai6vjv+HhhQaM9647MbimWFLm/0o9AXw1Cegdl1MOf5fyLBT45BgCOAQgTr7yn8zXsvcYBo6KlF8GIWZpoqvrZofW/6Eg1x1n2KfxIAc3ivb68gsvZOLWS8d2mPJAdK3sTE1sFW2npk51eahrOCmHUGq3i8/tSX91deYtOiD0/x6L67B4PURYKdU+kbLZ2/rVwcL8QQCGrNrlTboAVielItJaIcQ8HK8y3MB+bq46lvFBh4YciVnywCKs59aJ2PVXrinFCelCCEeM7ONtVj5+mCD4/lZuJO56P4HmxDTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Mh4IZSv36P2KqG3UYCLCqVuzmC8Ktk5sf3LgqvDxEg=;
 b=dj1KfVV1RbZcNGxJ0XQaNrpS0gcHjzbeAhPAmaYtpBq2/yKo2rXzgRi1z+k4U2h+O5K46LDo55R9WcHg9qB8uH3Bp/ZjQOhfBK/GsRjqzJ5kTfYHbsl2vcXw6yeCNXFLjz04JurTUxZJRSXNBIs78DDjI5FtwbN0lGL7rhFk49xLOCidoPEIBO1R5UEV+D9EqQKaw8I7j4w0Z6xK4pnFP/m8x82M+lCuZXTpoVARDrrgTMCBdO7UBeVxqUBSfk4cqTnk0Y1BbGesLUIXvh5rcHQgBA644FTXzXtnwUosJWVeGZNJXPkv7o0ZmbTA1AyebDZmLn9xS0n9p/wmNhV32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Mh4IZSv36P2KqG3UYCLCqVuzmC8Ktk5sf3LgqvDxEg=;
 b=I7gRQV858Dv9lZqBu2NZ/OwTDTGz4YSEAUFRnxM681fKMOrxAWSynlcvUgnl79pf2mZ8qxmG4xgSAzpf6okPsHNIeTxG5WsCVy2HIZ6ZO9yIWOf0mdhb3tT5525DHXEgjTgFmaAOD00NwdOcezo2hlcWwtrnzvt0Zqsu4F1z7Wk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Thu, 29 Jul
 2021 08:39:31 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4373.020; Thu, 29 Jul 2021
 08:39:31 +0000
Subject: Re: [PATCH v3] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210729075523.2557382-1-yifan1.zhang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <9cb5858b-dc4a-6895-b96f-e85242417000@amd.com>
Date: Thu, 29 Jul 2021 14:09:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210729075523.2557382-1-yifan1.zhang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BM1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::19) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Thu, 29 Jul 2021 08:39:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d50c69d0-3e84-494e-72cb-08d9526c623c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5319F2CB4C5B752CEAE89C4097EB9@BL1PR12MB5319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aL/gnoRgluC26pWgZ6jJ4euJfd57f/zxtmzp8IiYcqfRQSfVrCgML/QY8bDiuqFAtF0RJgrw2FvG2OVO9ALj57I6OXph0GFidkYcX+SRzGVzNUym7lNVE4NVXO2lQ8dnXaWCqze+z7GH2SA1lVten0jXB3a11GzYV84XkQqeeXcV4JgJtjkArtScHJ1s4CTjPHkvlb0b0Tc9tygiGLAIcN4DkI/hkklVaxIURirSDK3fbv4PINIyEhcwlnBsviPaOqzMEZgz5kGs+/fj7JGb9KkVHjIufwPb4UeredM9e1zSaZAElgzDXRwlCO5DE+TrFzkb6JbVa0b8ASAQzxOuMLIICNvzLjInoWqtQT0wlNfx4OrOHhsHVYQ3BZIXPSPhfs+UE98mBpPl6NQ8RVCHPk3KM2vrweX0V4IKC9/21p0J0ujPfqmzaKcRVcxhon783KmEJ8ElTGRDSJRAaG0ehgbEwomCH84HLUdfVMndDbSTeGviaEn6pP7v0XZdMtZHmXmI4pKl5uYm0tj/qdyczXEEu6xEBBD6ISQWsQOV2QfildCdG3A1stwhd60H+oU8z1+XC3vih5wjRs3atCKJlLhAA58zlpZ4UWSsqV2IN3d+uPU5KhuzVMqfl61k1mLC7dqek250CD/nJ3OYtShVEvDacawcEtgiDOSOrxOPVjs3kD5KIch0Nna2/WXG3U8Amj8loXEp747whgbPCpZe1FrszEMEktMhtn4rKwMnHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(26005)(66476007)(66556008)(5660300002)(31686004)(66946007)(2906002)(6666004)(2616005)(186003)(86362001)(31696002)(53546011)(478600001)(83380400001)(38100700002)(316002)(36756003)(8936002)(16576012)(8676002)(956004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RktkUU5wclVOR0F3ZDJNN3FIekt2WEI4bWFWWWdNZFFFTWdjSTJYbmZZTjR6?=
 =?utf-8?B?d3A2Q3dITEJCRHVmZkY4WGcvUVgyZkRjY2k0VXo2ME9kV2Nreml2MEZ3cVBT?=
 =?utf-8?B?WWtZdDZ2aFltS1BlVkVOajBKUXZDZEJyMm53L3RKR1FkbndDUWNEM1RPdEE2?=
 =?utf-8?B?bkNCYkpWVVB5cG81RldOeTBReGcyU3hzbnBZNlNzdjRjb1FnMnZIc2p0cVZS?=
 =?utf-8?B?WkY4WklwUXhlWWl2bHlsUWRxRnJlZiszZ3hUZndzZ2pXdEQzem9kSncxVTFo?=
 =?utf-8?B?bXluRFdPU3RmZjJMSWxnbkx1ZDBOUzVFSFB6cHh0TnpBbk9kT3JTV2drekFD?=
 =?utf-8?B?ZGFlaEEwdWJLS1FWVVJVUTJKM1NQME1FbGt2VExSd0Z5dU9RTjMyY3BlYWtR?=
 =?utf-8?B?dGcrbkExUkxvbzFReW5TM1UyMXVVd1Z4QTZxdjl5VTVHM3NNL3ZVTForSzl3?=
 =?utf-8?B?UjhxNWNnVWNkaXNGMU1UVjVsaWU5dXFXdkxrVVVzakdOS0FQWjlsREN1WEw2?=
 =?utf-8?B?cTc5bGtWdm9IUEZBeFhwRTBnNVIrTWZuc05wR00rcUpRSVp5OFJhT0JmTndO?=
 =?utf-8?B?ZzR6bTVuNC8wdlRhdTV4RDJoWGl3bXMySHJRNElDMklxaXJnY2ExNHBQNHZ1?=
 =?utf-8?B?czNrdjJSRlBDK3h6SlpSRFlTRkxmMHRsZXVpN01ScjY1TVVyLzhFL3Vja0ZR?=
 =?utf-8?B?dEJFcjRrK3pGWXRJakFyTkF5RzdTT1FVUjl4aWVPcGZhQjBFOXNRNmo1N2xn?=
 =?utf-8?B?L2M5bkhNQkxiQmNYUmVtUEw1VG4zVUdHRGZDUGN1bXFIOHRWMG50TCtOZ1pp?=
 =?utf-8?B?Wi9MRkVsRytQSHphN0Rhd3RKSlUvdnFYYnZiOW56M1d4bHkwL09iVGxHV29J?=
 =?utf-8?B?VkJkSlc4cThHWjBmYy9Xb2lvb3Q2K0VsVUFoL254REFqMjlPelZnVEVkU01u?=
 =?utf-8?B?THpVNHBsbWxQdUVHMVJadllUU3c4L1ltQXdHcERWdzdaQmwxY2YyREhROGVa?=
 =?utf-8?B?OXpCUkxwY0dBN1h6c2VDM0ZEY1AwV1R6d2w5S0F0aDg5ZVVtaTN4R21WSkR2?=
 =?utf-8?B?TFpCMWRQbnQvc2JpbWdUT3dHKzZ4NW5kbmJoa1JBZStoVktWbG9CWXhjdTYy?=
 =?utf-8?B?SUZ3V0FoL2cvaXQ1QW05azFiR0JoOGIvS3MxSnRYQ0JldGhkU042Rjk0YkNJ?=
 =?utf-8?B?SFlveXdiZlFPZ01obkhUT0EzalRpcW5mZndyQTJxS21TNUFRMWNocGI2V05z?=
 =?utf-8?B?ZHd6bVhWZEtNalBkYjViZEpDV3RFQk9mOTVnSmIyZzZTNEJPTEc0TVFCWC84?=
 =?utf-8?B?NkFwemxUYWNtUEZHTW8xQ01tS2dKZXMzTU5WN0Z0SlZWSGpsL0ZTbTFiNkQr?=
 =?utf-8?B?SWpYL0VSMjFIOUVtMnk1QnFwVkR5cmNpT1pnOVRYdjFUdDNNY0xlN2xFanpJ?=
 =?utf-8?B?Zm1MTXZOa1ZPc25xV0wvbTdBYXFqMCtwc01ublRSdkZVcHFjdTR6QTNXVGRQ?=
 =?utf-8?B?c3FJdlJsbWdpdFh4YURWV1MrMW9WMWtnSXBxSWJROWhMSEwxVm8wL1MvYmlz?=
 =?utf-8?B?SUloaEFmaG9WTXRNVjlNeVptLzZSeGJ2TDY2Y0VSTDZ6UXY0UGJ6NTU0K00z?=
 =?utf-8?B?UmYzWXJtYUJ4bjJwblNrMnYvcHN3N21jVXpiT21SS0F5MjNFaUFyQnhDTkNo?=
 =?utf-8?B?T0J3dEk3OHR4MTlxYlpoazBHRlpyQXcrdjBrOEM1dDM1MGtESlVBbE5xeHZ5?=
 =?utf-8?Q?/M3rs15c0AA3G01TDen7zA7mb/xzEenF9Hwp2Qq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50c69d0-3e84-494e-72cb-08d9526c623c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 08:39:31.0886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmVPdp5dpaZICf4688ZpGqIgsljTNdzPofAJPSeYJTb1L7IjWz0N0wrmybBvagzF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/29/2021 1:25 PM, Yifan Zhang wrote:
> If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
> Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 03acc777adf7..a35f1d041a85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3675,7 +3675,18 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>   	if (ring->use_doorbell) {
>   		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
>   					(adev->doorbell_index.kiq * 2) << 2);
> -		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> +		/* In renoir, if GC has entered CGPG, ringing doorbell > first page
> +		 * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
> +		 * workaround this issue. And this change has to align with firmware
> +		 * update.
> +		 */
> +		if ((adev->asic_type == CHIP_RENOIR) &&
> +		    (adev->gfx.me_fw_version >= 0x000000a5) &&
> +		    (adev->gfx.me_feature_version >= 52))
> +			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> +					(adev->doorbell.size - 4));

For better readability, perhaps
	
	if (extended_doorbell_range(adev))
		...
	else
		...

and move the ASIC and FW version check inside extended_doorbell_range.

Thanks,
Lijo

> +		else
> +			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
>   					(adev->doorbell_index.userqueue_end * 2) << 2);
>   	}
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
