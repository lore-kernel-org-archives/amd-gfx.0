Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64546C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 06:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF25D64DA3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 06:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF25D64DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79CA16E8C7;
	Tue,  2 Feb 2021 06:17:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770072.outbound.protection.outlook.com [40.107.77.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A796E8C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 06:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atkTzC67vskRNmI8chiqvFGjtIVrgcQVPh9EDdrSk/eRtWg7XNrmBbPqArj0wmRgF94kSNTM6b8mO8mXBz6JVPIQW6I1ZIpfIfNi0qt1GMXy67sWMzO5+OeMMF4cBNbdU0x2H4bKfVvmVDTDsmfFkDfXQwrgpfApeSTjpsMCwe/qsh5jn6u75wIL3mTBnpfCJZ0xjXAN2xExRB1f99qC+V9Lv+ny9zVqPw3xOZBBIHzS1pI646UwM5xEjKQXnV7A1F4el3cZI0VE5PlqEOOYi5/EDD6SM7nU+BHrvQqnfx1EG499lnC43WUDsrXAZ61YiAeDpQbfM/9OxfDuPAkxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Erm8CiHKef2/PQ6s2OjckqeTcARMUQbxihJjrtdXw=;
 b=aK9H5DwjwTzMv14pe65M3RO4iRdb69M5ZYtFdy7l1hrt3UDjekiOyx6kANBb0l50Q4gACz5RePPDezuJO6YJKKATUekos6K+eyZzMpVI4uBqPICWt5kmk2IlrmyL62/Ven3r7I42vveE9/kn6VOdqKYY9oyJyloWQsxub5Z/Fp367NvYhlxdL7Juh13+CL5PH9J9CZneE/rxrZGRJIB8gavlGGEJbXhqsl720XlFjs81Gcx69Qnf3AFwNDv8HgVxSEX6GSf8y2SQA61PUIIuy5ywAqTxNGVFrySqaGgfZ82O9UkNh6SQrlslvwsn2dV53eaqBBil0Wsmoy8NnZ4zBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Erm8CiHKef2/PQ6s2OjckqeTcARMUQbxihJjrtdXw=;
 b=n9SPDc9VyCvoZx3PAraqyfWLeKmCOORLhCN8JucOk7FgE+dDQerU241diaP4h7vK93Y87oX1m/FmsfhsRa+T/eEU3UkzMfTmmbjbFU5SFqEI62ImQwVgCNLQAGo7yHJGNaLljI0U0blyBY/MYlrKbELDr4ZUrNQjw6dnw0M5Ny0=
Received: from MWHPR02CA0020.namprd02.prod.outlook.com (2603:10b6:300:4b::30)
 by DM6PR12MB4697.namprd12.prod.outlook.com (2603:10b6:5:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 06:17:37 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::f2) by MWHPR02CA0020.outlook.office365.com
 (2603:10b6:300:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Tue, 2 Feb 2021 06:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Tue, 2 Feb 2021 06:17:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 2 Feb 2021
 00:17:34 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 2 Feb 2021
 00:17:34 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 2 Feb 2021 00:17:33 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Add otg vertical interrupt0 support in
 DCN1.0
Date: Tue, 2 Feb 2021 14:15:55 +0800
Message-ID: <20210202061555.5731-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202061555.5731-1-Wayne.Lin@amd.com>
References: <20210202061555.5731-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8239a68-032f-4b80-c7db-08d8c7423c80
X-MS-TrafficTypeDiagnostic: DM6PR12MB4697:
X-Microsoft-Antispam-PRVS: <DM6PR12MB469724EAC06BC3A0CA535C28FCB59@DM6PR12MB4697.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: to1sS/AsOChGUptuv8Yq9LZtOoAAAIG3dYCmjcQhPtzUAqy1pCfelcaA3q06BbZbXFhRzh6Kw3jw5QEFUiLOAjN8mfF2/zRA0raEBcolmDdqRk9KIVNltb5teqQAhHqbIJNpbci7WyvA5+magkcUJqJ3P2IzYgFjKMFsI1zyLMx8aK9Gb5wr18ulI/BcuUV2JIBklytGc2gYIwjJTLYQT0Mpz+Idhq6+LGUIzzWudw09VHH1JBtxXlRqND/zQSj10temI0D7aTPcZdlj6t8gMu/VR9gR35FhMDzTzcNnBbRA2lNIfwYO2Knd6v0+nfr6CeE9jiOeu52IuUZuDcJEr060A5Spsb/yZFk752XmuMSz/NoQVIYXRh8IcJyfBHpc37D8LrwMhyN6bK4TI2dQt2O63OOmPAnMYWPlEtOFoOnzEy9mu69FgCofkIHUoKaZXe6/20iEcj60YS4yi9RlSjm/PAhi1wFJFTXh+NYwTS4uni8QjxuSbK+d3Nq82hIi9cds1KMqBVEwzwWrWSs1b1EgZ/Kaau7yAcSD6uLS+EB4l2mgtIeZXM1Gn0SfhxLU7sarodprlDOk3T9k3OTtfZKgVWC+/U01wnbrXvEJwT+MXPdYcnfzQ0unceaeu6+J/uZ2YsY75xILTCP41fF5lD8vaGhaHFWAehRE6fv9LpE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(426003)(478600001)(47076005)(2616005)(2906002)(86362001)(336012)(186003)(83380400001)(36756003)(6916009)(26005)(4326008)(356005)(8676002)(8936002)(54906003)(82310400003)(6666004)(82740400003)(316002)(7696005)(70586007)(70206006)(81166007)(5660300002)(36860700001)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 06:17:36.8147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8239a68-032f-4b80-c7db-08d8c7423c80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4697
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 Nicholas.Kazlauskas@amd.com, Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
On DCN1.0, need otg vertical line interrupt to get appropriate timing
to achieve specific feature request.

Add otg vertical interrupt0 support for registers which operation is
vertical sensitive.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 22 +++++++++++++
 .../display/dc/irq/dcn10/irq_service_dcn10.c  | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/irq_types.h    |  1 +
 3 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 357778556b06..74738d2b9af7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -659,6 +659,20 @@ static int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 		__func__);
 }
 
