Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC1FC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 06:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A0F10E052;
	Mon, 13 Nov 2023 06:54:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084FF10E052
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 06:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmCxpJMIJ1uC43R3ZaAdMikRagRE/gc3+w+u+CPD8cQIVFAXG8G/y9jW3L6GPLlOjPpi95C5fV0XVR/nLZfgbV2EwnoGBpSuk4O9Ju3aoFPS0A6WKDEtKmBkOa4maT/wFkkU5qBEjtngf116P4I/3HzWIVQI+7Hh6n3pinA/TS5WPPYc679xqFp3N3QJLKRY/dKpGDttqfm+NvRG81Uvi65qZT3U0zf5KIuOGjG+A6rIdJ7FXQq1cXvjlvKraWbCHdRWNVkcIHizQKWP7UUtn3gl9A8HyzwyiimAGBhek3odoVArPIIBJeQfefO1/vg9C/B8FNS4IeYfX1WzvI07FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SGKBzSS6uXOwe1BuFkr1zFlqQTU6gHW555MUsXufKg=;
 b=OGo1DZfeID7Dy27FjVFUS+MhQgbWrY4nW7fqL8vCmmfKYvB6Zh4ptzYsG/SI4vj1njI2GrCajHSmxRRopO+4NBHXp4YRBerCOsyiWnCr5s6xucMgbCc6ObjSvJnYlQHg2oyZZp3OnNyVFs+MWdLsHEONzwoRHdI4qEpvbq7H8gUca7MR8mbcvaut8vdMdnhb+lA6q92g03GYVigXgYV6bYef54hlU6KXjbb448dIrg/MXocylsHQNp2GY+2yJJLPDIKbeaG0/LpL+A4WuD6rwnmErj+qcRgmkwOYiUYLJwofYbwrXtwJPaDVG69oW56z+xJabz5sr+t+A6HjAgPQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SGKBzSS6uXOwe1BuFkr1zFlqQTU6gHW555MUsXufKg=;
 b=NSGUH/kr3R/DFLU7IgaUTZayZEtP+pmx3/xN9yLF4zTFg6kjJsR3yA71hXI2oRr7F+qJNch0soLEOFszTG4qRIZ+6rWchNBKuTjn5R6Ha2nLfadIcXifPq65/6Ei9u121W5oN5mFBtWIuOEozWxl7PQAN+5/O8Jjae6sB/YVPAk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 06:54:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 06:54:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix err_data null pointer issue in
 amdgpu_ras.c
Thread-Topic: [PATCH] drm/amdgpu: fix err_data null pointer issue in
 amdgpu_ras.c
