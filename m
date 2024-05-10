Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0D2C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5354C10E120;
	Fri, 10 May 2024 02:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bsOcce10";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14A410E120
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoQL86Io7nK49v+wzOtFCpmhCkuZlbG642WnLLJkMC2mzf1i0HJD9Als4XMoA8tX+CII7tj9bJZdUNkPbgeFxdND9t5a0+ezHmDu3QqCafQAbc6BxFux4DwS1oUev5eLDPJsh0Da0CGVUzk20ceNAfreK/41f8aHovhm/9slNZcUchqxhF+qK6faVJAHZK3ZTilJIoQXdfingg5Fg8PYl3MYs7KkSvyalJqeskgTDY9tvTUi/OyJAEYPMfPTamwk+jQzB2+IQpNiCUt0weKNz0yQxieQHBfEXT1OImlnpQtPB9l4wrTuVj8LycZdht/XT0WkYChmzneSVkWG998U9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeS+K/lZMojFJhkG8mCzZ8+HUu08ZKRWG+B/9j9P/rc=;
 b=h7MDHQhPke6Dkg+94whkRjEF3atX6gl5HpYeu1eNoo4gEGjjPis+IOqA0EIkxh5Pae/aTYW+nSF436FT2RMrux5CRREc8DV0mLF6qzIDtERiYcOFRF+sCW8uIlE9JMfTVtHZPw/+a9RLh5lywl245qeh7GaDpJ08oaD7T9ZRaS6zfHlFove4HOE8dSQIrc8fpbRbIQyTgaZtABGgwAbDXWDp3UU8Sb/aSDffnILzItWX7TSGUQnjXp1LBsILtOvP2j04BOAdjyQzPBIPPmdZpTNBMgbEum0ppOL95M2GqJ9rvxCXe7/NlJRJHeZBz62V45xJ+oF1JQUPfXalm5NWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeS+K/lZMojFJhkG8mCzZ8+HUu08ZKRWG+B/9j9P/rc=;
 b=bsOcce107TJV/fUusmW1jOvXmGPzpwgJBaBgYwy3VJQt1gLkQupROObNnw4FIfrut04SdesCJr6WUhHGjjhpPwxQw63t6OT40l95F1OkgUliw/sRL283C2lCiMYsTpvAhKtcXsLTibShFs/V4Vmv9u7CrL9lJLn0553EpFgTEHk=
Received: from BL0PR0102CA0027.prod.exchangelabs.com (2603:10b6:207:18::40) by
 CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.48; Fri, 10 May 2024 02:53:05 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:207:18:cafe::78) by BL0PR0102CA0027.outlook.office365.com
 (2603:10b6:207:18::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Fri, 10 May 2024 02:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Fri, 10 May 2024 02:53:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:04 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:52:57 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 10/22] drm/amdgpu: remove structurally dead code
Date: Fri, 10 May 2024 10:50:26 +0800
Message-ID: <20240510025038.3488381-10-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: ee85db8a-d1ab-4d53-cfea-08dc709c5100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PT2h+fsYUIy6cqDeQIG+euhcQqpH7NVqkH2u9XiiXUkiDLJIeoWR670HrC5V?=
 =?us-ascii?Q?rfzf/CJGSmojYd3sCPBQ9oqpjmliG3JUb6rFY2kGFayHG8iBIO8B02wadpfW?=
 =?us-ascii?Q?OJUNwDvtunOLGma8Rcb0XsdIIJPWTr1dH1y5wGxMhm9PxRVQC4xzPS1CkKrV?=
 =?us-ascii?Q?xs/SznKzQFTkad1dtd3lYEA3+sWO8xJd/gz3wF8einkUu1OSrcwraomZxoT5?=
 =?us-ascii?Q?ZUeOIaw1sbRYc3JXdJq/BYwmnRV3eX4UPwpEFmrQekMk7sMuzZnzzcB48hz5?=
 =?us-ascii?Q?ZeteM1M5OFS9S8wPEJX7IBQTunYHTt0kJ2pcJPOsYeYBQFSzj6n1WbHOK+j3?=
 =?us-ascii?Q?duiVoMFvfMABwB92CdKpo4DuROjVO38cXUpC2juC/l1EMtk0rfHFG0zvEeFd?=
 =?us-ascii?Q?QGG84jVTf5IbFQ7l8FHTBm/nM48PnuRHk5KW+jIv5YLKazCBx/g5/ki3yWea?=
 =?us-ascii?Q?igieMcL2gMWpKjRqL3cptamio5ksJxsSRaMUD9V5mBIP3/55UTl/tO5OI6KC?=
 =?us-ascii?Q?2C2ZLOZaNLO2C77Sg/ohL0reSDuO55sv45BS1b/O8OJwA/el92ZHZpG69flN?=
 =?us-ascii?Q?hTdiLJoj6QXbPJQuRxPcz14PDtVkMbz4IUhqLn57QWHWfkKwfCn35Vi1AoO/?=
 =?us-ascii?Q?qdGti/fBBdCU8dujS6zV6Rw2HjtS+UvNLK4WO5blpXXBNSt0DiwgqqoMWA96?=
 =?us-ascii?Q?8DQFCWOYDDU/kABPAXQwTFvTmmo9DJgUflmTTaHbMi9Yei8tnJM4wPidwXVF?=
 =?us-ascii?Q?otwbN4BiLsmpo9MIFCvHiRHMMnJTVudhMPq0oJW1or8XYmdGxuVz8TWaCIfz?=
 =?us-ascii?Q?oaqt+g11/d+JnvhZeShmrKSsgy5Z8vRAZK4UcaIyaJOG5DWc67bA4UfwVKyp?=
 =?us-ascii?Q?cgp4G7r6Lxg/IbUoT2nbNSgniwGhLyI1uX7NHATpuaCAIh7R1r9K5HnMumEB?=
 =?us-ascii?Q?aAshG5cFD6FtdQ67DUS5QPV4gfP5PC6P9LZnUTxK+nfMPHQ67pNOJcvrxzhR?=
 =?us-ascii?Q?0t3Xgmx6eyqGT9V+1s9JZxJijm1gllf0wTTCa7AxnVpWR3dgaHY/Zw9maECl?=
 =?us-ascii?Q?Cs8OVzALn+bibdX5OZae9j5CgAQn56n0PaoU3FC8t1uPuV+OHiHTblxqNkCy?=
 =?us-ascii?Q?DbKihi8Q9MqwDu00uTin1rUkaXgDwKG+bp1eVx11efuqVhMOEznJQHmm0NG0?=
 =?us-ascii?Q?83R7jHtYNCd68ABE/eXw/CUHp5om6BA8EIOTzm6YY6TI8jyO548sd2Ejt0nM?=
 =?us-ascii?Q?SaQaE2De4WhURvNi5JTIQEamI2MloT3jZve71CKELt3xeY89KeRgzPqsUCdj?=
 =?us-ascii?Q?4WXaabMzUdknCkRrnVbHgKMfNJCt0YFs/uc6U/Anykjl1BsKjvZko5TGEPC5?=
 =?us-ascii?Q?JANxNDNUQidq0rjyvpkVAW8mhLMJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:53:05.5515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee85db8a-d1ab-4d53-cfea-08dc709c5100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
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

This code cannot be reached: return "UNKNOWN";.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 9a946f0e015c..109f471ff315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -554,8 +554,6 @@ static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 	default:
 		return "UNKNOWN";
 	}
-
-	return "UNKNOWN";
 }
 
 #endif
-- 
2.25.1

