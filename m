Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A7FC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 11:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C1F221FA
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C1F221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8036D6E241;
	Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C1A6E241
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 11:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4KJj+wLAQdlAl7a6kROILMJWuCttAHREJOIBN8aXjkIpPwxaNm5BOkOwxvW9ZmSqKEmPS2/4bMHOP0XfxQ8GugDSSsVPtj++V9Q/QyUyNIYwOaLGL67gAuEmtinSY3LbTPPMl/pps7xRlYAOciyxedyvvXhOx1nMGep/uw8+Eo1E21cpWdWHW23ZiT4MpGotxUBHLBPeV5JuSoB4VLJ1K8hN2UsRpkszbbK2N2a0Cm7Qfsf4JjfdMHHpS/Ua/gMRNhr6aD6VymIClGLa5Oq5sBsn7vAmqbgYlBFMPcoiQjK9cnFcXMBJEPxdEH1ALAH3EPhVjRsAqadUMVSDHcWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k079PXiODDFJVgmeqfDdzL54DPAVFgacEcZ2H3x+IU4=;
 b=O6IdfNVkCtpfgEnKgy7PCGOe8Ama3xVA/++5+4tDExA/bWB2uEUbz5Ok2bByxWpWdsUUix1FoJoYYDvNrx+uUnb/rOpRUhNEi34KtZAXm2IMOZyzOLgkNFeVPFo/UagDcyjnrfgbj0AfQo/R64QUcMRugRq+Vkcsl94ui+Sw9xL9lrrfaIxUpuaIOC6wkcDA9Jd4l+wjWlfSb39w3HIucrljwZw2lLJq/I4AgdGPCziGYSYCnOXM6JZR6y+PU6fBhKAVXAM+ndbIfrMEibwqx+TA3nyvfpIAqEr+rIUvTC43GLEqIokuq9NUuS/KoL67obBnjNDESJwTlNMf7eloHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k079PXiODDFJVgmeqfDdzL54DPAVFgacEcZ2H3x+IU4=;
 b=2s7APR21YwgL34YcRE5EPuPLW9lkMarITwV2XvHbAcf9ZjD2C4Gu4QA/5QfAe163DhvDAwe7GoG28jRxxgw9exS4b85xd9aDEkpMspluca5zXXCGrd4lN+Hz4QfIgJY0+MVL7Pc0GoeiH0QI29Fpg1OH23F2BjZU7eZSLGo+nQs=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 11:26:24 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c%8]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 11:26:24 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix the system memory page fault because
 of copy overflow
Thread-Topic: [PATCH] drm/amd/display: fix the system memory page fault
 because of copy overflow
