Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FD4C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 22:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F37D10E13E;
	Tue, 13 May 2025 22:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EazvoGy6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F180C10E13E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 22:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I43ElRHWJZLq/uyt+SmxnBqDXdD8oSymZHshX+31bC7Eemexe90b6XgFOR2ctwYc8OI2JWH234U8NO/gkToR99MVLpJKiMZSSsR2EzFFYnXmipAYAUCNgAeejV/PDWhJgEizR9a9NYkM5xNvlIpXfOjNbILqu6xtCtIduVfuvYxKF+SwiT3aI6iVY8svezKUOx5wrBWtWYPJyzWQrvZh0yYpX8MnoLCPnNSQ6hpaXquVOa3Z1R69LBF0vaClHQLbetnFVuN+wxfYvROzNSd29sFBCKslAYGxwXoLf03ZxYgBB9WAK9Phz/JQefomL/MJPNGzj4OP7kh6kRjWAIFUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngTmiBodfh2PDKtasFX5wa9+nBiIih4GMW/Dk5htsZ8=;
 b=AUwSEVb4vX3ojiU0QHJ0mMtzvJKubT6nPC6bjV4H6W+qJgNu1xRHBZoLKPIlFpGqLlMhvtMwjb72l0rK1SYaLnGAztyi2McYu/4VE3zstOgHVWjiHncW1rwqxtdSkwZAw4qso8J6KpSmpmgHZYxoB6+WPR5YN30ZTpo2QoHPOBuTonFTZR062wDr1hz/RHZehvdQSmXWAOtU3i+2BquUVpDpGqPMRgLNDIqFUVo1uVzX6o+iig6J6PaEA531j41m6emvENj1hEhJkj2re4ZwKcVobkEvnKYEmHBiFkalil0/FvxMb2wGrR5qLipoeMJ7W+Rq5TmeKN13UeZyZ7UVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngTmiBodfh2PDKtasFX5wa9+nBiIih4GMW/Dk5htsZ8=;
 b=EazvoGy61hnR0Nt+FEW6JMyPu4/jIEou/fhlOt4/qqvndgvfkDgm3N4FzKzoM373IL+2zB7OSWZjN1vGJ2goZJqLwTEik4NecN5pNAmows7cb3BNqvhpO+Ol+5ImRyicwN2f8jkfrX0De1CmBn/BRSK+ENWzvSuzbKi1tvxwtdI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA5PPF9176ED2F1.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 13 May
 2025 22:17:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 22:17:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Dong, 
 Ruijing" <Ruijing.Dong@amd.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH v4] drm/amdgpu: read back register after written for VCN
 v4.0.5
Thread-Topic: [PATCH v4] drm/amdgpu: read back register after written for VCN
 v4.0.5
