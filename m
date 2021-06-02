Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85390C47099
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E0A61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E0A61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C206EDE2;
	Wed,  2 Jun 2021 16:51:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C0266EDDE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b09i7g719M5kC1QeeIKgyEvuuTZoMsz8yFj3Nc0YpYoKg6NIwzGVu5rmyRRrzxphdg+F3+ggkJ/JAndu93hJZp3xbY1Oj1XbYOe09Dlh06O1vYlHx5HBILjj3U6iM3krF4Gsr4//9nHpmGO6KbN9rik8+leHBiiLXfYRrSmGQA49o1JMWD8FtKfkxkHL4Mw66LyTi/954cyNL+qP7LOOTiBZU8zx6jQ4gApZSdXl5gd6IGef+N+/EKm5ncIDQp4PsT+4riScS/ogP4mY+Ep2+RV780oswqmeD5oXLDniykaDYz8zeiW8IMeDB/RZ4Xs8CJj9k5zsvIlh2ku7/hMT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLfiA+mt16TAhc5J+ZL8efvoiCQzCBHY/TVSaZBoZFU=;
 b=Fh0QQ6BJrDGXS6B6+dn9WuslUQnveVlcgda0Idgl0Lwoe0IcbcsW/kQMuG1Dtxchjot+1xcD2ldvqIKQHtKylafcISFw+vOaTzsRrL0xPJOeOWrXaDNv41Vy97eXSGNNZdSScMYbOKifsv0dgsE+JXMXKFGSXWBYC5yYinm7msQc82OYjUn3CeDK1x6a7W7S72tsLgzOda7+k3n8ZshpBDjVRxjEKeyFoBzpzZ2gnqN1JmdSc1dIMXFbGcMty0SW7Qlo2fv5jMGfAHI34CLCg0fHwDXxduhMRCL94TvFzYdGlRmFVggNhY04eHKc2MXy5iNA1dn4aOYfVSCkDAIM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLfiA+mt16TAhc5J+ZL8efvoiCQzCBHY/TVSaZBoZFU=;
 b=AfeNyEqmKZnonKi8wbIK3iIdeBv+f7JaaVP+A7LUnWj0fnopoGklBByddlfFxrvCz07/dNvptobRZCh2LCHxvzE2wKXZa6EP7XiIrR+drYKx+LDXd6ULhDRtwM9DrXJSIFXwatDbpBswKX7bCUq0HXB1Lb+L876boiWvGmzD4Dg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:26 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 88/89] drm/amd/display: Add DC DCN3.1 support to Kconfig
