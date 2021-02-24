Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D353EC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9632E64E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9632E64E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A196EB42;
	Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B3A6EB3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYCRV6qBW6Dkha3lssMPuLd+yMgpv4PFCxGpX7OIQEiUXgJGEcJAPabdpcul1Fi1OEAGJ8FYqqAAhx540BYEnt6ruGZPNc9VsZsjJfr7PfjC1MgU7wKKoPSqvtOKyUVQjWxg5YTQUphgosd6v1fmdCZ/iNm3k5JcqtA5pfi6hp0s80l2r/eC5mLcUnWETS8gsW2kT43Z+w+ese7PV64DHBMXWm/6e4rR8hZdP5Q/V9GkQ0yu9w3jkWdIf/8Pc/zACmzqy56uQ9F8cd6hEiv/ub+JxOtZ28eCsNTp1wrL6y0VMqCxCKSjk7YlE06TVpqr+tWbGZj5+bL21n8iIuBspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psq9Eae1Oz8gsBn42TOhYXLSKgnoG7xz2A4/clw0uo0=;
 b=ISuiD3vL89rTiuedB8Cx75Z0lYp5/04e7j7EDShnMDJS2BRXH8vSW0sLvkH5rvCgiMgcn6dCPPlGRzOhXR9b6UtGBiVJ87Nc+HYKSFYAR4f5AyYaEjq0a+4AOkfjamKYIPvwpbG4jdaDIM5ivHV/ZfgyqCKgxuHL7rF7AQ4jrQh35Gl2TBwJ4P0E7fanlKlxECe1Zjc3gXu6bYKwe0LYyKGyl0kLKGxxkyPnjQrWVY6RAdl/PoKltTNtw+FRH/FAtcxXuyzn9WTP0QZSr+ZbeV1HoaY0dTcWFJxgrygmdKLotBuZ8Peolqexp/xcKK6uNppNGm84khpuhYlMgY3fWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psq9Eae1Oz8gsBn42TOhYXLSKgnoG7xz2A4/clw0uo0=;
 b=JlymEjmO4i9IGTBBMjg0oGzBOp3UnkmqFw+ANBS7TVqJEGk1tFCOpwynUoFUy+IPR9R0DPMxuyMFA1HMP7NEfoQ5I8Z/NVp1/qflawAcmDhYjeAh5GpNXfliEMhdXnG159ivCJKbB3Iv0Ur146802Hy0XlzJfQw1XUcZIM3qZ+k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 051/159] drm/amdgpu: skip MEC2_JT initialization for aldebaran
