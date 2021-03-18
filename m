Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418ACC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39DC64EC4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39DC64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCA76E880;
	Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E9E6E880
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mROj0bfjVF2A5GSI3qEMCTwJ4GHAK++/RIneS+kIZ43eitube+Vq/wGzCIK8WNkWlSMbikNPcZ1y9BDN5ZEhwpSJJJkmG2g46yNnURCRP8uiZS3aByCt2M7NEmXy/8rGv8xva3PN9JCRs3oAwrb9n6WRkm9qj1p+UklqUPPd32nnk872UV/1Nhp/eOSS9sXKArBlJ+7juX1Sl0b37RaZab9eoWIXOnucP5TSJum2nC5mGii0cYwBIpCUM5OvMKahlPmAPwBGsrIIYe5dQKj82eeLa3wAPrKNeNZiKBuZmJDzYGFf1VzxsWfm6MuYFcKeQh6yZX37FioVVcFnlMBJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgohrXJ2rpegyaUIO6FP2aTtRjZt/sC1SYqI8vHgkdM=;
 b=BtB2H0UUubK60OqN1Ergx2Wupyd500hIwqbbCA4E62y5ux/PZrbOYd3ygjJJbehbt6mUP0dNvSkEscUHSnc+rPmJ3GgZZ2EHcc3nE2jwpGDzUZZtnAVMeQ+R3fvaqkeR1WyVl97x6Tp8xE2jnnflNomAWweewSaxX6lxt1kJj1igHlkC4CEhqdw5+FiAnVP+V6w9in1BDMF2ukHG9vNctzgWFGrMTKRr6r0AEXbpxkrL0VBqY/yIy/gx48McvPH74KM9FKlrcXrdqtOMiLZtZfkg9O1HOK5k7qQxbWfEbwpSLKDuWwE13AmE961iPgfnlUTWQJraaaqltJw8YjKJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgohrXJ2rpegyaUIO6FP2aTtRjZt/sC1SYqI8vHgkdM=;
 b=AAyS7TbmY05uoGb0EW0YMh/GarEmesDdWwrmmtdk0qkRYB24EnGZwSYzMze1+hldQ+dBxvZMTF+ADobrdwtFs0m2b0Yq28uQB97I8n9JPUeAgqfvcu15pVNRI1NFtvxvwzwC9w7jMwvquXow3cCNTrsFsDNS2evXUsKUIp227bk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:46 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/13] drm/amdgpu: re-enable suspend phase 2 for S0ix
