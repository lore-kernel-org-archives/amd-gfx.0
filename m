Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216B2EA71B5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 02:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D18E10E0BC;
	Mon, 20 Apr 2026 02:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5rFE/cUA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8107510E0BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 02:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cg+HXcBhP9pSE7PN6L3LLkSsWVqUXbdPGezSRO/xbKas2mJPWiXMiiCqv4wzYGxDe7XJLYb7Bd7LPXD8QGN2CuAp4t5z5BWyZcascVjF2fXjTe7EG6sPXiC8jzEdc1wXNCUaj2NLJer/hlkdJklYSlLi0nmUXvYPaNZYhwxL1FXOQc7nLFJzvO8F4ixnZrMvpZ6rQA/wJ8hE7riqboKJeP5VGivXLM5BLUfVeYuJr/8GSopDxJEOVjs/80Apy2pzO5vqCcjl/3F5m8irTjUKNAQTvLwCJYF6HCPWo7658/ySSUOSl/yA/9+FLXiLkoKHD2RbuGVMMluFqb+3tVGfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va4gWsdIDdrs+4+QMpX6TByYR25a1W5nbfKyTuPPTb0=;
 b=sYY1IDH3a6+tpSXn2FxZ+7y9aSP9CFrmmR/ro+uw8C/eFnZwIQlRGcXESe1lPmYJVsn1hG6awh3oUfMlTT14DDxIs3T7yPdkUTeQPWp9krLtwduO139hQOfgiRCHv/lgIa6bN6CFJ4h9XwBJRqA+WDQip6059Jf361Q9n2NONfyDjcmTAEru2i/JfUJ2wPK6d7ar11S/o6Ys+XB9NeitDMHGZ1QSKnaXFbOq26zFqwTfdFdrFnpSN11l2ApMPJPFEuBXHEdOWm3+qtQXW4x0QUYlBHCnaUzffakLG3uBmHDGuswyZWzeEDUls/R5lcAQLGt/nfm/tYj5U6bEEIBb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va4gWsdIDdrs+4+QMpX6TByYR25a1W5nbfKyTuPPTb0=;
 b=5rFE/cUABlMt+DUFB5AHoYtoYZqIeyJb1aTMU3Y60eRC2Kkzz4IHbwzZbSAkL4PfGbWhpD6cMo3aCSQ2dY70miSwQ2+dnP7X8eK150FrPI9GljrffQmVg5jRmqYtURVl2CB801Olp7Kk0wv3HlED76n2xA0bZsJ+2Ue/3fVxgh0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.8; Mon, 20 Apr 2026 02:36:53 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 02:36:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix userq lock order against reset_domain
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix userq lock order against reset_domain
Thread-Index: AQHcy+yAqtg9g3u6b0yonek0fR98ZrXej1OAgAizqzA=
Date: Mon, 20 Apr 2026 02:36:52 +0000
Message-ID: <DS7PR12MB60051ED597A6477FB6277293FB2F2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260414085537.3471717-1-Prike.Liang@amd.com>
 <bf580889-aaa5-44a2-96e1-b66abea912b9@amd.com>
