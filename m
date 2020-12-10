Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B500C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 13:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8C723D50
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 13:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8C723D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 089AF89DA6;
	Thu, 10 Dec 2020 13:03:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E41E89DA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc2M2lwdqZXV8yzgda3Fpc3oG0h/TsHwBxLzTIh2wNoY/4cEIeVX7qYdJdIKuRx3oZSOUiZMagzrf5QdELV/fa2lXpA1rK7i42jQxauUoehxK7eW41SYtVXWiE8t1PiF7+ujf2P9wYpyx+ja48V1pchT4S4tLt2yk6YazwTxpmLEedrPITl/Q5xLJhYPmRDrBno+m6ABLL8BKiz4TFzN8pwWgaNiuIQj9FcPotLs4gZxsa+c3Rbs3lHoadvuSosjstxVLyAJepz6IjFsLgmtLvMWzKs451IaSw13bKviRvzF9vUzsuvZQLP2J0RzzMS550JL3sBKSxB4Lqc39Rjgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1w59/pD5ktTvBmrmdrQOruzwulBQKWzBGH7oZgTm/M=;
 b=bhnqLlpsCSNLKuz+L5JdqMDI56icVmrNEn/csWs7yx4NzOKbOyX2L82GSISuM3Xxl3hRSdVJnv+1RblHn/TVegq6fmcRMdsJ31LB5ehDCdhiUcSLeZ32TqGFZYaKwtH5IpyJ7Hl8QK7S1IxWAhDSy2ggTu+YTf6ZvsrtWqVIPgMqITZ32Gv5qfilgOqDRZDCbRPV2AJMlyPXeH1m9g+qINAtwRN7DktbKfSg6A8JN3KL0gKdEAeJvGgNQTVfY3OhCkLwUL+FyzjItN49oIgxuHwDxvGMUuJaCijd+BFE1r2MYMFt2tDAEtzlzw2vlQegIeN1rdle4uwUVOCrzp8K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1w59/pD5ktTvBmrmdrQOruzwulBQKWzBGH7oZgTm/M=;
 b=f5i9nnL3cxe/0FiIsddGWCE4hoDgWlfd+l72sbc4fDxChcCaXxghws12BP8rOBafEcyPU6ZGKYKdLRKdGhgffSMEIecSFz/5eE4e6Db03DDtmIjmoaTuzuAsZANEUjCwC9CD5D7nK4cIieA37Q7H7wYgPXWvC/l5dADt/B2gpwg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3133.namprd12.prod.outlook.com (2603:10b6:208:c7::16)
 by MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 13:03:31 +0000
Received: from MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::9102:eadd:7252:9135]) by MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::9102:eadd:7252:9135%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 13:03:31 +0000
Subject: Re: [PATCH] drm/amdgpu: take runtime pm reference when we attach a
 buffer
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20201204204130.3697-1-alexander.deucher@amd.com>
 <CADnq5_PABFEnCdvnZfm832aDHti66ujdzTjUFur3FT-O-+wbKg@mail.gmail.com>
 <410bc5c9-381b-5e65-5595-ec891f0edae2@amd.com>
 <2eb41038-2e69-68ab-2f6b-017cd1bcb455@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <dd8e7365-c432-f6bc-407e-e3cb1f88d9f5@amd.com>
Date: Thu, 10 Dec 2020 18:33:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <2eb41038-2e69-68ab-2f6b-017cd1bcb455@gmail.com>
Content-Language: en-US
X-Originating-IP: [106.51.105.40]
X-ClientProxiedBy: MA1PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::22) To MN2PR12MB3133.namprd12.prod.outlook.com
 (2603:10b6:208:c7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.105.40) by
 MA1PR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 13:03:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a4ae0c6-7b22-4950-8126-08d89d0bfed7
