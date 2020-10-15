Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A3DC433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 07:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56332223F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 07:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BDCI2HTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56332223F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97F06E04A;
	Thu, 15 Oct 2020 07:03:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10DFD6E04A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 07:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9Gh+2eeHUlM72b1KBZAbsOwF9YilLw1u/Q79y1jiaeJ25YxlD+5xPgT7z/sAKPFq7xu0p+bW5/B6Ewg1UcZj7BLSMtxbHMM8TY62a8WEjxBvhrHvxgoQFMp33i3jsTYzlNSUWliaNlCJJJdRszIPTUq8Th3LgXTdkJXqo+mklQg//KWsGEAaBjquw17zDIVMeE0auq7UQvbLlkdsJlkDJC6oowT7Y0kh2hKh1CKEoWl5InqU05YIaQ2TzG4meiPpfgHho0Fd05GrlDUsSw4+2FRXJ5nZh4z1N1YLu1N0BQ3++ntKKP3N8VBri0MZhcNb/k+Hn6YICy0D1j74gjITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8I50S8zRpGuJ3Tp0F/TPmZS9fHYJG2mIJ/+B/TEwi8=;
 b=Vk31ciQ72bOMG60lQTAEKDrOJ7Mzkpvmv8hgoLtJkoTPofp78J1nqKPviQeT7RaUMgXH7CHrPgttbYBlubxp0D5b0BFsDdbF+4SKU14RTMlolyFELdVowb1yhj3MycKjMEolHWRZfijk672oEEpVNmg2DrJQjT5biGdLLAKRkAsBp168dbMMawhM1CqHxD0JBNe9CiRm9JkSznmfpMHi3GsKwJ4pRSwlzux+u/x6mKAoh2FjnyUKJXAHGX7LaG0PE+Nf9OYU6ehizcA+q8epmFqLnzGVFGcyuLd0l7BoToxEzevP+rglSnLwxxrLlepjavFjOg8mPDaZXeg5fBUBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8I50S8zRpGuJ3Tp0F/TPmZS9fHYJG2mIJ/+B/TEwi8=;
 b=BDCI2HTnXUdlonBotAo+u0I10Vg3sK29Etpo9gJn4Z2Xx/0I1G7Xg0ZIaFJ/aV2wag0po5wse7NzdTbwoRQQimJG0NJ02r/581UDZBlGObOfzpSDd+n9z7h3FHusJR7Ou0OzoXQVxS8FIY6M2ETYUQedo65v0ziOSFZe5+aV70Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2889.namprd12.prod.outlook.com (2603:10b6:5:18a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Thu, 15 Oct 2020 07:03:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Thu, 15 Oct 2020
 07:03:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correct the gpu reset handling for job != NULL
 case
Date: Thu, 15 Oct 2020 15:03:13 +0800
Message-Id: <20201015070313.14078-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.3 via Frontend Transport; Thu, 15 Oct 2020 07:03:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c00de7d-6dab-487d-acff-08d870d8702b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2889:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2889CDFE12846CC71810E924E4020@DM6PR12MB2889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyfTiGpCq+a3Yw3QUNM+sEipOdEscZFFfMCp+QDz517uINcyI+TUilQzeaIULXUCbCFOBWmwseO298rdjPzS+RZNnH+pfPySSZk2sMn7U1zUfSuUP0gHp7Hyr+/jrYogO7bOqEQ748UDx8sgKHh43iywgMKt5u270DuBtu/yP8Z3CnslHOrmuBhLDAB5PV5x8NuygPic+VpNtfKvfFeqZBMJgOesdLukRZMhYSgkxNO8IOHBaqdXaeYHy367FTQpr0ytc62HI9Bg3Jv2bvw+6HVOr+ke+6RuCB2KGKRH3T75Ok3wlMpUlQq/j9++ULNBRu26LEDsFJaO7ng06V2tqR7YgJJh5VC1I5g6X8JMf9uOwzg99Ev3Vv9Ea6FsDiW+NuirtEKnkPbCQyAr073n6edtpSpMC9CGal+3IEjNNhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(8936002)(8676002)(44832011)(86362001)(6486002)(5660300002)(16526019)(186003)(4744005)(1076003)(956004)(2616005)(316002)(478600001)(36756003)(2906002)(6666004)(4326008)(66946007)(66476007)(66556008)(52116002)(7696005)(6916009)(26005)(83380400001)(34490700002)(116360200002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fblWQXlqSMKXJiUOP7JHxA9AfV3Cp59WBhlXMxualtxXeGUsER7YDk2gAhNAtF42O7n1lbyfD9lQxFOQ2pg2vVHBk5y4pnyBIFdP/5xJC6Ss1GIc30aEwj6Xd02LxvFkDu/d3kmXo7vVzQsRPm6dVqdHGi08+2o5QcyN7YDiqPWYTt9Gi1QkJEL+y36N8RzTWa3/+fZhFEludFXVTSE44MWir1tQQtvnEG41ZxK+nYtrKBKCfEL+GyeeL4VjDPsqDyCNj5yZkosSSkgmU/UzgjbLFZZdlM6HfBCbobZ3JDqIuPM70eQSVOu85KAblUGFo19xOcI0BVUkpPSAPhBUwBJeDCn0c3tG4VbJOaMZYm0a6niolPnasjZaxg/fbGp3ndL0i6Apy766s42jgRVormqtCBVTm06NUOX+FDSLPWMOXjNI3lRuXIpl1L/eMlHQKM3NSwaaYCMcVWOYpSxiM6gJjtEUUrK3AxEtbkk7HuGABQvFBtylr92aHixGyo/y/vjHE72BEJZfInkgA/EYEu9n8MfPk5BCy376SVSe+bM6h7N//FxwAZRw7iQC4KVj7w1MN+xxnHVKcJ2l7yUXPbs3MR2Z3n9wkPXkz6WB859SZcCGWAsoP8nc0EemSSH++IOCmjmI0+vehM5f+0tRtg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c00de7d-6dab-487d-acff-08d870d8702b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 07:03:37.3280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muW/JJCy/I71I9V+zU2xJA/RFJrzLdMcT5cUq5RA8zKEmuGzg3liBHMU6jUycLHV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2889
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>, Jane.Jian@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Current code wrongly treat all cases as job == NULL.

Change-Id: I3d686617bbe67bf64e8a6ff8cc5b0de11b80afb6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2f0ce854160..24e6de3aa8d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4643,7 +4643,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		r = amdgpu_device_pre_asic_reset(tmp_adev,
-						 NULL,
+						 (tmp_adev == adev) ? job : NULL,
 						 &need_full_reset);
 		/*TODO Should we stop ?*/
 		if (r) {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
