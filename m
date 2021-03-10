Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE3C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 22:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323A764FC3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 22:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323A764FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA5D6EA19;
	Wed, 10 Mar 2021 22:48:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B4B6EA19
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 22:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GExkZnxm5OFqHg7m6M4kAVR7CFVDUysUWMh3qu1leDlKbsEStuB8kakwfYpSBjHuaa43u9wotnx9dGjaA9ENJTMhqdBxXlpvsZ3yNgsxcKiSlSq5h+eDLUOuUWwgNXbasuhrnt4lYN6vCmM52H6OaXfP4mhscbKZIZCtxd/4NU5s7VkXBzWld0aun+075oMFsp5R+ThjC1toGdCO6+NywMKuHhdT3IOPq3jxWv+Iq08IEDsDVcUNpD28qVn90+sfB7GeKjBthuddje1ZpKR+pn+co+LmL8apNbhvM8+gLq4a8hvGwF5WYBQAgWXAGIrMdEA42DLPmebYSDUs6mOJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxGwFWLw8rDyALPgAfON6oNBXkg5rw9+YbMxgxTI+2Y=;
 b=PD2n9aD2rgMZ/9yHTFaxZN2Mdnmgp8jC37i+zHGO/xvHxmuB3qjr0QMRPIQZJyqBBKXEnFOjiq24AUg7g928ia7Em7FkW1A8UCNvwTaFyf1yVwU9uoZsDDqxBU8CY1HvQBn5gugRw5roNCyYrGDMgGAo1/xRjBoB3Njz0owljQ/xtu8JwjSZa/26WEOQuLVE3ffHeFr0ciWVmDWlHq4R0mVSxLvX4eGyKGTlvnYXIcRBev2mNxDVW/5H1tEWKm1oLhl+4c2lMag92fb7fnY7w2IyG03Jy5vBA6+LMAxYgVFpzRwO8Pj4Cmr9JrU4EJSGQMn3ihZP/D3Iqf5+vpijeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxGwFWLw8rDyALPgAfON6oNBXkg5rw9+YbMxgxTI+2Y=;
 b=I1uBuRG0oOuK1Ap0aXbOTSGsVb/uGNBh3pFyRtTd4NejtHaptccQuRseodz/oAn9zEq2LzgoCX+XyYwbiySARlvCm8NuEmgIabgjej8MLnxdsvtuIrxJvHedneb4v362dbMCUO4aO45EfDqB6/MZMhnkS7XA6M7eBFUrx5uDA8c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Wed, 10 Mar
 2021 22:48:18 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 22:48:18 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Enable light SBR for SMU on passthrough and
 XGMI configuration
