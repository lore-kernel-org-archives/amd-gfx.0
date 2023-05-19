Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A92C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 06:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D554B10E5CA;
	Fri, 19 May 2023 06:29:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF35710E5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 06:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0LEBxWu/Zdpc11lwTukTlvXUzEvZAPTiODifZFZWvcpB1E+E3BGQzMpHdk1qtiD712KBg7Eh6LsCw2XeTIxgyYrMNe1iGgfepgbFNjRiG7pbRE6MjuciZxncmX7BXaQSQ3Grnwp/4qIwNYu1DQdN/Ss0y3jaZKf1nd33Am3DdYvfnfA+JB1Hk12gqU4X9Pw3iuWy2HqvXgfK8ym1PROU3r4rg4sd8xNljDiHXnKHf6/0CaD2I01ze/ICBIIQ3Dfkb5JfhHt6honsPYWdKib1+ttzCwqfCs5QBmzIn2NV1NIwHyZqHgbP7pxRYytAwcz3eOnwEo957JlrZvg1G6pzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxS8QSoOUse7M7sfoRQyUz0s9hiffxW7Rn8yx09CvKM=;
 b=ml46Ke2+gPLF1RDLyTPOg3earyx2Q+VazABgrw2Uxg9ctuyiYIscXEwzfppFsKk44lxSOM1NlZjmTBNbFPUXJFpFuHl1XEo4twb+oWH82sueNgnGcBiCldjmv77jX4spECeNOjLRq3BkvYVI2P3Sw9/9X+aKXl7dk9s3d4KdvCdO8oz/AnprCkVc66H3RS9fu8v0egZ3l22Nb/jf5MDYhrTbUBR9wbo/NM7/mQrMH3LY/BNqk3BH41EDvftXwMjsKILpSBjDWDvzmxsvJ0t/KQOJAi1e4hgpqPA6JGWO5iRHvAccXPKWGVQPcptOx7KeV7VcItBG8pjSFahwoTWfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxS8QSoOUse7M7sfoRQyUz0s9hiffxW7Rn8yx09CvKM=;
 b=FTb1lUifMk+RLKujrbghLHP9vhdMuma8dA1dG9PPl1bDbna1fTaDg4zPKkgmD3tQMz5AK2cSCYfNNdQeDzFXl7tpLjA+UbP2FWxsv3FZq/CmsmklDglfYDeMtFqyqflcqG811OC1JvPMEnYDu38OH7dItiPGCfmOkQ6Bv1eDS6M=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 06:29:52 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3d86:2abb:7487:b5ab]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3d86:2abb:7487:b5ab%6]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 06:29:52 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove unused definition
