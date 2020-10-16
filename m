Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB195C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36960206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aZlRxPib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36960206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5406E9B2;
	Fri, 16 Oct 2020 03:27:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F4E6E9B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJ57f/4e3mgo59WloAawZNcwrDZWT1z4nCAJG/g4xtpPRoliTYFg/St/qR06Zya5Yt8xlWMBJsCWDB+rnqVnZWUvlutVFNyBsYnStSjpiBOyDxci79BOl4/8Km6uEdwUoWFDMApNQyBWeaZI5RkdmSn3/cInJcrdJdRJwZLvjF5CWpKMKoOom9RLvlH6EdJDzonAMZGMiYDxlrII2rY4PnIvs0DlzYZ/eqMUMQ/Mzj5vGn5dUmXE3kXJ0iguaOrsq1vACqaFseQXY2pxefNx4xEuOiXvFoLh3w/oZoDvwaviCkBU4rIYI/ioSXAwEpi9yZdB3OjCEg8bOqAMREEcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcMjTBtlFlLgyA2zaHdIEN3DRMm07L1Voce7eCsXA1A=;
 b=ek87VN2bW6jWBpQMBM6F6dhjmJwvY6SJZV8KXMx3UCT10M6WTAUkm9Seyg2BzLkEhpdzSLcdBLAkohFFxyRFq9m6BqaP2IHRtQ/+P6odM9CibCWA3q0vCbLMoktovHly5SO2gunbmRv7q7WyeZ9YNLwEKFl8CasoIejGdZ+stUmu7c/Tp44FbSxk7g7thVV+rFPs/yPoYyCYS3uiQ+NmKUsrf1UsTV0/DlIbWTuuQecsbQhXYdWEY2iOQL37y6ux5Rntif6dnYoYC5iBrOjgIDaPLA0Igd/7ATyKbxfCINFIpAzST8GjUql73EnSpQOulwjwgRyVUTRo1b93YKaAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcMjTBtlFlLgyA2zaHdIEN3DRMm07L1Voce7eCsXA1A=;
 b=aZlRxPibBREAvhKIeBTM0X7NrvDe1AO8vMiJIIF9WSFKDvcGoSP02DYLZePWAI6SCOwZ2J9lYxTeAWBotUsns5sm+3GtZMH8kQfpFlYse7xm+g7ozHx7SkODRfwmECuCWvF1HeCHJbJ8u9x004Iq5YzjyrqBNU5a/f2mgsrYJaQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/40] drm/amd/pm: drop arb table first byte workaround
Date: Fri, 16 Oct 2020 11:26:22 +0800
Message-Id: <20201016032652.507-11-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb6edf8d-ea6d-41c4-8a5f-08d871837592
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB468013F2438BA37B5A167E2CE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JDH9o6SvTzSxOVmUAtLKGBk+7PZ9ilnKWkYS0e+cnfCrIsXJbOyN00FjEoBfKZVcrQrM7hobmQiWda7oLFtNDnhvpESKFPHKhT2xLeNg96M2398HV6EICxBrBh7ZNgu4J5pNsiRfuWv3hTiLfcDs+zhWgVZhlj9ecbxQWsUuw9WVHfJbOYndmPSdjoe3AeU1qLPIp/YkjEQlzpkrD2RPn4jVRi40YuHQE57xM8XJtTRjJFDAzsJuoNdZLEPElaEGPO6u//VQuPp2s74Tu+r0Q/VskY+7qP/HGVj5d+AONY5rhL1K2DkHVjNtbstecxRNssyBw2Bl/CflSEV5Hid2PufhY+U1qMjqIf1EXcT4rR2Ol0F25ZuOu2C+QPTSaTk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(19627235002)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: U0vkux2Pj45vRXYMhE4SNu+2JhHZniljlm8TUsgfTqJWoV2C2+PP2QlEFUW3M9TtCTnguRbn2X0FD26mlixq+O+uqtqrftTCPLcJWR3p8IaPFOT2hW4Y7Zo7zSg2+sj3gFoSK8xZuMtZj1LbeXFIaCfSypku/okqwE45ePI8YQ5Gf2P8CpOAHVA1r20+eNyD1ljglv9IPG7HBbxLCwopcC+1Mp69RvfF3PQ2aYl2FpIx9FiFhOLy6s/5ZIwiVk5G3gvUlek8MIK+ojO27Ovl7qCzLcQfwePy0YbsDfcKhy4ldFtym28BjaX2fX62uSi3r4Hvoxb3sYNsW72d11UY4hcLmX/hwdmFh8u7+o9PXK3UZmUlfDWvUtaVLuKE1rNW9reQLK2WLCd9t/+sN6gSf3V4lC2e3B/L2H4E7+gAfOQYZmC5l15MnLQ5JswgjEa4TpYK0MB9xYD1MOO541N9PuO6oIq2n3XjXA8l5iOgbx++1nT4KI+l6cUndCsKSrhIs9Ivwi1LvNIqr1S8EM6AcfdLoakP4EUAhdZc8S0T3pG+P4aJm+8k7rsFQKegxEy9Ev2a3xwRbCWBfszabIYGAsiuG3gz0hX7rCLeb1zKdxLRW3LfUnLTdrrvbBn+Ex0CYw8EuuxGG8bUhyNkgRRvJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6edf8d-ea6d-41c4-8a5f-08d871837592
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:50.1466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSgqNujhHR/y7AILIwUWmpysi5zFpmXfzIyY866M8qhMDenVoACZbALmSvBLIQvX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As this is not needed for polaris.

Change-Id: I837f480622fb63c333c04cc68e449447fd7e3fa6
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 5a0c227f652b..e6099c2d3c11 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1865,33 +1865,6 @@ static int polaris10_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
-static int polaris10_init_arb_table_index(struct pp_hwmgr *hwmgr)
-{
-	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
-	uint32_t tmp;
-	int result;
-
-	/* This is a read-modify-write on the first byte of the ARB table.
-	 * The first byte in the SMU73_Discrete_MCArbDramTimingTable structure
-	 * is the field 'current'.
-	 * This solution is ugly, but we never write the whole table only
-	 * individual fields in it.
-	 * In reality this field should not be in that structure
-	 * but in a soft register.
-	 */
-	result = smu7_read_smc_sram_dword(hwmgr,
-			smu_data->smu7_data.arb_table_start, &tmp, SMC_RAM_END);
-
-	if (result)
-		return result;
-
-	tmp &= 0x00FFFFFF;
-	tmp |= ((uint32_t)MC_CG_ARB_FREQ_F1) << 24;
-
-	return smu7_write_smc_sram_dword(hwmgr,
-			smu_data->smu7_data.arb_table_start, tmp, SMC_RAM_END);
-}
-
 static void polaris10_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
@@ -2118,10 +2091,6 @@ static int polaris10_init_smc_table(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE(0 == result,
 			"Failed to upload dpm data to SMC memory!", return result);
 
-	result = polaris10_init_arb_table_index(hwmgr);
-	PP_ASSERT_WITH_CODE(0 == result,
-			"Failed to upload arb data to SMC memory!", return result);
-
 	result = polaris10_populate_pm_fuses(hwmgr);
 	PP_ASSERT_WITH_CODE(0 == result,
 			"Failed to  populate PM fuses to SMC memory!", return result);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
