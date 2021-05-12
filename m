Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA4EC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0418613E9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0418613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2056EC7B;
	Wed, 12 May 2021 17:32:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 710FC6EC7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9ZHPoBaqs4W+QEsKVN4q8m1Aqkbcc6sP/Gd1Yd4bbbmcWLrs+0rLH7MuQJv4B1sl8+WBq0xnoL4OZccnhCcXtAoULV7z33P9zcvz1xic9KuvPgNk6rfIgp8uSHWXGbettb5Rn1E9LPHouJ5enVAKScwZA+rM0gSTd5fIdorB0eSm1M7XKN2XnqFqpHiahWcJmR2zsUM/QKwgRrcAw2i+xB5ZhxcS0o9rIxZ8rk3DcYPUPzDGp70aMvoHVJq3KdRNgYyhHFUg0eJK33KxEIRSfulLc8TD4rsoBKgWDxn85xXp8iPGaxmjqlti6V8VcEQrYVHwZHgH92wiHdHYuzojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQHloUS3XaSWnrbNp5mF+JXAhGKgkEzSNhoQgYtmS5g=;
 b=npXGLB4aQqKaXVDCuj1f5VNXZ4Z+pKeaqO5r4maHHznMt4NHE7l0zATprUG/Nv6xc3lHFb1l2HYkYxN9Euj46ZgxGUvS+LiwDRa4LdOQ/Tcufna0RKj0Yy10r0P7akQ8L6meYmLK4fSuGBblGLKPxy2eXRWcSxKtNj8ciubrQmNEwc83cieT4gUcBvNN300DZeVWE5Ulbsbyzq975rfxJDqz6QC9SpKsUXbSpWMg5VyAtKtENNVqSgKJ90sZnMeQt06N0Lvhb2UWYDhtonHNxaxKGUNVzn7YzLiO6TZCXh99F9DfXESEnVcy7RlieWYdk/UD5dwmNGg14vaguB7sCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQHloUS3XaSWnrbNp5mF+JXAhGKgkEzSNhoQgYtmS5g=;
 b=uctwzvoo1mW6kLcqPsevdG5Jlmga5SWOFQtd31KLCV+jHXGpcRvPyWeGwJvVk19K4gtZCOc1XFBqeNxmLKeCJMHZ33X4IZbrAJLTOWHDAJNWEMsSNSRPs1hHFv6Il9MQsPNzn0JgW2KZByz0jjUZ3W6QMEpKbn5QlhEczOxDPOo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/49] drm/amdgpu: enable athub/mmhub PG for beige_goby
