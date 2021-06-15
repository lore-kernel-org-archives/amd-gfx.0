Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360DC48BE8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 12:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A4A61458
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 12:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A4A61458
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CEC89A75;
	Tue, 15 Jun 2021 12:18:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1AD89A56;
 Tue, 15 Jun 2021 12:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fcthde5PayEnibSvlYzfzbbw7maEjoVq4Wru9dfCohLcEmXg0NjtqkgpkvHyJAKKgLUpjpiEH+invLuelWxobIxUlrnuXx8vZkSR53By4SbfpHLRn/BdKLqk0iCAc5L8IXJTYC09v+6tSM+QYyoxhslRi/DTJrptGUwc/45haHdPkH9BiNE5qfmHJN4KTFmtLSNML/Z4vso8VuLR15pZyyLylP5BrUjGFcSYBocJdGXDEXpqiKIcsyxQoLmrGuU7LqXvhg3XVszO6ndwEZjLnexvLGdRHtOB6K6i5FBQiY2nzvKaG0qiU+Tx4riw/+JI7UMJkGvWJa6ypSOSwVRX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JS0/33fMUfRWzm0eTKIut6RMUL91tK0C6Bj7kcBVUY=;
 b=QeuIHGyP9/IVhjWXG9QZzsmRS9QemDgQKTSKtwVAngjxg/tTWalWRD5R2odmHxdH02sqJuSr+Q/e+Qw79Oh03F8AETfyuyxSMt7jDtGdTqL8cHBCeH5hW2AtkI77zQhPyUnfT3wcnOsIvKeKJaMjpdQVQr9Iu9bI+plPSXWoXc4u64K3vj4CPCKKuEMKuFtG5gTyEfUF+mjT6y3eBYTzJX9zVehEli5pdfkRQI0wTI8AGdpcyWXughcTG7lI5DwkCja7Eqk0cKu99kr4+x0lPdCEiqGOnsiKtuAjcEMcht2p1Mvf/NHuh/6b4tl4+rDwKCWsYLMJABYkYo2oQuBtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JS0/33fMUfRWzm0eTKIut6RMUL91tK0C6Bj7kcBVUY=;
 b=sSNdKOTi6BdVPynlJpSu+OPcSYwrVbEF1lR6DtmADlKn4yVAR72O5zPsXzkDV15RInWXlEaqk3bzjP3PVw0jQXpBOriA7p/pUbTJzDYbi+r1bjq84kWtf2oHQEN74hHZRqzEHbwVqTakps7MbrgWCDXb7ZRNJxUFL23qV3+v3dY=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 12:18:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 12:18:37 +0000
Subject: Re: [RFC PATCH] drm/ttm: Do page counting after populate callback
 succeed
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20210615115746.27424-1-xinhui.pan@amd.com>
 <f70e88b3-f0db-fca8-f05e-f685f1a913ad@gmail.com>
 <4719A30A-0B23-4053-B8EB-AC9BD21DBE40@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <88115e0c-5cee-5b16-f60f-480136f0bcad@amd.com>
Date: Tue, 15 Jun 2021 14:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <4719A30A-0B23-4053-B8EB-AC9BD21DBE40@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:f438:4e93:3853:400c]
X-ClientProxiedBy: AM4PR0902CA0010.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:f438:4e93:3853:400c]
 (2a02:908:1252:fb60:f438:4e93:3853:400c) by
 AM4PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:200:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 15 Jun 2021 12:18:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 158f92f2-fd50-455d-7cef-08d92ff7b3ea
