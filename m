Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EB2C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 19:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CAF60200
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 19:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CAF60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B81E89DE6;
	Mon, 12 Apr 2021 19:19:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3A989DE6
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 19:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeiiHiPterycGMpxOVisY07SwhLkcClGd8714qQEGw8UT3jC6PeyqjYrVzu83wu4h7CPO6ThIcHiFIQ2em14j+A73Qabxrfggnqe10zUvC/utcds6G4kZgKZFwbFmbyp17+IXsc8gdDcxS8wqRKONlEzwRwJ9c1bV/zYY7t4z47yfnynPYx5LB/+u5tRHYDWWOPj5cr95v9Q0Z6qTYiIqwnYxiLicZHWMKEpJdDR5r948IrObfxbJvYCdumyyCmz9KRjYeEF8WWQnPKvnA83mpnfM4dBrAZ6awj5a7FFO1/z8KtopSHZk+RLFbNu2o4rTIQaF32bF9mmKBfm0kd4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fWJX0FZyyql5SbbYpISideR+uZNFxv/BkMk8/D8tCs=;
 b=cdpS54IEhAhcP3Iu6lsflJh2tzuZ7rM/bUMJ2MPaq/ClJGTTdi7vDd9V1Y0Ei/u2wmzMGCT1lsLxedrFi3/yAkgtRkPBHV7Gh9Lh5WNozcg8pcWRnqAsXkU9/c8OlwdZ/qpfkLQWUEG7kThETODJ6l1dmorvTgYJY91m3XGZL4+5VRD7yWVTGn9I/mW1zy447A/zbiaew7Avmze1l3yEgpzySRJhJWTjie/qloCFadt6zuIL2dpu/rKTxqz0hAcUDumFu+AvNue8JG0Jjz8EN3YAlNl1wMuT72wKgt/awyS67hDHDYxw21dX6LCklbD+/UJ5/8eGqNarK/a+PuHf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fWJX0FZyyql5SbbYpISideR+uZNFxv/BkMk8/D8tCs=;
 b=MJnLNZBEZSH1Ia+YCJkAHr68lrN4+gbeiwSOYyssjGFoyaNQt4xidJekdOL86bc3cR5axCdgNUacJnMlBJvAqCPza33twBwZ+A34sI9bqdGjlw3JCwMTmvUpmtIzWmPj75OdeNNq+19KZ5K5VIUJ3rbpnB5yAdf5ftMMhGELYgg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 19:19:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 19:19:03 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
