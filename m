Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E737C001DB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 11:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2523D10E509;
	Thu, 10 Aug 2023 11:44:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CB610E509
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 11:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm70fKWs6A83ZoAqr3Mtpv7Ro50CTrJSJhJs+tSL58IbM6O4vc0jTr/wtApiq5H/t1aZED9wUzS2yNeX5SDZE1LwlYN3l+tAvWxekvvwpVdkZqMgRKla2KlYo0+IdsaIQCvK/WZE4O7kYmEhrfxYUS9/zm/TVruQeSC0WhRcqH0DGMvkKtuUjhBGlt19h0d1fsBzoB1DnbP8rM0xwn1Fxg4GMnedFlSGyy2qIgvEAu7XkK+kpb67HwDUorM4DumEKk0GMCrPWRjbohykkcOsQNCGFCRu9vc6Vp3sozkgEXQp9Ut5VnuN7Fq4sumlz42oD2SwACf/iAEdy5LXwXi4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqCB2GwqKIYwA73fI1tXxLyFUPz+jkkTadKvqTPLhRw=;
 b=SDy+w2feLV18h50bibhB6XxZDWy86ZUVjxoW0KmLoYy9x9UFNQyBXeRyB2NEXleNOCc9GwbQAFfk+P1MGE3WNDZpmwtgEBQPhcGEnqTopTl+2CXLMSH3Yp9m8Hgpf9Fs0R0FX1CRSnihJ0oRmx3QYTmS+sDxz64bJMA2UQYnc30AUy1to9Tr5jkgjd520r5+L+DXl1/xdY21NoIj/IbYFmTwVNX//GjqZbdnmUHQXZ26H1S9FhvvKuLtba+aIwg7Nk4uU3nfi9A0iaRRMMiZymoUJSITO9ANYIQuBuprIpKDeH1qY8eFs1GQsmG22whJlepmGBSSqhKWpk685NeDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqCB2GwqKIYwA73fI1tXxLyFUPz+jkkTadKvqTPLhRw=;
 b=jUpNFmvNlFjtLsto3C1wpTYEQyY9NuH+sDtpt4YlNbmTt4EWczRUJI+qIbfS2Gk/tc//Qws4+FWvJ2k2vGq9VMxBf3NlaXyiBg2UTfN6j83pFX617SliNXAUtaiNP+qP+VVWcRziOUW68BndaMQVJ7D4Jx4mwqP7g15bmKAKPAY=
