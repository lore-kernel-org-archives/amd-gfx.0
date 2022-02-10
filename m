Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8AAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 02:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB2010E2D0;
	Thu, 10 Feb 2022 02:37:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0873610E1BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 02:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8QmyND1G70czk7bFBSJSkDt7oG08qLyGjUkXW8Q02eUPd4B3pdAtxIuQqTGmhmHYLzHO1l4EIHleQuSy4tfiF4SEkLcyfiogFGFQhPuY40csyyf78SBW1a4BmPF2R/TrU4k3HFaIkN1NDjZt+1OaxBmDqe2l9MxbiA31mJO1f74+r8z50as9A87CWAK0p6B7+A9L0WYA/0QsAu74i/KPMfdcHv4chlHyVxJxFzszNcNgf2OM/ysxDdicke2ZVORN7evZzHAaPbahMKZC6d9P6dqZDy9EWj9ydNX7kE7ARO+qWKsysotJJx9FVeRGQ3rj0gpaftUxhkl089903zBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDJYEObIC0NgEDKs0L/utSNrGfBEejIzQULcVk58XQY=;
 b=kFqQfOYCPEMJyzSmVshzkpZlklsmVwVAsMafE+XqCH+jFbdyppKsgIaOY7SRP4R45oxz3WPm74TBgeOVboOBIzj7nT5R/AyYLEtd5iu81jDp/224Eawj3Jr9cepcnJ4a8ZE1pAMXnMxiWpAUqbo3nzG9u1njBVy4G2VUNv5ywLKrO2zZkpzvsmXDg9Qf4BvFSpbJKOSWE616rMwwZa8XTX3W4N/q7MzuoZCPtq5BF15c29O0eDRqu53tKuGjuwrOmRu6kbE51sU+rHq+PtXa0bUdi2jZmQOtijuaY7Hw398uICgptsXf3UkJA7hRvAkkm3JV8h7yUgnxt8420LGaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDJYEObIC0NgEDKs0L/utSNrGfBEejIzQULcVk58XQY=;
 b=FuUb2t22h1o+E/dAfm2UEcl/k66f6g75zUZvFf27Nj1pGRt3VIuUNp7pkvXEVNUM++WQJDnefjwRCuFYxEavz9bUCU46YHTxdQlVOAzvl6d9HoXUn1YhGux75svxjwoLx65UIYgC9V/yMf6+HCNOuvWWP+8INICWcfz3Rttl/no=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Thu, 10 Feb 2022 02:37:44 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 02:37:44 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sdma5.2: Adjust the name string for firmware
