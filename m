Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3A4C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 02:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F22E207EA
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 02:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="InU7EXXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F22E207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B116E82C;
	Tue, 15 Sep 2020 02:01:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3649A6E82C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 02:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu2vBpZbPXaPi07RwvpqY2x9E4khs/PUwRPFhW2ODbRUkW1OgR0VHV7gIoSfURdTS3/5v0FJukm98lC8hPGrTzsuBgU+Y40L51gSO47FnU6UjR28bGiahEDszc5UEBxBMZm/jWHaq7+ZUcuVy5fdlv0rC1AOW5vGaif2LAuv9+FMARdPEs9fp2wsvU1U3929mYDOiFR39OoLXrYVZqfNyvDpbTI2m3G3nL/VvZoP1CFGdDnDS54sFgvj5lQQ2BrWFG3jISBxAoy7bcIavQR2X8vT85usWZ7Wnper/Mt4T/2I+YwEXu0O+weAN9uMdUbwMcCVVok5mt1x+2OX4rmqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wQAGoTyF+/da6rkWJcM5sdJI5yDfMzKfM7qQsQ1ChU=;
 b=VTWqD5xwZiurbfUCIMYghGPG6QwXJdSFNzshWpW/e2ks8yVIwjKpXNBaHMXrYNtrPz4G1cJv9czYttN4gtnFU6cgZnry2cG12P8H2JPbP5mQs68pk/L68zTfGedsztOot7FREibmOXTqnCktuvQIeppyCY4+oyG7VcJvLRQ/toIGARvb+v52UlHL6zyFpuaWSXyYLhnVUf/idQXmDm9woIpk5t3HBzSBqzY5pl59VbfloYn7h/yTt2pR0n5SpezSuKROV0AWdTM/+2FXYS2z2hUIM6blVEkEIW1TwyfpfuMj2199OVTo49TSAFHXLeraRBeIFbh58ce1u6KOI1n0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wQAGoTyF+/da6rkWJcM5sdJI5yDfMzKfM7qQsQ1ChU=;
 b=InU7EXXdZ+BKQx4jCUjTgzLF28jX8lkjJ/F+ho/fc6qGaqVe2tA+hdzK/msiQiDKOYetnuVaxUrWCSnoh4CKPol1u+YpZUUUOY7cKT6WFp3to3u/XBi8auJN0ejl4MGRBYDR/kxiQfVpw/6Kk6ks8Mm7ThfiYUb+nV/LMs9yYms=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Tue, 15 Sep 2020 02:01:27 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3370.018; Tue, 15 Sep 2020
 02:01:27 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: stop resetting xgmi perfmons on disable
Thread-Topic: [PATCH 1/4] drm/amdgpu: stop resetting xgmi perfmons on disable
Thread-Index: AQHWheDuJvyGq6as6Uubhok5G8PDOqlo/EyQ
Date: Tue, 15 Sep 2020 02:01:27 +0000
Message-ID: <DM6PR12MB27614DF27957BA4234B814128C200@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20200908130603.10344-1-jonathan.kim@amd.com>
In-Reply-To: <20200908130603.10344-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-15T02:01:22Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f0a0430b-a619-40f4-9162-363a68df548c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:81e3:f385:61e0:4d2d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3f024c6-b279-4216-b614-08d8591b41bc
x-ms-traffictypediagnostic: DM6PR12MB2668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB266821F7F8714FBAE6B014B08C200@DM6PR12MB2668.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eUdJVtdvlliHsTjm/uDKRtmDWBUpSGBDmt5q+UzlSfbH/wHnRy41HluNSmGefgbKyOn3EPpYvj7s3lNkzakY7j08EpPpdc3hS//ofGcefwpj6TKJzRXtHd+Wyyy0FFNVbAvC4nR31jzg91gcbiXSUwNxtQhsxmqcA2nKgmESflKzyYEW4pjT3Kg3V0s6UZ+iCWfDK2jwvUkUvp3XgIZZLq2jmfvBGHWJrTIu1UDRgc+D0+QxZbQVXsTMG3wXwmlGSHl2QVA1pNYeidZKrbupo0EZb9C+kFJyybRn/MZbqbOJ/hT2kGsaf3ZQuTQNgK4UD0CtlSmSmGeVMnoRwTJhVWtpUEOCRjH2Yxb6EnSCrHrjGD+ZWM74/mmWJhCIgt6lymToZA5+E+5wOa82dlyvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(52536014)(2906002)(110136005)(53546011)(83380400001)(55016002)(45080400002)(33656002)(8676002)(6506007)(8936002)(316002)(71200400001)(4326008)(66556008)(64756008)(86362001)(54906003)(5660300002)(7696005)(966005)(9686003)(66476007)(478600001)(66446008)(76116006)(186003)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yNwxnhhoAzlf7WRKvaz6QzzPc5jXC4RD9elP/O5F1yZxaLdZZLwDrQ9hr73P+JOET09VhaAlGlv60imFHLtfpCkncX3SosHyUl467Yzp84Kdqho7u/4dKzLCBBOO5xP0UpM034G0rW1C8P2MUsG+P2jYNTLxBCv6eeA1WzTD43IYedFC9YpfEEA4vFqOgqMRaKmOtmkFQt7MCgP3Si5eXluY8czzGX31sx57WrnUfxThPOFg+S5kDl8TdERh8wOuAunloD5evFiIrVq+vOS0eFrNVeoSS2nd3iCiw+O2B1ostKte+nZDfWCh35QXS8ruDcbrvIDh06XGpGKncgoX0BnYC+Jm5k9Lr2TzHoLd8YDBPm1Li+x7m5VLJ/2WFzr8UFD8FA7FmmIp4HFBAtDTy2Yzg61emSHl7H49tjq86g49cEKZ8z8ITyFGwZEGJdr9B9vcPsKk72URwTe44CJXmq2sId34XlmYcoWFVwDwGnjz3lJVpjtLp1J/L317rILyV2kgQHlzVVDdTfEBXRZhe+wYWkx4sFWJIRsOqT2VbffjOZ1dyVe/M2mSArVqqoY5JTMhu7H4FlmaqA9xdPonoS4h4a/9MUNP/i+mo6iICWB7y8EHYaJ2eKCRyolEHyManRr5zVJRspzEGHwm9NcUm3hyjfHSMQLNnZMtknUV14oFRWithzAJttWy8h4WILYtPRV6CJVydlZ7cIgEhw73Xg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f024c6-b279-4216-b614-08d8591b41bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 02:01:27.2951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HENaEmmmUjxd/KnMHvRGOr0mVW6y3iW+BhXa7rUemiXTgCBbsxoTtvZ+l1LCJPX2kbynIZKqyVKrkQjw8ffLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jonathan Kim
Sent: Tuesday, September 8, 2020 9:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: stop resetting xgmi perfmons on disable

