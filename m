Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1165C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 12:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614FA10E29B;
	Thu, 20 Apr 2023 12:30:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A01C10E29B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 12:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX+YKkv6aiqp6pmKjy8cXt3gnEMZIgD0YqkT7LGU4zJFHOavKqyhsrK55GFGdbWEr4ngTGD2dUM5uvWsYmjB7pj6ZchCosXfi4wsRPHqmESfzBy0F3uXRdkTR0BvDUl9hvzfyjNTupjvsUTen3HzGUbBd5r9HwBAGEiMS4GMt0zunoRWJR3tCwHlGCmAuGsWuM2C8vJmLVhnXMt6c4n30xfkMovoCugJdfhhHxEWXJgJki7tamBBPNH7h33aHDsiSsJJKTDmwT4QvG9M9fBww9iGW6nGzWJF+rTrni2m4lBT0t+RvSw7+aHo06KVJnrl7f/pSSsdL4MPzDl0QtBnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyqF25E9YZZqPqerdabfHqucF1D5uHjyVaSIf2Fd3OY=;
 b=RiH2mcYpyv5JhSKwZFdZ4cl+OWWXzcGn2y89pRLYdXgmG0fD3WqQkFWKiXsrt7RHSVDQfnXSRigKqDNQG53+u8p39oYUtcjokjfgFO8yANVPihVvTMnI+T4O+4pdLBtjBfZGYXE6GaO+cvaE4Ia+yPoaO+SJrvOohhisPL++fKmdTo/UXf2MlWoepCUsT+iLDf9stl0rVUOQsRt41osXBnJftzb6nDsuCJ8W7m6a41/v0F7qEANSOLY+AqUUIoxSo314u3XuR3JAtoQuvj57UBaBdV2mOxe9Hzb/TfwIZbOjSPgYVl1TEFZYSjTLpiDxaGiG3PUOBQaDgnwh6EypYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyqF25E9YZZqPqerdabfHqucF1D5uHjyVaSIf2Fd3OY=;
 b=47NAgRRZafe1iOoeRl39vhxz0jPlKam8LY0OIc0zk++p+auyUsmBkiU4mgYCmsdOSlmE+XLWeTdSMQUVXaOUB32+muzcsl6kpeR53TOZR+dO+FBo2hCzRFc35aN0KwxNaxwtWdaBCXCoN3cpsLCOnNfi/bfJ+gB/Re7gOx0bXvQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 12:30:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 12:30:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: extend the default timeout for kernel compute
 queues
Thread-Topic: [PATCH] drm/amdgpu: extend the default timeout for kernel
 compute queues