Date: Wed, 24 Feb 2021 17:17:11 -0500
Message-Id: <20210224221859.3068810-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d52fce97-c85e-4bd3-6d01-08d8d912500f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175D35A2E466849206C13DFF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnjDSX6YdHyqj6636ye6s/MkUc9L0gq+723am6eR82NOiQffIEYrAl2ECC14OiZX0PCkzPv9z6P46p0sRrWXpyIWLGhDKB6xPNuKzx46ALbM1r7Q9to7uWSgMkf/ApwkSESYdwjrXGNamcWzh6iUJ4wvrjtSXwWVzaICs0EOQDY7ZgRozjfcrd9Pmq+V2o1AduBrt4Bxar9WRN2n4CTfU7oP89lHn+1iLhD8i5HQuwCtQ7H9NBC1IIxFLFmExi4Mcklk7cvvNLSEZb44gOCW6pDCFgSDNhJ7q4tgNSdc4t7gcWn9K9Mu6SiYbuxaHCm65VlstTmfVk3e534Cl3u46eVcNn3E/EnXFo8hjucmkL0XTX4kXIGCvf7sE3spTAo2d+gRkdBd4roLxV7MIKuIoO9qrOeAzu4spc5/4UOaQUYTdAsMqWrCwr+eS60iGO1n/pEpPrw162gTgi9zLwD/T2jycuFyaXHljzR1wkJGzLo9uLUg+T+kuMb3gQ1A013GGxo2zl1OsfRw47PibEP8OS827Aa2LfnWaSzerCVBmZYYpk4M/FRyyjr/p5D4bGoIf79Dlim8efUvo9csc1sbzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YLtLvaU9Vv5AIWGpDahrPSEteRMwmgmqxVAzenNrc21iVQY3oTxava9Vvn/B?=
 =?us-ascii?Q?8Ijb0sVxUce+ykfuCxelwFR/mfam7ojRv82KXh+Ty2zAxDgyb3meH9efzyJW?=
 =?us-ascii?Q?fmu5DArJikgNxD12UhBcvEiocDsp/AypFEDkaTApvQkeCLomOuzYC4kdf/ST?=
 =?us-ascii?Q?FJlJef2YvrENmC87aumHLP2R94RDbOQvg8N5n/l5aanK+z9DjZU3awAXuiiz?=
 =?us-ascii?Q?rxeSvD0osJMbrEoCLoxpriavF0+OFI/dNtEAMlqIiZ11EHV43SThOrQTUzQj?=
 =?us-ascii?Q?6lvNxF1C5Qy/oHAfqLQIjkPta5mOksJC4pPtN2nLgWNVDXRR1tC0JYCfvfpg?=
 =?us-ascii?Q?kxO8iO/zme7xnTqKdTbKCxP87xhcwh4mD2SYR7jSRLEFY9vXUu0E0ushhsz1?=
 =?us-ascii?Q?7RhQD7vlMH4I8pjqDTj6OKiN7dqN3wKN8f16mq063+/TW35LbqYuJWhCRoAT?=
 =?us-ascii?Q?lX7Y87UC7B+DeUkWt6dtW9h+Gt3fZD2nzIZYW8BT3BPXm/qV8XNdzfFwRAYY?=
 =?us-ascii?Q?ShKjrBtnqZAj/9KjPBeF+KnVfUefVYiELo7QG91jx8Gel3OHW5RJWwMeAvGB?=
 =?us-ascii?Q?GQY0tb1c9gF3mKTdif00YZDAN/6Vcc5wzfu/OBt5JKP07iljxaeR/s6u8SmR?=
 =?us-ascii?Q?BLNv/uSWbqEINBhlqz25zc1I6HcBAB4b006Hn8PVsIAipS5NP2SE7xqDjs32?=
 =?us-ascii?Q?bu5vYcdXAHnwVVQUngUCofjkMrmjGSLrCDR7ye1OFVzynYuQDNsxJJmyIV+D?=
 =?us-ascii?Q?THMKosDK5KxlkAVI9LGtx7bSZiurkarz9e9xfyYsu6UEOOSB1I00PHriXVUN?=
 =?us-ascii?Q?5uAWTSKzTvz13Wl39SoG0Nd3K8hbAbSWP1RF33j5ImqJl05vKCRcyJifxucP?=
 =?us-ascii?Q?YGZE7eM+deftzTJzyp16nyP9ThnBhJ1FX5eqCtjSLo5rdGqeEJw4r7+sK+Qp?=
 =?us-ascii?Q?VQMkT5h/Y7zQw6Xd8FEIH/eakfUUr37QFmHX40/sdWs9LVhBcnRg/kQuDhMD?=
 =?us-ascii?Q?Bpx3mWIvCGoPurhVZRv+zZxAMLjmQyFwzc17y1lYZPSMD7EWtAA8RNp9i7zF?=
 =?us-ascii?Q?m09vjgno+kwNjyjRCWmmtMAYeULKMQjTkUPrRamrVmS17kRr6LsLm/z/C4Su?=
 =?us-ascii?Q?NOv+wDjzK6QFWSWLmBMIQROYSm/kHcXL+qViK3pC9fzkibQQZcwcuRRUZztH?=
 =?us-ascii?Q?SzJ0Ozz//9Yq0pd3ayKtklEVjxhrRDZYMk7Y5xhkAn5oDz6S9LqSsSYCjo36?=
 =?us-ascii?Q?FEhkkfDvrdgKUSqUDIxqwJ5AWl5iHrn4Yc6f5EYQMxOnTcgnhlSADdyPYolI?=
 =?us-ascii?Q?dIU0uKPM/xeSZV4/4EXumdZG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52fce97-c85e-4bd3-6d01-08d8d912500f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:55.1898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCfP9pr4IjHjiPrSUsSahgwk6Z8mm01x56tvlyKifTEbrj3aYOSgBQc+32oRsNzut4Nkw98j1R9kYvEuLzgWQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

MEC2_JT is not supported

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index cadc1e383d34..f8816ebd431d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1522,9 +1522,10 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 
 static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
 {
-	if (adev->asic_type == CHIP_ARCTURUS  ||
+	if (adev->asic_type == CHIP_ALDEBARAN ||
+	    adev->asic_type == CHIP_ARCTURUS ||
 	    adev->asic_type == CHIP_RENOIR)
-	    return false;
+		return false;
 
 	return true;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
