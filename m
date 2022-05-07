Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61668C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  7 May 2022 06:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFA111278D;
	Sat,  7 May 2022 06:25:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACF111278D
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 May 2022 06:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/Xyl5WkyHfr+f5+buLWYYFvE/NR8ZiYeGUCiLSfbjgC0PWG6mIDWCAS0jVWiJbXNzfQt8egPKtm1dxYp+Xr1feA48BFIOWhdYrK9rQFv0fUm0Wz15PF29LYhNiEX+o/vS5gb282HSHeVoxdYUM7942vvktLmnTdhB+NkeKpIuAMTC9ChSbyNyS74u5ILxak4nv9gmNFMZPKF3WenvziVht9g6SOb+soeG6e3caccV87nKfluq+aui5kzXEKXvgZW/Jrgwdjy3kAjdxKMcJeGy/WCPXELdBcisyNfVn2K4ifdd+I6QREcTWeHUaW1zUCMb5BunkUXY5B3I9Qa1LUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06w+6DqzUgf/oqoCeIUMgMekD6tmr/g5navqiTIwsQ4=;
 b=XHjGI+EVBc4kTVi37wwzFf9rxFHG1gzBtPJfzUlRemw+svx5R85QNqLbqNc+NtXjoBajehpApN36l7BzGpzON0llmqxunvPxQl2/1EY60pCViBO/dxNmMdl5JNpU3kBQpSLx5dYMyskpji5UOde4JgY4X4aSgvjg+uVPYNxNJbEKEARF8GIhnm38k4BD80sXdzfSX7Ewdg6PuoSQYYrPghY7PyDynytB4HoB6mep34Dl50jVy2YA8VYYcmiZ+oGLewdCcW9N7ySSbdRca/MAoT/1wivEEbW3zrNdPqeqLr9ACe+Wg3eGtqa63Mbzo4pke7/zhmE15qIYA/dOlLOWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06w+6DqzUgf/oqoCeIUMgMekD6tmr/g5navqiTIwsQ4=;
 b=LycSHntdLmjcRYvbOQGRnyLEeYuHcVoZyQj4OTgr9lJMLNaLaTciFhh824BIpNgD2pqtPHNNkRbaNbMU2YummWaZMnytGjrmtI9i5NAj282VH12mXYDMic0o+eHmxI/CZwaRvLoOBO6+INaFGpxQ41xSE+8UEkjVF8dKmVrveo4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.25; Sat, 7 May 2022 06:25:10 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050%7]) with mapi id 15.20.5227.020; Sat, 7 May 2022
 06:25:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: make smu_v13_0_7_check_fw_status() static