Date: Wed, 12 May 2021 13:30:36 -0400
Message-Id: <20210512173053.2347842-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddf1c839-ae67-41b9-5139-08d9156bc986
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2564A3D1862C52BDF75F7148F7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfGdYdVK/MQIdNiY6EmtvRhWBkrUyaS3H8SAOfwBjTYWO4H2Lac3LXyj4xT2NPYnjD3E296H4j4UxXt+9DLa8/pddswo/QmL0kz9I/BsLnov4NDBeku1DdBxKhiSvRS25BFj9yo5XcmPfAy2C7Fj+Dmhx3BskCLjACwlDiUQF2zwHvKA/AMiTYC6++l6yXjBH2jFC+5mE153oIG0IhS9tp0wseI8Kmp294kH+KMq66ggiDB7ucvivW34JrgPaLTAD8K5vIQkGKTI/dJdE6FHJzTznhHLVHl2lifcGMT9wisR9Cv2vEUwNSY902lBy4CSDTrRQIPClXXYWEglpml71Q9euAahGlxTI7AOeM/e1sjhvFQDlGjMI2hoGdlhD3OE3a2mUZHai6pODk5TF9hJjZx8EjVlMWz3FygDPlFzC9K8S+yO8oRuir3nSDVk4Abg2NI7FB2V/uiKOdABtnVcjEfIuNLrFol/PoGNe/ZxDORWFgwL+I/go6seUJUSDYcYWvHQJ+Y3+H1LZf0Wn4mS2G1vdin9+9oMHxKYLjny3HsXEfeIqrWMac0FNHYL/pV+EWHj9jRzmOa2OkAiySTOvcq2Y8ecT3bB3kOr2RRdHVEPC976xeFzDuexEOgyhnFBjRWU2fmhNJUaENezqIFcn5iEeef3W7V5C/sVu3z1ZftIcvDTCIyeRCxQqUjxQvgy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(2906002)(6486002)(1076003)(66556008)(54906003)(83380400001)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(4744005)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SONTS382RWTqnNHaM/myTUwXkCbNxh/L7/c2GGX/m8bkyDUH0ZHF45wCzLvT?=
 =?us-ascii?Q?sK305KS5B/ABKhwKhXFS4ByxzoGDvH3Xsj6RyMOZ5xQ/u63tMD3SgCfhGSBO?=
 =?us-ascii?Q?kQWdWRURHc3wEBGuhp6IVAO/GVIooH+ROxwVZY6jPBJdOx79OIsh76L+OZTU?=
 =?us-ascii?Q?r5s9ORclW0FsEovnlQY/gwsFSCPKYedVG9Gl9gh5AsCqg+1nxq3pkufwzfYb?=
 =?us-ascii?Q?kr8mmC8dqyyghIW7BxtJpW9g5XQ2vyMFCodrkZ7RXxxN9bX0gWyDH2I4G5Kf?=
 =?us-ascii?Q?QK10K5LPLdSxhpR2UcQu6VUT5BlcRV2rTDtT5BGiTPMothodoxecPFUHliqY?=
 =?us-ascii?Q?q95/vD5nzfFBdc2N5J05eoATpFPlxx+xudcQ41T/tTk9YKVdMjua5CJHEQ1H?=
 =?us-ascii?Q?vgcg9YLQp6yFsYDE1kEtBNMvJ7x5dh5EhpLK+nkpAlOetekp68bGItDfe7ON?=
 =?us-ascii?Q?+N1j63EiKapFwEA7zXP009+HhkXY/DmLNbxw6MHVgjauSsI5IUkRxdJn1Lg5?=
 =?us-ascii?Q?hieYvtNBToMyg+8YyLY8Hd7Q8tWyWc/alUdhkos93wZEhBmMFkgQbMaWacOz?=
 =?us-ascii?Q?JiO0sa1N/3QG1x0tEijEYFZdjRdH33JhwG62vUYIQS8dJaAH9XjEGGVFQpbH?=
 =?us-ascii?Q?SJJAqca/g0aAe/n3/vbNNVEpEPSNAkIi/bj2kVpGhogKMehcFt/rtZ+p4ale?=
 =?us-ascii?Q?eZXH3vkbQDRPMNQB6OhAPEdGSED7JWdcZtyPeyZeVdHPTBqIrBSclVeZZAf8?=
 =?us-ascii?Q?45qwqv53zPzinLIVPVd7bwfmUlxtga8GmD2DOYk+bV6fvCehewnQU57fWOFl?=
 =?us-ascii?Q?t4JWJPGxTT3TR69CwmN6bSkk+B/jUTOZvED/AXYZ6UPTUeG7sAdmGpDTYjQN?=
 =?us-ascii?Q?VB1HCa9jBX6UQ43PNwWfVmsbFVE+HxdLwqduv7KzpCFNe/yOadoBZJPfHQrc?=
 =?us-ascii?Q?RThY2xHXhdPyjg/BZV/FrtdXEKu0tJH/IFrV3VGrMqditBArWbkmJ8Exyk/5?=
 =?us-ascii?Q?BpXweiCf3bu6KsNZVHJ+fLaGLeeBMMDTjnKR8hhbUwBnGd49MgpoYIF/Jt4k?=
 =?us-ascii?Q?1uErqFivYcCmbTAqzsYgHXyG2TU6NoDYUCVh/Qw6dAb3yZf+T2jODvDGqTSC?=
 =?us-ascii?Q?g7U6hh1XsTkBgD//SrzPPljIC8Z9ko4A+ybGMigkD0iZjWSvca0l6a4h9VAa?=
 =?us-ascii?Q?PSMwXeCsi3SiO+iDXJnHsrD5qAZT3/S9W94gAn5KS8XbTlWwrspMLvFkWPxp?=
 =?us-ascii?Q?NVV7vsOn7wA7dZrwQDAlR+vOgWh5qKT4VeXe+7vPFzA35JBn5/q2cbyzK15u?=
 =?us-ascii?Q?6CayJnxTzJhCQ4UuCFR5Lpjs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf1c839-ae67-41b9-5139-08d9156bc986
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:33.8055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp32KNDEGFIwfzFqH8s8gBc/1iimyk9bQqIVgBI73hcaFd8+ZV3fzO7LfHcMjwPeyg7EKATCU32yXe7el+iQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Enable athub/mmhub power gating for beige_goby.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8327f3d14e89..1fb8691e08d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1176,7 +1176,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_VCN_DPG;
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x46;
 		break;
 	default:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