Thread-Topic: [PATCH] drm/amdgpu/sdma5.2: Adjust the name string for firmware
Thread-Index: AQHYHedSiX4fZcHcwEGGCExV8yaaGayMEkrQ
Date: Thu, 10 Feb 2022 02:37:44 +0000
Message-ID: <DM5PR12MB2469656064659FD0285A4918F12F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220209190011.603362-1-alexander.deucher@amd.com>
In-Reply-To: <20220209190011.603362-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-10T02:37:01Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fb239c04-a656-4246-83f4-41f8971bf7ee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-10T02:37:41Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 08722028-3a08-48c8-bece-c011bafb1abb
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f166bd5d-8300-42d0-7547-08d9ec3e5117
x-ms-traffictypediagnostic: DM4PR12MB5914:EE_
x-microsoft-antispam-prvs: <DM4PR12MB59147CECDF4E37E7E26DDA56F12F9@DM4PR12MB5914.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:206;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsiLa6+nnlvQ1Nb2+5KsisRzf+ztiaho53pHXkxAObuGQRP4zGkuuw5lNJgn65CGAh2Uon52di/0M/A6kCIfncDRsfIvRxhIMujknwsu6d5OpYSg2PP34KTJbOTqgkJkL2hYxPXoHgEtECnaL0b39R25kXc6vVNbxQ1iGxLrSvxy7gaEBf4FjIp1l8FsktPOpboT8PnlfswX9P0A9O7f8KVJwzcMIUdr9K3qyAuD3/sPbizizlKo7uerWX1jNnN3Tx7s9Ifgvgzlw+nhkxHbnOvpzNfjSMnwu9+A0fxEEqgWFhc8W3xPHcj+9Ni//sVvWURs2gMUMd5/ql4CjDM+SlivCYMPO9LJzRl1mkkkPWs6nN+4wah49/02R9eQ4m5Uo2WXgsQfCH/YijmZJpGAcTmvn3dY0/oIE/o4ESu20YvRYgRUuSdd5OgVAgf1uBBh/1efoA7ha+wJrjacYceNtl95OGlUpQA3JnLQ5lozDqWePpegS6pqsLz2zfHk4gJepS89CtMnPNk7bHyfyP+JrRua0ptNXH4wk+94jnxfUJrUOEzBdYe2hNzG64t0haFNtttxlkHYWci5jUmFluTfF8nEGrl0f9QMbk4qJqLbGfKx8TISkdPjETbnny+go0AHB8Y4nV6eNdVJ5681UQcXkMRbG6Hr6H+NkCWgYGDO08MkGs83Po/gRBgaLxYApQau8MYblSkEtIBgucvxsjuhxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(53546011)(52536014)(6506007)(508600001)(9686003)(2906002)(5660300002)(38070700005)(110136005)(186003)(33656002)(66476007)(38100700002)(66556008)(86362001)(64756008)(4326008)(71200400001)(8936002)(83380400001)(66946007)(8676002)(316002)(55016003)(66446008)(122000001)(76116006)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F/Zq3vEvS2M2UCcmaICutLok99ENuzdy7QPh0dLmpXv7SET0QRh8dr27mzaf?=
 =?us-ascii?Q?P2ePaF9kM1Mp2qOL0jboJjy4dSEJp/+VlpSNyv+Wl6/PNj6xK8fgj5tiwQjh?=
 =?us-ascii?Q?pZs4CPOMhSGU2ChdM1TYZZtOKVVM8YqtYPIZqDSHt5yZzBkzRk69mYErSl2e?=
 =?us-ascii?Q?/9TYyP8K5dEfHcO8IcX94e+X8HFIPOJQyZ5zXUTN0Zzr8lkGMCKzDpjF+U18?=
 =?us-ascii?Q?7jjOZ186SVQcqoxdw4OpDz0lfnWk7EfNXyT8gWfTwA2MmFt2HoL6mMCvfdei?=
 =?us-ascii?Q?7E4m80cigdsUYpcBxedBPGh2cWcS0RLmDPN61FjifzMyEYnVBGclPxsM245I?=
 =?us-ascii?Q?24YADi0WTS94+sRb5JrNpEapLMVgoYmV/ScUD9Fl7I8br4zSVC1vjz8ru/y3?=
 =?us-ascii?Q?XFfxxzIwv2wfM9umicTU7C0kdPHbBFz4e76jCrbqXHkQj/4jfPUCi+4bww2c?=
 =?us-ascii?Q?lbhBVy3Vx2kez8fEE0ic1ampmLr+0lw2kPOgZUhbSnqJOcWajqMX13OqLNst?=
 =?us-ascii?Q?DVfWpJdCH2yWyMzUt3IL9xTQCvEUtRoh8iwV2yrJis3e3QFtH8QvEVs1QdEG?=
 =?us-ascii?Q?b5LGQVLYPPtQ9Jnm1VPx90Syngv7JTniSOokBu+w8bmcN/DmJZQNESK0eOLh?=
 =?us-ascii?Q?y3Ns63CbjnBkLx8v3TD+PoTuemSOhz4DUAMDusm4LTWpkYhdQLFUpJwbKDFg?=
 =?us-ascii?Q?MRvxvBlVuh0V4HDNzRNzgPFmfPBz3c1Llfve6945v0rQgs+E+ms+XEupVCP8?=
 =?us-ascii?Q?BWcIF9A45p04o2/PzvAKylKpIwPGFbpkJw6akpDQAPPWvwj/5QYuzmhPfV9r?=
 =?us-ascii?Q?5deukphktkRRkkpqkmT61t3kVS7tZ0LbY9TAMn0pvXvprj7cLS99JwpF1oq/?=
 =?us-ascii?Q?/fVbFv3pj27fbdIjcmiALFlodQJ0NdJaYlkP4DJ1aiA5Fek/21tY/IlfAngT?=
 =?us-ascii?Q?jkza3HbTGXO8tPyECmXs8PKRBQaFt4Pm77umFJGNPR/ZWuULsnwnQVl9uWIr?=
 =?us-ascii?Q?DSkSNUKY5VXdSZKeAllS1PuDPdvy4QITvxq6k1PEDMgCo2Ye25Z1AcZHMJ36?=
 =?us-ascii?Q?eG64WdldKtGrLX8k8MkQs4tjf+xn5ubZLM5Vk/xAb3Y4m6ZGU7+i5OcyFQ1/?=
 =?us-ascii?Q?991HUgod2pDfexqkPS7WphFmjobjE1G6oBYNPgA3r+UH06tSrDR/8YZC6moF?=
 =?us-ascii?Q?o0V7mNsiEe7QixUEmZNPgOMqkWcWkqtDnrut/qM3OCNsb7xCD0ovHYHmPVIu?=
 =?us-ascii?Q?ti/+CBFmzFYMJQmUAO4g5gsUkxCRsIykJ3J5w9WKaYAGCECRAgtSgkhbyZxA?=
 =?us-ascii?Q?VB5nNI96EmAbJXJ3dMetJUKE4KYRrEJc5Rzp9FkFJmSqSanEhhAVqRRXJTMb?=
 =?us-ascii?Q?ZhIkcKvyPeqn0ZfpqmvqHjDAvXQwlwSxtQHsX155OlDCi/uatVA8L1sfBFQB?=
 =?us-ascii?Q?6+15kS3ZbWenm+HLY8iHU9ufL9vTNDoszfh26cS/9m0eF5pro0S2hBfikxwP?=
 =?us-ascii?Q?sAm0F6SmXHfUKff+CZXFZ/mnSDIzZTRuAy4eCSsWFfHwxOhV9yl+fnbW6x6S?=
 =?us-ascii?Q?CLnpRmgp3acdBILbrl0UBIL7QJ6kkaIV8ZEjZQc58e3r2RUQNffrsOMfint9?=
 =?us-ascii?Q?x+TfrzjYt5BZITgZdOB9LJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f166bd5d-8300-42d0-7547-08d9ec3e5117
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 02:37:44.1317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlLSJ2cj48UGktPnfyz3S+1JbFK9mOTpT2nhVWPZSKuJUqn5oJ0lFUAqX9vt/Kj8cE1HSTHUt/htef6OHj2PdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, February 10, 2022 3:00 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma5.2: Adjust the name string for firmware

