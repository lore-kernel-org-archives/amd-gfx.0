Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9E3C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 12:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90ACC61090
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 12:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ACC61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E290A6E834;
	Mon, 26 Apr 2021 12:14:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023A66E84B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 12:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1Y+We99+v9wY+3gLnUv/s28NVB6W8hym+Tzv1Mdbr36LOVDJnDHsLvI6o20D7JB28aHZZoo5n+bH7r0mCC7M6IrIz9KO4reyUH4ROuO6EDZgMoD4gIByvdWFpZh5cbaM4+0L4eEZz49ez+7lKmMjyz/Y/htx08khtVQd4Kuo6bpjQf0ukE6YXkkvuBFgioikjgSRNqw+vhTw2hsjj8Ce41tohUr1IzamXlyKq8uExNFdQpi/gXTjvS1adjpQWf/6bn79IqfNar13A9CTyaWDi0J1rtZ9RVlv2IzjEKh45KvUdUAEXcVXUjJFMNzogE4EcYuK/jsfemm8ZDmrJVHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs83DgoOx0PmZLHj6Sc5TUBuX83KAtQNVovc3pPbK4Y=;
 b=WglGcJGzqHCTkPzcbhtQWYYFkI4Jua/tC7QcOzzSkaD7z3k6nkpynmSNvknYnBpA+CZvwo3FNYACRavPbTplj8lYIXEmCS3WPvTlFnUiQ5hLB/0IuNXDGdm1Axr+q+08fH5SvvstmU4lcMHvC4oRIedC9QIrEvLqIlY2HvTBzLeMf2bVv7hb4xrm7sAFcwkP3QAbM3wbs0fLvYzoKQU5HhalvU5DXVd53um5jHSCGOTH2CIHm1Jkgbd7jTMTmUckvYXB4k5r4E468+3vtbg8mJWCvFo2791OMz7uPhMDOXPjt6Ehe8iih1O9wLxuJ0gYkv9Cti1TMoPxbU+0PbhvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs83DgoOx0PmZLHj6Sc5TUBuX83KAtQNVovc3pPbK4Y=;
 b=A53XfMQQ+X8fcAEBeTXNM/qrAnsCpSYNVT9OJMeE1oybpjk2Z58PNwDA+DRLB8VO0CGLvos7rlG1kYJY/7pqDVyLDiFdh6lUZg6F/0Maoazun1zx8KNt89Xe8H2ETO2Mw+RZHPtBaiRMhzlk4oKukyrnlMyj3QaXJ9rjA83uwig=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1175.namprd12.prod.outlook.com (2603:10b6:903:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 12:13:55 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 12:13:55 +0000
Subject: Re: [PATCH] drm/amdgpu: restructure amdgpu_vram_mgr_new
To: amd-gfx@lists.freedesktop.org
References: <20210426085434.2974-1-christian.koenig@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <7283bf5a-a1ce-fe18-0369-a7895c533f9e@amd.com>
Date: Mon, 26 Apr 2021 14:13:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210426085434.2974-1-christian.koenig@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.97.47]
X-ClientProxiedBy: PR0P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.97.47) by
 PR0P264CA0145.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Mon, 26 Apr 2021 12:13:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e24ff43e-fe28-4390-6438-08d908acc308
