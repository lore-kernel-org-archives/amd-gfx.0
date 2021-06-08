Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32027C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 16:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91CF61278
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 16:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91CF61278
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3B489356;
	Tue,  8 Jun 2021 16:19:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF52789356
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 16:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1Z4tEcS/uZ8XQBM5Q65Zen2ekNN5baY//5vCNaobToGosj5QGazjw1NcwVwAOOTkXt99NlElcylAvpDRo5IBASTYwR9oMQx643LxUeXtxwwNoBFSsZp/NE2hTd/m3tOSoSUfnaBCpYMdN/6t7aYVlUYRBnsdfczASkLBvVzItTYlZZr1BZyc9Xo5gRyu4xl9yWgTUuPbsAe3h6nrQ8Y9/C4E8lAyd7gRnIvBNzFwSvSsvfZBh556WmuEYbEumfwR8AH7pE0I0QP5WKYVlv2XiCOP38xrajJLX1NInRLtJvHgM2z21fSN1l0vuOmtEc6dizjJnPoPXNF/gYLW+yj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB0CX67OwSXnGRZzNDU0BfyVV+0/dBOLjqDAgpqw3Mk=;
 b=hOiIquzP7n5QLiNj2GKR1Bg4viYtyPrPwbTwwIm3vbSfP2C7eum40iG7arHj/VcIQUJf1v0fu4AQOfpOCXBV1ciYBrUH/JPmcYajO6nEZy9gDRucc3Sovx2JuEO/6Nei+ujJB1cvFZEsXDN5nWAXghgIYBslKpou6KLc3UXebN0LWhwUrguT6BCjiYR/ZxxGoiekqYF1S8mtVKcus5Zn9+reVkZIxFGnfvc/W/oqM90rhaD84nJXXSg1ENG3ihCOY8ID2OeJ+THsxDsdVkELmqWuWo4Fqg1bKiaxNDI4wBLmcZDAaljWMyWFBwCgZYa4p+KeF95uLUKi6anq8h9kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB0CX67OwSXnGRZzNDU0BfyVV+0/dBOLjqDAgpqw3Mk=;
 b=yAeRmSX9CEI3c2bzNEsD5EKzbWDnJ0yZ4jAUsgKjgGwBS+JNcOeosR0RLIDZJh6L1yUCw7csSTAl9J14WTeefnvCrEv9E4Y/UpkKCijE22ggbzKfmKUs9UIgbIaz/EJHbiQombOy0jl4Av3XbQJ2yExBaRGFVv0ScYztG56GgnU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 16:19:56 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 16:19:55 +0000
Subject: Re: [PATCH v3 1/1] drm/amdkfd: use allowed domain for vmbo validation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210608130628.71281-1-nirmoy.das@amd.com>
 <c95c8161-4ab2-06be-4fec-92bfb3ee01dd@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d10f0e36-83c9-ef8f-3294-9496e3eda37f@amd.com>
