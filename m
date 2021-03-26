Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFDC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 04:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FF061A26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 04:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FF061A26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C176E043;
	Fri, 26 Mar 2021 04:37:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D93A6E043
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 04:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXiAoqcUJTbktJ1vI3KZ6tu9eNVU7a2UPaLhocGFQ5+AW5flbIr+PoVJGNcqmU6uEzKbtJ1D2vFiLE5gIYaZU//MmY3JPM7ZbeUwRc2TIqWEUum53dq0GM7TlFoQ6Ny86Tmoz83Mp0DBzRQzEpMY/pxRkYOoH+d1bVxc8Kj2qmueU+pY2zdNqxLQf5c+/Ek3SberdVsItxmjEwYiyIkvTlJhPE+H+rd6gVYHSwcRuT+YjfZZfODK7FIGn5Oi/usE8XZcZFIA5vf0C/L+OjnGk0StrG4RMNCRB631Y6FfR/XHNSMFddRKvqHMRDZzqBWWjPtb/FRDAEYcIf7TELAh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4H8OSuxZAe6dmcoZ6C76AM7ZLUbFlZa59MIG27VdEM=;
 b=hOyxPMrwXHwzSWhqLljJTai61gC31ojVj+PIsry6DZK5F60kBIlOYaWBAlwnQ9RKuRemdHtkmhweZGo8RH1qlR2/jT0kkdjy+NAM8Ncj490B0hjdFP0j0Iynnt02n2kGYDbJvOcxzNsPw7uGwVKn5YWAsBz3wPVpU99IrncHoG1s/tUFyfuWj/ggCQSlKYfPts8anvbik1fPPoLUxYkhQ7Utq3d0gBg7AK2m0AZ6cxrn4Z8PvfVGoXy7bI3YtfDQqm+f1lPid0jRxlWYq6tApdzHgYkvshA63bwCM04FLMdTHlJwb7Hshid9RZVsq5VEbwEd9y5Z3sOr956R5ys+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4H8OSuxZAe6dmcoZ6C76AM7ZLUbFlZa59MIG27VdEM=;
 b=ly1MYQO0DVqGd2PU65DVpA21f5hDdLbYHjlzw1X6T3hqGWEwseNkoy5WT9pLPQHh95HbOb38/iUxwoUJmy/Npz8HJsyE36MshQLvlzWh5AQeykfAz4zjJcYQzYh77DutbNMBkbiuzdjL+gqZ0pLa4XqephX8lQIBmZQy478S3Tc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 04:37:48 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 04:37:48 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Date: Fri, 26 Mar 2021 00:37:31 -0400
Message-Id: <20210326043731.779691-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0445.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::30) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.18 via Frontend
 Transport; Fri, 26 Mar 2021 04:37:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44946baa-d151-41ce-9e49-08d8f010e894
