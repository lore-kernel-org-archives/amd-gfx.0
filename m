Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8ACC00454
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB81207FD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB81207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E430A6E432;
	Mon,  9 Dec 2019 12:20:20 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD8C6E432
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 12:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8bXD6j4oVzj3gexJDg3bkgYIslx019lD8fkTVJoIprmiOqSnCYTpWE0lRac+ljDBVWoaUiG8ZJ7BaTmiY16GzHCRlhvyVXWdZ2hsWAOK7aJ0v2XVGxQxeionu/jI7yrAEQy2lKq+V4hzRf4icKtQCAJYZTbJ9Bh1MF87n5w+tLJWfWF6pHSsy9B0+HyfvQGbVg6jHjShdoSZ72gb+sERj/PpTPKQWMrp6zNT3Gs38TC1318WXJGFPmQMsCVzXIfDlbTlHPSA+SsEKnZIOZOc7eUlTmO2f75lQWxttcuPFLSli5B6zQukgibZ5RGsY6rKq30dyuzzBCO1r1SlrvVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pSXzQ+DPqMb7bzqMYFa1dC4v5nGxTwHTO+GD9pxE/E=;
 b=b+wHAs7sLCaTE8kt0bb2QwXDWr7jRFokN3yHW1s/aCU6iVVBmoOGQSbPwRfRx9ekSWE+X9/N5ca7CRigNTRo3+LD/eD5/FtnQKQHQ51JEQXAcXdohqNuNHhYayADifXAyZbtkrdLgRS21HImDV64ccpCK18kSxnatjbXtkpIt7hP6ZygVSHVkLyjqiOx99HlWHru8ymxUohz7uak3e6AJmfUhOLVlzO4y8H7lbx445eE1/Duwc3TF1KefIo+K6ZV384i4S4tUFi1wq6/aZ6idU5+PgQrSjJxSSAoQxG5EuyOgwTz21pzcSBzsil9C1mi2Yunv+Y3+2QXaqY7BzzUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1322.namprd12.prod.outlook.com (10.168.235.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 12:20:17 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 12:20:17 +0000
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191206173304.3025-1-nirmoy.das@amd.com>
 <20191206173304.3025-4-nirmoy.das@amd.com>
 <6cc23df3-97f7-f961-12f3-d99677cd5304@gmail.com>
 <c857555c-601e-04d1-adbf-f2219c3e4e11@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <86d30760-8f27-1c42-f914-b512c9a3a0f1@amd.com>
Date: Mon, 9 Dec 2019 13:20:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <c857555c-601e-04d1-adbf-f2219c3e4e11@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e9597bf-f46e-40d1-3ebb-08d77ca226a0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1322:|DM5PR12MB1322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB132271310D528F760226CC8683580@DM5PR12MB1322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(199004)(189003)(6636002)(6486002)(229853002)(66556008)(66476007)(66946007)(2906002)(6512007)(6666004)(186003)(110136005)(6506007)(53546011)(52116002)(36756003)(305945005)(86362001)(5660300002)(4326008)(2616005)(31686004)(31696002)(8936002)(316002)(2870700001)(478600001)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1322;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxLX48bFEcgYshlR03PmN4Hj1V2ZBFrjUxelh4HAggRtuOmmRh2i6pfuV1An8ZN4ozoTqQ7IsDvW0ty9E1ir6nQx00sdbTvNHdi4ryFaylVSofPievi5yT2KpEYDOcKzxLCbIaOgDh4M86O/0TgBHus/THkCq47dNTDMOc0jF9c//lYMQtNEU0KtkIESQOZWeOlWXsGGlRDjc5X46+LWW1hU3Ms7g0SpOBRJf6T+jkACNRpOEfZnRys3oQWfPMRTN1HHunoM0VrTBZPJw6j06bMhx5TEnXEllVLMTKp8yN2ekTGnYu48HZCOxPbSsNjKMMRiE7nvoPnuQ5N2JPWrMJV5xwuuMyHvaLpj7w4/HN0B12BOOaBuwBMLUuhzXyXsySm3zsvWFF3ay2IiY7w9wHOu161q5Y9Br2stzHx2Z7kptedlO7XmzUdG8iAANgJy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9597bf-f46e-40d1-3ebb-08d77ca226a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 12:20:17.3325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY/o2JkqWl49sr1FwuZYeKML5leAuNA9olGMeKq0ExmwALuAyviKf+Xq7D+sdoW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1322
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pSXzQ+DPqMb7bzqMYFa1dC4v5nGxTwHTO+GD9pxE/E=;
 b=X2MmhJt2APf2qkvqS3W6iQhDUsoLnLZQgnv7FMlzvLxj9JPEYq/J+akU+6medU4Nwh0CSYal5gltJyku0KnpU/1iUzuh7NDMjljqiVvQyV2H07JYwCdfJBJAuri/KNke1zPV6MWF3bDccJAbhjh3pZMvD7vEmXeKYrHKtnZzOuc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVzLCB5b3UgbmVlZCB0byBkbyB0aGlzIGZvciB0aGUgU0RNQSBhcyB3ZWxsIGJ1dCBpbiBnZW5l
cmFsIHRoYXQgbG9va3MgCmxpa2UgdGhlIGlkZWEgSSBoYWQgaW4gbWluZCBhcyB3ZWxsLgoKSSB3
b3VsZCBkbyBpdCBsaWtlIHRoaXM6CgoxLiBDaGFuZ2UgdGhlIHNwZWNpYWwgY2FzZSB3aGVuIHlv
dSBvbmx5IGdldCBvbmUgc2NoZWR1bGVyIGZvciBhbiBlbnRpdHkgCnRvIGRyb3AgdGhlIHBvaW50
ZXIgdG8gdGhlIHNjaGVkdWxlciBsaXN0LgogwqDCoMKgIFRoaXMgd2F5IHdlIGFsd2F5cyB1c2Ug
dGhlIHNhbWUgc2NoZWR1bGVyIGZvciB0aGUgZW50aXR5IGFuZCBjYW4gCnBhc3MgaW4gdGhlIGFy
cmF5IG9uIHRoZSBzdGFjay4KCjIuIENoYW5nZSBhbGwgY2FsbGVycyB3aGljaCB1c2UgbW9yZSB0
aGFuIG9uZSBzY2hlZHVsZXIgaW4gdGhlIGxpc3QgdG8gCnBhc3MgaW4gcG9pbnRlcnMgd2hpY2gg
YXJlIG5vdCBhbGxvY2F0ZWQgb24gdGhlIHN0YWNrLgogwqDCoMKgIFRoaXMgb2J2aW91c2x5IGFs
c28gbWVhbnMgdGhhdCB3ZSBidWlsZCB0aGUgbGlzdCBvZiBzY2hlZHVsZXJzIGZvciAKZWFjaCB0
eXBlIG9ubHkgb25jZSBkdXJpbmcgZGV2aWNlIGluaXQgYW5kIG5vdCBmb3IgZWFjaCBjb250ZXh0
IGluaXQuCgozLiBNYWtlIHRoZSBzY2hlZHVsZXIgbGlzdCBjb25zdCBhbmQgZHJvcCB0aGUga2Nh
bGxvYygpL2tmcmVlKCkgZnJvbSB0aGUgCmVudGl0eSBjb2RlLgoKUmVnYXJkcywKQ2hyaXN0aWFu
LgoKQW0gMDguMTIuMTkgdW0gMjA6NTcgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAxMi82LzE5IDg6
NDEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDA2LjEyLjE5IHVtIDE4OjMzIHNj
aHJpZWIgTmlybW95IERhczoKPj4+IGVudGl0eSBzaG91bGQgbm90IGtlZXAgY29weSBhbmQgbWFp
bnRhaW4gc2NoZWQgbGlzdCBmb3IKPj4+IGl0c2VsZi4KPj4KPj4gVGhhdCBpcyBhIGdvb2Qgc3Rl
cCwgYnV0IHdlIG5lZWQgdG8gdGFrZSB0aGlzIGZ1cnRoZXIuCj4KPiBIb3cgYWJvdXTCoCBzb21l
dGhpbmcgbGlrZSA/Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dmeC5oIAo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5o
Cj4gaW5kZXggMGFlMGEyNzE1YjBkLi5hNzFlZTA4NGI0N2EgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCj4gQEAgLTI2OSw4ICsyNjksMTAgQEAgc3RydWN0IGFt
ZGdwdV9nZnggewo+IMKgwqDCoMKgwqDCoMKgIGJvb2zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVfZndfd3JpdGVfd2FpdDsKPiDCoMKgwqDC
oMKgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNwX2Z3X3dyaXRlX3dhaXQ7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdw
dV9yaW5nIGdmeF9yaW5nW0FNREdQVV9NQVhfR0ZYX1JJTkdTXTsKPiArwqDCoMKgwqDCoMKgIHN0
cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqZ2Z4X3NjaGVkX2xpc3RbQU1ER1BVX01BWF9HRlhfUklO
R1NdOwo+IMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fZ2Z4X3JpbmdzOwo+IMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBhbWRncHVfcmluZyBjb21wdXRlX3JpbmdbQU1ER1BVX01BWF9DT01QVVRFX1JJTkdTXTsKPiAr
wqDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAKPiAqY29tcHV0ZV9zY2hlZF9s
aXN0W0FNREdQVV9NQVhfQ09NUFVURV9SSU5HU107Cj4gwqDCoMKgwqDCoMKgwqAgdW5zaWduZWTC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9jb21wdXRl
X3JpbmdzOwo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfaXJxX3NyY8KgwqDCoMKgwqDC
oMKgwqDCoMKgIGVvcF9pcnE7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9pcnFfc3Jj
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpdl9yZWdfaXJxOwo+Cj4KPiBSZWdhcmRzLAo+Cj4gTmly
bW95Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
