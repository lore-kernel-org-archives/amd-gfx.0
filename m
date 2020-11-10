Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C1C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 09:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEDB20780
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 09:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CSICpBns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEDB20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890C2894C5;
	Tue, 10 Nov 2020 09:53:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770075.outbound.protection.outlook.com [40.107.77.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17FD894C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 09:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy0VH7HkgQoSmgIssL0RQDJaq6cphDQ2SAU4uQ6FxuqhTruoWm1ineuaYsa1LFBcMzYLSbUuJPfOwAKAjlrjWi466P/e47jF66gRDav2aVPN9c2bNqSz/4CZ5zyneX4eeMNjSFBaGmNrFAg7XOMwVAyalZG88AkBcDvzGemU8kgGxqRoBjXwkVtIjI+IIZ159o+A+WoQ70XSBEXpvOPrsbnZqGH8rvLuXU1u0D2NiRvOj1j9QhTfauY3CKosLcclI5K90FgHi2N4SGiFxjtGrDi7Cf4iw+U4mgrD3QP9ki5qgI50KJUwB518zrmx4GZcd+pbJ4SAUKzmX541vqTEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24JhbPN5S1dheLcT6NaOhtjPR/zXRcKdNiTDHXqD6AQ=;
 b=dhNLTpGEjtc/lUZDO+F6QEknwf4YQppKvF2upCNpMxlR7fuECexCHNaQuIi89PHA5rHxerwAfGO77NnU4EEi7M8myThyMirKjwycFL9LuOg/itTCtvX72uwDWy3uEOMtKajx5ZiSHh2p5xkcAySBkMcs0+V4gzkFwcRSarFh9NotlR/z27AD4+zdAOEBa8doMpe4IMcu61Dsb4aYN9zLhwFmf4omxqUVoRJIPwND4k/hua8WO4SpMebYf6D2lvYHDoo7R+kn9ghc8yotRHAJ3NxmoXmyq3AtF95xA6sMAmj3b0zPx7Eots/QFtoB8ru3wLpUnmKb/E2vQLVYmLAUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24JhbPN5S1dheLcT6NaOhtjPR/zXRcKdNiTDHXqD6AQ=;
 b=CSICpBns8lacEXeZRRgWz/gsppK1BYeNt/IsenqKXKO2L34zPjJvunM+mh6kAB7MJA+9uvQhM1rbyAJIgySvgzdut7xF51V/UNWxwo+bYluSkM0WAj43LD9DYnj++4yuz4lemU9esQWSe1JChWsaz+S03gq9dSQ2xa+FrqWRPi4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1912.namprd12.prod.outlook.com (2603:10b6:903:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 09:53:43 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 09:53:43 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Wang, Mengbing (Martin)" <Mengbing.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct table_clk_vlt memory size due to
 replacing one-element array with flexible-array in struct
 phm_clock_voltage_dependency_table
Thread-Topic: [PATCH] drm/amd/pm: correct table_clk_vlt memory size due to
 replacing one-element array with flexible-array in struct
 phm_clock_voltage_dependency_table
Thread-Index: AQHWtzMI/qhdB9wREkqZQ9wA4nlCRanBH8Tg
Date: Tue, 10 Nov 2020 09:53:43 +0000
Message-ID: <CY4PR12MB128766A9787FA385BF81D5A4F1E90@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201110072644.4993-1-mengbing.wang@amd.com>
In-Reply-To: <20201110072644.4993-1-mengbing.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-10T09:52:19Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c56ec238-8fd7-4b43-9250-0000f8e0fbb2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-10T09:53:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c0a38ade-4610-4bce-8ee4-00009d407daa
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13f3dc3b-dd23-401c-a683-08d8855e82b4
x-ms-traffictypediagnostic: CY4PR12MB1912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB19121C98F1A50D4EA46A8706F1E90@CY4PR12MB1912.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02Fz460v+PV2eRGzv6HfKgOnO+qEXSkATw+fW1fBLXs9l2jOskYhU0MzxzI9qO1j3KPeqeDhByZIxx9Dewcaj2BU/N6TS7eSq4+wxKmVHM+94ONXP3g9FlY1k/0vWbZJJhA88noVfCbELZyYzBJJRTpMNBPxcZKnk1QzciL5Id8UhfN55uMT+PqcL7SFK7pvOj+0cjt0WcNmyMRbgfdT2GUKupTnuBTsTi6QxsBe6fWyYqr8rQ51W7qB7GY8wKoEZw8pZxYbQiEvYEkZTauFjrLO1QXEgkNjoQyolzWNepCUMaHAo3G4abGlSY/LNlZks2ZUPd8KVw05AirN9i9i5Bkh6iGyaKgsRoY7Xgtph53z/SAcLuxM9Ammj8HmGHNkgHbld+5Cg9VP0p/iCn6hHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(33656002)(66946007)(7696005)(66476007)(66556008)(9686003)(64756008)(45080400002)(86362001)(66446008)(478600001)(76116006)(53546011)(4326008)(6506007)(966005)(186003)(83380400001)(5660300002)(71200400001)(2906002)(8676002)(52536014)(316002)(8936002)(55016002)(110136005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tWm2K6Liq8eEaiwm4kaBe6EWKpcT+ZeBhweXVspExx5TqOqQJmWrKLHY/uGyImGvqQlnla/cMN7tuxrjQIOfSolIm4ywGdX2RrUiQIN6pwukTAbRA1Z/cMAPOMZvrXBsL1YEQk1n+n0z7935CWg4A0WyaNYluMGW111ECAV0xZiQWNMe6YiX9dWOlzggrq+dhcAKzzAJ/9epdHAoj/sGzyy6kkmz+NK25TfUqEm0NMpyRNiAljeetej8ukkmbNw+KeLnCheMREWzTkDREWM2IxkMjbZRF2Kwdc0EnNF46lF1gT1o8YcKGTPCXG5rlLRiWuMMVlZcrV32VclcOBCkh9R589winqkt0lL/GE7ovXT0Q6hE3JXueM9DsfKpRjKBEGKEaejY7V6XLA1CJAiHsvB1rt/xVhUYH+GfEaXFKTDx/ZZIS4cMGxpUjwRXh419S9NajUEf/c491QyqSJt81TGABkTzFCgmgdqGYCnZUmE+TbcqLcwTfrPbs1qwOoFPMzd+mAd7sj4J6748WXY0A9do87h5j5f+zNJQjG5FUkXyojeZ8FcVZa1jt58kpbNkbaJBBFEjsXNW5Ytu/Xir96Hfw6J2kQgIWsvQR4oGkapJWkp6FhWgv+COz8KzPUZYIi8P3ihs0bIapgTlRXdMhHZbRWkRALTq3HEKx6cdfFw4uv51bApYD1k9yQ1kR69XCQVlXVwKfXFz2zHnNIYpyxZz9gqYDhls3oE3asIS9BYW7pZVzWX6oxO8mStxzf3i7U40bK3dpvYcqwFAeQcNkozK96YNNLKUVN5Hpp1puOVDgQZWoRPFvzGoNcKbUnhNRN20oTeVhqKaMKeUMNvXB9583K0loLwoD/+wfEthUEIGphIvK6aoEsoylVGkyLlA5zFx6Nfwb9EfoJ3uNd4S9A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f3dc3b-dd23-401c-a683-08d8855e82b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 09:53:43.8282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFyw64XtAO4tu8h2PxyQCpAwJ+nl1EfdDH5QElLdOAclC8PPG8flJXbqlQLgbS2+wFOOcbhPTBu5OgWLnDVEaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1912
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
Cc: "Wang, Mengbing \(Martin\)" <Mengbing.Wang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpUaGUgc2lnbmVkLW9mZiBzcGVsbGluZyBpcyBvbmUgdHlwbyBj
YXVzZWQgYnkgbWlzLWVkaXRpbmc/DQoNClNpZ25lZS1vZmYtYnk6IE1lbmdiaW5nIFdhbmcgPG1l
bmdiaW5nLndhbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIE1lbmdiaW5nIFdhbmcNClNlbnQ6IFR1ZXNkYXksIE5v
dmVtYmVyIDEwLCAyMDIwIDM6MjcgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KQ2M6IFdhbmcsIE1lbmdiaW5nIChNYXJ0aW4pIDxNZW5nYmluZy5XYW5nQGFtZC5jb20+DQpT
dWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG06IGNvcnJlY3QgdGFibGVfY2xrX3ZsdCBtZW1vcnkg
c2l6ZSBkdWUgdG8gcmVwbGFjaW5nIG9uZS1lbGVtZW50IGFycmF5IHdpdGggZmxleGlibGUtYXJy
YXkgaW4gc3RydWN0IHBobV9jbG9ja192b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUNCg0KRnJvbTog
bWVuZ2Jpbmcgd2FuZyA8bWVuZ2Jpbmcud2FuZ0BhbWQuY29tPg0KDQoNCkFkZCAxIHRvIHRoZSBz
aXplIHBhc3NlZCB0byBremFsbG9jIGFmdGVyIHJlcGxhY2luZyBvbmUtZWxlbWVudCBhcnJheS4N
Cg0KVGhlcmUgaXMgYSByZWd1bGFyIG5lZWQgaW4gdGhlIGtlcm5lbCB0byBwcm92aWRlIGEgd2F5
IHRvIGRlY2xhcmUgaGF2aW5nIGEgZHluYW1pY2FsbHkgc2l6ZWQgc2V0IG9mIHRyYWlsaW5nIGVs
ZW1lbnRzIGluIGEgc3RydWN0dXJlLiBLZXJuZWwgY29kZSBzaG91bGQgYWx3YXlzIHVzZSDigJxm
bGV4aWJsZSBhcnJheSBtZW1iZXJz4oCdWzFdIGZvciB0aGVzZSBjYXNlcy4gVGhlIG9sZGVyIHN0
eWxlIG9mIG9uZS1lbGVtZW50IG9yIHplcm8tbGVuZ3RoIGFycmF5cyBzaG91bGQgbm8gbG9uZ2Vy
IGJlIHVzZWRbMl0uDQoNClJlZmFjdG9yIHRoZSBjb2RlIGFjY29yZGluZyB0byB0aGUgdXNlIG9m
IGEgZmxleGlibGUtYXJyYXkgbWVtYmVyIGluIHN0cnVjdCBwaG1fcHB0X3YxX21tX2Nsb2NrX3Zv
bHRhZ2VfZGVwZW5kZW5jeV90YWJsZSwgaW5zdGVhZCBvZiBhIG9uZS1lbGVtZW50IGFycmF5LCBh
bmQgdXNlIHRoZSBzdHJ1Y3Rfc2l6ZSgpIGhlbHBlciB0byBjYWxjdWxhdGUgdGhlIHNpemUgZm9y
IHRoZSBhbGxvY2F0aW9uLg0KDQpbMV0gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZW4ud2lraXBlZGlhLm9yZyUyRndpa2kl
MkZGbGV4aWJsZV9hcnJheV9tZW1iZXImYW1wO2RhdGE9MDQlN0MwMSU3Q2d1Y2h1bi5jaGVuJTQw
YW1kLmNvbSU3QzFhOTgxOTY5OTc2ZjQ0ODA1M2QyMDhkODg1NGEwZWFjJTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQwNTkwMDg2NDkyNDA5MSU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1ST1pEa2dHVHJOJTJG
Y2xVNnYxZUYxZyUyQnZwOXE5UzlUdVd3S2JUNGJBalAyUSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KWzJd
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRnd3dy5rZXJuZWwub3JnJTJGZG9jJTJGaHRtbCUyRnY1LjktcmMxJTJGcHJvY2Vz
cyUyRmRlcHJlY2F0ZWQuaHRtbCUyM3plcm8tbGVuZ3RoLWFuZC1vbmUtZWxlbWVudC1hcnJheXMm
YW1wO2RhdGE9MDQlN0MwMSU3Q2d1Y2h1bi5jaGVuJTQwYW1kLmNvbSU3QzFhOTgxOTY5OTc2ZjQ0
ODA1M2QyMDhkODg1NGEwZWFjJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3QzYzNzQwNTkwMDg2NDkyNDA5MSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpv
aU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAl
M0QlN0MzMDAwJmFtcDtzZGF0YT0lMkZINjdldmUzTmxjcCUyQks4ZmV4TnA2Zm5LVnBCQ25WTUN6
R0VGdEVWalVBdyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpTaWduZWUtb2ZmLWJ5OiBNZW5nYmluZyBX
YW5nIDxtZW5nYmluZy53YW5nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jIHwgNSArKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYw0KaW5kZXggY2Y2MGYz
OTkyMzAzLi4xMzNhMDg0NDQ5NDMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jDQpAQCAtMTMwLDkgKzEzMCwxMCBAQCBz
dGF0aWMgaW50IHNtdTEwX2NvbnN0cnVjdF9tYXhfcG93ZXJfbGltaXRzX3RhYmxlKHN0cnVjdCBw
cF9od21nciAqaHdtZ3IsICBzdGF0aWMgaW50IHNtdTEwX2luaXRfZHluYW1pY19zdGF0ZV9hZGp1
c3RtZW50X3J1bGVfc2V0dGluZ3MoDQogCQkJCQkJCXN0cnVjdCBwcF9od21nciAqaHdtZ3IpDQog
ew0KKwlpbnQgY291bnQgPSA4Ow0KIAlzdHJ1Y3QgcGhtX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5j
eV90YWJsZSAqdGFibGVfY2xrX3ZsdDsNCiANCi0JdGFibGVfY2xrX3ZsdCA9IGt6YWxsb2Moc3Ry
dWN0X3NpemUodGFibGVfY2xrX3ZsdCwgZW50cmllcywgNyksDQorCXRhYmxlX2Nsa192bHQgPSBr
emFsbG9jKHN0cnVjdF9zaXplKHRhYmxlX2Nsa192bHQsIGVudHJpZXMsIGNvdW50KSwNCiAJCQkJ
R0ZQX0tFUk5FTCk7DQogDQogCWlmIChOVUxMID09IHRhYmxlX2Nsa192bHQpIHsNCkBAIC0xNDAs
NyArMTQxLDcgQEAgc3RhdGljIGludCBzbXUxMF9pbml0X2R5bmFtaWNfc3RhdGVfYWRqdXN0bWVu
dF9ydWxlX3NldHRpbmdzKA0KIAkJcmV0dXJuIC1FTk9NRU07DQogCX0NCiANCi0JdGFibGVfY2xr
X3ZsdC0+Y291bnQgPSA4Ow0KKwl0YWJsZV9jbGtfdmx0LT5jb3VudCA9IGNvdW50Ow0KIAl0YWJs
ZV9jbGtfdmx0LT5lbnRyaWVzWzBdLmNsayA9IFBQX0RBTF9QT1dFUkxFVkVMXzA7DQogCXRhYmxl
X2Nsa192bHQtPmVudHJpZXNbMF0udiA9IDA7DQogCXRhYmxlX2Nsa192bHQtPmVudHJpZXNbMV0u
Y2xrID0gUFBfREFMX1BPV0VSTEVWRUxfMTsNCi0tDQoyLjE3LjENCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Au
b3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDZ3Vj
aHVuLmNoZW4lNDBhbWQuY29tJTdDMWE5ODE5Njk5NzZmNDQ4MDUzZDIwOGQ4ODU0YTBlYWMlN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDA1OTAwODY0OTI0
MDkxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lW
Mmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRhPVRm
MjRiJTJGb2VYWWNRSGpWeWhreXRKckQ3U3l5bmdtM3pXaU8yZ3VWV09pUSUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
