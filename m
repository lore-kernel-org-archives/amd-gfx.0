Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD551CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 03:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538AE10F405;
	Fri, 26 Jun 2026 03:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p5lwdv4y";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43AA10F405
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 03:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQP7ZJR9mpFHLtND3QbhehBqFsjq2gwWqd5vm77r/18riwWIgREXlhaeAXXx6XLRk99YpRE5ltKZbnbg1BTo/jvJrNVAM+UCNZ3jvsLiscOHIdv8b1DuvlAVuSX2RWgnOJx5qyIJAgAulkORRR+KTRtKwU3ODS/tjXAhjbc5LaignqJUexxrID4vSZ4NDwLDRtIiNp4bn3voyjsf2YIZmDT8+jMTX8X9zdqiOF+NMNI6p0E2nDKGGkzIUNxw6gHVh6iZX0ygpgEAF0ZA79rmJwTC//FtncBpHGmqAHVEcotokwx6aMxEez7JKkZxKwfz0iyVrgnHG9V9nNcNR8IA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gg3lgi0sQv+LZk5OAnaJAKHx5KVjPRZ/YiY/OajegbA=;
 b=gGL5Vy9/+5SdKa+gt9FyQBDxRHkbmxAUS8YDoMvvwPMESKMG/Cq1h+DNIIxGiY/AwquV8XjeStmwe1amMbW7E/7E5HlwVy3bCWQCDnWJsbwvvkdvDVZaG7D/Z9+PIB5eU2EUtyb96jzohF1GqxfvNc9wBcI4X5W7i/3Ofrb267QWL0M5lKmmCRJqnk10kLVb6YHCyfD0aNVFgjUv9pmjSh35J7KrAEHReFKleZSszT8PdAhHTkkAYKUCX6wfx+eMT4tP0nnLglUV8Q751DpNXCS/DNNpselyRl7h1Sq/loaqgj/L9aJG5hesIopRDP7UG1eoZ3xLHY7yR6s0qXv0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gg3lgi0sQv+LZk5OAnaJAKHx5KVjPRZ/YiY/OajegbA=;
 b=p5lwdv4yZOdCCsOligXT7pXwyUbXWaV5MnKUMLZ0T3jyaBoOIY7sjQTqT3m3iKaKqD41H25pjtr9+uyQWh4Cop+KGXran1f4yt77IZ9ITt//STbdbghqhIr7oN94pYB1P57khc1HXor3vwKq+QT9pYm01nKipGzqrrPbl/46cds=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Fri, 26 Jun 2026 03:59:36 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 03:59:36 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
Thread-Topic: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
Thread-Index: AQHdBFCQRvUOZooLKk6kWA0Wnm99ALZPFVmAgAD5O4A=
Date: Fri, 26 Jun 2026 03:59:35 +0000
Message-ID: <DS7PR12MB60051BBD4AAF99711CCD899FFBEB2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260625031252.298647-1-Prike.Liang@amd.com>
 <20260625031252.298647-2-Prike.Liang@amd.com>
 <32c5afa2-f24e-4d8c-8872-72826e7d3d08@amd.com>
