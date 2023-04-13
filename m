Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C632C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 02:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592F910E084;
	Thu, 13 Apr 2023 02:16:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1707B10E084
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 02:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmPByKRUXbh0CIATZnfxZh5w2U4ubrX8+NUXNBiosUxtrDNxmUVweAr2w0HFhMzb9vdXdbQBVjKiHmfyNbc6DLgSQnir+nZTmtyQY8Fa56HXERJ0t/2FWdG2GJzB8vbAWYsdBblgmWW4bBYWpKQ84F8+EcTNVvNHJhSNtasHS4H4nRDK7TiRXj8N3NzX9GC5zUd8qxbNUHRmQTlJ0iQtYVrQ28aWiaRI2nl44GOU5wS2L1BnN6hKw/Olm042U78XBrYVdtd1CZ7wCY+MWS8hjNEX/KgO54KhH0cxtNnW61YSHf/BLReKaAbjy9TKzl6ps7ayeThG8SQHiQMNFKlv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChH8+OW5a4Prq0XZXvi4WOkVPVyI0FfuzMvKs/Y15TE=;
 b=GB+G5TIx3sNd/6uEUjq3iPNknTESWm23pGpfHk75JAmeYIaIMAHXR3kK4RqYSdOJ+QdyRhMZ0Puz/ujmFtghKy2o1JFAydkp41dbBgG3wbILYmGcf1d1vbkH5tWpVUVlcHyeqU2s1qnbf9bkHcicnTb4zwVKE061fDu3Ic6fQh/M+vBmXzarPbeN0hGmtUzgXUzcS4aB0V6SwUr6dU9zyXS+fBf8tGw1NR1J230PtfNwEuelBvjOpueC0z4gixo81igLpkdkHVRDztdmB/I3fx3rfJBnWVE7PHdqd66nhCCHmAtC8ROgCf5eSA5FvpUR47b8OPBhzdGN0c2z+zHYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChH8+OW5a4Prq0XZXvi4WOkVPVyI0FfuzMvKs/Y15TE=;
 b=ZacCDFng9sz8XiaqUamDBMDZrff1k9wLw7XwDrxM0/olbyI5Bn0e4hIHydUi+SkSrL+Aow9bSl47h6sKWVOY2dSDQbT7p6iNneH+MA+aJXIJkaGu+P+mSCljzdgnOq8IUo0tcqk3sljmDmyMcyf7f6tLWPmv6ozCbLO9jgs93/Q=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Thu, 13 Apr 2023 02:16:27 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::dc4b:9084:6447:1834]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::dc4b:9084:6447:1834%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 02:16:27 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Liu, Aaron"
 <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: drm/amdgpu: skip kfd-iommu suspend/resume for S0ix
Thread-Topic: drm/amdgpu: skip kfd-iommu suspend/resume for S0ix
Thread-Index: AQHZbabA9CWtEsfxp0url6froqOJTq8ofx2Q
Date: Thu, 13 Apr 2023 02:16:27 +0000
Message-ID: <DS7PR12MB60054DB61DEBCD73BF273123FB989@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20230405112921.3690452-1-aaron.liu@amd.com>
 <62a91a22-0a55-6feb-7b8f-4d234cbd42a5@amd.com>