Thread-Index: AQHbxFQhNSA+/Z1i1kiKjRd7PY+dTLPRIMXe
Date: Tue, 13 May 2025 22:17:30 +0000
Message-ID: <BL1PR12MB514473DB51D15144FF17725FF796A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250513221218.654442-1-David.Wu3@amd.com>
In-Reply-To: <20250513221218.654442-1-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-13T22:17:30.195Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA5PPF9176ED2F1:EE_
x-ms-office365-filtering-correlation-id: ed8b803d-9eae-4a7c-8ec0-08dd926bf3df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Hl7/5piUJqQNTjkuXfv9KRRP6+4UAowMk+pXqzWg26JcEqnVZzJYmBe3uFP1?=
 =?us-ascii?Q?sAqvtLYdulM+J0O9U68MP3P+7tVFm4cmn6fK8f1IQAxP2y7PlGGA1+jP3fIH?=
 =?us-ascii?Q?1EkfWcNGruxXSWmztanKzZRCVJseGfjpMZqwGw+1Ha2LSMVDCtOCHp2LZAgi?=
 =?us-ascii?Q?URVWHITdKoj1WDkU0LV1wUEo0gZLFbPu2aIir7QCkK5EmFa3Wdj31ofhNinR?=
 =?us-ascii?Q?m1G2SY6dfH4oUP5Jfz/Ma6iqraWEYqLeD6ukFWUFxdzcsTo5OvNJ7wO5HB7P?=
 =?us-ascii?Q?ZnoIM9TJgz45dEIATpTSBUM3Z1xgtL3xL5lDSeLIGsdOfcFiiHHBlSSeSAiK?=
 =?us-ascii?Q?MYseE9MiGiZDS5tvrbNUqNxZtCmlH4ca65vZAVSL2Mbcs/JWbwOKlA3orab+?=
 =?us-ascii?Q?XVvr1YQ+J1BYKWBvMkCaLBUK3d2MIowp46TsfF1Zmi46ipm407FYDpKC2nsk?=
 =?us-ascii?Q?pJOA0bBpUuLqryzv5pKTsT14v74BJa2M1jauwZgDfsczB87FxQvPnYbF3aKc?=
 =?us-ascii?Q?vAqQ+HKLXn7wBDlj+hQWtejwHdofy2AV73n1mL6LYosEcQrYKqfClhQUbCwM?=
 =?us-ascii?Q?fayYWOP5s2QLPLTj06IacIhM9LfOKbpPjVKS4mZHzBvh2Kizh7Gh/QazF7EE?=
 =?us-ascii?Q?lAaJRYCv0IL0fp1aOFir6tFWhNZTmwZB1w9Af/3fqynw7vRuPsXM17ZIHnzN?=
 =?us-ascii?Q?p3JgWHMbIyhcKakCR1bjx2BS3W/sinh1gjkg6GRMX62DpG/T/lPXqdXIEmq7?=
 =?us-ascii?Q?bUnFwlNJJm86sjKxv2KW5aLkULIpMf9/qfqYqpnc2ulFzIrn7dyTKe7sjhYY?=
 =?us-ascii?Q?A81jRlJzri3rpik7BQ2eyyTTfAjcgUUMsDdjz5n6i2AcXwwMw/rCbQKHcrSb?=
 =?us-ascii?Q?gUi+VK6So4qe57VYKr/B6SOIHXJPxRJu5mSZuWqaLvAb8PMXRmyPnrN+Vfqf?=
 =?us-ascii?Q?Lk5pvvHWK2Zeiupk56NQk6bhutkuSrLRlLTbMUy0fOOlA5RlDUMTBZb302+a?=
 =?us-ascii?Q?8fO2PiUKzXRozMkZzNwwt6st+l0QN3XWxhyH/NHL+rpIWayrIjTixtY7DX3l?=
 =?us-ascii?Q?oUI1vzlXfu7q/dzZkfMDpVKnNlyteZXsnMcA9CRTu35pSeQ96ayGBlhxAtBp?=
 =?us-ascii?Q?gh+4ixzoVMq/sugl31w+Xbt5/EhtPujNSlecxQqREgJWoW12AkicVD21M5Hf?=
 =?us-ascii?Q?fG7X8Z8e72ao6PT55d4mEReedKgpqQpNr2JDIkGGfp2X2p/rO/ewDa1HVUsK?=
 =?us-ascii?Q?4nEPNFTTixGvyHHKSoZotLaxtcretbcgfzyeWCY+UyY3Tmw5gNnQU6rFPSaj?=
 =?us-ascii?Q?O4wuwuGIFWXXmVQ3TE6B6QKfbmzQp6pd4/cByz2BZYdXrOC4KoR6Ov6HHhoL?=
 =?us-ascii?Q?GOCIb+GaiJd1Vrzqs6+rqpGAfS0ECTDXc8WRwYk6TtrJIGHULN0TKbExiMok?=
 =?us-ascii?Q?tBIOQe25xo0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X8uzMkvcj8LEspcFeVOUv4WjSCkpMDbDVzW1tHAjj9TW/xyUeBuwsCoKRmEr?=
 =?us-ascii?Q?7DNLFTt3DI/E3DUXpSuVw29lgeFDwu0OOFVtQenfB0ccE9cn3WIDmftXBQ4U?=
 =?us-ascii?Q?GFXA1Wul9BMr87wgBst7sJNRlQ0xaF2kINrSMY6dBshAxuKO0XAD2GuhwcPT?=
 =?us-ascii?Q?jvwve8ctAbPUpaMPrrkTikwNnQDpp+Dd6EW07HEydTC8yGOWRcnUbLlIFlR2?=
 =?us-ascii?Q?QutfxN5yuvrG81Ki8VGMVdT+b8bOetjR8aS7RMSze2dH9/rD2pFoR5+o2FUD?=
 =?us-ascii?Q?uFunDL55IBGrZ96ceQrVoG1bqDjd1Zb7KKFuY8W5vtIvfZaCIMT+iuGt/o1f?=
 =?us-ascii?Q?SXgiIUznFzwX35XV357r1+VnVrzfhYFDeVfnri8U3ypw7cVEmLFd2od2/pwv?=
 =?us-ascii?Q?/qD7lgIq4fXA2AvHY73c2FZDPZ07uJvrsUxefMAHPxISVADk/N2CtzJRWl6J?=
 =?us-ascii?Q?5rzpGbxzGIwxDl8Nb2OyuXrK8GtwWYhDubXPVWA0fdFOarAU5wfmNwTThFOq?=
 =?us-ascii?Q?kAQiqofNuZApABLtZKI+dL7297qKaLZi4Hn6NGfgup5wpN55XPClBgeuqy4I?=
 =?us-ascii?Q?lgN3yip1vTzpp69ggFUqq12pQFtOhsjE3ehnq6wvSFsiueqdPtJKqVsbBi7i?=
 =?us-ascii?Q?pn71tbzB73XRIZ++B+KJwNF5DvNpdgOOK5Udxkqa8rY17xWV2nLstxloZBmB?=
 =?us-ascii?Q?hY9TSI9ZLD/HWC/O0LjZvSaCwvkS+WwR1XssGwG8b9Vm/zGrzoN4N46YzBVD?=
 =?us-ascii?Q?E43XPNhIUtaZL/g+OhIvpZFUMWeq4CSzhszWg7efHWcZn/jWispByLMsqSeU?=
 =?us-ascii?Q?yBdLaVYRHJ29Qn+pxSrmPcADtnyI/Y7H5/Y4ZjdVulxLSfb/CuPTg90Sz+5P?=
 =?us-ascii?Q?6387nHEELr74k1ZmJfPkr4zpUWTTZnuk2++HkSXa2SU7zqotnVen6ZRQW8cU?=
 =?us-ascii?Q?0b65H6QSRO6qlD99Q79oMF63eOpW91jPOOVSzEOF1HkpSLzqZLdgoWox6l5F?=
 =?us-ascii?Q?Oj9NSgRZs84cGznM9iYZJl8Y6Bkc/rL38IuoME6IvqmJMhEgT2e3OWu00USw?=
 =?us-ascii?Q?huEPKqWCxIfr5wCr1fsHM098UtyDX9OwLAowWUdMdMIN5XyrQLo45dPyRUVQ?=
 =?us-ascii?Q?bT2uCxkReAgiuLeJlnMfh1j0ZOjRkQEtMmnXTwwTic5EyKuu2fi/RHIxyLgy?=
 =?us-ascii?Q?9LnONRV9e/3rjPJs4TKmY2SK6fMxbXRDDZn7GAhULrjeVDQ6WC6wPAaaLfBk?=
 =?us-ascii?Q?hVb1WyzPWkhW5RhajpaIA5ZoDwiks3oiQ7PrFs0OhCwqSB5K7k3W11+++9JA?=
 =?us-ascii?Q?ltDvqcaCHZnRBc0mmWRqdvph87+iob7W1rEwoYLy2bQnfIn8yfxTA/9AyaQe?=
 =?us-ascii?Q?H1GU7karLImCq3+beE1GVnsmW3ioz7KvObc0B0PzLy8EbUjhP9DaaxEE+RXs?=
 =?us-ascii?Q?JIwcA7FxFMklLH8ZYq01WjVey4dTlJ28FLqF4YthiDbxIUzzrbVeuQ76POGv?=
 =?us-ascii?Q?DiO/G0M/3fp82G7bciVCskYCxiY5wzRedazQ3OCmMjBR2enzMYR6sd/PpcgH?=
 =?us-ascii?Q?voTl5MDk8fva85u2OFQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514473DB51D15144FF17725FF796ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8b803d-9eae-4a7c-8ec0-08dd926bf3df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 22:17:30.7021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flpIEwHOH79wU7UC+uxfzeZ3lwt8v0s+xLp4DRpqqfiYMW6sVKebGXtpwU62G43PJjQ/RGlxPq/pOacI7tmSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1
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

