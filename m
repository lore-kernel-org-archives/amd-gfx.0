Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80C8C021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 15:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869FF10E400;
	Mon, 24 Feb 2025 15:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20fxuNtc";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A3510E400
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 15:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3Z6pPxbZmhXVLpjls8g8tBUeoQCLZAXmrVA3PPxM0wSsrLMNGZ6gZ7d2fvhaKgbCPEydmf2qpls1WhHfp/Y7v6q+Mwg6S3ueWW9S+ZOMUsgI2NWMWGbfPp1C+O+WZRUxfLiU4GeOQ8cP8aJ6w8x2WtTVb9qB4lhqUhOc/YrCl6KEhZRVZfL1bik+ennB05hu29RX46p3AAJnJDIrxEHT3Mb7jCAP0ab9cDHrjhG3BI7WL5G+4zMSSKKtzfiYoapiYKPATCJgaeVGKn5LRzSWTj8yamLVOBgL0nDZk8r/S7iXHtSf/WRabYVj3GxwNTk0IzdmsMs3c3nhUJq1c9Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lBuMebaX6SS9ZiI/Fod4gpQMJ3TeZ96jd8z9gDm0t0=;
 b=vvlL+v2g4MnmPiLnK1Yq/1uI09ZjSxcTRC97QPWMf/ukepRUZ7Hbr0BRdpH/hAwqPJHZVtN83cLCsYEbg5i0erJdfrs3eL+z42nshz5Odplqtln+vkF+bNpiQxLVnd7+jVni+zB+4/JsUdZGHxRs12r7fys6gJinuXeFgWBdT3Dxc1opUh8pQ9vW62R0G8dAMu2FWIQFS71riTVb6/2VHLYDlwZi7dVuePQvHs1VUQ/gAd0us4pV+DqV4vL5vJi8qLhg622sjdC9naEyNngY2rnjsZjCAXw+5xXhGSs03Bem9KRYvN2M2sjI/IlsVo3FJ/I/nXuihvu+6pByvWJefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lBuMebaX6SS9ZiI/Fod4gpQMJ3TeZ96jd8z9gDm0t0=;
 b=20fxuNtcCw1pZZ7Px6TIhJ/Llx8WLXpOmNoxmpGtKd3SJqhUMJBGpzi0B5LE3GZz8TfO4YuEVODhsM5GARk4vnOFDlCxzNzM8Euz04Ukb2m3chTVilm63qAPUcKoSfsxsZCmOdH9ly23Eqk4gacicPk28EMBRsrFwWZrLB9ZkpY=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 15:43:54 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%2]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:43:54 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/24] DC Patches FEBRUARY 18, 2025 V2
