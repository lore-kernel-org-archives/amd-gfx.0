Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F2C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 14:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DE2613CA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 14:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DE2613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EBD6F53F;
	Fri, 30 Apr 2021 14:32:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACD66F53F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 14:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up0WKmcrerPsnldN9MyFeLvzf6q2SfJ2wPTEYxuhFpMy7QzLy/MEiETdlpuw9sXjelobGLpvErKQNrINZBrImWwBciTuL7/+yWlK77khrqfxqfCIZSIy0GqBNu8Rh203kVottLdVM/2GA3vv2GCcrbVkea0ZB9k6kckyCAks3KafJEwJacroEbeFGrIzUZted7/G6vPpwl49+Vv8QfJAK1n2ZnwkGN82HYRSr1PlZ7LrjPzYqNtCFpYexZsSpoeWo9f7YW2F+lYkQCP5WIp81IRs2xCkARBmjwNoxb4pOHLzAZjp+JCW1roFqNDhz36YNreDHPF/0CX4WDFLO0rkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZDk9WooQsIIwawuychoj4yUvj0qhppUolQ9ThBmQ7g=;
 b=AWV4qUvSE9+69KYejRrSElAg16zRcuNDGaU4l7me4vD+dp4s3FaZTwyqmgJ7k3tHImf1atKnpQO8S8sVf189PPWWuZNS119k6wgqN0EEOJQt/FhbSFJGDiCU5RLUMJSLK6bSSOm3dAVq1J/77GZqRokcKpSwr7bsYJSBBqPswl/kV3J3PoYjbL5fY9EhQ52W2lHReEabwjUXgqvBBadsQxySc5FcjzOLXr2m/lttsDt0BPYdqbhTtrJL2AZLm4fJ49TkvKM51exc8OeT12Qmp9TJ/2sGC/C6eWdcEwtVdsvdvMD31kaAPfUKnKsWI8fFLlnXLatjPJYHinBdyNQ5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZDk9WooQsIIwawuychoj4yUvj0qhppUolQ9ThBmQ7g=;
 b=k8dQp9pw5wgwt9uY3NNWH/YERr+o+rZlLhP8xjl1zZpznTSEZT8hsolvAESVdIfKoBHyuBHf+eE3Uz7Egl1jUFu/Yk3if/32EqoHFSavLaO1d32bqSRtpkqR7Vj8cTPCioOuw5kY8s3Gsc3CaS8dEGRUpiHpfa+4EejmdqcQaA0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 14:32:31 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1855:9722:849:a7e0]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1855:9722:849:a7e0%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 14:32:31 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu/display: DP MST hot-unplug cleanup
