Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126DC5519F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 13:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C052168B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 13:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sL/KKJDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C052168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE32F6E207;
	Tue, 17 Nov 2020 13:30:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E1A6E204
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 13:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN+DTB5EZ3ntLu7VhGO1u8acirmYA67EPErSTfP/WWhhtxn7EvNXZZMETfi7qQHrwV2LNVSa9B6uHwEu6oWE4ppAKErpMBBUetEphOfuhml4CE9njw95AwvSw++q0/pzEpA0UVspjVh6zW0Ty85qMTeCVP9xfw5UTPG9dTz+57aMlbzy+u+FIFlDWG0kPZb5Rju9JNAUfNTS6LKXw6Vn9MDuFnhyhZxEB1N8VDtQBfONQdmO/31hrR/fvbJZ8hy7o4SjWnGU1BCHJ5VHX1tQAgggzI4v7XXEHYc7x85RkQt97tSAihCRmwjGECz0eom6Oi/idYFllEGxTd2eFk7JWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUtTnnkxv0eFRjRhBiXtm/ECfL2kpiyN9Xq824WRYEU=;
 b=n8pI7NUbr/A21IXejVU/FdzeygmMUsySc4NyxdmSfklIvqEDxuxktFkAKZKiWrMhLexrBeUFH2YTzYBUN80GdIWInPsJ2OqBNkn14dtkFBnjAF9byLtEzdA42a/Z/N767KQXUcJt583YzaHxgzEWT7xR+PsWQncGm+Imii0CG+KWl9hVSkzm6Hii32WcB3sABL2jJrVRdtbDQ60Yq1/6J1SjAMBFOQjYtVoVmpwmORVi98qq9OiGMQ9SpqJsMRbZYHmvjkkqA0qR0a6/stTUGSiDUHH36fg6TGulVP7calrrocjIFViYKfhBTn8ISRpkIBp2u35svde7Kwe+zBhGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUtTnnkxv0eFRjRhBiXtm/ECfL2kpiyN9Xq824WRYEU=;
 b=sL/KKJDKw7J0NMd02Ho9UjZo5mHuYZ+YIA0/javL0dKGpXFCsG5tESmRGThGrOM7bYpJqA/B3ZIdPHsyCtvGxBqIOAvuO/o9nLNxEk5HaKcebpEvkAURXvFjJA7pNKc+pQboxK8zM4ddw0zkWRBgtIvGAvrorYGRYyscJrfNUl8=
Received: from MW4PR03CA0416.namprd03.prod.outlook.com (2603:10b6:303:115::31)
 by CY4PR12MB1509.namprd12.prod.outlook.com (2603:10b6:910:8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 13:30:56 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::18) by MW4PR03CA0416.outlook.office365.com
 (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend
 Transport; Tue, 17 Nov 2020 13:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 13:30:56 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 17 Nov
 2020 07:30:55 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 17 Nov 2020 07:30:54 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] runtime pm fix
Date: Tue, 17 Nov 2020 21:30:49 +0800
Message-ID: <20201117133051.1016-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e2de56-79b9-44eb-8657-08d88afd0391
X-MS-TrafficTypeDiagnostic: CY4PR12MB1509:
X-Microsoft-Antispam-PRVS: <CY4PR12MB150981422A697CEF20124ED08EE20@CY4PR12MB1509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3hpnHJCXKXuwRfjLpPg/gvvC9J5eMxvKxDG0FOXszpC3ILyD4xqWLLFfq/0TeRoPPEW2E1REL2lVq171tkEkjShRoj8EkAXmjQzqKGkIpfzNohX5MnJ9RdrRKfoYZlLI2Mi8vOaqIByjzKzt0gF1sOTFGujxdaFU8wEtQ0etWn6jOVUzBD0pkd0DEsuxuP/yWzjCdtI5Z7r/HAQ6xnZg5Tnue4ZMngDL7bC0bvRTGYjEu+G/ZRUPzNBO+X5E+IBoBKxwIZmDEAICJDYSNpebm/vTThI31ksiUpCIVaxKfyPvvFzagOK3ETZTDvwt6KtCSbqxRiq9fiQj5CMHRyeQVnI0ubc9CyjtFG4rUovG/nAvW1/4P8Qz0I+uApMfAIUmOrbwwdSDQ0xdTfWYa1uCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(86362001)(6666004)(44832011)(83380400001)(478600001)(47076004)(82740400003)(316002)(81166007)(36756003)(6916009)(356005)(82310400003)(2906002)(336012)(8936002)(26005)(2616005)(70586007)(4744005)(70206006)(426003)(8676002)(7696005)(186003)(5660300002)(4326008)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 13:30:56.1404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e2de56-79b9-44eb-8657-08d88afd0391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1509
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this 2 patches fix the runtime pm problems on SIENNA_CICHLID. 

Kenneth Feng (2):
  drm/amd/amdgpu: fix null pointer in runtime pm
  drm/amd/pm: fix the crash after runtime pm resume

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
