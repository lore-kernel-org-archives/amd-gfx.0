Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4B6C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 02:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB95A10E28D;
	Tue, 28 Mar 2023 02:58:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4890110E28D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 02:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHH78iVf2I4AbDfcUsySwzpbQ66EnPm1eIkTwBykOXUTyidpIl7RO2fADstPUsyfV0NFX/jJbPkc/hlTnTBj1c6ghOKTxg+34ezIIGlJoQRjq/VrBmGTNsHeeiC6rHlL7XaaiS9OKVMt/y+CLG09+kLAD0ptJN/cUJAddmYPiqpry9EqlWxddSIn20BxFuJixe6FHdgwyq/Ax8zsJYo3jDqwrnBr3vmK9KYwG9fdBuw/JpT9AWyj95l4fs1fJ/WKCKSm980qJie6J3vOaKlskM8kZCk1wrlqeiY7LbNe6h5FUpgQGm1TTe9O8zzIQR/b7shv5vR4ya4WDKdl9T2uUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhX/sPjl/sOQRPh22CP0rwhSutZKheGa4vUZXekCRcU=;
 b=NDA9oryfCwo+kjxKo8yteQQoZK4HErOtFbCGGEI1JjefkgdyzHpBmTiy4SgUTFerzS4kqwi1kzUxzbGD64LBQKKGQCYpN4jEPCeYjGSO6YXcw2ZDtiJt9iWH2rwuoqS4W9CmtpdCMzeETykcK3OPYl4nQksJJQczv/NoofDnJnkGUlXs233J5PPxf594GGBQgBIJTe5ZSwgqwDVu9D8vwJP2l3vXR0n8vNlT4W5E7HmFvLJpsio/icz9QfuNVRzP9VyCZAL+sKpmTpPsZp+jZqHDA036anKzpVRaBENjCb+FPPFKxr4HWu3J21j8sIphLIjGJPlDkGN2aq6Z7URu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhX/sPjl/sOQRPh22CP0rwhSutZKheGa4vUZXekCRcU=;
 b=ysL6qaP5SYNajbRSq0Dalh5Tgo3L4dDAFs3aRzWwfi0GYX422d0T6dtNdHjNLVeTZFRPWbeCHj+S4bQ5ACDUzcGNdV4jmKHGmfCulk6LyGz3jKacb4djqxdobOYgz6d2CiocjgH2MrKvOvddcYfx5onyrJZ3Dz/mHHG0TcBfe/c=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Tue, 28 Mar
 2023 02:58:22 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e680:853a:a2dc:1bb2]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e680:853a:a2dc:1bb2%4]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 02:58:21 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Topic: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Index: AQHZXh+B+AyGm0N4uUeOwCnQofXCIK8Phaqw
