Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE84C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71904247E5
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3VoEpuDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71904247E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D214F6E52A;
	Wed, 28 Oct 2020 16:18:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461576E52A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPEzZZiVY1hTQ7/P0tJJGTL96Mo/m/QRardC4px0tUMezVt63vF+oRSZtkcEsTtKgpRppjv/m+HjGrKkM+2wHepanfj7ZoGoO2xcMnEl20QU9/ZGPohHJfKqYkbvmZdD+tbWK041r9T+hQPV9ZQZ1Y8InvuH3UuUy1uQeu3ZBafAPIJFIT2AO+OMEh58oPOzkRKVgMrcowEX7hKHpfZeKnkLovY34IaphW0gLJKZa92yTnwoqyLbA147q6j8JXjTJLi71hpjaa1vJOW59NGJyEk66ziIsdF5kddadS9t0gesgjAe+8HLObNH8NpYTf7j55I69tgzWcDdcmvrVrqXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKgLuXYiH7Bn4ScMdtC1BrbH3hysWfc7Cq7xiW6liX0=;
 b=Gm8m+WBjFp4DQ36HDRasRfe45c1Ye73y3JgCGZKzI939Fzw0zJ4SipPA9+6cUu0Y+t6P1pg4F8B5XvNEfAKMbaVPEH72Rv3sc22J8e2gsK4R9KxJFaritH7f5F1wEYX/jeWwSYhRwNP7LSPU2gGi3VJzMBRW74fj7rmRnv7hlJBfPrX0Wpu7jYVjGTOX0D2yt3mEawHc7nWSeQexHQAjtWPrcPf6pDPoL27Ylx4Vznzkp0Pg86ZYWJdy1VONNHN799lRs5SQVkdJxynX504Y9QhIJDMb2RY7Tw+f16TQ1IRQwqiRd4or2AbOu8BvtzSS6llKWAZ57mvDVrAffBT0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKgLuXYiH7Bn4ScMdtC1BrbH3hysWfc7Cq7xiW6liX0=;
 b=3VoEpuDNAeGWE5owTiovt9iHK/R7CHf8ancHckT+DPMjS06KQ554dHITFt4pxgFoxVBVnoW6cPj/gfLlozrHs0sxwDA8Mb2FQa8TNSnvidTFNsWJ/pQqPImnnOviY4/CluK6BrH2lOYeId9UGsINYhxRFC/d8nqnJr5kLW3eg+Y=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 16:18:30 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:18:30 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: Fix getting unique_id in topology
Thread-Topic: [PATCH 1/2] drm/amdkfd: Fix getting unique_id in topology
Thread-Index: AQHWrT4rGa82W8JjN0uykAYQ7ZCPYamtMJ8AgAAAyfA=
Date: Wed, 28 Oct 2020 16:18:30 +0000
Message-ID: <DM6PR12MB3721387976EF9FC25120539885170@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20201028152218.18485-1-kent.russell@amd.com>
 <a6a645a5-5dea-54a2-b3b0-2ad84d7224dc@amd.com>
