Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BD2EA4E09
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 14:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC4B10E512;
	Mon,  2 Mar 2026 14:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFuQGGGB";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B2ED10E512
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 14:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSLjpiirSUNtLkz8Qdr6WWnCOK4Csq0KvaxKNlO1H9Z/2v0THqUwZzol3tosyJ1zcTnIb0t9Ob0ZAql5Wg1pDv0Ra7yYGNupOBWfaOjRZvvmaAwGwLuU/hlZP5XqZKcDSoqKYQYFWYxMbee2tGe67GgtJFspwULf01pvrwhTo5y2eJScHIt/VPmq7NJbSXKZUOar7bRFspHhDY7vWtwlrXzmKnKQuXVyPfONy1YFUtQAYpkNkPS0MbkQA2CxqwqXxUDkcEekVEBt+BIc1VgK4ZkkUQf30f/+WeYZoaUOX02gIz3IlCph1fc1j8LLWBsg0d6VmOK/svGDl9E781fscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl/C0hAbFOfbybzFhfA+zBNJnQSl6Bghwr7m5zNDyu8=;
 b=v88dH+HwXyQxOOTC2Itmo0ULsn46gSDP3brqS4W36qqP5097AATVApP5ccg283iXFB88mD3BRuXzd6MpDd61HGlbHm4uwfJZFHT5GoCy096slmGyZ49nnFsn+9Vcuj1rIPasT8dgxeJaWft+MaR/yeLwumcskenw7qKrBkgz1PzUgJCWL2xZ1fjdZ6A/wn9T7zUDIsy7S3qnSF+MMwCFABRcdJjh2NHql3ywOnLuappN4sVevXgz6EG6J9l6T6QefnH0ZWp70xLRbZEUGK8ez7l+4lMJjZMdydJtv0ATapsTWDNQ+d+LC7Dz/xv0lZOdNBnuzcIG2nuv93Z127U3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl/C0hAbFOfbybzFhfA+zBNJnQSl6Bghwr7m5zNDyu8=;
 b=NFuQGGGBH8x61DIvt5CZxMuLfc7y51iLOMIOoz4JUEhkhdpxaSVA/rCRfjLZbBL8NPmTioO8rGg5QLNtODDN/YgOHUqzDFvSEfPQyN3jfVUATPsW9qe9CYG692zAP5J3L9eR4zqXM5Ivjd3dEUmSQfO2E8pjBADE5IX/UQRk8XY=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.20; Mon, 2 Mar 2026 14:31:36 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 14:31:36 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: RE: [PATCH 0/8] DC Patches Feb 25, 2026
