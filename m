Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B5C10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 10:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B9E2146E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 10:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kiDR7g19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B9E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977BD6E10E;
	Wed, 11 Mar 2020 10:57:27 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67446E10E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 10:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/a84ov+EXcaxOTWqbZR+zqr55k4K4uavD9WR03bZUTYNhKUYoJu/nQQuwGyrLYdVWyAQ+M3StI0/8iPRaaJhiKVOEJR/Pgrqml9JDZ9eo4saxDDvCHG3AvgWxTv2eGJcy1lHR/a/PcC/XukqfNUzK8VnQmadbyUkKHOhssGnzpwGRRl5/HdlJ0tLHhrhEya/ZiQKdqGCYZWumCBLsn+RBMgjXuanOQjZlj20t6zlaWjygdfLzrHfvJdEULEV6EPQNmWX+C/eH+zDS7Av2VPNBq9UXFDaUeBRP2L5hxAtO/qt+7j1Q7Zjnz9JOadp3U7z2MqtY5fblWSACf5DBps7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkmbFRLNeZtJ+8AS22cZoXierO58ERNEfXHMiJXmmYk=;
 b=AGay7wcGCj2WYU6LBVmhI3stcVcDpj9DKdx/BMdj1+7SgcnYMEEkSE3OGktX0MugR7w17iQiKtXSs37G67ZPlp0jXwt9e6CAzFKusnaMjgKDwZ0V+lqtlfK6rC29W0s35pBEjEUxCc623hvVScyUPwPfRAMPbfqceCgWt/WK8+5bg/QQe30Tf9zI9Li5dUHysLGoeIEJyfhRT6BOZDgVegnqkTz94DN7DuFinBrFGs0v+INtuaSNVYxpaiFdCCEhE7nAIC2zsrRR05+gDWvqwrwnAyx3ZjPczGNnl371jFo86xsMY8ufh/Con+6oAs5ukIt4g4jsefYA+Tly4RSLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkmbFRLNeZtJ+8AS22cZoXierO58ERNEfXHMiJXmmYk=;
 b=kiDR7g19pxs3rYkcwvH5UmraAFK6d5Eq5KD3AhL1ilslPvp8SMn5g/KduuzvidbjUx+4DyDhmc+RBOBDfRzRGQ2o9twxxVJoy0a46vsMRUAw1svzCHAL4wFfAyAyTFbH0HP4cRR4RIjQfyPHFq48P3znDlT03DoBaUljLxKe41Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3952.namprd12.prod.outlook.com (2603:10b6:208:164::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 11 Mar
 2020 10:57:23 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 10:57:23 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: reenable runtime pm on navi12
Date: Wed, 11 Mar 2020 18:56:52 +0800
Message-Id: <20200311105652.28287-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Wed, 11 Mar 2020 10:57:21 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d332d35-eb0c-4975-98ad-08d7c5aafa55
X-MS-TrafficTypeDiagnostic: MN2PR12MB3952:|MN2PR12MB3952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB395285DEC7BFAD1681E47D0AE4FC0@MN2PR12MB3952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(26005)(81156014)(2616005)(186003)(7696005)(8676002)(6666004)(956004)(86362001)(5660300002)(81166006)(8936002)(6486002)(52116002)(478600001)(6916009)(4744005)(66476007)(66946007)(66556008)(36756003)(316002)(44832011)(16526019)(1076003)(2906002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3952;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vs63yBjmVXsyW2DnE2Jjr6zOb9i7G/bcuao4FgyX7c6Jt2na3JbaVpc0UFI9LFSESk1jMnPhyeuMBH7ppxr7BFGsA+mZdg+m7npYFn0HO4N7jraHeS6g7Q+dxi5mmcaiqJdRaqef2cPzl9JkYqjyyQyp4zuFJi/3IjyhVrK9+F3kXnUUPkY/cpH0HfRIT4/opJ3BSYVSj+nYOQRnBJeBEAwada6hOgpyUyNsAg3m7mc0ee+oybg55Nbq5BGg0gMmatNgRPwZ+3pi1c1mUOt/nU8D/h48krUFibmHO9qW55Sxb2FY4dXPeIsvp7mwqUkMf7ivCx1KOsh/VvOtJSq80Li/0vH+Wokb4h4Li2V0v8SBWe97Zrzgf+IbrFASPUuFN2a8++JeUbCyi7k9KVJ1fiYda7RiVc0OAsNa/MW9vJzJ+B+TQ1gz+21c8mbf4EpI
X-MS-Exchange-AntiSpam-MessageData: bpNZmq9025XpMkLU4IU0SOPPeF0UVb0qBktDKaCrND1eb7BGGLv+FxIulCT/AvkADbcfK3sWa5kYjyt+2d75Lj1VBGLM16BRA8HK4K8PYewu83NHz5m/uS/Va84G326MRRdvRa42qhpQRcNVZa8D3Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d332d35-eb0c-4975-98ad-08d7c5aafa55
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 10:57:23.6877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5fPQUcyxD98+c8J8V9RD/6xh8SlVZYNYVyJ1dXSCg8ALP5u0/98yzCacXBOng/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3952
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The runtime pm is verified as working now
on navi12.

Change-Id: I20393633678297308c9651237bbfdc854a3cff94
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 80495652a7c1..e376dc072d42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -174,8 +174,7 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 		 (adev->asic_type >= CHIP_TOPAZ) &&
 		 (adev->asic_type != CHIP_VEGA10) &&
 		 (adev->asic_type != CHIP_VEGA20) &&
-		 (adev->asic_type != CHIP_ARCTURUS) &&
-		 (adev->asic_type != CHIP_NAVI12)) /* enable runpm on VI+ */
+		 (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
 		adev->runpm = true;
 	else if (amdgpu_device_supports_baco(dev) &&
 		 (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=1 on CI */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
