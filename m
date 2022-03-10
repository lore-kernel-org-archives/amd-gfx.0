Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4BFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 11:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F157210EF4D;
	Thu, 10 Mar 2022 11:39:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63EA10EF4D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 11:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ/UhT9ZPLiMq4qxlzxy7uVjGDAtFEoAKW51skpHSDXfSAZa5bCS+5cmsOETrsIWCjnTUjqaqYjX8t+adVQYy0IlnUWnMNhYwUHis/V1YfJyhMk+e96gqMWg4w/n823tdvlO2qPrPGOB90Tc9Id8gxDCcitZnHSLIeCLTjiFnCod14mzjtox/3Gk7/7EHKErlOoGHOyvzJfBo0Qmf9A/oJTundILua/o8FB9jWHGClOwX+MuBjlaITfgAk0HBGEIXM0EMuSZ4BlWWC5CwoxT8p2tmVEuCdz4kccI6bby/fAQAeMI8F0YglSeAUnpbYD9mTn1QuVd0wkBfFStngWefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkVP+GJULYgL2C1m4oJV/zU5WsKeJSImUhU+2L9DTdo=;
 b=K5ie7EOlIO7DmfvJ9Wy4xHscggpNhS1kpqu1xPRA1EK0aMUaGztwgI15pEi3WYwdo7Z4NNa2FYTwU4y0FXRTQzx5xwc+7WYDiquL7bsDc1p4QcY/3q08OK8Y6m/FVbyoNVmM8pguyMrQho8TjoZmUL/3kWD7DH99V4/+Za5JIVqqtTLDHi1WcWW0VTi2j/VkWyIfXTo3bezRLQvqmftZnTw2AEivV2xnb9er35gTzthw0NpZwhfTLqOLhXTE1DuuzJBMGDciXfEsQpMcRDnNgjJsD7vtpj0gJi4tcG9fvDZtX8Y+dF45sNAcmxwPDoME8dzzSLk0v9RLL30FolN2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkVP+GJULYgL2C1m4oJV/zU5WsKeJSImUhU+2L9DTdo=;
 b=396c54uYwv0+G8wurGUYApfRfh0hUHZAwiJefG5EC31e0HiKu6VkZAR+2VYiFpe42/6ZZqaq+fzJFLBNs5HI+nVcCfFc/y2OFlR38FN4/bfsYb2OFDTvb72fm2eAMGDOSYRc21VPwbRfwSfPeF05oxinp+rPySv98VaVvEm4SAk=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 11:39:52 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 11:39:52 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] umr: Print errors to stderr
