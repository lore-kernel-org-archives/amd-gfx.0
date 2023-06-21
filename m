Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9672EEB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 09:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26EAE10E41F;
	Wed, 21 Jun 2023 09:16:25 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661DE10E41F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 09:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOV4ZAjIElS0aKZJDZ6BWnDO3Ud5dfYWLl9ILumx0ouMOlNYvC3iBGQjyNk8C7pdhh9fhoDV1TgEAD6h/U7EdCnoPvzjjWpLWqz6qfzfC4mkN0wHzEpzi+L3rLUjVH3z/rjw4pA4zkVeG+yg9SkIQnPzm5mR42HiR+xTsaN4RuGDF4XqqQLUTOL7OcyJYrtuju8ZECQrUj8/ctuMtLWV1uGC+DolcdELjcNdBK+dv5jRLQD2VQ/OPN52zorYz7JByysu1LcIGuX+5pmrDYQm9wJDSCoHOjnhoTo58DCR7N/I9vdzAvzmxQnt+DgihfSj54T49F870yqUm1845O9+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClJDwOCIfqGvOxI22afc0Jp4LUKwd0mTfMvkF/6EHHs=;
 b=LUlYjrzrfMVkto774NQA6E0M69jDqpwUtVOWvWuvSoQyCicHzL601cIrKrSSHK5QXorGbh6YLJtXL3RrfTHhhmAWy9DYnTzpy6WledDRDPJNLwuVwsjPpDPhdV+RN1+IhjTmYoMUIfU2u+CCrB33w+MKaduV0xwuLJvrag12o4vNfn9jnXFjZZrmF0FbfVpzOi8ochTOE+qeLCqUOy7PU0b3/9DzDKU3ubzxLFDItbTPV7kgwfdVjBZH3nDfvS1hrzBBx06EdGdKns41p9UbpX/hRl3w7X2AuonSWcpg+mdjT8trgpa2oV8auau0zIFnFiu/nGiLdqfz7ac0w8xv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClJDwOCIfqGvOxI22afc0Jp4LUKwd0mTfMvkF/6EHHs=;
 b=1o6Jo9swa7oB8SV4UZoDHN+VBM8UaZC9Zdd9XfdnzyzPFjQ5U9kyA7C+BbmPCjOVKIgPdxpoZGQMFhdv17sPTizNq4+/OEQAupADYGhm2MCVS8JpBnUKyVMNiVcQ1X/xnGc4h3rOmSDqBw7n91BQaGdu1acVFoXqR7UufIhzS00=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 09:16:20 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::1c82:424a:2817:86e1]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::1c82:424a:2817:86e1%6]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 09:16:19 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn: Need to unpause dpg before stop dpg
