Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55836C32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 11:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBA12072A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 11:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0WtFBoMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBA12072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BE46E3F0;
	Thu,  9 Jan 2020 11:44:41 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680052.outbound.protection.outlook.com [40.107.68.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF20A6E3F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 11:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEJY2smEm4P9Q++xuRcCL0rBuoetQPiP4OEos0pk6cgs1NmrWVEYyW3/yIyegkdek9SA/iTW4mVLhjZzNz6pB2fQuHTmvs1kG7Cw9i9Vq98uaiQnwrJ67QoHzeOAp0D5Rd9Te2AKNWL7gsLq584VRUk1A6cDreGjMo4XGP9Xd3ZRFZGubv1M1/zb+rNOO/JCwB4lUk/8EIBKFaFNRwcv/U4jfUab+7npcrg+pQCZ8F5ZJARjyYnSDBsqV9Bkiv0ZH2rRW1WDCLCbuJ0IKXbe8X9XS72gsZmkscgWT51Q7UmzwU+jnx5YGVdyc6Q2ig+Zi4O9s/QAkmnEs7bzV8BAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JX7DWOJQkjHkBEff0jZBYRMxDbKrLJPhIqy7iQq3R8=;
 b=C0VWq6VqowhTy0lBENeXVVEpzFVKQT+mKOD3YPwLmkCdi50mdBjCFTnEv9SN6CZaxJ/sPDdScyCVuDZk4Oqi1pDvowm0g5V044t1zgPkRh2FGqQFio3rKU3+/KV35tMWoocpKjuiGZL/EeNh6swI9uw5hy/8/bKL/+skc3tTPTnm0x3yN1bXkabPW9PY3sWj96/hsTfLv8u5LUNST+iR3R3hr1wSIqBsLzP9l1iOZxp6DkIG0AfHja2MkGTMdwg3mGZM/vC/2CCKdgziUe13HtWZfHpOgsFoKS7ibnocyKxoxlUPB3MZgNuDgBlmk73bVfEEs+IbRRmJI/PUlTdBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JX7DWOJQkjHkBEff0jZBYRMxDbKrLJPhIqy7iQq3R8=;
 b=0WtFBoMmBYcV7y/1w5vnYZypplqRmmcgbxuPPuwmUo2OSoe8CU0hwsKdQmrQcb46gLzYLumJ5W/5ebyhppeCl8KmLrk73KlHqpvME1k6yf8WOCBiypQ4nWtfLvmbXu333OBkTxr2+jYOuRCSfYdzI5OnKigXaJeT96GmV0N8FJI=
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB4176.namprd12.prod.outlook.com (52.135.49.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 11:44:37 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::dc02:3d41:a510:98f6]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::dc02:3d41:a510:98f6%6]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 11:44:37 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check sdma ras funcs pointer before accessing
Thread-Topic: [PATCH] drm/amdgpu: check sdma ras funcs pointer before accessing
Thread-Index: AQHVxuHe3gys+HofCEGpOFZyFe/txqfiNnQQ
Date: Thu, 9 Jan 2020 11:44:37 +0000
Message-ID: <MN2PR12MB42850182990697D135E4DE61F6390@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <20200109114213.5537-1-Hawking.Zhang@amd.com>
In-Reply-To: <20200109114213.5537-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-09T11:44:33Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=aafc0351-bb5d-4dab-befe-00006d1f9469;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-09T11:44:33Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c4d1ca69-91c7-4e96-a3c2-000083ab70d8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=Le.Ma@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f850229f-6fb4-4cad-9e5b-08d794f94df1
x-ms-traffictypediagnostic: MN2PR12MB4176:|MN2PR12MB4176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4176F9ABEC00C08B6D96B0E1F6390@MN2PR12MB4176.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(13464003)(53546011)(45080400002)(33656002)(186003)(110136005)(26005)(6506007)(71200400001)(8676002)(81166006)(81156014)(316002)(478600001)(966005)(86362001)(9686003)(55016002)(8936002)(7696005)(2906002)(5660300002)(66446008)(66556008)(64756008)(66476007)(76116006)(52536014)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4176;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgE9Dm60ojHSpUpaOxVEdrZpKPJlfKklKOnNsGKt3273bLb2Vnr/QxAFwHy3G2E/zvEx93QmrisoKJcFI5cQLfhV98X7vofM/lAO2p299Y1nYDJtHBfRx0SGhLgeFq7YhH51y1T1u/YJMFx0Bp9uyv25wrVoZYCX+2ypC+YX3BKWV2t/43U9iiYoPNCcYneq3Q/8vmfpqfQ1sHNmqr8tVR1m4f9M9rASaH3hz4etJSa2nDYi1CcJSpqSwxJQjSosugDdgsvHLmjC/QihcZ1pvuQpq+UIZ1XFe4PnP2aGmuBLncFwsYT0rNDRdiWaDk1UR1Sle6dQCDthAs48BIkqPelrL2O5wfYBW7/gArsDLefULFhJTNhMSMeXuL/v02v/8KFWz+O7Q8LNateWTGWtJqwUC7W9imYIIJ/wz090gG8A6TQ0Ob5BUn5HwxINHCsiRvWMxMhg84/QymkajROWGbslbwSzd8hIbT5YYSAD7bvtbLgC6Z9yXc/OtGbPYlWHkBI2QIk8/ulE15ANayd+qgzAf+97imoXbsb0iN2AhJs=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f850229f-6fb4-4cad-9e5b-08d794f94df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 11:44:37.0208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4qI4qHe66BgADHX+1t7tQzNyVCu1whInvBWlnx8JyfK44NLEtzoqY+YkzfIoB0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Le Ma <Le.Ma@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking Zhang
Sent: Thursday, January 9, 2020 7:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: check sdma ras funcs pointer before accessing

sdma ras funcs are not supported by ASIC prior to vega20

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f4107f9b75f3..c4b4caaf56fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1810,7 +1810,10 @@ static int sdma_v4_0_late_init(void *handle)
 			RREG32_SDMA(i, mmSDMA0_EDC_COUNTER);
 	}
 
-	return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+	if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
+		return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+	else
+		return 0;
 }
 
 static int sdma_v4_0_sw_init(void *handle) @@ -1882,7 +1885,8 @@ static int sdma_v4_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	adev->sdma.funcs->ras_fini(adev);
+	if (adev->sdma.funcs && adev->sdma.funcs->ras_fini)
+		adev->sdma.funcs->ras_fini(adev);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cle.ma%40amd.com%7Cf443faf2f98f4135d8a408d794f8fdd0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141669481128296&amp;sdata=h1x2tb1pAb4ZvU58Xbagq2fIfbnIvl%2FTzybbry4gFhk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
