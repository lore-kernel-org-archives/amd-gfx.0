Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC91C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC1320757
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v2bzGBOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC1320757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291AA6E0BC;
	Fri,  3 Apr 2020 10:55:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C326F6E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGTlmSFqxXXL5z5kLyiS87ar2iwbP4v8siNfe59D3Tg06EmwYoELJ9rO7WpYshXqY6DgugwEJpnUzfacfsIckFY0lKvJ44u8Tb6EDRthVVbTsppBOu+sLZM+vjipV4+fR49e5NFeXUb7NgAYQd36DAH+mXQV3fMr7SRkgw1r3q5d8TzRlhVNYRgAr0BfkKsdShax0lQ+P7MsCV/7ZTaxQN5MYV+QYoJcRPw0Q6i4dOin7iJLyJ7JE34EomTJbR7gYg1SQPd1Y81UdpYt6O3XwI6YcIKsGzfsREhg/tpUphvvqiI80PXtFCdbn6HkPZh5Hvl1SRAB6Ad1pfV27MIlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVfAxzDGZgdhmN6ebCXt0e9ue53zp1fWxh9Cfjy0w0I=;
 b=ISFkzMIvtVv0M+SUR0n4yuU7CBZzA23FmCviE97fFSGxSAoCYEZ8MryGggFC6x/huBJJMzNZGD/kojLSUf2I7ic9eLm6vdmpgaOR3fAz9rPnNNqknwNJhTqvIMx+DmFYCGAtx74UjKiUSv+hGTRQmtIFcaN073SA034OxoKX6u3mGiUrw1vutNy3BPvui7pWlB8NeHpapBYnUCP0+8AMmQmtnJ+VhEMvCRpam+ZAgNT2IaN/Ax3QWAU7dTJMLv7JP60W6DNeUDGjEB6fn+ZKhul+ev3M7NJFnQA09esB/1OGQJspeSVvKBUAMr02ACXITOCuZGRp6H+wy/sYYzsBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVfAxzDGZgdhmN6ebCXt0e9ue53zp1fWxh9Cfjy0w0I=;
 b=v2bzGBOEwSg4zT4b/4LFyJ5+EG+DAkgtL3qb/UTQuBlddKxCsz0TFPLW3pfXTYfL7DuUwPIBwXLvoiGA+lmRWHTy7sKnSU42tJi+IXzlmXJCnmrt+YdOOrTBoc6DJEjEpYtaADdWdWzLzq0ANPDsvzmxD67wUqjpEJWE3faWsr4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 10:55:45 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 10:55:45 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/6] refine register access interfaces
Date: Fri,  3 Apr 2020 18:55:24 +0800
Message-Id: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 10:55:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65a0be23-6e96-4ddc-9658-08d7d7bd8f1e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:|DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB383320BAF542B868BA171BEBFCC70@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(956004)(2616005)(16526019)(26005)(186003)(4326008)(6486002)(6916009)(2906002)(316002)(86362001)(6666004)(478600001)(7696005)(66556008)(66946007)(5660300002)(36756003)(8936002)(52116002)(8676002)(81166006)(81156014)(66476007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxKLJnLpRnpvKmDCVbpGyz5yVAQVvo+CuhkbF6l+wYLCDHVb9kI+2GFEW/PvY8kQcZCBdBT/57FmE8hDjGzrdlDG+THqNIpOizBCVRNbkYOMUQzl531NDNTxwI28hlKRr03JgEWc/6lhs8HiJjg0D82OY/tjecoYrWBYt/b56Kv+zAz0ufqtmgFz2XtOFbpoIcfB5MYPP9+3C2d5PFTpG/q5/8lLvRVN35f1GbuYYgPHMM5hAwy2tzz8schyke3EGdKCQsxT3wO9nhTGQ2vXFvOYmfORg9YPb0JokzXiRjAqDkcvfo6zTPvk4dA5+HwdiOuhcv/ZI2U9VxIdFnGdnmgpE9U2KQ4PxQs+HHQxQgCacLKk0AasmK0W9mCNCOAPEmuNiESoHP/JdqeONvn7Rh3m7n9gkBd9AfoIEgxrnCzyhM+YwFYH3oKVDXT0If/x
X-MS-Exchange-AntiSpam-MessageData: 6oI9V9zBfI/rIRQFSYw6ysjloIVv9oXq7Mnia9AcqsEuzGyogdLSrNOoaXHToawoW3AzPBJQdEzzBKX5Zbucazv5O+iTtYIBttBWaM+Rbwzn9QSeh4z1AwbdmcZ6kzhkdHsinCQi8vvX5xKCocZHAA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a0be23-6e96-4ddc-9658-08d7d7bd8f1e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:55:45.0353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qt9w0Ah0FARrJaILPP+gQultWftZg6U/sb8Zf+O+qySP/efJuNA2VdyvG1m+xLPMQHPgEwVPNjZSm/6rIrhsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series refined register access interfaces including:
1. add indirect access support to registers outside of mmio bar
2. remove the inproper workaround leaving in the low level if
3. retire legacy interface RREG32_IDX/WREG32_IDX
4. retire redundant flags AMDGPU_REGS_KIQ/AMDGPU_REGS_IDX

Hawking Zhang (6):
  drm/amdgpu: remove inproper workaround for vega10
  drm/amdgpu: replace indirect mmio access in non-dc code path
  drm/amdgpu: retire indirect mmio reg support from cgs
  drm/amdgpu: retire RREG32_IDX/WREG32_IDX
  drm/amdgpu: retire AMDGPU_REGS_KIQ flag
  drm/amdgpu: support access regs outside of mmio bar

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 29 +++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c    |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 +++++++++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c     |  8 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c     |  8 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c      | 14 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c      | 14 +++---
 drivers/gpu/drm/amd/include/cgs_common.h   |  1 -
 9 files changed, 60 insertions(+), 95 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
