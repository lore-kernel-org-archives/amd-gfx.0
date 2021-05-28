Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F51C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 13:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99B36128B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 13:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99B36128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EA66E0F4;
	Fri, 28 May 2021 13:36:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D11B6E0F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 13:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv3XOOewbUoS7kS8xX29WzRaEfbbUAzppg6aoGUxGAOj0odY+cn50B0DH8/XsviHS59F0F19+xG6y0sLvYQ4Zg1eXnZ8rv1spD073REDFjykQ02HsWknUi/6GauGVPEHUnOmgnOd521BBKJEey42pfhLYNs8gck01X/TeSS/oORQ5qQGjTXMFncaUwusYD36LiNUOj3M2IFwKaxXoRZPJk8bzsvFA2jiE6nULoLV6/2b1rUG7PQGGVD/4CquHr6PvL3BmMHCsiEYiqPN5ZbWvOTr9eM4ypNklhVmrbcdU3/M+U8CJkPD4Rt0h5fe2yJb5CzRlsvIElsDC9NYsNs3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3vroE6Br3XzzffBAOaVs5xS0uGWHWzH9mV0qNjT77M=;
 b=ln7mxOtS2RhTV5vYt28/ZDqCt79podRP3wGVyJgpMR3kfQN3cVjMw7NM91+bopDI2e3vS1V1/nOWMpICAnZDgHfxaRNjR8rg1N7I/9srWEdeh1/11S3J7eklnCwP2k4jsGjB2bQaDI+x4eUzQsFBdCN2hNskt/zylrpLiADLiPT/jUIx0eITJmRwLK+/W6WgOPN74sF14GLe1R+iPaO6SEnbgFDtUWNa2fLrOMgtWcDt48Ez6TH3S9SK32J8S940uUcLzkpSR68xMaubLUTWmnO07e7RDl2JjvJXyOxn5q5cPQU4Nelty8BghUa4keT5UYA4PcbTdDju4g76xD5ZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3vroE6Br3XzzffBAOaVs5xS0uGWHWzH9mV0qNjT77M=;
 b=1smdrbicu0lRLfMc/hLK2UM2aBeZfdG+yEOGjppYl6Hv+c5gdRbabElEYvCrolB+8/1kHdDjEDAeRrISbfUo2mgXzcHvSWTUHl98lFqIGLt/TZCgvh6gC7vi3SvEiMrVO0Tb0U6AGwUXWrTbnixhZNnuITJyEK+h/SD17y3brYA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 13:36:22 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 13:36:22 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: flush gpu tlb after a gart allocation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210528125428.3862-1-nirmoy.das@amd.com>
 <ee3dbc5b-5046-ed6b-da73-2bb299b2fa41@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <5cb92f28-73a0-5d90-733d-62337548c5ff@amd.com>
