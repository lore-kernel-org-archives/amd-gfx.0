Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17536C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9AA510EAB6;
	Fri, 21 Feb 2025 15:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IBiXqUE1";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B95B10EAB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV73V6vNLLxs6JENgW8hmokGxIeqGGHJ/FA0kFWxfpD8DBX49O3et1JATGOsRBY6KM9n73uoL/lH4zmUoDu1frRCqaLoVS+1R8S5PjREzyev5V5EydJR0SjCWYIK+jhInENJoACBTEgGEuHJu5W4hzjgrLIhZh96mvmqKckn/zAQrC9y4DSqrWLiJ39uXuy6P58QP7JRrWjwibq9SU6JTl9rCIP+Strm6BXMLx4vz8ZjCuwNv6xUAMIuAuXoECRQvXQWoNRb7utyoASQ6r+xlFtyFvf6znK+0YNCn/Ku+rantd1pCDi7WTYG7w8bj52zMmP+yw4UUu/mFVj0/HtJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaFzVadW9edi5acaWsMFfIVs4IkIQOq5gtpeqyj/ty0=;
 b=gOG8I1+i3ANfq6taiM/GcSP76AkV2kXzE+oCJvr6LzwL8bLDNhDAnlzZbjvZ0CWgYCx+YJglhFGmXIrZ6F/S/Hw2S9ezVLmBgU4q9QRU38+/Hrn99DqD7FEbMTTFet0L4GLgQU9d+Gu2FXWDMtkMts/r2/DzwOiWQKP3qXAS0zuVeJ5GkDrzuHQaM0Me1zASIW3gU8ajiVZDU7/LP9osB5A1LUZGth5W3/SmLIA2Y5OvWopoJkyWlsew1CLloiNKyzxwtDcpogG8EbKcQbYZN43EyogODKh3it2rOkOaggW7LzAV9CuQXt68/k/gR71/AhhyvEL9ff9uxI4LHH45kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaFzVadW9edi5acaWsMFfIVs4IkIQOq5gtpeqyj/ty0=;
 b=IBiXqUE1JZjtXGTB1Yus/eDkb9Tw0ZfGiC5Wt1WWXjmPCTrg+akHYBZtyg40hYo6CgTmPYgghCi9/64XeAN7kCnNV+/9ppHEAXpaDhw33EObiwby0OA+fSv19FI6LK7zbTyx/Pyem5FCb7QeCkzlOZfEceHQFSNciEYERz01HnU=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 15:43:44 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::ad) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:44 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:38 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Fix mismatch type comparison in
 custom_float
