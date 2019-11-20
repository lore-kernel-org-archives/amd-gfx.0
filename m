Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2FC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81DD22429
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81DD22429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874676E17A;
	Wed, 20 Nov 2019 10:49:48 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00C46E157
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 10:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+Zlc7gmfCo3cII+3JUOwYOF413Ljr7bpNBaB8Tbi3NrTds/WSbBmXRyph1uysE8Bck5nz9ezIV4O4IhYHB4QY7+oL6Xn9Z6meXyBGz/b8B7BUDMjx/SDAy7R5zvsHA+OaDx4fIM/GyozIoCoZFvP2Aap2JKvVvMnUXen/ORSHnnyP1rGC/9j5/3vtGzdfv321Fb54nQZlK0T7nC7sG5v71/eP2+y+5kQgz/ReN2TaqBcs/7osjSPAPH4DwT0nAzM7R5j6rJs17GI1k+I/FmRyjSE/Pr8OCcLQsiWYBDb1Nx0a0XWAvBvtQfJOF+Wck/s6JCgrZjplEDEBEfTFem0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5hiv2uy5hfbgqrg/jsC9bgwEZsZCzcQl67bo747Cz8=;
 b=R6szJqKyEgWoXoTBudfbWCrxWNeR/wBCnGQASOjIf9cTm5b5lb084TS5lbL+Cc+uwLNEDsk/lfCo+4Wgx5V8iKRhl3D4ISsjRczqyRz+PMEHax5ohqAK12BooBeBaRCrqJijOF3rNf97uMF9I7QDzrx+re34MfewRY2Fk8LbX+RBcNjq7eJ85E1URVdblKEYZnhpISzw+3kZUayJZx+9l6tciaSLKSk53RaW8VgR7kmRrw+y2MG3nrGBKp/o59OYMvrYOo0S4d/9ARz3GE1akdW/diquLKTTNGlTpKHJH+nBUKmebN8SqTN2zmwSz+7ynAy11i+uQ8Ad5Wv2sepoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38)
 by DM5PR12MB1275.namprd12.prod.outlook.com (2603:10b6:3:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26; Wed, 20 Nov
 2019 10:49:44 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by MN2PR12CA0025.outlook.office365.com
 (2603:10b6:208:a8::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.16 via Frontend
 Transport; Wed, 20 Nov 2019 10:49:44 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 20 Nov 2019 10:49:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 Nov
 2019 04:49:42 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 Nov
 2019 04:49:42 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 20 Nov 2019 04:49:40 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH v2 0/3] RAS support for mmhub
Date: Wed, 20 Nov 2019 18:49:29 +0800
Message-ID: <20191120104932.16257-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(428003)(189003)(199004)(2616005)(81166006)(81156014)(50466002)(53416004)(356004)(478600001)(305945005)(14444005)(316002)(126002)(6666004)(336012)(48376002)(26005)(1076003)(50226002)(8936002)(4326008)(2906002)(36756003)(426003)(8676002)(16586007)(5660300002)(86362001)(51416003)(2201001)(486006)(70586007)(47776003)(110136005)(476003)(7696005)(186003)(6636002)(70206006)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1275; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffa35ee2-0a6c-4ea6-d58a-08d76da75a3a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1275:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12753C99D4E71C478A838FEAED4F0@DM5PR12MB1275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvYJ1O+xI7r/cAUdFZMJPpCHxAJccZPn920Xrin43nJ4L99dLJUCKmWR+qYRzgZQH+tnSPtv6bdfbZu8GgBb/p1+otG2Ykk4LY+Q0iD/6V/M/uQAMIekMyToCQcexXiQ3PnMsnpHc+suT1c05dwnR127Ljq7XvRTLuQslnRc0txSwEICOQCJSgP8tUSEr1ZQUwUXV+ygX5BC4h2MjLYQxezVfnkO35pCUXl8kT5lVSgFg9Abb8oaC+T9SRT864stZ9c4Gc7Bu3rauct6Mi9Nz7AJcDTE6WLkWIdKY9RIyRBaqs86hWHeacCeyQ5LynTVLkFMG8v/0sibwdg/6EwdZEkzFRARe9N6vyqOSaEtBlvAhxD29xyxWYDc4QS/ZWsgKYac2hyq4r09i4qZPY/wbR8vzvrOjjUyehDqrPDgq4gg6BexabucOHt1FNux5kRm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 10:49:43.5393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa35ee2-0a6c-4ea6-d58a-08d76da75a3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1275
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5hiv2uy5hfbgqrg/jsC9bgwEZsZCzcQl67bo747Cz8=;
 b=E4O92qeWQ99QXdDoqSwS/fMn2s9KdSD52iAn0Vn8Q1N34OAmauEpyEWmvPqPBrrqkcaCXWHZTLnLYoq0CVcC21x5qNsvs6w6vpSjubw9e0abPe/CaLFtNDzvzFkf9TSWu7bgARoYAfgf9F2PJBMBPpMA+VgukR4AZ3fIozUHJ+8=
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120104929.TEvhaqNeeG3iPmnrqqgdzKvgawfl5aiPWvkgOcPucuw@z>

VGhpcyBzZXQgb2YgcGF0Y2hlcyBpcyBhIGNvbnRpbnVhdGlvbiBvZiBSQVMgZW5hYmxlbWVudCBw
YXRjaGVzIGZvciBBTURHUFUuIAoKMS4gVGhlIG5ldyBzdHJ1Y3Qgc29jMTVfcmFzX2ZpZWxkX2Vu
dHJ5IHdpbGwgYmUgcmV1c2VkIGJ5IGdmeCwgbW1odWIgYW5kIG90aGVyIElQIGJsb2Nrcy4KMi4g
UmVmaW5lIHRoZSBxdWVyeSBmdW5jdGlvbiBvZiBSQVMgZXJyb3IgY291bnRlciBmb3IgVkcyMCwg
YWRkIGNvZGVzIHRvIGhlbHAgdXNlciB0byBsb2NhdGUgd2hpY2ggc3ViLWJsb2NrIG9mIG1taHVi
IGNhdXNlIGVycm9yLgozLiBJbXBsZW1lbnQgdGhlIHF1ZXJ5IGZ1bmN0aW9uIG9mIFJBUyBlcnJv
ciBjb3VudGVyIGZvciBNaTEwMAoKdjI6CjEuIEZpeCBzb21lIGNvbW1lbnQgaXNzdWVzLgoyLiBB
ZGQgSVAgbmFtZSBwcmVmaXggZm9yIHRoZSBsb2NhbCBzdGF0aWMgdmFyaWFibGUgYW5kIGZ1bmN0
aW9uLgozLiBNb3ZlIHRoZSBFRENfQ05UIHJlZ2lzdGVycycgZGVmaW50aW9uIGZyb20gbW1odWJf
OV80IGhlYWRlciBmaWxlcyB0byBtbWh1Yl8xXzAgb25lcyBmb3IgdmcyMC4KCkRlbm5pcyBMaSAo
Myk6CiAgZHJtL2FtZGdwdTogZGVmaW5lIHNvYzE1X3Jhc19maWVsZF9lbnRyeSBmb3IgcmV1c2UK
ICBkcm0vYW1kZ3B1OiByZWZpbmUgcXVlcnkgZnVuY3Rpb24gb2YgbW1odWIgRURDIGNvdW50ZXIg
aW4gdmcyMAogIGRybS9hbWRncHU6IGltcGxlbWVudCBxdWVyeWluZyByYXMgZXJyb3IgY291bnQg
Zm9yIG1taHViOS40CgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgICAg
ICAgIHwgIDM0ICstLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAgICAg
ICAgIHwgICAzICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YxXzAuYyAgICAg
ICB8IDIzMiArKysrKysrKysrKystLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1
Yl92OV80LmMgICAgICAgfCAyNTMgKysrKysrKysrKysrKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L21taHViX3Y5XzQuaCAgICAgICB8ICAgMiArCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5oICAgICAgICAgICAgfCAgMTIgKwogLi4uL2luY2x1ZGUvYXNpY19yZWcv
bW1odWIvbW1odWJfMV8wX29mZnNldC5oIHwgIDE2ICsrCiAuLi4vYXNpY19yZWcvbW1odWIvbW1o
dWJfMV8wX3NoX21hc2suaCAgICAgICAgfCAxMjIgKysrKysrKysrCiAuLi4vYXNpY19yZWcvbW1o
dWIvbW1odWJfOV80XzBfb2Zmc2V0LmggICAgICAgfCAgNTMgLS0tLQogLi4uL2FzaWNfcmVnL21t
aHViL21taHViXzlfNF8wX3NoX21hc2suaCAgICAgIHwgMjU3IC0tLS0tLS0tLS0tLS0tLS0tLQog
MTAgZmlsZXMgY2hhbmdlZCwgNTk4IGluc2VydGlvbnMoKyksIDM4NiBkZWxldGlvbnMoLSkKIGRl
bGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvbW1o
dWIvbW1odWJfOV80XzBfb2Zmc2V0LmgKIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvbW1odWIvbW1odWJfOV80XzBfc2hfbWFzay5oCgotLSAK
Mi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
