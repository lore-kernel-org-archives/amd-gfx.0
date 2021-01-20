Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F5C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 07:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C279823131
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 07:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C279823131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2EFC6E14D;
	Wed, 20 Jan 2021 07:51:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2DE6E14C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 07:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASUh1CUUBWGTZ9bUIapLUvknoN6F8dvRt5MvBjwhIC2c3KVXf+JYXSli9DCgBeQUt90+MDBDlUZALQVPBjt78ZCKC+FdpJkFfq5ikHqfw024rHqMNB7JdjjJeP9p6Ux8bzD385RCOtVnmc00G3LxKEiQNR+tKkE/Xsq3Fp16YA4QrgU5HadZSoGDF37R9+/7U0/OH6+US1Wxa8i90nxhPanEM9ajLEgmlDFTO87mTZ5kYScFjNk2JKL0ar8E7BNXaeiOUpJZG/AJC4hxTFk4Ap1yOdJM0pPgf53d4EWxCYd1UfWz2HRTkRhNyBA4R2hRILnywn/2U8tSDeRyVpB7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfXAvNqYJ71nIgRoFPy75KHVyIvp/rNCccuN+EyFD3U=;
 b=H5ccyM19HKWWqP+ogX0/WFmPtAng09M003cZIhW0Ogofeqrr4nxEqiw0LHAwXSgq6v6096wOF4Uw+Y7SprShoIhSiePVERqNXFdYMQeEzCi8lJAvjgHuUGqaSWxYJVDsK+6U1bhA9sFaL2pP3G4eN4nqJ7mozwzbhAJeG1jGJM3J8Y2Y13kNeR9VQ7wnjQWlrb5qwL/RQBV9rUFoUZxgFpbt5SCwiY75ClMHAGll0IcYj7mCEdl8ml1c7Ih2V7lbPMttmju0LQ7ACV46LsQqh5wewU1GIcQl7x0hijKZsGOo6vzug0omRp3cjkS20zxAqNzwoaz3UeHr366Utz84uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfXAvNqYJ71nIgRoFPy75KHVyIvp/rNCccuN+EyFD3U=;
 b=q4jpWdbZ7PXLTJkusBG8aa68uqAG1WEHtZHuqyFmS3eHJoq/XeT1i8+oPa7Ssvg0c8+/mZoOtSqjMa/hl/u0ZbWCU1Xs581khVAcJhhbqJDq3oUwwJj4P2wOtKitz0YKAb/xwtnIJFBF+f5Jcu3b0sdigWR8Lmz736w2K1MhahQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17)
 by CY4PR12MB1654.namprd12.prod.outlook.com (2603:10b6:910:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 07:51:23 +0000
Received: from CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::82f:2413:1026:786a]) by CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::82f:2413:1026:786a%12]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 07:51:22 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable VCN PG and CG for yellow carp
Date: Wed, 20 Jan 2021 15:51:02 +0800
Message-Id: <20210120075102.4004746-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To CY4PR12MB1159.namprd12.prod.outlook.com
 (2603:10b6:903:36::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aaliu.amd.com (180.167.199.189) by
 HK2PR06CA0013.apcprd06.prod.outlook.com (2603:1096:202:2e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Wed, 20 Jan 2021 07:51:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23f43b96-686f-4991-108d-08d8bd182e23
X-MS-TrafficTypeDiagnostic: CY4PR12MB1654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB165443331919AC7178667C26F0A20@CY4PR12MB1654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZPEyKIzv30dl4AO6MntSzj9QWgSUs6qqsgL2IayPX/KieFqemR5Ck9ls/97cXI36AH1K2ZtU9FGNDM3PPQmPBC/UCrlv+rZPS2VvUMnjIjGYwFGHB/RaDwFwh5XDAOEJDptTurrxSTbX27pVUGTrUd3ka78xBitsBfgOCW3EpejDfZ0JAVdJ+Wj68yXO4Adc7LWOaNGgpPbQ2tDD0N9cFm+K1Mk/s+3AHdX+mRw/GRYTYsaF94xS+zSWgWI1MP3WDsue7uA10A5c7kru1zzpHo2vcT/lwVIWLCKvBJrfpmNsDh2EFDuPO/2NalKyytZD8gyH4qx0qaBf36LkgOVb2NucTJ8o3ugaT4H4GD0T7rJJMG+n8uQzY13cQxcM+fTNlQACvWyU1DgTCNni5p5tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1159.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(86362001)(1076003)(36756003)(83380400001)(2906002)(66476007)(6666004)(66946007)(16526019)(4744005)(6486002)(6916009)(956004)(186003)(5660300002)(66556008)(26005)(8936002)(4326008)(316002)(2616005)(52116002)(7696005)(478600001)(44832011)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ch2r4Po+FNak7wPtX6pqXbUZlKTjqtMUw6Maan/a/r2Z53CS0m7EUHTlCNFP?=
 =?us-ascii?Q?N9d2T/Tjfm1dYupaKsqMEVtNxKfnLDXKfny2Mh5oF2rB8BKtfLFPw5EZBfYe?=
 =?us-ascii?Q?GJ5hj3WoDSklNQf+d+BIPz86V6tE/vsEkUOIxG2YMo+bDG+syn7qRYfdQiAi?=
 =?us-ascii?Q?8Ef7//7pbMF6NYakXBwV2H0FP9PT1MLjh7cOX87gP4ZlKWJakaPUO7Y4xn/x?=
 =?us-ascii?Q?JLfFYICIO30hN5FHg4ukhMA0HOxvAS2LvfwS28QK37WjwQz+bJKBYjVieMya?=
 =?us-ascii?Q?/yKWxA43wPzw93Vhsuh7IVJTNFedGsi0/Bc3pRMVaUw83gYQauWb/vABpLeJ?=
 =?us-ascii?Q?Umkm0X/8XSSrdbOsatB2ByKA4xcgNtn0XX+Rnn0MtBEyYZM5MOh+kxWflKV8?=
 =?us-ascii?Q?2QnGWDDN+611WcWPPyqT8XTzMJIfGHItoBrwSl10o+j5zDA9XNE7JOsVSMxp?=
 =?us-ascii?Q?alFQFk9rQI2sgRuSX2dP11/aHKrSmNSb8pSudb6Y42KGTyJ1fPhL9cSDUR4k?=
 =?us-ascii?Q?CenYHUzgTflwz+pDZQ7BcryM2MWESpLOmZHLWDXbrwouZMNEOBj1uTIJcBFU?=
 =?us-ascii?Q?J/kmyTXy5NOlIIKnJk7dKtAUaFa+fHoCHFHvzPzKTsAGdRYr5CGM/6KZiQd0?=
 =?us-ascii?Q?U7U1tSjYVMjj6ZVMTk3WuwkV/SqUgUg72q+nCf/l9lz+wo9rCvwgapBjiBI7?=
 =?us-ascii?Q?/8GJcii6CPswUVdLFGmB7z5yR+zukj/tqvOJm2+NSOF6eEIiduIMzGeB4kbU?=
 =?us-ascii?Q?q3P7VhZxEmCT9P9Pr6djQ0Bpv58sbONbg1FdJSoOYqhYTpkRP5loISk8T6Dr?=
 =?us-ascii?Q?XfvnsPxfFF4CGSUSCW+LaflJgyhJJ+HELic2gxwxwEABQsecKqjDtjeD1Yez?=
 =?us-ascii?Q?pKzAMLzeNopHHegpheJjAIjSXEoYav57PUmBToNhAmsuzvR2QTn9/RUx5US9?=
 =?us-ascii?Q?CkVk3lcDNHs6C27o6ojxZ+qItf7s1wJNSPsTzwo9OdCts4cegb73jH2bvxEn?=
 =?us-ascii?Q?YzW8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f43b96-686f-4991-108d-08d8bd182e23
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 07:51:22.7987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUqbQ8jhG+mMG/+ghpRrydMY4nko1Co4CmJWaQGbDxeYmW2SbhK9QYuJa7G+/6tX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1654
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
Cc: Aaron Liu <aaron.liu@amd.com>, boyuan.zhang@amd.com, Ray.Huang@amd.com,
 Alexander.Deucher@amd.com, James.Zhu@amd.com, leo.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable VCN 3.0 PG and CG for Yellow Carp by setting up flags.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 801cf79353dd..903e1ae166c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1020,9 +1020,13 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
-			AMD_CG_SUPPORT_IH_CG;
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
-			AMD_PG_SUPPORT_VCN_DPG;
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	default:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
