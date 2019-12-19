Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E51C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 21:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620D02465E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 21:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hyhv/yMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620D02465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF716E08E;
	Thu, 19 Dec 2019 21:31:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EAA6E08E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 21:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbyRFtKxNmz3eEumm/ELb5GyPgPc3hPy95K28A7ZASesleDS1ZXs2ptrQKiLm+n8Zmv2DQUU5e77Nk48ZXS9YU0theDIa7ftupEGho2UZGuBTTTD0Fo4xtbVWH+s2VFb+uMs6ZOvHycFLZhJNW6PXKcPrMkUSGR8VleNPNvwDIxMYVSOh+vxL0/tiiHTPLzjADhJYkETVzzXb8zNeS9N3lg6wYsN0bWKDi+goi/DGm8HUggf5dep6QRzpemMMJ/Rk2Q7MqDeVnLYBLb6Vdtf7Z2/pex7k3jlHCzBUKFdEYVG4xpHN4C2B/RtnKJAEBvFEl3ffwM4mQDVSoZQW7EfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r+fpI3SorP5j8JLQGbJhZETaVA75vqhguuuG9Y16O4=;
 b=N0v/0V1EX1x3Zdw/V7lmD14OqaytaAVtJHjFOc0ENVZgnSoQbf8OBPGXWMXDBAdeCahF+fAkiEv5jFqP/qikH0wAGfxmb5gmBm0SdnYAiXDLtF4hgVKajLBemaDTeiTQVgahuPvA0Yz7hMRRTblR3n4bzlpHKrBsWdeehDyGHPsiddsmiBcO+UnhY3muZINusZtE0PIQDXHS8nH9TgefAghzgfDmZhQRV281LbIP0FMV3B0rX9IeowR030PnTDYzr21P+xZup883OpX44r8+H26ne3T1RfQdg+yfdqA7fo9y9goQeUEF2Wj6D8YdlLavVVRDVCYjsqLSVv5g8Vjjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r+fpI3SorP5j8JLQGbJhZETaVA75vqhguuuG9Y16O4=;
 b=hyhv/yMCZoV2iBumo4rMfV/pef3EQRjaq1dkG7W9bdQhTVGRKkf7Cq9FSecBTrX5+/itS1lFPJxHTU/RwmRdvOhDdmJNgu9tHvsifDFwKTOd4XhJDf3MDYv4IPT+BJj3+d29wMpRpi9+tlmNRk+HeXGd70WtNBoRzZn9Vpk+SME=
Received: from CH2PR12MB3831.namprd12.prod.outlook.com (52.132.245.141) by
 CH2PR12MB4294.namprd12.prod.outlook.com (20.180.6.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 21:31:54 +0000
Received: from CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::adcc:f57d:89f5:279f]) by CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::adcc:f57d:89f5:279f%5]) with mapi id 15.20.2538.022; Thu, 19 Dec 2019
 21:31:54 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: attempt xgmi perfmon re-arm on failed arm
Thread-Topic: [PATCH] drm/amdgpu: attempt xgmi perfmon re-arm on failed arm
Thread-Index: AQHVtrOY5t2/6BHcX0akzFnzTQ6n96fB+eFg
Date: Thu, 19 Dec 2019 21:31:53 +0000
Message-ID: <CH2PR12MB38318374E5C67F3878AA7C1185520@CH2PR12MB3831.namprd12.prod.outlook.com>
References: <20191219213044.129948-1-jonathan.kim@amd.com>
In-Reply-To: <20191219213044.129948-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T21:31:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8a005782-b3e4-4fd3-8d27-00003480f7b1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-19T21:31:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 84b21106-bd8b-4f79-94be-00008ba64028
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da8f4c93-31fe-456c-af74-08d784cade24
x-ms-traffictypediagnostic: CH2PR12MB4294:|CH2PR12MB4294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4294E18BB8CC4B4DFA56032A85520@CH2PR12MB4294.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39850400004)(396003)(136003)(346002)(189003)(199004)(13464003)(2906002)(71200400001)(66476007)(66946007)(7696005)(6916009)(64756008)(76116006)(66556008)(66446008)(4326008)(316002)(55016002)(33656002)(478600001)(86362001)(26005)(53546011)(9686003)(81156014)(8676002)(81166006)(52536014)(8936002)(5660300002)(6506007)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4294;
 H:CH2PR12MB3831.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fj8Q/I7jsfEIdWUSX3NBJhYSwKtnrLdUudtiF+KNOVeWoqAiLwy6b87lOHW1WfSnX7I7bSLb7+4vYPXCHfcl03wig+r+Gb4CUOUulZ7tGGqycJbW8j83SKP2BLQRFiIOPRHKvK94J00J3w8BblOl0E7EyG7DEKUd3OaLGyOWa7pSPVMT0fsGdUkTVgWUW7qt8yPDlzFWOTZsTI6L61Iq8fyA4SbA7Pu1PyLCsDIkKwNKnJFlS/xXZ4rW8mOd4jg2WqiBLgOaIYde2jHlsX5d1XS+eln7AK4YM1/5fJiD94gj0xy70Ix+uUajcgPmEPHBHny9+ZXB3c8ni46GJL3eU63uhoD05be4BUgz4NqZSv5JazAY4832ECrr6lT9L2kufxRm7GjuYbGaND6f5Qj7diGI0qulTv07F84ge3bFWjjHqSEK9W6UCTmZlYAxHAFIdUscwLNoepcW2tMMtxa2vroNRzTwPVA8ijOyjuoPjXiMd7TSbQ8JWdQQpTb0Vl8f
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8f4c93-31fe-456c-af74-08d784cade24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 21:31:53.9152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4EQIeO0u3OiPcNqt0/qrnrSRQHlgDri3kaSCNbJctlyH04AM/X3JXBb64fi8ocD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com> 
Sent: Thursday, December 19, 2019 4:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Felix.Khueling@amd.com; Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH] drm/amdgpu: attempt xgmi perfmon re-arm on failed arm

