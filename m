Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436DC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CAC2067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CAC2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1756EBB3;
	Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690083.outbound.protection.outlook.com [40.107.69.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9376EBB3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSWJXQ0+WqaqYA57IR70H7SF765Z7zUtIkGSNCQpgg0ZMvy8hKS5aVyJ91s9UEYYwRId7n3r05Yh012CJTzkgJfAAgoGHX+iDdIDGGBbVxXVFEB6CDjmhq/BxYZ6YK0TkHMlMneHIOELiCQ2MLYPeAW/M0URAwiflR/7tvRjwlof4r6Bx9MTKOPZWEVW+B/ZzhxvDhUYwHfjOZF1RMdTn4uuBYMlLN2Ny9JCgiPMNa5LcHxq3rOMoCVohxzq0hOZnv1xemM2VKhX5qouvdMyGo9p35sYf7mvIuMizAdlFgk+BKQsB63ZcNi2OTqXX3n1UmhCcuV53nggsCauyQChPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0FD/f7qjZAbZvQ6G4uQe+8V0WkfZENHFkqM67U1zx8=;
 b=niThsOxlKBXDL21yhnNQEtTuKxWS6dKIuRVVU0lFC5+4ijpAEPHZ4V0Jbk5iw1WKtlFzf4uimpEsd86uf6dOiBXiEkQuGXdDd1KWwZWDbiHz9SSm4j1RT1O1aKyvunhJ+bmDQIw0jJQ2saC6gJblQex0HtVHqf6Ex0cTfr73ZFk/H1RaQhjaLdYM8+egrk3zy3FN78zAzflvZZsQD+NYRtUK2jjY82WyD9PL8tLS9fofXsdFU1NgunrzyiCdcwPNgVy7w18EwI+AeVA4hILivEj0/wRWNjw6rpDhTFrd/dHR+YeNT9FT46CKMol6i2PRog8Ggdt91NQxRx4GrtrBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:16 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:16 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/21] drm/amd/powerplay: set JPEG to SMU dpm
Date: Tue, 12 Nov 2019 13:03:23 -0500
Message-Id: <20191112180329.3927-16-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e003b781-ff7d-4c8f-69e2-08d7679abb52
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15806E49BA978AF1062F4354E5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(86362001)(11346002)(50226002)(6666004)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXGc4LLtIeIMfYi4Yaa42EAxexOw3tuXLsvvvfp5etjdizw2MXhtotnZWdz++TNzQKxU2ECIHkdeVFDMvCk4V/xGa6RC5miOi4CBAqz4We2+y7eLU58cIAJSobcEkxQwYnk0Y0eZNOoh9pX2907hP7LwfzdwD/k3rqFKyAn00wVWcGPZ+EhNlzbvxoxvYiYCFTg3Xo0z2XULbwsxlazbQkQibDvynP5jgobZIP6GiUhKoAUar2yy/MufxQrZEVSxa/QLqcysJxLrLEHiCyAiKhgrZ1AygiXJYyqgVePZoWq4AoVV2yX6yaPDWmNVFzn8+UvyJ5Eij376q+Xf12jz9sixvpIn5oiGxRgZcQOERosDTJh1HTppNRu8KhSmAi5x2+lVmNT+hQM69L//VWMhdSoKh6wo6kUHY1oqdbm76jeN3KRsAzRLd9bKad/KJGh5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e003b781-ff7d-4c8f-69e2-08d7679abb52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:16.3958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brb8Zqa+sHWv2/9wd4GMMuTZtkh/UpgRLyjNRxLhSqqyl4i0+8cZAjhl7c5C42GB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0FD/f7qjZAbZvQ6G4uQe+8V0WkfZENHFkqM67U1zx8=;
 b=dUrzP1DZ6AcLiqngppoM7NLdZLuGRNTehow7+NqvA7FDFs8q9N2gchg6SPTWQKr0ocZxDejvEj1uvfZ6oM4L/Nhxnr8IVXXJWRL/4xKAwXDl6bw4MwRjQup4Jq+31yX5otwBRiQmZkW4aCAIU+A/0AjF7y1skDz4F1vVbZWBcu4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112180323.XPQeJOzNZOxfQOKBPHKd7om9DocFt9hJR8jhsGHO9Vw@z>

QnkgdXNpbmcgaXRzIG93biBJUCBibG9jayB0eXBlLgoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8
bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdw
dV9zbXUuYyAgIHwgMyArKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV9pbnRl
cm5hbC5oIHwgMiArKwogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKaW5kZXggMjExOTM0NTIxZDM3Li5h
MTQ1MzE1N2VlZmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211
LmMKQEAgLTQxNSw2ICs0MTUsOSBAQCBpbnQgc211X2RwbV9zZXRfcG93ZXJfZ2F0ZShzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSwgdWludDMyX3QgYmxvY2tfdHlwZSwKIAljYXNlIEFNRF9JUF9CTE9D
S19UWVBFX1NETUE6CiAJCXJldCA9IHNtdV9wb3dlcmdhdGVfc2RtYShzbXUsIGdhdGUpOwogCQli
cmVhazsKKwljYXNlIEFNRF9JUF9CTE9DS19UWVBFX0pQRUc6CisJCXJldCA9IHNtdV9kcG1fc2V0
X2pwZWdfZW5hYmxlKHNtdSwgZ2F0ZSk7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCWJyZWFrOwog
CX0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV9pbnRlcm5h
bC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X2ludGVybmFsLmgKaW5kZXgg
NzBjNGQ2NjcyMWNkLi5iMmQ4MWQzNDkwY2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L3NtdV9pbnRlcm5hbC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3NtdV9pbnRlcm5hbC5oCkBAIC0xNzIsNiArMTcyLDggQEAKIAkoKHNtdSktPnBwdF9m
dW5jcy0+ZHBtX3NldF91dmRfZW5hYmxlID8gKHNtdSktPnBwdF9mdW5jcy0+ZHBtX3NldF91dmRf
ZW5hYmxlKChzbXUpLCAoZW5hYmxlKSkgOiAwKQogI2RlZmluZSBzbXVfZHBtX3NldF92Y2VfZW5h
YmxlKHNtdSwgZW5hYmxlKSBcCiAJKChzbXUpLT5wcHRfZnVuY3MtPmRwbV9zZXRfdmNlX2VuYWJs
ZSA/IChzbXUpLT5wcHRfZnVuY3MtPmRwbV9zZXRfdmNlX2VuYWJsZSgoc211KSwgKGVuYWJsZSkp
IDogMCkKKyNkZWZpbmUgc211X2RwbV9zZXRfanBlZ19lbmFibGUoc211LCBlbmFibGUpIFwKKwko
KHNtdSktPnBwdF9mdW5jcy0+ZHBtX3NldF9qcGVnX2VuYWJsZSA/IChzbXUpLT5wcHRfZnVuY3Mt
PmRwbV9zZXRfanBlZ19lbmFibGUoKHNtdSksIChlbmFibGUpKSA6IDApCiAKICNkZWZpbmUgc211
X3NldF93YXRlcm1hcmtzX3RhYmxlKHNtdSwgdGFiLCBjbG9ja19yYW5nZXMpIFwKIAkoKHNtdSkt
PnBwdF9mdW5jcy0+c2V0X3dhdGVybWFya3NfdGFibGUgPyAoc211KS0+cHB0X2Z1bmNzLT5zZXRf
d2F0ZXJtYXJrc190YWJsZSgoc211KSwgKHRhYiksIChjbG9ja19yYW5nZXMpKSA6IDApCi0tIAoy
LjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
