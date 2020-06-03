Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A602C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 02:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175C220738
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 02:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EQNkwLXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175C220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913376E4AE;
	Wed,  3 Jun 2020 02:25:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D266E4AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 02:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikbib0lPwS8k1juIj581ZeqF9GzpNsCFcCUSkGhiR6grQdAEdz3S6uQiFm65uzjrHaJPXomliJ4/iJxy4V2fuoduw1MSS5hH0sIjCJA4pPJGtiPcLf9xem1++Sn6dlT2CGAA9KSYI8baXtL/syLmggTRIdW4HRhfeBQd4L98+wkhQUkFp1bn1++fMc2FVEW3Vh3zdayFooruLZ5KDXqvqB4EOAfVOvaROMhA+1xA6yE5LmHW1olyAUNsgn9CHqDXAxFqJHpoJAf8LGff7oKwNl1YXdtuTgJUynHplSMFEPaiGwpLsjCRd2kLXap3Q2PjFBtgxPlygoaUDQ6LiLun8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax6lvPsm+cxxKiMq2PU6ljz9SNIG6iHJ/n2ADu9CnIw=;
 b=GIOdPMYgTn6kK6bhj7UgNIXyhFm49LVIJh/1xm32QcM0OXtn+nT0cGJZMGoLwOq01LWipwiccoAmg1GUzSKfcCUT0k3oR77GFxKrdTGW0sMmr9RDcFMIAA2J9gUmPDtvdMUvnO2jljuiAyXmRrCz4WaRQ/ZKvqFAkNtbR4ZSsstQXLKKGrLRaJeqE2WpcBiqrlPQ0DEtoVyn7m0iYuGI2a/ll07kLfyIgJ/qcJj/fY2/334IqVvKbkDkebgltpaNrQuG8um0Z5qiwjNxRvl6AaYyBMZdNhh7OL0Q4YPv/5QQlna7Hiuvv+1yW2jpdTbY29SYEWvdFv6Zc2/8PYYL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax6lvPsm+cxxKiMq2PU6ljz9SNIG6iHJ/n2ADu9CnIw=;
 b=EQNkwLXPNLXpencGW6r3oJfz7bzO3cI8ySEkKIXrApOaXGh2tsVRRote0+sFQGjZq9zRf1SQvrbgscXYeMde0qKWoFnmIjO7PiVfiUgaac7YkMuZMDM8E9Dk0L2NZUhO74Fu0BOFRQBU8qQilC+2acT4Cldu+uZ/RZpmTfSrGtI=
Received: from CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16)
 by CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 02:25:30 +0000
