Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFBAC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 13:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F61610E02F;
	Thu, 16 May 2024 13:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7zm+Qpj";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3D910E02F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 13:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKNun55BXEGJr1AjV5Bh+9QRljVlgb3I2tqlfv4Mjb0OIFKm+2gKxhmiavzlExXERaC4x1WU4czR9jAkUlX6gp5c2tGnSsoocW1RT+KCVyd9Uig8eKkpLLKAvxB4EF6sfgsNAe8HeXUKkj14k2c8Ii904UHGY8aJnGSmz2ihjSlZmrkXi+gH5y1XiVmIODZMJ2Ad8geI56NL7OUSoIvZljDDdq/GYIMtvPNNw4jyzDBYq+UbP40ItqSlfchO6z3uLZvu3aIIwsuxKeD5e7dYCWZLNeNF9rxu06dWVm8SalUFsO3D6ZqfgW+FZxfwBZ49Z5zvOl+a64fcQqnR15V7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mglj6cScmYTQRjuZMiTpLtFWX/v1QyEPrJdc26aJcFM=;
 b=Wb98vvCqs192Mh28NEGM80wIvrOcVIRIekPghpK3TdjF5ExaiSyNRwZEosI7tzbOzoFKyGDE9FkQdui/PUJkNaW06TVP0bjfT9PqWf0dPiemsbyxA0QsX37oDa6dDVQ5Wb6ShwRoCIZaliyfPkBTO+AtDsyYv/sAPiBU1XN7Pxfv5sDRZm9w7Rn16aQmkEeoucd32t6KN0YdW8nvKt1rc8wW0+XpQJyEFJ2CzSgf34k6kHzZrmWqo1p2AM+07fEgR9NRsNKnrbgVtldXJseaG0pQr9BHOTP/LIA7Nppq/59q8FLPIGt5gyjx1Vup/r22mthl9WZa6S3vaAUUvzleyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mglj6cScmYTQRjuZMiTpLtFWX/v1QyEPrJdc26aJcFM=;
 b=b7zm+QpjVdx4Q8ditFwK+28fRoXJ0p7u7ns7ZMeDEzCUxfbnqbmehk8nmGUfUR5+uH3LVTjOx/qJmDKc44urb14FTAVg7Xrhbkbv360F17IOdX+UqbCbt91xaJweM93//MImUJk30sTRNstFkkwawUBql/ur5aLRJRO10J7LDPw=
