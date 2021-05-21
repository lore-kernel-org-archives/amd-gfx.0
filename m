Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF7CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84FE611AD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84FE611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3C16E18F;
	Fri, 21 May 2021 13:47:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C6F06E18F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 13:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg3bek3ZB4wUbqqAfCMdPApUc9sx8nHvuX+Vvv6+R+fbIoihOJbf2J3CCd/g4wTKv9jSY0QeMItJ6tCqVVeN3L8Q4asxbmXUPLbxw9S40Vz97wnyrj0cSHdrKI44fpGymuV9pCDpdtHOIbDP31z2ZIpY0Q78nbtloBN4v5V1t1FjPcyT7Id75FFkWdNa5YjHIWivCT0/jKOLqefTEKtP/NNxH+8KVK5kG+2euYpab16lHR3OMod/lXXf1ViAg2xphEOurChVfaDYfCm/LmDIUC/qmWgowI0jx8UjIQbPXqDzA/qlMF9t6MyD+xLHgY2Jv+BwRn3ILvOo2ImJCIA0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxTYVI4yJEo0DTyedNyWLgPYtu2acJXHhI89JxhSncI=;
 b=kzB/svTwpmdhfQXIbb1fxzZyPyVrYo9gKXdZUtNn0BnZm6S7jwnEyV6qoVad8cBbntozINY5PG/WRYnoyfITVeR3H6iWP/qZaFtBO+1ztFZB90l+3HQbLJKihiSUZzI7FVBvt9AHjUe1x7fW2e+BLkWV0GUA/9uz9+/4AcnYLAmIiNEyP/UCn5KE6GUIBNbAD8etdpw/Nfoe2nZoLB+T3LVT/2pHz/d2hD94KVFp6tjbTw9SDLjFVxhBQXhO18ojNCisaTc418eBSAuvZ+9lZHJUlB1mo/TAHkxeEGhq9o+VkibTfYL5mnfLtc59gGolYTqNrcro4fvH4+u1sYGDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxTYVI4yJEo0DTyedNyWLgPYtu2acJXHhI89JxhSncI=;
 b=k6ZAHwPemkteYKpz5Xscpa1+U1ytcv8WaH9I9t3gqJrIHJ/E08a85T08SsybkJXHtF80ff8EuhNDkYMu9l1FNM0oGqZr2FJ2yqLDwPHatA9xDa0/TY33e9uhs5nzp0wY54KFitEyAdCLWlBTV7l+HXdomq9JmRYQvEJfm1ViKxQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 13:47:19 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 13:47:19 +0000
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Workaround IOMMU driver bug
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210521022256.14184-1-Felix.Kuehling@amd.com>
 <20210521022256.14184-3-Felix.Kuehling@amd.com>
 <b8803012-3642-4817-1ae4-e546b5605a47@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f04777f5-0de1-fd61-41e4-28487e63a899@amd.com>
