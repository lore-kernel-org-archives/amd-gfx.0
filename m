Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F20C4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FED64EC4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FED64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E4B6E887;
	Thu, 18 Mar 2021 04:33:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C8A6E87F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2FvaCqoVx2VMnIyZimVAPd4mygYWNhNFw0jretnU6PFHhSbeMmhf34J7WiVpgemrkjOW4CmLJfB5JzLP4Wxz98k0XGJkolH1YEIb1zhdLugBbmrkx2Orly3DyKt1LM8sDesqhFbVTZRo22dCvykfEg7y0JLNtI6MM+9Q7WMQUNcLJpUvPX2UmZAEFwjm9gz6eiWUONPbcSfsHa2ZNxZpCLACYiExSZg8yemNQ5LqetOCr0R/klEEZmoTF7cDugqJskSwjnBewWM68rNumVsSKCCk5Fh7gJsqNSkMCfrrAvZUOqhZDCHrc6B7Rko/pema3qYc6loPwiz5qgJ2Hl1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWVoroMyCRaZLLZEKuTaWWriuJ0AU4CyW0z/Ov69/pw=;
 b=VIKguCrTupdqp7TPjCXZ7rNWmILLtvLc0rnJlOD7euqQsuiaWsTO37TnyH1ecIhbXDeh/ske0rL1Xz1Vjt5slG+5Xcl/0nHkd/DW5Y+uN0XFkHyBa4BpbgTQtogcTWeoLRA93Oygb+o9q/J9RMrZSLA37bdc5VKyn/XaCEX82J9XBUM0xfZSMOzt99z6MYcTMXVLAt2NK/D0A5eQvihR1yL0b4FCFWtxChWASCwijIl/xnIr9bp0BOhnl4/pvaDPlmFXtEYFlfxYiAogptSkCB49l4jkRC6uSClM1NvIDteLX2bRe8uPWcYlXKwgyivkhfmbsFw4tghs4TwIHhPtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWVoroMyCRaZLLZEKuTaWWriuJ0AU4CyW0z/Ov69/pw=;
 b=ehKEm7fG8QsXsbLnT80AIX+zWx5CDeKUiv0aGKtDig78QMXvAUk9Jgl6hat3Mz0lBveesbD3SMvomsp8EjUkrBv55brErbeIXQrjH9ksHjOKahCCwlZEIEpuTlnmnuyRUoiWw2GuFz+4+d973q6ofpEbbENQL8XXus3moNepv/k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:48 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:48 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/13] drm/amdgpu: skip CG/PG for gfx during S0ix
