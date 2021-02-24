Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1BFC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F343A64E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F343A64E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D6E6EB35;
	Wed, 24 Feb 2021 22:20:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819006EB21
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC91kvW4yrWDh/hfPMLyEm+4AYeJtu9rTuMjNs3xukITql8IQ+jOBuJKYLcLkn/JbpyCQZquO+N8RlQV36CTZo78ZBRU2aMn4XrFKm4b1l3cLQDljVT/wAX6v5kssSvjE9FxabfPNpZeRlbluGk71+RHtO8XKB4GIUJeqGLui8VXKnaZEASVFG0A+KSjTtz1UnK0ryfiWtMSlwnPZ6J3eqg8nKKMqjCLVTiTgrITfXAYPo3Mrjy7H7VBqdcZrNlpBwlAR2BiR5/csw/ZNEJFmynRri5jhF40CXmmjABjP0KdnHHJjn1wlaB5xen1UaFND1bbnWoBpiWJW5h3GpiuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnffN8puA3r8Vd8mS4AmWm/xlh69+Nd2Fk+1nLeNuCY=;
 b=Gaw0u/P9/s9L6OtPrXPrO9eNw1HqqWaPJfqF6oZsQj5TnTzQWgoMIWM+d9It8GmqiYsrOOi+5nsK4i0vE0TUCn5KT9Zq3cbl5ekas41+wVVb/YvhaJQE4xJmfSdGPa3tjXgYvdMDSEdnbNHIvKNU9Z0Ltg/RiajiJn2njzANvgv9HJSqGfhm+GO3d3UbGPrayBMPUCArNjBsp9bG2I/P+6eRRKtMse46OKbVVHa/nR5/36LVCejI855tFMltbMlNpa8ltleWOabyTXdyreGZ1CumNOHcWQL4tScNoKThi8igiVB1ZHissLPUWC6ahND4+TvVMuot6A2b3xdZ21EDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnffN8puA3r8Vd8mS4AmWm/xlh69+Nd2Fk+1nLeNuCY=;
 b=ViEhChivXuKHYcoKrBlFxR+oqsH9opMfou+Tx5TOyEeNMnZz2sEAoTmLkCceOUrpyBcDmt97zwRYWmmKHPgnbz7cIgnMzURrOV8amPXmGi/48EFKNzOLxSoj8en8ooChUIsYegd7/w+eC6CaA0CGiCdF3FqF1u3W3aq6MVsywKQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:20:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:16 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 038/159] drm/amdgpu: initialize smuio callbacks for aldebaran