Thread-Topic: [PATCH 1/4] umr: Print errors to stderr
Thread-Index: AQHYNBfFPf9Riv0hQUqKzsZdZASAKay4fstv
Date: Thu, 10 Mar 2022 11:39:52 +0000
Message-ID: <DM6PR12MB354745589A9C12D7AFAC9524F70B9@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220310004226.50895-1-luben.tuikov@amd.com>
In-Reply-To: <20220310004226.50895-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-10T11:39:51.783Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: fcd23cb1-5969-1fb3-a730-9aa94ac062df
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 702ec864-2c26-4a77-dfed-08da028ab0e0
x-ms-traffictypediagnostic: DM6PR12MB5534:EE_
x-microsoft-antispam-prvs: <DM6PR12MB55345D7C1C5E1BC4C816468EF70B9@DM6PR12MB5534.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ken+HOKm2fCirHjus7zI8D/hvyzCSS1n/Y8dVsT2ShEfaR6Kam/3ZOb+nOBYhSvveKnbOZoTFxxjTyMKNMtJCzSYnkxqBSiLvKKU6ItNrb0BQyqMc/pv4n2w8K5VCW0tHEtqvrRZ2Xwa/GqtF/kHM9vpaqUxYlR4uU7SPR0kS1a408Nx1qeNJZJqhrnRdjLMdmPhOAVqvHko1G1aQmUpwp4XXzkvgNCiSWzCag2WYwOdq9f/ZKaCIePO57t130VdKhUDvfD3aa3eY/N3lfGeVMwrG61PSPYhj82H/I/oU3aSXHSCA+d2w1UE/UWyoeKYFezE75lq2V6JIXkVFatgWKyVE7UBF8ycdgRJJCz8oEHKmab1PbhJx4e3O1/RPkOqYGF+9k480meFoJX9vBg+Ee42YHPw7/a1a8lMZnGzwgcG20tgc2c8NTbaerbqKhWNY7sjJfb1raNIaU1VWeGXouDcbvN6i2nFnpqCZHqwX2MgSCjSlcfY4MYdR34e5yl2mjmHZBKF2bwoZcvehVLaJm9XVc93CLAOHOyu6yHH3wl0O1xBx1b3llbZgPNxgc8cSa0qE5OgudBHwxQ1rZgWEkn2VuyJD+oAK4j9krHkhDVX8q4UiTIwFHqa+ZJVWM+SCrBKrD89k2j+2k5rhACrDYhYCtEIjXqjgGch9dxU2IV5wGsKLItpyG6F2kEcX9QwEIF+Vw7ZkJSIPCteerMs8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8676002)(110136005)(33656002)(38070700005)(38100700002)(122000001)(55016003)(186003)(5660300002)(71200400001)(7696005)(2906002)(6506007)(316002)(83380400001)(53546011)(86362001)(52536014)(8936002)(9686003)(508600001)(66476007)(76116006)(64756008)(91956017)(66556008)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QzDAaJFNFPH7kEHro92pvLB9hQJoCGQ948Oau0GlsvQV7BC61lrZtXdrmY?=
 =?iso-8859-1?Q?jMn9+V8Qc9ABpZgeG5mcKyCBMXVr33fUyX9lBeaTXGu9YrIPp6+VDE+B1P?=
 =?iso-8859-1?Q?R83WV1GEiuuNx5Raqj+AnrkWh8g56FpfS4uIrMtYq8EYO62jBOx8052Qu2?=
 =?iso-8859-1?Q?o84zdqsAbNVPdYQePGNFsG9ClWVf36amnDVRs+hMRI6tDbfQVlqUNUwyOg?=
 =?iso-8859-1?Q?qV20X/+PYn7rWVcCAy/X9GgoNuMk/P0CfVjq5hfVuE30KmukAOnInVtc5a?=
 =?iso-8859-1?Q?57TY2meCdnN7mTSFQoBY9J5TemVf+bZ2lnxQwqQmkGrt19Hua+/oT4yP72?=
 =?iso-8859-1?Q?pa3Fu9+F3gYPHFxlwucTtOVGF/YFoPF5vzxAm5csjHSvG6Ohq4whz/HrnG?=
 =?iso-8859-1?Q?ZU3mCVjBA35C9hzByJCP8RKegTIRqlsVatZ8Ytk5Ncua6Yr4LuFOyg2+OO?=
 =?iso-8859-1?Q?TNhAyXSemv1T6NruzYznuOI7KkokVfvuK8WftplwJuKoDTzxsUPCsGIZ1j?=
 =?iso-8859-1?Q?wHsNIpx598PXVkgN0tGgnVqh5qTEsyVCUW1YdnqEzAi+eAGKyaMIfXIjJs?=
 =?iso-8859-1?Q?JFZaePPET6PceGPksXRovmbHqqrEH3eAAKl0usP72ROzaNJk+nI6KOHA0w?=
 =?iso-8859-1?Q?sa4NS/4jW4wXBqfWTmrEkPRtzsRXt/3yDDcNaXOOpo9qTBybMd5wvKujfo?=
 =?iso-8859-1?Q?gq+nenTAz/ys5G8u3sIYdKeN9pDtb7YfBnjKnRAN/X3m94fFFH45NtXfVR?=
 =?iso-8859-1?Q?sQ4YmQspmmnuy5v6fll/UfD4PfM2j/JuuOENmKnG5986vaJ9nsvwE0HXpJ?=
 =?iso-8859-1?Q?dpjOeDPnRtLeIMJ8d3U6mronxmN9lhjUaAGSZ4fpfuhULRX1O4deWMbrsv?=
 =?iso-8859-1?Q?tT4fAHaBad1fzRBuHtK+Kiy3AYIIjjjteDmlVZbhdDlpJxx2Pl5Z33InHZ?=
 =?iso-8859-1?Q?mNzhAS0Rqrnppy+3AlVrriJKWAnp6qfS6QTTPpKtT6Wjy67an6TPooIumX?=
 =?iso-8859-1?Q?0Ni8MzB4csn22CZ58VToj5YG0HrqrzSQ9vNi2XSPWgDCEmrqetDUW2tbaH?=
 =?iso-8859-1?Q?Cqkk/8H6ClUo5McuaQSD/RHaXrAYyD4gbekJClTO+frbw3H0CpT51bYYg+?=
 =?iso-8859-1?Q?75Dk0XWj/rok4uAl/cs1I0cDRj9nMa+iO9y9xZABirLwsVuBTN9buJ11mj?=
 =?iso-8859-1?Q?ZN2z8FV5r7YUatG6HgrJNClOCvsIa7Vvv4dtd+PGfZwoGloQW7M+ypMaMS?=
 =?iso-8859-1?Q?GoVdogFvPcUrrIlQVnRw2M+7o/luDFWl/G42qpyZFlEtHxJu654gTRGVgu?=
 =?iso-8859-1?Q?xHJsI3xMfVOeO9mnIa7yvux8YHRtGnSKnl3xyba4Rt3AmjpnGbPapTjRo9?=
 =?iso-8859-1?Q?ziK9GtEdZi5pGXsK3YAVetsCdqK/fFewZhngS59BVj5mR7+PM+hqlt4M7F?=
 =?iso-8859-1?Q?PE446Qm+uSOEVIW2J4Ed4fhS7vtHjX4JiNg6CBLmHp2UNPD5zqtxiM/hyZ?=
 =?iso-8859-1?Q?hc6K8MYtX5sV1uylMtAqLzrGUKwX+4u/22l6EUS20/R98QVCkK1gYg/NC9?=
 =?iso-8859-1?Q?x4EZgyS/nDdj2p4gCNdgIHPe/Je2qYuBRuUAzN/ApgDmhqsNOsmDfyPybI?=
 =?iso-8859-1?Q?v6IeNNVk8py5WBGm7fJGH8S6CVMn82shJAjubHzU25RNR2iuQlYYiI1XTV?=
 =?iso-8859-1?Q?1xnT4bdYXBjq6zjUumVAQZrrui/ZbT1V0WRNA3mgIrLFo0sCqrmigAWFsz?=
 =?iso-8859-1?Q?lVDw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702ec864-2c26-4a77-dfed-08da028ab0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 11:39:52.1678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKFxpMy1Z95vtsQxpT+t4B6jmcn5go4DS6dLHKFFTyTrxHeT4d/1J37hKcRpV78KBHJuZtH/wFsRgEkRW+mbww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
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