Date: Thu, 18 Mar 2021 00:33:21 -0400
Message-Id: <20210318043323.3989-11-alexander.deucher@amd.com>
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
 Transport; Thu, 18 Mar 2021 04:33:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49c2e2ca-fcb8-477c-1b53-08d8e9c7060e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016DD6A2DBEB00764080884F7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6xzD10fDk7vkBxFCCEH98c53hQW7WT+XIKCcTWlEEyGMSisqe+Pbh8vTO+K8Z1sPopy0wfdnMivdnlPNSjUrPseH5SDz7BzLh2WwiHXi0mI7ygvTNuhIuYhXCPx/qDe0xYh4AdyFVLp6REgxL7Tv9m+ijw6QFF3Y4rSLymrD9Zf63vSvM+oS1ovnBEwpj530bXJKS3KRw2rLTk3AJpO/QikVfYlo3hvyF78knb0OXD7Ho4xfa1FB8LV7MCSY8l3HKIquKfSOSKC/wr0QgKyfsziTdmzujVMCa97mKwa8ZuAKqg0X5it/QbfXHuGFDcVZaggOhR/UYh9kHrEi+zsxZKpLX6OTEq73PdWbkIjlqpJ7y7QHWLtChTkneiKc2LZfzZqFoSg5syef2K61vpKRuy6JVrvE2J15XMZoqvy7ZSH8tsb5UIHS6bvwokeS/xPoRqAtbox6/jYn/fOucYIUK00WuCNbVB1rCWo9rp8glImioJbSsFXsh6oVAiEFBFg1Wx5TMMhcKZG31q4LDxxP3FhOaE/Y4yGQuLwyJOHc7KsPQLBm69C12un5kvtu+ToTNn9O6v/Dw+a69wUJagXRu5phYdTrTgFKSnKOs2Dq1icvXRitIAzVgDqZG9NGIoC1QNG84mE+APpPnwKcHv1aVAYxjfYwLkpXoqmivyIx1TH8j9jkYcpobfVTXjMxwFi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(54906003)(4326008)(6506007)(6666004)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GobIfj5VWblAI97SFVytzEKdjlYTbB0WWddz0nhCx+iTu2p1Pw3GTSK3WjgR?=
 =?us-ascii?Q?LUvVnZapCilZpztw4x5+Gfl6+/x9gVgJ2OU7wOftAKSlQT6mxSJxmH17N+Nt?=
 =?us-ascii?Q?1SNjd3le+Ys1Zo5zIWUqq3sNl/QCutX9g0oxti91drzsjJCSTcEDLskhaLeM?=
 =?us-ascii?Q?6yQmFkUdifKt3rxqLmAAt5DqhuM+K7LnkyrsL7NxLheJ/aZ0CVX1dlzLKsch?=
 =?us-ascii?Q?upFaod/rrXc0NSjrUp6FAUqKou9cage1yl3mc0dVDMoWSObqFXnKwhi2l033?=
 =?us-ascii?Q?88SPc3pgR3SiwZAacKJKJq4BnWwlNCnzP12eReYgk4AMqwbAg4H4SdcY3YxU?=
 =?us-ascii?Q?2uD48lDucQ72v2oXIVRJshuCZOfRx0MuGKBiuHpL2qdWVOesJmjH4CL3Eg8E?=
 =?us-ascii?Q?L83UGpWisLSuVI9DYcyEI4rjJTEbCA4fhKrLGZ8RbGzFk9jLC70BblpzfC4n?=
 =?us-ascii?Q?mrIVSY8TieH9pgMKtoUVW/GWJyQ4zsOQ1KhFne+SpiYrR9S07ng60ILXqdYe?=
 =?us-ascii?Q?cHMgZJODTtjztnvreVsJDA+xnoWXS/3rO5RrDI+esNqd4c9KAzGdsLJ7/v57?=
 =?us-ascii?Q?9OFHl0i0Pp9Ck6vb5qmyM6ZNiwQpwyVfOZKzTH1TzyYiaCXK1Og49GdqPvlz?=
 =?us-ascii?Q?EKyz4qVV4uziwHAtgHL6h+zM0O8EcoabwBCLNVTUH3D3omru3xkXCB0z9s7k?=
 =?us-ascii?Q?g/cKE1tn4TkZhP3djNgahn4TCQ0kApWLLYVD3o3F1qCIzJKc2u76FEw4/4CO?=
 =?us-ascii?Q?PJ+bGeepAZc1Lc4BLt1g5VeGm6b5mmjn1c8LksJgpvhxVw4mcRzrlDz0eNqY?=
 =?us-ascii?Q?D3LqC390zXVCwHMvhTVmHvur7/juZ5yRP3zDrvBKi1UqVPUkWhx99QwvFETu?=
 =?us-ascii?Q?WXhP4TfpSkLixGXhQCbOmmoMn6VPdoSbz25L7sE3v5ytp/U5t5Yd3glxyB0h?=
 =?us-ascii?Q?JQPCuoXASayKi8vGgUeIZKKMUa8vzU35DJJf8tJtJvyxjgEVnjKKhNSSE2+R?=
 =?us-ascii?Q?ALYC3J7tB/aY4qF6ffu4X82vpZzXFaJh+DYrfLKpAxldA8ugrdbmZj1TBkxZ?=
 =?us-ascii?Q?eV2LrDzyhrxl7CrfJI8W/Ae6ilAt++PP5Z27SsKxFo66nsJT4C5nyuCb3iSN?=
 =?us-ascii?Q?ZTnsVtfsNA5rpguubaF/9G0V1lOLSoDlPoayNm92pKky2YANO+Rr2HvT0YT9?=
 =?us-ascii?Q?7xh34kvm3Vg9fJzNLZEli2q3UdJ7TAhh587vI3Le7KVeaqGiMJFcgW6TbZNG?=
 =?us-ascii?Q?wO2a7GLkK1WpuOKReQwCCyyNcFxo9EPB7BLcPrWho3Qerb70dDdeQ9opVLlv?=
 =?us-ascii?Q?8cdqDuEYobXxwvz04JSF9quU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c2e2ca-fcb8-477c-1b53-08d8e9c7060e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:48.4516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHZym/WEw2tw4S5Wy5rpv6WJdO6DHi9tUlhUBdWoe5XxsPPIUdEH2AwnhPYg4bUdKCFxfxqWgVAkQovP+QPxCw==
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

Not needed as the device is in gfxoff state so the CG/PG state
is handled just like it would be for gfxoff during runtime gfxoff.

This should also prevent delays on resume.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a6f4b52ec796..de70a9917db5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2344,6 +2344,10 @@ static int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 		i = state == AMD_CG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		/* skip CG for GFX on S0ix */
+		if (adev->in_s0ix &&
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX)
+			continue;
 		/* skip CG for VCE/UVD, it's handled specially */
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCE &&
@@ -2375,6 +2379,10 @@ static int amdgpu_device_set_pg_state(struct amdgpu_device *adev, enum amd_power
 		i = state == AMD_PG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		/* skip PG for GFX on S0ix */
+		if (adev->in_s0ix &&
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX)
+			continue;
 		/* skip CG for VCE/UVD, it's handled specially */
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCE &&
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
