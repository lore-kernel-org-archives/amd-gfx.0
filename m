Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82533E81BC0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B9810E3E7;
	Mon,  9 Feb 2026 13:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IxaV3S8C";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8D210E3E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0NIuPklfxD4CdaTG2JPwaRdEs681PCx8eyvPzrIn1BW4JORySX4laLAANlwCd8VS0if+Tzdyj6hhTEf19QLvw/1uAie9jHeeIsCl5bzJDPLSJfeVTOIDyl6jvHyxpvlK3BcwEdSYNxzTpduIlj6ei8hyXUu1qDfg2ntsKhiJtCS8jX2PGSvE/1iXlU/541z9zRst0HYyqH+Mj+tWlZhoU3ryGsArusdQOaN8l2U7Kif17uRoyw+y/G4YgDcio75NY+UsVhk0/u5gagm9WpIqiEjDe9CRG0Y9ULNd+sYx1s5qTVF8zsK+if5nKwgsAvts290myIUMBae0NYNoKrByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=E+IbjK+762cGev624eZLOWVOHdzVo1Kz4DEwNbqf/7hFPFzynBI0JAHuuL65Ud79Fp9w1OxSyU/vKXNzpvvJNDcA3QR+A7ywzHJfxUQAzKd+iSjNygwKOhuNuy9VP+KoYISGyYUjERymBynAm46U/yt/5VxFVlFPz+2kp60Ak132o9Xtk/qU6YJGoP6ihkPLjQ22MoXRcdnQqBnIH6RvhhQ40BJkXLa1OAV1wTGIxSxpgGDhnkGMY5E5Cq6y4fSTU9rv9G8jWiHI18JLoRXH4CURCItkQTzAny+UlK2WXenAWRG2K/+oiFnKKqbojyrktOD5g0QdB1B/9hH4rhND9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=IxaV3S8C0ejQIbWC1JWJR0edMQcEWX4ucnU8NspOrBw2V4ltkrgxkF6L/Q2bPn8gBIoZP4E37TdWkGm+Bci4OBGO8zyNo1t+i4Bugilr2FEXuULzfBQMJseylmFWlgXkpmFp/eiP0XMxRm8BmptpFa2HTV7qPGlqsnbZ1mIlkwk=
Received: from CH2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:59::34)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 13:04:55 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::ce) by CH2PR03CA0024.outlook.office365.com
 (2603:10b6:610:59::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:55 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:52 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v7 09/11] drm/amdgpu: enable mode2 reset for SMU IP v15.0.0
