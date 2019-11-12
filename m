Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA226C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36BF20674
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36BF20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C8E892EA;
	Tue, 12 Nov 2019 21:43:45 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720049.outbound.protection.outlook.com [40.107.72.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23031892EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 21:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4y0pedMINpropyLVjOCb27sHip5tk5tuyCj9qImIgMCfcjMkthtnpeTMB7itcEOXi9798ggZSefY7M0gDaxgPWpMLwAgKd2agOfiNO3zSYJoH0l/WMBj7D1MsuR+AGwd9P752NfxAhcZF+onwEQq6hnt2gzuWw6cLLa2hhmX7j2jn8C4+WFjnNGCfvlfKPqxqWP3nX+5CsrGdCHsWKrdsxzBfbJoodtMaM5jCJXN8lbXCeHxdKwbYk9VVlYs9BCIchcwQHC1UhgJeoweDhEfavAlZVd3FmNqBz/l+pSUzE4jRVM+ifA3E6369J7O+lxSsB2bWbNzT1EPusiBrUOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9BqKJxzV4sLqpePE8X4EFHe7ybHDiM6QJJBo18E2pI=;
 b=YAfTHu8YaZOmpM4nfH57Jns3NgdWOkAhMdb1WaAecv7ZbgxQ8tYiDuf0iuYzvE8NnqKUwS+0xZSDBMZm9RfG4JFkllTAnznAuxSl3m1c8nSIgUg85ibzbIIdZBjg3QOg312fAdk9R0xIxVI1QT9M3Yx6cOJHepXPYg9O19F8uwJAgRfw0KxC1OWPcYSWHgfFyUlREgg6uaffSR43rx9aLQ8BmHaHgxOUfQCJVQH0p2wGw4tjiD2Hvrxo4L+WALQUAx8VqP3rhwfHSjUH9/grM7VyGXJrOfDor1r34zeAl3xDmo/C24c06SIUtROOPnbWq2zZAZCUV21XSZDmHAEmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3086.namprd12.prod.outlook.com (20.178.241.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 21:43:42 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 21:43:42 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: Fix a bug when calculating
 save_area_used_size
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 Jay.Cornwall@amd.com, "Morichetti, Laurent" <Laurent.Morichetti@amd.com>
References: <20191111232521.10528-1-Yong.Zhao@amd.com>
 <20191111232521.10528-3-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <b38849e7-e691-9684-b3ec-560dd799b523@amd.com>
Date: Tue, 12 Nov 2019 16:43:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191111232521.10528-3-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 731e111c-3747-4424-a341-08d767b96310
X-MS-TrafficTypeDiagnostic: MN2PR12MB3086:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3086B38F19F797E19483469292770@MN2PR12MB3086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(189003)(199004)(66066001)(6116002)(44832011)(3846002)(50466002)(6246003)(66476007)(53546011)(6506007)(316002)(386003)(186003)(36756003)(86362001)(66556008)(110136005)(58126008)(23676004)(6512007)(52116002)(76176011)(65956001)(65806001)(14444005)(2906002)(99286004)(26005)(47776003)(2486003)(36916002)(25786009)(66946007)(31696002)(31686004)(478600001)(305945005)(6436002)(446003)(8936002)(11346002)(230700001)(2616005)(6486002)(7736002)(4001150100001)(476003)(81156014)(486006)(81166006)(6636002)(8676002)(14454004)(5660300002)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3086;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4uPKMSJ0Cn+luAIYxEbfeAyJv+5h8DBvTWTGibc8rCiE1xvFCDT1Ui+taishY9hQ96JQuKI3GrE8RZMcPKI32ufYMqqR/PLzqgxJ9fTrb6eBOVCFcJa6jLDASln1z9oGDi+KrE1sSfkl8QCum1KJEz0jxWNlJNRyEatGSHdueWCfTUsFPTpZ/I+pEzbOK97zUYVjZTB8WJG9G0kk0sstOROgzLA71+1qTeoSBQWKi0V+8gK1D6KlGGcEafOSEW0pnsDEM2666Z4Ay9grRyQ5W6Zxp0CZJVu/z3hbmH4ud/LPmuk6u+cPAtT1Cqa23aw96FwuUSWyESNyekQ+K1804xgPlRygh9CU/NlUtVXi5U/OroX76uPCysTF1KxSzCf3ruh2MnEoPfG6lPbkRmxUipzJf4awwgKjGPwKnz/+Z6jTrHbHD6TSZf9ObqNiVBR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731e111c-3747-4424-a341-08d767b96310
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 21:43:42.7358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCt2MYixjNStq8BrLLNWFbiRfzS8UYq77hvE0IKmfVOAMmpq5t2jfVdDGhnkZ8N8YKkVi8alzi5fygOunaK9Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3086
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9BqKJxzV4sLqpePE8X4EFHe7ybHDiM6QJJBo18E2pI=;
 b=RFwFg2kG2eCe0eCQlsAUFjvRu38Xv4Bc0BV0nSWipQZblen6CLUjdP9kjJ90BAM3F/qr6xygYXgM2mTShLWN57RGvN872bJpkbEKiwHQCLtetItr3OpnZjMpXT7TPM+JBZrdPlnnqv4x/JWLtS0W9/sAeYlRcSIHgQlZTdVzZt8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112214341.ycK4bKbHSWmhN5dLhgHckuQe5MbHtquK0GRAkJWplYM@z>

T24gMjAxOS0xMS0xMSA2OjI1IHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPiB3b3JrZ3JvdXAgY29u
dGV4dCBkYXRhIHdyaXRlcyBmcm9tIG0tPmNwX2hxZF9jbnRsX3N0YWNrX3NpemUsIHNvIHdlCj4g
c2hvdWxkIGRlZHVjdCBpdCB3aGVuIGNhbGN1bGF0aW5nIHRoZSB1c2VkIHNpemUuCkxvb2tzIGxp
a2Ugc29tZXRoaW5nIEkgbWlzc2VkIGluIHVwc3RyZWFtaW5nLiBBcyBmYXIgYXMgSSBjYW4gdGVs
bCB0aGlzIAp3YXMgb3JpZ2luYWxseSBwYXJ0IG9mIGEgY29tbWl0IGJ5IEpheSBvbiBhbWQta2Zk
LXN0YWdpbmcuIEFub3RoZXIgcGFydCAKb2YgaGlzIGNvbW1pdCBzZWVtcyB0byBiZSB1cHN0cmVh
bS4gTm90IHN1cmUgaG93IHRoaXMgZ290IGxvc3QuCgpTZWUgb25lIGNvbW1lbnQgaW5saW5lLgoK
Cj4KPiBDaGFuZ2UtSWQ6IEk1MjUyZTI1NjYyYzNiODIyMWY0NTFjMzkxMTViZjA4NGQxOTExZWFl
Cj4gU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jIHwgMyArKy0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjku
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jCj4gaW5k
ZXggZDMzODBjNWJkYmRlLi4zYTJlZTFmMDFhYWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+IEBAIC0zMDIsNyArMzAyLDggQEAg
c3RhdGljIGludCBnZXRfd2F2ZV9zdGF0ZShzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCB2b2lkICpt
cWQsCj4gICAKPiAgIAkqY3RsX3N0YWNrX3VzZWRfc2l6ZSA9IG0tPmNwX2hxZF9jbnRsX3N0YWNr
X3NpemUgLQo+ICAgCQltLT5jcF9ocWRfY250bF9zdGFja19vZmZzZXQ7Cj4gLQkqc2F2ZV9hcmVh
X3VzZWRfc2l6ZSA9IG0tPmNwX2hxZF93Z19zdGF0ZV9vZmZzZXQ7Cj4gKwkqc2F2ZV9hcmVhX3Vz
ZWRfc2l6ZSA9IG0tPmNwX2hxZF93Z19zdGF0ZV9vZmZzZXQgLQo+ICsJCW0tPmNwX2hxZF9jbnRs
X3N0YWNrX3NpemU7OwoKUGxlYXNlIGZpeCB0aGUgZG91YmxlLXNlbWljb2xvbi4gV2l0aCB0aGF0
IGZpeGVkIHRoaXMgY2hhbmdlIGlzCgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+CgoKPiAgIAo+ICAgCWlmIChjb3B5X3RvX3VzZXIoY3RsX3N0YWNr
LCBtcWRfY3RsX3N0YWNrLCBtLT5jcF9ocWRfY250bF9zdGFja19zaXplKSkKPiAgIAkJcmV0dXJu
IC1FRkFVTFQ7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
