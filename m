Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7865CC38A30
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 05:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F1D2070B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 05:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xyyfi7vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F1D2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1626E0EB;
	Wed, 22 Apr 2020 05:48:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927176E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 05:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmJ1jc3V0Ad+Xx0Zz7Sj30hGbekd+alNKUDnmrl1+v20PU3XCuG9Rcwwj7YLzsVM1qmhfJV2VDiDWYKJCC2mgTAarGALFs+PnHpxBFTKxQxRlK2VvCYuEEwPHZAJBImNpIAf2/aouydKZlCxHAKLjiTiQwAqdEsE7kTPiUnOoVhzjRYIczjYHY1JwrCQKtn4o9pwn3QxJxPz3/RMd5OK9zeNyy052CNVKOdBLKDEtihXJfnAURzRlS4mN/e4a43b/fOVaA2JJvXnQiwsxxap/clk3YqiLdTk6W46YZebBzgEmdzQUdi0k7ItV9RtwZjdxULOskEHEjuwtqw87oDqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7IiCN0fZEd3DJQwWUtUZDbxd688Nn4aI5hpDRCfwuI=;
 b=mPT0W71LklwZPcyP/QTYN7O9BcFjQvijAJtywXe2k0kosDcxYJ8OEPzVWNhURHdUWojjSCNJjReaNLm/cuqfaDPOi54CaLWRCx549szMnuEvcM+drw8QZeK9F4Yobxq8jnU3C4OxUD18ticraHUj3zQ0ZiDMaW4GndFZ5B+wHTxblnX940cktIKjWlcxXVMQsS/8VRQ5hSoA8vdH/c8OYn6bvDIScroB6PmmWDWQvzBlu3n1qSygmwRDCdKKoYLsqQo3zV+H+GhC7mOCcTmO4ec7FNGaf1nxbjYAmEGzC66OeWxmsQDNbP7KLZFpLbvhrpofbYj4Z8pZIL9qfmbHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7IiCN0fZEd3DJQwWUtUZDbxd688Nn4aI5hpDRCfwuI=;
 b=Xyyfi7vsBrmg5Zxx+povl96yQnOGqVpAIf8EkAzvNT+xxXHi+GDs5iH5cf7w8vB2/pHmj7NipS46PqKN2tKKn+2obUhTE8wmHVOZs0cF/wKPXDLzW646h4AAdo0GKd2ITfKGImgsNPgQhGv1RUwoxMOxyXwZtPS00jxV0fp4wHc=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3450.namprd12.prod.outlook.com (2603:10b6:5:116::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Wed, 22 Apr 2020 05:48:51 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 05:48:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: set error query ready after all IPs late
 init
Thread-Topic: [PATCH] drm/amd/amdgpu: set error query ready after all IPs late
 init
Thread-Index: AQHWGF7o6WYix/a4mkSCcT8p0Qq8k6iEkYQAgAAQQlA=
Date: Wed, 22 Apr 2020 05:48:51 +0000
Message-ID: <DM6PR12MB4075AA4A49C36FE8D97220EAFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200422043122.20601-1-Dennis.Li@amd.com>
 <CY4PR12MB128771A12451DBBE9EB21245F1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB128771A12451DBBE9EB21245F1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-22T04:46:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=55be81ef-9afd-4628-847e-000096199b39;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-22T05:48:48Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 583aee68-0bf1-4274-a9b9-00005e98a1ea
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cec470a-7378-4779-d9f1-08d7e680d618
x-ms-traffictypediagnostic: DM6PR12MB3450:|DM6PR12MB3450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34502A169966FA87F214AA8BFCD20@DM6PR12MB3450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:513;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39850400004)(81156014)(76116006)(86362001)(9686003)(8936002)(8676002)(4326008)(26005)(55016002)(6636002)(52536014)(66946007)(186003)(71200400001)(33656002)(5660300002)(64756008)(2906002)(66446008)(478600001)(53546011)(66556008)(66476007)(7696005)(110136005)(6506007)(316002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qmmJA0Fq/zW8YU3U2NZbib48Nk8phJmhOig3K+qVcEk9rVxxPRq96bkp1uyCtNJtN2uM+F8J538eS6xNxsRvaYVlUI+pdxD1ZQ/+NE9AyQ16HD2K2KTBOwbEOKd16yLQwuh0F3u9d2qsHUKA2dKjLgRywKB5aMkpdq+EtO80ryn0Qh59/q2b7zdr/V/v5FcrpWy8uSoJm2L24oHsTA2yVhoZfUqj7m2FJmeCbxonXTtv0rwqXyW0GLX16aaXv5ZRvZYaJbyMnJl9k6qauTuX4zYks+7jEKz7bVOPAQEvQfReMR79eQhThyxwBLygNWpXYSb46oAhmg50SDTYkaUT53g+mBEZt6PROEmgvGzzqG/vqY1UtpnRi6APCQQhjQmpaGFlLR7gG0DQbYMSenSS3meY5Kzcd4uGzg2raqo14hqZqppT4hmwzcLfa4GDOKdD
x-ms-exchange-antispam-messagedata: BgLqSijt8yDgofs96GXqU5SEWRdX4EyOssbHPH1LDuHKW4uEF6A0KwZ7qqT3pX6y6UscYoqp0YOhqS738gd9OHTmtK4SZKvNn0Aukof+BbY/0isajqjd+gXdNb+5AI8Ypi8WiV6Hd3HY+FHld3a0tA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cec470a-7378-4779-d9f1-08d7e680d618
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 05:48:51.7224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Erhst6/OylxBzeLMaBlf6AC3d1uEQlqvrmJ5kpUZaM+rr8e5A4WC3vfnwfN6dRZB4pUv25rewAwfL9vwnjZ+Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3450
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

	if (adev->in_suspend || adev->in_gpu_reset) {
-		amdgpu_ras_set_error_query_ready(adev, true);
 		return 0;
 	}
Please also remove the "{}". With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, April 22, 2020 12:48
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: set error query ready after all IPs late init

[AMD Public Use]

Need to modify prefix of commit tile to 'drm/amdgpu'.

With that fixed, the patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, April 22, 2020 12:31 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amd/amdgpu: set error query ready after all IPs late init

If set error query ready in amdgpu_ras_late_init, which will cause some IP blocks aren't initialized, but their error query is ready.

Change-Id: I5087527261cb1b462afd82ad7592cf1ef73b15bd
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
old mode 100644
new mode 100755
index 423eed223aa5..e37e0982cd46
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2218,6 +2218,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
+	amdgpu_ras_set_error_query_ready(adev, true);
+
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 68b82f7b0b80..060866d372a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1922,7 +1922,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 
 	/* in resume phase, no need to create ras fs node */
 	if (adev->in_suspend || adev->in_gpu_reset) {
-		amdgpu_ras_set_error_query_ready(adev, true);
 		return 0;
 	}
 
@@ -1936,8 +1935,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	if (r)
 		goto sysfs;
 
-	amdgpu_ras_set_error_query_ready(adev, true);
-
 	return 0;
 cleanup:
 	amdgpu_ras_sysfs_remove(adev, ras_block);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
