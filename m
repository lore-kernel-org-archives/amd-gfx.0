Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 15:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68B964F6B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 15:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68B964F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69AF06E0CF;
	Thu,  4 Mar 2021 15:09:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632036E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 15:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1eYPRfKxY0CraVMnevt1oQG83jomQSanEuWvKuCyD4BdOROTdvD5/o0aiQItCVsetpliIHDcM/M+X5sc6TvLMkcUUFggbeoq0n/j7yLIoBvjPGhglk7kIWBb0FvSKxHNDBulM9zYlT42jtMFbTqeV4aDnzhIbzPCBNCYEqE0K2SGVrrZzkllvsvdqC8Je8zRL5XlVqTA7qooVQatx0Z9S2wSVu3fBICg9OCR8vsZj07z4P22dI7ivYHyUdhtTp7dbLbxuiefoQvMI37revNuPo3EhUHNGq7oDHklOYCnTyqFJpLrHC2Q0vLJKoQ1+7czOKroTOy6CJxBSRM4oSeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/pXFcZW8UrtO3XAOjVyEMzvZq3RmJf3wdmgPNMY0wU=;
 b=BQfKIhkZJo3wfx32boxV0zf3nIJYL9ERZgbOueBSaMxSfvL1OybZizKf6ckTukhkUH+96Yd403oAJqiNOXhijTkT+Ld3E3e1jotWwuyo9fVNMWjRz4ikL8ymo2u+I8I6VNGFj9KT3sQjNl3m5GeKfQEZl9ZXBs929WCTdAG3KmZwKKPPidsKC1Q5L/UUu3hVTCuT06mNaLXks/2E8zXUScDxkNYvBRc0g9mz0tWQjffLiNTtjYomJcfU8PjKwT/5GYWkMxMD/BlTtuCsyGdtFXSTIv0iEwO2AE1Yd3TryKmeSLkERcSvINWGzKYQQrYvwn0JF5LIGrG2WClZu7+o7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/pXFcZW8UrtO3XAOjVyEMzvZq3RmJf3wdmgPNMY0wU=;
 b=vuCPgZghCMCjFKFZo8rrbwYYZLexVmWJnQT2tS77KCdELHWBiQsFnhRCnasCjkm8bCcsqzjum4s/s0/Q2/YgDBeOv0Drrbw7RvHc/TjwSdEU+3SBRZOViXTD4gKCZAwVcmMipZb7SB43ID170KqMG+WjOC8sw7RLMlDOHAxAJ/E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3461.namprd12.prod.outlook.com (2603:10b6:a03:da::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 4 Mar
 2021 15:09:12 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::4d9b:6989:13f2:e4f8]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::4d9b:6989:13f2:e4f8%3]) with mapi id 15.20.3890.031; Thu, 4 Mar 2021
 15:09:12 +0000
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Daniel Vetter <daniel@ffwll.ch>
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
 <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
 <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
 <e7661e4b-a99c-5be7-9912-421ac3e61ff0@daenzer.net>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <94a2e9cd-8a14-984d-71a7-3671d7c352ab@amd.com>