--_000_BL1PR12MB514473DB51D15144FF17725FF796ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: Wu, David <David.Wu3@amd.com>
Sent: Tuesday, May 13, 2025 6:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Koenig, =
Christian <Christian.Koenig@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.co=
m>; stable@vger.kernel.org <stable@vger.kernel.org>; Limonciello, Mario <Ma=
rio.Limonciello@amd.com>
Subject: [PATCH v4] drm/amdgpu: read back register after written for VCN v4=
.0.5

V4: add read-back for non-DPG case. This is for protection
    purpose as it is not used for producton.

On VCN v4.0.5 there is a race condition where the WPTR is not
updated after starting from idle when doorbell is used. Adding
register read-back after written at function end is to ensure
all register writes are done before they can be used.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Cc: stable@vger.kernel.org

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_5.c
index ed00d35039c1..a09f9a2dd471 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1034,6 +1034,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_v=
cn_inst *vinst,
                         ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__S=
HIFT |
                         VCN_RB1_DB_CTRL__EN_MASK);

+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions */
+       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
         return 0;
 }

@@ -1216,6 +1220,10 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *=
vinst)
         WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
         fw_shared->sq.queue_mode &=3D ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG=
_HOLD_OFF);

+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions */
+       RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+
         return 0;
 }

--
2.34.1


