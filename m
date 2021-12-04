Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3B5C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EA673E4B;
	Mon,  6 Dec 2021 10:19:35 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B576E4CB
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 10:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLGx/Hq4SgeJuAdzy9PDg5/PdmiZvRd+jcnNnj3Ij/y2bQNCbcU9n5k2bRhO1BJS0aqN8/1iymqBujpb2ItL+8NrKLIijz2CpCyXOsE1hAy8nMgNfb+6ObqrAXu25mCYZ1Gf/Pn/dytantUFOcgAFxlrbNDysuZtCy7713qhBqdoFE20dI7Hq3O1VlrPoShh0zjlrWdMcD33Hc0FGlECO3HtdsX4c5DLCIAaHYF5PeKHNF2GA/8e6hW8dlCUvsyfpCs6VmGE4IAyxcEWz17tHHlHsDvbvw/gcHNXSXHMwtTiwbCVbX/gutki/Y4Vv3CI4KTybv/y6g8Y6ggTNadevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+Q4PK5Oc6fv2bg2LF4tzPVqcRww7ySDcwhaKi8RJNQ=;
 b=DjI1n1CIFcJFMXHWmPrz4MTU2JLxVAupfyGR+MN7Zd4Sgdb+Pw40ZXhS/e66e0M7o9UOFXDCwUawKeS+VP0uFx9z1XgmfqKzluSuwxAU2u5SjlfW4kj8N265tDEamyX2ZIf4tpRv19X4VM5hejDJimtlOpqRzkQN9TSwaP9fws0GeQ8XJSMJSkbEUYTQkY8gbJ62vof2uufbppzZqiq5u+sntNOdIuGJpLIsC62iuY9YVhPKurEWZZe424IEiiSTBYj6yYxOCtSWXiSfmQ1Vuv8SkK8DLka3R6ANH7ttDsmdi7/OAbDLkVR7w2VuUUNbH9NKXw0zemg6TIMAz6V13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+Q4PK5Oc6fv2bg2LF4tzPVqcRww7ySDcwhaKi8RJNQ=;
 b=LXcbiUNB8cDFCOJRKC/tTg4i1rpbX4PZviMrTbY6YSgVKgg0aoUFT2I2gNpmJq1FNw5ZlaKLcsZQBaZX5jgjx0qmELIi2l9sRWLV0Ig79qPGPNK/nGIPG05PACtXufMruhpjvl+Y+KLp5OKvQMqpGsp6f9jJV8ecz3Ey6iN1ciU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 10:38:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.029; Sat, 4 Dec 2021
 10:38:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: read and authenticate ip discovery binary
Thread-Topic: [PATCH 4/4] drm/amdgpu: read and authenticate ip discovery binary
Thread-Index: AQHX6PiiZXKk0Ow7kEW5MF1p2TTO1awiJBAQ
Date: Sat, 4 Dec 2021 10:38:42 +0000
Message-ID: <BN9PR12MB525745D2C205E18D9DB632E8FC6B9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211204102032.3063-1-Hawking.Zhang@amd.com>
 <20211204102032.3063-4-Hawking.Zhang@amd.com>
