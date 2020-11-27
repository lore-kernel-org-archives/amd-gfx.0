Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAAAC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 08:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DDA20656
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 08:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jKA2P1un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DDA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAFE6E9C7;
	Fri, 27 Nov 2020 08:09:30 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680061.outbound.protection.outlook.com [40.107.68.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8CF6E9C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 08:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0lsBvoXpYYc7vqa4IKp5s0gV36I6Rt6ImIMvNDn/KLFEn7kvWkxlyrPncgCbI9X0TfmzkV3Rohr3T9qIojSEJjphc/v1/Pg/knUCejJ4+JcOtgdHEwJ/lXgmAzrz+n832uF8ouUaeBiyHL9u+Dswqoqmf4lAguzqoR+/jxqQ8UqwZQBkaWmEurPpiN4K2DZ47P7XIqXYreJa4zMcq62y20yVQzhfm1MyiLZCadjBhnqP+NdIm++XxGMnv2idhfTu8OaRYlFbnYBz72uvakH+OM4xY6AZDbepDXVQMp7Q9OD1gjN4OMIGkeQH0tMUcmFDqgzAvWnw4NEoT50stxouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZxBmbcGlqb8SPVjRDnGmdEKqKKOA/kr5E6ijH3SWkY=;
 b=NS2rMobJ0lfXc5yplnVY8dW+AZv4+pen+9XIFtpxyudp0JDVHb+Ap5nsrIvDOOjS2p+XSnci8ZvCQoUpFreYf1C1AQRclwOdHbHYuzoeSWeNJ+PlUY+U3p0uxxcVDrz+lGo3hle2mdFHXGAqjnjcuqWRRr+V4UK7Bmgryizb7r5w+a0L04BKe+dQDvAKHtL8Uuo79H37vVJYtTt02MavAHkOkfWtHfJ2ZDfJOdE/VOf0PC9pbO1aTYRtAdu10DoobEgMyyBdt17NVRb9RT/XQn9H6d3ak9oBkcvjb3TlPFLX8k8yNOpcHdoV1WOl5mM2auDcEixViVohZkbcOUt4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZxBmbcGlqb8SPVjRDnGmdEKqKKOA/kr5E6ijH3SWkY=;
 b=jKA2P1un+xogctGnFs9f/m6dYqQlez4vSxzHLpBHZJ5rON/mbno4UlHZLJDCdSPXhFIQv2iI7EP2wMEmuhMuCU93V9AEq48tLu/S0uEhMCc76Qtm8ohBamKnEaGV1jROBe9NQINeFPZUEa8mGVLnIqGymfh0If1CWvRYjs2gSNo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Fri, 27 Nov 2020 08:09:27 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::1948:87e9:bae7:bdf3]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::1948:87e9:bae7:bdf3%7]) with mapi id 15.20.3589.024; Fri, 27 Nov 2020
 08:09:27 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Set doorbell range for gfx ring
