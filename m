Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABFBC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C524A64E0C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C524A64E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84CBC89E39;
	Mon, 15 Mar 2021 11:23:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4375189E39
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzvK+skTD7LDLIM2F56/diRVfQthoM5hIXgPNmiFr4ns+wqw1MUkagiHnWaWzXplht8bNuysV3KzLR4OUz72XrvxpuwA9hWdM878/5HBHKC9Xb4/AfSW/6higM0NujbuP9vUJGtSrvwYoaJ+LAwS/0g+tNXfk4+FiqD4ZBXRUt9g5Qy5bpLxFQKlC9ZiQhWFjhRl2u7WHDWailOLOINnqVcuys4p6cu552T1viQ5wslDulyMjZ0PHrV/KqkXgr5LMjmOUfa8HCLfG+sOyslK2k6d3uKKGuNjhfp58WGLvz+5+U1fWnVm87cArwpJ9HjRPZbFqlJVwix+/bcUJiSJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSPxUETDVA0JMhve3exDjCkvfTuOBxV9N7iQaTs9vjE=;
 b=S+b34SXDJrAadi+QhkcVQJAFj3sSTXuJq6Vs72U1JnD8SeClr2utheWs5MX+2Ot77IicaSgvTMbcaFWz2K3Jrepv7ZFPgrKIdlJAvtMyvbpgIVn9kE2jAI9QgFCbevmVVQfOBXtyd0WTUq5nzwsxxy4f8isv1piHAy0e+P4okkTNBCYTOlfYYyJcPH0Cqfjm1LX3urffpFuGF0mS/m2XM/JuCLt6QIom3uNc0XG6NqLkLlgv0Thi5xd/0E1PDtVZrw2WI6N2eR+Nb5Lnz2ThPacxIWyIPiEEwpFd/n6YR5X+N9+SSOA2nEpJmVBzA2QIk9Y+FsVYCZzoHXBYBdODxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSPxUETDVA0JMhve3exDjCkvfTuOBxV9N7iQaTs9vjE=;
 b=CQ3muNoFHkmlADcGaTNlhHVTHEBYDsM9VX8dqH6BUHWZmPlfMzUX2+5esmMfIM5maZY8d8bKEAtD1qtsxPxlgGcstg8vKAgrX9ib1TwVoAeSRRFsy2AXwSxd8hwEXckKiFn5wlmsJIU69ojiiZktP20ajhNN4qZIwNXCC7AM6Pc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:56 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:56 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/23] drm/amd/display: Fix potential memory leak
