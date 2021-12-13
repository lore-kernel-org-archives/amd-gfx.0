Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F71C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 07:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EEB510E34D;
	Mon, 13 Dec 2021 07:20:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CC410E34D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 07:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enRIk8CYAbdgZCzR5rVAmVvFNOoUjfdw3kaLV1SoQGUrkt0SVWrVAjkXe1PQaBWYddghXgyW0TuDatJMLm+dlsEbwao/aMHPhjlSgU8GgLrNMHl/Um4hAXvixMn5HZK+Sq//52j9AFjx+7serNowQMyXoB2l86CqDW/6HB6vUYCqHSqEpNts0jRXLZYJKanw3ZyW7AkXTszVWfHFIV4oe5blXW58MeYUtTAbmpMKE7IN04hBP3iaU0LXI4jIGNy5nSQcaY/bM21mH7EgRAb6vCCsubNw/qj0HVy1gwi350TSyu//NQjvt5AEoCyUbcnbppM9Fi3WXPDI+8G44rWL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI+xgiDBhDyy+ynuaAmbU0jGQu1Lmsp7Dja2zUabUO8=;
 b=ZBbI3I11exdSdeJd7wc3cVUMCMUquhIOL6rdD0Tuo6uplctvGwbU5Q5+vSkQLY0emNZRQNDiVpsGmLf1nnCswjyLkrLY4yEbwPTWzlsX1k0nX4jhKj1w75bwgqoCNH/905vkur2P9Yqg534hBnMbhGi+bdS6pczkM6f0/GmO3tVhxm0iPjhjJo7261b9GTLzI5TuYUUrsTna/lV84IepZ40n0cwI2OPZnhZaFQUGL7+M252T8iyU9eGPO8rIICgFEF6KkhUcuXlbmks/VPTEfoyWnisU72uQtI/0y3eHjLRsUfDLP9ObPPswaR+M0Gok1Q9NbqRKVKnkF02qkI+thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI+xgiDBhDyy+ynuaAmbU0jGQu1Lmsp7Dja2zUabUO8=;
 b=PCwHOTM1YpNijn8JMImJM7y7MSPgyqjQuERIy24oC8Bnrlx0pXq4RT2Ppp1VQxxVS7JcTwNTuY0O8FeGIy84ZyL29AqYx+RxdDb67UM0ceqD2ulORVL8b3T3LXh/7QmzFj27wUr+4wK9x98usdY5U8OjLr9Tv2J4VXM7eCPz9l4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Mon, 13 Dec 2021 07:20:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 07:20:36 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place
Thread-Topic: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place
Thread-Index: AQHX7+RIHqsmmsPhMEy5uNUMGefWHKwv++4AgAAIC1A=
Date: Mon, 13 Dec 2021 07:20:36 +0000
Message-ID: <DM6PR12MB26190225096EFB08BAA0EBEBE4749@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211213054241.773719-1-evan.quan@amd.com>
 <62e3d5ec-65ba-1e39-07a2-c16df1b81d37@amd.com>
