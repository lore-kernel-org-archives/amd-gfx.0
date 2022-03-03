Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C618C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 15:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F4F10E221;
	Thu,  3 Mar 2022 15:30:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE2B210E221
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 15:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF4hubglQu3xE6fQ/RzH57uP+3hvU1PZB24UmcPAoAUgOZ+Nyox65n1EFO1JvjtLAk/+R0vk3XeTktNvJK6JL61oQpvJoLSDDkO6TBbid02hwcA78q+LEePd0g8HSz2xuE5qUI2BGdH7AqJEREdc215lqsqtMJhezCuU8FXEtjz+rukwym4wPC0hsW69dZ4G0441g8IJS3TSjKT20qi/OQofHTfgrsNACLcMzqroRVqSrV4nEP27sJqE6AnBoZiB0buaCEiQJ/xsoXGcFSqAnbmDJ3lsZQ7DNjKHqbv/GalCLfAuenrLD/GhrpVwTiX/fY8y6sDOJfVdofS7gAF/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAm4sJupP3Xu3Ee1BSd96rclfO4nGfnaKadfLHAI01E=;
 b=JWuPDMw7ivmiowNHh93NS99u29tjdcbZOV7fIyj9YV9LBLUGVpk88gK5QA9opkybhnxT9GAPmyzMGIvfOSQyt4LRGLVsIiDGn89iz+0JRdpoBWI806cb0ij4A3SFUMSP0voNbrM6IbTTBhB5ZCo5KF+DfI2pwNnYDMA5JFHXxzqiEq3tZgrdaHZYr8Se0FMGbncLR/E3buMRKyr2b6VMPRVod0aUQWxzucRLadpmjSiKZQPsTVwJ63C62p13nXcQ0wN2jGgI5WkHpN2TqAhioVzMuCo4DAR7GCEatw7C5QDNOYxkFMh5d+m9eYUWcIQhNYimzH3gDBT0zGbJEhaH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAm4sJupP3Xu3Ee1BSd96rclfO4nGfnaKadfLHAI01E=;
 b=Y/cAzAW6rgzif80Nb5jPXmPZ0Gqhg00oGrsD9nkEeYDQiemDR9TUUVJOtX3KvVBhMASQt+F1VOAORsG8dxdEjXdfo9ggwI3Blfb5LRfWsLaUAbsi5eGjRPpMQRlcDGSpcbVejJycWkJ3HOhxxJ8+y/kgDuU1TikafGgnkMOe3KI=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 15:30:38 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::b9e3:40:623d:40f3]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::b9e3:40:623d:40f3%3]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 15:30:38 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Yu, David" <David.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Thread-Index: AQHYLwhbsx1upkMYA0CS1PG6P6GCZaytx9hw
