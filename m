Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5F7C54791
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Mar 2024 12:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F1710E079;
	Sun, 10 Mar 2024 12:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qFwdrbhv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C03210E079
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Mar 2024 12:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS7yzfPMrg5z2loABkq4wEHYCPu8MhyUqaMe/E8niFXKrTQ0fFwxo2rRY9RliB0HvuCa2EaQkzJAy5hWv66CNd1Lve5XHIE6/+bOyZuvcI3tRRii4efyopW5S0o6U0rw3BuG5WBhnCbhoL1CiMpzAftC/+pt/4P4CM3WIgCvE0cE+mBqWHnRuUiIiITefLe6gUuZCsZ03dztLzRk2haHYwKusQ/p0j/DJCfpOPKon5BKnXedMUsUMpTLGIuRxPzvXeHjHDvaQmVw3sLquR1kKJH9UgoclgtYDx1WpZYOXx+D2iQYuB5JPCpwher2HhXmmWva1Hm+VVQhpdUt/WMi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWCwWaaRbv8Sfr4bqvBEish/gEf/VJ/x8R83Qugt2AU=;
 b=etXjpaGzLNKSwPt7TZ83r0B8WyMjQmPvkq2FKKT09908q8ShTiBN6TKYYp7OhMWRNTasiwpZShST1umjcZCnym6K3JXcpsQWsYWrse3xY0zwN4BxtXuwjm0e0GZj/iCD0vOMyVFT8TpqKf1e4ZBBI58beRec/LbaqLnKQ05xPU8B77OGngvsF07HR5diYans58grWPwYjA772WMPGWmpwEqWAwc0KgUcWQwzyx6QdBxJ603jzf7W+ZH96jjv13GHqolF0itAmQ8nGk5gv9PLPpwYXb3LEmcXNwFdGE06qlxMD3pwscl3cy4rkQ2kvYG3w0vfmqtUsyn4KNfO3LffUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWCwWaaRbv8Sfr4bqvBEish/gEf/VJ/x8R83Qugt2AU=;
 b=qFwdrbhv6wAZUTfAuImd7YSE+ZKXbfjlbbXNb5ghA6/HrMpdR6jBkJCEjI4wFzr8UGG1rHQMy/a/btNxfOo45bu+xe+SXulbhSyGzXsd0Q+JMeJnyIbLoa6TQfSYgHPNuyQn/bCX1SNDcfqtBig9KGtrWFVRNul3Y1ryo08XI0c=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 12:30:50 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 12:30:49 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable smu block for smu v14_0_1
Thread-Topic: [PATCH] drm/amdgpu: enable smu block for smu v14_0_1
Thread-Index: AQHacQhfWQ5K2VV0jkuaS7kV0fPVNLEt6DMAgAMBKpA=
Date: Sun, 10 Mar 2024 12:30:49 +0000
Message-ID: <SJ1PR12MB607561D39A70637F8BADB366FA252@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240308032527.1031907-1-li.ma@amd.com>
 <CADnq5_Nyfh0pMcCx4JiqwB2Vqk4XGWerOW+KoOYbwtrz0AuzYA@mail.gmail.com>
