Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A7FD4337B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA5510E961;
	Fri,  8 Nov 2024 11:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0TUtV61D";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E7210E26D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBLB8ryk1LM9eJugB/ZthdqjuBbQBn5UziDd4YHcLpOCfX5h1NEBU3YCTneoDc50HwsBeAjbhl37BZyOi8rgesqzQcf4ubCqEce1TYOWJspo5bvYqTRA16vsTiQGmvOF3ceB3biLy8OL+lRiTrMq+46y/0sCrgIwG2OmqmMwzaNLw/uAjKAQHQVHienq55pzKXw/bab9sY1i1VyF8IBTcI39/ce+R+JEym37Q8CxYJUw3xhqlEwzuTw3n6sZTlNqAthTXQKzl1ix4LEDsbaFQQ6nC4AvXuclkyJtcm7Hq11A6w0+hMbNbQ1FV/PxQpB8Bu3hIyWDvQEQX4WCYXmRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv7xJA/sf0SU16KRFaA9/KlsBK5JhjbFXna3UlOZPb0=;
 b=dn6FAWgUmqoNFJGWYY1ohuiRTRFHH97jN21r8bLQNyhK/AC0sWw6/5/0fIvq58OovuSN8P0vOdwbgTVnCr4X+XIkk/ZfyKOxuQopcLp5E4+xX5dQIxRVMLx6TiDCJ1JqgqDa00TzUhHPBfDpnzy7+ni3j1lTDma7D0PfpzTnpsz+MWZa6Mx0w4vsKwJs+5d8Sf2/0NreG8hsk/B5FTSR1P9qmulggx9/KAExftb5TRwIDuR1Z/mBZnkkyjrfrFxfqoepY4LMEFm/PELrjoJz69NbYfJNb67ZCBl73HRCZoQHSArWSankL/gtT/8Io3rdbTOxv3wLb3JLgk7oCtPAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv7xJA/sf0SU16KRFaA9/KlsBK5JhjbFXna3UlOZPb0=;
 b=0TUtV61DkEeC2uSEYuw458kYbAapFM1AniD6F3l78wPAt/RiQyRQldbriLmBESIbPnOk7p+h+D5oZWbuocQrzzgWE7LU4hhGWvmPyun7KTNJUn6J4x3sgmYLDa+Z9iAiJ5Mfps2JDv+IcYc83g3hy/XA3Nbrl1gL364D3ghdifo=
Received: from BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 11:14:43 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::70) by BL1P222CA0013.outlook.office365.com
 (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:43 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:41 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 09/23] drm/amdgpu: add TA_RAS_INV_NODE value
