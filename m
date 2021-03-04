Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02555C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9694464E60
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9694464E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7146EA5D;
	Thu,  4 Mar 2021 18:26:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADAA6EA5D
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 18:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k00beeuhs9Zx8mN8Q2LnO87UjVBkcrE7w51uvHtLVvXfqdm1iEqTH21RuUl42h6qMD8Tsmf4WTOFjtrlN9vpXhiC3Lln7DiEdiwstFg+w9OQR0+NYPXoSM4uKFUjdasnfq9VWIy8gwL85reoxWpranerT5IfgaPLfi7D4yFCYtRXRPkq6zl66TuIHjXnUVUdB4JzrRkWzd375/jXOBaxln0/nKzdHEb+PI04BEyPixvsPa0gnO1mtv7TvpXcIuApkHCuL/oSEB5TX9Z/NoGaUmltcES6PnvlWqTCvc29zj9u1rfqfqUFkQExmVXQ4E7iDxMVDR17FipBV9dB8GOeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm+gaZ/xnvGQMaWd5q9w2wK8ug7+GzbCT/jpUbuZvU8=;
 b=VzTbscv8yBnfr2k8KpVPvo6blRwu0MUmYYs3LAx66PGjDb+4z+wH3MwwFX2k3ubgFe8YskSLl3b9a2hfwFApRYxLGNuDY3LuGcVJJ5Bihv76FQNGf6AeL0ih0Li/xiTC5bv5T6aAdOBnAw+n5KqkeSklm2gdkFBVDSMpZyCukXyyIkR4tfV2LCjQfdWh9OF3XzequLdeW/YZ/ZXCAHRtW7j7961jLgFKzyx/qLbH46z7j6McRO+n8IA/M78JrdHGeU7TnF/awQprLiqVF+wsaQKz6wV7X3ZprLuQpM7b8kH/ZvptncQwC53DtQg7QqT7vjQCgMjCWDvZhQAVvkZGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm+gaZ/xnvGQMaWd5q9w2wK8ug7+GzbCT/jpUbuZvU8=;
 b=CXy+2LzmWyE62zhzb8mAlQpiUtsx+6cFe78LsaYJRT9mwii40+VGDhftk0006i9C++eoMnM+ZW0wtcOTwfJ60biNgaq7pq29Bv+J76CnPJV6aM9nkVmE0dzMxovATDg8Su3AMuGWr5xe5M6IonDm4ayEPLyYA33OVSEiE09xrEU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 18:26:31 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::4d9b:6989:13f2:e4f8]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::4d9b:6989:13f2:e4f8%3]) with mapi id 15.20.3890.031; Thu, 4 Mar 2021
 18:26:31 +0000
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Daniel Vetter <daniel@ffwll.ch>
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
 <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
 <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
 <e7661e4b-a99c-5be7-9912-421ac3e61ff0@daenzer.net>
 <94a2e9cd-8a14-984d-71a7-3671d7c352ab@amd.com>
 <5d62d002-faa4-ea6b-c55e-2b297e8e1b5c@daenzer.net>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <19062958-ff28-0f1e-d891-9c030a88ecb0@amd.com>
