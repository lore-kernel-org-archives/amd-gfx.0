Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F2C48BE6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 04:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB7060E0B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 04:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB7060E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E4E46E4CD;
	Wed, 16 Jun 2021 04:36:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C786E4CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 04:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDQZBugeaU67cSDnrzowkQkXN26EtdrAdGDAwnqgREv6+h7P2RKI+4cHiKLrweGzO/v+8APWIq59P1/p3KqKOttgSy0caVsGb8IhIpy2utNPY7nSrxGcdmTdok56O1xS2X2pI0de3LOd6gMzUd33fWoMEPz/eek9tCMc2rghI1se+RyroLi7hCkI9e+sGrqkwh5Wx8zltagIa037lJsCcIQO/KEYJvoQzP8gVr+/rt+P3+oyBV94NTtbKRvFbxNOAOdCVY95sY2O0oYZQZkVwmdgdekN6xwG090FmntEF8awnTMYmZdGE/wZEZMkV18t8Muw87T237fa1gdH0WczPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLPxKxbELQnuOd3jicrVg08/kKB8HzgDDPQ78sFXlz0=;
 b=f2Q+QOxWtBnnkxURPfKEH2RQziTNaRve6/PsD0NGXy6S9y5060PkjqClwZLRLtPmTPRMAuo6p3opuc0ubjMwH1cUiUIBr60OMzDHbnEVLwnuA3OxDWeFGAHGGPFORcrBq6u5A/FBxcS1XWOMYYNwUGTGyY0jAHNJE3H0u38060Z38plXfgDXtwBvGZjAKk7QMo0jFbe4SbG4NyhqwIIHEEv6fLHXkOIyy9VSr+ti6D6yowOlffDzho4WCSH3ShGigsHlp+CtCnuzH6xBVpEeHkqnE2wahvmcCR4fOr9dIYWR05VKstQqBjOGfAflbGuegs4KX5WNGf9IIeqzqEXxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLPxKxbELQnuOd3jicrVg08/kKB8HzgDDPQ78sFXlz0=;
 b=ehH8eNhjcEdXLCyxBOf7sRDeCCjggMJow7xg7Ej4R5viHpDV4Ax1OhRN+wyQYVZSzZwNL4d5YPL0XI8BYglWUF25KjdhCgfKuhq3FYU5Sp2/CARvqq90L/8/Ys0vMNSnul0n+o4FwP4T3nwo0POBd5HH0mL8yLcAs0myi+famu8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Wed, 16 Jun 2021 04:36:14 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::e9ed:b713:2dd6:97ec]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::e9ed:b713:2dd6:97ec%8]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 04:36:14 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix circular lock in nocpsch path
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20210615175049.18382-1-Amber.Lin@amd.com>
 <a933d395-621b-52ab-da31-9e8de8525772@amd.com>
 <A1E8DF67-7630-4F63-BB42-F153E3405112@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e22394ca-8cc5-9d8f-453e-68d95744090f@amd.com>
