Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27EC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 15:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0F222201
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sGIsqxEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0F222201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A106EAA6;
	Wed, 14 Oct 2020 15:11:06 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700060.outbound.protection.outlook.com [40.107.70.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24FC6EAA6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 15:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLq7BTzM75Zv8soI7BD90JGLfRlWET6hTTKxXMLCKj0pu+l8Esmddd+c3nEsSMIHFI8/uNSTnPde5Ds/vPGzz23V7ivyiHTNdDyFQ5klRkJM4iRNuqmSFjL9p9XyxAUBJ/qkir5/uCLAA90c8oW36u3FLreaHEnvlkkMN4r27PR1J9VRC1JXqbNLTReUqkQESEJqL+TKpWr4fLKHR2jNQyQ1v00IUqxsVLUyiWVo80JvxNjhyW1/hJXE3SJxUZOIoA6YbvKin/rgfl6nIK/eKY+aeUL2gHRG5S2dnB+bZaDf3UvD3l4V6/7dUy/NEtWlEgt7gn5YXYGuhzoGbjWiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKQv6OhBaopO0kOYabEda2Qt38UXbpA6LDTjjkeCNn0=;
 b=SNuTDB6yOrq+lzYORSGeVFnU/Km+Oac/NP1TWn+BwWY40rbzuRVldXgZ2xDBo7OCW2ur9it0SIc2A683EUiyQgbaR1heVcH8ulSwdszJolDxzRRqviFJkwNoxLo0PwPwShKvf2q0UHbCGhMtz58NBKrLVBnXAYzn1lInm/GoHWt+kXsehWRrmKIcKh9QCsOAcN69un+EMqiNwnx1xjO/BHyy8GKc9NXgTEPY4S9ilzTqokDfOWYLDV7ADyicGZNqV7M7MZyuv35pKJmUFgM07EOi9hbgfcCBX8CNozzPmicjuLHwB7waXX8n+UflBOsfBFZdnnsoqVT625iTQLpDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKQv6OhBaopO0kOYabEda2Qt38UXbpA6LDTjjkeCNn0=;
 b=sGIsqxEojdhmz5eDeUbtCMQvecCGaRRCelfdHCq9kqm4Efd3/N5lBJreZNNojZYb4NCCJALMbylWneu0qPNdHApJ3HcRTKLPKSt8FcOnLur/LF+myqcGaw+p2K7AX/kcp5OO0Tp/EePj+8QvnyGq2el7aPJrL1R/E7Si5UupTHQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 15:11:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 15:11:03 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: increase the reserved VM size to 2MB
To: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201013170820.1548-1-christian.koenig@amd.com>
 <BL0PR12MB24337593D8FB1AA27A5E1AB89C050@BL0PR12MB2433.namprd12.prod.outlook.com>
 <6e57bfbc-fe17-7e1c-5f9e-b5bad7ffad17@gmail.com>
 <BL0PR12MB243361E0298DFFB3C70CD7969C050@BL0PR12MB2433.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3be32df6-4416-deb9-d770-c67a0b2da77b@amd.com>
Date: Wed, 14 Oct 2020 17:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BL0PR12MB243361E0298DFFB3C70CD7969C050@BL0PR12MB2433.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR07CA0002.eurprd07.prod.outlook.com (2603:10a6:208:ac::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 15:11:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5068291e-95ec-47ef-2b3f-08d870535daf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4239D3FD5037B2FFA4DBA5B983050@MN2PR12MB4239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0LjlsWlGCDUsYsj0DcXAMGsjl9VPyk0GATTYDpNHU5g/Fgnsk23LpbMtiqqZ5DyT2dnCSByBhlIahTB+vFGNXOpqWnNzLtE2caCK8Ww4faL1/r25ulUGeB2ZO+zchidBNbk3xFghJdr5jixXwuEJYgQjRe/Em/L7jYsf30U/gpcb4FhldaLFOiKa+SSRuikqXRXz3swrQl9RPjHanY4wbixsEUq5sCI7VINJEiQN80PIKJiV9+tfqhc4C0dJbUukNsj5y6cZ20x2AY7txI/nn7pR0dPSs1WLVi8tTvb4YnaMaceA9BbZda4sjGcuFis8blgMvcObQmObjvxm6v3OVz8VkcN5xZhx8dG7CIHKCcyRc2/1SXMZjETFsvMpucg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(8936002)(16526019)(83380400001)(31696002)(86362001)(2906002)(66574015)(186003)(110136005)(6486002)(316002)(4326008)(478600001)(53546011)(31686004)(6666004)(5660300002)(66946007)(36756003)(66556008)(8676002)(66476007)(52116002)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: drTEOMeR8oRAOxQD3mBo04UsT3RJSD9bWb0mN7r93iigOpFJopA6CQ3BvzkQTyEeIXiodT/loaEiCE1gF56FroeSMHTmIsAKvJAmVXahGPUF8T1zdEPUyzgk8lFX9gEKzhL3xVGrkZ1W+2XlnJ1s12E9I7NdSSXfwsGDc7Bha8uwbc6PwG0P4jzdz1H/7H01zYgJ3NIvgZL4cyYrgPPuBzT420qf7VLg+HXL3zk5L9tqxSnxUO4qZWL+nZyLmpJkusdu/5LqvXplvlm1kUR3HzsqJRQTDpwT6SlIsdCju0viE1Tl01OVoe2vz4cbbO2sgYDpB/0u+QgBb6slf2s5iaokC/E5NVhuArqfeEHTYODFB18Oqf11H4GCr4sKm7c3v2x/8hS/vp+Ce75rQLeycQmQiGxr3ZTxTkdnVVDRLmfIKiRyRkOLj3xf6JstLS+SNXEhslY7f43YsF8jmC2Kmd9802BU8H8QJ7yis7QXwqjcF7OqqK+uBUU/V/AtGXG/B61o2GI/SDPwvpGzBpA531BSDeu4NzcgQ4+kt+ue7ieq1BfsvJ7wqWj3YeQwuwRRs42qoZKnkS5BwGnAlsTr62n0OyG4TfFC9rliJmDB4N8DGjZk0CMJ1PLdyUsmHAehWtV59efMatKjc1HFJWIzz4evHLp0ZWIwRtbYY6RGCvzm4T3yAZX0qTfWQaxrAhuNVmUcTsJPhIoiupu7gzOLjg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5068291e-95ec-47ef-2b3f-08d870535daf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 15:11:03.3340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mSvkpedfkGX5bB3MnOT1026DC8Pnun04lzhQAdFE24abM51ZgoU2RrBA9xRVliT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMTAuMjAgdW0gMTc6MDYgc2NocmllYiBDaGF1aGFuLCBNYWRoYXY6Cj4gW0FNRCBQdWJs
aWMgVXNlXQo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBDaHJpc3RpYW4g
S8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4KPiBTZW50OiBXZWRuZXNk
YXksIE9jdG9iZXIgMTQsIDIwMjAgMjowNiBQTQo+IFRvOiBDaGF1aGFuLCBNYWRoYXYgPE1hZGhh
di5DaGF1aGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBQ
YW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBkcm0vYW1kZ3B1OiBpbmNyZWFzZSB0aGUgcmVzZXJ2ZWQgVk0gc2l6ZSB0byAyTUIKPgo+IEFt
IDE0LjEwLjIwIHVtIDEwOjI2IHNjaHJpZWIgQ2hhdWhhbiwgTWFkaGF2Ogo+PiBbQU1EIFB1Ymxp
YyBVc2VdCj4+Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IENocmlzdGlh
biBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPgo+PiBTZW50OiBUdWVz
ZGF5LCBPY3RvYmVyIDEzLCAyMDIwIDEwOjM4IFBNCj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+PiBDYzogQ2hhdWhhbiwgTWFkaGF2IDxNYWRoYXYuQ2hhdWhhbkBhbWQuY29t
PjsgUGFuLCBYaW5odWkKPj4gPFhpbmh1aS5QYW5AYW1kLmNvbT4KPj4gU3ViamVjdDogW1BBVENI
IDEvMl0gZHJtL2FtZGdwdTogaW5jcmVhc2UgdGhlIHJlc2VydmVkIFZNIHNpemUgdG8gMk1CCj4+
Cj4+IElkZWFsbHkgdGhpcyBzaG91bGQgYmUgYSBtdWx0aXBsZSBvZiB0aGUgVk0gYmxvY2sgc2l6
ZS4KPj4gMk1CIHNob3VsZCBhdCBsZWFzdCBmaXQgZm9yIFZlZ2EvTmF2aS4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiAt
LS0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggfCA0ICsrLS0K
Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPj4gaW5kZXggN2M0Njkz
N2MxYzBlLi44MWNjZDBhMGMzZGIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5oCj4+IEBAIC0xMTIsOCArMTEyLDggQEAgc3RydWN0IGFtZGdwdV9ib19saXN0X2Vu
dHJ5Owo+PiAgICAjZGVmaW5lIEFNREdQVV9NTUhVQl8wCQkJCTEKPj4gICAgI2RlZmluZSBBTURH
UFVfTU1IVUJfMQkJCQkyCj4+ICAgIAo+PiAtLyogaGFyZGNvZGUgdGhhdCBsaW1pdCBmb3Igbm93
ICovCj4+IC0jZGVmaW5lIEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFCQkJKDFVTEwgPDwgMjApCj4+
ICsvKiBSZXNlcnZlIDJNQiBhdCB0b3AvYm90dG9tIG9mIGFkZHJlc3Mgc3BhY2UgZm9yIGtlcm5l
bCB1c2UgKi8KPj4gKyNkZWZpbmUgQU1ER1BVX1ZBX1JFU0VSVkVEX1NJWkUJCQkoMlVMTCA8PCAy
MCkKPj4KPj4gTG9va3MgZmluZSB0byBtZTogUmV2aWV3ZWQtYnk6IE1hZGhhdiBDaGF1aGFuIDxt
YWRoYXYuY2hhdWhhbkBhbWQuY29tPgo+PiBDbGFyaWZpY2F0aW9uIG9uIGNvbW1lbnQ6Cj4+IFdl
IGNoZWNrIHZhX2FkZHJlc3MgPCBBTURHUFVfVkFfUkVTRVJWRURfU0laRSBmb3IgaW52YWxpZCBy
ZXNlcnZhdGlvbnMsIHNob3VsZG7igJl0IHRoaXMgYmUgImJvdHRvbSJpbnN0ZWFkIG9mICJ0b3Av
Ym90dG9tIiBvZiBhZGRyZXNzIHNwYWNlPz8KPiBJbiBhbWRncHVfaW5mb19pb2N0bCgpIHdlIHJl
cG9ydCBBTURHUFVfVkFfUkVTRVJWRURfU0laRSBhcyBzdGFydCBvZiB0aGUgdXNhYmxlIGFkZHJl
c3Mgc3BhY2UgYW5kIHZtX3NpemUgLSBBTURHUFVfVkFfUkVTRVJWRURfU0laRSBhcyBlbmQuCj4K
PiBDb3VsZCBiZSB0aGF0IHdlIGRvbid0IGNoZWNrIGlmIHRoZSBhZGRyZXNzIGluIHRoZSByZXNl
cnZlZCBob2xlIGF0IHRoZSBlbmQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UuIFRoYXQgd291bGQgYmUg
YSBidWcgYW5kIHNob3VsZCBwcm9iYWJseSBiZSBmaXhlZC4KPgo+IFRoYW5rcy4gSW5zaWRlIGFt
ZGdwdV9nZW1fdmFfaW9jdGwsIFNob3VsZG7igJl0IHdlIGFsc28gdmFsaWRhdGUgYWRkcmVzc2Vz
IGJpZ2dlciB0aGFuIEFNREdQVV9HTUNfSE9MRV9FTkQ/Pwo+IEN1cnJlbnRseSB3ZSBhbGxvdyB0
aGVtIGFuZCBqdXN0IHJlbW92ZSBsYXN0IDE2IGJpdHMuIFdoYXQgd2lsbCBoYXBwZW4gaWYgVXNl
ciBwYXNzZWQgMHggZmZmZiBmZmZmIGZmZmYgZmZmZiwgaXQgd2lsbCBiZSB0cmVhdGVkIGFzIDB4
IGZmZmYgZmZmZiBmZmZmCj4gV2hpbGUgYWRkcmVzcyBzcGFjZSBlbmQgaXMgMHggZmZmZiBmZmZm
IDAwMDA/PwoKVGhlIGFsaWdubWVudCBvZiB0aGUgbG93ZXIgYml0cyB3aWxsIHdlIGNoZWNrZWQg
aW4gYW1kZ3B1X3ZtX2JvX21hcCgpIAphbmQgYW1kZ3B1X3ZtX2JvX3JlcGxhY2VfbWFwKCkuCgpC
dXQgd2UgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCBub2JvZHkgbWFwcyBzb21ldGhpbmcgaW4gdGhl
IHJlc2VydmVkIDJNQiAKYXQgdGhlIHRvcCBhbmQgdGhhdCBpcyBjdXJyZW50bHkgaW5kZWVkIG1p
c3NpbmcuCgpHb2luZyB0byB3cml0ZSBhIHBhdGNoIGZvciB0aGF0LgoKQ2hyaXN0aWFuLgoKPgo+
IFJlZ2FyZHMsCj4gTWFkaGF2Cj4KPiBDaHJpc3RpYW4uCj4KPj4gUmVnYXJkcywKPj4gTWFkaGF2
Cj4+ICAgIAo+PiAgICAvKiBtYXggdm1pZHMgZGVkaWNhdGVkIGZvciBwcm9jZXNzICovCj4+ICAg
ICNkZWZpbmUgQU1ER1BVX1ZNX01BWF9SRVNFUlZFRF9WTUlECTEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
