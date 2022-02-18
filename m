Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0341C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 04:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D6B310E24E;
	Fri, 18 Feb 2022 04:27:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA7810E24E
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 04:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHfxwA6j4lEk8UtwL2W/osZ/mNIdZWp5SOBH2xGnWwFloa53QQnHjucBoObwLX3uYBnXPg/KyF6s6t/QgXzeGzHaoq8kYGMHbNNTpLy1NgmQB4z5P9vBKFDwZMOHO+UpSooWOofimRNaL67inQjE0+J5/VYoh6hd4l+VLWVXcrSCweT5vJkTAlA4iTbOmMyCnR7HpE/dSj1cq2kEbty/WkdJntsq3v0yKL9jWd4NaVrX7adBi7JFV2jlCJrvnxeIIl3syprW4/KrwjDKVwuQEVsq9isRlF/mxJbkPVaoH1f6vhXP7U8IkgOSMOY/1+7WvLiiTz+e4yv3X0kr3vFsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/rbh3oGigZd/J3VsnoODqSxCAc+6nnspBGHHh6l3CA=;
 b=V+nDfXaXJrs/cBG/baE2RWIK6aWyW3jKmceTb+wEequ0jHZ8B8YhmKW1HaacDj9mEkoQ+saQz0tLsgJ0NqVjbCX3qErMT7HnMsX/cs8o2L3fpFaoI3PkYpCdZ2Aw5/yCpDjbdHhMInHbBG0WG7rNZ8XmF+BuQQghoG93Osd8lpLyLUdrSk6jisMjHg/mpSwQ2eP7HhW/QJzwNcIIxj2TDxpfZpNdbhp6jRU0BXhcjSTozKPkEkgX0PT5g3BM6RUJypzvZYUdrXTJYiChhrphOT/PH1IR23pNyg7KO8dOOomWbc1+sh+LGy7emxwV4XLmuHaZ5r6tQhRMbf83PajsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/rbh3oGigZd/J3VsnoODqSxCAc+6nnspBGHHh6l3CA=;
 b=VEYN0anIJP8FRNYa9mFXLE+ESp6XuzevZoz07ntq99jRhyDFzQ20g6ZW8zM64Z1iobm6Bvrz/nojoX3L+wtPfkRV1OW/4Cb2HH1GW4HQWOD7n/ND7noC/aofpxviBxUQCRPOVzRtzQLDpKP6fVestL0VbbCGNbzwWO59ihWIcPc=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Fri, 18 Feb
 2022 04:27:06 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba%7]) with mapi id 15.20.4995.014; Fri, 18 Feb 2022
 04:27:06 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Thread-Topic: [PATCH] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Thread-Index: AQHYJHukXF9TM850b0GuCM8tTPxT8qyYsFYAgAAEFOA=
Date: Fri, 18 Feb 2022 04:27:06 +0000
Message-ID: <BYAPR12MB32384F7915C0784BEAAD3223FB379@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1645156501-18317-1-git-send-email-Prike.Liang@amd.com>
 <5db9229e-52c3-fc4a-f8b5-29a25366208e@amd.com>
