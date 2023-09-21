Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B82C2FC0C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 07:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EA010E56A;
	Thu, 21 Sep 2023 07:04:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7290910E56A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 07:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+8nG4WgOLit73FjF1C7gAxNG/ScL0E0GQl33SRL3Vc+6f2sfg2DVwE8+GikDZboGBz1utDX3rbMDewPBWQH7mk/wQF+X9SJg64Dx8/1F/tiTLz5qvSbvl5cSI6EUhO7SwlfE62D5nYSfArKlrZrHkdUJ9TpU6GKIaZfa0s+qwB7Rd5MSSHgVP4hS4ZDlCRGHNW+uH0ucJLFHwEBvDMd4/cRhja/Ijwkk21dcoc+9ij2NyMBy02ojX0s9H8h7zUSkCqp3h5vvMXYkuGz+FxkePuh1kcW58XSB3tXBI5x0T7NBx+FNiyaZfZ4mn3yM08oXE2f/KOi3/j8U0NzJCnLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd8kvpv8M3RCkfp1rJs0lK8kI0GDtLxhUacn4k/TRvk=;
 b=W6Yx+B/j5Wk9XmWc67KrpgfYzPAWyZAYTe8+x+7qppnU/xMf5bPl19gp77NxI05t7acJ8nDcSShiU1ykXeC4tiiig2zmvTX0LBD2g+ztJAr3HWfIvl3mm5DkYPfOl89GsaiJpzeRmo4LFzDBkdy5niPC0ViNhXQbi6RkHeZUoBbb3D5j9kNquSdoU8gNQBxdh55wc4nCS0WRGstP1x1Q5esYUfWdjWKF9EzbzGiRQ2IxcP/gwExTOQTwOygwcwBT+/yOA8LGqpw2h1W4ssnP7oCoYvaj3Qq2Jq1oVhrDqlPaQXnKg7vQ/q7KMlZ8HlPh1b3SA4/luZshhm+jiYrhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd8kvpv8M3RCkfp1rJs0lK8kI0GDtLxhUacn4k/TRvk=;
 b=WZp6DI33OWvMQocIdjVTO+BPFRUuhjNK345eN/juvZpaHq046JboGQtrkuQj+6LlkcFZC7s3tHLgpCOUBJyo8HCEehUA3w6whpGjPDo1+YNd5jaTSWFmrx04rBCc1WiOZRjlRnMofjKFaJnDdUp6rxENp4QbfhypMX7IWgZFJvw=
