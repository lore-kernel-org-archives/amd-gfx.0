Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35517C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 11:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6ACB206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 11:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ngsUXQ1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6ACB206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596656E16D;
	Tue, 28 Jul 2020 11:51:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8D26E16D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 11:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+veXqvWJgt46qxttpdcQWnPccrWrzk24+DPk/GIsKY4n+/EKNFR4mneJ9Pu8bU+qe7gGc6jiD06iNC5qmkMWNhDcGB27yV0laN9w+IOhJstXnLOE84pGY0mIXMrQ9VD0LkkyBh03XW25+BaaSrtsdGfVHtDbCaXuA+d6BY/Souti3Y8wBJX+Yt3HqRVN/hFt3c1PJ1taFYsYNbxL1dDrQHejHK9RKzNq/JMAtS16UWBE8hTmXbFXmVZIVWiLa1/RXW1yLVKYoJ5FolP1OYS2LJW/VhEZ5FUEhhZpBmKXBbVXz332KUJbo6j8Zl8p7rdwmMp/ulO3Qu3a9smMQyF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ8JMvhrRO4apE5xPsZLg/MVM9WuIbLRqVA7gRiTNx4=;
 b=iGA4I6ZGLOI9EM7c9f2PpYlJnZhVa6owuVpuoW2XZCvJxSUPS3eEy4aCnZtMP7bNR7sJVmlCK1UY+pb9o1MHYVOoqVbdklpnLFnT1eJcSFYB5/SFUzSKTLl0CLdQg2rhqOWIKDSQc/sYvKe0QN/wS6ho0Qi3OY7T+UzqyjEF77TlR2WJoV4ycWmKI5i5LCM/y2YDEsm4APItsQ7BoKDpPkfBIvcDvmwDdGChZB+CawRf7eeADrkgn1Zc2NSBt5poP2gNUrJrCnhlybiQ99AApDIQln8xCs+uWPbaxAfiqQbsYQGUHyGjs15TaQ2j7BgWtgC/vRIiKmce4sn9Osrazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ8JMvhrRO4apE5xPsZLg/MVM9WuIbLRqVA7gRiTNx4=;
 b=ngsUXQ1KS51LrNdn9wO0M7EORBVufFjfEdpN1Bl47tf2XzhSCPVqdvcWs92wpH0zYbvAOjOOsNMjOslCAi2Ny0bepUySkXCaFdL3f/TuY0z+fAhiFMvO1ZxaAKjCGTU3VivE79R2J/KBAEQI1HJcu5o2ceALOiEGcMtw4YktDfY=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB3805.namprd12.prod.outlook.com (2603:10b6:208:15a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 11:51:32 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045%9]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 11:51:32 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: update driver if version for
 navy_flounder
Thread-Topic: [PATCH] drm/amd/powerplay: update driver if version for
 navy_flounder
