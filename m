Return-Path: <SRS0=K/ap=KL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F5C433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 16 May 2021 12:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330AF601FC
	for <amd-gfx@archiver.kernel.org>; Sun, 16 May 2021 12:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330AF601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60E56E128;
	Sun, 16 May 2021 12:24:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAFF6E128;
 Sun, 16 May 2021 12:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izz8IhV91FGXPTpdyHHacsouvbcVo2tzC3A+3X2+lwqcBnTPBUx8aDKJyTT/6bTbLVCoBj9TWtHTYXxLd211yYmyT5yhA5tDCPSLWAKVX8GCoOaH8CSREWR+9DQePGV8HqXCDudJyB72uNg3fNpIiolgniPS89rT12fY8X0aM2bSnX9qgxwxn8GulJh1JVBTNXx5bSoaYrxvIF/jdhYnb7zIY4zLvWrrgiGOgDUWcqwENwfGN0TKEHEZxFKdo1euGMJjAqfkRRy7dnFfNpNsXPVOPehh2mbECQgBvpZOOk1h8i4ZNlMPVIhNmLyTGvVOIyLpPnudTbJMXNzEPa5z5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAJHpjJaK3G0U2XeiR5rPGhYIe+JbWcTlyCb8TAKn0k=;
 b=hqe+M2CaHZh8Pe/A1qeItCzSSAWRBolMd5gyg3Fm8Ppsh2PU5YFu8x4dz0d9D4m5m1wWzzyNgnPI9A2k8Ss5XeI+t9X8m3jbRPVwxKx7TgNzOfQu3qMJSOpPsLB4kc8dw9rgEkKOMU3wIlIfDh7snpAXg+oDo5Nep26g+vL6iyrAH35goPyCBFEvQKJ760n4Ks1sJOTbbs4kNUA0WQZ2xyRnbNCn0Ez3ZAmPqFgQJOsZ54BydQbuOqGPXG7CCtZxvLafKuzd3NdIq6Wba0S/5tkkG77CbNPShX4HU1YDyXwOWDkNwlsot9inDT2o7axojsOcUxXBUgQPPuVwJUAiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAJHpjJaK3G0U2XeiR5rPGhYIe+JbWcTlyCb8TAKn0k=;
 b=N4GHgfsb0gM9ODogZXsytLrhojcEcLSrdlyWPcgBg713+YLgdeV77JtNQN8wFBTck1gS1N90Nezs8z98j29pPqt9lnBL59BqHN+jhfBd+L+Op0ytIgEKfI6X+aSvm1ErJouMZt54pSiSBOXrTKbrreMOxQJNbiwlyw3fOi3NM3U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4658.namprd12.prod.outlook.com (2603:10b6:207:32::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Sun, 16 May
 2021 12:24:32 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.031; Sun, 16 May 2021
 12:24:32 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: Use %p4cc to print 4CC format
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 alexander.deucher@amd.com, sakari.ailus@linux.intel.com
References: <20210516121315.30321-1-tzimmermann@suse.de>
 <20210516121315.30321-2-tzimmermann@suse.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <46af8505-fb62-45b7-cbca-08bbe0ffa0d0@amd.com>
Date: Sun, 16 May 2021 14:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210516121315.30321-2-tzimmermann@suse.de>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:565:3911:7ef3:8923]
X-ClientProxiedBy: PR0P264CA0132.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:565:3911:7ef3:8923]
 (2a02:908:1252:fb60:565:3911:7ef3:8923) by
 PR0P264CA0132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Sun, 16 May 2021 12:24:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 346e1693-8fdb-4d0b-5d8b-08d918658efa