Received: from CY4PR12MB1623.namprd12.prod.outlook.com
 ([fe80::b5e7:768c:e3b6:e96]) by CY4PR12MB1623.namprd12.prod.outlook.com
 ([fe80::b5e7:768c:e3b6:e96%3]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 02:25:30 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: temporarily read bounding box from gpu_info
 fw for navi12
Thread-Topic: [PATCH] drm/amdgpu: temporarily read bounding box from gpu_info
 fw for navi12
Thread-Index: AQHWOUvMRIhDZYNz5UqVuXKRyWiChqjGKd5w
Date: Wed, 3 Jun 2020 02:25:30 +0000
Message-ID: <CY4PR12MB1623F5ED19C00270E7F9C5E4FE880@CY4PR12MB1623.namprd12.prod.outlook.com>
References: <20200603020749.27189-1-tianci.yin@amd.com>
In-Reply-To: <20200603020749.27189-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ac289380-61fe-44f0-8583-0000fc6acf95;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-03T02:25:23Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b34e45d6-5f55-4e01-9545-08d807656307
x-ms-traffictypediagnostic: CY4PR12MB1287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1287FFE832D606EFC3822439FE880@CY4PR12MB1287.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWyH1nxWFRNsTIqVTdYBB8rJ1xPYzCDmJy9QxhH3mo6GzyMUMSWam3h5TyHPzG3qqBL3eabXQ3m1I+brs8AVw+DVOtl6q4XkMeeBTMUrWlUtS2K8D6lgtTEB6mQDf+thvqPTQjiGWOSD1W+xgnNMJcp/8MA2C46Ev6a5JeR4k4r+Q6uNU+mRJBL/LnoBhUiHDrlm0rpz3oZHvvguVCUvga6v7Iq0snsdcxLaH1jbnKo8Spu0VFCSbKOYVPf4RIvfpSq9NLmsAoaz+ZYPna/MAt/K9thuF5uqmVa2b53MJ2bxAU3V3mde0vP0XzfYezNXRBLAnAMiMzSHQ8kEwkibNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(39850400004)(346002)(136003)(6506007)(53546011)(86362001)(26005)(7696005)(4326008)(478600001)(83380400001)(55016002)(33656002)(110136005)(9686003)(54906003)(66946007)(5660300002)(76116006)(8676002)(64756008)(66476007)(66556008)(66446008)(2906002)(186003)(8936002)(71200400001)(316002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: A1o8fmMNHoNRNVlwuJ9HoLXQuJhUxwliP4jTRbag8laP45q5TgZAVwQWNJg5pCHeoQ8d/YLhWf6kuf5DaW4Uq7OxS+kTq28FG9Szxe4zjArGx7HL/x2ZLee7csLxGzfVtIsu/lhBzGy0vjPd2EKEuE0aRzgOIyMtgkuSIlclDVHIuMpXgMnSaD09MxcumEP5CLElQx7rKvm07O3KbSo65+9QwLte1eqHnzuVLbm+szPR3SkQ8uyewSULs4VgXdLofMkj3kijiwu4/Uyf1ikauCSeOG9fLGR1ZoFkGeOROBrH6+4SXeqYwZiDh0lRCTxnIuaWOBGdTNzeQedWQY0NxNAuzpYmijL7uYnLbY1X70AwXG9nbny8n7ap4tIi15a4cfo2O+8tj3kBC1D+1vffdxuGF+JkdE+91i9Kg3Zqy7xJhng4R0n8DAThFA9SQmmR72gbzn9kWFBHfsVpy1NCyLKci3jtt6tJOy8cQyv2O92I9brbzlScfFEGgtMSLhcf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34e45d6-5f55-4e01-9545-08d807656307
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 02:25:30.6248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYg6R2MDYdbTUF4+Iv70tq3RW0a3JV2jiNin+uiLTzobNuavcDm+x7soJn/eShU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1287
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li,
 Pauline" <Pauline.Li@amd.com>, "Yin, Tianci
 \(Rico\)" <Tianci.Yin@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com>
Sent: Wednesday, June 3, 2020 10:08 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amdgpu: temporarily read bounding box from gpu_info fw for navi12

From: "Tianci.Yin" <tianci.yin@amd.com>

The bounding box is still needed by Navi12, temporarily read it from gpu_info firmware. Should be droped when DAL no longer needs it.

Change-Id: Ifc330ec860f9b0665134a81df2fc80ca91c41a33
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 15de344438d2..1df28b7bf22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1537,7 +1537,14 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)

 if (adev->discovery_bin) {
 amdgpu_discovery_get_gfx_info(adev);
-return 0;
+
+/*
+ * FIXME: The bounding box is still needed by Navi12, so
+ * temporarily read it from gpu_info firmware. Should be droped
+ * when DAL no longer needs it.
+ */
+if (adev->asic_type != CHIP_NAVI12)
+return 0;
 }

 switch (adev->asic_type) {
@@ -1627,6 +1634,12 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 (const struct gpu_info_firmware_v1_0 *)(adev->firmware.gpu_info_fw->data +
 le32_to_cpu(hdr->header.ucode_array_offset_bytes));

+/*
+ * Should be droped when DAL no longer needs it.
+ */
+if (adev->asic_type == CHIP_NAVI12)
+goto parse_soc_bounding_box;
+
 adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
 adev->gfx.config.max_cu_per_sh = le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
 adev->gfx.config.max_sh_per_se = le32_to_cpu(gpu_info_fw->gc_num_sh_per_se);
@@ -1655,6 +1668,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 le32_to_cpu(gpu_info_fw->num_packer_per_sc);
 }

+parse_soc_bounding_box:
 /*
  * soc bounding box info is not integrated in disocovery table,
  * we always need to parse it from gpu info firmware if needed.
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
