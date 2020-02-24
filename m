Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB70C11D30
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 14:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BF420828
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b0/BedF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BF420828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44DA89E7C;
	Mon, 24 Feb 2020 14:41:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B95089D87
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 14:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCCicVYCYvfG90cYvEKKw+RYi13WqErO5sAEqsjbzlDwSz4BoNypPgnk/iju6NJ6OtnAHXhc2sSE0n/j+ElMu59cLNs2GVyS1s/8w49E4ve7/MweSf6bVEYdw8OmsvfwW6C25Q3/w9Y2KERBUgNxGKt1dO+Mi0T4gZ6v+C1Nzw6AMglMxt4DyTPAgPUB6e1LkZnkVM4pJD1D8lfrY0XvDCtoM9OHlqI4O1W0TjTz4arUt7LLr0as3TWOW5LDBntMLW2yjp1JATLQf6VAgjbSPcAyHKLUdSgLhwevew4i+c70r8wd0PexoA/kwIG/ovbcAfN7AZFLp/8iH/D7yl3eOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9wrgoYO/UpRF/SoSwoSxFhgVjq1HCdGX7JB0icz8BU=;
 b=TRErKA2Q9bF+OGbKLeGBPupvaesiCaaz5sj/+lw+PcpZyyM6BOsFfvrLGersE2y8Prh4JpDbS3eolTIm1Vk/8iM/dbBMq3kJEonBP9k0rVvEq44GgdIYdMXMXxPo4otXy4S2CC5IBr9j8rIdCuQV4ObHBzKIU8gie0pTGAKUEuacvbRkaR305ymWt+96PMFNpPuhaoh4rLKT2dqFX0Q9CuTCiEI9PxaoajJJSlLzlsQa/GyYsu+x2JkUoYM00hIM0r4nLX8BGxasRFHW5R3EcywZWGhjfGZBQsDYCxgmt85P0iaM5YA3kP1WxiIdcIw92gEC1mKwfgV69U2EqVY3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9wrgoYO/UpRF/SoSwoSxFhgVjq1HCdGX7JB0icz8BU=;
 b=b0/BedF2Koz52I7g3Eeff1yFO+s9Uu4CBpJZEzzx1DtuLYSEEXCpTiJR4dFKMRcmsrLty4WLV1+LKqTkD0yVU8W7G3ssZhEA6EHRCZOa79PiykB8Ig9PExWwB5Xbvkausc8pb/120nCBdblK3MbFiDeV1oiR6zOhE9OL48WFXC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 by MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 14:41:19 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 14:41:19 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Add gfxoff debugfs entry
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200221184510.636829-1-tom.stdenis@amd.com>
 <CADnq5_Oi2w=Wy3m7e9v1wXd003Rbe2RYmwWSD3DOHz8Okbeyew@mail.gmail.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <0e1a2283-7345-a1f4-f5df-76938e7cebbd@amd.com>