Thread-Index: AQHW6yvd+lrAfPqHFESYkugSzcpvpqooivww
Date: Fri, 15 Jan 2021 11:26:23 +0000
Message-ID: <BY5PR12MB488513CB51AD26664AE5AF89EAA70@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210115184658.513045-1-ray.huang@amd.com>
In-Reply-To: <20210115184658.513045-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e971a449-9b69-4004-9789-39ec17e1b87e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-15T11:24:00Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4529d3dd-bc78-4e84-1f6f-08d8b948640a
x-ms-traffictypediagnostic: BY5PR12MB3970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3970EE60748FC1CBA5EF355EEAA70@BY5PR12MB3970.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrqXK7mPiK+yyLXSfwZNviv7cwepZkruGtB2eUAO06Tf3AGXgFwssSE+SXtUSfqUvwV73bhnNqc8qUwpHuc6x5JTcgzBgUjGqZONds03m9eb3AL5EgqmGNWOnNbHS7cKModtae9bb62T1O4x3NRZ8KkSbl4pyPLMHnX6nqjZaMB93Jjtd11A1IZVp7XmDCgtYTapO3nu9gPKadT7KaG/A5skbi+y4bJ2/jYq3y4QTX5EhaKGlqHlCUbwbQ1zRg8Mv367xcQ3QcpqA7QfKGEBkfix0GO86fIFBlAIaF4GrYEfydkNMgjzSyvROMQmYju40QJQTyt+N1Weouu8FE1UBjayRIkcbihLPVc+xFzSz3tdneWM9MHs14Sg5sCJyLaIST2H0V7PQIGcHo98JkxySVetJd0KWd8vgzWCNaFk0KGaX3uUinX679wX5WXFJFi5vSrn9PxzmZStERpucEhKhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(8676002)(52536014)(9686003)(55016002)(64756008)(2906002)(83380400001)(478600001)(45080400002)(54906003)(86362001)(8936002)(316002)(5660300002)(66556008)(966005)(6506007)(76116006)(66446008)(66476007)(53546011)(71200400001)(7696005)(26005)(186003)(110136005)(4326008)(66946007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bGZDemdkUzdIZ1BMS1lPdDR3T1RHQTZxOGVsVlIvNS9sNGRYSDI5amY2T2c1?=
 =?utf-8?B?eG9Ud2FMd0NTZWxxUmdaOGNUQ1UzUVJEUnVkcm9XRzA5R3ZZbXVXYkMxSHMz?=
 =?utf-8?B?aU9ONlNEa2NpcGtKcGF6TEdsMW8xbWlLcHBTR0lHdDVJdmhsUDRJaUFCZC9r?=
 =?utf-8?B?enJjd3FsRDVlVjU2NExPQUlZWm1xVTQyazVDSXhyL3J5Z1g3L0lvdi9MczRX?=
 =?utf-8?B?cGZUajk0RExpTHJnVm5Qa1B2LzFiWFRxaW5JNlVmNTRSUXl6YkRpei9sYmhF?=
 =?utf-8?B?TmRzS0IrVFBUaFR5YlUwb3JBdFVGeUhkVjdoU1JEM2FJWjVLSzhHTVN2QTV4?=
 =?utf-8?B?V09ubU5VMnpMdmNablZYVE9xSktMMmtpMEFWOEJ2TlpWK1FJOHNWaTdhUTl2?=
 =?utf-8?B?UkIySVh4czYzVGhUajloamUvanNmTmJFKzNISVM4WXJsL2Q0VDJiWlRBMmNH?=
 =?utf-8?B?b05tcTlqdVRScjc0Q1YxQm91eFRaUWt3UVZBaG9GWXlLNXc3YjlxdnR3NHFn?=
 =?utf-8?B?ZXAwMW5oVTRvSjZ1RXNkaEpjczJUYXBmYU85ZDYwRmlyK0FMTEVtRkJnd05P?=
 =?utf-8?B?MXcveEFnUy8vaWpCUUd3ZlpGNDhpZXA2UStVaDJQWi9QY2FPUTc1WldyVHlN?=
 =?utf-8?B?Ni9uY3hBR214U3Y4aFUyYXN3Vk9NNFViZ2tFOG1jdzZwRitrS3FOZTY5L2Zz?=
 =?utf-8?B?bk9ZRFIrZGxScW5sMHhsSWwva05hN2VGc2g0dGRhRTl3b2RHaEoxV2pxYTAv?=
 =?utf-8?B?QzBkSkU4eXRacTBxUUJEM1puYlpqOHorS3JwN1UrNXVXZkE1R1diWVRzK3VY?=
 =?utf-8?B?MWYxWnNMY0hPNjdSMTNQL09iYjU3UHZ4SlU3YlcrTlpmVHlybmZKMHV6dzJt?=
 =?utf-8?B?VEpORHdscWVxb1BodTUwQTQ4SVlKV3o1MmVEcUY1R0V5b3BuSHFRQ0ZtT2p3?=
 =?utf-8?B?SWc1ZTBaODQyUTJZdU9wbzZOelo0U0lEeFg3SUw2V2hxNWluU0N2b1Q1UTJO?=
 =?utf-8?B?eGhpSUZObWp2MVBUcldBdHpmaW1hZzVibXJUbGNqZHJ2MWJxRTg3T2pwRm5Q?=
 =?utf-8?B?TDFha2Ric2tzMHNodW1LU2kvUmdwTHovSmFvc05iWkJIUE9DYWM3QWx1bjNR?=
 =?utf-8?B?K3BjeS9sZng1WVdNRGUvYlM0ZCtVRlpYNmdBbUVoN0krZEFiSXc2YmZrQTRJ?=
 =?utf-8?B?MC9sSWdaMXpHeTl1UEVHMmNEVW13d2Uya0F3Wnh1MTFiNHdOSVlLazhWaXZN?=
 =?utf-8?B?UVZiakFXcDVUMmU4dFg1TWx4cXNYN0EwWG5KZnFkZEtBdUVDQi9HTzBvNXZM?=
 =?utf-8?Q?bh0GqV3Ei+uWM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4529d3dd-bc78-4e84-1f6f-08d8b948640a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 11:26:23.7595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ev5S2bbCmfrSxAg33YQfksRdKWzh1sULTJosW6+AYKFneRY4iZhdjjr63j4OAstGuUortNvu+S8FRj+liRcy8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Su,
 Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 Lee Jones <lee.jones@linaro.org>, "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpIaSBSdWksDQpTZWVtcyB0aGUgY2hhbmdlIGhhcyB2aW9sYXRl
ZCB0aGUga2VybmVsIGNvZGluZyBzdHlsZfCfmIosIHBsZWFzZSBoZWxwIGNoZWNrLg0KaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9jb2Rpbmctc3R5bGUuaHRt
bA0KDQpBbGxvY2F0aW5nIG1lbW9yeQ0KLi4uLi4uDQpUaGUgcHJlZmVycmVkIGZvcm0gZm9yIHBh
c3NpbmcgYSBzaXplIG9mIGEgc3RydWN0IGlzIHRoZSBmb2xsb3dpbmc6DQoNCnAgPSBrbWFsbG9j
KHNpemVvZigqcCksIC4uLik7DQpUaGUgYWx0ZXJuYXRpdmUgZm9ybSB3aGVyZSBzdHJ1Y3QgbmFt
ZSBpcyBzcGVsbGVkIG91dCBodXJ0cyByZWFkYWJpbGl0eSBhbmQgaW50cm9kdWNlcyBhbiBvcHBv
cnR1bml0eSBmb3IgYSBidWcgd2hlbiB0aGUgcG9pbnRlciB2YXJpYWJsZSB0eXBlIGlzIGNoYW5n
ZWQgYnV0IHRoZSBjb3JyZXNwb25kaW5nIHNpemVvZiB0aGF0IGlzIHBhc3NlZCB0byBhIG1lbW9y
eSBhbGxvY2F0b3IgaXMgbm90Lg0KDQpSZWdhcmRzLA0KSmlhbnNvbmcNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgSHVhbmcgUnVpDQpTZW50OiBTYXR1cmRheSwgSmFudWFy
eSAxNiwgMjAyMSAyOjQ3IEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTdSwgSmlu
emhvdSAoSm9lKSA8SmluemhvdS5TdUBhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFt
ZC5jb20+OyBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPjsgWmh1LCBDaGFuZ2Zlbmcg
PENoYW5nZmVuZy5aaHVAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5
OiBmaXggdGhlIHN5c3RlbSBtZW1vcnkgcGFnZSBmYXVsdCBiZWNhdXNlIG9mIGNvcHkgb3ZlcmZs
b3cNCg0KVGhlIGJ1ZmZlciBpcyBhbGxvY2F0ZWQgd2l0aCB0aGUgc2l6ZSBvZiBwb2ludGVyIGFu
ZCBjb3B5IHdpdGggdGhlIHNpemUgb2YgZGF0YSBzdHJ1Y3R1cmUuIFRoZW4gdHJpZ2dlciB0aGUg
c3lzdGVtIG1lbW9yeSBwYWdlIGZhdWx0LiBVc2UgdGhlIG9yaWduYWwgZGF0YSBzdHJ1Y3R1cmUg
dG8gZ2V0IHRoZSBvYmplY3Qgc2l6ZS4NCg0KRml4ZXM6IGE4ZTMwMDA1YiBkcm0vYW1kL2Rpc3Bs
YXkvZGMvY29yZS9kY19saW5rOiBNb3ZlIHNvbWUgbG9jYWwgZGF0YSBmcm9tIHRoZSBzdGFjayB0
byB0aGUgaGVhcA0KDQpTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29t
Pg0KQ2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+DQotLS0NCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jDQppbmRleCA2OTU3M2Q2NzA1NmQuLjcz
MTc4OTc4YWU3NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX2xpbmsuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGluay5jDQpAQCAtMTM4MCw3ICsxMzgwLDcgQEAgc3RhdGljIGJvb2wgZGNfbGlua19jb25z
dHJ1Y3Qoc3RydWN0IGRjX2xpbmsgKmxpbmssDQoNCiBEQ19MT0dHRVJfSU5JVChkY19jdHgtPmxv
Z2dlcik7DQoNCi1pbmZvID0ga3phbGxvYyhzaXplb2YoaW5mbyksIEdGUF9LRVJORUwpOw0KK2lu
Zm8gPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaW50ZWdyYXRlZF9pbmZvKSwgR0ZQX0tFUk5FTCk7
DQogaWYgKCFpbmZvKQ0KIGdvdG8gY3JlYXRlX2ZhaWw7DQoNCkBAIC0xNTQ1LDcgKzE1NDUsNyBA
QCBzdGF0aWMgYm9vbCBkY19saW5rX2NvbnN0cnVjdChzdHJ1Y3QgZGNfbGluayAqbGluaywNCiB9
DQoNCiBpZiAoYmlvcy0+aW50ZWdyYXRlZF9pbmZvKQ0KLW1lbWNweShpbmZvLCBiaW9zLT5pbnRl
Z3JhdGVkX2luZm8sIHNpemVvZigqaW5mbykpOw0KK21lbWNweShpbmZvLCBiaW9zLT5pbnRlZ3Jh
dGVkX2luZm8sIHNpemVvZihzdHJ1Y3QgaW50ZWdyYXRlZF9pbmZvKSk7DQoNCiAvKiBMb29rIGZv
ciBjaGFubmVsIG1hcHBpbmcgY29ycmVzcG9uZGluZyB0byBjb25uZWN0b3IgYW5kIGRldmljZSB0
YWcgKi8NCiBmb3IgKGkgPSAwOyBpIDwgTUFYX05VTUJFUl9PRl9FWFRfRElTUExBWV9QQVRIOyBp
KyspIHsNCi0tDQoyLjI1LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3Rp
bmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDSmlhbnNvbmcuQ2hlbiU0MGFtZC5jb20l
N0NhYTFmMGUwMTk2NTg0YWM0MTQ1MjA4ZDhiOTQyZmY1MCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc0NjMwNDQ2OTU2MDg0NzglN0NVbmtub3duJTdDVFdG
cGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFo
YVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9T2hsQk1tMDN0ZzBKVWN0anBFdE84
OGhMMURudTV3eHQ3S2V1b2ptNjFOUSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
