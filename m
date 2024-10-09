Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A00CEE342
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD10810E7E6;
	Wed,  9 Oct 2024 19:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ue09zS+3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA63010E7E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1amhU1FEYMCRNAPkqIE5V29Az9pAH/P3SRHZXyep0qfQLdrY0/mkvIoc1SEBGgk2lNnYm8+tJfl0fnO4AdhqIDdyzfTrPkxcKwO4vjxbuBGc2j+9qIrjPyIri7qfomJ99rGsaTxHrgLtTZdUwSXf+inUHEbpI6LdEggVq4KrhvKn77/o1dpi+stQIq7d8x/xroZzNNAd7mKMLZTUPPc+GhvOHtcrGrKwbBn+E3C7ExcBwD0+AM1Cfe+mmfJkfbjHv+oChtRyYesfDmWBUV9EbicfA3iB59XveCVFWcjEOTLPW2RN28CMWtBLHBkRCcOk9l7HBLoeb0wXw0qoadg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB0zheepA5MVr/Xch1vifOvNaOdYbiUuiBH7gOiu+tc=;
 b=e0CiSZyofMjqiwNYM1P38XyMM6TnZ3VLxOYSm2czxVG8Qy22cWst7p4B18stj+vMwTiQ3evOlQlJp0DGQJEHrQ+0B7oNE7QpZEu+GdN0sRIaa23yU9Q+/90RcqTuCQqKMWgKoN55gt70+d4e/9ZqExI+y2h74Kj8X/7SBFxS6yTYx56h18eBlMG9EI8l20H0tU/5XgOIRTHemY09OnW4vFm65iugW+kEcAogUFQvgSBlYThuxF3Hgz5uioPDCNzMxbbAQyTNlk7DXANZKaXY6FHn15+SdKer790FrJpjazAUX1UXaj5ZWNCwSn4B/K1tlfVXw2+qgFSEFQDCwftfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB0zheepA5MVr/Xch1vifOvNaOdYbiUuiBH7gOiu+tc=;
 b=Ue09zS+3Hgrbb207TcmuKXh+a+BSsgtwfS7jtD0IElinpXmU7xhvMwbnCG15UyfKdFnYpX+UMu8TkImyYY1jnw35SQGUIBFJVYmwvqEOf2qdCffihtkeoDFnL+PDJf2C1N7zbCyW5GW3xuGrX1IQHZ9CYfYYI5s43eD/NRK7vqM=
Received: from MN2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:208:134::26)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 19:26:10 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:134:cafe::91) by MN2PR16CA0013.outlook.office365.com
 (2603:10b6:208:134::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.30 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Wed, 9 Oct 2024 19:26:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:08 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:08 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 16/16] drm/amd/display: 3.2.305
Date: Wed, 9 Oct 2024 15:23:44 -0400
Message-ID: <20241009192344.650118-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b158a9f-84d1-441a-db21-08dce8983aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ogXlERQM5t8vddDDnxNnJ5eVfEv7ICuNg+w+oAml5F/YU4SyUfZcTQgCuvU0?=
 =?us-ascii?Q?sjbzkg5tG7PCziyb2aWWDBUtiscpcBi29pFfw17qse7AwgQuTWoIdtOsTvUa?=
 =?us-ascii?Q?wth0/seJAO2sGgKXfagSIBSxYwZ9ruDWfgtFTBq+48TgQk/WtqPozRQ9mLqB?=
 =?us-ascii?Q?FPxJDpuV/gOnSRiisqXqPsTB3xu3Qp9htoMPY/wmUOvE/8YG8xsoEp8ZCI3N?=
 =?us-ascii?Q?eLlw2HyJwNHAPJ6sS2wbnMavkLC468Sp8yvE1+2l8MWEOfil2GRTUq82VTTc?=
 =?us-ascii?Q?O/pdiHyCkYKdLO8kclFPJdOWHg7URxh2o65ldfVizuzBMwxnFwlvyZw//u0P?=
 =?us-ascii?Q?nTQsbGI8k92v8CuyNNB78mEEXA2zIzry2RAOq4oIWtM40955Ht3MOkUD0r7u?=
 =?us-ascii?Q?Q6Dh51PZMgtmVlayyu+oUULYq6DCyoTQqL/KrEi75ijoQpi9+REIAueHk/tu?=
 =?us-ascii?Q?gerumJcHTcdZWI2zD6X3atHI0u0L4h0p4RLHBhV5vCG9g0fyS91g/zQWbC0x?=
 =?us-ascii?Q?qksNfqbAnKEvV6y1ZoNhYw/u4553GaM1GsIR/duMy28C7paU3fcpEDL0ql6V?=
 =?us-ascii?Q?afzUeaZ3uNiilF853+AdmisxI+0rHxlNLY10+CA08ypEEyIn8C+LYqPN2UK1?=
 =?us-ascii?Q?4GWaDHFjSiSq5TuvZSLtnshNO+B1P8rBRKuc+8gDfc2apEt8cNOmgdfDn5SA?=
 =?us-ascii?Q?3f3U5GuW//xoeNsQBw9vHSjsS3N/eFqqqJv2Li2GgSvv2OU6X9NX8pqlAd4n?=
 =?us-ascii?Q?wlJLgM6unRTWupCZ5ccbkPSaYUhc9DUAD0CIsfmKkaukTNbigv1sTna+qiCu?=
 =?us-ascii?Q?YnDM6i3zwHa/MAGlse/7z8kFT/aJza/NlsTCuMXjPpCJPGaFelaP8QpUTjKg?=
 =?us-ascii?Q?sK/C7n5k2i6BqGHQQDyLnInrsSFrglv8Y5lxkVwz56GxDQKza77fftoPHyYE?=
 =?us-ascii?Q?htB8ZbIkAoDmxbNW4ia3kBSxYgQWTk59bdx9H7iDgbyc91dxuYpZUgivspXk?=
 =?us-ascii?Q?k0yNvdDlWQC8KZ3vyHwkMBOf+FnW3L6DxsT35MYBeGGpn/JAA6NUkh7CI4hD?=
 =?us-ascii?Q?+1237woMA5vohHJx4pSkfeidY8cJjgIxZio8nN99B8mY8URzqFSSJorpsqok?=
 =?us-ascii?Q?P/vISa2QRF1W9SAszF/NMC0jxNjeWtFnJO9Xm9nMxiEsKIe+EHWTIY1n7fP+?=
 =?us-ascii?Q?p48Vcj85IHsG8mRyZ5QtEo1DFKqmx1ilNghzvejsMST6IVmSnmc0T2Kq//DX?=
 =?us-ascii?Q?T4KqzO/3pCBkRU4xDFQ0xFaMtgK2FkZU23e9EV+5qIjXIH54GjJ++ydyzCVx?=
 =?us-ascii?Q?8aK1sdDsiXVqxVhFunE+wuxb1O3CtxFKNHSWJO7MyEfpgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:09.6026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b158a9f-84d1-441a-db21-08dce8983aa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
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

From: Aric Cyr <aric.cyr@amd.com>

- Add sharpening policy to plane state
- Clear pipe pointers on pipe reset
- Resolve correct MALL size for dcn401
- Read Sink emission rate capability
- IPX fixes
- Coverity fixes

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ad8e2a91c306..6ba167d4c785 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.304"
+#define DC_VER "3.2.305"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

