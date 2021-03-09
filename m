Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62843C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 16:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FCE65237
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 16:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FCE65237
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7026E41D;
	Tue,  9 Mar 2021 16:46:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21A46E41D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 16:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2DBommiwPZt9ZY6bZdv1nSIusDaT+jek67mtlBO4PeaYgRXEi9LEht+OxY39mWsNIDv47QyFTZ6KUjnybiXILC2egSUuCVsfX2kzimCXznlwWsxRVXxmhMwLbzJ70Wvs18dQR0vmbCdMx/HWpWDP7UdsiRWd0k0ZT/O3tDBxWinYm8OxEraXDspm3dnAD4PR6+q4ZZsVaBDi/l22fVvDefJs/lUXvMP5UCz02TthgA3mZ//4HMfTSHPpFv/PTz7hl966Vwt7aEd6DAOsa65Zjn69fL20FvsfifD4QOrumGoye0hV/Mw7UqB3WJAe+ALai7bo//f1zPzSXtLOcQOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My5Kbi/AFKMFOf6ZZ4z86Se/K6VzofxPLnJP/CtPJ5M=;
 b=mMX2z5ZPeIJ/UEzKbxeCrFnDSqwKXaoVWLOTai0N1awVmkmPvHRzbgSZZCKB4w6DmgLM3rPEhTT5Oz2aDzSFZr9LAht6GUmwTn7as4A3DWWWm8URfovqQG8AcyGE2eDAAa4Gp8Vtd098B6VuCFGAe+9Cf6nbHF85Z4LAta88jFLONjWVMoJPB3Lv7fvMYVQFYQhdWev7ewqgoNUAsXjvXAeDEVPwbQ3dwtOw8E87gDyambvZSZq5txSLAlWxFhCMIPeqJdwraDe7S6BCjx3UrUg6QAkutXOsno728qoDOglRlPSu7EktqaczaGO/GIKAs93J0fU1Jx57P1sNrr7EoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My5Kbi/AFKMFOf6ZZ4z86Se/K6VzofxPLnJP/CtPJ5M=;
 b=eRYQ3eC1Dmfyg4jWn4Z4ulQfudC09l54XIyAwvDqbds8dVNYA6S0RP7hlciayNbOzjLwOWRTcg948JBQQgZohUiQas2K/5l0nyfkW600dm/wr3M0KjRmQGL02+oEzh/qyoWBg1GMoWJhy0KTQYgqMSFLmGP+d0TbbaZh53wVlLA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3481.namprd12.prod.outlook.com (2603:10b6:5:11a::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 16:46:51 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136%7]) with mapi id 15.20.3868.041; Tue, 9 Mar 2021
 16:46:51 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: During compute disable GFXOFF for
 Sienna_Cichlid"
