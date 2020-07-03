Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1293C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9186D20870
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qwXl9iaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9186D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7236E223;
	Fri,  3 Jul 2020 13:52:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97A46E223
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 13:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMx1kt5fw3voKwQCqIfVb8Ght8BCQSeXs3mqNvwRquqqOCgd86f/D7bQwCbBzOzRVPk9VXjMwLlzr3YviJ81Pw+KO4Nj3p1fhWN6VPzBLTaoNTgPW1L67l9nk8Wizs8VgiKCLgeWj5ls9Xb+pknJN6rzNVhIAZ2jE80ioXL0mmfy6uRguhR0UoHkCespQg0Ll5jg0GblqvUKt56wMRwnSyQ/DtDNHA3fKqBbpcFf9VhDP39vsj9I14ImwFAJ1HMSExbGXq6skT/5VSk3mf1GdmpGlqdNVtgsl8XXHpGZbQcRK19v8UO6IcpkbtHifqbqLWWzEQ6Xs+ECzVPHBYw0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTto8IfKnOWocnE5Ul0fKemrW3OE3XCsiNAWuiXBkSE=;
 b=m94z7Iq7jkYsfvE438/iabcWu4ev/geoG2xiz7B6V/+Dhu39O3K5a+f7/1QVMAZ7TyJV1/xX0wYXS5TIFDIB3ZrR2ezcwlaVZSzyk+wReY5Pq97OXZRZlgWtbNDAHZwmvAQkHFHcwPsFfSsfU1QKccLNWWLv0KGHLk6kGf5hMPmyh5e6qO67+RfoeOIf2xrXKFG5D3xynZd5Jn0ARlAlsddRcuKMmc31nIp0MqGWBUHwQMuoESMzj+EUB1/kGyk7A9CPufsMhMNeKnrTl55BP6x7MwHPtqAn3ezc0gYlG4sxIt6TScg17w6NBT0UK9xaagqTnFW5qVDXMISnWGGthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTto8IfKnOWocnE5Ul0fKemrW3OE3XCsiNAWuiXBkSE=;
 b=qwXl9iaYMjXn0h5xSZSVcpIg5nEZPNNKiuMk0Kod7aD2U5wQ0dPV5Zj4YEa7XBzjMNVZ6oD6GtDw28SO2MQGbO1wSQRD39R7SceVI5huVcCwzuKJNI6Fl0liQAbMwuf3vQ4MDTplqp13D+QCRBDGu/47F3LBbPPWPR9lrydFvbY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 13:52:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 13:52:40 +0000