Disabling perf events does not specify reset in ABI so stop doing it in
hardware.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c   | 23 ++++++++++++++---------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 61a26c15c8dd..373cdebe0e2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -44,9 +44,9 @@ struct amdgpu_df_funcs {
 	void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device *adev,
 					    bool enable);
 	int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
-					 int is_enable);
+					 int is_add);
 	int (*pmc_stop)(struct amdgpu_device *adev, uint64_t config,
-					 int is_disable);
+					 int is_remove);
 	void (*pmc_get_count)(struct amdgpu_device *adev, uint64_t config,
 					 uint64_t *count);
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 2eab808fffeb..7b89fd2aa44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -455,7 +455,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr,
 					  uint32_t *lo_val,
-					  uint32_t *hi_val)
+					  uint32_t *hi_val,
+					  bool is_enable)
 {
 
 	uint32_t eventsel, instance, unitmask;
@@ -477,7 +478,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	instance_5432 = (instance >> 2) & 0xf;
 	instance_76 = (instance >> 6) & 0x3;
 
-	*lo_val = (unitmask << 8) | (instance_10 << 6) | eventsel | (1 << 22);
+	*lo_val = (unitmask << 8) | (instance_10 << 6) | eventsel;
+	*lo_val = is_enable ? *lo_val | (1 << 22) : *lo_val & ~(1 << 22);
 	*hi_val = (instance_76 << 29) | instance_5432;
 
 	DRM_DEBUG_DRIVER("config=%llx addr=%08x:%08x val=%08x:%08x",
@@ -572,14 +574,14 @@ static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
 }
 
 static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
-			     int is_enable)
+			     int is_add)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int err = 0, ret = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		if (is_enable)
+		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
 		df_v3_6_reset_perfmon_cntr(adev, config);
@@ -589,7 +591,8 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 					&lo_base_addr,
 					&hi_base_addr,
 					&lo_val,
-					&hi_val);
+					&hi_val,
+					true);
 
 		if (ret)
 			return ret;
@@ -612,7 +615,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 }
 
 static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
-			    int is_disable)
+			    int is_remove)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int ret = 0;
@@ -624,15 +627,17 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 			&lo_base_addr,
 			&hi_base_addr,
 			&lo_val,
-			&hi_val);
+			&hi_val,
+			false);
 
 		if (ret)
 			return ret;
 
-		df_v3_6_reset_perfmon_cntr(adev, config);
 
-		if (is_disable)
+		if (is_remove) {
+			df_v3_6_reset_perfmon_cntr(adev, config);
 			df_v3_6_pmc_release_cntr(adev, config);
+		}
 
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Charish.kasiviswanathan%40amd.com%7Cbaec81e867af49b73e8d08d853f80fa2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637351672173732796&amp;sdata=cd5%2BhKe%2Fz9QWs0QIH5zaTG3aWyLOUsOuViawyz9awNs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