Date: Tue,  9 Mar 2021 11:46:35 -0500
Message-Id: <20210309164635.290413-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::32) To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 16:46:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d88d3a9f-c7cc-4d28-e7cb-08d8e31aefdc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3481787685E5BFFFCFB8D6038C929@DM6PR12MB3481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:356;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dF1039K6YkDtk6oZ1UWvGsH945AQDSvCPSqAfS8qt0YsqfXIA+tPjNckPuGM09MSMsYhfLC2miX2agsZagQgMniFnDntxGLJZB/qN97BQmsdEsw3kjGuH8scPuPrO3nq5FYZD99YOG/l9bLQxi4ibQdYpTQvV4KepC4uHyqGr9b1VbwqSJS8g4wUmsdV10yM9MmTuLRqzHM8MHtk5JGAjL+OkCsN8PG4IMoUkrixaY4U/hHhg22vKLeyx/jj3IcscP+8tFsX9KpQyNJUXUAtIBmbAo8XrWWiGk2y33Tz16Whaf3TdI1y0kX23UTrFG3R8z0Iewhfbd7bwBGmQQ+l+fx0vWu5tZ52uOD8F0IV1GPcIap44r1AgMkH/orAvaDh6tZaQmN8zYeEGCIxTXuzO+7QsWhxEKvlG3tkgyNMOJAWop+2ih/H0WeEoxjV0HLK14VOWOnUeRYBHeg5rKRe8n1CqEroTGZyHXtaQ0akvFUp9P95iSkP5p+VErjYMfS/yowb3eJg6492Xxf+Rms6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(36756003)(6486002)(316002)(83380400001)(7696005)(52116002)(2906002)(86362001)(6916009)(8676002)(8936002)(5660300002)(66946007)(4744005)(1076003)(478600001)(26005)(2616005)(956004)(186003)(6666004)(16526019)(66476007)(66556008)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GieTjCc0huOXMaa+OOs1aqx1V/gZOVdN/ZQdVkhTUdQsOIPps8klofITy/WA?=
 =?us-ascii?Q?sbYiEd5h8wZsEVNrP8IbDdVVgdbmO7QIbmQgdSNlRI/OBi+g85moKFLeaujW?=
 =?us-ascii?Q?KbyJZTFWJzzvUB4SOoNEatTHC/Si8lblKJ5crM5qM0ynIMqwW8sk1zSikOfm?=
 =?us-ascii?Q?FSUY1a1IZK0ZLrQaeO18J5pGQMRivlpMws7Ons83zIavkzH6uxn26rYc7mRh?=
 =?us-ascii?Q?IasvzTFzDdiJEqgPXNIkhZAr6erLcW5yLDuLoCNiDktetsj4TloaQ37JZs+N?=
 =?us-ascii?Q?l8e9fT5ewv000Z2QtpCxyB1qMym6kjVhmMCtoK1AwWTiwkqb+WckGiCXVpLe?=
 =?us-ascii?Q?rTFNbllkx+NQuWY5tEBlhONLB9OZjgE3Z2YdGQhZZidWOfjOKVpTEJQPnrB3?=
 =?us-ascii?Q?8Al24Wsjcg45RVIaNDZBT1wQThBr8tSZBWmKk/b8eFapc2wXp9cwfRkhzMMM?=
 =?us-ascii?Q?ce68VyKrd8AuCgHxGOgKvAsKDpk/tRT6EjBfDTwrGWkrrhFXWZeNLWFQAZU6?=
 =?us-ascii?Q?WyH56IEAmzGtylmioaunxhgCEnvTUecORXS4Nt+bmp7ZVbnWmUKoRhujpK4x?=
 =?us-ascii?Q?RSbvpR/an+J92OBjnvW6QZPGEXihosurV95gBAlZQrc3ODDpCH8saxRooAsD?=
 =?us-ascii?Q?BquEkwsWR4rS2iYj9BS6p5GU1ORs2KU0b01dLXVzOdPAZDLLtWy0w3UlSEOq?=
 =?us-ascii?Q?dn6Km1C6Jofq9X+36CayEYyKkOASqdqdT05Pb/p+aM453nqzks3rgug9Tx9H?=
 =?us-ascii?Q?ctgcsHIIU1gVqwOvjJ3W+B+2IMkULjO2cmo6RNsGITncJAImTj4G6ySICJJi?=
 =?us-ascii?Q?chIu4rBRCp8dVlvpIAPw3gK5Hzzlwj8GIGV1k5V6HFDwapscqW8R0uDFzf+c?=
 =?us-ascii?Q?vP7BwXYiguoP5kVFxF2q/gAw93QO1QVMHlfv/TsRGBlbTnNqPQIufHSYEem/?=
 =?us-ascii?Q?vCVLW2TB01QhQJ6Zo7Js0mU78inWz4S4570mIoxSk5e66P7ArJ/sBmIDx4mg?=
 =?us-ascii?Q?In42cDftE0/lJlZpcq9BejHJOa6iXH6gJakww1WZ0fCH4uSD5xz2e0GthmOe?=
 =?us-ascii?Q?GC8z/PokUSrEoGqAJ9uTSLFqlWr046nlPGm3dlz+ZKMet95jSq+sLE1UpOdX?=
 =?us-ascii?Q?zAIVUJDQObmJ8OD1WYLh1GxN3gv59DmbOOC/Kjx4Hr8IPS8O1pZHMQocdSNe?=
 =?us-ascii?Q?T9InPGUblZIUHFZOcyAxukyJAOmJPx/C0fjK5lwBHIWKiVhFLF1+DDkM3Xdy?=
 =?us-ascii?Q?m9ARPmhqeRgOO+409v7I2mAT3cnyEdxZ5skRWVT9NLqaJAZrgBAIpuAC2VT1?=
 =?us-ascii?Q?QJHQMWKdyK5eGLrsPRdoWJpt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88d3a9f-c7cc-4d28-e7cb-08d8e31aefdc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 16:46:50.7780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f65s7VZuVmli9zXRnju2LLyVdYCRQbw4tBhhEJK8OOjc/Uk+jGkrW7wuVvgBvjQMw6IGWca/KZ5A8wtsw25tPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3481
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 73bf5cad2696fe3a21f70101821405db839ea18e.

Fixed in newer firmware

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index fa27262b5c2a..1c6be53313a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -639,13 +639,6 @@ void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 
-	/* Temp workaround to fix the soft hang observed in certain compute
-	 * applications if GFXOFF is enabled.
-	 */
-	if (adev->asic_type == CHIP_SIENNA_CICHLID) {
-		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
-		amdgpu_gfx_off_ctrl(adev, idle);
-	}
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
 					!idle);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