Received: from MW4PR03CA0319.namprd03.prod.outlook.com (2603:10b6:303:dd::24)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:44:50 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::27) by MW4PR03CA0319.outlook.office365.com
 (2603:10b6:303:dd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 11:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 11:44:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 06:44:47 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Keep reset handlers shared
Date: Thu, 10 Aug 2023 17:14:25 +0530
Message-ID: <20230810114425.645209-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8caa10-126a-432d-be24-08db99973479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzcIlaXu/S1qF9LmqfW59yfiGiR1uW8/Enu5lKSCDKHFy0Vif1SesjN80wx2bC9XxE5NaiDpLdgAt1YElj6Ao0BsERYUbLydzmWOxlGuj0eGS5SzUofiI5V/cH2kgtEh+Gp5KJPDejd5yCIgOTIcNMKrLWa85e6XhKI8GMTbsCuK9SsWlxYErgYB479FIt8z03Tl0+mf53FY7f1vO4yNZt99BN2zFWcDNEooapp8dvnzwDmrYw2bPHnhSx6qeZSF4Y8V68hz3lRZViUFqMbagngN/XMWu9EtW8jNPN7oYva81fCLyTAREC2W4ou6VWz5dDzyNfqpKShVexDuGyRWjdDMMP1d8n3HbvWThV8PrUh9AnfiYddFbhSCPUcq2U/X7OCBoexcTe/FpRh+oHpjddZPdbtlkEVRQW4UjOuGYxggRSqUbLe/LE9qp5KDX3JHMrzRLVLl6l5UgPM5DqtwpxlyK08I7UIQa2MvVbcQYLfjJ5H+uLwewRKaxe6VBYpuQB3rWnltU8lFpH5Y8RFLh5sCYC66yfCz8MmMRWKZu/zCWN1O89VqDv6baocjQd5sxzEHp5PM5W/1FKNBFb8eL3AzgzLuqmaOrxpaF2QSs1HON3aVQKCMu40keJVv1/oWosgsxjDILDTV+IhrnwIok5VyyMT8n9DSFIWfm4C6x8wygq5PLmOY9Pi/mWEeMIQedsJzRiNfsBaa7OXzlQzyV8WcirgdSQCKY8Qdz6VNWLXTTagzLKPprLhTKR44FC95WXCzXJw7CGINvvkWV/ogsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(82310400008)(451199021)(186006)(1800799006)(46966006)(36840700001)(40470700004)(2616005)(16526019)(478600001)(44832011)(426003)(86362001)(40480700001)(30864003)(6666004)(36756003)(2906002)(7696005)(336012)(40460700003)(1076003)(26005)(83380400001)(356005)(54906003)(81166007)(316002)(70206006)(70586007)(6916009)(4326008)(41300700001)(47076005)(5660300002)(8936002)(8676002)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:44:50.0999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8caa10-126a-432d-be24-08db99973479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of maintaining a list per device, keep the reset handlers common
per ASIC family. A pointer to the list of handlers is maintained in
reset control.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 20 +++++++++++---------
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 19 +++++++++++--------
 5 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 2b97b8a96fb4..82e1c83a7ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -48,20 +48,19 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 {
 	struct amdgpu_reset_handler *handler;
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	int i;
 
 	if (reset_context->method != AMD_RESET_METHOD_NONE) {
 		dev_dbg(adev->dev, "Getting reset handler for method %d\n",
 			reset_context->method);
-		list_for_each_entry(handler, &reset_ctl->reset_handlers,
-				     handler_list) {
+		for_each_handler(i, handler, reset_ctl) {
 			if (handler->reset_method == reset_context->method)
 				return handler;
 		}
 	}
 
 	if (aldebaran_is_mode2_default(reset_ctl)) {
-		list_for_each_entry(handler, &reset_ctl->reset_handlers,
-				     handler_list) {
+		for_each_handler(i, handler, reset_ctl)	{
 			if (handler->reset_method == AMD_RESET_METHOD_MODE2) {
 				reset_context->method = AMD_RESET_METHOD_MODE2;
 				return handler;
@@ -124,9 +123,9 @@ static void aldebaran_async_reset(struct work_struct *work)
 	struct amdgpu_reset_control *reset_ctl =
 		container_of(work, struct amdgpu_reset_control, reset_work);
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	int i;
 
-	list_for_each_entry(handler, &reset_ctl->reset_handlers,
-			     handler_list) {
+	for_each_handler(i, handler, reset_ctl)	{
 		if (handler->reset_method == reset_ctl->active_reset) {
 			dev_dbg(adev->dev, "Resetting device\n");
 			handler->do_reset(adev);
@@ -395,6 +394,11 @@ static struct amdgpu_reset_handler aldebaran_mode2_handler = {
 	.do_reset		= aldebaran_mode2_reset,
 };
 
+static struct amdgpu_reset_handler
+	*aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
+		&aldebaran_mode2_handler,
+	};
+
 int aldebaran_reset_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_reset_control *reset_ctl;
@@ -408,10 +412,9 @@ int aldebaran_reset_init(struct amdgpu_device *adev)
 	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
 	reset_ctl->get_reset_handler = aldebaran_get_reset_handler;
 
-	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
 	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
 	/* Only mode2 is handled through reset control now */
-	amdgpu_reset_add_handler(reset_ctl, &aldebaran_mode2_handler);
+	reset_ctl->reset_handlers = &aldebaran_rst_handlers;
 
 	adev->reset_cntl = reset_ctl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 5fed06ffcc6b..02d874799c16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -26,14 +26,6 @@
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
 
-int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
-			     struct amdgpu_reset_handler *handler)
-{
-	/* TODO: Check if handler exists? */
-	list_add_tail(&handler->handler_list, &reset_ctl->reset_handlers);
-	return 0;
-}
-
 int amdgpu_reset_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index f4a501ff87d9..471d789b33a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -26,6 +26,8 @@
 
 #include "amdgpu.h"
 
+#define AMDGPU_RESET_MAX_HANDLERS 5
+
 enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
@@ -44,7 +46,6 @@ struct amdgpu_reset_context {
 
 struct amdgpu_reset_handler {
 	enum amd_reset_method reset_method;
-	struct list_head handler_list;
 	int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
 			   struct amdgpu_reset_context *context);
 	int (*prepare_hwcontext)(struct amdgpu_reset_control *reset_ctl,
@@ -63,7 +64,8 @@ struct amdgpu_reset_control {
 	void *handle;
 	struct work_struct reset_work;
 	struct mutex reset_lock;
-	struct list_head reset_handlers;
+	struct amdgpu_reset_handler *(
+		*reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
 	atomic_t in_reset;
 	enum amd_reset_method active_reset;
 	struct amdgpu_reset_handler *(*get_reset_handler)(
@@ -97,8 +99,10 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 			       struct amdgpu_reset_context *reset_context);
 
-int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
-			     struct amdgpu_reset_handler *handler);
+int amdgpu_reset_prepare_env(struct amdgpu_device *adev,
+			     struct amdgpu_reset_context *reset_context);
+int amdgpu_reset_restore_env(struct amdgpu_device *adev,
+			     struct amdgpu_reset_context *reset_context);
 
 struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_domain_type type,
 							     char *wq_name);
@@ -126,4 +130,8 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
+#define for_each_handler(i, handler, reset_ctl)                  \
+	for (i = 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
+		    (handler = (*reset_ctl->reset_handlers)[i]); \
+	     ++i)
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 8b8086d5c864..07ded70f4df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -48,18 +48,17 @@ sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 			    struct amdgpu_reset_context *reset_context)
 {
 	struct amdgpu_reset_handler *handler;
+	int i;
 
 	if (reset_context->method != AMD_RESET_METHOD_NONE) {
-		list_for_each_entry(handler, &reset_ctl->reset_handlers,
-				     handler_list) {
+		for_each_handler(i, handler, reset_ctl)	{
 			if (handler->reset_method == reset_context->method)
 				return handler;
 		}
 	}
 
 	if (sienna_cichlid_is_mode2_default(reset_ctl)) {
-		list_for_each_entry (handler, &reset_ctl->reset_handlers,
-				     handler_list) {
+		for_each_handler(i, handler, reset_ctl)	{
 			if (handler->reset_method == AMD_RESET_METHOD_MODE2)
 				return handler;
 		}
@@ -120,9 +119,9 @@ static void sienna_cichlid_async_reset(struct work_struct *work)
 	struct amdgpu_reset_control *reset_ctl =
 		container_of(work, struct amdgpu_reset_control, reset_work);
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	int i;
 
-	list_for_each_entry(handler, &reset_ctl->reset_handlers,
-			     handler_list) {
+	for_each_handler(i, handler, reset_ctl)	{
 		if (handler->reset_method == reset_ctl->active_reset) {
 			dev_dbg(adev->dev, "Resetting device\n");
 			handler->do_reset(adev);
@@ -281,6 +280,11 @@ static struct amdgpu_reset_handler sienna_cichlid_mode2_handler = {
 	.do_reset		= sienna_cichlid_mode2_reset,
 };
 
+static struct amdgpu_reset_handler
+	*sienna_cichlid_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
+		&sienna_cichlid_mode2_handler,
+	};
+
 int sienna_cichlid_reset_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_reset_control *reset_ctl;
@@ -294,11 +298,9 @@ int sienna_cichlid_reset_init(struct amdgpu_device *adev)
 	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
 	reset_ctl->get_reset_handler = sienna_cichlid_get_reset_handler;
 
-	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
 	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
 	/* Only mode2 is handled through reset control now */
-	amdgpu_reset_add_handler(reset_ctl, &sienna_cichlid_mode2_handler);
-
+	reset_ctl->reset_handlers = &sienna_cichlid_rst_handlers;
 	adev->reset_cntl = reset_ctl;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index ae29620b1ea4..04c797d54511 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -44,10 +44,10 @@ smu_v13_0_10_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 {
 	struct amdgpu_reset_handler *handler;
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	int i;
 
 	if (reset_context->method != AMD_RESET_METHOD_NONE) {
-		list_for_each_entry(handler, &reset_ctl->reset_handlers,
-				     handler_list) {
+		for_each_handler(i, handler, reset_ctl) {
 			if (handler->reset_method == reset_context->method)
 				return handler;
 		}
@@ -55,8 +55,7 @@ smu_v13_0_10_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 
 	if (smu_v13_0_10_is_mode2_default(reset_ctl) &&
 		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2) {
-		list_for_each_entry (handler, &reset_ctl->reset_handlers,
-				     handler_list) {
+		for_each_handler(i, handler, reset_ctl)	{
 			if (handler->reset_method == AMD_RESET_METHOD_MODE2)
 				return handler;
 		}
@@ -119,9 +118,9 @@ static void smu_v13_0_10_async_reset(struct work_struct *work)
 	struct amdgpu_reset_control *reset_ctl =
 		container_of(work, struct amdgpu_reset_control, reset_work);
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	int i;
 
-	list_for_each_entry(handler, &reset_ctl->reset_handlers,
-			     handler_list) {
+	for_each_handler(i, handler, reset_ctl)	{
 		if (handler->reset_method == reset_ctl->active_reset) {
 			dev_dbg(adev->dev, "Resetting device\n");
 			handler->do_reset(adev);
@@ -272,6 +271,11 @@ static struct amdgpu_reset_handler smu_v13_0_10_mode2_handler = {
 	.do_reset		= smu_v13_0_10_mode2_reset,
 };
 
+static struct amdgpu_reset_handler
+	*smu_v13_0_10_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
+		&smu_v13_0_10_mode2_handler,
+	};
+
 int smu_v13_0_10_reset_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_reset_control *reset_ctl;
@@ -285,10 +289,9 @@ int smu_v13_0_10_reset_init(struct amdgpu_device *adev)
 	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
 	reset_ctl->get_reset_handler = smu_v13_0_10_get_reset_handler;
 
-	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
 	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
 	/* Only mode2 is handled through reset control now */
-	amdgpu_reset_add_handler(reset_ctl, &smu_v13_0_10_mode2_handler);
+	reset_ctl->reset_handlers = &smu_v13_0_10_rst_handlers;
 
 	adev->reset_cntl = reset_ctl;
 
-- 
2.25.1