Date: Tue, 28 Mar 2023 02:58:21 +0000
Message-ID: <CY5PR12MB636925CCBDF7A87AFED7C3BAC1889@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230324070812.1304117-1-tim.huang@amd.com>
In-Reply-To: <20230324070812.1304117-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-28T02:58:17Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0a9542e7-4f60-4239-bc18-8e2ed9ef31f4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-28T02:58:17Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 309db219-6d4a-4275-8142-44c2e9f2a94b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL1PR12MB5730:EE_
x-ms-office365-filtering-correlation-id: 3c7ae939-74ad-46ed-f57b-08db2f384a7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsJfT1q2A3n+Ad0Y1PxZtAbzy0oh1gfmPMB2dVwN+q7SWKp3EItrACh9s8AE9typlvMAP4eH+cxQLpA2md2DOp1jBw/NaETtJ24AFOtbcahCAeCen6fLSIS1jEnrbWlv2rJH0RTMXsgrzIv8QBf5+Y0Tx+h0WRvSBZfUnPO9JRLSux3V2IvIZ8wYGj/DmL80gxcon0VinaM+ygy5HDVjRiZ0/RtW9ZcOPkgRpiQtzwIASAuYVsC4YBCKWqrESAtxRtNleTzmlQYdxzpBd+JG4xmJnu2hIkRwANxZwFgWiiXM6gkCKDLoQ1EvKPNtj2UJtDeAg+I60OgW7liH5U/+tr2Y4q7c9X33T5vdZoD6CBWAUO89GkUsKLk0vxoA426LWFGPbfJl48TJMv6QeGgYHit7ZMPy0d3YjazMqvWGrF1duPL+yTKChZ62dZ8hrdiQyQNWVqmiQstfbRK/SCkoz6N25+TWNmkbURoT4HzchTGhs2KiAtDUatHm1rYuHcD82hs3RtvR5ziCBMIUq8+mvB4EEb6217uaBeH9W2F0kwwNVge2Pi1x58D2c/oWl9gnP2UBIsT132P3qhB8T+vgS0onqfN/u07A0O7+oV14NVlPZN7k7yJw4+CCElBW7aCZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(38100700002)(110136005)(478600001)(316002)(76116006)(41300700001)(64756008)(54906003)(4326008)(66446008)(66476007)(66556008)(8676002)(66946007)(52536014)(8936002)(71200400001)(5660300002)(122000001)(7696005)(38070700005)(83380400001)(55016003)(2906002)(186003)(6506007)(9686003)(53546011)(26005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ZalBieqk+91TDq/BZDLug8MhMNPhsHrGw3bs2GfL6pSOcm5OBfw9/XjSDbi?=
 =?us-ascii?Q?OiJBVsCLbeEKS3HkiUOz+xf/PBz/rr/9bn8TelHyo2J8PJsphm0c4//yX3oN?=
 =?us-ascii?Q?Gop9crMOwO2oT4i2hAp3lqiGvrVUxOjgSWx2QuFCyed4SAkEiK8M4izhW4PR?=
 =?us-ascii?Q?3dwdRIdTtYIeQBJfO+gOfxcCQLFq4hmZ4P1CWh5+S2k35frfroRTWXWyVHdr?=
 =?us-ascii?Q?SIqrGC6p/93UcgwFL3AqmDuz3xnkfWkYwibJcJ6h+LgEyNAd4TKjoWQbSSff?=
 =?us-ascii?Q?5PLNk4YEvb+/3gpmvKYzg2es+I4CW4I1Hgt/C16XYie8u6hBL7kbpP8c+7nt?=
 =?us-ascii?Q?uCr008ke1rD0R/oiyNU6cF0nEtC6D6H9ZIvWoOcJEv7nNM9rS1boGZ/59NBS?=
 =?us-ascii?Q?j+o4prmq3ydevvkRyK6Ymyyd9u7AhCNdqSb8Vy8LRls5f0uweoQhmkFvuc2O?=
 =?us-ascii?Q?lWoFe4wWUR2yWD/8ByUk+nBpaTdS/u4PVmaAssS0g+84SB7F1eHgEXaziLvF?=
 =?us-ascii?Q?cHGpVDCQl4vK4o/jVkSrWyGAcyPomG3vTjA0xOzl8wY654LP7il3krR9TLK9?=
 =?us-ascii?Q?Xqqjzx0jSGlvzgcuFAq9hMEV69Uindh17PS2f7/0C3yQtfZ7p30bnlKYiRMt?=
 =?us-ascii?Q?f6InsnpNQZKC7uNN5sA2C8XL5GPwFH70zE5Vigs5Oqz8fc//p4DB3mZPavQs?=
 =?us-ascii?Q?ytCclHAj+c4m1hSfeI9ih5KULocBxeS0eg3OOgbhTLpNwdOWjzDOxXdhdF6t?=
 =?us-ascii?Q?xxXEkHDjl/EnckcjvsIzhZ/P4Py0vrKCY/nhzOXLzfzVPwNECwIn5uN2g4Ab?=
 =?us-ascii?Q?OmCitLfsW4wNBunEmePIO4j3P3wDA+tqtkvMOAj9G+hYHcDOp1QY+Yhk/74p?=
 =?us-ascii?Q?66P82gvI60Yeec1tFRLiCxdXHWwgNrTgDZGFF8cvouPyQKwcvrUhqp2GpRYV?=
 =?us-ascii?Q?ux8Lhm7JRUZQPzUOmT7p9GuJP9edgWt/t6WE3F7LfP+g5Zd1orvQR+DUkt9H?=
 =?us-ascii?Q?tD/Icdr/hlrO3G5IetWiS0H0A1tc7SEcYGMCkG/1MN0VrLZCN5ukAmK5w2nL?=
 =?us-ascii?Q?M7NJjY7VAYO22wiC4XIyLUAXFPkUP/CKB2WcFGal6WedkwdlXlCvDF3DR8dN?=
 =?us-ascii?Q?qUcFrF+LhrDxiYlYoZu4q5eto6e6idGBsbC1k66YfC7fNLI4woFuZ0dfjzFx?=
 =?us-ascii?Q?Hu1RLIRQTVhQ2qT0okjAwih+FqfqpTDYd+hgJ14NcE7KYWUV+OytrC77VGIA?=
 =?us-ascii?Q?SwNNKF4MxqDzLf8A3D4xhsjAXRK2MejPPNfmawdU9hxvLUaSF+pahFF00zjF?=
 =?us-ascii?Q?Y6s8wC/MbvKijtQyhI7zmxj1FL426KTDI3gD0eBzgYGUR9WcxUa308dqqwjw?=
 =?us-ascii?Q?HhBXg+PJ0ePyqgGfXaeUzQdJm74lbq2aWDNFRggQx2RYCrWIE0lO/IhafJ74?=
 =?us-ascii?Q?mEu9xp3lhQhxi+l1Hm+43pV01IRy/FsfH8ia27hEa7UfMzrP3Gge1y935YtQ?=
 =?us-ascii?Q?MKjveCBxqDNv9os02Gzk3da3osQIva7p9rKqX+u6geYcjOjl+aclkYeRLRap?=
 =?us-ascii?Q?ZXbAyt1jLYGIctjV05U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ae939-74ad-46ed-f57b-08db2f384a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:58:21.7368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2omWe3YK+fwzMk2xwIIqbysFfvADcc7Go4aQtIBTRCDPB6FSi4SKgfEyvm7M1ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Li" <Li.Ma@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is :

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>=20
Sent: Friday, March 24, 2023 3:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.com>; H=
uang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume

If the gfx imu is poweroff when suspend, then it need to be re-enabled when=
 resume.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40 ++++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index b5d64749990e..94fe8593444a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -162,10 +162,15 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
=20
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu)  {
-	if (!smu->ppt_funcs || !smu->ppt_funcs->set_gfx_power_up_by_imu)
-		return -EOPNOTSUPP;
+	int ret =3D 0;
+	struct amdgpu_device *adev =3D smu->adev;
=20
-	return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+	if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
+		ret =3D smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+		if (ret)
+			dev_err(adev->dev, "Failed to enable gfx imu!\n");
+	}
+	return ret;
 }
