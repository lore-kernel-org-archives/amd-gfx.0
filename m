Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CCCC05027
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 08:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCB910EA8B;
	Fri, 20 Jan 2023 08:12:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98B610EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 08:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3Z8hW1/j+xjOTv/Esz72fnBwMr2IMhM28ixWzd+tKD5r4Fky3nH6Tgb+3jY/B80UbMVC3+LheKAnSgu/xJbxylBzE9XVZrGStu5moizuoug2jXPuCexs1V5u4sfY3qJrlZmxOJZfE72Ij2fYcmt3sVK9wscFiAMQtXg+6ngGzmBRxqsmXIJueCnXfB0EFSZL2AsAq42D3EBdIdGMam9AOpwb25CG5pou7tCcAzuS1LmvGFAfVeNSWM3a89fZBj9YzJTRQFMbAjjDHPuy+hh7qNZn7SIyM1Gno/vhh3dwzcUWMgaCi4B/tuRDn+E3iCHvXGYk36tFObC0yYDc1nnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj7liI3sCCkPhu1sXT1R3UcmbDVzX7NcmdbcQq9BS7g=;
 b=XY0+koM/+2YZXBq2k0J2otTTNP5fQqFdamkVgZ8iSwQcxOZzLkWAZdwN8asdI/P7daOQSxNTxArQE3Bk0iEdJ8+M+YNEJMekFerPBZLWyz1+bKOOd6PVJnhRSZyaWPpf3ki98/To4poizAlVG99S61UzltL18q7iL8xZzZpd7C66kBGhyn2Ekwv5BVglgGYMwhX8RRI5/+Za/ZVj2yOBjr0k6wdmwznnksBminulUT6pAkNeN2zZc9SZHfQtIE3mU9IkaaCHvbKJu+yH3mwGHriYtRUL+JRzvdQrDb29uJCiyJiyJ07HQtyRHpm111giGA+d7al7AyR8mOHhKtuWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj7liI3sCCkPhu1sXT1R3UcmbDVzX7NcmdbcQq9BS7g=;
 b=W05qyojuChzUPqUTqHpLJ2Zlo1kOdDixkmVTeufvc/yFdX6eJ0YK3CyMil0Phhep8xYfYHXXWHHR1N0/Zt56Ma+ZCavdR4LAm9vWefZO1yPPRZHc4KbtIAJMV2fmLus0iX2LSPJOP6GRRMZ4+xZWPggBcqJzL1vHaqxOp/TZtCI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 08:12:31 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f%9]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 08:12:31 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: declare firmware for new MES 11.0.4
Thread-Topic: [PATCH 2/2] drm/amdgpu: declare firmware for new MES 11.0.4
Thread-Index: AQHZLKaM7UlaoMAsYkaaDHLLwYh/d66m9Fug
Date: Fri, 20 Jan 2023 08:12:31 +0000
Message-ID: <CY5PR12MB6369C5D4252C1170CA3F59D8C1C59@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230120080909.948932-1-li.ma@amd.com>
 <20230120080909.948932-2-li.ma@amd.com>
