Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB43BCE7A8A
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Sep 2023 12:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A83710E109;
	Sun, 24 Sep 2023 12:13:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0925C10E109
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Sep 2023 12:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX2MJ5Rmgz/xXlyYB7bHDfzCloVfUbXlN9RANHkEb7CNYMflEMz0i19w7x4ynAsAkddy8086Ol3sXjTgEVlX5d8hcQp7FlBhxyTJYcaXbycgQTYUTNzLddsObb7XmmCvSWF7aMBkS2KzXbkGPAB4idQR/K+ZOjsZEXhxrfERrEtgh8cmQyTR0mqKG1PlvreRF5YCGAbdvHZRAhyPPKBEib7V3D7RgJuDchCOLiJyVU6JLwBYbXu3djYnxhNPu1VEG5XxIRB1RqNBR3GDipO0U7/0/SvtHPqBSDCJjCKYSqtkmYa3RNKwgUMajPnuPvah/R17ReDWrYZpt9XS5glFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQNtWTPvCxVOtoDC70Y+I/I5Hq4ShTmoAY088gyl21s=;
 b=kpSU1UmCYQizYB1vUEHqpacD7locde5WNACLonzrnG/RM3JS5JGqerDEQ4pk5/uw3PYJDfbcTtXSd+CxTQueHt9YvLD0kHbeELanQnzq15h8AGM5OAfHycoGfGPTadtVWenwJciDNaq9mTtrv7w6QqES7da3id1Wbp8UVWuo3jQFrP4lS93LC5eLoE1G9DhuSzNpd20SvYxNDqqikSAnVezF7dZOwA1iNJrZ9NYqmVtN9w7Y3co/VNQQGqPGeVTJOMANpo5s/Xd7nADmnZ2Dc8m7Vh270T2O6ON/qVItBDnrzl6xRgNErqTGKd5URWi13zu3tnP7eIa5p/knPuQ4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQNtWTPvCxVOtoDC70Y+I/I5Hq4ShTmoAY088gyl21s=;
 b=ixk53lrytT+7yIjyUhPjDwTnKblLvSNT1bQEJnFSpdhG2hUL924tipBQu8MzxRSmyWuSXfSrCAmYnZI3xCnafcMI/hoVQZkoOkyJ1QTBzvx+P++E38estMdl073+BUTOGDbSivIZtXBsVMQlkhN9UURoUaM+8Cu+uCn5cya/98E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 24 Sep
 2023 12:13:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%6]) with mapi id 15.20.6813.017; Sun, 24 Sep 2023
 12:13:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma,
 Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu:Expose physical id of device in XGMI hive
