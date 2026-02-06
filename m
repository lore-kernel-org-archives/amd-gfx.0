Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD1BEB28D6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 08:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB26F10E55F;
	Fri,  6 Feb 2026 08:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dqiMsKDK";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145A710E55F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 08:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP2QIxBbopxaMcpdQbA1X6eaH6ku60cBYbgP3V6BWJZEnQNfHEBvFUzP5SZAvo29BK8wFkO82WTYKEnqL5vYk1OymXsLiETwKA90pmjK72dJDwcZKE5Lls5qzpxEa5w+ef3Bn1gZh/Lr3gQhGrlxOLhLrOgNSPL6nIqav5MhY4ghPDZItmJj+rlI0ViUI2B5cBpUsWy+IzRrrqZWvE7EBvAzCRdsLG8rncV7SMRrWiuW4awkfL1Ynl7f4e+EZsWvZWxSdUiFt54IGoR7fqlFT+nJotZ8g1pi7XXH0Xtik2FPQRBlER/AvGL7LOCQ+KBUBPSLTi1X4GMcKc0Y7M+FRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be0auqpDdnVpYGkQolrWnib0I97unH3GGmadf3yF3Hc=;
 b=ZWQbcfNEtEn8n3hFYhlrb07X9q8XSiAJR1RF+N07ySlqIEdYogLrReoBfJjRcw56AfwJftA8EsIqkaS7tkd9kekT5OTe1c37RfiQ2eq1mCfUGsl9sElQlv7PL/2sMpaOIlqmK95lWQjKJaHs9H+oAXdmvpZEwbLWnsVaHwjWDUVWaJePqorciZTztnQaeSoNqR+AQn4qObQtU8bMbjxpR4SNQfLS+C4en+ZF4cS9lTPZvNrgaYIacctJv4rALaQLDScY43DhlhR/whT0hJznixCi7Tczr2nuCQxEAHSe9x1aSMAG+1jMayk/vuuojsC4GRSPeT5jv4wtBfs5rv9Qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be0auqpDdnVpYGkQolrWnib0I97unH3GGmadf3yF3Hc=;
 b=dqiMsKDKYpO83dUTeH35TPZHl6BG03hxEZAITbKw/R4r1StFm/BBCBIFRudH4gOJiu2AtTI/UuW9J+KXuyn857DU//Y3FQFguUXJxQVlg9lyI6lRRBgTHTCIBdhi3iD6WRN0CqjHxcBVXBlAqwNcvGRKUIpjCDTN+mnzPZ2JYw8=
