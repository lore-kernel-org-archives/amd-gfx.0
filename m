Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D82EB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 05:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D5410E13C;
	Thu, 22 Jun 2023 05:44:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7798E10E13C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 05:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHlIuUJ28Ioo+Mj8FJXLX5I5URvdMu8NMtiA4cBitHL7bVU5y9Trc6xfj0/s9NtjLoq9UbEpDBc8Ny+c19VeNP6faj9jkkagTgIjrdLXy2voR6p75xZ3ZVXijBm7CtAMMtS3g8WMhcvHlSSpMGc4CxSAd/vaLTrPv1ZEC3dFOdHY7Z/f+Xnw0AbOE+aI747CHnru68gcngMDTpXbyMbYoKHtxZ1XyjApg5lNMkPohU2JTSW3bfMgw1FSLJgGDdy1RKNrwUbe24UR168Dp6OuBxl72DF3esIivZPCrWQH491GT5avPk4Ebk+1zFwd+GD2W033SoHbfo4JRiGX+YmsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAk/F2Vy9rxixPGLSxDVXkcUXQE9Qv/ytVElV0hrDT8=;
 b=IZteAkHZvnWx1mynG46+53ftO217WZc2WeiqVGuCPF+b6MY5oNfLpoz/mVOIOtWjQNr57lHkhCxW6GBlc0eRNOPI6Y3S5pZxs6mn1LZMMYfvkXFS7cVE3+ohAqAKe0TzTkgTnWLbta5/NO5pUk/QJcn4c6sawxLN0Wh1WtrcmlyFtnXirb/tJAbm17ttBNKUtYl6oCzCW8smrkelcCPek1zbQn0kZcVa/Ze1L9yD9kdSOCjGwbmLNA3NMkQdUfn+7B6PUuxZ6ROJp+r/c3RtrVE9BQe+zSUmGxZRc2o9w7Tnypk5nTbbr/GporT83OnGmN7iE0dgx0qEiP6S1aYGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAk/F2Vy9rxixPGLSxDVXkcUXQE9Qv/ytVElV0hrDT8=;
 b=ij7+D1FvFQN+LEbiMWUEx91I25ind/wG/8kU95it1z2ocD5Mq3XKo6iW5JUsNYzc+1LTfRy5Rz/bQf0nQ/bzNqJ7eqDN3grV3nhZ37JZSf5NQ4HD9idHfa00jcKesm2wWHF3KH73ajq6RQf57xJOesJd8YGM4UJgO8iZ3X/jR70=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 05:44:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 05:44:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units
