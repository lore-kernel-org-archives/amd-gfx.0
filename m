Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7039CC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 10:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B554205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 10:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S3t7Muof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B554205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68D26E3CE;
	Mon, 16 Mar 2020 10:14:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94386E3BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 10:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiUJQL42FvgTRjaoHKLRHDbs7T9RUeduNlu7hPFLq3RQaxNmBQ60vRgLkE8Jmwra4/GXVXhfQfwpHhK/XQqYi4brMXPJ4SXIiV9mUm+eP8nCDfBD1KbYa+TmA4uurS9zx3iV54CWE4DbnydvBSgQiKD5TmcsS1KPRY1qT9Jc4WzgnsEldZU7H5SKHH29N6QO71IHw0Rsk3YkwZQdkmWStrT7c/cXtc2EkPpwdcmNQHujNrewKMP+yspQIFuYXISFJGmtqMyUEj0/ZiWe8OCKiFDVJMNjE7atktL9RjOjBZaJJ84pLW/WfCwfTnnE1XCwOkh40j8tJqfPkp/cX9GbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql3jjBtzBzMeZQzYCT453anOlvwCiDZJ63JhHRio55k=;
 b=ll3slnc1gExHEgLGVMygoBfcTfhTDJS47jg1aIwPK4k4IzR5MWFnMFA0Oy4i9SKWdFe7bJ1UyvxAipnjzorV2qUkLf64OrZRNjrp3qg9Bx5uhH6NQWh6pCA7+YMZPfHICQ3+UzVTtJmicvrEnKloL5vlqpZMArBMXUy2BZaNQKC6Hl2Bf5b9HoIkhRCJ6aQ8lUD3JTIhwUT4N6gBCdkZlOq0S/mNenkU0VTNuecek/9HvMBue1cFAd4zrmiHDsMfbPsNjSCEXbvRB0otf11ty0YfHoEK0oxTIXgMzStyvOSqacr9lYebnuVZ511uACN0skNgCKxD1KXN8kjmMgx1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql3jjBtzBzMeZQzYCT453anOlvwCiDZJ63JhHRio55k=;
 b=S3t7Muofdxwbsjjb8QUAW5AeU75xYT8Q7tX8nZhvlELH3C/K/Fb0JBU5FutDrXS76J83OP09d7uoIGK/tGfU+Xi0esgx7+nPEYpKHKV7nWyqmBFXckrkY3lh6wfJoWkQl00aupQELtYfQG/5nfwEVQaB4fK231D+3XQJslWTUwQ=