The DF routines to arm xGMI performance will attempt to re-arm both on performance monitoring start and read on initial failure to arm.

v3: Addressing nit-picks.

v2: Roll back reset_perfmon_cntr to void return since new perfmon counters are now safe to write to during DF C-States.  Do single perfmon controller re-arm when counter is deferred in pmc_count versus multiple perfmon controller re-arms that could last 1 millisecond. Avoid holding spin lock during sleep in perfmon_arm_with_retry.  Rename counter arm defer function to be less confusing.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 151 +++++++++++++++++++++++----
 1 file changed, 129 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 4043ebcea5de..2f884d941e8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -183,6 +183,61 @@ static void df_v3_6_perfmon_wreg(struct amdgpu_device *adev, uint32_t lo_addr,
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);  }
 
+/* same as perfmon_wreg but return status on write value check */ 
+static int df_v3_6_perfmon_arm_with_status(struct amdgpu_device *adev,
+					  uint32_t lo_addr, uint32_t lo_val,
+					  uint32_t hi_addr, uint32_t  hi_val) {
+	unsigned long flags, address, data;
+	uint32_t lo_val_rb, hi_val_rb;
+
+	address = adev->nbio.funcs->get_pcie_index_offset(adev);
+	data = adev->nbio.funcs->get_pcie_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	WREG32(address, lo_addr);
+	WREG32(data, lo_val);
+	WREG32(address, hi_addr);
+	WREG32(data, hi_val);
+
+	WREG32(address, lo_addr);
+	lo_val_rb = RREG32(data);
+	WREG32(address, hi_addr);
+	hi_val_rb = RREG32(data);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	if (!(lo_val == lo_val_rb && hi_val == hi_val_rb))
+		return -EBUSY;
+
+	return 0;
+}
+
+
+/*
+ * retry arming counters every 100 usecs within 1 millisecond interval.
+ * if retry fails after time out, return error.
+ */
+#define ARM_RETRY_USEC_TIMEOUT	1000
+#define ARM_RETRY_USEC_INTERVAL	100
+static int df_v3_6_perfmon_arm_with_retry(struct amdgpu_device *adev,
+					  uint32_t lo_addr, uint32_t lo_val,
+					  uint32_t hi_addr, uint32_t  hi_val) {
+	int countdown = ARM_RETRY_USEC_TIMEOUT;
+
+	while (countdown) {
+
+		if (!df_v3_6_perfmon_arm_with_status(adev, lo_addr, lo_val,
+						     hi_addr, hi_val))
+			break;
+
+		countdown -= ARM_RETRY_USEC_INTERVAL;
+		udelay(ARM_RETRY_USEC_INTERVAL);
+	}
+
+	return countdown > 0 ? 0 : -ETIME;
+}
+
 /* get the number of df counters available */  static ssize_t df_v3_6_get_df_cntr_avail(struct device *dev,
 		struct device_attribute *attr,
@@ -334,20 +389,20 @@ static void df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
 	switch (target_cntr) {
 
 	case 0:
-		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo0 : smnPerfMonCtrLo0;
-		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi0 : smnPerfMonCtrHi0;
+		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo4 : smnPerfMonCtrLo4;
+		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi4 : smnPerfMonCtrHi4;
 		break;
 	case 1:
-		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo1 : smnPerfMonCtrLo1;
-		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi1 : smnPerfMonCtrHi1;
+		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo5 : smnPerfMonCtrLo5;
+		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi5 : smnPerfMonCtrHi5;
 		break;
 	case 2:
-		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo2 : smnPerfMonCtrLo2;
-		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi2 : smnPerfMonCtrHi2;
+		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo6 : smnPerfMonCtrLo6;
+		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi6 : smnPerfMonCtrHi6;
 		break;
 	case 3:
-		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo3 : smnPerfMonCtrLo3;
-		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi3 : smnPerfMonCtrHi3;
+		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo7 : smnPerfMonCtrLo7;
+		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi7 : smnPerfMonCtrHi7;
 		break;
 
 	}
@@ -422,6 +477,44 @@ static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
 	return -ENOSPC;
 }
 
