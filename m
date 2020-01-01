Return-Path: <SRS0=Ppqo=2W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD89C2D0DC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 11:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD5E2072C
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 11:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EQB6y/SK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD5E2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA56789B30;
	Wed,  1 Jan 2020 11:17:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A986789B30
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jan 2020 11:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5h4rMi3hKHud6HrF8l2yNShWrj4akRps3wHw6bWXVG5QuvQvzx9jb+UwkAqd14m0IbUQVV1C9At8MouoPdYqEZ32KRkOqLB1AOdJfjrEA5OnZ8WwWcTGSi5lzWekPVg0lFubGpUrjfESbkv2EguoTto1r3XGnvSI6Ap0lU3KUcwIbhE6VZDmfZGQ9A3O9lJf7z6cF9i9s5TujiPSdWqqi8n4KNN8mWWFeMcTiJCUZN41XZZXssbs7XYi5ucnsv5a5Wt9bwFohA5BCJB853RJw0CFKWR0WYj75rq954rRYrH55ithDQBRN+1QZNfrpmGhwh4RGTQ6QIDGMaKBQQ6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6Ulw/8BsRWARH56utjZIdd9UwLlghSs35xeZSAK6Io=;
 b=D/zcxpHPRccefxhvBr7Kd0pHQD5tCEgWc4nCrrtfoCghLEQWs6bFLHstI1PVFdDmoLG5o4QpcdT+Pyd0QSrXuww7PriUkR4wxXqFsda1z6jq7HOYJpqGcP5x55bKOLygctYuY01hfgPhmjj2IArQwOyx1R6oU+A9DUETmQnilv5n34t7j4e4UPjFtx69BsezHh85An88vripmM3fzVKZ/i5NdNGTSYAi6snh1Hc4rpf5LbzJTL35Ml3PykimX/Us/eIKi3eBX5/JBsi9XpoFi94+uVVWQOH2leGbl0TmNQ+osjiL1JvpqfGAsxjkBeCRYWTpSfnFCMksZV2KOCr2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6Ulw/8BsRWARH56utjZIdd9UwLlghSs35xeZSAK6Io=;
 b=EQB6y/SKtnCdlgaW8K3li4zZEI8UL6tvcgBLpamaAKkxAHXGO90tQ2Dpbo8YLNpMWNJh/qIYcRz45nyirz4LROvL/i7wNbapZY/BDtU0j7Dfln2C9RPIj2/3++V1Cy4JOPtk4S93eq34P6vBDTtiug8f8JlSrpssnJyjsAKYoSI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2533.namprd12.prod.outlook.com (52.132.139.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 1 Jan 2020 11:17:35 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2581.013; Wed, 1 Jan 2020
 11:17:35 +0000
Subject: Re: [PATCH] drm/amdgpu: correctly report gpu recover status
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191218032534.28482-1-evan.quan@amd.com>
 <5ae5f01d-e7cd-d6b4-2433-90c03809e1b3@gmail.com>
 <MN2PR12MB3344EA5ABA08AA3C3DB61DA8E4520@MN2PR12MB3344.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <91cee3b3-08f4-95fc-5a74-ca0aad38b4aa@amd.com>
Date: Wed, 1 Jan 2020 12:17:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB3344EA5ABA08AA3C3DB61DA8E4520@MN2PR12MB3344.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10 via Frontend Transport; Wed, 1 Jan 2020 11:17:34 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b22ae985-26e6-4de7-0792-08d78eac33f2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2533:|DM5PR12MB2533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB253329F2279FC208AE7DEB9E83210@DM5PR12MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02698DF457
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(189003)(199004)(13464003)(8936002)(16526019)(186003)(81156014)(8676002)(66476007)(66946007)(2616005)(2906002)(66556008)(81166006)(478600001)(53546011)(6486002)(52116002)(31686004)(31696002)(110136005)(86362001)(316002)(5660300002)(6666004)(36756003)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2533;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHWjN2yDlAM15t2iqx6lTCk8i9e4b2Ov0QFc57TdCq27cPRp3FcWhdFJS1koc3si6lXIvQ/VgJwIXYsqocvJQ8JrUT87TUzLM4sf8vtvULncNkARuHa6NDBzwS0FmiRrMVHGEeewuNLLuwPSD7haMr2CqYgw6/1qLVRZ8ngSPrggBleNvMCGFsDP0Xc9PPcdovSYL7oYbl9mHPcXf3LyeJoPDZ1PS01l5bqmO3hqkpjGVghMf2z6OKpRGk7VGxc6Ky/deIoTe0uke+hhUX7hVlSq2gDJnbqRgS8wHqB4AMttF/OOpyfQrR8aj/4Gzo6SW25y/5kbjbZVk96Qh8Bjws7niG1XsMyuOtQ0cmtVAZAh1zPeYMkXiZjGt52tSP25hhQAdMbIabALqSOwIealLDfeTYE6Wo7C+P2YefPZ2gAZ5IARo+UPu9Vk7aE/5wKFniEh8nakpbKqmmfHs/tD5dEcq+EUvg+b5+rqBrfa9uKFzXkJJ9SuTABiQTAwtSzZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22ae985-26e6-4de7-0792-08d78eac33f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2020 11:17:35.6052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKv8veka1IIoVnOrR5J9LQ662jzTWRgOTBdrLhTKtcFqR9vbqoWWcIWU+GuzYrg+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2533
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

SGkgRXZhbiwKCj4gQnV0IHN0aWxsIHdoYXQgSSBjYXJlIG1vcmUod2hpY2ggaXMgYWxzbyB0aGUg
ZWFzaWVzdCB3YXkgdG8gbWUpIGlzIHRoZSBjb3JyZWN0IHJldHVybiB2YWx1ZSBvZiB0aGUgQVBJ
LgpXZWxsIGV4YWN0bHkgdGhhdCdzIHRoZSBwb2ludCB0aGVyIHJldHVybiB2YWx1ZSBpcyBub3Qg
Y29ycmVjdCBmb3IgdGhlIEFQSS4KCkZvciBleGFtcGxlIHdoZW4gdGhlIEdQVSByZXNldCBmdW5j
dGlvbiB3b3VsZCByZXR1cm4gLUVGQVVMVCB5b3VyIApwcm9ncmFtIHdoaWNoIHJlYWRzIHRoZSBk
ZWJ1Z2ZzIGZpbGUgd291bGQgY3Jhc2ggd2l0aCBhIHNlZ21lbnRhdGlvbiAKZmF1bHQuIFRoYXQg
aXMgbm90IGNvcnJlY3QgYmVoYXZpb3IuCgpJbiBvdGhlciB3b3JkcyB0aGUgcmVzdWx0IG9mIHRo
ZSBHUFUgcmVzZXQgY2FuJ3QgYmUgdXNlZCBhcyByZXN1bHQgb2YgCnRoZSBkZWJ1Z2ZzIHJlYWQu
CgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAxOS4xMi4xOSB1bSAwMjo0OCBzY2hyaWViIFF1YW4s
IEV2YW46Cj4gSGkgQ2hyaXN0aWFuLAo+Cj4gSGVyZSBpcyBzb21lIGJhY2tncm91bmQgZm9yIHRo
aXMgY2hhbmdlOgo+IEknbSBkZWJ1Z2dpbmcgYSByYW5kb20gZmFpbHVyZSBpc3N1ZSBvbiBiYWNv
IHJlc2V0Lgo+IEkgdXNlZCBhIHdoaWxlIGxvb3AgdG8gcnVuIHRoZSBjb250aW51b3VzIGJhY28g
cmVzZXQgdGVzdHMgYW5kIGhvcGUgaXQgY2FuIGV4aXQgaW1tZWRpYXRlbHkgb24gZmFpbHVyZSBv
Y2N1cnJlZC4KPiBIb3dldmVyLCBkdWUgdG8gd3JvbmcgcmV0dXJuIHZhbHVlLCBpdCBkaWQgbm90
LiBBbmQgYXMgeW91IGNhbiBpbWFnZSwgdGhlIGZhaWx1cmUgc2NlbmUgd2FzIHJ1aW5lZC4KPgo+
IEkgY2FuIGFkZCB0aGlzICJzZXFfcHJpbnRmKG0sICJncHUgcmVjb3ZlciAlZFxuIiwgcik7Ii4K
PiBCdXQgc3RpbGwgd2hhdCBJIGNhcmUgbW9yZSh3aGljaCBpcyBhbHNvIHRoZSBlYXNpZXN0IHdh
eSB0byBtZSkgaXMgdGhlIGNvcnJlY3QgcmV0dXJuIHZhbHVlIG9mIHRoZSBBUEkuCj4KPiBSZWdh
cmRzLAo+IEV2YW4KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+Cj4+IFNlbnQ6IFdl
ZG5lc2RheSwgRGVjZW1iZXIgMTgsIDIwMTkgNTo1NyBQTQo+PiBUbzogUXVhbiwgRXZhbiA8RXZh
bi5RdWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBjb3JyZWN0bHkgcmVwb3J0IGdwdSByZWNvdmVyIHN0
YXR1cwo+Pgo+PiBBbSAxOC4xMi4xOSB1bSAwNDoyNSBzY2hyaWViIEV2YW4gUXVhbjoKPj4+IEtu
b3dpbmcgd2hldGhlciBncHUgcmVjb3Zlcnkgd2FzIHBlcmZvcm1lZCBzdWNjZXNzZnVsbHkgb3Ig
bm90IGlzCj4+PiBpbXBvcnRhbnQgZm9yIG91ciBCQUNPIGRldmVsb3BtZW50Lgo+Pj4KPj4+IENo
YW5nZS1JZDogSTBlM2NhNGRjYjY1YTA1M2ViMjZiYzU1YWQ3NDMxZTRhNDJlMTYwZGUKPj4+IFNp
Z25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Cj4+PiAtLS0KPj4+ICAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgNCArLS0tCj4+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCj4+Pgo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+PiBpbmRleCBl
OWVmZWUwNGNhMjMuLjVkZmY1YzBkZDg4MiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+Pj4gQEAgLTc0Myw5ICs3NDMsNyBAQCBzdGF0aWMgaW50
IGFtZGdwdV9kZWJ1Z2ZzX2dwdV9yZWNvdmVyKHN0cnVjdAo+PiBzZXFfZmlsZSAqbSwgdm9pZCAq
ZGF0YSkKPj4+ICAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZh
dGU7Cj4+Pgo+Pj4gICAgCXNlcV9wcmludGYobSwgImdwdSByZWNvdmVyXG4iKTsKPj4+IC0JYW1k
Z3B1X2RldmljZV9ncHVfcmVjb3ZlcihhZGV2LCBOVUxMKTsKPj4+IC0KPj4+IC0JcmV0dXJuIDA7
Cj4+PiArCXJldHVybiBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKGFkZXYsIE5VTEwpOwo+PiBO
QUssIHdoYXQgd2UgY291bGQgZG8gaGVyZSBpcyB0aGUgZm9sbG93aW5nOgo+Pgo+PiByID0gYW1k
Z3B1X2RldmljZV9ncHVfcmVjb3ZlciguLi4uKTsKPj4gc2VxX3ByaW50ZihtLCAiZ3B1IHJlY292
ZXIgJWRcbiIsIHIpOwo+Pgo+PiBCdXQgcmV0dXJuaW5nIHRoZSBlcnJvciBjb2RlIGZyb20gdGhl
IEdQVSByZWNvdmVyeSB0byB1c2Vyc3BhY2UgZG9lc24ndCBtYWtlCj4+IHRvIG11Y2ggc2Vuc2Uu
Cj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+ICAgIH0KPj4+Cj4+PiAgICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGRybV9pbmZvX2xpc3QgYW1kZ3B1X2RlYnVnZnNfZmVuY2VfbGlzdFtdID0gewoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
