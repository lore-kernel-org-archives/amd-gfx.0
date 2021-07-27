Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EBFC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 13:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F1D619F5
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 13:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91F1D619F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507E46E94B;
	Tue, 27 Jul 2021 13:46:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1596E8FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jul 2021 13:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIPpT6V1zKBAGAjsUMdMDst168iHNTdAmdyLYatjcAm6HQiE9D0TzGZW9jlaPMVFOSNkIbHdHkdxbi73af4K1mAmOlRzlapC7PWDMXQ8PC+qIuc5thjcCpzELDeyNdVep6RlyqpgCMm6+AV177WruKaayD2HL52GLjCbbYE+v/ssnRjVFLSVlvn2OnnWFgysI79ZJasKYnkrUbxzfSiR4kZWl31JLMalISF6EyaEA+uTctvp52MF3NZ1/hoEhYaANSLib2riSO/9bUyqa/9MlaF2fNVpZH4jmNOFNy0GTsB5ru1VBMJlFq8KeCzY0yM3CDKqlqIRybMmw+ASvhrsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5odkXT08Dt76AH2xmUzV+L1KBy6P570/BviUa/HPqA=;
 b=PSrku70EbFDVu2cfK2am+9JYUDLy1iQrVyGkjtw823TG/n7Py17WZ3x6Jqj8atMe3XPA0GpQ09EZOtzFi4gOODoLss73k55V5qHS2lv5pSq84WHuIj58DybYSJn9neGh5JuUiPTxn+Gpv+XuFswBArvQ491hkupcZAIkn5dgcdhFlhs/pvq6SsW4Uibv6NAZw2WN1ZgXpJdGhxwuVy2zcAcCnDTs/bZDXI4iZ4JgTT0EvfUFm8TC3DiEHvlHRpAjx4W3isINWnepaio2st9Wr9QLO4JFX1ODamuwXdl0cy5Arkn/72m2tYLTidG3JETiGdyN/SFQtHISrpeDrnv7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5odkXT08Dt76AH2xmUzV+L1KBy6P570/BviUa/HPqA=;
 b=KL+fZon294ra+Xvhf5HKF2DVstZOqRGUn8aDGtQzf/EfGGSy0P5uQURw1oLEqAZAuxMhHyqJoFSLPDkJdJm/DxMV0TPvBE+ElBctDxunBV1zX6LypgYvhIP4ewhgYfAeaqQOlqeJJMyiEiXpGcQGwlIAxMLx2RoMHat/8SsWsMY=
Received: from DM5PR2001CA0016.namprd20.prod.outlook.com (2603:10b6:4:16::26)
 by MN2PR12MB3104.namprd12.prod.outlook.com (2603:10b6:208:cc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 13:46:10 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::b4) by DM5PR2001CA0016.outlook.office365.com
 (2603:10b6:4:16::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Tue, 27 Jul 2021 13:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 13:46:10 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 27 Jul
 2021 08:46:08 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix build error reported for some config
Date: Tue, 27 Jul 2021 19:15:48 +0530
Message-ID: <20210727134548.714874-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 165e1765-8618-460e-8a9f-08d95104e469
X-MS-TrafficTypeDiagnostic: MN2PR12MB3104:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3104DE593F4F2D5DAFA4035D80E99@MN2PR12MB3104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNcU+YVFyvOoNemGDJgX05gcTW2BO+kFqLrfh6qb2KaF6mNE4dwl75ent3LrSg01W935Ap36Dsdfm9p3/UGVkdO8IfHa3OmnxIh5MQQk/pq0Cr3qDwl/Ovq4aX9sCZ3XfOPlxQbIZG3gTEkc3G6QyaVt67U0KWvjYrUu2JPo33PXKiKUeBiAHUnZJuSDqt/NhBw9WuEXfdcGPmz6LQe/nQRO+lrui129RCOITXTofeOtp3zxpsYWdugJHOnCl3+EZSPvEFhe46kGWpetH+GyZ+Ad/yxfmW4s4wb+BJS5jPNUdYZnqes2+9ra3StJCBq+xfk0PIuX+jpDeqQKc3h9XZwx93qsjuugXF11a6JnEUZfpzx+FfonuaQ5PbZ1BvTAoa8LlpaS53KvoMjyDRxF2C1E6WtddJH2SB+zPyoxsWyYewrQCe2OZzYyPYXOdVUnBgWLR3sZ7COsqJj0Sai8DNRmALZtNRW+mtO9M5Tx3r5XfxMYSZ790Jju6VkK7meDojKSrhQ3i42IQsIUUrJozN6l6a8x3JcDRdFFcceaLk55Cf64ngwowbRKH1Sh1ezCQk7GwHvXjAAdSmweJ2BQWKeDFUqHkO/+CowRtHWToU0/rsP6cLhELumwbAlCKRVcyrXiaOtXQz4A0D/Y9Y12E6SjvIlKGxF3Ijgodjvk6/235gGOhD33BHrUwGulL3hwfUuNaPkIm4Wky4AZ6Z1ajcLToEB/Gg2qZAve7nQv7uqNtLSEj7/kXlib8en7Nrn9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(356005)(5660300002)(316002)(110136005)(2616005)(8936002)(7696005)(16526019)(186003)(4326008)(8676002)(1076003)(86362001)(26005)(2906002)(70586007)(82310400003)(6666004)(36860700001)(478600001)(336012)(36756003)(82740400003)(81166007)(426003)(70206006)(83380400001)(47076005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 13:46:10.2477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165e1765-8618-460e-8a9f-08d95104e469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3104
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
ZmlsZS5idWlsZDo1MTU6IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1XSBFcnJvciAyCgpGaXhl
czogNjllODFkYjMzN2MxIGRybS9hbWRncHU6IENoZWNrIHBtb3BzIGZvciBkZXNpcmVkIHN1c3Bl
bmQgc3RhdGUKU2lnbmVkLW9mZi1ieTogUHJhdGlrIFZpc2h3YWthcm1hIDxQcmF0aWsuVmlzaHdh
a2FybWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNw
aS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYwppbmRleCAwYzI4MWM3ZjVjZWEuLjNkMGI2N2YyNTZm
OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jCkBAIC0yNiw2ICsy
Niw3IEBACiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L3Bvd2VyX3N1
cHBseS5oPgogI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4KKyNpbmNsdWRlIDxsaW51eC9z
dXNwZW5kLmg+CiAjaW5jbHVkZSA8YWNwaS92aWRlby5oPgogI2luY2x1ZGUgPGFjcGkvYWN0Ymwu
aD4KIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