Date: Thu, 4 Mar 2021 10:09:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <e7661e4b-a99c-5be7-9912-421ac3e61ff0@daenzer.net>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25 via Frontend Transport; Thu, 4 Mar 2021 15:09:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1a9071f-a3bb-43b2-47be-08d8df1f77c0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3461D0FBBB77D1FA0A951156EC979@BYAPR12MB3461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVH0a6oQSTPLPoeRXpbGoy2DtS+jqpAgYi6Om9R7LQhnKn+wOOmljv5J2duBfRHiGxAVe0VyPHiwj9Lp/g0wsDo8hNoqvIf4qsbHsWW5faNdizc2Rykv0M+KTyywLN7yYCkPyjmj/RqxfWvkJr+IPqa5zvfC4PNUQRLsGdCwHd07TYF3l0EzxGMbmorphC3SZMCKV97mvelzs89aCgsLZbDzEjP+R3BIsy2+f6szsljkstK0d8WsgyRe4358ntjl/pUpjGoyzFe8jx2HZoWSxjw+5VCSA0hg9gmAlxAO/JYoSQXEDtMFs4abUm7Obq/0bcSEYPrklqw7yIqYaYHCbOmdOSvKzp4FF/U5sgr4tbquENBZWEQDPyEpoaq1gqlm9e+mw9sPRd5yU5yhcAZcwYnftL3gHCcVZ9hV2YFbxGi+DvMx0D8GSdiZQksxuJpK/aogASI7sMy9gr1QT37ZGHTHyQ8uX2jJ7cdjVx0tf2WwU9x3dEC8UaCNoO3CTWUtIpCPGUuee0az5iY6hlDWHsuI1gv8Zbw/xdk44KDijKpMB/FW+EQKzHDKmMTqQ33njVLOPz/EzFaSMKToj2/3HMv+FyetmeC57GlF7jRtyD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(53546011)(31686004)(66556008)(66476007)(31696002)(2906002)(86362001)(6486002)(26005)(52116002)(956004)(2616005)(5660300002)(54906003)(110136005)(8936002)(83380400001)(4326008)(16576012)(316002)(36756003)(478600001)(186003)(16526019)(66946007)(6666004)(8676002)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UU9RdUZVUVFzazVDcmYzWVREUFpPdGFLUHozWUplQ2JhTnV0TXpLOC9SY0Vp?=
 =?utf-8?B?emdZa3JLS05HV1psMURNYStSa3dEalVHVGdtWmRLanhpci84eGJDblJ0QUFq?=
 =?utf-8?B?WWpzZzhua1BiS2k3ak9qajd4TlllNjhlL3RWN2VEZGZFMUkvR09nQ1hWZmhQ?=
 =?utf-8?B?cjJ3ZVliem5ndUpKb05IaVpZWmJLRW0xT21HMys4bkRzdXZmelM1aTV1ZlVI?=
 =?utf-8?B?MFROUDVzeTlpMjB3emFSczIrRTFBR0JZRWxOYStlV0orVy9nczR3WlNTQzBJ?=
 =?utf-8?B?UHkyQmdpSmVHRCtwMWVGM3VtcnVuOTQwQ1VIZDhkalpNcTlIRWVlRWJUUjdT?=
 =?utf-8?B?Rk01cVJoR09WUW9LWW90RmlxTjZvTy8xT3p4dnJXVGFGNEhvSTAyZUVmVk9k?=
 =?utf-8?B?dWhDNkI2NHRMMDdueEhZUkZQeisvZ3FGQTB2enBwWlJEdnlQbUlZcldsZ2FN?=
 =?utf-8?B?T1p1WVdVS0NSbmJxRk56dFpseGU5U21HaXBST2RmOE9VdHg4SUgxNjBEa1dm?=
 =?utf-8?B?NFR5N3UrZ09lZnNNTnh1Q25UQ1BvRXVoMGVObEljbnZjTGRrYXRtWlR6dTQx?=
 =?utf-8?B?SWhDcjhRMzQ2S1E3WFptUGhTQmR4ZWUrT1VXdmVNMWZzNmpkMk10NVA2TjRD?=
 =?utf-8?B?QTZSem12ZFIvQkM3TS9STmswbm80QmtyTFl1UDMycFpVbWNXSmFKOGJ6VjhT?=
 =?utf-8?B?K3JlVGFqcFEyc1N5YjhQREVQbjRDbGJxSUNzYnE0aXpnNDhBV0l6QVRtZWM0?=
 =?utf-8?B?Unh2WGxoZFhwLzByN2ZmODNGcmVnN01nTGxndHNOZGJKNm02VEZ6K0ExNVhZ?=
 =?utf-8?B?M1kzVjRaUWkweUMvZjRBVHBtYmdac1E0eENPUnpjSnNLNmNJWXBwVkJzRmYr?=
 =?utf-8?B?TE50WXdoaXNkdEFBL211SzdMdVRwUGJ2aUFiSTFFMTN5QTRqYzlSUTZVbkk5?=
 =?utf-8?B?Y05FWk96S2F6QkNkd1lSbkpFVlNKMjFFdGF6ZkZUOGtXazQyKzRUYU5pdjdu?=
 =?utf-8?B?YUtRS3ZQa1d0OUt1WU0zTWJ2NnRyeTcvbmFZOGNvRWNaQ1gza3I5VDk4T2Z0?=
 =?utf-8?B?MHZybk81aGZxeUU2dXJHcmM4MTBiNU9KRXhxelNSR2MwZWlEN1lhVDBTTGsy?=
 =?utf-8?B?MTZ0bDdWNmRiUFNGckZYL3c2WkEyWTYrU1NmV0hKMGxYem5IaUhZcXdodzE0?=
 =?utf-8?B?R01zcW5CTitUVGN2ai8yOHFWR3crQU1RVXdaWWJsQ2dDeEwwSEpBTGJsWE5t?=
 =?utf-8?B?MWxuRTRLUm94RlRqRVNwK0ZiYXZHS3BlVlFVTW9SZCszQ0graDIyUW81UG9W?=
 =?utf-8?B?RGdlNjhVYzNJRWRUVURCOTRMSXBIRDBBeGNjN1ZEaUNveDVMK2U4M3hUMlQ4?=
 =?utf-8?B?aWFVWGdCQlprMzVGcWlkSW0zbXpmeVRvWUxzSERYYW9mUXJUcnRrR0hCanZD?=
 =?utf-8?B?VFl0aUpLamhVbi94NWNSZXRBZTZDVGNRYmpHVnBRS3B0L0FmZDF5cWxDd05z?=
 =?utf-8?B?SnFQUG1rdDN6WjlsQzNPVHpDeFZNcXJ4dXI2VUVIRzFnTmQ2bDZoZ3VJTXBO?=
 =?utf-8?B?SWpJOGxua0ZYNm53eGNEL1ZVeWIybkozdi83VWYrTS9nNkphVFFtNElvd2R1?=
 =?utf-8?B?d1BrZmtCVmFpbENPRFpMY25tVzJJS2Z5OVROUzNCem9YNzJqbFhTNnlxOTB2?=
 =?utf-8?B?MUxNQlp2b1d3VTdqOVRLZEJhMmRZeUYvcWd6YnFDNm9Xc1NQSmdXazhOS0NG?=
 =?utf-8?Q?BFflL7C0gZVHzxN8/mM+xB08XsgL+IOi5BRWGAK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a9071f-a3bb-43b2-47be-08d8df1f77c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 15:09:12.2233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvxIZuXV9wjH6sjbtwGL4/XRhiA/nq6pymiZGFKHyGUWsfHijG10xlLjtQ6Os2xwxK7IA2/LGH2xXYoBdF7qxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3461
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <hwentlan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0wNCA0OjA1IGEubS4sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uIDIwMjEt
MDMtMDMgODoxNyBwLm0uLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+PiBPbiBXZWQsIE1hciAzLCAy
MDIxIGF0IDU6NTMgUE0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6
Cj4+Pgo+Pj4gT24gMjAyMS0wMi0xOSA3OjU4IHAubS4sIFNpbW9uIFNlciB3cm90ZToKPj4+PiBN
YWtlIHN1cmUgdGhlcmUncyBhbiB1bmRlcmx5aW5nIHBpcGUgdGhhdCBjYW4gYmUgdXNlZCBmb3Ig
dGhlCj4+Pj4gY3Vyc29yLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogU2ltb24gU2VyIDxjb250
YWN0QGVtZXJzaW9uLmZyPgo+Pj4+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Cj4+Pj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxod2VudGxhbkBhbWQuY29tPgo+Pj4+
IENjOiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+Cj4+
Pj4gLS0tCj4+Pj4gwqDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIHwgNyArKysrKystCj4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyAKPj4+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPj4+PiBpbmRleCBhY2JlMTUz
N2U3Y2YuLmE1ZDYwMTA0MDViZiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+Pj4+IEBAIC05MjI2LDkgKzkyMjYs
MTQgQEAgc3RhdGljIGludCBkbV9jaGVja19jcnRjX2N1cnNvcihzdHJ1Y3QgCj4+Pj4gZHJtX2F0
b21pY19zdGF0ZSAqc3RhdGUsCj4+Pj4gwqDCoMKgwqDCoMKgIH0KPj4+Pgo+Pj4+IMKgwqDCoMKg
wqDCoCBuZXdfY3Vyc29yX3N0YXRlID0gZHJtX2F0b21pY19nZXRfbmV3X3BsYW5lX3N0YXRlKHN0
YXRlLCAKPj4+PiBjcnRjLT5jdXJzb3IpOwo+Pj4+IC3CoMKgwqDCoCBpZiAoIW5ld19jdXJzb3Jf
c3RhdGUgfHwgIW5ld191bmRlcmx5aW5nX3N0YXRlIHx8IAo+Pj4+ICFuZXdfY3Vyc29yX3N0YXRl
LT5mYikKPj4+PiArwqDCoMKgwqAgaWYgKCFuZXdfY3Vyc29yX3N0YXRlIHx8ICFuZXdfY3Vyc29y
X3N0YXRlLT5mYikKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+
Pj4+Cj4+Pj4gK8KgwqDCoMKgIGlmICghbmV3X3VuZGVybHlpbmdfc3RhdGUgfHwgIW5ld191bmRl
cmx5aW5nX3N0YXRlLT5mYikgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX2Ri
Z19hdG9taWMoY3J0Yy0+ZGV2LCAiQ3Vyc29yIHBsYW5lIGNhbid0IGJlIAo+Pj4+IGVuYWJsZWQg
d2l0aG91dCB1bmRlcmx5aW5nIHBsYW5lXG4iKTsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAtRUlOVkFMOwo+Pj4+ICvCoMKgwqDCoCB9Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKg
wqDCoCBjdXJzb3Jfc2NhbGVfdyA9IG5ld19jdXJzb3Jfc3RhdGUtPmNydGNfdyAqIDEwMDAgLwo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKG5ld19j
dXJzb3Jfc3RhdGUtPnNyY193ID4+IDE2KTsKPj4+PiDCoMKgwqDCoMKgwqAgY3Vyc29yX3NjYWxl
X2ggPSBuZXdfY3Vyc29yX3N0YXRlLT5jcnRjX2ggKiAxMDAwIC8KPj4+Pgo+Pj4KPj4+IEhvdXN0
b24sIHdlIGhhdmUgYSBwcm9ibGVtIEknbSBhZnJhaWQuIEFkZGluZyBEYW5pZWwuCj4+Pgo+Pj4K
Pj4+IElmIHRoZSBwcmltYXJ5IHBsYW5lIGlzIGVuYWJsZWQgd2l0aCBhIGZvcm1hdCB3aGljaCBp
c24ndCBjb21wYXRpYmxlIAo+Pj4gd2l0aCB0aGUgSFcgY3Vyc29yLAo+Pj4gYW5kIG5vIG92ZXJs
YXkgcGxhbmUgaXMgZW5hYmxlZCwgdGhlIHNhbWUgaXNzdWVzIGFzIGRlc2NyaWJlZCBpbiAKPj4+
IGI4MzZhMjc0Yjc5Nwo+Pj4gImRybS9hbWRncHUvZGM6IFJlcXVpcmUgcHJpbWFyeSBwbGFuZSB0
byBiZSBlbmFibGVkIHdoZW5ldmVyIHRoZSBDUlRDIAo+Pj4gaXMiIGNhbiBhZ2FpbiBvY2N1cjoK
Pj4+Cj4+Pgo+Pj4gKiBUaGUgbGVnYWN5IGN1cnNvciBpb2N0bCBmYWlscyB3aXRoIEVJTlZBTCBm
b3IgYSBub24tMCBjdXJzb3IgRkIgSUQKPj4+IMKgICh3aGljaCBlbmFibGVzIHRoZSBjdXJzb3Ig
cGxhbmUpLgo+Pj4KPj4+ICogSWYgdGhlIGN1cnNvciBwbGFuZSBpcyBlbmFibGVkIChlLmcuIHVz
aW5nIHRoZSBsZWdhY3kgY3Vyc29yIGlvY3RsCj4+PiDCoCBkdXJpbmcgRFBNUyBvZmYpLCBjaGFu
Z2luZyB0aGUgbGVnYWN5IERQTVMgcHJvcGVydHkgdmFsdWUgZnJvbSBvZmYgdG8KPj4+IMKgIG9u
IGZhaWxzIHdpdGggRUlOVkFMLgo+Pgo+PiBhdG9taWNfY2hlY2sgc2hvdWxkIHN0aWxsIGJlIHJ1
biB3aGVuIHRoZSBjcnRjIGlzIG9mZiwgc28gdGhlIGxlZ2FjeQo+PiBjdXJzb3IgaW9jdGwgc2hv
dWxkIGZhaWwgd2hlbiBkcG1zIG9mZiBpbiB0aGlzIGNhc2UgYWxyZWFkeS4KPiAKPiBHb29kIHBv
aW50LiBUaGlzIGNvdWxkIGFscmVhZHkgYmUgcHJvYmxlbWF0aWMgdGhvdWdoLiBFLmcuIG11dHRl
ciB0cmVhdHMKPiBFSU5WQUwgZnJvbSB0aGUgY3Vyc29yIGlvY3RsIGFzIHRoZSBkcml2ZXIgbm90
IHN1cHBvcnRpbmcgSFcgY3Vyc29ycyBhdAo+IGFsbCwgc28gaXQgZmFsbHMgYmFjayB0byBTVyBj
dXJzb3IgYW5kIG5ldmVyIHRyaWVzIHRvIHVzZSB0aGUgSFcgY3Vyc29yCj4gYWdhaW4uIChJIGRv
bid0IHRoaW5rIG11dHRlciBjb3VsZCBoaXQgdGhpcyBwYXJ0aWN1bGFyIGNhc2Ugd2l0aCBhbgo+
IGluY29tcGF0aWJsZSBmb3JtYXQgdGhvdWdoLCBidXQgdGhlcmUgbWlnaHQgYmUgb3RoZXIgc2lt
aWxhciB1c2VyIHNwYWNlKQo+IAo+IAo+Pj4gTW9yZW92ZXIsIGluIHRoZSBzYW1lIHNjZW5hcmlv
IHBsdXMgYW4gb3ZlcmxheSBwbGFuZSBlbmFibGVkIHdpdGggYQo+Pj4gSFcgY3Vyc29yIGNvbXBh
dGlibGUgZm9ybWF0LCBpZiB0aGUgRkIgYm91bmQgdG8gdGhlIG92ZXJsYXkgcGxhbmUgaXMKPj4+
IGRlc3Ryb3llZCwgdGhlIGNvbW1vbiBEUk0gY29kZSB3aWxsIGF0dGVtcHQgdG8gZGlzYWJsZSB0
aGUgb3ZlcmxheQo+Pj4gcGxhbmUsIGJ1dCBkbV9jaGVja19jcnRjX2N1cnNvciB3aWxsIHJlamVj
dCB0aGF0IG5vdy4gSSBjYW4ndCByZW1lbWJlcgo+Pj4gZXhhY3RseSB3aGF0IHRoZSByZXN1bHQg
aXMsIGJ1dCBBRkFJUiBpdCdzIG5vdCBwcmV0dHkuCj4+Cj4+IENSVEMgZ2V0cyBkaXNhYmxlZCBp
bnN0ZWFkLiBUaGF0J3Mgd2h5IHdlIHdlbnQgd2l0aCB0aGUgImFsd2F5cwo+PiByZXF1aXJlIHBy
aW1hcnkgcGxhbmUiIGhhY2suIEkgdGhpbmsgdGhlIG9ubHkgc29sdXRpb24gaGVyZSB3b3VsZCBi
ZQo+PiB0byBlbmFibGUgdGhlIHByaW1hcnkgcGxhbmUgKGJ1dCBub3QgaW4gdXNlcnNwYWNlLXZp
c2libGUgc3RhdGUsIHNvCj4+IHRoaXMgbmVlZHMgdG8gYmUgZG9uZSBpbiB0aGUgZGMgZGVyaXZl
ZCBzdGF0ZSBvYmplY3RzIG9ubHkpIHRoYXQgc2NhbnMKPj4gb3V0IGJsYWNrIGFueSB0aW1lIHdl
J3JlIGluIHN1Y2ggYSBzaXR1YXRpb24gd2l0aCBjdXJzb3Igd2l0aCBubwo+PiBwbGFuZXMuCj4g
Cj4gVGhpcyBpcyBhYm91dCBhIHNjZW5hcmlvIGRlc2NyaWJlZCBieSBOaWNob2xhcyBlYXJsaWVy
Ogo+IAo+IEN1cnNvciBQbGFuZSAtIEFSR0I4ODg4Cj4gCj4gT3ZlcmxheSBQbGFuZSAtIEFSR0I4
ODg4IERlc2t0b3AvVUkgd2l0aCBjdXRvdXQgZm9yIHZpZGVvCj4gCj4gUHJpbWFyeSBQbGFuZSAt
IE5WMTIgdmlkZW8KPiAKPiBBbmQgZGVzdHJveWluZyB0aGUgRkIgYm91bmQgdG8gdGhlIG92ZXJs
YXkgcGxhbmUuIFRoZSBmYWxsYmFjayB0byBkaXNhYmxlCj4gdGhlIENSVEMgaW4gYXRvbWljX3Jl
bW92ZV9mYiBvbmx5IGtpY2tzIGluIGZvciB0aGUgcHJpbWFyeSBwbGFuZSwgc28gaXQKPiB3b3Vs
ZG4ndCBpbiB0aGlzIGNhc2UgYW5kIHdvdWxkIGZhaWwuIFdoaWNoIHdvdWxkIGluIHR1cm4gdHJp
Z2dlciB0aGUKPiBXQVJOIGluIGRybV9mcmFtZWJ1ZmZlcl9yZW1vdmUgKGFuZCBsZWF2ZSB0aGUg
b3ZlcmxheSBwbGFuZSBzY2FubmluZyBvdXQKPiBmcm9tIGZyZWVkIG1lbW9yeT8pLgo+IAo+IAo+
IFRoZSBjbGVhbmVzdCBzb2x1dGlvbiBtaWdodCBiZSBub3QgdG8gYWxsb3cgYW55IGZvcm1hdHMg
aW5jb21wYXRpYmxlIHdpdGgKPiB0aGUgSFcgY3Vyc29yIGZvciB0aGUgcHJpbWFyeSBwbGFuZS4K
PiAKPiAKCkxlZ2FjeSBYIHVzZXJzcGFjZSBkb2Vzbid0IHVzZSBvdmVybGF5cyBidXQgQ2hyb21l
IE9TIGRvZXMuCgpUaGlzIHdvdWxkIHJlZ3Jlc3MgQ2hyb21lT1MgTVBPIHN1cHBvcnQgYmVjYXVz
ZSBpdCByZWxpZXMgb24gdGhlIE5WMTIgCnZpZGVvIHBsYW5lIGJlaW5nIG9uIHRoZSBib3R0b20u
CgpXaGVuIENocm9tZU9TIGRpc2FibGVzIE1QTyBpdCBkb2Vzbid0IGRvIGl0IHBsYW5lIGJ5IHBs
YW5lLCBpdCBkb2VzIGl0IAppbiBvbmUgZ28gZnJvbSBOVjEyK0FSR0I4ODg4IC0+IEFSR0I4ODg4
OC4KClJlZ2FyZHMsCk5pY2hvbGFzIEthemxhdXNrYXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
