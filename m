Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF4C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B322225C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NbGW5W5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B322225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989086E046;
	Tue, 27 Oct 2020 09:42:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482236E046
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUB/Ozn/BrpSUEdzBaPtHFrHIywY81QarE66bqoKPEynSzZzRHvy1kVR64p3siDPCZPW689RcOOpJrraa010bYzWiU4trJrRH7wfKHfIp9HmVUE3DXx3xgowELkoiqE7XeZNULS5pPj0EdUJKgnyscBztxa1b8mnkU62UCD2FjQ05ARmEyUYKqT4A3RrXxMNX/WoNGq48Uj68kx4RyMOLvi/JeFCsa+fyPijeCTndcJdYShOAzm/0dNK2Wvu0LIyeVR9eHJCgUcPWIQVNJFgSvR6wjeHiWX/rmgtkrwXJhIv9PossUUujv7mUVdOjsQVFuLVXcVekqyaiyM5QRN6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQOxz2r8WQQ2oaip2cmVBEygiwbDUg6xhQI+2OVbxZA=;
 b=QXc4VFmSym/+pe0NKs1FuxyLI0eZOOOrpKDxRNVA2Cg4oeDvUdXbX2yKyD7vuY+rspujp5OWSmbTJCcXtmeUIgV/1WvjlFQl3q9iVQwOiKWnb0ud+U3gI3bPJrhgerEXJe8blP76q3XO9TEWoyJ71P/DDh+E1sQCFB+4QkvrEtXKv1kKqdHbzhtxg8XPwLvTknDpsil1dnWrZ6h7qaW8v1khjPpowthVqhYPCUJTEbMjrSts08pkF0z44Yfz4GY9uCo1e5h6oWnYcELmIgJ8YzDj11FOMqygSIhT+QpLpJ04NkHH8M75h0bXmg/DUNT9S371qCvwlgXEciaShVEs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQOxz2r8WQQ2oaip2cmVBEygiwbDUg6xhQI+2OVbxZA=;
 b=NbGW5W5VnWOoLKrlqkkZOkjMCiEfRE93itQ6pj+G4Fdfgdl854jyHNRXgYoIko7GuCH7rO7SkYHTBXrIkA/O4dKUvtq4gE0lIDUY4Ph2JWJgutmq+/2qeTZ011dBoF7ONMBFe/ErMOyS/i2NGutoLCt4mxDbJVX8z7dT+3LaZJY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:41:57 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:41:57 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 01/10] drm/amd/pm: update the smu v11.5 smc header for vangogh
Date: Tue, 27 Oct 2020 17:41:24 +0800
Message-Id: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:41:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfdacf8f-c7bd-4e24-f78e-08d87a5c8b43
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1845A401EA5F1B21B1E17419F1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqQtGhgQoV2PcyCX/gQ8yb9vC02i+MKokkkEEOC0B/9uytwy18PB4XJJH+wSGGEXi7Hbm35qK3g+ylfmhKdTSLhD2aQ+rKAH0vhJZWhfZk5nDU2iFvya1Ssq7dzjDlxDcr1oIy+REW6IrZFj5cHM4l0FWs24K3QuhWRx1hBsoxV2Ae4zymgHdDL51R0LSEu3NuAA6jghcZ6mGg8bE0egCo+21UKtmwEmZCkRSzIiWmM7MNMQmCs48p5B0XbQfQI5iYtAZF5+fUcPjMxDKy4r3vwnzVU8YcHJo5mEkqYpm5rZiVYPfYAvcmpUIo8ZcGvXn+VYtoleUhHDv1kumVDt+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(19627235002)(1076003)(52116002)(6486002)(15650500001)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xYkcRInYLT5bECtPokSkyFlZzi1nTWviD0MVtfY8lwXfcLucXVhVjKOUKnyqhYFlbIO/TYK1nJ+Sv76pTkXiDJNQDc7VIFo8PIb+jMbt4lrZnZ7LS0En/QQf3NPwz7a1EroCUOIKNQQI2wxPqmSVm6FXwW6cr/Gwgt5vGwcVE+MiDgfwoh6UNNiaaatA/3HYo/8Wbc9HhKtMUGLuCdAUiHeZ56ei5IqfzTRY4H4t4uokDPrhavEIbTCkyUrmoVkvpSoqcy6hK6/jYq5usJEr5xSHSgfzdy0X82Uh8VwxPLuTcKn1KfXWYC4YbrqiPCfgUuw0+2+nYYpvWBKzfjo13q0ilcZfCOwnG+lt2p0Rmm+CzVyrf39XDzucODz0UsFaRfWi0PukQIu3vwy9+ytG3m2sCinzxOZSyAY3Ql9dyca6bZQI0r3g25H5bT380LOBTPCDbfu6ZW9VfO7pxMyVU2yrfflWhOocindvDlBr0QdDUQCC0XyVuOOVouO5EsVnREP+o0Kno0MM+MDJ1OmCzAUugdIrBMsZuKHPGoqBn1nY4eAoYS/teZBeUGls1LlzbRdcRo/cl3kaiPktqXBlY3x8Io4BfMfPaaiJ909L+B4hqNjCfEfwK1TdNpJLuwnb7+3cLucSSQHb9OPDfXqgvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdacf8f-c7bd-4e24-f78e-08d87a5c8b43
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:41:57.0569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FGlsVypOgksLd2P8MD1tLjTFf9QyIrw5sIM+QpZdbiRkLbMkAZTHeBzsqdeuM0e+zZj/zot2MB8K6o6La/iWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, xinmei.huang@amd.com,
 prike.liang@amd.com, changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update the smu v11.5 smc header for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h | 114 +++++++++++--------
 1 file changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
