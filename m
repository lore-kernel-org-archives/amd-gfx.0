Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A49FCA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154C92084C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154C92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9C56EB18;
	Wed, 23 Oct 2019 15:44:47 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790087.outbound.protection.outlook.com [40.107.79.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C213D6EB18
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 15:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2ovgDJAA8Kw4AGnDbrphE+ikNvr8PDSZylLs26WqoX485vWfLS3zXjjfKgrqtLRmYdPqJoe5APtPY+BZRT7MptgNQiciTwarW9r51dYSyMqnA1Cuh9HsxHqUoKqcPJXdaxJpaMea5ypFFIa+UgP/p0P0JhgtsJpow3FROvk4nbBq0fwtSr/XPUaysvFpagmVQL60tgTMpZ6E6PR7Ac8HVVmZIgROAAvfvQpioSOzjjXbVIm/I16GAEtxcpTQNMX+hfMzyIif7e1Wl8ZzKQQK2tYqspOQJDROmE5f0h2mJcnsZr4G5dc/4INLeKdrcHMcAHsFuGYGVUG6TnXdpxGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A4qG53BX0k1UX0ZPBv4aYyINORVGgA8FjPNn98wvVY=;
 b=eMmT7ql0lf/YTscGzRhEXTsi2J1QqDKgD4A6Q8dcpUAT5c8nNYzUpLT9SiDcBnPr2pkSyXGlnbx0qAKRY4QLJ7fSbU3gkECw09Q0mByjvtplSnjw7yhbjRwVF2qyjCYdKG2iqXo21bEEGqG/hzqeusAqL8w3S19dAKrz3ckKm55dZGJ3c20hGrL0hYIzEGumV+YiK3nWR53I3tOt5Wc22UXZw2fUnnRQc5jAc2y1UFqQ6v7YTNQQSmONNViXkp+WjRCMnijFY6R0AU5aI0GqeehiWb7TGMYMz9iTq8JEGKQ5ypAOMw5uC8uOzb/7glFubi8QJEVU6yFOwEO19FB2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2724.namprd12.prod.outlook.com (20.176.178.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 15:44:44 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::dd2e:828d:7e1e:7c66]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::dd2e:828d:7e1e:7c66%7]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 15:44:44 +0000
From: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
Subject: Re: [PATCH 18/37] drm/amd/display: Allow inverted gamma
Thread-Topic: [PATCH 18/37] drm/amd/display: Allow inverted gamma
Thread-Index: AQHVhR9LGUVEvKQVEkujU+rrTdrjGqdoYWkAgAAF6gA=
Date: Wed, 23 Oct 2019 15:44:44 +0000
Message-ID: <8ca6d548-7a6b-a242-ac22-75a43efd0955@amd.com>
References: <20191017191329.11857-1-sunpeng.li@amd.com>
 <20191017191329.11857-19-sunpeng.li@amd.com>
 <82b4b639-d1c7-c26c-cb84-4c41bb16cb41@daenzer.net>
