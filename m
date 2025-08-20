Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C24CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 05:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF0210E350;
	Wed, 20 Aug 2025 05:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ex9S/3Vk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A788610E350
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 05:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc0FZUz2W8/qPQF7u9UVo0zThYew6U1zC8vujFYDEgohLvi7bLoODgET9IJ318BESmTP5RA5jMOgH0zDAT9990SolEDRuGQx99LR1Iw2P2CbxqPm1HOMde1GMPnaB56I0umF79NXBR892o9qZ0CbFJyJ65DvCFhRMZQqfbHjZfHbCIwXRePkcc94tQ04sy8Q6pbKxl+bk+macZRt/Ff2edMocYN0CB5aT0qS4q5ZNr26d0RAcQzQeTS2BnSGUUC6Uh70DfnGAEHxa3chQjoq+hx31DLgvuEDqgpGZw34Sh9dlMWx965/UyHZ3y0CptGVbT2hNH0PvGgg63x2lQm6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKDQWLmInep5kQGJW9Mq9PwFPe62KxcRd9xzryrc9Tk=;
 b=bzvEDu5sQwKiFjy3sBIy0DzX53ylkcl3Xn7NWzAOJjOUVf5EEbwaPdnHM7SFH+IOqy0GyrOu2alJgTb/6Vd4ADT2Hgzcy5wwJ1yXbjMU/mwyZjgxs034RRm+zqhu4G0Ghks9f4COY8k/i1Y6V4F/iibKs/DnwyuBV3ml7BuaNVngiYExEU+ZLLZnkEM04o+SbiNPWUQ9GGwrCWvLF3WysjhVH6o+gfUw9rkLdYy/ng53JW1+Xya9QQ80d4Gd0VmtgHV234RTXlXZwrxvcqk0G19d9iMx3O+vVdPN2dZTyhvEaIMIuI85dQagmIX49kRmH6MkCLlhOTs1QqLX/LU+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKDQWLmInep5kQGJW9Mq9PwFPe62KxcRd9xzryrc9Tk=;
 b=Ex9S/3VksuHdm/fO4sGJ6sIaKn9Uki6B9WhssWQ03XYtxzreL4T6Vqm16WeEBAwihpR1ILfm7jrRtFE51a4+5BKYesr/df6Xls3IgJiixetZfFa4POEVV6a7rROTd6qz25dRy1tRjzbr6jBlyV+7WmRIm8IRCjzpYrjlDZAdRLU=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 05:33:32 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 05:33:31 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Topic: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Index: AQHcEMnH3hRnZo6IxEm6T5kGcGXV3bRqxPUAgABBCLg=
Date: Wed, 20 Aug 2025 05:33:31 +0000
Message-ID: <CY5PR12MB6345B07E614DBE882CE7FF2EFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
 <20250819052548.124897-2-xiang.liu@amd.com>
 <BY5PR12MB42125F685673D0BDF0ADECBDFC33A@BY5PR12MB4212.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB42125F685673D0BDF0ADECBDFC33A@BY5PR12MB4212.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T05:33:31.2010000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|DM6PR12MB4388:EE_
