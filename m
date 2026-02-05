Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57897E9126D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E9F10E7DD;
	Thu,  5 Feb 2026 06:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QK2XnHCi";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2159F10E387
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpuvhBJzdm7ChSIsmSdQwtaCigriajL8aWn+A4uuoznDQIZHErhFV2hMWc5SH+gCfdBAsrs1mAdYWelu6X12vYtacDKfMuMeUO0Xdj8H3EGUWpCh29QEAD1YFfDRueI8nFnR06n2p/8twyFTu47aFEgH7uHrIz3Lw4HH1i+N6HVKjRv2KhZZV0quGnNaf7BOfvZIleXcOf19u6XMvtSJyToVb8RhtqDJwTlpvZ5X7xT8GOQOWPP+FwRdagDsmkWePe2wGrg3i+C/0PuS+BppATCy+LCdoTUZw7mln+zN9PV5OBqotVZHnIVOPOOgGm0FnJ2XHi2ITl3VjtUm7TThKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQrQ3wT9sfeePUG7uB+SY08E4XTmP/9frClLK4eG3qQ=;
 b=QoIj5MScSF6PJMWYYivetPL+1a2+e1nBphXtDt108KUau/xMWWCqNS6nV95tOpwfH7u+bEb4Es9bPZXq4HP3yuN4gtXjXGZaQdK+jfSGiU/hqPDKJMxdaTZbdEG5xbpYW5RnY3zEWR2wjf6zQXqolig4yF8R/gET2LYp7uBa/gmrb5VRxj1BGeuUeOM5lc2Ja/CKB6VFpsoVK9GSU6E1c6pP7dKOsifPvRh2CRKw5zjlpPJVAg/0MH5zf6dnlkl284PB31KA0M9r/Je7rh7NXIFF+X6mGaYrmJzPQzCJ/HvMV1yq+abwso67v/OvnQUtlwzEJbYgc9VSks3wvynGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQrQ3wT9sfeePUG7uB+SY08E4XTmP/9frClLK4eG3qQ=;
 b=QK2XnHCiHFxIOPwQAkfBX/0jPR0Gj4iO6kfLaZJzldnf2XsnIIBMvfdz7+oAo6FAPyM9xMVZickl7MI5cNPEWfz+7qShUZlZ2iMLXY+aJk0pndbuK54EvWTxZDpS9j3l7J/uzdhUyGLEpWtD9LLLSD9kQJdLZVyWijfS4eseGuQ=
Received: from PH7P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::26)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:52:03 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::21) by PH7P221CA0031.outlook.office365.com
 (2603:10b6:510:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 06:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:52:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:59 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 15/22] drm/amdgpu: update PTL sysfs mutex protection section
