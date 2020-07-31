Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23801C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFA22083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="29VZjBWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFA22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8E66E999;
	Fri, 31 Jul 2020 02:44:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB2B6E999
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iweN56+sJ2lnj0aPEPkDrF1KzRr0IaFSxRZLQvYtX5kZfP/SDRmjnBKO3+jrGhTSEa8FHdsGzIA1np4Zz9HyqprGQzWrAjDUCf3oQrTSGF9BxwT0t/qwj0TFPEzziaO8i6yyOacrPuCvJHZfOcIsyXnFqVjxPfrlID7JyzgKUjgKPy6D7NoiJHrjbHqE/c9JTAo3gK/QtFBOvN6jhCkCz5czgVkrGlhDGjzYH6rQOvKuLK6qsyQSNyfIAWyY5pZz00xSEvTgKvVy74irMcI9cD9dGgAv17KF6bB6n/2SNclHyheiYX82aWFVnzCS39SbpOecRBMvWo8PkZHgPFfW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drZeWaN476E0PxxKo2MtStLuJvEPRBW8bVg4JXIuXLQ=;
 b=K05BYiR/5B86dAeui6Fgu6lk5jUyXvPxy8F0VT/z3TX083K7EUY9Z3uMUT1MRLNUmWrYYQO9dqGUC2n3LUqGGWNVrg913SLsyhhG9rsd2iNq2bLP5FiiEY13HaH9SVptF6gIyqr87D6XTekcV4BjoYU6adLdK6i2a/ZbxuYAKiJi7qr1yhIOSCYVlLDAURhnxzbvCJzsqGDkWknBuev5ZGO8u5iiWJx1SeRxRicQ99yhVJkhAT8T6GMY2jvCf8/5jaZBfKHorFCXW0hfk0NP4gdur1NgOLe1qOHkKUE+t7p0rra/gfedFa4gWzPlwAWLkALeDNfCZzt/tPnNXxu/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drZeWaN476E0PxxKo2MtStLuJvEPRBW8bVg4JXIuXLQ=;
 b=29VZjBWlnghHPpUxE2eiDftWwc8Hn+SpJ9ddSafdE71tAqjl+7qVfXS5BoicuhP8ExKPbbDIt6XXB0telfeg/+o7yVkW+GlmO2iSAHaTbopoRt8YO5gBhl8jm9Y05j6/MC+Cf2ACRpkKNJMNCmL5ky911lymQ2MvUNw8LN3w4CE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/17] drm/amd/powerplay: enable gpu_metrics export on legacy
 powerplay routines
Date: Fri, 31 Jul 2020 10:43:08 +0800
Message-Id: <20200731024316.28324-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:13 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 192cb5c0-a312-456d-3e82-08d834fb9d4d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435D326391E1E49A998F4AEE44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSBdNxGWVR1RnsiSiszklGYpFSqCivYtF/KtEnek1RQ2d+IPg9czROljZZx1rB3R07CDXGDnD3ymI1QFxGd/pRqdb+tpju8j1CBU/fQtPLr4rhhJuXayKPILMNSp922JVuCDPKxR6wWiu5pEVkPvLRJKxynu+68i0sQJh7iN2cpp1pBpn/DbatOrWWZJxle8Esf3aCMxiBiWlIO8jmw2zOf0rulhiTr4ZAWrXOHxy+1OEWH08k61+lY7olv6LPJSM683WARA89rbwcczyHs8SOiKlOOVMkeqjpXVc2WnGsvuk5rkrYTVLxPeheWb2uDPMsaB7JUShSa+cjKqtxK2Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Er+WnkVrmByqKLM/j35tRgKXEYRYaDhoT6urs8u03WlTXcLV4rg+oyzYwsv+Tr6eH2Xbpu1gjGfZ04bezrxlRnHcaUz5Ogvrvqu+2977ZqfZq+3eFpgokE4BkQ1d67L+9St1tXPNVXvMjQ1JzwGDeZu7MmmM2i3jeJNchsP4vO+6n1VlPXlvGY1aW63QflokoOyFP3LEvtZTEuhPF+Sijv40P6FHNe6si4pYsENUgo0Cce4vGL6Y41Zhp8DRftmUqM5ofT/GBnHTCT2XaFXStNBVsXYCtNInmAbx5d4N/UXQbZ0gKn1jkuZ+FzWKJdgFMOKkv6l3Ztoli8DPanrMon85S0fG9hx9EoBqi3WKmXDuxSSPlmCFJKfhG1Ib2lpYBWPrgvlvL3hUWlZwAghKS0QnQIsGZgwJ3A44pydwKvzMhJg9htQ0oddow6pJeP/qFbTN3kh5AlEW5wGGJJ8+3OxbCoSARoLdNZfxdlIIIGaOK7WY0S+D1I3N84WUhk7ZgyHM3klmaC4EVYB8HKExg4MMhxNTGVwlaLUCLGYmmL5j9IhwsVDQDblB6WYCdcvu78icaaOxBHtco6yqhwpKeQpEi/UBLw4uQ3UT3uIH0G+lzWaNAB4IomLZ4rGhj/h78XkEa2lkC78w6Vfe5xjLow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192cb5c0-a312-456d-3e82-08d834fb9d4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:15.4855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flJExmuaoYYQWh1LEgNG+1fVKwDqQoXqll6gYVNSQMJ60NSoFzPgTbmI72qgjpvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gpu_metrics support on legacy powerplay routines.

Change-Id: Ic2f09babe7e6bead9a838b7ce3c94bf8d4110991
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 7e6dcdf7df73..a6321f2063c1 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1598,6 +1598,24 @@ static int pp_set_xgmi_pstate(void *handle, uint32_t pstate)
 	return 0;
 }
 
+static ssize_t pp_get_gpu_metrics(void *handle, void **table)
+{
+	struct pp_hwmgr *hwmgr = handle;
+	ssize_t size;
+
+	if (!hwmgr)
+		return -EINVAL;
+
+	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_gpu_metrics)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&hwmgr->smu_lock);
+	size = hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
+	mutex_unlock(&hwmgr->smu_lock);
+
+	return size;
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
@@ -1658,4 +1676,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.smu_i2c_bus_access = pp_smu_i2c_bus_access,
 	.set_df_cstate = pp_set_df_cstate,
 	.set_xgmi_pstate = pp_set_xgmi_pstate,
+	.get_gpu_metrics = pp_get_gpu_metrics,
 };
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index 15ed6cbdf366..1b3529efc91e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -359,6 +359,7 @@ struct pp_hwmgr_func {
 	int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
 	int (*disable_power_features_for_compute_performance)(struct pp_hwmgr *hwmgr,
 					bool disable);
+	ssize_t (*get_gpu_metrics)(struct pp_hwmgr *hwmgr, void **table);
 };
 
 struct pp_table_func {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