In-Reply-To: <32c5afa2-f24e-4d8c-8872-72826e7d3d08@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-26T01:32:19.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB7571:EE_
x-ms-office365-filtering-correlation-id: ec7e99b0-d779-4722-f7f8-08ded3375668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tUuAQuB1ppRknguj8vYKD1HXcUMBMcxyAyx731Xgini72fyPrxaYhVOxbF4rm7cRMHW5CyFQUvSIfsLM8abGaCZMiCyaC19YO6/2uA+ojsmmyXOO/8y5rMMs7NaNonvoNHzVvCJ8VOsHLquAf2pGY26yJo0gfSe/+29R90YVW0l3FAQw2iLEvkkm1m8dgPFfZvF5SLqLtI4+Uvbj44HBcRcAuIAYImuoaNQcn1LXBNiTMZ+e4mwwmAYoC5jUI1yrMXpyDEtMcL5Aw1sJx1d25o+pYcbYcrcyECXcIpW3VhzcTR22gDaShwAIC+bYl4L1+HfGjKgl8fTllmrAqcZdEQa+o2q3s3tqILb9kNPevS5QwWDBscKTDMP6ooTE51N0J1qJ5z+uDEOT8Hf9xqvgclVE+p0EXsssNkH8l5pTa/BO8Z2dEWrHr95snT8oLrtdrBDgoGHbGaAmPtVI1wf5JzcoiEV5nNGF6HFeo5XFgfGJlisRAggAaYmVdafqfx80e4dg1XSO6N5wZKecgSXSo0kUzMn6ztBaCeAD1Y/2KBch/IVn7z7hsHiXoIxbQWQfIbt2dwE4bYpqWN4g1mEMlgneMHHfWuzlD/tej9W07eg1g92x5u9EjMo1PZWUF1eyNPXAXSOVxGveqGbA6UyL7ZNzbF4P3VoW3H+YscBbzAT3UJuPEuNfWvp9OlWt3qWwzRvZKMKyw+olX6sygjKYUBp19szmKs3gDnmm45/fjiM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXVvZHJaNFJSd29zL21WSEpLZ1pCRFBSa2kvSnJSOStYdE5rS0xGS2xYRWxj?=
 =?utf-8?B?SzJoMEZ2VHN4amZSbm1xeHRxZFo3ZWRqc0prQ0VqVDltNWEyam5xVldXWkZj?=
 =?utf-8?B?YXpwWDJVR1lYdmpFQTJCWUhVditoNDMwdjRTRWZQb0JpbUdiaEM0czNNenZk?=
 =?utf-8?B?S3ZMaU80ZzdJWVJhUXRONzkxd0g3VzF0eXNKMGhBYzBQbTZzcGtyajFLdjFY?=
 =?utf-8?B?Ym5XaFAvZFlMQ2lVQ2dxdnRVUlA3TENYc3JZWVR6cGh2SmNRNzZIZ1FNdm5W?=
 =?utf-8?B?ZEtCNk4zcXhDMVVYRUUrWVh6UUl5cU5DdlUrcVNlaHlKNFYzNVVKR2FiR1pu?=
 =?utf-8?B?WGdjYTdDU21mODExWVhVVkxJdERuUk9BUy9Zbit4bkthRzNyVnFGcjFncWhV?=
 =?utf-8?B?TWMydTU4ZW1OM2h5OGtLUDA0VUt6MWlSZDY5eFk5NG9Ha3Flcm5Sd2NxeW9q?=
 =?utf-8?B?R2lSUFpBaS9SdnNvSFJVNnlXOVVLQXFwR2ZMV3AxNUVSWmhNK3U2UTdwa1Nm?=
 =?utf-8?B?RXQ5dkEwMGRXR1QwZ3NqV1VISUo5ZEsrK29jb1BnaHFxMUQ1THY0ckE2Z3JD?=
 =?utf-8?B?cFk0YVlyMXZTcWRRb2p1NWhCRytLeDRhenN6U2VaNVFYK2RvRGFMUVJLTnNN?=
 =?utf-8?B?VmxDWEIydnM2ZU0vVzJxM2x2cmtEZ2tGSWpQQ2Z0MzdVNVMxYTVsLzJ1ZEF2?=
 =?utf-8?B?S0tQdXU3SHJBVDFNaVl4L1pGTVNDS0YzZXgxK1VldkJXZ0Foa2pLejVibmp0?=
 =?utf-8?B?UjJVTDc2enBhcVdEeDRESDUyamxPLzhKVTBBRXRwU1pKcnJZcEpsZVcrQlE4?=
 =?utf-8?B?MWIwMUh0Y1VWT1JrNjRFQThybTdsM2JRb3cvQ3NFYm5LdVh5NjI1Q1MzRHI3?=
 =?utf-8?B?Vk00RW9aZjNrZXJPUHFkWGxWK3MraDBQUWV0N2lIa3ZzMDk0QTBOMERtZWhk?=
 =?utf-8?B?MjB2OEFUZURYd3phbkpUYmtUOE1pS3dUOXFmRU0xV3cwQ1ptb2NzU3diZHFI?=
 =?utf-8?B?ZmNsVlhCc0lVUWZQaHgrMm1BOWVJRFI2T3JpRjFOZWtCa2JZMXozODIwcVZF?=
 =?utf-8?B?MUU4TFh2L0tQMzFuS29ENEZWQ0dOOGhTczN0amE5cVFCYU5nOSttaXBxeDdC?=
 =?utf-8?B?THNhaGsxNTNkenZiODFhTFZpd1owMk9WT2NIQXdCellMY1pwdEh3ZkdSc3cr?=
 =?utf-8?B?cmdaRTVNdVp0KzVwMHhwc1RkR1BiVmxBbEkzbElrSWp2eS8wdWxYejJqcjBX?=
 =?utf-8?B?RW00aS9TNmg0c1k3ZFp1RytsMVRNM3ZxeEM0K29pb2VTU2E3WjBqSGpWbHdh?=
 =?utf-8?B?ZFJyUmdXVVc0dWlpMzk0RTA5bzNxTE9XdEpaZEZoa2QxRGtxeTg2M0JTT0lF?=
 =?utf-8?B?U0tiRHdBY3Q3b2IwYkdIblVZT0ZxTHZ5cGtsUXlqVWN4Q3RrTlVWNWlVTUNj?=
 =?utf-8?B?Q2xqY09Nb3picEhPT05GWGdGdmR0RlpWQTNIWjUwNjBUSzRQSnJMbU8zWTVQ?=
 =?utf-8?B?WElaY1NFMGphTTlhZkFTZXN0RmVCai83a3pOT052UHFNbmx0dGgzNmJJVFU1?=
 =?utf-8?B?ckxzc0M0OFN4YUVxRzlzbnYwUG5YOUM0cjZXRVhibEw2eGRTMEt1ajZVbUNx?=
 =?utf-8?B?NnpKUWE4RFJSL3NCOG53U1duZldyQU4wWW1YKyttL0Y1eXZELzQ3M0tkVDhJ?=
 =?utf-8?B?SE5Cd3poUXhFRXJNSno5aDBzak1vRjc5emtody9odHA0SDEvS3ZFN0JkV2pF?=
 =?utf-8?B?SDhNbDBLbUw5b2VCUTFMNmJUNnh5MWkybjdJU2hZYXkyN3NaQkNJellJUFJp?=
 =?utf-8?B?dDJBRmN5SlI0OUg0YU96YmgrQ2RJOHNIOGFPVE01bkhSc2E1aFhpUmFXMnpL?=
 =?utf-8?B?b3BtRlB4UFpnMndlRVJ1cmZyTk42cDF2Z0FOU3lPZXVMOUhOanJudnJBMmgx?=
 =?utf-8?B?TWJYT25BOXR6MGlwYzE0U3l6NlZnZitEMmtrZm5HZDhPbndib2JOc0dIdU5h?=
 =?utf-8?B?YmJDVkdlVnhhY08yNlZxOWNaS2Z3RFJGek0yWUc1TlE1aWtzV0NLaDJEUVA4?=
 =?utf-8?B?QnBtL0RVdXFybFh2VXg4QUIvMGhpa05OUDlEZHRoQVZVWW4wV2ZOS3UvMWF2?=
 =?utf-8?B?ZUJOR1ZmbGdoTitpa29zOGRGSC9adHV0N1g5NWI3RGFzS08rRHRGZVNlcVBZ?=
 =?utf-8?B?bTJhR2pzTnJPc2x5dGE2OWNTSXNoNC8zVWwyRTkvdlFRd2RUMzlLK0t0SVA2?=
 =?utf-8?B?TDBNbUEraVU4WlkzejBSSng5Vjg2WDQ5bGJyUmZSUlZXL01JVzJvYjBrbDBE?=
 =?utf-8?Q?XdU6RG/t6EAyWH3X3o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7e99b0-d779-4722-f7f8-08ded3375668
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 03:59:35.9538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jr7Cuwj09ixCG6p/lgL7QtS+JbJ+gzHvl9d0Wu45JadoxSHfUE6+1K9i6vLGJpun
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

