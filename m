Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A650C5518A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 03:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1D520706
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 03:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Li4lnI7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1D520706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877F16E42E;
	Fri, 24 Apr 2020 03:40:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE786EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 03:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd6ok+Ru363S443FFmgHvBQcI0fw9EgWt26eE3o6zANgZcoGSyPqFSdkLREcKgmowkEWm/xRvWOXKMm7Af/H+ILURVZT0BLl6CHpHgEq7pAnmzUNCaLv/Lwl6U4U1nuWXU8eg21daJlbazMH3Bs7FS6GnxPrv/Xix470WKonAbCQt5zKNYk8obLFMBJ4aeZnKAUjGU0usGCqiQAWAbpAg64yWhZk59iMUmHTG0dO942mx6EvCVmWJNfNqGGADk26bUeivTTpq8Kt4bEbJyYl/0QwUOgwlemiDQyTgT8CmrTi/RlR4LaYM1oEoegvRpsD/luOBI/qHf3/ajJJD/kx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL2stYnkktmIBdubNC7NG8QqpOjALy57pJcIKAOrMC0=;
 b=ZYaZHiJ6cTjqA39b6odnIQChMNxXGd4MEMvzfhUpc8CEFSBscAzMGQcB8zmJAZdjYNCd/hOR2tKS3e5IFyrrvWkKh7wtOk51Heh07mkl3/yet/zJ62xd/gsiPfNMtaJIRnlaOGSmSpQnDmuawNbGX+WdfRcXR7rRABirZbgNfPqqi1PeMLCsm5UP0Xu43e+GOKlrDiXfGjEO0aW6tgxuEy7IMb+7Npf5huY9sv0yy43JSgtU0N3D+phcWypm+zdTuNr6Hw3oHHAza1O/mJkd4s0+g/uQLJchi8y83ZuQIauUTp2peCn56YYEsf9e7DloD4dBAagh32WMRq0iuBHPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL2stYnkktmIBdubNC7NG8QqpOjALy57pJcIKAOrMC0=;
 b=Li4lnI7+D9hDuiGSTxU3psvWMAs8QBqlz2aSwKEOTBFd3xyPFRLnqQAJUTclqHU/QbXsso0THUa3GDpoi7ql9KZ/rnxt0PYEfnsIabiLT2N9VIbsrAcB+sRhCQCs28qFu87zSSH4VGEXZFR96Rx3k4wCPkKMZgOtTDHcKaLM/ps=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Fri, 24 Apr 2020 03:40:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 03:40:49 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/8] drm/amdgpu: skip sysfs node not belong to one vf mode
Thread-Topic: [PATCH 7/8] drm/amdgpu: skip sysfs node not belong to one vf mode
Thread-Index: AQHWGT0eThXeNHIfo0WAefPl8S4bBqiHoVsA
Date: Fri, 24 Apr 2020 03:40:49 +0000
Message-ID: <DM6PR12MB26190466D01F65CE8C5C48BCE4D00@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
 <1587625306-20704-7-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1587625306-20704-7-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=59c94439-ca34-4ffe-910f-00009bb051f3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T03:39:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 305504e7-3f04-4548-0a86-08d7e8014807
x-ms-traffictypediagnostic: DM6PR12MB2635:|DM6PR12MB2635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB26352AE51FBB1F5F83795AFEE4D00@DM6PR12MB2635.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(66556008)(26005)(66476007)(66946007)(81156014)(7696005)(4326008)(76116006)(6506007)(2906002)(8936002)(8676002)(186003)(86362001)(71200400001)(53546011)(55016002)(9686003)(110136005)(52536014)(66446008)(64756008)(478600001)(33656002)(45080400002)(966005)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bd01sxprqyrZ7rnym+R0etKRuIX+gLnoLhh2gUY/OE7UqJo/HgpjH4d4YYEmtmwVe81txrc/kFWYyywquBQ5fyukGIh6bm7oW1lbQWk3D2KvIEZzLbukk76A3LKKyzHglA/mnkEl0tAmT4u1AtPTLB6i3qX3JM1oEXDRpteTXhOYG9f0ypcBhTiNV228YFMfmTv5fGmFdu5Ed2w+mmhTMPuDZUUvV3p5usEPj2qoXJEcx8Pc2u4iLAuC9ou5kipdn2tZWeojMqFYkK+UxGAqQv/4nazniaZ453ZDorlovUuU/J5OcHifzCfQ8x9XWRCtYfylr9yQob5jCLabgxaSHJaAiWVA5aqmDqyKv6MezL5u2wY2YgRwiJT436TWoSt2nb+vLo8YFoGll5CdoYGM9GHqiexI0bz7ujW4w480Lp1zlNeb+2XGgNP92b7E1HTzIQPdVjFTPTx91vv5QHLfkmbdCAQBcRYns1z/q76kPCM=
x-ms-exchange-antispam-messagedata: brNuSCFfnH9tsZzlCAQlPiVx81R4/TIBi50M0WzY2WDk07V/7YIGk2A+PkhTM64pzfCM63nmsbaQu0jk+xgIc2ZxSCfBBYpIXrL9e1VQrOwJUVsBLBGDhGQV0FPmXHgWpZ/SPlk9zm7mDZEzLBg8nQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305504e7-3f04-4548-0a86-08d7e8014807
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 03:40:49.5617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moMXhREbL/V9tQB47+fJKDBNnKB6EotwG0OON4KSWzAgMfNNYb1oVKKa0pd+uzpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Thursday, April 23, 2020 3:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: skip sysfs node not belong to one vf mode

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 48 ++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 49e2e43..c762deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3271,26 +3271,27 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
-
-	ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_num_states\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_cur_state\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_force_state\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_table);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_table\n");
-		return ret;
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_num_states\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_cur_state\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_force_state\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_table);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_table\n");
+			return ret;
+		}
 	}
 [Evan] Please add this for amdgpu_pm_sysfs_init also.
 	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk); @@ -3337,6 +3338,13 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 			return ret;
 		}
 	}
+
+	/* the reset are not needed for SRIOV one vf mode */
[Evan] Typo: 'reset' should be 'rest'.
+	if (amdgpu_sriov_vf(adev)) {
+		adev->pm.sysfs_initialized = true;
+		return ret;
+	}
+
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_pcie);
 		if (ret) {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C2fcb995e57fb4ceeb23608d7e7543adc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637232221351766801&amp;sdata=waHsAN5irYjlYb%2FrY8UT5h2eLu2wjaEw67DcaWJaUDs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
