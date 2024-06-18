Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB1AC2BA18
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 13:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E1C10E106;
	Tue, 18 Jun 2024 13:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xW6iyIwB";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942E510E106
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 13:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGUs1XON0qoKs/zIKpG//4PsIK0EeCLsmdn1EZOX0s7f7+tF1r0Q3otggi+JM8cf6QpKJRPq61Gdf9jozuqpBi231kSOh4yP9qadIUP3BBf5MgSqy/477K+hLpNGpgoQMI7YJy+3555c8XkIIFCHGrZ+s1dZgJPK058w9RHwusT335LPn6rrf+jXshDqF6wIfD7XGsfOZqDF8WWSOiAvHkupqxBuu0m+k2yUUu83IRClXRNRvMsHXUJTnocqSxTzBg5QoNcZbrL9NNKJSPD5etBK5MJy2uTBmp95Lv+bXHXq8GqTUe5tA2xzr8PbCqFJfvpR8YPhiVYqZK51qbxwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFZy0v/Xih7G7S9kxfozy6G8WgDn+HgEPVnOZrWnVK0=;
 b=krpfQiFcM/xRq9kbZ0GV4BasEaSguKKcA6kU06G4PQhwj+T+hBHqSSf4GR1q0GktfEDFlAOn1dX665nKX5aUnNBnus/oZdqZkfBfxe8/WwCifrG8BF/mQuf6zrnIF+vWSlvZvb7KzoKjF9Ga0U2rkAR4TB9hn5jd+H1Zt4ta2h7mUg7VyafeT3NeZ9OLiwDH3xvDNLnvWwa+AtdP9SJgRq+0U3H5QEXC3SW2KaZb+MGRddhRlS+HZPkCDeDTRoD8Dw05mCpA9iNDm6m6cioBE8+1HDyxi5F6keKxsQ0A/6TM2jCdk5toukiJZ/dmXX3vvv9acFOPupuIn7lBU80HOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFZy0v/Xih7G7S9kxfozy6G8WgDn+HgEPVnOZrWnVK0=;
 b=xW6iyIwB//UGpCpf2SL9LP4b/Y080lQxm460xuTs2Z+pfFM1POPqE7LZ1Xi5lZkLA2fEuUBSe12LjdL5Yf6WA8TnC7xNlxBqVNqmucxlD0syFYOPn7Fqdj7/xlgYD07HfKq7lFKeli5wgeUaMtqPldR/QyLueb50KiI8YG5EuRA=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 13:06:59 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:06:59 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: update MTYPE mapping for gfx12
