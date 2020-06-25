Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41DDC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 16:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8859B20775
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 16:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="js83NJxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859B20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C6689FF7;
	Thu, 25 Jun 2020 16:01:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D704A89FF7
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 16:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYFGBkgpmnMRJM9H5CZ8Fw7ySFpCI58tjRSKFrMnL48BE/0Ah1uE+LVQ70xSM9QAWA69FUCvTBOTNldRt+8iy0Rz9IT9sh/NRBgYJH60BWKhkCSq+Yc1TiaZAvKS4h5Qfn9szxEYy4R4kcwfFhmRtrbRhgMMZPhEeMwSwb8q63XrVzyKY35THb8cemzooFkfgANKD4UyorkAdB9uEQUYcFBhch+ywVWp+io9gf8xh13K7MKwwvY7fzkXm0cZNdT+Uzb3COdN7LLHXQsdMn4KkUC3EVNU72tiZFb19VFePiVOUb2vKP/nOu+LqZ3oMbOSuLfxJuORk2o+s1qtbdrrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/NnphgGYnblJd+XCEyZgt5jhSAmnA30VzAfgd0dRMM=;
 b=DAwjcLlwz//gdBprsUIcEtQTC4CPYj81eh+T00kaPM3wlvbT3jZfOWEfLQDQJciyqJ2GLhFX//4eLayeMjQ3M6bjBcjH61jeG8lzakYAGZBkjeoj2+eadSJYHbOylnXMrDkHR7YQjx/B0p1VX8paNJ+vUbcuM0DM8on2c0vJ14f3XRNi0gASFoyx1mS0snLdQjM6SgjEcPqzAP73q9d8DZzpsNcX5A0A8x8KrdwxGRs+86nXcFT7CKrTSpbgc5lAnHutjnuLrgH0VT9Sdi3ItU7H5p+aoaK/WXkTbKajB6fi9NFD3LT12I8USQOuUObcyN18C8zcLfLOagy/XcGkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/NnphgGYnblJd+XCEyZgt5jhSAmnA30VzAfgd0dRMM=;
 b=js83NJxEpxSw9pU0mdDpLB87dTpf5OFwD6AZxtTWH2Jnt66NuPiglYyH/HdPIl3Lmq2gZHpqhyILiFDUrquGMkABo83Xy7dHWsGSeLsOYxIt2pME18soqlHCeTC2H9psO92cwxdcqy7+W4huJq8wBAEB3uUF7WiegYJX1VrOY04=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Thu, 25 Jun
 2020 16:01:22 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 16:01:22 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
 <20200625031834.16122-2-Felix.Kuehling@amd.com>
 <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
 <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
 <841359ec-a1cd-7722-55e6-182b6e2b6578@amd.com>
 <e3261861-cec0-09da-3632-be8e25a22844@amd.com>
 <abdd1def-1407-65f0-33b8-981efd5c6817@amd.com>
 <1960cd33-03f1-f79a-7dd1-320577ae4121@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4c2d9e27-864c-0086-6167-97fe1483b183@amd.com>
