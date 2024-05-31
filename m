Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA62AC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 08:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2997C14AAD0;
	Fri, 31 May 2024 08:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZguwJbh";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AAA14AAD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 08:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irXH8h5JEeH99dW1UVEcHVSg4iQgROJ//wiOkZ0NPscF4zgsLuIcdN+idMTiSqeL1RwWxxM1I53M6C8fQ+i3HugbH1YjMF0/vOk01pbeeRRyv092s2S3Q2XJPFElrcLZ6ktnwEMJdhGdhdDCOTIv7OEPEfEcKOSxcTMiP7Xu8nPzzKR1FjbElQkpxfgpiaMDhplihwlsFzdPc7IBhrIW0r0QRsyKa0RlpGSktIqqJPPY+PK/93a46WNvyQS3WRX+vnAYYOu+5cYftJnoHNGc4tSVLT4nerkY4feHiZasbYToMEXkFtrKOOcg83DZzTUd81Q5IRc79Khb7nNclR5vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0ZNaEomMdPU7E9CSQ1jnk+54Q4QGHsOrIscE3h+Mp0=;
 b=Ew+937T5BFr4RnJKJAgp/1U83kY/n8xSAmyFBYPzMcdZOO041pYpGB052hUb8z+52NoiXfUewdxeGTOgCUDSGHhNZGv3JWk7Y3SGHm1G9Fnxs+hbEHmPCSYLrP/pYahrLB6hDpk/LAeSDw73SmdVn44tgZ/6g9R+VrNLpk1VBJGbx5gODyS7idPAfFjvNU+1D1puzxfhW0C/6A/bY0xkddm/vz9VicWlicpJC13atsKawZZFE1o8sBRvQKSfXYjBBzcSPsIvjLUUI1YnHl5UaXtLDrFCDLMBRNDUXu3yU8TWG8KS+9UDUqfbRKzQt3ZSLCIMNaTZpJHxSBPXWDQlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0ZNaEomMdPU7E9CSQ1jnk+54Q4QGHsOrIscE3h+Mp0=;
 b=tZguwJbh3+/xdUEQ49IBzV7gbHaERrE9BrTtQLC3ILBZ7D4bCFYwukVkvnSNLB7JD9QY2fEdkFl26AePSI0O0KQgz4/XsXy5R3RPfGdCksgTR09zMyqtgMAevEBGVZtKoGrdIPbD7uOelOxHx3qn3lgxvzrzQSIknfTANXhjTmA=
Received: from SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 08:21:49 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::c6) by SN6PR05CA0017.outlook.office365.com
 (2603:10b6:805:de::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.8 via Frontend
 Transport; Fri, 31 May 2024 08:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 08:21:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 03:21:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 03:21:47 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 03:21:45 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <KevinYang.Wang@amd.com>,
 <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH v2] drm/amd/pm: add missing error handling in function
 smu_v13_0_6_allocate_dpm_context
