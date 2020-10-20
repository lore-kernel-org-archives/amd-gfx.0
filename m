Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1836C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 10:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E892222D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 10:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3IHUMKpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E892222D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27DF6EC4A;
	Tue, 20 Oct 2020 10:26:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0D86EC4A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 10:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjAbl7rcVcxXiqWK++pqcmKjbzRS5mYhuvhsxQTtyHZjtBHY1dOMUi8RC80PHHD9m7CqEPIvwIgOs1xDhp4NpPvr/y/tqIPY3U5PMqnGp3DvVBpz9XuiUBDq/1/UAQNtL+5UwvG55SEah+aesbQk++mvKp6X5GqoQCLXUxysiIppWS7rM6f4yWJk34PzdCYfDMCzhtxgbPXbljJwNMBJ587LzRLUAa8fqBya3K5eJN82jgUVWKfZXryw1Z1ipJdzjQuwDW1aHVIIcCtX+6GaCfflykb6iDMAFci7qivOP4Q+4CLmME16Dn4aDgSZeYliwSrOrQgbNrGw6IPO9pfNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqrgJ6g0ZMBxf4/09xODfrRwpb0Qt8nl6fjpXrmwgng=;
 b=Ks2Tfbg6kUd9po89ptJLub/xXKKBkbEsTk+ydfltmNHHIn07wsghrUOqvN2SW4P9dMwdyhkjQbKIGN4Io4tRxQ5ccR3PbZNu6Y5/gocCn/z4WROi4ZmX3xH2h13PgxT0NN0y1mpFfbFDpf5vBBbxaDLdyuCCtLQ7AhyFDLK8KIFIyVSP7KgHColGWtjHJBIGIshCt4W4fynFEvKgqR5v0NzFDMrOepywlHProjCMvU3AwBnL5p0ugPzYmD4OVJEscmpe+pG2rv/oUhd3XZ6y8B+ENQweQqYrayiWau4WPRIRdntynl7BOfSxqzLnQt+P+p9e7igHGRiVfJRICcD8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqrgJ6g0ZMBxf4/09xODfrRwpb0Qt8nl6fjpXrmwgng=;
 b=3IHUMKplrz4BHcEosfUoo/Y3QXNC4/pEUmSQyRrzEsqCcag0uqBIWQ14TCOCcLwrMyEzlimYpA4r0d11FWXiQf/n/uJ/u0wCwaNZ5PxNuzwOEmfAVzmcfSIM99GpPGa+YjeT8ngP4PKs84cqiI+LE8JR+OssZpE4QGlxIdQuC+U=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Tue, 20 Oct 2020 10:26:00 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 10:26:00 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fix pcie information for sienna cichlid
