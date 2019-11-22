Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01612C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 23:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23BE20704
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 23:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23BE20704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861616F547;
	Fri, 22 Nov 2019 23:21:23 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820047.outbound.protection.outlook.com [40.107.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF226F547
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 23:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNjhTrqb0i/Qk3zU23ylljbvaPS9GFyHhmSu3heY84/Yjn3/upHSKs7vdaQptDfQm781/nLUXIPT6nZCJuPivmqziJ0WtjujmEBqcwo2eKtUaxOxBx7Yr1wE3Z8gE3/vFLQNeE8t4hMXqc50Bq9ELw6JFheFEH7JYamQj+C8tWN5cI7IpzdRaAZUSvfucBkRcK3LZBVO9mO92qKBXTb20G5y+abP9+OgNictS7vWPRNi47yHCxptIQFt5h9WINUUiBgF+lXsUo5rosKfJbQ7EOOUo6L+CZc9G7pDU6XU46abzadElgDnPduNN/5f19+yY+dg5oYGgShdipP3z6YF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIcR2nNtoiXhL6ksqpvqPKS49DUMT6kh8XOFLASe3RU=;
 b=iFRL7SvASH/oKgMB7M7LqUqjoIhTlnYHuHkT00mXppsgJ+eHLXQW6fiGJVB2dIn4AaMrEcdDkTHa+e7npP1wJ+f1Ic0oylOWriJEXLC9aV4lXiOT6hYQYAqjBvp/YwNHsoZgMoq8DCc87k3u/i1ei/ZxDhy+/ol24/4LkePn8Ch23GjToKicaBQHMc6camyb5uByZLeapem5RnZWh674in0Q7P567J/KWBrbc/ho5b+h+zN7dbAO/FhEKLJjU7L9CeTSOCHHvIQ8VKRYLNcDX5I43qhQaPrvSn9we7Tg/lZxOnmokDfIii8swklikuMpRxkXOxFoVZvfLKF/UFQt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3115.namprd12.prod.outlook.com (20.178.31.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 23:21:19 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 23:21:19 +0000
Subject: Re: [PATCH] drm/amdgpu: Apply noretry setting for mmhub9.4
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1574463347-27961-1-git-send-email-Oak.Zeng@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <68bce28c-6b9d-8626-b2e0-09d6f4b3bb05@amd.com>
Date: Fri, 22 Nov 2019 18:21:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1574463347-27961-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::28) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67086d86-1573-44c9-8a48-08d76fa2adf6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:|DM6PR12MB3115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31152E4573F6DE97A414CC5E92490@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 02296943FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(8676002)(4001150100001)(25786009)(44832011)(316002)(6116002)(6512007)(2616005)(99286004)(11346002)(6486002)(14454004)(446003)(36756003)(229853002)(3846002)(230700001)(5660300002)(6436002)(478600001)(81156014)(86362001)(23676004)(2486003)(81166006)(26005)(65806001)(66066001)(65956001)(36916002)(6246003)(8936002)(2906002)(31686004)(31696002)(50466002)(53546011)(52116002)(76176011)(66556008)(66476007)(66946007)(186003)(6506007)(386003)(4326008)(47776003)(58126008)(7736002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3115;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEwK11ZlwOnxFKRfzQ0jwf8hr/C/oLk2+pRpaNyCHD8seK8SbJora2Gwtn6Qhwwf+8TIxAdRYao12y6JvZ69RELomPSjclocX79o91yKGlq6/vcSz5el3lOj35RYvfOXN2A9D3scXD7IKqRRWwXuiVqh54me3xzpjpxQGpY10/Jn2H+guuAwkhf1oDby9+nspEZy0tThsssY+y+VkK/BbK9jhFYGnL/bdU98LSMR7pzyDJkm5oJtu4l65C6UHWTvENe70CtTDtx+gBopWXI8sLoUnzOPl3+gh3aYscUor3246qaRlOiJDI3D3UeHpaswG+8XjROHmewwiXohP3FoLot4vjEi9z0Tcn1lishBo8Cxnuz2a6tqzKg000TOGp/fnw2uuzDJ5FZLG3ao8eD81L2Gr7K462uZwZDme74hFgaTrT41qZA/VdJeoyPQ+1BI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67086d86-1573-44c9-8a48-08d76fa2adf6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 23:21:19.2044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfhXrGFTKM5TGUtSOCiq7rGxWmgEGDg3Bf2gGSaDrDhvD8xYzAGxm/fBMi0ZBcH/tfhMDyKxQGLkHl3fCFA1kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIcR2nNtoiXhL6ksqpvqPKS49DUMT6kh8XOFLASe3RU=;
 b=XKgAu4gmC0xbj8Hphu66M4DYZkTjLhtr3pknMM7pigbVDy79qb7CGReWVhtiAFm+SOk+2o/PE/GYK8vlp3xi/TyeRIt6UjyYgEyRgj/5B8J93mnEkXxLSpyg5nVZC5FSMW0oIBJlGxu79O73jBMF3a8gW/IhXxOqy4nmiSKeEeo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Cc: Jay.Cornwall@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122232117.c3o5spnS2SwN_IQKfUvRHYYWHOvZWBM3WyrBQ2SUSUc@z>

T24gMjAxOS0xMS0yMiA1OjU1IHAubS4sIE9hayBaZW5nIHdyb3RlOgo+IENvbmZpZyB0aGUgdHJh
bnNsYXRpb24gcmV0cnkgYmVoYXZpb3IgYWNjb3JkaW5nIHRvIG5vcmV0cnkKPiBrZXJuZWwgcGFy
YW1ldGVyCj4KPiBDaGFuZ2UtSWQ6IEk1YjkxZWE3NzcxNTEzN2NmOGNiODRlMjU4Y2NkZmJiMTlj
N2E0ZWQxCj4gU2lnbmVkLW9mZi1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+Cj4gU3Vn
Z2VzdGVkLWJ5OiBKYXkgQ29ybndhbGwgPEpheS5Db3Jud2FsbEBhbWQuY29tPgoKUmV2aWV3ZWQt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKCj4gLS0tCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgfCA1ICsrKy0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYwo+IGluZGV4IDc1M2VlYTIuLjg1OTliZmQgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4gQEAgLTMxNCw3ICsz
MTQsOCBAQCBzdGF0aWMgdm9pZCBtbWh1Yl92OV80X3NldHVwX3ZtaWRfY29uZmlnKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBpbnQgaHViaWQpCj4gICAJCQkJICAgIGFkZXYtPnZtX21hbmFn
ZXIuYmxvY2tfc2l6ZSAtIDkpOwo+ICAgCQkvKiBTZW5kIG5vLXJldHJ5IFhOQUNLIG9uIGZhdWx0
IHRvIHN1cHByZXNzIFZNIGZhdWx0IHN0b3JtLiAqLwo+ICAgCQl0bXAgPSBSRUdfU0VUX0ZJRUxE
KHRtcCwgVk1MMlZDMF9WTV9DT05URVhUMV9DTlRMLAo+IC0JCQkJICAgIFJFVFJZX1BFUk1JU1NJ
T05fT1JfSU5WQUxJRF9QQUdFX0ZBVUxULCAwKTsKPiArCQkJCSAgICBSRVRSWV9QRVJNSVNTSU9O
X09SX0lOVkFMSURfUEFHRV9GQVVMVCwKPiArCQkJCSAgICAhYW1kZ3B1X25vcmV0cnkpOwo+ICAg
CQlXUkVHMzJfU09DMTVfT0ZGU0VUKE1NSFVCLCAwLCBtbVZNTDJWQzBfVk1fQ09OVEVYVDFfQ05U
TCwKPiAgIAkJCQkgICAgaHViaWQgKiBNTUhVQl9JTlNUQU5DRV9SRUdJU1RFUl9PRkZTRVQgKyBp
LAo+ICAgCQkJCSAgICB0bXApOwo+IEBAIC05MDUsNCArOTA2LDQgQEAgc3RhdGljIHZvaWQgbW1o
dWJfdjlfNF9xdWVyeV9yYXNfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4gICBjb25zdCBzdHJ1Y3QgYW1kZ3B1X21taHViX2Z1bmNzIG1taHViX3Y5XzRfZnVuY3MgPSB7
Cj4gICAJLnJhc19sYXRlX2luaXQgPSBhbWRncHVfbW1odWJfcmFzX2xhdGVfaW5pdCwKPiAgIAku
cXVlcnlfcmFzX2Vycm9yX2NvdW50ID0gbW1odWJfdjlfNF9xdWVyeV9yYXNfZXJyb3JfY291bnQs
Cj4gLX07Cj4gXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCj4gK307Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
