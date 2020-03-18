Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DEBC4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 23:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851B320754
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 23:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k7jvwNKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851B320754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4070A6E995;
	Wed, 18 Mar 2020 23:26:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3CC56E995
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 23:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP4DaW9t35+ZFvmjUbHctNnKoH/5vCzjW8pOiG6lAssGiQursxorKXUaYy0Eq14Q/FBbuYtVQY0PJPVSR0bJ7r3VucH9pcbp3NpV1VICAAgi5/h0B/e7JcYQTLxpamCfMXox/5zxjE/fXTTHJUyqafluk3Wt6tA2MZb4Nz6e4JIOAeuGm0WezvpM9IcnFc0ROkj3xcoNecqsAUj9bFFiBhNMmjgtBgVnJhznZ3SjmDzTv4hGFYz/tsxM0QObIqtOPRu1bf+SCspxhKHG8pJwxU+oHZ9XGJAOkHb8l84Ptw13IbhWeyZvo1sxCvAbQr8vka+ilFWJ+Jwz8gGnn1w9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1hN6uUyMFCMi/Yg8Io4AEldt+fZqUw8jp89bC/eXFQ=;
 b=SuCGTWvEEz8HCIpKH349JnU3X9LqGCEHSEGj/0Sfc5Zx+IEhI1MvFiy/YKpmDYKgql30OJVVEaLl7jleqaLW5W2vFX28gj2SYsl9WcC+PJgqq96yNAHuT7XIl5Fp6AkBPC+5g/DO5zSL+lcZWXvXTbKI00uuwdzRLpOIg2+Dr/gWSmbdpzAqnCyjNv32v6m4DL5g8Qxnf2tKnaZEPy+Xr/KL4PHmrVY06ofFkDvA87Er++g6w3j+XiZSb80K3l0BgRxoGFq0AxJ7/X4qUl8dnCAQSg/x8TeDqRSCs1R4+qZAuAPVF9nFdQJGdpenqMCx89+XpXM8e1IEnLeDpmy5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1hN6uUyMFCMi/Yg8Io4AEldt+fZqUw8jp89bC/eXFQ=;
 b=k7jvwNKsXCZMIfvcnuArXOflyab5YQ9UusDpVMrPmviiGEQwZRoeM8EaRBS0Wfw7oiPwUaj5A+RajnHA+ofYiiuT8vOF979ibqH3Zhe1X3Zx8XCi0NQ7FZm18BFpXjr6uG/m5/sYXshRdd1OcVPYFalCpZ8hqQbYZh4Mqnfp92U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Wed, 18 Mar
 2020 23:26:52 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d%5]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 23:26:52 +0000
Subject: Re: [PATCH 6/8] drm/amdgpu: remove Arcturus references from vega10 ih
To: amd-gfx@lists.freedesktop.org,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
 <20200318225118.10756-6-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7f50de71-4d61-3f72-c229-1316b212db6d@amd.com>
Date: Wed, 18 Mar 2020 19:26:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200318225118.10756-6-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.147.80] (165.204.55.211) by
 YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Wed, 18 Mar 2020 23:26:51 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97a94d5b-97a9-41de-40c8-08d7cb93d69e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:|DM5PR1201MB2505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25056CF0BAA0EE98BDE514B092F70@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(199004)(2906002)(86362001)(31686004)(16576012)(316002)(31696002)(53546011)(37006003)(6636002)(8936002)(52116002)(81156014)(478600001)(8676002)(81166006)(36756003)(66476007)(956004)(66556008)(44832011)(66946007)(5660300002)(6486002)(6862004)(2616005)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2505;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BG7YCEvgfBRTXKRiKk/vuPcyIDPXfyTmrnx0Cc5P9p71NoJVZTmxpjdMHps9Bz1Kg1F4gdoVnVxTapvopl1qVisi0FssE5h7oQv0HKQrERG+8GlZP3G1W03QtUS3Gf6UHpNcis0JrETNRO1Uo2+gTinwp/U9A4ZjJdF6akypn3LSgjg0xvtDjQvrTt4b9EWGSbfwkv77Hby828BYycxUX1inN0/3lNcgouNnQTkfPn1Tp03MqdU2uH/c/EPaekyisGKkeM5LQSNiY0K50HSV/waRTgzvxToU+ry1aJt8pGrqQyNw9GZaiwA+DYSYBRCxlu0faY+5+rRl5q+EM11vQSrb6ng4ZbdYM3OjtOUlYPWJZZ1IZQlMQgl74TiiOcaDl+VG7gJ9ES/FuMCthBFSxrAcBNkTSwRT+YXxl1Yp9OPoTci4WmUPrVOJh3NY1lkS