[AMD Official Use Only]

The asic structure has a function callback "errmsg" which should be used fo=
r this.

Tom

________________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, March 9, 2022 19:42
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben; Deucher, Alexander; StDenis, Tom
Subject: [PATCH 1/4] umr: Print errors to stderr

Print the following error message,
   Invalid gca config data header
to stderr, since printing it to stdout,
confuses parser scripts.

Also modify this message to be clearer. For instance,
   Invalid or unknown GCA config data header version:4

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/lib/scan_config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/lib/scan_config.c b/src/lib/scan_config.c
index c7f4e9d3c69faa..3503bbd92a104a 100644
--- a/src/lib/scan_config.c
+++ b/src/lib/scan_config.c
@@ -122,7 +122,7 @@ static uint64_t read_int_drm(int cardno, char *fname)
 }

 /**
- * umr_scan_config - Scan the debugfs confiruration data
+ * umr_scan_config - Scan the debugfs configuration data
  */
 int umr_scan_config(struct umr_asic *asic, int xgmi_scan)
 {
@@ -246,7 +246,9 @@ gca_config:
                case 4: parse_rev4(asic, data, &r);
                        break;
                default:
-                       printf("Invalid gca config data header\n");
+                       fprintf(stderr,
+                               "Invalid or unknown GCA config data header =
version:%d\n",
+                               data[0]);
                        return -1;
        }


base-commit: 818bb1e8f1b5a26fda0e3d7abfc1e68605ebad28
--
2.35.1.291.gdab1b7905d

