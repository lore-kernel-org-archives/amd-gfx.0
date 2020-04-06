Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D7AC2BA18
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 06:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7CC2064A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 06:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vd5SwWN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7CC2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411186E2B0;
	Mon,  6 Apr 2020 06:54:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8947C6E2AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 06:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbwcGMy9hMMdOTEoQWv43ccBpIgel0azBjCCtCUtLxH8y0e2ULjQw2oq25hSEvNX2Jr7tJUrsSoCFwZmV8CkiPE9GTeYEq3D2EE9gh0Ot3Yt/ars+f9Hi+jL6PvJ9rgiKaBdUHnydwDWxFX6dDW/ddvJhmYvaVp/JRQ/7LVeaNU+X7RlOjUFPTPeNsIhrWOsOglsO/InoA9o4a7HgbATjqk899khg8U/9RA/dG0vuZtpojbAX63UF88W/D6x4t+3XMdnAxtsE/yKxPBA9bmP3OKuRUwoXBfS1YeYso7sThLCqM1M/F8lmWAkhKQIsOWhCT/ze/weye9k274jTBUTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsdFbYoa4F3I8Ynto7N8iNI00DKdkKSwLRclqLqnDYg=;
 b=ha6v6t5jfH120K28YQ7W8sJZkA/n+dWPl2jdC4SrHGN5ssnI7CWhxZ1m+cCCKJzsdfVUajz0wKKvOewsR4ypPdCOsH6nlNNavTJWz7zk7BoyzvHzVRInNBcma0ojefsgIYXlAhlk3SfE3gsl4VgkOA2O6fLVZwHE5wD/zobIQvK2qe70K8Wumsx+sFfKGee1d1FouaprV4K6fRNlfd6bRXR4HYyUtuZByi4Q/xqpVgEOEzE7XAWNKMxuK8430vGURP/NdnBWdXa3flo35a2a1lc2W/r9UX9Oyd7ZAN8VLeorqIViOp+Pjs9Rz0pQbOyNPf2b9+vtQcPau8RalnGB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsdFbYoa4F3I8Ynto7N8iNI00DKdkKSwLRclqLqnDYg=;
 b=Vd5SwWN6Mb9EBFPRmh7rHuBGGohikwU80kvoNG+7s7eKMjd26O2kl1skz3bCNCOTLTo73sJkODqME8BlsKcZpSnzEQBtZY2IeMn/tk1f/y/lHk+5M+YESKcsYxoRl2tw1i2bBn7g7S50jNdP+AOryKVjFuSX4kdhpuLnX8x49hE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Mon, 6 Apr
 2020 06:54:25 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 06:54:25 +0000
Subject: Re: [PATCH] PCI/P2PDMA: Add additional AMD ZEN root ports to the
 whitelist
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200403193859.81971-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <006fa415-b28d-475c-edad-abdbffc2e317@amd.com>
Date: Mon, 6 Apr 2020 08:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200403193859.81971-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::18) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 06:54:24 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1011b738-ff94-4704-7c12-08d7d9f757d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:|DM6PR12MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3068F21EF8D1B7757E01F17983C20@DM6PR12MB3068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(2616005)(66556008)(66476007)(4744005)(6486002)(66946007)(31686004)(52116002)(2906002)(6666004)(5660300002)(8936002)(478600001)(36756003)(31696002)(86362001)(81166006)(4326008)(81156014)(316002)(16526019)(8676002)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNemZuqwk0js00Vubg184G+lkqwNrqTvR5tZvUHvHACQoVVpqDYup/vXTU+60Rl1/8jzxTOPJgp8atoqzuuWMTS6Qoyw2DVYtUv9lYTblb0EsWtIB/Zc9AElxro3+fNmKUtIJgxI0zQ7romG3R5xpcAKp2WGZn92jXnfyEOozQfOlBC7YmlpSTjcsmCommbmadNssJCg4WpcNuJMAHDKgbp1FMYzp8W1dJhX/aE0JBhdS0GPXrqW28Qf6sMm2DSSNkhwGD4D8UaXcIwrppPS4RgwXOi3Ep0wuqQhogWE5piCyzjVGOr/jZJy444u2B+CaXe9VZ+zmm2LT5QCs3CiczdtAD7f62J2a3TQb9ZPhbftXAFHuLTVY1zWvcZhuOoYOtklUNjvxuoiIEeExaRFx/1pGv6wFpbDSh/ws/T0VfYUcVHalydSPObjKzF9D5yM
X-MS-Exchange-AntiSpam-MessageData: 9SalzpOchsMyMWyFW1RWEJ89qgZDZ9Ssuhr9NPoLnAzwsFzAsi6MGzmcujMz7XbUe88o8L5WXr/v2+T+VGQVTVp00EOGNqag5SA4p3YRpETaseFK225nmyhVWIrQoY5b54wqLHwLJV0EA1jZeleIF5hPNOJbqpOQycIRRoKiA1f5sXTAiZ1fjHJ/QqeK1s8+QnhsZYNMVgaNIVxbOvLG5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1011b738-ff94-4704-7c12-08d7d9f757d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 06:54:25.3666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eXxGwLfTzG4355Nlx7Ml9ncfVzSYR7a6UmmNpSgqAXPuOAHmPUivneNckAVzs0J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDQuMjAgdW0gMjE6Mzggc2NocmllYiBBbGV4IERldWNoZXI6Cj4gQWNjb3JkaW5nIHRv
IHRoZSBodyBhcmNoaXRlY3QsIHByZS1aRU4gcGFydHMgc3VwcG9ydAo+IHAycCB3cml0ZXMgYW5k
IFpFTiBwYXJ0cyBzdXBwb3J0IGJvdGggcDJwIHJlYWRzIGFuZCB3cml0ZXMuCj4KPiBBZGQgZW50
cmllcyBmb3IgWmVuIHBhcnRzIFJhdmVuICgweDE1ZDApIGFuZCBSZW5vaXIgKDB4MTYzMCkuCj4K
PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCkFja2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+
ICAgZHJpdmVycy9wY2kvcDJwZG1hLmMgfCAyICsrCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcDJwZG1hLmMgYi9kcml2ZXJz
L3BjaS9wMnBkbWEuYwo+IGluZGV4IDlhOGEzODM4NDEyMS4uOTFhNGM5ODczOTlkIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvcGNpL3AycGRtYS5jCj4gKysrIGIvZHJpdmVycy9wY2kvcDJwZG1hLmMK
PiBAQCAtMjgyLDYgKzI4Miw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX3AycGRtYV93aGl0
ZWxpc3RfZW50cnkgewo+ICAgfSBwY2lfcDJwZG1hX3doaXRlbGlzdFtdID0gewo+ICAgCS8qIEFN
RCBaRU4gKi8KPiAgIAl7UENJX1ZFTkRPUl9JRF9BTUQsCTB4MTQ1MCwJMH0sCj4gKwl7UENJX1ZF
TkRPUl9JRF9BTUQsCTB4MTVkMCwJMH0sCj4gKwl7UENJX1ZFTkRPUl9JRF9BTUQsCTB4MTYzMCwJ
MH0sCj4gICAKPiAgIAkvKiBJbnRlbCBYZW9uIEU1L0NvcmUgaTcgKi8KPiAgIAl7UENJX1ZFTkRP
Ul9JRF9JTlRFTCwJMHgzYzAwLCBSRVFfU0FNRV9IT1NUX0JSSURHRX0sCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
