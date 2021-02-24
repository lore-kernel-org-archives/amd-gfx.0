Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D587C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E549960233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E549960233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB306EB30;
	Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1649F6E0AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC8tCfOgQGuZvhaN6dbDLs6onvlw4G4kxeUMqB0a+K3yGwRcZjZ/2/zRqF26nxVy6ugD87ryuhuzXw7a2tv334Dnih+273XKDDp3D/oiUp9kU1HmK6zQy6JtBW0HZfgIkI6UTurs1EOoe7rqG0UKw2H+IckVjGXH2gMK+MXpD0m+nSL4X1GvvuEwRduWU0Gf9jpIgttayrtu8AqugiOrpjzZ8PJzxXZxJU3l+2zC3Nd8tBgSbvOePfF5OmB/9iXQIoRT7n2cZwRAW97YFymIqX+aFtbZE7UBkfeH1fhTRkdPKvyLYVeGRlZBNyRzUyLtTZVSp7abhYoXuEAt4ZAzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi56Gs/jFF2zwZS6MPPTcsGtdSoTtWHW9FNYGmfmYng=;
 b=T18qMw4p6Db/yhkifBorSLcE1D3STyHdew/XN/L1Be/w5LDc40MwLBT/2HoTzpIK0Wq0tTkYhOTy7aioSfQLsglZQvodvYsU34tOQYND8Ik4ArGP/EddRE5zU4xDBZr82+FJhzzntlpbt5wUYzoygMkNo2Rn+5PzVfkfrT/v2ii3uDtmJOBV+huQrZqP/+l6rgb9QUYTq+dctZfBXW433Z3v2cEup8sItzDRAw9KvSvOmyq8Zc/2HGUw5QHf6pPTYoNANPnugov55/xc2IHGcLnLlY0oppt6BgUWkRzw77g8n0rT3lUei2j/TDPJe0UPwRtnPIagVZtBIL+ffHOIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi56Gs/jFF2zwZS6MPPTcsGtdSoTtWHW9FNYGmfmYng=;
 b=efUOG2ea+mifhDxuLWkBx3KyLHVX2VAWnXnufUvnFfD9hS7LOSJfDhRE4crZefGMALOzkeAT8u+lHxTtcdO6QfLRHJM6fl0Rd6dW4MZu/Fr+F1KKeKzpO6MUY3Ida46IJZaKIlpkv2Ig3x9FYsuIQ1u22gNnH15nia+UiyeaSIY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:40 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 030/159] drm/amdgpu: init psp v13 ip function
