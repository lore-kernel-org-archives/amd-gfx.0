Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E4C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 15:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E554561A1E
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 15:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E554561A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1886E21C;
	Fri, 26 Mar 2021 15:25:17 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473476E21C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 15:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZbMHeRQ2fiW0Nz9PckHXzyRsc95rlQKw7oG03asCyu7lYkRzyYaq/y4p7DFYsKa2NewuFyjoi3zAg4vFbdlw387bSpyjFeBhnNIg1HBYDYAUKFoVithftPuO3FauCr/qdH4MhAwKx1D0Dm0wdJgEiFqi8ifb2PoY+3b9s4C+2VxF22OxAQIQcsziCm1rHeHAxp7uNaiX2eRcHyoVXzdt9o51vojwJ1jC+aUVflA4IWgz7Lw2PCUU5LFd+/agUvWMlzQjhc8Je+ZnUl00EF5nvBwa8hmPvmQGOagWHdEpU4et7/Jp2wdp5ZTa0ka/fLAiS1x9gCyQmpGKqMABIuaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDbx6M6bxK8mKLRjMvkVCS8y7vxN0ucIB/bg1z/TBiU=;
 b=UQ5m71LY/tJZPpVQKHRqBKWriFyodNmVRQal+8NCBih420iLCBsVcrfVVjEnBGkchEZkNqfCLMseUv6UIE08Uh/KAKh7sKDuc3Bb7GQI/xptmvh/Ij+OR9ZHOuJ+FZrxOgJbXxpheOnMYdS8JHqGx6Hnk4plC7MS9xDaCGUeR0SQ1VV1lxXnP4vsCnWqz3tfCMuUJgOXuHFDqG/8QonNqWhcpY4c3KKYTh7ByAheJCIOGgcbDck/XdkUbYDYnxQzYdQvxHDttuKkPzPxE5OtsYR3AJSbCznzetHzdu9S6DEB1oQXJxWpu9xc032lQWXdIDNv+BKYA/jWbwQ1q1LSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDbx6M6bxK8mKLRjMvkVCS8y7vxN0ucIB/bg1z/TBiU=;
 b=D9aMIz83cRzv3sHAbWKfREsotN+pw4HKPcqF8t4L0UnKgF0mPhhhXDsU0Igel27RPK0m2jSSWXP2Nh5C9a5xtsjX/iFXernzcf972DWzXyklHecGrr2BlpXCcYTVD9JqkpJrmVYP1yls8kHQruE5fIhl1Evco69YblufGjhoa+s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1640.namprd12.prod.outlook.com (2603:10b6:910:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Fri, 26 Mar
 2021 15:25:13 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3955.027; Fri, 26 Mar 2021
 15:25:13 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: fix offset calculation
 amdgpu_vm_bo_clear_mappings()
Date: Fri, 26 Mar 2021 16:25:00 +0100
Message-Id: <20210326152500.7293-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [217.86.117.24]
X-ClientProxiedBy: AM0PR03CA0095.eurprd03.prod.outlook.com
 (2603:10a6:208:69::36) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.117.24) by
 AM0PR03CA0095.eurprd03.prod.outlook.com (2603:10a6:208:69::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 15:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05d58a02-bcf3-4850-5977-08d8f06b59c3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1640A6A8B831682A84C89ABA8B619@CY4PR12MB1640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsLHl6PnrT5jUNJcRSPzrjLMosd833n48kv9UJZegI5uPUupFbEZ148QmFGI8XmuVmehakOtgugJWJcq3feRi60LnHJ7+rc5K3qMTrRx2xjpnEWf+9BrnX51SXPlBE3Pccf5cfnu6zTlAakTZmI60Ls1UzkYgMnORMap2sb/zIL82NKUw39qaLDNO7CMtRs82bkbVWWdQWbRgsJ+thQjW8tDhess653FtwMk7Mnfr9T/zAmLE6yPu/NxXPyDFw+K/C3pR5rnn7av4Rf7b08ynSH7hjpFUdynG3+bnYmaYts1dLQV/lRsV7bV5UggSUnp6f+3vgWjySSa5+4UoJJXd9wrZe2XhMxN/MR5jh5WCkk4XS+fibdDFd8JXmS3T+TpYNn+99A28xMrc5NNuB4gMjetu64Q6e9c8331HJAAtgVQUbAT1eN0FQa7sqULEaqM36jv1jNbVFDFXwlLFkwYWqtWTEh2W8rJXGPeGANiPsjB3cdetGBN1F8lweP91N9yhVOJti241IjIYSfbLyb+HFz4BJSMp8pjimcb2DxbNlvb8BJfT4SKxxfSvAlZZaIenPYkzJiw2jEmQf2A8pMeTRksNcPsOMcn0zAEonS7y/7J8glqGYGncnTSpGJN3J7+u+hGz56jsu73cTZW/acn1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(2906002)(66946007)(38100700001)(83380400001)(316002)(8676002)(66476007)(4744005)(66556008)(2616005)(37006003)(86362001)(1076003)(34206002)(186003)(5660300002)(8936002)(956004)(52116002)(44832011)(6506007)(26005)(16526019)(6486002)(478600001)(4326008)(36756003)(6666004)(6512007)(6636002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XREWAkVPZyzfMfNIwvULm7XB2kwPd20gz74h2qzjpZh2LWYzohxVzb3icom4?=
 =?us-ascii?Q?8NNgSO+HkmS/WDIaCdc2Eu+8Q1qOawrL9Fc9C2X14Qcz3y2fhCvQCx97bTaN?=
 =?us-ascii?Q?dq0uWmnxaMmcUpHGF/ld5haiJ6ONQreJLee9oxP01pGjJiCI+VFPbt/dM/f8?=
 =?us-ascii?Q?AZ98asLX9PiKsYaXfrPlrecbNAERB4DYEK+rtp5RLNvDZPXfLrFMw+isnTTj?=
 =?us-ascii?Q?GudpzW6Ho4SxfyDu89qvKBTutYf8ILsyKfqDyAcIubmuJpld5mNb4z/HdbbH?=
 =?us-ascii?Q?1S+j/miVzqZq/BgGGvg0zbcrr1dhihv7tSwoc/DTgJ5qvrWp2oxhZqEVh+sr?=
 =?us-ascii?Q?NAH2kcJsI4StiTHv8+2Av7QwH67zLcpUX6jy8pjABXeLuVzYsmglYbNx1JKr?=
 =?us-ascii?Q?nClv0yfms6xOWrH/UuZBXZ97X9Tw7Op4tX3AukIxUun2Nmyi44bIpryj4f8/?=
 =?us-ascii?Q?3EVj8nC0birLzOgoG0u3EiGzkgKO2xMDIAneJ2mkyzuykEHNkiZgw8lfeDkZ?=
 =?us-ascii?Q?pRxzOkcS/P+MRJ0dY7xptlow31sa8RFfIaoCbQf/HkzF+S0HbrESjdyarTDR?=
 =?us-ascii?Q?Vi4DNe3wvLXAtQSWkcVOSB2CYzEBHNzSg3ILyubBtlYt5hECFiWgKTg+2auQ?=
 =?us-ascii?Q?5pemxWzDMdHSK0cPb0lpEbutUER+BJAu8GBgkat2+UhOLl7ZOm/wGvc/4oY1?=
 =?us-ascii?Q?L4nbnYhdIpDTYOb4O7V57loSteefdKyo06yng8MvSkwKrs1SkNpkbBMq1kAP?=
 =?us-ascii?Q?aD4V6yzjiSers9oQ74nG2/JDBTpY6AHoDyn1/mNSPChZGz4IAL4KBNx2q/vN?=
 =?us-ascii?Q?EiiZS+h6kJQngc8tAIVjQ2FPFz6aTGWOOGmDUI0o8EocmedFI5ospocuv4lY?=
 =?us-ascii?Q?Tzi0LCusaqce8pP9uCBQHE7kQOChBlcm4tmcFHR8sjxenAliBQ/Eepl6BGVJ?=
 =?us-ascii?Q?LHG8bCTBfwg6Tr5fkiFhSuGkk6A8fVdWc/YyeMagjU3EpcYNITImd1rJUU2j?=
 =?us-ascii?Q?TyLuW9zIEfi65CeCSKtP5waCc2SyGSLQUz1+Zuoo1Azzr/pTb3Vj2UfLDqXK?=
 =?us-ascii?Q?aT1ddEZ89Bh0FHJyyQWGebCyAL7fELCduVE2izS3GZQ7hcd/stwBmdLZsHc+?=
 =?us-ascii?Q?ITfakLvWfg5cH8GK7AAoH+lCOnM1MuQNLKk++IFKIYSEEGd4AW+WVQUkdODC?=
 =?us-ascii?Q?BaAzeoPbzGWFuYg+3lvuyB81IzVaU2OEjdxKwxsgL7eO63xDHrC/0ybQd31p?=
 =?us-ascii?Q?C+Os6puWWEMLnzFN+Ju+S1Lp6XBoap0wxYJ6WTrHn8tCkpNqO0NirU13j8o3?=
 =?us-ascii?Q?tEHNIS9rLXgiWmplIZfbFmry?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d58a02-bcf3-4850-5977-08d8f06b59c3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 15:25:13.4545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfSJzXpyM7tx12x4DJUQYQ/JcVId82RmK1ZDh0/dBN2zbpzbW+DTRCNpEgCH1znB63C5ClXnZXCYXFdd+lIYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1640
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Offset calculation wasn't correct as start addresses are in pfn
not in bytes.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9268db1172bd..dc4d6ae71476 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2410,7 +2410,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 			after->start = eaddr + 1;
 			after->last = tmp->last;
 			after->offset = tmp->offset;
-			after->offset += after->start - tmp->start;
+			after->offset += (after->start - tmp->start) << PAGE_SHIFT;
 			after->flags = tmp->flags;
 			after->bo_va = tmp->bo_va;
 			list_add(&after->list, &tmp->bo_va->invalids);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