Date: Mon, 9 Feb 2026 13:04:11 +0000
Message-ID: <20260209130413.118291-9-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: ca30aa54-4949-4551-5490-08de67dbd1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T0gbdvWnLmeB87R+cEwq25EdPHlnfcNK1kU5AaLIsg1X0VyY4I1j+uzcova5?=
 =?us-ascii?Q?fnsbxTFK7o+jfeXx1l4ahoAp2Tg9g3Ne3Vm+xgkprqoEGMFesk/UhIYJPSKW?=
 =?us-ascii?Q?ql7W4ibD/WQaqgCgNFQKRR1bzM2CGc9t4SrtwUftFFKeVJ7L9xZypRqjwhkF?=
 =?us-ascii?Q?aqqyZyDJ6s2JPrvkDBRZsg1RK7hTqxF0tCrSxOvahnJ+qAHEGwfiAfsqz3nT?=
 =?us-ascii?Q?fmnuqy9Rp2Fhc5Hs6OQUs2c1W/XZr79VKf2ryqFqFeNlvCDLgUVEva/8BDHv?=
 =?us-ascii?Q?1oWHA3T2B+t7DW23rVeDiMTbyfCk+FcXlmbcLFJNGGy8IjhhaThFaqOSTc6B?=
 =?us-ascii?Q?wO9j36ziiqd4IeCO4QrRsdzJ8sDEkW0e0liHlrxOiRE5/jr6UoWJRGqEMHiw?=
 =?us-ascii?Q?M/NM8pMIV18PieLsHv5kk704jZW8aysH3qdFL4P3mqpjoaY4iQ+UEwZpG0Kz?=
 =?us-ascii?Q?Y3yapq9RWCQxYjnNSD1z+PTDFuBpSX8PnbIJmXB+v/R3g3w6oeD4ZfzNwGnJ?=
 =?us-ascii?Q?6JD/LGd/Dcz2HuHqIjxm4I6V48SFYJ1JW+1LmMUEAVxBZVPBzdf9qKHWAl/O?=
 =?us-ascii?Q?ka9Wr5SNAAW7dEur5tLq8FCEHHcbCmV1Ue/W1WYlR89NYeZ8o1xF76qTEGhk?=
 =?us-ascii?Q?l0lGsi5zgz4dI47dJUj4djxbpnijy4BGgLfSNTVpGIdW2WdQywY5mw/GX4Je?=
 =?us-ascii?Q?F1ccpxd0+A5/SEbtyfczLtIqI0fkAVrd8JimxATY5/nepLyoOt9Vz0EESiyY?=
 =?us-ascii?Q?RlS+4Qt48X+KRJIxqMXpQ1Mvze6fnRchEW+KvmsS0IRYz+YBaIMxdu9K/9zU?=
 =?us-ascii?Q?bQMpMTsw/Ky5lly6GalHD7vfVGLkiRDz0Nhqwa3G76RvylNeieSsNIuXa2m+?=
 =?us-ascii?Q?wXN4Iwb0ahqun/jRUNRUQ5cCZy3z5xniQbO+DT7w2T1Ma2CREjEmrvQo2RkV?=
 =?us-ascii?Q?gBI3eBRvhJ2tV5tWapSd3Zbqq8W0u/9h+y8mg0LlUl53fApbaOJV4djUDWzp?=
 =?us-ascii?Q?hjgYaPMs1RdjYJwMixfsrqyiqn7xygCKWKF/XvkecQ7fP6+XtWGujiriP22L?=
 =?us-ascii?Q?L76U10M0WI5ZWI1yIXTxFlNtYwwBi0T7pHNU+HPumSMZ2QweVvxPoh+ER40J?=
 =?us-ascii?Q?LUjq7TlyNMS5oCr6SFG58XhOrWBM+HDW/4i3Qj6MdNCKGxzlCGwKNxjBbaDs?=
 =?us-ascii?Q?i7y78LxuzjFcI+q0/euIiXSMuN+Mescw0A4wsYUB2HC0djDioTItKcqqNDgB?=
 =?us-ascii?Q?1a3eiH8vqAkK68YTa7R0EO4Tx6K9zQpZfSczqw44ovlieKQeKDEfol13mHbk?=
 =?us-ascii?Q?/nR98M6hXfe8B7oU329fBb0iw8PzFpiVl0JZzpNsKak+AjGA7Cg33jEGp6xp?=
 =?us-ascii?Q?EMiy70WXXxeD+Km+dG3LZkv7ZHxAbR2mZOl/lOt30h3ni3Yn/h8Z/QLRtoNN?=
 =?us-ascii?Q?/cXNPvZQkS9der9sYgCP9IASJx5MOplb1g8HRz4S1rNimV0VcmoscDGSp0E0?=
 =?us-ascii?Q?XqPttNfvnNveEVY8wp3rMUV72ciW8RJ6NKsf5U6H36ryNiTAhAl+RS7Ebpcm?=
 =?us-ascii?Q?0nUmpmWCuqBUUJdpGTBLU5sb4Yy8JMxNEHKVv+ABCkiZ6hJ/LC2vicE1HwUm?=
 =?us-ascii?Q?5ldzDrnc8k7x8sjPWkJcPZb9NfLYeHw1tlbEAfiQdMAN8pZKBQl66HOs7es3?=
 =?us-ascii?Q?C5RNWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z5ZEFf0HJtbpYu5NWmjRUmdDlfJhPZNydr0E9JfARqAmPgMI7Z68MrKLMvipq/oVmzksBP3Y19te7Cm/hmPGniCTMBNh4Q+Ty0fYWQ29V14rhiEaV1qFLOMes6BsI/jiZgSu9tpNf7c2rXXkZpMwFol77CUVUufUMiTpM/ANuxSGypO6cR8456SgwvnLLp/IX6Bpd7y4AhETKxrav+o+ogDgeu/cqMHlHbtY62Q/ncb4cpUSxn5pLZ3vhsJVkOM96NjM6L6Rbypi3MRii2tXnEXW8ZXX5LrD+YhxEOybdxWUkP+S9wWktTuGbtTf1WSIjtZYVWu8RneU868qF/kYvDeVgRo6sH8s06I1bwTPWvSLB7tnvik3yU60CcrbhB+6a30hQnt9TI6dc0AgWwKWmb55UtIg3ViJgnpwzK3/gyD/TSEF538lLSIfkckoDDmo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:55.1053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca30aa54-4949-4551-5490-08de67dbd1fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
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

Set the default reset method to mode2 for SMU 15.0.0.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d9cc649d81ad..79d132fc8ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -422,6 +422,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
+	case IP_VERSION(15, 0, 0):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.43.0

