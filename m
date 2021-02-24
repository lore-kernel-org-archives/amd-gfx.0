Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70959C4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E1764EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E1764EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3476EBB7;
	Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770089.outbound.protection.outlook.com [40.107.77.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A60D6EB9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9ixYckJieRz1B1aIBH4GOvv6UMGFSejyt2AxV+gGS6CLYOFzUUUr22nXHVKSR4CkC3m/IjuRfkOUg9QKgTH1xGXF88R40+eny8Dt8jTnwzrWsu8HbdG5iQrn/na/ovCS4GRYPfwHrxr587scAr57sTmTeMNpu9R3L4PhPojFyNsqoQjiyj5S7Hlkc/wW87LF0UFHQW/iW3xZ2JmRNPqI0Hx0jpY8ZmtkOxogvq9TId73LDwwGbysjJvCX9RZs+Q59hs4zijIIQN28xOL2+9IXcf0OkIzSaUdp7wwXo1TW5wkiEKVqlU+61AAt8K5fRKzU4WFOme0yldgruqt09vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHEax8t1hdczw+4VLZI003fcmdQBAFhW4OX8sawZFG8=;
 b=bxJGOsVPf+3QVmP2bnMUnwzAz6vDNrQT4M+KtPkYrTfsuvwhCuJXwFpRmQiKRtLjvILQHkvlP/EMFSJ4q96p5w2VT9NFvJdy22B2c+67hcw3Q0bCIeZ7n19EgTovOfb40uvB6DC/Kxd/ASvIBJm0995L+ZBfDTCeFWh3ZB7OZTFo6EiuAwKfV+PuLivuUfEdDl+uC+53X3eYWfArve4zqM/TvaLrgAPDd/fjKV1z5fepAuq3I+JXeOCtI8g16bT7fxcLCFHLbkiQ1FlQ7bu9rc9KWc6UBdEp+7LYyP2Ix7DG48dF0bi25S5I3hYY/Z8i2Qs+hUD+URWNRapRHXtFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHEax8t1hdczw+4VLZI003fcmdQBAFhW4OX8sawZFG8=;
 b=xSD4AGvXou6Qcx5WKGbdi8IBVQRfdeimAMkay5je1owUbLGjdk3NOfD9nC95VVJ4+Wgh8ZhlyMuKcXoPAtlv+JgxNTQnBvMvX/kLS60gYlOw9DK2V5s4V58ar6TPYX4o9XyMO4VG+zR2k/QliMMeus0MTUmp3oF+v0Rd920c91U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 143/159] drm/amdgpu: allow use psp to load firmware (v2)
