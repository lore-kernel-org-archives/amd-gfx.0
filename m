Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068A1C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC852067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cKkbEAhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC852067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9AF6F49D;
	Fri, 21 Feb 2020 16:03:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF236F498
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbfl6en/50HVhbbJLvMjRJL39OWQxiuqAZO8vF85pmPdWJRLIVfZOtFDs7xmJl0zkCv8nfDQMjmAYPHN82NIp7+MM6oUE8fV+klayk0U2Ead01zmj94NqA5elrNbxBMhuyj0b76p3tiPXmzMyliKm/DahbnfF4/EW/Q8NbGprZgFUD/ao5LsiSw3r44wkUOTwBApEL44xojRRyb808CA3yCk78d3zFn/6rSDkzopYaJ1vVm3RLK45d6z1QoEVoFFWuitBdFfuCvdXmK2euzUy0F+3eE4PV4Q/nmEBwjqe0dnEk23EI0iPmUgihq7znZOuGbTp7G/UL/gjbjiJJuZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzj3L67Jl8o7cYey7Hc1Ae5zUksASiIFx3ZjCDZLeLw=;
 b=GsSmvLssDvVR7KljWhnDUn5vf5DWn0iUKoHGd9njNpeKCJsrrt6CuPNZ5tpnCno/E0Oe8rpwqBKrXkYvNpz/jE6csAWvQ9ZEVFdOwqE2uNXnl7jndeRGhO3jmaAV7k5kCbo6O5L25BMBR1oUBzz8y+Jyoogyq/rVsP+fmKLPVWkhpFiTOP2rNkcNakxKW278alIYWnxTTklpy0Bc5w7uUmJlsLpGNqTirh8IaPyQ8CkH5jk7UWNK4w2EkYvWNaXX1v8hkXeIfz9gx7fLE9kf/ahwpo7YLaFFqszM2u7Nnpr8KmjjmAYVWrVL5BeFj5eiZf78z7vYNKZ/DX25X2ax2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzj3L67Jl8o7cYey7Hc1Ae5zUksASiIFx3ZjCDZLeLw=;
 b=cKkbEAhAY2HIAQLVLm1Rlxvuhr4hbkmgM2ZiXRhJ8dATVgeTra7pH6SZSk0A9bk5qI4QqYtazraTYSrFFCyiWCQ1svS67lYA6XPbOPWLUb66/naExuhANWUli2BClaZ2I6FBX4oMSRPgF4LGGn1TNB8HSW5lQq4rCVleZl/BbIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:50 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/35] drm/amd/display: DMUB Firmware Load by PSP
Date: Fri, 21 Feb 2020 11:02:54 -0500
Message-Id: <20200221160324.2969975-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:46 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 981a4df4-0143-49d4-7c8b-08d7b6e7a264
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572255DAEEEEE2890C55AF298120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjIOt7Kk5DCCDOfLjxS5vxRIsiPs+DKxEt7u9icwA3p00jZWFEPsMDzzD+3LBzyEo9p6B4mNwyKvDBI6ah6L16m2mGFO8vkDnGRzNrCiV3Uk33UR35MX/wem3eP0Doo2VscWiBe5syYsHVjp5rzNAOWJphiVuhL82DjQG0qF7yh+ozzZRy66eirR3+/Gxpgt4YJ6/HTmuTRA7sARu+C5xXbFBgUtCD6RNUvk/p6UA83fjYX2vwL0XZqiOM3PX1IQ3hK71fP/9FNBK3nwANiqgd73+wKB246396RjWv2LImwAtZMZf9hCwgrNKQFWdQFL2lNC7/NTjrwIJs4nA4xOOeXWR4wO+TMVGdnPMxCBIjZX79iMyhVZ0UXdZjUzHlzD9lx/BjqnDXAi0nK1pfJDtcZNHrceM1NyqebVB2NtGxqVBROYYaX2cDhn+Ep4rbwQ
X-MS-Exchange-AntiSpam-MessageData: emW1z1trNk8YuzNmqiRV4qyZbado4uRseyS4ak1xNMqrJXYhFU8Zg/V3ejGOz46TvztUeojq8c2z6ZZ+JiA0CTtYwa7fKNEkwmZbTrXJ1kJaKOJZTMDgXecD+RjBOIYkxddhf++e5lmmXJHTfke4/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981a4df4-0143-49d4-7c8b-08d7b6e7a264
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:47.6158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZRbinOWEgmqEk5t4qII8xDmZroGgtGZJPtWX65Pd5gP5WX7hb7SRoIKNOHkyiQAN5CLhYQQa0f6Yo7/wM3Ilw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index aeca0ada2484..8bb022c91b8b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -801,10 +801,20 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	fw_bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
 
-	memcpy(fb_info->fb[DMUB_WINDOW_0_INST_CONST].cpu_addr, fw_inst_const,
-	       fw_inst_const_size);
+	/* if adev->firmware.load_type == AMDGPU_FW_LOAD_PSP,
+	 * amdgpu_ucode_init_single_fw will load dmub firmware
+	 * fw_inst_const part to cw0; otherwise, the firmware back door load
+	 * will be done by dm_dmub_hw_init
+	 */
+	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+		memcpy(fb_info->fb[DMUB_WINDOW_0_INST_CONST].cpu_addr, fw_inst_const,
+				fw_inst_const_size);
+	}
+
 	memcpy(fb_info->fb[DMUB_WINDOW_2_BSS_DATA].cpu_addr, fw_bss_data,
 	       fw_bss_data_size);
+
+	/* Copy firmware bios info into FB memory. */
 	memcpy(fb_info->fb[DMUB_WINDOW_3_VBIOS].cpu_addr, adev->bios,
 	       adev->bios_size);
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
