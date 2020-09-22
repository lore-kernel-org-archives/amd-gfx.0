Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B17C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 02:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784D423A60
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 02:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cEPh6ulk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784D423A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D568A6E5D5;
	Tue, 22 Sep 2020 02:04:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B839B6E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 02:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STU+HapqfW6ozoC+DoRYNbWEKwPbWL7vJpdxP+94OZ8Irem7725ZHRTvImmF5JjuN42Ys7sWX109tJX7GEXirfmmi0PH2O8LWIYPS4Qr6ETx29UKokWldN/Qe2gOpfS0JP7XyfmQHkkvgguNmaIuP0fd94C3nT6Wop6jFucuuxzVlZs+TLA/oar4KeN/Cdz3dFnBr6laBHnjrxrmg/2K4om0BokT2hEcNcaMyknnn5s/5nKiouxGZmeFZXRPdG6OHVGmf7xmlGlry0yiH9UeC6p61xeDhLOGGomxTKft3ZKHKgjIq0HkZb/osT3MAV8dA47qJ5WekybH82CQngxktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZhcZzMwJxp+0yqA3QTj5K77hLQKYxUXx4GCn4JySM8=;
 b=c7qZYdSK+7DyGkM9yKziXrKQTBkPEpvQr4OQAnL4D3oqhInrTtjrmcoTV2GpY1rQYvcQRlkQk6/SbujtHe9hCp4ro0yCkN7soneeQtC6Lf5XiX2o8Xf5h7rwhbTkFkIaB2VVnOYj03dX8u4vDWjAhp/TtWWdhb12ERfvAgSL4MkEyk5BM20dGi7ExxuKQEolIcGDRgd7ZWCqNnhYaz9J6mHyT4xcJbEz0uMPpaMHZCnc4CyZcu6DnvHJqX6guL2gddqV5ntzomSbYCOudlsVhoYbYRFDd1VYyoSL2NaojPSXWqx7HReEx5XrmvM42/oAaOVamnl4FA3lZ9Rq5S0d7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZhcZzMwJxp+0yqA3QTj5K77hLQKYxUXx4GCn4JySM8=;
 b=cEPh6ulkxNnFalIsFdP3YzETZwypI4/lKh03B228+JOubGN6tlKU/kaZD7BEEISXnYp+fZp2uB6xgep/geN5fUcc0+M347Ifa0PbYDxgaNqWpyDx+NDQI9eNyqRoNYVx2oqFpQKFF0zCaOAnk+rdfF++87STObW9w+l++IZqSak=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Tue, 22 Sep 2020 02:03:58 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.025; Tue, 22 Sep 2020
 02:03:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Khaire, Rohit"
 <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna
 cichlid SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna
 cichlid SRIOV