X-MS-TrafficTypeDiagnostic: BL0PR12MB4658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4658A37FCED1FB16D57B8976832E9@BL0PR12MB4658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LciR7WHz7g7VlYKm5fKL63eiQAfXIE3Jp0JIkMT0SmNS0R6gZ91OpZrxZfIGL9EKorvYUJlsGyHDvmwuCrbTmsvphy3WfU5MFrhhft4cQltIs/CJ757cQ2oCxLsPEyU0GYANxmRRi5cODhPMZW3UTt1nshg37vvHqcXtOUaiWz9hP3YOMolESgfAAA1h3R2I7+ZvHthonKvROzPhMg772MEoYHksPvxEdSZqsJNjMRYwpCqMu1tnryXbQ854dlyl00hq7Tsm2SZvy3EWlTJ+Kbgy1o62A4wxONrbmesNLXtOTDZOMsG4hXZcJKU1pQE/8FWkNyqtesbR3oXO66eYE/4+Eh51+2UDZggK3l/INASiT1eBuJKO5eczv0oDNKgxxCVV6zXkRWuQWRc2qaYYDRclVY7fO++b8hedPx1fXgKvjs88LOB6+iDuZQHrq/zeWLJsL3E6Uuv/BBzxu44tt5Q2D7qSd+k0J4neBE8GtP2Hx9bXJNWuzCkE2iMxPJ4/21lEyx5tQQN6ASWVPpvJKCocm/nXyWxXnzWCfZoftbFUkY9/JN0Q48RYXaI3wooYD8jKEYe8L4Gib1+ySRl72kqG8AlqsLJpGcnHzH3vxebqZksESMSjpb3WY/k/6ODEVVMrCCYPQk/tETYFEptowSYR58LuRIL+/HiXO84ZskFWyTG+vF3C1YNF8mO6vLpG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(83380400001)(2906002)(38100700002)(5660300002)(316002)(8676002)(8936002)(66574015)(36756003)(66476007)(16526019)(2616005)(66556008)(478600001)(86362001)(66946007)(31686004)(6486002)(6666004)(31696002)(186003)(4326008)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dmxyY05LN29wWDY2MFVXS2k0SUMvWXlTRFJHVVR5L3pmL0VDSyt5djA1clFw?=
 =?utf-8?B?UVpzS3dUamdZeC9ERUtYb2QrSWNFcnBqdk5uZXAvQnFCblhJcnNWUUFOd1Bs?=
 =?utf-8?B?WTA3SGlaY1RSRVRtMFo0eUpNdzlxRXp0b1hvYkduNnZWb2ViUVRJVzZGNVBG?=
 =?utf-8?B?N1ZDVmU3L3ZpWFJoRGZlRENCekxMK2JaVElIY3dQNlNOZER2QkF2WnREekdx?=
 =?utf-8?B?RE1lZWFQR0p4d2UwZlNkeWpXLzNxMXZwUmxGb09aeWptZkZqNkd0TWF2T09L?=
 =?utf-8?B?R1gzS3ZtVVBHR0l5VnNrVWhyYUFaMEY1bjdxWGJTUGExWE96L0NjY1grbVgy?=
 =?utf-8?B?UUV2SUFHcW56eVRoUWs3K05laE5QZlVwQkdIK3h2Uk1RSUwvMVpBTi9pKzEv?=
 =?utf-8?B?N29pUlJlY2RXdXJlNUlzWnZBbDBWRTA5M2VTYktyMkNZeCtnWnNOL0x4Znd2?=
 =?utf-8?B?QnRLZ1lpRmZiYU4wT3l1R2xnempLSlA1UVFCNC95dnlXZXFIbXlKTXVlZkNJ?=
 =?utf-8?B?aVJkNFFtL3F2OG9kYi9xWDZZZ1QvWnFaZnpTZ3UvQWxHMzdaZnZqWXlpU2xK?=
 =?utf-8?B?YlJPc3E4SmtEeU80b3hYM0NxbEdZTFhjQ1ZGZFBEVHJvcXRiQkYydEVJTk1S?=
 =?utf-8?B?dGZDYzRST2hYNVN6b2JlcUUwWCtnTi9zZ09sTSt1UUJFd1RuV3Q0dlhSZjFC?=
 =?utf-8?B?Nm1uQ1M5OU1uRnk0eHZ3bDJCQjdzcGYxdGtEVUFsRWlmK1VzRHNlZ2hLampj?=
 =?utf-8?B?a2p5aHlCeXY1NmtyZWVCSTNqVmtpWGx4UXhET3lJTGZCblpndWk5ZmJKd1Uz?=
 =?utf-8?B?Nmg0b2UvY3hybEVveUJheUZud0tvY2NFUm5lZmltQStnQkVja1o1NUpuSTVh?=
 =?utf-8?B?UVUxd0pFbUdjWXUxY20vNnhEdmEyZWlEdnRqbmZZWHRuZTFFMEZER1JGT0FG?=
 =?utf-8?B?QzA3V3ZqYWlEL0VaZWFVcXlSWk1iQW5ac0lTcmJBQkptTUVhYXg0OEZDdU1Y?=
 =?utf-8?B?Q2tKc3lRWUtHNW9JZVczclk1QUVzcUcrZ1hBU09ONWN2cThqaU1HMFdNTytp?=
 =?utf-8?B?R2hSemw3eTZFc1RRTXkrSDJvK2lMS1poMWkwcGJadGZwa0ljb2Z0WGlkV0FH?=
 =?utf-8?B?WWYwVWxoMUpqeFdUZjRpOUU0MUx2dllpV0U2citTVmd5dUU4WXYrVDNWMG9j?=
 =?utf-8?B?dmlad3pYTWtOaWxMN0x0M0d4N0NtT0dwVGNNRmUzRWlJTE9pSXVTNmpjeExq?=
 =?utf-8?B?eHdjZUZzVHBUYk5ibXVTVFlBb3JDM3R4MXByMkRsWXFkYWYwWWp2ZlFBYldK?=
 =?utf-8?B?akpYK2RIT1U3OCtKRGJPK2RGeDdTUnFKRWxsdjd3NEJZTW5FS2VTUFVadzE4?=
 =?utf-8?B?dEJZcW5WcVhyOXBPdGhpQklqMnRVeGdnbU1GaEcvWFZ5Z21qVjlsSTk3SjNw?=
 =?utf-8?B?bUxmVzlpVUdqSnpkdWxBSnFFVUYycWdSQ3JKRFRMTEpDd0UvZkhIM3djR3Z3?=
 =?utf-8?B?THozTmdtQ2RvK3ZmNHd1YUQwcUdBV08vU0dCeC9od2tXdmx5c21xazlNYjFW?=
 =?utf-8?B?VTdnUVVQTWNTcllIS2xHK29sOTUvYThER0JjQy9WN1g2bE1yZkRhdDZ1djBq?=
 =?utf-8?B?UlVMUHkzUWhITmVQRi80VEJsN0t4U0pTVFdkdm1NczFhb2ZkdFUvSHRuc2dG?=
 =?utf-8?B?UHI3UTFURmdDY25yZGlIWEhPUEh2cURrM3RYeGVGWG1OLzhZdmcwRWJlMFFp?=
 =?utf-8?B?MTNmWnZVSGMyQm9XcEFjMXYvY0ZZZC95NVc2RXluQVBBc2t5VUJKTmVGN3F2?=
 =?utf-8?B?VXhUZzdSbEtwVm1IWGNKV1kyZWVKR2ljVEEvM1pnSFVORGllNUhOdlVVQ1p4?=
 =?utf-8?Q?7CtqpJJwjbA9X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346e1693-8fdb-4d0b-5d8b-08d918658efa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 12:24:32.3499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QLKSaT2Wl9EDAflvmlW9ABJ7wYRrNYrZaFPu0CvbRSZ50vd/S2o6rTnfLy+Jgmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4658
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDUuMjEgdW0gMTQ6MTMgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoKPiBSZXBsYWNl
IHVzZSBvZiBzdHJ1Y3QgZHJtX2Zvcm1hdF9uYW1lX2J1ZiB3aXRoICVwNGNjIGZvciBwcmludGlu
Zwo+IDRDQyBmb3JtYXRzLgo+Cj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6
aW1tZXJtYW5uQHN1c2UuZGU+CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kaXNwbGF5LmMgfCA3ICsrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kaXNwbGF5LmMKPiBpbmRleCA4YTFmYjhiNjYwNmUuLjQ5ZjczYjViODliMCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+IEBAIC0xMDc3
LDEyICsxMDc3LDkgQEAgaW50IGFtZGdwdV9kaXNwbGF5X2dlbV9mYl92ZXJpZnlfYW5kX2luaXQo
Cj4gICAJLyogVmVyaWZ5IHRoYXQgdGhlIG1vZGlmaWVyIGlzIHN1cHBvcnRlZC4gKi8KPiAgIAlp
ZiAoIWRybV9hbnlfcGxhbmVfaGFzX2Zvcm1hdChkZXYsIG1vZGVfY21kLT5waXhlbF9mb3JtYXQs
Cj4gICAJCQkJICAgICAgbW9kZV9jbWQtPm1vZGlmaWVyWzBdKSkgewo+IC0JCXN0cnVjdCBkcm1f
Zm9ybWF0X25hbWVfYnVmIGZvcm1hdF9uYW1lOwo+ICAgCQlkcm1fZGJnX2ttcyhkZXYsCj4gLQkJ
CSAgICAidW5zdXBwb3J0ZWQgcGl4ZWwgZm9ybWF0ICVzIC8gbW9kaWZpZXIgMHglbGx4XG4iLAo+
IC0JCQkgICAgZHJtX2dldF9mb3JtYXRfbmFtZShtb2RlX2NtZC0+cGl4ZWxfZm9ybWF0LAo+IC0J
CQkJCQkmZm9ybWF0X25hbWUpLAo+IC0JCQkgICAgbW9kZV9jbWQtPm1vZGlmaWVyWzBdKTsKPiAr
CQkJICAgICJ1bnN1cHBvcnRlZCBwaXhlbCBmb3JtYXQgJXA0Y2MgLyBtb2RpZmllciAweCVsbHhc
biIsCj4gKwkJCSAgICAmbW9kZV9jbWQtPnBpeGVsX2Zvcm1hdCwgbW9kZV9jbWQtPm1vZGlmaWVy
WzBdKTsKPiAgIAo+ICAgCQlyZXQgPSAtRUlOVkFMOwo+ICAgCQlnb3RvIGVycjsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
