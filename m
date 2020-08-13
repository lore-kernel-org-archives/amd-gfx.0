Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D151C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 03:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E08B20768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 03:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0zf9MpUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E08B20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F746E02E;
	Thu, 13 Aug 2020 03:04:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459316E02E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 03:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSr4u5TtkvqXtj1/sJqSZc3g+Gxwy0hBAch8dkAjHg6/WmAkWC2yHkXuZEw87l+ur7HOXFrSNVD85jExOMz2F1QNM8ywDe9F2Jg8WszNNki/h/H4eYLK3WHEhb2B/ZuBW4QhQvhk1s8i9YsyVwZleBMkrl5JqAworWrAo8ePB26rZS2bJSkV/q7TUpYOaftCFuStHK+5w5/4VNUCT/R5ozxUHwCFZR+snLVAF4UElCEaD4mVASUASY+FId7O2Z9JfbU13KIrV14KcM8qkzx3+zfLf6RzkjWa+OdtclNNbKutIEENq2/GpjmB8nNP6i5I2J7mW5UiwiknoLYe67oVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNQLdrrDLny4n0CUTco7m1i3E8Bu4y9lHXdNJ+JklRI=;
 b=LmZPn90NrtAQwnd1STOAP+k/WjPVXw9YJ9obXDQ1M/3eBZS9zW1rgx/Ege6a2m5puRPuAsX7Ydyw9I4ofyEbOY5QOBL4IvFVo+jK6Hy3zJ8I/v3bQoyCflyjilBl5fbrM+bzp0j7YuoNNrbaNpRgYLZuhV219g+q+/IYlO5yAtGpLj2IOIhHf3wj8I/1j+mIRULYjR4MV4m0/V4JmezePd/RYJiMqFp51kYUf7dj5Ma3C8UtY8N3xhBL9kSX6oQTgozj8nUG5DQ2B9vPJ9hN4IH0MLE0AW9QzpCGknC4wViZ51LBeImxp+wTfV1XLVoSlo8kMBF4O9GHyDwlwFIVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNQLdrrDLny4n0CUTco7m1i3E8Bu4y9lHXdNJ+JklRI=;
 b=0zf9MpUL3euB97xDBjnc1MDdZpuK6WxCv1DtRYED9wk+rqFdnSGAnNYyn0A2icewS6NeKMfTG6e/reKDMZ6rOk+d/O/TWIXyIW8c1NkQ1ka3Dmq4g2pg/amRJoMeFHoIeeA6bimZ6EkFQhNM4myoG7Sns5CVAaQkEM9CgcMeb2I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:72::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Thu, 13 Aug
 2020 03:04:35 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 03:04:35 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4] drm/amdgpu: add new trace event for page table update v3
Date: Thu, 13 Aug 2020 08:34:14 +0530
Message-Id: <20200813030414.188468-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MA1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::19) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (49.207.207.80) by
 MA1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 03:04:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.207.80]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c153df21-f150-4861-c282-08d83f359bb0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB267996756FFBEF6484601CC2F2430@BYAPR12MB2679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUzuWfJny6wCjh8hxolRH61I6GeFg3BtMe0GXsTg4+qSngRLr/bBf9x99AT9yZMb+Fh1MwrsZCkS/EN1DJCLuL5NONJ4MFmnxXhCN1t8RdP4INIvxbIPN8SiBw/qNXmLmofs8hiH0GCg38VsvX98WIcn4repCXQByCtJxCuPMR7xmXQjxpV9q+hcNliJWdGt0U0judXw49GO1kfBkBTOn3fL9Rq74xIHFNQyQl1s5/g2EQzprXSaGXewBJoJuoAxKqbG86Oq0WH5YjhnFHi8wHtmPUTBFgqdMWjVKXfD8LCUnFmmyBB/GHVp4yYRwqtyWzOMPEwfJ1kp7Q70nrGdxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(2616005)(15650500001)(186003)(66574015)(8936002)(54906003)(1006002)(26005)(44832011)(6486002)(316002)(478600001)(956004)(16526019)(6666004)(86362001)(6512007)(36756003)(2906002)(52116002)(55236004)(8676002)(4326008)(66556008)(83380400001)(66946007)(5660300002)(66476007)(6916009)(1076003)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TJUwBG9diw3S3Rs+2MOiOMbSrgU+czuQyzvD+BpkjecHDnLcYsD/AuY9AbBmely2FP9CMZlI0eS3GOubQ3KMgJJ3QMJ6CXHU8mtNDcnwKzd6/kDamMLXdHh1XqOoIFzpGsQ5UlftcbQYq99D6ui/ZmtJhx8/GEcIKm6E4KeOAmk8+Nc/jT0nQjfm20/YxtVLiDMD6PfxannhHT5dkk5Csb/1yK7BQo29mnuT3FbfSPxALvDNqmIVGIRxepCpUIaDZ4C8YeVIKr2lx31vNPw4xOn/H1yNolwbl8wo620m25VPb7aLfb3D0TIZPWqx88xYrlJFGWgwHYvIAgxL8DO8YD78AshLNrqnyT4FDEdjZweEcO5zChDOhZ9uSrzjoHp9C9Pb76ihIWEIhSKE06W7AzU+pPnNMjFt9+JR6Cs3nE4XZ+QGQzUw97loiaRjAMhPGwwoctsd39X3OVTxgEjPGdeh2U9eIT2F0nBcvDDbgV6AuikefzHRbq+sQSYfxpMUycOpau+pSYNvqRCRW8edq6sa5oNX2sqvp+LuRlHFyC9GjdLMT3ZkQAX0BbJgHbtw4hwmY51i+XJzyXGYRoupFI1xC6Tn4MMArvAzS6iB9cE80VJUtTJ/xMsfuFzykpevemNmB5GKPYcSJ80lxSaH8A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c153df21-f150-4861-c282-08d83f359bb0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 03:04:35.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1Czun6xzBqr97yNlVjLkmqDEkEgbwMjp0YyA2WSUqpEKxz4dtakRRrz9m2DmL507SYmT9mrLF4HJ1QJrQ89rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRl
