Return-Path: <SRS0=G9GP=6J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608F1C54FCB
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2020 16:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0633D20714
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2020 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xF4cIvJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0633D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9864289D7C;
	Sat, 25 Apr 2020 16:28:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A4C89D7C
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2020 16:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdfOZlCb4ofYIIPQr9AGjTDlXDHpPcxz+AwTpqU2OD3PmgMogWY/2pX/bcBqcI7Qvd8BA+UuQLmhBFIsV7phLzfEyDwSju05KftcpWgapLJE8Zzn1uDKJbcxsefmkYSNEGItxLs3qI5g0KkL4xYzU4OjLEH4YVLnOWWrLz/NpnTjyV1CKjxu/MhN4l+gAWbEM32oqwhlfJ8Y3cjSsdKMsSY8BPeWr6BDOo3fvXUzlXYl1eTJjtSa+e3D9XF4rIWEdQGcJwi33QSigZnILqOaZQM4AvVRMnEhypKIzvIUB9Nt4De6c07DxDbz5yDJ9jNoDdU/2kHJ+mlctplb2nXN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMcFejOEuTZxvIyFAoogZnqgFwyrLzlFhl/CGNP7CRo=;
 b=XC0zLwR4wZxOxwyFTx8iJykYDaxV/JGseXSJT/YpkJFtyPjKYuhiWvIQd78FNiPscbSZjFiRICfIisSK9kqUqFJKffmhJs4XEdLr7zj2GttrCwhKMV0PLB1mw2w1hqyHiU+QK47wlN4sKnTJ31eGs6PX+qu5d1KRGqk25TK/t1SXgCpQYRbzg4kCWdCnbRJRPc0XUHx1PcupAFCFCjKjTtPTT1VY0NA51OSZfS739B2vMIjN0ZXyoLytTLmSg2qhmq9jD08xYtrJhuMm8RF4cKlHv7f2WQJeFRtTcImwim796+DBwhjKpsjtGaqKmUh+FKi3Ickm27NS3zcnLRgD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMcFejOEuTZxvIyFAoogZnqgFwyrLzlFhl/CGNP7CRo=;
 b=xF4cIvJGSv6z7cuWLRSGdShzSAFrnfPLUAyuKHIcf7VDketrpWuASZKspeKoqx3NWKfh7KhqnPMFEA3hLdpC5qLtdg5cNa7eeGixz2B4c7PSpzeSpdtfO+oFcYGtWEj1v9o40qb1iMpUdfjTeo/U3Sp/wIWU1CyngWc+FTFCAf0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MW2PR12MB2570.namprd12.prod.outlook.com (2603:10b6:907:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sat, 25 Apr
 2020 16:28:26 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46%5]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 16:28:25 +0000
Subject: Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <e1ffd447-4445-3532-d5b6-7505e2f1c229@amd.com>
Date: Sat, 25 Apr 2020 18:28:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
Content-Language: fr
X-ClientProxiedBy: PR3P192CA0030.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::35) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.200] (91.174.76.219) by
 PR3P192CA0030.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Sat, 25 Apr 2020 16:28:24 +0000
