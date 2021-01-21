Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47105C433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 08:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08EF2399A
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 08:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08EF2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE5E6E516;
	Thu, 21 Jan 2021 08:41:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98486E516
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 08:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht9lZVW6Kzx+ivdU4rXp8z7/Zu+PPs2hFS7oDTnVPB3v7YSGQ0yWaqDkai1uSrgQfmgGGo2fS2qoIhXKIZIJWKUXpX1UvemXcycJYWMHBwdSD0ijZ63afSsJCJE/hrbXIV/BDdByoCs4wVXlOZydjnDAyUZbchBp04wh5UB9v6d/nZLiPEi/Iife6RoV9FrV0mGLlpibBvmbqn2UFzyUIRcgNOgNBX0u1WFQYRD11Sgpixq/DprAm/ELTuIdobB3/3skCYUNIECtnm9BZNoaPcdOWcNBtKBs41noB2KqHEEdLt3pFtNwj9QwQzCewT5XF8Ks7YpMzpNBQcv+Z5PrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soH43jFIPqAOFXXqbR/lCW9EnR0VHGP7TBv047EkY1Q=;
 b=k8Zpgz7dGvXBDrLaZxsaaP0pv8M0YV+JurMMFVsdp69vZCpz2JqgDT+uJNMaj+AlKgQMhb+TajUWAQRaiONK1npi+urbzPEJ3CIXNBxT4YHTwZYUL1BCDLULLW9CFACFLrPf9FOac04n1YfAOYd3EXk0xPcFqpLxJzg6e7t4sraveBPx69IvK4PVHoDJ98oZv9lQ2ZBlTv9Nr7aqTWrOkMXi22JOMWSbZFHr2SyajYAFWBNUKZ3WSRDpxbcqkm3NLoaQWp1eW39O3TainhHakunWzlmDysKkptfk3uzT0u36jy+xL6VVw1lV1RJbG0vXAgfZXHDI5rH6YeMR4xg/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soH43jFIPqAOFXXqbR/lCW9EnR0VHGP7TBv047EkY1Q=;
 b=3el3bwnNKZ/D3kvWv00oM7JaTVUykA9Nd2MQZehu39daMqVy8ZbzlS2WjgGaFeq13foAD6d4oJTylvwvbkp/SDE7qZDNbRT9wBnLRs7f4uKAOM8r59kbOvdFaI4dPgQZ+vRq16fMB4jdd6FRw39mOAC6/w8+TggSq3f8gjC/dpQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Thu, 21 Jan 2021 08:41:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 08:41:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct string parsing for extra separator
 characters case
