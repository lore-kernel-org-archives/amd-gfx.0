Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90524C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 07:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EFE20707
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 07:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1vfxHp5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EFE20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BD96EA2B;
	Wed, 26 Aug 2020 07:59:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD066EA2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 07:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dADKKeBaNknlnRPVFKAFfl6o9ss0wVTsw72xiR4OaR4sWbI61o3VxvzrTPYIOZeAmsLVJ+gfhZQj9Zl34vKmHclRWBHtGSv/ltQIauu//bnxTL5+W/SvsflxIZJqEcolXBsvcIn+ICuXatx58nZV/Aw7J55SdLca/Ou+t1+vkBoB+ACuFmBUUKDYbRD37tLTYiKIYqZnPnQnllgCloyDNlbctZbupvGEYXbTd6lZvQkANfQdsZhQNVH3WpUpdylKWXO5l3TVbnGz+uFUUXKrvuM6y7+fwDbrHqlf1YKz6kz43ldpva76Nsw2yzDfP/HEPsXh0H+NWCjbln6LE/3D+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+NsWqpraHLRvBPOFiyAi32AyQF++/XAWd9+z+nmipU=;
 b=mluBPqRsaoUVKHgNU3wuHy6DIPZW05BbtHqRIl/fRNhvJNhNP2ru6x2cjZb+dPiffO02vbwNykS9M3inCWY8rzJlCZkmLJsooywcZ50Y4XYN3DQ6vePJ/0grCeDP5Xt7i21ZafhNrkIuuhWA49SmF0Q5SjgYksWzdq+thgb/iJNhdng9AWXVRkcJ4kMfsjvVZEu8SFxvJrWJXSLqOvE+sHoY+kdGqwDH+Tsvy8qpkI8A/sGst0WHWyA1acyNsAIiL/2ZkQ8j5c4GS6Vk0htH/qRXr65TVwMtTdtHlbC1Zba9DyEjZqTIzGyLDfCtgFgDKkx9yutChNx9IMaslyQPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+NsWqpraHLRvBPOFiyAi32AyQF++/XAWd9+z+nmipU=;
 b=1vfxHp5GUL9yAWdK8i9mFYzJKWpp7SslPCcel/RgpRoOyjq2t4TKMfih81YAJp1odX/9RpA2/7mH1Aba4xsJt5Gs9hSmRxLf7KhDT+6jW/O7ZN3JZ4f03v0k3Y7wya+xvi3jyZ4BV2G/5F82ogRqQlylPqge75In1UtDcrpmY9I=
Received: from BN4PR13CA0001.namprd13.prod.outlook.com (2603:10b6:403:3::11)
 by DM5PR12MB1675.namprd12.prod.outlook.com (2603:10b6:4:5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Wed, 26 Aug 2020 07:59:29 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:3:cafe::86) by BN4PR13CA0001.outlook.office365.com
 (2603:10b6:403:3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Wed, 26 Aug 2020 07:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 07:59:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 02:59:28 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 02:59:27 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 26 Aug 2020 02:59:26 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable runtime pm for navy_flounder
Date: Wed, 26 Aug 2020 15:59:17 +0800
Message-ID: <20200826075917.2598-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f39275-fc0a-4495-d363-08d84995f559
X-MS-TrafficTypeDiagnostic: DM5PR12MB1675:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1675F2FF6822E23313F45AEDEA540@DM5PR12MB1675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46tNoZNcyT2GnK3VaK/r6bfkkR54M9pv8fCWqDpACYj4c4gW4EE1P2b+U+xszqtPAUnK2tUqDypph1AJm2rJuK0FKHfBoO+a9GZswTEXlK7vGt/gzoUoWPvhxkMftt3AQVbrix3p6UywxeLxT3i5goskayudGpGFj11Sthrc5ZIAEsfcpWYjUEae9HzmdD7LDziKetTkVEw6SvmNttIwMyXeQJc6hz98wNFLPwqdZI9qcRROSprj4eAWwrNBD2QpGQGRuMH8KxM6V4IZecEyOaK5FaXKl+hLMvHgbAckT1sRbuxgczknhgiT0a2eSoCwF7ntej0AQKLTQbx9uJaCIF/bFkcOSIElNcYgIGLkkgxJ+OXuDMZrEZ0GoWxN44CJ7kMu+JARM8DgmPR3TvLrow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966005)(2906002)(2616005)(54906003)(6666004)(7696005)(1076003)(4744005)(4326008)(86362001)(8676002)(26005)(356005)(8936002)(82310400002)(336012)(426003)(81166007)(186003)(82740400003)(6916009)(70206006)(316002)(36756003)(70586007)(478600001)(47076004)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 07:59:28.7764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f39275-fc0a-4495-d363-08d84995f559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
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
Cc: tao.zhou1@amd.com, evan.quan@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable runtime pm for navy_flounder temporarily.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ie1b03f09ab70e79b6dd67ede5547afa23c063eee
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9f80eaeaf0ae..caed73d72d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -170,6 +170,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
 		case CHIP_SIENNA_CICHLID:
+		case CHIP_NAVY_FLOUNDER:
 			/* enable runpm if runpm=1 */
 			if (amdgpu_runtime_pm > 0)
 				adev->runpm = true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
