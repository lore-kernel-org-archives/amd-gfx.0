Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E0CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 08:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE0210E790;
	Wed, 10 Jun 2026 08:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O8CsDr0H";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B9510E790
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 08:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlOJPSI2GgMF3HTflvmSMLk0yO7BnKBCqAh1H5YBsRSqpJoUCZmIbVSddXN4sDQ+bWCu5oGte9IkXhEjyHGuSDGwP4pMF1fMig4krjKhsC31EFElBgjPsZktIJmkHsGDXjERKI8M5++0GJlHL6O9CQN2s/vexkeqVkpMoEpFkTKY6CIA6fM1a5Pwgm1gEEkqm3ArG01eGP7Hb3Qf9pQBcoq6rCZD8JVzfUDvHPjfgBU0XVPIfJYufrZRT01FXkxiA6SXc2LSHUImRxC8PSoy17SiUQzSDm0g1Ua/Y+wpNks+7MavAnp/5BrP/vq2D0s9YLhFJZ6qI4Jfq5EdTduXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSwYUTh8IKXoDU6xcf69FVjTh/bRA2hgngt+JXE3zCk=;
 b=QHEFGMD4jEOo7a3NsaURxOVu8ujMYPdVdcjOeCur4IMnXXUWdqv5Cc9EUndI/w7wMe0yJusUmX95+lccEhPJ+TcgxAmDCnXZPJy+SPRWExMg3I8smwYzslLgVXvizAG1BEdTdF1LB4hVkuESjBJaZBv0sxVzznhGIrFzZWmrBZxILnrdXveGuxWw/z2yRHNKD5zK+G9b38MOHvd3o2c7Ee/mYWr+P48D+6vzIa40EeedXOLhMU/vujuehpQiAC6gzMg70Ng3vV2IsjHfSXDCg0ZGK7El3WrS16LMFD3XI4Ftyq8OK3Fv4bNWRBREFxoIL2j2hU2eyuQn0LxbBU1oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSwYUTh8IKXoDU6xcf69FVjTh/bRA2hgngt+JXE3zCk=;
 b=O8CsDr0Hqo0WwqzxhL1mj/AI4Vu4baOe+3RJF1J3L5bWMi4XcoHoLGR3BLq5+ENXaeEUT9P2Ipo3hKMyH/KIp4gf2jFgC9MLOyg3Z4Cif1nZ94NJq3aLdrGRctujlYWf3+n9+wWUpWxMVtRo7uhZUBZ/m+axzxREGDr6tz42SX4=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:01:25 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29%5]) with mapi id 15.21.0092.014; Wed, 10 Jun 2026
 08:01:25 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Huang, Trigger" <Trigger.Huang@amd.com>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>, Samuel Pitoiset
 <samuel.pitoiset@gmail.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
