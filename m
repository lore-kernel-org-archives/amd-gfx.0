Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28F5C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 10:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CBB10EC44;
	Tue,  7 Jul 2026 10:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W9f3f9Ka";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64D410EC43
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 10:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnHeiOFOOWykJh0gmnGEjPahwC4CzXI7pWpFpdgOkUCfwtoT2uhL1P5khhJfJhK4sSjZAlFUKZNYZGPZkxcs78sN5v9ggP9Zo4nNLci7lnXF/JAijNZ+baicB6KDGWsS+44FfUsBcevBUEIpzI9ETNLJUe6PUSnQqjRYynlsitjV6PhIvSoBk0LiUKeYNCe9sjBYiexpIR5dZOj9EixxohOWm+mf4Ew0TLF/qya9xFtWslayxyzH+4HsT100/BpQHp1RvpVWK/ghvpYZwC0YjuC9KcNOltRDDfJoFJJ9RwRE2IXifrT/0HqKz+/ktfXg6ET7KXA3dupOvxpnPJUBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlqQOftqmWcb0lYT9QtCNhKIsRhUOGD2GzfrnYPTBRM=;
 b=AUCrmCPv2NKuXHMfauLUk4Jy+5/gHpdIHxMzKDEZP+2yHcaldAgUoGz+/tTUV/SPoIMkU7BbWaMz0ftkrsVzBxosGehbKHyNKRRis11cUnyJP1sCjrOAVSvIJWfGZjtlAiLJGiF45by9kcBOPhGtC9JCS6GKJ6Oeu2MzVvJeeAzDAiG250c52KWTzym9UdFLH0NIQMZ4DwU0FUf+/yM1fVm94RQIuqDJ3KZai6DtoJ2MiTI2vGbaI1XWu447kgsQ3Qw+pPq57BhJIDRxQ8K7EY3R/zEC3xyhlHRX5d12BOrJw0vBo4VkQwL8K6DuuZpmWEmapKLsRb4wUMeXvk5AZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlqQOftqmWcb0lYT9QtCNhKIsRhUOGD2GzfrnYPTBRM=;
 b=W9f3f9KadM2zgXUZ04Bg7sjO88Y4hqRr5wyVQSx/Am1KeEiWO4+IgcOUGnPSli1aLPrnoDeBnmIstub0rygV8uLVo+SsutBvmY30xnvixIQdo8hSXQSDp+Pd7yZRhxlcAv7Jd320TY0XznxN45sW6Ls+qV8j4/oI5frknuIlquE=
