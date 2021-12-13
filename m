Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E5BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 15:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C26E10E754;
	Mon, 13 Dec 2021 15:16:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F9210E754
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 15:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeNPAPbse9ia+eiIoMmBZI975zpbRvzzuAOep/LIkwzyJpMWIE/xEPcaa8gg6szEgcFHAf/40qbV4rDnE4DkL4AOB5RfCXy8XRlvmCRRrCxVwJkdNeg8pPM9RsYaDhZuZy5aM+E4Ejk9zwCsmkgfRK169hbA2Q9j7Tow9e1ObJK6XU/eLnewxR5YqbOY0xyTl5ReK9Pfr9gWXP4sYi5slKIDO1ZZjvxX0AR9pkVEvCZfBvzKp6i2TUWgaFbQu7hMUJraGvEl5Ht3tuZamIbRU72dYl/qPx5F5q7PSSiZGvwwMMWW+PPBgBDzds1dReDk+AWwjpF8DjLbLRoZnbkxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV3Sx9L43TFeiWe164KjAZH3Kj5NVZb2+2sFhhpTnkQ=;
 b=XClwfJYus2xmb0dwQFF9tk0Ln28dylrlUSsy9qHVnDMJXIzd1FOTT/dU+XU4rO2Bdt/yHn7bTKbqYm+Yp04DElxzFLkYmnR6d+xd5kXH1miu4w5n6Dpq1QDjzFWpQjbaaW1uRtaAep3/vFlFG8nNHvWlLjHO7QFuKi/Wf7Y47TLbkYkpW/PGN+3npSGtGDKAXDpRbSBKBDG8tin60Pg5y5ZPOAOBxjlSWdLQ+nagq0iCreYzKJZZk5ikSKeDvsAq+VPQTmyoPEl/C+vkhRFbYDSp3OBzRg6kOYaCIrnBqdC8QHHbtQjfmJufh/rXeONT6P+zVWQ7dk8fCqAwT5ICOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV3Sx9L43TFeiWe164KjAZH3Kj5NVZb2+2sFhhpTnkQ=;
 b=O8rYKNKhj1XfdEqOfr08lYZ+C6YeoIE5At5YND+3WeU46lYkotbVKxbiABLzebppBhTHATkblc6sbgby1KgXugvKK2ZIg+mcPt3MwZmibwBEH1qGyLlJUH7iUdTfsSZYUkB0gPJxm6iGCl0+Fcck2tI6QcUrWz1KyzqsJBLn/0M=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Mon, 13 Dec
 2021 15:16:05 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 15:16:05 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Topic: [PATCH] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Index: AQHX7dJJ9IwUelgD50GS1Bxo5rEZQKwvyWaAgADDl8A=
