Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8013C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 03:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5948F20578
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 03:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YQ78KxBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5948F20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187766E3C4;
	Wed, 20 May 2020 03:13:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F076E3C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 03:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWqODLhm5y6IYVZfEjaACv0m01vdJ0YP/QqqeC3VRCxLdUrKLMLygYXR3K0jxbO5yYD+h29w14gYhzR7GA8nwyI98CJXQJDqKZnF1J5LLDNWREmHEB1qHmk2DRdUCZPtH+WRnNrJMAomUiHSna2wXkSYYk85SRoxR/AWnRRF0lfDcqM4bRox+1ITd5t8NApSSK0f9VQ/dS6iQTQsbs+Vb7hgj3puaYYhzIveuj9ZtvJlnLugh+I8/BEkpfKwnn2cYa6C5vCxTeV2B40Qi8YnhJzBe6kzXyhAKNckWxUQHJY7zQ4iDdkBx1Mc1jtbxxjjsrxj7LNVE5/JKMb18FoQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk/3QQ0btVEmt24x6LByzBYcxr9s7DMKCYsgijRoKho=;
 b=mihFvcyn/GxH/WCZHOUF/nDDcULr69ucDShTJlgk8dRRbNQSm+bnmFjtckdHYs3kUEfokPqrDvK9Kr8PmY6R+1bKjqNbB6Au/RzB8u++CMY90yewZWNWezRTyiCbfTH9ykRhi7OTffwYSZGsvMmYhYnldQzgEyXckTLbWD2H33oWJfOzh98/ooVOMpXvjWQ5qUVvw8uQefMPm9JJk/U5S+2GbjdJDdhkNrYPrBtESd03unYkco9Fj2h5jQHHUggeK6Ao8VQGOJYe3zj4n88fYygSO2qQLPms5vRFd/wj4tTno1Y968t6MjSFiiNBVnB1s47/2KYXMqE+SfqdZ/MMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk/3QQ0btVEmt24x6LByzBYcxr9s7DMKCYsgijRoKho=;
 b=YQ78KxBexE3iOwSkFuFz7HX5hrajElsMFZ6Gzdb7K+KCNfIEAV3Wg+B6GTatrX0lWZdTXsveIUUcoCpJQEoa+meowdAB8OycaLp7+aEQEpiwk/3SZ8TU/SHJJ+zDD8ldqHf9UqU6OqGGGE+5OsdNu2svGTR0H41GkmdX2oroCqU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3050.namprd12.prod.outlook.com (2603:10b6:5:11a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25; Wed, 20 May 2020 03:13:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Wed, 20 May 2020
 03:13:32 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add condition to set MP1 state on gpu reset
Thread-Topic: [PATCH] drm/amdgpu: add condition to set MP1 state on gpu reset
Thread-Index: AQHWLQAOsYcbpLZx2EmSOpNj2DUPRKiwTyng
Date: Wed, 20 May 2020 03:13:32 +0000
Message-ID: <DM6PR12MB2619231609F3C5C62A52C5CCE4B60@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200518103504.2176521-1-likun.gao@amd.com>
In-Reply-To: <20200518103504.2176521-1-likun.gao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b931f483-85c4-4007-84db-0000d761eec3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-20T03:13:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5af42fc-f871-4065-6c56-08d7fc6bc6bb
x-ms-traffictypediagnostic: DM6PR12MB3050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB305049CDD1332006CE3E08DDE4B60@DM6PR12MB3050.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qw/fsR9MVBBzEIaRlEPijjxfmmIHi+VQ+iEAewKoeVvLofiD2hG7ajMsPZ3tVag8l665ePF0UZwHY2Wd0KQeAczQj9Ee1EUJb/fO+Hcdj/pcTwsRuVd6sdPYYmHUse8UjXzFJtPfE1rG6Ye8wVWea2lJ7bGzJzU449NLPPU7FfZo7CZXXef/EFhB+rI5KlT9p35h7RiT6tqQIZLoJA3BEBNagVH3OekXA6rC+fAX48blontmLidhTuAyzpsyDH5s1piqEuWan++Gm1E57//dGRnaSrhU98hs6VXJSI9eI2iySYgPVDkMc8XI5LWrUcagi3LGZ0bQJcKT/YKqxNh7J0JlcRnAnhPIQX9gMuoP3Zc773ohrjntsg7YTMKC3ML6xCCuLuSIgnwdxnx/pp/CYG3ZtfI6SqFrWmabcTGc2LqLHAzqfUT1/b5n3X1VaYsp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(71200400001)(7696005)(110136005)(316002)(6506007)(478600001)(53546011)(26005)(33656002)(54906003)(4326008)(186003)(8676002)(66476007)(66556008)(2906002)(5660300002)(8936002)(9686003)(66446008)(52536014)(66946007)(86362001)(64756008)(76116006)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dURH7WEvyOqk3hu5whpFUeN67S/8KqeFBa+vzijv2uw9DJ+GrQFmDbreEuVKw1E5C94gWH2tlYREYdv64w/Rzcdtd/oFW3LbqX5YVxeafT/eortteoy3LLlCY/fOAysJoW02h+h1kytYtV23zXtX3LAJ5+aVz+2ofrZUBjcJ76hxBP//M+QBUa0E2N9E25Y/e/zmsEI5GS6AQyGqNu5gaz+U22kQIgvTl7Ao40593BKYYQriZnY6ducchDCkxRt7p9++lf5G7l5p4+pVaIFuU7LKh0bpKeGmqNls9CpccfgInP435B1CRzzWuBC+t23f0feV9ThV0OAAsnwIYxej0fPGAsZlbUteA0Z1CKW/NkIPDRdwY8DHfggP2MdCCQlvqZ+mqOX30N5jlSxB1+uybYsuiS4/cvJjNZlxzWjZVtrNWoBgHm1luMQF/NxFlt7ij4qzyIzjiUVRKQPm4Ddr5kA6i2+3Lbl63QFypfeMOUCkXG5fe/WEz2/x8U2xumAr
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5af42fc-f871-4065-6c56-08d7fc6bc6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 03:13:32.0767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzFVOZhuUZINy4Ps1QbK8njsphlw6YYS4mDZN3yRCjTNPZwschQLcSJOLkP01ueT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3050
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Monday, May 18, 2020 6:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Clements, John <John.Clements@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: add condition to set MP1 state on gpu reset

From: Likun Gao <Likun.Gao@amd.com>

Only ras supportted need to set MP1 state to prepare for unload before reloading SMU FW.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I9e49b3f13aa613393381fe15b6b060665026078a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 5de5b27bf4c4..a349cf15f90a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1399,12 +1399,13 @@ static int psp_load_smu_fw(struct psp_context *psp)
 struct amdgpu_device* adev = psp->adev;
 struct amdgpu_firmware_info *ucode =
 &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
+struct amdgpu_ras *ras = psp->ras.ras;

 if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 return 0;


-if (adev->in_gpu_reset) {
+if (adev->in_gpu_reset && ras && ras->supported) {
 ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 if (ret) {
 DRM_WARN("Failed to set MP1 state prepare for reload\n");
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
