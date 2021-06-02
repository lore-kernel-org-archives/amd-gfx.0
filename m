Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A7AC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB8C61C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB8C61C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A926EDA8;
	Wed,  2 Jun 2021 16:50:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926A66EDA8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+x5gS1hrCsPVrZGznnJN/GHxm0yMYjcTFLnQT+c/jtivIRxTd8zIa3p8CERjGAUInbqcrb7c2k7jy6COScFBu4eHCjfXwc+kpcTukuJ+MuKGYalfnSSh6k6w3dWpsOP1iSyg+GFjv50EbOMbAJjja4n8GDpi5hcK2fcBSX0MFQ3Cj/Juve6k6/7AOd0BAQ/3aarUlNW2lb0zd+QbR8PgWgFLdvvt8o+eQ3BVk0OjYKCnlqSrdxtNa/NOnfnM8Rdasjx6k4IMAO+Hf0n8ncQ99ZczQwjSuybvkdrU4H3Bf706c5qaB18EuEZmYuzGLEvxs5Qx3zq/aRzd31B3CEgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVqPWuH5GFoB7PxDpPWtHNAtke6cqVTS/I4yHDdCkns=;
 b=lMR8nM5aA3e0vkFqTV6ASqY3snXba4A75CTRjhEdT0uP2catJq4gAm9SF6P6LZPqdBDJSPswSMVwIAONl4lwXYCkXfFenU15pk8nAQXlEqwLVjnMjp2WBesyT8u4qF1YR7BgxzX/+qdt438W7pL2QWoSAxwP9GsAQzWoGrHZYqd27pCr5UD1p/K3qHQ7XZ7Qh+W/NM7jVbLLxsbYh7mVwOaqJD9RqNC2XxlnHxQ7JlmkMiWQZmmnGbXrDLvoAV5kyoI9p1mQ37oOzXtPe8VbVMTySFIa/txr15iFa0tWm+wYUTBrgPnegQTaiPW5lmYEPU3Ri2Z0ony2cCSBPr/jQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVqPWuH5GFoB7PxDpPWtHNAtke6cqVTS/I4yHDdCkns=;
 b=C0Die6OSKrSSdnxJBVRAMryhIdTPmktkcyNSCsLnMLZ4eafiHr4Yw5COche3/TACFkFrg1Y200+dcJ4AGP+NQi64DnQMXOeLF0C6ashEt2R/9kQ9HzNDwX9AlNa44Kr4O91UJgDaLbkqB1M26xAYS6unYv1xhqILTDVTvmoj0Jw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 42/89] drm/amdgpu/vcn: add vcn support for yellow carp
