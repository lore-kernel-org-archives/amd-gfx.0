Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF627C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 16:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 521EA10F4C1;
	Mon, 15 Apr 2024 16:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X6Eu6Vlg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE3610F4C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 16:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5vEd5gTMKSvW3lwmNbZfhTkRnueIV985jOBmwkWEzTQSnFNtWcpL7Cx+fMxArGiRAlmTTG54yYT+n0iZ6DwpzRSmrDZ129NkHE+tQ0M/VKRO8UqlaG9FdaFSrd6mgFIdvoEFn+CFDJGzCIDXxnP9inUWFTB6aQ2YDQE9in3qUy/Lmfnoo/EGT9GhDe12J1KzNUZNcblCZLdpCvvD5s93aZ0Z88y5Xj6I0Q9F4CLA4nesdeZEAbDAmBPy4PRO3+Zk10OoLdXH9oyglEztDgYxZUt9mMqxynCv9su+ZxsYPeYfJy0J6Bze48FZtT7JeTOafr7GhFIabwr/1+LM1F4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CMD7dt3up5RnqCuSSn5oIKrTuqpCsRRi0OEGxkV4EU=;
 b=fDHuq4EuoGvf3V0JVNE1lnVPPpDODYEKhr/VLPQ0Wim6HyImKM9uzS7sPqV0yXSP5t1AxSpGIXrmVa9cN6z5vDI3UwDD17s5Trwd8eHwExMHAu3fb/gf9JUZ2dmscvquWW2dZfzotsqOwCw5C4O+rtM1X9zZ1mvzw8kzyt8A65/A96N4V8kCUlyAC4VJtMVCaSPE96ngZiUMXBQ4t2BamcqukQ0bWT4W6E5uZ3BmIdHFKwHfJo7J7J/f4lZXimHFB1rAD50UXGBFlDtWAP4x/5hgAMncbBQkaVB/69jH/fkqcFxRxcG3FrZ0YvSmp9oNPdONqiZ/DPbXJxmR/+9GEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CMD7dt3up5RnqCuSSn5oIKrTuqpCsRRi0OEGxkV4EU=;
 b=X6Eu6VlgHVpynXVQwLevWBOmZHHRF1qRI7MtxX2l1dkWkMtgCsMDABGdm2OIAA+J+2sdLqMFu0aK9ZzILGM+dabNVxXl0nWRxw0CO6zr8ZhLf3h71mgb1gpMBNDMswEL57gQptJP/K7xljU4rnkTm7kIdTVnFJz0UFFm07wiuLI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 16:33:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 16:33:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Change AID detection logic
