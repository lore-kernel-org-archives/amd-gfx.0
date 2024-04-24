Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF867C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B4110FE42;
	Wed, 24 Apr 2024 08:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wt4S43fg";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F85510FE42
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEczUyM6HoPsYxZg7oBpZo9a9Tk32Bo1qQRYNGPPiBQjUepThYOuESnvGIdc5IkgaxWk62RV/meBFQjdM4zg6M+NMiNxQz0xPg2eMl/V0157SgfVbB5HP46kyPXvLYEFvZiOk0AevlQcfLD4V5d5pvwoOz+htxwBWj+rFOL2pB0jkPf5mCvEGTfRal6cdFHCLsFInTk2AYhNtJlK2rdrwiNtfDRmvpcDsSGGeC8O4WNk2EQMhqM7la1BNJUtNjG9RMDNFHUkLX5jxmfWEK3uRQqpgYv4n8I4jD7PdfQi1YcyNSnG510nSqT4gnNLi3jZlL6GuJ6UriXOBl9psaoI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9dzQIK+gHKW2l6IqH9dxPK25k0U7enXHQISu/neAzw=;
 b=Yewsb+ubJWs6ydcXGjD/MkeNIk4NnVj7RkOq+2BqP/4JpyeOzF8E0lrZ1Vq0IZ3QPzHyZkqhcmUqPaHM+lmFDcL46KUs4WndPKK/SE4BHTTEoCYhDSr/ByclHzsLRU9d237KWd1aJmss+8aLR+GNw4WxJDpbcJygWce9q2BGifpQD9ZWCUrbyR/AOuiKRHXly3vToky4CphYSibR3dwx1WO0sNljoHXyVMXrbq0FQnMoNfZat99k/dF3DLWCgFVzPWZVTQ3P1QOjhXAWwbw21dhzQS6cuxBLvRkPd85Ehgj8URRbzyatkkA9MXkLZWJR0l+O1/qr4z41gARGUlnUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9dzQIK+gHKW2l6IqH9dxPK25k0U7enXHQISu/neAzw=;
 b=wt4S43fgDYqhuMNPWH2WyPC7uQVXwYm7R0csrdIRoJAYOgrHMu6SLD+vtjojA2dr4EZAro7Dq4GwDlMLJPeH2kqmI7CoSxY+eVOMT3EY9NFeuLro+Q23NcpTC2wqo9lX2SiI3s+jUq6KkgSZNZO44yT7Eg1xiv5S+Vxvjog4gCo=
Received: from BY3PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:39a::33)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Wed, 24 Apr
 2024 08:54:26 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::4) by BY3PR03CA0028.outlook.office365.com
 (2603:10b6:a03:39a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 08:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:54:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:54:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:54:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 46/46] drm/amd/display: 3.2.283
