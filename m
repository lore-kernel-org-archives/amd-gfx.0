Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E677BC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 07:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8355920656
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 07:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fd6rPKJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8355920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C0089DE6;
	Mon, 13 Apr 2020 07:55:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1A389DE6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 07:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTLk5nMuJD+5B8dF5EXhhKbWF89cH1flbWo0UQjzc43Xis97G3tZBkOcND3Sq1ATP28Erxq1IAJ6bPEgfhHawOBa7E2Pp2+5eolT3z4WX0MeKRzydbmO29VEiMzk6UYX3k33fthIDqJ1ZarYKv72Mt/8auuG32kyeC4dIoJlIjCWI1TTHcWKQ1Yp08Jv/+0dr1eOb3rE+8NiY0fufOamHMQprFbZ4J5Qr8epcV9BZIWT4tswAkqagKPn3FHPGIFEnFRsiTedAwfSO+/f9IvvWbwxlBJGPDu0732XNiMEk3jFLRg499ZnpX4foISFoibi0glTQePWhPzVDd83zfDwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XavB1Vug+j5SIUqEdNCzWkSJSb3iatn0pZtVP+uGNk=;
 b=gPhl1map4QWuTUA+ThzzDFqp3yvr25ArQW3WR/CEov9L0kOG5APrLkeum0gdqcdc1+CA97rHf3bUH6YpsARb7Ap2/IH+3VwYRsqGROhoMV/CD6v7PdZFTIWSPzblhQAvIroZzbkChZBAHLgZ48g3TiQi6rdT2jLPz+sAcpcNchCK/aWw1j02aaPlfXSiQEV/Hj9y7tsQuF6b0RcRGWpoGf3nTyOhCwg8TW/erkRxkqh7kIMU29n4KouPkh0cLC7TS912HB6Vxofw6bLCaQUSxo9m7GAkRFeaE9tYKuscGExV/gxWLru1i56dEFebdxovqpoPnYffF/zpnjLT46jq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XavB1Vug+j5SIUqEdNCzWkSJSb3iatn0pZtVP+uGNk=;
 b=fd6rPKJ5chc+fB6Ho/GOkH0Jlvp7NTJXHM22VSylHpbSTDkwF/9wXt8huQT51h2rMZ2KH5AaKgW6MGF4f8x2P8e2vCqun5KJGHueT3W0QZj0+jRkkVQAqelbrACqL40Rlp4alK7h1Q50AVd09i6zIbHHMtStiM3w7c6EowqzqL8=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB3968.namprd12.prod.outlook.com (2603:10b6:208:16f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Mon, 13 Apr
 2020 07:55:24 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::286f:9ca8:b189:3c2d]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::286f:9ca8:b189:3c2d%8]) with mapi id 15.20.2900.015; Mon, 13 Apr 2020
 07:55:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: replace DRM prefix with PCI device info for
 GFX RAS
Thread-Topic: [PATCH] drm/amdgpu: replace DRM prefix with PCI device info for
 GFX RAS