+#define DEFERRED_ARM_MASK	(1 << 31)
+static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
+				    uint64_t config, bool is_deferred) {
+	int target_cntr;
+
+	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
+
+	if (target_cntr < 0)
+		return -EINVAL;
+
+	if (is_deferred)
+		adev->df_perfmon_config_assign_mask[target_cntr] |=
+							DEFERRED_ARM_MASK;
+	else
+		adev->df_perfmon_config_assign_mask[target_cntr] &=
+							~DEFERRED_ARM_MASK;
+
+	return 0;
+}
+
+static bool df_v3_6_pmc_is_deferred(struct amdgpu_device *adev,
+				    uint64_t config)
+{
+	int target_cntr;
+
+	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
+
+	/*
+	 * we never get target_cntr < 0 since this function is only called in
+	 * pmc_count for now but we should check anyways.
+	 */
+	return (target_cntr >= 0 &&
+			(adev->df_perfmon_config_assign_mask[target_cntr]
+			& DEFERRED_ARM_MASK));
+
+}
+
 /* release performance counter */
 static void df_v3_6_pmc_release_cntr(struct amdgpu_device *adev,
 				     uint64_t config)
@@ -451,29 +544,33 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 			     int is_enable)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
-	int ret = 0;
+	int err = 0, ret = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+		if (is_enable)
+			return df_v3_6_pmc_add_cntr(adev, config);
 
 		df_v3_6_reset_perfmon_cntr(adev, config);
 
-		if (is_enable) {
-			ret = df_v3_6_pmc_add_cntr(adev, config);
-		} else {
-			ret = df_v3_6_pmc_get_ctrl_settings(adev,
+		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 					config,
 					&lo_base_addr,
 					&hi_base_addr,
 					&lo_val,
 					&hi_val);
 
-			if (ret)
-				return ret;
+		if (ret)
+			return ret;
+
+		err = df_v3_6_perfmon_arm_with_retry(adev,
+						     lo_base_addr,
+						     lo_val,
+						     hi_base_addr,
+						     hi_val);
 
-			df_v3_6_perfmon_wreg(adev, lo_base_addr, lo_val,
-					hi_base_addr, hi_val);
-		}
+		if (err)
+			ret = df_v3_6_pmc_set_deferred(adev, config, true);
 
 		break;
 	default:
@@ -501,7 +598,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 		if (ret)
 			return ret;
 
-		df_v3_6_perfmon_wreg(adev, lo_base_addr, 0, hi_base_addr, 0);
+		df_v3_6_reset_perfmon_cntr(adev, config);
 
 		if (is_disable)
 			df_v3_6_pmc_release_cntr(adev, config); @@ -518,18 +615,29 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 				  uint64_t config,
 				  uint64_t *count)
 {
-	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
+	uint32_t lo_base_addr, hi_base_addr, lo_val = 0, hi_val = 0;
 	*count = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-
 		df_v3_6_pmc_get_read_settings(adev, config, &lo_base_addr,
 				      &hi_base_addr);
 
 		if ((lo_base_addr == 0) || (hi_base_addr == 0))
 			return;
 
+		/* rearm the counter or throw away count value on failure */
+		if (df_v3_6_pmc_is_deferred(adev, config)) {
+			int rearm_err = df_v3_6_perfmon_arm_with_status(adev,
+							lo_base_addr, lo_val,
+							hi_base_addr, hi_val);
+
+			if (rearm_err)
+				return;
+
+			df_v3_6_pmc_set_deferred(adev, config, false);
+		}
+
 		df_v3_6_perfmon_rreg(adev, lo_base_addr, &lo_val,
 				hi_base_addr, &hi_val);
 
@@ -542,7 +650,6 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 			 config, lo_base_addr, hi_base_addr, lo_val, hi_val);
 
 		break;
-
 	default:
 		break;
 	}
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
