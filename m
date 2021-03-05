Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE05C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BBC64F27
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BBC64F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E396EB53;
	Fri,  5 Mar 2021 15:19:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA5E6EB58
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrYnZEBOO29nRwi2z6xmCyThocsNpm+bqkmjkoAG7Dn4XmHP149/Rr8ry2loAkSFp+nviGA9sal+q5CWpo3ZuMpdc7ACoYn7efJebSTHEg53bEitaLM3S1aBqGXdISVwJHqtm3ip9i/KnhA7VUSnx8sQpib949+Yw8OAXc/cqEFS12B0hIz/9671L4D00WbFZGOdqEXOS44XtFHtIP46uowAtuYLNU4ZClhRR9VbtH0XoxqzSeobBJCO5Z066l9mqLl8ou9knduLp+YLSGPWW8MCxRf/eM+3Cox/bLOxjkqfdMLynGMmApSNq0vbks46+nwEADvBM3XV27wW8lwpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QarC1kOtvXjk1rCqcScw9OoIWNjJdBn+aJ9hZ9nCoN8=;
 b=BFelc2B+YUz3qVrg8OxJalcyq6EF8AfmXsjtooH8clesYZnOfCDRD8emoPBrjFgFH26/Nd68KhHAntChUtsP2VqjvVI1BviTCkdKV4Y6nF0qdBcxKf16wU7/nrOpo/h4B1I5Ua8s1OjXG3k7uHaG//pUPHltWig65JraVVEtWqPosYcJ6NdvCInxFj42nE8EOGYPIwTRJLgpcce6MApf2Iat/n7QL3ugz8QAVj3G8rcB7SZ5V159k0Mk6+dqNYjpqywuq0ZdHzKCcfpRgJgZS3M5/NpiV9dLZeVeEx97sXZZWZBFptncYWh9BlsFgMsUqc6jENGnyJHeTrsWwCJqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QarC1kOtvXjk1rCqcScw9OoIWNjJdBn+aJ9hZ9nCoN8=;
 b=dg1gIa5ZHO0LkuvQoSHNKPW8tAYru19cLTFKBSiaX3APJ6+JWi2UD0UCFBNy4qpKMbYBxFm6CeWSj+adm4bdFoE9wnerkV+/QhZMR4zPHyX6oAXMsIOyfaLMF119ylq3qH0rH9HDhonZHEVAOOM14N8YJE+ltWwtD28k7pgyUhw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1208.namprd12.prod.outlook.com (2603:10b6:903:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 15:19:41 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 15:19:41 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <015f2823-e03f-1cc0-6b9f-4c6109225863@gmail.com>
 <5f17b6b0-15b6-bcfc-9576-6d5c8ee70f0f@amd.com>
 <e88ca8f6-971b-caaf-a967-0554008baaf4@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <42572b8c-6a6a-6520-a680-1b712f57ba57@amd.com>
Date: Fri, 5 Mar 2021 16:19:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <e88ca8f6-971b-caaf-a967-0554008baaf4@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: AM0PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:208:1::23) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.122.77) by
 AM0PR04CA0046.eurprd04.prod.outlook.com (2603:10a6:208:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 15:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 242f5013-3ed9-4691-92e3-08d8dfea1900
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1208D75415A32DC55AC7AA488B969@CY4PR12MB1208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsgANUAZ5EeSBC+37Hu78EX0bALcjM8KW/3V3qRpHy2Vr1FiVAQNr6GPvKTW6J8rteJfKIWEldlNf/TNgreSxixSoaCZrLlpAk3cnPe1ZgIupbRhIcagZdZxYfZnb9v4puLL+5jhlezGdmDm7kpV1nCyOXdd0VKh638kfY6UFJhQDc0Qq7iq4WykgJk6PSxogUx3h9fclIArQS8BUL7OaPdWrLbI6RsMGs31RiB2DSbCyNB6mOwh7UxEXRxY5lx+jz/tJoQCxXGW8Lk+sR4VwNsJ7cIBOGVWng+QHiJhyNNQLDHR31ff+gg4ON4QvJd7dsw+kWUs401BoE8LRHm5mNTmJvoSrDR0tuV+DIL2rXThGE4EjYBWcNQWfYI6W7sO4ZbKqQp8EWZGHxvBUukz/uSRWJx4ZNSQ/R/8RTJSIwscSoT0B/LM7/75fTRvIgOZ3AkJ3QcPAqXfwIbaKgD/qNFHimG1TEoC0Dxe+15qTaK8AP9ZbLEBC7fQ5ghWfpkVwRAqv29adDK1H9bbN+EqX1UNvPKi3bjASKySmVCbjd8Ee56OKZCkUhNHIDAkjfLdWC7HbV7ehM220v+TtAroFiRoPlNpRiMWt1npAJcWmRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(6486002)(5660300002)(52116002)(6666004)(110136005)(8676002)(6636002)(66946007)(316002)(66556008)(66476007)(16576012)(478600001)(31696002)(956004)(2616005)(186003)(36756003)(26005)(4326008)(31686004)(2906002)(8936002)(53546011)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SG9jdFRBSHkzWE04Mmk0WnVQMFRCTHEwVmxHU0hXWm5vMDJFakVnbENqTnhD?=
 =?utf-8?B?a0c5d1U2ZS81eFRkVGVIK3NKQ005VzhZdERtd2FmQzNCRUlnWW4yeEhKOTht?=
 =?utf-8?B?VnVIMGhubDZiWHA2Wk8vSUtCUzhPNC9PUkFGYkg4L01LSUtsRHFodWljTW1l?=
 =?utf-8?B?MURteUY5STJJQy9lZFdMalVQbEcyN3pPUmNUZG1vOXBvK25jZlh0c0xpNHBz?=
 =?utf-8?B?MHlqSTR6OTBKWHZYbEt0SlVJYjZzdVlndmlWeHVyM2tIU0FkdCtyaTZNKzgz?=
 =?utf-8?B?ZTBocncvMUFLaWxBMk5UWTFIaTNRdDcyU1VQY0dDRFF2bDVqNFoyakI1ZUp3?=
 =?utf-8?B?UzRva1FsaytTak1tVGJaaVdDdjRZbmtyTlJBUmExWWdqRUoyell3S295ZXF1?=
 =?utf-8?B?UGx2YldnVWJjem5WemVWeFhic2xMalJoQ0Z5TU5BNWI4TGp1VzlJdUJkbTZB?=
 =?utf-8?B?NjVZOHRsYnFCUGJubUZoek1Ha29JMm04cFVwOUMvUkQ3NWt5K015MXpTU25x?=
 =?utf-8?B?WmRlU0FObWRRVDdUT0JtejF6UHZ3SWczZE9BYjMxMUhpOWJSVmdMRk1GOXBp?=
 =?utf-8?B?YXVySjVmNHlOL1hQTStvSlhldzNsdmo4akxVdUFrancrNnBaQkRZL1NKUXJH?=
 =?utf-8?B?TStmS3lRUzZIMGpxSC8wUlFzaEpWRlFMWDhFdHpqMUxxVU1XTS91SS9vV3Jw?=
 =?utf-8?B?aG9SenF2M2dvSHpGQ2c1THhQSVF0L3RhREZYZk5KaVNBb3pyUXl2TkpuT1ls?=
 =?utf-8?B?NkRGSWVsSG9VU3ZOQldJL1d5L2hWTjhhbUtGVzFPRmpkdFB6WE5mV2lhSUIz?=
 =?utf-8?B?T0gzZnFaTGZGQ2NadENQVFFOTUx3THVuc0RsTCtWTkRQanhoVE9Ddk5rbG9Q?=
 =?utf-8?B?NG8vTWVXK1o2K1RrNEVwdFpBK0RyUEphTEZJTTdtVXliNEkzeWNnQVJXQnVV?=
 =?utf-8?B?YnZkM0dLNTlEaFdXV0NWQ2lKMjdSS3Y4TjdXNWVFWVR6d1lmTGp3cUp0NEVX?=
 =?utf-8?B?K3ZTcUlKU3pTT2dvTWJYc0kzSUdJNGZ1SVRWSHdqMXloQ3k4eWlYYS9WdUZr?=
 =?utf-8?B?SkhRNmphcFBOOWt4L0RqZTNjdjFmbjJRWEhhbzg2ekF1OEEzb2VoVG01ZlJz?=
 =?utf-8?B?M3ZHTnJEanpINmM4TUl6NEtBa1Q0N1Y4dlhUTSs3dVBkSDNkWnFIMC9OSnFB?=
 =?utf-8?B?d3dDcTRwVmUxTnFDMTVkM29zQnUrOUdLUEMydHZhUFhNRlgwTVJOMHhuM2RB?=
 =?utf-8?B?RFowMGt5WnBSZ0d1bG0ySVhpcDU0MXJ5dlRnQ25lMXU0R3J2V0RmdENObUxS?=
 =?utf-8?B?bktxdlNvaGxWMzFvemlsaVRyMTJIWUk4MTlHTGIrOFNQTXloQVdJSG5DZGRG?=
 =?utf-8?B?YVJicmlsclYrM2M5bU1NdGU4STNDZ3piaTNDNjRhTksyZjBUenpJcnhxVGI2?=
 =?utf-8?B?eXI1U2lVZnFhWmJIblBaY0laS2ZOL1BZdHFHWUF2bWxGMTMyQmtKTkhNU3NS?=
 =?utf-8?B?U1d3K3FhUlNmTEUvRUMvQi9VOUdEOHNiTGZwT3IzVVQzdlF3SVZ0UzVwdWh5?=
 =?utf-8?B?OEpybGNuNGtidnBObDBIRDdSaHRadVk3THBJUzZuaUJ5WVMyd2pVYnVXa2RV?=
 =?utf-8?B?Mm93eGZURWZPYW02WUxWRzZwSTU0K2hsVVg5RFRaZDRXSmFIMjBhNndHc2hp?=
 =?utf-8?B?akFYeFY2dWdzVG83UlF2ZDNCWHFTa3V4SHNrSXpId2RybFJjeGNJd3Y3dFVE?=
 =?utf-8?Q?HX4Ez5AJqqDsxyLgp0iUWabmGSHjKlIiIvFFMQS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242f5013-3ed9-4691-92e3-08d8dfea1900
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 15:19:40.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgPPioiK/gFnP3AsRexBnIU3aKYFR+Y8wLtz1RMRH56HfYiYU2i0nC454MUcavjA3y+HkHRUPzZ7puu3l+7uuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1208
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

Ck9uIDMvNS8yMSA0OjE4IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAwNS4w
My4yMSB1bSAxNTo0OCBzY2hyaWViIE5pcm1veToKPj4KPj4gT24gMy81LzIxIDM6MzcgUE0sIENo
cmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pgo+Pj4KPj4+IEFtIDA1LjAzLjIxIHVtIDE1OjM1IHNj
aHJpZWIgTmlybW95IERhczoKPj4+PiBBbGxvdyBhbGxvY2F0aW5nIEJPIHN0cnVjdHVyZXMgd2l0
aCBkaWZmZXJlbnQgc3RydWN0dXJlIHNpemUKPj4+PiB0aGFuIHN0cnVjdCBhbWRncHVfYm8uCj4+
Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+
Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5j
IHwgMiArKwo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
aCB8IDEgKwo+Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4+Pj4KPj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5j
IAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+Pj4g
aW5kZXggMGJkMjJlZDFkYWNmLi43NDUzOTM0NzI1NjQgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+Pj4gQEAgLTU1MSw2ICs1NTEsOCBA
QCBzdGF0aWMgaW50IGFtZGdwdV9ib19kb19jcmVhdGUoc3RydWN0IAo+Pj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4+Pj4gwqAgwqDCoMKgwqDCoCBhY2Nfc2l6ZSA9IHR0bV9ib19kbWFfYWNjX3Np
emUoJmFkZXYtPm1tYW4uYmRldiwgc2l6ZSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm8pKTsKPj4+PiAr
wqDCoMKgIGlmIChicC0+Ym9fcHRyX3NpemUgPCBzaXplb2Yoc3RydWN0IGFtZGdwdV9ibykpCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIGJwLT5ib19wdHJfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgYW1kZ3B1
X2JvKTsKPj4+Cj4+PiBZb3Ugc2hvdWxkIHByb2JhYmx5IHJhdGhlciBmaXggdXAgYWxsIGNhbGxl
cnMgYW5kIG1ha2Ugc3VyZSB0aGF0IHRoZSAKPj4+IHBhcmFtZXRlciBzdHJ1Y3R1cmUgaXMgY29y
cmVjdGx5IGZpbGxlZCBpbi4KPj4KPj4KPj4gT2sgd2lsbCByZXNlbmQgd2l0aCB0aGF0IGNoYW5n
ZS4KPgo+IFlvdSBhcmUgdG8gZmFzdCwgbGV0IG1lIGF0IGxlYXN0IGNvbW1lbnQgb24gYWxsIHBh
dGNoZXMgOikKCgpTb3JyeSBhYm91dCB0aGF0IDopCgoKTmlybW95Cgo+Cj4gQ2hyaXN0aWFuLgo+
Cj4+Cj4+Cj4+IFRoYW5rcywKPj4KPj4gTmlybW95Cj4+Cj4+Cj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+
Pj4KPj4+PiDCoCDCoMKgwqDCoMKgIGJvID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGFtZGdwdV9i
byksIEdGUF9LRVJORUwpOwo+Pj4+IMKgwqDCoMKgwqAgaWYgKGJvID09IE5VTEwpCj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCAKPj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+Pj4+IGluZGV4
IDhjZDk2YzkzMzBkZC4uODQ4ZGMwYTAxN2RkIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+Pj4+IEBAIC00MCw2ICs0MCw3IEBACj4+Pj4g
wqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSB7Cj4+Pj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25n
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplOwo+Pj4+IMKgwqDCoMKgwqAgaW50wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ5dGVfYWxpZ247Cj4+Pj4gK8KgwqDCoCB1MzLCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9fcHRyX3NpemU7Cj4+Pj4gwqDCoMKgwqDCoCB1MzLC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9tYWluOwo+Pj4+IMKgwqDCoMKgwqAgdTMy
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByZWZlcnJlZF9kb21haW47Cj4+Pj4gwqDC
oMKgwqDCoCB1NjTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3M7Cj4+Pgo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
