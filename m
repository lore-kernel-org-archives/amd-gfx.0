Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF75C636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F1A60FEA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F1A60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CBB6E44C;
	Tue, 20 Jul 2021 15:44:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E786E446
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahC9lwhTN7eLWtaMwbx08NadA0LcGPVwpM52U6KADYyg1UjYpUUr90AmpEkChUmtxkUM5LkQ8V2MFUuMja76X0AaVgQNtc3jSZTx3pfFTjm5v9+RV/RtE1q8i08d3u+QacnHqB9QZus4cv0WnH8eO1OuZZLiQUt9SdubpWSuRDMpX0xjEoD6rqBtQQEJ/OWzl4UCvOvd5I2aAMZfs4uhEZ1K3uI1HcGsyKXPhZHXB4kYC28NbhyU8mRhu786joemsSXSYJhNXexyuaz15ylhf96RdqlMhE4HC3z059wWyYmUKjEKJXlhO221/Y9m34UVFFpRnkfT6CaM50MYC5qtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C/wSJQTi5zhrLg54WB2Ucyku954Pd2elxhMqIyR/VY=;
 b=V/5oSei3yltlmNGEY4bNjSikVYDh486BrhcAQFniZX1TW4E+fsboHsd2PP/cRXA4yoRHB8eLVuttAleGcozHVCPsEbuxXB8r4bQf1ohROPddscyiMTsLjjZCbvANs6pjvT6C9hX3M/egefnPKOj6FHKmkTw6DUjTYe+/5fRqTlrkJP2Ol7ix/DWIEte5piEFwpcQzEuTc9I8Fvi30TJmJoQWjyplXd/emvzy6cDbE9VF0vy6RyuUodcDU8250slNVhO37dcCCYFSFSEQ1mcNSZdseg1CwGNnB98WQji8Z1eOyGGyM7tByzDtObnaO9ZiAvzWZDM0C0f/ijovP3aZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C/wSJQTi5zhrLg54WB2Ucyku954Pd2elxhMqIyR/VY=;
 b=UnccDSMbGo/gsQTW/QTVilbdnM0AfY0NfV49GsDuoPHMmEE+Zbe9Qe9pbUI++k9A89Zt+M2azIgdI9A4586Xe3/zROwhkKzhGdY0CvfOz7MHjeLJOk42hyqI19lhRK2AIKu104dwGp9WVTC2FetdO0FjKTQUyFvcNnnWugmu9NE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/29] drm/amdgpu: add pci device id for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:49 -0400
