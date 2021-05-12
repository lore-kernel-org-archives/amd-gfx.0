Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6648C4360C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B7861059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B7861059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13EC6EC84;
	Wed, 12 May 2021 17:32:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22C26EC82
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU9G9EejnSnXCAnb7KB5jpGtn/Ki5YxogGWyepBRvtRWRN3oh9MUq+sNUzo64jKRcwGw+Ft+iUSL4CwsYCb10qML/rxYY2iwVN+QKW3BAK3Zgh7qjBq3kHqCWNrld4+lNYpI8N3HyDL3PTSrlrGWGzpaM0nF/xN3+YWvgHQLfQVDPG7E/j4QBV7ivulxHmKmYJOGSn0olnl31DHCDfAAygk0vrA7Qi5fyRyFy702qriQvcIG+BMA2Vw26FGHf9c+7sjjz45+R5YEDdZbWBo0B8Pg039qVgkd/B6xgN6bGo+ImAj72SoXXafeq+6ZDuojlq3kmx8cU/pyCEr8eJ1IYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0hjUY2ScprASN26on/oXGSI7IwZUDhA6fFJho+969s=;
 b=PRMPkl9qzHi7FuZzXYshQW4YwgGzELN6eKqpw/C41U+xmY4Y3pgiMNNE1uCewIMYtlAb57A3vENb++iPbFV0rETU0XnqWusp1DGnlkags5zOYAdirj00AN55R7uWdmRT/aE7wa05AcIcV6URHSj6jewUrzI8LOHlI7M1m/ZLJ+pP7DPtMMMc2MSnkybuA/XhaSXshhOsswRFewo2DioYXOYrJyJmVSlJxCTPLIQAm9NeAZcGIhNqW0RHPIaefJ5jzsrmU/0q9kg3emKdLWOwH+ejlzpVeaiwaHSv4BNl7Fi9fBSaHC5k7tZmw1+W/9NErUbIdfETok3WrdGJVUQAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0hjUY2ScprASN26on/oXGSI7IwZUDhA6fFJho+969s=;
 b=LpOjKY7r66w8JapQFVKtAwL1MkuSO2e9v2a5vIiUJUViytTjpal512vqZptcwqpi4fxaUlyrIF6/4ylLqLLKzZsMNlEDfGmG1E0XJmaV+9K9Wv4xEuifgl3ouFbqwQ1iFtzpHko0fFx+eq8U2Diq+yCR+kDXLl8oPvs+WNSL35k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:09 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/49] drm/amd/amdgpu: Enable memory training for psp
 HW_REV#11.0.13
