Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2626CC43462
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6386124C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6386124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23EF36EE32;
	Wed, 19 May 2021 16:22:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614226EE1E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 16:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByiVuHLt0PWKDU3QP4fa51gLPqEq8KvwxyMJN7KO/k9qTkDpy6onv3qfFZ5bciRcM0qwviNt/MXrvhwYcvzxfD8qhapXtS5OeQ3eXQRwB1z7pDOx5ip1Y4r6eXn31IdJ0ls71OrYZea+ZzqkI6WVEZ3L857tfyLuq3CqEvGCYGpW/Ux2TrGHOuM+QL4IOCbprj+CbaUVI9oFZbkAfAy682fwWhO3OCWPEqtFDHpLp4/oXLmDC7ejl6N/DHBFzZ9mAUtyVxG6AI81Qoetlw+Y+7aGVpv3EBydu/5qAS9gzp1piQzCnnxW4LA1UQUjVkQdUxq1lfeVN3O6IEc6GgaxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUBqxUny3MBREEn+BLo1Kr/FDnl9gsy3B7w6ED0aCV0=;
 b=ToQA0gty6GxiIuBy6pZdt6TlDU4vqmfC7WLHWb8VV58rn7upg9smoqUyFcAg5ZNk50D5g481uV/e2DDftHO0620PAq9W+sVWvk5j0tbmhA9Yo8ep01jyZ9+uCaSp3D1dzMADCd+ag5NL6ekhIHOU+4LBEb2Tjk1oNmSd8K0+gNn2SEmtEwuyJNRlU9cQNq5Du/bCVG+arKLMuXYaXPF7HNX93t2ysCVpOheAwhck9Lu9CSkyliSIx+3TuRpRXh96Ekt9awMWDOa3xdQZ49qtMgqYaNeBsNnxJLn+N+W3dyPJd361oAcLubegNCiFLxeViIM6yirecBq78+xIwKtZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUBqxUny3MBREEn+BLo1Kr/FDnl9gsy3B7w6ED0aCV0=;
 b=Q9V456xM3PNUXsBCG8GCeM6t3G8SH537dnQf6heV7LzuNJTjVCsG33E6rTJz0ge2w45IvML2HXIBWTGQWKs34BD7ET5gyFMCrtwkGxDLCYBYGDtDYVqqXrbi4aix+AGfRf39N18FdZq5SC3vhCM5vvX1yR6tCKincXcw1O9l0hQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 16:22:53 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 16:22:53 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