In-Reply-To: <82b4b639-d1c7-c26c-cb84-4c41bb16cb41@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a348cce-d906-4ef6-0aed-08d757cfecd2
x-ms-traffictypediagnostic: BN7PR12MB2724:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB27246FFB2F47790DD97A05E5826B0@BN7PR12MB2724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(54906003)(316002)(99286004)(4326008)(76176011)(6116002)(3846002)(256004)(52116002)(71190400001)(36756003)(71200400001)(5660300002)(6306002)(4744005)(6246003)(6512007)(8936002)(486006)(446003)(2906002)(11346002)(2616005)(476003)(25786009)(66066001)(6916009)(66556008)(66946007)(86362001)(7736002)(6486002)(66476007)(66446008)(64756008)(6436002)(31696002)(186003)(966005)(81166006)(229853002)(8676002)(26005)(31686004)(4001150100001)(386003)(53546011)(6506007)(305945005)(478600001)(14454004)(102836004)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2724;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Lz7ZWwhju1Kc29I+D69CqdXDJ9bH24AjT/A/pKydPi8QZvWgiTwaPLA6H8reMyQxIvOg653NT39pDe2Whpj5g0p75B+HwDqBPWogfBtqidflpm5cfSUOWzqWXQnGoOHNhPK4GIDUS1GQSUjTktcd6toLselhQfYVBJ9S+ZAmZLmpThBojYtKJwqmpqlpf6JEFJxcsm2+s1cYTMlSaSG4Gn8I2rLnUx9hJoYFwpcroQ8F8PZWFhk+fWbc5G+tL7qEZLSVC5/ICSD8Yc5mNxRaXORxNrCQKWP6YgKN6ji238FiD8cUByXcD3wpfWoJMb37cHzhwH3QhN9S1nZQUd2TRw7XdQqCPTWj0xjfnWOs1qcPiXmsGXcOG5LS8I8r4+0Wex8pjlCRcdXz4ASiKINLRa6k02IuV/XQL1YJRzAeKgpn0Kdhsp5BEPw1QhI2lN9D5cCvDFpt4g/sMK26/thKws6Fh1Z4o9RTSz6uSmeuPs=
Content-ID: <E287FFCE9C774342AB877D89E804D4BC@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a348cce-d906-4ef6-0aed-08d757cfecd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 15:44:44.1968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJxgpK3Tt3dPmYqnPOHeuZjIfOschqbMD/1q+QzV10HX25HPH0oY7O7IeL5TEgNO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A4qG53BX0k1UX0ZPBv4aYyINORVGgA8FjPNn98wvVY=;
 b=3spcxX2QrSbY7O6+eBoff2ryzFC9gG9cVOruKO4qxdxX78+od+hDT61vdyO8amvc3CajZX6wH2MU3xwA8BjAS9Kcg2R9b/SoPffrW1Ojti2zmQsLpvSrRrs0iz47NOfv02wSD//1M7RRu+nt59BODOkE27/qBj3J5FDWzUmcL5o=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Kovac,
 Krunoslav" <Krunoslav.Kovac@amd.com>, "Amini, Reza" <Reza.Amini@amd.com>, "Yang,
 Aidan" <Aidan.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023154444.MZHRg_Gbvki1rSuY_7gDuj8_oTCKeP8EBvpZdPyhf8Q@z>

DQoNCk9uIDIwMTktMTAtMjMgMTE6MjMgYS5tLiwgTWljaGVsIETDpG56ZXIgd3JvdGU6DQo+IE9u
IDIwMTktMTAtMTcgOToxMyBwLm0uLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6DQo+PiBGcm9t
OiBBaWRhbiBZYW5nIDxBaWRhbi5ZYW5nQGFtZC5jb20+DQo+Pg0KPj4gW3doeV0NCj4+IFRoZXJl
J3MgYSB1c2UgY2FzZSBmb3IgaW52ZXJ0ZWQgZ2FtbWENCj4+IGFuZCBpdCdzIGJlZW4gY29uZmly
bWVkIHRoYXQgbmVnYXRpdmUgc2xvcGVzIGFyZSBvay4NCj4+DQo+PiBbaG93XQ0KPj4gUmVtb3Zl
IGNvZGUgZm9yIGJsb2NraW5nIG5vbi1tb25vdG9uaWNhbGx5IGluY3JlYXNpbmcgZ2FtbWENCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBBaWRhbiBZYW5nIDxBaWRhbi5ZYW5nQGFtZC5jb20+DQo+PiBS
ZXZpZXdlZC1ieTogS3J1bm9zbGF2IEtvdmFjIDxLcnVub3NsYXYuS292YWNAYW1kLmNvbT4NCj4+
IEFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4NCj4+IEFja2VkLWJ5OiBSZXph
IEFtaW5pIDxSZXphLkFtaW5pQGFtZC5jb20+DQo+IA0KPiBEb2VzIHRoaXMgZml4IGh0dHBzOi8v
YnVncy5mcmVlZGVza3RvcC5vcmcvMTEwNjc3ID8gSWYgc28sIGl0IHNob3VsZCBiZQ0KPiByZWZl
cmVuY2VkIGluIHRoZSBjb21taXQgbG9nLCBhbmQgdGhlIHJlcG9ydCByZXNvbHZlZCBvbmNlIHRo
aXMgbGFuZHMgaW4NCj4gZHJtLW5leHQgb3IgTGludXMnIHRyZWUuDQoNCkkgZG9uJ3QgdGhpbmsg
aXQgd291bGQsIG5vdCBvbiByZXBvcnRlZCBwbGF0Zm9ybSBhdCBsZWFzdC4gVGhpcyBjaGFuZ2UN
Cm9ubHkgbW9kaWZpZXMgZm9yIERDTiBmYW1pbGllcywgc28gUlg1ODAgd291bGRuJ3QgYmUgYWZm
ZWN0ZWQuDQoNCkxlbw0KDQo+IA0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
