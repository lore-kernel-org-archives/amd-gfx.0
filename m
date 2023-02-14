Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AD7C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 06:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C90E10E203;
	Tue, 14 Feb 2023 06:12:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B26710E203
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 06:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9jioYtm45Oy4jKp0ivSjR3NgY+hhbox4I60uuKpaaR7cPk9UuTsfVPbWcx914DtJIXPtlWfs/NiQ84oF3eEUVlp63ds2/Zp7D06hbwYRp00Ajprovq3/T6OsRSIFkqrY5gTyJR5r2blRsDZQDAp6tyy8Z2BXEkviq8gyzx1RBgApCX6Nafn2sBM8t8lqGvve8DT/RTapj0ybDE+f4XVGmIbzpU2fW75dg2vRBeO3f30mzwYkYmKmZTg3ozj58elTdgwEyCFd55JBTlhNnMYJXOp8b5fhPqKb0IdR3YJhx/T6JM4HuPD/HoGIvzE4ZHgR/y/FxbxukMVE4BRr8B/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5MyjYyZPVYtHmVZhCDCtpRfYUGqF/WpIQJ0QDrT3Zs=;
 b=UuEj9hyHGrVK5+QuY+NEEBBLKTI8NyU+mcL3zYtzf30lFGz+ygrfNJuLVxqQIpxigsWr72Yv3iOG3OsOY5kOMCURuq97ZuFpTISHLtpqjnHKYkLTKTcMztz80J10mzzzaK2SycGZiC65KVlNMIhnH7Z6DNGvVkuoU/ndLo9wKPSenNXCcmdAVKJIsQbzN6gS6eQftmuWntYjhelWEZctzZfT+CZbX9DD63xdhi08Mc2yUEBohj25N2C2/dzs9JSHGy+KNHQ6nGxQuc04brulxa9UykkyqEC10xjKjduruKuzGjU2cqmG4GWA6w7Iv/hT7kDjzPwq3ZY1d1ax6OF/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5MyjYyZPVYtHmVZhCDCtpRfYUGqF/WpIQJ0QDrT3Zs=;
 b=MXdWwVjkLH1b9XVlnodolAqibK5zf0AxvIZ7SyU2crJks96K1ZeUfnNhes92o0o0Wil2mX/rEpqlq/BadnScb+m28NkFqcurs6fQ7GxHOfKlEf3lP72QJYJ2Jo0dJlZEIgwXvHprwB41Ih2MN4C/6bo0bfyY5s6pl729Gcpamzc=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:12:49 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 06:12:49 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, 
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Thread-Topic: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
 bad page
Thread-Index: AQHZPSwYCyokUNaSQkeAF4mLprNJJa7M1aWAgADiPACAAC7IgIAAAvgw
Date: Tue, 14 Feb 2023 06:12:49 +0000
Message-ID: <DM5PR12MB1770C510765BC7FA52342058B0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
 <fe541c9c-4684-fd02-e5bc-f28b583744af@amd.com>
 <DM5PR12MB1770AF75B3AFA71C91FEC5D9B0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
 <623a1379-5746-1bfd-b083-c49c3cd169ea@amd.com>
