Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE70C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 03:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1963060EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 03:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1963060EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA556E39B;
	Tue, 14 Sep 2021 03:37:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 902696E39B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 03:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx4P8XOA2RBm3cDn8X2FKHrfDsoy7m8GzLX1tEbkf7kzg8ar6oIiXYoRB3vy0f4i3zGYNbf943Hjufrqh5PZvIqY5oR3cJsO6tf0tJhaam6rF8wiufVQ56IOQCDEeABOnDKTzliNAZPdFw3kw9cietU2UaSuyJwhul0DFccQ5CnwZ+w5zObBP+7tjka367ZZen+wqwjX191Baowlr8yMoeKDlGI3KcQu2/9PxOvD3rqlob1NYEQ8Qzv45tLPb76oTpkS0N1yfHSZQ9b33B4XdHMFKQR4q5wcOU17Efpyl5lKGSIn5EI0Bi4dmKLxCvS3NtNeURPYZDvu5ROd1IGMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2VV7F2kglgb8BU+L/rn2qlPsBYVsbWE9qJjrno+KB/8=;
 b=Pu45aMsKEbnd2iIIhL+5qojzePP+uCfHdQ+bcidpPSbhqJhWfi1YwcfJLQSVD00OTob3dxUE3BMEI7M9dy5dFm1ZawgVLeDfddY5yXGlwN0x0oGNPjC2zYEPGaU2lyUar/PbWsSaV72azEHlB+R7cV9QMGv4E3+p4Jf5X/oppWqN+aqqhf0x1CAYAn8I6UaRxe5cmNC6hIMr1noZ5E8vg3oLRY8z8df6a9g+vJtZE5XWc4q2PxLzefYfKhrHQByJCeVfH0nLeYkEIgVWy1awYDGeooCStif8TYRDOBTvkcBiXNGNfEfJrJavWz0jNU5O1eqznYVTiwP/GMD2FCVyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VV7F2kglgb8BU+L/rn2qlPsBYVsbWE9qJjrno+KB/8=;
 b=rLvu7TBxaB2lJlDvQMe3a7E3ArUSuFAvGEKPwQn66DYU6+dYl24OvqIWzKPGECRW2iAKSFvBMyPPcIPTvHenxaDT9SXEowcHRvtkbXkPhMCK14xiO6Ubxj1qHQYOuN0FeMZypbkGG9TOOUU+qJfHEdeVdSUUAZ0ATCDEL+awQPQ=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 03:37:55 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::65cb:61c9:4ef2:c5bb]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::65cb:61c9:4ef2:c5bb%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 03:37:55 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Fix white screen page fault for gpuvm
Thread-Topic: [PATCH] drm/amd/display: Fix white screen page fault for gpuvm
Thread-Index: AQHXqNMzpHm6ZkhSbkyxRCKziNehK6uiVR8AgAADkICAAIkccA==
Date: Tue, 14 Sep 2021 03:37:55 +0000
Message-ID: <BL1PR12MB52370AEFCE98301DDCC123F3F0DA9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20210913191136.104609-1-nicholas.kazlauskas@amd.com>
 <CADnq5_NRi4V-MPm-5JWVbPEtAJ0n7pVvL5K+Wonkvr3YXDoTwQ@mail.gmail.com>
 <36e271a5-0cf4-39e3-401c-2621de431332@amd.com>
