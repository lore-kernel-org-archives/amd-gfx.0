Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81665C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 10:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365BD6525F
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 10:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365BD6525F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D4689E47;
	Tue,  9 Mar 2021 10:32:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6776089E47
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 10:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk3p9t+fYkD/Rs/MzG3aI8A6Z+CqtJmAY7CLIpI+NraC6RdcrXGKFbimbc7zaQmbQCBwYDC607RFQ9J7oJaAK7k5wKF6T4z8uADha/kuHCOB7Xq/fywJ05n3m85bMizoPPd4jnsAi+uNhkDCcDhSRsBiiIWslraprR2FqlL1z5yDjKGfZq54wF8Qyin0m5+ATtyt0Q5g2W0DCRhBPJZTTik5fN5yqDIinREJKGl1LesVWYkdpY51AjjCXmDqS5HucmtF+dF0uliUg4IY3Ag7M6bmW1A8KD+8t4PauYgKsQOtadEM/n9fuifbfP+BkpNBEjzNbWxSA+vxGaSGvcw6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abbPzDy83YpKCKNF3N8u2HQmoMILb1DrinHPNGNBe5w=;
 b=n3jyQQ6bWeonJncEOUNnl+xhimTbBQhNY0/MWwcDPRn+eWqMYMZpuDEizFSJ/HRiV3C78FwLQfwKSAoqZoy2I4kiI/jrbq8Vvc3AKxwIIk88LnwWiv8fSHSOz+4Nt019v+FHYhtQBBMAfZSR1tgPl+TxJNT8w+ToNY0nBXn9VVrAvzXQF+z4Uefg03JQbL5FxJ5QxThZSsv0htkwYKXU6BPjyMHe12oru8y5be5/vNvaBV6i/jjxFyTqdBdlFPsr7ZEcolrRJMGRf4lybqqhXvSonR3WtK2zPAv3baViIi9kXZRO3C+z2+XmqQ43O6U538T4aCJZ1TCbPwMpCQKu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abbPzDy83YpKCKNF3N8u2HQmoMILb1DrinHPNGNBe5w=;
 b=nvOynTaOaaEIIn8zpRuRLK29ar51yXhSKW/dPPGRPwDUfS9l9Joq2zjBLj+HMW6FC1ABH3HkHHRwZxeNH/ug6IWcdcd1YBNLdhudWYvS7hHb7mWHK0t3g26BlglH6Nl3LF0W5bTcrO6t5V983b6IzoORZiCaF/aZR6+CNRuQ6fM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Tue, 9 Mar
 2021 10:32:23 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3912.025; Tue, 9 Mar 2021
 10:32:22 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: add psp RAP L0 check support"