X-MS-TrafficTypeDiagnostic: MN2PR12MB2878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2878084E67083188DC45294BF2CB0@MN2PR12MB2878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CS6/DZDXmr4Rz91pQAalnNYM9kdW7M37bY7thbQRGOiPKTD1i3bSEWcgPIYCHNdxiCsmthu9RUaVcKK5DvVS7sDrcpxdVHIAawO8ZxJAGgHGiHYJSo2tzWtR8sWrhBZWXpgdXgroyDmt4NQbKNFIfURHMQHxPW1vV51L9g2WaYjitpDa3zVHzhGTIFaKwVoOcNIo4yOUtY1t91zSDNfbPgiNGZUHhBLGkjrtEsGjVdLX0kasrmYDUQsKd3MJhzY/rSSunFYvc7vhkvNFnpBW+PIqJwrOy0sgP/nyDvq85m5Ep2iDec55AE4ox1t1V07sEwE0GHe8wR0BWLO1E4Vf4gttS6s9dhD4q7d1xdthcsyuQ19c9TYSHr1PTsSN3yFQrTF3jnyjS5QbPgjNGwWcQr7dt3qY42wQJOiNR8cX3r8JQ7WtCLfPVNEAum7YtR3ijadOhr24AJy8HdLdK66G/YGinRTjG8XCs8ZCpQ3WTWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(66574015)(34490700003)(31696002)(36756003)(86362001)(508600001)(66476007)(26005)(31686004)(53546011)(2616005)(55236004)(6486002)(16576012)(186003)(44832011)(16526019)(66946007)(8936002)(966005)(956004)(2906002)(45080400002)(66556008)(52116002)(1006002)(8676002)(6666004)(83380400001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QjAwN3FHbFNoNzJ6eEwzOWEvL3RwOXZRMkxiTFduc2lXWDVLQWdBY0FpYXNj?=
 =?utf-8?B?aGdhWXJoTS8zYkdGWHYzWEcwZ3FYd0J1OGVKMmNhY0cwNjRxTUtMZ3lCUVZ2?=
 =?utf-8?B?Lytldk1KVWlFcVBYak52Z2dyNzJlZTFjV0ZqTHUvSkgvWFZQYnh1VUxMbXdU?=
 =?utf-8?B?VjBhYStEd05vRUcrOTR5VDN2WlZtc1g2UVR3R2ROaHZRQ2ZKR3lRY2Y5V2Rt?=
 =?utf-8?B?UCtiOUlsQWtON0xDcit1NzQ0aUJTVUNvM08rdm1JVW9tWEFPSTU4Y2dsUEtq?=
 =?utf-8?B?eUx6UkN0N2k1eWpzZnp0Y1lzbll1LzdCZkxtZE1FZDhHcUh6QmZ0OGpqc3B2?=
 =?utf-8?B?SW1ibEJaTWFsV3JQTk9DT3I1NTVJNGtNQTRmeDc1Wnl0MVlmeW5NQ1o4NnFN?=
 =?utf-8?B?NzFzQWVxbGdCV0JGb0ovUUxiQkFhb0daMjNGSlZNY1FqNHdTNVJ5K3hVN0F0?=
 =?utf-8?B?S0ZGZUhVcFNnUldBejRxNmZrRENLY3dtL1JOdVhHMXZVb3JsTmZMWTl5eFZz?=
 =?utf-8?B?dExBTlNMUVBmN3cxejlPVldRMWY0WWRrOGxBREdSaWZjamc0QVlkN3F4S21W?=
 =?utf-8?B?WExOdFQwY0phTkdmVVpXbi85cU9acWp3aXA3U3RyOXoyUWNiQnV5VFgveEo2?=
 =?utf-8?B?VitxY3VIdENYSUZTM0xPZVE3STNIc1ZaK0liWnlEa3JPbFRtY2FZWmg3QlE0?=
 =?utf-8?B?VTdwTGl2L0thUGtYYmNjekVMMW5JUDJIOXRBcHowbGxtS2h4eW1GbkNqME5P?=
 =?utf-8?B?bzJuN1R1QnEzMXV3S2lzWk9GSDNNbGl2RTFDb2ZCanBHRlVkOGt6RGh0cUll?=
 =?utf-8?B?d20vOE54ekNTNUpZOXM5RkZKNDUvNHlwV3V5MVJpaDVpSkN6QkhiVXIzYmdD?=
 =?utf-8?B?Q2U4Q0NORjdRUmZpMC9Jakg4cFJZZXRnYzljTHFsZjU2V3JkVnlpYzlZOFB2?=
 =?utf-8?B?VWd5QjAybTRsNnR6VkRoa05XVC9aUHc1V3hPUzd4cERDbWtsbVJOT0ttMkFC?=
 =?utf-8?B?aTlTMGZtMmUzcVpCaDE5cVFrK2xIZDNwR1FmTW1Jd25WTC9TSE90bWdjMmFB?=
 =?utf-8?B?bmFCaE13WFE2enJBZDBPeU5Za1loMUtQRGpRRjZUNFdwQ2lKSmpJRElnc3dF?=
 =?utf-8?B?VS82U1J4ckVUNjVNR3pKdlh0WFQ5cHdmNnRaQWhCWVhLSDVua29CNFBsZ0Vm?=
 =?utf-8?B?Z1BmMGNVOEJpeWN0UG9NdGdSK1FWQmJrbWJzMm5mVGxjM1BxeDhZblQ4MFdX?=
 =?utf-8?B?TUpJWW5DamZ6WTRsTVFnUmRiVjZEck1sbitzODVTbnorNmZTNlNLbkxJRU1R?=
 =?utf-8?Q?qtujdbiDM4bq4WqQ6wshKuXu8/2S3pskEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 13:03:31.7503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4ae0c6-7b22-4950-8126-08d89d0bfed7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQR/xeiEn/a48canH6Q6XUmWsDTq0SsxFfIJLABdgTkKY0ZsYXLFXayVReGDRFin7zLweizEvUFZDPSLx9EA4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
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

Ck9uIDEwLzEyLzIwIDM6NTggcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTAuMTIu
MjAgdW0gMDU6NDkgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IE9uIDA5LzEyLzIwIDExOjAw
IHBtLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+PiBPbiBGcmksIERlYyA0LCAyMDIwIGF0IDM6NDEg
UE0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+IEFuZCBk
cm9wIGl0IHdoZW4gd2UgZGV0YWNoLiAgSWYgdGhlIHNoYXJlZCBidWZmZXIgaXMgaW4gdnJhbSwK
Pj4+PiB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBwdXQgdGhlIGRldmljZSBpbnRvIHJ1
bnRpbWUKPj4+PiBzdXNwZW5kLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4gUGluZz8gIEFueSB0aG91Z2h0cyBvbiB0
aGlzPyAgV2UgcmVhbGx5IG9ubHkgbmVlZCB0aGlzIGZvciBwMnAgc2luY2UKPj4+IGRldmljZSBt
ZW1vcnkgaW4gaW52b2x2ZWQsIGJ1dCBJJ20gbm90IHN1cmUgb2YgdGhlIGJlc3Qgd2F5IHRvIGhh
bmRsZQo+Pj4gdGhhdC4KPj4+Cj4+PiBBbGV4Cj4+Pgo+Pj4KPj4+PiAtLS0KPj4+PiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgfCAxNiArKysrKysrKysrKysr
Ky0tCj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZG1hX2J1Zi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYu
Ywo+Pj4+IGluZGV4IDViNDY1YWI3NzRkMS4uZjYzZjE4MmYzN2Y5IDEwMDY0NAo+Pj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKPj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4+Pj4gQEAgLTQwLDYg
KzQwLDcgQEAKPj4+PiAgICNpbmNsdWRlIDxsaW51eC9kbWEtYnVmLmg+Cj4+Pj4gICAjaW5jbHVk
ZSA8bGludXgvZG1hLWZlbmNlLWFycmF5Lmg+Cj4+Pj4gICAjaW5jbHVkZSA8bGludXgvcGNpLXAy
cGRtYS5oPgo+Pj4+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgo+Pj4+Cj4+Pj4gICAv
KioKPj4+PiAgICAqIGFtZGdwdV9nZW1fcHJpbWVfdm1hcCAtICZkbWFfYnVmX29wcy52bWFwIGlt
cGxlbWVudGF0aW9uCj4+Pj4gQEAgLTE4Nyw5ICsxODgsMTMgQEAgc3RhdGljIGludCBhbWRncHVf
ZG1hX2J1Zl9hdHRhY2goc3RydWN0IGRtYV9idWYgKmRtYWJ1ZiwKPj4+PiAgICAgICAgICBpZiAo
YXR0YWNoLT5kZXYtPmRyaXZlciA9PSBhZGV2LT5kZXYtPmRyaXZlcikKPj4+PiAgICAgICAgICAg
ICAgICAgIHJldHVybiAwOwo+Pj4+Cj4+Pj4gKyAgICAgICByID0gcG1fcnVudGltZV9nZXRfc3lu
YyhhZGV2X3RvX2RybShhZGV2KS0+ZGV2KTsKPj4+PiArICAgICAgIGlmIChyIDwgMCkKPj4+PiAr
ICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4+Pj4gKwo+PiBJIGFtIGEgYml0IHNrZXB0aWNhbCBp
ZiB3ZSBzaG91bGQgZmFpbCB0aGUgQk8gcmVzZXJ2ZSBpZiB3ZSBkb24ndCBnZXQgdGhlIHN5bmMg
PyBJIHdhcyBob3BpbmcgdG8gY29udGludWUgd2l0aCBpdCwgd2l0aCBhIHdhcm5pbmcgbWF5YmUs
IHNvIHRoYXQgaXQgZG9lc24ndCBibG9jayB0aGUgZXhpc3RpbmcgZnVuY3Rpb25hbGl0eSA/Cj4g
SSdtIG5vdCBzdXJlIHdoeSBwbV9ydW50aW1lX2dldF9zeW5jKCkgY291bGQgZmFpbCwgYnV0IG5v
dCBhdHRhY2hpbmcgdGhlIAo+IERNQS1idWYgaXMgY2VydGFpbmx5IHRoZSBiZXN0IHdlIGNvdWxk
IGRvIGhlcmUgaW4gdGhhdCBtb21lbnQuCgpBaCwgSSBzZWUuIEp1c3QgY3VyaW91cyBhYm91dCwg
YmVmb3JlIHRoaXMgcGF0Y2gsIHdoZW4gd2UgdHJpZWQgdG8gcmVzZXJ2ZSB0aGUgQk8sIHdpdGhv
dXQgdGhlIFBNIHN5bmMsIGhvdyB3YXMgdGhhdCBkb2luZyBPSyA/CgotIFNoYXNoYW5rCgo+IE90
aGVyd2lzZSB3ZSBjb3VsZCBlbmQgdXAgaW4gYWNjZXNzaW5nIHRoZSBQQ0llIEJBUiB3aXRoIHBv
d2VyIGRpc2FibGVkIAo+IGFuZCB0aGF0J3MgaW5kZWVkIGtpbmQgb2YgYmFkLgo+Cj4gQ2hyaXN0
aWFuLgo+Cj4+Pj4gICAgICAgICAgciA9IGFtZGdwdV9ib19yZXNlcnZlKGJvLCBmYWxzZSk7Cj4+
Pj4gICAgICAgICAgaWYgKHVubGlrZWx5KHIgIT0gMCkpCj4+Pj4gLSAgICAgICAgICAgICAgIHJl
dHVybiByOwo+Pj4+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsKPj4+Pgo+Pj4+ICAgICAgICAg
IC8qCj4+Pj4gICAgICAgICAgICogV2Ugb25seSBjcmVhdGUgc2hhcmVkIGZlbmNlcyBmb3IgaW50
ZXJuYWwgdXNlLCBidXQgaW1wb3J0ZXJzCj4+Pj4gQEAgLTIwMSwxMSArMjA2LDE1IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X2RtYV9idWZfYXR0YWNoKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsCj4+Pj4g
ICAgICAgICAgICovCj4+Pj4gICAgICAgICAgciA9IF9fZG1hX3Jlc3ZfbWFrZV9leGNsdXNpdmUo
Ym8tPnRiby5iYXNlLnJlc3YpOwo+Pj4+ICAgICAgICAgIGlmIChyKQo+Pj4+IC0gICAgICAgICAg
ICAgICByZXR1cm4gcjsKPj4+PiArICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4+Pj4KPj4+PiAg
ICAgICAgICBiby0+cHJpbWVfc2hhcmVkX2NvdW50Kys7Cj4+Pj4gICAgICAgICAgYW1kZ3B1X2Jv
X3VucmVzZXJ2ZShibyk7Cj4+Pj4gICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4gKwo+Pj4+ICtvdXQ6
Cj4+Pj4gKyAgICAgICBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChhZGV2X3RvX2RybShhZGV2
KS0+ZGV2KTsKPj4gV2h5IG5vdCBqdXN0IHBtX3J1bnRpbWVfcHV0X3N5bmMgPyBXaHkgYXV0b3N1
c3BlbmQgPwo+Pgo+PiAtIFNoYXNoYW5rCj4+Cj4+Pj4gKyAgICAgICByZXR1cm4gcjsKPj4+PiAg
IH0KPj4+Pgo+Pj4+ICAgLyoqCj4+Pj4gQEAgLTIyNSw2ICsyMzQsOSBAQCBzdGF0aWMgdm9pZCBh
bWRncHVfZG1hX2J1Zl9kZXRhY2goc3RydWN0IGRtYV9idWYgKmRtYWJ1ZiwKPj4+Pgo+Pj4+ICAg
ICAgICAgIGlmIChhdHRhY2gtPmRldi0+ZHJpdmVyICE9IGFkZXYtPmRldi0+ZHJpdmVyICYmIGJv
LT5wcmltZV9zaGFyZWRfY291bnQpCj4+Pj4gICAgICAgICAgICAgICAgICBiby0+cHJpbWVfc2hh
cmVkX2NvdW50LS07Cj4+Pj4gKwo+Pj4+ICsgICAgICAgcG1fcnVudGltZV9tYXJrX2xhc3RfYnVz
eShhZGV2X3RvX2RybShhZGV2KS0+ZGV2KTsKPj4+PiArICAgICAgIHBtX3J1bnRpbWVfcHV0X2F1
dG9zdXNwZW5kKGFkZXZfdG9fZHJtKGFkZXYpLT5kZXYpOwo+Pj4+ICAgfQo+Pj4+Cj4+Pj4gICAv
KioKPj4+PiAtLQo+Pj4+IDIuMjUuNAo+Pj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5v
cmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NzaGFz
aGFuay5zaGFybWElNDBhbWQuY29tJTdDOTk1N2M1YjgzOGZjNDlhZTIyNWUwOGQ4OWNmNjQ5YTEl
N0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MxJTdDNjM3NDMxOTI4ODk1
OTAyNjE3JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRh
PUFNdFdOU1pSeUZaRFJIaEU3aHNJZEJXeFRIVkxHWVZPSFpPU2VSU1IwN3MlM0QmYW1wO3Jlc2Vy
dmVkPTAKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJG
YW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDc2hhc2hhbmsuc2hhcm1hJTQwYW1kLmNvbSU3Qzk5
NTdjNWI4MzhmYzQ5YWUyMjVlMDhkODljZjY0OWExJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMSU3QzYzNzQzMTkyODg5NTkwMjYxNyU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1BTXRXTlNaUnlGWkRSSGhFN2hzSWRCV3hU
SFZMR1lWT0haT1NlUlNSMDdzJTNEJmFtcDtyZXNlcnZlZD0wCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
