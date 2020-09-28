Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFE2C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 21:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DE12083B
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 21:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tFbmcbf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DE12083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A3289E52;
	Mon, 28 Sep 2020 21:41:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E6389E52
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 21:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK+DEm7slwzBNdPzrjKCAEsr7N6gtvhlFKcmHXtqclKtZqI7z1wVKtyMBAw4Wy8ErPWTTB09DXe+OvC438RGnenVHGfuK+RuijSG9rGeQrIvAOCQAzUeiHzQWNYReygtPbqMouhkrorHd1kCE1nhIUoQti4eIQAjXXWQjLm861b6tVx2texM307jEetvnzFTHQ2MDMvCcSeAUdYvto9Cnsjz30iyVuRT88e5fYfUzyeEkSZ+nIfNzV+j2JZnPIdA4WD/K22ZUUVcJ16Vt4wFS8Fuc8Hc16OKmFmvuKIT1WTZJbeZbPgDNrZJ1Ttv6Vhse0c8Sx6GemJB49c5UfuKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODsnqTG09c6jFisUKbmYiLW88TWYok+9Fv7FrTXVlGA=;
 b=f5Aa2DaLW8/tducCKnRTl0w1yUj44KJgSEpV/YCI8xpO7GnLOXlYHrS2BH4+w0Lwv32itl0qvVkUCKEJnbeaM9ncCDS7w7yChw/v0MDs3QVIGV0fpps2OS+xOr2ZwMEYwm/4Ohhw/HALD3vyDQiRx/4Ep3h4sfPUQ0SZAU7cIfnIVUS0upyDhyiQvXGYswpvpl6VESvsKB5SV0I8e56DaYyOfGXcf/IQzWBOtmUkl0XBXdEqjQy8tCFbugwGd0svNo5Skcx9l2A6qhO0ci/S6Gc3gVR1Awhl813fbk4W6kFU324GVWs58UDZ8l2ircSNn4sW9C+NqnQtRqHtiuKHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODsnqTG09c6jFisUKbmYiLW88TWYok+9Fv7FrTXVlGA=;
 b=tFbmcbf9LBk5Upie0ZUl2ZlTMsaq4kJ7HvB7bVfbyzh6Bsg/QVCrlx91GviLlsTPSMYSHH0iJWshIJd1elvflZRE70chA0fa4JX2RV3OdWTyx/TbypKGc36WdUuOSmNPZUkswVuzRpXsLPzbKJIEE5Qvkim5CjW3ILM7x0sNRbE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 21:41:32 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 21:41:32 +0000
