Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41003C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 13:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A3710E145;
	Thu,  1 Jun 2023 13:04:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8B310E145
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 13:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgHs+xIcPrJvnekeOAQfkKPT8adKrVya7UpC2vWQEcjeY68fSQ8cDbNltBf9VcJf0anfdIXoM9erzc2Ny4mDbocFZMfDr1xJbN4nCIrAP6qdctgEeIV1Y20oA3nmKKiIB6tk+ZQc7jDkTSgZEAysoW2sp0Ff0kVPsrDG6YuLe24MVMc96DiRAmWdVL9EgJel9NakdrfcHczGBXdhlL3ca7P53MTrMKq3MrrxvfwbDglRQD9hGJJ3P+FWE31sLjdpYX3ZbNYEobBvkm5g05dHQG3YyEpRA7WOTtMTc3ETG7AJ0j2jb2PYZ/YW6bYrOFlW6eX1g16TD0A5dYXjqRQM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ00F57sY1ZTuB+YTGICPbTgvPN6kBBPUVewetwmeaw=;
 b=oPekpC/kZ8CyaxTKotXQ+xp7PI6eyVfBe2KOVFbevZdj0Z88oZJjytZluaxT7N0lq/7gPpNpaavBBrnLdzs5f9DbH/6En//Qr57Pql2rBTWgEHHrIbnNLuLEyWi6ZB0iNxMjhF7JVNH3tqt054iXpUelf4Aiz2yrDrPZDdL1AUFgjHxiS2/kuhWrllaIaDEdNxFclZjP0cYXkn6PQAtBNLyau3tu2d+aL/Togzm21OfahANYGQ53c6DWM3/AkL+tsh7bzL3RRsqKKUpaqI6nE3MELNDMg51RecaeTcSBQkcy9vK1H+64G0MAj4NG+zNe1uVx6Of2H6sPf5M9bemXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ00F57sY1ZTuB+YTGICPbTgvPN6kBBPUVewetwmeaw=;
 b=MZhNia54Ub8HhS2sc8XljlvHuJdhMCgR+RAN1m6VHyZvyxNNCHemN2pkSkuf8qsDyY7NesvbvVsYbS5JXhoD87IenJYg6z4XeUcXhJoZC8hrinWLvdz2pafjOJrm15BZtjnBZz6C/+QUJaqe/Vq2IWKD6gSadOVtEEt1RkKkE5w=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 13:04:08 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::1bc0:9a90:646e:eff2]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::1bc0:9a90:646e:eff2%7]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 13:04:07 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: Drop unused DCN_BASE variable in
 dcn314_resource.c
Thread-Topic: [PATCH v2] drm/amd/display: Drop unused DCN_BASE variable in
 dcn314_resource.c
