Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9715C388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 13:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552352223C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 13:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2x97vtgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552352223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F876E328;
	Fri, 13 Nov 2020 13:13:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 566DC6E328
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+HE8osco1Zz2x7FXqL9i+oYmZ8N6hw/RXG6HPRdqtPkrHARlOPj2txw4k26uWcz8uhA+4uMvOtJxsnY5Amb2NmM570dhsSbTvzriZkXlISMiZyzK+v5JT9R01J2NKbyk+ziz2HLwu3+9SvxcOKDZvsAcS4N25nHLbj0NRu3Wazk+vKUVTCv7ObJUfNWrbCN+veda2T5KlGXyhHXN+D7BNrpRF2TREYMqEpNf9CnjYNgHaveGTHy/25vSoVxCysF0ZXz07O1qKTxhslwaC5OkYupQh/A1DyYPJpC89oPL4I6K9DR+WnIa4HuESjV6GaymznamrT6kvIQYFN6dTzhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVxrua1aIO5mU2xgOlxY4t1eTCGl0hDYWoE8rqNxZqs=;
 b=KFNDctWlDAaVfqLtsChQxpNa7xYqT7W8ra2GgribKCceZSVU2tjZSkss9DBC7gVpOWUEKbaKgWnjwf+sKf68+J694gPq8fwNB+6zuhUhdSP8xVJZqV8VYrcUM6pGCSxU0ggMbotBDRtCCbiWRbThnjwg+13KH/Kz885Z7DbIB7g8iI55PTctZd/jrZ6N6CzzMi7LT2WMlxjKAwaDJvFXqs/Wm2aE2cW0DCTlbB6/3a9L7uVJIGIgjr3f5v3iqImbWvBR0in4qh0+HwDx3tcDpDvRy1qcUlJ/Bf14PvtYvQMdC2364yQVMhOkeJsJ+Tz5qsJWtLUCl3NnLs/Q9r8E8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVxrua1aIO5mU2xgOlxY4t1eTCGl0hDYWoE8rqNxZqs=;
 b=2x97vtgS6rGeZCeHx9/mZDgGUntscDIvB8clQZTmA4ZNaW/doqO5UCD0zaze28XihszaktDvMWOACY8Tet62Z6J3E/LtBufX7p4670dsaHiwEHvYYcAjQ/c8zMCwaNyt7n1z22N4xtcl2e429WRNje9NzqXyLjVBMCl7Nnx37Xg=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1656.namprd12.prod.outlook.com (2603:10b6:910:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Fri, 13 Nov
 2020 13:13:36 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 13:13:36 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: declare smuio callback function as static
Thread-Topic: [PATCH] drm/amdgpu: declare smuio callback function as static
Thread-Index: AQHWuZ9QsZIGeymvbEaPwEnAAoP7o6nGCg0g
Date: Fri, 13 Nov 2020 13:13:36 +0000
Message-ID: <CY4PR12MB1287505BCB6DBCE8BF2466CAF1E60@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201113092750.26602-1-Hawking.Zhang@amd.com>
In-Reply-To: <20201113092750.26602-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-13T13:13:29Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=05ede1a6-aa3b-4915-b470-000038a72272;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-13T13:13:33Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b0a73355-1756-4c28-9f69-0000c6777572
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.158.166.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f855dead-07cb-48eb-e950-08d887d5ede3
x-ms-traffictypediagnostic: CY4PR12MB1656:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16566AFAB7ADCD32CA79F934F1E60@CY4PR12MB1656.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1U8iFDyLP7yYGG7dpdfB6xmxe0Ya1O/5t2sY7OcWvBO6f09LmJXhzsNpmkqSOjNVI7vMoGPaY+UVuVP7hGeH8D1OLHv00DwtAyUJXZ7Ho0ilmRiMSyf4xVqX9JMhJOQ3M1CrvurDZ0/CX0iKhgHTBokhmaVwU1slOYvCvwLH/uT9vmp8ZfDPXguPp1lBzVjj2PO6wZKuz7ArikMe2oXWSSrFK1stOS4t9GasvoCQH8mLAqkG3RUYzDuQANmJpWUSS+I2ZebgJ+NfCgDXI3uL0YL9LsABUBR0jpGi/ld0xVQ6j4f45Hh++yFq2Z0vxx9KydfmsKFLO4CuN2fomJMh1s6jmOXqJ31sCCcA4XKtEs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(8676002)(316002)(71200400001)(53546011)(4326008)(8936002)(9686003)(2906002)(83380400001)(66476007)(52536014)(26005)(966005)(86362001)(66946007)(5660300002)(64756008)(66446008)(76116006)(45080400002)(55016002)(186003)(66556008)(33656002)(478600001)(6506007)(7696005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Ub23UnjYUNFO/jzSEq4Ono91/TldnMit7KHxIgJDt7DHRI9QXycJzaNQBCJIE+ysL5SmAu/EpyniIpNFjJp/IFu8aKHvVca0Cq2yTaF3tIjmGbRj26ezfQdJO5rEXiJK4+6xkT7qCpy+YrBqXEkIqTa9D3XwxKBH0aoRQYob85oEdVDbi3K6Z0mWiVNqJt19e9ssyFXJo6QVchNeRQ9ebnlYPrPm7H4xyH7KJtvhXrTz+DNNtj/MJlJid1GZhaY0HZSxPskpmmQ9wbIlIHoN62AQYn0MRv7eIxi9Jz7YB3uCNGCqEvpmphJfLkvcf5vuzI4kVEn3HLIQorzPkOO+/JmBbhpJh2H2uu3J8aflXCaHo5/0cycJLfhls3wTovJbGL+pX9U5+w7nEGUzsL8WoEPkfeX9IRylbrPHIMLTPHLaTcPRSiWKV04JUeVwUDK//Hxbrbwur1MJhC6nM9ZquFAy/qpIfhpfv99z9ayiNHO45/aIKBdxKYA3okcEyw8/6V2W7A9judHwNRy1RZB+nnub0IvTAqzyWyL/xtulGkv9QVprmrtEcqeCYb+V/5QnaTW+nzNYkzwVBCq8jSNcUv8P/z5G/JwAbtSpHNboljihUtTi53Wchi3tdMZELTNunvPxshnefpx3Q5Af8OSQEPTDmicYZ8vGdbRlE7xG9kU4+wRxHxMhSEN/beoP1Q88S3sr7y5dXDrVXIWJamq9fvhhacmG8jJfQJ+PIyJcDutCk1Rgl7bNsVCbRSYj56+BFPcmalj7lVvr3r4VgJSfasQ2byNyBLS15s+f8SIqejjaDP6RTpy7S6+X66K09H671FZubpiueKkfFKqynTND4bYcb3wKROe8NBVC/P6Xj6NDxNxqBro+jZ+opXhGPCmuprHuX4CYhX0gQ7yTTbiHrA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f855dead-07cb-48eb-e950-08d887d5ede3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 13:13:36.1125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oG7+VWCCrN1wEl74PfaTijjNi85nPQei5MDm09eNb2Ot6ABEeSUluXyBXtQSwctkzwbExKV7hofMrzpJi1gO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1656
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking Zhang
Sent: Friday, November 13, 2020 5:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: declare smuio callback function as static

fix -Wmissing-protoypes warning

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c | 4 ++--  drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
index 137b410..e9c474c 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
@@ -35,7 +35,7 @@ static u32 smuio_v11_0_get_rom_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);  }
 
-void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+static void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device 
+*adev, bool enable)
 {
 	u32 def, data;
 
@@ -56,7 +56,7 @@ void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);  }
 
-void smuio_v11_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v11_0_get_clock_gating_state(struct amdgpu_device 
+*adev, u32 *flags)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
index c9c3e30..8417890 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
@@ -35,7 +35,7 @@ static u32 smuio_v9_0_get_rom_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);  }
 
-void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+static void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device 
+*adev, bool enable)
 {
 	u32 def, data;
 
@@ -56,7 +56,7 @@ void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);  }
 
-void smuio_v9_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v9_0_get_clock_gating_state(struct amdgpu_device 
+*adev, u32 *flags)
 {
 	u32 data;
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C40070a1eccff4a9b33f208d887b67228%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637408564958028535%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=LxBVX8XQAcGAq3eccCxbPCNlLojc1fPiKIp9HwI7EPA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
