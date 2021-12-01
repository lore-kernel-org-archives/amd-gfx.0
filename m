Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91612C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6A66EA09;
	Wed,  1 Dec 2021 10:38:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA446EA09
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F39ZVhFmCpYf0pZT1ce9ZuopfdH1KIv0bUj7sR4ViPjVUO0FVtyHZsU3gh8eGnjnkokNYOof3IK0Mbdyo8v1Ck+mJiDj2tkd8Z+eRasF8WGoYtA6YhoPBumDeiyWAUhgogW4vj7UQC3/DfzkrggjF4r7qp1liCc348++R5TymMrE7/mpd50+HKgWXPbhXtC1Jkcji2O4cQDEfQBGF8h1YdcpP2/jynOESRNew9EbqOQgD1LJCWSkLBVIzqxhBeJcEDx+zZGWGFm0crRfwk1Mrn6h51UxYqECNr1dBwveq75OVMEHBD5O8KOJzL5Ht2o59yTn6tVw/p6DW2o6yHmsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH0bxlxqT1rqvq3aiZQHV/aN3ghE0kP9cPU8GFgvAnU=;
 b=BunZ+UFYnJjOWE/z07qiSBuwpugPOdBRSkVyyU0mO/b2l5bZo71VzKg/WhggRFFdy11I3jY4BidFCSmRGJjMWDEJsfHC68cvbYSSYktwczwZ7+15ggjeM30L50zqGaNbvce2F8YsGy7j1Pdjm79w2GJBeO60W8KpkGuTzhVsMKdil3gqStfCJcnka2TxhMfdAGFfXH6i1Yfs1M6n7i/O32O9WHNXM+HabraZuCxXo4Jr00YfSeFMs7+cKt3z+HWzv8hN6JcPj7Cp2B5TfPi89v7LBVxjy6TiXyJ7D98LUgWAZGkiQrAOQeI5Rs/k4eiNS8Lk1f9WZpnmXfOkd6OCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH0bxlxqT1rqvq3aiZQHV/aN3ghE0kP9cPU8GFgvAnU=;
 b=nUgU25gRjlV46+pgJHlXpM5l43YDZ4BwlI/TvHZ5zdbk5+Zdrdg1Pf/E+/1nLQMHoroWs2KzS77n0hLp+BSo+ZPHCjoc8Jgc78mxzJwd7iF2NirHYccxiE+Iuu66BdAgHcSsWrNdhxXB1v21iMVa0D4M7Dz/k+CTrHvxOGeH/LY=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Wed, 1 Dec 2021 10:38:13 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 10:38:12 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Topic: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Index: AQHX5pVcc3LghN55bkmOkF3w2Pkmd6wdY7IAgAAJ63A=
