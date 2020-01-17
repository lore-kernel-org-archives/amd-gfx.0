Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F48C33CAF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 02:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BFA2072B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 02:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ADxXcsMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BFA2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C386F37D;
	Fri, 17 Jan 2020 02:42:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE896F37D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 02:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alDoxdXslSdHf8wEEY1JXun99h9Wo9fBHkR36MwkCsUZvDWFf9QYricN7WlX7OTxDGrAMpdVhOH+D5rB2/BDDpCwW7O2R1RK33rsnvgukGi9k34RAhH07y1UdzhjqW7igw0R0T7BzLjFYWu73nrdIy15LmvaaVbpjzkPtfrHpolmvoRvjXvpfXCIdapPBvGLufx6CzHO7Q0diE9bIsePC2iit7U93vxJGjTo6H0ddJWiyWCeC+ZqDWdDxh3BRYuvn4bV3T8FLZZyD1S4Zc5Z970M1ef3/3UXAZSl5gCIHW2DamUc3/fjG1o8HtIlrwQh1F2EC3PX7Z16/+S7DporRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAAnIzIfU8te20j+JXzUpUTfnaz/lwWk1xcrWTDx8H4=;
 b=mx/GyTXaKzgLP2AizDud+EDE4Ybpz4BMZjkT/2JCuWjPdFTGQqeAhlgD+ByX3fltQbanLzaedkQXpcZchZgitYhDKQxjF7xzdrfxFpboJrYZWQElMDrNUvoYvr/HRKhdoAl6t7ASBofUa7UIwyJ3xLpsOk5aqRB66i6d5mjaXTCKdBOAoIMvzuRY82+EP79oSI8ZAPS0nl4DVSdldxe4n7ItyTm7fkChVudHcCU5sD/fXqmTH8ibMXap/EoI7xuz/UEcWVsQnc1c580gzAZo9Iwzlu0rCNblyCDwX9bX8g2ZJ/1aR5lXVCTWEI0ohGBotse6m+iReygxiqmGuVTqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAAnIzIfU8te20j+JXzUpUTfnaz/lwWk1xcrWTDx8H4=;
 b=ADxXcsMkXJMwroocCcNcsSFwwJAOQuAj/nnP9FUfaVuOfnvWq8jN+Nf2/eoDGzVavT8906AAXi+YQRiIi4nwlZIzA0cXqtSR+p6dTdvdhKnhxXPk0F8VMbPBzNjpaf/Y/bnNX7BBuGRVVzTn6+mpECPWSyQRnbTynzsiAhIMzko=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Flora.Cui@amd.com; 
