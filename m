Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDBAC2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA64206E3
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XgpTsHIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA64206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6693B6E060;
	Mon, 23 Nov 2020 17:06:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7306E05D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 17:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSnb2scrpm9K9v4i1XQyHgs+pUHzfLV8umbgwlrXhVmKsUusOGSAbUu1V+ff2RYwfOmKk/MvTHch+Fes7RivQHs+i/jd5jgbqSv0ZPBeT8/CTqSghgz537ig651hx0VEVpFNQtLS+F5Qq3W4lWACJEeaWbcvAd59aEAHFfrOdWnDcb+SfiI1yek34JUvU6z37sBjlqxnShWiXTQ9+bXtOlfFXHnLjSiKzYaFbwGzXOmn3qv8RPEErEL5hFENMFFdoW/Y0uM4o1GTLm6WrW0OGb6l4Y5ImumMC55TvvUaHrPpoYMI2SCdaBSVw/vQNmeAir6NK+8IsO9d3priXszNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBrUauM1BSzHPB0LaRXTKWF8ra6c8eqTUYvf1bPzIZE=;
 b=Ie0UYfEFadAk245XMu71FMVbBjoRpy0ezQLH7ie99QwBV2cku+SiyasDf9hU/PBFfu0GJk1+nPq9FYMiIIY2DkKl/94sylqxKSeKwfs5R7JUskEQTLG6p8ZNsb+2q80kmFb2ZgSgzve6j+l7409L78fLldMVoTVBftMfnRSQaKolxVgKklYD0huZvKmVIWK/fh+/rHqE/TWhN2Gif4tQ+uGEvV0aS/x6rkrQ2E7VJd8hP2nOhD5ztQ053mSWv7Z8GKHKt2XroDRUu/gZd3eqKwjyBbjlnFdv7IYuhffCYrM8Gii5Yph02Tx5yFdnKsywbxKyQJsgh5Gt3fszBAm9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBrUauM1BSzHPB0LaRXTKWF8ra6c8eqTUYvf1bPzIZE=;
 b=XgpTsHIXiH3QGsaDZMou30hIq5YERbldbrwT4ts2mraQOqIL3DVZutY58GhCzyHxUHdm/ueBPLfwFjq5etfR8mC/f2DnWE+Uj/3dzc1QMl5Ev1NUfjwQFenntaFtgpxYiVBpOOGG6qy+8aOvWFRcmHenVTTNf192cYT57bkSe5E=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Mon, 23 Nov 2020 17:06:25 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 17:06:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf
Thread-Topic: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf
Thread-Index: AQHWwbeMAlqkQAe1OkCk1/CCwlnCIKnV8k3A
Date: Mon, 23 Nov 2020 17:06:25 +0000
Message-ID: <DM6PR12MB407587212AA49546EA547529FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201123164048.19583-1-shaoyun.liu@amd.com>
In-Reply-To: <20201123164048.19583-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-23T17:06:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cdd21af4-5714-42c2-b3e7-0000b12fd42d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-23T17:06:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3aae3eb0-364c-41ef-af78-00004f6ffad8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-23T17:06:23Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e56a8f64-deec-4593-b348-00004daf632a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3024d46b-f158-48d3-51d2-08d88fd21c72
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2358A400F09CA9D10DDA25CCFCFC0@DM5PR12MB2358.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3w5VVNKq+UkpgHpSvM1dn0koKA87NMBjvy8hoLs5r4LYCWCupnSh/4a7NWpt20vzp/7HvmtwT8/t37kaGYJxZz6nClrrWHDTxMfNIdHF93YnAJgABYjwE8S5X6sFttfWCVBieFZ2EKjzKzeEszsz1FZtFO6xkrKnDsApxiN3hQzddFBknBSR+KwRugXD+rzrQr1L6i1CNrYgpWBMKHsQAEjnSFtw65078PLMqCA2XMSzZR/znuApaF2YW8nEADL3TJvlcNqo9KOPoTAqUUvJAcQ7mPnkNd0ABLg4jhG2afLM7cG8NVBWIzKYebReLq7YEINN6viUCqlXBcx2NVwVyXIozt3tYLrWJWURDx1Z2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(55016002)(83380400001)(9686003)(478600001)(8936002)(110136005)(316002)(33656002)(5660300002)(76116006)(71200400001)(2906002)(4326008)(966005)(26005)(186003)(8676002)(66556008)(45080400002)(66946007)(66446008)(64756008)(66476007)(86362001)(53546011)(52536014)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YjxodXlViewVhf6DG8kYAKcXvvDnHb6uB7PlVECJ3vCW9TjuuY06IH+EoxQdPfktZlifYCqwyB1JWb8cqtlJvqZKxRKUZpPudD9t2JFPtBEak3SJvSQpvCn9JEO7oEbHlqmUVnQX0FrMp2dieGM6i2w3nC/w0smO5KqVTJeAsY9aMmzFA9ynLqJPTaF7zUjWu43avVZbvOxlUjD+noo1K4MxepVjFAPcUnBtIKHRtkTosbdYOsOpY3JokLI9gcKUQwZcRTj6eDytZWrGbgmEVQ78uR590RCVnVtpZIGCk2DjQGQsW7np6fmHu13qucBrWB35Tx2MjlmEwtgldjo8TCc5tZh3TWb/P+f3gE1QAMBxTgwmqe9wGQQiPJYAW3Owag0n8PYJoNiXMFagRp3eBCQ1FKV4hz7vf0tFtTtNst1mtQChefn27qSkAwyblnAHGffyPlSERz2pF9kKu1cNDtKX/voDtg0N86gNb0edAuxqk9+jmkLqPNnrJftJ3DBLigSyeN7kydD1tfxhWicKOiIooHG5ICCd88BB9M3VBP1+Bm8DRnUqpwxe6W8sioiYnZeEL3amAN0YmgYfXPASrhDrs5gXqImLucNyvhKCy0RWa9gUr582KMFMnCBGMyTwSAn+RrjW1Fw6dG7xT4wPUcf+Sr42Q75Fw8ejMdLGtp2RXpvjzzIsherQ+UMhEvGYD97R3EDX5x12HRhhzC0wJ7D1JHn6zI2Q+QRKNcQ0EyyKNVS2gYIGeSjqlAIr7HFQJa9ANW6U+uHH9TSCNGgmPpunVEuCdS42/9kdwSwYRiqXXDa1ZDCkU4uHQwiezMvwxvMJblsUaHlNn10KUsd3c3+e7cgFa2qlP9l8YnODlRFPKREMDirWF52CyJf2TJjOFoE4VI2hssXGnXzZ9aWO1Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3024d46b-f158-48d3-51d2-08d88fd21c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 17:06:25.5087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yspQo36XoMvFbPQeaLXqPtc9fE5LyOHBn3jW+QHsJr0HmPm+fHMJ8g3tmN4/92mcROgYt3eNdtS+aVvW8HAbyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Tuesday, November 24, 2020 00:41
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf

    This function actually control the vblank on/off. It shouldn't be bypassed for VF. Otherwise all the vblank based feature on VF will not work.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I77c6f57bb0af390b61f0049c12bf425b10d70d91
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index b4d4b76538d2..ffcc64ec6473 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -139,9 +139,6 @@ static void dce_virtual_crtc_dpms(struct drm_crtc *crtc, int mode)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
-	if (amdgpu_sriov_vf(adev))
-		return;
-
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
 		amdgpu_crtc->enabled = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7Cc1c948ca8d4b478f3c5f08d88fceab9b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417465126174440%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VlFBXGWwjYN49ufyahlQrS%2Fnm%2FFojwp%2Fp7S8DRpB2kk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
