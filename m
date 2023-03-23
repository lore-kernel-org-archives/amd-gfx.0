Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C985CC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 06:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFE710E036;
	Thu, 23 Mar 2023 06:06:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F414710E00D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 06:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUC/60H+N5rI+DJ/qQtXpaBkF5dHgbJVy7rh2sPOmkLV1zmzjM35yujWOjfl3PC5FyTSQv51ix8Lu8kpzW4EJ4SU09uPZELRsD8PixlaAQKjOLO9I//7puAp4PUEqdKCR+aKBuUfF8c2cdGXtbz6z9qODa1ReNqqSqCYfGvZWsAiO/o9GuoMZpwPUFLVTPxHmpqrqUU91eO8IVyrh+RsGf8jFz0pX1MNBSvBOCujMcBLGR0yzCxjcTM4JAlFolA3ZlGwde1F6LO5PPzVym1BrT5Rq9XWJ5VwDW6F0pp2M0YAnSqy/pTwXTsjxge6+fwSazMU302WuDKjAtj8b5I0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjB7KcBkEUssXk9SHTm1WTQjq7+qUvYdi+0YHOMxi5A=;
 b=YgVsccCXH1tHgMrfVPLQpg9mEp1N45SnZzxUZ1OcQXA/eZ5JauLWc/nCppo2g2GkV1ubEEiOrVcUEf2kyxsuWzHcfEBHnVRCjE4uclLRtM7EKMQfRXEfJR/OLJS8vNV9TJzXOyLktJSf3BIqmMGGz1DbktGk78E79+GGyEw6w8XKTan6zxFOHjoEWDkrJn1TdGnf6gy8FcLNVp+5UcwyOZUQc+EbultHIZUrX5IRgrstvlJfYgoo7dN04ujYqv6dQftAwAdYkuttjGMPDYGxa4eHtWoK1KKmQySi/aqkRpK/YIvuJsQw4lScuWdacrc+b8sedw0rz6Pdpvz4tnu+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjB7KcBkEUssXk9SHTm1WTQjq7+qUvYdi+0YHOMxi5A=;
 b=sI9kV+SKUXaz4CTk2SreDRcwCkqqyd82rxAnGDdfcPghk7/IOrbzW1kB9oIgKjaihc9V7wbsmz63CB3XRj7aOs6Eu6AF6eRA1sOwMnsWvNCOzYiK9SsyWZq1lzJI6N+6M4flYc2S50z1Ms6XhsTxWeVrcSBye/IUHZ7KgsXYpfk=
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 06:05:59 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::3f) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 06:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 06:05:58 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 23 Mar 2023 01:05:57 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Return from switch early for EEPROM I2C
 address
Date: Thu, 23 Mar 2023 02:05:29 -0400
Message-ID: <20230323060529.270869-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230323060529.270869-1-luben.tuikov@amd.com>
References: <20230323060529.270869-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d6a9a0-88c6-41fa-e4df-08db2b64ac32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: de/odEGK6tf2DxggGh5VhFFh+qCl8pgjPnXSN0c3EHBKulmXajjs8c5+TIocm9iz/+E4UVvKxNuUzLLQceyoH1g2CCzhL/zuTiHuM91/N19lbnfTbx3ygomkcJNgNSKuEng6KK2/+RM1/wPGoA4upkURucbKG8RWPYknc9BJtbBX16ylJsOP/CHplqfRFNVkpv1t5wbKaRG0tclWqJ/n/NqcglLq8G3eHdv80rBqqlQCj/1f/9s75urD/EfnNEJkRoCJPdbf0LFJbV0P8PjdFjMmpqDc+niSsHf3h5h6imAZgFNrtPNQT285tRi1uPEsFEXTzCzqxnToSqh9/OK9gD14U2UgDWvKPs4kWh93rYO7+uu1fIjvC6QvuHJki1GlMuPFZ+jJwdpG4oe+G7I4BScYTU5RIFM9ALWb4LsJuS8M7ouWyqlabPwJ2jPX/vPxoezxAD4a0s2VQDEpUjSddkvsHFBoYiYcrj66VnJeiaMSwB+j7c/7n7XoYSw604KO2dj4GssR4YsUJ/BtZz/sxoxTRjY3hhTdV1hBew4fQDHN8xh7Ta4tkf87IJUAvNtYrw7TwK8RWGEgjI2xcZ1mNC5T5AA0ZWLFfZE+8lB2UcxrVHhs9Oc2Lz09h8td+APpE6jKz18u6KUYP58cjRpWGp979R86LHbbV3c7nt3VRQSuggRtUHabs/hLFLnGlaS2NB593RbAw0r/JDXFxFElzc3rKBuS61hU+gg5OqSRFrc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(41300700001)(5660300002)(6916009)(4326008)(2906002)(40460700003)(44832011)(8676002)(82740400003)(36860700001)(81166007)(356005)(86362001)(36756003)(7696005)(6666004)(1076003)(26005)(54906003)(478600001)(70586007)(316002)(426003)(8936002)(40480700001)(82310400005)(70206006)(47076005)(336012)(83380400001)(2616005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 06:05:58.8016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d6a9a0-88c6-41fa-e4df-08db2b64ac32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>,
 Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As soon as control->i2c_address is set, return; remove the "break;" from the
switch--it is unnecessary. This mimics what happens when for some cases in the
switch, we call helper functions with "return <helper function>".

Remove final function "return true;" to indicate that the switch is final and
terminal, and that there should be no code after the switch.

Cc: Candice Li <candice.li@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 5c21480fff9c8b..3106fa8a15efef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -181,14 +181,14 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 		control->i2c_address = EEPROM_I2C_MADDR_0;
-		break;
+		return true;
 
 	case CHIP_ARCTURUS:
 		return __get_eeprom_i2c_addr_arct(adev, control);
 
 	case CHIP_SIENNA_CICHLID:
 		control->i2c_address = EEPROM_I2C_MADDR_0;
-		break;
+		return true;
 
 	case CHIP_ALDEBARAN:
 		if (strnstr(atom_ctx->vbios_version, "D673",
@@ -196,7 +196,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 			control->i2c_address = EEPROM_I2C_MADDR_4;
 		else
 			control->i2c_address = EEPROM_I2C_MADDR_0;
-		break;
+		return true;
 
 	case CHIP_IP_DISCOVERY:
 		return __get_eeprom_i2c_addr_ip_discovery(adev, control);
@@ -204,8 +204,6 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 	default:
 		return false;
 	}
-
-	return true;
 }
 
 static void
-- 
2.40.0