Date: Wed, 16 Jun 2021 00:36:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <A1E8DF67-7630-4F63-BB42-F153E3405112@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::18) To DM4PR12MB5133.namprd12.prod.outlook.com
 (2603:10b6:5:390::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 04:36:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e8d378-a622-4e0b-6546-08d930804640
X-MS-TrafficTypeDiagnostic: DM4PR12MB5358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53581D0EE5D16DC5E0E61971920F9@DM4PR12MB5358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZ7HZlncMmkIjsZUSpItWNuVtVJtIF42pqAmYEztf7LPavq9roA46B4MRy3/0nIklmgFtY17kcnnJQOQ9tmnPpRiFaXMg7XXdhc5JNZfCD3cikNSAzxQNzVVLj4F5v3SB3C++APK7eudRMhcIptB6vyqULGkC/by7/oY/I5Q3CSYOEU/QkSQdQggIAp4Ipe8Mjkx9XV9dkUvPdTnzevPsISAchw1TxTnDOaRS3+pg6fg9VPn6qyMAUUoGYDinzJ32Ke5ULNcSHyqxYtS4m1S1EI41QraIABcVC96R1QYQI6H7Q6pskWjG6xK1ddqeCeMLtVb5ZWa6WlfzHZzNfnd1o7ukwURIFeUsgEXIfi6JD+EPnKn0TJHg0LBN6Cjhnpbhdsno/kplDATHgsEDqTtr+qAu8uKW1lKkdy9VOkrLNBeVp2z3O9H0HMgIYN+elLKvBfJjHvuhBBnJzbV/ZlXBV/u4lOabHS+FM0PDlhogffGLu9i5ahJrf5nMaWFYIHvcK7fjrRJGHsHYtghUYMUxcYHqdS48SDXHZ7hMY6gYpmVMLiQcezqU1gdmoTovD/tCQhI7XMJt5BqFnTh/FYh76ZTqXUEMWShfIC9aipCpksoWWvYzwUmFx6/2GkZh8oLWhNTirNb+Z0mw05U4j/de9Cm56JDNSZYTZqoLytazmrzRXFHK2U8aZu3ObQk3NMs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(8676002)(38100700002)(2906002)(4326008)(66556008)(26005)(66476007)(16526019)(186003)(8936002)(86362001)(6486002)(31686004)(16576012)(44832011)(2616005)(478600001)(83380400001)(31696002)(6862004)(37006003)(5660300002)(6636002)(54906003)(956004)(316002)(36756003)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBNN2c2Y0NnVmZXdTFndGlMZVU2cnFkWlBPYVA0RmVxcTA3VlBNMlBsQXN2?=
 =?utf-8?B?VXN5cjRWd1FvZldneEQ3b1dJdmdFYS9tNVRvaWlyc01tQ3JadWNRZi9SdlA2?=
 =?utf-8?B?VnN2THdWcTBWalpBVUNqVWJSVXA0VElhcG53NFZBYkkzcTVNbk51V3FUUXly?=
 =?utf-8?B?c2o3VDU1d0plak5mL1daT0NhZGhvbDQrLzFNd2RySWl2d0J3Q1BNY2JYcXJF?=
 =?utf-8?B?cUdYNDFTUnlpdGdEZlNDaWhXR0dKQ2ZzbncwRm8wMEtoQ0xOSHlyUFBIcVQ4?=
 =?utf-8?B?L0cvdXNNNVBhM3FPVDZSakxqRDBrOTNKOEVDZkZ1NWFvaWJZM2N0d1N3Mm05?=
 =?utf-8?B?andqQk1KWEVia0JqL1ZLNU1MQnBJUXdVUFduT0dIUXdZTFphbnhVaVRkQ3lY?=
 =?utf-8?B?LzJvalAvcDFHWkthMEQ5VnlndHB1cFZMY3JZeFRDQW5OVFBxNjFVSmNra3pZ?=
 =?utf-8?B?YUErRjJhTm9kRW9uaXVzVHd3ZGdPUXY2eUIyUkRNdklHVTUwRFhkOFNya3JC?=
 =?utf-8?B?MGJQaHNnQW1JTnNpOXZJWkZFRSs2VlpWcW1lNFl3ZVE2VEsxRUJZVFFjSmx0?=
 =?utf-8?B?R0tHOEdpUDYzSk8vR2o5bEJTQWo3SzNjNHJjS3o2OStEZHorY0JJb21lUjVw?=
 =?utf-8?B?TENVMGIzQVBzV1dGekl1UGswY0ZkQlNXV0o1by91TWREaEpLV0NkZUkvdlZR?=
 =?utf-8?B?YnpnMmVPeFlqWmczWGdRQUVzSTFJcndiU2Urei93cWErWnJWQVZvazZtblZP?=
 =?utf-8?B?UzVxQTVsSWxwMEZIV0hFQjBEMTY3UmNZaFZ0RzBSdlgzMTk5MUVpdldPUWhU?=
 =?utf-8?B?L3Jqb3FNMzBDQk9QdEhPRDZnQ1FJMllqc1VmK2JXMjVMb3hhczhWSGJpNmpI?=
 =?utf-8?B?UnRyU2g1MHhIZWJmU2VNajBvMjVwSW1ReFBlOERLSVJhMVF5MldIcXBML1NR?=
 =?utf-8?B?NnhDaUJkbXRHUHhJaWpLSXRWTE5WakxhbnVwdjljUHF3dG9YYzIwUDluM2lx?=
 =?utf-8?B?aDZ1blAwMVJVYnZCRkZWbjl0OHZLelc3VEdiODF2b2dGSTdkR0ZuWFNrU0po?=
 =?utf-8?B?aExzRFRCd0ZhT01jQ0NZSkNRUi9JSEV1ZnlKWkZlUzIvMlBJbjhwdFhySWZZ?=
 =?utf-8?B?bVJMY0tHUE5FTUtUY1FqMG10Yi96SkVaM1U4U25EeVNPZ3JLZkY1dEYwYXJo?=
 =?utf-8?B?V2xSa2FpdzNtTTNQVXdnWkpZNlVEOGJWUW1yQTd6dGE3TTBqL0ZTejRZaHg0?=
 =?utf-8?B?b3dhL1htYmhhVW0xeml5QWhyYW9FazdpNFRtN0tqMWdkWGsvR29XdzNWSEVG?=
 =?utf-8?B?VG1acDNITWg3MlE1R0thdXFyU2xuNDl5UlFpSDZGWEhBZit5SG0vRW14bXh4?=
 =?utf-8?B?UTdqZTdqdjZtc1JyV01Ya1dHOUt0Q2h6UjM2VVVrQVJHWmNHQklDQkxETTcr?=
 =?utf-8?B?YWQzcVNyWDBqalM1aUs1U1BvL1IzcWVHeEp4a3ZJZUhtZmNmeDZMK0NDM2xU?=
 =?utf-8?B?d1ZuczRWZHpqUlh3QzVzU2s4cjVWNDlOUHZGUmtQb3poZVpmRmswUzJnUWtX?=
 =?utf-8?B?aGxzTkgyUDRBVmNFM0tDS1R6RU1sL21qTjFxL0ZTTS9OSjgvTkNhZTJQWWh1?=
 =?utf-8?B?K0hVZmxWaEkvS3draXZNUXZaS1hCUmVqdXVIc2pNOU5Pd3VSanZmdlVaUFRv?=
 =?utf-8?B?Mll3OHZRMFBwcTRpR29IRUVVQm5nSW1mSk9vQ0FnMmZiNDJSNmFWRUlDL3hw?=
 =?utf-8?Q?Hyg7XM9yiWYvSCdJT7w1DQcmH5VQMhVKIJuhyhc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e8d378-a622-4e0b-6546-08d930804640
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 04:36:14.3900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiR76x/NujYa5sfqCsgaWQMYw2Q7MiUaVlTFUhKDQrpuvamUna5y5SbxoJDhZkpbfibb0uzIklXHOSkDPdK0cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0xNiB1bSAxMjowMSBhLm0uIHNjaHJpZWIgUGFuLCBYaW5odWk6Cj4+IDIwMjHl
ubQ25pyIMTbml6UgMDI6MjLvvIxLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5j
b20+IOWGmemBk++8mgo+Pgo+PiBbK1hpbmh1aV0KPj4KPj4KPj4gQW0gMjAyMS0wNi0xNSB1bSAx
OjUwIHAubS4gc2NocmllYiBBbWJlciBMaW46Cj4+PiBDYWxsaW5nIGZyZWVfbXFkIGluc2lkZSBv
ZiBkZXN0cm95X3F1ZXVlX25vY3BzY2hfbG9ja2VkIGNhbiBjYXVzZSBhCj4+PiBjaXJjdWxhciBs
b2NrLiBkZXN0cm95X3F1ZXVlX25vY3BzY2hfbG9ja2VkIGlzIGNhbGxlZCB1bmRlciBhIERRTSBs
b2NrLAo+Pj4gd2hpY2ggaXMgdGFrZW4gaW4gTU1VIG5vdGlmaWVycywgcG90ZW50aWFsbHkgaW4g
RlMgcmVjbGFpbSBjb250ZXh0Lgo+Pj4gVGFraW5nIGFub3RoZXIgbG9jaywgd2hpY2ggaXMgQk8g
cmVzZXJ2YXRpb24gbG9jayBmcm9tIGZyZWVfbXFkLCB3aGlsZQo+Pj4gY2F1c2luZyBhbiBGUyBy
ZWNsYWltIGluc2lkZSB0aGUgRFFNIGxvY2sgY3JlYXRlcyBhIHByb2JsZW1hdGljIGNpcmN1bGFy
Cj4+PiBsb2NrIGRlcGVuZGVuY3kuIFRoZXJlZm9yZSBtb3ZlIGZyZWVfbXFkIG91dCBvZgo+Pj4g
ZGVzdHJveV9xdWV1ZV9ub2Nwc2NoX2xvY2tlZCBhbmQgY2FsbCBpdCBhZnRlciB1bmxvY2tpbmcg
RFFNLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEFtYmVyIExpbiA8QW1iZXIuTGluQGFtZC5jb20+
Cj4+PiBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
Cj4+IExldCdzIHN1Ym1pdCB0aGlzIHBhdGNoIGFzIGlzLiBJJ20gbWFraW5nIHNvbWUgY29tbWVu
dHMgaW5saW5lIGZvcgo+PiB0aGluZ3MgdGhhdCBYaW5odWkgY2FuIGFkZHJlc3MgaW4gaGlzIHJh
Y2UgY29uZGl0aW9uIHBhdGNoLgo+Pgo+Pgo+Pj4gLS0tCj4+PiAuLi4vZHJtL2FtZC9hbWRrZmQv
a2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgIHwgMTggKysrKysrKysrKysrKy0tLS0tCj4+PiAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9t
YW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21h
bmFnZXIuYwo+Pj4gaW5kZXggNzJiZWE1Mjc4YWRkLi5jMDY5ZmEyNTliMzAgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
Ywo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9t
YW5hZ2VyLmMKPj4+IEBAIC00ODYsOSArNDg2LDYgQEAgc3RhdGljIGludCBkZXN0cm95X3F1ZXVl
X25vY3BzY2hfbG9ja2VkKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLAo+Pj4gCWlm
IChyZXR2YWwgPT0gLUVUSU1FKQo+Pj4gCQlxcGQtPnJlc2V0X3dhdmVmcm9udHMgPSB0cnVlOwo+
Pj4KPj4+IC0KPj4+IC0JbXFkX21nci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBxLT5tcWRf
bWVtX29iaik7Cj4+PiAtCj4+PiAJbGlzdF9kZWwoJnEtPmxpc3QpOwo+Pj4gCWlmIChsaXN0X2Vt
cHR5KCZxcGQtPnF1ZXVlc19saXN0KSkgewo+Pj4gCQlpZiAocXBkLT5yZXNldF93YXZlZnJvbnRz
KSB7Cj4+PiBAQCAtNTIzLDYgKzUyMCw4IEBAIHN0YXRpYyBpbnQgZGVzdHJveV9xdWV1ZV9ub2Nw
c2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLAo+Pj4gCWludCByZXR2YWw7Cj4+
PiAJdWludDY0X3Qgc2RtYV92YWwgPSAwOwo+Pj4gCXN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2Ug
KnBkZCA9IHFwZF90b19wZGQocXBkKTsKPj4+ICsJc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWdy
ID0KPj4+ICsJCWRxbS0+bXFkX21ncnNbZ2V0X21xZF90eXBlX2Zyb21fcXVldWVfdHlwZShxLT5w
cm9wZXJ0aWVzLnR5cGUpXTsKPj4+Cj4+PiAJLyogR2V0IHRoZSBTRE1BIHF1ZXVlIHN0YXRzICov
Cj4+PiAJaWYgKChxLT5wcm9wZXJ0aWVzLnR5cGUgPT0gS0ZEX1FVRVVFX1RZUEVfU0RNQSkgfHwK
Pj4+IEBAIC01NDAsNiArNTM5LDggQEAgc3RhdGljIGludCBkZXN0cm95X3F1ZXVlX25vY3BzY2go
c3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4+PiAJCXBkZC0+c2RtYV9wYXN0X2Fj
dGl2aXR5X2NvdW50ZXIgKz0gc2RtYV92YWw7Cj4+PiAJZHFtX3VubG9jayhkcW0pOwo+Pj4KPj4+
ICsJbXFkX21nci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBxLT5tcWRfbWVtX29iaik7Cj4+
PiArCj4+PiAJcmV0dXJuIHJldHZhbDsKPj4+IH0KPj4+Cj4+PiBAQCAtMTYyOSw3ICsxNjMwLDcg
QEAgc3RhdGljIGJvb2wgc2V0X2NhY2hlX21lbW9yeV9wb2xpY3koc3RydWN0IGRldmljZV9xdWV1
ZV9tYW5hZ2VyICpkcW0sCj4+PiBzdGF0aWMgaW50IHByb2Nlc3NfdGVybWluYXRpb25fbm9jcHNj
aChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwKPj4+IAkJc3RydWN0IHFjbV9wcm9j
ZXNzX2RldmljZSAqcXBkKQo+Pj4gewo+Pj4gLQlzdHJ1Y3QgcXVldWUgKnEsICpuZXh0Owo+Pj4g
KwlzdHJ1Y3QgcXVldWUgKnE7Cj4+PiAJc3RydWN0IGRldmljZV9wcm9jZXNzX25vZGUgKmN1ciwg
Km5leHRfZHBuOwo+Pj4gCWludCByZXR2YWwgPSAwOwo+Pj4gCWJvb2wgZm91bmQgPSBmYWxzZTsK
Pj4+IEBAIC0xNjM3LDEyICsxNjM4LDE5IEBAIHN0YXRpYyBpbnQgcHJvY2Vzc190ZXJtaW5hdGlv
bl9ub2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLAo+Pj4gCWRxbV9sb2Nr
KGRxbSk7Cj4+Pgo+Pj4gCS8qIENsZWFyIGFsbCB1c2VyIG1vZGUgcXVldWVzICovCj4+PiAtCWxp
c3RfZm9yX2VhY2hfZW50cnlfc2FmZShxLCBuZXh0LCAmcXBkLT5xdWV1ZXNfbGlzdCwgbGlzdCkg
ewo+Pj4gKwl3aGlsZSAoIWxpc3RfZW1wdHkoJnFwZC0+cXVldWVzX2xpc3QpKSB7Cj4+PiArCQlz
dHJ1Y3QgbXFkX21hbmFnZXIgKm1xZF9tZ3I7Cj4+PiAJCWludCByZXQ7Cj4+Pgo+Pj4gKwkJcSA9
IGxpc3RfZmlyc3RfZW50cnkoJnFwZC0+cXVldWVzX2xpc3QsIHN0cnVjdCBxdWV1ZSwgbGlzdCk7
Cj4+PiArCQltcWRfbWdyID0gZHFtLT5tcWRfbWdyc1tnZXRfbXFkX3R5cGVfZnJvbV9xdWV1ZV90
eXBlKAo+Pj4gKwkJCQlxLT5wcm9wZXJ0aWVzLnR5cGUpXTsKPj4+IAkJcmV0ID0gZGVzdHJveV9x
dWV1ZV9ub2Nwc2NoX2xvY2tlZChkcW0sIHFwZCwgcSk7Cj4+PiAJCWlmIChyZXQpCj4+PiAJCQly
ZXR2YWwgPSByZXQ7Cj4+PiArCQlkcW1fdW5sb2NrKGRxbSk7Cj4+PiArCQltcWRfbWdyLT5mcmVl
X21xZChtcWRfbWdyLCBxLT5tcWQsIHEtPm1xZF9tZW1fb2JqKTsKPj4+ICsJCWRxbV9sb2NrKGRx
bSk7Cj4+IFRoaXMgaXMgdGhlIGNvcnJlY3Qgd2F5IHRvIGNsZWFuIHVwIHRoZSBsaXN0IHdoZW4g
ZHJvcHBpbmcgdGhlIGRxbS1sb2NrCj4+IGluIHRoZSBtaWRkbGUuIFhpbmh1aSwgeW91IGNhbiB1
c2UgdGhlIHNhbWUgbWV0aG9kIGluCj4+IHByb2Nlc3NfdGVybWluYXRpb25fY3BzY2guCj4+Cj4g
eWVzLCB0aGF0IGlzIHRoZSByaWdodCB3YXkgdG8gd2FsayB0aHJvdWdoIHRoZSBsaXN0LiB0aGFu
a3MuCj4KPgo+PiBJIGJlbGlldmUgdGhlIHN3YXBwaW5nIG9mIHRoZSBxLT5tcWQgd2l0aCBhIHRl
bXBvcmFyeSB2YXJpYWJsZSBpcyBub3QKPj4gbmVlZGVkLiBXaGVuIGZyZWVfbXFkIGlzIGNhbGxl
ZCwgdGhlIHF1ZXVlIGlzIG5vIGxvbmdlciBvbiB0aGUKPj4gcXBkLT5xdWV1ZXNfbGlzdCwgc28g
ZGVzdHJveV9xdWV1ZSBjYW5ub3QgcmFjZSB3aXRoIGl0LiBJZiB3ZSBlbnN1cmUKPj4gdGhhdCBx
dWV1ZXMgYXJlIGFsd2F5cyByZW1vdmVkIGZyb20gdGhlIGxpc3QgYmVmb3JlIGNhbGxpbmcgZnJl
ZV9tcWQsCj4+IGFuZCB0aGF0IGxpc3QtcmVtb3ZhbCBoYXBwZW5zIHVuZGVyIHRoZSBkcW1fbG9j
aywgdGhlbiB0aGVyZSBzaG91bGQgYmUKPj4gbm8gcmlzayBvZiBhIHJhY2UgY29uZGl0aW9uIHRo
YXQgY2F1c2VzIGEgZG91YmxlLWZyZWUuCj4+Cj4gbm8sIHRoZSBkb3VibGUgZnJlZSBleGlzdHMg
YmVjYXVzZSBwcW1fZGVzdHJveV9xdWV1ZSBmZXRjaCB0aGUgcXVldWUgZnJvbSBxaWQgYnkgZ2V0
X3F1ZXVlX2J5X3FpZCgpCj4gdGhlIHJhY2UgaXMgbGlrZSBiZWxvdy4KPiBwcW1fZGVzdHJveV9x
dWV1ZQo+IAlnZXRfcXVldWVfYnlfcWlkCQkJCXByb2Nlc3NfdGVybWluYXRpb25fY3BzY2gKPiAJ
ZGVzdHJveV9xdWV1ZV9jcHNjaAo+IAkJCQkJCQkJbG9jawo+IAkJCQkJCQkJbGlzdF9mb3JfZWFj
aF9lbnRyeV9zYWZlCj4gCQkJCQkJCQkJbGlzdF9kZWwocSkKPiAJCQkJCQkJCXVubG9jawo+IAkJ
CQkJCQkJZnJlZV9tcWQKPiAJbG9jawo+IAlsaXN0X2RlbChxKQo+IAl1bmxvY2sKPiAJZnJlZV9t
cWQKCkkgdGhpbmsgaWYgYm90aCB0aG9zZSB0aHJlYWRzIHRyeSB0byBmcmVlIHRoZSBzYW1lIHF1
ZXVlLCB0aGV5IGJvdGggbmVlZAp0byBob2xkIHRoZSBzYW1lIHByb2Nlc3MtPm11dGV4LiBGb3Ig
cHFtX2Rlc3Ryb3lfcXVldWUgdGhhdCBoYXBwZW5zIGluCmtmZF9pb2N0bF9kZXN0cm95X3F1ZXVl
LiBGb3IgcHJvY2Vzc190ZXJtaW5hdGlvbl9jcHNjaCB0aGF0IGhhcHBlbnMgaW4Ka2ZkX3Byb2Nl
c3Nfbm90aWZpZXJfcmVsZWFzZSBiZWZvcmUgaXQgY2FsbHMKa2ZkX3Byb2Nlc3NfZGVxdWV1ZV9m
cm9tX2FsbF9kZXZpY2VzLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+IAkKPgo+Cj4gIAo+PiBSZWdh
cmRzLAo+PiAgIEZlbGl4Cj4+Cj4+Cj4+PiAJfQo+Pj4KPj4+IAkvKiBVbnJlZ2lzdGVyIHByb2Nl
c3MgKi8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
