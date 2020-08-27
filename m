Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E5DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 07:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564DF22B4E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 07:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hnwiFHyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564DF22B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCD76E43C;
	Thu, 27 Aug 2020 07:03:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87E06E43C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 07:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjLs3MVxJqPbUFAdK40HlxjHkxpkht9iN4yRIyYFrKqognNOkBN3t89NTlhVlJIXL42tc0WhVK/vmVMBtTSs9yNnyX+jePr9NSNVgfIRzMyx6S5UMNJP6wcJMUJ6WMb1haino1JurD5T6NehKTz7MUYN9h7F0Xs4bXSrPUCOpvjL+8yRlHb5bmnNwkTYrGNkEjPqMFBleAiBAeLhHiMLTjFCwKyj7cF/4KFd52paeiOXRF/Jci/+2QaP7wnzfaPMV/nIZxKUEEO8Sq08b36HNrlEru0NAb1bwg2dBxB+Via+IoO/P2jIMXhFRcx965CCxKW930U+nmQhBDkuckk7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM/RIj/8/Rh0wUNeJk7YiQj0HBtdqYO7VVNcgJMSwns=;
 b=Y9cSysJmr4n95qzeci3wAkJKwLlXvIJ+HcMj6F4bbY5w9AQ+lBYZtWe+QaDm/++T1pahYT0hqLbObo5cPg8YqQJeTVGBOLotyX3wi1Tampt+UK3e80yqBzGwYyXfSzsLhX0YslfknkddpI75DuqEgMAqk17jrfjzpZ7BCXMlM5bkkopPzRjYc0bCU/cci/ZKmmB+HcxhChnGWv2xSErMffXHlgtnYPg3EdHcyzNIYcBax/tj7bIMje4CKnSaCPBM/Dm3Q3kS/2GqMtA8tLiySNt7AEVV/72t27O+HqRbrfZOadslPHKINuSo2V4mZ5455cQjTlMfV25PpTlJOpwjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM/RIj/8/Rh0wUNeJk7YiQj0HBtdqYO7VVNcgJMSwns=;
 b=hnwiFHyUuRidNwv3yBLaKWPqWUifv6o+s940L20MuAjwk5UVDMdYa6UG17uXT/tiPySCKhtEtA2oFDXyog2sXT09qCr+GSaTv1q5ApZE/eNqwjwKunWQrGumsTd4SgIwG02oomf2WszpZ53s8nIfOQ1pX3s6FOPFT9Ix00ur3Z4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 07:03:19 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 07:03:19 +0000