UHVibGljDQoNClJlZ2FyZHMsDQogICAgICBQcmlrZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDI1LCAyMDI2IDY6NDAgUE0NCj4gVG86IExpYW5n
LCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBMaXUsIFNoYW95dW4NCj4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMi8zXSBkcm0vYW1kZ3B1L21lczExOiBzZXQgZG9vcmJlbGwgb2Zmc2V0IGZvciBzdXNw
ZW5kaW5nDQo+IHVzZXJxDQo+DQo+DQo+DQo+IE9uIDYvMjUvMjYgMDU6MTIsIFByaWtlIExpYW5n
IHdyb3RlOg0KPiA+IFVwZGF0aW5nIHRoZSB1bmlvbiBNRVNBUElfX1NVU1BFTkQgYW5kIHVuaW9u
IE1FU0FQSV9fUkVTVU1FIHRvIGFkZA0KPiB0aGUNCj4gPiBkb29yYmVsbCBvZmZzZXQgZm9yIHN1
c3BlbmRpbmcgdXNlcnEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJp
a2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbWVzX3YxMV8wLmMgICAgICAgIHwgMiArKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2lu
Y2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmggfCAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbWVzX3YxMV8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192
MTFfMC5jDQo+ID4gaW5kZXggOWUyN2QwMWNiZmEzLi5hYjBkZTZkMDRmZjggMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiA+IEBAIC03ODMsNiArNzgz
LDcgQEAgc3RhdGljIGludCBtZXNfdjExXzBfc3VzcGVuZF9nYW5nKHN0cnVjdCBhbWRncHVfbWVz
DQo+ICptZXMsDQo+ID4gICAgIG1lc19zdXNwZW5kX2dhbmdfcGt0LmdhbmdfY29udGV4dF9hZGRy
ID0gaW5wdXQtPmdhbmdfY29udGV4dF9hZGRyOw0KPiA+ICAgICBtZXNfc3VzcGVuZF9nYW5nX3Br
dC5zdXNwZW5kX2ZlbmNlX2FkZHIgPSBpbnB1dC0NCj4gPnN1c3BlbmRfZmVuY2VfYWRkcjsNCj4g
PiAgICAgbWVzX3N1c3BlbmRfZ2FuZ19wa3Quc3VzcGVuZF9mZW5jZV92YWx1ZSA9DQo+ID4gaW5w
dXQtPnN1c3BlbmRfZmVuY2VfdmFsdWU7DQo+ID4gKyAgIG1lc19zdXNwZW5kX2dhbmdfcGt0LmRv
b3JiZWxsX29mZnNldCA9IGlucHV0LT5kb29yYmVsbF9vZmZzZXQ7DQo+ID4NCj4gPiAgICAgcmV0
dXJuIG1lc192MTFfMF9zdWJtaXRfcGt0X2FuZF9wb2xsX2NvbXBsZXRpb24obWVzLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgJm1lc19zdXNwZW5kX2dhbmdfcGt0LCBzaXplb2YobWVzX3N1c3Bl
bmRfZ2FuZ19wa3QpLA0KPiBAQCAtODAyLDYNCj4gPiArODAzLDcgQEAgc3RhdGljIGludCBtZXNf
djExXzBfcmVzdW1lX2dhbmcoc3RydWN0IGFtZGdwdV9tZXMgKm1lcywNCj4gPg0KPiA+ICAgICBt
ZXNfcmVzdW1lX2dhbmdfcGt0LnJlc3VtZV9hbGxfZ2FuZ3MgPSBpbnB1dC0+cmVzdW1lX2FsbF9n
YW5nczsNCj4gPiAgICAgbWVzX3Jlc3VtZV9nYW5nX3BrdC5nYW5nX2NvbnRleHRfYWRkciA9IGlu
cHV0LT5nYW5nX2NvbnRleHRfYWRkcjsNCj4gPiArICAgbWVzX3Jlc3VtZV9nYW5nX3BrdC5kb29y
YmVsbF9vZmZzZXQgPSBpbnB1dC0+ZG9vcmJlbGxfb2Zmc2V0Ow0KPiA+DQo+ID4gICAgIHJldHVy
biBtZXNfdjExXzBfc3VibWl0X3BrdF9hbmRfcG9sbF9jb21wbGV0aW9uKG1lcywNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICZtZXNfcmVzdW1lX2dhbmdfcGt0LCBzaXplb2YobWVzX3Jlc3VtZV9n
YW5nX3BrdCksIGRpZmYNCj4gLS1naXQNCj4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVk
ZS9tZXNfdjExX2FwaV9kZWYuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL21l
c192MTFfYXBpX2RlZi5oDQo+ID4gaW5kZXggNjY0NGZhYmViMGI3Li5iMDY0MTJhYzg1ODMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL21lc192MTFfYXBpX2Rl
Zi5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL21lc192MTFfYXBpX2Rl
Zi5oDQo+ID4gQEAgLTQyOCw2ICs0MjgsNyBAQCB1bmlvbiBNRVNBUElfX1NVU1BFTkQgew0KPiA+
ICAgICAgICAgICAgIHVpbnQzMl90ICAgICAgICAgICAgICAgIHN1c3BlbmRfZmVuY2VfdmFsdWU7
DQo+ID4NCj4gPiAgICAgICAgICAgICBzdHJ1Y3QgTUVTX0FQSV9TVEFUVVMgICBhcGlfc3RhdHVz
Ow0KPiA+ICsgICAgICAgICAgIHVpbnQzMl90ICAgICAgICAgICAgICAgIGRvb3JiZWxsX29mZnNl
dDsNCj4gPiAgICAgfTsNCj4gPg0KPiA+ICAgICB1aW50MzJfdCAgICAgICAgbWF4X2R3b3Jkc19p
bl9hcGlbQVBJX0ZSQU1FX1NJWkVfSU5fRFdPUkRTXTsNCj4gPiBAQCAtNDQ1LDYgKzQ0Niw3IEBA
IHVuaW9uIE1FU0FQSV9fUkVTVU1FIHsNCj4gPiAgICAgICAgICAgICB1aW50NjRfdCAgICAgICAg
ICAgICAgICBnYW5nX2NvbnRleHRfYWRkcjsNCj4gPg0KPiA+ICAgICAgICAgICAgIHN0cnVjdCBN
RVNfQVBJX1NUQVRVUyAgIGFwaV9zdGF0dXM7DQo+ID4gKyAgICAgICAgICAgdWludDMyX3QgICAg
ICAgICAgICAgICAgZG9vcmJlbGxfb2Zmc2V0Ow0KPg0KPiBJcyB0aGlzIGJhY2t3YXJkIGNvbXBh
dGlibGU/DQo+DQo+IEtlZXAgaW4gbWluZCB0aGF0IHdlIGNhbid0IGJyZWFrIHRoZSBGVyBpbnRl
cmZhY2UuDQoNCg0KVGhpcyBwYXRjaCBhbGlnbnMgdGhlIE1FU0FQSV9fU1VTUEVORC9SRVNVTUUg
c3RydWN0dXJlIGRlZmluaXRpb24gd2l0aA0KdGhlIE1FUyBmaXJtd2FyZS4gSW4gTUVTMTEsIHRo
ZSBkb29yYmVsbF9vZmZzZXQgZmllbGQgaXMgYWxzbyBpbmNsdWRlZA0KaW4gdGhlIFNVU1BFTkQv
UkVTVU1FIHN0cnVjdHVyZXMuIEhvd2V2ZXIsIHRoZSBkcml2ZXItcHJvdmlkZWQNCmRvb3JiZWxs
X29mZnNldCBpcyBub3QgZGlyZWN0bHkgdXNlZCBieSBNRVMgRlc7IHRoaXMgZmllbGQgbWF5IGJl
DQpyZW1vdmVkIGluIGEgZnV0dXJlIHJldmlzaW9uLg0KDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCj4gPiAgICAgfTsNCj4gPg0KPiA+ICAgICB1aW50MzJfdCAgICAgICAgbWF4X2R3
b3Jkc19pbl9hcGlbQVBJX0ZSQU1FX1NJWkVfSU5fRFdPUkRTXTsNCg0K
