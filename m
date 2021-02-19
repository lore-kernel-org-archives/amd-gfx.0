Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B49C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 07:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D60E64EAF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 07:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D60E64EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D6A6EAAC;
	Fri, 19 Feb 2021 07:46:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7FD6EAAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 07:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4sQhsYiVdoXcFq+SfftUBwInawDsJFyFZpVWXYDXlfUK4Vv5kWACGr/pbkpCaVNL5oqoCiILDA+F2jXtdRlfyn6Zqp41q6g7smxktMtvBOutBg8hXz8J7UL9ODWgamkumDqEv2CxbOrAaHvBrm12L4xUKvNZGaOcqNbZNnlw1GAGs6h+0zwgfeGQ/OQMMC7PWHuHKVpqF+k5MlKt7nNt8kFQUFYX1TUZfsNTvXCbdn5GSPk1Bn7ZWXATUg52MSTZ+segpVFWaGzsdMBkT4pZVPS9NBTPynuQpdjKC/5rN6hXBDYJ5fXUpI9ltc5CQaKaARKk6knYUreFdqwZyPpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLMEkML+tCVWzE1rKQjTfZsvUzCmf6A4eslVFWNwx1U=;
 b=RjB5/kb183GOaEzEhWWVeKpEMpvIWrcG46Bt02xNEfhytGXLbWJtgSbU57vrNvAzaBFV7najOGsnw/rJHiC5zZhjK9Jroy7BfUn3nFfo3eoXHswaElNxRgvjEaaqw50fmI2jeCtRS0HSg0yCabGpVfY+qr6TfZGnMHEDipCYGlC/Kmm3iNTd9mFh6fxD8ZLU6M9RDt18MquMEamzRGNUofrg8pz2gNw3zJPAY9bopzjUXHk9yZtr+f3AT9JlcJvkJTFUDizJD5rm5CmP9ImUwaH+SXakEt/8cckspM4IiVKCrfnHDRJUThu+25gHYQLsVEN4bbxianmFhxLOLApFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLMEkML+tCVWzE1rKQjTfZsvUzCmf6A4eslVFWNwx1U=;
 b=HYLcGlyQ0OAIyBMBpojt+izcFzao6+nhEQzr2AOzfGGLXxNf4EflMdh6cu/fdQWKPIDxLwH2deKS+ga48INlpAYgaPUjyk/92tzHeqdF+wMPFeKeakcaywYL1/TvTSFJVMJe2Dg0vHxZU5Q86qztQfvxhWnG+YgvCy1kYhE5+uA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 19 Feb
 2021 07:46:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3846.038; Fri, 19 Feb 2021
 07:46:18 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: remove unused variable from struct
 amdgpu_bo
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210218170636.91372-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e5e09617-93b9-24c1-0b0e-b7f96b26a89c@amd.com>
Date: Fri, 19 Feb 2021 08:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210218170636.91372-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:cf49:9fdd:8d2e:b941]
X-ClientProxiedBy: AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:cf49:9fdd:8d2e:b941]
 (2a02:908:1252:fb60:cf49:9fdd:8d2e:b941) by
 AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 07:46:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e23200b-2029-4c55-90d9-08d8d4aa715a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB455127C5348AF4172133132F83849@MN2PR12MB4551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPRvUPQd9RW4kgEjaRbZjq7QISJ5wxI62m/42YMDPTAHTzopznU4cJECzQSqMQQUKSGD/Tnixa4xiVdxYmDlKGdes/Ncj9Vi0ohbR6wbpCvB6YH8GBSxRtPgMFiDGDyf8moZBz1x3c6LKy48W90aZp0RUGCtVnVV0mhKIfqfmqX6BPzLAYE/aiKESBAOfTJcJcTmEH7eh761WnbeT12lVcfs6hoLUqjLAQQA3Txkq6q9Y1t+VITwUuusOqYFd6QE4s0ulq6DHta0CUQG/5byu/u06kd7ZSfm2+8SUf9yjSGWXXDRz8fZYYRtF8ShIFsf0S54dgE2WslNm37EV749YPeb8GcPQpNTSihexy7XXHbnbzXOoqVFENB6U6neGD4oC02n3LM0H6TZnJZausI8yGIsAtNTazAP0bV0WAd618m0iVGtaI8ZZX6yiP6IXsTzmYTc0RqMuvT3D6aj/qmc9McIHESIxoHoCh0KvedVXtur639wYyYtu52u7yCCdIjNGqiGTo7IPGhpWjZoiRJUNOwCYGqUhPIXH19HkWs6tHqzn6p2Oqw+/TPdurJ039kTZqt0OmZd2XsdtjhOPnrf7X7K2AsfS50eu+NeZzubd4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(186003)(86362001)(8936002)(478600001)(66946007)(31686004)(2616005)(5660300002)(16526019)(52116002)(66556008)(66574015)(36756003)(83380400001)(31696002)(37006003)(8676002)(2906002)(4744005)(6666004)(6636002)(4326008)(316002)(6862004)(66476007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TURSS2YrRlQxWnFlWTZ4RVBQQkY2OS91NGUvcWx6RXFoS0ozZWtaYTZ5ak5X?=
 =?utf-8?B?L3BRU3NCWmhlS0lPOXRYRVRIM1dOU3F0MTM5MFJRWERQZlE2VHdPRWVBVEpy?=
 =?utf-8?B?aXd0SWUxZE40Qmc2TnFBN3BoYk9uK3FBWmVvbjRrQmNDZUpqbThyaVBtUFVw?=
 =?utf-8?B?TDJSU0hkVFpqRUxWdjlxQUFGNDZPdEpidlAwQ3VHcS9MUlpRODlLdk12U3hy?=
 =?utf-8?B?MmRhOG9NdGlCMWdoSWh2RUoxZFBudjJVaU1qMkFxeDZoa3UrdXZDMDJ2Z0hS?=
 =?utf-8?B?SEx3NVc2MWorK0NoR1dlaHpMWTZQV3dRWkR1SW5MMFMxNnRjTmxXazY2V3NS?=
 =?utf-8?B?UGtHaXlIZDFIUUtUS1dTZVZsWk5TZE5oWHFLTEVuc3BhaXd5blE1TWhrV1ZG?=
 =?utf-8?B?ekV4VzNaRHNsbEt0SE5oTGlpbnA0VkduY0ZIVE5oaGRIbUFPWEhJMWV4Umwy?=
 =?utf-8?B?UmVrNFhodDRDS0hTbnYydzdOYjhTU3ArbmV4QWE2OTdpVk01QnlIQ1UxNG5v?=
 =?utf-8?B?WWxERjlDdmNmYUdNd0pWN3ZOUmhPanBvak95cEozODF1ZktPUkF5SkZ1MDNt?=
 =?utf-8?B?bXpBRkh4WUp1bHNPMXZmZmJmWVhNZHI2UWRzQ2ZxNmE5STAvdDJTVEtsNnVr?=
 =?utf-8?B?MzVnQlQ1UWpwMGlPNDJrN3hWcVVNdVdmWHQzMmZyS2trV1h6OW9GcTRWNjVt?=
 =?utf-8?B?Q3d0VzBaemxjQTFZVGplMTZibXR1K01jV0t1UzUwWFlLOWZNdjlDZVNEb1FY?=
 =?utf-8?B?SmUwU1VLSzd2MFBqQUFxN09VWWQySUZvelZQUmZBOHpNZVNTbTZTMktpUk8r?=
 =?utf-8?B?RXNsTUtOMXpjd29qVWtxcXd5K1FVd09JR3BKaFE0U2FCK1VmdzA3algxa29T?=
 =?utf-8?B?bXJWVCtjUTlnaExUSlN3RFZydXQzVE5RMGc1WnlGanhPTklnZVlXQVg0TWxR?=
 =?utf-8?B?TnA2aTQ1U2Y2WlBncFpNWFg2Zkd5TlcvazZSZENyalNiSUZncGg2NUsrYWpi?=
 =?utf-8?B?ZE5UT2JhanRxZTB6Skx3bU53STBWd2U3MUVyNXZlUzBRYVRzd21HVXdrM3Vv?=
 =?utf-8?B?d0l3eUtFVStFYnVqMEt5THE0Y3BRdlhTZ3FJbUtZemhOT0Fsd042Qk9xWVFh?=
 =?utf-8?B?aktTL2NXbGhmM2MwR2ZZTUQ4Tmlwc2dGRXlZTnVVck82dTFDQ0dFeHRsMGJE?=
 =?utf-8?B?RExMc2MxVmx2QnBtNUtFV2hHc2wwaHFNbEF4VkxzSU11NlNNZkN6OFo3aEVp?=
 =?utf-8?B?dytMaW1DcHY4c1VhZHhlNEloem1oVWFYMm1xQ1A5cnUxK0dtUXJtampLNUFR?=
 =?utf-8?B?RE5HOGc1S0dRRHlFN1k0N2pGTk5RWjBYQWlOaDhyOE9UOG1qQnRvbm1ya0d4?=
 =?utf-8?B?a1VLVnR2cnFhaVZLTVlIcCs1MkdSdWp6dlBJWDJyeDRRdlRPSndzbklNSlpY?=
 =?utf-8?B?QTNKcWZWRG5aWnpTYlBhanZHdmxnYUxLcFNJRFluUng4aXc0bHJNMUEybll6?=
 =?utf-8?B?d3ptZkF6Q2hDbnhXTnkyOS9kRXMzQzRJbThTWER4bGF0R1VHbm9KOGFqbzhW?=
 =?utf-8?B?cU9RaGhqY0R2RldWOVBXSWw1aFovNzFxUE51dStDWmplZVZxRm5hNHZjNDgz?=
 =?utf-8?B?YjZnK2dOaVV4VEVlckxiN3oyV3NBYWpMRWI5czFwTkJCcElkQVpLT2RyTEVI?=
 =?utf-8?B?c1JlandiRWIzbFRoV3FSZ3lhamZCakFnTWFvYVhLTVV3MGN4KzhMbVdyaURB?=
 =?utf-8?B?MWtwdm1IYU5MNEQ0a0c3emt0NWhmeUJYWFNDMzdiOTVTd1JFQWJtdWhCaTg3?=
 =?utf-8?B?T3RFQ2NKUExDNkhOaTRweVdDMkc3eVdURjRzNk14cWpjQmRnTlM4dGU3V203?=
 =?utf-8?Q?I6JgTbj/xIfB1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e23200b-2029-4c55-90d9-08d8d4aa715a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 07:46:18.6593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oq524FVre2SPUGCbqlG6jULC4MGSRc32T3QsuHJZ2HzuLW+JIlLibse4tZRjf8Q9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDIuMjEgdW0gMTg6MDYgc2NocmllYiBOaXJtb3kgRGFzOgo+IEZpeGVzOiA2MjkxNGE5
OWRlZTVhKCJkcm0vYW1kZ3B1OiBVc2UgbW11X2ludGVydmFsX2luc2VydCBpbnN0ZWFkIG9mIGht
bV9taXJyb3IiKQo+Cj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQu
Y29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmggfCAxIC0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCj4gaW5kZXggMTkyNjI3ZDM1YmFlLi44
Y2Q5NmM5MzMwZGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5oCj4gQEAgLTEwMiw3ICsxMDIsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2JvIHsKPiAgIAlzdHJ1
Y3QgYW1kZ3B1X2JvCQkqc2hhZG93Owo+ICAgCj4gICAJc3RydWN0IHR0bV9ib19rbWFwX29iagkJ
ZG1hX2J1Zl92bWFwOwo+IC0Jc3RydWN0IGFtZGdwdV9tbgkJKm1uOwo+ICAgCj4gICAKPiAgICNp
ZmRlZiBDT05GSUdfTU1VX05PVElGSUVSCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
