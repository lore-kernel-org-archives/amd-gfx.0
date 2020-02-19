Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5F5C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0231424654
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f68mN8tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0231424654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEEDF6E134;
	Wed, 19 Feb 2020 11:51:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578F46E134
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da0DnpQVqvE0rQuTamegiBq+SOX9z8Ko9BXSh9t9znq9LwqVxjS0Y8pG+4+8IHPEEMpsnwtw1tR/w8obU89jRTl8isMlipqYZDWOuOn+9qYRiOkqDDeZOQunfNE1g7eyyT0qPF78DMc2XwfSzI0nrzHA/L/+0eeZSebpGbIgSSbo9BJ7cGczvffgL19t7wtwOgORarGb7MBOoJcDzlrHXoWrREjGloKtYavSTAfWWVNUUc7LLDHRKt/62EGkc9vAA7Twb6vshQDj8NIQ0A5eJKlaYqIOYi737Lf+drdsZ0OJy+s35cpfRH6YTGbRaAnqK4UQafZfjoiETQtBVq6fYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcyDBsOmiFeClG/KFnRGzOoXWcqt0KIKrEEu6hOQzSU=;
 b=gcHSKrIQUTaa8oRDqXPs5C8eGCia599KGEqeYHXHEayWKKkbexyub9Y4wawShV1TumFT2h/H3IzWy50KdoSc/aitB0+ueVE/rmj0pJeq3Jdwj4z9mj6z9mZdxX2FssodIUZ5Rofqn0s4qKLSHmB/I2qOs5EUlt5+nsKfbbJANg06T025JCQxWWZ9VGRUAwtyEIw4gDWOqvNk270w4G7xvuqsU3zeoyD49g5GaFRjMuBrltkVI/JRmHAauMIsmCe9BoDHtpUoMm5A29XAXVmsyt3uoO+khmgT7O87OLIRZy1u6meosiMrjv2amBB1/kE8rDd3xg3+5V11gmIAfyNC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcyDBsOmiFeClG/KFnRGzOoXWcqt0KIKrEEu6hOQzSU=;
 b=f68mN8tk9mrBVZaWPICbU4eBtp1Tq1F1vbygvBbUckbCZrFplM8Jp89ou/FgYEOixiLM6BPEFE+3AmtF7GQsRuw1RTAhhnnsYI37E6/IARPNRBrfOuV6HyvHfik2ArkTx6kdzhEsGReyNjSbr6ibPz2ZQfvph6CExlHh+1MWoMs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from CH2PR12MB3927.namprd12.prod.outlook.com (52.132.246.141) by
 CH2PR12MB3862.namprd12.prod.outlook.com (52.132.231.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 11:51:08 +0000
Received: from CH2PR12MB3927.namprd12.prod.outlook.com
 ([fe80::54a8:8b32:7a8f:488c]) by CH2PR12MB3927.namprd12.prod.outlook.com
 ([fe80::54a8:8b32:7a8f:488c%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 11:51:07 +0000
Subject: Re: [PATCH umr] fix field names for INDIRECT_BUFFER_CONST/CIK for
 gfx9/gfx10
To: Xiaojie Yuan <xiaojie.yuan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200219112629.6154-1-xiaojie.yuan@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <15c10f68-2b50-b9c5-ad13-a80cea90ba89@amd.com>
Date: Wed, 19 Feb 2020 06:51:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200219112629.6154-1-xiaojie.yuan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::45) To CH2PR12MB3927.namprd12.prod.outlook.com
 (2603:10b6:610:2d::13)
MIME-Version: 1.0
Received: from localhost.localdomain (64.231.93.139) by
 YQBPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 11:51:07 +0000
X-Originating-IP: [64.231.93.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5645456e-51a0-4f81-7d4c-08d7b532019c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3862:|CH2PR12MB3862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB386247E611CEE363A94B520AF7100@CH2PR12MB3862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(8676002)(81156014)(26005)(52116002)(81166006)(36756003)(16526019)(186003)(86362001)(66556008)(53546011)(31696002)(6486002)(6506007)(6512007)(31686004)(66946007)(956004)(66476007)(498600001)(5660300002)(8936002)(2906002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3862;
 H:CH2PR12MB3927.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjHGKgBDc1gDzi3491pNM6apSqVGi1ptU8gwAi7IuxWCqbB0qy70nqRUI7TL02Xw9/aatgl5prwcYAkCQtVd9fW/mZtOScoJjFoBwmUluZkZaGywWlggC08IIsyPvkMGzQ+9J/1fiPRoV4UFqT4QEygCdWjwvK3dZbPuRJjPn+Ty/gr7e7uckqtLhuas13HPeAPThCxOC8pP/lh3iBOj9ESTPHV4FpvCpaGGwI7nh4BvSys0RTi9n06ruhHMVNljklA5Y9HAlZ/3gAe83LmDSp3swjLPiq8kb7+Eon+R935YiY+uREqzrnE+C6UlYaOIVEiTKO9E4ptD1iNdEFn6JTzHb7dRtoHRlGK6+C2BIyBXi/swwAceYa3U14JhX3mdYb2Sz4q0VsgM2rgbKHEeWHFMrwZxW3Ucfp2UpL5b401he7UmNbP/p6zBC+xW5V2k
X-MS-Exchange-AntiSpam-MessageData: vOhK3XJTd4ang89Rz4PBz3kaPSdYqz+Ur+vV9+STYPA1LXcGwyqA4fV7xT9NKwszb+7EgCM4HRIg8HeDfaC9GxyIEDA8zZO0+ogw8K7jNemVgUzPah8OyUYfEvkkVHkdGd08D4ymWwHUO5u5ndFCxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5645456e-51a0-4f81-7d4c-08d7b532019c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 11:51:07.9118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aP9PkLPx8gJnD8GH+6aDuaDZsmJ8PRJRIwSJkoHDbNhlUYRuYStIdsObqC3uJZfWIC2sNvr1tOylWyl5dZfkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3862
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

WXVwLCBteSBiYWQuwqAgV2UgYWxzbyBuZWVkIHRvIGZpeCB0aGUgc3RyZWFtaW5nIHZlcnNpb24g
KGxpbmUgNDMyIG9mIApzcmMvbGliL3Vtcl9wbTRfZGVjb2RlX29wY29kZXMuYykuwqAgV291bGQg
eW91IGxpa2UgdG8gaW5jb3Jwb3JhdGUgdGhpcyAKaW50byB0aGlzIHBhdGNoP8KgIE90aGVyd2lz
ZSBJIGNhbiBkbyBpdCBzZXBhcmF0ZWx5LgoKVGhhbmtzLAoKVG9tCgpPbiAyMDIwLTAyLTE5IDY6
MjYgYS5tLiwgWGlhb2ppZSBZdWFuIHdyb3RlOgo+IGZpZWxkIG5hbWVzIGZvciBJTkRJUkVDVF9C
VUZGRVJfQ09OU1QvQ0lLIG9mIGdmeDkvZ2Z4MTAgYXJlIHRoZSBzYW1lLgo+IGZpZWxkcyBsaWtl
IE9GRkxPQURfUE9MTElORyBhbmQgVkFMSUQgYXJlIGRlZmluZWQgaW4gbWVjJ3MKPiBJTkRJUkVD
VF9CVUZGRVIgcGFja2V0LCBzbyBub3QgYXBwbGljYWJsZSBoZXJlLgo+Cj4gU2lnbmVkLW9mZi1i
eTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KPiAtLS0KPiAgIHNyYy9saWIv
cmluZ19kZWNvZGUuYyB8IDIzICsrKysrKystLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9z
cmMvbGliL3JpbmdfZGVjb2RlLmMgYi9zcmMvbGliL3JpbmdfZGVjb2RlLmMKPiBpbmRleCAyNTBk
ZmQ3Li5mYTQ0ZjI3IDEwMDY0NAo+IC0tLSBhL3NyYy9saWIvcmluZ19kZWNvZGUuYwo+ICsrKyBi
L3NyYy9saWIvcmluZ19kZWNvZGUuYwo+IEBAIC02MTcsMjIgKzYxNywxMyBAQCBzdGF0aWMgdm9p
ZCBwcmludF9kZWNvZGVfcG00X3BrdDMoc3RydWN0IHVtcl9hc2ljICphc2ljLCBzdHJ1Y3QgdW1y
X3JpbmdfZGVjb2Rlcgo+ICAgCQkJCWNhc2UgMjogcHJpbnRmKCJJQl9TSVpFOiVzJWx1JXMsIFZN
SUQ6ICVzJWx1JXMiLCBCTFVFLCBCSVRTKGliLCAwLCAyMCksIFJTVCwgQkxVRSwgQklUUyhpYiwg
MjQsIDI4KSwgUlNUKTsKPiAgIAkJCQkJZGVjb2Rlci0+cG00Lm5leHRfaWJfc3RhdGUuaWJfc2l6
ZSA9IEJJVFMoaWIsIDAsIDIwKSAqIDQ7Cj4gICAJCQkJCWRlY29kZXItPnBtNC5uZXh0X2liX3N0
YXRlLmliX3ZtaWQgPSBkZWNvZGVyLT5uZXh0X2liX2luZm8udm1pZCA/IGRlY29kZXItPm5leHRf
aWJfaW5mby52bWlkIDogQklUUyhpYiwgMjQsIDI4KTsKPiAtCQkJCQlpZiAoZGVjb2Rlci0+cG00
LmN1cl9vcGNvZGUgPT0gMHgzMykgewo+IC0JCQkJCQlpZiAoYXNpYy0+ZmFtaWx5ID49IEZBTUlM
WV9OVikgewo+IC0JCQkJCQkJcHJpbnRmKCIsIENIQUlOOiAlcyV1JXMsIFBSRV9FTkE6ICVzJXUl
cywgQ0FDSEVfUE9MSUNZOiAlcyV1JXMsIFBSRV9SRVNVTUU6ICVzJXUlcyBQUklWOiAlcyV1JXMi
LAo+IC0JCQkJCQkJCSAgIEJMVUUsICh1bnNpZ25lZClCSVRTKGliLCAyMCwgMjEpLCBSU1QsCj4g
LQkJCQkJCQkJICAgQkxVRSwgKHVuc2lnbmVkKUJJVFMoaWIsIDIxLCAyMiksIFJTVCwKPiAtCQkJ
CQkJCQkgICBCTFVFLCAodW5zaWduZWQpQklUUyhpYiwgMjgsIDMwKSwgUlNULAo+IC0JCQkJCQkJ
CSAgIEJMVUUsICh1bnNpZ25lZClCSVRTKGliLCAzMCwgMzEpLCBSU1QsCj4gLQkJCQkJCQkJICAg
QkxVRSwgKHVuc2lnbmVkKUJJVFMoaWIsIDMxLCAzMiksIFJTVCk7Cj4gLQkJCQkJCX0gZWxzZSBp
ZiAoYXNpYy0+ZmFtaWx5ID49IEZBTUlMWV9BSSkgewo+IC0JCQkJCQkJcHJpbnRmKCIsIENIQUlO
OiAlcyV1JXMsIE9GRkxPQURfUE9MTElORzogJXMldSVzLCBWQUxJRDogJXMldSVzLCBDQUNIRV9Q
T0xJQ1k6ICVzJXUlcyBQUklWOiAlcyV1JXMiLAo+IC0JCQkJCQkJCSAgIEJMVUUsICh1bnNpZ25l
ZClCSVRTKGliLCAyMCwgMjEpLCBSU1QsCj4gLQkJCQkJCQkJICAgQkxVRSwgKHVuc2lnbmVkKUJJ
VFMoaWIsIDIxLCAyMiksIFJTVCwKPiAtCQkJCQkJCQkgICBCTFVFLCAodW5zaWduZWQpQklUUyhp
YiwgMjMsIDI0KSwgUlNULAo+IC0JCQkJCQkJCSAgIEJMVUUsICh1bnNpZ25lZClCSVRTKGliLCAy
OCwgMzApLCBSU1QsCj4gLQkJCQkJCQkJICAgQkxVRSwgKHVuc2lnbmVkKUJJVFMoaWIsIDMxLCAz
MiksIFJTVCk7Cj4gLQkJCQkJCX0KPiArCQkJCQlpZiAoYXNpYy0+ZmFtaWx5ID49IEZBTUlMWV9B
SSkgewo+ICsJCQkJCQlwcmludGYoIiwgQ0hBSU46ICVzJXUlcywgUFJFX0VOQTogJXMldSVzLCBD
QUNIRV9QT0xJQ1k6ICVzJXUlcywgUFJFX1JFU1VNRTogJXMldSVzIFBSSVY6ICVzJXUlcyIsCj4g
KwkJCQkJCQkgICBCTFVFLCAodW5zaWduZWQpQklUUyhpYiwgMjAsIDIxKSwgUlNULAo+ICsJCQkJ
CQkJICAgQkxVRSwgKHVuc2lnbmVkKUJJVFMoaWIsIDIxLCAyMiksIFJTVCwKPiArCQkJCQkJCSAg
IEJMVUUsICh1bnNpZ25lZClCSVRTKGliLCAyOCwgMzApLCBSU1QsCj4gKwkJCQkJCQkgICBCTFVF
LCAodW5zaWduZWQpQklUUyhpYiwgMzAsIDMxKSwgUlNULAo+ICsJCQkJCQkJICAgQkxVRSwgKHVu
c2lnbmVkKUJJVFMoaWIsIDMxLCAzMiksIFJTVCk7Cj4gICAJCQkJCX0KPiAgIAkJCQkJaWYgKCFh
c2ljLT5vcHRpb25zLm5vX2ZvbGxvd19pYikgewo+ICAgCQkJCQkJaWYgKHVtcl9yZWFkX3ZyYW0o
YXNpYywgZGVjb2Rlci0+cG00Lm5leHRfaWJfc3RhdGUuaWJfdm1pZCwKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
