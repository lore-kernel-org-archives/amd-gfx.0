Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A97C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6366C61C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6366C61C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D8F6EDB0;
	Wed,  2 Jun 2021 16:50:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3BC6EDAC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpAYr1+Rbj/JHWNDeC7wWsY85nxWKTgAjcujsvfmU/rVLPqnsXGUd7TR4I+OMyLDGvO3fumTsJX0GuqjA5MRx4RoUMaqRtLcdccomQqdB1FocCh8kgFRLD3uIki2LjnmV2m7u8TuajcfzzTqxNjERXxhXTdypaFLReyOkp/StutCgbNjR8yqPpxo5WMcCKbpylBDZijp1bDkrJ9/MEcVVI/VJBlwRfW/uUwAVkj48eJDTrjVD2h5kBPi406VQT4kYV5MBg/Pm3xy/PsAAjHtoADL1RmqaIhi4VDijZfkix35P7U8s5uFsiE0ZztWNf4Ylzne6QtcYryrozGa24At6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi3MOzyQygHBH4E2PIN+WHBw5fB74RggytMINt6BvMI=;
 b=URgv6xjdlu2KEi6LMZUUTmNDLvvs5t4PmJxUmVsfvDjHyGokQzp1voHWkO7nzz6USHLDvDYP8I3i2mMjZEdZo7ZPZq4UJFmahrNh7DZKjdy9iXSnH4S0EhLEzHYryCwBez3JHZDdnj5q3O+mjpr7gzkoXL0DZM6F5MLDhrnmKoUCjEkfcq9BqoWA3ZZT3Q31T+gcDub1Nkqj8lCfb8jiMOAhTMB9rIqgT/boYwxCmvgWrXfIsHTEhV5KdwynNYx0oIcE1aBriCospuk7G7CynH3WQT5hZZ/N+jeIzdZD/0aAMwaoXa17ZVjWVRh55MAUg8ex1lJeq2EE2ABJxe7GVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi3MOzyQygHBH4E2PIN+WHBw5fB74RggytMINt6BvMI=;
 b=5jVgN0jnDqOLV/KAQ7ODRybY12F6ogoJnFEZFdp5ZIF7BgR2qX/KgE6vz3MYOP0Z2BZExpikSXPRDsdvhoJxcsOq0JKDrk77wByUXw70Fp6WUDM05HQRI/FJE26hkoMxev3+MERpIkYm4DSbTt4J6m8s0AEXMU3mDDafO/qe7AA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 47/89] drm/amdgpu: add RLC_PG_DELAY_3 for yellow carp
