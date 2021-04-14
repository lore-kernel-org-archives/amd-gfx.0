Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC98C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58A161154
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58A161154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6966889C21;
	Wed, 14 Apr 2021 23:39:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EB189C21
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 23:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6SsAELFPPqm1z5QiNqAibfzFyJngpbdqL/eXCooddn98jJNPyb02zChHfF4fhUaTmX3ffj9ULqlicEa87nAYSb5uCJmBp7C3+XwDz0lOnyqkoZTaBM+KrUVCd89cXU/JQa27d1RRnlor+f5Z9ki3MsmeOy4/1PwqBWL42Cs3JwR7Jmno2nV9/4VKVzTnf16Py5ITcc5OC8th2UmFi1ebnFOUO2zVOzfcNq1rt5irS5t9VRZ04bZzm/3Ip8UU1D5EwIER4afaoXQpoWGTMvp6L18XILnapOf8Eea0E2rOOVhl+f1yElgvam4IFdZ+02xNJNl1eQkcAflOeWd9k23mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNLyft48u/SdN5whOeeWZ7a01LTkoChOx6bJnoDZlx0=;
 b=DPqOssGw5Ltjm78xJWJqMNrOskefiZrRyvTXAi4LRteQ6ArEL5tRhfJsAwMGEmFrNUIi4nr5MpnMTOfqQ74iJAVcy8BXJ8UwcKUrvo54fimaQeNUV4YMwZbMZl/ZGQG7+y1fS5sFvYqRhvvxhzu/WaZ0fJU1wVU3EgQF7psLqby8Ji0qw3pHjlInVFZfN2t3tIGsjtApsIPwjXk/4TLQPlEO4dtAkmdgvYcQsmwS15ihGGgzJIp39ECqgcE8Tnhx+t6LKpCGVfR46DmmTCPVYkXTgsL5UC4w3ezxMTdFf0zRfLw7RG7fSyjeJoSnJrc9sNpEYtqC+Qyr/4TVSWC9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNLyft48u/SdN5whOeeWZ7a01LTkoChOx6bJnoDZlx0=;
 b=IE7671T5gF9rB22gBMk+Su0ziRXOZNljEjkfJfsb9OMQQPuw9yqkt1+J+RaNY4clvFgZVDlu1Frp7jlXKag/U6XbvQIHGt2RBqHAGqTLBC1hHKsS/T0QlT8gZacwG49Iw2Ua4ryqGRSZD3Azw5N8WorB7Xh6jCaDnTZ/NXUYRwA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 by SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 23:39:48 +0000
Received: from SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::bd15:7c50:10e0:502a]) by SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::bd15:7c50:10e0:502a%7]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 23:39:48 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Copy MEC FW version to MEC2 if we skipped loading
 MEC2
