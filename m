Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40362C04A95
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 01:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF9E10E8BF;
	Thu, 29 Sep 2022 01:43:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035C310E8BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 01:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qle671noB+6s7n+K4fyi8GwsdRCHVqlDQNZMz/SOpyPkGYD4lqpj3UHpu4aYm01W1LxBbIyGUklRofZ/x8Y5QY4I2WWW9B2u5mcmy1meMjmiKfEWfFFwki8VF304NcwfOrfU/CMOQ0JDDdXjoUloC2kNzZkI9ZchI6DXt1f/QFChrhJweG3Xn4RZWbw/+zMa/HNqJShaRuEyStl/c34aywU3PCVa1xDigw+QOohfoWT1DiDhDi8cNCjMI5FsbRoiNQOPF6mciOiPXnzc9xD65ZDYh2+Qy5QM+nLBpWgjjvZINJRVj0v/YVmBD5G23/FId634UT7ucW1As01U5NvDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPNJYx8i/GqRQe+NUqG2HKHr9Wwn995Aa46hjykW3+o=;
 b=XF/orjTm0roTLc2E4fW5qLOM30uapHuYTE7oIeuXQQYztGZ3LSMud8pckD7RWIzZMpL0Wmo4xIeqBfGUJW4QvwIrAsVhF1O7lgayZCPEDAh2Gw4AwnDgdYaSlkoLB+vjF57zj+0s9YMoz/jQ9zJw/WtWE9otVmuShS0YeSrzeiBJacilOmRtcXFtLR+U92Uxyhi5SctX07pNqKR1dB4yeJLwg5/20P3RQhKVasjDenfDSIOjU7AVwavb7xgpLNzhlQwN9kff8aZ7x/kp7hldzsnQdOzP8xQAe0U1LYB86Sk+TyeUwY8M0tiZXKpwL/E3+QWLGDyMILIcgh041gUdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPNJYx8i/GqRQe+NUqG2HKHr9Wwn995Aa46hjykW3+o=;
 b=CuhfTh6AI8QdSmzYJluxEzSdmFcziw9cBs7WcC4mVjZ1o5ASEO36Vpd48oc4fZ9qN1nf7i7FEDAWhrDCw0VaxV0lT7WtSkqA0sos/j3sSR98cAreGFfg6W8qL4he3188Yx/M5RbFghI1EldK6Fwqne0LMxz+gjQtnx3BfUQTxG8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Thu, 29 Sep 2022 01:43:26 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0%7]) with mapi id 15.20.5654.026; Thu, 29 Sep 2022
 01:43:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: ignore rlc ucode validation
