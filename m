Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FEC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 20:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B742072E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 20:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J0nD8cmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B742072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027D06E34C;
	Thu, 25 Jun 2020 20:39:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147D26E34C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 20:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj1s7lK83C9TVhTn75C9yhzesW11KopZY2bv+GfdIgJg8bryhyVwEFyyRXQe+sUATCT6LLjdXuO9ZHSG9x+1E6+RQCxLlPgQmQFnpRoZfuCNUlaIA5NlFd8pj2bOG8ReAQN81MkPqVaoJvLNR0Z8gaY06xsdHMgY7kqrqn4ZZPHqTcxHp3/rQJs8tnZ2d0R8n4kbDA4zLj0Jwc0CkiTY+5kfrVya1gKUCOx7rlJ4ksY+PP0aDOsBOjevC2KOv8Sp0wJFfiAgX0TJwFulrzMYCsp5eN3DhVYYOI2Sxhq1qaJfDjRV68ob8e1uhERxDoMoHMcItB7LIS5YYtFGkVHhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIT0jxbRzRPP8wJnsN1SZFPbNFvlLNQVw4qBh38HuJc=;
 b=LTXjZgiom2DPN2ycpM60zEykY21KvcXwKbnRYgl986vhRQPcg4VACeCFtGi+kdyOKTIcxhdi7TINQ90T7wjyk1d6zL2Fe6XNuayNOSfkq37YvhvmFnA3ySWRiZOjgjeQQnhrk5HZnPudDedZtlDrGVurTzQQHOUKRexOaHeZuj580FHEz7q1IE6WWgqSYKhvjoP140LQmymUHqAkq08Qy1DMPlRjgZEnvJ11ZLA5ifBa/ADLvR7CSWOxVvnitDLeEPa+nq6qLQC7N1mXlhPIiBgO6pygnl64mmXigKuzAl3yG118/uEn2og1tdNxBXqen3WVj+NgH+glpGt1wP0EJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIT0jxbRzRPP8wJnsN1SZFPbNFvlLNQVw4qBh38HuJc=;
 b=J0nD8cmSNmey4vZFFSq4S29srbP6OKtIPoZNfblQ+9QlvpMNQhddm3Di155HRMj/dyOMDw1Oq+gvYBqXW5S7u9bYjT5Qnk0XI4XwfyWzNbgbkdTd4rI53H18G6BNL2sbYwZVfo5ErtyyVilQmERg07f/KtK4O4tok52lXm2ggW8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2829.namprd12.prod.outlook.com (2603:10b6:805:e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 20:39:35 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Thu, 25 Jun 2020
 20:39:35 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
 <20200625031834.16122-2-Felix.Kuehling@amd.com>
 <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
 <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
 <841359ec-a1cd-7722-55e6-182b6e2b6578@amd.com>
 <e3261861-cec0-09da-3632-be8e25a22844@amd.com>
 <abdd1def-1407-65f0-33b8-981efd5c6817@amd.com>
 <1960cd33-03f1-f79a-7dd1-320577ae4121@amd.com>
 <4c2d9e27-864c-0086-6167-97fe1483b183@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <bcca1d9b-a260-347e-be7c-b57ab4b0a700@amd.com>
Date: Thu, 25 Jun 2020 16:39:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <4c2d9e27-864c-0086-6167-97fe1483b183@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::10) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 20:39:34 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a019e566-e2ce-464d-a9b5-08d81947df08
X-MS-TrafficTypeDiagnostic: SN6PR12MB2829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28299E3FB98116B5F1E91A2092920@SN6PR12MB2829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dp9aQUuMn4a1KsWLXoWNaGHHt1IHebqytwDF7Momm0G6x0sDtxS1fBpjdVBm805CNYAsD77q08PW312zVGVjKCaQEEfED+Yq1GlrzmpXAwh39j0Z7C59SNXPRwdJAdtMH+1T+UrXlOpaS+7PwU2KBLqp+pu24qFaD7NOCS7ol8O0lAhh0afSsQX+JXLWr/nW2tqp4ObfP+TqaO9RjydwLzVRVFXoVcFvNP/MAXSuzmfFZhA55yGfPdkeo2EM47pOybvkBF4J2kWZ5qtENdvg5NigUoNBp2kq70rZ0E/wzJm18RQbOfODlC0JXGycT65h40aY7uIqIsRX8dT/WvfBghl60Sr8zwDvK/kM1UzQOc9OFKNJsCgcjTOHZxp4Ahlj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(6486002)(52116002)(66476007)(66556008)(31696002)(478600001)(31686004)(36916002)(26005)(66946007)(186003)(16526019)(8676002)(86362001)(5660300002)(44832011)(956004)(83380400001)(36756003)(16576012)(66574015)(316002)(2616005)(53546011)(2906002)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aXmvqQRCylanFQePnzFf4xfZ67EYsfJ3eCYSyGRDvxS6fYDLl8nrRimJ8pVG7P4qI1hibXX3PdF17VhRncFgXihR4iik+hDjyoj4fuTnVpL52+LcC94LrbBrcbEPqG7bptjl4DgTibqVDKT89R9Lf1QtPGBW+400/R0bwsBi4sKvi3EkgZteQRrCWP7vd6eJPaIdPSHaFzmnDflEpGsSGoGGpPAXUGDq7+Ug0mDOkur6H+py0+C5RJyGZ7cWiTofHs9/x7fvIqrhQFCmeB7SymPVti8lr9neAKqjJqgMXuis8MiONCb3JrMQ8l9a7KbljQSsVv/8Wfof+QCjGgv6pGdHRYVJgn8pqxUFvJvJDga90UwgE6PCy1KMVmNQpaEYXVQCRLKtpI0orCPs0ZN5vnjzihf8Y6k6yHUdGIHsTq0t5IspgpGozK6OLlWWkpNbaBmv+JqsMwnCy6zLagC5XZqgRP4+uXlrbYzGVSMvQ2DdAax8sttt41+zEBYJuh+V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a019e566-e2ce-464d-a9b5-08d81947df08
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 20:39:34.9793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtna65RJbckz0ooZlvJRpiIG/pgaG6HOh673FelvCX5x83FcVTy1UPsh6F5t33plmWY9WoUYJZ3FTtiggaRN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
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

