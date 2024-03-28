Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EA9C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 06:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31DF8984C;
	Thu, 28 Mar 2024 06:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tsvr7+Em";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30568984C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 06:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MewQwCX6UZDeFFfdNAZiZB9yydrhTRQvGL7YD9K6PJq162rWP3/gu/61RHms95HjLVKB2M0wQdzqzUFe+oPgtIkFiDnE7zPkN3VAmF6dmJJducRAPiW7hJ4e75NLDqI14lGLdD8+WkcsjRvb47+mFjDwCwdWlVvm7W8JA96bUNj5KjDDmNlx/gpXTeskoyt4Jt8SKssxPfwgh2NbvGOYWJ/6wsJZcAIZ9ekdY+qOaNnWuiuk1oValQ9mlZgMNh9y5qIbM8GXHwRz1a0GbQpNxD071SS0RZZkGljE14qvQ4NAYYtEa5aIkatRu3go8QZEmI8u85JeQQ86KA4+DhQ4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA+g/aN1vHHzvVyoJdN2fG8/HQB/ijs1FUEzofFnCJk=;
 b=gXMrM/1wwEOESBpYyFQALq5yz5qzpBfywMRHpAg2u9+WKtVegPhe9j05/UEZFOrg0omC7nQikkMNfkQYdUBqoiLEc+erTH/mydnNiR32Ot2N78ZqO+HS/fVWkFLTioVFIkAHdR1v4xWffQZmwvtNBCx4xXxD7lFJAm9qeitXn7ROuspw1uEFtMaQ0zL26++gRGngu8ELLWRYkzieFGxM/UXGBZxcv8/YEijLVtsEogzj9ao1r9vR8DdU8QsnhA32FjTqCxu/Mn+8hOe5Y5F0XeysSn6tGb9OrFBXf75THX43009oaZYv+PnAPdV0JVYCPs5GMt1Jq05ImbbgijtuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA+g/aN1vHHzvVyoJdN2fG8/HQB/ijs1FUEzofFnCJk=;
 b=tsvr7+Emg8EUPzQ/ljw3Ug/XGSHb77yQITZD27lU3T+fOEPFAxE7ycryVtxH1YHD+zG/m1n+WtqscafxtjuVz37k+rVdO/yRYIF+/s+cQw/1w4dPhnSC+VtFpAwpCZbnue+6HjS6dsUQb6MZwg4qmTmzkTEV+883winMHMuYvKc=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 06:02:23 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19%5]) with mapi id 15.20.7409.038; Thu, 28 Mar 2024
 06:02:23 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Li, Roman" <Roman.Li@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Subject: RE: [PATCH] drm/amd/display: add DCN 351 version for microcode load
