Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A128CD3441
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EC910E788;
	Wed, 12 Nov 2025 18:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="THm9Tnho";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2126D10E788
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiVroWc1lojxHbozXiF3QAaG41yCYPB1NKEHG0c8RUnapTstJCbiXq8d/f+U8n1ASRQORgmGne9/q9GHKhRmT0yC0CM6elgC5wLk1IRv639Xkcpt6yLpkz7L2p0yytRmlRd3fGVC2hdEfBoM6A5fks5RpsXBui1D4tThovw8XBO8Nsj9NNWen95aFO0NBUeErHHgMxLnRp56fFRZOaMSAePdnKqlJ15QKV4RG2z+Mk0qAEpfhi2WYS+8lBDn554aQrqpgwFDHgYumanStEZC/err9BSdOO7RBOhrRaRqfMmtWuljM7sHQANA+goyw3uq4Z1Fy1BN80PzPctz2DswWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdSGjpbGulXHp4w8Q2evqJ1+C8c7t1nmQ/ev/Ed3ZFk=;
 b=tN8z83j7IVhq+TPMwwKFrOQ8vIk/8EklsWzDtd9fSOJEKf1QnBJt1NSUdmhv+4NXnD6RK/4YEELqvFPwberyWtiz9ARhTLzCtf0snQYYrq8f4+gBcAsEPEdsYLpy7JrdDnWk5kkBELy3PcDZoBb8VyAaBhe+rknAwoWPky7A4/cS4TntN+YMcPKyOcNxpd0ypF3S7WV0BphEr5KGA1nhZ+9MGlj0PWNAgJJOm5eZ5EJLL8M1nV6bMo40pcZ5p1v0IWyX7UrWA63JRWDoj5Tk2TlaLspShcXAcjDusQAGJq8fJ6YB9kiYMZ2I4ueKHqpxD7Rx5psurcQn2QYfICftrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdSGjpbGulXHp4w8Q2evqJ1+C8c7t1nmQ/ev/Ed3ZFk=;
 b=THm9Tnho3GVdsyyfggzljM2ieB+pzbtY3yNukwHNC2bEKroWuW/V5e10M5ryLxEDqawaSjNPurKEf4Mn9FHgr2aIiuma3UCImmnNsLet9HGElXDX0wcfp5Yde37HzQ8F401ysz2QCd45smB0OOzbstkoVaDHlW78kPgoJmjVWRA=