In-Reply-To: <62e3d5ec-65ba-1e39-07a2-c16df1b81d37@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-13T07:20:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6b4d99c5-1726-4bb1-90be-41b407cc3010;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd8af4e3-a85a-408a-c3c7-08d9be090ec9
x-ms-traffictypediagnostic: DM5PR12MB1644:EE_
x-microsoft-antispam-prvs: <DM5PR12MB164463883FAC0CA0FDC4BEDFE4749@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6f32qsHKwFBy/IzcsRx3XcFJh4Kj0lX0IZbldfAk4LYDxGjMi8qmJx3phqT48plK4rbp2cs3m8Qvszi4CWrwlqTJAREUgUBf/atjPCraKJkOy2E3WYlkfoXMPYNBvD8uENg9wai+08N+M9EVxPDUMJf7llWbFSYlTG5PZDNWUr8UxOmxWAeQrB78yrW1J1CT3mhi1fVkZ72HPk+K3yNDjEKBIVigf0d9IWuERjPRUeoLvw+IQWo+wLkGQ8UzX12UroAT9TS5LONBTDrAYEeI66LtzhNU7nGicVR1Y9WMoFSPLK2bOvAeXi5/qCOWh8OBQ6HInQnMSpKcfRGccQxqveZk9j2X4927D+8obcqXXCrmNg0rM4AQhJB+2g3LJw0XNXRBdXFUoi/dmVTwKnGvaFAo8dXsoz2zwlQDFbA5hHelNfmUcXXiw6aqW7k1I3hRie5CBj5ejYP6mPV8TYagHm2Gs3aheGv2uCVCtxMUq0LCBOYWXBG+bscaaJG3zsLJoPyRhwpSLf4QnTvvgcp+QrHyAyRLnZm21WPXOdVZlBpENbPm5fdGGqkiI6gU21DTCJV2t3wM2ubippdDO5HESxkPfIy50ziMIi6T8/2lUPylJujh8sfDtnGBZu9D78qpX70o2dgWBVzd9IHhOiJXmBNQK1+v4bvuGoQhKBu3WRzOlJjjEuGjXxOThZXkPQf/Gy66hmoGDbXQvRtwnKJ8iA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(5660300002)(316002)(66476007)(9686003)(66446008)(8936002)(33656002)(66556008)(53546011)(186003)(26005)(66946007)(2906002)(4326008)(64756008)(52536014)(55016003)(76116006)(122000001)(8676002)(83380400001)(86362001)(110136005)(38070700005)(38100700002)(71200400001)(6506007)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUpGOUpBWXpZYkRKWHBUTmJVTGlaQXlxNDJjSjlaWEJtVHV0YTRVcE1EVnRy?=
 =?utf-8?B?TG9iOG1hM2M2VUpGc0pZa0FvSForeFBTeUErbVFzeXQ1WTVCU2V1VSs0TU1a?=
 =?utf-8?B?R1A1MkxpNVAwYnV5dFNxK3YzSG94MDBkNzg4QTlEeDBhUExOODUvcW9vR2g0?=
 =?utf-8?B?bHVCZ2hpMnJHc0dScSt5aGZna3NGc2lQNjluY3Q1SVlxWE5YRnVGK2JubzRX?=
 =?utf-8?B?MEpwRXJmbGJlMG43REF4eE56ODFTblowWE9vOVlJMUdack5Db0hUWTU0dERu?=
 =?utf-8?B?SnRQVi9lNEVFS3hwU1M2VHEydTUvV3cveG1nM2NaTGtYRkI2eG1KMW5ZM2Jl?=
 =?utf-8?B?cTNyOTFzTHBIZktZVHh4L0M2QVVhUDBqTm5Pb2J0eHlCV1Q1T3FCd1VQMFZJ?=
 =?utf-8?B?MkdpY0NmWlQwNTJxZnZ3RjUzOFFlQldTUXVVMnlBaXlIbVJKdWV0SGhSODlE?=
 =?utf-8?B?dE5TMmZYeU80MGkrQWtGMU1kQThiVkpLZ29SdUpiU05aVnJwVXVlMFpZWjFP?=
 =?utf-8?B?WnJjVUhnUGtSTDMvcE5TQ3Z3dGxqaUpJbDZlZHRpRHF6Y2tTSnV5OHlRbVhl?=
 =?utf-8?B?SjBBcDh2Zm9MbnlHeWJTNnRIcWlBd2xqMGNZWHZIWlE4K252d3hlNXFnM202?=
 =?utf-8?B?WjV4d09sNWpLRkFHUkFqOFUyN2czSXBqOGd2SStaRVR3WkNNaVlrVHBSbHVr?=
 =?utf-8?B?SURJNEdQZXJaNWYyUlBRNDExTmowRnIzRVd2ekMxenhUWUJFMTNGZHVtaHVN?=
 =?utf-8?B?RzBBejZNeEE4RDBrQjR1OFRIQzA3UkxIWmZWNUdnZGoxN1d5SElERHp0OEdu?=
 =?utf-8?B?bFJQMXFWNU1kWm53T0pEZFRhVkM1bm9GNFJKVml6a0w3a25jdTVSVDBCMUxa?=
 =?utf-8?B?K3FxQ1p5RmJjOTJpMkcwc1U1TC8vYWszMG1DL3VDczlXRUd5Qmh0U1BwRUR5?=
 =?utf-8?B?WnkzUTFhV24wbXZ0WFl1akh5TjVObk52OE5xd1pBRDU0WU1jSldkc2FIVHNU?=
 =?utf-8?B?dUE4cWRqUWF3ejh6ZSt1Snc5RmwzdFFWdGk2SXhvRHZ5Wld1NGhJekpxdnVZ?=
 =?utf-8?B?eEpjbDBPWndHVURUbG5oTUwzQ1BodVdackZLRG9YTXhLdHdubFlmRlovMWpu?=
 =?utf-8?B?by9TVkhZd3VhRzFPdzJ1WVp1R3pRSVdRWVN3RFFNVEJaMGsyUG8zc3loRnF1?=
 =?utf-8?B?ZVIzZ1Q1U3hnajBvQ1dTKzNrQkRmSktkUmNhM0JxNU9zR2xXRG5nQ0hHRkVO?=
 =?utf-8?B?MXpDODBxVFlZYmNJNUxobS8xaDlLNTE4NjR4dUJhMWs5b1RkYk5VanZmbm1p?=
 =?utf-8?B?VnRUeWNReDZudXM2eFZZcFM2QVRBaHc4clJBTVZVQjIwQWlKSTQ5NXg1OG1w?=
 =?utf-8?B?Vkx3NVJXQnNSd0Z5QWpQMHlKbG9mODdVRmtFeXVzTVRUTStkd0VuRzFEclIv?=
 =?utf-8?B?L2RHZHNxMkpyWjRjVDAxbittOEVpUFp5cC8xQkRtR3BSdUgwQzgzbU14NVcz?=
 =?utf-8?B?NFNBdldnVlBnQmFxYnQ0bDh5aUNBeVB1ZVI3TkJqeUdZeGxYVzJUZ0UzVXlM?=
 =?utf-8?B?UU9zRjF1cVJpdE9DMVI2YmtTMFRFSm9ZaVU3SGZ3U0FHMm5RUEhpUmRkak9T?=
 =?utf-8?B?ekFjajhLWW1uSUxyQ2FTVkVnMUIvQ1l2YzZCaTNhREdtOGZKYXpkQmV5L0ZN?=
 =?utf-8?B?SE1Ec0tWcTBaWG5oTHIrMXkxbXI5UllMWjV6NjBPY0w1ZitqeVpnM0NpWHVL?=
 =?utf-8?B?Unltc0ZWT3Fjd09FRXFVMlBXS0hUcHNOSlV4NytiVnBtemE4c1k0V1JXQTI2?=
 =?utf-8?B?dkVad0h0V3A0TG5TUjB4MFh3Mm4rd2NxYTRXdzVBcmNQTHMyVnpCOVpHNEha?=
 =?utf-8?B?aHF3Q0xTUThUVE53VldvTjAzQXE5Ry9GL2lPWjdNcTRubWQ2dTdETkdDMkt2?=
 =?utf-8?B?MUtMdEFMMWdyNGRyTkswT0d5VDdSSnBGMXl0YktJYjNyb2lOaTd4ampLZ2d0?=
 =?utf-8?B?RkI5YVU4aEZQUVdXeFNpYzNUejQ3NHlZY3pzSWJJNG8rMXdmQlZxTW1IdHEw?=
 =?utf-8?B?djAzTTlMRGVVaUo1Vmszck5lQW9jalNCMTBNeUd4c01WWW4zS1N0ZFFrZ1Nl?=
 =?utf-8?Q?c0fU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8af4e3-a85a-408a-c3c7-08d9be090ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:20:36.1243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOwFqlbJ2Hal4h79zPecyALmgjjKu+PuF3kC5/caxpFiipB6xt+tD5CJzfcs6ZRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBEZWNlbWJlciAxMywgMjAyMSAyOjUyIFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IG1vdmUgc211X2RlYnVnX21hc2sgdG8gYSBtb3JlDQo+IHByb3Bl
