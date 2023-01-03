Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73D3C4708D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 19:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5335310E4C9;
	Tue,  3 Jan 2023 19:25:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ACE10E4C9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 19:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3qo7l0D/Mbky1UKQvKfdmC/iXpOaHGpNyFQErERJdvkp0UROjcUoN1CB56bo4xJs0Af0VgOTCJOmH0RHTzrvYLx+BZUkJjXcs58W+fR7slF2q1I22b9w60MkH+NmAJ0MU+amOmpel3xiR9cAgzpz62kIgsZ+9g0C0gbNL3DUu+u9Z94GPWnRu1kRJhGFoMk07bduEDV/Iut3HcIrCorrNf/rywq4zzg0Y3f59ER7rWllZny2oMkzZ+HpZIq1fK0qzwtj3lTZ1ypBmQZEoUYNFnW20MN+2HAZz3tJQO7ro/2uiZvLVsRj6RztYwO3sONj6/2y08kk0+gbBYzV3oi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jO+TwYlPQBOIUPGep2C1TLsqBN0HA6Q0E/sKDB7QJmI=;
 b=Z53J6s+mKA4B3M64KQbhSeuoOKCu9lD8PQPASV5dtrtNKEYlDVZSQ3S3GIHYeoY01y034plNnwPptCcjj4m279RqpNObJ0h2qqpG0COLB7R7NCvn/jIyWn0gzJZ7NE5PZdj4xDC7fSHtoa8Oqp5UWoHeh/nLywy3qjeSOtG2kECveYOuPGk5t+OwscNoOP3NblS0JyGjKc3yMTmiI89L1JahamrfJzNIUPDy/hv33c+QZNYiv2gv4qxciJSrSgmC5ASjO79Xj9lBnEZYunLFhabWy66Fx4Nns+BAlEuHPk/jrTsk2EfPCERaWOwO2HS6Qz5sc7Chx9IU32gaFlO7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO+TwYlPQBOIUPGep2C1TLsqBN0HA6Q0E/sKDB7QJmI=;
 b=dAL6dWgUtt36hKfXHJ2rwT633mX8YVGJcTULy6kUnbkue9u2HB52iGzuO2lSBU4py4G2Ey/8A/dP9TCELhC5+yJbMmsSLTWAlCe/TzskcMvRQ1p8mswBAF7qb6tem12JUrbAdFTIrGr7QJoJ3l5bh6tYMW9eWlFZlKZo/xjUmhg=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:25:41 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::3fbd:bad3:3f81:dc35]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::3fbd:bad3:3f81:dc35%8]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:25:41 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Thread-Topic: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Thread-Index: AQHZFwYFMcwWgY+iQ0uqXzsdFBemE66NFLgAgAAMm7CAAAIJAIAAAEVw
Date: Tue, 3 Jan 2023 19:25:40 +0000
Message-ID: <CH0PR12MB5372F9A6C6ED7917D25EC1C4F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
 <CH0PR12MB5372BF7A0FAE2CAC070D2AB9F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_NxBW+074+sYwuOC11wShDLFFX0Hrsa54m9fYYBWeSpPA@mail.gmail.com>