Thread-Index: AQHWgjxlQ0y0sagecEiXuzscIaGVt6lztEaAgABO7JCAAAFdkA==
Date: Tue, 22 Sep 2020 02:03:58 +0000
Message-ID: <DM6PR12MB407522E6B7B66C69678030AFFC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200903215027.6823-1-rohit.khaire@amd.com>
 <BN6PR12MB162088225A53EA064E648697873A0@BN6PR12MB1620.namprd12.prod.outlook.com>
 <DM6PR12MB4075BE5E30C2F23D66AA5FE1FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075BE5E30C2F23D66AA5FE1FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Monk.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-21T21:14:52Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dd94a889-ec62-443b-b06a-db0ef43069c1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T02:03:54Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3fc67bae-7b4b-47db-b2a2-0000340b0773
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8af280ff-ac75-4339-ebf2-08d85e9bc4bb
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3274716D2FC9F6BA70BFE98BFC3B0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AIFFJGGNFnMVcF896+PJYtKHozm5PZQBn75q/mTSO1SNBiMTr5G/PtJ4vglPw+YODVizDgZ+V5G7KkekxsR3wpyGD5Y02NbG/hPvwh3M70llDdPtz8rUeZLVg7gf9k/hluz7tKyeb5WBenNnMindp/LaVNrs+gjDbl3Dd7sNFaOMOxb1ePezFTnoSAwXB4tubhj4y4TTjGXRPOr2uT9ACXWrv29zpR6KP5V7RcE07IPR1b/2+w+sbNACnzNsKHQ2wvA9wSsCQ0eGd4vlDqTbBsuLqHTyyNcHqpITVaVJtzgqP02OHIq5abLQ3ZiA0gTI2Hmtw4LEDWrvKzVaF1E0iOb7g1TIdm6ZeJpFMeN+kUGbCDQlhwF+/wtPLeQDGYvXjAj7hj6d6yFAtgxuZ7tEQAiF1loFtXKq2DitMKiYDg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(33656002)(71200400001)(9686003)(52536014)(6506007)(30864003)(8936002)(2906002)(5660300002)(7696005)(53546011)(8676002)(66476007)(66946007)(66556008)(66446008)(64756008)(76116006)(110136005)(966005)(6636002)(316002)(26005)(83380400001)(2940100002)(86362001)(45080400002)(186003)(54906003)(55016002)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GxjEYIkVgG9+EDd1vvhQBdPqnAyPmeytjvEZzoCuxaM3J7LdTb7ug40EiWKfhBeZs0rKKSNDAAzk/KGMA9GCd5s9grMQ0UKU/aw2e6fyebo4X0qHbig4WTNBpCldYSISlqH8I9YfZVhL9kLo9nXox+ylpjilBXhz+Xgt/oyUT0dpAM8Diuv0K178fjvP2K2ecPUlIC2AWHFBWP+gdy8r55LjMUgyBLelTVi2KSTOjcd460ws0RNB5p5KlILqELsUDH5jOTbb7HuHQrTt9ZAweWf54QvR8xjUirPJikZ391T9JuSQSW/NFqBTowK1EBolOLBffr9rrOKVwpVxZHP3QeUYD17RhdmsrYWV97LcAN6jD3MYFpkDEOug4gRiKn9w/P8G0Dt6zCWqpEr0UBTU+hGn2e3zCA6Tz7PUez1x6UB4diyavjVnq7G4549gF2m8umbKM3SD9/rva+ERkuL6HWgO3mOhHnbfZdNFkuDGM3WfRhfLFNJpZT3vNjquHoDnlsqeryXHmYz89Ah1Pb5NUK7s1JKY7BteUIvDAUwsCA2f5cbGx3DUe+Tx+KKbOf/g8b7Sn7DlzU4ImSFmDut4acuc7mMgE0Iw7YpRmizGJ+tpQvHrUh8hemgQkbXH2legOUwlKwT4/Me1YbqI1CcRWQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af280ff-ac75-4339-ebf2-08d85e9bc4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 02:03:58.4933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIMxxEQBcoTo5z3nRYsHEjbBgyU6mpS55YZ3fbUN0YWEjGXW2pNfpJZ0oaDy46kQnE0bT07cVCdPcZLszBOrMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Li, Rong \(Zero\)" <Rong.Li@amd.com>,
 "Min, Frank" <Frank.Min@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Add @Liu, Monk for a more reasonable approach if any.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Tuesday, September 22, 2020 10:02
To: Khaire, Rohit <Rohit.Khaire@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Li, Rong (Zero) <Rong.Li@amd.com>; Min, Frank <Frank.Min@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna cichlid SRIOV

[AMD Public Use]

This is really not a sustainable approach --  add amdgpu_sriov_vf(adev) check for every callback function.

If RLC is not allowed to access from guest, we shall not initialize gfx.rlc.funcs for sriov guest..., while check the function pointer before invoke the function.

I think we really need to think about the approach we are using to support sriov guest. I'm afraid, in current approach, more and more functions will have to add amdgpu_sriov_vf(adev) check....

Regards,
Hawking

-----Original Message-----
From: Khaire, Rohit <Rohit.Khaire@amd.com> 
Sent: Tuesday, September 22, 2020 05:16
To: amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Li, Rong (Zero) <Rong.Li@amd.com>; Min, Frank <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna cichlid SRIOV

[AMD Public Use]

Adding more reviewers to cc.

Rohit