Date: Wed, 24 Apr 2024 16:49:31 +0800
Message-ID: <20240424084931.2656128-47-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 412c2b55-ed80-4695-afd6-08dc643c24ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L0HaMF9L1Px3k/k/6XgQfDJiTyamKMilmklZvZPKY1sRW3FuvsUhGHaHEeQ8?=
 =?us-ascii?Q?dSulttx60vcX6J65Lw+uliBaSDMmpjDpSSvE9zJ7OJUohCkgjH8zMDU3OTKt?=
 =?us-ascii?Q?NQTOYxuQT5alrVl0h/MaMY44a+TGcABBk4Np96h8Cy9zDmcQjQNd0v3/STl7?=
 =?us-ascii?Q?IaqQA24cyq/vO2Iypa3kQdGpKE5qF5bDC1u2S/lMC8iUUOfLcAeDQlTI2+J8?=
 =?us-ascii?Q?6Ar80i+1amCFROh+6or8uLG5DPyOO6YsianwlPDcBOSeEazuDuJSFb5hh5wI?=
 =?us-ascii?Q?FjOym5QehOERqnw6/yiWEukOzdBwY8CtwzT11KmY0uVZgwIAXuIEekst9D22?=
 =?us-ascii?Q?ukKkf/JsZXc8CzbleKEDNV3KYn+QcwNWtuFpL7mGMjH5dEhzYaThdxGVEf9F?=
 =?us-ascii?Q?g8qEKUAWFdd2A57SAPGsWIEbT1itBY+51YwrLS0YW+uzyk/0P/XweTW7XePT?=
 =?us-ascii?Q?eJ0IJVscQWh90aoFE0XHnyDxO9zwuYsHwzlkuQwdoXwSMAJld0A1Zaqif2v/?=
 =?us-ascii?Q?tuSe4kzVk/FYgU8GIFfbnxvq7BuHNuwRKIfmzv7YDQ/7l4a1XUmDWhFUhSxi?=
 =?us-ascii?Q?NYCEOS/XnM3HRUs+R/Dd3pKhFufF3JTgFgARV/L/sK90HQQcaC3BgJ1PhjHp?=
 =?us-ascii?Q?Qq3Ml1J9tk0T3ukolO2LgighDs8iB649QT4qVu1gZ8mv1K65rNd7sE5AVl8m?=
 =?us-ascii?Q?KOMnKPYR0cRDsel3DUQ6m6OvigLv+W/xG6YS6rFdnoDsR7mqatbdA/Svgjf4?=
 =?us-ascii?Q?rKgjWsddypfZUy3MsgzXKmUlmJPCuJsRVwuPLEs0kvZF5mrGXo3kuB2xfMcH?=
 =?us-ascii?Q?ldc4e5tLgjA3B9ehTUcFaxPrr/erdYvBvaRX9PrqlIMX9oE0QLVkhmSjMXAN?=
 =?us-ascii?Q?u3GiXXgRVL2cXLIhsn+CGGqiIkL0GWzptFyDoyXy7tYprduwXks1XvnzgW5s?=
 =?us-ascii?Q?Ga82iw5bdbM/zIrFs4fbXyxR+wYqQIArKa8YhfCh6XEw7w91MBjy/SF9hFu5?=
 =?us-ascii?Q?74a7wAwan2jGvsMPw+AFh3StIM52MfzvQNJjpOnhjDkkoEMX+kJ01aF8/8Fb?=
 =?us-ascii?Q?IwvagHfgL8OHdRHL61bONznpcK+PeEvqvmTzqdSa6hqYFsPVuDnMc804WTGz?=
 =?us-ascii?Q?+IKKgocvYSQsu8/BKAXW5Q41oxFZ43tRnBLMQNuktU83qai5yBow1dh+V1W8?=
 =?us-ascii?Q?9wkuyJG/ecNZektvX2ktYAydgCZT7E8Hrag2tUeBAQ4meGUjHvJmbe06h1KV?=
 =?us-ascii?Q?Vt1lzn0aEDGRKTIJrGvQaARa/VQttMKiTKzvyziuxHymsh1wbedR/R0cTI3q?=
 =?us-ascii?Q?xpnWuR/HKPVrj4vSNKxPI4HcEVNTCWaHqQH2OWt/LcHnDXv8XEqtrBoPsC5E?=
 =?us-ascii?Q?nsk3RBe745gklY0yCb5nAQKN+61C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:54:25.8355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412c2b55-ed80-4695-afd6-08dc643c24ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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

This version brings along following fixes:
- Disable seamless boot on 128b/132b encoding
- Have cursor and surface updates together
- Change ASSR disable sequence to avoid corruption
- Fix few IPS problems
- Enable Replay for DCN315
- Fix few ODM problems
- Fix FEC_READY write timing
- Fix few FPO problems
- Adjust DML21 gpuvm_enable assignment
- Fix divide by 0 error in VM environment
- Fix few DCN35 problems
- Fix flickering on DCN321
- Fix mst resume problem
- Fix multi-disp FAMS problem
- Refactor Replay
- Update some of the dcn303 parameters
- Enable legacy fast update for dcn301
- Add VCO parameter for DCN31 FPU
- Fix problems reported by Coverity

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dd8940c2a4bf..b6e92dda4b2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.282"
+#define DC_VER "3.2.283"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