In-Reply-To: <62a91a22-0a55-6feb-7b8f-4d234cbd42a5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b35e4835-1f9b-44f0-8018-3e500ce292de;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-13T02:11:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH0PR12MB5026:EE_
x-ms-office365-filtering-correlation-id: c652cf69-8d92-4ec4-cf09-08db3bc51661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIa9LGzYd7fj93TkkvwCXoATuh7b0MJyZEtfsJxwIOrUsqRiOpJddwQBgsoir0N2PxYRbyXyvUu/NHIPXEPBd8tJiuNZVP8+ubt5/eeILwTiI/UDJ0QsNqFRotzOPysvw+osokcupN5Srq/bas9SfND9KZ2GL0nwf6PUR7bM9A4fmIAzqffNWrigyxu2YOn9ab3wLvcjK/QiiGrLNX9p3JgVhBGgwgyW59ULkrA9UUqZQ28hLo8F7Ut2c24AgLkiMrzlDnqsKwS8leP/avdl9sufusukRsnfrO2tz5ArxjJ0zP+l7w7dJhKTwkwMzybK/SN3fAikdvw7+kTOr6XwbZcXOVgcK+DrsuVBip0FmRtnVDVofbaZtZCP7fpoouTiMxJJpX5rAAvakKzYX3V/Y8W8KS7eDh3dsdyWjyAgza/CqS0FimatPup05XDJrvgmxZGHWW2TlRk8M8QuYMmPTT/k3PNE+hCwbnaRogKiA2G7M5tGRmDDPYkKKzs23Qw0zOuMYMAY/UtxFPPLhqWiF3d67wwgBBF4p5JsAQInxcZ+8H/xE6KTk75o/ST1GBVGnUmwlja3thLUw50nsiGOyLroRZ7BMdDeVVu82/CIFXBPfwB+j8L7iAukT8XPCnifsMfUUnwiNRlvZsNLT8dHpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(71200400001)(8676002)(66476007)(66946007)(478600001)(7696005)(66556008)(4326008)(66446008)(76116006)(64756008)(41300700001)(110136005)(54906003)(316002)(38100700002)(86362001)(33656002)(53546011)(83380400001)(9686003)(26005)(6506007)(15650500001)(2906002)(55016003)(38070700005)(5660300002)(52536014)(186003)(8936002)(122000001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVZnVHhzc2Z4cXRDYlltbmRnMnUrN2t6MTNLelltbE12bytIakh5WUNOS0dZ?=
 =?utf-8?B?OFZVV3g4NERNcjdTMzZEUCtlUHhydlpvMXhGL0swb1ZicExRUFhoV2hmZlF1?=
 =?utf-8?B?MERQS1V5K21sQVZSVzJsbUd5dWNDTVNLbS9NRG51c01aaW1obFRZSVBtRVNj?=
 =?utf-8?B?RHVodWJ2VkNkd0hQSVpxb2xyUTgyUFBlYlhzaTg0aXNvZWRGb1BpaWpOVzhn?=
 =?utf-8?B?aHlNYnpqTkE0VHlhallldUt0N3NNT3IzQ2QvWE5vMkdIc0QvMjNlS1dPb0E0?=
 =?utf-8?B?LzRYQS9rOWRVSXQ5NG80U0o5b0xzeFQ2UlZQeUpiVDRNLzc3UG5RM1lGRzBD?=
 =?utf-8?B?QkVuc3FKQXdUcHJuOU1aTHJteDdFZitpT3o0R2ZnN1BxOFFlTDJxcnNMMFdp?=
 =?utf-8?B?NUovR2JnZ21lOVl1TE1ERHNQWW1PSis3bWtjblg1S2ZHNmJaREdjclErUUIv?=
 =?utf-8?B?bU1pVzgrVU8wQ3EraTAxbTlCS3QrL1o0RjR0ZHYyUGZWS0hJQ05PNlpURVBO?=
 =?utf-8?B?R3QxanZaa01PTHljL0xWNkkzUThHMmF4cWovMFlETm01ZFdiV1dvZFpIeVN3?=
 =?utf-8?B?d25IQ1hvOThjOVN5ZlY2TjZJTGVJTTJveS9oRGRvTFluZ3FGdE5aQ0ZaSGV3?=
 =?utf-8?B?dkVGenhiRWh1amZQMVFXQmkxbXF6Vi9SZ2tKa3hFa25VQ2pTRTlIcnZlTlZ3?=
 =?utf-8?B?d0ZoUk4wMVZlbHFhTTc4Y1NIWSs2UGpQaHJsRkRmUzQ1VnBKelkyaUZOUUly?=
 =?utf-8?B?bnFNVVdFVFVIQzc2aTIyUU82eXZNUk9PS0FySm5FeE9USzdmNmU3Qnp3WlRr?=
 =?utf-8?B?akxRTXFMeWZZUkpVY0xTYTJmblU5VmpWR0ViRDlJcnZhb0pmckUyRXVlbGpv?=
 =?utf-8?B?QjlVY0IzaHRzKzJKOWNCZlRod3IreFdGZURHQXVUQ21VS2p6N1VQSnJYZHBj?=
 =?utf-8?B?bzVoT2loY1F0eDFERVRjNkJGMlVIbXFtYXVQNnhYdTdMdXBodTd3OG9YWW5s?=
 =?utf-8?B?c2MxU2N6VU53R1BEY3gyNHpZVW9aS3VyLzZ0QlhqZFF0c0xNY1I2c3VOTlVx?=
 =?utf-8?B?NWRuNTJuaUtzNEM2NEFrb2ZiMDNpczN6ZW1nQWpyS25CclR0bW5mTWtaQmcy?=
 =?utf-8?B?eklISUZmNzhXVVZWYjBYUzZVWVoxemdybmZRWWR2Z2F1TkYyQ3Yyd1crbGxR?=
 =?utf-8?B?OXlxZW82VlZ0S2Ezc1BsYzNLNFJqUVdMeHM4MG5zdjRDNG0zS040K2NjY3N2?=
 =?utf-8?B?K2RQNmZlMTNXbUw5Q1g2d0lrQWFXUGVrdlV6aEw0aDR3bmZ3dGVrMTZCMFBx?=
 =?utf-8?B?S0d4WkhPSWxMbFJOMWI3QzZkTVlHcGFCaDdPb1U3R1JUTmVLZUNxd3V6WVdn?=
 =?utf-8?B?UkhWVkQwVmdCOEF2N3pCVVVuNG9EWGpFU2tzTjBubE9lQ1Q5MWxFNmFuM1hG?=
 =?utf-8?B?ald1eTQwZStsU2tZcnVhRDRONkNTWXhQSFlkZlM1aDlXanBIeVFRT1crUlRl?=
 =?utf-8?B?ZG5sWTBqaU1uc2VVVnIyQk5yQmVFN2dmOWwrbjBaMnoyZVlFZ2xqekRpZFFV?=
 =?utf-8?B?aW5QZnZ4WDVHWXNjRFRkQW1tZ25NTkJYMHZTTFpReHN6Mm05UWhHanorbkJh?=
 =?utf-8?B?eCtJR1ZxSXRmSTIranVlT0lrOTVnb2o1bmJNcTUxVDBDWUVnNE9NSDZLZ09T?=
 =?utf-8?B?OGhSUi9EUEF0V2lFZUhvQ0R4OWRnNEMycVVJb1lEQ1pwTW96MFM1dVdoUUJJ?=
 =?utf-8?B?TXBiMVVON1dGNmxoSlZLaVA4dUp6cWVkWDU1cFRuOWpOQWl1N2tHSThzdEk3?=
 =?utf-8?B?Z1lQdUVqNEF3b2ZYWlJlZkdWQnBQZDJJdlpvR1R3MkJVcS90anppVGNnaGNC?=
 =?utf-8?B?bDZnc0xGaVRXcmVRem5WdDJGS3Ztdzd2OThHSWNhMWdYR1hLcmM3YXJWK2g2?=
 =?utf-8?B?ME9HRnc5SFN1MFhDTXNJaFMzOW9nSFU3SGJ4blMvK2dWRzBQSGVUQnlvc051?=
 =?utf-8?B?WW9OdkEwcjA4Q29oWS9icFBoT0lwSi90M3dLZE1TQk1NV0l5MVZJRDlkd0pH?=
 =?utf-8?B?VzZnMFRqcnF0WGZjMDI4RjZlMzZ4aGsvRmhqaG1uUHkwOFhUMFJLR1B5Y205?=
 =?utf-8?Q?QgPA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c652cf69-8d92-4ec4-cf09-08db3bc51661
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 02:16:27.2602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRG8Y54ls8bdG4DMrEL2cYELmWAvPeUUsCNQ/SzlfudAZ44Z95mJPmENHda1bUGe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBmb3Igc29ydGluZyBv
dXQgdGhpcywgdGhhdCBpcyBtYWtpbmcgc2Vuc2Ugc2luY2UgZHJpdmVyIGFscmVhZHkgc2tpcCBr
ZmQgZGV2aWNlIHN1c3BlbmQgYW5kIHRoaXMgd2lsbCBza2lwIGtmZF9pb21tdV9zdXNwZW5kKCkg
YXMgd2VsbC4NCg0KUmV2aWV3ZWQtYnk6IFByaWtlIExpYW5nIDxwcmlrZS5saWFuZ0BhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KLS1QcmlrZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4g
U2VudDogVGh1cnNkYXksIEFwcmlsIDEzLCAyMDIzIDk6MjUgQU0NCj4gVG86IExpdSwgQWFyb24g
PEFhcm9uLkxpdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEt1ZWhsaW5n
LCBGZWxpeA0KPiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IExpYW5nLCBQcmlrZSA8UHJpa2Uu
TGlhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IGRybS9hbWRncHU6IHNraXAga2ZkLWlvbW11
IHN1c3BlbmQvcmVzdW1lIGZvciBTMGl4DQo+DQo+IE9uIDQvNS8yMDIzIDA2OjI5LCBBYXJvbiBM
aXUgd3JvdGU6DQo+ID4gR0ZYIGlzIGluIGdmeG9mZiBtb2RlIGR1cmluZyBzMGl4IHNvIHdlIHNo
b3VsZG4ndCBuZWVkIHRvIGFjdHVhbGx5DQo+ID4gZXhlY3V0ZSBrZmRfaW9tbXVfc3VzcGVuZC9r
ZmRfaW9tbXVfcmVzdW1lIG9wZXJhdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFhcm9u
IExpdSA8YWFyb24ubGl1QGFtZC5jb20+DQo+ID4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxv
IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgOCArKysrKy0tLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGluZGV4IDNi
NmI4NWQ5ZTBiZS4uNTA5NGJlOTRmYTA2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IEBAIC0zMzA0LDkgKzMzMDQsMTEgQEAgc3Rh
dGljIGludCBhbWRncHVfZGV2aWNlX2lwX3Jlc3VtZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAq
YWRldikNCj4gPiAgIHsNCj4gPiAgICAgaW50IHI7DQo+ID4NCj4gPiAtICAgciA9IGFtZGdwdV9h
bWRrZmRfcmVzdW1lX2lvbW11KGFkZXYpOw0KPiA+IC0gICBpZiAocikNCj4gPiAtICAgICAgICAg
ICByZXR1cm4gcjsNCj4gPiArICAgaWYgKCFhZGV2LT5pbl9zMGl4KSB7DQo+ID4gKyAgICAgICAg
ICAgciA9IGFtZGdwdV9hbWRrZmRfcmVzdW1lX2lvbW11KGFkZXYpOw0KPiA+ICsgICAgICAgICAg
IGlmIChyKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+ID4gKyAgIH0NCj4g
Pg0KPiA+ICAgICByID0gYW1kZ3B1X2RldmljZV9pcF9yZXN1bWVfcGhhc2UxKGFkZXYpOw0KPiA+
ICAgICBpZiAocikNCg0K
