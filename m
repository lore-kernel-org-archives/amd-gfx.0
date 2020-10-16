Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CD2C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F59206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="drJWDYco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F59206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29616E9B6;
	Fri, 16 Oct 2020 03:27:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03D46E9B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5m/HPIUrdYLidvDqsPu3KZghgh8AGqwBrrT9A2LJ0VH1wR5Cl8MGY8CdAwuFugI3g7js6em1A39xXMAY89VEs9NK+nq16qREKEdBRe2KkUAMl0PEjaH3AixFZbnrW+wKELMtaxOoS1DDC/sJINbDiJg4TlaVWAe9lSCOOM93RP4lHeMIaUFnBkphNZo/XaToEofNq9dzn8nkK9LIbWb7fvkpCbInFNf7rIkHD8yw7Fv17MfNLL/qUmpW/rirXSZDDepWZin3JhVYKXRbwHqjkiyObSECIv/E3+o+2UxRAmmk8Cz3QLwEvYqq5d+Xl9fC/4XnY8Kw0lj/Wwk1Ety1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaewBmFtPjykVnKZDhbeloSAFBJvcQHfy2dyeMCL/yo=;
 b=COrgyFMvad6zGj8LYTSIrYT/ccl/I8hmvU2EoiRjZQesLXyoLxaEWZHeYaoa1ODzBNxzFyGH1qmCSzTOsHRqLL1hSC71S2uKc2/urv41lkt+Idej+9pM5rYwqmrarraMzFcnaeA8gekFOACJRSAMjgY34QgPWjUf9p0mkxU+xy1ODL0ENAsH8fDZsLw2LA39lIxp6bWLkAApxXXN8nbci78MNszV3ys6L4ALpB7r6YKIYUYloTK1xYkoz0T/9Wa7ykHam+4emb0S5c+mjg/+TviPXCbvs/RCdUOzt1ARD1wyvdHhWfftx5pCi0ZmOsELvIXlSkzaulHSo9/ysyhMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaewBmFtPjykVnKZDhbeloSAFBJvcQHfy2dyeMCL/yo=;
 b=drJWDYco5u2uNfzfb1pRxESGTniJ/Xcn8TyGdnLiOTxJzuzgUHwZ83LphowGHf4WJ/lK/4uCQPK/FpXvIWIZaIBlTE3FrS++anWiPbBPOyFqk5nVMAfebJ+bRt//23TfcLcRhmUoLxCcIG4b/4Wsl3DKUqX83wKJGDUuXTI6rMg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:46 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:46 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/40] drm/amd/pm: correct the BootLinkLevel setup
Date: Fri, 16 Oct 2020 11:26:20 +0800
Message-Id: <20201016032652.507-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 642b90e4-524d-47c4-4d19-08d87183734a
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB468008119C60C741CF70B8D3E4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raH3U5SJ3UilNxhQ1vJ6SzOd/h1owqiK/2ztJq6CDKTrzw0ZxG7dOlf/ZLsQsTILEMdAHWThXJthgQRjQRd9/ElLI9oJukAjDEkS1JmRNwz9nPvXVkYldjvSh0JmUCp9mpIepG7a7CqCJAtG+h23+c4Btlcdqtw+SgonFBEQaieQj60QDgzs4qvsKIoJhbLcONju5HEcObdbrVe20+rOV1PdSnkff0pvRD5M5S3lvCHNPxRpGIDvUIrn2+4fuRraLSAo6f2Tb3A3/BFIlZTBdN+6nvQWUC6XCW+6AzsZuB8Ec4sgfqC9P506vusTw38ntXhAzwQCbc9BgQrMvMnEp3v/OZO33kNlMRhmLkYq5hUCf9UZS2KotPkr9fWyPRoJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(4744005)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4JkswI1SyGFDPZdE0upavk4q0JGV/Rfl0sW9lyCB2B7yrQW8PHfRm/u3iGaDcfPCbJvUtuT6yVV+ucf5eCQbL25xtbMaj+GzMKKXooE4DDk5SVZ63GoPJM4zDupfCOfng80fAixyVONOKr8BwTQAdqsRVIdnvpnkYlX7ZUSv6+zyMR1RJcXjw672ENxkOtOt+eri0i9saSm3mLDAkpkPWsvO6HYxB1myAPkXOzA22AQp+c9M9ujrN8HqZUOuKKlNW6JIb/oKDWftupuLt4rPnMMDgumxGVj73uy5Y75e+40vUJZ7GSfnaVJcLKgqDP3JoPY0B4Vs2R+SXxfA3vaU4Kj8YYXjiA/hAWW0LPCb+9u98r8gPaUDTAFwcqO9K6PmCuLtofQF3r6N5xhmI4gsTNsQ1wMnHo7qRrfzIl14PqxuiPSHNsusrrqzTvps+BnCW0cbwFDdrCy0a6gRYOQ6RaQ8w8+AsfE2aIKQi7ajoaI+oMMSOC93ed+ZDbktqchrh6ivSWbymAepF3BmAdhhJrqWWEunAgyMkHMVt+b0AWWkotNZhwMdRv50EAH9HStxLV/ZbnePhdffm1WefjYksw2byGpLWBKZqctExPgXcAeim6cPviEW/hym+hBBptkAf/x8PZ4SlEbxGwPDBHUpKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642b90e4-524d-47c4-4d19-08d87183734a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:46.4967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaHB+rpsOcQCMI53NqVpDgJA7symjSbHGtzj2JSc6BhrEUf6m/keesOvqYA4KoSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the BootLinkLevel as the max level.

Change-Id: I5fde6b472c9d802420be5783fd93f589404e66eb
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index a6c8f121f41c..d9d53fbd438d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -2023,7 +2023,7 @@ static int polaris10_init_smc_table(struct pp_hwmgr *hwmgr)
 	table->VoltageResponseTime = 0;
 	table->PhaseResponseTime = 0;
 	table->MemoryThermThrottleEnable = 1;
-	table->PCIeBootLinkLevel = 0;
+	table->PCIeBootLinkLevel = hw_data->dpm_table.pcie_speed_table.count;
 	table->PCIeGenInterval = 1;
 	table->VRConfig = 0;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