In-Reply-To: <36e271a5-0cf4-39e3-401c-2621de431332@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-14T03:37:50Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1fe23931-b95f-424d-bca4-0d640cd04112;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e222c284-b484-4d34-63e3-08d9773109ea
x-ms-traffictypediagnostic: BL1PR12MB5093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB50930B39DBD45E2C197339D5F0DA9@BL1PR12MB5093.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gsd5LYFjgujcIjBwGigN0uIzmMv/cBlbZZ+IA7d5/Pkw3SNC81v+tZfBSTS+IV3Y3vbl5K+vWW5rqsjY35PtJwhIHwAwU5EDgKvMCDXYZCUaneHYDM+iZ9/uWPegF8cd5t/CPA5aK3lvLS0Pt5muGlA4lXt+GH27LMByVjktX9cdfSv8ojCR1SwyUQ93OUET/CtoGhqRq7JU6B5gE9Uk7vSauIrHpN4uqHb+5Y3eJ8MR8H2Jfeb2seO1DdkGsFtruoC4nyGybujX7Wdk8yvgCD7zzKzD7rO4TpQUYSmJNR3vTCJqw5BYyCI/MnDGkr72DKZ4hszEBssFyJzm4h7V5n2XlexmmcL6dQ+zEe8jL0zsvQ4Y9xFqjRQXmdRsKE/MJdEvQHd9FYbsenfgrdIGhXZ/OiOzf4BXfN6LuuuMIBfxj1yibsCH4Fb2HNxlbldODOlv7pXyoUZTAIrZqZdIc/t5lrRHnEzTZ2PpA8Dfy+gP2Go69T+cdiiVL7R/Q73wyCTmdxD3KRauxSasxiH9DHctwF1s9Td31SOyi0kxO7c54ovXu5ATvRh8Hg9KyiURm1Kz/UdNEbAeY9fSFNvGhM6c+56KEvIMCNp/1DsL+p4LHHaZYm2odXnBKcClhVTQsIO5KSL+zzUPaz7AQz8k5ViKA6wONjsvKpPBSFJvUmMVXZhnEysmdcIjBPA7DOqhcJA/mCqDffAEPmqavXd4Lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(8676002)(83380400001)(38070700005)(86362001)(478600001)(8936002)(55016002)(26005)(7696005)(5660300002)(71200400001)(2906002)(66446008)(66556008)(66476007)(38100700002)(9686003)(316002)(66946007)(122000001)(110136005)(76116006)(186003)(64756008)(52536014)(33656002)(53546011)(4326008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3ZFWTNNSThNNHdxdmZ3RUZ5UXh5ZDh5cDM5dDk3ODdLc05KaVRmWW02V3FV?=
 =?utf-8?B?S3c3dmd4N1JjTUJKa3BOOVR2bmg4OW9JbDZWUDhub2o2QXVHSFJMWTMxTEYv?=
 =?utf-8?B?bDZ3V0pkajRqSUxoOVlQQUNkMCtqRnlHU3Y5UlBCQWxXSHovSVI3RDJ5RHA1?=
 =?utf-8?B?dFY3eVhqdXhSVXhTWEI4Sk1wSFFyYXRxNzZVNUk3QkZQdUVsRnZhaVVsZGhB?=
 =?utf-8?B?UFh0cDlMY0RITHRDUWE1aWlXY1JLRjhvd04vejgwOFZwNEFBc1BXL3hieS9J?=
 =?utf-8?B?bVVzdHpNSGRrNnRYWVZCOXhCcXMxbW8rZ1dlWklxYnExOUNYalJRUjFIYXhp?=
 =?utf-8?B?UG5KUHRscExOYm9oaU1BWFloLzd3M25kR0dGUGV3N2JjcEZXQXNHVUsxdWJ0?=
 =?utf-8?B?dVJjTGE3TlJkTm10NE5FcTFkWUhpa0JoSjJ5VGFNcTB0dlZGbVRwRFMzNndU?=
 =?utf-8?B?MHFiMXFHMEIyZGxnUDVoSTBDZ1lRSlo5U3pTU0x4STZMOCtkTm9pWjllS2I1?=
 =?utf-8?B?Y1lzcWk1eXB1d2FRUWFtZ1h5V3RIVjlSaTBMR1k1M3ZHUjVTamJSRFcrekRZ?=
 =?utf-8?B?Ukp1SjRleC9XU2p4WXNpalFEWjdJSFJ0eWpjM040TkFCSGZORUJVMzR4WXkv?=
 =?utf-8?B?R3k0TFRZYlNnZmVlU2xUTWZlODB5dXdmNDhyTUpJZm9BQ1ZLVGNEZ2dIYXBz?=
 =?utf-8?B?WFRZZ3J2bkdhdldaRStuR2prVStJN3h2WmswTVNGUFVkWWJLNmR2SmRFbXhG?=
 =?utf-8?B?cVNodEdTems5SlBTSUJGVm9UeXhMVFZiMkVnVC9nUzVoTW1oRVRUdU5Pa0Zx?=
 =?utf-8?B?NUZndzR5UG9oWWhXZDhFaVdHeXUrMyt0K0VxRnFKcjJmNnFEa2xvclk3VmFL?=
 =?utf-8?B?L0lLcUNxQTJ2NDhoWnBxS0I5amdYam1FWkJ3dFBCZGlVbytKeEVRUlB2VUEx?=
 =?utf-8?B?WG5XQmE1YjI4MExwS3pZSU1OWVI3MlJBUVdXcUo0WFd3a0pMTEI3Mkd4ZkQ0?=
 =?utf-8?B?NkJ1dWNnZWpkSUNWNXVHcWdUNWJ1UXBpNmp5d3F4cU94ZXV6YkViRzVTY2tV?=
 =?utf-8?B?UmN1WnNFUGE5UmNBdTFUaDUzVmk0bjVLRFpnVnEyN1VBS3RxWXRYZExvQVlr?=
 =?utf-8?B?YS9GVVVnZjUwa0xiV3llS3JZTnRwdTZKNzlDdFNXWitnVEduQ0VVa0VBb0Zu?=
 =?utf-8?B?VXE3MTJ1dnpoR290T1B6UTZ5YnZKVkEzUkI3VzZmQ2cwOUNFS3lHUDJiUnJo?=
 =?utf-8?B?TjhQS2JYY3pSSmdCUWt5MHlRMVBIWGF5a1hkeUZGN1RvK09ibXFWMU9sMFpl?=
 =?utf-8?B?QThUYzVtSmZobE51d056MXpEUlpKc0hTRjBHUndodHBFc0w3SmdJekh1RVRJ?=
 =?utf-8?B?MUlFTFlRUzZ4NFdUcFpNWStXKzdTTUx0Y01UbGJxVFlaL25WWW5DU2dKcXFs?=
 =?utf-8?B?VnRZSjM1OW8xQmpFcFFJajMvb0M3S2IxMnd3ZGRUZnpHaFJCRllxR3pnYU9U?=
 =?utf-8?B?YTBOeHk2Q2ZaMnBHOXd0b09SRUlVUUxadmFrNW5mSk40Q2FSTXhsWHFCaFZq?=
 =?utf-8?B?UXRUb1JqTjZlMWtiYlhYOFdnWnZsSXRralpoYzZpem8wM2g5VmR4TnFybk9y?=
 =?utf-8?B?akJGTEE3SGlQVUhCM1FFSnlMVDNOZFMwQXBsdWJ2YWFEd0NsdHBjUk9VNkJn?=
 =?utf-8?B?S05Dbjh5RGxKTjFwOUNkZ0dxdUNDK0Y0eU1KVmhVeFVrOER2SHlPaENiSkJv?=
 =?utf-8?Q?8hbdLNnwnAZ1tThufyLKmkrE3oopzCFOeBBwwy+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e222c284-b484-4d34-63e3-08d9773109ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 03:37:55.1830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjMmuaDstjhOqdqjd3FSCbeL6/LqfTWDgm5Nx9H2+r9dlZuu9eob3oZktHV0q5ZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVmVyaWZpZWQgb24gWWVsbG93IENhcnAuDQpBY2tl
ZC1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4NCg0KLS0NCkJlc3QgUmVnYXJkcw0K
QWFyb24gTGl1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2F6bGF1
c2thcywgTmljaG9sYXMgPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgU2VwdGVtYmVyIDE0LCAyMDIxIDM6MjYgQU0NCj4gVG86IEFsZXggRGV1Y2hlciA8YWxl
eGRldWNoZXJAZ21haWwuY29tPg0KPiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz47IExpdSwgQWFyb24NCj4gPEFhcm9uLkxpdUBhbWQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IEZpeCB3aGl0ZSBzY3JlZW4gcGFnZSBm
YXVsdCBmb3INCj4gZ3B1dm0NCj4gDQo+IE9uIDIwMjEtMDktMTMgMzoxMyBwLm0uLCBBbGV4IERl
dWNoZXIgd3JvdGU6DQo+ID4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCj4gPg0KPiA+IENhbiB5b3UgYWRkIGEgZml4ZXM6IHRhZz8NCj4gPg0KPiA+
IEFsZXgNCj4gDQo+IFN1cmUsIEkgdGhpbmsgdGhlIHJlbGV2YW50IHBhdGNoIGlzOg0KPiANCj4g
Rml4ZXM6IDY0YjFkMGU4ZDUwICgiZHJtL2FtZC9kaXNwbGF5OiBBZGQgRENOMy4xIEhXU0VRIikN
Cj4gDQo+IFJlZ2FyZHMsDQo+IE5pY2hvbGFzIEthemxhdXNrYXMNCj4gDQo+ID4NCj4gPiBPbiBN
b24sIFNlcCAxMywgMjAyMSBhdCAzOjExIFBNIE5pY2hvbGFzIEthemxhdXNrYXMNCj4gPiA8bmlj
aG9sYXMua2F6bGF1c2thc0BhbWQuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gW1doeV0NCj4gPj4g
VGhlICJiYXNlX2FkZHJfaXNfbWNfYWRkciIgZmllbGQgd2FzIGFkZGVkIGZvciBkY24zLjEgc3Vw
cG9ydCBidXQNCj4gPj4gcGFfY29uZmlnIHdhcyBuZXZlciB1cGRhdGVkIHRvIHNldCBpdCB0byBm
YWxzZS4NCj4gPj4NCj4gPj4gVW5pbml0aWFsaXplZCBtZW1vcnkgY2F1c2VzIGl0IHRvIGJlIHNl
dCB0byB0cnVlIHdoaWNoIHJlc3VsdHMgaW4NCj4gPj4gYWRkcmVzcyBtaXN0cmFuc2xhdGlvbiBh
bmQgd2hpdGUgc2NyZWVuLg0KPiA+Pg0KPiA+PiBbSG93XQ0KPiA+PiBVc2UgbWVtc2V0IHRvIGVu
c3VyZSBhbGwgZmllbGRzIGFyZSBpbml0aWFsaXplZCB0byAwIGJ5IGRlZmF1bHQuDQo+ID4+DQo+
ID4+IENjOiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+DQo+ID4+
IC0tLQ0KPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgfCAyICsrDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+
Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMNCj4gPj4gaW5kZXggNTMzNjM3MjhkYmIuLmIwNDI2YmIzZjJlIDEwMDY0
NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMNCj4gPj4gQEAgLTExMjUsNiArMTEyNSw4IEBAIHN0YXRpYyB2b2lkDQo+IG1t
aHViX3JlYWRfc3lzdGVtX2NvbnRleHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBkY19waHlfDQo+ID4+ICAgICAgICAgIHVpbnQzMl90IGFncF9iYXNlLCBhZ3BfYm90LCBhZ3Bf
dG9wOw0KPiA+PiAgICAgICAgICBQSFlTSUNBTF9BRERSRVNTX0xPQyBwYWdlX3RhYmxlX3N0YXJ0
LCBwYWdlX3RhYmxlX2VuZCwNCj4gPj4gcGFnZV90YWJsZV9iYXNlOw0KPiA+Pg0KPiA+PiArICAg
ICAgIG1lbXNldChwYV9jb25maWcsIDAsIHNpemVvZigqcGFfY29uZmlnKSk7DQo+ID4+ICsNCj4g
Pj4gICAgICAgICAgbG9naWNhbF9hZGRyX2xvdyAgPSBtaW4oYWRldi0+Z21jLmZiX3N0YXJ0LCBh
ZGV2LT5nbWMuYWdwX3N0YXJ0KSA+Pg0KPiAxODsNCj4gPj4gICAgICAgICAgcHRfYmFzZSA9IGFt
ZGdwdV9nbWNfcGRfYWRkcihhZGV2LT5nYXJ0LmJvKTsNCj4gPj4NCj4gPj4gLS0NCj4gPj4gMi4y
NS4xDQo+ID4+DQo=