Thread-Topic: [PATCH 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Thread-Index: AQHc+J4XCBgeWze5TkWSE/RQ9Grs47Y3alMAgACIk4A=
Date: Wed, 10 Jun 2026 08:01:25 +0000
Message-ID: <BL1PR12MB5849C380B7B9F311646E3C82E71A2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20260610055736.951241-1-Jiqian.Chen@amd.com>
 <ebbf567e-cdb8-44bf-b8ec-1c0096ca740f@amd.com>
In-Reply-To: <ebbf567e-cdb8-44bf-b8ec-1c0096ca740f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.21.0092.005)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MW4PR12MB8611:EE_
x-ms-office365-filtering-correlation-id: f3a7bc54-975b-49ed-fa94-08dec6c67841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|4143699003|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: YxdURoZRBWt4m2q5iDDFAbjPv+zImmfWEzzApHVLveR7iFbye8rxig5NAv/UkXahA+LS3D8DSO2RRgPOr5hga+uGig7qGWbFA3K3NZ7kZFm4l4oBGYvhC8hqtJjO3Z0k9987ckQkE+CAE1vq0zdD9E54kum72VfHuC1ssjNkUCiy8PV9SoZPxYxChW/eWarH6B97dXz+NsVon0Dr41FtV1T8f7xyedugq/hBRm9mADJ2E58KXIfjBRICQlYojl4xvmyALfWKAyumCUD+biYhvcR8/U7uRVplGple2YARlot/klwkSn5/yr0PlBx4gqnZ91t06Pp21pRtUOFGEOTr2YYtkV2HlTUSl7hXi/s8iPHP6SCXOm7EC8LXMAE+9arpPt2uE8xutO+WiRjFzGgUGvZAVrHwT736kn8mgbom+o2Pqcb8yICeBuy+472+pHP9S/cDWO8r7iyzSlQ7TP706f7IaS6XXXC1EbXiGId9eitgDqcTqKh32XXungAavdLPr0whiW+Tf+7mkV0oiSiNUnOM7WLcdiSNtGzyQ5fhBOz6/zFPokYDxXZt/WOSNzi00W+KwYLZV6fgg6YrK9t/a9otoxWCtDqZL3MJAAEjWbNymmtVOH5E+tSG/Ab5/Ge4mBFEmnkaecZ6i7mQrmuKK3gskyLwXJzs9ByfZs1utBylVVK/0miUUIQM7d87f/xHUcLT07LzxMns4y5/t5Y6vL+gYZqZc8cZkQopQsjota2QpAJPd8b9Hqy1alOHDnu3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUI5cXRXTmpXYmwwNXZ4ZDBRVkpWcGlVTU5TN2x4N0ZXdU1KS2pMbnhYYWl3?=
 =?utf-8?B?MXNiV20xbk95REt5ZW1PazZPTmV4N0l5bTdrL2hnQ2QxU1FyNFp1Ly9sRDJk?=
 =?utf-8?B?Ym9pTEFuZU01S1JXamkyc3V6L2JQeXVsRG02TDRtOTJmWDBkNlZUVGMzWlpt?=
 =?utf-8?B?dUIxYnpFY0hMbWw5ZDd5MGdnbDJTcEduTWZRQ3I5d2V0YTh4N1J1b0NsNERh?=
 =?utf-8?B?TVprVnVrYis5dmZjUlY0NkEwYU5wVEZHWWVsMXI5RktFZ0k3OXYxUmJTVFFT?=
 =?utf-8?B?RFNJcEJrSXJFOGdHRG01bGZ6MWJBenpoQW8ya3UvWFhvWlVoV3NKU25tRFp2?=
 =?utf-8?B?b2VDYUg1cFN0clBsbDdEa2RXTjFscUthVXVkQ0JqZDVGVXVuSUVFQ1RZMmdU?=
 =?utf-8?B?TDlibFh5NExUZDJsTXpmays3TWdVL1lCR3cyNUlHRC9Ua2FqMVp6U3NjRU53?=
 =?utf-8?B?eXhNMk5DWDEzc2k0MXV3ckVhU3A3UXhrM1hpb1ZYRnplTWtIckdhNVlXMWRX?=
 =?utf-8?B?cUtZQ0hpSUZoRUptMTQxbGxXNjh3aXBYMUdsUXl5Y1VQdHhYbi80NUx2SXlr?=
 =?utf-8?B?cHFEK0dpbUJOSERMZnJRbjM2MWo2ejFnUDZrTDNEMVprNTJoVzJEbUlaaC9V?=
 =?utf-8?B?dHYyN1ZDZ1hEMVgvNTJsN0tEUjMxd3R0Wlc3Yk9sWGZvdmN6dXlFUFRycUhI?=
 =?utf-8?B?Y2IvSHY3RklLQm4vazRuVUtPTlhtajlybDczWHVHejJjSlNMYmhXTFR3RFFJ?=
 =?utf-8?B?NFIzMzYwYmJqaElQR3l2V0lCRk5sYTRCRU0ySnZPcnMwM0p1T3E5Z1BzdFI3?=
 =?utf-8?B?SW1uaGNmNDNCaGpDMVkrQzFIa0pOTFpodVRTSFJJamNraWJHM2tVZzhvTmFz?=
 =?utf-8?B?Y0JjYzZJV3duUVZTZTdJUmh3cDBrRmcrYXdFNVBhdjF0NEhYY2hqMDdWSmow?=
 =?utf-8?B?TXBMY2preG5PUVFpaHZEeVVTSHBvN3ZpNzZIS29mQVRyVWdCcUpUVTVDeXpt?=
 =?utf-8?B?OWNmQk1JVFpDN0RpYStFZnVWdDdCNGNpOGtCNUNya3p5bjNJUFpsL2x5SUcv?=
 =?utf-8?B?Qno2OEcyMTUxWnZnZlQ1bWp0RzRVeVQvR09qcWtwbXZsdG5BUzZSOHRmSWJE?=
 =?utf-8?B?OGRkazBvaHhTOE56c3I0MTM2aVhCN2hRQmdybGg0WE9HVWdsc25Sb2NGTDgz?=
 =?utf-8?B?VmlSa2I5MkhzaDdOQlNxd1hxOHNTbUx1dFI0OW9GdkRoTnNKK0F3ZTd6N1I2?=
 =?utf-8?B?blhkR2dYeDIvTGNBVHZWSW41U3JWWGdhM0RmbE5URDRCVlJrYTNzRGZYaitZ?=
 =?utf-8?B?K2xUdmV6alFuTXl1OW8xZG5lb3R1QStvZUdjdnVTdStoTkZoZ1Z6QWMyRFNO?=
 =?utf-8?B?aGp0aG9kQU5lYTRpdG01RkdOVjdlcmdSU1ZTM2FIa1FTTm12K1M3TGVDTm1k?=
 =?utf-8?B?MkNicUs1VDRwenhzNlRnOHd0TjczbUVOUzd0S3NYZHdSaU5WTW9MUHR0VDMz?=
 =?utf-8?B?QWtwT1JwWlgwNkdYdVVMbEY4OHhybEpncVU1aDZuUHFGZmVHd1NWbEhNdGUz?=
 =?utf-8?B?czY1eERYVGo3Y1JrbFhQNXFzMEVhZG4yMy92RlFpMGRPU0FOd0JKSTJKQ29T?=
 =?utf-8?B?YTBsbW9rNlIyMzlSNUFjaU5XZmNhVW5BRFAwUmtsb1BoZFVacVVEUGFLWjdI?=
 =?utf-8?B?WVk0bzYxaisyK2dkSElJeXRiSUtESWg0NkNWam12M0RqWHlWZ3VoTzFZQkJm?=
 =?utf-8?B?dWlyRDMwTWYvL0U5cHpvTVFFNkxYeU14amNyemg1NHZHZTFDek80eC96MnUx?=
 =?utf-8?B?YW9rei8ySmE1K3RvaHFsSUxmZHJTME9IdXd2d3RGN3Y2SDlSVE9MREpaSFlk?=
 =?utf-8?B?VHBiSk9veWUxZHpyYzRJTjhjSU9RMDFrQ1U5YW9QclI3T1VGQXBSNjFLQndY?=
 =?utf-8?B?bGlQS0hWSmhnZGUxeVBVS3FSdG9jUnRVQ3N0eUpIRWU5RE94WkNWTXRWdlRi?=
 =?utf-8?B?YzlUK3ZkUHI3OGhucERMSktnMEFpSXZQdUhPd2VrY3VLc0t0VjNTemJVWlln?=
 =?utf-8?B?QzNqcTVSUTNiTkxKUWtLczZUVGJVRGltTU1Oa1BNdHZHUUo2QnpwVHorUGlj?=
 =?utf-8?B?MDhJdG9IaHF0OFNUVmVlV2JqSm55MUpVdWdHU29MTWFzSzJ6Y2ZhcTJ0TnRo?=
 =?utf-8?B?ZTJTVTNabjllVlY3Y0lQcWhYU0F1YzBqMnpmNGhVL1JLenVNek9IV2FxQVZY?=
 =?utf-8?B?M004V1hiR0pmRlNNeDcvcG1FYjdVNC9TQUpWbXgvTXNUVXV6MHlIUy82cEFj?=
 =?utf-8?Q?eWeGquWguM8saX0POq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB1ED9D364A0BB4DA824A130525B5821@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a7bc54-975b-49ed-fa94-08dec6c67841
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 08:01:25.6447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wrl7o/eTimkViMZ2YVS3hYiBZb1RGksNKv8ebYSCJ14NjMuRuUG4WlHka3zS/KJ0xd+08p0hCNoFvHXILEpxXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611
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

