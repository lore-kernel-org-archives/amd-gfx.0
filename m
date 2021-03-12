Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D901C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 11:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84BA64FEA
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 11:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84BA64FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880596F599;
	Fri, 12 Mar 2021 11:12:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1BB6F599
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 11:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAnyKRmsJ8fxeCPsLULYO9WOlOA/MTUM+8tVosA59W+5AKgdwEMDMxNP4lnw7SeK7hRh2tE0u0XHMNB+gL4rfsN0HrfRTABSGIkEOr5Vfgi4PlGVI+0oBilk2ky5v2NyM9mxMac8tsAOSoHQdviW3F8niZ0bEjZkUpmJxgdShUxBNhiKEqCy5WakWVjr5RsWo2cpcTItKjpfxBF66gzM8GTPhxUC5Nugfr7MomGky5nQb+AoSfdydMXPzRTl/uRqalT4nYEOps7k7Cvr9ejnol7aHXeOnM2EtZykzrs5I0cKGaHHhHNvu/v3pzEmPySPPANlT07iKuvOYL35HzR5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Poi0W0hbTldqO0x4mu+f4vfv7oQwOHOkP4o7+1N4V94=;
 b=fy7QG6rb0/iqWytIrAvnlKV/1/XAK2Se0BOWxnBTMZmUtWvHK+46gkZ6kY0AIXKuWvs6G5LY/Dj6gwiYgVPnlATmU6swk6fUSRzF0ZlO5MRGv9oJ9o7MSi1GSLYmMqeuSChk0tdaR9Bm8ZPB8Vj8vVRiswqibm53U3yxrgdT6VtJ1IS63sepHS2cGVGxLf4ASdYBoS0Gom/hrub3RMoCezNbQz3yP07AgTUknFnHn7yFoSU896EXayGA0vAdYLOo9sxSS9Ebu5TnpgE+VbJ+aUKjxxtRcWoFTeF4AFmcVhcBXs0/GYUyRSQ6iq2Hb6ZcNNzlaQXwun3BwoRdnyJhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Poi0W0hbTldqO0x4mu+f4vfv7oQwOHOkP4o7+1N4V94=;
 b=TYxRuaOaVIiXyktU4DD0C4Qo2AHDAhzIxkFE6iE94MjyWz2Vopc+s/cqv3db/u+bKfeUGf+U56dUmofhmaX1v9qYFuxHdPcqSuoxBftUoe3IvXleO9FCp4BjcePg0jxpXmNvARkuLkhQmlWbercqLFFEZGTLZB6DZX5d0M5iNSw=
Received: from DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18)
 by DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 11:11:54 +0000
Received: from DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::e940:8e3d:17ab:65e5]) by DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::e940:8e3d:17ab:65e5%9]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 11:11:54 +0000
From: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/8] drm/amdgpu: new resource cursor
Thread-Topic: [PATCH 1/8] drm/amdgpu: new resource cursor
Thread-Index: AQHXFCCmS4J0ELBkoEy7t2O6VTcpMaqAMz8AgAAE3dA=
Date: Fri, 12 Mar 2021 11:11:53 +0000
Message-ID: <DM6PR12MB41887EA09B1AC220B3B45282E46F9@DM6PR12MB4188.namprd12.prod.outlook.com>
References: <20210308134044.133658-1-christian.koenig@amd.com>
 <b95c5f36-0b12-347d-8d85-4e24cdb37003@gmail.com>
