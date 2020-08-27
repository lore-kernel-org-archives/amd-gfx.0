Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD684C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 03:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AF12076C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 03:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a0jtDdLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AF12076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D626E15E;
	Thu, 27 Aug 2020 03:36:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF2F6E15E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 03:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUbrFSLBx4STrKiMpirC3tI0QYJArWgFAj7XJT4fbS9Tu5KO1cTMN7yS6Kq1jlWkgmsLmXHaESLhYnYhjE4T6ze9dtUsSsKd8IsxUSqtZutAWiGHA34WIylHWmfaQZDe+EoGtWLTppDj+Wb/NcuK1ISJDu8eMnZS+rLSlIYS9qnfJ4mlUhWQuU/LuxD0oPOvg+GxJj1tTSCpS/jG+aCAsJTYasBHEZmLM5SIKDhUN/Adnwx5UTW/s4sHuOpx5ArDquJDbuHSRM2ww5pxpot5L4Ec7b6OJk1rTyuXejXsiTkqL/sEQ+dNMttg9KVpxlsjg6wUZ7PK6W3VO0SmP49pSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBpXfzIPy1Mf5H+dy/la+iIjauDyQhcU0obhCH39JVo=;
 b=HX1u1vpnliM7dB2OyqbstQzDl+vCExzdFDDpGu9EZjmsfnq4/CkeA5QPFu8FwQfdTHbiZ4wdXzbiHipEouDrTp2L6CsDoQmIxPz5Wu71m6+bi1+ao+80qgLG8vMp4nz0JBzWIdFT5+ZyXGGl+b1NM4GDRU6SaoC/kY1jiBIdbPwKgfWU14TqsfKq7XE1bzEZRW/EB2YD2s3gDmtImkwbXnXifnVFVbIh2M8k0BgCrs5dee5xVIuFpdm3Xjrnkv0RHONl5LfFyvjGe9zjV2sqEpPk+VPCMzULtXRdds/U1TQ8t5uPpgFd2jpgMBhuuFUkW5RhTVg8LE6LqRlMnkggeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBpXfzIPy1Mf5H+dy/la+iIjauDyQhcU0obhCH39JVo=;
 b=a0jtDdLbOtojc5J2FD1kEk81JrQwnmlCGV5RSswnh2tjOediWODDGCY7Izrf1araywiL6SckNSSXPuPA8U+bp8n+YhtXHRaoUCoBDt6nKc1IZ2kTd7gNpO1hEB5PmQb6YRSNBK0ytguH5/phWISE3st+fIOCz2poOspSBs2KI1w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 03:36:22 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 03:36:22 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Add GPU reset SMI event
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200826200131.31180-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1fcf6a89-578f-e514-da0e-7f66c0bda32b@amd.com>
Date: Wed, 26 Aug 2020 23:36:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200826200131.31180-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 03:36:21 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bac2d8cb-cfa8-4866-5b15-08d84a3a5e1a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2767E9CFECAE1699F73D111E92550@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Q1Pkw5DZonv1gmLXUK/vWeQxdk+DpXIGNjrtLwTYFGEK597+ECLg5hAUscO6IYrFTVryWrIuKJ+WMKsC3BJ9KtzTH7PlOis+Ugkaq+u5avG9ngnvCU9hGUpv9LCna27MWmfG3nfHHk/Vp/Pgp3spQB6/j2+Llifh+yRDmISJXCkkG2e5O/Gq2eED/qxTR0IvPrtWD9yQe28ri589F/4DvbfR0WULw1nPM40+oiHaeWhcobE/Nw/c5gazvhyi5hD2Av+4D/STNtv3zebKR/yiALKNP+W5Rh0PQ4vY+eDbcJcdKzYHl5iMgx6PSUC1/96ApMlmsE8mG58izUJJ84NJrE4wxqs8HgGvDm/29gza3wfOU5A0N3Hh40lbfyk1aR/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(6486002)(5660300002)(52116002)(31686004)(186003)(478600001)(2906002)(66946007)(8676002)(26005)(956004)(66476007)(86362001)(83380400001)(44832011)(66556008)(8936002)(2616005)(316002)(31696002)(16576012)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ScqnkiS90UMOXi4jEZaYWZr/AUlQSnWzVuFlbW3vZBqQGJX0rqJcWj2FVfkJGsTFs63u/I100o+j6doFGQO7r8yKHodBo1alfqRZGZMeZD9ZAILnqN2c0jSq/NOSszUWf/BX8AAUJ5t32UwQaVHH5vSLK7GsW4+ccmB5BhqODBkFBFvWcIIOt3+l7LK0qIiFojU7mbFVeHzf5YUhRKNZ83/3yQUJnsc/zUhxq62cz+c1Gh6FketiZYPTAipirig49jjPChx7FJ0m6Tl1FvyTEpJTVI/VzDzIfu7GgnA35/qB4tw2twHUQMjYEY1i/Y4v9TRdhwW9dSf3WPIbIi6Wo5nuGnUEXagrfsQpBjklil3ywLSGvizi9N93GMdHMJ7mk9rlGzdac72n4Wt7Mo8yB7djC0V+y6+2I7q4w8ilTmNjxW07RJDJw4bQ8fw31A2J8KiWmQDOFxHC61lTLKOUmjXy1kzHrSyPZ4O6b5gIqa7ApR/jJ7v4plQDMHvIouVkSuegeiMWA/G7t7SnhO/m5e1Bjm1xHeBAjaTj6/plOegEZlllCRSfQSeKwiCwxoRknbQ9eFKLMlJg39MEQBOYCt1deWTl3mkKQdI3SAo87tQ8gl2usCMAvhmEB0AOv4Qpl8+rOvSlXeMxDsZqVDSnVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac2d8cb-cfa8-4866-5b15-08d84a3a5e1a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 03:36:22.2268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZENiOuIVwESOhVGUAQTrLITGfAz/5so23chfVohgAx09B2exl7/m0qbjj6DsAXdMF6vsY5bIji232QrMCTodg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
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