Thread-Topic: [PATCH] drm/amdgpu/vcn: Need to unpause dpg before stop dpg
Thread-Index: AQHZo9/lGJIeGWpEW0yf3v+ewkLkI6+U+kEw
Date: Wed, 21 Jun 2023 09:16:19 +0000
Message-ID: <PH0PR12MB5417B4076ED19DF260F04EAC8F5DA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20230621012954.2273614-1-Emily.Deng@amd.com>
In-Reply-To: <20230621012954.2273614-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=627f4bfc-6ebe-4da6-8da1-6db95717c7aa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-21T09:16:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SA1PR12MB7320:EE_
x-ms-office365-filtering-correlation-id: de2237eb-d8f3-4151-d7ea-08db72382cdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgoijSOIFrkemGTG9dsLYjx8sMi2Ljc9hOm42i70Rd8KG5dTrf1p4yQ+jUPZd0qAsYdZnFEEG6Fmw4iXc8sVIfJbJNyXiPHYZ9tZEqB44lRkC6s6tRuRrtwnOSMt3OiTBrvS7tm407EVY9MIsB52UeGQB69KHSC31yv/+TcP+ULrD6DA+RJ/lp4nQ5bhaSr0qyj3tNgi0FQJQ/ByXGq33cjwzKEiSoZZDCewS54mi0MATK6yLmpLCREmk+yFzPeHVoF8HX2YfOpkSGcHK4Ha4rssT7yWJBH3llb6w6F/jnArh1khkje1sgWwDtom5fGe9K5h/I94b+UPWoQEXrcCsD4ReXlTDyKpnhgDw+P2jXfOvWbQKJW7Kxvf7Tz6djbhYw3kS0aq8vUaCsOiB0efPDzqMUY/4O+I3rhickGynDJrXQN7i3TSW9WEfqFfV4zKSA9s+/QSVRRLzUktIc0Xrzl4rdiqqpc+DxlRl79UepS1y7c9QTA34ogNHIykPJ8lnsvA/Vf5kffEV84vpZWp2Ej7JpK+WYCWVe1ryxyhV2qTSJo/9yO3b2BrpEr5K7tPkjG5aJC1zWLrFirR7jsp3+MU27XXYEQqWyUfqwdCrHOax+dzjltCjEhH252C9Ery
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(41300700001)(2906002)(52536014)(5660300002)(38070700005)(33656002)(55016003)(8676002)(86362001)(71200400001)(478600001)(83380400001)(8936002)(7696005)(186003)(26005)(110136005)(9686003)(316002)(6506007)(38100700002)(66946007)(122000001)(66556008)(76116006)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AConCPu3wwSLVA23jaHGKU6GAjS7ZMfVvl4wCri55kaPujvNWMOFlrhh8v5v?=
 =?us-ascii?Q?w04/sCKw/t5sWRsp53SzUEYxGnsnJeWo5A5HG9yKz7T/1a+NX/GLPQFL4njh?=
 =?us-ascii?Q?jYaMhuUaDwPbggJ9X/bTX3xS9FnT/kOjbv2PMSzpsZFrNgp2Rc/9YBo/xk4y?=
 =?us-ascii?Q?4tqD2tjNS6bd0t38AHx52+rd9GWsSXcaJgRXScMgouO+Br6Y+xMozrQYgshj?=
 =?us-ascii?Q?6pVgXbp5p5WLuXny3LnpuZZdOttNtUb/RIvDSKlcDUjlX3wFrXsKetbA0sm3?=
 =?us-ascii?Q?FGSG0aoTJ2k0VVM30CyQR+NRw++A510VDy3AkiL1OT21shhDMAvBCSdJo5M7?=
 =?us-ascii?Q?a8aWCs075bGCTmDEqeeMQUNj+E2OIaikCZbwswNaxYzj0/TWKSJQIAsgFQLA?=
 =?us-ascii?Q?16Tewxa/SZWqQfWRQF1FRty0wwhcmGaUYDsJfqjm8bme9WD/ATc28AIvVPmO?=
 =?us-ascii?Q?THLUqTkGfpn3J2sWE8NCvZeDT93oafc0KVJVO7z4pCN2zBOhkvDh5dc4Hvik?=
 =?us-ascii?Q?TkswSOfXjlfASpLKlOWxVderhIY0jR5xhzt9WeCNGuwIoNFQk6n2N0AquJbG?=
 =?us-ascii?Q?Ix0Uf188B9+aeSPkOxBOhWPVTWizYO+SDdvxPdDa4dMtqz+MPdHDIKH5cbZG?=
 =?us-ascii?Q?Ifskn0j3LdrqlU7vtRvuIV8G9MLxiZZL3loVKT9sVfeKYtaYs29StjkhUQPM?=
 =?us-ascii?Q?xGHLRjHmxB7B/OfOehSSbIo25RuZOlqdG1cCjqGOaov7kwDfSA5+HtYbGvA5?=
 =?us-ascii?Q?tD9xt4XsmkqZD2aPBsdxIkMvywdpqWaY4xZZYbbYu6VF8TTCxc6dUvYFIxZw?=
 =?us-ascii?Q?xuZNwMO1FaC5f/yF/tOd+CCd8EGT8yj6x8N+mZC29qBwACTnS5nYfylNvm0Z?=
 =?us-ascii?Q?Fb55t0zN2D9yKZqetDKV4kRzh/JBR2MwWgyxrczUciZTbj9udIHOOgNd2x6j?=
 =?us-ascii?Q?lT5IVHz3qgyXc5nisQjyJzAnSTCY2QQM+YzKkFMTbILUZEFtfAQvzN5YrIee?=
 =?us-ascii?Q?xEWkRAeMtFJxnje/RQGW2YrG40C4tF/l/V14hrTc+uRFzxKZuQviSB+gbcHv?=
 =?us-ascii?Q?LBueBByHcNJWFirD0X2hTpfhifVV98ysQhhDlbV/iMYKweLpKMDEmXiCjV/g?=
 =?us-ascii?Q?77szIdmswP3nHU+zGExgvp7yqq/UARXTg5syZCiyQu19msb/lo/xAzynC/ZP?=
 =?us-ascii?Q?KLA2azVTQEeIkxIj6LTvR0D6w423qRQSvRzSNG/Un8ej5gIC+QQAcLtuulrX?=
 =?us-ascii?Q?GQ2up1u+XAVIXvkPko7tQHUHzkVFyZrYElX88vrB+ITGUQ/r3GIyTuiPf4m5?=
 =?us-ascii?Q?IoHtBqfTA9l7F/EMwDoUwxtoDlnRa4f/8AJTP7b4T5hyc1SSWVsFqWu198kX?=
 =?us-ascii?Q?PYMQpdD5E6KYBP3OUVGdLx8a1fKUJ+ksYo0p8MJQqTl6WSqIqk/ZITkhWCxg?=
 =?us-ascii?Q?QZfoVZ7DVwqfmut+c6FBHYUeZJJOEBSrB7c5NsZuUB4BDhAsBPYv+3S3Kn1G?=
 =?us-ascii?Q?Zx4XjLiBbUss4oCq2mbWEtxTe7MfXaZxvezqkfn505d05V7caOwUUpRhhYfW?=
 =?us-ascii?Q?/jsVpX8pjLW7dUEKMCw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2237eb-d8f3-4151-d7ea-08db72382cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 09:16:19.9175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oG2CIYH5iKIBuMHqht5CFQBRrry+uZB0Hp3AziyHa07vUQjA3XtpOrwdqpBxoJs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

Ping.....

Best wishes
Emily Deng



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Wednesday, June 21, 2023 9:30 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu/vcn: Need to unpause dpg before stop dpg
>
>Need to unpause dpg first, or it will hit follow error during stop dpg:
>"[drm] Register(1) [regUVD_POWER_STATUS] failed to reach value
>0x00000001 !=3D 0x00000000n"
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>index b48bb5212488..259795098173 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>@@ -1424,8 +1424,10 @@ static int vcn_v4_0_start_sriov(struct
>amdgpu_device *adev)
>  */
> static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int
>inst_idx)  {
>+      struct dpg_pause_state state =3D {.fw_based =3D
>VCN_DPG_STATE__UNPAUSE};
>       uint32_t tmp;
>
>+      vcn_v4_0_pause_dpg_mode(adev, inst_idx, &state);
>       /* Wait for power status to be 1 */
>       SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
>               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>--
>2.36.1