In-Reply-To: <20230120080909.948932-2-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-20T08:11:57Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2d9e3b33-ac2f-4c5b-8879-de5103d9d657;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-20T08:12:24Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 877ad72d-d337-4e7f-8725-4c39befb4a0d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA1PR12MB7199:EE_
x-ms-office365-filtering-correlation-id: a40965af-1e84-415c-4dfb-08dafabe140b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BlAhmVU9qkoneS0w8khXteE3p7GCLDCswfODCdEobfvOTqS2lc08Ic+P0pIS8720itkWSsG9La6HBvIyKRwYl8DUH1To98zsBDqTPyzwmq8tr9DempIfuS8rwZ1yRRUo92+vxcCV54bHMs6xBNBbplUpJZGOyQUbqwrYilrxWY827fU0EKPTUMzkMaoFLoiGaHTsYfRd2Uicp4sYhJ8b0GLjlyiMuCmH9Rc56qkY1cEAvgaNbcJVQ75B/gDYjl7Ik09b6RLyoDz6QkJQN/uiMUgNwA5kuUZFMNQP71DKbdSAbrdOfGKfXmHGb+tPZETITUOOPOkx7iDnuA14xtCs2BZg/DI+riXJnflX95jkvLsD4A2YpJswEyOdsr+t2fXK3KUR5ndTsZzE2cnMgpCAF+vugzb7a7d3/BZhq3IQjc0YecXRrS8B8QbMd/Vp/ZywncR2rfej4cFYAeLMiUnR5AcujOPXQm43B8GB7DrqVlnBcSACPXqhkj3m9xcy+X0WmikfhyPqYLBo5gnSMGibFGS/vXtuJDlThfwm8Vapc59pAc2500lVgSZLZHQGzO3SUYeymL52RGwVNf7jPJ5WZCqP8WjXqLRhFEKJ+9kEMTctUPT2A2JFUYoC5P+i6RqEAYq4bATHHN5u/515LF5sXAuMU2l3kPgLEGb4jpN47uyXvIIINRVOZMvOwH9YH/LWejx7N+wCOS7JC2cQEXECjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(2906002)(186003)(9686003)(26005)(54906003)(110136005)(6506007)(53546011)(316002)(478600001)(7696005)(71200400001)(122000001)(38100700002)(86362001)(38070700005)(55016003)(33656002)(83380400001)(41300700001)(4326008)(5660300002)(8936002)(52536014)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HxkFpukabGsd/wnJ3YmfCXzb6FFeXpKLC+z7PX3nH4bifMQzLBj/Idkk8za0?=
 =?us-ascii?Q?g+rkJWZlsCxArY/AoJPscggrS7yiLziUQHv9Uvwglvb+B6cTO16GWdZKSow8?=
 =?us-ascii?Q?KTmrou6ztuk/Y+YjXkBq7gipXBhnctAW2KdRX9oomEPnxuQs6jPiMSXBOhPu?=
 =?us-ascii?Q?Ct4LAfdmoJtN/MG8nkTlJqNANI4w5REPIzFJPXrFVhJyq/PwaKLFbYnNTQfa?=
 =?us-ascii?Q?uQuIMbAl3ca5eUVqIIZ4JLU5W1HhG8DVA0KJ+Nwa81uVCn8L/F2vLU2YcwnB?=
 =?us-ascii?Q?IkSBbKdl6Y5VKSxCPMlujF+oNspR2Zh/FOvOxBE76mMUwG5nqurnAwExb2qw?=
 =?us-ascii?Q?HJn4IJMjrDuE9FPP6Raz//Ec1MWW2tlIYyOHfgoTBDTmtJiKYhoN01cXnLQm?=
 =?us-ascii?Q?D+Mh+Oi0clqJgguDb4Mccfl/BSvq6moTonClT41QWAf9eT1fZ+3F+vryRrlO?=
 =?us-ascii?Q?db51XgtWGRS2M+xHY/1vVOzSaYepdYzErAwFzI1/sYCHuRbP/ynvIYXXy3oY?=
 =?us-ascii?Q?/ZlfFMGKjYl5UVJxrm/0wJUr/P72PlyzGRNh4FVmP8hEcxP5pO/lEZOIm46T?=
 =?us-ascii?Q?g5L4G9qgFLemx96p7gPTNI/Rb3J7PdnvQj21aMeqtxRCEdZvsJWRbdTxi0fr?=
 =?us-ascii?Q?s4P/jCgB8Y33R9kPJXgLeKfCkYnAYjckLpYg/3obXL6SfvbjO/xlRUa+qdqX?=
 =?us-ascii?Q?oX7nX1cYAol9tWw4soN/puSfhWkFpQZ2iXpHZelg3fDtfyx0BL7w6ovVFP02?=
 =?us-ascii?Q?393/d72xw6oA4GzuSA/3L5CK/YzFRZUvH1rOr8POKCOFyC55E9RJ/jB55Ek2?=
 =?us-ascii?Q?i+Fg5cWUBs9WcJi1RNJUHKPE0WmFlvN5pFIjVwqhkP+cp99P3KhJJ56ygCiT?=
 =?us-ascii?Q?cHeK9VCpbtVu/27Kx81aqoPXG8QjW0fwR2tLxP4wiXog3BgBzOw1wb2jvhff?=
 =?us-ascii?Q?uY1Xi0G2WnXWaGvWdSXE6D8uo5zxbwyDIye2ElXUvn8+Bc8Ss5bx4cvBBB9F?=
 =?us-ascii?Q?5eXiisjCKwSzIZSmqnovyxKE2FHo+awidAK8H6RmuGHbxP8ogaaVwq6YxxJY?=
 =?us-ascii?Q?tbF7RmHFBoAG4+6QLUu7eGEP6xz2susFejYBgEFryQwAYG1BLqTThIXT0SLM?=
 =?us-ascii?Q?8FpyIGy9wfoWTyp9xnIzT59fc7aA8EICO+F71HPUTnAF7r7ilxs3/dXBVuR9?=
 =?us-ascii?Q?pKqhYxNfBwMB9rDkClWb+n5rxVID7V3JL/iDvr5BWicfqTEwYdvQbMvElWFq?=
 =?us-ascii?Q?XTx4KVAUzIxvw6VpDHP6xfG9Cohp9HS8ngEFUZOvNeOO+NegXXi/pUYSaPAC?=
 =?us-ascii?Q?l9Sh8rQnrp69alp8Bls4ArBp8UHKgip4LhulxbwMFYxEi31SgOoAb8gXexBC?=
 =?us-ascii?Q?K1smnjpPjh8mPZKgvrAkECrNr/U0oUpWDQZPmmG/xUlNvn2MpLBjCUj1XRIq?=
 =?us-ascii?Q?5/9TXbI1dHJ9gaPt1Bxk4vf1lVOVa2CguswVzrlHORa1aj1K2DNA8zvB9Aev?=
 =?us-ascii?Q?LB7oSWvGqND0yU1Cmw9PqVDhnpLRt04mHFS83nr+QuYzV5O8MEMIRweiZx8a?=
 =?us-ascii?Q?bvJl616VqK+hnGH4eWs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40965af-1e84-415c-4dfb-08dafabe140b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 08:12:31.3049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpraJ6gq71kTVndezFdTPMAAbcqNMsreTEs0IhYeckb1Jc82wqEc32+yji9bMWDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>


-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>=20
Sent: Friday, January 20, 2023 4:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Du=
, Xiaojian <Xiaojian.Du@amd.com>; Deucher, Alexander <Alexander.Deucher@amd=
.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: declare firmware for new MES 11.0.4

To support new mes ip block

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 00e64838bb8b..62cdd2113135 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -40,6 +40,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
=20
 static int mes_v11_0_hw_fini(void *handle);  static int mes_v11_0_kiq_hw_i=
nit(struct amdgpu_device *adev);
--
2.25.1
