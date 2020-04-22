Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7990C54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 04:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794572072D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 04:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RlhCWFbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794572072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BE06E0AB;
	Wed, 22 Apr 2020 04:47:36 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA4A6E0AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 04:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W//V+FJrv6crQHCklzgvKrur9Z98mr1hqZoRDvMwKrwBmKO9CpYQTZ+YrTcM0KadeTyrmryMs//VSzflEKS5D1Zll08ErLxDvNeoMzufpL2UPlSc4sqjvPUe7OGzF6Qba9/ZilmURwlbYMWiy/WfFlTah1yXJ495by1bBo0QqbMkxptklm4u60S5E4zKhHcYACak7AEAxHCt+80yohgIBK4T5m6X56WNTYAFxfGOWH8sEIw7SKRUqLoXmkHc2fVXSD3IpNwHYziXrO8CWKTPuGqPszpW7IA5UHNAOMKi1hDInnMoIDU7Bk/jb55E94GK28n+GyQStJtQTcbEGuUZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odnozvrlTwbuJ8wEyype3tlBdMAy+EHDxpRGmDR/U8A=;
 b=PboN+j3/lb+UpQeev/dOb3eFE3Ex+hWOrYtA8Rgm9A3Dnkf9Fuu5ZhuHs3WFKZcgWp4n9paeYX3A1O0sX3pQCzxn3fZq50Po76O9EP0LZB01DcTsJhQvDITKGVFbTPySlE/EaQPdrzjW820eLXfiPou++hQo/HRvJz57rs62M8iEVlLvgOlu1Ed09NlYMpYaFWPgAlxLupSFABos7qayy8elU+0Ttn5X0vbHcdhNogfaq+qKbS+TJKq94BNFs9QT8IMhvuAn73iRR5hGudJsMXSRtv14tpt2P2fneQQcZGn7D7XmtBTIFnuI/Ncr4x1zly8kR7NDFzjPOtB+FRRbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odnozvrlTwbuJ8wEyype3tlBdMAy+EHDxpRGmDR/U8A=;
 b=RlhCWFbGls2VQ8iX3zE7rhQrdGgP7jxXLe3f687PIWgnCLm9G8z2bhwcarFyKlSt/z1jLKR8E7mgcT6PfVs8eqEfADct6YGhDtRI7gUT3SSCqCb7uMILguB9I82ww4uSAMZtghl+6I1Vv9ntzaVMqEzdc6bso4JDo8Khrnv3Acw=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1768.namprd12.prod.outlook.com (2603:10b6:903:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 04:47:31 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 04:47:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: set error query ready after all IPs late
 init
Thread-Topic: [PATCH] drm/amd/amdgpu: set error query ready after all IPs late
 init
Thread-Index: AQHWGF7oz1t3AYkQ2kK9nYiEwl6htaiEkR9Q
Date: Wed, 22 Apr 2020 04:47:30 +0000
Message-ID: <CY4PR12MB128771A12451DBBE9EB21245F1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200422043122.20601-1-Dennis.Li@amd.com>
In-Reply-To: <20200422043122.20601-1-Dennis.Li@amd.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-22T04:47:26Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3f282046-112f-45d6-bd69-00006be8affe
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ae82009-d5ab-4125-d2ab-08d7e678442e
x-ms-traffictypediagnostic: CY4PR12MB1768:|CY4PR12MB1768:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1768495E71D0D19EF958F391F1D20@CY4PR12MB1768.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39850400004)(366004)(136003)(376002)(346002)(7696005)(64756008)(81156014)(8676002)(66556008)(76116006)(53546011)(186003)(5660300002)(2906002)(6636002)(52536014)(8936002)(66476007)(316002)(66946007)(26005)(4326008)(478600001)(86362001)(66446008)(71200400001)(110136005)(33656002)(55016002)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Flo5u6cuUDIz/fBWebh3WgyQWdwVszeBC9NrQrAIoPiWZtpD8mn1qZEoYQ9sjXd2OXw+zi2qKDrDaY67ORUX0TQNRI7zxOHVZiyBWQ3HKEY6DKDapLApGxgrj5lYum3U0KSnJiSKC6q9Ndr2jBsY5wYZnEOvW1lNaldjOThAVXjov5sEiguoWUU8Imi6W4rn1R6qSLT2znvnU4L2wCiK3IihcD8CTBKmLq+61cvh1cm5qYQTP/qtz9gcruoipWQSNJ3MDIhy94wXDSmbO3ZNLGAs4ncjGSM6blnPAJOKISU+D0dmjT/43K3xzScSRP4sfddZ4JattuvBfqBmxXuhjaAdNv9cQHpANiQSlF4xsEzpzDd9KNTuI5crfzLUUGHH8Wh6uX609nbCYd67cicGBPzxtdzYL8mlkPcx6cGJ8tVGRLYIF3rFggNlWA9uLIJv
x-ms-exchange-antispam-messagedata: Oe+0y7cN8KpLYSIWOmmLUDGtQp02QNBLyZEomhVPC8pxIaOn4tgR5e5Y+/Lj4zkgJHW2S7m6GnYtIBnePtzySLJUvXalj3rH8zWixY1rJTOp8T1tCDl2zH2CNjCbplu85lHxvCLw+MBMPQd280ZVSg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae82009-d5ab-4125-d2ab-08d7e678442e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 04:47:30.8338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWzRHZyuGsxlQW454yzZeHsP/1B9ikN5QCq97NZXCTTERZlv4+VyTT69+m60wT50Ug5k+H8CzUV9MuIqSFIYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1768
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
