Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D61AC83F11
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 11:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27FD10E28F;
	Mon, 28 Aug 2023 11:23:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A15910E290
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 11:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFf1CLAa0+sahtL6xWChszlBGjT1bfUw3MYW0033fEli5kIUZ88MnsmQNcLjWhwjQkwF6vMPzXsKinpeqyXnvk1GvATt/HrQkMEFIni43NN4PQ3oGnV27G51LbnqAdmdgtj8agJX9ttpbjxXLllFbnTNgOvujNnd4tj/XJCVZ0BBBL3eKmnk81GDHvUhTEmAu4e1SbukAN4V7l559G8B1ZqKLYIjMVjvTDBog6vD+6+4CNXwENoakz8kclhZar2Rs5u0yRvzWf0+loYQ3O6BLJiq55KMRHjaJKhiBp12tjQJccouKptn32eFLbPcRak57LT1/4N/M3CIL7Wa0M6ikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EL+1tYHtH5pux0JL0PsWGDE//Gf02SrKrov2UvXVuA=;
 b=UFHGS0lTJeJ+gligGzGwXCfx4+pBbb/l5SHamoNFs4YBTX4CALuB2umAP8TmaRN35bXqVQ/nZTZves9n4HzIstBUadTIWwp6QFZgvR+s5QmeDSgT0Xh2LnJkegQ0IEwgFypc8MNOuTMYO8BkxAWJ8d3hWeZ0YhTsPeroW3FdanDzgUqYT8qX0LWfoiGjVRtV9kUZklTKYoaGou/wuTCg642eVOsHm2QbYiCvolk9gRQNmuWYfY6v7CsRolb4g5lAxpI1Aq5dBWkWu4Epv1o6J7uqKRFqzM+iQbnfA1MEnaa5i1K7ZeLirSlTIQcYp1JYNC44AbTLpTY0O6ijRBKA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EL+1tYHtH5pux0JL0PsWGDE//Gf02SrKrov2UvXVuA=;
 b=f4jI96+MWXwOykuTEQQnSa/IQGNBz5IvAcfm0TFqI/AOYeno2maqXqJTN5sp4og7FGAyFCARgzWymBqLv7avgTOfXGmpRMZE0gdxF2haCnFkicHv+qW+eL9KvFfMyQlT0Q8er9kcjabG4wGRLMDIV1jdbe/zFGilfxaNo6VIp7I=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 11:23:48 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::b4ba:c624:2cb2:90cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::b4ba:c624:2cb2:90cd%4]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 11:23:48 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Thread-Index: AQHZ1uvvohHWYJx9c0OqJMFaLXkm2K//bUHwgAAMWICAABsUQA==
Date: Mon, 28 Aug 2023 11:23:47 +0000
Message-ID: <CY5PR12MB6369567CA37A1148A55BC2ACC1E0A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230825003348.3978418-1-yifan1.zhang@amd.com>
 <20230825003348.3978418-2-yifan1.zhang@amd.com>
 <IA1PR12MB635664DEA385477CF3996C8DC1E0A@IA1PR12MB6356.namprd12.prod.outlook.com>
 <4f64681c-11de-7c9d-c71c-d96b4099a9bf@gmail.com>
