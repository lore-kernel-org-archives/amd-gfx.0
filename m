Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B2C55179
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9402225C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="htkn0WE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9402225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D2716E1A8;
	Tue, 27 Oct 2020 09:42:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AB46E1A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggT2V6DzKq+LFBFFBcIg7ElGNLCehag+Wk87BN5UbGZm0Yo7B9CS+rSQ8pvL2SI3MZpW67rtKd8ReP73IZnuUrYe6MwuImUlM6B7lQQgur00px41nrOducF5Az4hYWNSJ9pVfkfwYj+UfXgYDnWVHm3bipG30hrZsDdZ4iKlwyDPnUeMCSOep8tD4/hkjiFV3rIIyOSqfcOgXAB6IQJ42PwQfgj7XWjwRessAzosU6IbK759Mu21BJUN6YhotvUCX1YtV7Ty5S0y11bP41829LALh3jZJJI1KJxF9Q6QvG9PsV6cIynfS44/BEu5aLJFloVtO7mc3bxW7rruZbIXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPFCHbsNuqOVO86HJz3X096vPwv5eTOpJrG3ZEDRgGI=;
 b=KMBSLGKrjm/STsn0GKeKICFzL7YN5ByQ/fH9nm2XPuQimGG7T3nWUQMrjGQqHQfQqAUSXSTuoIL4Jf3skV0ooSCE77+AMwYmIlffRlAoL8G9IZPyaCjw6j3BpBWDYK8j3KB9MSAtVzLZf0emCGxOMQQiycB5SUz0JxMzyjm48AAZcYpwSwXLAq/JVBYlmpawd5lF3Hl/AR0AEW4y4RJPdC68JPc9Kwyx0ya6FdTtbP9C6YZLNBj7zZIUNDQT03ncBdkwMD2htqoceWEv2FOb+iG4HA7r4w00mZyWzhhFDhRh/p6MYSYvK/22ktpG8VXm7Mg98jmXJXKNopRtzvP3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPFCHbsNuqOVO86HJz3X096vPwv5eTOpJrG3ZEDRgGI=;
 b=htkn0WE7/lm3stvd1aJDJbD4UPP3BeeiVrEpogqtNvOb72Sm4YMCkK3J55AJ7PN4ASdEskiU1a4CPQx02+fYR7TB2g6jkBdnsYXvs1mPY0FwxGbk7gtFc4VBQr6BBqbTz9ovZYPeS1QAOBkkkQXnQ0ux3vHFl1O6H2GETjjLx5I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:00 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:00 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 02/10] drm/amd/pm: update the smu v11.5 firmware header for
 vangogh
Date: Tue, 27 Oct 2020 17:41:25 +0800
Message-Id: <20201027094133.21881-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027094133.21881-1-Xiaojian.Du@amd.com>
References: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:41:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cb4237c-781c-454d-d4b3-08d87a5c8d77
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18454E6E8912F9458340DEB8F1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXTcQnElSMbVz1KBSpdiRy2hdQi/iuvl4khL1AqMeFN/P/KyCuV4GXKpL8YDM6nWa3TKxB4WuY+XBzj7M3u36OAt7dTjS/r9Tf/X13zeIxUxo5rvb6sF3AMHpKEvON6rL93uH5nvV+3CWWRvt8WD1970uaL9WYUOEdHVT2teMHnavFK3dMWDyHC6vkwWO745SQ6Zol1D9WiM8CRcH6JZp85yotKajnapyX+1pkwFykCZIyhtUZYfsF+QXTFHc8b0D6imqiMojnd5oXLCVxXlJmGLnMKCxC2xgIpDknGOjYO2UOuU7u5E+Xzvhf/hqRhB0XjDdxkPsGJtSXJnbSecig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(15650500001)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(4744005)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vncm1TiugEZWonLUPc5bvB3cmrLMCsINn0jyISYQfXf1Q23aLKQ8uaHZfoK6UnErvBzNfGj7BPsWomHp2vclUhGOO3WH3a6JIXBViYNOn2AGUnP2W/Q0BqQkyUQvIkoaOmIxLIXXI6FDxkfwZl4FT4bA1ifqvUT1AKiuNiabRQRwfGzyrgdYs4HBmFQuWMIjNP8XSH+QVyaWJNCZlCmAeCL8EqJU3Roz91wW48Zzn+5x7ZEKz8wRWoURZ3px+AzOUrkXPn6raCSJDBpAdMamOSIW2QOTts5NdZjNDhx9VknblYL8/E7bMz4Vh4Remae5WWVFcvQiTfpWJ3LJ1PM+trV5Ru/8flhZu2IWLWs/y+/CNm4hBYaL6scz0wsE6E+e49+azdziWHemQttWuyjUW32wMAXqQWBUtnxYmMiZv2Wa5hdYvig9OEUeNAqF25xGhQW7eXSRwXN82V57C8oK8/4Ma2VMutKZI9nNkK2KMwqf0ub7gL+ORqt8Dz+4vyogAlGiG2zr1VbDzuK6Iad8+i5YZXOkmqwk5hEzWTv4dFnII97xxTHLYg3cQvVvYfZc+mrC2x9y2UC0AkVgv/KylVu9iBSEuWHIHwgflqf/es5AtZUNApyL87OI4H6s+MZRfxLYs9gjI+TvE9XMO4WXHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb4237c-781c-454d-d4b3-08d87a5c8d77
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:00.7573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4n+Bul+dg8OqcLjQ0B9vWzEczycoEL04oZ0V6drhXZXAoh+OYeapXIFKE1q+Nf5HKd9crYr/FE+RyC6tEwD5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, xinmei.huang@amd.com,
 prike.liang@amd.com, changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update the smu v11.5 firmware header for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
index abf13abd3919..99a406984135 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
@@ -89,7 +89,7 @@
 #define FEATURE_SOC_VOLTAGE_MON_BIT   55
 #define FEATURE_ATHUB_PG_BIT          56
 #define FEATURE_ECO_DEEPCSTATE_BIT    57
-#define FEATURE_CC6                   58
+#define FEATURE_CC6_BIT               58
 #define NUM_FEATURES                  59
 
 typedef struct {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
