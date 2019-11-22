Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD15C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 20:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD13720706
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 20:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD13720706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535906E0DA;
	Fri, 22 Nov 2019 20:19:56 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730062.outbound.protection.outlook.com [40.107.73.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94686E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 20:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYhOfChJOjmWdWBx8qmHUedS5Lq3tc+yGl+tOmGVzL0R5wnYU3w1iMX5DM0R88ZetXnSGGbkX8wZttYCKxKPiB4zI8UqbGlEPuKZ+E9miGxf+O2IqyOhxPJZv+kiPJeXwwdnDfVg5pDdY4wtthWmObJaUe8+yk6T8yxDjuJHOL1nVnZ6yrNym+F4E5JfcXq2XU4o9jYWnRWu8lrTQxlGdaLH9YDT92x9xKCxEIZGW3qbqhfPVQ6F5L3btja0DT/K37I0TWepMOv96m0f5LugLteN/XmBRdVVuZFuCv9nlPioreZzWXK8bRvQr0Cdkeykn2/uHO89iZ3xCjUeTNVR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7yRKYf735/L5wNId9516cec5R+Tpr6ORids3Pvu34Q=;
 b=WMRvdEqiFy0/vS608ZzRfM8ZT3qcAxOfD6RCqSGPiJssR5n2t9Itq0xOk7s1JxN34MyRFj0blWuJV7d5/uJ7o/S766nm9wGlvDC5a5/gzH9uxe8qJXKF2mcwxZ+hlaT6V3Eenzr0ddHEggUjOHEOYNd/OK/K9D4D8w1vuFnbY65JoN39bPhaDJ8F6D70u2zI8bexoKwYzL3imh1YoxHDREHc/SlUqQwR7WFGAK+ZC7LpgCQWoPzHmuhm2IpC0HsDYfKCmYzRjzTSy/8slgxU7OkLNvvTPtNKdlCchtJYqIdslxcNoRNZFCogu3IeULMXBFgRths4DYFJ+hHv1VESag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3333.namprd12.prod.outlook.com (20.178.55.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 20:19:51 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 20:19:50 +0000
Subject: Re: [PATCH] drm/amd/display: add default clocks if not able to fetch
 them
To: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20191119205639.244832-1-alexander.deucher@amd.com>
 <CADnq5_O70hUYjTmv_bkcKKwU4_boOAu5UHz9AcgZir89vX55yw@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <56ce589d-a14c-1772-ebcf-22260130f50b@amd.com>
Date: Fri, 22 Nov 2019 15:19:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <CADnq5_O70hUYjTmv_bkcKKwU4_boOAu5UHz9AcgZir89vX55yw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c96885bb-f62d-43fa-db6f-08d76f8953ba
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:|BYAPR12MB3333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33335582BBC0C8E4978E1505EC490@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02296943FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(386003)(6246003)(6436002)(76176011)(4001150100001)(53546011)(6506007)(2616005)(52116002)(446003)(65806001)(66066001)(186003)(3846002)(230700001)(229853002)(25786009)(11346002)(14444005)(6116002)(65956001)(2906002)(47776003)(305945005)(8676002)(36756003)(6486002)(26005)(7736002)(31686004)(8936002)(86362001)(81156014)(14454004)(478600001)(6666004)(66556008)(50466002)(66946007)(110136005)(316002)(66476007)(31696002)(4326008)(58126008)(5660300002)(2486003)(23676004)(6512007)(81166006)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3333;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2psHlLy3oa/BEzrtZ//2IdLNhFPIHw1vkTphhqyq9KyrBlPNSlol/gFxWJQ92stYuSTF/6Yh6oT+CeZaiMh2jiHwWczKd+JRE6bKIX+3/pCfmbmabKoFb1oDh0tqTsAB24uxPreF5Ep8itA4Ta+uT+nxKHF0RWUDCxOZSdn1V1MMYf5FCkZyiFObyMHaOsGLnYe5xX30Jn/ecDXQxM7etU2fPBrbwH00L1Dul1pm4bCNEELB3L/iapcWyl9+1a7skNs159Avr7XjNeJ9UUqAjtKcBu5LE9HNplXTz7G5vXQ0A9GLnVIUSFh8cqKKDMrBADHHl4tIsozf4eBsD4Fa6uv3PZog5uYZ9oIZ7MJk+tvG5OlyQQRjyUhoOJmBw20Gz4vq938pSi+qi53EzKLlqJkSmkAUqj0BaagOA2gzsiV+pfUr+Lzm/V3zwBFINdq+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96885bb-f62d-43fa-db6f-08d76f8953ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 20:19:50.8448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXqN53r8gI0DNUM/sFZCJ1Q0EVNSSLwN61Gma6Y59mjyCyPZ8CDnBbWLifTZXKEuQcEE28pQLogG+J3Ro4eclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7yRKYf735/L5wNId9516cec5R+Tpr6ORids3Pvu34Q=;
 b=LkYPqbDJ486dQwMRmqFlhqvo+Fa9rLIlsh/7dZuZOmUYrrFUL9S4age2B1c0MaFma9EHvnV58w0E45SKD9ARtwOw6urHRTJ7bxU4K8Dcqd51qDFhCK5qXeh9IFgV46dVzmyUJXsGq+DMB89CkjEY3aGz9V3A86OoVstBYzBTyoU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122201947.NdisWrhTVRy2wky0LeACDHoKsC269mwCUOSv94UgaCA@z>

UmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1k
LmNvbT4KCk9uIDIwMTktMTEtMjIgMTowOSBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gUGlu
Zz8KPiAKPiBPbiBUdWUsIE5vdiAxOSwgMjAxOSBhdCAzOjU2IFBNIEFsZXggRGV1Y2hlciA8YWxl
eGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPj4KPj4gZG1fcHBfZ2V0X2Nsb2NrX2xldmVsc19i
eV90eXBlIG5lZWRzIHRvIGFkZCB0aGUgZGVmYXVsdCBjbG9ja3MKPj4gdG8gdGhlIHBvd2VycGxh
eSBjYXNlIGFzIHdlbGwuICBUaGlzIHdhcyBhY2NpZGVudGx5IGRyb3BwZWQuCj4+Cj4+IEZpeGVz
OiBiM2VhODhmZWYzMjFkZSAoImRybS9hbWQvcG93ZXJwbGF5OiBhZGQgZ2V0X2Nsb2NrX2J5X3R5
cGUgaW50ZXJmYWNlIGZvciBkaXNwbGF5IikKPj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYyB8IDMgKystCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHBf
c211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9w
cF9zbXUuYwo+PiBpbmRleCAyMjk3ODhiZWU1NDQuLmEyZTFhNzNmNjZiOCAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHBfc211
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG1fcHBfc211LmMKPj4gQEAgLTM0Miw3ICszNDIsOCBAQCBib29sIGRtX3BwX2dldF9jbG9ja19s
ZXZlbHNfYnlfdHlwZSgKPj4gICAgICAgICAgaWYgKGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcyAm
JiBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MtPmdldF9jbG9ja19ieV90eXBlKSB7Cj4+ICAgICAg
ICAgICAgICAgICAgaWYgKGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+Z2V0X2Nsb2NrX2J5X3R5
cGUocHBfaGFuZGxlLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgZGNfdG9fcHBfY2xvY2tf
dHlwZShjbGtfdHlwZSksICZwcF9jbGtzKSkgewo+PiAtICAgICAgICAgICAgICAgLyogRXJyb3Ig
aW4gcHBsaWIuIFByb3ZpZGUgZGVmYXVsdCB2YWx1ZXMuICovCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIC8qIEVycm9yIGluIHBwbGliLiBQcm92aWRlIGRlZmF1bHQgdmFsdWVzLiAqLwo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBnZXRfZGVmYXVsdF9jbG9ja19sZXZlbHMoY2xrX3R5cGUs
IGRjX2Nsa3MpOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4+ICAg
ICAgICAgICAgICAgICAgfQo+PiAgICAgICAgICB9IGVsc2UgaWYgKGFkZXYtPnNtdS5wcHRfZnVu
Y3MgJiYgYWRldi0+c211LnBwdF9mdW5jcy0+Z2V0X2Nsb2NrX2J5X3R5cGUpIHsKPj4gLS0KPj4g
Mi4yMy4wCj4+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