Thread-Topic: [PATCH 00/24] DC Patches FEBRUARY 18, 2025 V2
Thread-Index: AQHbhHlbTW2UyKylJkiAQIGWQgahbrNWnH8g
Date: Mon, 24 Feb 2025 15:43:54 +0000
Message-ID: <DS0PR12MB6534F6A769476054F8ED22669CC02@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=02788e69-3b9a-4c8f-9072-2000b1621553;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-24T15:42:57Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB8988:EE_
x-ms-office365-filtering-correlation-id: 2027f220-f79d-42ca-4b02-08dd54ea0b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dVEZyKXTMAzy+3jtFjKuXNoGSGOJ2HjHRoB4SPp5DQyIrbNjnV0/EeCN0J?=
 =?iso-8859-1?Q?7l9qt/FbH0CMRFRKNsRTwBhHJ1Xtb0KXaom39j/I59tvxwgUMSqtnvzdLz?=
 =?iso-8859-1?Q?ng5Yhap60dbjB7Nx9ckLhxNib7BD8wPsPcwsIXpyiQnEPK4HDgU4lY4PEY?=
 =?iso-8859-1?Q?XqO6d38ScJVsUkT/S46M7P4y/Jy7qluu/aGolVKAGK4sb1WvjG8w4hwGLu?=
 =?iso-8859-1?Q?H412I1YJLIFKc9mHj9Yy43PpRu50P5/zkQjTC/j25xIiXCMxjxBgzrc8AG?=
 =?iso-8859-1?Q?/CHRMxpyU2XsUN4m5GjAcaEKGRxdfeiuQd1Kc+CKXDz5PX7chIiqG72Bsd?=
 =?iso-8859-1?Q?g+mP7itkLkgrSSoz4A+KEDQ3FPGiQm3OG1g32hItkI8/ce74/E32orsoR8?=
 =?iso-8859-1?Q?8UIxAeibSGOTVlY1t2iEx/fgAhQ69Snwe1boCuMeI1F3bpj8tv7g11qieP?=
 =?iso-8859-1?Q?XKlGYa7koPugOjCW4ihTHxRQnMulChBZQE4RZf1Tcbg3IBiI6RHXFER5vi?=
 =?iso-8859-1?Q?jUDU9rHQMEJM5Rm1vqCtB150rgzoU7vLYHJXVIvF4ZlBBTe33l9z1Vsmk1?=
 =?iso-8859-1?Q?ECDL5UySChgXLGurFBblty5gScfVas7CaDho18/giaULdBUIBTq/HThmai?=
 =?iso-8859-1?Q?IJuyQ+IF/29fAFDc15WUYXpotKS5PDro1Tz0iVhjL6vVATHL258kQsxnQ4?=
 =?iso-8859-1?Q?J2W/2ib0K6FOnTPYnljRR9sLHUScc3c51XLWkRKGnud9xZZVacJtLgJI+6?=
 =?iso-8859-1?Q?ElQBJwY5Hr79UCInx+rpN1BTROcPLqPypX9eKqtUHDYzupy9ZyiDp6UKbr?=
 =?iso-8859-1?Q?ot3G+J8q6MeFbDwX8hN9upMmcFHYiWU3yHcNCfUCKI0nGY8LmYIglPum5R?=
 =?iso-8859-1?Q?cumt7gWvZD7yRbaNJKBEOeZeMa0Cs4M24fSA1dzm1s3dbwowpd3Rb7bNmp?=
 =?iso-8859-1?Q?xtqZlkebLIWFAuqjguPvNsrO2swtSexdhRufp8J70w0khzY+UBKqxNXf3i?=
 =?iso-8859-1?Q?C3HcQX6knYHmsmtieRX/vDODz0Ob2q275L266zKii+A2+GCnuwQPcZ611W?=
 =?iso-8859-1?Q?rWQjNrg/0Yq6LonHFAKRQz3EjBtVmK1uheAv7MMSxIM+wZzGfrNG6BfcrK?=
 =?iso-8859-1?Q?GjRScpeqLkEFOJ8ZoWXyuEYMGIggs4OqSCyj30G0bfqP2wnpDhS1kUNA5T?=
 =?iso-8859-1?Q?68KgbPPjUAI9Mh19umDaVSYprxmu9l6UfdAEFZk5QNXao0Jdw2XBfk/xax?=
 =?iso-8859-1?Q?ydZwJUvVh73CDgr2FBIPgRvlWC6LuKVevxqzAw3AmyM2DiqN9nihBGckgw?=
 =?iso-8859-1?Q?o9gXKXXfFmKHlU0rcSt6j7CQrjUS2ZCJgAX6EN0w43DLLt77fh2Vx6r8Co?=
 =?iso-8859-1?Q?OTjhNx5X4YFyKKDva7YXS7cfQBByHWLJKEfbLgmFdohl2WLgTuCibMWCHR?=
 =?iso-8859-1?Q?9j5x5zslDXhvYzij+WrK0JTGN6Joi2UEVKdDfoAfNLNloJnTijEhVWPVx7?=
 =?iso-8859-1?Q?e7pIdr6oXA0LpMiqc4vazW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AzjO4KNK+m+T7DmcFJdNzl5Poz/QyO5kFflwnn22Fs4zuhn/7S7SCnXjBe?=
 =?iso-8859-1?Q?j8hwpKTOnTxUOuL/PMOaazOZ3UoFLfi5rYgNvXexczJc4yAwZI23Sa1+Iu?=
 =?iso-8859-1?Q?vQTWB+S6fSeiUuMk8BRFcvk28vibRYesUs5B5+0kCvBEB46gwpNvxPGv/C?=
 =?iso-8859-1?Q?IvklgkFB23jKi6No5/dIWpd68ecMz6OFlY94W6yJzLa2hl5FQjoCbHuGSk?=
 =?iso-8859-1?Q?AVFBu0IbjxI7maR5E16QkAIiclruv7BEEYn7clNm6MsKatlJFthWZMWi7f?=
 =?iso-8859-1?Q?40GOTsLTc+f1wWcQOUzXB36oKL+fTrh2wjB8Kbifcxjb73esEBrsvazc35?=
 =?iso-8859-1?Q?vLn95Tw0NyR2+QF6gvTxBJHzD6flBqsY4b5RGGuuw3cyuARhCEtbJ8dC4d?=
 =?iso-8859-1?Q?JfpVzxavLDodXqxoRnG8rHOe7Rg7hzZhCEDiAUt+hpT3Nv/VFQ00e+d2+3?=
 =?iso-8859-1?Q?FEzwls15HXbpbVqY/8HK9SCYbxeDdCtJ8qYDGdoQ0kAquw9ruAjse25eC/?=
 =?iso-8859-1?Q?0gIZeEvYIfFDZtNNy1f7n6nY+b8rLKCrQhiimBLmzoK5e5a9IJQQXG7V6O?=
 =?iso-8859-1?Q?vq7GEeKtwXEUWgrluzCR1VLP3ETvJcZbDspf2ZpPHnplxVUuhJmQ+J7pb5?=
 =?iso-8859-1?Q?NyRbFLuVd18ko1gv1Af81wQ9WbcBE/fa19AcPCXFoWY3EKley6ATun1rqs?=
 =?iso-8859-1?Q?oxLNOhmU+24pmNMsyBGAKgtta85/RkyoeloEXVTntxNp87Lt+CUDaWWna3?=
 =?iso-8859-1?Q?A2S5pqARUuzWi4LPEYww4rVHx5kE0G9ERCQqSvkSwp+Pg4hCztSnkLKhge?=
 =?iso-8859-1?Q?WOpnV5SVhMrPpxegRDcVZcRoFKqMh4Op/YBa459L6JOnBcE/AbooMena+Z?=
 =?iso-8859-1?Q?5uIcZYGulPCxwzVWQLXGdTbOQFT3X1E/9zfLCW+9pXRuZ4poWFeALE9wjO?=
 =?iso-8859-1?Q?6n/sddOf5SFhbGCQMs/oJI4afDgfCsxSsg5uDjutJlTL913K3ihWZpDHTe?=
 =?iso-8859-1?Q?24qq2b+QGUtxHDwWwhFsLIJ5T+IqBSNxoZZRHnRUF1pxMp1g4FbomTfA7N?=
 =?iso-8859-1?Q?QrvbSSS2QwqPbqawX9F+vCOJBl5WCEH1tjMnaJwfMXHf90t0qieVgI+YNa?=
 =?iso-8859-1?Q?e/DTVu4CcmDQMff+DvzjiA+PwysrWmy8b/jrAdhZmz4Ipk/TWB9agJSBN5?=
 =?iso-8859-1?Q?v0vtagg4MCJmdSfn99p+1G/V3v+tuGYffIWRdFgtZJTrhwTooHX1R7gT0m?=
 =?iso-8859-1?Q?pj5d3MKSK5ywWg4mZ/Pt8zHlhTmV1NOKBd/scoBdG9MFRRKT5UTZRRaE8s?=
 =?iso-8859-1?Q?vz4OiM5Mx9eNLbJl8+CBXrxYEOk7hrM65crLKhAD51t/PF2xxaom++RCms?=
 =?iso-8859-1?Q?ySd72QQDJkGMzThgn3Ij9tJYwdFvksSIbqjyIEnAxR2inex79lK5nKNjDh?=
 =?iso-8859-1?Q?vePUitd5nOYHXZjWShiX8HxX2OWjvhSlFF29rOIOxtCs0fzxyky2vrKQiW?=
 =?iso-8859-1?Q?hW9VfaEnkna7iXt2KzDAyFeVn1KJ7lfCdOqQZeWxIQaBeVXJ3nF4YCEmUu?=
 =?iso-8859-1?Q?r1fE+qYeqfKxLTLbqZsNFTPKcnsSzwE3CpHYc5vkHegsbs4KcUgyxIACtY?=
 =?iso-8859-1?Q?mtrodyCxp5yN0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2027f220-f79d-42ca-4b02-08dd54ea0b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 15:43:54.3211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrRnBzpsDLSWSccsp6bMQwfQF+OggvuBPtS2LVIUJHq8wk1vjRX1JbqP4KiVgmoSQL/kmEdYd7MWvMS/+zqG8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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

