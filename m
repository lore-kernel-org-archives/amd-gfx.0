Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456ECC43600
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 20:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0826144E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 20:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0826144E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565446EC42;
	Fri, 23 Apr 2021 20:49:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB886EC41
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 20:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2Ea4haMuF4vcujA+SMe8oToK631AV3ulCrlCdvkeLyXXTaXQc2Sb9NaOXUfuUDjevITTCz3PhbY1vKVpcPH03svfcxgWhxktSUcJJlhf0cU2PXH6bqLj3Awp2LcTl7z+4JqOf0wz9KDHqtXrppp/R68kojt/9Z54ZwuOlOMe89awxXjezafo2gs6AMlhSiFBqav2gBO7ESh+mKlVJp59W7XqgNtJ8uohavWaLVKvBcgMDWnRhmPFTHgGeKi4wKDG7/2pAICNZgymrUWpWCppiiHdaFE9k/1goZU1CBIELCcsC11F3trJJspS2GEko4LEto1I0W8EkySuHYiZW+8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp5d6EQDD002v7G2FKHLU5wW1M9T+z/MA6WPdKIqqac=;
 b=UdkcCBobydfktzukMXhvDqUmm1XUJYH7DWlsOQAV3kmvhcnod3iRKZW4S5R1bNjOPdrxiEKXnbGuW13Q1xT1kjT1/cd9j+volyhNGuCs53GjMwo/d1DjO4mDyBXwKbBpzRZ+Kz6YDsUZkfp9ez1IpkmsS5pi96vZ8rFGhw2O7GnWm/yPvw0IzBMdoE7Ar6Y9TxomrZPUmvPgGKeh6wcvbI7Q9UBVrtfW/uliQ3h5dkgxOtPEZI2KIUubb8G2D+8rEa79GqSIWG8xQAxxumkf3AjYjt5QyOcUPmDjsNnlYdoTIcy4QXjvP8zLHcDne+3L2qTTpJ6LjR6dulKZtaJ3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp5d6EQDD002v7G2FKHLU5wW1M9T+z/MA6WPdKIqqac=;
 b=Spdvv/XRlg7B6VFCMnWE6E9iK6AY71Rc+YtB9wTmCw0qk8ug1aF93od9sCQgNOyNiHmK9H2jP7CNOgEL25erLxhZT6/50nX1jWSAeDtkxmww7kKhA9Fp17mP+5DzBS2mxoskmolfXEXGJ39BgqsRj1RBYtaFo8mKm4Rolr6QQuM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 20:49:51 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 20:49:51 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: fix dal_allocation documentation