Date: Wed, 24 Feb 2021 17:16:50 -0500
Message-Id: <20210224221859.3068810-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e01488ad-9c6f-43c9-584e-08d8d912471f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417551EEA9B8D7E8AB1D35EAF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhqDy95xSFmn1a7esYUjyVKV68dqaWtxDcL7sALVywftLlNxkIGjV1DpJYIp81+1seBwr2B3Qtqdnn50TP3BXUYjb7UDCgEfAwUlMChx26C3G5La31AQDi7av0T3oMuoyMQLXOuaN0KQSmYbVQnM7lYc5UbqZ7G4QcCvcwu1LEYLpM9M6vJUE8CjINzgGcnm/1SIAQtdqB7yMJxBuIXWSVeTH4O6sPojYPufSQCEdEuvZ5fJYaQ9iJvxyzV2JtB3v2jhB72bNFHzfjeWqn7QuojMelGosZK/yNZczlT5xfgvnL01Brp72NFW47EDgt6do+ubZ1f+sDhCiOl89FmrrTBCYt/dBrvf55dPYhc7eO8y4apOIsqpbyFteX04cPyzoeXRR9a/AtowIBo5LMwhI5v3z6l4LTXNMLc6QnD+PFpJzSkh7MvQQ/+jBmVInLHqsBmgEcbYRRHB3Ujt2RCzDCvro6ZkiOH2o5lbEVTRQqVaEuPKuoKhzyA7YZswJdG5sAwyzM4W6cyQXyx3LwLmFROTRVsfIcJYTP+9djAf0lEoRv4DsTvmVzUCSduSY5C4QkO8ytnedAwJ/DEL59Zekw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HQQGM2k9t5QK5A17InvAD4mwD/Y+MXEnkj5lp2wYGcGPkwpY20KWCjkZLz2E?=
 =?us-ascii?Q?50w0Ao1NV+kZavTl4eEwdpsBGznrDbCQIyV+QltviyWqYOsft3vuccjxs2rA?=
 =?us-ascii?Q?3G+Nj+SB1QLOta27bE9KiQZWvKXnHoMZmZ/EO4096LL65IMlszfzdhqlAK7c?=
 =?us-ascii?Q?wkkfzCcmd3YU75QRuEddSXZwzllGAkaUv27tIzYWu8QdnMAxEZPmluXRVF76?=
 =?us-ascii?Q?63FrJXAM6vvFwYKBQYglqIyhvt77ZzD9NqjJICkhzHw9b1zuG0uMqzpu5y+X?=
 =?us-ascii?Q?j4G5bFUKDdpvVR8OvdTZnHIP3wgguGpJsiY5MaKbq6cg/MyuPHslWfKAwqhN?=
 =?us-ascii?Q?GHQB3yhedx20/5Ov6aextL3yoWRj3EeciyP8NtJwHX+WePT3sWA29O/sngn5?=
 =?us-ascii?Q?kO4nwgr2Ml1SSssEfWMh2DuLZdFXDABXr49wC81dy4HTgYQBFHTUtDB4Ebmy?=
 =?us-ascii?Q?4rvy9LL3/4W1HwXRmmD41IAnfFL00eiEoETKWydOAL2tk1hbqb5N2G300ITY?=
 =?us-ascii?Q?N/6OD0lExFANysRdIQuDpsOTAcWGwOTFm5+DUlaPeZelcWvRSJF9xpKqP9Q6?=
 =?us-ascii?Q?wcWDX4RXC8stnz3wF57bEoWWrczAI5It+mm7BcuUWT5Ob2CnbRrO5I7RyPjk?=
 =?us-ascii?Q?ldJGpYt40BimNgm+qFGSDirbilOqybBlzBAs+qumZlOLQ8q0gnYDZnJ+6xzy?=
 =?us-ascii?Q?mLI71EScnCFw6oqQtIhaGtxgt1i48MUHDCKUeduH+apfFCxKG/xCtB+ey47T?=
 =?us-ascii?Q?Eg1kPOqbU+sB720q/SLfFo7OKlSJFg77Roml0QpYD+dNkp35BngDEmtLi88c?=
 =?us-ascii?Q?9A5Qqfn4Y8Zldax5LNxQBpEMhQD1cN3wLNeGBIRIicCt+LeuIcA1oISBWskm?=
 =?us-ascii?Q?u9QOkK1DYfn11Th68sX3BfsDeD1wsmfJIWGbpNEWVQrYFF0g1lgoKApt7ewr?=
 =?us-ascii?Q?JeHB+NOw2XtgeJ+GJ2sKMDVONWghZ4aTqWf57bnwlLfTEFMOxidO7IWkiNrs?=
 =?us-ascii?Q?P9TuMbKU2ZIx/QsqiVTDcc/Cs/uO/OlfmJE49CLwXHt4wJeAKpNFY7UFmWA/?=
 =?us-ascii?Q?v9H8Ttpw4tND0+anZE1hQoXbYRnAmcD5WrflOc3CnkRxwnhgw9Pu+3nFwDWz?=
 =?us-ascii?Q?DC5gM+wEGTUxqSlGYC/dWq6Tt2/k8xnN2N6YOE5h6MqnHVDSQjpEgCcyVZEM?=
 =?us-ascii?Q?gIE/BPJHssUmnjPUqxadGq5nx1EkAHmHQFtCmAq2ElZQB37ubJYAiWg/TspG?=
 =?us-ascii?Q?cLAUlvKvK85LywiklCfuU0xjQt3zrigEHRD87FvG5+lBIGXoh/YUUp8SBJ1j?=
 =?us-ascii?Q?9RMvhvBIID/o2/TwtxKkOFL+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01488ad-9c6f-43c9-584e-08d8d912471f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:40.0881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfF1XGr8SBwETRZAeibDqSAq+pldH2mbcBlZTR0Qyxmc/ZwT+t9jCqOAOVoQCSRUYn/aG7w1s4Y24QAt/n84dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialze psp ip function for aldebaran

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 839917eb7bc3..88518897c17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -34,6 +34,7 @@
 #include "psp_v10_0.h"
 #include "psp_v11_0.h"
 #include "psp_v12_0.h"
+#include "psp_v13_0.h"
 
 #include "amdgpu_ras.h"
 #include "amdgpu_securedisplay.h"
@@ -109,6 +110,9 @@ static int psp_early_init(void *handle)
 	case CHIP_RENOIR:
 		psp_v12_0_set_psp_funcs(psp);
 		break;
+	case CHIP_ALDEBARAN:
+		psp_v13_0_set_psp_funcs(psp);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
