Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853B2C5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1354910E7C7;
	Mon, 17 Aug 2026 12:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mNSirAfl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD7510E7C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 12:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAY4gwn2qNp2IIbctu21teKHcMitGjEKKYYlbiHZmjCdcJc7/+AVnSoiZSRWImQSD9M7qrwRHwYsE9NXDfyXfRjayoTHOpDbz3dg9771XGXkoF5reYlyQpKLVBYNuHe1gi+0nCaqaHc8bB9KrbpQeP+7VjYHD8ZIi6tMpiFAy/2q2yj23ufDHcgSS4r/JvIbj+B3tQsKSAW/I+UsrCavbB3yojP6dNcH0nvk0ejaWh84qtNur6iIsvoRY6lcWeAqkvMa+H3VbnDDSC9rbMAKQ3s5673ZjIa5UpWIDmukcEQn3jfQuI+r2/nRZAMQiJp1RkCPqFA4HXYxpKFzPWdK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9saZvZL6qJdn5m8TrtU4sVKRMaMXlw7T4yYiFzqqJo=;
 b=RUWNqg+eaueI9+eGV+eChzx0l3k8WZG6YCkGTqCgN4zNHH741fGi0YnmFhaL8GZiipLPhMuz4IuJDGbZtIVNHS56Sav9hJRv94FUvDjQ/uDp+aPsT8Mwaoq+zzNwfO7AS7C3eS8vAqD9oRLHftQ7CVZscU9IiWDIsVug5QQ8YCN0eCqoGiES4LY4onh5Kd/8+3nsPdYj48PW1yCaXvclxxXLgQbPvkZ/K8eokVMGrURrb/kQv3uOWAAmPq8sfJ5SnCyHfS70uAC1mAPok12VJm0tJDR1/NjHdR9fthqy6VFVa8gI1OUCpgV26o5NiTJnW5p/wlYeOI2XutwQspeYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9saZvZL6qJdn5m8TrtU4sVKRMaMXlw7T4yYiFzqqJo=;
 b=mNSirAflNuIp7F0zRAfIji+17vN42XGHVUSm46xMMxJXlkJAmNZGL58NyzcNK8ntlFX0Tx7Xxw08q/mFXuzXVOh3RjQW5xQt+i5B7hUgLqbuNBqplytpGcJhoyacVnG+KJDX06tQhcqiqymgDBLMcvqK9GRn2Loy6SPD56DXUyk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 12:59:22 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:59:22 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Ping Lei" <PingLei.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/24] DC Patches Aug 17 2026
