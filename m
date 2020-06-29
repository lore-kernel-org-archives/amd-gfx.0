Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E218C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF9C23D20
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ic77pJJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF9C23D20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9023989F0B;
	Mon, 29 Jun 2020 12:28:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C316A89F0B
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 12:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzL+GIODST4L9hf09kCZTvFnWYzPWNqsT026JXW7Bwa6sOOmPmmLjnbT6Nj4sQ+h2R2RYrSDwIRiCFKUHJpO6me1mHYJQn3vbpYrhndXMsi+GEHAFqfdfOwLt5un+V9MyERUVWqqgNWD1zwvwXe4V/u/OX7i0nlLr9lyI+o7WQRt2YzGuPYG51hCBCTP7BqmPHzflzopGwkNkBXZNiZBTkP63TrE6V5O+GHEUkuGxdwS2xlsjEBILdlRcps8CSkdZg4VJpa6ijXah7rnG8vJR1Vtccx85HCJTlbMCOafU3szZBIaEP+4VetDXUgQJw2Qv4aXvBiv1ZBnq4dChTlPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqPntE40a0lfQbGrrKxdg2ZQbauTemv7BoBjKFfU9qM=;
 b=HJCviFjpGRJTsjdE3YLzcMQq/gHCyD5uWIqdNb/7yu+c4JPqw2XcIjAcUL61lOtA1eZrxY8ONZCiOrfIax4xmQI1Y4E3s4IwB5tMrBHZi0y6d5Z0lF/fK1QvbS+g59gqa+IrCN47PU/lQhz6GpRg80YVCSfctjMy3LiORwZMQPXAPHVOlZirftFvNJe7Tz7V0U4wEIX3iWbi03lKZ9bRTNYT0UV3JqDFLZawZmxJK4BSws0yGJa1kVavlz0CUPzu9AEwl8DRPnrWWCc94TJWwNnMiuioxwyOzyFk73lZ5vaTCs3/nJMAzvGlzBvxHAXjULy/l29HtndbuCFpFhaG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqPntE40a0lfQbGrrKxdg2ZQbauTemv7BoBjKFfU9qM=;
 b=ic77pJJkBUPe6SurpaQVoJhjuEWD44JvdpXk9I7U/oGU6apqHxAg2xnK19DGVvjdYi+a/ySfpv62E8Wq8MHGBB8xYv9hhMWQ2tFepkG2bJn7Fjo//rQLav/4HpTjDkRuzmtXoPVqSzmpp3w9JW9hyxVpd7mkPoj6Pp5GHcS35e0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3727.namprd12.prod.outlook.com (2603:10b6:208:15a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 12:28:47 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 12:28:47 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix compile warning in amdgpu_fru_read_eeprom
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200629121313.18064-1-kent.russell@amd.com>
 <ade43f8c-6ea1-ea69-d173-323e1d1f1867@gmail.com>
 <DM6PR12MB3721818B463CF5BE7BFD5F72856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <10dc15f9-4657-12bb-70ba-fa44ea137c88@amd.com>
