Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD76DC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 13:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48BC310E904;
	Tue, 30 Apr 2024 13:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yudbS8R0";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1177510E772
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 13:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz5uPFSmVKIUPIi2u0MgKKjOBfCqxrmaQygFY9h/pmTycrZrPW6NSb+o3Jj+xZSC5cVlXFyYZtl8nAdAPPIIj+MTfEq0drwDAOzDFYxba1/gx5CO1TqdtZJuirZ52kaYCW8ZxrZ6iFqTwPLcwbwp6B9dEUz1f0i6vxvBOA/kjCNRTSKFP8q9KSssGbsQ+O5LvlEzUiqIAmiBflczIK0ulCcYHJ7aZEFaBgnb9LJ/RMHMX2WiMGOVPXxhLz5bvpZWoY97slrmCdovmTl24XIEkrln/G02BMhwW1eZgQwUXjYBVzbUL1I7yg4j3VBEB6Qsh8/8fgMmVncm6yl29t1AUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejxq+yZZguiyebJ/ZbdcV0IlSkfa66BuyVlYBxv5ymE=;
 b=FCiRLIDbgd7/4rRNPS1z+NLCrmh4pMMV8HSM4p9Rf2sHWejRmePCR01mHtKo6cx7SzINEtAJeWFx8C9JNNLUONlFPf/fnc1CxhUzFMzSzjTqJYNp7tPJtKfMwLp+r7MWp1syOP4tEQHk+44WByQ4iSRV7bi3zUdg/t2LgLm5tGwkMqBdTsskGaISQXpIhjotNuZmSaORXlGl4Twzx/OB2uueI/YFH/3QrIvxtlH1irVwBiiXsfvakYRhTLrwAkn/57o1ZIPxYhQAkB+N68uqP4EUlpuIvOBOTYKjZQx5myZHllFCRBfkNP7ZlEuZ+FZBx26S9i7EfR/10k25peuRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejxq+yZZguiyebJ/ZbdcV0IlSkfa66BuyVlYBxv5ymE=;
 b=yudbS8R0M1NEe7l+o1/Vt538F7O7rbh+L7yQ4ZmhuoZ8/Drkg0mY6bDSvvjsnzDlOvO7RBPOtvgM1enN07SntLEtKshJkuDNEl4Gqm61Ssc7kpIaiRogCC56xkEpMZJNtni58PVZMQVwW8ouqgCtKSjcAx5q9H8wC8oKaMK/4N4=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 13:34:03 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 13:34:03 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>