Thread-Topic: [PATCH 00/24] DC Patches Aug 17 2026
Thread-Index: AQHdKajRBgJZdT+ShUOFHJIMAfLspLaiPNOQ
Date: Mon, 17 Aug 2026 12:59:21 +0000
Message-ID: <DS0PR12MB6534E54A500E0DCBF8B254339CA72@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-17T12:59:15.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY8PR12MB7289:EE_
x-ms-office365-filtering-correlation-id: 4a59e6ce-152f-491b-1c34-08defc5f5b5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: XjBf0LQaDto7sVFEXRYLcWXbMfV/CG2kF0Rxx3xN54vVhsQMsj1mNH0VfTKIlQUnQRKqBQjOxBFyVTkPHnNsw3Il5NlYtRLDxw0IIecCLMVVmQZsUni1zfKbdmSvXtcS4W2iurKfU35lMfy1+euomGs93QuWsO+JYXyw2VOmkPf+i2Tx8mO1uRnPG4wWNZH4FfOc1rp4LWeqD0h7jW0vUh44iQvQx41I0AN/oUYLiSDsd5zb4V3/sWfR6rtIXfnUtzUy4HfqfQC6rdZHddInjYc6Mr6LTuu6KfPHpozE0698w5Sx6LHJ4qGORvn3Xf1wQX/6dZczz+BIMMC8pYjTpmKxhOqDGcSmXK2jGt3DidwEDP1KgC0x33487BSez28i+DKhlUqrkK54EyGTe41Wl1lEfmVp5eLgUSWnGI4imLrq9fClXir4q0QWuIDRthya9Ui9bcb0/pV7BpOkCybd+PKpZhdSdS9TSbb65YZ9NIJiKLCcOIr3tTfW6LNf0oxlxeqbSf4fyUctzgtsql8Rh3WsuLMCVQbG1sqVp8BCsEJGGV5mQ+u+GRaunAp4Uiq7ZezWOhHyfORuxsFCKpkrjAyNdUw9qyXOtaJt9chiNXo4jZQIm3WM7LV6ksXxELfblQFdjr5u575H1gi8iRYW71hXIaYnlroa+spvJvC06+Z7YMEWyVBt9i9xKzpnrLbgO2UuHHDMoHCqt5bgyugk0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?90QaAf3ToHlIbDDivmJDs5Jq80NobYq8BrL0uUevCUj56Hd0ynziU14Sdv?=
 =?iso-8859-1?Q?I5uueehOub6L3k+eifFpM4OEajZZiVNIQ5R73VNphTjJqOAIauUvO6cDfg?=
 =?iso-8859-1?Q?wkVTPfQc1Q7T1zFhDOCh5HHSJjmks97zs/ewZL7I/eXPaEYULGshPkXgjz?=
 =?iso-8859-1?Q?YqOWIpamm+2JjKTACForIg0cAgmc5AeM86VmiL3nvzaTTgHEWrVBQOWvUk?=
 =?iso-8859-1?Q?EKA5S4+g6t5DSbCvo9uL6VKaDfP1rNnsYz4RWfNRx4na1h12VU2JpismGu?=
 =?iso-8859-1?Q?zvSSh2m2nhwtZlI+L2ZlhB3ETTiCIkw+Gc20I0isWfbzZL9f1b10Ty3wDL?=
 =?iso-8859-1?Q?lJnHTd0tXSROaLcA2rUGKvH84H7zQBwKSz+wGkM4LN664O/ART6uNR65Q9?=
 =?iso-8859-1?Q?nXrAoUTQBBUeGZNC3iN5wcXjy4p2ldePiYAPuDSTyA2xAl57EqBlbSDC72?=
 =?iso-8859-1?Q?FXP/QogCrDKWPoxx4JCobSWJW8j7OqQqhnx+faAqLBaZbk9zaF5u7rCc/x?=
 =?iso-8859-1?Q?LAblAAF1hzwsGUdZJHXZPw4VgsKxY8BtxOTJV0D5UI2qHmm3SMPv8T7ju1?=
 =?iso-8859-1?Q?OnQSJZcpYNOmrpoGzUGHsLYOTg3QNeebB/qBURKDUi0qiymdm9HKE/1r0C?=
 =?iso-8859-1?Q?S/2xfuejfv4OnuP+pQwdFsl6axxJDCVbzfOS/YEes3l9Kn7EZ5mk8sIHsq?=
 =?iso-8859-1?Q?eIOK2ztRmxSeTGbtC07MA8/mq7dol9Jm2AgJcud0mMm3xA+noGoMsBXwtT?=
 =?iso-8859-1?Q?PwzfKjZ23w5QenlN1CPsRXIkCerWmELEah86U+y6kFnARDFDWMuGAKLxiF?=
 =?iso-8859-1?Q?UTQoaDsbT4GhkR8RvpfDL8hjebjW0STFdmZbDe8Bm+7ontKekXoP/UU0D7?=
 =?iso-8859-1?Q?IzJYkDEvuZ7QrpMtY1onUgTEjqHU3a2A5hlsWO3sNJl83aJaOTayGFiqO5?=
 =?iso-8859-1?Q?VVuARLPQZDiLAtOVR+rS6UVhQBiHsZWqXeP8SRdDfmH/5N8djEV6EHCon5?=
 =?iso-8859-1?Q?YihiUHMjYfkKqUSjhyUuNKCBGBZ3yLOQUnlqftMgEhG1+N96TE9ma67gxH?=
 =?iso-8859-1?Q?qTX5Lk23TQBOP1SFrVZY64P+dS/cfbDH2Vb2njoJBASGnplEq5nSBrzVZi?=
 =?iso-8859-1?Q?U4ZBzoMJFsaPVTCHae2gYdIB5kaXBQYtUnCDpfSoN8qH/dWgsHz4u8PcNi?=
 =?iso-8859-1?Q?Ais7a/o55p+ixy3KSmFNOJmIW2xHv/1Ny10+b9O4b3yaLCczAwmu4jPfOn?=
 =?iso-8859-1?Q?NeyoqGLppNKW8JaDGCbTC11mqDjdphMRf9/7NXVISetJRpiby/Y2y/tIxW?=
 =?iso-8859-1?Q?LA4wf+lXrOrpYIkCl6xmbFdcYTC6zoSI5QiEvauw95fNcXM5hwhuR5ghWP?=
 =?iso-8859-1?Q?jrCl0xibC7FoD9sY1Gs+ycISNKagHLuyHfaEnSxU7rZA0nr6RrpqNs0pfd?=
 =?iso-8859-1?Q?KkVqqe2VkBNIWR5mTX34v22dKZTFW9OUPTXACHm3olYyRqW/7GE2dO7DV9?=
 =?iso-8859-1?Q?bOCl0fNqgLBhl7dU0HSfsNTnYKPm39mo6WNh869/U9ENGp3UdVVSynfBQ8?=
 =?iso-8859-1?Q?L3WLQVEJZCdVU/BtqH6mmXYb/6wRBGscGnifL8ZvQGXgDuoYM+xJd3OgMO?=
 =?iso-8859-1?Q?JgPKOD48mk4pDSZVHYOH9/yl4V5JjpXlGuECKXgWACIB9II3zHzhu1Ty/S?=
 =?iso-8859-1?Q?HR8WLJ8NX5p0Lu5LMoHQbawolpQKA5si1DK+kh7C1U6ckd+YCUnQeusxur?=
 =?iso-8859-1?Q?DH9dR2XW2mIFQyKfDbk1FGf3fq7z06CtNV5VLXKZEid7Qh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a59e6ce-152f-491b-1c34-08defc5f5b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 12:59:21.7824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +npW4507e0BCjjoYGimu5vaHP07Ce4McExZTu3DlCOwkqbIPLa6FFDhxNOahNwyV0jlOeKCCw70iDS4zgGtc2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
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