Thread-Topic: [PATCH] drm/amdgpu: remove unused definition
Thread-Index: AQHZihZg1xJ3Bzk+IEmjtycyNFSpEq9hIkHw
Date: Fri, 19 May 2023 06:29:51 +0000
Message-ID: <MN2PR12MB412810D35619C5684EFF1892907C9@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230519055416.13910-1-tao.zhou1@amd.com>
In-Reply-To: <20230519055416.13910-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a4cf28e3-912c-46ba-bc2b-e047ab5c7290;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T06:29:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|BL0PR12MB4898:EE_
x-ms-office365-filtering-correlation-id: 2a087107-91dc-40b8-5fa5-08db583273e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XqMe+dAtwwspFDD/2AApjZyZMuqzQnkV7oqavoAEVW4oNUlqvH+yDylkGzJjiO+YqmKNQ2yv01BO6iiUxkWbum0Dw09moh0zdIlbplN+rUOzwemp+DMtq6ZXUNjGJHXWKqPZobN4oTNhjL1zcQFxPjRRdt0wHYhHmJoSmaw3HBLk/SR0doFeKzx3vUNzLCheDdilnASkq73goXU+yFOkRQIB7jD31oECT9jPICgfNWVVWXAk/N667wJvGAlG+NCZ4xueAVlk76l3ubZe8qk7RZ10t7fOTvidetj/oRNRKuGUEQpFO4eHT+QIQ5yVdXLYrQWaRla7+NFw6bNsRb4ONdTUtB8C5Nr7Sxpu9Iiay9DS4tKmqnOL/y6aAHW21fjFdKmcSsWb3bu5q5TTmwo0jO6beGXbIQERf6lR0WFwwmOTVNA2fOll0w7QNMXD3ak4yzfMGisWvXQAkxEiuQbMCECL8ikc5ejViM2Su2woG+h6Bgi+rBViG/9hacNGiOliGOaA1o6nBlaF6mxa8oIavEuFbYnGSkL/uqFfKQM2JaEyAZ1etkT+4WxDl3+oEXhY0XPFiMrOnnZ2qiwO7Epum5OcP5zTqSiATT5kMove13GEsWdf7q8RA4DrIEv+BgvP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(33656002)(86362001)(66476007)(8676002)(6636002)(4326008)(41300700001)(8936002)(66556008)(76116006)(122000001)(38070700005)(38100700002)(66446008)(64756008)(316002)(66946007)(2906002)(110136005)(478600001)(83380400001)(71200400001)(55016003)(7696005)(9686003)(26005)(5660300002)(52536014)(6506007)(53546011)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mJfav/SWT9SJE1k+nkzkfd9YI3miRgAynDEcY/YchlMNF3cVZy0YXrPLvnuB?=
 =?us-ascii?Q?Y1b8cGWXqFKCW6w57/h6qyEvnOsbACRrt//XEqxH6NzgBM0yH1HdSSLDzNu8?=
 =?us-ascii?Q?vGYg39gYbMeDG7UOt9u9XuendSe0BoYOVqk59QfUCo91r2PqLBvxGg8KXVdi?=
 =?us-ascii?Q?VWh3bnu8zPG9c4quVHme2VbWKTZ61tRQLlbCZq78B15N4iNPhfa0vgw4oI3W?=
 =?us-ascii?Q?TiwdBSr+riSG/okM94zk1LgVOi1i5aSscoWFU0iRr1qY2NoL8BHbdkKz+bZ0?=
 =?us-ascii?Q?IAuz9OE+gDpLn0b4j4FGnd5s484/TjKMt5FGdSD53M7Ci/IUVn2s+DcCXDUN?=
 =?us-ascii?Q?5nh/EmlyQ3u+ggTgv/isAbvxk72KHr+tX5hBCj1kN79/qL0xNrbuTZCaz3Bw?=
 =?us-ascii?Q?6V9dbn2ugDcjTz0yE/B8mjAsUoDLyvZjjGw2vwzC5K+lX3iUdY4HdVf4Mwaa?=
 =?us-ascii?Q?eY60oNi+zGq2kB0VP6YhpE2fIz/nCyu2eSOjfw5xcCrJIY+8AXvrOREtxuWS?=
 =?us-ascii?Q?kUv+FjICELVKwl7nUrArUtgn/dxavRZejIUe16iecIXvEvDvZ895iuUvYf61?=
 =?us-ascii?Q?MF28dfifKg/5pURSiPEnlNBL7bJba8xrpfIbOdNaxi3op/P5WPxJdomfK6hl?=
 =?us-ascii?Q?KJYgniawZoBLuUzE9N8JluGeO+I1+nsv7GM6VjtUvbmeMpd9sK5cq7ZhtrA4?=
 =?us-ascii?Q?avFzGIduo9Lp/X86rlXg2F8eKVxeB9RCRSyNzSJRFLVKNOjz5P9lpeoMalfA?=
 =?us-ascii?Q?tzwfDS1ubbKgJugIGklRTuHTnLVmtw2yngJLsiSrxBf1YjUJLEJx4NLEJBdB?=
 =?us-ascii?Q?HH9yZcdJE2TYu4HidJb5cBzdnqNlyvWEpmpDBBhngQymfIUfqDXmOqsVEZeH?=
 =?us-ascii?Q?NCK8i1sG7prc6zcEFc9Rq+F8WEM6O+jfhiFMLIZZIYPj8vkV8uRX1Q6QLs3m?=
 =?us-ascii?Q?MC9ORKwxOM1NjA3xpy1sb0QuJjPbgp5IfuJowRJSLlX8iluN+grkdUNYw/4R?=
 =?us-ascii?Q?G8Ao/fP9TFwlIpa3k4y7rPtS4M3aTy3O59z1bcc4B27ZZF0ET/VyltA1gz7b?=
 =?us-ascii?Q?I9gwQwts+XvJu/lL4ZwNsXSh3b5JZIj+2U/Pxjpp6Vp1OraHlY3B5NeUe/Hv?=
 =?us-ascii?Q?8v4BhD0FkXfiFbTqD910A7Pl65t3nMkP6zHZuaTQEttbOs/tlixhRwmCoclE?=
 =?us-ascii?Q?HyBa7aXVsj2xmOmZCZCbi+4ebXUNvd+NfRxcrQnQOnNWpk8817FpLME9goOm?=
 =?us-ascii?Q?YSl9q/ixDrAeb1PMW/CRT0r+rc5P87Wl5SLLknZv38+QyH6sQ5t7EiIvPWGG?=
 =?us-ascii?Q?1FIbLfC3uWXzxyMIGBpr9uoHXz2+32zkwEEXO2BwLNKzep1el2NmrzCs8Ipt?=
 =?us-ascii?Q?7bTdQBMjjbIG0cgdi+dgE2LTSku1rUWOvMq0j4jP/3OA76O3VPIelrFuRezu?=
 =?us-ascii?Q?5FThj3mmc6tHROUHHu39fGqmdbJQBeAuBYK2l5O+/U/ba3uB00rFb1pM8IEy?=
 =?us-ascii?Q?jx8QeXvatSwi5oMg+SRNs7sgiaxPviLYxezEdSY+QzqzDWu9Rs8wHCp7St/h?=
 =?us-ascii?Q?JdWyK7jUEC6Lwgley8c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a087107-91dc-40b8-5fa5-08db583273e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:29:51.8709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcVn1o9ijZ9GjnDMzuGLIwKpGgNi/aGt6w6Xia9EQUtQg3g0H7SCIkXxEflYKz4XGZOILVZPuAhWjntbTM1P9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, May 19, 2023 11:24 AM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Zhou1, Tao <Tao.Z=
hou1@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: remove unused definition

mmhub_v1_8_mmea_cgtt_clk_cntl_reg is defined but not used.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index 3648994724c2..00e7e5db7c28 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -757,14 +757,6 @@ static void mmhub_v1_8_query_ras_error_status(struct a=
mdgpu_device *adev)
                mmhub_v1_8_inst_query_ras_err_status(adev, i);  }

-static const uint32_t mmhub_v1_8_mmea_cgtt_clk_cntl_reg[] =3D {
-       regMMEA0_CGTT_CLK_CTRL,
-       regMMEA1_CGTT_CLK_CTRL,
-       regMMEA2_CGTT_CLK_CTRL,
-       regMMEA3_CGTT_CLK_CTRL,
-       regMMEA4_CGTT_CLK_CTRL,
-};
-
 static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *ade=
v,
                                                 uint32_t mmhub_inst)
 {
--
2.35.1