Received: from MN2PR12MB3312.namprd12.prod.outlook.com (20.179.80.215) by
 MN2PR12MB3471.namprd12.prod.outlook.com (20.178.242.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 17 Jan 2020 02:42:46 +0000
Received: from MN2PR12MB3312.namprd12.prod.outlook.com
 ([fe80::58f5:ace4:d364:9664]) by MN2PR12MB3312.namprd12.prod.outlook.com
 ([fe80::58f5:ace4:d364:9664%5]) with mapi id 15.20.2644.021; Fri, 17 Jan 2020
 02:42:46 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: skip reservation of discovery tmr region
 in pre-Navi
To: amd-gfx@lists.freedesktop.org
References: <1579201021-7109-1-git-send-email-Hawking.Zhang@amd.com>
 <1579201021-7109-2-git-send-email-Hawking.Zhang@amd.com>
From: "Cui, Flora" <fcui@amd.com>
Message-ID: <5686e8de-3e15-d399-6c5b-9213721417d1@amd.com>
Date: Fri, 17 Jan 2020 10:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <1579201021-7109-2-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2PR02CA0212.apcprd02.prod.outlook.com
 (2603:1096:201:20::24) To MN2PR12MB3312.namprd12.prod.outlook.com
 (2603:10b6:208:ab::23)
MIME-Version: 1.0
Received: from [10.65.97.113] (180.167.199.189) by
 HK2PR02CA0212.apcprd02.prod.outlook.com (2603:1096:201:20::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Fri, 17 Jan 2020 02:42:45 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1148f8e-3bff-442f-290c-08d79af6ef4b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3471:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3471B8BA36EDB3B8A7C488BAFA310@MN2PR12MB3471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(199004)(189003)(2616005)(8936002)(6916009)(66946007)(8676002)(81156014)(2906002)(478600001)(66476007)(81166006)(956004)(66556008)(16576012)(6666004)(31696002)(186003)(5660300002)(26005)(316002)(52116002)(16526019)(36756003)(31686004)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3471;
 H:MN2PR12MB3312.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLhk2EPjUeYf0bM3p9jk9RERIPxtjK2LhFF7qnkCAgbwpgmaoqB44AG7h8pTiM0Xk5Bz5JpufRkz0YiwcYfOySMBKxrMIva4nAjiALKcRy9+pyrz/hPobzUirdgAUr8GBrlpxZsPawu4xPDRskKOd7xAWSsA5rfpHoTS0NdMv4yEjmsU6dsCwgr130kgZhAPdDENwyL5dnQoHfG+5JWprDqI+OOw9MDmqSJ1B0BdRBYjWqzR4DDm+70/0FWzGrbMy3v+ryptwRvVu/2ksJkk6bt/2ixk3U1uYFPU3cQQlG46FRHT1GRnTThgwDHxUYC4TFZKtHj7DFU3/vT60sPCbZMBNvN1qz1VbC11R1pu/g/zao0EmM40JERcAmXAo9yl8gfHjt3sxt/0b98wp3R/TaFQd9o3WKd3TTd4MVDEMzBwUMhzGruz4e+Ll+rDHoD/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1148f8e-3bff-442f-290c-08d79af6ef4b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 02:42:46.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdVLlD4JOAU8uVVQRnI1kt8pUEcJ4VWhb1BhxdO0/I4f0BnBARVDFI4T8eahVf6o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3471
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SU1ITyBpdCdzIGJldHRlciB0byBoYW5kbGUgdGhlIHNpemU9PTAgY2FzZSBpbiBhbWRncHVfYm9f
Y3JlYXRlX2tlcm5lbF9hdCgpLgoK1NogMS8xNy8yMDIwIDI6NTcgQU0sIEhhd2tpbmcgWmhhbmcg
0LS1wDoKPiBJUCBkaXNjb3ZlcnkgaXMgb25seSBzdXBwb3J0ZWQgaW4gTmF2aSBzZXJpZXMgYW5k
IG9ud2FyZHMuCj4gVGhlcmUgaXMgbm8gbmVlZCB0byByZXNlcnZlIGEgcG9ydGlvbiBvZiB2cmFt
IGFzIGRpc2NvdmVyeQo+IHRtciByZWdpb24gZm9yIHByZS1OYXZpIGFkYXB0ZXJzLgo+Cj4gU2ln
bmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+IC0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgOCArKysrKy0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBpbmRleCA5NjdmNmQwLi5mMjFm
ZDhmYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBAQCAt
MTgyMiwxNCArMTgyMiwxNiBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQo+ICAgCSAqIHJlc2VydmUgVE1SIG1lbW9yeSBhdCB0aGUgdG9wIG9mIFZSQU0g
d2hpY2ggaG9sZHMKPiAgIAkgKiBJUCBEaXNjb3ZlcnkgZGF0YSBhbmQgaXMgcHJvdGVjdGVkIGJ5
IFBTUC4KPiAgIAkgKi8KPiAtCXIgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbF9hdChhZGV2LAo+
ICsJaWYgKGFkZXYtPmRpc2NvdmVyeV90bXJfc2l6ZSA+IDApIHsKPiArCQlyID0gYW1kZ3B1X2Jv
X2NyZWF0ZV9rZXJuZWxfYXQoYWRldiwKPiAgIAkJCWFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSAt
IGFkZXYtPmRpc2NvdmVyeV90bXJfc2l6ZSwKPiAgIAkJCWFkZXYtPmRpc2NvdmVyeV90bXJfc2l6
ZSwKPiAgIAkJCUFNREdQVV9HRU1fRE9NQUlOX1ZSQU0sCj4gICAJCQkmYWRldi0+ZGlzY292ZXJ5
X21lbW9yeSwKPiAgIAkJCU5VTEwpOwo+IC0JaWYgKHIpCj4gLQkJcmV0dXJuIHI7Cj4gKwkJaWYg
KHIpCj4gKwkJCXJldHVybiByOwo+ICsJfQo+ICAgCj4gICAJRFJNX0lORk8oImFtZGdwdTogJXVN
IG9mIFZSQU0gbWVtb3J5IHJlYWR5XG4iLAo+ICAgCQkgKHVuc2lnbmVkKSAoYWRldi0+Z21jLnJl
YWxfdnJhbV9zaXplIC8gKDEwMjQgKiAxMDI0KSkpOwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
