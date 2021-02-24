Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99959C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6325E64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6325E64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7636EB40;
	Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62E46EB3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3UoS5WDUL3aKCYSLKSomqzIOpjg6/aS3GxHgZV3ZOCnP5oa/yCCdD11s/1L7YGemZuopUAvQJduLl2n/6oFxyICu6DNsWXJA3mG9jOqm/6ItOefLry6ULtY4SplDB+KTbS3pWh4mXzYGUn5XzoSB4cj0qgxiyhUssQ0Twl1yVGNeiYVEfepx76JXUYTp9KbNMqyu2QTJ4OFGRY/+TmR+ZIwAKUU/8AFg1ZOk+erQXtcLR3xhHZqsgcfJOYFLfoWJTz7T45o6dvu+Wpi+gEhd4l6sWYW01ZFj4tqSvW81sBzyN5z1Bnx2cm4e5mk0qkJRzKfUMi3gH6CAtsM6hlJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmeMfY66HI22J6+HIHoSJZPzbUMCDHeGcQC2LlUnwJU=;
 b=UbGDA9rOvmaNmitJYdjWV0EpfH3h9MEWofMxH49g8svUE7aTs1P0vfQR3gUk+4IHYlisS5mYq6JFK/39eJFtQCJ3tFD7Z9BkD9JPIsJ5yPm9UVErxwlZzRsvARn0dn3LddcCMzm+Q9VZGzlzfSIe8/xphJdwvRqJMpWHQy7Q4r+DGASDA3z2Zch17qBD8P3ry1tFMjVPZ0d3xVhg9Lugn3EDnC8DEHAcJ1phsj9VQvOLeBIojHCeqAeh6heJojSnMBb9XHBC8ZLqQcTk8NaYzkOeM0Vgjs5q/PSX1cNBvPMII94NCHDw0a7hJfsjPyXPDe7tfTvsoA9YOBY7KsLe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmeMfY66HI22J6+HIHoSJZPzbUMCDHeGcQC2LlUnwJU=;
 b=zrixlm9GR0yHFw3GghgTbe38A8Lv7hfeAASKC5YGcRuahSre+EsONunfOAJyU6tILoHFCUmIOr7WkUIlVu6Zf1gMGey1uqNbERgYYiwHcfii6o5oS8nUIUdu6W8hSLroQFFxaUSubiOKvq+rFFf6R10OmAXlddPSK3daSO/1oyc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 053/159] drm/amdgpu/vcn: enable VCN on aldebaran