In-Reply-To: <b95c5f36-0b12-347d-8d85-4e24cdb37003@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T11:11:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fa692fa7-91f9-4352-a117-c6503ed6fad6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a29a64e3-e495-4bd2-a81b-08d8e547a4a2
x-ms-traffictypediagnostic: DM6PR12MB3002:
x-microsoft-antispam-prvs: <DM6PR12MB3002CC5679802667A3AFDE08E46F9@DM6PR12MB3002.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5a/CYZzSdUBHvwBv2wnBsBy7xGcF3dUOElrw4KUwxrispuXs3tv3ZlVn2NvrshXrJgChLfTU9uj4IXvhyh2YNu6GckJOvFmE5DIa2I2aqJ9MMKq7sogn2P8Bk/saB9mOAnGFUhuXepjAncPJNGPrnHW/+pLlmQ2Q6FpJZZLNLxNDC36UkaWaZNdgT8VYvu6BDaPdl6HMX9RkNOybcebO8BbvEmBu3EK/f/MdVT/ZGE7aBY/SFaQouw9P4hnvXPb6LnINw1M+gRUNPFO0zELqCGA4OiabK6iBcFDHgmZVRJhyagkFjFQ9PyuSaGqSchSetNmWL++KfN0ILVEcNX0d1HPLFkceuy0mg+8QDEB3/tsVlo36B7qJ2y50ES4EjVDwCUesyha1f4wPc6O2hrJPI26FywGLDf33nCGeVOHJ3LuZOpt0qIsdt1byyo8Lr85X8I4LJTplRrg7IjA3g/YLMHqaH6AlFl/z67q7IfRDNfyl12ulCGowQU74cF4A0EXoD1+oia89N4Cz/qyLaSStpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4188.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(26005)(5660300002)(7696005)(9686003)(86362001)(66446008)(83380400001)(64756008)(66556008)(52536014)(2906002)(478600001)(66946007)(186003)(8936002)(66476007)(76116006)(71200400001)(110136005)(8676002)(316002)(53546011)(6506007)(33656002)(55016002)(66574015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZUlBMjBYZ1ZVOUc2bXR0TGE1K051cUZEbzZmLzdBZXNaYmUxWTFOYzRnSVJj?=
 =?utf-8?B?cTB4WTRnKytTeUIyQm5JbVBFU2ZZRFpmK1BVWjdFOEZhSTBDZURHOXZmOTRr?=
 =?utf-8?B?VHFtekhsZXRoSjkraURqSHkzcWhvNGdRNmxpVUY1cXBRcDY4bGtJejBsQ1lt?=
 =?utf-8?B?WlFCcGZCc29lM2RKM2VZVFcycGY5VHlBakFnUXJFRWZRSEZocEJZdXFRUUkz?=
 =?utf-8?B?V2JtUEVPblJld0M5T2w0Q3BYWC9kZzcvWWxBeldHVHpaSWZqVS9Zb0E2dWpJ?=
 =?utf-8?B?YzUzVTdoYTcyYy8rT0NUS3dId0xKL2xFUXNLZldBa3JGanFWN2FwRTBpSTVF?=
 =?utf-8?B?cFIzbTlMN2JCMXAzM21KeHNzZnYydGNvV1pRSVhxcmNyLzhNZi9IeXFBTStT?=
 =?utf-8?B?YzdPWUovVzM3Q3BCWktKRTBQUDExRWVvSDRNbFhIRzJCK2xHSEdCSXZHTXJw?=
 =?utf-8?B?azJxL29pcnQrWERhZkE2RkUxZmtJSGptc0JhT250N0w3UU0xWGRDVVgzMmo1?=
 =?utf-8?B?a1dVUkFNcXlGN2NiSnQxRzRKT3UrMDNlTkFlZFVTSi9PeC9ETG9oRnlCU2Zz?=
 =?utf-8?B?TWQ3ZUVOTmFPNUVxeVp5N3RaZlVOOEZwVEx3MmNEZGNodDFmUUVYSDNxOTdo?=
 =?utf-8?B?OG9wQ050alRSN0FTTzhBeVJQczZwalFyOTk4cWF1TXJOWGsyekZ6WURkNFhZ?=
 =?utf-8?B?SUhMZ0N1ampuNVl3VjYrRzhUdjY4dWc4VzRHNDRybmFLRVJPTThlWDM1d1Bt?=
 =?utf-8?B?YjM5aCtlaVUxZUExWlFFWWQrWFgycjFlM1h5a0hOSUJhR24wSmMyZUtDYkVz?=
 =?utf-8?B?WWMvQXM4WXFTNm4rdWNyRUFZQTJwVWF5eDQydWlBTDBndHUvYTZLdDJ3YTA5?=
 =?utf-8?B?aVROWWYzTHNQMGJISUFHYVpPOFJoeE9sWWd2d2VKK1hMVWd4L3l0U1h4clcx?=
 =?utf-8?B?Vm9PbzBkYUozczBuTUlNZ2JET0l1RWNOazZhWm1razdUQlRnS21qTTYvSEQ2?=
 =?utf-8?B?U3lFWjBIZ01Eb3ZDc0Rnb1ptU3JRSk5Nd0VGYWU2ZFdmV05VM0pYL1Y4SXl0?=
 =?utf-8?B?ZmRGWThIV1NxcElvdytpZndnRjlSMTZoajJyMG9MbXlEd1l2U3JXZ2FMd1kw?=
 =?utf-8?B?UFR3a09WUE1XNGdNRWVrR0QxK3NRdDBEWEs0OVpSTWUyUVZiNXA0VXp3Y1J1?=
 =?utf-8?B?cFJuUDhMVFJmcDRqc1BwelVzV3BoQm11eU1UNDE4a3Q3MWlPazhoT3lneEJL?=
 =?utf-8?B?ZnJycDNOZVNhck4rQ3RJRGlmajZmSm90U0g5MTBnSllkV1dqVlR2bkl5Y0hp?=
 =?utf-8?B?M3gzODZGVVNXSW10NjUra21MYmZ3R0RtYUFZNDBDRWxtOUVRRk0vSGFSWmMz?=
 =?utf-8?B?MEtreXovY2xOZUhXZWo4R3Vrenl5VEVPSGI2am5janhuRkF5MjEyZzFTUjkv?=
 =?utf-8?B?Z2VSczdGR0tBTGtIMmc0NVRHajR4bCtzbE40T3N5c0ErQ1l6SHBrVWs2b2tt?=
 =?utf-8?B?N2pSNWtNcGpNcVZmQW9YaGx2RnJTc0VzcEcrL2ZlNnVyN091S3NsRmxXdmRx?=
 =?utf-8?B?ZWJhSWxMcVVsOUdRZnVZN09hVEJzb3YyZGxmeWV5QWwzZXdRVHF1NFlsNFQ1?=
 =?utf-8?B?NjVEUFNJUEZ3VnZhdVp0SnVOUGRHeXlDMVh0ci9xMGk0Z1BGbjhZK2h2Y3k3?=
 =?utf-8?B?Z0thaVQrQXdCc2ltSklEa3AwQnM0dkRmeTAwdFQwYmJQUEVjYm9sSENING1T?=
 =?utf-8?Q?fagmf4kUl0FW5vOoUlQu7iog8wijPdZcgVMCbGV?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29a64e3-e495-4bd2-a81b-08d8e547a4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 11:11:53.8590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGlAUb5fYYKJM05hfFRnZInZNhM/kwf/U7XKHREcZV+OXT2KdP+gkCYYzOoU32I5P+KY/INcdVHVYRrvOsfG8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpIaSBDaHJpc3RpYW4sDQpSZXZpZXdlZCB0aGUgY2hhbmdlcywg
aXQgbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IEFydW5wcmF2aW4gPEFydW5wcmF2
aW4uUGFuZWVyU2VsdmFtQGFtZC5jb20+DQoNClRoYW5rcywNCkFydW4NCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbT4gDQpTZW50OiBGcmlkYXksIE1hcmNoIDEyLCAyMDIxIDQ6MjIgUE0NClRv
OiBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS84XSBkcm0vYW1kZ3B1OiBuZXcgcmVzb3VyY2UgY3Vyc29yDQoNCkFueSBtb3JlIGNvbW1lbnRz
IG9uIHRoaXMgc2V0IGhlcmUgb3Igb3RoZXJ3aXNlIEknbSBnb2luZyB0byBwdXNoIGl0IHdpdGgg
anVzdCBPYWtzIGFjay4NCg0KVGhhbmtzLA0KQ2hyaXN0aWFuLg0KDQpBbSAwOC4wMy4yMSB1bSAx
NDo0MCBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6DQo+IEFsbG93cyB0byB3YWxrIG92ZXIgdGhl
IGRybV9tbSBub2RlcyBpbiBhIFRUTSByZXNvdXJjZSBvYmplY3QuDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQWNrZWQt
Ynk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0KPiBUZXN0ZWQtYnk6IE5pcm1veSBEYXMg
PG5pcm1veS5kYXNAYW1kLmNvbT4NCj4gLS0tDQo+ICAgLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmVzX2N1cnNvci5oICAgIHwgMTA1ICsrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMDUgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oIA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4xMzM1ZTA5ODUxMGYNCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVz
X2N1cnNvci5oDQo+IEBAIC0wLDAgKzEsMTA1IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMCBPUiBNSVQNCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgMjAyMCBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuDQo+ICsgKg0KPiArICogUGVybWlzc2lvbiBpcyBoZXJlYnkg
Z3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gDQo+ICtvYnRhaW5pbmcgYQ0K
PiArICogY29weSBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24g
ZmlsZXMgKHRoZSANCj4gKyJTb2Z0d2FyZSIpLA0KPiArICogdG8gZGVhbCBpbiB0aGUgU29mdHdh
cmUgd2l0aG91dCByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgDQo+ICtsaW1pdGF0aW9u
DQo+ICsgKiB0aGUgcmlnaHRzIHRvIHVzZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwg
ZGlzdHJpYnV0ZSwgDQo+ICtzdWJsaWNlbnNlLA0KPiArICogYW5kL29yIHNlbGwgY29waWVzIG9m
IHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gDQo+ICt0aGUNCj4g
KyAqIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywgc3ViamVjdCB0byB0aGUgZm9sbG93
aW5nIGNvbmRpdGlvbnM6DQo+ICsgKg0KPiArICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2Ug
YW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgDQo+ICtpbmNsdWRlZCBpbg0KPiAr
ICogYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuDQo+
ICsgKg0KPiArICogVEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FS
UkFOVFkgT0YgQU5ZIEtJTkQsIA0KPiArRVhQUkVTUyBPUg0KPiArICogSU1QTElFRCwgSU5DTFVE
SU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRiANCj4gK01FUkNIQU5UQUJJ
TElUWSwNCj4gKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFORCBOT05JTkZS
SU5HRU1FTlQuICBJTiBOTyBFVkVOVCANCj4gK1NIQUxMDQo+ICsgKiBUSEUgQ09QWVJJR0hUIEhP
TERFUihTKSBPUiBBVVRIT1IoUykgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIA0KPiArREFNQUdF
UyBPUg0KPiArICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05U
UkFDVCwgVE9SVCBPUiANCj4gK09USEVSV0lTRSwNCj4gKyAqIEFSSVNJTkcgRlJPTSwgT1VUIE9G
IE9SIElOIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhFIFVTRSANCj4gK09SDQo+
ICsgKiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuDQo+ICsgKg0KPiArICogQXV0aG9y
czogQ2hyaXN0aWFuIEvDtm5pZw0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgX19BTURHUFVfUkVT
X0NVUlNPUl9IX18NCj4gKyNkZWZpbmUgX19BTURHUFVfUkVTX0NVUlNPUl9IX18NCj4gKw0KPiAr
I2luY2x1ZGUgPGRybS9kcm1fbW0uaD4NCj4gKyNpbmNsdWRlIDxkcm0vdHRtL3R0bV9yZXNvdXJj
ZS5oPg0KPiArDQo+ICsvKiBzdGF0ZSBiYWNrIGZvciB3YWxraW5nIG92ZXIgdnJhbV9tZ3IgYW5k
IGd0dF9tZ3IgYWxsb2NhdGlvbnMgKi8gDQo+ICtzdHJ1Y3QgYW1kZ3B1X3Jlc19jdXJzb3Igew0K
PiArCXVpbnQ2NF90CQlzdGFydDsNCj4gKwl1aW50NjRfdAkJc2l6ZTsNCj4gKwl1aW50NjRfdAkJ
cmVtYWluaW5nOw0KPiArCXN0cnVjdCBkcm1fbW1fbm9kZQkqbm9kZTsNCj4gK307DQo+ICsNCj4g
Ky8qKg0KPiArICogYW1kZ3B1X3Jlc19maXJzdCAtIGluaXRpYWxpemUgYSBhbWRncHVfcmVzX2N1
cnNvcg0KPiArICoNCj4gKyAqIEByZXM6IFRUTSByZXNvdXJjZSBvYmplY3QgdG8gd2Fsaw0KPiAr
ICogQHN0YXJ0OiBTdGFydCBvZiB0aGUgcmFuZ2UNCj4gKyAqIEBzaXplOiBTaXplIG9mIHRoZSBy
YW5nZQ0KPiArICogQGN1cjogY3Vyc29yIG9iamVjdCB0byBpbml0aWFsaXplDQo+ICsgKg0KPiAr
ICogU3RhcnQgd2Fsa2luZyBvdmVyIHRoZSByYW5nZSBvZiBhbGxvY2F0aW9ucyBiZXR3ZWVuIEBz
dGFydCBhbmQgQHNpemUuDQo+ICsgKi8NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfcmVz
X2ZpcnN0KHN0cnVjdCB0dG1fcmVzb3VyY2UgKnJlcywNCj4gKwkJCQkgICAgdWludDY0X3Qgc3Rh
cnQsIHVpbnQ2NF90IHNpemUsDQo+ICsJCQkJICAgIHN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciAq
Y3VyKSB7DQo+ICsJc3RydWN0IGRybV9tbV9ub2RlICpub2RlOw0KPiArDQo+ICsJaWYgKCFyZXMg
fHwgIXJlcy0+bW1fbm9kZSkgew0KPiArCQljdXItPnN0YXJ0ID0gc3RhcnQ7DQo+ICsJCWN1ci0+
c2l6ZSA9IHNpemU7DQo+ICsJCWN1ci0+cmVtYWluaW5nID0gc2l6ZTsNCj4gKwkJY3VyLT5ub2Rl
ID0gTlVMTDsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiArCUJVR19PTihzdGFydCArIHNp
emUgPiByZXMtPm51bV9wYWdlcyA8PCBQQUdFX1NISUZUKTsNCj4gKw0KPiArCW5vZGUgPSByZXMt
Pm1tX25vZGU7DQo+ICsJd2hpbGUgKHN0YXJ0ID4gbm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKQ0K
PiArCQlzdGFydCAtPSBub2RlKystPnNpemUgPDwgUEFHRV9TSElGVDsNCj4gKw0KPiArCWN1ci0+
c3RhcnQgPSAobm9kZS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKyBzdGFydDsNCj4gKwljdXItPnNp
emUgPSAobm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0YXJ0Ow0KPiArCWN1ci0+cmVtYWlu
aW5nID0gc2l6ZTsNCj4gKwljdXItPm5vZGUgPSBub2RlOw0KPiArfQ0KPiArDQo+ICsvKioNCj4g
KyAqIGFtZGdwdV9yZXNfbmV4dCAtIGFkdmFuY2UgdGhlIGN1cnNvcg0KPiArICoNCj4gKyAqIEBj
dXI6IHRoZSBjdXJzb3IgdG8gYWR2YW5jZQ0KPiArICogQHNpemU6IG51bWJlciBvZiBieXRlcyB0
byBtb3ZlIGZvcndhcmQNCj4gKyAqDQo+ICsgKiBNb3ZlIHRoZSBjdXJzb3IgQHNpemUgYnl0ZXMg
Zm9yd3JhZCwgd2Fsa2luZyB0byB0aGUgbmV4dCBub2RlIGlmIG5lY2Vzc2FyeS4NCj4gKyAqLw0K
PiArc3RhdGljIGlubGluZSB2b2lkIGFtZGdwdV9yZXNfbmV4dChzdHJ1Y3QgYW1kZ3B1X3Jlc19j
dXJzb3IgKmN1ciwgDQo+ICt1aW50NjRfdCBzaXplKSB7DQo+ICsJc3RydWN0IGRybV9tbV9ub2Rl
ICpub2RlID0gY3VyLT5ub2RlOw0KPiArDQo+ICsJQlVHX09OKHNpemUgPiBjdXItPnJlbWFpbmlu
Zyk7DQo+ICsNCj4gKwljdXItPnJlbWFpbmluZyAtPSBzaXplOw0KPiArCWlmICghY3VyLT5yZW1h
aW5pbmcpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWN1ci0+c2l6ZSAtPSBzaXplOw0KPiArCWlm
IChjdXItPnNpemUpIHsNCj4gKwkJY3VyLT5zdGFydCArPSBzaXplOw0KPiArCQlyZXR1cm47DQo+
ICsJfQ0KPiArDQo+ICsJY3VyLT5ub2RlID0gKytub2RlOw0KPiArCWN1ci0+c3RhcnQgPSBub2Rl
LT5zdGFydCA8PCBQQUdFX1NISUZUOw0KPiArCWN1ci0+c2l6ZSA9IG1pbihub2RlLT5zaXplIDw8
IFBBR0VfU0hJRlQsIGN1ci0+cmVtYWluaW5nKTsgfQ0KPiArDQo+ICsjZW5kaWYNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