Subject: Re: [PATCH 27/45] drm/admgpu/powerplay: add smu v11.5 driver
 interface header for vangogh
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-27-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <f70487c4-8df2-8275-54fa-d14710257b47@amd.com>
Date: Mon, 28 Sep 2020 17:41:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925201029.1738724-27-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::36) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 21:41:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4c932b4-43fa-48cd-b14f-08d863f7436e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4385B71AEAE821F1621EAFED99350@DM6PR12MB4385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lczzN/mD1rZHQm2MOSt0JnlEr4PPAHDID/HYx1cklQWDA3wCcJyT+Iu+kLDwDUOdLnZd0TdxDlhgQNZcLGZhFUvDMV6Ic3y7WdaNU1QiVvW+crAiLy4BP5YD/AKqT5cV0ldo9HDhtMwFPHGiilyvAyZY2v2R3ZrtsFk/BxBddZS7DVJGl880uMltNaT2MtRT3e90p/Ws4bFS7gnjjbULek0yfDnBhqohx5jOolIcpsSeN8poRgAtUsvT2KCRlpnuc9SPzn8NfqlJtn29J+jgV5v0rGj5bMz+7pQoeInaEpij9iCZMB9sPuhnqGXXGT5rlww6ABOwGwSD6+mg2kfizWfb1ixAwLOGGT4rexKl557uwDRgC+7W+rjNgtSHZZZsLBeXNkewZlItGYZXm+tD41GtKf6E0Vd6qb2U7moqj/xpUCJxsSBOXUp32yJr9RpA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(44832011)(6506007)(53546011)(26005)(54906003)(36756003)(8936002)(186003)(83380400001)(52116002)(316002)(66946007)(5660300002)(16526019)(478600001)(8676002)(6512007)(6486002)(2616005)(956004)(2906002)(66556008)(66476007)(4326008)(86362001)(31696002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5yLB9Ul4rni+XMaQTI/wbbNjZ9oeLDHg6oQcShzHldzfhPK5zM+Pq2ZSVRO1vw6KOHq+c+7wS3v9VsSLSDisAGHaIN2EEJSI3FP8wR4ugGBFGk3C9j75lkmba4K0ZittwefX43CfTVElanOKud2SR5HrP7O9+MsPhAh+b4v8EgMkr6jPTB0GrYQ0a5X4MzWBAeMP+XtKnapH9yzYH/y0yEq5e2ZmQNwv6/MFgtACjTAHARKgY8DvI5EYbL27+tNDzjaqx7DTu51YOeIfWDMmE0SkCdBypO/6ROWjA69eXOQx+4YOMlZb1XuYb8QHJ/LqO4C6SEFlWg4RpOBIVic5TOnVCwqPHxbcpcJDdYMlFW25o99ZikWQXjCWrTiTVnAwHwKdZQi836qbnsHms44FOoy7GK9lrJKvQT8edhMTB3/mAEyPlUDGXchyhmRmsVZkqRiF9SFbCVsV9D5FWnx+8AO+WE8JWpqA8TdrVIfVc8LPRBfksYJzchxwU/m5slJF5Obw7hb0KTdbiltURH7cOR976OikG3caCpe/H5jYfSUd9OSngzTeVYhcvMxZh/7axA51YiVPgr5jxzq+1F1HjpN7vVY5+SHhyRXQVNzWZqZEu0eO6ko4Ph22X9D8AJfkCWG9JLsVehLMR8v0QBn49w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c932b4-43fa-48cd-b14f-08d863f7436e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 21:41:31.9220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lx4kM0bN51Z8AsuUuR5pj9k7jZLwGWCaMikrctVClXbr/fhLL6c4dylLb4OQZDHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-25 4:10 p.m., Alex Deucher wrote:
> From: Xiaojian Du <xiaojian.du@amd.com>
> 
> This patch is to add smu v11.5 driver interface header for vangogh.
> 
> Signed-off-by: Xiaojian Du <xiaojian.du@amd.com>
> Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../drm/amd/pm/inc/smu11_driver_if_vangogh.h  | 239 ++++++++++++++++++
>  1 file changed, 239 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
> new file mode 100644
> index 000000000000..20f8c6f460b8
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
> @@ -0,0 +1,239 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __SMU11_DRIVER_IF_VANGOGH_H__
> +#define __SMU11_DRIVER_IF_VANGOGH_H__
> +
> +// *** IMPORTANT ***
> +// SMU TEAM: Always increment the interface version if
> +// any structure is changed in this file
> +#define SMU13_DRIVER_IF_VERSION 2
> +
> +typedef struct {
> +  int32_t value;
> +  uint32_t numFractionalBits;
> +} FloatInIntFormat_t;

GNU-style indentation as opposed to Linux-style
throughout this file.

Regards,
Luben

> +
> +typedef enum {
> +  DSPCLK_DCFCLK = 0,
> +  DSPCLK_DISPCLK,
> +  DSPCLK_PIXCLK,
> +  DSPCLK_PHYCLK,
> +  DSPCLK_COUNT,
> +} DSPCLK_e;
> +
> +typedef struct {
> +  uint16_t Freq; // in MHz
> +  uint16_t Vid;  // min voltage in SVI2 VID
> +} DisplayClockTable_t;
> +
> +typedef struct {
> +  uint16_t MinClock; // This is either DCFCLK or SOCCLK (in MHz)
> +  uint16_t MaxClock; // This is either DCFCLK or SOCCLK (in MHz)
> +  uint16_t MinMclk;
> +  uint16_t MaxMclk;
> +
> +  uint8_t  WmSetting;
> +  uint8_t  WmType;  // Used for normal pstate change or memory retraining
> +  uint8_t  Padding[2];
> +} WatermarkRowGeneric_t;
> +
> +#define NUM_WM_RANGES 4
> +#define WM_PSTATE_CHG 0
> +#define WM_RETRAINING 1
> +
> +typedef enum {
> +  WM_SOCCLK = 0,
> +  WM_DCFCLK,
> +  WM_COUNT,
> +} WM_CLOCK_e;
> +
> +typedef struct {
> +  // Watermarks
> +  WatermarkRowGeneric_t WatermarkRow[WM_COUNT][NUM_WM_RANGES];
> +
> +  uint32_t     MmHubPadding[7]; // SMU internal use
> +} Watermarks_t;
> +
> +typedef enum {
> +  CUSTOM_DPM_SETTING_GFXCLK,
> +  CUSTOM_DPM_SETTING_CCLK,
> +  CUSTOM_DPM_SETTING_FCLK_CCX,
> +  CUSTOM_DPM_SETTING_FCLK_GFX,
> +  CUSTOM_DPM_SETTING_FCLK_STALLS,
> +  CUSTOM_DPM_SETTING_LCLK,
> +  CUSTOM_DPM_SETTING_COUNT,
> +} CUSTOM_DPM_SETTING_e;
> +
> +typedef struct {
> +  uint8_t             ActiveHystLimit;
> +  uint8_t             IdleHystLimit;
> +  uint8_t             FPS;
> +  uint8_t             MinActiveFreqType;
> +  FloatInIntFormat_t  MinActiveFreq;
> +  FloatInIntFormat_t  PD_Data_limit;
> +  FloatInIntFormat_t  PD_Data_time_constant;
> +  FloatInIntFormat_t  PD_Data_error_coeff;
> +  FloatInIntFormat_t  PD_Data_error_rate_coeff;
> +} DpmActivityMonitorCoeffExt_t;
> +
> +typedef struct {
> +  DpmActivityMonitorCoeffExt_t DpmActivityMonitorCoeff[CUSTOM_DPM_SETTING_COUNT];
> +} CustomDpmSettings_t;
> +
> +#define NUM_DCFCLK_DPM_LEVELS 6
> +#define NUM_DISPCLK_DPM_LEVELS 6
> +#define NUM_DPPCLK_DPM_LEVELS 6
> +#define NUM_SOCCLK_DPM_LEVELS 8
> +#define NUM_ISPICLK_DPM_LEVELS 6
> +#define NUM_ISPXCLK_DPM_LEVELS 6
> +#define NUM_VCN_DPM_LEVELS 8
> +#define NUM_FCLK_DPM_LEVELS 4
> +#define NUM_SOC_VOLTAGE_LEVELS 8
> +
> +typedef struct {
> +  uint32_t fclk;
> +  uint32_t memclk;
> +  uint32_t voltage;
> +} df_pstate_t;
> +
> +typedef struct {
> +  uint32_t vclk;
> +  uint32_t dclk;
> +} vcn_clk_t;
> +
> +//Freq in MHz
> +//Voltage in milli volts with 2 fractional bits
> +
> +typedef struct {
> +  uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
> +  uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
> +  uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
> +  uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
> +  uint32_t IspiClocks[NUM_ISPICLK_DPM_LEVELS];
> +  uint32_t IspxClocks[NUM_ISPXCLK_DPM_LEVELS];
> +  vcn_clk_t VcnClocks[NUM_VCN_DPM_LEVELS];
> +
> +  uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
> +
> +  df_pstate_t DfPstateTable[NUM_FCLK_DPM_LEVELS];
> +
> +  uint32_t MinGfxClk;
> +  uint32_t MaxGfxClk;
> +
> +  uint8_t NumDfPstatesEnabled;
> +  uint8_t NumDpmLevelsEnabled;
> +  uint8_t spare[2];
> +} DpmClocks_t;
> +
> +
> +// Throttler Status Bitmask
> +#define THROTTLER_STATUS_BIT_SPL 0
> +#define THROTTLER_STATUS_BIT_FPPT 1
> +#define THROTTLER_STATUS_BIT_SPPT 2
> +#define THROTTLER_STATUS_BIT_SPPT_APU 3
> +#define THROTTLER_STATUS_BIT_THM_CORE 4
> +#define THROTTLER_STATUS_BIT_THM_GFX 5
> +#define THROTTLER_STATUS_BIT_THM_SOC 6
> +#define THROTTLER_STATUS_BIT_TDC_VDD 7
> +#define THROTTLER_STATUS_BIT_TDC_SOC 8
> +#define THROTTLER_STATUS_BIT_TDC_GFX 9
> +#define THROTTLER_STATUS_BIT_TDC_CVIP 10
> +
> +typedef struct {
> +  uint16_t AverageGfxclkFrequency; //[MHz]
> +  uint16_t AverageSocclkFrequency; //[MHz]
> +  uint16_t AverageVclkFrequency;   //[MHz]
> +  uint16_t AverageDclkFrequency;   //[MHz]
> +  uint16_t AverageMemclkFrequency; //[MHz]
> +  uint16_t spare;
> +
> +  uint16_t AverageGfxActivity; //[centi]
> +  uint16_t AverageUvdActivity; //[centi]
> +
> +  uint16_t Voltage[3];         //[mV] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
> +  uint16_t Current[3];         //[mA] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
> +  uint16_t Power[3];           //[mW] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
> +  uint16_t CurrentSocketPower; //[mW]
> +
> +  //3rd party tools in Windows need this info in the case of APUs
> +  uint16_t CoreFrequency[8];   //[MHz]
> +  uint16_t CorePower[8];       //[mW]
> +  uint16_t CoreTemperature[8]; //[centi-Celsius]
> +  uint16_t L3Frequency[2];     //[MHz]
> +  uint16_t L3Temperature[2];   //[centi-Celsius]
> +
> +  uint16_t GfxTemperature; //[centi-Celsius]
> +  uint16_t SocTemperature; //[centi-Celsius]
> +  uint16_t EdgeTemperature;
> +  uint16_t ThrottlerStatus;
> +} SmuMetrics_t;
> +
> +
> +// Workload bits
> +#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0
> +#define WORKLOAD_PPLIB_VIDEO_BIT 2
> +#define WORKLOAD_PPLIB_VR_BIT 3
> +#define WORKLOAD_PPLIB_COMPUTE_BIT 4
> +#define WORKLOAD_PPLIB_CUSTOM_BIT 5
> +#define WORKLOAD_PPLIB_COUNT 6
> +
> +#define TABLE_BIOS_IF 0    // Called by BIOS
> +#define TABLE_WATERMARKS 1 // Called by DAL through VBIOS
> +#define TABLE_CUSTOM_DPM 2 // Called by Driver
> +#define TABLE_SPARE1 3
> +#define TABLE_DPMCLOCKS 4    // Called by Driver
> +#define TABLE_MOMENTARY_PM 5 // Called by Tools
> +#define TABLE_MODERN_STDBY 6 // Called by Tools for Modern Standby Log
> +#define TABLE_SMU_METRICS 7  // Called by Driver
> +#define TABLE_COUNT 8
> +
> +//ISP tile definitions
> +typedef enum {
> +  TILE_ISPX = 0, // ISPX
> +  TILE_ISPM,     // ISPM
> +  TILE_ISPC,  // ISPCORE
> +  TILE_ISPPRE,   // ISPPRE
> +  TILE_ISPPOST,  // ISPPOST
> +  TILE_MAX
> +} TILE_NUM_e;
> +
> +// Tile Selection (Based on arguments)
> +#define TILE_SEL_ISPX       (1<<(TILE_ISPX))
> +#define TILE_SEL_ISPM       (1<<(TILE_ISPM))
> +#define TILE_SEL_ISPC       (1<<(TILE_ISPC))
> +#define TILE_SEL_ISPPRE     (1<<(TILE_ISPPRE))
> +#define TILE_SEL_ISPPOST    (1<<(TILE_ISPPOST))
> +
> +// Mask for ISP tiles in PGFSM PWR Status Registers
> +//Bit[1:0] maps to ISPX, (ISPX)
> +//Bit[3:2] maps to ISPM, (ISPM)
> +//Bit[5:4] maps to ISPCORE, (ISPCORE)
> +//Bit[7:6] maps to ISPPRE, (ISPPRE)
> +//Bit[9:8] maps to POST, (ISPPOST
> +#define TILE_ISPX_MASK      ((1<<0) | (1<<1))
> +#define TILE_ISPM_MASK      ((1<<2) | (1<<3))
> +#define TILE_ISPC_MASK      ((1<<4) | (1<<5))
> +#define TILE_ISPPRE_MASK    ((1<<6) | (1<<7))
> +#define TILE_ISPPOST_MASK   ((1<<8) | (1<<9))
> +
> +#endif
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
