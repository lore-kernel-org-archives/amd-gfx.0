Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB9C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 12:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF45C6523F
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 12:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF45C6523F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 980D16E8CF;
	Tue,  9 Mar 2021 12:40:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DE76E5A4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 12:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixN3Hv69uqvqlLKO8wg+nyU8TB9qYYmJjvM8gUkoyzPhAPsPcZtpAuOwMQxtVgWqdYfQ8pvykLiB3M4DHUH4aBDqSJX0ZHe4yugfSEO471HsfXXjTTtAhqCtqap8zBKzdcj4wII18V0GXncD5DpCMEU9giVqTUatJoJe/rGJJdgfCwHUS3a3L5opo9V8WC4v8NvwIOwmYdYZI/xS2x7UPWUVeIUd7UwO1DrmOOapBdCEJAKCBsyM4eczYLLlr4xit6PxwOTn0+0ybNRXzV6mFjVbPXtnHMJiMkaixF1glg0EQTyVXqInghAlD1cB93X8bi6FiJXdshDaeJNX0CpqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTgyc14PWwmUnGl+DkdCzwiElBmcdIadKcmsFvPPjcc=;
 b=REuZ1F3WhbybmNSz+eFtcFnHp80lYlhD55sBfFPxxGggaetn/2lYmft69POuSH7tdKqZ78KiijEzhyCR8LEBvjqf7QLj1QXCLAz5UyBmAGn9XUyJwiI2ZPdAqZyYc6pshe0uBnlNOPdXHJHDgULc8rE8fxRCfd2Pbj0lREc+iG1ABEYCZd05pMMrSw713OPKcF5xSzRcz1W2QLV8Ks3/jSVcT0TI8GebYOCyOAfh7DiwH+GcO+rFb+drg7MPR46HF10TawkgRkOTXU+o/UsXW7A3Hx3eTCJv0jlgupJJvCzoPBm6YU4t7Y1GzjmgN4Y3ZEiAB122kh/HYLHO+Abekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTgyc14PWwmUnGl+DkdCzwiElBmcdIadKcmsFvPPjcc=;
 b=asekrsu1U4GQcAF6g6ZVWMuppXDASuzEfTb9172Y8ze9x9VXlSm8UbUlP7CX19agWAbxUZRnQHmA7tVIORvKSh/B3XfSvP9UNHClAb/y+CrDUwCC3ZQTK12ld6iX6hIgSCMwOiZRovlFoaqiVnw6J4sSF5CkckpPp1Y74WGw9V4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Tue, 9 Mar
 2021 12:40:34 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 12:40:34 +0000
Subject: Re: [PATCH 4/5] drm/amdgpu: use amdgpu_bo_create_user() for when
 possible
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210309084659.37649-1-nirmoy.das@amd.com>
 <20210309084659.37649-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <245801df-ce15-8898-0ffb-cc57d97a72ca@amd.com>
