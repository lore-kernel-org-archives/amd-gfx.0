Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE7C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 03:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D5A207D3
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 03:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hHmsC2OH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D5A207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB0A6E81C;
	Tue, 25 Aug 2020 03:20:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82AC6E81C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 03:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/MvtWUkRnpA99G6VslAwGIoagA0+lg3JwM7dC42fWjvl6as6jPHGRRtgtP7qZFwJp1sRmo62KbAhyYRrZaJIU9snH98wjLIP0NqTFM8uh+tzfQGXloyEYrnqJ3Ft4vU/9tF195lEZQnDO1Tg14v3qEqLWcd95/xOCpto+WdFcVkYxoPBuOZnvX2fkLNQT9YxV78P6ChvLDr0wk4PUIC9Dsb6A6ZIDz7zYKK5ZRAY1I8uUm+BCY695t0f//NdtWje5OsuYbXswroLUCBW9x+s5WrKKJ5newJulqKfuT/QXGB+aLgupnatETW9V2U2VM/pAifZiBiNrYcEpJkUjSPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCWh49DRsqckssfOWmVDY4LyMXn0irrMGgLviYEIwlQ=;
 b=AhtvSz8fCnGz+aNGjx3kPCHL+2R6XHRMJh0JLqYHgAdxuzXokOIvMSpdjeH+FM7wq+AxslUxCU1Am7tGsI+oi77i3sBBlavC7/0A+2oxaLF1iFq5e9FQblwt93lEAshINpi/aAVYm6pjUufVBC3cMpojUGqsewjF24l70eg/ka2huWdCEf7yO2xEV4n+KyhU3mw85wN1Wnh2bmm5xZXCqPOnW1ULuszp3EhurTeCmUDnjOMi2/7JEfkPKvDkWF9f8PAMJKj5z2qg6pdgw4SNFHkOCxHkglN6nmGOTZx6U2wujOsQzBeMuaVH9W0sdUy09LbfN1+x6YSwMo2F0JB3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCWh49DRsqckssfOWmVDY4LyMXn0irrMGgLviYEIwlQ=;
 b=hHmsC2OHZOunrFOsAcb/oEhnfe5/LlYnwj15EIqeTeEPZP8S8Eyl+CID9HGkmiAgUZI21qmtu1ATA14EloTd0SgjgNEx0qoORPXprsl6jaRcml8wTpCceRh4GjueZTMqZcTG7WKDo381aB8SFFYj1ldcGtj7WGvQ6cdhgy3jYh4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3031.namprd12.prod.outlook.com (2603:10b6:a03:d8::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 03:20:28 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 03:20:28 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com,
 jiansong.chen@amd.com, jack.gui@amd.com
Subject: [PATCH] drm/amdgpu: add asd fw check before loading asd
Date: Tue, 25 Aug 2020 11:20:15 +0800
Message-Id: <20200825032015.22192-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 03:20:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f27f468-e24c-485d-1e2a-08d848a5d0e9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3031969760746EFCE19F4EEBB0570@BYAPR12MB3031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfpHYpRAaJigGF+wQ4i+FF7zy2PVrMJwaqxgmQd4LQc39p/9CEf51Vyt7tMlxHONZ6m01khQ1HX/MtBwqGtk2y7jYdpJXx8gps79TbsRnQ0OAprUyERO47CZygkdNT3jlQjBOb9U+AHvCWpTCLAiPMt+hitTKo0wl7Bw8+k9YjfKD3GUlUGHTuFvzJTD9HNSM4uF8Cq1Wl6ywTzUxGgXOWquwXUJ9kOvRNmbarOZtHn9qj31YYHHikFcdXIa5RqkKkdDv5pAC1TedJTVVKEbf6wscHjTqqWNzittdrS8gUdqqaR6vJl+OHhLNc9HD9MQhmfpv8AYEQhR1CNhB1phAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(1076003)(66556008)(52116002)(36756003)(186003)(83380400001)(478600001)(6486002)(66476007)(6636002)(66946007)(26005)(316002)(6666004)(86362001)(2906002)(8676002)(2616005)(4326008)(4744005)(16576012)(8936002)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OlUafro9OfqjT38SSanpS7cH/i1T9GsLHxynq+aYzxp9IERSxKoNjMRARHjLSjaX9f480ANt9TeErX4N7zGJ6jO7x+govju5nyD/icEH488J/pmbD2r2kXjdfFKasnnNvX6W3ZLv9kVrsRbTOXfsoohwNA70LbeNsM0XL63i/P+6YoCqRgayYVkD6InFaYx5xLnotH6BB4+kfsriCrJB6sen5mb0MvFf3cLH48WK8hOjZMdkyoVAUd3VtQ62u80hxG8oQLJ5HU8geZg+Yn73jKuTSWHkjACPTn8e5qQ6pY2BzDnAkRRwWSdCO+y4na9PWMYzolxGhTIRXWOf1/K9fmXO3oyTdOoaQgc5IUNTp+mlB+oCDjYKq1smeNY2W4TUmJwJxngdGxVpY4AiPRIErTkKFkeKKsj+UvPWlLpuOutzDmymacLDxi4zF6vHJXv/3s2DLFZXRmJ9AcFdwCijp3sDQTA+n96kpeF8obWSB5xW0cO3icqfumRwhnyV923ruMx+dafOmv1ILU7QG9fq4bjfgCL/y2/2YeSnbyHrT9jyqHYAoE0XfgHyyz1n9BbZLfE0ASSxmjVBi5c/Sa/jvD11Kj9bzjseGRcNDqgCtQ/EIUVG0Xaai4aSUlIOSI6jrvSAc35MhawwXiXtoWaTkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f27f468-e24c-485d-1e2a-08d848a5d0e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 03:20:28.9414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+1DjnGShKWR/4z41QIOjmIfZevPY6tAVmFJp+jkiZHqO3ppVQ+Q8FVx+AmK24WV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3031
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

asd is not ready for some ASICs in early stage, and psp->asd_fw is more generic than ASIC name in the check

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c22fb0194df7..d6c38e24f130 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -522,8 +522,7 @@ static int psp_asd_load(struct psp_context *psp)
 	 * add workaround to bypass it for sriov now.
 	 * TODO: add version check to make it common
 	 */
-	if (amdgpu_sriov_vf(psp->adev) ||
-	    (psp->adev->asic_type == CHIP_NAVY_FLOUNDER))
+	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_fw)
 		return 0;
 
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