X-MS-TrafficTypeDiagnostic: MN2PR12MB4224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB422431D16F0A8FD355AD1CCE83309@MN2PR12MB4224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAmOnLlDN55Icdj/vxtB+1/wb+ki7zA+tpFG1g1BTbZCL0tzvXVTXLydo1KEl15ACzi/tAQIbmyMRDyNarkmYd2To3RHUvdygaZuh8BERbx87azYrJF4Y0Ib8LZJ4zpqgz9YsxrqD8yrsk2WjKmgQplTRZUZiNHExJRip5NW1ld0BefVnvp31s72o8rCQlMkbuzUyGPskt0bNOS4KYHse6ujKh+EN7gaZZR7+VOyJlpEgERw3j6rZxW9aj1fwd/RGMYJs1VQsGSQjYE17f3kZSt1x1zorhvs5+5tVXSP3CzLwIZs70o0Sm8ekzdkubZITPd9L6g4nY7Jc4cQxlqMWtmTobwWxeyPWoV2IsHyPBdP5hQORfolgGSriJXekF52VUMpbqLrsNkknm2jIfjllN5ah6n4N9ufmMb4CHiPvlZCJbEK/KICkP5LTgiBKEv8FO4HhLMS/aG2JR/oIYbMtuSd3PWHAPNze3vuVbjA7PFXA/OJaZe1IFCng6tEzTsrUbjC6u4kmvYSBjlMfib2kUPiB/56M0xIazzHUKqMyQXJ2mxfS3hRa/HJsjUPdxieDBLM9paoAOUviQ7pU+bfgcUXW4LnESpyPC//ttiNte/1nIWnGhx/pgzr+cy33IlP7PIHIeL/XC5VwQer+UclI3Y3xJ4MV9Gfw9CBJjVEPxS6ayFGYOAIQorps8V/GHiF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39840400004)(6486002)(2906002)(316002)(66476007)(478600001)(54906003)(31686004)(110136005)(4326008)(186003)(2616005)(66946007)(16526019)(86362001)(6666004)(83380400001)(8676002)(66574015)(36756003)(5660300002)(8936002)(66556008)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VpNk1GNkROTm52RkRocDcwYnl6c2RmSHJ1SnR0MFQwdVJ0ZU40NXFheXFS?=
 =?utf-8?B?RSs0bFFhOHE5M1Fob1JQRlI1a3pESnRIWEVITnhxeUV5R2w4WkVHV25saG40?=
 =?utf-8?B?TXdwWVNWbDZOTFprY3VVam5BblZOVE9TZFpKNTZSc0RZekhSendsRDc3ZkRy?=
 =?utf-8?B?azl2NnFJUmFPZ1dtaHVQSnVUbStYMWRGWWMxbUZKeWZqNkIwVEJLRnRlVFFs?=
 =?utf-8?B?MEZENGhjTElTcVhKOGQ3b2R5eFhBOVhJaTNwZHRPMjhtbWluNFVQWnRMREhi?=
 =?utf-8?B?cFN0ZEM3eEY3UGIzUTFBcnBFN0ErTjlSZHpaSkpTMjM3UFdLemRZUmR4UXZ6?=
 =?utf-8?B?OGNOQzNxeW1FVUUwVUpDVjRwLzl4M1BRREdadEFNSDhoZlR2K0RsUlRPSHdW?=
 =?utf-8?B?cDNJa2k3VFl1Qkl5czhGM3NTNlRuSkpJRWRscVRXMHVBS3lzNzNUZ3AzVXRM?=
 =?utf-8?B?N2F2Q3lmWkRjeU5NOFB4RnNyaE90YnlhUCtCZlVwQmZKL1lwbk9pNENUK2pK?=
 =?utf-8?B?K2xEUVIzUnRja013cHlxZE9KUXNVMW9Od0JKTkdBN21OZ0dUOXZUemdXREhT?=
 =?utf-8?B?MmlMUW1MeDl5WTl3b2k4Y3FEREwxUVNuTndtYjBnRTlNTWQvQkhLYmZ6dG5B?=
 =?utf-8?B?NEcrVHY0RTRqNzBBQmJDb3FzcWdKNjl1WlZOMTdSYXRoS01oVE1mSCtHSVpq?=
 =?utf-8?B?UnZUdTlZZ0NJczB4bDFPRWU1YlV3VG10aXUzSDUrcVpZMm5oTWdvT0lkQ2tu?=
 =?utf-8?B?R2N3UnJmYlRweFkyY3FML1pNQnVLWWtMMWh5emkwZ3BxaWNhcmNVa0svMmFt?=
 =?utf-8?B?QUttTDFXQWF0WWZQYVh0WDBnbUtFYnRmbTlIck1icXlUVE1lcy9lZ1BYR2hQ?=
 =?utf-8?B?OUNud0JqdC9ROXVLMFJBZU5nY1Z6bnE5dDNIOHZUb0dZbU5LMmMxQnV2QUJE?=
 =?utf-8?B?Vmc2cm45WUI4ZDFyQzROMkZyS0JTc1JnK0UxTEtzRkdTZG4vSWRSQVhnTEZN?=
 =?utf-8?B?WkF3elRwWVNubk5vM3lQZTdqRFovM2dReG1FdVE1YS9iZnFLSSszVlVqdzEx?=
 =?utf-8?B?RDJsclpVa1JiWFNQOHBsdGJFOU1RMHRUOFlEaThON3VhVFN2MzVSak5DMXhD?=
 =?utf-8?B?WDFCdXNxOTR4ZGxTdEVBY2x5NWNXZU5KeDg5cXNUSDZpWFIwVDhXbUZKcHVm?=
 =?utf-8?B?aWl5L25OYndqdUhkK3IrcFZvUUZuRmtUSnVxcUF5eTJsSkF1cEdxMDJmSDRu?=
 =?utf-8?B?NEdFR3Z6ZFRNcTdFU2g4RWhYRUVtOXhkYXFPdVZvVlFXYWJmOHRQd1ljUVA4?=
 =?utf-8?B?d2tEVC8yU2NmaS9jMStCQUIyRkZqTWVqSlZ1R3J2cFFEb2duVm9odGlQemR1?=
 =?utf-8?B?QnYzM2JQNHNaaGxvbDJmYU5ORk5vaVNaK2FmUXdlZEVMVVF6WFNDWHJFVm84?=
 =?utf-8?B?dlBiVm9EVCtjemJwVE1mSSs0ZXVHblA4ZWJpMXQ3SmpvT0VDdlU1YkpheXpC?=
 =?utf-8?B?YWFuVXZTb09lbmRJekdhNk0rVmRBZ0xxMG9CTlNYdGw2Tnh4VERaY2RLUnhS?=
 =?utf-8?B?UG4wL0hBakgrTHQwcEM3MGo2UUZUamU0dy91eGpKaE1rZ3B2VmVCQURlRFdM?=
 =?utf-8?B?MUYvalFXR3A3MWcvQkhqcE52ZW00L2ZxUG9jWnFleVZoUW1qOVBQVWpuOEht?=
 =?utf-8?B?b1lwMVY4MHJzamc4WnFiNktNc2VXQThUVGlScXQ0SnpEeVlGYTZTNldmV1pr?=
 =?utf-8?B?eC9xYmN5YnhaSDhIcUtmMGQ1RUlRUWU1QWpFSWtydG52TEFkRzYrWEt3bHlI?=
 =?utf-8?B?Mkx6Q3RkdUhZa0FmVWcwL1NzcjB3UlV0K3g3YlZ3ZUtJNEFRRnlPK1UvdHpF?=
 =?utf-8?Q?Vy6sT6jQhXLnP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158f92f2-fd50-455d-7cef-08d92ff7b3ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 12:18:37.4021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tk8/Y72JflyL4wtWqFUhE347FoK0ny43vyJRYFuSznwn3QZ5b5XND2HSPf18HoO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
