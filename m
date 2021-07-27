Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D09C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 06:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685A460F4F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 06:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 685A460F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F400F6EA0C;
	Tue, 27 Jul 2021 06:28:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5926EA0C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jul 2021 06:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcqLZNgYgZFPsCBZeyNp5qbP8ZqCEB9NHgPPkzW+8AD/jGIqkXJwEQhwf+YnEuWXx1gHUoHbKbNC5Nidna3ESN4eSbusjsGDXVwfvy8rgvGhZ+a04do2iJsRylciIJO7e8E/BHLc7HsdK/BZaOeC1PBuXLUpJYXYKmLZuTMw9ytb5iEo6HNUo3a/YmP8LvRRR7YF0DAzJlHi/1x8/LgKqFhQS2NR7jJLYUjOw1e1vAG/7/A/j9HJV5wDbt1209/nxBr2VSYNXY6YSBk1ACPeeBIOafhYXF5D3KpOTAOr0QJjLXv/knur1gziAD7u+2dXPR4wC/4XlG/KpmLIZTiG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPRSo7/Upolj0RPwyRw4NZR30JkLo0E3nWmaf3ULRg4=;
 b=FmECAHpapHkNSCrRYjr9Tm662CTx9niYJkGztq2Ve2KYngYuZgNZQI51pwNqo9QILzOkWo2vdS0pRuDExVK54SGKC5BUIwAP7wJZGUbjhL7528+fQws7BKBUzA7aN2YO3RYtbs3WeawBFki5kASxrXfqO6P2/epl4r14KXNyGQ4NPcBYig3QNiqLsRpk+LjLDq74fUYumdbAYym5cBwbMlOvJpJxkCsDQzVzc+SzM1zIjhl2h3lzMZvClayQxSNBfF2TpKcIVg9kLwUdCHcSIanvaPEC87A5OVXFZ2EdS4y8mpfqYGh90ujTGNSi3VF5Sfk56zz9Fp6o4gH2x+Xf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPRSo7/Upolj0RPwyRw4NZR30JkLo0E3nWmaf3ULRg4=;
 b=O2ltYQcSvXdu70dR9BGy0Q1vyJQWh7djVEOrLxSOFQPD2H4XmFFZeslbOIQtpBjczFADAKMn28mvUdKj82SQOvjWoL21PzxkNyoxs+ngkFM99Uho08Rx+FMaIzA1RiJJkvcjWoTbEC4JFWnsLXhESNc2MWhGGGSZ094PoYpRrD8=