-----Original Message-----
From: Khaire, Rohit <Rohit.Khaire@amd.com> 
Sent: September 3, 2020 5:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Khaire, Rohit <Rohit.Khaire@amd.com>
Subject: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna cichlid SRIOV

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 49 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 64 +++++++++++-------------  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 42 ++++++++--------
 3 files changed, 95 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d502e30f67d9..4bafbd453e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4808,14 +4808,23 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 
 void gfx_v10_0_rlc_stop(struct amdgpu_device *adev)  {
-	u32 tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
+	u32 tmp;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
 	tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
 	WREG32_SOC15(GC, 0, mmRLC_CNTL, tmp);
 }
 
 static void gfx_v10_0_rlc_reset(struct amdgpu_device *adev)  {
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	WREG32_FIELD15(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
 	udelay(50);
 	WREG32_FIELD15(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0); @@ -4846,6 +4855,10 @@ static void gfx_v10_0_rlc_smu_handshake_cntl(struct amdgpu_device *adev,
 
 static void gfx_v10_0_rlc_start(struct amdgpu_device *adev)  {
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* TODO: enable rlc & smu handshake until smu
 	 * and gfxoff feature works as expected */
 	if (!(amdgpu_pp_feature_mask & PP_GFXOFF_MASK)) @@ -4859,6 +4872,10 @@ static void gfx_v10_0_rlc_enable_srm(struct amdgpu_device *adev)  {
 	uint32_t tmp;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* enable Save Restore Machine */
 	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL));
 	tmp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
@@ -4872,6 +4889,10 @@ static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
 	const __le32 *fw_data;
 	unsigned i, fw_size;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (!adev->gfx.rlc_fw)
 		return -EINVAL;
 
@@ -4906,8 +4927,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
-		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
-			gfx_v10_0_rlc_enable_srm(adev);
+		gfx_v10_0_rlc_enable_srm(adev);
 	} else {
 		if (amdgpu_sriov_vf(adev)) {
 			gfx_v10_0_init_csb(adev);
@@ -6990,7 +7010,6 @@ static int gfx_v10_0_hw_fini(void *handle)
 	if (amdgpu_gfx_disable_kcq(adev))
 		DRM_ERROR("KCQ disable failed\n");
 	if (amdgpu_sriov_vf(adev)) {
-		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
@@ -7272,6 +7291,10 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t data, def;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 0 - Disable some blocks' MGCG */
@@ -7339,6 +7362,10 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,  {
 	uint32_t data, def;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Enable 3D CGCG/CGLS */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
 		/* write cmd to clear cgcg/cgls ov */ @@ -7381,6 +7408,10 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t def, data;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -7422,6 +7453,10 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
@@ -7584,6 +7619,12 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
 
+	/* bypass PG and CG on SRIOV VF */
+	if (amdgpu_sriov_vf(adev)) {
+		*flags = 0;
+		return;
+	}
+
 	/* AMD_CG_SUPPORT_GFX_MGCG */
 	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 237a9ff5afa0..44ebb2722c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -152,33 +152,35 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)  {
 	uint64_t value;
 
-	/* Disable AGP. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
-
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
-
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Disable AGP. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
+
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+				adev->gmc.vram_start >> 18);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+				adev->gmc.vram_end >> 18);
+
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
+			+ adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+				(u32)(value >> 12));
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+				(u32)(value >> 44));
+	}
 
 	/* Program "protection fault". */
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-		     (u32)(adev->dummy_page_addr >> 12));
+				 (u32)(adev->dummy_page_addr >> 12));
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-		     (u32)((u64)adev->dummy_page_addr >> 44));
+				 (u32)((u64)adev->dummy_page_addr >> 44));
 
 	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+				   ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 }
 
 
@@ -350,18 +352,6 @@ static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
 
 int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v2_1_init_gart_aperture_regs(adev);
 	gfxhub_v2_1_init_system_aperture_regs(adev);
@@ -394,9 +384,11 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 
-	/* Setup L2 cache */
-	WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Setup L2 cache */
+		WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 2d88278c50bf..99f697e63e3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -211,26 +211,26 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			     adev->gmc.vram_start >> 18);
 		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 			     adev->gmc.vram_end >> 18);
-	}
 
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
-
-	/* Program "protection fault". */
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-		     (u32)(adev->dummy_page_addr >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-		     (u32)((u64)adev->dummy_page_addr >> 44));
-
-	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2);
-	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
-			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+			adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+				(u32)(value >> 12));
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+				(u32)(value >> 44));
+
+		/* Program "protection fault". */
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+				(u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+				(u32)((u64)adev->dummy_page_addr >> 44));
+
+		tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
+					ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+	}
 }
 
 static void mmhub_v2_0_init_tlb_regs(struct amdgpu_device *adev) @@ -656,8 +656,10 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)  {
 	int data, data1;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		*flags = 0;
+		return;
+	}
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C686ade932f02471d005708d85e9b8b2b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637363369437654352&amp;sdata=%2BNvmYXYD%2B2yvFWuJWfqNKYQCcXw0dn5Q5cA0DHU9tlU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