[Public]

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - fab=
cad2e59577f5a3736f84ebdec17aff9b2d026 -> drm/amd/pm: Fetch current power li=
mit from PMFW) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Mohamed, Zaeem <Zaeem.Mohamed@amd.com>
Sent: Friday, February 21, 2025 10:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel <Dan=
iel.Wheeler@amd.com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/24] DC Patches FEBRUARY 18, 2025 V2

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Disable PSR-SU on eDP panels
- Fix HPD after GPU reset
- Fixes on dcn4x init, DML2 state policy on DCN36
- Various minor logic fixes


Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: update incorrect cursor buffer size

Assadian, Navid (1):
  drm/amd/display: Fix mismatch type comparison

Aurabindo Pillai (1):
  drm/amd/display: Temporarily disable hostvm on DCN31

Charlene Liu (1):
  drm/amd/display: fix dcn4x init failed

Krunoslav Kovac (1):
  drm/amd/display: Remove unused header

Michael Strauss (1):
  drm/amd/display: Update FIXED_VS Link Rate Toggle Workaround Usage

Mike Katsnelson (1):
  drm/amd/display: stop DML2 from removing pipes based on planes

Navid Assadian (2):
  drm/amd/display: Add opp recout adjustment
  drm/amd/display: Add SPL namespace

