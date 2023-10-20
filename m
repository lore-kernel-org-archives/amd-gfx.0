Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B376ACDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 18:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C3110E10A;
	Fri, 20 Oct 2023 18:06:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8177910E10A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 18:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbGltduuLT3AyVtG09ib7HL1P5eeQpbKqGMB+SBDvXYUPEeD+ySaCJdnVn0FCa3haNCxYRze3RQ7sEl2GNNaZVKwGYr4XvpQ5UjbkpnXa1Imt2pp06DIW31+bhlZJKrNjMM8jhdpOZvGIfy4pZJjJOtkxlPL/lryC/UFsXDm4RHeAyGU44vN6kZPJwRseJCUzw4ounujdSNy1dI+f5caOmqt6tRZWtUMVunh8IJS+XjMx5qLegd1fRzo/OgaIgIYeH2yZAR2Wwn6RM29GkhjEDRgLIxly/2uECyakFDvC5wjtUSh1hD+Psik3jJN8vJv8FgmXhbUPrp03yGkDy6ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RdqjFe1LnhQzaxOcl7iuDEIE++zS5MR1BpUwCbyJy8=;
 b=nG4mPJ9zyg2qmdi0d+ClptsKPUNYth1ZonpcSlK0puE+pRmUIwC3Vs3rSdGhzsAGeppzGlOM1ZszV4juMQzh8XZR6ptv1nv3GRkfR7RuGDcU5fT4gACIxbSD6f4YdQNirf7VZGQO55aTFPnA02mJsGu+RtKpDXF25jOkba9ZM4lxSNSJ6tFF2lWQ9E7WJlxCjjF4MKb25lXdZlZdGAccxWJN46dPW0dyzghHrj4lwUCn/XsECvoOpk6xuIsaAlrJUoBvGqydI0LtFLZ5w/v7NVv64gRLV5KL5+ilM2IxwptVkKMasggdLukVPq8gtjkU/LCmo79UNcSQ0nJ79Ok+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RdqjFe1LnhQzaxOcl7iuDEIE++zS5MR1BpUwCbyJy8=;
 b=bUnEsGUWKT35fDXhOp+loHGE9hL4yiupJsbo4g60rmzb/GTYso+s72a6+XTFuqAy3XuMAFPPVNTpYGRNP2HUUUfX/tMpOzqioOjE8AdF2frqA2jnHMIqNzEJQ+BSCsczNLMgy87uXn/9UJb/3i3nzw8P8YKCE4z4s79FqhxAWAc=
