Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8CC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733682467A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aotTzvjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733682467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 209656F43B;
	Wed, 22 Jan 2020 09:31:17 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDA66F43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 09:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5Sk7SAZ9IgDm6BfnNwHXqriSiiZB6Em9TUg2ht9Ba01ZATQat4nDf9Vj8BqhiQqdQhTF1Fywm1vfy7J/Ze9W+A/x1FZqvpd1HoAKJ9NgPNHe9TE6I1e++oc1qLFE8r9Z+bPG77icWeym5sunwlhy8f3EKa03xW3DHBDDpkpeFBSH4vDdHDoiGEcTzp5/naLJxL/En2nA9cmBHU+x9qTRj85obLQ+h2eArAUydSeFPlh9/cSBfrrQhLMgKmlhzmN+UyKGHPUP094Bsjut7P1flS0PxBux7hiCKKgRV2gSBHzYcmLuBg7iWITSvtSLeepPX8VEsydZ7v1QBOFu2EaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Vy7kG519rb4sS3RBRYnbHMH56UjBB2O7yuuU+pk1P4=;
 b=jCEFkQNJA6xVV45WP/nY/+/MRcO+GHwHvPWV6srPeXv8GEvTY2s6/blXd38fc59fqWUdjrQrTGvjYt5QKmpxZPSeEoZBT9swFhPNRbN9FhgZRp3Q2nV0IvOSDMGd7BhhfvM9naBraybHW0zryVaRZoDBbcWTYhpUoyOtJvG2JcXD6j/Q2BBVHTohQxW3kptMidFb7bf6j7bsrCYf6wpNrE/njD/on9sB9Gvr+GBUptrRN1pmoITcKdgmWsbL+UDTL2IabToP/xCsOBrjwGmvP8tHj41u17BaPXwxIOz0XLNWf7IhSjfpKDOp1Ls/PsxtETu+Swu3slKBQRbfyjKIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Vy7kG519rb4sS3RBRYnbHMH56UjBB2O7yuuU+pk1P4=;
 b=aotTzvjT9SJXFxuuyGnL1hOjzQynCsnin0igzyevit4ChtQazvuuioHE7WqYV75KT3IUlmRfc5TsjZZ1Z+oLnrNe7rSwyJJ4IXM2jhnYpkxZ5eLHIQ+J8uLaI2NjUPJ6WcZwMtZ0HBtQgTiHyVRGIn7wNPrdDHUt5+iQEe4UMPM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1465.namprd12.prod.outlook.com (10.172.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Wed, 22 Jan 2020 09:31:14 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 09:31:14 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: individualize amdgpu entity allocation
 per HW IP
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200121165002.3709-1-nirmoy.das@amd.com>
 <3d159a30-f7f5-a4f7-b63a-26b9f5df0ec2@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <6fbc12e5-ded7-ebc6-f905-f75f8faf5e1d@amd.com>
Date: Wed, 22 Jan 2020 10:32:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <3d159a30-f7f5-a4f7-b63a-26b9f5df0ec2@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::31) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8]
 (2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8) by
 AM0PR01CA0126.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 09:31:10 +0000