In-Reply-To: <CADnq5_NxBW+074+sYwuOC11wShDLFFX0Hrsa54m9fYYBWeSpPA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7e01e5dc-cab0-47a7-8400-e944cdc77ec2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-03T19:23:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|CH2PR12MB4055:EE_
x-ms-office365-filtering-correlation-id: 6bde20c2-9d35-490d-ed43-08daedc04d17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzYXUZ5EjpTuqqZ8rYwj4BHTDv3U1KNo6WqpnWgdpkW7dbDpLnHG0eDr3mhH5RmBSigq3+5VoFn0EWJ+7BJc8yGtOY0EXN7YwE80IJPACkemyFOlvC99+7ExosUSmoZpC18lAAPIEUIcSTl8YVHLPqxaa4FAlwlbeefjeS0oAVhuoye0NhJCIRrbEhVJOXeHqt+q49jjH86ZAWK/bZFwy2sK713ApqnhT9Fwf6ktfpZIU7AI5pT8LCMtM60CB5hhxuCLEEkJNfbxqWt6l0fu2pP7x4d2y1Vk+DAEEShxUHuGaJy8Ic3S5/hXEhcg4XI6ExQRoj8/7tVqx1uVxfTeL3mzfYPUNQ+BLqscDhTm3zC5a91j/BUb389sw1g5tv8FAFsJnZAdHRGeuEr+7VgdjpZQ3yFPiaJspLMv7DniXV26wcr57JDmubPAwX8KBaD+McaO3obRQOOjaZjHT02hOb2/LHzl0IHv5B9iNkn2d9JFisXOmOEKJvTwsU2wqOby1wlSQr5pETK1QBKJW/KRRTsaWhm+oHiAnDd9aIoocEF/ZOaurFwE5RlhIbniSkwqSxB9i8uMfsISsqGRTzg+BybBTgs9tDu1jjF1hgkVtKSzFRGUyeAh+SuJL2oTclwVSOfj8fo8K0RzqN6BgI9A2iP+/s/r26nf59S0U8T5PpHc08Ki4Jb5cScs48fMz5nIEOKboYYorORoR1wyyv3UiwDDdm90f1LBe0Raomq4CQo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(38070700005)(55016003)(122000001)(38100700002)(33656002)(86362001)(54906003)(6916009)(316002)(53546011)(7696005)(6506007)(478600001)(26005)(186003)(71200400001)(9686003)(5660300002)(83380400001)(2906002)(4001150100001)(4326008)(76116006)(8676002)(66946007)(66446008)(66556008)(64756008)(66476007)(52536014)(8936002)(41300700001)(22166006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WCs1Z1dmWEdzOHprM2xRN2NqOEJ5Q0kzc0h3dU41bHhnVUthaXpZdjZDa3Bi?=
 =?utf-8?B?Z3MwYkpLYmora095UHpQbDN4bDVJMXpGWVBtcE16Q3ZrV3J0WkZWZDc4cEdK?=
 =?utf-8?B?TTUyR2txOURtRitwZmJzazRzWTUzSFdXRVp2dXQ3OVUzc0lnTHlHZE9qcEU4?=
 =?utf-8?B?UWx4eUJzcDVRZFdLZlorSTQxbnF4UkR6YXN3c0t1N1ZIRDF4TzlVSEtmcHVo?=
 =?utf-8?B?K3lsdVMrN2xZQzlOa3pXNnVmakdLNjRVdk1rZHpybUZWd1B1Zk9ZOGhQbUxJ?=
 =?utf-8?B?S0N5aDF0NVI5QnMrbXY4am1ZdDJIRkFpeU55N1NQTHZNbFBRcEwwV2ZLU0xu?=
 =?utf-8?B?V2JXYmFpS0dKM0NFa2JEL0F1T1FkTkpNMTh1REgweFYvcEpac2pGbTZaMzZa?=
 =?utf-8?B?cDVGbUtwNk1QTUxNUFNBc0FtSzc0K1dKT2VaMDJRNUd0eWI0a1Y1REVubmlH?=
 =?utf-8?B?SFprUzhEQkxaNXFpRlpreUdLUUVZQmFzOCtKeVFzSm9uclp3a2JRcndrVkNa?=
 =?utf-8?B?ZTVuSDFhTjhkejZwclNwMzZ4SFNkVy82MHhBc3hHTWJzVVRoaXYyWW1PSkk0?=
 =?utf-8?B?VXgyKzF4MlQ2MWxDaWU4NzJvTkpVRy9sOXJHTDdCbXVxajdhWFVrdmdZZENI?=
 =?utf-8?B?cFRiTVZSZnh1R292dmxQM09vV2hKb0R2RERIRDF0cmpkNDZHZEg4eS9Mbzlw?=
 =?utf-8?B?cytkRWw1NFZsMVZ6V1pqR1ZGQ1l5dFdsb1g2QmptY0tvbDRUMnNxb2pOUEFF?=
 =?utf-8?B?YVFodEZLNEErSFFlajJQWGVqR2hZUlRiSEJ2aGJrUVR6QTdHZ0czb1daYjFu?=
 =?utf-8?B?Z1ZuSDZtZElId1lKYlpFZmxyejNCeFNOaHRLbHp5QWcxUVNGSy83UU5GbDRH?=
 =?utf-8?B?MUxrUmJUWGk0Y1RFeEVhcWFqVFNMWVNVT0I2Z0xhd1NydDF0YUphN0dleHJI?=
 =?utf-8?B?UEVWMVJjeW4yeGVLMVd4REIwS1phZTBTQmNHbmhVcmFQRGtrbU5jMDUwdGh3?=
 =?utf-8?B?YUlsaUJ4ejJpc0NJSlNwUXF5WVl6SWlSWGxSUmx1TDY5TUpEN2NlTk4rdGwv?=
 =?utf-8?B?Q3FXR3VENmxIdjd5VHpHUVVsc2xDN1FJeHN0MVVzUURFM2JhQlNiU1NPVGlI?=
 =?utf-8?B?WVFOTHVwN2JFcVB5VERGeHlLTC9KRGIwNkhsbXEyU1RSV2VzdzJtcEY4ZTZV?=
 =?utf-8?B?VkFMQ1VscE5KYnZQakxob2RycERBUm12WUFDUjY0SjhPRjZBbWc2VzFyN1Ey?=
 =?utf-8?B?ajd0M1oyakM5Yjh0NzJQbnM2SWt4TWM5a1NaOU40dzdxYlNZZHNxYzVLZHJC?=
 =?utf-8?B?UWkrcFZ0N1J0bHVGRTRBTWp5WGRZMnNqaG95K3A2bW41ODNyUUtjdmhpa0lH?=
 =?utf-8?B?Mlp4SUxhbjlBNW5CWUh5U3F2d2ZCTjZuNUVMblJGUHEvSXhQZGg4TE1GM3Zv?=
 =?utf-8?B?RUVmL1hQNEluTUoxRmsyOUhEVmxYNkVreGxnMzFMRGR1dE5HNzMvYlhqSDZM?=
 =?utf-8?B?WHl3dy9mMmhFYXJJZkR0ZG9rNzkvSW5BSGtQdzBPSjR4bHNwRGM4dk4xeE05?=
 =?utf-8?B?WldBcnN6dVJYYS9wN0hRODJNbmxraTBrOGszdDNUa2VCOEVkNWF6b3JDRERr?=
 =?utf-8?B?OVM2a1UyeFdaY3pycHl4YVY4V1d6VjVLaVhRRXo1bHU1T1VMaVVBZlFFWTBh?=
 =?utf-8?B?NkpBNjRFR2NGS3JLOUc3VjdqOGQ0NXh5Nnd2dEdiYTFuUXkzbW1jUU9IWCtZ?=
 =?utf-8?B?U296bDJLaUt6VVhlRlBWS0Z5RDRRbisyNjFpdVJxRXZSb3lMQTF6U0RmTHFV?=
 =?utf-8?B?TnpuZVZaQ0ZhQkJNTU0ybFEwWURFT0lhWnNRNGJsZGtWTWFaaFFPNEdHUFQ5?=
 =?utf-8?B?UStuMUYrVWhHbWI0NFVrSHRFQlpBTHZ2c0JlNTZoMnBRQ1dlM0IvQ1VteWFC?=
 =?utf-8?B?eUg1alNpZHJmWjYrZVI0N1laZ1FyU2dPQ3c1cDYySnRQY09pOTlPYWlOcWZF?=
 =?utf-8?B?cXdaZVdIYTFuTk5GVmZITkJNL1hvaFJLem1IakdaVEM1VUVwZXNqSTJqN2pq?=
 =?utf-8?B?NENVSXVaZzFSTWtPMFhxdEVnekVIK3h5MmRxY2dkS2xEc1Mzbm5WZDlqaFJt?=
 =?utf-8?Q?zX8M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bde20c2-9d35-490d-ed43-08daedc04d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 19:25:40.8639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cK/VrQicVuZz2DaKIHWXXECfG+G0QMxEsHy6SORgnpzi+4BwHokUXexw/onYYxU15bJFzTfFAt+livBdXmLkLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
Cc: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Yadav,
 Arvind" <Arvind.Yadav@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCldoYXQgYWJvdXQgdGhlIGV4aXN0
aW5nIHJvY20gYXBwcyB0aGF0IGFscmVhZHkgdXNlIHRoZSAgaHNha210IEFQSXMgZm9yIHVzZXIg
cXVldWUgPw0KDQpTaGFveXVuLmxpdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBUdWVzZGF5LCBK
YW51YXJ5IDMsIDIwMjMgMjoyMiBQTQ0KVG86IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1k
LmNvbT4NCkNjOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBTaGFy
bWEsIFNoYXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWWFkYXYs
IEFydmluZCA8QXJ2aW5kLllhZGF2QGFtZC5jb20+OyBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmlu
IDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtSRkMgMS83
XSBkcm0vYW1kZ3B1OiBVQVBJIGZvciB1c2VyIHF1ZXVlIG1hbmFnZW1lbnQNCg0KT24gVHVlLCBK
YW4gMywgMjAyMyBhdCAyOjE3IFBNIExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT4g
d3JvdGU6DQo+DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KPg0KPiBIc2Fr
bXQgIGhhcyAgdGhlICBpbnRlcmZhY2VzIGZvciBjb21wdXRlIHVzZXIgcXVldWUuIERvIHdlIHdh
bnQgYSB1bmlmeSBBUEkgZm9yIGJvdGggIGdyYXBoaWMgYW5kIGNvbXB1dGUgID8NCg0KWWVhaCwg
dGhhdCBpcyB0aGUgZXZlbnR1YWwgZ29hbCwgaGVuY2UgdGhlIGZsYWcgZm9yIEFRTCB2cyBQTTQu
DQoNCkFsZXgNCg0KPg0KPiBSZWdhcmRzDQo+IFNoYW95dW4ubGl1DQo+DQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBGZWxpeCBLdWVobGluZw0KPiBTZW50OiBU
dWVzZGF5LCBKYW51YXJ5IDMsIDIwMjMgMTozMCBQTQ0KPiBUbzogU2hhcm1hLCBTaGFzaGFuayA8
U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
S29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFlhZGF2LCBB
cnZpbmQgPEFydmluZC5ZYWRhdkBhbWQuY29tPjsNCj4gUGFuZWVyIFNlbHZhbSwgQXJ1bnByYXZp
biA8QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMg
MS83XSBkcm0vYW1kZ3B1OiBVQVBJIGZvciB1c2VyIHF1ZXVlIG1hbmFnZW1lbnQNCj4NCj4gQW0g
MjAyMi0xMi0yMyB1bSAxNDozNiBzY2hyaWViIFNoYXNoYW5rIFNoYXJtYToNCj4gPiBGcm9tOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4NCj4gPiBUaGlzIHBh
dGNoIGludG9yZHVjZXMgbmV3IFVBUEkvSU9DVEwgZm9yIHVzZXJtb2RlIGdyYXBoaWNzIHF1ZXVl
Lg0KPiA+IFRoZSB1c2Vyc3BhY2UgYXBwIHdpbGwgZmlsbCB0aGlzIHN0cnVjdHVyZSBhbmQgcmVx
dWVzdCB0aGUgZ3JhcGhpY3MNCj4gPiBkcml2ZXIgdG8gYWRkIGEgZ3JhcGhpY3Mgd29yayBxdWV1
ZSBmb3IgaXQuIFRoZSBvdXRwdXQgb2YgdGhpcyBVQVBJDQo+ID4gaXMgYSBxdWV1ZSBpZC4NCj4g
Pg0KPiA+IFRoaXMgVUFQSSBtYXBzIHRoZSBxdWV1ZSBpbnRvIEdQVSwgc28gdGhlIGdyYXBoaWNz
IGFwcCBjYW4gc3RhcnQNCj4gPiBzdWJtaXR0aW5nIHdvcmsgdG8gdGhlIHF1ZXVlIGFzIHNvb24g
YXMgdGhlIGNhbGwgcmV0dXJucy4NCj4gPg0KPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gQ2M6IENocmlzdGlhbiBLb2VuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhc2hhbmsgU2hhcm1hIDxz
aGFzaGFuay5zaGFybWFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvdWFwaS9kcm0v
YW1kZ3B1X2RybS5oIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gPiBiL2luY2x1ZGUvdWFwaS9kcm0v
YW1kZ3B1X2RybS5oIGluZGV4IDBkOTNlYzEzMmViYi4uYTNkMGRkNmY2MmM1DQo+ID4gMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gPiArKysgYi9pbmNs
dWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaA0KPiA+IEBAIC01NCw2ICs1NCw3IEBAIGV4dGVybiAi
QyIgew0KPiA+ICAgI2RlZmluZSBEUk1fQU1ER1BVX1ZNICAgICAgICAgICAgICAgICAgICAgICAw
eDEzDQo+ID4gICAjZGVmaW5lIERSTV9BTURHUFVfRkVOQ0VfVE9fSEFORExFICAweDE0DQo+ID4g
ICAjZGVmaW5lIERSTV9BTURHUFVfU0NIRUQgICAgICAgICAgICAweDE1DQo+ID4gKyNkZWZpbmUg
RFJNX0FNREdQVV9VU0VSUSAgICAgICAgICAgICAweDE2DQo+ID4NCj4gPiAgICNkZWZpbmUgRFJN
X0lPQ1RMX0FNREdQVV9HRU1fQ1JFQVRFIERSTV9JT1dSKERSTV9DT01NQU5EX0JBU0UgKyBEUk1f
QU1ER1BVX0dFTV9DUkVBVEUsIHVuaW9uIGRybV9hbWRncHVfZ2VtX2NyZWF0ZSkNCj4gPiAgICNk
ZWZpbmUgRFJNX0lPQ1RMX0FNREdQVV9HRU1fTU1BUCAgIERSTV9JT1dSKERSTV9DT01NQU5EX0JB
U0UgKyBEUk1fQU1ER1BVX0dFTV9NTUFQLCB1bmlvbiBkcm1fYW1kZ3B1X2dlbV9tbWFwKQ0KPiA+
IEBAIC03MSw2ICs3Miw3IEBAIGV4dGVybiAiQyIgew0KPiA+ICAgI2RlZmluZSBEUk1fSU9DVExf
QU1ER1BVX1ZNICAgICAgICAgRFJNX0lPV1IoRFJNX0NPTU1BTkRfQkFTRSArIERSTV9BTURHUFVf
Vk0sIHVuaW9uIGRybV9hbWRncHVfdm0pDQo+ID4gICAjZGVmaW5lIERSTV9JT0NUTF9BTURHUFVf
RkVOQ0VfVE9fSEFORExFIERSTV9JT1dSKERSTV9DT01NQU5EX0JBU0UgKyBEUk1fQU1ER1BVX0ZF
TkNFX1RPX0hBTkRMRSwgdW5pb24gZHJtX2FtZGdwdV9mZW5jZV90b19oYW5kbGUpDQo+ID4gICAj
ZGVmaW5lIERSTV9JT0NUTF9BTURHUFVfU0NIRUQgICAgICAgICAgICAgIERSTV9JT1coRFJNX0NP
TU1BTkRfQkFTRSArIERSTV9BTURHUFVfU0NIRUQsIHVuaW9uIGRybV9hbWRncHVfc2NoZWQpDQo+
ID4gKyNkZWZpbmUgRFJNX0lPQ1RMX0FNREdQVV9VU0VSUSAgICAgICAgICAgICAgIERSTV9JT1co
RFJNX0NPTU1BTkRfQkFTRSArIERSTV9BTURHUFVfVVNFUlEsIHVuaW9uIGRybV9hbWRncHVfdXNl
cnEpDQo+ID4NCj4gPiAgIC8qKg0KPiA+ICAgICogRE9DOiBtZW1vcnkgZG9tYWlucw0KPiA+IEBA
IC0yODgsNiArMjkwLDU2IEBAIHVuaW9uIGRybV9hbWRncHVfY3R4IHsNCj4gPiAgICAgICB1bmlv
biBkcm1fYW1kZ3B1X2N0eF9vdXQgb3V0Ow0KPiA+ICAgfTsNCj4gPg0KPiA+ICsvKiB1c2VyIHF1
ZXVlIElPQ1RMICovDQo+ID4gKyNkZWZpbmUgQU1ER1BVX1VTRVJRX09QX0NSRUFURSAgICAgICAx
DQo+ID4gKyNkZWZpbmUgQU1ER1BVX1VTRVJRX09QX0ZSRUUgMg0KPiA+ICsNCj4gPiArI2RlZmlu
ZSBBTURHUFVfVVNFUlFfTVFEX0ZMQUdTX1NFQ1VSRSAgICAgICAgKDEgPDwgMCkNCj4NCj4gV2hh
dCBkb2VzICJzZWN1cmUiIG1lYW4gaGVyZT8gSSBkb24ndCBzZWUgdGhpcyBmbGFnIHJlZmVyZW5j
ZWQgYW55d2hlcmUgaW4gdGhlIHJlc3Qgb2YgdGhlIHBhdGNoIHNlcmllcy4NCj4NCj4gUmVnYXJk
cywNCj4gICAgRmVsaXgNCj4NCj4NCj4gPiArI2RlZmluZSBBTURHUFVfVVNFUlFfTVFEX0ZMQUdT
X0FRTCAgICgxIDw8IDEpDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgZHJtX2FtZGdwdV91c2VycV9tcWQg
ew0KPiA+ICsgICAgIC8qKiBGbGFnczogQU1ER1BVX1VTRVJRX01RRF9GTEFHU18qICovDQo+ID4g
KyAgICAgX191MzIgICBmbGFnczsNCj4gPiArICAgICAvKiogSVAgdHlwZTogQU1ER1BVX0hXX0lQ
XyogKi8NCj4gPiArICAgICBfX3UzMiAgIGlwX3R5cGU7DQo+ID4gKyAgICAgLyoqIEdFTSBvYmpl
Y3QgaGFuZGxlICovDQo+ID4gKyAgICAgX191MzIgICBkb29yYmVsbF9oYW5kbGU7DQo+ID4gKyAg
ICAgLyoqIERvb3JiZWxsIG9mZnNldCBpbiBkd29yZHMgKi8NCj4gPiArICAgICBfX3UzMiAgIGRv
b3JiZWxsX29mZnNldDsNCj4gPiArICAgICAvKiogR1BVIHZpcnR1YWwgYWRkcmVzcyBvZiB0aGUg
cXVldWUgKi8NCj4gPiArICAgICBfX3U2NCAgIHF1ZXVlX3ZhOw0KPiA+ICsgICAgIC8qKiBTaXpl
IG9mIHRoZSBxdWV1ZSBpbiBieXRlcyAqLw0KPiA+ICsgICAgIF9fdTY0ICAgcXVldWVfc2l6ZTsN
Cj4gPiArICAgICAvKiogR1BVIHZpcnR1YWwgYWRkcmVzcyBvZiB0aGUgcnB0ciAqLw0KPiA+ICsg
ICAgIF9fdTY0ICAgcnB0cl92YTsNCj4gPiArICAgICAvKiogR1BVIHZpcnR1YWwgYWRkcmVzcyBv
ZiB0aGUgd3B0ciAqLw0KPiA+ICsgICAgIF9fdTY0ICAgd3B0cl92YTsNCj4gPiArfTsNCj4gPiAr
DQo+ID4gK3N0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX2luIHsNCj4gPiArICAgICAvKiogQU1ER1BV
X1VTRVJRX09QXyogKi8NCj4gPiArICAgICBfX3UzMiAgIG9wOw0KPiA+ICsgICAgIC8qKiBGbGFn
cyAqLw0KPiA+ICsgICAgIF9fdTMyICAgZmxhZ3M7DQo+ID4gKyAgICAgLyoqIENvbnRleHQgaGFu
ZGxlIHRvIGFzc29jaWF0ZSB0aGUgcXVldWUgd2l0aCAqLw0KPiA+ICsgICAgIF9fdTMyICAgY3R4
X2lkOw0KPiA+ICsgICAgIF9fdTMyICAgcGFkOw0KPiA+ICsgICAgIC8qKiBRdWV1ZSBkZXNjcmlw
dG9yICovDQo+ID4gKyAgICAgc3RydWN0IGRybV9hbWRncHVfdXNlcnFfbXFkIG1xZDsgfTsNCj4g
PiArDQo+ID4gK3N0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX291dCB7DQo+ID4gKyAgICAgLyoqIFF1
ZXVlIGhhbmRsZSAqLw0KPiA+ICsgICAgIF9fdTMyICAgcV9pZDsNCj4gPiArICAgICAvKiogRmxh
Z3MgKi8NCj4gPiArICAgICBfX3UzMiAgIGZsYWdzOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArdW5p
b24gZHJtX2FtZGdwdV91c2VycSB7DQo+ID4gKyAgICAgc3RydWN0IGRybV9hbWRncHVfdXNlcnFf
aW4gaW47DQo+ID4gKyAgICAgc3RydWN0IGRybV9hbWRncHVfdXNlcnFfb3V0IG91dDsgfTsNCj4g
PiArDQo+ID4gICAvKiB2bSBpb2N0bCAqLw0KPiA+ICAgI2RlZmluZSBBTURHUFVfVk1fT1BfUkVT
RVJWRV9WTUlEICAgMQ0KPiA+ICAgI2RlZmluZSBBTURHUFVfVk1fT1BfVU5SRVNFUlZFX1ZNSUQg
Mg0K
