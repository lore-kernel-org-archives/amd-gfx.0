Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD135C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 13:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C16520838
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 13:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c/a+9det"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C16520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD196EA29;
	Fri, 27 Mar 2020 13:18:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A8D6EA29
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8wedUDF1IKu2eN26mS513Je8lohhU1Ggu6eP5FefIpcLYcvVGbm0WLf9eOm2AuFQk9n2WQi30r+z3kSQpUIq/yafcGtagTM/zrMow4hN5TPnyriGUJBe0uVSJThtvaa+4ngFiowi/NdMDB3RDhzxgOtgxAglAwiWscHiIpmO210jBrUMVs9LdPcoAK9HrntQtNAJszmnyvsXM8HKMTWV9EE1xN45pHm069QhLcoKCYznx+r3TccX0Yna0UaAIoHMcia23JqPsa0hhtI63Gslo2w6mTQjK6Uw3LcYwUBB9rDYNf/qr5w9oquKeNMTZa2/nn4HvrStsECbbwGuiXAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4GaXgrFr6jB+3OKI7rD2QB1ImaeuaO/+J0il6VlnWE=;
 b=SmUPNCO9U6oAQ5MwNawZZcOXKbblZ55nDVUDR92o41yPHmVWXdzWqguNet+g1Ga4poLTyrSJCurrsZhcyyeA2jUIfoo7YnxVA33itWLiwFVE8EU4Gh4NuMYcJLR2U0sOe7HfTfNm9SMk/qbeU+2+VXDJO3sFLGquR9X+ck9KdRSkZz0H64CYVjo/mKuk0XFi6BwWZYO6dGhSA/D+coNSNpzN8RkII2hbQXsjxYdvOa0L5Q73YIZIoWMUYHEZxHDJyD1KDC6U7zGe09SoHA44XF2gw2cQxuWANIvIOovjTeaFwQcUlENytPROffbCd22qojQqeX390x4mXnZsGy/81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4GaXgrFr6jB+3OKI7rD2QB1ImaeuaO/+J0il6VlnWE=;
 b=c/a+9detVewF2BAUxARnkk4a1Ljth0KhLbN0+j6+AIuEWsKJvjje4GrybC2/JYgIOuDzyZKnCjeJbtGzpDe3mJMMrSoxjWu23rVNzRRvbr4J62PS3sgL/fnPgz8ARf+Fq7quDe2C6o7rton5/D+v5xt6obgXODngbdtnwagxpYU=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1948.namprd12.prod.outlook.com (2603:10b6:3:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 27 Mar
 2020 13:18:34 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 13:18:33 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 0/2] add direct IB pool
