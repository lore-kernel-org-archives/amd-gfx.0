Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD92D5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03AB10E474;
	Tue, 16 Dec 2025 09:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IZtg61QC";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0536310E5E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERgIvuTInaIi4q0V63UOcMmn7XfnC1/gn9IKB8Pheu+hdCBcL7m3FHqgCOFyHrIh/rVIvRcmCuD7KDzolupgRLFQQBVSLtGD7pz81Lelm6MVRltifW2/Zs7TNDRk6vYCJC/3CbLDX3yYqJCnlrYqVkE89rtEsUomiJAKMj88LzdazBXiquD6uF9fwFFXFbJWfqR0Qu2j5A2l3AfL246+giQvsaO9M42Mo35BZvIWUb5C23lmcQ8eqTHK5fjRIoseCJHlGVEyUzs0s9QGH3xuYOnxRFk0pW0KmB3DIR5QJU0edTr8epC3Eg/g5i8+5j/n7vWF3No9Ub/Sc3friGnkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg9Mcoxn7/GDeVD4O4JWfjTi28OUPgInsF9lQA1OgY8=;
 b=Yhcuqgxt4iRMHPcHBDCrQrNtU515vaQAsU2ir5xIMoyHSPHxzRNYY8Ny+R2FY8cDLHKtbvsXAnFsv2AGD44GzkXYpLjDuHFo8inAEtv9W3pMOTfyMEV9HGIhCT9srP3TqnmV6nVJJJYD/DqMigWBwLEzzdYc0L6kT3CTN9sGrEZYE0yDNUxgsZBaTnMxIyNZt4TxO9tLwagk7y4/pNz2ruAW/wJ8/aP4KD/RKmCtKeznSzDKhKqghJI+8AfpQrcZ4oygDB+OYloB4QFuprSFV5hU84sUXOIGLxOoOMrsVQQ0MF5Wq0yTIu7mouFYkNQAtyrgQtNYyDCkdAgB3MetUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg9Mcoxn7/GDeVD4O4JWfjTi28OUPgInsF9lQA1OgY8=;
 b=IZtg61QCtPUJ5paS+zooZ+z7g85z/Ytey28FWe0GzuD9PI1rwMfKIH/0tvYyq7mA+18NRMS3oLVLFNGTLLheorVcx9oSj58XnUkoeZSeG3zM/V+GePzAL1X44ebtMjA2Zh9fZXiSfcJkiI9opQF6gcDAfQKs4TyJL7uIx+j0jOc=
Received: from SN7PR04CA0083.namprd04.prod.outlook.com (2603:10b6:806:121::28)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:57:46 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::1e) by SN7PR04CA0083.outlook.office365.com
 (2603:10b6:806:121::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 09:57:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:40 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Dec
 2025 03:57:40 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:37 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 03/16] drm/amd/display: Update function name to
 link_detect_connection_type_analog