X-MS-Exchange-AntiSpam-MessageData: 4vp3C/yMw9FnkNOOWgOWtzFDM142Xcv1q6fMw9TzkV8alJgpFCbvqpJ8wem55oCCj5itdcS/hllvm+PhJiopx7o5vDpIaEqxPGB0xBNGpXp4Pe8ipIMJ/tKGPrhP30grUqjgboBSg7PTmeqFwirwUA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a94d5b-97a9-41de-40c8-08d7cb93d69e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 23:26:52.0409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEuVDAvQcpipe5mBW2bsFogHHIZMwcjSdJ5LR/xSvz3QKyJciuxRhEXS1aaDRefCKsb5SG+ZapKthQYEo2EYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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

SSBiZWxpZXZlIHRoaXMgc2hvdWxkIGJlIHNxdWFzaGVkIGludG8gUGF0Y2ggIzggb3IgYXBwbGll
ZCBhZnRlciBwYXRjaCAKIzguIE90aGVyd2lzZSBpdCBjcmVhdGVzIGEgYnJva2VuIGludGVybWVk
aWF0ZSBzdGF0ZSB3aGVyZSBBcmN0dXJ1cyAKZG9lc24ndCBoYXZlIGFueSB2YWxpZCBJSCBzdXBw
b3J0LiBUaGF0IHNhaWQsIGl0J3MgcHJvYmFibHkgbGVzcyAKY3JpdGljYWwgYmVjYXVzZSBpdCBv
bmx5IGFmZmVjdHMgdGhlIGNhc2Ugb2YgZGlyZWN0IChiYWNrZG9vcikgZmlybXdhcmUgCmxvYWRp
bmcuCgpSZWdhcmRzLAogwqAgRmVsaXgKCk9uIDIwMjAtMDMtMTggMTg6NTEsIEFsZXggU2llcnJh
IHdyb3RlOgo+IEFyY3R1cnVzIGhhcyBpdHMgb3duIGloIGltcGxlbWVudGF0aW9uLiBUaGVyZSdz
IG5vIG5lZWQgdG8gc3VwcG9ydAo+IHRoaXMgb24gdmVnYTEwIGloIGFueW1vcmUuCj4KPiBDaGFu
Z2UtSWQ6IEkyOWM4NDNlMGIxMmE0NThkMjkxNTEyOTUwM2MwYWQ4NTJiY2ViYzQ4Cj4gU2lnbmVk
LW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyB8IDQgKy0tLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmVnYTEwX2loLmMKPiBpbmRleCA0MDdjNjA5M2MyZWMuLjYwOGU4ZGE5Yjk2MiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCj4gQEAgLTI0Niw5ICsy
NDYsNyBAQCBzdGF0aWMgaW50IHZlZ2ExMF9paF9pcnFfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIAkJV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMLCBpaF9y
Yl9jbnRsKTsKPiAgIAl9Cj4gICAKPiAtCWlmICgoYWRldi0+YXNpY190eXBlID09IENISVBfQVJD
VFVSVVMgJiYKPiAtCSAgICAgYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQVV9GV19M
T0FEX0RJUkVDVCkgfHwKPiAtCSAgICBhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SRU5PSVIpIHsK
PiArCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SRU5PSVIpIHsKPiAgIAkJaWhfY2hpY2tl
biA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ0hJQ0tFTik7Cj4gICAJCWlmIChhZGV2
LT5pcnEuaWgudXNlX2J1c19hZGRyKSB7Cj4gICAJCQlpaF9jaGlja2VuID0gUkVHX1NFVF9GSUVM
RChpaF9jaGlja2VuLCBJSF9DSElDS0VOLApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
