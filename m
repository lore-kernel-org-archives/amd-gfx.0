Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3486CC04A94
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 08:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD88410E172;
	Thu, 10 Aug 2023 08:49:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A3B10E172
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 08:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABYIKQCNZTGKlXhjojg1RoaItkMvCfp2Wi+WPAbT635fZt5CL/Y6pBz1zY4rzJ3u8PANoS/QbfAqLjmKGQkamRxMirDx/MKpLgT17tFLXRfs9Ikl+/qlFiSnyt6KByy7UP1NVytKVV8yzruK3wEtJz3IXMdTZPIBveiIHv9UQZjvSKPgSXEHqcsOoGN/bYFfVhNJxSK9f30ssVFfiVJ+8FAbJuuT1f8aALzdP/3eoiNXmQE7sgcC10Snf8bAAjWUuXRkro60wyIG1g3M+eqMF4TOK96e4JQ6HbH/R70n4DzTXjXXP3TjVVgdV9DoR5whbdsCpFbYOI7MffnNByBbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqX/UcXeq+52z/fdnMtr5ognVHsv7Yj7AJEGZ3uMzso=;
 b=V1UHI0wFqkfgE5bdcPcyUMYZXZozEVXBCWZ8AYXjfHaFGjAgeLHMno7LKScB+6GKXwlNvscQZtBhRmd+aBpqXaWNMJ7xTBhZ3rH37lX1O5h3naC8qH+D9uSUn9+jLQDoqZ7keGCnp7fQ0vfgkhz3No+UjZlryHd485QDUFt2e2aJuHujmkbX8A4Pv+oxA+24g1Jq43KvqtNnilUF7R6dp4F0GBbOhdNp1iyJ8x7GKAhifeVLnKH0ZBf1CSWw+j8WcBtxCrLG71dBOHohLF5lVqFc/cUR1Iank2/os3t0ROZh7ZD9IehZJNG+6nyYYtZxXS6WbUFssWFfyB9Dg77nWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqX/UcXeq+52z/fdnMtr5ognVHsv7Yj7AJEGZ3uMzso=;
 b=Pv42kO+ijha9ZVn5T47pzpBuY8oiALSrv2mW9hnsC1zjL/rX4eJ1DTVwZmOgnmkIdbQBBxiWbML1nkREN0BWX6gKLisOXbG8PwPCQgdj8Lc6wlRBQLc/8NNsLBaRsApVQtq2KsrDOg3MbPOb+FZTQlBlMQK5Zm8AmQcOHk/RGjw=
Received: from MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 08:49:34 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::a9) by MW4PR03CA0139.outlook.office365.com
 (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 08:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 08:49:33 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 03:49:32 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Add I2C EEPROM support on smu v13_0_6
Date: Thu, 10 Aug 2023 16:49:09 +0800
Message-ID: <20230810084909.2662486-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: a58a4a2a-f7c8-4f04-063a-08db997eb84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32JBaK4iSkTcV8wKecjbpZ/xbMg1CN13p0gfWCEkjxgNAbpvo/WaQGgR9eyCP8pJKwl8Mxa7MvSYyjbqtL45okiuQhzvbAPRe0CsG9cvA0xmcnFtECnQc0k+vRd0aEI2bRPmrFFvjp7KJ5PeiqQ9mvXRcMPVuD2MxIrH7TzGFYdQFZVjyD3FDZhWJLWRgWr4O1rSpZGQKp2CDOw7jlGWC9UehVr02WGymvpPiWnaISR/Do/e8mLG5NFo9eDJkkfiIW2LB8r1BuMa1DJsOY3w5EyAu3dxEC19BwQ3RRvEnkLzZ9b4UgztyIqSOa3eLVW1y3RtxbtwDJJ0IIBRXb+Kp6jjI+nQvY23w7eTkUkbWlNVGJrKvyo0SJM6de17fulbHuJvqnByJ/iDbk0dFWRx1rzXteoQc69U2fZs0nVgQ2jNWu4T+Bly34DYSTq4Y9qP0jLEvpfc0njDzUWLrm0jnK6h7BpFp+UUxFEM05axopL4cCZMEPKrH9ixMMajsdcWKZpfbuQsAmsIb/UuGQJ/0guuqaVOEVaLWwITJ2QcYxC5tCvog5gwAlChs+M5WKQGnZ4Sm+gV2IzBWWXslMkkVOWiP/wtGx0KmA2xET1YdsQo9kOZ76OREKDX5jbQZPhz88M4qV24tg1YkJoFLBlftiJJdkkr7hvf9z/2LmSv7l9v5qqJFt5QjS9G6InkmaA8CQPnL3CuJdbk7Z5BBrvxlMLNaq7Z57y5eQwvw6w6Ss6ZV43KrITfGVlHsD2S+S0CZOy0MWp/dPvr0ZE+8Cw77Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(186006)(82310400008)(1800799006)(451199021)(40470700004)(46966006)(36840700001)(426003)(40460700003)(1076003)(26005)(82740400003)(2906002)(36756003)(336012)(356005)(81166007)(16526019)(40480700001)(2616005)(36860700001)(44832011)(6666004)(7696005)(5660300002)(316002)(478600001)(41300700001)(8676002)(8936002)(86362001)(4326008)(6916009)(70586007)(70206006)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 08:49:33.8282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58a4a2a-f7c8-4f04-063a-08db997eb84a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support I2C EEPROM on smu v13_0_6.

v2: Move IP_VERSION(13, 0, 6) ahead of IP_VERSION(13, 0, 10).

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4287743e121245..4764d2171f92e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -158,6 +158,7 @@ static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 7): /* Sienna cichlid */
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 2): /* Aldebaran */
+	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
 		return true;
 	default:
@@ -212,6 +213,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 			control->i2c_address = EEPROM_I2C_MADDR_0;
 		return true;
 	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
 		control->i2c_address = EEPROM_I2C_MADDR_4;
 		return true;
-- 
2.25.1