Cc: "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTUuMDYuMjEgdW0gMTQ6MTEgc2NocmllYiBQYW4sIFhpbmh1aToKPj4gMjAyMeW5tDbmnIgx
NeaXpSAyMDowMe+8jENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21h
aWwuY29tPiDlhpnpgZPvvJoKPj4KPj4gQW0gMTUuMDYuMjEgdW0gMTM6NTcgc2NocmllYiB4aW5o
dWkgcGFuOgo+Pj4gQW1kZ3B1IHNldCBTRyBmbGFnIGluIHBvcHVsYXRlIGNhbGxiYWNrLiBTbyBU
VE0gc3RpbGwgY291bnQgcGFnZXMgaW4gU0cKPj4+IEJPLgo+PiBJdCdzIHByb2JhYmx5IGJldHRl
ciB0byBmaXggdGhpcyBpbnN0ZWFkLiBFLmcuIHdoeSBkb2VzIGFtZGdwdSBtb2RpZnkgdGhlIFNH
IGZsYWcgZHVyaW5nIHBvcHVsYXRlIGFuZCBub3QgZHVyaW5nIGluaXRpYWwgY3JlYXRpb24/IFRo
YXQgZG9lc24ndCBzZWVtIHRvIG1ha2Ugc2Vuc2UuCj4gZmFpciBlbm91Z2guIExldCBtZSBoYXZl
IGEgdHJ5Lgo+IE5vIGlkZWEgd2h5IHdlIHNldCBTRyBmbGFnIGluIHBvcHVsYXRlIHllYXJzIGFn
by4KClRoYXQncyBwcmV0dHkgcmVjZW50IElJUkMuIEZlbGl4IG1vdmVkIHRoZSBjb2RlIGFyb3Vu
ZCBhIGJpdCB0byBmaXggCmFub3RoZXIgcHJvYmxlbS4KCkNocmlzdGlhbi4KCj4KPj4gQ2hyaXN0
aWFuLgo+Pgo+Pj4gT25lIGVhc3kgd2F5IHRvIGZpeCB0aGlzIGlzIGxldHMgY291bnQgcGFnZXMg
YWZ0ZXIgcG9wdWxhdGUgY2FsbGJhY2suCj4+Pgo+Pj4gV2UgaGl0IG9uZSBpc3N1ZSB0aGF0IGFt
ZGdwdSBhbGxvYyBtYW55IFNHIEJPcywgYnV0IFRUTSB0cnkgdG8gZG8gc3dhcAo+Pj4gYWdhaW4g
YW5kIGFnYWluIGV2ZW4gaWYgc3dhcG91dCBkb2VzIG5vdCBzd2FwIFNHIEJPcyBhdCBhbGwuCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgo+Pj4g
LS0tCj4+PiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMgfCAzMiArKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgMTkgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3R0LmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90dC5jCj4+PiBpbmRleCBhMWEy
NTQxMGVjNzQuLjRmYTBhOGNkNzFjMCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3R0LmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMKPj4+IEBA
IC0zMTcsMTMgKzMxNyw2IEBAIGludCB0dG1fdHRfcG9wdWxhdGUoc3RydWN0IHR0bV9kZXZpY2Ug
KmJkZXYsCj4+PiAgIAlpZiAodHRtX3R0X2lzX3BvcHVsYXRlZCh0dG0pKQo+Pj4gICAJCXJldHVy
biAwOwo+Pj4gICAtCWlmICghKHR0bS0+cGFnZV9mbGFncyAmIFRUTV9QQUdFX0ZMQUdfU0cpKSB7
Cj4+PiAtCQlhdG9taWNfbG9uZ19hZGQodHRtLT5udW1fcGFnZXMsICZ0dG1fcGFnZXNfYWxsb2Nh
dGVkKTsKPj4+IC0JCWlmIChiZGV2LT5wb29sLnVzZV9kbWEzMikKPj4+IC0JCQlhdG9taWNfbG9u
Z19hZGQodHRtLT5udW1fcGFnZXMsCj4+PiAtCQkJCQkmdHRtX2RtYTMyX3BhZ2VzX2FsbG9jYXRl
ZCk7Cj4+PiAtCX0KPj4+IC0KPj4+ICAgCXdoaWxlIChhdG9taWNfbG9uZ19yZWFkKCZ0dG1fcGFn
ZXNfYWxsb2NhdGVkKSA+IHR0bV9wYWdlc19saW1pdCB8fAo+Pj4gICAJICAgICAgIGF0b21pY19s
b25nX3JlYWQoJnR0bV9kbWEzMl9wYWdlc19hbGxvY2F0ZWQpID4KPj4+ICAgCSAgICAgICB0dG1f
ZG1hMzJfcGFnZXNfbGltaXQpIHsKPj4+IEBAIC0zNDIsNiArMzM1LDEzIEBAIGludCB0dG1fdHRf
cG9wdWxhdGUoc3RydWN0IHR0bV9kZXZpY2UgKmJkZXYsCj4+PiAgIAlpZiAocmV0KQo+Pj4gICAJ
CWdvdG8gZXJyb3I7Cj4+PiAgICsJaWYgKCEodHRtLT5wYWdlX2ZsYWdzICYgVFRNX1BBR0VfRkxB
R19TRykpIHsKPj4+ICsJCWF0b21pY19sb25nX2FkZCh0dG0tPm51bV9wYWdlcywgJnR0bV9wYWdl
c19hbGxvY2F0ZWQpOwo+Pj4gKwkJaWYgKGJkZXYtPnBvb2wudXNlX2RtYTMyKQo+Pj4gKwkJCWF0
b21pY19sb25nX2FkZCh0dG0tPm51bV9wYWdlcywKPj4+ICsJCQkJCSZ0dG1fZG1hMzJfcGFnZXNf
YWxsb2NhdGVkKTsKPj4+ICsJfQo+Pj4gKwo+Pj4gICAJdHRtX3R0X2FkZF9tYXBwaW5nKGJkZXYs
IHR0bSk7Cj4+PiAgIAl0dG0tPnBhZ2VfZmxhZ3MgfD0gVFRNX1BBR0VfRkxBR19QUklWX1BPUFVM
QVRFRDsKPj4+ICAgCWlmICh1bmxpa2VseSh0dG0tPnBhZ2VfZmxhZ3MgJiBUVE1fUEFHRV9GTEFH
X1NXQVBQRUQpKSB7Cj4+PiBAQCAtMzU1LDEyICszNTUsNiBAQCBpbnQgdHRtX3R0X3BvcHVsYXRl
KHN0cnVjdCB0dG1fZGV2aWNlICpiZGV2LAo+Pj4gICAJcmV0dXJuIDA7Cj4+PiAgICAgZXJyb3I6
Cj4+PiAtCWlmICghKHR0bS0+cGFnZV9mbGFncyAmIFRUTV9QQUdFX0ZMQUdfU0cpKSB7Cj4+PiAt
CQlhdG9taWNfbG9uZ19zdWIodHRtLT5udW1fcGFnZXMsICZ0dG1fcGFnZXNfYWxsb2NhdGVkKTsK
Pj4+IC0JCWlmIChiZGV2LT5wb29sLnVzZV9kbWEzMikKPj4+IC0JCQlhdG9taWNfbG9uZ19zdWIo
dHRtLT5udW1fcGFnZXMsCj4+PiAtCQkJCQkmdHRtX2RtYTMyX3BhZ2VzX2FsbG9jYXRlZCk7Cj4+
PiAtCX0KPj4+ICAgCXJldHVybiByZXQ7Cj4+PiAgIH0KPj4+ICAgRVhQT1JUX1NZTUJPTCh0dG1f
dHRfcG9wdWxhdGUpOwo+Pj4gQEAgLTM4NCwxMiArMzc4LDYgQEAgdm9pZCB0dG1fdHRfdW5wb3B1
bGF0ZShzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwgc3RydWN0IHR0bV90dCAqdHRtKQo+Pj4gICAJ
aWYgKCF0dG1fdHRfaXNfcG9wdWxhdGVkKHR0bSkpCj4+PiAgIAkJcmV0dXJuOwo+Pj4gICAtCXR0
bV90dF9jbGVhcl9tYXBwaW5nKHR0bSk7Cj4+PiAtCWlmIChiZGV2LT5mdW5jcy0+dHRtX3R0X3Vu
cG9wdWxhdGUpCj4+PiAtCQliZGV2LT5mdW5jcy0+dHRtX3R0X3VucG9wdWxhdGUoYmRldiwgdHRt
KTsKPj4+IC0JZWxzZQo+Pj4gLQkJdHRtX3Bvb2xfZnJlZSgmYmRldi0+cG9vbCwgdHRtKTsKPj4+
IC0KPj4+ICAgCWlmICghKHR0bS0+cGFnZV9mbGFncyAmIFRUTV9QQUdFX0ZMQUdfU0cpKSB7Cj4+
PiAgIAkJYXRvbWljX2xvbmdfc3ViKHR0bS0+bnVtX3BhZ2VzLCAmdHRtX3BhZ2VzX2FsbG9jYXRl
ZCk7Cj4+PiAgIAkJaWYgKGJkZXYtPnBvb2wudXNlX2RtYTMyKQo+Pj4gQEAgLTM5Nyw2ICszODUs
MTIgQEAgdm9pZCB0dG1fdHRfdW5wb3B1bGF0ZShzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwgc3Ry
dWN0IHR0bV90dCAqdHRtKQo+Pj4gICAJCQkJCSZ0dG1fZG1hMzJfcGFnZXNfYWxsb2NhdGVkKTsK
Pj4+ICAgCX0KPj4+ICAgKwl0dG1fdHRfY2xlYXJfbWFwcGluZyh0dG0pOwo+Pj4gKwlpZiAoYmRl
di0+ZnVuY3MtPnR0bV90dF91bnBvcHVsYXRlKQo+Pj4gKwkJYmRldi0+ZnVuY3MtPnR0bV90dF91
bnBvcHVsYXRlKGJkZXYsIHR0bSk7Cj4+PiArCWVsc2UKPj4+ICsJCXR0bV9wb29sX2ZyZWUoJmJk
ZXYtPnBvb2wsIHR0bSk7Cj4+PiArCj4+PiAgIAl0dG0tPnBhZ2VfZmxhZ3MgJj0gflRUTV9QQUdF
X0ZMQUdfUFJJVl9QT1BVTEFURUQ7Cj4+PiAgIH0KPj4+ICAgCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