Date: Thu, 25 Jun 2020 18:01:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1960cd33-03f1-f79a-7dd1-320577ae4121@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Thu, 25 Jun 2020 16:01:21 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1db3bcae-a5cf-4b64-4b2b-08d819210171
X-MS-TrafficTypeDiagnostic: DM5PR12MB1321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1321CF75713E2F999785ECE283920@DM5PR12MB1321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0MsJZqUW434xXLa1h5LTtn/2REGp3oLXSAN7yb/mBwptK2ChrxSTcO03ISyBt7kUjDpfR95irlh/6ZwMS8LNre9ol7wRSQobqo7KSCeIVMXtDQtrohN1Omc6O8owpFVPb0MAl7UM+fSIWLMxrQkNe+evJ8w/uqqjqEjNMuyYNBbU3p13H57CbSujJBO+7tBnS46gWrMl3Bdby4OkAyKf4sLWTMrKbbVTK9pWicUf1ODv2by1iUwi4hjgiQYeQWzqvtW2aX0G0DBeHrpJ0KtxOPXo+diTfaXNIqY8O4o5vxqgfHL1AcFhygQCZ420f3mShZVq0Ibr3XNO06uCbeu75nxuKRyKOvZjbMRJD9o1JdEE7a3E4XZATFdTDzk9e/9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(478600001)(2906002)(8936002)(86362001)(52116002)(31696002)(31686004)(8676002)(66946007)(66556008)(66476007)(316002)(36756003)(16526019)(186003)(83380400001)(2616005)(6486002)(6666004)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4WlGgT8Md9eUXC4WgDyJEG/Qt5OjJE6W/upvKKhueO/v+eCOeMShMki74C36agV2DSUujUgFi0b0kAby+CUetAwpK/+c7GzgWBDA4zVqSrMEOP9PcgCzBCu37SFBOY6t16dzZhluUiHfXGgxi++JLARMiE5ZRVh5Q2gXPbhNTHRUQFqGj0Je4+qlxrsnL6UEER3Sel66OHCSzBoq7xYg/tWGhvjwnNtLjovSH/dlfuq4E3NwumFGmC7JWhL1jd86sISISt+tLCrdPdEPl8a3QmMLFpO6gLiAkbLu5R403+cHGTPhGxEcVeQPvew+gL9qP88auqnPBkEB4fwd5QSnC2b4c8OSqnGuoq1Me+FygqniHtWrbkAvoa+vI+c1z+hnvyIksXMksLE1GTQOF3kmgyK62LeQYeLO7GUsBr5UCM7YGJQQseUtHkkeKnpORIDMdI+8WmOTo3/pQyJzFTPL2SlufNcxSwXJLL6RoHFBTm8XgBtn+a3emhIBT8d8y5IQyV7UPvtpAerDVs27Y+IZ2XgpYi8b6+t1Xq9w1U9ndrdd+/AzQ8qSIQAUJtCU9Cjo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db3bcae-a5cf-4b64-4b2b-08d819210171
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 16:01:22.3454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbOe05Ca02YAnu7RKl3UQlqEaxxKN8n0BjSElw7acBfgIbal83hUk8e9uYiTaj6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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