Thread-Topic: [PATCH v2] drm/amdgpu:Expose physical id of device in XGMI hive
Thread-Index: AQHZ7RgfkhncaIho6keWLYZ1pFm/d7Ap5pnw
Date: Sun, 24 Sep 2023 12:13:35 +0000
Message-ID: <BN9PR12MB5257C01DB693D6DB879E4306FCFDA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230922054555.838605-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20230922054555.838605-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a049b9e5-db29-4714-b7a4-3e97b1437d5d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-24T12:12:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4220:EE_
x-ms-office365-filtering-correlation-id: 09394695-0b41-4280-5d60-08dbbcf7ad60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDR5X5FKC8Xv1j1pYJk9gwOQ1OcNROye7KWCZ7CZBHJF/lSj1hWpPUVIRXxdDBKW/x/3+JJJvGHRxE/2rciQdboHHN5lN2v6d8eYFFc3w5wK6yARstRjjW1R8Iz2SMnYGrbB+9ceotquVkluxX9kjHb+C1fsCZsR9lq4N3lIlMrgvEgY3zLbcK10WzQK8i6YYOihrPK5rhH11PLyoY1JpTw29x1yM7WD6vu2PAQHmo84V7yiaCJadmEtbtV1jyAZBUpJe6L3KG0Uv3UehIBJoay1y2wT33UhachPUfjqLxLlrw02Bv9igW4wj4M7Bu35aqDmk6jbsC9tbiJznmGOPu8m1RH3NxIaY8TeD4RbShFatQ2ETYiTSdtWg6hVn9LqZBQQl3V7CiP6n8CDxvZRErULyGoggfY+HkpAQJPp4leOO9pxl60PdC6gtwlOlbuipWcmFVwrAgCD0ZnqcamPizu7b3qSfzYvr8LHTSPSqszZrGFd219XKqTWniBcor0PBNSVlo4nKpdCVi7osIOXMoPWpk6dfaX6CoWpx2jZq23rDkVzhw2Had0q3n2AC1cET7QgEL53VXWUvWLdiEji2EniX3qDBgFccfN3rdz9y8idqXlHMjycG+ViM/6zgRKG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(8936002)(4326008)(8676002)(55016003)(26005)(110136005)(52536014)(2906002)(478600001)(6636002)(66476007)(316002)(41300700001)(76116006)(66556008)(66446008)(64756008)(54906003)(66946007)(5660300002)(6506007)(7696005)(71200400001)(53546011)(9686003)(83380400001)(122000001)(38070700005)(38100700002)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9N+SN9SKJq44C+clFhcFW29H6OJSSCpaLoK9yystF2YcJXMrZX9JFP11fE9z?=
 =?us-ascii?Q?A/MwGT2CA8Cf9P3KcnZZv7udDG8RLaPcdOxMd5gPkBfUvsnVjBuFm+NIE4Sp?=
 =?us-ascii?Q?GBN4zNMABUxdUs/Sn9EVrk6U+tzzEDk6w28bXsUGJHfZT0USp2krrMbVQ2kx?=
 =?us-ascii?Q?VzhEZq3lEKxwH8n2BlJQa4d7zM3CQ3n9q5h/qVgf/ge4wbPV6Ec14Bf8PTYF?=
 =?us-ascii?Q?yEKfFYqRyMjQc3rQuBuBRK/erxHXbh9h+MQ610FRd3lQPPmTVl1PPLLebpHK?=
 =?us-ascii?Q?VggiEYoPnTbuWWzoD+PNAD5Wdf02xbUzRrXuUwXyoMUX9DmJQpztJV91984C?=
 =?us-ascii?Q?he4tiVirUdSPLXx3Bg1iDWDvYFOBFXlZN5QuHGIj+BwVYxZKcrWZWqwZOxeo?=
 =?us-ascii?Q?CF/r44JhUTgzAjcBZ/HyjPHE2/3/EiBunv+PBujbcy5i9PckqN5n/DQZ3AQd?=
 =?us-ascii?Q?qpN8aYAfBsoFHr3CEE1oCnui2aR6Diek/V2XPv0WEKuntToItn4T7iaCxibE?=
 =?us-ascii?Q?+dC8n2v4RxNn5d/SrK9YCXwZupl7HxMBzwGaxnrjcJFGJ/BtDajV3J0MjnFr?=
 =?us-ascii?Q?3ZoQwgmw4wef5ztGBYTvcE9BCxFh5jjNQ93+8IAEmsAAPlp/uDm1tje2O7mj?=
 =?us-ascii?Q?i8zW+WIq1vI3u+2xKQGlZloiy1U7vGnZHPsNyOXsL8XrrFPaL0yFQWX+iihf?=
 =?us-ascii?Q?B7Vxhd9YD9PFlFMnkxLvJERw/pfU2U2hNzo+Pk/XyzV2rPA03B/3MXSyX5hf?=
 =?us-ascii?Q?CAxel9713rhfHQGxS3aElwQ1/aZLvlEhZWQ8dTbms8Ku3ZRpvmP/e4Wpg66w?=
 =?us-ascii?Q?qLZ2c6pdj1CqYt9IjAPdE3KGXPw5pj3JiGZqc1taoYlBALbRTu8qq8e8dLLH?=
 =?us-ascii?Q?S+ip9856F0ZTLb292zy7OJ8wZcXBJH/xfyePL51QT0338R9TNG6xdzLjn8jJ?=
 =?us-ascii?Q?9CaZvrOIjT0FH3wnPCIUcgNt0N72Poo9jBAD5Rj9X4gHSXOaDoCxgtFkP8jh?=
 =?us-ascii?Q?KP6X/MPRPH5ptJUkvLfLI29mdgm1zMYFYVIDAliuGmBXvu/ZuGjFvSZSX3bS?=
 =?us-ascii?Q?v5MjV/o+erlKI6Sw7rjoJ4FB8+pIv9c7NOsPwufmeGeT1WVM4ZEDJVHabi9E?=
 =?us-ascii?Q?IRumQk2bfV88Wj72EDhuHAR182Je/inkkQqJLjd3nWAgv34mMtsW44Ow+TBF?=
 =?us-ascii?Q?+HREm1N/KgAnSuAB0E41dlqY1sq2fV1h4qQNE+Px8Dakw02jaLW0sqBiwT7X?=
 =?us-ascii?Q?CyuSIrmF0jHpPHU5LLHuvg8z160t6ueF07wNGosEfn4xSSnuIaJO8/EkfdOK?=
 =?us-ascii?Q?81SX9MBdml3sbZyKf7MpxdcAJQCeuHyvn+SrBE+qwstkNvx+4nh5em7set7g?=
 =?us-ascii?Q?1F2S5WWhasDxQFc2828/IdzdCk4o6tmf3qpftGhfjPWOnyYVJ5UvYRNGRQqu?=
 =?us-ascii?Q?YTfpbFeCt+Ij5kIbNJx9vib+FBURMEMHw2Ge8ZWhSg/+aWdpg/dM751eWzub?=
 =?us-ascii?Q?UW85F3yM6PJNlAoZdX3Qt05Yub3h80Wr24P6Zf7m/T3eARyIrPj/6kTlOXnh?=
 =?us-ascii?Q?DLMYS3Qi7IobscPw6S4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09394695-0b41-4280-5d60-08dbbcf7ad60
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2023 12:13:35.4164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zkCspPk4sYxgwkJWkyhLD2xoD355//ALHWagTLrtLa4CTIWhIX8Z4uCkasXPnrcERS9t5kB2yhT/GmMQDnzZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gadre, Mangesh <Mangesh.Gadre@amd.com>
Sent: Friday, September 22, 2023 13:46
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Sh=
iwu.Zhang@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu:Expose physical id of device in XGMI hive