Date: Wed, 1 Dec 2021 10:38:12 +0000
Message-ID: <DM6PR12MB42508C1A0E5EFA6D522C02D0FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <1f8f87f7-acac-acb7-5e1c-8baa643de7b3@amd.com>
In-Reply-To: <1f8f87f7-acac-acb7-5e1c-8baa643de7b3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-01T10:38:09Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7efaa244-0677-4c69-9d83-4ec868ab45ce;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-01T10:38:09Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: bbe294d6-00e5-4221-8564-ffc6dac6d71d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 706c807c-dc48-467a-c90f-08d9b4b6ad01
x-ms-traffictypediagnostic: DM6PR12MB3516:
x-microsoft-antispam-prvs: <DM6PR12MB351614E1D602BB78309DD96BFB689@DM6PR12MB3516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TYQWB+/eB8s6KFReQUpfu06t0Ftpy3G/TfKIZbyAxbdcRvOvSMiGNLYDo64vhjIgQJ+2RVCQU8DYrHPFF725K2yaLYjAywjmyshW/D1HhbXM6TG1/43IzyeIWsA0lkOOPqXKZpRgUicx3yCRP4v+suLTOIG12iXv8TtnaP7sXW86T78HGzzd7oWq/5kLhIsvyOpUNvTZdWBiU92yhqofEYPVH0lKYpFLlPyvWRKVCKkNYU0rxrtm4a6k0ZVLx6XXP6NKdZwRwbIrjd+Ds50VwK5wSXbGSZmm//xOPvt9lnQQgeJcQLTW6TvVndaV/SGJ24x4E5rWK8hloSCIUXJVhHPklxeMzatrNMntsqlHCY5Bp6bk9J22MONjdTqTMEpDWTAdNDt4VBsxUJrR79064np6cDmG6AIDsSsaKsmoDTOwatxFOYhi0C6HLg9AmGgNW47/o9D4VC9NkHI0LAIidvWXCjTTYZAerkbRINux5DXRX607024Js7iwaGNAo9eUQKYtlVx4rrlheS+8v7/XalFvzySP9JA7eJeGcOv5l8yP7Fi8DvPy3A2bvdmCEdt2oBbPpIBCgybVd4h9+8tNYc+8yE1TryxOv78nGtprVSYFhD6NCiXXeiv11ydR00I9BLTPkWYQxYAhLkvCmEsnI6+MOtz1nyjBoipQ7WA1AVjFt3yJEaiib9UacUgYuoOJUZlBTxVvflyuOXWah/GacA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(52536014)(316002)(83380400001)(122000001)(508600001)(26005)(54906003)(7696005)(186003)(66946007)(55016003)(5660300002)(86362001)(4326008)(71200400001)(66556008)(64756008)(66446008)(66476007)(38100700002)(6506007)(8676002)(110136005)(76116006)(8936002)(33656002)(9686003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVlkK2FNL3JGQWhzZ2hxWWY0bEw2U2xDZ3pRb0hUaUdwanI2NUhPa0tPRVc3?=
 =?utf-8?B?cmdRT29SMU9mQXQ5Rk9RVnVwbThwcmZIV0NGUE94VnRrSWFOdFVVS3lNTnJ0?=
 =?utf-8?B?TlpXakk0LzlzK24vOEZjbitsNk9admFTRTVEYUNBTHNEMmt1Mm11Vy9JMkFp?=
 =?utf-8?B?RVkrNktUb3NkTWZLa0drNEcyLzdoeWNwZllFbFlWV3FEVGMzVU5MQWROeHFr?=
 =?utf-8?B?aUNQR2FCOVhVTjZRTUwranh6ZU9hRHovcEt2bTgzWGoySkRlb3ZCbURBbGhr?=
 =?utf-8?B?OCtFQmxaSnQ2WDAwem9ncDFNVys4ZjBTM1BPd0xzWkpJck5LM3JxcHZpcURD?=
 =?utf-8?B?QmhXN0ZTdWxlSkVJSDdrUkQrdWtwTldhbzlxWHMyd1RsSXVISmdwQ0dvOGpm?=
 =?utf-8?B?ZUtlK3NsZDU4aFNBL3ZSNDN5N3lERTFDbHJkZ204MzQ4YkxZdllva2JYdUFL?=
 =?utf-8?B?NU1aL0xtYTdkQnAwNFMrbG5oVDI0VkpleHZRRkRMV2VCMTh6YWo0OXhDa0tK?=
 =?utf-8?B?Mi9uUGNCa2JnTGFndWtMcVdWUFZYeEV2L2E1Tlk4RW81MlFSbUp1UlhySWlD?=
 =?utf-8?B?aVBqcE1Lek1GL3NCUDN5dGZLanhwQkZ1YlZBRDV1eWFQV1c1U3k1M2VPWktm?=
 =?utf-8?B?eksrazdDbE5zMmgyZWUzdmdkOHZTQW54YmNuWlIzZTM5cmY4a3ZWUFpuaEE0?=
 =?utf-8?B?TTlkbFNHeEdCR3hFNi9ud2F4RFB5VW85TkJqZ0JoT0UxMmZrcERvYTJNaHho?=
 =?utf-8?B?VEIrQnp4aGN6RWRYNXRrcXl1NmpralVZdjM2ZXRVbUxVc1VtUC96V1FUb2ZE?=
 =?utf-8?B?MUlxQzNtUlhDSGNxcm82WlNwVUQ4dC9VOFhObTNrclNYYkVFTG1VTlpRZnlw?=
 =?utf-8?B?clNMRHIwbmpoWHFVdkdvWkRpaXd2RS95dHdmRkxuQ0tqeUUzSys0NEdjMjJh?=
 =?utf-8?B?VlNKMzlLQ29sL1QzOEVPM3B4Y2VKenlvd29ZYkdISlpLY1loVXFKK3RNQk93?=
 =?utf-8?B?QkpHNnBXTW1jaXdDeGJiTXBYNnV1MXpialVIT0F5QTRQUXYxelRFcDdKQWxC?=
 =?utf-8?B?Uk9GS1Uxb21RTURZREFEV09NNWRmRCtMb0FlbEJKTlNuWDNXRlQ2dGc5djBz?=
 =?utf-8?B?b29aekcyZHh1VEY2Z2NtY285RFhxSjBZUnAyOTZtcDRHMDVHS2UwczZSRUtw?=
 =?utf-8?B?WFpGVHZvTFdIU0dmMXJka1hJaHRGSGRBcHZTTlQxSjU2Z0c0WGNMdU02bVNO?=
 =?utf-8?B?ODUwMkg1U0pMZmpBOVkzK1d1dXk3ZXczQXZ3RW4zVktVMG1URXlLUzFUcVRC?=
 =?utf-8?B?V0pCZzNtSmRUVmI1SmZUT0llTEJtanNTeXN1N04rRFdYaGlnb0tRTHJkN0l3?=
 =?utf-8?B?eDJCUEpaeDBTOVVRV0hldi92V1Q2K2lvaXdNM2RlZVRQVDNpbmsrOHBIOU9u?=
 =?utf-8?B?djhNUW0zbkhsOXdITmtzSE9xcXZlU1RWdjdOeDJQN0RWN002MzJlemtZeHNS?=
 =?utf-8?B?UjlRbXlibmlmY0NnbmtodjkzbSsxQ3dtKzlLWlZKcEgyclV1eEtLV0xaczZ0?=
 =?utf-8?B?SkRONnk3bVlBVnpqS3F1dERrQm1Dd2RQWWNPaFQyalZqekNWdUs1UTA2Qkcr?=
 =?utf-8?B?ZHpYOVIzNUxWY2xaeFpwc3Y5MUVRMC9wK0M0Y0tuSXFzaWlNQmNaLzcvbjFt?=
 =?utf-8?B?SkhkaThEWVd2TDVJV0p1RnBnMzdRbllmUElaL0psbHppQnRDYXVFcnB0MkxG?=
 =?utf-8?B?emJyNm1hYWJRazJvVWJ1dmFGQlc0Q0RvWlNiTVlLK2NNYjdlYXhkYVgxNjhE?=
 =?utf-8?B?V0Y1SVJLWm1SM1dOQlE3cVFTNnRuRUtlK21QZUVFNFhWSCtoWjFhUXdYM0Zp?=
 =?utf-8?B?REY5R2Nick0xRmlOenhGdDRLZW42UVJFc3JlNSs1R2dRMzhXNGpFZFMxZ0NO?=
 =?utf-8?B?cmlzaGtoVXh3V2RLdmE3RnA0MkZiUDJtM1VlRXc0dU92WkVaSnBXUTNrODA4?=
 =?utf-8?B?V2d5YnR6STl6Qi9TaklPa08vVDNmUFJGalprLzg1cDlIM3pFSXp3TEM4UXlQ?=
 =?utf-8?B?Z1drVjYrSmNydlR1QnNlcG45TXJpTXNGZE1DdEtNbWVhaWJXbzhZa2RabGJ5?=
 =?utf-8?B?VFVGM3k0amxJQ040bnVUM3BoWWthdGRoVG56Nk1PSmR5dFl5bkVudlRZdXA0?=
 =?utf-8?Q?yh+g2xfYi07lWT9a377IfZM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706c807c-dc48-467a-c90f-08d9b4b6ad01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 10:38:12.7476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6Nw3WIB2nk8GQf4B+//oOFSdM0Hm06RJ88rFfcNzMjDLMgTkbNv6YNEoIQBEQzQnZMiCFFR2LLvkyqY6wHB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
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
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+U2VudDogV2VkbmVz
ZGF5LCBEZWNlbWJlciAxLCAyMDIxIDU6NDcgUE0NCj5UbzogWXUsIExhbmcgPExhbmcuWXVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj48UmF5Lkh1YW5n
QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBzdXBwb3J0IHRvIFNNVSBkZWJ1
ZyBvcHRpb24NCj4NCj4NCj4NCj5PbiAxMi8xLzIwMjEgMjo1NCBQTSwgTGFuZyBZdSB3cm90ZToN
Cj4+IFRvIG1haW50YWluIHN5c3RlbSBlcnJvciBzdGF0ZSB3aGVuIFNNVSBlcnJvcnMgb2NjdXJy
ZWQsIHdoaWNoIHdpbGwNCj4+IGFpZCBpbiBkZWJ1Z2dpbmcgU01VIGZpcm13YXJlIGlzc3Vlcywg
YWRkIFNNVSBkZWJ1ZyBvcHRpb24gc3VwcG9ydC4NCj4+DQo+PiBJdCBjYW4gYmUgZW5hYmxlZCBv
ciBkaXNhYmxlZCB2aWEgYW1kZ3B1X3NtdV9kZWJ1ZyBkZWJ1Z2ZzIGZpbGUuIFdoZW4NCj4+IGVu
YWJsZWQsIGl0IG1ha2VzIFNNVSBlcnJvcnMgZmF0YWwuDQo+PiBJdCBpcyBkaXNhYmxlZCBieSBk
ZWZhdWx0Lg0KPj4NCj4+ID09IENvbW1hbmQgR3VpZGUgPT0NCj4+DQo+PiAxLCBlbmFibGUgU01V
IGRlYnVnIG9wdGlvbg0KPj4NCj4+ICAgIyBlY2hvIDEgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkv
MC9hbWRncHVfc211X2RlYnVnDQo+Pg0KPj4gMiwgZGlzYWJsZSBTTVUgZGVidWcgb3B0aW9uDQo+
Pg0KPj4gICAjIGVjaG8gMCA+IC9zeXMva2VybmVsL2RlYnVnL2RyaS8wL2FtZGdwdV9zbXVfZGVi
dWcNCj4+DQo+PiB2MzoNCj4+ICAgLSBVc2UgZGVidWdmc19jcmVhdGVfYm9vbCgpLihDaHJpc3Rp
YW4pDQo+PiAgIC0gUHV0IHZhcmlhYmxlIGludG8gc211X2NvbnRleHQgc3RydWN0Lg0KPj4gICAt
IERvbid0IHJlc2VuZCBjb21tYW5kIHdoZW4gdGltZW91dC4NCj4+DQo+PiB2MjoNCj4+ICAgLSBS
ZXNlbmQgY29tbWFuZCB3aGVuIHRpbWVvdXQuKExpam8pDQo+PiAgIC0gVXNlIGRlYnVnZnMgZmls
ZSBpbnN0ZWFkIG9mIG1vZHVsZSBwYXJhbWV0ZXIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGFu
ZyBZdSA8bGFuZy55dUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgICAgICAgIHwgMyArKysNCj4+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5oICAgICAgICAgICAgfCA1ICsrKysrDQo+PiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jIHwgMiArKw0K
Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYyAgICAgICAgICAgICB8
IDggKysrKysrKy0NCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYw0KPj4gaW5kZXggMTY0ZDZhOWU5ZmJiLi44NmNkODg4Yzc4MjIgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+PiBAQCAt
MTYxOCw2ICsxNjE4LDkgQEAgaW50IGFtZGdwdV9kZWJ1Z2ZzX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UNCj4qYWRldikNCj4+ICAgCWlmICghZGVidWdmc19pbml0aWFsaXplZCgpKQ0KPj4gICAJ
CXJldHVybiAwOw0KPj4NCj4+ICsJZGVidWdmc19jcmVhdGVfYm9vbCgiYW1kZ3B1X3NtdV9kZWJ1
ZyIsIDA2MDAsIHJvb3QsDQo+PiArCQkJCSAgJmFkZXYtPnNtdS5zbXVfZGVidWdfbW9kZSk7DQo+
PiArDQo+PiAgIAllbnQgPSBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJhbWRncHVfcHJlZW1wdF9pYiIs
IDA2MDAsIHJvb3QsIGFkZXYsDQo+PiAgIAkJCQkgICZmb3BzX2liX3ByZWVtcHQpOw0KPj4gICAJ
aWYgKElTX0VSUihlbnQpKSB7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9pbmMvYW1kZ3B1X3NtdS5oDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdw
dV9zbXUuaA0KPj4gaW5kZXggZjczOGY3ZGMyMGM5Li41MGRiZjU1OTRhOWQgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgNCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUuaA0KPj4gQEAgLTU2OSw2ICs1Njks
MTEgQEAgc3RydWN0IHNtdV9jb250ZXh0DQo+PiAgIAlzdHJ1Y3Qgc211X3VzZXJfZHBtX3Byb2Zp
bGUgdXNlcl9kcG1fcHJvZmlsZTsNCj4+DQo+PiAgIAlzdHJ1Y3Qgc3RiX2NvbnRleHQgc3RiX2Nv
bnRleHQ7DQo+PiArCS8qDQo+PiArCSAqIFdoZW4gZW5hYmxlZCwgaXQgbWFrZXMgU01VIGVycm9y
cyBmYXRhbC4NCj4+ICsJICogKDAgPSBkaXNhYmxlZCAoZGVmYXVsdCksIDEgPSBlbmFibGVkKQ0K
Pj4gKwkgKi8NCj4+ICsJYm9vbCBzbXVfZGVidWdfbW9kZTsNCj4+ICAgfTsNCj4+DQo+PiAgIHN0
cnVjdCBpMmNfYWRhcHRlcjsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KPj4gaW5kZXggNmU3ODFjZWU4YmI2Li5kMzc5
N2EyZDY0NTEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTEzL2FsZGViYXJhbl9wcHQuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4+IEBAIC0xOTE5LDYgKzE5MTksOCBAQCBzdGF0aWMg
aW50IGFsZGViYXJhbl9tb2RlMl9yZXNldChzdHJ1Y3QNCj5zbXVfY29udGV4dCAqc211KQ0KPj4g
ICBvdXQ6DQo+PiAgIAltdXRleF91bmxvY2soJnNtdS0+bWVzc2FnZV9sb2NrKTsNCj4+DQo+PiAr
CUJVR19PTih1bmxpa2VseShzbXUtPnNtdV9kZWJ1Z19tb2RlKSAmJiByZXQpOw0KPj4gKw0KPlRo
aXMgaHVuayBjYW4gYmUgc2tpcHBlZCB3aGlsZSBzdWJtaXR0aW5nLiBJZiB0aGlzIGZhaWxzLCBH
UFUgcmVzZXQgd2lsbCBmYWlsIGFuZA0KPmFtZGdwdSB3b24ndCBjb250aW51ZS4NCg0KT2ssIHdl
IGRvbid0IGhhbmRsZSBzdWNoIGNhc2VzLg0KDQo+DQo+PiAgIAlyZXR1cm4gcmV0Ow0KPj4gICB9
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Nt
bi5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+PiBpbmRl
eCAwNDhjYTE2NzM4NjMuLjliZTAwNWViNDI0MSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdV9jbW4uYw0KPj4gQEAgLTM0OSwxNSArMzQ5LDIxIEBAIGludCBzbXVfY21u
X3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHN0cnVjdA0KPnNtdV9jb250ZXh0ICpzbXUsDQo+PiAg
IAkJX19zbXVfY21uX3JlZ19wcmludF9lcnJvcihzbXUsIHJlZywgaW5kZXgsIHBhcmFtLCBtc2cp
Ow0KPj4gICAJCWdvdG8gT3V0Ow0KPj4gICAJfQ0KPj4gKw0KPj4gICAJX19zbXVfY21uX3NlbmRf
bXNnKHNtdSwgKHVpbnQxNl90KSBpbmRleCwgcGFyYW0pOw0KPj4gICAJcmVnID0gX19zbXVfY21u
X3BvbGxfc3RhdChzbXUpOw0KPj4gICAJcmVzID0gX19zbXVfY21uX3JlZzJlcnJubyhzbXUsIHJl
Zyk7DQo+PiAtCWlmIChyZXMgIT0gMCkNCj4+ICsJaWYgKHJlcyAhPSAwKSB7DQo+PiAgIAkJX19z
bXVfY21uX3JlZ19wcmludF9lcnJvcihzbXUsIHJlZywgaW5kZXgsIHBhcmFtLCBtc2cpOw0KPj4g
KwkJZ290byBPdXQ7DQo+DQo+TmV4dCBzdGVwIGlzIHJlYWRpbmcgc211IHBhcmFtZXRlciByZWdp
c3RlciB3aGljaCBpcyBoYXJtbGVzcyBhcyByZWFkaW5nDQo+cmVzcG9uc2UgcmVnaXN0ZXIgYW5k
IGl0J3Mgbm90IGNsZWFyIG9uIHJlYWQuIFRoaXMgZ290byBhbHNvIG1heSBiZSBza2lwcGVkLg0K
DQpJIGp1c3QgdGhpbmsgdGhhdCBkb2VzIHNvbWUgZXh0cmEgd29yay4gV2UgZG9u4oCZdCB3YW50
IHRvIHJlYWQgcmVzcG9uc2UgcmVnaXN0ZXIuDQpUaGlzIGdvdG8gbWFrZXMgZXJyb3IgaGFuZGxp
bmcgbW9yZSBjbGVhci4NCg0KUmVnYXJkcywNCkxhbmcNCg0KPlRoYW5rcywNCj5MaWpvDQo+DQo+
PiArCX0NCj4+ICAgCWlmIChyZWFkX2FyZykNCj4+ICAgCQlzbXVfY21uX3JlYWRfYXJnKHNtdSwg
cmVhZF9hcmcpOw0KPj4gICBPdXQ6DQo+PiAgIAltdXRleF91bmxvY2soJnNtdS0+bWVzc2FnZV9s
b2NrKTsNCj4+ICsNCj4+ICsJQlVHX09OKHVubGlrZWx5KHNtdS0+c211X2RlYnVnX21vZGUpICYm
IHJlcyk7DQo+PiArDQo+PiAgIAlyZXR1cm4gcmVzOw0KPj4gICB9DQo+Pg0KPj4NCg==