Thread-Topic: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units
Thread-Index: AQHZoquJvrNuQ+dY1k+sxh6FoSq0OK+WU+WQ
Date: Thu, 22 Jun 2023 05:44:42 +0000
Message-ID: <BYAPR12MB4614293E9ED8D77971B8CDED9722A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230619124215.2085234-1-lijo.lazar@amd.com>
In-Reply-To: <20230619124215.2085234-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f1032af7-b9f6-414d-a95a-216ffc03e3d0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-22T05:44:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|SN7PR12MB7204:EE_
x-ms-office365-filtering-correlation-id: c70784aa-14ae-4ab5-5708-08db72e3c745
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: olIlaUKoipen34YHUbuL1JLeyRaRm7PrDl/S6jAomZB0mxviKT3z5sBmTVfl1ZooZXIuSUChY+n/bVz8AekvYYwVRqv/6Lt+rhQT6LtIgsWQAH1WEvh2k7WS2e6wq/4KBLh47ysgSfoJXyK4lZ/QIiToi8XXiVPdm+uUIWBAbtb6d8wPFOFu0kusP+NxyZcSUjmbYhDf77WrMC43yTAUJj7hsE1bundOLbb0aXpx43ev35wqTd21ZQUdz6nUIU5eEf2V/eBPoPjP/V9lgAEWiiYZ3RTGijQyqEW4LkylCgbdH8KoX8oiihOTUf4CDzWUlc3IwncYeUB2urlpVo5FQ420xXArmEvLd/0XMMp2PzDtlcMyYjW3zXU5SMI9nfqFsJn6ZVwYQiM+rl8zmJNX0mKxS/0ZQLpuM3QWSahNpSlEyOx7ka79yHEtxGdGhESTOM77/QlXy/x+ptUrK9czowKc4qPjdEUrEl3KI2mAOwtHW0kc0m7C0CkJ9fL2deoZRb4DKuQQR+luAwm7mAP7NNIqQbe7xEaMgDHDYUXkVQEQSVHoOAAtN3LuUeJCoBDGOa8G5FXlyh3sa+liJ6pWg4ZDW1uBeFoU6FHGnEjtujOK3a0dUjQxoFtSPNyUoSJJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199021)(38100700002)(7696005)(83380400001)(186003)(53546011)(26005)(6506007)(9686003)(71200400001)(55016003)(122000001)(33656002)(76116006)(316002)(4326008)(66556008)(66446008)(66946007)(38070700005)(66476007)(64756008)(2906002)(8936002)(8676002)(86362001)(52536014)(41300700001)(5660300002)(110136005)(54906003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KO/ACs2s9d8Rjfz2gbyyn9FHx62DAkUas3ty3cRsScUDv6fJdqWtv2iVhbkV?=
 =?us-ascii?Q?/JzH+1dSTSgDn9z4/OWeN5eVobAAdjeubVNYZCXPDYsJp8iC5M7ETcuJ8fMq?=
 =?us-ascii?Q?ImFsleBOo2hbCjpRW3s06FIce6G03YFMVjujKr96XTW5v9X0c4A3MCsNuFE+?=
 =?us-ascii?Q?fnfS6+qvG7qk99yFTXacdNL2Be6v3WxUsG0mgsGn54DctnEW10B2jBK3GjIv?=
 =?us-ascii?Q?vBLEg449RJKkIPbQtfStnxjBU6BTPlUNWiQIngKTMilqr5AxRxMYYApCFYyd?=
 =?us-ascii?Q?5CVBtsobogo/K2w+7q2PRW6qQe1pUo5QwHywEKcPoFEhHRiRuyF64ow0KqGc?=
 =?us-ascii?Q?JwdxWbnvG8rWgO664JOS/IRsfLG+54UBsEUfYeA5WqwwucyqP9maTFpOZY5u?=
 =?us-ascii?Q?1HO25jMromigv/u1S9GvXnVMIw4tHibFze4y39KAR4CHL6NUJ83DSwo88rZ0?=
 =?us-ascii?Q?J+1XRs1S0TUJs+v3u8wewmW7gxptSqoI0/nOceaXhgpLQgj4U3wyg8+9Csca?=
 =?us-ascii?Q?4QES199WZ+W3ZcTozaC1bZrfe/0qr8LN715WUyXJsBBqqEtxPNE1po5X+Box?=
 =?us-ascii?Q?Los30WHl6sFQ2V312Gg/Gd7jHl3zwp7lUu3NOKB/73riX/VVsVO/Rh15oagS?=
 =?us-ascii?Q?QUeLhxbDsyYx10gknq+wOfYZtumFXiJYUlKnJ1zdhehX9xALn/6xDP4ETcSZ?=
 =?us-ascii?Q?a2VQduvSMCOMBuvzYqbboDzTGYJzwJdc7oDp3OysjZJpJeR/ugGt+pZWobKe?=
 =?us-ascii?Q?QTqbqjAl7LmBVcpiq7DDaA7o9QGghy4R/x9AhdGpFAj4lrSxCbjulpU3x2wU?=
 =?us-ascii?Q?wDc4Pz7KSrNoCLsXRtLXzI7So8MMWlBO0ZawfgvnPb4L2DboQYgebvqT3XDn?=
 =?us-ascii?Q?WQ2fG09psrH5GQRLpbwOPBY4x0yENiNyddDjfW9/xdxrrGXCZ0xT9W4TuIgk?=
 =?us-ascii?Q?3oqhZu1+5ICPb3Ks0oGx7We06O5uJMhO6bqgfIT22ruP9XnTyfOBqTE+beHS?=
 =?us-ascii?Q?jJr9QVPsd2oEGb0kbB9O6rUb/efnm2ClMvRxvOOA+0w4Mp2uLfYD7ECGPZze?=
 =?us-ascii?Q?PGdY96HpaYW4Pc8XladnDue9Xh06CdUqKe7+k4cImlG64DYlEP6ot/n95FN8?=
 =?us-ascii?Q?28vE/tz4ufULIeOfzydYv850rS4nYIVd0J7p18efE6ntSCZwDs3BjwN6gbx8?=
 =?us-ascii?Q?sZVdThhcSBY0FH3bxXAJnLAxsbHpAChma1M3NVrbCMD+oH4Pys8saandk+eA?=
 =?us-ascii?Q?OMEH57uMnfSlU+5iIn+R6MuMA8Nefzw5QYT3l3nu1caT6/4yP6djet6N/y85?=
 =?us-ascii?Q?Wm/6bHnjqwb2NBgiEJjfrSJfpiwjdkr8BzGeTLNwwm+7OMGYkkSf6TR+YG7+?=
 =?us-ascii?Q?X0AIQ0tWsoMU1++9Uk65VK3bx8+NgEn77VIZZuSGIDGd7UpsWN453UVFgID8?=
 =?us-ascii?Q?tEY7bofSg/IN9X6Jc/5cKvMsZZAefL2Ad8xx/S8wVkgFtacnEp1S2XwDYxZc?=
 =?us-ascii?Q?SUD1V2AWGbi4nqx0MG/m3HlP572k4O/RMavIO9cZ1Eys9sENmRhjLSPvftlp?=
 =?us-ascii?Q?tj/nlYOBrxX3Tpv7gk4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70784aa-14ae-4ab5-5708-08db72e3c745
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 05:44:42.8807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPZE1Yk0H1G4A+OBke7cKv62WNTJ0PfHr96c52spG8IPFFUhE5LU2j2Og7hyhP8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

<ping>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, June 19, 2023 6:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units

Publish energy data in 15.625mJ unit for SMU v13.0.6. The same unit is used=
 in Aldebaran also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a92ea4601ea4..6ef12252beb5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -200,7 +200,6 @@ struct PPTable_t {
 };

 #define SMUQ10_TO_UINT(x) ((x) >> 10)
-#define SMUQ16_TO_UINT(x) ((x) >> 16)

 struct smu_v13_0_6_dpm_map {
        enum smu_clk_type clk_type;
@@ -1994,8 +1993,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table

        gpu_metrics->average_socket_power =3D
                SMUQ10_TO_UINT(metrics->SocketPower);
+       /* Energy is reported in 15.625mJ units */
        gpu_metrics->energy_accumulator =3D
-               SMUQ16_TO_UINT(metrics->SocketEnergyAcc);
+               SMUQ10_TO_UINT(metrics->SocketEnergyAcc);

        gpu_metrics->current_gfxclk =3D
                SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
--
2.25.1

