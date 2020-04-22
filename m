Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368AFC38A30
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07824206D9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q40oi0hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07824206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38336E4F3;
	Wed, 22 Apr 2020 06:00:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A277B6E4E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 06:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9wYjdOdBy9sppu+WIRNf5R6j5UoBgHRhzdIfPGu/aNtAVO2upuanngdrRGCWpX2Bbqifbwc9smnMcjIwUJ3pxa2JPM4BKEJ/QsyEaXfyZwIEZ2emZfkr5QPzwS9uJoRSzFpVDS825LKMmrSA7se7Q2cGeKU5/5d7M2qvUJMMclX7xq2gCuvM86gYP/b2YOAIWfOcbInyxXyp6v9BXtsgz1jltCU3VRK0S35TORvdawr5BLmEPY/I3dBv78Ul+Yp+t1caJt4+j1C/YuSuhsaKTEklsGOQKdunPsh39fh9nk6CgNMLUUabaq9An+4rY/VjCnzcFA7QR/grIIZOSbrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuO3rrrzj2aijEi5YvAJ+1/Gc8axMPq7HvvZBgGrskM=;
 b=cCJ5ovqhPS4oQGwEi1A+Utja3VlM4uSusHnyA8qb+Fsb/X/sV4o5RYY+jmt36LRsKjUf/H1NGhWWlOvL1RAmuhoQ07LPxUQ+ib2U/pS+4IbJwJDmAoxWXwXwTpB/pFywcYpABPXz9TbtzTjGDCvjHJwWZvOM1sScoswDjPfWQBEn9ChH7IDlLcWcSOuyuIRaI/J7waq1IbVrQEwDOsTno1o8PIUYpqpIsLu/wTP47pBJc12CZ3C0MwYszVTfXcrMAcoe/ZRomM0tZCtWxhK6l5GMipgwTA9/vUjbVWwcMlnDQSo7MPHBoTHAH3NHdRlFYshPaaLJ6JqMjc/5tEocFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuO3rrrzj2aijEi5YvAJ+1/Gc8axMPq7HvvZBgGrskM=;
 b=Q40oi0hi8lVHr9Y68EBslp4ADgeOEPgqR1f1/t60EgGtXZe3PQ+T9Gc9u9ULwrOWo7yRp9jUvdDTYFRNsOmyvTi5FuoC1Hz1jVcqcBCfcGBlconJqptR4k1BNJxVxNL1zkGS3FKr44P7jGoSLyOIw41nuUCA4HaV7elvKu3l56Y=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1848.namprd12.prod.outlook.com (2603:10b6:903:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 06:00:22 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 06:00:22 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: set error query ready after all IPs late
 init
Thread-Topic: [PATCH v2] drm/amdgpu: set error query ready after all IPs late
 init
Thread-Index: AQHWGGrXRGyVfKI7aUmGnulBTwyBN6iEpadQ
Date: Wed, 22 Apr 2020 06:00:22 +0000
Message-ID: <CY4PR12MB1287201682322B13C85FA45EF1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200422055646.30347-1-Dennis.Li@amd.com>
In-Reply-To: <20200422055646.30347-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-22T06:00:04Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2438d38d-6e35-4106-88c1-00003ea27a05;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-22T06:00:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 83145b69-9b69-428b-9e60-0000268957d0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc3ef213-737c-4070-e035-08d7e68271eb
x-ms-traffictypediagnostic: CY4PR12MB1848:|CY4PR12MB1848:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1848452041464CCFEA53E081F1D20@CY4PR12MB1848.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39850400004)(136003)(376002)(366004)(396003)(5660300002)(316002)(6506007)(53546011)(478600001)(186003)(66476007)(2906002)(110136005)(7696005)(26005)(52536014)(66446008)(76116006)(9686003)(4326008)(6636002)(55016002)(66946007)(33656002)(64756008)(66556008)(86362001)(81156014)(71200400001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fvS1ZvdaChkORXL5awOb+jb/zhkom4hBvaQgsE3pQrepw0b4QIyC96pp/3t4qZHb8jVa0GuSY945BXba38l5w/q2qy6z/JXCwbjxCOxEpPkpu25GnqE8C14jWS2/vMwg/aOJPV7fTcAGOBilL8Vas9VT2OnoN1zm5Fk3AH+JuKB4L4FKLY5Tebh/fV1PaioMG97/gsb62iFnGJYdSt2KdE/Gw2++4FlVae1eqJYw9RIQHMujdy2E1RsI0uLg2YlLVyCmlhBgDVxXdFp5MTE5Sz9gc2rghxJlD4uUxXcD5kKEFQZz2fP+3LlDKrLptZV64RCMXcFOJTwn5fJEHlcI5TQVaX4zLm+dE3RSZxNsKULSwpcM/+6P36cobClgqOrO2378VWKKdNmMdiy56IiUb2R8TChIuznEJ8w8iZPZ6TmkbJgHwjTYKfO9Mo+un6eD
x-ms-exchange-antispam-messagedata: wNPM6Ukg/xIYNeyAC1YhSG9nxqk8hZTw/X8aVUhyC6bYG1IN2MVKVdZNeF/ChVOgVE+jazeYXmUfY8qf6Hmm11ngPTLyHPm8I3h9qq709AemIAwXOXNrmkYeeXrJsjQ/XaTOedX2WYrPDo/khUcLdw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3ef213-737c-4070-e035-08d7e68271eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 06:00:22.6585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sj6SlVX9e834xLAFdzKhAM0Gkfguttn/BLC1oS0bgRfzAuVdyZG6e/Xpf/q0pQILFSrSn4mRVhtGC8SF3uriA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1848
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, April 22, 2020 1:57 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: set error query ready after all IPs late init

If set error query ready in amdgpu_ras_late_init, which will cause some IP blocks aren't initialized, but their error query is ready.

v2: change the prefix of title to "drm/amdgpu" and remove the unnecessary "{}".

Change-Id: I5087527261cb1b462afd82ad7592cf1ef73b15bd
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 423eed223aa5..e37e0982cd46 100644
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
index 68b82f7b0b80..8b14aee370c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1921,10 +1921,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	}
 
 	/* in resume phase, no need to create ras fs node */
-	if (adev->in_suspend || adev->in_gpu_reset) {
-		amdgpu_ras_set_error_query_ready(adev, true);
+	if (adev->in_suspend || adev->in_gpu_reset)
 		return 0;
-	}
 
 	if (ih_info->cb) {
 		r = amdgpu_ras_interrupt_add_handler(adev, ih_info); @@ -1936,8 +1934,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
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
