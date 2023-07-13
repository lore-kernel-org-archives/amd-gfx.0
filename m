Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37944C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 14:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AC110E6ED;
	Thu, 13 Jul 2023 14:44:59 +0000 (UTC)
Received: from outbound.mail.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6689410E6ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 14:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh5bFQoqs5i7CA5403XJJ0f7a0QVcXQj5A/q7B+uZJtgUcvCnXewigSqoH1AutiXDUz5doWwjhZfKwCMLOLlwLYK1jQfTx03daSgYM9aCnYSiOwXY6N8yEJGVHSuMaOwIDFHXI0043eFNChOIyrPhH/qg9g7HIc3IsjoSg4R55b4KU0E3a7JwTt1bEOukIJyZDFEreFlrX3neSCucd9CJKSmnhtbhNnXE0lJ1JWTo5r4tExwxEeaTPUOxiZb9ZJl+opSOsIHrVNOL4dBgtyW7n3mXJqR4FlsUUJBUBHUZ3UtNEX59bPV6MYjTUEqHOsJpOnsqBvQ8oZQKvh+X18ArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Btkdp3RvcAoDUOnhrEFZQJE6PK2q0r73FOE0wzaybBo=;
 b=kRDuR0ixmbXNfjg9U0RKp9hDORo/at0YsuaM48NuTien42KT5jWV0mltJoiLDWmzdYEFTih+N5N/zDlzE+LyicGSQT35JcInUQ31AvOWRKDvTKJum60UKgAGe/Eud628XmxJ33XBG6JvCKVNxezZQk+f5ee+CuA2JTRc9Czd481KVXOzD/5v+kjSIRDfj5QPCRyZDLU91FDaGvT4hg+yb8bfgWWklGCVO6u7rI3WSmJhX9s8O1XTAYsLhMIXXFlRKJpCdg4XCUUucyyFqgo/JlDkLlN47fELPdgkuq8bSKY8tAIhE+Xi7M351ZtPyScoPYMsWHBJ4tnieOtQqaFugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Btkdp3RvcAoDUOnhrEFZQJE6PK2q0r73FOE0wzaybBo=;
 b=pTp+9ckJWVp+zhafXCj8Kdgygr83NvPABwcblWY2tWkWPd2i93vxzIBfVP9NWJDoOdY18wBVlgA5K2i3kc0ahTkNemp/PwaODRdrYc1p+I8J7+JBL1iFjNdm51+lBgOACb7fuR7yvIxdU3Zm209WQ+/LYoVVBEklQMPqmDxHVkc=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 14:44:51 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::f0ee:c42e:fba1:4f02]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::f0ee:c42e:fba1:4f02%3]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 14:44:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: make mclk consistent for smu 13.0.7
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: make mclk consistent for smu 13.0.7
Thread-Index: AQHZnhYDXO9iyPZO3kC3Zir1ftI33K+38ccAgAACrgA=
Date: Thu, 13 Jul 2023 14:44:51 +0000
Message-ID: <DM4PR12MB51657DCCCFF14F3DC1B5F8698E37A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230613164148.2631132-1-alexander.deucher@amd.com>
 <20230613164148.2631132-2-alexander.deucher@amd.com>
 <CADnq5_NP5AR0X5k1ZAC-P-dX5CoUyZS_uftXyVPdPbpLCUkcFQ@mail.gmail.com>