Date: Mon, 29 Jun 2020 14:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DM6PR12MB3721818B463CF5BE7BFD5F72856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0078.eurprd05.prod.outlook.com
 (2603:10a6:208:136::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR05CA0078.eurprd05.prod.outlook.com (2603:10a6:208:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 12:28:46 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d3929c8-4ea8-4d89-b29b-08d81c27f866
X-MS-TrafficTypeDiagnostic: MN2PR12MB3727:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3727EF286A0171A085913BE1836E0@MN2PR12MB3727.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:222;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVRuvrotsZOlDQ31CNtiVjt8qmsGVQ56ttzC+5JfzLGEc5KUvccdwEpBf3m056TKlIJgpGH0YMrfYMAuBT1xBnezdRm3AIDqlLrRufCXmSfSwoOz87Aj6tPpiEJacTMXvUtohrD6khyHrefWLsgTrEfL2JJ6zyipUl75BqeXkbEVAHIGzzX78ag2QvuJIPBgvoxPvU3adZWRp2J0Qla1J7RsJfKKHU5SFphJiQhrG0mCQXabbYfa2v8xEkUgYyAfO/cy2NbaNzgYEx9yoCutIwHiga0627P4iAtNXSy9lid+bw5HH4nEVDhueTUIo6b3kUYQNdGYqItQKuwWdJQahIuL5ESNLYAh+/0JoA88XYLFXdWoJCK8P4JBo2iKZD9w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(66556008)(36756003)(2616005)(8936002)(53546011)(478600001)(83380400001)(8676002)(31686004)(66574015)(186003)(16526019)(86362001)(31696002)(110136005)(66476007)(6486002)(6666004)(316002)(52116002)(2906002)(66946007)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oIytkEHyNSRstERZQsej4fl531OX/1vZhDG/jJVbp9g4PkgzqjBEkqPt9L2IJ7pDF1ub9yDGwZFz1ZGn7k7bC1+Ai7UCmtq4P1WBGRspmD0FEy2kitnMCBj6buhv1OfuXasDAjgTfia/TX68LKjMn7iE4GVu7tPBeyrYHCJ5MI9NS27XYZIcTfm+9+BlQVSQA++UpxS7elyqil4c7JVxH1a8H9W9BW+GYCrl8IORJkSrAa+pmrCqnm0ek7Q/BGT/UWl11DQUl9/uD7GYN6Rn3wXsXygeZSN/YFL7r58V8/T1NkU14/mlDwTcN877J5RPW3fWmEIWHDkq98o20jfRBEMJ/mrb+NEdv63WUgoQmjeB47Zj1JZd7T8LOO4E3G1xxEK3htKwWe53UVV4UQ6pOBfB0dGqVIJ1j33ZE+XpCjHxuvjBhfEAckPiT33rd42qBgiTDvpaiYPrebkDzHAeGEuny+hHNlua4d+6SOlo+Wpu60TI3kG4Lbzsyn+gIUkGHR7pw3e0TTU3HhInKpq0vDUQ04GAhuPt1U4AN+m3Zb7JnCZ9AzHW3bVXb0Rg0Y3D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3929c8-4ea8-4d89-b29b-08d81c27f866
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 12:28:47.2285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GhGFNjVrP9ZJgQ2HOftKlZKsoXL8SHIr+jcU83gCnnjBFweI4jxm4yaiOrRd9c5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3727
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

T2ssIHRoZW4gd2h5IGRvZXMgaXQgZml4IGEgd2FybmluZyBpZiB3ZSBtYWtlIGl0IG5vbi1zdGF0
aWM/CgpJZiB0aGUgZnVuY3Rpb24gdXNlZCBpdCBjb21waWxlZCB1bmRlciBzb21lICNpZmRlZiB0
aGVuIHdlIHNob3VsZCAKcHJvYmFibHkganVzdCBjb21waWxlIHRoaXMgdW5kZXIgI2lmZGVmIGFz
IHdlbGwuCgpDaHJpc3RpYW4uCgpBbSAyOS4wNi4yMCB1bSAxNDoyMCBzY2hyaWViIFJ1c3NlbGws
IEtlbnQ6Cj4gW0FNRCBQdWJsaWMgVXNlXQo+Cj4gSXQncyB1c2VkIHJlcGVhdGVkbHkgaW4gdGhl
IGFtZGdwdV9mcnVfZ2V0X3Byb2R1Y3RfaW5mbyBmdW5jdGlvbiwgYnV0IG9ubHkgaW4gdGhhdCBm
dW5jdGlvbiB3aGljaCBpcyBpbiB0aGUgYW1kZ3B1X2ZydV9lZXByb20uYyBmaWxlLiBXaGlsZSBp
dCBjb3VsZCBiZSB0aGVvcmV0aWNhbGx5IGJlIHVzZWQgZWxzZXdoZXJlLCBpdCBpc24ndCBjdXJy
ZW50bHkgYW5kIGFueSBvdGhlciB1c2FnZSB3b3VsZCBiZSBiZXN0IGNvbnRhaW5lZCBpbiB0aGUg
YW1kZ3B1X2ZydV9lZXByb20uYyBmaWxlLgo+Cj4gICBLZW50Cj4KPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0KPj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1l
cmtlbkBnbWFpbC5jb20+Cj4+IFNlbnQ6IE1vbmRheSwgSnVuZSAyOSwgMjAyMCA4OjE3IEFNCj4+
IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBj
b21waWxlIHdhcm5pbmcgaW4KPj4gYW1kZ3B1X2ZydV9yZWFkX2VlcHJvbQo+Pgo+PiBBbSAyOS4w
Ni4yMCB1bSAxNDoxMyBzY2hyaWViIEtlbnQgUnVzc2VsbDoKPj4+IFRoaXMgZml4ZXMgdGhlIG1p
c3NpbmctcHJvdG90eXBlcyB3YXJuaW5nIGZvciB0aGUKPj4+IGFtZGdwdV9mcnVfcmVhZF9lZXBy
b20gZnVuY3Rpb24uIFNpbmNlIHdlIGRlY2xhcmUgaXQgaW4gdGhlIGhlYWRlciwgd2UKPj4+IGNh
biBtYWtlIGl0IHVuLXN0YXRpYwo+PiBXZWxsIGlzIGl0IHVzZWQgaW4gZGlmZmVyZW50IGZpbGVz
PyBPdGhlcndpc2Ugd2UgbWlnaHQganVzdCBoYXZlIHVudXNlZCBjb2RlIGluCj4+IHRoZSBtb2R1
bGUgd2hpY2ggY2FuIHBvdGVudGlhbGx5IHJhaXNlIGEgd2FybmluZyBhcyB3ZWxsLgo+Pgo+PiBD
aHJpc3RpYW4uCj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2Vs
bEBhbWQuY29tPgo+Pj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwu
Y29tPgo+Pj4gQ2hhbmdlLUlkOiBJMmI5NDE5MzY1Y2I4YjM4YmNmYjY1ODJkZjUzYjk2YzgzODYx
ZDZjZgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1
X2VlcHJvbS5jIHwgMiArLQo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ZydV9lZXByb20uaCB8IDIgKysKPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYwo+Pj4gaW5kZXggZTgxMWZlY2M1NDBmLi42OGVkMTZl
NGQ4YmUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZnJ1X2VlcHJvbS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZnJ1X2VlcHJvbS5jCj4+PiBAQCAtNDgsNyArNDgsNyBAQCBzdGF0aWMgYm9vbCBpc19mcnVfZWVw
cm9tX3N1cHBvcnRlZChzdHJ1Y3QKPj4gYW1kZ3B1X2RldmljZSAqYWRldikKPj4+ICAgIAlyZXR1
cm4gZmFsc2U7Cj4+PiAgICB9Cj4+Pgo+Pj4gLXN0YXRpYyBpbnQgYW1kZ3B1X2ZydV9yZWFkX2Vl
cHJvbShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+IHVpbnQzMl90IGFkZHJwdHIsCj4+
PiAraW50IGFtZGdwdV9mcnVfcmVhZF9lZXByb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHVpbnQzMl90Cj4+PiArYWRkcnB0ciwKPj4+ICAgIAkJCSAgIHVuc2lnbmVkIGNoYXIgKmJ1ZmYp
Cj4+PiAgICB7Cj4+PiAgICAJaW50IHJldCwgc2l6ZTsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5oCj4+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmgKPj4+IGluZGV4IGYyOWE4NjExZDY5
Yi4uZjQwMjRmMWQ2NmM5IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZydV9lZXByb20uaAo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZydV9lZXByb20uaAo+Pj4gQEAgLTI0LDYgKzI0LDggQEAKPj4+ICAgICNpZm5k
ZWYgX19BTURHUFVfRlJVX0VFUFJPTV9IX18KPj4+ICAgICNkZWZpbmUgX19BTURHUFVfRlJVX0VF
UFJPTV9IX18KPj4+Cj4+PiAraW50IGFtZGdwdV9mcnVfcmVhZF9lZXByb20oc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90Cj4+IGFkZHJwdHIsCj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgY2hhciAqYnVmZik7Cj4+PiAgICBpbnQgYW1kZ3B1X2ZydV9n
ZXRfcHJvZHVjdF9pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPj4+Cj4+PiAgICAj
ZW5kaWYgIC8vIF9fQU1ER1BVX1BST0RJTkZPX0hfXwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
