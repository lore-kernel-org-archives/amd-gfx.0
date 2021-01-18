Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B004EC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 14:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747F922C7E
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 14:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747F922C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D26E6E438;
	Mon, 18 Jan 2021 14:57:04 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690084.outbound.protection.outlook.com [40.107.69.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A762F6E438
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 14:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju18gr7PdK27jcI1cp5yr8gWPFgrKL4xiWFrvj/SQhdFzZbQUPYujlk+gyWts+9Dj7KWNzO6yXoTHSAnAJ8tZXwTvHYBpahonCtBn+THG1VilGambD2+K0A/suzTmdtUw9SlJ+kSZ3JZcm0M5bJqDw2JhFEqr4B5qCaQpbul34qU8QqgoP9COb3oWkQmV/2JPKajjevxZ13+ntHeoiDkpCpkNbHamJ54EQWRE4wkeOGjQHLOneRTqYaNLVqQFU53tP5NNsPjoW6eZ0nvVWB+Wxmpl+hFPPxBMPQEdpNNtNl8Sq0UdbKaCXsKNE/ufyUiFBr1euS/Z2/Eid56lwSJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsRSvdySulRo6zHwIokquOsCN2dkOvvCK27FwxeJ7xI=;
 b=cUJ6qdZOw7wmm/r68+1div4yK1vp9opk6t7BVmuCmZWhLr4LWL0ZOsT3DEyUfV7Brp5qqkQT9gTWJAQuvEg7XQ/JHb2DmERP5Lc1aWe1VdLtUiN3DcY32tmGmm6UV4Y5mb6DwfSwwOuirqrgpAwhatVeXJuTaWCbbLxap2DcOEFwzU5o6bFus5xE8bzNyIo2MYSBRK0CFnIqp3vm4Gy5jrJwZOLpqSYlAnyWvsu+46E1HkjUqjkJBEkFW0DoysCOT1ofbsnvBwPjd6KSi6PtsBpdXqenyjChOPp+/K1T1gOiPR6W4ZGpL/nrPzfexYpKb3wCN5BkBzvcn/Qmj8aPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsRSvdySulRo6zHwIokquOsCN2dkOvvCK27FwxeJ7xI=;
 b=JfTFwOAKYJBaDWvCYtS4BHfpEBPaGDU13NGHrUzlW4AQZ86YQIsn62whw9uKZAWQ1qdtWN2Rd3igD3S6zezQaZBTt6Wh04qpDCJ58xmiODlC7+s1Tck/dU1A0kyegY7ZfEu5X4i6ZfcXCAQOsI3iS4xpkED5jqMaCIacBnLtnvA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Mon, 18 Jan
 2021 14:57:01 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 14:57:01 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210115182423.32368-1-Felix.Kuehling@amd.com>
 <a4af46c0-f33e-d93a-4eae-bee52892e8bf@gmail.com>
 <b94a787c-f7f2-1141-c7df-c0950f8d1904@amd.com>
 <30326fb3-a772-e297-af3f-bfb970bcf275@amd.com>
 <f74b3692-ff14-0221-5efc-ef79ecf47d2b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f96de660-f6b0-83c9-f330-471719b23218@amd.com>
Date: Mon, 18 Jan 2021 15:56:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <f74b3692-ff14-0221-5efc-ef79ecf47d2b@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 14:57:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d48a6d05-9393-42b4-b653-08d8bbc14fc4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4389BB68E2B8DC08FE5D46E383A40@MN2PR12MB4389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9I6FEqz0CNij9/5j+wVU+PbMVMWjosffVZMfB99lhI4vGmkmpC8Q0/MCkA3kbhAbIPl718rRVELvEVV/QZAz8BRuF/xdXJSeXSyIxY2kZVftGqRPE0bpl4CElnG/UOcmYyejkuzPC8STlv78lJ2ej0U0osAutVHStEnWp1yHGHhZ48wt5ZHn8NrMflDafPuAl5A8UQxWoqLwP/tgrDrJiRITx/mTRyM9tof/AjvCnzUuLm2AQBdI64xyLkoaQMdKeTqD14AiVnTzCG8fOni9Ph+poQN/Dom/B6zDbQ0+yO8QNqjcRiZixUcM9JRVuxxvU1H5SakoqyOd53YDTFIJSx6bybj4YxeNpwQ9Jlg71hKDHm21LlJLANDrAJr8p3DTt7Z3K2jBrutJrkcmLnRtNF3ACzlmOiMVl5RbgTSS3XTBIgH+T4PcmtztRcpwP6qD5D5I6rRy2nLJ1KMq6xoli5au7FJMHDCIsDXPnXPkOANF66L+bukchL90LR/LWCJ8TUKzEyOjiQZx1j3O6NmqspPvcgmJPdsdDpPilaQd4YbGikorlEnLWz1ZUPKry0DrS800SGtcczX1QE2qnUacSoT0ExA8atQTwsL837G7A0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(86362001)(8936002)(31696002)(478600001)(316002)(8676002)(16526019)(66946007)(66476007)(186003)(36756003)(52116002)(2616005)(66556008)(5660300002)(2906002)(6666004)(31686004)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjQ5U3JFeFI2Z1VLU1pyeDdkbFFIeGMvSDBnMHRHczlYdFNtZm5aWk9wd0dj?=
 =?utf-8?B?d2E0cmprc1ZpOVJ2UktQa2txSXJQQTFQK1ZqRGFDYkhna0xNK0dCZzJWZXZK?=
 =?utf-8?B?TzZ0bDNxRXovb3FNYmdMUmlHeHhTV0YreUFuTVdPZkhJaVA1TUVab21Eajlt?=
 =?utf-8?B?dzBKNnQzRW9oNGxseHFTRlBHakluVGtEVjFYWTkyTHhxOGViT2hrZ0Y5SEF2?=
 =?utf-8?B?RkliVUZSWGd2NmRnSWJiek8rcE1BQXhuWTErZ1J0M1d3VzlXSjNiSXZ6NnYz?=
 =?utf-8?B?bndlaEVMbUx4TGl6M0Q4VXgyM2ZoMEJwckoyYU5HandEb3VFTWdPM0lLR1hw?=
 =?utf-8?B?ZUlSTU1RQ3d2NHQwaHduRXZuQ0xWL092YXp0M2gybCt4RGJxd1Z4T3dZTmdm?=
 =?utf-8?B?VitlcXFXazcyNFdZQUpRUG92bG9hdjR0UnZQenN1aXZLNTV3SEZmQ1lCK243?=
 =?utf-8?B?UlVDakdKellWNGI2UEt1U253dWF1WUtKbDZJaDQvTTlDeWdxN09BaVBQY0lO?=
 =?utf-8?B?clNoeEFzV0VkRklLck1lSEExT0s5dHlQTVpxM3NpNWFZb2gzanpiY0s5RzZI?=
 =?utf-8?B?OHoxQzZOdzRvUm52aS9MTFVva1BjRWt6aWIvTmYrbG9taVptYS9jSzJyVUFy?=
 =?utf-8?B?Y0NOby9aaXBnbEgzTTFweDJsY3N1UzdLM0dRVjBUQTRPS1NPWjZBVVpXWXFS?=
 =?utf-8?B?OGF3Q0JJcVAyZDZwZkhpYUJwcXc4cUlBZ05ndVV4ZERaVFFkSHVNbXRQMCtU?=
 =?utf-8?B?YnU0V0FJbnJUelExbVhrUzRRTXdBN1dMRmJrWHM1bVdLTkIvejhHU3dWbU1y?=
 =?utf-8?B?S0F0R3lhSWdiTXdSOEU0TXp1b09idHBwQU16ZTI4ZSthbzNYckFBN1IxVnE4?=
 =?utf-8?B?Wlpmcjl4ZXVnTHJ0OC9WcFJobmdpVnNiMVhkU0FVRXhyY1hxZUZHTm5FaEtH?=
 =?utf-8?B?N2RIUTRnemZSSkpLSnoxRkJqNDQzZUpNVnlpejd6MXI1TzUvM2pJaSs3L0tW?=
 =?utf-8?B?b0VoUEtxMTljSEt1alBzM1RIUWMzS1dHdzZvMFEzV1YrdWZXcHlvdTYrMEhw?=
 =?utf-8?B?NUJhandoV0NNN1FtUGNPMWozRjdKcmJOUU9DM0pEN1RqY083Wkc2MXhRL0dj?=
 =?utf-8?B?YS9xRCtmS293a0p6NEpxazlSTkVUcWJIak1xNEdFamJpWWc4UUlEbmhkNUkv?=
 =?utf-8?B?bUx6cDB4K2o4VlVldjVBNkdJWkI3L29NMlRWdkxTc202YWd5T2h2dDA5amdX?=
 =?utf-8?B?SXNNWlQ0MlFWY3djM09BR0pqd2RWRCtLNW05Z050ZWlCVTRhWU05SFlZeUJp?=
 =?utf-8?B?ZnhsbEQ0Q0FHQ3pKYWZRdU9JMUU5cVYwWE9nbFhRVUt5TFBSWS9ZMllUYjZu?=
 =?utf-8?B?QjdBaHdjbWRUMjVpeXJwWjdva1lETTJMYW84RlprN2ZhK09RZ3FJRGtmVU54?=
 =?utf-8?B?a0JNeG9pSEdPbnpocWZqYUVXZzRWZjJhOTQzSi9OSlA1TjY3STRxS1ZSdkVo?=
 =?utf-8?Q?gf/tJ6BYTWlo3/crPdyWZvU+p3y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48a6d05-9393-42b4-b653-08d8bbc14fc4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 14:57:01.5548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCryYs+IvFVA1L7ZnbVxtVykEeGrr1V7Q1HI5rwDLsFbQeDxKEUAhFlb3JoPA4u7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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

QW0gMTguMDEuMjEgdW0gMTU6NTUgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIxLTAx
LTE4IHVtIDk6NTMgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+IEFtIDE4LjAxLjIx
IHVtIDE1OjM3IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+PiBBbSAyMDIxLTAxLTE4IHVtIDI6
NTMgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+Pj4gQW0gMTUuMDEuMjEgdW0gMTk6
MjQgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4+Pj4gUk9DbSB1c2VyIG1vZGUgZGVwZW5kcyBv
biB1c2VycHRyIHN1cHBvcnQuIFdpdGhvdXQgaXQsIEtGRCBpcwo+Pj4+PiBiYXNpY2FsbHkKPj4+
Pj4gdXNlbGVzcy4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgwqDCoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9LY29uZmlnIHwgMSArCj4+Pj4+ICDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQvS2NvbmZpZwo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25m
aWcKPj4+Pj4gaW5kZXggZThmYjEwYzQxZjE2Li4yODAwYjJiYjI1MjIgMTAwNjQ0Cj4+Pj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPj4+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZpZwo+Pj4+PiBAQCAtOCw1ICs4LDYgQEAgY29uZmln
IEhTQV9BTUQKPj4+Pj4gIMKgwqDCoMKgwqDCoCBkZXBlbmRzIG9uIERSTV9BTURHUFUgJiYgKFg4
Nl82NCB8fCBBUk02NCB8fCBQUEM2NCkKPj4+Pj4gIMKgwqDCoMKgwqDCoCBpbXBseSBBTURfSU9N
TVVfVjIgaWYgWDg2XzY0Cj4+Pj4+ICDCoMKgwqDCoMKgwqAgc2VsZWN0IE1NVV9OT1RJRklFUgo+
Pj4+PiArwqDCoMKgIHNlbGVjdCBEUk1fQU1ER1BVX1VTRVJQVFIKPj4+PiBJIHRoaW5rIHdlIHNo
b3VsZCByYXRoZXIgbWFrZSB0aGF0IGEgZGVwZW5kcyBvbi4gT3RoZXJ3aXNlIHdlIHNlbGVjdCBh
Cj4+Pj4gdmlzaWJsZSBjb25maWcgb3B0aW9uLgo+Pj4gSSB3YXMgY29uc2lkZXJpbmcgdGhhdC4g
VGhlIHByb2JsZW0gd2l0aCB0aGF0IGlzLCB0aGF0IHRoZSBIU0FfQU1ECj4+PiBvcHRpb24gd29u
J3QgZXZlbiBzaG93IHVwIGluIG1lbnVjb25maWcgdW5sZXNzIERSTV9BTURHUFVfVVNFUlBUUiBp
cwo+Pj4gc2VsZWN0ZWQuIEknZCByYXRoZXIgYWx3YXlzIHNob3cgdGhlIEhTQV9BTUQgb3B0aW9u
IGFuZCBzZWxlY3Qgd2hhdCBpdAo+Pj4gbmVlZHMuCj4+Pgo+Pj4gSXMgdGhlcmUgYSBnb29kIHJl
YXNvbiB3aHkgQU1ER1BVX1VTRVJQVFIgaXMgYSAidmlzaWJsZSIgY29uZmlnIG9wdGlvbj8KPj4+
IFdoYXQgd291bGQgYmUgYSByZWFzb24gZm9yIGEgdXNlciB0byBkZWxpYmVyYXRlbHkgZGlzYWJs
ZSB0aGlzPwo+PiBUaGUgcHJvYmxlbSBpcyB0aGUgTU1VIG5vdGlmaWVyIGRlcGVuZGVuY3ksIG5v
dCBldmVyeWJvZHkgd2FudHMgaXRzLgo+IFdlbGwsIEtGRCBhbHJlYWR5IHNlbGVjdHMgTU1VX05P
VElGSUVSLiBTbyBzZWxlY3RpbmcgRFJNX0FNREdQVV9VU0VSUFRSCj4gd29uJ3QgZG8gYW55IG1v
cmUgaGFybS4KClllYWgsIGNvcnJlY3QuIEJ1dCBjYW4geW91IHRlc3Qgd2hhdCBoYXBwZW5zIHdo
ZW4geW91IGRlc2VsZWN0IFVTRVJQVFIgCmFmdGVyIHNlbGVjdGluZyBLRkQ/CgpSZWdhcmRzLApD
aHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+Cj4+IEknbSBqdXN0IG5vdCBz
dXJlIGlmIGl0J3MgbGVnYWwgdG8gZm9yY2VmdWxseSBzZWxlY3QgYSB2aXNpYmxlIGNvbmZpZwo+
PiBvcHRpb24uIEUuZy4gd2hhdCBoYXBwZW5zIGlmIGFuIHVzZXIgdW5zZWxlY3RzIERSTV9BTURH
UFVfVVNFUlBUUgo+PiBhZnRlciBpdCB3YXMgc2VsZWN0ZWQgaGVyZT8KPj4KPj4gUmVnYXJkcywK
Pj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gUmVnYXJkcywKPj4+ICDCoMKgIEZlbGl4Cj4+Pgo+Pj4KPj4+
PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4gIMKgwqDCoMKgwqDCoCBoZWxwCj4+Pj4+ICDCoMKgwqDC
oMKgwqDCoMKgIEVuYWJsZSB0aGlzIGlmIHlvdSB3YW50IHRvIHVzZSBIU0EgZmVhdHVyZXMgb24g
QU1EIEdQVQo+Pj4+PiBkZXZpY2VzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