Received: from CH2PR20CA0018.namprd20.prod.outlook.com (2603:10b6:610:58::28)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 13:55:17 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::c2) by CH2PR20CA0018.outlook.office365.com
 (2603:10b6:610:58::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30 via Frontend
 Transport; Thu, 16 May 2024 13:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 13:55:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 08:55:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: silence UBSAN warning
Date: Thu, 16 May 2024 09:55:01 -0400
Message-ID: <20240516135501.2214792-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f635300-68c4-4fba-181d-08dc75afd134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Yp2JDS42PBH/Kma2osThq6dndrljkhMlULPWH4o+aT5i3DX1soxcJQQNvJt?=
 =?us-ascii?Q?ahYbXsJDyPLB1c4a//zeDSkEDLHLMkoW/u7oS5WPPDiV/orlZed59KAyE5MP?=
 =?us-ascii?Q?dLvuuf3flQoXe0tFYo5BUyewBWxOGsGz3dMVM6IEBJkV2QyEt3KgjFAh/Xyj?=
 =?us-ascii?Q?+mztkNKdDdjRk1csnhGkqFiaGwyzX1ShLLRO3Rz0rRpoq+fLIPtwer+NuxcS?=
 =?us-ascii?Q?fIlQAgN36MEnG+m6WefqSLdppNBqoNeDwDtSBfTypG0e+KWgvdczhv6o9H6y?=
 =?us-ascii?Q?8a88J6nbdr7keyNv3bRXZ8GS3bVwu4HiSy16Rs0whkLVFFyh5o9wxw5htsUk?=
 =?us-ascii?Q?VJWH96Ih2UDhCacitronGRrKvnam5GJfRENMLTSOVdvsO/4O7xP6CVaW6OnC?=
 =?us-ascii?Q?a4Cb4rBa0sgMnffusb/FZ2gIlTjHQ3uL8g431lBc3GW54irrApzar+NgPXoZ?=
 =?us-ascii?Q?40EdPiiSD5HcKXnNDVmKP/m0DxN6becv5sk90wiK6ebtQBuCjTXGHAWZCPVe?=
 =?us-ascii?Q?ftS5dTltDsrGsxDlMCtiRZIW2dNcfs6V54h+n8j0WyYXx5QCoOtIOvL92NU+?=
 =?us-ascii?Q?Mm+BiX6aSHWhqbM9u2+lsAgeNyMlhoRkezzjXffhUjPufxGTEMpeUEq5FGy5?=
 =?us-ascii?Q?dBXbDd4PGb4vrriXgUfzd6QPLR8PTL2zCO4YLc/JeOXq5Xfegt6Nix8CpJ6E?=
 =?us-ascii?Q?clud+LXp4fuUNvmXHeR8z8iT8TUHNcs4S/Li1/DY8r3cvmCzI+5GF7MJxOfR?=
 =?us-ascii?Q?MnYet3q3nbdxbBi35nIU/13c568TR7Hgv+BLTBc5Nxd8nePr74iY6oMxNIF1?=
 =?us-ascii?Q?DoiLjqPfGnRmsoljkdaHo1t+Sk92jIJeFh1igR8bO+VnbQGPfwkHTyF3+Cv+?=
 =?us-ascii?Q?JjqXaJV4mcon/RAozDvfwXjftduTkvVVaeqaVoFtL7+3Zw0UQR/2wPDo2qgo?=
 =?us-ascii?Q?WpPh0agYeAHpzjcbf5PSLkgC03eywO/mor7GVxnGPiMs53bGihfy+HIyIUml?=
 =?us-ascii?Q?EDg7AGb6Jy/MshdtH5qmvvY6lsSkDasthfj/Cxn6ZyjEQ9N9Urm01eku9n5+?=
 =?us-ascii?Q?UD2VM3ryS+3XcATXkKtukGmxIY/Aq3GC6HZMw8gKt+iJnvr3Lbqe565ZTccr?=
 =?us-ascii?Q?hjcUL0nl3JxQaEyFDOLje+78HDx6PBEW9Yebye26uMNVgJIJ1SEVi8LpDN3M?=
 =?us-ascii?Q?YVtOXP9IVV8cPLFgd1Gp+KceZ0A80dUTA4rjsp4VSpA/MVwYG2V4/Pxv6uPZ?=
 =?us-ascii?Q?UE+snZ6PK+ZfmTgQRUbi7+ny5leOkQJ0L0ahmeOJpVRAJV4l97yJhSQ6fkyK?=
 =?us-ascii?Q?EHGAf7lUf0QK0Y/QK1OwjJ+bjnM0mt42bsgM7kdhvkJUak/2QmKvA3ngjZYe?=
 =?us-ascii?Q?TFRGvKHndGHbmjbuLSrKV/1+kfZ2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:55:16.8565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f635300-68c4-4fba-181d-08dc75afd134
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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

Convert a variable sized array from [1] to [].

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index af3eebb4c9bcb..f732182218330 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -3540,7 +3540,7 @@ struct atom_gpio_voltage_object_v4
    uint8_t  phase_delay_us;                      // phase delay in unit of micro second
    uint8_t  reserved;   
    uint32_t gpio_mask_val;                         // GPIO Mask value
-   struct atom_voltage_gpio_map_lut voltage_gpio_lut[1];
+   struct atom_voltage_gpio_map_lut voltage_gpio_lut[] __counted_by(gpio_entry_num);
 };
 
 struct  atom_svid2_voltage_object_v4
-- 
2.45.0