Thread-Topic: [PATCH 0/8] DC Patches Feb 25, 2026
Thread-Index: AQHcprMI9bgoal7zk0eFav6IACjBOLWbUa+g
Date: Mon, 2 Mar 2026 14:31:36 +0000
Message-ID: <DS0PR12MB653447CCC1878BFE0B0CD9629C7EA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260226000048.68030-1-alex.hung@amd.com>
In-Reply-To: <20260226000048.68030-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-02T14:19:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA0PR12MB4351:EE_
x-ms-office365-filtering-correlation-id: b288a2e3-62ae-4e49-1cae-08de786868b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: UYJO+ilNT31eT/84RgfHfbAoglR9RFzlySbuNv0FHTfWmQr4bnzk5k8EqMSAgD5fbh3bq1FTafFq7jIXIM6vGEO1hHH88ZOdtg4t4UhCjnsullILjKEMnYclZFvsKUKgWSXIV+qa9T0K6eUK5IhqLV57Tvn/3XI5JmgKzvw/pnUExg7afnHFA1utjJFNbuzcrpjsmoK1avRh1ogt3bGOho3PWKF1awQAvEO+HE81An9aK+p0BKb+a1UFIF3swRsL7AOTbNj4qZ+Kf94XrTMKQVywksV1+fpPPjLnweg9vfpaE1v4RGB88kIqERJbO0ptuhcLdr5dV2+X8O60u/Y62pQ1D6Cb8Cj7fy0bYUB8KFRtlwG9vW/uQN/l0z1HHIZHGCupGKic5KBdrfc2X92hX61R5Eo3ZAReBu1SjwCCRUaDUMFd9H9OWe3BmrggQbbay1X/ad8H751+tL692QuGSSaWnA0HBb5TA7pe5cz/TPrpZXRYvlrgBaq7ZXEubj7Vn3XY86Zncxp0THNzSLYd1MTCjQvGwoV3wBu+mYftLeOVPa70NnHuUP02NnblkiF+J/gbCMflQAKWITie5HZn5jgLicoIOEefC91OyMqwDQUZ7VLqWGsrv8f4AxMdeEMkSul5FqTAtXJlcTS1nypsbF6jwmfGtFXVWiBS0IAi1w2KDxXSUQbAT8xIIuMPr0IhDqtPHy09Hywu8y7Ukq3itUii8A2ZHUSMfpQYFKZVNhZ6ldR0LoTwS9jPoiUh/ZD2TIL90AT02WnZtS/O/xrgBToIKJi6ZJTrjYuV6uyQVzo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XZltKbQoNWaXACvJD5s5ekz7KwSH5+6Z5djqi4mHspkoDMRKxuvtNaqa1tzw?=
 =?us-ascii?Q?GTw+3Meh2OIqQdBpKCANmCrQb6bAa1JIb0Abdn/BfW6joMw4pLSp2gsWe2ld?=
 =?us-ascii?Q?3CsXN7C+W93dG+dffvB1DZw6DoVkACecZojVmxiy4Ct7MVmCubhKT+m4iD34?=
 =?us-ascii?Q?BjTdMGp4knbtKuhL78RnAfWMPpUMyS0ADb0+8aXxGTCVJoiMqFtqR34JeEN8?=
 =?us-ascii?Q?RlmMqQoJk6Lze+D21mFbXYUI1jDEJXCXu8hdQ3v1/0Q1oegmeptog2fWYt39?=
 =?us-ascii?Q?u8A37YsEN+ZPp3mClNDq0YMBvKpVQb8UiyijGHKLgj0q+zIldegWHw5+ojC1?=
 =?us-ascii?Q?n+1aMSZRYlzljqideEXO/bW2Mo/Tb65+0z6rblRMoLnFN6qgyPEZkWZ3frjH?=
 =?us-ascii?Q?F2NQTmpK/dgm1LzPSMLMWZufdw+AOJC7L2w0X+TBOSy+FzrcpQInZeAnGzae?=
 =?us-ascii?Q?D+NjDqIP8VSDVLtej1SrcOFHX3NH5bBUbOJR+hnitsivReqMvmvbpJH1z1tY?=
 =?us-ascii?Q?s4ADCbr9posl4WnjYpWvMaihmnCjcqLF3W24ZK4U3i1fv/aF/MhaNbxSurnt?=
 =?us-ascii?Q?cTsTtkkKMV5RNMqgs+zenVgzslhe0pHkCIlLpGTT/qTWZX4vTw/fUnGpDA8s?=
 =?us-ascii?Q?UdxuaNn4V53HJ4cYGsbeYiKPITJn9w/Cg+Vy5LEhJj+6RU4G2FTax5CrzBOP?=
 =?us-ascii?Q?ZGi9Caq96b3VaSF7fIKyVVpY/52IBZRwrqLWWkPAxZ9Ivk9r8uZI62QAB5AQ?=
 =?us-ascii?Q?Dsy0PvkQvT+CFhCoJ92FjuzHuhp+Y2zR1V9WwyRyJWPCL2MytnJBE2S/RdTj?=
 =?us-ascii?Q?cHpAdJPRupBfhABMgNqXDahqM31FMco5GDj7c9Qa50BP88BnSb2YRm3QhbL6?=
 =?us-ascii?Q?dJGFqs9IExlVIdr7xr7yJ4EWXl6c8vEBjvCM0AxR5XoP0DmC6enY+JwpEoBO?=
 =?us-ascii?Q?SvURExIYQNT4N9tX7NdD9Cs+wtJuYZSQKjBSh0Yya0RaGCETLGrNtHz+e4+G?=
 =?us-ascii?Q?wOHO7zliDYNvxBuF6FxEhE080WtBR7Fud6eIUki2C2UwK58V7VX89MIJMD/L?=
 =?us-ascii?Q?cbdVBwNzMHHe/09TPCArRQ0N8NAkumkEukoPlIV4aO4h4TP6sofLzbgzIbZp?=
 =?us-ascii?Q?gUvw4oeOeBSU90ocPSeFlINIRqmRhFAVI26UfzQM2WV1Zu6RiDkPuiN05A3v?=
 =?us-ascii?Q?lUo8bomkWYWd8KHDcOsphlfYrujD6WEau79l0V1JtQqhm6bLDlY10lBU8WVP?=
 =?us-ascii?Q?NKF5KH71oeHZ2Ra74eDcc2epyvcRcb/JtuErc3RiNwxZuNwcZp98AdYdFgn1?=
 =?us-ascii?Q?s/n3ywce1bP7oVeXDIhdJ6p3HahvckeHg6R9yNqGM1U2pNA8JZII3BWZ4bqX?=
 =?us-ascii?Q?38ZkPRW33AIjHzyKXPth+vWgguZBkXb2+1klqGT75oMoJTNr8vKhkQosWQRp?=
 =?us-ascii?Q?zQm5Y0cvC/QiY8D9iYI7qoyA6fyYeBchxmVUtb/WNyTC44OJQwJSemZ0DmEL?=
 =?us-ascii?Q?pj7I4C5mQr2F/kyyMXgT/DPS9zRgdvyFNaU96GkngI9NE5dJSEh3Z465cZpK?=
 =?us-ascii?Q?K2vJOH4v1CxlD4BmBUQ+tuos/eyEjjGDyCWCrWem4wVDmGDeVDxtMHvvgG/v?=
 =?us-ascii?Q?X+rrWA+d7ML8GYOGItzrFGgtfQNCwO10trv16Us68wZLcG8atw2sgds8Fycu?=
 =?us-ascii?Q?MfjCirgBeI1nKLhu7GNa3Bxp0RPKuAI5FwtDPCO0KTzA6AkX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b288a2e3-62ae-4e49-1cae-08de786868b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 14:31:36.0533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mr/0YYqWqXo5TAzNM2Tce/D+6fIPRpkocLLGV48hh1Lgtp+3KvQ+xwoC0gEcXPJwjhWk9yVcU8AC1psnw9Laug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 080=
