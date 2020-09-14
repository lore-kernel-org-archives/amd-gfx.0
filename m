Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE0CC43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D41620EDD
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tDVB05z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D41620EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989BD6E3F4;
	Mon, 14 Sep 2020 08:14:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA2D6E3F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 08:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGT3bdOqXDSzlNCQzN1V++xTUSTFjQiU4tfvIsKR9GgxMO8Ybr0sxV82diSOf5l2HUIh59Tc1RdDsMwoL713pqTORjYrM0wxSYNfC2FtXt2THi9tJSzhLWlmRj1Nwuwbgh4bMct36+jDDc8YEiDrx8IPLJn2qdZdRr23fUYJ7i6i6Vrcr53XvUqd/tj8AuuSDupRThrlbeBmB1cIT0TG3+yKTL7DxV4p4KLVuIE1M8Yh0lQxb55asPKqonyCAyqazrWybqDIS/gFhrXfTCaWH/Dx4ZN1mCFSPTkpgtnQdlf8z3d+asGvUKId8tXYzXHVwMn9R8KyH+CJQG9QuiMZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5qkEh2DpvP8D6DQRDeyvoYb55UexyKOAK9iTAuuZsc=;
 b=Ya+b9XlafXyyxZxxuk1VCIVPklAvpRRB8rUC8lMksNzYVeSkhw5Ry6hKPwjprzpRrokUFpTjBF3prt5Et3v5bRK1t9vMCV7SMpd10Vga51qg3P4mtoyhBYKa1CfjwBPMbbimDHOo5adO8cJ6+NRCO3E5HQbodW9lVbeN8SroTlbjzy0vbrCspgmHMwHqnx4Ysjf0IHPv71Djwol+RAX3FdLmGgraewaK0AuVQUKMbYhWcM5mVj1fkjf49cJ1Ka3vg0b9UTQCGUBxbbMvvxun8K3wUKTve7ebXpkLs7FHYc95S/A8dLtrXPouI0G6YvJCf17TQzw2yHNFJMVBqcHJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5qkEh2DpvP8D6DQRDeyvoYb55UexyKOAK9iTAuuZsc=;
 b=tDVB05z3gXLecCNdrOLxzXQ7hpkpTwrGKHp0bGj8svFjiecthputJT2Z2LTdf1VHM6M7EWWGhCX5Wd19XjzGrYe9Ki530vGaStVRF7BaK9XZcuFoEjtIMfv+eyo8gE+ewliFsYMfHGRIcoJFFlBESNAHivOoN8HHue4/ZuelQ94=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1879.namprd12.prod.outlook.com (2603:10b6:903:125::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 08:14:27 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 08:14:27 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: support runtime pptable update for
 sienna_cichlid etc.
Thread-Topic: [PATCH] drm/amd/pm: support runtime pptable update for
 sienna_cichlid etc.
Thread-Index: AQHWim6ANvDLrzHa/0OGcSUrFUV8A6lnyNhw
Date: Mon, 14 Sep 2020 08:14:27 +0000
Message-ID: <CY4PR12MB128709986C0308A88D466D15F1230@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200914081001.3932-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200914081001.3932-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-14T08:12:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1cebe0ba-846f-4a19-96d5-0000c143c1bf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-14T08:14:25Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6ea582ef-36e5-4093-ab15-0000909e8cf0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 531f6fbd-9876-4a11-e88e-08d85886331f
x-ms-traffictypediagnostic: CY4PR12MB1879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB187941D1AADBCDEC70094908F1230@CY4PR12MB1879.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBN74J+3EJFG0vcePXSx+4v4Cu7DBkBTX+Xhzq4TevT+Pdh3XODw7hfhcs6ewo+Zr8NwCundxl6+2eI/qJyfkQE90Aoe4kfoWBq3QACFjBW18HPjOjiL+sFfRRvRxZbW3x+n14TdSyip5/B7v5HrwipUl+LhEReaQiAozbRDPQRXeN1F3bVELaVBVqIPZ/IefmriiR+9GaAsoA0jBF1jKAZHxaHmKAOsduU3e7++G5zGvEWF8FBu2K0M09bm2+3bpZ+HTPLH/AgAhs3r4eXGg2ZH06ooQmg0i8e17dXaD3wH+teMwISOeLLIMMQBqwIblALESK3FCPeVusnzpG+ePVP4F52U1UY53EuHWUJyoq4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(66446008)(64756008)(66476007)(7696005)(76116006)(8936002)(33656002)(71200400001)(26005)(186003)(83380400001)(4326008)(316002)(52536014)(66946007)(15650500001)(8676002)(53546011)(6506007)(66556008)(86362001)(110136005)(54906003)(45080400002)(5660300002)(966005)(2906002)(55016002)(478600001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LD2tEqzaA5i10Yf68Gvg2chHmLhxiue8zscG7BGCSdR6Yr0ArnqUVAiPQj5VfQT7/xV04K3YGxSuMquux8hzlKLCT5PXlm8tkXmLOGffItui65VNEaBeaVaxLIC3mHwIyrGQW5ab00z8WN5sTi1XyDj+qv9OVbBhQ1zQieiiPaP7hQnhhka5PJ0Otz9eagbcoag/jL5I0fuveyTtDvYJ5yIHEQ5ftxJEigHQPivcm633xVNiHKWf1NhZPauCyX8IIAtc3Wb9W4Vlqw+8CkKVpOk2FGbK5BPXWBxzaH76f2CKcuIMtvFoNADurlDp6E8bFQMBD5GwK/OC8LRWLwRCyRZ2FCkZoyx71E9IhzgbNNf/cQQfxSMM+YmX/7L9j4x4kozrd6MB51vpouCmNTpVB1za9I1A63HMCB2Aan3Jyu1+EYjR/xEjsp5MAl3SqKtMuuuaH7rY4iqbxScYrEPzQ2pnnKpUGiNngunzXLbuwqnRa8mnuJcipuAdaS0OevEOHxCmEyzgDQIFs+CwcsZUksEg7lto7xDjoLqaLXagLMtGi9Y4iKMYxbS7HlDbEcyeEBy9aSLyOJXd8IVmsQLyjcCnojOv76pH0iaCsYfT3K91CCaXeC6eOfgd8QHRSJlnM/aPnUEZrdyA4yzhwc4TpA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531f6fbd-9876-4a11-e88e-08d85886331f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 08:14:27.7297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXXAm0bXlplcZKTQlmThmEiVRTKIbzmVk+WAJ9LCsyqy+QqV6Pc3XAEfT0JN/wxoOcA0ngcmKaaNi3mssg8Rxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1879
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

ret = smu_late_init(adev);
+	if (ret)
+		return ret;

One counter leak happens? It needs to call amdgpu_gfx_off_ctrl(smu->adev, true) before returning?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiansong Chen
Sent: Monday, September 14, 2020 4:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: support runtime pptable update for sienna_cichlid etc.

This avoids smu issue when enabling runtime pptable update for sienna_cichlid and so on. Runtime pptable udpate is needed for test and debug purpose.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I70b704ab4d6efd169f579c392e5dbc2737dc1fb2
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7a55ece1f124..7618f9972b8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1129,7 +1129,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_NAVI12))
+	    (adev->asic_type <= CHIP_NAVY_FLOUNDER))
 		return 0;
 
 	/*
@@ -1214,7 +1214,9 @@ static int smu_hw_fini(void *handle)  int smu_reset(struct smu_context *smu)  {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
+	int ret;
+
+	amdgpu_gfx_off_ctrl(smu->adev, false);
 
 	ret = smu_hw_fini(adev);
 	if (ret)
@@ -1225,8 +1227,12 @@ int smu_reset(struct smu_context *smu)
 		return ret;
 
 	ret = smu_late_init(adev);
+	if (ret)
+		return ret;
 
-	return ret;
+	amdgpu_gfx_off_ctrl(smu->adev, true);
+
+	return 0;
 }
 
 static int smu_suspend(void *handle)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7Cd73dd73ccf3c444c710508d858859f53%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637356678262125090&amp;sdata=p0sqrDLhD4vaNesLHIq6Jfd57sAeu8wHDH69bDwTAvA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
