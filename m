Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BF8CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 12:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD1F10E073;
	Wed, 18 Oct 2023 12:32:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA84B10E3EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 12:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5jGceK6Flg3BKeAi46PjoL8rQaA5mh5Np4lCJQRM6d8IWMrPV1Ou3y7hxDtxa7i4aBYW5EXAkbbDPvTNq/PFJ3Vb3edotkB7VH+mhgtEQFjC5qmpozf5SclArNq8Zk1ZrzFp0oRTT9ErCTgeV1W06OlT2o8gg5ILGm9rT9U7WhDuIgUoiEvcfH3Al+7yjSyeYPdJpAJ3X0V+fv3Jz/ag3JK8jy+QrBUEV4g4aUzauDa6yQKeE2dIgofcsI3dOYj6dEmvZA7ZJ/qdBIyS9t1NS+S1QdZ+4XOP+o0qMSa6jUuYJNerawH5qd3RQHPw92SFTrR0dxu7etWCEB3bPskrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz2XZKVDT7915/EMxRiU+hDoDySAI00qHcRdkKwYhB4=;
 b=XygE9eWZqSknGtMU7EjH6rmgH8x83BRgx1+35/7risrE2F+7LK+0meA7T7lhkZLos9MBxwIGt7loKtmZSokO2Q7qDngwherVYCqVsBpqvcsstVDF/Xudwv5mBJE0J0PXTnoLP+JxYJM69ZQRdyLWNDGiuKQS8gxfkrBlQnoA+IfxhLoR4kI30Msi7GDKwtgBLNq1Aob3tCXLT9djpgDspWFX5/Tf+An5Va059Ua266iFioTycJt2E0KuGwkipKGdyiCplQ3tjIAizzhQKBLNRdXCrLyoHPq53zH/53CFrB+/pV0h6qwBtE0djJgVwnJmTOYYYxkfw/ZI/55PnPCuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz2XZKVDT7915/EMxRiU+hDoDySAI00qHcRdkKwYhB4=;
 b=HgSDRJwhlFooUjcEvfA0JaMA5uBp+i2IRkGRNz5EGmoUamovoJMLAZSh6Q+V097CLOPGQGtfFdS1za0RuPI1LhUyhnakxlxhlda4TtS3LbXjwZcDi/+Z8zPqo6VDdyGKQ5VjaT8ZEMKgHYrqcFDRBFRYrzs8iTRuOUPm2Pr+8cY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 12:32:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 12:32:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Enable mca debug mode mode for apu
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Enable mca debug mode mode for apu
Thread-Index: AQHaAb2sax0olyubw0irPTq2knuxF7BPehRA
Date: Wed, 18 Oct 2023 12:32:51 +0000
Message-ID: <BN9PR12MB5257DD3940257CCB5A081ECAFCD5A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231018122134.3280090-1-Stanley.Yang@amd.com>
In-Reply-To: <20231018122134.3280090-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b9e6a19b-e0a3-4ed5-9b7c-8c218d5c7427;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T12:29:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6063:EE_
x-ms-office365-filtering-correlation-id: da7dcc22-b41f-4684-755f-08dbcfd6586a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YaV4wWEFK0uZNP+qCLUav0L7VQ6vlpJgc5oi2Szf6RvRbu8IeCyHoYJu2I6F929IUeq3R1w8okShoQwvCFbDJaCSAEAKvg+37l/YcGm5G02B5sDq8/GoqVsNvsK28V0DuiMSqFSg8HB9N4xTd9Cu0djk3d72ZU206fXcCEGrDrnOXk4bOmJLctJw+rIkUNrB8ilQSXnzsYytsuRXbrDGQbCFW4+7HJKU6xk5g3Y0A25c7fFuUbdu7lQuI3r++cplQbdewiJo0PKJ83hJ0bXfUBKMUCUph2i2JDWrCPLgjOwyzukP+Arha3dWwqBtGtRJJxfoey5m85tvOKa6ySNO4N/MMhSN1zUO489rEaCRblLLNpHBOidxRoRgek/Rhhx/CFcCC0yRHUyN/NxzeLUet2grYwavTinnLHctq2avagm1RgqCqSrp9lbT+zU/EUKGmosb17ceOCyLGbYiPBRnbUETR/JhkxbKMfwtotcG9ewM8CIBArfVHR6DIgJCW1MgO8cmjxyMYMJk9KtDKzFMe6qu4QTqhTiC8lONqUDyd26EVGqv6i6FbvMDDpcF+j4QfsybrXCOIJvXgaapPLWwRkcepLl2L4IggvZvgO5jV+ktg0J9SMl8G7diBnfrzT6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(86362001)(2906002)(55016003)(5660300002)(26005)(33656002)(52536014)(41300700001)(8676002)(8936002)(4326008)(9686003)(83380400001)(478600001)(316002)(71200400001)(53546011)(122000001)(6506007)(7696005)(110136005)(66446008)(66476007)(66946007)(66556008)(64756008)(76116006)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cULLHRdEjHMdH4efK9FcDOJEUPV3bhthJo7EERjQmPw3PDB6jYmkNI103e34?=
 =?us-ascii?Q?KIIDNRUZOJ0gZpSOPT5YDC23acV0MFK8ZMgpXrcfRKSJg7Rwy/kYD30csXnV?=
 =?us-ascii?Q?eYJ3u4pauhHJprWr7AhKu1p8zX75r6ZxLfgQfDiZAsBdfN7WfbiKOH2FID6M?=
 =?us-ascii?Q?mQ6q7gbsrgp5Z2Qg55Ch3ccz1Wl6RAnxfx50diohRKARxMYbfl07uRI6qLmJ?=
 =?us-ascii?Q?Z3q5x4ps8TuQQFNxpwsxKhgj3vcegbE8zdcjBiQU4+rF6lVu7wIkb+HFGfdB?=
 =?us-ascii?Q?i4dnZqfWPOXahydovL4nWrSsSz7jAJJ6ReCDFcOMdEJCN+JhdZ78GMMi8jkX?=
 =?us-ascii?Q?xs8Pg8O4UyhTmGRc1G/lUTTkj0ZIh4rBS8f0NHt3naontBbmpQwY9xNmGyH3?=
 =?us-ascii?Q?yK3ldvjK5S7ZUh0doqTNRxwyDACiOPUlTXi0Q1v8vxXvZ/ya3KCZ/AtG3R+A?=
 =?us-ascii?Q?onHWsoH9RWGrnvEDOrkpCufnTENuuwB8DA6t+qA68JzlEOw805ue/66M1yTi?=
 =?us-ascii?Q?xBSOvTVbq9ueHZt7j0JvzvaWTY39goBLwXgbVeSr6dWp/pl+zhozDTa3Rb5b?=
 =?us-ascii?Q?2mn/Y/InieS6zfe7q14b3NKYspPCzZ1ihzWoKlEylZZthuQawyYKr57AdUwv?=
 =?us-ascii?Q?9XdPkZKF2BQw9sAgjQ5MvxNBSw9g3bOSzojKQi0YUcbqPOUVBhyAbtrtO8jx?=
 =?us-ascii?Q?LdK9cC7IGHhegGqN25yi4EDVBAve6rX/856NpvQDGP2YY5iv3693d65zgF9R?=
 =?us-ascii?Q?AgygjNOQTKCz6zmo+GWAASIDr0ajf+WVNd0EqBJrOTKH3pU71CudBlNlJih3?=
 =?us-ascii?Q?jOT14FvHPwiVkRe7OYNu1vtC+Dad67OUUM/S+mhNtSCl213gqQHPol8zNAGD?=
 =?us-ascii?Q?IXCUdvZxN7y/tQVN2VdktXZJ83kBjqljp3bOYXgDVycno6QnLON6P8Tlucwj?=
 =?us-ascii?Q?G15pq0fq3Lp9gV/yiUic2MHQt3Ig8eL4kLWMbS+2fYlDX9HRzYyd0vAxllFm?=
 =?us-ascii?Q?mdRCltd1qcYrjETvDpOI0g4HbyUio1XTa5sprxGCzDy5sZYUYg6vpofnyHC6?=
 =?us-ascii?Q?z+YXFiRinPR4wmIoyidPyC4iefcDYg5/1BsxPNJSQa3W6vk1bLOuKQ1OB+LL?=
 =?us-ascii?Q?c0URSurcGXNVoyY6+FjBEaiqm5VMLgedCFLT08qQfrS/9o9toDvu/5DPQyEO?=
 =?us-ascii?Q?RAQI2X9WYEgNoA39IxITios+RKTeO3tncA13eeyjBaTz0Hmk40Ku/Uj7RdT3?=
 =?us-ascii?Q?7emlavHoy72ZS3+ak9IfWl0LdBvg/Y+HL8OrIsN/Hbt6bioULTuRbeAT7ofQ?=
 =?us-ascii?Q?g04pazC/FmIzt59CCDnEj6KEGVg/L1DRv6W3vWLoyrqsloePx6VHgajy6ENW?=
 =?us-ascii?Q?rI0U+H8zpxbMpmnBevVrgi8wTN7TcwOsVtNFmflKzPCoehml0Pb/MWeOOREt?=
 =?us-ascii?Q?3+Qk0/IUDa64bqWfSn0e1AMwWvim9lC8mOtyTfZWQ9nlghoNFpcrsuCbreWo?=
 =?us-ascii?Q?tcsNVSNbYTEbXHFQbIDllP/PGVMxAlsswlixHsclFjXP2pODU8eIgVyu2/FZ?=
 =?us-ascii?Q?2y4isjt8qPPnA7tLGK0qx4B6sKvcZ18U7pM2v1hZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7dcc22-b41f-4684-755f-08dbcfd6586a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 12:32:51.5834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZrbeY62PEkPRI59VgwqekmeGHChuPTFj1amYEMtkn3JGhYBXuGonoZuUFpizv/2TLNn+UHWvAcc19fLA3+uTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Let's not rely on specific IP block. Just check adev->ras_enabled.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Wednesday, October 18, 2023 20:22
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Enable mca debug mode mode for apu

Enable smu_v13_0_6 mca debug mode when GFX RAS feature is enabled on APU.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cab5a5569bc6..62589ba3c4a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2298,7 +2298,8 @@ static int smu_v13_0_6_post_init(struct smu_context *=
smu)  {
        struct amdgpu_device *adev =3D smu->adev;

-       if (!amdgpu_sriov_vf(adev) && amdgpu_ras_is_supported(adev, AMDGPU_=
RAS_BLOCK__UMC))
+       if (!amdgpu_sriov_vf(adev) && (amdgpu_ras_is_supported(adev, AMDGPU=
_RAS_BLOCK__UMC) ||
+               (adev->is_app_apu && amdgpu_ras_is_supported(adev,
+AMDGPU_RAS_BLOCK__GFX))))
                return smu_v13_0_6_mca_set_debug_mode(smu, true);

        return 0;
--
2.25.1