Date: Tue, 8 Jun 2021 12:19:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <c95c8161-4ab2-06be-4fec-92bfb3ee01dd@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.27 via Frontend Transport; Tue, 8 Jun 2021 16:19:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f38eb88a-5161-4da7-b817-08d92a9940df
X-MS-TrafficTypeDiagnostic: BN9PR12MB5244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5244ACFAB76091B3DA241F8E92379@BN9PR12MB5244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/Z38isfEICMNHyEwpukVT8bywWI7/0t1GXUrBqdj1THxNGxltxlR/ujZN+Sjcv/sWe01BGSSvwN02WAFVotgENXTzkjvqtlOSHu5nEO6xrAJwhL2Q/8IDay7NfTbO9nDo5utKlhHtbOeLY5QFyVtJYWG/PK1ehfU2oxhu+6ZpGjM+HuarZtbFAAOHlRhkkJJkco06zFeBd8kkf3v8wsMz2fvKVNaSHgTvtLlmcstI1iv25fkM2Jb4FhTBjNQtSzj0+zXRKJ56Gf4OVxQ7JBfzMR8iDE8vkL2gzxNh85JDxSyyBleQShwgWWHRg+T2pwffp4ck1z6Y0e0DI9v8bMiQOitvK8rLZ0pTuMSnJpYV0sIKDjufH/hUjb688lB5SMjiuYarufs6ErcdFYYT16HMRclpaQKXFxkd2rIlaeBq94h+8xNkLrfnCT/aEU+R8jQ2YgX9IDCN2w8MFDh6W82I5QOQDH/aVYEKl63fC8+rqj8lZfJwSS31TqSY16TbJnwNiZ/ZgUBwSducDAWT5XyX+sFjGItZYq96gYuGLlONcigkWGwoJEJjJwt22slUDwM92dPIdgg2PjFLVaAN9L+qNqtS0B+P46ApxDSPDztL1a2ci/w7xkDtrn+KIaOSs6Vsvq1cHtM4bHG8fQ6Z3DyxFZrSLqHziV1L/BGiE/wdOZEi7Oelx3FOjWELdVSvav
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(26005)(956004)(66556008)(2616005)(8936002)(44832011)(6486002)(8676002)(31696002)(83380400001)(36756003)(66946007)(66476007)(31686004)(186003)(2906002)(86362001)(5660300002)(478600001)(316002)(38100700002)(16526019)(110136005)(16576012)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXdET2VLWE1YeXFOV2pVd0ZSYmZZc0YwY05kbHRHWHBhYnFrTHlwd2dyT3BW?=
 =?utf-8?B?OG80cHdMdnl4aGFTQ1VvaHQ5WGFIdDdDbVV4RmViR2lLSzNpMkY4cmZQVVJQ?=
 =?utf-8?B?R0ZkaTV2S1RiRm4xUWpGaXFTR2l1YXYrcytSdGg3bzZpSG9heHFvSVhzNUhl?=
 =?utf-8?B?eFpnSDhScmhtZmxGUXF6MzVHMUIwRGZVdGJiOHpldGJZR2RVWlUyL2lMTnRw?=
 =?utf-8?B?clcyZGFDVlo3SUgrSElPaGtzR0lrWXk5UmNhMG9UME5jaUM3aUlPRU9OdmJw?=
 =?utf-8?B?eWt6VnZ1Qm1GZll3TjFabDZZcjhveHFVK2RZNkNtcFgxNUJYOHNZSGN5Wi8v?=
 =?utf-8?B?OFQ4a2p5WHAxb0RoZ3NRNkJ5eDdZc3VUcWczYVFGemp6N3l4V3ZpUlNRdGl0?=
 =?utf-8?B?UnNVQzgzZ0c4LzludVpBNkU3am14Ymp4WUVjMkwyT0paU1ZKTmw0NVJNSGZo?=
 =?utf-8?B?YmVyVnJnWEg0bXlxTEZEcGF0ZStBa1g5VEtjdWhuSnRJbnhtc0FCNDAxdVVx?=
 =?utf-8?B?eksxTGkrenY2SnB6a2ZDL0lCM2ZhOHpxSW5kS092THY1TXlLZzhEUFRyMnNy?=
 =?utf-8?B?WWFscndRRm9YRnNSYlhJbWxIaVRtTGU0bUR1cFczcVgyTDBadzhoSGM4WC9j?=
 =?utf-8?B?ZVVLZ0ZqSjhLYk5pVjlabHZ2bHRQQm1GTE9QNys1V0x5WDU4NXh4UVJsQVhy?=
 =?utf-8?B?SVQzeTJsd2ZHMWRSN2IzU2ZCZGo0Rmx1LzBIWUZOeTZFKzJCVHpFWEdBSXFs?=
 =?utf-8?B?b0dFTnZGVE52aUs4ME1UU1E5eVJJNUdGYzgvTXY0WVZld2lBdW8ycmlYYU1j?=
 =?utf-8?B?eXltbW5rbm5ubWpXZHBDdE5WTXRKZHZtSDllSjVEeWJiQ2dKNUVHTTY4UGtC?=
 =?utf-8?B?SXhseEJjYnpBREwzUk9rbDNTQkJUUlRnbFV0eWNJRi9aYWZNbndxdVhadlBa?=
 =?utf-8?B?ZzNRam82VkQxNnhGY2NTWm94c1hiSUFDdUEydi8yM1NxUVdmck5NVlFoQ1RS?=
 =?utf-8?B?TW1IOGpQMVJ1MEQ1TklkZVFxV2dzRzVuazlnMVNka2x3WEpaQU1rT08vRTg3?=
 =?utf-8?B?Y2d2UjFaNTI5WEpqYUxIazI5eGJRUjFYdWhjaHlPKzU2YlZDWUVuNXB0alFB?=
 =?utf-8?B?akZYMG5wenFIeXo0aVJyMUw0ZmZ0bEl2UVllM0M0QzZnQzJidHNrRHN2OTcr?=
 =?utf-8?B?citqeHNhSjAwN2NpYVdMYlpNZEZmcFljdEFubGI0cko0Rk5qOFlCVXNaallR?=
 =?utf-8?B?UGgxNnZBQXRNemlreGNrOVNvaTFaUjUwNlhMOUpXNzRya0UyTDVEdFhoZTVB?=
 =?utf-8?B?bUttRW54akJJdENZQjlzUzJ4MmJOek9sUDExOGtpU2thNEpsaGRSRTdmSTlm?=
 =?utf-8?B?cHpheDdSQ2IyNE52ZmRseDBiNGd5WHNVbEYvWmpHVU5neHA3UnNBR3J0alFy?=
 =?utf-8?B?anZGU1QzeHlKZE52L2xoNm1nYldlQms4MUFsN1VaWnJVckU3T1c0ZHU3RzRP?=
 =?utf-8?B?NlBRbXpiVVBsRXRERDJkQ0dzL3oyTHNHRndSMW1rQXRHZmhXVmFPdDk1VjBR?=
 =?utf-8?B?THdOLzhZS2hLY0JSWnowMDlZUkw2QU5VV28vK1JIU0I1eGEranJVVStZN3Nw?=
 =?utf-8?B?MGxMdEVkdmw0WnR2bjRSUW84NHZSZ1hIUDBCVTl1aTgyTTJMOWdmbkFkZit6?=
 =?utf-8?B?QmJmZW40em5oUktBc2ZhKzhmQ3cva09hNDgyOFFIMForaGV5T1g1UGVNSU4z?=
 =?utf-8?Q?yVsNLVF0ol+V9LlKopShzFq8Gn0VZS/58wWvaKx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38eb88a-5161-4da7-b817-08d92a9940df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 16:19:55.7228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpHG/e6Qxlur777sYpGz33tMIf/06uUovZ4J1nUUbxM76XM+E774vmw/zqeMZRtCtCL5gWCLwRUR3bnVjkkkGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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

