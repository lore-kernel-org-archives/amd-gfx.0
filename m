Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85F0C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 09:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D3910E2E5;
	Tue, 28 Mar 2023 09:16:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 196C210E2E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 09:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSSeWhkfFd1JqR0IpsRAiGAPmOa4y9tlqICGrRsUW0zWLxlJXve4vI+uxfqxWaquGLSYdRnTLcJpyboNdQDA1yqkD+NcGNFPi3jXwJUbJBhOfQyO2WJ/71xieXqCldGVSpyRqs5s0CNMKIp3Nl06V3cMBS2DwPY+939FcRKQKrdFdK4haOenu1V/x1pVclYg0Anp2B2wSuvXN5h1QRuxjQIyJXQhZG7udkkk8inwnob39nhy2tRO8ddlna3OXwh+ekVXYkFC/I8OSrpKLVeh2SjmLJ4Hx3DL0T3ix/TzeTBkElEJFurnjMrZNmf/EpfO9GKZxczMc3U9Pc2F9A0Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFA62YWU40uZ2mgs7eIH9kEBJRrBH3vB4ddQ0sH0c2Y=;
 b=Rel00d7xTr35O0SLJbO+HopNclIbuwj6AP0r50lCmV4lH9GR7hHrM4Y4+ogzedN9FDyoL5xTKcdZe+fF8mtdFKqshfJgn+hUk/HedWOpHSJ5BFKo6FmxtA2verp0EcHnUBLf3XiBbdlpGSXyOfmWg7Ek/NlabU6re87Een/0PLDv3LNChpTgik+Pak5IaNMVSfkuuojmn9TaJ/nk4AMN20EwU/scGgbNf6J8npSSLwTZebsKS1DIK8meX0Pkk6K+xSNziUj3dzEGMLYSqV/ZZo3cSEeR47LahxHgjppOQdKlJeKg6MmGNwvmmz1pLHU6Wf7aNjO58z38VZkfPF8peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFA62YWU40uZ2mgs7eIH9kEBJRrBH3vB4ddQ0sH0c2Y=;
 b=hTHuut/I0TsetJ2Ax/s2z6BJz0Ol5pE900N9i6VO8UrxRcDfO+r6cENJxqGMF/Xb6DoWCKYeoLe4i8CkKayR5Ii6H1zWpEBl1w8VvL2AuLhASXwU/OtHZzovMf68dJcnEnQy2nssqrhzwxg2/DFBwgt90qOe+GzwyLVzWAaY7CQ=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 09:16:54 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::fa65:a03:3c12:41ba]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::fa65:a03:3c12:41ba%4]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 09:16:54 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Yang, WenYou" <WenYou.Yang@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v2 2/3] drm/amd/pm: send the SMT enable message to pmfw
Thread-Topic: [PATCH v2 2/3] drm/amd/pm: send the SMT enable message to pmfw
Thread-Index: AQHZYH1GGZY937NsoU2BhqflKkMZFq8Oj7sAgAFaxlA=
Date: Tue, 28 Mar 2023 09:16:53 +0000
Message-ID: <CYYPR12MB8655D7CE7DBC6B68CF4C3BC49C889@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230327072437.580766-1-WenYou.Yang@amd.com>
 <20230327072437.580766-3-WenYou.Yang@amd.com>
 <841ff665-0cf1-50f5-a470-59085972a0e3@amd.com>