Date: Wed, 19 May 2021 12:22:32 -0400
Message-Id: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 16:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90bee8ee-b8d9-4c70-aad2-08d91ae25a8b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB325964B767AE99AFB05D261BE42B9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eo3+pUEQQ7LAU2fkczS95XoNUmLv9QnLtqp2qJLMGyzeCnT5KnzniEEQ6LXxQ6cGXNFO5x/ULswOEJiWsRi8AvB6YMb+7Qiz651ceYy5AxMkyK2KQFl18zbv0yl7TIf0xPWgGagiwdDCZItwm860+whQmNg0lpyMi9TXypOfkBkqgVNAuLSIm/puK20Geo/PlE3PJuOQ3dzu5ZEsQl+SvvBtAIMLEuv1uUHXtFOaod/ZdYfz8zrGRfHn+BF1ZYUSzoEphUIzsmWHfH77CFrLii9YzvPnIrckBWp+cNiT8SNaiSlP5qxMQxCF5zsva0dh70FCN2uaAh3mZ9hvuuOadAmaScfJHcdb/mw+YkbUV6DdDV9/nIC7d2h/PYzgijUw1kMTy8hBHKMNCPiicE91oPOjG8JzqOeymkxlRmdSnPRK7NfM/k/XbU8UJMOJQbQfPwl+caD+nbLD9KRvk/ggwlc7KuVJTxHMNaunrs8oj9j8C+VQBsYVNtiRfbQvl9L/4GnNBrsUlrrjHoBOSUStIs7vH3Tkiop1mdmcXV1zHspoiIynkG4e2YjT/Wn0Q9gEpS/aKIgPyI5rw5VqsorJA1+J4Cpz6YO1HOt5AR/TCoiqgYkx45WOnWbVK7HfT5qKD0uiZFndm5OLCYA7HeZp7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(186003)(36756003)(4326008)(66556008)(956004)(6916009)(8936002)(16526019)(4744005)(26005)(7696005)(66476007)(6666004)(52116002)(8676002)(38100700002)(66946007)(38350700002)(2906002)(2616005)(5660300002)(6486002)(86362001)(316002)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/4xrGca6PBkGnSB4pYJDElheVO0JJdIlSiup9Cmjx+0iVt0C3JHGGHsteea3?=
 =?us-ascii?Q?lITfhoR+aG/PeCO1PTqdEqKNeTNRCjexefm7aK1UN/bpUXQKWAz/++fvblSC?=
 =?us-ascii?Q?adS+V+XCLWbAYdjIdDrVwqopg+/8NYZqTbavRoX0FWic/7HLPJcBDQUybgZj?=
 =?us-ascii?Q?jMQTQaEV21or9aoCW0jXDwOwWnu5mGrI7WNl5RlM4AGyKoxLHPlZc83W30tl?=
 =?us-ascii?Q?JfysXEN7oScjmMi2O4IgftHGKoQt8EF7PDx4rFccxcR7SJ4ZKIVaA3jEjax/?=
 =?us-ascii?Q?RC/OhRyz9C9GQmlOM+Q9Mivl9UcfDLs3vo021uNxOaNgM60+5KcIXzf6b0z+?=
 =?us-ascii?Q?efZH7VINqdjwANXI5B8p7CPcVV2EwlV86+iFiBOxIAL2cj9rF1id9Vjd50ym?=
 =?us-ascii?Q?Vg1l2kjeazKwj/xLAqsheTgYLavXG+HnuigMN+po/jlJnmc1VCM15DUqh0iB?=
 =?us-ascii?Q?aeqJwrA9jDzb0Vx8NdfQTH0hPRbd/ifWeA7LLUiy9nKl7Rnw4vj0tmuktN4d?=
 =?us-ascii?Q?/tPaNlbJDVFVi9QSXzJ1B18MiIv1srlzEn7lkviUdBOQtog12eNK05vVBG1a?=
 =?us-ascii?Q?ehVnFMKvgLO6gxKTZapOyazccrdmMuN1dcfpTZjn5rrBcQePCdntxmd9mT03?=
 =?us-ascii?Q?sRckR8kke7ncw/3a2372jvgulwD/E8yN0wzvIfAouxl5rDn8Bkb7f9KjnKms?=
 =?us-ascii?Q?jC3QpIYh4lvhtQx+6oKfdKrywyL3Ua+E3KiSav24Ad/oE+aoZwglrR2Lmtb0?=
 =?us-ascii?Q?ZqqT9sceEeV4w4/p8DoiU9EVa6+aOxpMogWhPEqtx/9FYaVtogykj/2+GgTt?=
 =?us-ascii?Q?g7YI+rW/jlbxLLYlMurlET6FA6pOoKLDfJXytm/VVEgj8L8yio4k8wFs7qg0?=
 =?us-ascii?Q?iLemP40y/iRnHHzs49qCLMxAa14b1Rtp9OuMFUdV83f9NvIzI2cRZUBAotzA?=
 =?us-ascii?Q?P3nM8QHr0nkSQDh4g9Hc229Ga9+fETHU4s1JaX/h/vf60rQdq1uDOTygutwV?=
 =?us-ascii?Q?NqI8o7xqpcESfUozC8G3Oos8tp6cs8MhQAio28YiqY3PI7Ws2S7o1fWjLZ7o?=
 =?us-ascii?Q?5p6LAY8iMi/IZwzhKD/lWasgnPTsLdkOAZ0D0a6+Ti2ThzFMB8UexBe64IUL?=
 =?us-ascii?Q?sCqMlXKBZYsHAn6//vk5THMH4f6J4UrSY4zYXE9Zay/zTvoZU4noyy9l0ydN?=
 =?us-ascii?Q?EfC7XhSadESXVIEP9sdSlFXbWiZhGfo2+yaMBpH+p39VFKHKQ3HjU0wsPreA?=
 =?us-ascii?Q?X8E8TdjnVbDCOqWdcQPCsPirEoQrTFb1a10L/g6BKdS8NXfEJNL7U+/e1Y+J?=
 =?us-ascii?Q?Pbdly6ibvB8mTWdwnU4IC1++?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bee8ee-b8d9-4c70-aad2-08d91ae25a8b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:22:53.6657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3Yqzn28TKiqJsJeovXMEbmm4boR4yzMwJZ77qV2QJSCOsthfIHGQSLZBaW7msS3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add cancel_delayed_work_sync before set power gating state
to avoid race condition issue when power gating.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 0c1beef..27b1ced 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -231,9 +231,13 @@ static int vcn_v1_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		RREG32_SOC15(VCN, 0, mmUVD_STATUS))
+		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+	}
 
 	return 0;
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
