Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE7C43462
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB0461059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB0461059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FB06EC8E;
	Wed, 12 May 2021 17:32:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797866EC82
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq35bkoELP8U4KkqsUnDenMNAtpUAFQIEEAiIuk68fhOoqt2p3VAGZZ6D3MELXB7xhrBYccss/h91ERmE95rruR6Z4E82xOQVlcIKqmtBDJeY5KanfDfxkezUWDYlnvS8iITJWDUwjouIf1HaDqN+vdONx4yMavWqRbo6JWzlvG2u18GIvzIV8ofXZIMQ9bB0LfuvGk+o+BOEqbz5RCJP/HR5wHC8x6uDOyAdyqfKKVdazCo+jZBUsxIAZFn/+zl95c8cqUswt02e0gru5EbSO1TsMdHBtH03esB34+/x/MM2tWz7112nZyifY9QTU2U0cqq0NXt8PTyE34GnRjTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/hUr1zabeD6In+q07qvE7UqSYUbRd2EO56SxC3rNeg=;
 b=X6GHLOoUwiOml+ceSHGFCXjHnsPQqlxL0JTxtEGznfIrMNw+RXj7kFiq4TSncn9Jmct+e0tCbmqTsWsRU3gyG6ST0m1ewb0GEGgwBiUAcF59kqmUW+W+eLapUU9oXDwSoNsvaWNd2dMQHxoJs4wZJWWiGYo1Ky3MtUu94D7x+GQAsJpmvpi9eJQ6p1ipR7CRm1HJcRjXpi6xR8pWrSYI19Q7zgw/JbMMS85mEylDdjxudtSrY57uPJzyAAWItx7ZUit4wncMRpB5n1t1k0pWkvEhkFGGFNT1w3gMhayH0GhQcOuAziUXtXqIZbC1+RkGdPCp6wgdMGEXAzC6WpDwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/hUr1zabeD6In+q07qvE7UqSYUbRd2EO56SxC3rNeg=;
 b=FL+zNhFn8QmSVrHLTHSo0WqHZMWvcgJvUynuCuAqzPJt/bwCGADGkaPITg641ZaRgyB8+NON0k+MeiPWownuO2gGEPxJeiZYqhQB9Mk/c7k8MJLRZjO06D2OjNF1d/5dC1+nYT0Bz0SF+C3Vt4Ktt2cOR2THLNNC7Zsxb8e93kQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:12 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 46/49] drm/amd/display: Add callback for update_soc_for_wm_a
 for dcn303
