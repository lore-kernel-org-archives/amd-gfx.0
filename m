Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6EC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403592082E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mrJHsMns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403592082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F256FA39;
	Thu, 30 Jan 2020 22:18:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A52F6FA39
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 22:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAyeBa9aFf4wnqpMAulBwm7z7JWxTwD14UPncEXhs8uMKtaVMd2HwskURiFKuL79+A8yPbo+towbhlS/Z/+O8L8c59YLCZ/umNmoxA/GcHop+wW7QTiIqp3pNmClSLvjdJ5Bb2MH1Y7lUOVd8UvV0Uo5FuXVOKfMjzs3XoTp4YKzRg1U5Xegko/FSpBogzop8DRrR6qOBGAIwBK4FTfoyKIaZZy5ZFEZQkCkgBrDAP3o4iGlHPKqyVzBby9s9dtMl8K+9SB6jDLo50QrK/gI13eLoYuTF3gUVzA7GgJ9QHPcV0gNRFyISu6EVdI45DMIHbbyydg1Q3Pmy2oxGGuD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzpYOQ2/Wu2omzL7x22Pxju6W0TBjxZ0Yd7MEh8cjlU=;
 b=astFTyA696TQIvZvtOBlTQbP8/3lq4SD8hyOguXtix+8YRJldR/vaHmldiKAyZrVNmPK47iQM7H0OSP6kbtiFn2W/DQxYnpUp15dekHLigJQ//uYXPdZgJiIHp8LYscyJk7k1Hr7QMIw10+29HW55T/xVGZn1TbjBG5GkQpfjY3QdXUzUXhcra8RoA7h2S42nsKF4OoAFIM3TQOFPPpGlVhSs7jwaaMUgBC4+TkmWVODgXV4meg0OmqEj9CnQUyUfHtO58S+KFG8QZie70CRQeRHYeKnsD2/qpfYNYTas2sp+Ww4R3aHl2r0xhr5eus+OlrNRe9UJZaoRyQjPwtbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzpYOQ2/Wu2omzL7x22Pxju6W0TBjxZ0Yd7MEh8cjlU=;
 b=mrJHsMnsbuJ1Bmzt94HxRkggnYyXxh6fWOobE/e2qrW7Xkx5405IgLd8r1tb5RDqLX7czPSuaJWVSpc7nUEiXzZI7Gj62RqbyTOhfWppO0qMsWGTFWbd9kkw0ppIjQgxt1DjBn/7L+ahCoLXZDq6uNugci3qQiHPliW2HH5DjV8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MWHPR1201MB0095.namprd12.prod.outlook.com (10.174.255.8) by
 MWHSPR00MB254.namprd12.prod.outlook.com (10.169.207.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 22:18:39 +0000
Received: from MWHPR1201MB0095.namprd12.prod.outlook.com
 ([fe80::ade9:4cf3:87ad:707]) by MWHPR1201MB0095.namprd12.prod.outlook.com
 ([fe80::ade9:4cf3:87ad:707%11]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 22:18:39 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu: return EINVAL instead of ENOENT in the VM
 code
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200130124940.30380-1-christian.koenig@amd.com>
 <20200130124940.30380-2-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <63be4274-1a41-f153-5942-86aa290881ad@amd.com>
Date: Thu, 30 Jan 2020 17:18:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200130124940.30380-2-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To MWHPR1201MB0095.namprd12.prod.outlook.com
 (2603:10b6:301:4e::8)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Thu, 30 Jan 2020 22:18:38 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78455fd0-369b-4cb5-3508-08d7a5d25b65
X-MS-TrafficTypeDiagnostic: MWHSPR00MB254:
X-Microsoft-Antispam-PRVS: <MWHSPR00MB254ABD9F98DC08C06E8F02792040@MWHSPR00MB254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(36756003)(16576012)(16526019)(186003)(316002)(81166006)(478600001)(2906002)(8676002)(8936002)(81156014)(52116002)(6486002)(31686004)(5660300002)(66574012)(53546011)(44832011)(956004)(26005)(66946007)(2616005)(66556008)(66476007)(31696002)(86362001)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHSPR00MB254;
 H:MWHPR1201MB0095.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xal5jBOEdJTiDsVxRvCeHd3Kf4eJNlcqAy8d3O5AO8NWzMlEeqGiClsy8V0be3tWt2CcMQZPWYM1V4+Jb6zK0C73UU+UozbsLX7QiYBoaPiCqKo2eip/lDrYlQOocTXPwSgBuHkQU7cYwmLCVd+xeakCQKisLBdwCoVO6jb0I8vYb/SI0rpgRS2ut3AF3E9Sxn27ao543x3hHwc7Xo7Q2gW5o39bOgei5Gj2nM2JfhymxEEH04Lb0GAfDpkPFffBRlp28t3Td5SOtLOAZOIshMmlQ9CI4zv6T2yhFM/nYLD/5ykVd3oBoy0+mU7vV/hqVqaOcIEON155KVoOrsmGSnj0PDzdJckKf6kpLOXhzmHJiz4sJ0j+/nw6kFWeyWNLTf6rtKznN9D4xdBLoOUhmlbuo6IHtyzHKE9gBuCgwNbC86H6zsCQcaKXgEYYKSpv
X-MS-Exchange-AntiSpam-MessageData: x7ZPKdPK2qcftzrm1LOKcV6mJPmvuTg7OBZk7o3Fy98x0tkv8w/GwKKjA8Czn/CKEF98ItGXpgKcmuZBLfAVIvobezW2as1UKiSUwpaYmZF/vnbGqbzRbjuzm9hekXE/mVJWhMeaVKzlCStFsr6EtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78455fd0-369b-4cb5-3508-08d7a5d25b65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 22:18:39.4267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g636T2gnGWf0y5KxnqBu8pdkD/Zo03LQjpHP9XzVAlE8DxzeP0rjmP6MOziKlVVMTbHfviVIDbAzmEqu13ZqkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR00MB254
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

T24gMjAyMC0wMS0zMCA3OjQ5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFRoYXQgd2UgY2Fu
J3QgZmluZCBhIFBEIGFib3ZlIHRoZSByb290IGlzIGV4cGVjdGVkIGNhbiBvbmx5IGhhcHBlbiBp
Zgo+IHdlIHRyeSB0byB1cGRhdGUgYSBsYXJnZXIgcmFuZ2UgdGhhbiBhY3R1YWxseSBtYW5hZ2Vk
IGJ5IHRoZSBWTS4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPiBUZXN0ZWQtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNA
YW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAy
ICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggNGJhNmE1ZTVkMDk0
Li45NzA1Yzk2MTQwNWIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+IEBAIC0xNDc1LDcgKzE0NzUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRl
cyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPiAgIAkJCSAqIHNoaWZ0
IHdlIHNob3VsZCBnbyB1cCBvbmUgbGV2ZWwgYW5kIGNoZWNrIGl0IGFnYWluLgo+ICAgCQkJICov
Cj4gICAJCQlpZiAoIWFtZGdwdV92bV9wdF9hbmNlc3RvcigmY3Vyc29yKSkKPiAtCQkJCXJldHVy
biAtRU5PRU5UOwo+ICsJCQkJcmV0dXJuIC1FSU5WQUw7Cj4gICAJCQljb250aW51ZTsKPiAgIAkJ
fQo+ICAgCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
