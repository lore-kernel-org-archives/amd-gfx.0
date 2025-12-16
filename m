Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED55D5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D981A10E4CB;
	Tue, 16 Dec 2025 09:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7Z9sm09";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011067.outbound.protection.outlook.com
 [40.93.194.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B8B10E4CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNG0CPvermbUx542/thWS9yzBVvCBIPT8dCcOTSq9ADpIZrAi3GCtcDK/cLlpX6nMufK9ymn0aI7XGxbwqHCY0RzGzCCdOqXR5QToVS/OnET/TcY7JzeHhdmZ0e+kR2tieh2pXHE5Jds4w/P2c1hLncA5MM7khA1qIRIff+Y0VpPk6ImXMKkZkiIkAjYnR9kXDgQgOa5EAe2miki12+1rvmmRHXbfGWQOOtXoyG9WDrOWTKwp81jzd74BBlcDcIlC3gUBGpFYe8X8fq9YNUODLn5EFjz8r1CPcjrYw7cuJ6P+u1mGShOy+E7Iz+jNF92JZXghDrjOfQlcCA2woYTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQWuLTZhT0YdclMEm9Sa4rAS3eSQNX7S7bXkp7O/H1w=;
 b=DCO3em7PDKLPf5UDuh9HHvKtcjiih7p/gCDJ+QiuIpkOpTPJJ0TpPm0C7CkdapcV4I/zg1+4w3kaH9P69ZNl48H6YLLvE1MJ2F1nEb1O9h+6wzIIaS0MOlJ6a4odPo9GMB8KHBVfF63MPcAynzuOqBN5LrznIHI91DYOLqYDcmasTvOsuofEc+yiWruTrNE1dC9wZtE8s4aHLH64kuEEhCtt4fO3x3OcPbiDHVGIl45KZGx1jUjzqTxDUw27qOXFEjtNyuaZ8pHDgOYfV6MOtGNYxpjQebv2PLVprbtdNjeGbZVGujwzD5yCK4eKpllfkK0hPTWxZGetDGJeoMNIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQWuLTZhT0YdclMEm9Sa4rAS3eSQNX7S7bXkp7O/H1w=;
 b=R7Z9sm09U6jHMrbHP0rJdbHJJEZHIFS3+rEY3JIfXgjCnMYCSZjsRWl2zNLx7cbNxys+l8wcqGiGPueZBSoM7/ruR/oWLTyI5mvOUAcgG6koJRA8FGEq6vTJkgL4OtbqHeO2FMaF1LA4NOOEzU4vrmNhMZxnvw6k86dNcBPFmJE=
Received: from DM6PR02CA0090.namprd02.prod.outlook.com (2603:10b6:5:1f4::31)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:57:48 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:1f4:cafe::d2) by DM6PR02CA0090.outlook.office365.com
 (2603:10b6:5:1f4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:57:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:47 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:44 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Kaier Hsueg <Kaier.Hsueh@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Fix P010, NV12,
 YUY2 scale down by four times failure
Date: Tue, 16 Dec 2025 17:56:05 +0800
Message-ID: <20251216095723.39018-6-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5509a9-0cde-4068-55dd-08de3c8991a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFl5RFp1SmFBYlY3Z2doWTBSMzRuVWk1SjYxR0R3amR5Z1cvNjVyUlRYZ3BS?=
 =?utf-8?B?R09ESGtHRFRKRzd5RTM0QmNGTnllK1VpeVRQRWdLOWdGOU9GZy95ZDRraUhK?=
 =?utf-8?B?ajNZdnJseDBoeFoyUndtVGpOd1V5cENxQWpLMHZyYWdrcWFZWEwyTWFwNEZE?=
 =?utf-8?B?TTBWUGFtdjg2MkxnYjVxU1ppQjRnRGtqSFIyVExlY2JtSXFFdTVFY1BuTzNU?=
 =?utf-8?B?WlNldmdPc2JhK2d6VXdCQVpkamh0c2FUVzBvS3psaDZWRzhQWi9mQW5XUi9k?=
 =?utf-8?B?YkI5d0V6WHBJMU5lakRDaEhwUS9kczB6WjJkZml3UHNyVnJ3VTE3d0h3UkdB?=
 =?utf-8?B?S3FieDU0dnMyRVJYUTlya1NRWXhadGJaK2Q0S2svU3BMU29VNlFMY1dJTXo2?=
 =?utf-8?B?cVB3VnZ6QUdncnh5dXorazdCRzdpeHUwM3dYOUtNSjM0dm5VdDhnQVZRQXZy?=
 =?utf-8?B?dFFDY3BscjNaNmp5NUY1VG1LMTNIZWxGeWtOblBzRXdhNjU0NHdvOFc3b1hu?=
 =?utf-8?B?YVBOalRWWm9vOVBsc1MzZzFhemFDOFNwT2ZJbkhwUDNBanhSYkJ6NXBSZ2p4?=
 =?utf-8?B?Z1creTBUR2Fkb0F2L290THhSaklSek4rVHEvbDNZWEZ5UHNnTm1LSkhnQXNF?=
 =?utf-8?B?YzJMcHY2TnNOeGQ3VlBNM1lMakM2QlBaR2lXTG1DajAxbGl1R3h3R2VhRjNk?=
 =?utf-8?B?Um5CQmt1RFFPclVJcVVuc1FsbUhmRVlUWkhkUlZJNEJkTUQ1c3FPU1VyT0Jw?=
 =?utf-8?B?T29kQlc4Y2Zpa3NBYmtqaGx2TXFISytybWxIYXVWOTdNUi9VVUJMTjZXTGhj?=
 =?utf-8?B?N3cvWDZ4TFpUQXZicjZNZ1lVQ3RFbFQwYmVqRkxDaG5YWUs3aFBZaU9Dd0hG?=
 =?utf-8?B?VTFBdmN3T1Yyb3NyWkdFenpKZk9SbDhnMmpvaENBT1dKNmxUUDNrZjY4V3pi?=
 =?utf-8?B?K3BkSnYzSHRJOXlXaGd5SnZVcllYbXo5c0lvWFIyK2o5V2FxeFZiRkxyN1Q0?=
 =?utf-8?B?SW16eUx0aVBsMGNGbjRSVVMrZGEyVlN2ZjhqbG5RQitob0ljQ0ZFTzFrUWxi?=
 =?utf-8?B?REpwUXNWTmdONjNqSEs5VTRhRjR0ZFlRajZSaWRPZFYyOExnOTBTVDZpM1ht?=
 =?utf-8?B?amtrZGU4K2lLbGdpQ1RFSWFzZzNGdm93M0VlWFJ0NzEzNjVISVl0QmhQZVox?=
 =?utf-8?B?TnFlaVhyUm9Mc1pJWldhY0NTcDE4YUUyZ3UzTi94OWZnbWlZeU50anVXOTV4?=
 =?utf-8?B?bVhrR0lhdTdjb2ZFNEc2R29nblhTakU2SG1EclpwTTcrVmZBMDcyN25oSC8z?=
 =?utf-8?B?Z0QwaE1XUkhCZm9XVjRQVyt6YklYL0ViRUxPakRJdktlSE96WDVmelp6emQ5?=
 =?utf-8?B?a2ZGOE9nbjk3eHBTRk9Fc1B3eXdVMWZRTXFTK3hURm5FeHd3bTRKb0VlVklN?=
 =?utf-8?B?Q0hpSk5pT0FxZXJCelRPMklqZjRHWmFhN2xSMTd0NE1vSkZmY0p3dUk4bDVr?=
 =?utf-8?B?TGMzWkR6cThCV1p1bUdkMjROb1VaOHRERXk1WGc5Q2FDY1VZb2NMMWZndTU5?=
 =?utf-8?B?SmY5eTYrUzgrY09pQlNjZzhkZzR0enlBVEhmZm4rVnc4b0RJcm5kZzJUbVU3?=
 =?utf-8?B?Mzk2ZlpITU9jQ3lHTEY5anRYZ0VMczhzQ3dUYkxCQm5OSktuTDVMUkJFcmxo?=
 =?utf-8?B?RlhXSXNCZHhTeFNLR2ZXb2FmeURKZkUyMlh0cmh5c1VtaVdMRUJlV2tvWllo?=
 =?utf-8?B?VlJNOEVJV1lLS251M0hJQ2tPVUhFYnJCWkhkd0d5QkkrRTdNa21Yelcwcldz?=
 =?utf-8?B?dmVnQVpnMHRsMzhId2gwaThkbnFGbnRNOVFCYmwvelhkQmUvZGZUSy81UnFa?=
 =?utf-8?B?VjRUVE1haG90S1RidTFFS3Q0S09IQ2lhVzRaZlNPcngvNktkNTFRNEJweVl6?=
 =?utf-8?B?UzJVSWtVWGk4emlnRzVsdWNoSDlVd1FuNEtKVGc4MTl1QW15QUhCdHlZQkJB?=
 =?utf-8?B?RnhNMEJ3T3JETUcwR0Q0NHBCeWlxYlRhV0xnMTRkWFNyVExkTHFqNWw2NmlN?=
 =?utf-8?B?azViNE1xVERpKzJYTWlJeGdwOWNmMHFpVkExTjlubEtzWDk1NjVQNTgyVjd0?=
 =?utf-8?Q?6qjE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:48.4229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5509a9-0cde-4068-55dd-08de3c8991a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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

From: Kaier Hsueg <Kaier.Hsueh@amd.com>

[WHY]
When performing 4:1 downscaling with subsampled formats,
the SPL remainder distribution logic (+1) overrides the
upper layer’s aligned width, resulting in odd segment
widths and causing hang.

The upper layer alignment ensures the width is sufficient
and even, so SPL should not modify it further.

[HOW]
In dc_spl.c within calculate_mpc_slice_in_timing_active,
add an extra condition: Skip the remainder distribution
(+1) when use_recout_width_aligned is true.This change
respects the upper layer’s alignment decision, prevents
odd widths, and is a minimal, safe fix.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Kaier Hsueh <Kaier.Hsueh@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index f506ab70a307..d8aebaff7c3f 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -226,7 +226,8 @@ static struct spl_rect calculate_mpc_slice_in_timing_active(
 	/* extra pixels in the division remainder need to go to pipes after
 	 * the extra pixel index minus one(epimo) defined here as:
 	 */
-	if (mpc_slice_idx > epimo && spl_in->basic_in.custom_width == 0) {
+	if ((use_recout_width_aligned == false) &&
+		mpc_slice_idx > epimo && spl_in->basic_in.custom_width == 0) {
 		mpc_rec.x += mpc_slice_idx - epimo - 1;
 		mpc_rec.width += 1;
 	}
-- 
2.43.0