Public

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
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
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 856=
090adf2d66a238b662894698c4aee67dd88fd -> drm/amd/display: Promote DC to 3.2=
.393) with new patches added on top of it.

Tested on Ubuntu 26.04, on Gnome Wayland.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: James Lin <PingLei.Lin@amd.com>
Sent: Monday, August 10, 2026 5:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/24] DC Patches Aug 17 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Reworked per-DPM derate handling: refactor the per-DPM derate logic,
  update derates with default per-DPM values, and move the
  soc_and_ip_translator onto the new per-DPM organization
- DCN6 mode-support and UTM work: opt-out for the OutstandingRequests
  check, a utm_support capability flag, and a guard against an empty
  DCN6 UTM QoS table
- More DMU/DMUB offload: send DPM0 clock values for Z8 retention, allow
  DCHVM<->rIOMMU SDP port disconnection on DCN42, and add the DC_BLS
  command
- HWSS block-sequence cleanups: move periodic interrupt calculations
  to HWSS, drop pipe_ctx from HUBP_WAIT_FOR_DCC_META_PROP, use mpcc_id
  instead of the hubp instance, and add a wait stream regen event
- DML updates: unify CalculateFlipSchedule logic and relax the frame
  size limit for the dcn5/6 core funcs files
- clk_mgr refactor renaming carried DCE clock manager functions for
  dcn10, plus a missing-prototype build fix and a static DCN42 SOC BB
  struct