In-Reply-To: <623a1379-5746-1bfd-b083-c49c3cd169ea@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|DM4PR12MB5133:EE_
x-ms-office365-filtering-correlation-id: 75382b47-51f4-471b-c34b-08db0e527f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7oxMbiaTauJ5Rl/lzabp2kFu2SXLe8LT0pU1qNirz9QFkwuEJiiRMGzc6MwXjTDocT26frnpisb6r5UXOwsw/S0PLTC2uuLS20pEcQPBo64l1a6NKmiZPeuzlOzmIoCgBrEV0AiD7l+clUZdqhJ6ptddU76YynCN/lpzHskMBuN3QBdQgdF/nVDlzAyQoLp/KMPLSUWYFenhaQDdi4fkkcAkw1ie4Hhj+xjhkq3WHxNtGxRxdsTe9uJT+m/ObEGcDM9gDAZd9Nly87iCtuvCgLCQY3iZE8sO37QY5gofxHV4SDMRqzV5bpUqQXq9trM3OT2W4PKshbQNn4gWwIIYqUYGlF0r/+TMIAUOclMzqPczMYwmGkEDcQzZVEFaBMjNjkoZXe3kHsHKvqUdYkEWm7cwYweb/64rLf/uXiYOTNK1MaN5kPpWqhMv1kkPp79krht4ImaCCjBVDFrBJf1Fv3bM7JyMOOFkLbU4TKtfQiM+IL/ZSAtDWXqJU2TIYXYx9XK4Ec32GNDEBDlE1vd1DJ/PRxOMsWaG3rC4m3AphkYLTvWYmsi+BO2QFZIO19ZlcQ3GzX3+GJi5EEa1D380ct/cGWW/qz3aM7YQPFSpWOFu0EoocFnVtE1WrV5qpgS2n0bXtySGAMynuskpmqGJ7ofHsU2oGGBXch3vEkQSH4/XpyWOm+MsNkLi8dg4Qw4jkDeR/lnChQkYTSNFXiXXtgMJ9QOFKABBOMIWPfk+Pqk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(38070700005)(2906002)(5660300002)(71200400001)(83380400001)(55016003)(26005)(186003)(921005)(122000001)(6636002)(76116006)(66476007)(66446008)(38100700002)(64756008)(8676002)(66946007)(8936002)(316002)(66556008)(9686003)(33656002)(41300700001)(478600001)(6506007)(53546011)(110136005)(86362001)(52536014)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWRqdmU0Y2dTOXdySTU4K1NwbWhEVFBnQVE4QTliVlF0aVRrbjc5MWdmdjNW?=
 =?utf-8?B?YkIzUUUyVzFLR1NjcDkxQ0t4Z1V4WHVNbXVRSVYxdlk4ckNIVWxKOTRhVU83?=
 =?utf-8?B?My95MWpsejFESUtqVVpnSEZOT2t2Y0VYK2x2aGlEMnJCQUxWc1llV21UM3JN?=
 =?utf-8?B?NjhSeU83VzhsTjYvWDNkcVliK0tjY250NHk0WFp5VTBLSXlMUVFPaHFZQlZX?=
 =?utf-8?B?VVBYQUdGOFVIWVpXeWpENExra0JHZWtWODFMVFVZKzk5OWVjUDc2U3FvVUpq?=
 =?utf-8?B?dHR4RC9OMTlwSithWmtvVzlOa3FPTldDUHdWVVJDallCQXE5OGdDSVhNRFVh?=
 =?utf-8?B?Vlc4NlNVd3lvRUVQZ1ZCbUg5WjNjU2ovWU5zVzRqSmdoaFh5YmlXVUpIdVp3?=
 =?utf-8?B?WUxPTWhoWHhjd1R5RDRSRkExbHBLcm5FeCt0Y09yZHZwRlg3ZlVJN3dGTjJo?=
 =?utf-8?B?YUkzU3Q3V2o1RmVoaXd6U3dlaXhvOVdFUjBMdEFiNnprYnlEQ2U1emlxZVpr?=
 =?utf-8?B?MmZWamxMV3dZSzdWS2FUYTdrb3BNQ0VmNS96MS9pb2h6enNGTy9JVEZ4UFpy?=
 =?utf-8?B?bjFqeXR6VFdOUldtNm8xQkVoa1NkM3FtdFQrMTZBUXpPVTBsOTJEajNUNmhr?=
 =?utf-8?B?QmN0UWNuWlQ3U20rM1RnNytYODJEVDFDZWJXRkYvc08yWnRVc0M1eEJJUlZO?=
 =?utf-8?B?Zk9DU1FSbEJaYW01NFNCTGJQdGVQU3kxMGpQcXJxSlo5Q3pHbWxvdHlLY2ZC?=
 =?utf-8?B?SU9wOG1PQzJiSG9UTlllZFpmamFkUElKMFl3bXdGTDlxWFpOaEE3VmtBYzBE?=
 =?utf-8?B?N2ZkczhRaUVyMHBNUFB2dzFyMkJkVmQvWHlwWmpaQXJMUUZvWFdqRVA2NkdJ?=
 =?utf-8?B?cEVhRnRwUTFBMTY5bGtFZGwvWUZHOXhXNVZvTTB3K1cxWlE2SUg4MUxhNmNS?=
 =?utf-8?B?MlZ0Ny9FVEVzQmNGNytMaE54Vzl4M3RsMDlKK05Qb2lQZ291UzJBaGZLcGtX?=
 =?utf-8?B?UWRqLzNxNUhBQlplUTdYbE1VamRYTkhLWlVTTTlISmVUMGNFRVRCTmRkSHQ5?=
 =?utf-8?B?eGpLVE5uRGZKV0tWdnZtNER0cmluT2J3V3laRE9Tclk2R2EyV0pYWUR2QUlE?=
 =?utf-8?B?T05GWm9TRFYxcGVOeS9MUXVqOFladXJmdk11QnR5VlZWUnQxWlRSMFp5YkVT?=
 =?utf-8?B?TFBiZ3psWW9HMjc0S2pUa2V0K1IxMm1hc2pvQUJzQlZJWEQxWEQrVEZlUkRl?=
 =?utf-8?B?N0lQVVVNV0RRN3dQdWRTcGd4OE5jNDBLVzNPRTFGUHZUSzEzQ0J2WDgvYjZm?=
 =?utf-8?B?bXlHMnBidUtoQisrTWJMbDlvTHowbklyRGllbmIrZytVTHZkL05EMWx5ZHB6?=
 =?utf-8?B?MEx1WnlFR2V3MGl4UlpGbDIvRUM4NDRPZTNMd3FqRDJ1NHBzVFlVVEMzSHY3?=
 =?utf-8?B?b2NaZlQ2cEJ1QmNlNWpFbDVpcXpZUE1idjk4ZVROemIzd2RtUjVxVVk1T3dn?=
 =?utf-8?B?NFN1aitJbEV1TThvL1dBS1Bua3hRZEdBM0tQQzErMmpBNnJkeVZLVlpNSjNw?=
 =?utf-8?B?bmlsbDVPck8vdk5vM1VXcFpmeUppY0RMRTAwVVcvQW1HL09FZEtYTlpOOGdy?=
 =?utf-8?B?Rzd5MzFVaHkydlhhNFdvWDF6dTBlUmtFZVdkSG9INHJLRk9uMVo3ZmIrOWRD?=
 =?utf-8?B?MFFXL0J1clpKMmgxTGJVTkhWMGJId1B6NU82SFg3YTM2aTRlK1lOY0haeFdL?=
 =?utf-8?B?bGo1SGI2L1hwQ3k1SFFObGhRWHMyM01URm91ckNUMkhJSVBRakpvMmtndFhJ?=
 =?utf-8?B?NlF6TXhBSGE2bWNPOVBHS2xvaVNJQmplNzNUeG1TUmxIaHJLWUxVckFLQ3kz?=
 =?utf-8?B?c0c2d25GM2Q0MmU1TEduaUlJeDdKUFA5MlJtMWdacHBmZERBZ2lKRFI0NDdO?=
 =?utf-8?B?RTcvY0I3UFhJYnMwVDVFeDhqYW5vQkFkQ2VvcVBVQS9zTkZtUE9wWWE0MnRC?=
 =?utf-8?B?eHFHVlJCQzFEc2RUN0lPUS9JR0xJR3JLQlBaT1ZEa2xwTVk0NVZ3MzRFUmVs?=
 =?utf-8?B?UVlEYmdkbzM3MUsxZGlYOUpYUG8ya0hua2dDRXE5cTNJUzlSWXJDMnh3dml3?=
 =?utf-8?Q?e8AI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75382b47-51f4-471b-c34b-08db0e527f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:12:49.3322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OorjJIVcXThd0D4TwBib0mVNsF9RTcl6kT6zt3caZqBdhhPsvnPMcadSL46v4MFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTQsIDIwMjMgMTI6
