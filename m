Return-Path: <SRS0=6ZMW=Z6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F888C43603
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Dec 2019 19:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D624E20663
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Dec 2019 19:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D624E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF7F89A9A;
	Sun,  8 Dec 2019 19:57:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFCB89A9A
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Dec 2019 19:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUUBWnJ7gaJYkzhmXPPNJp9rd1CRTfglv6paAkaQrvgD9n/juEDaTYoLUcyWxkWkBZw++b15vCAAJh0L8SKU3jiOmqqXGdj5b6ebXRk2XUExBte/I7KSOoP1aQ5R5PkXAbnn7lhU0pfUZPSsTmeNzR9c4imiieDYT9B5TYAAZqW660fwYfOj7u9xTuu5WPumraQz2ah0Mx1WZUaXPvLcxL/gLdFP8artRkOWEL5EZmb8cIdL/rMINPwqLx0sJ34Pi4HQ0lEKa9eKaqFNHW9VoX7Loqi6yS2bIp3cLyxBMp5F4eefMwZM2v58Ynr+sPWkfJNw6aZKRJuQjGNn95Ew+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W36h0McxcrOLrDEX2yQmtltYE8Ilj4s0eEtsCMorpcU=;
 b=nDWvX2f16P0AjCOzg+t0E2LOZdQTyI9cg4Q8W5FcwQxnzzlCA7b60ZEiK8077K9SBlT+zetRQUufFqbYAxPU+ajoTSFpgperpPPaTqIWdD0HKuDJHEq372xI49Sf+SRZL7+jpt4Sxqv9uE8ikuj8YVhBymnV+SvG6nug32vLA1VTKsRAu86o+iVVOWqVMcFjXo6mCJ+pZDROLd4LIBL3SgXS2BhYdLR3Z93VT9y7tveLgphen34ZdsvMCHsPteirMyj/MuOp1+X2eiZH4dBeOqVAyNoWITQgy66pY6wVlr2lgEhweCk/NRJJSvIhncxdxNbcZjgs/IFvQmb7x8BHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1228.namprd12.prod.outlook.com (10.168.237.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Sun, 8 Dec 2019 19:57:02 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2516.018; Sun, 8 Dec 2019
 19:57:02 +0000
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191206173304.3025-1-nirmoy.das@amd.com>
 <20191206173304.3025-4-nirmoy.das@amd.com>
 <6cc23df3-97f7-f961-12f3-d99677cd5304@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c857555c-601e-04d1-adbf-f2219c3e4e11@amd.com>
Date: Sun, 8 Dec 2019 20:57:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <6cc23df3-97f7-f961-12f3-d99677cd5304@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0046.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::23) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f09:f600:d56c:be3f:3532:7289]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a69fa056-319e-4128-7bf8-08d77c18ca5b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1228:|DM5PR12MB1228:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1228CDDE103F6EAEB2B7EFBD8B590@DM5PR12MB1228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0245702D7B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(52116002)(76176011)(53546011)(65956001)(2616005)(36756003)(6506007)(99286004)(186003)(316002)(58126008)(50466002)(4326008)(31696002)(6512007)(31686004)(478600001)(4744005)(8936002)(81156014)(6636002)(229853002)(66476007)(66946007)(2870700001)(305945005)(66556008)(2906002)(5660300002)(6486002)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1228;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48VaTrzpmI2dvHpzF/Wzmph5dT0RGwwJEVd2nvkrnCBMM37URX6//dphpEyiIO6SpaDRakQl34MNsrDWanVlsKjh0iBHIzYj4n2/AdVB8OBx+Nd3sBSXLAhy5IkFrXyR4fJ7SBohXMKiIOJlCmlp7hQ4uBhhpbl42+JPUBHZslF8/00DMSy1adEXo0S/8DCiEc70XuYMpUcLebSgE9+D562VOQJOomZ1NXpjyuILZ6X3VmGs237RxDFPScJgPu3IPna/O/vbKg3tTzdMG/L1JtTItTL3f3KY97tSIWgqhqweFMOAND4qGox7puspOZNND9S4aefnk8A1+FLsz+s5bTFnlpmrLoiOg9EdvGSPYAaEgwnmMM7HWB1K8zOlMveqdl4OjQVY01dJf7A+gqf0XzSnQkjJrrrKmY4AZN0MnjLWKmmf6QGH9WBuFGGkWanT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69fa056-319e-4128-7bf8-08d77c18ca5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2019 19:57:02.7668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfdG0ggDtjRVsoFNOBMf9kQsARDER0iozWSwwSE5xlkmxwU2pKOFfGfEvVqOOPXAgRZtT2ohzQ2e/qHhGlZ9xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1228
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W36h0McxcrOLrDEX2yQmtltYE8Ilj4s0eEtsCMorpcU=;
 b=OnSAeAM5WE/OJpWla3SmsapWjSUBSgDRn5Z/xWMiL1kPiczYnnXGoUit4SkMS12ytbLd09dCC6OZy25rW1dmB8bWS+4sv+Y4LXAISMeV6sqFnnwsYcQPZEB+JZUdL5kfVDnhGMHjMHAdvh0Wfv80Myx8ciCfZyAOvp1Ii0fBURM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
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

Ck9uIDEyLzYvMTkgODo0MSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNi4xMi4x
OSB1bSAxODozMyBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IGVudGl0eSBzaG91bGQgbm90IGtlZXAg
Y29weSBhbmQgbWFpbnRhaW4gc2NoZWQgbGlzdCBmb3IKPj4gaXRzZWxmLgo+Cj4gVGhhdCBpcyBh
IGdvb2Qgc3RlcCwgYnV0IHdlIG5lZWQgdG8gdGFrZSB0aGlzIGZ1cnRoZXIuCgpIb3cgYWJvdXTC
oCBzb21ldGhpbmcgbGlrZSA/CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dmeC5oIApiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZngu
aAppbmRleCAwYWUwYTI3MTViMGQuLmE3MWVlMDg0YjQ3YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZnguaApAQCAtMjY5LDggKzI2OSwxMCBAQCBzdHJ1Y3QgYW1kZ3B1X2dm
eCB7CiDCoMKgwqDCoMKgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lX2Z3X3dyaXRlX3dhaXQ7CiDCoMKgwqDCoMKgwqDCoCBi
b29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNwX2Z3X3dyaXRlX3dhaXQ7CiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgZ2Z4
X3JpbmdbQU1ER1BVX01BWF9HRlhfUklOR1NdOworwqDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ3B1
X3NjaGVkdWxlciAqZ2Z4X3NjaGVkX2xpc3RbQU1ER1BVX01BWF9HRlhfUklOR1NdOwogwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG51bV9nZnhfcmluZ3M7CiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
Y29tcHV0ZV9yaW5nW0FNREdQVV9NQVhfQ09NUFVURV9SSU5HU107CivCoMKgwqDCoMKgwqAgc3Ry
dWN0IGRybV9ncHVfc2NoZWR1bGVyIAoqY29tcHV0ZV9zY2hlZF9saXN0W0FNREdQVV9NQVhfQ09N
UFVURV9SSU5HU107CiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX2NvbXB1dGVfcmluZ3M7CiDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmPCoMKgwqDCoMKgwqDCoMKgwqDCoCBlb3BfaXJxOwog
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9pcnFfc3JjwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cHJpdl9yZWdfaXJxOwoKClJlZ2FyZHMsCgpOaXJtb3kKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
