Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F47C43619
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB99261059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB99261059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840BB6EC71;
	Wed, 12 May 2021 17:31:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDD76EC6A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7mFi4DZOAFtFLc2lWqMjre50WjO5qty5xxCX1fCtq+xYAIi81eUu/IWjzkbPMbm6Eoa9oR61elxlktiXZ/OawAdpT8N/2B7dkCpCkDT2MtlMOehdSHA/THxv6L/WpSzI4m7wUc1XfILcF72AQNQ4ga1KBRHVLjZzE+V1TOkQEQCFQWMzhCdUXbFkA6vSGMTedr/zjQxb9iwrxcZaO5Hpmw7p+aGIorq3oZnaPoOiJ62NRRYP4ZRiVnWsMC+uvSkG5sYdm2b1SWdx59zvYX2uNdXjAEUYHAGSrirrVzzeLrjpuBmNfppbb06QfMbSD/2zjP+NgErlDBLquPS1uHmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASvxSFq/rrbuShGWMjhGfS3eIQemJdGkCoY4442eckw=;
 b=hNH7xmqViULZWPInDScYGBGR2c1huDXnv+MeBddhp5PSbehK+EfcCww2+Z5oFUsJQ8tBqCiBzjUlsXU0XZds0guZSNI8kGfzo9Q/ERW6+qZ7nUm+8FinoCEBPGCvG/tl1Y9XsIcHn7tf0dl7F+LP3whnMaPTbIdnEBe3FjAE4GdHAC2OrTsxbcSirUYR2LLcnE12tlZ+2Su/6AKgVVNm7z7cUOmgBTP1FsKmwok2Lfj7SyZF/pb++uZdcFOemtI5Zsw9vMIsbzC8daSHv57gnIik4PvbabR0d7zTtbh0OvpavsGBBCkq8npThQLapQG/kCHpUbPbOBD+E+54WD6/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASvxSFq/rrbuShGWMjhGfS3eIQemJdGkCoY4442eckw=;
 b=QfghjUWmaTbCupLL/OACHz6WjwVTC4tM/td+TNFTkQnzvJIZoIXCsYDUwijAOvk7FNfkWhGHXHjgHmLuaSJ5d5I6DEEXHY/tAIzfbEa3QhwJThUaJ42UP66mn5RWolM0cXbzLLex1yIytCplTf1XnV7O3CAa06TLV3v5uaFL7Wc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/49] drm/amd/pm: update smu11 driver interface header for
 beige_goby