Received: from DM6PR11CA0015.namprd11.prod.outlook.com (2603:10b6:5:190::28)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 18:06:33 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::2f) by DM6PR11CA0015.outlook.office365.com
 (2603:10b6:5:190::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 18:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 18:06:32 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 13:06:28 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/display: Fix copyright notice in DML2 code
Date: Sat, 21 Oct 2023 02:06:23 +0800
Message-ID: <20231020180734.559121-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020180734.559121-1-stylon.wang@amd.com>
References: <20231020180734.559121-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c554a27-d4ec-4948-a5ef-08dbd1974ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjn3CrZ9yE+4KSdzG30BfuPIh2+m4bLRuNhx7D1ifg5iiKRA+gW2X7djzXuzFUmxdidQQQaL7LoNOAKA4Qaqh++HgGAtiaOnJqmcPAuWus374/B+pu9tJ6VrDCuzRd+kxiYaMfzGlSfQp/xqBM+kiNRBgK5r3z/e4tau0YhsHi1jAdTEI3sOQdSRV2rIRdyeHc+Hhf+PiQ6I06qoM/7DcHZx/55omQMkaaBttbxmXfky5AuvHwMe7f3N/T3xK7dX9ZdIOSc1FhRfn+N9u4Epp/k7yCmJC0mx2IVnW/FXvS/I9mhSxNcJ2+xfTDRDU3+8WlGy/Qj0ucYqIH1xIpKRF4MdVpMFnAi2vz1HTS19W+brfP39guXbVIjwj7wlCZiiHKhh+2xhBkdgZzDwAPwpNJfeCDVH9kBOzSQiX/n3K4M3M7EhpDxMQPokJvHScNVLxIdXtR6csDZWnIwEKJbydCBfgwIUisKwS1dLYQRZT+YjuU4FLoNEL11YZieSUXhDvsUen4BBqDq/KDXJ4/KjbyTFyg0guwJYglKmozwLZXRMSd4PRLItslt2ImsA/zaLLKJifo/6cKEcj6IE0JkdScYD2LI5k/bdVeOX66HlUj+o1EC4pKWChoEdd8XQ1gaaqH6ZCz/WppaiCH6nO6+InEPRFtkjIu4I0QH7GUKsoA077JxjSLoIejs0ea1lpNIkEOI47NruwrtJZHXLRDNhMPt0huPNYa12wtOg5qjJasc/Fd/doguPiNT4RaCXX69jpWKfgE/VkPy+m+hMuLYr0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(6916009)(54906003)(66899024)(70206006)(70586007)(40460700003)(316002)(478600001)(6666004)(4326008)(36756003)(86362001)(8936002)(5660300002)(15650500001)(2906002)(30864003)(8676002)(41300700001)(44832011)(82740400003)(16526019)(2616005)(426003)(26005)(336012)(1076003)(81166007)(356005)(7696005)(36860700001)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:06:32.7271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c554a27-d4ec-4948-a5ef-08dbd1974ac9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
Fix incomplete copyright notice in DML2 code.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/Makefile                  | 4 +++-
 drivers/gpu/drm/amd/display/dc/dml2/cmntypes.h                | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c       | 2 ++
 .../gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h   | 2 ++
 .../gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h    | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.h       | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h   | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_types.h           | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h     | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.h       | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c             | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c              | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c            | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h            | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml_assert.h              | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml_depedencies.h         | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml_logging.h             | 2 ++
 22 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index f35ed8de260d..d9137675d8b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -20,7 +20,9 @@
 # ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 # OTHER DEALINGS IN THE SOFTWARE.
 #
-# makefile for dml2
+# Authors: AMD
+#
+# Makefile for dml2.
 
 ifdef CONFIG_X86
 dml2_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/cmntypes.h b/drivers/gpu/drm/amd/display/dc/dml2/cmntypes.h
index 5450aa5295f7..e450445bc05d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/cmntypes.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/cmntypes.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __CMNTYPES_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index cff53d28d3c5..4f906fcd83d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "display_mode_core.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
index c2fa28ff57ab..b274bfb4225f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DISPLAY_MODE_CORE_STRUCT_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h
index 99bdb2ddd8ab..de63364be01d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DISPLAY_MODE_LIB_DEFINES_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c
index 7dd1f8a12582..c247aee89caf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "display_mode_util.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.h
index fb74385e1060..113b0265e1d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DISPLAY_MODE_UTIL_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index f45fbe820445..393ecad64636 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dml2_mall_phantom.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h
index a78de194793d..2f91244a7b01 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DML2_DC_RESOURCE_MGMT_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_types.h
index 191b2e63ce6e..e85866db80ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_types.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
index bcb59bcd9179..ed5b767d46e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
  
 #ifndef __DML2_INTERNAL_TYPES_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
index 02797cb2667e..32f8a43af3d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dml2_dc_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.h
index c14b4de29d73..9d64851f54e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DML2_MALL_PHANTOM_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index f8e9aa32ceab..c4c52173ef22 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dml2_policy.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index e5ccd2887c94..331f6bd97d38 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "display_mode_core.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
index 1bcfca51e665..dac6d27b14cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DML2_TRANSLATION_HELPER_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index ac6bf776bad0..69fd96f4f3b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 //#include "dml2_utils.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 9a5e145168bc..0a06bf3b135a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "display_mode_core.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index f3b85b0891d3..252442ea9d3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef _DML2_WRAPPER_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml_assert.h b/drivers/gpu/drm/amd/display/dc/dml2/dml_assert.h
index b5e463aa61af..17f0972b1af7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml_assert.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml_assert.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DML_ASSERT_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml_depedencies.h b/drivers/gpu/drm/amd/display/dc/dml2/dml_depedencies.h
index d8c7f7497e9c..f7d30b47beff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml_depedencies.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml_depedencies.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 /* This header intentinally does not include an #ifdef guard as it only contains includes for other headers*/
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml_logging.h b/drivers/gpu/drm/amd/display/dc/dml2/dml_logging.h
index 890c0a072012..2a2f84e07ca8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml_logging.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml_logging.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 #ifndef __DML_LOGGING_H__
 #define __DML_LOGGING_H__
-- 
2.42.0

