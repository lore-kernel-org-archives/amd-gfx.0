Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC21C4332E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5E32226A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5E32226A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E196E7D9;
	Fri,  8 Jan 2021 08:55:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F196E7D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+wSUGMLOzY/VHYpQFUTIta52dOx7UVHLgh7tLjMuNJ+er+Ec5nVYzZhw3T7YQ2nJVdGtmdcJ1nHpI7eTc5GgYRkCDXyjQ2zYrVEyMBWAKLOPJdxncdG+lrNfThMXGGT7weINvT4f7GRIa8pEZaQH4ikWMCjxZa4Ot3x8QagfvMMYxYiqPRhxRP1fMzRhVNxryP0yq1p4e+5DxuIsoAe0kcElwLA+CUJnEX+5vinSyIHhbhDcf/eAdvkfYq7X8tDoLdNaT7fr8nesXlU35oXpJeweMh3jQOnIhcuVNVKSaRFR5/xuzwP4RjssDTbV9z0T0aXfX6t2OiiiCvFxVHywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlrRYeM1VEDKEYB5vCrME61L3MwviEvi7+eEXbV2IM0=;
 b=mi0d82XhPZCr6gjhHqFFtRP/hjGyRV+IvSo7gnPMwJEys9MzkWAWlBf14k5TGjsj87PDygawhl8hKC+8j3+LFsZYItmrzY9RFPva1/j4EeOEonlLDXGwlXrtdNT4Spb1kpjeCk/MPVlEJOfRonsf20wIny5VLE1gaZ9r+P/ZDyoRXMfBMdhq6f1wfKaGOSRG+mw8XNtO1miY71iXYmj/7mgqmjCYpDEyqk0k0wFw1HzzSWVgABs/7Lo0C70fQawbmHQxI9B2D0tG1hWtIF5S4j61Sb9hU95S0DDiNbgZeWfQh9TF/ZQqJUuXBZ82ny00FwkoxjQnISfjQ9Xvv/NHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlrRYeM1VEDKEYB5vCrME61L3MwviEvi7+eEXbV2IM0=;
 b=ytPf5vvsbS1eZERwa9XTRU+giD4xcMji4b9A9JtwBjWoNGmn05XvxLwLaDUI2y665QULpIOTMWG3ahOveGyDboXHicHCRAFHMxdkEeoYMcKgs0Jlq/prYUMI+THGDqB8+11X/GeeOvNdA3hh+kmX5/rV2cVOlFOWGXo088a6Xfo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 08:55:29 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 08:55:29 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/7] implement the processor fine grain feature for vangogh
