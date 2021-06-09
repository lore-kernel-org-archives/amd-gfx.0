Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84066C48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B4A601FC
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B4A601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D466E504;
	Wed,  9 Jun 2021 15:21:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360B56E504
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 15:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJNtVPPu3uJCrATYjwdBpJTzZG/Y+dmvBcvVO+/2ElyHtPQHT2fbjaxAZQr6GO9Hnxjbw7h4sh2H9c2WnVTIWmCoTM8LAkJelOMGFXnkY0CY+fU1TGBlN1PsFuQYllOvMXAIAQkApRZc4+ogcMXMIJ0eka5Aa9ODS8iU33iJRe/b/ZMiFoyzkkMnuR4ZHby8aqWGfqHfbzxvLXbpJrXaK9+5tn3IWqfEsI1aqLwGFcuFXXKXMntUz2i7I8ATL6NA+1F0dDxGPXlOteSg3EQoiY8nMytmgfiVuurt4hKEOhDoT8P5azZw+mpJIO07J99MngLojkaXCeOm/S//vrqSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WNfUoKT5LjqIwUj7L9ZlQncwby8lAzvi5GjCGkAPkw=;
 b=M+625SFA8OOHE74AGxS3p7NMilvFcggRox5yYOM3ZhS7nC9uYtf5Fza/h1i2JmgAkbtIv5W/q4sqt5vXKzFBluuUe1h4MpvUTBuc+xwCV5CZrc0SgMBZCTVqkDaoYqHgqUVQ/S3cO9e+5HLI9ZgaJ7fBUhKy4R9m+rJFLS5je1nMwOoXMkayCBe+HoyYG6jnqBGdbRRR6+e5+h/Ro4ihcEY+/BLZ0a9w/Py0a8gu2d/Ra8bqGLg/xSEmhg4/Y5aUBV0XjHDXXqa81+Su2rkFpqRZtEA/7bLgsxyp1un47ShhGOOVDl/2eZiNeHoF1qzEAV1NC97cwT+Tosf/r9W4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WNfUoKT5LjqIwUj7L9ZlQncwby8lAzvi5GjCGkAPkw=;
 b=5Njxym9nUZbbz1paqqiSNuH74s10hcbDCsJ9KrKGFvN+YW6WcMO/8kW6Uv1dMrubWGuJgTy45DoZUrU8Abn2kZeTAg7xFTZYjLqGG+Scan7DVwZ9QDvQh/g48yQkToYOsOzDtBHPUZLe21CTfA91a1nwOQewIeomg2n2oY7BqJU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Wed, 9 Jun 2021 15:20:51 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.022; Wed, 9 Jun 2021
 15:20:50 +0000
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
To: Felix Kuehling <felix.kuehling@amd.com>, Guchun Chen
 <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210609092323.32650-1-guchun.chen@amd.com>
 <ab48ac1a-16a4-3bc2-13e4-bb3c1fb6a3ba@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <59df3448-f49c-1390-5031-327293bc1f38@amd.com>