x-ms-office365-filtering-correlation-id: 6dbd5431-c73b-4cb1-969a-08dddfab1975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KGxqdiL3UdzdGtsZpYTGr0xQNXz2aAGPfFLgR3X6Q6llBtBF4D52HtH4GZX6?=
 =?us-ascii?Q?jkaj+vknxP9eguaXIADZstqxciLyGYtv/HfKmL/nwlN9YFYqiV/Ii/6aTFek?=
 =?us-ascii?Q?qwsNMPvoV1hbLCkOKHBy7IQfZ7wZkZdnvoZoWtkgwFqH+KilGG4Zc54c+G/H?=
 =?us-ascii?Q?OM2WGd5zxMSGiW3GdOzBoY+cIU1xHDPvXLLsP/SktNxwS2pYpN6sQ5vZQU6q?=
 =?us-ascii?Q?OE3oovw21c9GW9X3pYiRCsJ7JSJfakCEL9h8BbFF4wHpe8WVSBLaq34UpGbt?=
 =?us-ascii?Q?drEEYZk4xyC+u4LhWOr8QJuqD4upCGBgNzpmkvc2X16xGKGfRwoDlMyquhZg?=
 =?us-ascii?Q?jFtDJDC6isK9kV9YrZIKwu/R3JkTjqqS20uFRaWLtNneid21XSgdH2a3FH2q?=
 =?us-ascii?Q?1HWQd8xN/wvdPJ/ts5Jx2by6+r9ywLry3Kyf10o+ZY6gA3yZLrwwurNqiD+O?=
 =?us-ascii?Q?0qejoCjSM3Ou7MsijED+ukwCWGsUTVLoUUX2vh0UuPOFat2pqjWU+a99Zx0j?=
 =?us-ascii?Q?a6TVrRqiAPheDqR421jiAolwZD3FnzkLJ4Mv5aunxy0ckbGkybKPk6PzUPAy?=
 =?us-ascii?Q?UrnlaSuAiHdwIkNB8Rk3QVJN/s9n73USRIneflcU5v++2NQrLE+7ASDvs1UC?=
 =?us-ascii?Q?8BXtmcOj6OXcGUl1tLIpzl8nGqf3Cr2QZk9L+3qxB6OomEMclOplUb6l5vDB?=
 =?us-ascii?Q?K5uCZAYmoGT+kSSnz5s6MjrqDLNYgkcE8Yc+EOYX16e4e5INVBLJwn/AVg0F?=
 =?us-ascii?Q?NGdantjbrGAJM8K7hG+dEIgMC/HC6nDr2ItK5k+uHhlQnGcGmPp6NUMS5Ydp?=
 =?us-ascii?Q?TeLpDltQloZhSP5kG+bki1N2wjW3lSCKN5OksDOUg7bzggcv3cE9TGRpDKUJ?=
 =?us-ascii?Q?knc9fLZlq6P6WahrWM8HJqCC+u5GdquMoZYmzaKy8JXNcpANswlUAanXnh91?=
 =?us-ascii?Q?wUP1Ntm3MGpP5uT2BODh6kE+mz7fvQLoTYn8LT0q30K3baASJB+Z87VGkIbe?=
 =?us-ascii?Q?BWppA+lKtWVsye91RoCuaLeaJ2WJ8nG7hZ454hnAsd0S20DDKhUPuqykmKVa?=
 =?us-ascii?Q?hOmte7f42yk8X8DBNxyEU8ptsMh0eZ6BlTcrZflTSu49mO3BV55gyJN+l1P8?=
 =?us-ascii?Q?DC6eDxKifXd/t9kBJXeJQ9GGFqTYZQNJ0tWcixGNVgl3OpLlUFR/mS7Dk5s4?=
 =?us-ascii?Q?5C7HBxXonhJYLy9rJL7+gCr+MJmcjR+SGevUQzuuTX49oxpl1inmVt/1plTZ?=
 =?us-ascii?Q?iUQGrJgTJjoCj128wpPVNj6CNPr4avh8dhH6A/wRaOztCA96dMRB4bBgg6HU?=
 =?us-ascii?Q?ttp/0rAyjRkUXfzqyn5P0CuEO0pHxv9jDXSdtivbJuN3HlaLnZ4pnGYksjYe?=
 =?us-ascii?Q?ZPFIABajdT1/Ae78wrIo7vI2KrdRhk7SnjiUVWeLyW4Ns60Rzkjnsq/QvkrR?=
 =?us-ascii?Q?cUXAq+xu3SnDI0cY5QBdm56FGGAMuw3JHW+rTijbWumgcFB4xeDXZPCvLfEe?=
 =?us-ascii?Q?k1MimlORyeWTXfQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xgzpvUd24CWKNtIy6hgJP0czCAbE5GL5KU3H/K2AxalhRjKvbbgKEannJY+2?=
 =?us-ascii?Q?f8G6VbUlq2tRj9nFjDsbgH/zfpthlJK7QXET3EGEEn+0mYXVdiJqV4qRLR7i?=
 =?us-ascii?Q?/siBg9ZDFHAH2xSNYfHpzTExcXJFtbkj2FXXTSgvGOZMPXvO78DTm7YfQMg4?=
 =?us-ascii?Q?2w6irJBgXuh3g75VRAbf5RpLJ4x0+Rcc4BYQGrwaMHc2MbH/WSlojxeAMiKe?=
 =?us-ascii?Q?y7KrvxniGoSSjCGnxQSRUpF8aETJXUYGKskW6gt5PAGo+eY4fdI3NollTCTc?=
 =?us-ascii?Q?1QGgk5aZ2vkWUm3bTvv7hk1DeMbR4UCSjr3GEuajVmmh2cOP8JD79pBg3Ej7?=
 =?us-ascii?Q?ytgd5LPv6cKIKEArqqEDr/b/wrEKtGjM1RCCss73W7a3Hgll3mA0zkbag7FR?=
 =?us-ascii?Q?LWjt4cisRJju4exUXFNzqz8d+v3uqG9X4fzRDhRqYDbhCY1qayoWiUvjgFTs?=
 =?us-ascii?Q?OD+HkXzWzcEt2PgbMn3lUGQHpeLLS4tpJ95H0ZuxOXokPNHf75ejGn4fz5Ni?=
 =?us-ascii?Q?k7/EB/KAaaMLR/Dy2DxkkKgLhYn7MUTsFrxY2+SZQHwkXs2SA2uZd13RQzY7?=
 =?us-ascii?Q?o7Uj9Za8StRuBN/roV7BxiDyuSIIV6WHBX8NiX97tu0uaiKMfYQN6iLPGt+D?=
 =?us-ascii?Q?kxMq2fUjhY/uqGYGRYDTCbItKDbNW05HkaZ/I093D3T+MvHR8a8ea2mtmshd?=
 =?us-ascii?Q?qqprw7MObLx9XyaEsSrXPlZ8M+WLb03NSRq2Ctgifn4W7cnovqIq0gVBbNcY?=
 =?us-ascii?Q?0r6dBehTnqbou9Jvcl/JrPpfMyjT56Egm1tZt3aCVN329VyTHOggYHvzKIkc?=
 =?us-ascii?Q?whoGGVJsvsbLIde6SgkpynANkRcgaAf9szvT9qyPHH6dV9TjSfzZFu2NIx3f?=
 =?us-ascii?Q?fLaVjQMmW4xo8syjYjnyh0DA/Gl7OGzv1nkaac3FfxwGnd+aKDR7Hhwghd/1?=
 =?us-ascii?Q?D5tu7dD5Psz3vmSKeoMt+QAZjVfOQcmCZEJG3yIC6iQEzv+4yd7MDozgTN/9?=
 =?us-ascii?Q?jof8Dm+V2qvM0BQlBZyRuwhhAV5qnFaori1lHAEoXlUrzxKBmED2Vt46FMcV?=
 =?us-ascii?Q?Qm1sOMMGxPKpXwFS6rX38S6LuNPOS/U0TfTbWn0UgXSeLmSnA61b2xGcXvz1?=
 =?us-ascii?Q?ccIlTvFCkLjsXoNGqiwtlgdiOTy6ULhRoSNJaRl1LrCzpl59VYmdBWphGXfE?=
 =?us-ascii?Q?QhwATur2JKNqJB+0gjh5J4yp9ofMmSXe78S9NgKuZBJ+1yx9XGBSbzDIZWYi?=
 =?us-ascii?Q?LL18ngSPRYOMDiQfGBk1hUU1kEcKiAsR3YN3DPOCKGpkol0A0JQAPQdGv7wF?=
 =?us-ascii?Q?AvlxUNDppt/8Xe8d/uBhoqnLoZbUzHXTHSVnbq6mZYZxPUqlziKt7MLGg45a?=
 =?us-ascii?Q?dUo7oBIUm9fX036+6rUVRrNuhIuU87Xw53bMAusSfH0IjwhFLvBPlMy/MWTo?=
 =?us-ascii?Q?cMh5VDX4DX+tzd/B5Alza0ZzcDLoj3WY3VyXuvMiDlC1hxtrd+blchFB/GpG?=
 =?us-ascii?Q?GlpPSSogM1T7n+zLY3umFHVE/r4PUXDws3n4PGfUsrf5J1nWumJjRXa3hrth?=
 =?us-ascii?Q?w7M1e3hKmfcRtd7+HSg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6345B07E614DBE882CE7FF2EFA33ACY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbd5431-c73b-4cb1-969a-08dddfab1975
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 05:33:31.5954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CK4bNxunHSTOF4fnUNCB3vjGEgX6JPsPgvpZNZVHgOvhtpJJRqARM2TLcWmKO33T6JETEhDohJCNC7L0CrMnCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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