In-Reply-To: <CADnq5_Nyfh0pMcCx4JiqwB2Vqk4XGWerOW+KoOYbwtrz0AuzYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b05d8ae8-0eef-44c9-85e7-86d185beffd5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-10T12:23:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|SN7PR12MB6716:EE_
x-ms-office365-filtering-correlation-id: b0d61ef3-65dd-45dc-dc21-08dc40fdeb48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3xIYtL7lkxrSixPysrUKYL/360+rkFPO3cVzU8x1cwhbXkD9dn/B0+3hJaWdoxLkFh9pYwVPIgMP2vM5CH3EKstSym8HhGDvCEEF7TVNAMGgpkY0JJfMrDJtulnicr/b89aDtIZ7O4Q0hf/SNjh6DgNslp3GECHCGTTiTo8MK6k6s89q8mWgpGSAUaPWYSpAt9YCXlGkDbE8Q1MkWWbN9h2tu7I1UcOkFxJQ4O+39rMwPSgTb2KY6DH2AqLYKDu60Z2yoWFXmqQ1jvrTQPzrsNNf+T0YROj1fyQhXolOAf5U041K+Hv89zmTL6o9m3fop8ixKc8nm5gCgkLS0Sz9ndD6msYbv32FhERNY92NcmTqryKI55g/jQGJx4EuYxiOpygB4QaecjDR2tuUK7cRhNkDQG1s579k0RtaU7rs6ZQd4Qt5z7+yXuGEIOWtZnvhmes3ixGXynYZHDGLktNOdv0nepcmqg/iHVwKsAaHRccqNfWw4n7rpIm8EDmOH+E+5ty9ybHn87LpeabioyU9wH8outememG3O7vi0oVHDSQGutaS+iDfWpWGUBaGyFzwyXJjBeMjmQu6c2AYZlERzBUcnBr03IMEdm/1PO4BMbejk1MpRU4PJx5t/qsgoTJdfdfv/2ShxmvCviC/PJJY7R2Nm9SlS7gi5VsApXYha2bldSzoBX+t98iJZDcyoDXmlRuRhDwHHdmEf2jb4DET8liPZJQt9uOVpQdjTOl7N4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDdyMk03ZjBLSStuQzVycDFQMFoxUHVDeGxJYmQ4bFhGR05TQzVFQXJHQzJY?=
 =?utf-8?B?WmtQelMxbjVFc09LNFJGMk9xUCsxak1EVERvMXpsWXRYQzVGQTJSbEZJb0Ns?=
 =?utf-8?B?OTRpYnZnOVZaQ0tQbzc1bWZFSmgxWlUzZm1FMktLc0RQTGZnMDk0dWFGTmxi?=
 =?utf-8?B?ZUY3aUdkL3FDMGhvLzd1Q2QyakNnL3FPc2pyR3g2bGFJZ0UxNVVWRm1lTjlS?=
 =?utf-8?B?VEd1TS90NXByU1BpZWtvdDdKeDN2QnpZYjhiYjlJSW1Tb3NBYmNHRkZia1Jk?=
 =?utf-8?B?LzZoQ1F2cWlOZ1JaWVZLZ1ZQb05wSFljS2hXOGtLcml2SGFpREdXcHZIY0Y2?=
 =?utf-8?B?a0R5Szd4VTZwNHEyL3Y2M2l3WXhGTzJTSHV0UStqeExaK2x2RjRjNWZhVlFu?=
 =?utf-8?B?ZlJDSW5ieEZjV2I2ZHVoRnhreVcvTk11TnpwWGM1a3NqN0drbHg2REhJRDBK?=
 =?utf-8?B?WkdrVDd0UDJ4U3RjRVErTXQwU0NnVGdsTXZncDNpVlBlSXluVzlzT1ZRYU42?=
 =?utf-8?B?SjVKNVpRZWIwdzdMTFlnNGNEQnpyL2FKakhtRzJoN2lUL3BvNnlEdUMrUDU3?=
 =?utf-8?B?eHVkam1uWVJvZDNTTHJQOWNaWHFDaXljb2R1NVFkNmpUbm1uRFNZU1liS3Y3?=
 =?utf-8?B?bE51azhPYmxGNUtXamZaUHNieVk3c3ZNYloxL3h3TEc1VndyZ2ZGQXBXUU8w?=
 =?utf-8?B?NDZERWtLQURGTEdLYzlvR1NmR0svWXQ1YnZPR1pSL0JJcFltd2x3c1Axd2s5?=
 =?utf-8?B?MUNaUlNyYkpnQU5DWnJtNG16M2Jsd1ZTdmg0VkpEK0ZoVDJBNHdnR2VTZUI3?=
 =?utf-8?B?azN1dWNWSTJFZ1NpSjFxZkozSE81TDZxR0tYWDBDaXAra056QW9ybzJLbVJ1?=
 =?utf-8?B?ZVhpL3d3VjUwOXpldlZVRFR6RVhIcjRQdXEwaWQwNE0zdUtTSCtqWGRsOUp6?=
 =?utf-8?B?SHdsaDJOZkZmQnlwYUpIalZac2dMZXc4amh1M3JLanhTQnNGZGpjVENZM1k1?=
 =?utf-8?B?WUdFWEtKRFJhT20ySjNhLzQxZVFWUTN1ZXBBTXRLbjNIL0JHWjA4TTZHVkdE?=
 =?utf-8?B?eXRvQjM3czNTZTJqVHBjRmhrYmZjcG1ObGVRYkZNS2NadUpKbDY3TE1LMUpl?=
 =?utf-8?B?c3ZSUHVpNTJYSmZ4cFJHK1hNaUtmQzRZOUFCSEY4RVo5a2lVVHNZdnNWeFNF?=
 =?utf-8?B?ZlBabDI5SUQxOUZLZXpGaktWYktxT3M4cGhnMHlSbmY2OWdaNHhUL3dtaCtk?=
 =?utf-8?B?bDhHK1haSFZRd0VubFJFS1V3YnNZS1lhZXZpYnBMeit6Zm9IWTJBY2hMczZO?=
 =?utf-8?B?NnBpellERGg2TkQxTFptVkpRM2o3US9iNm5xOFdLVVZKaDBCcEFHYzFYODRR?=
 =?utf-8?B?bDlzUlcyaDF3ZW1mR3JDSy9Bb2gzaDJaUTVjZEhHZ1BGanMxc0FyMDNhdXZ6?=
 =?utf-8?B?ejhrQjV3S0dqNURGek9BeWlMbVNvSFF5YjZwbGhkSTUvUzZBNWVhejhrZmox?=
 =?utf-8?B?Mnc4WWxlekowSWplay9qODBxTTZsbUd0SjVKZVNwaERIaUh2a1A0UUsyYUV5?=
 =?utf-8?B?WTF2WWFpcllQL2oxdklPVnJabi96VDlEaXQ1OHZkcGxvZi9YM3Z3NVR1ZFFr?=
 =?utf-8?B?amdWL0ZDbXNGVUhFcWNRcSttYjFyQlJzZ0VnOXgzZTZBZU9sd2VXS1hIUUZ6?=
 =?utf-8?B?NnlBUW1DTHVyWFV5RGtLOFlPTnYzZnhGWlltcEt0aFlQQ2cyTEs3WkNRMkMv?=
 =?utf-8?B?TU4xY2xrejJPbGFvemFMQWtNdlZKbElWVnVOL0c1UVJraTl6TmtwRFdaajF5?=
 =?utf-8?B?UCtCcUlQSzJ4eFFsRlFocUdsOEJoWmN5MUVWTTV0VG53Y2lXK1Y4ZUtiRGhh?=
 =?utf-8?B?eFZwUVFvZkxMMHl0NVRyUW5jM3dYUzhrNHk2aEZ1SGtpZTErWnFtUU5MYUg5?=
 =?utf-8?B?MjZsQUI5dEFZRE1XeUtsRVBHWFhWNG9TK1JwN0JhL2hUbmFrdHd6ZWF6bDBi?=
 =?utf-8?B?WEVNWCsrQlZ0S1NKVmpDcTFKaWM0YTJHbXFjU0ZNREZFVVRsaXptZWZzaFBY?=
 =?utf-8?B?K3N4MVEvbUxpaG5xQ3FkN011Zk5SLyt0TU8zdVNybVNIWk9Tb2x4QWZ3N0RZ?=
 =?utf-8?Q?Vyis=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d61ef3-65dd-45dc-dc21-08dc40fdeb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2024 12:30:49.7955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VekX4F27v0j+Aqy5RbEvvNdpfFE40cfW0qj4F8LRmlkiVjr0YuEh1TeZnQt/tJ+UiBKHtE6R+7Dtp3SeDX+slg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgsDQoNCk9LLCBnb3Qg
