Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B2AC2D0F0
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 15:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D702078C
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TO+plp+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D702078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538EC6E954;
	Wed,  1 Apr 2020 15:31:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1946D6E954
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 15:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MebnIKs3Y6WJHxJGcwolPG6fcizrdzq0MAK7TieSTAkjaqwUtvDBgxqB4tW7vTz7zx9upi8wiazbPkesq0w54/yIPzmyyEbo/SZg3GM7CoQf7R9iU5r0vQYKbaaGGFCn6KyG1/T04xv9soqHVhScdTH5mXWEpUqTc0FkmwVuBmrAWfKQaVO+wDPR7EPnfKXiYjLqY7z/Bj9jmHVZuUs7sOBx+51kp8/69j6gk57M5wXI/NGI+2YxtPwv7Czwr+Xcr0m00IjkkD4XtSFWP2TNadNGpOGCCpp/hZ6M89nqzpfTnQgX/krjoFvLMi4kSUEOGjf/pRbNZ1ixae6/ckRj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHYRzGtza9AhdXhcDFGuz6OBaS+Ajx/7nKAcLZfx7Gk=;
 b=fHTSLEIRfOWi+Rrx0qL5Rvmc3QSn0Z40TjbfWh/WfOgrJLGCOQ6fXHvL0bOja/UuUmyf8di7CUDUdP1u9EfeN2lvPrs1Zy/sDqd77fpEm/lIhuu0VIeDOzz3GQMxRI/kOsDFzVnWHrQVfaAFTjTGB8i+3y2M/3pibbS592X9F6p1UKuvie27aUH0RQi6OPhlzm0UsPQa5OcRQGLXu7dBzIOtSNidOUs6G+QmBuHCDO0v5g8rrddeIw/DBZGYxr0WJ0BXbzkZS/WlKdvSb42E889/NJmhQmspsd9Z7ZazejeZC32KP+vXV5hT+rg5lInxiTG009dsy3ApIN3/ZZX9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHYRzGtza9AhdXhcDFGuz6OBaS+Ajx/7nKAcLZfx7Gk=;
 b=TO+plp+H9kwcnUQmGEjzqibt4ncZ3/tCWwZVkmF0w5tTGw1NM2hMJx3Y2dn1v+mx0kFIAPQM6tEkjUJ2PHbW5F4qpdYoHs0pla+8bMLNhqiaxCi/BMdW2ueS9Y8TibOvyc10I7J29cUHrV6hx9OtMsZJTKM8KWkNVwCjqQsbm5s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 15:31:07 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 15:31:07 +0000
Subject: Re: [PATCH v3 1/1] drm/amdgpu: rework sched_list generation
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200330154909.51100-1-nirmoy.das@amd.com>
 <7ee60b3e-5c8b-9af3-499b-f2326c97da7d@amd.com>
 <63c075f4-dd81-6344-6eab-0545941028de@amd.com>
 <94cc257b-641a-44fa-21e1-28bba2e0854b@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a850d639-86de-3369-92dc-617c5599551c@amd.com>
