Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D08C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 04:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFA3613B5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 04:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFA3613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC7F6E811;
	Thu, 13 May 2021 04:38:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E666E811
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 04:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYP6ssIkBhzIKiQGSjiLOzVBj7/2nXfygP3aBb6zbIxpn7inAXX2Fq9l5fNJ1pJn4Bj6+uOoxbJBSS5LijOkK7HTPsRIexDf7wDMfrOs0I6tSqy2QVN97hZmBTBxHBtZ67ivXsyFEJUpF5HIwM4a55swHGUO+N1Uc2CvrMwaN0IAkYvgobEPjAEsvZgLHvL56wsszC8eCxwuFrys0jOnYVdHAc09uKMNOoMFeerfvxNacyTlp9DB3vQvAHlvk48JVFmcS7OpBYl2T0uP9FC+29b9y0XrmIyec9jPL9HT+cHAoyx2MC0Zlw1IBJPconMFcD+HkMssjWhvqIlzMgl7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYS+7ugVTVSARk/9y3QfuA01DaE8/aZaWrXYf8pMY9g=;
 b=FJjJtbgCW48OSpum32C2Ae097ilU1w6xC1/6VyIisP2sCD3rIWmXG6MDhoejTP082+MtPb96uKD9vwl525xta63sb0ZA/GdOHYugrUZPrFlBQUmAHUkPLID0y+jm9XhQqUnsSOHUv2tM3X5P92ovmujYosJP+WCOuapfnALa7NgUprJBCS1YL18hZuHKMMw2d/dmv4CTxnHxUf+3wRtDwxCiDbLmSjgJ2AVmGHoE0TqjJKRTphX91IIydGNG/vEZL5sM2JQVn07u7DgG9QqgXiQAHUnbj7eK28dm10Zss99UMq16iUztcyUqhveXTkcUZhlEz73oBqaB1LJ1pOTqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYS+7ugVTVSARk/9y3QfuA01DaE8/aZaWrXYf8pMY9g=;
 b=oJTjFDGtjyvxuMyIxaf2kpx8j5YbId9+w92oQpQeUihmDbHg2ZRpWsjiqJfgnuxsltntL/gnkjvQQwgTEm71fSWOv8hqH1U/bxs0Fn8iIF7I6VTX+hZ+1/Uie4M1kB2sgYZUOGdBvPnk0EQ+0xB8Gy1Su+xzX7sjWW0BsGhTo4E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 04:38:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 04:38:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix a typo in kfd_device_info for beige goby
