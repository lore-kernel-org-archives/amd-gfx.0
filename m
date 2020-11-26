Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B5C56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 16:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE8921D40
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 16:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w6BbAVKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE8921D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FBB6E949;
	Thu, 26 Nov 2020 16:05:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920C36E949
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 16:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmnnG5ixWVTksOcH78C4mDXLdiJIagFKDC9L7L9lKNh1Z6LN2khuWik+HoiGAVK34SDvNdZEXpkjfQGZmFQnmcBI5qQ2HaFwD4REmOVJn9fW7yoreJJaE+SQ/ZA3t1GU1YK2CwwtYMck1WB14QnjyCKmH/Fvh0i+42Jl4nsczyRXxCibInnEyLSn6zseypYlgmBVYWI41UXsz7vnMZpw4SDNwrlml1H4rfteKLSE6/O0/HmO2Zlbl5Se9MHJj4i7dTujdQcwsYEwWi5BAPKIMTwsCY/0w5JHNkZTGuugGtzBeAE0ODVPgy57TCuMm/ZMsB79tnUxCnbFDdBzUp8Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNelKIjBixiKrxUpUjI1GO21xhikv5NHrCYztqC7Fos=;
 b=MYmD7EGIWGVdErjZTODziYsP6e+mRaUKw69GuIkBEeu/CJlthARaV5QZD1/AQWBW10ic+ykOAqWIgktb+8hIMztwhlFc5AKtkxRx1LK+E7oq+xrQa311qrLaZVnKV8AnrUod1dLES6pHTWJPeeLuR6KrSAZZHRhJC215uPHdK5T3zEySR989ymehFFlaCaMfNZoTqUeRZFGx5noFJoibhbFz7yGjC+gjEbf1AluViZ4DpncvpX5bgHEbK6a6FWf0g4qdcr+4zpRhKaUyH0S6tzIq6xb2gvLUUajNkGisHPCl0ZcJh9a2EX3VHdjNFQidRU8x6lsnQ6DaC6/b5IS6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNelKIjBixiKrxUpUjI1GO21xhikv5NHrCYztqC7Fos=;
 b=w6BbAVKbm+GlwsJzrpvOaWVWU8rKuFd/Jltuz1qerlmSn7pStwQPLVY8CS71J4qK3hALX9fzbJ2LVDH6dPzEMOho6nI1JZ6T0IrAEg1vhANpUeflbTELrzR74iEXtqWkNojjywG8dSa/Hizdrt7D83KruofSMOzc+EKxULiRDbg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1939.namprd12.prod.outlook.com (2603:10b6:404:107::12)
 by BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 16:05:26 +0000
Received: from BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c]) by BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c%11]) with mapi id 15.20.3611.023; Thu, 26 Nov
 2020 16:05:26 +0000
Subject: Re: [PATCH] drm/amd/display: Clear dc remote sinks on MST disconnect
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20201126143105.32016-1-aurabindo.pillai@amd.com>
 <ab9f847e-d819-7ff0-f677-c2ee5587b2ae@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Autocrypt: addr=aurabindo.pillai@amd.com; keydata=
 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
 Gul9w6KOPkCni6aOWdaa4kvIZpWBE+E=
