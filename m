Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F67C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 18:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1509B20644
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 18:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GyMdgzkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1509B20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6539D891D5;
	Mon,  9 Nov 2020 18:12:41 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690073.outbound.protection.outlook.com [40.107.69.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB41891D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 18:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCgh0B1z8r/aJgGJtkPHJha+5CBJlDMkUERHkISEa/sxPeZi46pNuXVAnwKHYm28RkWEve+hs2xIlgshkANwbjuFYcQfmLczMHMxgg5lEjWm65iw//y5RxiaT5sf/oC/RdWd377kfs3goNJ/U3GLkmgFW3Rw1ijLzLuFUTosYwj5wYxosr6DHUCP8pPBHr7C0aXBX9qrzlvQG72I4FSRK6rqVuKNPsM0Ei+SPz0h+7glhghRp5hhkTYdO8MNjS8NMbR/wwbwlpF7Fh619XzNFHhjZUb84I3VD3hxkkfC3ScShEz2eWkAjt0s/VWj0A6RfvsM0u+4UmDlcg+k+PGXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EzQAZY2DqOphVEAUeedhfWMlmEMd3mohb/YODyPF7c=;
 b=i1NjmSP86RM/hofFV++7FiOYfTInt77jQkdTc03H0b78F4fXDxgo1zDRegh7PgPzlqRpf/SvQVL6DyUEF2beJyC6re5pLCrAgrGuuk+Pkmt0UQAamLz49ncyOrPiCjgNbflBPuiW+l4XgVnK1RE/NubVBcWFVQuDuv4Mrp2T9Evq41IR7UqeqbayFNzhJkK2UA/7FTw0hVutL+Q4aMS3Ahp+2VhOCR5ufwJEbzW7H1sYvJYEondoABLLWPVRJw6+dEKJWcx+/j91yNjKwrHoSPOo7nNxYqL9fU/TXbvTGFCKBQ6vr3ZWydK0SEOpXk7/QRtVS2a1Ja5Ss08JFW1S8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EzQAZY2DqOphVEAUeedhfWMlmEMd3mohb/YODyPF7c=;
 b=GyMdgzkVvjQL1li/ua1zfjIveyzni7YsNnLTf7TEgS39hGTg0yRRhJFsm4EaD9/jMrO6yLA/GY6a2fvh5/PxCjpb6bMfoUnBUbvXv59Fka4q3aZFQozz/0Y3bko5zOXBGazhW8M/b6R2ma2b1Xr1Q67HRBdbN3KosklySyFHGm8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 18:12:39 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 18:12:39 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm:amdgpu: check before setting hw priority
Date: Mon,  9 Nov 2020 19:12:12 +0100
Message-Id: <20201109181214.35540-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR1201CA0024.namprd12.prod.outlook.com (2603:10b6:405:4c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 18:12:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d63d90b-8cca-4e64-f2a8-08d884db0ade
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0090CC4A9FBBB1CD104F883B8BEA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlxpo4VqbBcHqEpEB7WUZdrhvKKfeGkEQf/sJj0nuRJdDo+SKNrWBJrd5/SOr48TlCiBoj8REoc8NywYEn6ar5PpmO3JJbAn/v3Mn6Sgco/qo+89LfdtICossAmyJ8E3DQWN3lRecWTcsXQl0mDrl/dLEiotrYLggyVS+2yzGpRB71KABwWexrATdEwbjzeJVLNyx+yWZmk/WWZG86jM8Nn459CJa3TWdGf/Mup6Ts7z/7oYa3sf7Sq0eoZ+p+gtuA0kqURHXDTZKw9Kv4VoW5PwtkkxsbpMgxkynFKOwJmteqNHaZ6WGL3LnNcCMEc+klNCgQSaVXly0qTiCTjuKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(6916009)(66556008)(1076003)(66476007)(66946007)(8676002)(86362001)(8936002)(26005)(52116002)(7696005)(5660300002)(316002)(2616005)(6666004)(956004)(186003)(16526019)(44832011)(83380400001)(2906002)(6486002)(36756003)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dnugoUMgeNz8RKCQV4zpllH+xC/t9VN809uvAJ4kmMldgCu4Z2Bx3ax6uIlaaqUZUUycw+MMadYIRmBSTXff/HLBGHY42CQ4o/guTIqwFns9HGsLyxFORByRSAvX2fFBKTDtdnnyVqvb+OoCBDPPzSq+Na6ZeQyifIHoXSQ572LYv+0m9GHc1f0QhFqrPtpF0abDb40+auyUq9KTJ3Bu76L1x2HBmvt5hHND+id+ZpCNy2kZOl+tW6Y6DZo6qJw9JoHjwuCTQh+Q3Sixz8gj10MFGN9zthfKAB1jp/ugs2lJwzk++0GuqM8+9Mbm7+OdecF4mkhoKD+OGfRVfCCpio4BIR6JaL/JE6n3+p0QdqPwgT9fPc8S1xdyhMbdU6rKdnLAFWWra0BirjnvE6V8Ts9HIoVSRFrTIK6IM0HX7ujT/jLvU0vd7QJ7HaaqDk9b5i1pYhdw8m3QLgjEC/n1QdE1V68iudVo/MzMqoxgZDfGZ6E+I/7gIXdoCh31VmwNn6tqJIrFYEnJfRrZCoXaS61dH58FRRNiplta3Q++lzCGXQbWwlX8vHG3F/ohFnULE44a3NQu6Wr9GEaSkQq45wYl5b0oZUpdF0le66id59whk4kU+2NjMdOvSN3s7gxjEZMIxKUN4ER+i3JtvLtH6SvtL15FWc37kWler/jcanDqOLethIxAntS+nZEUl/BKuoopDSg40tLbEQegfdb1KW/BzswmJdBJ5+g9QtY68iqDaLhQqYgd4fDsX5q8f75lwoQKuxfCIzhGohFEYZjrRmEbJSdAZiuuTKwQUxlyvgiVcFQmtSlQKtrFXm5Kmq+8RNgEvKIvf6Rn9+vflx83FQKkXvY0VkqEaZCYPb0qMLZIwNqMHg5+Fda+KKOhSDqmn0NbL2EogcQ+yvpo27e+Fw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d63d90b-8cca-4e64-f2a8-08d884db0ade
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 18:12:39.1980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9UIpjvgq6t0xUU2IwttHdALV+i839H7Uw6bsTezdKQXjpRADC5Z7FbzI7RKPihUSbvDJXw8+hWNV/Ei5aRIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0090
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
Cc: Guchun.Chen@amd.com, felix.kuehling@amd.com, Aaron.Liu@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check validity of drm_gpu_scheduler before setting hw priority.
Also fix a minor indentation issue.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0350205c4897..5e099f635040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -504,9 +504,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 }
 
 static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
-					    struct amdgpu_ctx_entity *aentity,
-					    int hw_ip,
-					    enum drm_sched_priority priority)
+					   struct amdgpu_ctx_entity *aentity,
+					   int hw_ip,
+					   enum drm_sched_priority priority)
 {
 	struct amdgpu_device *adev = ctx->adev;
 	unsigned int hw_prio;
@@ -523,6 +523,9 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
 		hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
 		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
+		if (!scheds || !num_scheds)
+			return;
+
 		drm_sched_entity_modify_sched(&aentity->entity, scheds,
 					      num_scheds);
 	}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
