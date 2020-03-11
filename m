Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48687C10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 08:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B26A2082E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 08:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="trO1hV63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B26A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BE289E69;
	Wed, 11 Mar 2020 08:19:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4BB89DE1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 08:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhKJDQrQWKrPyyP4/lYLktacRukZmJ4/pqJu9sqpxo002X/wOP377du0Fn3ZlrPZrmH1jiLJdMuC46FHsQbrI5uG6UtpQShtRvMufgqZqR0jssdNaX/3H2ZjCV2HVE9OnoIjj+GIrHrI+sAK3Ipkd7z/Zuovo72NFEzr9FPSlp3SGA6AA+2QYVoFWRyEBCY8j6T9kYKcM6uWOIzW8c3KZQExfH5JT/0OjgmfhLY9YTw5Ce/6RG74HYoQA/cVdI9f7JXg5OVim9h9xgLShiz1Pn+ZOrod0HhQIkAUnGxGXIgWAzi2wuPpc19AJ5XybQ3pFdv2mOiPZNP6QjDwDUnmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk9jtiooRzHhDrGa/zyiKAezoJrwUYb8BJOsbBJlp6k=;
 b=HusEkA5l0dZjbLXsJrFwO29utQcwTSTTXAW+1u7/jxtrRY9Sxav3egUhWzvpT3zTDDjgNCFVbbRwZlbqaUHt0obwpqx1X/qETardmosLi6eMQa4Fvr7UBzOPfB00OCSOnNu+LmwKn2NawwJIUFiUi9Ywm4zXhOJjHW8DDMA+4dxKgYGAY6PosROsMUsf834FwHyGZov36W/POPXm7pifnJ0Gg6yvrYeAzD5OVhibQJsEiWaWkY8mAyZ9wjIieLVyysMK+03fdVtvwlrRIn3Ccj47vviFiyzKURhUZqUI8023dS3VI9ym/3eocKuA890u9EscL5YWIOXqvi3HI6Q4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk9jtiooRzHhDrGa/zyiKAezoJrwUYb8BJOsbBJlp6k=;
 b=trO1hV63hGJeeNM4sct6YEM4CNbAzZ7xMx1KlSIRBVXXmmvn5dn07zsXtL894A5nPtTiDJWnxU2DFb6Cy+OgNQA403z8q79Rxak3OqUONRC+UHQIsmG2ewoqSGq3BdUoaetYDUaoHfCiWggCiQ9gaihBMFO6W9OPQ6epwQLgj9E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from BN8PR12MB3329.namprd12.prod.outlook.com (2603:10b6:408:61::29)
 by BN8PR12MB3555.namprd12.prod.outlook.com (2603:10b6:408:48::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 08:19:12 +0000
Received: from BN8PR12MB3329.namprd12.prod.outlook.com
 ([fe80::5b6:1a26:379e:163]) by BN8PR12MB3329.namprd12.prod.outlook.com
 ([fe80::5b6:1a26:379e:163%4]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 08:19:12 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset
Date: Wed, 11 Mar 2020 16:18:53 +0800
Message-Id: <20200311081853.25274-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To BN8PR12MB3329.namprd12.prod.outlook.com
 (2603:10b6:408:61::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0108.apcprd03.prod.outlook.com (2603:1096:203:b0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 11 Mar 2020 08:19:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c0024e2-10ac-4759-d9fa-08d7c594e109
X-MS-TrafficTypeDiagnostic: BN8PR12MB3555:|BN8PR12MB3555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3555E33B02BAC0F2EA4EE016E4FC0@BN8PR12MB3555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(4326008)(26005)(6666004)(52116002)(15650500001)(6486002)(316002)(5660300002)(81156014)(7696005)(8936002)(186003)(8676002)(81166006)(6916009)(16526019)(478600001)(956004)(66476007)(66946007)(2906002)(36756003)(86362001)(2616005)(66556008)(1076003)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3555;
 H:BN8PR12MB3329.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWKNmE93Azl4bqQoId+U59rMR7HTJrzL5JqorQU2Cg0FJZi67olIKjYxWwBKH4NS/oXzUSkNMxN2EN+PGGMX1ZKTfyyk4hhWYwbs4iac5/dIqYauoBNbi8JrUsHbXtuFtsA7MAjOdkBXl65QZZQOQyiznNoXU25htc0A5R4vyqTq57uAaCZYfNzQuIg8Yr3r4ZLbb4/Ll+gASOpjUtppPPKA5b9cEMlz7oEuQLv9fFdwRtFD5BkTjRaIFcawMAQvzDzDKbweHM9/4KUY5ruQSqvIJPVXc5yPMI9MDB6Yx2aoaLszGa9r+xqSd1nSRa7ZzRhCkubi88DPoU5cHEWe3da41vgH9vhI+1mst0+Cy8kXcpv7ac0vevQ92eDOQlaAucQLAtWczD9bxOtglJP78s7u2v29Bkp5GUUEZ+td/GIMI0LYn0MUnYJiYzkrnXqd
X-MS-Exchange-AntiSpam-MessageData: Qj1SQhFwIyI6WLbGtvwB04qsmnLRbaCVuz/3c9TFsx2tHZXfj9TacTanHll+B+ZxwQdpg4/K6ospAhd26iB9iQ4uDGEI86ssKOimJkHDvuJdV1tguCPb03D0b0UexoAURzZBohsn2wyGsW5jasHxaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0024e2-10ac-4759-d9fa-08d7c594e109
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:19:12.4881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxqfPhYBf5Vqb1Tt6abop/ZE/Nlq2fyjC9AFhLLGaRzbwAJ4C7QfVs7Te5hut/06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3555
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can fix the baco reset failure seen on Navi10.
And this should be a low risk fix as the same sequence
is already used for system suspend/resume.

Change-Id: Idb4d02c5fcbbd5b7817195ee04c7af34c346a053
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 572eb6ea8eab..a35c89973614 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3935,6 +3935,8 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 				if (r)
 					goto out;
 
+				amdgpu_fbdev_set_suspend(tmp_adev, 0);
+
 				/* must succeed. */
 				amdgpu_ras_resume(tmp_adev);
 
@@ -4108,6 +4110,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 */
 		amdgpu_unregister_gpu_instance(tmp_adev);
 
+		amdgpu_fbdev_set_suspend(adev, 1);
+
 		/* disable ras on ALL IPs */
 		if (!(in_ras_intr && !use_baco) &&
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
