Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9E6CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 13:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301F110E8C8;
	Mon, 28 Sep 2026 13:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H0zPFau0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F343510EA36
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 13:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArpFgNjw0rtfamRJC/1kp0s2GoheqO/Xb97TBRjrlJqN/IuGJ5bel+YNlGosasnH4zccWbkp98k8V0H0FxEYX/DJw7MmCN7BSheQiB+wq8VPBUSgJhtD5fcfQCk7vTNzDvYGetdJXe+6ZU0Bd1WfBdgd+HZIQEPHthFWO687sNaQM5GNUZL2gDnpP6CKQP0XZmjdETxxMH2oWwh6i9oxgBcPO0nCZbTq5l4oSTa1fF5rAN+HAT4jLlWO3/JvHG3pzur3GLOtl93e295EtB767I7rfWYgPcDC7Hqz0EkNQj9e9xdzHh0xtAix4chrPWLdSSsEMMWYuIS70s6rKaFWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82n+toMvVROLtxucTG+yamrxOngqQYkEbhGuRdGM61Q=;
 b=cnuk26EjYNIfZq9WVtBWk6sBIK1qPJytg44u45pllZcs2M9CMZaYeC1bbmwt6ziZEYMtd2zrH0GKP/2gJ068MLoiYStFbzyQtJ3NFbU0jeACc76cheTLdghHIK2rUyfMyDcSIHLGRgLjZHTj8CSeWB3dKin7rcnSOC5ews1PrR838NJfO+iV8lDqayCz0KSKCBvPsMiHu82O/8LcZ48PPypmcWOazWFjq/Cfs9yDwuMXSeCD20CtGX8IX6XtoAh7iQDBB/6g3jGloh+VzHy5rCpsU6HtdeErEpvaxLAzOHcWPHchUkM4Zw6kv7oFP13gU89piaS3A4geU4hA6T0QVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82n+toMvVROLtxucTG+yamrxOngqQYkEbhGuRdGM61Q=;
 b=H0zPFau08RpCzE0QQYECH5Gf7GxNboYlXBWRpz7sV/lRWuvBvviYYoTPOsiGfIkP7EWd5iweo6uMJfxrbRHQd14e4tOU/+K9ojhW13MzE1x5Hmnyxp1C4ehZj/X3DnddO5bB0403dpK2LajlToKFo26MM7JOkFRBWZ6RgkYAnAM=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 13:18:25 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 13:18:25 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reserve fence slot before userq eviction rearm
Thread-Topic: [PATCH] drm/amdgpu: reserve fence slot before userq eviction
 rearm
