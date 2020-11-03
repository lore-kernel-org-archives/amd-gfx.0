Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E21C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A214206E3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jAfR9xUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A214206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93BD26E85A;
	Tue,  3 Nov 2020 08:19:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3F36E85A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 08:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZSPTt99XGH3BZsdAkyRCoJeuNHEHAlO72oVr2+hv1E06CcU5+64vf0mBRAk7XMFCNeF5d7sCMH7mQGd32T+pxxK1RDxXgGtfnkIMcgYv0c7OMxv1Fz0vzFsHVUJDbLXjEEyLk2uJxL6GyfCeEhtYk4zqzi3kx0ylte4o1r1cc+UTk/nDhOoagjCJH0EpfE2OsfDMuSvx9yqXxYpG5G00WYOWbqrfWUCQXXv8qFpF14Z9EEIcFoBHRsvEGYy8HXozTvjW7XlcmCCDMl6+eS1mKiBr7358QecE4wE/H7U59vBeWCleErbCGAPu717bvij4wu1m+0MQSfFzKNG7trTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMcZRs1NZX6HBArho9HrOfA3/djOZO2Z6wKXGOJWCSQ=;
 b=g0yGXiAxdrBWz2o3TyLpX98j0ghRKeOcmC1zj8mNjX9fQx+iyzBGKgq70M3bEmiYY28WhLpz/mnX9jdjMr/InuJ5q4wBV6KTe4dJ0H+bYUffTAW5ZOL3fW3eViOuYcHIE9WdOZ3kBkWg5l1DcrbsyEwIgYMbk3mUoTofs6wQSCRIznhwCZl7S9lEii7aUdwgg2N6NGXzlVCrgNFebzPqD7vay4rx3qphGGOj/WxmlSruGfsxsaFwgzsNAh831m/evYBDqdJWq4iZdayCFhtVK1BdRTf20YZnncyqgFwYj905V19A6j9pjc44Cg5dRPAJ9rc2gJyK3QuD8a0UIDObPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMcZRs1NZX6HBArho9HrOfA3/djOZO2Z6wKXGOJWCSQ=;
 b=jAfR9xUBaPEQz3G/Pbg1g7rOZMme2mPvG9XSaGEWsXA4/+I/CWgORRia1pg5jRcTHi5vV2jC3olSLgpH6Kz1CgCvOMRRS2GO2HtMSmdnfAT+74gvUDPSmdg5zAxzA6l3HfM7mc4GdFSoX7W2fasyIA+Y57SImcW8vaLrUJOTJA4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3000.namprd12.prod.outlook.com (2603:10b6:a03:d7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 08:19:50 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 08:19:50 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable GFXOFF for dimgrey_cavefish
Date: Tue,  3 Nov 2020 16:19:36 +0800
Message-Id: <20201103081936.7054-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (58.247.170.242) by
 HK2PR06CA0023.apcprd06.prod.outlook.com (2603:1096:202:2e::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 08:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e608f5af-51a5-4e12-9cd2-08d87fd13bca
X-MS-TrafficTypeDiagnostic: BYAPR12MB3000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB300034DCCA9AF2895D182D6AB0110@BYAPR12MB3000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouvJk86R52B2lXiOghTTl5cdtP8iMoyJVWqOqIglwFNqykznEEEUve+acDFITv4gMqme4NkHiBRKlJL2DYjyfOEHTnxmn44zqfxVeaSWwl3FiHvzBSsMzv2nDS3y65PiWHil/3YhEcelKkxRlCbsb2BnWAoLdy/qASi9NWuJ5WWc7gG8JnCRqyN2q61+upwHmvkjCvDrmQWHTtCk96L3fHNwRJwiKGTtMjVnnyXhfKHOPgygqzLlyfA0/94Kapd3tVgp4uR2OMOqJ6JmNqKbuM7gYpm4vhJtPKm1ni7GK+rCYoipTo5mWtklPEPG3DK50AWeNBVYOF9IhhdoTseE5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(8676002)(8936002)(2906002)(26005)(316002)(6666004)(86362001)(4326008)(5660300002)(1076003)(478600001)(66946007)(66556008)(66476007)(956004)(36756003)(6486002)(2616005)(16526019)(186003)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TouYMqJvqAW4AIetPE4mySWsIWm+BBWKHlnZxLT9dAOdgHN7XkYRYu/rP4FjS97J0Zu2vj92hEFbLmQPw+aA3lhZ8sYLRokAVDKCWfjelK3zoqt12/N2BHpH4GjNLnhb1FMBRH6cf3cjLZEiG+szXCKko0W1sG3lwaqOJ4BNbynjM6HC1e0uOJEDtUxOnbkPQ/nOTHU3OTVOJrB6i9I7tJfgOGE/ZM5bwsglfsZCZ2658NvPhcvosKMrJ7ZKj+446BcRcz3Zk+OdFtS2iOujJUKE4b2+wZYrB3vD9BcIogL3AksNjTiyvA2+GT+S4JYk/lnLff7Ayd5zbQTp5qU+cft9wLtP2BEnasBaxDZ4inPEtqMskdxkdQOshd/G34ycMsMHo32i8ZmcFqFnpHcPj4DvtC5v1iJp4iL5+x/74MVxNza6drEjMSVLjECga1hXBDQHHmn6pXvto7TRd73yQLaFiXQaChqLEXZ0d3iYx5Y4tZc5JSxKbDx4uA+9FHXws0L73A37cWIjU3fDYuNY/EBRo8QZOfWJ/H0nslxNqGZml8BlT/alBKMuUfPTOrzpLAlDBUCYFOxg883Bv8uxjiQ1fmMaqFXqpjY2My9jD6HFNdwjmXjdxmjgLd59OPIxv34b4NstT2DLhk/fcGcZ7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e608f5af-51a5-4e12-9cd2-08d87fd13bca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 08:19:50.4579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAB9lsabUznCeqjzo5XUBofqslAV/h4uAeCZ17w33qDIO7JPJWv6xoAS7tNa13nc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3000
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFXOFF has been supported by PMFW, enable it directly in driver for
dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 76eba25b2d9a..e153f2719f79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7808,6 +7808,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	case CHIP_VANGOGH:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index fff1d2522463..b6453ee6f8e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1086,6 +1086,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
