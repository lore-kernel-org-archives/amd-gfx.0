Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD00C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E54613F5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E54613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0426EB22;
	Fri, 23 Apr 2021 02:39:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC2D6EB22
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm1JW3d9O2K738ty3hWZxtoiIhMrsggIuHbDMOdwRyA6rimVu4BoNbsDPfYbASqTUbt5U+4lo3xlXJarTlRtvM0gE/01vqGd+hTC7sdZ+cIXGns4GSIRXi1uurdTsnUAn5U/piUkPIpTsnATXphz87sELrNXgSBBeGuoUKU5Bt+K3l0+ZZiaN4Z3CB1komLfe6LniAsKz6oJFm0QtgFKcRk52gyJ+sonvZnoyns8uokn1Xm4sfMoBk1G/IEc1HoEifg2A+X7MlSIGv4psyqPm0LCSZ44spSlcUtx4GVPVDnMODEIH0Y5r0o/yOD6nNPARQww059nZ3BUY04RJ2KOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr/KsJC40op1vKdrR3xEQ+yqZ1vq5sRpgDztSs6+Rv4=;
 b=BjhDbp+8FjqaDg+6w93LaI8Q4c1+U29vvqUm8J3c+hRYUrcC4G1mp6qNZcy+i3Gv1fe5hN7eNoy+XLvVi6eTOKoh0xb0/NH9C6puPrh6VWqrAgAQQCtyyGTfKzm6B9+hfEgv6XeZcjYOqnh5b/B3AGFAUksbtrmWr7JqpQkipQFnbt35/nm0Y/voo7TEftPJ99vZTOwjefwV4cTZw1t0yN1RxwY4DuNDRFKMPbGPTwPNPIAq7rMvIwhC6WyPVChimR/W0tVTLdwYZDFWnJuCSsZsCZhhrwP89sIqKiS/p04k9lcMnbAppYY/sXQAWjl2z8XVzT1q9oVYPK/v+RfDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr/KsJC40op1vKdrR3xEQ+yqZ1vq5sRpgDztSs6+Rv4=;
 b=nm3S6nZ/qjMuEUBtodNgL1ObbMzE5NVD0v9pkKZ8XUhk6rFMvlhUZOGPylX5XxgKgEeBvppFFsuszJpMlGeW1qCYrho+MnoYugh6zl3/O6q36lz+92D6Ea5Nq2iUuvisj5KK6zgePECG3vHXjmf59g4F8/Qb4i+6BwVx/LUOLoQ=
