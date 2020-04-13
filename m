Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E822DC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 04:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07F22072B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 04:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RZ713chc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07F22072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CFA6E157;
	Mon, 13 Apr 2020 04:28:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C91056E157
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 04:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9g5Ni8/LdjytA2Dlpthq2pHawKSIBwC0XmbfVjTBrKudbY5GElalnRRxSMBub3PVkhS5V/9/5dp0tZf5bLwgOio+Qz/XiF71KGf8o3isioJoZ9DLvhbPjEdleUB7lhAHYyNdnLUhzwcmuPKHUp3QPII0B21vzRLFj/q6ieLdSxdJenk7168THjemmaHryWncf9MszNO1nR6GVj/hd9uLHgEZE4CEj6n1AZUjaQ1NmGcCJXXqv4Tus+zpvmJrl+NMbGqeMDJaw3F8ftMLABiDt3Uii/YvYI1fHmUfMWiwnYEAEDdXjCDAaSunghCnYGTfW2p1qWPqDuNZJjafOrdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZJkmLntYW5eI93o0wQQCXRb09jsT5ueMmBmMmmwwQs=;
 b=WpTwY562o6veNeaYCy6M4mBqPxwpmTi0tu4NesazMo8wz+ffT0UaKbghjaqX546cJ8LBCMVbxZSjKQWw+pUnVEKNrnqTZIhUAJpKWGU4OT/6mKNxc7Uf8vF3RunfyXvGfQhCV3+8DRvjmtq5pT3pX7bI7MuzYfdVNW5iCluqqpCruMaf77NuAU9iipmhAHLoXtcGpWmCUhqgOR3a85ZGplG7uv4TGj+OFusoYP5AOMqAf6lUkYJH8VcVhne/DdbI55MVM9tjOexeBgll/US8K1l5Wz2O4YNVScasQRJujHvurnEtLiMaJQfjK+qRo91Ve19tbPX5fa50ZcbM2ugPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZJkmLntYW5eI93o0wQQCXRb09jsT5ueMmBmMmmwwQs=;
 b=RZ713chcoADRjXhA8gSRxrIFufY2wtpMuU6szLb0h6PHL6nViwIw6z6IlIg1d1OKTiiz2+zU3FL9Mq+UqGi9s3JZQykXhp+04ar09mJKcyNzmoPyvMH74JnHWNYTnlFbitBazbYTazbQjHAYyRrqkzyjjT+sV8Ed9ci2B/azZnQ=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2399.namprd12.prod.outlook.com (2603:10b6:802:2b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 04:28:19 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f%6]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 04:28:19 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, Johannes Hirte
 <johannes.hirte@datenkhaos.de>
Subject: Re: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Thread-Index: AQHWDN6T5UHYlsDC3UiXGUPd3pPdsqh0n6QAgABBZ4CAADRpC4ABZ3WAgACHXwA=
Date: Mon, 13 Apr 2020 04:28:19 +0000
Message-ID: <A765DE55-45AC-454E-9A64-36E9988E0DB4@amd.com>
References: <1586265256-8824-1-git-send-email-Prike.Liang@amd.com>
 <20200411235534.GA1930@latitude>
 <BY5PR12MB4307451314528C7285E49C60FBDC0@BY5PR12MB4307.namprd12.prod.outlook.com>
 <SN1PR12MB255854626047504C0AB71A0987DC0@SN1PR12MB2558.namprd12.prod.outlook.com>
 <BY5PR12MB430770EDDB677F95284387E8FBDD0@BY5PR12MB4307.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB430770EDDB677F95284387E8FBDD0@BY5PR12MB4307.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b38ce2e8-1efd-4f2a-ee10-08d7df63184f
