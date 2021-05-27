Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF52C4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 08:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360EA611C9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 08:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360EA611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDC86E06D;
	Fri, 28 May 2021 08:45:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED736E06D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 08:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQAzyHDmyKdfRQwSIkfH8twqsq6OFr/XJJMIkTT42qABfqt6d2vT/NGbAUoIlbv56b3/1lMRKC6bacH9SOF6m8XZPsOJ4Sr2t+j2xm7lkgn6xyMIbBU6u0kYxyFcoSxtTSLhM1qxlVIldY4PZG95ndLEGOaUEdXtfMCKWo1I+FDF1mqxtsKpMofIiFg5mJ76cq1KmrRIR/bbpY4SZweRuoq6e77K6oR1nrEmbc6tZSnQXO3sN+lEerFoaYzQALJnvtSHEzte7sUlyYjfJ9ihTc2t1keMsNCmLOAKx7zYqXS9vD+ml4HLhZ15cQQikJnMWrwgXiXMAecVKPaVvM9enA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwPSAyNjaLBLUcepE7Yc1S61mxuK+zJvArKWxw0zlrU=;
 b=VbXhTE0CmkbJ0VBe36/4aS7mcmVXcKpUChLeEs+Hlo9ydbMIAZGuX2B7g2C7RM+mNoycHBCgxN9xhd6KsDiAnnP5hCW6mE9Yxwlnf2annR//mCGallMdwMwArlY88vQxbduRD2NofNmpXJK36Xoa/bUfcDKV2fDjIGmX67c6ttndVg/FOQtjUUHt+VyK6NB+3+ABbJQNlKh5iERcL2uWuROlSGGOUSWLe46T81/I+OqQLwHbIHhNHMmX2AzES3xSBT7ay0z42myRumI9Stkx+rIY4ONg6EamYfELZLfVjYvA5p55ak7cf7tWZNIom09g3/L9HFLwo/DbiU4xIZqifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwPSAyNjaLBLUcepE7Yc1S61mxuK+zJvArKWxw0zlrU=;
 b=FmicJu63W7ahaIMyjP80ims9yakmJUA6WtvML39P48IEXnwqGUrrtUo6wIQ0d3il6djwGD32LDy3PSl1mCCijos+PhwTBZUQis6ppDWXV6SrUQCqwsqop6DkEx3DFa3m4iqEX4IZrFkC/GuXJ39nM7xizaiv7gdTXWODRHO2uq8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 08:45:30 +0000