Thread-Topic: [RFC PATCH 0/2] add direct IB pool
Thread-Index: AQHWAxLHEZz28VZJUU6knQS4e38jIKhaWDlggAAJsICAAgwfMA==
Date: Fri, 27 Mar 2020 13:18:33 +0000
Message-ID: <DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200326020144.5953-1-xinhui.pan@amd.com>,
 <CY4PR12MB1703BFC301A1A22BF912869D84CF0@CY4PR12MB1703.namprd12.prod.outlook.com>
 <SN6PR12MB2800000B1CB04514C02CD81F87CF0@SN6PR12MB2800.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2800000B1CB04514C02CD81F87CF0@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-26T05:52:48.5484430Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [240e:e0:b16d:8000:5057:5dbf:794c:ce46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08d5d245-263c-4051-6446-08d7d2515994
x-ms-traffictypediagnostic: DM5PR12MB1948:|DM5PR12MB1948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1948E9554540C692E3DB52DB84CC0@DM5PR12MB1948.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(66476007)(66616009)(53546011)(52536014)(4326008)(6506007)(966005)(9686003)(478600001)(2906002)(64756008)(76116006)(186003)(5660300002)(55016002)(8936002)(66946007)(66446008)(66556008)(33656002)(45080400002)(81166006)(8676002)(86362001)(71200400001)(316002)(81156014)(7696005)(110136005)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1948;
 H:DM5PR12MB1708.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VrW0wnOQH16cHaxWBbt6IFq+wgWJnAYftxhKsjn/uI9p9s8iYdEaWUOl7SsGoFUvORB7VF0mWRCB0/TaGKtv5oky5ck4Q5xpNFuRnCZ3+bwxY7plb1ip2ZokPbkFSC8DiS7Hgc0f3d3ns0Fn/oU9tppqRINtOCgktboMLGDvd8AreDVFiN05i/DHMxVkSKKuN5bc4uRm64n4cyTaRTqo8IGkiuVANcGZI87/4DNJvy3XyMzvqndM515jf+9YL63DrX4fAp0beVOEwB0ZG6wvfc6rkdLYqgtC+CNcRoE9a7Rz3jPS/7jONF+iYoNLoLKXRnjmbHErYTzlSgTDk4MZdVesKShE4VAriZLpZzxP64TPQ08Tq41hQ4x33/JvP6TENe5gfxvlEfUB0nau4WlZwI0/covUsEDAjNCdKx2XQgZJi/RvD2iN1y/0DB1UMOuELtLWZqfqbENtb3PF/zp1OwU9pDqJZ/KZYGX5T09k3b4=
x-ms-exchange-antispam-messagedata: 4E+rDmycpuGCaS0+igvIp+DC3h7Ca4bVpzOax78TXenCvSRgYqXIWxdIK9+mMxxWtVrgTpLarlwCBeMmcrf3gYUPWPmX+uVo6SI7SzMkQldFFsERs8NqAIMAt5HPaLxL5+vNmmmrf2U7jWDBq4dz0MKFhVshGB09fbG5zgteC3ReJcVu7qm8mdXn11QkZPpBhvr3Y83iDeIwKiqFcCJLOw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d5d245-263c-4051-6446-08d7d2515994
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 13:18:33.2635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAMz9EzdjcO2Or4A41JRcf5D4H6ZzV9MVJG6ST/w70X92+CLaEhNpt34M0bcmxR8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1948
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0749944633=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0749944633==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0DM5PR12MB1708namp_";
	type="multipart/alternative"

--_004_DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0DM5PR12MB1708namp_
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0DM5PR12MB1708namp_"

--_000_DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0DM5PR12MB1708namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

QnllIHRoZSB3YXk6IGlmIHlvdSB3YW50IHRvIGF2b2lkIElCIHRlc3QgcGVuZGluZyBieSBHUFUg
cmVjb3ZlciwgeW91IGNhbiBtb3ZlIElCIHRlc3Qgb3V0IG9mIFREUiByb3V0aW5lLCBzbyBJQiB0
ZXN0IHdpbGwgZXhlY3V0ZSBhZnRlciBHUFUgc2NoZWR1bGVyIHJlc3VtZWQgd2l0aCBURFIgY29t
cGxldGVkIC4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTW9uayBM
aXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFNRA0KW3NpZy1jbG91ZC1ncHVdDQoNCkZyb206
IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgTWFyY2gg
MjYsIDIwMjAgMjowMiBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUs
IE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUkZDIFBBVENIIDAvMl0gYWRkIGRpcmVjdCBJQiBwb29sDQoNCg0KW0FNRCBPZmZp
Y2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQp5ZXMsIElCIHRl
c3QgYW5kICB2cmFtIHJlc3RvcmUgd2lsbCBhbGxvYyBJQnMuDQpJIGhpdCB0aGlzIGlzc3VlIGZv
ciBxdWl0ZSBhIGxvbmcgdGltZSBhZ28uIFdlIHRlc3QgYmVuY2htYXJrcyBvbiBBUk0gc2VydmVy
IHdoaWNoIGlzIHJ1bm5pbmcgYW5kcm9pZC4NCkh1bmRlcnMgb2YgcHJvY2Vzc2VzIGhpdCB0b28g
bWFueSBpc3N1ZXMuIFBhbmljIGFuZCBtZW1vcnkgY29ycnVwdGlvbiBldmVyeXdoZXJlLg0KTm93
IGkgaGF2ZSBhIGxpdHRrZSB0aW1lIHRvIGZpeCB0aGlzIGRlYWRsb2NrLg0KaWYgeW91IHdhbnQg
dG8gcmVwcm8gaXQsIHNldCBncHUgdGltZW91dCB0byA1MG1zo6x0aGVuIHJ1biB2dWxrYW4sb2Ns
LCBhbWRncHV0ZXN0LCBldGMgdG9nZXRoZXIuDQpJIGJlbGlldmUgeW91IHdpbGwgc2VlIG1vcmUg
d2VpcmQgaXNzdWVzLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IExp
dSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbTxtYWlsdG86TW9uay5MaXVAYW1kLmNvbT4+DQpTZW50
OiBUaHVyc2RheSwgTWFyY2ggMjYsIDIwMjAgMTozMTowNCBQTQ0KVG86IFBhbiwgWGluaHVpIDxY
aW5odWkuUGFuQGFtZC5jb208bWFpbHRvOlhpbmh1aS5QYW5AYW1kLmNvbT4+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+
IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+Pg0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbTxtYWlsdG86QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4+OyBLdWVobGluZywgRmVs
aXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb208bWFpbHRvOkZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
PjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbTxtYWlsdG86WGluaHVpLlBhbkBhbWQu
Y29tPj47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb208bWFpbHRv
OkNocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4+DQpTdWJqZWN0OiBSRTogW1JGQyBQQVRDSCAwLzJd
IGFkZCBkaXJlY3QgSUIgcG9vbA0KDQpUaGF0IHNvdW5kcyBhIHJvdWdobHkgZG9hYmxlIHBsYW4g
dG8gbWUgLCBhbHRob3VnaCB3ZSBkaWRuJ3QgaGl0IHRoaXMgaXNzdWUgaW4gb3VyIHZpcnR1YWxp
emF0aW9uIHN0cmVzcyB0ZXN0IGJ1dCBsaWtlIGEgcG9zc2libGUgaXNzdWUuDQoNCj4+PiBTbyB0
aGUgcmluZyB0ZXN0IGFib3ZlIGdvdCBzdHVjayBpZiBubyBpYiB0byBhbGxvYy4NCldoeSB0aGVy
ZSBpcyBJQiBhbGxvYyBoYXBwZW5lZCBpbiByaW5nIHRlc3QgPyBJIHJlbWVtYmVyIHRoZXJlIGlz
IG5vIElCIGFsbG9jYXRlZCBmb3IgcmluZyB0ZXN0LCBhcmUgeW91IHJlZmVycmluZyB0byBJQiB0
ZXN0ID8NCg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCk1vbmsg
TGl1fEdQVSBWaXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzxtYWlsdG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4+IE9uIEJl
aGFsZiBPZiB4aW5odWkgcGFuDQpTZW50OiBUaHVyc2RheSwgTWFyY2ggMjYsIDIwMjAgMTA6MDIg
QU0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPG1haWx0bzpBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPj47IEt1ZWhsaW5n
LCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbTxtYWlsdG86RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPG1haWx0bzpYaW5odWkuUGFu
QGFtZC5jb20+PjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbTxt
YWlsdG86Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPj4NClN1YmplY3Q6IFtSRkMgUEFUQ0ggMC8y
XSBhZGQgZGlyZWN0IElCIHBvb2wNCg0KZHJ1aW5nIGdwdSByZWNvdmVyeSwgd2UgYWxsb2MgaWJz
IGZvciByaW5nIHRlc3RzIHRvIHRlc3QgaWYgcmVjb3Zlcnkgc3VjY2VlZCBvciBub3QuDQoNCkFz
IGdwdSByZWNvdmVyeSBwYXJrZWQgdGhlIGdwdSBzY2hlZHVsZXIgdGhyZWFkLCBhbnkgcGVuZGlu
ZyBqb2JzIGhvbGQgdGhlIGliIHJlc291cmNlIGhhcyBubyBjaGFuY2UgdG8gZnJlZS4gU28gdGhl
IHJpbmcgdGVzdCBhYm92ZSBnb3Qgc3R1Y2sgaWYgbm8gaWIgdG8gYWxsb2MuDQoNCklmIHdlIHNj
aGVkdWxlIElCcyBkaXJlY3RseSBpbiBqb2Jfc3VibWl0X2RpcmVjdCwgd2UgY2FuIGFsbG9jIGli
cyBpbiB0aGUgbmV3IGliIHBvb2wuIEl0IHNob3VsZCBoYXZlIGxlc3MgY29udGVudGlvbi4NCg0K
SWYgdGhlIElCIGNvdWxkIGJlIGZyZWVkIGluIHRpbWUsIElPVywgbm90IGRlcGVuZGluZyBvbiBh
bnkgc2NoZWR1bGVyLCBub3IgYW55IG90aGVyIGJsb2NraW5nIGNvZGUuIEl0IGlzIGJldHRlciB0
byBhbGxvYyBpYnMgaW4gZGlyZWN0IHBvb2wuDQoNCnhpbmh1aSBwYW4gKDIpOg0KICBkcm0vYW1k
Z3B1OiBhZGQgZGlyZWN0IGliIHBvb2wNCiAgZHJtL2FtZGdwdTogdXNlIG5ldyBqb2IgYWxsb2Mg
dmFyaWF0aW9uIGlmIHBvc3NpYmxlDQoNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaCAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
cy5jICAgICAgfCAgMiArLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5j
ICAgICAgfCAxMiArKysrKysrKysrLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfam9iLmMgICAgIHwgIDggKysrKysrKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfam9iLmggICAgIHwgIDMgKystDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2pwZWcuYyAgICB8ICAyICstDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3R0bS5jICAgICB8ICAyICstDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2
ZC5jICAgICB8ICAyICstDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5j
ICAgICB8ICA0ICsrLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMg
ICAgIHwgIDYgKysrLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3Nk
bWEuYyB8ICAzICsrLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMgICAg
ICAgfCAgNCArKy0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAuYyAgICAg
ICB8ICA0ICsrLS0NCiAxMyBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxOCBkZWxl
dGlvbnMoLSkNCg0KLS0NCjIuMTcuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCmh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngm
YW1wO2RhdGE9MDIlN0MwMSU3Q21vbmsubGl1JTQwYW1kLmNvbSU3QzFmNWIxYTNiYTEwYTQ1MmM5
ZGU2MDhkN2QxMjliMzk2JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdD
MCU3QzYzNzIwNzg1MDIzNzY3OTY0NCZhbXA7c2RhdGE9Y1M3UzdhOGdEbUlneUpOYnI0cVhTUE1a
VEx3S3owVzQyOVolMkYyWm82Z2VrJTNEJmFtcDtyZXNlcnZlZD0wDQo=

--_000_DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0DM5PR12MB1708namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Bye the way: if you want=
 to avoid IB test pending by GPU recover, you can move IB test out of TDR r=
outine, so IB test will execute after GPU scheduler
 resumed with TDR completed .<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">________________________=
_____________<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;background:white;mso-fareast-language:ZH-CN">Monk Liu|GPU=
 Virtualization Team |</span><span style=3D"font-family:&quot;Calibri&quot;=
,sans-serif;color:#C82613;border:none windowtext 1.0pt;padding:0in;backgrou=
nd:white;mso-fareast-language:ZH-CN">AMD<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><img width=3D"80" height=
=3D"80" style=3D"width:.8333in;height:.8333in" id=3D"Picture_x0020_1" src=
=3D"cid:image001.png@01D6047D.43DC6A30" alt=3D"sig-cloud-gpu"><o:p></o:p></=
span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Pan, Xinhui &lt;Xinhui.Pan@amd=
.com&gt;
<br>
<b>Sent:</b> Thursday, March 26, 2020 2:02 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Liu, Monk &lt;Monk.Liu@amd.com&gt=
;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;; Koenig, Christian &lt;Christian.Koeni=
g@amd.com&gt;<br>
<b>Subject:</b> Re: [RFC PATCH 0/2] add direct IB pool<o:p></o:p></span></p=
>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">yes, IB te=
st and&nbsp; vram restore will alloc IBs.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">I hit this issue for quite a long time ag=
o. We test benchmarks on ARM server which is running android.<o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Hunders of=
 processes hit too many issues. Panic and memory corruption everywhere.<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Now i have=
 a littke time to fix this deadlock.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">if you want to repro it, set gpu timeout =
to 50ms</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=A3=
=AC</span><span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,san=
s-serif;color:black">then
 run vulkan,ocl, amdgputest, etc together.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">I believe =
you will see more weird issues.<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liu, M=
onk &lt;<a href=3D"mailto:Monk.Liu@amd.com">Monk.Liu@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, March 26, 2020 1:31:04 PM<br>
<b>To:</b> Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com">Xinhui.Pan=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Kuehling, Felix &lt;<a href=3D"mailt=
o:Felix.Kuehling@amd.com">Felix.Kuehling@amd.com</a>&gt;; Pan, Xinhui &lt;<=
a href=3D"mailto:Xinhui.Pan@amd.com">Xinhui.Pan@amd.com</a>&gt;;
 Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christia=
n.Koenig@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [RFC PATCH 0/2] add direct IB pool</span> <o:p></o:p></=
p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">That sounds a rough=
ly doable plan to me , although we didn't hit this issue in our virtualizat=
ion stress test but like a possible issue.<br>
<br>
&gt;&gt;&gt; So the ring test above got stuck if no ib to alloc.<br>
Why there is IB alloc happened in ring test ? I remember there is no IB all=
ocated for ring test, are you referring to IB test ?<br>
<br>
<br>
<br>
_____________________________________<br>
Monk Liu|GPU Virtualization Team |AMD<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of xinhui pan<br>
Sent: Thursday, March 26, 2020 10:02 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;; Kuehling, Felix &lt;<a href=3D"mailto:Felix=
.Kuehling@amd.com">Felix.Kuehling@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=
=3D"mailto:Xinhui.Pan@amd.com">Xinhui.Pan@amd.com</a>&gt;;
 Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christia=
n.Koenig@amd.com</a>&gt;<br>
Subject: [RFC PATCH 0/2] add direct IB pool<br>
<br>
druing gpu recovery, we alloc ibs for ring tests to test if recovery succee=
d or not.<br>
<br>
As gpu recovery parked the gpu scheduler thread, any pending jobs hold the =
ib resource has no chance to free. So the ring test above got stuck if no i=
b to alloc.<br>
<br>
If we schedule IBs directly in job_submit_direct, we can alloc ibs in the n=
ew ib pool. It should have less contention.<br>
<br>
If the IB could be freed in time, IOW, not depending on any scheduler, nor =
any other blocking code. It is better to alloc ibs in direct pool.<br>
<br>
xinhui pan (2):<br>
&nbsp; drm/amdgpu: add direct ib pool<br>
&nbsp; drm/amdgpu: use new job alloc variation if possible<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
| 12 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 8 &#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 =
&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 6 &#43;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |&nbsp; 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;13 files changed, 35 insertions(&#43;), 18 deletions(-)<br>
<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cmonk.liu%40amd.com%7C1f5b1a3ba10a452c9de608d7d129b396%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637207850237679644&amp;amp;sdata=3DcS7S7a8gD=
mIgyJNbr4qXSPMZTLwKz0W429Z%2F2Zo6gek%3D&amp;amp;reserved=3D0">https://nam11=
.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.or=
g%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cmonk.liu%40amd.co=
m%7C1f5b1a3ba10a452c9de608d7d129b396%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637207850237679644&amp;amp;sdata=3DcS7S7a8gDmIgyJNbr4qXSPMZTLwKz0W42=
9Z%2F2Zo6gek%3D&amp;amp;reserved=3D0</a><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0DM5PR12MB1708namp_--

--_004_DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0DM5PR12MB1708namp_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=12243;
	creation-date="Fri, 27 Mar 2020 13:18:32 GMT";
	modification-date="Fri, 27 Mar 2020 13:18:32 GMT"
Content-ID: <image001.png@01D6047D.43DC6A30>
Content-Transfer-Encoding: base64

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

--_004_DM5PR12MB170867DFB9EB4E46FDFA8EAB84CC0DM5PR12MB1708namp_--

--===============0749944633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0749944633==--
