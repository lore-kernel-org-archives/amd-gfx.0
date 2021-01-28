Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE08C43381
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 15:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8DE64DF4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 15:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8DE64DF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D7489179;
	Thu, 28 Jan 2021 15:21:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DC66E984
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 15:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2mmCCq0CXjsEeOjUNeQa6UhRj9VRs9tjmo4Z+miPVU7ynXe03BhJmzwexl6nHSHUWpwQdAzsL4R9cQhDG7iG0jTSieZBMgXdcZk/WfqQJK91KmRum2r6XClK+WlErldVkEK8L60gOz/6GNJD4CBwhInY6JjSJa2bnqd2nND6abBYvsQdUjk7ISiFnyZvICokgfML3EP66U1wSXrn557MX60fP1av+opKj8E9ij8iupkfPuXBcADeSdP/rBlfV20VqkrN5UIvxoyjZmQj0Kz893ztQCpxWrV+mmbmUaPCe8SWvq5lnwhapyx0qwYVvzwLXq117JVL+VVBMftALjjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QumwHyeoF0xKP/iZ29t7qkX4PeAOmcn+zkChEeFZQis=;
 b=Jw2Nq8scQo7kl0nZGHlGumBS0p6+kIiA4gqCvvJVvs4q5OzHET3LPlqBB/DwKPXvJtuI3FtW8g+IsKd3rIyZI8/yYSTU5/aY2sEUkx+Jpao60PNxW0De9kG4V+uvJDN+pBK9bZi++0vztFr8XI0lRGFYW9ht48Sszfly+7ZdyOzxrW+IltYX/7kWr5yA+6UsAoMgdJ1ia27z8yURjzdh80+Hk8THEFomZoHB6YA8+tZDqga6vrmOtoPIU2YSISs4MKJTJuIVnvm7Ed9m9AXONXz4deV4EVeWSQ+BV6pucuMbDPecbWtMo3TujdVHWLFSVHh/8TraR419xlTsEYrSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QumwHyeoF0xKP/iZ29t7qkX4PeAOmcn+zkChEeFZQis=;
 b=12CpaR1g2HuZi22Zya+7My77eOxdry+gBkpR2PMelas6YD3valH8LhcvIIl2v4fvI2KWNxseUPie2ejkGc2mfENzKBIpDWI8M9coIv++8jtf0XD6f/+jIU46pteJlr8ZrOapzYN4f9gPDXAQ1HzycwtC7MHlYmD4lT57YqxDr+Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1132.namprd12.prod.outlook.com (2603:10b6:3:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 28 Jan
 2021 15:21:41 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 15:21:41 +0000
Subject: Re: [RFC PATCH 2/2] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210128143554.61100-1-nirmoy.das@amd.com>
 <20210128143554.61100-2-nirmoy.das@amd.com>
 <0adf796d-c0c8-87cc-e7c0-8a29336385f7@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a44f5a1a-4be3-06a0-764d-23918a51698f@amd.com>
Date: Thu, 28 Jan 2021 16:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <0adf796d-c0c8-87cc-e7c0-8a29336385f7@gmail.com>
Content-Language: en-US
X-Originating-IP: [217.86.126.145]
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.126.145) by
 AM0P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 15:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b244ac55-7bb7-410a-951b-08d8c3a069ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB1132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11323891B929C7F8F9D6CAD08BBA9@DM5PR12MB1132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iwzy41GV+AXEUrWQm/zD8id9ThWWPqAt6WBzu0N31/pbd/hIqNnvkuewBlODICIgHvmKS8xz16FgUGGmafNsNHWCyXHWHNoVHCoNhl4akisKZl09POvQWGISi0flnAfYhSp1K2ctEIt3r3CvvjLLw0DGErweJqT8a7gbzwb3WNDi8LDU4cD0rQFhioFIph1+Z0Sk1ZlE2VPGacMV0oTGfBmpDQJCg5S2IxxDC7vrIiWZRDYavOE6Mi+1VLme/f+avAJWc5aW+l1MxX7lMEh44o7M6h92Y0OCR6yZq2thLRgpBhCHgqg9n0PWpvTqASer00iyg1pfMbkx/m1AnBvxx4xLMtnSfWmtpQVmbSjHIFctONvjCB4t5EL4iNSld6y3m0pUUKNq20uD4ccIBP9jRJeBXpY1ECXB77mUxUaXIgQ2Re8MpfQhBYxCfNEnhonj0SQglNGvt2/h6qsPlz5iOxjxktxqFdnV1N9PTz4BOMss/bLuP9W23TbGu/j/jHazukce+Vrh3kG5s3Lred8a/56pW7293lMJSsY/zP4kplxJ8r+1VX1KWnyfIsy/Z2fr3gnwW/+vvt7uYVwC+xa7WLFyXwjXDXo98FHNo95oYL6LYDIZPytVgY3MUcZHFPErZR425E+IE0BwK64q4u80iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(66556008)(478600001)(956004)(6506007)(966005)(8936002)(186003)(2906002)(6666004)(6512007)(31696002)(16526019)(2616005)(53546011)(36756003)(66574015)(5660300002)(31686004)(26005)(6486002)(45080400002)(4326008)(66476007)(8676002)(83380400001)(66946007)(52116002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WUlQblVIWTEwdkw3Z09YYnlsSVFzRFUweEJZTzhqZ01QbTI5WTd6ZEZjcWYy?=
 =?utf-8?B?NmgwZGFtZWd3VVlhakdjeWo1RmwwWVVDbERQeDUvRkd5N3JNZTZ4dWtQdytD?=
 =?utf-8?B?cnFGMm9Ub2tWemV3MS9KTnNtNTg2UEdmYWRiMUkrQjVmeU9heXVWZEtGZGZC?=
 =?utf-8?B?ZU85ZEU1VnR6cktCSmcvc1ZCc3NQOFA1WWh3YTNFdGdWR1FVTVRzVno1VTIw?=
 =?utf-8?B?ZkRreG9PZS82UFZ6R2wybDJwSStJSVFHOW8zNnFLSlhuM24rOGM0UVhZVGsw?=
 =?utf-8?B?YVkxNHpHZ3BSR1BoL0xpaGJsMGpBc013UXNiL2RjOGpKQkRTSDhvcm80R2RY?=
 =?utf-8?B?L0QwMVE2eFEvOGY5Y0N5MEpYbGdtdWdnTDZSV2JZaVRKcW05K25SZWpIL3BM?=
 =?utf-8?B?RXdPbW9KK2pIbThQUFIzN3hNditlcXBNazVIajBsVHNIZk9tSFpQRVcyazUz?=
 =?utf-8?B?VTdrd0dUbmR5bXZOTjdQZFA0ZnpxakR2NCtxb0NYNmJSZEVYMFpEVHdaUEJa?=
 =?utf-8?B?aksxbTZzRkY4ZG81QlNsOXFYQzA3UENzMVh5Ymw3WUYxa3g5Z1hMc1BObk1k?=
 =?utf-8?B?Q0wrZ0syY1k0bFJHNGJicFE3enVDdGt1VU9ya3YzY3hvRG9Pdk1RQXJ0YXo3?=
 =?utf-8?B?Uy9iK2pzK2pwM1VneWpUVmxsRU9jNXJ5ais5cHpmTFRtYTlDZXJ1cVprK21B?=
 =?utf-8?B?VTZST0Qya3NjT1hrWm1mNERRekhHU2dxREUvQ0xBaE5yNDJxUTVaREhQTnJU?=
 =?utf-8?B?bStXWEdrQVF3cVNZS3dKUHU1VzRlc01WT3FaSUd2ZndheTZMMEVFQkV5UGhl?=
 =?utf-8?B?QU4vcUtybDNrYUIzWFgwUFpWRzNVY0dzU3haaXovV2NNd3VOczBvcFp3ZVEx?=
 =?utf-8?B?Wi9GdVorU3h2ZEZVK2YrMDQyQW1YdXVzRkhrMXBxcndBTGhUQmZxcjVVc3BP?=
 =?utf-8?B?M1FKY3ZNUjdRenlIUmRUbkpxOVJxTE1kL1pKUDJoUGJhc1FrNXl4Rm9pTmNr?=
 =?utf-8?B?YVNzaUhmMElYT2Rpa1Z2VVB6SmE4bmh3VzJGZjJ1UkFKMG55bVIyWng3bTQx?=
 =?utf-8?B?dkxiY01QVjMyYnBhdFZJL0dUeng1QlBlT0RDY2VGRGVTRHFvbEtQQ0RQVXFL?=
 =?utf-8?B?eUxKMGN2TXlwWjZZZEl1L1RpWlJrSlNwTHVTUmFySHFsZjRwK05qWlI5S3Bm?=
 =?utf-8?B?TnltWkc0ZVM3eEFaOU12WGRaN0V6QkVoR1JXRlQ2eTI0c05FNVA3bmNzTW5p?=
 =?utf-8?B?dmFGRmtycUdEQ2pzOUVOTGVuOGNRd2o4a09VVERZeExLTU9PVHVLb2NwbXRq?=
 =?utf-8?B?RkdZNjFjbmt0akpzSjhqTW5Gd2NIMllGYzBmRlhOQ1pMU2pXZmpRaDBiWEF5?=
 =?utf-8?B?VjFCVUdkNnRDU29ZaG0va0RRTndjTGZDVzhRTHJqMjd1MlFkR2N3R0RLcWVH?=
 =?utf-8?Q?x9pKH9ge?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b244ac55-7bb7-410a-951b-08d8c3a069ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 15:21:41.5394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jcjev5/WRmnCA8V7Ua0klhUYj8tQjSfRiexY0pmcU7bGnkUK19dCVsGyQN9JrSo6zIwYiZBKOWSrBCHp+UJMUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1132
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
Cc: Alan.Harrison@amd.com, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEvMjgvMjEgMzo0OSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyOC4wMS4y
MSB1bSAxNTozNSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEVuYWJsZSBnZnggd2F2ZSBsaW1pdGlu
ZyBmb3IgZ2Z4IGpvYnMgYmVmb3JlIHB1c2hpbmcgaGlnaCBwcmlvcml0eQo+PiBjb21wdXRlIGpv
YnMgc28gdGhhdCBoaWdoIHByaW9yaXR5IGNvbXB1dGUgam9icyBnZXRzIG1vcmUgcmVzb3VyY2Vz
Cj4+IHRvIGZpbmlzaCBlYXJseS4KPgo+IFRoZSBwcm9ibGVtIGhlcmUgaXMgd2hhdCBoYXBwZW5z
IGlmIHlvdSBoYXZlIG11bHRpcGxlIGhpZ2ggcHJpb3JpdHkgCj4gam9icyBydW5uaW5nIGF0IHRo
ZSBzYW1lIHRpbWU/CgoKQUZBSVUsIGluIHRoYXQgY2FzZSBxdWFudHVtIGR1cmF0aW9uIHdpbGwg
Y29tZSBpbnRvIGVmZmVjdC4gVGhlIHF1ZXVlIAphcmJpdGVyIHdpbGwgc3dpdGNoCgp0byBuZXh0
IGhpZ2ggcHJpb3JpdHkgYWN0aXZlIHF1ZXVlIG9uY2UgcXVhbnR1bSBkdXJhdGlvbiBleHBpcmVz
LiBUaGlzIApzaG91bGQgYmUgc2ltaWxhciB0byB3aGF0Cgp3ZSBhbHJlYWR5IGhhdmUsIG11bHRp
cGxlIG5vcm1hbCBwcmlvcml0eSBqb2JzIHNoYXJpbmcgR1BVIHJlc291cmNlcyAKYmFzZWQgb24g
Q1BfSFFEX1FVQU5UVU0uCgpRVUVVRV9EVVJBVElPTiByZWdpc3RlciB2YWx1ZS4KCgpSZWdhcmRz
LAoKTmlybW95CgoKPgo+IENocmlzdGlhbgo+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBE
YXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pYi5jIHwgOSArKysrKysrKysKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2liLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2li
LmMKPj4gaW5kZXggMDI0ZDBhNTYzYTY1Li5lZTQ4OTg5ZGZiNGMgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4+IEBAIC0xOTUsNiArMTk1LDEwIEBAIGludCBh
bWRncHVfaWJfc2NoZWR1bGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCAKPj4gdW5zaWduZWQg
bnVtX2licywKPj4gwqDCoMKgwqDCoCBpZiAoKGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX0VN
SVRfTUVNX1NZTkMpICYmIAo+PiByaW5nLT5mdW5jcy0+ZW1pdF9tZW1fc3luYykKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJpbmctPmZ1bmNzLT5lbWl0X21lbV9zeW5jKHJpbmcpOwo+PiDCoCArwqDC
oMKgIGlmIChyaW5nLT5mdW5jcy0+ZW1pdF93YXZlX2xpbWl0ICYmIGpvYiAmJgo+PiArwqDCoMKg
wqDCoMKgwqAgam9iLT5iYXNlLnNfcHJpb3JpdHkgPj0gRFJNX1NDSEVEX1BSSU9SSVRZX0hJR0gp
Cj4+ICvCoMKgwqDCoMKgwqDCoCByaW5nLT5mdW5jcy0+ZW1pdF93YXZlX2xpbWl0KHJpbmcsIHRy
dWUpOwo+PiArCj4+IMKgwqDCoMKgwqAgaWYgKHJpbmctPmZ1bmNzLT5pbnNlcnRfc3RhcnQpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByaW5nLT5mdW5jcy0+aW5zZXJ0X3N0YXJ0KHJpbmcpOwo+PiDC
oCBAQCAtMjk1LDYgKzI5OSwxMSBAQCBpbnQgYW1kZ3B1X2liX3NjaGVkdWxlKHN0cnVjdCBhbWRn
cHVfcmluZyAKPj4gKnJpbmcsIHVuc2lnbmVkIG51bV9pYnMsCj4+IMKgwqDCoMKgwqAgcmluZy0+
Y3VycmVudF9jdHggPSBmZW5jZV9jdHg7Cj4+IMKgwqDCoMKgwqAgaWYgKHZtICYmIHJpbmctPmZ1
bmNzLT5lbWl0X3N3aXRjaF9idWZmZXIpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfcmlu
Z19lbWl0X3N3aXRjaF9idWZmZXIocmluZyk7Cj4+ICsKPj4gK8KgwqDCoCBpZiAocmluZy0+ZnVu
Y3MtPmVtaXRfd2F2ZV9saW1pdCAmJiBqb2IgJiYKPj4gK8KgwqDCoMKgwqDCoMKgIGpvYi0+YmFz
ZS5zX3ByaW9yaXR5ID49IERSTV9TQ0hFRF9QUklPUklUWV9ISUdIKQo+PiArwqDCoMKgwqDCoMKg
wqAgcmluZy0+ZnVuY3MtPmVtaXRfd2F2ZV9saW1pdChyaW5nLCBmYWxzZSk7Cj4+ICsKPj4gwqDC
oMKgwqDCoCBhbWRncHVfcmluZ19jb21taXQocmluZyk7Cj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7
Cj4+IMKgIH0KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q25pcm1veS5kYXMlNDBhbWQuY29tJTdDNzQyODBi
ZTQ2NThkNDI5YzBjZDgwOGQ4YzM5YmUxNDklN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3NDc0NDIxNTYxMTczMzc0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPVRBMnVoNDBVNUMlMkZocnZzaFczcXE4NUJidWJL
bCUyRkxoU3BDNzI1WGlyOVdRJTNEJmFtcDtyZXNlcnZlZD0wIAo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
