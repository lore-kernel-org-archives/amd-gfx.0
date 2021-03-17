Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7598FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 09:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D4664F42
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 09:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D4664F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44646E50B;
	Wed, 17 Mar 2021 09:31:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0186E50B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 09:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTtindIFXjqDlD7fYNBLknXbdGPgO7kUqdlR5cLHgew1m+WWt2B0XOeC0JqNKvoArJHIEpVGdob7pRBWDpIvtuH8SkByf/kP3EZcjXoc1pl/Afa4cCv93AZemLRRsGbWOgpehzYpOSTAGxGBBBvhCrxyy65Zn3tzdkFqrOcFuNpanOipZHgKr6howGjvReBZMIFTVA6vbEBKfnHadx+Vm9ekyPowsUzy8hL+EV+4jb8xYuH58gtY38pQgfXjTw9PsFiHVF/2RjP0UWHXB7fKFIrvpK4VUrQf+fnWyYY1LG20p/ePo+oqar/nneHUBXR3NVPnVAU+u0x7WT+hm6UxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7z2xBavoUZkhOfwKxx8/VLRfeD9CW3Gb3zfELiAgJs=;
 b=VehAe3C96ddV/j9Y4a2nOQB6Ls10vgvrcxnvKHktPk9N+e5wnWwVKfgxl5TXFBOXNxZSdw+FVrGiNXnXpkFEFzGRwYZci8UsCtnG66L8/izknElXUwJ++iH3z+jjsYT1k9guEp6psS+koNXpn1vfQebJpoxQgilpciE55LSU5KD7hoPrfqXANjH3v8EXPCVVKTJ0dJAJgeSwL4HioGEZE51LaG9zBZF39DI1UMGf8o/ziK4s9Gs76awTEWvzZYV/sg+IOmRAF4zRk4qYEScxUdyV559+4fGUgPdfMxTaWaaZPvlx2jNBT2ViMuUFzISXOfTcU4X+l4z59Z68iEiWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7z2xBavoUZkhOfwKxx8/VLRfeD9CW3Gb3zfELiAgJs=;
 b=wLauyz95CjzqJTGkoI+y0inVTs/DjFdRPu0sr7LICrJ90u88RkFKZwStYp7TbjXaQOzbK8lptE4Ug+TcuRcqis64mTytshW+mrz+/k35bPay2kWCxLrDgHg+0vtvJNTTRookEby5HPUiNBNyo0MPj3os2EAl9XhgfshtPZRsdI0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4782.namprd12.prod.outlook.com (2603:10b6:208:a3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 09:31:36 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 09:31:36 +0000
Subject: Re: [PATCH] radeon: use kvcalloc for relocs and chunks
To: Chen Li <chenli@uniontech.com>
References: <87czvyz4dd.wl-chenli@uniontech.com>
 <03eefbb1-4d33-8a96-a53c-df1654a7d3f6@amd.com>
 <87blbiyw6o.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <90080fc2-85d7-fcbb-4889-c63d800d868b@amd.com>
Date: Wed, 17 Mar 2021 10:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <87blbiyw6o.wl-chenli@uniontech.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
X-ClientProxiedBy: AM8P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
 (2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5) by
 AM8P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 09:31:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c363c5f3-74a3-48db-e622-08d8e92775df
X-MS-TrafficTypeDiagnostic: MN2PR12MB4782:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB478214188A396605253F13FE836A9@MN2PR12MB4782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cl7CwmTWHUi+/0pMBZKhNzGjtwY8F0Nze9V3bRgWSTk/yDBzZXZQYJgT2fAgXGqgq5boSJPIbEEKsb7nLYPchuiOLwlDHNqgIdd9sPHFu2/4VB7AcXQf9J1eZc+dBnvZtZE02tAy7BGq0gspR0BvN9+gO2zJNOqNe5tIWjvYY1o8I2CTA1PPMaed+q+UnZdAEychQlSudn4a8NR62IocIZQNbmysHR5BhFDnAP7WrvqWSSrv9vLOtzcAIOQMnGFS8rALE3jSScqxb0Ss181BtxQW4iT1jg2vmsXZ//Qmh5+QuM4Hf7buv5G2P4tLsuBFM/p2Uao/yHuv+0Q/87iAeLwB9CqgkMlMva/ffWaWLkXwABuyjq987357/ImSfev+E3XaqAxo92b8YqmtpuOOB5Ema5jOHYyCwNPl5holry9lVG6ZClLYzimP8hfCfKBotuabR9pGZBTVtA802E37Guxyjg7XJsJuub8Is+860ZfPwp7WMsgOliEXROBtpfKxh7PZ5R55fS7H9Nzhl20ly7kpyQwRNk0fLH0izFkKP5WKmRZNG+RlFwyAE4oQl08E9vpmWJW25RMGfvtE0X2QQbKpdw93Yv+brleQlZ0PuwSjHyqRALPotpTDSJ9njUBiUoOMEBAhh7wR5UONX21N0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(186003)(31696002)(2906002)(8936002)(2616005)(316002)(66574015)(4326008)(36756003)(5660300002)(478600001)(31686004)(83380400001)(52116002)(66946007)(16526019)(8676002)(6486002)(6666004)(66556008)(86362001)(6916009)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cmNieHFtbnczYi9uZ243ck5SNXhjRjE2N3R3K09YbzhsUkh4bUhtaGlDYUFh?=
 =?utf-8?B?TUZMVzdJajhJUnd4ZVJXMGFtV1Nkakx0YTdXTHhDVUxmbVNPdnozaFMwUkty?=
 =?utf-8?B?N1paZlJKS1c2d3VpOW1paklxQlp3Y3N3TzRyZFFiVUw0cHdGQUYvcEl4VEZY?=
 =?utf-8?B?WFhoM21sVVQ0VFJwQzJrZ0VCZ2R6QTNpTTFON1c3dms3MkE0eDBFY09FbXVS?=
 =?utf-8?B?elUwcmcrVm1GVEJxamtkVFVFZlRTVTM2a2xTZEhOeEdtS05CUXdVWkVyRkRR?=
 =?utf-8?B?blZoeFpxUUs3dW1kVUJiM1M2b29kSW93b0tQUHhmR1RQV2VVcWQycjB2M042?=
 =?utf-8?B?MUo5NXNnek8xeGVMTVROOHJTUURIajV2VXRBcExHck5iS2R3a1BtYUV2bGRZ?=
 =?utf-8?B?cDYxcUJ6UGlnem5FbVpCT2pCK0QwOWlBMW5CR3BrUjZUKzFzN1dLaFhXWU85?=
 =?utf-8?B?cnZVb2ZJdXAydzBLR21Qd1p0RVlIMitnRlVvSjJyOTFRRmpOaUVZMGdHNVR2?=
 =?utf-8?B?M1BaU0hORkFPazFOd2lDdHpwRzlyRkxEQmhORVh2RW10eWNUZVdrcFpyaWVH?=
 =?utf-8?B?dG5WSVZ4OHRjZm1Qc29ZL2hYOVZIaFlFMjVEb3hZUUdKaGRkQWR4K3JYcjJM?=
 =?utf-8?B?WktsL0pBUEhVM29PUFNScFVKd1k5YVpxckJ3MVE1QXhuZmE4eStJSVZhVEJI?=
 =?utf-8?B?TzJYWFFSR0N0QlBrcHY4TXpQRE5xc082NDhNcERmamNSRGxtdXo2RUE1Y0xS?=
 =?utf-8?B?cE5uU2ZNN0l3ZnBNcUhzcEZFWUtsOFprQ2NKZ0MwTUlGN051ZFl6Y1VHQ0l5?=
 =?utf-8?B?WUxlSm5hemw3djRZN21lUWl5MkpvZC92VEZYNWpzOUVnRk0wdzUxTHBIdkcx?=
 =?utf-8?B?TU9xOHFGUGNoVFdwOTZPQjQ1Ymg1MmhlckZlSkNVNUtiYkpQTzNyOUt0WTJT?=
 =?utf-8?B?bU5tcEF0enNPVnhTVWRDQW5hRUhIQWVBLzVnOG9BSzBNQzg4WUs2LzZxRHdM?=
 =?utf-8?B?QkxOYXIxMkZySkFLVk9QMUhadVd5SDF1ekRVbk9CSUhKems5ck00WFpHWkxO?=
 =?utf-8?B?UXZhdm1HMllQSUZxUTYvam95TXpZSHNraEF3emtobVZWcjczdDc5UUdiWDBv?=
 =?utf-8?B?bjhqUEZMaXpReEU2ZWtvclk3SVRNNHdQcmJtNGVUdDRCYXF6M096OStQUVZI?=
 =?utf-8?B?VTREdDRQY2tLSERzZlZIaDlWK3dLdmdFaS9sVG9GTTdicDFwbEJxRWMrSFhu?=
 =?utf-8?B?R1JuVmxaTVF3ajFqQjFBMnExdFhkZ2pDcGFLVVNxVnd6c3FUYnlZSUpxM0Fo?=
 =?utf-8?B?ell2M0lXMXd6ZWFrZ0hlRkJlUVh4OGdTdXpHNStUWjJsa0djaE56TGVkazdz?=
 =?utf-8?B?Ri8rdGcydTlVeng3VHRYZFdienlaS3FTS3NHNDFYVGQrYUtWMWlvT1UvRTA5?=
 =?utf-8?B?UmxnYlhSSUpCMzFrZ0R3TzdicmtVVVhCV2ZodERQL1ZJMlV2azJwRkdpSFYx?=
 =?utf-8?B?QkRCSExjS0tlUHFhOGkva3Zha1htc1NtdVhiODM0NXIySkFnZ2hLTUJWcDVa?=
 =?utf-8?B?VjIzTVBPb1BWNzJPanh3ZWF6SXg4Z3VTY1Y3ZGRSUWw5VFN6cndCY2JYeHA2?=
 =?utf-8?B?UGg3Q1ZIc3Y0d1pTSTZPQlJ6ZEl4S0NmK0JHNzRkcTUxYSs2OHdORWtQQmxC?=
 =?utf-8?B?OXZxelhaS2hPYkNHajAxVWp3T29TMVZJT2I1OTEwWEtUMFZ3QXY0RzBXaGdJ?=
 =?utf-8?B?SE5kOHptMk9aZTAzdWJHZEovTFBSODBYQ2toWkxhVWJUbmFzeVIrNUVKZ0Nh?=
 =?utf-8?B?bTQrSi80RG5vQnpSQXVJQ1R5eHlLL3JaWmY0L2l3UzF4bVRNN3BmV2VlNnRw?=
 =?utf-8?Q?Xm+RkWYmctP3u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c363c5f3-74a3-48db-e622-08d8e92775df
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 09:31:36.4888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua118PnCWNaGFdAk9c275q7UUmJ2pdscY9/bgGm1lEp9fOQ5Tdw711Tt4GJy5KhM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4782
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDMuMjEgdW0gMTA6MTkgc2NocmllYiBDaGVuIExpOgo+IE9uIFdlZCwgMTcgTWFyIDIw
MjEgMTU6NTU6NDcgKzA4MDAsCj4gQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTcuMDMu
MjEgdW0gMDc6MjIgc2NocmllYiBDaGVuIExpOgo+Pj4ga3ZtYWxsb2NfYXJyYXkgKyBfX0dGUF9a
RVJPIGlzIHRoZSBzYW1lIHdpdGgga3ZjYWxsb2MuCj4+Pgo+Pj4gQXMgZm9yIHAtPmNodW5rcywg
aXQgd2lsbCBiZSB1c2VkIGluOgo+Pj4gYGBgCj4+PiBpZiAoaWJfY2h1bmstPmtkYXRhKQo+Pj4g
CQltZW1jcHkocGFyc2VyLT5pYi5wdHIsIGliX2NodW5rLT5rZGF0YSwgaWJfY2h1bmstPmxlbmd0
aF9kdyAqIDQpOwo+Pj4gYGBgCj4+Pgo+Pj4gSWYgY2h1bmtzIGRvZXNuJ3QgemVybyBvdXQgd2l0
aCBfX0dGUF9aRVJPLCBpdCBtYXkgcG9pbnQgdG8gc29tZXdoZXJlIGVsc2UsIGUuZy4sCj4+PiBg
YGAKPj4+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwg
YWRkcmVzcyAwMDAwMDAwMDAwMDEwMDAwCj4+PiAuLi4KPj4+IHBjIGlzIGF0IG1lbWNweSsweDg0
LzB4MjUwCj4+PiByYSBpcyBhdCByYWRlb25fY3NfaW9jdGwrMHgzNjgvMHhiOTAgW3JhZGVvbl0K
Pj4+IGBgYAo+Pj4KPj4+IGFmdGVyIGFsbG9jYXRpbmcgY2h1bmtzIHdpdGggX19HRlBfS0VSTkVM
L2t2Y2FsbG9jLCB0aGlzIGJ1ZyBpcyBmaXhlZC4KPj4gTkFLIHRvIHplcm9pbmcgdGhlIGNodW5r
cyBhcnJheS4KPj4KPj4gVGhhdCBhcnJheSBzaG91bGQgYmUgZnVsbHkgaW5pdGlhbGl6ZWQgd2l0
aCBkYXRhIGJlZm9yZSB1c2luZyBpdCwgb3RoZXJ3aXNlIHdlCj4+IGhhdmUgYSBtdWNoIG1vcmUg
c2VyaW91cyBidWcgYW5kIHplcm9pbmcgaXQgb3V0IG9ubHkgcGFwZXJzIG92ZXIgdGhlIHJlYWwg
aXNzdWUuCj4+Cj4+IEhvdyBkaWQgeW91IHRyaWdnZXIgdGhlIE5VTEwgcG9pbnRlciBkZXJlZiBh
Ym92ZT8KPiBIaSwgQ2hyaXN0aWFuLCB0aGFua3MgZm9yIHJlcGx5ISBGcm9tIHJhZGVvbl9jc19w
YXJzZXJfaW5pdDoKPiBgYGAKPiAJaWYgKHVzZXJfY2h1bmsuY2h1bmtfaWQgPT0gUkFERU9OX0NI
VU5LX0lEX0lCKSB7Cj4gCQkJaWYgKCFwLT5yZGV2IHx8ICEocC0+cmRldi0+ZmxhZ3MgJiBSQURF
T05fSVNfQUdQKSkKPgo+ICAgICAgICAgICAgICAvKioqKioqIGNoZW5saTogY2h1bmtzWzBdIGNv
bWUgaGVyZSBhbmQgY29udGludWUhICoqKioqKi8KPgo+IAkJCQljb250aW51ZTsKPiAJCX0KPgo+
IAkJcC0+Y2h1bmtzW2ldLmtkYXRhID0ga3ZtYWxsb2NfYXJyYXkoc2l6ZSwgc2l6ZW9mKHVpbnQz
Ml90KSwgR0ZQX0tFUk5FTCk7Cj4gYGBgCj4gSW4gbXkgY2FzZSwgY2h1bmtzWzBdIGlzIG5vdCBh
bGxvY2F0ZWQgYmVjYXVzZSBpdCBpcyBqdXN0IGdldCBjb250aW51ZWQsIHNvIGl0J3Mgbm90Cj4g
d2lyZWQgdGhhdCBrZGF0YSBpbiAibWVtY3B5KHBhcnNlci0+aWIucHRyLCBpYl9jaHVuay0+a2Rh
dGEsIGliX2NodW5rLT5sZW5ndGhfZHcgKiA0KTsiCj4gdHJpZ2dlciB0aGUgaW52YWxpZCBhZGRy
ZXNzLgoKUmlnaHQsIHRoZSBwcm9ibGVtIGlzIHRoaXMgbWVtb3J5IG9wdGltaXphdGlvbiBhZGRl
ZCB+OCB5ZWFycyBhZ28uCgpXZSBkb24ndCBzZXQgdGhlIGtkYXRhIHBvaW50ZXIgdG8gTlVMTCBp
biB0aGF0IGNhc2UsIGNhbiB5b3UgcGxlYXNlIGFkZCAKdGhpcyBpbnN0ZWFkIG9mIHNldHRpbmcg
dGhlIHdob2xlIHN0cnVjdHVyZSB0byB6ZXJvPwoKVGhhbmtzLApDaHJpc3RpYW4uCgo+ICAgICAg
ICAgIAo+PiBUaGFua3MsCj4+IENocmlzdGlhbi4KPj4KPj4+IFNpZ25lZC1vZmYtYnk6IENoZW4g
TGkgPGNoZW5saUB1bmlvbnRlY2guY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9jcy5jIHwgNiArKystLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9jcy5jCj4+PiBpbmRleCBmYjczNmVmOWY5YWEuLjA1OTQzMTY4OWMyZCAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKPj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKPj4+IEBAIC05Myw4ICs5Myw4IEBAIHN0YXRpYyBp
bnQgcmFkZW9uX2NzX3BhcnNlcl9yZWxvY3Moc3RydWN0IHJhZGVvbl9jc19wYXJzZXIgKnApCj4+
PiAgICAJcC0+ZG1hX3JlbG9jX2lkeCA9IDA7Cj4+PiAgICAJLyogRklYTUU6IHdlIGFzc3VtZSB0
aGF0IGVhY2ggcmVsb2NzIHVzZSA0IGR3b3JkcyAqLwo+Pj4gICAgCXAtPm5yZWxvY3MgPSBjaHVu
ay0+bGVuZ3RoX2R3IC8gNDsKPj4+IC0JcC0+cmVsb2NzID0ga3ZtYWxsb2NfYXJyYXkocC0+bnJl
bG9jcywgc2l6ZW9mKHN0cnVjdCByYWRlb25fYm9fbGlzdCksCj4+PiAtCQkJR0ZQX0tFUk5FTCB8
IF9fR0ZQX1pFUk8pOwo+Pj4gKwlwLT5yZWxvY3MgPSBrdmNhbGxvYyhwLT5ucmVsb2NzLCBzaXpl
b2Yoc3RydWN0IHJhZGVvbl9ib19saXN0KSwKPj4+ICsJCQlHRlBfS0VSTkVMKTsKPj4+ICAgIAlp
ZiAocC0+cmVsb2NzID09IE5VTEwpIHsKPj4+ICAgIAkJcmV0dXJuIC1FTk9NRU07Cj4+PiAgICAJ
fQo+Pj4gQEAgLTI5OSw3ICsyOTksNyBAQCBpbnQgcmFkZW9uX2NzX3BhcnNlcl9pbml0KHN0cnVj
dCByYWRlb25fY3NfcGFyc2VyICpwLCB2b2lkICpkYXRhKQo+Pj4gICAgCX0KPj4+ICAgIAlwLT5j
c19mbGFncyA9IDA7Cj4+PiAgICAJcC0+bmNodW5rcyA9IGNzLT5udW1fY2h1bmtzOwo+Pj4gLQlw
LT5jaHVua3MgPSBrdm1hbGxvY19hcnJheShwLT5uY2h1bmtzLCBzaXplb2Yoc3RydWN0IHJhZGVv
bl9jc19jaHVuayksIEdGUF9LRVJORUwpOwo+Pj4gKwlwLT5jaHVua3MgPSBrdmNhbGxvYyhwLT5u
Y2h1bmtzLCBzaXplb2Yoc3RydWN0IHJhZGVvbl9jc19jaHVuayksIEdGUF9LRVJORUwpOwo+Pj4g
ICAgCWlmIChwLT5jaHVua3MgPT0gTlVMTCkgewo+Pj4gICAgCQlyZXR1cm4gLUVOT01FTTsKPj4+
ICAgIAl9Cj4+Cj4+Cj4gUmVnYXJkcywKPiAgICBDaGVuIExpCj4KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
