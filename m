Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3BFC369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 04:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DACC410E050;
	Mon, 21 Apr 2025 04:06:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB85210E050
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 04:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5KFPsqgNEHtGyq8z1i/DeSDhtsVo8VMdJOwOI+e545q244AbCtuZ+TV/oMs4mlL+iPiv7DNF0gxg9jV0ZoFPPYIQSKBtLpiVjwrx9qMaWlLQeXQ9TDR9+6SkF1NUq/TAzatfbveU3JJPtoQwMWXBTLKuQ5U1zpi8n8R3gKP2FE1N+OOHB0Ag3kyfQoqlMW5bvAUIdX6HtqRa4wVbUQv732Mh5XWSwMnbgfENxxGT01cVu5liBBvyo8Q6V5Cv6X2tWiFrWnjE9X44MPsTesMHMqANyLOJ2L5c2zxOVRrPLra5svFSKZH0UJBmn34uvDefssb7hL9e7GT86ZQSscCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z94bXiwMoMdHHjcT84XvxSppale2ouokV7dj/g3Iopk=;
 b=Tkq5bktdaOkj3QqQ0Q5dYIi9rxQ/EZmdU+Z7Vfw293lrA54ddGj2oV3mWABkxh2nVAr5GxntlGPku6/dsCCzXwgXGzk5l6RoO0K4eXAUksj9yoWOkmEf3TUxVr9kHH73BYgaq/1IDt2tRvGsn7ZDF8gnfOiE/8YtyuxXFcbzqTV0EVBdgGWA2tjaXCF1M9QYOEn8tDrNRLbHPB71Qu+BgOmd6xIyIO7VlGczK0Q03fcU/qc/gqlxHC3eT7/Rcerz6ktUzqpDp4SIkAC93sMiVxLduHZG/x9Day4rubEk8DHyTuIXUM597Pl/2BGzRsUTuQaUzg7E0xc4l921BGPBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z94bXiwMoMdHHjcT84XvxSppale2ouokV7dj/g3Iopk=;
 b=1P4MIwgTtH2NX7HbZ3U51OQ73NwC49StSIMSqOZZRazNfHzcBBrwREiMsTsDDIVV30iC4oviJhH3pEMspmHIPdKS5IpCd2TAhOWqV7fKQwGtTcmAi8WBaJLOQ7qOJnPqC5oOsp5rPBn22buRDaxcpDHDrJuSKgJw7HQk89FQSwU=
