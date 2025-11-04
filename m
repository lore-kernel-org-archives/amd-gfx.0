Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74AACCFA08
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B002910E584;
	Tue,  4 Nov 2025 08:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fwr3cL0X";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB53910E568
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhIXSpfna2zYt+lBHgUXnHdyldE65G4B9krrX4ZBjx9k6dknjppmLsh69CGzknj6twbt3PPjJb5Coj3EIRd+Sp8SEYDIx1oWdrLVFzMF5fsR6SNlNZ28yAP5IH3a5D6gohIeXAnWViAWTpFI+0hEbFoC4+hBFPGH8LJNVuuU6DNZTN0uoDhCHbomtfleZ8lS4/IckA5MTWDDZkQfnvRFOR7pC5eVB9UgvVTLpor6YPezstAW52ZRHR9Ff4AXtq192Nk3TLid9idjAT9XA//OBAFZ1F2IVQNHM5qFAeXE7DbtU0+Ge0IKNqu4J7//ThTvE77wPSYUoIvYXenYQRFE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7pbJpTBlYsvFn6W/JLh4VHPDMI8w6PwLwhmIh0Exq0=;
 b=VzKvpQ58ZdRP8Gc5PS0cpZ8xOY7T0YXDsDTYKgOCCzZrGDztaSMmIAndt217hvEmq8+fUfRVy9tKi0P2Nokv6XWCPrylspr6szpzZzhUiuNtzFpAY0DCo/mFZ2cSrHaxK/iDbZHfJCMgjGtU5BDO49E3Sf/3l/880xBBvaJ9P8uyt1ogjIwTl4hI3lu74B69N5ogjf3jPD3NDXE5ffD7yRXdcIpgR7OMmV1cL+WX06jHrTKTh2T1DHxvEN4KUi4f9viQn1mledUhraWG0p6lgkHEuMKE/BWSkdEd9tqnCo13nj+0pC+oWMmXu7FmzS21vHvw5Cp/ir7Uigxylh3RkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7pbJpTBlYsvFn6W/JLh4VHPDMI8w6PwLwhmIh0Exq0=;
 b=Fwr3cL0XIhGnDJHaIkMXpS+7P/eMFJjkPwaqMsqwFdGMHcIgNsFylGNFXQkUlqNO1k3RHM4+jmBJ0kZByyAYD+fXQT3w+QbQkCnWwW0P2eLRko18qvv3pfqOqPM6omB5N4cl8YeR9/r+EowxGNVUiWxZTRHITTGhxMH/eZsFRGM=
