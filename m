Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3269C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B9861077
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B9861077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC666F5D7;
	Fri, 28 May 2021 14:51:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76986F5D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 14:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgOT35NRL6Bj8gDbRUarakUT6/Vg/464NoNaMVe8vy1nf8BzhzAzwJkjrodUboAkWUbO1ijOk/WuFb+tnYQHEM9yndCfNWMuGnYAXFIDGvYOR5GV/JCZniSykKfvGfh+u5iP+Q3Gzs+qipAFS/Z3o0tvrJAwKpTEUD7aOpGUX475W14hmB3ss+6SRNdkYLkUOriKmKlhFaL8uo9JIGBau4fXSKzpYRxB5Yh3o+48Plsd1fRiE6WJTUCoZyoH/Dl0ZMqdzirvWeFwe8OYoIckLbtJV/4gWg+Xrr4lNA5XF9JYxL16s8cwedAhhB45BFxp7KjWzbhegLDjUtrAHQ2J6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXLUNXdEQiJ2JDGd8+4E1BeTv3srCgaej3EZr7ZHmpU=;
 b=aJsLbQEu5ZKNfCLfSeRated4Gt2JUmaNQaK5FNYcblcJLCDx8bZ1ot1xjU/ogJgI1ZzO++EnLoXU5e2ccfX23OZKQ3Nf4grrKvhQKrv/jLiic4AJ+RwjQ0bPVvftrHWSrqJinUh2+J1Zg5b3Np2RH4RnR2qb2UkJe4QMKQ4am4ne9MUdySxjHIspjqJJr7h9FIbRLrQsxgj8vHRKPjakoWpyDOPqahlC1w9JSGQTCe3sbFdI98wPQz8vyF1orFcyvqwTIrl+RNCt+zF9HkVPQYR/D5Qk+PVCN4f/NaXPX1clQyo9uJnT4Hl1Rmm0O6B6nR+DmmsrKEFv5IlVSQJRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXLUNXdEQiJ2JDGd8+4E1BeTv3srCgaej3EZr7ZHmpU=;
 b=mEFPX9yLmM0LGqvM2PMVbMzBzUPW8PHq97Qjr6SKhY793cDncSak8Ro/9WRI3XlkInUO2kGGCl/m9xx6YQ5JwXFHnG37NT3Y+rc14qLrC8JQHGiWhG6o3lOKle3OVs7tuecT7YPqIsuCVivWtEbWCxaIV4ePoZ8+502yCcXnP90=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 14:51:45 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 14:51:45 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: cleanup gart tlb flush logic
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210528144401.14046-1-nirmoy.das@amd.com>
 <aa586b3d-b192-23e4-7cfb-bfadf65a2b53@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <d7498b36-4fc5-2ab8-28cd-c6c69c17ad9d@amd.com>
Date: Fri, 28 May 2021 16:51:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <aa586b3d-b192-23e4-7cfb-bfadf65a2b53@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f21:6900:10f4:3065:5814:d1ee]
X-ClientProxiedBy: PR3P189CA0072.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::17) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f21:6900:10f4:3065:5814:d1ee]
 (2003:c5:8f21:6900:10f4:3065:5814:d1ee) by
 PR3P189CA0072.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 14:51:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01be79c6-a96e-44a5-b661-08d921e81d07
