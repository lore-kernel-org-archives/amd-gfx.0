Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ED1C35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60E02064A
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="snGyIvBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60E02064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 864BF6EAB9;
	Tue, 25 Feb 2020 13:43:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC956EAB9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 13:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoU7kKBQ+EJOSznZ+OHJvkuxPnvCbM7lc1H2C9W+xq9EasLP554Sr9NF5j0BK+NuVTbN8HsoRMGiXv1EThxop6xwvjcH/2iwbyxaUYZa+OF2xcY4mj9Ul4DL3FOnbKDylh0sgQpMOjcWkI/xzqX/AL0VBl45rvKh8Ex9lempX6drpyFgZOXf5nYfkvCXY8E1/AKPHaYFnxDe/kmjXwYiR2c8Fb8TQysT6tFdBCcsB11/ewKgHBGxh7+7gzxG/4sdwDsR8LUqtzbKlptV4maRJWZQN/78X3cS8iDRjMjvuu6Hu+lJ8uD5adLSE9yjIs8+KVQFbMSCkv/QBRhYyp/pkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbFTkp8azSmjH17HxpUpqrMauQ2QzJgKQxT8j1wR5/c=;
 b=mZYgaNVsz1PAo6FJSBFhiPpah5rb2HmPzTg/BJCiuwYheWfKDuu1bt5sANxS1YRFO+9BVGrxlmF6Ye04ZFrxfPrHlzAjSUn69lKhY3U1x+/gRCzeli15M25Ve3szayADQC/7EUJF2E9uigiB42H4X59SOJ+Rvw0H2+CBtyZCnMWY4CBNaf8f06IjzNX78TfZUg8qKQ96nM4h+fpXo51d7bhxPTGlKGEhc79AugegdN2Y61G8c6bo92cYjr6Yxz/9QsyeIO/PZLM+LF4M+7665OVTRCLL2MauiY4RJiV3/RSvkJuL1gy6gpY4gZk0cse1RmLcB1dDykCkLTGz6RM+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbFTkp8azSmjH17HxpUpqrMauQ2QzJgKQxT8j1wR5/c=;
 b=snGyIvBZVoSeQ/YpdCaNMPxEEExIpoKd1AvDEAAlEXx/NLnRvob4WzIXO8vErjU1pINXDZef2xhsoJ8o0gfjt/DXQu3xw07RoGYmqR5XmmRjn5tn2D4l3z+tWz18ttSR8aaWJ19zaGdAXnbs63OlP5w16nGERG7lVpvPty2FDRk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2342.namprd12.prod.outlook.com (52.132.208.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 13:43:16 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Tue, 25 Feb
 2020 13:43:16 +0000
Subject: Re: [PATCH] drm/amdgpu: use amdgpu_ring_test_helper when possible
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200225134247.16162-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2edb87ca-b603-e3c8-eb82-055d77a1eb27@amd.com>
Date: Tue, 25 Feb 2020 14:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200225134247.16162-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 13:43:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e035ce26-5ba4-47cb-bf47-08d7b9f8aabb
X-MS-TrafficTypeDiagnostic: DM5PR12MB2342:|DM5PR12MB2342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23427DD9D5589AAF17CB893783ED0@DM5PR12MB2342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(86362001)(52116002)(478600001)(8936002)(4326008)(5660300002)(36756003)(31696002)(316002)(2906002)(31686004)(6486002)(8676002)(81166006)(2616005)(66556008)(66946007)(16526019)(6666004)(66476007)(81156014)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2342;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Joj+L6wE8TTZmSwwNYDKtErMyCU80PtPbE5tyiKgIADgSUPqwLrmB5UGCUVnhlmnzvNA0FJGweGsQprKCDtSL1pr5lzgFU8woBIx9+v7byiafoz75Aepd+k0TApa/WXBUnzJlo3I3hQp3w3wCBTE6RwWXxUfzuZUkRV37JNsFo0fBsicqIjKkVE5Lp583rdDwoW5U7zNnFOemprN2nrunCe6h6jVaA4SjHcK5RYrjUjSV+Eg+UEsx/gxPY8Bvi3ek4v9neszv/uh6qG2+11GZaweBR70zyUokkmFhbAWCodczYMuKYzbvSZ4y8TZrTeaMuxezv8Oz1X8bE81H3aeFK8paruZdJHq2G22rSBAnu1fMqODePMTUOlwQYjw6Ziz8bgcIze3lqPuPHhZbRBTt+e4a1ce/V6UqqKZ+ZldZC8dI3FzKv7p8sqV0VSydtPu
X-MS-Exchange-AntiSpam-MessageData: hZ/CxTYuP0o+T7VvOoIL3EFq7aIo1/bVs0KsBbc8xRUt51kXikTrzWsNMZeeCook7RfyXtqZY8RFPD9YZKKlx6AR78i+cnBb+GCCefyl+kqoeZiW9ck7hADnD3LUyutZpBhTCNQl+bI9aewHPl02H3Zwofpr5NZUvRmfHnWtWyUOZnfpqCpftIFl/1kpgNfdr9kYG6ndKj1TV2VCnECL9w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e035ce26-5ba4-47cb-bf47-08d7b9f8aabb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 13:43:16.6012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFL29AxIKDZ30IRPFAM7HGtL2BlhSbtM9a8vV0j50TzutaPu0n1vFixSwzzrfVlK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2342
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDIuMjAgdW0gMTQ6NDIgc2NocmllYiBOaXJtb3kgRGFzOgo+IGFtZGdwdV9yaW5nX3Rl
c3RfaGVscGVyIGFscmVhZHkgaGFuZGxlcyByaW5nLT5zY2hlZC5yZWFkeSBjb3JyZWN0bHkKPgo+
IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgMiArLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgIHwgOSArKy0tLS0tLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jICB8IDYgKystLS0tCj4gICAzIGZp
bGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jCj4gaW5kZXggMGY5NjBiNDk4NzkyLi43NDAz
NTg4Njg0YjMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dmeC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jCj4g
QEAgLTQ3Nyw3ICs0NzcsNyBAQCBpbnQgYW1kZ3B1X2dmeF9kaXNhYmxlX2tjcShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKPiAgIAkJa2lxLT5wbWYtPmtpcV91bm1hcF9xdWV1ZXMoa2lxX3Jp
bmcsICZhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldLAo+ICAgCQkJCQkgICBSRVNFVF9RVUVVRVMs
IDAsIDApOwo+ICAgCj4gLQlyZXR1cm4gYW1kZ3B1X3JpbmdfdGVzdF9yaW5nKGtpcV9yaW5nKTsK
PiArCXJldHVybiBhbWRncHVfcmluZ190ZXN0X2hlbHBlcihraXFfcmluZyk7Cj4gICB9Cj4gICAK
PiAgIGludCBhbWRncHVfZ2Z4X2VuYWJsZV9rY3Eoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBpbmRleCAzNmNlNjdjZTQ4
MDAuLjc3MDNiZTE0MzkwZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jCj4gQEAgLTMxNTYsMTIgKzMxNTYsNyBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9raXFfZW5h
YmxlX2tncShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlmb3IgKGkgPSAwOyBpIDwg
YWRldi0+Z2Z4Lm51bV9nZnhfcmluZ3M7IGkrKykKPiAgIAkJa2lxLT5wbWYtPmtpcV9tYXBfcXVl
dWVzKGtpcV9yaW5nLCAmYWRldi0+Z2Z4LmdmeF9yaW5nW2ldKTsKPiAgIAo+IC0JciA9IGFtZGdw
dV9yaW5nX3Rlc3RfcmluZyhraXFfcmluZyk7Cj4gLQlpZiAocikgewo+IC0JCURSTV9FUlJPUigi
a2ZxIGVuYWJsZSBmYWlsZWRcbiIpOwo+IC0JCWtpcV9yaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNl
Owo+IC0JfQo+IC0JcmV0dXJuIHI7Cj4gKwlyZXR1cm4gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIo
a2lxX3JpbmcpOwo+ICAgfQo+ICAgI2VuZGlmCj4gICAKPiBAQCAtMzc3Nyw3ICszNzcyLDcgQEAg
c3RhdGljIGludCBnZnhfdjEwXzBfa2lxX2Rpc2FibGVfa2dxKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQo+ICAgCQlraXEtPnBtZi0+a2lxX3VubWFwX3F1ZXVlcyhraXFfcmluZywgJmFkZXYt
PmdmeC5nZnhfcmluZ1tpXSwKPiAgIAkJCQkJICAgUFJFRU1QVF9RVUVVRVMsIDAsIDApOwo+ICAg
Cj4gLQlyZXR1cm4gYW1kZ3B1X3JpbmdfdGVzdF9yaW5nKGtpcV9yaW5nKTsKPiArCXJldHVybiBh
bWRncHVfcmluZ190ZXN0X2hlbHBlcihraXFfcmluZyk7Cj4gICB9Cj4gICAjZW5kaWYKPiAgIAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCj4gaW5kZXggNWFmNjZhMjRiMGEy
Li44ZWQ5ZDQyNzgzZTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2RtYV92NV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAu
Ywo+IEBAIC03NDMsMTEgKzc0Myw5IEBAIHN0YXRpYyBpbnQgc2RtYV92NV8wX2dmeF9yZXN1bWUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCQlzZG1hX3Y1XzBfZW5hYmxlKGFkZXYs
IHRydWUpOwo+ICAgCQl9Cj4gICAKPiAtCQlyID0gYW1kZ3B1X3JpbmdfdGVzdF9yaW5nKHJpbmcp
Owo+IC0JCWlmIChyKSB7Cj4gLQkJCXJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4gKwkJciA9
IGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyKHJpbmcpOwo+ICsJCWlmIChyKQo+ICAgCQkJcmV0dXJu
IHI7Cj4gLQkJfQo+ICAgCj4gICAJCWlmIChhZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jc19yaW5nID09
IHJpbmcpCj4gICAJCQlhbWRncHVfdHRtX3NldF9idWZmZXJfZnVuY3Nfc3RhdHVzKGFkZXYsIHRy
dWUpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
