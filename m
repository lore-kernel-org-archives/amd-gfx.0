Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B94C00528
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 21:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE9410E303;
	Mon, 31 Jul 2023 21:16:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E7510E2F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 21:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPFr8kaHfhzs7q+yXNY3X/ZxkURy+JjFo/oEwCUfG/dyl5M6iRn4vni1y270fv+8eTQDyHfmeYz/Y/gK23TxnfdQz7y9jmLLpyyvP+x2KPtoSDUg1vHl35eMq7lUKGpSbmIcEvEA09sBVvfS6JVRys+cJEE0MhWWwtAJFRChPD9upPL1Hx4JQqitF/Duv3oM4xSXizgWFG6gg2cXvc+Ns3jsA34QKDFacPjHTqurJnUJ1Twne3wM14834zpiDvV39EkJ8/8+PuNqPWeP32T35hL4IMs8WO6+B/XGc+56khjycFm9KrukidoXZ/63v48f+bxucu1aK134vYTt6p967g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1xSt/7aR0Z3OUlsI6tQFH7sksHZ53G6Ez3knGXUeCw=;
 b=fkknRoo5sfiCUBlq0uaUSFOJwa9zl91eNTpZer6W+kDCJQF1Y9Z2zLK4wY+HyRUzL041rBbeq36zyWHaY7eeWB7kfIXoZiHADB0mBZbPz3CLsTYoedJ9fLTBBiM28evDtJQvXjwD26oJorS8SsTkBdqazVo1G3NLcVGXwsr/AgGb4q0pYZIkJVjToMLuleWgxAFTVnJ/Y+EQn/vH7iIn0tfgYKaC3PSSsHTtgTMFfzwM9mVpvdB44iyzzJwAloG25pQPxhbFK7IMiXcBqz9ckRH0wQJ11nkhfS/1yMXnKQ906xMCtIGcGI+MPGrfNXInsFlwqfwSsRl0cixh3go8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1xSt/7aR0Z3OUlsI6tQFH7sksHZ53G6Ez3knGXUeCw=;
 b=TFpDQM/zzA5eZ7kNWKVIu00Y8cNaRKoAU+CHyVdUbDDn40hVoIeu8OeKwNr0c0LTeKFZjt5Dr6kZdGCRcDYN+hoWLo2J605Op74hx2Ljbc3gyK3I9H0yRn3xd1xOxSuDeoramnwEco5alkqt7TmFuhzIyeJoEkfe13Gg8g6E9y4=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Mon, 31 Jul
 2023 21:16:14 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::a5f3:e7b0:83dd:c832]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::a5f3:e7b0:83dd:c832%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 21:16:13 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Messinger, Ori" <Ori.Messinger@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Report Missing MES Firmware Versions with
 Sysfs
Thread-Topic: [PATCH] drm/amdgpu: Report Missing MES Firmware Versions with
 Sysfs
