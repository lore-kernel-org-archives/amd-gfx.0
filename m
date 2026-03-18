Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3C5FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5BD10E5FA;
	Wed, 18 Mar 2026 01:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m4HWxh0G";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7EC210E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtOB5Yi+KrrSVoL0kUNIg1mblTZzj1nLPb1z9iIk+vd97G+xh8EpHbSthNpGUs+BTqwl0HDPrVkRydQIv8rakBUfQH9Fc2kp33oqPJO7ub20knoyJv+W8ccIso7iILS8GZ53TXoNDm8o7f2wvpQUD6a9pNEO12D0aH31PunQaB62pdR6nAlqt2UL4qzwQsw8hI3mUy71hS45xhndIAPrQ/BfwzOipCKnWTphkoc0KVdx8pcG9rzQX+cfQmpFma8EBOfwED9HgehWIosKtWNJYKVSa8Swk8zapPw2EaqIv9B1AcnPFHOQX3epW4QVH68hHiDVFXr3Ku2vBgc9UIrFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH/5vU1+6WCXNOmumficV8Sh1bP0l12tDp91PIB+cX0=;
 b=rdXA0gE8jmMdNR5Bq5pOPPaCaEayWemrBUPDVl8ZLSKz+spTSsmlKle5MEsQBLVzK4WAhZshgTkqKAotHhso8e7N1RgxPfFWSibIGq8eQVMsS95m1PG0IdDp5AlWgsQb9lMGf2MW8TdCTqN37BnakQH9v5Bb8XouTFopmaLnYGln6eJWmmiSssZEZ814w6sLt2GpUTUg/XPHhuxxQYdEprU92LCAu7g/V4mnuda7IOW9Uqc3C0fZ2eZG7yC79EeX9auCiVCaD2vJIYEdSyDMO8sLG5MO9Ysa5DP/ki3fd7+FhQjXPMFEdlPSQBlQ1Nq6faqVg33F/qBb8K1oEKawCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH/5vU1+6WCXNOmumficV8Sh1bP0l12tDp91PIB+cX0=;
 b=m4HWxh0G6Rm/fXGguz8DNO69+KtfpeLJUkWaIi6ryIRSuWqkStaMyslYwIOphwmZFBNGiggG4GxLgfWnLRBR5pJlt3NxrV0Mu85kbJCEsO7WURwJQ0Nx+HNZvm8PUkUKpTebAdOrZ/+HBFJ3Aa9oevtKVuQQAop/De17lbwkeoU=
Received: from SN7PR04CA0202.namprd04.prod.outlook.com (2603:10b6:806:126::27)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:01:52 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::76) by SN7PR04CA0202.outlook.office365.com
 (2603:10b6:806:126::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 01:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:52 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:49 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 14/31] drm/amd/display: Fix drm_edid leak in amdgpu_dm
Date: Wed, 18 Mar 2026 08:59:23 +0800
Message-ID: <20260318010224.513094-15-ChuanYu.Tseng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 2074ee38-da90-474a-d971-08de8489f156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lD4czpL6PPhrA/UDg+3dSNO/phr7+0jMTKsyha/Mf0mOLI8EWPizzjQ+avFZ5srzcoKabTpqVuB/6hiPP8KsjFiJSXyPhn8CP+P5Oczhxyj3xKB1vbbT86JpqAhpmt+YrTT+Pd2qDnDDC5dZRD99i4oDSBSbp1SZqJ30IHe83pLUuEcIxp7ltF2W6kRzzQFE+bng7OHJOMCupg6QaK8jTmdkWHgVXEyAIaWr0LokmOySSrFlWRztthhQWJ6P7Usx2EoBZKT5jyoGEXvKotfhRc5q+kQgyda1S0MoMIcQVTpxni17J142sbZvt9Skv+HkHtFAV2vKbDoshnpEc0qMhvEZphr5FepRxuH2F7OXnEOdez2utvRNzaDzxPyOyJPXAt4+25btxHCsDXYN6y6FaZjkWPalfCvne5pngxht2UDs6bBK/1N6QjV+oIAJjBzEYpHQFK3JzIyBB4qrj0oov5LKsv7iqglSbaLTZ0vgtbAXKEh0s4GCmzf6PRP3l1SKfSxbf65p+OpUfltxDXARfToBeH8S1Fg9r7sHHBOptNO+3Kef15VvVUU3g6heWovtYKLB6fuGanJ8JuMhw0m/8HFtT+k0R9YlwxiK0xcK7sjrCK43yNxebTNFeXt9B6iotUgmRGJ0D4gqNTmiIBVFT/VAaAX1zFWBQalloapQZ/mL82gYeyKg7MmbvWXux4U+xoJMrR8YNe6ID07BYgGnTjEnm8qQrGWr7LxEJGMzThSsW0alkTTaMoHmhxl2ocnIT+Hz/XKUan457wDBMALacw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Butxf8bD3rt6D2qZ84JotdT1Jb0w5ydSGxz/ABxJwxGScAFd+j+BeX2ZE3Y8xqYflbO8VpP9IwcilPQif/Wbi/NdhXceaa6tc+wR+EWFjDjHDNlTORDyG787HixuvV4/dRC3sioI59/OjXJ+qdWz0LmJV7SR3z3B5VA+Ra5mZw+xlYQot5RuspjI6nu+Z2c0GJnmPDP521AD2md9C8HN/k2v7d1VtRaF6UPWrCWOSBjwDdnPF8QEUWfglYtmxNj+KHVxgcYnV1KDJuZDXTt7bfvSAjfczZAFlIpPbYnIP02UTr64DkS83WnraCVHmjwrYbRhXsHu082gUz0uvJSToJfzmS9JYV6oZPI0RDEA5Wv9bItgvYGR+zU+mayUJhUMfuJA+oQ16HrVscL3LJ9A3qnxi9koKoO0dBjXhMJsGe3wB8khzGh668H//0OXCO5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:52.7229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2074ee38-da90-474a-d971-08de8489f156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
When a sink is connected, aconnector->drm_edid was overwritten without
freeing the previous allocation, causing a memory leak on resume.

[HOW]
Free the previous drm_edid before updating it.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index acdc4abbdddc..344ff8cb42df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3992,8 +3992,9 @@ void amdgpu_dm_update_connector_after_detect(
 
 		aconnector->dc_sink = sink;
 		dc_sink_retain(aconnector->dc_sink);
+		drm_edid_free(aconnector->drm_edid);
+		aconnector->drm_edid = NULL;
 		if (sink->dc_edid.length == 0) {
-			aconnector->drm_edid = NULL;
 			hdmi_cec_unset_edid(aconnector);
 			if (aconnector->dc_link->aux_mode) {
 				drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
-- 
2.43.0

