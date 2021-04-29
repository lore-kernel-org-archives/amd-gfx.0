Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F26C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 18:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9C06143E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 18:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9C06143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881AE6F425;
	Thu, 29 Apr 2021 18:34:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C646F425
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 18:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3jaKEf0uPaLwSPW946+2MQC4e6XaLOW+U7j9ELS1cjVtSFztkSnBcCtydi0m/k+9CEoyZt+0l+l7z1FquM1T969olrOsCXDmkF3wn3/f4NKJoUm+6HpfFMqLfa++v/folHmnH3jLWC03pxyWhddQldXtBJEQ5yIVZ32N+v3SEb3bDdMs7orbHuDwxG8QEROxKINu+rxKHyd2X8GzXdOp9Ph1uodABo+FEX/Ub0/Ng1RfmH+GuBHLXgEDORiBXlopJXiu/drMkavWlRCs/qMIQPzkDYhjDEZrlmguumji6slFi6IOMnUjSqLi9IEWKFLGqqtVR1v9P6e52exh5eElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAXlNjbHS7uG/91iyW4LBOjLxKrsyhyvpG4mj6UTJss=;
 b=PaIpKcklMktG/HupKVb/LflZdxVuTy2UZpXfAWtoyqYwqSAY6oGViCua/z4FvbmggtuaK2xHMWj8y+FL2i1n2nu5JUpNu9CO7Fqh2xEYShre5dlrpdjKKT1ZfzeQctz7fLCiYe1nMvCBRtAVpL6JJ1PGzYf10as9uMnxRWx8LC+ZT3eiGY2o9PSVYjRp44lVnKmJYMTZ+bfcJ+O5KzqPpuzJ/mdAb3tIcBnC2kh6Vx/Z00WvV9fcZavaV/Oy0o8Kl0pMV2gKfmQyM3DZQgeNQzD8YcSoMvENFxuhuopR0C9NCfkbkFnm8fqa1ru/dyJhFMiAKz/uUl6QgTeY6ecyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAXlNjbHS7uG/91iyW4LBOjLxKrsyhyvpG4mj6UTJss=;
 b=gz8/JXB72PMhK4j5e4eO8hwnOneT63LhrPSKrN4zCiNx71PNQ9VfarTRd338jzQsh03GMZev8/DaRhhCUENXr1lJlqIsrFDrk0qkEbrkHIhJ/Ly9t182rVeNAikkfgOz4CUFGd4Cvr13nAODvg7tEa4MUewT8hCPARQzp2WaErA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 18:34:26 +0000
