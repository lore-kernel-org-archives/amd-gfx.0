Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB3C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 06:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AABF60FE8
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 06:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AABF60FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFE088AC2;
	Tue, 18 May 2021 06:28:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6616EAA0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 06:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0YLMrlKeZQuydxebtzX07h524Nc6DBJWSLw7YYeq1KfTxikj5o0cO2Tgr5dK0dRqPTktsMBycNxR6nte8vtpr2KtClYdf7TyBfCq9Z4Dys0rwsqGNtg6tykw93mOBls9e8q+sfA5QDGBb+DWzAnuddsUyKKq9+JdUFvRiSJNX46k+VAKVroQ7ytux6l8gffW/mFixgfFjS8m3U8gyUXGwb7DFRuwlNauzXb8Q8YSxNKblL/oY9+iGdyzDRs8EPxZgXEW6mmWN8PA0nksyy1+uyMwKY4RuQ274jx0JTL2sKFOiSHOauAHZERz6Yr+huf1JHsPlxDXJbI3M+873pb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZJ87Zen/cPdgHhD2PglhYbJukYgxRWyGzoOoUkJ56M=;
 b=V+0tyg9P8s18FB1vFcmf9X1DcIuLXcoQA4x/WwijT7BYPtOvJhveOpVO3tO9FoTYLL5OU3ZU8vuSnNPTgvTDntqkB157vZZoG/AfvMv3UTqlA8mKBmYrJZ3z+OiIGZfCV90fnba3/Mv4GXUrzLaRZzaUYaiId1EhqhLIILZyO9Gqwggi2H5Cm1T7PGHcK4//sRFRHf0YMX53m7R+fyLiPUTmqkTkdK1k1lSv4uZAOeqAQqvTvsT/Loth/858Zhc+JrweCMnK5Ao13oqnLg0/OwBHKPQzYqXza1RcV36DxaXCzvCtIFXkZ4poFgsaZz/Qutai1l8fjIeMWf0SOKxHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZJ87Zen/cPdgHhD2PglhYbJukYgxRWyGzoOoUkJ56M=;
 b=mqJ/7LcAAUZY/FEhBX6cSuOWdRSW2ouvzLmuhSJZ1OzhB4KcBiIhCGoDjkpJCw3ZcgHSpBxu3ltbUAwPLxZrI0yC8Wg0YY30vOHin7WLDzycpKOOB8HEeaDKkHyMI+Hao2cdIvix20NnR1Zq4I/swzgwcpOyyCStlBDkiaDcVMw=
Received: from BN6PR14CA0045.namprd14.prod.outlook.com (2603:10b6:404:13f::31)
 by DM5PR12MB1498.namprd12.prod.outlook.com (2603:10b6:4:f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Tue, 18 May 2021 06:26:22 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::88) by BN6PR14CA0045.outlook.office365.com
 (2603:10b6:404:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 06:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 06:26:21 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 May
 2021 01:26:19 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: modify system reference clock source for navi+
Date: Tue, 18 May 2021 14:26:03 +0800
Message-ID: <20210518062603.1357891-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abba25fc-9fe8-43bb-fe9d-08d919c5da8e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1498:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1498D22183A03763B03D132DF02C9@DM5PR12MB1498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf3CtI00oVmwrqVIVuDYmpZaP9X7tUtbaCqPC7cF0gudh31oha+wjRX2z3g6+MdIz7UD/R8JtCEyPoo9Ea5QlgazpucNLG3Ku9VpP43eHt3ZfwjP+m56dhu7s8BINUEqKBo/pjWQHh0ecvrXOKo/67Gv/b4QW7S4l1kVctGAw/eja8skf31DFlF9Bfi1a9Ue/34Efbh6hod9h7CCBSq2BL+1tm4uqZgXikHsAmIqhRksDLNqOqEaZdJ7nJQA+qdCXn+reA8PHH2duWwKIEhXd28mZGU+vJORxKinN3RZ/omPEkTPTgz5kV5GOIN5AVSgWXfzbPUf+B706NBuDSe4Ek26BLWtYubN5k3wFKmIrP87Vz4Wil1bifQBRD3SShDFzuod7owzivJHSDtv44dNxF65qinHXw0XJ250mjlj3efLP/lHuFemld8g9GRVCxDeYEAOJLb/Kd88qn1j88BA1XQDXZGpKk/GIoVQP5jWuf4z3ww3lG0pxwUPqETlaxBGRodWt89gX93fnAnMOy66GA6y7mcNWFNBJvCn4cmrfCLCSnmMEfCtgogXrFY06LpBhLmzQ0CyhWqw+gWWNQZXYHMsSfz10Bdy9zV3kiDi7Ry+msIdsHvuNWkUtGOBerzhWvIWsjaMKUmKOdEcnoHVDFR0RKRxeimzyde0Ndw81f5TAdAvAzisbsiP65F9is3b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(44832011)(70206006)(54906003)(6666004)(4326008)(478600001)(7696005)(26005)(8676002)(36756003)(81166007)(70586007)(356005)(5660300002)(1076003)(8936002)(2616005)(336012)(82310400003)(83380400001)(186003)(316002)(47076005)(16526019)(426003)(86362001)(36860700001)(2906002)(82740400003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 06:26:21.5252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abba25fc-9fe8-43bb-fe9d-08d919c5da8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1498
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting from Navi+, the rlc reference clock is used for system clock
from vbios gfx_info table. It is incorrect to use core_refclk_10khz of
vbios smu_info table as system clock.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 8c417014ca89..83ca58426139 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -546,6 +546,21 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 		ret = 0;
 	}
 
+	/* if asic is Navi+, the rlc reference clock is used for system clock
+	 * from vbios gfx_info table */
+	if (adev->asic_type >= CHIP_NAVI10) {
+		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+						   gfx_info);
+		if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, NULL,
+					  &frev, &crev, &data_offset)) {
+			struct atom_gfx_info_v2_2 *gfx_info = (struct atom_gfx_info_v2_2*)
+				(mode_info->atom_context->bios + data_offset);
+			if ((frev >= 2) && (crev >= 2))
+				spll->reference_freq = le32_to_cpu(gfx_info->rlc_gpu_timer_refclk);
+			ret = 0;
+		}
+	}
+
 	return ret;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