Date: Thu, 5 Feb 2026 14:51:23 +0800
Message-ID: <20260205065130.654921-15-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: f8903463-1d60-4721-4bc9-08de64831185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hgkTrQ2mzNRLufEMt5yK0iP9z+Wbo8cTw0uVsrZl33m+7lu1rXYKX6jWYKww?=
 =?us-ascii?Q?v1wCQLjZjQJYP9GvNN9Shlh0et+Z39u1pcD2zeQGJRZhlFUKtv10C9RbWP6w?=
 =?us-ascii?Q?wcVCqJrQFQnlS2KGdZJTNWiN9vmA/rck51fSsrEiszE+XX+EJ7MH9XfldvPi?=
 =?us-ascii?Q?gkcRV3WWWbhKq16o/dkqC6PUTziPcyxrWei89lo1Clhu1FuxvA5clYBmlCru?=
 =?us-ascii?Q?QZ6xRaYpcmxNYWkkZyPrGsSrfI439wP8jmvhRMfH5ryTTGzq54OlP7TuT9jN?=
 =?us-ascii?Q?pNwP3PcSFfr3L8MYHsPzjKkp4WjgyZ3a4jlQhzPQbTSyScx37ee5MuWeBgQA?=
 =?us-ascii?Q?awNnthm0+LXlpp4iarzSaXcN4rbVxMkoNxNJxzskREAXFzQO/r4kWfiKTiPO?=
 =?us-ascii?Q?CLD7cBbb7zbpBPuvoPqE4Y2+3QH1FeaOel3Q7z24rGwYZpEbvuAd81Ek6uGM?=
 =?us-ascii?Q?HGo4d7kfpT9e86PM+e++8rtodfQaKJoWuybRWkn0rXZQjI54uMJsCllTznPk?=
 =?us-ascii?Q?kKil+n8Xl5Cl0Rw3bX37pPp/AiAWylNfmTDU8r/arpArHnEUBQP04G72Wr3e?=
 =?us-ascii?Q?Q6A9XK9BlsMw40cuMyCJOUVqseVG6jLUzOlD/By3crK08dR5FMolgAZVyYtu?=
 =?us-ascii?Q?aL+xB1PMCIyOKNWstJWP8kPf/ghNwJij/0S4egVXSM8zsYpB9lOm/QLSG6o0?=
 =?us-ascii?Q?kidpd3Q4HmfceWj9boBdHpzpKga52gmc5Wwg55KEoshXUd+0ca9H+6AsP0tW?=
 =?us-ascii?Q?gq7f9VefbcZ9yAf8g0ZcAIkqUowIdVch5pCj42HiwNR7uHRzz4Y8qWZ9qNZE?=
 =?us-ascii?Q?5tC52DPgY3fEJT8yXCrqCbL4wvJK28vz4jimWyKoXFfVFQ9CT80OUTkqBZRe?=
 =?us-ascii?Q?hlR6NcyNsSCMIgYomYIKr/MbU+JLqE7t2Cy6wo16cn/BfaGXpg2Rk0B501ih?=
 =?us-ascii?Q?GuW9Ge6GZAMkZXTbLuuA0ZN0ozTlAEBQjbMk6sqsxpdjLRrY5jnGwMQ5OjsK?=
 =?us-ascii?Q?H56wkn21pDLlEgKMqjIQNYQ2MxlkTjyHF539tGizPO1KkiMQIq5nLrShARAf?=
 =?us-ascii?Q?w7c8dHxcdWuDLAY9gWcVHhJStzG60AK1j1xhuLoEYyhfA/uB8xeIqzp8pS2H?=
 =?us-ascii?Q?gJKN2JviublFf5SXMlfzyRc3J/G3UzKmVQDQGLh7PL7/+j6s6DWG9jk7T0Ju?=
 =?us-ascii?Q?EhA9W01JuOYjWEUVrdeLu3toMlwIhQ+1YBNKwUEdqHlZ5WcMxdT9RT7Ivnyo?=
 =?us-ascii?Q?nW4l0C3qxkxKEI9T3svEuPb8aH3jmKEaMqGZoeInf+uz6P6bik4az31/yWFp?=
 =?us-ascii?Q?lM8tk9JhGsxLT3FCQnmaJvGAvnKYR4BTufpmlwOeZg7MYLF5qWNGBHa7OOOk?=
 =?us-ascii?Q?Ck2DPeNaUdcvnzLgo7CzQwm23Xz+S+lsuF/X0UnEEonBedalhEjYPhqdBOEM?=
 =?us-ascii?Q?T0OzSfa80D6i7TMh9fmiQQpJfWpzG9OCemWrWWaAS/k+z6cX1URIz1egNYMr?=
 =?us-ascii?Q?KDdZcjCWuNVhzI9utau/0+1+CYR/lNCqK2sPaJAugvs+bOgElWXzWImFM3Jw?=
 =?us-ascii?Q?HYN4irCV7nhiVSN3Byj0QhxTQEty2lYVUNORauvlRa8c/vK9Ti2OrlKiFPex?=
 =?us-ascii?Q?aYTOQa37VslBygM2wTez8+fklQlxc38V31BzCMTvwO5zgw9zA5eSSw5M8pn3?=
 =?us-ascii?Q?JbGHrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EEBiIJmBCrL8ALDL2CnvsVy8PfOyhxCMwfP80Wte5i0S4wNbFt0E7W22y07iEYc/ydhZDiw1QGyvr0REWCDlXcISNTRvxYyI5aLvhLlvxCzu/h06J4LdfwVriZxnv0kT0WWOkUxdYnkC3ZPUjW939+JuUlog6lyuKEb+tcRDFSd8SO5TYqvWUK6j+YlmYzTpvVieb2Dggm7XydxKq1dKhcME25rw96FQ6faRxl094/Q1EVlobcQiL6EdpB6e83LsSO3X+z0BMjy7L8vL0Rzm3WtJtMwjL1Heu8OdO9FbsALiRI7H+l+pzenTGd3qSqw57KEnsWyTWq1LwGWLBoiyTX+i/rDgRPIs12O7rCgimPrX/bQPIoJUpqHtKIBIqpVRQnJgZFlyx22Av+HrQGae4F2wuBGmccerSVbI4g4vJeUOy3uvCc3mFutRzUudzwv3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:52:03.0228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8903463-1d60-4721-4bc9-08de64831185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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

extends the critical section of 'ptl_mutex' to
cover the PTL sysfs update operation.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 682a0e4adafd..982494abbf1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1336,14 +1336,16 @@ static ssize_t ptl_enable_store(struct device *dev,
 	uint32_t ptl_state, fmt1, fmt2;
 	int ret;
 
-	if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1"))
+	mutex_lock(&psp->ptl_mutex);
+	if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1")) {
 		enable = true;
-	else if (sysfs_streq(buf, "disabled") || sysfs_streq(buf, "0"))
+	} else if (sysfs_streq(buf, "disabled") || sysfs_streq(buf, "0")) {
 		enable = false;
-	else
+	} else {
+		mutex_unlock(&psp->ptl_mutex);
 		return -EINVAL;
+	}
 
-	mutex_lock(&psp->ptl_mutex);
 	fmt1 = psp->ptl_fmt1;
 	fmt2 = psp->ptl_fmt2;
 	ptl_state = enable ? 1 : 0;
@@ -1390,17 +1392,22 @@ static ssize_t ptl_format_store(struct device *dev,
 	if (!psp->ptl_enabled)
 		return -EPERM;
 
+	mutex_lock(&psp->ptl_mutex);
 	/* Parse input, expecting "FMT1,FMT2" */
-	if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) != 2)
+	if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) != 2) {
+		mutex_unlock(&psp->ptl_mutex);
 		return -EINVAL;
+	}
 
 	fmt1_enum = str_to_ptl_fmt(fmt1_str);
 	fmt2_enum = str_to_ptl_fmt(fmt2_str);
 
 	if (fmt1_enum >= AMDGPU_PTL_FMT_INVALID ||
 			fmt2_enum >= AMDGPU_PTL_FMT_INVALID ||
-			fmt1_enum == fmt2_enum)
+			fmt1_enum == fmt2_enum) {
+		mutex_unlock(&psp->ptl_mutex);
 		return -EINVAL;
+	}
 
 	ptl_state = psp->ptl_enabled;
 	fmt1 = fmt1_enum;
@@ -1408,8 +1415,10 @@ static ssize_t ptl_format_store(struct device *dev,
 	ret = psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to update PTL err = %d\n", ret);
+		mutex_unlock(&psp->ptl_mutex);
 		return ret;
 	}
+	mutex_unlock(&psp->ptl_mutex);
 
 	return count;
 }
-- 
2.34.1