Date: Wed, 9 Jun 2021 11:20:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <ab48ac1a-16a4-3bc2-13e4-bb3c1fb6a3ba@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 15:20:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a3a79b4-da64-4ba3-4bba-08d92b5a2a53
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13555018D9F9E1051580EF8B99369@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juY1JfI8yOs+kpo0Ll9wJ8PEn4hltxbBg/EyQzsAbFZbK/Bj2ObdJD+tom4GaxFBxKnDnC56+QlfEi+9RrJpLRjMneaUWFQsiYBMD/UVGaBIlJ4/e4W3DgDiD8elfZjvGNpF1H6BQ7z8JjW4jM5znF9XKVCmKWKD0mj2JRSMJFYA0UlO/+PQcqbc/GDvDw/pwZ1TDu/cNX2Ciu8GfJ/ZfplcT7gtitwdHnOSgk9PJflHmoreGvbV6IjwONW2I2QfpcbJwiVBSCBa5wcPHe0TVo57ocxQL6CKSoOhVlytNHWLh4rxCKib6cI+OI6EPpstbG9xoGNOJVo66kMSwf4wOmbRwOfk12hWiP0Tuv3G5zBnqWiGbvpOwLDW7AFSxHVpWdNSE+Ggmg2AjJMRcP799DRZQEo6a4k1GD8FRPUNiMdwBrMVK7LoqTt3o8vs+Y4IkJUrOdZM06XDbF0DBPCTCds7pVR0FL5vBJYv3DUBus8xqpg3rDQFYPccd48zpO+8rzj20rH/8aXjNoYjw12M9C9/J0OF/UQpLi96LCFdJFZSezEU7bSWuwOD4xWSdN+V6Rubc4WSeT/L6/FrpuSRjvvrARmWDL63uisHDN5cqGKxRXfQ+K0s9h+wnBr7mJPG+BSWKzES7i/rhEjBikG4HlW7O568GMstFg8dtLIW6LOPVlQvqv55tEXFUtLtJ9O+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55236004)(186003)(26005)(2616005)(16526019)(956004)(8676002)(6512007)(66476007)(66556008)(44832011)(66946007)(2906002)(110136005)(8936002)(53546011)(498600001)(6506007)(38100700002)(6486002)(31696002)(5660300002)(31686004)(86362001)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnM2ZyttaVN5V1VQcCtBTGl4bUZ6VHpKenpVdGJTTHE3bmQ4dmw3STNPZ0wx?=
 =?utf-8?B?UGd3enpONWp0MU9WZjFhZS9ENlFCbEpzQThCSWx1cXJKQlJsbzJuM1ZmdkRu?=
 =?utf-8?B?NjNtTUlLQ0JqZ3J3OWpGYmxlblFsZENFWUN0ZHJnR09NZXNHTlorVWFCcGlu?=
 =?utf-8?B?VmR5T1lrelUrZk43aGw4TlNKT095ajg2bWszTHVjK1pKS3JSaDIrbmh0T0JI?=
 =?utf-8?B?dzJveFVYU1plOVB4U1VKZjV4NHBxai9zTG1uRGNoTXh6K0MzV1hNWDJybE5N?=
 =?utf-8?B?cjVMUHpFUWxYZlFsVTRqV0hSTXA2UTJad2Mwd25sS0tzUzYrWW9uS3ArQXpq?=
 =?utf-8?B?c1Yvc0Z1S3M1ZFhZSG5UalU3VGxZT0RPNHAvcFJWMEF3QzF3Q0xnVXJNcmRR?=
 =?utf-8?B?Y0E5VUt2bjJFSUJ6Q2J2cG14dTBKdERJdmlFaDU3dllsVVFVSmRCNG1sM0Jp?=
 =?utf-8?B?WnIrYW9wTFhja0dvczRrQ2ZFUEVEendPbHcvUmZwbUwyYVlEREZoN0ZIVXU2?=
 =?utf-8?B?YzY0S3FocjAzUzZSeVp0ODlBSHcwUllERFZJVktwbHVLekdSS3pTNWlRS0hD?=
 =?utf-8?B?bXNwUnJ5dTBZYjdYbVJKeVpFek9NbGR0R3QyWUhxNmNpU0d3ckJOc3VONG9h?=
 =?utf-8?B?UGRwZGVkVHV1MkJoTnRVL1VUZlNyalNYS2o3RTh6S0tEazY0UThWTzJjYndM?=
 =?utf-8?B?Q1dJTjZKLy9UZzNNZlRQNXJWamx6YlFyVUhDNzI0UThUOFdkOGtjM2I3cGpH?=
 =?utf-8?B?Y29hN0JsQ2p2d0tiZ3ZTMWVXamlvZGpaQ0pWTDFldjNhMlZjQVlSNXVpN21D?=
 =?utf-8?B?SFo4ZG85N3EyTHFLUTdRMFIranJFTXRldTZYbS9tVXJ2ZlBqRmdzb1M5OUxr?=
 =?utf-8?B?ZHNwNkFWb2JYNVVaUS83TWY0a25hZStxa29DbXRXNjlYdENvNGRvZ3cxSGUv?=
 =?utf-8?B?dW1YZTJ0YURLUzRsMU9yWUFuRkRVRnBDampDUzYvWGhRVThMR3FOZHdWWDRk?=
 =?utf-8?B?SHNZVHQxSElheFowdDB1cW8wQTZoNFo0SExBUFN4M0pXSXNoMUlPaCtCd1Z6?=
 =?utf-8?B?QUwvWVVtYytCVUxKVW82dDJHSHpWZHpCUjNyRFRKaUlKYjV0eWdvSmRPdkYw?=
 =?utf-8?B?M1NSSDMwRWFTLzB0b0s1Z2Y2YnBtR3RpSjBiUldRQkE1M2ZQais3dFNnT3lW?=
 =?utf-8?B?M0sySW9VbjFvTTAyNGY5R08zUEdVK1ZjMkpZODRsVlZGMmFvOC9tbnNYblMr?=
 =?utf-8?B?OUhGVU5ndDlLOHhpMWdIWmhZRlJwSUZKNXlqRThTVXJUdWwvN2JvbjMvMlY2?=
 =?utf-8?B?Rk0vY1RTYjM3QVBCNnh2N2w1TVh2Ri95RXpTc0pxMlgxY3lIakxMcnNLbFgw?=
 =?utf-8?B?Z21TeFhxZGw1ODNhbzd6UThXL2YvU3dicXViUG1YekFlQkV6akhsVTlYZjhE?=
 =?utf-8?B?R0hQZ3lwTjVEcmFuTDJkYmtWWmMvT0VhUjE0R3M5bkJ0M1BBVkhhWWc4VlZX?=
 =?utf-8?B?Mk0vclZIZ3dQR0VvU1RtUXZNYWhKT0RqYjJyOVpTQ1QvTmRaZjhXR3ZxNDh5?=
 =?utf-8?B?bjZMMWdZTndGemZTa0VnWDJmem5SOUZZM3lmdjFFRzhhWWlRSkMxQ2JKU2Nj?=
 =?utf-8?B?QVU1bEhYaWNRM0FjajBGUTVPRXk5M0FDYkNwTUlycDg1TVphcEFPMnhHMy9v?=
 =?utf-8?B?a1FYWUx2bFEwMkNHUk9rSVdOU1hGWTdkUCtFU0JnajNGdFdJd3ZHUnFLZXor?=
 =?utf-8?Q?s9LkCrh255PbIpZZpBUc/OcjHwXEHt2cRl4coUV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3a79b4-da64-4ba3-4bba-08d92b5a2a53
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:20:50.8168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qO+EyrVBfAKrT++uXRAXo8QjEUmYSEz0gatblXsQc/dmqC1xuJmHQtYvNUPkIXJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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

