Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23B8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704166EABC;
	Wed,  1 Dec 2021 10:45:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4B76EABC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3av5GV0B9JpM1D6RWoxdxKt1BgI7WP4bcQDOkDPpADHYgS4ygf5Gb0AxYhj3qayFGdk0mxu9omeIl19Uzxnf0a5e9I0YNSBjOZlom2i2+PVh99m98bTO/2+CBrvAiSB7+yUE9abmwSBZdTiWLiUgIzLZ1l4GdH6yJqSTjYmuDAhTRhqzqUdRfZcKVlUQXRi3Ug/MvYYH/r1oeEkGXvCkeaLJe+yAF0gxAyzIOF0ZI2wQthoymxPVsXRp4mosXtBeboB6BZf+JVuWIG4dzFbLa/wRX1XSOHvvydaZKYbEK/Uhw4bDw4zZc+89yqG0Zna86WBrvlNQzquhayQ9q3Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v/mhX3kuBNsF4YyThZS+8Q4BUQ07OsfnmXh++YZoqo=;
 b=CKNwtDMTXwctAAmWgrCkzdbJTR/0WhhezCSsot/wn2+usrOautWS6TiIYsn28DBRTfaiExwD49Hzjy9VXvcQImAhIaUNdvlBHfVSHawaUCyhlhu/661UT3sk3qNv/sO4nI9zf/3jr9247d68CgYiMD9R0CFqZFl7fMuAg4NRhbhGPdU8xmIpXVyJcdvpf9SnrnpLH++oVffkdees1Q7WtFPeABy3fVrCiyfiPPM7hR9BqkuKygNaLf4kFP3I317W5S87n7C+GOts2NSRECbcQJsrJV4SYjaBGCSLXO0RA8vzWChWt5BjmveZmS86V3Gu+jEheQJGcqHfAUmvrx907w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v/mhX3kuBNsF4YyThZS+8Q4BUQ07OsfnmXh++YZoqo=;
 b=b4AnADKAUtPaCiPKiy18XytyqwsD4IArwXaBduHePNKsXqQPAGKlkxe9Y0XVCcRMy7Fzz89DkTlmtHmqUF9R451KdvCh5M57cP83MQYc/9rcs8buI4ST3jVsI3EyYmyEYS6nc4houeyX20vf7ELzC0QE6IyonzloRvrwSW/jEG8=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Wed, 1 Dec 2021 10:45:00 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 10:45:00 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Topic: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Index: AQHX5pVcc3LghN55bkmOkF3w2Pkmd6wdXtgAgAATJuA=