Received: from CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 07:04:10 +0000
Received: from CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::e34c:6461:a974:4c77]) by CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::e34c:6461:a974:4c77%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 07:04:10 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Expose physical id of device in XGMI hive
Thread-Topic: [PATCH] drm/amdgpu:Expose physical id of device in XGMI hive
Thread-Index: AQHZ7EU1x/xXaOV7gEyoYQPU0Mwdg7Ak2p0Q
Date: Thu, 21 Sep 2023 07:04:10 +0000
Message-ID: <CY5PR12MB60813F7A23726EE11AA88DFD8EF8A@CY5PR12MB6081.namprd12.prod.outlook.com>
References: <20230921043551.3903891-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20230921043551.3903891-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d1e9f4b-9ea4-4409-93da-4cb9ded9b3f6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-21T07:02:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6081:EE_|DM4PR12MB5055:EE_
x-ms-office365-filtering-correlation-id: 126d6feb-b908-4bef-86e4-08dbba70f48c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H9NVlwNCQkKWfhqauOnwowpfWrY/bNjtD5+JNp3oQ5V4BtPzLZ9Re1yPPAsmeWSCSFPZk1XvpQI6XDdT3vtk+8elTGDCGng26B79YcNSExIt8fj2bOr3P0K9SYczzWkGm1KY4kBVnH0LUFKkSkz6EiO0gH4MYvZ5Zp0/qaip9lYeTIaSRU46T7I3x8lslNJmX39b6SwsLTOrJiNu2Ghhx2oyCaAdV1XdvT+d+WA2frvFxkFaADDaqfvMO38P48Gx3TXancW4wMAg9Ezxcftbv1l92y9GCCuBuZbjShOK22nVTac92L61pJnwgtN+GqfEOeIQd+Qgbz6IXMzyLPPliqJpmiWw4ONeGcWfT8w3sf7TvOYAYJOWh6/dQrw7mHu/jthYfaGZtj1UO8qdn2N9kVTlJoKsEZhL1bR27oN7/gtmyqEz7/PbGei+beOkeo0cF9YSDUrR23FyBP5WIl+dhS47lnJu3DqxtUI6xteb9VmiX/wPvV7swSZUzkvlu0hmY6CdoKk5WMFsTh/A+4Ey5jYQ9q6fEGMAftbTkZ/IhKjD88WbB4+6SS4vy0KOCNGkv/wPp3lsu3YHVOO4zceYhn9v4UE5dTEzJG5NE2IYc+ZJrubi45A/1WYPXmBUyX9L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6081.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(1800799009)(186009)(451199024)(55016003)(83380400001)(76116006)(5660300002)(54906003)(7696005)(64756008)(9686003)(921005)(122000001)(53546011)(6506007)(71200400001)(41300700001)(2906002)(6636002)(66556008)(8676002)(66446008)(52536014)(4326008)(38070700005)(110136005)(66476007)(8936002)(316002)(86362001)(38100700002)(66946007)(33656002)(478600001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eQJHLjyfslH8xuxgk2NVczbPnLG1eqbEdoPaHrRLYzKzF7KqrLETbP5DrxNS?=
 =?us-ascii?Q?NC4dj1pmSapLeJgo7NyqLLp+LP5Ii7IYrZu76ARVpMHIi80csdUVnpQMHfmP?=
 =?us-ascii?Q?h6l/08/6ktw7WrYYTYf4feLvDZB6xp/cLYOlG+etHvD7u8wCx9fGJNb4DOzS?=
 =?us-ascii?Q?u5nDCUL8vWIeZEDBYrNyJ49S+xmyB1OE+hQdOiAKKXXwBNz3Hb/NKdvmR+PE?=
 =?us-ascii?Q?fT4XkXsIuVXGbZm2UXeDqtfpvcwyzfnerp5WYayh80zHg/2w4TXtKtYN96Pg?=
 =?us-ascii?Q?qIIVrQF/tEEhJQioqzBH6BP1nH5wpefqLxom0hTTCs0CIm4RRgnZ9te+wQEr?=
 =?us-ascii?Q?hKwLRCKDsfK7FoBv9pyPOAXY9RKZB1F2Z5eBdf3eiQmcMb0qLhjqKcMQWrIZ?=
 =?us-ascii?Q?0txUVFQIPoA7KxFJux7okprBMfj0zVlIhEz64+J+FPr1lQrjodC0I/XbdN8v?=
 =?us-ascii?Q?42fJIr4b9bpi4yiNYHVa/1LiSy0sChnTzjIFfQ9y/GN9Skcn5z38+jc184lu?=
 =?us-ascii?Q?5RLJp5Sfjvg3Ul6AxH5N0SmLTBoCgeGtgjYwucbP9uhc8/hSorxgS1ReI0hw?=
 =?us-ascii?Q?AXR5pGRl9+gxGju4G4JdPqlZXUBjDgzBDYDWAzwq9Xm+JIi76xiu1gMgakgJ?=
 =?us-ascii?Q?RoD2I6MFLCxxtF9wKZ9NgP4zjaYYtZ92B2s/KFOZRnQqAbcZ53rI86DTMAlN?=
 =?us-ascii?Q?fbDwRGw/CVmkzpHvOFRwW5LoOO14os49uILxEyS/B7HcealWZNvyx/IfeTF0?=
 =?us-ascii?Q?E1IygmQYV5QxmjG6cX5bounYl49YbqYN60NgwEBhZ78INjO7MPQkB23mk4Vp?=
 =?us-ascii?Q?VVPFwfxeO02qLW4GE+jV/5Nr+EdR2Corq/D0w+pSTnzw3Ebct9MBz72alFuv?=
 =?us-ascii?Q?l2qNsNLF37jH+nV2+8uRqFtiH7+WRi3vh6iGCIrPYOhZFynXM7gkrHloLfx8?=
 =?us-ascii?Q?deYOtILPEZjOeB0EaFWgjee8nlnSUCQqqsYOAsdixcw8OlcugzdWKiHSWu3v?=
 =?us-ascii?Q?p0tZfIw//kW2CLmz30YSuB+OuAsT8q1nmOe7C64ZD0So0102FmZRUBt8RG2+?=
 =?us-ascii?Q?a/nhKLleTB9/8y9KYhGIOufqxniFc3MIWyloBHFF6yVQaZa3r391GuKFc2p9?=
 =?us-ascii?Q?BGpRBxJDbQM4eqSBCSq/jqLlcdpGPyZZ4mN8/f0ZgLSbaNBvVWmKkf2r1A3z?=
 =?us-ascii?Q?zavO2P6Rshsng/1yJbyA2xvQ3/IFeVTWXjjFxNGyiuOEuzcDKgE8osI01JRR?=
 =?us-ascii?Q?INHpwmxLCRbxINrWXQe+MpvJ3yZ7INKb/dbRtHg9FHYXuU6oqYpcNksHFBS8?=
 =?us-ascii?Q?BUF9gN6vn88UULF+vN1Mjg1UrtgpRMOzNVly9++6d09756zNSKl9n+8yi4zK?=
 =?us-ascii?Q?eY4vpKBXXv9o6b7nG7yPVGVlbf/oSwXcbxLZnZnPqH0PdynPZH6lIuz/Ix6h?=
 =?us-ascii?Q?PKz+nOWDFBNr0G8bS3MEzrgszNt0M91FJ+dF7f+yRPxHhhiraggtuTgDng/Y?=
 =?us-ascii?Q?/n30IvEw6U1g27pKZVscizV9lWV7IUU2h5i17hv+DJ6vw5VsSUpNVyC3qZkc?=
 =?us-ascii?Q?+8Rq3heYrMCLrVMFrgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6081.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126d6feb-b908-4bef-86e4-08dbba70f48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 07:04:10.5001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3Cy5o/iAsUUnvx7vATtjcLoAczx4Y9PruEnbfdAT1eZ2IqzwWDas1NgL8Pz7BDllz/ZA8O+7nt78z8MG7VB0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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
Cc: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mangesh =
Gadre
Sent: Thursday, September 21, 2023 10:06 AM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Sh=
iwu.Zhang@amd.com>
Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>
Subject: [PATCH] drm/amdgpu:Expose physical id of device in XGMI hive

This identifies the physical ordering of devices in the hive

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 061534e845a7..4cf38164d72c 100644
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
+       return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.physical_node_id);
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
[Kamal, Asad]  Can we use S_IRUGO in place of hard code value 0444?

Regards
Asad
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