Date: Mon, 15 Mar 2021 09:40:10 +0800
Message-Id: <20210315014010.16238-24-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d8731b0-7ca2-47af-3c1c-08d8e7a4d1f4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659033CC80F1D461EA7E8A3976C9@DM5PR12MB1659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:43;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nitR3vfWEP7iHT//VK1LI6z59AuDUCXQKo+ZQcPskvVqSbSi2jWk5QFVb+jdXMi0D2ia5nVkfG8YKpNuGMYTQh6gUzzdp43nTCDajyniJAVmwo3o6gQuNCWQpD9XcMIPp11DYYCXblIe4CANdS2uvi2drwrl4TrCL7/5HI3r6SEj9hp7VL1p1kYeymUY8gXuZpDEME0mwGKG58b8g4Cd21LSCkbvSIAGIay+2In5J8CXKp9IDO6Pp0ZZdQL2Jrp6nwtWVLBLLyBmXxzmVao3Lzo1XS9rkjRLMsBrFWLw/WzgdDjARbNcTbl7reEbA7AgR/Xj9WIWkijJerZtQvLE+QiXedO1r1s6qu+nfJDJStipGyCBrB+6w2ySqUuCY4wlne2PMTsXjIfs2qXHM8u3ciNRWAA/0jEbugPPZOhy031E4QBIpzRtiOZvhi6tJikIu3p2ZwTxFtjkIP/1VOhyKkIzLMlc9e2M0x9XDwGjZHdi8Ksfg3JRxiED8DWFerAzU1LyVAnO5rBlwiPNl5kL6hBM4v1uSQxY7mgXUgIQ6HGqQZ4zEXw1jkwmtRiwr90E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(6916009)(6666004)(956004)(478600001)(4326008)(316002)(8676002)(8936002)(1076003)(54906003)(2616005)(6506007)(44832011)(66476007)(6486002)(66556008)(66946007)(5660300002)(6512007)(86362001)(2906002)(26005)(36756003)(16526019)(186003)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wIkd9UbqQuW1HmX0stw/YyLnqm+UmyBDZFVPcOX9MAxPJqj8Adlep3RvRdUM?=
 =?us-ascii?Q?qtjd30uXLP47En8GsN566lURnLDSaMQ6CDdU3XyNvG0WbXdbVd7M6KkuuQ6Y?=
 =?us-ascii?Q?mbjevsOpPflMr9vCwJgFnYKYWkKBeQj4n3nOTWU5EfcI+wAOil2t1mp8/PzZ?=
 =?us-ascii?Q?LTS042UBYTUrjNtPi79ERQq4jXWUsd6rmRqPymzft9bWOlzwa1THEXb6rfuU?=
 =?us-ascii?Q?iWdek4pzFnr3W9Y4JN8Bvvvf6Tb42eLljLP6jV7zHkzxCDtQRMEiCB19CcP+?=
 =?us-ascii?Q?7mFAsrYLfy7M8xVPQTImdNb22/SybsGjsdW/EQNWrl8DMwUieYKos6OgKF/n?=
 =?us-ascii?Q?OAgNUH7JIAEK/krBcbWx7nhQWNPyLpogcFEwBbIHE6xm27OdD2LG+u1KxJxg?=
 =?us-ascii?Q?8t3T3akC2A/EyHyLeHE7OlhDOzprIATtJF4rbj8oICzW1pva1Yo4btai4BPz?=
 =?us-ascii?Q?eWCzPBVTQqyZxuvnNjWHW+SYALwtuyqUL74RvnSBJbNZHvp6z3ja+Gf1BcYE?=
 =?us-ascii?Q?ojDku3GD7exnD0eO56YhcrS7YT4agbG7Fyp6eNE6GCSXzosLmfF9KEpkJV/3?=
 =?us-ascii?Q?Qj/hFzm4OOyCYbyOFCQ3AaDHy7cO5D24nLl2UhbfmiXZeo1sa4VErTjk8m/0?=
 =?us-ascii?Q?/YDHjYUaBpXi/i17LVkn/+JcZJpwmNTgIUzrzRf4AGID1nPC6XygMFpA9H9o?=
 =?us-ascii?Q?S1K5iKGPx1Qasztq1eIzSPG/e8wcO35Ypd2TlFTvg2CKo5h8TJEhWs0oMOji?=
 =?us-ascii?Q?+gcrjRymD47vdOtOmWQvnQk4zMzy+7xIJOiLsOjwv8/AIKf1lxloogzkx8Hx?=
 =?us-ascii?Q?uu3u4sBaDXUNrM2WNcHTXxBlHLRVE7dkhO6vZb9tsZaIppO2/Q7A5NkqQ0Xt?=
 =?us-ascii?Q?X8Z7M8vWlEFGO04AQVm64nBNvIIHcSdQf7Mfjsuzlx81+5rN6PaoS4vilvim?=
 =?us-ascii?Q?Wo/2h/7nQDs5FNNufYtvCbPGwtklyXfKsRPVQ3+O0khFyTcS3ZvHQw+v/iNu?=
 =?us-ascii?Q?KxYpxHgPR7Fx4ss0U1mwLCP9nmA16ueisx/GO6YLnnCjZJxIQXaDi+aLs8tX?=
 =?us-ascii?Q?FqLhM22gWspxUQw75aDFt3HuKa2Sd1nOaRkZvUphKVBFg7y3Z5T+b6CxcYEo?=
 =?us-ascii?Q?NP0ikpIPANYXOCWAAriBhp89L0ZBJTNS6ZFsf/USBlOv22cKB3TRMjUTkkRf?=
 =?us-ascii?Q?ckilYY/fDmA0TpV6lJjEERdzQhUBGjGRcgVRfDM7HbVxGwlF2AHxWWddnPd1?=
 =?us-ascii?Q?1UOOxW6ltDh0SZyIw63BTm9vAi5jFjC8dUbuXfPKz7kfpZYHwA7iyMBmKBG5?=
 =?us-ascii?Q?QZBrfMtI8veTsa8Ufdi+BftdIsOwhWo2BLN3s4eBs6KPZQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8731b0-7ca2-47af-3c1c-08d8e7a4d1f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:55.9570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4NxXfnzAimLY2JTh7bGgeEY7w4tsZeExq+vqgayu7hcea0yUh8d/yMPGW96tjJ1svLhCLqmNAlkFXKIeHVkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
vblank_workqueue is never released.

[How]
Free it upon dm finish.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3db69f5bd6e9..41f19ec743d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1228,6 +1228,15 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	if (adev->dm.dc)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
+
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (adev->dm.vblank_workqueue) {
+		adev->dm.vblank_workqueue->dm = NULL;
+		kfree(adev->dm.vblank_workqueue);
+		adev->dm.vblank_workqueue = NULL;
+	}
+#endif
+
 	if (adev->dm.dc->ctx->dmub_srv) {
 		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 		adev->dm.dc->ctx->dmub_srv = NULL;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