X-MS-TrafficTypeDiagnostic: CY4PR12MB1175:
X-Microsoft-Antispam-PRVS: <CY4PR12MB11756722BD591F5B83D0430F8B429@CY4PR12MB1175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjND/RVDtDUMlCUaI3KJ82SAdANnowmCUuLH9qGaMOwarwmbzM497q1sacRIrxMnncuBhyDHvQYTvLNxhPv5uuw+oC6p5o95mcyN/mAfVwwKsD8++lmuc/tyTDyHx8TwBzzVBcjzFHI/beALwwu4HQr8T9+ddteTqXXE5zgeFd+Cw5VNn6J6b+M+gcsgF3YQg6bbz9tKfbZDeekKNg9jUxiHgNZ0nmvendW49SORCHWqeQd99ZC3YjjjK3mwUzIgkgEjDb8DxZsww1CEATrrfGk1Egx5OEje2BqlwHQf1BrJ4sKOx9iUcTweHfXBshIpbE+hCfA07A1D+QbW60bLQxE22k1RqniTM6wb08vz8d7zQmUI4F1mdII1X5GY8PMkGHIMtQZ6YYyhsBvtfaH92cncNdoUhd4BzdMBAK/RnudbkU9xRi+uPwxDtgvrShgnvFVlb4xCFilqU7R9ZlpxrjABKOtO0X89V22dh9zHwZnUwVeA/PxJJkrGcraunFflS+ySty1zRTmyEOQ+RnIgKYv+NrlCy1j3EI2oIB7dHSJoPRxpEsEHZsYZNkHz7r4dFiybNOetKIkU9EqIbXplV3BjxopL4d+pffg5WHmCIXO/npwecJ7F0MBiLuMZTDB6jKE18xJuDkwzOwQWJf3R1lda6lx6gqJHqDBHf9XcjHSuBSHBixuH+Y/KzLCV1xPa1fSJWc86rsKQ1mBnTJKk+0oRhrO/42iiBsQZ0+yOxJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(6916009)(31686004)(83380400001)(478600001)(316002)(8676002)(66574015)(16576012)(8936002)(53546011)(52116002)(6486002)(186003)(16526019)(956004)(2616005)(26005)(5660300002)(31696002)(2906002)(6666004)(36756003)(38350700002)(38100700002)(66476007)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ekFldGd6UEtHUFNkQVJaYStzWHgrZS8zVlpiaVJJY0ptTXdYazNRamhhOWZo?=
 =?utf-8?B?OTgyRGpvMzIyOHlFd1pvUWV6WDBkUWFoMzFBVllUUDU0cTNOai9UV1FXZU9V?=
 =?utf-8?B?SzNwS2VaVnBTQ0Y4SG9FUzdwdStGUEhLTitNaG1qdU1meHdPenNyVDdzNnFQ?=
 =?utf-8?B?RkpWUmcyQXQzQ2UveGtqQ245aFIzOE90TGpDcFFabUg0bE5kTzJzaWI4MmVV?=
 =?utf-8?B?amt0NnNoTW8wZEllSjVXOEFvNi9JNzVDMWx6elVjYnhaaWdySHNpWkh0UGtY?=
 =?utf-8?B?eUFVN0gzMW5RWEd1SWRBemU5TER1SUU0dUhvWWloWUllNFllblRrU0JPc2hO?=
 =?utf-8?B?RjFxRThGMDVIanlHTTRKYVN3V0EwYm9ZclFueS9NQVdiN2kwaWNBZGZCLzhQ?=
 =?utf-8?B?cmR4YXlOL3UwUWZJVEpmMUlacTN2eDF3Y25UbW8zZnc0dFBmK1RiUFFFY01l?=
 =?utf-8?B?eVBlejRrY2xycGRvVnpNbUNOY2xmVGpVVzZFVG5ncHRya2lUWUwrb2JhOXp4?=
 =?utf-8?B?blVpNSsyUXZkL2R3NGZ4WGdTWWFTcmRCYXFwZ1VURnJTOGJiRlNtMWVXZkpw?=
 =?utf-8?B?NTFGeFZNc3FjbkhaS1VJYnIrR3RwOWxyOXVjUnBIWVlreC8va01OOVNuL3N3?=
 =?utf-8?B?Z3o3ODNLRTV6eE9hU1RyOVoxamFTUE9YZHZmMjU2WEhUVjVUM3Q5SHFpWGc3?=
 =?utf-8?B?Tkh6ZDFZSTMrdUpXRmNvRCtoTkdUYmRWUUdIUGhvb1pQLzA4Ulh2UmdrQ0p3?=
 =?utf-8?B?dUZDWHhteWJGUC9RdVgrbmhVeUZwS21XQlZCejhtSWxIcDJUUk1kMll5THgr?=
 =?utf-8?B?YVhIcVBmQzJHejVKNWt1UG5iZ0VobmU4L0FWdENnZ0xJcEtpUG91Qk92QVJR?=
 =?utf-8?B?a1d3UldCSTFvazZIdUF6TDJBYUR0RmFJdkR2SUFHODdBVEgxKzhNV1FNSVcr?=
 =?utf-8?B?bE50bDZLL0FiRWNIa09UR0hwb3NOOTM4aVU1RHRpanNieFhoNVA3QXBKTkkz?=
 =?utf-8?B?MDZjQlVWZ051Tk9zTFNJWDBJS0lWU2Zrc2txc1Z4YVphTEpFOFdkd3pZVVNI?=
 =?utf-8?B?OUhrVUJMR2hRdVpGT1ZselhTcUxnbW5EMFhab1NoMEMwNGRYY2FMNUltT05n?=
 =?utf-8?B?aTkzUWo3aVR4Sm1CZUpvcFdmQjdmTFh2Z25iQ1lrS3NhYStUSkRwcmZWb2kx?=
 =?utf-8?B?NTJGZGRWemp0dGVwdTZZelhJZFpydzVCWjRtNlQwYmRDSkZHczN1MzI2TzVL?=
 =?utf-8?B?L0pGWmlTNXBKVDlXZDd4aDkyWGVoZGpzUHczL2xXSEgrUy9hdmhOeWVzYitK?=
 =?utf-8?B?Yk0rYzlEeTNITkhrbzFNb2l5cFVHeGJlVGlFanJJc3IrUUZNUHBmSjRrekdN?=
 =?utf-8?B?SjZBa3NVdFluQjd3UUE5WEwvTFBtcnZFaWg2YlpyYkYyTlVqUWM2NjRDTlZy?=
 =?utf-8?B?YnlLSDc1OGdBa21DYmJEa0szUDRpQ1NqTitkbjdGcmYxWUdNZis3Wi94YUVa?=
 =?utf-8?B?ZGdFamRiSm1aRkVrYkltWVN6R25uSW13aUhLb1FtN1VWck51UWJUMndmb29s?=
 =?utf-8?B?SGVVRWR3L2FDcWdPNTNNeEoyNXcwNG9uVzhDcTJNejZNRTcrK3FUVU9YVHBE?=
 =?utf-8?B?bXZxaEVQTnRsQXJHa0xoODJhUHlKaEdlMGtjaGNleFhsdU82WkpTSmlST0pK?=
 =?utf-8?B?bVdjK2tJWjJncG42RHFuN01TQzR3bUpZMUp4MGtaYVpSaDNLM1ZqOEFmdGts?=
 =?utf-8?Q?oH8gn6Mr3VRFyJD9h+8GY0f/u1ZOX2ju/pFrOab?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24ff43e-fe28-4390-6438-08d908acc308
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 12:13:55.4297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSZFmrt9NW/E1p9TjdqDUx5QNzMu9TCb6aE7uULasT7NjqLxFmRWKmEad+LSi5wyfP+zSiwAWSnVKLZEYNr0Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1175
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

