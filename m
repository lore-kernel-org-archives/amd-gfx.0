Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC0BC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 15:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B8560FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 15:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B8560FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD5B6E9E1;
	Mon, 17 May 2021 15:52:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E426E9E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 15:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM5q80+OSIwfHi5mo4ThCeOEp92fzei5Z32GoCdha3KjSpaAKG3fMADYGV5F62pop9Dk/LpYiFhEClcIRC6Chm/eLz7g7vt2vGFDUsSpFQ2Eq+00XgvxtkuoxC/WCIMN0YgeN+u0sISJzdAgYi0Y9fEhGC+vg7j4lozN6zd3QF/EmRrBEUWJk3e3NjhomoCwnlUNoqXIq1gQ5HDJeto2/w3p8jnQm0/wEua7QR6TXDnKEEgRbJlMvfXzW9Ct8rjijhjRFMYSC6/9YfwJIvWPy+el+Bcg3pBbyrcjEeZIqZ5pylE6dtEKjNct2bd7F48EdDJLAw6z4qNHG6+H6hudVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7t1iSiW193DmDjEkLxe98E5YPOS64HriFMl6xfHYw4=;
 b=IwwCPuGSTol4iJgNBJ5BGl2LLt/rmS9RtV3IauUcJbALkUyE3fQbO2saXa2tjvUXzzNA4KRSJGzr2fXwwFIBf9xn6cYuLLZLArXzi+IJrwXJrdHvoNaAie8e9dVrEK/pEIaBU2TF/1pkHKCRMYVIltqLrtxjSsZyIZUsReWh8cVXX58cleKPSKGzfUqsVr1kCx15E9cQoDk8cbjvbv941Hj+L3k8mg+EicRNuyK9/DkgG5BaonOi5hSxagPaXsAsEOEPRBhRNUwvNJO2sPQDgTwhpAb7b9V7VNvwQ+yr5/5ijNKuHXCqOCFet3ke4zBaMbsumAZbWaB6uvLHNvvg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7t1iSiW193DmDjEkLxe98E5YPOS64HriFMl6xfHYw4=;
 b=Tb+YVGSKnIeb57c9M0ZrKiJTOPSXUFwE2AW1i1bala3asyC1O5gMF6TQcF2lJykN6W2JHcZLR0NtknZ66zSLSlZG3C0EYLApkMLT+R4Cnf+q0DEW+TXYEKabz/1wTFiYwal/rFhqtR6NZ379rIYkmVM96E7mADQUBzq4F+Sk2ow=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1818.namprd12.prod.outlook.com (2603:10b6:3:114::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Mon, 17 May 2021 15:52:39 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 15:52:39 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
Date: Mon, 17 May 2021 11:52:32 -0400
Message-Id: <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4108.31 via Frontend Transport; Mon, 17 May 2021 15:52:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67ee1dda-990c-4d95-f76b-08d9194bcc25
X-MS-TrafficTypeDiagnostic: DM5PR12MB1818:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1818C8E402A299696D3C101AE42D9@DM5PR12MB1818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6suLnPrL2w77FyqryLMQ7zHXlG1+7kU6CvzwQvXrISteBHDyv8beHgbsfq+GvScyAFJp08GhwRVeNflC2h34EJhsIpHTH5nruev4R6eJ7mMO8bfVCSPjcPfCSIDUvlojHhfhk2sXElOI8+y1EWK+7IxDEBxF9f3h8wJUKC9aeY/XnlXeTPFcf02+sc55gQ+2lrSnX5GfKkCPvYG55N4CGSP80yDPNdK6BwC7z25W+gLv8PNY4mT9XRj1rk5qe09C1ktxOIj5lTNw5Hs3GjSnzk28pLiESiLGNS2weCFJwqVObnQPee2BJE4d+/FY1o8ttyJwGjC/Acs700fsAM+wZSDyUBvtYSomKBiO80C/N/yDW8tzbwkqsv+eqePoNUKiS7zAbJC7sOfGcUxNmbMym++b43RJlWoU67zQgR/IYrI0JHp6IB1WZsbJLDJ7KrMc6NpdagJZkOW4kf/Ui+E+L8xVGAt0Gi3P9y2aOYDSYu+vGQ26OMT+SVKgtuouwxUWWoUw325nYu5yvtE3zbJGcq4XsIWDTI1gXp0m6ypQDAM/up5Hvih2hMiVJ58oRGk4K9ElXbDkiPiOEESm56aeGkUkThQxisvuBxUFO5ggIEf2ZyC8Lo/Dnl8sayPZNc8yNOhKVt9OKyhuE979ep5x/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(26005)(6486002)(2906002)(36756003)(316002)(6666004)(38350700002)(478600001)(38100700002)(8676002)(2616005)(66946007)(86362001)(5660300002)(66556008)(186003)(8936002)(66476007)(83380400001)(6916009)(956004)(52116002)(4326008)(7696005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ok5KFcHnumHJLP8BcsbeoUsopg1l6cCM919i1psUwskureVzq/AByR1stShd?=
 =?us-ascii?Q?tjQ6BkjuF0JMjuUopDkJ/ZepP++d1MB4aY0DHt3Vf3ZbBo0vEtwAy6FB+AtC?=
 =?us-ascii?Q?aVwx8HSOUighISP6q8rwtyvZjBixBGWxaWzubR23ndDhNdrP1FZmvJ5JPcjp?=
 =?us-ascii?Q?UIgTxPaAkGagAJoQXIuE44kpriEBDZxgn+NDfdFesIbAf/KOF7FvrW6S19P6?=
 =?us-ascii?Q?Rv442sIyj76ZwRQGBCkAclwEQsWxetxuadiiiYSaSS6AP5i1gaeg7MPUvoW6?=
 =?us-ascii?Q?zwmA9FXutnjLXSnMwk3R2Nt6iULyznr5jwG08IESy0AOP8TuE7tk/ZavVRgU?=
 =?us-ascii?Q?GvQA+ax85x3YkfQ3xYVkecdCShFhQOamQllHydwq8t8+tAtfNSAHZIK2c7Wp?=
 =?us-ascii?Q?bNKjKonewMwwprUdGGW3gj4PiDQvCG9VOMqmf7q8HSVNWMpfIW5+aeIWRwG5?=
 =?us-ascii?Q?vubUMAC/blP2y8qrcw6osBEWjrx8zEeX+ypTnFp/PtxSeg6gzBbCIszZUbBr?=
 =?us-ascii?Q?5FjJ14cVgdxouncGXU86bskRUFALsA2VFhBxcuOjdW5w9SMGgI2xkKPVQ8yf?=
 =?us-ascii?Q?XCNrprZvyngda+WsTzuOkwMSJrIfLQr2klSqHjc5YKa8O0A9DWSVReqS/rZS?=
 =?us-ascii?Q?NCpcv5USOfQD0obP2FEex2/AYORXvPPXEPjA/w+DhD3QUpMxdl7cRIu/JAiT?=
 =?us-ascii?Q?FspEZDn8xCNYK4i4XCHGtxU/BYlT3QNcAHKy74Z67ROzmf0chWr9hIbSaxCG?=
 =?us-ascii?Q?u8FnWsAFoO1DDq3JWJPzMB2qA2juwBQzYlkuhhSWeUWC2JsHZfSHpXLaK1cM?=
 =?us-ascii?Q?WP0ce66Dlk5f/l2b5L8cQ9ATq/r74MGIgG1xBUK8vntzXdgJPA1lPK8Mcpyj?=
 =?us-ascii?Q?C5usVk81uES/a5nD810nrYqqHoLcY0ToMgj7PTogI8g1xzRU9UKui7am3tT7?=
 =?us-ascii?Q?s7K+VEBNpIGuuYCb7CrVoHPCWsQEUFAPP4nNZ+86xx9jMGUXUw5t0V3POZqJ?=
 =?us-ascii?Q?uczStatF5BlemMNpCB8RLy+4AiTlk2CafFHfBVSeoGFNjBFu1j9VHXJYGwnd?=
 =?us-ascii?Q?D7qzbv1E+UEKCZ5OfhStP18915hVS8J/ttrytIZVp4uekP2yTEjEek0hVgkn?=
 =?us-ascii?Q?AsZiLh6VkfCZZj/Ol+QgtV5DMdm3vIz6p5/1hNwaLsuIojrMer0BmvsDq95N?=
 =?us-ascii?Q?cFFv/9ndhkw3zUzaVIBnvWiWJ7p7d/HXxgZ2q/MUOI7mtEj3DPX7Wq+U5ozV?=
 =?us-ascii?Q?L0IlsMvX28KEedlnEWeM+h6mBPUaSv4Zj86IiGeUH65gwXlVEhyFXXNWUjnX?=
 =?us-ascii?Q?0Zu/ADtK7QYbA6YKO8WzBc7H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ee1dda-990c-4d95-f76b-08d9194bcc25
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 15:52:38.9886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ak8Ird/luOmYaT3o8bV4AN3YaUOfJmyJhnRNxaUtP0wo2nIz4GlXjluARVTe6stV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
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

During vcn suspends, stop ring continue to receive new requests,
and try to wait for all vcn jobs to finish gracefully.

v2: Forced powering gate vcn hardware after few wainting retry.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2016459..9f3a6e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -275,9 +275,29 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
 	unsigned size;
 	void *ptr;
+	int retry_max = 6;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		ring = &adev->vcn.inst[i].ring_dec;
+		ring->sched.ready = false;
+
+		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			ring = &adev->vcn.inst[i].ring_enc[j];
+			ring->sched.ready = false;
+		}
+	}
+
+	while (retry_max-- && cancel_delayed_work_sync(&adev->vcn.idle_work))
+		mdelay(5);
+	if (!retry_max && !amdgpu_sriov_vf(adev)) {
+		if (RREG32_SOC15(VCN, i, mmUVD_STATUS)) {
+			dev_warn(adev->dev, "Forced powering gate vcn hardware!");
+			vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		}
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
