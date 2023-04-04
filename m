Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF65C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 10:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E32110E655;
	Tue,  4 Apr 2023 10:56:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB8310E655
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 10:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOHRT9wfR8kaM9QtzjX53vB612dsW4WO8HcIVAgn4jekmchc16uvv2RdpkBcxQORFerOwdAj4o+XxOaQ7T37wfRXwzeS8hzy62EuIuurpLi3ZWJEBc0IWjbxwxl0zUzAifAuOYrSUgqgkuqT9/kSdKTHNVj4HREXE6KSEqXIqQBeA83qpK6urbWYncLRefQSQjJvy6ndS5I6FZNR1B/tHuA0MF0NU3EuiBSKuBU+OxOhSp87/EYxPGKXsJ4OhTB1cbcM2/CGHN5b/P9cmrRXSPAnGPrnnYSsi8hKCfWM4yten/TI/g9v275sG5SoI4/VUBfNTE1FA7vqrS3wuAX52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WZMG76Xxg/r+uqvzIFLToTgK1W2K8cmlo8vf4eAXLA=;
 b=IvcfgZ2nbNu5rH0vkqbAsbMN+xGxIoaC2bJCG50aSkpTkgBIYLq4P/pZQMSLmfG9ygyO2RCXV++mRNw5DQ4++6HxEOyU5wdY4R+vGJ2zuBWSTEWL4XJXf2dgAaUE1ujMnvgFPm3KmrSr25dKxEcQrJTZBamhWInxOX6jJ5Z3xNk3vHbKYj1BqFhlTYGE0+XP4FTgBwiI44jwE3N5IBSEz30W0e80vuQMKAxx6fgGzeDWvncv0i1QafpFn/LNCbiNrjur2c4ERNyrfyFvwPG1KnMQMdiH8Tu27jmo92oFYsZ1NFopnsRK8n27VCKkX3tfVExzbkRLYFWcBlbOGh/P4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WZMG76Xxg/r+uqvzIFLToTgK1W2K8cmlo8vf4eAXLA=;
 b=p2FHqHxYxYR0dzyT4BzlgVw4eNPydQyQuHUPpctMtgMabAwlsFSINd1k9gzNIfVzUIcjhnaaYvV7mD66pssDMwg/wSTGiwF9h+mmESEAunED/vA3QNf12objxjbVFePK9qTuqwA75J5NpFIkS4bpKWt1yuUqvtTz1gvp6Tbtcbo=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 10:56:39 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::6b6e:7238:b357:8185]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::6b6e:7238:b357:8185%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 10:56:39 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Thread-Topic: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Thread-Index: AQHZZtvUozkdp1zAF0e4jgIRazGDMa8a8iCAgAAEpfA=
