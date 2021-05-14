Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CE5C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866E261440
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866E261440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E856EE0E;
	Fri, 14 May 2021 07:18:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421C26EE0E;
 Fri, 14 May 2021 07:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJHScgbdpZX8wgNy/fKLsa+WPDZso3Pklr19Rtbc7F16H4VSVxhhHJ41ubDeYYEU9nNIbmaH4G0xcnEFkxk2513ZSHtbxa0wwHJRZuKqfu35NvhtctXABT2vm0uCjLRXHopcE3hl/wQCNy+SGz7ZtLx2WqzbLDw7A/+BNBJ29mOsD6xGuTeHF3SthE1VoA7eklZK/WaU5ZPAb3wwHDyxtTSO/iStkkU/vu+7i9tKkErG019vdWGYC9aMWFWRFwIBlogeAsdsth/R4qhvK33AjKf4w7EN/M6XbE/obFZEVDRD3j/S9l7YeS/M6bbdeKQ9RtOHKHF84kTkPtPErp0uOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKKIXMdTyRPJALPYri6c3qB8qO6iWPYhHjjPMznM+Z8=;
 b=L+ZmUwWYOKWkfAur0SSpwf5ZOvFTyvz8UT0wCIxyoZZQV8aIBtnd1a+NoL2f1F6M7cqbaG4LLwdoMsTwo0Kvjo0eoQ6v1fvp2kUba4xJoWJSvzr9tfHb74rMek/gSzX1jWj6Xb1siM7bqWigHeQpodM1ciP7IGqDJIXjVwoqotiI0e1TYHeRgmevuStZ7T+B7FcgfTmYNqztrmdGEJ5nORWCVfmaAqIQR7+h+4dOZqq9Xs66d4duUgFTnMDMY34fW8KKkevc41vEPa6dE6uHFV6FPrrooTJr1LpY3AV1FboBHUfpWbIQwx9ZZ7Ej8ZrNOTUPsPpY6pY9C6OkWKtRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKKIXMdTyRPJALPYri6c3qB8qO6iWPYhHjjPMznM+Z8=;
 b=cS+H3OcvPo4355Qt3Vn/OG91DaPzuhh6Fpbmh0LsD1h4HpxAp4wCIV8zzxkodU5CJQzxzm2zo/La0xvmC8iCTEYvP7uy8ZAMWAb+6qfIZUNt5vkyOhc0OrWlZExIE1pN/iMtFEsnPjY9lVIFP3U7uHpI6PCT/YPEGgvdd3L3Ga0=
Authentication-Results: loongson.cn; dkim=none (message not signed)
 header.d=none;loongson.cn; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 14 May
 2021 07:18:34 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 07:18:34 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix GPU TLB update error when PAGE_SIZE >
 AMDGPU_PAGE_SIZE