Date: Fri, 30 Apr 2021 20:02:10 +0530
Message-Id: <20210430143210.151658-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430142322.147627-1-shashank.sharma@amd.com>
References: <20210430142322.147627-1-shashank.sharma@amd.com>
X-Originating-IP: [106.51.20.251]
X-ClientProxiedBy: MA1PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::28) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (106.51.20.251) by
 MA1PR01CA0134.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 14:32:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b140fe15-31b7-434f-1551-08d90be4c979
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2918ED78EDAD87F0E5E88936F25E9@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfwqU9k8XFHNxzgH3hOnadrnrBcIRc2s2NynJo3LCkUgnrqbjJ9LBciIibsMt8e7+XJ4I3MhL3nJlzI7gibo9yUeeQMtrc+FPZauyj+wtYakCTYvpvlZekcEUXXqhZhE8wtG1lLuE8+Youa+hzHJLbQZkKugZ6BapVm/gMkadtNtWSc50BYZDEQ57cdrK6G0I1dG1jJALXAfQb7Lc1ed431SMeDTlbAgDiWQncDYK23HZnM9NOfZ3eODQl07vMtO3qHCPCocYKXIo6QMHS+0QaVRFMez9R7C8h+P0BD6u7/QBhYAFQxtBPvbSFiT8laXto8YBHptD2t4bdGZ/pfN5xZTqYlMiWwIfK+QZ3lg3Sx3nH67ZQl5cjBMiyzpTQe+m6HAP1CTc0JUEoE2QGyOEmNHJ+JkXbeWuDXFqcVQsDPBQQusR8sWqiYCYvWZ+JriD765jgOJgLe1SJ1eWVEcEJ6FntKDZjiYR6pnpnYbhu9ldzWLnr4lz0winqDw1n1iGCgrBT8semWFNyGpPxj6NtNZr5jqig7GHVteIGNdeLoYSnTCkceT3vtoOXEuuOpF9xZriJZExSWY3peRydIlsfrCRJXLS+k2qvMUezNFs0IPdhACnsDk7pHf91INN0jwS7iVNdJdBfDKWZc9N7E4OET3rj99FAfHST80R00o3twOW8oOyEakT1xVO2mb0+KG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(1006002)(186003)(478600001)(52116002)(8936002)(2616005)(36756003)(956004)(6666004)(54906003)(26005)(16526019)(5660300002)(8676002)(2906002)(6512007)(66946007)(66476007)(83380400001)(6916009)(4326008)(44832011)(55236004)(38350700002)(66556008)(6486002)(316002)(1076003)(86362001)(6506007)(38100700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?72roSki5anQdkuXwQcCLRYup5XsaCmJ31juM8a5xWl07rtgvj83Nsx8oUotl?=
 =?us-ascii?Q?Czt+1FJIE2dzqw0RM4YzJ8SQ8es6MFv7ClgwKwEh8jFC6/GcZqwxZUJlfW9V?=
 =?us-ascii?Q?591zOQPmnSTIjydlHTIKOCmAd7/wNuI8R1mcS2eIg5LOxl2gM8G89ARzoRRq?=
 =?us-ascii?Q?ehCfVij0PU48g2Y0K5pyaK5plyMa8II+d3ckM0ULvBU/u7cOc1zpe3+Eq1VX?=
 =?us-ascii?Q?in386E96oVwPFJEIRd+ULTMCnpabhf0eIIcDS+/QSKYn1GIdKa5KBT7tZrAo?=
 =?us-ascii?Q?umrevbMzX3OyNEFDH1y40CtOc5BaGyfckey7tx0TIiVaJC3KZLjb0QDub5UH?=
 =?us-ascii?Q?Fi35ygKgV7xQA8A6iU+dQfBzN9DidZQE9OZjfpnVOANotrym/m8KUds41EFH?=
 =?us-ascii?Q?15soaU2svZSJu4m7JO/1+dfF1C4tjTtayIWZVOcmevd9Ov9JP5+BHneAbFCH?=
 =?us-ascii?Q?JgCBoFCPIpsOoz3biJZGvrq01PQge23XXvJ/zcUUKndSnDovKavihMmQ7bL2?=
 =?us-ascii?Q?Zh+1pBur8BTaXcp99grBn37Mji7/Xxw3zkv40BYsPVeK5c7lSFDFd9WnKPeB?=
 =?us-ascii?Q?VkQbavdPCpRt8kycHDX0xvk8OBh4RnYAnSGX0REujZJGnQeM18QcD7hNnxm1?=
 =?us-ascii?Q?GL1m+xqlfo9FJweQpt9j4NB0qdAgZ1I3j9Mbmtndmqm44ArZXX3kG27/dsiI?=
 =?us-ascii?Q?bxCOdA6fEVq9X9I9alnG/ULLLQR9d0pzWWHAN1S2mo6+7dk7XyfGp6nWdVg6?=
 =?us-ascii?Q?2gU7LsNas/VYaH4DCa6NaD5TJt6DlXrBaKs3VoY+smtX0raNZM/Zpx5irTfF?=
 =?us-ascii?Q?fjBE3+ay9A9XlizlPOIfBaAPRJa/nJTRzEl9e2/TGOS0hJF2H8EMdUwaOJyX?=
 =?us-ascii?Q?bH3bmGcp+Aum9aWHUNETw+PA8kUWs8VBnvPxv94clEseRTNDmEPV1186wZDi?=
 =?us-ascii?Q?Q1H66CMNcYHW/i+5Z3Q6xToSFgTtiONNplQQMSSN5iwqVsP4Nd8QTr/sFmYL?=
 =?us-ascii?Q?VmFHh3Ddr3iVxDflGRKeBLsXgZt8PwqBediHp+osiLsG65I37MpgUHww280q?=
 =?us-ascii?Q?S0UZSj11jTT0Gv+oW8IDM9d67F9mEYP7Z/aE/2bjfB3BUR+sN18EBecWIGx0?=
 =?us-ascii?Q?lUFDb+hekPEtpPdwYEyUbd4a4AiBkjY9RKQdYLdpfZiog+MDQS4tg4afahHc?=
 =?us-ascii?Q?jPHrAlKuGiIQ68CZy38QFkh7Fj+m1Zwkzr2WzPbjmQFcfb7YNrQhdNvCz5UR?=
 =?us-ascii?Q?g+0O6QiDi4R/SMXX3nMBQ1rOAZU6JaDakK4XH9W11yzQdf19LtM7d6dbOgeQ?=
 =?us-ascii?Q?+YeiFPdppTyfKvwEzFMacoNe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b140fe15-31b7-434f-1551-08d90be4c979
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 14:32:31.1809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlJ6+jo1AWOG18w3vtarct+69k0Z1wDeoS4oWMvQW4E/NFXyNHY+S7WDNuDNKE66z3YgWWVgmG574t66URy7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The current DP MST hotplug handling sequence adds new remote
sinks during the MST plug-in, but it doesn't removes it during
the unplug, which results into saturation of sink count after
2 contineous hotplugs (dual monitor scenario).

This patch adds a clean-up sequence during the hot-unplug situation.

V2: Removed one extra line added in V1

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8dc5005bec0a..8b87dd0a3d50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -220,6 +220,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		struct dc_sink_init_data init_params = {
 				.link = aconnector->dc_link,
 				.sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST };
+
 		dc_sink = dc_link_add_remote_sink(
 			aconnector->dc_link,
 			(uint8_t *)aconnector->edid,
@@ -266,15 +267,42 @@ dm_mst_atomic_best_encoder(struct drm_connector *connector,
 	return &adev->dm.mst_encoders[acrtc->crtc_id].base;
 }
 
+static void
+dm_dp_mst_sink_cleanup(struct drm_connector *connector)
+{
+        struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+        if (aconnector->dc_sink)
+                dc_link_remove_remote_sink(aconnector->dc_link,
+                                           aconnector->dc_sink);
+
+        if (aconnector->edid) {
+                kfree(aconnector->edid);
+                aconnector->edid = NULL;
+        }
+}
+
 static int
 dm_dp_mst_detect(struct drm_connector *connector,
 		 struct drm_modeset_acquire_ctx *ctx, bool force)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_dm_connector *master = aconnector->mst_port;
+        enum drm_connector_status status;
 
-	return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
+	status = drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
 				      aconnector->port);
+
+        if ((status == connector_status_disconnected) &&
+            (connector->status == connector_status_connected)) {
+
+                /* Fresh hot-unplug scenario, sink cleaup required */
+                DRM_DEBUG_DRIVER("[CONNECTOR:%d:%s] MST hot-unplug, doing sink cleanup\n",
+                connector->base.id, connector->name);
+                dm_dp_mst_sink_cleanup(connector);
+        }
+
+        return status;
 }
 
 static int dm_dp_mst_atomic_check(struct drm_connector *connector,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