Received: from MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c]) by MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 08:45:30 +0000
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: support atcs method powershift (v4)
Date: Thu, 27 May 2021 10:37:05 +0530
Message-Id: <20210527050705.11442-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.157.251]
X-ClientProxiedBy: MA1PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::20) To MN2PR12MB3839.namprd12.prod.outlook.com
 (2603:10b6:208:168::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-Mandolin-PCO.amd.com (165.204.157.251) by
 MA1PR01CA0170.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 08:45:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91346aa2-dbec-4463-d95d-08d921b4f291
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4302F2ABACD0C8C9D7706A999D229@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7H/9GKwNXq7fu+sSbRlblnStkfMmZUJCdgpi56EwzsXPOZcuwAGzFjOW605aoTZhc5gthpy62Nt7mqpsl02R1lVpf0Bo9fato1Aj4EU9EgiU/qBpVnjMqPhRbsOGZO7JpgqcmotgRZ+NY7PTS+apdqZ+6k/7UbyshDVbj4hrc8/LPreNySGbsBv9pAelJEoda2U1GGxgsNW88QnSOJfn6NzJtL/wCHAXplKt8NH6uY4rxhdvJ4gajV3nK0xHp8KDhaT37tL4j6iNBKtbpZlFO7ot2uCEX6opqP1vmG6G1k8KDFizTS1F/Ddu+xJK4UwAHiGtznPQN4jIVayCcAsYVUEZ1/wKU7xSkmaPdmuU07ZFmBM5xR0trgX8mMFBwSgOHbhPv5llzJ9ncB5soeMFG6nDYRGRNzd9trmcDrq59+G9wV/9xpqh1QSbacqXbiBzuxRRcJUhlcMiUPH3zGh3gr0apNtAOIrZyUIZ22bSjgTGxlYwkOQrYt2ZPnfj76iSrEOpEBPyAkE7ABID9TKc9Azev7ajEaoqGEKs/gMatYskR2oT6acqecYk3Q/2ooFK8ME0uOJSKy30Dr1hQVJ7LIzcNd9F78qIcP5UitHigPXqNVKSq1eOOfAiKwId9NIX0h/dRIvhmDZyipAGMW0iWi7rDn/2tYwQ/3KWwmv19M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(26005)(7696005)(52116002)(478600001)(16526019)(186003)(6486002)(86362001)(2906002)(6916009)(36756003)(6666004)(83380400001)(54906003)(316002)(4326008)(2616005)(8676002)(956004)(8936002)(5660300002)(66476007)(66556008)(1076003)(66946007)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RmVxbVdsTkZvM3lPaTBjS1pwc0daOFpMa0ticG1tSCtXQWhQWTF2Tk40ZWV4?=
 =?utf-8?B?MWJXVzY3WnNvZ1JuM2FvREFtSjR2TGJJNVJGaStxY09XM2JXdUJOOHNueXc1?=
 =?utf-8?B?cytBVDJXL3l0RG9xblg5RHI4NGJxSXUwRzVPakJDeHFKQ1dLS1dSMjRaMVhH?=
 =?utf-8?B?Sk5PV2hGQzl0czZ2aFEzVnA2MUxtMXRlMS9HQmxlcDdSaXBDUU45SksyT3cw?=
 =?utf-8?B?MUJzTEtaNDlFOUxibTFMRkQySTVESG45YTAvVjNQQTIrUTNtRmtWN1d3ZXFv?=
 =?utf-8?B?UlcwdE1Qc0IrUzFGYzNtWDJtM3lQUnMwa3hJa0JXZktEZUx6ZHJzN0J1WUdj?=
 =?utf-8?B?d1lLV2J3eUdEVThlRndSUy9ZZkJkMm4wUXh5Z1RHRVJQSlBidEJoYUJUb1M3?=
 =?utf-8?B?VktxWUxvVVM3WTFUWVZGZ3A2L0h3a1ZjeE54eGYwYlhqaFJCd2NqMVdyaFFp?=
 =?utf-8?B?V05HMEVvZlVEN0tYNkt1bHcxNy83NFpsM3VUN0xBejE2ZmIwY2JKTTFtREdE?=
 =?utf-8?B?UkF4eUlMNGVyK2dCdFFwUWo5eWZqWUVXZmdhVUdBbmZRNUdGb3RyRVhRbHc4?=
 =?utf-8?B?SnIwd2IwWnNZNzk3RXJtQVNpMS9QdUlDM3dIeUEzVWpsTnhoM1NONEJzekp3?=
 =?utf-8?B?cS9iSnFJdHIzVERFcDdDMkNYWWtwc1pJMDE1eVRhVGEzV2tHakE0SUZZSnRt?=
 =?utf-8?B?cDc4UUNoRWxsaE9ka1JtV3Q1WWJlZHVrN2VCTUN0WkFZSnlzWjd2SHJCcTlz?=
 =?utf-8?B?OWhRQ3o1S05YTXdKYldBUndicERLUGtIaE50ZUxTNjF3VXhBRWY0dXlZTkJR?=
 =?utf-8?B?T0xQcU84Y1BhQUxnMDZ1WnJteExXejg0WGt5V1hURmdGMU1wK29kZkc2ekEz?=
 =?utf-8?B?VnQzUVkrTmk5a2RLQVMzWE96cCthMkpvZkFsNTN2U0RNb2RBK2swYkZIL3JH?=
 =?utf-8?B?ZVg5R0FxSlRoT1hwTndZVWpwTkRmdEdwdlo5TUdsdWNzZTV4T1pGaGJ6YWtJ?=
 =?utf-8?B?aXJUZmxRQXpMeGowNnI2bzVvQmlDNlJBT3FjNXhONDdEazRLd0hwdlB1WVZ0?=
 =?utf-8?B?TE0xYkhPMDkyTURHSmhTMDFIQmk0VVFQcEI2dzlDb3FQL0ZtL1lETlFOVUVr?=
 =?utf-8?B?aVJ6eFBBR2FGQ3A4U1M4T0d6NEl3dkZjaVB3U3l6Z0pxWEZKVDZ5N0cyQnpP?=
 =?utf-8?B?Y2FKb1FwWUYxSHVxWWtlK3pwc2c5c1A3am51cDVrandFRkJuTXdqNjZiMGRY?=
 =?utf-8?B?V05oWGtuNmNFUEZ1RFczTnRwZEhsOSsrRkZLQWZhNHFTdkZudGRGRktuWWhH?=
 =?utf-8?B?OVNrcUVYTjM0WWVMR0JRaERlLzVVVUIveWxIcFBjOFA3ZmtySTRXR2h5cVZn?=
 =?utf-8?B?cVVDWHp4RnE3Y2hzcmV1a2x0SDZWRy9ibjJUY0JITVg1Ny8xc1EvVnFtb1hE?=
 =?utf-8?B?ekdpeTRrZFlIU1h4Q1B5cGt3RUc1ZC9aL3NxY3g4ZzZRb2dJOFFKQmt6RHlr?=
 =?utf-8?B?UWx3b3I2RGthMFRNSS9IZ2ZCL2NBNmc2YUNPZUFId2I5V01CSTNxQm5Bbk1O?=
 =?utf-8?B?VEVnZkllT1AyL2lhRTRNSG93OEplMDZwaDJIY2RPSjhDT29uQ253SXBYRURx?=
 =?utf-8?B?Q25EM1pGUjFXSEx0VHp0U1J1cDN4YlB1MjNPaEFlREhKdDFXd081eFZHZEd6?=
 =?utf-8?B?eTFXZ1IvY1N3WEpBdThJcW9lNEhTMGUzY0VSTDRPbXlmRHdXMjM0elJ1dUtt?=
 =?utf-8?B?NkxodTVZRytYM3c3WUV6MHRZcnZoT3dqQjI4Vm1xUlRiQlNFNEpMQWFXRUVE?=
 =?utf-8?B?UnlGdGVTWWJISzhRenJkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91346aa2-dbec-4463-d95d-08d921b4f291
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 08:45:29.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj8u3iEtBBiOfo/VrAcV91HQEsTRHRLZPE9xJwnEqxc+CXZKSQLXhl1a6oV2nqwvmHaXuJLWYYXyYWXr3RSROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add support to handle ATCS method for power shift control.
used to communicate dGPU device state to SBIOS.

V2: use defined acpi func for checking psc support (Lijo)
    fix alignment (Shashank)
V3: rebased on unified ATCS handling (Alex)
V4: rebased on ATPX/ATCS structures global (Alex)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 55 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_acpi.h   | 18 ++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7b794957515f..0ea2ed3a55f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1343,8 +1343,11 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock);
 int amdgpu_acpi_init(struct amdgpu_device *adev);
 void amdgpu_acpi_fini(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev);