X-MS-TrafficTypeDiagnostic: DM4PR12MB5359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53595E23D02CBFA1E9BF087B8B229@DM4PR12MB5359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTOKhTgSoojriqUb8Lt09eVePMFQQ6cs4r94jifbcFc6OenzC5KSUp2EnZhWKYPlsj9pauwkVmgSAHKqAJRAgOpRDUWd7CXWeKUSKzi/lFoagiGjJBqEFaM5rUy6VKjBGa1IUgqGNQ6TQrAotXyww7Q9YiPRnFNoKVonjJmeO4yHy/rYE4u6FeMR4TQU4UI34+1TbdpVDsvaM5Ck8emt2nLswpuXSq62EpzAzVNNQmQF7SuzvQlu+FxWRdBmWucllaE+E85ZPxUQaNX4cmRVqL7y53JYoNoCUvFklsC1ggmnH8GThPG0Hs8+h/B1L8VY0wVxgXRlfuR44KsaAJvmkoVKHz4EbWvoooJBgz1TqT6wpxE3ECT4HOVRGcHMBRqO5xQ0qDoB8xY7O3kLuYKEm9nByYWkvB1zH+MXFj/fpN6L40XMAWS7kh00IdqNVNzEKsM84yO7RI4EVmsGdlRuGyORIhz0bhbtl00EkFo8FNIuF74VQ+A+Uw38/zTYGjttDb2Z5NcevlFpf79yxdjv7Gm3H3Fs/Uwf5lmQGNFmS44cGZj7Z+m5V2ZdRSERMAhLur4B50180ro06bD0bV5fURUi4dlfIdgL3KAVZj1OJ1rRxAQqWb1mDcZLMTK+RC4gEFQO438qe6V4klVi0BpEF9tLPrhKG3kgvqS1jXrTbMF4iNRxK+KRsRhlkSw2uEz+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(366004)(8936002)(38100700002)(8676002)(83380400001)(6666004)(86362001)(186003)(16526019)(6486002)(36756003)(2616005)(66946007)(31696002)(66556008)(66476007)(66574015)(478600001)(52116002)(53546011)(31686004)(316002)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZmZiQ29XdEppWEhWa3pTcTl5YTdTRGdqOFUrRmpHUkU4TmVqUFVaSWw2V044?=
 =?utf-8?B?dmxXd3NqMnBXY0h6bVhrYzZDbHN5RUM3c004YStacytEQXVlZXYrdzcveHBM?=
 =?utf-8?B?T21maWF1eGVoSml1UTNQQ3l2b1AzRlN1ZXpYTXdVU3BCcXgvYlZ1TS8zOUFw?=
 =?utf-8?B?WkptQUxaOHlZNEM2ZlhwOGJJeGFGM0lsSjJHcU1WMEZaeDBodEgyanVKZUt5?=
 =?utf-8?B?SGdxWTVYTS9SNmpsNE1HNXFyMTJ6OUtnNzRzLzFxcTZpTUw5TEM3OHBKOWhv?=
 =?utf-8?B?TG9Fclo5WDRQSW4rQVdSOTJzZkxTRmVxSWJaMzZ6NGNpYnkySnE3NFNPeXlQ?=
 =?utf-8?B?d1MzeXpQYW9mK0NFc1JaYVdMb2tEWXNuVEVYRDZVSFlsUmM0WmJDVWZjMTc0?=
 =?utf-8?B?UW9NSVlGN204RzdKSDlnYVpiQlZ5M0xtaW9rTG9NaTdRbWlZbzdMZ0ZVR3kx?=
 =?utf-8?B?dXhDenVKbE9WTVl0OVpWU0FrOEM2ZHJvU2U3cldPaXJPa1hXQmViSzhEbFc5?=
 =?utf-8?B?aUtXMTFvQ3BtVVZtYkZyQVladmEvaXFWci9QeXRuc2FVb01qMkhlNnZsQ3A4?=
 =?utf-8?B?WXV4V3NNakdtWWpzWDQ1c3RYUEh4Y3VzT0NuQm1mcDNqdHlXaWIrc25vcFho?=
 =?utf-8?B?SnZBdmx6TUJtWU9JekhSbEpQUHB3cUlLQmdvL3VaMDdCaFV1dExhOW9KNEM0?=
 =?utf-8?B?WU5Vd3FSenFpUG90N3Z6ZXBlQVlQWHBjTzlZcldxaVQwYXJ3Y2diNWl6cWE4?=
 =?utf-8?B?K3BXVnR3aGU3ZlFLNXRWQVJHMmljaDNOaVlGdkpZOXUxWVlPWGcwNWZnUnpL?=
 =?utf-8?B?anlKVWtDa1NVQXllaHpBUy9LclJ6OHcrL2daWlVHeXl6ZnNFZS9sbFpFSUNm?=
 =?utf-8?B?V3BFTFhvWGhJb0tFWVlWclhxVS9NQnovem5GNG5mVHZlR3JFQTVJTHlFSTZ6?=
 =?utf-8?B?QlNyYWNURE9MTi9YMnFEeFVQaVZyM3lIVHhiWVI2QlZGUW9yUzc0UWp5aEhY?=
 =?utf-8?B?QVhFWGlrQ3g4d25BV1dHU29XL3l4MUFQa25KVksxRmwxSzU3N1lZS3RZV2Z3?=
 =?utf-8?B?aHYybkl1bkUzYU4rREtSOVYzeENHWWVscFRtekwyN3FSZFdoU2xpcWJRVFls?=
 =?utf-8?B?R2cyNEJFbFpUWEF5MzAvakFBeUFEYTNKVTZsSU50dnNJL1dBTTZSZ3lRa1pO?=
 =?utf-8?B?MVltSmhNcDVrUW5nY1ZFZURPRU53YW5vcmZkQWhmWlRWVTlQQmVwQys5VC9o?=
 =?utf-8?B?bTJhVS9qTGlBVGQrSE9RRGZiSk9WQnRub1Npc2d4WGxUTGhiQ1E1eDBCT1lB?=
 =?utf-8?B?VFFVNFQ2bXFuUnVoZzBKemxWRlM1NU1UaThZQlhDamZMY2Q2aTZ0ajBUOUE1?=
 =?utf-8?B?NXV5eG9IR0xzRWlMZTlMUFY3NFBjU2Z0ZTlhMEluYzd3ZzZuZVJndlk4bU5k?=
 =?utf-8?B?QVZ4WlRrL0o3NGdFZ0JFOER4aEIyZnFHVVFXVDVoMWNMUGtTcWhQQ1N3enhz?=
 =?utf-8?B?aXZkTTFFdzcwbXV4eUViWEhGUW4vUnRneXpNTk1zREpzRXpUSkk5eFZHcWhW?=
 =?utf-8?B?RXd5Z055a1VlbmtWRWZhbFU1WURtaTF5RERlODVYc2Y5M2ZXdWxOcWxlY3FB?=
 =?utf-8?B?VFppeGZOVUNHUHUza0twZVRYUUZyVTI5YmJpSUg0UThsenNTN3MrSHNuY01j?=
 =?utf-8?B?elRzQkY5ZVRPM2NPYWtOUlhuMEc4enE3Z0F6Z2VxalRxN3VRV0J2Wm01eG93?=
 =?utf-8?B?K1NnRVVYRVBzbDVHVElHRGhBZUpDYnZiYzJFdi9OQ2ZZTkpPNWxETXJ2RjFs?=
 =?utf-8?B?SzFxTWNES0w4WnRLZmlOaVJvb2FBNTFnM0tOOXdJWnlrWFRZeHkwQzJuVTFY?=
 =?utf-8?Q?/d9XLe2lBDB76?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01be79c6-a96e-44a5-b661-08d921e81d07
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 14:51:45.3715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KMAUmjZqCN1cEYuVvp6NP6HCMuNiox0W+omH7ytdyjbrLf9rwaIUEYdpkz6Graq5HX5ngC6umx2ina4NVrTTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
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

