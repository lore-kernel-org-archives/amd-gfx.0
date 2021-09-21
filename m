Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E282AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC28361168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC28361168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F686EA3C;
	Tue, 21 Sep 2021 18:07:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5886EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKQGmcFhDNquyka0Zz7r1aw4xwhEnMu+3D9m3fFMkOjgHsDKPcOUjD73z8Myx61Qhatl4WwYrux4CsVsbIaYxPBxFkwRJrUPSV1mlTgEPKNfScffEdMsEOHa0bVMgpUkzbvG2bWD2aeclQ0dKt16YOOOayUfwwA9Z5LW20Zxp6eQDY8KegVJo2BmqcDoQxKR4s5YF7M3AQ3qIG5B2GISqLDiDAra4PAg727CVB6BdfZdBcEVWc1OdCbE1du/MX4zmrK+w5ilVcJYz/pJlQPCRKeo4sMufpY38ChToXH5diWU8vZmKLr3iNtp4Sa5jp/mPYByCiszpNNufT0LYg/j3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ob/RrGUL8pS0rNmoLXm0yVSlLg/dyHoB4lxj7KosrS4=;
 b=btwyMqtLU7X7Jidvd/Q1+0UF+zWF1xls71hY9MpxJolX3IlGtBN00QFbS90AkYVv/ZHkD283YqRIayi6X8zKulvo5Z9NnkbOaCV99ST1ftGl0D2fAe+M5LudZsl4hF73XydCygxXEsbw6qaEHaqeWDFyOrZ9RzSZP3E4l3KFsyeadsiYaqfpI6EwVw7GtUwhteL/i8WrZknhwU7p0vXrFrdFK3xVUGnVRZfiNwfHZs8+PaW402lksfU0Q3v+frW1WjQrlEg5BF6z2o/X9MuyJ8csaPoW4FWPOW9ZgRt6n4Pw9HaqN8mLk7C+ngP07XwQsFtRraaG2d2J9ZYi+vio4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob/RrGUL8pS0rNmoLXm0yVSlLg/dyHoB4lxj7KosrS4=;
 b=u5pav1EBqdxII8exkxkhnD8M+XigZIw8juhaWXneeeAWHRADQk6dED1gFRPIPHbPidZX+iOX/lNDsgoSlLkzsAMxAwmbO/pjvXeEBR1T2b7h6Itiyheh8Y1c3jADhpkeSqSfk9fzziRok+tYuiQ7G48pInFVyzc9KRiatoAxKdA=
Received: from DM5PR11CA0017.namprd11.prod.outlook.com (2603:10b6:3:115::27)
 by MWHPR12MB1744.namprd12.prod.outlook.com (2603:10b6:300:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 18:07:45 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::6e) by DM5PR11CA0017.outlook.office365.com
 (2603:10b6:3:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/66] drm/amdgpu/sdma5.2: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:28 -0400
Message-ID: <20210921180725.1985552-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 270265d1-5301-4ef7-87d7-08d97d2ab64e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1744:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1744EA4E4F73C6ED7FB102E9F7A19@MWHPR12MB1744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBfolAI4KLQkptyM57PruaGSpSVtx6DV+A1XHLk38N5jN48PKsOx7oObLONrAIDyMXBhkNGGOOqsdN5c79SA2egCNJWDIg89jntfd4S5mYPc6ACFk7P/QPp9M9LPWAOv1aYlgAjisI+DmJRjaif5iBt+zUYBj2CcdfPPm4VWhWCjJ25bDM2ig2uWjYIqgfqAP42Jv3l2toZEiAWuU9TkY55zQH05KoNYY8pN0fz7mWFRFABYWaSGBAzPD0wQmkqgN8SmgQfYFMcNG1uY3GTAaXTHn9IGMipyfHFmLCYfNIPwf63qakYKXXlzrsMqrAQJ/lNCIVyJuH+vLJEC4LqdObXvkDOeBbKIifGLAdKU9/boWE2UT7b+mH1Pmjp/6y6ylL+GeX5xO/732rzD4OFZWSCb3qSnq563Ahu5gscffjWpwNwJGNJPEFS3eFSG87lyWXbKmuP1oX6+/54/bgB60Y4TQbNRX7MXhZRyzvJEuF/2Ss3HJ/iVR5MA036sGk8SJFSt5X4x9vpun0MXChvvxIixAORoicM6M+b3GLoZakIOMgasJAhCmW91KowcPK9363dZ1MCyUgYo0c34anYlbN8w66uidtx43Z6HqWC6KKA8PUb/eLm5nj0ePeuAXUODSbgpUfeo4ChUjRdcRLdqTEOzdKNU2gv6GLcm9tpEDiKxB8Od2pHMfBC53ImUQXW4eb+fz0u3N+HhGS7ydKTcByfZvaI9cX5N9rhaFAHQwy8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(356005)(426003)(86362001)(36860700001)(83380400001)(5660300002)(47076005)(186003)(36756003)(16526019)(8676002)(8936002)(70206006)(316002)(82310400003)(1076003)(7696005)(6666004)(2616005)(6916009)(508600001)(4326008)(2906002)(336012)(70586007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:44.9534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 270265d1-5301-4ef7-87d7-08d97d2ab64e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1744
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 48 +++++++++++++-------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e4a96e7e386d..c5252f12eee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -136,23 +136,23 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 
 	DRM_DEBUG("\n");
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 2, 0):
 		chip_name = "sienna_cichlid";
 		break;
-	case CHIP_NAVY_FLOUNDER:
+	case IP_VERSION(5, 2, 2):
 		chip_name = "navy_flounder";
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(5, 2, 1):
 		chip_name = "vangogh";
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(5, 2, 4):
 		chip_name = "dimgrey_cavefish";
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(5, 2, 5):
 		chip_name = "beige_goby";
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(5, 2, 3):
 		chip_name = "yellow_carp";
 		break;
 	default:
@@ -174,7 +174,7 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 		       (void *)&adev->sdma.instance[0],
 		       sizeof(struct amdgpu_sdma_instance));
 
-	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
+	if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 0)))
 		return 0;
 
 	DRM_DEBUG("psp_load == '%s'\n",
@@ -1209,17 +1209,17 @@ static int sdma_v5_2_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 2, 0):
 		adev->sdma.num_instances = 4;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
 		adev->sdma.num_instances = 2;
 		break;
-	case CHIP_VANGOGH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 3):
 		adev->sdma.num_instances = 1;
 		break;
 	default:
@@ -1547,7 +1547,7 @@ static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *ade
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 
-		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
+		if (adev->sdma.instance[i].fw_version < 70 && adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 1))
 			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_MGCG;
 
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
@@ -1584,7 +1584,7 @@ static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 
-		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
+		if (adev->sdma.instance[i].fw_version < 70 && adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 1))
 			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_LS;
 
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
@@ -1613,13 +1613,13 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 3):
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.31.1

