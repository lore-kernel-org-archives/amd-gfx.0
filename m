Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D7C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 14:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0942073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 14:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rVw/z0Xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0942073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4613C6E14F;
	Fri,  3 Apr 2020 14:43:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35406E14F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 14:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flCSsNuphLA5jxnQMrQkHNry+R/xf4DTVWzN+HOFt+05iwyyKwYIOyempdtbMpe60PuLMrvWzsAHsNbQdKM6Iwg7h32ORQjZFwgdzQTx7tDS+lBsWjRu1xKe5cnnOHNsKAnYQcvngv69zjKhg7UkVp0T/C76kqMTJEf4NFAMGldfs/TUvj+CJU8Cr3fHwG7h7sjpz68kwfLDfa7Mg+clyDeVtxYHEiJDfmaRW9KLgDfkL83xBq8e/f8ZcXwrjjfEUOnVQb3CScQCPMasdSUVUR6HrtrrrWwfoXx3QbujaooeLqPG0J2oqK1drKEsyD+ZuBUa7vvG7vohmEpGxcYDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZXQsumocu7Ub8QoRq2exG9ZVlokTZYWOTRigYF7eXc=;
 b=fyeOAxm0d5f3OSv8Jx3kOcS9BT7VyI4DlTgEMvwsMfOhc01QLIzBaywyrSfIOMlJFMAZxkLPWSUlAshlCRwQA+E9LOvMxEv5dG8kyR/u6bftX17cklIRf/kh7W2lWXVYUTkx9JJXwxv//vg0yiJmTvbZV+gSUFszokNiwe1/dc7RMQqFovSIDc3SXREwY5bMJvz1yb99r3VKM32Xp/9ul5/3mt0TsTypnkqVZeHbDpvBlPfjxAtOkma+pOnItascBNb+r8G79giHK+CWXZfYYnpLd0Jn/dOl6mnDmX5uo7dp2sGjTbYoTxE5QJ5qajgSo++JgYjs10V4HBmM6IDnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZXQsumocu7Ub8QoRq2exG9ZVlokTZYWOTRigYF7eXc=;
 b=rVw/z0XwJar9wgb+pwpfoMQnnS34pc3kC42/mPCo4Cjc2bA3T4/LOMhM8upU67k7dcZZP/+ep1xvfi+6dT4tW+ur2YxZ37Rh2qGgmFCiXzwIoNfKdd7h7rAvOZzouvpeHKRoH8HBpuRBkDJcrQTtdLy2yamzlakRnLU6zJ3OPfs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Fri, 3 Apr
 2020 14:43:39 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 14:43:39 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Date: Fri,  3 Apr 2020 10:43:29 -0400
Message-Id: <20200403144329.30127-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::38) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 14:43:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef4f6418-e03d-4a80-44cc-08d7d7dd65d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:|DM6PR12MB4155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4155A2BEE57D1971EDB6DE3285C70@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(4326008)(186003)(8676002)(8936002)(36756003)(26005)(81156014)(81166006)(52116002)(16526019)(86362001)(7696005)(6666004)(6916009)(44832011)(2616005)(6486002)(66476007)(66556008)(66946007)(956004)(5660300002)(316002)(2906002)(478600001)(1076003)(170073001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rj1LjIUxQRU9gvQx+Zj5+BsYYaLy+YsYJRzxwxjaMMMKfBNcnZ6SnMZHOlcBqnB/jFspNG25M0eT3wiPO5SVeawrJHMNcagWFjpsa674Ol8tqTCfRnlJceGSjAjXwZTAAJXEsoY6xo+hWZ1bCoH21zB1hpYKlHRsraqtWDIKsaoOz5wOdgSKt85YwuuzjFQKPUZCH3qX+5Vb0nHhWTM2/W9AV/1vwDbuwZyd2WHPszUHaAvQ36a+M7Vx/Tk582tS+YC9xAA8kAzKjVXDo9VqZ9SQ6U0pzcTOiAc9N+UJ6kKyW5DrvuqunlaLVMYNIVRYjOYAGuLi/8XW4CkbBARirZFvZte14nN9fVplQAZyfKE81FSXyFI6rhFpdxZBeD3EHuuD2FbVvPckZmLmrdG1Q56loaZ7q7goqmJgojXOfO0M/iA5uWg8pKM0K+vJy1Eb2JG5et02IHCyoHelDu8dCFzhWcch4zq/Rhw/Ps1zOHA2YoZJ0NiUjBORH/WD6/D3
X-MS-Exchange-AntiSpam-MessageData: dKJLyMcfHL+e9nIAG73TeDZmz6D+WjCkv16y+FZh0YEmgOZyB38kRjeBfnfAgyNEkEzGtUet4GIVLWB5EjMQK/JCLO5SB2PAEe5vICQLOuMNP21/jjUTRay+leUZ+bPMwnGcE75z5+mA7QVqvaco2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4f6418-e03d-4a80-44cc-08d7d7dd65d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 14:43:39.4517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv+9tbleWDS/oy4DGFTOnzBOMk7p5zNt7+A1TepqhUMBsOOnImL5I7wTS4CeGNtYAFPYWoiVMeAsDxoSmc3xPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are 2 SKUs that do not have the FRU on there, and trying to read
that will cause a hang. For now, check for the gaming SKU until a proper
fix can be implemented. This re-enables serial number reporting for
server cards

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index bfe4259f9508..281bdfd4630a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -31,9 +31,20 @@
 
 bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-	/* TODO: Resolve supported ASIC type */
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 
-	return false;
+	if (!atom_ctx)
+		return false;
+
+	/* TODO: Gaming SKUs don't have the FRU EEPROM.
+	 * Use this to address hangs on modprobe on gaming SKUs
+	 * until a proper solution can be implemented
+	 */
+	if (strnstr(atom_ctx->vbios_version, "D360",
+			sizeof(atom_ctx->vbios_version)))
+		return false;
+
+	return true;
 }
 
 int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
