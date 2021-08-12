Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D197C43214
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184746101E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 184746101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63DE6E314;
	Thu, 12 Aug 2021 06:52:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD686E311
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 06:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/Zmuukb5q1aVBeM/uLq0SJq02becaOwNeHBkFM7RH3vIA06hAbh5R9cT8nu2ZaqjbOHcJnD6bF2OTUHseQGwaxP47lgHxc53q0HmJSeh1RaPjTskaQPcoiM9DxJ6hNNsOL5FCcfZRp5h34WxRZlFw/j2p4qEKY+lH3EjOXRpmPRporFT/UQ81jTWqxyVYV0yqpgw/gAis2y4DEtA4oYglV2wea7twVqtaotfXkreOzVw0E7MMwRN4SIlm9vWNxPyR12MM0x0yYwEDs9rHrsMuF6F5HDG/7fop98q6kKYczsERe9LIYFFxwOl3BRnm9sj/dV/eYkX1RGFkwRxzc8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fyFaVYJncUCL4TJtVnrprxEwNXpAsBXzHCS5P/pw08=;
 b=VV4rWKA0zSi7y2Wub/yIy/M5OiM2WG31KS4xV3XD4ZYByzNcQvE3eb23DVuHhY14okoZTnZQzyNID4ng0xbv92VwKaYJd2byMRVhUCYBdHlqpzCASEh5vX/Dxi1T8qsbD8k+3BJAN0qr2Ru+I96X1C2aJ62HsD8hJH1G7GowSOWW2/nYHJJ7JJg8iz43r1qBZw1yZNXoI00ZXKE4xP7rO7X53uDF2Uhj64kf9hhhZ1trGVNrscTd72G8sM0mtu2OY0sJi+LWU8EPrAcm3RBRwAaSTh70lAAOVkF+npc/bUz0wCDgy1hH8/Z6SEoD+Y6V/TRRz1Ql+F1EwuJhh472uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fyFaVYJncUCL4TJtVnrprxEwNXpAsBXzHCS5P/pw08=;
 b=s+fTjErf3/ODVJcRLTiYQs2sn6B02c5MBe4HKST526cQkz47cmVrNj/oaBqLOg/RQjMVclPNnAlWxEwWUI6ATl1kRTYAj3e8Fa21wah3vjVOEsRuc6XJZSRotY4hkluGXvp8lc4yhl00Scxwl90ZnpZ3UnEQ1eBpuNGA0JM0KCU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4988.namprd12.prod.outlook.com (2603:10b6:5:16a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Thu, 12 Aug 2021 06:51:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 06:51:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
Thread-Topic: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based fan
 speed settings
Thread-Index: AQHXjy7A9dMvhryQnkCSvw1ma4llt6tvYaoAgAALkUA=
Date: Thu, 12 Aug 2021 06:51:56 +0000
Message-ID: <DM6PR12MB26190C2DBBCBDE6AF4835F7FE4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-2-evan.quan@amd.com>
 <f63b688e-81bd-a6a7-4a27-f1d3140559bc@amd.com>
In-Reply-To: <f63b688e-81bd-a6a7-4a27-f1d3140559bc@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T06:51:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c975091e-8bbc-45a9-b909-a156308f87ad;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 479e0c97-8ef0-4cf8-d0a3-08d95d5dace7
x-ms-traffictypediagnostic: DM6PR12MB4988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49881C9263D22465910CB00CE4F99@DM6PR12MB4988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CER96EmVvLyEgZv26zLUKaSj/+A0kHuxlTa7knNBIAR1XYMPIK2CoT8x4bAE36BwqqRZ/XB+cmBMqIkTmJoX9c228myCUBdvXrPw3GHijRgs6lPxW6WTr4JLQjBurBwLFpNJWTIlQvXe0dNjP0e/zi27oq/86W9RwFK0At3POFkHNj9Aiml2rQQA++yKpkkWOnBd7wRDsJORVWKhqH4RlVFdX+nBGU+g+A6neXj4/Hef6n0Kq/rrRHtolZGiFgAwjttHgbS7xSdJCTyHwe76YmOcjOYq1qVDj8F8vFzndVfbkJI2a6A/laxls9ddEoleCpPuuS3pCPXFRNkTb6wDjy4PsLgQE1o0my4sLAYAufaST8cmRVpu7+mWBmrNCTpCWgBqwO4zd3ukCVITfYZdq56nlEbuGDqEsj2lHH0PrdJEDntyp65sXSuwJsNMHiMaLRkK9/bcQvUNe9IY1ENt3vzjgHtAZTiCiWXaUOcmXBV/cdw5CSMJu+ZND0MCrKBYMRS/LG0hAFrFiXVMYjestMNNUcX9h/Rpcx0BslvcC1WZf6KnbT+b1x0Ff4j04b0YwBGI1tKyoWk8MyrmzMVsGMq/Akk71H3jFOrYrkeIskqGqAE3MltoQgcouo3+B0xJvE2GSRU16egHsvrJ2IHgSPeZk4CULBtNlWg0N7G8eOvH7WE88XGqOVgNm/uIPI8GaUrPQdl6nOb/Cil00d+1qg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(38100700002)(53546011)(8676002)(4326008)(2906002)(122000001)(38070700005)(64756008)(66556008)(66946007)(66446008)(66476007)(83380400001)(7696005)(8936002)(33656002)(9686003)(316002)(71200400001)(186003)(55016002)(5660300002)(26005)(52536014)(54906003)(110136005)(478600001)(76116006)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlNhdGxGWlNRbjdldXJrL1dPT1VsNXY1aVNWenY2V2xOQ1pZU2hsdWpteTVD?=
 =?utf-8?B?Nlh0K1M2eXdMQVQwazV6V0dnRUV2end5TmV4eGYwOHVrOXFRczM4SytIME9M?=
 =?utf-8?B?L3dxbUlIY3F5eXdSSmJBL2dPWVlxUDBtaXNKNy9BN1JaMjhwMnFLNnBSNnJh?=
 =?utf-8?B?TEp5WkNIUzVUVnE4cmNHSGE3aGRITGFNZm9FRlJYdm81TmQ1RWsxVytOSGp4?=
 =?utf-8?B?NjdteHBOQzRCYkRxVkRUNUNTQVQ1b29aOFNTYkJ5aXhvUU1lTFlmTVA3WG4r?=
 =?utf-8?B?SFlHd0xpMk1NSVZyUWRUZFZhaHh4YU5xTW9pZjNNTGU3YlBSRENpWlM1aFh6?=
 =?utf-8?B?L3RFMG9XVUd4MS8wa1V1dlhSWVY2dzZGRTBFWC9QTjY3VVlDbVVrVjZTbmFN?=
 =?utf-8?B?dGptUFVTdGo4R3QvamdLZUFjS2tBZjNlNGlJUFdCN3gvZUEzVHJRWWtlLzVJ?=
 =?utf-8?B?RW5jZFFzZzBtdHQxK2dvaUdsSEtvRDI2cHVIZThxVDBDZ0xwdHRnYThOQy84?=
 =?utf-8?B?Vm5uS3NRUnRKUVlLb1NJMThTNWlZTkllRkJhaFJ4N0ZTQVc3ekZDNGIwSE1i?=
 =?utf-8?B?M01kaFphMFRqWmsyZVZ5QnNrUFpwZWFlLzVEQnFZQUI3MGFDMmtFeVYrTG55?=
 =?utf-8?B?TzdpczY4cy83ZkE3STVIWUpXanZoM0cwQldoTld3L1YweXhMTExHTEJTU1pF?=
 =?utf-8?B?RmhZdEZHUDVxWmluMG5nWHQxNjh6OHBBb3R4aFZCK0xmcTg0cXV0NDVhQWJo?=
 =?utf-8?B?YnJOM0NZZks2eEN0cTJrNTJMZVJHSmRtUndSWnlhWWdySGdGUDNVN3YxMDZD?=
 =?utf-8?B?dmtkdUpXY2RhZG16SVAwcU52cXRSSWJYbjhhTDY1TVJVOGJJRlV2TWlobE9s?=
 =?utf-8?B?cU9VZ1J0SjFhZGhoNXg3MUxOdkFZL0puMnBraCtwQmh3YmgvZG1pdVBYRnJt?=
 =?utf-8?B?WENWU0l5SEJwTCtPSTF4dlFHQWxwSUZMRzRTajA2amtpcGIrbXowNGdIeTUy?=
 =?utf-8?B?UEZBbnp6bjJIK0JsM0hFSll3RjhLQkd0UiswbGwzSStxOTdXTlZqWEZvQnVp?=
 =?utf-8?B?NnF1ZlorR0REUHYzK1dEMS80WVRESUErVW1obU5vSkdueW1rZXFKRG0wTC9y?=
 =?utf-8?B?NzJOV2prc3BzOUdDQkI3TW82UFdKU2F4alozRHZ2UzBrazRsL3R5MFpRS0ZC?=
 =?utf-8?B?U0pyNVNsZmYzVEZVbUtvZU5tdmo1ZVVNK2RrL1VYbVlhQzM5bWpFNVVMa1dO?=
 =?utf-8?B?ZmRSam1Kb25zb0NLZU50b3NuYXVpak9CYjJrVEEwSHUxNVN5cThqb1VESFBW?=
 =?utf-8?B?alZ5b3UxL1Z4OUxSV2dtL2w5dVRlRUpvSi82QlV0ZFJtZDhjZ244RS8xS001?=
 =?utf-8?B?RFdTbk9TTmR4S3dITUtXSjN1S2E2TEdodGdnQ3FScW5PbDNtN0o2YWNRVjFq?=
 =?utf-8?B?aUFUL0RUNjZJRE45U2E1WWZMdU1aZ0VqQnlKNkZrdzVGKzFJZXVmeEp5Q29U?=
 =?utf-8?B?dzc1WlNneE1hUHhabE1ZVTRZZTZuYkJOT2JaQjFXbkhYZ3VKWm5DOURHcWNZ?=
 =?utf-8?B?dTV4anUxeXdKMjd5NFMzSzFpcnB5bTNLSWZZeUZpTjgzK0tQSU5ueXJveURm?=
 =?utf-8?B?aVE3aDlGaFNYTkM2N2V4bjErZGNtZnQvOGZqQmVhZ0ZhcWZ6cjlWRkZ2Nitj?=
 =?utf-8?B?TkJobnpQRzY4UHYza29tTytUVFdsR3V1RSszL1BvcmdUd0xaWUgreUNBUkUz?=
 =?utf-8?Q?9LZGJDEq5FtBAJDvECXa2qzFNr3t15acGUUeeMI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479e0c97-8ef0-4cf8-d0a3-08d95d5dace7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 06:51:56.2871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uisVRT5Pek8s1W5tumYra2DJNdArXZZMSJB00y4SmXzsGz/OBwRURMur91bLGn7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4988
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAxMiwgMjAyMSAyOjA1IFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBuaWxzLndh
bGxtZW5pdXNAZ21haWwuY29tOyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi83XSBkcm0vYW1kL3BtOiByZWNvcmQgdGhlIFJQTSBh
bmQgUFdNIGJhc2VkDQo+IGZhbiBzcGVlZCBzZXR0aW5ncw0KPiANCj4gDQo+IA0KPiBPbiA4LzEy
LzIwMjEgOTozMSBBTSwgRXZhbiBRdWFuIHdyb3RlOg0KPiA+IEFzIHRoZSByZWxhdGlvbnNoaXAg
IlBXTSA9IFJQTSAvIHNtdS0+ZmFuX21heF9ycG0iIGJldHdlZW4gZmFuDQo+IHNwZWVkDQo+ID4g
UFdNIGFuZCBSUE0gaXMgbm90IHRydWUgZm9yIFNNVTExIEFTSUNzLiBTbywgYm90aCB0aGUgUlBN
IGFuZCBQV00NCj4gPiBzZXR0aW5ncyBuZWVkIHRvIGJlIHNhdmVkLg0KPiA+DQo+ID4gQ2hhbmdl
LUlkOiBJMzE4YzEzNGQ0NDIyNzNkNTE4YjgwNTMzOWNkZjM4M2UxNTFiOTM1ZA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gLS0NCj4gPiB2MS0+
djI6DQo+ID4gICAgLSBjb2Rpbmcgc3R5bGUgYW5kIGxvZ2dpbmcgcHJpbnRzIG9wdGltaXphdGlv
biAoR3VjaHVuKQ0KPiA+ICAgIC0gcmV1c2UgZXhpc3RpbmcgZmxhZ3MgKExpam8pDQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmggICB8ICAzICsr
Kw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgfCAyMg0K
PiArKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2luYy9hbWRncHVfc211LmgNCj4gPiBpbmRleCAxODM2NTRmOGI1NjQuLjI5OTM0YTVhZjQ0
ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211
LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgNCj4g
PiBAQCAtMzQsNiArMzQsOCBAQA0KPiA+ICAgI2RlZmluZSBTTVVfRldfTkFNRV9MRU4JCQkweDI0
DQo+ID4NCj4gPiAgICNkZWZpbmUgU01VX0RQTV9VU0VSX1BST0ZJTEVfUkVTVE9SRSAoMSA8PCAw
KQ0KPiA+ICsjZGVmaW5lIFNNVV9DVVNUT01fRkFOX1NQRUVEX1JQTSAgICAgKDEgPDwgMSkNCj4g
PiArI2RlZmluZSBTTVVfQ1VTVE9NX0ZBTl9TUEVFRF9QV00gICAgICgxIDw8IDIpDQo+ID4NCj4g
PiAgIC8vIFBvd2VyIFRocm90dGxlcnMNCj4gPiAgICNkZWZpbmUgU01VX1RIUk9UVExFUl9QUFQw
X0JJVAkJCTANCj4gPiBAQCAtMjMwLDYgKzIzMiw3IEBAIHN0cnVjdCBzbXVfdXNlcl9kcG1fcHJv
ZmlsZSB7DQo+ID4gICAJdWludDMyX3QgZmFuX21vZGU7DQo+ID4gICAJdWludDMyX3QgcG93ZXJf
bGltaXQ7DQo+ID4gICAJdWludDMyX3QgZmFuX3NwZWVkX3BlcmNlbnQ7DQo+ID4gKwl1aW50MzJf
dCBmYW5fc3BlZWRfcnBtOw0KPiA+ICAgCXVpbnQzMl90IGZsYWdzOw0KPiA+ICAgCXVpbnQzMl90
IHVzZXJfb2Q7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9hbWRncHVfc211LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1k
Z3B1X3NtdS5jDQo+ID4gaW5kZXggZTMzZTY3MzEwMDMwLi4xMzFhZDBkZmVmYmUgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiA+IEBAIC00
MTMsNyArNDEzLDEzIEBAIHN0YXRpYyB2b2lkIHNtdV9yZXN0b3JlX2RwbV91c2VyX3Byb2ZpbGUo
c3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUpDQo+ID4gICAJCWlmICghcmV0ICYmIHNtdS0+dXNl
cl9kcG1fcHJvZmlsZS5mYW5fc3BlZWRfcGVyY2VudCkgew0KPiA+ICAgCQkJcmV0ID0gc211X3Nl
dF9mYW5fc3BlZWRfcGVyY2VudChzbXUsIHNtdS0NCj4gPnVzZXJfZHBtX3Byb2ZpbGUuZmFuX3Nw
ZWVkX3BlcmNlbnQpOw0KPiA+ICAgCQkJaWYgKHJldCkNCj4gPiAtCQkJCWRldl9lcnIoc211LT5h
ZGV2LT5kZXYsICJGYWlsZWQgdG8gc2V0DQo+IG1hbnVhbCBmYW4gc3BlZWRcbiIpOw0KPiA+ICsJ
CQkJZGV2X2VycihzbXUtPmFkZXYtPmRldiwgIkZhaWxlZCB0byBzZXQNCj4gbWFudWFsIGZhbiBz
cGVlZCBpbiBwZXJjZW50XG4iKTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWlmICghcmV0ICYm
IHNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mYW5fc3BlZWRfcnBtKSB7DQo+ID4gKwkJCXJldCA9IHNt
dV9zZXRfZmFuX3NwZWVkX3JwbShzbXUsIHNtdS0NCj4gPnVzZXJfZHBtX3Byb2ZpbGUuZmFuX3Nw
ZWVkX3JwbSk7DQo+ID4gKwkJCWlmIChyZXQpDQo+ID4gKwkJCQlkZXZfZXJyKHNtdS0+YWRldi0+
ZGV2LCAiRmFpbGVkIHRvIHNldA0KPiBtYW51YWwgZmFuIHNwZWVkIGluDQo+ID4gK3JwbVxuIik7
DQo+ID4gICAJCX0NCj4gPiAgIAl9DQo+ID4NCj4gPiBAQCAtMjE3OSw3ICsyMTg1LDYgQEAgc3Rh
dGljIGludCBzbXVfc2V0X2dmeF9jZ3BnKHN0cnVjdCBzbXVfY29udGV4dA0KPiAqc211LCBib29s
IGVuYWJsZWQpDQo+ID4gICBzdGF0aWMgaW50IHNtdV9zZXRfZmFuX3NwZWVkX3JwbSh2b2lkICpo
YW5kbGUsIHVpbnQzMl90IHNwZWVkKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBzbXVfY29udGV4
dCAqc211ID0gaGFuZGxlOw0KPiA+IC0JdTMyIHBlcmNlbnQ7DQo+ID4gICAJaW50IHJldCA9IDA7
DQo+ID4NCj4gPiAgIAlpZiAoIXNtdS0+cG1fZW5hYmxlZCB8fCAhc211LT5hZGV2LT5wbS5kcG1f
ZW5hYmxlZCkgQEAgLQ0KPiAyMTkwLDgNCj4gPiArMjE5NSw4IEBAIHN0YXRpYyBpbnQgc211X3Nl
dF9mYW5fc3BlZWRfcnBtKHZvaWQgKmhhbmRsZSwgdWludDMyX3QNCj4gc3BlZWQpDQo+ID4gICAJ
aWYgKHNtdS0+cHB0X2Z1bmNzLT5zZXRfZmFuX3NwZWVkX3JwbSkgew0KPiA+ICAgCQlyZXQgPSBz
bXUtPnBwdF9mdW5jcy0+c2V0X2Zhbl9zcGVlZF9ycG0oc211LCBzcGVlZCk7DQo+ID4gICAJCWlm
ICghcmV0ICYmIHNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mbGFncyAmDQo+IFNNVV9EUE1fVVNFUl9Q
Uk9GSUxFX1JFU1RPUkUpIHsNCj4gPiAtCQkJcGVyY2VudCA9IHNwZWVkICogMTAwIC8gc211LT5m
YW5fbWF4X3JwbTsNCj4gPiAtCQkJc211LT51c2VyX2RwbV9wcm9maWxlLmZhbl9zcGVlZF9wZXJj
ZW50ID0NCj4gcGVyY2VudDsNCj4gPiArCQkJc211LT51c2VyX2RwbV9wcm9maWxlLmZsYWdzIHw9
DQo+IFNNVV9DVVNUT01fRkFOX1NQRUVEX1JQTTsNCj4gPiArCQkJc211LT51c2VyX2RwbV9wcm9m
aWxlLmZhbl9zcGVlZF9ycG0gPSBzcGVlZDsNCj4gDQo+IFNvcnJ5LCBtaXNzZWQgdGhpcyB3aGVu
IHlvdSBwb3N0ZWQgdjEuIEVpdGhlciBSUE0gb3IgUFdNIG1vZGUgaXMgYWxsb3dlZA0KPiBhdCBh
IHRpbWUsIGlzIHRoYXQgcmlnaHQ/IElmIHNvLCBzaGFsbCB3ZSBtYWtlIHRoZSBwd20gdG8gMCBh
bmQgcmVzZXQgUFdNIGZsYWcNCj4gd2hlbiBSUE0gaXMgc2V0IGFuZCB2aWNlIHZlcnNhPyBUaGlz
IGhlbHBzIGR1cmluZyByZXN0b3JlIHdoZXJlIG9uZSBpcyBub3QNCj4gb3ZlcndyaXR0ZW4gd2l0
aCB0aGUgb3RoZXIuDQpbUXVhbiwgRXZhbl0gU291bmRzIHJlYXNvbmFibGUgdG8gbWUuIEJ1dCBJ
IHN1cHBvc2Ugd2UgYWxzbyBuZWVkIHRvIHByb21wdCBzb21lIHdhcm5pbmdzIHdoZW4gdXNlciB0
cnlpbmcgdG8gc2V0IHRoZXNlIHR3byBtb2RlcyBhdCB0aGUgc2FtZSB0aW1lLg0KSW5zdGVhZCBv
ZiBwZXJmb3JtaW5nIHRoZXNlIHNpbGVudGx5LiBSaWdodD8NCj4gDQo+IFRoYW5rcywNCj4gTGlq
bw0KPiANCj4gPiAgIAkJfQ0KPiA+ICAgCX0NCj4gPg0KPiA+IEBAIC0yNTUyLDggKzI1NTcsMTEg
QEAgc3RhdGljIGludCBzbXVfc2V0X2Zhbl9jb250cm9sX21vZGUoc3RydWN0DQo+ID4gc211X2Nv
bnRleHQgKnNtdSwgaW50IHZhbHVlKQ0KPiA+DQo+ID4gICAJLyogcmVzZXQgdXNlciBkcG0gZmFu
IHNwZWVkICovDQo+ID4gICAJaWYgKCFyZXQgJiYgdmFsdWUgIT0gQU1EX0ZBTl9DVFJMX01BTlVB
TCAmJg0KPiA+IC0JCQkhKHNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mbGFncyAmDQo+IFNNVV9EUE1f
VVNFUl9QUk9GSUxFX1JFU1RPUkUpKQ0KPiA+ICsJCQkhKHNtdS0+dXNlcl9kcG1fcHJvZmlsZS5m
bGFncyAmDQo+IFNNVV9EUE1fVVNFUl9QUk9GSUxFX1JFU1RPUkUpKSB7DQo+ID4gICAJCXNtdS0+
dXNlcl9kcG1fcHJvZmlsZS5mYW5fc3BlZWRfcGVyY2VudCA9IDA7DQo+ID4gKwkJc211LT51c2Vy
X2RwbV9wcm9maWxlLmZhbl9zcGVlZF9ycG0gPSAwOw0KPiA+ICsJCXNtdS0+dXNlcl9kcG1fcHJv
ZmlsZS5mbGFncyAmPQ0KPiB+KFNNVV9DVVNUT01fRkFOX1NQRUVEX1JQTSB8IFNNVV9DVVNUT01f
RkFOX1NQRUVEX1BXTSk7DQo+ID4gKwl9DQo+ID4NCj4gPiAgIAlyZXR1cm4gcmV0Ow0KPiA+ICAg
fQ0KPiA+IEBAIC0yNjA0LDggKzI2MTIsMTAgQEAgc3RhdGljIGludCBzbXVfc2V0X2Zhbl9zcGVl
ZF9wZXJjZW50KHZvaWQNCj4gKmhhbmRsZSwgdTMyIHNwZWVkKQ0KPiA+ICAgCQlpZiAoc3BlZWQg
PiAxMDApDQo+ID4gICAJCQlzcGVlZCA9IDEwMDsNCj4gPiAgIAkJcmV0ID0gc211LT5wcHRfZnVu
Y3MtPnNldF9mYW5fc3BlZWRfcGVyY2VudChzbXUsDQo+IHNwZWVkKTsNCj4gPiAtCQlpZiAoIXJl
dCAmJiAhKHNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mbGFncyAmDQo+IFNNVV9EUE1fVVNFUl9QUk9G
SUxFX1JFU1RPUkUpKQ0KPiA+ICsJCWlmICghcmV0ICYmICEoc211LT51c2VyX2RwbV9wcm9maWxl
LmZsYWdzICYNCj4gU01VX0RQTV9VU0VSX1BST0ZJTEVfUkVTVE9SRSkpIHsNCj4gPiArCQkJc211
LT51c2VyX2RwbV9wcm9maWxlLmZsYWdzIHw9DQo+IFNNVV9DVVNUT01fRkFOX1NQRUVEX1BXTTsN
Cj4gPiAgIAkJCXNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mYW5fc3BlZWRfcGVyY2VudCA9DQo+IHNw
ZWVkOw0KPiA+ICsJCX0NCj4gPiAgIAl9DQo+ID4NCj4gPiAgIAltdXRleF91bmxvY2soJnNtdS0+
bXV0ZXgpOw0KPiA+DQo=