Thread-Topic: [PATCH] drm/amdgpu: Change AID detection logic
Thread-Index: AQHaju9kgFov4VtxtE2xMcRQv9MoSLFph3Ag
Date: Mon, 15 Apr 2024 16:33:52 +0000
Message-ID: <BN9PR12MB52578C577FE8C80CA51311D1FC092@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240415044236.142024-1-lijo.lazar@amd.com>
In-Reply-To: <20240415044236.142024-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cd2c36bf-a6b8-4602-8336-52e587cff11c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-15T16:33:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6088:EE_
x-ms-office365-filtering-correlation-id: fd067b39-9368-4028-1f94-08dc5d69d5fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/VWQ0B20GSzctiObSZbVwNplKMvjP4mNW4hrJtpYj3MR8c3sE1VWsvMMSq30HxpZTbVzj3xIPgyW1/+1neryVvjK1HsFQOXNcP37TTwfswkeBinB2jvjyIjHzCQvvq0OYwEcjb0dFiXrVKktqZhFVZs9O8H8zyVO9mPk5QRmRPqYBkT0ScmYawprmdVYlVONJ74mnEG4QUXqmgBC1xJtxM54WuBFQINvr6Bh9N+YzGuM7jDTGbOyz1d1nJbhkBXRPYEGWCZQNkz88CIGG8MVI/cMLpvlAk/xmctBkTzZx+YCnhRlDnI3juOGFIustOY1UEaOaYR80EiV5j23lWYew/43nX48nQ2/CoyPe1dsWIBsWVwhf1p0HvFgL5dblC12dJvoWNt/e2i9Zjtziylig2ZTmqWqCppmYvoZf3WgLVGHVS7yU7HQGJvVsAEcJMkPunntAbByoDFb1nyvneBFfmiAWgBmVWa79PYHDN98fMxm9nH2ES3P2/6jUL7oV4QXwyXo1z0qrWEVXVF8hRbXNifXXNwaoTrSPElPZbAsW3xbB2WFykfAgIrVnIEJRak6IDuWmOqpwqX3Vm7szE+J+DWBL4GpWShnp5Dmz2OmbTHEDghDUmDYdUnqjj6GlrDIjHMTrgUE64lNZjwie4FQ9A0Ogg5pW0YyvoEPXv7x7or7icKGVvfKtEQ36zbY59ZNv/wyGeo4BvrbcMpZqDtpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UWxFC66h7w4HMP1tL2DxpF/Id2ilyslON5s08wf/Zp95lzBJiGTSCANZJPM/?=
 =?us-ascii?Q?vuSguO4f6U9XVGllxuq8Vdboi62F3f43BVPPk5MxitIn/76ZnIQcRIKs5Xhu?=
 =?us-ascii?Q?yt0tJcCbaWrMy1n3yKtAaUFDeN6ZENKuknum0DfUjaAR5XrOLSY/3QTq4gAR?=
 =?us-ascii?Q?AeGh0CiqqYUiOAMopkcaEBd8flhDigIY07Kw/8hFhyFhUzYkWkRREG3IWqJO?=
 =?us-ascii?Q?S//ewwaLwwvOR7joynyzFLR9uBZ1MomdfOk6M1KOA/YiZO6y5evLdKI/gr04?=
 =?us-ascii?Q?q7DQEkre8rTdWWu5v701QFneBmS3u5lroCcAxyS5rkt4GX/V+6IEKNa5Quk9?=
 =?us-ascii?Q?zX6dmDH4Pj0qp6lsR2muLhJsqJz/1tsF/VoA2N6CKmICiY9TkWJ3VEfX1AO4?=
 =?us-ascii?Q?gT1XpC1DuiwHB9UALvBichH/AEcPXgis7WretLzBgGehTieY50cpLPwd2N9H?=
 =?us-ascii?Q?Tk6w8BwiZfqpXpO290ef6jMQlyukV9jJi/CcqEZU6BTyKTCa/brLawHasOoQ?=
 =?us-ascii?Q?LXkc/TU0RdCUOd1fdr3DfGfzOtScxCmm+u195goaIDfQ7Y82Z6p3DsDZdFUm?=
 =?us-ascii?Q?tC6DJWjyY6lXYTLlas6JdqSAVdMpWz4zWuZJqQ4dsJni6CQqODM3C8qypCD8?=
 =?us-ascii?Q?8DDvc5HLaINCv4CQVki7LnPo8AukA0eycBErbg8k+6J3erfGQHJ0B2J//Kd1?=
 =?us-ascii?Q?kyJ2UEtIyzjbZjsezZWkCbE3j+QeKAdBUkXlrsuqWTlH9ZVHRpqD7LNVNKRy?=
 =?us-ascii?Q?W0OriVSP1ss11E700ZOUy7+aXnsSL9eHXYVvvDpD1op5jjokn+nWwiHQ+ZCx?=
 =?us-ascii?Q?zv6EqyTlAz0nfrr5V6sjfok+xOX72rwxZ4HugsB22mKhwxKRNdnNlLpTJeMV?=
 =?us-ascii?Q?UmLSWmvHoYnVt9fBzkx44A+/bI8tw7Y4+j06SICpvoKygoRYkB4uNNPw1qxe?=
 =?us-ascii?Q?u2l2ZJZs1Hl+//S/oIqDPWYABX7Bnx1rU4HG2Xg5t6kaCFz1Ny3yFfLuSOyR?=
 =?us-ascii?Q?rGTQ6BnVkXSXL+q7uIaCAuLaxBnzOo03crYuPtE4wOdO2GqhLjI16GMmIcEX?=
 =?us-ascii?Q?60NQ7FryHu+HCZej1LwSMEDPQvk1jUDtoKdpDRlE+npWNJIqRJ+kwAXR0L+t?=
 =?us-ascii?Q?2YntNPpKH//tXqvAM9csSirGmonF8ktolkrRLLL1QT6lQDFDLRPXs2HEtqWj?=
 =?us-ascii?Q?FGvv4NcTAXnN9P7BUqX7Ct7WkelhcWvCBop2FNcS/pabcRQ+S6V+birJNsWC?=
 =?us-ascii?Q?Eh2u9sDU8/JPNUymSax5o8vIvcD7k1F0SvrnzLcgdkfTY3g8L7Mm1quPJZkH?=
 =?us-ascii?Q?NjyuQWqRb0P8fUBCw3AfaYeKayF4hzI43+uyN3YVX5DBCNZT247DLewKhpMD?=
 =?us-ascii?Q?VyO8l6pa727otBA9ms5U0882qK5Yk0+1GU2E+03dN1q24+Osd9n9WverSzGP?=
 =?us-ascii?Q?Ht2oV9FHnMXuVVNkmOpPGEv29EZ1wuiAmA3EfWcgzO+I4iBfdQVDxu9sdYwv?=
 =?us-ascii?Q?Vdgii3sFxiq2jXx0LdjFAhUjbExyMzomTD1KV2AX8ix+/Py1dqKdd/w30Rc7?=
 =?us-ascii?Q?bhv+R5GTrzOt/dN2skU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd067b39-9368-4028-1f94-08dc5d69d5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 16:33:52.2031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVlylYzE2O0S5x+rKTVM4psshzLPOxGO4o5e9h+zbuZ8MHOT1FN58wGIhNLOqBjfhHihbVO09pFqEJspb/FmwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, April 15, 2024 00:43
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Kamal, Asad <Asad.Kamal@=
amd.com>
Subject: [PATCH] drm/amdgpu: Change AID detection logic

On GFX 9.4.3 SOCs, only 2 SDMA instances need to be available to be conside=
red as a valid AID.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index fbf5f65ab091..bdab65bc3105 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -649,7 +649,7 @@ static void aqua_vanjaram_down_config(struct amdgpu_dev=
ice *adev)

 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)  {
-       u32 mask, inst_mask =3D adev->sdma.sdma_mask, sdma_pres;
+       u32 mask, avail_inst, inst_mask =3D adev->sdma.sdma_mask;
        int ret, i;

        aqua_vanjaram_down_config(adev);
@@ -662,8 +662,9 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device =
*adev)

        for (mask =3D (1 << adev->sdma.num_inst_per_aid) - 1; inst_mask;
             inst_mask >>=3D adev->sdma.num_inst_per_aid, ++i) {
-               sdma_pres =3D inst_mask & mask;
-               if (sdma_pres =3D=3D mask || sdma_pres =3D=3D 0x3 || sdma_p=
res =3D=3D 0xc)
+               avail_inst =3D inst_mask & mask;
+               if (avail_inst =3D=3D mask || avail_inst =3D=3D 0x3 ||
+                   avail_inst =3D=3D 0xc)
                        adev->aid_mask |=3D (1 << i);
        }

--
2.25.1