Date: Fri, 31 May 2024 16:21:45 +0800
Message-ID: <20240531082145.24027-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff949b4-0b6a-4451-8e68-08dc814ab775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbTUCdU9LNiTVnF1lcYn7Rf3v2VQCgpMU02KNzxP4RZ6eA37mCdpiwtU6Abr?=
 =?us-ascii?Q?KeLmxW/xxBfMforcgQr1cXVEVK2Ky1fQU0y/H95Zf7AwzoG9yVBCFPP8OTP0?=
 =?us-ascii?Q?cnR92eJRATRSZ+CtZgowg0CQRVNH3JX04JsGdgF7e8Xt6BO64TVNX/T0+H55?=
 =?us-ascii?Q?oWV3I976nJ5XwmUUcWT3FQ3baQYP8iQp0BLj7+4gVg2/c+aUAkC/q8Lmu9Mz?=
 =?us-ascii?Q?+J9R6CWwllGERnVVhQennEj2MQ5ZlaFtu08HBuf2pztpJA7wW3Id/CMx3mt+?=
 =?us-ascii?Q?AbBzfUz3aYio2gPC6x+k3u6Y0rBZbH+bYfDt//Yi/crvao5LzawT0kiH91iP?=
 =?us-ascii?Q?dLFimfCY3fHcMT8RD6P5jx5/kKy4IQFzpdCmkUsCq0WXCFGsvUlGGnK++7Y1?=
 =?us-ascii?Q?5vS/IPubAMDgIwNOBTr43K0d+/+OKqsBdmVKk0VbfdJLzKAhFfebHp4Bgt20?=
 =?us-ascii?Q?C9xNF2NUKNQZRY/AVfU6Gqk3d1+/giHhSzDbpKfSZYyeunqF/1kcMfBMNGvj?=
 =?us-ascii?Q?eJxWsZl8sedUNeajsrgkps1UeRuXr4UWxaD1lGkMvrEElIxL+cii1ZN3qK55?=
 =?us-ascii?Q?Ha4ltegj53rVfn46Oq3587KDkFZmjyxfmjWQVuHrwrUTjh4BAMO4OVruDa31?=
 =?us-ascii?Q?bbdFORSll7hgYlVTZUeWhLo35F9avq8X1tIV17Ur1McZD4IBQV+cBqzz9g4h?=
 =?us-ascii?Q?Qnh/Nm3g9vYBDbhYn14qc+yReT1PVG0t+IUG3izempxdV8UfOotfnK4jv75q?=
 =?us-ascii?Q?tPs3ngDfaQfnPrRcHsibhz1ceK60197C3TeHo9hxryXNmtEulodSjL5f0C5/?=
 =?us-ascii?Q?W7ViG62JB5gyZ4Voc5Gqmya/NuISCeQmkgOsE4Z34QOB4LQk7SWMjy4re8KO?=
 =?us-ascii?Q?rLowtajr+ePfi9Qm+hCrj34i+5UMi/iPdVyqaqpXSRef0efOv6VeH8w4fdWG?=
 =?us-ascii?Q?dUKaLT6jZTf6ugXiJP7Sc4VMWCEmnQcsSUSjC6ZzMYCmTdKv7WZhgiZJkmZf?=
 =?us-ascii?Q?JvsIs+wtWAQ/1G98jepW1UnpIleaWjxlMZsVFenJ1qwQFL1ygrRmKFkS0vAM?=
 =?us-ascii?Q?rIV2pT8b3V3cnNxS4w8y+oeBTSwY+tLKsSsvxAThrIwmASdcRWu2k3GgNUnQ?=
 =?us-ascii?Q?tjldoj+xW2iCwwXmU1prWBNjjdR/OustN/36vwFW0lAZDhEPQ5d92sW5QCRq?=
 =?us-ascii?Q?VI90ssIeMYUmhEhTsarl2NwgSmB9sbbI5hI8M0J7E+TPJohFSRn5tYD3xHrC?=
 =?us-ascii?Q?cXTOzKZziZPCG9eLthfmARpFc7ezYisT9hLvTn/rZm/F6A9SGtwmFbGNFUXl?=
 =?us-ascii?Q?JPnshi8AQv0XOdi39+E4Rdkb7d9FlgytnyaKMddXLU0fzkD2DJOUheRamQ+e?=
 =?us-ascii?Q?nbEP4Y+R7qCKdCTHMzyz19QvaM51?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:21:48.4640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff949b4-0b6a-4451-8e68-08dc814ab775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
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

Check return value to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 15c0aa0ad443..6b8decaf6427 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -451,6 +451,11 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 
 	smu_dpm->dpm_policies =
 		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+	if (!smu_dpm->dpm_policies) {
+		kfree(smu_dpm->dpm_context);
+		return -ENOMEM;
+	}
+
 	if (!(smu->adev->flags & AMD_IS_APU)) {
 		policy = &(smu_dpm->dpm_policies->policies[0]);
 
-- 
2.34.1

