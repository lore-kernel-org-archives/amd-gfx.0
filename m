Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ECBC54FD4
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 07:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB3F20714
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 07:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QSEQgt3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB3F20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6C46E11C;
	Wed, 25 Mar 2020 07:48:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64576E11C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 07:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwjFRsdtIRausJN6YYSCGTkdNO5TBpQsnQ5JnssvC5bbOJUq9s5TbCgfLXbAyzRs3afFytJD1GlXhgdmdAly5v7YS46Fm1wABwhkuxOTuP1qqtWVaO5SLJ9RYWS2PxOm1Dh8DIEnSwhifTDBqdg3fnxTKEr++gnUTwY/KkkDNuiCAg4uZpNleHgb16ODFkoePHj/ceBZ4ctEcbcfQOzgRuCJBmg8NyFjI0WVr3bz8uis9BQ/Phl+fW0/jdzze8s2wQU0V1mQnQLeo6SRnjn4sG1nRUPFO5vL054YshpDdaHUqci+TVH/mXMg4fSRRYxYEpNyahrjnP5Z9cUThoJJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzDbdl7GWleflhskEKZ4nj9hlSBiN2GcfVzGaa6p2e4=;
 b=d+RXAMlqEMc8/sIQKPb4ZWLAneTn3KoDS9OaU6NuypiVCzBsLmEOv1Fv4Xhjc3Ft49C+Fx05gv3ZH4ZyPPFsjIBC2Hg2771k26ff3awTHI8dRLYDnfRY0EFkbof2HWwz0KhcuVnpScs121IxCJb0QR+QCkkOWgnM51VvoZsyujqVJGzSHvk1PuJty7c8fc41q1bC1KdyJSAZ+OGbh4Bt8u1VuQPfjaaJdPmoJs/aaKxuUG7Om4GuxET+xC4MEoFTaTNL/+pMNpDjpa5K639sBFYg3qN8U1qkhXVcnsMPXu56qrD9K88zL0kqL5IsLQ42EJ4sqo8kIVYaSuS3EpFmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzDbdl7GWleflhskEKZ4nj9hlSBiN2GcfVzGaa6p2e4=;
 b=QSEQgt3WVLNw+KVR0m7Rrhz3FWgXlN0lEOVcORILD7bhbRuG1rouklLcfyEcPO+J1ZRqGfGqvZZaIigz6LIZpQk3hYel7zSCSOrgb6f64l003obXT0YhvchV1rTqDGKWV5wQT8Fvw3iD0VfSsdf03VseJYct4e6/UA5GoxHOjtk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1467.namprd12.prod.outlook.com (2603:10b6:4:c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Wed, 25 Mar 2020 07:48:44 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f%11]) with mapi id 15.20.2835.023; Wed, 25 Mar
 2020 07:48:44 +0000
Subject: Re: [PATCH] drm/amdgpu: Check entity rq
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200325054723.4560-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <15d695c5-539b-2461-c265-d3590f1540e5@amd.com>
Date: Wed, 25 Mar 2020 08:48:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200325054723.4560-1-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Wed, 25 Mar 2020 07:48:42 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 176d961a-b96b-4b72-856d-08d7d090f121
X-MS-TrafficTypeDiagnostic: DM5PR12MB1467:|DM5PR12MB1467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB146749F237A94496F288794083CE0@DM5PR12MB1467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(66946007)(4326008)(2616005)(16526019)(81156014)(52116002)(186003)(81166006)(8936002)(54906003)(8676002)(316002)(31686004)(2906002)(6486002)(478600001)(66556008)(86362001)(31696002)(5660300002)(36756003)(66476007)(6666004)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1467;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VP4lsmW4NL8kiA9zlLln4PwMlVdoA0/mrc2UYidRNOFoC9HDs4nujqx0KgYCfjVMU+jfpA11HUhO39cjNhWzlYP5M2QeY23TNBLyo/vz/2QiRUSlJSAZla1hx2QsQg4gBHQ54b+ZqiKGQNPH96Kgu7pOzZIDckp0KHjRFV/Fw/9Ub34hdDENO9m9pQIYv/OFyGY95wy7cW6n4WtcH1UKZAjz0cJyol6XdFwXdCuF4Uo0S9XmySAHn3K5r4y8q0+Vq5isNHGrmNZauRGVpybpKue62drq5fxwDPXjpHMFFYWfRtzeURDAyTFO5nRMdwdZRS7u4e2se6YgOk4HqlaRa6Lb+ktnBPXIPSGoMBYYoTUHuLs5btJk09bDirSD/ZviCMyRkB0Xdlf8AR3AC81wn40dVsrG0Szm7cvCIVI3PSX+L0ZUIQmSvQx1qIU9ISc
X-MS-Exchange-AntiSpam-MessageData: 8jP9NC3TTLDMj1EIyNGeb8qjdRiYx0O5BT/pfrCTk8LDUl7bDPuwPHMA6NDwI+JpHHPGqu404wFiDblIK7s2o0OSf1/5gCOWnpQy2F6ItF3stJl3qRBY3qw5HhPUa0nKkvyCQzrhvGTzOJb7vQZAmPwjKUl/9lPdU+gMVhS4FLPBHtL4pLinMZJz5le+5GfbayiYmppLv5EeY3Wr9UGLhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176d961a-b96b-4b72-856d-08d7d090f121
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 07:48:44.0986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZaWVghuqmNUVYSvSUC8v5nKyrJmmmZDl4Y5tOMJ4pokYn4r+EtC/v0jXkn7QAg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1467
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDMuMjAgdW0gMDY6NDcgc2NocmllYiB4aW5odWkgcGFuOgo+IEhpdCBwYW5pYyBkdXJp
bmcgR1BVIHJlY292ZXJ5IHRlc3QuIGRybV9zY2hlZF9lbnRpdHlfc2VsZWN0X3JxIG1pZ2h0Cj4g
c2V0IE5VTEwgdG8gcnEuIFNvIGFkZCBhIGNoZWNrIGxpa2UgZHJtX3NjaGVkX2pvYl9pbml0IGRv
ZXMuCgpOQUssIHRoZSBycSBzaG91bGQgbmV2ZXIgYmUgc2V0IHRvIE5VTEwgaW4gdGhlIGZpcnN0
IHBsYWNlLgoKSG93IGRpZCB0aGF0IGhhcHBlbmVkPwoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+
IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8
eGluaHVpLnBhbkBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtX3NkbWEuYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1f
c2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+IGlu
ZGV4IGNmOTZjMzM1YjI1OC4uZDMwZDEwM2U0OGEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCj4gQEAgLTk1LDYgKzk1LDggQEAgc3RhdGljIGlu
dCBhbWRncHVfdm1fc2RtYV9jb21taXQoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpw
LAo+ICAgCWludCByOwo+ICAgCj4gICAJZW50aXR5ID0gcC0+ZGlyZWN0ID8gJnAtPnZtLT5kaXJl
Y3QgOiAmcC0+dm0tPmRlbGF5ZWQ7Cj4gKwlpZiAoIWVudGl0eS0+cnEpCj4gKwkJcmV0dXJuIC1F
Tk9FTlQ7Cj4gICAJcmluZyA9IGNvbnRhaW5lcl9vZihlbnRpdHktPnJxLT5zY2hlZCwgc3RydWN0
IGFtZGdwdV9yaW5nLCBzY2hlZCk7Cj4gICAKPiAgIAlXQVJOX09OKGliLT5sZW5ndGhfZHcgPT0g
MCk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