Received: from BYAPR08CA0013.namprd08.prod.outlook.com (2603:10b6:a03:100::26)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 08:12:44 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::e8) by BYAPR08CA0013.outlook.office365.com
 (2603:10b6:a03:100::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 08:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 08:12:43 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 02:12:41 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add acc counter & fw timestamp to xcp metrics
Date: Fri, 6 Feb 2026 16:12:27 +0800
Message-ID: <20260206081227.4133648-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cf8dc2-1f29-4f46-bb43-08de65578156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oBpxn3LXBJpy30DQRhFyeLGKWrFKZCzeJtMqDS8sGgbAFrhvk5XH5BMXEA9p?=
 =?us-ascii?Q?jmg/uiL+D6S/dhzxPknQwiiDVTnBbvpw7HTB4pep8Nae90Yq9KeJL3jSIUxH?=
 =?us-ascii?Q?ccaoSHr+d/ENxvBq5aBEaX5R/e8bqK81rk017/ZJD3HAIW+iuuKDr/cUPimD?=
 =?us-ascii?Q?8d6/zHoxohqgq6cTpQi4VViYaTjcUhCrA8mUFyif7JA+wspwu1d7KuMn+o+o?=
 =?us-ascii?Q?JR1JLIusEfwhkxmumCbcjy8F4ekysnTX5NocoIyaPso6MfKWsR3ummwKZkxw?=
 =?us-ascii?Q?MyFzyqUWYBzT9JxM1YpjjVQ5Ol2g5BL/A34yoAX0osf3BOxOuezt5lmz/5+2?=
 =?us-ascii?Q?FSvPCMq9ZXXIfS6Fzd4gYyHWwtecPM4OHxlnoPehPESY7Pc6/6owXrFogxVJ?=
 =?us-ascii?Q?y6yVCDnFf9In0dIW1XGzGelPzROivzcyTKqu59bkkuW8Y8YOKTnL4U8BVj46?=
 =?us-ascii?Q?pkMffR3EXdeuq1Rtit6lvz8rcQ/+i5SQAPnTRRdInQuQyjGCS2GLHvHQjL/u?=
 =?us-ascii?Q?8Bmbv76YQEnGxldDenucI+dGYf0g3ZiwvajlQH7yiRk7js0XfTdSwv6ZQEDl?=
 =?us-ascii?Q?Xrx4UNA89o8ap+n9QV6G04TUFwgfhpzC7iUT/wIlJDOZ4r8/St5kDWkBV3IJ?=
 =?us-ascii?Q?wiz/NUtG0eovBQl99xJ49R+pu7codSs/Ky8qRLjdD/lGvUdgk2w7muQMNRKJ?=
 =?us-ascii?Q?GILeCvJA4c24OAo8UuEHIA3KT8LZcYN+kqIiwI0ePkcPNk6B2fyxwOYX9qqk?=
 =?us-ascii?Q?GWxY44LfAgz/uEgBbL/rPz5Ch+PcOJfcO/5rp6YFZwGdbmKqpI3MdD67kQPI?=
 =?us-ascii?Q?tp2Lp3AAqgAff9sl4VIS5mlEf9MdshYKrOWmTsdmc68QhqJ+LStHTJb8sqEx?=
 =?us-ascii?Q?nQzCrVoP5nocTIG9pEy8LkODZPxQdNlKsamJOs9e4q+6Md1VY8/ZTMcSeTXg?=
 =?us-ascii?Q?k+7D4DyGjnQDuqnTzSlah9OKFcLwVOxiwtn8CGIymxF/y+/edDICDj/xe/p4?=
 =?us-ascii?Q?zklCrc4tvrzx0XL0ZB7FjS1AxN1zaJmTlJaurNPOvtevMjvvtePtqJ3cjJbZ?=
 =?us-ascii?Q?b3h9abjgjDGXTGaYa/ui/1Js0b2TWVI6BIp8tf+Rt78pmFbzlyWY8S8d40Hb?=
 =?us-ascii?Q?YPwfb8HxZZZqlaCzuTLP1gkP8dlhJKdfJcsrkMMyMmDW1V1fGBrQN1cwYNuE?=
 =?us-ascii?Q?ezeJUkegRUMD5tB1ATiZ/dGdN3nQg7JdDiQcUv3q4YM1zCJ1MA+Zlkz9aGeD?=
 =?us-ascii?Q?oYijKoHjwl+5Yv8tF3vY+kuc5PlRWW20i6dFvqj08c/n1SXTjNLih0U0gThl?=
 =?us-ascii?Q?t8Ogz6Lh9KX0QTrCn7+fELq9Tb7RrKTv3SdHF7XllvBcmxGXDzUcw4mG36Ns?=
 =?us-ascii?Q?M173hqtKejDHy79tuXx2kNIs1o814zYEpQwQjZ/4dAEuD383DeYkObTFOSUX?=
 =?us-ascii?Q?an/+rUn50oDuxrayc3HyVCl38H0FoGezLvegJNZ3xy/z/OqZpiH6EWK5SprD?=
 =?us-ascii?Q?/xA0PH9auX9OKyY8ykVH1AJo2R//ibjd7SfWMfhRKJ2nBKb0Z/Sevr5jhNPU?=
 =?us-ascii?Q?P7KGKZx45ADeSQTciKe1nlFv8xCNKtTxW5Apyfq6T6nHY/rR1YAM5HnyXrVD?=
 =?us-ascii?Q?yQxfrtqK378wb1UAtCHkGAQE60ZRJJ9bU0Xk1EwbngBL6KKfj0167HAe6EHT?=
 =?us-ascii?Q?1MTJ0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RFJuQKDQqf/0lKTPJkPQ7+MinckEKbopskqc2iE4Uqm401tIO7adqPP3OciCF0Dz2gPF811xDNC6kNur8xQ6MqDzNAJKzhU9Ngyto0chq3Xs/QvXxBBl9a5xPKyR3MULPhowfr3Qh6IQUARKkjB60KB8UkreNxIXBmf1/6G+r7LoHdNJ9nfl3oj1CB9xqc0+YMg60R6d1vpxuXavNFctK49A3oo1jefPVrLzpJr0zasSYfaC+MGITbH9vMaNbXkRUJ0tYzXQADwO1Wn384l5e/LrLt5MUsQ9DXsR4wERszYiN15VRG0cd4KQ/j+C4mr2eB2eM5N9Y/3WBNktw8L1A5arhE+7mszgvR/3f/VmbBIBtvE+hk+9ZlhtSL7y3dvCU/nXqsfPnWS2amdOFfma6I1cVlilGb4Fo1m34JFi92JKBUiVe6swL9b1FM4dr2H0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:12:43.8353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cf8dc2-1f29-4f46-bb43-08de65578156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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

Add accumulation counter and firmware timestamp to partition metrics for
smu_v13_0_6 & smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 6 +++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 3d60d3c1e585..f2a6ecb64c03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -823,6 +823,9 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp
 		idx++;
 	}
 
+	xcp_metrics->accumulation_counter = metrics->AccumulationCounter;
+	xcp_metrics->firmware_timestamp = metrics->Timestamp;
+
 	return sizeof(*xcp_metrics);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3a9210083ce3..07592e285cf5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2668,6 +2668,8 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 			idx++;
 		}
 	}
+	xcp_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter, version);
+	xcp_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
 	return sizeof(*xcp_metrics);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 0588a5aa952d..cbe41b2191a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -259,7 +259,11 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 		  SMU_13_0_6_MAX_XCC);                                         \
 	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
 		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
-		  SMU_13_0_6_MAX_XCC);
+		  SMU_13_0_6_MAX_XCC);					       \
+	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U32), accumulation_counter);                      \
+	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
+		   SMU_MTYPE(U64), firmware_timestamp);
 
 DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_partition_metrics,
 			  SMU_13_0_6_PARTITION_METRICS_FIELDS);
-- 
2.46.0