NTUgUE0NCj4gVG86IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLA0KPiBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+OyBZYW5nLCBTdGFubGV5DQo+IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IENoYWksIFRob21h
cyA8WWlQZW5nLkNoYWlAYW1kLmNvbT47IExpLCBDYW5kaWNlDQo+IDxDYW5kaWNlLkxpQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGRvbid0IGluY3JlYXNlIFVN
QyBSQVMgVUUgY291bnQgaWYgbm8gbmV3DQo+IGJhZCBwYWdlDQo+IA0KPiANCj4gDQo+IE9uIDIv
MTQvMjAyMyA3OjU2IEFNLCBaaG91MSwgVGFvIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJA
YW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMywgMjAyMyA4OjM4IFBNDQo+
ID4+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOw0KPiA+PiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PjsgWWFuZywgU3RhbmxleQ0KPiA+PiA8U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBDaGFpLCBUaG9t
YXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+OyBMaSwNCj4gPj4gQ2FuZGljZSA8Q2FuZGljZS5MaUBh
bWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBkb24ndCBpbmNy
ZWFzZSBVTUMgUkFTIFVFIGNvdW50IGlmDQo+ID4+IG5vIG5ldyBiYWQgcGFnZQ0KPiA+Pg0KPiA+
Pg0KPiA+Pg0KPiA+PiBPbiAyLzEwLzIwMjMgMjoxNSBQTSwgVGFvIFpob3Ugd3JvdGU6DQo+ID4+
PiBJZiBhIFVNQyBiYWQgcGFnZSBpcyByZXNlcnZlZCBidXQgbm90IGZyZWVkIGJ5IGFuIGFwcGxp
Y2F0aW9uLCB0aGUNCj4gPj4+IGFwcGxpY2F0aW9uIG1heSB0cmlnZ2VyIHVuY29ycmVjdGFibGUg
ZXJyb3IgcmVwZWF0bHkgYnkgYWNjZXNzaW5nIHRoZSBwYWdlLg0KPiA+Pj4NCj4gPj4NCj4gPj4g
VGhlcmUgaXMgYW1kZ3B1X3Jhc19jaGVja19iYWRfcGFnZSB3aGljaCBjaGVja3MgaWYgYWRkcmVz
cyBpcyBhbHJlYWR5DQo+ID4+IHBhcnQgb2YgYW4gZXhpc3RpbmcgYmFkIHBhZ2UuIENhbid0IHRo
YXQgYmUgdXNlZD8NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBMaWpvDQo+ID4NCj4gPiBbVGFv
XSBhbWRncHVfcmFzX2NoZWNrX2JhZF9wYWdlIGlzIGFscmVhZHkgY2FsbGVkIGluDQo+IGFtZGdw
dV9yYXNfYWRkX2JhZF9wYWdlcywgdGhpcyBwYXRjaCBqdXN0IG1ha2VzIHVzZSBvZiB0aGUgcmVz
dWx0IG9mDQo+IGFtZGdwdV9yYXNfY2hlY2tfYmFkX3BhZ2UuDQo+ID4NCj4gDQo+IEluIHRoZSBw
YXRjaCwgYmVsb3cgdHdvIGFyZSBjYWxsZWQgYWZ0ZXIgZXJyb3IgY291bnQgaXMgc2V0IHRvIDAu
DQo+IAlhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzDQo+IAlhbWRncHVfZHBtX3NlbmRfaGJtX2Jh
ZF9wYWdlc19udW0NCj4gDQo+IEluc3RlYWQgb2YgdGhhdCwganVzdCBjaGVjayBpZiBpdCdzIGFu
IGV4aXN0aW5nIGJhZHBhZ2Ugd2hpY2ggaXMgcmVwZWF0ZWRseQ0KPiBhY2Nlc3NlZCBhbmQgcHJv
Y2VlZCBkaXJlY3RseSB0byB0aGUgbmV4dCBzdGVwIChyZXNldCBpZg0KPiBzcGVjaWZpZWQpDQo+
IA0KPiAJaWYgKGFtZGdwdV9yYXNfY2hlY2tfYmFkX3BhZ2UoYWRldiwgYWRkcmVzcykpDQo+IAkJ
c2V0IGVycm9yIGNvdW50IHRvIDA7DQo+IAkJZ290byByZXNldF9sb2dpYzsNCj4gDQo+IFRoYW5r
cywNCj4gTGlqbw0KDQpbVGFvXSAxLiBhbWRncHVfcmFzX2NoZWNrX2JhZF9wYWdlIGNoZWNrcyBv
bmx5IG9uZSBwYWdlLCBidXQgb25lIHVlIGNhbiBnZW5lcmF0ZSAxNiBvciBtb3JlIHBhZ2VzLg0K
Mi4gaWYgbm8gbmV3IGJhZCBwYWdlIGlzIGZvdW5kLCBhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2Vz
IHdpbGwgZG8gbm90aGluZyBhbmQgcmFzX251bV9yZWNzIHdvbid0IGluY3JlYXNlLg0KMy4gZ3B1
IHJlc2V0IGxvZ2ljIHNob3VsZCBmb2xsb3cgdGhlIG9sZCB3YXkgZXZlbiB1ZSBjb3VudCBpcyBz
ZXQgdG8gMC4NCg0KVGhpcyBwYXRjaCBvbmx5IHNldCB1ZSBjb3VudCB0byAwIGlmIHRoZXJlIGlz
IG5vIG5ldyBiYWQgcGFnZSwgYnV0IG90aGVyIGxvZ2ljIGhhcyBubyBjaGFuZ2UuDQoNCj4gDQo+
ID4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+DQo+
ID4+PiAtLS0NCj4gPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YyB8IDkgKysrKysrKystDQo+ID4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdW1jLmMgfCA2ICsrKysrLQ0KPiA+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4+PiBpbmRleCBlODVjNDY4OWNlMmMuLmVhZmUw
MWEyNDM0OSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jDQo+ID4+PiBAQCAtMjA0OSw3ICsyMDQ5LDcgQEAgaW50IGFtZGdwdV9yYXNfYWRkX2Jh
ZF9wYWdlcyhzdHJ1Y3QNCj4gPj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPj4+ICAgIHsNCj4g
Pj4+ICAgIAlzdHJ1Y3QgYW1kZ3B1X3JhcyAqY29uID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChh
ZGV2KTsNCj4gPj4+ICAgIAlzdHJ1Y3QgcmFzX2Vycl9oYW5kbGVyX2RhdGEgKmRhdGE7DQo+ID4+
PiAtCWludCByZXQgPSAwOw0KPiA+Pj4gKwlpbnQgcmV0ID0gMCwgb2xkX2NudDsNCj4gPj4+ICAg
IAl1aW50MzJfdCBpOw0KPiA+Pj4NCj4gPj4+ICAgIAlpZiAoIWNvbiB8fCAhY29uLT5laF9kYXRh
IHx8ICFicHMgfHwgcGFnZXMgPD0gMCkgQEAgLTIwNjAsNg0KPiA+Pj4gKzIwNjAsOCBAQCBpbnQg
YW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+
Pj4gICAgCWlmICghZGF0YSkNCj4gPj4+ICAgIAkJZ290byBvdXQ7DQo+ID4+Pg0KPiA+Pj4gKwlv
bGRfY250ID0gZGF0YS0+Y291bnQ7DQo+ID4+PiArDQo+ID4+PiAgICAJZm9yIChpID0gMDsgaSA8
IHBhZ2VzOyBpKyspIHsNCj4gPj4+ICAgIAkJaWYgKGFtZGdwdV9yYXNfY2hlY2tfYmFkX3BhZ2Vf
dW5sb2NrKGNvbiwNCj4gPj4+ICAgIAkJCWJwc1tpXS5yZXRpcmVkX3BhZ2UgPDwgQU1ER1BVX0dQ
VV9QQUdFX1NISUZUKSkNCj4gPj4gQEAgLTIwNzksNg0KPiA+Pj4gKzIwODEsMTEgQEAgaW50IGFt
ZGdwdV9yYXNfYWRkX2JhZF9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4g
Pj4+ICAgIAkJZGF0YS0+Y291bnQrKzsNCj4gPj4+ICAgIAkJZGF0YS0+c3BhY2VfbGVmdC0tOw0K
PiA+Pj4gICAgCX0NCj4gPj4+ICsNCj4gPj4+ICsJLyogYWxsIHBhZ2VzIGhhdmUgYmVlbiByZXNl
cnZlZCBiZWZvcmUsIG5vIG5ldyBiYWQgcGFnZSAqLw0KPiA+Pj4gKwlpZiAob2xkX2NudCA9PSBk
YXRhLT5jb3VudCkNCj4gPj4+ICsJCXJldCA9IC1FRVhJU1Q7DQo+ID4+PiArDQo+ID4+PiAgICBv
dXQ6DQo+ID4+PiAgICAJbXV0ZXhfdW5sb2NrKCZjb24tPnJlY292ZXJ5X2xvY2spOw0KPiA+Pj4N
Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1j
LmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VtYy5jDQo+ID4+
PiBpbmRleCAxYzdmY2I0ZjIzODAuLjc3MmM0MzFlNDA2NSAxMDA2NDQNCj4gPj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuYw0KPiA+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VtYy5jDQo+ID4+PiBAQCAtMTQ1LDggKzE0NSwx
MiBAQCBzdGF0aWMgaW50DQo+IGFtZGdwdV91bWNfZG9fcGFnZV9yZXRpcmVtZW50KHN0cnVjdA0K
PiA+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPj4+DQo+ID4+PiAgICAJCWlmICgoYW1kZ3B1
X2JhZF9wYWdlX3RocmVzaG9sZCAhPSAwKSAmJg0KPiA+Pj4gICAgCQkJZXJyX2RhdGEtPmVycl9h
ZGRyX2NudCkgew0KPiA+Pj4gLQkJCWFtZGdwdV9yYXNfYWRkX2JhZF9wYWdlcyhhZGV2LCBlcnJf
ZGF0YS0+ZXJyX2FkZHIsDQo+ID4+PiArCQkJcmV0ID0gYW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2Vz
KGFkZXYsIGVycl9kYXRhLQ0KPiA+Pj4gZXJyX2FkZHIsDQo+ID4+PiAgICAJCQkJCQllcnJfZGF0
YS0+ZXJyX2FkZHJfY250KTsNCj4gPj4+ICsJCQkvKiBpZiBubyBuZXcgYmFkIHBhZ2UgaXMgZm91
bmQsIG5vIG5lZWQgdG8gaW5jcmVhc2UgdWUNCj4gPj4gY291bnQgKi8NCj4gPj4+ICsJCQlpZiAo
cmV0ID09IC1FRVhJU1QpDQo+ID4+PiArCQkJCWVycl9kYXRhLT51ZV9jb3VudCA9IDA7DQo+ID4+
PiArDQo+ID4+PiAgICAJCQlhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzKGFkZXYpOw0KPiA+Pj4N
Cj4gPj4+ICAgIAkJCWFtZGdwdV9kcG1fc2VuZF9oYm1fYmFkX3BhZ2VzX251bShhZGV2LA0KPiA+
Pj4gY29uLT5lZXByb21fY29udHJvbC5yYXNfbnVtX3JlY3MpOw0K