ciBwbGFjZQ0KPiANCj4gDQo+IA0KPiBPbiAxMi8xMy8yMDIxIDExOjEyIEFNLCBFdmFuIFF1YW4g
d3JvdGU6DQo+ID4gQXMgdGhlIHNtdV9jb250ZXh0IHdpbGwgYmUgaW52aXNpYmxlIGZyb20gb3V0
c2lkZShvZiBwb3dlcikuIEFsc28sIHRoZQ0KPiA+IHNtdV9kZWJ1Z19tYXNrIGNhbiBiZSBzaGFy
ZWQgYXJvdW5kIGFsbCBwb3dlciBjb2RlIGluc3RlYWQgb2Ygc29tZQ0KPiA+IHNwZWNpZmljIGZy
YW1ld29yayhzd1NNVSkgb25seS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8
ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJMWEwZTFhNDM2YTUxZmM1MjBhNDdi
M2ZiMjhjZGU1MjdkNGU1ZWI2ZQ0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1LmggICAgICAgICB8IDcgKysrKysrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDIgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUuaCAgICAgfCA4IC0tLS0tLS0tDQo+ID4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYyAgICAgIHwgOSArKysrKystLS0NCj4gPiAg
IDQgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gaW5kZXggZTcwMWRl
ZGNlMzQ0Li45Y2ViOGYzZTczZGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaA0KPiA+IEBAIC04MTEsNiArODExLDkgQEAgc3RydWN0IGFtZF9wb3dlcnBsYXkgew0K
PiA+ICAgCQkJCQkgIChyaWQgPT0gMHgwMSkgfHwgXA0KPiA+ICAgCQkJCQkgIChyaWQgPT0gMHgx
MCkpKSkNCj4gPg0KPiA+ICsvKiBVc2VkIHRvIG1hc2sgc211IGRlYnVnIG1vZGVzICovDQo+ID4g
KyNkZWZpbmUgU01VX0RFQlVHX0hBTFRfT05fRVJST1IJCTB4MQ0KPiA+ICsNCj4gPiAgICNkZWZp
bmUgQU1ER1BVX1JFU0VUX01BR0lDX05VTSA2NA0KPiA+ICAgI2RlZmluZSBBTURHUFVfTUFYX0RG
X1BFUkZNT05TIDQNCj4gPiAgIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsNCj4gPiBAQCAtOTU5LDYg
Kzk2MiwxMCBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7DQo+ID4gICAJc3RydWN0IGFtZGdwdV9w
bQkJcG07DQo+ID4gICAJdTMyCQkJCWNnX2ZsYWdzOw0KPiA+ICAgCXUzMgkJCQlwZ19mbGFnczsN
Cj4gPiArCS8qDQo+ID4gKwkgKiAwID0gZGlzYWJsZWQgKGRlZmF1bHQpLCBvdGhlcndpc2UgZW5h
YmxlIGNvcnJlc3BvbmRpbmcgZGVidWcNCj4gbW9kZQ0KPiA+ICsJICovDQo+ID4gKwl1aW50MzJf
dAkJCXNtdV9kZWJ1Z19tYXNrOw0KPiA+DQo+IE1heWJlLCBiZXR0ZXIgdG8gaGF2ZSBpdCBpbnNp
ZGUgcG0uDQpbUXVhbiwgRXZhbl0gVGhhbmtzLiBGaXhlZCBpbiBWMi4NCg0KQlINCkV2YW4NCj4g
DQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiAgIAkvKiBuYmlvICovDQo+ID4gICAJc3RydWN0
IGFtZGdwdV9uYmlvCQluYmlvOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGVidWdmcy5jDQo+ID4gaW5kZXggOWRmY2NiMjBmZWRkLi5lZTFjYzE1YzZmMDkg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVn
ZnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmMNCj4gPiBAQCAtMTYxOSw3ICsxNjE5LDcgQEAgaW50IGFtZGdwdV9kZWJ1Z2ZzX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYpDQo+ID4gICAJCXJldHVybiAwOw0KPiA+DQo+ID4g
ICAJZGVidWdmc19jcmVhdGVfeDMyKCJhbWRncHVfc211X2RlYnVnIiwgMDYwMCwgcm9vdCwNCj4g
PiAtCQkJICAgJmFkZXYtPnNtdS5zbXVfZGVidWdfbWFzayk7DQo+ID4gKwkJCSAgICZhZGV2LT5z
bXVfZGVidWdfbWFzayk7DQo+ID4NCj4gPiAgIAllbnQgPSBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJh
bWRncHVfcHJlZW1wdF9pYiIsIDA2MDAsIHJvb3QsIGFkZXYsDQo+ID4gICAJCQkJICAmZm9wc19p
Yl9wcmVlbXB0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMv
YW1kZ3B1X3NtdS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211
LmgNCj4gPiBpbmRleCAxMmU2N2FkOWEzYjIuLjJiOWI5YTdiYTk3YSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgNCj4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgNCj4gPiBAQCAtNDgyLDkgKzQ4Miw2
IEBAIHN0cnVjdCBzdGJfY29udGV4dCB7DQo+ID4NCj4gPiAgICNkZWZpbmUgV09SS0xPQURfUE9M
SUNZX01BWCA3DQo+ID4NCj4gPiAtLyogVXNlZCB0byBtYXNrIHNtdSBkZWJ1ZyBtb2RlcyAqLw0K
PiA+IC0jZGVmaW5lIFNNVV9ERUJVR19IQUxUX09OX0VSUk9SCQkweDENCj4gPiAtDQo+ID4gICBz
dHJ1Y3Qgc211X2NvbnRleHQNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAg
ICAgICAgICAgICphZGV2Ow0KPiA+IEBAIC01NzMsMTEgKzU3MCw2IEBAIHN0cnVjdCBzbXVfY29u
dGV4dA0KPiA+ICAgCXN0cnVjdCBzbXVfdXNlcl9kcG1fcHJvZmlsZSB1c2VyX2RwbV9wcm9maWxl
Ow0KPiA+DQo+ID4gICAJc3RydWN0IHN0Yl9jb250ZXh0IHN0Yl9jb250ZXh0Ow0KPiA+IC0NCj4g
PiAtCS8qDQo+ID4gLQkgKiAwID0gZGlzYWJsZWQgKGRlZmF1bHQpLCBvdGhlcndpc2UgZW5hYmxl
IGNvcnJlc3BvbmRpbmcgZGVidWcNCj4gbW9kZQ0KPiA+IC0JICovDQo+ID4gLQl1aW50MzJfdCBz
bXVfZGVidWdfbWFzazsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHN0cnVjdCBpMmNfYWRhcHRlcjsN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+ID4gaW5kZXgg
NDM2MzdkNTVmZTI5Li5iMjMzZDlkNzY2ZjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdV9jbW4uYw0KPiA+IEBAIC0yNTcsNiArMjU3LDcgQEAgaW50IHNtdV9jbW5f
c2VuZF9tc2dfd2l0aG91dF93YWl0aW5nKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0KPiA+
ICAgCQkJCSAgICAgdWludDE2X3QgbXNnX2luZGV4LA0KPiA+ICAgCQkJCSAgICAgdWludDMyX3Qg
cGFyYW0pDQo+ID4gICB7DQo+ID4gKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHNtdS0+
YWRldjsNCj4gPiAgIAl1MzIgcmVnOw0KPiA+ICAgCWludCByZXM7DQo+ID4NCj4gPiBAQCAtMjcy
LDcgKzI3Myw3IEBAIGludCBzbXVfY21uX3NlbmRfbXNnX3dpdGhvdXRfd2FpdGluZyhzdHJ1Y3QN
Cj4gc211X2NvbnRleHQgKnNtdSwNCj4gPiAgIAlfX3NtdV9jbW5fc2VuZF9tc2coc211LCBtc2df
aW5kZXgsIHBhcmFtKTsNCj4gPiAgIAlyZXMgPSAwOw0KPiA+ICAgT3V0Og0KPiA+IC0JaWYgKHVu
bGlrZWx5KHNtdS0+c211X2RlYnVnX21hc2sgJg0KPiBTTVVfREVCVUdfSEFMVF9PTl9FUlJPUikg
JiYNCj4gPiArCWlmICh1bmxpa2VseShhZGV2LT5zbXVfZGVidWdfbWFzayAmDQo+IFNNVV9ERUJV
R19IQUxUX09OX0VSUk9SKSAmJg0KPiA+ICAgCSAgICByZXMgJiYgKHJlcyAhPSAtRVRJTUUpKSB7
DQo+ID4gICAJCWFtZGdwdV9kZXZpY2VfaGFsdChzbXUtPmFkZXYpOw0KPiA+ICAgCQlXQVJOX09O
KDEpOw0KPiA+IEBAIC0yOTMsMTMgKzI5NCwxNCBAQCBpbnQgc211X2Ntbl9zZW5kX21zZ193aXRo
b3V0X3dhaXRpbmcoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4gICAgKi8NCj4gPiAg
IGludCBzbXVfY21uX3dhaXRfZm9yX3Jlc3BvbnNlKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0K
PiA+ICAgew0KPiA+ICsJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFkZXY7DQo+
ID4gICAJdTMyIHJlZzsNCj4gPiAgIAlpbnQgcmVzOw0KPiA+DQo+ID4gICAJcmVnID0gX19zbXVf
Y21uX3BvbGxfc3RhdChzbXUpOw0KPiA+ICAgCXJlcyA9IF9fc211X2Ntbl9yZWcyZXJybm8oc211
LCByZWcpOw0KPiA+DQo+ID4gLQlpZiAodW5saWtlbHkoc211LT5zbXVfZGVidWdfbWFzayAmDQo+
IFNNVV9ERUJVR19IQUxUX09OX0VSUk9SKSAmJg0KPiA+ICsJaWYgKHVubGlrZWx5KGFkZXYtPnNt
dV9kZWJ1Z19tYXNrICYNCj4gU01VX0RFQlVHX0hBTFRfT05fRVJST1IpICYmDQo+ID4gICAJICAg
IHJlcyAmJiAocmVzICE9IC1FVElNRSkpIHsNCj4gPiAgIAkJYW1kZ3B1X2RldmljZV9oYWx0KHNt
dS0+YWRldik7DQo+ID4gICAJCVdBUk5fT04oMSk7DQo+ID4gQEAgLTM0Myw2ICszNDUsNyBAQCBp
bnQgc211X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzdHJ1Y3QNCj4gc211X2NvbnRleHQg
KnNtdSwNCj4gPiAgIAkJCQkgICAgdWludDMyX3QgcGFyYW0sDQo+ID4gICAJCQkJICAgIHVpbnQz
Ml90ICpyZWFkX2FyZykNCj4gPiAgIHsNCj4gPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gc211LT5hZGV2Ow0KPiA+ICAgCWludCByZXMsIGluZGV4Ow0KPiA+ICAgCXUzMiByZWc7DQo+
ID4NCj4gPiBAQCAtMzcyLDcgKzM3NSw3IEBAIGludCBzbXVfY21uX3NlbmRfc21jX21zZ193aXRo
X3BhcmFtKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0KPiA+ICAgCWlmIChyZWFkX2FyZykN
Cj4gPiAgIAkJc211X2Ntbl9yZWFkX2FyZyhzbXUsIHJlYWRfYXJnKTsNCj4gPiAgIE91dDoNCj4g
PiAtCWlmICh1bmxpa2VseShzbXUtPnNtdV9kZWJ1Z19tYXNrICYNCj4gU01VX0RFQlVHX0hBTFRf
T05fRVJST1IpICYmIHJlcykgew0KPiA+ICsJaWYgKHVubGlrZWx5KGFkZXYtPnNtdV9kZWJ1Z19t
YXNrICYNCj4gU01VX0RFQlVHX0hBTFRfT05fRVJST1IpICYmIHJlcykNCj4gPiArew0KPiA+ICAg
CQlhbWRncHVfZGV2aWNlX2hhbHQoc211LT5hZGV2KTsNCj4gPiAgIAkJV0FSTl9PTigxKTsNCj4g
PiAgIAl9DQo+ID4NCg==
