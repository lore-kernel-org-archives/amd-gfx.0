Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D9CC3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 11:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209E42080D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 11:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VgX7huI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209E42080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D816B6E431;
	Mon, 24 Feb 2020 11:00:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44AC6E431
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 11:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7IkzHE9cJeyobhaE/9WS3qU/CfVlbmwg5NNs4jqDYBMX30zVdPZZlaaBLWacWMJIR5F4pCAzGgXD3ZJ4FshBDN1fZTHBj3rwQ9QpANN/a4UOgmZOwtg5LM2nJ2zOCmZKhYsaAXxG0oVrZB22ykYO4twGGj/qsNOk4olMZzusgQn/s4pFGJzUuHOmDvRug7HyVi4kXH3qfqJ7Fp9H7NmSX+ockV4CBj3DpymgqmoX8GknScPbRGm+r0XaF9EZLcdPE6x/PbDa12A8hp51WK6Md8NzUtYB4CO4i0i8Klye4bTMWekRRrx+QZR0ZKDRnSJsUdgXIMrjl5ceZYaOHNswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfyOW5geX1hbq5sHvSdFHfvTbyzIKejc+KhPaZLxsq4=;
 b=NnzwFtNYjIoySwIAJwdYE4Ek1h31GZ5JQsO2BAiLuibtuewAJC+QdVHpBs3vN4rensMmIC6tQm/fNn+PzPuGOTtVfbqjNjiYe+s1PBtN/SC7mZpLDQLTQ5As3U10GT0FMpj4sslrrkpjNnx6yIV9nplf6EYXDAr9TZVcpqTn70dpENqPBtiFCGKv2MeTFRyE7ceM1w7g9+g5x8xH9NP873GiLCJ+hzq/BdLpr/zJsAAaVXzawzMliZ1b3YkW9jca7vY6I+HKnPEHTkcISJh9qz7Zss70SNc6eRU5AJyHSTugx/CPQIHNkhkKgisKdOrH9gkoUOQzj5AWvXuDTFpa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfyOW5geX1hbq5sHvSdFHfvTbyzIKejc+KhPaZLxsq4=;
 b=VgX7huI4nVkMbISOgoACjk3kgqs4qhMOEA8CAJPvM4vz9RKxUzgxrzzufN94Xgygm0o624mBtaVnI7s1htilU+xtau18R/P3RdQ2dJK3d8KOKKgwP7bIOep269TnnhueKlTYLILqy7eu168rWIJJ8e5Yr/BZspX07j705O5lLQY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 11:00:12 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:00:12 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	tom.stdenis@amd.com
Subject: [PATCH 1/2] print the missing 0x prefix in WRITE_DATA packet
Date: Mon, 24 Feb 2020 18:59:52 +0800
Message-Id: <20200224105953.29906-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c0.amd.com (180.167.199.189) by
 HK2PR02CA0177.apcprd02.prod.outlook.com (2603:1096:201:21::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Mon, 24 Feb 2020 11:00:10 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4015f254-8121-4508-4b9d-08d7b918b816
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:|MN2PR12MB4437:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB443716A78E0E9B98A5B2CE3089EC0@MN2PR12MB4437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(1076003)(86362001)(4744005)(6636002)(956004)(26005)(6666004)(6486002)(66946007)(36756003)(2616005)(478600001)(44832011)(8676002)(186003)(16526019)(81166006)(66476007)(7696005)(52116002)(316002)(81156014)(66556008)(8936002)(4326008)(5660300002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4437;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBbxb8BQ46FDX9iQ5oVrEO7aPg8SIE3nhM6IhrYMYsgnlO/yRouFNiFY9AFq8tjTUJpOrMMnatN+T/tZnIFgeoJEJRU7cnhNz77QD9nPuu09e9+5HEL81N3TVucVjQaBEQgMY85AfA6O8f3MBbXrmd49PVE00MY+GmjCxrRsMw7WeOPBxB/ueFEQaqSXLhlxBXW1nYWovsWmJvx6zSYMp6jMMIpMOzR2fBK9v13oGMkG8k5kkN4Xw484uHx7TQKem+t7/p5GS16kKoNHj2vHL59HMNbx2qNDne21EQjeNj4i24HJEr/dqPEUr7GzbRHf3no6rNozx/HHPdatd5vjRf5PmiROyUfVAoSN86j1ubJeObF3USwtrqvMYicy22s00DlgpTo3tsAZAySRxLvinGlI26DvWS/9XWN/wUOD9nWA42WvjXhjfFk2PRhqIe8n
X-MS-Exchange-AntiSpam-MessageData: IPwQR1vzdjTSNNF1XwolcL6USMk50XuLsNsGUglT8b/xPyZiE+wScFgxWfbYGYdHzQlN4iz1pMo5G3jD5wIv8QDsAKbo6yHVDx0wkHbq5vZUClnhTz4c/EpjhHl+msYEtShy6Kv83WpnSe/ufj/uZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4015f254-8121-4508-4b9d-08d7b918b816
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 11:00:11.9934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZzFBNXCtMfTwpcSp+uZVi+ZH3PbIj4HxECeXMOT2WODhmY7NQQEA3Cw87HOH5lg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index fa44f27..c5582f5 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -664,7 +664,7 @@ static void print_decode_pm4_pkt3(struct umr_asic *asic, struct umr_ring_decoder
 						if (!decoder->pm4.next_write_mem.addr_lo)
 							decoder->pm4.next_write_mem.addr_hi++;
 					} else {
-						printf("DATA: %s%08lx%s", YELLOW, (unsigned long)ib, RST);
+						printf("DATA: %s0x%08lx%s", YELLOW, (unsigned long)ib, RST);
 					}
 			}
 			break;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
