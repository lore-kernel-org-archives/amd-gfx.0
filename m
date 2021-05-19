Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A169C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25A960234
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25A960234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F178D6EE17;
	Wed, 19 May 2021 16:23:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D929E6EE15
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 16:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVMVyr9/7GI8e66QSg5643J2p+O8Q8gU9/sx16qDOO8BsU3qtBAynZkittY5oM7J4er45lc1PDkPU4w4jHcNYWCrFh5qxkdpQM63hhRnbJ6jQ7hMdcqN+mrHtNEXrImeROgVA7m5EVlZ1j6QLrq1jdWOsqRwl7ivjFFrdeo3eYjeuDOObE5zAsymzC4HJaUnCd3rPdDIEpHzkMoewzInROUBl40H7YLNpu/WdkkmT/mJBM6WYrVUPBat1ULswRCAMf3JG73rrGz6Z+EhAYl4RNURRAvj9tKDrdyb7Qr1dPojUmqTW8DnPqN/Jbp8RK64cKxfiR/2gHCZk+KG7joOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grSdjEH2HYI6RZ6NgvT6kc8uT6XH6gzfLwmz1QBf+SU=;
 b=X7j711qqHkATYkUhNew06rX4/gJ3g7tVCECeEKniJd42l6Mh5Ocs8fkUbP5/C9wVFaXriq45Ee7fgiqYtqOVVVcmlX50J1Jt0G0rx1+lTqmqSxcjmfomYBi10xQvPsa41fgjes46rxtl78Us/xdPj2TW19Xc7nQIPq3mAtTC8TSYrb/vsng3z/5tlqspQppOniYMv6Id5RWeYS4o+GofFoEnh3EcaQGzhMqLQqMTEz8/AfR2wOlK9YrjFO5Tgvcc34lhicGw2F3uaiEc4Hpc3HF8ZvJQ9CmMsxidKCJj3IjHsjde+Mbfkad9UqGhnFkgbU7WdsBRjJ9aKQVnPyIT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grSdjEH2HYI6RZ6NgvT6kc8uT6XH6gzfLwmz1QBf+SU=;
 b=qJaPXbzbIW1bp/AGlAOKjhiFLIpB2Go5TRYEyulefkp4QIQEDp5306Q1p63do1PA2+S3oHRCN/yytrlbt1dTDbxLwdp7LfTT7OLMexwuJX2Uu6gaeOrgzf9kisweW0PJUMKVaiX9T6+I93zqC3hk1K3MGwUJfHtlQATtpmWUvn4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 16:22:57 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 16:22:57 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amdgpu/jpeg3: add cancel_delayed_work_sync before
 power gate
