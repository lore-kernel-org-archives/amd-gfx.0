Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA11C25B6B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 01:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74EE10E0B6;
	Fri, 27 Oct 2023 01:58:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6912910E0D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 01:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNcjpiTrYpyegWUGsPdJ1XeIixLgdhw186syPPXeKC/fGxxvDvPOkQ+pDc86zDNjo38D1Vcs9OscK/qDiPZrHDv9dGeVtB+kwc+lDJ5d+2ctLf0cVWBAeqEfbEnbN/9ywOV3/BRB9hzwa8dah+nAjk6WHHtPUP1SYSwfkWjXu0soKSfewpeczWAmW9kgWUrdEWdRdqAAgGbkatBZk1d+BC5pgyhPGorvXB9zVfvf/Jf3NHia9D11EZNqUIX9tKixj2Z43Pu6GRSEIvyusmwF8SUWqnRhs3t021xPZCK9jkLSKtF+io5i6V9v2TR1hCy7hJjXqp+FMmoNGE3cIKH/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udsxPvrAMxG4+4RwGDwg/d1x8Yd4q6QEQgB5fMOYnq8=;
 b=CzPDH2ahurIhCa6dfPW5ETjDXlZg3iKUgcCwnq/E7ZBujGJvk/nAVcrFX72WLnNdppp7/iI1s4CyhnJmBIsKMIBoH94kXPDEdADD+JqyNQ2mrRt9HFcGQCk0riHdy/xunYjbQyMdbUltbzB7WZPZYtwZtrqlM7Uk4vKd5i3MMAGSV6qb6DFQdZP1cgM041PlpxQhC+P3RyjijzibmJA59+LqSNf34IgOu3G9PYUqUfwnPNALReQ56b5urFT5iEFiHyfkpbFXNjJpP4rQ+SweaE8BcJKSMEAfnhNFx+ztJQ5dZBS4pB/qnjjtQZSBjYW5AUMy5o/+oteQinCUML/AeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udsxPvrAMxG4+4RwGDwg/d1x8Yd4q6QEQgB5fMOYnq8=;
 b=ZzrO5bwGR5DJEh0YWRGQvhG5TO7ib8lR0GJmrCH65IYUF15ZuO0hSxvtmtjyvydAq+yBBiyfUludjD2X+BUIVHg1gbKK+3L7y/Rhf6XYqBafQ0DK2RSvpF1pCdET0COKS+1x8iwFoIm59hxMtqS1Cf2styCMivG6cPDSCojBpaI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 01:58:44 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b%7]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 01:58:44 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Return 0 as default min power limit for
 legacy asics
Thread-Topic: [PATCH] drm/amd/pm: Return 0 as default min power limit for
 legacy asics
