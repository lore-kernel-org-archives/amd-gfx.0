Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8CCCA9EBB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C45A20663
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C45A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08C16E1D3;
	Thu, 24 Oct 2019 10:10:20 +0000 (UTC)
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr780083.outbound.protection.outlook.com [40.107.78.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BD06E1D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 10:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsp1Rq3/CIjqRg0di6vGWLP/GJNtA4BQTj0BZ9PXgmebsa8oqwrYLsxhqHGoPlE0WzRR/B0duUd7Q6OwbkCsNQ4JchOyx0K8zAjamsMLpWVryHluvIVV2xxY9HWdKW9IVQwuu5eq7FjURCaYzMUN4MDx4tdtKdy85ecswJPWBcVZqZP+Z5rTEIW5Z7pCpfdhp+YvnS77vYLIUiN6FzgLKBNmc/Pz7MS3YjRq5Bd6+WWVKhwu7bs6xlPAlX0A0JZPSXXkXsNHHTYimHBqrYH/tBfMZEWBSsf6cHrznGN0Z6pDFdKSN2HVoUvpICmWHm95atf5z1JCK6GWLr4/4sDMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8revMrcxGbTfg+d2xbhWBcpEQmrPTjYaBQxb1g5ycfQ=;
 b=dihrF6eTozWOvhnXqBwl35niJQ8Dz3esKWdvJvSCGFN5XF0MsgS9b07BiTRRqPWxNXEpWBblbLPY6y+paXSoUJOK462iUySChS4tXF+l0T8QWgRAkRYoorORgVIi4sufCqDAhylToOii3VwgKEz6fzpgjUg/nWsWUTfXHiopvWgUGjhZBMHChtjhuaj+3gXM9zJZXPQHlZgkSwHJYmUM14alhPp1SQ89f9lnupgekEkJH1bozWUGW1HMl/Ez4P31NsIlIooz4cat145DSaMEB6PH8ThIa3k1wTRj0+XiS6bvRHjZU9MYxtrTteO2QaMQjDrR+3nRko2alP/OAW5atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0077.namprd12.prod.outlook.com (2603:10b6:0:57::21) by
 DM5PR12MB1369.namprd12.prod.outlook.com (2603:10b6:3:6f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 10:10:18 +0000
Received: from BY2NAM03FT016.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::204) by DM3PR12CA0077.outlook.office365.com
 (2603:10b6:0:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Thu, 24 Oct 2019 10:10:17 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BY2NAM03FT016.mail.protection.outlook.com (10.152.84.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 24 Oct 2019 10:10:17 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 24 Oct
 2019 05:10:13 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 24 Oct 2019 05:10:11 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/gfx10: update gfx golden settings for navi12
Date: Thu, 24 Oct 2019 18:10:04 +0800
Message-ID: <20191024101004.17247-3-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024101004.17247-1-tianci.yin@amd.com>
References: <20191024101004.17247-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(428003)(199004)(189003)(8676002)(2351001)(81166006)(50226002)(14444005)(8936002)(16586007)(316002)(81156014)(36756003)(54906003)(6916009)(26005)(5660300002)(186003)(86362001)(478600001)(76176011)(51416003)(70586007)(7696005)(4326008)(356004)(446003)(426003)(50466002)(336012)(15650500001)(6666004)(1076003)(48376002)(2906002)(53416004)(2616005)(126002)(11346002)(47776003)(44832011)(305945005)(486006)(70206006)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825f84f5-76d2-4509-427c-08d7586a5ed5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369E52AC7E5E728BD5C56FB956A0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0200DDA8BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzWd22ZjKpj+KkqVmMWGfX/VYZvnv25LLrfgMrzTg0Vf1c3s43vCRe+3h9v1mlO2xQob8vKeaV3sd59OH3GI4zuN0faRuhmIYotitMjZIHcJE0r2E7oJgXMmKRZ6WcHi+BGVSroyDTloGQGXvGhScI3Vnddi84Kp0OD4yVVSg/NdQP0+J6UKlcxv7jTq5iHd2r7JEGJJ9bd63fkX43B5u1tsRS1C9WsebWIkw5mkUSBc3OUYfa5CiAAeLYEu2vq4dLrObXAJltvIW35MQ08S8BmeY+exY7tmRxomgM+eIktCNt93suhiIPyENVaOc0Eyug1qh0/XfViWl5tjPwBJH48KczEolPM84ypGFg6L0jzOOzQN2IvYA5U65gNRFjQxBm5RFO9yzBOtA6m/OeizlNyejRaeDzhcoJSXu4516DORwO4Ep1559fSZPC/0kdwG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 10:10:17.5715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825f84f5-76d2-4509-427c-08d7586a5ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8revMrcxGbTfg+d2xbhWBcpEQmrPTjYaBQxb1g5ycfQ=;
 b=a+WihKTmwESYQjsSG5xQdBaPjD//qJm6o0VzvjEYCb8IY2SBXI6WhAs3JWYy3yYkQ4/PsE7Vtl38wHDbfjersdVUaMLyoMIgFX9XNQt6AnpnSFECMfCnNERP/GKhLZ8s/Mtj9mHVslkZelcmZFycexjAjiUuhNRa7wOjapPpNHM=
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Tianci
 Yin <tianci.yin@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024101004.2utj5BSZfej8id_xDpaMZbuyq1OO6QgDQQwlRNI95C4@z>

RnJvbTogIlRpYW5jaS5ZaW4iIDx0aWFuY2kueWluQGFtZC5jb20+Cgp1cGRhdGUgcmVnaXN0ZXJz
OiBtbUNHVFRfU1BJX0NMS19DVFJMCgpDaGFuZ2UtSWQ6IEkzNWZiMjViZTEzNDBkOGMwNjJlMGU1
YmZmZjY0MjAwOWEwMGQ1MmNmClNpZ25lZC1vZmYtYnk6IFRpYW5jaS5ZaW4gPHRpYW5jaS55aW5A
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggMjJkMGZhZGU5YzcxLi5kMTI2ZDY2
Y2I3ODEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0xNzksNyAr
MTc5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzb2MxNV9yZWdfZ29sZGVuIGdvbGRlbl9zZXR0
aW5nc19nY18xMF8xXzJbXSA9CiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1DQl9I
V19DT05UUk9MXzQsIDB4MDAzZTAwMWYsIDB4MDAzYzAwMTQpLAogCVNPQzE1X1JFR19HT0xERU5f
VkFMVUUoR0MsIDAsIG1tQ0dUVF9HU19OR0dfQ0xLX0NUUkwsIDB4ZmZmZjhmZmYsIDB4ZmZmZjgx
MDApLAogCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tQ0dUVF9JQV9DTEtfQ1RSTCwg
MHhmZmZmMGZmZiwgMHhmZmZmMDEwMCksCi0JU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwg
bW1DR1RUX1NQSV9DTEtfQ1RSTCwgMHhmZjdmMGZmZiwgMHhjMDAwMDEwMCksCisJU09DMTVfUkVH
X0dPTERFTl9WQUxVRShHQywgMCwgbW1DR1RUX1NQSV9DTEtfQ1RSTCwgMHhmZjdmMGZmZiwgMHgw
ZDAwMDEwMCksCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1DR1RUX1NRX0NMS19D
VFJMLCAweGZmZmZjZmZmLCAweDYwMDAwMTAwKSwKIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdD
LCAwLCBtbUNHVFRfU1FHX0NMS19DVFJMLCAweGZmZmYwZmZmLCAweDQwMDAwMTAwKSwKIAlTT0Mx
NV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUNHVFRfVkdUX0NMS19DVFJMLCAweGZmZmY4ZmZm
LCAweGZmZmY4MTAwKSwKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