Thread-Index: AQHZwX4IuIK8r1NaWkCy714VDLHiC6/UZV5g
Date: Mon, 31 Jul 2023 21:16:13 +0000
Message-ID: <CY8PR12MB7099D8342EC80851D5D7F2768C05A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20230728180423.864002-1-Ori.Messinger@amd.com>
In-Reply-To: <20230728180423.864002-1-Ori.Messinger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e54f38c1-627c-46bb-9ddf-df24aa71f80d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-31T21:15:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|IA0PR12MB8864:EE_
x-ms-office365-filtering-correlation-id: d0e7d7c2-14c3-4b2c-c5f3-08db920b5ede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvvanOHDSc3YO1gqUGXF2AH9qKm6JpQxmcLac74jIVS7XQd6kBnNt6+dJgMvNan04Hu2meS51vCG1xHlTMvQMeU3br8/R7bn+Nwmp6HhIGcO6DaIuRrvp4Zg/sHzLq/OV9JKqrkAj8joYF0cK4T/O04hFWLh8yM6qofv63qpVvo7lwkzCMUwi95fxDRR++JqYGe6GTI2P7pGnJ1+9N76AVm7tyIps9csYxl/YM7xfsYu68dkgWpbFkFq95onrHa6a7ML5HzDbqcFgiMnQonkMZrF3iIYMT9wyiHPtSL9KpPQcKtBeyq6NHl09hQKywb3VmVP7hj8vo4uI7wM9FgINm/ntVHyZ3fNWh2fSWpC0V1BFs5cpKj/raSjBQs8/GxwdkPqnNfS0kfM5U45EfMl1WAtk69BLviNp4mLrf+TW9uz9+cEAJLFkOk5EdsBWSSI9225fNZLv44p594p4PW2rV8Zd7CLP8vxFPDCFPn7Dv+sk8pP0ZHA0mjf3BokspuoSfiZxMAy7YFfqMbsuJ3+gyYTV4Y4EsrIRwmxTx9fi0OsU5ncxr+ZPN6qmV/EugvqTaLXps1VvmZ38XKsw7Hrg3e+EIC8qrj9j10KuTCb9MTJXPhcUCioyHlw663FWMIf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(38100700002)(86362001)(66476007)(8676002)(8936002)(64756008)(5660300002)(316002)(4326008)(66446008)(122000001)(33656002)(76116006)(52536014)(66556008)(66946007)(110136005)(41300700001)(38070700005)(478600001)(2906002)(71200400001)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(53546011)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/dDgGNTsCth0tOqyorQEDvyb++VaPGDe+WrpSuBiK1+EpZQgQK67ZTZpYkG/?=
 =?us-ascii?Q?jorPetCr32ZToj1kWcJ5X/5jXx+mQa/Dd3LBqAsbdkvSwA9txqxCZ1PmWsCJ?=
 =?us-ascii?Q?b4dAvWaRqxkMUswBKZULJCUOXm5QsFTX5X2DY3ESroGStaaSLYAuCaZdJ1eG?=
 =?us-ascii?Q?eXzkDcXxFUvirLrSY87HcpTiwSnAfq0JqqlKzX6O28T0OjhZbte3RBa6BaeB?=
 =?us-ascii?Q?wF2Kc64s7L+JGT/jpEgmAvdezxQ9Nr93fnugDvwiMXhD5ZY+R5fZ7y1Z3Bx2?=
 =?us-ascii?Q?81J7tEBOTzLmYd0FmPDVxhDz+fTpOUowf69cwXZaPWGuzpvn1lMdnG1JxlWZ?=
 =?us-ascii?Q?4EDjkXwRO342xoGIvM0MtMwEa/fA6+P+Ui93afEpp8nCrEv9mFG/C4Zuuw4z?=
 =?us-ascii?Q?b3MiKdVvVv8su+/4mndPFgeQ0IZre/4FMnD3hvGCMD78edyoP+XxStaMr1Dz?=
 =?us-ascii?Q?XxvLptA8IReOziLL3HJHRFH1IiuvbdxQfvEn1/txA/wEHNSGIKUH30eU2lT8?=
 =?us-ascii?Q?Hcih5leYYROyxCacNJmCTlaNsas/Df8sYAVGh4gGk/IScYh3jzrlaChlI3QI?=
 =?us-ascii?Q?JxIIghaJ+uobOXD0YjvtuU36Ku9rW51ngFbvmpDn/y0DKlaXDcDPoH/QUXRG?=
 =?us-ascii?Q?D1mSxNlcDRpp34y1e4vJ7Uh2+we9vT4/LYtctkrbonLVDiEITXizWsYsb+P/?=
 =?us-ascii?Q?yjbpfd7zC8PEIcK8hk9Ro0m3UYDrz2ki9QnATeTYIC4FewavjyR4vJv1CLZ+?=
 =?us-ascii?Q?292X9R8tF7mc/sDK0/BPADl+aJlQogdz3F5hvDISugED/qD6IQQJp+JCBVkA?=
 =?us-ascii?Q?hCev01pmHJOcDgYbKKNFhDhNyE2rn0KKNk5qmxFvY6p9uD9Fhsb57hwn4A7X?=
 =?us-ascii?Q?vZkBnLmd1m8Tyteihme1PXouQ4uMfGatFttoLrFOKl1CWwzioOBs/nT1Qwx6?=
 =?us-ascii?Q?XEd5cteg6HV7knTc+xyso0ZbzSHn2arKOJoacihZDEuuOtJrZzL9IZxeFmO5?=
 =?us-ascii?Q?oI3DYQNKD5sVdxkoPm1epQyWGv9reXXecojn5pi5kd6ZO+ndjIDS25tNKaTx?=
 =?us-ascii?Q?USXtA9T1zRWGJiK/YAx7OqPdI/5uEmAQcG1gpNzVzEkcmqGCvR1V3miiLsH5?=
 =?us-ascii?Q?b91cm29seYa9mhoz0KmiQWPXrZt++iQZANnUhcvV4oj4TzUmaHfgmb4kcBVv?=
 =?us-ascii?Q?vTqPRa7HEgjxgYqlLHCrmeMlpn4oEDQGysh1ftIFLzVtKdnqgX+jJT8wKBX0?=
 =?us-ascii?Q?6+sy9UYb8UZCmOWYkldNpNcn79gM5tVJkFEfpLOH87jXOvoFKdvw1r/cVH36?=
 =?us-ascii?Q?hnKXBddELnzsahgyCH3zg5QljmWz8R++Sv2bwcz92wDBcD/N6i4rN4zeRUdi?=
 =?us-ascii?Q?RYjuQR+Tg9V1HWbjL5v8bN25JJA/CfBH1lenWKxGM08ysy+JC9mUOS9ZLQp9?=
 =?us-ascii?Q?LtwYg6rzVsmdiQzctxALX/H/3yh3ZEM7bgKcHk6jrGbvur64oNL3CyORWmZx?=
 =?us-ascii?Q?fFC2mhioXxEYAmlPR3NbyJ1v3P2xOo3HMoYLFvlT5HACG4k6XBCm1I3tKNUD?=
 =?us-ascii?Q?hmrB3C2+aVn4jIRcKH0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e7d7c2-14c3-4b2c-c5f3-08db920b5ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 21:16:13.6736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkLVXUKU20oDk3+BDA0jtd8lK/k91YgQ/bvzUTe0t7k2OBNcXQ8b+YV1rdoVnFakKrDU8PJ0Rb7vTgQsLLgP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
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
Cc: "Messinger, Ori" <Ori.Messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ori Mess=
inger
Sent: Friday, July 28, 2023 2:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Messinger, Ori <Ori.Messinger@amd.com>
Subject: [PATCH] drm/amdgpu: Report Missing MES Firmware Versions with Sysf=
s

