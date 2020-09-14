Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ED3C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 06:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4449420770
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 06:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EUVS8GSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4449420770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5E189FE8;
	Mon, 14 Sep 2020 06:48:33 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750052.outbound.protection.outlook.com [40.107.75.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBDB89FE8
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 06:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7bY9oL2vtB48WmMwYKGI5SZRm5m1D7dxJ+yZ+eE4p+FgnDRi0ynPFT+QOVmx84t3t9+3+LUcYTRz2RP6HX6I+B8GNkP83iW0+QDBw21K20VdllepIuruvBTmkFLRVU5nJXjkJXS9fcJ2omMnNtwICpeItUIrbACEmPRF3MeKEWxLuXKGknUi9dSauer6rGqyhxiL/vGIEj9uHecYryJwVnoiatb7akhycvhxfzDTUHl/1vfNM1PT9PYwr3MoyKfQgZuwZWza3yax3KwR20gko0+Qt9T96kkmfuO566NNJyVVRZSlJ0vL1SdLUMjVK0TIqwU5KEaWU7LRLmPgKTexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN/ZyPzKLqSG7QpJPd0Db4F9373qTMQEmcppDeB4w3g=;
 b=Tpn/bdjF6qzh26+wY8ntQo12LelFvGbIUmxciixw1sL1b5GDN2yGvEkO0W2ygMLV3gMU+Q1DFdpyca9dBz/46w/DNcljT5Zu274x1DP0vWE+7weboGHlu+iVC0Sf7earJFReGPyYEd7VaKvTDr2xlV76gLuYukbY6h0w86OLRS+A49xUjz2OlywVVs1SmbbInuiqtX525YLQgbk7xhREHC9VAWSyBiMylry4K3dLZvuwF4SniKGb2l8w185kZ4CgOe/kpExkiHW4/c8joVpAocO9aGj3YTJAwANg2GKOhAGOONZ3yS8pavfRSGOz9Yd1GKlJIQbh8CwnrhAPWIykuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN/ZyPzKLqSG7QpJPd0Db4F9373qTMQEmcppDeB4w3g=;
 b=EUVS8GSmhk7utvpwCcATKjnaUGMNFCdLhdth9GnWYysV15T6hLrDITuFV9nKHHHe60hUcd1jm0z+hGHP++MFd/MXe5Dj+jmyZs6VW3+DfcxQsyRzMGUu4Un+PANqmMtF+pUPhP4DL+mX6oKWni3VwNTPoiPRmz9cdCCmTbRCGpM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 06:48:29 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 06:48:29 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Add comment to function
 amdgpu_ttm_alloc_gart
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1599848732-15764-1-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a22e01a1-302d-f469-569c-0bb97647c48a@amd.com>
Date: Mon, 14 Sep 2020 08:48:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1599848732-15764-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0112.eurprd05.prod.outlook.com
 (2603:10a6:207:2::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0112.eurprd05.prod.outlook.com (2603:10a6:207:2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.19 via Frontend Transport; Mon, 14 Sep 2020 06:48:28 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 388de3cb-01ec-4774-0fd3-08d8587a2fe7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB454912CDA2AE811D50B497DA83230@MN2PR12MB4549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7fnVb3DlUdDt6JgxNTCUMZA5jMhWlEf/G0TeTsCmQKS4JvdTavYzwA9g3ukye01OW9osHcs+T/fqeGc4TgVM6sVuDpbCLmpaI/r+NXFugiHPdq4gbPVyWIEKfbirkya9hW8V4W9HVx3AgBIxAXfBfGsWF4aK5mmd/AnizUeZEblDfcwCQFZ0sxCB+wR+n+G+FsOI6C8DAcgJqsbjVsGFx+fsOiwIa4MA05lKA2KnDRvYVJh4/NZt5TePpkHWjmp8gfqnOOTgIxE262RF8/2QQkMOvfZAk9akYEesxxhx1BIr6BbiYg6g5dQXmGPssGcQlFUKvWkvxm/P+l0utH6pF1wKFYYyTMWWJufr43yZwvXWJ8mLGtw0PtOEOeE8P2K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(66476007)(478600001)(66556008)(31696002)(16526019)(66946007)(66574015)(31686004)(2616005)(6666004)(5660300002)(186003)(8676002)(83380400001)(8936002)(86362001)(36756003)(2906002)(52116002)(316002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8h/Zb3CE0j4Cn3V9BDY3aaVNkYqWV1rAGguRZbfxwRNOfW4gpYHYvFrXY6nk1M1Q9jo2ndpGbrs4rhBPNFBia1DGFUGjNFeaA9Ro5SkUEoppHwQouvTinxbHU1cU2o2iEivzaHo08cUQw34YWdyegDBqdqup3BpJ3nbQiQW7bA6AIj58HPoCgCG1qTjySJKtiO1gCUpHfUnoX4z8Wi4x+RaDTJ+EiV+Qn5B7qyK9r90TUZP+DCTu19qrgEg3MO9/6BHJievwN0snhK7Xr29w2lThfyBW3OAdEYdXf9lJ6kokQfSf9VOvT047/jdrIg4+rwA45kZc8kaScUZV0MXhNJAHCBIkL35MXtw1mXQNonyQSBNiVGWDsJNxxkb9WveOZ9lrNNJtWD0VBdPLCIUzqcW6/RZW1uQdLXZu7UaHtgdtZQzMC3z9ZrDRO/SVhMIQ8llKYPy6h7ZEpDk68ptkQy9Tx0wmPV96/lMoHEMb0u6JA4lg014J1sNyED9H3ULhs8h9cELRHoV0rEmK+lS+pggVixocACUlZjK1PoBbnk3lsFH8TI7spZPC+FwMwjEK3jtiNLffIBbh6S1KM8/MFk57Wwv9EgMXsa2lxTBH7ePMLM7hT8iZvcAMD0I2lsrQ7rM6YA4mOIm5OzSEKN6DjUyZMX7K5/VRP5AUe9QwWS2JJvMszPYSDPkAuY1w+lmflvOTrDIvolTMUUEKhMuwxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388de3cb-01ec-4774-0fd3-08d8587a2fe7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 06:48:28.9649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j04wPCKmhtA9XfurmcJ5Pxk+p/Ndz4PEFzPuGxqGwkIHnK50XJY6vLI7qw43z60x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4g
Zm9yIHRoZSBzZXJpZXMuCgpBbSAxMS4wOS4yMCB1bSAyMDoyNSBzY2hyaWViIE9hayBaZW5nOgo+
IEFkZCBjb21tZW50cyB0byByZWZlY3Qgd2hhdCBmdW5jdGlvbiBkb2VzCj4KPiBTaWduZWQtb2Zm
LWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDcgKysrKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IDYzZTU0MTQuLjhiNzA0NDUgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAgLTEyMTAsNyArMTIxMCwxMiBAQCBz
dGF0aWMgaW50IGFtZGdwdV90dG1fYmFja2VuZF9iaW5kKHN0cnVjdCB0dG1fdHQgKnR0bSwKPiAg
IH0KPiAgIAo+ICAgLyoqCj4gLSAqIGFtZGdwdV90dG1fYWxsb2NfZ2FydCAtIEFsbG9jYXRlIEdB
UlQgbWVtb3J5IGZvciBidWZmZXIgb2JqZWN0Cj4gKyAqIGFtZGdwdV90dG1fYWxsb2NfZ2FydCAt
IE1ha2Ugc3VyZSBidWZmZXIgb2JqZWN0IGlzIGFjY2Vzc2libGUgZWl0aGVyCj4gKyAqIHRocm91
Z2ggQUdQIG9yIEdBUlQgYXBlcnR1cmUuCj4gKyAqCj4gKyAqIElmIGJvIGlzIGFjY2Vzc2libGUg
dGhyb3VnaCBBR1AgYXBlcnR1cmUsIHRoZW4gdXNlIEFHUCBhcGVydHVyZQo+ICsgKiB0byBhY2Nl
c3MgYm87IG90aGVyd2lzZSBhbGxvY2F0ZSBsb2dpY2FsIHNwYWNlIGluIEdBUlQgYXBlcnR1cmUK
PiArICogYW5kIG1hcCBibyB0byBHQVJUIGFwZXJ0dXJlLgo+ICAgICovCj4gICBpbnQgYW1kZ3B1
X3R0bV9hbGxvY19nYXJ0KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4gICB7CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