Date: Fri,  8 Jan 2021 16:55:00 +0800
Message-Id: <20210108085507.1164588-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 08:55:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4532adbe-85c0-497c-ec9c-08d8b3b32649
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24582D217944A160C4695D66ECAE0@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6wq8wgUXt12yfmcJuFDFxodlzKP4sf2Emcr8w/gxclW5GFRPwlTFlynzlrGW16j/X2Lrmu9PJMivWxC23QNwDyd2CVFPhtwf57ofLvYVOriXW79Wz3W1A1bXWKjxnZ1ramXuTjvY8DqewdVocOq/X0zp7U4kcysKbQ8o0kNBA3PeBG1GrKYFEIE8WxQJS4Rj+iPwLFXfw0rF4kIbzYLqALR+gQojka+FBy3avvTYQS/M62hYl96EOs8RrK+e0Hre0ejsYXM3FPGWnQlojtp6ErmOyfeY2/kAqlmC1pLRR41N73IyHDA/Yuql1V8PZhh7fAELV0K0cblt6PHKG/Vkk8uN/snKK644cj5deg0MB8AZWK+g9G2OUNTh5ON+A1Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2616005)(956004)(83380400001)(36756003)(26005)(1076003)(7696005)(86362001)(4326008)(66946007)(6916009)(186003)(2906002)(8676002)(8936002)(52116002)(6666004)(6486002)(478600001)(316002)(66476007)(54906003)(66556008)(5660300002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GK/iVSmGtgijV43DIgEzHKm8YBGIlOxskviFDj6rSC9nwKzwmjjVUI2x5Wac?=
 =?us-ascii?Q?QQ46d9Sv7PiDryLSZ+vSL4UwaKUfUQ6DS9+1nC6rA/X56/QG6kVROtxPXONk?=
 =?us-ascii?Q?CC2rJ4mYYkAXOnwmup1lVX8CWzp7iZZ0m9MtqX3tB/C/e17qLq0cJWH8Xk0X?=
 =?us-ascii?Q?82Di541/gvDdirMEMFXavpn+YbqDpmTPY1w+L78hPuJta5tuJg6fnMF8GECN?=
 =?us-ascii?Q?1w7K5oF8xI1G0u2gij5qwLb45cAzEz3kcR0dNUYmeqoUvtVyntULu+Oqy9px?=
 =?us-ascii?Q?cBWpsjN7hhYO9UKWoCFOuTEktshVbJv7X5ppEAuJ9lknUdjUoYZh2XYabU3k?=
 =?us-ascii?Q?aS8n7K6YkRwXGzjyPTYhP68mkPbc7mS0CMAacGdQJs24Efl2oPNaHe7Jmk+W?=
 =?us-ascii?Q?tpWi2tjAwR9zJm7zIHVr3gGJcJwh0jugp1SUVnHP0UTf5w+grQoQNZ4QqE4Z?=
 =?us-ascii?Q?73gGoLU2V8t58xBtm07F/pMwWwwG1zUqxAqPhxXMd2138LzFzQXdbZWCQEIH?=
 =?us-ascii?Q?hFzPSJC5VxgXccu2ujzBlk1sxKnga89Fd7e7xUmC6XaE6+9GnoUcY1qH9t7l?=
 =?us-ascii?Q?xaKi5luoj6MWyhUC6HiSJai1V/aelLVmJFgSdbfG3O4P1m+vZNWN+1i9MOMx?=
 =?us-ascii?Q?34Sqhqxj7gJwGMAZXeSX+/obktcnFhAjLaUE3HGEUoUqP/Y7OR0/dTNZxKiQ?=
 =?us-ascii?Q?PNGp7YLTyPopYVYIebWobT+5hLs1BmiCFJU11SpPCyV7Z2kFwZ2yVYK5vpFz?=
 =?us-ascii?Q?LwpJEtg5BPPGlXLgPSqBp5g2fh5PaHcn5BF03x42kve2QUX46neRma5/AKe9?=
 =?us-ascii?Q?FQcQGqMkP42FFZysnb7EpUMR8ouFuwHWrUuPlsSZTbFj5tRZeW3SJ/xYX7np?=
 =?us-ascii?Q?HyWfePFEIs/wZKn2E1vDE/8QclsP4zZWLnjFsNmDJxOjgCXP1McENL3gqzOY?=
 =?us-ascii?Q?/qZ2RoKjQGWhHig6Ry69hnotv9XiXf6SpPCZaMJ16tObucyOfhb0VNegKd8g?=
 =?us-ascii?Q?RJok?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 08:55:29.4192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4532adbe-85c0-497c-ec9c-08d8b3b32649
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvpTeNA7SZke2fS+SBMLuohZdPWiXCn30OmL67kbk2zhKuy3oWaOJr0ssR1Rohi/SHPXD8s0zCn6BQT3joVmCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These series are to implement the processor fine grain feature which is similar
with the gfx fine grain on vangogh. Please take a look.

Thanks,
Ray

Huang Rui (7):
  drm/amd/pm: remove vcn/jpeg powergating feature checking for vangogh
  drm/amd/pm: enhance the real response for smu message
  drm/amd/pm: clean up get_allowed_feature_mask function
  drm/amd/pm: initial feature_enabled/feature_support bitmap for vangogh
  drm/amd/pm: don't mark all apu as true on feature mask
  drm/amd/pm: implement the processor clocks which read by metric
  drm/amd/pm: implement processor fine grain feature for vangogh

 .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  28 +++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |   8 +
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |   1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  14 ++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 190 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 +-
 7 files changed, 181 insertions(+), 70 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
