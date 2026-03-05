Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A7FF513E5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 22:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D0110E2D8;
	Thu,  5 Mar 2026 22:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0AMbuV4N";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6F410E2D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 22:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOQDqvnAp8sAoId1gxSaAdCZA8HavG7IDvF09V4VPRszb9FAlqmvmhc4dCuAP00paPYTHtdkrma5Ok4rAjNwu0QNC1JXfKsCoD+Qxh5utVK0OTDNF8AnTLzsWq/uHz9F+1xgfRkNozE6NDl2+5PLheSpywov+pbuMWr+ZBcwetGtag50O3ewWoLQdIVb+AhVL7lO/QGwt3sZs6c/1j6tnzBnpNIIYj9PbdOXpw7cvk6YQ+zo3xiMXHiBKxAVlnlNgT33wPtuOPljjtoDS1yru8uetg9ptUyl7AX/RcBCzcZ2cqehjUTp/uHJqiXOD33RkvVs1Twppr3ha9hQ4T5yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD8jjfuFBr6Ouu+cAqEOMPJxJBYsf5TWrcmCDWOSGSg=;
 b=yjA426fU6vH7uoLp8gNhe9Vy6Y07E+85h/agHfzFicbElLrRfPOFBjtPpJQCYEWgKrMZh9AV9DEy6s1fckhCazpekqmKiYYtiT2KEUWWLnK4SA+yXr11HfBaEHLPkkxYUNCeC4mWchDSsYUp4/8ujTMlD1Ac7uX/5d0cP5HPBVKWzfbpe4zrNbn5hfuzCyfRKpzg+k5Fz1m5D94Hv4e36Z4qDAFG5amGDj6ee9lR5tT9AHUbvCoscyS9OcQPbX3EcdQ2AXPzxlo40zL2uGOAWzGP1vqiyhSj5s8i5THpZQaGEucwg83LB8RsvIHQrYp0AheP7KaaJnvVZYlWwsUexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD8jjfuFBr6Ouu+cAqEOMPJxJBYsf5TWrcmCDWOSGSg=;
 b=0AMbuV4NSUHQxjGjsAwIAZtqUl5Zr2fSSG6R+5a7l32aZjoOrQqxMuGd7BaKOAw3h6cRmiFJSgfeFe3N4+8a19+sW0uLRBrlsE7EqLixG9xUh2rFzcK6c6LSF7llSNLwQwhDdp4b5+v8jEVimRlb45sHwEMdRbgAs8X/C1MUf4Q=
Received: from CH0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:610:e7::32)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 22:06:05 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::28) by CH0PR03CA0237.outlook.office365.com
 (2603:10b6:610:e7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Thu,
 5 Mar 2026 22:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 22:06:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 16:05:58 -0600
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 14:05:58 -0800
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amd: Make sure asic_funcs is set in
 amdgpu_device_ip_fini_early()
Date: Thu, 5 Mar 2026 16:05:40 -0600
Message-ID: <20260305220540.1354776-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220540.1354776-1-mario.limonciello@amd.com>
References: <20260305220540.1354776-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa6be64-7f0d-4efb-33e0-08de7b0364b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: iemIXhByn0wHGRHFv3nnIIsuS5RpqqM9Q423XbzGIakBCAjqywSzAZStvnWUiZb8WF3TwRRMv+zmH79HLZyFFaZKsuxpU4hVhIZAkugoVk0vQVtCk5G3gi646VRwoVcCBkzBeM3Df1HOXwgAeUmd/unK4VytxPmmNEvUu0iZEMrlxd/xMWe+tv9lGB33Jza8St6WPDYy//a4YCHVksVD1EzW83k/BC9WvolUEtQqstu5ZS6yBL41vEoMIyN60Eflr46ypzrVkOoyCxKHxv/UZy3ePXfXX48pM5DlflFmKR7jQEuJ4RGjGMs9GRcNiNgg/7kPOd2tJDnQEeQF8rF4d6NUlAVG3eP9v+SYpg8Jfeu4mv3Ywn0dIkpZHqzitE0Y7D6szYFyQv/X7SQdeO5LbeNpsz0bYfJgM4p2vDSAh6jVi/JKhuIpZMPrLUtWxBxjwAbpOtfijCy/vegCy7fSAarrAuipMKGbdwa98u8c40N2NERCzBetTbT4C89Yb70eFFsSRS7lcc0zzsSoxKszdkzuMPFo+5uIVps7A/+4N2ETAn5bhC2OfrrPusk9Khta1xoHWcVkvILt2UY4TuJPpBzkitZzCTaBDMcawoa8a7O0Dg6fRyyd4NfXH7NHbaLMZOczN4og7J9yZY6tcWmkhG8XT3dUl+Sf3Rjj/yhnr0RTUurWNCSpq/due4iYRKrqtjELIWCF7rRr2xtQ1CA2lGxVHQCrF7w3SD9gSlhODuhKcXDXgwwMbohUzrj7bFD1zi+Qm+1/HapqcytDWeQcyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hacL3MR1cHBGF3VlxRqBoxY24/TM9IUIwJHPpM8bCbR1t2DfN6C+Q2OydQB44Bp6D1GpZYOtLRVhF+a3iFhZuDWhEwAEhV2vMd3ZbTOnV9Ozt4DbeHxTtvdSgRQ3uSmcqmrFYZ50lmgrVaaRqQHpNWkR2z41wTQn84jkJaYLlKccUNdfVydOLFbT/AHj9NHfthXHA4t93YheAhBEQDBNFrEm5TbjHlUQJubs1527JP05YHE5wt0kMoTL8I3yBbG2iBkJNtmki9lR8vtD5KEKPy6Xm65GQW0sVF62vr2NGZ3HmhqBOQJMl0qvRK5Zf0rsKVo7JARJqbDElt/KUuvc9Gts6y7L6pFeuC2NJBCG9qLWcMFty6HVmLq4kfFK3ZqE976+Bk0+aMNSJhs6HzYGv5s/RfKhtFgL36/t/25g4iaYIPryOzpRnX+XOGs+aH2Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 22:06:03.7023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa6be64-7f0d-4efb-33e0-08de7b0364b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If asic_funcs isn't set then the GPU doesn't cleanly clean up when an IP block
is missing.

Fixes: 34355e61835e7 ("drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is reloaded")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 74cbe58484fe2..6161e30e0f430 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3554,7 +3554,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	 * in the APU is to trigger a GPU reset, but this should be done during
 	 * the unload phase to avoid adding boot latency and screen flicker.
 	 */
-	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
+	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu &&
+	    adev->asic_funcs) {
 		r = amdgpu_asic_reset(adev);
 		if (r)
 			dev_err(adev->dev, "asic reset on %s failed\n", __func__);
-- 
2.53.0

