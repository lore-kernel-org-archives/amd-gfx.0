Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C98CC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 14:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09B220663
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c0jR7Dup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09B220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F806E9EE;
	Tue, 17 Dec 2019 14:11:10 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680066.outbound.protection.outlook.com [40.107.68.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A350A6E9EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 14:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEGo9iW+0Um1rOQv4EVCr0ZGJ51e7UHSyuIcQ24ira+WeMcBv9AF7m6P5sGzTFDjLhVnO8YGuUhZbj4C8wHR/VK0VjKxXCcKbIDJB4pd6EOHEeOQa5Dmgn7AW0+T2uzzuTrLoC3wfIKn0dzLDsmgyI+68Bmu9OMxCAnrP/RtEqzLaDeW2HFIchCYamfAERVzi82Pkg2dtL43Lv4LEAd3ynpPQqXUGp9lfmG0px++iy/t7BUKijIbeM7AGuCIehfcEfJrrB9cmpMDhJGiwUPNCAmfZ43brd6ehDTA2qgl9era9NI0DaTkxP1a59fd2QWTtz3oS4Vzep8HHr2apyNYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiYUKNoPEmzYRgA0ois2Xu2NxYih8icSKGVoIVE9f0M=;
 b=aR9ljVbxSWI/juWa+rULlW6AY2u0qvsHtSx62xk49cXWVkQ2l0p/lCRCETr/HzYdYZUWaWH3iz3uJ/hOwP04WasGB7pYZ6kC18BYFim14JM36cyWw14su6Na3dgAbclahMzHy6Qjv+qxqbSm3e1vnKqekCP7/6uTcyEZ/ZyR5gMKFRgRV/+Ia5HTlCowVqKO1L1Ewny7dDFuylWfIysh03vFvbnl3g8zxJvIZJdndntKiz0mDAaai1RpfVnOoxCc8XaF5tTIu19SxVmTDru8DWK3rEM5mrILZOdog2TqGfe4tGxkAjNqmPbFggmbdrC/kDDXWc3tkZja5Y+krKwmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiYUKNoPEmzYRgA0ois2Xu2NxYih8icSKGVoIVE9f0M=;
 b=c0jR7Dupx6Is8hOAkvVfLgBWY4SK7kQ3+q5FUw+r5g9oe4VB2T0j0VHIjUyTgvFHQgH4noXenmpiuI3sGkC91JHFwheVxymie2b7fijNRaRCnn9/cReD8JFWejjggsofp8/HUN0WfDSmANG37+/B9neM8LQkkQr5tdjPpvns53k=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3351.namprd12.prod.outlook.com (20.178.55.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Tue, 17 Dec 2019 14:11:07 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 14:11:07 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation
Thread-Topic: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation
Thread-Index: AQHVtMyMW9h1v44lYUmnj/Q619A3UKe+XLrg
Date: Tue, 17 Dec 2019 14:11:06 +0000
Message-ID: <BYAPR12MB28061BFCA95C49E7FA245752F1500@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20191217112322.20042-1-tianci.yin@amd.com>
 <20191217112322.20042-2-tianci.yin@amd.com>
In-Reply-To: <20191217112322.20042-2-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-17T14:11:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=db295dec-8b05-452b-b097-000085a6d200;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-17T14:11:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d929a38b-9a3a-4fab-b82d-0000ddad5e1c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [222.65.33.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b0b6b0e-b620-4f13-0e6e-08d782faf59d
x-ms-traffictypediagnostic: BYAPR12MB3351:|BYAPR12MB3351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3351B2DDCEA8781DC63472EDF1500@BYAPR12MB3351.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(13464003)(186003)(45080400002)(6506007)(53546011)(86362001)(52536014)(5660300002)(966005)(4326008)(81156014)(8936002)(76116006)(110136005)(54906003)(66446008)(9686003)(66946007)(64756008)(66556008)(66476007)(498600001)(26005)(7696005)(71200400001)(2906002)(55016002)(81166006)(33656002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3351;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /o1F+f2C9TXoFaIgEiyJD1gb70o/kxvW9fPV3G5E/DQ64WtZYPW9JZeZPeHI4SeIuCaZU7PgxPBVzaOxJ/1+B6NpFu2eRynmvS5ie0UDESnTbCaSonWyarU8ZLvtJawtFctubu+ZTe7tSq618lNQlfioMiiwOdpPw1siV4VGRZR/9jANJSPm/G6iKZfPu9wvlL2t3XSrOyBE6OaLXyDNRIhcai4WwTuq4mhiMDtHyTe3xizJJ3tYJdUPtD0Apm3dhcn2RGyvsP4BOWZuAI8QBGDXBtJv0aFkyTmEd79qoysjBo14Iv4T7mPgICOwjXESfPkFY6C3hACqdWwFgDbLGyzbH9dSIvIH7lJz20djWEWgDgQdMbE6w2f1RDRHPU3EK4H0ce+2nTZCSEpzoP1f1epqYKi5tSJSZbkZnlOMPAQtZ5njYhkrek2fgUpeBACgN5pdSeHgXwUPbdmtWZOntRm6onvvhDU8nEsO8uWs/e+z5dB/aSqAKwQI6lYEeiyO4WTdLqTYsGG51oxexrN7ow==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0b6b0e-b620-4f13-0e6e-08d782faf59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 14:11:06.9620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IazY+kZgQdW+u8K4ET6k9qBd7cFWKGWoqrC0VYLkTYZQfNb/1YZWSbL3m1pQnDM0XrArFYYWI3zCUqf6GLc8cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3351
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]




-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tianci Yin
Sent: Tuesday, December 17, 2019 7:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Long, Gang <Gang.Long@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservation

From: "Tianci.Yin" <tianci.yin@amd.com>

IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE) has been reserved, and the p2c buffer is in the range of this TMR, so the p2c buffer reservation is unnecessary.

Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 5f8fd3e3535b..3265487b859f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -202,7 +202,6 @@ struct psp_memory_training_context {
 
 	/*vram offset of the p2c training data*/
 	u64 p2c_train_data_offset;
-	struct amdgpu_bo *p2c_bo;
 
 	/*vram offset of the c2p training data*/
 	u64 c2p_train_data_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ce5cb854bdb9..6f0ad1d1d4d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1681,9 +1681,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
 	ctx->c2p_bo = NULL;
 
-	amdgpu_bo_free_kernel(&ctx->p2c_bo, NULL, NULL);
-	ctx->p2c_bo = NULL;
-
 	return 0;
 }
 
@@ -1718,17 +1715,6 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
 		  ctx->p2c_train_data_offset,
 		  ctx->c2p_train_data_offset);
 
-	ret = amdgpu_bo_create_kernel_at(adev,
-					 ctx->p2c_train_data_offset,
-					 ctx->train_data_size,
-					 AMDGPU_GEM_DOMAIN_VRAM,
-					 &ctx->p2c_bo,
-					 NULL);
-	if (ret) {
-		DRM_ERROR("alloc p2c_bo failed(%d)!\n", ret);
-		goto Err_out;
-	}
-
 	ret = amdgpu_bo_create_kernel_at(adev,
 					 ctx->c2p_train_data_offset,
 					 ctx->train_data_size,
[Guchun] If we have to remove such buffer reservation, from coding style's perspective, I suggest removing error handler code by "goto" too in amdgpu_ttm_training_reserve_vram_init.
After removing p2c buffer reservation from this function, there is only one buffer reservation case for c2p. So direct error handle and return should be better.

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C888c561716c342aa9ecc08d782e397d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637121786693411170&amp;sdata=pH1rob4R5ljvEGo8PSjn1te7ctWLG1Wctv30lNCLyx4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
