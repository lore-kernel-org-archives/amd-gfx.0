Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1EBC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 18:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F4510E093;
	Wed,  8 Nov 2023 18:05:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0EB10E093
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 18:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPUuSNyo+R+uaE7RjrHbx1EZSHLybUBqhq/lYsQd84bWcswhnUUQY7HvdW9h3KAhn+BASr8iZHk66wXE3LJ6YScS41ZrSy/RVeL/2GR0aR0vqkPHhWcCQmYdsK2cmnynCQplG/YUCdEpxW0J5pnQPXpUoKdQE/tfaAIQj/EUIYj84AmYvsrwPWf+qw7zEgCXLp7Fy/um/VTsUVnfN9IrtE7WKsDWC6/vD+PuefYhwH8thwKSMa+lxwmzPoAZ1F18imDW+4G6GIQzm1L8ddvOUvjMYNxKvq5nYaVgvrYEf6NRNuHp+r8HJUoqnghGwQWbl+y65LThHdnCOUzIaJSuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8JUSeA++70gTzkRqTumlo4QC6x1Q2VcfW5SBtjyvnA=;
 b=dZ8DfBzYpgi6KjK/10cickfHdOHcJcDTXtgUdtat8b5Nf9K4T1A0wC/RtxaZxN92vKmxtxViPEyMGx8FSoyvPTW5MbGGNQVt+icnqsb+rIq1055uF2rZx6tvPzMMsZyAMLnlTgiDfMd/6KYFiXzfBA6/sz5zibYpTY6FGX3q+Koa08UO5CWH9EUH5JR8b1VCyaMkFVHPvsnBX97yeCY1jQRdgNGIqXT0O1YqBaoWt1aO8aAxDF+Ns6x4EArQIFqSxMeZ5WTw8PaU6aP+lwhjOE4nGABql6ifQ0gpQcE8eV542vPjYKTO+61+CNEqvswbJJHod9bMnTEMwz9u3bQSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8JUSeA++70gTzkRqTumlo4QC6x1Q2VcfW5SBtjyvnA=;
 b=bZsrU2BmvuWeughDBLIz1gHneIQogpyuH2y+BYzeyCa5WagCbuPoO3Pn3nhLiDpmGGA1y+MlNETL4t4VuPCTkvkJaO6MQu/KGlgeg1PewnXBZ7SObCCTdGyRc0fZ4l2OOKoEum6fLKq5dfUVsUli7ylFwt6a4vPEKB97MfhYUW8=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Wed, 8 Nov 2023 18:05:15 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::36d4:54ac:e00d:bf88]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::36d4:54ac:e00d:bf88%7]) with mapi id 15.20.6954.025; Wed, 8 Nov 2023
 18:05:13 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Do not program PF-only regs in hdp_v4_0.c
 under SRIOV (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: Do not program PF-only regs in hdp_v4_0.c
 under SRIOV (v2)
Thread-Index: AQHaElfFPI6teJ/71UWJ6ksXPiSYHbBwt4MQ
Date: Wed, 8 Nov 2023 18:05:13 +0000
Message-ID: <MW5PR12MB56002E069D64ED3B9EF41CB4E6A8A@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <DS0PR12MB8503AA16A3EB7149CC7A4600FAA8A@DS0PR12MB8503.namprd12.prod.outlook.com>
 <20231108152431.3301-1-victorchengchi.lu@amd.com>
In-Reply-To: <20231108152431.3301-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0851dcd7-6ec9-43cc-9ee8-3070ec1e9ec6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-08T18:05:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|DS7PR12MB6168:EE_
x-ms-office365-filtering-correlation-id: b1a852af-6651-4729-e321-08dbe0854177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ZZCYePBX0PFvFzDUh6pWlovWOYdBpX5FsFdz+ejOnrgJv7T5OzvhR4pA99zQHLpV78Zuby4tgcjc3nJzGhi42SCZddwkWKajVAtlJF4eHHo/CQfbSQ33vWioGtmonNOtQ8jWOgcu28hSOuNEi6R6TiEgFUpNRC8qa2wlYEWOcDbFG78rEZCtyMK87LY6tlTgRXLcc1TCyl+otf0ifenctzt1qTUc1p6WXam0FyOeH3cIKaVqtsHq4vPFemZ9IfRpn0KzZatKhxlkXqjXJYfuKM5RAi611V/Nax2/XgsykJCK9kA+Z47ztMk4JJlcmYvSYq10ysk8H/tC66ecmKBz9MZVYb6Pq6/gOXfLM+jLoc5JnfX05MnGi2drH/8S8inhS0UZ1+WsGwYlk5Tv63tMOBRPdlhp8/BlFRVF78gRlchQAx1rjpwMoIvoFWlQvj7TWYnXVt/Uw46xPRc//Yov32qD+hSXlv37kxV+IAMdRQ2Zvk8spfLiTBETcyFmN17nd6+canX1WEi6Zg6aptKBLS1+W4AgpjlHqX37komjjXa5I/Nm2SR5tjut1sLAApQWZ2Hq5C/ky9XyNTk1VotBcrFqCWMD7/pTwgTAg+lUXLPkWr/fjuFUfl55PDvvpFJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(52536014)(83380400001)(316002)(122000001)(478600001)(53546011)(7696005)(71200400001)(66476007)(9686003)(26005)(66556008)(64756008)(66946007)(76116006)(5660300002)(6506007)(66446008)(2906002)(33656002)(86362001)(38070700009)(8936002)(8676002)(41300700001)(38100700002)(110136005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CLwioIWeuG/er2jUE3V6arLF2wwkNbs3ylrcDAw38eZpGXn0TeKiYsFTTRKi?=
 =?us-ascii?Q?mvwnCRiLHVMJ3RHCcE8SGHEQdECVELhk497nJunHquY10Pqsgj/jduS7MylG?=
 =?us-ascii?Q?5OM+K89EjH8D5DjPBqc8sdaW+nKEn2EE/LX844ci4IzHyQKnpn1p/cgYJDW+?=
 =?us-ascii?Q?Gi8Wsj5OyRh5dIqyhvs4lE6s/+oe8GAQIUVRKVBaEhOFJTHz4AG4FnY7/lYE?=
 =?us-ascii?Q?gKTVvpRlTKmxpx8EYi54U7Ri3veVNEuU6qh4btLH3uEsEjsiZHK9b1noiPRc?=
 =?us-ascii?Q?mm6BOjVzqSvMVhlNIatBsQvLXXTnfCi9r2vmbba557OMxh1TElXUVYjccVu9?=
 =?us-ascii?Q?wZ2uTTmd95KBz2OBjrwKE7P2PNszWurdh5Y0TNggD5vZWOYRmRKqiW86gHvc?=
 =?us-ascii?Q?DuncTI3+1xXQZ+TpeitxaQqqFdq4cVG7S5u8CqCq56hl1cFNg9lkVU1pF+6m?=
 =?us-ascii?Q?sUbJ4IGI5TSjdfS1UclH9bvXZROINr79QoFyLZqW1ijxkbR/FX9/MnttxKuQ?=
 =?us-ascii?Q?Dudh9d1pI+AXGApyozJy40MT6Xlujr5KNI7WlRVEbiAW7pnf7xHLUFdgdVCz?=
 =?us-ascii?Q?jUgu1IfKpzmfRmWNoDY5yDikCEBCfvAyRnuePmMcGgj6EHB4gltxeWaHwmlE?=
 =?us-ascii?Q?rXV0TG+JRwlwx7jWDy8wVP1d3wVCyRFvOQMPFjSbgcja5YgSolHkU87ZZAvl?=
 =?us-ascii?Q?GbZ3K2Pji19mSt4rVoz7ncfeKCmoUfT4Fx3N0qCpnyMNF3zmiZgRLJV8Un5O?=
 =?us-ascii?Q?hb//8JSEq3kh5mseKn2wAkdTXmkXsz51RL/nsp1SjTqOQdUujrYgabPTELAP?=
 =?us-ascii?Q?occjyAtGVPmOMQLJnEVJANBkPZS0KqHHdjtcvR1KlHzeZzf3/aAO8r3osGNn?=
 =?us-ascii?Q?qMwzfddhydT1Zp7CQMraolgvyWRyOuvC7ptR5Kb4kIxpbkeICywGZ+gjFBAM?=
 =?us-ascii?Q?tCmjTPz8dinDwyj72Ed96BJIUYhUREVhuadJIQ0B2PF11mZliTqq8RUNZWY2?=
 =?us-ascii?Q?bJNmI5zo67wKxh+J7S47J6R2n6f42NjWu4S+DxXJaGHK/VZ2tg2bHSKJ3aRk?=
 =?us-ascii?Q?ENME4rnNRy29FkbysRyAa9wVmnXHO1FoyzcRTc5On8noQnFr0mYI/fqm6E2T?=
 =?us-ascii?Q?Wx4+81PxqptCAXog/EJioadiP6EM7I/eW5x1lHaPQpkFz2e6IY4Hxg//e51d?=
 =?us-ascii?Q?Vcup+vnx8xP0f8FL2HecO5USJDtq8Q9W5oozLikgTJEmgy36M8a5pUAUyVpK?=
 =?us-ascii?Q?KkrkU5VoyLIkBL+1KZCFUhseU4Ca+fQaYRIJC3GIcvYICCpEfLC+uiRpmhOv?=
 =?us-ascii?Q?kEQseEq8lywNA6fnky+6/LP5ISep5LzVAC5+AcRsxbIGlpJOOB6OnT0n9SEI?=
 =?us-ascii?Q?WGWudgCT+AvNnp88ePrWzD3LpL9pSY69RDmm7esVY3fbCvGNxv6pR6iiA3Mi?=
 =?us-ascii?Q?IU+0xaULwL0EZooIZ4GIn90Qh763c87evLb61IAbxsaslRD3rRl1DNnFSDHt?=
 =?us-ascii?Q?Rv8bKcNgtugiicTgP0OBtGiMshsbxTDDiUsB5c4QL3Y9YXE/ycdMb8w+p5t5?=
 =?us-ascii?Q?P4Tu+8yYLaQKUzj6Mm8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a852af-6651-4729-e321-08dbe0854177
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 18:05:13.6123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqxkEiF75rSRbBkbIVK1dQBazS5BJt4SOzt70+6KVfLnTre9DmTx3rThcTWlKbkD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

Reviewed-by: Samir Dhume <samir.dhume@amd.com>

-----Original Message-----
From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Sent: Wednesday, November 8, 2023 10:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Dhume, Samir <Samir.Dhume@amd.com>; Lu, Victor Cheng Chi (Victor) <Vict=
orChengChi.Lu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Do not program PF-only regs in hdp_v4_0.c u=
nder SRIOV (v2)

The following regs can only be programmed by the PF:
HDP_MISC_CNTL
HDP_NONSURFACE_BASE
HDP_NONSURFACE_BASE_HI

v2: update commit message

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c
index 3f3a6445c006..bf3bdf67abb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -145,6 +145,11 @@ static void hdp_v4_0_init_registers(struct amdgpu_devi=
ce *adev)
                break;
        }

+       /* Do not program registers if VF */
+       if (amdgpu_sriov_vf(adev)) {
+               return;
+       }
+
        WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);

        if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 4, 0)=
)
--
2.34.1