This will make it easier to add new firmwares in the future.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index d3d6d5b045b8..2c0f1e84a563 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -138,28 +138,28 @@ static int sdma_v5_2_init_microcode(struct amdgpu_dev=
ice *adev)
=20
 	switch (adev->ip_versions[SDMA0_HWIP][0]) {
 	case IP_VERSION(5, 2, 0):
-		chip_name =3D "sienna_cichlid";
+		chip_name =3D "sienna_cichlid_sdma";
 		break;
 	case IP_VERSION(5, 2, 2):
-		chip_name =3D "navy_flounder";
+		chip_name =3D "navy_flounder_sdma";
 		break;
 	case IP_VERSION(5, 2, 1):
-		chip_name =3D "vangogh";
+		chip_name =3D "vangogh_sdma";
 		break;
 	case IP_VERSION(5, 2, 4):
-		chip_name =3D "dimgrey_cavefish";
+		chip_name =3D "dimgrey_cavefish_sdma";
 		break;
 	case IP_VERSION(5, 2, 5):
-		chip_name =3D "beige_goby";
+		chip_name =3D "beige_goby_sdma";
 		break;
 	case IP_VERSION(5, 2, 3):
-		chip_name =3D "yellow_carp";
+		chip_name =3D "yellow_carp_sdma";
 		break;
 	default:
 		BUG();
 	}
=20
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", chip_name);
=20
 	err =3D request_firmware(&adev->sdma.instance[0].fw, fw_name, adev->dev);
 	if (err)
--=20
2.34.1
