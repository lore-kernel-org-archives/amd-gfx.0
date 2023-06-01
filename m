Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14404C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 07:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A2110E04B;
	Thu,  1 Jun 2023 07:28:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF8F310E04B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 07:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+9plYx5tJLjn3TBz+wqICdJ/HBaks8i1BhT11sY6n3ZQwJw8osn8EFFEHgYUnFnaSPo24Y4sw4ZrFZ+OF2nK7PLMH0FHhoIYlzsi9nDmSJ0un8KYDVRC5eLwPpevCm8SKTjz9oyyGulinbmrepYgMS8gV/VNnrb8iagJZO+UnzlkFlZce3iwAmJ54BgnG1sVDd5UC1ABIjRqkMkdmnXcwQ7gE7PnoP0XSjdjRmuKRtDx0bGdDzCrBQTCZ4JMt1SJhUU2wbVKQ3z9EJ5j3SSZYPGTH1y8pbkhyFrkerEF+uZGupgGztfmno7m9UnckkPXI0lF9Nq+tVXBiAc16Lbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKpRP01SXqXTMmu23pfwlrTb6t2e2GYh0b9fMhNpagg=;
 b=cnRQNrOEOARWvlr95U35F/c4HeUNiGfk7lCjy7Id/z01BGAdVKd50gPjTgvol2fPJXW4Sogb/XMuw+FZJ4kTikg5vzf4C97aAuCTQRJKXCRdJex2QyKD5t9JKKgspWZO6i3gk8pnf/lc8vWHfibiEEy9fOl2tRmzahLQ22hiSmZim3mKhtN6gH09Kx8iHWmgU2aJ30j1BOmCCpRo6kKm70D/xucmJfh+L+zOjcdl1NMFXntSQVd83FUyffQ6dbd7BIpo8VPi/+LvPf2jZqNIfCemwPBFxnaJaSPdpH8tZm4jWpCayxYOEvtYOwYTol3fkOIacdZehOqmK9EatDP8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKpRP01SXqXTMmu23pfwlrTb6t2e2GYh0b9fMhNpagg=;
 b=33OkhO5V+XqNQic16U1kHfTcR23I7BbQDI0N9fxvZTQJFizdrRqYsq4pyD/QYDXZKXUnD+B8k1XntvO13bls0mTebwMzVbBZlODSxN0ttpK30+RNEk6x9/dsfRfUJ28XMPktBHDy7/6jdTTuPQI9Iwv0e+oHCz/TYvaLZD98iko=
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 07:28:24 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:331:cafe::ff) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 07:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 07:28:23 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 02:28:20 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: Add throttle status in power context
Date: Thu, 1 Jun 2023 15:28:02 +0800
Message-ID: <20230601072803.1321429-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601072803.1321429-1-asad.kamal@amd.com>
References: <20230601072803.1321429-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9a933c-9c54-4cae-8987-08db6271c882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9Lq2XBogA3M96hDs94DLbbiOhgt7VMf7xUcn+CfyJGSDO722czGyNsL3yABno7Snz3uUIGF2LfN3/HU2TR2ZRRPrvjeYGwlgMO/12WDxZ8bggOeUdLuCaNg61r0OzoKg77T+q5G43JOBS7Dzwc05KBW/A+Ycg9cSutctskf6+xkTuCGu+Ic7CvDT3gfaLVpQ/zoj6CAh6XCee4EIe16C3jB/3pty1q/i4R2hrke9LPNDKF92oUu/ctkp7r+sw6NitQxKCEfKpmbvR0yg8PJtonP2miTdDvAecpVHu7BNkIhLazy8SMSVTIxdHa8PwX0tKFYhv56jFxJ+4jjtVukZeWzKxK6u31hyq/fOQHP3CdB9M5/WUzSM+qoX3q2VQsECWahd2no/cUZQt9UkuOTUjT1jC76zB8VGerjJQM9tIxW8daV/XY3QBIhIYdXjOi0kaN2U5JhS4jOe0CQs4wYz+2goSC3U6fhJPKRoCxzGY+n0RJbuSO6DPsyqOZEHCEY1DBLj1yiNWMrFzOVndwCa4YHf5qIddydRKrLMu5AmQGy64rzdsVbeS6KoM8iepoFoiYvx4gAj1LR3dgSYR/nmIWODh6+aj1CkcIbd+reGlqnPJHr0JiVGDshWerrLsUxY9RnHvLXjtDBAUVRjSzD/waZEgxdZQgSdfDcJLGa7k3pUYswznl8M+j6YIpmhSH44uxEgC5OXApOPHGaPI3tUKOzpPbx5vUNIWGKhGmTb9dGCWO0lZHfd6Wvwps7WjGWGaqZJ7283CYYth3Qr/9XeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(7696005)(6666004)(36860700001)(86362001)(426003)(36756003)(336012)(83380400001)(2616005)(47076005)(82310400005)(356005)(1076003)(81166007)(40480700001)(82740400003)(26005)(186003)(16526019)(4744005)(2906002)(70586007)(70206006)(4326008)(6916009)(54906003)(8936002)(8676002)(44832011)(5660300002)(41300700001)(478600001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 07:28:23.7100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9a933c-9c54-4cae-8987-08db6271c882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
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
Cc: Le.Ma@amd.com, lijo.lazar@amd.com, shiwzhan@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Keep throttle status indicator in SMUv13 power context

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 3ae8d5d252a3..5a99a091965e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -119,6 +119,7 @@ struct smu_13_0_power_context {
 	uint32_t	power_source;
 	uint8_t		in_power_limit_boost_mode;
 	enum smu_13_0_power_state power_state;
+	atomic_t	throttle_status;
 };
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
-- 
2.34.1