Date: Wed, 12 May 2021 13:30:32 -0400
Message-Id: <20210512173053.2347842-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83bff973-31fe-489a-8a49-08d9156bc7b9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340F551ACD212FF5F4B9921F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m06a3BHpEaB6eiZW+9qklL4dI37v3uZy8U0T3R8WM1wfRgqMMhJk3MNzs6LfNL1twRWLVsfCqxMu+kh16lCtY7T+kWtYkuEwvmrY0QR9ZtNSDFBoCUFxHrZbWhR2ZvqOP+UWXMXA5kha1cbZf4rLjx4BR3K/CytcSrLHht+XVrZowzKeWLH5kDVGDWG56jt2NweGUFOmhm0PVGjpDMmrhNH/Wg1WcooW5B8qf0gm5A657S6srNpBMaM/8UsQQBthJTuHiu4z3mViokgeFQkL+m2gl4ZYcTjXsiIcvlvednUHbfs1IwczgZHEYMzE2j/qO7Ra4Ke/DtNZUxA8gfdUCI5L0vy+IEevc3E92w/Nk7PdMu8Sthkj/fCeEhv2fH5GVjqdl68dsE5uxTdZVdXy3ZlPsoy5MbNPJ9HGlWM3hrgT91JEaN72kxLcliPnIcjUqfRkIT5yMmKWK0UjHk73VmpOQxzc5rKYquJ4dRmvlNzteQkl2NGQJriKmP3wMceOm3CdYsGtpj5Ax+rMxBC28uRe7Aue5RMbJdWqIa/P6CJZGpUdX3eNSMVA8WCX9SmRCi0amD/W/0D/8Jub7+QiEw2kVC4Y7niEXhO+M/PIO4M859oW2+qhZo7SEYHQ5D13sIALyHzXSu/H5OoiY7hsBsp0PTxFhAI2lZ059PRX/ih6zzbnmD9zMgJ94J3cx5O2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(15650500001)(6916009)(2616005)(956004)(30864003)(6486002)(8936002)(16526019)(1076003)(66574015)(83380400001)(6512007)(186003)(19627235002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hN9nrGhyB7cJcqLv8KEH55aKmJu1D7DB92n4zCqbgEw3tBlSthEA7/0VHtTG?=
 =?us-ascii?Q?ElPT3klB69KjLSAicpQgRLOSIuplDSEUGsax6cDzsuP2AZZVsku4vV2wHuE7?=
 =?us-ascii?Q?rH0kKDFwY1hHYE239QpeoJXKEJcvCsDSDRBqd/dU3PMz3dwQaXLivGLHw6HW?=
 =?us-ascii?Q?q2IYJWgMLvt1xNwvloq58iU2fvhhz/PQPwX+DVt/qPEPVoe49ZroR+Cr8Vlg?=
 =?us-ascii?Q?wjfF2XpNoCQoR+NNRRM438qa54UyPw/LkctoCpl/5czIhAQlSMXwSG4X9C3K?=
 =?us-ascii?Q?Ksk7D03zFRLqw6n1K8/uT8dkZ0rvt+ETrWxbAXOLjFKVa1lnh73yLTaVLtyd?=
 =?us-ascii?Q?kbX1A1I9Ov5mDnWONa7rDSRvpdpD2/rgX21SHEv3a/ZZGe6nXjqLvaBhH40K?=
 =?us-ascii?Q?V/VdT8RusDF7lSjN6OURD8UXOekz1oVtdi6l6RbZwMYx4GBFnR+EDSGOCMaV?=
 =?us-ascii?Q?HbGHxA8t8nAdo8svUUapmQoHcdC4ngG/ranPsqgW80qxFEe59cHjA0ZFDj7E?=
 =?us-ascii?Q?UbB8hSe0iu33ljLaprLgfYAmiqnPpuGn3nlS3SH6eMq/W3hU/OeuHOYMcl6v?=
 =?us-ascii?Q?ExmdUbkVt0REd1C4iPv2o9LS9dt56AVJ+PGQEaxeOAgrraU5rkrvJ8IuBdug?=
 =?us-ascii?Q?yT7WNKYcnV0zXayWJsQYrYaT3Cy5Rj7clUgrsrg/hioJzDJmSmQhjZjQ1qSB?=
 =?us-ascii?Q?RTNMMl/IAAa6wH/Xvq0SmEFEc1fSs8yPJUOoj4AKZUeyM7Tg6IIPYwd8XI8S?=
 =?us-ascii?Q?6u8YP9kOya5mes3uEw8eN4Bpki3XEjpSaomgtJIvx4ZgNr+pv5wIX78RUfcN?=
 =?us-ascii?Q?r//zIVb/30HWUOwrTVUVJSQ+27D7R5Mv45heZZ/zVPArVr+wESgIDaUaY9E9?=
 =?us-ascii?Q?ijkzPo2SXo7jgh3nhLm2dRy9TjA/XapVzdMwXnifZrF+TB63LCWVdK74ygXn?=
 =?us-ascii?Q?Tbz+fMqhSiBgPTEc/aEE1OhRPSN7WOfhVE1UMK7TdhI9FdnX2qv0s0xADC9G?=
 =?us-ascii?Q?G3o/na+8Alqku5uoH1ERzpMTYOgchXlXjDRzt2Jurfa3M8ReU8TljtO2EDKl?=
 =?us-ascii?Q?65YJ7TEr7FdInqzcNLCopjh6sh2ycRbYyC7yCTmFOn0YB2b+90QoS9IZ6mXs?=
 =?us-ascii?Q?TkRWmf3mb1wXtHssl6hTa2N8sjr3oQh/sfnx6BZN590CnwsAAXs21qaEuLrr?=
 =?us-ascii?Q?Xhsgxaq6jTxNpqcZh0BELP3KZO9aHkdHYn4zv5jM6ZwlRaLhE5g81OAR48cW?=
 =?us-ascii?Q?XMDgwQkTD1MBcZIi/RIezHjcn9QKkfXpBzovSyXd9tU/YYNjfunzKl2e23o9?=
 =?us-ascii?Q?Tzn5HvJRcOpOIHZ7clDieD0l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bff973-31fe-489a-8a49-08d9156bc7b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:30.8355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DmXyXlcuCdZOKRr7pykvJI7TA3heD1TAZoP0oBv7deV9eDrOgxKjmjNOfvXmsL6P6itwSR2wb9J23ilHxOfvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Use new struct name to identify beige_goby pptable
due to extra added fields.

v2: squash in updates (Alex)

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Evan Quan <Evan.Quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   | 366 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |   2 +-
 2 files changed, 365 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index fa95147b5a63..7a6d049e65e3 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -129,8 +129,8 @@
 #define FEATURE_SMNCLK_DPM_BIT          47
 #define FEATURE_PERLINK_GMIDOWN_BIT     48
 #define FEATURE_GFX_EDC_BIT             49
-#define FEATURE_SPARE_50_BIT            50
-#define FEATURE_SPARE_51_BIT            51
+#define FEATURE_GFX_PER_PART_VMIN_BIT   50
+#define FEATURE_SMART_SHIFT_BIT         51
 #define FEATURE_SPARE_52_BIT            52
 #define FEATURE_SPARE_53_BIT            53
 #define FEATURE_SPARE_54_BIT            54
@@ -940,6 +940,367 @@ typedef struct {
 
 } PPTable_t;
 
+typedef struct {
+  // MAJOR SECTION: SKU PARAMETERS
+
+  uint32_t Version;
+
+  // SECTION: Feature Enablement
+  uint32_t FeaturesToRun[NUM_FEATURES / 32];
+
+  // SECTION: Infrastructure Limits
+  uint16_t SocketPowerLimitAc[PPT_THROTTLER_COUNT]; // Watts
+  uint16_t SocketPowerLimitAcTau[PPT_THROTTLER_COUNT]; // Time constant of LPF in ms
+  uint16_t SocketPowerLimitDc[PPT_THROTTLER_COUNT];  // Watts
+  uint16_t SocketPowerLimitDcTau[PPT_THROTTLER_COUNT];  // Time constant of LPF in ms
+
+  uint16_t TdcLimit[TDC_THROTTLER_COUNT];             // Amps
+  uint16_t TdcLimitTau[TDC_THROTTLER_COUNT];          // Time constant of LPF in ms
+
+  uint16_t TemperatureLimit[TEMP_COUNT]; // Celcius
+
+  uint32_t FitLimit;                // Failures in time (failures per million parts over the defined lifetime)
+
+  // SECTION: Power Configuration
+  uint8_t      TotalPowerConfig;    //0-TDP, 1-TGP, 2-TCP Estimated, 3-TCP Measured. Use defines from PwrConfig_e
+  uint8_t      TotalPowerPadding[3];  
+
+  // SECTION: APCC Settings
+  uint32_t     ApccPlusResidencyLimit;
+
+  //SECTION: SMNCLK DPM
+  uint16_t       SmnclkDpmFreq        [NUM_SMNCLK_DPM_LEVELS];       // in MHz
+  uint16_t       SmnclkDpmVoltage     [NUM_SMNCLK_DPM_LEVELS];       // mV(Q2)
+
+  uint32_t       PaddingAPCC;
+  uint16_t       PerPartDroopVsetGfxDfll[NUM_PIECE_WISE_LINEAR_DROOP_MODEL_VF_POINTS];  //In mV(Q2)
+  uint16_t       PaddingPerPartDroop;
+
+  // SECTION: Throttler settings
+  uint32_t ThrottlerControlMask;   // See Throtter masks defines
+
+  // SECTION: FW DSTATE Settings  
+  uint32_t FwDStateMask;           // See FW DState masks defines
+
+  // SECTION: ULV Settings
+  uint16_t  UlvVoltageOffsetSoc; // In mV(Q2)
+  uint16_t  UlvVoltageOffsetGfx; // In mV(Q2)
+
+  uint16_t     MinVoltageUlvGfx; // In mV(Q2)  Minimum Voltage ("Vmin") of VDD_GFX in ULV mode 
+  uint16_t     MinVoltageUlvSoc; // In mV(Q2)  Minimum Voltage ("Vmin") of VDD_SOC in ULV mode
+
+  uint16_t     SocLIVmin;
+  uint16_t     SocLIVminoffset;
+
+  uint8_t   GceaLinkMgrIdleThreshold;        //Set by SMU FW during enablment of GFXOFF. Controls delay for GFX SDP port disconnection during idle events
+  uint8_t   paddingRlcUlvParams[3];
+
+  // SECTION: Voltage Control Parameters
+  uint16_t     MinVoltageGfx;     // In mV(Q2) Minimum Voltage ("Vmin") of VDD_GFX
+  uint16_t     MinVoltageSoc;     // In mV(Q2) Minimum Voltage ("Vmin") of VDD_SOC
+  uint16_t     MaxVoltageGfx;     // In mV(Q2) Maximum Voltage allowable of VDD_GFX
+  uint16_t     MaxVoltageSoc;     // In mV(Q2) Maximum Voltage allowable of VDD_SOC
+
+  uint16_t     LoadLineResistanceGfx;   // In mOhms with 8 fractional bits
+  uint16_t     LoadLineResistanceSoc;   // In mOhms with 8 fractional bits
+
+  // SECTION: Temperature Dependent Vmin
+  uint16_t     VDDGFX_TVmin;       //Celcius
+  uint16_t     VDDSOC_TVmin;       //Celcius
+  uint16_t     VDDGFX_Vmin_HiTemp; // mV Q2
+  uint16_t     VDDGFX_Vmin_LoTemp; // mV Q2
+  uint16_t     VDDSOC_Vmin_HiTemp; // mV Q2
+  uint16_t     VDDSOC_Vmin_LoTemp; // mV Q2
+
+  uint16_t     VDDGFX_TVminHystersis; // Celcius
+  uint16_t     VDDSOC_TVminHystersis; // Celcius
+
+  //SECTION: DPM Config 1
+  DpmDescriptor_t DpmDescriptor[PPCLK_COUNT];
+
+  uint16_t       FreqTableGfx      [NUM_GFXCLK_DPM_LEVELS  ];     // In MHz
+  uint16_t       FreqTableVclk     [NUM_VCLK_DPM_LEVELS    ];     // In MHz
+  uint16_t       FreqTableDclk     [NUM_DCLK_DPM_LEVELS    ];     // In MHz
+  uint16_t       FreqTableSocclk   [NUM_SOCCLK_DPM_LEVELS  ];     // In MHz
+  uint16_t       FreqTableUclk     [NUM_UCLK_DPM_LEVELS    ];     // In MHz
+  uint16_t       FreqTableDcefclk  [NUM_DCEFCLK_DPM_LEVELS ];     // In MHz
+  uint16_t       FreqTableDispclk  [NUM_DISPCLK_DPM_LEVELS ];     // In MHz
+  uint16_t       FreqTablePixclk   [NUM_PIXCLK_DPM_LEVELS  ];     // In MHz
+  uint16_t       FreqTablePhyclk   [NUM_PHYCLK_DPM_LEVELS  ];     // In MHz
+  uint16_t       FreqTableDtbclk   [NUM_DTBCLK_DPM_LEVELS  ];     // In MHz
+  uint16_t       FreqTableFclk     [NUM_FCLK_DPM_LEVELS    ];     // In MHz
+  uint32_t       Paddingclks;
+
+  DroopInt_t     PerPartDroopModelGfxDfll[NUM_PIECE_WISE_LINEAR_DROOP_MODEL_VF_POINTS]; //GHz ->Vstore in IEEE float format
+
+  uint32_t       DcModeMaxFreq     [PPCLK_COUNT            ];     // In MHz
+
+  uint8_t        FreqTableUclkDiv  [NUM_UCLK_DPM_LEVELS    ];     // 0:Div-1, 1:Div-1/2, 2:Div-1/4, 3:Div-1/8
+
+  // Used for MALL performance boost
+  uint16_t       FclkBoostFreq;                                   // In Mhz
+  uint16_t       FclkParamPadding;
+
+  // SECTION: DPM Config 2
+  uint16_t       Mp0clkFreq        [NUM_MP0CLK_DPM_LEVELS];       // in MHz
+  uint16_t       Mp0DpmVoltage     [NUM_MP0CLK_DPM_LEVELS];       // mV(Q2)
+  uint16_t       MemVddciVoltage   [NUM_UCLK_DPM_LEVELS];         // mV(Q2)
+  uint16_t       MemMvddVoltage    [NUM_UCLK_DPM_LEVELS];         // mV(Q2)
+  // GFXCLK DPM
+  uint16_t        GfxclkFgfxoffEntry;   // in Mhz
+  uint16_t        GfxclkFinit;          // in Mhz 
+  uint16_t        GfxclkFidle;          // in MHz 
+  uint8_t         GfxclkSource;         // 0 = PLL, 1 = DFLL
+  uint8_t         GfxclkPadding;
+
+  // GFX GPO 
+  uint8_t         GfxGpoSubFeatureMask; // bit 0 = PACE, bit 1 = DEM
+  uint8_t         GfxGpoEnabledWorkPolicyMask; //Any policy that GPO can be enabled
+  uint8_t         GfxGpoDisabledWorkPolicyMask; //Any policy that GPO can be disabled
+  uint8_t         GfxGpoPadding[1];
+  uint32_t        GfxGpoVotingAllow;    //For indicating which feature changes should result in a GPO table recalculation
+
+  uint32_t        GfxGpoPadding32[4];
+
+  uint16_t        GfxDcsFopt;           // Optimal GFXCLK for DCS in Mhz
+  uint16_t        GfxDcsFclkFopt;       // Optimal FCLK for DCS in Mhz
+  uint16_t        GfxDcsUclkFopt;       // Optimal UCLK for DCS in Mhz
+
+  uint16_t        DcsGfxOffVoltage;     //Voltage in mV(Q2) applied to VDDGFX when entering DCS GFXOFF phase  
+
+  uint16_t        DcsMinGfxOffTime;     //Minimum amount of time PMFW shuts GFX OFF as part of GFX DCS phase
+  uint16_t        DcsMaxGfxOffTime;      //Maximum amount of time PMFW can shut GFX OFF as part of GFX DCS phase at a stretch.
+
+  uint32_t        DcsMinCreditAccum;    //Min amount of positive credit accumulation before waking GFX up as part of DCS.
+
+  uint16_t        DcsExitHysteresis;    //The min amount of time power credit accumulator should have a value > 0 before SMU exits the DCS throttling phase. 
+  uint16_t        DcsTimeout;           //This is the amount of time SMU FW waits for RLC to put GFX into GFXOFF before reverting to the fallback mechanism of throttling GFXCLK to Fmin.
+
+  uint32_t        DcsParamPadding[5];
+
+  uint16_t        FlopsPerByteTable[RLC_PACE_TABLE_NUM_LEVELS]; // Q8.8
+
+  // UCLK section
+  uint8_t      LowestUclkReservedForUlv; // Set this to 1 if UCLK DPM0 is reserved for ULV-mode only
+  uint8_t      PaddingMem[3];
+
+  uint8_t      UclkDpmPstates     [NUM_UCLK_DPM_LEVELS];     // 4 DPM states, 0-P0, 1-P1, 2-P2, 3-P3.
+
+  // Used for 2-Step UCLK change workaround
+  UclkDpmChangeRange_t UclkDpmSrcFreqRange;  // In Mhz
+  UclkDpmChangeRange_t UclkDpmTargFreqRange; // In Mhz
+  uint16_t UclkDpmMidstepFreq;               // In Mhz
+  uint16_t UclkMidstepPadding;
+
+  // Link DPM Settings
+  uint8_t      PcieGenSpeed[NUM_LINK_LEVELS];           ///< 0:PciE-gen1 1:PciE-gen2 2:PciE-gen3 3:PciE-gen4
+  uint8_t      PcieLaneCount[NUM_LINK_LEVELS];          ///< 1=x1, 2=x2, 3=x4, 4=x8, 5=x12, 6=x16
+  uint16_t     LclkFreq[NUM_LINK_LEVELS];              
+
+  // SECTION: Fan Control
+  uint16_t     FanStopTemp;          //Celcius
+  uint16_t     FanStartTemp;         //Celcius
+
+  uint16_t     FanGain[TEMP_COUNT];
+
+  uint16_t     FanPwmMin;
+  uint16_t     FanAcousticLimitRpm;
+  uint16_t     FanThrottlingRpm;
+  uint16_t     FanMaximumRpm;
+  uint16_t     MGpuFanBoostLimitRpm;  
+  uint16_t     FanTargetTemperature;
+  uint16_t     FanTargetGfxclk;
+  uint16_t     FanPadding16;
+  uint8_t      FanTempInputSelect;
+  uint8_t      FanPadding;
+  uint8_t      FanZeroRpmEnable; 
+  uint8_t      FanTachEdgePerRev;
+
+  // The following are AFC override parameters. Leave at 0 to use FW defaults.
+  int16_t      FuzzyFan_ErrorSetDelta;
+  int16_t      FuzzyFan_ErrorRateSetDelta;
+  int16_t      FuzzyFan_PwmSetDelta;
+  uint16_t     FuzzyFan_Reserved;
+
+  // SECTION: AVFS 
+  // Overrides
+  uint8_t           OverrideAvfsGb[AVFS_VOLTAGE_COUNT];
+  uint8_t           dBtcGbGfxDfllModelSelect;  //0 -> fused piece-wise model, 1 -> piece-wise linear(PPTable), 2 -> quadratic model(PPTable)  
+  uint8_t           Padding8_Avfs;
+
+  QuadraticInt_t    qAvfsGb[AVFS_VOLTAGE_COUNT];              // GHz->V Override of fused curve 
+  DroopInt_t        dBtcGbGfxPll;         // GHz->V BtcGb
+  DroopInt_t        dBtcGbGfxDfll;        // GHz->V BtcGb
+  DroopInt_t        dBtcGbSoc;            // GHz->V BtcGb
+  LinearInt_t       qAgingGb[AVFS_VOLTAGE_COUNT];          // GHz->V 
+
+  PiecewiseLinearDroopInt_t   PiecewiseLinearDroopIntGfxDfll; //GHz ->Vstore in IEEE float format
+
+  QuadraticInt_t    qStaticVoltageOffset[AVFS_VOLTAGE_COUNT]; // GHz->V 
+
+  uint16_t          DcTol[AVFS_VOLTAGE_COUNT];            // mV Q2
+
+  uint8_t           DcBtcEnabled[AVFS_VOLTAGE_COUNT];
+  uint8_t           Padding8_GfxBtc[2];
+
+  uint16_t          DcBtcMin[AVFS_VOLTAGE_COUNT];       // mV Q2
+  uint16_t          DcBtcMax[AVFS_VOLTAGE_COUNT];       // mV Q2
+
+  uint16_t          DcBtcGb[AVFS_VOLTAGE_COUNT];       // mV Q2
+
+  // SECTION: XGMI
+  uint8_t           XgmiDpmPstates[NUM_XGMI_LEVELS]; // 2 DPM states, high and low.  0-P0, 1-P1, 2-P2, 3-P3.
+  uint8_t           XgmiDpmSpare[2];
+
+  // SECTION: Advanced Options
+  uint32_t          DebugOverrides;
+  QuadraticInt_t    ReservedEquation0;
+  QuadraticInt_t    ReservedEquation1;
+  QuadraticInt_t    ReservedEquation2;
+  QuadraticInt_t    ReservedEquation3;
+
+  // SECTION: Sku Reserved
+  uint8_t          CustomerVariant;
+
+    //VC BTC parameters are only applicable to VDD_GFX domain
+  uint8_t          VcBtcEnabled;
+  uint16_t         VcBtcVminT0;                 // T0_VMIN
+  uint16_t         VcBtcFixedVminAgingOffset;   // FIXED_VMIN_AGING_OFFSET 
+  uint16_t         VcBtcVmin2PsmDegrationGb;    // VMIN_TO_PSM_DEGRADATION_GB 
+  uint32_t         VcBtcPsmA;                   // A_PSM
+  uint32_t         VcBtcPsmB;                   // B_PSM
+  uint32_t         VcBtcVminA;                  // A_VMIN
+  uint32_t         VcBtcVminB;                  // B_VMIN  
+
+  //GPIO Board feature
+  uint16_t         LedGpio;            //GeneriA GPIO flag used to control the radeon LEDs
+  uint16_t         GfxPowerStagesGpio; //Genlk_vsync GPIO flag used to control gfx power stages 
+
+  uint32_t         SkuReserved[16];
+
+
+
+  // MAJOR SECTION: BOARD PARAMETERS
+
+  //SECTION: Gaming Clocks
+  uint32_t     GamingClk[6];
+
+  // SECTION: I2C Control
+  I2cControllerConfig_t  I2cControllers[NUM_I2C_CONTROLLERS];     
+
+  uint8_t      GpioScl;  // GPIO Number for SCL Line, used only for CKSVII2C1
+  uint8_t      GpioSda;  // GPIO Number for SDA Line, used only for CKSVII2C1
+  uint8_t      FchUsbPdSlaveAddr; //For requesting USB PD controller S-states via FCH I2C when entering PME turn off
+  uint8_t      I2cSpare[1];
+
+  // SECTION: SVI2 Board Parameters
+  uint8_t      VddGfxVrMapping;   // Use VR_MAPPING* bitfields
+  uint8_t      VddSocVrMapping;   // Use VR_MAPPING* bitfields
+  uint8_t      VddMem0VrMapping;  // Use VR_MAPPING* bitfields
+  uint8_t      VddMem1VrMapping;  // Use VR_MAPPING* bitfields
+
+  uint8_t      GfxUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+  uint8_t      SocUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+  uint8_t      VddciUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+  uint8_t      MvddUlvPhaseSheddingMask; // set this to 1 to set PSI0/1 to 1 in ULV mode
+
+  // SECTION: Telemetry Settings
+  uint16_t     GfxMaxCurrent;   // in Amps
+  int8_t       GfxOffset;       // in Amps
+  uint8_t      Padding_TelemetryGfx;
+
+  uint16_t     SocMaxCurrent;   // in Amps
+  int8_t       SocOffset;       // in Amps
+  uint8_t      Padding_TelemetrySoc;
+
+  uint16_t     Mem0MaxCurrent;   // in Amps
+  int8_t       Mem0Offset;       // in Amps
+  uint8_t      Padding_TelemetryMem0;
+
+  uint16_t     Mem1MaxCurrent;   // in Amps
+  int8_t       Mem1Offset;       // in Amps
+  uint8_t      Padding_TelemetryMem1;
+
+  uint32_t     MvddRatio; // This is used for MVDD  Svi2 Div Ratio workaround. It has 16 fractional bits (Q16.16)
+
+  // SECTION: GPIO Settings
+  uint8_t      AcDcGpio;        // GPIO pin configured for AC/DC switching
+  uint8_t      AcDcPolarity;    // GPIO polarity for AC/DC switching
+  uint8_t      VR0HotGpio;      // GPIO pin configured for VR0 HOT event
+  uint8_t      VR0HotPolarity;  // GPIO polarity for VR0 HOT event
+
+  uint8_t      VR1HotGpio;      // GPIO pin configured for VR1 HOT event 
+  uint8_t      VR1HotPolarity;  // GPIO polarity for VR1 HOT event 
+  uint8_t      GthrGpio;        // GPIO pin configured for GTHR Event
+  uint8_t      GthrPolarity;    // replace GPIO polarity for GTHR
+
+  // LED Display Settings
+  uint8_t      LedPin0;         // GPIO number for LedPin[0]
+  uint8_t      LedPin1;         // GPIO number for LedPin[1]
+  uint8_t      LedPin2;         // GPIO number for LedPin[2]
+  uint8_t      LedEnableMask;
+
+  uint8_t      LedPcie;        // GPIO number for PCIE results
+  uint8_t      LedError;       // GPIO number for Error Cases
+  uint8_t      LedSpare1[2];
+
+  // SECTION: Clock Spread Spectrum
+
+  // GFXCLK PLL Spread Spectrum
+  uint8_t      PllGfxclkSpreadEnabled;   // on or off
+  uint8_t      PllGfxclkSpreadPercent;   // Q4.4
+  uint16_t     PllGfxclkSpreadFreq;      // kHz
+
+  // GFXCLK DFLL Spread Spectrum
+  uint8_t      DfllGfxclkSpreadEnabled;   // on or off
+  uint8_t      DfllGfxclkSpreadPercent;   // Q4.4
+  uint16_t     DfllGfxclkSpreadFreq;      // kHz
+
+  // UCLK Spread Spectrum
+  uint16_t     UclkSpreadPadding;
+  uint16_t     UclkSpreadFreq;      // kHz
+
+  // FCLK Spread Spectrum
+  uint8_t      FclkSpreadEnabled;   // on or off
+  uint8_t      FclkSpreadPercent;   // Q4.4
+  uint16_t     FclkSpreadFreq;      // kHz
+
+  // Section: Memory Config
+  uint32_t     MemoryChannelEnabled; // For DRAM use only, Max 32 channels enabled bit mask. 
+
+  uint8_t      DramBitWidth; // For DRAM use only.  See Dram Bit width type defines
+  uint8_t      PaddingMem1[3];
+
+  // Section: Total Board Power
+  uint16_t     TotalBoardPower;     //Only needed for TCP Estimated case, where TCP = TGP+Total Board Power
+  uint16_t     BoardPowerPadding; 
+
+  // SECTION: XGMI Training
+  uint8_t      XgmiLinkSpeed   [NUM_XGMI_PSTATE_LEVELS];
+  uint8_t      XgmiLinkWidth   [NUM_XGMI_PSTATE_LEVELS];
+
+  uint16_t     XgmiFclkFreq    [NUM_XGMI_PSTATE_LEVELS];
+  uint16_t     XgmiSocVoltage  [NUM_XGMI_PSTATE_LEVELS];
+
+  // SECTION: UMC feature flags
+  uint8_t      HsrEnabled;
+  uint8_t      VddqOffEnabled;
+  uint8_t      PaddingUmcFlags[2];
+
+  // UCLK Spread Spectrum
+  uint8_t      UclkSpreadPercent[16];   
+
+  // SECTION: Board Reserved
+  uint32_t     BoardReserved[11];
+
+  // SECTION: Structure Padding
+
+  // Padding for MMHUB - do not modify this
+  uint32_t     MmHubPadding[8]; // SMU internal use
+
+
+} PPTable_beige_goby_t;
+
 typedef struct {
   // Time constant parameters for clock averages in ms
   uint16_t     GfxclkAverageLpfTau;
@@ -1265,4 +1626,5 @@ typedef struct {
 // These defines are used with the SMC_MSG_SetUclkFastSwitch message.
 #define UCLK_SWITCH_SLOW 0
 #define UCLK_SWITCH_FAST 1
+#define UCLK_SWITCH_DUMMY 2
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 83caa9a62bf2..a3b28979bc82 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -34,7 +34,7 @@
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
-#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0x7
+#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0x9
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