Date: Fri, 28 May 2021 15:34:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <ee3dbc5b-5046-ed6b-da73-2bb299b2fa41@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f21:6900:10f4:3065:5814:d1ee]
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f21:6900:10f4:3065:5814:d1ee]
 (2003:c5:8f21:6900:10f4:3065:5814:d1ee) by
 FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.12 via Frontend Transport; Fri, 28 May 2021 13:36:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7ecb2e-3c4b-4714-6ac9-08d921dd954d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5325:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53259DDFEC12DD49F54AC0A78B229@DM4PR12MB5325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YiOkNDQt8zF+hTojeNmX9rxQtpDQsUZkk2Y81T0HSexpxNIt+peZVbMDX7eteuSpjqs1Xg3Otq4Z8EocpPam7UiwILD2MNE9+7aLN2w3yTxKWMSMX4EHXc5y1RxZ2wsFnS60Xw9tW6rGlrY0t9Hozs9kJWIaIX2A2yp03SihpHOs+bQwXNjDSU+GcOA2pMB1BbyXWKZaMAJ2xMXY71YJ/hUHbbZrsjb3kmnTQIwHdErk6dNvxdcioYhrNRn9AlDxeZktqJGF6dWniTN7uTP/+pPIniCIvE4uTofOQtcoEPOCSGFIFvzYv3r6hi/9sqkahCpkXbqkOLB57SumkuPGs9K6gSnucz0pUjjRZ18eW+NZq8/IXaeMbmqKARbkBTgngwTGDKaFl//7h6/wqw93WkeEGp3nWkJMcVv1a7PVKbpZGMd54qA8Oil8dXResN8EIBV84oGdfTD5H3Z3z/RFtDp29gbxCQzwcU18wMoqRsaetrLaebqF29+iO9+8bPFBmmmMurV1ppPECZYpKLgyYjqVkerK2uoWRN9P4RdaGrD6NKHM2yEI9mPmnVdt1VBCWpD9Em1r8DcbW7AEraUfkV3Ur4t7vC76W9XcCQjSXq+FfjRc1sy1b/aHrc77fdfpm8NZn6aZEBxy23/18nUfgnlA5aq0YiAHUwXu+F7IMrJIAou9K2C3eaQ9EkHnamGc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(8676002)(53546011)(6666004)(38100700002)(316002)(2906002)(31686004)(52116002)(8936002)(31696002)(5660300002)(478600001)(86362001)(16526019)(186003)(36756003)(6486002)(66946007)(66476007)(66574015)(2616005)(66556008)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3WBmqZKM3AU8KqIoK8YP7Mb9KaGII/Ym7oUvZ2KO53Hrt91nbquzVzwJv/yWwJXwp1QR6GC9h0VQiQrAqR4RtQBxuRpatvNHKEl2XLqyk2gjdab/E3sCEx8otUPFrJ5DSlW3IsHA5fM5J7gA0hoIqpCwi/Um+gdzMuLeKvk7tojwak3dc8cKl765bdRdajgZbzYPi9hkhQZRKXWLq774sm2xwfEk3jmdPkTscGu1g2ORd308CMp1CTfOsFrCXszevSvwKx5+p4qq4J02sG6SWtFwKI84Wgw6fYCJKNb7llGi0yL46m4gGZTnX3FsUy2OjTI7IK5VeKXpQhk6noY+CoDKYRyXXluSNzQVsxdc/3nvG0XAXhH2Xqqy/f45calMlUQia9gM8Xvg7IBKGi5n9UrS1wMniG043KXgz+moE4ItrWi/NFCnAbPxHa7snwiwDKdVwMupQLorxBG/ypkMJYtq8iKu6GvhULzBnzsZM3k+7hpxqGW4EzAmLkgBbHFNf0Su+Dlbi5pC/GmvLRBx/zGCzECV3AujahZdAatDxmGSKbYjfiDyaxxvQ9pxcORWcTDWXEYzcAW3t8cY+r0M+pt09fU3AWT2v2LmejYSZmg46l2k0MNjPY8Kwo1aOoK5+qVLH3SjbFIDUx+Jspkx/CZGwNMHqOkRQoVTRwhtjlT3Ub2lzGZ/fauWtXHbt6b+Tc+FH9reBtbOh0t9LzCLRt8My1x4vB3rJ+jCrqqWhCYRpPB3RXDQL5rxorGwMpjaTkqpKqgc9erphNYuevoJbApkeEBMAMKlYHVm0Vie1vJzUj/cnGp8iXYOehzq9hn0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7ecb2e-3c4b-4714-6ac9-08d921dd954d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 13:36:22.7088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVGxUGWzYkyfgpVh+U8cpwwJTCk9ydexjfHSTzsWuUL0F6vSFnqwPOfIQ3IY2OaH7OlUn6enUY34au/yiYnNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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