In-Reply-To: <CADnq5_NP5AR0X5k1ZAC-P-dX5CoUyZS_uftXyVPdPbpLCUkcFQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5f6105c8-0f09-4276-b06d-1271e5327e36;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-13T14:42:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|SA1PR12MB8723:EE_
x-ms-office365-filtering-correlation-id: 72516f43-77b5-4c67-5fc3-08db83afb6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vc8AgKgeRSxP7XjvcLyB2glMDY+2DRlfwhYdu+T4w6ySwkONUZJkYsHwzM1ZoXAKI7FcUpTGXgHznkf721lzFueQSbIznL/omgEAkWcDWjmvSKHLWrPTvboLnHe2OtrwT6Vt1eP3C7FfkU9kHlOpqdxYbSDKCLFMqiihpgtX5NjFv2Y00fvchozajtwCv4/1sbd5saFezEXseRRHi7B19cPT8BL1ZkvbyludXwbPaMotQUQruTXr7lPfizcSX11XbwgTCfv5zi0w/kbWPl2kx3fD/d5GMzr+hytOBOaEYxpcz4pinJzGVoSQnBzGfQQ/TpY4WXk6JP2Qef6VWXvR8ce0rquPcg2WCjDZFN2vKJ53NlPR3xInf+bRl+RQTcCjPyJbp1b/uqiIVzmdWRA+SO1+VfPX+9B+zXFM39LK2J7/W1wFv9+ZsQoXkrlnyff4jiYDMsLySUUtwbvwg1FfpFk8sNgrz1naBKW4l0xK/bvR+yLeE6zY+XKkUzEpyBVADRQzuucas2oF5NaBq/h0knqDQpNRcdIYInQcOwkorAW3hN5iCON9koyLMNMuQ8lTYMtpYJS+hoD4nlU9f3U4tZrJynNiUYAEn1br8LDqUsg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(110136005)(41300700001)(55016003)(66476007)(66446008)(64756008)(6636002)(4326008)(76116006)(66946007)(66556008)(478600001)(5660300002)(52536014)(2906002)(8676002)(8936002)(316002)(71200400001)(7696005)(86362001)(26005)(9686003)(6506007)(53546011)(186003)(33656002)(83380400001)(38070700005)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2krMDhiTm5WN1ZtZVdmY3FDS1lmblpzYmlOQ2Jwc21FckZISzdiMU83WVRx?=
 =?utf-8?B?b2VlcUxsVnc1MWFXaDVXL0ZBbFc3OHVQK0hOck9ZMFlaU2tCWWRNL2tFekpT?=
 =?utf-8?B?SXd6bGdzeTZWMCt6ZnlFajMvWXVucVUwbmszdFpmckJLNEJkbjJBQkhySlhz?=
 =?utf-8?B?M2xQcGh4cy9RZnNaREhKR2ZIMFRYalhHdUtWWVVBdkZ1WkgwS2luV3hLc1Vm?=
 =?utf-8?B?Q2o2M3h3dXBueFFZV3NHQmhIa3l3cUdrRmFiMXNQMzVkM200eFdLYmVTL21O?=
 =?utf-8?B?d0pRelArNnVvSm13L25CNU1GYkIzMGd5b3diWm9TSVV5NG83UmZIN3lacTBO?=
 =?utf-8?B?cUtaMXR4QVBlN3NSQ2FQZnNVQi9FN1AvUUdKam4zLzd6aUV3ZjVHUHIzK0Y4?=
 =?utf-8?B?RGtDY2t0c1RvVzJONTJBTGtvTXVPMjB2WE1sbTNvUFprUlppZzhGeDBSQnYz?=
 =?utf-8?B?bHgvOTRQQ0hhcmlzWm9WWSt5eTkyNUlJbm5zQnVrcHErdUpTeFZ0TTI5aGN2?=
 =?utf-8?B?VnJPSisvc0NSR3JaRUhpbHhMejdJSW1oNHFVeVR2RGMrUkVweGsybjZsck5P?=
 =?utf-8?B?eDU5U0pPalZNbEFXRDZWSXJwSEJBazVNVmxOVWdwQm5vSTB1YTdsUzhmZWI3?=
 =?utf-8?B?YVF4alZoZXVrYnBGdG1Jckp5OWtiRjV2aWhVVzRreG43VjhxNmdQbzZGcnZm?=
 =?utf-8?B?SHhiQ1VEVlF0VzE3TDlBTTJGc2djbW4zUGRkZDZpTGhjMlBjYjVKbDFYSGtv?=
 =?utf-8?B?MENYa3RQQldGTGtqaEZrc0UwU043SEFEZkszcEh6OTFFaDc0OG9EVWpaM2hq?=
 =?utf-8?B?ckVwdnlWSTk0YVU5VFZYOWF2TXpwbzJaYXlMNHQvTTl6bkdLeklYR2xmTFNE?=
 =?utf-8?B?eSt3c21YbFV0by9sSlB6c01NYngrNWpUeUFQVXI5UVBVaTAvMW5Ea2ErMXQ3?=
 =?utf-8?B?NGhLckg5REtvZVgxNWpDRGhwcGJVN2orMEVTZ2hBYWg2Tk5NWmFSU3BWMlA4?=
 =?utf-8?B?bjZJRURCODZPejBMcThPZHFKM3oxODYrenRYWG15K1BuVW15KzdCVHJCZGZ6?=
 =?utf-8?B?TlhSNFI1TFNHN3BQTXNQSWJXL05Bb3FOL0VsVUg1ZzZOc2VBa3pxMzZxRjJT?=
 =?utf-8?B?NXJ1ZXlMd0hoVWExRE9CRGMxaTFtSUZqSFhOMnpVREtIZmdzRUVrOUJ2NW9U?=
 =?utf-8?B?Qyt2YW9WWTZQOC9mTm1ZTUh0VzlZL0V0dGlxTkJ0WHRnRVFlVjdJRU53c3BZ?=
 =?utf-8?B?UkZzOEZ5QVV3L0VQc0RRZU5FbzQ2RGJTZGxLK3h5ajhMUnRuRHd2aUtCQ05T?=
 =?utf-8?B?czdqRWh2enpCWVdkTkc3elU2TE5KTHlMcUpjcTFmRUZkdmVqL2h1S0l6dGlZ?=
 =?utf-8?B?Y2RldmZsVHB1VGlvYjRBUnc2RmZEWVZxb2VzSTY2cjNMZVdBRWthY1pJSDdh?=
 =?utf-8?B?ZjJweWtvWXcwckZQZTdBeVNUWEovVERTay9RQ0E0M2oyQ1N3MFUrQ1FoMDRN?=
 =?utf-8?B?YTJyREVveWtCRnVaL1lLME1hV0VmR0pqZEowUWd6ZC96UC93N25nTyt5RUxD?=
 =?utf-8?B?dUc5WHVxOUNMam1JcVhQeVJyQ3djaDZlR2taWDNaRnRMSzlrZS9OZTc0UEQx?=
 =?utf-8?B?YnRXTmhwVk93bzNQcE5VY2JpbVNrRE0zbHNTMVZrTFlmRHJvMW9qaWRaSS9o?=
 =?utf-8?B?RDEvaWdTb0Rya1JPSHJvYjdkazM4emUvY05yUWJ1eGlWQ0Q1Q0M1cjhUVElZ?=
 =?utf-8?B?OWxUbFNwT04rTEtYalZhakU1TE43cjl1SVliMVJZR2E3QnlTZWE0UmtZalU0?=
 =?utf-8?B?MXdXQ0xEQkJ6WWc1aVplem8zaG44bWpaeUl3eFhWR2RXczZqN010V2VoT1VR?=
 =?utf-8?B?ejZYUndqSG9TWktIWnFKd1RFK1BBMFlOYXZQMVF1V0lnUi9aV2htZEdHU3R3?=
 =?utf-8?B?T3ptWlBidUlHNEFUcmg1TWFMVmwybDBZOHJXL3hxYmVPOUNGUnQwUSt0N1Za?=
 =?utf-8?B?bDBnVXB4aDZQRTFWS0JYNzJiNG1pd3IwSWxxczVQNllYMWJLVTdiazM3bzVW?=
 =?utf-8?B?S3lEaEJUZzE1QTY5ZzNoTTlRcXBzbkh4V2k1NFFmTDdiQi9BR1lObTZQL01K?=
 =?utf-8?Q?qD3Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72516f43-77b5-4c67-5fc3-08db83afb6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 14:44:51.4803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V84pCexPYY7Ci/vDnLh5ElvVwYLVOzY4zMrvtIKFa/hrXD2NzumXzvUCG/YBQQCt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBLZW5uZXRo
IEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBUaHVyc2RheSwgSnVseSAxMywgMjAy
MyAxMDozMyBQTQ0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQ
QVRDSCAyLzJdIGRybS9hbWRncHUvcG06IG1ha2UgbWNsayBjb25zaXN0ZW50IGZvciBzbXUgMTMu
MC43DQoNCkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwg
U291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCg0KDQpQaW5nIG9uIHRoaXMgc2VyaWVzPw0KDQpB
bGV4DQoNCk9uIFR1ZSwgSnVuIDEzLCAyMDIzIGF0IDEyOjQy4oCvUE0gQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4NCj4gVXNlIGN1cnJlbnQgdWNsayB0
byBiZSBjb25zaXN0ZW50IHdpdGggb3RoZXIgZEdQVXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3Bw
dC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQu
Yw0KPiBpbmRleCBjZGE0ZTgxOGFhYjcuLjhlYjhjMzBlNmM2OSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jDQo+
IEBAIC05NDksNyArOTQ5LDcgQEAgc3RhdGljIGludCBzbXVfdjEzXzBfN19yZWFkX3NlbnNvcihz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAg
ICAgIGNhc2UgQU1ER1BVX1BQX1NFTlNPUl9HRlhfTUNMSzoNCj4gICAgICAgICAgICAgICAgIHJl
dCA9IHNtdV92MTNfMF83X2dldF9zbXVfbWV0cmljc19kYXRhKHNtdSwNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1FVFJJQ1NfQVZFUkFH
RV9VQ0xLLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTUVUUklDU19DVVJSX1VDTEssDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodWludDMyX3QgKilkYXRhKTsNCj4gICAgICAg
ICAgICAgICAgICoodWludDMyX3QgKilkYXRhICo9IDEwMDsNCj4gICAgICAgICAgICAgICAgICpz
aXplID0gNDsNCj4gLS0NCj4gMi40MC4xDQo+DQo=