Received: from CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 10:42:52 +0000
Received: from CH1PR12MB9598.namprd12.prod.outlook.com
 ([fe80::1cf8:469b:2c4:1dd]) by CH1PR12MB9598.namprd12.prod.outlook.com
 ([fe80::1cf8:469b:2c4:1dd%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 10:42:52 +0000
From: "Indic, Vladimir" <Vladimir.Indic@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Six, Lancelot" <Lancelot.Six@amd.com>, "Araz, Tishko"
 <Tishko.Araz@amd.com>, "Erenberg, Max" <Max.Erenberg@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix named barrier restore in gfx12.1 trap
 handler
Thread-Topic: [PATCH] drm/amdkfd: Fix named barrier restore in gfx12.1 trap
 handler
Thread-Index: AQHdDZMOBc+vF3jCGEqHaxWY7hSPmbZh3pVB
Date: Tue, 7 Jul 2026 10:42:52 +0000
Message-ID: <CH1PR12MB959858A5D90FE2BA34BE39739AF02@CH1PR12MB9598.namprd12.prod.outlook.com>
References: <20260706220043.612554-1-jay.cornwall@amd.com>
In-Reply-To: <20260706220043.612554-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-07T10:42:51.544Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PR12MB9598:EE_|LV8PR12MB9668:EE_
x-ms-office365-filtering-correlation-id: 37c59705-a79a-4c72-55cd-08dedc147efd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|8096899003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: AQfnRaSLkmai64FtOUcM/6ISzzPWrhLRZDM073WILoReSzolXMIlmFauLHVb8eFF+spau6fSPkxeD4odDrbK9Xsu47v/gu4G//p4Oo/AlGGa78cjSLs2b40itL9hRU4wEOG812G1n14SCevjKTV6JGSnQi5B1R1Nac2ouiS+Qze2rbHKPS85fHhHG5Gp6IiX7ycfN4Iql7DgSYt1tV5o8z/qPwYA4fb1AhSVCqcJ9yqhyh5a35YwmmR3vM/IX1F5M4cguFls493AxalvXcRh3hKvu8TVP8xcEJmRH0Op4TzQmoEhCt4YtU4BxKPWXS2zuuWAMjmHEPqBAbqd3UJjah1qbdcxlpd1YoSbBULC4PqJ8GB7WFWMM8DgAAie0ivyIys9A8Y1vjMp6VTseITTR2MRWLy0tyFpio6H6RyAeCWWihbh29UEC6zkLAumX9foXizeZJH1hXYGQ76mTmU4t+Ppo+acgECShnKBJtz9abrSbw3qhpRF20urv8sZMnVnDgt2yE+K2bCwsT1TpVLWiJw96wzBkG9stf2Lv7sgFqTyvSAQ/il5pPmp+Bg7PAKXKQACnL69JOo0MoSR/VUjW0XvvxOHIm1Wv/P3EJENjR2SwtwGCQMaxkWmtwb581OaCVjIZjdqdUypu6MTAk3JF3khsBQB+FgEZ2JUEzpOKb/bNAgeW3Ktnwa8SJBK3yi5QU7QJg1D6RL3BWBlQqcU8n3NhLKRa43IzhwZZRZ9kg4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH1PR12MB9598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(8096899003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?FagsHTe2gEDqXBBeLPUitrasRbdvTevT3iA5LoOMgFdRMkM6W3pj4O5Z?=
 =?Windows-1252?Q?J0c01uI8NMylUZ7FydLql/oz6IAVMJ5Fp5LGVNX7xLWhlPn7QkX+vaph?=
 =?Windows-1252?Q?jmsT3dTLODzIanFUkUshni44qDbMYUogjPO6UewVFMdcKjzfHK6v+b7I?=
 =?Windows-1252?Q?TFCHt8oK2gKGy1beqCVvRlmb0qlwPPp+Tj4FtfUOfU1b7qAb4rL748Uj?=
 =?Windows-1252?Q?N1nFO1cNx6RSZYqpAeliP1D7a3q+r1LTHQyDcP60B5hOHZlBTdrsGLD1?=
 =?Windows-1252?Q?tAgTNdsvEXqTNajJOOg1OkoHmGMAhVFJ8Xm6YufxlVnc8uefm/mLMiec?=
 =?Windows-1252?Q?joLBdSRQt9IuP3i5Ty/VgR5ny3cwVqvQ5UvIe1kqRf59UNrN/2ZAxsF0?=
 =?Windows-1252?Q?yEdL6RAgzIDASpCD0jmAhuELQl1KeCNxKf2YMtIdOOqSDYRCW+QiSnWN?=
 =?Windows-1252?Q?aRpUVK+u/wFyjNaPfb5pJOan+Bqc+dAj7PtKG+tYCpuuOw/qJiaSaNJL?=
 =?Windows-1252?Q?C853g/AcS2BOAgEbU88KYKmR7nlUEqlw0YnBbUR7/VtXSSF14F6T42b2?=
 =?Windows-1252?Q?0riy5xcnjt3Dni90C6ovbC6Uk60BIeUX1BZ6L1SvpnXeAyOJYN5mAzPH?=
 =?Windows-1252?Q?zJsDJeMZ6b4rlPqvmAQcTWVKjPRGNIYgoMtRg6JGxri5Xyai3z5a66e0?=
 =?Windows-1252?Q?yCesU+lmfdBU4J/iwPmyyx3yNgk1uCqz8+mq63D+nMLSZMQSmK68YIsP?=
 =?Windows-1252?Q?9KOjKITPSWDuJSiHYnRdklCnwpbFt8vCdkNM7RPwPGzi6U+mxMMC5OkV?=
 =?Windows-1252?Q?G71y+/YsQCk4jMq15mrfPvtFSWjPl//yuq9B/XIBW1NGMmlMq+Ipqdhr?=
 =?Windows-1252?Q?k3zQlPybVWwnnenibZQYxaa3mL1Rz3i9F19B6FuAeAK1nd33pmV2ZQIK?=
 =?Windows-1252?Q?rk8VREK5NR5sCxeBHCdNWKFSQlFueBruwCpcpkF5oJYE+oL3+sEzLusi?=
 =?Windows-1252?Q?xG99Ua95Efnc1HvVY1FpQcHtBsyBpi2kOcUroyGxaNTCIX+fQUmevX/7?=
 =?Windows-1252?Q?6uh+tQsNhHclNikkuUWrT4bK4wyoHTwMceOzoIiaaDfmVzgz9xDRgDP3?=
 =?Windows-1252?Q?1IchFT3qlJWQexQ4/0dGNpK+jiQ/F2Bc0CFsRHVOPWZDaWyIv5ICGC7Y?=
 =?Windows-1252?Q?mpjvPxkamYV/YxFH9hESOSgx6THFmZgzA2PIMhOj9aGKTvTP/s12iRey?=
 =?Windows-1252?Q?0RnA0vu68CYx793PvS9BVcXskfeOD1l3TAULOOor1MCH2SkK3t/E7tYZ?=
 =?Windows-1252?Q?k7TFTbuSJ2RPCx1HloOZ+bICXrkCgosF25s9y2cEHRkXmGZgxGCqbilU?=
 =?Windows-1252?Q?z8Jc/VFtzbtuM9WLyb7tBfOgZ4ZmUYJwgDSnqpMlE8xNPQl8EQqmGCNQ?=
 =?Windows-1252?Q?4mKNgtsngCi3G29rcfwJhMoyiX5XBNOPAEbmYDjhNvfLn0SRdyrDPbTx?=
 =?Windows-1252?Q?pmk3xQ001bDMalLRfxJKvYVbeNbTP6BQMiZsNDehZToXsMBjg0z9NrvW?=
 =?Windows-1252?Q?4eOOgOAxhEHE0gGfzoWfmEKAGGYdygWX0IKtvQV9tNMdLp8US6PUGOVc?=
 =?Windows-1252?Q?1L8bdpgDt0ZiR43RuKTLF9Jewdl6U01QGOTH4mrXbEg9+dhx3dQGWda4?=
 =?Windows-1252?Q?/Q1OPd7nMytnlL8aKZmX4VaFQ0624VK5GHET7Nt+6E/Q0KN/RNw+IpyY?=
 =?Windows-1252?Q?71VjRi5n7LhS5+PyssccZLt+MgVckM74GpjId8ZHYsWG6vFEm1JxRYDO?=
 =?Windows-1252?Q?58I4XiUWxoOdHH9AMrOgfprWPeD3c5YSrIAIsgn9MuCm1MK0?=
Content-Type: multipart/alternative;
 boundary="_000_CH1PR12MB959858A5D90FE2BA34BE39739AF02CH1PR12MB9598namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c59705-a79a-4c72-55cd-08dedc147efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 10:42:52.0500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCiBFMKs4MWkNdzWrhFJSl/P+1N8+hgaccPaH9AHVSJJ4G/re4JJANIkaOLzYd5zPBOyC+b7Y4Z+Q7OHTyPk+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

--_000_CH1PR12MB959858A5D90FE2BA34BE39739AF02CH1PR12MB9598namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Jay,

Thanks for the patch!

  Reviewed-by: Vladimir Indic <vladimir.indic@amd.com>

  The bug and fix are correct. S_GET_BARRIER_STATE returns:

    { 5'b0, NBC[2:0], 1'b0, signalCnt[6:0], 5'b0, memberCnt[6:0], 3'b0, val=
id }

  where NBC (bits [26:24]) sits immediately above signalCnt (bits [22:16]).
  An s_lshr_b32 by 22 shifts both down together, so the extracted value is
  (NBC << 2 | signalCnt) =97 inflated whenever named barriers are allocated
  (NBC > 0), causing the restore loop to over-signal the barrier.

  s_bfe_u32 with offset=3D22, size=3D8 masks NBC out precisely, leaving onl=
y the
  7-bit signal count in the destination.

  One note: BARRIER_STATE_SIGNAL_SIZE is defined as 8, but the signalCnt
  field is 7 bits wide ([22:16]). Bit 29 is always 0 in practice (it's
  reserved above NBC), so this is harmless and the extraction is still
  correct. A comment (or a corrected constant value 7) would make the inten=
t
  clearer, but it's not a blocker.

Best regards,
Vladimir
________________________________
From: Cornwall, Jay <Jay.Cornwall@amd.com>
Sent: Tuesday, July 7, 2026 12:00 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Six, Lancelot <Lancelot.Six@amd.c=
om>; Indic, Vladimir <Vladimir.Indic@amd.com>; Araz, Tishko <Tishko.Araz@am=
d.com>; Erenberg, Max <Max.Erenberg@amd.com>
Subject: [PATCH] drm/amdkfd: Fix named barrier restore in gfx12.1 trap hand=
ler

Barrier state layout has non-zero fields above the signal count.
Mask these off to restore the correct signal count.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
Cc: Tishko Araz <tishko.araz@amd.com>
Cc: Max Erenberg <max.erenberg@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 150 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |   2 +-
 2 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/d=
rm/amd/amdkfd/cwsr_trap_handler.h
index 54fa76f374c9..42e4a5773ad6 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3929,7 +3929,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
         0x00030000, 0x807d847d,
         0x8070ff70, 0x00000400,
         0xbf0a7b7d, 0xbfa2ffe9,
-       0xbfa0014c, 0xbef4007e,
+       0xbfa0014d, 0xbef4007e,
         0x8b75ff7f, 0x0000ffff,
         0xbef1007f, 0xb8f20742,
         0x84729972, 0x8b6eff7f,
@@ -4070,36 +4070,36 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
         0xb96ef812, 0xf4601bbb,
         0xf8000030, 0xbf8a0000,
         0xb96ef813, 0x8b6eff7f,
-       0x04000000, 0xbfa1000b,
+       0x04000000, 0xbfa1000c,
         0xf4601bbb, 0xf8000038,
         0xbf8a0000, 0xbf0d806e,
-       0xbfa10006, 0x856e906e,
-       0x8b6e6e6e, 0xbfa10003,
-       0xbe804ec1, 0x816ec16e,
-       0xbfa0fffb, 0xbefd006f,
-       0xbefe0070, 0xbeff0071,
-       0xb97b2011, 0x857b867b,
-       0xb97b0191, 0x857b827b,
-       0xb97bba11, 0xb973f801,
-       0xb8ee3b05, 0x806e816e,
-       0xbf0d9972, 0xbfa20002,
-       0x846e896e, 0xbfa00001,
-       0x846e8a6e, 0x806eff6e,
-       0x00000240, 0x806e746e,
-       0x826f8075, 0xf4605c37,
-       0xf8000010, 0xf4605d37,
-       0xf8000020, 0xf4601e77,
-       0xf8000034, 0xbf8a0000,
-       0x8b6dff6d, 0x0000ffff,
-       0x8bfe7e7e, 0x8bea6a6a,
-       0x936eff77, 0x0002001a,
-       0xb96ef81a, 0xb97af804,
+       0xbfa10007, 0x936eff6e,
+       0x00070010, 0x8b6e6e6e,
+       0xbfa10003, 0xbe804ec1,
+       0x816ec16e, 0xbfa0fffb,
+       0xbefd006f, 0xbefe0070,
+       0xbeff0071, 0xb97b2011,
+       0x857b867b, 0xb97b0191,
+       0x857b827b, 0xb97bba11,
+       0xb973f801, 0xb8ee3b05,
+       0x806e816e, 0xbf0d9972,
+       0xbfa20002, 0x846e896e,
+       0xbfa00001, 0x846e8a6e,
+       0x806eff6e, 0x00000240,
+       0x806e746e, 0x826f8075,
+       0xf4605c37, 0xf8000010,
+       0xf4605d37, 0xf8000020,
+       0xf4601e77, 0xf8000034,
+       0xbf8a0000, 0x8b6dff6d,
+       0x0000ffff, 0x8bfe7e7e,
+       0x8bea6a6a, 0x936eff77,
+       0x0002001a, 0xb96ef81a,
+       0xb97af804, 0xbe804ec2,
+       0xbf94fffe, 0xbe804a6c,
         0xbe804ec2, 0xbf94fffe,
-       0xbe804a6c, 0xbe804ec2,
-       0xbf94fffe, 0xbfb10000,
+       0xbfb10000, 0xbf9f0000,
         0xbf9f0000, 0xbf9f0000,
         0xbf9f0000, 0xbf9f0000,
-       0xbf9f0000, 0x00000000,
 };

 static const uint32_t cwsr_trap_gfx9_5_0_hex[] =3D {
@@ -5066,7 +5066,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] =3D {
         0x018c0000, 0x00030000,
         0x807d847d, 0x8070ff70,
         0x00000400, 0xbf0a7b7d,
-       0xbfa2ffe9, 0xbfa00184,
+       0xbfa2ffe9, 0xbfa00187,
         0xbef4007e, 0x8b75ff7f,
         0x01ffffff, 0xbef1007f,
         0xb8f20742, 0x84729972,
@@ -5208,64 +5208,66 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] =3D=
 {
         0xf4601bbb, 0xf8000030,
         0xbf8a0000, 0xb96ef813,
         0x8b6eff7f, 0x04000000,
-       0xbfa10022, 0xf4601bbb,
+       0xbfa10024, 0xf4601bbb,
         0xf8000038, 0xbf8a0000,
-       0xbf0d806e, 0xbfa1001d,
-       0x856e906e, 0x8b6e6e6e,
-       0xbfa10003, 0xbe804ec1,
-       0x816ec16e, 0xbfa0fffb,
-       0xbef800ff, 0x00000080,
-       0xbefd0081, 0xf4601bbb,
-       0xf0000000, 0xbfc70000,
-       0x80788478, 0x937eff6e,
-       0x00070004, 0x847e907e,
-       0x8c7d7e7d, 0xbe80517d,
-       0x917dff7d, 0x007f0000,
-       0x856e906e, 0x8b6e6e6e,
+       0xbf0d806e, 0xbfa1001f,
+       0x936eff6e, 0x00070010,
+       0x8b6e6e6e, 0xbfa10003,
+       0xbe804ec1, 0x816ec16e,
+       0xbfa0fffb, 0xbef800ff,
+       0x00000080, 0xbefd0081,
+       0xf4601bbb, 0xf0000000,
+       0xbfc70000, 0x80788478,
+       0x937eff6e, 0x00070004,
+       0x847e907e, 0x8c7d7e7d,
+       0xbe80517d, 0x917dff7d,
+       0x007f0000, 0x936eff6e,
+       0x00070010, 0x8b6e6e6e,
         0xbfa10003, 0xbe804e7d,
         0x816ec16e, 0xbfa0fffb,
         0x807d817d, 0xbf08907d,
-       0xbfa1ffec, 0xf4601bbb,
+       0xbfa1ffeb, 0xf4601bbb,
         0xf800003c, 0xbfc70000,
-       0xbf0d806e, 0xbfa1000c,
+       0xbf0d806e, 0xbfa1000d,
         0xbf0d9a7f, 0xbfa10002,
         0xbf068180, 0xbe804fc4,
-       0xbf94fffc, 0xbfa10006,
-       0x856e906e, 0x8b6e6e6e,
-       0xbfa10003, 0xbe804ec3,
-       0x816ec16e, 0xbfa0fffb,
-       0xf4601bbb, 0xf8000040,
-       0xbfc70000, 0xb96ef81a,
-       0xbefd006f, 0xbefe0070,
-       0xbeff0071, 0xb979f822,
-       0xb97b2011, 0x857b867b,
-       0xb97b0191, 0x857b827b,
-       0xb97bba11, 0xb973f801,
-       0xb8ee3b05, 0x806e816e,
-       0xbf0d9972, 0xbfa20002,
-       0x846e896e, 0xbfa00001,
-       0x846e8a6e, 0x806eff6e,
-       0x000001c0, 0x806e746e,
-       0x826f8075, 0xf4605c37,
-       0xf8000010, 0xf4605d37,
-       0xf8000020, 0xf4601e77,
-       0xf8000034, 0xbf8a0000,
-       0x856e9677, 0xb96e04a1,
-       0x856e9577, 0xb96e0421,
-       0x856e8e77, 0xb96e3021,
-       0x8b6dff6d, 0x01ffffff,
-       0x8bfe7e7e, 0x8bea6a6a,
-       0xb97af804, 0xb8eef802,
-       0xbf0c8b6e, 0xbfa20003,
-       0xbe804fc2, 0xbf94fffe,
-       0xbfa10001, 0xbe804ec4,
-       0xbf94fffc, 0x857a897a,
-       0xb97a0244, 0xbe804a6c,
+       0xbf94fffc, 0xbfa10007,
+       0x936eff6e, 0x00070010,
+       0x8b6e6e6e, 0xbfa10003,
+       0xbe804ec3, 0x816ec16e,
+       0xbfa0fffb, 0xf4601bbb,
+       0xf8000040, 0xbfc70000,
+       0xb96ef81a, 0xbefd006f,
+       0xbefe0070, 0xbeff0071,
+       0xb979f822, 0xb97b2011,
+       0x857b867b, 0xb97b0191,
+       0x857b827b, 0xb97bba11,
+       0xb973f801, 0xb8ee3b05,
+       0x806e816e, 0xbf0d9972,
+       0xbfa20002, 0x846e896e,
+       0xbfa00001, 0x846e8a6e,
+       0x806eff6e, 0x000001c0,
+       0x806e746e, 0x826f8075,
+       0xf4605c37, 0xf8000010,
+       0xf4605d37, 0xf8000020,
+       0xf4601e77, 0xf8000034,
+       0xbf8a0000, 0x856e9677,
+       0xb96e04a1, 0x856e9577,
+       0xb96e0421, 0x856e8e77,
+       0xb96e3021, 0x8b6dff6d,
+       0x01ffffff, 0x8bfe7e7e,
+       0x8bea6a6a, 0xb97af804,
         0xb8eef802, 0xbf0c8b6e,
         0xbfa20003, 0xbe804fc2,
         0xbf94fffe, 0xbfa10001,
         0xbe804ec4, 0xbf94fffc,
-       0xbfb10000, 0xbf9f0000,
+       0x857a897a, 0xb97a0244,
+       0xbe804a6c, 0xb8eef802,
+       0xbf0c8b6e, 0xbfa20003,
+       0xbe804fc2, 0xbf94fffe,
+       0xbfa10001, 0xbe804ec4,
+       0xbf94fffc, 0xbfb10000,
         0xbf9f0000, 0xbf9f0000,
         0xbf9f0000, 0xbf9f0000,
+       0xbf9f0000, 0x00000000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drive=
rs/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 456db8199899..0da98cbc4c30 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -1387,7 +1387,7 @@ end

 function restore_barrier_signal_count(barrier_id)
         // extract the saved signal count from s_restore_tmp
-       s_lshr_b32      s_restore_tmp, s_restore_tmp, BARRIER_STATE_SIGNAL_=
OFFSET
+       s_bfe_u32       s_restore_tmp, s_restore_tmp, (BARRIER_STATE_SIGNAL=
_OFFSET | (BARRIER_STATE_SIGNAL_SIZE << 0x10))

         // We need to call s_barrier_signal repeatedly to restore the sign=
al count
         // of the group/cluster barrier. The member count is already initi=
alized.
--
2.34.1


--_000_CH1PR12MB959858A5D90FE2BA34BE39739AF02CH1PR12MB9598namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Jay,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for the patch!&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Reviewed-by: Vladimir Indic &lt;vladimir.indic@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; The bug and fix are correct. S_GET_BARRIER_STATE returns:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; { 5'b0, NBC[2:0], 1'b0, signalCnt[6:0], 5'b0, memberCnt[6:0],=
 3'b0, valid }</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; where NBC (bits [26:24]) sits immediately above signalCnt (bits [22:=
16]).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; An s_lshr_b32 by 22 shifts both down together, so the extracted valu=
e is</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; (NBC &lt;&lt; 2 | signalCnt) =97 inflated whenever named barriers ar=
e allocated</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; (NBC &gt; 0), causing the restore loop to over-signal the barrier.</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; s_bfe_u32 with offset=3D22, size=3D8 masks NBC out precisely, leavin=
g only the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; 7-bit signal count in the destination.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; One note: BARRIER_STATE_SIGNAL_SIZE is defined as 8, but the signalC=
nt</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; field is 7 bits wide ([22:16]). Bit 29 is always 0 in practice (it's=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; reserved above NBC), so this is harmless and the extraction is still=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; correct. A comment (or a corrected constant value 7) would make the =
intent</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; clearer, but it's not a blocker.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Best regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Vladimir</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Cornwall, Jay &lt;Jay=
.Cornwall@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 7, 2026 12:00 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Cornwall, Jay &lt;Jay.Cornwall@amd.com&gt;; Six, Lancelot &lt;La=
ncelot.Six@amd.com&gt;; Indic, Vladimir &lt;Vladimir.Indic@amd.com&gt;; Ara=
z, Tishko &lt;Tishko.Araz@amd.com&gt;; Erenberg, Max &lt;Max.Erenberg@amd.c=
om&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Fix named barrier restore in gfx12.1 tr=
ap handler</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Barrier state layout has non-zero fields above the=
 signal count.<br>
Mask these off to restore the correct signal count.<br>
<br>
Signed-off-by: Jay Cornwall &lt;jay.cornwall@amd.com&gt;<br>
Cc: Lancelot Six &lt;lancelot.six@amd.com&gt;<br>
Cc: Vladimir Indic &lt;vladimir.indic@amd.com&gt;<br>
Cc: Tishko Araz &lt;tishko.araz@amd.com&gt;<br>
Cc: Max Erenberg &lt;max.erenberg@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdkfd/cwsr_trap_handler.h&nbsp;&nbsp;&nbsp; | 150 ++=
+++++++---------<br>
&nbsp;.../amd/amdkfd/cwsr_trap_handler_gfx12.asm&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 2 +-<br>
&nbsp;2 files changed, 77 insertions(+), 75 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/d=
rm/amd/amdkfd/cwsr_trap_handler.h<br>
index 54fa76f374c9..42e4a5773ad6 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
@@ -3929,7 +3929,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00030000, 0x807d847d,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8070ff70, 0x00000400,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a7b7d, 0xbfa2ffe9,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0014c, 0xbef4007e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0014d, 0xbef4007e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b75ff7f, 0x0000ffff,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef1007f, 0xb8f20742,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84729972, 0x8b6eff7f,<br=
>
@@ -4070,36 +4070,36 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef812, 0xf4601bbb,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000030, 0xbf8a0000,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef813, 0x8b6eff7f,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x04000000, 0xbfa1000b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x04000000, 0xbfa1000c,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000038,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xbf0d806e,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10006, 0x856e906e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6e6e6e, 0xbfa10003,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804ec1, 0x816ec16e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0fffb, 0xbefd006f,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe0070, 0xbeff0071,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97b2011, 0x857b867b,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97b0191, 0x857b827b,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97bba11, 0xb973f801,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8ee3b05, 0x806e816e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9972, 0xbfa20002,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x846e896e, 0xbfa00001,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x846e8a6e, 0x806eff6e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000240, 0x806e746e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x826f8075, 0xf4605c37,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000010, 0xf4605d37,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000020, 0xf4601e77,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000034, 0xbf8a0000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6dff6d, 0x0000ffff,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8bfe7e7e, 0x8bea6a6a,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x936eff77, 0x0002001a,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef81a, 0xb97af804,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10007, 0x936eff6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00070010, 0x8b6e6e6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbe804ec1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x816ec16e, 0xbfa0fffb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd006f, 0xbefe0070,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0071, 0xb97b2011,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857b867b, 0xb97b0191,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857b827b, 0xb97bba11,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb973f801, 0xb8ee3b05,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x806e816e, 0xbf0d9972,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x846e896e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x846e8a6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x806eff6e, 0x00000240,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x806e746e, 0x826f8075,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4605c37, 0xf8000010,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4605d37, 0xf8000020,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601e77, 0xf8000034,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x8b6dff6d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000ffff, 0x8bfe7e7e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8bea6a6a, 0x936eff77,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0002001a, 0xb96ef81a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97af804, 0xbe804ec2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffe, 0xbe804a6c,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804ec2, 0xbf94fffe,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804a6c, 0xbe804ec2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffe, 0xbfb10000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfb10000, 0xbf9f0000,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0x00000000,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const uint32_t cwsr_trap_gfx9_5_0_hex[] =3D {<br>
@@ -5066,7 +5066,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x018c0000, 0x00030000,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d847d, 0x8070ff70,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000400, 0xbf0a7b7d,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffe9, 0xbfa00184,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffe9, 0xbfa00187,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef4007e, 0x8b75ff7f,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01ffffff, 0xbef1007f,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f20742, 0x84729972,<br=
>
@@ -5208,64 +5208,66 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000030,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef813,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7f, 0x04000000,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10022, 0xf4601bbb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10024, 0xf4601bbb,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000038, 0xbf8a0000,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d806e, 0xbfa1001d,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e906e, 0x8b6e6e6e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbe804ec1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x816ec16e, 0xbfa0fffb,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef800ff, 0x00000080,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0081, 0xf4601bbb,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf0000000, 0xbfc70000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80788478, 0x937eff6e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00070004, 0x847e907e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c7d7e7d, 0xbe80517d,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x917dff7d, 0x007f0000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e906e, 0x8b6e6e6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d806e, 0xbfa1001f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x936eff6e, 0x00070010,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6e6e6e, 0xbfa10003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804ec1, 0x816ec16e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0fffb, 0xbef800ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000080, 0xbefd0081,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf0000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0x80788478,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x937eff6e, 0x00070004,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x847e907e, 0x8c7d7e7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe80517d, 0x917dff7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x007f0000, 0x936eff6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00070010, 0x8b6e6e6e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbe804e7d,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x816ec16e, 0xbfa0fffb,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d817d, 0xbf08907d,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa1ffec, 0xf4601bbb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa1ffeb, 0xf4601bbb,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf800003c, 0xbfc70000,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d806e, 0xbfa1000c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d806e, 0xbfa1000d,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9a7f, 0xbfa10002,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf068180, 0xbe804fc4,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffc, 0xbfa10006,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e906e, 0x8b6e6e6e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbe804ec3,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x816ec16e, 0xbfa0fffb,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000040,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xb96ef81a,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd006f, 0xbefe0070,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0071, 0xb979f822,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97b2011, 0x857b867b,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97b0191, 0x857b827b,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97bba11, 0xb973f801,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8ee3b05, 0x806e816e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9972, 0xbfa20002,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x846e896e, 0xbfa00001,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x846e8a6e, 0x806eff6e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001c0, 0x806e746e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x826f8075, 0xf4605c37,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000010, 0xf4605d37,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000020, 0xf4601e77,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000034, 0xbf8a0000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e9677, 0xb96e04a1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e9577, 0xb96e0421,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e8e77, 0xb96e3021,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6dff6d, 0x01ffffff,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8bfe7e7e, 0x8bea6a6a,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97af804, 0xb8eef802,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0c8b6e, 0xbfa20003,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804fc2, 0xbf94fffe,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10001, 0xbe804ec4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffc, 0x857a897a,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97a0244, 0xbe804a6c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffc, 0xbfa10007,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x936eff6e, 0x00070010,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6e6e6e, 0xbfa10003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804ec3, 0x816ec16e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0fffb, 0xf4601bbb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000040, 0xbfc70000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb96ef81a, 0xbefd006f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe0070, 0xbeff0071,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb979f822, 0xb97b2011,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857b867b, 0xb97b0191,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857b827b, 0xb97bba11,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb973f801, 0xb8ee3b05,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x806e816e, 0xbf0d9972,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x846e896e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x846e8a6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x806eff6e, 0x000001c0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x806e746e, 0x826f8075,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4605c37, 0xf8000010,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4605d37, 0xf8000020,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601e77, 0xf8000034,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x856e9677,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb96e04a1, 0x856e9577,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb96e0421, 0x856e8e77,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb96e3021, 0x8b6dff6d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01ffffff, 0x8bfe7e7e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8bea6a6a, 0xb97af804,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8eef802, 0xbf0c8b6e,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20003, 0xbe804fc2,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffe, 0xbfa10001,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804ec4, 0xbf94fffc,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfb10000, 0xbf9f0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857a897a, 0xb97a0244,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804a6c, 0xb8eef802,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0c8b6e, 0xbfa20003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804fc2, 0xbf94fffe,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10001, 0xbe804ec4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffc, 0xbfb10000,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0x00000000,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drive=
rs/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
index 456db8199899..0da98cbc4c30 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
@@ -1387,7 +1387,7 @@ end<br>
&nbsp;<br>
&nbsp;function restore_barrier_signal_count(barrier_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // extract the saved signa=
l count from s_restore_tmp<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; s_restore_tmp, s_restore_tmp, BARRIER_STATE_SIGNAL_OFFSET<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_bfe_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_restore_tmp, s_restore_tmp, (BARRIER_STATE_SIGNAL_OFFSET | (BARR=
IER_STATE_SIGNAL_SIZE &lt;&lt; 0x10))<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // We need to call s_barri=
er_signal repeatedly to restore the signal count<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // of the group/cluster ba=
rrier. The member count is already initialized.<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH1PR12MB959858A5D90FE2BA34BE39739AF02CH1PR12MB9598namp_--