--_000_CY5PR12MB6345B07E614DBE882CE7FF2EFA33ACY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Thomas,
Sure, will do, thanks.

Regards,

Liu, Xiang

________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, August 20, 2025 9:39 AM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, August 19, 2025 1:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection

Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b00cbb927ca8..6730de574fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,
        struct amdgpu_vram_block_info blk_info;
        uint64_t page_pfns[32] =3D {0};
        int i, ret, count;
+       bool hit =3D false;

        if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
                return 0;

+       if (amdgpu_sriov_vf(adev)) {
+               if (amdgpu_virt_check_vf_critical_region(adev, address, &hi=
t))
+                       return -EPERM;
+               return hit ? -EACCES : 0;

[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,
          The VF critical address regions of guest may be also need to be c=
hecked.

+       }
+
        if ((address >=3D adev->gmc.mc_vram_size) ||
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
                return -EFAULT;
--
2.34.1


--_000_CY5PR12MB6345B07E614DBE882CE7FF2EFA33ACY5PR12MB6345namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Thomas,&nbsp;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Sure, will do, thanks.</div>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Regards,</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chai, Thomas &lt;YiPe=
ng.Chai@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 20, 2025 9:39 AM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
-----Original Message-----<br>
From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Sent: Tuesday, August 19, 2025 1:26 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thomas &lt;Y=
iPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection<br>
<br>
Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.<br>
<br>
Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index b00cbb927ca8..6730de574fdc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_block_info bl=
k_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_pfns[32] =3D {0};<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret, count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool hit =3D false;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UMC_=
HWIP, 0) &lt; IP_VERSION(12, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_virt_check_vf_critical_region(adev, address, &amp;hit=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EPERM;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return hit ? -EACCES : 0;<br>
<br>
[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The VF critical addr=
ess regions of guest may be also need to be checked.<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((address &gt;=3D adev-&gt;gm=
c.mc_vram_size) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (address=
 &gt;=3D RAS_UMC_INJECT_ADDR_LIMIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EFAULT;<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB6345B07E614DBE882CE7FF2EFA33ACY5PR12MB6345namp_--
