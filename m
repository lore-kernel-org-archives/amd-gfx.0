Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76239C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 03:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FAE2072D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 03:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PENd2hV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FAE2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C2E6EABF;
	Tue, 27 Oct 2020 03:16:35 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A917C6EABF
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 03:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLwfKn+OV45sBK5H5lI6gcz5sbq9QiSpcMhoyYVatvAMLfnuP2t0AYj9jCnjylfcaArTKUZzhDJTpGaqDxEn6vlPPZ7WwRaDNB8r8IoPRj2IDD5aNPkcoq6joK9gAQsRjA4D0qqJWL/lZ9B/MV5lse1o/QY/PWQV1n6e/8rPWIWACs/yYBESYeCXm7P5fC9+QxuhutKM+Z/YjTOIVWXsVD2jwUC62wrdETjjtgaUEiBMrywkkBLEiuCFqZ261BJm6rVH4KVoPQMAOaczVsIn2Oi0moUi6h4Tc9XAdadKaZJ71b8VRnbNEzvAxkUK6pEYCee8lS0wlg8wFAYAwL3kBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgOiPhihR9EnFARi4e8nS8YMXPY7+uJFlAP9ulmS/0Q=;
 b=B8OdboH4I7jUkIJgSuFtI5ulLUeCzCnHe8l4v897mHfUbOqTUFoluBBZ485cVHlzREYXv1U6GIG5RulaTRqGckCOfUW91/5v06/BzaU/tjR8wcNbz6DVxgd3oInKUmVaGFTlfdKA9EdedcW41blpYXsNmkmCDmDVwhbhgPfeZXfoCC3mRrcRxFnEFiGctDqjXJEnxDQ3uH+jWI75G6bhwS1BSsa2ULx7DN2IYras7ni9QVPXsYjLq1mQnipurKkxbFQWZeFfL30WOnVX+ISD7X1TNsv61gELZCacy1BTN1tUM7FWicOUrNHzKqUH0E5tj7d0SAQpt0h1UeqlybfSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgOiPhihR9EnFARi4e8nS8YMXPY7+uJFlAP9ulmS/0Q=;
 b=PENd2hV1A2TBdJSzSPW8ccao39PH8hVjYckbiGjeunVSpUsxKhAAXHPfigQaf0PAmdOBwQapqrDebY6LJiOW8pI+qvIppbDbzrQ8eNghlwCZ0zyoieoFbtojiaMc16dRyWlWH6hnWNINoVu016+FXP52bMQz4iFk0SbCYB1HJHw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3578.namprd12.prod.outlook.com (2603:10b6:5:3c::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Tue, 27 Oct 2020 03:16:33 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 03:16:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu: drop smu i2c bus on navi1x
Thread-Topic: [PATCH] drm/amdgpu/swsmu: drop smu i2c bus on navi1x
Thread-Index: AQHWq9+58iN08gxCSUGhTeSOjOR15Kmqx16w
Date: Tue, 27 Oct 2020 03:16:33 +0000
Message-ID: <DM6PR12MB2619497A7DCE43C7819ADA87E4160@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201026213347.1680226-1-alexander.deucher@amd.com>
In-Reply-To: <20201026213347.1680226-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bf8f0158-55c8-4630-8517-1d722538e0a9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-27T03:16:29Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9b71a41-dd58-455f-27d1-08d87a26b4af
x-ms-traffictypediagnostic: DM6PR12MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35788325C7EB1BCF241171FAE4160@DM6PR12MB3578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67M0PcDMbzkQLZKJrZq4Kq0m9KwksTrO8Q/NB/IDB117IsjcQy51zumP8E8ra+FpwxmisaVEa5iWTyI7n9twJ++T17LkE5oF/uGQ/i5EkZX0mKn0ugH7RWW9rOiTpkVRFcqRwFBGLAFOC35FlY0ZzlxiyDEksKBMvR/7AWkxT9C16WRH789i5PE0Eg3rfGylV1g/3RqKhgmmKtSl9mXt5d4Hc0cHD4OvVt5LYQhu/19HmqKZYrJCJOYMKQacK9O9kSsV+3IqJ/wi94AQN4//hKWaj0urZvv06P/pPlwS3M07vjd0rr94g/rBgln2azHgK6lg3YSiF84hR7hnayHoM5Jcab+/55wQpVu0AmcQH9vMsIFZ2FYXh+cpSowHrlIWBd7bfWFrPrFJf3+9p+Me5tLdoVjyxAGqKEwJUDHcX4luqXRCpe5oUBLYMyI34rNy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(2906002)(4326008)(8676002)(33656002)(186003)(9686003)(8936002)(71200400001)(316002)(110136005)(83380400001)(966005)(53546011)(7696005)(6506007)(26005)(5660300002)(55016002)(76116006)(52536014)(66946007)(45080400002)(66556008)(64756008)(86362001)(478600001)(66476007)(66446008)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Dn8Tslgmk5AhcFtID2kgBNJLCwv35K1jBVtS9Gh1JQH53CGxB71EOAhWuoN/+HbFOuZvq7GQPGGY+qnAPpMVHe8NMKn5Xz1ffCKl8uiYrVv5EevQpZBc8Be40J6MStxQlVaH3dR0e55wwTGh0PxLrG+AlsXw3nC1OxDmkBIXXE6Dz14IpJ1FDmF5dJcEfML+3wB4PGlA+Gk4rG4b+v10qovSwOpCJSMIBNXLn4+EEfKohqVhBXUH62WKEywE3tVD+L/mECURarSvqbc+2kWt7JWYzo3biVmIn2b15ureiClfJNOs9CIAkninLG3Ck7e1u9aX34NOM/xTE6NNfE6XR3xVZvSffQtx7oG2+OgCVYoGnIETIIweJ6E2ZGoePGkhXPHT8yvaJ4ras+Kc2DWQ9UHlFkB8bYjMp2l0wRqO/rMqblxHiCLZUqh3u58+Zi1PpyNWDaqGJRZw2nYkA/qCLO1GgBnFqh1M71MYvlMn4udGo6UA3xW8tzyiHMtKFcfnHnRx03wrT+Yz0ZnGPP07u0Nw54Qhven3Vc2kQPe3208vfsXoa9+f7LFUNHagyx8L6p9Z2l3YfkSCCVI0U6yP3l+PlabFtzN0qc2o6mV5VWYZtd2TyU3I05qwXUMNwaULGAjSmd6XP0Cg6wCetTFjKA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b71a41-dd58-455f-27d1-08d87a26b4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 03:16:33.1039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QguFm+Ph4csRNY4LwYNUwubOtMacYtIl0NBKA2M5YQFmoZlhbuDx7lDBq70/hUMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, October 27, 2020 5:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu: drop smu i2c bus on navi1x

Stop registering the SMU i2c bus on navi1x.  This leads to instability issues when userspace processes mess with the bus and also seems to cause display stability issues in some cases.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1314&amp;data=04%7C01%7Cevan.quan%40amd.com%7C88fb81ab5bca450f536608d879f6d938%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393448423758226%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WmOflcFg8%2BVk3%2F4Qr8H4wwgNKWgirGBq24aBayHU6%2F4%3D&amp;reserved=0
Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1341&amp;data=04%7C01%7Cevan.quan%40amd.com%7C88fb81ab5bca450f536608d879f6d938%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393448423758226%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8Cx34yYo7MsoewcJMmR5fmtO%2FAlP9jric871bwL5vjA%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 8d8081c6bd38..9cf97744b67e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2534,29 +2534,6 @@ static const struct i2c_algorithm navi10_i2c_algo = {
 .functionality = navi10_i2c_func,
 };

-static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control) -{
-struct amdgpu_device *adev = to_amdgpu_device(control);
-int res;
-
-control->owner = THIS_MODULE;
-control->class = I2C_CLASS_SPD;
-control->dev.parent = &adev->pdev->dev;
-control->algo = &navi10_i2c_algo;
-snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
-
-res = i2c_add_adapter(control);
-if (res)
-DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
-
-return res;
-}
-
-static void navi10_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control) -{
-i2c_del_adapter(control);
-}
-
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
       void **table)
 {
@@ -2687,8 +2664,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 .set_default_dpm_table = navi10_set_default_dpm_table,
 .dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
 .dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
-.i2c_init = navi10_i2c_control_init,
-.i2c_fini = navi10_i2c_control_fini,
 .print_clk_levels = navi10_print_clk_levels,
 .force_clk_levels = navi10_force_clk_levels,
 .populate_umd_state_clk = navi10_populate_umd_state_clk,
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C88fb81ab5bca450f536608d879f6d938%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393448423758226%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=bZIRGI7eSmTxNQ2NXtbzKmqra0vsUvNRSST13iw%2BNNA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
