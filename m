Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4459BCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2368220873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2368220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D486E5F3;
	Mon, 28 Oct 2019 11:31:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EAD6E5EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 11:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9UXky6840AZC1F9TTfkV2fBw0mRohf9t54B5U/R/KGMZUQ91KGbyU7CqfQh91kyO0KvbQyQ4mGM9WuNQ0x/5Uz1l+ZHOtvo0hk8XhIMPKW1jm7yMvb2JBrm5My5NMDdcgWxibGTIG7JvSAyNhFi5VZrWb4jMfwWO3tJk7uNCppTNNnRY61VHU1uMkJrC5e3mUcuejpAOwmhTj0GFQ0yJGkgfi6SXHG4NdXM94kB6LbjeKe9oLTQK3pMadcCfiJadlqujszPTPb/ccuo5F/U0kDSeyxRcVUVAXKH8A2DlspVgf27ijlSEVyqwKVKlGjkdZNPqcmhf4SOs3K2XCqneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKWn5cOr9yAls4l60YUuYnvDkBn1RP7qqN0pvX+WCWw=;
 b=DnfUTvis+AVq92jz56R2fDnK0gSFwFfqOcY9gpuh++x98ud2wBqZjWI9UbCzPqrn2ZNJTnmwahAzCPJjQ/qpkZjN7UObAlYtyRDpm0oQZZ2PQEKkxtcr66+56x3CWluu2TYq+t2OaOQqs0qjPdE1I4UYyK/GKDv1PqD1L63Iz49o7e0Of3b2+/Uj3/yX2flt7HEQyEZfZvfjL0hDiCFRnEfJNXhsrutqNNf9Y+2gfPUOqjv3fw2/DNiYkME/EwHJc63rXD6FN20TC8boVe7Iyk4+aX5K7txjyG3xQRliPrN564ckuFT34bcUGUn4YzBJhvVHrH+in9U+3XZH2nJKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0059.namprd12.prod.outlook.com (2603:10b6:300:103::21)
 by CY4PR1201MB0261.namprd12.prod.outlook.com (2603:10b6:910:1c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Mon, 28 Oct
 2019 11:31:15 +0000
Received: from BY2NAM03FT038.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::201) by MWHPR12CA0059.outlook.office365.com
 (2603:10b6:300:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Mon, 28 Oct 2019 11:31:15 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BY2NAM03FT038.mail.protection.outlook.com (10.152.84.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 11:31:15 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 06:31:14 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 06:31:13 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: reset err_event_athub flag if gpu recovery
 succeeded
Date: Mon, 28 Oct 2019 19:31:07 +0800
Message-ID: <1572262269-14985-2-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572262269-14985-1-git-send-email-le.ma@amd.com>
References: <1572262269-14985-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(199004)(189003)(81166006)(8936002)(81156014)(8676002)(44832011)(305945005)(50226002)(70206006)(70586007)(4326008)(186003)(336012)(446003)(2616005)(476003)(126002)(486006)(11346002)(426003)(16586007)(4744005)(356004)(5660300002)(47776003)(76176011)(51416003)(6666004)(26005)(36756003)(478600001)(2906002)(86362001)(316002)(2351001)(6916009)(50466002)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0261; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c69dfbab-209d-41ae-deb1-08d75b9a57f1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0261:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02613B66C6039ED88DC9BCD4F6660@CY4PR1201MB0261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCaqVblihU6x2zTlnOPuJfK1PpAlK7eN62Y38t4COkpYhzf+T3LYqlvJPjzefamoyb1pP4TccZkjiNQsRI3/yS4QIQMDh73ih9MxEiEYFMyJmvXhfF+yfgfD6o8+jC0cy1TqhXK7iNtLyKX5eHZeLXypwKK40MS0iJjSui+vBYjcO0V2NxNddItVV2XpBN2Gx812Wc7iMOFhj+A627tJSZke7pbWGLkeyH7QUkKZ8/zq/Hvrgs/Ys5D4fOdVeegFoKLctIQnwGJ5r80TZRgJUOZ/oSih6kO80TOegcXlHQTjQXB+UkzWSGxwf931APFMhfDiIT4Je/sv0j4DJ61Eqg4hzdC1kPeyUrkyj1Gix9XUCP4/8fSZR1zNWvPo/UhkRSlJ2JXL0QEXXaz4QfRnHgePwc8RakAca6nl9eMAyuF2w4vPOpX7pN8c036Guo7p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 11:31:15.3453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69dfbab-209d-41ae-deb1-08d75b9a57f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKWn5cOr9yAls4l60YUuYnvDkBn1RP7qqN0pvX+WCWw=;
 b=Zkku4XrWvsGia2Iqa4JdmOw0WITQ9+VPDyL5ysLd4FOjUahzqVWCWKL2Hdk2PPmFO21Zv2C1TrpDNdjNlsVWOoE8CR0IcWJCYkAOkFSDwDcBmDqMB8sviXxwx4hFDFaOuGy1jgkEtaBtXOjHYhwfz71JSp+DO6gqS/fEN26Wg9I=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Le Ma <le.ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028113107.AJN3TehQj-lZW4L4FjW_Xa6LzYWDtW8cS3bgEx9zQUg@z>

T3RoZXJ3aXNlIG5leHQgZXJyX2V2ZW50X2F0aHViIGVycm9yIGNhbm5vdCBjYWxsIGdwdSByZXNl
dC4KCkNoYW5nZS1JZDogSTVjZDI5M2YzMGYyMzg3NmJmMmExODYwNjgxYmNiNTBmNDc3MTNlY2QK
U2lnbmVkLW9mZi1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMK
aW5kZXggNjc2Y2FkMS4uNTFkNzRiYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYwpAQCAtNDA4OSw2ICs0MDg5LDkgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1
X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCX0KIAl9CiAKKwlpZiAoIXIg
JiYgaW5fcmFzX2ludHIpCisJCWF0b21pY19zZXQoJmFtZGdwdV9yYXNfaW5faW50ciwgMCk7CisK
IHNraXBfc2NoZWRfcmVzdW1lOgogCWxpc3RfZm9yX2VhY2hfZW50cnkodG1wX2FkZXYsIGRldmlj
ZV9saXN0X2hhbmRsZSwgZ21jLnhnbWkuaGVhZCkgewogCQkvKnVubG9jayBrZmQ6IFNSSU9WIHdv
dWxkIGRvIGl0IHNlcGFyYXRlbHkgKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