Thread-Topic: [PATCH] drm/amdgpu/gfx10: ignore rlc ucode validation
Thread-Index: AQHY03Df73IL7kpJlUyt9mopvWa3BK31osgw
Date: Thu, 29 Sep 2022 01:43:25 +0000
Message-ID: <DM5PR12MB2469256F0C29C10F3649A117F1579@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220928193043.5729-1-alexander.deucher@amd.com>
In-Reply-To: <20220928193043.5729-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CY8PR12MB7610:EE_
x-ms-office365-filtering-correlation-id: 745544ce-16bb-4163-237c-08daa1bc005d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hiTrIdHVe6H0zgfmxs2JIBnKH98tvVEAXeXhggruHgV6gbEVMj20VpCLqQRfpt50mM41GoWiLDOuegnlYT+an4k2Kg5CAi1c4zZSTM7lutBEuTcxWptnHV3AsFE9+kTcmrX9zel87ACrdbgo2A2/1Gk+7qtrDATxIZH2J+C/yWK32gsgdnHLSb5lKeMJXIVrEdDlBfZXU7VMFU3fv8fA1+l9X7Yo1IYCvcwB5VBVezksOYjNZ6sMdMtWuajqptjYIM5Ep5OMkKarm5NYcn/qqwQ3gDmZg8efBde87PY3L9xxYdEpgtB43t2Fj49asaEgSHFHguERxMj4ZOv5aYv9o9knm/6pSfygwo8dkC5McX1bYlGj317IrAT6Pas4xp8eB4LTq2TH8jADB/yYtLdffrPerDX3rdJ8JlnSJAJ3ed3xL7mYh4eayNgvgPB5TDJvtuMvcWH6HVeU/qZu2QYhZxXY1Pj1oP0bDrVHK6DQK6jh5PwyusFeCucTL1jHfL8EPLEKe71kS7iZJVw08l6LKHaxzicUHOYDivyF8842pKi7K/28pi5MNeob8y1XkqWJEFhH9aPmbrSKmwJKvMB6Os9LTwYZHBY4lAlU1Z7pzBwLXOq/yz2wZd1Faejj8VWViM6hkK56LzvfoqazGFDb8p29nVCkmcTNdR3y7syiZwfOcJlTJfJCNx6vaViGl2mWvM/NRPx/ltr13YSYHO58AQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(9686003)(966005)(5660300002)(478600001)(66946007)(26005)(86362001)(186003)(8936002)(53546011)(7696005)(6506007)(110136005)(52536014)(45080400002)(66476007)(316002)(122000001)(76116006)(64756008)(66446008)(4326008)(38100700002)(71200400001)(41300700001)(55016003)(2906002)(8676002)(66556008)(83380400001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O47VH2GR/J85RwPXz/iYoXZybp4QWfKU3SSknNlKUJ/CNhQztzd6RjtOGPxW?=
 =?us-ascii?Q?7PwQbh/Cs7jnFPWllywJewyQdXDYkE3GNo+S+2SzL6V6uquvgxd8p/9FvF2L?=
 =?us-ascii?Q?wF3PQSwErzaF1CV0ZaysdtJBLtz8371fBIR+g9JvtFoRWzMNIL/fFYSo9OPn?=
 =?us-ascii?Q?9f/PHzyxrSgs4VHs7p2bpW+EaJMWvrzkmcP0fUmjAyfStKKmZU72rFMsSrvd?=
 =?us-ascii?Q?QkLg5TPCWz7hbARpC2LAxvkgsRQOfv23hPD4TKBfz5k91TocnTO2Ed4zswOZ?=
 =?us-ascii?Q?mWuvLlUKPayQl9tmn7vWjkeovhoYsKyBWZkun4h1o5iIev3i2tQz2RHq0fUM?=
 =?us-ascii?Q?hC/zHzwFFBsJDht6neXun4xeNZTruLD3L944kC8fCrb6C7LF2Wn73JJZTGOc?=
 =?us-ascii?Q?rBYOYinTZyMH4Negrvy05Np8tJm9zL8zczoJvC+1QzEgCQ0gElZlXe0vCSGP?=
 =?us-ascii?Q?Af7yiPQ7NWHFDa6dOOsU3n/QDW447kEdL8c2o+E4suU/HGzxkmwEtiD2gjsM?=
 =?us-ascii?Q?zQROdNHdoEKPDfquz2g5xUhjWEC2vXbwjS0Zi8dwioa8xeoi3db4hw9qBMhk?=
 =?us-ascii?Q?xo7sdiPwCbLmiHYo4TEi+u9EQXBuWQgb/MiCot6f/61IJ7IR95GM98OI0ULC?=
 =?us-ascii?Q?ulvZc8BOmVdpIlOulM1LYwZZRmIsd2RY1b1ZlZ1zdbAhD5wCe8kMs5Feb/rc?=
 =?us-ascii?Q?iRhebcuYsv8IIPt4ildSBCKYnIgHOSzx0eqbzfVDBF3YIbaeq+d+r2lflLGL?=
 =?us-ascii?Q?CNGOMK6jLm+PqNZW3FsbmNXFMchhozUVogzKdymym+rh4FO3TrnUPV0AoRDh?=
 =?us-ascii?Q?plhol1N3x/xZW30BBM/aesIxvjd4IBaVM8kCrtk52s2hKxiWNUt77DLibc8K?=
 =?us-ascii?Q?DfMqfA7FfYoWiwoTskc6D+5FKdIiK+Ceg3cJrSOjSHqLqAf9NacnyWHivAnw?=
 =?us-ascii?Q?I8+yCmcC3krP7U0qo5bEz4Ab4qnKl6YcVF63K7VW7Y2kVP44yDYYcc1a12MG?=
 =?us-ascii?Q?FimcHCfx/JpTCIwTXJwJecr/6x+UMxQwzy9wUNNE1qPOmu8ezPjBRJE7CEPd?=
 =?us-ascii?Q?C7ukzC5simnX7ny2KoR2wEls/Ycm8Nxu/C0RdICLos4EDYN1rtrhw2q1S8Gi?=
 =?us-ascii?Q?QE72f5DHVe8g+ekSOEKQhDwaLkzXHzfkKwEZq6KjI0A47rQd/QkHcMY22ywb?=
 =?us-ascii?Q?wwZy47hHoJ7UC0UI8mvEBTEp3dP0RK1GQvUG7m65j09pWb+ilnLXWletRMom?=
 =?us-ascii?Q?6+Kr+nFChqRIC1Qk0LAalUOl2Pk4BY9d6m19+3qxX7XWB3vXBnyXdMEbjiY1?=
 =?us-ascii?Q?VZibjEEIPnn8azzSd2DCnSvraPDijrfFIuHigtj5xVKwFg6/gZAqqc/GSg8c?=
 =?us-ascii?Q?XtH3mGwLFutpHjevm7jQwoKlGbvZE+Riow/NWmqBM8XJ12heiZ1j8g9lPTEG?=
 =?us-ascii?Q?Okuk7b/88KdWTLOJp/ecyfRJIJZWvk8FRLkaK3RB0DXE4XRp2P2kwrW4RHrF?=
 =?us-ascii?Q?/MotWOBSVOi5BoNPIycMw3xQR+VmkBzx3fHPEbt7B3lGXTtEgzdwmdomPpJr?=
 =?us-ascii?Q?qQjHG0usEaNsLnfZeDn8P7xfLVUaJnylgTEtZgRz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745544ce-16bb-4163-237c-08daa1bc005d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 01:43:25.8374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbAkgdVNbRXngM5GI6HGLnOiseeG5rDQYPwpIq7Zc+wHXDtWQMdMo5czVSeMhGVc7CfPdcMbnX03B2wxAyMjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, September 29, 2022 3:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: ignore rlc ucode validation

There are apparently ucode versions in the wild with incorrect sizes specif=
ied in the header.  We never checked this before, so don't start now.

Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2170&amp;data=3D05%7C01%7Cg=
uchun.chen%40amd.com%7C83b76835cb62401dd4a408daa18800ea%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637999902754962693%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&amp;sdata=3DBvwLB%2BugxkJ11k%2Bu6Cz6MvdgUJsZ6sE77VETnIUD41s%3D&amp;reserv=
ed=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 18809c3da178..af94ac580d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4061,9 +4061,14 @@ static int gfx_v10_0_init_microcode(struct amdgpu_de=
vice *adev)
 		err =3D request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
 		if (err)
 			goto out;
+		/* don't check this.  There are apparently firmwares in the wild with
+		 * incorrect size in the header
+		 */
 		err =3D amdgpu_ucode_validate(adev->gfx.rlc_fw);
 		if (err)
-			goto out;
+			dev_dbg(adev->dev,
+				"gfx10: amdgpu_ucode_validate() failed \"%s\"\n",
+				fw_name);
 		rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->d=
ata;
 		version_major =3D le16_to_cpu(rlc_hdr->header.header_version_major);
 		version_minor =3D le16_to_cpu(rlc_hdr->header.header_version_minor);
--
2.37.3