Added missing MES firmware versions to the 'fw_version' sysfs
directory, they should now exist as a files named "mes_fw_version"
and "mes_kiq_fw_version" found at:

/sys/class/drm/cardX/device/fw_version/mes_fw_version
/sys/class/drm/cardX/device/fw_version/mes_kiq_fw_version
Where X is the card number, and the version is displayed in hexadecimal.

Signed-off-by: Ori Messinger <ori.messinger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index 16807ff96dc9..8beefc045e14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -703,6 +703,8 @@ FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0]=
.fw_version);
 FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
 FW_VERSION_ATTR(vcn_fw_version, 0444, vcn.fw_version);
 FW_VERSION_ATTR(dmcu_fw_version, 0444, dm.dmcu_fw_version);
+FW_VERSION_ATTR(mes_fw_version, 0444, mes.sched_version & AMDGPU_MES_VERSI=
ON_MASK);
+FW_VERSION_ATTR(mes_kiq_fw_version, 0444, mes.kiq_version & AMDGPU_MES_VER=
SION_MASK);

 static struct attribute *fw_attrs[] =3D {
        &dev_attr_vce_fw_version.attr, &dev_attr_uvd_fw_version.attr,
@@ -716,6 +718,7 @@ static struct attribute *fw_attrs[] =3D {
        &dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
        &dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
        &dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
+       &dev_attr_mes_fw_version.attr, &dev_attr_mes_kiq_fw_version.attr,
        NULL
 };

--
2.25.1