Date: Thu, 18 Mar 2021 00:33:18 -0400
Message-Id: <20210318043323.3989-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 928fd902-8494-4e7f-c7fc-08d8e9c704c7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016DD2CC1B0EA6047823419F7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDnUbz5BiKvqNrgP0rCtlI+w7vUeyRI9zwuCm72XhIGYyhXhlQDtwwcBRmM58Y0w6J/VuAT4CsFw/HBJYHMXOB3H8W8dMacETsz7d3KSkW4s9wePqpN7gi1lC2SU/zT3ijKp5D8aiMequiZW3WNsodylRbX+d7gVzeA5KUSmuBhejGtbtdq6vmb7PJdSs/gjjb8fVLJSKxkT2eGGPcPzDhk3a/icgZBg+xRGWqBdxB2IPacoD+AFKJbd/dtZuUgoATqQ4FG0qjDnr2VZohHy3LcpyFwAJKKLuyAFU1u2czBYC7tR/lwkn1NgZoVbM0u+Zg1sRapCh3td3zMQJBwXBTDuSkHFQF+2TENcz/IftTr29sjENgDBnzrsb/YWcn9VPgLY5LGRYJhJ9bx9TWskQEdRk2a4vvsXuPeAQp+nwLlLpPnMfMnrmJLMZIdek/FClaal4L86spngW7S3ps5Ogym1yE1fDkOuFae2QzpA0/AxBEVxcR09845k9kBQjykYS47KqQHtQgeytM9vkmEPSOg68eZHMlpvgzaoJyjRmuG3AucVFjZ2yyfyNk//xKW1HTuFR5zXMn/7QYCT3sQmfuMQWZ+oXyNYdYlUSRzKToKzQbBWvw97sjU1bd9uQuzISKP7ucJVCQ4VM5RONdAcMmrvygQ8mMcknsOiX6+KCCtr9ScfSUk6dh2a9DvTci1nxU2niFYA+Z9dlwVNfx4lRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(15650500001)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007)(21314003)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EKGxkSC/lj6TyyZktKFVyc3l/dx6cH05dLKyoIYeOW/JT2UMNvFQOwiXjcyU?=
 =?us-ascii?Q?iTan6B5tf3HhP2h4xPVzXyPhkKSdV1VWnJpMW4CIAj9dIN6q865AcrRn+fZk?=
 =?us-ascii?Q?Ex5YsOxIJKpI9KnVtPpStVrYTgDDYZJGRfs/Z3hchzCbHyyr49dh4nLL2SxH?=
 =?us-ascii?Q?zCxAA5290ewIe/BKdW38/oBDa1Y2tgaB7PHaA3ky9SeVXfG1JIgxDEYSAjkz?=
 =?us-ascii?Q?e41sFnpx/GuUcPh0pgwGgDYAYPaFRa3gWPGtov4YF4GIcEKf01HQ5SHXXaf2?=
 =?us-ascii?Q?ZcCp+q7/cE7RWjOIablQp9Zqkf3fTMU+wfiBkrXi6xKCm/B+zjJpS9gtX7Rc?=
 =?us-ascii?Q?4o44BZ2rYG9KbXxOvz7tbuYwdU415YQzhGxk6BNlJjkczsPazzLZ9gysG1bN?=
 =?us-ascii?Q?/qsFxJymq+NydSZK/4M0vJOfnf62+mb2sysK4VQTBzUTR/l7BxyzecKhlkVE?=
 =?us-ascii?Q?TvY6Hi53IzqNmV1AJR6EOjzO1FOSKD7VoA+QOGrk5UU8Ihss3pM8jecu9B44?=
 =?us-ascii?Q?P/5NDcslP22T4zRg52v7jPlKIMTkrImO1hGcP+cBuFkSuEspt88ZgN+uw34m?=
 =?us-ascii?Q?m4q2etVXvx06PUV12HulAPcukhMEr8xkwJI4L0GNZ9ZPSOY2sFtxs8d8Gbx5?=
 =?us-ascii?Q?NmZVcZ3tBf+I02boNRmjFBdOrVBg/6D0IALYHjGC5xyMZejcXi1CE4HhUgQc?=
 =?us-ascii?Q?MvE6IY9XBSOs8H0M9nytDSJyqnAWyNiJUut6to0VB79WaTNhSBGal0Lkxoqp?=
 =?us-ascii?Q?8uKbWSJ5iAXX7SlLsZBoB4mi/rDxRikeslbGSl4gyVc7vx9mSytHAn/twX0Q?=
 =?us-ascii?Q?hHfdPdZfjRaBaedrNUGSydHSeQpfdjQcD8+6Si5AkTXTDW8kn9y+3tpv40Ws?=
 =?us-ascii?Q?wnjKpKaGFEJF5eABkHE9FB6leiNrZM7s4fWpGF1TAWUGa1xL1H2ZR4IJ52ZG?=
 =?us-ascii?Q?lDlkecDnL1Sz6V5I/tBtTrDGoVUfVAPi3zXxJTS6lwpRBp/LxYF+0naklu4B?=
 =?us-ascii?Q?zFjS6RJHmTz42q5I7Zr6Dc+QO7xDK7dCEoKFCa1g1agrpHVXqo3/ByPr1yrk?=
 =?us-ascii?Q?+nS8AVkdWXzpqDmhfp1U1PCOM/vHjTPr/ltjq9U2orVqA9PaanFHD1TW1/ru?=
 =?us-ascii?Q?K825tQjuJrPINNNYakdRFZOIDq64NCiSAK14LOIetgzQhzEpvq8pLS4PDmP0?=
 =?us-ascii?Q?ksPsNSkBNQxoB9CzWwrf9/HMr+sUheytMexl9RgRCJauNwpypD/O5gp/wa/x?=
 =?us-ascii?Q?bmov5YHwtG7od5+TRa4kGr+k3+kv7dGLq0baMMOl/92eXVMTBqsrXo1p0IgN?=
 =?us-ascii?Q?2Knvjrdbu0wBQRPE03nh/W0Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928fd902-8494-4e7f-c7fc-08d8e9c704c7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:46.2413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et1pevJzZVvQZjGjOD5lhi6s+tAqU53gs+G4BzMLhTiFS6cU0UvzNNEq9LYj8kT0VcVFRgsvsjsdeW46movaBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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

This really needs to be done to properly tear down
the device.  SMC, PSP, and GFX are still problematic,
need to dig deeper into what aspect of them that is
problematic.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f34628e15bd..99444bd1f2e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2699,10 +2699,8 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (adev->in_s0ix) {
+	if (adev->in_s0ix)
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
-		return 0;
-	}
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -2726,6 +2724,14 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = false;
 			continue;
 		}
+
+		/* XXX fix these remaining cases */
+		if (adev->in_s0ix &&
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC || /* breaks suspend */
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP || /* breaks resume */
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))  /* breaks suspend */
+			continue;
+
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
