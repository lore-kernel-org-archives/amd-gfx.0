Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC1C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 16:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B269206DB
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 16:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B269206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AAE6F8A4;
	Thu,  5 Dec 2019 16:10:29 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700063.outbound.protection.outlook.com [40.107.70.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF066F8A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 16:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRFr3DA+5P/mJWXuTFqw0q9bsArNzNJEdDRjQqBVVIUWpOwqZpqAqrzGxcjwGh/RAlGDVuIwEuJ9d6A4X87DZXx2bwrlofukH8clPvdrQoWJV5Gc4rtSDby5TcGZHltLl4lR3fnupNO1RIj72Wyv+KG78sohpGdxR0OnnFl2juix/9SNQdNzXwTJZNsdOhL9Lq/pb+XWGlRJDQRl7p6A+RlQ8NfM7y1tnK3zSErH6AW8wcHH20ALvh7ptYRX/TsU+niXx0A5v+jiRs+AHzroYWnrrW+TgIuZdQxgp5TBB0ST8VvfC2lsIuIqJCU1m5R4CNptJZ3s95SUb9DnE/dC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnB3CMjJjvYxeR+J14QHqnkkvX2n8rAmOC3nJvRP2iw=;
 b=ED3EbyU4Gl69dC9D0sy0+j0e0HtYX35AbukaaZ1USdkxIDY5yfvaGOJCNvaXmOKd7DhnW6pS1K9CHMjryoF6u9HEySQVnGp8FhyMG6uyn6j45BOHBIBDUs/BheMZ4Pipqe+c+LU8Lj26wGP6Jg3JBPImlvZmsRPOOe+WqD8ME5FEd+QW0lRfyKSkWAakaL3s7Xu+9sRNeBk1z5tifNxC9abQJRZd7BIo25NEBuyq8NY2mUWejjcKvd+NVzH+GZfF7SL1Iagej5nwgvNBf9E313MzeGNE0HRfMfY9/fpkUoE49RICoe08hXqZBRM5qC0fCzbd1Fl5LFmidgwMpJDIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3872.namprd12.prod.outlook.com (10.255.237.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 16:10:27 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e%7]) with mapi id 15.20.2516.003; Thu, 5 Dec 2019
 16:10:26 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Improve kfd_process lookup in kfd_ioctl
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191205041311.19270-1-Felix.Kuehling@amd.com>
From: Philip Yang <philip.yang@amd.com>
Message-ID: <e408e64c-3259-8219-1555-9d2f89f9a459@amd.com>
Date: Thu, 5 Dec 2019 11:10:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191205041311.19270-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dccd4072-8c8f-4e30-9afb-08d7799da397
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:|MN2PR12MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3872043B76ADB6B9571B2A05E65C0@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(478600001)(305945005)(6512007)(4326008)(14454004)(66556008)(25786009)(11346002)(66946007)(81166006)(76176011)(23676004)(81156014)(65956001)(36756003)(2616005)(14444005)(99286004)(229853002)(44832011)(316002)(26005)(58126008)(31686004)(6506007)(50466002)(230700001)(5660300002)(8936002)(6486002)(31696002)(52116002)(53546011)(186003)(86362001)(2906002)(8676002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3872;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpSddxafx6WzHtpaYR8gDxQeVcWB+BwatEDPC2rQyUk4YavYeQAKvLPnDlq9mRdLT7lTlUVq7/xkpGnE0csxlY7YO6U3k092c07WlzB7XCRN4+nKe5A96DJ2MRTSJcBNErl+fhj7VawwKMCAZtRko1+D2DnKa1jEPicUnRTE8TqLRUN7Yd1eQLq5tDBk4rlNVPl0TesIqv+zb4cwibu+jDj7OMRPCgGga6mok5EfLS7bB9DVFMz+ME2gU6aPh7IpZaBnnyYbaWccnT5Xt94XdomyFIJwL+4NzROZSSyYgYn60fWZ7WIRuaPfzdFQwhjgSKpdhivq/4Lh3e6Oi5pzmUMsenbwGfv5XvUDuDZoC4+rXs2SpIPcDkcqcpTxdT1lUF3og1ErMSSQh31P5mw5tmxMocnOEzdUrtWe1JDDLi5no5K6C94EcNbAWOVyaPXj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccd4072-8c8f-4e30-9afb-08d7799da397
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 16:10:25.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FfXDDTY/rZPMhk1wMG0F2CFvK5A5HCRTqixr0HPmTs9xSZEQAkVe0pH9UU0j9ws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnB3CMjJjvYxeR+J14QHqnkkvX2n8rAmOC3nJvRP2iw=;
 b=J7eV58S5dIhYhZm5+6HA/nfIDzjFB+u7v7XwAieDeGgslETqFko5jg7GOk8xserJ6ttqVi38CTDDgTiHxE/WsaExlHg95yBZWKqFEyz3iOgNvXwy87YlGSfVZ1sBU/nm8MCetsSkSBvFHyJcAD8T2GBeZKZ/XsZAK5uyiYc++9Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: sean.keely@amd.com, jonathan.kim@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T25lIGNvbW1lbnQgaW4gbGluZS4KCldpdGggaXQgaXMgZml4ZWQsIHRoaXMgaXMgcmV2aWV3ZWQg
YnkgUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+CgpQaGlsaXAKCk9uIDIwMTktMTIt
MDQgMTE6MTMgcC5tLiwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gVXNlIGZpbGVwLT5wcml2YXRl
X2RhdGEgdG8gc3RvcmUgYSBwb2ludGVyIHRvIHRoZSBrZmRfcHJvY2VzcyBkYXRhCj4gc3RydWN0
dXJlLiBUYWtlIGFuIGV4dHJhIHJlZmVyZW5jZSBmb3IgdGhhdCwgd2hpY2ggZ2V0cyByZWxlYXNl
ZCBpbgo+IHRoZSBrZmRfcmVsZWFzZSBjYWxsYmFjay4gQ2hlY2sgdGhhdCB0aGUgcHJvY2VzcyBj
YWxsaW5nIGtmZF9pb2N0bAo+IGlzIHRoZSBzYW1lIHRoYXQgb3BlbmVkIHRoZSBmaWxlIGRlc2Ny
aXB0b3IuIFJldHVybiAtRUJBREYgaWYgaXQncwo+IG5vdCwgc28gdGhhdCB0aGlzIGVycm9yIGNh
biBiZSBkaXN0aW5ndWlzaGVkIGluIHVzZXIgbW9kZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBGZWxp
eCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCAzMCArKysrKysrKysrKysrKysrKysrKy0t
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgfCAgMiArKwo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+IGluZGV4IDJjYjUxZDFl
ODU3Yy4uMWFlYmRhNGJiYmU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9jaGFyZGV2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
Y2hhcmRldi5jCj4gQEAgLTQyLDYgKzQyLDcgQEAKPiAgIAo+ICAgc3RhdGljIGxvbmcga2ZkX2lv
Y3RsKHN0cnVjdCBmaWxlICosIHVuc2lnbmVkIGludCwgdW5zaWduZWQgbG9uZyk7Cj4gICBzdGF0
aWMgaW50IGtmZF9vcGVuKHN0cnVjdCBpbm9kZSAqLCBzdHJ1Y3QgZmlsZSAqKTsKPiArc3RhdGlj
IGludCBrZmRfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKiwgc3RydWN0IGZpbGUgKik7Cj4gICBzdGF0
aWMgaW50IGtmZF9tbWFwKHN0cnVjdCBmaWxlICosIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqKTsK
PiAgIAo+ICAgc3RhdGljIGNvbnN0IGNoYXIga2ZkX2Rldl9uYW1lW10gPSAia2ZkIjsKPiBAQCAt
NTEsNiArNTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBrZmRfZm9w
cyA9IHsKPiAgIAkudW5sb2NrZWRfaW9jdGwgPSBrZmRfaW9jdGwsCj4gICAJLmNvbXBhdF9pb2N0
bCA9IGtmZF9pb2N0bCwKPiAgIAkub3BlbiA9IGtmZF9vcGVuLAo+ICsJLnJlbGVhc2UgPSBrZmRf
cmVsZWFzZSwKPiAgIAkubW1hcCA9IGtmZF9tbWFwLAo+ICAgfTsKPiAgIAo+IEBAIC0xMjQsOCAr
MTI2LDEzIEBAIHN0YXRpYyBpbnQga2ZkX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IGZpbGUgKmZpbGVwKQo+ICAgCWlmIChJU19FUlIocHJvY2VzcykpCj4gICAJCXJldHVybiBQVFJf
RVJSKHByb2Nlc3MpOwo+ICAgCj4gLQlpZiAoa2ZkX2lzX2xvY2tlZCgpKQo+ICsJaWYgKGtmZF9p
c19sb2NrZWQoKSkgewo+ICsJCWtmZF91bnJlZl9wcm9jZXNzKHByb2Nlc3MpOwo+ICAgCQlyZXR1
cm4gLUVBR0FJTjsKPiArCX0KPiArCj4gKwkvKiBmaWxlcCBub3cgb3ducyB0aGUgcmVmZXJlbmNl
IHJldHVybmVkIGJ5IGtmZF9jcmVhdGVfcHJvY2VzcyAqLwo+ICsJZmlsZXAtPnByaXZhdGVfZGF0
YSA9IHByb2Nlc3M7Cj4gICAKPiAgIAlkZXZfZGJnKGtmZF9kZXZpY2UsICJwcm9jZXNzICVkIG9w
ZW5lZCwgY29tcGF0IG1vZGUgKDMyIGJpdCkgLSAlZFxuIiwKPiAgIAkJcHJvY2Vzcy0+cGFzaWQs
IHByb2Nlc3MtPmlzXzMyYml0X3VzZXJfbW9kZSk7Cj4gQEAgLTEzMyw2ICsxNDAsMTYgQEAgc3Rh
dGljIGludCBrZmRfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZXAp
Cj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCBrZmRfcmVsZWFzZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZXApCj4gK3sKPiArCXN0cnVjdCBrZmRf
cHJvY2VzcyAqcHJvY2VzcyA9IGZpbGVwLT5wcml2YXRlX2RhdGE7Cj4gKwo+ICsJaWYgKHByb2Nl
c3MpCj4gKwkJa2ZkX3VucmVmX3Byb2Nlc3MocHJvY2Vzcyk7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4g
K30KPiArCj4gICBzdGF0aWMgaW50IGtmZF9pb2N0bF9nZXRfdmVyc2lvbihzdHJ1Y3QgZmlsZSAq
ZmlsZXAsIHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwKPiAgIAkJCQkJdm9pZCAqZGF0YSkKPiAgIHsK
PiBAQCAtMTg0MCw5ICsxODU3LDE0IEBAIHN0YXRpYyBsb25nIGtmZF9pb2N0bChzdHJ1Y3QgZmls
ZSAqZmlsZXAsIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKQo+ICAgCj4gICAJ
ZGV2X2RiZyhrZmRfZGV2aWNlLCAiaW9jdGwgY21kIDB4JXggKCMweCV4KSwgYXJnIDB4JWx4XG4i
LCBjbWQsIG5yLCBhcmcpOwo+ICAgCj4gLQlwcm9jZXNzID0ga2ZkX2dldF9wcm9jZXNzKGN1cnJl
bnQpOwo+IC0JaWYgKElTX0VSUihwcm9jZXNzKSkgewo+IC0JCWRldl9kYmcoa2ZkX2RldmljZSwg
Im5vIHByb2Nlc3NcbiIpOwo+ICsJLyogR2V0IHRoZSBwcm9jZXNzIHN0cnVjdCBmcm9tIHRoZSBm
aWxlcC4gT25seSB0aGUgcHJvY2Vzcwo+ICsJICogdGhhdCBvcGVuZWQgL2Rldi9rZmQgY2FuIHVz
ZSB0aGUgZmlsZSBkZXNjcmlwdG9yLiBDaGlsZAo+ICsJICogcHJvY2Vzc2VzIG5lZWQgdG8gY3Jl
YXRlIHRoZWlyIG93biBLRkQgZGV2aWNlIGNvbnRleHQuCj4gKwkgKi8KPiArCXByb2Nlc3MgPSBm
aWxlcC0+cHJpdmF0ZV9kYXRhOwo+ICsJaWYgKHByb2Nlc3MtPmxlYWRfdGhyZWFkICE9IGN1cnJl
bnQtPmdyb3VwX2xlYWRlcikgewo+ICsJCWRldl9kYmcoa2ZkX2RldmljZSwgIlVzaW5nIEtGRCBG
RCBpbiB3cm9uZyBwcm9jZXNzXG4iKTsKPiArCQlyZXRjb2RlID0gLUVCQURGOwo+ICAgCQlnb3Rv
IGVycl9pMTsKPiAgIAl9Cj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9j
ZXNzLmMKPiBpbmRleCA4Mjc2NjAxYTEyMmYuLmJiMmYyNjUzMmZlYiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+IEBAIC0zMjQsNiArMzI0LDggQEAgc3Ry
dWN0IGtmZF9wcm9jZXNzICprZmRfY3JlYXRlX3Byb2Nlc3Moc3RydWN0IGZpbGUgKmZpbGVwKQo+
ICAgCQkJCQkoaW50KXByb2Nlc3MtPmxlYWRfdGhyZWFkLT5waWQpOwo+ICAgCX0KPiAgIG91dDoK
PiArCWlmIChwcm9jZXNzKQppZiAoIUlTX0VSUl9PUl9OVUxMKHByb2Nlc3MpKQoKPiArCQlrcmVm
X2dldCgmcHJvY2Vzcy0+cmVmKTsKPiAgIAltdXRleF91bmxvY2soJmtmZF9wcm9jZXNzZXNfbXV0
ZXgpOwo+ICAgCj4gICAJcmV0dXJuIHByb2Nlc3M7Cj4gCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