Received: from CO2PR05CA0078.namprd05.prod.outlook.com (2603:10b6:102:2::46)
 by DM5PR12MB2518.namprd12.prod.outlook.com (2603:10b6:4:b0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 16 Mar
 2020 10:08:54 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::7a) by CO2PR05CA0078.outlook.office365.com
 (2603:10b6:102:2::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend
 Transport; Mon, 16 Mar 2020 10:08:54 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 10:08:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 05:08:53 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 05:08:52 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 16 Mar 2020 05:08:51 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: miss PRT case when bo update
Date: Mon, 16 Mar 2020 18:08:45 +0800
Message-ID: <20200316100845.1150-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(428003)(199004)(46966005)(316002)(336012)(110136005)(54906003)(2906002)(66574012)(1076003)(5660300002)(2616005)(6636002)(15650500001)(4326008)(426003)(70206006)(70586007)(8676002)(7696005)(26005)(186003)(36756003)(6666004)(81166006)(478600001)(8936002)(47076004)(356004)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2518; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31ad6b97-57ce-438c-482e-08d7c9920874
X-MS-TrafficTypeDiagnostic: DM5PR12MB2518:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25184ADADF0EC54A310F417AE5F90@DM5PR12MB2518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03449D5DD1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tzky8/8UBiZ966p/y2XVu77XThLRJYOJRGSDldszOBqfY21wz0arp9nJnx56uK3AoHWAOZjNEYTj4bECoCa5OmXuI52UbaMBSMlJ6cpu918UBIMs11jyf9/yZHVQeT711dEklQYVGbIJSq8l3Y7D54BYSeWaEPTFfYZwOb9XRBy4oia2TvEXJvdLp1+l+rGvtL1nMzGUjg5SPOfGuKRH2gRw3uEdqPuBS84MWG1ROm4S7dgyi13b8yzL4EGmZYiMeVtBjgg5QDjG0aNNJErJCmsDbQpIvNDoyT6OjwAjyzRruq2wQBCcSrQh/YJlc4AfwWATV/lRPzZvw9CBzZEc0ZF3bA+MSM65z3wKGHCP7cnyzLkEXVYUlfHJ+J4eLlfHDwgwajXly2e0ppV4KQcz4JaHd30ODZQf53PaHuA4y7TVU0fKfawwCNNkYx/lsWZVKuhTJk/J3MemYaoKIkwYElrtfDSllJ3SaIYPArOC1z9wFVF0+9MjLDDexjGGRnVLlN64bkdDEJ/G+90en/W5DQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 10:08:53.8881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ad6b97-57ce-438c-482e-08d7c9920874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2518
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T3JpZ2luYWxseSwgb25seSB0aGUgUFRFIHZhbGlkIGlzIHRha2VuIGluIGNvbnNpZGVyLgpUaGUg
UFJUIGNhc2UgaXMgbWlzc2llZCB3aGVuIGJvIHVwZGF0ZSB3aGljaCByYWlzZSBwcm9ibGVtLgpX
ZSBuZWVkIGFkZCBjb25kaXRpb24gZm9yIFBSVCBjYXNlLgoKdjI6IGFkZCBQUlQgY29uZGl0aW9u
IGZvciBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcsIHRvbwp2MzogZml4IG9uZSB0eXBvIGVy
cm9yCgpTaWduZWQtb2ZmLWJ5OiBZaW50aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT4KUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggNzMzOTg4MzExOTZmLi42MTU3ZjZhOWRjYzggMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0xNDQ2LDcgKzE0NDYsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9w
YXJhbXMgKnBhcmFtcywKIAkJdWludDY0X3QgaW5jciwgZW50cnlfZW5kLCBwZV9zdGFydDsKIAkJ
c3RydWN0IGFtZGdwdV9ibyAqcHQ7CiAKLQkJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkg
eworCQlpZiAoZmxhZ3MgJiAoQU1ER1BVX1BURV9WQUxJRCB8IEFNREdQVV9QVEVfUFJUKSkgewog
CQkJLyogbWFrZSBzdXJlIHRoYXQgdGhlIHBhZ2UgdGFibGVzIGNvdmVyaW5nIHRoZQogCQkJICog
YWRkcmVzcyByYW5nZSBhcmUgYWN0dWFsbHkgYWxsb2NhdGVkCiAJCQkgKi8KQEAgLTE2MDMsNyAr
MTYwMyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAogCQlnb3RvIGVycm9yX3VubG9jazsKIAl9CiAKLQlpZiAoZmxh
Z3MgJiBBTURHUFVfUFRFX1ZBTElEKSB7CisJaWYgKGZsYWdzICYgKEFNREdQVV9QVEVfVkFMSUQg
fCBBTURHUFVfUFRFX1BSVCkpIHsKIAkJc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9IHZtLT5yb290
LmJhc2UuYm87CiAKIAkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0
KSkKQEAgLTE3MTgsNyArMTcxOCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3NwbGl0X21h
cHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCUFNREdQVV9HUFVfUEFHRVNf
SU5fQ1BVX1BBR0U7CiAJCQl9CiAKLQkJfSBlbHNlIGlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFM
SUQpIHsKKwkJfSBlbHNlIGlmIChmbGFncyAmIChBTURHUFVfUFRFX1ZBTElEIHwgQU1ER1BVX1BU
RV9QUlQpKSB7CiAJCQlhZGRyICs9IGJvX2FkZXYtPnZtX21hbmFnZXIudnJhbV9iYXNlX29mZnNl
dDsKIAkJCWFkZHIgKz0gcGZuIDw8IFBBR0VfU0hJRlQ7CiAJCX0KLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