aXQuIFRoaXMgcGF0Y2ggd2lsbCBsYW5kIHdpdGggb3RoZXIgc211IHYxNC4wLjEgcGF0Y2hlcy4g
QW5kIHdlIGFyZSB3YWl0aW5nIGZvciB0aGUgSVAgcmV2aWV3IGZpbmlzaGVkLg0KDQpCZXN0IFJl
Z2FyZHMsDQpMaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXgg
RGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDgs
IDIwMjQgMTA6MzAgUE0NCj4gVG86IE1hLCBMaSA8TGkuTWFAYW1kLmNvbT4NCj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsN
Cj4gWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQu
Y29tPjsgWmhhbmcsDQo+IEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGVuYWJsZSBzbXUgYmxvY2sgZm9yIHNtdSB2MTRf
MF8xDQo+DQo+IE9uIFRodSwgTWFyIDcsIDIwMjQgYXQgMTA6NDPigK9QTSBMaSBNYSA8bGkubWFA
YW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBhZGQgc211IDE0IHN1cHBvcnQgZm9yIHN1bSB2MTRf
MF8xDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBNYSA8bGkubWFAYW1kLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPmkNCj4NCj4gSSB0
aGluayB3ZSBzaG91bGQgaG9sZCBvZmYgb24gdGhpcyB1bnRpbCB0aGUgcmVzdCBvZiB0aGUgc211
IDE0LjAuMSBjb2RlIGxhbmRzLg0KPiBPdGhlcndpc2Ugd2UnbGwgYmUgZW5hYmxpbmcgYW4gaW5j
b21wbGV0ZSBpbXBsZW1lbnRhdGlvbi4NCj4NCj4gQWxleA0KPg0KPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgfCAxICsNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gPiBpbmRleCBhMDdlNGI4
N2Q0Y2EuLjU0YTA0MTRmMjJmMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gPiBAQCAtMTg5Niw2ICsxODk2LDcgQEAgc3Rh
dGljIGludA0KPiBhbWRncHVfZGlzY292ZXJ5X3NldF9zbXVfaXBfYmxvY2tzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfZGV2aWNlX2lwX2Js
b2NrX2FkZChhZGV2LCAmc211X3YxM18wX2lwX2Jsb2NrKTsNCj4gPiAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTQsIDAsIDApOg0KPiA+ICsgICAg
ICAgY2FzZSBJUF9WRVJTSU9OKDE0LCAwLCAxKToNCj4gPiAgICAgICAgICAgICAgICAgYW1kZ3B1
X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJnNtdV92MTRfMF9pcF9ibG9jayk7DQo+ID4gICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgZGVmYXVsdDoNCj4gPiAtLQ0KPiA+IDIu
MjUuMQ0KPiA+DQo=