Ck9uIDUvMjgvMjAyMSAzOjAzIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAy
OC4wNS4yMSB1bSAxNDo1NCBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEZsdXNoIGdwdSB0bGIgaW4g
YW1kZ3B1X3R0bV9hbGxvY19nYXJ0KCkuIEFsc28KPj4gZG9uJ3QgZmx1c2ggZ3B1IHRsYiBhZnRl
ciByZWNvdmVyaW5nIGVhY2ggQk8uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5p
cm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nYXJ0LmMgfCAyIC0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uY8KgIHwgNSArKysrLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dhcnQuYwo+PiBpbmRleCA1NTYyYjVjOTBjMDMuLjY4ZDQxMDYzZTEyMCAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYwo+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jCj4+IEBAIC0zMjksOCAr
MzI5LDYgQEAgaW50IGFtZGdwdV9nYXJ0X2JpbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IAo+PiB1aW50NjRfdCBvZmZzZXQsCj4+IMKgIMKgwqDCoMKgwqAgbWIoKTsKPj4gwqDCoMKgwqDC
oCBhbWRncHVfYXNpY19mbHVzaF9oZHAoYWRldiwgTlVMTCk7Cj4KPiBUaGUgbWVtb3J5IGJhcnJp
ZXIgYW5kIEhEUCBmbHVzaCBjYW4gYmUgbW92ZWQgYXMgd2VsbC4KPgo+PiAtwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBhZGV2LT5udW1fdm1odWJzOyBpKyspCj4+IC3CoMKgwqDCoMKgwqDCoCBhbWRn
cHVfZ21jX2ZsdXNoX2dwdV90bGIoYWRldiwgMCwgaSwgMCk7Cj4+IMKgwqDCoMKgwqAgcmV0dXJu
IDA7Cj4+IMKgIH0KPj4gwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90dG0uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMKPj4gaW5kZXggYzBhZWYzMjcyOTJhLi5lNjhiNWRhYjg0YTQgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4gQEAgLTk3Nyw3ICs5NzcsNyBAQCBpbnQg
YW1kZ3B1X3R0bV9hbGxvY19nYXJ0KHN0cnVjdCAKPj4gdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQo+
PiDCoMKgwqDCoMKgIHN0cnVjdCB0dG1fcGxhY2VtZW50IHBsYWNlbWVudDsKPj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgdHRtX3BsYWNlIHBsYWNlbWVudHM7Cj4+IMKgwqDCoMKgwqAgdWludDY0X3QgYWRk
ciwgZmxhZ3M7Cj4+IC3CoMKgwqAgaW50IHI7Cj4+ICvCoMKgwqAgaW50IHIsIGk7Cj4+IMKgIMKg
wqDCoMKgwqAgaWYgKGJvLT5tZW0uc3RhcnQgIT0gQU1ER1BVX0JPX0lOVkFMSURfT0ZGU0VUKQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IEBAIC0xMDE0LDYgKzEwMTQsOSBAQCBp
bnQgYW1kZ3B1X3R0bV9hbGxvY19nYXJ0KHN0cnVjdCAKPj4gdHRtX2J1ZmZlcl9vYmplY3QgKmJv
KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPj4gwqAgK8KgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1f
dm1odWJzOyBpKyspCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9nbWNfZmx1c2hf
Z3B1X3RsYihhZGV2LCAwLCBpLCAwKTsKPj4gKwo+Cj4gUHJvYmFibHkgYmVzdCB0byBtYWtlIHRo
YXQgYSBmdW5jdGlvbiBpbiBhbWRncHVfZ2FydC5jIHRvIGtlZXAgdGhlIAo+IEdBUlQgZnVuY3Rp
b25hbGl0eSBwcm9wZXJseSBhYnN0cmFjdGVkLgo+Cj4gVGhpcyBjYW4gdGhlbiBiZSBjYWxsZWQg
ZnJvbSBib3RoIGFtZGdwdV9ndHRfbWdyX3JlY292ZXIoKSBhZnRlciAKPiBkcm9wcGluZyB0aGUg
bG9jayBhbmQgaGVyZS4KCgpUaGFua3MsIENocmlzdGlhbiEgSSB3aWxsIHJlc2VuZC4KCgpOaXJt
b3kKCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdHRt
X3Jlc291cmNlX2ZyZWUoYm8sICZiby0+bWVtKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJvLT5t
ZW0gPSB0bXA7Cj4+IMKgwqDCoMKgwqAgfQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
