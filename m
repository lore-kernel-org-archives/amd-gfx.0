Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662C0C433E5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A2220825
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MDpE4YyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A2220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E280E6E2D1;
	Thu, 23 Jul 2020 03:44:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABFA6E2D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 03:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBXRExMwGdiY5gDYMLQQbpiiTQkVkO1UUhhd+Y04NmzMAliQrD/PKB9YXZ3L+XKkj0Gl4d05/K1o62oMQFcv/4B+cVdrBVENgUsFwskMYDhvu5TDyoEgJ/UWhPNsSTEE9/nn2qPFl84cUVFcEcHami+a2qqneqYRaQ5DNzkn1whnh/QBoJRvx6Y1DqJXMA72okBz4bC0lbqKHEOZW9aiDq06zi3Xz6BIGd27JU7E5NSdmPeHY5F7hxB9UJrTvN8u45ZMXFaMvjWaWPMKN9osJaauQp2gYA12VZXykN4FRIZ/cK7lUIwRMMzZEmu1vfkjgWEbU6Dp7ms4X8QkvAObog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ9pG8GSdOZI2BOkhyMFULKwOsTSsx/g3Nnt+QEBHAU=;
 b=GAxqkUrTIIEehV+adaE6U8XeAs/61tB284c3nIs7pSl0RyXWhR0e9CGVnH1SSPYfy9TKo9LeNQCwmWr7s6XC3SarPp6wnun0ZOY9CE/5MB50DdW8PxuXhkIfrc6BMrFrA0OyO41HH4S0/J5b3+cJWQxX+OwS8r9Gs7J9kYueUaIrctd1aVN+z0Tz4ytqkVPf8zZZVmu4H9QzCHFslKzHaOHDhs6cGhx50z7LdPh9kPnDpCAkNGO6Vvdxr6le/sqLCRmOxDSfp2DmKbO+oQbJqPqEBvnC7YidxKpbHiHxDnRf4nBdVvkispLwSvOPtwrpFyou1h58efmp5uXjAYU2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ9pG8GSdOZI2BOkhyMFULKwOsTSsx/g3Nnt+QEBHAU=;
 b=MDpE4YyPYNRmbw73zCYRBNbyPd+Z+FTvdzug1/+u7RhaOus6v7brZzvhPAdB8wu/tE2Yg3PcztB5j/k4Qn7DP55aPElRKYWDQTlnd1aZ9y+/03hKFGKgbbNaLUXUI1HA1SN3NPJgPG4HC8G8O6saTLOH0JffBCSHcToqKEWDVwU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3276.namprd12.prod.outlook.com (2603:10b6:5:15e::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Thu, 23 Jul 2020 03:44:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 03:44:54 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: skip invalid msg when smu set mp1 state
Thread-Topic: [PATCH] drm/amd/powerplay: skip invalid msg when smu set mp1
 state
Thread-Index: AQHWXyhkhFr8BI7mj0iaFjSlhROc+KkUiNUA
Date: Thu, 23 Jul 2020 03:44:53 +0000
Message-ID: <DM6PR12MB2619EA7540CD5837BC02488EE4760@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200721062952.1255025-1-likun.gao@amd.com>
In-Reply-To: <20200721062952.1255025-1-likun.gao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a2614336-0a87-41cf-817b-f82146c311e3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-23T03:44:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb8a02d9-5de9-458e-aa98-08d82ebac2f0
x-ms-traffictypediagnostic: DM6PR12MB3276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32761B8DAFC6D0FE7D8EAD8EE4760@DM6PR12MB3276.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ceigAtQlsvegwUZovo6Df4O44Qc5PKxqBgeFJoUgTmX4an7ZqbkYMte/DjNiEUUIll04pAzHLWPuTsYoP/bbU15EdntNsf0Qj+shmUMZGufB/j62gezhMb1qYZYbNkK4RTx0OXmr08ZginaO7CHBocZjIGnW32Auurb6lL5QXgPxAH6ct3l9E9Cke05e1zM1sANJRGazs5+6n1pX2lQYPYLivmstUAPBSsScLGBpMYXLP04vIg9mMF5ZKUg6E7VE3IlYQpXr+cDSZrkeqH5ycsltADE1XaQupITw98rxoRJej7X+V5LS37Zkad/J3ttNgmc7jlmUXBXidJ2TKOhrKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(66946007)(76116006)(33656002)(8936002)(186003)(55016002)(26005)(9686003)(5660300002)(8676002)(71200400001)(6506007)(53546011)(86362001)(66556008)(52536014)(110136005)(7696005)(316002)(478600001)(2906002)(54906003)(66476007)(64756008)(83380400001)(66446008)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9YsP4YNa8+BWxtzYS+ovzIZeDYE5yvpOPtb9M52AD7WFsmCAAZeJ8H9FKuvB3AqtxI+bQhneNuhpTXvXW34VYjaGlRXP/8D84stO7QKL/BSIXoKG3HaoyW+b5KZt8o4CWkNKtS6WLqV6PZGXIwofmkbMx4xikrBuUSXg5bXZDfJ7Hc15yaL6rQPZur8dgPlhK97eDXHPlf6Wz3xkJhz4/5M65xEUOj+VapHLYPftsYu0dcYkO9pwXYWlWmQcibU716XVD6uGK7KSds5FVLOhnFMM29d9HqUfNoHPb09gKsNfVpKR4T7r3uziJh6Xz2RqfBVSJh1RXhBn/t0UbmfTjprgKJifP+MhNmPmUtQ1u19G04pTJrfC6agIF5OJEiITK3uuBDY8ZZRbnJJTlPxRpcvBt3UE4BjvNEACSgsnYS+KKURPKX016FjiOxVJ8nJTHarLQpa+aBtBCf47fiAnbaoh6ekgBMZ+7Ctk0XvctvSlMoLKni6C71t2ynZBBPWe
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8a02d9-5de9-458e-aa98-08d82ebac2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 03:44:54.0473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmCKuF3lJ0EiZKE+7FXJSRiR+7ROaUM+MCGb+kA83/W4bPpzK0V0D3gcChPGAEPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3276
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
Cc: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Tuesday, July 21, 2020 2:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip invalid msg when smu set mp1 state

From: Likun Gao <Likun.Gao@amd.com>

Some asic may not support for some message of set mp1 state.
If the return value of smu_send_smc_msg is -EINVAL, that means it failed
to send msg to smc as it can not map an valid message for the ASIC. And
with that case, smu_set_mp1_state should be skipped as those ASIC was in
fact do not support for that.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I31b40b87532a1d7549b26155d4ec8145b5e3f101
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b197dcaed064..237d8ab8b40d 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1590,6 +1590,9 @@ int smu_set_mp1_state(struct smu_context *smu,
 }

 ret = smu_send_smc_msg(smu, msg, NULL);
+/* some asics may not support those messages */
+if (ret == -EINVAL)
+ret = 0;
 if (ret)
 dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
