Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF6EFF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 09:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB37610E3C9;
	Wed, 29 Apr 2026 09:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kQNjaktW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A1410E3C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 09:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eScpsqHTetv1nLXWDldbMt4Vyr/2MDktswNusUQdpWpaqYBcPOnHDfBdj5Fxtu+/iqkvBxIZ6DHYLdFw0Ung/rDSIvIILCSDnF+tdXnDnFO35iXaPIBgaQ/4IPCNuaxwSAEIoRVs9/buxkVSPtPiiDvgiGZOGxsanJJK/IS2hUSfVs4NnGEbj5dSu2QzQV5m4Ol6tnQQgPoO2ZSAgpQr32Obsylr55uLBDet+rcHr/oN4kLQTocarpcZPjXhk5o5qGEetNR/VcRa2kfbuJ1YPDAe12oSQiy89aoDerFlq3A9eF4Kc4AYfpqbh3VfqQEjLjELE+eLv91wh5KGUoyghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6jVqhZxXv6sgS3yb9ex0e3OichN1t5guQqxEaJyxYE=;
 b=yni6raV40ZFoDlSBbiPu5hqW56dAKXCqYWyvbh0HDRYMho/RUc+oCzc2+944vAjgIkMBYjkWKe6bKUtUN1zpDCaZ5xEnWxlBPQU2+3Ysi6OXRrGIiFJJne2n566bV9PnHnqkp6/+kSxsYmLMdyCRlw3SbIYJFXx9CMn64gbmcZMGm2w+qGrrnhRETG63/Ic8QOp8HtPwL+O1EngHtEtXDgcv9zJZi+WJNNHkrSB26VdmfqcnieT1xFED8gqtxOj64dQH1J59dK9NIR5b+BoBAx2T1cK+6JSB/Xl8ss0ycsuxsHZYBRf1h3vQpUFRqc5GtVXwicOrsGKSiQe/tgMTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6jVqhZxXv6sgS3yb9ex0e3OichN1t5guQqxEaJyxYE=;
 b=kQNjaktW2hc1bgYJtoo43qEFJ3y2USvlaclehlLfAt/n5ecbe0WgnmZ5WUW/WFLc5onb9o4vaIMXZKlLFy2hGLfDvWDupHDbEIx1s++WpU2teoNDzM4UymgzwDGe5Fy9h70o4MlsJ7OSTeAXYOz1HjOB6BhVf8guHP5+SjGogBU=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 09:07:25 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 09:07:25 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 0/4] drm/amd/pm: add and use the SMU multi-msgs helper
