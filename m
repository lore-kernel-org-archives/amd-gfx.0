Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E0CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 16:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F51F2225E
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 16:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F51F2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4940A6E3BB;
	Mon, 18 Jan 2021 16:16:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8E56E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 16:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMDvEZKp2D4jZK99QXRnW/Mi9jQQwP8o2K2n0X+BzgnozoZl4kA3xK0wLUzaNIMY3/AoWJAbln4z8V0NOOdOZsJqE7zKCog7yGkX+FabtCiQ9/i0wACdzge/DM5jNomzSp3Ao7k+EDW5dz6f64jZL17U8E5A4/ewwu285fHVdL2PXAlhRHhSopyuf+PIX+DK/YsIOE47G0mO0bMPa+cjFePKjHT0AY1ap8NIgYZRPmeaNh1RtbUjndr3kurO3TSg1XKb5iRqSKMVNBSx0D3SGV7Tm4xMaYKY84HfNiuuy9bCFF7A+SE/fQOnqb202rfCvgQTuU+9pC/pZQ87DZXiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fHO232SdMxBtbuYAdbXQvmzlu+15QzkmqLFkXdyuuU=;
 b=eo/HiFZjHq4NJuVNOg0GAfE+K8F5tyfRyGa0BoSmEwiH6+2wDB+URhvM5bMhNzRWPshxvdP9EMVfQFdGZ1foqa5jnQjgemXYaeZF6Ux8yKqwS37luuIhEGmmJNixENVNkjw90BUQr5vfumApVFXSw3vCH9k73ictsvjQXicX6+QkKbQG73EhBqENzdvCVtQZ4ufKTi7Znwbccs5fK0edm4fc7bA5qBiuHFkTq6UaoauFhXCtZ4hGxOU3PVy9cnNuE88FS0FMeMQoCoLuylvpeKP7ood5rldxT2TceGXjatlkCGwnFKGICIcJEwFME2Hv6lU+FgHYTEKAQRlfq89JLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fHO232SdMxBtbuYAdbXQvmzlu+15QzkmqLFkXdyuuU=;
 b=4pKhl9M46K9NQHsUMa9uAq8mPV/OLsYUZwpavBfjjCMztKeiSyDoYjyW0KKERtQb5byCtmP6a8OwwI0hH8ytCHanzfjz5ADZAm+NMlJmMoehQryAmfSZVYC4a1CxqhDsKl9Q/3Xdojy6qtrZBZn1W3XrlvJ4JoifjQDj/RONuNE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4657.namprd12.prod.outlook.com (2603:10b6:207:1a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 16:16:23 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 16:16:23 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20210115182423.32368-1-Felix.Kuehling@amd.com>
 <cea118cc-b9d0-0052-bc4f-d40a2bdd07ce@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <20816994-73e9-202d-5f17-eac7e269a530@amd.com>
Date: Mon, 18 Jan 2021 11:16:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <cea118cc-b9d0-0052-bc4f-d40a2bdd07ce@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 16:16:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a1223c0-4d32-470e-564a-08d8bbcc6636
X-MS-TrafficTypeDiagnostic: BL0PR12MB4657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4657DF7799F234C51A54B85B92A40@BL0PR12MB4657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xx0moX3jxcldyI874QDQ0HTdwwx+hn5gSpxOPkcl//24b5g4XHid/sE83cydptLMBGyOXzH9vB4bAF8NTNv+npS+sFWPVmDPWm8sBkRbG8POPdFUSKLVOjhBFpixjd6ZmEmmiaZnpA2trkRPZc3yHTgRT1fNKEdcPQ4Zw9HGKA/dRuwoL73yUlClcBUCVsloz1FSUb95FXwSMp32royj+64UknIIYq/gM7iWAxLY+fuX8leBL5wjE0+4F8XjR1AvvYboAG9G1xrfKFUeDD/88tDG9KA+qhknv9x60V8S7h5o/rqBnrBW0QUpTPJ7Ct7UL0goxYs5C9JEy/u15V9X5mXJudEmx+5fo/RyL4mOi/Y5keArs50Rhapci6hhs7LosLIFCkwtIyMfIxAzZ6n1dZfZyLN+u33J5X8vH5SvmlQN4Uas20hj/K9NXTo02F68uj9+jo+Bytwu/Ed/kWUFBAPWJeSVKE3t/5DHQwBEgRXtO167XlVeHkbSH/qooSNw9+OfrnrOZJ5/q7exKaOMc8oH/ZVFp9Gsh7y3/isWjH8bKeorsep8mS05I0FBlTcqs8feYlxI86UuvyB1xqKmsw5qHTTKtr8XuwZyzF5+Xis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(31696002)(36756003)(86362001)(16576012)(44832011)(52116002)(316002)(956004)(8676002)(2616005)(2906002)(5660300002)(66476007)(8936002)(66556008)(478600001)(31686004)(66946007)(66574015)(6486002)(26005)(16526019)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UnhHaklkaUplMWUzL0xCZUsrdkUyWEVKbDhqTjJZK2x2ajdDeUs0QjI0T3k3?=
 =?utf-8?B?U3E5VWgxM0JJckxpSWEzY2x0MUNpSHY3dGsrQjRXZDNkL2xrakx5Y05NNDJN?=
 =?utf-8?B?ZFptcklJZzZja2tNb3hEWU94SEQ1cStYVndIZWc5MzQzenI0aWhGWW9IemNU?=
 =?utf-8?B?RlE2a3h6MlJlNnBNWTdHKzVrYXVFdno0d2lnV0dwSFBGdUo2MGRHdjV0TGxV?=
 =?utf-8?B?ZHlMVVAzenNsOE5xWkNLVmpQWElJWDZPbkNvUloxaitjaml5MHRiOTgrdDhq?=
 =?utf-8?B?K3RuUnJMcHdrMks4UFVrWjNuOHo5ZSs1RjV0TFBoLzlPd2k0NEk3VlRvR080?=
 =?utf-8?B?b3cxNVJvaGRmSUJrbExpNnlYUU1uZmlBTCtpMyt1UG9JWlJaMWlxdjA1OHRV?=
 =?utf-8?B?YVNSeTF6ZmowZFo2MGYvQkRTaG01UGJrWXJuaExoaXBhNko1UlIwVHdFdXBL?=
 =?utf-8?B?SFNKU2g1MmhIQnVKdnQrbGhtbWZQaXVqcGtEc0xYOWFVNE04NkxNOGRUTmhT?=
 =?utf-8?B?QUlJSDJmdzB4aUNIQXVIbzRJMHNqMmx2ZlNJZlJBSFNNQTFjRnNJR3M4S2l1?=
 =?utf-8?B?bVI4TjBBWlBRSm9qWUJmNnJ0T2tYRzdaS3RaVlFFWDJ3ZE9NSVdpRUFWS2sr?=
 =?utf-8?B?RlQ5WmtWUGkwM2xXVGNWeXRLdTdodEVWKzFBWUV0ZGpaR1AwU3JYQlBDek1o?=
 =?utf-8?B?ME5GaFFtZkYxckZQR3NWY1pLelhVdDk0eHlyL0NEYmswOUtyNTFRY0lYQmw4?=
 =?utf-8?B?Nyt4Rys2Y3JRVmtFRXREZDByak1PUkl3VHI0V3JSMkRWRXh5ZWV6c25tNStM?=
 =?utf-8?B?d3hScHk0NXhZMEFhbXBtb1Vhd3craXFQOW9leCtiNDIxL1V2YmpFTmE0NGZE?=
 =?utf-8?B?blFwYlIyL0tMdWY3QjBQNU5YaXhBcTdCSG82dWd1akdUTkt3S3pwNG40aUNi?=
 =?utf-8?B?OVU0SlIwSkZDNmcyYldhYTFDN0xzam1sRXFtRmw4RDBNYVpkelhwbEErK1Jw?=
 =?utf-8?B?WVYydHBEL0xRN2ZnNDRIdEUxNGxwN1hXK2wwOU9uQmVQVmo5U0tZZkFCODhp?=
 =?utf-8?B?QThpU2JTbktUY0E4QWl6T2VJc0dua2dtNmlleVB3dHhTSUJuTmcva1NDRWNy?=
 =?utf-8?B?UzJBZGdERjhsVU5oTnpvSGhIazdZZ1JvUzhGejEvZ0xtdFZoYWlaVXVrc05q?=
 =?utf-8?B?ZXVJWkYrM2FDM0FhbDFBSWtFcnVUam40QnUvbjdabUxna0srajYwQ0NjKzk2?=
 =?utf-8?B?WVljZDE2V0dMbHdqTk1kc0xsOVVheHhmT1NQK2w1bW1mS0Zvc0ZDSzBCbVJD?=
 =?utf-8?Q?Vqu9myXdGZITCf3LFvvbss2djTFe2ISWtX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1223c0-4d32-470e-564a-08d8bbcc6636
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 16:16:23.8332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3ZAX5fwQgqIBa4bL1wZ1jMjhcgq+W8mA1ZGRpXs9Iedpar0CyHwxJHfnboOXYfZrHB774LCPtJQYFBUno4ytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4657
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

QW0gMjAyMS0wMS0xOCB1bSAxMDowNCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBB
bSAxNS4wMS4yMSB1bSAxOToyNCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBST0NtIHVzZXIg
bW9kZSBkZXBlbmRzIG9uIHVzZXJwdHIgc3VwcG9ydC4gV2l0aG91dCBpdCwgS0ZEIGlzIGJhc2lj
YWxseQo+PiB1c2VsZXNzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpUaGFuayB5b3UuIEZvciB0aGUgcmVjb3JkLCB0aGUg
ZG9jdW1lbnRhdGlvbiByZWNvbW1lbmRzIHNvbWUgcHJlY2F1dGlvbnMKd2hlbiB1c2luZyAic2Vs
ZWN0IiB0byBhdm9pZCBpbnZhbGlkIGNvbmZpZ3VyYXRpb25zOgoKPiDCoMKgwqDCoMKgwqDCoCBC
eSBhYnVzaW5nIHNlbGVjdCB5b3UgYXJlIGFibGUgdG8gc2VsZWN0IGEgc3ltYm9sIEZPTyBldmVu
Cj4gwqDCoMKgwqDCoMKgwqAgaWYgRk9PIGRlcGVuZHMgb24gQkFSIHRoYXQgaXMgbm90IHNldC4K
PiDCoMKgwqDCoMKgwqDCoCBJbiBnZW5lcmFsIHVzZSBzZWxlY3Qgb25seSBmb3Igbm9uLXZpc2li
bGUgc3ltYm9scwo+IMKgwqDCoMKgwqDCoMKgIChubyBwcm9tcHRzIGFueXdoZXJlKSBhbmQgZm9y
IHN5bWJvbHMgd2l0aCBubyBkZXBlbmRlbmNpZXMuCj4gwqDCoMKgwqDCoMKgwqAgVGhhdCB3aWxs
IGxpbWl0IHRoZSB1c2VmdWxuZXNzIGJ1dCBvbiB0aGUgb3RoZXIgaGFuZCBhdm9pZAo+IMKgwqDC
oMKgwqDCoMKgIHRoZSBpbGxlZ2FsIGNvbmZpZ3VyYXRpb25zIGFsbCBvdmVyLgpJbiB0aGlzIGNh
c2UgSSB0aGluayB3ZSdyZSBmaW5lIGJlY2F1c2UgS0ZEIGFscmVhZHkgc2VsZWN0cwpNTVVfTk9U
SUZJRVIuIFRvIGJlIHNhZmUsIEtGRCBzaG91bGQgYWxzbyBzZWxlY3QgSE1NX01JUlJPUiBleHBs
aWNpdGx5LgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9LY29uZmlnIHwgMSArCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2Nv
bmZpZwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPj4gaW5kZXggZThm
YjEwYzQxZjE2Li4yODAwYjJiYjI1MjIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL0tjb25maWcKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2Nv
bmZpZwo+PiBAQCAtOCw1ICs4LDYgQEAgY29uZmlnIEhTQV9BTUQKPj4gwqDCoMKgwqDCoCBkZXBl
bmRzIG9uIERSTV9BTURHUFUgJiYgKFg4Nl82NCB8fCBBUk02NCB8fCBQUEM2NCkKPj4gwqDCoMKg
wqDCoCBpbXBseSBBTURfSU9NTVVfVjIgaWYgWDg2XzY0Cj4+IMKgwqDCoMKgwqAgc2VsZWN0IE1N
VV9OT1RJRklFUgo+PiArwqDCoMKgIHNlbGVjdCBEUk1fQU1ER1BVX1VTRVJQVFIKPj4gwqDCoMKg
wqDCoCBoZWxwCj4+IMKgwqDCoMKgwqDCoMKgIEVuYWJsZSB0aGlzIGlmIHlvdSB3YW50IHRvIHVz
ZSBIU0EgZmVhdHVyZXMgb24gQU1EIEdQVSBkZXZpY2VzLgo+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
