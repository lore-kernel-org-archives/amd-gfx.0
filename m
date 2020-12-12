Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D637C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0516A22AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0516A22AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D616E86A;
	Sat, 12 Dec 2020 15:46:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B016E86A
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS2cLnI1hk94WzP887GnA3D7dvjWhXYj+K3/sUxhvAN/eIPiBTfJ+W0aEgEZqf/ghMjeAWwZ4HBWSXW2t9t/4HX/eZzGPgQoewADJDgH2R4o/tTE36ashLK6JuLa0S5cbGvG4kIh5h1wHqLAEstAPdgyuH7iHDzR7X9r4Ca2gWxSsCVS02wiqFriVFQ4SeQ88/yAAIYy9murqfkCfPzI0PBXcc/BX2KbvQb1Fi8oFzNf2lCgGnzUWsws9fhCoLuwPnoE1NpyRe0H4rQuTHSRtybB0vtDtJVoeeELiHbxc45HAOicj8Oe9CmrOB0qiBpjCEEutfZL0NM3/aofOMNtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCUqzVmfzoXz88VJIVQzBUoNTz/n64WPljzWPioxIic=;
 b=G3AR8XzbFtTDLonXWSTGgHj9YMOpq0Km0WSaLl4+zpwFX+ZNMbjV7T2/acFLstSGEJSLjQDjGKSOLNG71SS8MNBL/GJlv16wmxBnRGaMWEkn2Y0uf4Slv8wC568hKlAEaFdU+EPPK71a8b/4DDb+4Fesdvln3GNWNMF2kkO80TebqMZEkefHiZEpcyaiPx8Of0nOTe+eGUpP09H3zq6tPz4TfyMWNkd71DCzXnjwjjE/vyxTjiqqeHM51MD1r5IktAGteZoVHAdeC2Z9IFlVKzXMnpk8zRh3o+A0LblirAhOsdftc8KRyIUec/0EYx5Pkxsjb3ew+k54t3YO0BqE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCUqzVmfzoXz88VJIVQzBUoNTz/n64WPljzWPioxIic=;
 b=gpCp0ox5QTxq/Z+PeyoN7LqQvhepd/4ox24t42HRWA9a7bFtUgF93X4f0hIHnO3rhKRb4061smSslyMhZlA4FgqDTRnW9yJFuXIooaAiMhq28C0/VJHKXraLgHakVc2ugI7QAyNnSfmCu5cGvxgy1cF16n3TgYysP+9a2Dnvc7s=
Received: from BN9PR03CA0104.namprd03.prod.outlook.com (2603:10b6:408:fd::19)
 by BN6PR12MB1410.namprd12.prod.outlook.com (2603:10b6:404:18::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Sat, 12 Dec
 2020 15:46:36 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::df) by BN9PR03CA0104.outlook.office365.com
 (2603:10b6:408:fd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:35 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:34 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:32 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 09/27] drm/amdgpu: correct ih cg programming for vega10 ih
 block
Date: Sat, 12 Dec 2020 23:45:42 +0800
Message-ID: <20201212154600.21618-9-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b39765-7830-4449-1916-08d89eb51b43
X-MS-TrafficTypeDiagnostic: BN6PR12MB1410:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1410803D4CC78E94FAA4620BFCC90@BN6PR12MB1410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUohUUHXpkc2UsRNgVKMyNHU7y5irchAH/RBZ7amVL1QSEB9Rk6y/6mvbYJbSuViWT7qDh77Er69lkkWbRYVNeLWg5lVXdqqQ3KXlYJMeqpCNeWf1+5YN+L4sO0/Um0lBvuKK4PMohcZju2BOHSxSoGrzBncSSv3BxbOzucxhM43nfop84vsQl7hUzZI3YrS4XJjcyzRRKpOktWa0jK7mtezRlm881G0th+vJiUDLMJTZyenbjipdMq3pz7qSxih1ZMDZl7+PMZCNIApMaFBn6rOEapk4g8WZ1Iph3bKM8bLEe9TeQTuxp0gXml+/EvhvgS1ttuw7WdO/MEOvtkcDSwVv+P0HKDz9lxdCuHfWX9KRtOj/Non2V/AGne591msGfbMGTZ1J9WnczWkddQWWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(508600001)(82310400003)(186003)(26005)(86362001)(426003)(336012)(6666004)(2906002)(356005)(8936002)(4326008)(2616005)(8676002)(7696005)(81166007)(5660300002)(47076004)(1076003)(36756003)(6636002)(66574015)(70206006)(83380400001)(110136005)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:35.6126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b39765-7830-4449-1916-08d89eb51b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1410
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dmVnYTEwLzEyIGFuZCBSQVZFTiBkb24ndCBzdXBwb3J0IHNvZnQgb3ZlcnJpZGUKaWhfYnVmZmVy
X21lbV9jbGsuCgpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+CkFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KUmV2
aWV3ZWQtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWlm
ZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZlZ2ExMF9paC5jIHwgOCArKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92ZWdhMTBfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCmlu
ZGV4IDYyOWJhNDYwMTNhYS4uMzJjM2RkMGI2Mjc2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92ZWdhMTBfaWguYwpAQCAtNjQwLDE1ICs2NDAsMTEgQEAgc3RhdGljIHZvaWQgdmVnYTEwX2lo
X3VwZGF0ZV9jbG9ja2dhdGluZ19zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJ
ZGVmID0gZGF0YSA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ0xLX0NUUkwpOwogCQlm
aWVsZF92YWwgPSBlbmFibGUgPyAwIDogMTsKIAkJLyoqCi0JCSAqIFZlZ2ExMCBkb2VzIG5vdCBo
YXZlIElIX1JFVFJZX0lOVF9DQU1fTUVNX0NMS19TT0ZUX09WRVJSSURFCi0JCSAqIGFuZCBJSF9C
VUZGRVJfTUVNX0NMS19TT0ZUX09WRVJSSURFIGZpZWxkLgorCQkgKiBWZWdhMTAvMTIgYW5kIFJB
VkVOIGRvbid0IGhhdmUgSUhfQlVGRkVSX01FTV9DTEtfU09GVF9PVkVSUklERSBmaWVsZC4KIAkJ
ICovCi0JCWlmIChhZGV2LT5hc2ljX3R5cGUgPiBDSElQX1ZFR0ExMCkgewotCQkJZGF0YSA9IFJF
R19TRVRfRklFTEQoZGF0YSwgSUhfQ0xLX0NUUkwsCi0JCQkJICAgICBJSF9SRVRSWV9JTlRfQ0FN
X01FTV9DTEtfU09GVF9PVkVSUklERSwgZmllbGRfdmFsKTsKKwkJaWYgKGFkZXYtPmFzaWNfdHlw
ZSA9PSBDSElQX1JFTk9JUikKIAkJCWRhdGEgPSBSRUdfU0VUX0ZJRUxEKGRhdGEsIElIX0NMS19D
VFJMLAogCQkJCSAgICAgSUhfQlVGRkVSX01FTV9DTEtfU09GVF9PVkVSUklERSwgZmllbGRfdmFs
KTsKLQkJfQogCiAJCWRhdGEgPSBSRUdfU0VUX0ZJRUxEKGRhdGEsIElIX0NMS19DVFJMLAogCQkJ
CSAgICAgREJVU19NVVhfQ0xLX1NPRlRfT1ZFUlJJREUsIGZpZWxkX3ZhbCk7Ci0tIAoyLjE3LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
