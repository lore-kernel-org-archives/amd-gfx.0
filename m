Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A0C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013E864F74
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013E864F74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85EBE6E952;
	Tue,  2 Feb 2021 16:31:32 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7867E6E952
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM+wqgsNK4O5eMzEuwgZeAl+VRXw5UN1HDz90x2vdwS8DCRU0yaxnQTwjl6fGjhzhuusJfN1NHTLdEiUzSK/flvWyKgUyKg2AdeO5OAk6xFan66s2y8fTTLDdxvjbq4tdREPVjVi7CcV7TBkIKw1tTjMHxfbux4btHGZ7tXvVjnbe6PVW3ij4z0rEw29nzCjU2XWlQQKSbjqKizZ+OZryayp05X2wW21GK75j7YEoshKycgB9azPADoHOSjPPdhYpxzPeuSkuJTv0dObAW8zj8HyZcLscaYkM7MxZgShbzfWS8nfDqxMNzS59YT/SNw4jWIKGN6z3B4vkzwoIej8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbM0RAbiRvf18qPZz4fw4/3Gh6sYiXTfyvoKbnzJuYY=;
 b=ghMQDzxlQ9JvrGQQ+OPJ1K0gbGkvY+yS751TOByv9UHaz5ZatvVbpI5+YMUtAflRH3KrTsaHuUCTN7Yc10GOkXxeAAdjSWol7xR9jLl0WUHHhMci5VXYNwOUaX5JWEN3ivCjnv2kLAq1+yEqdEG+mmToUAg5eqRxkrAmXeymjboGiPmasRQSWk2g/skbGgIBresttOR8inbK8ve3gPLlYAKVeYGwpXk1Eq9nbfejYEzhdXhjIOfFfU1wbZM+5AptB35eSLAt44S4+CpI9H47Iz9SHGvSlKnFcgAm1oLKWXJgEggl2LXCrOvI0P8Y/vqO6pZPNTczIpQneXl6Y8GuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbM0RAbiRvf18qPZz4fw4/3Gh6sYiXTfyvoKbnzJuYY=;
 b=YJO7xgUQSfac0sej9KWtwaAwPK2+7/3T7OVIKe8jnUjo6Y+PWab9CeY8e9yORRmJgqRd8iZ57fxbBvdr+qYdDrfpsWdlbXH0q2yzBS2cxtBJvrPvfa+Qa/vH1pdTHoJz5bMhxd9BobotddLFwfFblZlrUnXhKP7M7NSKxSm/2cA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 16:31:30 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.022; Tue, 2 Feb 2021
 16:31:29 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix a false positive when pin non-VRAM memory
To: Alex Deucher <alexdeucher@gmail.com>, xinhui pan <xinhui.pan@amd.com>
References: <20210130010002.21222-1-xinhui.pan@amd.com>
 <CADnq5_MHPZvKrjYXr66VotD_RRi336PyOOaEHW2-U24SM63-fA@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3c999a54-1da4-f2d2-232b-2349c892e42b@amd.com>