Date: Wed, 24 Feb 2021 17:17:13 -0500
Message-Id: <20210224221859.3068810-46-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02f51846-6487-45cb-41d1-08d8d91250f7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417502F252C162E9033F9E32F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZctlc1CrOUhxjs40J4MPY5lHePgSnYMqeEj9f/uQnuJfTNCLYqovwk4/ZbcFrKPh+TB2M5Gv4bqCbrpY7rLLpSxjuCySj09X3x4i/q5a7+AXV9L6IdRKDQjjJH4eL8l19y/aGTQGnyEyc9K8rnTwbO/HxcSBxC2tpZJQLyI2tG1uyftovDHY47nQiPMZu/XGG0ssnFovnMZ2WMmPmdv37quSxNjg2SwyZT2O1Y6w/4c0HNVBgnKXEWFB+uQIDLKrmdJUfIByV3VeCAIuyhrcSpDM5eUonXtdenrsumxS1dgCTaYnkbI/tW5+2OU/K0oc9azPfGqfcCTYaveBg+qxAj2J4jMno2cIdtKwh8hoHXlK4SMslYmdxtC80ObgUPm9FRHy/9orDGRxdKW8QY/LkzvwGu6lkImVIno85TfxLL7jCqCm1HcqjBoGZExDUUIaTITCRTM54hw/nzHfV/ldWcr2Ep9CAxDN78BEn+NAJIk5cxSop3wqT8u6/+hTO4Lb8qYNIFinDHEAEGqHUqTqBGuts1AlgZFuT//reFFinHdpahgfUOLohbxIKeWDXfCUWbmVsU0Nr41kOeOasbZww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nF6uHHKTs4vzl4r73badhr7AF82VxWZWNgrPs+YKBaKTc4VgFfpJarfM+LBz?=
 =?us-ascii?Q?WBTyxaeYZqoGzHI4nQYiNI8P1vCoCz7LCRdkTxh3xs/QLTeyJeX2rlSwsWmd?=
 =?us-ascii?Q?3aOs0LYt99ZJTpF7LmkZnOlOqo6SugkOscRqhMfmrYHj3bd8SILPsHHjWsN6?=
 =?us-ascii?Q?wd92KSkw2NSn/KfAnX5SxAvqN06Pqy20jO+E0YJWxWHG1A6m5QIz/MQon3c9?=
 =?us-ascii?Q?PJYXPygxS/ACaL0W5rSktgdMg3CH6fZbGUj2vq7e0Qbgy/CsmQUioZOIJLqA?=
 =?us-ascii?Q?oE3uoawqJt9o1if6I4L5qIU1jfrJBib4WULxPUV57WYDPAqlpNlzMdQ4orMo?=
 =?us-ascii?Q?ismBcpqUpyOWR/O347mMVuWnJa1WhfxV0Bpswcd6t9EU8ga6AtW7w7mD8x9V?=
 =?us-ascii?Q?vNtrqwnDSOV1BEg5jPshHr1VHDvKejhISfuzZfTEji6MA7L1q3XOQt2Qpvq/?=
 =?us-ascii?Q?DDFLQkpbpYUxk4fEaGH0QKU5Ns5qPgJ5ILrVSQodlBInjNaIGcJEOvdONWdk?=
 =?us-ascii?Q?xetFMeFWPTkHI3miqx+SUkeu7ZAK5aTaY8R2tQtI8xThrWzMkJ7/64mEQOWo?=
 =?us-ascii?Q?uvSCMATmZ3/Eh7+XpJw2EPXpDfy/oD6vKhO3Taaa/VqPOsCA8ILOTsd/4dVB?=
 =?us-ascii?Q?Z6qGYINEbbTx6GgFNUa4sM9Th3a1WqSb5PhlgQfDdO7bOw1QAWlwLLOdVeW2?=
 =?us-ascii?Q?Rb6JUAP18gbMW5MkT02GrGELsVmvArr2zlnaZhA7Wc4ThJDOvGY17Psk8rdr?=
 =?us-ascii?Q?yOn69EGFwXpmJHLmcFBkqbOxyy7pcpyMsgw9sYO8EQjit7kspA7XkiiPZPaj?=
 =?us-ascii?Q?v9RQLUyvqwekpZWqmsGsFw5AYLxLt7ixRWovxSI2832vJMb3CoW9PBwv8kis?=
 =?us-ascii?Q?6pDSIbwqan6vDFeD7Ow78FyeF48RyQFGiWmMroGL8KSGw0ov8W5w67f/jZZB?=
 =?us-ascii?Q?3nR86FM5+yNKSZFYCIFKgqvLrETtfrjffRv588NchtnqXRsB0287axNlrmzs?=
 =?us-ascii?Q?H+5j5QV/4PnXkGKUz0Yr4/WeNzcLCq9ZBuKfmEucklyciAQW7NSsM0hx41yp?=
 =?us-ascii?Q?0XqqqLYKlvaoJwI1sRYSmm+JQRYmwg2IWntNKfWipk4frLeAuKBT4eRwFH2l?=
 =?us-ascii?Q?+mglCQTqjCBeubrqEPSZVSqzfaSAWJmA42PXKRz7ulOLVtaXDQ64Bwfn/acC?=
 =?us-ascii?Q?L9y0ui8q6bsNguTf4eRU0v9oeOYy3yQZXXSer+SHtNI+8xbukZk6HrGUrkkw?=
 =?us-ascii?Q?37gEvf56bMOr5ZHWYC+VQ/EP0ulLoMSxqJZJmNsdy83Y33/5uslA0hdH30lx?=
 =?us-ascii?Q?2cL4wEsmBvoHkkArjwQhf8PF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f51846-6487-45cb-41d1-08d8d91250f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:56.5807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vbKlx32rk827+8AjUXANS5mqiuqcd190lz3OVWBdw+3jSng0Htq5LsSdm6xh8LZNSetMiFMXVbBR94iuhSSvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable VCN on aldebaran

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 486839c3052a..99c254700fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -848,6 +848,8 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
+
+		amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
