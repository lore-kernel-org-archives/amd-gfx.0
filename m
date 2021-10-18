Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143D5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 09:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62EC60EE5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 09:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C62EC60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B596E2A3;
	Mon, 18 Oct 2021 09:08:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045456E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 09:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBWtxX/ObF5B30AUvUY2LkiJ4YXi5lhbQdqkOe20qqMitRJ3BE+jQZ0rvFja95AFxgQA8crbPTUWWnhJLhsARUxrnkVfg+/z42V4JleshJmyzgDqEGeH4GWdnTNSbbe+ZQQFjbRLZ1TFF8s6kDchotJMtC7zTD8eNocmm19UzA27tdnzEJBWaXeN1vH7DYh9KtWGR8owdE+KdRGljDP5ePJvA/Zga8eotQpbJA7rcT2Ieks4sb/FqgeX7nUchQXqzIAUi+I1DGFns0nCUUOaDJ1mq/jDMCUKhRuVs9Kt/81OZLezuf5sKnB6RCSLjFCrqdil7rSZESNKcsyGJYNkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkaOpXfFswE1JJIlzhNHuTXwAZIR6qzx23R0KmRtRS8=;
 b=ZvlJ8GRTVBIvfp/HHp09ZlR/7Shq0f2p5z6MWxx3fnu9vFXzuBfS1MpZ23wwTBj8dCSGnVeu+HR4UkPz0X76/EQGEG7oCt08Lx+eit9p6xYBODN/y/giQYLEUkt1WjO3X/nwYM3zT5VnNJL3ge1v+VGO/JzhZCRf5QQknN7P77Dl9Q7g3fqwGwpkxwe5beoUOjJZSB4UjgMP3zxiuW8y3FRDJOJSk9zIOVcYeF1AcuA5EqXDvaTGpW39KWnGVMdnQrWMz4Py3Cvfy7agU0InDS1Flhx3bL9kPxodWsqcjteg+4cio5HukqAlxtcWYq53KKVpv2jZbyWFfIFyCjykDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkaOpXfFswE1JJIlzhNHuTXwAZIR6qzx23R0KmRtRS8=;
 b=d3Vv9I6wdwWGfO3ArSmQedl3jympJCETQtKFQZSiTTwGJERdROJuI4oVjpazZeoBOPaik303oFaRpd0/byq89C74w1G5OE4Qx5TPpFfniZ9P5P0QlIvO9hiKjH8hXnBSy47JDAS/Lz2l60xlQS4I0WJOblkwSLRd5SRChOCTD1I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Mon, 18 Oct 2021 09:08:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 09:08:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
Thread-Topic: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
Thread-Index: AQHXvnoAYkL8Qp0iyUaGXbuZdh0/aqvYaJ8AgAAIAgCAABFeIA==
Date: Mon, 18 Oct 2021 09:08:41 +0000
Message-ID: <DM6PR12MB261909FB884248959DF113A7E4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211011082812.742688-1-evan.quan@amd.com>
 <DM6PR12MB26197E608C4A9739D1E0855FE4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <fe64d815-45a9-1560-d92a-2c1fc207f0b2@amd.com>