Received: from BL1PR13CA0247.namprd13.prod.outlook.com (2603:10b6:208:2ba::12)
 by CH1PPF0316D269B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::604) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:22:59 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::2e) by BL1PR13CA0247.outlook.office365.com
 (2603:10b6:208:2ba::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 18:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:22:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:55 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:22:55 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:55 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>
Subject: [PATCH 13/16] drm/amd/display: Check DCCG_AUDIO_DTO2 register mask
 exist
Date: Wed, 12 Nov 2025 13:20:31 -0500
Message-ID: <20251112182212.559007-14-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: e622ba43-13b2-4937-db03-08de2218823b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0rFaQDHla5rvgphX2QlA4h5QktsaaF/mpeNbOU64JgtALymUmEGKFnSnixF3?=
 =?us-ascii?Q?lJQJBjMiL6yhJ7YUJYq+6voFA6IctvmF0Kw09fc6L1p+2t7gwFuEClz15mrR?=
 =?us-ascii?Q?yNMtf+lXR4TjLRFa065z0hk8wBE1USW4FXW3f7nmYaWDUMGcbqjJg936+BQ2?=
 =?us-ascii?Q?InoqUVBmjOExM/7DuSK+Cy74ZtUYhzY2nZheWUoHeiVOY0EfV5RsV5ntWjWG?=
 =?us-ascii?Q?P1dyx7RoC7j+/Y1sYt+JMOgZ8KplN07PgrqfZ4DsZ2QvGOKlHR2Ra2fs2Ula?=
 =?us-ascii?Q?gSIwm+2BFtrvPkVlPo1kHnlCHuyv5yqrFODaxbkGstaut01e4LuvpLFbNySD?=
 =?us-ascii?Q?F/vSK/oacup/kvh8RmPSrAWJp013to5K4ahbSG4DxmpIPUS1BgjCu2cWDpwf?=
 =?us-ascii?Q?pttsVhe+gCiSJiLiiyqUWVCDVk6RpHAt/XnR1UVNx2FzrLPMJoBIEDFM4Nct?=
 =?us-ascii?Q?PQaqsCN/IhGqX4Schdk/E8lOPezCV1djPYC24PkKzRcPfrR98Y2RyKyys19I?=
 =?us-ascii?Q?pRUR0umkyGVK3OHtB+Eez6xtXNCAvTDUy/MqMhRH6SWF9VtmZ5bg30nL/joR?=
 =?us-ascii?Q?CDX0bLfNiupXV2zZKzmewsjfBNp89nw3PWnLDTZFELjkNU+iLXYeh0UTmKwZ?=
 =?us-ascii?Q?RhnxhqDd8Iu01EU6CDroxFqD1qOXFNmPMc8hp7CxpOV37VB+Fg8vYTI9vwBB?=
 =?us-ascii?Q?BNHS+d8X0D3ePsG3jtQfHjWDJHSYONXExKP55wfK1eqNBLYtlGh58FnL0JHF?=
 =?us-ascii?Q?XsXbm0RnKM65xZKqj2hnPRDqfQNUse1iFTpLbmvx4SYFsWN7pZv6oelHL5ho?=
 =?us-ascii?Q?7v6kvuBc1V+Yrj5nLOZfWMFRGNKY5uil9QC3Gapr8rv6VU5smHtxk3Ux5OVl?=
 =?us-ascii?Q?G32CEIRpFG/OBC7DhYSFPZrjmy6fDusOHLc0fBGcJfRnvYQGuutJPdR4AlHR?=
 =?us-ascii?Q?lW1vfHq/QFAZVoilNUDbn/Fb+6f0M7jfmT5e647chZNH8XrgFMATCSbO2yl1?=
 =?us-ascii?Q?9MX1uWqRxmotvr/0rpYSb0MUgXeMsuORRT4hYgeOA95XMGg3IQv81RobNLsB?=
 =?us-ascii?Q?hl/8y4F9sC7BOV3ym/Fkd/I8fh+TLGXd+cvPesySieeSkDA2JHIFrEb2/dsF?=
 =?us-ascii?Q?G1a5wcbUxP98Q5io0JGgFN30UdE0hs7Dhea6Gw0eGgII5jTQ69WRZ2DCQwQv?=
 =?us-ascii?Q?8htPbIdTl6tT9kcWgyAKZj76rscji2wRVBLcYRH9RRnvrU877ctuEfnrswAB?=
 =?us-ascii?Q?6yHNr4EiD4uvwv0zT+tZ1p+xmtLRmaImpM3ycqKXKi1O3hV7sGRXQJadG1FC?=
 =?us-ascii?Q?AsdaMpmiBcg+b4v/NOaB7NBJSawiN+IzdoKsXkBmhfQ3VaUWeWVo+uyM4kV/?=
 =?us-ascii?Q?a8fYBu0fRhs5M/ZMdvvKtze1jYbc6v/Ivb1whSdt12m+46zuJ8JdZsFZGHEK?=
 =?us-ascii?Q?1MAb7aT4T1ZmZJB5CphbkfzBzRqKRaGz3MNB3hrbLKPQPlB22mkvJlp8bGtp?=
 =?us-ascii?Q?m5B+cCqxMYexb3K9x8HDPymn0iW1v89+JscVeNgwRU8WjG9v/lI1CWh3bvJ2?=
 =?us-ascii?Q?GLSVqomcA8NZsYVLGfg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:22:59.2269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e622ba43-13b2-4937-db03-08de2218823b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why&How]
Check DCCG_AUDIO_DTO2 register mask exist before access.
Also,  add a existing DIO_CLOCK_control register for later use.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c                 | 3 ++-
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index eeed840073fe..fcad61c618a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -1143,7 +1143,8 @@ void dce_aud_wall_dto_setup(
 		REG_UPDATE(DCCG_AUDIO_DTO1_PHASE,
 				DCCG_AUDIO_DTO1_PHASE, clock_info.audio_dto_phase);
 
-		REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
+		if (aud->masks->DCCG_AUDIO_DTO2_USE_512FBR_DTO)
+			REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
 				DCCG_AUDIO_DTO2_USE_512FBR_DTO, 1);
 
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 0fc66487d800..e1fa2e80a15a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -227,7 +227,8 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 #define LE_DCN401_REG_LIST_RI(id)                                            \
 	LE_DCN3_REG_LIST_RI(id), \
 	SRI_ARR(DP_DPHY_INTERNAL_CTRL, DP, id), \
-	SRI_ARR(DIG_BE_CLK_CNTL, DIG, id)
+	SRI_ARR(DIG_BE_CLK_CNTL, DIG, id),\
+	SR_ARR(DIO_CLK_CNTL, id)
 
 /* DPP */
 #define DPP_REG_LIST_DCN401_COMMON_RI(id)                                    \
-- 
2.43.0

