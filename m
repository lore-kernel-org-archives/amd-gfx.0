Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4461BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 10:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D047922211
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 10:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D047922211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4403F6E1A2;
	Mon, 18 Jan 2021 10:18:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991756E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 10:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crduiDOyYyiBDg9bC3W9vGmPogoM/WeBpdvqcGvWoBw/RCvDcJqoG9WUbzceuRV1Lkf1O1KQ9SakKhackiQpdbfQxXrKRG5nsoahdltsY/oVsSQYA+GF4vB9jFX6bJy28vORI8rjEMumfl/QRmFIqEgCF01w6H+5SFc78qTqqZccQ9UPDQJafi25DVTzRokXsGk7cMvBmDNadecemIU75xUqtHbpd2KuWI0+dvXX0pVjCTVS5aubvHv/OMFYFB17XRc7oCtff5mRC+WjYBeWAVx/vKFLgsF/jOSAt8XSnUR8Pb/uGbFL0FZIfbzBx4ukIwjs1wOCLo0/KajyJqWrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOZP7ww0n4B+FeEHMDga/LQyHq1DxQHzTQna+XWcL3I=;
 b=QXA+W59brgWwy7HAVOVUgP1V1v0PHhvMLP/CKmcgBZ6VyJMuf0ALpBBzi+BucEt53gCtDvSGDRpjnw5hw4vLEbRlavERHSnxIGY+016gCFKZ2q6HXTVA0RATMbR/gv+vYEXMIGmnyDsx6PatTU+rGTQ3XhBzkpXc3EeaFqj8Rd5YkxyHi6RPTTbVIJJOqmLQlPTtOIR6YnXKSX2gKeVvvUfhdPgKiBE3w0uLH45Z351klUwCOcEVJyT76sKfwLmytvIfm6c1oDRsvm8ExwefnPC0kypKdg6zSQ2h6niByx29iEL7decFdnHGcaXlkglEkBRpdq3pDnY+eHsoLWNA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOZP7ww0n4B+FeEHMDga/LQyHq1DxQHzTQna+XWcL3I=;
 b=jDJf1pbHV/XQ8TUgjeb9bL6L5FqHJbQmX5QShm9TyQG3UnQmAWV73AIa29qtRg29/1Xmx1xYosGlNHSQ+Tlccd0yzgWzE8fiuF9UJkO1EpMn7Kf9pu8USKRWblS4uwj6wlRuycEn585VCxdaCmEBRWVHXh9PhcvtjX2KIU5ando=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Mon, 18 Jan 2021 10:18:14 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 10:18:14 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Remove GFXOFF MASK for Vangogh
