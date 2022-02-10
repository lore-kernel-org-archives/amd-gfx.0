Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B162DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 15:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE0C10E896;
	Thu, 10 Feb 2022 15:42:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6926810E896
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 15:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvXOH2kFQLkd+AVwpXpIIjbbIbCCfZLaJDQ90DMkb9EkQkGarqlwQ8eJwOJXb1nikWazeJFEbmD6MN0nBn6fJS8aT8+oVXXOgYwtdEJi8u0UIcHypuoh+IkxuauH0qyX74RF2InoqJkmi5c5ARwidtSQLc3i+IV23H1nLG0RqvemBzyCMBg8zNdWKXSGGzSy/1ueatqnTZxeA5m+1ynaWfy8qv1a+ZPJI10haaS3eUoTjDUv4SSVWxjSmjhpzI/91+jJLF41mGTMFIhUovgVIFr3Ee7I1tQ+BTMwk0UYpqtSqCEUzxeINeNsQtOpv1kSNSg8Uxy/Ml0VBX7quQJZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huHFpZQLvQVQUoctVcqc1omsajaSCrpkkgH31PYnhnA=;
 b=ZL3X/lIphM2y+bNoWFRZTgmAK0qaz6N8z3cMIJxHE03nYZXOiNXCJpFFyUfW/3eoHruMWH9uRoQarON9I3p6OhqiJRh24fmbayIBuVlbXnWpUeubMAaVyixktZ4PGjp9o68uiT1ueuCaaFN92oa7v+nEQBXw4C1bS0UhfGWum8QPtainziWyj5KhpjuZxl6AxECgVt6tf9RgbHM8AV5eNKUTIWc/RZOmhQ87Ngj6qqcpi30hpZXwnyZQiGB72+LFP1wOcjocojRDaqOjqYHExNMfbmmnFA66ejaVQz6KtwRXb370+nHQPkrDJzgHCVEygCfPwI4AD/wLdudcjS14Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huHFpZQLvQVQUoctVcqc1omsajaSCrpkkgH31PYnhnA=;
 b=kMcajiZl8dM2CMW9rc8HRcdGgfoHB9NgofZgyt/zWYaxLWmChK3nIyQes06JOQzYi56QQssoB1Qmb+S/9BK+eDtQHoaueGGqvCbCm9RGcpytaHz3x2me3USGWCxny8ceq14sRQJwFqkgilz+KvOtefP7mL5vVEcMPFDlLcINKOs=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN6PR12MB1266.namprd12.prod.outlook.com (2603:10b6:404:14::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 15:42:04 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 15:42:04 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
Thread-Topic: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for
 S0ix.
Thread-Index: AQHYHoMU8Guv8NP4lkmx1o/laTSQ/ayM0LrggAAX4wCAAALn4A==
Date: Thu, 10 Feb 2022 15:42:04 +0000
Message-ID: <BL1PR12MB51574E5BD540B48C975D7502E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220210133507.5954-1-rajib.mahapatra@amd.com>
 <BL1PR12MB5157740FA3CFB17B93165A19E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_NQDUyQYKGu3==HhzVN-tjriKjxH4mGgEuKqiX4ffo8ng@mail.gmail.com>
In-Reply-To: <CADnq5_NQDUyQYKGu3==HhzVN-tjriKjxH4mGgEuKqiX4ffo8ng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-10T15:41:48Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1754bb42-fc3c-4d73-b03b-e155c14954dd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-10T15:42:02Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2297d49e-9814-4cac-82b3-a95e2309affb
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58c0e050-77f4-4f53-7035-08d9ecabe321
x-ms-traffictypediagnostic: BN6PR12MB1266:EE_
x-microsoft-antispam-prvs: <BN6PR12MB126691A96B4774727859CD84E22F9@BN6PR12MB1266.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OY+kOkeTcs4eVbmnSWYB1jutEM9DwsmBGmXFC33SZApb+mNzF5auxh2zGdUJqGmxX2ES4/AMlvPeI8vj8S6eYXzdz9Q+6WvNtLeg5aR8K3HO/lEAbEPnpW43H7d1w240Kh7+oCFrrX0xZVFgJugywXe4ZvCF0BYRm8im6EJSMCojKYlXc3RZ3c9FNk2gP9TULwYi7TRe6CPmwBr0GPlEBVvh9FikMcEz6g9rSkIAwln7fX32KpVNNY/qxeiKunv3ZfPDxMWGF9mNwA6KMm3gEpEtR6DBi4d03glHnfqM3rb4eZ6C37UOYaj4iGzSA6eEg4LGR/K5xkfjnnbarGpXeWDYFED9aUE99jxzhYWMotcVu1W732AX95AU8hGkQzdxNPcjcBDOjyR1KUA/mMwAa4O0QumaRYcjxSDUKpKOtrrNPDBBLj6hCICFwSTMxiEPAeDozMzXht95oeiC1Lt0JHTprGlZLHoBnBT9A7DH+nbPt/3k0uKfkEr1ZSl5qG4/7GDmno4tsBJK+DqyumiDBmQYJHM/hi4DryslZJXh4ieAvCRxKDEDu0I7rxk8iBuEmYo5CdwnFWqEKrg89i3OorqCfLLHzdyhByR2cXR+x6dCsXdqOzGxLbDfun9+py5rtNPQQZITZPZ6Cn168GDMo2E6XKmgFCluJ/p2Ou0w13lyii4Xer9pUGik11sMa71saN38C37fzvyA3QGpiMk+77xJAMEZnqOOviLWr+B3UfI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(52536014)(38070700005)(76116006)(66446008)(66476007)(66946007)(38100700002)(9686003)(5660300002)(64756008)(4326008)(2906002)(8676002)(66556008)(122000001)(83380400001)(7696005)(6506007)(54906003)(6916009)(8936002)(508600001)(316002)(33656002)(55016003)(186003)(86362001)(71200400001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzBkSnUvKzJuMUpuZTUyQXQ1N21iZTJqMXVxbDhITHY0MTdBRFNxTXJReHRD?=
 =?utf-8?B?NmdCWi9MY0VERUJ5c0dKVTBGdWIxNGN5QVBvYkRBV2t0UGRqWGlOcTFQWGJK?=
 =?utf-8?B?OHhTWFRXSjBGdjkrU0NvZnBZR2ROQjNUMWo2VnlmWDlLWURReVNvR1lCMUJU?=
 =?utf-8?B?QllIbGFRRWs2eUFCNmtEbXM0YW9sQ1RPWmhxaW1RU3lwTTlISHNNY0hnU1A3?=
 =?utf-8?B?clhZWXFFaUZRaTBPTTA2Z0ZnRFlBNHU5WEhwc0RpTHFlUDFsNC9oYVk2Mkxw?=
 =?utf-8?B?NEk5aFB2R3RWZFZ5TmdqaVE5Y3NzWW9zSEZSY2xiSW41VFk5aWtXQmlPeTAy?=
 =?utf-8?B?QldkOUZPbk16TXJNK2s1MWZpNHlSS3M3Y0wvTmxaVTQzak5RK0ZENkdXVDJo?=
 =?utf-8?B?Zzh0VmhmSjk1K0JJWm51cEM1NTZHUk9MTWRTTTdyWUtxSGtKZ005anhRQXJK?=
 =?utf-8?B?QUNRanllbjRCdEgydGdYbEFXTC93N2pEWFVRaE9MNWNVdE1PUXhvckpCWXdG?=
 =?utf-8?B?bEFyNFpzRnJSZC9ranFqN1lwakl5VEV4MXljWnVVakJ0dUVrSERyRXpiYnVW?=
 =?utf-8?B?S1NaVEx5eEsvMGFpc1lUa0tUNFNqRjFNbHVSWnFSbCtRTzljc1ZxME1PR1dx?=
 =?utf-8?B?QW5ZcDRHY0ZPMUc0YXFYUUlteW1WSnZoL2RZcHZNaGdVcG5zRkw1MEtneEFG?=
 =?utf-8?B?NmFjODZWU2lGTlBiVGpJVjZKYnVaN3Q2bHhOZlBKK2xaMzIvQ0hsVkZvVDlk?=
 =?utf-8?B?VHVWRWpEa2Y3cXJ5a2ZJazNLK0c5UDY3NE4zMG9ZYmxMS2ZlRTNRQUg2bmtu?=
 =?utf-8?B?ZGE1eExhZkVwWVk1SlJMRGcxYitDdjFidTdoWlBmb1JnRDlQNEFCN2pyQXh2?=
 =?utf-8?B?dW1QejczdlVlZFkySUZ3NUQrVkFKTTNPQVIybG9ZVVREdFAxc0grQVd6L282?=
 =?utf-8?B?S1JIMGJoNmZGWTE4R2JWc3puZG5Eek9OdG96VWtkUXJsUFY4V3hlcUZrL24y?=
 =?utf-8?B?UlQ5SVdPQXZiVjBZNzVQcnVUMU5mWU5XQ0prbm54WlpETi9pcUhlQ2JlMytO?=
 =?utf-8?B?VDRxWW92QWZTazNsZUV4Q2p2MU96KzNqNWRucjc5MkVwdlo0blJ1dUZmV0xX?=
 =?utf-8?B?RlYvVjJvbVpDOTgxcVNXUkpzY1hIN255amZGSFg2M2pUNmtnWFNmU1JnRmhk?=
 =?utf-8?B?eldGSG5HLzN0QmFTYVpzRVJ6L0dEOFFBRm9sdTRGczVReklLdUkxbVk1TkRx?=
 =?utf-8?B?Y0NDN1lOWmtsT2JJOHFoNXVTc2RzUGxuNDZIcUhZRHdFQkExamVHblVQbVZv?=
 =?utf-8?B?MWpQem45eFYwT1M3enViZ0dyL1dEMUlyOUNRZGpuZE9XTnNSTFRrbGN6TGVW?=
 =?utf-8?B?bktzd1p4d1hKWnNzVnV6ZHV0eU5Xb2ZhYW9IS1ZCVlhFQkptVy9sOVpub1JD?=
 =?utf-8?B?UzJIREJ5RVNnOE9zTVVLMWZCU0hhK0k5dWhORHpiMmZiY1ljYlZtVDBuUnJs?=
 =?utf-8?B?V0p0bTFLMm9meCtSMGFheTlINmNhRjRHdjMzQ2h3MnUrQThnZFBqYmxra2l2?=
 =?utf-8?B?VHpvUlV2dlJubjhOdnZndlg0QXRCT2FhMERzZUd6ZGQ5VjJ3cWhtbUhTdmU1?=
 =?utf-8?B?UHdMbHBmRWliTzJoWVZvUGZvMTE1TTZCNkNaZG00YVRycTVvNFBobmg5TEh2?=
 =?utf-8?B?VWJwU1lqdFN1OWdYbEkwV3doVk1sMnlVdUlyczYyc2pSakdMbEc3aENOYXpR?=
 =?utf-8?B?UjBQdHNZbVFnTVRGbzhqY0MxNGxCbXYyUDdLakVQNU9yQ0J4ajVyWk5FUFhl?=
 =?utf-8?B?b3ZiZkFjeEJMTHpiaXJMd013L21GY25DWGdRMEg1RjdXTXprNkJPY0ZRNWdj?=
 =?utf-8?B?RWF2bWgwVnJnL1BpSmIrNlV6NTlEbjhHRmJ0S2NtQ0I3akVXVXhUdDk2Wlls?=
 =?utf-8?B?UGp6SXozeFNyKzB0M2ZsajFnaUZsOHd3N1Z4N2hPN1V5cTNnc3pUdFNqNkU2?=
 =?utf-8?B?NTNPZ25aN1ErR1QxVW55U2hXQ0RvOE82ZXFCYm1pK2kxamo0YmhMZWpIc3V1?=
 =?utf-8?B?OWQrL0lwaUdCeVFZc0lOdVpyL1dmMUlIQU9TbUF6c1F4TXN0VHRPaThTcmtU?=
 =?utf-8?B?VGpLeXk1Q0dHUjlCTCtaOGJ6bWNlMmlZT0pxaHhPYnUwOFp6cDl0K3BPbkxZ?=
 =?utf-8?B?ZVlmYzVRNXNKS3E4Z3lUMnl0WWZuSHovVExLelQrWVAweFFObmtEbnpxL1lY?=
 =?utf-8?Q?+itKlh3oLUTnU4KY+YDpW99zZmwwhgFHnsVkU7qx0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c0e050-77f4-4f53-7035-08d9ecabe321
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 15:42:04.2412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfoJgxUmwMynB037QzX0s1m2xSZkz1OJgkybDTK9+BOpjetblcGZv8+XrwDtYcqAnwZWCO34eCgLIHj7wDB8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1266
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Mahapatra,
 Rajib" <Rajib.Mahapatra@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJy
dWFyeSAxMCwgMjAyMiAwOToyOA0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1v
bmNpZWxsb0BhbWQuY29tPg0KPiBDYzogTWFoYXBhdHJhLCBSYWppYiA8UmFqaWIuTWFoYXBhdHJh
QGFtZC5jb20+OyBMaWFuZywgUHJpa2UNCj4gPFByaWtlLkxpYW5nQGFtZC5jb20+OyBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsgUywgU2hpcmlzaCA8U2hpcmlzaC5TQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IHNraXBwaW5nIFNETUEgaHdfaW5pdCBhbmQg
aHdfZmluaSBmb3INCj4gUzBpeC4NCj4gDQo+IE9uIFRodSwgRmViIDEwLCAyMDIyIGF0IDk6MDQg
QU0gTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPiB3cm90
ZToNCj4gPg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWFoYXBhdHJhLCBSYWppYiA8UmFqaWIuTWFoYXBh
dHJhQGFtZC5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTAsIDIwMjIgMDc6
MzUNCj4gPiA+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBMaW1vbmNp
ZWxsbywgTWFyaW8NCj4gPiA+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+ID4gPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgUywgU2hpcmlzaCA8U2hpcmlzaC5TQGFtZC5j
b20+Ow0KPiA+ID4gTWFoYXBhdHJhLCBSYWppYiA8UmFqaWIuTWFoYXBhdHJhQGFtZC5jb20+DQo+
ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IHNraXBwaW5nIFNETUEgaHdfaW5p
dCBhbmQgaHdfZmluaSBmb3INCj4gUzBpeC4NCj4gPiA+DQo+ID4gPiBbV2h5XQ0KPiA+ID4gU0RN
QSByaW5nIGJ1ZmZlciB0ZXN0IGZhaWxlZCBpZiBzdXNwZW5kIGlzIGFib3J0ZWQgZHVyaW5nDQo+
ID4gPiBTMGkzIHJlc3VtZS4NCj4gPiA+DQo+ID4gPiBbSG93XQ0KPiA+ID4gSWYgc3VzcGVuZCBp
cyBhYm9ydGVkIGZvciBzb21lIHJlYXNvbiBkdXJpbmcgUzBpMyByZXN1bWUNCj4gPiA+IGN5Y2xl
LCBpdCBmb2xsb3dzIFNETUEgcmluZyB0ZXN0IGZhaWxpbmcgYW5kIGVycm9ycyBpbiBhbWRncHUN
Cj4gPiA+IHJlc3VtZS4gRm9yIFJOL0NaTi9QaWNhc3NvLCBTTVUgc2F2ZXMgYW5kIHJlc3RvcmVz
IFNETUENCj4gPiA+IHJlZ2lzdGVycyBkdXJpbmcgUzBpeCBjeWNsZS4gU28sIHNraXBwaW5nIFNE
TUEgc3VzcGVuZCBhbmQNCj4gPiA+IHJlc3VtZSBmcm9tIGRyaXZlciBzb2x2ZXMgdGhlIGlzc3Vl
LiBUaGlzIHRpbWUsIHRoZSBzeXN0ZW0NCj4gPiA+IGlzIGFibGUgdG8gcmVzdW1lIGdyYWNlZnVs
bHkgZXZlbiB0aGUgc3VzcGVuZCBpcyBhYm9ydGVkLg0KPiA+ID4NCj4gPiA+IHYyOiBhZGQgY2hh
bmdlcyBvbiBzZG1hX3Y0LCBza2lwcGluZyBTRE1BIGh3X2luaXQgYW5kIGh3X2ZpbmkuDQo+ID4N
Cj4gPiBUaGlzIGxpbmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBiZSAiYmVsb3ciIHRo
ZSAtLS0NCj4gPg0KPiA+IEJlc2lkZXMgdGhhdCB0aGUgY29kZSBpcyBiZXR0ZXIuDQo+ID4NCj4g
PiBSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5j
b20+DQo+IA0KPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPg0KPiANCj4gSSBwcmVzdW1lIHNkbWFfdjUuMi5jIG5lZWRzIGEgc2ltaWxhciBmaXg/
DQoNClZHIGRvZXNuJ3QgZG8gczBpMyByaWdodD8NCk5vLCBZQyBzaG91bGQgbm90IHRha2UgYSBz
aW1pbGFyIGZpeC4gICAgWUMgaGFkIGFuIGFyY2hpdGVjdHVyYWwgY2hhbmdlIGFuZCB0byANCmF2
b2lkIGEgInNpbWlsYXIiIHByb2JsZW0gdGFrZXMgMjZkYjcwNmE2ZDc3YjllMTg0ZmViMTE3MjVl
OTdlNTNiN2E4OTUxOS4NCg0KPiANCj4gQWxleA0KPiANCj4gDQo+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFJhamliIE1haGFwYXRyYSA8cmFqaWIubWFoYXBhdHJhQGFtZC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyB8IDggKysr
KysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jDQo+
ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jDQo+ID4gPiBpbmRl
eCAwNmE3Y2VkYTRjODcuLjAyMTE1ZDYzYjA3MSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYw0KPiA+ID4gQEAgLTIwNTgsNiArMjA1OCwxMCBAQCBz
dGF0aWMgaW50IHNkbWFfdjRfMF9zdXNwZW5kKHZvaWQgKmhhbmRsZSkNCj4gPiA+ICB7DQo+ID4g
PiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqKWhhbmRsZTsNCj4gPiA+DQo+ID4gPiArICAgICAvKiBTTVUgc2F2ZXMgU0RNQSBzdGF0ZSBm
b3IgdXMgKi8NCj4gPiA+ICsgICAgIGlmIChhZGV2LT5pbl9zMGl4KQ0KPiA+ID4gKyAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPiA+ICsNCj4gPiA+ICAgICAgIHJldHVybiBzZG1hX3Y0XzBfaHdf
ZmluaShhZGV2KTsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gQEAgLTIwNjUsNiArMjA2OSwxMCBA
QCBzdGF0aWMgaW50IHNkbWFfdjRfMF9yZXN1bWUodm9pZCAqaGFuZGxlKQ0KPiA+ID4gIHsNCj4g
PiA+ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2
aWNlICopaGFuZGxlOw0KPiA+ID4NCj4gPiA+ICsgICAgIC8qIFNNVSByZXN0b3JlcyBTRE1BIHN0
YXRlIGZvciB1cyAqLw0KPiA+ID4gKyAgICAgaWYgKGFkZXYtPmluX3MwaXgpDQo+ID4gPiArICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gKw0KPiA+ID4gICAgICAgcmV0dXJuIHNkbWFfdjRf
MF9od19pbml0KGFkZXYpOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4x
DQo=