Date: Wed, 24 Feb 2021 17:16:58 -0500
Message-Id: <20210224221859.3068810-31-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54151140-2dc2-44de-7c7f-08d8d9124a90
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4865F57794027014BF8EC990F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RzI1Xj78aHEFUvQP0th9DCejpvLhN07++1XfovKFqq7z+cfsbPMH/7/wWjFce4zqFD1xD7l/WsK92qvuiUj+zE+fF8vBLTx1t/odFwsHNeyZvIKwNXGfata4KYdXbFNGcfJMkGbWtK1s8W9RsIVhKwO5TPVpeH/gsdAMK2U6CuANATrYsrT0J8I4KAdszNld5/e5e57F9I7oAZ1MrpFd0DGuhoa5pLXyKdzXGSiwvXVKEOkJcivMwEMdjigjahP2cUtVto7Mm/AGJn2X4eUVEdtPKRwYQ38eQ9lERchIrkg5wdFDoQNgSKcCkSgbTk4uyIRUAMr40DmXZPRqPpX9Iopn2q3XYdCAUCYrjiHsuAjiG1U6d1yD9ze6RcytbWThchTsAJ3p0QWOSWFJwOCVT2UAJCZgHpspiHl7haAi7Nh+erHEmVrUl0tOtUsojNF1QLLFqInli0srhNjAOpC3UcKCjYYfMibmdMR2eToeEiczOzDt/21jXXGN1fMSUa2RXOlr/B7p5/CaNe1Uz7TFNf0qHlVS343ks/zZ3++ke2Nj8IijUEJ7HvmpYfpDBkn5hbp0mSax+9NjsZrwJevVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K1rc4VZO6Dsk7b0vfYjX1Cb7hU+mvCVxyto+TmFKf8pJhQrofIZtqYKi4fhV?=
 =?us-ascii?Q?zBfnBIBegHBrsfxzYqdHrqumqtV9xGFJ/liAJBpr9avMQUhiyGpcKNaWzXRD?=
 =?us-ascii?Q?M4WzPvMEsUrWS6OMMseYH54afKuUOSSxfWWnV+gHmeJbRkoLlx3dIJoPVC70?=
 =?us-ascii?Q?Wj7dRT0LtfJNCU9PRxmZYR5wa/81HMTK5HZFFj5Rlj9HIyLCYy+GtDyzkzM8?=
 =?us-ascii?Q?ZphMrBq7yqLT1et4fluzR7zRJjQMA8sGL24e/EflAPjp3tyoAA7SGgnhLzrw?=
 =?us-ascii?Q?R0IIBi9TSwdwQXaBpAbgQLmYEH++4Ytykkm7NC7VI5rJvGIwhDbN0OvnMhXS?=
 =?us-ascii?Q?XHCsqYhkuEgee2c+fO9Y+qMbvpicdd8ymTfdGW0nGjN0HzZBxpxre9M1MFeN?=
 =?us-ascii?Q?weyLDf7y+4ADFi/2uNfV+c2naOGLdkR2kN3kyv/zY4MGoH7VZDmnQJnkS36/?=
 =?us-ascii?Q?CjG4IHnejIa8hKWyL5vaLaKchdLBU3s/KPj7oWUu2XgR9LP7f02pSPydKhud?=
 =?us-ascii?Q?RgB0mkGvkxuH6z33zXqwuVoouRNvgtJcxj6YMiASDJ25U8JmwJKafIDXtsSy?=
 =?us-ascii?Q?IWZFxnFU96PbR+xxJ0ui+ccwmwnQg1uz7cCWopBGISdjZb7gLa4uu94oVuXD?=
 =?us-ascii?Q?kM18x01BgyMAWkLOdAAz+/K5fLUEACSKK6o4G/xlrQ7k02nUwHACqCBLP/+U?=
 =?us-ascii?Q?ClLzmsPNpcHLoXi6o9XI5k74yIZo7vo5+dC8AlGU9MiJ30q9Gkaa5Q75MxlK?=
 =?us-ascii?Q?kt2Q+S8x3ZWBudRq5EYHTRm4tCwJ6hx/+02SKv03zcZcXUIeQIWBiL8rwDAF?=
 =?us-ascii?Q?SoTyuUmnRgYg9G6rwT5KQ+q06dqhHvrY52F5eEWcxhngXVb84JCNeGiX3qtK?=
 =?us-ascii?Q?gcqSeD1AArvLz78zZQ+mkYIpHcccFtTObQcHp375oQhT/iFvo5XQtJayRnzl?=
 =?us-ascii?Q?Is2XGP3Gqa07EM9PsP5Q+FwmEc2AXLFrjYQGpLoNi12JCPPhVGzLRM70ujo9?=
 =?us-ascii?Q?E39sjWD8snDWxY4uhH0SgweXUO+NZ0g2hSXKnI75m/NEReCNEQDhZv3kcRKQ?=
 =?us-ascii?Q?XPAEqkJ6IU2DtVkl1CNzZ8Wz38ax2dwTNXriEY/dCrx9D21d5HP1FSeMPz3k?=
 =?us-ascii?Q?OwmyLTb20ZmlUwnEP7Q3i6LJ0Rag0VNoB+ECpAyF0oaA03U1CZUf4IwfPlYJ?=
 =?us-ascii?Q?ekYpO//I5lcJHzFeHgSURQIlwdQWXkWS5Qu4kq7Z/3k0+tgBOAccWDXwWO1E?=
 =?us-ascii?Q?B4pYvTCRYTT683R2aSUAy9p+mhq+5AlnNGqvVYmk2QS2Imx6YTh4jhrpPN/Z?=
 =?us-ascii?Q?o0RY7HokFy/611FgddjhiBD/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54151140-2dc2-44de-7c7f-08d8d9124a90
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:45.9792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbFamkQ7DE3rCg/Gv870ycA0gV2c3+k7JgzgkRUI5rv3ThPGb43qWHuQgOOof4ti8VH7/giVUMXPj/JD37eB2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

initialize smuio v13_0 callbacks for aldebaran

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d379fcd48b31..721b3b6207df 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -71,6 +71,7 @@
 #include "jpeg_v2_5.h"
 #include "smuio_v9_0.h"
 #include "smuio_v11_0.h"
+#include "smuio_v13_0.h"
 #include "dce_virtual.h"
 #include "mxgpu_ai.h"
 #include "amdgpu_smu.h"
@@ -713,6 +714,8 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20 ||
 	    adev->asic_type == CHIP_ARCTURUS)
 		adev->smuio.funcs = &smuio_v11_0_funcs;
+	else if (adev->asic_type == CHIP_ALDEBARAN)
+		adev->smuio.funcs = &smuio_v13_0_funcs;
 	else
 		adev->smuio.funcs = &smuio_v9_0_funcs;
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