X-Originating-IP: [91.174.76.219]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b64ae843-b741-4978-a3f0-08d7e935ad8f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2570:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2570389F42A3AA657BC3657C8DD10@MW2PR12MB2570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(86362001)(53546011)(52116002)(6666004)(31696002)(81156014)(8936002)(5660300002)(26005)(4744005)(8676002)(36756003)(66476007)(16576012)(186003)(16526019)(2906002)(66556008)(316002)(478600001)(110136005)(966005)(956004)(6486002)(31686004)(66946007)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUFbO/mo7nrxr8+6RkW0QWGdEQaMy+1IgVGKOLc5tKpsBrmBUwusD4CoWYu4y+B3rOEsB3WkHvq3kku5r7yPEt/LrxFpI2CiT/PWV597zoCPWU53+om9K1KiVnJTSLHNf8NPkEKZlrFTyRHWYMMgt8QDJvCI70h/7/QN6RM+tHI5PxU85pX+srdpq63DamqoK2FBhnUgNnsbSivJXNR5wRoZcQqfXoCO4liT537jy/UlsVqPAo3tVAnE5Yg1kSMroG8Xtm/1gui8KEsHFK8wlWssLoxE2QBM0gVxK0vyRV78h9+ydyWqs1V0/pr0eXG4FX1EqMr/kymloSd4HO1uHNhbdB9gnHYJsk0TCvJC1St2WZ+heAqg2JOJzzZ5ChXRqKvRmq7vnXnyHPeh0BZbaIIbI3BtSLaUFdJiwZd+GAgxygPZY6pTkkWqxR1E/s+bAKM7kK+cTo8CvosCsIf2J476tozjJUNSU880e/0dmBw=
X-MS-Exchange-AntiSpam-MessageData: oZy5tIK6YKg5y9f9bwzsVHOBCnVoxorwbQQW9K8Z4Fh77mD1n40Tvft9VSpP8UtKVFoKHv6qyNcCz34SLZLbBzrlWYvhepJuXsPoq2CsDrkm/T+7a8nrNGw5zfA7Rv4V2AyZhzgFDLe0HWYyRCBTLBouGqjyur0fAxSENr4L8K16e2o2RdXUVnnRn6a4bM3Uhmd1rV4I2bBnGbVvu3DgOupGVRxFxhgucKAPUFqGAmq8GEtRdgWuxmbuaMMFAz5S53C4jVhwakPw8gv0cOiLXLF3jZkUYWOARztP9O8ILyGO0GGQGoTQCbdwoPOi8i1x+JENDh4yeDGJBgMcC3o2M5zfBPyVheoeKTm8EyfbVi+251664CKzythGGFyZelo5VjwuG616LPj2BFhz9a1SssknJWrRgOxxncYgmE0A4qkVQKLmXUaBcQxzjpp3hfyGyQOzsIIkHb+QnM2sJd2zQduJ0kK0tVrCmD9nYVz13XmWPw9griRKDrqNlM90w8TdxaJ2Et42GMMFGJacHJk5AlM4taME+Nfuo+H3WS9ReM4MPaCImBdjeSiTe3V2fyUwlJlKnc1nhieuzNbKUwrzlPUo05vdDGPMK/07xC0XSxk6KJcIsqK2F8k3HKMESNY+j2vTSB38kazPg/IiXZkC8FqH3oqYxcoEhb2xFPNzFK89IZh0k4qkV4239A/gJ8rJpFoT0Q8agQ1J1zl/1KksYtOEtjysc9np8CJNwWn3jH61vH+A6S6XGcgFyiWqvJytijQBgB8nTD4RsvS3bm7D3RhSwdkzu4Vg17QLJg7vuQU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64ae843-b741-4978-a3f0-08d7e935ad8f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 16:28:25.6271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+qjAXGL7OmTofrZ23c6zRc8YFNwWWZydax631LDTGhydslOTHGllbQKtMRnuF3rklMoHWRmAfTBZhrMH8V4Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2570
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

SGkgTWFyZWssCgpXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCBJIGNvdWxkIHJlcGxheSBhIHRyYWNl
ICh0aGF0IHVzdWFsbHkgY2F1c2VkIGEgc2RtYQp0aW1lb3V0IG9uIHRoZSBmaXJzdCBydW4pIHNl
dmVyYWwgdGltZXMgaW4gYSByb3cgd2l0aG91dCBhbnkgaXNzdWVzLgoKU28geW91IGNhbiB0YWcg
dGhlIGNvbW1pdCBhczoKVGVzdGVkLWJ5OiBQaWVycmUtRXJpYyBQZWxsb3V4LVByYXllciA8cGll
cnJlLWVyaWMucGVsbG91eC1wcmF5ZXJAYW1kLmNvbT4KClRoYW5rcywKUGllcnJlLUVyaWMKCgoK
T24gMjUvMDQvMjAyMCAxMDo1MiwgTWFyZWsgT2zFocOhayB3cm90ZToKPiBUaGlzIHNob3VsZCBm
aXggU0RNQSBoYW5ncyBvbiBnZngxMC4KPiAKPiBNYXJlawo+IAo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
