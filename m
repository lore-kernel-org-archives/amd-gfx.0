Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938D3C636C9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DEE610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DEE610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A726E430;
	Tue, 20 Jul 2021 15:44:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575176E42F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDSmmFpvlgDSu9oiKbBRMSZsHBr5ApY0WJOxFeV+RZPok5REy29j4jVKH8veak5j13S2fpFHWHXsrwd5uf2QJ174OhwUPuI6s7gjuYzTgtVvDS+avsEltWk0WY5BNbTxgx4eO7Jk3/1ko3lAFipW0FH4bbzmag5uL5XQR9HN0IU3rXEi3YvkqRPwhpCN4w4iP8+oEom5ezYfFhs/rUWR70aYMAUQJcD9BCGA7q7MVfSBOdiri4NpCgc35oGwn04su4LgHsk2DTSvKT/g2YpsMoV8+2Phbhgx091KnzmFy7hajEXTsWsOnbXG4FBmd6O/hB8D3rm+P3pOI2CsvCypew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjRRigvlmrDaliB/6TQ3g/GteYWiI9733OoMN3B4E80=;
 b=F0Y4FSWKWlOOBg88BPho+taiEQMvj2U2XpSSQVQKuRxG0UbIfFE8JFFu1IDZzEBq2bOpCYM3Q1NlMdjtltyVykNoNxa8EiNeerEU/boR8QfLO7M+E2NBaHt5jKnoLkKUpx4bv/+Xa7/PoSu0l54oFmTuKj8eXPQvH5GjUArZvNnHy+LTH+cy/jQZV0EGX3+wq9BoUj7KJ/N42Dm/93Z74ygF+hU7f67HUZ32ETSeFgI3fAgCdA22LNN3XEh+hetkjStKmODoD8j9ZbP7iSI7ZE31HgK4rwMur5KxP6NGP2GJZJSse8SfU/j0qttI7kb+eErwecUm/PFj6N+kgRDR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjRRigvlmrDaliB/6TQ3g/GteYWiI9733OoMN3B4E80=;
 b=UIj2rV63ha3V5gCd9eKgdm5UMzKneVQVnhjY1cry9LndDtIxj868996ebaNqNtlG/nWNNgo/0h8zhpGhloRmWQmgc20Re/vov1hjTArs1VYj3ZSp0pOdmWx5O/7MGv5AoS0q9W3N9p1gnIBWLxoC8zrQ/9Z8WtwAqvyEdNH2Gh8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:09 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/29] drm/amdgpu: set ip blocks for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:26 -0400