Date: Thu, 13 May 2021 00:38:08 -0400
Message-Id: <20210513043808.569309-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0444.namprd13.prod.outlook.com (2603:10b6:208:2c3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Thu, 13 May 2021 04:38:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa4001eb-f184-423e-7ccb-08d915c8f498
X-MS-TrafficTypeDiagnostic: MN2PR12MB4831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4831CCD6777C820610A75D1AF7519@MN2PR12MB4831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HACnM4mx2BIb1dedcXKIFxBXgIWc0VgZZ0QDSm5feVlkFi9tG5f0YgdBIWenDSArkVOzUw4feD8r1LVrOeoTqZgjQzdlp6qcLOZR6tAnBud4HWykq2cZR4/VnDcxTbbw7QFwDg2t4GAQZCR/wOF9YwVNNF8PPf/93X0MxS7q2EVELDrg8JFmC7iKVGdCP/W+TFRYjGjW2G8fR/ks7TSDl9ilWsfx0hedls348sdXZq/ge0TWwr5YeuWzA3SEQjSz67JY2VxGFFv4IaGNItZIb5lfB+ffx+6XMe1WPzGsWHDkrgknbBYLtMSLcjTTHdEDX5P8su9y8njp65B9aqy/GI93Htf3+m0h+etyKbbD31ybaSUJvPCI0xH5U9dLv6cC2OeMllnkZNaAaxbjBU+VhVY1YbO7NSqvnjNXtseeYP7KOfnuZb1Lsnygg0CYrUQUfJnNdc2brrySnOJ1K/XHEvryJ45Juwp22RXocwFVjYA7VdcPn5e8AVweQ6HSmbVNekW3WAs9gB3Qo9SFWvjay7fJqVJKxBoKXVWV7HissPdvM9bO/e08pQLoR5Z9oTNCwQz3mNdpVL77GO7B9OkDm27CPCeXKG2sAsDcGJYIsG8IwMvfayvzVPBHHL/q7/uGCZAWDLcfrMLopuvOPvAE5UqjQMScWcR9z+zaHMJE7Es=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(6916009)(52116002)(7696005)(4326008)(186003)(16526019)(36756003)(38100700002)(38350700002)(2906002)(6486002)(2616005)(956004)(83380400001)(316002)(5660300002)(66476007)(66556008)(4744005)(86362001)(66946007)(1076003)(478600001)(8936002)(26005)(6666004)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L2yQcA32+5m9TihZZHSca/nvmhk5Ienai8hz7fY5R65u1RENlsmzxFMCRTk2?=
 =?us-ascii?Q?mhnuG4ntb//Zzgl0KFvdKQcPdIYIKY5HzmIDHie6cb7o9+hFsSSULkTCrj9L?=
 =?us-ascii?Q?XL73B174dpk+ZMMG8DN22XngbCZRtX3XmL7H1QOCIxXtstI87ryhkkgaCCqj?=
 =?us-ascii?Q?5WLfTufdqnbv2cHVqN3YETETokVMEfFBJMkjcmYexn0X88Dn/Ua7pogmc7CZ?=
 =?us-ascii?Q?B54u0DXnUdEqn/sgo/ufEnDHTsuNLEyMI7pJNdT3INDg7mNfNwgz9ZqjYsGF?=
 =?us-ascii?Q?3kdSlaCQRHUX6/vx6JmvXgckIbimG8EUumeeL19wjySAHHVPh6MuI2vMK2Dd?=
 =?us-ascii?Q?aG0hl++WEQejp4k4F0xeuPZsYMOVbBMdjLQFfAdwYgU8z9XvR/bht6Rby1b+?=
 =?us-ascii?Q?7wXDfslBjsloHJJAPn2I19lq45KGdYW6XV7QCebN/TQTGgNpgeRljTSrnDlq?=
 =?us-ascii?Q?uSJqn/LixnageX+sWXW4RrnoojFqf+Kl9fkUX4rrsxW/QrSptcGmEkzurTYz?=
 =?us-ascii?Q?SQJudKLaYRASKGNz+D9cdaOyZm5f2Vuw3r7jw/Wy7ezr+egfvixevsIs/k+m?=
 =?us-ascii?Q?jHZGs3uqeueheEFo/3ZlShLr3CqjmywLZ8ihZR5ztKNslZmoWcCSii3xnDTU?=
 =?us-ascii?Q?ZALP5CKlgcu2LuxCQpvv1Y+MBgRJk16PAyjZe0Y1J3sXq+FkCHfcHqYJ18ca?=
 =?us-ascii?Q?IibeIk15VMfFj55XzG7koPiC221Tm6c6TlFOZR4JLkxOUn7sRcpR7Ftb14+I?=
 =?us-ascii?Q?1wWedI6yhKxebxp4qT/ksgPb4xaQ5BWmra4L5RHZZBthLMp3Pcp9zZA6Q9Rd?=
 =?us-ascii?Q?/7W5iquxsVxU/giZMG5GP+Ge0QcH3pgwd6/8dHAY1tU29q7dRe8SRLI/zlh4?=
 =?us-ascii?Q?YHcCaH+9Oj1rBZrW5kOnGp1Ak4PEAivV66rOY5n3A0Q9Rp+R4jgC0dtbL7eX?=
 =?us-ascii?Q?t7D+8m1vm1EHCdjo6R3mNG+obLQ+5ks7H4s/Q22c3zK2Nbth2VKM6Uv5ndiD?=
 =?us-ascii?Q?Opxpu7J90ESqWxAaEVp1jisDPwZWMoTo+1QqhlbVLlCdfcT9wcClKD+xKAwk?=
 =?us-ascii?Q?JJLvYWQkQUQO9l9EUnOezlFCBZqiKQrnkVBMBCicjyyQVz3tKVGcsJ+wvmu+?=
 =?us-ascii?Q?gUJVMWof4cy9mkI2AFbjPL2e2OgichdasKCuorKakwQ7ev0q+exBfB0z3+hj?=
 =?us-ascii?Q?Ac+9j/ZMOlwRuz9pu0VWKsRtu4OOpSla3dtmPpgqXvsdt/OuTluB4ToH+EKn?=
 =?us-ascii?Q?wxM9iX8jjEOk+DKk6Lwd7Jlha0wYHosxx8bu6ljJeIoojwoDVfEq26W56Yew?=
 =?us-ascii?Q?e3zqtH/oY5mjCTH323i+gvYN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4001eb-f184-423e-7ccb-08d915c8f498
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 04:38:29.3919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N95z7i+vD8geespCUR05HHhnMGxKJODyspfNd1aL9FM3hqJZK3Op1CAwiaoCtwTqw8lwSJPzq11/Nf9yNIl26A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
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

Fix needs_pci_atomics setting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index d925e5ffa41b..80015e866498 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -571,7 +571,7 @@ static const struct kfd_device_info beige_goby_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