Date: Mon, 12 Apr 2021 21:18:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:69d5:bc93:d475:bcf3]
X-ClientProxiedBy: PR0P264CA0231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:69d5:bc93:d475:bcf3]
 (2a02:908:1252:fb60:69d5:bc93:d475:bcf3) by
 PR0P264CA0231.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 19:19:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 403741ab-5a88-487e-e680-08d8fde7d551
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4390DEED16C4E50EFACDF6B283709@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pbC4VyrAGgAmbl3keB4i0/PyvWdD7pgPkoj4DuzyhoEM9+99jc+HbTucy39CngMOvBgHoD3hp85XYrK25SaOQKpEOBtyzAZC8xiD+BLVh39mRsWtvYb15w0PuF5xe9AO/0mHnoCsJ0k49L1St2UMexe8YoUCo6UCBvmnslRU/47e93VpkIRPvYjRkAS6J1tYH0MnoauZ0lWmI7ttwRCh4uWOvCJosaXYK2DpmWyCOTBY9iW9JaG3Yf7stiazayPPT45Q3jRORC3ED6ybfoy1GDs/lDkNM7g8OmtGzdT33Kmvm1bf8yJQwo+M7ZMm38eJrWmLnnyKTxHCP+RcLSNtck+2rDvM6Nxzio3AfJUFudcDXiMj9Mm0oWmQ9/A9xXMpmXgIbwh8CPThuuEOlZUlYgihbveHYHL4Zb0wQ/8UT33JCqsr4A9q9hXOIAX/WRWLFGDsjUXrgSUgUBoLL7H5WfOQpV0M0N1wqS6Ior6GSw9tvAKqJvWHyapiCrDb9nDmJ6d8kZz1m1nlN+JDF9wAipHAzUz65kzCKhzxsBnmrv6UGBn0aihIpjUMBLIszS4HoEtB729Y/T08hzvqjib4UuVClkFkXo5RqRhIt/2YPfoKi89b/Ct9WLX7yqpww19el9Jkq1h0XN0HHO1Hw2zN7M4ZGWM6vz3kc6AFd8ZgiPTGrRWtGmz/79X6kz2bJsKxLCvXkk8C71zLnk0A9gG7i7VUp1NqCql1T7tXsW8e7gPHvYBIgasPrRgQZ5bpGUn+/wQ/RdxVtwmmB20K0jj6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(2906002)(6636002)(83380400001)(38100700002)(8676002)(66556008)(921005)(66476007)(66946007)(36756003)(86362001)(52116002)(6666004)(2616005)(31686004)(110136005)(31696002)(8936002)(45080400002)(316002)(478600001)(186003)(16526019)(966005)(5660300002)(6486002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UmY4cjJRZG4zRWpvQS9yeHBNa29Cd3FkMjVONk1RTzhoK3JXSmdyYzhmeUJy?=
 =?utf-8?B?UGV6dDRoNEdXUWlvcGxWOVpiMmh0RVFVYnVvemdqeXBQc1VtU1N4Nk9iNHNV?=
 =?utf-8?B?OXpyellGVXVIZVN5ZUg2d1k0Qk5mQ0k2U1hkSmdJTWtMekNiUFZXWTdkWXAw?=
 =?utf-8?B?L1Qzd3p5SERuMVd6d1pOY2N1QVZQcWRqdDJSbXo4aUNaLzFFejlDNnUxM25T?=
 =?utf-8?B?RzljY1pKNDFzcWY3eTk2RUJlc28xdnFFNkMyZTFMc1NEczRFbzI2VTBBVjJt?=
 =?utf-8?B?YlhpNllMZDdzN1BjUFhEWmtYUk93ck9DSG14cFo0QWZRVEFXWXFKY1hlNWJ2?=
 =?utf-8?B?UUR6NDVjdVNla2x3WjRGVEZGMkZyQ0M5b2tMcVJtMFlteDNKdE85dEFqcS8y?=
 =?utf-8?B?UkoxSVFvQjhmbnFQMHBPREdpQUFFT011RkoxTnJXemcwQXFqNlpCRFUzSW5H?=
 =?utf-8?B?UDB5Qk9ySEkzMHJFQ0xsLytKVWdqSHc1UE1xb2RvU2c4ZlFSTWpETHhSMXF6?=
 =?utf-8?B?MG9vdG1idFRiam9CS0ZPMWJEQkQ2QWVqRjA3WkF3NHAyNERMU3ZYWlVTZUtE?=
 =?utf-8?B?ckpSRFQ1OU9zK1RJV243bHNCTnRuYmJnbWdXa3FsVmI1dm05WlNHYW9QbU10?=
 =?utf-8?B?TzJSeDVrdGxnUmdOMWlpWUYwUk1CbzQxRVdJUzkrbU1WQ3lqc09PUGFWcmZz?=
 =?utf-8?B?c2kyVzFNakNJL1FQRGlxVG9BOVFTVDBiN2g0cE1CRjVFR1RQZnIxbm4zQVg3?=
 =?utf-8?B?Y3loTVNVM01xZ3ZITGNnRXZoY09nUEtSL0ljOGw4UHk2QTh1dC9OY0RtWFBD?=
 =?utf-8?B?Szh0UWdFd3BwRm45STVkVFpzMXBVOHVUeGtxMGw4NGZQeGxwQ3pzRm85ajFy?=
 =?utf-8?B?RW1TVUF5WmFUYnNiUzN4WUpMNk9nV28rb2RFdFRwTHgxbUJmUUVsRGxJTjFX?=
 =?utf-8?B?ays1NnMrTW4rUm5nUVp6MlVsbGMzYjBPVGRWcHVxZUlTSnoxV3d3T3FsbFpW?=
 =?utf-8?B?UFM0VlZOMkloN2tScEJYT3BVcE9DV01zVWJuMXlRdk5uMDNnY2cyYW5rUWV2?=
 =?utf-8?B?RU92UDZvUXJaSk1hVTJOaU0rV3duQ01zNUpCaWhja2wvcEcweUxPUXRmWTNW?=
 =?utf-8?B?eGtVVHJiWjhnbEtRRUVob3BuM2RWS0NYdXhqcHduWndrNUc0ZjNEeFd4M082?=
 =?utf-8?B?cHdHZU5SY0RMdXFJcDN0Y2NpQ2w1N25FV1BOblNUKzJBZXFYSlB5eEVTOG9M?=
 =?utf-8?B?ZjluRHlMdmJkNEE4dkszR1FXM2VuMnFuVWsweDI3ekxvY3Brd21rMjgrcTFu?=
 =?utf-8?B?NGttSUlCVFlnY1hxRkhHcTBLSzVpV3o5cWVTd0JNc1VpWU9IYldjZzE0Y1Ja?=
 =?utf-8?B?MDdJdzk0aGFnWlJkQXkrMm95VnJVVzVjclJ6NFQrMloySTV5MDlCWm9pcGFD?=
 =?utf-8?B?NDZSTDhJdHl2SDM3NjlUSTJXbUd4dnB2Zk5SbTJEL1pVZkFnVHo3YkNCWGdE?=
 =?utf-8?B?OTJwNmwxd1hVbmR4UkEzNWNKdFdMbWxKNlU2WmttalBuTWpESXZTWjJRdm40?=
 =?utf-8?B?ZVFVN1BIRjNiZHJBOWwrYzBKTldCSEhkZGQ1MXppSFY0ZWpMQ01BOGJ5amN3?=
 =?utf-8?B?cUlidEdPbksyajNwS3VjY0VmUmwvU2VyR3g3N1FGMEVVTDBlOUQwbGZJdTdT?=
 =?utf-8?B?ODFVVjZibWlqQXdMOTlZbnExeVRnNnZsWmxNempza0dmQTNSSDZJd2UxY1pE?=
 =?utf-8?B?OHQxbENOeUViZ010ZVRzeVMzdEdQY09OWTZkdTRDeWF0ZU9qQ1pJNExLR2hh?=
 =?utf-8?B?OVE1K1g0eFVWUmZGTTU2Q05Makcxc1lvbkwrbFliRmZSa3MwQ2c2VGNmOXFN?=
 =?utf-8?Q?rexcRTvN3zRZT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403741ab-5a88-487e-e680-08d8fde7d551
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 19:19:03.3151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWV5ZOLh7xgkHnGirAkW9R/aSfj+p6TE2ANR3RibDU9TTr1INCtDv3Uh2aI/KAQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

QW0gMTIuMDQuMjEgdW0gMjE6MTIgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBbU05JUF0K
Pj4+Cj4+PiBTbyB3aGF0J3MgdGhlIHJpZ2h0IGFwcHJvYWNoID8gSG93IHdlIGd1YXJhbnRlZSB0
aGF0IHdoZW4gcnVubmluZyAKPj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlv
biB3ZSB3aWxsIHNpZ25hbCBhbGwgdGhlIEhXIAo+Pj4gZmVuY2VzIGFuZCBub3QgcmFjaW5nIGFn
YWluc3Qgc29tZSBtb3JlIGZlbmNlcyBpbnNlcnRpb24gaW50byB0aGF0IAo+Pj4gYXJyYXkgPwo+
Pj4KPj4KPj4gV2VsbCBJIHdvdWxkIHN0aWxsIHNheSB0aGUgYmVzdCBhcHByb2FjaCB3b3VsZCBi
ZSB0byBpbnNlcnQgdGhpcyAKPj4gYmV0d2VlbiB0aGUgZnJvbnQgZW5kIGFuZCB0aGUgYmFja2Vu
ZCBhbmQgbm90IHJlbHkgb24gc2lnbmFsaW5nIAo+PiBmZW5jZXMgd2hpbGUgaG9sZGluZyB0aGUg
ZGV2aWNlIHNyY3UuCj4KPgo+IE15IHF1ZXN0aW9uIGlzLCBldmVuIG5vdywgd2hlbiB3ZSBydW4g
Cj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pX2h3LT5hbWRncHVfZmVuY2Vfd2FpdF9lbXB0eSBv
ciAKPiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHctPmFtZGdwdV9mZW5jZV9kcml2ZXJfZm9y
Y2VfY29tcGxldGlvbiwgCj4gd2hhdCB0aGVyZSBwcmV2ZW50cyBhIHJhY2Ugd2l0aCBhbm90aGVy
IGZlbmNlIGJlaW5nIGF0IHRoZSBzYW1lIHRpbWUgCj4gZW1pdHRlZCBhbmQgaW5zZXJ0ZWQgaW50
byB0aGUgZmVuY2UgYXJyYXkgPyBMb29rcyBsaWtlIG5vdGhpbmcuCj4KCkVhY2ggcmluZyBjYW4g
b25seSBiZSB1c2VkIGJ5IG9uZSB0aHJlYWQgYXQgdGhlIHNhbWUgdGltZSwgdGhpcyBpbmNsdWRl
cyAKZW1pdHRpbmcgZmVuY2VzIGFzIHdlbGwgYXMgb3RoZXIgc3R1ZmYuCgpEdXJpbmcgR1BVIHJl
c2V0IHdlIG1ha2Ugc3VyZSBub2JvZHkgd3JpdGVzIHRvIHRoZSByaW5ncyBieSBzdG9wcGluZyB0
aGUgCnNjaGVkdWxlciBhbmQgdGFraW5nIHRoZSBHUFUgcmVzZXQgbG9jayAoc28gdGhhdCBub2Jv
ZHkgZWxzZSBjYW4gc3RhcnQgCnRoZSBzY2hlZHVsZXIgYWdhaW4pLgoKPj4KPj4gQlRXOiBDb3Vs
ZCBpdCBiZSB0aGF0IHRoZSBkZXZpY2UgU1JDVSBwcm90ZWN0cyBtb3JlIHRoYW4gb25lIGRldmlj
ZSAKPj4gYW5kIHdlIGRlYWRsb2NrIGJlY2F1c2Ugb2YgdGhpcz8KPgo+Cj4gSSBoYXZlbid0IGFj
dHVhbGx5IGV4cGVyaWVuY2VkIGFueSBkZWFkbG9jayB1bnRpbCBub3cgYnV0LCB5ZXMsIAo+IGRy
bV91bnBsdWdfc3JjdSBpcyBkZWZpbmVkIGFzIHN0YXRpYyBpbiBkcm1fZHJ2LmMgYW5kIHNvIGlu
IHRoZSAKPiBwcmVzZW5jZcKgIG9mIG11bHRpcGxlIGRldmljZXMgZnJvbSBzYW1lIG9yIGRpZmZl
cmVudCBkcml2ZXJzIHdlIGluIAo+IGZhY3QgYXJlIGRlcGVuZGVudCBvbiBhbGwgdGhlaXIgY3Jp
dGljYWwgc2VjdGlvbnMgaSBndWVzcy4KPgoKU2hpdCwgeWVhaCB0aGUgZGV2aWwgaXMgYSBzcXVp
cnJlbC4gU28gZm9yIEErSSBsYXB0b3BzIHdlIGFjdHVhbGx5IG5lZWQgCnRvIHN5bmMgdGhhdCB1
cCB3aXRoIERhbmllbCBhbmQgdGhlIHJlc3Qgb2YgdGhlIGk5MTUgZ3V5cy4KCklJUkMgd2UgY291
bGQgYWN0dWFsbHkgaGF2ZSBhbiBhbWRncHUgZGV2aWNlIGluIGEgZG9ja2luZyBzdGF0aW9uIHdo
aWNoIApuZWVkcyBob3RwbHVnIGFuZCB0aGUgZHJpdmVyIG1pZ2h0IGRlcGVuZCBvbiB3YWl0aW5n
IGZvciB0aGUgaTkxNSBkcml2ZXIgCmFzIHdlbGwuCgpDaHJpc3RpYW4uCgo+IEFuZHJleQo+Cj4K
Pj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gQW5kcmV5Cj4+Pgo+Pj4KPj4+Pgo+Pj4+PiBBbmRyZXkK
Pj4+Pj4KPj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pgo+Pj4+Pj4+IMKgwqDC
oCAvKiBQYXN0IHRoaXMgcG9pbnQgbm8gbW9yZSBmZW5jZSBhcmUgc3VibWl0dGVkIHRvIEhXIHJp
bmcgCj4+Pj4+Pj4gYW5kIGhlbmNlIHdlIGNhbiBzYWZlbHkgY2FsbCBmb3JjZSBzaWduYWwgb24g
YWxsIHRoYXQgYXJlIAo+Pj4+Pj4+IGN1cnJlbnRseSB0aGVyZS4KPj4+Pj4+PiDCoMKgwqDCoCAq
IEFueSBzdWJzZXF1ZW50bHkgY3JlYXRlZMKgIEhXIGZlbmNlcyB3aWxsIGJlIHJldHVybmVkIAo+
Pj4+Pj4+IHNpZ25hbGVkIHdpdGggYW4gZXJyb3IgY29kZSByaWdodCBhd2F5Cj4+Pj4+Pj4gwqDC
oMKgwqAgKi8KPj4+Pj4+Pgo+Pj4+Pj4+IMKgwqDCoCBmb3JfZWFjaF9yaW5nKGFkZXYpCj4+Pj4+
Pj4gwqDCoMKgIMKgwqDCoCBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKQo+Pj4+Pj4+Cj4+Pj4+
Pj4gwqDCoMKgIGRybV9kZXZfdW5wbHVnKGRldik7Cj4+Pj4+Pj4gwqDCoMKgIFN0b3Agc2NoZWR1
bGVycwo+Pj4+Pj4+IMKgwqDCoCBjYW5jZWxfc3luYyhhbGwgdGltZXJzIGFuZCBxdWV1ZWQgd29y
a3MpOwo+Pj4+Pj4+IMKgwqDCoCBod19maW5pCj4+Pj4+Pj4gwqDCoMKgIHVubWFwX21taW8KPj4+
Pj4+Pgo+Pj4+Pj4+IH0KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4KPj4+
Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
PiBBbHRlcm5hdGl2ZWx5IGdyYWJiaW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIGFuZCBzdG9wcGlu
ZyAKPj4+Pj4+Pj4+Pj4+IGFuZCB0aGVuIHJlc3RhcnRpbmcgdGhlIHNjaGVkdWxlciBjb3VsZCB3
b3JrIGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBJIGRpZG4ndCBnZXQgdGhlIGFib3ZlIGFuZCBJ
IGRvbid0IHNlZSB3aHkgSSBuZWVkIHRvIHJldXNlIAo+Pj4+Pj4+Pj4+PiB0aGUgR1BVIHJlc2V0
IHJ3X2xvY2suIEkgcmVseSBvbiB0aGUgU1JDVSB1bnBsdWcgZmxhZyBmb3IgCj4+Pj4+Pj4+Pj4+
IHVucGx1Zy4gQWxzbywgbm90IGNsZWFyIHRvIG1lIHdoeSBhcmUgd2UgZm9jdXNpbmcgb24gdGhl
IAo+Pj4+Pj4+Pj4+PiBzY2hlZHVsZXIgdGhyZWFkcywgYW55IGNvZGUgcGF0Y2ggdG8gZ2VuZXJh
dGUgSFcgZmVuY2VzIAo+Pj4+Pj4+Pj4+PiBzaG91bGQgYmUgY292ZXJlZCwgc28gYW55IGNvZGUg
bGVhZGluZyB0byBhbWRncHVfZmVuY2VfZW1pdCAKPj4+Pj4+Pj4+Pj4gbmVlZHMgdG8gYmUgdGFr
ZW4gaW50byBhY2NvdW50IHN1Y2ggYXMsIGRpcmVjdCBJQiAKPj4+Pj4+Pj4+Pj4gc3VibWlzc2lv
bnMsIFZNIGZsdXNoZXMgZS50LmMKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFlvdSBuZWVkIHRvIHdv
cmsgdG9nZXRoZXIgd2l0aCB0aGUgcmVzZXQgbG9jayBhbnl3YXksIGNhdXNlIGEgCj4+Pj4+Pj4+
Pj4gaG90cGx1ZyBjb3VsZCBydW4gYXQgdGhlIHNhbWUgdGltZSBhcyBhIHJlc2V0Lgo+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBGb3IgZ29pbmcgbXkgd2F5IGluZGVlZCBub3cgSSBzZWUg
bm93IHRoYXQgSSBoYXZlIHRvIHRha2UgCj4+Pj4+Pj4+PiByZXNldCB3cml0ZSBzaWRlIGxvY2sg
ZHVyaW5nIEhXIGZlbmNlcyBzaWduYWxsaW5nIGluIG9yZGVyIHRvIAo+Pj4+Pj4+Pj4gcHJvdGVj
dCBhZ2FpbnN0IHNjaGVkdWxlci9IVyBmZW5jZXMgZGV0YWNobWVudCBhbmQgCj4+Pj4+Pj4+PiBy
ZWF0dGFjaG1lbnQgZHVyaW5nIHNjaGVkdWxlcnMgc3RvcC9yZXN0YXJ0LiBCdXQgaWYgd2UgZ28g
d2l0aCAKPj4+Pj4+Pj4+IHlvdXIgYXBwcm9hY2jCoCB0aGVuIGNhbGxpbmcgZHJtX2Rldl91bnBs
dWcgYW5kIHNjb3BpbmcgCj4+Pj4+Pj4+PiBhbWRncHVfam9iX3RpbWVvdXQgd2l0aCBkcm1fZGV2
X2VudGVyL2V4aXQgc2hvdWxkIGJlIGVub3VnaCB0byAKPj4+Pj4+Pj4+IHByZXZlbnQgYW55IGNv
bmN1cnJlbnQgR1BVIHJlc2V0cyBkdXJpbmcgdW5wbHVnLiBJbiBmYWN0IEkgCj4+Pj4+Pj4+PiBh
bHJlYWR5IGRvIGl0IGFueXdheSAtIAo+Pj4+Pj4+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzOiUyRiUyRmNnaXQuZnJlZWRlc2t0b3Au
b3JnJTJGfmFncm9kem92JTJGbGludXglMkZjb21taXQlMkYlM0ZoJTNEZHJtLW1pc2MtbmV4dCUy
NmlkJTNEZWYwZWE0ZGQyOWVmNDRkMjY0OWM1ZWRhMTZjOGY0ODY5YWNjMzZiMSZhbXA7ZGF0YT0w
NCU3QzAxJTdDYW5kcmV5Lmdyb2R6b3Zza3klNDBhbWQuY29tJTdDZWVmYTljOTBlZDhjNDA1ZWMz
YjcwOGQ4ZmM0NmRhYWElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0Mw
JTdDNjM3NTM2NzI4NTUwODg0NzQwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0
d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3
QzEwMDAmYW1wO3NkYXRhPVVpTmFKRSUyQkg0NWlZbWJ3U0RuTVNLWlM1ejBpYWswZk5sYmJmWXFL
UzJKbyUzRCZhbXA7cmVzZXJ2ZWQ9MAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBZZXMsIGdvb2QgcG9pbnQg
YXMgd2VsbC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Cj4+Pj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