Thread-Index: AQHWZNE80kW9zZGxLUyHOpuycs7az6kdZ1iA
Date: Tue, 28 Jul 2020 11:51:31 +0000
Message-ID: <FF8B4509-369E-40DE-A1DE-9A1D839788DC@amd.com>
References: <20200728112113.1883-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200728112113.1883-1-Jiansong.Chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9b98e8b8-6092-444d-8b50-00006a3e5d1d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-28T11:50:42Z; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.88.135.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62396b37-a602-4ee5-0980-08d832ec9275
x-ms-traffictypediagnostic: MN2PR12MB3805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB380510D28F697F642CF81FE98E730@MN2PR12MB3805.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEvtAVPFyYotaqJQMOwKJWpEg51fdgYpsTVDZ8b+qete8NXAlf94dff/ifn0DVGBmVtLS/yUkAJVnEbSzwtk/TBsSazf4ocxs5KCJOjRPqDEpGGzoRhXRTSOwYrJAKy6H/aKMfqCSAFvnfcLjlWxSacXmZcjHxN/i3Tr0f0H9JRNlAAmLwVvpuDLUkkXJtxocf+eIjvKSbCfcCdig0HCT1s2+dGuzSttmdHJzOfCpToRhnCfwUL9/wAdMx3KmL1y8Ec84o9CvfrAvV8Zxj4Zw08vfbzmFif3SZrqw7W0enuWQ2zvtVBYshQjUH1tn3HClXAi4SUmocLMY7h6aJeDSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(6486002)(36756003)(186003)(83380400001)(478600001)(33656002)(2616005)(6506007)(2906002)(4744005)(86362001)(71200400001)(6512007)(66446008)(64756008)(66556008)(66476007)(76116006)(91956017)(8936002)(8676002)(316002)(110136005)(4326008)(5660300002)(26005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: La5R4JeErTLUzYjiVemz8kXU/Nva5U3LkLnFP/rxz70QA3MtP8KTQKBt7T2Yw0YIC/yuFfcvVk09SqGHJWtBkmuqns/1ICbkn0BI9/Ic4DxqmzyJ+JIZllKVXsd8UPwQK7EkYjoj+mSEcxzNxXWp4zZoIZzaH4t/xdfSYxwMSvNNMyD+oivbMWFFDAPvJ5ACGv7kZzcnAHExbLWPPYbqEwFbFl1mZwuiw2Gc6VXsxJxGUPUai312fCrWoSodGY7U4z4nCM9D7Xt+wsnkolu59cx9RaIIcrPeRsDatLn2+XKlsbHI6zbS5F65Qbn18XnEP0y96to/Ig1Rs3Pd1Wxx/Z8q6Xkth/TfrPsAvYAS/9TQ9Tbnw1Y9ZKQ0sbNeGSaCLhCzDc5uHtVYoPYdTdPsXvnzIEykTjiLi1kGeMylDBQ+VlsBebw+/LuAplTud6vbe3vFETJER4nztwVvZFwQ4ujJdeLEVtvoKG8C1r4BsAvYn+Z02K12oFwHT2M16xLF
Content-ID: <96D40B6E0793FD49A6FD632859A6ED5F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62396b37-a602-4ee5-0980-08d832ec9275
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 11:51:32.2066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmT5PY2qVnlty2FBW66977Bfrp4dB5lbV30k8soMlnSLV33WO1Y/p5RCnu+ie0vE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4NCg0KDQrvu7/l
nKggMjAyMC83LzI4IOS4i+WNiDc6MjHvvIzigJxKaWFuc29uZyBDaGVu4oCdPEppYW5zb25nLkNo
ZW5AYW1kLmNvbT4g5YaZ5YWlOg0KDQogICAgSXQncyBpbiBhY2NvcmRhbmNlIHdpdGggcG1mdyA2
NS41LjAgZm9yIG5hdnlfZmxvdW5kZXIuDQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBKaWFuc29uZyBD
aGVuIDxKaWFuc29uZy5DaGVuQGFtZC5jb20+DQogICAgQ2hhbmdlLUlkOiBJOTg0YTExNDcwMzAy
NjRhZGJjMDIyMzBlMmUxZGQ0MTZkNGFkNjNiMA0KICAgIC0tLQ0KICAgICBkcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmggfCAyICstDQogICAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQogICAgZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjExXzAuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjExXzAuaA0KICAgIGluZGV4IDk1MDRmOTk1NGZk
My4uNmE0MjMzMWFiYThhIDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9zbXVfdjExXzAuaA0KICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9zbXVfdjExXzAuaA0KICAgIEBAIC0zMSw3ICszMSw3IEBADQogICAgICNkZWZp
bmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fTlYxMiAweDMzDQogICAgICNkZWZpbmUgU01VMTFf
RFJJVkVSX0lGX1ZFUlNJT05fTlYxNCAweDM2DQogICAgICNkZWZpbmUgU01VMTFfRFJJVkVSX0lG
X1ZFUlNJT05fU2llbm5hX0NpY2hsaWQgMHgzNA0KICAgIC0jZGVmaW5lIFNNVTExX0RSSVZFUl9J
Rl9WRVJTSU9OX05hdnlfRmxvdW5kZXIgMHgyDQogICAgKyNkZWZpbmUgU01VMTFfRFJJVkVSX0lG
X1ZFUlNJT05fTmF2eV9GbG91bmRlciAweDMNCg0KICAgICAvKiBNUCBBcGVydHVyZXMgKi8NCiAg
ICAgI2RlZmluZSBNUDBfUHVibGljMHgwMzgwMDAwMA0KICAgIC0tDQogICAgMi4xNy4xDQoNCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