Thread-Index: AQHaCHjzbfbq3Xh5jkGG/gYSrZ8eKLBc4STw
Date: Fri, 27 Oct 2023 01:58:44 +0000
Message-ID: <DM4PR12MB516501E740A8631B72430B298EDCA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231027015655.1499111-1-Jun.Ma2@amd.com>
In-Reply-To: <20231027015655.1499111-1-Jun.Ma2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=06a150fe-78fc-4cdb-8abb-5bde32108ae2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-27T01:58:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CH3PR12MB9430:EE_
x-ms-office365-filtering-correlation-id: 72044d48-ac3b-49b6-9229-08dbd6904041
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1yXERm1/CIcreqU0pF8GaLfqvNQ61qogt9wozW1WXBcj/wzn0dt0xTCFZIH15bFta4u9vDwT/3rAfcMDWO6+VRiwLnCxOEd7OTwvw64bNejCEPDwj5/3YuX4P3dDEqq1HMtH52bDQnaSetbXIco0tPPD6RtWvyvr5g3T8jdYAh5DWapt8k6XVOVJMQGDagDF6ZT9zOIZXHdmlVFMIOyxwM9MeGLB1PysuauzleEcIqTwoGtq2gI6aFayzIa/mgBi94xiKpINQbPflxTgIynfxR+hf+GFPRidUYAIC/8zNel9PB6UUO3bCqgimmkknKu8MCh00YRT+/4UavjiLzuEvNDC2bvO0qJ/ue+tzVq+Xu2OHag/Cq4B363UWfqpurtOqyWzsAv+ftqQF/JZjslCdNQTMsRxwPaT8Cy0+Ru75Cq6GOs0Q64plr/jDyn1HYajs92BZ0+g64zOX90ybS0uvfw0j0MeMCGJtUhOSHcbr2+gsRW6VZLxTNAz1v8Pq1GqNP/bXAYzHnWpHYiEmjcYNdmA84kYcFAQuBiSOrOz4FVEpLwif6v7Fo5hKgLhnOsPRLmEjrcf5gaaYqZnosYy2Pj8NJRFQ09JmhSNaotwSzGHI0JtCioTpxb9+IeRXuC2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(4744005)(6506007)(55016003)(2906002)(41300700001)(38100700002)(122000001)(64756008)(66946007)(76116006)(66476007)(6636002)(110136005)(66446008)(66556008)(71200400001)(9686003)(316002)(7696005)(53546011)(83380400001)(86362001)(52536014)(5660300002)(478600001)(33656002)(8676002)(8936002)(38070700009)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jVyfMM4rXD7b/P2YJRu3ctIUJ2v/VtYWOiD7SRbegiLDCbz3Y5eQBppa/VnI?=
 =?us-ascii?Q?sE4bzsAH4wLfCesPlOUaz9ecRwwi9RXLzgAjYFItG9iYTH4ql/NrN1/drW+u?=
 =?us-ascii?Q?ymBgl3JoeccMC8ZBZmJuWyPZRdiCLvr8Nu1PYqYN8wu663Q5PLT9T4cksyBd?=
 =?us-ascii?Q?hCyC6jM8onGmbiygWpR1BQ7CwcinMrG2Upvkr0NXmSIqcuHA2pRg9cvB+zrN?=
 =?us-ascii?Q?scUETj4tysRC3URQYGUYAZG9xqNSVAw79ZK7bP+X57QIW3xaIzU57LsJsX/J?=
 =?us-ascii?Q?3fqrEGduY01YHnKIX/SxAAmNJT8kmNdY4lr3wCbyu4Q3q/8PXRezEIsE6G/j?=
 =?us-ascii?Q?tflLCCIbO2LgbTvgu6SSqFkOxapLEr8k7dFSIiWQzY/r4KvRP8Plat+UxbL8?=
 =?us-ascii?Q?zYRG4zOIPG4jrz8NjZlwUWfRj/nw3GwuSrOLgy9owY1nJmZSraw9taZsfQx7?=
 =?us-ascii?Q?Yc+jPa2TihhhQdwqCfxd6iGVbzhbDxBNjN/VFZ18HG8SF/Jvsq+0AJXar6Hr?=
 =?us-ascii?Q?13on5I3yXJZrfkkLNhArSbCmNHBm7lvjaa8avik5i5TNPUNVa6VeZ/AOCDlF?=
 =?us-ascii?Q?4k5IjcVBRbTKHbQg66fUeFZsPoIhdh8cTfZ7J8WSQfM5HyRMJIczVCfn+bQZ?=
 =?us-ascii?Q?kj7u9UoYKtZ9cOAZW9zP1OwNuRES8nvb9uJYzNYxoCbY4c4LMQPX+BErbGJz?=
 =?us-ascii?Q?TcawE4Ie1INs1tb2y8de10dD5dI7jwp0CQY9SMe5vtQ5FFZ0IPfPxAgm8AgP?=
 =?us-ascii?Q?h/TLorChBhLv8g3WLBc6yJfFf982gUjPjh7awIYi2jZZ1Xfq/LkC1+rUn5ty?=
 =?us-ascii?Q?1d5TQba1OqYKNlD/avguXgTE0XfU+2SIi7SvP7Wte429Ssm8ZuMnSCXY8BNp?=
 =?us-ascii?Q?2jJWQ7aIwFut3Wty/eT43whIe7ljHpBBhKfbkcIWS4VqMQw10rOhuXcpMf9p?=
 =?us-ascii?Q?hP7IbfLo026a/hq9V55v+jjqz4vymdBJecy72SDIhdbJUws4Zq4giJfUSJrV?=
 =?us-ascii?Q?L8D7bK2E/VYXMpp6yW1lovspFWpxXqvXfoyDZ0/o0HlDZqbK5Imj5Bv3rwIl?=
 =?us-ascii?Q?ZbY3IinvLqizMsYGEZNIDTn4+tkxD3GuxJ7dz+X4t1alYc161x+9zwkVxKe3?=
 =?us-ascii?Q?Z8VtTUAjKGNXi8V30Ee2exwwSAgqgguTwDt0d/DxR51rPlWny9NvSJmFNMQY?=
 =?us-ascii?Q?j4sOirkDP+3zcI8qYxJ0qzAmWpNuvcIQmXXysucRcNBN8hZJ/ezhWCDOadmU?=
 =?us-ascii?Q?tRN31IvgR7eppa2MVYXpYm2m8vRv4RazsVZ0C7I/HyhJzbfLDyu+MIdwkpgU?=
 =?us-ascii?Q?0D3ZfrA+6Oh/cDxtpGW6i3tkiTLg62Fj34A6KpiAiTNh5ELUysmulBjL01x3?=
 =?us-ascii?Q?DgTKu2OuNVrh7MqE1IsghVLj9ZH8eZl027J+KQzK5CmM6mw980YGRw4HhSnd?=
 =?us-ascii?Q?uLuu+0s5z9vCb0i1mZbwdRIRejO1hruRw6IAFFiLy6hFGZj3LPSCiHazrxcv?=
 =?us-ascii?Q?X3w+WAIdoU9Mn5zT6CSoSpVEKQFRWBVhFQthhNH26iU2JudU3hkyw2dPt2Ot?=
 =?us-ascii?Q?DIVAgz8fOIqtz4mSnis=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72044d48-ac3b-49b6-9229-08dbd6904041
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 01:58:44.4705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOS7PV4tFNM+BrEULW3Aidr0yXz/nGXxsUmu/GUNfYoJWSDqBKP0e5qzEr59tUNr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Friday, October 27, 2023 9:57 AM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm: Return 0 as default min power limit for legacy=
 asics

Return 0 as the default min power limit for the asics using powerplay.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c
index 9e4f8a4104a3..914c15387157 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1022,6 +1022,9 @@ static int pp_get_power_limit(void *handle, uint32_t =
*limit,
                                *limit /=3D 100;
                        }
                        break;
+               case PP_PWR_LIMIT_MIN:
+                       *limit =3D 0;
+                       break;
                default:
                        ret =3D -EOPNOTSUPP;
                        break;
--
2.34.1