In-Reply-To: <a6a645a5-5dea-54a2-b3b0-2ad84d7224dc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-28T16:18:28Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=85554268-8c5d-4608-a011-000058cbb09e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-28T16:18:24Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a70d54cf-cce1-4d0c-9518-00009afa4a75
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-28T16:18:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9526868e-5508-430f-9d69-0000ee56a90f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1220944c-e8bf-49c9-f22b-08d87b5d1c29
x-ms-traffictypediagnostic: DM6PR12MB4107:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41076C986EF33CF3A80E676C85170@DM6PR12MB4107.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q8DxepSqwCVIfzNGQbkfsrfwUTYKDq0eGJmsNvOVuKCeFcqf+KUttcX+Br66UNadmGw+0gw3hN1AChTRAQusIkZcadi1e1/c+nWifbGutmbZJsNyMv1K87QDs5yUD1K6ddu4iGwZQjw9gbWx+I5kFuYzAxzU7aiB85Ahuu3stYw2pVSPih8xfpfDNb6UPqRP4+CDLPwTbeKQ2lCgTZkmo7V6swNxnp6VuV2Z9Zw6Q06Ev47I4ozHXygXkN44KV605Nnx/TJkODudxHerdfPD+Jwmzf78nq+dAkpoZEzAYuBwCA9NX/eHpB4+DqyNTVqbd7Cb2R6xqmV8uzvx8+9MUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(9686003)(2906002)(186003)(8936002)(316002)(110136005)(53546011)(6506007)(66946007)(76116006)(8676002)(64756008)(66446008)(66556008)(86362001)(66476007)(478600001)(33656002)(71200400001)(55016002)(83380400001)(26005)(7696005)(52536014)(4001150100001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kQBPU48WTYIPsKzl0D0R73elkVkNkK57S2NHi1ySu2fu8jmtVmf0OoyMVzl37Y8L5PUFKSf5xijM1CJvH75sd9eFwRiMbXtG1D0xWUIBeqwZeZNShvz/d08IksPFcOLsC3wGwL4YFZMlQwMlbv6m4eeTvOqzfjE5MbrP7Yw5n+BSrt7QNVU9KscM1NgwE8Pht/TY2GLb/HB5YT9+vPJTJudsX/q0pFi4msnUmdHfidf3EttjeaQcyxv3Wy68NNoHAj3QOwDqAmQZCkbvjkNSzPgla5UozdWpbEaSzWr+e0Q039fLOq5rZOjuiUV7b3euF783IzLM8t0UoCleUgBKtllOGaY0n1pHlI/DrXos8MaGhmhsbAaZgqbte11WrPEKbU2LXVdbQBDr6sgfwjPXvvPJoCTGxD40SZyPQaXcrpO/lDMvIAhQvtmlp8Q4pz4bnEDqysPdukzQMVnVNVpleHCBrNavt4NH29gD6Ns2LtO051ivLHw39noCVO/TV4X6GMoFAEP3ZIA55NiKX4FQdWM0ZExU0t1A6ZQ1D4ozPYcioGMsLapItF2OJdtFCEOiRVeZpqV/lGOF2Zrr3FTrifU/FIuoqptzwlMndiKDqpNFmMo9J947g6r2E1IZMcJY0XJHNc0HHt4XfANKiTwntg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1220944c-e8bf-49c9-f22b-08d87b5d1c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 16:18:30.6271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qdAY27wiaYF0RcQO2wKZIG22GnryuWeBoSYscnC59VzlsR/LM3izoB7m0azQ3p4zUTwyDQCaznnJGox+uNhsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQpSaWdodCwgd2lsbCBkbyENCg0KIEtlbnQNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyOCwgMjAyMCAxMjoxNiBQ
TQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGtm
ZDogRml4IGdldHRpbmcgdW5pcXVlX2lkIGluIHRvcG9sb2d5DQo+IA0KPiBQbGVhc2UgYWxzbyBy
ZW1vdmUgdGhlIGJyb2tlbiBjb2RlIHRoYXQgaW5pdGlhbGl6ZXMgZ3B1LT51bmlxdWVfaWQgYW5k
DQo+IHJlbW92ZSB0aGUgdW5pcXVlX2lkIGZpZWxkIGZyb20gdGhlIHN0cnVjdHVyZS4NCj4gDQo+
IFJlZ2FyZHMsDQo+IMKgIEZlbGl4DQo+IA0KPiBBbSAyMDIwLTEwLTI4IHVtIDExOjIyIGEubS4g
c2NocmllYiBLZW50IFJ1c3NlbGw6DQo+ID4gU2luY2UgdGhlIHVuaXF1ZV9pZCBpcyBub3cgb2J0
YWluZWQgaW4gYW1kZ3B1IGluIHNtdV9sYXRlX2luaXQsDQo+ID4gdG9wb2xvZ3kncyBkZXZpY2Ug
YWRkaXRpb24gaXMgbm93IGhhcHBlbmluZyBiZWZvcmUgdGhlIHVuaXF1ZV9pZCBpcw0KPiA+IHNh
dmVkLCB0aHVzIHRvcG9sb2d5IG1pc3NlcyBpdC4gVG8gd29yayBhcm91bmQgdGhpcywgd2UgdXNl
IHRoZQ0KPiA+IGFtZGdwdV9hbWRrZmRfZ2V0X3VuaXF1ZV9pZCB0byBnZXQgdGhlIHVuaXF1ZV9p
ZCBhdCByZWFkIHRpbWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZW50IFJ1c3NlbGwgPGtl
bnQucnVzc2VsbEBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPiA+IGluZGV4IDNmMmFhMDU1YzMyYy4uYTNmYzIzODczODE5
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9n
eS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMN
Cj4gPiBAQCAtMTM0MCw3ICsxMzQwLDcgQEAgaW50IGtmZF90b3BvbG9neV9hZGRfZGV2aWNlKHN0
cnVjdCBrZmRfZGV2ICpncHUpDQo+ID4gIAkJZGV2LT5ncHUtPmRxbS0+c2NoZWRfcG9saWN5ICE9
IEtGRF9TQ0hFRF9QT0xJQ1lfTk9fSFdTKSA/DQo+ID4gIAkJYW1kZ3B1X2FtZGtmZF9nZXRfbnVt
X2d3cyhkZXYtPmdwdS0+a2dkKSA6IDA7DQo+ID4gIAlkZXYtPm5vZGVfcHJvcHMubnVtX2NwX3F1
ZXVlcyA9IGdldF9jcF9xdWV1ZXNfbnVtKGRldi0+Z3B1LT5kcW0pOw0KPiA+IC0JZGV2LT5ub2Rl
X3Byb3BzLnVuaXF1ZV9pZCA9IGdwdS0+dW5pcXVlX2lkOw0KPiA+ICsJZGV2LT5ub2RlX3Byb3Bz
LnVuaXF1ZV9pZCA9IGFtZGdwdV9hbWRrZmRfZ2V0X3VuaXF1ZV9pZChkZXYtPmdwdS0+a2dkKTsN
Cj4gPg0KPiA+ICAJa2ZkX2ZpbGxfbWVtX2Nsa19tYXhfaW5mbyhkZXYpOw0KPiA+ICAJa2ZkX2Zp
bGxfaW9saW5rX25vbl9jcmF0X2luZm8oZGV2KTsNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