Date: Wed, 12 May 2021 13:30:45 -0400
Message-Id: <20210512173053.2347842-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29c03637-0a90-4a43-d727-08d9156bcca2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2564C8BC045EC68501AB07C5F7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XubOySeuZIMQhbrn88f5+gyZ8HUQ9rcN5kdq8DT3m3NsuwYJstp+AWprVPiAnMdLzobiI9UffLsRS1ONhR+wSHRoWbJTKT+Ix7xkDh6MID4rLC6GLCchzR92cEJiOz4V4GXPBJ2x7+2BftisfqjRFeFosWe4hoYVrvATBkBpravbqa05HzfsPT1P66R1V6BtKFqxB86dlq+nbYRkijSXxeevguwHL1qQ+iLX+0tJvza8T4pensjddD3EXd5aHaAEc98gjAeJdV+D00d6p6/nT8huItwuZb/2oGwi6uag268SVsceM/R8i7vhC6kRt+0zVFpyJshgwvemfvUvi2y/+B6RXXkGGQoUWGsXB7Jc3LvF1lJqyKSetyrvd7/w+6AoJXAYRK/ZqwVcIcde8feAH0OZuoLYnysJSv6H7DlvfXPQYzVsFMxTpf8tnAfCKw8hwooXni0nct5DfA4eMGkaDXWacfxfWGyZ39IBADcbeJjuiI9VBLB7DgUfvhnOhfzOXBhBcuE4RKTUbona7Xv5/4NNpNDtAE7RZ+uiyvUN+7u7LZooyL4WsilWlWeIe1EsgFgvsc2mx0QMr7HobVQCAcvLAQ6Q2ywZg2Mc5RtBmA/RmFcRSpG5FP58yVejUdfdB+2J5VVObItkTMn0W5EsGehhUNwl0PsdUt8uWEZJCSqMZpbK2Iu/gOBjE0q/fqsF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(2906002)(6486002)(1076003)(6666004)(66556008)(54906003)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(4744005)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1CHzuVjvSk8kqqEBuTcuNi6Qm2HrTEqEAIQm8a7gZdcuwYI1xJmW1kvriFb/?=
 =?us-ascii?Q?87syILtj4+o8xZQ4nBt7Baz2SXEDxt5iewNFUzr1SxZ1MXe5MS1c0hs4Xg4x?=
 =?us-ascii?Q?iJGgs+k5VquZbMWYyGok7NeCWPN/SFXYgSNQPVOpMD0EKEsohtET41gAT8ao?=
 =?us-ascii?Q?VXryNcMCsw8tWiWledEzOjuAncIXCHNQgYcVWZ9Ld8CKCtwjnAU3A+pdL5dm?=
 =?us-ascii?Q?WG1e4S1ZgFMnVYSmx8qaRgFgvZfoHkiunmz3eueOit8bCQ951IlGYj1DxnTJ?=
 =?us-ascii?Q?MjMtRHXleDi5DNk9ngtUVenyMC1iCGsIZL2wm/DmL3lFCIMLOzt+Y7tqKMRh?=
 =?us-ascii?Q?m1QOcNsfSiHy2vSebDFPneQecva0Ay+QS9qO22Eh4iEaMcNXxBAkzji5zocE?=
 =?us-ascii?Q?MZG5SDtrSLxZXuYFHFri3CFqkta5OPqp4G0ZVadIckQLsoMcaRX5tMGvm17E?=
 =?us-ascii?Q?aiJ2uaKZcXrt6vUs5mJbqZ85nZvU5Ai5Yl+zPoBhBQv9VjYnq3O+LdgT0QDa?=
 =?us-ascii?Q?d2pNDo4iShQlzg+IdxzOYmPHXSZa8FCVS3zONYDsbiVJ/3tfexjECXPoXtod?=
 =?us-ascii?Q?iEractyqyd4CT014/PXsddji05G+n+bRCl20DRbjeH8vbqKogB6E2MgbNQZn?=
 =?us-ascii?Q?9XoqUO0xRgc/NeqOZTZlbPt/YsSnlumeZjJf7pd+1dJCf0Wx04f8IP+OFUCM?=
 =?us-ascii?Q?c1CVde5dsQLRwrLNaIRXLoa1uxSNEIMHKXsNBTvLeflhuK2LAjFWF2HnNSdS?=
 =?us-ascii?Q?ay15/Oo8E9x5AldzT3YGD5X3s2x+S5zp1m55d87BiAMitoVdFEl49ai4rDEl?=
 =?us-ascii?Q?kDMBlDrXyiy4SEM7B6nr6F7LfKge5yRghgb4Rm0XZTmdf/YdV4gVlOLQ6Q/O?=
 =?us-ascii?Q?7G/2Z17HlRXAkQhrlDwZV3yCPb4Y+yRiCbC9AvXO218OrmQkstyuhrFmsAwk?=
 =?us-ascii?Q?urVU8KNmyuxlwSt+c3/mJuPClR+1Gp02LncaQaJA8gq/3uAEPlxc5SPvf0dr?=
 =?us-ascii?Q?Nqr/BKSYQrnrxR1w+65q6K6f315WZRP2bW2JSAJmd4cj0LvhtNG2aZVbBjAS?=
 =?us-ascii?Q?EgVhAvSXD0afOY6ApF6dFJN1Hl8rk8Xgw74b2kPWIEJnTbeESY3+GZydHe9X?=
 =?us-ascii?Q?dHG/3zwDXWOsn14zZ0apP7rsAcSrWMcwqv5bxQHspb0RIlxgIfiy2sBubYyf?=
 =?us-ascii?Q?bqtIJoeCqXCG6rwuJ31EuOM28mqBfweKImr11rhr72pmD6tn+kOuK7KSdMvm?=
 =?us-ascii?Q?CpXJ1jfhs+Qy4pLsC3oEN/rNbi1LcYAvnuDqAOf9YXn0SYdj03q/l7CbB3YX?=
 =?us-ascii?Q?RWy5Jd+1K/K6Jk16RdPyeftq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c03637-0a90-4a43-d727-08d9156bcca2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:38.9778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btDUJ+NL6DRXmYaGoc619PyHTWESsIRoj3JdplaLaFIJu+UW0HbLqby5sODX8/o5IYRsHG0/CbJgwNIBhPGPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Enable memory training on newer hw revisions.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 60716b35444b..6dffade320a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -629,6 +629,7 @@ int amdgpu_mem_train_support(struct amdgpu_device *adev)
 		case HW_REV(11, 0, 7):
 		case HW_REV(11, 0, 11):
 		case HW_REV(11, 0, 12):
+		case HW_REV(11, 0, 13):
 			ret = 1;
 			break;
 		default:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