In-Reply-To: <841ff665-0cf1-50f5-a470-59085972a0e3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-28T09:16:51Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cc151544-8265-4ab3-844a-a6b6065aaba6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-28T09:16:51Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4f6462bf-04b1-4ca6-ae8b-154cf0069947
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DS7PR12MB6264:EE_
x-ms-office365-filtering-correlation-id: 044e5e20-866f-4d90-6048-08db2f6d2c01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4Gkb+q/5WlPo8qfMtPIe3/CT6ptx7nXB/fmatRs9dIQfj6wGILyuri2KmPQ7GW7C9S/1ofNInJ7lBy3Ioas+x/UhD84nY/JaCqBqw0fSkbj+1yJCkkJzSpc+RFKjSKQ05vqKRYqhKveQoF2fSIaDN7hBzINlfIUI/f8FU+E5k5G3nvNfxvtTpMKgNE/pIUoz+J/eCq1L502Fs/iP4jcHoMasNUIHq9GtD+/Q4FGPNK6w7XWaT9WYyIr0tc27Szf2iBJCsjm0QLa4iU4lsz0Oc7IFHJ+GeFjTil2ekXGJA9sv4whsSg7PsMEY5sybKSWRdirWFReUbkKJIxWgFEFxuQcg1enX0+XTtpR3oWxBSEkWXEEWLdOg6/2RHyjs/yA4nAEpXoSyA/RhFnjpMfXUenRKSpvL1/1nltWzufFWBiTdQdsfcmsC5Ej0Xc3HxINsgCqLrL1QLGk0vlHiH2ygsV4AznY4Owm4nktidsauo1gy8ksxfKZ4pv63hcIwnJN7CxsA86x5HwTR6ASNjcc/OBIvgL+vGEHBQ4+uQjQ2n/haNO7HNsxlnROIt0BeUyC31ZFGXqX0aFC3b/1MS90h4dp9JeiGlbnH/A68nT5TzSh/u8qYZxq8BJD5HvcKH5XnNzdUOcaGXKwI0GQLD1ngw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8655.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(186003)(316002)(110136005)(53546011)(6636002)(9686003)(26005)(6506007)(54906003)(83380400001)(7696005)(71200400001)(122000001)(478600001)(38100700002)(33656002)(38070700005)(86362001)(52536014)(8936002)(5660300002)(55016003)(921005)(41300700001)(66476007)(66446008)(4326008)(64756008)(66556008)(66946007)(76116006)(8676002)(2906002)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU1EMmVOSkJoREV2Wk5wcHkyRzhzeVRmTmlNRW0rVldtUmFLNGlEVVR2elJG?=
 =?utf-8?B?WlM2Z2I2N0tnMDloL0NhRENHTlc5ZUdQWStjUC9aSklpL2xvajNubGVveUl3?=
 =?utf-8?B?UHNoUFhHMC9vcCtiNGRvZ3g4WUlwSEJKL1BxRFV4UGpVM0lQZFFNWDI1a1N0?=
 =?utf-8?B?bjY1NHVzTmpXWE5hY0s5Y0dtcU9lNVNubjc2elVGNUFha0FLczR2d1RFRkYz?=
 =?utf-8?B?QTE3YlVmUHlHdHJ0cWVWR3l2YTJOQVBoaGtSdS9hMnMrSUFhcjJVbTQ4UUJs?=
 =?utf-8?B?OFRCR0Job2tVK29DdU1GVXZQSksyWU1nemtLVGtjYkM2eXV5M3hFc0tLZXk4?=
 =?utf-8?B?d0dFVHNJaTU4MUJlVFVmY09ncnpueGhBekxFY2ZZSDl3eFo1MUdIYUFkbnRq?=
 =?utf-8?B?cVA4emo2U3lDRXB1dTBrVC9BQVdwZU9MWnBqUzJhQUoycG1rK0VNbjU3YUhm?=
 =?utf-8?B?YWM0SElDcElkb0QrYUtmWG0zTHNHS0VCM3pSMnJLbmN4Qjd5dFlEcC9EWlhq?=
 =?utf-8?B?M1FjeWtyT09CQlY5Q3J2bUlRM1h5WmI5OGxodmQ3QkpVU0lJWWM3SVFyS0hQ?=
 =?utf-8?B?OW9BU1VIQjhKM2dtQzZoVjdINVRmdUJvZFJoNHFpdTlVV3lrSWt1aFhIUlRM?=
 =?utf-8?B?b0g2b1hFQUU0UUtJTTdqMXFXQy9JVmVtL2dTMXFMY2pMT1EzUHNlQ3EwRnUw?=
 =?utf-8?B?R0k1NzEyRnFKNGcvaEpXQ2M0VmR2cnlERmRmWUZDNEdBTi9adzBXUU9OZll6?=
 =?utf-8?B?Yk5oK0s4MjM4bDRPTWwrY0FiaXdGMklIQzRWRjRKRmF2eGl6UmQ0alRYQ3hp?=
 =?utf-8?B?cDRjM2JrZE9NRS9oN3NScUEzVS9EamxkUWdWVlArcW5SYWgvbmY5clNjaVhy?=
 =?utf-8?B?dTY3N3pjeWpMM1BaSFMvNXRoTHBGbGw5RjJtNTBQb09sMC9BYm9Hd3hoaGpl?=
 =?utf-8?B?cXByWCtqRlZrUHFBVkpVOWxvL0UyMEhjcXNZZHVadnZPVjJ0YXVUcnhqRnNQ?=
 =?utf-8?B?T3JBdUNEd1ZsWXdrMTNsUGVSb2dEOGlxaTgrdlNkK2pqYUNNaWVvbFNDUEVS?=
 =?utf-8?B?NlY5TGhEdEZWa3EvM3NsakRIUnlERkFkZVljMWtkTTVLQVlKTkVBcVMwRzhH?=
 =?utf-8?B?MzVBUm5oMVlzdXhXaE5DUHBjTnNEK0ErNDRDSEwwdURMVUp3VDQxaW4yeXBL?=
 =?utf-8?B?TFN1VHE1UjR0U0V0NENCUGY4VTAzbldiNmtScTRteXdmV1FTNzNoWWhZdTVt?=
 =?utf-8?B?MWhDNmdqNktJY2pPVkhEcy9WVHdlNk93U1diaVNyMnhyQkpLcUM3a1JLYzJt?=
 =?utf-8?B?bU1EeTJneE1wcXlOek5mRzg4M3A1T2FQUmg3RGhpNHB5WUE5ZnRZWTN3UHBy?=
 =?utf-8?B?Z0d0QjN2RUcxVjBZdlVqNjJhMnVydDJNd2puMzlyazc4OVlxbVZpZmFVcDc1?=
 =?utf-8?B?MjdBMmhqbjhvc2UwWHg5NnpvZjJ5bm1FblNXa3hKQml1Z0ZyaXZwM3FTNnlJ?=
 =?utf-8?B?d0VtdjVBSmNBSEg1LzBCYitCWmZRb3I3RENpQWE0SVk3eVhwYzBxZlVOS043?=
 =?utf-8?B?cERXT1R0ZGE3V3pJSXV6bUVKd2s4dlkvTFV2V09Fc29FV0p4V1JVZGlpZklJ?=
 =?utf-8?B?d3I5a01PSnBKV2Q1WUdSVnp4Q0l4Sm5vdjQvVGJNdnJnaGl1OFUvMDZnU21H?=
 =?utf-8?B?QVQzMDgrN0ZMQ0xuU2FUdEdtdkJ4YjNhTGdva3JROVF5bVAxU0RXZkplM2s0?=
 =?utf-8?B?VFAwWW9hSGVnb0JhQmdBRDUxN2lnQ1I1TnM4QUNPcE1abFp4R3FMNHNTUEk1?=
 =?utf-8?B?UnBNQXlrVWRnNFlRdHVHNVA2WFVtS0F6NXhHN2M0UW4vZ012RmFFa3ZCekoz?=
 =?utf-8?B?akx1QlI3ZjVySTNMdTVaMDZJQzR2eHJaL2dhQkszcnArbnNPUXNLcUcvTS9P?=
 =?utf-8?B?WE5aTnJ5YldwY3RhT1J5S0NaMlF2NEJPRWZhTnkxYTBaY2dXMi96VGp5MXFP?=
 =?utf-8?B?RGV1YkpzSnRTaFZOSk5DTlpMSWVYd3JRQ1M5VHRhTDVuTkNIbFpTYlk1SzM2?=
 =?utf-8?B?NUY2M3J6dnMxNW1IQTI0LzVFRlNEQkJ5ckc3Ty9rUUdRR3UyUlhPazZqY2xH?=
 =?utf-8?Q?XPJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044e5e20-866f-4d90-6048-08db2f6d2c01
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 09:16:53.9169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhQPt3cIhuBlbNNh93zbZeBARxXoEW6YUFYKQM6OFHEksrKDvZRQgrCceip2rUcqvwWxdnJ9gzFioaXWCBHMuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
Cc: "gpiccoli@igalia.com" <gpiccoli@igalia.com>, "Li, Ying" <YING.LI@amd.com>,
 "Liang, Richard qi" <Richardqi.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIExpam8uDQoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBh
bWQuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDI3LCAyMDIzIDg6MzQgUE0NCj4gVG86IFlh
bmcsIFdlbllvdSA8V2VuWW91LllhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsgUXVh
biwNCj4gRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1h
cmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBh
bWQuY29tPjsgTGksIFlpbmcgPFlJTkcuTElAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgZ3BpY2NvbGlAaWdhbGlhLmNvbTsgTGl1LCBLdW4NCj4gPEt1bi5MaXUy
QGFtZC5jb20+OyBMaWFuZywgUmljaGFyZCBxaSA8UmljaGFyZHFpLkxpYW5nQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBkcm0vYW1kL3BtOiBzZW5kIHRoZSBTTVQgZW5h
YmxlIG1lc3NhZ2UgdG8NCj4gcG1mdw0KPiANCj4gDQo+IA0KPiBPbiAzLzI3LzIwMjMgMTI6NTQg
UE0sIFdlbnlvdSBZYW5nIHdyb3RlOg0KPiA+IFdoZW4gdGhlIENQVSBTTVQgc3RhdHVzIGlzIGNo
YW5nZWQgaW4gdGhlIGZseSwgc2VudCB0aGUgU01UIGVuYWJsZQ0KPiA+IG1lc3NhZ2UgdG8gcG1m
dyB0byBub3RpZnkgaXQgdGhhdCB0aGUgU01UIHN0YXR1cyBjaGFuZ2VkLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogV2VueW91IFlhbmcgPFdlbllvdS5ZYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyAgICAgfCAzOQ0K
PiArKysrKysrKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L2luYy9hbWRncHVfc211LmggfCAgNyArKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDQ2IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L2FtZGdwdV9zbXUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9h
bWRncHVfc211LmMNCj4gPiBpbmRleCBiNWQ2NDc0OTk5MGUuLmViNGM0OWYzODI5MiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+ID4gQEAg
LTIyLDYgKzIyLDcgQEANCj4gPg0KPiA+ICAgI2RlZmluZSBTV1NNVV9DT0RFX0xBWUVSX0wxDQo+
ID4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2Zp
cm13YXJlLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ID4NCj4gPiBAQCAtNTQs
NiArNTUsOCBAQA0KPiA+ICAgI3VuZGVmIHByX2luZm8NCj4gPiAgICN1bmRlZiBwcl9kZWJ1Zw0K
PiA+DQo+ID4gK2V4dGVybiBzdHJ1Y3QgcmF3X25vdGlmaWVyX2hlYWQgc210X25vdGlmaWVyX2hl
YWQ7DQo+ID4gKw0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRfcG1fZnVuY3Mgc3dzbXVf
cG1fZnVuY3M7DQo+ID4gICBzdGF0aWMgaW50IHNtdV9mb3JjZV9zbXVjbGtfbGV2ZWxzKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LA0KPiA+ICAgCQkJCSAgIGVudW0gc211X2Nsa190eXBlIGNsa190
eXBlLA0KPiA+IEBAIC02OSw2ICs3Miw5IEBAIHN0YXRpYyBpbnQgc211X3NldF9mYW5fc3BlZWRf
cnBtKHZvaWQgKmhhbmRsZSwNCj4gdWludDMyX3Qgc3BlZWQpOw0KPiA+ICAgc3RhdGljIGludCBz
bXVfc2V0X2dmeF9jZ3BnKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGVuYWJsZWQpOw0K
PiA+ICAgc3RhdGljIGludCBzbXVfc2V0X21wMV9zdGF0ZSh2b2lkICpoYW5kbGUsIGVudW0gcHBf
bXAxX3N0YXRlDQo+ID4gbXAxX3N0YXRlKTsNCj4gPg0KPiA+ICtzdGF0aWMgaW50IHNtdF9ub3Rp
Zmllcl9jYWxsYmFjayhzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLA0KPiA+ICsJCQkJIHVuc2ln
bmVkIGxvbmcgYWN0aW9uLCB2b2lkICpkYXRhKTsNCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IHNt
dV9zeXNfZ2V0X3BwX2ZlYXR1cmVfbWFzayh2b2lkICpoYW5kbGUsDQo+ID4gICAJCQkJICAgICAg
IGNoYXIgKmJ1ZikNCj4gPiAgIHsNCj4gPiBAQCAtNjQ3LDYgKzY1Myw4IEBAIHN0YXRpYyBpbnQg
c211X2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQ0KPiA+ICAgCWFkZXYtPnBvd2VycGxheS5wcF9o
YW5kbGUgPSBzbXU7DQo+ID4gICAJYWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzID0gJnN3c211X3Bt
X2Z1bmNzOw0KPiA+DQo+ID4gKwlzbXUtPm5iLm5vdGlmaWVyX2NhbGwgPSBzbXRfbm90aWZpZXJf
Y2FsbGJhY2s7DQo+ID4gKw0KPiA+ICAgCXIgPSBzbXVfc2V0X2Z1bmNzKGFkZXYpOw0KPiA+ICAg
CWlmIChyKQ0KPiA+ICAgCQlyZXR1cm4gcjsNCj4gPiBAQCAtMTEwNSw2ICsxMTEzLDggQEAgc3Rh
dGljIGludCBzbXVfc3dfaW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gICAJaWYgKCFzbXUtPnBwdF9m
dW5jcy0+Z2V0X2Zhbl9jb250cm9sX21vZGUpDQo+ID4gICAJCXNtdS0+YWRldi0+cG0ubm9fZmFu
ID0gdHJ1ZTsNCj4gPg0KPiA+ICsJcmF3X25vdGlmaWVyX2NoYWluX3JlZ2lzdGVyKCZzbXRfbm90
aWZpZXJfaGVhZCwgJnNtdS0+bmIpOw0KPiA+ICsNCj4gDQo+IEFzIG1lbnRpb25lZCBiZWZvcmUs
IGl0J3Mgbm90IGEgYmxpbmQgcmVnaXN0cmF0aW9uIGZvciBhbnkgQVNJQy4gVGhpcyBzaG91bGQN
Cj4gb25seSBiZSBkb25lIGJ5IHRoZSBBU0lDcyB3aGljaCBhcmUgaW50ZXJlc3RlZCBpbiB0aGUg
bm90aWZpY2F0aW9uIGFuZCBub3QgaGVyZS4NCj4gU28gdGhpcyBzaG91bGQgYmUgc29tZXdoZXJl
IGluc2lkZSB2YW5nb2doX3NldF9wcHRfZnVuY3Mgb3IgcGFydCBvZiBhDQo+IHNvZnR3YXJlIGlu
aXQgY2FsbGJhY2sgbGlrZSB2YW5nb2doX2luaXRfc21jX3RhYmxlcy4NCj4gDQo+IFRoYW5rcywN
Cj4gTGlqbw0KDQpZb3UgYXJlIHJpZ2h0LCAgb25seSBWYW5nb2doIFBNRlcgd2lsbCBoYW5kbGUg
dGhlICBDQ0xLIFBEIExpbWl0IHVwZGF0ZSByZXF1ZXN0LiANCg0KSGkgQFlhbmcsIFdlbllvdQ0K
DQpJdCB3aWxsIG5lZWQgdG8gbGltaXQgdGhlIHVwZGF0ZSBtZXNzYWdlIHdpdGhpbiB0aGUgVmFu
Z29naCBBc2ljLg0KDQo+IA0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+DQo+ID4gQEAg
LTExMjIsNiArMTEzMiw5IEBAIHN0YXRpYyBpbnQgc211X3N3X2Zpbmkodm9pZCAqaGFuZGxlKQ0K
PiA+DQo+ID4gICAJc211X2ZpbmlfbWljcm9jb2RlKHNtdSk7DQo+ID4NCj4gPiArCWlmIChzbXUt
Pm5iLm5vdGlmaWVyX2NhbGwgIT0gTlVMTCkNCj4gPiArCQlyYXdfbm90aWZpZXJfY2hhaW5fdW5y
ZWdpc3Rlcigmc210X25vdGlmaWVyX2hlYWQsICZzbXUtDQo+ID5uYik7DQo+ID4gKw0KPiA+ICAg
CXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+DQo+ID4gQEAgLTMyNDEsMyArMzI1NCwyOSBAQCBpbnQg
c211X3NlbmRfaGJtX2JhZF9jaGFubmVsX2ZsYWcoc3RydWN0DQo+ID4gc211X2NvbnRleHQgKnNt
dSwgdWludDMyX3Qgc2l6ZSkNCj4gPg0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICB9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgaW50IHNtdV9zZXRfY3B1X3NtdF9lbmFibGUoc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUsIGJvb2wNCj4gPiArZW5hYmxlKSB7DQo+ID4gKwlpbnQgcmV0ID0gLUVJTlZBTDsN
Cj4gPiArDQo+ID4gKwlpZiAoc211LT5wcHRfZnVuY3MgJiYgc211LT5wcHRfZnVuY3MtPnNldF9j
cHVfc210X2VuYWJsZSkNCj4gPiArCQlyZXQgPSBzbXUtPnBwdF9mdW5jcy0+c2V0X2NwdV9zbXRf
ZW5hYmxlKHNtdSwgZW5hYmxlKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgaW50IHNtdF9ub3RpZmllcl9jYWxsYmFjayhzdHJ1Y3Qgbm90aWZp
ZXJfYmxvY2sgKm5iLA0KPiA+ICsJCQkJIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpkYXRh
KSB7DQo+ID4gKwlzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9IGNvbnRhaW5lcl9vZihuYiwgc3Ry
dWN0IHNtdV9jb250ZXh0LCBuYik7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCXNtdSA9
IGNvbnRhaW5lcl9vZihuYiwgc3RydWN0IHNtdV9jb250ZXh0LCBuYik7DQo+ID4gKw0KPiA+ICsJ
cmV0ID0gc211X3NldF9jcHVfc210X2VuYWJsZShzbXUsIGFjdGlvbiA9PSBTTVRfRU5BQkxFRCk7
DQo+ID4gKw0KPiA+ICsJZGV2X2RiZyhzbXUtPmFkZXYtPmRldiwgImZhaWxlZCB0byBzZXQgY2Ns
a19wZF9saW1pdCBmb3INCj4gU01UICVzYWJsZWQ6ICVkXG4iLA0KPiA+ICsJCWFjdGlvbiA9PSBT
TVRfRU5BQkxFRCA/CSJlbiIgOiAiZGlzIiwgcmV0KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0
ID8gTk9USUZZX0JBRCA6IE5PVElGWV9PSzsgfQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211LmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdwdV9zbXUuaA0KPiA+IGluZGV4IDA5NDY5Yzc1MGE5Ni4u
NGQ1MWFjNWVjOGJhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvaW5jL2FtZGdwdV9zbXUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvaW5jL2FtZGdwdV9zbXUuaA0KPiA+IEBAIC01NjYsNiArNTY2LDggQEAgc3RydWN0IHNtdV9j
b250ZXh0DQo+ID4NCj4gPiAgIAlzdHJ1Y3QgZmlybXdhcmUgcHB0YWJsZV9maXJtd2FyZTsNCj4g
Pg0KPiA+ICsJc3RydWN0IG5vdGlmaWVyX2Jsb2NrIG5iOw0KPiA+ICsNCj4gPiAgIAl1MzIgcGFy
YW1fcmVnOw0KPiA+ICAgCXUzMiBtc2dfcmVnOw0KPiA+ICAgCXUzMiByZXNwX3JlZzsNCj4gPiBA
QCAtMTM1NCw2ICsxMzU2LDExIEBAIHN0cnVjdCBwcHRhYmxlX2Z1bmNzIHsNCj4gPiAgIAkgKiBA
aW5pdF9wcHRhYmxlX21pY3JvY29kZTogUHJlcGFyZSB0aGUgcHB0YWJsZSBtaWNyb2NvZGUgdG8N
Cj4gdXBsb2FkIHZpYSBQU1ANCj4gPiAgIAkgKi8NCj4gPiAgIAlpbnQgKCppbml0X3BwdGFibGVf
bWljcm9jb2RlKShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7DQo+ID4gKw0KPiA+ICsJLyoqDQo+
ID4gKwkgKiBAc2V0X2NwdV9zbXRfZW5hYmxlOiBTZXQgdGhlIENQVSBTTVQgc3RhdHVzLg0KPiA+
ICsJICovDQo+ID4gKwlpbnQgKCpzZXRfY3B1X3NtdF9lbmFibGUpKHN0cnVjdCBzbXVfY29udGV4
dCAqc211LCBib29sDQo+IHNtdF9lbmFibGUpOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgdHlwZWRl
ZiBlbnVtIHsNCg==
