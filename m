Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8C6C00523
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 10:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D307206F0
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FgihQMmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D307206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6589F6E880;
	Wed,  8 Jan 2020 10:08:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DC16E880
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 10:08:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPry9x3Y+BG6rxaCGC7qz4B6SyhxcHaaYlzI1Wa5dTh9zONs/RFRTu/v11WNHlGEX03ukN/246TODZW0cPTz4SaBAFVzgZz8KnJSUhsAT2UB/y4MRIc3MhHfAFLcSwiZ42h+QY74+5rQp9iKs5V0BRvy1HG7mWqi8W5awxH9gV70QtvQKWm8Vi9H+aZV/t1+nqJT0I/JNJiAJdD1Ls86RtbFERt9sZfW7SAfjXbhPM3eh/fVocgOpjSWC19017ash4LRk+mHACCJhTwd40dG1fDrXZgWoCN6Tz2LOOo6LQLUO9Qgj3ZDacVz3zm0Ns2XWHG61jpDVNVnWlmdWoKNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duyukdzipPZ6o0QcqMCwtDcM/lUrO37J+ak4ipCYb6I=;
 b=e7F2X2B94K8/I3D1ZxBsoRu2LwzX8IR8mlyKbxUCUgXKl97iS+a8r1ZBC/DJj+DbWWgXCYfr+sXwfGZP3X8SnetJ6DLf2Qq/4iBTLxgLBuww2miolDl9e0+zpvhvY4yrqvR2pi8u76RMZCyrijjpZd4/lfSlo1lMDBsRCjuzUXJfeOWslvVXbhE3To+/Noyx0sQbEEBCLlJqanTYeEKfJ4xI+Dn8MDUFOXcEMXktJMAXj0OQVs+Qlo8h7ZmONK+cqN+32QTS3yZPlFGqRekEDIpJrXSn7VZW6GD5uvS2v/8+LUE6M4QGpZmMQzz/BAdQQUoDPxhoJrOO7Ixd0oFozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duyukdzipPZ6o0QcqMCwtDcM/lUrO37J+ak4ipCYb6I=;
 b=FgihQMmcat4dB/f49ShZnfl4eXET3Cda+RCOkl/AlPnUVgtDwN4K934Ul2G20NOF6qHZ6O1VBLZ4Wao5C/J6LQj7asMWJ18hk6jDFUiGIasqI7oy3otxhXRdP4Y7GQEImfYmlnVaynmRWjA+kc4gWM7F7kDXRa3kn+qJK6hZxu4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1737.namprd12.prod.outlook.com (10.175.89.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 10:08:41 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 10:08:41 +0000
Subject: Re: [PATCH] drm/amdgpu: catch amdgpu_irq_add_id failure
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200108094056.23776-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <89b43f57-589a-a9f6-d5ae-ca6afe855de7@amd.com>
Date: Wed, 8 Jan 2020 11:08:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200108094056.23776-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 10:08:39 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90e97d6f-d216-45ae-306c-08d79422bc5b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1737:|DM5PR12MB1737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1737BAEA93432006A98917DD833E0@DM5PR12MB1737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(16526019)(2906002)(186003)(8936002)(31686004)(8676002)(31696002)(81166006)(81156014)(86362001)(6486002)(52116002)(66556008)(36756003)(5660300002)(66946007)(316002)(2616005)(6666004)(4326008)(4744005)(478600001)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1737;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaKE6PqGLMJxecTvlsmvCjdL+wiOcdRTQWvxQs9419aqzKpPlX2V9SrkRvX1ippqsuXKTzy9VeQsY6+HJfDL/LvmeTg6Qr+j8aktqK+zzLYppqk3iZ3QgLtDR0G0Ue7v0oQYGh1lQplqLz4omvpr1E6vaTEkkASeS1ApFGLECDllJ937LmDRfUNGZ8Zh/sDlB09JhAG5nXcnNqTFsIChbZx33il9zGb1oajCnpwJ3eqPhmuRCdpARci+a92e+Iv7/AxSHDIKcm7iBRWEJR0vr8PBmW9BhRKQWj68YCDDvIf5ih5oVwVyHS0d5kIrbrNK1/DwkVzpmEklTUoOOV0enAo3AMUXo+II3HI0wW7vUEEsCx7l7XY//ZEIWH5ZcemwEU/bp8XoKOW4+f6gUOfN1w3SM1LsDuC65gwnFl1kiHaiEZ2/mqudCXUek8vHsMZX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e97d6f-d216-45ae-306c-08d79422bc5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 10:08:41.0234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqVzIYNW9xf2AnE0yg0X000UTt2wdFU6TCjuluwZSdp2//dGrIdXTdtkdycKjLuQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDEuMjAgdW0gMTA6NDAgc2NocmllYiBOaXJtb3kgRGFzOgo+IERvIG5vdCBpZ25vcmUg
YW1kZ3B1X2lycV9hZGRfaWQgcmV0dXJuIHZhbHVlIHdoaWxlIHJlZ2lzdGVyaW5nCj4gVk1DIHBh
Z2UgZmF1bHQgaW50ZXJydXB0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95
LmRhc0BhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEw
XzAuYyB8IDQgKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiBpbmRleCBkYTk3NjVmZjQ1ZDYuLjdk
YzhjMDY4YzYyYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djEwXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4g
QEAgLTcyMCw2ICs3MjAsMTAgQEAgc3RhdGljIGludCBnbWNfdjEwXzBfc3dfaW5pdCh2b2lkICpo
YW5kbGUpCj4gICAJciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYsIFNPQzE1X0lIX0NMSUVOVElE
X1ZNQywKPiAgIAkJCSAgICAgIFZNQ18xXzBfX1NSQ0lEX19WTV9GQVVMVCwKPiAgIAkJCSAgICAg
ICZhZGV2LT5nbWMudm1fZmF1bHQpOwo+ICsKPiArCWlmIChyKQo+ICsJCXJldHVybiByOwo+ICsK
PiAgIAlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfVVRDTDIs
Cj4gICAJCQkgICAgICBVVENMMl8xXzBfX1NSQ0lEX19GQVVMVCwKPiAgIAkJCSAgICAgICZhZGV2
LT5nbWMudm1fZmF1bHQpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