X-Originating-IP: [2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a55c5c4a-3aaf-4500-90d7-08d79f1dd30a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1465:|DM5PR12MB1465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1465485D3CFC87B01F22F4788B0C0@DM5PR12MB1465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(189003)(199004)(4326008)(4744005)(8676002)(478600001)(5660300002)(53546011)(52116002)(16526019)(81166006)(36756003)(186003)(6666004)(31686004)(6486002)(8936002)(81156014)(2906002)(66476007)(66946007)(316002)(66556008)(2616005)(31696002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1465;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq0Thob0HK+/rV9oC8Y2Zxq2suDbMTmlLEB/jso0i8I9tvH8Z5JeLDZDjAhIQ42ih9UwjyiPo/XxdpTrUtJE4SAYJ5JkxSfxFV28p0Ku7i24pl+rpo4OlngZ1bGTPQT6v+11INOLjK3JvzsPZrtjU/x2QVWQDDZbxRKhR6haKsveDrU0JYENjOaaLU0Q2zgrAkWjzSXVFW+FIVJ5o1vIb1zIHOpBhSKs+XBibUrXAQLohjTO04IfqqR5B7OIqeH/nr8XZ7pZab62e6R4SA62hDjXHJRk0Fo2lDsoRVGG6Sq08aKxCnrLu9B/D3pdfLx3DUjJgidZj58RsQDpiynBDoxP6lJCGKKxJASaNDPu/8xpav1y3dbq1GMq2LGjqcxXa8B+KJkTrxGphFyA0dNuu1SPOXFs+Op6PAsw/e66JHzZNFZthoMfXtBz3xKuHl/p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55c5c4a-3aaf-4500-90d7-08d79f1dd30a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 09:31:14.2326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPqfiNwcIuLHeiSanynPCmZOPfrSDpWktHz6ZQ5GbOXt7PzekTdZm53A+72PaQ8qW/VOMZakpNysBKzV4KABiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1465
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEvMjIvMjAgMTI6MzQgQU0sIEx1YmVuIFR1aWtvdiB3cm90ZToKPgo+PiArCQlmb3IgKGog
PSAwOyBqIDwgYW1kZ3B1X2N0eF9udW1fZW50aXRpZXNbaV07ICsraikgewo+PiArCQkJc3RydWN0
IGFtZGdwdV9jdHhfZW50aXR5ICplbnRpdHkgPSAmY3R4LT5lbnRpdGllc1tpXVtqXTsKPj4gICAK
Pj4gLQkJa2ZyZWUoZW50aXR5LT5mZW5jZXMpOwo+PiAtCQllbnRpdHktPmZlbmNlcyA9IE5VTEw7
Cj4+ICsJCQlrZnJlZShlbnRpdHktPmZlbmNlcyk7Cj4+ICsJCQllbnRpdHktPmZlbmNlcyA9IE5V
TEw7Cj4+ICsJCX0KPj4gKwo+PiArZXJyb3JfY2xlYW51cF9lbnRpdHlfbWVtb3J5Ogo+ICJjbGVh
bnVwIiByZWZlcnMgdG8gc29tZXRoaW5nIHNwaWxsZWQsIG9yIHNvbWV0aGluZyB0byBiZSBjb2xs
ZWN0ZWQuCkl0IGlzwqAgY29sbGVjdGluZyBtZW1vcnkuCj4gKE9yIHdpbm5pbmcgaW4gYSB3YWdl
cmVkIGdhbWUgb2YgY2hhbmNlLikgQWxzbyBhdCAibW9kdWxlX2V4aXQiLCBtYXliZS4KPgo+IFRo
ZSBrZXJuZWwgaGFzIHRyYWRpdGlvbmFsbHkgdXNlZCAidW5yb2xsIiBhbmQgImZyZWUiIGZvciB0
aGlzLiBOb3csIHNpbmNlCj4geW91J3JlIHVucm9sbGluZyB0aGUgbG9vcCAobm90aWNlIHRoYXQg
aXQgc2l0cyBhZnRlciB0aGUgInJldHVybiAwOyIpLCB0aGVuCj4geW91IGNhbiBiYWNrdHJhY2sg
YW5kIG5hbWUgaXQgbGlrZSB0aGlzOgo+Cj4gRXJyb3JfdW5yb2xsX2ZyZWUxOgo+IAlmb3IgKCA7
IGkgPj0gMDsgaS0tKQo+IAkJZnJlZShteV9hcnJheVtpXSk7Cj4KSSBwcmVmZXIgdGhlIGV4aXN0
aW5nIHN0eWxlIG1ha2VzIGl0IG1vcmUgcmVhZGFibGUuCgoKUmVnYXJkcywKCk5pcm1veQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