Date: Mon, 24 Feb 2020 09:41:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CADnq5_Oi2w=Wy3m7e9v1wXd003Rbe2RYmwWSD3DOHz8Okbeyew@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN7PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:408:20::32) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN7PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:20::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 14:41:17 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8f942aa-a1e8-42f5-c9ea-08d7b9379bbd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3437:
X-Microsoft-Antispam-PRVS: <MN2PR12MB343729DBD50F8F1F83BAFDECF7EC0@MN2PR12MB3437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(2616005)(956004)(16526019)(26005)(186003)(66556008)(66476007)(66946007)(52116002)(6512007)(6506007)(8936002)(8676002)(81166006)(81156014)(53546011)(31686004)(4326008)(6486002)(6916009)(316002)(5660300002)(36756003)(2906002)(31696002)(86362001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3437;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epZEHApk7XfBppmaZpfaupupL7tnbPRxGRhEimPNvY0LKiQva5K9FFxSBk+Bk0ry84v50NcxVntlwBSHG4N4IxAanZX+oBECk61VNRPkH1wrKedE928bJBcFF7ZtKHz5TPWMrmv5K2/Nkn5ZAqhmA6gvnutYJUtQxlffjcPCaZEB2fSUJjhQkNJCA50bAyeGDUtBWNjSQZm1BOriBIh0qkXLlXT3PLuIEI69V3ksO36BWKq1WhJ0R5hmJToL5/Pp6FrJXJ9gwQo212x0i2w9Oo6a18W82UA6fxWUFp+stbUJNlADpu6NvgJ4TT87+APdEpGpp6wWSx/QaA9BXsifcXT8ETdr36Qr37tR8pcd92KX1fOEwCHVLJzRqnRfB31BfLBA+bggsd4TlNnvBrGDaTra+vOtyZB0BfUE2EnYQ49mzhznRENvZzuRCFVcusKA
X-MS-Exchange-AntiSpam-MessageData: I+pQjzg1JcWX9BDNi9CCTd4jhnFYr6/O6k6pgZ6hWNdYhcgHPN9ncDpNe15pub2KCmmPHHzy5MMVFSRDI0y0U5/8E6OVOnPDgK13ikpUzv5OhW3I8CQBO6CPF5gu11ZFqHXoNmoGf4h1Pj7+CZ2L9w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f942aa-a1e8-42f5-c9ea-08d7b9379bbd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 14:41:18.8118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANBsM9RFP4Nq3+CJWRNETF65bO67XSjJ7CV+iUhJXK4hzeEmYUGxAxFLHWt0jt28OvtEX5152DCBio+k5yURjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3437
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDItMjEgMTo1OSBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT24gRnJpLCBG
ZWIgMjEsIDIwMjAgYXQgMTo0NSBQTSBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+
IHdyb3RlOgo+PiBXcml0ZSBhIDMyLWJpdCB2YWx1ZSBvZiB6ZXJvIHRvIGRpc2FibGUgR0ZYT0ZG
IGFuZCB3cml0ZSBhIDMyLWJpdAo+PiB2YWx1ZSBvZiBub24temVybyB0byBlbmFibGUgR0ZYT0ZG
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+
Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMg
fCA1NiArKysrKysrKysrKysrKysrKysrKysKPj4gICAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0
aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmMKPj4gaW5kZXggNzM3OTkxMDc5MGM5Li4zYmI3NDA1NmI5ZDIgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+PiBAQCAtODQyLDYgKzg0Miw1
NSBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdmc19ncHJfcmVhZChzdHJ1Y3QgZmlsZSAq
ZiwgY2hhciBfX3VzZXIgKmJ1ZiwKPj4gICAgICAgICAgcmV0dXJuIHJlc3VsdDsKPj4gICB9Cj4+
Cj4+ICsvKioKPj4gKyAqIGFtZGdwdV9kZWJ1Z2ZzX3JlZ3NfZ2Z4b2ZmX3dyaXRlIC0gRW5hYmxl
L2Rpc2FibGUgR0ZYT0ZGCj4+ICsgKgo+PiArICogQGY6IG9wZW4gZmlsZSBoYW5kbGUKPj4gKyAq
IEBidWY6IFVzZXIgYnVmZmVyIHRvIHdyaXRlIGRhdGEgZnJvbQo+PiArICogQHNpemU6IE51bWJl
ciBvZiBieXRlcyB0byB3cml0ZQo+PiArICogQHBvczogIE9mZnNldCB0byBzZWVrIHRvCj4+ICsg
Kgo+PiArICogV3JpdGUgYSAzMi1iaXQgemVybyB0byBkaXNhYmxlIG9yIGEgMzItYml0IG5vbi16
ZXJvIHRvIGVuYWJsZQo+PiArICovCj4+ICtzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdmc19n
ZnhvZmZfd3JpdGUoc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191c2VyICpidWYsCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHNpemUsIGxvZmZf
dCAqcG9zKQo+PiArewo+PiArICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZmls
ZV9pbm9kZShmKS0+aV9wcml2YXRlOwo+PiArICAgICAgIHNzaXplX3QgcmVzdWx0ID0gMDsKPj4g
KyAgICAgICBpbnQgcjsKPj4gKwo+PiArICAgICAgIGlmIChzaXplICYgMHgzIHx8ICpwb3MgJiAw
eDMpCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4gKwo+PiArICAgICAgIHIg
PSBwbV9ydW50aW1lX2dldF9zeW5jKGFkZXYtPmRkZXYtPmRldik7Cj4gTm90IHJlYWxseSBkaXJl
Y3RseSByZWxhdGVkIHRvIHRoaXMgcGF0Y2gsIGJ1dCBJZiB5b3UgYXJlIHVzaW5nIHVtcgo+IGZv
ciBkZWJ1Z2dpbmcsIHdlIHNob3VsZCBwcm9iYWJseSBkaXNhYmxlIHJ1bnRpbWUgcG0sIG90aGVy
d2lzZSB0aGUKPiBlbnRpcmUgR1BVIG1heSBiZSBwb3dlcmVkIGRvd24gYmV0d2VlbiBhY2Nlc3Nl
cy4gIFRoZXJlIGlzIGFscmVhZHkgYW4KPiBpbnRlcmZhY2UgdG8gZG8gdGhhdCB2aWEgdGhlIGNv
cmUga2VybmVsIHBvd2VyIHN1YnN5c3RlbSBpbiBzeXNmcy4KPiBFLmcuLAo+IC9zeXMvY2xhc3Mv
ZHJtL2NhcmQwL2RldmljZS9wb3dlci9jb250cm9sCj4gL3N5cy9jbGFzcy9kcm0vY2FyZDAvZGV2
aWNlL3Bvd2VyL3J1bnRpbWVfc3RhdHVzCj4gU29tZXRoaW5nIGVsc2UgdG8gbG9vayBhdCBmb3Ig
dW1yLgoKV2UgcmFuIGludG8gc29tZXRoaW5nIHJlbGF0ZWQgdG8gdGhpcyBmb3IgVVZEL1ZDRSBh
Y2Nlc3MgYmFjayBpbiB0aGUgCmRheS7CoCBXaGVuIHBvd2VyZWQgZG93biB0aGUgTU1JTyByZWdp
c3RlcnMgYXJlIG1pcnJvcmVkIGFuZCBhY2Nlc3NpYmxlIApidXQgd2hpbGUgaW4gdHJhbnNpdGlv
biB0aGV5IGFyZSBub3QuwqAgU28gd2UgYWRkZWQgYSBQRyBmbGFnIHRvIHRoZSAKb2Zmc2V0IGlu
IHRoZSBkZWJ1Z2ZzIGVudHJ5IHRvIGZsYWcgd2hlbiB3ZSBuZWVkIHRvIHRha2UgdGhlIHBtIG11
dGV4IG9yIApub3QuCgoKCgo+Cj4gV2UgZG9uJ3Qgc3RvcmUgdGhlIHN0YXRlIGZvciB3aGVuIHdl
IGR5bmFtaWNhbGx5IHR1cm4gaXQgb2ZmIGxpa2UgdGhpcwo+IHNvIGlmIHdlIGdldCBhIEdQVSBy
ZXNldCBvciBhIHBvd2VyIG1hbmFnZW1lbnQgZXZlbnQgKHJ1bnRpbWUgcG0gb3IKPiBTMyksIEdG
WE9GRiB3aWxsIGJlIHJlLWVuYWJsZWQgYXQgdGhhdCBwb2ludC4gIFRoaXMgaXMganVzdCBmb3IK
PiBkZWJ1Z2dpbmcgdGhvdWdoIHNvOgo+IEFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+CgpHb29kIHRvIG5vdGUuwqAgQ2FuIEkgZ2V0IGEgUi1iIGZyb20g
c29tZW9uZSB0aG91Z2ggc28gSSBjYW4gcHVzaCB0aGlzIG91dD8KCgpUb20KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