Message-Id: <20210720154349.1599827-30-alexander.deucher@amd.com>
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
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe138f13-6789-4d5d-de2f-08d94b9543db
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5537F2609D568F42A914CB2EF7E29@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z51t4VzdO5SiWv9Qq0bo7XKXqDn47zeQhDIOsoepOdW1myTQu7Nz2xNcOD+PwnnzKMjNvl5CCoovx0zr7vlT1oFrHx1cwBQdbVjuJr89ej4n4wGzk0KMF+N2hHF4oHCVIPRBhm1ZmLqj9W1TR+V97ksY35frJOQ2UcFU+GpmsDXflrEz1xM0J/uQsYNaWbvLAvgd3WUxX+8o9191WmKRc5S2dBx3SZpSnr5+UR6N13S4H30y5hNWQ1mi7SK2aTnn3ES/LiMjQsWV3yWxxIEHrSOtRkydVzwDk+A2nX7/wL6MB29LUcC8tMCt3iTwPtHRZAfm4/ItACfQT7vN9kp1GIUBt3YTxZCPYJucPVMREIxGSCqqvZjVjN5ZahShFC+QcCaMCfRA1giinhStWfXyelV3VnMypfLsf3/p8j9TQUjwiLE2QgRVveJrjYy21Sl27ga1wFlj3DrwOZcmW6N9QEn6U00gENt07gY5Yt+ZO3CgZwL098XtIRPidMBiInjwhz3RzUyBbNTjB7gRnXQ34lI08yZH0n3SijBZbA8pOlHSTdluaV0B40sOv8yw/RW21PaacrJaIFMwYXCvfg4Wdw2VYPlvmSM+RX0lYAGvqSufVC8dZ6f+eJdAjgq/eHxL5P3oSiFWXl7gd5ZfELyDTzzTKcN/ndlHHUIlTCdTOz+LoF54DiQqgd+jOmK4/zwU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(66476007)(26005)(86362001)(6486002)(66556008)(6666004)(2906002)(1076003)(508600001)(66946007)(4744005)(7696005)(52116002)(186003)(54906003)(4326008)(36756003)(316002)(8676002)(5660300002)(8936002)(2616005)(956004)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJegvxr0rMXSBbndgn7kJUjRbMu6UMY5sDJaTyVzmqIrstOknJWl1J79ET6a?=
 =?us-ascii?Q?wtRaXhiygFnmjULt3iKD6AgXU3StkTDPfOv417YcYwDCSvRUAj7T3QwKgYVP?=
 =?us-ascii?Q?GiC1Ma4XkpdqudBxb4++LDnBCaoVnEvSk0Ly7ydHxrDRfyEDUAvZM6/haO3E?=
 =?us-ascii?Q?EqToeyl0lP/vruxxmi4kpnTDmynfW07OOcWERIHt1P9seMmPZNJaLzvCGZWr?=
 =?us-ascii?Q?jOPpaTnVgb6OyNLYgxnZcdU4xnVDLRqHxgz/pYxVW6tixvpvt41WaHalLZjT?=
 =?us-ascii?Q?LKS9ANhTxnqnvQR3NF6UO69I3Rtjm26WrRwbyxtyb9Tt4dRjQ3tH585rAE+E?=
 =?us-ascii?Q?P6j5ofqio/MKjn6wdPi9WiLDAGLn/dMX960hrJBWPJmxHVtZt+L15XQOkJeU?=
 =?us-ascii?Q?B6ceM8Y4Aia/PmvztS9peU9QtJjNixojI43R5Blw0GSg5votmQ+rhH5fIPvY?=
 =?us-ascii?Q?vdvm4Aum/sKFpnsjVP0YBDts8L9MdZLpMW1lPPdQToUuafg1vHw/2iMplY5y?=
 =?us-ascii?Q?XO1U9v/orI8XxzAjgJfLRU5moZdMEKmyKJ2kuMEkycnMwS5N6KiY7MtBazwT?=
 =?us-ascii?Q?X0u8heppkhAgHtbeWTSf6bMeDMCFVhFQdeR8/Fth/Ye3pV57QizX6mMRVzG/?=
 =?us-ascii?Q?IheS5iD9maGvJNgLfT+r0wEnpqFIyTIuzXFM+EYkP/tuwC/lZN1281Ygg9My?=
 =?us-ascii?Q?rS7dJFMTBr+X9NUgViCne6TDHJTj/GzoER8My9zPh6TIzrgBWOFGEqJhMbkF?=
 =?us-ascii?Q?2TwQXAVw31tNI6UWOVqR8bq3pk6IqLmvb2RHoF5kDaYFJBixlKKJpvlTu0XU?=
 =?us-ascii?Q?J2C7u7SM+dDFm2gB7hpmnnGHtmHUdjk6jmrn2NaY38FhO7sMwayEqW9aGyk5?=
 =?us-ascii?Q?52OYZKg8/Rg3JBVUgEhzQVAH3O4geFxdsQciXWDLU2LfNtrwgpKGAsMFBmAh?=
 =?us-ascii?Q?kayVbhyRtaif7aaVB3qgno9/apfE/S5HRLjJu4taAPOdvOJ3PKbFzYvSzQVw?=
 =?us-ascii?Q?VMZTu6w3mieXJMvScg5wT/xbyTk66EY69Ffxd+xpBoFJSJE6MBtvwxR9mQlq?=
 =?us-ascii?Q?lYJhaq1UtiPbW9SoOowau1wLKlRtCaWf+tDozDDcDUXW2kxKlx/919HhMq4q?=
 =?us-ascii?Q?2x3Yz9nCMdL08Q280DXYFO/ZQ0RRQ9fw/9cj9+St1Fbokmq2PnCX4St9IOP/?=
 =?us-ascii?Q?LGf4hqOw9R/PtTgeoSfd/yxIGtxHD+B+94JX2Oc9J1dxd25ynr5i8bBwgdBt?=
 =?us-ascii?Q?Gt8FDIkraFxVGLDS51xAo89jevISItEoX4DT6qnY6svLCOr7fHzC+74fG77+?=
 =?us-ascii?Q?qOIiQ7Qa9wkbPIHj/EjwT8VC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe138f13-6789-4d5d-de2f-08d94b9543db
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:31.2997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBp3JTFokFPVcijrL7R8E2OSlAyeKAFm4wtLHRmasRWcp8IHi2H1mAHlo3/NsWZhS0/8pS/zq0mnrZI7iCpzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
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

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 179f2d01a082..c698016b3075 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1206,6 +1206,9 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
 	{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
 
+	/* CYAN_SKILLFISH */
+	{0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
+
 	{0, 0, 0}
 };
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