Date: Wed, 12 May 2021 13:30:50 -0400
Message-Id: <20210512173053.2347842-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b07454f-596b-44de-fb99-08d9156bce64
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2564C4EA897CBD6F80AB6331F7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4lrtJEAC13vuzpm9oESsV309GD7Z+sc+mzl9Ts6YWSdCH5envPVVgv74O7IIT1UvtVBgVnvT/MGFqwPEpg2G8gFbbiurIOM7emGBXGBqmOIXCVjxBhNZl7ccMnDuOnpH4+p242aaK/0bajpFp/Y+NGuDtoDD91q7z5ly/4WDrvR/OSrRWj77c27Iu1CL3vka0I3F0rIBr2MvFOFZH/dMAPz6GrBdfcEJ7Buod/9wO7OCOChnAs1IQEBk05eoyGP0C+ogF1DDRZiyw1C7+Go5p1gLBljXVl3yWp4W7agSHmo9VLObPrKvGUqrMm0uogQJwWzyWylQfLBLtmKk4TEYnhVvJs4mGUfQAAeZ52SBD52EyUt0blx1dDZ6W+x+YRMWf/U8UwsFZ/sJOYhs6UDOUuEp0IQDbyl6uJXrGqBHXMpLR5ap/yF+ZzgKGecwhqtl4sjIuitzsWku3KMyZFEzhBGn9BZCyI1fiu9iitLefK6NcNw11clKln9UVtNg912XfstyFHRHJ4lWgv8R33m9+eVxJ3sH2ZO7IQCXPvR1wDNkZdYajP0M9QzeTI11O2Ka9JVwcwcMVhr8E5f6rxA89Dvs02CyAFMaoSnP0bUBvYWVcttllzyHriZJ5u/FO5WIWeKiZe9JczYo474yJgw5eccm9SylK0DvKlSicttfAudgDWmBTJshRkj2H+7h6ja
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(15650500001)(2906002)(6486002)(1076003)(6666004)(66556008)(54906003)(83380400001)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6KdQrdgf3TuTBRPNmVvjJUV6TgTfyERT5VDKT4l/aOG2RbT6ElT9PoRFtAs9?=
 =?us-ascii?Q?2MU4Lsp+bZXj0CAbkbYb3b/A0SHWNJjZd2Wj+mJP53fWUD5Wm9DdMGaGODku?=
 =?us-ascii?Q?89vQXjUJ8nFCEykVmVGORaCoVHe0bIGdjKNzhhYbIaeUJTGyAgauP1S1HkHf?=
 =?us-ascii?Q?XIo82ompx0jN0Bj2ONcRZ9O7/E8qNAXT/4L3pPwyFg43cn5l+EOJlh31dAoL?=
 =?us-ascii?Q?/8GMsp3RizpssU8/L72s51wId9vWlExhd22l+GI++Ym+tjImTze8/py+PXYs?=
 =?us-ascii?Q?G1q6rmZYJqDi24iDsVGXnlM160UI+OWTirI3US0mbzlqh8sAb8hJ4MoYWiYn?=
 =?us-ascii?Q?L2VoECSvQ7cvLi7dkxyRZajgXe96ttDmdazCQnmsXP/Mk7RK+2mzco3ivvGb?=
 =?us-ascii?Q?UdT0g5tNjZWJLoB6m6pyqQVaXZNbwYcOUtQJwTtErSATEt1luAKT3b0qMCzE?=
 =?us-ascii?Q?1PBwWlFIniOth2rmLqi6X1SkQII1LzT0Go6djtAGsjFRHQfPea2V+rNtPcHA?=
 =?us-ascii?Q?5m13JNtBLWc/4+W1HaqMsFqgCESHBU7UQBgZlHXnpPGtPvcuWZrR8ljYEPIA?=
 =?us-ascii?Q?tXtxzjfu1eOcaFi4uBiCNFQ+1VeSpL9dDulLawXBz+BK5OVTz2RVzh8fY4jA?=
 =?us-ascii?Q?NqeKhm5dl339YXL4coziblw2iqdYVL7MUooAHOyik8qQZBgClqGoAsUy+nSR?=
 =?us-ascii?Q?1evTWs+oOWVjyXsDe1GDL/Ece40redH2bF9njIEg1lt4YGGcHyStlz98EqmW?=
 =?us-ascii?Q?dD7NBKsBWt5b02y31rSyH3YzBTeU4Fz9YiMHK+3Pv67PikRvhVKZhlv7aQSp?=
 =?us-ascii?Q?6sytkD6O+esDPuQQKvlKNLbLsXaN7DOuERh9DAt/F8YaibPLBnBBrYClTOD9?=
 =?us-ascii?Q?wMxQjn8ST7BokONCFcz6qIfpQhUHpAoVvtcjk3Qj1CCFDUyI12conD3bai+f?=
 =?us-ascii?Q?ywawZlqYyrhQ+qOix5FgmSYsAPKrrTuglnW6wvHtUtnTo6Iqtim1n5k9E3Ex?=
 =?us-ascii?Q?HUsgpzX/UGAXA7AKWg/16qnrLLIA+AHdMhzCX8hQQPYRZzzvXhTrkrRpT70E?=
 =?us-ascii?Q?ECj3rHDmeWQMaVMEV70Iqekf37lLrKVlKA2Ri+VQCrckjaYwQNifDV7zD/TN?=
 =?us-ascii?Q?9ULMr3v7extWBKcUVURoCBd5o4qp00u9HxaTQhaOvbbY2KnD0yjLfQR1UaRd?=
 =?us-ascii?Q?e+AibSr2iPX+yvPsyMTQ6/oGjrjkqsMrgWzQhWCIlc0YXTes0df/8fyDH+9E?=
 =?us-ascii?Q?wURPGYjThkkxLts+63c94L+p9kDUyLE5kEV2PmhCjp/iQ3np346u806XuArx?=
 =?us-ascii?Q?4p6rAneNBEUaP+I5zb7LQnB+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b07454f-596b-44de-fb99-08d9156bce64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:42.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPwRoc7RPa19gEXwc6cnR/Lcu3jAiLEntFcdW1d3uzPv7kIirOv59v0r1ozm6X0qPRnbNR2cGdkwP7WdYDXsAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Absense of this callback causes null pointer dereference.
Add the corresponding callback in dcn303 resources.

Fixes: 8ea9608379 ("drm/amd/display: fix dcn3+ bw validation soc param update sequence")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 3d6259d0d392..59548a6e1a50 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1325,6 +1325,7 @@ static struct resource_funcs dcn303_res_pool_funcs = {
 		.panel_cntl_create = dcn303_panel_cntl_create,
 		.validate_bandwidth = dcn30_validate_bandwidth,
 		.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
+		.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 		.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 		.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 		.add_stream_to_ctx = dcn30_add_stream_to_ctx,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