In-Reply-To: <4f64681c-11de-7c9d-c71c-d96b4099a9bf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=232cf8f5-81ce-42ff-9930-8875e9d466e3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-28T11:23:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM4PR12MB6375:EE_
x-ms-office365-filtering-correlation-id: 414293d5-1761-494e-28ad-08dba7b93f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxteHflOfDY5ZAxLtb3c3XjSa+W3GN7v6CaVDlsWJ2WzYWxAA91pR7dcahmTdoseOehl1dWBLsou0t73oG95PtAInUDs7Pfd4TnbrdgbyhfXTznbA2TJDtTdTfkPOgISe7vWHDQ00D24UOpI89EdA1agehO9wJTD72JhnIwkDLWmnBJTqbGmZJVsI72UpUzrQ4w3RA7cVHTZdM9HQiMG8Zi03QIWoOPUjRMoDO0TOCB6rZ5XAEMNg8muLjMty6agB2D7dkRvyzcnqg+xL9F8sYhICLqIBW8gCqdZ1a+xkvmQfQPd5OBi8CjaeMKsNezE7+OjSb9t37ElTgNINPJnh1jysMRrBOPvfChYI6rOfcvTJYTAWr1vizuq0dCZZH03kyP5TCSG5D4qy26746Q4uV+Gjbq1IbygNYAZv+/222oMEUtd6dvCvVNBlrSp2voPCpuQvrEXv2HCnp0XYMkWFjV6hQCf/1xTri1T95VULydua7AiB790JSqSyMG8L97ZKQWBXLOSPY2w78iX07o920eFpq2tNTNrTMVcufwA28+mnzE4OXttEYxk78jjhTzwmyIGspP0+RZt5yKIf2st+obbJWlQ99JAdo7zes6qEyPaJwy/56S/1BkqIt/F2CrU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(110136005)(54906003)(66946007)(64756008)(66446008)(33656002)(66476007)(66556008)(316002)(76116006)(5660300002)(52536014)(41300700001)(26005)(6506007)(7696005)(9686003)(53546011)(55016003)(38070700005)(122000001)(38100700002)(478600001)(66574015)(71200400001)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amhTV2hzV0N0RktNZDdEQm9xN1Y3NVROeUd1MnBLS0F5L0dHT2xQaEF3ZGE0?=
 =?utf-8?B?eVNOUG5zTXFkWmt3cEtNRGg0WXQxVGY4V0ZublNLaEROcmtsUHFoRk9OQ3A4?=
 =?utf-8?B?ZTM0ZUZYOTE3YUdNN2d2TTVTREVVcTRUWmx6Rit5aDVydXd4Z1U5cUFvTk9r?=
 =?utf-8?B?VS85SXNrVVA5VytPbEhnZjlTNzFRRUQ2YTViN2lRcnhBMFRaOTdwN2lYbjgz?=
 =?utf-8?B?REJBMVA5dHhPZ2FicURUQ2NWSFUxR3FLRERMTGdSM0MxbHV0TnVEaTNJcGJj?=
 =?utf-8?B?TzBwZ3ZHR1NUQXpqVGlkMGxKaHQ3ZDdWWjBFM2IvWk9zNkp0YktmRXBwU1Z0?=
 =?utf-8?B?UzhnSXdxTHUyVC8zNWoranJTS3RIK2lQWDkwK2lOMUhhZGwvbVVBdlJ5R0dR?=
 =?utf-8?B?SEx5WTNuOFllaTcvZDRHanFkQk5hdUsrVXhtOU9sVzljbkgzcy9YdzlYTklS?=
 =?utf-8?B?MHFHcHE1Y0w2N2xJcXc2UDhoZVcyUS9DNkZ0NUtyM2N2SHkxZlhqNmJRWWdO?=
 =?utf-8?B?dkxjcUQ4UUdtTlJHVHBObHVVbFBFNUxxWjBqYVJKcmtwYkhlMXdVZ2RFN0ty?=
 =?utf-8?B?U0sxeDN5Sm11MGJLY3h4Ty9Tekp3ZFBiTmdHQ0NOM251ZE5hd3BKWkVaRzY1?=
 =?utf-8?B?eTh4V1RHbmpON1FwOUd5UlV5QmVCdmg4K3plQlM3L1JXMUFmaUJjdndvcHRO?=
 =?utf-8?B?bTM0U3gwaTh0ZzFhckxWTVhtVVgva3JHU3o4R3hlQWhzNVJlVEdxaTdTc3hM?=
 =?utf-8?B?NnhXcWwvYnNmbUwzRjZ6YkdMUFZ3VXZ6Qk5ZNmNxbzJzSlN3WEszOGhENDR5?=
 =?utf-8?B?THFSZXNzQ0YrRlZpRElIOCszQ1hYczVCejNZMmZZdzdVT05LZUtyTFFLM3hI?=
 =?utf-8?B?OG1yRU53REdEbWE0enV0WU9VQU0rbG9ibDlKUUc0YVZ2c0FMZ1dzR1dlZkF0?=
 =?utf-8?B?c1pLeUx3TW9GYnh2L0lhdE9VY3l4b0ROYWc1RTBYYkFXb2VoaE5jYWpVN2p5?=
 =?utf-8?B?OUx4MFJLNVRQNlhmSmFJc29xUWR6bE43eDRmUHhuZ08wOCtlMHc5UVAyWHdI?=
 =?utf-8?B?VDhFQllWeUY2c0prUlp3aUpsRG9FNVlKM2hMZ0VFRjJZQnZmbCtTWUxZRkcv?=
 =?utf-8?B?dUZSdnhHSm56TWNNQTREUmFheldIU3cyRis3MldMT29sWThwczZBcG1zOVhM?=
 =?utf-8?B?OW14VnJmVUZ0RlMzWXR5KzUvdU9YZHQra3BpWERjRmplNWJ3MlVyUU5aVmxX?=
 =?utf-8?B?dUZVNXQ5NXlMU05PODlmbFk4YTZKQzNFa3VhbGJnUUwyTnNsSHhnRU5lU1cy?=
 =?utf-8?B?akJEQXRteFJ6NFNxTkMxRTlOVXN0WlIwc2xMak0yMCszVUk0MjlocGhlazlw?=
 =?utf-8?B?cUNRcFBadG5GMDZmclJwZlQxVUdzNFVudTZBTi9VY3p6SitsazU0L2dUb1JS?=
 =?utf-8?B?R29Qd28rWXdsVWR1VmdEV3BjaUg4VVZwdlVSMDYvR1RiaU5sd25xMlhZWUQ2?=
 =?utf-8?B?K0dvZUVKbzdydG1rRFZOVG5ONDNNUVFjbk9LcVFVeDJRSXgxb0x0TTJGbUZk?=
 =?utf-8?B?UkczNHNZb0hzOCsrQlVhMXZQWll1Szl1eEVjZCtpbE00bUJOcG9taURoOUJj?=
 =?utf-8?B?V1ZhdFBiQWRUMjVXUnJPNzZob1VsMHdiL2M2RGtZNXp2dGNyNE9LYldsa2Rm?=
 =?utf-8?B?ZTN0QkNFejBSNTRtbUM0VHlZZnlSSllCc0trOUlWTFRPS3NlOE0rL0U1Q3VT?=
 =?utf-8?B?eGRvRmhWaElxbmhXOVoyalNDOUxZUHF4blFBU1p6bGtZQTNwV2dnMzBhM25s?=
 =?utf-8?B?cXEvRjRGb3VUQ29XRW1RYzZjOVNBcGdYZnVZYkN1RThTRlhoWTBhTGNleHhx?=
 =?utf-8?B?c2lvb0NoOUpwQ0MxdXh2aWhiYi9IRUF1Qml3a2dBMnBEcTdPUGRjVXpLbUhY?=
 =?utf-8?B?T2JJaWNHQTNsTTRrMGJ1VTZTb1FuK0FDSVFOSlNhSjNPOWk2eHFTVWh3RDJR?=
 =?utf-8?B?enNPekNHclpHdzNnVUREMS9taGQ4bFBzZ2pyRng3RWpEd1RJTU9SRXlQcGVq?=
 =?utf-8?B?MllVT2lqQS9lL3ptUmo1UHRSZUw2VFJuWHYrcFZLWUR5WEJQZ2taS3lsNFBn?=
 =?utf-8?Q?VpBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414293d5-1761-494e-28ad-08dba7b93f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 11:23:47.9362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chHEoegsZf39WySmhPlAFh2uB8jS8TEVX4m0ro5CX5SgGhNTiOFxq7qcWIZ5ktSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KTm90IHlldC4gSXQgd2lsbCBiZSBvbmx5IGVuYWJsZWQgZm9yIGdmeDEwLjMu