Date: Mon, 13 Dec 2021 15:16:05 +0000
Message-ID: <SA0PR12MB45104FD2ACE2C181F481184AE2749@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211210142848.7784-1-mario.limonciello@amd.com>
 <DM5PR12MB2469857D51B76ABBADA5BF27F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469857D51B76ABBADA5BF27F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T03:32:30Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=02185718-ded7-4174-94c8-fa327ce0bbd0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-13T15:16:04Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6a47f498-bdf2-4752-b82d-89768aae1513
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b6ff8bf-e0ed-4702-951d-08d9be4b7bd1
x-ms-traffictypediagnostic: SN6PR12MB2830:EE_
x-microsoft-antispam-prvs: <SN6PR12MB283007B765B92F4DBCDCF754E2749@SN6PR12MB2830.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/CWarWEGIjvyt1dnTuJS3WbXO8racZOygvNvfWSbecWK35PM+oRNHUUS6kicrb9BwIQc6qdLr9cw5u1Nbjggg/jBfZECpSFkQM2VP8maBUcJiG+c5+iILagE0bpIP05Idhkv7cr0tCrpOngqJQeATD96WUIK6tTx+oIl21bgzPsodj1efgNTVEZXFAAAeorJN2BNy5Y/nsGNTDoTPuwmNYtrJKK7/sy8fj+/49Z6dKURT0+0z+Nkydc9s728L3nveH8mXUfPU17BGCJ+Y1+7khzLamdNn3yuTfh9gyVf1SEkwp2d+4nwjMCGLqjXFbEfn7KJIKVNHNiLDUfkpkzSuONOJZ80hnpO9N9tldHpC8ok7SUQPPFkVN6xwnu8abwXZAOYv2Xe23sQ7C1Nln0zMaP/M7eKPQGpcI2T+in4K5WKxyceVqxj7y4Kr/qg/tHmGDPctD/w/nJFFZ3PbC2b50F1xM0Bv6x8z3Mn5Wu5JSevDrTFwO4kldx0vklJgO5DTELBlGv6QgPguo+pqJ5AjyFojy2TaapEayOcFtapBmBevc7an0DU1C7JA8QaP2qJg+jIBWFAImM+J2henV0yzS2/z5HkIocsQbZwuSV6N4vqwkRIo+nto8nxfyR0zN542ZPhDAkARkmjbonlxBOszVZMr91g6R87LF1MsBQYt2WUTzwzZox0daLg2pveDvDMy+03ViwolotYisKxFpQTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(83380400001)(86362001)(110136005)(26005)(186003)(5660300002)(55016003)(8676002)(33656002)(66946007)(71200400001)(2906002)(122000001)(508600001)(76116006)(6506007)(9686003)(7696005)(53546011)(52536014)(38100700002)(66556008)(8936002)(66446008)(64756008)(38070700005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lyUW/Qc+lt+fp4S+fvt8MQOa1umqxq4S0fNTkrUJWEmg9cnbSN+dC7i/sGyv?=
 =?us-ascii?Q?LHz5NoyGb9pSXAteJGiuGlXfP4dH17A/BTNrA6Qkcw4gu0sZou9R/h9u+8it?=
 =?us-ascii?Q?sMtWfW2JxVPL731PnOLSSJsW0+fLaAUv3DQFFPbB7QdW8lYVWGCq79AwoWRP?=
 =?us-ascii?Q?jO8Y4C3SmZQyP7cKm99LsirDrPClOS8UgOd+iSTIMYjWe/UMWwSSqHvcRbwj?=
 =?us-ascii?Q?0a0n3A7meoBRuaYjrtfFviMHbgfy9Fo1qnkkTxsmZVPIrmE2B7F7acXvuCTK?=
 =?us-ascii?Q?vBDshEKyGxfcjMitJA08YNLPdz2tjzyRU6o2cPjS1eqgT0y3lO66qlNFQHjU?=
 =?us-ascii?Q?303/HcCSxNT1EgEGjxiAGBU3nKVXKtv/ylRf7jJOAE7JJ2n/842zxY2ndrSO?=
 =?us-ascii?Q?rf3qwdUWxOtmZcSmao7ikhI61Wf+bQAtGSd+2izJEi7Gh0agXTzt6ukZ8d8G?=
 =?us-ascii?Q?ulIXSu05eNIzlpqkoO3HRvNl7CLK9He7ECWOSg/nCospC9byZO17yIGQmmha?=
 =?us-ascii?Q?TdSP4iK+gu8O3VT4wx6teo8U8EE7ZSxFnE+uODQ+wZCrZ4+WSeCxbAXqrVOH?=
 =?us-ascii?Q?VMSdil3s+rPALpb2hQiWvpQXrrVXVqLeEXhsLjrsA5G9loXYKdW1HEqkAbPG?=
 =?us-ascii?Q?R5+Dh/4MrfYbEBA6BXAjBEfh+Cx/PwGinoeKBHL6H3IEkiZ2iCGOIsRcRVqd?=
 =?us-ascii?Q?noT91o9WvfHD4FxlkHWOWJIneWE7dEiXbWg7zMyJtOGROP0eNQb6iQmMjkBL?=
 =?us-ascii?Q?q2UxxyGRlYbxjafTWp4Lb92YbcmBsxee0caZIXoV0sRndQYMTD+3kdRZIDsp?=
 =?us-ascii?Q?HMtFMqGZqzf7oNGhg+IfkGhfSddicBEwajSRbTdo82I7WguIBxb/M1VavotV?=
 =?us-ascii?Q?gSUWN68wckSzwWm8QLe6noPNdI7iSDq1R1rJGoNZBi+nPoMS3x4iy9Kn84G4?=
 =?us-ascii?Q?FVrFADwF1+Ak+1Mc6Kn+VeyQZT8pk3vuY5tDEx39FPpr/0b8B3G8ylKA1V1z?=
 =?us-ascii?Q?s255ygnxiUotP34x0VSvkccgKJtdAN9Evx2v+lBmf/UIzDQZjlMD/npyeVNR?=
 =?us-ascii?Q?VC188pg9+KizAIYkOE2xtdD/GcCU24/mPxYJ9Dq0Y+CVjMX5mPAWx1i8esK9?=
 =?us-ascii?Q?Y6nnWz33BTdRwcax70ivYJJMaSpW8FZEBw9jNWPGaPn7HohcgSoojnxliq2k?=
 =?us-ascii?Q?PSuvn7UC3P3KfxbRtveVjgS4b6yFxgRrYXTpysz1sLrGe4d3X97MPfZZUnmJ?=
 =?us-ascii?Q?UNC1bMpV2YM2sQMqHo11eUsIhccFhMT53HOzGT2FCIR6B20W13w/Elleb6eT?=
 =?us-ascii?Q?M5vUGYsm/VKObOYkFoHM75ESfrP4e/ID35uR/Pk2qvirY4L9DBYvZJfcbRGP?=
 =?us-ascii?Q?xCk159eON1I7kqwJpiSvjVbWxnx70HYKSpyIYWWalsEH6Ac/2z2a6OUwFj9Z?=
 =?us-ascii?Q?MFkC/qPRMxk0JKChDYFLzXCXHXfGEkRMpsRA/ymDGhlq4YXLHOyGHC3yAv1W?=
 =?us-ascii?Q?S2jwWcV4Lt5x+HEDVIqRMxtCNXkjazFvObbuX2b7NTrvWvjtrcndhw9IgqpM?=
 =?us-ascii?Q?FbYQECnsLJ50yHZdk94+wAMoKY9pihg8S6h4U0mO3zrdH31cwDr1wD4oWy8d?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6ff8bf-e0ed-4702-951d-08d9be4b7bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 15:16:05.7897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0GblfGHDLnBu/ynXjHUHzr6evHrW10rypLqd4/nGUyix6K0QSuCt/5zFECRMChQRXPzDsA03QNdo42cPrh2kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
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

[Public]

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Sunday, December 12, 2021 21:36
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: fix reading SMU FW version from
> amdgpu_firmware_info on YC
>=20
> [Public]
>=20
> In SMU11/SMU12, it will cache pm.fw_version unconditionally only in APU
> case. So we should apply the same code in smu_v13_0_check_fw_version?

Thanks, I just sent out a v2.

>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario Limonciello
> Sent: Friday, December 10, 2021 10:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amd/pm: fix reading SMU FW version from
> amdgpu_firmware_info on YC
>=20
> This value does not get cached into adev->pm.fw_version during startup fo=
r
> smu13 like it does for other SMU like smu10.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 55421ea622fb..85dbd6a7efa9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -226,6 +226,8 @@ int smu_v13_0_check_fw_version(struct
> smu_context *smu)
>=20
>  	dev_info(smu->adev->dev, "smu fw reported version =3D 0x%08x
> (%d.%d.%d)\n",
>  			 smu_version, smu_major, smu_minor, smu_debug);
> +	if (!smu->adev->pm.fw_version)
> +		smu->adev->pm.fw_version =3D smu_version;
>=20
>  	/*
>  	 * 1. if_version mismatch is not critical as our fw is designed
> --
> 2.25.1