Date: Fri, 21 May 2021 09:47:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <b8803012-3642-4817-1ae4-e546b5605a47@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::24) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Fri, 21 May 2021 13:47:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 908500fc-3891-46da-8601-08d91c5ef407
X-MS-TrafficTypeDiagnostic: BN9PR12MB5033:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5033C8D65FDA01864A5CC65092299@BN9PR12MB5033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwOiUCqLfFu6V2leCTked4GeNfjY5a1m8zOKZMDkXqlA/1FdYnfrjXURQO+z/e1UrRZuN7lNABnVTEXlWlsQen1QxtKNIr5sRaZU+ghnTBqUbqvZSLcYHuGgcZ37JCiQfoxKyvNRveWby+Qcmk6OVS0eU/ffAslQh3tnWUFRINeLgdjBWYYeHJnsu9lp3fUvt57eEQNz5pC0KI9CqOfmhIBmUp9I+ogpDeukYHwsLYgv60mvCY0n6/Vvj32ehOdiiip52l76uzcyylEx0KfiPVEMVRo13feieGRzkNE3JTyMp5SFmfXwS65aHemwv+quOrbNv49VWwCjhW27o8iorrG8ZEHCUKbrDdDEDi/T8HShwrVxS5U46tNdMr89kutHskiU8YVNTGkP3xC744HL9hsQK2dIE/WehwQyloz3DPFnN0itDfsnMGyy2qeeQMEYNVqhQ/KdNx1ZPOMsw1O3m9U7cDUpdXhJaKZc4RnZYw625iFpLi8Zfx9FGkmUv7bWC/4MHcOMdAi912rZi9CBmP8gmh5U+wmoVWaZX/wOHmrk2Of45m0JXIps3jflDpESLr15GpZDG+uLV+jhFNbxWAV7wDQPG9waaQJCTFvaB0iPO0j5aclVBuHMiiOUoUlN8vFvkGC/6PLPHjN5HhLYwUeE8qawaQ/bhBv1wyNynO1HSHbh/jxp126Ltikypq/2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(36756003)(31696002)(478600001)(16576012)(44832011)(8676002)(83380400001)(186003)(6486002)(31686004)(316002)(16526019)(66946007)(2616005)(2906002)(86362001)(66556008)(66476007)(26005)(5660300002)(38100700002)(956004)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjhyaElsMTd6WlhqeFVYZ01hR1lFMG1leHYwZ0M2dWNQd2xNcldpWkJwNUVT?=
 =?utf-8?B?NGFCamhON25iYUs0WWRmVXNaK1BrTHROVkFxVk00SDhCUG1XL045UHl0Rlg1?=
 =?utf-8?B?VFFlMFgvUXU3MXkxc3MwbjJ2YlBaZnd3MTgrMjU2ZXpBOVg3S0xPVDgvNTha?=
 =?utf-8?B?WmdTeWdQZTQyNVBUWExpNG1seitiRjNiY0FPRWJMMXl3NWZMZEJyVlpKcUdK?=
 =?utf-8?B?ZWFjOTBpaWZIanljZW5ObEN3VlpzRWg3dXR4Tmc4OHFWOTlDVno2WHJNbUVp?=
 =?utf-8?B?UFYxcUhNbWk0aXlXbEhzeDRiditkaWRZY09ROVFwYU4vejRpTDdoQTRYQTlB?=
 =?utf-8?B?TTFSYjEwbmgvbnRHUEVqQys5UGhvVnozckZxanlCa2pUK25ya1hYTUd5bGV4?=
 =?utf-8?B?YzNJQktyRGVlOVU3ZlRVTzBTdVM0STl4Z3JSdk5Bc3BCM1F5bHc1c3R1TUVO?=
 =?utf-8?B?UEJSTDFLdEwrVlhmZEVwbHpiVyt2WkoyczhRZ3ROSUFka0JtU2hpZFUvejEv?=
 =?utf-8?B?UllrZHAzb1A3ZmdFREtZWmh5WXQvUEV4MExQSG8zSE9Vbk9tdERNdWR0dE9k?=
 =?utf-8?B?T3lNUkNjWDNzcEZYYmVjS3piVmlaTlRFSUxhSWFwWVVHQytYUWh6WGRoRUwr?=
 =?utf-8?B?M3pVRXQvQzJDL3AyMGYvU0QyVTlTdXNTYi8xNHNuakF3bEVZdElwYjl4R1M3?=
 =?utf-8?B?UjVjRUZKZG9zdHNVYjE1RVJzamFTWjJhcnpIZGZVdXZBWEk2cFNpN2puVG9G?=
 =?utf-8?B?czNYbU9vTzF0UmxmYjlCZi9LOFI1TzZxWDZpZGJCbnlpWjBnVHA5R0UyVGlO?=
 =?utf-8?B?Tm9ORmhpNVAwTFErQk5xK1JiVXFtcVJ1NEEzcTk4d3JJTlowdDlJbXVTNmRB?=
 =?utf-8?B?akpWOUhHcTNROXFXNERHbjAzaXVHSlQwbUtYbjB6T0R6ZVVTR29ZV0Ewajdq?=
 =?utf-8?B?NzRSSWJRUk1Vd3Z0R0NsS0wyUUh4YUVmTGNWOWk4OTRLRStyZjNobkM5UFkx?=
 =?utf-8?B?Ny9Md2VGV0RJZlBHaUVaSTJvU1BnQTJ6cWdmSGt3Tm1oZXFpZ3picCt2OU43?=
 =?utf-8?B?VlFQT3dHaTZIdUlqVUZRWktXa0NPZ1gxcWVYOXJ0V1NwWEFWVVZCMEVWbkpa?=
 =?utf-8?B?Qm1MSFpLQy82S1hMMldEOUZmM092eVhOdWF0M2pjTWF2N21GQlpVUUo3Sk9j?=
 =?utf-8?B?c2xlSlhWM05XNTh6V2Noa0NHK0l3Y1BZM3B3VDF4UWhQb21RZEJjZ1I1YUZQ?=
 =?utf-8?B?eWpVY0UwYnE1ZmNYdGJLcVFyRmdRTWJRdXlWaWtzV3lkaEhWd254RTE4eGhP?=
 =?utf-8?B?QUY2YTAzQ0dLZnZrYVZjTElxc2lmck5EcHpIemh5UWNBT0dMdjZOanhYdXhs?=
 =?utf-8?B?enIvcFN4VXgrTXhNeDhNa1VpOFJhZTZqR01wT2NTaHQ1WVNxRGRzM003RDZl?=
 =?utf-8?B?QVNPTnNIVXRaSy9SM2xUZFVhTy9JTkxlb01uU2RJVlV1dDUxTDArMHBJSy85?=
 =?utf-8?B?SjZ5Q0tKTm1HcnZ1cEdEMTdxcm5yT1BXUS9xdlczSk9iVUpHN0hvcVRzb3RE?=
 =?utf-8?B?bGdXdU9GenQrWmlRbXJPRE5KYmc3akFtQXFYek5nVjR5ZGkwWW4vanB0aW9M?=
 =?utf-8?B?L2pya2NqMkRVREtMdnROS1YwU1JjSzhWS0J4cHYrZHl0enhzS2s0Rm9uRm1T?=
 =?utf-8?B?V1VGdTlJY0kxSnd6MnJkUGJPTGtMYjlhc1l2OHRIUWZ6R0pUcmRURnBNdG83?=
 =?utf-8?Q?8ZaS7ktR/5azk8vWau0HLPyCc80S0i9hFRPyRkg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908500fc-3891-46da-8601-08d91c5ef407
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 13:47:19.7557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mMAPLcuAuviODROEGZ1uKoSpL9mXgPAd0bZWsJNGuXHs1TjfMP6LW/E54o9Z7WJ+4LXW/G79QYyPIn/Si/BoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
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