This identifies the physical ordering of devices in the hive

v2: fix compilation issue

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 061534e845a7..02770c632bac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -325,6 +325,17 @@ static ssize_t amdgpu_xgmi_show_device_id(struct devic=
e *dev,

 }

+static ssize_t amdgpu_xgmi_show_physical_id(struct device *dev,
+                                    struct device_attribute *attr,
+                                    char *buf)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       return sysfs_emit(buf, "%u\n", adev->gmc.xgmi.physical_node_id);
+
+}
+
 static ssize_t amdgpu_xgmi_show_num_hops(struct device *dev,
                                        struct device_attribute *attr,
                                        char *buf)
@@ -390,6 +401,7 @@ static ssize_t amdgpu_xgmi_show_error(struct device *de=
v,


 static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NU=
LL);
+static DEVICE_ATTR(xgmi_physical_id, 0444,
+amdgpu_xgmi_show_physical_id, NULL);
 static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);  st=
atic DEVICE_ATTR(xgmi_num_hops, S_IRUGO, amdgpu_xgmi_show_num_hops, NULL); =
 static DEVICE_ATTR(xgmi_num_links, S_IRUGO, amdgpu_xgmi_show_num_links, NU=
LL); @@ -407,6 +419,12 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct =
amdgpu_device *adev,
                return ret;
        }

+       ret =3D device_create_file(adev->dev, &dev_attr_xgmi_physical_id);
+       if (ret) {
+               dev_err(adev->dev, "XGMI: Failed to create device file xgmi=
_physical_id\n");
+               return ret;
+       }
+
        /* Create xgmi error file */
        ret =3D device_create_file(adev->dev, &dev_attr_xgmi_error);
        if (ret)
@@ -448,6 +466,7 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu=
_device *adev,

 remove_file:
        device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
+       device_remove_file(adev->dev, &dev_attr_xgmi_physical_id);
        device_remove_file(adev->dev, &dev_attr_xgmi_error);
        device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
        device_remove_file(adev->dev, &dev_attr_xgmi_num_links); @@ -463,6 =
+482,7 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *=
adev,
        memset(node, 0, sizeof(node));

        device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
+       device_remove_file(adev->dev, &dev_attr_xgmi_physical_id);
        device_remove_file(adev->dev, &dev_attr_xgmi_error);
        device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
        device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
--
2.34.1