T24gNi8xMC8yNiAxNTo1MCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gT24gNi8xMC8yNiAw
Nzo1NywgSmlxaWFuIENoZW4gd3JvdGU6DQo+PiBGb3IgUmVuaW9yIEFQVSB3aXRoIGdmeDksIGlu
IHNvbWUgdGVzdCBzY2VuYXJpb3Mgd2l0aCBkaXNhYmxpbmcNCj4+IHJpbmdfcmVzZXQsIGxpa2Ug
YWNjZXNzaW5nIGFuIHVubWFwcGVkIGludmFsaWQgYWRkcmVzcywgaXQgY2FuDQo+PiB0cmlnZ2Vy
IGEgZ3B1IGpvYiB0aW1lb3V0IGV2ZW50LCB0aGVuIGRyaXZlciB1c2VzIE1vZGUyIHJlc2V0DQo+
PiB0byByZXNldCBHUFUsIGJ1dCBhZnRlciBNb2RlMiwgdGhlIENQQyBhbmQgQ1BGIGFyZSBzdGls
bCBzdHVjaywNCj4+IHRoYXQgY2F1c2VzIGNvbXB1dGUgUmluZyB0ZXN0cyBmYWlsLiBXaGF0J3Mg
bW9yZSwgdGhlIEhRRHMgb2YNCj4+IE1FQ3MgYXJlIHN0aWxsIGFjdGl2ZSwgdGhhdCBjYXVzZXMg
TUVDcyB1c2Ugc3RhbGUgSFFEcyB3aGVuIE1FQ3MNCj4+IGFyZSB1bmhhbHRlZCBiZWZvcmUgZHJp
dmVyIHJlc3RvcmUgTVFEcywgdGhlbiBjYXVzZXMgY29tcHV0ZSBJQg0KPj4gdGVzdHMgZmFpbC4N
Cj4+DQo+PiBTbywgYWRkIHNlcXVlbmNlcyB0byByZXNldCBDUEMgYW5kIENQRiBhZnRlciBNb2Rl
MiwgYW5kIGRlLWFjdGl2ZQ0KPj4gSFFEcyBvZiBNRUNzIGJlZm9yZSB1bmhhbHRpbmcgTUVDcyBh
bmQgbWFwcGluZyBjb21wdXRlIHF1ZXVlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4g
Q2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+IC0tLQ0KPj4gSGkgYWxsLA0KPj4NCj4+IE15
IGJvYXJkIGlzIFJlbmlvciBBUFUgd2l0aCBnZng5LCBzbXUxMi4gSSBydW4gYSB0ZXN0Y2FzZSB0
aGF0DQo+PiBhY2Nlc3NlcyBhbiBpbnZhbGlkIGFkZHJlc3MgdG8gdHJpZ2dlciBhIGFtZGdwdV9q
b2JfdGltZWRvdXQoKQ0KPj4gd2l0aCBkaXNhYmxpbmcgcmluZ19yZXNldCwgc28gdGhhdCBkcml2
ZXIgd2lsbCBjYWxsIG1vZGUyIHJlc2V0DQo+PiBkaXJlY3RseS4gQWZ0ZXIgbW9kZTIgcmVzZXQg
SSBmb3VuZCBjb21wdXRlIFJpbmcgdGVzdHMgYW5kIGNvbXB1dGUNCj4+IElCIHRlc3RzIGZhaWwg
cmFuZG9tbHkgb24gcmFuZG9tIGNvbXB1dGUgcmluZy4NCj4gDQo+IE9oISBJdCdzIHJlYWxseSBu
aWNlIHRvIHNlZSB0aGF0Lg0KPiANCj4gV2UgaGFkIHF1aXRlIGEgbnVtYmVyIG9mIGJ1ZyByZXBv
cnRzIG9uIHRoaXMgaXNzdWUsIGJ1dCB3ZXJlIG5ldmVyIGFibGUgdG8gcmVwcm9kdWNlIGl0IHJl
bGlhYmxlLg0KSSB1c2Ugb25lIHRlc3RjYXNlIG9mIGFtZGdwdV90ZXN0IHdpdGggb3VyIHNwZWNp
ZmljIGNoYW5nZXMgdG8gcmVwcm9kdWNlIHRoaXMgaXNzdWUuDQpJZiBhbnlvbmUgbmVlZCB0aGUg
YmluYXJ5LCBJIGNhbiBzaGFyZSBpdC4NCg0KPiANCj4gSUlSQyBzb21lIFZhbHZlIGVuZ2luZWVy
cyByYW4gaW50byB0aGF0IGFzIHdlbGwsIGFkZGluZyBhIGZldyBwZW9wbGUgb24gQ0MuDQo+IA0K
PiBJIGNhbid0IGp1ZGdlIGlmIHRoZSBwcm9wb3NlZCBmaXggaXMgdGVjaG5pY2FsbHkgY29ycmVj
dCwgYnV0IGl0J3MgZ29vZCB0byBzZWUgdGhhdCB0aGVyZSBpcyBzb21lIHByb2dyZXNzIG9uIHRo
aXMgaXNzdWUuDQpUaGFuayB5b3UhDQoNCj4gDQo+IFRoYW5rcywNCj4gQ2hyaXN0aWFuLg0KPiAN
Cj4+IFdlIGNoZWNrZWQgdGhlIHNjYW4gZHVtcCBvZiBHUFUsIHdlIGNhbiBzZWUgdGhlIENQQyBh
bmQgQ1BGIGFyZQ0KPj4gc3RpbGwgc3R1Y2ssIHRoYXQgbWF5IGNhdXNlIENvbXB1dGUgUmluZyB0
ZXN0cyBmYWlsLg0KPj4gSSBhZGRlZCBwcmludGluZ3MgaW4gZHJpdmVyIGNvZGVzIChnZnhfdjlf
MF9jcF9yZXN1bWUpLCBhbmQgZm91bmQNCj4+IHRoZSBIUURzIG9mIE1FQ3MgYXJlIHN0aWxsIGFj
dGl2ZSwgdGhhdCBtYXkgY2F1c2UgTUVDcyB1c2Ugc3RhbGUNCj4+IEhRRHMgd2hlbiBNRUNzIGFy
ZSB1bmhhbHRlZCBiZWZvcmUgbWFwcGluZyBjb21wdXRlIHF1ZXVlcyAocmVzdG9yZQ0KPj4gTVFE
cyB0byBIUURzKS4NCj4+IFNvLCBJIHNlbmQgdGhpcyBwYXRjaCB0byBmaXggYWJvdmUgcHJvYmxl
bXMuDQo+PiBUaGVyZSBhcmUgdHdvIG1haW4gY2hhbmdlcyBvZiBteSBwYXRjaGVzOg0KPj4gT25l
IGlzIHRvIHJlc2V0IENQQyBhbmQgQ1BGIGJlZm9yZSByZXN1bWluZyBLQ1EuDQo+PiBBbm90aGVy
IGlzIHRvIGRpc2FibGUgSFFEcyBiZW9mcmUgdW5oYWx0aW5nIE1FQ3MuDQo+PiAtLS0NCj4+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgNDAgKysrKysrKysrKysrKysr
KysrKysrKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4+IGlu
ZGV4IDQ3NzIxZDBjMzc4MS4uZGMwOTc4YmMzMTJjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4gQEAgLTM5NDQsNyArMzk0NCw4IEBAIHN0YXRpYyBpbnQg
Z2Z4X3Y5XzBfa2NxX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICANCj4+
ICBzdGF0aWMgaW50IGdmeF92OV8wX2NwX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikNCj4+ICB7DQo+PiAtCWludCByLCBpOw0KPj4gKwl1MzIgdG1wOw0KPj4gKwlpbnQgciwgaSwg
aiwgazsNCj4+ICAJc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nOw0KPj4gIA0KPj4gIAlpZiAoIShh
ZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpKQ0KPj4gQEAgLTM5NjcsNiArMzk2OCw0MyBAQCBzdGF0
aWMgaW50IGdmeF92OV8wX2NwX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+
ICAJCWdmeF92OV8wX2NwX2dmeF9lbmFibGUoYWRldiwgZmFsc2UpOw0KPj4gIAlnZnhfdjlfMF9j
cF9jb21wdXRlX2VuYWJsZShhZGV2LCBmYWxzZSk7DQo+PiAgDQo+PiArCWlmICgoYWRldi0+Zmxh
Z3MgJiBBTURfSVNfQVBVKSAmJg0KPj4gKwkJKGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVfSVNf
UkVOT0lSKSAmJiBhbWRncHVfaW5fcmVzZXQoYWRldikpIHsNCj4+ICsJCS8qDQo+PiArCQkgKiBD
UEMgYW5kIENQRiBhcmUgc3RpbGwgc3R1Y2sgYWZ0ZXIgTW9kZTIgcmVzZXQsIHRoYXQgY2F1c2Vz
IGxhdGVyDQo+PiArCQkgKiBjb21wdXRlIHJpbmcgdGVzdCBmYWlsIGFuZCB0aGVuIGxvb3AgTW9k
ZTIgcmVzZXQgaW5maW5pdGVseQ0KPj4gKwkJICovDQo+PiArCQl0bXAgPSBSUkVHMzJfU09DMTUo
R0MsIDAsIG1tR1JCTV9TT0ZUX1JFU0VUKTsNCj4+ICsJCXRtcCA9IFJFR19TRVRfRklFTEQodG1w
LCBHUkJNX1NPRlRfUkVTRVQsIFNPRlRfUkVTRVRfQ1BDLCAxKTsNCj4+ICsJCXRtcCA9IFJFR19T
RVRfRklFTEQodG1wLCBHUkJNX1NPRlRfUkVTRVQsIFNPRlRfUkVTRVRfQ1BGLCAxKTsNCj4+ICsJ
CVdSRUczMl9TT0MxNShHQywgMCwgbW1HUkJNX1NPRlRfUkVTRVQsIHRtcCk7DQo+PiArCQl0bXAg
PSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tR1JCTV9TT0ZUX1JFU0VUKTsNCj4+ICsJCXVkZWxheSg1
MCk7DQo+PiArDQo+PiArCQl0bXAgJj0gfihHUkJNX1NPRlRfUkVTRVRfX1NPRlRfUkVTRVRfQ1BD
X01BU0sgfA0KPj4gKwkJCQlHUkJNX1NPRlRfUkVTRVRfX1NPRlRfUkVTRVRfQ1BGX01BU0spOw0K
Pj4gKwkJV1JFRzMyX1NPQzE1KEdDLCAwLCBtbUdSQk1fU09GVF9SRVNFVCwgdG1wKTsNCj4+ICsJ
CXRtcCA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1HUkJNX1NPRlRfUkVTRVQpOw0KPj4gKwkJdWRl
bGF5KDUwKTsNCj4+ICsNCj4+ICsJCS8qDQo+PiArCQkgKiBDUF9IUURfQUNUSVZFIHN1cnZpdmVz
IE1vZGUyIHJlc2V0LiBEZWFjdGl2YXRlIGV2ZXJ5IE1FQyBIUUQgdG8NCj4+ICsJCSAqIHByZXZl
bnQgTUVDIHVzZSBzdGFsZSBIUUQgd2hlbiBNRUMgdW5oYWx0ZWQgYmVmb3JlIHJlc3RvcmluZyBN
UUQuDQo+PiArCQkgKiBPdGhlcndpc2UsIGxhdGVyIGNvbXB1dGUgSUIgdGVzdCBtYXkgZmFpbA0K
Pj4gKwkJICovDQo+PiArCQlmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm1lYy5udW1fbWVjOyBp
KyspIHsNCj4+ICsJCQlmb3IgKGogPSAwOyBqIDwgYWRldi0+Z2Z4Lm1lYy5udW1fcGlwZV9wZXJf
bWVjOyBqKyspIHsNCj4+ICsJCQkJZm9yIChrID0gMDsgayA8IGFkZXYtPmdmeC5tZWMubnVtX3F1
ZXVlX3Blcl9waXBlOyBrKyspIHsNCj4+ICsJCQkJCW11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0
ZXgpOw0KPj4gKwkJCQkJc29jMTVfZ3JibV9zZWxlY3QoYWRldiwgaSArIDEsIGosIGssIDAsIDAp
Ow0KPj4gKwkJCQkJV1JFRzMyX1NPQzE1X1JMQyhHQywgMCwgbW1DUF9IUURfQUNUSVZFLCAwKTsN
Cj4+ICsJCQkJCXNvYzE1X2dyYm1fc2VsZWN0KGFkZXYsIDAsIDAsIDAsIDAsIDApOw0KPj4gKwkJ
CQkJbXV0ZXhfdW5sb2NrKCZhZGV2LT5zcmJtX211dGV4KTsNCj4+ICsJCQkJfQ0KPj4gKwkJCX0N
Cj4+ICsJCX0NCj4+ICsJfQ0KPj4gKw0KPj4gIAlyID0gZ2Z4X3Y5XzBfa2lxX3Jlc3VtZShhZGV2
KTsNCj4+ICAJaWYgKHIpDQo+PiAgCQlyZXR1cm4gcjsNCj4gDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KSmlxaWFuIENoZW4uDQoNCg==
