Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE403C3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC8524695
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AaiALOHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC8524695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4582D6E142;
	Fri, 28 Feb 2020 09:27:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9E66E142
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 09:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt5YPXA30wy3uKylmVkgUymtE0IvL6quAqon/DNcY7CDo41JYLRGliNN6pukRJc7K2v2jR9Cjw7xU7lU3s9oaLp0hsPoNN/1ryD8AehORwvucIFAa72VwuO8lM8rC+qceOWv3xS7sIQFVJOhLVvm/AFNIjgEFg7q1rM1/s/UuiJDz/b/m6+gilScggwiAm7dFGe9tGFs7RCIBEzlrPb88HX4cP3AQV4tcjJYvpvHwYdZD3tVW/aitWjwYkfUY7h/TrwiZsO9NC+L38o2pRbkR9X7n6PUk1yauP+iI0RIxE3JWouHdsngeVEEI2CMHHp7M9VkOGQ6UKWPydLOc13hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbWnr/XahJNpJZJtM+a5FyG/PIrumTjYmKNPp+Tk2O0=;
 b=F2mBa+qaiOfkBV5yrSaGiid7Sz+wflUkDIMz5iGV+sJ98wvgOC8+S4zxQKVN7X6GtZazyLctz3stZY/6hiFRNYNtxu6FBNb/6X9rpzkw+/WbxrzahvtlufmMa6JOCp8SEFrNQGrFbdQN1vgz7SZeJkent7vRK258lf8a3m2/FBfw4Lgge8ztROZHUZVKwyC1EdGCxqqgd1mbP9izGyTDEKGmOS+GgkKMyFgIF9kzbKKX/RXMGiNTBIFXDCGZsERPvPn/DTFd1vEkLG/vN5a4d8MPP787Ba9yHBHo3ySXoiLrSIjja9e5zEFu0j+OG1ZOClRLqpIo3Utdm3T2sh4VYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbWnr/XahJNpJZJtM+a5FyG/PIrumTjYmKNPp+Tk2O0=;
 b=AaiALOHm8z2RjMrE9AdCcPXohMvqYn0kL/2yinZJ2mW2/PoiLKuIzEVIZeCVnyUVo70DPQzem4LsblB0BjOENVmrogWT9gxyBT2/N6B3VmBFsKILz+ZXZGnRIu1ionVxWcflPdW1yyGpfxYOOhMgNLCLkmdWHlFnVUU9zOOPbdc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Fri, 28 Feb 2020 09:26:59 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 09:26:59 +0000
Subject: Re: [RFC PATCH 2/4] drm/scheduler: implement a function to modify
 sched list
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200227214012.3383-1-nirmoy.das@amd.com>
 <20200227214012.3383-2-nirmoy.das@amd.com>
 <46106fdd-55ed-cb09-902e-a1c0cffd7b0d@amd.com>
 <d87c9952-1eb8-5295-a1bc-475f5e94fc78@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <6fb0dff5-9262-6374-3549-dc598e7fd477@amd.com>
Date: Fri, 28 Feb 2020 10:30:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <d87c9952-1eb8-5295-a1bc-475f5e94fc78@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0042.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::22) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f28:ef00:805e:149d:bfe0:9c45]
 (2003:c5:8f28:ef00:805e:149d:bfe0:9c45) by
 AM0PR10CA0042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Fri, 28 Feb 2020 09:26:58 +0000
