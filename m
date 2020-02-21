Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2A5C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 14:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ADD222C4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 14:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i/pM01VW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ADD222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82EE26F45D;
	Fri, 21 Feb 2020 14:35:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D486F45D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 14:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMPnCujGortOPKdQJTU9P6+/OMmaPw9U+DR0qwwjNxjVyf0OHzxf/Go3H2xna9DwsTFpspXr/0bYxNx9MI6aj+asZ+AZrYvCY9EInA3ezFqds42i/dAL4/6XIj6XBbiQr2Wz66AC66Zsl0oJW6M0LIFJaMfXkZLPuOfOqhv3sqVXaDPtuDBXPSOvVniwwPdllEbrD3qpXbzMPG3rsnfUP9lkOiA5E9VwdDRqiTz+AHIfUOdvtYeT2KkAD3FUcr5lbblni2YaBFCZtBEE4R4VR8AKDt/ZNSapV+rAHAbBQRBsqEdm9ts/KeLA0J9f4MKt4EmZ/5b1JF4RPV4PMXzi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xDCv3waoKJeDk+LycOSHYp5cj/dJyjdLhoTlE5UGgs=;
 b=a7bLcgybn04+POrG94cpSox9SkYXdvv9UvAqMbpBENYVMSvuO0a4rkfIkPtOv++swKYNQ315zkq22Di7RQNE6s1WW+VVN+/BXbfgBn9tZ51+Q38CRflIM0t/29ATTwQhzwojBfnXR4VIGRk+48GwodCgbmtKy/fFcZnRpzURwpZ9ttAEl7GT5rJ+6MpmUavDn3mcFCCYtuuj+S55Rk3JySA1Y8xCDli7/wscsR+M9nHiHXu5b5YCVF1n8pv9J1j3Nm+vQ+qDjqwa0bKQHcQGpUcoOeG8oW9jO7wQATMYmHSlo9BpIDIkm+c5JykNtJyWVmgIckn8CEnWusgHW6Z0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xDCv3waoKJeDk+LycOSHYp5cj/dJyjdLhoTlE5UGgs=;
 b=i/pM01VWYgGy7AphH/xXQQpwCJRfKpB7byrkJ1HS0T3CzQ3WKkRNA3jUVUWDkDQbm70GcL3IA8YSnezE38dlmUjhJzEKt8LZWKxMIUF9gNfAbRLp+fPV3tbMPvo5EDYAv44xnuJac/MZxLJEyLz211lP1zj58NfESOl9pMY5OJE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from CH2PR12MB3927.namprd12.prod.outlook.com (2603:10b6:610:2d::13)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Fri, 21 Feb
 2020 14:35:36 +0000