Date: Wed, 19 May 2021 12:22:38 -0400
Message-Id: <1621441358-14685-7-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
References: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 16:22:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f39a637b-7273-47fe-c1cd-08d91ae25c57
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB325986C1D7C28FF34F518C28E42B9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KH7jjN8dDJ7W0st/kgcPYzcU86E1zExKDlgpCFOv5Y7gXGvnCtBXX4OOsjH4aYzl5TUg67Q7fxQrfxctEdaetkRx4YY+DLhK4l4Mxk4YoaXWxnVWj23i+/5k2GXIdIoN31jlxeXOKUbFluTgnpNHgj14G4eLpGrZZZgw7cglt6RrxdHjNea0qkq8TvOqXU9NFJTqQenym2q2M+rAP4YFFbADeHvWU20kOOtAtXyJjpbaNtCk2H4kH/1+jL3mm/3c/lKC9PE0bfss6eM2UXZNxoNGDsgFAhaBCmvpA2WIxUKy8HW8dYPXTQ7KkNfFCp7BNGSvUHzCouf9xobTt2vjgiurO9CM+lLfG8Pn//GTYVd2WKWtcH1peJXiGKSeKP1higxsGNapvhg4hY7dHf0+kyiYH3iqSF2x+GczjHI8yz5aqKMq07NE6JpYuk3IbOemPSXNOcxQ8pqZk9FlPUFxc6kpUrCjCWBT9TkwdlN60cNIDBFGsmg2TZbtF0y2DAqtKZtwQVIeEOeSgi0cXPBh1WNawSOcEr5M/Z+SNddQl6TSoxTZS8I7BMcoILM/rjTXtmGEUTlDGeBGl8LGJLcILGLx7pup9NvjQxl44sHjjJm2lWrcUZ8jjvn8OzdS5B8KjdunKm7/plZo7clKuzqX2XBUuB4FXav8bFYmTB8dtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(186003)(36756003)(4326008)(66556008)(956004)(6916009)(8936002)(16526019)(4744005)(26005)(7696005)(66476007)(6666004)(52116002)(8676002)(38100700002)(66946007)(38350700002)(2906002)(2616005)(5660300002)(6486002)(86362001)(316002)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OkfgYGKNHNHHM5ReAKFb25yGP9V+HcBPy5n/89tgvoD23iqWnFZbcAzCfZB+?=
 =?us-ascii?Q?EG0Hjbhfg3zXj+Z7FkbLUXPZPBJnDs1oHQuRllGGvHtAsGPNxurk3RXC1z6Q?=
 =?us-ascii?Q?ceNUYeqNRlMPm8MWn1Nc6Mgo6KHxhPywhKKzZDPkWzcHwaFiksru9L71mZNR?=
 =?us-ascii?Q?ixVR1EqZ2JptE0LTn5FGtEBhUHRPr3wmce4kEvkw26yETNQhEWysdPe/f60X?=
 =?us-ascii?Q?UbtUhtCcDw0RwQ2YkfoqPiinpugQbqSKgxPucNBXClI/T9MUzOtEHTT5szm/?=
 =?us-ascii?Q?hXHirGGj1IRoWZqc+AYn3hXh+N+hDne+9asxbXRqxcCOGpV5hJTnh++DlfBJ?=
 =?us-ascii?Q?FMQ92TZNOrhuC6G4pXIDm1JGX78KtUQ/ymgOBZwVCqAK/t/WluPDZodizhYG?=
 =?us-ascii?Q?/VpH7PjIJnxk0RJFu5opx4jbYXiAUE63hwavKMKehctoVPITqTAW45UmtCho?=
 =?us-ascii?Q?q8Nk4ttS+0uBnBfjWbv47MzMMaYC/eJvIZ0VAU9u88VkvF9BB7zh6qcpyZPL?=
 =?us-ascii?Q?qeCkZpH1FZdS9eXVI1D2oz7eCYzCaMBEpY8bb2ZH7nGVzz+p3BwRQqfu7kWG?=
 =?us-ascii?Q?E311zfUkBLUVY8V2DVKnqDIjjIPxSUvsGJ1AyMQyToVTrdHrH0SvyEHQBXxb?=
 =?us-ascii?Q?NkP/pgaQo45Sf0RDz7JZPFrGEicz95enfL5ZHExLuroUUelW6nPadynhF5r2?=
 =?us-ascii?Q?nY5Xxi1wE+oWvyG1COVHBxk0KWBRZHUVCVD9HoxQKE7THTssIEloLwNlZt6c?=
 =?us-ascii?Q?GRYktyMdxpphDeC1e+MBXWlONS8zBOKz9n08YbNoQ0R9HDzI90UYCN+f5nau?=
 =?us-ascii?Q?eNBaHtEvm7Xe/Q9xVJz53A+mDQiSAQf2xVgZ/KReLYl3HI8d3mfr7DNgOu+r?=
 =?us-ascii?Q?wxvSBuPPY7WOIelUACNtM/yZ9l0MPVGR+JTXR8Dvk0Yc7InKfUqaNtnou9HF?=
 =?us-ascii?Q?+AUNenXJ8aL/T9WM4PtPWidefXYZ0ildKyr5MlEkFkb1C7DELEBToQjpW5Fd?=
 =?us-ascii?Q?ZD5e5ZsM4pb4E/0PX10xxZ5thjyedNT7UKg1gtP9eGF3ifA3W1P2bBlQnCFt?=
 =?us-ascii?Q?H+6Yk1U47V9C72iRMloqvlnVAb4hX3ruP+GPI2WfWpyQCA3+uskIIY2B8tyJ?=
 =?us-ascii?Q?fxrKR/c6y69oeKroWpmtf4DnUls+iRnxR6s16wbP0AdNUYWrr+9d3dRq6+ON?=
 =?us-ascii?Q?eNXHW4C7wQBa4QJMneev+0+MPrxE2CIy5S8FiVX3NBwoRp3bgBujxvG3Zn1b?=
 =?us-ascii?Q?WyENaY0DPacTU0IwYJmSdpTPhW2VAN3kPExuEFfhz8boXZDr5+3dN8UdaZ+R?=
 =?us-ascii?Q?pjSHIKtT8EGLJmTJN7iogqYL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39a637b-7273-47fe-c1cd-08d91ae25c57
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:22:56.5311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjMdO9JL8hiFkURUNiJSUFL5VKfpjMw/f+gLUePDQZDP5oovnim8EoYKgLLm8Eau
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 94be353..bd77794 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -159,9 +159,9 @@ static int jpeg_v3_0_hw_init(void *handle)
 static int jpeg_v3_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring;
 
-	ring = &adev->jpeg.inst->ring_dec;
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
 		jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
