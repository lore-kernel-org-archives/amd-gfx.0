Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83A1C55179
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615012225C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sXnJoQTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615012225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B776EB45;
	Tue, 27 Oct 2020 09:42:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98AA6EB45
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/GLqQ76roM9bdF6ENZdNM+4s73lH4odKKLx8S/j18/YJ4g5Wo6GrA6JMn8KrFyireSSeu0Z52I2CiROm9jsG30cf0Who9A0ILDpC6c90djLr0UidjOY3U2VKFK64h9Ypyz49dWQpSnOo032xXqPhxw20IX2b8fR6LsHWNz5fLEYpv+3bRTxjfIeKpyAxmCwHrsq5XVR+c+FjPPZdHYlEOO15gF+KREyP8DPzjJy6pUnL0OAGjvjevVziuhPb3k2AGnwEjSyWo/CK8EbX8AqELC5GQ/YXd9OL6Zh9NXUI1L4XKBOraDcOqwgH2ZNsb8wGjhgXVbHeYEvpy8IuIXC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp53HZbsfZvmufoNNrEJ6dTnAMxyGwoFKy+U/dG1OJs=;
 b=avdOCQE54AQCv407CnNcgcrNt1eQlyIbvUViLciXlI9D1MlUaAdwO7NvBUrWK5md3ZDydtBPZh0AMkTgb1U46w+ZDadLN6JiuQjlQ652E7QJQez8JJlgbRk0mwbEliXcghW/89eO7w32ZyEie0eEmGdLpYsID8khgDiJWc+YaIl43ZYv4tnamoXv8A76MZGnAtvOT7fI9scppm6etzyPO8aNvq4rqCs13Z9Vy+hPxrEb682/3vTl06o+G24DMmzB7mrlbGmNeQelJu5nJj/Qg6zF0Rrel0Sge2eQ7hWGNFqo/n3SWncDMSDSDVDmPtdeZEX6yPoeLk4k8EdVopboTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp53HZbsfZvmufoNNrEJ6dTnAMxyGwoFKy+U/dG1OJs=;
 b=sXnJoQTBkFIsE0of2+JYaFip1D2CtA0arOCdNwW47M4dT/MctU1TAKVlzTBiGW6QB4w8u64e9eU9vBBcJpWGrBIe9v1NtDSmoEmIbyQkpDRFQ2BB2rWjq7jRHmGXLfPbG4FtIQR04o58+6YMfVLloBW9S9okONUcxtF21ST67ho=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:19 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:19 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 07/10] drm/amd/pm: remove some redundant smu message mapping
 for vangogh
Date: Tue, 27 Oct 2020 17:41:30 +0800
Message-Id: <20201027094133.21881-7-Xiaojian.Du@amd.com>
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
 Transport; Tue, 27 Oct 2020 09:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf15b1de-4403-4146-526d-08d87a5c98da
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18452AEFCC1537F715DFF0F0F1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8M3Gh4oJkjZHXG959nq/3Gy2WXqcpPvbvDm7qF9y1RqX6kYreigVZR9S6bOOtjlGHQ2SlsqB0qsK2MIl/Vx454UxAkrZrYeAkqU5tckxmcS1kEa+cDLZQZGRnS0wYwjoP/7H9S+dJ7hApMDwsXQMIquTkhKs9eE9+WbaeuVKC9cWhEvkFOE3RWCnksfpL0obHCYxJu/P3tH3WqAJ3eilvr2to/2X4hdF2VtmgpniACIGwqZc2ZtsojNPzfrXE5pWnPaS4yg6dkHh4p687bjunEXsoiAQt6bx87zBwJDnZXLCmJ3Xm7DnZ+n5j8Rw5LDB+HZt3Froulcfuhpox7G8TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(15650500001)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(4744005)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ma8VXVcMWaiIkdow1wTecIu2/UPCBLXdkdGILkZJCYH/chRZBfKTT3H9hb08aZxKX27RYJ1E+cko2cZuVpR4LFjQTiYGDx24cttZldTR+XOnZ8mE4JSnVBqytT6TKBQt7eWg5Uet97/LFXWtszYVpHsPYOgKxAZRn76bKMNhBYCUdVFA87Rmj791DogxdDkaVCRKgrjelvW890boueP+Bd7Se34Gb78KgIdHAz9LqwCmcbb2CvJUofdTu4ZmhM4HA4J6u7Qw3F5qK7IYVSd382XT/OTDVqDJSZ5VhLSUhABY2lOgZzD5vPepbVP72HKrpD621KAGi6eXHomL3j9L0f/OsCU6wuWhW1vXdy6NWJNnSIhQxRqRPvVEUlABXrKXY3Zeq9pef0NT8UQ7kefUFO5t/uZi+gZZc0xkSaqfPXhc8RGram/0MW6K9J4aUEcdEgeDtY9t/SIWaay0X6s0CYhOZgKcuW36OlqHXBV/MZcvQlUt4DsLfFwZI+cRto0h9r4dhXOeIh2A33lq2pMZ33bteq0dQPdd6HITbYU3DwD6ofk2UusAA5W/dblquuA+G2fL8jCL/nE71HwGFJJ1+hltXQ7HPE6sKj15l7G1VWlu9W46/aWFsyBMvv7g1+2kcfFMlwh3RzgKTDCVvmWFxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf15b1de-4403-4146-526d-08d87a5c98da
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:19.6658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fb+NTk6fXKvspK2E/wf4EcpVeJCwlxF9st6GmXZSL62gGerOYdbJJrZg6NkO6cIuCP03MRM2iDiqnRoZzGVIzA==
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

This patch is to remove some redundant smu message mapping for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 1e8558da84af..4a6d1381df16 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -302,13 +302,9 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(CCLK_DPM),                     	\
        __SMU_DUMMY_MAP(FAN_CONTROLLER),                 \
        __SMU_DUMMY_MAP(VCN_DPM),                     	\
-       __SMU_DUMMY_MAP(FCLK_DPM),                     	\
-       __SMU_DUMMY_MAP(SOCCLK_DPM),                     \
-       __SMU_DUMMY_MAP(MP0CLK_DPM),                     \
        __SMU_DUMMY_MAP(LCLK_DPM),                     	\
        __SMU_DUMMY_MAP(SHUBCLK_DPM),                    \
        __SMU_DUMMY_MAP(DCFCLK_DPM),                     \
-       __SMU_DUMMY_MAP(GFX_DPM),                     	\
        __SMU_DUMMY_MAP(DS_DCFCLK),                     	\
        __SMU_DUMMY_MAP(S0I2),                     	\
        __SMU_DUMMY_MAP(SMU_LOW_POWER),                  \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
