Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB966C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 23:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F64A20870
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 23:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PE8fpX1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F64A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C1C89FDE;
	Wed, 11 Nov 2020 23:05:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3992689FDE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 23:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PW2mx5w0JAsp6MWZDIFZrqnqe8L/40d1Fs9gH1krcLpLfhjGOgP0ofbqFGMZ2vXrcAQkETCIIa/WwJI4Y4VTlNiz/0DvH+CCg6o+5xAMEegiDVtUSkUnFKZ8xfQoBKeF2VoGhkY0wnks4yGClFFyJmBVk2JjdvpA3gW4OU39p5x+pVbPo+An9osKTWZfnrUjLAqJd2z/lLj3OhQOovYCqRBD75WJue6AmNHb1BXSvmXQ7Ixd5qZNOXHxmKwIR9/ocqWSRMnbhgki3I5SP482YrJk97zA0u8LZQPm1ByHicxfy69LQtv6BenmrQGopf1uYfHGgJAxJ2agtNadEj5pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze7ICCsQDA5Ndne8qEsK4YB3cXrSK5xqHzKvcYTQhZo=;
 b=YlkQOju8+ut2u6ak7BPd9DN3p4ClIYr/R7QFCf4WpxhUPvflIw+F8BrEUUPa2Zq90D6TGiiE4cqAjKSEcqUbcdSQiczAVJVbeel40294/wunwQA5qEVhKRE/BtapvkJhybiHbKhyzoDL5OO1Xvnox5+M2lbv3I+5wvc+QR3c65O4BIrW2rzsVpLN2KgdrtQ2CZ9EPOMl85+c7xQFcOUU65qGeZkDEl39Ov5jyqyGjYC7Bk5Lp8XdJ9rZGLIWLDxbM357+zntut2HrNXl21UYTGWkFQptVoCj4G9ruXrBz4ipsloF6cHW9wmT5AxVqNBvuzL/gvstRACFX5LcBicWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze7ICCsQDA5Ndne8qEsK4YB3cXrSK5xqHzKvcYTQhZo=;
 b=PE8fpX1VuJzJ3W1+uJmMJivwkQjK5TnK53Rhiuvouk3dKfcaN7h3bS3Aq3Qp/og/braBILngGxOojwHjhVAo86pXTwx4I1sr6/TA/qcZAmfRmdHa0yUqEDRs7Bv67xjA60MHa1VdoZP9+AVfAsIhcUhnBgTRzPcHSk42AYF1hvE=
Received: from BN4PR11CA0004.namprd11.prod.outlook.com (2603:10b6:403:1::14)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 23:05:18 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:1:cafe::bc) by BN4PR11CA0004.outlook.office365.com
 (2603:10b6:403:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Wed, 11 Nov 2020 23:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Wed, 11 Nov 2020 23:05:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 11 Nov
 2020 17:05:16 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 11 Nov
 2020 17:05:16 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 11 Nov 2020 17:05:16 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>, <john.clements@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use PSP_FW_NAME_LEN instead of magic number
Date: Wed, 11 Nov 2020 18:04:43 -0500
Message-ID: <20201111230444.180991-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6cf2ca2-6f48-48b8-2579-08d88696415f
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47894839A158718EB4C0374BF9E80@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9MkhE62s3uPEMjGkPhPGxGIidA1VTZwVIjzqZrFXgKI/1qgB9lR3dE+UKIbvzGeJMHf5bglGu1hql8m8DTVDI3uGg5pnB5imovHnkYQ5ntskqMICjh3WhrLSpj4fkWL6Jz3VHaztKdpxjYb/imfFVRfifVzKVqucHx5BRQrNkgSJNxejJqfcT/wThLWTamNYF6e6emOlhUmcOyP65HLOEWAmHTtiWGmeq696hSgJbaJ4Vf5sTS1qwzaCjBTv2gVr3bJNW9ufDtJH3U0VKr7GNWYfpm92RRr2KYDamY2YIDo5Hf7FI9ef9RfYiHUSBa1r8UhYrOjm4q6KAWEckZb/ppihvCvy5RjBmy+h3xaENEROcR7oSFJIMjTI1wl7N4Y+W++7V/qUu6v+rbTm880xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966005)(1076003)(47076004)(478600001)(4744005)(7696005)(81166007)(54906003)(86362001)(110136005)(316002)(6636002)(70206006)(4326008)(5660300002)(82740400003)(70586007)(83380400001)(2616005)(36756003)(2906002)(6666004)(186003)(8676002)(336012)(426003)(8936002)(26005)(82310400003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 23:05:17.2436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cf2ca2-6f48-48b8-2579-08d88696415f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, nicholas.kazlauskas@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2b0a2b93994b..74cbaf212698 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2631,7 +2631,7 @@ int psp_init_ta_microcode(struct psp_context *psp,
 			  const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[30];
+	char fw_name[PSP_FW_NAME_LEN];
 	const struct ta_firmware_header_v2_0 *ta_hdr;
 	int err = 0;
 	int ta_index = 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
