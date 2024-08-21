Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDD7C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4F510E709;
	Wed, 21 Aug 2024 22:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G3tZhTSI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B4A10E709
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjrJDnTXMVyXFtg9hxNki5x+yPPTCUWnEbotRzX2nafAQTChcA/QbPIbBKV198bv5yuPLcVhDomNXBkpDC7UZAVxeaf4nIFZzoMq7wWQJSJaN4sUA8tej6p1Iqe6U+1rDRhfxMRwdKdHvEu8DP2r1OZXE2R9+nOqFGjSTQNv+7sv1LN2rIxXCjTNwJ7MIzLIi/GkbYvLPoFTZNPHmRShx5bAaWa9I5fCWqMKxIruNpYY2BlfL7q0dAzlw2kg05OmwQNIE4aeIN0vqI8i4axLCcRn7Jn8Pz/68aLSVtT8N1nMaHiwHz78Jo3AWdfirg75RDQQwXYXHBMYUPEOXCcvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EbuJfgSInwLRWdzeNJbtj7fi53ZihFL6AtZ4mYh15E=;
 b=K7VW/fD1majgYAWL8DbGrRrKbeQ31Uw7FOuWXywDS+x5HoOpxZFjMeUu3RbLTn/f5EDQhAD6nnsf7Za9gOVWAEmSKzV6HPgpbDDuwGftuUhzW5x8XLbtHL1l0DoH40JKdKzYwyQxuP6sTaC/NqVj0NXiAyIweWyDixT24vMwy3T2fHCdtjpiBh18gbmv/uqCN9sGIyAbxK1NX5FKgzV9RE29I1m1QdLBtv1OFIBGbFtLwX9vgcYb0Y5O76JBDlPwAcf6qkmvdz9Upbls/DTRLEXZ21h66LGsaEiVORuQ0uZ5BiWtKNqRUjO08xv7CeW/U1bbjnrNGObNOH1NJypGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EbuJfgSInwLRWdzeNJbtj7fi53ZihFL6AtZ4mYh15E=;
 b=G3tZhTSIADWs4kI863mcn0aZ2BBsxF/X+0TsZ/bPs12O03TITh1d0gM+wCiJMY5it5pfNHIjPFuaB2ukZsSIwfRkCqu8vXyy/pgv10fTr6cIixIlXooYbzHDpDdzLy47uFuMgbpjNV6OkQ0zOFrh/A2IrIToM2mB+kiSwmIf8p4=
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.27; Wed, 21 Aug
 2024 22:04:45 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::65) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:44 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:42 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 09/16] drm/amd/display: Fix Synaptics Cascaded Panamera DSC
 Determination
