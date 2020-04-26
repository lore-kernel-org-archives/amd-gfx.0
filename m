Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DCCC55199
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 09:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90FB2071C
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 09:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uei0lBuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90FB2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6A489E57;
	Sun, 26 Apr 2020 09:17:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E80C89E57
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 09:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b25KnxoA+z0Egq3c16Wnr4lf+h/6CpVV+ozKxBhCUcMHrwmxnc+v5PLK+vQLPpH/hJbw5wfFV68bfk61ZqKEURzm+0GGL/FY/X0mB9GRTStcv6N6hyUFpGfAPXJiSp0kvcx8Qz0oiyFeK81orEh1oILRC/nO7oSVRHSr5bcpOHiC3fIM5tkMq0t7mhTL0g57eY6UYKyU9/qPjkdca7HvYnM6+jv3UEys2RDgjkYPcGfVISAOWI6QJM7JPtf6guVS87W9YXwNkjqooOGEizk71r0FmYf6A/oQzgR8GlSGmi/kxDghr4TzLjwrm6oc1gwxMcc29UNDn+Eh616UY9vj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkcVHbOQc0oOuGV82SVE4yMtFbYiFdoFYJhlPrcTx/8=;
 b=HYhn7QCu990rObl645s455jwvPYWOHf1Wp4feoKqzu+zEtTuy4YXHD7Gy7/8lap4zV27njwZyBts6YaY6JcBDF91etTWGdatcup/Kw/JqMh83lisVUi8yCEv2NiBaNF1ZxwYIeSbnuPd7/8lfSU7CB48U1lH8p1Agjnkk5WQrapH+WX+4eOzkOWKRvXYoE6AkSbtnmYWQhhaZp3qbiW7tIJNSSgjtakFy+s2KRyPNHReHw8qXRyMSV6ZXgVkSsJ5TXXrHdWnPSUMprj2CcOms4/TQaiQq8QqVxF/KYfrHKXxN7mgpjGdYn44ynShcXyFv/Gj++TMl9fbxruKdHjQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkcVHbOQc0oOuGV82SVE4yMtFbYiFdoFYJhlPrcTx/8=;
 b=uei0lBuKCbbdeX5KPeUDQ7QSHO59GFXLWRECo3lvVEj/r7an+4YKgdF9XMkLyY7XVUfG6awnR72EkY5gDTYz6tsUWbJftwjlvi2yX9mg0agLFCfz3dXIH9gdcYjiR3QeTd3SEdFJx83LBh2yFooGMFR9BGcR8cn2U1WTnonBDBs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (10.168.168.136) by
 CY4PR12MB1941.namprd12.prod.outlook.com (10.175.59.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Sun, 26 Apr 2020 09:17:07 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 09:17:07 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, alexander.deucher@amd.com
Subject: [PATCH 0/2] add correctable error query support on arcturus
Date: Sun, 26 Apr 2020 17:16:42 +0800
Message-Id: <20200426091644.26776-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Sun, 26 Apr 2020 09:17:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72d72fde-b4fc-4bdd-a2ef-08d7e9c29765
X-MS-TrafficTypeDiagnostic: CY4PR12MB1941:|CY4PR12MB1941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB194138B9BA16D519E1EACE8DF1AE0@CY4PR12MB1941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(8676002)(66946007)(6486002)(26005)(81156014)(86362001)(8936002)(7696005)(52116002)(6666004)(36756003)(316002)(1076003)(478600001)(2616005)(44832011)(186003)(4326008)(66476007)(66556008)(2906002)(4744005)(6636002)(956004)(16526019)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2EhNfkdF71wBXwWey/rECU78RRIlWhx6yeUF9MicrAIbq/hvINTpp6XnEs5lJxrDcsxUbT3LQ9srjaUAwIQeGdV+PRKgVCgAFsafL3OIIo8tznv3ccWOTUjGPGYmv21g0l/HInTwDodesOMEHgM0YDE7zbe67hjUPOxRjJWFTFCDBr485icf5DMHXbIi71c8t1VRiif4oVNWBQKGBas+ZX4AyoCrJ1pH21BkvOQjLx1aGArp85TUysEz1XLAePZIo7l5B9BZfVPwJnhdAKzDA2ukQtzvVg+qLgQq5isvy3nEcMw+6MeUcht0SMaidMcx3uJw7fuk4iWE0kAxmGcuzB9xxOoGzSgOt//CMRvklHgqZI9BnEYwd+yeFbuOd7QHQOI+Y3n7ymsjBZP9UmKcW/uAl3UKtDTXTHKRL4n+z8kj880rluZMxoWoe1u6Rjc
X-MS-Exchange-AntiSpam-MessageData: 5Vkuw0MsIfCGkIqjomuYaCSa2lRHLAHyCCc4btzvaVtERBMnUFF8XJsXYGSLWcN3AuiWZmE81ekA1gHuFMAHvHQYTEvr6prWALJ3FR9yr1sSQjfLsBg6UoLiCFoBwzsA1YlSh6bD4/D3scSWq+rbKHVcPAFQNl0HeZPk7HAUX2tcohqFn35pKjbGKj0QPA6E2N1ZEaeH0LjbUxJB2mP4b7RBdgEPScFwpYbvWQ0yf1YbCpwRk+sHM5ezYflUvMOWYocjnL2hDYme/597VxFcp03Ei7yV3H8ETzbRyynTGsenCXStyc4Rs/aLB/lMRev0JEb4hkkNs2LSI1UFkgca1hYzr59H/TrO3Y8zj+gtEiTwOfPHfeeMhlh4KMLodXPGKXvH+2c2bWFH01Utb0PMhytQdWMo/sEpBNOZdy/yDI42fyafDXQhTql5D3DVCGNpZbZapydz66o+9PLB14UL6IAGj59I86rD9IWSFaZxm1Tnr1i8KPF3RQD08B1CwMjynbLnqbW2Kqu9NxstGMIV5nqYpdkZEeSnh3G3ll7rkCKQ92EHw999L6dmC/oOxtHebFODWXGOGMrAM+pMcG0TIO+7lcC4tTaoBdn55CrNk4LesTc5+1MwEw0y9N6eePO806a7L5IjyLYx8tj04xErsac2Arn+KkGcEysPoOl+19gASTsXXK7iHQq0LFEfOGhu+fc6Fb4svpHIvNagNDE8UMUIo0sz9f1WHrYral9t3gm4DRXdxgcSIJIIcD6DLNAsqktf5oq1hosUqfaBFnl/XMpr4EEQijlMnJ7O8F5SYbQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d72fde-b4fc-4bdd-a2ef-08d7e9c29765
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 09:17:07.3600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9OJV7k5oIG6yAWF3IOTm0v+zT2GegJ3QlcXi1sq4XX2ZasEJotTn6nbq0TgQ7kX9utiAii9xZ7DWnKfgzdITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1941
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
Cc: Candice.Li@amd.com, Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Below two patches are submmited to promise UMC correctable error query
working fine on arcturus.
Patch 1 is to switch RSMU UMC index access to SMN interface to make it
stable, and to be consistent with other register access in this file.
Patch 2 is to decouple EccErrCnt error count query and clear operation,
due to unknown hardware cause.

Both are verified on arcturus and Vega20.

Guchun Chen (2):
  drm/amdgpu: switch to SMN interface to operate RSMU index mode
  drm/amdgpu: decouple EccErrCnt query and clear operation.

 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 112 +++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 9 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