QW0gMjAyMS0wNS0yMSB1bSA0OjQxIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDIxLjA1LjIxIHVtIDA0OjIyIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IFRoZSBpbnRlbCBJ
T01NVSBkcml2ZXIgY2F1c2VzIGtlcm5lbCBvb3BzZXMgb3IgaW50ZXJuYWwgZXJyb3JzIGZsb29k
aW5nCj4+IGtlcm5lbCBsb2cgd2hlbiBtYXBwaW5nIGxhcmdlciBTRyB0YWJsZXMuIExpbWl0aW5n
IHRoZSBzaXplIG9mCj4+IHVzZXJwdHIgQk9zCj4+IHRvIDZHQiBzZWVtcyB0byBhdm9pZCB0aGlz
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KPgo+IENDIHdob2V2ZXIgaXMgdGhlIG1haW50YWluZXIgb2YgdGhlIEludGVsIElPTU1V
IGRyaXZlcj8KPgo+IFdvdWxkIGJlIG5pY2UgdG8gaGF2ZSB0aGF0IGJ1ZyBmaXhlZCBpbnN0ZWFk
LgoKWWVhaCwgSSdtIG5vdCByZWFkeSB0byBzdWJtaXQgdGhpcyBoYWNrLiBJIHdhbnQgdG8gcnVu
IHNvbWUgbW9yZQpleHBlcmltZW50cyB0byBzZWUgd2hhdCdzIGdvaW5nIG9uLgoKUmVnYXJkcywK
wqAgRmVsaXgKCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAzICsrKwo+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4gaW5kZXggMmI4Yjg5NTM1MTk4Li4zYmVj
ZjlkOWY4ZmQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dwdXZtLmMKPj4gQEAgLTE0MDksNiArMTQwOSw5IEBAIGludCBhbWRncHVfYW1k
a2ZkX2dwdXZtX2FsbG9jX21lbW9yeV9vZl9ncHUoCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkb21h
aW4gPSBhbGxvY19kb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBhbGxvY19mbGFncyA9IDA7Cj4+IMKgwqDCoMKgwqAgfSBlbHNlIGlmIChmbGFncyAm
IEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX1VTRVJQVFIpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIC8q
IHdvcmthcm91bmQgSU9NTVUgZHJpdmVyIGJ1ZyAqLwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHNp
emUgPj0gKDZVTEwgPDwgMzApKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVO
T01FTTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dU
VDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFsbG9jX2RvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlO
X0NQVTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFsbG9jX2ZsYWdzID0gQU1ER1BVX0dFTV9DUkVB
VEVfUFJFRU1QVElCTEU7Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