Received: from CH2PR12MB3927.namprd12.prod.outlook.com
 ([fe80::54a8:8b32:7a8f:488c]) by CH2PR12MB3927.namprd12.prod.outlook.com
 ([fe80::54a8:8b32:7a8f:488c%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 14:35:35 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: disable GFXOFF around debugfs access to
 MMIO
To: Huang Rui <ray.huang@amd.com>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
 <20200221143359.GF28698@jenkins-Celadon-RN>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <8256dab1-c0d0-fc88-cc3d-1185f42e1671@amd.com>
Date: Fri, 21 Feb 2020 09:35:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200221143359.GF28698@jenkins-Celadon-RN>
Content-Language: en-US
X-ClientProxiedBy: BN6PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:405:75::19) To CH2PR12MB3927.namprd12.prod.outlook.com
 (2603:10b6:610:2d::13)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR17CA0030.namprd17.prod.outlook.com (2603:10b6:405:75::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 14:35:34 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c4fb298-502b-41f0-108e-08d7b6db503c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4119:|CH2PR12MB4119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4119393D8CECE263A098AD91F7120@CH2PR12MB4119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(31696002)(316002)(8676002)(4326008)(54906003)(4744005)(81166006)(8936002)(81156014)(6636002)(5660300002)(6512007)(52116002)(478600001)(66476007)(6506007)(16526019)(2906002)(66556008)(6486002)(66946007)(956004)(6862004)(86362001)(31686004)(186003)(26005)(36756003)(53546011)(2616005)(37006003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4119;
 H:CH2PR12MB3927.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tX1772B7GK/tm7U9uXyJAPg+qQ+zDuPwgNJjCyRJAqzEasta0LeAEonBUfL2pq7KxHGwASuOrn2jiCeolvfrsNx9TEJWz+Sn9SN6bJY2oEbnHyfgYWXGqlBTNZiHHK96XgD5Y2zsRfGP+BW2AYdJxcqyIfLvlds7UZBuqHFyyki0N6N1R5I7ozbVzaPKaydAnUjZxSmEnna/LhZnVA8/zmsAZQYa1RU0HAIPXOt7LYvXW5pxvmQYVpuAI/vdgcYkNIusVlohn4c1lJNi/pABPy0uu1uSEp6TjluKvNUN4pC9xhWEQoQcH/zVijT2admnzWoKi+XK1F4SEJOITyyVZt2bQbvBK1wCjxFwUwJf+ccEif4zAZSiJ9n23GZuIZ/EtYdyLFBIpRLQ0zCSjZsod/tVA1ZE1/pXFJLUdkjkU8yhHdrXD4L0uE5QHdx/hQMa
X-MS-Exchange-AntiSpam-MessageData: O61oCHKU8IkUiG6LGKE1lAmHIs9WcvkR7+0ICMyeX+hh4kbB15cgWYN4l9NHIxabfVsSqdZDW5yse9ltYb6D/S1+boy07l78Cdp5D3KOkEq3Xoe9xk6Ry0ZW9Y04e7bb+I8ChFhtxLyHF/ZVG3g35g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4fb298-502b-41f0-108e-08d7b6db503c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 14:35:35.8360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYZSl48doFioBxbY3lwLdY3kWoQx9gUdFNvr+Qq0ql2erjYuQY72FfNqhflNcEScOjSvddvtyTGUOIoaBUgEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDItMjEgOTozNCBhLm0uLCBIdWFuZyBSdWkgd3JvdGU6Cj4gT24gV2VkLCBGZWIg
MTksIDIwMjAgYXQgMTA6MDk6NDZBTSAtMDUwMCwgVG9tIFN0IERlbmlzIHdyb3RlOgo+PiBJIGdv
dCBzb21lIG1lc3NhZ2VzIGFmdGVyIGEgd2hpbGU6Cj4+Cj4+IFvCoCA3NDEuNzg4NTY0XSBGYWls
ZWQgdG8gc2VuZCBNZXNzYWdlIDguCj4+IFvCoCA3NDYuNjcxNTA5XSBGYWlsZWQgdG8gc2VuZCBN
ZXNzYWdlIDguCj4+IFvCoCA3NDguNzQ5NjczXSBGYWlsZWQgdG8gc2VuZCBNZXNzYWdlIDJiLgo+
PiBbwqAgNzU5LjI0NTQxNF0gRmFpbGVkIHRvIHNlbmQgTWVzc2FnZSA3Lgo+PiBbwqAgNzYzLjIx
NjkwMl0gRmFpbGVkIHRvIHNlbmQgTWVzc2FnZSAyYS4KPj4KPj4gQXJlIHRoZXJlIGFueSBhZGRp
dGlvbmFsIGxvY2tzIHRoYXQgc2hvdWxkIGJlIGhlbGQ/wqAgQmVjYXVzZSBzb21lIGNvbW1hbmRz
Cj4+IGxpa2UgLS10b3Agb3IgLS13YXZlcyBjYW4gZG8gYSBsb3Qgb2YgZGlzdGluY3QgcmVhZCBv
cGVyYXRpb25zIChjYXVzaW5nIGEKPj4gbG90IG9mIGVuYWJsZS9kaXNhYmxlIGNhbGxzKS4KPj4K
Pj4gSSdtIGdvaW5nIHRvIHNpdCBvbiB0aGlzIGEgYml0IHNpbmNlIEkgZG9uJ3QgdGhpbmsgdGhl
IHBhdGNoIGlzIHJlYWR5IGZvcgo+PiBwdXNoaW5nIG91dC4KPj4KPiBIb3cgYWJvdXQgdXNlIFJS
RUczMl9LSVEgYW5kIFdSRUczMl9LSVE/CgoKRm9yIGFsbCByZWdpc3RlciBhY2Nlc3NlcyAoaW4g
dGhlIGRlYnVnZnMgcmVhZC93cml0ZSBtZXRob2QpPyBDYW4gd2UgdXNlIAp0aG9zZSBvbiBhbGwg
QVNJQ3M/CgoKVG9tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