Date: Mon, 18 Jan 2021 18:17:51 +0800
Message-Id: <20210118101751.18953-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 10:18:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d854994-08ed-430d-0294-08d8bb9a5d37
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB175385B604D8CA5A78584BD990A40@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtkm64k4K4HDopd7K55dIHvZMIQtWCld5A/bXBHoUzeT7CsCd1mO/ckUTfn8AfpB1YT8OqudKQi7UdRwqtWW6njWaohh+32t6K0ct0sFkvgGSlMLfz1TueD8t4SOdXb9cbRN1sKUo3SSi7hZz2OzGl456XPovEylFj5RZEpWIHseP6im1aHdCDPRQlu66ZNuKYGPfN6ozEjReROM01PI/KdmPqw9SdABlIMhH9WOSfrvo1fmmaXPu7hanCinRXQZAgA5pX/cFZzqwxm/7/d3P6Yl+yFK0ZfsAwNAS3UOgZAeVqDMf2L1QP3KKaaB3t3Rsz+7086uwOSF9deOWJLCQD1pR7xKUKMI5vMtmBKX0jrLOpExeHJUGOq/E7390VJELhV3SmYZ9foWnK/IZd7woA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(6916009)(66556008)(83380400001)(36756003)(316002)(5660300002)(66476007)(66946007)(16526019)(52116002)(186003)(478600001)(26005)(7696005)(1076003)(2616005)(956004)(2906002)(4744005)(8676002)(6666004)(6486002)(8936002)(86362001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jMFLE8+rwY+GgBfZBezeFvcArfzY17FJUtzw1uUpxxScK9igEm0cZWujfSOm?=
 =?us-ascii?Q?xw+DwnZI17m2Zc4Zy9xDl6lfDFCYum7drCLadxFTkiGmWw+VtxpBkg7KO9KW?=
 =?us-ascii?Q?bp5Tx//ktsli7+oQpqTzwJ3Wbr3mtGIFuVzMaC5/VhnyZ+Dkt0t8AZywsi4T?=
 =?us-ascii?Q?S/rosSxobdWPoTI3AhvDhlkwTWzN/C8iidfOubGlTUizmhPOUrWyqSqle+ci?=
 =?us-ascii?Q?2wbUFcfqwrmlpedshRJyLJyB09qwonJeZaBhGWOSYbRnP/oMuZTixcEmmoRg?=
 =?us-ascii?Q?Ib9CL8U86aiRd/m2GFQ0khZOk8qYAZTlCDddBgC3Yx+4HqI7n9xIDFwbiSyZ?=
 =?us-ascii?Q?9WCJDCbXCyzwzBQRY7eKEqQB0ypXv/rPVlCdeGZRywkF4jt5Vp6427VeCZMZ?=
 =?us-ascii?Q?+GiVgbXO11RhsIv3Of4YccKVkKkmD5xKU2mfdPPCHGw+k1z4mwF8WwKPysag?=
 =?us-ascii?Q?1DTqg5QwI9zyajMuBQNbMnoTS6LJMUoKpAkd7I4wN0u3uxDicQ4LWuPsPMHJ?=
 =?us-ascii?Q?YgE9RGSE9GUyPde5FwMjXifvxTUvJq+fCfzxxSbmePvFK1ROqSpaXPcU16yq?=
 =?us-ascii?Q?+nj9ouCjnfJOZKIqm0jAyZ6k2agLgjYnw/MUb7nrLJ0uqvDUJesOJTQcnZBx?=
 =?us-ascii?Q?eCeJplsJ75hvCzIRFViee0kYz9XIjheeZXVtmbjsKKFXFhlzESUtmEYGrr5R?=
 =?us-ascii?Q?QkKmU5TqXvb47x4NvHOfscN6IzXw/ElLByP42RAR6lkVvKu3FaZPTO0+VtBO?=
 =?us-ascii?Q?qmfIdIAEshcl0Hug3gk7RgW9pkCoZHIZVtUYSrLXBIjXjBXEd1+KDeJEgG//?=
 =?us-ascii?Q?LwcSNa8SiZ3jiVMX5qLmcPfOu1pL1CFCz/gT+LKHpn31GyuiRHQNUzycb9aq?=
 =?us-ascii?Q?6ulzle/m8PYCVv7mnBnRT67KmAgT9FHbOoVu2j5BOPfYEl/vBDJaNkdBL4Bu?=
 =?us-ascii?Q?Uj7s1MDxUPzvF5b978cTaZRhP11uOfnA+U3qBq7C4rCJrzUck1A/9a1is8uf?=
 =?us-ascii?Q?cgYX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d854994-08ed-430d-0294-08d8bb9a5d37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 10:18:13.9852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dv/V4i0kz9FiOTt9opDhwkWkv281VO2HwSkC8KIVs1jQXlyVLQWdjdKgkh4SKlZoL2G2bXDt+21RoqwtwDyTkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 1. Remove PP_GFXOFF_MASK and then GFXOFF can be enabled
    by user space.
 2. GFXOFF is still disabled on Vangogh by default.
 3. When GFXOFF feature on Vangogh landed, will enable
    GFXOFF by default.
 4. GFXOFF can be enabled by debugfs interface amdgpu_gfxoff.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4d3b30a2dd45..92b1cbdebae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3775,9 +3775,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
-	case CHIP_VANGOGH:
-		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		break;
 	default:
 		break;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
