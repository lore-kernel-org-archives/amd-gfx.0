Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C64C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 05:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE846E4EA;
	Tue, 23 Nov 2021 05:40:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863926E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 05:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwCJCB1/qb0kR8MhIEtgj3a7M7ol2lcjoyMFjuURqY3EsqPQAF6n4kAo8ydg3b34OETdHCTw91YCNrGv2sTCekkeABJXSnBHW9fuTOiYSYz7QVsmKObAFbOzjAB5yWK1I7iObVEyk9ZMUf8Y5a/uSAUCNtkRdl3QXc7gq+f2s6zDQ3rZidsnCA6k+Wmfi8gg2NPVurmnQuKAbi8Fyqf7zMdZQs90qIxja7uhvB53kKcFRVuaS3Z8/PenE1k1+dDpJ6ry4nObgxw8+zmsdj/sR5t7J8OuOKITXlT1JxP/TTlHE+O/kACCb2vjF5HmENQ/7sOVAWfbG5dMQG40NrjNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKf14tsYHPhhLv5O9SZffDMezqpGOpQa95Mw9dJMRCE=;
 b=mD6XXBF2d9Fol2pq+MWXdflHLvOKrJM9/vRJBYVoedb0Auy2Jpou8p3OGWCv7u+EtfwoOc0gVyQOXDnkz7s8WQTbsDABJZxnsOSWwnZaXGb2xaG+NC21XlTlmX82rj4EXWm+IHuMgcdL71ZMdtJIuKCiLvXqV3bqPobwNdTylYWHTlgbNw0y94GErFj/XASHk0gZquxQdoSNSoCWCZgeMmUXcTmdm/aedoAqinSDG+EBPbSlnrXtWWW/wR1uk3jt8S1BKFUt5QPz0G2YfExD8SiTqYmiIdchbcz3DK2CvU155qjzF6/HuF9Qt6TwFIoIUfmzkYY+R68lYDJtjUKiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKf14tsYHPhhLv5O9SZffDMezqpGOpQa95Mw9dJMRCE=;
 b=Wt5qljEl35yLgL9kGQcsUgvfwlIHUUNcw+wLhr9EY8OQuRFmEKG+HeZRvgchaDMWGPB/0+0wwcUvZLgsI5DlRhCGO2lRiUY4rykWpOKBN+xXcrn4sO6UdP86Yo00cte8FFxbVEow38EPZlHTaCrWSkHLWDu9IKcAvKZ97DdSeUc=