CmV2ZW50cy4gVGhpcyBzcGVjaWZpYyBldmVudCB3aWxsIHByb3ZpZGUgaW5mb3JtYXRpb24gbGlr
ZToKLSBzdGFydCBhbmQgZW5kIG9mIHZpcnR1YWwgbWVtb3J5IG1hcHBpbmcKLSBIVyBlbmdpbmUg
ZmxhZ3MgZm9yIHRoZSBtYXAKLSBwaHlzaWNhbCBhZGRyZXNzIGZvciBtYXBwaW5nCgpUaGlzIHdp
bGwgYmUgcGFydGljdWxhcmx5IHVzZWZ1bCBmb3IgbWVtb3J5IHByb2ZpbGluZyB0b29scwoobGlr
ZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZSBldmVudHMu
CgpWMjogQWRkZWQgcGh5c2ljYWwgYWRkcmVzcyBsb29rdXAgbG9naWMgaW4gdHJhY2UgcG9pbnQK
VjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2FycmF5CiAgICBhZGRlZCBucHRlcyBpbnQgdGhl
IFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKICAgIGFkZGVkIHBhZ2Ugc2l6ZSBpbiB0aGUgYXJnIGxp
c3QKVjQ6IEFkZHJlc3NlZCBDaHJpc3RpYW4ncyByZXZpZXcgY29tbWVudHMKICAgIGFkZCBzdGFy
dC9lbmQgaW5zdGVhZCBvZiBzZWcKICAgIHVzZSBpbmNyIGluc3RlYWQgb2YgcGFnZV9zeiB0byBi
ZSBhY2N1cmF0ZQoKQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQt
b2ZmLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIHwgMzcgKysrKysrKysrKysr
KysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgIHwg
IDkgKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNl
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAppbmRleCA2M2U3
MzRhMTI1ZmIuLmRmMTJjZjg0NjZjMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3RyYWNlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3RyYWNlLmgKQEAgLTMyMSw2ICszMjEsNDMgQEAgREVGSU5FX0VWRU5UKGFtZGdwdV92bV9t
YXBwaW5nLCBhbWRncHVfdm1fYm9fY3MsCiAJICAgIFRQX0FSR1MobWFwcGluZykKICk7CiAKK1RS
QUNFX0VWRU5UKGFtZGdwdV92bV91cGRhdGVfcHRlcywKKwkgICAgVFBfUFJPVE8oc3RydWN0IGFt
ZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLAorCQkgICAgIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRf
dCBlbmQsCisJCSAgICAgdW5zaWduZWQgaW50IG5wdGVzLCB1aW50NjRfdCBkc3QsCisJCSAgICAg
dWludDY0X3QgaW5jciwgdWludDY0X3QgZmxhZ3MpLAorCVRQX0FSR1MocCwgc3RhcnQsIGVuZCwg
bnB0ZXMsIGRzdCwgaW5jciwgZmxhZ3MpLAorCVRQX1NUUlVDVF9fZW50cnkoCisJCQkgX19maWVs
ZCh1NjQsIHN0YXJ0KQorCQkJIF9fZmllbGQodTY0LCBlbmQpCisJCQkgX19maWVsZCh1NjQsIGZs
YWdzKQorCQkJIF9fZmllbGQodW5zaWduZWQgaW50LCBucHRlcykKKwkJCSBfX2ZpZWxkKHU2NCwg
aW5jcikKKwkJCSBfX2R5bmFtaWNfYXJyYXkodTY0LCBkc3QsIG5wdGVzKQorCSksCisKKwlUUF9m
YXN0X2Fzc2lnbigKKwkJCXVuc2lnbmVkIGludCBpOworCisJCQlfX2VudHJ5LT5zdGFydCA9IHN0
YXJ0OworCQkJX19lbnRyeS0+ZW5kID0gZW5kOworCQkJX19lbnRyeS0+ZmxhZ3MgPSBmbGFnczsK
KwkJCV9fZW50cnktPmluY3IgPSBpbmNyOworCQkJX19lbnRyeS0+bnB0ZXMgPSBucHRlczsKKwkJ
CWZvciAoaSA9IDA7IGkgPCBucHRlczsgKytpKSB7CisJCQkJdTY0IGFkZHIgPSBwLT5wYWdlc19h
ZGRyID8gYW1kZ3B1X3ZtX21hcF9nYXJ0KAorCQkJCQlwLT5wYWdlc19hZGRyLCBkc3QpIDogZHN0
OworCisJCQkJKCh1NjQgKilfX2dldF9keW5hbWljX2FycmF5KGRzdCkpW2ldID0gYWRkcjsKKwkJ
CQlkc3QgKz0gaW5jcjsKKwkJCX0KKwkpLAorCVRQX3ByaW50aygic3RhcnQ6MHglMDEwbGx4IGVu
ZDoweCUwMTBsbHgsIGZsYWdzOjB4JWxseCwgaW5jcjolbGx1LCIKKwkJICAiIGRzdDpcbiVzIiwg
X19lbnRyeS0+c3RhcnQsIF9fZW50cnktPmVuZCwgX19lbnRyeS0+ZmxhZ3MsCisJCSAgX19lbnRy
eS0+aW5jciwgX19wcmludF9hcnJheSgKKwkJICBfX2dldF9keW5hbWljX2FycmF5KGRzdCksIF9f
ZW50cnktPm5wdGVzLCA4KSkKKyk7CisKIFRSQUNFX0VWRU5UKGFtZGdwdV92bV9zZXRfcHRlcywK
IAkgICAgVFBfUFJPVE8odWludDY0X3QgcGUsIHVpbnQ2NF90IGFkZHIsIHVuc2lnbmVkIGNvdW50
LAogCQkgICAgIHVpbnQzMl90IGluY3IsIHVpbnQ2NF90IGZsYWdzLCBib29sIGRpcmVjdCksCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IDcxZTAwNWNmMjk1Mi4uYjVk
YmI1ZThiYzYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMTUx
MywxNyArMTUxMywyMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3Qg
YW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKIAkJZG8gewogCQkJdWludDY0X3QgdXBk
X2VuZCA9IG1pbihlbnRyeV9lbmQsIGZyYWdfZW5kKTsKIAkJCXVuc2lnbmVkIG5wdGVzID0gKHVw
ZF9lbmQgLSBmcmFnX3N0YXJ0KSA+PiBzaGlmdDsKKwkJCXVpbnQ2NF90IHVwZF9mbGFncyA9IGZs
YWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpOwogCiAJCQkvKiBUaGlzIGNhbiBoYXBwZW4gd2hl
biB3ZSBzZXQgaGlnaGVyIGxldmVsIFBEcyB0bwogCQkJICogc2lsZW50IHRvIHN0b3AgZmF1bHQg
Zmxvb2RzLgogCQkJICovCiAJCQlucHRlcyA9IG1heChucHRlcywgMXUpOworCisJCQl0cmFjZV9h
bWRncHVfdm1fdXBkYXRlX3B0ZXMocGFyYW1zLCBmcmFnX3N0YXJ0LCB1cGRfZW5kLAorCQkJCQkJ
ICAgIG5wdGVzLCBkc3QsIGluY3IsCisJCQkJCQkgICAgdXBkX2ZsYWdzKTsKIAkJCWFtZGdwdV92
bV91cGRhdGVfZmxhZ3MocGFyYW1zLCBwdCwgY3Vyc29yLmxldmVsLAogCQkJCQkgICAgICAgcGVf
c3RhcnQsIGRzdCwgbnB0ZXMsIGluY3IsCi0JCQkJCSAgICAgICBmbGFncyB8IEFNREdQVV9QVEVf
RlJBRyhmcmFnKSk7CisJCQkJCSAgICAgICB1cGRfZmxhZ3MpOwogCiAJCQlwZV9zdGFydCArPSBu
cHRlcyAqIDg7Ci0JCQlkc3QgKz0gKHVpbnQ2NF90KW5wdGVzICogQU1ER1BVX0dQVV9QQUdFX1NJ
WkUgPDwgc2hpZnQ7CisJCQlkc3QgKz0gbnB0ZXMgKiBpbmNyOwogCiAJCQlmcmFnX3N0YXJ0ID0g
dXBkX2VuZDsKIAkJCWlmIChmcmFnX3N0YXJ0ID49IGZyYWdfZW5kKSB7Ci0tIAoyLjI1LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