Thread-Topic: [PATCH] drm/amdgpu: make smu_v13_0_7_check_fw_status() static
Thread-Index: AQHYYVZHRmrAdTgFf0y1yFrMGb7x9q0S87Lg
Date: Sat, 7 May 2022 06:25:10 +0000
Message-ID: <DM5PR12MB2469CBC739DAC37E9DF3287FF1C49@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220506143318.2467559-1-alexander.deucher@amd.com>
In-Reply-To: <20220506143318.2467559-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3e041ac-197e-4d1d-0c32-08da2ff2564f
x-ms-traffictypediagnostic: DM4PR12MB5231:EE_
x-microsoft-antispam-prvs: <DM4PR12MB52314B27196ECD375EBC51B0F1C49@DM4PR12MB5231.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9iZ8pGPk/DiycdQu2HY+jG2f9Zz7s5Ntjt2DURqyfkqaWZasEMzyin+HyutMSv30ZmH1dQTxai0JpZDzoQ0j6wGHK6kCIjyoKsrMzimbrj1aT6sMYbSO3ubDBnhjDEXSRFoLxbm3Tl9q4ilR2Wdzb4f5TO8rmjL1C7DOTOlmljYjbxlYxOS41k87/6bl1Z6w92GMk45f6MnHibgx2E6ir1P8o/lSV3wRfLO78dUGwEGna5C7XnqsuFluEK5ho1xL2SwmxYd2KIjDjdFeGJTXm9XlhuilRXbTljsruMlCbLMP6mQzl2OWjidJjSQ1vA27HgmTPFavlZF5WLl6380N5Jv6wijCN3zjDO4/TqteGoauQ1fGx+DswOqxdGsr5jh1BWBayZYFvX5UVe5lH1eDMgzRjVJbfQK4LPwtBRku6/792iYZmXNrfIfjTj/5pTdcE3oq8zJs/IgPwd/jfJXbRldSA3JMvHG/uanOgH33tuffm/Sq/Z7Z2y9AY+UC8cTpmHDtkwjK5krBGXBtUK7ZDjoKA1/JU0I37R+npgDqvw75xB6z0po6l87h7YJRYIOAD8iaJ67DrX/do/qHoclpV+Z2WDff1gM3WJZ90yVDo9VJoffLUnfT2aQbwROaMkSeNRL8Vy4qBX1yR+wMlGRZTMmPXhDybQvP2z2MtltuMsKE6DAAx99LoP2RexUJ1FFiPejzUgJeqtveWMGiJySMXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(52536014)(33656002)(38100700002)(38070700005)(26005)(5660300002)(9686003)(86362001)(122000001)(4326008)(8936002)(7696005)(6506007)(2906002)(508600001)(53546011)(76116006)(316002)(55016003)(54906003)(186003)(110136005)(66946007)(83380400001)(8676002)(66556008)(64756008)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yqlXYlYrVaxibMU1/NPXMDNAHLnCdK4bMVhxrgyPjvg6+IyVmpwsybvBRKh1?=
 =?us-ascii?Q?QGfc5E/1tGWspD0eaQ0WN+nTRJCCGpbySaq9JeDzkpixfrL+a9Z880FNpjDB?=
 =?us-ascii?Q?VyDpgwB5B5XMPVaB313MiUMciKjGVju0P7rGkysnuItaJS4gZBj4saDAX4UV?=
 =?us-ascii?Q?y37zLLGAks24uXJ07RIxCoulY7ALb3NCxK0R+sjn6a4Taok76nDHdqOXIjAw?=
 =?us-ascii?Q?KTz51nDVq3OZeEEFqkiQAqgCroKOL873EHpVGi4eR+nrBX/k+RGU0BbYb919?=
 =?us-ascii?Q?G25uQRu73ePV6zAFeGjCffgZPrwBl7XFFzj2nVrPlAz8K0AV2qV+8y50M+pN?=
 =?us-ascii?Q?PKY/LYjp0bzucQ/6mS/ENC4gEes58oRCeOA6ABYMQ97nHEsAwIptnjnUrOXo?=
 =?us-ascii?Q?eo2Rq5K1D7Knggfb+cS68zDO8l75ifCMEue6CWE80E6m/FzQAfHlb+/i++lr?=
 =?us-ascii?Q?hTO4at1McAxRNu1GbxmbncU4qxmAOSdcJUn0mFSg7MOz3zLVAZDbWwN+zV8Q?=
 =?us-ascii?Q?sqSHDjdAgGAnkSLjxlXC3iJq8kmn8l2hatEQwxNV0ZYafyLZTa32I4le52a7?=
 =?us-ascii?Q?Yd7Mc65gYlhUhlaR01HrkI1s6gb+x0NRoA+IX89zcwnDC/W7J10UHVJjIzyo?=
 =?us-ascii?Q?VI0v0E1kxsepJ5hk+lNYJxkJ5U4qA4vu5S1kkiNDsG5Cw7PhoBc0ZAqhtpXe?=
 =?us-ascii?Q?ezngAINoqifezwCzErxwE1oipepxkZXJVaGfE5DGeLxP+zHbbgNsHxOREMoA?=
 =?us-ascii?Q?pC2mIOYjdEEIOzAk2cUiT9jcTWY5SdPpsktHrLT4u01ub2iqETzVhz5JMhGo?=
 =?us-ascii?Q?p4zXp+nRioQJ1HU80JnvToL7TlsWvildqi52jm5a+Ut8AUjl4G1fZGVcKl31?=
 =?us-ascii?Q?oqeGquPUVhNnEh5AedHIkOtw8hnhQtdz9XapyCUihqkM0AvwNFA7I76V33vm?=
 =?us-ascii?Q?ovBJg8LbVeVpaGU5lFCZD3oZG7+p2peoWi9Z6rJiT4HzLzdZeKKu7nDM9FnK?=
 =?us-ascii?Q?JxhHLfdgFkznzA5xhVlcbSTC+tJbh9gIoD3FpgWiMuevTgy7pmEmQM8bn2mK?=
 =?us-ascii?Q?cwZBZfhosvVmHo7n9uMjOQLWTDSEcfGsXtLjWwgzP1udwqsgx4DJH0snq56H?=
 =?us-ascii?Q?3BusUj+uPTA8J04qgRJMIfpcU+W3I0Ti+DsbLjb+7YOBo0c6aAjzwVrd8MoP?=
 =?us-ascii?Q?uQdQh7A079NfwsDgfvLpyl2igUUO/FxIAO/XPsBztNPI2Qz7X42D8ALCF78+?=
 =?us-ascii?Q?uObn8beqYu/9Bb4L7/rc5nrzAb0UohnWRGj2y2+mLQVLWtyUCqWODCckSqOe?=
 =?us-ascii?Q?LwJ1I4vrd/jeptvGBCilocEnhp/tLhpHF7zPdSS1gI+MVYmTvqcLjyQIMyWw?=
 =?us-ascii?Q?4A9mIoqvxDcbMw7qA/NBJQmKhFCEsR5phY5eh0G7HNztsEd0esTOUfI1V7ix?=
 =?us-ascii?Q?Mts4ib3BpTyHVhTM1Fe56lWCqMhSMTRBW4Nc9NpictsmKruGHfazBIzAqTib?=
 =?us-ascii?Q?XT6rvLGwKFnpK+bmy1I4X838YjdHiNSUe+fDCL6XpjC2yKgsD22CfUOtELu4?=
 =?us-ascii?Q?GK8vSEk3Zere1zaFEbDhcOrrFHE7Cz/fUVx5DWC5h6B14cBcGkd/KnV+frD9?=
 =?us-ascii?Q?lyGq7mhTYa/3sAvg/c6O0XcNISBqKKCD9vSgSOTZ0RnUhVUNpvY6PGtu/vBW?=
 =?us-ascii?Q?vW+FzTOg69uxGADALdYuMH4kW2LAutwpDhCHpR/9e23qd2jhvgQbEOP2D3Nx?=
 =?us-ascii?Q?dceYsaA4Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e041ac-197e-4d1d-0c32-08da2ff2564f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 06:25:10.2333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goZ56KL82VFMy0VK7flpypIftRJsPDepp5S7OhBF3VRyLnY5tlCuovxAp+zmwPMwlT5dj8ET7cJ6HIWemWTqFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, May 6, 2022 10:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <lkp@=
intel.com>
Subject: [PATCH] drm/amdgpu: make smu_v13_0_7_check_fw_status() static

It's not used outside of the this file.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index cf5800822174..9949ee3ae090 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -291,7 +291,7 @@ static int smu_v13_0_7_store_powerplay_table(struct smu=
_context *smu)
 	return 0;
 }
=20
-int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
+static int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
 	struct amdgpu_device *adev =3D smu->adev;
 	uint32_t mp1_fw_flags;
=20
--=20
2.35.1