Date: Tue,  9 Mar 2021 18:32:03 +0800
Message-Id: <20210309103203.43483-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK0PR01CA0057.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 10:32:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72defce3-3fcb-4eeb-ce75-08d8e2e69fbd
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2941D3028B008677F8FD3754A2929@MN2PR12MB2941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgJTmPNk5sXbmpWjwp+cargBbhMXPCKOgD7l1+gePWoOxuZO0FhuHDEhFxNhGO7/MexAYOHtXU8U0+0jdy5rOuw5LlBb9t0MgIdvUhlcJTjZPcwAM642w6CWC418ivMsXwjI85WQzVliUFiHY0TjkKIaPwMvmP7vAmn2YDpBsyybvy4Y0CWWHhWTMe7dK7fYvWsPzKl4bBkui958zHCTN/oH9IYhFQOuGFoRyWh9IiLRDc7cpi+3n0fV2rbHD+qqTHAVsGQn9olSwxzVQhma0zGo+z6wITfMRUJY7YvzEkfwIpKqeNE6dmxSOPeZMRvdXaJRnjp49r+6UGqV9sYP879/gtQUC3S2JNyF92TSx3/2IPsNKG1wJesg1AS1EN7VvR9/fPJ60P1LcV7gOpJ++q9y/tKzMBmdr/J5/CwX+7ykkWyQZU5wSHNteZ1Rq4kgcEFkVXQaeNrp6JJje1W8Ydxl8r8p/u4RGBLeRXBoxFe4EMp88WJoXbcbY52M9c7msV74JQ4rjhMx07DdSu0++w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(2616005)(2906002)(83380400001)(956004)(7696005)(26005)(16526019)(52116002)(1076003)(4326008)(316002)(186003)(8936002)(6916009)(478600001)(86362001)(6486002)(8676002)(6666004)(66946007)(36756003)(66556008)(66476007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?92WK1slVvx8xQ/aMlwDb6fyZxmp99YsP6hiOF+WWorB3B0F2A+5oVtJ7iNlp?=
 =?us-ascii?Q?x1UXePtezIivIwbVsHXRqGcnQFrPQxEs7tx0Wn7LHHgnYVCQfY+AQa4ej4Px?=
 =?us-ascii?Q?RnV+sxvLB8swWy3C3/TTTS6c56w7yiY5yLwloQaSJ8lc2mQ7nJp8029DwX6M?=
 =?us-ascii?Q?gh3floidQgnVqeUhHBwFtBrCzbMnAsJOhcP0XFq0DQumzDAFXYlwgIU4SfHY?=
 =?us-ascii?Q?D8PqTtnxFmvAn4tygqbTPgQejuHOTn4UFZHlsa9bAtALP+aDtBxBXC1pFyoU?=
 =?us-ascii?Q?rQjrUWCa+4pDsn8pfNs2eHhE1h/u9Ma2VRCgUBjYTlHpEw5TpKBGthhW+B+I?=
 =?us-ascii?Q?SiejMinLrXw4p0Ovcjphgxnu1PIhO6MBgchVhwmeLfFX+mkoFvuEmy5f28iA?=
 =?us-ascii?Q?IOyBJE53TMldwGlFXHdF4olF7hmW5/tGtLFlVmeULk6R/lL++tA7zb+ezKmS?=
 =?us-ascii?Q?DBGF4ISJpH+VJNNsEa+5D9a2yVyMO9UlIVc7M/xuLrTOClNdAILkisABPpio?=
 =?us-ascii?Q?jJVkGPgPywxL7yuS0mcmdDchDirvI9Uu4C1K38y4o4YSQPqSkt5H83ZjRQ8m?=
 =?us-ascii?Q?NJpk/9d8T+o8pAu1SVBs37HR0XDxxvLHg6kaSWdddKklBGnLOWd7RVPqWjNv?=
 =?us-ascii?Q?RfYdOzXWWazNp3PboYEANzzPAIF8GqukWkkNHWmao/zpHF01dEWxjRgfCnHg?=
 =?us-ascii?Q?lEo4OIAhsmQmvVv0EGIsWeROI9K7hVYd6aLE0w8+4SkbHpwyRFBoxeGUhnqV?=
 =?us-ascii?Q?2Zg58apMM8bfZv+pHD9aU2rbHmIH0nItUud1MQg7DLbnPkBx6X7SH8+0kNl+?=
 =?us-ascii?Q?mqLleSTnDWqa19E7+4SJCo19RMz+si+7N79EYdtJSYHGdSMT7UtZ6weQljDd?=
 =?us-ascii?Q?R6oKoWUI2FDHuL8wLZCBC9x+rVkIx4/P/RAuxz1fJZDXy1b4Iv2llVyWGHvW?=
 =?us-ascii?Q?zmXX7n1/e4symo8WeSkOaPQc7U7OiFMWOuhXR9vPT9Rc/F1zuCObqG2FFv0J?=
 =?us-ascii?Q?ib+3HqsCkBNUi7t27R0TvF+aTF0ViVOKSysk0FUMukHjg/znpJHpQv0WjiGk?=
 =?us-ascii?Q?f21pcfb0FLXbBFS27Yqx3GwLJv00s00m9sdW/WRafH7pJN42+j5vtFFJDa+T?=
 =?us-ascii?Q?yUnkegr2M+ag3vEfEsNt2N/wdqtf37ml317wQFRnEqjCeuf4hZSahBnWmuia?=
 =?us-ascii?Q?83vFBSLnRUGnGrSWkF9alH8UjyLbeeIovCe7LPhmQqBykt2ss+6wy/lu2/Y2?=
 =?us-ascii?Q?ocKl22FLmQKU2CTJYGQwWKlQWb9rX9bLChIC+bN9kdmIPITaf2HWNpqLz4yj?=
 =?us-ascii?Q?rXJ+yJstuvfQKPcbG+HEW72I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72defce3-3fcb-4eeb-ce75-08d8e2e69fbd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 10:32:22.8164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCFGchOkqhr8V8AT2VxwfOzMtdzDrxK8uF7t1Xv0CA/rrz3QUE43WJMuUj7D/fHy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2941
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
Cc: Kevin Wang <kevin1.wang@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit a77e3752c319e479c538a84c3b0f6d87f6fa4bc7.

Disable PSP RAP L0 self test until to RAP feature ready.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9856cae9a39..80a4dc51951e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2365,7 +2365,6 @@ static int psp_hw_init(void *handle)
 {
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	enum ta_rap_status status = TA_RAP_STATUS__SUCCESS;
 
 	mutex_lock(&adev->firmware.mutex);
 	/*
@@ -2383,14 +2382,7 @@ static int psp_hw_init(void *handle)
 	}
 
 	mutex_unlock(&adev->firmware.mutex);
-
-	ret = psp_rap_invoke(&adev->psp, TA_CMD_RAP__VALIDATE_L0, &status);
-	if (ret || status != TA_RAP_STATUS__SUCCESS) {
-		dev_err(adev->dev, "RAP: (%d) Failed to Invoke Validate L0, status %d\n",
-			ret, status);
-	}
-
-	return ret;
+	return 0;
 
 failed:
 	adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
