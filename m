Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE42CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 10:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CF510E0F8;
	Tue, 16 Jun 2026 10:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oodwqoro";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71ADE10E0F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 10:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aekhhnga/HrN7nuPOtjAJVXnvhT3IEWyzIu9BM2vjgA7fcUvp5fkN264H6SMk5Wfghx9anx8YhnJMttHb1y7+tvcvloIl6AgXlCy/DGlqMd1Yu8kxAOFtzFOg0u8oW12L+73olw+Vw54xdH42UzJtiur/McYbKpYWzVLLCcSdLLG4HK3Dn63R/SxGGPZMHs4NyBbimzU75EaSeOxilpZx352k1j1trjf8uscJNxFqMakTFHiJX4wJbQyBQlXh3h+F5pwBg7KbAcNlX3Cj+j6gBTk4r5vKmyTt9FwouhD38HBINRwPeWydDgzFoWCu+/MNT3Kq91klSJt5iXgqVYe2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hR7ePjdjdplo0NqVrZ8BKtCPAYTzdSd8Z7gbyTnV8c=;
 b=OfYns9D1sNqchuut/5Bz4t93gtP9NwAHBgE5FJasnsJ3zAUQG1kGam9Y7cuakn7wv5HP9Vqbk/U9mD8uSw/DX0nyzsX7sl/b144+g7mBDWCbolWJ0xzef3oisHc1fVb3XHtxtMS1o5F6eNjzJ9Ft7evJMDw/k8bGpEa9exaS2nOF7FIFaMubcu/uZt0T+4Fo+lOlrcg6DuauUrS6+5PfhBeiHZybFKgnIKoz5JUsNH15InFO2eCEilN6CmMaq5mByz6rc5hhgfKZtLLzA+XBTMR8tUp+3Vu4z8sbn4YSMzVTDSxXAPOpcfB6c0FW/nJRbsTwsSP9N4jiXt6fbPwnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hR7ePjdjdplo0NqVrZ8BKtCPAYTzdSd8Z7gbyTnV8c=;
 b=OodwqorozzqtT+ja9sFizatNZXIPG8bDsc+expX3bSRiWy0gwL1UUhUVgbELvjHArmn1TdXcCIG86KbecDDMmOYcpoHOvZiXOm5wXVlGEdqxXTc4DksnxNCouGVieWs5LSJRqVdQtYqyMsLjjDFa5c8a4HsG7paoO4UpnU8KT58=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Tue, 16 Jun
 2026 10:19:25 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:19:25 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH V2 1/2] drm/amdgpu: add bounds check to prevent array
 overflow
Thread-Topic: [PATCH V2 1/2] drm/amdgpu: add bounds check to prevent array
 overflow
