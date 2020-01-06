Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699BFC33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 21:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224892072C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 21:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4BK1N5vQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224892072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10486E511;
	Mon,  6 Jan 2020 21:04:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182376E511
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 21:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZPSPhNsJ5ryV/tJ7bjQLwFicqXWnKRi/WJ4Xh0Y3hkOQ9SnyclQNbsnO6TUSyWx4iLpQB0mo6HennxXTe3cHzcnD7A/pbQ0oZLbRNadxmePXPnVlJ/80pTydqZyKXwQBSs3CCQQkfNQhr0sMfx/MIGsP467pGXqRMxyrRIr+TaP2pDGceG+gv9DOpk2xOMguiBqoNY+fCKyZIp9rsCvIqMElZb1OuJHoSpYsSUY8oS8UZtJ3k6e1nU8Ivwxl2Rw+Q8T6mMqGAirTNdPhgSG0mHoMI9qsgfQAldTdr6uVGDltE00tNYsiGa6OQ5IsmL/WY6lOUq/Pb25H8XdhVVyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOhHd2CMM9rCNfqAJWnzydgzgkJwD5nAaDGWETVlY9M=;
 b=RmzF0dNwvTOesf2W5i9eVfRhCFT8XO2Kx1d0abwI52+yAATlBEsve2FprsLpaeLUKd380VEF/o/TKkOfo7AXsm2+Q/P6ZIj7phYEL/NWkqhNAZkO08rkKTg78/wNqpT9TPUS1HIiZDeqcklIe6tGQ0xs9RysDg/vYHIWvzWmVmlLvFcDKkWEOm4tUxmmUwyV/FNBcD1lcG+ci2D8GuGLlbgTWxF77IT5WFqJtiYska5XigHiQJZooKs6ALoK5EHIQRDRA4fCH7wvSe6vEUTS4T0UEmhLhSSeoEA4svZBSFwWYbi8RlkwpoJAhT7+Ro7Tgge65LRDWaLooUQJhug9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOhHd2CMM9rCNfqAJWnzydgzgkJwD5nAaDGWETVlY9M=;
 b=4BK1N5vQiiiFyZBqO3BYbv1mA/uyzsWiqKBwWpZel5aN7DOdIImmX+RVCb66b4l+u7KfGNE03wDfvEF7iD0r2MXJLdbZ9b3ZXrooyN0ziZAGEyiJEMSnzvpny9LBSqmy1W3LUPhFO30h7o5THKQ08m5BCupnqsMEXl1yv0SC3lY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0012.namprd12.prod.outlook.com (10.172.89.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Mon, 6 Jan 2020 21:04:35 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 21:04:34 +0000
Subject: Re: [PATCH 10/12] drm/amdgpu: immedially invalidate PTEs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex.Sierra@amd.com, Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
References: <20200106150335.1738-1-christian.koenig@amd.com>
 <20200106150335.1738-11-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <9247b84d-fac5-4ae1-0050-ea0544f04db1@amd.com>
Date: Mon, 6 Jan 2020 16:04:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200106150335.1738-11-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 21:04:34 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91363c69-87c0-4be6-fd80-08d792ec086b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0012:|DM5PR1201MB0012:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00128D4BFEFD8F37666AF8B0923C0@DM5PR1201MB0012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(44832011)(66574012)(31686004)(6486002)(16576012)(316002)(53546011)(81166006)(8676002)(81156014)(36756003)(26005)(186003)(2616005)(36916002)(16526019)(52116002)(2906002)(31696002)(86362001)(66946007)(8936002)(5660300002)(478600001)(66556008)(956004)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0012;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GW1d/IddArYUghdj2hccoGkda7zzK2ijFOYUHMc+iJK124O9pR4aBDH4qmsJ5cOSGn7D18ytB5+KIdmQTBmxTMoQV39VtMTjJCLhLwwR4bnm+r82fhwUzfIDhix5V5Ns19duz/gnf/pwt+zmjZaE5zqZvBpMOGqkRi0NIx87xr9wKW4BiwWmFk2KGkZvsR2NLE/LZwwPLSI2uegDvaZYEkfPVL32/zcaNpZ6eTK9tre9q3WPxaQRRlWrGibWL6k9hAZCjW0c7lrgcmbjLB5cYdOIcGhVJ5h8RoNDXrfhLsnWfi9z3ywf57haRUtX1Bw7KLcCcAKZWPGLGrKaq366qMUFgryTWEjj++kRenWH5jrdb8KKsHxNM+cnWWIVhfyAM/BLXpg1/KzlYN7tdPXbEZk+iWt+dK8pYnCBtiFJ+SZ5FWzgIpEnp8dZhLF9kzPa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91363c69-87c0-4be6-fd80-08d792ec086b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 21:04:34.8955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBowH9hyn0LXCftQSOqd6rXGjypNf/A826LCz6lMC9svOb59MtRTzea4uze7PIlcZ1pQZa9UrODdbHimPR5T1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0012
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

T24gMjAyMC0wMS0wNiAxMDowMyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFdoZW4g
YSBCTyBpcyBldmljdGVkIGltbWVkaWFsbHkgaW52YWxpZGF0ZSB0aGUgbWFwcGVkIFBURXMuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDE3
ICsrKysrKysrKysrKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBp
bmRleCBhMDNjZmJlNjcwYzQuLjY4NDRiYTc0NjdhNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTI1NjksNiArMjU2OSw3IEBAIHZvaWQgYW1kZ3B1X3Zt
X2JvX2ludmFsaWRhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkgICAgIHN0
cnVjdCBhbWRncHVfYm8gKmJvLCBib29sIGV2aWN0ZWQpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdw
dV92bV9ib19iYXNlICpib19iYXNlOwo+ICsJaW50IHI7Cj4gICAKPiAgIAkvKiBzaGFkb3cgYm8g
ZG9lc24ndCBoYXZlIGJvIGJhc2UsIGl0cyB2YWxpZGF0aW9uIG5lZWRzIGl0cyBwYXJlbnQgKi8K
PiAgIAlpZiAoYm8tPnBhcmVudCAmJiBiby0+cGFyZW50LT5zaGFkb3cgPT0gYm8pCj4gQEAgLTI1
NzYsOCArMjU3NywyMiBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+ICAgCj4gICAJZm9yIChib19iYXNlID0gYm8tPnZtX2JvOyBib19i
YXNlOyBib19iYXNlID0gYm9fYmFzZS0+bmV4dCkgewo+ICAgCQlzdHJ1Y3QgYW1kZ3B1X3ZtICp2
bSA9IGJvX2Jhc2UtPnZtOwo+ICsJCXN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9IHZtLT5yb290LmJh
c2UuYm8tPnRiby5iYXNlLnJlc3Y7Cj4gKwo+ICsJCWlmIChiby0+dGJvLnR5cGUgIT0gdHRtX2Jv
X3R5cGVfa2VybmVsKSB7Cj4gKwkJCXN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3ZhOwo+ICsKPiAr
CQkJYm9fdmEgPSBjb250YWluZXJfb2YoYm9fYmFzZSwgc3RydWN0IGFtZGdwdV9ib192YSwKPiAr
CQkJCQkgICAgIGJhc2UpOwo+ICsJCQlyID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZShhZGV2LCBib192
YSwKPiArCQkJCQkJYm8tPnRiby5iYXNlLnJlc3YgIT0gcmVzdik7CgpXaWxsIHRoaXMgdXBkYXRl
IFBURXMgZm9yIHBlci1WTSBCT3Mgd2l0aG91dCB2YWxpZGF0aW5nIHRoZW0gZmlyc3Q/CgoKPiAr
CQkJaWYgKCFyKSB7Cj4gKwkJCQlhbWRncHVfdm1fYm9faWRsZShib19iYXNlKTsKCklzIHRoaXMg
dGhlIHJpZ2h0IHN0YXRlPyBUaGUgZGVzY3JpcHRpb24gb2YgYW1kZ3B1X3ZtX2JvX2lkbGUgc2F5
cyB0aGF0IAp0aGlzIGlzIGZvciAiUERzL1BUcyBhbmQgcGVyIFZNIEJPcyIuIEZvciByZWd1bGFy
IEJPcywgSSB0aGluayB0aGlzIApzaG91bGQgY2FsbCBhbWRncHVfdm1fYm9fZG9uZS4KCgo+ICsJ
CQkJY29udGludWU7CgpUaGlzIHNraXBzIGEgYnVuY2ggb2Ygc3RhdGUgbWFjaGluZSBsb2dpYyBi
ZWxvdy4gTWF5YmUgc29tZSBvZiB0aGF0IApjb3VsZCBiZSBjbGVhbmVkIHVwLgoKCj4gKwkJCX0K
PiArCQl9Cj4gICAKPiAtCQlpZiAoZXZpY3RlZCAmJiBiby0+dGJvLmJhc2UucmVzdiA9PSB2bS0+
cm9vdC5iYXNlLmJvLT50Ym8uYmFzZS5yZXN2KSB7Cj4gKwkJaWYgKGV2aWN0ZWQgJiYgYm8tPnRi
by5iYXNlLnJlc3YgPT0gcmVzdikgewo+ICAgCQkJYW1kZ3B1X3ZtX2JvX2V2aWN0ZWQoYm9fYmFz
ZSk7CgpJdCB3aWxsIG5ldmVyIGdldCBoZXJlIGZvciBwZXItVk0gQk9zIG5vdyAoZXhjZXB0IGlm
IGJvX3VwZGF0ZSBmYWlsZWQpLiAKTm90IHN1cmUgaWYgdGhhdCdzIGEgcHJvYmxlbS4KCgo+ICAg
CQkJY29udGludWU7Cj4gICAJCX0KPgo+ICAgICAgICAgICAgICAgICAgaWYgKGJvX2Jhc2UtPm1v
dmVkKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiAgICAgICAgICAgICAg
ICAgIGJvX2Jhc2UtPm1vdmVkID0gdHJ1ZTsKCk1heWJlIHRoZSB3aG9sZSBQVCBpbnZhbGlkYXRp
b24gc2hvdWxkIGJlIGFmdGVyIHRoaXMgdG8gYXZvaWQgbXVsdGlwbGUgCmludmFsaWRhdGlvbnMg
b2ZmIHRoZSBzYW1lIEJPPwoKCj4KPiAgICAgICAgICAgICAgICAgIGlmIChiby0+dGJvLnR5cGUg
PT0gdHRtX2JvX3R5cGVfa2VybmVsKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVf
dm1fYm9fcmVsb2NhdGVkKGJvX2Jhc2UpOwo+ICAgICAgICAgICAgICAgICAgZWxzZSBpZiAoYm8t
PnRiby5yZXN2ID09IHZtLT5yb290LmJhc2UuYm8tPnRiby5yZXN2KQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICBhbWRncHVfdm1fYm9fbW92ZWQoYm9fYmFzZSk7Cj4gICAgICAgICAgICAgICAg
ICBlbHNlCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV92bV9ib19pbnZhbGlkYXRl
ZChib19iYXNlKTsKCkkgYmVsaWV2ZSB0aGUgbGFzdCB0d28gY2FzZXMgYXJlIHVucmVhY2hhYmxl
IG5vdyAoZXhjZXB0IGlmIGJvX3VwZGF0ZSAKZmFpbGVkKS4KClJlZ2FyZHMsCiDCoCBGZWxpeAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