Message-Id: <20210720154349.1599827-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10cdefc0-4f6c-4be7-2116-08d94b9536b7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349989040427944BDC7ABFDF7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7XiDw4hDekxmQ4OxJ75BragYmK+UJQlm9jMa/D6UnHUftTwRTh5DaZJACBadIZ5sPmqh+NlPKy6PjgZvUR0FFmANzUPn1rEavC+iM9nL2q1knM9Aayn0DRg0VZ2VfW06xN1L4mGXlZIaQb0zYbCdL/cBrjIKQ/+OzLJ2hgWI5VDy7UeaFhn1EE6K7Dx+e4Zp/I+4VZXG/6aIU/kbpefvWEaOVgEmJKIRY160aEN+Veq3W1xZ59Nb5YCK0/EPu9Y+gGugdSVUhZ0uSWChpuFQDR5/V+/h0J8RUEittD10lEt43fhU1HK/2LX7zyqkBc2ncZNAbBFRojzAsZMgtnsEbd2/V+ZKf7kJ5YMJmBd/RDECD8g6D1BCU8gwo5S7cwBYgvNRdEvHQ2mCUr1YtsOKhP9qBLmDENIIYuT/2VnCYtmfNGtU8sppnPMWA4LvLdL7434iceqqQGOcElcM1Rlw/uRp0ERGR4cWp12THKapAoIfMVGI334yY3KBbqIoVqoA9LeR3N8RCRiVzXVa5HKxiR08zImLEQvWCRmgK1JPg/QevF7UFohyBwgzjcTDQoxO8Dk2+ICw6hBLsIOkk95ejjXiuZ49jChDIytG5lBOVLwq30Px4VWlGasOSfRRwjtXeyLxzn9RwAXDewV31BisbpP0HrVaUaFINpMjJS13/oM24Jh+D7VE/hD6/KvPeVWnQos6O01+meRP80/kXJ7pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(83380400001)(54906003)(6666004)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nisrvF1xidPmF/yJyn/07k36b0CZldQdlBfvAkEVMpWyDDbk2zScUxqcuB0L?=
 =?us-ascii?Q?bNcahB5srFbHWHqr4oRPV77ozXYENFOfx4rJdbwvlmerJqRjAePXMW7rNqWD?=
 =?us-ascii?Q?ULH60j1tyn3pE2Wjo6uCZyMA6ODjpVhNKxHFJRMluF+97hw6euYixWXU/YZ/?=
 =?us-ascii?Q?fZvhIVsqBiTv+l3bWPs1aJgp+T4wyj+EJcP012L8ftHDxX1SmN5k/WBmOCi2?=
 =?us-ascii?Q?gDSKUoDKi2XytWQhHaPIndPrM1lDx7PCadcNOoXKtwm11UD8kZW0hL4cPpLZ?=
 =?us-ascii?Q?/XoIRIrjIHQs9QeB1cwPw/nm8Gyza3LugvDt7V7G7vGG4PCw4L5b+vHXd0hf?=
 =?us-ascii?Q?zMqS0F5lcaFhlSrQ2ABYbQsy8vZa7cs7K9f8ZeAcsXeSGsXD2ge1mrh/Wde7?=
 =?us-ascii?Q?ZpAi2wl/C/vgDSrMd6H7ZN2rbhmqXu5RxAHdlZ13n7wUxmCkDCfD0bSwKae7?=
 =?us-ascii?Q?pWi2BcushN2vOv/00J9wV+V65lCrtHaNHmrznh93ofDBMhormyx/NgAk9dY7?=
 =?us-ascii?Q?les2AOSHcM/CSi87rSjTMWvWZ4Qf5txL7WJanQ1UI5RCmkMqBRaEqWC8BxlG?=
 =?us-ascii?Q?nEW7YsD2FJ9QrmND0ArK34K6mzYfCpydknZrTHe+toT0H9Cvr/0j4o2Z1Ezh?=
 =?us-ascii?Q?pk1slFjJpPrqnK2j/J6rKlfEd61xhXd8C3thiNbJvu55R+6JwEFxd18YiPnl?=
 =?us-ascii?Q?FwpL5oduDBS9rjXPJ/nCGWQeUeAyGzJE+L0Nu+fr1oKOuLWa7qTSJ+M7ewn3?=
 =?us-ascii?Q?8pCo8nxVnQsn4JdrZ5tkuxV1MPXjoBo4w6yC4wW6CGVj5m1Y72+djrvgPkoh?=
 =?us-ascii?Q?+Co6UA63jpKvCPJqV3ovuRUF8rlo0gqwoBXZPEAG2HfFqfRf9QjiuNQjXoUk?=
 =?us-ascii?Q?Cqn6zGozFbtduzqcSDzhBjz0bFeJ8KFSO8rwvYE7sh+qHj5246wRPuFzJfe4?=
 =?us-ascii?Q?o8Hzc2KNxmpj/a7Lu9ggPPzS8AjfvmdfEjKU2OoJ5rra05L6epzkUNyJd/MS?=
 =?us-ascii?Q?RXCy/Zv7tBM4ilU/vje5hj8Wa/5pMXAJ2yJgrWoNalAaWKmTqVS96DZQQi4u?=
 =?us-ascii?Q?gePGUACEZ+6W/SiH6Ka9u7kFFDZQrkH1F7RpdrMNwcBULac/VMor+dUXJQMk?=
 =?us-ascii?Q?RmYDx7RHKK35r6QOVeV+67RDaCOoK6ZvQSniHp71f1RLvlk928IHsR3PAgfm?=
 =?us-ascii?Q?kFQP7WASG/M4ts5cPSuykT5ywIm2sLuGFxudcmLomQjnkLjqCPjW7IYDxyZ0?=
 =?us-ascii?Q?MAH8S49kWoUY4K2dg/LjA2zO55ICWbMxSw78oZzp0kERjVm/kroNnjBcFyyE?=
 =?us-ascii?Q?rARssWfY59a8lHaC+fvUAyxo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cdefc0-4f6c-4be7-2116-08d94b9536b7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:09.1928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbuJtA70FRtKoZmUt+kAD+VN7wuZyYb5HXmrnBe+6tkn1XEKMui7zm9BgyAPpILycPISX0/onCvv3blQMPUnkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add ip blocks for cyan_skillfish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 76692106a144..837c101ce5d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1043,6 +1043,15 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+                amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+                amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+                if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+                        amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+                amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+                amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