QW0gMjAyMS0wNi0wOCB1bSA5OjA4IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDA4LjA2LjIxIHVtIDE1OjA2IHNjaHJpZWIgTmlybW95IERhczoKPj4gRml4ZXMgaGFuZGxpbmcg
d2hlbiBwYWdlIHRhYmxlcyBhcmUgaW4gc3lzdGVtIG1lbW9yeS4KPj4KPj4gdjM6IHJlbW92ZSBz
dHJ1Y3QgYW1kZ3B1X3ZtX3BhcnNlci4KPj4gdjI6IHJlbW92ZSB1bndhbnRlZCB2YXJpYWJsZS4K
Pj4gwqDCoMKgwqAgY2hhbmdlIGFtZGdwdV9hbWRrZmRfdmFsaWRhdGUgaW5zdGVhZCBvZiBhbWRn
cHVfYW1ka2ZkX2JvX3ZhbGlkYXRlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxu
aXJtb3kuZGFzQGFtZC5jb20+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBidXQgRmVsaXgKPiBzaG91bGQgcHJvYmFibHkgdGFrZSBh
IGxvb2sgYXMgd2VsbC4KClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4KClRoYW5rcy4KCgo+Cj4+IC0tLQo+PiDCoCAuLi4vZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uY8KgIHwgMjEgKysrKy0tLS0tLS0tLS0tLS0tLQo+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1
dm0uYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0u
Ywo+PiBpbmRleCBkNmNiN2NmNzY2MjMuLjAxNjgxNWI3YTc3MyAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+PiBAQCAtNDcs
MTIgKzQ3LDYgQEAgc3RhdGljIHN0cnVjdCB7Cj4+IMKgwqDCoMKgwqAgc3BpbmxvY2tfdCBtZW1f
bGltaXRfbG9jazsKPj4gwqAgfSBrZmRfbWVtX2xpbWl0Owo+Pgo+PiAtLyogU3RydWN0IHVzZWQg
Zm9yIGFtZGdwdV9hbWRrZmRfYm9fdmFsaWRhdGUgKi8KPj4gLXN0cnVjdCBhbWRncHVfdm1fcGFy
c2VyIHsKPj4gLcKgwqDCoCB1aW50MzJfdMKgwqDCoMKgwqDCoMKgIGRvbWFpbjsKPj4gLcKgwqDC
oCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3YWl0Owo+PiAtfTsKPj4gLQo+PiDCoCBzdGF0
aWMgY29uc3QgY2hhciAqIGNvbnN0IGRvbWFpbl9iaXRfdG9fc3RyaW5nW10gPSB7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCAiQ1BVIiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgICJHVFQiLAo+PiBAQCAt
MzQ4LDExICszNDIsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9hbWRrZmRfYm9fdmFsaWRhdGUoc3Ry
dWN0Cj4+IGFtZGdwdV9ibyAqYm8sIHVpbnQzMl90IGRvbWFpbiwKPj4gwqDCoMKgwqDCoCByZXR1
cm4gcmV0Owo+PiDCoCB9Cj4+Cj4+IC1zdGF0aWMgaW50IGFtZGdwdV9hbWRrZmRfdmFsaWRhdGUo
dm9pZCAqcGFyYW0sIHN0cnVjdCBhbWRncHVfYm8gKmJvKQo+PiArc3RhdGljIGludCBhbWRncHVf
YW1ka2ZkX3ZhbGlkYXRlX3ZtX2JvKHZvaWQgKl91bnVzZWQsIHN0cnVjdAo+PiBhbWRncHVfYm8g
KmJvKQo+PiDCoCB7Cj4+IC3CoMKgwqAgc3RydWN0IGFtZGdwdV92bV9wYXJzZXIgKnAgPSBwYXJh
bTsKPj4gLQo+PiAtwqDCoMKgIHJldHVybiBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlKGJvLCBw
LT5kb21haW4sIHAtPndhaXQpOwo+PiArwqDCoMKgIHJldHVybiBhbWRncHVfYW1ka2ZkX2JvX3Zh
bGlkYXRlKGJvLCBiby0+YWxsb3dlZF9kb21haW5zLCBmYWxzZSk7Cj4+IMKgIH0KPj4KPj4gwqAg
Lyogdm1fdmFsaWRhdGVfcHRfcGRfYm9zIC0gVmFsaWRhdGUgcGFnZSB0YWJsZSBhbmQgZGlyZWN0
b3J5IEJPcwo+PiBAQCAtMzY2LDIwICszNTgsMTUgQEAgc3RhdGljIGludCB2bV92YWxpZGF0ZV9w
dF9wZF9ib3Moc3RydWN0Cj4+IGFtZGdwdV92bSAqdm0pCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgYW1kZ3B1X2JvICpwZCA9IHZtLT5yb290LmJhc2UuYm87Cj4+IMKgwqDCoMKgwqAgc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYocGQtPnRiby5iZGV2KTsK
Pj4gLcKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3ZtX3BhcnNlciBwYXJhbTsKPj4gwqDCoMKgwqDCoCBp
bnQgcmV0Owo+Pgo+PiAtwqDCoMKgIHBhcmFtLmRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX1ZS
QU07Cj4+IC3CoMKgwqAgcGFyYW0ud2FpdCA9IGZhbHNlOwo+PiAtCj4+IC3CoMKgwqAgcmV0ID0g
YW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcyhhZGV2LCB2bSwgYW1kZ3B1X2FtZGtmZF92YWxpZGF0
ZSwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZwYXJhbSk7Cj4+
ICvCoMKgwqAgcmV0ID0gYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcyhhZGV2LCB2bSwKPj4gYW1k
Z3B1X2FtZGtmZF92YWxpZGF0ZV92bV9ibywgTlVMTCk7Cj4+IMKgwqDCoMKgwqAgaWYgKHJldCkg
ewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJmYWlsZWQgdG8gdmFsaWRhdGUgUFQgQk9z
XG4iKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+IMKgwqDCoMKgwqAgfQo+
Pgo+PiAtwqDCoMKgIHJldCA9IGFtZGdwdV9hbWRrZmRfdmFsaWRhdGUoJnBhcmFtLCBwZCk7Cj4+
ICvCoMKgwqAgcmV0ID0gYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZV92bV9ibyhOVUxMLCBwZCk7Cj4+
IMKgwqDCoMKgwqAgaWYgKHJldCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJmYWls
ZWQgdG8gdmFsaWRhdGUgUERcbiIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsK
Pj4gLS0gCj4+IDIuMzEuMQo+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