Received: from LV3P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::6)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 04:06:27 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::96) by LV3P220CA0017.outlook.office365.com
 (2603:10b6:408:234::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 21 Apr 2025 04:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 04:06:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 20 Apr 2025 23:06:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "Roman Li" <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: [PATCH v2] drm/amd/display: Fix NULL pointer dereferences in
 dm_update_crtc_state() v2
Date: Mon, 21 Apr 2025 09:36:10 +0530
Message-ID: <20250421040610.3794293-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
References: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: d80d01b1-9710-41b7-3854-08dd8089e2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XQ6YbrW6/OUC3j12U3pqjwm3MU2nAPcN+P+Rnhm1HwPxGUTQJnB70rGhDx62?=
 =?us-ascii?Q?BQyslNFmpQS3ergcZzHIf9rhFKXAq4YCesUSshqCTTrSdjBSsNWR2DS6BTBR?=
 =?us-ascii?Q?uyI5eFUB0hpONBpY6ruORPcN59wcrk2JPTuNsrYqMpZ3f3DYO3b9ABLLnZP+?=
 =?us-ascii?Q?HZwx+xHjKfqt75m+lSeiNaqJVd+N7nmi814ltcMSgH1Ar+iNCq2jWz0Aw/Tw?=
 =?us-ascii?Q?OaRnEm4e9LlBEDtXDHksy3x9hjXBio4IfMFfdZHv+sDvzAlpCl84TTTvVvGk?=
 =?us-ascii?Q?g7vUf5a2h8tPKqMg2arhHwTJdVB5L0lx5LsUpacDWnXhCfAoDrLu7uN8ooGj?=
 =?us-ascii?Q?OpGuwyMtNFT885ORMtorcNCmr7DeZGTluaJGJQ44vrkAJjpKma32XdMpMDQK?=
 =?us-ascii?Q?x/NGZsaKdSZQviofJRsL1y0zNzuKzs3hqCIlM0RJIuEHrMseqBMKy+lwZV/z?=
 =?us-ascii?Q?mkeQJ3BSt0bpk2VEdIMNC/cEGcjk4rZ2qtTZSS9Ckj8wazBde84PTg4FkwWf?=
 =?us-ascii?Q?k2vhkaS79kjllWXjTP4hDL/6g2ztlRWL7JqwMbilG9m4GHaZ/WBLdhiu4UkH?=
 =?us-ascii?Q?MypAc86ZUNyngnJbtcK2qhselSRJilz+Jya8R9V+PQvJ5TQTzKjVY7z+WPLc?=
 =?us-ascii?Q?suI2BgoI8We/wQY+nBItubSZ2EUEK5i9NWVkoLUQM8JCG6x4/7HYQis+c8Jj?=
 =?us-ascii?Q?3ZEVADfx9DrTbfHH8wcphklJY8jRjm1VORrKC6MRntX2s/4XLPqD9KF7V4Fk?=
 =?us-ascii?Q?x3rTjg7l6DM0VF9OYonIwh2mdU7f0cZQ7Ca83cgCW0xiJbSHRUHAZCvHblzk?=
 =?us-ascii?Q?nvh4p2ht84LTsIroeZ8PG1p3VIdylCF5HPQnMx023jr/MTOQz9KDXl1KWLST?=
 =?us-ascii?Q?L3P+wxR5ujxXMA/oJhaFu+G5UAis0LVbS3ak4qR9/dJGV0/Wj7fS5LPq0wKf?=
 =?us-ascii?Q?ehAY4xV1cxtlSdj5o0yosd18xoVj9R1A5rcStIlYR8errbckUpXTAu+0EcWO?=
 =?us-ascii?Q?BnEbUqzgZEG9n+2WsEsLkUpTEBNM1DexLIjeFwHKULAlARmnzurL9DetueA7?=
 =?us-ascii?Q?JxYRVVv8OrrIB06kF5S0SSVOAiuXhWvMiUDEsJPRwaXgyL5sq2aCmdjwkszr?=
 =?us-ascii?Q?evs/m+RPNBgd0qRVuhyhkkeUkj66Y+oBMFKzPo5YK/k2BGN+3BAg4NNC08EM?=
 =?us-ascii?Q?MkJchTNkhs/Gjj7TrieZG9PMN01SsMYmLJ9M1HhDpzPbMV+cxRqKR+dfN+26?=
 =?us-ascii?Q?n0M5VXIPL3o6AiDY0xJAyy3OJ5eIkhO1/2Bsyl9jkRshsLoaFqvtnpA6diz1?=
 =?us-ascii?Q?+NSE1Kayig7Eoci8GNEfJdLyACW5w8gydgam04w0529HhSpYMorweg7+TZq0?=
 =?us-ascii?Q?pe/mH/617gTjtYZLwi5jLrwN5WbLzpl/knSePoJj7m4OT7zdPsqggXTmxiqV?=
 =?us-ascii?Q?gU4poLqRo6kKmLrtcYbuW0M6TvQ9v11VFmY5dELG05b9MqVxkcGD0vXfOMHL?=
 =?us-ascii?Q?q14Sa9qjpqNUD2kXg1GtxYpOLjuLbm3BwC07?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 04:06:26.2434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80d01b1-9710-41b7-3854-08dd8089e2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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

Added checks for NULL values after retrieving drm_new_conn_state
to prevent dereferencing NULL pointers.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update_crtc_state()
	warn: 'drm_new_conn_state' can also be NULL

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    10672 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
    10673                          struct drm_atomic_state *state,
    10674                          struct drm_crtc *crtc,
    10675                          struct drm_crtc_state *old_crtc_state,
    10676                          struct drm_crtc_state *new_crtc_state,
    10677                          bool enable,
    10678                          bool *lock_and_validation_needed)
    10679 {
    10680         struct dm_atomic_state *dm_state = NULL;
    10681         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
    10682         struct dc_stream_state *new_stream;
    10683         int ret = 0;
    10684
    ...
    10703
    10704         /* TODO This hack should go away */
    10705         if (connector && enable) {
    10706                 /* Make sure fake sink is created in plug-in scenario */
    10707                 drm_new_conn_state = drm_atomic_get_new_connector_state(state,
    10708                                                                         connector);

drm_atomic_get_new_connector_state() can't return error pointers, only NULL.

    10709                 drm_old_conn_state = drm_atomic_get_old_connector_state(state,
    10710                                                                         connector);
    10711
    10712                 if (IS_ERR(drm_new_conn_state)) {
                                     ^^^^^^^^^^^^^^^^^^

    10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);

Calling PTR_ERR_OR_ZERO() doesn't make sense.  It can't be success.

    10714                         goto fail;
    10715                 }
    10716
    ...
    10748
    10749                 dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
    10750
--> 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,
                                                     ^^^^^^^^^^^^^^^^^^ Unchecked dereference

    10752                                            &new_stream->hdr_static_metadata);
    10753                 if (ret)
    10754                         goto fail;
    10755

v2: Modified the NULL pointer check for drm_new_conn_state in the
    dm_update_crtc_state function to  include a warning via WARN_ON and
    return -EINVAL to indicate an invalid state when the pointer is NULL.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 31a5b8fc4dc4..3d2ff5d58067 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10858,8 +10858,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		drm_old_conn_state = drm_atomic_get_old_connector_state(state,
 									connector);
 
-		if (IS_ERR(drm_new_conn_state)) {
-			ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
+		if (WARN_ON(!drm_new_conn_state)) {
+			ret = -EINVAL;
 			goto fail;
 		}
 
-- 
2.34.1

