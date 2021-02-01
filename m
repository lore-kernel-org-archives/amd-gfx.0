Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CABC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2EA64DAD
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2EA64DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1906E5D2;
	Mon,  1 Feb 2021 15:10:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564046E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnA2ONKaogQHq+vANsTNTWWTWili5sVTd58q7bLRmlhvc2fAF3ehHMT+ZmRsKLkgA6PRhybBebsyAm+RjevYOAicH49kR+QCwtiA5VmtYWFrZGoP9j6rvcTIIj+J/7t5Jgn2soBkVnQy8J851e6Tac2gWH8MLFsw9hv7H+t4bTVT2g/2BF2tjYbiaIBQFkw4cZ7I0NClY14NxvUhee4d55BqI/pb9LMVcaOzaxRfDBi8txfiTNFlpgn6HzwdrZ2hCt5FZ6XdQq70tXdNDiu6UfIzdImYfqyTtncJ+K4TJaoR0YklL4S9lKcwZHZ/i0osZW1GLpzx1uEHdqp3qI8DMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOKq7cEGMM+fJQv8PU5FH4snRpbsMn9t2o+A0Hrq1R8=;
 b=YSANEpH5w005dL05jNv4ZlLsmOwLYD7PR1R0qcTd3PNwY/0zdMRGG+qxm02g5DOiGnMGGpl7AHNe7FUfcoiL85Q8xoMPdUG2I0sbI63Cf0eLOrvvp+9zWsfa2UM9E9EfgK0dC/k24t1bDskw3n39kg6VH25777QSOwLPXeVlUvdEmeqLiZaTFkhEg4CyME8xp9Dv6qaEZzUGn8ctgWw2SeRnzkBuQR/Q7vGf2sKR2YoKK+UJkBFx9RrMTwK0I/3l9KJ8ftyGGazLtqpAoiGLkiNO/wp0ERlgOUqwiJqYwkRztCpSfLYsNgnEUo8yhst4MWV1bex1wLwYjPF1S45UBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOKq7cEGMM+fJQv8PU5FH4snRpbsMn9t2o+A0Hrq1R8=;
 b=K07gjdFYCHIZzSCUOV/yD/8sXVqnqSNe8fA08BGHcYiDGmUASPF3Bp1dfHZvLKIrK4Is3qWl2VI8tJhJ7dQUUVE8Hxi2NkqjTOhRhgmsEzIyR2J93UKJnUkEpRWEPAht5LZ1MtSmBXUPQAAyJMRftwmPlDXISZeM/wQbdQpF/kU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1132.namprd12.prod.outlook.com (2603:10b6:3:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 15:09:58 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 15:09:58 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: fix ring priority assignment
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201143800.26908-1-nirmoy.das@amd.com>
 <46571899-9beb-0348-5711-6c146e316fb0@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <63c56e4f-2cda-fc93-d1e9-29b98e7cca44@amd.com>
Date: Mon, 1 Feb 2021 16:09:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <46571899-9beb-0348-5711-6c146e316fb0@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM3PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:207:5::33) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.32.223) by
 AM3PR03CA0075.eurprd03.prod.outlook.com (2603:10a6:207:5::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 15:09:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e382089-3a1d-42e7-02ce-08d8c6c37094
X-MS-TrafficTypeDiagnostic: DM5PR12MB1132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1132DC93E6B0846026F220FC8BB69@DM5PR12MB1132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9d5PO71xtBjNQgtfy9ZD+zLAv/dVyhzoFOzUvQdLtE5D6xIYA78/LmB7gbeFPxeXR52ST/nKHamPhmN4bE6gHJEq16yJa5vLHE4BKrqiDxlT8Z5+7M9AE3AfdaI2NNN6RhW5E7HdLfKGIwe1AO9XLxUi7Lr+Y903VREdZdSAwFDqR6pL9gI80xWPhLPSYPNgj8A+1V+Lze75ID5xxPqwPtkGC5I1FZLZ4Tc2X+Bz653TPrnxErHdV1Vxcd+/Hz+eBTi0HMwdq8AK25mQVj5r0P421TxBj4y6Z4JHyWgZuT1JyWNT0YofUMCp/5eTng9Ph8RN6un7Aoww8/zLMQ0gm3InCP7roSX1X1NCWW48qkWvJNIhYMJeKPLXsCl0YaO/f8ZXyB/PDulzIUR0BIkNOlOXaZImXTBGRkK+mJAOuBcXWiAypn6vjtgMCLdx8vIhEuoGveLMHhNvC7nMM5EgIW6dXwZA5yAil3vuL4TIGo1iGh7cZEsSLHHLdfrZxBNgGefvVTSRjlG3IW17QaMZekJ+kFQYYKJ2k7uuYDk11j7KiCy6NZck+9mQwGpgaH5ByQdE4JJ4vr9vDZ01XAQLAVDYdp7Vel6Limj8GjrWNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(5660300002)(316002)(478600001)(53546011)(6666004)(956004)(26005)(8936002)(2616005)(186003)(16526019)(8676002)(52116002)(2906002)(4326008)(110136005)(83380400001)(66556008)(66476007)(66946007)(16576012)(31696002)(31686004)(6486002)(66574015)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZnhVRy9Mb0Jpd29xbzF5cndSMk8xdDk4UVIxNnNJcFZqZFUrc2RsbHUwclAv?=
 =?utf-8?B?ZDVNOThHTjgxMElGOHo1WjlmT2w0TDRMeEdhRkNDaHhhWlJKK2srcHR4SkZG?=
 =?utf-8?B?RnBVTEdPMkF6R0htMTAxTHVXaGhNY01nMVVCb1pCRjl3WDFXNUNpM2wyUUtH?=
 =?utf-8?B?aGZRVHFiS1JCbitrWG1CRWdkNm9wK0ZzL0RELzRwR0VqUktidmtnYXZTU3Y0?=
 =?utf-8?B?b2pucGRPc0ltdTArRVBVZVdISCtpakJFamIwMnVhUEFnbWpIVWw5R3A2VTdm?=
 =?utf-8?B?NHFHaEQwSGp1amFJem8yd1VxUDE0akVUVXFERW5tTHF6UDNsS1FYWmhzWFhB?=
 =?utf-8?B?OWhIYUxDSm5yMGtEczdNTWZyYmpyOVRUQ3JQenIwZUpxdWxBVzM0RkRxZzh0?=
 =?utf-8?B?Z2dtUmo4amJPdmp1NzlpMWJlTE1OelM2V0hTdEw2YTZHOVRNU0k0WHQ0c1RE?=
 =?utf-8?B?WXR4SHp1T3dTWWFPTTNlZENlRENLczI0Q0I1bHUxNVJNRWRQK3U1OEs0Z0dv?=
 =?utf-8?B?Uk1MSHp6cndtYzViUktpclhhcnFILzE0cjdvOWlCTnpVT3BJZERZNVBXMTNY?=
 =?utf-8?B?Ym1DdDdvVjliZTNSRnpnR0cvaW9MQUMyQ2FKM1BObGFuWTNRdEg4SkdGYkJ2?=
 =?utf-8?B?WTZLbmxvMFFjbGE0QXZ1d1FxMjNoeUdoLyt6bzFtRXJOcm10RkVXSlRNN3By?=
 =?utf-8?B?elM5RW9jRytPT1owVjdBRWRYeEdvYjQ0VkNiWUF3RTFka2MyTVNqaVA3NUJa?=
 =?utf-8?B?S1NkbkdvM3UrNmNtODBSSEsyejRNUGxNZW5mWEE4RExJSXNHWDhUQW44VzUw?=
 =?utf-8?B?bm1SLzQ4MGp6eU9VbUNpTGNrSzBwQkpLRHBwNmZ3TWtZWU1aMllqQXk2OEdN?=
 =?utf-8?B?YnE5KzV5SDdXQ05yQ1AzRU1OY2poeVNUMGdHSllaL0pqcE9yMWdDb0tvRnZR?=
 =?utf-8?B?WURtUitHaGFxS2QyYVZuWWFxTkpKNVNrT3pNaEoyazd4QVJ4cDdidU54YkdI?=
 =?utf-8?B?SitiUFlPUVNENXVPVnBpRkQ5MGZGL2tXcFRmd1p2cWN1eWlZRUhCRFNDUUpo?=
 =?utf-8?B?WnpDV3VOSDRXa0dZbGJpSjNKYXhBS1FUTkdTZjVOU0d5K0dOQmtHSVFPNWlo?=
 =?utf-8?B?dDhsazlJcFFHQjAzOXBVb2ppZ1k5V0N5UFp4cG5MaVNqRDhMODlEcUhPZlFN?=
 =?utf-8?B?c0dMNENlWTJmZE9Zb2hFRlFUOGZKdVhhMGZMNzQ4TUFkbnNwb3l4ZG1HN2gy?=
 =?utf-8?B?aklIa1BPbWd3YjhISk1KNVo0T2VGT00rMVBkSm0zRGpmQVhsN0szTkNFWWpq?=
 =?utf-8?B?NE5sVXJHVTJCSTFWaUdwbGpFNG1MQlkwamk1eS9lVGlFS2lYcjRNMkVDVkZa?=
 =?utf-8?B?NHdPT1pEOFRLblRORGUrMENOWXpuSU9GV3pkTW42cEpSNmdBZHBPODFIdkJJ?=
 =?utf-8?Q?xTH7IYKG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e382089-3a1d-42e7-02ce-08d8c6c37094
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:09:58.5883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTGa85cGm7AIZ3dt130xyCrYispK/DXlFDyPzPqQEqImJMusMWNxzHFFHsJd2FkqEH0lEq9/aagzfWPpZQrDDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1132
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
Cc: Alexander.Deucher@amd.com, Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIvMS8yMSA0OjAwIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAxLjAyLjIx
IHVtIDE1OjM3IHNjaHJpZWIgTmlybW95IERhczoKPj4gQXNzaWduIGNvcnJlY3QgcmluZyBwcmlv
cml0eS4KPj4KPj4gRml4ZXM6IDMzYWJjYjFmNWExNyAoImRybS9hbWRncHU6IHNldCBjb21wdXRl
IHF1ZXVlIHByaW9yaXR5IGF0IAo+PiBtcWRfaW5pdCIpCj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1v
eSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMgfCAzICsrLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmMKPj4gaW5kZXggMWE2MTJmNTFlY2Q5Li5iM2QwNjQzODM4MDcg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+PiBAQCAt
MjU4LDcgKzI1OCw4IEBAIGludCBhbWRncHVfcmluZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCAKPj4gc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+PiDCoMKgwqDCoMKgIH0KPj4g
wqAgwqDCoMKgwqDCoCByaW5nLT5tYXhfZHcgPSBtYXhfZHc7Cj4+IC3CoMKgwqAgcmluZy0+cHJp
b3JpdHkgPSBEUk1fU0NIRURfUFJJT1JJVFlfTk9STUFMOwo+PiArwqDCoMKgIHJpbmctPnByaW9y
aXR5ID0gKGh3X3ByaW8gPT0gQU1ER1BVX0dGWF9QSVBFX1BSSU9fSElHSCkgPwo+PiArwqDCoMKg
wqDCoMKgwqAgRFJNX1NDSEVEX1BSSU9SSVRZX0hJR0ggOiBEUk1fU0NIRURfUFJJT1JJVFlfTk9S
TUFMOwo+PiDCoMKgwqDCoMKgIG11dGV4X2luaXQoJnJpbmctPnByaW9yaXR5X211dGV4KTsKPgo+
IEkgdGhpbmsgd2Ugc2hvdWxkIHJhdGhlciBudWtlIHRoZSByaW5nLT5wcmlvcml0eSBhbmQgcHJp
b3JpdHlfbXV0ZXggCj4gZmllbGRzIGhlcmUsIGNhdXNlIHRoYXQgaXMgY29tcGxldGVseSB1bnVz
ZWQgcmlnaHQgbm93Lgo+Cj4gKFdlIGNhbiBvZiBjb3Vyc2Uga2VlcCB0aGUgcHJpb3JpdHkgZmll
bGQgYXJvdW5kLCBidXQgSSBzdWdnZXN0IHRvIHVzZSAKPiB0aGUgaHcgcHJpb3JpdHkgZGlyZWN0
bHkpLgoKClRoYW5rcywgSSB3aWxsIHJlc2VuZC4KCgpOaXJtb3kKCgo+Cj4gQ2hyaXN0aWFuLgo+
Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKCFyaW5nLT5ub19zY2hlZHVsZXIpIHsKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