index 55c1b151a68d..1ada0eb64663 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
@@ -32,55 +32,77 @@
 #define PPSMC_Result_CmdRejectedBusy 0xFC
 
 // Message Definitions:
-#define PPSMC_MSG_TestMessage 0x1
-#define PPSMC_MSG_GetSmuVersion 0x2
-#define PPSMC_MSG_GetDriverIfVersion 0x3
-#define PPSMC_MSG_EnableGfxOff 0x4
-#define PPSMC_MSG_DisableGfxOff 0x5
-#define PPSMC_MSG_PowerDownIspByTile 0x6 // ISP is power gated by default
-#define PPSMC_MSG_PowerUpIspByTile 0x7
-#define PPSMC_MSG_PowerDownVcn 0x8 // VCN is power gated by default
-#define PPSMC_MSG_PowerUpVcn 0x9
-#define PPSMC_MSG_spare 0xA
-#define PPSMC_MSG_SetHardMinVcn 0xB // For wireless display
-#define PPSMC_MSG_SetMinVideoGfxclkFreq	0xC //Sets SoftMin for GFXCLK. Arg is in MHz
-#define PPSMC_MSG_ActiveProcessNotify 0xD
-#define PPSMC_MSG_SetHardMinIspiclkByFreq 0xE
-#define PPSMC_MSG_SetHardMinIspxclkByFreq 0xF
-#define PPSMC_MSG_SetDriverDramAddrHigh 0x10
-#define PPSMC_MSG_SetDriverDramAddrLow 0x11
-#define PPSMC_MSG_TransferTableSmu2Dram 0x12
-#define PPSMC_MSG_TransferTableDram2Smu 0x13
-#define PPSMC_MSG_GfxDeviceDriverReset 0x14 //mode 2 reset during TDR
-#define PPSMC_MSG_GetEnabledSmuFeatures 0x15
-#define PPSMC_MSG_spare1 0x16
-#define PPSMC_MSG_SetHardMinSocclkByFreq 0x17
-#define PPSMC_MSG_SetMinVideoFclkFreq 0x18
-#define PPSMC_MSG_SetSoftMinVcn 0x19
-#define PPSMC_MSG_EnablePostCode 0x1A
-#define PPSMC_MSG_GetGfxclkFrequency 0x1B
-#define PPSMC_MSG_GetFclkFrequency 0x1C
-#define PPSMC_MSG_AllowGfxOff 0x1D
-#define PPSMC_MSG_DisallowGfxOff 0x1E
-#define PPSMC_MSG_SetSoftMaxGfxClk 0x1F
-#define PPSMC_MSG_SetHardMinGfxClk 0x20
-#define PPSMC_MSG_SetSoftMaxSocclkByFreq 0x21
-#define PPSMC_MSG_SetSoftMaxFclkByFreq 0x22
-#define PPSMC_MSG_SetSoftMaxVcn 0x23
-#define PPSMC_MSG_GpuChangeState 0x24 //FIXME AHOLLA - check how to do for VGM
-#define PPSMC_MSG_SetPowerLimitPercentage 0x25
-#define PPSMC_MSG_PowerDownJpeg 0x26
-#define PPSMC_MSG_PowerUpJpeg 0x27
-#define PPSMC_MSG_SetHardMinFclkByFreq 0x28
-#define PPSMC_MSG_SetSoftMinSocclkByFreq 0x29
-#define PPSMC_MSG_PowerUpCvip 0x2A
-#define PPSMC_MSG_PowerDownCvip 0x2B
-#define PPSMC_Message_Count 0x2C
+#define PPSMC_MSG_TestMessage                          0x1
+#define PPSMC_MSG_GetSmuVersion                        0x2
+#define PPSMC_MSG_GetDriverIfVersion                   0x3
+#define PPSMC_MSG_EnableGfxOff                         0x4
+#define PPSMC_MSG_DisableGfxOff                        0x5
+#define PPSMC_MSG_PowerDownIspByTile                   0x6 // ISP is power gated by default
+#define PPSMC_MSG_PowerUpIspByTile                     0x7
+#define PPSMC_MSG_PowerDownVcn                         0x8 // VCN is power gated by default
+#define PPSMC_MSG_PowerUpVcn                           0x9
+#define PPSMC_MSG_spare                                0xA
+#define PPSMC_MSG_SetHardMinVcn                        0xB // For wireless display
+#define PPSMC_MSG_SetSoftMinGfxclk                     0xC //Sets SoftMin for GFXCLK. Arg is in MHz
+#define PPSMC_MSG_ActiveProcessNotify                  0xD
+#define PPSMC_MSG_SetHardMinIspiclkByFreq              0xE
+#define PPSMC_MSG_SetHardMinIspxclkByFreq              0xF
+#define PPSMC_MSG_SetDriverDramAddrHigh                0x10
+#define PPSMC_MSG_SetDriverDramAddrLow                 0x11
+#define PPSMC_MSG_TransferTableSmu2Dram                0x12
+#define PPSMC_MSG_TransferTableDram2Smu                0x13
+#define PPSMC_MSG_GfxDeviceDriverReset                 0x14 //mode 2 reset during TDR
+#define PPSMC_MSG_GetEnabledSmuFeatures                0x15
+#define PPSMC_MSG_spare1                               0x16
+#define PPSMC_MSG_SetHardMinSocclkByFreq               0x17
+#define PPSMC_MSG_SetSoftMinFclk                       0x18 //Used to be PPSMC_MSG_SetMinVideoFclkFreq
+#define PPSMC_MSG_SetSoftMinVcn                        0x19
+#define PPSMC_MSG_EnablePostCode                       0x1A
+#define PPSMC_MSG_GetGfxclkFrequency                   0x1B
+#define PPSMC_MSG_GetFclkFrequency                     0x1C
+#define PPSMC_MSG_AllowGfxOff                          0x1D
+#define PPSMC_MSG_DisallowGfxOff                       0x1E
+#define PPSMC_MSG_SetSoftMaxGfxClk                     0x1F
+#define PPSMC_MSG_SetHardMinGfxClk                     0x20
+#define PPSMC_MSG_SetSoftMaxSocclkByFreq               0x21
+#define PPSMC_MSG_SetSoftMaxFclkByFreq                 0x22
+#define PPSMC_MSG_SetSoftMaxVcn                        0x23
+#define PPSMC_MSG_spare2                               0x24
+#define PPSMC_MSG_SetPowerLimitPercentage              0x25
+#define PPSMC_MSG_PowerDownJpeg                        0x26
+#define PPSMC_MSG_PowerUpJpeg                          0x27
+#define PPSMC_MSG_SetHardMinFclkByFreq                 0x28
+#define PPSMC_MSG_SetSoftMinSocclkByFreq               0x29
+#define PPSMC_MSG_PowerUpCvip                          0x2A
+#define PPSMC_MSG_PowerDownCvip                        0x2B
+#define PPSMC_MSG_GetPptLimit                          0x2C
+#define PPSMC_MSG_GetThermalLimit                      0x2D
+#define PPSMC_MSG_GetCurrentTemperature                0x2E
+#define PPSMC_MSG_GetCurrentPower                      0x2F
+#define PPSMC_MSG_GetCurrentVoltage                    0x30
+#define PPSMC_MSG_GetCurrentCurrent                    0x31
+#define PPSMC_MSG_GetAverageCpuActivity                0x32
+#define PPSMC_MSG_GetAverageGfxActivity                0x33
+#define PPSMC_MSG_GetAveragePower                      0x34
+#define PPSMC_MSG_GetAverageTemperature                0x35
+#define PPSMC_MSG_SetAveragePowerTimeConstant          0x36
+#define PPSMC_MSG_SetAverageActivityTimeConstant       0x37
+#define PPSMC_MSG_SetAverageTemperatureTimeConstant    0x38
+#define PPSMC_MSG_SetMitigationEndHysteresis           0x39
+#define PPSMC_MSG_GetCurrentFreq                       0x3A
+#define PPSMC_MSG_SetReducedPptLimit                   0x3B
+#define PPSMC_MSG_SetReducedThermalLimit               0x3C
+#define PPSMC_MSG_DramLogSetDramAddr                   0x3D
+#define PPSMC_MSG_StartDramLogging                     0x3E
+#define PPSMC_MSG_StopDramLogging                      0x3F
+#define PPSMC_MSG_SetSoftMinCclk                       0x40
+#define PPSMC_MSG_SetSoftMaxCclk                       0x41
+#define PPSMC_Message_Count                            0x42
 
 //Argument for  PPSMC_MSG_GpuChangeState
 enum {
-  GpuChangeState_D0Entry = 1,
-  GpuChangeState_D3Entry,
+  MODE1_RESET = 1,
+  MODE2_RESET = 2
 };
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
