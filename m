Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FFEC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 10:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878EB2072E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 10:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SWaaCORf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878EB2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DC46E075;
	Mon, 17 Aug 2020 10:05:02 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4646E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 10:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzYC78y/t3F7lvmQqklXdQJu5mUpJHOn9vDEEzS3MDrebSZyIcLkQumg97jFQS7z4AVKpkA+7vVVcKIoLbXvCIFvzIjm8Z12C3nJelDWsqWvvUrVJkJbjH0t6RtJu1f8RzXXOGYZBKt37vSPtY15xzxW3BQeGNIXlcpXlTlsbSAugRh+GcyhTZfFEmXn5D8DjQkB4/wuH0BPqEynDbp+cizQ+/vcxgc78fQ7ovsev+dg1QZgfUaWCnToQwEpF0zNXQAEUWOkJ2nJZnFmuTThYD1SlE3vRU4VTG2K2muItv3bg4LHMq1lXqd6FDaY+sC3kxO8+R5tBg0/tlnsKVnQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n45bNhp+FPDeaG+yD3qptmxnSuIfB6EWWmn9ppGkTkE=;
 b=BIRxXg4Zv294E3YnsW/6y1qI2kJE1CdokQP4YNy/2bc11QvZvM7y5pamcYDDGd2S69MhUd2GSLnT8Jh2L2G/d0KpWHJJsO8UGcCZIlX48v6YK81QJjzW3aMiJMD3Ur60qauxqXS9qDI/bij6hmxMc1O74zITLk/O+6gAdReI0jC5vJjCVWNEvn2e7lSvOopCKshD7MmGz9AZvWSxrkTkSydJqKU5LMx+0lXG8wqYWfe63ALVD+Ilw5a7Hvx4bKrc2+Pis3TdhLJV+VbHwAqMwgIfVPSS+F5yOm2S2rV7KUDlY+JwTB3duMg9J8EKvuhunGZHdet9C32853DtLCxLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n45bNhp+FPDeaG+yD3qptmxnSuIfB6EWWmn9ppGkTkE=;
 b=SWaaCORfrafjeKQhcA5nO0t1Bk0hd/s42DiatO8M7a9gYoqt+FNXFXJPLbspd2Qf+2OnUfd1XSWGJcXjKB3uieDBKsGBcn1J5KA6X3UhTfrk44FVHxirDR2DYYpHm6z76YlzFmbFaTNQWCmuu4Awb8f+dp+hm0hINLFAOzuXgVo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 10:04:59 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 10:04:59 +0000
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_bo_release_notify() comment error
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200817073535.699-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <aedc8585-f9a6-985b-1c71-9c5f87ca07ae@amd.com>
Date: Mon, 17 Aug 2020 12:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817073535.699-1-kevin1.wang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:205::17)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:205::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 10:04:57 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20c6b4ca-d48f-44e9-66e4-08d84294ffc7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4318EE79B7BCCD93007BECF1835F0@MN2PR12MB4318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTc1Qtnp47jsi2SEqBoKdtvdGx+dGqLEd6DLGN2/WqjQZtJMy+WIVFmI4OAw4NExX7rAAHldVaXy76JaCP7JjsQB6YSfhOdPVcLJ9bEdRbcKQmyPVgwC8/DIPLrIdn6O/Tyx0YCb2YwRq2/xtxo7ajDFmPQN9+MQt0O1S7ufekRLc2X4mqdTVA89zSttGgmdrnh9JIJxZ9ichhnu5PhflbRotaEJ+qdIgHE/hQM3RsAT+QADxVVzH40MHCzOYlRqZCPD1PDQq2wuJU0GOQZqcK73eh0cqHqFDE6qULZ4bZh72MefLq7FiCAgOh0GRd5bkj3mfWJibvHWwQhQ1uajYhQwj+9IDhOR9EuwDXM9cMM6E2HnFjkYFVYWHVeDhIrd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(4326008)(2906002)(6486002)(4744005)(36756003)(83380400001)(66946007)(66556008)(8676002)(66476007)(86362001)(31696002)(16526019)(2616005)(478600001)(52116002)(31686004)(316002)(6666004)(186003)(8936002)(5660300002)(66574015)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HGEfsIp1/8UFbQlCWFkau9Lgh3zT1aMwwVwsGXLYa1PqYqVacTYeIHAC3zLalwbR5gJoMGLJs/bJzAJtEfxfiye0bHMYwerF10niyiMR0N4CDzHF38khUMTAtar5QPE0Gd26butO/BRQlLgvX6FVDCYsyG8OHtDVqip/FnMwwGuZtIuzFZZLHkLKtUxyQIcGpsa3YSTc2Ze33k7Gfncb2AT8+t0Ko8rj4wVBj9GUC/rmRyyQCGg0qjotxooQrpQ+KfRQW0d98tbpOASkGm6HqCbSdMg7fpaXPx0PJEixkOtYmAvvuA5JBDlIIT66MXDmSCg8QGrzOQtQo6aGbxZVhcFLzIZJyXtoQ4sXHhul3nZtohl+uZHxaj/3G/hZZqWqTAnQWoE7zQPJKz3nzEaMGwsXLp6jxPfgIn8oKAhJCbUjDztwHlqe4I3dqje65tAYEtnNXG2GWogni3E7teMvaIEeMmqsQq6l0VQ/c37s88FDEnRZsA7JylADG4CK9NHAIwzPsMCUta0xPp22LtF46UA3WICVh+l8ALfw1jSbeJH6T+OIwud8ISLbck8G4gA9N9rywWuJmjJ5b3MN1XkjQjsRTLPoe2y+EvOc6gD/GgVRhQu1dfriBsieqXsBXWFJWOj8bQgULBq70b2SOGulIxqdedj1kl9E9zRZCVSyvr4JPwAg+X/KD7ta8u64i8KrFv6uNhKQ0XPD8zEvn0TFww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c6b4ca-d48f-44e9-66e4-08d84294ffc7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 10:04:59.2602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iE5OY/+g9e/pW5gvFZcR/bKd3DpIVXmT7Uq+u2WG0lnYTfvF95Ky42RDv6P8596n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDguMjAgdW0gMDk6MzUgc2NocmllYiBLZXZpbiBXYW5nOgo+IGZpeCBhbWRncHVfYm9f
cmVsZWFzZV9ub3RpZnkoKSBjb21tZW50IGVycm9yLgo+Cj4gU2lnbmVkLW9mZi1ieTogS2V2aW4g
V2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jCj4gaW5kZXggM2Q5NWIzZWRiNjM1Li40Y2I3NTBlZDY4NTEgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gQEAgLTEzMDEs
NyArMTMwMSw3IEBAIHZvaWQgYW1kZ3B1X2JvX21vdmVfbm90aWZ5KHN0cnVjdCB0dG1fYnVmZmVy
X29iamVjdCAqYm8sCj4gICB9Cj4gICAKPiAgIC8qKgo+IC0gKiBhbWRncHVfYm9fbW92ZV9ub3Rp
ZnkgLSBub3RpZmljYXRpb24gYWJvdXQgYSBCTyBiZWluZyByZWxlYXNlZAo+ICsgKiBhbWRncHVf
Ym9fcmVsZWFzZV9ub3RpZnkgLSBub3RpZmljYXRpb24gYWJvdXQgYSBCTyBiZWluZyByZWxlYXNl
ZAo+ICAgICogQGJvOiBwb2ludGVyIHRvIGEgYnVmZmVyIG9iamVjdAo+ICAgICoKPiAgICAqIFdp
cGVzIFZSQU0gYnVmZmVycyB3aG9zZSBjb250ZW50cyBzaG91bGQgbm90IGJlIGxlYWtlZCBiZWZv
cmUgdGhlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