Date: Tue, 4 Apr 2023 10:56:38 +0000
Message-ID: <DM4PR12MB5261B08BE4730541920230F89D939@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <cd5efdb0-d6f6-8e91-353f-35906a1fe62f@amd.com>
In-Reply-To: <cd5efdb0-d6f6-8e91-353f-35906a1fe62f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-04T10:56:35Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1d18cdda-21c9-42f1-8971-5e4d6fab2fc2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-04T10:56:35Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 18801164-9587-4ed0-9269-dda4a14ee35a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|BY5PR12MB4968:EE_
x-ms-office365-filtering-correlation-id: 21741cb2-ba84-45c1-66a0-08db34fb4445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: giYMC3vtXd5zdEqOv3ab0FU59HNTtS2onbda2WCid9new3S02xaIf3o3Vt8IHhpnY4XtN+6Q8NpI7sGJ5r2PwnWY7ZJITQo0ayC/6r/SilAHAu9+EWv7vOiZ6Uij6FZJOtsByFI6GxET4iS9aOgjcIc5qFYN5mdIQcHsoygaCvINhnOTjD6FGvuK52lFSBoADojO/rRx8Ve7+3ccc5dIHD5YzeV/m4E6UProKsWmFn7Koxegm1AK/2fEIImmRWx3oHivvi1TXkkYzwaT2WOZhZA9L/p8fxoHs2JmrPpcaN+tlhmn8sM4oNiXcmw5reRYFY6GCmupVei+X855GsRj58kYb7SVA4aFKdoWiN1n8/+NLBDzEbQypxfxo0ahpN51myk+Flm9bvFUdJK5klZE614DCjODQ4O5QbPZmI2q7yQo8ZFZ+zYs6XWzAhZxWd6kk6WXrhO/wOkax+EjZe/OF7DtVOReTwCowGXnL1A+HknzeOsrOBgoAHh6gol496KZvQBhjXECLm2x6awOUHdrPU6eJeDJQQEg1ieE9Vzll/0gAlcj5wkXxScdaZFbi3ppZaW27KD5sMRKU6bMiexIA5SuQF3dpd/d0x0S4vT/8XlNv3Fq1jvZUpnGgo9u7ktK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(122000001)(83380400001)(9686003)(55016003)(53546011)(38100700002)(6506007)(186003)(52536014)(26005)(2906002)(33656002)(8936002)(5660300002)(478600001)(6636002)(38070700005)(66476007)(66556008)(66946007)(54906003)(7696005)(71200400001)(64756008)(66446008)(4326008)(110136005)(76116006)(8676002)(41300700001)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHBZRHlvVGxBeWhlVXdBbXFiN2ZXM0ovS0R4cEdOZnNPWVB4akNoenBCTVNv?=
 =?utf-8?B?Y2pGTXA1am9qdWpEY3Z1enBkamxIaGx0WTY5MGptTXMwZVRScnhlK0Y3dDB0?=
 =?utf-8?B?WGY5akhFU04xNVlHQi9ZN0tqOE53aGdFNGZsRzdUbkphVElvK0RlWUQ0Vllx?=
 =?utf-8?B?QjM0Z0VzSjBFb1I0T2J6Z21UdDcya3B4VXBLYk55U2Uza0JkbFQ4UE9BaFpR?=
 =?utf-8?B?eVJHSTF0cjRJcWY4UUI1RjRVWWtVdElxMmswamN0aHlWNytnanNLQVQ3UFoy?=
 =?utf-8?B?YU8zQ3BIdUNtVkV4cHNQOU9HMmJBN1daYUtRVTlZSkhrd1hvZm1DemZDZlk0?=
 =?utf-8?B?czNaYy9SSnlGUkF3MUZ3dlBHMkZmYzZZUDA1NW91eE5sQm81d1pkL3drWkxx?=
 =?utf-8?B?blNsS080RUJ1MXhCTVRFZzFCMlkvdzIwaVlBTm9RR0h2WSt0SG56QWlFcWFu?=
 =?utf-8?B?S1hrYmd4dUIvbDBDcVhPMlZPSW4xSnZRR2ZRTXgydy83Tlc4a1NSRGNRSEVz?=
 =?utf-8?B?R3lodDhmSHBEejZxN21MMUppOXNWYWlxajVvUFN1TlZja0VtSHhkdkhXMDlU?=
 =?utf-8?B?LzEvZlU3ZnE4YVpvTXd0VUdiNHVHRGdMM0ZQNzJrTXlkYkJlWmtncGRiS1BR?=
 =?utf-8?B?blJJTXNwRGVJbGxQMmpBRDRKYmZSMWx3NWpkeFJ0MytiTjUvTGE3dkhCZzJq?=
 =?utf-8?B?K0dWSm56OFh3MzdobU9OSEFlZGNyWGZCNDJkaDRRYVJTdU5Wejdlc0NValUz?=
 =?utf-8?B?L2IyNGZyVlUzL2pFdXhTUEhaYVI0Q1dQUE9xVlhZWFlyVVltVTNOWjFJS3V1?=
 =?utf-8?B?UUJUKzdSOWJIc1prM0pDOVlOTzBhZnd4cXI3bnZwWDEyU1VCNFhDS0NaTEV1?=
 =?utf-8?B?SGhJb1NrbC91OFBudWQ3a09ydFI0cWh5WmhzZFZTaHByOE92WGhEaVBka2lM?=
 =?utf-8?B?dEQ3M3pIdmFBQ0RWZFA5RStaeXlpaEpURGEydzRHUXhrZjRZUVQ3WnFxcUFK?=
 =?utf-8?B?SnUyNWluc2FxUjBmZTA5QjBGRkYwbzl6Uk1UN1AybStHSFNjOHpkdXJLMmpH?=
 =?utf-8?B?MldKdlNqa3JCOGMrbDVXNDgvUjk4SjB3bWlBa1JBQVd2d1poa0krekROYnUr?=
 =?utf-8?B?aTRCWVVxQjdleUs3eUNlQ0Y4WjdzSytabDh3RzRxOXFFREMxRlJtVmVWSzQr?=
 =?utf-8?B?RTBpL0Y0VUlWdVBnaWVLdHAvc2gwTEl5RkFnK1Y3Y1Z2VUlTKzNqSGxxbjZ0?=
 =?utf-8?B?dDRhMk9oT1FvSk1iL21hL2dYVm1yWFE5MUN3ODZ0UkYrRStTYWgzUlFzYlRE?=
 =?utf-8?B?M3hoQjhNV2V6UTBJdjQ4blliVlAxNlBmZVcrTW4wVis4a21wUWVJdElDbUdv?=
 =?utf-8?B?WkJ6eXNFTFIwNXFWSUhyYkNpbGJLZWVxVk9LRXE2enNrMyt6WFpEdy9zcEhj?=
 =?utf-8?B?QWhHNFpwUytLWWFzRTlyU2pVWnpSbVV2cTNBZGhldkkzdDlyWnpsd01LV0RL?=
 =?utf-8?B?b1FITTdDYkFmakJwMk1IeUdTWGtSak1jbnVhUFFzZUZtR3M1bjNjSW1WaVZ4?=
 =?utf-8?B?bGxGejNzTmhaRTdYdysxZ1l5VWU5emFRVG1QdnNIdVNyNzYwN0pCL1c4L2Z2?=
 =?utf-8?B?YjJEQUJXRC8vL2J6enRtWlh1UURRaFJDMU1EMm9oQ2o4T2IvMVJIRFhOckNw?=
 =?utf-8?B?bm9FS3l0dTBVK3lnbjh4U2ROa2daZ210U2Y0K3JNL1dPU2d6eUpqN2pvL1k4?=
 =?utf-8?B?VnB4ZERQekV2a2FUYnU1M3laWXZ2N1ZLMURiOXZuako5b2tJT0IveVBCREhk?=
 =?utf-8?B?Tm4rZHVMOExwWDlqcmlqQTE1REg0VXBLK0tBTExDaFh3MXkrYVhTOFhrRUhR?=
 =?utf-8?B?dXJ4K0lzcnhWMWNRdnh3ZXRIQXc2cXdxZERKdFd4NEJ5SytZZWZ3YlQ3Yngx?=
 =?utf-8?B?ZzhnSVFpNHFZejBYSDJvc3NpNFh6MVcwRk1FZ3RyMkpWeHBlaTdINVBCem91?=
 =?utf-8?B?WHg0cEVBU1JQVDVxQ000SmIrNVdSa2Rkb01KVjlSaXRPR28yUUVycjQ5a21E?=
 =?utf-8?B?UHVmeWM1S1Axa2x0SVlaZi96T081L2ZhakpUSk52dnB0eHhJWERwcEplc3la?=
 =?utf-8?Q?GasI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21741cb2-ba84-45c1-66a0-08db34fb4445
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 10:56:38.9848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E65m8TWLvFKCkJFqtwNXN7/UtfyRAhtfRuDj0sj0r0m0OcojGSHFmgjFQ2xE3Tmoq/xfYtfVddpUioROHUvCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
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
Cc: "Liu, Aaron" <Aaron.Liu@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDQsIDIwMjMgNjoyNyBQTQ0KPiBUbzog
WGlhbywgU2hhbmUgPHNoYW5lLnhpYW9AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOw0KPiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IENj
OiBMaXUsIEFhcm9uIDxBYXJvbi5MaXVAYW1kLmNvbT47IEd1bywgU2hpa2FpIDxTaGlrYWkuR3Vv
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBBZGQgdXNl
cnB0ciBibyBzdXBwb3J0IGZvciBtR1BVcw0KPiB3aGVuIGlvbW11IGlzIG9uDQo+IA0KPiBBbSAw
NC4wNC4yMyB1bSAxMTo1NiBzY2hyaWViIFNoYW5lIFhpYW86DQo+ID4gRm9yIHVzZXJwdHIgYm8g
d2l0aCBpb21tdSBvbiwgbXVsdGlwbGUgR1BVcyB1c2Ugc2FtZSBzeXN0ZW0gbWVtb3J5IGRtYQ0K
PiA+IG1hcHBpbmcgYWRkcmVzcyB3aGVuIGJvdGggYm9fYWRldiBhbmQgYWRldiBpbiBpZGVudGl0
eSBtb2RlIG9yIGluIHRoZQ0KPiA+IHNhbWUgaW9tbXUgZ3JvdXAuDQoNCkhpIENocmlzdGlhbiwN
Cg0KPiANCj4gV1RGPyBVc2VycHRyIEJPcyBhcmUgbm90IGFsbG93ZWQgdG8gYmUgZXhwb3J0ZWQv
aW1wb3J0ZWQgYmV0d2VlbiBkaWZmZXJlbnQNCj4gR1BVcy4NCj4gDQo+IFNvIGhvdyBjYW4gdGhl
IHNhbWUgdXNlcnB0ciBCTyBiZSB1c2VkIG9uIGRpZmZlcmVudCBHUFVzPw0KDQpJZiBHUFVzIGFy
ZSBhbGwgaW4gaW9tbXUgaWRlbnRpdHkgbW9kZSB3aGljaCBtZWFucyBkbWEgYWRkcmVzcyBhcmUg
dGhlIHNhbWUgYXMgcGh5c2ljYWwgYWRkcmVzcywgIGFsbCBvZiB0aGUgR1BVcyBjYW4gc2VlIHRo
ZSBzeXN0ZW0gbWVtb3J5IGRpcmVjdGx5Lg0KDQpJbiBzdWNoIGNhc2UsIHNob3VsZCB3ZSBleHBv
cnQvaW1wb3J0IHRoZSBCTywgIHRoZW4gY3JlYXRlIGEgbmV3IFNHIEJPIGZvciBhbm90aGVyIEdQ
VT8gDQoNCg0KQmVzdCBSZWdhcmRzLA0KU2hhbmUNCg0KPiANCj4gUmVnYXJkcywNCj4gQ2hyaXN0
aWFuLg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW5lIFhpYW8gPHNoYW5lLnhpYW9A
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYyB8IDggKysrKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPiBpbmRleCBlNzQw
M2Y4ZTRlYmEuLjMzY2RhMzU4Y2I5ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPiBAQCAtODA0LDExICs4MDQs
MTEgQEAgc3RhdGljIGludCBrZmRfbWVtX2F0dGFjaChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAq
YWRldiwgc3RydWN0IGtnZF9tZW0gKm1lbSwNCj4gPiAgIAkJCSB2YSArIGJvX3NpemUsIHZtKTsN
Cj4gPg0KPiA+ICAgCQlpZiAoKGFkZXYgPT0gYm9fYWRldiAmJiAhKG1lbS0+YWxsb2NfZmxhZ3Mg
Jg0KPiBLRkRfSU9DX0FMTE9DX01FTV9GTEFHU19NTUlPX1JFTUFQKSkgfHwNCj4gPiAtCQkgICAg
KGFtZGdwdV90dG1fdHRfZ2V0X3VzZXJtbShtZW0tPmJvLT50Ym8udHRtKSAmJg0KPiBhZGV2LT5y
YW1faXNfZGlyZWN0X21hcHBlZCkgfHwNCj4gPiAtCQkgICAgc2FtZV9oaXZlKSB7DQo+ID4gKwkJ
ICAgIChhbWRncHVfdHRtX3R0X2dldF91c2VybW0obWVtLT5iby0+dGJvLnR0bSkgJiYNCj4gKChh
ZGV2LT5yYW1faXNfZGlyZWN0X21hcHBlZCAmJiBib19hZGV2LT5yYW1faXNfZGlyZWN0X21hcHBl
ZCkgfHwNCj4gPiArCQkJYWRldi0+ZGV2LT5pb21tdV9ncm91cCA9PSBib19hZGV2LT5kZXYtDQo+
ID5pb21tdV9ncm91cCkpIHx8DQo+ID4gK3NhbWVfaGl2ZSl7DQo+ID4gICAJCQkvKiBNYXBwaW5n
cyBvbiB0aGUgbG9jYWwgR1BVLCBvciBWUkFNIG1hcHBpbmdzIGluDQo+IHRoZQ0KPiA+IC0JCQkg
KiBsb2NhbCBoaXZlLCBvciB1c2VycHRyIG1hcHBpbmcgSU9NTVUgZGlyZWN0IG1hcA0KPiBtb2Rl
DQo+ID4gLQkJCSAqIHNoYXJlIHRoZSBvcmlnaW5hbCBCTw0KPiA+ICsJCQkgKiBsb2NhbCBoaXZl
LCBvciB1c2VycHRyIG1hcHBpbmcgaW4gdGhlIHNhbWUgZG1hDQo+ID4gKwkJCSAqIGFkZHJlc3Mg
c3BhY2Ugc2hhcmUgdGhlIG9yaWdpbmFsIEJPDQo+ID4gICAJCQkgKi8NCj4gPiAgIAkJCWF0dGFj
aG1lbnRbaV0tPnR5cGUgPSBLRkRfTUVNX0FUVF9TSEFSRUQ7DQo+ID4gICAJCQlib1tpXSA9IG1l
bS0+Ym87DQo=
