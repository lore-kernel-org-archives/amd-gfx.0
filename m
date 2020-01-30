Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F133C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1005020CC7
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4jSH0iXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1005020CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A222A6FA37;
	Thu, 30 Jan 2020 22:17:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D912E6FA37
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 22:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4KyZ1NdBrwdMRpszUldbfQA6tF3i4Q227GzBDyROV5zaQbMisaP39PKgBklhegYuWjYQfYudTwfCKgaDWfkj8t9pklgcJKfHTGZLd+j04htZRRNnTYBLtI00f2L2nLncsszl4+WcVixkwabVdqACv0pBwHkaTzIKmmJlI5pJrGUvIU9OWdrTMzqAdsYl6UQm286ckdcCPeoTWWEWNlElv6Tb/AGYb43b1fMp4WmpP8xlN5TMxk3mlDnWXSHBMHL0DV+oz1/uWPfvd6+Ukg1J1PPGI+7S+sghy3tCafyK8tVMwQVlSMru73cDEof4qu6X0AZk0GOs5rmScp4rKIjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owxQXI3H1Y7H71PuxcaND7JYneKzj5ylCBAdIp6a0E8=;
 b=D6xypTKnZnhlUehSpVW5v3LjNtPV888GEgrcUOm3Uqb4ORgiShfTjvqsXZsS/y2053TXax9V04IxIW8i5/va1vQFJDzQilQpOOEDSPKCBeiRtx0Nu3s77GwhsHux6idjFrpxVTs79vJLlcF15R/i/xg7teottsVJvLuyaPXX/6VTPgWkDc9FijIzWa1phoQ5QVLW8f7VGJ7LqzuWlGOtUoOJ6JHZlCoIHhCqKkndTL/zD1JyZ4tXA0yLuXyXy+8SFTUfk0EZslLX3K9eINxQaGblunV2cKh2ePuBYA5aMGGgtMN7Xxc0CyXp8ovSaO6rBbYkvK6uJfbXCyG/VxuzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owxQXI3H1Y7H71PuxcaND7JYneKzj5ylCBAdIp6a0E8=;
 b=4jSH0iXHKgAi6nxcD6MqGQG2MiqKrbgfX2xstrvZjCnnr9Kh117I5NpVsr9XJHCntA9u3ynTKChoHKLLinNsKLAZMy254sB98+J+PbO1zDVwE6y4/QUz/x7dGUgXiir2pfvqFW44v68WTgAxeH6Onj/FHINyfhwQqKqXJOcIhok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MWHPR1201MB0095.namprd12.prod.outlook.com (10.174.255.8) by
 MWHPR1201MB0127.namprd12.prod.outlook.com (10.174.100.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Thu, 30 Jan 2020 22:17:18 +0000
Received: from MWHPR1201MB0095.namprd12.prod.outlook.com
 ([fe80::ade9:4cf3:87ad:707]) by MWHPR1201MB0095.namprd12.prod.outlook.com
 ([fe80::ade9:4cf3:87ad:707%11]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 22:17:18 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: allow higher level PD invalidations
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200130124940.30380-1-christian.koenig@amd.com>
 <20200130124940.30380-3-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cee092c7-b36e-3992-0cbc-51d55477bf21@amd.com>
Date: Thu, 30 Jan 2020 17:17:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200130124940.30380-3-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To MWHPR1201MB0095.namprd12.prod.outlook.com
 (2603:10b6:301:4e::8)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Thu, 30 Jan 2020 22:17:17 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc2288f7-a661-4ccb-d82b-08d7a5d22adf
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0127:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0127620DAB68BBBBE1AA9A2C92040@MWHPR1201MB0127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(5660300002)(66476007)(66556008)(66946007)(8676002)(26005)(53546011)(6486002)(36756003)(31686004)(478600001)(81156014)(2906002)(186003)(16526019)(8936002)(86362001)(316002)(81166006)(44832011)(52116002)(31696002)(956004)(2616005)(66574012)(16576012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0127;
 H:MWHPR1201MB0095.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5a81VPA/c1Br5pFn7t0xdm1WueXAQ304sO1wDXRHiDi4r/4fA3ly6aroAD5S+ckqDCqGjQl5cWP+oNQjs/HIt1QwU19/9s/lZoMR3O6CuAmDmsApmHdly3VmF3KjB8TP4WpVjEn5SsCZpTNad5djrafgalHpZPUY1KROs5Lksb4t2I8AJYtVL3TsT85zRkF1LfhjDvs4w2++WlJdjGM9RqH2rKy6wCpmWGB4Dl2qNK+QTOjqNCypNW8mEg+N6hdquZCqHnkvr5BNRFeFBEIW27v+sczo+c+6Pe8zbyb2rV+wBnIBfp6EBhOL8D4/hxyt/eLyzisBBJdWEwqyQFXMLRlwP3Mg1yZI/U311VfanqJoC8czS8BC2p9rhl9dDkCaG9/n69Q+tPNpJzDmP2mOOozVSvs6ZMoA2MvwixSIrRxKLDOOMH9okk6c76v1R15p
X-MS-Exchange-AntiSpam-MessageData: U9UOyjyFqawfRwpZsPaXhL+LHwFGDZ7cfTfkhlNlKcvSRriN35S5EyVrr3irijC4isXVmCekVRAi91V6EBckmkLYfvUWsCWX7lmthjSOmWIK+U7AW8QoOXRHbPgLtnPZMpbyZ8FIgUp3ASs8u7yuwg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2288f7-a661-4ccb-d82b-08d7a5d22adf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 22:17:18.0341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOG9AYpEik30+nY+YrYmcKhoKTjWSNenJ8CY91zxc74b4yjmnuv43XfROSzjRO5qN8LVll+oLlesVQb2P5/yhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0127
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

T24gMjAyMC0wMS0zMCA3OjQ5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFsbG93IHBhcnRp
YWwgaW52YWxpZGF0aW9uIG9uIHVuYWxsb2NhdGVkIFBEcy4gVGhpcyBpcyB1c2VmdWwgd2hlbiB3
ZQo+IG5lZWQgdG8gc2lsZW5jZSBmYXVsdHMgdG8gc3RvcCBpbnRlcnJ1cHQgZmxvb2RzIG9uIFZl
Z2EuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4gVGVzdGVkLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+
CgpJIGFscmVhZHkgcmV2aWV3ZWQgdGhpcyBhIHdlZWsgYWdvLiBXaXRoIHR3byBzdHlsZSBuaXQt
cGlja3MgZml4ZWQsIHRoaXMgCnBhdGNoIGlzCgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIHwgMjMgKysrKysrKysrKysrKysrKysrLS0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA5NzA1Yzk2MTQwNWIuLjYwMzhiM2M4
OTYzMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTE0
NjcsOSArMTQ2Nyw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBh
bWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+ICAgCQkJICogc21hbGxlciB0aGFuIHRo
ZSBhZGRyZXNzIHNoaWZ0LiBHbyB0byB0aGUgbmV4dAo+ICAgCQkJICogY2hpbGQgZW50cnkgYW5k
IHRyeSBhZ2Fpbi4KPiAgIAkJCSAqLwo+IC0JCQlpZiAoIWFtZGdwdV92bV9wdF9kZXNjZW5kYW50
KGFkZXYsICZjdXJzb3IpKQo+IC0JCQkJcmV0dXJuIC1FTk9FTlQ7Cj4gLQkJCWNvbnRpbnVlOwo+
ICsJCQlpZiAoYW1kZ3B1X3ZtX3B0X2Rlc2NlbmRhbnQoYWRldiwgJmN1cnNvcikpCj4gKwkJCQlj
b250aW51ZTsKPiAgIAkJfSBlbHNlIGlmIChmcmFnID49IHBhcmVudF9zaGlmdCkgewo+ICAgCQkJ
LyogSWYgdGhlIGZyYWdtZW50IHNpemUgaXMgZXZlbiBsYXJnZXIgdGhhbiB0aGUgcGFyZW50Cj4g
ICAJCQkgKiBzaGlmdCB3ZSBzaG91bGQgZ28gdXAgb25lIGxldmVsIGFuZCBjaGVjayBpdCBhZ2Fp
bi4KPiBAQCAtMTQ4MCw4ICsxNDc5LDE5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9w
dGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+ICAgCQl9Cj4gICAK
PiAgIAkJcHQgPSBjdXJzb3IuZW50cnktPmJhc2UuYm87Cj4gLQkJaWYgKCFwdCkKPiAtCQkJcmV0
dXJuIC1FTk9FTlQ7Cj4gKwkJaWYgKCFwdCkgewo+ICsJCQkvKiBXZSBuZWVkIGFsbCBQRHMgYW5k
IFBUcyBmb3IgbWFwcGluZyBzb21ldGhpbmcsICovCj4gKwkJCWlmIChmbGFncyAmIEFNREdQVV9Q
VEVfVkFMSUQpCj4gKwkJCQlyZXR1cm4gLUVOT0VOVDsKPiArCj4gKwkJCS8qIGJ1dCB1bm1hcHBp
bmcgc29tZXRoaW5nIGNhbiBoYXBwZW4gYXQgYSBoaWdoZXIKPiArCQkJICogbGV2ZWwuICovCgpj
aGVja3BhdGNoLnBsIGNvbXBsYWlucyBhYm91dCBtdWx0aS1saW5lIGNvbW1lbnRzIHdpdGggdGhl
ICovIG5vdCBvbiBpdHMgCm93biBsaW5lLgoKCj4gKwkJCWlmICghYW1kZ3B1X3ZtX3B0X2FuY2Vz
dG9yKCZjdXJzb3IpKQo+ICsJCQkJcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICsJCQlwdCA9IGN1cnNv
ci5lbnRyeS0+YmFzZS5ibzsKPiArCQkJc2hpZnQgPSBwYXJlbnRfc2hpZnQ7Cj4gKwkJfQo+ICAg
Cj4gICAJCS8qIExvb2tzIGdvb2Qgc28gZmFyLCBjYWxjdWxhdGUgcGFyYW1ldGVycyBmb3IgdGhl
IHVwZGF0ZSAqLwo+ICAgCQlpbmNyID0gKHVpbnQ2NF90KUFNREdQVV9HUFVfUEFHRV9TSVpFIDw8
IHNoaWZ0Owo+IEBAIC0xNDk1LDYgKzE1MDUsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRh
dGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPiAgIAkJCXVp
bnQ2NF90IHVwZF9lbmQgPSBtaW4oZW50cnlfZW5kLCBmcmFnX2VuZCk7Cj4gICAJCQl1bnNpZ25l
ZCBucHRlcyA9ICh1cGRfZW5kIC0gZnJhZ19zdGFydCkgPj4gc2hpZnQ7Cj4gICAKPiArCQkJLyog
VGhpcyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhpZ2hlciBsZXZlbCBQRHMgdG8KPiArCQkJICog
c2lsZW50IHRvIHN0b3AgZmF1bHQgZmxvb2RzLiAqLwoKU2FtZSBhcyBhYm92ZS4KCgo+ICsJCQlu
cHRlcyA9IG1heChucHRlcywgMXUpOwo+ICAgCQkJYW1kZ3B1X3ZtX3VwZGF0ZV9mbGFncyhwYXJh
bXMsIHB0LCBjdXJzb3IubGV2ZWwsCj4gICAJCQkJCSAgICAgICBwZV9zdGFydCwgZHN0LCBucHRl
cywgaW5jciwKPiAgIAkJCQkJICAgICAgIGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpKTsK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