Received: from MN2PR12MB3246.namprd12.prod.outlook.com (2603:10b6:208:af::21)
 by MN2PR12MB3263.namprd12.prod.outlook.com (2603:10b6:208:ab::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 05:40:00 +0000
Received: from MN2PR12MB3246.namprd12.prod.outlook.com
 ([fe80::70b6:8476:4368:fd71]) by MN2PR12MB3246.namprd12.prod.outlook.com
 ([fe80::70b6:8476:4368:fd71%5]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 05:40:00 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Thread-Topic: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Thread-Index: AQHX3Ep0OrbJL2yYpUqCXznVALiInqwI7ECAgAA3wuCAAC5hAIAAAPMAgAAAjwCAAADIAIAAAvYAgAAA3ACAAAksAIAAFYQAgAYlvHCAABscgIAApNGA
Date: Tue, 23 Nov 2021 05:40:00 +0000
Message-ID: <MN2PR12MB324616E2837777B72ACF7EDAFB609@MN2PR12MB3246.namprd12.prod.outlook.com>
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
 <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
 <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
 <CADnq5_MGQ802Z-gdgfQXK_Eo2RXeE0qZ7AQUQLusez4Y3ysT5w@mail.gmail.com>
 <14cd6274-c967-ba7d-71d7-ccf332c30494@amd.com>
 <DM6PR12MB3930D33025C01706AE0F258F979B9@DM6PR12MB3930.namprd12.prod.outlook.com>
 <CADnq5_MbghaKafhQ0cQZPoL4FNHap=53kCDGP4X99rxe7Du-eg@mail.gmail.com>
 <MN2PR12MB3246251ECB6905B242B29379FB9F9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_MGrr7h8e00U6y9uiONuTgpQ0eNDzntKLNA7=AqDVsApA@mail.gmail.com>
In-Reply-To: <CADnq5_MGrr7h8e00U6y9uiONuTgpQ0eNDzntKLNA7=AqDVsApA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=607f3597-f445-43ad-8334-737aba7fe4d3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-23T01:37:52Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19ae8a82-0fe4-4b50-335d-08d9ae43b0e2
x-ms-traffictypediagnostic: MN2PR12MB3263:
x-microsoft-antispam-prvs: <MN2PR12MB32634CF8328D538987660F48FB609@MN2PR12MB3263.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RBq1hsmPzWz+3pDPSHIU9eNLxfZLAoSbUB3s4I4Dqw6wjeEdFpvd3Xq6ZkIw8pKJYEv3ORZ+gNJwrgEUbR9bnY5TrNf3lNIy6ol/h95roL5OFW2zmOGSMUd01vMeOVhtgC6rwwaeRa7w5/OxAG7RhPapHKvNLNMqmaHc7GUfqrGt9BCs1ideUOgmVo6SdHAJWTcZWm37fba63Q+kyR/7EtGNIDrcrbp9+a0Z7VJHTShs1aj+DuLzFq+CbpqRq4Sd2mHGZf3QY10ReJPVEoJHTNb2w3cR+UuVxpNMsrh/qRBBpM0kbQvKdMn6DJl7aouohvImZgDuIEq87fDMk/av03HQ5/nvskoUb/Is0q+bVX98t02sbs5mZP22CfgLtzc32p3YGLBqZgOmAvoMtb/RnZi3lqTD/A7qUzthwjv65c33lUhXjATV/VW6csJ38TUv54UA42hNwqmhX0xnN8vIguBJU1vcFrP9zXsEIe2/sKP7nDUGg/RC0ntIBU/iGG7vy7/chpVPbM38KDazHOY0Ii86Ul3kbTVxQsSt5bzPZt4nDnYRZyKzbVoNRaBlj5bHeWvBBuZLo+HImB6/FYbeb7ceoo3060pHFrsXQLxKHeFjkONx35IbNKS4UpJdu8e3MrTKQRXi/bIcT6bt1bKSjE0rGESb5kKDyTjRv9ds0NVpwtYNOz35pc5MT4hOBDNAsTriAEriit7Xdj0MfqO0JQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(9686003)(66574015)(122000001)(66556008)(86362001)(8936002)(8676002)(55016003)(53546011)(38070700005)(508600001)(83380400001)(6506007)(316002)(15650500001)(7696005)(33656002)(186003)(4326008)(6916009)(66946007)(38100700002)(64756008)(66476007)(5660300002)(26005)(76116006)(66446008)(2906002)(71200400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzFSWFBkamVvZVNIeC9mN2JaZUlKVFlEYkxmK3hOYm1OTmhpSmpsZFdqSTdj?=
 =?utf-8?B?TjI2K1Y0aUtKN2YwRGc2SWFlTzhFOUpUc0RmdkVPRjAwdlNiZlFHcm13eEVJ?=
 =?utf-8?B?a3EwdWhaamVrWGZLODF1TjYyRURiR1Vzd1NWdnNkL2hRYkN4M3VGNFk1US9Q?=
 =?utf-8?B?QVRvN0FMcXJYL0ZqVjJpbEs3WVdBUGl2bXZUaEJpbld3Y1d3T1g3V1NXRmda?=
 =?utf-8?B?SjB4OHR2eHdzcXpSaGV0YUdkR0NaTUJ1MWVhWlFodzJBT0U4N2JLOGxvenpo?=
 =?utf-8?B?TFRLUnhYVkxqVkhHdFgxelF2cG1Md2xMMzg3K3hzZHNoeGNQYW9VWWc3TnZl?=
 =?utf-8?B?WUNiODBubEkyVmJ6R3A1Nm9ZdWFXcWo1K2dJS0ZGdmRmbm1yYm9oOWllNVBl?=
 =?utf-8?B?d29TRm1GNXp5ZHloOERWQlk1UUZnbVJLYUN3NHNSQi9IcjNXeTNnUk9YWmdD?=
 =?utf-8?B?eUR4U0dIYkRVUlpWMWRZY1lvbGl1aW5hS2hPZloyK1EzSmVZcE9IOFp4Y3Iz?=
 =?utf-8?B?b08vRDVDbWFxUTliMk5Xa3c4Rm5VWGFSTUk0VVpzVUFiWmZUV0NTQlp4a3lT?=
 =?utf-8?B?S3RUanhNQWgzZmp1eE5kQUJCQzNaNmZQYWY0bjBDWWhtYnJKcW5UODNsb1hz?=
 =?utf-8?B?MWhwZ3lHTkhZY0lXUUlCK0xpOU1PS3M5czdseVBJaTQ3MWVHdDlaWjFVK3pC?=
 =?utf-8?B?Ymw1L0JsejlpQ05NRW0wMHdrN2tNTHpzUUozVzU1TXRFY0NkMldLL3QwYnRi?=
 =?utf-8?B?bTFsa0FubkF3UWM2RkRsQllFS3FmWmttU3lIWldzb3l5R0ttRFN3VExuOHgz?=
 =?utf-8?B?YXo0VjJTdk43emhtZElyY0MvdEx1RWhGODJkdytEaHZSQTc2ZWRldWhOekZa?=
 =?utf-8?B?dCt4d3hTQXZwY0hrZzdhUkdzeTZrWUFPc2tkNGZyOEZMOExZa3V1M0dCZ0hy?=
 =?utf-8?B?anFUY0dadUc5WUZVb1hVcklObklpYkc0NmxuQ05WVmdIQnoxVFFSZExjeXFU?=
 =?utf-8?B?SGFxYlR6aXkwNys5Y0o3c2lqVnlHN1ZzcmJGTytFVE9hQ3lYOHUzNVlneVQx?=
 =?utf-8?B?aVBOYmp6WHJSMUpoQUZLeTI5aDlmdmUxdkt5TUJZV2R0cW5pTElEaGZTd3pV?=
 =?utf-8?B?SncvZzZFVTg1Z1JETE5UcmtVQ0JCWW9NV3lTRTNzTDdSUmI3b1hLLzR6K0Vz?=
 =?utf-8?B?RGFmYWR2VTlYeWNuVjN6OGpUODVzbkd1RldwMVRXQWw3REY3SFl1M3ZuQk5Q?=
 =?utf-8?B?ZXUrMk5EK0pXSHJoam91UXZtUGpSSXRQc1NWbkNmNmtEUUQyWllBeWhSSmo3?=
 =?utf-8?B?Sy9pZm5uZHo4YnY5ckhUODMvb0o4WW9WcjR6cUNqbGFRMlYyNEdKWVZPd09S?=
 =?utf-8?B?RDFkazFDUzRZaGF1RnJXZUlseXVjbS9VTUJoeDBjWEhKZDYwa3ZZREE4ZzVR?=
 =?utf-8?B?eVQxbDdWVzlwZWdwMTl2TWwvV09pMkhqejVqUkZkUC8rSFZidHhkcjhLQUt5?=
 =?utf-8?B?ZUlWZ0ZPVEUwTjVtZE53dkxndVI0dXV2UFhtTFdsLzZKaEhYKzlUVm1yMUJ3?=
 =?utf-8?B?Z3YyVDkzZzdtb2syQithdVlMVFRFSVE1aGpGVk1wVWdkMG5sRVZMSG9vSTlr?=
 =?utf-8?B?MU92dnB5YlhiYTh6TlNBWTExaVovZjA0QkhPWmdlNzhtd2tRbzNhbjZUSHdJ?=
 =?utf-8?B?dGoxdk5DeFQya0JzMDlFaDVzNmxZalYwWlRucm8vMTUzQnA4TWt6bEdCcVJF?=
 =?utf-8?B?SXNRSXd5R0xBZjdyRUZIemNhclA3Z1JiVktEWVhJelUrUDJlQ0NZbUlxNC94?=
 =?utf-8?B?dXVwYWVuNFlpTDRYRmM2QUI3ZERLcC8vKzhERk56bVRwVnRFclV5OEJnQ0E2?=
 =?utf-8?B?MyswZWs1STVxbFhENnZHcWZEQkFQN0luQVo1YzN0c2N4Q1UyMmRMNUV3Q2xB?=
 =?utf-8?B?SXpWOW9Nc2FwYUdOdjhld0lwWWtxdGN6Y3dMYzdiVm5QcFB5UkI1UjdHa2pC?=
 =?utf-8?B?L2VGQmZla2p2UUp0YVFRMHcrdElzMTJkVlJGdU5DSVRtU1Qyb3c0eXUvUFZU?=
 =?utf-8?B?YUZoMmhvcVhlTFVCSGVhQmlvVzYyQ0t6V0J1aVRSRWNxRDdneWNMRHl1N2Mr?=
 =?utf-8?Q?Gs7o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ae8a82-0fe4-4b50-335d-08d9ae43b0e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 05:40:00.1722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVsL2nsFVDwmM/6KGEGbxf9UKfkOf3cA35ry2tndSgFg/wU4ip5bDoSEjZbr30w5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3263
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAy
MiwgMjAyMSAxMTo0OCBQTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29t
Pg0KPiBDYzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IERldWNoZXIsIEFsZXhh
bmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENocmlzdGlhbiBLw7ZuaWcNCj4g
PGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5n
QGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXNldCBhc2ljIGFmdGVyIHN5c3RlbS13aWRlIHN1c3Bl
bmQNCj4gYWJvcnRlZA0KPg0KPiBPbiBNb24sIE5vdiAyMiwgMjAyMSBhdCA5OjIzIEFNIExpYW5n
LCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBbUHVibGlj
XQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBGcmlkYXksIE5v
dmVtYmVyIDE5LCAyMDIxIDEyOjE4IEFNDQo+ID4gPiBUbzogTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT4NCj4gPiA+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnDQo+ID4gPiA8Y2tvZW5pZy5sZWljaHR6dW1l
cmtlbkBnbWFpbC5jb20+OyBMaWFuZywgUHJpa2UNCj4gPiA+IDxQcmlrZS5MaWFuZ0BhbWQuY29t
PjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+Ow0KPiA+ID4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHJl
c2V0IGFzaWMgYWZ0ZXIgc3lzdGVtLXdpZGUNCj4gPiA+IHN1c3BlbmQgYWJvcnRlZA0KPiA+ID4N
Cj4gPiA+IE9uIFRodSwgTm92IDE4LCAyMDIxIGF0IDEwOjAxIEFNIExhemFyLCBMaWpvIDxMaWpv
LkxhemFyQGFtZC5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBbUHVibGljXQ0KPiA+
ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBCVFcsIEknbSBub3Qgc3VyZSBpZiAncmVzZXQgYWx3YXlz
JyBvbiByZXN1bWUgaXMgYSBnb29kIGlkZWEgIGZvcg0KPiA+ID4gPiBHUFVzIGluIGENCj4gPiA+
IGhpdmUgKGFzc3VtaW5nIHRob3NlIHN5c3RlbXMgYWxzbyBnZXQgc3VzcGVuZGVkIGFuZCBnZXQg
aGljY3VwcykuIEF0DQo+ID4gPiB0aGlzIHBvaW50IHRoZSBoaXZlIGlzbid0IHJlaW5pdGlhbGl6
ZWQuDQo+ID4gPg0KPiA+ID4gWWVhaCwgd2Ugc2hvdWxkIHByb2JhYmx5IG5vdCByZXNldCBpZiB3
ZSBhcmUgcGFydCBvZiBhIGhpdmUuDQo+ID4gPg0KPiA+ID4gQWxleA0KPiA+ID4NCj4gPiBGb3Ig
dGhlIEdQVSBoaXZlIHJlc2V0IGluIHRoaXMgc3VzcGVuZCBhYm9ydCBjYXNlIG5lZWQgdHJlYXQg
c3BlY2lhbGx5LCBkb2VzDQo+IHRoYXQgYmVjYXVzZSBvZiBHUFUgaGl2ZSBuZWVkIHRha2UgY2Fy
ZSBlYWNoIG5vZGUgcmVzZXQgZGVwZW5kZW5jZSBhbmQNCj4gc3luY2hyb25vdXMgcmVzZXQ/IEZv
ciB0aGlzIHB1cnBvc2UsIGNhbiB3ZSBza2lwIHRoZSBoaXZlIHJlc2V0IGNhc2UgYW5kDQo+IG9u
bHkgZG8gR1BVIHJlc2V0IHVuZGVyIGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA9
PSAwID8NCj4NCj4gWWVzLCBleGFjdGx5LiAgRm9yIHRoZSBhYm9ydGVkIHN1c3BlbmQgcmVzZXQs
IHdlIGNhbiBjaGVjayB0aGUgdmFsdWUgYmVmb3JlDQo+IGRvaW5nIGEgcmVzZXQuICBJIHRoaW5r
IHlvdSB3YW50IHRvIGNoZWNrIGlmDQo+IGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2Rl
cyA8PSAxLg0KPg0KPiBBbGV4DQo+DQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uIGFuZCB3
aWxsIGFkZCB0aGlzIGNoZWNraW5nIGZvciBHUFUgcmVzZXQgaW4gdGhlIGFtZGdwdV9kZXZpY2Vf
cmVzdW1lKCkuDQo+ID4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiBMaWpvDQo=
