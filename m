Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 14:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E7710FDE4;
	Fri,  4 Mar 2022 14:48:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301B510FDE4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 14:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKu/Oun0BNJ7r6IdEfuy/dcRL/gjvaXdheAU4dbARxDMPvzAx1SKR1ObP464ArZ2i5UWt6qdKvSg04hfY0UjGNzuWomLE+Srbu1aReZyHn2znb+yq99qAPUKagCukuue5VJZCqnfvd1cZ7NsX3qQVFF6nJmR+t412Ha7Kejq5qRKieAjj2vWqMqmMELv6OrOP0T55PqBykirU4HobApHMFYhd0jbdpi1tZFcrz+XXIhVUuP5eCopNdlDghO6GF8e9d7tg571QgOnd9Z+ZJohy9oLV/pqnvVUtn5ncmDIWyV+NZvd6pp3OS+5o0OVEJTfnamCGWWvCBqM1TiowiZs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=747W0xtAwmckW8ExvrafRq8O+34ZeukSdOm4003ndUg=;
 b=PqNgfW9q0/TnkGTd0Oly1y8iF3/BBL7lXURgKrN0UYknFB0Yq6hG3F2qFaHGXn6Hp/A+KM4H/IYXRKCD2E8H1JS1Cj+oJ2FAxNljYXomOWP8CElpIr8hF7w3rtaF/fN+1riqTBg/WBIsbyoc0tnbNm1hA5wukumBSRJ2epTw42iC2GqpzGTzzJaEcKrnvRheLalKcTvE+8wFjOKb7GDHWIor2gZQoNzqJ4UIBHBuiHzKhYRJCuCDvlxqpLkJpUt3pqgl9xOxTXCjRuMHoCoIgHbwj+Du0eDnifsFd4Oj38YrfrKVd1sctWjUHTOIKNjgR5eCeIzExStH4mD4fWhGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=747W0xtAwmckW8ExvrafRq8O+34ZeukSdOm4003ndUg=;
 b=ILb2sVlz2fzUYkSgsC3M3kcRyVqRT82VBGFsAYvM4C0WG04y83LqS+5DpnAy2S3kEqxwzpTAi7GRZKZEjPjW6Tzag+lTN7jM1Fp6l63VqIn9nNKJSuWK6ARuNJ5Q8P74cwmmvBA+cwjiBnId1hj7PEqSCVy61D3dC6hAJKxFBOg=
Received: from BN9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::22)
 by BYAPR12MB3335.namprd12.prod.outlook.com (2603:10b6:a03:dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 14:48:38 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::3c) by BN9P223CA0017.outlook.office365.com
 (2603:10b6:408:10b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 4 Mar 2022 14:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 14:48:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 08:48:36 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Add format attribute to kfd_smi_event_add
Date: Fri, 4 Mar 2022 09:48:11 -0500
Message-ID: <20220304144811.17451-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 921a2cd7-4ff8-430b-8251-08d9fdee10cb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3335:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3335DE24EBE53D107A7ADE47E6059@BYAPR12MB3335.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28gotfg4FWeOWhSWQ/ceNBn+VG1C7dCsvcZDH3E/Uhd/fdsnl2qFXK1eGxaPzGkA/MabxHmmLgAb9a71InSaAXJbvW0YqqVciA4zcf7NWP6a476f4j5mluNWkCs/rrhyqcyUelXnVjZWnqABb3Mt6F2kf19lZH7VONGP+ZVqeIy+KmWwzPZamqT87wpIiUXHfwW2QxHLyf2d4kitux6QFKPm+WiHXh3OVS7Gf4QrEolkSlJo3QQxCZJ2fUvdbP6/Ij1AKUdA+Jc794BZj+1Eh2q3IFKzSv9wrpULzcQIalYE+1BLTHK5umUQ4hq6pUZ4QI40zzfISUXjEKxCBcMVbR2OFuvZ6YTBu6+K4LtMjfuq0zrPYTOfUMSDrNuJPCd37IOtzYSmHPzqIwDQV31GvwaZrYxW/wMNTur4GRCt6XGg7tW2BMTAHdaQpCHzxlwIiaTC6lwA1MOUSQn+1NtAo4qyT/Jg+SrFSOSKs/QGNxhB+nQ+uDIChAgBxdBecFk9aaMtk1qfcj8hX4ZF1ooNqwP4stzW4uMiPai61qg43/Oe9GsuixL4Pd8NoQlTcQbZ7EgcEUOqx/4rG39a+4JwUw7wwioHDtCvg0AY9DS9yG1uALpKju/S1UR1g9yJbTREHmwXgMFhK2hAJb5tqxVGF6E+sjdKtW/ARLEvyUEkzjERWS9eP05/oGnWOO1pVTTOsULmYrpdgMQdmctq8iTR4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(36756003)(47076005)(508600001)(2906002)(8676002)(4326008)(70586007)(70206006)(83380400001)(82310400004)(86362001)(40460700003)(81166007)(16526019)(2616005)(7696005)(6666004)(356005)(1076003)(426003)(336012)(186003)(26005)(36860700001)(6916009)(316002)(4744005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 14:48:37.4827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921a2cd7-4ff8-430b-8251-08d9fdee10cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To enable compiler type-checked against the format string in callers.

All warnings (new ones prefixed by >>):

>> warning: function 'kfd_smi_event_add' might be a candidate for
'gnu_printf' format attribute [-Wsuggest-attribute=format]

Fixes: 67e874c2fa ("drm/amdkfd: Add SMI add event helper")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index bba8d9692a4c..02b6b26ee8f3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -176,6 +176,7 @@ static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
 	rcu_read_unlock();
 }
 
+__attribute__ ((format (printf, 3, 4)))
 static void kfd_smi_event_add(struct kfd_dev *dev, unsigned int event,
 			      char *fmt, ...)
 {
-- 
2.17.1