QW0gMjUuMDYuMjAgdW0gMTc6NTggc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTA2
LTI1IHVtIDExOjUwIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+PiBBbSAyNS4wNi4y
MCB1bSAxNzo0MyBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4gQW0gMjAyMC0wNi0yNSB1bSAx
MTozOCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+PiBBbSAyNS4wNi4yMCB1bSAx
NzoxNSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4+PiBBbSAyMDIwLTA2LTI1IHVtIDQ6MTkg
YS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+Pj4+PiBBbSAyNS4wNi4yMCB1bSAwNTox
OCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4+Pj4+IFdoZW4gdGhlcmUgaXMgbm8gZ3JhcGhp
Y3Mgc3VwcG9ydCwgS0ZEIGNhbiB1c2UgbW9yZSBvZiB0aGUgVk1JRHMuCj4+Pj4+Pj4gR3JhcGhp
Y3MKPj4+Pj4+PiBWTUlEcyBhcmUgb25seSB1c2VkIGZvciB2aWRlbyBkZWNvZGluZy9lbmNvZGlu
ZyBhbmQgcG9zdCBwcm9jZXNzaW5nLgo+Pj4+Pj4+IFdpdGgKPj4+Pj4+PiB0d28gVkNFIGVuZ2lu
ZXMsIHRoZXJlIGlzIG5vIHJlYXNvbiB0byByZXNlcnZlIG1vcmUgdGhhbiAyIFZNSURzIGZvcgo+
Pj4+Pj4+IHRoYXQuCj4+Pj4+PiBJSVJDIHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IHdlIHN0aWxs
IHVzZSB0aGUgY29tcHV0ZSBxdWV1ZXMgZm9yIHBvc3QKPj4+Pj4+IHByb2Nlc3NpbmcgYW5kIG5v
dCB0aGUgS0ZELgo+Pj4+Pj4KPj4+Pj4+IFNvIHdlIHdpbGwgbmVlZCBhdCBsZWFzdCBWTUlEcyBm
b3IgdGhhdCBhcyB3ZWxsLgo+Pj4+PiBDb3JyZWN0LiBQb3N0IHByb2Nlc3NpbmcgdXNlcyBjb21w
dXRlIHF1ZXVlcyBhbmQgVk1JRHMgaW4gdGhlIEdGWEhVQi4KPj4+Pj4gVkNFIHVzZXMgVk1JRHMg
aW4gdGhlIE1NSFVCLiBJIGJlbGlldmUgaW4gTWVzYSB0aGV5IHVzZSB0aGUgc2FtZSBWTQo+Pj4+
PiBjb250ZXh0LiBTbyBjYW4ndCB0aGV5IHNoYXJlIHRoZSBzYW1lIFZNSURzPwo+Pj4+IEFoISBH
b29kIHBvaW50LCBCdXQgd2Ugc3RpbGwgbmVlZCBhdCBsZWFzdCAzIFZNSUQgd2hlbiBWTUlECj4+
Pj4gcmVzZXJ2YXRpb24gaXMgYWN0aXZlLgo+Pj4gSSBkb24ndCBrbm93IGFueXRoaW5nIGFib3V0
IHRoYXQgVk1JRCByZXNlcnZhdGlvbiBmZWF0dXJlLiBXaGF0IGlzIGl0Cj4+PiB1c2VkIGZvcj8g
V2hvIGlzIHVzaW5nIGl0PyBIb3cgbWFueSBWTUlEcyBjYW4gYmUgcmVzZXJ2ZWQ/Cj4+Pgo+Pj4g
SWYgb25lIFZNSUQgaXMgcmVzZXJ2ZWQsIHRoZXJlIHdvdWxkIHN0aWxsIGJlIG9uZSBWTUlEIGxl
ZnQgZm9yIHZpZGVvCj4+PiBwb3N0IHByb2Nlc3NpbmcuIFRoYXQncyBub3QgaWRlYWwsIGJ1dCBJ
IGRvbid0IHRoaW5rIGl0IHdvdWxkIGJlIGZhdGFsLgo+Pj4gQnV0IGlzIGl0IGEgcmVhbGlzdGlj
IHVzZSBjYXNlIHRoYXQgVk1JRCByZXNlcnZhdGlvbiBhbmQgUk9DbSt2aWRlbwo+Pj4gcHJvY2Vz
c2luZyB3b3VsZCBoYXBwZW4gb24gdGhlIHNhbWUgc3lzdGVtIGF0IHRoZSBzYW1lIHRpbWU/Cj4+
IFZNSUQgcmVzZXJ2YXRpb24gaXMgdXNlZCBmb3IgZGVidWdnaW5nIGFuZCB5ZXMgdGhlcmUgY2Fu
IG9ubHkgYmUgb25lCj4+IHJlc2VydmVkLgo+Pgo+PiBCdXQgSSB0aGluayB3ZSBuZWVkIGF0IGxl
YXN0IHR3byBmb3IgZHluYW1pYyBhc3NpZ25tZW50IG9yIHdlIG1pZ2h0Cj4+IHJ1biBpbnRvIGEg
QlVHX09OKCkgd2hpbGUgZ2l2aW5nIFZNSURzIHRvIGpvYnMuCj4gSSBkb24ndCBzZWUgYW55IEJV
R3Mgb3IgQlVHX09OcyBpbiBhbWRncHVfaWRzLmMuIFdoYXQgc2hvdWxkIEkgYmUKPiBsb29raW5n
IG91dCBmb3I/CgpXZSB1c2VkIHRvIGhhdmUgYSBCVUdfT04oKSB3aGVuIHdlIGNvdWxkbid0IGZp
bmQgYSBWTUlEIGFzIGFsdGVybmF0aXZlIAppZiB0aGUgcHJvY2VzcyBhbHJlYWR5IGhhcyBvbmUg
YnV0IG5lZWRzIHRvIGZsdXNoIGl0LgoKQnV0IGl0J3MgYSBsb25nIHRpbWUgYWdvIHRoYXQgSSBs
YXN0IGxvb2tlZCBpbnRvIHRoaXMuCgo+PiBCdXQgSSBjZXJ0YWlubHkgbmVlZCB0byB0ZXN0IHRo
aXMgYXMgd2VsbC4gSXQncyBwb3NzaWJsZSB0aGF0IDEgVk1JRAo+PiBpbmRlZWQgd29ya3MgYXMg
ZXhwZWN0ZWQuCj4gSSBjb3VsZCBydW4gdGhlIHRlc3QsIGlmIHlvdSBkZXNjcmliZSB0aGUgcHJv
YmxlbWF0aWMgc2NlbmFyaW8geW91IGhhdmUKPiBpbiBtaW5kLgoKSnVzdCB0cnkgdG8gc2V0IHRo
ZSBhdmFpbGFibGUgVk1JRHMgdG8gMSBhbmQgc2VlIGlmIEdGWC9Db21wdXRlIGFuZCBNTSAKc3Vi
bWlzc2lvbiB3b3JrIGF0IHRoZSBzYW1lIHRpbWUgZnJvbSBtdWx0aXBsZSBwcm9jZXNzZXMuCgpB
IGZldyBVVkQgdmlkZW8gcGxheWJhY2tzIGF0IHRoZSBzYW1lIHRpbWUgc2hvdWxkIGRvIHRoZSBq
b2IuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gVGhhbmtzLAo+ICDCoCBGZWxpeAo+Cj4KPj4g
UmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gVGhhbmtzLAo+Pj4gIMKgwqAgRmVsaXgKPj4+
Cj4+Pgo+Pj4+IEkgZG9uJ3QgdGhpbmsgeW91IGNhbiBnbyBiZWxvdyB0aGlzLgo+Pj4+Cj4+Pj4g
UmVnYXJkcywKPj4+PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4gUmVnYXJkcywKPj4+Pj4gIMKgwqDC
oCBGZWxpeAo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Pj4+Pj4+IC0tLQo+Pj4+Pj4+ICDCoMKgwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDExICsrKysrKysrLS0tCj4+Pj4+
Pj4gIMKgwqDCoCAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMKPj4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMKPj4+Pj4+PiBpbmRleCA2ZTEwYjQyYzU3ZTUuLjM0NzA5MjllNWI4ZSAxMDA2NDQKPj4+Pj4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+Pj4+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+Pj4+Pj4+IEBAIC0xMjQ1
LDEwICsxMjQ1LDE1IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUp
Cj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIC8qCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgKiBu
dW1iZXIgb2YgVk1zCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgKiBWTUlEIDAgaXMgcmVzZXJ2
ZWQgZm9yIFN5c3RlbQo+Pj4+Pj4+IC3CoMKgwqDCoCAqIGFtZGdwdSBncmFwaGljcy9jb21wdXRl
IHdpbGwgdXNlIFZNSURzIDEtNwo+Pj4+Pj4+IC3CoMKgwqDCoCAqIGFtZGtmZCB3aWxsIHVzZSBW
TUlEcyA4LTE1Cj4+Pj4+Pj4gK8KgwqDCoMKgICogYW1kZ3B1IGdyYXBoaWNzL2NvbXB1dGUgd2ls
bCB1c2UgVk1JRHMgMS4ubi0xCj4+Pj4+Pj4gK8KgwqDCoMKgICogYW1ka2ZkIHdpbGwgdXNlIFZN
SURzIG4uLjE1Cj4+Pj4+Pj4gK8KgwqDCoMKgICoKPj4+Pj4+PiArwqDCoMKgwqAgKiBUaGUgZmly
c3QgS0ZEIFZNSUQgaXMgOCBmb3IgR1BVcyB3aXRoIGdyYXBoaWNzLCAzIGZvcgo+Pj4+Pj4+ICvC
oMKgwqDCoCAqIGNvbXB1dGUtb25seSBHUFVzLiBPbiBjb21wdXRlLW9ubHkgR1BVcyB0aGF0IGxl
YXZlcyAyIFZNSURzCj4+Pj4+Pj4gK8KgwqDCoMKgICogZm9yIHZpZGVvIHByb2Nlc3NpbmcuCj4+
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4+Pj4+PiAtwqDCoMKgIGFkZXYtPnZtX21hbmFn
ZXIuZmlyc3Rfa2ZkX3ZtaWQgPSA4Owo+Pj4+Pj4+ICvCoMKgwqAgYWRldi0+dm1fbWFuYWdlci5m
aXJzdF9rZmRfdm1pZCA9Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX0FSQ1RVUlVTID8gMyA6IDg7Cj4+Pj4+Pj4gIMKgwqDCoCDCoMKgwqDCoMKgIGFtZGdw
dV92bV9tYW5hZ2VyX2luaXQoYWRldik7Cj4+Pj4+Pj4gICAgICAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