Date: Tue, 16 Dec 2025 17:56:03 +0800
Message-ID: <20251216095723.39018-4-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e25051-8472-4875-fc1b-08de3c898f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0r8EMWxyYU6hmD5b2eSI5HhF0Xu2QMLNPIGsC4HwS+cwiLeQFvRQ7NKPBKyD?=
 =?us-ascii?Q?kReRdaTTADrn35yCWLP+mzOFj9gjZpGd/b+Xt6P7DrG35VqobE3EkQ9fKskc?=
 =?us-ascii?Q?iNlOKMjvJ1PoESXh4CF/8ZoRSzuUg4Q0Wd+DsI+A9KRNjKrWRQ0h4IOUBWcp?=
 =?us-ascii?Q?VfekkTTpHLY9/jfRywAmbfzrmIs0LKb9PRB0bkJ4CcRyUoZ1AmEDJyasGbCd?=
 =?us-ascii?Q?kW/NftsccYx4+MTfsUct0NoWEUs9+8Kgp8TrLLwhO/O0fVBrnF4a9E8xznHj?=
 =?us-ascii?Q?Q62RfgG46EJTRutTgYlZYik4+oy84MhV2faX/EuuoL7ptKpa+Ek8m4m2Ai4H?=
 =?us-ascii?Q?LqXQwMHqEHAH1gWlp+Pgk6K0XYKYYKqXnE5EMczQrNiIjOoRvVGvSgXYxYZI?=
 =?us-ascii?Q?z2mIgDAyxYnjUrMNJyp8Fy9Rxta8Qha7cAantQ+C5uck5KES7jxdaeL+QJaL?=
 =?us-ascii?Q?QnXjD5y3pverpRvWmT7V/9WrMWSloFTPnGc5+dWyCr9lapKW7eplHlLioRxn?=
 =?us-ascii?Q?uZ5m6PWvxezn9Cr/cl9gEAw8u2dyJvAmoO1/xJxZUyOBl4BBS2YQ3Zj9DJ5u?=
 =?us-ascii?Q?a6lIBTI+h8u+qLY/fk2+fwSja38xrHgOq1XLJN2nGpHPrPRGqK3wP2kN/iW2?=
 =?us-ascii?Q?/eK+WnmCaErVX36iQFLrZ2jaxUKh2dr7Kw5SmEti8mnuCN8JDxni/Kajfiil?=
 =?us-ascii?Q?SH6jQulNhbxmSYFrDDKlIyl7X9hbSsCkfi/4cAg4opte25mX581DZ4LzOpOp?=
 =?us-ascii?Q?8d3ooN0KYnPUlwEs0JKiLZmVEmuPp+wV5wN5Tcv1G8uPGiOI/UofbBYTQpVB?=
 =?us-ascii?Q?tvQjbU9XxNUmiY1f1FzZpiRppscb83Cq3zOKUYz6KxIiBnnwopfV2Nj1QXWS?=
 =?us-ascii?Q?fjtChToUB3KGvfXSEbtnaCGr4XaY8e62itFb3Bcir0mWYoGnb8cJWSav5fC+?=
 =?us-ascii?Q?QGThuZSmqFJxQyW6jk8n7wMUNRK4ffHT4ZaISKfW5ar0EyZJDOcyon1mgHb+?=
 =?us-ascii?Q?D3pyni1GAoaN4/gTFYdbbUvfOxOz1jm8tzkL7XrmIHyVng+ZSbvrY8VMbIeb?=
 =?us-ascii?Q?1hspW5o+V0/tip+EJjui+oBiuFGQoNGPcQQXNt0Tr4B1/f1zduZHoaqvmaBq?=
 =?us-ascii?Q?wO3qJ1qeAbJXoUwgtKyij644meIpoA2VQf7XL3bpSX6Ti/gfRqm2hWWRmvhu?=
 =?us-ascii?Q?1E1kQbIZgnVVBnEJ2eRmPA3OxhTgEAodjoF4JiaiGIsiwZc6D1ig5Sn8s+Bn?=
 =?us-ascii?Q?xzCGSvm7V806wKOLmJvLyahvIXiMTcB++UmMjpQ5WZTtfyMDp1UM3YO8NGbK?=
 =?us-ascii?Q?YHV/DSAI+YrGsNT5y74kDe6W5hGXcrXOAojuDMoXeFeFxjJUt91PTvi+S0pq?=
 =?us-ascii?Q?U+ivb4SPG7uZRwsGZuHnjV6sCTtDmvtV/PjWw8qFFaCMpTexaBe8gMMlX+pY?=
 =?us-ascii?Q?Y7IC/yPZU6PUYh8Uqf66j5TaZwf3SU/WcHQ6HV4a78sDauNQjPVLx6od5aOV?=
 =?us-ascii?Q?0R7SpoqSnUwkBCJZtm9BW4bOQPDx9nRa8pJtER5FMn0LlwbyognlbQb71qhn?=
 =?us-ascii?Q?Lgf1lwMy2DMSC7YmIos=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:44.2141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e25051-8472-4875-fc1b-08de3c898f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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
Update function "link_detect_analog" to a more accurate name
"link_detect_connection_type_analog".

Suggested-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 080642dfde2a..bfb5c1c886a5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1365,7 +1365,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 }
 
 /**
- * link_detect_analog() - Determines if an analog sink is connected.
+ * link_detect_connection_type_analog() - Determines if an analog sink is connected.
  *
  * @link: DC link to evaluate (must support analog signalling).
  * @type: Updated with the detected connection type:
@@ -1375,7 +1375,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
  *
  * Return: true if detection completed.
  */
-static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *type)
+static bool link_detect_connection_type_analog(struct dc_link *link, enum dc_connection_type *type)
 {
 	/* Don't care about connectors that don't support an analog signal. */
 	ASSERT(dc_connector_supports_analog(link->link_id.id));
@@ -1417,7 +1417,7 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 	 *   (So it's high even when no display is connected.)
 	 */
 	if (dc_connector_supports_analog(link->link_id.id))
-		return link_detect_analog(link, type);
+		return link_detect_connection_type_analog(link, type);
 
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/*in case it is not on*/
-- 
2.43.0