Received: from DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e]) by DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e%7]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 18:34:26 +0000
From: Zhigang Luo <zhigang.luo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran
Date: Thu, 29 Apr 2021 14:33:51 -0400
Message-Id: <20210429183351.17914-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To DM6PR12MB3308.namprd12.prod.outlook.com
 (2603:10b6:5:182::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Zhigang-WS.amd.com (165.204.55.250) by
 YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 18:34:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7d4d61e-3ab8-4109-a919-08d90b3d6afe
X-MS-TrafficTypeDiagnostic: DM6PR12MB2857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28573D824231EDF17FBBB7B5F15F9@DM6PR12MB2857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHNXJet9PPTC2uKTphOorQAigzR80ZM8X3rSOPeuRjskUhhBmeAj/iPTqQFiJqvtCyfWdafaD+kr/sssFETomQyt2WKAMkfGJYAqRnOKhBsFxDyr+ioh/cdwTC1sxLxqi3MVBUbir9vIkjbl0d6QA1AUgpzUf7pyG//N64J8UWX+yJBYWHNQo3KaDDntWe97jk4oeA1s0Z063r20q6fUN7wuokTtPeoCMDeWeWjGuULyuw5wSu9PcdZkPyA3Un1qF5H3DRPMOh2AgS99pWoFpGEEzrWTVbAS8iJGT8ZhexNs9kRHWI5TJjyBWIr2FRN/HCHJuZ6ZiunT8ju7tc8C9FWEgK5yOTGj+t59pW5UzkkymtpggQ48rxsq/XK9vSXxQGeYlzU02opCihX0VcTd77c3Qj3cqIM2o/dxZAhttYssm/ABjAVcrrlkBeFcmiOs9rPxOQWg7nB/MW52jZct7TubbHfqovGhorBDkJiT4Bqmr1pJcpRLI+mEi7ZUAzRt9/N4EUPmepN+7uyCedzxFr+/yhk983e1tumMx61vjMejFOS1xoIXZEvpSDzU/yTCpRVFjvp9vYEIJ3TII74VpJdKcAQnlUoqhJWuUQ/HRMUWbdUDKBtJks9e6BhGWSOL3hZo+kJhtH5x82FcJX/Rpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(4326008)(6666004)(8936002)(2616005)(1076003)(2906002)(38350700002)(956004)(36756003)(4744005)(6486002)(7696005)(38100700002)(478600001)(26005)(186003)(66556008)(6916009)(66476007)(5660300002)(52116002)(8676002)(44832011)(16526019)(66946007)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rZUusux8/IrUnXG5XS7tyvvGKWdxZ/Qu2pSWrkJu7+V2J8TkssEg74rh0GhU?=
 =?us-ascii?Q?d6Y7zUjqh6iAusAPenwErqP8ouzDiQRlE8Jzx7poJPziR5PU/PPVR8LW279v?=
 =?us-ascii?Q?e0nk5ZNoa2wyPMoKTDhir3yjNqHst89zPGKOSfVeczbRU5Oz5QeC7VR3axw1?=
 =?us-ascii?Q?pRycKTq7jzv8i1j0FOyzfIt4jdXjBhROoAsiBhwcso09+Ejq+tp4jtjZl0ph?=
 =?us-ascii?Q?2OfjRFhTqCpeiZMRKIAr5KLPODIKtYvp4j9F41Y31qy4yk8p88mjBVJ3MYQO?=
 =?us-ascii?Q?zuqg2uxWxvTfL+es+fBtzR0s+PQ3XlaqcXKXdizJQgKRsx1uJ7C8/mrwY7nu?=
 =?us-ascii?Q?FMndKru9kyiHoDt4NVnpi33suWRSTvmT0rAkReBkDIahx+uYDRFXUqBqzYr/?=
 =?us-ascii?Q?YXP5BGzr+xqSLbv/LJqBvsIMVoybC2eDaJ9ykxUedKIgcQ1Z3bC4S/1EIsct?=
 =?us-ascii?Q?X2NoJPR9JEvsHRHZ2SetAVdD/cse3MZDO4bRpoe85kswYo6StHhlfIEg3cbW?=
 =?us-ascii?Q?gUICzp3MnK3Kwtc7Am7Q/G9yKew1c2dX30C4VPZN3N43HZyio9w5F7e+a1yQ?=
 =?us-ascii?Q?FpFpdraHqflStwZWIti2mpuF+jb2HQLxQVYiNz/GomJv06bGu3cB/NBtjsDJ?=
 =?us-ascii?Q?NONWwvFPnYAwwoZHo6R7NYrtGDQOAPWXdlwFEmu3ch2CuKAZAUhDe2JYABU5?=
 =?us-ascii?Q?UAhSu8nX4pJmh4y7y57zQ7KU1NrBy4gmjAoYwpdz0fGvxkf1Tp0MMieXDy3n?=
 =?us-ascii?Q?t4RHKUtR7GtbQh8K2b9PvaU++azZOc4FxEhp+bQNnVbhLSiUPOl4HFfI6JH2?=
 =?us-ascii?Q?nQVvnGsaD0wIMrXG7ObMO4Q7z62EZ918Yh6QyELkm9M3rPmiLcZxlNmvoTS8?=
 =?us-ascii?Q?9M3eVp4nWaiO80Hw849mvJ8aXnLm5MaM+13yxROR+BacBu+mTSWK2BoNwYoa?=
 =?us-ascii?Q?FY1w2GmJR/q0z4vI2w7/PmArIf7U0Y83zVAPHMfLG9Fi0INGlDQ6cELzTLCM?=
 =?us-ascii?Q?2v+nrjUgaroC3iOPy5F96EbPlD3n07hprCtqH10cYnt2BXpR5T+GH1ThHVkT?=
 =?us-ascii?Q?nfocLFozAkZfTP+ifiODjXv0Gqau9FSTA96RVA9+DGV0qUgpkQ3HXzegMgmC?=
 =?us-ascii?Q?RgqsPPM/lQUMHe0XTYrkBuz1jNkk/1N0iZuwLkgPW9K3bygYiFC8iC1z3uT/?=
 =?us-ascii?Q?y6VjtJsEm1CiKSV9jpfKhV+m+6hDpZSZTa3cdKfzsId9ptIL/HJ87xrT+VmK?=
 =?us-ascii?Q?hgjHu/yiOrpp5PcoqS/M6MqgJGswLSYW6qI3A0xLnThhTOnxmdu8u82jFvLg?=
 =?us-ascii?Q?QzJbhoEvb23/aogPDrFe4EmK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d4d61e-3ab8-4109-a919-08d90b3d6afe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 18:34:26.7339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SuBtDK2lyvLyDJEQBAOpCpozMs3vzD/zGU4eKbfHyMH3HiHhWEYi+fi8Ekg5gVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is Aldebaran VF device ID, for virtualization support.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0369d3532bf0..310e1249e64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1186,6 +1186,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
 	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
 	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
 
 	{0, 0, 0}
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