Date: Tue, 2 Feb 2021 11:31:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_MHPZvKrjYXr66VotD_RRi336PyOOaEHW2-U24SM63-fA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTXPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::26) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTXPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 16:31:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 507c3a10-192c-43e5-c26b-08d8c797fe75
X-MS-TrafficTypeDiagnostic: BL0PR12MB4900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB490066B1ED3A4E4D75393E5E92B59@BL0PR12MB4900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rg5tzZnhRUU0EW9W7E2TxD2CC74Vc1RClX5PT2YLSXnE5Txzq0t8UXGSzrO9MCALGqCTSR6t5ZcFxEMLGJ8wNOmLPBayJCPJlRx6gHhcLg6C6LoQqdOo42IelL26OmubZFqkpZLISJyvpf7tXcIwET360JkepjaguEj+jALfldxbuqmIupczPhID9JLP/IEzOc/HtcnabdiEWQ2qt0s1uCt7FsjxkCTeizx8Hq0k3PHYb8uSCu9bmfUzBBlDv5qMyx3QabpmxyFyV07X5S84Kl8X8rTYDjNTkxP/A0R7v3WaTcYdfrnEYa35+qKpPKz/AGbDSEaAZ426TpcoKIwzLCivthCj4jgMCLSvci98NTO/BATkOw0U8JRpkRUZMpt0yHuFJtY5Tfjp9tN6eVAEi4bjZ9SFP7R790dorQqEwReeDjh7eanldlDh3eVEpfAQDY5ROODz17ZwboypybCkCzgV11NKd+e/6nyXq1578UAQPbMGT4qsIy2hQp6YKYpBDCEpaG5pn1o99C047Zz7AnjZipoXEnkx2aBb9dvLmZqIAKMLYWtxWECwOxZdVqwCO4UJo7H8UqPjtLJ/kDEOsv+ROchj+NWmHKxOwEX1fq2GG+mnVx0O/ubwFZIUdw+TSr5THWx0T05RYbFc9tByKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(478600001)(52116002)(966005)(31696002)(66476007)(66946007)(2906002)(316002)(54906003)(110136005)(16576012)(66556008)(6636002)(956004)(5660300002)(53546011)(36756003)(4326008)(8676002)(26005)(86362001)(186003)(8936002)(44832011)(83380400001)(6486002)(66574015)(16526019)(31686004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qkk5WEFIakhpalIvMjh3dkVwTjBPQm9JRDhWS0dpOEthQ2o3UzRmYkZHWkxC?=
 =?utf-8?B?U2lnWlNla3ptUXlsZnB1OFZPN3Q5aDArUWljSm9qeU1kYzFKOUxhMnY2NDJP?=
 =?utf-8?B?bC9OZFBSaUR1YW5mMlU4aWsrUzJEa1ZJYStYbVhENUxyWnlvRVhaZzBFMk9G?=
 =?utf-8?B?ZGhwek00MWdoZW5CZnFaMUhWNWtRVFg4YVN4d1BIY2VSc05ydldoMkdmNTZD?=
 =?utf-8?B?cklCUHc3dVJvemNRNTBwbytYM1R2TkJLbDkxUi9kNWFqYmZrc0Y4U0J4NVV0?=
 =?utf-8?B?N1hQK240eHl4RWxEbTNJNzRCc0hFUmlEOVlrQlAwY1FPZ2o4eWdkTlFINWlN?=
 =?utf-8?B?ajBIK2R1VHV1UE9VRDY1emlzZXBzWVBPY2QrY1oxS3ZTemtQQWhrdXpOV3FZ?=
 =?utf-8?B?L2FEamF3WGRnSUJwSGQ3dVFoV0V0Tmp6NXlWbjVPOS9kUDZNMVpaT1JNZlUx?=
 =?utf-8?B?VlFTRXRzTG4xbEF2aDdkWHRScnNHQzg3dTB1a1RPWjZFQ2xLeXNwdGREaDlM?=
 =?utf-8?B?UUdUV2gvbzdBNEFsdG9HNi8zVTJEdmRQU0J2bVcwVmtDeGJ1WmlaMDNmVXlF?=
 =?utf-8?B?R28vQTBDNkd1bE9Sc05DZE03N2hJTFhiS0RFdERSSFAyZitsQkZubWJSR2dH?=
 =?utf-8?B?TFF2UXNlNkV2WTBiVnpheUlDcDQzYkU3YkNuM0k5NFNZdW9RVG1MbWMrTXgw?=
 =?utf-8?B?KytCQkVvc0plUjJvS3ArcjFpQmEvSkk2LzRSSDdLMitDVFgvVlhVSjY3RTRM?=
 =?utf-8?B?Zk5IVmlVMXhhTjNiNnI5NFpFRmFtM3VaVWthTEhDYXJJVHVqc2tUbU9PNGZ1?=
 =?utf-8?B?WGdyN09iU2IyZktjcUR3VU9zeGd4UE5vNHFPbzM0RnNpcWhrUjlFZDNMY3Ba?=
 =?utf-8?B?dXAwQzZYSDI3VkdoNW5FUzNUOWRsbk5UQ1BQa2xGcUVsODNFZm1Ub1lGL3VQ?=
 =?utf-8?B?NDdUTjlvTlB0dW0veUxaUE1BQlpES1RzUmJVcENIMnR1Q3hMeUM5aklOQS93?=
 =?utf-8?B?dUxhT2R5QTNGajJYM3JXemR1SG5qTXRWbDB6aHRlcFgvd3AyUlRrbGxsN3p1?=
 =?utf-8?B?d3I0VEU0Z2hIOXBkdG96RVdZSnc4QmlJOFlwcE9XNm9XWlRCSlRZQmVKajk2?=
 =?utf-8?B?VFRUU2g4ZTRvZ3dObnVRSEJqWjVwWnJBckZIMTRLeng3WWxRMElwRG5Gam0y?=
 =?utf-8?B?eGVOc0lkTlBPV2QwbFFMSk0vWmtZQVFxQXpUT0t0Si9yMGhFUDEwclRQakpt?=
 =?utf-8?B?YzFMQ2doM1ROeEhUUDc2cWdja3ZmdEczYWRYYVlYU1N0OEJWK3M3WXRwaGI5?=
 =?utf-8?B?eHJKdlNvN1FLcFd0Zm56bk1GNFRkdWhZTmNkb3lqd3hESC9JZVF4bnhlZHFO?=
 =?utf-8?B?YWRRYWFNZlFkaGY3QjBiV0pXSkdnTFZUWWtkejk5ekhyU3hDQWFmWmh6TGZu?=
 =?utf-8?B?bTUxdi9JN3E1Q091VjRlby9YWHk4RlErZTM5RkRnPT0=?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507c3a10-192c-43e5-c26b-08d8c797fe75
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 16:31:29.8145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qV+F5vERQeMc8qIsIFdXIVKtQqnp3fPXk0mUEOVyA9KGy7GalAEDZS7wCBuuqZG/TOh+YLCR3UyQucU3Cg3ruA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wMi0wMiB1bSAxMToxNyBhLm0uIHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+IE9uIEZy
aSwgSmFuIDI5LCAyMDIxIGF0IDg6MDAgUE0geGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29t
PiB3cm90ZToKPj4gRmxhZyBUVE1fUExfRkxBR19DT05USUdVT1VTIGlzIG9ubHkgdmFsaWQgZm9y
IFZSQU0gZG9tYWluLiBTbyBmaXggdGhlCj4+IGZhbHNlIHBvc2l0aXZlIGJ5IGNoZWNraW5nIG1l
bW9yeSB0eXBlIHRvby4KPj4KPj4gU3VnZ2VzdGVkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT4KPj4gQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBh
bkBhbWQuY29tPgo+IEBLdWVobGluZywgRmVsaXggSSBwcmVzdW1lIHRoaXMgZml4ZXMgdGhlIHJl
Z3Jlc3Npb24geW91IG5vdGVkIGxhc3Qgd2Vlaz8KClllcy4gVGhpcyBpcyB0aGUgZml4IEkgbWVu
dGlvbmVkLgoKVGhhbmtzLArCoCBGZWxpeAoKCj4KPiBBbGV4Cj4KPgo+PiAtLS0KPj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDMgKystCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gaW5kZXggMTM3ZjI3NWY5MGVlLi41
Njg1NGEzZWUxOWMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9vYmplY3QuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMKPj4gQEAgLTkxOSw3ICs5MTksOCBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmlj
dGVkKHN0cnVjdCBhbWRncHVfYm8gKmJvLCB1MzIgZG9tYWluLAo+PiAgICAgICAgICAgICAgICAg
aWYgKCEoZG9tYWluICYgYW1kZ3B1X21lbV90eXBlX3RvX2RvbWFpbihtZW1fdHlwZSkpKQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4KPj4gLSAgICAgICAgICAg
ICAgIGlmICgoYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdVT1VTKSAm
Jgo+PiArICAgICAgICAgICAgICAgaWYgKChtZW1fdHlwZSA9PSBUVE1fUExfVlJBTSkgJiYKPj4g
KyAgICAgICAgICAgICAgICAgICAoYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9D
T05USUdVT1VTKSAmJgo+PiAgICAgICAgICAgICAgICAgICAgICEobWVtX2ZsYWdzICYgVFRNX1BM
X0ZMQUdfQ09OVElHVU9VUykpCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOwo+Pgo+PiAtLQo+PiAyLjI1LjEKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
