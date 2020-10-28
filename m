Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F456C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 07:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F5E223C7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 07:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k2Q2VVfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F5E223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED2F6E488;
	Wed, 28 Oct 2020 07:21:43 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690041.outbound.protection.outlook.com [40.107.69.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B956E488
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 07:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLAXF6OhV7o+ojZ6iiq4pQsMS4/kuA6pyRvDCz4MK9IZKIRPgElot4c9fy2azzE6RtVk/9zS8AiCvPXm9gkEEI2nkTFzNjDcltEwgYIRH4eKJkF1tL0nEU2D0ej2C5P1NyfImvXi/PzWZyqy46NsfHlqX+nldsttyPflCEGgmh9JZTqkDjEi1XKenIZrQhLpgNsDccX9PRnrsGOi70OBwUIPbXh6ZaYziQlXwWc7pFiJZ+mPTXk1PfvnX81RZNXV9CMcIE3yiQDU/zn8qYeNjAjevkwWZLVRSvAsTyv1aOdntH7IUpZZl7iPO57sI3Ze4QTfDlsP5xNnrREjzfsWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPBIf51QB/WrOut+/2hSIruZxcz1zbsLj+O1Yd9CCh4=;
 b=h8pu/jbND+YtykHo+yDMfyaSiInzMXzpQch/8a0WQGFhoYyXW3+yyWIULoRs2Tk2ggWg06722C3wSRdnq/Kp19fUPTUG0KKIayKKaCmY+CUGv9YZhZIygLlmSbb0LCWXqCK9JwNSrv5MXxivoJPLuzvvoW/CgCcGsVLN3d1hhXQH+it4GKxmpRXBp8QbVsu3prAc73AQM37HPxvd/YdGRkLPKOkkSeC/pJbpLBOm2tg7GUqPm5296I/GuE52cJuf+OyBub0OdspmA5lERiYf309f9GiUGEKWwkkx7M4WaGiWnnA3gCFCPDwptGcvsMmg1BsznBZUkbVIMNHu1NRUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPBIf51QB/WrOut+/2hSIruZxcz1zbsLj+O1Yd9CCh4=;
 b=k2Q2VVfjctG1SUgGDPt14+kMb2TxxSEErzVMFWnieznhmlT/gulWLvKpSbP4hQOakJg+8LbPeNJaFawNQ3jo1aXssOEWpJnmmtsDjYVkqMNDebFJmq8ULxLhW8rM2BCm+wATeZlPJeeaTnXQ81/Q5uth6TBWzWfV9sLPoVEFtcc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB2541.namprd12.prod.outlook.com (2603:10b6:300:e5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 07:21:39 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.018; Wed, 28 Oct
 2020 07:21:39 +0000
Date: Wed, 28 Oct 2020 15:21:46 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH 01/10] drm/amd/pm: update the smu v11.5 smc header for
 vangogh
Message-ID: <20201028072146.GA1767271@hr-amd>
References: <20201027094133.21881-1-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HKAPR04CA0009.apcprd04.prod.outlook.com (2603:1096:203:d0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 07:21:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 567ef72d-a85c-40c9-5241-08d87b121c8e
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB254118FC0129E4B8C2AF81BEEC170@MWHPR1201MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RV106qcJaa+3UwqpxwUWJwaRn8g6HG1uGfMyFdvEQsHQk4oba6xStUf0Mdh8bMVARyumIAnFwmdIILmirzl6O+N4eHsTTtabrKZua9v6Fw8LyP1Y3i/mzP3AclgPrpKqDmFf7y38MZcUImR/G7jceM0I3YcMo5QLW1EHj5sYAV1/wGQUrNwZBHb36rHz0Ak/nOV7eAKEHxnXJe6EvmbxgsXXgW0Ywn7asajkzofcN9wA/3SLpAZBfe42Nj5kniqlU+w863cbxEHIES8iosAv5Aiju0yk5Ij4x+OCZB0s7XqpawxTdHqM4xFmHwgwwXR/wbnXVI1HzwJwmEWOJlAMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(15650500001)(5660300002)(66946007)(83380400001)(26005)(6636002)(6496006)(55016002)(1076003)(66556008)(956004)(66476007)(86362001)(478600001)(8936002)(6666004)(4326008)(16526019)(6862004)(52116002)(33716001)(33656002)(2906002)(186003)(9686003)(8676002)(54906003)(316002)(19627235002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fd2S1CCucSLBOu6JuUIMaFnWehWWU1xtdSdC73MZ1ull4OJaP4YSA2p8bS0cpNqN1ksTTOrb+4Pcc2jeW1KUWv/rdqOTo0RZp1TUTOe4NW6PiBEh3KpBmN4teN4zQt/tnRmXo29MBxPOatD1KSNa06oz74XFVrrLAn07BS3CL6feCzOcQxnwnEPzmD5eofX4piVvCGR1BfpM0DioSrxXk5zMy4lMpWwJH9+9VsHfmfBDELsvg+S20ypQyP2tcdmR3PbbNCzLBiIFynZ/VrICyzPT+LnLFS8vpBz15bIKZu7hqUi+KVK5ufDZEfn9QjZ4qS2xGJoJLrPQTRlQ2iqfFkvWjZog6uU/8KDnwqkEWaTenEZtGTziNw7ix61GYmgGpChRGjZP7db7qbjRIdHkIjIiV6bonT+1v2HyGYKwEm+FKXOi2MbPLWGynrPYb0AEHv0OAvAtD2KRl6jHT32sZlTi/AuJGdtGnrMlHwyy+FmYapkuP+IGQJiJmPrIuiby7sh/yi7hXrFRJ3c6jtbGMVa2ONqwTnFGm64q1PKvsv9By1ahRJPeqvhfQj8jQRLVqnqTN6LIdWhi7jpHr+pe8UpJuBok6b8Aiq9B/Jzj6Kb3hpWRF8Sr8y0OjFcUYIF9pMGI0Ay7SPQt/clw+55voQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567ef72d-a85c-40c9-5241-08d87b121c8e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 07:21:39.6779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89hiqp9NjAcQMX8Ovo5/DHUDj1R3HGhLaik3RL6jT6T3Z/5cBFuTXLc0Nchb0Cew17Iu2VS94/GkYWeL+6nYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2541
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Shimmer" <Xinmei.Huang@amd.com>, "Zhu, Changfeng" <Changfeng.Zhu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 27, 2020 at 05:41:24PM +0800, Du, Xiaojian wrote:
> This patch is to update the smu v11.5 smc header for vangogh.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h | 114 +++++++++++--------
>  1 file changed, 68 insertions(+), 46 deletions(-)

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> index 55c1b151a68d..1ada0eb64663 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> @@ -32,55 +32,77 @@
>  #define PPSMC_Result_CmdRejectedBusy 0xFC
>  
>  // Message Definitions:
> -#define PPSMC_MSG_TestMessage 0x1
> -#define PPSMC_MSG_GetSmuVersion 0x2
> -#define PPSMC_MSG_GetDriverIfVersion 0x3
> -#define PPSMC_MSG_EnableGfxOff 0x4
> -#define PPSMC_MSG_DisableGfxOff 0x5
> -#define PPSMC_MSG_PowerDownIspByTile 0x6 // ISP is power gated by default
> -#define PPSMC_MSG_PowerUpIspByTile 0x7
> -#define PPSMC_MSG_PowerDownVcn 0x8 // VCN is power gated by default
> -#define PPSMC_MSG_PowerUpVcn 0x9
> -#define PPSMC_MSG_spare 0xA
> -#define PPSMC_MSG_SetHardMinVcn 0xB // For wireless display
> -#define PPSMC_MSG_SetMinVideoGfxclkFreq	0xC //Sets SoftMin for GFXCLK. Arg is in MHz
> -#define PPSMC_MSG_ActiveProcessNotify 0xD
> -#define PPSMC_MSG_SetHardMinIspiclkByFreq 0xE
> -#define PPSMC_MSG_SetHardMinIspxclkByFreq 0xF
> -#define PPSMC_MSG_SetDriverDramAddrHigh 0x10
> -#define PPSMC_MSG_SetDriverDramAddrLow 0x11
> -#define PPSMC_MSG_TransferTableSmu2Dram 0x12
> -#define PPSMC_MSG_TransferTableDram2Smu 0x13
> -#define PPSMC_MSG_GfxDeviceDriverReset 0x14 //mode 2 reset during TDR
> -#define PPSMC_MSG_GetEnabledSmuFeatures 0x15
> -#define PPSMC_MSG_spare1 0x16
> -#define PPSMC_MSG_SetHardMinSocclkByFreq 0x17
> -#define PPSMC_MSG_SetMinVideoFclkFreq 0x18
> -#define PPSMC_MSG_SetSoftMinVcn 0x19
> -#define PPSMC_MSG_EnablePostCode 0x1A
> -#define PPSMC_MSG_GetGfxclkFrequency 0x1B
> -#define PPSMC_MSG_GetFclkFrequency 0x1C
> -#define PPSMC_MSG_AllowGfxOff 0x1D
> -#define PPSMC_MSG_DisallowGfxOff 0x1E
> -#define PPSMC_MSG_SetSoftMaxGfxClk 0x1F
> -#define PPSMC_MSG_SetHardMinGfxClk 0x20
> -#define PPSMC_MSG_SetSoftMaxSocclkByFreq 0x21
> -#define PPSMC_MSG_SetSoftMaxFclkByFreq 0x22
> -#define PPSMC_MSG_SetSoftMaxVcn 0x23
> -#define PPSMC_MSG_GpuChangeState 0x24 //FIXME AHOLLA - check how to do for VGM
> -#define PPSMC_MSG_SetPowerLimitPercentage 0x25
> -#define PPSMC_MSG_PowerDownJpeg 0x26
> -#define PPSMC_MSG_PowerUpJpeg 0x27
> -#define PPSMC_MSG_SetHardMinFclkByFreq 0x28
> -#define PPSMC_MSG_SetSoftMinSocclkByFreq 0x29
> -#define PPSMC_MSG_PowerUpCvip 0x2A
> -#define PPSMC_MSG_PowerDownCvip 0x2B
> -#define PPSMC_Message_Count 0x2C
> +#define PPSMC_MSG_TestMessage                          0x1
> +#define PPSMC_MSG_GetSmuVersion                        0x2
> +#define PPSMC_MSG_GetDriverIfVersion                   0x3
> +#define PPSMC_MSG_EnableGfxOff                         0x4
> +#define PPSMC_MSG_DisableGfxOff                        0x5
> +#define PPSMC_MSG_PowerDownIspByTile                   0x6 // ISP is power gated by default
> +#define PPSMC_MSG_PowerUpIspByTile                     0x7
> +#define PPSMC_MSG_PowerDownVcn                         0x8 // VCN is power gated by default
> +#define PPSMC_MSG_PowerUpVcn                           0x9
> +#define PPSMC_MSG_spare                                0xA
> +#define PPSMC_MSG_SetHardMinVcn                        0xB // For wireless display
> +#define PPSMC_MSG_SetSoftMinGfxclk                     0xC //Sets SoftMin for GFXCLK. Arg is in MHz
> +#define PPSMC_MSG_ActiveProcessNotify                  0xD
> +#define PPSMC_MSG_SetHardMinIspiclkByFreq              0xE
> +#define PPSMC_MSG_SetHardMinIspxclkByFreq              0xF
> +#define PPSMC_MSG_SetDriverDramAddrHigh                0x10
> +#define PPSMC_MSG_SetDriverDramAddrLow                 0x11
> +#define PPSMC_MSG_TransferTableSmu2Dram                0x12
> +#define PPSMC_MSG_TransferTableDram2Smu                0x13
> +#define PPSMC_MSG_GfxDeviceDriverReset                 0x14 //mode 2 reset during TDR
> +#define PPSMC_MSG_GetEnabledSmuFeatures                0x15
> +#define PPSMC_MSG_spare1                               0x16
> +#define PPSMC_MSG_SetHardMinSocclkByFreq               0x17
> +#define PPSMC_MSG_SetSoftMinFclk                       0x18 //Used to be PPSMC_MSG_SetMinVideoFclkFreq
> +#define PPSMC_MSG_SetSoftMinVcn                        0x19
> +#define PPSMC_MSG_EnablePostCode                       0x1A
> +#define PPSMC_MSG_GetGfxclkFrequency                   0x1B
> +#define PPSMC_MSG_GetFclkFrequency                     0x1C
> +#define PPSMC_MSG_AllowGfxOff                          0x1D
> +#define PPSMC_MSG_DisallowGfxOff                       0x1E
> +#define PPSMC_MSG_SetSoftMaxGfxClk                     0x1F
> +#define PPSMC_MSG_SetHardMinGfxClk                     0x20
> +#define PPSMC_MSG_SetSoftMaxSocclkByFreq               0x21
> +#define PPSMC_MSG_SetSoftMaxFclkByFreq                 0x22
> +#define PPSMC_MSG_SetSoftMaxVcn                        0x23
> +#define PPSMC_MSG_spare2                               0x24
> +#define PPSMC_MSG_SetPowerLimitPercentage              0x25
> +#define PPSMC_MSG_PowerDownJpeg                        0x26
> +#define PPSMC_MSG_PowerUpJpeg                          0x27
> +#define PPSMC_MSG_SetHardMinFclkByFreq                 0x28
> +#define PPSMC_MSG_SetSoftMinSocclkByFreq               0x29
> +#define PPSMC_MSG_PowerUpCvip                          0x2A
> +#define PPSMC_MSG_PowerDownCvip                        0x2B
> +#define PPSMC_MSG_GetPptLimit                          0x2C
> +#define PPSMC_MSG_GetThermalLimit                      0x2D
> +#define PPSMC_MSG_GetCurrentTemperature                0x2E
> +#define PPSMC_MSG_GetCurrentPower                      0x2F
> +#define PPSMC_MSG_GetCurrentVoltage                    0x30
> +#define PPSMC_MSG_GetCurrentCurrent                    0x31
> +#define PPSMC_MSG_GetAverageCpuActivity                0x32
> +#define PPSMC_MSG_GetAverageGfxActivity                0x33
> +#define PPSMC_MSG_GetAveragePower                      0x34
> +#define PPSMC_MSG_GetAverageTemperature                0x35
> +#define PPSMC_MSG_SetAveragePowerTimeConstant          0x36
> +#define PPSMC_MSG_SetAverageActivityTimeConstant       0x37
> +#define PPSMC_MSG_SetAverageTemperatureTimeConstant    0x38
> +#define PPSMC_MSG_SetMitigationEndHysteresis           0x39
> +#define PPSMC_MSG_GetCurrentFreq                       0x3A
> +#define PPSMC_MSG_SetReducedPptLimit                   0x3B
> +#define PPSMC_MSG_SetReducedThermalLimit               0x3C
> +#define PPSMC_MSG_DramLogSetDramAddr                   0x3D
> +#define PPSMC_MSG_StartDramLogging                     0x3E
> +#define PPSMC_MSG_StopDramLogging                      0x3F
> +#define PPSMC_MSG_SetSoftMinCclk                       0x40
> +#define PPSMC_MSG_SetSoftMaxCclk                       0x41
> +#define PPSMC_Message_Count                            0x42
>  
>  //Argument for  PPSMC_MSG_GpuChangeState
>  enum {
> -  GpuChangeState_D0Entry = 1,
> -  GpuChangeState_D3Entry,
> +  MODE1_RESET = 1,
> +  MODE2_RESET = 2
>  };
>  
>  #endif
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