+bool amdgpu_acpi_is_power_shift_control_supported(void);
 int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 						u8 perf_req, bool advertise);
+int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
+				    u8 dev_state, bool drv_state);
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
@@ -1355,6 +1358,9 @@ static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
 static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
+static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
+static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
+						  u8 dev_state, bool drv_state) { return 0; }
 #endif
 
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index bbff6c06f943..b631316bfe5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -76,6 +76,7 @@ struct amdgpu_atcs_functions {
 	bool pcie_perf_req;
 	bool pcie_dev_rdy;
 	bool pcie_bus_width;
+	bool power_shift_control;
 };
 
 struct amdgpu_atcs {
@@ -534,6 +535,7 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
 	f->pcie_perf_req = mask & ATCS_PCIE_PERFORMANCE_REQUEST_SUPPORTED;
 	f->pcie_dev_rdy = mask & ATCS_PCIE_DEVICE_READY_NOTIFICATION_SUPPORTED;
 	f->pcie_bus_width = mask & ATCS_SET_PCIE_BUS_WIDTH_SUPPORTED;
+	f->power_shift_control = mask & ATCS_SET_POWER_SHIFT_CONTROL_SUPPORTED;
 }
 
 /**
@@ -598,6 +600,18 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
 	return false;
 }
 
+/**
+ * amdgpu_acpi_is_power_shift_control_supported
+ *
+ * Check if the ATCS power shift control method
+ * is supported.
+ * returns true if supported, false if not.
+ */
+bool amdgpu_acpi_is_power_shift_control_supported(void)
+{
+	return amdgpu_acpi_priv.atcs.functions.power_shift_control;
+}
+
 /**
  * amdgpu_acpi_pcie_notify_device_ready
  *
@@ -699,6 +713,47 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * amdgpu_acpi_power_shift_control
+ *
+ * @adev: amdgpu_device pointer
+ * @dev_state: device acpi state
+ * @drv_state: driver state
+ *
+ * Executes the POWER_SHIFT_CONTROL method to
+ * communicate current dGPU device state and
+ * driver state to APU/SBIOS.
+ * returns 0 on success, error on failure.
+ */
+int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
+				    u8 dev_state, bool drv_state)
+{
+	union acpi_object *info;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
+	struct atcs_pwr_shift_input atcs_input;
+	struct acpi_buffer params;
+
+	if (!amdgpu_acpi_is_power_shift_control_supported())
+		return -EINVAL;
+
+	atcs_input.size = sizeof(struct atcs_pwr_shift_input);
+	/* dGPU id (bit 2-0: func num, 7-3: dev num, 15-8: bus num) */
+	atcs_input.dgpu_id = adev->pdev->devfn | (adev->pdev->bus->number << 8);
+	atcs_input.dev_acpi_state = dev_state;
+	atcs_input.drv_state = drv_state;
+
+	params.length = sizeof(struct atcs_pwr_shift_input);
+	params.pointer = &atcs_input;
+
+	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_POWER_SHIFT_CONTROL, &params);
+	if (!info) {
+		DRM_ERROR("ATCS PSC update failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_acpi_event - handle notify events
  *
diff --git a/drivers/gpu/drm/amd/include/amd_acpi.h b/drivers/gpu/drm/amd/include/amd_acpi.h
index c72cbfe8f684..2d089d30518f 100644
--- a/drivers/gpu/drm/amd/include/amd_acpi.h
+++ b/drivers/gpu/drm/amd/include/amd_acpi.h
@@ -103,6 +103,13 @@ struct atcs_pref_req_output {
 	u8 ret_val;		/* return value */
 } __packed;
 
+struct atcs_pwr_shift_input {
+	u16 size;		/* structure size in bytes (includes size field) */
+	u16 dgpu_id;		/* client id (bit 2-0: func num, 7-3: dev num, 15-8: bus num) */
+	u8 dev_acpi_state;	/* D0 = 0, D3 hot = 3 */
+	u8 drv_state;	/* 0 = operational, 1 = not operational */
+} __packed;
+
 /* AMD hw uses four ACPI control methods:
  * 1. ATIF
  * ARG0: (ACPI_INTEGER) function code
@@ -418,6 +425,7 @@ struct atcs_pref_req_output {
 #       define ATCS_PCIE_PERFORMANCE_REQUEST_SUPPORTED             (1 << 1)
 #       define ATCS_PCIE_DEVICE_READY_NOTIFICATION_SUPPORTED       (1 << 2)
 #       define ATCS_SET_PCIE_BUS_WIDTH_SUPPORTED                   (1 << 3)
+#       define ATCS_SET_POWER_SHIFT_CONTROL_SUPPORTED		   (1 << 7)
 #define ATCS_FUNCTION_GET_EXTERNAL_STATE                           0x1
 /* ARG0: ATCS_FUNCTION_GET_EXTERNAL_STATE
  * ARG1: none
@@ -472,4 +480,14 @@ struct atcs_pref_req_output {
  * BYTE  - number of active lanes
  */
 
+#define ATCS_FUNCTION_POWER_SHIFT_CONTROL                          0x8
+/* ARG0: ATCS_FUNCTION_POWER_SHIFT_CONTROL
+ * ARG1:
+ * WORD  - structure size in bytes (includes size field)
+ * WORD  - dGPU id (bit 2-0: func num, 7-3: dev num, 15-8: bus num)
+ * BYTE  - Device ACPI state
+ * BYTE  - Driver state
+ * OUTPUT: none
+ */
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