Date: Fri, 21 Feb 2025 10:42:53 -0500
Message-ID: <20250221154312.1720736-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d64d27-0d9d-4686-652d-08dd528e85ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uABEgLqWifeDqvzz16bclR8K8uMgtYjPgcqNVNycCHySIoFDLeY7YLc3h2z2?=
 =?us-ascii?Q?aRZlVcvEAbzZY38663q6Puokz1+40/mO3cYyaL5xIy0ajTBPlgDtgFo61tJ4?=
 =?us-ascii?Q?TPP8S//LEt0T32AWtKkHpaLsjPfJYyekiNmSHnkRxNolo6/g3AZwa9Od8Rit?=
 =?us-ascii?Q?HdbYGzZzdhcbS849XVU4H5xxRjpdbUVA0Pfppu6CEaKDgrWh9f30MMAgDiqX?=
 =?us-ascii?Q?vQEKxNzkZuPTsLleNXh2RTG+WodvlcxVvYNUFPWc+9Raxi9OVOL0X75GDNGG?=
 =?us-ascii?Q?pus9Jy6/kSTouxb5dnSpDqdze28/X/qWtQXb+TxfjidHPm5jJStYGW0S4dop?=
 =?us-ascii?Q?PJeRI2a0ErV/syDxRWWEFq0xwkcRJHsXqdLib9rJvIYjsD6tnaKjAXNiasAv?=
 =?us-ascii?Q?14O9X32JRYqeBD7PkBVk/nlT//Z2Vl5OfX19W+nP8aqJHKTjSlj2ron3o1Ee?=
 =?us-ascii?Q?lcn7F+s94R3EfC2EC4fTumGlH4CTjdcrbRiebqorJ3hGJqYP6L6eV0/o0tDF?=
 =?us-ascii?Q?fPF5cnZfm/ys5jJzYVFDJiWAvVDkAIdMihHoJpPT0e69XTpNnUK9OU+WCS4T?=
 =?us-ascii?Q?YRb58ZJakssRjCB29Xoxw01SfOk6GyDvH9UjSAgOupxDzH1jfCGECYSYUtnA?=
 =?us-ascii?Q?cKsD+PiarZWbFqDFR7NZ8BhsLSu4gtj/j6lQs6jqcebNY2vYlQrhljw3S+4R?=
 =?us-ascii?Q?gyf0aKR5qVz7jBn0qs8fOJWZNY6N4U7OApb57JHciCWviTdhqpUUReEfi/rs?=
 =?us-ascii?Q?hlDQmHN1uT1JCpxA/fb7iZTs0SBNuQb9+OK2v2BLqUVc2qpgR5tpdbaxIk3l?=
 =?us-ascii?Q?ebMLMButvcQo+HovDG0UFzaWh+heyDxexUAw/tw23e6Qq5gP64pANmE1g1A4?=
 =?us-ascii?Q?HY9HMLrXTfabEUvMKxcngLrL01v9QEqcOeSo3okv0jtIC2QJ6i3kKWgODgj+?=
 =?us-ascii?Q?z6wo0Ngm+f5AqmVQMdbqdEV0tqkE69XC/ybK6CPmPm02EowyEPhORYY0YbYq?=
 =?us-ascii?Q?p9pPgakFgHz9L/Ea00zQfUIFEzpHr/MDpy6F5vD8mymNUAuIeY3WqCI6IChM?=
 =?us-ascii?Q?ZGlcksBIxRXSliFhuuNZNzDkFvBPqgThkme2ilC6O4VFFi9BzUU7Gu/3UZ/O?=
 =?us-ascii?Q?70eBSwR2wWkHGE+1ScdW+r9BbW425crSPl2cHyjikwZ9/5W84F89a0cRfTHB?=
 =?us-ascii?Q?2C+VkEk3AjQ6ZTJuemBaynPqTdjw3Olsopmi+rgjeZUU6VGikLpckzg5H4Kq?=
 =?us-ascii?Q?NmYrsm2Xzbi1Fyl8qKtNBXXUK1RQxLcNS82rS9vjvw830cXuda5DlzGC1GTN?=
 =?us-ascii?Q?+CyhH/KipQfKguFSFlCLulqNNktbNEZT0MVbvlpIhpncxoZcK2xHzc9kqOCo?=
 =?us-ascii?Q?NCCt/ZrtR/+Yrfwr/aqQmZT0T3y3Est38wq3MpIDaccNZBndiu5nKCNpFC2q?=
 =?us-ascii?Q?GP1LinVUfy41/k0AGGRPivsz4hI59u5CI8rEO4XSGAPJq8U35r3gA2vMinyM?=
 =?us-ascii?Q?8MfbWMjZc8PIn/I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:44.0611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d64d27-0d9d-4686-652d-08dd528e85ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Passing uint into uchar function param.  Pass uint instead

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c | 2 +-
 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
index 131f1e3949d3..52d97918a3bd 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
@@ -346,7 +346,7 @@ struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg)
 		if (m > 0)
 			return spl_fixpt_shl(
 				spl_fixed31_32_exp_from_taylor_series(r),
-				(unsigned char)m);
+				(unsigned int)m);
 		else
 			return spl_fixpt_div_int(
 				spl_fixed31_32_exp_from_taylor_series(r),
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
index ed2647f9a099..9f349ffe9148 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
@@ -189,7 +189,7 @@ static inline struct spl_fixed31_32 spl_fixpt_clamp(
  * @brief
  * result = arg << shift
  */
-static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned char shift)
+static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned int shift)
 {
 	SPL_ASSERT(((arg.value >= 0) && (arg.value <= LLONG_MAX >> shift)) ||
 		((arg.value < 0) && (arg.value >= ~(LLONG_MAX >> shift))));
@@ -203,7 +203,7 @@ static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, uns
  * @brief
  * result = arg >> shift
  */
-static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned char shift)
+static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned int shift)
 {
 	bool negative = arg.value < 0;
 
-- 
2.34.1