X-Originating-IP: [2003:c5:8f28:ef00:805e:149d:bfe0:9c45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a37c26d-bf95-4198-977a-08d7bc305c8a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:|DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23584A90401771022B9C60128BE80@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(53546011)(81166006)(16526019)(36756003)(52116002)(8936002)(186003)(4326008)(110136005)(8676002)(5660300002)(316002)(31696002)(81156014)(66574012)(66946007)(66556008)(6486002)(6666004)(31686004)(478600001)(2906002)(2616005)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2358;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3Xb3Lw4J3+E8EPMY4CPZplSDa0Ndwqk2oGxcFNTbrv3pLhk83FoF6KerLwm6IWymeC61MUUuvC5dhD3YuTKBkABbN9UjodsgbHNWa36jR5ZJB33lxMAJHDKnbuDW7dDZs2HPq9IpzucWHZVtLBCqGwzQxFQRpSf7z9l8/cUqPkPYWKYQzoFfPk8Yak9MHPy8mM9LXfOH2ozHDg7Bo2D0MzdtudI/f6jkXF6RnW2e+3YBI0xIv1MrrGPP8/TW6hEe67pL4loBvD8s/DUtK6opvRJQQf8XHLiPbqstFtEacjeD8ogrTz5b3kq4DRpDstagGqdQ9QGgqlQMKHwPrRq7yooErfN8ItggXYZdw/FPk0IrXTrWlCygh5Jzrge2f4qAIMe6hwffxeLFPC3PdVNvVGybK/AvNR2IWArUd0y5edqL6KHK7XKb6Fz9l5DkjIB
X-MS-Exchange-AntiSpam-MessageData: HjoDB2tA5cHr1Zt2DxtLndZhZWldL132qc8YPpEE14g/Idl/c9ax5iAMp60rjj68cRNYxBxHUiLdsjM+ekTvBFQRMTCA+y9zwD8wA8Xn0DRdu+TOT4MPsSjrzipyNvO6ZnVico3dXxYWRaw2MwWZlrxugEF9ahTI3rTD2wWJauYVq8Cq1pQATKvRifmo7FVJAj7K9c82oD4RkviBvCwe5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a37c26d-bf95-4198-977a-08d7bc305c8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 09:26:59.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbrivPftDSEOm8VZTo+mpf9nifhj3b35yZ2IK8GtPP3md1YosQylYgJGxPKHPF085lbvVRh3+9GhXPXdaiNw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIvMjgvMjAgODo0NyBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyOC4wMi4y
MCB1bSAwNjowOCBzY2hyaWViIEx1YmVuIFR1aWtvdjoKPj4gT24gMjAyMC0wMi0yNyA0OjQwIHAu
bS4sIE5pcm1veSBEYXMgd3JvdGU6Cj4+PiBpbXBsZW1lbnQgZHJtX3NjaGVkX2VudGl0eV9tb2Rp
Znlfc2NoZWQoKSB3aGljaCBjYW4gbW9kaWZ5IGV4aXN0aW5nCj4+PiBzY2hlZF9saXN0IHdpdGgg
YSBkaWZmZXJlbnQgb25lLiBUaGlzIGlzIGdvaW5nIHRvIGJlIGhlbHBmdWwgd2hlbgo+Pj4gdXNl
cnNwYWNlIGNoYW5nZXMgcHJpb3JpdHkgb2YgYSBjdHgvZW50aXR5IHRoZW4gZHJpdmVyIGNhbiBz
d2l0Y2ggdG8KPj4+IGNvcnJlc3BvbmRpbmcgaHcgc2hjZWQgbGlzdCBmb3IgdGhhdCBwcmlvcml0
eQo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4K
Pj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8
IDI0IAo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiDCoCBpbmNsdWRlL2RybS9ncHVf
c2NoZWR1bGVyLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKysrCj4+PiDCoCAy
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyAKPj4+IGIvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4gaW5kZXggNjNiY2NkMjAxYjk3Li43MTFl
OWQ1MDRiY2IgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X2VudGl0eS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0
eS5jCj4+PiBAQCAtODMsNiArODMsMzAgQEAgaW50IGRybV9zY2hlZF9lbnRpdHlfaW5pdChzdHJ1
Y3QgZHJtX3NjaGVkX2VudGl0eSAKPj4+ICplbnRpdHksCj4+PiDCoCB9Cj4+PiDCoCBFWFBPUlRf
U1lNQk9MKGRybV9zY2hlZF9lbnRpdHlfaW5pdCk7Cj4+PiDCoCArLyoqCj4+PiArICogZHJtX3Nj
aGVkX2VudGl0eV9tb2RpZnlfc2NoZWQgLSBNb2RpZnkgc2NoZWQgb2YgYW4gZW50aXR5Cj4+PiAr
ICoKPj4+ICsgKiBAZW50aXR5OiBzY2hlZHVsZXIgZW50aXR5IHRvIGluaXQKPj4+ICsgKiBAc2No
ZWRfbGlzdDogdGhlIGxpc3Qgb2YgbmV3IGRybSBzY2hlZHMgd2hpY2ggd2lsbCByZXBsYWNlCj4+
PiArICrCoMKgwqDCoMKgwqDCoCBleGlzdGluZyBlbnRpdHktPnNjaGVkX2xpc3QKPj4+ICsgKiBA
bnVtX3NjaGVkX2xpc3Q6IG51bWJlciBvZiBkcm0gc2NoZWQgaW4gc2NoZWRfbGlzdAo+Pj4gKyAq
Cj4+PiArICogUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG9u
IGZhaWx1cmUuCj4+PiArICovCj4+PiAraW50IGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVk
KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKipzY2hlZF9saXN0LAo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IG51bV9z
Y2hlZF9saXN0KQo+Pj4gK3sKPj4+ICvCoMKgwqAgaWYgKCEoZW50aXR5ICYmIHNjaGVkX2xpc3Qg
JiYgKG51bV9zY2hlZF9saXN0ID09IDAgfHwgCj4+PiBzY2hlZF9saXN0WzBdKSkpCj4+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+IFRoaXMgc2VlbXMgdW5tYWludGFpbmFibGUu
IEknZCB3cml0ZSBpdCBpbiBpdHMgbmF0dXJhbCBmb3JtOgo+Cj4gVGhpcyBpcyBwcm9iYWJseSBq
dXN0IGNvcHkgJiBwYXN0ZWQgZnJvbSB0aGUgaW5pdCBmdW5jdGlvbiBhbmQgCj4gY29tcGxldGUg
b3ZlcmtpbGwgaGVyZS4KV2FzIGluZGVlZCBsYW1lIGNvcHkgcGFzdGUgZnJvbSBteSBzaWRlLgo+
Cj4+Cj4+IFNvIGlmIG51bV9zY2hlZF9saXN0IGlzIDAgb3IgMSB3ZSByZXR1cm4gTlVMTD8KPj4g
QW5kIGlmIG51bV9zY2hlZF9saXN0IGlzIDIgb3IgZ3JlYXRlciB3ZSByZXR1cm4gc2NoZWRfbGlz
dAo+PiBvZiB3aGljaCBzY2hlZF9saXN0WzBdIGNvdWxkIGJlIE5VTEw/Cj4KPiBUaGlzIGlzIGFs
c28gY29weSZwYXN0ZWQgZnJvbSB0aGUgaW5pdCBjb2RlIGFuZCBjb21wbGV0ZWx5IHdyb25nIGhl
cmUuCj4KPiBXaGF0IHdlIHNob3VsZCBkbyBpbnN0ZWFkIGlzIGp1c3Q6IFdBUk5fT04oIW51bV9z
Y2hlZF9saXN0IHx8IAo+ICFzY2hlZF9saXN0KTsKClRoYW5rcywgdGhpcyB3aWxsIG1ha2UgaXQg
bXVjaCBzaW1wbGUuIEkgd2lsbCBoYXZlIHRoaXMgaW4gbmV4dCB2ZXJzaW9uLgoKTmlybW95CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
