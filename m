Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD36C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563BC61287
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563BC61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B46F6EACF;
	Tue,  1 Jun 2021 19:07:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5576E6EACB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 19:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+jUpXvYk9uf7gJO4Ol4ljXJrXir3gBD9D+9FWTH3wOqlAP/5HvIKUx7H12Qub2OMhJC2VPLC+D1LmBdfI0ioo8lOtl7MYLhD6lPC87Cz/1UHOWRoSYvXy+EQxjLFOdsB5ieF2o45epDczDzPbDIbCDkitoyARMr6lwkRRrHvohBw8JciBXJab8Iaol8fvFEs3wFrIjlyrcUR9gN7xR9bI+C8lo/Xk3YUbGaF34nxnbpZnLtJh1PlLifiGFc6EuEt2+UOOlGaCGF08hVrglT0vHrRitOMOQDgBwsIOL5mT12OVljyCwvOToDK8WO1LGtcd9hmKZetuCgDocvA6JAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8KHwV7UH0aMeVR8d06+SpMNN3HA26oDNL4xE0YXm2g=;
 b=Kix0nng+AVJVG0IhpsG5SFZltt5WPjmnKnPxS2znVycnCn8OUvyqKbUHigyfPV/voivLIm2QBKoxYl5xn3ANqoxwQ5XhtlaI1Fo0rdW9m9XdBw6yfu1eM6waDnUn1EhpJzCRrQ3p74y2qQJqg1Nnr8jylb2Kogn7snemHcw863uaw4pFDwWE9JLhtsORFxWBCeZHRTUMhPQ4BN0c+Y3zrBwkn7eBFb4MuHNQpekrR8c1Gn9UVJKUGHcam3cwqd9wwxIwSwSIlRmGW6en5wAhtEWAlFaOmQ+JunKwwjCN9LLMsVtTxdwpXYyctfzWcs4Y/3vNOzvEK0z05WlloBzoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8KHwV7UH0aMeVR8d06+SpMNN3HA26oDNL4xE0YXm2g=;
 b=RUyo5/C0kyPzLgV8ERpo5Tqm0lQHLFOm3JesEni51e7B9twLQmeUEjD7AIFcBejbQAOivJOb3g9GYUXt9QS3I2EDjtEU8UCBVxOAM1yPMhze8wjN7h/mu32+wUgKiL8KABhu3Qv2ESdUbcC5ek2ISY02V43gkyaAhgb632wrKKU=
Received: from DM5PR04CA0049.namprd04.prod.outlook.com (2603:10b6:3:ef::11) by
 BL0PR12MB2513.namprd12.prod.outlook.com (2603:10b6:207:4a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Tue, 1 Jun 2021 19:07:51 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::ea) by DM5PR04CA0049.outlook.office365.com
 (2603:10b6:3:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 19:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 19:07:51 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 14:07:50 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdkfd: Use simd_count to determine whether it is a
 GPU node
Date: Tue, 1 Jun 2021 14:07:36 -0500
Message-ID: <1622574457-4447-3-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
References: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 253eb094-b4a6-4d42-f685-08d925308d9c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2513:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25139A083A876686CF051FC6803E9@BL0PR12MB2513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6wIIyoFLahZ2qFrTnoO+34U4nN0WOlafDTgTU+Z2mBSWFIS3+nzLF0XBOV2oRqFsmc3wcGph1oQQqdCyKK/s3HXqcfl5dDTxsMpr83bOKWFU+vkx0PJJ9Un4S1/+rdoJmxrzRE1jBEQsJuO855NvTfqcgi1QWjeUueHtLMTmTeT2m4r/mV5+LVdVKrKFLFRk9ps7b5y25sCbXF3v9GmkgqZ4Vj5QvH0mcLPM36uVnTomk/vMbHOJHsw0W/9touo1wHkk2laLrEZxKD4Rku+dJdaqZkYWrVb9k2D+Y2IwpjgL61vHEfZdwyYw22pwZjfqBOayAHyB7F0ug90P7oxS1JzVsE7qYwtokkKcij9nNvH/gzksLg/FPh0kt5jVONyx7U55a6Ou3wwwwDyHTEv6aDPMMIMdhJEp5sjBcXGfnmslV3Wg3zoEjlZ5t6Ws5C7/dwxkdkiMkgT5zjQreoslUPY1IHt/ybUyB+5MH/N+bQHmpQoaJeOrrsKCw3lgTElmjUex8olvNjxUgzw5r5qJgsaabVGO2jJbIqQSb0Bv3Guqh5JpWeo4sZfkrxhV0WdTTdql+dXe1piP8dyLLKNs7/dMO4ig83jW3aORA6q3IOgn46bO0QZ8CnOIVoN7331rJidwdrsQDidF/LZVHKXA1s6yIkLSQ/dEByN4A+hpnGpIZTfGEVozCG0k/ce2rMG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966006)(36840700001)(2616005)(82310400003)(356005)(4744005)(54906003)(478600001)(47076005)(8936002)(7696005)(316002)(336012)(70586007)(5660300002)(36860700001)(82740400003)(8676002)(86362001)(26005)(36756003)(16526019)(83380400001)(186003)(4326008)(6666004)(70206006)(2906002)(81166007)(6916009)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 19:07:51.3188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 253eb094-b4a6-4d42-f685-08d925308d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2513
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
Cc: jinhuieric.huang@amd.com, felix.kuehling@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previously we used cpu_cores_count==0 to determine whether a node
is a GPU node. This is not correct any more since we introduced
memory only numa node. For memory only numa node, cpu_cores_count
is also 0 but it is not a GPU node.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index dd7772c..87226d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -835,7 +835,7 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 	list_for_each_entry(dev, device_list, list) {
 		if (mem->proximity_domain == dev->proximity_domain) {
 			/* We're on GPU node */
-			if (dev->node_props.cpu_cores_count == 0) {
+			if (dev->node_props.simd_count != 0) {
 				/* APU */
 				if (mem->visibility_type == 0)
 					heap_type =
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