To: Huacai Chen <chenhuacai@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>
References: <20210514064039.1300558-1-chenhuacai@loongson.cn>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b555643f-8369-2eb5-fbea-89e6e9f01435@amd.com>
Date: Fri, 14 May 2021 09:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210514064039.1300558-1-chenhuacai@loongson.cn>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:cf70:a0fd:8c48:efd4]
X-ClientProxiedBy: PR0P264CA0138.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:cf70:a0fd:8c48:efd4]
 (2a02:908:1252:fb60:cf70:a0fd:8c48:efd4) by
 PR0P264CA0138.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 07:18:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6392e037-8db6-4dd5-e373-08d916a87c0a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25785829876340508C3316A883509@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOoCWlkUxBRWn4wSxtIZuyJfSB503/Ilff1tv3neQY0eq74ld6PdkBf2aqsSSKo68SNc7zkJWcGeaN+a++GmpMt0ke/AVXfWaXm9m/VznegW2wGWQUfHkVQlZUS8H7UVM7vHLnuCxV9UtDcmh6BCJSw5ss4AJGWsrvr6Rrh3pTtSgbgKA66gTOtiVrvSMtWftrlEEJ4xqfGvhHjVYwsGVjtB8DnEIvO0R81PKG4Hsj4tIQTW3ShDQNxxy8jInPFqpCPQOQe13Ck9GU7zHVRm9k+BgUN+KCET3wyWjiOWpO7AQ9ruymhKmQMNAe+yPPGJL+buNK9yQwcW5ifo1TXvgoX8sHeCUw42UMD7uk7YR1kcYWwGbyhVP4iWPX0UPOeiP0Fk+8c03hg6rc8hD7cFbsCl3xtjDIW2SyHn+56ydPzEL5YUiL/D7uJee8FWTDNm5MiMkgwEIt6odeHpPfMuuO/JStE0mDpCGKlSGvUS3mtjiMGn2KeshV+5i45KC4/Oj+ghCFqpYoiSznkMbhlWhYbPFZMzhy2FkJ/Yh/EDBEtqSB5epFB3ODV8m29GxdvWqDhJXkTI0EYWbVQ3d0dxDCsxnGwltkfkPQYOCZX1uzyiSMJ7p7unXmiNI27K0RK7VrHf60JywlKOEX+cUyUv0y0dx44P3n0YxC0KUKBm0Iaz+kGfJAKflXJ5PcZNLXrX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(478600001)(15650500001)(2906002)(6486002)(8676002)(16526019)(186003)(8936002)(6666004)(2616005)(31686004)(110136005)(316002)(5660300002)(66946007)(86362001)(31696002)(66574015)(66556008)(83380400001)(66476007)(36756003)(4326008)(38100700002)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UEZOZXFqMHNRZ2s2UDFuZytqL2dSYVVIVFc5YVI4WDFLUUZsMWJPcVA1dHF0?=
 =?utf-8?B?VVkzbGx6NzNBNHA5UGx2eEQwTnB6Qk5IL2orVGtHelViZkpYN2hQSzNEc3pq?=
 =?utf-8?B?QUN5YngzUWYwcXRtM04rMVFQYS9XVERFeWFaMzIydWgweWFNRjNiWGNxK1NT?=
 =?utf-8?B?OXBFWEJqczFqTG1zVVhNcURkLzhhZXJPQXRXQ1k0NjBiWHFRNytBZHc3Q1dD?=
 =?utf-8?B?VGhEa1V2NEc2MnlKN2NZNi93My9JVm9BWHhxTklyM0dsQ0V5dnV5LzRFb3pi?=
 =?utf-8?B?bUt5WnJBNWFRMW1wa1A5OGd0eUhjU0w1cHE0MjlzZWpwMmtVTE5xVFlEajVu?=
 =?utf-8?B?QktmaklNdmtEa2JYQ2MzWjk1ZGFncG41NUtHdjEwMnJaYjJZaFRETUtUK1lH?=
 =?utf-8?B?anJiSUpubUJybkpNZ0xaMWJTeFlFVXFyR1lydDVXVnp2Vkg3WTQyYUpyUFNZ?=
 =?utf-8?B?UlRidlhReE11N05kSEVjbzgzQ1hQYjRxRldBb3ZPU1R4b3lxbTZMZWw5RzJp?=
 =?utf-8?B?cWZldW01YmhVVzFKbjNwWnJJbFlOZFZLRXZwYU5hdVJIRS91cjREMDFwK0NM?=
 =?utf-8?B?TlZNV0xLZ1gyVTNGalo0WTJKSzBBV0FGVk9aSnY3SW10dHVJYnAxKzFobEVH?=
 =?utf-8?B?czZ2MkRmNWNFbmM5SFNMWU5xcXNZRjR4ZTdZODVSRjVMdnZqUEd3WG9rSHFv?=
 =?utf-8?B?WXkyTFplRTVLNlZINnVvUEE0V2VUU0N4UmxrT3o3ZGVqVGRiUTBveVRwcDNH?=
 =?utf-8?B?bm1MblhxMC9UMnowN3pXSEkzdWVwZFRHWEExN0JBdnVNTWRJd2c4VkFuTkdY?=
 =?utf-8?B?YllRR2o5a1pMVlR6cE82a2xvL3FBQWdFdHNYUXFtL0VrS3BhTzZEN3l4blNZ?=
 =?utf-8?B?dzFtYVVJNGcwNi91LzZTMTcwdHdVRGpDajlYVkM5Qnl0a1FWL2xtOTYyekkz?=
 =?utf-8?B?b3lORCswSXZnMU9FNTFYQzU3S2VETCtCOU1kZnh3Lzhhenp0bmcrKzFHNEdr?=
 =?utf-8?B?WDFGTm5QT3JUR1pDRVRMT0RFUzNKNGhZT3lYTkVuekpYTkFmek1sM1Iyamxv?=
 =?utf-8?B?TUxZVFBVR1NrSWR4ekgrR0lrQ3BCdWJibm8rTDVIaHdGRjU5cEFBMFJ0OEZs?=
 =?utf-8?B?clhDY1ZyVCs2VzYySy9HK0E4cmZpVSs4RUNlMDRLdVNQNzJzdTFqdlBVYU96?=
 =?utf-8?B?NW5RWElubEdsa3dManRubUREcjdnQXVtQ2ZSZGhrZ2x1VjgzRDl0ZEtRVUxp?=
 =?utf-8?B?UFczS29hTkJITldkUG9qRzlJVFVmQ25hbVNLb3dzbnNnRHpJdGszM1duVmRE?=
 =?utf-8?B?c2VWMG9BNDhrTHNiNkNMOTNyamNBRm9MYVNMR2c5TU9HVlVXYVhiTnJHcUFx?=
 =?utf-8?B?Q01RcG5DS0VqYVZ1aHRaMk56emFZRE1xODcrcUdVdFd6S1NKdmo1QTZPY1Vk?=
 =?utf-8?B?dnRCN3hBa1ZxT0N1Qng1RjZBOU5UMEpIMDhUWmRUWmVQLy9QN0lqcmJFQzRw?=
 =?utf-8?B?amZYOTFpVWRhZVhIMG4rOTlqd3JlZlVYWCsrbU5wSWtkYlNZRjY2UUwrUlpo?=
 =?utf-8?B?aFpSWmx5NVhtazhMMDJvUGd0UGg4L1RCc0paNmNmVG8vWUdsbVNncHZuODZD?=
 =?utf-8?B?YzMvSUlTMEZhc0dnaTBKQW9UTnlkRGpOaTdZSTBzeCs1N0JpRnBidDQ3aDZO?=
 =?utf-8?B?MHRvRnFsYnpSZ3NNMGIvZGh2SEZHWGROMklGbFAvWHdRUlgwVjZWWHRKZE9J?=
 =?utf-8?B?Zjdvdy9WV09ndnZZdGZyTlRKcFRMTWFkNFJQVTBQYVAvcGt0bnY3U2Z4NnVL?=
 =?utf-8?B?Z3BCZ3hnMlgyd1JaVUYzWDhYdEMzNWloK0kwZ21Da2EzcFhlbUdWMlBhNDQx?=
 =?utf-8?Q?zE+K0qLRDC9P3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6392e037-8db6-4dd5-e373-08d916a87c0a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:18:34.1840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpXcNA2UetKU+oFI5rcFHt3v1ltBrXLc5subGyOEismhkeCWmdMNcSDZj9EQBYTh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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
