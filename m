Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC30C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 08:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054A56146D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 08:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054A56146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC596E909;
	Tue,  2 Mar 2021 08:04:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB886E909
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 08:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSK80drFtV7I0pgxQaEWZFb6pjiX5Q/Ox719+7YZMydAXftQ6TMHiwHv1y7cQxJdMqMezhijSxZjMHLnDsw5xRgv6v2L5tB0gHm25fTml7JtQmLIT+CwbJjXO0ULDDZOT9EV8S1OLBBtSTZTB6IaAxiZT6VfLAQPnuQon+ysdPixAZPhErlq0BF/TnhDCFtv87VGYpwfzZjKqBJed4pQYATsQBWrTqMccn6rXkzVoD3LFPwzw4GLbcxueNIdJI+8eD7g3lxuFzv7U4qIrClDeusv8kyOMp1YxgfaqVFbhuAy/qDxQ+ISKlAHALWTGZ1O0DaqNkKwCKUwn3HgsJCYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrRdw4HEhFO3c5yBlIhDVHxvb9YprYimWrw7wZkdW4I=;
 b=eAmYhSPK20HWBgH+/2CaCaxQCG83jS5HYznN4pd6M7HIW9eKHccG3YE00zeSABcB3bx3MvrOiXux1cqhruw9iTuMxWQrBh0fZoz+OK8x7ATWiiMTc1GMShO/gjTvFIEVPDeVXWcIGQ32tIl75nsRQp22yK9ygpl9idEhcXfAYHsloiPBdR0USoM6wy0SpIvBhhDBlwQoqm3upn5mfO8FsaRn1b/Wnj9MzYFdgVwcvNZ9qMj7gF6sGe5kL4/4hIHKEKBGGgMyt2h8pr1NJ1KIBNtTIBD8p5IXOYJdR/AapNQqWjFpgbBcV39EeJmgb/9PcIE0kPn660pcEK8d7giIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrRdw4HEhFO3c5yBlIhDVHxvb9YprYimWrw7wZkdW4I=;
 b=Y41cthMZqmmg+e++4c9YUP8KkDhkYCWgW7x6M0UxsO5UgqGWnrmIw8Xt2DenJPIgTv/KYiszWhPOo/JeLJ/UhMGY0cuN/mP4E35FQzGpD5N4up5mt0WWUorG3epzqvHrPP6YQyz2y1dV+GqkeuW87zVzKsQOy+0o8e6PbQH3Mbg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3264.namprd12.prod.outlook.com (2603:10b6:208:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 08:04:22 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 08:04:22 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in
 amdgpu_regs_pcie
Date: Tue,  2 Mar 2021 16:03:48 +0800
Message-Id: <20210302080348.7101-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:202:17::19) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK2PR03CA0049.apcprd03.prod.outlook.com (2603:1096:202:17::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Tue, 2 Mar 2021 08:04:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8310abee-de1c-43cd-e63b-08d8dd51c99d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3264C29F9D77E0A8ACC05232A2999@MN2PR12MB3264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edoQEHfvlPDT4bf2uqRTrtrjome9TDFXjH4JGnZIrQRbOz6NYmJNwn0ZQEc0i7Y0s0eFGcRtRuVSaoNMir/Ce8yp7wDPeKzCzlZ7UJ1wjLYeuJtzkB9eopL/pGMqmrVivNCXmKkqJ3zZz3aMiP5jo5GpAkSml+y0mnu55tIVChoFo5WlKtN643kJ+Q3pKrpQxN5hsEUYCWMe/v14QIGTWg0y6931RAphWtjml71gOXCDo7aBwMpPa1UdsvvXtCx71mfwvnf3vZY++2dumWS1MeN0Xc+5nQYnVJ2ITL4XZbcwGpqufeBf8XZvkQ8ZP0pjoSc1fJxb++9dApVdirTr2plT9sZhwXhHTC6BXUErhUPesmMrZRQVK4cFLM8zGa/RphoXKcqc+LJXhk7mLC7/2j0Oc7Gf+GKNSbmkASAhxGM9poWRiw3S5jpkCzEVGDYvEx39hXgmDLt0JMdrlWoPLHisbILbxvwTBD2+tFnR7jo/DwOE5yHYIyBzqGNe6DOwMHlzrQs6FeDYCEzTwLuEdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(4744005)(1076003)(2616005)(956004)(316002)(66946007)(66476007)(36756003)(6666004)(66556008)(5660300002)(83380400001)(2906002)(52116002)(86362001)(8676002)(478600001)(26005)(186003)(16526019)(6916009)(8936002)(4326008)(6486002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P4AOCn1xQ1CQciqED0kaMn8hBNGM1puXYmalwlwC59GBzosuv5EICGB+yRAi?=
 =?us-ascii?Q?To0PAWqY664x/3jwX9vPk6M4O/jF1pNkRCLbFgsNoEchXdtJpyBkof/mgu9b?=
 =?us-ascii?Q?sV/M75j7XZDj1QzNE3J/ooMcXVQaJMiknHtPU29ZwM+YZMMPOGNzCQwqHAoy?=
 =?us-ascii?Q?d3c7dLGxxP+7odbpKB6mqLgJc/xfYR2lYCwF+VfE5wWHlxObf4qsmK+p7HI1?=
 =?us-ascii?Q?ww6UdUshtG2YQI4LI2BajCAOlhnaot/hIX5hnEHi0CwqO3r2ncAKg8PX3sTe?=
 =?us-ascii?Q?UfazpFjuuXDK6JLH6ljGReHYK9HgYeK4Cexjy7lvTMDLgPpb7oJ0VjKyJNw0?=
 =?us-ascii?Q?wvpUINXQJjX9kjPHFP6aXeOdtz1BpZMHN/QW49I7dZjIS5WasZIkajEr4Pss?=
 =?us-ascii?Q?PYNAEimwNVBz/Hj6H5fBGOxtakuDcD95m12LjpeHMYwNhdmgStHADBA03SPa?=
 =?us-ascii?Q?F4N7m0bnv/jHDIwo0aKDtOmglAnUPbte2yX/YoznTWnVWeGmKRD90wON61ec?=
 =?us-ascii?Q?o1Y2QLklOlYwRrc7LmsZmKmdUl/4jWvaMwJNGvv0FERWXQ228cgItGJZ+tcc?=
 =?us-ascii?Q?TDuPWj3MT+1FoVXWFcQe18OGS+Wh/72I9Kk5Cz/34rmCvFiglydF1JxzfaQr?=
 =?us-ascii?Q?d9kvpc7Nc20QceibihM0DEEh92WpMVWfZqI/RszkEihmJ0z6i4P3UoiIV5is?=
 =?us-ascii?Q?ueGB2cw2TlwArlCIzRbQ1tw203n4tOg0OEfvW0VCX2d0A3TxbGwiEDZDlXZj?=
 =?us-ascii?Q?SHsYIYOLs3sknoXAb//Yb7XhP7A+EQAwJxtrayklwWqsTFJOimtJ9drvVqM6?=
 =?us-ascii?Q?KBYWJTjZztXYYeLZecWLngSeCxb1eBetYddNn5ZUqbKz5lRAoOqIlNvznPwv?=
 =?us-ascii?Q?XKZDzuu0EVsHCWd7pk++r0muja4QnSOu7s01NLgX5Q4In+5++zdrh83VVEbI?=
 =?us-ascii?Q?k6UFsoKKe/0BqQ9QRzV14ZR6XxMBhmDAyavcoos1ToprDxlDWBGC4FpicsjP?=
 =?us-ascii?Q?bEin+sYD/FD9apsPNcN8OXXg8UlMIz0RkDbkfz/7L2FhfE0jZFJ4Y2HDzXgO?=
 =?us-ascii?Q?U1f2Zbw2cBQgyyVv0TCjmidCqUjpw8OBupamhIYC9NZR6j2NTmIji22QYLX2?=
 =?us-ascii?Q?UgybtRRHo6ohnr8esxVv7hIm1PwOFm3Xvjf8CgzOezRPgn8X2ulx1mZd+6p1?=
 =?us-ascii?Q?Fg95ZNkqhTbA5ST5eT1Sno59eNsZ3v0g9OZSL6YB9IbHfT9w0uY7yqayiBFv?=
 =?us-ascii?Q?Ko/ZPJ+nYoTSczwgeDrLnUQNYb6ONkOs25gWP7BcJlvRWBaYmr8su11btnsJ?=
 =?us-ascii?Q?Jr+f/DLsTfQDab/jZ2MYn8KO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8310abee-de1c-43cd-e63b-08d8dd51c99d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 08:04:22.2950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sV9S/lQFcxCZP63Th46EPhlb5iU1yqK78+uz1Vhtl3hoT3kgCiO8mT4OCKYDSDPO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3264
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
Cc: lijo.lazar@amd.com, Kevin Wang <kevin1.wang@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the register offset isn't needed division by 4 to pass RREG32_PCIE()

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a09469f84251..f3434a6f120f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -317,7 +317,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	while (size) {
 		uint32_t value;
 
-		value = RREG32_PCIE(*pos >> 2);
+		value = RREG32_PCIE(*pos);
 		r = put_user(value, (uint32_t *)buf);
 		if (r) {
 			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