Message-ID: <98dbf460-9e63-e1a9-321b-e99320034499@amd.com>
Date: Thu, 26 Nov 2020 11:05:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ab9f847e-d819-7ff0-f677-c2ee5587b2ae@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:404:11::21) To BN6PR12MB1939.namprd12.prod.outlook.com
 (2603:10b6:404:107::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.3.55] (165.204.84.11) by
 BN6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:404:11::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.8 via Frontend Transport; Thu, 26 Nov 2020 16:05:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5deab63e-3b51-405e-d953-08d892251692
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB36041E630F4DF34FECB001438BF90@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqRyJoWfPKVdpErvNemM+2eCaKAOL5nE5lPbaF6Qt/BwXHaQZfWVgkNyet2a6YTrkB9c1TSkEzNhcL/wj+mDSTDnga/Kwmuz2SmjgSgJb1kuHUI6tTXT6/QOaHkOAsd6F+Hqjj94M/k8CxyIB53tL4vxaaVgDaNTG732XjJy59KJoEQKiR+SkmJqpT9dsImBWbMV574ejFXGlJqJvFx0KzqzHrgEQN9uBq9ftaTTzESJ/Y4wdejbxGZ7nhT9Kqyh5mYIhHUXCK8ZIFlPnPlia4xR8lBniYLWZ/ce+UZ4/3XJMFqRJk8T7Tdp7IZQu8OfAzZBdnm/2U0QlW1+65WrLT5nP12/vsnTbHeU8J93Nk7EtScAGm1QDUUkZVYE0c1C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(6486002)(31696002)(66556008)(16576012)(8676002)(8936002)(31686004)(66476007)(316002)(2906002)(66946007)(36756003)(4001150100001)(478600001)(5660300002)(4326008)(83380400001)(186003)(16526019)(26005)(956004)(53546011)(52116002)(2616005)(86362001)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K0hqaXg2NGw4RjR1NkdNV0hsak9XajNuMURaUWxDK3BpL2YzVW4rb0dpaURz?=
 =?utf-8?B?SXFlYVluY1NZcVZSSVNTOHNjRlZQRkZ0U2M4czZrdWdJcEMxS1gvY0JIYVla?=
 =?utf-8?B?VFNxSHBPTmJ1dko1amR2OG44NFhPbXZ4dkxReTVjNzh4dHlwMVk5MG42ckRt?=
 =?utf-8?B?SnFxYlBuY1E5NXlnUFhoUGpiSnE3WlhkWmV6R0RiOExZR29MQVluK1pUd0RN?=
 =?utf-8?B?cGV1NUZMUFd0VTFja1orcEZqYklZZktVUXVXbFpJNnFBazhKRXZndFFBTmpp?=
 =?utf-8?B?bUhxb091YlJkQ0plZklEQWIxUzB5QmVqUWtWcHZEbC81UkxUVzFubWJJeGU0?=
 =?utf-8?B?b2xCUWdYaE9jc3dHSkdQV0Y1end3UDF2TjU0czgxVW1RNFN1emFwNERJMGov?=
 =?utf-8?B?T3MxOVJGME4ySHF4VnhUK0ptcVQ1MkwveWMyT0tIODZvcWJBZlkzRVpKdkE5?=
 =?utf-8?B?ZUl6UjlhVEMxeDJGdlZ5WDdDYjZOem8yWHlGa3NCaVI4bWQ3T2dJZG5hTmRV?=
 =?utf-8?B?UThraWtNam8wLzdqMmRuM3NCZm9DNEpLd1hxRUpBdCtxZ0RqUzcxM0orckpT?=
 =?utf-8?B?VThKVms5MjFVT01Idzh3UkE3eUZSTlEwbXhMand3dFB4K2IrODFkWFByc0R6?=
 =?utf-8?B?aHl0NTB0SncwcG1JNTNJajRPeG85Tm8wUkFTUFN1bThJVkVOdG1yZXZWWTNm?=
 =?utf-8?B?bG1YNXM1QS9kK1ArQkFSbUNlODQwNHoySUk4ckpuTDB6b1l3QXdLck1MNWUz?=
 =?utf-8?B?UTliZ3c5L2VTdlBMMHdxZDg5M0Z5RHhVWUZBczBVNEpQUDhHZXZtZWhmK0s4?=
 =?utf-8?B?NGh3K3FKdDFwWXZWcnNmYU1aNlQ5NUo5MExJNUthUkdOR0NhbFhMZnk5Qm05?=
 =?utf-8?B?WVBTMUVJbGFWNXE4bDZGeXpwb0VFb0I4U25OU3JBZDR4LzI4U013a0xUeitm?=
 =?utf-8?B?aXp6YmNFWjcvVlRLcmlveDJVWXlhWUNUbmFRdkQwSkJyb0M5U3FlUW5mVzAw?=
 =?utf-8?B?RFpORytqandYWURsaFB0dHdDY3diZ0ZEdi9Idy9Hb0s4RzFJdC92eFlrc3hW?=
 =?utf-8?B?MW9UZ0FTUkJNcEc3M2xvK01ZZW9WKzB2TzNTbjlJbks0bTNoZ1g0UDNVRnFQ?=
 =?utf-8?B?MnZmcVBvUndOTEhmeVNSQit1ZFM1U3cxVnhscVE5VWpXQVphZzZ4RGxDakY0?=
 =?utf-8?B?NlUxcWp2eHpjNzRUSmdkUGpsZkIyeG12dG9hVUk1RTNtV04rbDdEc3BRWlZN?=
 =?utf-8?B?R0RRV3NwWjVUbWE1RmVzVncrZVJ2V3NOZFdqaEM1SkM2dkFlUUJZKzFVSzht?=
 =?utf-8?Q?YCiBXmr9skgG63yfrArB2YBnJudl4J1bz2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deab63e-3b51-405e-d953-08d892251692
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 16:05:26.5392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: folHgHwoemlpM9jsBheB15UDAthTjwowbNGwKFQNwbOngeqmWOGKtkkVreJxuAdRL8a1O0Y32VbO7SdcrWBuXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
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
Cc: Harry Wentland <harry.wentland@amd.com>, aurabindo.pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Eryk.Brol@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIwLTExLTI2IDk6MzUgYS5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4g
T24gMjAyMC0xMS0yNiA5OjMxIGEubS4sIEF1cmFiaW5kbyBQaWxsYWkgd3JvdGU6Cj4+IFtXaHkm
SG93XQo+PiBSZWNlbnQgY2hhbmdlcyB0byB1cHN0cmVhbSBtc3QgY29kZSByZW1vdmUgdGhlIGNh
bGxiYWNrIHdoaWNoCj4+IGNsZWFyZWQgdGhlIGludGVybmFsIHN0YXRlIGZvciBtc3QuIE1vdmUg
dGhlIG1pc3NpbmcgZnVuY3Rpb25hbGl0eQo+PiB0aGF0IHdhcyBwcmV2aW91c2x5IGNhbGxlZCB0
aHJvdWdoIHRoZSBkZXN0cm95IGNhbGwgYmFjayBmb3IgbXN0Cj4+IGNvbm5lY3Rvcgo+PiBkZXN0
cm95Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEF1cmFiaW5kbyBQaWxsYWkgPGF1cmFiaW5kby5waWxs
YWlAYW1kLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogRXJ5ayBCcm9sIDxlcnlrLmJyb2xAYW1kLmNv
bT4KPj4gLS0tCj4+IMKgIC4uLi9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBl
cnMuYyB8IDIyICsrKysrKysrKysrKysrKysrLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RtX2hlbHBlcnMuaMKgwqAgfMKgIDIgKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2Vk
LCAyMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVy
cy5jCj4+IGluZGV4IGI3ZDdlYzNiYTAwZC4uZDhiMGYwN2RlYWYyIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1f
aGVscGVycy5jCj4+IEBAIC00MTgsOSArNDE4LDEwIEBAIGJvb2wgZG1faGVscGVyc19kcF9tc3Rf
c3RhcnRfdG9wX21ncigKPj4gwqAgwqAgdm9pZCBkbV9oZWxwZXJzX2RwX21zdF9zdG9wX3RvcF9t
Z3IoCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGNfY29udGV4dCAqY3R4LAo+PiAtwqDC
oMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IGRjX2xpbmsgKmxpbmspCj4+ICvCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgZGNfbGluayAqbGluaykKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRn
cHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yID0gbGluay0+cHJpdjsKPj4gK8KgwqDCoCB1aW50
OF90IGk7Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKCFhY29ubmVjdG9yKSB7Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBEUk1fRVJST1IoIkZhaWxlZCB0byBmaW5kIGNvbm5lY3RvciBmb3IgbGluayEiKTsK
Pj4gQEAgLTQzMCw4ICs0MzEsMjUgQEAgdm9pZCBkbV9oZWxwZXJzX2RwX21zdF9zdG9wX3RvcF9t
Z3IoCj4+IMKgwqDCoMKgwqAgRFJNX0lORk8oIkRNX01TVDogc3RvcHBpbmcgVE0gb24gYWNvbm5l
Y3RvcjogJXAgW2lkOiAlZF1cbiIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjb25u
ZWN0b3IsIGFjb25uZWN0b3ItPmJhc2UuYmFzZS5pZCk7Cj4+IMKgIC3CoMKgwqAgaWYgKGFjb25u
ZWN0b3ItPm1zdF9tZ3IubXN0X3N0YXRlID09IHRydWUpCj4+ICvCoMKgwqAgaWYgKGFjb25uZWN0
b3ItPm1zdF9tZ3IubXN0X3N0YXRlID09IHRydWUpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRy
bV9kcF9tc3RfdG9wb2xvZ3lfbWdyX3NldF9tc3QoJmFjb25uZWN0b3ItPm1zdF9tZ3IsIGZhbHNl
KTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IE1BWF9TSU5LU19QRVJf
TElOSzsgaSsrKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChsaW5rLT5yZW1vdGVf
c2lua3NbaV0gPT0gTlVMTCkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250
aW51ZTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobGluay0+cmVtb3RlX3Np
bmtzW2ldLT5zaW5rX3NpZ25hbCA9PQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFNJR05BTF9UWVBFX0RJU1BMQVlfUE9SVF9NU1QpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkY19saW5rX3JlbW92ZV9yZW1vdGVfc2luayhsaW5rLCBsaW5rLT5yZW1vdGVf
c2lua3NbaV0pOwo+IAo+IEluIGdlbmVyYWwgSSB0aGluayB0aGlzIHBhdGNoIGxvb2tzIGZpbmUs
IGFuZCB5b3UgY2FuIGhhdmUgdGhlOgo+IAo+IFJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVz
a2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+Cj4gCj4gQnV0IEkgdGhpbmsgdGhhdCB0
aGlzIGxvb3AgaXMgcmVkdW5kYW50IC0gZGNfbGlua19yZW1vdmVfcmVtb3RlX3NpbmsKPiBzaG91
bGQgYmUgcmVtb3ZpbmcgYWxsIHRoZSByZW1vdGUgc2lua3MuIE5vdCBzdXJlIGlmIHJlbW90ZV9z
aW5rcyBjYW4KPiBzdGFydCBhdCBhbiBpbmRleCBvdGhlciB0aGFuIDAgdGhvdWdoLgoKZGNfbGlu
a19yZW1vdmVfcmVtb3RlX3NpbmsoKSB3aWxsIG9ubHkgcmVtb3ZlIG9uZSBzaW5rLiBJdCByZXR1
cm5zIGFzCnNvb24gYXMgaXQgaXMgZG9uZSByZW1vdmluZyB0aGUgc2luayB3ZSBhc2tlZCBmb3Iu
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