Date: Wed,  2 Jun 2021 12:49:07 -0400
Message-Id: <20210602164908.2848791-88-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13b9e7fa-fec8-454d-38b1-08d925e686b5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453444EEF18DC2E6B21D441FF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuviC1fyqiWMW1Qt5SZtgfWmBQJRwCqcnvcMoc0ucOYfjplCECOn99Q4JJjsrIKJS8A0pIkBzhrRqbU7pgfZUsOfsuNiIhH8o0MVRsmnKlM/b+dE/jcyYUqfMyxr3xm2hkD/Z3oh4VUTktlTbAgTLM2of5VhEMvZMIpNlP3q0cSgUCyovHkpZ1o6fyBmRapClSfQmpF4LXGZWKweYf7SwicnBrzMt5kX4WoZWrSc9gF3LgdhwQL6+Enh0FNX2DGmHQKJ6CkfKxoPAFqgqwuLuhyqysOzwCisMv5SFyBR7+ZJWq6g7hlF8dsSJMS4pDuCosCfm5givicq1UXl0NEZNUYjuM0Gu6Vj83cF5lqFO7qCUyGcyDEpNWmAI77KZ03MFu/7IShYuad1Go3qbr9vJocW8NBIX7ifK6E/Lnq5lBG2JEOadjeHBIScNCx09mfIA4IInXjaduaWKs4bTKFRhyjPYjgzv3Vni1Y1iTl56HLO8kt5mxF0cN+HYXTfovChiLEKJ7QjwkNR18xHyDGuCclfeVVWkaaT2QZQoxBxeEzFz6zd2Ni8JSP80hVSSA9IvhmgrbNY43AcCYTAjPddmWWn2ho+8h8ZToa0R91rb4TVR21DlAbJMKCXlD1sKQpAnoOVJbKuUNgB3gYGRt4vZETWDJFBImfurm6EeoD60QvMqNE4T0/xJiXWvJdds0Ar
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(4744005)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GyTuhYZX6ejUEq4yBgTyINcLi6s/dnHUctzeg9WxPhTQPKSWDHUlkUaGAwmP?=
 =?us-ascii?Q?zcn+FuNmX5UznGxAn5/3TDSjdglAIRrEex8dh4x1xA7o/NAG7Mk0+dbydJ0T?=
 =?us-ascii?Q?g6Je0AP2XYIo9owOD6yOZeeMRPtSdNcVGIiMiXwgBCghm0BSBHSVkTadJPA6?=
 =?us-ascii?Q?Xgj7t78JBxxFcuN7nxosDbapDAO5fWKl59Q54xN9hOcIaidkcwEre63YW66W?=
 =?us-ascii?Q?K3StFM/ZN8v02hOmouiH1lNkJ1mmG9hYfMXPDstDTxePRnUWCUrajN+8qknj?=
 =?us-ascii?Q?2+DEk1BlTcfRqbdxxany4DZi9u/tg/+50vO20YoJw9gjIZhuz76VjZRLq3Fm?=
 =?us-ascii?Q?b8Qb95FWT6gS/olb+mgBfRykJ03QbYAe8wUBkNtVtXntfAYBY1h7ni0crA8J?=
 =?us-ascii?Q?lsC7PvZFtsbcmf2ZcsG2IJ7nk2vyodfz2B/zvXlAqTAN7ubCp2awrM86Oj12?=
 =?us-ascii?Q?VoBNVklGmE75ZC75mWnT3ES4x6T9XVSOcgAulN2R2iMeffIqma6Av3YdzVwr?=
 =?us-ascii?Q?4FTC00PIrkRXKg+w0qlIOY41PwTRbvMeEyBWt0Yn3W2rmtsXru3r0bXcs71Q?=
 =?us-ascii?Q?EAtgsNMNdLq2UkKv4H3gLkWyg14vCnHjOq9VhHViUwjgoijtSjugjCoATCg6?=
 =?us-ascii?Q?QZVVp4Y5XAOEveUdqJ8WuKo/XW8V0thdesSpg0TkPldsWzb9uvxREGW+4ctW?=
 =?us-ascii?Q?L/NzEuU27+d2FBESxgEjAhLPAfMnEsVsBAWGBh7vGh3GOcEGhtNjEn/+Dt1x?=
 =?us-ascii?Q?kBVIQgZGUVHnjHrQ8tgNHDn4Kf9bGa7PKHsF2SWdWYW4tJ5+o5Ijcb0L0a84?=
 =?us-ascii?Q?gp4Tdf+sfPuiSsem3fXSUabbA9XKi45AIrQzmdqtttAGVhuyB5qOxrS3oohO?=
 =?us-ascii?Q?gx0JZj/dUy0HwoI2tDBzuhHuq1UiIduquwAD3Guf/eJ7IgYtRAj6KOfh4t0x?=
 =?us-ascii?Q?7IoJN1lKyS0aNTXoKIqtDKQX3MUgD4vNIrEmqC9ehwmHWsFVj+0fIfWO2Jcy?=
 =?us-ascii?Q?2e1HfO3SVZKF881c+eNEL0dEiR4BEMAZCKKjIDKARjL9jZsoXlBcDrOO0JHm?=
 =?us-ascii?Q?WZC9cVZbZXz2f+8yqBGeCTuaHjccWXhrUqDfFMY0+hY6bBwhR+jNnCo0tmjr?=
 =?us-ascii?Q?uLUh66HI5Royy7tQcc+ynt5+o1FA2RrluZdwewim8UVFhSew3Clm2ZdTHltf?=
 =?us-ascii?Q?99RwfwrpK6nyIdVsfCPsCq2pExYaPBifNJmoZ0o4TNSF4CP/obj2pwWSNjtT?=
 =?us-ascii?Q?LZ7ohv+zXA5N2PvgLrz6SHVh8vatT4kAGNgzmvjfRQBEIkyhEWbCXGL4W/dc?=
 =?us-ascii?Q?eRxzdI7Jm0RhbDwK6nhzRYCh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b9e7fa-fec8-454d-38b1-08d925e686b5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:28.4366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wyp6E+kT6m6V/5hhCVk39ifbO2moWjSfflp2AcSx7NP+GrpMeJfQs2n3yvH13BBAZfjx9kR4HTuv/4dJlmTe+A==
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

To enable compiling and using DCN3.1 ASICs with physical output.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 7dffc04a557e..5b5f36c80efb 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -31,6 +31,13 @@ config DRM_AMD_DC_SI
 	  by default. This includes Tahiti, Pitcairn, Cape Verde, Oland.
 	  Hainan is not supported by AMD DC and it has no physical DCE6.
 
+config DRM_AMD_DC_DCN3_1
+        bool "DCN 3.1 family"
+        depends on DRM_AMD_DC_DCN
+        help
+            Choose this option if you want to have
+            DCN3.1 family support for display engine
+
 config DEBUG_KERNEL_DC
 	bool "Enable kgdb break in DC"
 	depends on DRM_AMD_DC
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
