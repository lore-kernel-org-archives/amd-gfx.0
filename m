Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA73C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED68207FD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O4FkDvFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED68207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F71589AFF;
	Mon, 13 Jan 2020 16:53:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D812E89AFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 16:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Idugk5YJVhjeujOogD3CHnWdUSHZDb+x1VO9z7l1i+LujzBbqeJsS4ySMm/NqncBPq7CDDOK6g/jl6ei8aylKU5B2AGCzX/hkZ4kQ+MuTj8WcCqDbP+GJa6NUbBUvFdAbEU9TSraxu2OB+e3wU5zPw3Cp5UdSsAf9k0+zlCEFaps4T1GRay5LpDDPHdZOFphDhsDFuB1WLLx5QiVch1/DI6fb9GOzc2DIm1IR5gV/e+qprFZY1D/xBTHtrvgIwvS+iW3jHRENyMX85bX9A0UvLOUoJo5cW2sPysMgRSihKYy80nuGkkoTFu90T3fgG7HaDLqPIHxRSAWIX0HqknfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh+HaH3Dgo4VtXjybi/UvpjQNkvSOes9fYA3/rYAfyE=;
 b=Pm4CyEAtCohtJ1693PEt/Sr5+x8OVwaaQenvkTMUVkD9qJWnWOqLgz2dBunyJ7LFlO1HuRhGrnrlzsRmU72ekq9aYcPa99LKsMDtkzRIkrAL/FaXI/IJ8dKz2+DXH3a3kc9G5K8ZNNdxawDLGX1ZIb+lNxLz9PBxziEsDDaXJx4vE3/fD/3AQ/xoaNYqkSVGqW+mXUi98yJ5eJ3fg/TJdzlYR8peYmKMPXU75qqwXex9hGXWvHW9P9wqZsDqCVtEKHMgzj5DD6unyomnCkMJuBtBB9E4zEQs2HcB296BrOsrF1l18IxjO1CtUaCKUX4XLk/dGndDE8Xp9PnIEH2Hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh+HaH3Dgo4VtXjybi/UvpjQNkvSOes9fYA3/rYAfyE=;
 b=O4FkDvFBub0rLHb4HR3hS8d4VRtvHUV6DNxCTWrl6SJk64iKOT+o9m5Gz2n8LxoJe1AJcIUNBu5AdStaNI0YjnZ4n8VksUL8cutL0pqJtIklNnMaknkwIu1P3bWWNP9dbx8IAf3wRdaG5gxBPww4vMD5ZywPz/xOjc1vKScGkUY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (10.174.107.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 16:53:03 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 16:53:03 +0000
Subject: Re: [PATCH 4/7] drm/amdgpu: replace kcq enable function on gfx_v9
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200111183938.126310-1-alex.sierra@amd.com>
 <20200111183938.126310-4-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <c4970147-6bfd-2cec-115c-1fac615bfe6f@amd.com>
Date: Mon, 13 Jan 2020 11:53:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200111183938.126310-4-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Mon, 13 Jan 2020 16:53:03 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02a71b0a-6178-439e-383a-08d798490e3f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:|DM5PR1201MB0203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203F37FAF2F349879279B1D92350@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(44832011)(2906002)(2616005)(16526019)(36916002)(186003)(52116002)(53546011)(956004)(26005)(316002)(16576012)(8936002)(8676002)(81166006)(81156014)(31686004)(5660300002)(6486002)(36756003)(31696002)(66556008)(66946007)(66476007)(86362001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0203;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MW4RvsImP4NFKMXVKk7ZuVpuHVIJe7msi2O/n6LnqUkOatuiQElfoIzO1YPKkCK0norIN1WMEvgEAbsYcv0oWzF9BUnBtTqlBenPrPEDv5lmcxxP+mr33V0TKakxrRv0aRXpL11zs4SUBQ9F4+KwLPfte21vXR/ngkpnVm5jFhtD1NYzFkVYM+wqZwZAu2+KTGNkcDWaaN10Fb+igyzjmoYAn1mDDoJ3CzJSO2gIJIyRkfjdkd5nwgo/nO0IvZI6+HLFJCbnz4YAi0b6AbOmF6qNcTcApt5WNaZ+CR4knm2nVWNwwF/Vmq+4kgSSwx2grYedynf2IIwIAmAOitfYEsK0iSBNRUm5lHBDVJWv0sLNaY2whs+M8rG7+6vzHcDt11QBsnvBBWJlMYl8ay84iJAEWnQzpiqmDDqkAbFre9WJLA09vc/kIbr2NnSyYgcm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a71b0a-6178-439e-383a-08d798490e3f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 16:53:03.6562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HfoGf2SM+WaK6BOghRfbpL+BsD3OZDq3qr6+qJEQiDFOus7IUHfrAYVIo747061arzDDceW1Lhtw0MLf+UC6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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

Q2FuIHlvdSBpbmNsdWRlIGtjcV9kaXNhYmxlIGluIHRoZSBwYXRjaCBhcyB3ZWxsPwoKVGhhbmtz
LAogwqAgRmVsaXgKCk9uIDIwMjAtMDEtMTEgMTozOSBwLm0uLCBBbGV4IFNpZXJyYSB3cm90ZToK
PiBbV2h5XQo+IFRoZXJlJ3MgYSBIVy1pbmRwZW5kZW50IGZ1bmN0aW9uIHRoYXQgZW5hYmxlcyBr
Y3EuIFRoaXMgZnVuY3Rpb24gdXNlcwo+IHRoZSBraXFfcG00X2Z1bmNzIGltcGxlbWVudGF0aW9u
Lgo+Cj4gW0hvd10KPiBMb2NhbCBrY3EgZW5hYmxlIGZ1bmN0aW9uIHJlbW92ZWQgYW5kIHJlcGxh
Y2UgaXQgYnkgdGhlIGdlbmVyaWMga2NxCj4gZW5hYmxlIHVuZGVyIGFtZGdwdV9nZngKPgo+IENo
YW5nZS1JZDogSTc3MDliZGJhOTM3NDJjMjM0OTQxYTU5MzZjODJlYjY3ZTM0NjA3N2MKPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KPiAtLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA3MCArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNjkgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiBpbmRleCA1YmU2
ZmFiNTViNzMuLjcyMTllYWNhZDljZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYwo+IEBAIC0zMjUyLDc0ICszMjUyLDYgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfa2lx
X3NldHRpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAgCVdSRUczMl9TT0MxNV9STEMo
R0MsIDAsIG1tUkxDX0NQX1NDSEVEVUxFUlMsIHRtcCk7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGlu
dCBnZnhfdjlfMF9raXFfa2NxX2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAt
ewo+IC0Jc3RydWN0IGFtZGdwdV9yaW5nICpraXFfcmluZyA9ICZhZGV2LT5nZngua2lxLnJpbmc7
Cj4gLQl1aW50NjRfdCBxdWV1ZV9tYXNrID0gMDsKPiAtCWludCByLCBpOwo+IC0KPiAtCWZvciAo
aSA9IDA7IGkgPCBBTURHUFVfTUFYX0NPTVBVVEVfUVVFVUVTOyArK2kpIHsKPiAtCQlpZiAoIXRl
c3RfYml0KGksIGFkZXYtPmdmeC5tZWMucXVldWVfYml0bWFwKSkKPiAtCQkJY29udGludWU7Cj4g
LQo+IC0JCS8qIFRoaXMgc2l0dWF0aW9uIG1heSBiZSBoaXQgaW4gdGhlIGZ1dHVyZSBpZiBhIG5l
dyBIVwo+IC0JCSAqIGdlbmVyYXRpb24gZXhwb3NlcyBtb3JlIHRoYW4gNjQgcXVldWVzLiBJZiBz
bywgdGhlCj4gLQkJICogZGVmaW5pdGlvbiBvZiBxdWV1ZV9tYXNrIG5lZWRzIHVwZGF0aW5nICov
Cj4gLQkJaWYgKFdBUk5fT04oaSA+PSAoc2l6ZW9mKHF1ZXVlX21hc2spKjgpKSkgewo+IC0JCQlE
Uk1fRVJST1IoIkludmFsaWQgS0NRIGVuYWJsZWQ6ICVkXG4iLCBpKTsKPiAtCQkJYnJlYWs7Cj4g
LQkJfQo+IC0KPiAtCQlxdWV1ZV9tYXNrIHw9ICgxdWxsIDw8IGkpOwo+IC0JfQo+IC0KPiAtCXIg
PSBhbWRncHVfcmluZ19hbGxvYyhraXFfcmluZywgKDcgKiBhZGV2LT5nZngubnVtX2NvbXB1dGVf
cmluZ3MpICsgOCk7Cj4gLQlpZiAocikgewo+IC0JCURSTV9FUlJPUigiRmFpbGVkIHRvIGxvY2sg
S0lRICglZCkuXG4iLCByKTsKPiAtCQlyZXR1cm4gcjsKPiAtCX0KPiAtCj4gLQkvKiBzZXQgcmVz
b3VyY2VzICovCj4gLQlhbWRncHVfcmluZ193cml0ZShraXFfcmluZywgUEFDS0VUMyhQQUNLRVQz
X1NFVF9SRVNPVVJDRVMsIDYpKTsKPiAtCWFtZGdwdV9yaW5nX3dyaXRlKGtpcV9yaW5nLCBQQUNL
RVQzX1NFVF9SRVNPVVJDRVNfVk1JRF9NQVNLKDApIHwKPiAtCQkJICBQQUNLRVQzX1NFVF9SRVNP
VVJDRVNfUVVFVUVfVFlQRSgwKSk7CS8qIHZtaWRfbWFzazowIHF1ZXVlX3R5cGU6MCAoS0lRKSAq
Lwo+IC0JYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3JpbmcsIGxvd2VyXzMyX2JpdHMocXVldWVfbWFz
aykpOwkvKiBxdWV1ZSBtYXNrIGxvICovCj4gLQlhbWRncHVfcmluZ193cml0ZShraXFfcmluZywg
dXBwZXJfMzJfYml0cyhxdWV1ZV9tYXNrKSk7CS8qIHF1ZXVlIG1hc2sgaGkgKi8KPiAtCWFtZGdw
dV9yaW5nX3dyaXRlKGtpcV9yaW5nLCAwKTsJLyogZ3dzIG1hc2sgbG8gKi8KPiAtCWFtZGdwdV9y
aW5nX3dyaXRlKGtpcV9yaW5nLCAwKTsJLyogZ3dzIG1hc2sgaGkgKi8KPiAtCWFtZGdwdV9yaW5n
X3dyaXRlKGtpcV9yaW5nLCAwKTsJLyogb2FjIG1hc2sgKi8KPiAtCWFtZGdwdV9yaW5nX3dyaXRl
KGtpcV9yaW5nLCAwKTsJLyogZ2RzIGhlYXAgYmFzZTowLCBnZHMgaGVhcCBzaXplOjAgKi8KPiAt
CWZvciAoaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmluZ3M7IGkrKykgewo+IC0J
CXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICZhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldOwo+
IC0JCXVpbnQ2NF90IG1xZF9hZGRyID0gYW1kZ3B1X2JvX2dwdV9vZmZzZXQocmluZy0+bXFkX29i
aik7Cj4gLQkJdWludDY0X3Qgd3B0cl9hZGRyID0gYWRldi0+d2IuZ3B1X2FkZHIgKyAocmluZy0+
d3B0cl9vZmZzICogNCk7Cj4gLQo+IC0JCWFtZGdwdV9yaW5nX3dyaXRlKGtpcV9yaW5nLCBQQUNL
RVQzKFBBQ0tFVDNfTUFQX1FVRVVFUywgNSkpOwo+IC0JCS8qIFFfc2VsOjAsIHZtaWQ6MCwgdmlk
bWVtOiAxLCBlbmdpbmU6MCwgbnVtX1E6MSovCj4gLQkJYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3Jp
bmcsIC8qIFFfc2VsOiAwLCB2bWlkOiAwLCBlbmdpbmU6IDAsIG51bV9ROiAxICovCj4gLQkJCQkg
IFBBQ0tFVDNfTUFQX1FVRVVFU19RVUVVRV9TRUwoMCkgfCAvKiBRdWV1ZV9TZWwgKi8KPiAtCQkJ
CSAgUEFDS0VUM19NQVBfUVVFVUVTX1ZNSUQoMCkgfCAvKiBWTUlEICovCj4gLQkJCQkgIFBBQ0tF
VDNfTUFQX1FVRVVFU19RVUVVRShyaW5nLT5xdWV1ZSkgfAo+IC0JCQkJICBQQUNLRVQzX01BUF9R
VUVVRVNfUElQRShyaW5nLT5waXBlKSB8Cj4gLQkJCQkgIFBBQ0tFVDNfTUFQX1FVRVVFU19NRSgo
cmluZy0+bWUgPT0gMSA/IDAgOiAxKSkgfAo+IC0JCQkJICBQQUNLRVQzX01BUF9RVUVVRVNfUVVF
VUVfVFlQRSgwKSB8IC8qcXVldWVfdHlwZTogbm9ybWFsIGNvbXB1dGUgcXVldWUgKi8KPiAtCQkJ
CSAgUEFDS0VUM19NQVBfUVVFVUVTX0FMTE9DX0ZPUk1BVCgwKSB8IC8qIGFsbG9jIGZvcm1hdDog
YWxsX29uX29uZV9waXBlICovCj4gLQkJCQkgIFBBQ0tFVDNfTUFQX1FVRVVFU19FTkdJTkVfU0VM
KDApIHwgLyogZW5naW5lX3NlbDogY29tcHV0ZSAqLwo+IC0JCQkJICBQQUNLRVQzX01BUF9RVUVV
RVNfTlVNX1FVRVVFUygxKSk7IC8qIG51bV9xdWV1ZXM6IG11c3QgYmUgMSAqLwo+IC0JCWFtZGdw
dV9yaW5nX3dyaXRlKGtpcV9yaW5nLCBQQUNLRVQzX01BUF9RVUVVRVNfRE9PUkJFTExfT0ZGU0VU
KHJpbmctPmRvb3JiZWxsX2luZGV4KSk7Cj4gLQkJYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3Jpbmcs
IGxvd2VyXzMyX2JpdHMobXFkX2FkZHIpKTsKPiAtCQlhbWRncHVfcmluZ193cml0ZShraXFfcmlu
ZywgdXBwZXJfMzJfYml0cyhtcWRfYWRkcikpOwo+IC0JCWFtZGdwdV9yaW5nX3dyaXRlKGtpcV9y
aW5nLCBsb3dlcl8zMl9iaXRzKHdwdHJfYWRkcikpOwo+IC0JCWFtZGdwdV9yaW5nX3dyaXRlKGtp
cV9yaW5nLCB1cHBlcl8zMl9iaXRzKHdwdHJfYWRkcikpOwo+IC0JfQo+IC0KPiAtCXIgPSBhbWRn
cHVfcmluZ190ZXN0X2hlbHBlcihraXFfcmluZyk7Cj4gLQlpZiAocikKPiAtCQlEUk1fRVJST1Io
IktDUSBlbmFibGUgZmFpbGVkXG4iKTsKPiAtCj4gLQlyZXR1cm4gcjsKPiAtfQo+IC0KPiAgIHN0
YXRpYyBpbnQgZ2Z4X3Y5XzBfbXFkX2luaXQoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAg
ewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKPiBAQCAtMzcy
Niw3ICszNjU4LDcgQEAgc3RhdGljIGludCBnZnhfdjlfMF9rY3FfcmVzdW1lKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQo+ICAgCQkJZ290byBkb25lOwo+ICAgCX0KPiAgIAo+IC0JciA9IGdm
eF92OV8wX2tpcV9rY3FfZW5hYmxlKGFkZXYpOwo+ICsJciA9IGFtZGdwdV9nZnhfZW5hYmxlX2tj
cShhZGV2KTsKPiAgIGRvbmU6Cj4gICAJcmV0dXJuIHI7Cj4gICB9Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