QW0gMjAyMC0wOC0yNiB1bSA0OjAxIHAubS4gc2NocmllYiBNdWt1bCBKb3NoaToKPiBBZGQgc3Vw
cG9ydCBmb3IgcmVwb3J0aW5nIEdQVSByZXNldCBldmVudHMgdGhyb3VnaCBTTUkuIEtGRAo+IHdv
dWxkIHJlcG9ydCBib3RoIHByZSBhbmQgcG9zdCBHUFUgcmVzZXQgZXZlbnRzLgo+Cj4gU2lnbmVk
LW9mZi1ieTogTXVrdWwgSm9zaGkgPG11a3VsLmpvc2hpQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyAgICAgfCAgNCArKysKPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCAgICAgICB8ICAyICsrCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zbWlfZXZlbnRzLmMgfCAzMCArKysrKysrKysrKysrKysr
KysrKysKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3NtaV9ldmVudHMuaCB8ICAx
ICsKPiAgaW5jbHVkZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oICAgICAgICAgICAgICB8ICAyICsr
Cj4gIDUgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+IGluZGV4IGUxY2Q2NTk5NTI5Zi4uYWFkMWVjZmExMjM5
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+IEBAIC04MTIs
NiArODEyLDggQEAgaW50IGtnZDJrZmRfcHJlX3Jlc2V0KHN0cnVjdCBrZmRfZGV2ICprZmQpCj4g
IAlpZiAoIWtmZC0+aW5pdF9jb21wbGV0ZSkKPiAgCQlyZXR1cm4gMDsKPiAgCj4gKwlrZmRfc21p
X2V2ZW50X3VwZGF0ZV9ncHVfcmVzZXQoa2ZkLCBmYWxzZSk7Cj4gKwo+ICAJa2ZkLT5kcW0tPm9w
cy5wcmVfcmVzZXQoa2ZkLT5kcW0pOwo+ICAKPiAgCWtnZDJrZmRfc3VzcGVuZChrZmQsIGZhbHNl
KTsKPiBAQCAtODMzLDYgKzgzNSw4IEBAIGludCBrZ2Qya2ZkX3Bvc3RfcmVzZXQoc3RydWN0IGtm
ZF9kZXYgKmtmZCkKPiAgCWlmICgha2ZkLT5pbml0X2NvbXBsZXRlKQo+ICAJCXJldHVybiAwOwo+
ICAKPiArCWtmZF9zbWlfZXZlbnRfdXBkYXRlX2dwdV9yZXNldChrZmQsIHRydWUpOwo+ICsKCllv
dSBzaG91bGQgZ2VuZXJhdGUgdGhlIG1lc3NhZ2Ugb25seSBhZnRlciBzdWNjZXNzZnVsbHkgcmVz
dW1pbmcgS0ZELgoKCj4gIAlyZXQgPSBrZmRfcmVzdW1lKGtmZCk7Cj4gIAlpZiAocmV0KQo+ICAJ
CXJldHVybiByZXQ7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcml2LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCj4gaW5kZXgg
MThiYzcxMWY5N2FlLi5iMWEyOTc5ZTA4NmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3ByaXYuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9wcml2LmgKPiBAQCAtMzEyLDYgKzMxMiw4IEBAIHN0cnVjdCBrZmRfZGV2IHsKPiAgCS8q
IENsaWVudHMgd2F0Y2hpbmcgU01JIGV2ZW50cyAqLwo+ICAJc3RydWN0IGxpc3RfaGVhZCBzbWlf
Y2xpZW50czsKPiAgCXNwaW5sb2NrX3Qgc21pX2xvY2s7Cj4gKwo+ICsJdWludDY0X3QgcmVzZXRf
c2VxX251bTsKCjY0LWJpdCBtYXkgYmUgb3ZlcmtpbGwuIElmIHlvdSdyZSByZXNldHRpbmcgeW91
ciBHUFUgc28gZnJlcXVlbnRseSB0aGF0CmEgMzItYml0IGNvdW50ZXIgb3ZlcmZsb3dzLCBub2Jv
ZHkgd2FudHMgdG8gYnV5IHRoYXQgR1BVLiA7KQoKCj4gIH07Cj4gIAo+ICBlbnVtIGtmZF9tZW1w
b29sIHsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3NtaV9l
dmVudHMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zbWlfZXZlbnRzLmMKPiBp
bmRleCA0ZDRiNmUzYWI2OTcuLjRmMDU5MGJjYjFhMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfc21pX2V2ZW50cy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3NtaV9ldmVudHMuYwo+IEBAIC0xNzQsNiArMTc0LDM2IEBAIHN0YXRp
YyB2b2lkIGFkZF9ldmVudF90b19rZmlmbyhzdHJ1Y3Qga2ZkX2RldiAqZGV2LCB1bnNpZ25lZCBp
bnQgc21pX2V2ZW50LAo+ICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gIH0KPiAgCj4gK3ZvaWQga2Zk
X3NtaV9ldmVudF91cGRhdGVfZ3B1X3Jlc2V0KHN0cnVjdCBrZmRfZGV2ICpkZXYsIGJvb2wgcG9z
dF9yZXNldCkKPiArewo+ICsJLyoKPiArCSAqIEdwdVJlc2V0IG1zZyA9IFJlc2V0IHNlcSBudW1i
ZXIgKGluY3JlbWVudGVkIGZvcgo+ICsJICogZXZlcnkgcmVzZXQgbWVzc2FnZSBzZW50IGJlZm9y
ZSBHUFUgcmVzZXQpLgo+ICsJICogMSBieXRlIGV2ZW50ICsgMSBieXRlIHNwYWNlICsgMTYgYnl0
ZXMgc2VxIG51bSArCj4gKwkgKiAxIGJ5dGUgXG4gKyAxIGJ5dGUgXDAgPSAyMAo+ICsJICovCj4g
KwljaGFyIGZpZm9faW5bMjBdOwo+ICsJaW50IGxlbjsKPiArCXVuc2lnbmVkIGludCBldmVudDsK
PiArCj4gKwlpZiAobGlzdF9lbXB0eSgmZGV2LT5zbWlfY2xpZW50cykpIHsKPiArCQlyZXR1cm47
Cj4gKwl9Cj4gKwo+ICsJbWVtc2V0KGZpZm9faW4sIDB4MCwgc2l6ZW9mKGZpZm9faW4pKTsKPiAr
Cj4gKwlpZiAocG9zdF9yZXNldCkgewo+ICsJCWV2ZW50ID0gS0ZEX1NNSV9FVkVOVF9HUFVfUE9T
VF9SRVNFVDsKPiArCX0gZWxzZSB7Cj4gKwkJZXZlbnQgPSBLRkRfU01JX0VWRU5UX0dQVV9QUkVf
UkVTRVQ7Cj4gKwkJKysoZGV2LT5yZXNldF9zZXFfbnVtKTsKClRoaXMgc2VxdWVuY2UgbnVtYmVy
IGlzIHBlci1kZXZpY2UuIFdoZW4gbXVsdGlwbGUgR1BVcyBpbiBhbiBYR01JIGhpdmUKZ2V0IHJl
c2V0IHRvZ2V0aGVyLCBlYWNoIEdQVSB3b3VsZCBnZXQgaXRzIG93biB1bmNvcnJlbGF0ZWQgcmVz
ZXQKc2VxdWVuY2UgbnVtYmVyLiBJdCBtYXkgaGFwcGVuIHRvIGJlIHRoZSBzYW1lIG51bWJlciwg
YnV0IEkgZG9uJ3QgdGhpbmsKaXQgY2FuIGJlIGd1YXJhbnRlZWQuCgpPbiB0aGUgb3RoZXIgaGFu
ZCwgd2hlbiB0d28gbm9uLVhHTUkgR1BVcyBhcmUgcmVzZXQgYXQgZGlmZmVyZW50IHRpbWVzLAp0
aGV5IGNvdWxkIGdldCB0aGUgc2FtZSBzZXF1ZW5jZSBudW1iZXIsIGFsdGhvdWdoIHRoZSB0d28g
cmVzZXRzIHdlcmUKY2F1c2VkIGJ5IGRpZmZlcmVudCB1bnJlbGF0ZWQgZXZlbnRzLCBhbmQgaGFw
cGVuZWQgYXQgZGlmZmVyZW50IHRpbWVzLgoKSXQgd291bGQgYmUgYmV0dGVyIHRvIGhhdmUgYSBn
bG9iYWwgcmVzZXQgc2VxdWVuY2UgbnVtYmVyIHRoYXQgY2FuIGJlCnVzZWQgdG8gY29ycmVsYXRl
IEdQVSByZXNldHMgdGhhdCBoYXBwZW4gdG8gbXVsdGlwbGUgR1BVcyAoaW4gYW4gWEdNSQpoaXZl
KSBhdCB0aGUgc2FtZSB0aW1lLCBjYXVzZWQgYnkgdGhlIHNhbWUgZXZlbnQuIFRoZSBlYXNpZXN0
IHdheSB0bwphY2hpZXZlIHRoaXMgd291bGQgYmUsIHRvIHVzZSBhIGdsb2JhbCByZXNldF9zZXFf
bnVtIGFuZCBpbmNyZW1lbnQgaXQKb25seSBpbiBrZ2Qya2ZkX3ByZV9yZXNldCBpZiBhdG9taWNf
cmVhZCgma2ZkX2xvY2tlZCkgaXMgMCAoaS5lLiBvbiB0aGUKZmlyc3QgR1BVIHRoYXQncyBnZXR0
aW5nIHJlc2V0IGF0IHRoZSBzYW1lIHRpbWUpLgoKCj4gKwl9Cj4gKwo+ICsJbGVuID0gc25wcmlu
dGYoZmlmb19pbiwgMjAsICIleCAlbGx4XG4iLCBldmVudCwgZGV2LT5yZXNldF9zZXFfbnVtKTsK
CkEgc2FmZXIsIG1vcmUgbWFpbnRhaW5hYmxlIHdheSB3b3VsZCBiZSB0byB3cml0ZSAic2l6ZW9m
KGZpZm9faW4pIgppbnN0ZWFkIG9mIGhhcmQtY29kaW5nIDIwLgoKUmVnYXJkcywKwqAgRmVsaXgK
Cgo+ICsKPiArCWFkZF9ldmVudF90b19rZmlmbyhkZXYsIGV2ZW50LCBmaWZvX2luLCBsZW4pOwo+
ICt9Cj4gKwo+ICB2b2lkIGtmZF9zbWlfZXZlbnRfdXBkYXRlX3RoZXJtYWxfdGhyb3R0bGluZyhz
dHJ1Y3Qga2ZkX2RldiAqZGV2LAo+ICAJCQkJCSAgICAgdWludDMyX3QgdGhyb3R0bGVfYml0bWFz
aykKPiAgewo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc21p
X2V2ZW50cy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3NtaV9ldmVudHMuaAo+
IGluZGV4IDE1NTM3YjJjY2NiNS4uYjliMDQzODIwMmUyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zbWlfZXZlbnRzLmgKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfc21pX2V2ZW50cy5oCj4gQEAgLTI3LDUgKzI3LDYgQEAgaW50IGtm
ZF9zbWlfZXZlbnRfb3BlbihzdHJ1Y3Qga2ZkX2RldiAqZGV2LCB1aW50MzJfdCAqZmQpOwo+ICB2
b2lkIGtmZF9zbWlfZXZlbnRfdXBkYXRlX3ZtZmF1bHQoc3RydWN0IGtmZF9kZXYgKmRldiwgdWlu
dDE2X3QgcGFzaWQpOwo+ICB2b2lkIGtmZF9zbWlfZXZlbnRfdXBkYXRlX3RoZXJtYWxfdGhyb3R0
bGluZyhzdHJ1Y3Qga2ZkX2RldiAqZGV2LAo+ICAJCQkJCSAgICAgdWludDMyX3QgdGhyb3R0bGVf
Yml0bWFzayk7Cj4gK3ZvaWQga2ZkX3NtaV9ldmVudF91cGRhdGVfZ3B1X3Jlc2V0KHN0cnVjdCBr
ZmRfZGV2ICpkZXYsIGJvb2wgcG9zdF9yZXNldCk7Cj4gIAo+ICAjZW5kaWYKPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2tm
ZF9pb2N0bC5oCj4gaW5kZXggY2IxZjk2M2E4NGUwLi44YjczNjhiZmJkODQgMTAwNjQ0Cj4gLS0t
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xp
bnV4L2tmZF9pb2N0bC5oCj4gQEAgLTQ1Myw2ICs0NTMsOCBAQCBlbnVtIGtmZF9zbWlfZXZlbnQg
ewo+ICAgICAgICAgIEtGRF9TTUlfRVZFTlRfTk9ORSA9IDAsIC8qIG5vdCB1c2VkICovCj4gICAg
ICAgICAgS0ZEX1NNSV9FVkVOVF9WTUZBVUxUID0gMSwgLyogZXZlbnQgc3RhcnQgY291bnRpbmcg
YXQgMSAqLwo+ICAgICAgICAgIEtGRF9TTUlfRVZFTlRfVEhFUk1BTF9USFJPVFRMRSA9IDIsCj4g
KwlLRkRfU01JX0VWRU5UX0dQVV9QUkVfUkVTRVQgPSAzLAo+ICsJS0ZEX1NNSV9FVkVOVF9HUFVf
UE9TVF9SRVNFVCA9IDQsCj4gIH07Cj4gIAo+ICAjZGVmaW5lIEtGRF9TTUlfRVZFTlRfTUFTS19G
Uk9NX0lOREVYKGkpICgxVUxMIDw8ICgoaSkgLSAxKSkKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