Thread-Topic: [PATCH] drm/amd/display: add DCN 351 version for microcode load
Thread-Index: AQHagL9F7v/H6FQKykmS0Gwm1bGDUrFMqT1Q
Date: Thu, 28 Mar 2024 06:02:23 +0000
Message-ID: <CY5PR12MB636933029F46C98E4C4CE040C13B2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240328032234.3466383-1-li.ma@amd.com>
In-Reply-To: <20240328032234.3466383-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=851bc658-9ad5-45b5-a234-47bdafa9d701;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T06:01:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ0PR12MB6925:EE_
x-ms-office365-filtering-correlation-id: 7f0b7ccc-adc3-44b1-5162-08dc4eeca2e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhoVNj62tyhN3R6sOAaDAH8sEeYxQWc7Pqf5rt59OZLxw5LjIVRVRicMGw//gtMQR4kqrwxS6eeWISADN4ADJbxWLv5BxgFYX7Dy9faCnH4fkEb+caaSU+0uBSsFqi9+syvIS8f6vxXQWEyAwvfvI3y+DubUO+zF1lLJLh8CeRymNgvq1VNEefUX5DTYOII3NluxVNT4/7f88q764LrLwy0Ywj8dbLRqsET099eaylVV85qOcXOKeEPJxuNWCJLClF0AVYu3Usk2/WOUrVSc0B4nuKAONjHSbrg/kUM8eM4NoFN/OPzF3jlfbeTW2LmxMkDFE1D8FrDJq5BpvhZKwUepG8QqMkN0g5q4q8gHyEIPv9aJ/RF6LPQ+Au0mp2UMKTwSqtucXxND9wMZxfgtGa8d30eRZrYPvyMuAaqisA7lZDspIgWmo62iU5wkORHHUF7MZZ0KxyBoetWI/aGM/mvmcBoQwpqdXwwF3SbCSGuuFPLYhCyOIZA4Mste//86WxNwclen8U3iCQ8hd4CMxl1u1FpU6VSn29LUO+RWX6fL5iRoWPBC+RoQQMNiO/PJzEZ30WVprvi8zOYVtYFKWQGiV4lVFA32ZrBDbtKPqb2Ej2hVVgs5KLJSgYgSoG5qGqX6N6mokoDzbwqbDFAVAIPSv4PMvwl4oKwTWlthNoFPNodJL8UEtGvmNKT6u6uPVm2Rscpol2i2aabUprohWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2tmctBbO4EDs8hTmv+ltQoaoM3hEj8wog7BEARTOB8+0c7B0tHneygEG0mWR?=
 =?us-ascii?Q?mWeuXqiKAFcG2wj5xFI0lX6HbzHk5il/1xAa+9tcLWSH3p9rGRGec6bBka3Q?=
 =?us-ascii?Q?rg+RaDFQWWTtwks/TLVfA5quIMcwyqDa8ASykNMM1F85JVBoVKkanz2ET10V?=
 =?us-ascii?Q?w3s0sQ30IIeLuIcSD/t4X8XSi3kH7kTP+L2xp7Muahu552YWDX2czvAjr6MY?=
 =?us-ascii?Q?Hr4rY9MrTg1Jh1yFJfMcM0r2PfQODbbrw4xZ6bG5HsErYF7KyjhQKNe6/5we?=
 =?us-ascii?Q?/zo9gnNafii8c3Kzmw2LgyfX4pvYHovosewOLNeyn/bn0nM/51Mlb9alLGzR?=
 =?us-ascii?Q?2dBgOOYU8M+aNPel5SwTJyPENpDyAqjo7BeJGtOykfQwFAcAUzLzWzRnjU+5?=
 =?us-ascii?Q?+MiuaxtnM6baWUeptr6VP/itBbegdzdArVTA7r5U6hY8kxPd7AlP5wRAffmq?=
 =?us-ascii?Q?HynZwXdUpzs7bmqlaQalL/+YgrDp5GktrTUeVZX7i066+VxmjtHdbx/+zqKU?=
 =?us-ascii?Q?gufnj0luYGNl2nrTF+ZEqjC0yvVYAvZVeeUYL21IZhWDUshKaH0WSXGnx73y?=
 =?us-ascii?Q?gZX4XWmzbTm2LA/nMogDiLsQdO6uihM8XM7fPxSVzXlCKoIbFecduHe02Zcb?=
 =?us-ascii?Q?dQydESAQz65j4Q5FKXSQtgfsRdMU0KoAk9T6jykkO2cbJtCFRUAziPT7VcrT?=
 =?us-ascii?Q?iIbTlw+YHbUURR0POztlgfxXK4JTmyMg/gBoZL8608dvngNO8rh5MfafGVRp?=
 =?us-ascii?Q?YhRDVX1UoWhGZtzoKMZGfG1Ef3j/b7ElU27Z5ZoWQk98KqWSJC1gl9zGY5yR?=
 =?us-ascii?Q?nPdVHWWQ8Xny9S/34uC3aAK1KFy5UD1ifKY8EtIwU18KRVQn7yn/h7f/RVYP?=
 =?us-ascii?Q?FyFDDjlZKXC8prfWwaWUhqMJSmcoXwqAic9nPjidp7p9LqHG7Gbaen1+P72E?=
 =?us-ascii?Q?Fx/Ls1ShZBVMrP4WuU6Tc7wfbNVc+rT5S0CiU1umfsFGhY0aMAUGosGL9FjG?=
 =?us-ascii?Q?pMuPTjOr3oHs6YCn5FdmYoOmgYyhUMke/EojVAxnjUDZ4A/p+ugf3LsLs0Xd?=
 =?us-ascii?Q?d5xsMvNPQfXAShHzLQv6DnO0aPvx70JMgdPfEOY6ROvhvj3uOEgsyPAdMLnq?=
 =?us-ascii?Q?DdDM8qgqepZQ3JZUo4tFYueuJ2WeZxi3dQo3QUrPAlphllB7ga9gfbbKzXW7?=
 =?us-ascii?Q?EF+0EHAKoxG3NPNazxEF5ltvf5TpU5XtTvHjn4TwhjyclQnYkRdfSJTrSjTA?=
 =?us-ascii?Q?Z55dDed5dhAUVvtjBZ67uFy+sWRXISDzOl9RWG+jt2AsxVGGEIGnhH3GQ9Lg?=
 =?us-ascii?Q?1qkKkjkFyZQW541/EoE20PSTnTXgqp3SxTYgA9+3hLa3LZF2ie4Nw0WbmbC4?=
 =?us-ascii?Q?a28ZbiLwp6oijc5awE+dmiruKyahmuaehr844BikXRbLfVpGPiP2fud0BQSf?=
 =?us-ascii?Q?n+bEhTpa9fjcjhraSegfvL/GLUTlIR1UyNFUJoLoEs0toQGX8maiXGtdPPjn?=
 =?us-ascii?Q?sNrzdIb2tIWzG+m+QZYyJuDuDSzSUp0gbqCD4mJREdYHvxbbf2L3EmxmUE8r?=
 =?us-ascii?Q?kF9Ohd4xxT1+WSVwci4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0b7ccc-adc3-44b1-5162-08dc4eeca2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 06:02:23.1415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0PcmAM3C+sV9WzaqPJGZ6MDQDZTqxBZsfuyiukt1WSyqXsCPOtyCS5JKy4+3L8m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Li Ma
Sent: Thursday, March 28, 2024 11:23 AM
To: amd-gfx@lists.freedesktop.org; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; =
Li, Roman <Roman.Li@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amd/display: add DCN 351 version for microcode load

There is a new DCN veriosn 3.5.1 need to load

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ef546932f6c9..d98632f37c0d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -148,6 +148,9 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 #define FIRMWARE_DCN_35_DMUB "amdgpu/dcn_3_5_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_35_DMUB);

+#define FIRMWARE_DCN_351_DMUB "amdgpu/dcn_3_5_1_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
+
 /* Number of bytes in PSP header for firmware. */  #define PSP_HEADER_BYTE=
S 0x100

@@ -4820,9 +4823,11 @@ static int dm_init_microcode(struct amdgpu_device *a=
dev)
                fw_name_dmub =3D FIRMWARE_DCN_V3_2_1_DMCUB;
                break;
        case IP_VERSION(3, 5, 0):
-       case IP_VERSION(3, 5, 1):
                fw_name_dmub =3D FIRMWARE_DCN_35_DMUB;
                break;
+       case IP_VERSION(3, 5, 1):
+               fw_name_dmub =3D FIRMWARE_DCN_351_DMUB;
+               break;
        default:
                /* ASIC doesn't support DMUB. */
                return 0;
--
2.25.1

