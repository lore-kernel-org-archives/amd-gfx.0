Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C9CFED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A57B10E693;
	Wed, 18 Mar 2026 01:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgKV5ixb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA49010E694
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYmjL1/bNwYwV7LePGBiELR49CnIhrhU/Zxl8IfvbqfoZ0ab6W3qgYIclYVcQK5IoopmON4EBLNv74HnQ1USoe/3RfPR6DKnv6cHscBflMQOHOFk4v533+p0ptkA1z8KwVuOO79mXQ8iHrWjJbCiCd50BR/DhsEywfYRDhQTYs1wKuJg9pKJztj7kx2oQp2xYMlSm5qSIMnicV6IBYRtQ7oabfhcKM0XAt0mC1cJyCSt1ljOXJKRXgLbQvvyADkwxngfuaqMHwZqdH77BmwvFBvtoazpKm8+8CUSOiS0Qs96pCp0gWmh/2VIEOXFdqWfec86XJzQXnc1aX7+fZoC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nVm1wtZ/HslOERzQqnoLwpYHRTVs/WCWxr2uPfxpGU=;
 b=Cz147eWs87mAHIdvucuaLd2m7o5awAFp0FMcyzzR7KxlAqdfTxOIs6+HwL6x8mHPwaxtTpexKMZtSQ8MPHy3Zoj18AAm2PgBAlThLIRExPPaoluNYfUhUYgG4Lb3b5l5uxsXgg1A5ljCWGDLMwAO/gJJBph+un/Ll+6Zn7hsOcP9TGnVqdAV7ktqZ7V5jetIUgI/k0/b+33PX9C+CD77Yfg4ZRegDfc307xIqbXl8DJLVVWGd3741QPWDThXkRTO2WL9GrY9IxTCAGnNWUjfdGToObifmn8b3i0TCwpunVsyrbKERoKJO5rOLod3J9SMsWLtIVIbQ8dlMPp8gRYEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nVm1wtZ/HslOERzQqnoLwpYHRTVs/WCWxr2uPfxpGU=;
 b=lgKV5ixbMXF+qluONYUU66OJRXVpeLJljiS8WYGSSupeD5xZa6SKVpxH+ZZo1kL8jSHahrPOj+nhuDMS9/ERGtpdy/XVS9CHjH8+uYCt4wpfV2lNCEmt9lQA/JHw5T1abULCGRnxFY96ZlW2eKMD+Wui8mCzyBtlLKSWs4kfsdw=
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 01:02:39 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::c) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:39 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:31 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH 25/31] drm/amd/display: remove dc_clock_limit for apu
Date: Wed, 18 Mar 2026 08:59:34 +0800
Message-ID: <20260318010224.513094-26-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 54705a4d-be71-4898-bce0-08de848a0d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6H9nKcdrW/AQINha4ws5MTzqVB969GlE89T39v8KncOw8XlAWVCOUwp7CY6TSYpXNPSOc8RXv4Gk97h1FLwHwunirKGJ61jNY0dTgr/GkeX8H33j7MoZZ+ntSYfDqYs8b5g75g+/EfMUlK6N564eazqOp3jw8v4kZ9qqlGpnjrosQSzcbmstYPm5epsPIBGrpZzb7hmX+Lov7yxJUO8lpYUVfyfI3uL198t+NNSu014C7cS1k6QKduUMR/W4oyrc2NhIQFs2Y5+YcLt393V1kecWrDMyBTYpw/qeF8gIYQhys8jlSyddeFfoyCPpJpVjT5xHwnO9qzxWrLvmeiSlG3WPB5ukAHZYN0cFwOKfYAg40Mv9xMfvcspkAEXb9F6GM+xQ4H/nbPdcid2PdzzQrHKVmEvWBsdRsn5xjyQvwguL1re1/t+1RleOe/je170BkDHkuitS2+o4Yp6UCUi2oZVTnzsX2vCCtuexmJfzUmXEwuwA/AJ3FjDqQbQZsIu1B/Fd2/gEnqLIBnf73LJsUHRBo1OgnyXfCDKrDwb8cU27+Wm2M3uH5/MgzU3ZSu7/FdhYiywEUpl8DouNrtDkYy18BWjJ4JR3/pmIyr2UBXK9u12uun/tG5kWoNatNfE+pNktqvVTvRZW9HrFMJZQ4J39ABcfEXhcsferISIPTWPUCMpu8chmPyik+U/v50DBi7hCU52FBdzuzFP5Ydu+DvGf72fkH6ESUtdehArhxz4Lp6prCczkUI86fSpiKaeqABvOU1FlbunytLyaNSjAHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kKA5DObfwoaK0CZ5EIKor9o+kQyw3bcyYwD3Uwt8PX1W9NrMp/ZdPduT8CUr3Jn2BFmo2R9Ela6/yigu0SPWbyIHJKDMKaoEhcFiLwwoavT5zOiz1LL9Joow/i1XPng/KZ8jTVMPXZt+sPOfJbyKT5WHGmTqZiOzL8W+OJqVkp3DmP68gpmgNPw1B+fsTHu3zmnsvhhL7Vv2hSYLj/UWrazqsm7skU7pjqvhzHwvbtzB4e0fXHo7q+WxknmP9I3avvnbo9wpLQcGhNIR1d3HFNAgnC/wx8VSoRC2hAcwXghuRUX09QgtVPugJpx73yOirohkE/T/PKekQ/NXT70w+7ng0HHAd0Vsbb+iPEb9l7rY2im3k8TUMNSIucOiJZAAjhOQ6PHWYOXrBwm3wZLSY8H1WzjgPtdQ3fnuFF+aya7DxC6oL+ISFwonqM+QfxFg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:39.2313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54705a4d-be71-4898-bce0-08de848a0d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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

[why]
current apu pmfw does not support dc_clock_limit

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index fa5d0558192c..6328b3dc35f9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -2018,7 +2018,7 @@ static bool dcn42_resource_construct(
 	dc->config.dcn_override_sharpness_range.hdr_rgb_mid = 1500;
 
 	dc->config.use_pipe_ctx_sync_logic = true;
-	dc->config.dc_mode_clk_limit_support = true;
+	dc->config.dc_mode_clk_limit_support = false;
 	dc->config.enable_windowed_mpo_odm = true;
 	/* Use psp mailbox to enable assr */
 	dc->config.use_assr_psp_message = true;
-- 
2.43.0