Date: Wed,  2 Jun 2021 12:48:21 -0400
Message-Id: <20210602164908.2848791-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36856ad5-3487-47ae-c7d4-08d925e67472
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534DC337BD1476898C3CD4DF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRO4mSCpkcm8sxjiw0eJ98a8/BPiS82PtU7pHJ9zJ46sf2hLBliX8LZI55Csnu6WgduNovSouduaNDTPBmmAqER0tXR9h4B2pucVoKsyyLwwXd/z5bYIQ2M3t9OTZv7hkE4ibiQyPQ2ikyD4Qs/j1T79J3s4CjdrFUvrlrG7aVnZxmJUyMq83sTtuaU9gseGofil6gNnovIo8ri6O68As1/v0RScY6ma0kASv2OYfX4aXROPO5AYxzPyLg5+h/45mjHYx1RRaEhTKYQyLKegCH4dkAhTzAwMP+f4LSSr/knArIeUbX/kpzFpYJfSf/GrZnRFdyAJk2L+Xb2wArWXFKdCmtk26zOTd/X/vvfAJNX8iGJFeAaxC7IU9Xd/g+TjmkAW5TsEuxTJwMHKzIUanDXUJByRC0EbJRiseRShCzJsjWs1phhWPMgtO71/ZedKhML8fsmqCZFk2DI3CgvNA0K9AXLjMopxpaZMrs22Q2IMX03IM2YL1AiClnNSn2WKBdeGCO4wLc+in8xD/4x0Z0dWesBM808qLbFFXihfGGpQi7ZUxuUs/DD0/6j7erm7q3PpCAgJ8kcnJaTYCgomVYXz5+rQjUg5XgoogXtqxmHo85nUeBkEr7zd96PWPqfGQGlKlNVd6TG8NbTgbK0sN3AUFBbF3exPXbcQR6rIku6MWM+N4g+xDv1x2GD6ff6c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RNUePnjvo3FZTFSvSs5flHXsDSIjdlN7EEATpqPvvlSzYBBeWJk+6YdSPVrN?=
 =?us-ascii?Q?7/YdMYvmiB/xmEgi6XbXFW2LNpdV/fu+sXVqzkJecK6dcDb/DMwY4nTQ6+hO?=
 =?us-ascii?Q?pcV0Rk2mxXwmTLr20NG9FmgIbfqoOiSiU2nDd9xS3CKpFVAzP+dl2cPZj0ZQ?=
 =?us-ascii?Q?VW0QM1RPLkiQZ5FuBUMfvsLrAXjw8F+CNLtvjQveURnAYWVJwt78zri4S3TI?=
 =?us-ascii?Q?y2POp5FZVV+AySTh8lP76Sq2fVipi3jZ59OR+toYrvBnY+DhHp0eIS8YBK86?=
 =?us-ascii?Q?L9cwb/OwrN6wVVz+AKAYvQ5piQvLJwr0zB/BNy6B2R3CLi4WtjCSlwjDbkMa?=
 =?us-ascii?Q?wIFLh14mWiuovFDXCbMCyvEDCyZKtcW3FkFC2pCITUfk7CjjEUZxSSrOe49Y?=
 =?us-ascii?Q?ObT04u2vYxWCD+X+xI4IXpYmW+2arbRE1fpTrTHDsc9UrIdeB8PTlyRcLb1Z?=
 =?us-ascii?Q?sotLTh91FqaRHDwqqeDeX9GPkxr9+pA/GZmdgLhBMHLsoCzz21IWSoycNofx?=
 =?us-ascii?Q?yb9dGkCIh7TR9VIL7q2lfjYbrPUS7cu9U+mnqMQowOHxf2ueL6vwjI0W0iOV?=
 =?us-ascii?Q?X6YoYhZWI8epVTc2IipOYDWoB9Qgd6EjqdcOfVCmN65IvvQNylZjK2rZQ/aS?=
 =?us-ascii?Q?HL9Xjal9uUoMa+02YGXgyrbwaDE8Yep+UWMIFN7Ih8bRpviTpCaHyT6RHm8m?=
 =?us-ascii?Q?A+tacXsa5inhR6pUvDqyVMyYO/tp/3lBqQxzlG2EP4NbN3N15MHU4tAkfUoe?=
 =?us-ascii?Q?T8pnlDatf8krny35ot0vWo7qSAfHIf/HaQJ/sI4t+73e3OkVGD6U5JQ2fRIZ?=
 =?us-ascii?Q?pO/7nvFF79qY58dGt/RekSMOYTdBrbIjEgzzXFveaWdXAisuIvJoTfLmtufE?=
 =?us-ascii?Q?jS4VtXU8EeI8ZAVbLmUSqrCLUjyOuclZDGKgBb2FjhxSO8e73Doj+VKGSEXh?=
 =?us-ascii?Q?6loLI1edTc1EceVm13XdVcvmtXdvGSaF8Af5mnEyt28h/8KlQaqfDCB013hd?=
 =?us-ascii?Q?1JpVM4bYBijjsJtgZykSnW5nxQojJj65cmHx8zqcXtFsnAlY+X7Cj+hE2np5?=
 =?us-ascii?Q?mVc89BHl4ftzLIqFDSXAaBYcjb596iqHbztG7RKGPvZGtr6yRBlFghdxsGdT?=
 =?us-ascii?Q?oePan+ddONWee+tUUuKEh8FxDmT0nR46jsVtDTTlMSasjOIlK+tTPtPXniR7?=
 =?us-ascii?Q?4i7n6ZRJCxIQKypCw+pnEHLjXZ5CCkR1xpqqzKwrwOY0SYFQ0M1yaPygAUav?=
 =?us-ascii?Q?1VSf4BqRI5G5OV6R+YNOiTo/mdWx5bu0uL3u8aYGfRSWs1Em+9U4QHXrZrTQ?=
 =?us-ascii?Q?FA4gm2YmTl+3sKsLSeiRNXcz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36856ad5-3487-47ae-c7d4-08d925e67472
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:57.7633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSJ7LEfd21RWpwBVcNa7zNPb+QW7DyRfcuDtB3aDSb74fx5nW762UNjXuNqo5Z5nXNHiFtOw0ZxzVzyMOnYx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add vcn firmware support for yellow carp

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d101cb9697a2..6a8800a7c89c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -49,6 +49,7 @@
 #define FIRMWARE_DIMGREY_CAVEFISH	"amdgpu/dimgrey_cavefish_vcn.bin"
 #define FIRMWARE_ALDEBARAN	"amdgpu/aldebaran_vcn.bin"
 #define FIRMWARE_BEIGE_GOBY	"amdgpu/beige_goby_vcn.bin"
+#define FIRMWARE_YELLOW_CARP	"amdgpu/yellow_carp_vcn.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -65,6 +66,7 @@ MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER);
 MODULE_FIRMWARE(FIRMWARE_VANGOGH);
 MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH);
 MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY);
+MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
@@ -159,6 +161,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case CHIP_YELLOW_CARP:
+		fw_name = FIRMWARE_YELLOW_CARP;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
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
