Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B16C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D5B2072C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EI20pjrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D5B2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09206EBD4;
	Fri, 13 Mar 2020 14:08:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C556EBCF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of2A8Njk9nplzK/7eeZPwYBNA/tjTXqolUhEPNVZzG5tM9lh6T5JC4zbkTst6YSh2MlDWHvj52hxY9yD/J/EGOOR8YrelWhd2MKOh7KZcVhrTKJmNCHKFJaqPzsoAOUl0sl0FhIncBo31YHvpq9bF9Tn48W/sXAJcuSFfUca6r5AB3dEX5kqY7DjxWGYOYbuPnjbO5ZAPIzfFpojnqivDqPIyQmXr1VhGhjaxmDrFFx4eWTfBE7QEJ5fV22TDRL1+F+XbO87Nj8Iof2m3EVCtrNzRC8ZRZf68GEgVWUdVw9bylvMOltYM/ehpFNU3tSPH18XlX0oupDITeDvzcVQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD+jhUO+wDi0PNDV1C59FdPlzul/D5vBf4DOIWP93dA=;
 b=T4CN1JVY54uvXZVH6auz2Wdi09oP2tMk9eJUwhrYYVWCndWrNYUR0rKv+fRY/HMKDx/vmriV5+BYLEH65Uq2j8Kbem96G9ll9AOpfrbSkRHTD4l5D9JIMFNCPIUUwbV5AElYB9XWiDSAij5FqiZEU35VgpGG+qBkh8enU3JsZqxb54pkfWSmQY8JXSOtMtnDCELZj+qib3u5O4Z9nIs5QCen+5DBUzSAnI9CbXdvpH4280PsNfgaNvpD7PWaj+ARgKO6ibjkId5MtMXKZYsgKXlsDssZcMdO3VyY3FTHL0Wj1Z9u92c9UBCWcG6ty0Xfui+lsVxbX2t2vGUuY4ntkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD+jhUO+wDi0PNDV1C59FdPlzul/D5vBf4DOIWP93dA=;
 b=EI20pjrJGVD12wEQkW0k6Ha8FZzaijqqL2+xJRsssIyX6iricxtsNRQ/nm+09HIUqGG8TCaKN90CwEQRpdbut+qd65oAJKzjm1tc8aPavuC7AJXWMCDHbFRoUSanZo5PdDomsX+hmLdzVp4QRlXudWXUU8mkRBrFx2ZGHRa0/Rc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 14:08:25 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 14:08:25 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/2] drm/amdgpu: Add job fence to resv conditionally