Date: Wed, 1 Apr 2020 17:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <94cc257b-641a-44fa-21e1-28bba2e0854b@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0024.eurprd07.prod.outlook.com
 (2603:10a6:200:42::34) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:1800:463:6d89:d3d:5f49]
 (2003:c5:8f2b:1800:463:6d89:d3d:5f49) by
 AM4PR0701CA0024.eurprd07.prod.outlook.com (2603:10a6:200:42::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.11 via Frontend
 Transport; Wed, 1 Apr 2020 15:31:05 +0000
X-Originating-IP: [2003:c5:8f2b:1800:463:6d89:d3d:5f49]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c5d9ce0-130c-4325-cbf6-08d7d651b237
X-MS-TrafficTypeDiagnostic: MN2PR12MB2878:|MN2PR12MB2878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2878FFDDBB863BE555E1CF5A8BC90@MN2PR12MB2878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(2906002)(31696002)(81156014)(110136005)(478600001)(316002)(8676002)(8936002)(53546011)(2616005)(81166006)(4326008)(36756003)(52116002)(66946007)(16526019)(31686004)(66476007)(186003)(6486002)(66556008)(5660300002)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mJv3b/cSw1nyNL3uAMNpTyfZuB3rfb6uubgHJceHyXYX1lcedRmJTu8IctWUdgpSPKnFaaSs0Z3F5KqBjjcUD0MGO1KZeXZ76xC2vPoZ/0Hv1mGqlNdo07VqilWJoEpG5Qf0YARH7T7W/AOX7k6x1eGIf9aRgMgAik2bKc0RlWAD/G7IkCrWblpK+3xm8UTglVEps63orH+oCjNzQGqSeAcAdp4LdaGaMPUoWm4YAy3DMlabP+mw/2n3B99CtY0VH3KOszbuti71zcF2GHR5VTY1ZISmVPhvY0xpa4gKOpw3IuI46ZZz/0IzKb+lsv3HRoqR+sG7JRiL5zFeIP1IJ59sGQzaBi/UAm5jG4UnnaEVGZ6H0CD6tNq56YSQIpv+8zH2/UPUxbSceUwl/7lPQJ9FLRMTcqP4wkSsKIILO/8RA4wmyG/NNpcnhhGRrT8
X-MS-Exchange-AntiSpam-MessageData: +fUxSuA8+GHZUGJafEDrzIssY0faYXlN6/8Q+z1mHiWASus5xmVeNvo5J2flm43+f+z3N/UN6IXuka4JoP6uNJtCeruYqaiLU0hLysk7GycVR1tQ+pQPxgywBwzrZyZdRbtOwW0SluZLvLgR5GPRBIAKCR1T56noNWezAsnhNNHu9NlMhSuCeX67PfrD7mi9DN6axaWSJdCk7aeqbLLqmw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5d9ce0-130c-4325-cbf6-08d7d651b237
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:31:07.1218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7olJWL8IQfirieqI8So43fZF0uTBcWxDjDi2vabSTb2/s9Aeel7ZCPMP7cc7XYqKKelDjpQJDP2ZsXCOVqzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDQvMS8yMCA1OjAyIFBNLCBMdWJlbiBUdWlrb3Ygd3JvdGU6Cj4gT24gMjAyMC0wMy0zMSAw
ODo0NiwgTmlybW95IHdyb3RlOgo+PiBPbiAzLzMxLzIwIDM6MDEgQU0sIEx1YmVuIFR1aWtvdiB3
cm90ZToKPj4+IFRoaXMgcGF0Y2ggc2VlbXMgdG8gYmUgdXNpbmcgRE9TIGxpbmUtZW5kaW5ncy4K
Pj4KPj4gU3RyYW5nZSwgSSBkb24ndCBzZWUgdGhhdCBpbiBteSBsb2NhbCBwYXRjaCBmaWxlLgo+
Pgo+IE5vdCBzdXJlIHdoeSAiZ2l0IGFtIiBjb21wbGFpbmVkIGFib3V0IERPUyBlbmRpbmdzCj4g
dGhlIGZpcnN0IHRpbWUgSSBkb3dubG9hZGVkIGl0LiBTZWNvbmQgdGltZSB3YXMgZmluZS4KPgo+
IFtzbmlwXT4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+Pj4+IGluZGV4IDI5ZjBh
NDEwMDkxYi4uMjdhYmJkYzYwM2RkIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1LmgKPj4+PiBAQCAtNzIxLDYgKzcyMSwxMSBAQCBzdHJ1Y3QgYW1kX3Bvd2VycGxheSB7
Cj4+Pj4gICAgCWNvbnN0IHN0cnVjdCBhbWRfcG1fZnVuY3MgKnBwX2Z1bmNzOwo+Pj4+ICAgIH07
Cj4+Pj4KPj4+PiArc3RydWN0IGFtZGdwdV9zY2hlZCB7Cj4+Pj4gKwl1aW50MzJfdAkJCW51bV9z
Y2hlZHM7Cj4+Pj4gKwlzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIJKnNjaGVkW0hXSVBfTUFYX0lO
U1RBTkNFXTsKPj4+PiArfTsKPj4+PiArCj4+Pj4gICAgI2RlZmluZSBBTURHUFVfUkVTRVRfTUFH
SUNfTlVNIDY0Cj4+Pj4gICAgI2RlZmluZSBBTURHUFVfTUFYX0RGX1BFUkZNT05TIDQKPj4+PiAg
ICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7Cj4+Pj4gQEAgLTg1OCw2ICs4NjMsOCBAQCBzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSB7Cj4+Pj4gICAgCXN0cnVjdCBhbWRncHVfcmluZwkJKnJpbmdzW0FNREdQ
VV9NQVhfUklOR1NdOwo+Pj4+ICAgIAlib29sCQkJCWliX3Bvb2xfcmVhZHk7Cj4+Pj4gICAgCXN0
cnVjdCBhbWRncHVfc2FfbWFuYWdlcglyaW5nX3RtcF9ib1tBTURHUFVfSUJfUE9PTF9NQVhdOwo+
Pj4+ICsJLyogZHJtIHNjaGVkdWxlciBsaXN0ICovCj4+Pj4gKwlzdHJ1Y3QgYW1kZ3B1X3NjaGVk
CQlncHVfc2NoZWRbQU1ER1BVX0hXX0lQX05VTV1bQU1ER1BVX1JJTkdfUFJJT19NQVhdOwo+Pj4g
VGhhdCdzIGEgMi1kaW1lbnNpb25hbCBhcnJheSBvZiAic3RydWN0IGFtZGdwdV9zY2hlZCIuCj4+
PiBJIHRoaW5rIHRoYXQgdGhlIGNvbW1lbnQgc2hvdWxkIGJlIHJlbW92ZWQsIG9yIGF0IGxlYXN0
Cj4+PiBub3Qgc2F5ICJkcm0gc2NoZWR1bGVyIGxpc3QiLiAoSSBjYW4gc2VlIHRoZSBzdHJ1Y3R1
cmUKPj4+IGRlZmluaXRpb24gYWJvdmUuKQo+Pgo+PiBZZXMgSSBzaG91bGQgcmVtb3ZlIGl0Lgo+
Pgo+Pgo+Pj4gSWYgdGhpcyBpcyB0aGUgcGF0aCB5b3Ugd2FudCB0byBnbywgY29uc2lkZXIgcmVt
b3ZpbmcKPj4+ICJudW1fc2NoZWRzIiBhbmQgY3JlYXRpbmcgYSB0aHJlZSBkaW1lbnNpb25hbCBh
cnJheSwKPj4+IHdoaWNoIHdvdWxkIHJlYWxseSBlc3NlbnRpYWxpemUgdGhlIGRpcmVjdGlvbiB5
b3Ugd2FudAo+Pj4gdG8gZ286Cj4+Pgo+Pj4gc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpncHVf
c2NoZWRbQU1ER1BVX0hXX0lQX05VTV1bQU1ER1BVX1JJTkdfUFJJT19NQVhdW0hXSVBfTUFYX0lO
U1RBTkNFXTsKPj4+Cj4+PiBOb3cgdGhhdCB0aGlzIGFyY2hpdGVjdHVyZSBpcyBzdHJpcHBlZCBk
b3duIHRvIGl0cyBlc3NlbnRpYWxzLAo+Pj4gcGVyaGFwcyB3ZSBjYW4gc2VlIHNvbWUgb3B0aW1p
emF0aW9ucy4uLj8KPj4KPj4gSWYgeW91IG1lYW4gd2hldGhlciB3ZSBzaG91bGQgc2VlIGFueSBw
ZXJmb3JtYW5jZSBpbXByb3ZlbWVudCB0aGVuIGltbwo+PiB3ZSBtYXkgbm90IHNlZSBtdWNoCj4+
Cj4+IGRpZmZlcmVuY2UgYXMgd2UgYXJlIHVzaW5nIHByZXR0eSBtdWNoIHNhbWUgbnVtYmVyIG9m
IG1lbW9yeSBhY2Nlc3MgcGx1cwo+PiBub3cgd2UgaGF2ZSBleHRyYSBjb3N0IG9mIGFycmF5X2lu
ZGV4X25vc3BlYygpLgo+Pgo+PiBBbHNvIHRoaXMgaXPCoCBub3QgaG90IGNvZGUgcGF0aC4gV2Ug
ZG8gb25seSAxCj4+IGFtZGdwdV9jdHhfaW5pdF9lbnRpdHkoKS9IV19JUC9Db250ZXh0Lgo+IE5v
LCB0aGlzIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggInBlcmZvcm1hbmNlIi4KPiBJdCdzIGFsbCBh
Ym91dCBhcmNoaXRlY3R1cmUgYW5kIGRlc2lnbi4KPgo+IFlvdSBzZWVtIHRvIGhhdmUgYXJyYXkt
YXJyYXktc3RydWN0IHdpdGggYXJyYXkgYW5kIGludCwKPiBhbmQgaXQgc2VlbXMgbXVjaCBjbGVh
bmVyIHRvIGp1c3QgaGF2ZSBhcnJheS1hcnJheS1hcnJheS4KPiBJIHRoaW5rIHlvdSBkb24ndCBu
ZWVkIHRvIGJyZWFrIHRoZSBjaGFpbiB3aXRoCj4gc3RydWN0IG9mIGludCBhbmQgYXJyYXksIGp1
c3QgYXMgSSBkZXNjcmliZWQKPiBpbiBteSBjb21tZW50IGJlbG93IHdoaWNoIHlvdSBzbmlwcGVk
IHdpdGhvdXQgYWRkcmVzc2luZyBpdC4KPgo+IElmIHlvdSdyZSBub3QgZ29pbmcgdG8gYWRkcmVz
cyBhIGNvbW1lbnQsIGRvbid0IGRlbGV0ZSBpdCwgbGVhdmUgaXQKPiBmb3Igb3RoZXJzIHRvIHNl
ZSB0aGF0IGl0IGhhc24ndCBiZWVuIGFkZHJlc3NlZC4gT25seQo+IHNuaXAgcHJldmlvdXNseSBh
ZGRyZXNzZWQgYW5kIHJlc29sdmVkIGNvbW1lbnRzIGFuZCBwcmV2aW91c2x5Cj4gc2VlbiBwYXRj
aCBpbmZvLCBsaWtlIGRpZmZzdGF0L2V0Yy4KCgpJIHdhbnRlZCB0b8KgIHVuZGVyc3RhbmQgInJ1
bm5pbmcgcG9pbnRlciIgYmVmb3JlIEkgY291bGQgY29tbWVudCBpbiB0aGVyZS4KCgo+Cj4+PiBB
bHNvIGNvbnNpZGVyIHRoYXQgc2luY2UgeW91J3JlIGNyZWF0aW5nIGFuIGFycmF5IG9mIHBvaW50
ZXJzLAo+Pj4geW91IGRvbid0IG5lY2Vzc2FyaWx5IG5lZWQgdG8ga25vdyB0aGVpciBjb3VudC4g
WW91ciBob3QtcGF0aAo+Pj4gYWxnb3JpdGhtcyBzaG91bGQgbm90IG5lZWQgdG8ga25vdyBpdC4g
SWYgeW91IG5lZWQgdG8gcHJpbnQKPj4+IHRoZWlyIGNvdW50LCBzYXkgaW4gc3lzZnMsIHRoZW4g
eW91IGNhbiBjb3VudCB0aGVtIHVwIG9uCj4+PiBiZWhhbGYgb2YgdGhlIHVzZXItc3BhY2UgcHJv
Y2VzcyBjYXQtaW5nIHRoZSBzeXNmcyBlbnRyeS4KPj4+Cj4gW3NuaXBdCj4KPj4+PiArCj4+Pj4g
KwkvKiBzZXQgdG8gZGVmYXVsdCBwcmlvIGlmIHNjaGVkX2xpc3QgaXMgTlVMTCAqLwo+Pj4+ICsJ
aWYgKCFhZGV2LT5ncHVfc2NoZWRbaHdfaXBdW2h3X3ByaW9dLm51bV9zY2hlZHMpCj4+Pj4gKwkJ
aHdfcHJpbyA9IEFNREdQVV9SSU5HX1BSSU9fREVGQVVMVDsKPj4+IFRoYXQgY29tbWVudCBpcyBh
IGJpdCBjb25mdXNpbmctLWl0IHRhbGtzIGFib3V0IGEgbGlzdAo+Pj4gbm90IGJlaW5nIE5VTEws
IHdoaWxlIHRoZSBjb25kaXRpb25hbCBpbXBsaWNpdGx5IGNoZWNrcwo+Pj4gYWdhaW5zdCAwLgo+
Pgo+PiBZZXMsIHRoaXMgaXMgd3JvbmcsIHdpbGwgcmVtb3ZlIGl0Lgo+Pgo+PiA8c25pcD4KPj4K
PiBJIHdpc2ggeW91IGhhZG4ndCBzbmlwcGVkIG15IGNvbW1lbnQgaGVyZSwgYnV0IGFkZHJlc3Mg
aXQKPiBvbmUgd2F5IG9yIHRoZSBvdGhlci4gSXQgaXM6Cj4KPiBJJ2QgbXVjaCByYXRoZXIgdGhh
dCBpbnRlZ2VyIGNvbXBhcmlzb24gYmUgcGVyZm9ybWVkIGFnYWluc3QKPiBpbnRlZ2VycywgYXMg
b3Bwb3NlZCB0byB1c2luZyBsb2dpY2FsIE5PVCBvcGVyYXRvciAod2hpY2ggaXMKPiBpbXBsaWNp
dCBpbiBjb21wYXJpbmcgYWdhaW5zdCAwKSwgaS5lLiwKPgo+IGlmIChhZGV2LT5ncHVfc2NoZWRb
aHdfaXBdW2h3X3ByaW9dLm51bV9zY2hlZHMgPT0gMCkKPgo+IEFsc28sIGFyY2hpdGVjdHVyYWxs
eSwgdGhlcmUgc2VlbXMgdG8gYmUgaW5mb3JtYXRpb25hbAo+IHJlZHVuZGFuY3ksIGluIGtlZXBp
bmcgYW4gaW50ZWdlciBjb3VudCBhbmQgbGlzdCBvZgo+IG9iamVjdHMgYXQgdGhlIHNhbWUgdGlt
ZSwgYXMgdGhlIGFib3ZlIGlmLWNvbmRpdGlvbmFsCj4gZXhwb3NlczogdGhlIGNvbW1lbnQgdGFs
a3MgYWJvdXQgYSBsaXN0IGFuZCBOVUxMIGJ1dAo+IHRoZSBpZi1jb25kaXRpb25hbCBpbXBsaWNp
dGx5IGNoZWNrcyBmb3IgMC4KCgpOdW1iZXIgb2YgdmFsaWQgZHJtIHNjaGVkdWxlciBpbiBhZGV2
LT5ncHVfc2NoZWRbaHdfaXBdW2h3X3ByaW9dLnNjaGVkIAp3aWxsIHZhcnkgZGVwZW5kaW5nIG9u
IHByaW9yaXR5IGFuZCBod19pcC4KCldlIG5lZWQgdG8gcGFzcyB0aGF0IHNjaGVkdWxlcsKgIGFy
cmF5IGFuZCBudW1fc2NoZWRzIHRvIApkcm1fc2NoZWRfZW50aXR5X2luaXQoKS4gSSB0aGluayB3
ZSBvZnRlbiB1c2UKCmFycmF5IGFuZCBpbnRlZ2VyIGNvdW50IHRvZ2V0aGVyIHdoZW4gdGhlIG51
bWJlciBvZiB2YWxpZCBpdGVtcyBpbiB0aGUgCmFycmF5IGlzIGR5bmFtaWMuCgoKPgo+IFBlcmhh
cHMsIHdlIGRvbid0IG5lZWQgIm51bV9zY2hlZHMiIGFuZCB5b3UgY2FuIGp1c3QKPiBjaGVjayBp
ZiB0aGUgaW5kZXggaXMgTlVMTCBhbmQgYXNzaWduIFBSSU9fREVGQVVMVC4KPgo+Pj4gQEAgLTI1
OCw2ICsyNzIsMTIgQEAgaW50IGFtZGdwdV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPj4+ICAgIAlyaW5nLT5wcmlvcml0eSA9
IERSTV9TQ0hFRF9QUklPUklUWV9OT1JNQUw7Cj4+PiAgICAJbXV0ZXhfaW5pdCgmcmluZy0+cHJp
b3JpdHlfbXV0ZXgpOwo+Pj4KPj4+ICsJaWYgKHJpbmctPmZ1bmNzLT50eXBlICE9IEFNREdQVV9S
SU5HX1RZUEVfS0lRKSB7Cj4+PiArCQlod19pcCA9IGFtZGdwdV9yaW5nX3R5cGVfdG9fZHJtX2h3
X2lwW3JpbmctPmZ1bmNzLT50eXBlXTsKPj4+ICsJCW51bV9zY2hlZCA9ICZhZGV2LT5ncHVfc2No
ZWRbaHdfaXBdW2h3X3ByaW9dLm51bV9zY2hlZHM7Cj4+PiArCQlhZGV2LT5ncHVfc2NoZWRbaHdf
aXBdW2h3X3ByaW9dLnNjaGVkWygqbnVtX3NjaGVkKSsrXSA9ICZyaW5nLT5zY2hlZDsKPj4+ICsJ
fQo+Pj4gVGhpcyBzZWVtcyB1bm5lY2Vzc2FyaWx5IGNvbXBsaWNhdGVkLiBQZXJoYXBzIHdlIGNh
biByZW1vdmUKPj4+ICJudW1fc2NoZWRzIiwgYXMgcmVjb21tZW5kZWQgYWJvdmUsIGFuZCBrZWVw
IGEgcnVubmluZyBwb2ludGVyCj4+PiB3aGlsZSBpbml0aWFsaXphdGlvbiBpcyBiZWluZyBkb25l
Li4uPwo+Pgo+PiBXaGF0IGRvIHlvdSBtZWFuIGJ5IHJ1bm5pbmcgcG9pbnRlciA/Cj4gQSAicnVu
bmluZyBwb2ludGVyIiBpcyBhIGxvY2FsIHBvaW50ZXIgeW91J3JlIHVzaW5nIHRlbXBvcmFyaWx5
Cj4gdG8gdHJhdmVyc2UgbWVtb3J5LiBJZiB5b3UgcmVtb3ZlIHRoZSAibnVtX3NjaGVkcyIsIGFz
IG5vdGVkIGluIG15Cj4gcHJldmlvdXMgY29tbWVudCwgdGhlbiB5b3UgY2FuIHVzZSBhIHJ1bm5p
bmcgcG9pbnRlciB0byBjb250YWluCj4gdGhlIG5leHQgZW50cnkgeW91J2QgaW5pdGlhbGl6ZS4K
CgpPa2F5IEkgdW5kZXJzdGFuZCBub3cuIEFzIEkgc2FpZCB3ZSBuZWVkIHRvIGtub3cgdGhlIHZh
bGlkIG51bWJlciBvZiAKc2NoZWR1bGVywqAgaW4gYSBzY2hlZCBhcnJheSBzbyB0aGF0IHdlIGNh
biBwYXNzIHRoYXQgaW5mb3JtYXRpb24gdG8KCmRybV9zY2hlZF9lbnRpdHlfaW5pdCgpIC4KCgpS
ZWdhcmRzLAoKTmlybW95CgoKPgo+IFJlZ2FyZHMsCj4gTHViZW4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
