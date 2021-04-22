Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A40BC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 14:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D8060FDB
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 14:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D8060FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 078C76EAA3;
	Thu, 22 Apr 2021 14:17:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A516EAAA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 14:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5t0X8iqNeGBja1f8CORarmlcMDGwfELVg9ivQmr14nF/hKqcFPGTUBAv1GmG6l88rjIiV0mm9tiqFZAthmNcc60oR8F15+oJNRipjJEsGa2m9yu5yGHKhLK0Hji9feNN+5EZu8ZLo1c5vDByHSLoQ9bsC+S4S/YB+rXB+BU+ePGmbk/raTbxiCGd+rvHAOp9JZ5w3XEUX1Ss/m8EoLf2NNPxZ5RZ4Yjgca6SbsGCGotAjxN5/H/M9HnkBSLyyyNP4nBamSQDIZJ/CWUkn0CMglp41VjphXpUMJv9g/iuficnphOQt3aSvsUCL5zF6tRupz0PiDnd50Bful0OPT6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cShJoYcRuz7e5gnKMkztWdQblLRz154lPlpYOjFIq3Y=;
 b=kFK4CXFECAwFzURcOfWpKE0lkFE0tywmIQbgb4nb39Pu9Er8jIRPzRuL6ucQlanjUHWlqO6xhFnK5BQYGvLecUwSxOOvggganW1xJoHi/TETKEwdb/ePUAxEKGORjHUgWKkYO5WIkGlxUewVESvTbPo1moMKK9ueH5XH3ZjT/0IgsoTN8uFkOMUgL9skXN9FQvD0Lg/TzXej+Qd4Qv9m5tjSiOE8JHA42mYlDqKTju9pnC6YFltNsgJ83cOQjOBd7ZuhYmzgWv5ezTCuC5RsFqajqbSmFJkP8BPv4/vJwHEQpMQ/NM5Rn4PDdcP6Y6ocrOQ0Mk1estIStg/5CPqdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cShJoYcRuz7e5gnKMkztWdQblLRz154lPlpYOjFIq3Y=;
 b=rpzImUdxP8c2qecx7Ktr5yrp9ctz3BnG0kM2fCLlOvnTzwOvp9MdzJhe7Ix1PnZSdjZLjZzm6ZoBcK98ZxU8YH8kYSSca49rkCSrN4BbAov/rg/ZO4iH8V+asG5dKfBOxgdK+4wkaOfqHQLZGfTtt5o36IU1YFY9qKt5o0K9XKE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1590.namprd12.prod.outlook.com (2603:10b6:910:a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 14:17:11 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 14:17:11 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu: initialize vm->is_compute_context properly
To: Felix Kuehling <felix.kuehling@amd.com>, Nirmoy Das <nirmoy.das@amd.com>, 
 Christian.Koenig@amd.com
References: <20210422123545.2389-1-nirmoy.das@amd.com>
 <20210422123545.2389-2-nirmoy.das@amd.com>
 <cf1b7b58-d2f0-e7bb-ea59-ae0525b5653f@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <deea0dfd-3112-95bd-23f9-bbd0d11067f9@amd.com>
Date: Thu, 22 Apr 2021 16:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <cf1b7b58-d2f0-e7bb-ea59-ae0525b5653f@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.127.111) by
 FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.17 via Frontend Transport; Thu, 22 Apr 2021 14:17:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a447785-3eb3-4e69-0db6-08d90599517a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1590D3D79F57539A6744210C8B469@CY4PR12MB1590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5XkShA+5dC1YRbapr4BO5GPRwwqoBAKkuEYFkiBQWcp6RX8UWwaJq4q4X8801ejboQEJwaX78MIFX8n1VdY3ntFylIJOhDJE2r3H4vN89NA602SpDfxVW3uFvdB5vyywEIdXQlcn1a48fw4laxQKK36ZxSog/SZ0m+l7t3AZU+vWOy0cpKv7QghYMIN7+r0boNqpwwPx6Ikp87ENm+FhOvJKo2WtKZMZQ8dwVPp61DD/cl0J4aIP4BRgKyNnIMYiAjwDoMqFu+KEAQFCtvF+F4ZvCuimQTllpKL+hy64UmS4W9erRB83yHMlwMlhIX8xSOanOHEElWjj7XYDyDSrHBE1tR5RiU/Ac1+h/gx7TmNZK6qMpOAwPJSlb2fsNrIrALv6W0Ky54+xZFzrBtFDEvq8K6uuCzT7QxF2c6VTTzaiGls8D9qOjC0fCDGtHixPfJLlvEJLwZrhkpvP37GvYmLD7BAE2Gky7aB7FlpbiokSbJ52YeP/i3D75llx+UIn98OQh6iU+iWnPf5XvhI9HT7oGwvM2QMSEwNGjAPxq3M97izO4lcXRWaqzcGqF/qwbgDI7iN0fDiAyHW7TxQQxXzOHZ/40XtfGyDAhNUSvGOQZnTt5xnESvyzJ7U9EXQz7eh59aAMnkj0Z+r18WCtV1zllL7EmN6ovRNsI0WtcJUDI9kcPx8s6mOAkiSYSsVV5fxlC0lV2igPemSmEgWBuLWriwz+P+dY9exkKB1Eng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(396003)(346002)(376002)(366004)(26005)(6636002)(4326008)(52116002)(186003)(53546011)(16526019)(8676002)(6666004)(38350700002)(66556008)(110136005)(38100700002)(8936002)(31686004)(16576012)(2906002)(956004)(6486002)(31696002)(478600001)(36756003)(2616005)(316002)(66946007)(5660300002)(66476007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SUlFZTJrUURCVWJ3dFFnNkJac3RBdEpvdmN3WWU0aCt0NXpiZHNnTU8wcDlS?=
 =?utf-8?B?TkxLdEJLQUlIbzMvOUpwcVpWWG5OdFBCejdUd1c2RWhEYldoM1hGQ3VHLzJG?=
 =?utf-8?B?cUhjYkhidDFrSnZPVVpRRi9KaDk3RzVJWTBWOHJzY1R4aGFyTEFyeENzVUJZ?=
 =?utf-8?B?MWpVcVV1VFZjSEpOSEpWRHU2UUJTWXNDZ0lNU00rcnAwOTFuTndEUDNBMmRZ?=
 =?utf-8?B?Q292RWwyajJ5em9UMGhXM3lUSkhtQ2JhOVdobFFDYklaTnp1S0sxUGthWFZi?=
 =?utf-8?B?b2p0ekxkeEV1elc3LytrK2htK3JjVUdFRVA3MEZwdjZLcDFnTUtFb3FVc3R6?=
 =?utf-8?B?M1dsOFNiU2dTVDNHMko1cnpuZ1I5Zm1EblRoMlgvaGRZMHZKN2xVZVRpTGxk?=
 =?utf-8?B?QUthYlo4SE1rSEdzb3pTRnQyaUpVUjhHa1psSXlJYlBNN2J2akJDSUJIeWZl?=
 =?utf-8?B?aDBvOFhyN2UzSUQ2ODBEek5QWllUcDlWL1pXeVBrajFjVy85b2pMUmMyVlEz?=
 =?utf-8?B?YkxQWUpNMVVlUnlKcGJwd1FxVDVRL2YzbXQ5bXZWcnMxcElQSVhkVE4zN3Ex?=
 =?utf-8?B?NGJOSFdVckJsMjdYSUQ0MWRRMVVTazBwT2NkQnVQUUt2bXR0dmllTTVYOE5W?=
 =?utf-8?B?Yng2YVBCL3VQZDNvMkxkOE56ZEIyclczLzkzYkFGM1pIeHN3enE3R3h2Slox?=
 =?utf-8?B?aU9BTGFJWHpYNHJJWkFJUnNtbWVvbXZNWnk0V3RWTCtydXhsRjBLRmd1WnRX?=
 =?utf-8?B?N3ZzZmh2ZXZId3FiVDNsallWQXBwNUlkTlhBMkNGcWlDeW9GV0pxWm9CZGh2?=
 =?utf-8?B?TlZIM0VFVG1rRUJZNjNIVHZTcm5oR0dVZGZXWHJabnZiemhLNHBLV2w3TDZK?=
 =?utf-8?B?UXlQQmtYYzZTUHhIZmFlL29pcGh6b0NPdnpMeXlrZnlrd3BmWm9yN1Q1MzVx?=
 =?utf-8?B?eG9tdGpmeTVjSkt6ZzJ2VVV5UUZCcXEzdy9yamtscGRLbWQ4VHEwU3FicVlj?=
 =?utf-8?B?dndoa1ZxeVYreEF4MTZ0Z3l5RnZhTHAyVGhIMHZLU0w3ZnhyV3R2NjAvZllZ?=
 =?utf-8?B?Z2Y5Tkd1eWZmYUtIS2JnY0E2clpPQndUalhmMDMwK3l1YjA4blA0Rk9LNXhG?=
 =?utf-8?B?QmpaTmlNQWdtVllLY004bUtXakNxU3IvaU94MzRCSnp5ME9mTXBTdktCWlFL?=
 =?utf-8?B?a0ZUa1dybjN6Yk5SOTdpZGJESTVnTmwrQldNQ0I2bFZjeTIvSkpFNU90R2pv?=
 =?utf-8?B?a0I3WnZ0Nkg5VGRjMVFXUm9sN0ZMbDQ0M01NeERtOGNXdlRnK0hoQWo3NTZt?=
 =?utf-8?B?aTlQVjdUVllQbjdVZUhXTS9GalZHS3doY3lJWno5VHBOKzRXQk01ZmozR0tT?=
 =?utf-8?B?OWhxOWlFRXo2NmhGckJ3N2ZmTm1TdTVCWDR6QTE2ZjlmNVlMZjk2UkZGY1V2?=
 =?utf-8?B?blNOMDVidTRxV3gzaEVYSnFzQnFqYUJ5ZE1xL2pDZzZYRjZYNzRoYjNQdVMy?=
 =?utf-8?B?OGNnYXNVZ093dUlnRWZXUEMrQWhCVmY1WktGVkhBZDdPR3k2NEltdzdyeGg0?=
 =?utf-8?B?SjZJbktLVzJ4Tzh2a3grRmtlY2VEeWhSQ3pBdDk2SHRTTEkvWHRHeFdlYUFR?=
 =?utf-8?B?WCtKaFozSmxzWnNaVUpMM09jbVVwSm55ekRsdnVja3o1bEFleUwzZFNabUNU?=
 =?utf-8?B?SEUvR3Fld3ZXcGQzTWRHbHoxbnNFSWV2dmh0SEozZTVKTHB2S0hDTU5Hdko5?=
 =?utf-8?Q?Xn1bKKovAdLsX5RaC7n3lWxLGQlwbgJRjaQVfIA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a447785-3eb3-4e69-0db6-08d90599517a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 14:17:10.7923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DcEXfzHoyQjeP8MPV6Z3F7FIRlZfTJuxIUIXJfJRuovDsXquoTf09SWbSXUoKkV7ZZFpca2TkxGL8t37Hc7HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1590
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDQvMjIvMjEgMzo1NiBQTSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gQW0gMjAyMS0wNC0y
MiB1bSA4OjM1IGEubS4gc2NocmllYiBOaXJtb3kgRGFzOgo+PiBGaXggdm0tPmlzX2NvbXB1dGVf
Y29udGV4dCBpbml0aWFsaXphdGlvbiBpbiBhbWRncHVfdm1faW5pdCgpLgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNiArKystLS0KPj4gICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBpbmRleCBmOTViY2RhODQ2M2YuLjZmMGE2MDEx
Y2IzZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gQEAg
LTI4MTUsOSArMjgxNSw5IEBAIGludCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sCj4+ICAgCQlnb3RvIGVycm9yX2ZyZWVfaW1t
ZWRpYXRlOwo+PiAgIAo+PiAgIAl2bS0+cHRlX3N1cHBvcnRfYXRzID0gZmFsc2U7Cj4+IC0Jdm0t
PmlzX2NvbXB1dGVfY29udGV4dCA9IGZhbHNlOwo+PiArCXZtLT5pc19jb21wdXRlX2NvbnRleHQg
PSB2bV9jb250ZXh0ID09IEFNREdQVV9WTV9DT05URVhUX0NPTVBVVEU7Cj4+ICAgCj4+IC0JaWYg
KHZtX2NvbnRleHQgPT0gQU1ER1BVX1ZNX0NPTlRFWFRfQ09NUFVURSkgewo+PiArCWlmICh2bS0+
aXNfY29tcHV0ZV9jb250ZXh0KSB7Cj4gQSB3ZWFrIGFnbyBvciBzbywgSSBzdWJtaXR0ZWQgYSBw
YXRjaCB0aGF0IHJlbW92ZWQgdGhlIGxhc3QgY2FsbCB0bwo+IGFtZGdwdV92bV9pbml0IHdpdGgg
dm1fY29udGV4dCA9PSBBTURHUFVfVk1fQ09OVEVYVF9DT01QVVRFLiBXZSBjb3VsZAo+IHByb2Jh
Ymx5IGNsZWFuIHRoaXMgdXAgbm93IGFuZCByZW1vdmUgdGhlIHZtX2NvbnRleHQgcGFyYW1ldGVy
IGFuZCB0aGUKPiBBTURHUFVfVk1fQ09OVEVYVCogZGVmaW5pdGlvbnMuIFRoZSBvbmx5IHdheSB0
byBnZXQgYSBjb21wdXRlIFZNIG5vdyBpcwo+IHRocm91Z2ggYW1kZ3B1X3ZtX21ha2VfY29tcHV0
ZS4KCgpJIHdhcyB3b25kZXJpbmcgYWJvdXQgdGhhdC4gSSB3aWxsIHJlbW92ZSB2bV9jb250ZXh0
LgoKClRoYW5rcywKCk5pcm1veQoKCj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+Cj4+ICAgCQl2
bS0+dXNlX2NwdV9mb3JfdXBkYXRlID0gISEoYWRldi0+dm1fbWFuYWdlci52bV91cGRhdGVfbW9k
ZSAmCj4+ICAgCQkJCQkJQU1ER1BVX1ZNX1VTRV9DUFVfRk9SX0NPTVBVVEUpOwo+PiAgIAo+PiBA
QCAtMjg0NCw3ICsyODQ0LDcgQEAgaW50IGFtZGdwdV92bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPj4gICAJdm0tPmV2aWN0aW5nID0gZmFs
c2U7Cj4+ICAgCj4+ICAgCWFtZGdwdV92bV9ib19wYXJhbShhZGV2LCB2bSwgYWRldi0+dm1fbWFu
YWdlci5yb290X2xldmVsLCBmYWxzZSwgJmJwKTsKPj4gLQlpZiAodm1fY29udGV4dCA9PSBBTURH
UFVfVk1fQ09OVEVYVF9DT01QVVRFKQo+PiArCWlmICh2bS0+aXNfY29tcHV0ZV9jb250ZXh0KQo+
PiAgIAkJYnAuZmxhZ3MgJj0gfkFNREdQVV9HRU1fQ1JFQVRFX1NIQURPVzsKPj4gICAJciA9IGFt
ZGdwdV9ib19jcmVhdGUoYWRldiwgJmJwLCAmcm9vdCk7Cj4+ICAgCWlmIChyKQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