In-Reply-To: <20211204102032.3063-4-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-04T10:38:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4da70ee1-3424-4e5c-8ad8-da26aa3a3888;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb677b57-b6dd-429a-54ce-08d9b7123e36
x-ms-traffictypediagnostic: BN9PR12MB5354:
x-microsoft-antispam-prvs: <BN9PR12MB535479E1022D1484D54DC384FC6B9@BN9PR12MB5354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ew0kvWCDvzP4dyYRBctf7XegaTVJOBtiV4oGE8hucwgKp+4ozoYyl9dqUE7D+iLQmcnmDXddKzOZz7qI/EwJciBoDdbndo71tQm2LggYTY3GFAr4kUCwZA/x5vaR4MvWEAOVOJyNmb+8HtAxmIlECCCPJz3Cgd6B4UnzoxDq6n0vDTpAq7Jl4CbFb4kHu3mHObOlrzg8GIy6o5noaqPuX0RR8+WDzjtvSWP4Qtc/bL+Fj0SfuJTjoC1aQyDmnkD5Vfr/mOiq2ABRX2078eeGsvMEjixyMc3gMdv4ZJyiap/3qD+yMNe/o/zVEJLDb9UDbvcd3iPylEdJXEZenyGiXF8nr8uizjXnOFWu0CzSx+gMtheSO5Cj0VIg5IZMmfGyZ1KhZ9icgwJyZnP1XlZnE966QVOM52Io0S3PYtDxKoQziTogniPnPx5TlDfi/xAgmEsuKvnWBJNgxRjulNoMU6MGoUTiyWqUATD996mE+7EmAcJLdnJyDvOUdHfGlNM0DbT8GGsz5SoMAWpagxDNP9lQT/qNtjj92BCvKWgaVawqN+23KDJ/3jVtzUofRdW8JV8ZzVGDqlV9PIP2FlG8u/r0xrDXSh8ajsZIYlxK56c13us0F7aSL2CRf99/a86whMQltqaNMBy8pHi16xl+u+ZnHywGaIlhmXO6Gw5sBJv4sPmXdt+0HDKvJeFx+9Ay9JChM7mIMp5QCtXoNlkjXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(71200400001)(8936002)(66476007)(55016003)(7696005)(5660300002)(86362001)(66446008)(66556008)(38070700005)(186003)(76116006)(2906002)(508600001)(33656002)(83380400001)(122000001)(6916009)(316002)(66946007)(38100700002)(26005)(6506007)(53546011)(8676002)(64756008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DxOSmJNygLK/pXFqTMdrAYqV5dTp3+cRaHgss0Euc97MmYekv9ouioqTL9IC?=
 =?us-ascii?Q?+lINxRqdb+f7ZYGsUNj6W2Ftu5ZxhH+0kmxqsE/kSTvwVbF+BV7PiHYAyx0k?=
 =?us-ascii?Q?J7ijTmLKxzdZ4ls7YkDvwfAEzH8quYX4uXb0fUkVqtTZPnrhVSiMwBQnitdE?=
 =?us-ascii?Q?jooCH7LOp8qeVZO0bp4eq1AaTS738+gRP6ciN9lYfaCsdaz1si5bYayy3XiA?=
 =?us-ascii?Q?6yawJKm2pdDIHVaYEUtAvlsKZ/hpsmnJPraJiHQujIP2Ha62XUrm4kh5h+Op?=
 =?us-ascii?Q?RY5rxEPL44rVhuJQji/2aq+n0JcBYqSDEZ8ShrRfj2Urzcv2xB3wN0hTOU2R?=
 =?us-ascii?Q?k7ct87GEpyrYhvh94cQn37AJ3dUangN1UHe396HfKB2plidTG3RPD5h7qbEx?=
 =?us-ascii?Q?y8ofAr8S+3kFc1eKoZY/X91TuZv4sW1j2krPBJyIIbbNmsFdy+yec0Ko8aZy?=
 =?us-ascii?Q?LjHdO/Qk6P6rf+soLBUX9aswzs8iNwOPoKNSfBYySWOg2Bu4ppo2PcW2OQpk?=
 =?us-ascii?Q?rLCWwlL62u3zqYssyrqmRxlJN694nAUi5BlSC2ZwHWuCMuCl+Urz+O9jp3PL?=
 =?us-ascii?Q?Xse350kvWsHBmT9WSclOy5WBVdVY5g8xduDVNoFEoOfeIajdEBx9Ceh8tneU?=
 =?us-ascii?Q?AZC9zyxzyIdWbhAdtTN/T0tdsirwy8EPHA7LYIKH0LT3pfG8cCgY+ooO17Fo?=
 =?us-ascii?Q?Qulc86vlDilk4rC7GNqXsWIF/ApAylW7QS7yX2Rwg7pEjjaXkweQ0uvaWf4S?=
 =?us-ascii?Q?oLb6BzT80Gf5wvBHkh3xB53T0TrjunmbD5LAz/ZS3nshu8LzXsnWvMvOfrjv?=
 =?us-ascii?Q?YGTaUtwBwkaoV/fXiLb5N81pgjUNncA9U/tPFk79euz6hPm2fBZCAhmQgqLV?=
 =?us-ascii?Q?RjBj3+G1XV62o8j3aRlyXOAESFfd/DNvIIVvpwTN+slFGhoHM54g+3cmjC80?=
 =?us-ascii?Q?JjNzI+8SGVXBu68dtwo9IDwmxsyekUoFWiyshUDz6g2Ns52IVBH4tGNhXmJq?=
 =?us-ascii?Q?NKwsgRc/kW+Z9MQMnOr6xKRKayN9jN6K4qroeL20Y1fyaUmXq3l1eTOWSwaN?=
 =?us-ascii?Q?GV4exhBYIP2UP2HmsEIBsd5XTidvi7d7EX1xTweKSF0nWdjU/eee22jwMR2X?=
 =?us-ascii?Q?Dufb6X/OqCvpCY+8zVXNf4iAN6u70yyz8AiWDnQSdUwP3ugDUaLqUONXhrNt?=
 =?us-ascii?Q?JoW+/jZMF4KeXfMNwTgBw8ivSKod3fTZw7TP1VWRGDxxSAeVCR8/nGLNg4qp?=
 =?us-ascii?Q?VU35AJ0zgRUY422zhtM2X64vsuBySLw0Br6vrElGkgpgtj6Q6MGiqZjlimfG?=
 =?us-ascii?Q?7w/JK5kkFORv6ZgXTElI3k7/WB71oYD4fsyKvHwf9KqX4NJ5EQzqmdnj3/Qh?=
 =?us-ascii?Q?0b+w33P1KCaQjc3LGtZf+ln9aCmr74d/pTp+yWgx90SZmFdan7+3RwiD5YEx?=
 =?us-ascii?Q?jjCeMOvWP5tZrYkuS3iLbjM4tgAMZypMyolw0m3IwlsIA6tHon4hH+AOTZgS?=
 =?us-ascii?Q?8s3tiHaOIC9Y+iZmNOQnD2d6hzJLP26kKpU9AaCMNVd9cLW6pOalYbcp9Hpk?=
 =?us-ascii?Q?5NbeXK1qZglAvG6aeT9YedkBH8VXDzgGPiP+mPirfx2pvO7GcARpdfDbiKx/?=
 =?us-ascii?Q?Hn7XibRDiqNjL7C32/11khg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb677b57-b6dd-429a-54ce-08d9b7123e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 10:38:43.0270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63i3yuOEK7Md9BepBRiD8d0x9CzZdUxu44QkNR/BZqjRCfUnBKY5ebtz+LoHWZlJkjMN84S3zhoMSCYPF1AsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
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

[AMD Official Use Only]

Please ignore this one (patch #4). Will send out a new one based on latest =
code.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Saturday, December 4, 2021 18:21
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: read and authenticate ip discovery binary

read and authenticate ip discovery binary getting from vram first, if it is=
 not valid, read and authenticate the one getting from file

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 44 +++++++++----------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index f507cd70ab86..45f38ae6e53c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -247,7 +247,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct gpu_info_header *ghdr;
-	const struct firmware *fw;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
@@ -258,31 +257,28 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
 	if (!adev->mman.discovery_bin)
 		return -ENOMEM;
=20
-	if (amdgpu_discovery =3D=3D 2) {
-		r =3D request_firmware(&fw, "amdgpu/ip_discovery.bin", adev->dev);
-		if (r)
-			goto get_from_vram;
-		dev_info(adev->dev, "Using IP discovery from file\n");
-		memcpy((u8 *)adev->mman.discovery_bin, (u8 *)fw->data,
-		       adev->mman.discovery_tmr_size);
-		release_firmware(fw);
-	} else {
-get_from_vram:
-		r =3D amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_=
bin);
+	r =3D amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_b=
in);
+	if (r) {
+		dev_err(adev->dev, "failed to read ip discovery binary from vram\n");
+		goto out;
+	}
+
+	if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+		dev_warn(adev->dev, "get invalid ip discovery binary signature from vram=
\n");
+		/* retry read ip discovery binary from file */
+		r =3D amdgpu_discovery_read_binary_from_file(adev,=20
+adev->mman.discovery_bin);
 		if (r) {
-			DRM_ERROR("failed to read ip discovery binary\n");
+			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
+			goto out;
+		}
+		/* check the ip discovery binary signature */
+		if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) =
{
+			dev_warn(adev->dev, "get invalid ip discovery binary signature from=20
+file\n");
 			goto out;
 		}
 	}
=20
 	bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
-
-	if (le32_to_cpu(bhdr->binary_signature) !=3D BINARY_SIGNATURE) {
-		DRM_ERROR("invalid ip discovery binary signature\n");
-		r =3D -EINVAL;
-		goto out;
-	}
-
 	offset =3D offsetof(struct binary_header, binary_checksum) +
 		sizeof(bhdr->binary_checksum);
 	size =3D bhdr->binary_size - offset;
@@ -290,7 +286,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)
=20
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      size, checksum)) {
-		DRM_ERROR("invalid ip discovery binary checksum\n");
+		dev_err(adev->dev, "invalid ip discovery binary checksum\n");
 		r =3D -EINVAL;
 		goto out;
 	}
@@ -301,14 +297,14 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
 	ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin + offset=
);
=20
 	if (le32_to_cpu(ihdr->signature) !=3D DISCOVERY_TABLE_SIGNATURE) {
-		DRM_ERROR("invalid ip discovery data table signature\n");
+		dev_err(adev->dev, "invalid ip discovery data table signature\n");
 		r =3D -EINVAL;
 		goto out;
 	}
=20
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      ihdr->size, checksum)) {
-		DRM_ERROR("invalid ip discovery data table checksum\n");
+		dev_err(adev->dev, "invalid ip discovery data table checksum\n");
 		r =3D -EINVAL;
 		goto out;
 	}
@@ -320,7 +316,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)
=20
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 				              ghdr->size, checksum)) {
-		DRM_ERROR("invalid gc data table checksum\n");
+		dev_err(adev->dev, "invalid gc data table checksum\n");
 		r =3D -EINVAL;
 		goto out;
 	}
--
2.17.1
