Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A10EC34051
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FA424656
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1xpxUvr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FA424656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE0C6EC1F;
	Wed, 19 Feb 2020 15:09:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688BB6EC1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVvXpNceQjndkDuKthfto2xq8J/4DM3LFZXnXMQ+8rl+sYGlmqtR+1AxheL7fUgIXPRBX1dSqFhZ1bbZJmT3RAgflYS/lTMbfGqdZITeYNPl7ovX+LdLgMaL37Y8QxnLg5G1cQ7ntGYPrknn9Ky4sqbK5mIJbrP6w6ZmdA9cEljlGDN6eHhtzyrreaH6Vv41IBNsmztnD+S8ubVV+lL47g92a3pEndZitNioDDsBHDI4s/cBj2OfICUSki1PYIXPWw2k8fKqRMkVp+g+CP+fKJ0B4Y8BF+fl+67SG3blLL0rnKl6DcwmeFRYkFJ88wHOAP/0ZCZ7V1ZozvgdHlI+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HEQTOeBAPW/wouob0d0uzVJS/s9SMil8Hf0MH60kM4=;
 b=UFzcyf8dUHtUDxrzCP037CnDP3GEqGcRhmFF5C2hA6U1yKDWTx1C7ycGrVix1nN5oeIvAxh/mG51bundMTzCfzzrj/TD6jm5Ev+a/S2LaEIlTBsz5H5qghAdomF0xXsxmoW3BnMCqYGQcZFrXQEi+F6dGsoXsasSRe8LQbfv8b4ERyb8BeCsFl7rZlNGHKyg4EYTcQOr3MDITjQTW9Hx1xf9OW/ehBfwC27b/kFuL3KYrC9xR9TiG5wsY1ttxVjh98GI+GkjvBTqw8vNA8AsuimqT7Js49TErgSuRXrxyqdadsPDZwzaSrfUmWV/BxMZfbbRo7jVzP4B8NROYKoPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HEQTOeBAPW/wouob0d0uzVJS/s9SMil8Hf0MH60kM4=;
 b=1xpxUvr2bKfhf0ef6P+tu1r/dIUUz4hKNIv6LnBD/4np3Pon2fxeZt0NL90UUPPklwFBJRxbNWpTUoTloB2zYw6+q/Kk7huI2u5J6Z3ssS+JJ0jRS6e5SXbei1ABDWk6cMgaHKBE4bd7R5LyLbIE+hKk/LojzKEgSCFxolzMIF0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB4240.namprd12.prod.outlook.com (52.135.48.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 15:09:48 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 15:09:48 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: disable GFXOFF around debugfs access to
 MMIO
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
Date: Wed, 19 Feb 2020 10:09:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:208:a8::18) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 MN2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:208:a8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 15:09:47 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 490e6f2c-9dc5-44bf-f9bf-08d7b54dc299
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42409377D320D68112377BE6F7100@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(8676002)(66556008)(4326008)(31696002)(81166006)(6916009)(966005)(36756003)(31686004)(81156014)(8936002)(5660300002)(6486002)(66476007)(86362001)(2906002)(2616005)(316002)(186003)(6512007)(52116002)(53546011)(16526019)(6506007)(956004)(66946007)(478600001)(45080400002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4240;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPZWGFLggEVhP4ualXG+3h6Mohm9Oc8SkvRy8W4HHxv/bXME2Bmi9JNZ7LpW96TeJQrKWsdVC14iviJBl3FYP0Z/Gpnk+92tnOl2CU5CX5hdAc7mm5O3ZDAV0Cm1pmpB18dP1LMwePFbMv+U+62suilpss2DWWM7RyKJiGLhhODBX7GrLMmShdWPsaA/f0UqQlUb/o+CwapT8RFPPmS070YODUy9kFiwAdsW4Kg1A2YpMvh2HS0f3PMBMjs39vLrAS3QdakucpgJET0FlaLXDmYpUAuDm5srheY8vByYD+nYUxLaQzOIZ//QWWWVf23LfFbVm+Yv9OzzqzoOUgNuwEdvKyqvk8BTfDf9FgDeXlEqko3ezi2VTl/UJLYjrmYLDymXtdKfNg4Kt1p4TZesw4RWNnWIrg2mvJXA9YfqSp+1dPjkuxUMzdkH4H2K2QuJytJVIwdoWKwF5FR6QXVe8dARipTPUzjPiH6Ik/czys/dbbbmHKq/euqOWTpn1FtWO+TJTSfg7DMbyslBLWW+Aw==
X-MS-Exchange-AntiSpam-MessageData: DyKNKkmnFIDXte4NaFcQyXgWM4eWUXnXngjXZ9z8VwH/5q2CMlVdXRJoFwZzUvG9uInSDiUa0qR/4jNTpr4MTx/sblEdpSS/2+COodZGcTCQtMqPQ3yYZdr37/t6ESiNjY8fBWegU9UDt8dQpjx1Eg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490e6f2c-9dc5-44bf-f9bf-08d7b54dc299
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:09:48.0663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HorTPzACwKhqgBzIOHsHqYb8mqFslGX1+0HUbiXe11OA+YO/Mm5mS+npCYCOla+2G9MagYr3DJy3Z+L82H1sqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

SSBnb3Qgc29tZSBtZXNzYWdlcyBhZnRlciBhIHdoaWxlOgoKW8KgIDc0MS43ODg1NjRdIEZhaWxl
ZCB0byBzZW5kIE1lc3NhZ2UgOC4KW8KgIDc0Ni42NzE1MDldIEZhaWxlZCB0byBzZW5kIE1lc3Nh
Z2UgOC4KW8KgIDc0OC43NDk2NzNdIEZhaWxlZCB0byBzZW5kIE1lc3NhZ2UgMmIuClvCoCA3NTku
MjQ1NDE0XSBGYWlsZWQgdG8gc2VuZCBNZXNzYWdlIDcuClvCoCA3NjMuMjE2OTAyXSBGYWlsZWQg
dG8gc2VuZCBNZXNzYWdlIDJhLgoKQXJlIHRoZXJlIGFueSBhZGRpdGlvbmFsIGxvY2tzIHRoYXQg
c2hvdWxkIGJlIGhlbGQ/wqAgQmVjYXVzZSBzb21lIApjb21tYW5kcyBsaWtlIC0tdG9wIG9yIC0t
d2F2ZXMgY2FuIGRvIGEgbG90IG9mIGRpc3RpbmN0IHJlYWQgb3BlcmF0aW9ucyAKKGNhdXNpbmcg
YSBsb3Qgb2YgZW5hYmxlL2Rpc2FibGUgY2FsbHMpLgoKSSdtIGdvaW5nIHRvIHNpdCBvbiB0aGlz
IGEgYml0IHNpbmNlIEkgZG9uJ3QgdGhpbmsgdGhlIHBhdGNoIGlzIHJlYWR5IApmb3IgcHVzaGlu
ZyBvdXQuCgoKVG9tCgpPbiAyMDIwLTAyLTE5IDEwOjA3IGEubS4sIEFsZXggRGV1Y2hlciB3cm90
ZToKPiBPbiBXZWQsIEZlYiAxOSwgMjAyMCBhdCAxMDowNCBBTSBUb20gU3QgRGVuaXMgPHRvbS5z
dGRlbmlzQGFtZC5jb20+IHdyb3RlOgo+PiBTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRv
bS5zdGRlbmlzQGFtZC5jb20+Cj4gUGxlYXNlIGFkZCBhIHBhdGNoIGRlc2NyaXB0aW9uLiAgV2l0
aCB0aGF0IGZpeGVkOgo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cj4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RlYnVnZnMuYyB8IDMgKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
YnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKPj4g
aW5kZXggNzM3OTkxMDc5MGM5Li42NmY3NjMzMDBjOTYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+PiBAQCAtMTY5LDYgKzE2OSw3IEBAIHN0
YXRpYyBpbnQgIGFtZGdwdV9kZWJ1Z2ZzX3Byb2Nlc3NfcmVnX29wKGJvb2wgcmVhZCwgc3RydWN0
IGZpbGUgKmYsCj4+ICAgICAgICAgIGlmIChwbV9wZ19sb2NrKQo+PiAgICAgICAgICAgICAgICAg
IG11dGV4X2xvY2soJmFkZXYtPnBtLm11dGV4KTsKPj4KPj4gKyAgICAgICBhbWRncHVfZ2Z4X29m
Zl9jdHJsKGFkZXYsIGZhbHNlKTsKPj4gICAgICAgICAgd2hpbGUgKHNpemUpIHsKPj4gICAgICAg
ICAgICAgICAgICB1aW50MzJfdCB2YWx1ZTsKPj4KPj4gQEAgLTE5Miw2ICsxOTMsOCBAQCBzdGF0
aWMgaW50ICBhbWRncHVfZGVidWdmc19wcm9jZXNzX3JlZ19vcChib29sIHJlYWQsIHN0cnVjdCBm
aWxlICpmLAo+PiAgICAgICAgICB9Cj4+Cj4+ICAgZW5kOgo+PiArICAgICAgIGFtZGdwdV9nZnhf
b2ZmX2N0cmwoYWRldiwgdHJ1ZSk7Cj4+ICsKPj4gICAgICAgICAgaWYgKHVzZV9iYW5rKSB7Cj4+
ICAgICAgICAgICAgICAgICAgYW1kZ3B1X2dmeF9zZWxlY3Rfc2Vfc2goYWRldiwgMHhmZmZmZmZm
ZiwgMHhmZmZmZmZmZiwgMHhmZmZmZmZmZik7Cj4+ICAgICAgICAgICAgICAgICAgbXV0ZXhfdW5s
b2NrKCZhZGV2LT5ncmJtX2lkeF9tdXRleCk7Cj4+IC0tCj4+IDIuMjQuMQo+Pgo+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0
cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRh
PTAyJTdDMDElN0N0b20uc3RkZW5pcyU0MGFtZC5jb20lN0NmM2M0Y2QzMTIwZmE0NzZiYmNhODA4
ZDdiNTRkODA3NiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2
MzcxNzcyMTY3ODI2ODQ3MjAmYW1wO3NkYXRhPW01ZXljbzFuR2M1WEQlMkZvcmQ3UTNnb0E0OEc1
TmhSJTJCcWRTWVFqbmZkNyUyRmclM0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