--_000_BL1PR12MB514473DB51D15144FF17725FF796ABL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wu, David &lt;David.W=
u3@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 13, 2025 6:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Leo &=
lt;Leo.Liu@amd.com&gt;; Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;; Dong, Rui=
jing &lt;Ruijing.Dong@amd.com&gt;; stable@vger.kernel.org &lt;stable@vger.k=
ernel.org&gt;; Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH v4] drm/amdgpu: read back register after written for=
 VCN v4.0.5</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">V4: add read-back for non-DPG case. This is for pr=
otection<br>
&nbsp;&nbsp;&nbsp; purpose as it is not used for producton.<br>
<br>
On VCN v4.0.5 there is a race condition where the WPTR is not<br>
updated after starting from idle when doorbell is used. Adding<br>
register read-back after written at function end is to ensure<br>
all register writes are done before they can be used.<br>
<br>
Closes: <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528"=
>https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528</a><br>
Cc: stable@vger.kernel.org<br>
<br>
Signed-off-by: David (Ming Qiang) Wu &lt;David.Wu3@amd.com&gt;<br>
Reviewed-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
Tested-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 8 ++++++++<br>
&nbsp;1 file changed, 8 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_5.c<br>
index ed00d35039c1..a09f9a2dd471 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c<br>
@@ -1034,6 +1034,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_v=
cn_inst *vinst,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCN_R=
B1_DB_CTRL__EN_MASK);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Keeping one read-back to ensure al=
l register writes are done, otherwise<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * it may introduce race conditi=
ons */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(VCN, inst_idx, regVCN_RB=
1_DB_CTRL);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1216,6 +1220,10 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *=
vinst)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, i, regVC=
N_RB_ENABLE, tmp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;sq.queue_mod=
e &amp;=3D ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Keeping one read-back to ensure al=
l register writes are done, otherwise<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * it may introduce race conditi=
ons */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(VCN, i, regVCN_RB_ENABLE=
);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514473DB51D15144FF17725FF796ABL1PR12MB5144namp_--