- Expanded IGT/KUnit validation: CACP ACE curve area debugfs and cursor
  mode tests on disabled CRTCs
- eDP fix to skip teardown while a forced PSR is active

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Austin Zheng (5):
  drm/amd/display: Make Struct In DCN42 SOC BB Header Static
  drm/amd/display: Refactor Per-DPM Derate Logic
  drm/amd/display: Update Derates And Set Default Per-DPM Derates
  drm/amd/display: Unify CalculateFlipSchedule Logic
  drm/amd/display: Update soc_and_ip_translator To Use Updated Per-DPM
    Derate Organization

Chenyu Chen (1):
  drm/amd/display: Add CACP ACE curve area debugfs for IGT validation

Dillon Varone (1):
  drm/amd/display: Rename carried dce clock manager functions for dcn10

Ivan Lipski (1):
  drm/amd/display: Relax frame size limit for dcn5/6 DML core funcs
    files

James Lin (1):
  drm/amd/display: Add missing prototype for
    amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags

Jun Lei (1):
  drm/amd/display: Add opt-out for DCN6 OutstandingRequests mode-support
    check

Karthi Kandasamy (1):
  drm/amd/display: Skip eDP teardown while forced PSR is active

Ovidiu Bunea (3):
  drm/amd/display: Add DC_BLS command
  drm/amd/display: Notify DMU to allow DCHVM<->rIOMMU SDP port
    disconnection for DCN42
  drm/amd/display: Send DPM0 clock values to DMU

Peichen Huang (1):
  drm/amd/display: add wait stream regen event

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.71.0
  drm/amd/display: Promote DC to 3.2.394

Tom Chung (2):
  drm/amd/display: set base.enable in cursor mode tests
  drm/amd/display: test native cursor mode on a disabled CRTC

Tomasz Siemek (3):
  drm/amd/display: Move periodic interrupt calculations to HWSS
  drm/amd/display: Refactor HUBP_WAIT_FOR_DCC_META_PROP to drop pipe_ctx
  drm/amd/display: Use mpcc_id instead of hubp instance

Wenjing Liu (2):
  drm/amd/display: Add utm_support capability flag
  drm/amd/display: Guard against empty DCN6 UTM QoS table

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  68 +++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   |  24 +++
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 115 +++++++++++
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   8 +-
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  59 ++++++
 .../dc/clk_mgr/dce112/dce112_clk_mgr.h        |   4 +-
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  |  14 +-  .../display/dc/clk=
_mgr/dcn10/dcn10_clk_mgr.h  |  12 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   9 +-
 .../display/dc/clk_mgr/dcn10/rv2_clk_mgr.c    |   6 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |   6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   5 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  10 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  10 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  10 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  10 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  18 +-  .../display/dc/clk=
_mgr/dcn35/dcn35_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  18 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  26 ++-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   5 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |  11 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 136 +++++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  18 ++  drivers/gpu/drm/am=
d/display/dc/dc_dmub_srv.h  |  12 ++
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   8 +
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |  39 ++--
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |  25 ++-
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |  27 ++-
 .../dml21/inc/dml_top_display_cfg_types.h     |   1 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |  44 ++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 183 +++++++-----------
 .../dml2_core_dcn6_funcs_mode_support.c       |   7 +
 .../src/dml2_core/dml2_core_shared_types.h    |   3 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 106 +++++++++-
 .../src/inc/dml2_internal_shared_types.h      |   1 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   7 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  60 ++----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  24 +--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |   8 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  23 ++-
 .../dc/resource/dcn60/dcn60_resource.c        |   1 +
 .../dcn401/dcn401_soc_and_ip_translator.c     |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  39 ++++
 .../drm/amd/display/modules/inc/mod_power.h   |   1 +
 58 files changed, 924 insertions(+), 412 deletions(-)

--
2.43.0