Date: Wed, 21 Aug 2024 18:01:51 -0400
Message-ID: <20240821220156.1498549-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 639f8fe2-3896-460a-ae5f-08dcc22d43fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JugmsnjV99T/BitNpsWODHe970rMRamUiV16z6ecJTZK5rkTv/BANPcZ9Tgk?=
 =?us-ascii?Q?f5E7ZhSFhZMS9M6bERbp6zFv9JjBKVEUhWoK/W7GEa4cgrTM7W/rM/1QUS12?=
 =?us-ascii?Q?h9/jihu0235Z8EAmVxH89OHPahCP1ZEan4Ud/YsXQJk6XO17OGMpMpby3kZy?=
 =?us-ascii?Q?jM5o4GjW5uIpiAIkGaa/+xZ4K0AZcMxgNrI4YOvWnnoXLE2jLkgo4rC7On2l?=
 =?us-ascii?Q?f2NfDx7EhUF4rv4LPU63mNKnwvAxyszGYJFDlTLWkY30LRSsOREcFz8jxrjx?=
 =?us-ascii?Q?I0fRty+MSEUGWiWjquhOLwaNSxpLold4sDdObqHb4QmkT5YcSOXG7nJRrnzL?=
 =?us-ascii?Q?WCpsAPrcHNTH6qJT5+t9MvaDdpjZchZYf7fBsbmQbCkydor/i0ZBnCfk046K?=
 =?us-ascii?Q?JEMZNKNH1ULNDne+4bKAO0+MOytWxQvtvIJ+3YvdvElN1KhqudKs+pE7zsLH?=
 =?us-ascii?Q?pniJAcnlP73dHPxRL9LMqsbODLsHr8MnQUZS8Y44Lk3lOxRu4tb5K8KWc9nJ?=
 =?us-ascii?Q?LkeRe5AJdaN0FYZb+IG7Eg/BK3vgjfMyf2rgu2yhfa9+flBkW0GZ8Y+ojru0?=
 =?us-ascii?Q?WJ/UPgYERp+vbXsq6wTn4/T+ObcvxV1Hr4NO2v5SAjNtYpwOlCF/cPg4SaGi?=
 =?us-ascii?Q?NYd3f5sXaD7hsBAWnJ88yw01Dh1HikoSAC8GI5UDCJTLn4JckC3U77lQnCxV?=
 =?us-ascii?Q?xg67S8kitV5Xd75E5PEcMpcCqKhkWO+wF7tsuHwsmxpFkb1pP9mr2dy3COgq?=
 =?us-ascii?Q?yRZ3ixh2Jly1/8XBHHwlnlv8pUpCqwXP9ez6TcvFOoQ0UqMxCBV3v4au1Aiy?=
 =?us-ascii?Q?GMEsW+SiYh1s0S0ZyWu9iITV6fUGt8iY/5gC2ouxWq7lRbjTxYPU7KVQFcIB?=
 =?us-ascii?Q?XKHPA8sf/kv3jDINQ2diKIxSIqREfkQT//IMwXN4HoxaXTAi/6JwKNHinDR3?=
 =?us-ascii?Q?vmXJLH+nAjJt3mCsAk4lk4Ec228bw+wEvteIfBTj6xMoyI9M3k8TKcvfW35o?=
 =?us-ascii?Q?q/lwk9HZsS/OlXJoTxV8RreQkIXrmtu88Tgu1BD5+jrnm530gKoC7UMLQZjt?=
 =?us-ascii?Q?V8qKYyUaiw6zc2UcTlHkvwpjb5RyrVKl4qIGVPivutpjtM0A8u2StgjPrquo?=
 =?us-ascii?Q?d6RnE27Dbz59UVg7m+owGLU2+svJTbCsQ9yv0wD3bVkoV25tgMSdYJX346qU?=
 =?us-ascii?Q?p9ZXGLvxTm+GuLRVXQ6PIDBa5oSvBHcYf77JGb2SUy9sBrmNe7SLJJPKTead?=
 =?us-ascii?Q?9A4EaTmdmXMwFgxlhVcLiefFV+dks/MnBv/+4xZZumji6LAK2skCI0LBaezs?=
 =?us-ascii?Q?VjVZQnmQrDI2YbDffx+b3AbyvVv7d9Umu2ffv4DIwrg6wCyt5iy6WpuSrLgW?=
 =?us-ascii?Q?nzDRgDzaDkf+ukcT0rPPO85Mh8ZVnK/CfzDwcFJqnUPGrFmnRieKQl28MdwP?=
 =?us-ascii?Q?ALfb1E254BRP2YK/2xsnTZ5mmbYj3wfl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:44.9092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639f8fe2-3896-460a-ae5f-08dcc22d43fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Synaptics Cascaded Panamera topology needs to unconditionally
acquire root aux for dsc decoding.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 958fad0d5307..c309af2f6f24 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -252,7 +252,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 		aconnector->dsc_aux = &aconnector->mst_root->dm_dp_aux.aux;
 
 	/* synaptics cascaded MST hub case */
-	if (!aconnector->dsc_aux && is_synaptics_cascaded_panamera(aconnector->dc_link, port))
+	if (is_synaptics_cascaded_panamera(aconnector->dc_link, port))
 		aconnector->dsc_aux = port->mgr->aux;
 
 	if (!aconnector->dsc_aux)
-- 
2.34.1

