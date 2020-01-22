Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84538C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 11:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555D921734
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 11:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eybX6BZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555D921734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BBD6F4CC;
	Wed, 22 Jan 2020 11:40:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA7126F4CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 11:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZDfwBWuPyYdCETT1HkABTDXoQBKRL+7rmMrLZbQG/EnwI0Dq7gbVg84P6Vak7fENwUeZVBZH+Z1PjQV+m/9XA5rahWCmAWfyFvT+CqXpQ/Cf5dx1gUQCpwnq75Uvz2eAnFHk9SegRGyHdu/OWSjkMpj+2IonrtUNn1+x96g6+kRdPDXhAhGjWEWgLzRnyRJfEIwbxGX9Qwaf3V9LJiopwb/0Qt+rBMqWcOjYY+qpMZjwK24W8IhT2PI8tWzPycd8q06BqXbjlV/9e78dif2QNYll2B5UiOr1Hs1t+5bZelB4MwmYNP+Muez2TliTqi0We4wr0J0LZ6yuksSkRppWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpiVt9XpxHWmblAz46WjBHScb2a0SQ/goxr5kYTVjd4=;
 b=YjcPcqqHvUG6wYwv8khYaqbeu242Ydv1dP6FgqOYDCOtRl0Oe0SXJ1+/Nu4TksDXwMYuchxErS5NkwZpQtKppJGHnroGJvzubPRCHxwA6xZhKw9e6LJKZNb8VbRDxXr3cfDrK7T7qAEo/wzKaYnIhyo/RQNhoYMka6mywR63v3RQ/b7GhFk2MtsNx+6/lXKq/A7vnL8FZf4jXn5B2kLC9hcRaiX9pQp6BiYF2wF4LUrDFnX673cfbZSwA0aazspDGznkrVyzJxEZxof1bgEWgrn1weqsTSfYdAue98Rc7HABIPfUfe4WJjFWydmL/pFjMsOyVVnS3OxEMmVGZuL8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpiVt9XpxHWmblAz46WjBHScb2a0SQ/goxr5kYTVjd4=;
 b=eybX6BZAD0msP4uHNFJILPT3g2F908h8sQgYDU1OX1Uac+pxJeOOCchSnlZkJoc/fcLcJuLxfMRM32bTWN7YFBo25H5eHOTWplaN24BeoBseHyuO1DnnID8IHY6puIuir7dmQwTPARoPQWRbk6z/h9f5d6Lmq3nZRs2qWxSdoX0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1243.namprd12.prod.outlook.com (10.168.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Wed, 22 Jan 2020 11:40:45 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 11:40:45 +0000
Subject: Re: [PATCH] drm/amdgpu: fix doc by clarifying sched_list definition
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200122093838.17136-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4100382f-2a65-5959-094f-cb004602c6fb@amd.com>
Date: Wed, 22 Jan 2020 12:40:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200122093838.17136-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0034.eurprd07.prod.outlook.com
 (2603:10a6:200:42::44) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0701CA0034.eurprd07.prod.outlook.com (2603:10a6:200:42::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.13 via Frontend
 Transport; Wed, 22 Jan 2020 11:40:44 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea1de33c-2e79-4369-e250-08d79f2feb07
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:|DM5PR12MB1243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1243D305B9982E7896E4165B830C0@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(31686004)(478600001)(2616005)(16526019)(186003)(52116002)(4326008)(31696002)(66476007)(66556008)(86362001)(66946007)(6486002)(66574012)(5660300002)(6666004)(2906002)(316002)(8936002)(8676002)(81166006)(81156014)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1243;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmTNYMPpSPQuu+nJ8QbExxG/0f45emb9imOLTm4GnDMGby8oXQJJjN60vGtNLmwSAFqBowyeawvxnPIY66ONx0sx4pWEfNi6jyA3o5TbZLnu82pyki3LichPwMPNm0Fvhs/4eb15j1PsWWhi0lsGeoFAYi3PfgKVDhpnn/kQ/0fcQRkOZgCSRBAHWQnNUZMiluo90/G/sDLmPSxpSVx4FcuJ1wvu52OVWV7IGcrqlCR6N00HRpVZmZMCAW4WaO6VHZeNhOFvPPyu5sDg/8eyW36zaAILsEj6bwx4vt5j3QYR4eW8cTC/9XzC2liVTYpolfjRcvlrtuuSCXsbgvOt7GdKSCRJ9Ug4Mmm1HCC78qe6riYqSjnQ46xHvM3HOstSA1j1oYM/k8HA4aVVnDnliNjqU2JNgU8RQnFo4WDJveBkVIT4Gbx1ZquzoBJjB+OM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1de33c-2e79-4369-e250-08d79f2feb07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 11:40:45.3705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vepvH14UpMei9qhetp/75eVE7MLs2wExh6plpbN0Q2ZmXnp8H2UckyKh/lAVK2k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, luben.tuikov@amd.com,
 nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDEuMjAgdW0gMTA6Mzggc2NocmllYiBOaXJtb3kgRGFzOgo+IGV4cGFuZCBzY2hlZF9s
aXN0IGRlZmluaXRpb24gZm9yIGJldHRlciB1bmRlcnN0YW5kaW5nLgo+IEFsc28gZml4IGEgdHlw
byBhdGxlYXN0IC0+IGF0IGxlYXN0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJt
b3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfZW50aXR5LmMgfCAyICstCj4gICBpbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmggICAgICAg
ICAgICAgIHwgNSArKystLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9lbnRpdHkuYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMK
PiBpbmRleCBlYzc5ZThlNWFkM2MuLjYzYmNjZDIwMWI5NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+IEBAIC00NSw3ICs0NSw3IEBACj4gICAgKiBAZ3Vp
bHR5OiBhdG9taWNfdCBzZXQgdG8gMSB3aGVuIGEgam9iIG9uIHRoaXMgcXVldWUKPiAgICAqICAg
ICAgICAgIGlzIGZvdW5kIHRvIGJlIGd1aWx0eSBjYXVzaW5nIGEgdGltZW91dAo+ICAgICoKPiAt
ICogTm90ZTogdGhlIHNjaGVkX2xpc3Qgc2hvdWxkIGhhdmUgYXRsZWFzdCBvbmUgZWxlbWVudCB0
byBzY2hlZHVsZQo+ICsgKiBOb3RlOiB0aGUgc2NoZWRfbGlzdCBzaG91bGQgaGF2ZSBhdCBsZWFz
dCBvbmUgZWxlbWVudCB0byBzY2hlZHVsZQo+ICAgICogICAgICAgdGhlIGVudGl0eQo+ICAgICoK
PiAgICAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBm
YWlsdXJlLgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmggYi9pbmNs
dWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPiBpbmRleCA5ZTcxYmUxMjljMzAuLjU4OWJlODUxZjhh
MSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPiArKysgYi9pbmNs
dWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPiBAQCAtNTIsOCArNTIsOSBAQCBlbnVtIGRybV9zY2hl
ZF9wcmlvcml0eSB7Cj4gICAgKiBAbGlzdDogdXNlZCB0byBhcHBlbmQgdGhpcyBzdHJ1Y3QgdG8g
dGhlIGxpc3Qgb2YgZW50aXRpZXMgaW4gdGhlCj4gICAgKiAgICAgICAgcnVucXVldWUuCj4gICAg
KiBAcnE6IHJ1bnF1ZXVlIG9uIHdoaWNoIHRoaXMgZW50aXR5IGlzIGN1cnJlbnRseSBzY2hlZHVs
ZWQuCj4gLSAqIEBzY2hlZF9saXN0OiBhIGxpc3Qgb2YgZHJtX2dwdV9zY2hlZHVsZXJzIG9uIHdo
aWNoIGpvYnMgZnJvbSB0aGlzIGVudGl0eSBjYW4KPiAtICogICAgICAgICAgICAgIGJlIHNjaGVk
dWxlZAo+ICsgKiBAc2NoZWRfbGlzdDogQSBsaXN0IG9mIHNjaGVkdWxlcnMgKGRybV9ncHVfc2No
ZWR1bGVycykuCj4gKyAqICAgICAgICAgICAgICBKb2JzIGZyb20gdGhpcyBlbnRpdHkgY2FuIGJl
IHNjaGVkdWxlZCBvbiBhbnkgc2NoZWR1bGVyCj4gKyAqICAgICAgICAgICAgICBvbiB0aGlzIGxp
c3QuCj4gICAgKiBAbnVtX3NjaGVkX2xpc3Q6IG51bWJlciBvZiBkcm1fZ3B1X3NjaGVkdWxlcnMg
aW4gdGhlIHNjaGVkX2xpc3QuCj4gICAgKiBAcnFfbG9jazogbG9jayB0byBtb2RpZnkgdGhlIHJ1
bnF1ZXVlIHRvIHdoaWNoIHRoaXMgZW50aXR5IGJlbG9uZ3MuCj4gICAgKiBAam9iX3F1ZXVlOiB0
aGUgbGlzdCBvZiBqb2JzIG9mIHRoaXMgZW50aXR5LgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