QWNrZWQtYW5kLVRlc3RlZC1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKT24g
NC8yNi8yMSAxMDo1NCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBNZXJnZSB0aGUgdHdv
IGxvb3BzLCBsb29zZW4gdGhlIHJlc3RyaWN0aW9uIGZvciBiaWcgYWxsb2NhdGlvbnMuCj4gVGhp
cyByZWR1Y2VzIHRoZSBDUFUgb3ZlcmhlYWQgaW4gdGhlIGdvb2QgY2FzZSwgYnV0IGluY3JlYXNl
cwo+IGl0IGEgYml0IHVuZGVyIG1lbW9yeSBwcmVzc3VyZS4KPgo+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIHwgNTggKysrKysrKysrLS0t
LS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dnJhbV9tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5j
Cj4gaW5kZXggNTI5YzVjMzJhMjA1Li5lMmNiZTE5NDA0YzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+IEBAIC0zNTgsMTMgKzM1OCwxMyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5h
Z2VyICptYW4sCj4gICAJCQkgICAgICAgY29uc3Qgc3RydWN0IHR0bV9wbGFjZSAqcGxhY2UsCj4g
ICAJCQkgICAgICAgc3RydWN0IHR0bV9yZXNvdXJjZSAqbWVtKQo+ICAgewo+ICsJdW5zaWduZWQg
bG9uZyBscGZuLCBudW1fbm9kZXMsIHBhZ2VzX3Blcl9ub2RlLCBwYWdlc19sZWZ0LCBwYWdlczsK
PiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZyYW1fbWdyICptZ3IgPSB0b192cmFtX21ncihtYW4pOwo+ICAg
CXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gdG9fYW1kZ3B1X2RldmljZShtZ3IpOwo+ICsJ
dWludDY0X3QgdmlzX3VzYWdlID0gMCwgbWVtX2J5dGVzLCBtYXhfYnl0ZXM7Cj4gICAJc3RydWN0
IGRybV9tbSAqbW0gPSAmbWdyLT5tbTsKPiAtCXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9kZXM7Cj4g
ICAJZW51bSBkcm1fbW1faW5zZXJ0X21vZGUgbW9kZTsKPiAtCXVuc2lnbmVkIGxvbmcgbHBmbiwg
bnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZSwgcGFnZXNfbGVmdDsKPiAtCXVpbnQ2NF90IHZpc191
c2FnZSA9IDAsIG1lbV9ieXRlcywgbWF4X2J5dGVzOwo+ICsJc3RydWN0IGRybV9tbV9ub2RlICpu
b2RlczsKPiAgIAl1bnNpZ25lZCBpOwo+ICAgCWludCByOwo+ICAgCj4gQEAgLTM5MSw5ICszOTEs
MTAgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVzb3VyY2Vf
bWFuYWdlciAqbWFuLAo+ICAgCQlwYWdlc19wZXJfbm9kZSA9IEhQQUdFX1BNRF9OUjsKPiAgICNl
bHNlCj4gICAJCS8qIGRlZmF1bHQgdG8gMk1CICovCj4gLQkJcGFnZXNfcGVyX25vZGUgPSAoMlVM
IDw8ICgyMFVMIC0gUEFHRV9TSElGVCkpOwo+ICsJCXBhZ2VzX3Blcl9ub2RlID0gMlVMIDw8ICgy
MFVMIC0gUEFHRV9TSElGVCk7Cj4gICAjZW5kaWYKPiAtCQlwYWdlc19wZXJfbm9kZSA9IG1heCgo
dWludDMyX3QpcGFnZXNfcGVyX25vZGUsIG1lbS0+cGFnZV9hbGlnbm1lbnQpOwo+ICsJCXBhZ2Vz
X3Blcl9ub2RlID0gbWF4X3QodWludDMyX3QsIHBhZ2VzX3Blcl9ub2RlLAo+ICsJCQkJICAgICAg
IG1lbS0+cGFnZV9hbGlnbm1lbnQpOwo+ICAgCQludW1fbm9kZXMgPSBESVZfUk9VTkRfVVAobWVt
LT5udW1fcGFnZXMsIHBhZ2VzX3Blcl9ub2RlKTsKPiAgIAl9Cj4gICAKPiBAQCAtNDExLDQyICs0
MTIsMzcgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVzb3Vy
Y2VfbWFuYWdlciAqbWFuLAo+ICAgCW1lbS0+c3RhcnQgPSAwOwo+ICAgCXBhZ2VzX2xlZnQgPSBt
ZW0tPm51bV9wYWdlczsKPiAgIAo+IC0Jc3Bpbl9sb2NrKCZtZ3ItPmxvY2spOwo+IC0JZm9yIChp
ID0gMDsgcGFnZXNfbGVmdCA+PSBwYWdlc19wZXJfbm9kZTsgKytpKSB7Cj4gLQkJdW5zaWduZWQg
bG9uZyBwYWdlcyA9IHJvdW5kZG93bl9wb3dfb2ZfdHdvKHBhZ2VzX2xlZnQpOwo+IC0KPiAtCQkv
KiBMaW1pdCBtYXhpbXVtIHNpemUgdG8gMkdCIGR1ZSB0byBTRyB0YWJsZSBsaW1pdGF0aW9ucyAq
Lwo+IC0JCXBhZ2VzID0gbWluKHBhZ2VzLCAoMlVMIDw8ICgzMCAtIFBBR0VfU0hJRlQpKSk7Cj4g
KwkvKiBMaW1pdCBtYXhpbXVtIHNpemUgdG8gMkdCIGR1ZSB0byBTRyB0YWJsZSBsaW1pdGF0aW9u
cyAqLwo+ICsJcGFnZXMgPSBtaW4ocGFnZXNfbGVmdCwgMlVMIDw8ICgzMCAtIFBBR0VfU0hJRlQp
KTsKPiAgIAo+IC0JCXIgPSBkcm1fbW1faW5zZXJ0X25vZGVfaW5fcmFuZ2UobW0sICZub2Rlc1tp
XSwgcGFnZXMsCj4gLQkJCQkJCXBhZ2VzX3Blcl9ub2RlLCAwLAo+IC0JCQkJCQlwbGFjZS0+ZnBm
biwgbHBmbiwKPiAtCQkJCQkJbW9kZSk7Cj4gLQkJaWYgKHVubGlrZWx5KHIpKQo+IC0JCQlicmVh
azsKPiAtCj4gLQkJdmlzX3VzYWdlICs9IGFtZGdwdV92cmFtX21ncl92aXNfc2l6ZShhZGV2LCAm
bm9kZXNbaV0pOwo+IC0JCWFtZGdwdV92cmFtX21ncl92aXJ0X3N0YXJ0KG1lbSwgJm5vZGVzW2ld
KTsKPiAtCQlwYWdlc19sZWZ0IC09IHBhZ2VzOwo+IC0JfQo+IC0KPiAtCWZvciAoOyBwYWdlc19s
ZWZ0OyArK2kpIHsKPiAtCQl1bnNpZ25lZCBsb25nIHBhZ2VzID0gbWluKHBhZ2VzX2xlZnQsIHBh
Z2VzX3Blcl9ub2RlKTsKPiArCWkgPSAwOwo+ICsJc3Bpbl9sb2NrKCZtZ3ItPmxvY2spOwo+ICsJ
d2hpbGUgKHBhZ2VzX2xlZnQpIHsKPiAgIAkJdWludDMyX3QgYWxpZ25tZW50ID0gbWVtLT5wYWdl
X2FsaWdubWVudDsKPiAgIAo+IC0JCWlmIChwYWdlcyA9PSBwYWdlc19wZXJfbm9kZSkKPiArCQlp
ZiAocGFnZXMgPj0gcGFnZXNfcGVyX25vZGUpCj4gICAJCQlhbGlnbm1lbnQgPSBwYWdlc19wZXJf
bm9kZTsKPiAgIAo+IC0JCXIgPSBkcm1fbW1faW5zZXJ0X25vZGVfaW5fcmFuZ2UobW0sICZub2Rl
c1tpXSwKPiAtCQkJCQkJcGFnZXMsIGFsaWdubWVudCwgMCwKPiAtCQkJCQkJcGxhY2UtPmZwZm4s
IGxwZm4sCj4gLQkJCQkJCW1vZGUpOwo+IC0JCWlmICh1bmxpa2VseShyKSkKPiArCQlyID0gZHJt
X21tX2luc2VydF9ub2RlX2luX3JhbmdlKG1tLCAmbm9kZXNbaV0sIHBhZ2VzLCBhbGlnbm1lbnQs
Cj4gKwkJCQkJCTAsIHBsYWNlLT5mcGZuLCBscGZuLCBtb2RlKTsKPiArCQlpZiAodW5saWtlbHko
cikpIHsKPiArCQkJaWYgKHBhZ2VzID4gcGFnZXNfcGVyX25vZGUpIHsKPiArCQkJCWlmIChpc19w
b3dlcl9vZl8yKHBhZ2VzKSkKPiArCQkJCQlwYWdlcyA9IHBhZ2VzIC8gMjsKPiArCQkJCWVsc2UK
PiArCQkJCQlwYWdlcyA9IHJvdW5kZG93bl9wb3dfb2ZfdHdvKHBhZ2VzKTsKPiArCQkJCWNvbnRp
bnVlOwo+ICsJCQl9Cj4gICAJCQlnb3RvIGVycm9yOwo+ICsJCX0KPiAgIAo+ICAgCQl2aXNfdXNh
Z2UgKz0gYW1kZ3B1X3ZyYW1fbWdyX3Zpc19zaXplKGFkZXYsICZub2Rlc1tpXSk7Cj4gICAJCWFt
ZGdwdV92cmFtX21ncl92aXJ0X3N0YXJ0KG1lbSwgJm5vZGVzW2ldKTsKPiAgIAkJcGFnZXNfbGVm
dCAtPSBwYWdlczsKPiArCQkrK2k7Cj4gKwo+ICsJCWlmIChwYWdlcyA+IHBhZ2VzX2xlZnQpCj4g
KwkJCXBhZ2VzID0gcGFnZXNfbGVmdDsKPiAgIAl9Cj4gICAJc3Bpbl91bmxvY2soJm1nci0+bG9j
ayk7Cj4gICAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