Date: Tue, 9 Mar 2021 13:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210309084659.37649-4-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe]
X-ClientProxiedBy: AM3PR07CA0138.eurprd07.prod.outlook.com
 (2603:10a6:207:8::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe]
 (2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe) by
 AM3PR07CA0138.eurprd07.prod.outlook.com (2603:10a6:207:8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.14 via Frontend Transport; Tue, 9 Mar 2021 12:40:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca0bd152-3828-435d-2dbb-08d8e2f8889d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4867F220FAE1E53BFD6A0BEB83929@BL0PR12MB4867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUZ6UfiKZKPc5AINHGD5LgXgHSLS1FS/bXlrLQkH9qBIZxRvPqNQZiZtsZ1mKGvw1MbMitJrdPqPDdFSTnQ1HlvhX/ZhhmXbNIq5KTluM8bec6EqxLDawIqmHgOVTxGYkwotu9MMHV08RJc7Ssk/o/It2tQA+Loy+if6/kFe63wQ6Fe8gwmknAL5fb7p+xDiroz/dhgOvc/rW29OkCR+7WVIeTU0vE506mu6walGy3C5MAgLIETN1J2kKBaAUOtgas/GOa+3hNoDavqCVoToYCB2/TaJd69Yxe0iGGGYjH5ilCKhfyRxJN4VCQbA7+ix2W+6i7Np4yqwIDWqxBmzLxs3dSAPubLa0Ef6tKczdmuHMbOkIsXzWo7IDci0sjgDsCtZQyLUVxjdvFhz2BpziXBhlsecnVxLGciKB00IzyUEhF5pZwCMXQLE2J673DDSYQ2pyVp8NxIwLepQxlH4hUU9EVHjNuQyhKhk3t76Ws3cbCynujRqX8oM8mI2T8viQZda+46ULftOVOBXFwsKHCYa1QYfNyewn/TLqk8La/SG/qEpnBQCzThfyfcBZKeVWa8TIDJtsJ0X103+hjCDKd2Qnc72MBroqIlbxvWxWug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(36756003)(186003)(2616005)(83380400001)(16526019)(316002)(52116002)(8936002)(6666004)(31686004)(86362001)(31696002)(8676002)(6636002)(478600001)(6486002)(66556008)(66476007)(4326008)(66946007)(6862004)(2906002)(5660300002)(37006003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R3FtNnZVK20rNGhaanpqbG1QNVFiU1RzQWlFSGc5OUhabEVuRGNMQXNvbEpu?=
 =?utf-8?B?Q3prcHpDaU9DeldTSm5SWVhoYk5tby9qbmpZQW1ncG9vdHVEWEJjeS8zQkg2?=
 =?utf-8?B?V2ZuL0dEZkRGMTNmNVdZYlZlaklCallLVlltNW1ySVNRUy8wODduZWgyR0hr?=
 =?utf-8?B?czRBajRsSEJBUUZBUEpuQ0pEWE96dW5jZE9DN0lTSWJDQnNPdDkvVTZxaHQ0?=
 =?utf-8?B?aWpLWExSS2VjSE01MTNEVjBxdXhaMkJFSnY3V3BKMGV2SHo2OGNwM3U1T3Zi?=
 =?utf-8?B?ODdreGhpK1JmbEdQVXR0MnN5ejRIZnkxNWh1YklmRnBvTXFVVXJnN2N4MVdV?=
 =?utf-8?B?QVJoM2poVjRiR2tMVkNNNk5NTlRlRjNTZnloZkJ3RElaMWsxck12Smd1MGMx?=
 =?utf-8?B?M0lPTk1oWnc0c3UzTEZxVGUxOXJmcGVrSDZjanFyUG9JNHJ2R2p1OGFmQXBk?=
 =?utf-8?B?VVl0eVovSm8wNUZ3WEVRT0lBMTQxc2IrZnF3Y1lIcHNhdXpKeXpIbStleFUr?=
 =?utf-8?B?OGVRaTFoS01WR1MyY00vb3Bab3cyVFpwUExqNUFJWEI1ZGoyZlY2cjZKT2FV?=
 =?utf-8?B?bzhLM3A3bzU0MndsakRPUFUrRDN0NzdrOXZMMFMyNXJheG9nQXZpdThIaDdx?=
 =?utf-8?B?aFlkMmorTklKaDN0aTA2SGp3SU5PVm5ybExtTzNjSTBsSUNaT01tWmptNWp5?=
 =?utf-8?B?STBpQ3NVdEhBVllzZXVzL2p2VGhWSE8yTkJCbGNKZWQ4QXNxc0NQbmRyN1Az?=
 =?utf-8?B?VjVVdy8zTlNuNkVHaDNqQ2Mxeks3OEM4VHFWbEFXUFF3YUlycVV5QjB4VlR4?=
 =?utf-8?B?cFJvemZ5TEtDeDhFamxXNnIvRE5JVWhrUzRnSXkvQU9rK20xTTBJWm41NDlv?=
 =?utf-8?B?MGl1Wkh3eWxEV3dtNDAyRHVzSU5HZmhSVnQxZGxBcjNkTXMzbXc1WUp2ajhk?=
 =?utf-8?B?Y1VacHVicXBSVlRzS3p2MzRocWVFMzV4UUxOQ1VQWjUxVkdlUlpRUUlYMnBo?=
 =?utf-8?B?U0JVRHc5NDY5Rmc2QnNuTkp2WEt1TVBnZHE5bGY5TlJoUUFUOWdaYkltOU1P?=
 =?utf-8?B?UW9IS0tJS3h6WU91UWI4cThPdk1Qd0NFN0VBZ3Jxb3FaQ2NTYkZLYTNlc0RL?=
 =?utf-8?B?V0dEQkUwd29rUXUvRmRHVGxmeTBhek5kQ21aT2cxbmtJL25wWkV1Z0NTZ2JX?=
 =?utf-8?B?TGdrNHEvMlUxZi9ZRVhsKzRodEtGN1pVMjZuTEIxL0E1c1RoNEdsSTJmdG5h?=
 =?utf-8?B?QW5IUFVJWG02UEowRnVtSStDTTFnbUVBcmpYOWEwSWxpTDAxbm9sY0htVUhL?=
 =?utf-8?B?T3pmZEdrMFFZeGxNbFNYcXUzaFFOV1VyeUtUVFhDR2V4bU5MWnF3eE9KR2hG?=
 =?utf-8?B?MHN5STFqVmdrTTd4V1J6Tm00dEUzemlycGxWR2ZwWTc4anFyQ29kM3ZlT3oz?=
 =?utf-8?B?b21xdkZ4bzhsa1BaT2w5MEhFQlc1QnVrSTdvdXZuSklHd1BqK1RZSjBUQS9i?=
 =?utf-8?B?ajZySXg4NXZOa21STWxGdG91TFdkallDNDVNMDVwMXlTdzdqMXExanU5dDQr?=
 =?utf-8?B?RjNUNjV3WXhLNktIS0crcEhJMG1WSUc2WmlZbEZIcXV1bE5RR3BuamEzd1lZ?=
 =?utf-8?B?cituR1l3SytqWUxNLysyT3Y0U2JJQjAzYmR2OG9qbzI3ZGl5eXpXbVJhT0VO?=
 =?utf-8?B?NDhJRFRUcS93TEVHT2dSUU1xREFiQkJkZ1p3dHZ6Q21iVGZpK3pWOFdaWVE4?=
 =?utf-8?B?M3dCRHVLaXBCaGZUWU16eXY1cHE3TVFtcHk3M0pzSllnQ3JDbDk4SHQwUHlO?=
 =?utf-8?B?UFI2OUZ3K2NOcmpHeWRzSFFtTFJFZW53YVloNTVzWGtKa001UTNPQjdDRm5l?=
 =?utf-8?Q?RDeo44JnifKNM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0bd152-3828-435d-2dbb-08d8e2f8889d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 12:40:34.6303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2JbVtFgGMjOpLMkcLYYBM741xHv9Nn0Km4cMIZblIXjCRIaHN25BJYgWgvovKyo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDMuMjEgdW0gMDk6NDYgc2NocmllYiBOaXJtb3kgRGFzOgo+IFVzZSBhbWRncHVfYm9f
Y3JlYXRlX3VzZXIoKSBmb3IgYWxsIHRoZSBCTyBhbGxvY2F0aW9ucyBmb3IKPiB0dG1fYm9fdHlw
ZV9kZXZpY2UgdHlwZS4KPgo+IHYyOiBpbmNsdWRlIGFtZGdwdV9hbWRrZmRfYWxsb2NfZ3dzKCkg
YXMgd2VsbCBpdCBjYWxscyBhbWRncHVfYm9fY3JlYXRlKCkKPiAgICAgIGZvciAgdHRtX2JvX3R5
cGVfZGV2aWNlCj4KPiBDQzogZmVsaXgua3VlaGxpbmdAYW1kLmNvbQo+IFNpZ25lZC1vZmYtYnk6
IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIHwgNCArKystCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgICAgfCA0ICsrKy0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+IGluZGV4IDIxNTFmY2IxZTE5ZC4uZGU2YjNjYTY0
YjQ1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+
IEBAIC0zMTcsNiArMzE3LDcgQEAgaW50IGFtZGdwdV9hbWRrZmRfYWxsb2NfZ3dzKHN0cnVjdCBr
Z2RfZGV2ICprZ2QsIHNpemVfdCBzaXplLAo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+ICAgCXN0cnVjdCBhbWRncHVf
Ym8gKmJvID0gTlVMTDsKPiArCXN0cnVjdCBhbWRncHVfYm9fdXNlciAqdWJvOwo+ICAgCXN0cnVj
dCBhbWRncHVfYm9fcGFyYW0gYnA7Cj4gICAJaW50IHI7Cj4KPiBAQCAtMzI5LDEzICszMzAsMTQg
QEAgaW50IGFtZGdwdV9hbWRrZmRfYWxsb2NfZ3dzKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHNpemVf
dCBzaXplLAo+ICAgCWJwLnJlc3YgPSBOVUxMOwo+ICAgCWJwLmJvX3B0cl9zaXplID0gc2l6ZW9m
KHN0cnVjdCBhbWRncHVfYm8pOwo+Cj4gLQlyID0gYW1kZ3B1X2JvX2NyZWF0ZShhZGV2LCAmYnAs
ICZibyk7Cj4gKwlyID0gYW1kZ3B1X2JvX2NyZWF0ZV91c2VyKGFkZXYsICZicCwgJnVibyk7Cj4g
ICAJaWYgKHIpIHsKPiAgIAkJZGV2X2VycihhZGV2LT5kZXYsCj4gICAJCQkiZmFpbGVkIHRvIGFs
bG9jYXRlIGd3cyBCTyBmb3IgYW1ka2ZkICglZClcbiIsIHIpOwo+ICAgCQlyZXR1cm4gcjsKPiAg
IAl9Cj4KPiArCWJvID0gJnViby0+Ym87Cj4gICAJKm1lbV9vYmogPSBibzsKPiAgIAlyZXR1cm4g
MDsKPiAgIH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gaW5kZXgg
YmNhMjYwZDU2Zjc2Li4zMTFiY2RjNTllZGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jCj4gQEAgLTU4LDYgKzU4LDcgQEAgaW50IGFtZGdwdV9nZW1fb2JqZWN0
X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbG9uZyBzaXplLAo+
ICAgCQkJICAgICBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKipvYmopCj4gICB7Cj4gICAJc3RydWN0
IGFtZGdwdV9ibyAqYm87Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgKnVibzsKPiAgIAlzdHJ1
Y3QgYW1kZ3B1X2JvX3BhcmFtIGJwOwo+ICAgCWludCByOwo+Cj4gQEAgLTczLDEwICs3NCwxMSBA
QCBpbnQgYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1bnNpZ25lZCBsb25nIHNpemUsCj4gICAJYnAuZG9tYWluID0gaW5pdGlhbF9kb21haW47Cj4g
ICAJYnAuYm9fcHRyX3NpemUgPSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ibyk7Cj4KPiAtCXIgPSBh
bWRncHVfYm9fY3JlYXRlKGFkZXYsICZicCwgJmJvKTsKPiArCXIgPSBhbWRncHVfYm9fY3JlYXRl
X3VzZXIoYWRldiwgJmJwLCAmdWJvKTsKPiAgIAlpZiAocikKPiAgIAkJcmV0dXJuIHI7Cj4KPiAr
CWJvID0gJnViby0+Ym87Cj4gICAJKm9iaiA9ICZiby0+dGJvLmJhc2U7Cj4gICAJKCpvYmopLT5m
dW5jcyA9ICZhbWRncHVfZ2VtX29iamVjdF9mdW5jczsKPgo+IC0tCj4gMi4zMC4xCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
