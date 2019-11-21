Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B0C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 06:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0C32089D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 06:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0C32089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9831C6EACF;
	Thu, 21 Nov 2019 06:17:14 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820050.outbound.protection.outlook.com [40.107.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAB06EACF
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 06:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+6Zs4KCVJS9Og35QRKdm16Pp4GD3M/tyrt8tJ2MJenXcnyMSR2BUTyRl9JdKX9yO3LEQhQTwsGowNXJX5zjjemAYcgnTgCGKpQMp9HuBpVLNnixYm5U/Y4kewGHrlZxxi0gUBmLIW9m8GijaKBpCt/JANJNS+s0lvAsn9hxrqIkehb243QsI1YBIlYc7OjbHu+g+GX0HQllI/JhAeCFEF5Jmt7QpreLvnPg7IdmJqz0Ertq7SeCImOdziaePkg6uBCR1jXP7aesyKKyXncAMIbC7YumUJ4/iDA1JrqrKGCExlQ7YcJOfx26vQdcv0qCUFXWDLkqBbJ9O+J6IvLZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACvzqLbeNuVOYAq6icGuRTUfqV4MffWBx+e3RYD3Ch4=;
 b=BKbcOa/hqQwJEvpspD9YO/cOMymeE8G6swWrfCmOS1O6Nf57FwhBrt8vxABdkIOhDqgSkOQiSbL98K1Mb2GMU2bELM4vvBAuUisdgvq1K0Y7dzjrYiQP1B2+56c0Q5CzniLfxSzr2czMTgZY10R16CfUWhPlGB93mXh/ebUDC7oGp1lfc+6Z0N8w1LvPsYaZ+WqCcNhWFGoV6j4vQ9si/qmrvvZQUcYEXr2svaenQAkdwGGbP/1da5JR72nIEqsLDFJnIeP2M/5vBc5P1Ya188GHNsbKe9i09vR+aW9dP+gWz5WuJnrTawDpKqA5kuTLPXzSX9igqAAeCagIJioIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0068.namprd12.prod.outlook.com (2603:10b6:3:103::30)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 21 Nov
 2019 06:17:11 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by DM5PR12CA0068.outlook.office365.com
 (2603:10b6:3:103::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Thu, 21 Nov 2019 06:17:11 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Thu, 21 Nov 2019 06:17:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 21 Nov
 2019 00:17:10 -0600
Received: from ubuntu-mi100.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 21 Nov 2019 00:17:09 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus VF.
Date: Thu, 21 Nov 2019 14:17:07 +0800
Message-ID: <20191121061707.25958-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(428003)(189003)(199004)(2351001)(476003)(48376002)(186003)(2906002)(4326008)(1076003)(50466002)(356004)(86362001)(70586007)(70206006)(81156014)(36756003)(5660300002)(305945005)(126002)(486006)(8676002)(8936002)(6916009)(26005)(53416004)(336012)(426003)(51416003)(16586007)(81166006)(47776003)(14444005)(50226002)(2616005)(478600001)(7696005)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4065; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7326b41-7942-4383-7a65-08d76e4a71cb
X-MS-TrafficTypeDiagnostic: BY5PR12MB4065:
X-Microsoft-Antispam-PRVS: <BY5PR12MB40652EEB15F3EC5B1466C313BB4E0@BY5PR12MB4065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0228DDDDD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDRmWjYkxQOf6sxfKPgk4aUXUtXMdIujPkD4ZtBZKIfWWvshrSsia9moZpIIdoseBVGyv967uC1C8qt7581t+AomCf5gdPgV3mM9GaFIO1ECorTq49dTJNscgvSxTIdbWuUee7OyrKENlPkoj5j9ebanS7LeQMLM3G9zgOVtaTZXkBQ+i0YrpGcBPWC1nEpwzSRnOqQ8Ub9aclztx+PX/E0dd7/DHhSWtN2A+AUT85R5itQ5WDDGgr0SnO6LUTg8+esKsLEjN6A2vysHY7s1CgT6veUk/OyR8c/rlleYpwRRsVaOm0sqyqQqWrhbdhVGGtFMfINkO7S2/HnO5NABIQP8Fg3F1hBfV4Wf+FgnIPbqrQ4iDRddREJmdo66UrW8t6WuVzZ6MH9YFwuICpqrcF2yemJ0juV+nfu+kn4xLIzVyAzAayoPoBHF2zbBG3I6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 06:17:11.1600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7326b41-7942-4383-7a65-08d76e4a71cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACvzqLbeNuVOYAq6icGuRTUfqV4MffWBx+e3RYD3Ch4=;
 b=3XnDf0uClCzbyvE3Kz18sZqDUUeqq7579XvbQUPzevR8CnU8susZqwUqeMbKEpnqohwaz9UGSsL3z5uAo2EUS6RGdtKIiWI4r6V1plY8d9SOiSVtz69+XwwBr8LpYaxgdbWhdSRmDSD54FZKgqPTcsTouTQxVbkUkj3d0AXsY7s=
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121061707.fLNaLWvirqZI5XpMM70u47SiU9VOvYXdgcWTQJJc_Uw@z>

QWZ0ZXIgcmxjZyBmdyAyLjEsIGttZCBkcml2ZXIgc3RhcnRzIHRvIGxvYWQgZXh0cmEgZncgZm9y
CkxJU1RfQ05UTCxHUE1fTUVNLFNSTV9NRU0uIFdlIG5lZWRzIHRvIHNraXAgdGhlIHRocmVlIGZ3
CmJlY2F1c2UgYWxsIHJsY2cgcmVsYXRlZCBmdyBoYXZlIGJlZW4gbG9hZGVkIGJ5IGhvc3QgZHJp
dmVyLgpHdWVzdCBkcml2ZXIgd291bGQgbG9hZCB0aGUgdGhyZWUgZncgZmFpbCB3aXRob3V0IHRo
aXMgY2hhbmdlLgoKU2lnbmVkLW9mZi1ieTogSmFjayBaaGFuZyA8SmFjay5aaGFuZzFAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCA1ICsrKyst
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IGMzYTQyZDMuLmVlY2RlODAgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTE0NzAsNyArMTQ3MCwx
MCBAQCBzdGF0aWMgaW50IHBzcF9ucF9md19sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQog
CQkgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BNQogCQkgICAg
fHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BNgogCQkgICAgfHwgdWNv
ZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BNwotCQkgICAgfHwgdWNvZGUtPnVj
b2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9STENfRykpCisgICAgICAgICAgICAgICAgICAgIHx8
IHVjb2RlLT51Y29kZV9pZCA9PSBBTURHUFVfVUNPREVfSURfUkxDX0cKKwkgICAgICAgICAgICB8
fCB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJU1RfQ05U
TAorCSAgICAgICAgICAgIHx8IHVjb2RlLT51Y29kZV9pZCA9PSBBTURHUFVfVUNPREVfSURfUkxD
X1JFU1RPUkVfTElTVF9HUE1fTUVNCisJICAgICAgICAgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09
IEFNREdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX1NSTV9NRU0pKQogCQkJLypza2lwIHVj
b2RlIGxvYWRpbmcgaW4gU1JJT1YgVkYgKi8KIAkJCWNvbnRpbnVlOwogCi0tIAoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