Date: Fri, 23 Apr 2021 16:49:30 -0400
Message-Id: <20210423204931.428241-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::6) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.19 via Frontend Transport; Fri, 23 Apr 2021 20:49:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62e12a8f-b887-4c7f-c92c-08d906995719
X-MS-TrafficTypeDiagnostic: MN2PR12MB4160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4160878A6D5AC26E7C491C3AF7459@MN2PR12MB4160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7h1ux0sy7ZJc2/BsBFcwDkHn3iy96+aaIuRtvieS7Hs1KvrHiFW0iwFgWzVOoI2bw5nXjTI/7xl3j7JJzV7wpQOdtHJVkl1k1lU3MWH+7c+OeuPrdmv7QOTjZNPPlqiJSqTAGxn51EH7EyYCW1TnHaIlsGoDjEJnAWQeYkadczCoDBHIjUtphZA0HaisEupr2JdVNwbXtNvMlsOMcF0tPlbOHyHklrPYTz6LLTnLnCQ6VBAAt1bXj7bp1KsoFE0J/COgCmvDwXLRixbbKTmJ9ONJQIy0DVnNaePUk7SIYfG7atWMWV5lWEhJUT+Zx0BxS5FV4nXMN4KSgUCb1u6AdF/10PBIKcDac7e6JOeUL2hfNtdOoWMmp1ZAlFjwGR7AaFGGsJNw3yjJZ+aSjrUGUY7eZEOzTTeruLY2uTWzmJTrNJRqlnK9+RPhrrnV4Hbbp33i1STSREp+XAMVus9Ev7ifVSdPQTA25ZIkfc+Bh//+k8LD+mc5r7Jb1RzyteNqz3MPePn2aDtZ5zB883AQBNHVqvsPMWTeirAHZ/981nHLv7ihTpUmN3TM5+yiQXso4gqmdEEAKv3s1h/R70YtgyvDXPVDzn6vGVP256nxA9sFp09Dg+FnUZUhPwJK6d15gneU6O3ifbsBNYodkG6Hmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(478600001)(36756003)(66946007)(52116002)(8936002)(316002)(66476007)(6916009)(7696005)(4326008)(6486002)(66556008)(4744005)(8676002)(26005)(16526019)(5660300002)(2616005)(186003)(38100700002)(38350700002)(956004)(6666004)(1076003)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yiTA1sv4khadUCnpHC5G4FMm3RhvfWk5vV7sxNSbhq2W5Z/65gSHLWEIL4wM?=
 =?us-ascii?Q?TGtnA2yJFBJY0QqQ4C4e4C7PdXmYmiUAqsvbb/6wSg+GXqtYHbNq++ZKLUS8?=
 =?us-ascii?Q?b5TYDLS0DL2pVoZGnQuLtUrw/8kfuHhQuclzaFffDyuY7FAz7BxKVrBdhry7?=
 =?us-ascii?Q?VXu5woziUFpvIJg2f3kzACXE24Ri3Y5k0SXxQZtpazt3lhZiPPSbYDsz/oFr?=
 =?us-ascii?Q?odNAnJlmk9xl+Yt/irnzYqRLb0QdAjlesDA9echDrJt4MqQh9DEuFjj4FNAz?=
 =?us-ascii?Q?mDMglYEaiHyTVrhNh/icUmKwt/tmHqpD2HNH/RZeCwPZ6DbO/poCx+k7a0sR?=
 =?us-ascii?Q?zrpCK8eDMbC9hNAZrFcIbhaBDPNlTTtTUmoRUnP1qchsGECyiU5vBNWZIE1Z?=
 =?us-ascii?Q?d43WQF0QJfrlJFnnqtKWm8dKecA0L7SyXoiBnA0/MqANobIL5gDHLza8YXVy?=
 =?us-ascii?Q?6+W4D1fk3cpNcOMnwU7RXuRFJpBYuvgslt396qkxkh1YGcIFkrgwISMV7wqr?=
 =?us-ascii?Q?8YVB7Sk68/uDJ9DFEcdrH5od7s5TTbcCB4cD68X+dSUwIafMy2NGqPkaYYs8?=
 =?us-ascii?Q?0UYYrH1ZKQPWwz6zWVR812DPrv8vDom4fCsaZ0gnEQfwzuJTASRBupv5yaN+?=
 =?us-ascii?Q?3QX9JhsJN1jZ4rcZcB45xO61o/lTPSeXHQghMaK34Vuowwjdlha/5HGbt+yH?=
 =?us-ascii?Q?PeMYMpAmu3sssZZbtbB1rOF4QmxOZJ30iio/gHolYyW/8sz7pwxWJ6AbtCm7?=
 =?us-ascii?Q?n7QxdamaUgEYoNk/ID5aVbT0T16l54nRZI9iPqMH3BXnc5QJLEBjDo4aZNL9?=
 =?us-ascii?Q?r2/RpmJx2OW01zhRrdxGGgjIBalPT69ugaXdUKYHVzBpB0gzNZdulu7TAqrz?=
 =?us-ascii?Q?AXFPcfwAc9XkewPU4uhgAOzJn+wktvrEeXkcftSUOPv43Mh6lRouW9RE1f/X?=
 =?us-ascii?Q?8qSaTyjY9N9VUzRDvl+tuVtquZL+Bioe8lzmYXwthPr5fxeG+Pj1k70XIRm7?=
 =?us-ascii?Q?avouNGhQqCB9MbVHegS8FpOBcXJ/DMkX+aZ0lI/E7a3tupOeMmh8Q/tLlvgO?=
 =?us-ascii?Q?Lt+Odi7fWhV7aPDpK7vu23U3pIf8WckwWJZzb/m3B5GLjY9BHm4lJhyhJsD2?=
 =?us-ascii?Q?Ys/EQ+qkK8nMPtTX02+Y/IARJqnslvlyUZESb+Au877Zp+XWKhmYcscxP0Jc?=
 =?us-ascii?Q?URnr3eqz8d43Jp05dhi0b5x+ALAbe3PWGiYMJgz5qcwuE0ZY46cxpJKSaLLj?=
 =?us-ascii?Q?FGdSHa3I+T+bBmLZfCddfdcSoJnSQMDyPYiBec/OB+TRAENhWUzwLIlH/OL0?=
 =?us-ascii?Q?rpU6CRAlJBAqG7FMhlYRIXuN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e12a8f-b887-4c7f-c92c-08d906995719
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 20:49:51.2349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCa4pqipMOsiSEUPjA7R0h/vvpsNFoYdWnjFJr1nWNgybS/3OF3bmAHhMxDtYgS4cmD8x8saap3M8n9Hf9/Z3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing structure elements.

Fixes: 1ace37b873c2 ("drm/amdgpu/display: Implement functions to let DC allocate GPU memory")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 77e338b3ab6b..d6a44b4fc472 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -135,6 +135,10 @@ struct amdgpu_dm_backlight_caps {
 
 /**
  * struct dal_allocation - Tracks mapped FB memory for SMU communication
+ * @list: list of dal allocations
+ * @bo: GPU buffer object
+ * @cpu_ptr: CPU virtual address of the GPU buffer object
+ * @gpu_addr: GPU virtual address of the GPU buffer object
  */
 struct dal_allocation {
 	struct list_head list;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