Date: Thu, 21 Jan 2021 16:41:31 +0800
Message-Id: <20210121084131.866028-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:202::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.6 via Frontend Transport; Thu, 21 Jan 2021 08:41:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7d9404f-c523-4dd6-f079-08d8bde866c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB308283693D570D3FBE5892A2E4A10@DM6PR12MB3082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXjJn6XMu/JkymiFkPNvI0nieRn8eObet1MycWGafAA6+GMNKfdoeXuGY7xnyCJ16Ala5hWYvmssiMfL+3loqeJ3ACJcb20JuA1XeRFFWc8OXhGN9RYABkFO+UFksKA/s56AnctMOsg7cE/tsLwr0/tV9JNUC/CGYNx0yCQ5zmsZLc5CnEmJXBFu365bqPcmfcLTqYovWDRRgmKP7lxUYnEYiWXb8FDvltOI7nRYT2WcMtFDvupe0UH2mZvcIt1fVuvRQHiY0+YQROSXWEvcwp4z+ewul1hEH2wY80AgKSdamJ9Czpi6Q/AojB5MSJ4vboELHWcxgXYBB644/MbWcqQEt8HFrsLJZrzMP2L1Y6A3BPf+J5beBApVF2gB/Gqv18goCCP0O+etUDL/ml+FNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(26005)(4326008)(83380400001)(66946007)(2616005)(86362001)(478600001)(956004)(7696005)(16526019)(66556008)(6666004)(8676002)(1076003)(186003)(316002)(6916009)(8936002)(44832011)(4744005)(66476007)(52116002)(36756003)(2906002)(5660300002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6R4tI1KUlb7bfeuceokOK597kGTbgcyQYW7vxANIgpFI6OsQW5RZFp1FDHxj?=
 =?us-ascii?Q?yBZreFV3QPaGpr60oXBunRJDIYsje7D/7WiIRvAMt69Wjb8AbOuQ7YRUmhve?=
 =?us-ascii?Q?QD6GFKSa3WVNT0arSZnwyPQ/AoBT84Y1tQMqV7uH/nJjxw4cRsj0+j7ETyqT?=
 =?us-ascii?Q?JC11o8YzsqPH4ASjek8pnk181Gxmqa07EIdmmClSh+kRCTxXITjwf6HYQFN0?=
 =?us-ascii?Q?ERr1IR6Hgf/QifM9iTCG1tpnS43YYO8aydTqa7ieiYYzZnglBJitmr0FU4fJ?=
 =?us-ascii?Q?6Vy0VFyanoh/WRG3bOSDXM2WKxyrMWQFOzmBgSwi/kRvZg3rfl1uedB6v2Rb?=
 =?us-ascii?Q?WNNX2pPRqe6jDVdpXJair3KPQwmJiMLTcNsRmoEaX//s+uQC+qHH2a6NVEKc?=
 =?us-ascii?Q?RXJbV37sfRwaC3/lvxUWqWwylvi6Z8mA2vB98sUJfPnHB8oeh2D4t245n16m?=
 =?us-ascii?Q?v7QnFi2vl+bSsSL6Un9eWN9BZuoBnbLOzXktsY12v7ucP/VJuh5/iNKhdc1S?=
 =?us-ascii?Q?gcoM5UMgD1SlTpf4epLXLIHghgsHZpTp3cWybvcbE/s7ujG25PPN3PY/pgmK?=
 =?us-ascii?Q?PxZuwf1GPrBaFQUpS9OHt9iNlGGz5QU1EGbBEdqgkjOoCvu/ttprSGNFHPwO?=
 =?us-ascii?Q?O/zGIyXmyRqDMi4T1FAdqrvSlk29VBrsYmeq5b9Rx859qcELJTo+9u3w4V8e?=
 =?us-ascii?Q?WA0fo9dkS0BAiR8XXST27aVPNMTmZR1xl6pMbNhy5t8pr8WLSdxjvyOHEC7y?=
 =?us-ascii?Q?Jv1VmSS+qx/wgryyjm1MNZpsNvtJA2FhJh8ui/AxvRfuH0uR1cptRnBYDW4Q?=
 =?us-ascii?Q?Kr8iO+LluJsIhZ70AIKu3bikbnFvi3tZCzGCGDdAuu6DxT1Yyjb8AOL00Qqw?=
 =?us-ascii?Q?QuJqobDrQ4WnI/zEAfvCk/5kaQH48AjfKkM6VquoaGkwXYlV/2k7WMC1Ynto?=
 =?us-ascii?Q?oyTQqFm4UOcsic1mnPlNG94Q5V0xt3vbnv2ShSLmcYdQV5Ny0/l+VQeGT3qF?=
 =?us-ascii?Q?Ocxd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d9404f-c523-4dd6-f079-08d8bde866c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 08:41:53.0662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCMrQ7zEF3svLXWtTxeSRnQnP2TeZPD+PIjvTDQ1jPN2Ux81yAnbwUriAbyDxPVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Supplement of previous fix "2d873f24dfaf drm/amdgpu/pm: Account for extra
separator characters in sysfs interface".

Change-Id: Ie9e9a78ad8530ba4b46ea27e28559d5dcda5c033
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ba1539f6e0ce..ac150e63dd25 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1866,6 +1866,8 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 		memcpy(buf_cpy, buf, count-i);
 		tmp_str = buf_cpy;
 		while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
+			if (strlen(sub_str) == 0)
+				continue;
 			ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
 			if (ret)
 				return -EINVAL;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