Date: Thu, 4 Mar 2021 13:26:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <5d62d002-faa4-ea6b-c55e-2b297e8e1b5c@daenzer.net>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::13) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.19.251] (165.204.54.211) by
 YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.24 via Frontend Transport; Thu, 4 Mar 2021 18:26:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77c726f9-997d-4d68-73ad-08d8df3b0849
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31447A5C2203A4897BAC821AEC979@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKTvAlbf3rLpBbVoAh18mPjxP0WxTqg1ibbLQ5gZ3aAa9xk3NXMC9Rrpb1sR10S9IQflVkIJvE/G17so2eblEyxLNTW9EVGaVGyT8PTQlwDQXbfzjj8xzQLCytrAlgpoFcWl4L99wEg66u2WvB5mXUxFDYc3uoTdiReQ1NdCmLSm7KwT4fmvBGTOZOT0mRAn0IYwwiGGfRAEpP7WTzKaFpXsMq5gOG0XL/2ZcqL1nYlpZQGPwkKD01FZ92Ya8fxpykyBorNYa12FSa/naC2LGiNE0bfb6nyqaIcZC+gaotJyaH9fQOgtmxSSmfnfklMBtKvXMcc3+/Evj3yxxTr5ctqpV5b+F7w1YW70Yv7s7ZG99AirLiJS5Q7wj4LIff0RxT3/WkUr8yTgiVohuZblmiPq1mqQrJJO7k8z3AzUg+io/mF1Na6nKo+jmS/43ttLdW1OKL3wHA+kTyxya5WZvPvl/oHgDmQPR519mA6EPkNCNNuYusbWYPr+TK8HDmRsFWElg353Ei6dpEAEzUjNV6JPC2+4oKcI1xeF5gneUNngy1wwqzcEF9OYqVi8Ri/ehxX+AtP7eFqJ9WEZ2NFMgvp81xgeSI7OZp1rORHDdns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(66556008)(2906002)(6486002)(66476007)(83380400001)(66574015)(8936002)(8676002)(5660300002)(2616005)(956004)(66946007)(4326008)(36756003)(110136005)(16526019)(31696002)(86362001)(478600001)(186003)(26005)(31686004)(316002)(52116002)(54906003)(53546011)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dmFobkVtRk1CaC9KYU45OXBlcmdDeWZUbVNXdzZuWmxnRDA3RmI2bk0yTnBK?=
 =?utf-8?B?dDhXbzc0cysySTgwSVRkZXVRTmZLRHNVSHp2TjhTbElpN0hnVllkZDV4Vzl4?=
 =?utf-8?B?UEdjZmNLMmkwK2Y4eS80NHpHMVJ3aDBzalRMQlpJbmZuTVk2OUxSZENsVklF?=
 =?utf-8?B?RzN5aW5oZndYUUQ2OUxTUC80dHhoTW91UGhjMkRTYXd5Mm9KaTJqVmo0dHBN?=
 =?utf-8?B?ZktFdkZPSUhuL3VuWUNjby9tNkZZVy92RnpYMlNRMEZPV04rU1FtWUREaGIw?=
 =?utf-8?B?VlRFWGZPWTJ4Y3ppTDhBZ1pIajl2dmtRTk1ZUVg5MW42UWEzbVEwTkU0SGtD?=
 =?utf-8?B?Z3JEWDlwQWlmTjZvWUNhTlZQVnIxNDhUNFQ1S0htSGFQekhzeUFpWlQvR3Zy?=
 =?utf-8?B?TFAwZU5HeXZMSW5hZ0VRWXgwMzl4Y3FQUkNKWG41emRERm02RURBZ0pVcnhy?=
 =?utf-8?B?bTRDMnptQTV1M3lQd2JUbG5oaUI1Z3ZReUpudTZGNGtFeWkwc3UxRFJrVE45?=
 =?utf-8?B?QVo4c3h0TFZTbzZCTUpsOU0wUlBSNzZBTkJLdElOMFM5akEyVzVxSlhvZkVh?=
 =?utf-8?B?RTFMdTRxaURsdWg5dnhPQzBsWERnei9jK2hQaGN2QWE5Sno4ei85MnozMXh4?=
 =?utf-8?B?TzNvdVdWMmJrdVFBRzJjL1dVcXlGdDJXa2EwMXdWUDlRMzh6UDBGR0w5dGc2?=
 =?utf-8?B?MnNMMlZFbmVDZWp2L3Ywdlg5TTR2SlMvbFBEN2RaMUNGT00rYnYyZWhCL0Yz?=
 =?utf-8?B?LzJoSnE2ZjdTVStiWk5BODRndWd2ZFBQZ29XcG5zYnJyMmZTeWRXc2dOekdi?=
 =?utf-8?B?bitJRkxHd21KbHJTS0ZjZE5Lbk1wTHMvOHhpb1BsejB2NXZVMzJrQjJPTG9X?=
 =?utf-8?B?aEFIVXdMUG13cE5vc0Nic3RwS3A5UE9qR1F3eEVzclpRODdjd251dkNxb0JE?=
 =?utf-8?B?Y002RlgybkRyMnMxVU5NTXFlRWRVYVU2TXFmZFp1aGt4bGxQVmJ1Y3Frelpp?=
 =?utf-8?B?WWtiaTdFcDR0MWVRNHZHclJXVjk4ZEtuNWpyV0hMdDNjb2xUU2poeCtoOUEw?=
 =?utf-8?B?T0pBTStqTEpjL0dZM0tvQWRLOXFZVHo1TW1USUVEdHFOTEl3NnVabDYrV2NL?=
 =?utf-8?B?S0hJQnIrR1dlTWFCZ0krZnZkdVlOYTBWSWlLZFlGY2RwNnhHRTFOSGRDRS9H?=
 =?utf-8?B?Nkd5U2ViTHdpbklGWnEwbnNyVUxWN3cvb0g4VWxwYkZ5RzV4STNqWXBlNGFZ?=
 =?utf-8?B?a2JjTFJLNlFDU3QraTQ0bjNBa1dJRVF0bmI4YkR5b2cyT3lNZm1SQVQvUjd3?=
 =?utf-8?B?aUQvMGFZL1NCWm9iN1EzVjMxL3ovdUo5c1V3OXo1WUNxWmc5ZG1Yd3FWY2di?=
 =?utf-8?B?QndDcjZCRkxOYXFaYzVoS0MyV3lLMjdkVExBUnJxTzhMdDkxRGZ4N21sSFdo?=
 =?utf-8?B?aU40b2tqSVZzZGtTQ1puOGpJdFBVbDBmeGtGdkhaeEQ4cmppaE84S0F3a244?=
 =?utf-8?B?MUNjQy9OTGl2WmFoTjZDYWt2ZGVaZ3RIdnp1S2lhQmpDZ2gzYzNVbDZsWTVM?=
 =?utf-8?B?NkpZMSt2VUhiYzNkL1BtajFSWXduUHZycHBWQnlpV0VTNGd5VVZvVlQrK0My?=
 =?utf-8?B?Zmp6T2Q1a3pIa2RjQXZWQXhSQUJVdEIyb252SytOc2V3OWJRUzByeFBXaFU5?=
 =?utf-8?B?TWNxbXNScHRLVDFLbTY4WmxuL2xQYkVBUDJjWjZHbkRCN212UVZmZFhtTGlT?=
 =?utf-8?Q?MhmTQdSzvFU0XCwzwib/GTcGl8nib+cDLVxkRdd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c726f9-997d-4d68-73ad-08d8df3b0849
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 18:26:30.9330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns64+5aUCpwxcWPb94W+en0vokBv9HBbZsj87HIf5eIWdARmfss+V/tR3pM8K7H/dqmqCACdUtYy70xI8uuPYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <hwentlan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0wNCAxMDozNSBhLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDIx
LTAzLTA0IDQ6MDkgcC5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4+IE9uIDIwMjEt
MDMtMDQgNDowNSBhLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4+IE9uIDIwMjEtMDMtMDMg
ODoxNyBwLm0uLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+Pj4+IE9uIFdlZCwgTWFyIDMsIDIwMjEg
YXQgNTo1MyBQTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPj4+
Pj4KPj4+Pj4gTW9yZW92ZXIsIGluIHRoZSBzYW1lIHNjZW5hcmlvIHBsdXMgYW4gb3ZlcmxheSBw
bGFuZSBlbmFibGVkIHdpdGggYQo+Pj4+PiBIVyBjdXJzb3IgY29tcGF0aWJsZSBmb3JtYXQsIGlm
IHRoZSBGQiBib3VuZCB0byB0aGUgb3ZlcmxheSBwbGFuZSBpcwo+Pj4+PiBkZXN0cm95ZWQsIHRo
ZSBjb21tb24gRFJNIGNvZGUgd2lsbCBhdHRlbXB0IHRvIGRpc2FibGUgdGhlIG92ZXJsYXkKPj4+
Pj4gcGxhbmUsIGJ1dCBkbV9jaGVja19jcnRjX2N1cnNvciB3aWxsIHJlamVjdCB0aGF0IG5vdy4g
SSBjYW4ndCByZW1lbWJlcgo+Pj4+PiBleGFjdGx5IHdoYXQgdGhlIHJlc3VsdCBpcywgYnV0IEFG
QUlSIGl0J3Mgbm90IHByZXR0eS4KPj4+Pgo+Pj4+IENSVEMgZ2V0cyBkaXNhYmxlZCBpbnN0ZWFk
LiBUaGF0J3Mgd2h5IHdlIHdlbnQgd2l0aCB0aGUgImFsd2F5cwo+Pj4+IHJlcXVpcmUgcHJpbWFy
eSBwbGFuZSIgaGFjay4gSSB0aGluayB0aGUgb25seSBzb2x1dGlvbiBoZXJlIHdvdWxkIGJlCj4+
Pj4gdG8gZW5hYmxlIHRoZSBwcmltYXJ5IHBsYW5lIChidXQgbm90IGluIHVzZXJzcGFjZS12aXNp
YmxlIHN0YXRlLCBzbwo+Pj4+IHRoaXMgbmVlZHMgdG8gYmUgZG9uZSBpbiB0aGUgZGMgZGVyaXZl
ZCBzdGF0ZSBvYmplY3RzIG9ubHkpIHRoYXQgc2NhbnMKPj4+PiBvdXQgYmxhY2sgYW55IHRpbWUg
d2UncmUgaW4gc3VjaCBhIHNpdHVhdGlvbiB3aXRoIGN1cnNvciB3aXRoIG5vCj4+Pj4gcGxhbmVz
Lgo+Pj4KPj4+IFRoaXMgaXMgYWJvdXQgYSBzY2VuYXJpbyBkZXNjcmliZWQgYnkgTmljaG9sYXMg
ZWFybGllcjoKPj4+Cj4+PiBDdXJzb3IgUGxhbmUgLSBBUkdCODg4OAo+Pj4KPj4+IE92ZXJsYXkg
UGxhbmUgLSBBUkdCODg4OCBEZXNrdG9wL1VJIHdpdGggY3V0b3V0IGZvciB2aWRlbwo+Pj4KPj4+
IFByaW1hcnkgUGxhbmUgLSBOVjEyIHZpZGVvCj4+Pgo+Pj4gQW5kIGRlc3Ryb3lpbmcgdGhlIEZC
IGJvdW5kIHRvIHRoZSBvdmVybGF5IHBsYW5lLiBUaGUgZmFsbGJhY2sgdG8gZGlzYWJsZQo+Pj4g
dGhlIENSVEMgaW4gYXRvbWljX3JlbW92ZV9mYiBvbmx5IGtpY2tzIGluIGZvciB0aGUgcHJpbWFy
eSBwbGFuZSwgc28gaXQKPj4+IHdvdWxkbid0IGluIHRoaXMgY2FzZSBhbmQgd291bGQgZmFpbC4g
V2hpY2ggd291bGQgaW4gdHVybiB0cmlnZ2VyIHRoZQo+Pj4gV0FSTiBpbiBkcm1fZnJhbWVidWZm
ZXJfcmVtb3ZlIChhbmQgbGVhdmUgdGhlIG92ZXJsYXkgcGxhbmUgc2Nhbm5pbmcgb3V0Cj4+PiBm
cm9tIGZyZWVkIG1lbW9yeT8pLgo+Pj4KPj4+Cj4+PiBUaGUgY2xlYW5lc3Qgc29sdXRpb24gbWln
aHQgYmUgbm90IHRvIGFsbG93IGFueSBmb3JtYXRzIGluY29tcGF0aWJsZSB3aXRoCj4+PiB0aGUg
SFcgY3Vyc29yIGZvciB0aGUgcHJpbWFyeSBwbGFuZS4KPj4KPj4gTGVnYWN5IFggdXNlcnNwYWNl
IGRvZXNuJ3QgdXNlIG92ZXJsYXlzIGJ1dCBDaHJvbWUgT1MgZG9lcy4KPj4KPj4gVGhpcyB3b3Vs
ZCByZWdyZXNzIENocm9tZU9TIE1QTyBzdXBwb3J0IGJlY2F1c2UgaXQgcmVsaWVzIG9uIHRoZSBO
VjEyCj4+IHZpZGVvIHBsYW5lIGJlaW5nIG9uIHRoZSBib3R0b20uCj4gCj4gQ291bGQgaXQgdXNl
IHRoZSBOVjEyIG92ZXJsYXkgcGxhbmUgYmVsb3cgdGhlIEFSR0IgcHJpbWFyeSBwbGFuZT8KClBs
YW5lIG9yZGVyaW5nIHdhcyBwcmV2aW91c2x5IHVuZGVmaW5lZCBpbiBEUk0gc28gd2UgaGF2ZSB1
c2Vyc3BhY2UgdGhhdCAKYXNzdW1lcyBvdmVybGF5cyBhcmUgb24gdG9wLgoKVG9kYXkgd2UgaGF2
ZSB0aGUgei1vcmRlciBwcm9wZXJ0eSBpbiBEUk0gdGhhdCBkZWZpbmVzIHdoZXJlIGl0IGlzIGlu
IAp0aGUgc3RhY2ssIHNvIHRlY2huaWNhbGx5IGl0IGNvdWxkIGJ1dCB3ZSdkIGFsc28gYmUgcmVn
cmVzc2luZyBleGlzdGluZyAKYmVoYXZpb3Igb24gQ2hyb21lIE9TIHRvZGF5LgoKPiAKPiAKPj4g
V2hlbiBDaHJvbWVPUyBkaXNhYmxlcyBNUE8gaXQgZG9lc24ndCBkbyBpdCBwbGFuZSBieSBwbGFu
ZSwgaXQgZG9lcyBpdAo+PiBpbiBvbmUgZ28gZnJvbSBOVjEyK0FSR0I4ODg4IC0+IEFSR0I4ODg4
OC4KPiAKPiBFdmVuIHNvLCB3ZSBjYW5ub3QgZXhwZWN0IGFsbCB1c2VyIHNwYWNlIHRvIGRvIHRo
ZSBzYW1lLCBhbmQgd2UgY2Fubm90Cj4gYWxsb3cgYW55IHVzZXIgc3BhY2UgdG8gdHJpZ2dlciBh
IFdBUk4gYW5kIHNjYW5vdXQgZnJvbSBmcmVlZCBtZW1vcnkuCj4gCj4KClRoZSBXQVJOIGRvZXNu
J3QgdHJpZ2dlciBiZWNhdXNlIHRoZXJlJ3Mgc3RpbGwgYSByZWZlcmVuY2Ugb24gdGhlIEZCIC0g
CnRoZSByZWZlcmVuY2UgaGVsZCBieSBEUk0gc2luY2UgaXQncyBzdGlsbCBzY2FubmluZyBvdXQg
dGhlIG92ZXJsYXkuIApVc2Vyc3BhY2UgY2FuJ3QgcmVjbGFpbSB0aGlzIG1lbW9yeSB3aXRoIGFu
b3RoZXIgYnVmZmVyIGFsbG9jYXRpb24gCmJlY2F1c2UgaXQncyBzdGlsbCBpbiB1c2UuCgpJdCdz
IGEgbGl0dGxlIG9kZCB0aGF0IGEgZGlzYWJsZSBjb21taXQgY2FuIGZhaWwsIGJ1dCBJIGRvbid0
IHRoaW5rIAp0aGVyZSdzIGFueXRoaW5nIGluIERSTSBjb3JlIHRoYXQgc3BlY2lmaWVzIHRoYXQg
dGhpcyBjYW4ndCBoYXBwZW4gZm9yIApwbGFuZXMuCgpSZWdhcmRzLApOaWNob2xhcyBLYXpsYXVz
a2FzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