Thread-Index: AQHWEV8wtLkh4PNFK0CyaPZF5ADVjah2rvRw
Date: Mon, 13 Apr 2020 07:55:24 +0000
Message-ID: <MN2PR12MB40789166B8087C72C079A626FCDD0@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20200413064540.15902-1-guchun.chen@amd.com>
In-Reply-To: <20200413064540.15902-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-13T07:55:22Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=29d1c41e-4728-436d-b9ad-0000244992a3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-13T07:55:22Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 898e16b7-c0e8-49cf-a4b0-00004c534211
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd325091-5224-4325-1092-08d7df80061a
x-ms-traffictypediagnostic: MN2PR12MB3968:|MN2PR12MB3968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39687364BCD9830D64B55DFEFCDD0@MN2PR12MB3968.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(8676002)(81156014)(110136005)(71200400001)(316002)(6636002)(478600001)(33656002)(2906002)(4326008)(186003)(76116006)(66946007)(9686003)(86362001)(55016002)(66476007)(53546011)(7696005)(66556008)(6506007)(5660300002)(8936002)(26005)(66446008)(52536014)(64756008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KfGGsLYK/O5Bo27FFBOwQECMSvyI3Oj7F4BuxXnscNroG11zuEB1PwgWfwbQYO1qOlDkfKqph0kEaeqLWICDzY16rMtwtPC3tqs9Y1RMeWIKkJf2HntuOYt9nSBdgoqxXrWV+glnaH86ld3IkfGlR99eqXWlBbdUk1OGFOoHy3fLeVuzMc42+vXkSQaqOwh4fZ/ILZ7uZJzBydgy76hqSg1dQMhOtNo1EHVG8BrtbBtbhHnmunBAjFp5JbLDUPHolmCIoRz0igs6ZKlQeA/KX3/RNxfw/Px5CG9x5zF89lii/8Dr0to5sJBc2FKDDGQ3I5vvkEjXgoFiQAUrvBxLVgssvujFQOusve51gUnKsyOdNfZoiy0vwoqtrEa8Euq3OqDArsoPS+iWh5TdroocmprMI0nJbDAHqdy3dnBdbY59ItWmmK9LgVkV0/HL7clL
x-ms-exchange-antispam-messagedata: MAFnkw4LJgIn5DIZHfE+N/aEd/ytq8lmq6N8b9x3jHG38BloM5Dbshkohj/Eh4ez1FL9km6G0OWMrv8jFrfV7jSdbUllnWdOUHPZL210bL2fWRmgPbz8aFuxHGtAvsdLV8/OeAoogkTxxvpxSA2t5w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd325091-5224-4325-1092-08d7df80061a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 07:55:24.5233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ido/uEUu0uo4lhUE8awMnA3VTXaZmFmXkh7RbYPNY+PR6MNH+QO66RDAxM6se24vZDdYCSWpK6fFlzD84b037Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3968
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, April 13, 2020 14:46
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>
Cc: Li, Candice <Candice.Li@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: replace DRM prefix with PCI device info for GFX RAS

Prefix RAS message printing in GFX IP with PCI device info, which assists the debug in multiple GPU case.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 +++++++++++++++------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1d18447129b1..84fcf842316d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6397,15 +6397,15 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = REG_GET_FIELD(data, VM_L2_MEM_ECC_CNT, SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
-				 vml2_mems[i], sec_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"SEC %d\n", i, vml2_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = REG_GET_FIELD(data, VM_L2_MEM_ECC_CNT, DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
-				 vml2_mems[i], ded_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"DED %d\n", i, vml2_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
 	}
@@ -6417,16 +6417,16 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, VM_L2_WALKER_MEM_ECC_CNT,
 						SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
-				 vml2_walker_mems[i], sec_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"SEC %d\n", i, vml2_walker_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = REG_GET_FIELD(data, VM_L2_WALKER_MEM_ECC_CNT,
 						DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
-				 vml2_walker_mems[i], ded_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"DED %d\n", i, vml2_walker_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
 	}
@@ -6437,8 +6437,9 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = (data & 0x00006000L) >> 0xd;
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
-				 atc_l2_cache_2m_mems[i], sec_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"SEC %d\n", i, atc_l2_cache_2m_mems[i],
+				sec_count);
 			err_data->ce_count += sec_count;
 		}
 	}
@@ -6449,15 +6450,17 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = (data & 0x00006000L) >> 0xd;
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
-				 atc_l2_cache_4k_mems[i], sec_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"SEC %d\n", i, atc_l2_cache_4k_mems[i],
+				sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = (data & 0x00018000L) >> 0xf;
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
-				 atc_l2_cache_4k_mems[i], ded_count);
+			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+				"DED %d\n", i, atc_l2_cache_4k_mems[i],
+				ded_count);
 			err_data->ue_count += ded_count;
 		}
 	}
@@ -6470,7 +6473,8 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_0_ras_error_count(const struct soc15_reg_entry *reg,
+static int gfx_v9_0_ras_error_count(struct amdgpu_device *adev,
+	const struct soc15_reg_entry *reg,
 	uint32_t se_id, uint32_t inst_id, uint32_t value,
 	uint32_t *sec_count, uint32_t *ded_count)  { @@ -6487,7 +6491,8 @@ static int gfx_v9_0_ras_error_count(const struct soc15_reg_entry *reg,
 				gfx_v9_0_ras_fields[i].sec_count_mask) >>
 				gfx_v9_0_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
+			dev_info(adev->dev, "GFX SubBlock %s, "
+				"Instance[%d][%d], SEC %d\n",
 				gfx_v9_0_ras_fields[i].name,
 				se_id, inst_id,
 				sec_cnt);
@@ -6498,7 +6503,8 @@ static int gfx_v9_0_ras_error_count(const struct soc15_reg_entry *reg,
 				gfx_v9_0_ras_fields[i].ded_count_mask) >>
 				gfx_v9_0_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], DED %d\n",
+			dev_info(adev->dev, "GFX SubBlock %s, "
+				"Instance[%d][%d], DED %d\n",
 				gfx_v9_0_ras_fields[i].name,
 				se_id, inst_id,
 				ded_cnt);
@@ -6587,9 +6593,10 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 				reg_value =
 					RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
 				if (reg_value)
-					gfx_v9_0_ras_error_count(&gfx_v9_0_edc_counter_regs[i],
-							j, k, reg_value,
-							&sec_count, &ded_count);
+					gfx_v9_0_ras_error_count(adev,
+						&gfx_v9_0_edc_counter_regs[i],
+						j, k, reg_value,
+						&sec_count, &ded_count);
 			}
 		}
 	}
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