Date: Wed, 14 Apr 2021 18:39:33 -0500
Message-Id: <20210414233933.266833-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:805:f2::40) To SN1PR12MB2382.namprd12.prod.outlook.com
 (2603:10b6:802:2e::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN6PR04CA0099.namprd04.prod.outlook.com (2603:10b6:805:f2::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 23:39:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 562ed6ba-b62f-47f5-143a-08d8ff9e976b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2605057B7E3FA5442890DDE4F94E9@SN6PR12MB2605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/xDsiaByTwl1ZMFtyx5lmhDLyX9n5mPciskvbaSBUW9TQ8jjuxrUw5t1RNiJqKaLOdj2DfSCSD+bhoTEtboz8DNWDYeEAK6ZZYNwJkuwCqpHkPLqSZCXfG8XWsby6CJYYhBoFsE296Iw69mrHaZSCH4RtCQ6ofLN/Opigq90ZvOLn/reLyI7nJEDRdjlDeN5b5Ie+m+ludZn/bxPKC2A9bss3bXCLaAl3KV6KPREyrG2n6N9P5zAl6QwMbfD9frX1OsMMajKcQFwALYTSD7PX+0rB1OiCWd9g9LNevabTZchfUDqeIt0lDCX9qZyLcbMyNzgzjKNnk75RKPDKTXj1eTKWptDJ4sRuIlkIZMADfC4tS78hJD7ko9hA5vt06U3Yhk2NbzxP3PVusVEdlzMpJ4fjt8a/bnM7zdZJ88ZW2nUAi5C5IGQjEQMK7PbqB8D8i7vkq8QcWJ9D3x+HhFLASIFLw5TxM+07K7aNr2lZx/AyjQDCV2Ru2WfuX175WbtCQJYeAaf/8mh48NZBauf50NRI2I3UDahtJhmFi3eStUIRLMtxs/5EkQfwV8dGbqPOml6Av5l3yY/k83d1BXm0cAshceMwt1Hp3Jmt7i1wAMYcPlQIf98slNRiA5pgTBPpG0mwHAlLXkwSd9EV1hPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(38100700002)(36756003)(7696005)(6666004)(52116002)(4326008)(956004)(38350700002)(66556008)(316002)(66476007)(5660300002)(66946007)(2616005)(478600001)(6916009)(1076003)(8936002)(26005)(8676002)(86362001)(6486002)(2906002)(186003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gRCEnywNReRsJi0eP3Aj5gwGtThv5+i20s/d6CTc5BmSqUe/wytqL196mydg?=
 =?us-ascii?Q?/SgH5SFw9LddJq205C/DTh5CEvv0Gg2JHUmFYUsNT84CyfMJBi6V1aB2VXY5?=
 =?us-ascii?Q?HG+08qtRaBk1ojThaF0XEITlp+/xxqXdG5k+OdM7YcZUN6sYNNBPr/jCYMY2?=
 =?us-ascii?Q?Czt+v39iwEBkhUDRWKd+NPodFtqgiwVk+aL05u6+EiMTlWKcSnjAVvew2Hii?=
 =?us-ascii?Q?zCmvwG9PzeGQvBtUVDMWquzOeywUjgfFnJUpHtgA+Tbh7W0082IQmkiI+hAh?=
 =?us-ascii?Q?Nhm3H/fvmT/iOkIcaxl4ibH6euUHzxbHf1qcSacmdHb0tw2AM2l7hSPtqn9/?=
 =?us-ascii?Q?aeCc/WK/54VsG8VDRJ9cDGO3f9Up/0UatN5b+jF3YjTp/AZV1Sa72gzH8PCP?=
 =?us-ascii?Q?B5KFO+G+Mw9uBt1UIf75n6COhp6aBWGSTMIPFzNHy7du9lWUjbbO47DrZRVM?=
 =?us-ascii?Q?iOWIdYUJvGxXSQx6tR5OoZwMJs7tbNlQL4a68xDH4zQiCp4vJDs/ELh7Vqa9?=
 =?us-ascii?Q?AqjRizhH8lUUzUemYxOHYezyRtB2co6LkQFIloF0hT4tm4/+L/Y7UNbgq2q8?=
 =?us-ascii?Q?2Po8bxE1aK1TnJ+qRJUNAjPDkpI5cBgjnYuI5G2YQ2VzxQV3vHdeC2yRmCkw?=
 =?us-ascii?Q?huBUFb0NWUyFlr+xw15iNFS8e1QR+xCw2AjM4l8y1xGTzjf/WekqgDa1Z74J?=
 =?us-ascii?Q?ARH6rltHUae65TyApe2QdnJU0dx1K+ydLpVkgfbYsPqNSAPBi0wClJZaKbLu?=
 =?us-ascii?Q?gqT+yyaKW7aW5gi+0IO7W4WoRxopjEITm2sjA6dmdLdV9ttpYwfq992Fyi4y?=
 =?us-ascii?Q?FCEZL7PmACxq3umal0KHnqnye80ID6KteRtUFsKnmTjNgOYgTg5V+mTNC7Ul?=
 =?us-ascii?Q?SUAb+ouy1VM1cXUq9TEMatB6oDKtAugYmk1I/JYrXum4RPDnWfDGl7gnKUtJ?=
 =?us-ascii?Q?2HkTbVIE6DcgB1l/SuZIiyg9sbUObccmYRrFeRGhz/bmMWjYcdaf1hFFFVPd?=
 =?us-ascii?Q?oTyMUbc8xbIts8lmM2x6Oik3oLKJIbubgl5TaCa48W82ewMMIkhMj4tpqC0f?=
 =?us-ascii?Q?XPJW/2fDmuY0AMZzeSJqO44IjTK2/hozAkkqD/JUX5YOJsYKpiI1rieso9DZ?=
 =?us-ascii?Q?Uva/41jstzNXDpQm3LP3qB0UW2/zFnpiCxsoPJyQqnh0HhV0dRTb1zzK5WP6?=
 =?us-ascii?Q?KCSMJOiRDCW0SN2URgLEDPD6FcnR9UYj5mL8E7ERizUHto8+5BfB42M+wUii?=
 =?us-ascii?Q?znglwDHEd8oFlKGMWJAX/phLzJ+HHvb57URwSsbT53n6C9s8WtUUMRhYIxYv?=
 =?us-ascii?Q?OCjjp58gMCVfm/vfeB9PD5+g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562ed6ba-b62f-47f5-143a-08d8ff9e976b
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 23:39:48.4996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRAanvjAi90Foz8gXkTmf5p8AnjUlFWpRqjajTdAzEkLltNX8DTvLppYSb/62a2d2MiWac0d70t1QJg4gvCs2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If we skipped loading MEC2 firmware separately from MEC, then
MEC2 will be running the same firmware image. Copy the MEC version
and feature numbers into MEC2 version and feature numbers. This
is needed for things like GWS support, where we rely on knowing
what version of firmware is running on MEC2. Leaving these MEC2
entries blank breaks our ability to version-check enables and
workarounds.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: Id6f672fc69452abd6ff41821a5f2240037048a6f
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 06811a1f4625..a078a38c2cee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1587,6 +1587,9 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 			err = 0;
 			adev->gfx.mec2_fw = NULL;
 		}
+	} else {
+		adev->gfx.mec2_fw_version = adev->gfx.mec_fw_version;
+		adev->gfx.mec2_feature_version = adev->gfx.mec_feature_version;
 	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
