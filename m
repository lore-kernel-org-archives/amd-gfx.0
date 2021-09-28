Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14765C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC96861266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC96861266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF3A6E8DB;
	Tue, 28 Sep 2021 16:45:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1E26E8DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSYIxy06BE1S1gey0q/5AgZ0SrqYXoeOMiNXbJRCXEWIFebM05ifJUyw1vU3W8U6CivuTEc09EyYcoSoMrx2k4Mv8pZMEHhWLRMXSYReLbk+4ZeubXSeHzLxc3wBn2CI4+8SMjbbqC4JO0dotaNLLCh44FOQkJPqj6k+JRJHpfiQWkiECLRLy0/7lFhBFuLrizAMx41wvlxXpSQ9sFuirRSUYo0bE3+/V8xIxJm3NB+nrjjVnrXerOhDvDncOQsKW0ziqzd8ayvgCxRDl1rw9cgOM5UtWsclKuPBkqtiKNJiTJyQumz4oPaGiuNb7duX9wSz/CITaziVvawaWgqMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qsVoKjVJkbxRmlZdtFpAesszMqYufcXYRtRApBW9VKU=;
 b=Bdz4Seu4mN30VAV0A3GOFQElCqvTxeDqKxu7RPqId457R+E0M/dxmP57P0zaRP8aovmh3zuZTu3A5U2p410AzZKEOby2Sdvrt61L5VQGEpdAiAnpUNFtYyKrZfObDsxOYQMPlmWCJeGZgyUyGKae/c4aYzWlKu9JRMD8k9bek/e29C0cok05Jz1rS/+WxVGHUQpqDW5AvYMyMwGb9S2XS/C1h4diF5Un9rZFX7JwSjKfljvTxUguhmTVezDdd8owRjnz6B904hpcAlfzozNGBe/ds4DgJH8tbO/tFNp5dVL6T6Tl9VZxccBTBAIXvzoKZH7hfJ4HhZZtRk6SVNMkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsVoKjVJkbxRmlZdtFpAesszMqYufcXYRtRApBW9VKU=;
 b=JNrT55BP5v+3v4GD3l2omJutoKu2ddN92g3s3grjA79jvXE45AEwE2RIKiMhYt0tunz0bQi/u0rofUc56fZrmfZTdLourQ3Jie0ki5yeCIT3y8iUautP3q42QWNFUKEgdrjYYVclCAskOVVNjnWFbYcsuZPdg1MZWA5swenFFjA=
Received: from DM5PR15CA0033.namprd15.prod.outlook.com (2603:10b6:4:4b::19) by
 BN6PR1201MB2528.namprd12.prod.outlook.com (2603:10b6:404:ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 28 Sep
 2021 16:45:33 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::f4) by DM5PR15CA0033.outlook.office365.com
 (2603:10b6:4:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 42/64] drm/amdgpu/psp_v13.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:15 -0400
Message-ID: <20210928164237.833132-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 722cc0ff-0dae-45e3-f50e-08d9829f62f3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2528:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2528D1E3E9231B9DA638C81AF7A89@BN6PR1201MB2528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iOOY8++9zGfgRyn0OOj2M64n91OaILCCtFD1dhb//Ruhnn3hhdhea295O5y2rD/5h6F/TrpMUyNoondwumrdp6rXiMWzqoh3SRFK02TEwakCg4c1IwkkEPAoxDfB2+J8HdXaOgc1mgUfOuk+l9l7OAydgcdH9x47Up0sWTEVBhoupQLIiqn8HWudQzyzPdMEizxuzaotBzuyQHtLYrASZ/lydYQrWdcvWLwRDry+1BWK6aXCT1Ol1cLAstOsd0nStF5OXGjlwDG1dVwlR+8hZ02+r9jEEXmcvAIJpzHAPdHp0Oqw5vYMBrkCud6hmfVBJqxiFipb2BO7foY8OO7tbWhOCKwPfQDARWAiGWvzgEBub0wIdqo8q6ABHUQlC8ar6hwbUCxfs3pyA+DF2EAUGPF9MKYFgTnmcKPUiIa+/fKUCd8eozWiPWkCMhpSZVnHoQ/Cxn5wUPAoTkbKCOkOU+CzfQovLUH7f9baFHhH9frXU2hSGZSfRs8ioTSsm13o/mMrSddd7H7S8gR1HLAseypcY2Yxm6yvo3gKGe5oiIunuR3KdGib1shEqcsA1HeTTn0KQ+8rWWEgnOloOhcBxtj6HX4lhuVjZ27O6XulsDQ01ufFbS0bzt4JzfKzh/GpyUxo2qY7LeU8izPuCU45qI7D5wTNJuSmY5sYpK1QLwdWN7Y/lIwiU5aPkR8OTJJUkGyT/gNkpuxkxxVceolJwWj/mhmGl8nDi08FfgXN54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(8936002)(16526019)(8676002)(83380400001)(6916009)(186003)(356005)(81166007)(36860700001)(426003)(36756003)(70206006)(2616005)(70586007)(86362001)(26005)(336012)(82310400003)(47076005)(7696005)(54906003)(6666004)(1076003)(2906002)(316002)(508600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:32.0202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722cc0ff-0dae-45e3-f50e-08d9829f62f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2528
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 47a500f64db2..64b52c5ea981 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -47,18 +47,19 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	const char *chip_name;
 	int err = 0;
 
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(13, 0, 2):
 		chip_name = "aldebaran";
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		chip_name = "yellow_carp";
 		break;
 	default:
 		BUG();
 	}
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(13, 0, 2):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
@@ -66,7 +67,8 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
 			return err;
-- 
2.31.1

