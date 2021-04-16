Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95508C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD97610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD97610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265666EB8A;
	Fri, 16 Apr 2021 14:34:43 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680084.outbound.protection.outlook.com [40.107.68.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB24B6EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsVZmPq/SZt2imEdQm71+6ae5TN1rWI8uH3Rv45MDbuweRBVc9E7FSzvyjuF5ZakHmk0HH6Bby6d0Mp//3zoZQ40XFE+h4jeVVMmXo9keQRGmWuAzNHZQh/YXSlTcAaYhBNT5xE9jtLSWE4xF7f1B0YWtPnVCeABCe2/qBLoqVJQdtgMYtoTPv/CkB89Rpirvb8xDXRFd4JzCuA1OJENQran/vUucPdPdsr7+3+tzzomzmseOih2lD1EpGqBC2GGXURYB28m34nr28ifJOaKlvVO5yA3TYedgP63qROalscvy4OXKYchM10Bm2P+7iK812I3cYH/G5K0un0rKLJtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFnwuMJuSCdQQwhwHrgLWal8RDH3w38yFLEe9W4YQbs=;
 b=OFZ3FBHAF7x6th2Gk4X4Urp3Xmkdv1QUVfyoLOwIxtOIzUUr3MRuLih1Ac/qbjNv9Kv7LOafNA0YGlZMKfqzg5DcCLhbtJ7iZvH0Ov9VsZ14DC8hoThHKxJU5Qz2gxlGSWJDg+ICC7Zkx/ZTQYzl4ZM2U7Z1PLdWzZava3WSzLRMuNy5ObYdFybaaOqu085JQYJSPovKVEtRtEcGM5ONTe9BHE2qc1P0fx4YuD7epEGB5ieABY67IoVzyPtWtt/iDg98xl+nB8KzoDluX2psY0+hPwrcN/0w1Bytx6+rkfpyYWiPsNvEUKgtNGC3Vj1sG5YgSdnVr2+w5/gIzdHnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFnwuMJuSCdQQwhwHrgLWal8RDH3w38yFLEe9W4YQbs=;
 b=HWxnu1sF3iV1k0N+PRzg8RaOA/C8irzQe9U6YijVwbWonT7gJvEjJ88qmfQv35Vq5T4zmDb45Jkb52Z3tExxlkvaFu7mmaX4ljDfSP7CwP2tlHUheZEshjTMuL6WUNvY4rFrZBfkjUFYorPyTVQFWkhzESzbLEFx3/kpP4/h0Qc=
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:34:39 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b7) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.17 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:39 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:33 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amd/display: force CP to DESIRED when removing
 display.
Date: Fri, 16 Apr 2021 10:34:11 -0400
Message-ID: <20210416143417.611019-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47a39904-9840-4c11-25e1-08d900e4c46d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2714:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27143935A7E8713E3EB0D9D58B4C9@DM6PR12MB2714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWxHe99LTUOk4E5oulTMKvFDvtUtShbPebtwBm8j/CjnHNvu4ovJteVpJIky8HM0wfCZ+g56DhB2zWD5lUhcwyOWgcT/lcucjtgGCaiwlLfzYwutV/I07R6BV0BYGzHFGOmrw2dQuVEHNADRgBsMT1G2akpKFs7whvIFgaQBPym0jJnhbdQWCzq+dmh5CDqXDfnzcj0Wh/bpu1kqi5WCEFVUeCqUj4UzO9S3q6v0KtDLgX1hVc9QyOuOb9ehIaJxBIi6xulWl7pXoyAOqooGlLO4LCahnIGnCS2SvU8vlc9YVUSTJYgPrdBafQ9/Uud+7atxT8vyg6XIA8OWQLm6J+JUfFm2CLOS5bhrZbVudU4JEs2T0R0AHEpCGAjr6uUPpmoEUSB92/uoUNGcwAwaUD6vzuw50GyrrJCAyuZfikIXJWDR3sgv9vnd6OARvYdtVHLUGuW5+kjzOgUAnBHaEXV+gRayVFD6voPrVJDSF8hc3iso3n53rgRoOdnl0ZieG4Ahk4Pi6vOR2N0/m41UbQX8LPe5hCfsg98KTIhH6uxpW90x5zgF2kdIOYTiyoJAQFRAjZOhrqDiCOM2/gjL4N8UYMD2V1y2Ed76RS+Hobnw56wNk9DquvhsJeqZg7Z4R4vAwso8HsMt1qQ0XdqYHed3VRdOBIrWhi5Js5pUG4Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(478600001)(6666004)(44832011)(26005)(2906002)(54906003)(7696005)(316002)(70206006)(8676002)(82740400003)(81166007)(8936002)(186003)(5660300002)(356005)(82310400003)(36860700001)(86362001)(47076005)(6916009)(426003)(336012)(83380400001)(36756003)(2616005)(1076003)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:39.7217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a39904-9840-4c11-25e1-08d900e4c46d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2714
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
Cc: Dingchen Zhang <Dingchen.Zhang@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Dingchen (David) Zhang" <dingchen.zhang@amd.com>

[why]
It is possible that the commit from userspace to cause link stream
disable and hdcp auth reset when the HDCP has been enabled at the
moment. We'd expect the CP prop back to DESIRED from ENABLED.

[how]
In the helper of hdcp display removal, we check and change the CP prop
to DESIRED if at the moment CP is ENABLED before the auth reset and
removal of linked list element.

Signed-off-by: Dingchen (David) Zhang <dingchen.zhang@amd.com>
Reviewed-by: Dingchen Zhang <Dingchen.Zhang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 616f5b1ea3a8..50f6b3a86931 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -160,6 +160,7 @@ static void link_lock(struct hdcp_workqueue *work, bool lock)
 			mutex_unlock(&work[i].mutex);
 	}
 }
+
 void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			 unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector,
@@ -222,10 +223,22 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 			 struct amdgpu_dm_connector *aconnector)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
+	struct drm_connector_state *conn_state = aconnector->base.state;
 
 	mutex_lock(&hdcp_w->mutex);
 	hdcp_w->aconnector = aconnector;
 
+	/* the removal of display will invoke auth reset -> hdcp destroy and
+	 * we'd expect the CP prop changed back to DESIRED if at the time ENABLED.
+	 * the CP prop change should occur before the element removed from linked list.
+	 */
+	if (conn_state && conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
+		conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+
+		pr_debug("[HDCP_DM] display %d, CP 2 -> 1, type %u, DPMS %u\n",
+			 aconnector->base.index, conn_state->hdcp_content_type, aconnector->base.dpms);
+	}
+
 	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
 
 	process_output(hdcp_w);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