Thread-Index: AQHZc2lBfT557wof20qq1cUUzfP5TK80IJ5A
Date: Thu, 20 Apr 2023 12:30:51 +0000
Message-ID: <BN9PR12MB5257A9508C775B5C04905D4DFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230420091942.5981-1-Feifei.Xu@amd.com>
In-Reply-To: <20230420091942.5981-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7c8cb734-f561-416e-88ae-214d0979b9f3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-20T12:29:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB7255:EE_
x-ms-office365-filtering-correlation-id: 79ef1cef-d6d2-4ff2-0382-08db419b13e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgrR81G90cNE6Xwpfv4augW0UpaUuZzRHMiHfsPJ0mNsgMatGSg8/WDbiT/2llidUHzGJm35OonNE64MvwsBW4dCtum8Q264zCF4JDY0B1sw+ZqKt5yWJ6AtZ++jHrIknTLrp/iAUWGjhHlw5NxUpF+Hsertp2IEIF/XjIaPUdHWdHvsMFXBpVv642BLBkGrPdOBIu9VzZ1lqctmZQ8zDSREo2STQVIRET4RASeke8Dz6IqMC6gwtWRvAy87Ar6uvQ+L6+MvUP0H5tBLm6393BePtMUMjTObNVaWbjg76Up3Os3WN/3k0r69v1uMBYwJSElBhwMtlxUHsXv2DSDy1jzN/Ga0fRvJDk0O1LkTW/Q2dupgUBy8V1hHho1gwa1R3Jz9wNLeC/g/N+57V5wF14JqiYJRHFPeHyD8trKKuZ5pZxe+cnFX3aNv7fTno7PWTMddo1PZPKBT3dJb+7ttrlty9qtJs60bY1DwBkJP2QZXR9JXGVhAI+GvHOSkFDoGoS+XIQ9MEgaSGmk8ryFXA1ZPh3Wlches37Blx8LrXThan97VBPVmAPA1hzqnbb4HSNP0wisQeB+n/tw4GngbNtpoEVO3p9JmRWOqpJR6tvS4jhceY/QVfdknDCP77EVh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(33656002)(53546011)(76116006)(4326008)(316002)(110136005)(66556008)(66476007)(64756008)(66946007)(66446008)(41300700001)(478600001)(55016003)(71200400001)(5660300002)(8676002)(8936002)(2906002)(52536014)(38070700005)(86362001)(122000001)(38100700002)(6506007)(9686003)(26005)(83380400001)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZWg/VIoQZPsUxMkF38YKG7+wVTePbEsgkg44AJBo4GKlyN8ddRn/XfSIVzRj?=
 =?us-ascii?Q?enj1FLrEXzB+erIYTbBx19KziH+FGVo7jX1jyw8JLhH7N4NnDDWNCOmND6s0?=
 =?us-ascii?Q?eifGBh23qud8qY9Mru5ivbq136tBLqUhmKqpZjT1Q5QlDJn+vgFqjURmGpe2?=
 =?us-ascii?Q?cj4EEB0+Dk7Mp66Sg8zUJ5nT88J4Rq0YaEfPXjoxiqGtdnXzS3k67mYFTH/v?=
 =?us-ascii?Q?eRPZUralAzXIhRkCu9atB/ne/9u56rY5zxErjpTH2WNgrCgKo2KsKWrCDPoJ?=
 =?us-ascii?Q?43xnq3OROFVQGpJr7J2oXcyRLeSmdxqld+TJnH4jAW2UVIWeI5CFG+vV5GRU?=
 =?us-ascii?Q?hFCrQMUiR9X6tIEnf1LLbm5/jEcYxWRCnMtAfRl9AOsrLnIfdlSrfGy55Nmn?=
 =?us-ascii?Q?zua+GlVhsUNzQ4aeUInvyh4RRD1hwIRsMwKYUnzbMzkj9Hd2w6f+zmPTbJg/?=
 =?us-ascii?Q?bgegsIJ7PF74SDghW3NR6aUeVKjjk1FVc63CrFLCt3xTc9B6My5VmmUXtiLG?=
 =?us-ascii?Q?Yricvz1b5YcJbNdK7+KvLnrOJSplSSfAFGod8UnBOR1XgA5zfFefBtozbYqi?=
 =?us-ascii?Q?VcILS/0lxu6MtxM6f6SAv9QXo5x8/uHtB703YdO3E4QVPjo7x4iu6VP81V6m?=
 =?us-ascii?Q?DptJ3Wl/Ggtb6MJvzAVtDwtKUMnimCfVKXnPGbC31BvtuWFFW2JeGp20KKFp?=
 =?us-ascii?Q?+pCQ5/XP1m2O+O+zLS0M1a0qhKa7fZQtpazjtpZUCN7leXfmbMNZPQcIMWuy?=
 =?us-ascii?Q?zqg/RDiJHoRXypZxOdlR9NOGEySGoOm4Z7JlmSkl6nttmy/qv/kl+tvPB38V?=
 =?us-ascii?Q?X/0UNWemKONJ0MaURJtx7jt0IxxS3wjGaT37SNBso4Ixp3RMRlPtCNGDeV12?=
 =?us-ascii?Q?O+ewy5nnBbpsOVFTdXgWUrkVTefbGip3FmKrSn6d2NcD3MY9wsZ+WmuWuBlC?=
 =?us-ascii?Q?FC8oHudn92KPqLgHUkyR38k+Lar5bYF8ER0xdQOSHJXmBQPxazGKIrJWR5Gg?=
 =?us-ascii?Q?XM7eBYJz7KEnedfMrGgCL5i/lRzsJ7wFm/m8t/virT7CeCcFumWZmb1XkRLF?=
 =?us-ascii?Q?fQM7ya/Fiy7/q0iN/kGadSPgwnISka+usZZURXcxRA5gZLOHnpP9HPE/QfyM?=
 =?us-ascii?Q?/KXa0BbSuil54vjqxcaTw/rPeUHHie8JuR6Rm+uo9+sfrz4Cp3rtRLV0hn10?=
 =?us-ascii?Q?QI/T7aCXdlDM32v2zlp7S5r0gGyzC87UYGGqAZMSYtU2tjo3Lw50U+8jX0oL?=
 =?us-ascii?Q?r2zKGzU/iQwETwXWaWLqkBRWtmXEQ+TGuH6LHBX7w6+tKSRjm3gG/G64T1jx?=
 =?us-ascii?Q?oaBaDH5oUTRRbxlOk68oyN83EmjKziWhZMyzuJ/yU+c8Ps8XAMHj44TCRa+x?=
 =?us-ascii?Q?w03yUDHVTfa53zoDbBxZJcSwROD3/8cQ3ZoITNu17cIFLyDVkzBDNRH7koX8?=
 =?us-ascii?Q?4i1+79O82C5Ubuz+bRIVlFWAMJDLVb10Ao4HmWTIF2Ha3SiSs5RNAnN1ddFz?=
 =?us-ascii?Q?ip5sojImvtrXr440ip/tSLNW/0+4PYFNHm5MxxU0g2hHTG9T+wrE8v4/LH5n?=
 =?us-ascii?Q?FrazZEXMowsM+zDYGdI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ef1cef-d6d2-4ff2-0382-08db419b13e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 12:30:51.2096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moYDXdik+oKNJ1g5MBXL4VCLABWQmbF05vyPRrL9NwVpFzpyDoNrGRGjyG8UdbRddzDDFCisPDsX15qdHvUPyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Thursday, April 20, 2023 17:20
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: extend the default timeout for kernel compute =
queues

Extend to 120s. The default timeout value should also extend if compute sha=
der execution time extended. Otherwise some stress test will trigger comput=
e ring timeout in software.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e536886f6d42..1f98b4b0a549 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3475,7 +3475,7 @@ static int amdgpu_device_get_job_timeout_settings(str=
uct amdgpu_device *adev)

        /*
         * By default timeout for non compute jobs is 10000
-        * and 60000 for compute jobs.
+        * and 120000 for compute jobs.
         * In SR-IOV or passthrough mode, timeout for compute
         * jobs are 60000 by default.
         */
@@ -3485,7 +3485,7 @@ static int amdgpu_device_get_job_timeout_settings(str=
uct amdgpu_device *adev)
                adev->compute_timeout =3D amdgpu_sriov_is_pp_one_vf(adev) ?
                                        msecs_to_jiffies(60000) : msecs_to_=
jiffies(10000);
        else
-               adev->compute_timeout =3D  msecs_to_jiffies(60000);
+               adev->compute_timeout =3D  msecs_to_jiffies(120000);

        if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
                while ((timeout_setting =3D strsep(&input, ",")) &&
--
2.34.1