Nicholas Kazlauskas (2):
  drm/amd/display: Apply DCN35 DML2 state policy for DCN36 too
  drm/amd/display: Increase halt timeout for DMCUB to 1s

Ostrowski, Rafal (1):
  drm/amd/display: ACPI Re-timer Programming

Patel, Swapnil (1):
  drm/amd/display: Refactor DCN4x and related code

Peichen Huang (1):
  drm/amd/display: replace dio encoder access

Roman Li (1):
  drm/amd/display: Fix HPD after gpu reset

Samson Tam (3):
  drm/amd/display: Fix mismatch type comparison in custom_float
  drm/amd/display: fix check for identity ratio
  drm/amd/display: Fix unit test failure

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.0.255.0
  drm/amd/display: Promote DAL to 3.2.322

Tom Chung (2):
  drm/amd/display: Revert "Disable PSR-SU on some OLED panel"
  drm/amd/display: Disable PSR-SU on eDP panels

Yihan Zhu (1):
  drm/amd/display: handle max_downscale_src_width fail check

Yilin Chen (1):
  drm/amd/display: add a quirk to enable eDP0 on DP1

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  76 +++++-  .../drm/amd/di=
splay/amdgpu_dm/amdgpu_dm_irq.c |  14 ++  .../drm/amd/display/amdgpu_dm/amd=
gpu_dm_psr.c |  23 +-  .../drm/amd/display/dc/bios/command_table2.c  |  56 =
++++-
 .../display/dc/bios/command_table_helper2.c   |   3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   8 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  94 ++++----
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   2 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |   5 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |   2 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.h |   5 +
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   7 +
 .../drm/amd/display/dc/dm_services_types.h    |  26 +++
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   2 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  26 ---
 .../display/dc/dml2/dml2_translation_helper.c |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   3 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  11 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    | 148 ++++++------
 .../dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c  |  10 +-
 .../dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h  |   6 +
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h  |   3 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |   1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   5 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  66 +++++-
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.c  |   5 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c |  20 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  15 +-
 .../dc/link/protocols/link_dp_capability.c    |  33 ++-
 .../dc/link/protocols/link_dp_capability.h    |   1 +
 .../display/dc/link/protocols/link_dp_phy.c   |  16 +-
 .../display/dc/link/protocols/link_dp_phy.h   |   3 +-
 .../dc/link/protocols/link_dp_training.c      |  20 +-
 .../dc/link/protocols/link_dp_training.h      |   2 +
 .../protocols/link_dp_training_128b_132b.c    |   4 +-
 .../protocols/link_dp_training_128b_132b.h    |   1 +
 .../link/protocols/link_dp_training_8b_10b.c  |   5 +-
 .../link/protocols/link_dp_training_8b_10b.h  |   3 +-
 .../link/protocols/link_dp_training_auxless.c |   1 +
 .../dc/link/protocols/link_dp_training_dpia.c |   1 +
 .../link_dp_training_fixed_vs_pe_retimer.c    |   3 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  31 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 221 +++++++++---------
 .../dc/resource/dcn20/dcn20_resource.c        |   5 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  71 ++++--  drivers/gpu/dr=
m/amd/display/dc/sspl/dc_spl.h  |  16 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |  12 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  |   2 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.h  |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  76 ++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  15 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   2 +-
 59 files changed, 813 insertions(+), 406 deletions(-)

--
2.34.1