Date: Fri, 8 Nov 2024 19:14:09 +0800
Message-ID: <20241108111423.60169-9-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a24f9d-3871-47f6-9798-08dcffe68bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tWc7nS+Srvoi2zp+t3WHPrY7ZxguG3FL0coQTJt+bzyQFr30YiOYr7uMlrQo?=
 =?us-ascii?Q?LeWs+01SgOqovtE4BFTzKhH/Hcl0plas+YZaPlAcI6bF9wBhBghwga1z5Yle?=
 =?us-ascii?Q?7eJwAJQrrld77SFyt99ffOC8HD63EBT4AqqG9ZQK+350Z0sdI7kf70+FiWV2?=
 =?us-ascii?Q?4Licnbk2XZcwKWxSbPmUzBkbhINMHalb96TN7ptGE1iWTcP/Mgy3F5vYDWDt?=
 =?us-ascii?Q?Da4AYCYZJ8GXNRBGyM2+RpFi8g5YtZBDlSrFwV49F96RT3fvLYYGKol0XyWl?=
 =?us-ascii?Q?VIqKLV64x9nXa9FpqPWWC9vfmy09qrjU6OC/0Zt8sTwNEku8l7yRefoyIE2R?=
 =?us-ascii?Q?wVdUT/5oKNR8R9kvgpmB9dgJnRSuYTwo8sVOQxeIipa14I66hbbuVAMSmeBh?=
 =?us-ascii?Q?zfYybh5TJOilIhAj++EIbxTgc+wz2bR0FiRIt1aYFJtieZayC4uLcw9GuWP/?=
 =?us-ascii?Q?ZVXW2rkODrut5LaaTtKB4Hn6ZzhB9g1uovT+2I3GKoGj6npch46R7oHSCV7R?=
 =?us-ascii?Q?jxT/F4nMNQWyAp5ho9nLnY2hc6QRVTMjQBHxElxEr/hnUik982L9rEoYDMQS?=
 =?us-ascii?Q?wJqCfiWPS//kFUPVKpyH2kdGcaQqKzXluBlPpzHNr9gnviGGwr3f8b4MtNbS?=
 =?us-ascii?Q?PEiVheRA+rlZRqr1hIcHkmar8YeJTN7AdL0GbDX0YQHddmC4ude3XrBxTXC2?=
 =?us-ascii?Q?bMDXRp+L7+wXfR1tT6wM6aZTrLEdcGrvHqWyNfc7oYZ3JqqqJw6c5XXZr61V?=
 =?us-ascii?Q?yVxcGlIuuYV/mx91w90UEzXtGExn6W0razTW6CuVEGIkCeBx8MQuFhSBwANo?=
 =?us-ascii?Q?u8as+9U+jK/BPdsKYvznygbddZLa3y+eYF7x4vvRMzI+kzxdDpRP5oif/h3G?=
 =?us-ascii?Q?CP4dWV68tqgOOuh/2nzD0Hzsg77ZQmwtXqpFaw0FNmTxHa4fr5Li6Vud/Qy4?=
 =?us-ascii?Q?AYy+q9HJYiAS4TlUB+lQfKrNsrQB/YO18tR2ycIoLlnqokY61s4EkrhD9uGb?=
 =?us-ascii?Q?1nLdHYfeTQqwY3eXPeSBTRNtuyGXmiYKVJwJbUSi7ufaroj/m3ujb4lEHJLE?=
 =?us-ascii?Q?ymQyrtmBv++X0yF7fEllMO8NP4kdchziVMiLBlMUnd1BtxYpNiSYJMq81quK?=
 =?us-ascii?Q?K6j9TZDgyQ0R+P//IwKV5Z2TW0ewxi8GpK18sgDVehzISMAgGQWWPO2lptZj?=
 =?us-ascii?Q?6tvYD2kcRQAuBQj1aZgVI6G9UZLh3cZ0OSZ2cI/hizI0AI7US2QZOI88b1Zm?=
 =?us-ascii?Q?28DZF6biobmieCqMO2XYZ9xx28Bp/3KjCvdN///Fpot2GdRC2aDj29YGV8wM?=
 =?us-ascii?Q?TofX47jhTldJl66238zK8eVAFOtox/LJmYggSB938zqgvkl+0ScjT40U7TnI?=
 =?us-ascii?Q?do4vCP6RIjihEuyT+HRsWqKhk2xl4rJFcINgk260d6WC69AdGvWLzAgLDIwc?=
 =?us-ascii?Q?uojjyhJ/nkPsYLowX7cTj2zjeRJbzSIv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:43.4610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a24f9d-3871-47f6-9798-08dcffe68bf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
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

We can set UMC node instance to invalid state if we use global channel index,
and RAS TA can choose UMC address conversion approach by checking node_inst
value.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 21b71a427b1f..64891f099366 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -30,6 +30,9 @@
 #define RSP_ID_MASK (1U << 31)
 #define RSP_ID(cmdId) (((uint32_t)(cmdId)) | RSP_ID_MASK)
 
+/* invalid node instance value */
+#define TA_RAS_INV_NODE 0xffff
+
 /* RAS related enumerations */
 /**********************************************************/
 enum ras_command {
-- 
2.34.1