+static int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int crtc_id,
+					enum amdgpu_interrupt_state state)
+{
+	return dm_irq_state(
+		adev,
+		source,
+		crtc_id,
+		state,
+		IRQ_TYPE_VLINE0,
+		__func__);
+}
+
 static int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
 					   unsigned int crtc_id,
@@ -678,6 +692,11 @@ static const struct amdgpu_irq_src_funcs dm_crtc_irq_funcs = {
 	.process = amdgpu_dm_irq_handler,
 };
 
+static const struct amdgpu_irq_src_funcs dm_vline0_irq_funcs = {
+	.set = amdgpu_dm_set_vline0_irq_state,
+	.process = amdgpu_dm_irq_handler,
+};
+
 static const struct amdgpu_irq_src_funcs dm_vupdate_irq_funcs = {
 	.set = amdgpu_dm_set_vupdate_irq_state,
 	.process = amdgpu_dm_irq_handler,
@@ -699,6 +718,9 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
 	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &dm_crtc_irq_funcs;
 
+	adev->vline0_irq.num_types = adev->mode_info.num_crtc;
+	adev->vline0_irq.funcs = &dm_vline0_irq_funcs;
+
 	adev->vupdate_irq.num_types = adev->mode_info.num_crtc;
 	adev->vupdate_irq.funcs = &dm_vupdate_irq_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
index f956b3bde680..34f43cb650f8 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
@@ -58,6 +58,18 @@ enum dc_irq_source to_dal_irq_source_dcn10(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
+	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC1_VLINE0;
+	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC2_VLINE0;
+	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC3_VLINE0;
+	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC4_VLINE0;
+	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC5_VLINE0;
+	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE1;
 	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
@@ -167,6 +179,11 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.ack = NULL
 };
 
+static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
@@ -241,6 +258,14 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
+#define vline0_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
+		.funcs = &vline0_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
@@ -349,6 +374,12 @@ irq_source_info_dcn10[DAL_IRQ_SOURCES_NUMBER] = {
 	vblank_int_entry(3),
 	vblank_int_entry(4),
 	vblank_int_entry(5),
+	vline0_int_entry(0),
+	vline0_int_entry(1),
+	vline0_int_entry(2),
+	vline0_int_entry(3),
+	vline0_int_entry(4),
+	vline0_int_entry(5),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn10 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index d0ccd81ad5b4..87812d81fed3 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -160,6 +160,7 @@ enum irq_type
 	IRQ_TYPE_PFLIP = DC_IRQ_SOURCE_PFLIP1,
 	IRQ_TYPE_VUPDATE = DC_IRQ_SOURCE_VUPDATE1,
 	IRQ_TYPE_VBLANK = DC_IRQ_SOURCE_VBLANK1,
+	IRQ_TYPE_VLINE0 = DC_IRQ_SOURCE_DC1_VLINE0,
 };
 
 #define DAL_VALID_IRQ_SRC_NUM(src) \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