Date: Fri, 13 Mar 2020 22:07:57 +0800
Message-Id: <20200313140758.6607-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313140758.6607-1-xinhui.pan@amd.com>
References: <20200313140758.6607-1-xinhui.pan@amd.com>
X-ClientProxiedBy: HK2PR04CA0083.apcprd04.prod.outlook.com
 (2603:1096:202:15::27) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR04CA0083.apcprd04.prod.outlook.com (2603:1096:202:15::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16 via Frontend Transport; Fri, 13 Mar 2020 14:08:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea5eb8c5-337b-4053-4094-08d7c757ff1c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:|SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688D18EAFE52F0F89B71EF987FA0@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(66574012)(2616005)(4326008)(86362001)(316002)(26005)(956004)(8676002)(2906002)(8936002)(81166006)(66946007)(66476007)(52116002)(66556008)(7696005)(5660300002)(6666004)(81156014)(16526019)(478600001)(1076003)(36756003)(186003)(54906003)(6916009)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2688;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5U4nAym9QR7FLuvMOrNOtVx9MHIIiqSCWDo6OmJdM0XtW1p+FknYlQpkI8QlEcCSuNb6Dgnlc0CJQACwWVuFVduD80x4EYdiEo2ThS9q9BcmVQd6xDuHOjlZkZ7dTkS+oVUclOuwZAXCiELAxh/58nr9x2gZyfgku2m9n79fbu8Ffk2A4YjZ1n40hUgbbtoVKdsVWi6BAJMeFI66kEtrd0FKRwgziCMuX9r05FAOQgkUnv5vdFan+oXRy0nfYPBngYnjK9mkANTl0PeOWBvCPyKDugA/gxBtK0VKpSbld/9djRrZPgNKGQW6hpRXpoGJzvrdioHrD8+JVlOHXdZQaSwyTo27WgAR276I0gzGt7OUNVBhgZ8O0Fte+uwMOGWuLEIQ9Mz5ce4uej0Sg0F7ES1B2m3rdulQb8p4vkZJGV4lZ6jlbQ2ljbJG+7EFRBO
X-MS-Exchange-AntiSpam-MessageData: By0FIl7xFI7t6VcMPEcs4Ru9ZVAJGNi5lHYca1tDeZD2Sa4i5NpjJbfxUXIAAdevSZAexYeVTaOy/+OivRY7DfDnKhOXkqT/h5To17X1hf4Rl4Ty9CsdupSAwaUn2k3A9lF6goUeKCO8VkvTmCihPQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5eb8c5-337b-4053-4094-08d7c757ff1c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:08:25.4317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeLN2OGn/d03C+WKt11ykQ6i2nVawyMan/SkBFNVGtc9eSMAFtXOGxOXFinOEbZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UHJvdmlkZSByZXN2IGFzIGEgcGFyYW1ldGVyIGZvciB2bSBzZG1hIGNvbW1pdC4KSm9iIGZlbmNl
IG9uIHBhZ2UgdGFibGUgc2hvdWxkIGJlIGEgc2hhcmVkIG9uZSwgc28gYWRkIGl0IHRvIHRoZSBy
ZXN2LgoKQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8
eGluaHVpLnBhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jICAgICAgfCA0ICsrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5oICAgICAgfCA1ICsrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1f
c2RtYS5jIHwgNyArKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCA3
MzM5ODgzMTE5NmYuLjgwOWNhNmU4ZjQwZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMKQEAgLTE1NzksNiArMTU3OSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3Vw
ZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCSAgICAgICBkbWFf
YWRkcl90ICpwYWdlc19hZGRyLAogCQkJCSAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2Up
CiB7CisJc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9IHZtLT5yb290LmJhc2UuYm87CiAJc3RydWN0
IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zIHBhcmFtczsKIAllbnVtIGFtZGdwdV9zeW5jX21vZGUg
c3luY19tb2RlOwogCWludCByOwpAQCAtMTYwNCw4ICsxNjA1LDYgQEAgc3RhdGljIGludCBhbWRn
cHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJfQog
CiAJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkgewotCQlzdHJ1Y3QgYW1kZ3B1X2JvICpy
b290ID0gdm0tPnJvb3QuYmFzZS5ibzsKLQogCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2
bS0+bGFzdF9kaXJlY3QpKQogCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2RpcmVj
dCwgdHJ1ZSk7CiAKQEAgLTE2MTMsNiArMTYxMiw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2Jv
X3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJYW1kZ3B1X2Jv
X2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2RlbGF5ZWQsIHRydWUpOwogCX0KIAorCXBhcmFtcy5yZXN2
ID0gcm9vdC0+dGJvLmJhc2UucmVzdjsKIAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgm
cGFyYW1zLCByZXN2LCBzeW5jX21vZGUpOwogCWlmIChyKQogCQlnb3RvIGVycm9yX3VubG9jazsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKaW5kZXggYjU3MDVmY2ZjOTM1Li5j
YTYwMjFiNDIwMGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCkBAIC0y
MjYsNiArMjI2LDExIEBAIHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyB7CiAJICogQG51
bV9kd19sZWZ0OiBudW1iZXIgb2YgZHcgbGVmdCBmb3IgdGhlIElCCiAJICovCiAJdW5zaWduZWQg
aW50IG51bV9kd19sZWZ0OworCisJLyoqCisJICogQHJlc3Y6IHN5bmMgdGhlIHJlc3YgYW5kIGFk
ZCBqb2IgZmVuY2UgdG8gaXQgY29uZGl0aW9uYWxseS4KKwkgKi8KKwlzdHJ1Y3QgZG1hX3Jlc3Yg
KnJlc3Y7CiB9OwogCiBzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9mdW5jcyB7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwppbmRleCA0Y2M3ODgxZjQzOGMuLmEx
YjI3MGE0ZGE4ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtX3NkbWEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2Rt
YS5jCkBAIC0xMTEsNiArMTExLDEzIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3NkbWFfY29tbWl0
KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKIAkJc3dhcChwLT52bS0+bGFzdF9k
ZWxheWVkLCB0bXApOwogCWRtYV9mZW5jZV9wdXQodG1wKTsKIAorCS8qIGFkZCBqb2IgZmVuY2Ug
dG8gcmVzdi4KKwkgKiBNTSBub3RpZmllciBwYXRoIGlzIGFuIGV4Y2VwdGlvbiBhcyB3ZSBjYW4g
bm90IGdyYWIgdGhlCisJICogcmVzdiBsb2NrLgorCSAqLworCWlmICghcC0+ZGlyZWN0ICYmIHAt
PnJlc3YpCisJCWRtYV9yZXN2X2FkZF9zaGFyZWRfZmVuY2UocC0+cmVzdiwgZik7CisKIAlpZiAo
ZmVuY2UgJiYgIXAtPmRpcmVjdCkKIAkJc3dhcCgqZmVuY2UsIGYpOwogCWRtYV9mZW5jZV9wdXQo
Zik7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