Subject: RE: [PATCH] drm/amd/amdxcp: Use unique name for partition dev
Thread-Topic: [PATCH] drm/amd/amdxcp: Use unique name for partition dev
Thread-Index: AQHamvK3QcVeDilsdEGc1rdikGj5BLGA0DPQ
Date: Tue, 30 Apr 2024 13:34:02 +0000
Message-ID: <DS7PR12MB60716CA7963A27A92DEA35EE8E1A2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240430113620.322882-1-lijo.lazar@amd.com>
In-Reply-To: <20240430113620.322882-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f7f4de62-00f4-47a0-8394-38b4c03bfdcd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T13:33:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|LV3PR12MB9257:EE_
x-ms-office365-filtering-correlation-id: fcb58fb2-a0e6-4cf5-e345-08dc691a334c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?H1DnI3oo6T5eGe2+Whv9vFOhjI6XHLjQVeILhatRI1uSFsiYZydYZvPUKkEr?=
 =?us-ascii?Q?P7JLoMfd5ewz7v8AWwadMh7ID4/V1tZMNlj5JbpF3B4bccx/7EGDwW9GVMFh?=
 =?us-ascii?Q?fNTj7NV5JOkVhyCU3DOrr4tjlVjo64u3QCKjumvyAGDJAc4WwVnMEdQjjBnw?=
 =?us-ascii?Q?gt23KpQG3GK7Zy+jOkMi+Vc926Cxv64l9t+zVe7NMmSvR59KfsiFkvhi7AEz?=
 =?us-ascii?Q?TA9RJyfdgugUSvnE+b/gvSd+xxsZ4dxFvit3IMO6CwhqYDWkguNHLHj2hxWY?=
 =?us-ascii?Q?Ff9MoedXj6fKsNwXV5E4r2YlXhw9JgOCFzURaqjkb28zNgYh6AYlDoFhIBwH?=
 =?us-ascii?Q?mCn92DL6KCjcOVJ8+IMw4glv7Boi/bQD248jZ094fNv9SKM4x2uVWPU2G+U1?=
 =?us-ascii?Q?TnG/eACiQSq/r9l23oRVT+SNk1KvB07CZrXjQ5KoogtBGsjlxHOvExG12hXR?=
 =?us-ascii?Q?sFYHVlyw683n+f5/P44H9KZDuQrzOJmMxhWVFLc0qVDZcajUmgBagqElg7uZ?=
 =?us-ascii?Q?V6Y8fM/LBWzNuRUKBYh38M6wykQwDZvvuKltmTwxefj2jwxvTNkjKQTbN2qy?=
 =?us-ascii?Q?t3PsHgEwJqLvk4PeMdiVIOPuYxn9yBUKXN1hx4J6i5oisKZ8LF0mURif+7W5?=
 =?us-ascii?Q?MGkkUqSccpZdd3zilSGvVpwkslrRNIe7rOUjdupx3TIq4jF18ZNZiE+FkJ/Y?=
 =?us-ascii?Q?0l5mfABQCrWmcoFXwmMqhuGrdanYHYqa7bA4+Cmj+64UE7aqVvGFrrPaeerT?=
 =?us-ascii?Q?YuivkQW3Mbt4GUrdolT6Mdt3SeXG9BWlToM5omwzdpHNSMtvX8L18YHRxIJs?=
 =?us-ascii?Q?waCFLoqv9TUh9M82syUayLPCN4raviChpGIJaFPq8+CQnTJSbi53sko99Qmz?=
 =?us-ascii?Q?9WlonvzxDtPOYVRpFQ1arLGxnCp9Bq4HPEt8i9sFNP0Ci0ftUrhtvQmcotXD?=
 =?us-ascii?Q?c9PyrmQcQNhje91nggzhgjiERbKsF0ZdUfKHF5PA0xd0TXoqfvOEzDyxksBV?=
 =?us-ascii?Q?6riWHA3mxbJJl7BWAnIuQPey+x4cfea1MB/faF6nb+xLFAzP8OVRFfYwsVhl?=
 =?us-ascii?Q?j3GePGjo0UVMNeYh8Ar3ICYwO5kgLFcSgsKJ2EgS69YkUOA33QJpFlrlXhgE?=
 =?us-ascii?Q?66LvQHojEGESp438J881d0TQRxSzrJXnZl90QsJcS3xddYbVgiRJQXc6gCLJ?=
 =?us-ascii?Q?DuRW+cs91joV2bprLkbVBD/Azojr61DrLe/cL5MJ11Tvd1/EPaGg6lcVEhGr?=
 =?us-ascii?Q?nYP26d6jOHSam1/q19IaZ1iq6P5xQToToCdA8KwslrD7sHYv4oXkm1RPK7qr?=
 =?us-ascii?Q?Q5VuruHbaAxLvG4hQIzq4fAUflWdNpnNCMPv+F1COggMHQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xrkiV9rj4QHY6QjJBmMyqIYQVvA95ZFfufSA0GBTfflEQ9cvoClxmljSqi1y?=
 =?us-ascii?Q?8rpvVus2ZTEpFsRWkVSsyNxdBCctA0wb0VE62DWePpz8OFJx/dbQVk+UDM6n?=
 =?us-ascii?Q?VZCC2MH6Pt4rsG89PIM/5fFAJixKDacB2o4CXZw+8BlOwc9Y3SfEuP+7tirv?=
 =?us-ascii?Q?lJun4fSmGNSK5BD5C2P/uowSbJkuIZeTdYljw9xloQW9Yvpaq+iNm5MsozWS?=
 =?us-ascii?Q?HL/l8mkIVkMZEorPeSceGaWBkVDgSjbf4aKarMt/bXxIVuvmY+2/A6veWQfj?=
 =?us-ascii?Q?qXRTvSBc1/weViHcohtrbjR7uJf9xt3tSoql1mEyzrS+6P3FyefFCl1SRa0l?=
 =?us-ascii?Q?E2q9gKuVLW/LRojYZrzAprmt0nexK/uOICE+M3UcJ0bGU3heCYn0hsIUcUT/?=
 =?us-ascii?Q?MW/j0eHhmGi2fEhMLrCAIR12hvSKWF2/y2eGmDBRtvyv+bdUi0LA3DeG+yOf?=
 =?us-ascii?Q?4FJ95Yosf2F1dfwLK7e2HUxa/xzLc5huVvrycQL19qK1MUybRgEYQCRjDAwU?=
 =?us-ascii?Q?3RXm6vQCu2D1txRUgt/5PFyhXzkW1c4xZ3avDeBjVKOirKBrSbr4V72KvAM9?=
 =?us-ascii?Q?9WDBo/DoZFamOQk4zghbO/EtI7danP0b07QQsJPA63A0L+yUqA/zu8E3ljFr?=
 =?us-ascii?Q?Jln0Km6AH0snnyr7VDbd0UAn6ARmP5uQfbjY8x/OGGl7en5vxOgPUOAUSkG8?=
 =?us-ascii?Q?wtzXVmGlGPoPyeBskeUdJNAjTMGwYxQwoKG367JLq3UnLIugfrU60c/iQT+c?=
 =?us-ascii?Q?j1Zbp71Ab8nyk+lZxddEFznfOBf4Q5DEGIMKsAlSYWpg/f6mtJzUo879a5MQ?=
 =?us-ascii?Q?j0C/DdIJl6dH7+izQpe/9EyRA5EP5vcyqOvgWMxOWDVIoDX89Z/GPN6Sflfb?=
 =?us-ascii?Q?022AjQ7iI4YTRLTBSfDWkFneGjhV9hIxs85qLfY9uv0P2hCorz0EbSabWr3Q?=
 =?us-ascii?Q?Bg8kOLwvUiDB5GV7oBv8T6E+mFmKQidmf/arSkRdIPds/IDMhHixvZ8pO/SH?=
 =?us-ascii?Q?wmUWwT+GJs8ihDL0JpiNrUV5ju0N7lQu2/x66UjSkH+Cq96PkuoUXRxSQb7Q?=
 =?us-ascii?Q?ffGAmjr0vEyA06rqQWuoa8xfvEkFHr6i2iYAZXZtbM8b2ojAignE2So8OlE9?=
 =?us-ascii?Q?r7tdmCAzK41N1jnSW0m2uOSmh1st9M8DIdg0VGAN+MhogUI3XJmfjfoZOdwl?=
 =?us-ascii?Q?jO+v6+tvPqMZcpxa42ayqQ+RCBygnkC4YqI7nb3cYk6DdwpLq3ICOdl6W3ot?=
 =?us-ascii?Q?OA2s6Ty5ozZ/Dm1G/vPniWJlYzCrTf0kla0OuiyAn+oxYQBbK1VSZm3RQfR9?=
 =?us-ascii?Q?G3hihAKnA+FjC6ToIWRBiXoW1nolSs/F0IGknFXDFUYRdSADCeKu29KdI+mC?=
 =?us-ascii?Q?Yfy7T/6wh3TvlvAi+Jzi+D4hdfaeaphUTlJTFq9lPSJnNIrTNz3jTtHUR702?=
 =?us-ascii?Q?OmqFMnUBSRNpC/0Ev0SEyHrCHZbcvk0DGYHTQcb5A08VhTHvX/DmpgOKJnnn?=
 =?us-ascii?Q?/kHQrruT7kBEOsk5ljz6REWWfhtLRxS22JZ0hiHFt6b9dOgyXM7yS9Up8nBh?=
 =?us-ascii?Q?BVSrxWltvGZ3v1+u+5U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb58fb2-a0e6-4cf5-e345-08dc691a334c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 13:34:03.0252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQfGBf0kYy2s9mc9FoqrpV/vqUGNgmIYJmcl/H65Oq1KbI26YR5l5ghdPVyTcVjfu0D5jY9X8GH3ksXtZXve0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, April 30, 2024 5:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhu, James <=
James.Zhu@amd.com>
Subject: [PATCH] drm/amd/amdxcp: Use unique name for partition dev

amdxcp is a platform driver for creating partition devices. libdrm library =
identifies a platform device based on 'OF_FULLNAME' or 'MODALIAS'. If two o=
r more devices have the same platform name, drm library only picks the firs=
t device. Platform driver core uses name of the device to populate 'MODALIA=
S'. When 'amdxcp' is used as the base name, only first partition device get=
s identified. Assign unique name so that drm library identifies partition d=
evices separately.

amdxcp doesn't support probe of partitions, it doesn't bother about modalia=
ses.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c
index 90ddd8371176..b4131053b31b 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -50,12 +50,14 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev) =
 {
        struct platform_device *pdev;
        struct xcp_device *pxcp_dev;
+       char dev_name[20];
        int ret;

        if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE)
                return -ENODEV;

-       pdev =3D platform_device_register_simple("amdgpu_xcp", pdev_num, NU=
LL, 0);
+       snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
+       pdev =3D platform_device_register_simple(dev_name, -1, NULL, 0);
        if (IS_ERR(pdev))
                return PTR_ERR(pdev);

--
2.25.1

