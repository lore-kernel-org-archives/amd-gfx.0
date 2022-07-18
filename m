Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6BFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 03:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEB32B9FD;
	Mon, 18 Jul 2022 03:37:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DCD2B9FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 03:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCd4ZGZOuoBwmKNArIoYfOHwkGrXj9UKu7rUYKr+A0AYK1FsH5u+yQA5nIu+xtbteNUqwQOwlXkau3MS5BbiJPn8r8mBuD7ljEthgFe6BoEmb6jH6T1ml+TabTwZ6+9Besy0guIWo2yYs9gdu22ZbNNIJBaeSI2mmoJBiN3Bf3dlKm6J7jL+D4km1u0kfXNL59BevRi9wG0Jz/la1hMw1v/KfffOCsiRrZ684SYYvYiWN5B8xtWldQHpSYmh+sD4JrQ2voizwKBVB4dRToTLTfO2u6sDmN+q4mzBOSlTS1gmPB4cGX2pxkPw3PtIEKpIiUWbjZ6Cp95ext2tLJSxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHpyoLhbAD/xE6tci5ma5qbfpmlr1AW+9+9Avz87DRw=;
 b=cJVshZ8DwcU+FmOAWtrfMacZnRXXp6Us7t62OYdr4U0fSu+l9XIoPvaS9JtPMkt1YRAPJWrsprHw1O2ky5kWWX92IaQT7AKuZnAkaAfDZfNN/8+4w9xTOGeR/xRW2aT0TMRhCi7GwRu1DLzJj9G0CSMJUVkErTdHpHXuQ5PgSB4XnZkzHz+yI/W4PMssXNykfT0i9CdfRnZefh9SJV7EDkh/PqoN2ZOPqI+1L9GWpj6PJV4qezrQXgydLkxU+DoB9tEbbreYHoedESghAtOEjCIyT9BEgwvgaVXn5fpIph7wrUqyH+kI0veEcbaNTCMyjtRLcqgomfuEyfWUTsOwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHpyoLhbAD/xE6tci5ma5qbfpmlr1AW+9+9Avz87DRw=;
 b=A4ByoTF2rvfvqz4gFOT5P0LcMz0yXiuq8j1k4whihxnggmrnDY8dPPwGFwIsaDbpY7ZCkDyDsNGMJ/7/EX/VllJVujuU9W9pK1DlTGEMm6cU71z2KqBsb27TO4dt/FqOCiDkoxERstoDPLBfpfxPDIyMVPRjQneUQ7qAchSba/w=
Received: from DM5PR1201MB0139.namprd12.prod.outlook.com (2603:10b6:4:4e::8)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 03:37:14 +0000
Received: from DM5PR1201MB0139.namprd12.prod.outlook.com
 ([fe80::f411:f83d:5a68:1788]) by DM5PR1201MB0139.namprd12.prod.outlook.com
 ([fe80::f411:f83d:5a68:1788%11]) with mapi id 15.20.5438.023; Mon, 18 Jul
 2022 03:37:14 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the PSP_BL_CMD enum