T24gMjAyMS0wNi0wOSAxMDowMSBhLm0uLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBBbSAyMDIx
LTA2LTA5IHVtIDU6MjMgYS5tLiBzY2hyaWViIEd1Y2h1biBDaGVuOgo+PiBGaXhlczoKPj4gOWZh
ZjI2MmMzMmQzIGRybS9hbWRncHU6IEFkZCBETUEgbWFwcGluZyBvZiBHVFQgQk9zCj4+IDA5MGYz
YTYwZDdlOCBkcm0vYW1kZ3B1OiBVc2UgZGVsYXllZCB3b3JrIHRvIGNvbGxlY3QgUkFTIGVycm9y
IGNvdW50ZXJzCj4gQSBGaXhlcyB0YWcgaW1wbGllcyB0aGF0IHNvbWV0aGluZyB3YXMgYnJva2Vu
LiBIb3dldmVyLCB0aGUKPiBpbXBsZW1lbnRhdGlvbiBvZiBhZGV2X3RvX2RybSBkb2VzIHRoZSBl
eGFjdCBzYW1lIHRoaW5nLiBJIGRvbid0IHNlZSB0aGUKPiBwb2ludCBvZiB0aGlzIHBhdGNoLiBJ
dCBkb2Vzbid0IGZpeCBhbnkgcHJvYmxlbSwgYW5kIElNSE8gZG9lc24ndCBtYWtlCj4gdGhlIGNv
ZGUgbW9yZSByZWFkYWJsZS4KCldlIGFkZGVkIHRoaXMgZHVlIHRvIHNvbWUgY2hhbmdlcyBpbiBE
Uk06Cgo4YWJhMjFiNzUxMzZjMyBkcm0vYW1kZ3B1OiBFbWJlZCBkcm1fZGV2aWNlIGludG8gYW1k
Z3B1X2RldmljZSAodjMpCjRhNTgwODc3YmRjYjgzIGRybS9hbWRncHU6IEdldCBEUk0gZGV2IGZy
b20gYWRldiBieSBpbmxpbmUtZgoKSXQncyBnb29kIHRvIHVzZSB0aGlzIGlubGluZSBmdW5jdGlv
biwgdG8gYWNjb21tb2RhdGUgbW9yZSBmbGV4aWJsZSBEUk0uCgpSZWdhcmRzLApMdWJlbgoKPgo+
IFJlZ2FyZHMsCj4gwqAgRmVsaXgKPgo+Cj4+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxn
dWNodW4uY2hlbkBhbWQuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDIgKy0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yYXMuYyAgICAgICAgICB8IDIgKy0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+IGluZGV4IDAxNjgxNWI3YTc3My4u
ZmI2YmNjMzg2ZGUxIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+IEBAIC02MzksNyArNjM5LDcgQEAga2ZkX21lbV9hdHRh
Y2hfZG1hYnVmKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qga2dkX21lbSAqbWVt
LAo+PiAgCQl9Cj4+ICAJfQo+PiAgCj4+IC0JZ29iaiA9IGFtZGdwdV9nZW1fcHJpbWVfaW1wb3J0
KCZhZGV2LT5kZGV2LCBtZW0tPmRtYWJ1Zik7Cj4+ICsJZ29iaiA9IGFtZGdwdV9nZW1fcHJpbWVf
aW1wb3J0KGFkZXZfdG9fZHJtKGFkZXYpLCBtZW0tPmRtYWJ1Zik7Cj4+ICAJaWYgKElTX0VSUihn
b2JqKSkKPj4gIAkJcmV0dXJuIFBUUl9FUlIoZ29iaik7Cj4+ICAKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+PiBpbmRleCBlYzkzNmNkZTI3MjYuLmJmYmNiOWZmMjQ1
MyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+PiBAQCAt
MjEyMiw3ICsyMTIyLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19jb3VudGVfZHcoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQo+PiAgCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBjb250YWlu
ZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9yYXMsCj4+ICAJCQkJCSAgICAgIHJhc19jb3VudGVf
ZGVsYXlfd29yay53b3JrKTsKPj4gIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGNvbi0+
YWRldjsKPj4gLQlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gJmFkZXYtPmRkZXY7Cj4+ICsJc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiA9IGFkZXZfdG9fZHJtKGFkZXYtPmRkZXYpOwo+PiAgCXVuc2ln
bmVkIGxvbmcgY2VfY291bnQsIHVlX2NvdW50Owo+PiAgCWludCByZXM7Cj4+ICAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