Received: from MW4PR04CA0152.namprd04.prod.outlook.com (2603:10b6:303:85::7)
 by DM5PR12MB2341.namprd12.prod.outlook.com (2603:10b6:4:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Fri, 23 Apr
 2021 02:39:54 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::4e) by MW4PR04CA0152.outlook.office365.com
 (2603:10b6:303:85::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Fri, 23 Apr 2021 02:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:39:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:39:53 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:39:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: fix HDCP reset sequence on reinitialize
Date: Fri, 23 Apr 2021 10:37:00 +0800
Message-ID: <20210423023714.22044-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 603317a0-70dc-4b99-3793-08d9060113b1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2341:
X-Microsoft-Antispam-PRVS: <DM5PR12MB23412EE471874672DDB41667FC459@DM5PR12MB2341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNi03nIaI2ZZpWcqGTZBlhBqeLAa3uC9gvCuwO4ZOS22XZJB7cfyORfRwLjB7eweLai+8HA4YZH4gYtO3fWIX/4I25Cm6Z/iKWIJAO9u1DH/3TPoT+lGG8ytsTXq2xmE6GR+/S0U6+2LvW9M8e2POH1ucg09G1RX9xXqvMM/dl6nu/XKRUi6HWn3t0tE9QPpRqwBd8CUJzTuKSmmFWrXeJ3ui+V/i67AEgHZBPVrjw1sysZgOko03lCgxeRmwaP0JA3OXS7glgn+jSKIg1omfk4bwURTnKQNDqxGExb9sYO31TruNU1sVRNyEMiL9Cf4V5di8iRgVTyRJMbx2we8C30NwXviK9LmWr6ZV5R0pDiuRvRevwwk6d0RKJk9wKd8DFrVTu3OvLnCY3TDjLHwDTNQSb2L1JaIwvDnlvpOM2D52xtM52jzvts7pq6Qpp4twWcowMeQh0nn2cuh1PrIi2noUdZjYRfdWQpSYo4s2dBDQL9/fuknZxEAVgou6jV5z4FifkJDjV21wecBfg6RYd3wXuy3upteae6Lx7vfiLVF/Uxflydd9obIUDmGphY+wMxTr0kfuQWldquGv9qbjMwo6CvgA4I5mbdyxu+wRiTgyIL38puELHU8jkUzntUnZCKw4SS6JdT7dwsRPRH+j1a+rg6KpUQlDMtTXncMrbAFEA9AepyF9Q3dOM/J8JHd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(36840700001)(2906002)(36860700001)(426003)(6666004)(70206006)(2616005)(7696005)(8676002)(4744005)(86362001)(186003)(47076005)(70586007)(316002)(1076003)(336012)(36756003)(82740400003)(4326008)(81166007)(6916009)(26005)(5660300002)(82310400003)(83380400001)(8936002)(356005)(54906003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:39:54.3201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603317a0-70dc-4b99-3793-08d9060113b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2341
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Brandon Syu <Brandon.Syu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQnJhbmRvbiBTeXUgPEJyYW5kb24uU3l1QGFtZC5jb20+Cgpbd2h5XQpXaGVuIHNldHVw
IGlzIGNhbGxlZCBhZnRlciBoZGNwIGhhcyBhbHJlYWR5IHNldHVwLAppdCB3b3VsZCBjYXVzZSB0
byBkaXNhYmxlIEhEQ1AgZmxvdyB3b27igJl0IGV4ZWN1dGUuCgpbaG93XQpEb24ndCBjbGVhbiB1
cCBoZGNwIGNvbnRlbnQgdG8gYmUgMC4KClNpZ25lZC1vZmYtYnk6IEJyYW5kb24gU3l1IDxCcmFu
ZG9uLlN5dUBhbWQuY29tPgpSZXZpZXdlZC1ieTogV2VuamluZyBMaXUgPFdlbmppbmcuTGl1QGFt
ZC5jb20+CkFja2VkLWJ5OiBXYXluZSBMaW4gPHdheW5lbGluQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwLmMgfCAxIC0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
bW9kdWxlcy9oZGNwL2hkY3AuYwppbmRleCA2OGE2NDgxZDdmOGYuLmI5NjMyMjZlOGFmNCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwLmMKQEAg
LTI2MCw3ICsyNjAsNiBAQCBlbnVtIG1vZF9oZGNwX3N0YXR1cyBtb2RfaGRjcF9zZXR1cChzdHJ1
Y3QgbW9kX2hkY3AgKmhkY3AsCiAJc3RydWN0IG1vZF9oZGNwX291dHB1dCBvdXRwdXQ7CiAJZW51
bSBtb2RfaGRjcF9zdGF0dXMgc3RhdHVzID0gTU9EX0hEQ1BfU1RBVFVTX1NVQ0NFU1M7CiAKLQlt
ZW1zZXQoaGRjcCwgMCwgc2l6ZW9mKHN0cnVjdCBtb2RfaGRjcCkpOwogCW1lbXNldCgmb3V0cHV0
LCAwLCBzaXplb2Yob3V0cHV0KSk7CiAJaGRjcC0+Y29uZmlnID0gKmNvbmZpZzsKIAlIRENQX1RP
UF9JTlRFUkZBQ0VfVFJBQ0UoaGRjcCk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