=20
 static u32 smu_get_mclk(void *handle, bool low) @@ -196,6 +201,19 @@ stati=
c u32 smu_get_sclk(void *handle, bool low)
 	return clk_freq * 100;
 }
=20
+static int smu_set_gfx_imu_enable(struct smu_context *smu) {
+	struct amdgpu_device *adev =3D smu->adev;
+
+	if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
+		return 0;
+
+	if (amdgpu_in_reset(smu->adev) || adev->in_s0ix)
+		return 0;
+
+	return smu_set_gfx_power_up_by_imu(smu); }
+
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 				  bool enable)
 {
@@ -1396,15 +1414,9 @@ static int smu_hw_init(void *handle)
 	}
=20
 	if (smu->is_apu) {
-		if ((smu->ppt_funcs->set_gfx_power_up_by_imu) &&
-				likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) {
-			ret =3D smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
-			if (ret) {
-				dev_err(adev->dev, "Failed to Enable gfx imu!\n");
-				return ret;
-			}
-		}
-
+		ret =3D smu_set_gfx_imu_enable(smu);
+		if (ret)
+			return ret;
 		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_set_gfx_cgpg(smu, true);
@@ -1681,6 +1693,10 @@ static int smu_resume(void *handle)
 		return ret;
 	}
=20
+	ret =3D smu_set_gfx_imu_enable(smu);
+	if (ret)
+		return ret;
+
 	smu_set_gfx_cgpg(smu, true);
=20
 	smu->disable_uclk_switch =3D 0;
--
2.25.1