Ck9uIDIwMjAtMDYtMjUgMTI6MDEgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAy
NS4wNi4yMCB1bSAxNzo1OCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBBbSAyMDIwLTA2LTI1
IHVtIDExOjUwIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4gQW0gMjUuMDYuMjAg
dW0gMTc6NDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4+PiBBbSAyMDIwLTA2LTI1IHVtIDEx
OjM4IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+PiBBbSAyNS4wNi4yMCB1bSAx
NzoxNSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4+Pj4gQW0gMjAyMC0wNi0yNSB1bSA0OjE5
IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+Pj4+IEFtIDI1LjA2LjIwIHVtIDA1
OjE4IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+Pj4+Pj4+IFdoZW4gdGhlcmUgaXMgbm8gZ3Jh
cGhpY3Mgc3VwcG9ydCwgS0ZEIGNhbiB1c2UgbW9yZSBvZiB0aGUgVk1JRHMuCj4+Pj4+Pj4+IEdy
YXBoaWNzCj4+Pj4+Pj4+IFZNSURzIGFyZSBvbmx5IHVzZWQgZm9yIHZpZGVvIGRlY29kaW5nL2Vu
Y29kaW5nIGFuZCBwb3N0IAo+Pj4+Pj4+PiBwcm9jZXNzaW5nLgo+Pj4+Pj4+PiBXaXRoCj4+Pj4+
Pj4+IHR3byBWQ0UgZW5naW5lcywgdGhlcmUgaXMgbm8gcmVhc29uIHRvIHJlc2VydmUgbW9yZSB0
aGFuIDIgCj4+Pj4+Pj4+IFZNSURzIGZvcgo+Pj4+Pj4+PiB0aGF0Lgo+Pj4+Pj4+IElJUkMgdGhl
IGV4cGVjdGF0aW9uIGlzIHRoYXQgd2Ugc3RpbGwgdXNlIHRoZSBjb21wdXRlIHF1ZXVlcyBmb3Ig
Cj4+Pj4+Pj4gcG9zdAo+Pj4+Pj4+IHByb2Nlc3NpbmcgYW5kIG5vdCB0aGUgS0ZELgo+Pj4+Pj4+
Cj4+Pj4+Pj4gU28gd2Ugd2lsbCBuZWVkIGF0IGxlYXN0IFZNSURzIGZvciB0aGF0IGFzIHdlbGwu
Cj4+Pj4+PiBDb3JyZWN0LiBQb3N0IHByb2Nlc3NpbmcgdXNlcyBjb21wdXRlIHF1ZXVlcyBhbmQg
Vk1JRHMgaW4gdGhlIAo+Pj4+Pj4gR0ZYSFVCLgo+Pj4+Pj4gVkNFIHVzZXMgVk1JRHMgaW4gdGhl
IE1NSFVCLiBJIGJlbGlldmUgaW4gTWVzYSB0aGV5IHVzZSB0aGUgc2FtZSBWTQo+Pj4+Pj4gY29u
dGV4dC4gU28gY2FuJ3QgdGhleSBzaGFyZSB0aGUgc2FtZSBWTUlEcz8KPj4+Pj4gQWghIEdvb2Qg
cG9pbnQsIEJ1dCB3ZSBzdGlsbCBuZWVkIGF0IGxlYXN0IDMgVk1JRCB3aGVuIFZNSUQKPj4+Pj4g
cmVzZXJ2YXRpb24gaXMgYWN0aXZlLgo+Pj4+IEkgZG9uJ3Qga25vdyBhbnl0aGluZyBhYm91dCB0
aGF0IFZNSUQgcmVzZXJ2YXRpb24gZmVhdHVyZS4gV2hhdCBpcyBpdAo+Pj4+IHVzZWQgZm9yPyBX
aG8gaXMgdXNpbmcgaXQ/IEhvdyBtYW55IFZNSURzIGNhbiBiZSByZXNlcnZlZD8KPj4+Pgo+Pj4+
IElmIG9uZSBWTUlEIGlzIHJlc2VydmVkLCB0aGVyZSB3b3VsZCBzdGlsbCBiZSBvbmUgVk1JRCBs
ZWZ0IGZvciB2aWRlbwo+Pj4+IHBvc3QgcHJvY2Vzc2luZy4gVGhhdCdzIG5vdCBpZGVhbCwgYnV0
IEkgZG9uJ3QgdGhpbmsgaXQgd291bGQgYmUgCj4+Pj4gZmF0YWwuCj4+Pj4gQnV0IGlzIGl0IGEg
cmVhbGlzdGljIHVzZSBjYXNlIHRoYXQgVk1JRCByZXNlcnZhdGlvbiBhbmQgUk9DbSt2aWRlbwo+
Pj4+IHByb2Nlc3Npbmcgd291bGQgaGFwcGVuIG9uIHRoZSBzYW1lIHN5c3RlbSBhdCB0aGUgc2Ft
ZSB0aW1lPwo+Pj4gVk1JRCByZXNlcnZhdGlvbiBpcyB1c2VkIGZvciBkZWJ1Z2dpbmcgYW5kIHll
cyB0aGVyZSBjYW4gb25seSBiZSBvbmUKPj4+IHJlc2VydmVkLgo+Pj4KPj4+IEJ1dCBJIHRoaW5r
IHdlIG5lZWQgYXQgbGVhc3QgdHdvIGZvciBkeW5hbWljIGFzc2lnbm1lbnQgb3Igd2UgbWlnaHQK
Pj4+IHJ1biBpbnRvIGEgQlVHX09OKCkgd2hpbGUgZ2l2aW5nIFZNSURzIHRvIGpvYnMuCj4+IEkg
ZG9uJ3Qgc2VlIGFueSBCVUdzIG9yIEJVR19PTnMgaW4gYW1kZ3B1X2lkcy5jLiBXaGF0IHNob3Vs
ZCBJIGJlCj4+IGxvb2tpbmcgb3V0IGZvcj8KPgo+IFdlIHVzZWQgdG8gaGF2ZSBhIEJVR19PTigp
IHdoZW4gd2UgY291bGRuJ3QgZmluZCBhIFZNSUQgYXMgYWx0ZXJuYXRpdmUgCj4gaWYgdGhlIHBy
b2Nlc3MgYWxyZWFkeSBoYXMgb25lIGJ1dCBuZWVkcyB0byBmbHVzaCBpdC4KPgo+IEJ1dCBpdCdz
IGEgbG9uZyB0aW1lIGFnbyB0aGF0IEkgbGFzdCBsb29rZWQgaW50byB0aGlzLgo+Cj4+PiBCdXQg
SSBjZXJ0YWlubHkgbmVlZCB0byB0ZXN0IHRoaXMgYXMgd2VsbC4gSXQncyBwb3NzaWJsZSB0aGF0
IDEgVk1JRAo+Pj4gaW5kZWVkIHdvcmtzIGFzIGV4cGVjdGVkLgo+PiBJIGNvdWxkIHJ1biB0aGUg
dGVzdCwgaWYgeW91IGRlc2NyaWJlIHRoZSBwcm9ibGVtYXRpYyBzY2VuYXJpbyB5b3UgaGF2ZQo+
PiBpbiBtaW5kLgo+Cj4gSnVzdCB0cnkgdG8gc2V0IHRoZSBhdmFpbGFibGUgVk1JRHMgdG8gMSBh
bmQgc2VlIGlmIEdGWC9Db21wdXRlIGFuZCBNTSAKPiBzdWJtaXNzaW9uIHdvcmsgYXQgdGhlIHNh
bWUgdGltZSBmcm9tIG11bHRpcGxlIHByb2Nlc3Nlcy4KPgo+IEEgZmV3IFVWRCB2aWRlbyBwbGF5
YmFja3MgYXQgdGhlIHNhbWUgdGltZSBzaG91bGQgZG8gdGhlIGpvYi4KCkkgdGVzdGVkIGl0IG9u
IEZpamkgd2l0aCBmaXJzdF9rZmRfdm1pZD0yLCBydW5uaW5nIDMgaW5zdGFuY2VzIG9mIFZMQyAK
cGxheWluZyBhIDEwODBwIGguMjY0IHZpZGVvIHVzaW5nIFZEUEFVLiAoRm9yIHNvbWUgcmVhc29u
IFZBLUFQSSBpcyAKYnJva2VuOiB2YURlcml2ZUltYWdlOiBvcGVyYXRpb24gZmFpbGVkKS4gSnVz
dCB0byBiZSBzdXJlIGl0IHdhcyByZWFsbHkgCnVzaW5nIFVWRCwgSSBkaXNhYmxlZCBIVyBhY2Nl
bGVyYXRpb24gaW4gVkxDIGFuZCBzYXcgQ1BVIHVzYWdlIGluY3JlYXNlLiAKRXZlcnl0aGluZyBz
ZWVtcyB0byBiZSB3b3JraW5nIGZpbmUuCgpSZWdhcmRzLAogwqAgRmVsaXgKCgo+Cj4gUmVnYXJk
cywKPiBDaHJpc3RpYW4uCj4KPj4KPj4gVGhhbmtzLAo+PiDCoMKgIEZlbGl4Cj4+Cj4+Cj4+PiBS
ZWdhcmRzLAo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+PiBUaGFua3MsCj4+Pj4gwqDCoMKgIEZlbGl4
Cj4+Pj4KPj4+Pgo+Pj4+PiBJIGRvbid0IHRoaW5rIHlvdSBjYW4gZ28gYmVsb3cgdGhpcy4KPj4+
Pj4KPj4+Pj4gUmVnYXJkcywKPj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pgo+Pj4+Pj4gUmVnYXJkcywK
Pj4+Pj4+IMKgwqDCoMKgIEZlbGl4Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4+Pj4+Pj4+IC0tLQo+
Pj4+Pj4+PiDCoMKgwqDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwg
MTEgKysrKysrKystLS0KPj4+Pj4+Pj4gwqDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Pj4+Pj4KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+Pj4+Pj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+Pj4+Pj4+IGluZGV4IDZlMTBiNDJjNTdlNS4u
MzQ3MDkyOWU1YjhlIDEwMDY0NAo+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMKPj4+Pj4+Pj4gQEAgLTEyNDUsMTAgKzEyNDUsMTUgQEAgc3RhdGljIGludCBn
bWNfdjlfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAv
Kgo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBudW1iZXIgb2YgVk1zCj4+Pj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCAqIFZNSUQgMCBpcyByZXNlcnZlZCBmb3IgU3lzdGVtCj4+Pj4+Pj4+
IC3CoMKgwqDCoCAqIGFtZGdwdSBncmFwaGljcy9jb21wdXRlIHdpbGwgdXNlIFZNSURzIDEtNwo+
Pj4+Pj4+PiAtwqDCoMKgwqAgKiBhbWRrZmQgd2lsbCB1c2UgVk1JRHMgOC0xNQo+Pj4+Pj4+PiAr
wqDCoMKgwqAgKiBhbWRncHUgZ3JhcGhpY3MvY29tcHV0ZSB3aWxsIHVzZSBWTUlEcyAxLi5uLTEK
Pj4+Pj4+Pj4gK8KgwqDCoMKgICogYW1ka2ZkIHdpbGwgdXNlIFZNSURzIG4uLjE1Cj4+Pj4+Pj4+
ICvCoMKgwqDCoCAqCj4+Pj4+Pj4+ICvCoMKgwqDCoCAqIFRoZSBmaXJzdCBLRkQgVk1JRCBpcyA4
IGZvciBHUFVzIHdpdGggZ3JhcGhpY3MsIDMgZm9yCj4+Pj4+Pj4+ICvCoMKgwqDCoCAqIGNvbXB1
dGUtb25seSBHUFVzLiBPbiBjb21wdXRlLW9ubHkgR1BVcyB0aGF0IGxlYXZlcyAyIAo+Pj4+Pj4+
PiBWTUlEcwo+Pj4+Pj4+PiArwqDCoMKgwqAgKiBmb3IgdmlkZW8gcHJvY2Vzc2luZy4KPj4+Pj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgICovCj4+Pj4+Pj4+IC3CoMKgwqAgYWRldi0+dm1fbWFuYWdl
ci5maXJzdF9rZmRfdm1pZCA9IDg7Cj4+Pj4+Pj4+ICvCoMKgwqAgYWRldi0+dm1fbWFuYWdlci5m
aXJzdF9rZmRfdm1pZCA9Cj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBhZGV2LT5hc2ljX3R5cGUg
PT0gQ0hJUF9BUkNUVVJVUyA/IDMgOiA4Owo+Pj4+Pj4+PiDCoMKgwqDCoCDCoMKgwqDCoMKgIGFt
ZGdwdV92bV9tYW5hZ2VyX2luaXQoYWRldik7Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
