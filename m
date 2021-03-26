Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F2C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 23:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D3A61995
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 23:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D3A61995
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF436F4FB;
	Fri, 26 Mar 2021 23:29:00 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690044.outbound.protection.outlook.com [40.107.69.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198086F4FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 23:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6OxBanBslXWMiW7TLK81f3Dfeo8BYG2ptSvjnGPntAfxdEe7RjYKtjro+//iVwe3DPVkuquuuHToFsIDNPFOwsK3A8tb7X2FhJAaYPJpiGDGa/hSCV3VB2u3t7wl1AQVzZ1AXADJ+qWP7w0ZKfVxNbmAhmZIl0xRG/Fg/misygeY5YF4ZcP1rC3oWb4QJlUV8m0pWw40cx3CC3zR3fr0hUxyNwb7k+AHC8n9DPfRmRhC27V8FEwvt0glfheDBGsOyklrDrRN3RgVuNemlNPlELD1BSSuGQo24HIgmvtMTZzkaYJgmDkAIreWVJfkJRXGE+aqBY7ksGBHB5rs3pKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJUBpFkC4QCR3B4w3OvUDFoA7YcNnRqFLKN14KMGPgw=;
 b=im4wKPJ3JC4/csessnDcMNvdbG1gXA/wlebrGQn3wYE9/Ub05sdGxM61J9vAu+VX07JImVuih7R5B45M26UNYSs2s+7YdXhIx8LHKOA29XKjJIssmQRN3fVUSGqKLhw/yZwqVxY4km3IU0pg8GzZRo7yvGFwSMs8uLVWSu+5G98LzxaFU2kdNpiFGB+ML/nMnMeqsDgkQQ4tx5PPojpQjnmO2Gyt02tf1GWO9KJP3xPk7d4xKUwojs5fh2g9mh6FeiWBjzUe0rFY3EuWslCS4wqhq50SltOVUOPsaT/QdAsA0OJw+4EfbBsitfxTd+dayDWTAM7e0fqfTmT45sSWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJUBpFkC4QCR3B4w3OvUDFoA7YcNnRqFLKN14KMGPgw=;
 b=fci4mp2ZT6sfjClsRjG44CHyewuinavP0a/lk49oBsfYAFFnJ8Nu7OMb6LWerO8aGstfHjluXzAdYzdDRuiJO7zaxiY44NwUAnqu49ewJseClU8IMEm2AFMaShZeahKop6IHSggF+sDK8dbNUfQE+Nc8t9krFY6NWZKIX+wvhO4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3887.namprd12.prod.outlook.com (2603:10b6:208:168::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 23:28:57 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.038; Fri, 26 Mar 2021
 23:28:56 +0000
Subject: Re: [PATCH] drm/amdgpu: ih reroute for newer asics than vega20
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210326153332.4149-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4656cce6-a05d-74f5-b72e-a76cd570dd97@amd.com>
Date: Fri, 26 Mar 2021 19:28:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210326153332.4149-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Fri, 26 Mar 2021 23:28:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6228f223-27ae-43bf-8dec-08d8f0aeed03
X-MS-TrafficTypeDiagnostic: MN2PR12MB3887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38875C73735C835270A66ED492619@MN2PR12MB3887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8XmEPJl/4dRHjdNF7FEvW2gkAw2mzSM6ymrWFndmKfHbu2GIwSf3Q0074+0DaL7hlz0jX1j4wYkBEyWWabkUKIEits4NAtsjELOxiMQjIk5dnDS1zM6pn3Qe3kNW4ZTpb6epDt9NtMuZN28q39DSYFoU68RaCygc4wVU2iPETe7Fgz8UQCIU5N3EPCZBtfUqiMAukoA9IS4pqIRk7UEj8hzjeExFxmBpixykW6OfcrXCMS2TVJdO5fsYan6+XvASKOCp17abw6oJg7L1OWKjSzhw7eP6Bgoe4yaCsrjqVWY/WlBn7qgYkjvBdGOKQliWa+Ki/rCyEr4O9CcyhayiuWG813Omg8ei5HFpqAZxM8vOGOGKY50LAGiK58nqAFozkEI8xP+M3AvdNz9fcXPmxnX4ebDpFs0xnL3aWJkdNszwtEJjcmbsdm0Jm2N6Yi8n3FN15GvYGaOvuyNnPfCRgdUpdgukPhKe15ACSM2Fk4wR+uXJFll0E2vYS2ebaq0fmo2m677kqo4QAEMh17Hd7UKtfpGxQhj1PJR9bO3vAL3a2P/tQTOfGlH+y8NUl5sGuLSs63iDxH39+A6KtkzdJlAUokS7P6Mglob55NptmVPcJdezlF61I+ocZsAbWbctObDopCrcwa1LCvE8QmqnYlc8mfUKu7HCyhw6kcAiWdfuT2aL8N0zo0heKDaSQQyFYD5a8RW/01KEhxYL6Sh7MzMSiA6TUBeYsIeNrJbfW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(31696002)(5660300002)(66946007)(86362001)(66476007)(44832011)(38100700001)(8676002)(478600001)(83380400001)(8936002)(2906002)(66574015)(66556008)(6486002)(26005)(36756003)(2616005)(16526019)(16576012)(316002)(31686004)(186003)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RHhka08yeTVJNEJNTVVnZm9qRkR2bFlpVnlHZDRWK3FiT0JBbWVFcE1uMWVH?=
 =?utf-8?B?TDNqUFZOOUEweDFkbnkrVjN4ZXFReDE2MGRhSGxQRDFGSmdFcnVoMTVIV0g3?=
 =?utf-8?B?UXhVUGtDZURHaDJuejFVWWoza0Qyc0JtWlZqYXNOUkJST0tVK2FkaTczTUVC?=
 =?utf-8?B?SFA3ODNWNVB2a3o2dVVqR2Q5NklpcFgvVmg3SU82ZlZxV0VjNTNlb0t3TEF2?=
 =?utf-8?B?VE14NjdpdjdOUllRK0Y0U3FiT1BGZkpwNitjNUxqSWFDVVhmSW92aDJFZ3RU?=
 =?utf-8?B?SC9pa0FYZ1lZbDBQRjNGR05qSG9zZlNjOE4wRTBqWU9iWWZNeG4xdnNVMVpZ?=
 =?utf-8?B?OHEwWGdWQkl4cUNoZm1TWkhBSlBDNEF1VzVHWnB5ZHNqQ1FZL0x6dTBRWXBL?=
 =?utf-8?B?OHpSYlVVT3BCa2hHT29iNC9tWkFzcHBBdnNUczRudzBPajA3NWlOcm12Ykhx?=
 =?utf-8?B?bjBoa1RNZE5jaXZ2TFlsTUdMMGFNaWJ4Y0R1aUNZU0x0REpYd2NWVXJKRk5G?=
 =?utf-8?B?MDRjamUrU2Y4a3pzZ084d1YyYTdDVDZhTnZSL3VHTU84Y0lNczRBa2pyanpN?=
 =?utf-8?B?Z0hSV0ZaY2s1aTFkOE1NYkZTc2w1VjgvNW51NnZ1MWhaM3BOWnRkL3dHaW5C?=
 =?utf-8?B?VGdlQnNIbVdVTVdjYVVkUzlYZjJHdkNMaXZMdGZqTnFCS3hsZnhzenQvaXk1?=
 =?utf-8?B?MkNscmo2QndveU0wMGFRMHVBRGhIYmxXRjFYYkthWllyUDFmMmRST29uMVNV?=
 =?utf-8?B?VFhiRmtSUmo2VlJ0cVBUaEV3VUozbi9WbEtEMWMyZXdGQkxPZ1A3MzJnZDRj?=
 =?utf-8?B?UG0wcms4MEVJVEM4Y1FWeWZyS09JL3lORDZTR2VrbWNrbTV5UzFvUVZWL1cy?=
 =?utf-8?B?c1BQUmxRSC9Lb21MNUE2SjYzWWJnYkV2U1NvNExWWHZ4VENCRWg2d3ZZR1Ri?=
 =?utf-8?B?ZXlDbHAwV0YyZWJtbzM0N3dLdlNiNGV6OUZBMDFxUk1zNTJzc25iTkV2WEZk?=
 =?utf-8?B?eGp3WnJtK3pXTHpMRVlKOUpSaUZCNEo2Y2EyWm5aR3VKMXppMjVqWk1Ia2JG?=
 =?utf-8?B?WGhEeDB6N25MNWtLQzVLZmdmYmFIVzVJSk02RmFINnFYcjU2UjNLdHBTU0JF?=
 =?utf-8?B?RWExbEhoZXFUT0ZyZ0EyMWlBelpYMEUwemhQTWUraE1IWU1yOU0yM0llNmJ0?=
 =?utf-8?B?cG5iaFl5TlYyVWdGMGZzYXJUUGNRQ2hQemlnYlEvZy9JZnN1WEtEL2xVZzhu?=
 =?utf-8?B?eDgwVEx4NmxXOGNvWUJvTmRwSkgzY3Npa1V1R2ZJUHpFT2g2aGk0V2ZOdVJE?=
 =?utf-8?B?S2dKSUNOVVVhR25RaXNpTHU0bmdLRDNJT2k0RStrWDBDMXU4YWc4S2xxZzNQ?=
 =?utf-8?B?SExVVU1QeDVHbGdhcXdIOHBveHlOaVJ4Qm9YajdrU2pCRy9OT0tVbHdmYkpy?=
 =?utf-8?B?eHBMdkVaWGRiaVpGUWdHUzA1eVUyMnFqZ3RWaDhBYVNqdVVJeDlqR1R0Nk9T?=
 =?utf-8?B?YXZFa1k1SE5kaTI5U3I2UTFVV0pPYjVKNVg2dW01R0RUNVViTFpOZnlja2Vv?=
 =?utf-8?B?L0d4VWV2S1o1WSthSVIrN3RLVnZzc0d3STluZHE0OTlIQ2JJMzUyRStuTVV6?=
 =?utf-8?B?b0VOT2JNUWVoNEpXUzhkN2lXS2NTakZwMnBjU1l4NW5EYlRBaWRVS05wRFlL?=
 =?utf-8?B?THFiZFhiUzF6dGVtd05YakZDSSs2eUNodTF6SGNDYmt4TkVKdkJBTlI3SW51?=
 =?utf-8?Q?6y05mYUumFnBbRXxgFWWKkS97qq0NAr5RemgriU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6228f223-27ae-43bf-8dec-08d8f0aeed03
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 23:28:56.5946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5rT+yNtIkeApEKn2HZwUz49WDfUCDkQAb542bPetnXTO+VWYNDQn92L+YwgNnT5cqfWuqMa4byB8/OqoJ+WNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3887
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

QW0gMjAyMS0wMy0yNiB1bSAxMTozMyBhLm0uIHNjaHJpZWIgQWxleCBTaWVycmE6Cj4gU3RhcnRp
bmcgQXJjdHVydXMsIGl0IHN1cHBvcnRzIGloIHJlcm91dGUgdGhyb3VnaCBtbWlvIGRpcmVjdGx5
Cj4gaW4gYmFyZSBtZXRhbCBlbnZpcm9ubWVudC4gVGhpcyBpcyBhbHNvIHZhbGlkIGZvciBuZXdl
ciBhc2ljcwo+IHN1Y2ggYXMgQWxkZWJhcmFuLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVy
cmEgPGFsZXguc2llcnJhQGFtZC5jb20+Cj4gQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPgoKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zl
Z2EyMF9paC5jIHwgNiArKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92ZWdhMjBfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5jCj4g
aW5kZXggNmMzY2IzNTEzYjk4Li44YTEyMmI0MTNiZjUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92ZWdhMjBfaWguYwo+IEBAIC0yNjQsMTAgKzI2NCwxMCBAQCBzdGF0aWMgdm9pZCB2
ZWdhMjBfaWhfcmVyb3V0ZV9paChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgewo+ICAJ
dWludDMyX3QgdG1wOwo+ICAKPiAtCS8qIHZlZ2EyMCBpaCByZXJvdXRlIHdpbGwgZ28gdGhyb3Vn
aCBwc3AKPiAtCSAqIHRoaXMgZnVuY3Rpb24gaXMgb25seSB1c2VkIGZvciBhcmN0dXJ1cwo+ICsJ
LyogdmVnYTIwIGloIHJlcm91dGUgd2lsbCBnbyB0aHJvdWdoIHBzcCB0aGlzCj4gKwkgKiBmdW5j
dGlvbiBpcyB1c2VkIGZvciBuZXdlciBhc2ljcyBzdGFydGluZyBhcmN0dXJ1cwo+ICAJICovCj4g
LQlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMpIHsKPiArCWlmIChhZGV2LT5h
c2ljX3R5cGUgPj0gQ0hJUF9BUkNUVVJVUykgewo+ICAJCS8qIFJlcm91dGUgdG8gSUggcmluZyAx
IGZvciBWTUMgKi8KPiAgCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX0NMSUVOVF9DRkdf
SU5ERVgsIDB4MTIpOwo+ICAJCXRtcCA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ0xJ
RU5UX0NGR19EQVRBKTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
