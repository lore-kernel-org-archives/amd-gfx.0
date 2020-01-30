Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D382CC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A445620708
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GCh5SmfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A445620708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557626FA4D;
	Thu, 30 Jan 2020 22:51:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2EC26FA4D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 22:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4sWls2IPXWe/1AfXKX+CyGor7W/Mf/kY32ndfxyECDBY+LsOYpPWUkD5WxMyKye3bHPKt57DEBhTgGnI9NcJGljzPvNOAhJ0PV+Oi1fhqDBAdaOffbcgrP2iA8vziNSITSRHawuyCGA1lD1uPgzo7iUjVV+tjfcFtiRT+xdB8V5+NpKhdRN8OlLR3Y0aydtYtE4J1YaDkM/gbFdtwfZzU6rpAhglpsX9rDy+HK4J8a3JfwZNNGXcasQJqZf5/SWagrR7DE98qycn5AMMw90T38qSqQJWH6lW2t0vWEXEKLX5VHWk6vd9aDX1nEm3lfSW/ubBx0w129C+voHTFVPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3nABcc05/sKta8w9uR5DmqlzUCC/061yZKE5Do21pQ=;
 b=PJJJ9wuMzEAw564oDn9yrmwq/qN986sjc2gqG3he5Q7QkOivycbMwXs2vOIAflLwY1NBSm3fChH4L+Y5709wj7A3DhF/RNLzV26FeCiG+pPhfSjVF/3J3iUiuPO9EVMIzyt7Lp9ODhkK6hRLtLauiZkGMfGZX1IdfpxStEi1YaGkX/HJ8WhOUrOH9iu3+1msU4TOKn7Kscuv2E2j+1VOoIk0n5YdROIy+8pppnETtFroGDam0ZrOWEX3Idi7nqw14OhCFoxRo4KsomKCOdtMHVHd9zoqEilLx2SoSXrE5yweyQkjkLybS2Fc3++mCG/BpKfH7/S1t2H7rpiVBf6atA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3nABcc05/sKta8w9uR5DmqlzUCC/061yZKE5Do21pQ=;
 b=GCh5SmfWtXlLaXD5MXwpDFifUg6xJRQ6FTcGL6rvLmpboKPwJJp6MPh1+ErOaXAppuw9HA9ErbqZj5JNRMGRXDoeyJxgo6wQni7vq1Kmiah0jE8i1adoKFhXvFXs7x6b9y5WT1tqC7kTTYSlwGN0LoNjR+O3iJG+t/V/2mjf+ps=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0153.namprd12.prod.outlook.com (10.174.107.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Thu, 30 Jan 2020 22:51:22 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2686.028; Thu, 30 Jan 2020
 22:51:20 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix a bug in SDMA RLC queue counting under
 HWS mode
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200130222908.1403-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5f7d507f-25f9-bebc-a1d5-cf3b509c060a@amd.com>
Date: Thu, 30 Jan 2020 17:51:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200130222908.1403-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::33) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Thu, 30 Jan 2020 22:51:10 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3e9f0c1-3fd5-44d3-5b19-08d7a5d6e6bc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0153:|DM5PR1201MB0153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01533FA9B95F1E613D42AAF192040@DM5PR1201MB0153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(8676002)(956004)(44832011)(2616005)(31686004)(81166006)(31696002)(26005)(81156014)(53546011)(86362001)(16526019)(186003)(8936002)(5660300002)(66946007)(66556008)(66476007)(2906002)(52116002)(36756003)(6486002)(478600001)(316002)(16576012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0153;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMm8IUTMyPp2vmA9bgWJy8MUzKSBld3u5z8H93siX6JRloL+Zba0TNUnuGt8urUNyWThive+ZPQ7zwcfwuntK7kvkFszPek4so2W6p5q22Flt3A+7VFQo15VK1j0sUQfurNHpOrnaUvdVdCyKwRZLu0Xy9iaf6C3q1Jps1I2PGp8YfTO0jtc3gJNS9g8y2k/QxmPUidIcblyFph+m13xG4d2PTmV6T6ev8cUR+BOxi74jbL6Xej1lEMIYL3L/9fbGLRLEJYDGtd4OzCF97gL6Qml7n+/icgUfEx92GXuSYU1o34XNQw27Vk8jocunJFU7x1lzN44/LsLDxBJ9CdODYbwlILYBuwbieaCJpNdWem3bcE3UieCuzZaF7Mz+OmUYWnp5kPAiG3gKaH2/OGT9MLNE37nNsKw5rWy70d3IZlfHuawgObn8rQNh4Bq8fAZ
X-MS-Exchange-AntiSpam-MessageData: mW2Hyda+bqitnL0ibj9IJTPy+iyAihPJKXAT8Hmv9QWLv2tmsYEbn7hSFbhRdKFzOUK4Ye09RUGb1cldH8hdsp0i8l/1h6WxbmRij0YUSLG7jVdqdM4dyXvX8+TiX+npAxeC2vtnLA29z7YthQDWlQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e9f0c1-3fd5-44d3-5b19-08d7a5d6e6bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 22:51:15.8380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JuLVRVPzr637LmIPj4Q9hCdX8IzMlzdDWellWmnVCwcOYnfFzKqM/SV6fDTZVD4t/n0F/XmQplJZ+rWLuRv5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0153
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

T24gMjAyMC0wMS0zMCAxNzoyOSwgWW9uZyBaaGFvIHdyb3RlOgo+IFRoZSBzZG1hX3F1ZXVlX2Nv
dW50IGluY3JlbWVudCBzaG91bGQgYmUgZG9uZSBiZWZvcmUKPiBleGVjdXRlX3F1ZXVlc19jcHNj
aCgpLCB3aGljaCBjYWxscyBwbV9jYWxjX3JsaWJfc2l6ZSgpIHdoZXJlCj4gc2RtYV9xdWV1ZV9j
b3VudCBpcyB1c2VkIHRvIGNhbGN1bGF0ZSB3aGV0aGVyIG92ZXJfc3Vic2NyaXB0aW9uIGlzCj4g
dHJpZ2dlcmVkLgo+Cj4gV2l0aCB0aGUgcHJldmlvdXMgY29kZSwgd2hlbiBhIFNETUEgcXVldWUg
aXMgY3JlYXRlZCwKPiBjb21wdXRlX3F1ZXVlX2NvdW50IGluIHBtX2NhbGNfcmxpYl9zaXplKCkg
aXMgb25lIG1vcmUgdGhhbiB0aGUKPiBhY3R1YWwgY29tcHV0ZSBxdWV1ZSBudW1iZXIsIGJlY2F1
c2UgdGhlIHF1ZXVlX2NvdW50IGhhcyBiZWVuCj4gaW5jcmVtZW50ZWQgd2hpbGUgc2RtYV9xdWV1
ZV9jb3VudCBoYXMgbm90LiBUaGlzIHBhdGNoIGZpeGVzIHRoYXQuCj4KPiBDaGFuZ2UtSWQ6IEky
MDM1M2U2NTdlZmQ1MDUzNTNkMGRkOWY3ZWIyZmFiNTA4NWU3MjAyCj4gU2lnbmVkLW9mZi1ieTog
WW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGlu
ZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCkJ1dCBJIHRvb2sgYSBsb29rIGF0IHBtX2NhbGNf
cmxpYl9zaXplLiBJIGRvbid0IHRoaW5rIHN1YnRyYWN0aW5nIApkcW0tPnNkbWFfcXVldWVfY291
bnQgZnJvbSBkcW0tPnF1ZXVlX2NvdW50IGlzIG5vdCBxdWl0ZSBjb3JyZWN0LCAKYmVjYXVzZSBz
ZG1hX3F1ZXVlX2NvdW50IGNvdW50cyBhbGwgU0RNQSBxdWV1ZXMsIHdoaWxlIHF1ZXVlX2NvdW50
IG9ubHkgCmNvdW50cyBhY3RpdmUgcXVldWVzLiBTbyBhbiBhcHBsaWNhdGlvbiB0aGF0IGNyZWF0
ZXMgaW5hY3RpdmUgU0RNQSAKcXVldWVzIHdpbGwgYWxzbyBjcmVhdGUgZXJyb3JzIGhlcmUuIFdl
IHByb2JhYmx5IG5lZWQgdG8gY291bnQgYWN0aXZlIApjb21wdXRlIGFuZCBhY3RpdmUgU0RNQSBx
dWV1ZXMgc2VwYXJhdGVseSBpbiBEUU0gdG8gZml4IHRoaXMgcHJvcGVybHkuCgpSZWdhcmRzLAog
wqAgRmVsaXgKCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZV9xdWV1ZV9tYW5hZ2VyLmMgfCAxMCArKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiBpbmRleCAyODcwNTUz
YTJjZTAuLjgwZDIyYmY3MDJlOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4gQEAgLTEyMzcsMTYgKzEyMzcs
MTggQEAgc3RhdGljIGludCBjcmVhdGVfcXVldWVfY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9t
YW5hZ2VyICpkcW0sIHN0cnVjdCBxdWV1ZSAqcSwKPiAgIAo+ICAgCWxpc3RfYWRkKCZxLT5saXN0
LCAmcXBkLT5xdWV1ZXNfbGlzdCk7Cj4gICAJcXBkLT5xdWV1ZV9jb3VudCsrOwo+ICsKPiArCWlm
IChxLT5wcm9wZXJ0aWVzLnR5cGUgPT0gS0ZEX1FVRVVFX1RZUEVfU0RNQSkKPiArCQlkcW0tPnNk
bWFfcXVldWVfY291bnQrKzsKPiArCWVsc2UgaWYgKHEtPnByb3BlcnRpZXMudHlwZSA9PSBLRkRf
UVVFVUVfVFlQRV9TRE1BX1hHTUkpCj4gKwkJZHFtLT54Z21pX3NkbWFfcXVldWVfY291bnQrKzsK
PiArCj4gICAJaWYgKHEtPnByb3BlcnRpZXMuaXNfYWN0aXZlKSB7Cj4gICAJCWRxbS0+cXVldWVf
Y291bnQrKzsKPiAgIAkJcmV0dmFsID0gZXhlY3V0ZV9xdWV1ZXNfY3BzY2goZHFtLAo+ICAgCQkJ
CUtGRF9VTk1BUF9RVUVVRVNfRklMVEVSX0RZTkFNSUNfUVVFVUVTLCAwKTsKPiAgIAl9Cj4gICAK
PiAtCWlmIChxLT5wcm9wZXJ0aWVzLnR5cGUgPT0gS0ZEX1FVRVVFX1RZUEVfU0RNQSkKPiAtCQlk
cW0tPnNkbWFfcXVldWVfY291bnQrKzsKPiAtCWVsc2UgaWYgKHEtPnByb3BlcnRpZXMudHlwZSA9
PSBLRkRfUVVFVUVfVFlQRV9TRE1BX1hHTUkpCj4gLQkJZHFtLT54Z21pX3NkbWFfcXVldWVfY291
bnQrKzsKPiAgIAkvKgo+ICAgCSAqIFVuY29uZGl0aW9uYWxseSBpbmNyZW1lbnQgdGhpcyBjb3Vu
dGVyLCByZWdhcmRsZXNzIG9mIHRoZSBxdWV1ZSdzCj4gICAJICogdHlwZSBvciB3aGV0aGVyIHRo
ZSBxdWV1ZSBpcyBhY3RpdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
