Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5268CA9EBD
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D6420663
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D6420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821D06E1E5;
	Thu, 24 Oct 2019 10:10:23 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A98E76E1E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 10:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV6yGOWon0K8k9IpVnyDS2a75SL+8FFBi1fRku9/+sE1tSAwUIFGMGUwozcRs1s09HkqlF5R0QtANxcTyiV8+GucLogARUGgAL5eBHdutPk0/um7JexjS1iXRWs08U0mlRPj8jdm/WOBT4Ujxretr0Qi8NEmaCd6r6gXzGSaSgLtUQtEfjIpXp4dPtBYiCpKYl5LA49CP/fe6+TUyCiXG6ERvorgzlY9ksdYgJf3ThrnSbQdunRLrPpeNZY0phspBBdHmRq+LXMht+BJdYQ7n5lBPurxRWx07sb+fp6FDRFluTWAnowKs/ipV+M5HfSJrqsHKhLn6c7jO8/nZDS//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QWPRynTwxvmb7TgRyAlxZACNpku7SjD0qwit1nlIIY=;
 b=EB8zrUvx1DzzM8EWV6GDAxIaySacGuaHTRHPr1lSM+J1+YkGOpVpw/qpFPTwFrYHfN9Nsw2ZOKTBAzmF80bJZl+iHK30+JpINKFE3M0sIObOOkcREi7tnuitT6e5yMrGBeVQIOfg7mi3sEPti9p+LNN7fgApqL3jCcGGPbZRpZ9ezleHrBKyJfTfdYrFSdqqTMfmV5QxE6Wr4tMzrrYYHZMnicr+GAI1JHGiG1r8XtNcERIQiVRTmi1jQJJEs7J4ra75uNNBipULHBw1TZpsZivaIB8F5tlqhXWhIh7HScCJL2TbALboFsvxLS3uz+9SUoT10/GHrHGxNbrAZ32HUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0077.namprd12.prod.outlook.com (2603:10b6:0:57::21) by
 BN6PR12MB1939.namprd12.prod.outlook.com (2603:10b6:404:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.24; Thu, 24 Oct
 2019 10:10:15 +0000
Received: from BY2NAM03FT016.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::204) by DM3PR12CA0077.outlook.office365.com
 (2603:10b6:0:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Thu, 24 Oct 2019 10:10:15 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BY2NAM03FT016.mail.protection.outlook.com (10.152.84.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 24 Oct 2019 10:10:15 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 24 Oct
 2019 05:10:11 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 24 Oct 2019 05:10:09 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden settings for navi14
Date: Thu, 24 Oct 2019 18:10:03 +0800
Message-ID: <20191024101004.17247-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024101004.17247-1-tianci.yin@amd.com>
References: <20191024101004.17247-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(428003)(199004)(189003)(8676002)(6666004)(44832011)(356004)(8936002)(47776003)(186003)(26005)(2616005)(126002)(476003)(11346002)(48376002)(486006)(53416004)(51416003)(7696005)(76176011)(2351001)(336012)(426003)(50226002)(81166006)(81156014)(5660300002)(6916009)(2906002)(446003)(478600001)(70586007)(4326008)(70206006)(14444005)(50466002)(1076003)(15650500001)(54906003)(36756003)(86362001)(16586007)(316002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1939; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f347e854-6b67-444b-6b80-08d7586a5d55
X-MS-TrafficTypeDiagnostic: BN6PR12MB1939:
X-Microsoft-Antispam-PRVS: <BN6PR12MB193963EADAFDEA11D65A91F2956A0@BN6PR12MB1939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0200DDA8BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gy7IkzewgYOsEAMa/NgjiYCArRC+0rfqVGMCa4LbRcfoTBuq1SMvQGRMoWly0FV9d8u243wVP19Tb2TAWKAzFTv5ny0PMyDP4EWSXUF55+FMTIiQy/st8Kpaz61Bx73uHBwZYzz0ZLJd8E5camKDr4xKyD79DgHLvTE97G8z0ZWSuIqCGYdeJOJ2O1ngA6ZSW3FwIAjDXemewk5TtyJEzyh2VUuTfBAFd13pmjoQ5gWGjoVy6U31E5KBjSAWYc/jvXDgjMudOcr7rXfxcP4kIguc+K2O9T1KWIRu3ZYgV3dmvw1/2GkHHR3Rk0VFgyp9VjgzJx4Vr7HD78neUZt1OYegbY2JpL3FjdAFI8lJoa9aPDnr52bJQ9PBssNfu5W1Poup9kY021ISp494XoASGCYySNtJCOhraVyavwV3YXyoiWr63aw31dd/dtpaMIdQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 10:10:15.0550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f347e854-6b67-444b-6b80-08d7586a5d55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1939
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QWPRynTwxvmb7TgRyAlxZACNpku7SjD0qwit1nlIIY=;
 b=OW4ejfCt7fHhZoP0kDjZGRglfDWn9dVtHEs3H3zJVaNNSCN0iQp2aYRbD6DChqwzhaQTTPqmjDyyD398OmYFQd/SnwCETcRmDDZ0Oo3lu9iDHA6DTb/ucQMbdQiZIvJZivCx5Mv+OZxifYawLa9rZmfLdoadnYpwRP3q0ReRSlA=
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
Message-ID: <20191024101003.G5t33OP4XOcT4zu694EFB0VfG2rZGHxVCpUPW-pkjJg@z>

RnJvbTogIlRpYW5jaS5ZaW4iIDx0aWFuY2kueWluQGFtZC5jb20+Cgp1cGRhdGUgcmVnaXN0ZXJz
OiBtbUNHVFRfU1BJX0NMS19DVFJMCgpDaGFuZ2UtSWQ6IEliMjUzOWFhZTFmYjBkMDAxMjc4Yjdm
ODljOTBhZDYyOTZmOWZiODVmClNpZ25lZC1vZmYtYnk6IFRpYW5jaS5ZaW4gPHRpYW5jaS55aW5A
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggMTFlODYzYzRjNDBiLi4yMmQwZmFk
ZTljNzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0xNDAsNyAr
MTQwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzb2MxNV9yZWdfZ29sZGVuIGdvbGRlbl9zZXR0
aW5nc19nY18xMF8xXzFbXSA9CiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1DQl9I
V19DT05UUk9MXzQsIDB4ZmZmZmZmZmYsIDB4MDAzYzAwMTQpLAogCVNPQzE1X1JFR19HT0xERU5f
VkFMVUUoR0MsIDAsIG1tQ0dUVF9HU19OR0dfQ0xLX0NUUkwsIDB4ZmZmZjhmZmYsIDB4ZmZmZjgx
MDApLAogCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tQ0dUVF9JQV9DTEtfQ1RSTCwg
MHhmZmZmMGZmZiwgMHhmZmZmMDEwMCksCi0JU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwg
bW1DR1RUX1NQSV9DTEtfQ1RSTCwgMHhjMDAwMDAwMCwgMHhjMDAwMDEwMCksCisJU09DMTVfUkVH
X0dPTERFTl9WQUxVRShHQywgMCwgbW1DR1RUX1NQSV9DTEtfQ1RSTCwgMHhjZDAwMDAwMCwgMHgw
ZDAwMDEwMCksCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1DR1RUX1NRX0NMS19D
VFJMLCAweGY4ZmYwZmZmLCAweDYwMDAwMTAwKSwKIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdD
LCAwLCBtbUNHVFRfU1FHX0NMS19DVFJMLCAweDQwMDAwZmYwLCAweDQwMDAwMTAwKSwKIAlTT0Mx
NV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUNHVFRfVkdUX0NMS19DVFJMLCAweGZmZmY4ZmZm
LCAweGZmZmY4MTAwKSwKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