Thread-Index: AQHZk+fg7n6P2PYEmE6A2qH8dFyx96916xEw
Date: Thu, 1 Jun 2023 13:04:07 +0000
Message-ID: <CY8PR12MB8193905534B131422CC7147F89499@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20230531174624.3526968-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230531174624.3526968-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fd19240c-a897-4d81-a0a9-f1e2e9940b3a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-01T13:03:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|SA0PR12MB4558:EE_
x-ms-office365-filtering-correlation-id: 383436c3-36a7-4b33-b17f-08db62a0af39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2VfVU68TdE0DzXb1bhSgFX6xu8IZe91EDZrReZDhCZgdJ+kFNrcR0NaTkN1CTQFI609Yx9f/9xqwwQPlj7VuT8k2At/mflSvtY279ee1eiB8OkYi2WPqJec9XvnSoRLp/umrMQVQhxeBoMOjfNlVBYfA4NpvUuBV30EfT87HPc7utBSHBTriEGZ9/hy2eewpd1j/4kNdFX+yvIJYvQQwXvzjtgec+mwxFoDo5lV4NhVt2UlUfTBZBICVK085HbClrzMvMrhBF/5nRzNylLSreombnQYuMcwsCueQMyJJLbFc7VHJg1QKiTRdAK7DmQ6krVUX0N9ecR5p/nB2gpnneHl+KXB4DLP893EBa8vDy+wFNInmg5p+gb3TxwkAeEgCHkVQ0RIeSgXrm5E9TcsnJWCzqB87DBGsIHwYt8SM57SNmToUucj6goy5umXzvQo6nR8+OscKXFVfO4oOaooYRVT8x7mhlZpu2diL4LfP0O8pzeu3eH8Eq8H25T/DnVK7W8hx9ZYkvTt0oulivXgSURLY/Mh4Gcf4Ff4ajinA79GCLqF7PDeoqRXhrOr1EtX6RdnPs9mZg+np5n6PTKInCu/PklNMPVJmsIlxyCylkcx9LSb5q9s63Xxn9K5aLCv86LRIiEa9eNJgGAHD4fpDrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(921005)(33656002)(122000001)(38100700002)(478600001)(110136005)(71200400001)(66946007)(76116006)(66446008)(66556008)(66476007)(7696005)(41300700001)(5660300002)(8676002)(8936002)(86362001)(52536014)(64756008)(2906002)(83380400001)(53546011)(55016003)(186003)(6506007)(9686003)(6636002)(38070700005)(4326008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1A0OEwvM1dXNzNUZ2FSM1ZTM2V1SFFLazBESzh3ZVJJQ2JoNE03MFZ4d3pH?=
 =?utf-8?B?ZE1GQzFZZzFyUEhNMGd6Q09kSjYrT0ltSVVaeUR2b0VBRmg1c0hRUjVCUXNR?=
 =?utf-8?B?aDhvenZ0bXk4ZDByV0Jad0RzTGlZYUFWS2MzOEZleXdac1FHak1JVjRXOUt1?=
 =?utf-8?B?aUVLTjZwM045Zm1kVHVNUDVmL0xzc205VmlIL3JkSTNGdWVFVkQvOFd2VDlW?=
 =?utf-8?B?RFVLalIxMWJia3UzSkg1YytQU0FFSjBVVmo5SE5WQ0xXaVgrcmhxajF2Y2Zq?=
 =?utf-8?B?Mi9JR1R1ZnYwN3JKUGpIL3pHLzVqWnpuZUZYWEtYQkZhZ0kyK2Y3UVZhMit0?=
 =?utf-8?B?SUFpRUJSbTZ3d1MzdDRMQndhRms5RkFUbEp1NWNkZ3RqOU0yVGY2MkpieEJQ?=
 =?utf-8?B?bGIxUFdoNDhKQ0plSjBqZTkwTnpjN0pyQnpNdm14dUJ0YnNTdTdxOFdjaitm?=
 =?utf-8?B?MlFCeUdEcTMrNTJaTlVrNjZRZTdIN05IYUdQMmdMNS93dmRXbGxNRGxwZXZ5?=
 =?utf-8?B?U0kvN1hEbU9RenpQRDk1U2t3Sy9lbmhndThuWktybDNuWHBLNFpOekNxamlj?=
 =?utf-8?B?MjhvMFlUN2txeU1Nc0J6cmlIVE5jVDZLN1piYjAyYkkwcmUvMWxoaHBYZWRY?=
 =?utf-8?B?ZkEzRmVWVEptY1p4UkNkRTFJOUVXNnBrVUhCWGN1RndVR253Z3FQWk00Y2gr?=
 =?utf-8?B?OXZoZWNvUHUvT2laR2lKUnBFN2p0eHF6RmxlTmpZSFFLTVRya25DMDJlc3I4?=
 =?utf-8?B?TGcyd0MwMm9nVEUvSnhqOUJJVWU0Y0I0M2RjNFZ6ZkxsMlBIdWtnd3hrM0tp?=
 =?utf-8?B?UUxhRExJZXV3alhCbmZIR1JhaHo0QWVGUnI4dzRWWlE3TjF0QzhuQ2xaNjI4?=
 =?utf-8?B?NktkVjFicWhFRDFHUHllT0JxR1dVZG85NWsyVXNRbEJkV0dFd2ptRXQvOGtm?=
 =?utf-8?B?a0doUG1QVEIveTNCTnJxYTJIcWV5cUZmQjVJajdERW4wWkpPT0JWWXBORTV5?=
 =?utf-8?B?QW82eG94b0JaOXN2V2NOaHJRSVBBU1JZbUxmR3JaSWVhQStYMDlZWllzSWpC?=
 =?utf-8?B?RFJqVlNKTTY3Q0s1eGErM00weUx0dTIxUXJWR0JIS2RzVmNLQ2tNazdpNkxq?=
 =?utf-8?B?RUh3cXZJbHJnZ1I0NHlkSmRFck5JU3p6ZFBCRDMwUEY0UTBSYk5QYXRndXFC?=
 =?utf-8?B?VUZ3a0J3dW1Hem1sTzhETE00Z3JBY3BPU2czZ1Q5RTAzUERHWlJxeWw2bDM1?=
 =?utf-8?B?MStlalhOSERwbnJ2SGxhK1lTYi9NcnZwUmY1Q3hjMm9oNU1IZkpuR0o4T3Jn?=
 =?utf-8?B?ektqRHp0dGx3N0grYVhHLzFNeWpYaDl4QzFFZG1IT2hXbi9IcmtxQlhSNHFy?=
 =?utf-8?B?VUNCL25HaG0xMDlWYzlnaU9hRDFQd0x3d0NwS2owaHFCYVN0aEVOaGNJdmtZ?=
 =?utf-8?B?MHpiVXgraHZMbkZFUllFVHcvQkNQa3BIZmdzM25NUmNpUEREWXE4b21aOEJp?=
 =?utf-8?B?TlJIWHErYlVxTUR0a09CR0ZVNVREWlhmWmFDR0R6VWNndDhRVmZ5Tm0rd1B4?=
 =?utf-8?B?T1dlbU81NExFcGpaSXJkL3d6T29ydmVJNnRQSkFaYng5VnVuWlZjSFhWZEEz?=
 =?utf-8?B?MENjS2k3UXFCVkk3Z1JZOGU2Yk1Id2RpODg1cWgvQnFQYVR0cm81KzAweVRC?=
 =?utf-8?B?dWxDOTBtS2VjdmJzNWhrbGI4V2dsSjJ4QXpYV012RGpxN2xFTitzZmk3OWV4?=
 =?utf-8?B?VWFURFhEbXRnOGtFUG5DTjFRVldlMGtFcStnOGpUMkRxZUlJeHFab0FjQ0g3?=
 =?utf-8?B?NjZxL21CUW5rc0tST2NPb2hwVEFHSzEyUU5FSDRhYnJRODJRekZnZzZQelVr?=
 =?utf-8?B?TWc3d2UrdWM5SkR4SVBKOVpCU3hrY2p1T2wxekIraEJzbHprajc2bVUzSjZo?=
 =?utf-8?B?ejQwV09FSDhJZlExU1BaZ3FZUGFjbEYySG1BRnhOTlZud3E4dEZkS3Z2eXRZ?=
 =?utf-8?B?dmhjL0dYam5TRXB1TnpGUUZaLzV0NXpKRXpKOGVqZ0R3b1VMQTVNQm1USk42?=
 =?utf-8?B?cW9kN3ZnRFpvblloeHNBZldFS0orUjBOc2czZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383436c3-36a7-4b33-b17f-08db62a0af39
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 13:04:07.7074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzHlVN6QyX3S9BF65BXRIZc5+0gNcs19jIMXa1BJRqfolzmqj6jZSzz964MVBEPU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IFJvbWFuIExpIDxSb21hbi5MaUBhbWQuY29tPg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNIQU5NVUdBTSwgU1JJTklWQVNB
TiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkg
MzEsIDIwMjMgMTo0NiBQTQ0KPiBUbzogUGlsbGFpLCBBdXJhYmluZG8gPEF1cmFiaW5kby5QaWxs
YWlAYW1kLmNvbT47IE1haGZvb3osIEhhbXphDQo+IDxIYW16YS5NYWhmb296QGFtZC5jb20+OyBT
aXF1ZWlyYSwgUm9kcmlnbw0KPiA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPjsgV2VudGxhbmQs
IEhhcnJ5DQo+IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgTGksIFJvbWFuIDxSb21hbi5MaUBh
bWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwg
U1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU3ViamVjdDog
W1BBVENIIHYyXSBkcm0vYW1kL2Rpc3BsYXk6IERyb3AgdW51c2VkIERDTl9CQVNFIHZhcmlhYmxl
IGluDQo+IGRjbjMxNF9yZXNvdXJjZS5jDQo+DQo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtl
cm5lbCBidWlsZCB3YXJuaW5nOg0KPg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2RjL2RjbjMxNC9kY24zMTRfcmVzb3VyY2UuYzoxMg0KPiA4OjI5OiB3YXJuaW5nOiDi
gJhEQ05fQkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFi
bGU9XQ0KPiAgIDEyOCB8IHN0YXRpYyBjb25zdCBzdHJ1Y3QgSVBfQkFTRSBEQ05fQkFTRSA9IHsg
eyB7IHsgMHgwMDAwMDAxMiwNCj4gMHgwMDAwMDBDMCwgMHgwMDAwMzRDMCwgMHgwMDAwOTAwMCwg
MHgwMjQwM0MwMCwgMCwgMCwgMCB9IH0sDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+DQo+DQo+IFN1Z2dlc3RlZC1ieTogUm9tYW4gTGkgPFJvbWFuLkxpQGFt
ZC5jb20+DQo+IENjOiBIYW16YSBNYWhmb296IDxoYW16YS5tYWhmb296QGFtZC5jb20+DQo+IENj
OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+DQo+IENjOiBIYXJy
eSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCj4gQ2M6IEF1cmFiaW5kbyBQaWxs
YWkgPGF1cmFiaW5kby5waWxsYWlAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNh
biBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPg0KPiB2
MjoNCj4gIC0gUmVtb3ZlIGV2ZW4gdW51c2VkIElQX0JBU0VfSU5TVEFOQ0UgYW5kIElQX0JBU0Ug
c3RydWN0IGRlZmluaXRpb25zDQo+ICAgIGFsdG9nZXRoZXIgKFJvbWFuKQ0KPg0KPiAgLi4uL2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24zMTQvZGNuMzE0X3Jlc291cmNlLmMgfCAxNyAtLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMxNC9kY24zMTRfcmVzb3Vy
Y2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMTQvZGNuMzE0X3Jl
c291cmNlLmMNCj4gaW5kZXggMzU5MmVmY2M3ZmFlLi44Mzc4ODRjNGYwM2EgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMTQvZGNuMzE0X3Jlc291cmNl
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMxNC9kY24zMTRf
cmVzb3VyY2UuYw0KPiBAQCAtMTE3LDIzICsxMTcsNiBAQA0KPiAgI2RlZmluZSByZWdCSUZfQlgy
X0JJT1NfU0NSQVRDSF82ICAgICAgICAgICAgICAgICAgICAweDAwM2UNCj4gICNkZWZpbmUgcmVn
QklGX0JYMl9CSU9TX1NDUkFUQ0hfNl9CQVNFX0lEWCAgICAgICAgICAgMQ0KPg0KPiAtc3RydWN0
IElQX0JBU0VfSU5TVEFOQ0Ugew0KPiAtICAgICB1bnNpZ25lZCBpbnQgc2VnbWVudFtNQVhfU0VH
TUVOVF07DQo+IC19Ow0KPiAtDQo+IC1zdHJ1Y3QgSVBfQkFTRSB7DQo+IC0gICAgIHN0cnVjdCBJ
UF9CQVNFX0lOU1RBTkNFIGluc3RhbmNlW01BWF9JTlNUQU5DRV07DQo+IC19Ow0KPiAtDQo+IC1z
dGF0aWMgY29uc3Qgc3RydWN0IElQX0JBU0UgRENOX0JBU0UgPSB7IHsgeyB7IDB4MDAwMDAwMTIs
IDB4MDAwMDAwQzAsDQo+IDB4MDAwMDM0QzAsIDB4MDAwMDkwMDAsIDB4MDI0MDNDMDAsIDAsIDAs
IDAgfSB9LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHsgeyAwLCAw
LCAwLCAwLCAwLCAwLCAwLCAwIH0gfSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB7IHsgMCwgMCwgMCwgMCwgMCwgMCwgMCwgMCB9IH0sDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgeyB7IDAsIDAsIDAsIDAsIDAsIDAsIDAsIDAgfSB9LA0K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHsgeyAwLCAwLCAwLCAwLCAw
LCAwLCAwLCAwIH0gfSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7
IHsgMCwgMCwgMCwgMCwgMCwgMCwgMCwgMCB9IH0sDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgeyB7IDAsIDAsIDAsIDAsIDAsIDAsIDAsIDAgfSB9IH0gfTsNCj4gLQ0K
PiAtDQo+ICAjZGVmaW5lIERDX0xPR0dFUl9JTklUKGxvZ2dlcikNCj4NCj4gIGVudW0gZGNuMzFf
Y2xrX3NyY19hcnJheV9pZCB7DQo+IC0tDQo+IDIuMjUuMQ0KDQo=