Thread-Topic: [PATCH] drm/amd/pm: fix pcie information for sienna cichlid
Thread-Index: AQHWpr8DarrfxLKeeEOpjk2lJxIfAamgz20A
Date: Tue, 20 Oct 2020 10:26:00 +0000
Message-ID: <7B44B67E-882A-4B7A-9B8D-2F0F714235D6@amd.com>
References: <20201020085658.654678-1-likun.gao@amd.com>
In-Reply-To: <20201020085658.654678-1-likun.gao@amd.com>
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
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=253e5e84-fc2f-4db1-a4ec-95cddf77906a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-20T10:25:14Z; 
user-agent: Microsoft-MacOutlook/16.42.20101102
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.88.29.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23f9fad5-0242-4336-4863-08d874e28a84
x-ms-traffictypediagnostic: DM6PR12MB3306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB330664BD138D8FFAA120AE7A8E1F0@DM6PR12MB3306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6vgoBrxPPV8ysbw+v8jH2N2Ie4ZV6LQmdKwYruKmcq6o/+E+k7EG5vgbpqDk3drSeOid6XKzNxsCi+01RyX86I/l2HuaSA7RhcIfrC8l/JSCfX9tQ5fUrWFYh+5tdCDn/OhWzqz9XZv8kitqponwAZ0r4g6mntnsAuitEStUmucKj8ugv8Q2h3Mft7n61xhwJEzcnsV8gMVgryM8FVwOq35Fof2/Yly5L9JXUugFjmtExi+3pfztDgFuZu3MmamP3ocWCHmls2C9hQ3q54JlLXnDN9txLCi+vANiQJ+6O6LvLJDQE1tPTFpgy2NONVe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(5660300002)(71200400001)(36756003)(6506007)(8936002)(8676002)(6486002)(66556008)(66476007)(76116006)(91956017)(66946007)(33656002)(26005)(316002)(83380400001)(4326008)(186003)(64756008)(66446008)(478600001)(86362001)(6512007)(2906002)(2616005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: a/kdkS4An8jaFzSDXUE6E9VpJioeOdO22JKyS+/WzSIBFialaMX7s7FGwVLqKfm/l+ncOIPHM8HLrvS9OYRNHg/ArUlp90fk+SbkSPdKgY15fQiGpijTG8TrUzV3UirnSpYdLPH5CBkOekGS4ufEs+C3g6mF8mOy9Djuh/u4D14cmkJkmaOV4Xx24i1JQHjs9mnvEwAAPGApkA5aagSr58crGbrwNPP+wZNxsaAFcxzXQea8M4VpnbFrbaKw2DkutCP0U9/DIsSeS3+HRYccapqSOkMdtXc6oUZHZoXokMs5OgSG4PEvzkCJcedqm2Hr1PnDFWI74myMPdeA4/ixDevdPqFhevexvCl7kouaPOOwhdhoOChEimgS1zX1t2tj6nJDet8+Qz4gBejGRfBWqod+qcBjppBTN43fJ3nYDsX3GHxIanNbZLv4/aGijSq7ZrLnrgcx4QTXK8X8xJR3htPHMXYY6UaGqIw8ChP9cJi1IdAhyTJb28c45IDD2R/YQ1zbrY/++pP50u5hGIPRg/Ej0qultvNO2WMsKVuxLA9FIDdtTIf4Bkr92oRdCkEJSMHaBcSCTsMaP3Gdvtj+jsOGn1BXjsFVTkb3ApZedp1qcEWwao3R4o5+4ZSv+iQHnpk/W6VSDAhl/ggINsrqaA==
Content-ID: <AC9551DE32A5D240B05C2B83EA8F1D8E@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f9fad5-0242-4336-4863-08d874e28a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 10:26:00.6771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9KcMiiB+IfeE/REy7v3IRaaJVcO2cgDuGi+x8rneZdNkTX/5/c31LoPT+QNzq9D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4NCg0KDQrvu7/l
nKggMjAyMC8xMC8yMCDkuIvljYg0OjU377yM4oCcR2FvLCBMaWt1buKAnTxMaWt1bi5HYW9AYW1k
LmNvbT4g5YaZ5YWlOg0KDQogICAgRnJvbTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4N
Cg0KICAgIEZpeCB0aGUgZnVuY3Rpb24gdXNlZCBmb3Igc2llbm5hIGNpY2hsaWQgdG8gZ2V0IGNv
cnJlY3QgUENJRSBpbmZvcm1hdGlvbg0KICAgIGJ5IHBwX2RwbV9wY2llLg0KDQogICAgU2lnbmVk
LW9mZi1ieTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4NCiAgICBDaGFuZ2UtSWQ6IEk4
MWU1MjliZTZlOTZmMDgzZWI3YWEyNDRjMTY3MDA0MjJiZGU1ZmVjDQogICAgLS0tDQogICAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMgfCA0
ICsrLS0NCiAgICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEx
L3NpZW5uYV9jaWNobGlkX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
MS9zaWVubmFfY2ljaGxpZF9wcHQuYw0KICAgIGluZGV4IGM4ZTg3OTBlMDg3MS4uZTAwYzM4YjFi
ZDQxIDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEv
c2llbm5hX2NpY2hsaWRfcHB0LmMNCiAgICArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jDQogICAgQEAgLTk2NCw4ICs5NjQsOCBAQCBz
dGF0aWMgaW50IHNpZW5uYV9jaWNobGlkX3ByaW50X2Nsa19sZXZlbHMoc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUsDQogICAgIH0NCiAgICAgYnJlYWs7DQogICAgIGNhc2UgU01VX1BDSUU6DQogICAg
LWdlbl9zcGVlZCA9IHNtdV92MTFfMF9nZXRfY3VycmVudF9wY2llX2xpbmtfc3BlZWQoc211KTsN
CiAgICAtbGFuZV93aWR0aCA9IHNtdV92MTFfMF9nZXRfY3VycmVudF9wY2llX2xpbmtfd2lkdGgo
c211KTsNCiAgICArZ2VuX3NwZWVkID0gc211X3YxMV8wX2dldF9jdXJyZW50X3BjaWVfbGlua19z
cGVlZF9sZXZlbChzbXUpOw0KICAgICtsYW5lX3dpZHRoID0gc211X3YxMV8wX2dldF9jdXJyZW50
X3BjaWVfbGlua193aWR0aF9sZXZlbChzbXUpOw0KICAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0xJ
TktfTEVWRUxTOyBpKyspDQogICAgIHNpemUgKz0gc3ByaW50ZihidWYgKyBzaXplLCAiJWQ6ICVz
ICVzICVkTWh6ICVzXG4iLCBpLA0KICAgICAoZHBtX2NvbnRleHQtPmRwbV90YWJsZXMucGNpZV90
YWJsZS5wY2llX2dlbltpXSA9PSAwKSA/ICIyLjVHVC9zLCIgOg0KICAgIC0tDQogICAgMi4yNS4x
DQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