Thread-Topic: [PATCH 0/4] drm/amd/pm: add and use the SMU multi-msgs helper
Thread-Index: AQHc1hgx4GPSzRHa0kq5s/dnwVFf4rX1wl7A
Date: Wed, 29 Apr 2026 09:07:24 +0000
Message-ID: <DM6PR12MB2972E5937FCD249C8AEDEB4F82342@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260427073355.3363500-1-kevinyang.wang@amd.com>
In-Reply-To: <20260427073355.3363500-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-29T09:05:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|BL3PR12MB6545:EE_
x-ms-office365-filtering-correlation-id: 71eee53c-ee61-458b-ca7a-08dea5cebacd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: DN/ne7X2iIyOY1+s5uiS9lz3Cc6vEyLyeLucL2lZo0aSCd8dMxrfUadLT6Wmb6i2SLsg8uqW+4OAdZafVgGSnIiRvoZvu/fsakzSQ/0+ZwXnp/Aai/jbYnt6vNfNeYT85/5T8xvVgUtXvXEQaI61YEnL0X+YNiUVe2cVbr5xh2RvmByp9oGDmMObx/8yb/tjyZXN5oyz6KkQRoWeU2NzTK1EMuBIgBa8fNzLHQ5M07jJeDKgaH/0uLy4U0ZP3cy3eZocuNRHviWpbNQ/Y6rrZa99lnO/bn9m9Euh/R6pQc8hGdgEV8cY4wR1X/8d5lmK4mqpRLF+2Bgzaq7mrva1eNUBAQZWOvhNu4C0pwgng7MFQQBWSK1+Oe29v3ivI6EC6gwlYFHEq3HXS58oF0O8e0KNJVhbLeVLNMBMi26LJU7EeqPGg+uOdNggpCNNOJOT0qgWPQ1VBbydPmkdI8GfHEIZ8zkCqhyO2E3QusmeKSvFhtRX16T6/PS3R2Txu+0qPb3tvne6E/VR5kwvdZpsyK3J1AymibJtD/EnrTCOMt7to8XnSQWn3pyYknVj+gzpCU3dAE/wx9WmP/q7gkjhon4BQV5K7boN/zLHnMV0xG9vPjGz5XI/3fabdk9jN2mgV4/vSqFLPfaYEconmGHr2/+Wfl4T1b9VNqwLP96Iqi8FhkgXslPFzFvqlwdqNv8dh3zxP4svg8QvYPqS5iH5C1eyLJQZn2KhjneJZYMvqGrV8VtblAfnl5+LDNYEGMvHRUT2CohlRqVbddegPppkklu0aiqofKc8dPiFiBLo0a8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZP8NDB5DGHrK6D+z2nhLG8iY+S5o5oF+DJKMRrX8plmXrjiXlHeErEBQiKVb?=
 =?us-ascii?Q?OxvexiZ/aH9x15xaZManBeORnXpaKTVwnWgWsMY6YIlvP8MuwQRdoXN0WdR1?=
 =?us-ascii?Q?9jv1wTewVPsoXwOv0jP8+qqgiLSfLrLvibDInOZo9cf6Tk4tNgD2AekKyIWJ?=
 =?us-ascii?Q?0BfBNnroRZYfOm0FIzEPdDSpd3ea1bbS++jvgV4bSuFvJCRBtrnZwf6En8Y6?=
 =?us-ascii?Q?WMprcwlLs0IznZ1zVc7BaM7Icf/FoIy8/JDKxhhXZoo1pZMvZopc2jDPK5+9?=
 =?us-ascii?Q?dT5pfUhDskg5s8Nph9lmlA/P/6fxg8VUuwsW1ZNrP0gJiu5L51nr+7cS81sZ?=
 =?us-ascii?Q?xFohZr9YLmpTKcsWWaNvWO6dNt45WF9Nggf2Ad6bT5iS3P5jzY/VohG++jZ7?=
 =?us-ascii?Q?gD+Vjmxps0Kfl4nc8Vs5esF02UfJOHeHfalEKdJuXw/uP9NrrE6Yy+Neh+lm?=
 =?us-ascii?Q?0xmvG5QcfA5R7XrniIKvuwCMSIuINTMYHdM0icB1hnpVkgWFDpGN4Df4pd4H?=
 =?us-ascii?Q?+mU2p5Bu57ylHbJoxRVOhlzNwte6LCTG2vxfy8MHdqHflyJdgaioFatMA5CG?=
 =?us-ascii?Q?Kd3SOg+6Bh/KlwZkh0olWu9qqMTboTkLSnkV44XbOK23ylPSkmee45mR8kSW?=
 =?us-ascii?Q?V3AZlF4yGGwEU+HEd2AbTZOedfhAOrRHvIkcMIdRshmpdGcImmXJH5xp9goP?=
 =?us-ascii?Q?CL1w8Fl95uB9UBMlR3ddHoRKLphdsEBhkq1q/42w34NBnxVir7sRmiO91CvK?=
 =?us-ascii?Q?c7eyqGLxCHtw/qK8StlDSocJJbud9JlLEel+4WmGBNceFdkycC1MuBzs3wS2?=
 =?us-ascii?Q?5S16x5hK1MJ/vvUJTzmtVrmTFgeqkDiWZdt1BbGmzC1I1uNCWfGBH1foaQHi?=
 =?us-ascii?Q?999iWDqXqRf6xEyvSzPn9K+ZRIWkz2juwQZHyYE/xV8oZiASuxkKj/9YVqOo?=
 =?us-ascii?Q?32iBbhMResatJQEWdFJlyhwFJZPvEE25wq8PB5a3WlzH70/Vrm6WGWBZd4/o?=
 =?us-ascii?Q?U1zM6YKOehDoBi2F4hRTS0M7K2dqPzVCMRVmDIkOWHfrtzmW4XyWZGG/DMSW?=
 =?us-ascii?Q?g98vh9+TRv/cudNaSeOq6fvV/3H7MmPBQKpHoizgMa/XP3HDmc+gDxacTnfX?=
 =?us-ascii?Q?38HS/1Z5XTXkla+HpvIcTArp5BAXDZ06A/OhQmOY6SCsj5FI3SRIIz5y7jVY?=
 =?us-ascii?Q?Tl2w9dO+Y/imKtuFKZpPiVuwRRSUORoaDnMYZW5/MMNNGmWJ2iKTbCgzdGBl?=
 =?us-ascii?Q?fBdQlmees0DsVWEsr0JqDUuHmeYWvXZ5PhvnzfQNAi1q0FOvCJ2Rqf384ZFr?=
 =?us-ascii?Q?CzOD3H9rOKQJv0TkEaB8sdTEnAhyi9TSPlgOAwK5y2B2d5A0bDdZKX/15hlL?=
 =?us-ascii?Q?JMPX2TXL4BU6JE+A7u7I5dEkeO/O3Ay7GZFB4i3T0NRuiZY21rrYDvRVcSIR?=
 =?us-ascii?Q?Dossyx5poA99UbplD6NdHP5uuFLzv+9aNDOAgs5esqTZr5wFcH9t2cHrJdij?=
 =?us-ascii?Q?EThgyK+84pPbv0qgnt69SnM2uJOeyzWCGKXzetG9kQT1idVccnGgsxb/TX5W?=
 =?us-ascii?Q?9aWYMNPU7nnNEzHAuK1tmjMtd/+rOevfySAunGcdMIJD4NCWThQ8et+Eyubn?=
 =?us-ascii?Q?MvL/v9WWhJ0rhBzPW32ZxiatEh49ughL41Dqu2av1j+ixYBGqZ92TBTc1DRF?=
 =?us-ascii?Q?7+S7jvPQa6BfLU0pPDccEAOLEAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eee53c-ee61-458b-ca7a-08dea5cebacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 09:07:24.9038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXcU52NRuhiyjPKjY0OwHmdD1FS5g9ICupwepKOfHniWuc4zK4MB6Jtq8P5GK5Ar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

AMD General

Ping this series to enable support for upcoming SMU IP and SMU RAS interfac=
e.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Monday, April 27, 2026 15:34
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 0/4] drm/amd/pm: add and use the SMU multi-msgs helper

SMU15 introduced driver messages that can carry multiple input parameters a=
nd return values, but callers still have to build struct smu_msg_args direc=
tly.

Add common SMU multi-msgs helpers in smu_cmn and switch the first SMU15 use=
rs over to them. This keeps multi-parameter messages and multi-return queri=
es on one helper path while leaving the older single-parameter interface un=
changed.

Patch 1 adds the common helpers and updates the shared path.
Patch 2 converts the SMU15 base table address messages.
Patch 3 converts the SMU15.0.0 table transfer and enabled-feature query.
Patch 4 converts the SMU15.0.8 enabled-feature query.

No functional change intended.

Yang Wang (4):
  drm/amd/pm: add SMU multi-msgs helpers
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_0
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_8

 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 47 ++++-----
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 38 +++-----  .../drm/amd/p=
m/swsmu/smu15/smu_v15_0_8_ppt.c  | 14 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 96 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 22 +++++
 5 files changed, 130 insertions(+), 87 deletions(-)

--
2.47.3