In-Reply-To: <5db9229e-52c3-fc4a-f8b5-29a25366208e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=436ff55d-2a01-4b5b-8b88-bd32f16f353c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T04:19:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0a3b8f0-bd3f-413a-1e7e-08d9f296ebd9
x-ms-traffictypediagnostic: SA1PR12MB5616:EE_
x-microsoft-antispam-prvs: <SA1PR12MB561612B1658986C20CB59673FB379@SA1PR12MB5616.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chNiJaCc217E+CRUrp8okR5cYdd5v0Qxhap4Jk7uUJ/GI1kt95de6kvXmyV/37dYu7fKJY//fySKznDmbFq7LHgk2782ZxoXbU/7XZB8z/OfR37gtAJpT9DZPGCPVVvB/BRw8LTSEalDt0oAegXFJNzORjlNSjDiMVsUEPbfp2GLtr9/JH1FnYO0enX0jqrspZPx+5XSPjzHaxj3HWQ6YvMaYUek1af+4udCV0L+PdyA2h3xvQr3f/s3zpXJ5tAYH7V3P2HujO3287YwsRQx8yxuN5yK8PFRXaqhLqft57qu/LSsN2rVcbw1b74359MATeoKmBhgnk574CXu0ByeMTeRVqKexFIwpKvGdxSv1gue73A4mc6sZrVz3MXZgYR1RzED69zTkpJ2Wymmmh96xOnZ0zXKyda3wXzTbllLTcEy6niYhfHFyBFlNHwjfPhewXPphklE8kUvifYVYoaDwoaYu4EZoSJfmc6d7DPTdyiJPv1f4+6/EoM/zvrgL2VqBVgc7Aj7XVeFcqAgNVSMjkoLLXKbeGPrUZZZ/W0snBIQL/8dEdwPWYaBkjanA+ADL1X4lyoZ4BKoOIhKLIA29PsB7rWGh/kytxfh1zA/5HypNCZkLGfpwg4rPS4BMHo/dPzif3qjg2/Xhx/vgiL6CvU6fQh7uv04nP+MounRaQCyPlPQ4PiQixARnBC0RzC0wEenlDkvzij8kS7v3I9yfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(5660300002)(66446008)(38100700002)(15650500001)(8936002)(8676002)(2906002)(38070700005)(52536014)(76116006)(66556008)(26005)(186003)(4326008)(71200400001)(7696005)(110136005)(66946007)(55016003)(508600001)(316002)(6506007)(86362001)(66476007)(53546011)(9686003)(83380400001)(54906003)(33656002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVBqUjEraHJITW1RMGF5Y1JCQzVUYk9XQ29VY3ZkNHpYRWNlelQxbFRvZVpp?=
 =?utf-8?B?ZTM2SXQ5QmlWcE5RVXRBQTVrTE5XMXBuNjM2L0pSeFlnV0Q4WXBLYitZWTM0?=
 =?utf-8?B?cDhDZHhDaDVYbDdsZHFGUWRFT2x5NG1IQnN6RXFZWE9xK1JLNjdYYXZQMmlH?=
 =?utf-8?B?UGhnTjVLNnVaWWdsS2lzZHJja21yU0ZmT3RzVVl6dTBZS0lYcDcxOG1Xbm5U?=
 =?utf-8?B?ZWxPcVVJNkJwdnc5dkpZWXcyYUlkcHNWbmRDaE10RGM3SUp3Z1lPeEd3NVFy?=
 =?utf-8?B?ZERndlI4dUtVK0xoV3RkaG5lNm1PdlZZQkJ6am9ZNDNoeEwrL0x3OG1ReXNF?=
 =?utf-8?B?VDh2N1ZqVCtZMEQ2azByV0hCMWZQcTUrajhvZWMyVHlGU0FvQUUyVmwyTTVV?=
 =?utf-8?B?b0VrVEpKdktMenFOaXZpYjJlTzN5QklxSXNIcmJiT0QxbCtSbEpKZncyTTJt?=
 =?utf-8?B?bituRkpld2F2eUlDbkhjb2cwa0tKZVRpTnp1NDQyNW1Nbi9OVEVNbCtsYlVh?=
 =?utf-8?B?M0o4QUgyS014QnkwZzRSUW1PWWViS0FVL3I2b21IaGt2MUJvYnRYaFRlSFFu?=
 =?utf-8?B?b2dDMHBkczFJc1c3b2tzblR2U1BNRG5YYUR5TnJvYXBUOTE2TDJsWlphUWs5?=
 =?utf-8?B?QmQ1VWpiOGdTR09wWitZQkp5a1BCZHR0cWhzVEZvUHN0a1Q0UmlPTEF1djhh?=
 =?utf-8?B?M0JlblVrdEdpR3lESXUxSWphQzZnS2tCWDlkRU40ekJCcUo2cVU4ME8zdEJ6?=
 =?utf-8?B?TlpSSDFYKzg4K1lCa0paSWZXTy9vUzZXMkVrQjBZUngwVmc0cHBRaDJRWXQz?=
 =?utf-8?B?aExuQUJBYjgzT25URW9ZZ1BJYkljQis3dWNrTy9PcHBtQ1EzM0dRQmp6cGxL?=
 =?utf-8?B?KzlnOVBMbnY3UWlWRldXdEtPd3FYQ0RTTjkyajQyZUhWeVd4UHoydndjaDNB?=
 =?utf-8?B?eXpRSlVPbmVsTmJjcnpWdWRsR2VGTEVKdjM3Yk51Z29MSEkzcmFuNTBHT0Q4?=
 =?utf-8?B?NzUrOVBzK2dHMGllZnVlUnEwOVNKRnRMQUtyQWxpNUlsSlNERzNpRy9EUFoz?=
 =?utf-8?B?OEd2S1l3cmREa3E3Mml4ZG1adnBSN3hIYjcyTEc3UHFnclVBaStyUGFDcDJE?=
 =?utf-8?B?YXZGSHQ2Mi8xZlRkWVU5MjBmTWN2T1hIT0RrS0s5VUJCTEhjVzNreGx6WUhl?=
 =?utf-8?B?ZjZHRTIzUFBNSmJvb2YvRzF1amFFWFpraXhYY085ZVZYZEoxK01qMzQ1WU1Q?=
 =?utf-8?B?bWlQYXJxMzZaRnRhWjRvQUxqbUdUQklEQS82K2tHWXdvaHFFNGNZbEZrNHNN?=
 =?utf-8?B?VVY3QVZNd0s4aVhZTHoyb1JnZytSMVFzc25yWHEvREsvQms1bXRtMHNlNGxs?=
 =?utf-8?B?SE1NdGZtcVNOV1YxWTBKa0pCeHNKQk1oNmZpOFV2cnE2eVEwNXZGVDZUTlRY?=
 =?utf-8?B?aUVJNmJXRGRkZDFrUWpUSHNsU1haZitsakRrcnlGbHpzaGo4RkRZVG5RZjA1?=
 =?utf-8?B?ZENENlpPK0UxRkE3RG5rWXhIMUZ0alcyMGdWKzdsbkgrTkZITVJzeG5HL1Bm?=
 =?utf-8?B?WE1MbkhsL1p0djdxN2dvVXJ5c1NqOTg1a3Vhd1dFWGFhaUNqeTdyMWJ6OVpq?=
 =?utf-8?B?MlAxY0gwaHlhZTg0U2EvVVNxRjZSb0UxZWh2VllFalFtVEJXWE1OOHR2eEV0?=
 =?utf-8?B?TjFIWmZwUVJVc2MyUy9JWm11OFlxejVzN0R3SVRGUDBjbVp0SGR6bjJIYXAz?=
 =?utf-8?B?eTNZRkJDNncxZm5KbW16VFp5RisxRmx3VUptVkZQUFBEWmVIbitnWWFKSzJs?=
 =?utf-8?B?Y2ZBdktIeWlsb3VwTGFseUxhOG9TUGc4Nzg3R1RRSUFmSjJ5QTdSU2FLd0dM?=
 =?utf-8?B?a3JuemhyNlVIbWFFV2FCa01MM2ttRm9mcjZiTTEyTUJrNWJlU244NWFLUEtm?=
 =?utf-8?B?TnVYSU5DUS9HeCttS3RBaWYxdk0rdFN2RGRxc2hTMW5taUdDbHF2ZGJmSmxt?=
 =?utf-8?B?bmZFQlpmSERRSVJWZUZya3FyUHg5MjZIcHZJT2xlN1djSTVtUllKeld4QVlh?=
 =?utf-8?B?RC9oZlE0RWJzV0srZUV2RGlqYUtWSTRzeTRNZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a3b8f0-bd3f-413a-1e7e-08d9f296ebd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 04:27:06.3183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RYFbn3AIdFCNCoU011LrjW42jf/9vuXiC6T5A3hKEpaMA8tZf6nyPV27oQ0Htk2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE4LCAy