Date: Wed, 1 Dec 2021 10:44:59 +0000
Message-ID: <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
In-Reply-To: <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-01T10:44:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f8d548d4-d885-423d-91d3-90606280de87;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-01T10:44:57Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9af9355f-2bab-435a-ad25-9acc3d7690c7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d48f916-42f0-4147-78fa-08d9b4b79fb1
x-ms-traffictypediagnostic: DM6PR12MB4338:
x-microsoft-antispam-prvs: <DM6PR12MB43389466E25A8215E53756FFFB689@DM6PR12MB4338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3bDL4KEVCl5ELz9W7mqBCb7w9dif9ME1zL79iDitQ4Nq1PrqDT2rMlLdAVJhsPPMcgRcw5QMaLyoEFnR0XWVYDwUrtMCv6e5QTRuHbo1Smy9CfelLt11ezG+enZo4fPPKqh0shw1V1wZ1OOsNP0g+ZI9mpm3Ayrf7nXgHca1oyNI3EdTlX7z6cFmsmOKLK80MW7r/BocA55FS60O9buGE3TgwgKJUb6Whx6XWxZOAyzBOgfQktkhp/WNY5Jr/Y+HYnbYZpvTo/8oL/aBKphIYe5W3WzEq7ReOPAjCsLcX7fZmxM1eYujNnS3Av/jRnq0jhWVmH9Y/Dw7MbN0oNEVwoNUSXoOqEBNhO9JheWUDbreaodFjy1xMILAgO4wR5OiP0JwJek4kEyg8S0BYe7goT5w5SIWU3msr6IKQOAUgbqufIfYYrsNkZ8I2UaKnOKZDoWboxTKuKfoIcPTytGGTRGNsb2LZxQLhaImkgqVoJwVT3i38+csfiPO2xZBNpL2yAkXMftoefJzuiNSH94+GeiVie1x5Q85RQcEYErRi3hCjLmU3qbkii/Ik9lKKzdJgE2kqFfC0ClkQwjTG3MrufApc7KBUQH28ytSGykfosszgXMcdaKIYdlSVloNJ2weSrwprIhUrO/ha4uSAlEtpcAuW0Mc9MHq2ixpkgN03e4vB2ntUkqnAO2LyQuZ1VUfJc/A7zldPmDvWG44yIuig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(55016003)(76116006)(6506007)(64756008)(66946007)(2906002)(122000001)(4326008)(86362001)(5660300002)(66476007)(66556008)(316002)(66446008)(38100700002)(9686003)(26005)(54906003)(110136005)(8936002)(7696005)(38070700005)(83380400001)(33656002)(52536014)(8676002)(186003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEpNYkl6M2tKaXY5TmpLRkc0NmtOKzVTbU9xckFCd2RZanlEaVgwYVNVSmxk?=
 =?utf-8?B?aXdUNXJIamdJbWxhQkk2RnNaYWp1MjM5YkRKcDE5bWJFQjhCNWVTalBtdjNl?=
 =?utf-8?B?NVNZWTZMUEh0Q3NhMkhhc0MrTm1TU3YvV0JLMUkvM3VUL1Y4c3phamZNS2Y0?=
 =?utf-8?B?LzhydGVPeUlMRzE2aHlpWkpQd0VDclJjQWl1WC83OEZtRE15RXBrOWtQcmov?=
 =?utf-8?B?bmR1VU81N2VtMGI0MHVJQ0VpQkp0dGZUSFBOeC9uWkhZK2grdmtyVzRMNmg0?=
 =?utf-8?B?T2c2VkIyYUdNck1PdDltckJvTHZjZWxkRjZWUHE3eHpKTitPNVh3VGQ4Qm1k?=
 =?utf-8?B?YjhpS1ljcHR0eVpVUjRHSC9Rb0FHOS9paVhRWHMzd2szbnBsZFY2L3ZUc24w?=
 =?utf-8?B?VTRyR3pMcUxYbjVETHQ5ZDA3UnAwZks5MC9INWVmOHNKTkJCRWJ5S3JYcGtZ?=
 =?utf-8?B?TzNiZ0I3bnA5blpnZTFtKzJSNTdwcVlGeFlGNC94QzdHVmZKUWM2ZFVsbTNF?=
 =?utf-8?B?OWtnSkFCVThpQm1qRS8vMDhTU2lmNjNNck5GS05HVS91ZXJTc2Nna0hHbk5x?=
 =?utf-8?B?M1NKdVFzUmtaNzJaVUpPbVVvcXRtbjhPdFRjdGtmYjRycnUwMURnNXJTRmF2?=
 =?utf-8?B?eXhxd0VpUHU4VU9mS3B5R1FxSmpWTkpta0xYenYzeTYydjhZYTArN29ZbVl1?=
 =?utf-8?B?S1QzYnhGeU9GYUJTYlRiek1PVUNaSzdnRGZ6d1liSS9pS1lPb1c5Skk2TmxB?=
 =?utf-8?B?azZkQ1hraUFhYTE5TU5TVXZ4dGNGSk4rSHVvZkV0czc4WFlYMHRJS2VxNGx5?=
 =?utf-8?B?VElXcjlkY0RwZXJLdXV6ZHE0bGRJbFJRUWNzWHNvclZCMXMyZ25FVjliV2cw?=
 =?utf-8?B?V2MyRnFLaXZGMVNxVFNpbzBaM0gxTlloeTNGZTAvZ3hwc2U2TE5zNFYvRlZa?=
 =?utf-8?B?Zll5cHpNZENmYzB5bUt5MUcreVhXcWRYWWdpWG5TVVBhOHVYZm1UbmhycXJR?=
 =?utf-8?B?Z1h0MWw1REZPTmhDQU9lenpVS3BRQk1KMFNzZElMVzJ0V0NrUVRaVURkS2JP?=
 =?utf-8?B?U0tiTmpDVVczWXV1VUdKRGV1MjVFckxFM083UkhTTHNlSUVJeXErMUswTlNN?=
 =?utf-8?B?dm5IUVhReEVsQkYvYlF4aTAwQndES0dWTEc2TWliQWFDQ0ZZaFNxc0g1NFdH?=
 =?utf-8?B?ZWsrWHRiSE83Qk9QQ2JaUUtVajd2UVUwYUE2cldTbUdzZGQ2Z0tSc0FBTWlR?=
 =?utf-8?B?a3JvbXk5Z0N0eWc3WE5zbjRGSnE3SGt6ZUMrUE1QTGROTFd4WTgydkhpQ3o5?=
 =?utf-8?B?Ti9PR1lqUEs2TGJJNkMza0c3ZS94cTFBRG03L1RMMHduOUsrbEs5VnpHMlRB?=
 =?utf-8?B?TkN6dWRudVpTS0VGTm9PV2ZSeVl0SlU0K2QxZ2NiSzJxK0dzdlZBdm9nNTRV?=
 =?utf-8?B?aDNOTUtJYVo3WGR6YXRZTEZCUU9BUWpFRmgzbVVacTZicTlCVjg3NXdJVDJu?=
 =?utf-8?B?UFRtbHdMZXhtVFhBUVZuZ1JLN1h2dTJLZmxmV21tc3dXUnJWZWNtVlF1VUJ4?=
 =?utf-8?B?MWlIK3prVDFhSEFRS1dPUk1RV1I2bUVNWS85eHRKaVF6anN6Vkt0MHA0elov?=
 =?utf-8?B?bmdKRWo5VWVOdHVaZmpYQlBaaERaVnRTdTIvcTRCTXhOL1hSWCthYUhoTTA3?=
 =?utf-8?B?T2lxaHA2MVRMaXJkK2pxZEtndSs3em0veldtdnA5QzROc3RpWEJMRGx0N3hj?=
 =?utf-8?B?OTN5Q3pncGZrNGNxNW02UExKOTJnemNpQWhMTURoOWxrWmFINjhncklIcnF4?=
 =?utf-8?B?NGs3NUl4ZzM1T0c1U2p0OHhZdTk4d2c4OGgzM056M3VLbHY1OS9jQVNtdEY1?=
 =?utf-8?B?KzVIVVBnM3YwdzJOL3dZbHIrS2RJTHZzM28zcGZiUDFtZmtoa2xvYVk5QkpI?=
 =?utf-8?B?QU0zRVdyaEZyWXVQdmY4bkpJOERwSTUzQjZ5QXhTS2k5WjhoK3R0TUxyck1q?=
 =?utf-8?B?eS9hZXFHUkIyL3BsWkhhTi9UUjlzd1JYbnZ3MFNQUlUvbzFPNWhtaVBKZTlu?=
 =?utf-8?B?bVI5UnQyaG9xaXlQVTdzL1QxaFhFL2dDMVpJNmpoSzhwbG5Ka1k3S3RXd2wx?=
 =?utf-8?B?MVRSVG5heEtjWU1yeFdUNVAzZXVWeHplckFIOVNQY1FrU0R3SXgwdTJNSC9H?=
 =?utf-8?Q?jJ1MtIetE0Jqvdj7chA9D9w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d48f916-42f0-4147-78fa-08d9b4b79fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 10:44:59.9096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGJVnlyV5jYXiaDjoFaVLQbwXP0XLecUdZVSHijpSiI+TRKy74scGPv4ZLtnn0yj12xS0ahe6XDoLLhGWUujdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
U2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxLCAyMDIxIDU6MzAgUE0NCj5UbzogWXUsIExhbmcg
PExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExhemFyLCBMaWpv
DQo+PExpam8uTGF6YXJAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBzdXBwb3J0IHRvIFNNVSBkZWJ1
ZyBvcHRpb24NCj4NCj5BbSAwMS4xMi4yMSB1bSAxMDoyNCBzY2hyaWViIExhbmcgWXU6DQo+PiBU
byBtYWludGFpbiBzeXN0ZW0gZXJyb3Igc3RhdGUgd2hlbiBTTVUgZXJyb3JzIG9jY3VycmVkLCB3
aGljaCB3aWxsDQo+PiBhaWQgaW4gZGVidWdnaW5nIFNNVSBmaXJtd2FyZSBpc3N1ZXMsIGFkZCBT
TVUgZGVidWcgb3B0aW9uIHN1cHBvcnQuDQo+Pg0KPj4gSXQgY2FuIGJlIGVuYWJsZWQgb3IgZGlz
YWJsZWQgdmlhIGFtZGdwdV9zbXVfZGVidWcgZGVidWdmcyBmaWxlLiBXaGVuDQo+PiBlbmFibGVk
LCBpdCBtYWtlcyBTTVUgZXJyb3JzIGZhdGFsLg0KPj4gSXQgaXMgZGlzYWJsZWQgYnkgZGVmYXVs
dC4NCj4+DQo+PiA9PSBDb21tYW5kIEd1aWRlID09DQo+Pg0KPj4gMSwgZW5hYmxlIFNNVSBkZWJ1
ZyBvcHRpb24NCj4+DQo+PiAgICMgZWNobyAxID4gL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvYW1k
Z3B1X3NtdV9kZWJ1Zw0KPj4NCj4+IDIsIGRpc2FibGUgU01VIGRlYnVnIG9wdGlvbg0KPj4NCj4+
ICAgIyBlY2hvIDAgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9hbWRncHVfc211X2RlYnVnDQo+
Pg0KPj4gdjM6DQo+PiAgIC0gVXNlIGRlYnVnZnNfY3JlYXRlX2Jvb2woKS4oQ2hyaXN0aWFuKQ0K
Pj4gICAtIFB1dCB2YXJpYWJsZSBpbnRvIHNtdV9jb250ZXh0IHN0cnVjdC4NCj4+ICAgLSBEb24n
dCByZXNlbmQgY29tbWFuZCB3aGVuIHRpbWVvdXQuDQo+Pg0KPj4gdjI6DQo+PiAgIC0gUmVzZW5k
IGNvbW1hbmQgd2hlbiB0aW1lb3V0LihMaWpvKQ0KPj4gICAtIFVzZSBkZWJ1Z2ZzIGZpbGUgaW5z
dGVhZCBvZiBtb2R1bGUgcGFyYW1ldGVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUg
PGxhbmcueXVAYW1kLmNvbT4NCj4NCj5XZWxsIHRoZSBkZWJ1Z2ZzIHBhcnQgbG9va3MgcmVhbGx5
IG5pY2UgYW5kIGNsZWFuIG5vdywgYnV0IG9uZSBtb3JlIGNvbW1lbnQNCj5iZWxvdy4NCj4NCj4+
IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jICAg
ICAgICB8IDMgKysrDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUu
aCAgICAgICAgICAgIHwgNSArKysrKw0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL2FsZGViYXJhbl9wcHQuYyB8IDIgKysNCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXVfY21uLmMgICAgICAgICAgICAgfCA4ICsrKysrKystDQo+PiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4+IGluZGV4IDE2NGQ2
YTllOWZiYi4uODZjZDg4OGM3ODIyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4gQEAgLTE2MTgsNiArMTYxOCw5IEBAIGludCBhbWRn
cHVfZGVidWdmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+KmFkZXYpDQo+PiAgIAlpZiAo
IWRlYnVnZnNfaW5pdGlhbGl6ZWQoKSkNCj4+ICAgCQlyZXR1cm4gMDsNCj4+DQo+PiArCWRlYnVn
ZnNfY3JlYXRlX2Jvb2woImFtZGdwdV9zbXVfZGVidWciLCAwNjAwLCByb290LA0KPj4gKwkJCQkg
ICZhZGV2LT5zbXUuc211X2RlYnVnX21vZGUpOw0KPj4gKw0KPj4gICAJZW50ID0gZGVidWdmc19j
cmVhdGVfZmlsZSgiYW1kZ3B1X3ByZWVtcHRfaWIiLCAwNjAwLCByb290LCBhZGV2LA0KPj4gICAJ
CQkJICAmZm9wc19pYl9wcmVlbXB0KTsNCj4+ICAgCWlmIChJU19FUlIoZW50KSkgew0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUuaA0KPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgNCj4+IGluZGV4IGY3MzhmN2Rj
MjBjOS4uNTBkYmY1NTk0YTlkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9pbmMvYW1kZ3B1X3NtdS5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9h
bWRncHVfc211LmgNCj4+IEBAIC01NjksNiArNTY5LDExIEBAIHN0cnVjdCBzbXVfY29udGV4dA0K
Pj4gICAJc3RydWN0IHNtdV91c2VyX2RwbV9wcm9maWxlIHVzZXJfZHBtX3Byb2ZpbGU7DQo+Pg0K
Pj4gICAJc3RydWN0IHN0Yl9jb250ZXh0IHN0Yl9jb250ZXh0Ow0KPj4gKwkvKg0KPj4gKwkgKiBX
aGVuIGVuYWJsZWQsIGl0IG1ha2VzIFNNVSBlcnJvcnMgZmF0YWwuDQo+PiArCSAqICgwID0gZGlz
YWJsZWQgKGRlZmF1bHQpLCAxID0gZW5hYmxlZCkNCj4+ICsJICovDQo+PiArCWJvb2wgc211X2Rl
YnVnX21vZGU7DQo+PiAgIH07DQo+Pg0KPj4gICBzdHJ1Y3QgaTJjX2FkYXB0ZXI7DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0
LmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0
LmMNCj4+IGluZGV4IDZlNzgxY2VlOGJiNi4uZDM3OTdhMmQ2NDUxIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jDQo+
PiBAQCAtMTkxOSw2ICsxOTE5LDggQEAgc3RhdGljIGludCBhbGRlYmFyYW5fbW9kZTJfcmVzZXQo
c3RydWN0DQo+c211X2NvbnRleHQgKnNtdSkNCj4+ICAgb3V0Og0KPj4gICAJbXV0ZXhfdW5sb2Nr
KCZzbXUtPm1lc3NhZ2VfbG9jayk7DQo+Pg0KPj4gKwlCVUdfT04odW5saWtlbHkoc211LT5zbXVf
ZGVidWdfbW9kZSkgJiYgcmV0KTsNCj4+ICsNCj4+ICAgCXJldHVybiByZXQ7DQo+PiAgIH0NCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMN
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4+IGluZGV4IDA0
OGNhMTY3Mzg2My4uOWJlMDA1ZWI0MjQxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5jDQo+PiBAQCAtMzQ5LDE1ICszNDksMjEgQEAgaW50IHNtdV9jbW5fc2Vu
ZF9zbWNfbXNnX3dpdGhfcGFyYW0oc3RydWN0DQo+c211X2NvbnRleHQgKnNtdSwNCj4+ICAgCQlf
X3NtdV9jbW5fcmVnX3ByaW50X2Vycm9yKHNtdSwgcmVnLCBpbmRleCwgcGFyYW0sIG1zZyk7DQo+
PiAgIAkJZ290byBPdXQ7DQo+PiAgIAl9DQo+PiArDQo+PiAgIAlfX3NtdV9jbW5fc2VuZF9tc2co
c211LCAodWludDE2X3QpIGluZGV4LCBwYXJhbSk7DQo+PiAgIAlyZWcgPSBfX3NtdV9jbW5fcG9s
bF9zdGF0KHNtdSk7DQo+PiAgIAlyZXMgPSBfX3NtdV9jbW5fcmVnMmVycm5vKHNtdSwgcmVnKTsN
Cj4+IC0JaWYgKHJlcyAhPSAwKQ0KPj4gKwlpZiAocmVzICE9IDApIHsNCj4+ICAgCQlfX3NtdV9j
bW5fcmVnX3ByaW50X2Vycm9yKHNtdSwgcmVnLCBpbmRleCwgcGFyYW0sIG1zZyk7DQo+PiArCQln
b3RvIE91dDsNCj4+ICsJfQ0KPj4gICAJaWYgKHJlYWRfYXJnKQ0KPj4gICAJCXNtdV9jbW5fcmVh
ZF9hcmcoc211LCByZWFkX2FyZyk7DQo+PiAgIE91dDoNCj4+ICAgCW11dGV4X3VubG9jaygmc211
LT5tZXNzYWdlX2xvY2spOw0KPj4gKw0KPj4gKwlCVUdfT04odW5saWtlbHkoc211LT5zbXVfZGVi
dWdfbW9kZSkgJiYgcmVzKTsNCj4NCj5CVUdfT04oKSByZWFsbHkgY3Jhc2hlcyB0aGUga2VybmVs
IGFuZCBpcyBvbmx5IGFsbG93ZWQgaWYgd2UgcHJldmVudCBmdXJ0aGVyIGRhdGENCj5jb3JydXB0
aW9uIHdpdGggdGhhdC4NCj4NCj5Nb3N0IG9mIHRoZSB0aW1lIFdBUk5fT04oKSBpcyBtb3JlIGFw
cHJvcHJpYXRlLCBidXQgSSBjYW4ndCBmdWxseSBqdWRnZSBoZXJlDQo+c2luY2UgSSBkb24ndCBr
bm93IHRoZSBTTVUgY29kZSB3ZWxsIGVub3VnaC4NCg0KVGhpcyBpcyB3aGF0IFNNVSBGVyBndXlz
IHdhbnQuIFRoZXkgd2FudCAidXNlci12aXNpYmxlIChwb3RlbnRpYWxseSBmYXRhbCkgZXJyb3Jz
IiwgdGhlbiBhIGhhbmcuDQpUaGV5IHdhbnQgdG8ga2VlcCBzeXN0ZW0gc3RhdGUgc2luY2UgdGhl
IGVycm9yIG9jY3VycmVkLg0KDQpSZWdhcmRzLA0KTGFuZw0KDQo+Q2hyaXN0aWFuLg0KPg0KPj4g
Kw0KPj4gICAJcmV0dXJuIHJlczsNCj4+ICAgfQ0KPj4NCg==