Subject: Re: [PATCH] drm/amdgpu: simplify hw status clear/set logic
To: Jiawei <Jiawei.Gu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200827023219.6650-1-Jiawei.Gu@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <23204288-401b-37b2-1cd2-82d8c6372b90@amd.com>
Date: Thu, 27 Aug 2020 09:07:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200827023219.6650-1-Jiawei.Gu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Thu, 27 Aug 2020 07:03:18 +0000
X-Originating-IP: [217.86.119.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62313bbb-0bf0-4ce4-4fd5-08d84a574742
X-MS-TrafficTypeDiagnostic: DM5PR12MB2471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24711779A8D24330CF5B07278B550@DM5PR12MB2471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xt+/niFwl9RKt6tW+AHPCYeN1J/iKYnU32HGW74R+hn+Vgyi70bazuxW6eq4q5hUBE3pidmaaO8siX2FAj8heGqkXKM6FgZ4Dja+FQZEUDdEHtsQAX6a78a/lbjtrTiN5KrRC6Ocmppoqwslxqk/qOXImr3Vnpg74p66+1tv2WTFNHjafhLAcQ09xia5+3VX+QvRWor6FtTDAb2eYDqAnYlBGIPRfM8pluIf0aKkKXUedpP060q3S90hfnTlCsmb+EpeCdeCrA0XIHV8ocMvKQk45j/R+k740r5FtYazt1pdSpuk5Ap0bnTCbyXOykjp4aunhY1HuhHeMm3V3lCPjYqh70wsGiXJ0EKXBDjlOY8TBF7S1zwv2eWsWWfpJ6QG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(31686004)(5660300002)(66946007)(52116002)(66556008)(66476007)(83380400001)(36756003)(16576012)(316002)(26005)(2906002)(186003)(53546011)(6486002)(478600001)(2616005)(956004)(31696002)(8676002)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Wh1FJ/R/OCAB1utfBUNOXzjGzjEHJd1uPns7QER+ZLpoQgZAPkKdMJ0Ss8SHyykvd+wQaXJP+9ZPQ3PNRHaqiMY7Q2PK4gLp4stOKOREnnomMNj7VikgXkv/zO+aqunduihZO0R5QXWIjt5NqtKqoXuxymZ0Sy77xmqMHN8r6RIcDSatTIOym113xk7MeygfaImY0bb0DN2rXm6dB7OSJA+Nt2DyOVrvlgPawnrvKy1OnANtmS/b+ExuttYmU0D1XSPmD37zsytVqZG8hrfEfPCFIYliwtH9qjFJUPCEayFuAvhY1rGs0rohitrfcfeYdSsCFE1RAupLNjnjmNpbIHv2OmKEgx2F9G/biEVGxC1jkAqwXlSOGzv1f9WkOUz2e48XuYlI92CL0p3n/DdnYGu/5m9kqWgAcjNdII8kiLj7U+ALqk0pagefsx4lz0dxQrIAtW2GWDb6SEumAauqosHr+j1i9ZKzwsn01H8yDkSCFv2k2UoyGItiEZ9VuCOahseG4p3Pl0/Dk008LowbsNXE4HdLPLKPMWaUi+I3qyPpm7aDJaSs9/AIleEqdjHcxHAkuQcZyNdGiopN7664LoJ795QBy/ogaH9EKUBRe38Yo0Up08kFNq9fD7L+FdHohmyNgxU1tUix370E+N83WQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62313bbb-0bf0-4ce4-4fd5-08d84a574742
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 07:03:19.3042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI00LXQtTstK7oiIJ9TPr77h+5RntDkLO4Xe2dWrySk31h42nFegjJVRiUTSJXQYWVti0+JiHtBxQn9jHxLupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2471
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDgvMjcvMjAgNDozMiBBTSwgSmlhd2VpIHdyb3RlOgo+IE9wdGltaXplIGNvZGUgdG8gaXRl
cmF0ZSBsZXNzIGxvb3BzIGluCj4gYW1kZ3B1X2RldmljZV9pcF9yZWluaXRfZWFybHlfc3Jpb3Yo
KQo+Cj4gU2lnbmVkLW9mZi1ieTogSmlhd2VpIDxKaWF3ZWkuR3VAYW1kLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDEzICsrKysrKy0t
LS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gaW5kZXgg
OGYzN2Y5Zjk5MTA1Li42OTZhNjFjYzNhYzYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTI1OTgsMTcgKzI1OTgsMTYgQEAgc3RhdGljIGlu
dCBhbWRncHVfZGV2aWNlX2lwX3JlaW5pdF9lYXJseV9zcmlvdihzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIAkJQU1EX0lQX0JMT0NLX1RZUEVfSUgsCj4gICAJfTsKPiAgIAo+IC0JZm9y
IChpID0gMDsgaSA8IGFkZXYtPm51bV9pcF9ibG9ja3M7IGkrKykKPiAtCQlhZGV2LT5pcF9ibG9j
a3NbaV0uc3RhdHVzLmh3ID0gZmFsc2U7Cj4gLQo+IC0JZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJ
WkUoaXBfb3JkZXIpOyBpKyspIHsKPiArCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxv
Y2tzOyBpKyspIHsKPiAgIAkJaW50IGo7Cj4gICAJCXN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmJs
b2NrOwo+ICAgCj4gLQkJZm9yIChqID0gMDsgaiA8IGFkZXYtPm51bV9pcF9ibG9ja3M7IGorKykg
ewo+IC0JCQlibG9jayA9ICZhZGV2LT5pcF9ibG9ja3Nbal07Cj4gKwkJYmxvY2sgPSAmYWRldi0+
aXBfYmxvY2tzW2ldOwo+ICsJCWJsb2NrLT5zdGF0dXMuaHcgPSBmYWxzZTsKPiAgIAo+IC0JCQlp
ZiAoYmxvY2stPnZlcnNpb24tPnR5cGUgIT0gaXBfb3JkZXJbaV0gfHwKPiArCQlmb3IgKGogPSAw
OyBqIDwgQVJSQVlfU0laRShpcF9vcmRlcik7IGorKykgewoKCldlIGNvdWxkIHByb2JhYmx5IHJl
cGxhY2UgdGhpcyAiZm9yIiBsb29wIHdpdGggYSBiaWcgaWYtc3RhdGVtZW50CgogwqDCoMKgIGlm
ICggYmxvY2stPnZlcnNpb24tPnR5cGU9PSBBTURfSVBfQkxPQ0tfVFlQRV9HTUMgfHwKCiDCoMKg
wqAgwqDCoCDCoCBibG9jay0+dmVyc2lvbi0+dHlwZT09IEFNRF9JUF9CTE9DS19UWVBFX0NPTU1P
TiAuLi4gKQoKCkJ1dCBhbnl3YXkgaXQgbG9va3MgZ29vZCB0byBtZSBhcyBpdCBpcy4gQWNrZWQt
Ynk6IE5pcm1veSBEYXMgCjxuaXJtb3kuZGFzQGFtZC5jb20+Cgo+ICsKPiArCQkJaWYgKGJsb2Nr
LT52ZXJzaW9uLT50eXBlICE9IGlwX29yZGVyW2pdIHx8Cj4gICAJCQkJIWJsb2NrLT5zdGF0dXMu
dmFsaWQpCj4gICAJCQkJY29udGludWU7Cj4gICAKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
