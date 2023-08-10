Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE59C001DE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 08:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D86410E065;
	Thu, 10 Aug 2023 08:23:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACAC10E065
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 08:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhwdqxMGofP7CZ3Tw02qxNnSn6K8hf2UhJBy8YXoemx086CIiaXH7Cz0c3hsZNA91GQtXZtwTY6gKa1N+6R+k0AWiDsXN2YolFF9aOvi6S+KdzkU53vTfqrmNd1ji4Jg03Ncv41+ZPBiAf0HmrqBl68RzgXu+G1IPnYFy6md9EVRAbl5ACSdv6A7SGVqqwCgQX1+Uuqj1IKz2ngXkRruCnxuvxtYV+6DVhXcsqwjnG3VpjzngDl2n3ystGr8wNlaM18Evl1dijjnjFR16L6LTVRyeu/zkS5h+3w1JMM2vOfEsGHIp2DaFVDeAo3slxfrqVWimh5IGk5M5sSTAop/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNCmP/1cGQDqqopqL92MNcTqQVOQ4f1WmvwHr6LVkCg=;
 b=JQxm+aZR4LB6xUl877zqX9RuwJluZ3sAIevs28VS31OieBtbJZtCSn7k3JGVIy6myLFF3ABjvYrzdORGLiKEp1B3XVj7N7L7y9h/+mah4/58S5qvLKubBxA7yfWx6ypfXm9CQuZZyCM9c+jYtXKi15B57PtRnniKoboqQKd2uMwYN+u0wIhWGbd/wAVPf/IVPMkny3cMVHoKDMDbSpkKEyVvjZcqONE5UhD387BPUuam5sRTMSrOXGDYKvV5Yol3L4mzZovOxO7zMEsKadK8ne7csmzwn2Yz9PAfIy7xULEc1j3FmCU5u5hQd1LGcf39rKTFM1fFrwcWLVBcXJl0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNCmP/1cGQDqqopqL92MNcTqQVOQ4f1WmvwHr6LVkCg=;
 b=UvXTgjiU2jDw+zOW0y4YhalcRolsqyYmkAkuf46k+3itN1GiPrATpwzkPP52BW3ICCyfh9MC04yd5g9jz7c5jKBk+ky4vk1+gfGfSi/tzBlnn11RCrEASa+3mvWVDiLr6FXDXuDlQccxJm6nUx79k8GYrzCZVM8nwKdcAa7HRgs=
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 08:23:44 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::6b) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Thu, 10 Aug 2023 08:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 08:23:44 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 03:23:42 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add I2C EEPROM support on smu v13_0_6
Date: Thu, 10 Aug 2023 16:23:24 +0800
Message-ID: <20230810082324.2659934-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f5ad34-345b-445e-8483-08db997b1c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhvFO6D9pI/Zv8bghmQhJNTNNhmOQyOjNE2x/ELzvB83I2/dLQNXjoszNefjEr3EYGUlEd5XGvBxKfdlOrXJySbvt3yDqNI/ZjqbpCh7gBnLksJXrh4FWkRAxN6hbqbpSD/8G+HhKnYYnb+NmGf8DjK58gJOzux7VHYrRaEK0mGy6h/wUJrY81h4tbBR1H4X1XrPlmT2EQrn8tKmpQXMDgO2Rr/4VYV6xt8b0D8oqO03i0c4t+TJ66oC6q+d/dmVpHF+TxM7O0dc96YIES6PexqEEG0k8d8Y8Nl3ux3iY2vgrhcW3R/6iMvpOX3ChHaxM56s9RAQO+Kq27RAHIn7M2I5bDAEvfkpx2Tqf4dlWsI+gpvL6HKLNlWhqDM2w+vNcI1VSYRiVfEX71IZJsnhUWSKVaiJieh2vBxZT1RDaonX7KIrfiN50UkhnTti24ZfUjNauewbDSWqNP1ba/PjDr4UeVNpOWi8Dpd2b7yCSFxTSts+NZGduK4xEXpbj9s77iPl6XIT2PNZSDJ48b9Ytj69MtZiA0vZYCrI/O/PzddcjtPleUuGcDJYsW4OvOk2mwd+UxVfhrtwqngIrjVgLCBniBwpBp5toRKlooPHo/Nvc4v5kbZG+Pp09bzdZzbhH+T9fUX8PeCxo1Fwd0VxUJhdXFFfp5d5yqFInUWmgE+ohG3DWGDDKS8sLfRN5NZXOwKCH0Ns1E0zwjvkXAXsUsGbTD9OqGXTljxhIzFTTvGwiijfexFT/9Wod6+2SS75TT+edTGuzzJcOtelTxmBYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(82310400008)(186006)(1800799006)(451199021)(36840700001)(40470700004)(46966006)(4744005)(316002)(5660300002)(2906002)(8936002)(41300700001)(8676002)(82740400003)(44832011)(4326008)(70586007)(6916009)(70206006)(478600001)(86362001)(336012)(40460700003)(6666004)(7696005)(81166007)(16526019)(36860700001)(356005)(26005)(1076003)(47076005)(36756003)(2616005)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 08:23:44.1561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f5ad34-345b-445e-8483-08db997b1c8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4287743e121245..27fb9b640011c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -159,6 +159,7 @@ static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 2): /* Aldebaran */
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 6):
 		return true;
 	default:
 		return false;
@@ -213,6 +214,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		return true;
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 6):
 		control->i2c_address = EEPROM_I2C_MADDR_4;
 		return true;
 	default:
-- 
2.25.1