Date: Wed,  2 Jun 2021 12:48:26 -0400
Message-Id: <20210602164908.2848791-47-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d845af2-6cbc-4a14-600d-08d925e67684
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45347F5F53C79872481E0241F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fie9sq0xmMg85E/rsLQZoh9fuEZcCYgpkZ4HxhPfsTxvcL/GnPZyNtmCf51/RyPhE4yMRdeVVbaX/cNHKDMapTQfPmpYMnxUTNiGaMpGm8/hV1qYzYH03QYgkG6YtFpmS9PxAyRlnvACYmWGSGJYjYVVoznv9zsxIeR44OvQ+EevzIryCMwFDLTxxOwzwPWY2xOLPa1bx6G83GglAqmlY3CtGyCBXDpsBOahTuB5AptE1rFmes+m15cn/TwbVPto4Cih4/AO1G26b190+yS0+QojQxNEvmO36Xg+LMchv2dlTFd8rErD5ZkobR4A6qqDE67gIJ3Ctw2vJicofwwEDLnETquI6zZn6XWytm8aBbyzsYmzdhbfHTPtOfJMej147u3fBnAviPgjDcFw6oUUtEEPfJlqoTp1s5Hka+6rXhRGiQis7kp1FrbhRPyLWJGqZuG+XzqjtyuR2sGIoblJXblJLzDfioMvEe/k1msajdqgRPCFIGLhcRfJyGRUGLriQW8uhACq5oCsZBIWDekpzyfUt0wyVPdCjQL7vTj1d34ijxYl33AWpzEq4uRh+hixarTp5jdhHsubRSdZ7aflwPGlBUnxFQxTZTjeexY4S0XRjy1ZNXpaZEe/zxB/8Bp35yNrm0Lpth4QQMK2eek4w+1j6hEOE2qlzoBFm9BWd4cWPxm5ynayF1sN3T/IQxFb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jMRaiTYLlqNr2xZVrV9w5imb1zktxNRbF8alBc7Scsmv+5uuqHlAvkccoM84?=
 =?us-ascii?Q?nitPJQkEh/F2P0w/mlldjA1neQfxGUIN4aoS/b29GLuT0YhsX8FHJ11k+Pjp?=
 =?us-ascii?Q?SxMkFAw0XYKyTZTu1d+fpcOfsVvU9PRXN0Qm7T8QpleCrUBnM/mzsapYyhI1?=
 =?us-ascii?Q?ou7JP0tqcPSPuoHXKgCLiFGzzZmW5V4aPVIq04depnZHK4HnGrKHHt1qQRqY?=
 =?us-ascii?Q?j9+CYgSJuJXGtw+NKSKcQxw+HoTmVV/Ww/7H4e3QC/MffFuDcQ/jsCuYot28?=
 =?us-ascii?Q?jZ9Zpk0MdSVI6kuElRyAHcyXZUB0/C1i8knw0w1/SaVakjIM8iYinU2jm8g3?=
 =?us-ascii?Q?umWKCZtffdsVL7wtVE/+9siB2/+LwIU4QDpZuulOr3OHcFv+x9FlRmgbzZKK?=
 =?us-ascii?Q?pNnaACh6uipdWi6Y6GFJJvsj29ZKX1bzsGow4mdhE4cX2xgfgbnndRDdfpS7?=
 =?us-ascii?Q?sX/x2Mo5LEpg7yk0hU2eNaPFtsx9YArj94ZW+KeaVn2RjSq41YvBOznuJZWK?=
 =?us-ascii?Q?ibrVpu3Gnq7SmOmqPe2VYh7g6bgYMZOJ6vlfl087LYBQee/PsiP0CJDHNJEE?=
 =?us-ascii?Q?Gcuz/fP7yFVCYAJoQp29+VMxa2wi0YhiZpG8H6L4zYL8jN3mmOOmkihoEMkX?=
 =?us-ascii?Q?BVwlocRcVoQhMMJJLft0wUdD2vgJoJt9Q/puxiZoSRtAC47Wd0wMIMEsqVPw?=
 =?us-ascii?Q?Bj+l2vKJkdectDnpbSeROh/3nuBMwNIM65wzEbl8TGEDUWAAo7UxyTzp9e76?=
 =?us-ascii?Q?Sf7iWxRn7SXlNbUafse8K3LQTtZjoJ6IkzB00WdKb2LuFFf6DbWWkRO7hu9j?=
 =?us-ascii?Q?qt1xrOqHxZGcdm7l/IOaCOTV8Y58w+Yna9Acfz+/mbrLESpUTP+2y38UE6iu?=
 =?us-ascii?Q?GGvWoLi+bm76CVexg7+u0v0nfftNMoHGzmkRJYcDxmSZDQDw8QQC7qAkp5OL?=
 =?us-ascii?Q?VRw27r3HJOGaWWtDHe/RMGC4rgkRJprefiyQU0Q9GgR3S8HSchFYi2Ni1M80?=
 =?us-ascii?Q?ZQZwsj88kZjnFDd1WzjC/+1cJYpP0zTDrFjDvxQZkZwZZTBjjlBoRmq3fpz4?=
 =?us-ascii?Q?PMQIwx6IsH+S0oPivVGK/H1JjH2kyW8w2PT1na2WvroaakiLUg/mR0UYG9ig?=
 =?us-ascii?Q?a2gAPhioopJEuYzXpqtaZbQb/1W49sTWoThaeqSx4j84m4lPGbIa/8UBvGdm?=
 =?us-ascii?Q?SzLQJz3LmPNfl21DLevFNNFhnPNW3Jz4nyVC46f9upwYsOTDWnW8OVhtyI7e?=
 =?us-ascii?Q?oC5ssw4HPrJKQXEdnFy160Okw/8RliTrawWGh9wsSbbtoNDijoJJhQRh1yZu?=
 =?us-ascii?Q?144JlZrvc+RAIq1/kHRSl/sx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d845af2-6cbc-4a14-600d-08d925e67684
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:01.2172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCzyM0hKaYAAhOOC3oumX+2BcbnAWBynoCuv0V6K620ockqFVll0kwkDCyoamEsdQfZHysGdcPprx6Vk6Q4sEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

RLC_PG_DELAY_3 is to make RLC in safe mode to
prevent any misalignment or conflict in middle of any power
feature entry/exit sequence when CGPG feature is enabled.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3f6184451b9b..4e37e219989a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8052,12 +8052,23 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 	 * in refclk count. Note that RLC FW is modified to take 16 bits from
 	 * RLC_PG_DELAY_3[15:0] as the hysteresis instead of just 8 bits.
 	 *
-	 * The recommendation from RLC team is setting RLC_PG_DELAY_3 to 200us(0x4E20)
-	 * as part of CGPG enablement starting point.
+	 * The recommendation from RLC team is setting RLC_PG_DELAY_3 to 200us as part)
+	 * of CGPG enablement starting point.
+	 * Power/performance team will optimize it and might give a new value later.
 	 */
-	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) && adev->asic_type == CHIP_VANGOGH) {
-		data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
-		WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
+	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
+		switch (adev->asic_type) {
+		case CHIP_VANGOGH:
+			data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
+			WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
+			break;
+		case CHIP_YELLOW_CARP:
+			data = 0x1388 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
+			WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
+			break;
+		default:
+			break;
+		}
 	}
 }
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