Received: from BN6PR1401CA0010.namprd14.prod.outlook.com
 (2603:10b6:405:4b::20) by SA0PR12MB4493.namprd12.prod.outlook.com
 (2603:10b6:806:72::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 06:28:20 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::1d) by BN6PR1401CA0010.outlook.office365.com
 (2603:10b6:405:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Tue, 27 Jul 2021 06:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 06:28:20 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 27 Jul
 2021 01:28:18 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix build error reported for some config
Date: Tue, 27 Jul 2021 11:58:04 +0530
Message-ID: <20210727062804.3654932-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09230eb3-7c8e-473d-9722-08d950c7ba51
X-MS-TrafficTypeDiagnostic: SA0PR12MB4493:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44937FA8E6BD3DC271D339A180E99@SA0PR12MB4493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3FVXjPTtul054DOskmVc4ZYdGpxWgXuWDpyd5oanfMNriGKqVi/EP/cwJuEeB2jQinn4c+J0Jqf9/wbeWrUA/N3EKYyrzkyvLGd5nyux8aWQQO0uvP0F+WPn3IrI48PSIgP8p+1ME8Ram9POkaGp9GIJCt0FjoNAuOh8hfDC6DpQDGRKqaoKzsLD7cnECQBllhuXyZstljAK7uhh/q3zuMyYzwh4PaDUI5sYbfsnIu5cMda1Thmo50YcYCiJ27KX4qMgQz/Zg62OfhSVKlqN+U5h96XU0TPXdXHSKCgeFzr5NXky2VumSTfgUTfkKZA9ArZqie8OzdHt8YdZPpKORvmjtQ3nBuRrFOxceqSzOr2jOGFIMsTR9/amuDbV9S8z8Qte09YSriGx2xKqVdmGVAHLAKX895KNEvTirh2oJvx+IQuYQ4qGZ0GZppSwHgN8gUlt3vd6/dn8aJRWvyiqq4+FM+GA4mRGP6uAo3Se1kCQN8dmU/uyVvzx1lInGHM+JfFqjt0Vzy6Ef46IQJ9YMxcFrsI3BnhGkO51KxTDOux9HLvi2DDV1rNIc6ESnLKKNKijbuCNUG0NTI7+zZ/xa31TArckz60SzdR6jWaTLgR5oUosOws+rZ4fxvdnuIHReXuKWuVgspCYcVcvH0xEQbMwpO92tCdKsS5+cGfxXYoebJvz6lheDb0yFnnDI67Vc1mrsZL0FALlROCBlyQNQLuZjkZZm2wjFuShyJzydbkI1eNVJrD003WJxeLPVDB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(336012)(81166007)(82310400003)(4326008)(8936002)(5660300002)(36860700001)(70586007)(26005)(356005)(6666004)(83380400001)(7696005)(47076005)(8676002)(1076003)(316002)(36756003)(2616005)(186003)(2906002)(508600001)(110136005)(426003)(16526019)(86362001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 06:28:20.3819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09230eb3-7c8e-473d-9722-08d950c7ba51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYzogSW4gZnVuY3Rpb24g4oCY
YW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmXigJk6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hY3BpLmM6MTA0NTozMjogZXJyb3I6IOKAmHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRl
4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogMTA0NSB8ICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBwbV9zdXNwZW5kX3RhcmdldF9zdGF0ZSA9PSBQTV9T
VVNQRU5EX1RPX0lETEU7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
Y3BpLmM6MTA0NTozMjogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0
ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KICBDQyBbTV0gIGRy
aXZlcnMvbWVkaWEvdXNiL2R2Yi11c2Ivbm92YS10LXVzYjIubwogIENDIFtNXSAgZHJpdmVycy91
c2IvZ2FkZ2V0L2xlZ2FjeS9hdWRpby5vCiAgQ0MgW01dICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pZ2MvaWdjX3Rzbi5vCiAgQ0MgW01dICBuZXQvbWFjODAyMTEvbWxtZS5vCmRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmM6MTA0NTo1OTogZXJyb3I6IOKAmFBNX1NV
U1BFTkRfVE9fSURMReKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikK
IDEwNDUgfCAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcG1fc3VzcGVuZF90YXJnZXRf
c3RhdGUgPT0gUE1fU1VTUEVORF9UT19JRExFOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4K
ICBDQyBbTV0gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3NvdXJjZXNpbmsubwptYWtl
WzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjcyOiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYWNwaS5vXSBFcnJvciAxCm1ha2VbM106ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDo1MTU6IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1XSBFcnJvciAyCgpDaGVj
ayBpZiBQTV9TTEVFUCBhbmQgU1VTUEVORCBhcmUgc3VwcG9ydGVkLgoKRml4ZXM6IDY5ZTgxZGIz
MzdjMSBkcm0vYW1kZ3B1OiBDaGVjayBwbW9wcyBmb3IgZGVzaXJlZCBzdXNwZW5kIHN0YXRlClNp
Z25lZC1vZmYtYnk6IFByYXRpayBWaXNod2FrYXJtYSA8UHJhdGlrLlZpc2h3YWthcm1hQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYyB8IDIgKysK
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FjcGkuYwppbmRleCAwYzI4MWM3ZjVjZWEuLjRjMWYyYWM2MWY5YSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jCkBAIC0xMDQwLDEwICsxMDQwLDEy
IEBAIHZvaWQgYW1kZ3B1X2FjcGlfZGV0ZWN0KHZvaWQpCiBib29sIGFtZGdwdV9hY3BpX2lzX3Mw
aXhfYWN0aXZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogI2lmIGRlZmluZWQoQ09O
RklHX0FNRF9QTUMpIHx8IGRlZmluZWQoQ09ORklHX0FNRF9QTUNfTU9EVUxFKQorI2lmIElTX0VO
QUJMRUQoQ09ORklHX1NVU1BFTkQpICYmIElTX0VOQUJMRUQoQ09ORklHX1BNX1NMRUVQKQogCWlm
IChhY3BpX2dibF9GQURULmZsYWdzICYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCkgewogCQlpZiAo
YWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQogCQkJcmV0dXJuIHBtX3N1c3BlbmRfdGFyZ2V0X3N0
YXRlID09IFBNX1NVU1BFTkRfVE9fSURMRTsKIAl9CisjZW5kaWYKICNlbmRpZgogCXJldHVybiBm
YWxzZTsKIH0KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