Date: Wed, 10 Mar 2021 17:48:05 -0500
Message-Id: <20210310224805.10266-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::36) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend
 Transport; Wed, 10 Mar 2021 22:48:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1b45b41-a2ea-4818-a854-08d8e416994c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268FA9B99756734AB25DD89F4919@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r161ygneQ15Wx0KzSsffr3sMM/3pSVnaANpZJggCgnnN+CU7byleg5rGs84ljG+RDJU06c0D9brCqDEnl9haNSaaZ1ppCCdvwUzwEJn1FLOJrDl8xOAkFj4YwGweLTNAnAHFyPWEUERZsrYzi0zICDxLkDKqT7wnU2UJIp4/Z7ls733dOO50RpBlSeOzznVPqdJYL0LKdGiX+0R81CkhL2ain+EcWj24vHr7vcccmt4aHNbI/IZL5MIfvS+agNoDdOoVdIhUUTjKeAyI6KGVfy9tyoZOvTBzocwxjXUczMOvOjJ/Liu6AJ39XBJtgMs/Gq2yrkgO/cae0CrsPAKooTkddFeTQAXwBin43gZAK98EKO81xtF+qkbqaz2E/Y7CeFjd6pspYTy/gqCC5vHWE3wE5qRKxlvD73N+azi9IYkWLB5wCdJRBu/lYsk4nimoVtS93vFBY+qIg4FSPg4CdDrQevjrYQVcq8hFzHY+eWOFjRgd5SGla28Juqcak++u8ZOB1h915DF/blslmf/Uo7yLQYBF4LeYsUSNxNU/wvTsPsqg7as+tEGBouTKrjr9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(66556008)(66476007)(2906002)(8936002)(316002)(6486002)(16526019)(6666004)(186003)(86362001)(52116002)(7696005)(956004)(2616005)(4326008)(1076003)(36756003)(478600001)(8676002)(66946007)(26005)(83380400001)(6916009)(5660300002)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B4GQMThf0MepE80zRjaSOctG9OiD3HSb68dlYZWyBMPj3VI3zK/AoNyB0rA3?=
 =?us-ascii?Q?1DQXfwOrOqWBD16oFY5xF904vnysvsqJpWPNjAz1XeuJSDRpYeqMxGQCWMwu?=
 =?us-ascii?Q?6viCXBnlBlSoC3aKKK29UQH5NLpeTExY+PLL7NiP3p67DpwgcGc0NEAKjcca?=
 =?us-ascii?Q?2gi9WMAGamkKyQEPh5ukXPT46mXTD4k0VSmeyqAcpzotTkohyufk0hszrB0+?=
 =?us-ascii?Q?5F2Y6vXaJE7RStdbUf2BvfNdqtoIoBsaHyo27hHsT8JZ15aZNY3RMFneDxSZ?=
 =?us-ascii?Q?8yDsEiVRQx6CWNi1RWKOWV1nmFe8GvEikkuLZHlWA+tUL9llUEtSdPUHBYk8?=
 =?us-ascii?Q?WayMzUx7ZBcF6NPTlMH0LLPJX+xGUDsuf3MYvSadwE4iCaKoyJ4mJpeL++7+?=
 =?us-ascii?Q?HEos6s1nx2YssakC6yzKQnAKAgGIf8bdLXT/LeUyIzRbmhPvbiI9NY4n/9hq?=
 =?us-ascii?Q?M+A1hLTAUPptm9rFSpn4NpiFJqKai8AcD5blDHkTyf5BYNbEOXJdb0by0sgO?=
 =?us-ascii?Q?0o44ZgLY5NVakbu5dIT/tahHrOdQfuUPxpGFOSyU593d93yXj6Mr1qGc2OpP?=
 =?us-ascii?Q?qhaoD0wqkO6o1a3sVNGsUS3y9Ulunwjfxt+CjUjYIzJJAxk3swdGrIGjYxco?=
 =?us-ascii?Q?0+2knqIdHxmWt7lRPm3pouzbHRJeIV2xP88qpohtbEeCPs2yRTEl0XMn3yEf?=
 =?us-ascii?Q?3bka1Fe2eAmC9jhYL2TDW4DcfpNNogIPDCaxDIxELPnuCJmKYVpIYk8ZMxaV?=
 =?us-ascii?Q?ZChHKDV3So/4Ex7xzT4qWFewzxSLQYbvPjtvXqz0WjxQ5A8OSmCt7d+DO5sX?=
 =?us-ascii?Q?U9gFRdSTWsHVN15wYWRDqQZ5EZd9rhC4m1p04mhApJR5hBv9WC/2FNRvwSP8?=
 =?us-ascii?Q?9+ZWyN2pNOX/1Qdtw0RBnmp9uCcI8ZUHGLxEXmuDllxAncLcyblsHKeKpPkF?=
 =?us-ascii?Q?6D9lmXhZy8fWFnrrU7Zz3/6ihqcbnnO1tCYRjiYnC/fbhTEoAJ++BMxrlc7A?=
 =?us-ascii?Q?MI95ia8xJ1iipZCop8dEQ3LSEqp/y4XCGirpaxwv2M3eNqnhZYJdce9Cpi14?=
 =?us-ascii?Q?KVHo9MYRLn6160M5QV3vkMRkT7+UGgjSIkuvpCJqa9PafyqxPsnEnJ/We9eI?=
 =?us-ascii?Q?T0zEDVcvYUuPTneEWECRzKbnwyKXQOhV2BNC6W8XC/l47utHJ5P2QSExb3CB?=
 =?us-ascii?Q?VxI5LMrX2LzUWj1bE7akyQXoeHGivVIOfDKesnk/Qp7MFODKTGi0rKybdMey?=
 =?us-ascii?Q?wEByFpZfeARi1fUIu+S2lVlZx2P3uxrZBdJ+AcGMqPXGsT8unz4fVKKs0L7A?=
 =?us-ascii?Q?N71+bGRQ/lTt5de83esCPzgN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b45b41-a2ea-4818-a854-08d8e416994c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 22:48:18.7914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61w678fKl0jkpkURes66HHDwvf395JabzDH1QCE/l1DS8PSzuljWbHEtXOzQbadSXa8VQjL6HHwvW3Au9LXr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU introduce the new interface to enable light Secondary Bus Reset mode, driver
enable it on passthrough + XGMI configuration

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I59aef0559aba418b764e7cf716b0d98aca14fec5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4640cafae619..e142b4080976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3630,6 +3630,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	/* Enable lightSBR on SMU in passthrough + xgmi configuration */
+	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
+		smu_set_light_sbr(&adev->smu, true);
+
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