Date: Wed, 24 Feb 2021 17:18:43 -0500
Message-Id: <20210224221859.3068810-136-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39baebcd-180d-4c25-a71b-08d8d912766c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807D6CD7B9E0A3DB2A8D310F79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQ0RrCu9liYyEvecV85jyOSjIj4SkMAoKqGM+9B4a2h/djKqNv2W68+ujZv6vY/YkKEwXWTz3ikDNp8LcmYHOFTot4h0L/GYEvuHhB/MNe4p5lZXRxueReoc4Lm8sIe8oMxCVb5D6nMUVlsqMjXPbX+7s+Pw0OlTzMLsiob1JfQxTV8LDhTBRWP6fKrQHeroJ0CdML6wHz2+Eu0Se9jwcGt4hlLJ2V2Rzpt1ZDbKL5Z5GtqECEGW9y2KKFMQTdSATiLMRsOVn7WaJC3MBghQaEexKr7VVAN72jDZxT8pv4nFF3IVGr7TDlj4Rpn7FK/2f8bWBj4ycx/7adw0EJIoircIEIoSHRSNuuJtI8LMmnzMXb3tW9D22mJ3yzeUbMSOP/iHMHoIWEPsWO74/h/VmQTYJQdc6bveVHFb7rKeywPZ2FUasv3xztjBitKPpLfXyWYiHxRtTzdstOu1ewhRpSdPIbqF0QIl81gHH596LaGQgRzjI6iKyUBizyprEaKGe/Q6mciRgY4W3UEzQ85BymF/zJLTVX+jFYwQA71zCtJux4h76v97YWpOJzZ3wdDtieNCtmQYv9q/0osPSXHJ5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(4744005)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CnJ+O50P5Lea0U/fEjwnCB6b6rXBKmpXa3HrpR8L+LjiasPVN52/v5dUusRY?=
 =?us-ascii?Q?RLj6YwlhQjp14HHpjnE9yLvyw/3gjYLCJnpQkxRwplegSQW6C/q2o5mXw8nw?=
 =?us-ascii?Q?esQtNAnVfos0GMJoJ8gEqfuktAvC3/BZiZMa9e2iNxVqltE0sZPDDYIzOEhw?=
 =?us-ascii?Q?eU0Hc+C5bmA1QTvf7bX1eu2rQDMtzGxdV+JuTxKl+Yc9JP4PfWvtwhvxYraZ?=
 =?us-ascii?Q?z/Ul5qLKGZJYGlEE3ZzvhRfglXOjBUwnKEhJwT1oYnzHy50LDj0vI9GJSBP8?=
 =?us-ascii?Q?bQYelZsNgAUdRnPGswAU1zsDe74NRSH7JtT4l4RwA9nkxl4wkqWSRcwgqPZM?=
 =?us-ascii?Q?l50d92hVp3Hsfad9ABH51RVN+Lmx+uW5+PG8PUmOvASpf6+Qhqow9GG9C+zG?=
 =?us-ascii?Q?W4nIklL9s3lu1HZZHZRhKD0MjDpzGLYk+KsjEb/BIL3XBShtYLW0vL63rwo7?=
 =?us-ascii?Q?f7stmpQ2bDmxDwS9jNmBCrRsgccIN/16czfvkC0PAackBI/+R5xGlJjUK9Pz?=
 =?us-ascii?Q?g9xspOBPNjN1MCunAuY67tr1LzvFEktr73uGpX8jJmGtikFh10qYXClWyaTs?=
 =?us-ascii?Q?iFKYAVKhRbcpiRZuSFy13o/zRQg72R3ydBMf62PdtmIRwNURVrOOhqHPhPY9?=
 =?us-ascii?Q?/uFsbpAje6DnAtB4IALxeqnnZ16Jh6JT3cNpLSY33VhmwkTR3w1ydDJ951XP?=
 =?us-ascii?Q?MwDbVpVVDITn9w+3mBHdfXduWXsjkjgoxEHbWS3F0AtR1JYbIuJLSfnorHQN?=
 =?us-ascii?Q?b5VG0FYYGAD7Io97se6Kp96G82m73XuR24q8vDDknfVD8YQZ709kGRebfIRl?=
 =?us-ascii?Q?HM0W2fk4Jkmta16DphI2R0TUp+5oF+lVhUoq5hQxlOi0N46zjb8QCV44DtP0?=
 =?us-ascii?Q?qhMiiJz2MxAFiWs6s+m4NiUqU37aWPfjvqyWgLh4zj92nOmel5DtvSoxMiJt?=
 =?us-ascii?Q?oWp5+nzdLsplhmnRyZg8fUi+3GIgrWAk9pMOwGJQyU2dPelOF2PwIzmnOVwA?=
 =?us-ascii?Q?bgguGHaEks6RRlxJk2kA3y3xAvVj0V3egu4xnrNC0Z5Pybt2E51dJdiVV3GC?=
 =?us-ascii?Q?YwUCJG3zBqNNtA0VL4K0w6gppGJIjBllRO7Te8Hs8VljwgH8WGjXsprF71DB?=
 =?us-ascii?Q?D+gGHUqI2t5I78Lgj+9XiyidIcgOLAIacqCtMxF4t5YxWbpvm6W6CZmOrnMF?=
 =?us-ascii?Q?V9uLoO4BHRLDWlzvOOwqY0UGzslpBG3TdTGzcVgv+iQ7Qhg3tdBOYKmZe72n?=
 =?us-ascii?Q?HIQh0gVDPpYmVp9q/5wZTOnh7/xU3gUwPCn5XCtp6lCGrrHyH0bCHa36HXrQ?=
 =?us-ascii?Q?nvughNedEZtwK/eFEJAfO+8J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39baebcd-180d-4c25-a71b-08d8d912766c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:59.4357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY9smRwRni+y1gN/E4GVCikyljeCK9rxHZ+xX76JI1B2UzEIvv75WasvRwdVjoAmKr0wex/2istPeFP4TI5Brw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Match existing asics.

v2: rebase (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 358134b29c18..9733224117e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -402,12 +402,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_ALDEBARAN:
 		if (!load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
-	case CHIP_ALDEBARAN:
-		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