Ck9uIDUvMjgvMjAyMSA0OjQ4IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDI4LjA1
LjIxIHVtIDE2OjQ0IHNjaHJpZWIgTmlybW95IERhczoKPj4gRG9uJ3QgZmx1c2ggZ3B1IHRsYiBh
ZnRlciByZWNvdmVyaW5nIGVhY2ggQk8gaW5zdGVhZAo+PiBkbyBpdCBhZnRlciByZWNlb3Zlcmlu
ZyBhbGwgdGhlIEJPcy4KPj4KPj4gdjI6IGFic3RyYWN0IG91dCBnYXJ0IHRsYiBmbHVzaGluZyBs
b2dpYyB0byBhbWRncHVfZ2FydC5jCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5p
cm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IElzIHRoZXJlIGEgYmV0dGVyIHdheSB0byBnZXQg
YWRldiBpbiBhbWRncHVfZ3R0X21ncl9yZWNvdmVyKCk/Cj4+Cj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmPCoMKgwqAgfCAyMCArKysrKysrKysrKysrKystLS0t
LQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5owqDCoMKgIHzC
oCAyICstCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMg
fMKgIDYgKysrKysrCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
Y8KgwqDCoMKgIHzCoCAxICsKPj4gwqAgNCBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dhcnQuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2FydC5jCj4+IGluZGV4IDU1NjJiNWM5MGMwMy4uZTIwNTlmN2VkNjM5IDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMKPj4gQEAgLTMyMiwxNiArMzIy
LDI2IEBAIGludCBhbWRncHVfZ2FydF9iaW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRl
diwgdWludDY0X3Qgb2Zmc2V0LAo+PiDCoMKgwqDCoMKgIGlmICghYWRldi0+Z2FydC5wdHIpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4KPj4gLcKgwqDCoCByID0gYW1kZ3B1X2dh
cnRfbWFwKGFkZXYsIG9mZnNldCwgcGFnZXMsIGRtYV9hZGRyLCBmbGFncywKPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYWRldi0+Z2FydC5wdHIpOwo+PiAtwqDCoMKgIGlmIChyKQo+PiAtwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+ICvCoMKgwqAgcmV0dXJuIGFtZGdwdV9nYXJ0X21hcChh
ZGV2LCBvZmZzZXQsIHBhZ2VzLCBkbWFfYWRkciwgZmxhZ3MsCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+Z2FydC5wdHIpOwo+PiArfQo+PiArCj4+ICsvKioK
Pj4gKyAqIGFtZGdwdV9nYXJ0X3RsYl9mbHVzaCAtIGZsdXNoIGdhcnQgVExCCj4KPiBFaXRoZXIg
Y2hhbmdlIHRoZSBkZXNjcmlwdGlvbiBsaWtlICJmbHVzaCBHQVJUIGNoYW5nZXMiIGFuZCBkcm9w
IHRoZSAKPiBfdGxiXyBwYXJ0IG9mIHRoZSBuYW1lIG9yciByZW5hbWUgdGhlIGZ1bmN0aW9uIHRv
IAo+IGFtZGdwdV9nYXJ0X2ludmFsaWRhdGVfdGxiLgo+Cj4gU2luY2Ugd2UgZmx1c2ggZ2FydCBj
aGFuZ2VzIGJ5IGludmFsaWRhdGluZyB0aGUgVExCLiBPdGhlcndpc2Ugd2UgaGF2ZSAKPiBhIG1p
eHVwIGluIHRoZSBuYW1lLgoKClRoYW5rcyHCoCBhbWRncHVfZ2FydF9pbnZhbGlkYXRlX3RsYigp
IHNvdW5kcyBiZXR0ZXIgdG8gbWUsIEkgd2lsbCByZXNlbmQuCgoKTmlybW95CgoKPgo+IFNvcnJ5
IGRpZG4ndCB0aG91Z2ggYWJvdXQgdGhhdCBiZWZvcmUsIGFwYXJ0IGZyb20gdGhhdCB0aGUgcGF0
Y2ggbG9va3MgCj4gZ29vZCB0byBtZS4KPgo+IENocmlzdGlhbi4KPgo+Cj4+ICsgKgo+PiArICog
QGFkZXY6IGFtZGdwdSBkZXZpY2UgZHJpdmVyIHBvaW50ZXIKPj4gKyAqCj4+ICsgKiBGbHVzaCBU
TEIgb2YgZ2FydCBwYWdlIHRhYmxlLgo+PiArICoKPj4gKyAqLwo+PiArdm9pZCBhbWRncHVfZ2Fy
dF90bGJfZmx1c2goc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICt7Cj4+ICvCoMKgwqAg
aW50IGk7Cj4+Cj4+IMKgwqDCoMKgwqAgbWIoKTsKPj4gwqDCoMKgwqDCoCBhbWRncHVfYXNpY19m
bHVzaF9oZHAoYWRldiwgTlVMTCk7Cj4+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFkZXYt
Pm51bV92bWh1YnM7IGkrKykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9nbWNfZmx1c2hf
Z3B1X3RsYihhZGV2LCAwLCBpLCAwKTsKPj4gLcKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+Pgo+
PiDCoCAvKioKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nYXJ0LmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuaAo+
PiBpbmRleCBhMjVmZTk3YjAxOTYuLmM4NTNiNzBhMjRjZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5oCj4+IEBAIC02Niw1ICs2Niw1IEBAIGludCBhbWRn
cHVfZ2FydF9tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIAo+PiB1aW50NjRfdCBvZmZz
ZXQsCj4+IMKgIGludCBhbWRncHVfZ2FydF9iaW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1aW50NjRfdCBvZmZzZXQsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IHBh
Z2VzLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VsaXN0LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRtYV9hZGRyX3QgKmRtYV9hZGRyLCB1aW50NjRfdCBmbGFncyk7Cj4+IC0KPj4gK3ZvaWQg
YW1kZ3B1X2dhcnRfdGxiX2ZsdXNoKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPj4gwqAg
I2VuZGlmCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z3R0X21nci5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdy
LmMKPj4gaW5kZXggODg2MDU0NTM0NGM3Li5iNjFhNTRmNmQ5NWQgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMKPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYwo+PiBAQCAtMjA1LDYgKzIwNSw3
IEBAIHVpbnQ2NF90IGFtZGdwdV9ndHRfbWdyX3VzYWdlKHN0cnVjdCAKPj4gdHRtX3Jlc291cmNl
X21hbmFnZXIgKm1hbikKPj4gwqDCoCAqLwo+PiDCoCBpbnQgYW1kZ3B1X2d0dF9tZ3JfcmVjb3Zl
cihzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbikKPj4gwqAgewo+PiArwqDCoMKgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gTlVMTDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1k
Z3B1X2d0dF9tZ3IgKm1nciA9IHRvX2d0dF9tZ3IobWFuKTsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
YW1kZ3B1X2d0dF9ub2RlICpub2RlOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fbW1fbm9kZSAq
bW1fbm9kZTsKPj4gQEAgLTIxNiw5ICsyMTcsMTQgQEAgaW50IGFtZGdwdV9ndHRfbWdyX3JlY292
ZXIoc3RydWN0IAo+PiB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgciA9IGFtZGdwdV90dG1fcmVjb3Zlcl9nYXJ0KG5vZGUtPnRibyk7Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAocikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWFkZXYpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFk
ZXYgPSBhbWRncHVfdHRtX2FkZXYobm9kZS0+dGJvLT5iZGV2KTsKPj4gwqDCoMKgwqDCoCB9Cj4+
IMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJm1nci0+bG9jayk7Cj4+Cj4+ICvCoMKgwqAgaWYgKGFk
ZXYpCj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfZ2FydF90bGJfZmx1c2goYWRldik7Cj4+ICsK
Pj4gwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4gwqAgfQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiBpbmRleCBjMGFlZjMyNzI5MmEuLjVlNTE0NzU5ZDMx
OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiBAQCAt
MTAxNCw2ICsxMDE0LDcgQEAgaW50IGFtZGdwdV90dG1fYWxsb2NfZ2FydChzdHJ1Y3QgCj4+IHR0
bV9idWZmZXJfb2JqZWN0ICpibykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHI7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Cj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVf
Z2FydF90bGJfZmx1c2goYWRldik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB0dG1fcmVzb3VyY2Vf
ZnJlZShibywgJmJvLT5tZW0pOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYm8tPm1lbSA9IHRtcDsK
Pj4gwqDCoMKgwqDCoCB9Cj4+IC0tIAo+PiAyLjMxLjEKPj4KPgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