Thread-Index: AQHc/XQCjOgxxt5QoEyXLaUkbUnLOrZA+D2A
Date: Tue, 16 Jun 2026 10:19:25 +0000
Message-ID: <PH7PR12MB879616949E4FECF8A11366AEB0E52@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260616093753.4142104-1-YiPeng.Chai@amd.com>
In-Reply-To: <20260616093753.4142104-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T10:19:10.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CYYPR12MB8922:EE_
x-ms-office365-filtering-correlation-id: 950bcd57-f3d9-4ce4-16e9-08decb90bdf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: TIvgiQuLQOJFUENELjSWDfWylU7zAlj9i83v/LwpbncX3zz/VoWEHlSLMxE9t8aOf2nySSJ2KJzMJ0zrL3hyJ1PMBmx+UgEJ3BFzK4Owcj6/fOQUe+HafZP21iSPvQXGT73IBhcJs5+3fOW0lKxwwlssw6veNr/zm3yLHrVds/npkObtjIiyRyPKBI4vSZW0RnBNSg5gJDvnSoVfzl3EygDgPBqB1dztvHiprGi+U8yJsqx1D1TAvUyCuYMGrvlw/oqKpPr5xCJsUFdWRSFXANb8fXf2WtT2O2e4JpJjJpaHRym7XkpQ1WhVCFJaoKFPJoY3aAHLBgSBTx84g/3rn6FKFLSedb28dw2ceJW8D6oagRDrl3jfIBktNmHntDocLGIy2KjzuBbb4QKtcHADkIqGfRakUj/V3IOfJmRbLIt4r3ggnT5MiJEYD78MkADkO3jgmTH6iEx9FI7+HpcHFlb3BxTfzqbANlmpdGDeKbT0MpMA5LSEPRH98cGU34amx70UQQYLj0IQAG0Th1Kocwb/VnlNQbuzkUkL9GtnKEvjL+ldsm9J2SZaIEGYARYC00COHfIfOqSaJinAaAFkFuhWdkFcpJ72UgUXov3dmw60W9Pr+fV4XO/lnrvADvN7tP+K+bsdVf63q+TYyKRg5Slu68ix21v4E+pBSO28uZIvsTxtJckZgYIV7zVE/SOND9uKbcmUFL7TQkT3LX0Yc4jS1MWz0DOnIaY92GAKNQP6fK5YDTtR37pOAEKRGous
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lmLbd1K3lrsmvXJf/7Y9oGms2Fbe+GsAjwH6nJ84PZZ4+urONMY/ZF4DNvxM?=
 =?us-ascii?Q?QRmiivJtsFdPDi+rQxXAuZXphy1+XnS4X/vjlOqFPODGL9XokC2alYywTk4j?=
 =?us-ascii?Q?3M7KI6c1tYmlgSJtPtCcpL2yNAaFj/SdzefmDOu/o+/lu7/VpVFmHB0I5JuV?=
 =?us-ascii?Q?0AV6sigs2QHbpU/lvFY4lqjoZwzp3cXrM32IlajdrpuFy8gPiuNvn5H3igxh?=
 =?us-ascii?Q?Fin8DX1Ft1o0dlE8OdihT1sJalrM2UnsoX5vjpqfWgoVfFiNrDiULr/4UWU4?=
 =?us-ascii?Q?mx1DmjKUDObaaVM/2htoKPLOJ19ats8EcaPLnFDUGbbpGE2hiHtIP7Qk8QHj?=
 =?us-ascii?Q?5Qx2tjvumKZrVl3JQ+7UN8Iz5RaGL5cPCsass9eLj7QBmVUybOUgkor0uoft?=
 =?us-ascii?Q?lmzmdHeEPYe2UXf67vzZiOzHfzlWOrcJrnHXUkEImw7jCY8WA1snWZtfaKSf?=
 =?us-ascii?Q?Sk4kOoL2G0+Pa2NkoWK1dkg9YBcYOBTfwJJZo1Qch8lH2n2zXZRIxkWN59St?=
 =?us-ascii?Q?qHClhtBNMURsUp/zJjAJTGjKVlEXcJrglENHXxVKZXuaIMobwSY9GMgYOnnr?=
 =?us-ascii?Q?9bfEp2ckUc75pwvEhE+KULbrS0RD9XAh+p0N+ZKHiZI5/gQsfFrGmKtnM0Av?=
 =?us-ascii?Q?zrQbvznmM/Se0ora8b/Jr2XlVR9THmVKYZS//Lu3TFokZ3KNcjLV8G/YwWRW?=
 =?us-ascii?Q?KhDzF8qIkHKIe5q49ws7OMCg2FCCKYEFlXqiOzoMvwFn4+DUfcKgdFUx38J1?=
 =?us-ascii?Q?P2l3NC2ML5XZmmD4lgjelJwXaD/akBAkoi5r4Km6PlTBbU1NuyvWKDU9a9Bm?=
 =?us-ascii?Q?kHLE+mplAD5hXabaA3IrXh+RtbqWRKL3oTncgcwBmTOxR8Mg1gdevQf9fkOt?=
 =?us-ascii?Q?c2DDnnENaU1OaZL7lc4ZhmdWUlhr0emc7cGcluTJwtZurMq3Cc4J+4H1D5Cr?=
 =?us-ascii?Q?vUPPw0y3MswdQQjlshdtR+IBWpiFAurjO5+dih93VKyIm9QAYn4XrA9j0quL?=
 =?us-ascii?Q?uKrPlOpDkEE9wg4wRK84q2dU0gFMLM74GDwjmBH3IhngPZIx6O9yaINcYvtS?=
 =?us-ascii?Q?DKMjofqhtAM2dLWEosYBGqQySYw63/qlIM3D74q/ccrseAS12XVYuibmxUfj?=
 =?us-ascii?Q?5W2WZ7xn+56Clx1bLvZ0kPyl6VD4o5VezFHEE1CxghItA/teXSAm+y7wiXwy?=
 =?us-ascii?Q?xPVxr5Wvfs6flpQf1azrR2UuXAsZKmTTbGMA92Acls/83SB6n95b3Tk9Cpa0?=
 =?us-ascii?Q?mO6djS5k6FPwc4dwbq3lorNMET8pA1l1YFdq4fOniZo/Q0meKBCrUgPCJRSr?=
 =?us-ascii?Q?pdJAeeMUcrHq9ZCGsAqARrcPKHDyBlBryp96q517rriFSpzJMTeLvHivzM1t?=
 =?us-ascii?Q?KM1NCFcCcNph2zfXQGYc/PsxGTTIIwwIUHekCL+JEXwL61e4nmBCy6ydYYrU?=
 =?us-ascii?Q?o0tynkJtsf3wdzDMG69Pvoa3QdWH0dNZAFjJpPtOEs+8DVTdpKYag8chhaZ3?=
 =?us-ascii?Q?5Tb+BILAgExw1sZA3oghfWl9boirb7roBOkA6uW49+0MzK1CLvdP4M/StZrc?=
 =?us-ascii?Q?aEoMgeH4PRgqMmyF/iYjpVJVbnyopysN3aV8bF4r2Mno9xnShl+D3kFxyhWz?=
 =?us-ascii?Q?3peGtiibSd+oPKy792CDwiza7IrKNlBT+4VpDhBw0IcLMIzawel7HZbkyjRF?=
 =?us-ascii?Q?KcYnCRYeCk57v+0qirNNSyQZjqNi2KH+k036kRMEqQg00pKK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950bcd57-f3d9-4ce4-16e9-08decb90bdf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 10:19:25.5759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5J59qzVmmprOErCZm9D5zHzA7QWtyTeMsNsFLRw+LBW4Q9rJegr3iRMexPyVYcky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
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

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, June 16, 2026 5:38 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 1/2] drm/amdgpu: add bounds check to prevent array ove=
rflow
>
> Add bounds check to prevent array overflow.
>
> v2:
>   Add warning messages.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 94ddb8b98abf..8a49ae4c0132 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -5064,6 +5064,13 @@ static void
> amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)
>        * Use this list instead of mgpu_info to find the amdgpu
>        * device on which the UMC error was reported.
>        */
> +     if (mce_adev_list.num_gpu >=3D MAX_GPU_INSTANCE) {
> +             dev_warn_ratelimited(adev->dev,
> +                     "mce_adev_list full, skip notifier registration (ma=
x=3D%d)\n",
> +                     MAX_GPU_INSTANCE);
> +             return;
> +     }
> +
>       mce_adev_list.devs[mce_adev_list.num_gpu++] =3D adev;
>
>       /*
> --
> 2.43.0