Date: Fri, 27 Nov 2020 16:09:07 +0800
Message-Id: <20201127080907.12337-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0077.apcprd04.prod.outlook.com
 (2603:1096:202:15::21) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0077.apcprd04.prod.outlook.com (2603:1096:202:15::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 08:09:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d20f35b3-6cc1-4183-b3c6-08d892abc225
X-MS-TrafficTypeDiagnostic: DM5PR12MB4679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4679A2C08CC1F27DC199EF8C90F80@DM5PR12MB4679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orhLHmRONWU8KVsG0etRftfzCjqosovO8txsE7gwsG8Of4XA48dzd1zxBJwUCUufUrWoLZn2H2ndsbW9uRDLHbMryes+oGEI2MvQycvmE1nLbMD+aCXVjvAjCRByBPpTCNUiGEOzxxYrvJleQoLTvnGVmxpLVSyBgQuxlXNXOqxc200dM1yjWvOmAbz/bLYj/zOPNtsBp9Viw0nPqqDrtf/2AxsBApSb9rj+ZMtHsdsBeRuMDgbxX0DyUQ7xw9Ln5JUPvqK0prWoTnp9+DIJPHEIFRpIUA8xW1plxlXvPwn9Z2+pgkSMvY0rhbFyNXKwn2vX8tcqq+hrvUFhtIwQsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(4326008)(2616005)(66946007)(66476007)(66556008)(956004)(7696005)(8676002)(1076003)(83380400001)(86362001)(316002)(36756003)(52116002)(2906002)(186003)(6486002)(26005)(8936002)(6916009)(6666004)(16526019)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+WGZEd9413LbjuzsGL/KUmZpTVbpkZEbg7tsnG9JynPF8KuTkuC2of3QGNFx?=
 =?us-ascii?Q?W3uLYrUnVQpxMzNi/9zHilGw0TDqYGMc39fFOPZPCxqmy0Cm1PcVitwAFscI?=
 =?us-ascii?Q?KesTV+UwpQbzNiNPUV7+DyGX9DUGC6JejxRP9Eyvpxu66Stks+PxcPpnU+Qu?=
 =?us-ascii?Q?fgDlWc3Z/BVhj7lanXKOy8X6xfyW0pWec8rKc64tg00sgw2u+Awix8D+ybW4?=
 =?us-ascii?Q?NIKssLz6JYYCNSxyxYAIPAK6oBLEzL1M4LkF6L84A8GB1cuKKQIT5B8K9657?=
 =?us-ascii?Q?RHgVt5MNzrRiI3B4EoCv31rENy655IVEsb9XmmxIXlNQ9AzYr/UENDKtmXMX?=
 =?us-ascii?Q?Qh5m7PAvIy5LhKEe8tzcZD1ot1qa19FXjSWQf0h0TKSdWNxNIDe0qtzGYYTX?=
 =?us-ascii?Q?mlwmifNmxMaGKUkzQHzHfzURI/JbKUV5mO5Lg97oPHKfn3lK/aNcBrllwL81?=
 =?us-ascii?Q?gbFTj5Dt6tvxqhlfOgq7hf5AjK38e59Fo0ZAi+kOaT9xQXwK89N1/cOo8VJS?=
 =?us-ascii?Q?ysUrFFWnefWLfflo+O5+fIcuaQxw78VYTgeThFPCCqsaRI0zTnDbBTS0fe2D?=
 =?us-ascii?Q?G/bgeESEQV12GChL5sAGmz8JhzdFrO6tEN5UuxatlcX/8bdnpSiPPhidZ5tc?=
 =?us-ascii?Q?/RuKvdKAVCqLUfyW55ZRWD6r4CezsB07QPf60c9rZlIbRAuFduJNuB1Y83b1?=
 =?us-ascii?Q?xI3oEnh1KxNr8xMNYbqBWvUu0X1f8py52tLb26i/Zt5BFC5GNcWwcqPHZj6v?=
 =?us-ascii?Q?8C2iHStATqTI0qw4zJM5fW7hTZJS34JrGIO/3T+w/0Tvi+So9CoiTAgUfMtD?=
 =?us-ascii?Q?o0sw8D04AMM5XkSUNFEOSNw0+h7KJebRB1uKAzDwJHmxGDbZO/+AXUaHAYSe?=
 =?us-ascii?Q?BVBqiWXtI3gGUu9wYrgVXWhP2Ql7TcOVxOwX+gvc0+ThNZTyIgb6M+SuWzQS?=
 =?us-ascii?Q?9o4gJjYvw+Vn7TDlfiGCBlZYcCGx0u7Nv0Cyj9iPEJAsZbaHf5ePeDVR1SrY?=
 =?us-ascii?Q?da7W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20f35b3-6cc1-4183-b3c6-08d892abc225
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 08:09:27.0676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRpBA06zOtyC3Cag/xcKrX2TKpkgEaoaG7KRKvw6e4UtbLypoGSGQbyPrKVjHwgyPuGaz0TIO0TkjMYZNETefw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4679
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, prakash.kamliya@amd.com, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If there are 2 gfx rings, the doorbell lower range of second ring
will override the first ring.

Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ffbda6680a68..f33e54b01d3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6357,8 +6357,11 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 				    DOORBELL_EN, 0);
 	mqd->cp_rb_doorbell_control = tmp;
 
-	/* set doorbell range */
-	gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
+	/*if there are 2 gfx rings, set the lower doorbell range of the first ring,
+	 *otherwise the range of the second ring will override the first ring */
+	if (ring->doorbell_index == adev->doorbell_index.gfx_ring0 << 1)
+		gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
+
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
 	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