Thread-Topic: [PATCH] drm/amdgpu: update MTYPE mapping for gfx12
Thread-Index: AQHawX/dRd5WBcibiU+GxWxHWaBA4LHNfSsg
Date: Tue, 18 Jun 2024 13:06:59 +0000
Message-ID: <SA1PR12MB565900CF1142A9A43F8B0921E9CE2@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240618130033.3721-1-Frank.Min@amd.com>
In-Reply-To: <20240618130033.3721-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=50346356-e01e-48f5-987e-0e61ff1c3f72;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T13:04:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|DM6PR12MB4076:EE_
x-ms-office365-filtering-correlation-id: 0d69269e-cb3a-4975-aaa1-08dc8f9789d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?wRJbTqZUE9+mmpstmjK+gY9rgT57m9A77c6P6rIyqSPfhFrcHCgWjVHyJ9FE?=
 =?us-ascii?Q?vDLJ6/0hi+/JfLl+35qLSsy1MhhRiGR0KMHbyZe4pC3VvsKLCG1qCHVYZMXj?=
 =?us-ascii?Q?WzmnESn6W+aDrjR9D9G3a71cO4LzARDrZYVPE3op5XI7I8Zk2EHEn+sAe+Bb?=
 =?us-ascii?Q?ufb8K/1QVG8Us38IQfrwLbyn/QitAhjkp7qRvM5FEOnzZ3U+ffsTIgu8JYCU?=
 =?us-ascii?Q?/hSzHotIbExZgjFAUDg/sPMody4V0YS8EeBZmJNsoyNlUkoieZUCLo34Hm4h?=
 =?us-ascii?Q?UZQJsxaP4+4zaKrWzs4VInRQII6Wt8WDw9nLDKLjll6E/v9VOQI3liJ6/Sk/?=
 =?us-ascii?Q?B0QK3ld50I47D/ncrsA0+dvbPgfaz34upWW2LOM4OefVAgxgeqK8Q5cEiWhJ?=
 =?us-ascii?Q?q8aybIDb4GOBPvhyUjDCF+nVgOeGYYO+aUue1aWOSa9qwzUkErpLpyporVNk?=
 =?us-ascii?Q?ShpjEzhN32NaDcsxugndx6IRDAw1dh1odPoQDmD6OQTfZN4/rnIPBWu5bp52?=
 =?us-ascii?Q?htrkcj4vjbwW5K1NLEVWV9JufdgY97AxuPOmarBRr9tEK3uFrjOC4C5gnocs?=
 =?us-ascii?Q?AVyIlEpkNQOeF/ktw25do604e6k5+7kA4weez3LOFf/P5x+puy3ZfwG2Trif?=
 =?us-ascii?Q?saMEqE5PGq+5tJYdaXPJENgayukLA1EA9x5xmzzA6R/HDWqXDt0LqT/BIZ7K?=
 =?us-ascii?Q?AsyT03F0jSHFRCoDSMxS3DK8tHL43buffPDc/g/FQrtq89XSpUkcZgtPxgcQ?=
 =?us-ascii?Q?pL8+NWX2e2uJOB2p35oH5N64lNmqqH+M40Etn05iJBX+KhRVsVlPlRUCLJ6I?=
 =?us-ascii?Q?txU8l+BIuv5xPRwpvYs8qE1W4yyJdp9V0CzW4s/P1qG0m6URE/hhzYvNovmP?=
 =?us-ascii?Q?dEQ3mXMXlUmNR6G0Qs/drW6EHGhFx8PDhDL9XqfF0NG4cIaty1p7mTrqZDk7?=
 =?us-ascii?Q?NSdAtoSxvj99NPGO32SKRVtC2/lCj7adYGyDmflGpbzTyoWELODcT7aNNHzi?=
 =?us-ascii?Q?Oa4XFsVn9JG1lvgt+UMyg9tGCuRtBE9sBe62hwJLtskRsAh7uf+7gbcXbjSX?=
 =?us-ascii?Q?/oe+FeH2jT9CBZth+gBa50kITCqCbmqGiMVFcuv0PFV8dyvmDN87s3m7vBNt?=
 =?us-ascii?Q?0X0PiHtxthR6wphi5Xl43bXli+payoYelYrBOkT7JTaLoOTI/n+O4G6N7mgz?=
 =?us-ascii?Q?gAvSP7DcQgIddZAdeuLusA1gJDps2GJQX1znAWQ9X9GcP9o/LKC0mCLld1PK?=
 =?us-ascii?Q?g7Kw6OtiquWtK/cuf3nmRFH5ngjLNsWCjhvRm4M1o9ourRF3MGlOatIlK5p4?=
 =?us-ascii?Q?uNTWVzvUZtGyAK7HeHEIP6cKSWQeoQNZglqf1jmbzeCx6Z/ewKJ5EQmMVgly?=
 =?us-ascii?Q?pU8f0iQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qyRvrRUjOFFjqxJwF/EuIRPOrBmbhYPZVqi/GVljGITgJEGLIr60T2kx2jH4?=
 =?us-ascii?Q?x+ocsehRLih8XbY438p5Lt12qiQyHJ750cbfdyglznX3JcMmFCIEFGotdIwI?=
 =?us-ascii?Q?JzP/yMXBjQ+IkDMJNjsxwK4H/MgcmjDshIGiCnCyxTOfymcwb99Rdzz2Wvd2?=
 =?us-ascii?Q?3mFwNxf2cHnsulduiQO0oAWsfOZY6552H9wN3zGSnNPmYTOA08lGaLFGJHMm?=
 =?us-ascii?Q?LU3PEdGsQna525eZaXMyfCzdFh8v8Pwa9uZjFaw1BHgUV04tfqs/T+XdqX21?=
 =?us-ascii?Q?5XoNc0y5vxaP7CBbR3NsKqLfAbd8KC7aSEkLUeShF6uAdAo2hDLgNvYVwCpj?=
 =?us-ascii?Q?RfOQyRzScZshtIr3wB4lmUsrA3zudM11d+iZdXYOVXqMs/sTis7ChMlA0ffk?=
 =?us-ascii?Q?wryevZ+DRUciXgkaqat2i46O1uiWC1MXqoUP5afBPzd4sZanUkqwxgEruhma?=
 =?us-ascii?Q?1foTl7fyaBeaQU4+cTKLQggnMyVR01hTIxT5/oDmhswizpJfftP/JxEcYjLB?=
 =?us-ascii?Q?rmFlc3xBJ2vbC5AVax3FSDd5xNPpVAdlSaWiYB0iktVImDMT897E6bcAnQNH?=
 =?us-ascii?Q?FpfUaO9axjhVC1ewIIAELv546B1Oo+krew8QNHzRf6TVR5gD496dFGE8cJhv?=
 =?us-ascii?Q?dERLhL93+ccH1GbmTC3mhEzhfZfB7O8FRY+tq45kGRuIxg+Az/e2sT+7yiHe?=
 =?us-ascii?Q?MIGVZR2ZwKUaHBMWgpx54+7bC0FhoCWtLhr/ohPayhR7IS/uFskxQeb+kQh9?=
 =?us-ascii?Q?r26F6cjkFr3dZG9SuEPbw0WD4Tq+M2lVNIQagQdwSEOycMzVDoicRabj+NJW?=
 =?us-ascii?Q?b/8u4KB5dAQy9xqN24v7I62js+0HWbohBjQsSXSGCmu+5JKgTarGrWInEE44?=
 =?us-ascii?Q?HEAhPkgTWTb09m8GR2EVQZFkswAJUSKths/6Y1WyVqkffdysjerx2Cacbrfh?=
 =?us-ascii?Q?NAE1qDOIdtm4kjREz1vFV959xrUmhExwtphP7h6TDoCRdtJNmkEPsMlj6GGC?=
 =?us-ascii?Q?gnni1Sd1JYr3kH+7tGCNBPyfCBtfQWFtJVh28B4m10ShIac8r08G8S2GbCCC?=
 =?us-ascii?Q?tP2ulgyupuWy81XVQmTJ2agKjFkez8aUoQYgIrFWrlpl+nBIdUd/2e/e4o0C?=
 =?us-ascii?Q?Kns+f3V1q1FjLjYXA+7CSn8VvdXZ6nK9tfka8KpJseYTRbqOpFeMbl9Rbnoh?=
 =?us-ascii?Q?2VRXApNwCOb5AeSP9XFzuSh4P00VlrFEGhTVjLGPBAcgG3Jg4cWcYrYK2a0I?=
 =?us-ascii?Q?Ze9u7AIPgWhxMg/PiClDbOcCP7bPj4GAiiRaVwByjlJrymm2Aax5paSOsHIE?=
 =?us-ascii?Q?5oBs4CXDjEjyVs+t8PnSnTbqAuO/X6uJqfG5oAWZzzgqosf/1FBENA5yR0+P?=
 =?us-ascii?Q?RJ2uxAq0juVyA9e+3lnDxV/dIADlEIGLrsB4Du8ky91KjfmzFL08Jvzu33C2?=
 =?us-ascii?Q?ZIxJ+IfpQJj6VjmZe46QxX23WRBSH/UXkh1EZJ6SpAgNSgCHgryg+IfgRiNf?=
 =?us-ascii?Q?1DWbc2wkvOYc6bsWP89QDR5BzIPzveya11oUvTFyPHyy9QZ7gydDuwJZP283?=
 =?us-ascii?Q?JUT2L0gY80Yhk9lJ4p8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d69269e-cb3a-4975-aaa1-08dc8f9789d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 13:06:59.4728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5/OelQuDpqu2X/ZzSGhJey9Q57DJwhJfwRxyo5DzlY9yKmmfDtrERMl1RtkAltV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
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

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

gfx12 only support MTYPE UC and NC, so update it accordingly.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 26122c8cfcc3..61db331adcc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -464,10 +464,6 @@ static uint64_t gmc_v12_0_map_mtype(struct amdgpu_devi=
ce *adev, uint32_t flags)
                return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
        case AMDGPU_VM_MTYPE_NC:
                return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
-       case AMDGPU_VM_MTYPE_WC:
-               return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_WC);
-       case AMDGPU_VM_MTYPE_CC:
-               return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_CC);
        case AMDGPU_VM_MTYPE_UC:
                return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC);
        default:
--
2.34.1