Thread-Topic: [PATCH] drm/amdgpu: correct the PSP_BL_CMD enum
Thread-Index: AQHYmleCFyNN8Cuerk+MzznC34Y86q2DenLQ
Date: Mon, 18 Jul 2022 03:37:14 +0000
Message-ID: <DM5PR1201MB01399E6DC957083115FB511BFB8C9@DM5PR1201MB0139.namprd12.prod.outlook.com>
References: <20220718033505.9635-1-Hawking.Zhang@amd.com>
In-Reply-To: <20220718033505.9635-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-18T03:37:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7c96a98d-8aa2-4172-81b3-37ebe17724a3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-18T03:37:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: de3d4fb1-765c-4964-b271-e374a3a89604
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1508946-5943-41c3-acfa-08da686ece38
x-ms-traffictypediagnostic: IA1PR12MB6649:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/eCGXF2E+PeX82NY35939IeTXwrvjz2OdHdd3KA+j64cdX8lC/PcOvGsqz8ny4Rx2mkuOyGjpjvpS0L36bJQvmuuvOI22eXvfbo7bSSce5ebSNMAMnJ9aPPEgbDnLT3eMeGJtLYms5E9oPfS8yMI20IEtgJ87qAS8uT0a9tto7ubitedJEoJ31gkBmAW2GvQpos7Jqw6VCyNfeL9uOXweWYJYb+d2lU1ppwa94N8+smr8TrWWayinME7oKOnbX5pv5NEuy8jB3eyV1A43DZtLicbVrWhlSztykUu7UTgF4k8dnrO5sSCy7K4S15HegESlmzO/frP603FaiZCeuuiC5lkEf8OzKXubunR8p4bR4+V+demGW7NvxPA97T0rmg+KGevZIufNlKWy5SgGg/f2cNDUMOKo8QAd1ferTojYxXG9qJL+xRyMUbSnDUDegv013KOmBXX6r7vz/BFB/IL2/GiSIVcVt72wum3d0vv4Yax5zgakbzjXuEgGFtmEav/C9Rees1zvW8uVCrDepg7Ylowce4T1y0wcYhClAwdeZ/Fn/ZibGB+QwWotwN9fSwvKuwzexP7QfukP6AFMPfKIYEY+cFV1EeNrCBawu79bPIYjeDNS54Oe1cj9czaDLM37nzObE+huNC2gFISi+96e0jBhDGfS5uGGHuqmlqSA3tlbuwxUXFeZlBwhm8+o/7ppWdtPK5lnjfPXm3xj5DkMQOMJP4pP0xcJoyjLEgFDhoc2Il0vIR/s8u7AbYdHL0GvfP0O3iCDOq8n8+yQQr1nRUEQjCx8k/MNuMvh5fDm2J8wH1Z8XtXLC6yqCvBiA4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(8936002)(66946007)(66556008)(52536014)(66476007)(8676002)(76116006)(66446008)(55016003)(64756008)(2906002)(38100700002)(38070700005)(122000001)(86362001)(316002)(33656002)(478600001)(6506007)(7696005)(41300700001)(71200400001)(110136005)(53546011)(26005)(83380400001)(9686003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0lVXD7PG5LL3J62iEieGdVcpTq5f0bN0OGkDkPpkenHfjs5OHDofat1d5LKW?=
 =?us-ascii?Q?wM1q0TX/3A6T7mYgGyrYdRcWNmxic63SN4CsLaGJvu9NmpzA6PJxYIerpzxP?=
 =?us-ascii?Q?55pfYEBQ3De7OSItrk14Sr2VcMZoONKEEKwwotN1cSWmUh4y6KNF/Q6xzPNK?=
 =?us-ascii?Q?HS9PrRTCeFHrYzHS4is1skqrAy455WYanViEepcweDLbVwpp2LaphNHJddkl?=
 =?us-ascii?Q?1SzGkYv2dDyzVyVFLzOjWXrwSASJ/YFZOtBQ8wHQAT1/e3S0OXluod6II0nC?=
 =?us-ascii?Q?6TggJC7VDSHyTyHToC5nGinEDIB71Mh3IWpFgOLK4hxvN2ZxEuNx739LmtFC?=
 =?us-ascii?Q?Z3rZb0yZz+hZqthJH34FcrUQFunlItorMRaLcMOgE4r8Ck/Piawu+yzAos2A?=
 =?us-ascii?Q?PCIoJraWfW6vNtP0t9DSZcYh6sEw4+Vjp8WIiaVUMHrx6HlVdhmmNv1demTG?=
 =?us-ascii?Q?zUevXz4eJXjQOFXk61zjiqbecGxKkP08YQLKmEwaq3DAne5M50lMgatPpKlz?=
 =?us-ascii?Q?WDsgrB4tu97PghQuYZ2TdKTXyD6V4NIJiWyjEKnmc6JfkFmTIN344Bcgp49E?=
 =?us-ascii?Q?/50Bn0In6vvhMGqG2BeyYMDSpxaarjLP5JbYR15RI4decYGoFMtxVKO3fMkI?=
 =?us-ascii?Q?yzUfF17RKy5CMww3Vu4aFlWkz8k9eYYI2/X/WlVEjzCryFW+xqwKhkNSj1+a?=
 =?us-ascii?Q?d10t+f9GAxGE0sEcI6A7+KYzw/C8GMJePTf5yDprcf1olv7qGNCctGKmBDLC?=
 =?us-ascii?Q?N4nq7VmBCjVg31GCy+dEDnvn0m9CSVCpcPwzV6emNhzGs1Y6KdVlMhqbJE9d?=
 =?us-ascii?Q?hTCPDmBvOOi780SDV7ZobQwPXjqO99sum90ZwZOMLjI+20hEtU7lStwIoVRE?=
 =?us-ascii?Q?0S6oXK4ZFJw9mVZpNxQ0Y+9wOkcAIUGXZNj5BMJh7Bc7a/ItqNOnkjJyhcqG?=
 =?us-ascii?Q?DOxOmk8w9I6hJGNHQFQR2I+H4aFrvsUJQEaFt2hJTprKcliFsOI1ZUgb41TX?=
 =?us-ascii?Q?SkpDEu26MZ+kFGcse0pKbmj/oSE6xiGBiDFEh/AAWuK1NUE1uncOyvExJCSV?=
 =?us-ascii?Q?p9GtGGC+g6E2qCqlI5FM6fRne8kqYGMM4I8fIHUHPAp7FSeN/hHAN+Huh106?=
 =?us-ascii?Q?y2NpisevFXuMg82J2KjBcM5aYTsKo8k6Z4//u8s3+5S9zyBymyIB3iN/aea+?=
 =?us-ascii?Q?bdULnqf7KlpQaeEjXoYIxD9t/k2Wmx6y9HGwk5J+8pFx4HJgfmbooQTNT9P8?=
 =?us-ascii?Q?3Uk6EirUsU8ibvLXg5zCyb1QpT5VB7Zng+cpj7q+YjiLVODgvyEP6OGJzwbW?=
 =?us-ascii?Q?tufKPyglV05qaCfHWcpBv/2xKboLCQA/eDxUGu0kSWRvd3nXGmspTxOu2/Xk?=
 =?us-ascii?Q?F58XrXMmAbmCOul5hAg3X/qkKxx2xH7caFvMXpCCqO5kRXHazIImdzfBRZZy?=
 =?us-ascii?Q?yQ1CZXsT4HveL4qMHfnJW4RkmpU44VVZ0OjYEvXGfaD2BAlv6O2N7CK3/uKD?=
 =?us-ascii?Q?KxvHWX9ms2/W/x8PlPKEtkXEDLXVsUJaYNIphYquWHxO6gefgYT06LUMYLB3?=
 =?us-ascii?Q?jHNToGi9+U6omi6hUwI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1508946-5943-41c3-acfa-08da686ece38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 03:37:14.1702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kl6QkdCy2MkkCAcL/MPdZwZbxjPfWa4ZCRFCMX+S+JqwgKdZc0h6C/iVMSTIj6Zx5DSIpySGsXJd/CenD5/0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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

Reviewed-by: John Clements<john.clements@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Monday, July 18, 2022 11:35 AM
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct the PSP_BL_CMD enum

To match with the enum defined in trusted os

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index e431f4994931..180634616b0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -69,8 +69,8 @@ enum psp_bootloader_cmd {
 	PSP_BL__LOAD_SOSDRV		=3D 0x20000,
 	PSP_BL__LOAD_KEY_DATABASE	=3D 0x80000,
 	PSP_BL__LOAD_SOCDRV             =3D 0xB0000,
-	PSP_BL__LOAD_INTFDRV            =3D 0xC0000,
-	PSP_BL__LOAD_DBGDRV             =3D 0xD0000,
+	PSP_BL__LOAD_DBGDRV             =3D 0xC0000,
+	PSP_BL__LOAD_INTFDRV		=3D 0xD0000,
 	PSP_BL__DRAM_LONG_TRAIN		=3D 0x100000,
 	PSP_BL__DRAM_SHORT_TRAIN	=3D 0x200000,
 	PSP_BL__LOAD_TOS_SPL_TABLE	=3D 0x10000000,
--=20
2.17.1