Thread-Index: AQHdS7XXCDbHx3ykvUmZo9Yz6CIvgrbj/m7Q
Date: Mon, 28 Sep 2026 13:18:25 +0000
Message-ID: <PH7PR12MB60002DE41AF8BEAB3AC46299FB8D2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260923234646.101279-1-vitaly.prosyak@amd.com>
In-Reply-To: <20260923234646.101279-1-vitaly.prosyak@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-28T13:11:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|CY8PR12MB7121:EE_
x-ms-office365-filtering-correlation-id: 191fa3be-e5b8-4ef8-650f-08df1d62fa82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: gJ1Ws2O/eNXYD0OaePRYDCU7K8z/x74X1IqpvJshyXNsfe2pcoI/Kud1muphhUOpFBlJDH1XDmgL+mIrTKPT9oarFAda1h1Lmz2NF5bcyIx+nerjk9YmK6ukzPztuN9fkbbNj8jCwc2frSh4tb8DYxrZ2O9PxGrXkZg32rqf5ekuv8Iz/Xmf/Oitkp9V7kN4Qr5+/4pNEUr9KLgtalmN+jZnfQ14bDpJwwVvn+UrCL4lsNrotXDK0YZ5Tt8Xi0IkhCPq5yWMpCikxD1fyWyjS9oL+ejk2Y4aT+e57+Vc8fkoRCRfBrclG2hjcJUhzPpaJoqh5zQZWKa9C+2jieyZxFgSnwaKUP5s2q0JpoiQyNyZ0HRgXIaBI5/0ACvrRUKalmB6RhIeB34ZQEAxE0ikD8625000icdjJynaPFI1/jDXbXEmZxqC0tRchKsYqSCKHFYV1+8BhVVR6l7XVlfuBT6rsqQRIDaurI0ywyl+2+oTfwfPG4doSFInViZSk5pige/6KfQ7J0mQknr7MgjOLKm4KDA6PrwFPhMRPdw6rldgA7aq3N3FKYAygyKlRpZ4TgEwR0TQOrTK053pGKTKas6NhfY+qjGGleBV3K3T5lHcUFRqDGRSH359DbKEp0w0s0GH/hy0XGZY9isEFi19jhWsuQ2CPyqA3zBL30HqPGYAKj1NzH22JipXh+VrnmJU/CtTVZs0xL/lcPq1rJE6OuaPobPY3fPjh2p5DLQQZ9U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3dtK0NCUzV6d2ZBMWV6cGF2cDM5Zm5lSXJlcWdzRXhBbjJjMWlpbFRsbjky?=
 =?utf-8?B?NFJWbTNvdnZyUm1QSXpWOFRkWWV1dzVLUzZJVlg0ck4rRit3Nk9aL3U4SzQr?=
 =?utf-8?B?T3F0Y05FR0lNVGVUd01DL21qMFd1UmhGSTErZGNWS21vZXo1cDNJVFRLWDg4?=
 =?utf-8?B?ZldLNnJaRG5ibE5FZ043Ky9taStKSDBZVFdVTVJFcVZyY202ZWZLejVVL3NC?=
 =?utf-8?B?UUVBSU5uQUNKaUZXVFV4aTlvVUdacU1WSTFzcFprcjdNdjVEWTQrcGJuVjd2?=
 =?utf-8?B?Qm5HRnRweWdYN0pTTTdJem1KM3NpTkwwR1gxd1hna1NIWW9CODZwRndRbUo5?=
 =?utf-8?B?dHNwQi84L2FOdzYrZUg1NWxkQ1d5YXU0cHNUL1hJTHhoWU5XYk5QYXZ6ZXVx?=
 =?utf-8?B?RTN1NFpTY3ZheWhvZmNJRlprNWY4ZFBScTRSUGdCOWwvbTFVWVl3VEkzSWpo?=
 =?utf-8?B?Q1Q0YncrZUNIeTNiRmRvVEFFS040dlpiT2xMS1lpTksvWHlDWlpNeXg3cnNn?=
 =?utf-8?B?QXpWZnlHTFJKQVRMK1hKT2VzZ3VXRjlFYUl3YjAxTGl0SFBOSy84L0FsL3RQ?=
 =?utf-8?B?WUdoNFNlbUJxODA2NzFtNnVNdnpyMUMzTkt0U05jMXRDMjhzL1RjUEVub3hx?=
 =?utf-8?B?b3RkY1JodWVqcnVELzlWUUhuRHpLUjFZcE9GZm9ETXZVaHJOaCtMZDJHaENh?=
 =?utf-8?B?TDVDdHpSTzRvczlUYnphWUtyRCtzdkFNc3QvWEpjRmxDMmNYS1FhWWFWRkk0?=
 =?utf-8?B?NCtGaW54TFQ4UURUeTFHSWorSmJWWkVOVk5ENG9WLzVJSytoaHJuL0hFUXhU?=
 =?utf-8?B?MlMzVHVDLzNoRHRKVks3bXA2L0g5MndLMStSM21sS1NSQVRMdTFId29FdGRp?=
 =?utf-8?B?Rk5WQmE5VkJUMTR3eWpmSnFVVkpFM0ZTcTlFM0VUcHJmR3RDZlB2MnYxSXFC?=
 =?utf-8?B?NU8vY0hHZHBzbEFXbzN5SmJTMVpYZC91ZnQyV2dGc3QvbnFnYlJIWXRnRXRn?=
 =?utf-8?B?aVRBejRwcUpuUVIyYit4dk8xVlF2c2g1bzVSY291amVCYlA3NXFNTy92UHh0?=
 =?utf-8?B?QkRGSUxHOFp0L1h1V3pyRUtGeXc1aWIzdmQ3Q1pWWXU4Tm5iNjRBZHo2cXpR?=
 =?utf-8?B?d3AyT1RpbitGVlFxdFF0emplZUdyZ2cwQTJVcDJuR2MzcGN4ekpJWmNwQjhB?=
 =?utf-8?B?aTF1UThhZEFxUDBNemtGbGFLZHNvTDdpYjJyb3JFczdhLzd0eCtmL0xQVDVn?=
 =?utf-8?B?Y0VvOWVncmN5RUZDS3dXQWJZU1JGaktHbEhLT21EY255L0dZMmt5eENGeVN3?=
 =?utf-8?B?M29XRHIxOUoxV1J0dnord2l1WG9wRlNQK3NIV3pGSitBVTJsYTFvRFhFanlt?=
 =?utf-8?B?dFRWQWtiRmc3a0RrTFR4OTdVNHk0LzRQSDd5cWNoVTlhUmZBb1FnTmVXN1JU?=
 =?utf-8?B?R3BBeTdERC9XZzhQT1VReFdHbldLUXorK3g2TFpyaG1TQ2VXTHViT2YvSnFn?=
 =?utf-8?B?L3lSUm1KQmRUZTRwWXkyZ2lLMzlWaDY5OHgrckp6UUY5VDk3VjdYanZwa29G?=
 =?utf-8?B?a3c5WFRZVDkxOStrUlcyNU50bTNCOXZKZGpicWNFMURoeGZjZEtUM1FWb1Na?=
 =?utf-8?B?aGllak5ySEVTUjlzN0lJa2lsaEFCelZ6c1VlVjZHYlhETTBpYXVsSUR4czdK?=
 =?utf-8?B?ODUyNk9xb1lCOWc2SVJTZFJFLzdzVlFpK1hFVHpuMWdqN0N1YTR1Vi94QkpN?=
 =?utf-8?B?eXVnNk8zWHk1ZWxpc1FlNkJqUWIzZHMrNTUxWkcydS9CNjBFeVFqdkIyRDll?=
 =?utf-8?B?SGNLNTNsNFhhaWJMWnRIdXNPQ2JuKzFwdVBOenZvWU1jTXp3QmN5SHpkR3BD?=
 =?utf-8?B?c2JQZTh4ZGNkRmF5STBjLzV6eklCd2pnWXg3SWRUNzg5Sko3bVFxWVE4VnZ0?=
 =?utf-8?B?VkMyQkt5bzg2eUxGbncxN0JmTUsxdis0enBzZzR0WllLVm9RNmVqL0ZXa3l1?=
 =?utf-8?B?N2hkT3c0NUZQdWt0c1RQeEt1dlBvR0hqbFFpWG94cXdtMXJwamU5VnV3WXFG?=
 =?utf-8?B?TTljWElkeXc3ajJXRElvMXNYbUFOcXl4cEVKTWw4MWswbkttYnZlc1gwMzll?=
 =?utf-8?B?VkVKSVZJNk9jM2gvM0E1Q0dYZzJLd0lld0dBNTZReUVRcVJsQXp3S1ZnaXBz?=
 =?utf-8?B?bXY3UWFiSDBYMGNmZEZsZnFKckxGRXoyUWxNTjBLbm1XM01tbndDYkg2S2dv?=
 =?utf-8?B?OEJCYUZ0MHp2L1JIamM2Wk44RG9oNU9kOWNaK01qYTlNWU4xR3pFeHZac0gr?=
 =?utf-8?Q?ExhChgNmx2F/MevUOo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191fa3be-e5b8-4ef8-650f-08df1d62fa82
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 13:18:25.6307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbdHSPYW7Sm3kWNM8xROUwzOzVnw9QSVZUU/dzOrIBsKWtSeiW2i5JaqfXMtqKat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogdml0YWx5LnByb3N5YWtAYW1kLmNvbSA8dml0YWx5LnByb3N5
YWtAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNCwgMjAyNiA3OjQ3IEFN
DQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogUHJvc3lhaywgVml0
YWx5IDxWaXRhbHkuUHJvc3lha0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXNlcnZlIGZlbmNlIHNsb3QgYmVmb3JlIHVzZXJx
IGV2aWN0aW9uIHJlYXJtDQo+DQo+IEZyb206IFZpdGFseSBQcm9zeWFrIDx2aXRhbHkucHJvc3lh
a0BhbWQuY29tPg0KPg0KPiBEdXJpbmcgYW1kX2RlYWRsb2NrIHVzZXJxIHJlc2V0IHRlc3Rpbmcs
IHRoZSByZXN0b3JlIHdvcmtlciByZWFjaGVkDQo+IGFtZGdwdV9ldmZfbWdyX3JlYXJtKCkgd2l0
aCBhIGxvY2tlZCByZXNlcnZhdGlvbiBvYmplY3Qgd2hvc2UgZmVuY2UgbGlzdCBoYWQNCj4gYmVl
biByZWJ1aWx0IGFmdGVyIHZhbGlkYXRpb24uIFdoZW4gYWxsIHByZXZpb3VzIGZlbmNlcyBoYWQg
Y29tcGxldGVkLCB0aGUgcmVidWlsdCBsaXN0DQo+IGNvbnRhaW5lZCBubyBhY3RpdmUgZmVuY2Vz
IGFuZCBkbWFfcmVzdl9yZXNldF9tYXhfZmVuY2VzKCkgbGVmdCBudW1fZmVuY2VzIGFuZA0KPiBt
YXhfZmVuY2VzIGF0IHplcm8uIGRtYV9yZXN2X2FkZF9mZW5jZSgpIHRoZW4gdHJpZ2dlcmVkOg0K
Pg0KPiAgIEJVR19PTihmb2JqLT5udW1fZmVuY2VzID49IGZvYmotPm1heF9mZW5jZXMpDQo+DQo+
IHdoaWxlIGFkZGluZyB0aGUgcmVwbGFjZW1lbnQgQk9PS0tFRVAgZXZpY3Rpb24gZmVuY2UuDQo+
DQo+IFRoZSB2MSBwcm9wb3NhbCBhdHRlbXB0ZWQgdG8gY2FsbCBkbWFfcmVzdl9yZXNlcnZlX2Zl
bmNlcygpIGZyb20gaW5zaWRlDQo+IGFtZGdwdV9ldmZfbWdyX3JlYXJtKCksIGltbWVkaWF0ZWx5
IGJlZm9yZSBkbWFfcmVzdl9hZGRfZmVuY2UoKS4gVGhpcyBpcyBub3QNCj4gdmFsaWQuIGRtYV9y
ZXN2X3Jlc2VydmVfZmVuY2VzKCkgbWF5IGFsbG9jYXRlIG1lbW9yeSBhbmQgcmVwbGFjZSB0aGUg
cmVzZXJ2YXRpb24tDQo+IGZlbmNlIGxpc3QuIElmIHRoZSByZXBsYWNlbWVudCBldmljdGlvbiBm
ZW5jZSBoYXMgYWxyZWFkeSBiZWVuIGNyZWF0ZWQgYnkgcmVhcm0sIHRoYXQNCj4gYWxsb2NhdGlv
biBjYW4gaW52YWxpZGF0ZSB0aGUgbmV3bHkgY3JlYXRlZCBmZW5jZSBzdGF0ZSBhZ2Fpbi4gVGhp
cyBpcyB0aGUgb3JkZXJpbmcNCj4gcHJvYmxlbSBpZGVudGlmaWVkIGJ5IENocmlzdGlhbiBkdXJp
bmcgcmV2aWV3Lg0KPg0KPiB2MiByZXNlcnZlcyB0aGUgc2xvdCBpbiB0aGUgcmVzdG9yZSBjYWxs
ZXIsIGJlZm9yZSByZWFybSBjcmVhdGVzIHRoZSByZXBsYWNlbWVudA0KPiBmZW5jZS4gQWZ0ZXIg
dmFsaWRhdGlvbiBhbmQgR0FSVCB3b3JrIGhhdmUgY29tcGxldGVkLCB0aGUgY2FsbGVyIHN0aWxs
IG93bnMgZXZlcnkNCj4gcmVzZXJ2YXRpb24gdGhyb3VnaCB0aGUgRFJNIGV4ZWN1dGlvbiBjb250
ZXh0LiBJdCByZWZyZXNoZXMgb25lIHNsb3QgZm9yIGV2ZXJ5IGxvY2tlZA0KPiBvYmplY3QsIGFs
bG93aW5nIGFsbCBwb3NzaWJsZSByZXNlcnZhdGlvbi1saXN0IGFsbG9jYXRpb25zIHRvIGZpbmlz
aCBiZWZvcmUNCj4gYW1kZ3B1X2V2Zl9tZ3JfcmVhcm0oKSBjcmVhdGVzIGFuZCBhdHRhY2hlcyB0
aGUgbmV3IEJPT0tLRUVQIGZlbmNlLg0KPg0KPiBUaGUgcmVzZXJ2YXRpb24gcmVtYWlucyBjYWxs
ZXItc2lkZS4gVGhlIGV2aWN0aW9uLWZlbmNlIGhlbHBlciBkb2VzIG5vdCByZXNlcnZlDQo+IG1l
bW9yeSBhbmQgb25seSBjb25zdW1lcyBjYXBhY2l0eSBwcmVwYXJlZCBieSBpdHMgY2FsbGVyLiBU
aGUgaW5pdGlhbCBjYWxsZXItc2lkZQ0KPiBwcmVwYXJhdGlvbiBpcyBzdGlsbCByZXF1aXJlZCBm
b3IgV1BUUiBCT3MgYW5kIFZNIEJPcywgYmVjYXVzZSBpdCBjb3ZlcnMgdmFsaWRhdGlvbg0KPiBh
bmQgbWlncmF0aW9uIGZlbmNlczsgdGhlIGZpbmFsIHJlZnJlc2ggaXMgcmVxdWlyZWQgYmVjYXVz
ZSBsYXRlciB2YWxpZGF0aW9uIGNhbg0KPiByZWJ1aWxkIGEgcmVzZXJ2YXRpb24gbGlzdCBhbmQg
ZGlzY2FyZCB1bnVzZWQgY2FwYWNpdHkuDQo+DQo+IFRoaXMgdjIgc3VwZXJzZWRlcyB0aGUgdjEg
aGVscGVyLXNpZGUgYXBwcm9hY2ggYW5kIHRoZSBpbnRlcm1lZGlhdGUgY2FsbGVyLXNpZGUNCj4g
YWxsb2NhdGlvbiBjb21taXRzIHRoYXQgZGlkIG5vdCByZWZyZXNoIGNhcGFjaXR5IGFmdGVyIHZh
bGlkYXRpb24uDQo+DQo+IEZpeGVzOiA5MWEzNThmZTk5ZDg2IChkcm0vYW1kZ3B1OiBkb250IHBp
biB3cHRyIGJvIGluc3RlYWQgdXNlIGV2aWN0aW9uIGZlbmNlKQ0KPg0KPiBSZXBvcnRlZC1ieTog
SUdUIGFtZF9kZWFkbG9jayB0ZXN0DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+DQo+IENjOiBQcmlrZSBMaWFuZyA8cHJpa2UubGlhbmdAYW1kLmNvbT4NCj4gQXNzaXN0
ZWQtYnk6IENsYXVkZTpjbGF1ZGUtc29ubmV0LTUNCj4gU2lnbmVkLW9mZi1ieTogVml0YWx5IFBy
b3N5YWsgPHZpdGFseS5wcm9zeWFrQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycS5jDQo+IGluZGV4IDc1ZDVjZWFhNTNjNi4uYTFiNmNlOGIzNDhlIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiBAQCAtMTAzNCw2
ICsxMDM0LDcgQEAgYW1kZ3B1X3VzZXJxX3ZtX3ZhbGlkYXRlX2FuZF9yZXN0b3JlX3F1ZXVlKHN0
cnVjdA0KPiBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IpDQo+ICAgICAgIHN0cnVjdCBhbWRncHVf
Ym9fdmEgKmJvX3ZhOw0KPiAgICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1
ZTsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9ibyAqYm87DQo+ICsgICAgIHN0cnVjdCBkcm1fZ2Vt
X29iamVjdCAqb2JqOw0KPiAgICAgICBzdHJ1Y3QgZHJtX2V4ZWMgZXhlYzsNCj4gICAgICAgc3Ry
dWN0IHhhcnJheSB4YTsNCj4gICAgICAgaW50IHJldDsNCj4gQEAgLTEyMTAsNiArMTIxMSwxMyBA
QCBhbWRncHVfdXNlcnFfdm1fdmFsaWRhdGVfYW5kX3Jlc3RvcmVfcXVldWUoc3RydWN0DQo+IGFt
ZGdwdV91c2VycV9tZ3IgKnVxX21ncikNCj4gICAgICAgICAgICAgICBxdWV1ZS0+d3B0cl9vYmou
Z3B1X2FkZHIgPSBhbWRncHVfYm9fZ3B1X29mZnNldChibyk7DQo+ICAgICAgIH0NCg0KDQoNClJl
Z2FyZGluZyB0aGUgZXZpY3Rpb24gZmVuY2Ugc2xvdCByZXNlcnZhdGlvbjogdGhpcyBsb29rcyBn
b29kIGhlcmUsIGJ1dCB3ZSBhbHNvIG5lZWQgdG8gcmV2YWxpZGF0ZSB0aGUgcHJlbG9ja2VkIEJP
cyBpZiB0aGV5IGJhY2tlZCBvZmYgZHVyaW5nIHRoZSBwcmVsb2NrIHNlcXVlbmNlLiBJIGhhdmUg
YSBwYXRjaCByZWFkeSB0aGF0IHByZXBhcmVzIHRoZSBCT3MgYmVmb3JlIHJlYXJtaW5nIHRoZSBl
dmljdGlvbiBmZW5jZS4NCg0KVGhhbmtzLA0KICAgIFByaWtlDQoNCj4gKyAgICAgLyogUmUtcmVz
ZXJ2ZSB0aGUgcmVhcm0gc2xvdCBhZnRlciB2YWxpZGF0aW9uIG1heSBoYXZlIHJlYnVpbHQgdGhl
IGxpc3RzLiAqLw0KPiArICAgICBkcm1fZXhlY19mb3JfZWFjaF9sb2NrZWRfb2JqZWN0KCZleGVj
LCB0bXBfa2V5LCBvYmopIHsNCj4gKyAgICAgICAgICAgICByZXQgPSBkbWFfcmVzdl9yZXNlcnZl
X2ZlbmNlcyhvYmotPnJlc3YsIDEpOw0KPiArICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsgICAg
ICAgICAgICAgICAgICAgICBnb3RvIHVubG9ja19hbGw7DQo+ICsgICAgIH0NCj4gKw0KPiAgICAg
ICByZXQgPSBhbWRncHVfZXZmX21ncl9yZWFybSgmZnByaXYtPmV2Zl9tZ3IsICZleGVjKTsNCj4g
ICAgICAgaWYgKHJldCkgew0KPiAgICAgICAgICAgICAgIGRybV9maWxlX2Vycih1cV9tZ3ItPmZp
bGUsICJGYWlsZWQgdG8gcmVwbGFjZSBldmljdGlvbiBmZW5jZVxuIik7DQo+IC0tDQo+IDIuNDMu
MA0KDQo=