Cc: Yi Li <liyi@loongson.cn>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDUuMjEgdW0gMDg6NDAgc2NocmllYiBIdWFjYWkgQ2hlbjoKPiBGcm9tOiBZaSBMaSA8
bGl5aUBsb29uZ3Nvbi5jbj4KPgo+IFdoZW4gUEFHRV9TSVpFIGlzIGxhcmdlciB0aGFuIEFNREdQ
VV9QQUdFX1NJWkUsIHRoZSBudW1iZXIgb2YgR1BVIFRMQgo+IGVudHJpZXMgd2hpY2ggbmVlZCB0
byB1cGRhdGUgaW4gYW1kZ3B1X21hcF9idWZmZXIoKSBzaG91bGQgYmUgbXVsdGlwbGllZAo+IGJ5
IEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0UgKFBBR0VfU0laRSAvIEFNREdQVV9QQUdFX1NJ
WkUpLgo+Cj4gU2lnbmVkLW9mZi1ieTogWWkgTGkgPGxpeWlAbG9vbmdzb24uY24+Cj4gU2lnbmVk
LW9mZi1ieTogSHVhY2FpIENoZW4gPGNoZW5odWFjYWlAbG9vbmdzb24uY24+CgpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDIgKy0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IDNiZWYwNDMyY2FjMi4uYTM3NmE5OTNl
NDc0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IEBAIC0y
MjUsNyArMjI1LDcgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX21hcF9idWZmZXIoc3RydWN0IHR0
bV9idWZmZXJfb2JqZWN0ICpibywKPiAgIAkqYWRkciArPSBtbV9jdXItPnN0YXJ0ICYgflBBR0Vf
TUFTSzsKPiAgIAo+ICAgCW51bV9kdyA9IEFMSUdOKGFkZXYtPm1tYW4uYnVmZmVyX2Z1bmNzLT5j
b3B5X251bV9kdywgOCk7Cj4gLQludW1fYnl0ZXMgPSBudW1fcGFnZXMgKiA4Owo+ICsJbnVtX2J5
dGVzID0gbnVtX3BhZ2VzICogOCAqIEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7Cj4gICAK
PiAgIAlyID0gYW1kZ3B1X2pvYl9hbGxvY193aXRoX2liKGFkZXYsIG51bV9kdyAqIDQgKyBudW1f
Ynl0ZXMsCj4gICAJCQkJICAgICBBTURHUFVfSUJfUE9PTF9ERUxBWUVELCAmam9iKTsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