MyBhbmQgbGF0ZXIgQVBVIGluaXRpYWxseSwgSU9NTVUgaXMgcGFzcyB0aHJvdWdoIGluIHRoZXNl
IEFTSUMuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2
bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NClNlbnQ6IE1vbmRheSwgQXVn
dXN0IDI4LCAyMDIzIDU6NDEgUE0NClRvOiBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzJdIGRybS9hbWRn
cHU6IFB1dCBwYWdlIHRhYmxlcyB0byBHVFQgbWVtb3J5IGZvciBnZngxMCBvbndhcmRzIEFQVXMN
Cg0KSXMgdGhhdCBub3cgdmFsaWRhdGVkIHdpdGggSU9NTVUgaW4gbm9uIHBhc3MgdGhyb3VnaCBt
b2RlPw0KDQpDaHJpc3RpYW4uDQoNCkFtIDI4LjA4LjIzIHVtIDEwOjU4IHNjaHJpZWIgWmhhbmcs
IFlpZmFuOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4NCj4gUGluZw0K
Pg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaaGFuZywgWWlmYW4gPFlp
ZmFuMS5aaGFuZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAyNSwgMjAyMyA4OjM0
IEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAyLzJdIGRybS9hbWRncHU6IFB1dCBwYWdlIHRh
YmxlcyB0byBHVFQgbWVtb3J5IGZvciBnZngxMCBvbndhcmRzIEFQVXMNCj4NCj4gVG8gZGVjcmVh
c2UgVlJBTSBwcmVzc3VyZSBmb3IgQVBVcywgcHV0IHBhZ2UgdGFibGVzIHRvIEdUVCBkb21haW4g
Zm9yIGdmeDEwIGFuZCBuZXdlciBBUFVzLg0KPg0KPiB2Mjogb25seSBlbmFibGUgaXQgZm9yIGdm
eDEwIGFuZCBuZXdlciBBUFVzIChBbGV4LCBDaHJpc3RpYW4pDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3B0LmMgfCA5ICsrKysrKy0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fcHQuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jDQo+IGluZGV4IDk2ZDYwMWUyMDliOC4u
NDYwM2Q4N2M2MWEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm1fcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm1fcHQuYw0KPiBAQCAtNTE1LDEwICs1MTUsMTMgQEAgaW50IGFtZGdwdV92bV9wdF9jcmVhdGUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLA0KPiAgICAg
ICAgICBicC5zaXplID0gYW1kZ3B1X3ZtX3B0X3NpemUoYWRldiwgbGV2ZWwpOw0KPiAgICAgICAg
ICBicC5ieXRlX2FsaWduID0gQU1ER1BVX0dQVV9QQUdFX1NJWkU7DQo+DQo+IC0gICAgICAgaWYg
KCFhZGV2LT5nbWMuaXNfYXBwX2FwdSkNCj4gLSAgICAgICAgICAgICAgIGJwLmRvbWFpbiA9IEFN
REdQVV9HRU1fRE9NQUlOX1ZSQU07DQo+IC0gICAgICAgZWxzZQ0KPiArICAgICAgIGlmIChhZGV2
LT5nbWMuaXNfYXBwX2FwdSB8fA0KPiArICAgICAgICAgICAgICAgKChhZGV2LT5mbGFncyAmIEFN
RF9JU19BUFUpICYmDQo+ICsgICAgICAgICAgICAgICAoYWRldi0+aXBfdmVyc2lvbnNbR0NfSFdJ
UF1bMF0gPj0gSVBfVkVSU0lPTigxMCwgMywgMykpKSkNCj4gICAgICAgICAgICAgICAgICBicC5k
b21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7DQo+ICsgICAgICAgZWxzZQ0KPiArICAgICAg
ICAgICAgICAgYnAuZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5fVlJBTTsNCj4gKw0KPg0KPiAg
ICAgICAgICBicC5kb21haW4gPSBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9kb21haW4oYWRldiwg
YnAuZG9tYWluKTsNCj4gICAgICAgICAgYnAuZmxhZ3MgPSBBTURHUFVfR0VNX0NSRUFURV9WUkFN
X0NPTlRJR1VPVVMgfA0KPiAtLQ0KPiAyLjM3LjMNCj4NCg0K