In-Reply-To: <fe64d815-45a9-1560-d92a-2c1fc207f0b2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-18T09:08:37Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bc2ba9be-c323-4014-a76d-efc89febfa33;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a0a2fc6-58b3-4cac-6182-08d99216e14a
x-ms-traffictypediagnostic: DM6PR12MB4603:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB460357B38B66C36C92E9BEB9E4BC9@DM6PR12MB4603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kXD8ITJalkmzAUeipunW/v6eOr0EL8OIbH4HFEVhuzWWNB4TDp5u+xW49S7Ydy5G8Hqk5dDl/JHlgTuLRKrmfg8R79Xil12fCyUl5UBhIdN1rUURBe3wOmzmede4DlNA6DVKT60GSAJhVHkPB8r1UQ+mLE1Ytf4LsDTaj95vcVLEazBH9e70RpE9e9mzRMSvg3+xArNo4dmGdyIBfPmL1sdpvwBIxS02E7GHE4CRx+G9vqmIXeyRpsofkdU2ZHoQBwPNvpf6E+xKrhIBXyxNlMtIap1G8yL6iidaVDknWO0kZEZt5RR2Xpx86O6xCGxYxQX7zElMfodZttvZKai2sN0Oaz3yvTflSsh4MKVT6Zgho893Tb9DiwYPf5+hfwfxGT7QVl/CvraLFd21xCw4HE2BgCscCFJaKMhTHWATgNcb88GSx0PVLxQMjiqRETIuSWRI03W+Y/lFa9z+07FmRGqSoTE7AiuY0eVINPaaOVdztiojc7fdQ62A/TNt0H9jP1UXkwAKvskVidg+vhANZKJnRImKxvWYxnYqeVviMQCJpROXBPJAxrny8aqcKzxl3TOQeKQ1uo7HtivYSilOVhaSxh56gEWJqx6IGRP9xS19ZVultLd8lh9iAId7M14Zf03dlVTDfd7yVIckvdGCzU48/W5JPhNvw+RfL8fXfgHsCqJDFFVOvoSvSBnoDAnHxMCcNs+TZIoO455k2n/dqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(38100700002)(83380400001)(9686003)(8676002)(54906003)(122000001)(66446008)(71200400001)(64756008)(4326008)(316002)(8936002)(7696005)(5660300002)(86362001)(26005)(38070700005)(53546011)(508600001)(186003)(110136005)(6506007)(33656002)(66946007)(76116006)(66556008)(2906002)(66476007)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nmx4OUpNUU1HbXZieUJiUjhEbkNtNGF2bXkvbUhzcWVmYVV4ZDVhYTFob0pv?=
 =?utf-8?B?TU5TZDdXSXlaUWMvTm9QSlJNK0Q5TVQ0eVJkcTUyWlpPTURXWXdlclU0KzF6?=
 =?utf-8?B?dExHZDV4d1IzUWl3TmFSOGtTbEpTbCtWU24yaFh1QllkMEduVEhVV1VzNyt2?=
 =?utf-8?B?dVRqbHNrRmVpZDVsQitLdFJKZ3lxazVSWmY3R213K3YvN1Yyd0pDTGxoSm9x?=
 =?utf-8?B?MW1uQjJOWER0d1RlY3FqWWZISFlWN2drUUljemo3TkFHR3grMWdaekZyV2Zw?=
 =?utf-8?B?TFZIVkdjYkRZdkQ4ZjduR0lYVStFb25ROG1mZW1DRjJCV1piK05tMHVGVmJK?=
 =?utf-8?B?SmsrR1hacjB2T1B1bEYwYW5TLzZJZmFVdGVPcXVFSnpSSFVGUUliY1Zkb2Q1?=
 =?utf-8?B?bkNseU5obGtKNU5OV0Y0U3VCdFZDdnpwL3BCWVprcWFHbXJKMDE3b0Q5ODRT?=
 =?utf-8?B?WG80TVZtRjJJbDY5a1YrdFBWcTZ0NFFNNDBocDBHVGgrRUl6UU40R3YzVHp6?=
 =?utf-8?B?NElydG5CRzZ5dWRhNkJiTzk5czcrTVdjNU12ck5JdE9qQ3ZKZlhzNzJtbFVx?=
 =?utf-8?B?dE1QSVdyR2hhaERMZm1Bc1QrQ0tGTXN3cTJ6NWdaK0RwdjdpN3A5M0V0UW16?=
 =?utf-8?B?OFA0OTEzUWlVQVpnSDlNT1F4S0sxOVlhdFQwOVdSdWJtdDJHMlBrWXllVE5C?=
 =?utf-8?B?aG40OS80MjEvNEJVSEh2Z3lwb1VWaEZBYWxVQndvbEJRYUdjbEZYM0N5dmxt?=
 =?utf-8?B?QUJML0xwN3JwZ202TmJ6N3J0NG5vUG1sTEF6SGdvNEo2TWE4SmF1YkxlWGdo?=
 =?utf-8?B?QnlrNnV3Z25RTkNIOGx3Rkl1WTc4SWx2bHYxNWZ1SGsvdWVDc1h2TUNuYWFO?=
 =?utf-8?B?YzBpTlkveHpORVVjaHEySzdpbXlHMmlOT3QvQ2xNQkZPM1I1ano1TFE4Q0dC?=
 =?utf-8?B?Wm4xV0dUc3I0NENnUUxLVzhITW14dFVlMWxWTnlZVklmeXBxWUhWajFpcHk1?=
 =?utf-8?B?WURDZWdZbzlpNEp6dG9UNmM3eVI0TW1kNnFjVXFEN1R5eXFiNVFVUFdEalJP?=
 =?utf-8?B?U01sWm83RDRyTUtCaHJyV3NOOXlDZTBHTnlXamZ3aFJFbTRiV3RLRE5idjFq?=
 =?utf-8?B?eUNhUUNBRmRNb01jWmtkWXZOY1VYdlF5UUlIRDNJb1ZrNEFkUGhCd1NkbEhm?=
 =?utf-8?B?TWFWZGtIRTNBeTRzWGlCVDRRMzZVTU9GVXNhZE9CV0lkNzhPVWpUTFpzRm12?=
 =?utf-8?B?b3hGK1B2bGJENXhzSU05WFlKL1EvejRLeHZaSVEzZFdpOVd0MTZSR3Rtd1NG?=
 =?utf-8?B?bGZ0UmQ3S0c1Q1hHeGoxRVp4ZEhVTDdQVWszUjhFemsrczg5eDI5VGtoQmhl?=
 =?utf-8?B?SmxsOXFjMFJDRVcySkl5WWx2eHhLWkVNT3RkWmNQeEZSYVFRLzVSRngzbEh6?=
 =?utf-8?B?bUFPY1pUaTJTaUNsTDByQkdwYUlIemNMV0VwMEtybXZzU3FoZXMvNjJncFhz?=
 =?utf-8?B?OHhsVnlRYUZxU3k3dUNlSXErczVXSDliRHRROU9naVhFdTYweXNhVHZnOHhW?=
 =?utf-8?B?eFdGbm80eUFhcUVucnlPaFpORjhMNDc3SFhOUzdqNFNTSU9IRXRaVHVNN2tH?=
 =?utf-8?B?d29MYVc3bkVybWpYamVNK09adndEaXpGNzRDN2taYi9yTmpPdDNqRldUbkFm?=
 =?utf-8?B?L2EwTVc2bmtuRXc1UStibmNGMnJtdmlnWmFZT2YvWmtPZUxKemk2VDJ4MXlI?=
 =?utf-8?Q?fjYlaD0hq3MgFzaN6srolWqBBaqUSO0D7RbMQc9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0a2fc6-58b3-4cac-6182-08d99216e14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 09:08:41.5050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCNHHVG08BKIFpQerww3xc21qWravjIMgquDddrqvX1BPtIFdCZUeDPEMamap2QR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4603
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDE4LCAyMDIxIDQ6MDUgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVh
bkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEdyb2R6b3Zza3ksDQo+IEFu
ZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogZml4IFBvbGFyaXMxMiB1dmQgY3Jhc2ggb24gZHJpdmVyIHVubG9hZA0KPiAN
Cj4gDQo+IA0KPiBPbiAxMC8xOC8yMDIxIDE6MDYgUE0sIFF1YW4sIEV2YW4gd3JvdGU6DQo+ID4g
W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4gPg0KPiA+IFBpbmcuLg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBh
bWQuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTEsIDIwMjEgNDoyOCBQTQ0KPiA+
PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEdyb2R6b3Zza3ksDQo+ID4+IEFu
ZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IFF1YW4sIEV2YW4NCj4gPEV2YW4uUXVh
bkBhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBQb2xhcmlz
MTIgdXZkIGNyYXNoIG9uIGRyaXZlciB1bmxvYWQNCj4gPj4NCj4gPj4gVGhpcyBpcyBhIHN1cHBs
ZW1lbnQgZm9yIHRoZSBjaGFuZ2UgYmVsb3c6DQo+ID4+IGNkY2NmMWZmZTFhMyBkcm0vYW1kZ3B1
OiBGaXggY3Jhc2ggb24gZGV2aWNlIHJlbW92ZS9kcml2ZXIgdW5sb2FkDQo+ID4+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4+IENoYW5nZS1J
ZDogSWVkYzI1ZTJmNTcyZjA0NzcyNTExZDU2NzgxYjAxYjQ4MWUyMmZkMDANCj4gPj4gLS0tDQo+
ID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYyB8IDI0ICsrKysrKysr
KysrKystLS0tLS0tLQ0KPiAtLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdXZkX3Y2XzAuYw0KPiA+PiBpbmRleCBkNWQwMjNhMjQyNjkuLjJkNTU4YzJmNDE3ZCAx
MDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYw0K
PiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jDQo+ID4+IEBA
IC01MzQsNiArNTM0LDE5IEBAIHN0YXRpYyBpbnQgdXZkX3Y2XzBfaHdfZmluaSh2b2lkICpoYW5k
bGUpICB7DQo+ID4+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICopaGFuZGxlOw0KPiA+Pg0KPiA+PiArCWNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygmYWRldi0+dXZkLmlkbGVfd29yayk7DQo+ID4+ICsNCj4gDQo+IFRvIHNvbHZlIEJvcmlzJyBp
c3N1ZSwgdGhpcyBwYXRjaCBzaG91bGQgYmUgbW9kaWZpZWQgc3VjaCB0aGF0IERQTSBkaXNhYmxl
DQo+IGRvbmUgYnkgdGhlIGlkbGUgam9iIHNob3VsZG4ndCBiZSBleGVjdXRlZCBkdXJpbmcgaHdf
ZmluaS4NCj4gUHJldmVudGluZyBwb3dlcmdhdGUgZHVyaW5nIHN1c3BlbmQgaXMgbm90IG5lZWRl
ZC4NCltRdWFuLCBFdmFuXSBUaGlzIGlzIG5vdCBpbnRlbmRlZCB0byBmaXggQm9yaXMnIGlzc3Vl
LiBJdCBqdXN0IGFkZHMgdGhlIG1pc3NpbmcgaW4gcHJldmlvdXMgQW5kcmV5J3MgZml4DQpjZGNj
ZjFmZmUxYTMgZHJtL2FtZGdwdTogRml4IGNyYXNoIG9uIGRldmljZSByZW1vdmUvZHJpdmVyIHVu
bG9hZA0KDQpCUg0KRXZhbg0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+PiArCWlmIChS
UkVHMzIobW1VVkRfU1RBVFVTKSAhPSAwKQ0KPiA+PiArCQl1dmRfdjZfMF9zdG9wKGFkZXYpOw0K
PiA+PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gK3N0YXRpYyBp
bnQgdXZkX3Y2XzBfc3VzcGVuZCh2b2lkICpoYW5kbGUpIHsNCj4gPj4gKwlpbnQgcjsNCj4gPj4g
KwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhh
bmRsZTsNCj4gPj4gKw0KPiA+PiAgIAkvKg0KPiA+PiAgIAkgKiBQcm9wZXIgY2xlYW51cHMgYmVm
b3JlIGhhbHRpbmcgdGhlIEhXIGVuZ2luZToNCj4gPj4gICAJICogICAtIGNhbmNlbCB0aGUgZGVs
YXllZCBpZGxlIHdvcmsNCj4gPj4gQEAgLTU1OCwxNyArNTcxLDYgQEAgc3RhdGljIGludCB1dmRf
djZfMF9od19maW5pKHZvaWQgKmhhbmRsZSkNCj4gPj4gICAJCQkJCQkgICAgICAgQU1EX0NHX1NU
QVRFX0dBVEUpOw0KPiA+PiAgIAl9DQo+ID4+DQo+ID4+IC0JaWYgKFJSRUczMihtbVVWRF9TVEFU
VVMpICE9IDApDQo+ID4+IC0JCXV2ZF92Nl8wX3N0b3AoYWRldik7DQo+ID4+IC0NCj4gPj4gLQly
ZXR1cm4gMDsNCj4gPj4gLX0NCj4gPj4gLQ0KPiA+PiAtc3RhdGljIGludCB1dmRfdjZfMF9zdXNw
ZW5kKHZvaWQgKmhhbmRsZSkgLXsNCj4gPj4gLQlpbnQgcjsNCj4gPj4gLQlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsNCj4gPj4gLQ0K
PiA+PiAgIAlyID0gdXZkX3Y2XzBfaHdfZmluaShhZGV2KTsNCj4gPj4gICAJaWYgKHIpDQo+ID4+
ICAgCQlyZXR1cm4gcjsNCj4gPj4gLS0NCj4gPj4gMi4yOS4wDQo=