Date: Thu, 3 Mar 2022 15:30:38 +0000
Message-ID: <CH0PR12MB53721C9EA7A2A589BF2730F7F4049@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220303140941.27787-1-David.Yu@amd.com>
In-Reply-To: <20220303140941.27787-1-David.Yu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-03T15:30:36Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=05c0ff45-2d07-422d-abd5-700b1cb2ce42;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-03T15:30:36Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b7162049-d43a-4a5e-bad0-242929beb86a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4be32038-328e-4e3f-cd5d-08d9fd2ac52a
x-ms-traffictypediagnostic: SA0PR12MB4496:EE_
x-microsoft-antispam-prvs: <SA0PR12MB449618E9EEE4D8CABBE953E3F4049@SA0PR12MB4496.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYn/zf5X7uoRJJW/5QuGUikKfLRCssECVrI7KO/VBxZKAu8WbobAcUSJRlKAdZaDsgol1umEw3Fgepo9ee2JelAHpzLPHe8T5fymzIkMtbFyeUGRxSpvlfJsa3fCda2KZlCIF+DFbhWmHJo/vxmCbvoz4aYYlS+ofx3sPdrNEwowIw4ZxIZA3qPN5luwcsutsZJwG7uvyPMU6Qsn+5S29aTBo287uO7IgPCU+mXFtxrN8AJmh1Ji5SLmuGRyacBWvKUP15CSVwZklNVP9jr09pNHI4KW1x5EPiASSZbzealw787em4sXu1yuG87d6H2MT/WBkOWp7zgt4O83+TXK6PP2SKpqAfh/9NyvYy2XWDTGun/+TDuFVTBOIApfbw8QsE3hcuaKABsLP+2fjZwH//RTynW43+JPtVINT8FUfkObF77RgUhtJPsfjz6NW5/BREnuAcYwexGJagcgD/unSj+9+qpCeT6IeV06upNCGw+AYe+96HFseNAzsBkE6Ugz8WseoB2lqxp+WDhVpq/DCB58BChfsnbU+Kw9doBJ5Y7aF86wqZFwlPpdwbwluq6lZXBXZoPOuy75oSNolNN95PMwq+0/SB8RArjLOGUbQxKSNW8v3q3nyjupY2oC7Mpnr7uKvbe6YJTJNzB69S7cm/qdNnRZOxgjv0r2dURz3NDm02BwBMFGWIeywcZJtrlzNPaCHc9NAGyxXDsFAXzbtw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(33656002)(52536014)(71200400001)(86362001)(55016003)(110136005)(83380400001)(38100700002)(8936002)(9686003)(186003)(26005)(38070700005)(316002)(66446008)(64756008)(66476007)(53546011)(4326008)(66556008)(122000001)(7696005)(76116006)(6506007)(8676002)(5660300002)(2906002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lBaF0keIQQg+GrAShjPDdr3fbKb75+jmFFNl1kalfGZR36dlGznYh3dlefbn?=
 =?us-ascii?Q?xTMyKHp7qoBED6S8A+J0fKt3+nA5yF+IIAX7JioUFUpW0eAs5B1svdLkp88T?=
 =?us-ascii?Q?kkFuq3Rq4ihSARGAc5kIzTWaE1C5oNhallNN/Plv5H/nEQfWC+Ps0nF9xw+R?=
 =?us-ascii?Q?C/N4XFOgEc8gbJdQw8iwH95PqVxRVXAlxt+LIzGpjlDm3zI9YNG67zx+eeCe?=
 =?us-ascii?Q?WItLI8kUuabkIBXw6d6qp+8ToR/jUYMKr98mV+7cGiucJzFiRYjaPJ/iRuxE?=
 =?us-ascii?Q?veEVssuBiP4iCXcWdEsWzIWvhTAz3uXVbS00Dnfs6Q3GRA9xEthpkYApDgHq?=
 =?us-ascii?Q?4Tq3vhArkQEoSSlyOCeOxpAqCF7qtyEvEyoKmXvr88+TsI7BzK0H2Fcg9Zmk?=
 =?us-ascii?Q?zV0gnJbuVuXwllmDzA2C2p/YydE+ikomWxzw99IK6WV5gEMO2eEvRHGhBLxE?=
 =?us-ascii?Q?Nk6Rvd9x3h7xvsrcyRSLRV2Az/4PYPpEQP9u1d/64e2s2BPYWWr2AYGyMlMA?=
 =?us-ascii?Q?J+o0buE0wxSOGuVUz1zWiXbY2XaEWtDe1NmCqaLbQlfKQwhJHqDoAPfX0LF5?=
 =?us-ascii?Q?gunzAfO5FJ2l2ahR+mTYak7Nxj+nxZywrTWyN7YRQfSGf6b6/RMTsGfb9OHa?=
 =?us-ascii?Q?lzDckOp935JFernYxVi2yBOhjezKqowkO9ME2MpQEPdR4BCYENsUTkDkpTVx?=
 =?us-ascii?Q?4QRt8B/i4V0oKOCpZLRdly1lwt6Qq4kv8X89cPHpiddxN0I+hImXF0cpyjcQ?=
 =?us-ascii?Q?bCfdLQB3xrd/e8Mwp2tSurpwUmBfgM9iG27Kei7ejI2sKBGuU1+ADZzpf5+j?=
 =?us-ascii?Q?uj9mmqLBmKgj1mJAiBHzyWpXwdlyDFP5du+aieLCxa6QjL87KsmePqR1LdYy?=
 =?us-ascii?Q?+yRSpvOHS8nBc7S+n2qALpYrNHDfzqlDsD89VghXelCzXYpIyKInsEQ+ayNB?=
 =?us-ascii?Q?EZXUXNq2Bj1GScP5RpJE8f66Q7eLjuVWIFh9LQW0K30ZPPGsvOEB9/ciGI3r?=
 =?us-ascii?Q?sp7utIzLkphpzqu7XOe3qMRToQTbcpBFCE02eYlYRNUWdcFvtfB68FZmvCm5?=
 =?us-ascii?Q?JDDK3LmjfEHtzzU3qP4LtEKt8h3zFAEdQ1kgPLnX0LuvxUs7btaD7hUTpAkX?=
 =?us-ascii?Q?YNkmbzRaKYbK7o/8fSXc7WQqjXxjHSABj7JLp/9C50xQg7VpvW13sUgV7GIg?=
 =?us-ascii?Q?YSoGu9gLv6GtxGSQNianI5MTJ+wu6e07EM/zzlKJCuxXuMV1925/Nw4gpJvY?=
 =?us-ascii?Q?lP6ak09i0W1Pvdia7KLLVe2XW0z4f9Yjr9SZMSHrEqw2UXPY2PP/wSwGNUQM?=
 =?us-ascii?Q?4niSpXs3nJXCBa4zg2DPHqSja8HiduF4M847nrTWDP+EINaGH4unBKNu1Efm?=
 =?us-ascii?Q?5Mf9sgDkk6COnprCL8ZVP6TEnyAe1mVHjnBMUMrooQPeQODVObl/g0EJ9R6a?=
 =?us-ascii?Q?6AyeOD3A4cMCFDugWTS69TqWnDmRvuUcaynOlj8OipHtOiFc+fMp1/IqPUer?=
 =?us-ascii?Q?Tf1vm1V6zB3gN3G19IrucYxYdS/9PTYAPc0xyyXlmwPcQ8dJaVRzi5kQLJ1Z?=
 =?us-ascii?Q?cTdSr4PBVO2pBLeZ0jnmCGvxLCkjXaIb+7cycv2qAYpLkJHqkpMF/6iiMC0d?=
 =?us-ascii?Q?yjpCqSWOi7oOTcgSSESqUSU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be32038-328e-4e3f-cd5d-08d9fd2ac52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 15:30:38.6600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCHmbTH2P5skSsrCBSRZpfsiv9sOldWu/cM2sWvVhUT+4ulJ6KmxnEnByb+peRMEhHeAagO+m8Tdmpfp6R0VyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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
Cc: "Yu, David" <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Probably just described as follows :=20
Initialize cap microcode in psp_init_sriov_microcode,  the ta microcode wil=
l be  initialized in psp_vxx_init_microcode


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Yu
Sent: Thursday, March 3, 2022 9:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yu, David <David.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran

Add DFC CAP support for aldebaran

Changed incorrect call to psp_init_ta_microcode in psp_init_sriov_microcode=
 to psp_init_cap_microcode which caused it to fail even with correct CAP fi=
rmware.

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/psp_v13_0.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 94bfe502b55e..3ce1d38a7822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -277,7 +277,7 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)
 		ret =3D psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret =3D psp_init_ta_microcode(psp, "aldebaran");
+		ret =3D psp_init_cap_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 2c6070b90dcf..024f60631faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -31,6 +31,7 @@
=20
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
--
2.25.1