Subject: Re: [PATCH v2 1/2] moduleparams: Add hexint type parameter
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20200703134940.27054-1-pmenzel@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <73fce393-45a5-180e-307a-4f399a31c858@amd.com>
Date: Fri, 3 Jul 2020 15:52:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200703134940.27054-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:208:14::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR03CA0004.eurprd03.prod.outlook.com (2603:10a6:208:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 13:52:39 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 975697a8-6ef7-4797-90a2-08d81f5859e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4237:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42373BD7127F7E6053ADA466836A0@MN2PR12MB4237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRVwIunjyd13K1rb8dMzxs4t/3Y/FCjY8tX/zF5IiK9xlL2HkFGPSZEeX33fEcLWPHLdO3nuPW9MKAU355b0gsgyernIJAwK8M1UAU0ZbalnrJNGAEnhjuLCNcAPI+zdhBIttd4WQjdBwJDiBLS8UULqH94DjwPuPE+Y1OafFX6PqdBVyKRR0xQscKpCXIVBdENgZOMtCD4RtDpgDM2UT5RSsKW8GsTXs6n9QNOmBPUV8YyUcVA18NXOfXXcTr4oFnr/HkDLxP1EXLioeZtQHx49nwlEc8Mv7n1sA5r2VUzeS2RSwSEfoxaIoZmyCWfKE48OGlLLOEyhtvQuvqi0gQlr4wqa7YQ8JlcqLjzfKhBjClWnsdpGdjKMNdRa+Kge
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(86362001)(31696002)(316002)(8676002)(8936002)(110136005)(36756003)(83380400001)(2906002)(4326008)(66556008)(66946007)(66476007)(31686004)(16526019)(6666004)(186003)(2616005)(6486002)(52116002)(478600001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sKaiWC0qc29MoekfdizLKGkhwmJMGznQBO3P6z8LiSsOOz9O8vk2klTl0USzghRcrNRHgpsRTcsYm9zGuZ7teV358JL+T+I1i+Ay7ryyQ2Sxd/7vUmQ/0jZAg9rzBal7qdlzVlYV7kCIMP4xjNTs4JtwyMmViLrU0+fMU4iJbvLSejagTmb7gjJLpzZTUkm0oO3kDSOE9OPO2lZRNgCZj94aPw7Wx3Qhmy2qQy+PaYV3hJwkU2nMDxDNnI8HhAFr39AYUD/FTwKTgLoFRgbmbMV7wIATj8qpOLU7uUkR2ALlYCATPDhC0WikDHaCmHeq1ivbHgt8Fu7TRtd7kAaWeaVIQ0DXFVmukJI6OeCshGbFZzmZAIcc6X2H6SuZbhC0yXlGfFs6T5KFYSn3pa8DR5BriKgMt8cjUg90U++ClAfXfJhAUbBXb7klNgXWw3E9imG/0BwIm6dhh6YMMl4ZcDExeXrys5l1tvjLdjf89/f9BEG0EnaTRntZ3M5mXywb01q3/YTq8+/arPcg5G0HA+Yfvp1MGiTgwjo5ZfC/UEnDg5CCw+7dgg3ecWHg4wKO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975697a8-6ef7-4797-90a2-08d81f5859e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 13:52:40.1073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GK3QxIEPsu10CAngig9203momqFrEI2nY7TAwOSVMUpgBWmbHiiT+M8ivhQL91J+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDcuMjAgdW0gMTU6NDkgc2NocmllYiBQYXVsIE1lbnplbDoKPiBGb3IgYml0bWFza3Mg
cHJpbnRpbmcgdmFsdWVzIGluIGhleCBpcyBtb3JlIGNvbnZlbmllbnQuCj4KPiBQcmVmaXggd2l0
aCBgMHhgIHRvIG1ha2UgaXQgY2xlYXIsIHRoYXQgaXTigJlzIGEgaGV4IHZhbHVlLCBhbmQgcGFk
IGl0Cj4gb3V0Lgo+Cj4gVXNpbmcgdGhlIGhlbHBlciBmb3IgYGFtZGdwdS5wcGZlYXR1cmVtYXNr
YCwgaXQgd2lsbCBsb29rIGxpa2UgYmVsb3cuCj4KPiBCZWZvcmU6Cj4KPiAgICAgICQgbW9yZSAv
c3lzL21vZHVsZS9hbWRncHUvcGFyYW1ldGVycy9wcGZlYXR1cmVtYXNrCj4gICAgICA0Mjk0OTUw
OTExCj4KPiBBZnRlcjoKPgo+ICAgICAgJCBtb3JlIC9zeXMvbW9kdWxlL2FtZGdwdS9wYXJhbWV0
ZXJzL3BwZmVhdHVyZW1hc2sKPiAgICAgIDB4ZmZmZmJmZmYKPgo+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2ln
bmVkLW9mZi1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4KPiAtLS0KPiB2
MjogQWRkcmVzcyByZXZpZXcgY29tbWVudHM6IFJlbmFtZSBoZXggdG8gaGV4aW50LCBhbmQgcGFk
IHNpemVzCj4KPiAgIGluY2x1ZGUvbGludXgvbW9kdWxlcGFyYW0uaCB8ICA3ICsrKysrKy0KPiAg
IGtlcm5lbC9wYXJhbXMuYyAgICAgICAgICAgICB8IDE3ICsrKysrKysrKy0tLS0tLS0tCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tb2R1bGVwYXJhbS5oIGIvaW5jbHVkZS9saW51eC9tb2R1
bGVwYXJhbS5oCj4gaW5kZXggM2VmOTE3ZmYwOTY0Li5jZmY3MjYxZTk4YmIgMTAwNjQ0Cj4gLS0t
IGEvaW5jbHVkZS9saW51eC9tb2R1bGVwYXJhbS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9tb2R1
bGVwYXJhbS5oCj4gQEAgLTExOCw3ICsxMTgsNyBAQCBzdHJ1Y3Qga3BhcmFtX2FycmF5Cj4gICAg
KiB5b3UgY2FuIGNyZWF0ZSB5b3VyIG93biBieSBkZWZpbmluZyB0aG9zZSB2YXJpYWJsZXMuCj4g
ICAgKgo+ICAgICogU3RhbmRhcmQgdHlwZXMgYXJlOgo+IC0gKglieXRlLCBzaG9ydCwgdXNob3J0
LCBpbnQsIHVpbnQsIGxvbmcsIHVsb25nCj4gKyAqCWJ5dGUsIGhleGludCwgc2hvcnQsIHVzaG9y
dCwgaW50LCB1aW50LCBsb25nLCB1bG9uZwo+ICAgICoJY2hhcnA6IGEgY2hhcmFjdGVyIHBvaW50
ZXIKPiAgICAqCWJvb2w6IGEgYm9vbCwgdmFsdWVzIDAvMSwgeS9uLCBZL04uCj4gICAgKglpbnZi
b29sOiB0aGUgYWJvdmUsIG9ubHkgc2Vuc2UtcmV2ZXJzZWQgKE4gPSB0cnVlKS4KPiBAQCAtNDQ4
LDYgKzQ0OCwxMSBAQCBleHRlcm4gaW50IHBhcmFtX3NldF91bGxvbmcoY29uc3QgY2hhciAqdmFs
LCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCk7Cj4gICBleHRlcm4gaW50IHBhcmFtX2dl
dF91bGxvbmcoY2hhciAqYnVmZmVyLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCk7Cj4g
ICAjZGVmaW5lIHBhcmFtX2NoZWNrX3VsbG9uZyhuYW1lLCBwKSBfX3BhcmFtX2NoZWNrKG5hbWUs
IHAsIHVuc2lnbmVkIGxvbmcgbG9uZykKPiAgIAo+ICtleHRlcm4gY29uc3Qgc3RydWN0IGtlcm5l
bF9wYXJhbV9vcHMgcGFyYW1fb3BzX2hleGludDsKPiArZXh0ZXJuIGludCBwYXJhbV9zZXRfaGV4
aW50KGNvbnN0IGNoYXIgKnZhbCwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApOwo+ICtl
eHRlcm4gaW50IHBhcmFtX2dldF9oZXhpbnQoY2hhciAqYnVmZmVyLCBjb25zdCBzdHJ1Y3Qga2Vy
bmVsX3BhcmFtICprcCk7Cj4gKyNkZWZpbmUgcGFyYW1fY2hlY2tfaGV4aW50KG5hbWUsIHApIHBh
cmFtX2NoZWNrX3VpbnQobmFtZSwgcCkKPiArCj4gICBleHRlcm4gY29uc3Qgc3RydWN0IGtlcm5l
bF9wYXJhbV9vcHMgcGFyYW1fb3BzX2NoYXJwOwo+ICAgZXh0ZXJuIGludCBwYXJhbV9zZXRfY2hh
cnAoY29uc3QgY2hhciAqdmFsLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCk7Cj4gICBl
eHRlcm4gaW50IHBhcmFtX2dldF9jaGFycChjaGFyICpidWZmZXIsIGNvbnN0IHN0cnVjdCBrZXJu
ZWxfcGFyYW0gKmtwKTsKPiBkaWZmIC0tZ2l0IGEva2VybmVsL3BhcmFtcy5jIGIva2VybmVsL3Bh
cmFtcy5jCj4gaW5kZXggOGU1NmY4YjEyZDhmLi40ODcyNjFlYjgzNmYgMTAwNjQ0Cj4gLS0tIGEv
a2VybmVsL3BhcmFtcy5jCj4gKysrIGIva2VybmVsL3BhcmFtcy5jCj4gQEAgLTIzMywxNCArMjMz
LDE1IEBAIGNoYXIgKnBhcnNlX2FyZ3MoY29uc3QgY2hhciAqZG9pbmcsCj4gICAJRVhQT1JUX1NZ
TUJPTChwYXJhbV9vcHNfIyNuYW1lKQo+ICAgCj4gICAKPiAtU1RBTkRBUkRfUEFSQU1fREVGKGJ5
dGUsCXVuc2lnbmVkIGNoYXIsCQkiJWhodSIsIGtzdHJ0b3U4KTsKPiAtU1RBTkRBUkRfUEFSQU1f
REVGKHNob3J0LAlzaG9ydCwJCQkiJWhpIiwgIGtzdHJ0b3MxNik7Cj4gLVNUQU5EQVJEX1BBUkFN
X0RFRih1c2hvcnQsCXVuc2lnbmVkIHNob3J0LAkJIiVodSIsICBrc3RydG91MTYpOwo+IC1TVEFO
REFSRF9QQVJBTV9ERUYoaW50LAkJaW50LAkJCSIlaSIsICAga3N0cnRvaW50KTsKPiAtU1RBTkRB
UkRfUEFSQU1fREVGKHVpbnQsCXVuc2lnbmVkIGludCwJCSIldSIsICAga3N0cnRvdWludCk7Cj4g
LVNUQU5EQVJEX1BBUkFNX0RFRihsb25nLAlsb25nLAkJCSIlbGkiLCAga3N0cnRvbCk7Cj4gLVNU
QU5EQVJEX1BBUkFNX0RFRih1bG9uZywJdW5zaWduZWQgbG9uZywJCSIlbHUiLCAga3N0cnRvdWwp
Owo+IC1TVEFOREFSRF9QQVJBTV9ERUYodWxsb25nLAl1bnNpZ25lZCBsb25nIGxvbmcsCSIlbGx1
Iiwga3N0cnRvdWxsKTsKPiArU1RBTkRBUkRfUEFSQU1fREVGKGJ5dGUsCXVuc2lnbmVkIGNoYXIs
CQkiJWhodSIsICBrc3RydG91OCk7Cj4gK1NUQU5EQVJEX1BBUkFNX0RFRihzaG9ydCwJc2hvcnQs
CQkJIiVoaSIsICAga3N0cnRvczE2KTsKPiArU1RBTkRBUkRfUEFSQU1fREVGKHVzaG9ydCwJdW5z
aWduZWQgc2hvcnQsCQkiJWh1IiwgICBrc3RydG91MTYpOwo+ICtTVEFOREFSRF9QQVJBTV9ERUYo
aW50LAkJaW50LAkJCSIlaSIsICAgIGtzdHJ0b2ludCk7Cj4gK1NUQU5EQVJEX1BBUkFNX0RFRih1
aW50LAl1bnNpZ25lZCBpbnQsCQkiJXUiLCAgICBrc3RydG91aW50KTsKPiArU1RBTkRBUkRfUEFS
QU1fREVGKGxvbmcsCWxvbmcsCQkJIiVsaSIsICAga3N0cnRvbCk7Cj4gK1NUQU5EQVJEX1BBUkFN
X0RFRih1bG9uZywJdW5zaWduZWQgbG9uZywJCSIlbHUiLCAgIGtzdHJ0b3VsKTsKPiArU1RBTkRB
UkRfUEFSQU1fREVGKHVsbG9uZywJdW5zaWduZWQgbG9uZyBsb25nLAkiJWxsdSIsICBrc3RydG91
bGwpOwo+ICtTVEFOREFSRF9QQVJBTV9ERUYoaGV4aW50LAl1bnNpZ25lZCBpbnQsCQkiJSMwOHgi
LCBrc3RydG91aW50KTsKCkFsbCBvdGhlciBpbmRlbnRhdGlvbnMgdXNlcyB0YWJzLCBvbmx5IHRo
ZSBsYXN0IG9uZSBzZWVtcyB0byB1c2UgYSAKc3BhY2UuIElmIHlvdSB0b3VjaCB0aGlzLCB0aGVu
IG1heWJlIG1ha2UgaXQgY29uc2lzdGVudCBhcyB3ZWxsLgoKQXBhcnQgZnJvbSB0aGF0IGxvb2tz
IGdvb2QgdG8gbWUsCkNocmlzdGlhbi4KCj4gICAKPiAgIGludCBwYXJhbV9zZXRfY2hhcnAoY29u
c3QgY2hhciAqdmFsLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCkKPiAgIHsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