9aaeac51f26cd340f626d6446c85b04919d33 -> drm/amd/display: Promote DC to 3.2=
.371) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

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
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Wednesday, February 25, 2026 6:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 0/8] DC Patches Feb 25, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:
* Prevent integer overflow when mhz to khz
* Remove always-false branches
* Remove redundant initializers
* Silence unused variable warning
* Initialize replay_state to PR_STATE_INVALID
* Fallback to boot snapshot for dispclk
* Skip cursor cache reset if hubp powergating is disabled

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (3):
  drm/amd/display: Remove redundant initializers
  drm/amd/display: Remove always-false branches
  drm/amd/display: Prevent integer overflow when mhz to khz

Benjamin Nwankwo (1):
  drm/amd/display: Skip cursor cache reset if hubp powergating is
    disabled

Clay King (1):
  drm/amd/display: Silence unused variable warning

Dillon Varone (1):
  drm/amd/display: Fallback to boot snapshot for dispclk

Ivan Lipski (1):
  drm/amd/display: Initialize replay_state to PR_STATE_INVALID

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.372

 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 14 ++++++------  .../amd/d=
isplay/dc/clk_mgr/dcn42/dcn42_smu.c  | 22 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |  6 ++---  .../drm/amd/disp=
lay/dc/dpp/dcn10/dcn10_dpp.c  |  7 +++---  .../drm/amd/display/dc/dpp/dcn42=
/dcn42_dpp.c  |  5 -----
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  6 +++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  6 ++++-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  6 +----
 .../dc/link/protocols/link_dp_panel_replay.c  |  2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |  4 ++--
 11 files changed, 39 insertions(+), 41 deletions(-)

--
2.43.0