x-ms-traffictypediagnostic: SN1PR12MB2399:|SN1PR12MB2399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2399590A8953771E4AB1AB9D87DD0@SN1PR12MB2399.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(36756003)(186003)(316002)(6486002)(64756008)(966005)(15650500001)(8936002)(91956017)(76116006)(66556008)(66446008)(26005)(86362001)(4326008)(66476007)(66946007)(71200400001)(478600001)(81156014)(110136005)(54906003)(6506007)(53546011)(33656002)(2616005)(6512007)(2906002)(5660300002)(8676002)(45080400002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMc8j0OlY5kN3XVWRk/HUV2XzrEpP/qEsx9BrPBPOGrrA03v63IphCQXrQjQvFvXIKgcWL6MoFAKa7fn6l9tbaCw3sWn5M+ySlMviiNeZ9JhI8Jca/ggjHzR+uxNhmVhCcxc1LcIdYwUrpxwm2Gk8KEeSVl0ynj3D9kd+u8KvzkKpMJLwbRjlQnG00gFlDGTMKKLJtmnWnT90R3FvkW6LVIT8fuM74ye+XNhhGjH9Y5ljSn4w6h503s3tT0GDHK/e6sQKqGBhrQAtQytZ+1PVZnkwyh/UnyRKo/AW2y/DSXdJGCqqe4vW1gHwRxjxjjUdegG6VkhB3zYP/qKXHJ36JXSJm58HIGW6S/APJekzui8mSyQHF5FRTAlJ+IQaObtcm3VD7Md3Yu+4AhtYC/7k0ZBnw0war9kq33fLVIRr66FCwAvE4Q+5KXaHPa4taJ2QViOjt0A/aVwmXagkQCYXIrQP/iNyeP7lAS1+3plf+Q=
x-ms-exchange-antispam-messagedata: TKOkOjgggMuCiNRX2KVGcox2LVj42R9Xd4Db6gPmHMUEWwRHVwsZVXwS2H1c4GQnWeDotdnaqwoZlnS807WQG7W4MvDFA+TrKEI4z+8sCy3MeVa1QUDgEDj8QDy6MOOY/aK+wN9C9ReK6mAW8IhewQ==
Content-ID: <6E5F4EA56847A34CB1564A54B508B93E@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38ce2e8-1efd-4f2a-ee10-08d7df63184f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 04:28:19.6453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZnKDNEPpw4OBkg2FNq9DipMpgotSw767O0L/C2fd0aZbrW6+SD6FJQzblkWSPyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2399
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MDY6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBBZHZhbmNlZCBNaWNybyBEZXZpY2Vz
LCBJbmMuIFtBTUQvQVRJXSBWZWdhIDEwIFtSYWRlb24gUFJPIFdYIDgxMDBdIChwcm9nLWlmIDAw
IFtWR0EgY29udHJvbGxlcl0pDQoJU3Vic3lzdGVtOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJ
bmMuIFtBTUQvQVRJXSBWZWdhDQoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5
Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0g
RGlzSU5UeC0NCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZT
RUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtDQoJ
SW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDEwDQoJUmVnaW9uIDA6IE1lbW9yeSBhdCAy
ZmUwMDAwMDAwICg2NC1iaXQsIHByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yNTZNXQ0K
CVJlZ2lvbiAyOiBNZW1vcnkgYXQgMmZmMDAwMDAwMCAoNjQtYml0LCBwcmVmZXRjaGFibGUpIFtk
aXNhYmxlZF0gW3NpemU9Mk1dDQoJUmVnaW9uIDQ6IEkvTyBwb3J0cyBhdCBkMDAwIFtkaXNhYmxl
ZF0gW3NpemU9MjU2XQ0KCVJlZ2lvbiA1OiBNZW1vcnkgYXQgZGZjMDAwMDAgKDMyLWJpdCwgbm9u
LXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT01MTJLXQ0KCUV4cGFuc2lvbiBST00gYXQg
ZGZjODAwMDAgW2Rpc2FibGVkXSBbc2l6ZT0xMjhLXQ0KCUNhcGFiaWxpdGllczogPGFjY2VzcyBk
ZW5pZWQ+DQoJS2VybmVsIG1vZHVsZXM6IGFtZGdwdQ0KDQpBZGFwdGVyICAxICAgIFNFRz0wMDAw
LCBCTj0wNiwgRE49MDAsIFBDSUlEPTY4NjgxMDAyLCBTU0lEPTBBMEMxMDAyKQ0KICAgIEFzaWMg
RmFtaWx5ICAgICAgICA6ICBWZWdhMTAgICAgICAgICANCiAgICBGbGFzaCBUeXBlICAgICAgICAg
OiAgTTI1UDgwICAgICAgKDEwMjQgS0IpDQogICAgUHJvZHVjdCBOYW1lICAgICAgIDogIFZlZ2Ex
MCBEMDUxMTEgMzJNeDEyOCA4R0IgODUyZS8xMDAwbSAxLjAwViANCiAgICBCaW9zIENvbmZpZyBG
aWxlICAgOiAgRDA1MTExMDAuMTA5ICAgDQogICAgQmlvcyBQL04gICAgICAgICAgIDogIDExMy1E
MDUxMTEwMC0xMDkNCiAgICBCaW9zIFZlcnNpb24gICAgICAgOiAgMDE2LjAwMS4wMDEuMDAwLjAx
MTEyNQ0KICAgIEJpb3MgRGF0ZSAgICAgICAgICA6ICAwOS8yMi8xOCAxMDo0OCANCiAgICBST00g
SW1hZ2UgVHlwZSAgICAgOiAgSHlicmlkIEltYWdlcw0KICAgIFJPTSBJbWFnZSBEZXRhaWxzICA6
ICANCiAgICAgICAgSW1hZ2VbMF06IFNpemUoNjE5NTIgQnl0ZXMpLCBUeXBlKExlZ2FjeSBJbWFn
ZSkNCiAgICAgICAgSW1hZ2VbMV06IFNpemUoNDM1MjAgQnl0ZXMpLCBUeXBlKEVGSSBJbWFnZSkN
Cg0K5Y+R5Lu25Lq6OiAiTGlhbmcsIFByaWtlIiA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCuaXpeac
nzogMjAyMOW5tDTmnIgxM+aXpSDmmJ/mnJ/kuIAgMTI6MjMNCuaUtuS7tuS6ujogIlBhbiwgWGlu
aHVpIiA8WGluaHVpLlBhbkBhbWQuY29tPiwgSm9oYW5uZXMgSGlydGUgPGpvaGFubmVzLmhpcnRl
QGRhdGVua2hhb3MuZGU+DQrmioTpgIE6ICJEZXVjaGVyLCBBbGV4YW5kZXIiIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPiwgIkh1YW5nLCBSYXkiIDxSYXkuSHVhbmdAYW1kLmNvbT4sICJRdWFu
LCBFdmFuIiA8RXZhbi5RdWFuQGFtZC5jb20+LCAiYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmciIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCuS4u+mimDogUkU6IFtQQVRDSCB2
Ml0gZHJtL2FtZGdwdTogZml4IGdmeCBoYW5nIGR1cmluZyBzdXNwZW5kIHdpdGggdmlkZW8gcGxh
eWJhY2sgKHYyKQ0KDQpDb3VsZCB5b3Ugc2hhcmUgdGhlIFBDSSBzdWIgcmV2aXNpb24gYW5kIEkg
dHJ5IGNoZWNrIHRoZSBpc3N1ZSBvbiB0aGUgVmVnYTEwKDEwMDI6Njg3ZikgYnV0IGNhbuKAmXQg
ZmluZCB0aGUgDQpyZWJvb3QgaGFuZyB1cC4NCsKgDQpUaGFua3MsDQpQcmlrZQ0KRnJvbTogUGFu
LCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4gDQpTZW50OiBTdW5kYXksIEFwcmlsIDEyLCAy
MDIwIDI6NTggUE0NClRvOiBKb2hhbm5lcyBIaXJ0ZSA8am9oYW5uZXMuaGlydGVAZGF0ZW5raGFv
cy5kZT47IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCkNjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVh
bmdAYW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IGZp
eCBnZnggaGFuZyBkdXJpbmcgc3VzcGVuZCB3aXRoIHZpZGVvIHBsYXliYWNrICh2MikNCsKgDQpQ
cmlrZQ0KSSBoaXQgdGhpcyBpc3N1ZSB0b28uIHJlYm9vdCBodW5nIHdpdGggbXkgdmVnYTEwLsKg
IGl0IGlzIG9rIHdpdGggbmF2aTEwLg0KDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBvbiBiZWhhbGYgb2YgTGlhbmcsIFByaWtlIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPg0KU2VudDogU3VuZGF5LCBBcHJpbCAxMiwgMjAyMCAxMTo0OTozOSBBTQ0K
VG86IEpvaGFubmVzIEhpcnRlIDxqb2hhbm5lcy5oaXJ0ZUBkYXRlbmtoYW9zLmRlPg0KQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkg
PFJheS5IdWFuZ0BhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+
DQpTdWJqZWN0OiBSRTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBmaXggZ2Z4IGhhbmcgZHVyaW5n
IHN1c3BlbmQgd2l0aCB2aWRlbyBwbGF5YmFjayAodjIpIA0KwqANClRoYW5rcyB1cGRhdGUgYW5k
IHZlcmlmeS4gQ291bGQgeW91IGdpdmUgbW9yZSBkZXRhaWwgaW5mb3JtYXRpb24gYW5kIGVycm9y
IGxvZyBtZXNzYWdlwqDCoCANCmFib3V0IHlvdSBvYnNlcnZlZCBpc3N1ZT8gDQoNClRoYW5rcywN
ClByaWtlDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEhp
cnRlIDxqb2hhbm5lcy5oaXJ0ZUBkYXRlbmtoYW9zLmRlPg0KPiBTZW50OiBTdW5kYXksIEFwcmls
IDEyLCAyMDIwIDc6NTYgQU0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNv
bT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdA
YW1kLmNvbT47DQo+IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBmaXggZ2Z4IGhhbmcgZHVyaW5nIHN1c3BlbmQgd2l0
aCB2aWRlbw0KPiBwbGF5YmFjayAodjIpDQo+IA0KPiBPbiAyMDIwIEFwciAwNywgUHJpa2UgTGlh
bmcgd3JvdGU6DQo+ID4gVGhlIHN5c3RlbSB3aWxsIGJlIGhhbmcgdXAgZHVyaW5nIFMzIHN1c3Bl
bmQgYmVjYXVzZSBvZiBTTVUgaXMgcGVuZGluZw0KPiA+IGZvciBHQyBub3QgcmVzcG9zZSB0aGUg
cmVnaXN0ZXIgQ1BfSFFEX0FDVElWRSBhY2Nlc3MgcmVxdWVzdC5UaGlzDQo+ID4gaXNzdWUgcm9v
dCBjYXVzZSBvZiBhY2Nlc3NpbmcgdGhlIEdDIHJlZ2lzdGVyIHVuZGVyIGVudGVyIEdGWCBDR0dQ
Rw0KPiA+IGFuZCBjYW4gYmUgZml4ZWQgYnkgZGlzYWJsZSBHRlggQ0dQRyBiZWZvcmUgcGVyZm9y
bSBzdXNwZW5kLg0KPiA+DQo+ID4gdjI6IFVzZSBkaXNhYmxlIHRoZSBHRlggQ0dQRyBpbnN0ZWFk
IG9mIFJMQyBzYWZlIG1vZGUgZ3VhcmQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBM
aWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IE1lbmdiaW5nIFdhbmcg
PE1lbmdiaW5nLldhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPsKgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDUgKysrLS0NCj4gPsKgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBpbmRleCAyZTFmOTU1Li5i
Zjg3MzViIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KPiA+IEBAIC0yNDQwLDggKzI0NDAsNiBAQCBzdGF0aWMgaW50DQo+ID4gYW1kZ3B1
X2RldmljZV9pcF9zdXNwZW5kX3BoYXNlMShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldinCoCB7
DQo+ID7CoMKgwqDCoMKgIGludCBpLCByOw0KPiA+DQo+ID4gLcKgwqAgYW1kZ3B1X2RldmljZV9z
ZXRfcGdfc3RhdGUoYWRldiwgQU1EX1BHX1NUQVRFX1VOR0FURSk7DQo+ID4gLcKgwqAgYW1kZ3B1
X2RldmljZV9zZXRfY2dfc3RhdGUoYWRldiwgQU1EX0NHX1NUQVRFX1VOR0FURSk7DQo+ID4NCj4g
PsKgwqDCoMKgwqAgZm9yIChpID0gYWRldi0+bnVtX2lwX2Jsb2NrcyAtIDE7IGkgPj0gMDsgaS0t
KSB7DQo+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWFkZXYtPmlwX2Jsb2Nrc1tp
XS5zdGF0dXMudmFsaWQpDQo+ID4gQEAgLTM0NzAsNiArMzQ2OCw5IEBAIGludCBhbWRncHVfZGV2
aWNlX3N1c3BlbmQoc3RydWN0IGRybV9kZXZpY2UNCj4gKmRldiwgYm9vbCBmYmNvbikNCj4gPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPsKgwqDCoMKgwqAgfQ0KPiA+DQo+ID4gK8Kg
wqAgYW1kZ3B1X2RldmljZV9zZXRfcGdfc3RhdGUoYWRldiwgQU1EX1BHX1NUQVRFX1VOR0FURSk7
DQo+ID4gK8KgwqAgYW1kZ3B1X2RldmljZV9zZXRfY2dfc3RhdGUoYWRldiwgQU1EX0NHX1NUQVRF
X1VOR0FURSk7DQo+ID4gKw0KPiA+wqDCoMKgwqDCoCBhbWRncHVfYW1ka2ZkX3N1c3BlbmQoYWRl
diwgIWZiY29uKTsNCj4gPg0KPiA+wqDCoMKgwqDCoCBhbWRncHVfcmFzX3N1c3BlbmQoYWRldik7
DQo+IA0KPiANCj4gVGhpcyBicmVha3Mgc2h1dGRvd24vcmVib290IG9uIG15IHN5c3RlbSAoRGVs
bCBsYXRpdHVkZSA1NDk1KS4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+wqDCoCBKb2hhbm5lcyBI
aXJ0ZQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
YW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTAyJTdDMDElN0N4aW5odWkucGFuJTQwYW1kLmNvbSU3Q2RlNmUwNTc4MTc0OTQw
YjVmMjk4MDhkN2RlOTQ4Yjg4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3QzYzNzIyMjYwMTk2OTg0MzI0OCZhbXA7c2RhdGE9cXVXR0VsdyUyRm83MFZKaWJ1Wjcl
MkJ6UyUyRmNISDJPSFNEQiUyQjV1YUZQUVVmMk9zJTNEJmFtcDtyZXNlcnZlZD0wDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
