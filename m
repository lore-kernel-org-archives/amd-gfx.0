Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338D9D2F7F9
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 07:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCCD10E7AC;
	Thu, 17 Oct 2024 07:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pczZ2wef";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE98C10E7AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 07:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyccbPFdIIpWINjKzXl94oWcf/fkHu8Hb0wL29uoGI/d3UFA/sEM9H3wSOMV4GBouDQqO8NkkpjDGGDCRLf80Ocib0c/3/7n7fOcs2c7FH12hHrKrgfX2olfTq3jXsniZsW9IUwirTKVIPKdlJNQ70VhPF93fu26jrSPUxsyf4qao7QXMltef/iMYcJnE9j48bcUnr9xFYgvFz9/hgizSuitZIOsZcaMRhAVqGPfJgEV9Y8K28Tmtq44PIT42qyTop18kxMJ9xn7jS21SrVQm9HQY6nIo8QO1AKy0Yi3WsZS3r261Tfhz8TBvP9rrpMbW9BEIvApsbLkTnEiTGHtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8EO6xviTlAUrcSqR2O6baRku7biEYw/7YFJO+6v0ho=;
 b=yQ2QVdDOXfOt0+akYM6hd4ekJ4aHXm9yRXu5sCy0fBD7RW9EmsdHwx0pb8KaHGmKUrCo38E2YUgVuq5UPmFdhQhBmp39vnYELAzjVi3jEeioyy6KchHqMtCb5yfDVIxMChxuq4hfN89R9NZXv+O8plUaCw5+i2h2znL0u+/T5o7AcxHQGbhYxq9AghRd9HKHNUkEtWz8xPSUH8iqlikoYaN124eBG6ft+JhAJwOAEsxpRVfYY5kZwh5tqNLBk0FRWSI/dMg6+9RO/j82uwY2QgDU1zwCwRAChWw6f36+ETXydQhdfp7++arlqFuWvh3Kp5nBMNktmMFi/jPpRuMJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8EO6xviTlAUrcSqR2O6baRku7biEYw/7YFJO+6v0ho=;
 b=pczZ2wefzxrwx8JZ01oKMeVSKikvKCN4p1CzKh6sJMySxoUIvnDwGe52IcrE/5QtBODGo6tz7rqbduSSX6g1pR921X7e5scbBTY4NAHyTV5VsDqdK40biz6Z3TrFqAYGQn60gDwqpMeMwuSQF7vi4fq5wX/2wuxn29nbUdBTox4=
Received: from MN2PR20CA0048.namprd20.prod.outlook.com (2603:10b6:208:235::17)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 07:23:40 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::32) by MN2PR20CA0048.outlook.office365.com
 (2603:10b6:208:235::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 07:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 07:23:39 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 02:23:38 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Dereference the ATCS ACPI buffer
Date: Thu, 17 Oct 2024 15:23:16 +0800
Message-ID: <20241017072316.1888172-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb6f545-2866-4b55-9821-08dcee7c9f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jDal6JuHaKRSF3aPyHCbJ7SDlEqT4VYpjZsg4/pa+K26DyD9T+zwV92f0VtD?=
 =?us-ascii?Q?695Yt88RR1auUWAUYNrw4EPUZunZjJmdv7/UpPkjX+K0o6TtJ/PPF1EldqzQ?=
 =?us-ascii?Q?DmqEpwrGxrZngbKA9HEkgzjRCNmiY+Ws8L0m6f7J+udNRnOLP8RsbSzb3QDe?=
 =?us-ascii?Q?Vw/ZGDf8SdTPRTPhVze8gavIR0qZfnNTruzYdw4mopb3cZgDv2sDUR2RFAmQ?=
 =?us-ascii?Q?esUuiZdGanYoXJIV35eZVK/NesviNk5FGTKwW12OpGP+nEKve/61vJfaUzef?=
 =?us-ascii?Q?M6LZ1n99dwiPebX4l2nbvOALwefqZzI7uTzgQhp+xbjYcbjRsOgzcTqWHqAm?=
 =?us-ascii?Q?dGX4bL/PgJ0kPZj0lj397Xkxh6y7HbNOinrclkaB1Gaqhf8fnH6zLz80BoDR?=
 =?us-ascii?Q?KnugbS2VIS+TVXtSqTO7iw8TdpFsPKXI3eEdvIOpoWoojzDurcGJRf1h1VEO?=
 =?us-ascii?Q?V2+O6qQSZO3cmtPp5gc78dQCY1Awht5MBEKQ78ZEPnfOyRRWN0r5WJbkDqa8?=
 =?us-ascii?Q?f/82lGtV7mPG7PN9auOTrjuH7UAmrj/9jpVJ8WE2jP9l9qpijBmRDcmi1ucy?=
 =?us-ascii?Q?0wFGxvKotIRk9t3x7od2Jn7OP6/ncOGeDS7ayGrW5wXzJW0M//YZFPXC9RpY?=
 =?us-ascii?Q?3BcUJDTJbzwC4IZVLzkQ1QMdEqMncwPIsUPIyg7pbKD3OaUvYyF/xmwnbfc7?=
 =?us-ascii?Q?AGBjuXT7uMo1mpioUz+zUOpjxErKs40wb5j3CO9UrNBhqPVMgBjs7KQw/PLd?=
 =?us-ascii?Q?mRpsXgqhWzi6Ofwc1XIqf36Tt7rBZNblriztaQqmkiU226dPQiBsZ4rBmDQy?=
 =?us-ascii?Q?zIb3CnQwHHnM+yBuvIU+AC08WtDKAq9oFm2um3JWRtqQFRSvSbu0zcKueIc3?=
 =?us-ascii?Q?1rrwZ5xhYxT82OB3weHUlGAL5yP7YdMfr1Ok6KfOWmrXXnGTlnn/ltNPtO5h?=
 =?us-ascii?Q?kCgndh8DcXLQ0RsCgX9FIGcLICJVs7w17KAq01/bdQLtyowV03nNMOGv16YF?=
 =?us-ascii?Q?gWUP/cvpG4bMrpWSctyo58UvVcChMFCsT1jp4QXeYXP5GxNaWy/dmC4LjXUs?=
 =?us-ascii?Q?nuv3tJDKNLMn+O97suDn2ONqhoIhrJ/h1EBeUwLIX7WwsvTxtv4AsqveUxxB?=
 =?us-ascii?Q?OO4o+JFsfTutShI590nZcC9cfKZuYeoNnGwKx5XhoqzsxsFSIyhzMKjWPKoR?=
 =?us-ascii?Q?LybCsF16dH1a4Koq0rUocXSfNZqGP/unTgP+dNvraaqWKjRCqH0AkbIo1i3q?=
 =?us-ascii?Q?/RxSCE8ud3fgKZdzGp/koNDITjv3ZpTTkJ5AzN1yKMzmbt0flgYDw3imUcRq?=
 =?us-ascii?Q?W7/5kI9gihTv29u+XnqCkqStkkAH155efjdRMfhi5BblStYKyPYIlw5a08UY?=
 =?us-ascii?Q?glj/rovDwmWYAsQVei+/sIT5buOURp02Bbb/DppvmdeVMUEFgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:23:39.9264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb6f545-2866-4b55-9821-08dcee7c9f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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

Need to dereference the atcs acpi buffer after
the method is executed, otherwise it will result in
a memory leak.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 1f5a296f5ed2..cce85389427f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -800,6 +800,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 		return -EIO;
 	}
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.34.1