X-MS-TrafficTypeDiagnostic: MN2PR12MB4080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4080F3A246D75C04E66CA911F7619@MN2PR12MB4080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMGnaywYnn5Qe1jasqG3sSuy8x2DQoevw6RqP8nRnzXUqjI0FTrzaP1u9oNEWz13ksFcF+ebpvgsIEmzrC0q4rEW7pjAZB8mmK9VLKxWKDYAQ21ZnTg1BM6XOVFnpF+E70cD660lUInM/kfnCrnru3L17OgEX4pjP1LCdstjCriaKJWKl5t7XM/8lO2SvMmxLGN1fYMGru/3WWKSWa1q/MJpgy7jC0gGkXzN0eloJsDpw+v7qaUto83T1ELmPoRoMes+7UUcrlhiL0+o3/l2rtntbqQNGDdVZQ8/D7jseBMtIJVNIeSjOixN5EbQLUWDKcXOhXryCM30qukkgYfRxyqFdtUSrv3FNkwsVxtQdm7pTeOhuK5jqXYVkwbZy/ebe8Ywmu91NjL5/4ACekXyUvc3EtvGw7DggRy/0I1vEC4DbjVPDAvnR5JLtuKa8g+alP4bipfV6b5NJk8j/m8aCPYmFnU/HvT7PW+yIbWBKxwd8doJ2uK9fTjtZA62zfSGIAVDWyN1knEIuvINN53dohiVEiv1tStCpC/oLN9HamwPjRhrcKY7uqEV+ZUtqtI4xO0UjrJi8GFMOJaEsYJERWHHUHTWx/UZB2MA2sgj7gzaK9C7C0eKUv9r3akFRYgVhNEIOiwBwXMipPiq2u0KxDA+IeJ2nzzpzYmicoOpa/YHXPpdNEyUUOrFNWxDRHFk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(83380400001)(66556008)(66946007)(2906002)(316002)(66476007)(2616005)(69590400012)(5660300002)(38100700001)(16526019)(26005)(956004)(4326008)(186003)(6666004)(6486002)(36756003)(8676002)(86362001)(6512007)(6916009)(1076003)(8936002)(478600001)(52116002)(6506007)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?er/QPQzKQCrcFoCVmp5GCaEu7vJ8q8pcceW6B//6NN7h1swtN5JXNGAKXRwB?=
 =?us-ascii?Q?jhoYpRZgLWzQHorw3AApsl5JFz/51pViT3I9b0P+VhObk8wPmCIDCCQwje+d?=
 =?us-ascii?Q?8RobQJwWpeNJh1vLaxzhi5EIPZLt0+81W21jPyIcIEDFedGtpeKS6sf5N1bM?=
 =?us-ascii?Q?nC4lrOqKmGkBM6MCDjdVdnTHCfBjuQQOH0rwEyjHJ/jQYwn3nhrenMUF/+C8?=
 =?us-ascii?Q?97+Nx9W5GHPzIMVE75oHEk4Cuw9Eu8DixRhmic0/lI03gGhIzwId7gnMhY1N?=
 =?us-ascii?Q?5aVM64o10+08y/iOMSF9q94ROJmzAD6oiT5E1X0/Q4B14QCAq77LYveVrexF?=
 =?us-ascii?Q?Btup1LOL6jpPRQSH6dBgmcjO768fQKF++wh9C1IuCpbRH+s9S3ppTLXGIwP6?=
 =?us-ascii?Q?IaUTwD0rkXDyzfToPBsiTW1Z9al7JtZSyRCoOeps4NFummZJlWBwYdM2DqRY?=
 =?us-ascii?Q?1K8CBIfgJFl3hLX7HB0B1QPgUWPdL3lFX3lUTPqawmOyghWN22FPtVHZVbU7?=
 =?us-ascii?Q?XG6X05ItkrETcqhGo/nr6hrYSgWfSfAHQed5HI6TNfUzbiuvKKSQjN+ENmpW?=
 =?us-ascii?Q?mdO/mHSsabhLRNq7Mdo9+bZvnwLB7fR5uYhyIvSAkTiHfW11nwtGjL7wFKmo?=
 =?us-ascii?Q?JW2LqE8rOr6wr1XSdQrioKhpwBdwwHG5X7OIImmWZp/2iR2tYaGwehAzurL+?=
 =?us-ascii?Q?VD9//CUC82+XRC68a1yKAubFinx+3DGUV1gL3z/Rvn3rX2dhv+eHySuVcgb1?=
 =?us-ascii?Q?XcCiXnwJb1iQZmW5YlKNfL/U5wfukuGkDkeZ4huPQyjYUj83ZHRimiKxje07?=
 =?us-ascii?Q?sBtX+G4M2PJ1FA24zqx4YyFAaXA8L07PTqsC19oEwa47eR3iQkXS7bg5yfE1?=
 =?us-ascii?Q?Hpw3FzDrcf0H1m2FLGL7Sbzlpg/sub4FpoT2UAZanY+NEOr+INd0H8xmXt18?=
 =?us-ascii?Q?OXIyiHvPiIT9nVPu/FytTAVU8pGmAcxYfGGxIug37T+r1wBgfg6itJf+/11U?=
 =?us-ascii?Q?HPr4K7W1Z0DcYbKap7HmEpUf3HY8UBcGYxY++22uGvBOYatIk7SGFQcBqR8Q?=
 =?us-ascii?Q?xBmCh0VGiEeV7C6EN/pRUSx9rSU/y+SejSSXdj+TpQlOQ+krzR8ypK7yEdwQ?=
 =?us-ascii?Q?oj0rQ7L1aCWXNpLG24yd2c2TR3wtE+XxbKY7dmExhSTio0yhBqZx7iOntqPz?=
 =?us-ascii?Q?G0cqISbEkmIiGAfYSX6Vy2Ce5/xaRHA2kKAOis2KCKdzf0U4XdDMFPpnCyqC?=
 =?us-ascii?Q?GnokNx2xckExegCowxJh2TeJj/5Aaa1mlNgt8ZmxEPdHSu2MGSaWD9CzY+nO?=
 =?us-ascii?Q?5BOmfefv9MO541/UheW6fBAs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44946baa-d151-41ce-9e49-08d8f010e894
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 04:37:48.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKgF/8RuIrFPqI/TluCNfyV0LJ2Xl5rvHUq2kvMVnhxNSYq1/BWeX+lQmYnqxc/0p1l/1dhZIO0nb+7RM9teEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SMU comes back up with DPM enabled by the sbios, but the
driver still has to set up the SMU/driver mailbox, etc.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d4b804c7b986..462917d4d5e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1102,7 +1102,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	uint32_t pcie_gen = 0, pcie_width = 0;
 	int ret = 0;
 
-	if (adev->in_suspend && smu_is_dpm_running(smu)) {
+	if (!smu->is_apu && adev->in_suspend && smu_is_dpm_running(smu)) {
 		dev_info(adev->dev, "dpm has been enabled\n");
 		/* this is needed specifically */
 		if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