In-Reply-To: <bf580889-aaa5-44a2-96e1-b66abea912b9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-20T02:28:55.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6477:EE_
x-ms-office365-filtering-correlation-id: d7f59db3-87f6-4fc0-492c-08de9e85ae93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: BCNUVtQRfc443+61EZPrNgryn9IuJrWETnzf1FnFpJT9dl7MJjcWltFdyN3VZdCR0tKkZf+9UcyBt3k6cmVy49R6vejsCSNpimGkTZu56YxWftJyettR+hyBldjuIbyPLSBny6hcFnQq38KAKfemVOHK0zXi5c8n9ohrocq48QVUVi4tJGMZmVr4NK2hz7aKoUy5AeqoBol9iWst4GX5Llb3WKxtlQ42g9qICqBP66ohs/a2yhqyFZvhaUPlZ6sNCI7RQBF8EfF9ZgHao0fhkgxc1eslNXpjwh0OZWzIVtGvtbt4aqkTu0ayxw2ME0TD91glhne0kMU5SNxXhDYk8XP6b7WlcyMxeAxWHYgSKxzwnM4YgBbTuRdv/ydEjxHJVLZGPKIfxV3mSzkhuOKdIl+CeD4KOf3fzkoWXEyXyhKrcMmqn+UlK54PsEu8/vXIdiRMmdE8mRNIUD4AwllSGSF/xA5lRUITSFK6T87lY/tSJ6U7gSfDKGJNAYt1KjlZRQb1NE3LKuF5h2zQOaMJgfGbrFAHrE31vmEMIMTCtsDu16GWz5HJlqVzMJk4H2vZyE0XvZmUkvNmWW8y73ANq2bIuRwI3D4/dVLolgIZRPaGfTFk79iZs16sftcdgmkHIkklAOwzyWBs9W/sicTmkjrqTmrZgS2EySDJVMMJYhRBZLa/AgLLTT71p1Sw6PxPvL0/Ry2SvnU1FN+5mXK3JB8/qNgGkuQh37gfCBsVTchF6DRXIrY+YjwGlzU9PXX3cvd+rUB8oGSKAiaxOC4MEn8fdPjWeDvCZe5xgB7JD+E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjZPbU43L3F1bUN2ajRwc0svTkJDVituNk5QeW9oNTNTOWNoYXNCMUxMMVV1?=
 =?utf-8?B?MXEwQ0NkZUV1WmhRS1ZIVlRIOXJEdGFFcXVMR3VTTzJ5K0lvak5ab0ZhUHp5?=
 =?utf-8?B?UGwvVmZ6ajJsdGtFRHpZMEl2VWxCRld0TnZycndQYU41d3craXBqaXdqM0Uy?=
 =?utf-8?B?ZFQwYUNLYkZYaTlIL2pQaFYvaElFY3NPZVl6RUlXWHEzNHRTTERXN21HVU5K?=
 =?utf-8?B?NEpDMUpmKzFvODNRSXhESVhPblNlNy9tYjBjaUhocm1McDdjVWhJSEJzVXFp?=
 =?utf-8?B?NVNZT1VhQklKdmVVZzhXemY5d1VBbFRIWEs2Kysvd3FGYlhubStuUkNLRldE?=
 =?utf-8?B?Ulc0RGk0VUJ1U25iVHppSk5uaStKYUlFMndxWUNJTnlJbzBBRnozdHFseFA0?=
 =?utf-8?B?MTdzWHBvdk04Rnh2U2t4c2pIVFdXY3ZhU0lQL1p4azgzcG9QU3V3bzhsL0x4?=
 =?utf-8?B?Z1NiOXl5OGNleUdsdXFkMDNXbUtTd0pHS3NCUHJUNmE2ZW5iNlg3Y0NyOXB2?=
 =?utf-8?B?YTMzaTRkdktNay95RzVtRlp5c2NucE42VzJCTGNDQzg0TEpJVVpsQiszUW9w?=
 =?utf-8?B?S01EbDcySjhaNXZteFBoR3J5dFpzL2dTTGxFT21vYm5qemRsNWVoMXRqVWhG?=
 =?utf-8?B?WjJJMm4wRkNWRHNidWpQQnpuNE5kOW9KdGtnVUlTT2dSNXRIaXpoV2U2VG9o?=
 =?utf-8?B?VzY0QmtEZlZhWTg1emhEN0lVSlhtNXV1V01OZ003OUN6WlpXTDVaKzRnY3dN?=
 =?utf-8?B?RmdGQVJPMWxsWkhGQ1pnRE1sTzhLSXY5b1JFaE5iYlRzY1FPWHZhdUxrYkJI?=
 =?utf-8?B?ZVoyUXAraXVZQW9BTXI4cGRyR2d1a3BJOXArQURBczd5MGtBS3hZdVNQVzY4?=
 =?utf-8?B?UFpaNnJWbmQwaGNXeXpkeHVpZHc3Mk5QdVkwdkVkZXJaT1Y5T0VGazVaKzV3?=
 =?utf-8?B?TDdHN04xQUdrcGlXa1BMRkN4Zkg1elBQeUlCeExzTVJKMHpUQTVrMFVUZG5Z?=
 =?utf-8?B?elRDWktyTFcvdjlKZmJVOWVWM212YzVXM20vV3ZpUXFJbmliZjlFRHZ0Qjdv?=
 =?utf-8?B?S2dodXlhY0JyTlBnZVR4SCs1Zkl6VDRkUXBsVnNHS1ZIclEycjhSZkV4L1Bs?=
 =?utf-8?B?TldMSldvOGZGdkZPblY5aFgwVEs0cnNsWkkrbG1lbjJZbXpKM0FOUWs5Y2Nu?=
 =?utf-8?B?UjJ3TElYSHJFT2ljdjMrSlJOM0RCRTI4QXJlSUpnaWpHdGJiTTF1ZUgzRWhj?=
 =?utf-8?B?NVVIUTJzUnZUTGQvT0d6VWNuM1pzdk5LWG5HcCt6L21hanB5bVVvQUVrSXRI?=
 =?utf-8?B?V2hpZUJkNXF4cGJMTURIVHpIY3dDaHl4eEk0RGxvNmd5WDNaSHJCRGJ1dzVL?=
 =?utf-8?B?dVpNWHdvaXFrT09qVm1rWEsybTY2MXo2dWt1c1lGNFVwR1dFaU5tWkxRb20z?=
 =?utf-8?B?SzM0T3diMERJUWpZRUEyMDRkV1BtUVV3NGxnT0VjbVUwYkpHQWhvakNKa0ZO?=
 =?utf-8?B?ZWtWNzJxbkViZTlkb2czWDUzY2VPNHNkTk9xQ1o5OUp0WmZSbDJ1UXFwUFR4?=
 =?utf-8?B?RElHbmpEVUpFMnR4L2dEZHFaa0tia0YwSlAzMWkxVjNqSmlTVURiMHBndDU3?=
 =?utf-8?B?QWpUNDN5YUFPMFRYTVl3OWJZVEk0ZlBuSitROGQvS2FJODAvUVFKOTZIclhD?=
 =?utf-8?B?SWM5U2R4RlRBdGpTTkNGdWNYb0hGaEtncUdnbEtjUktUNHJNcGh4S3pMRC96?=
 =?utf-8?B?Y0F3U0s3dExLckllbmYvK0k1UWRoSmdGRFU1NDd5anp6R21YNEFhQlQ1YWxY?=
 =?utf-8?B?Y2lZMzUrR3NqSFVqbTVIRThHVzNHbk1JWVdjc0F4dy9kNkRXQ1laUHRZMm1u?=
 =?utf-8?B?MTBIMklDZjBmQ0xua0R3L2RIdmMzWG5rd1U1eC9xWlREUGFsVklnbGVuSDJt?=
 =?utf-8?B?Y3Ztam1wczJFakc0VlUrR2tpdm02cjFlOHNJZjFRV0tyNGQ3RUlmMVh2bnNr?=
 =?utf-8?B?amp1b3NDMUFUVDd2NXgzTmgrYW5LSGoxTHNRcEVxTWNicWw0Y1VZY04xQ0pF?=
 =?utf-8?B?ZEI0N2oxY0NuRTFkbDd6RWFZdnBkOVBtV1EwVmZJZklBY1FoVmcrUXd5SlEw?=
 =?utf-8?B?dWsxVkhXV2NDL0hvYVRlQzRmdkphTmtuUTFpU1RZUlN3dTBuanVibHRDdTRF?=
 =?utf-8?B?bmc0TWd2TDJYdVpCRXR0ZThOakFOY1FsRG9yU2Q5ZWFldDNHUWRsMnFkUW1R?=
 =?utf-8?B?eWZjU2NYVTB2WEo0TUZKMkI0VjJ0U3pNVVNwekVRTWRpNW00UUw4TktyQUtt?=
 =?utf-8?Q?9LgNwSzSuV/l2AoS3x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f59db3-87f6-4fc0-492c-08de9e85ae93
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 02:36:52.9665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IItrQwB8/MWeJYmRnQAVrZThT0LrOw9FPYafZhDJuvBpUMHQ/f8VvFa9iNKg48yW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTQsIDIwMjYgOTozNiBQTQ0KPiBUbzogTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IEtoYXRyaSwNCj4gU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPg0KPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogZml4IHVzZXJxIGxvY2sgb3JkZXIgYWdhaW5zdCBy
ZXNldF9kb21haW4NCj4NCj4gT24gNC8xNC8yNiAxMDo1NSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+
ID4gVXNlciBxdWV1ZSByZXN0b3JlIHRha2VzIHJlc2VydmF0aW9uIGxvY2tzIGJlZm9yZSB1c2Vy
cV9tdXRleCwgYnV0IHRoZQ0KPiA+IGNyZWF0ZSBhbmQgZGVzdHJveSBwYXRocyBjYW4gdGFrZSB1
c2VycV9tdXRleCBhbmQgdGhlbiBuZXN0DQo+ID4gcmVzZXRfZG9tYWluLT5zZW0gdW5kZXIgaXQu
DQo+DQo+IFllYWggYnV0IHRoYXQgaXMgY29ycmVjdCBiZWhhdmlvci4NCj4NCj4gPiBMb2NrZGVw
IHJpZ2h0ZnVsbHkgcmVwb3J0cyB0aGF0IGFzIGENCj4gPiBwb3NzaWJsZSBkZWFkbG9jayBhZ2Fp
bnN0IHRoZSByZXN0b3JlIHdvcmtlciBhbmQgb3RoZXIgcmVzZXJ2YXRpb24NCj4gPiB1c2Vycy4N
Cj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGtlZXBpbmcgcmVzZXRfZG9tYWluLT5zZW0gb3V0c2lkZSB0
aGUgdXNlcnFfbXV0ZXggc2VjdGlvbg0KPiA+IGluIHRoZSBjcmVhdGUgcGF0aCwgYW5kIGJ5IG1v
dmluZyBxdWV1ZSBjbGVhbnVwIG91dCBmcm9tIHVuZGVyDQo+ID4gdXNlcnFfbXV0ZXggaW4gdGhl
IGRlc3Ryb3kgcGF0aC4gUmVtb3ZlIHRoZSBxdWV1ZSBmcm9tIHRoZSBnbG9iYWwNCj4gPiBkb29y
YmVsbCBsb29rdXAgYmVmb3JlIGRyb3BwaW5nIHVzZXJxX211dGV4IHNvIElSUSBwYXRocyBjYW5u
b3QgYWNjZXNzDQo+ID4gaXQgd2hpbGUgdGVhcmRvd24gY29udGludWVzLg0KPg0KPiBUaGlzIGlz
IGV4YWN0bHkgdGhlIHdyb25nIG9yZGVyLg0KPg0KPiBXZSBuZWVkIHRvIGJlIGFibGUgdG8gd2Fp
dCBmb3IgZmVuY2VzIHdoaWxlIGhvbGRpbmcgdGhlIHVzZXJxX211dGV4IGFuZCB0aGFuIGluIHR1
cm4NCj4gY2FuIHdhaXQgZm9yIEdQVSByZXNldC4gU28gdGhlIEdQVSByZXNldCBjYW4ndCBkZXBl
bmQgb24gdGhlIHVzZXJxX211dGV4Lg0KPg0KPiBUaGUgb3JkZXIgbmVlZHMgdG8gYmU6DQo+IDEu
IHJlc2VydmF0aW9uIGxvY2sNCj4gMi4gdXNlcnFfbXV0ZXgNCj4gMy4gR1BVIHJlc2V0IGxvY2sN
ClllcywgaWYgd2Uga2VlcCB0aGUgY3VycmVudCBsb2NrIGFjcXVpc2l0aW9uIG9yZGVyIGluIHRo
ZSB1c2VycSBJT0NUTCwgd2UgbWF5IG5lZWQgdG8gcmV3b3JrIHRoZSBsb2NrIHNlcXVlbmNpbmcg
aW4gYW1kZ3B1X2luZm9faW9jdGwoKSB0byBhZGRyZXNzIHRoZSBsb2NrZGVwIHZpb2xhdGlvbiBz
aG93biBpbiB0aGUgdHJhY2UgYmVsb3cuIE1lYW53aGlsZSwgSSBub3RpY2VkIHlvdSBhbHJlYWR5
IGFkanVzdGVkIHRoZSBsb2NrIG9yZGVyaW5nIGJldHdlZW4gdGhlIHJlc2V0IGxvY2sgYW5kIG1t
YXBfbG9jazsgSeKAmWxsIGNoZWNrIHRoYXQgY2hhbmdlIG9uIG15IHNpZGUuDQoNCkNoYWluIGV4
aXN0cyBvZjoNCiAgICAgICAgICAgICAgICAgJnJlc2V0X2RvbWFpbi0+c2VtIC0tPiByZXNlcnZh
dGlvbl93d19jbGFzc19tdXRleCAtLT4gJnVzZXJxX21nci0+dXNlcnFfbXV0ZXgNCg0KPiBSZWdh
cmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFu
ZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMgfCAyMSArKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gaW5k
ZXggMjQwOGY4ODhjNGQ5Li41NTE0MjY3NDFhN2YgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IEBAIC00NDcsOCArNDQ3LDYgQEAgc3Rh
dGljIHZvaWQgYW1kZ3B1X3VzZXJxX2NsZWFudXAoc3RydWN0DQo+IGFtZGdwdV91c2VybW9kZV9x
dWV1ZSAqcXVldWUpDQo+ID4gICAgIC8qIERyb3AgdGhlIHVzZXJxIHJlZmVyZW5jZS4gKi8NCj4g
PiAgICAgYW1kZ3B1X3VzZXJxX2J1ZmZlcl92YXNfbGlzdF9jbGVhbnVwKGFkZXYsIHF1ZXVlKTsN
Cj4gPiAgICAgdXFfZnVuY3MtPm1xZF9kZXN0cm95KHF1ZXVlKTsNCj4gPiAtICAgLyogVXNlIGlu
dGVycnVwdC1zYWZlIGxvY2tpbmcgc2luY2UgSVJRIGhhbmRsZXJzIG1heSBhY2Nlc3MgdGhlc2Ug
WEFycmF5cw0KPiAqLw0KPiA+IC0gICB4YV9lcmFzZV9pcnEoJmFkZXYtPnVzZXJxX2Rvb3JiZWxs
X3hhLCBxdWV1ZS0+ZG9vcmJlbGxfaW5kZXgpOw0KPiA+ICAgICBhbWRncHVfdXNlcnFfZmVuY2Vf
ZHJpdmVyX2ZyZWUocXVldWUpOw0KPiA+ICAgICBxdWV1ZS0+ZmVuY2VfZHJ2ID0gTlVMTDsNCj4g
PiAgICAgcXVldWUtPnVzZXJxX21nciA9IE5VTEw7DQo+ID4gQEAgLTY2Miw4ICs2NjAsMTIgQEAg
YW1kZ3B1X3VzZXJxX2Rlc3Ryb3koc3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4gKnVxX21nciwg
c3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWUNCj4gPiAgICAgICAgICAgICBkcm1fd2FybihhZGV2
X3RvX2RybSh1cV9tZ3ItPmFkZXYpLCAidHJ5aW5nIHRvIGRlc3Ryb3kgYSBIVw0KPiBtYXBwaW5n
IHVzZXJxXG4iKTsNCj4gPiAgICAgICAgICAgICBxdWV1ZS0+c3RhdGUgPSBBTURHUFVfVVNFUlFf
U1RBVEVfSFVORzsNCj4gPiAgICAgfQ0KPiA+IC0gICBhbWRncHVfdXNlcnFfY2xlYW51cChxdWV1
ZSk7DQo+ID4gKyAgIC8qIFJlbW92ZSB0aGUgcXVldWUgZnJvbSB0aGUgZ2xvYmFsIGRvb3JiZWxs
IGxvb2t1cCBiZWZvcmUgZHJvcHBpbmcNCj4gPiArICAgICogdXNlcnFfbXV0ZXggc28gSVJRIHBh
dGhzIGNhbid0IGFjY2VzcyBpdCB3aGlsZSBjbGVhbnVwIGNvbnRpbnVlcy4NCj4gPiArICAgICov
DQo+ID4gKyAgIHhhX2VyYXNlX2lycSgmYWRldi0+dXNlcnFfZG9vcmJlbGxfeGEsIHF1ZXVlLT5k
b29yYmVsbF9pbmRleCk7DQo+ID4gICAgIG11dGV4X3VubG9jaygmdXFfbWdyLT51c2VycV9tdXRl
eCk7DQo+ID4gKyAgIGFtZGdwdV91c2VycV9jbGVhbnVwKHF1ZXVlKTsNCj4gPg0KPiA+ICAgICBw
bV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChhZGV2X3RvX2RybShhZGV2KS0+ZGV2KTsNCj4gPg0K
PiA+IEBAIC03OTksNiArODAxLDEzIEBAIGFtZGdwdV91c2VycV9jcmVhdGUoc3RydWN0IGRybV9m
aWxlICpmaWxwLCB1bmlvbg0KPiBkcm1fYW1kZ3B1X3VzZXJxICphcmdzKQ0KPiA+ICAgICAgICAg
ICAgIGdvdG8gY2xlYW5fZmVuY2VfZHJpdmVyOw0KPiA+ICAgICB9DQo+ID4NCj4gPiArICAgLyoN
Cj4gPiArICAgICogS2VlcCByZXNldF9kb21haW4tPnNlbSBvdXRzaWRlIHRoZSB1c2VycV9tdXRl
eCBzZWN0aW9uIHJldHVybmVkIGJ5DQo+ID4gKyAgICAqIGFtZGdwdV91c2VycV9lbnN1cmVfZXZf
ZmVuY2UoKS4gUmVzdG9yZSBhY3F1aXJlcyByZXNlcnZhdGlvbiBsb2Nrcw0KPiA+ICsgICAgKiBi
ZWZvcmUgdXNlcnFfbXV0ZXgsIHNvIHRha2luZyByZXNldF9kb21haW4tPnNlbSBhZnRlciB1c2Vy
cV9tdXRleA0KPiA+ICsgICAgKiB3b3VsZCBpbnZlcnQgdGhlIGVzdGFibGlzaGVkIG9yZGVyIGFu
ZCB0cmlnZ2VyIGxvY2tkZXAuDQo+ID4gKyAgICAqLw0KPiA+ICsgICBkb3duX3JlYWQoJmFkZXYt
PnJlc2V0X2RvbWFpbi0+c2VtKTsNCj4gPiAgICAgYW1kZ3B1X3VzZXJxX2Vuc3VyZV9ldl9mZW5j
ZSgmZnByaXYtPnVzZXJxX21nciwgJmZwcml2LT5ldmZfbWdyKTsNCj4gPg0KPiA+ICAgICAvKiBk
b24ndCBtYXAgdGhlIHF1ZXVlIGlmIHNjaGVkdWxpbmcgaXMgaGFsdGVkICovIEBAIC04MTIsMTYg
KzgyMSwxMw0KPiA+IEBAIGFtZGdwdV91c2VycV9jcmVhdGUoc3RydWN0IGRybV9maWxlICpmaWxw
LCB1bmlvbiBkcm1fYW1kZ3B1X3VzZXJxICphcmdzKQ0KPiA+ICAgICAgICAgICAgIHIgPSBhbWRn
cHVfdXNlcnFfbWFwX2hlbHBlcihxdWV1ZSk7DQo+ID4gICAgICAgICAgICAgaWYgKHIpIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgIGRybV9maWxlX2Vycih1cV9tZ3ItPmZpbGUsICJGYWlsZWQg
dG8gbWFwIFF1ZXVlXG4iKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgIGdvdG8gY2xlYW5fbXFk
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgZ290byBjbGVhbl9yZXNldF9kb21haW47DQo+ID4g
ICAgICAgICAgICAgfQ0KPiA+ICAgICB9DQo+ID4NCj4gPiAgICAgLyogZHJvcCB0aGlzIHJlZmNv
dW50IGR1cmluZyBxdWV1ZSBkZXN0cm95ICovDQo+ID4gICAgIGtyZWZfaW5pdCgmcXVldWUtPnJl
ZmNvdW50KTsNCj4gPg0KPiA+IC0gICAvKiBXYWl0IGZvciBtb2RlLTEgcmVzZXQgdG8gY29tcGxl
dGUgKi8NCj4gPiAtICAgZG93bl9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7DQo+ID4g
LQ0KPiA+ICAgICByID0geGFfYWxsb2MoJnVxX21nci0+dXNlcnFfeGEsICZxaWQsIHF1ZXVlLA0K
PiA+ICAgICAgICAgICAgICAgICAgWEFfTElNSVQoMSwgQU1ER1BVX01BWF9VU0VSUV9DT1VOVCks
DQo+IEdGUF9LRVJORUwpOw0KPiA+ICAgICBpZiAocikgew0KPiA+IEBAIC04NTAsNyArODU2LDYg
QEAgYW1kZ3B1X3VzZXJxX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIHVuaW9uDQo+ID4g
ZHJtX2FtZGdwdV91c2VycSAqYXJncykNCj4gPg0KPiA+ICBjbGVhbl9yZXNldF9kb21haW46DQo+
ID4gICAgIHVwX3JlYWQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsNCj4gPiAtY2xlYW5fbXFk
Og0KPiA+ICAgICBtdXRleF91bmxvY2soJnVxX21nci0+dXNlcnFfbXV0ZXgpOw0KPiA+ICAgICB1
cV9mdW5jcy0+bXFkX2Rlc3Ryb3kocXVldWUpOw0KPiA+ICBjbGVhbl9mZW5jZV9kcml2ZXI6DQoN
Cg==