Thread-Index: AQHaFf3vKLxFoCuZr0+vPqDiGQuKLLB30E7A
Date: Mon, 13 Nov 2023 06:54:01 +0000
Message-ID: <BN9PR12MB525733DA62961747517C0AD1FCB3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231113065129.649893-1-kevinyang.wang@amd.com>
In-Reply-To: <20231113065129.649893-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1660edaf-460e-4e8c-9a20-f882592c6608;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-13T06:53:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4912:EE_
x-ms-office365-filtering-correlation-id: bf2e3be8-3191-4554-9ae3-08dbe4155133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGEOq6L3qL92PSoXK1KemKbOH/Dw4efihp6XHrFv3aBsIQ4VboQZ5H6zCYxHXv7OtwjgrdB3Ofb6uAxU8xC+4kdsJnaiFQD+1ca0dOl9cAqbZLdbPTg+Ee1gO4ZJNq8tYbkgJhg9ce2jL6zMR0RKmdszDwM5YuVQdzUjWVuWuA7rzh/zT6565j/0X15l2WVW9YyTZR3+xfw3JfswBjH2ppOWVkLmxxX9a81D69nLUNbbttQVQ5Mbrg91EvMsdzyQEdf5yXN4O098Osc5MPJBNza7QMF3HNZm3v4q68BP3vXgIYU6aj/dPcqo4o2+mvMoIlPmFHEXzrsn0ZSeOBGHIyjH+nptBeq8CXfu3JwAsQEf1CZIIULXjhYtPv1AFDZnUD0f36LgctvvVFmIGigzREVffYBZZNNq5CSYOQBQG3rhPh+nJKZno0baYEnFEz9t5pm70QoSI+NfA7KOktsOvSYeQRSG0nB0LByD1yLeHuu5hdQZB57aJiagf0VykniJtFNdCqoTgYwdFGXsdLfI2rFlkbEJ4cAyM2NefWS0FebevfT5IRgfPTCmdRfjiUz6trWG5CwpfE9xDSXVSZCjbZNJQFVGYYqjLuFN4AF0eoI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(6506007)(7696005)(53546011)(71200400001)(9686003)(83380400001)(5660300002)(4326008)(8936002)(8676002)(52536014)(41300700001)(2906002)(478600001)(316002)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(122000001)(86362001)(33656002)(38100700002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KzrTjLqYFQHE98t+kNZHgjIpbxukIem/+BAjak2fS5QI8L/uMB2SJ/j7BB8c?=
 =?us-ascii?Q?Ig7Y2Vg1R+VWMlpo5xKiG8JG//tjpZyp084vjWjufvvtN7atMZyyJXy+XdDd?=
 =?us-ascii?Q?4P4HgVMwYrINegm+cCUgyOdZ7Mv/upQemyfF4A/EdEcYdP/yHsTwXTytqNFG?=
 =?us-ascii?Q?z/mWxs2EF/Akhmjb7jMG76VvI6sGdmKmbkmta4XTTn4jZHcpRbasRSKNK42g?=
 =?us-ascii?Q?OtcwFKpyoZtbDeAEiYBzqp91YG4jMAO4jGFtwYiLvMCikM9BZt+QEFNmw3KO?=
 =?us-ascii?Q?+oWlCfOc6P6HKVnjMlds+bVKusI2FcX1uCUnntbI0BoFDJWyTvk54YQWEAdV?=
 =?us-ascii?Q?YJ+rGfnOSyr6/f1FigExors94HmPI2Rarekxvnl1wi/YVyDqO++eduWIz129?=
 =?us-ascii?Q?IXM6Dc7nKuDdhqMbBaujPp5PGff+Qb6vwW49IgBscqBpasU8ZcBN58Xe4N0i?=
 =?us-ascii?Q?rgySU8iuZco3fekbIqKE9QwN9LIV3ZM0L4VEGk8YXnKBWKEDNmfvzuTwUaVw?=
 =?us-ascii?Q?qqZv3LtHfoYmM1mKBdX/8OHuIp6L7988oWqHWxs1uIxJ+3tub91+0T1UFr5V?=
 =?us-ascii?Q?ftAFgorSvzJEJqGra8plq5NjdDhhUFYMnIgpHpsthk1fDaWwEDy/kjPhXBGD?=
 =?us-ascii?Q?m3PhyLLZY2YlQufIqmBPtNQ4C5ZLEFVgdoil4itb4vJdaRvBLKbGdJnAEpyv?=
 =?us-ascii?Q?LJXVWAYOYPNA5VEBOikFhzCfIzS+iHuiH4oHUkbNzqReysG3nNDgVLJ7MUrI?=
 =?us-ascii?Q?YGHlcyGFJC6Xs16GPvrJ94j7ogCZkngGP/DFkniiNmqkM0df0gC2Lwhk46bj?=
 =?us-ascii?Q?Fq0X5ctLlbOXs2KNc/Ie65M5i9outZB8aFPdicZQTfCefV3guZ8+9oUR/I3m?=
 =?us-ascii?Q?8UbNJrv7Z84BOofovW0bFaqr4sW+oGFD59XpwHrBiDisnNO0pR7yFgbysOIe?=
 =?us-ascii?Q?nwIZdSVcQpE1kaJKRPChD7wap7w9uXiyLQhxcn+SGOuXCF6STnWE+HOx0Y4p?=
 =?us-ascii?Q?3tZc6zK3LmIr4awy6cXWw7lXQbMEJBbWSAX9RcKNtYG9+5zSfP0HLZFkNX+P?=
 =?us-ascii?Q?M+bvAQha+IKyHjw8imkmuI+R4YrJ88ufcbs2GV4ftJ0SSvkXWkhx0LoQG9r9?=
 =?us-ascii?Q?5f4UWCRWG4vZDH0Um20eL81b47dNFZiG24QFR1jZpzf9W3eBBuie0wiaUO4t?=
 =?us-ascii?Q?VpA3hVImbSdjzFYwXjuQhoWVOtofUryqwf2gv/aIPR+kmlTlqE7enUDcjnMb?=
 =?us-ascii?Q?lTcMWF+AmFTwoc8yoUetwwJBIVwjeNHD+Qe7rDo23xvHzcmch4+VEM+J21Qh?=
 =?us-ascii?Q?XbMk38WlbG6EwGSc6122i3g6zw8xjypB+YJ1vJc2y7uaUf8bbAgi3icoLwfK?=
 =?us-ascii?Q?3Tqq3CPRxuEX84UrVaj9eI0VIMKf+0TWPvwwQXw2RkXspG9/VhJYk1RvF5NZ?=
 =?us-ascii?Q?r1W2XnzV5SfHSLcZ5nJm1V2raV1hq+FM5Mx+2OonZhHNuV2bPcntmcWCBvDR?=
 =?us-ascii?Q?KkmvpiCrx0UbOT+nwaoFfmW/x672g9MW4RITne0C1XtsZBKldlWMWxuosSwm?=
 =?us-ascii?Q?Vmp+RoBFWh9SKj3eBc8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2e3be8-3191-4554-9ae3-08dbe4155133
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 06:54:01.0724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPs8FyYx5lGfehrkE8S4V8khvejjzCeK4R63m/JG6Dlq6Nfp2zmET7HKb8IzsvyOW7jsTHP1+pvwfV/Oi7UdMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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
Cc: "Hawking.zhang@amc.com" <Hawking.zhang@amc.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Monday, November 13, 2023 14:51
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.zhang@amc.com; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kev=
in) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: fix err_data null pointer issue in amdgpu_ras.=
c

fix err_data null pointer issue about err_data in amdgpu_ras.c

Fixes: b752e18f33f1 ("drm/amdgpu: Support multiple error query modes")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 1372380d2423..13ccc4cc36c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1188,7 +1188,7 @@ static int amdgpu_ras_query_error_status_helper(struc=
t amdgpu_device *adev,
                        }

                        if (block_obj->hw_ops->query_ras_error_count)
-                               block_obj->hw_ops->query_ras_error_count(ad=
ev, &err_data);
+                               block_obj->hw_ops->query_ras_error_count(ad=
ev, err_data);

                        if ((info->head.block =3D=3D AMDGPU_RAS_BLOCK__SDMA=
) ||
                            (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX)=
 ||
--
2.34.1