Received: from CH2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:610::43) by
 PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:47:19 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::33) by CH2PR05CA0030.outlook.office365.com
 (2603:10b6:610::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:47:18 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:47:13 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: try for more times if RAS bad page number is
 not updated
Date: Tue, 4 Nov 2025 16:46:56 +0800
Message-ID: <20251104084657.1412130-7-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104084657.1412130-1-tao.zhou1@amd.com>
References: <20251104084657.1412130-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 24558362-d32a-4206-15cd-08de1b7ec354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pAWp0Kjsv5+NV+UqwggD/S0P67K2ONj8KpNJZYzC+ds7+sHrmLtdZsEZ+eG9?=
 =?us-ascii?Q?1fcxZwxrt4CdYn0BpLPOE4i1oknQZfChKeSlhsLYWL2to2fPiPyLjh9Xj9oN?=
 =?us-ascii?Q?/vbKcsIRLUHAjdom60kqrxRN3axrBLz6jIctBq1tur3z3KgE7cAt0VNx88XA?=
 =?us-ascii?Q?gcDGLhoLiNJ4Kpt7ChEsq2s3Q7AP2wjv+VDoQiZppesUHv8SFpu23mtao2bW?=
 =?us-ascii?Q?ae0B5OEmJsjWsN/uAW2KBaC7zYy920+RYFGYxj9wFvV7NTAte95LQZg3QGdz?=
 =?us-ascii?Q?X6+j0UnohCTH6GERp6JZLsU9JfuLCNbF1qRS3rfpDjdYilPVwEoKbxH5fNNH?=
 =?us-ascii?Q?MCEB8jk4J7kfuSWi6qhEVD+uHPhiWxLzjHXNnO/OiIJELqWCEU/IluaG5qAB?=
 =?us-ascii?Q?afwPgqnr4rCudTOy7rwA7iFZtvcMJsqz4sEYH1/irWutDmQzm3cKR1Bn8W6I?=
 =?us-ascii?Q?VNCxa1Keg1CFgS5USikMrmeD4/HD3saWj6z77yW5iiHGBXV804i22t2uDlay?=
 =?us-ascii?Q?5tzihsD3k/VOWQJMGOEv34XZV8lmTEbUwE4wuQV5+obpTnySX1zEJTHeSWdL?=
 =?us-ascii?Q?+e2dDkf6NDSx2VZtfbSX/PyZuysA4FyFD5wGmSavfM/rdhQcSNrhQq9XRyn5?=
 =?us-ascii?Q?VzYCdY/xAH2Q1Gqfe2mIghwvLwrNfcav3DeB9ZiuANdy+Dari5o2yKP235mk?=
 =?us-ascii?Q?H72PVkEdpLD4n/0q+/VQvtDgEyro++UxouREl9qSDjXhmyufo8bxfPo/Fq+x?=
 =?us-ascii?Q?4/6mIYlFNi/EVxmiPo+PB7wF9QdcBuWgIqa69mh+CbkjkpP+S+YCBz6L7BzX?=
 =?us-ascii?Q?9nd89WpZgcnpR9II8Fj9/cis/02HUve8W83KQC2eqyKahJBMwduUdS2vH5NT?=
 =?us-ascii?Q?HdM0BteG3magtyJxWt/7/OOF7Yxcz9wRRPjhd4JXoS8NVZ9Yyv1aVCk/QRXr?=
 =?us-ascii?Q?62/BmxpznjVhFCavo3B9PnR/EFdEmvaHGQAsrv0uBp3Noj+JEcswTpsd5nxN?=
 =?us-ascii?Q?5BVe6OASKrp89v+u05fLiBC+b3agUGg7o5nqHfUMEHFqOcCsSeM5Y/USCv/f?=
 =?us-ascii?Q?ksirjUsANgPF404vwQJVbOaLyGhmYerNP/UAJr1an8e4QWJMDIX04Yf8wO9q?=
 =?us-ascii?Q?crqf6mzgRDSbACRZclwqRbmHs7claohLoUYrxfkxuFfu0QYwuVRv8HDf/NcP?=
 =?us-ascii?Q?YajQAd2h5yEsOWXYKPKBEP5KhugCdVsj/aByfdcg6jVljCQPyrJQiX7IFgXJ?=
 =?us-ascii?Q?KB7Ized6tov2TGY2FdxFpHW0HMfOZY4S7V4cAQgQC9CSZ1FF9JbZtD+xOYes?=
 =?us-ascii?Q?UFot3BtvWYVMlwWiaNqd/1+LHyZ4rhSpOI0wNSAEYFGALzNijlxxQ1K0F0nM?=
 =?us-ascii?Q?7pWmhqepFusflikPR3M/fPgSye1hUl0x5PgKQrNcbIotNnVE71xD73hPrFbK?=
 =?us-ascii?Q?lXAgZlcDmAvH6J8Jrqgr9hNJGXUBflas1MVZGKP/GDstM2eySkt1ksap+HmQ?=
 =?us-ascii?Q?RkKgBP+dVO3B7q+itK+hlHGUoOYfUgsm5XnfbHOzafAvrntuFd+7wqffuOgK?=
 =?us-ascii?Q?m0St4wz0Ndxh1t3lP9Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:47:18.9553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24558362-d32a-4206-15cd-08de1b7ec354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
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

RAS info update in PMFW is time cost, wait for it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 71eb5c2210b6..4e1bb804753b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -874,13 +874,33 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	int ret, timeout = 1000;
 
 	if (!amdgpu_ras_smu_eeprom_supported(adev))
 		return 0;
 
 	control->ras_num_recs_old = control->ras_num_recs;
-	return amdgpu_ras_smu_get_badpage_count(adev,
+
+	do {
+		ret = amdgpu_ras_smu_get_badpage_count(adev,
 			&(control->ras_num_recs), 12);
+		if (!ret &&
+		    (control->ras_num_recs_old == control->ras_num_recs)) {
+			/* record number update in PMFW needs some time */
+			msleep(50);
+			timeout -= 50;
+		} else {
+			break;
+		}
+	} while (timeout);
+
+	/* no update of record number is not a real failure,
+	 * don't print warning here
+	 */
+	if (!ret && (control->ras_num_recs_old == control->ras_num_recs))
+		ret = -EINVAL;
+
+	return ret;
 }
 
 /**
-- 
2.34.1