MDIyIDEyOjA1IFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUXVhbiwgRXZhbg0KPiA8RXZhbi5RdWFuQGFtZC5j
b20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZC9wbTogdmFsaWRhdGUgU01VIGZlYXR1cmUgZW5hYmxlIG1lc3NhZ2UgZm9yDQo+
IGdldHRpbmcgZmVhdHVyZSBlbmFibGVkIG1hc2sNCj4NCj4NCj4NCj4gT24gMi8xOC8yMDIyIDk6
MjUgQU0sIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IFRoZXJlJ3MgYWx3YXlzIG1pc3MgdGhlIFNN
VSBmZWF0dXJlIGVuYWJsZWQgY2hlY2tlZCBpbiB0aGUgTlBJIHBoYXNlLA0KPiA+IHNvIGxldCB2
YWxpZGF0ZSB0aGUgU01VIGZlYXR1cmUgZW5hYmxlIG1lc3NhZ2UgZGlyZWN0bHkgcmF0aGVyIHRo
YW4NCj4gPiBhZGQgbW9yZSBhbmQgbW9yZSBNUDEgdmVyc2lvbiBjaGVjay4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMgfCAyOCArKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdV9jbW4uYw0KPiA+IGluZGV4IGYyNDExMWQyODI5MC4uZGExYWM3MGVkNDU1IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gPiBAQCAt
NTUyLDEwICs1NTIsOSBAQCBib29sIHNtdV9jbW5fY2xrX2RwbV9pc19lbmFibGVkKHN0cnVjdA0K
PiBzbXVfY29udGV4dCAqc211LA0KPiA+ICAgaW50IHNtdV9jbW5fZ2V0X2VuYWJsZWRfbWFzayhz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDY0X3QgKmZlYXR1cmVfbWFzaykNCj4gPiAgIHsNCj4gPiAtICAgc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSBzbXUtPmFkZXY7DQo+ID4gICAgIHVpbnQzMl90ICpmZWF0dXJlX21hc2tfaGln
aDsNCj4gPiAgICAgdWludDMyX3QgKmZlYXR1cmVfbWFza19sb3c7DQo+ID4gLSAgIGludCByZXQg
PSAwOw0KPiA+ICsgICBpbnQgcmV0ID0gMCwgaW5kZXggPSAwOw0KPiA+DQo+ID4gICAgIGlmICgh
ZmVhdHVyZV9tYXNrKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IEBAIC01
NjMsMTIgKzU2MiwxMCBAQCBpbnQgc211X2Ntbl9nZXRfZW5hYmxlZF9tYXNrKHN0cnVjdA0KPiBz
bXVfY29udGV4dCAqc211LA0KPiA+ICAgICBmZWF0dXJlX21hc2tfbG93ID0gJigodWludDMyX3Qg
KilmZWF0dXJlX21hc2spWzBdOw0KPiA+ICAgICBmZWF0dXJlX21hc2tfaGlnaCA9ICYoKHVpbnQz
Ml90ICopZmVhdHVyZV9tYXNrKVsxXTsNCj4gPg0KPiA+IC0gICBzd2l0Y2ggKGFkZXYtPmlwX3Zl
cnNpb25zW01QMV9IV0lQXVswXSkgew0KPiA+IC0gICAvKiBGb3IgVmFuZ29naCBhbmQgWWVsbG93
IENhcnAgKi8NCj4gPiAtICAgY2FzZSBJUF9WRVJTSU9OKDExLCA1LCAwKToNCj4gPiAtICAgY2Fz
ZSBJUF9WRVJTSU9OKDEzLCAwLCAxKToNCj4gPiAtICAgY2FzZSBJUF9WRVJTSU9OKDEzLCAwLCAz
KToNCj4gPiAtICAgY2FzZSBJUF9WRVJTSU9OKDEzLCAwLCA4KToNCj4gPiArICAgaW5kZXggPSBz
bXVfY21uX3RvX2FzaWNfc3BlY2lmaWNfaW5kZXgoc211LA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQ01OMkFTSUNfTUFQUElOR19NU0csDQo+ID4gKw0K
PiAgICAgICBTTVVfTVNHX0dldEVuYWJsZWRTbXVGZWF0dXJlcyk7DQo+ID4gKyAgIGlmIChpbmRl
eCA+IDApIHsNCj4gPiAgICAgICAgICAgICByZXQgPSBzbXVfY21uX3NlbmRfc21jX21zZ193aXRo
X3BhcmFtKHNtdSwNCj4gPg0KPiBTTVVfTVNHX0dldEVuYWJsZWRTbXVGZWF0dXJlcywNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsDQo+ID4g
QEAgLTU4MCwxOSArNTc3LDcgQEAgaW50IHNtdV9jbW5fZ2V0X2VuYWJsZWRfbWFzayhzdHJ1Y3QN
Cj4gc211X2NvbnRleHQgKnNtdSwNCj4gPg0KPiBTTVVfTVNHX0dldEVuYWJsZWRTbXVGZWF0dXJl
cywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDEsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBmZWF0dXJlX21hc2tfaGlnaCk7DQo+ID4gLSAgICAgICAgICAgYnJlYWs7DQo+ID4gLSAgIC8q
DQo+ID4gLSAgICAqIEZvciBDeWFuIFNraWxsZmlzaCBhbmQgUmVub2lyLCB0aGVyZSBpcyBubyBp
bnRlcmZhY2UgcHJvdmlkZWQgYnkNCj4gUE1GVw0KPiA+IC0gICAgKiB0byByZXRyaWV2ZSB0aGUg
ZW5hYmxlZCBmZWF0dXJlcy4gU28sIHdlIGFzc3VtZSBhbGwgZmVhdHVyZXMgYXJlDQo+IGVuYWJs
ZWQuDQo+ID4gLSAgICAqIFRPRE86IGFkZCBvdGhlciBBUFUgQVNJQ3Mgd2hpY2ggc3VmZmVyIGZy
b20gdGhlIHNhbWUgaXNzdWUgaGVyZQ0KPiA+IC0gICAgKi8NCj4gPiAtICAgY2FzZSBJUF9WRVJT
SU9OKDExLCAwLCA4KToNCj4gPiAtICAgY2FzZSBJUF9WRVJTSU9OKDEyLCAwLCAwKToNCj4gPiAt
ICAgY2FzZSBJUF9WRVJTSU9OKDEyLCAwLCAxKToNCj4gPiAtICAgICAgICAgICBtZW1zZXQoZmVh
dHVyZV9tYXNrLCAweGZmLCBzaXplb2YoKmZlYXR1cmVfbWFzaykpOw0KPiA+IC0gICAgICAgICAg
IGJyZWFrOw0KPg0KPiBUaGlzIGlzIGJyb2tlbiBub3cgYXMgdGhlc2UgQVNJQ3MgZG9uJ3Qgc3Vw
cG9ydCBhbnkgbWVzc2FnZS4gSXQgaXMgYmVzdCB0bw0KPiB0YWtlIG91dCBzbXVfY21uX2dldF9l
bmFibGVkX21hc2sgYWx0b2dldGhlciBhbmQgbW92ZSB0byBzbXVfdiouYyBvcg0KPiAqX3BwdC5j
IGFzIHRoaXMgaXMgYSBjYWxsYmFjayBmdW5jdGlvbi4NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+
DQpCZWZvcmUgdGhpcyBzb2x1dGlvbiBJIGFsc28gY29uc2lkZXIgcHV0IHRoZSAgc211X2Ntbl9n
ZXRfZW5hYmxlZF9tYXNrIGltcGxlbWVudGF0aW9uIGluIGVhY2ggKl9wcHQgZGlyZWN0bHksIGJ1
dCBzZWVtcyBuZWVkIHNvbWUgZWZmb3J0IGZvciBpbXBsZW1lbnRpbmcgb24gZWFjaCAqX3BwdC4g
SG93IGFib3V0IHdlIGFsc28gY2hlY2sgdGhlIFNNVV9NU0dfR2V0RW5hYmxlZFNtdUZlYXR1cmVz
SGlnaCBtYXBwaW5nIGluZGV4PyBBcyB0byB0aGUgQVNDSSBub3Qgc3VwcG9ydCBuZWl0aGVyICBT
TVVfTVNHX0dldEVuYWJsZWRTbXVGZWF0dXJlcyBub3IgIFNNVV9NU0dfR2V0RW5hYmxlZFNtdUZl
YXR1cmVzSGlnaCB3aWxsIGhhcmQgY29kZSB0aGUgZmVhdHVyZSBtYXNrIGluIHRoaXMgY2FzZS4N
Cg0KPiA+IC0gICAvKiBvdGhlciBkR1BVIEFTSUNzICovDQo+ID4gLSAgIGRlZmF1bHQ6DQo+ID4g
KyAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgICAgcmV0ID0gc211X2Ntbl9zZW5kX3NtY19tc2co
c211LA0KPiA+DQo+IFNNVV9NU0dfR2V0RW5hYmxlZFNtdUZlYXR1cmVzSGlnaCwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmZWF0dXJlX21hc2tfaGlnaCk7DQo+
ID4gQEAgLTYwMiw3ICs1ODcsNiBAQCBpbnQgc211X2Ntbl9nZXRfZW5hYmxlZF9tYXNrKHN0cnVj
dA0KPiBzbXVfY29udGV4dCAqc211LA0KPiA+ICAgICAgICAgICAgIHJldCA9IHNtdV9jbW5fc2Vu
ZF9zbWNfbXNnKHNtdSwNCj4gPg0KPiBTTVVfTVNHX0dldEVuYWJsZWRTbXVGZWF0dXJlc0xvdywN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmZWF0dXJlX21hc2tf
bG93KTsNCj4gPiAtICAgICAgICAgICBicmVhazsNCj4gPiAgICAgfQ0KPiA+DQo+ID4gICAgIHJl
dHVybiByZXQ7DQo+ID4NCg==
