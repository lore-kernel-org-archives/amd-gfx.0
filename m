Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C380ECF8843
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCAA10EA34;
	Fri,  4 Oct 2024 15:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1F8XgkYY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E37610EA34
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2LX3TgebE0Aj8CSA4w7czHEGT9fv1rpMaMUuoMA8DUCKiYAVI5nmp4+5d+cNFb9Fba/RDI2tNt1BKz9mDQgq7TyCu82h+0jZqzZPVezW+LjCnVJBm5PMKA+z+u8kAwxvzg3HnAsBmB0kfpA+CoIDh6kEmZXRM2lcYAcfORaWCJWcx2+SeJj8WV0nxe0aQxow4TD7AaVAhK5WHC0Zv3/O65OZ0axTBVnjc7bnOReZAP27KeQFEXKluxu/wj8lA2vl5Kgjr7OFire/p38alpeqUjjAZM8XGXLNR/Amvjj3G3wPsg0pddQb8XWgOuYVkkIy7FQtb8DmGhC8O9CEhu+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KQdmD0WPasFWo9rqsoxFr2/kjnWw6bV5c+NFPoK5IU=;
 b=FWNiBUSYke8gJgwXZM4+aPVSIzRxsRtUQ6JuUsxRLu6K085L/XXZG0GqrwtvJ80I4sjKxGbCl6bw4DfX1bceZ8cEW5Xn6Kh9pdH/CfNOi3GGcQukv0suvjEcUNLYi530pIFbvdtK39CYlEuT8dkiaHSmS3paMmdQoRdiw310Rf5+8/pXGpjJN1HADxFlNXbIXVjACyNTN2/IvBCB1iVhnkYLZN6PU+0sY+lshXUltOlATfKmJTsW/y8k38KfCmogfcVzP8iTNzpsgIESNlZIkEpUQcccAjdpqQO/2ZB/CvpZWbVXNumEJMcDrflV6AAIvPQdj5m1MgU+cGjZz0zN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KQdmD0WPasFWo9rqsoxFr2/kjnWw6bV5c+NFPoK5IU=;
 b=1F8XgkYYa8SCrOiaVBs+sFc63bo+X2pUQJBPORsV6IRoOtKzSaPWG5ln066xekjbcmcvnSzJ34JpccZZt9KkMmrmOq24bxQrwGfBJ0oZ05WH0D1ua+W8Pt1Xjw4zQc/I9P3TjZVuJtTky6wp20XuakznL3DG3NKAk3yuWxLyaL0=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 15:05:06 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:05:06 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem"
 <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/26] DC Patches October 3rd, 2024
Thread-Topic: [PATCH 00/26] DC Patches October 3rd, 2024
Thread-Index: AQHbFez2kmgN7PoZqE2nmzK5hFT5Z7J2sXRw
Date: Fri, 4 Oct 2024 15:05:06 +0000
Message-ID: <DS0PR12MB653482ADC7ED0767076115839C722@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8f4d024b-c2dd-47a0-a77c-e1484dae1f2c;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-04T15:03:52Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ2PR12MB9241:EE_
x-ms-office365-filtering-correlation-id: 443033ac-6dc7-4e38-9152-08dce485ee73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?v8b1t2EU6FRPMb8XEFpLrNxsb1nhm7cqN5nBe868o+hCu0CyBhGsLpILSV?=
 =?iso-8859-1?Q?laHkdMI7kw0OruWBIzYi8lyyze+cQptMuAR7gw+azCnNSPkR+UxG5+t2Hy?=
 =?iso-8859-1?Q?KOybEKcgv8pslurBBETZXgIuDwdexomjYoVw/pZg4JH6l5yjDAP17jWC9g?=
 =?iso-8859-1?Q?8GZBpFxO/exlzSlXVVewJTfJ/qUnItjjy7OP5wnTPIWei0cTyn4S4c8m3N?=
 =?iso-8859-1?Q?HsfgcY2R8WpX77MQXVJZlYjmXXnL4VXeA3RKiB8ONRw8So2FEcVEZmKnqE?=
 =?iso-8859-1?Q?wv2u5PA27Zo8Vn+IMJn8pNwlAswfhcAF3oXJbVdCpQnq184OVnNihj+1Z3?=
 =?iso-8859-1?Q?F0bWBZUSFRED0nxoPUmcku44RfnZ8Vd4q1F1uLPoPT5AyMPBW8b8jwGzCI?=
 =?iso-8859-1?Q?8e+KqBVIugn1+IH0FxL0bh/bvUokYYHzSIFUGDSRAx/DADOkIQ4vOmLviB?=
 =?iso-8859-1?Q?+DrQ4EFh/BJ3BlbvAHQR3A7fiPRyDYb/3qi+SHTujscP53bCQYwzGoUOgs?=
 =?iso-8859-1?Q?z+UsOhOgmksx8zbhZsKgq02mx6xC/waN2aTBH6VydVICf1+ANtOgVAUrMb?=
 =?iso-8859-1?Q?BIwsR3MjvuWCLjfyAQQhFbzCPF6+qlN3PK5qJibd1kwWmCVJJD0CKHteGf?=
 =?iso-8859-1?Q?RyufhZ4wLYRlf5ZdQGpLBdDV6MoIOI3ipKPO63cjrRvyNicAxnJRcp14LW?=
 =?iso-8859-1?Q?9UDDvf+u+X2BlV/kX63eT1qp8nVCm3lpTyg1ayLRmQrWThMzETb7JuqBgV?=
 =?iso-8859-1?Q?7KvX1WKZcB17UAEtUiWYmS1FONevCznu6OuO3mc+l0dTfKTgUz9aLQODol?=
 =?iso-8859-1?Q?EqhmeMWgqI3RRwWdlc8PwJGFEgjPbQVE4knA4vinzAlKhVBXCrveI+LDqX?=
 =?iso-8859-1?Q?Aug79WUv5s/m4s6qi8XhW2UhzsIBNgoyJKVidrZi7isxY5+Pq9yu/Qq6W/?=
 =?iso-8859-1?Q?Qhlj1E5iX3N2RF4wqwUDpc5TsCBHKk3e22edFc2eEeeFVeL1fJxfrDnI42?=
 =?iso-8859-1?Q?Xg4RV9mpsINUWZvc0MoMBTyqR8h+wadxzDh8hgjmzXIAn41YqpF7IUK5/0?=
 =?iso-8859-1?Q?X7PB9QoeYXTZCu2vzocqrRKOQ2WocVEEeBoX7DrlcGjWJHo3be41+iu0ok?=
 =?iso-8859-1?Q?yRdraqhSZ1vD7udRfBJ2gk38jfm7mrt5bIlRi86yyTM9li0EEXi4RhpR8H?=
 =?iso-8859-1?Q?ZUAQAsxL2oy2+jPNtNSoZFP6HK+RFDrH91mdH49MKPTHJ7CnXO+UJeQh/C?=
 =?iso-8859-1?Q?Sl34VidaBGZvzpsghxCns8zQ/yEmsYgoOgvKUjuB/Ma/Vp/P51/VVaSf/E?=
 =?iso-8859-1?Q?2BW55IAhwwz/lHpZW+HjCcQ4uQhiS052PtT3f59OiLDqcHPgDJsPXnf4kE?=
 =?iso-8859-1?Q?9F8awhqqmDKkgFx4T3J534FsvbGfdU6Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QgkrxsZGN8osaNoZl6Jkm5nJS2JF8zIiKmy8C1mTsZ2styVooy7rmT3sX7?=
 =?iso-8859-1?Q?3u8t5ssX156JiBj7xGvek2/6LefCb4a4j4xQLUjVl0zDK1QbixwDsYFIa+?=
 =?iso-8859-1?Q?iT0m2xUZsNNcIVfsMVp4vk51hHX97jPCWClwg2ti8Tq0hsw9bXVaP8iOPQ?=
 =?iso-8859-1?Q?K+Jab800mlT/q+pfKh2xiWRv2+Z6jHuT1eWdEq9RevedMAJkoqnuFRQFK4?=
 =?iso-8859-1?Q?dewupPVHTUiDd3m5Xd43TDoy+AEvJxXWFnPEjt0xS+u7NTnckSLXXFlKXj?=
 =?iso-8859-1?Q?I4x+INOCZIlIo+t0RcrkUaYy5PdeCpbDS01htg+LtPF9AQ+yL/DIww+pne?=
 =?iso-8859-1?Q?DwVHwL1rvbsTqGcy0kIfg1b0YCIUaxUMZVOQ4lGZfbJeE5n2g76uPg9lI1?=
 =?iso-8859-1?Q?XncVC4ZxE99PjcyyKBo35qOQLsjaj3JSul/0KMAC6NmNfzMrdHCSkZvmpe?=
 =?iso-8859-1?Q?q63TNxYgkOhzHtj+BQkhGi0Y+gWX5Ms8qy6wEtGBZ36b9nivS1k9BBPwjP?=
 =?iso-8859-1?Q?C/cc1ThV8jIO1tnWM8OcRTHTmnWzZzuuhULVaMRaUJulKT64wkB1kz8Jy9?=
 =?iso-8859-1?Q?3dAAkWomUx/Lylb4Xht5UvcPp7XJmbYW18fhwUeGwK6pCAXYZg8hba4ylH?=
 =?iso-8859-1?Q?GGPL08xkGGQ8MLdjHW04yYduS/cCHQa2+icbQhgnAFfAybXeotreU467qa?=
 =?iso-8859-1?Q?nE7sD0dXra+jQSf6s+KW4ruEymL3PDDiLrqxPLaezBrkeGA/070XGYnNP5?=
 =?iso-8859-1?Q?4Sm+RMOH4vjLhzkqCGNTpvpzrfKoY7kr/OdQgXlEf8btaOFmk7TwN7eJMi?=
 =?iso-8859-1?Q?8Ack7Cdf7d5aJ5tP1NE/vA92VXqELUZznRcDlgTEJMv8sqmQYU4we3Qjeu?=
 =?iso-8859-1?Q?qE76pWOigJip5Mj9pyByuSk8IQmgL8fNLK1jDl4fhRwYHTFbzcCXNDPvQ9?=
 =?iso-8859-1?Q?NjifJD5lhEmU09hiNex8HsEBkhnxp/WFj7SWmBbUqmTivTkk2Ywb58rD+7?=
 =?iso-8859-1?Q?iCjMkWO3/MUQBz8mnxr2IAhPAfNtqCAsKl7bcJAiJUQyveHSioKqE3nxiY?=
 =?iso-8859-1?Q?iozfzWvxawYNQmnuoQIfpv3DSp49e2hmWo0r7H4pPmQtc2hlGBD7H2nhrh?=
 =?iso-8859-1?Q?TxkF+HlEvbBwOkX4ZRcBILOYz1usPSrBVj6QQctLAqNZHnejUC0spXOGRn?=
 =?iso-8859-1?Q?h12d9AdhL+xQoqeYTmXlJmvTtLAR6wowQbfXcuf/7P9DCN5ADg/GnD21+5?=
 =?iso-8859-1?Q?9Ahv31QU3E7mWtJ0BLwQRuPd3E8pzM8eJI9ZMJV/Va2RdiH70Tx5O3YHtE?=
 =?iso-8859-1?Q?V98ZKQ0ZN1GObox9O629xRZs+nIuv5EWHsSIDTHHG+HzqavG/B4ibFUAAo?=
 =?iso-8859-1?Q?hMIc4ZRu6yyyCASCdy2SSGnhdG4JWcQioy/7b9D32gURj16Z6bB0o+R9nl?=
 =?iso-8859-1?Q?zLUJRrgFrL3BByIVZfzlfE/xYmvttUWRrsFWvD3QyfQv/kcGO/igZwmGNL?=
 =?iso-8859-1?Q?CBYDROjM95+Bn0Ja1hbrOwlEHltdPo1eAJxNKe57XcUvW3fX5AvISKymLF?=
 =?iso-8859-1?Q?2jwmJUomF4Roh+2X7dijufqMdLW4rKm6epQwQnEQsKmK3TAwgNKD7GKmOg?=
 =?iso-8859-1?Q?eSiXxsuzFsMpY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443033ac-6dc7-4e38-9152-08dce485ee73
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 15:05:06.1733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70hcsrVS+e+XK6Hk0BrPSZ05QyFTDRzhSV+h8aCpBKBF9l3HJoAyErXJu3GxcWSaDS7LNTHPyT91FsGHuX6cNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241
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
        * Single Display DP -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz displays=
, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * PCON -> Club3D CAC-1085 + 1x 4k 144hz

DGPU
        * Single Display DP -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz displ=
ays)

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

The patchset consists of the amd-staging-drm-next branch (Head commit - 9bb=
9f6059b1b13cb7d439b617086caf5cf0c9f5f -> drm/amd/pm: remove dump_pptable fu=
nctions) with new patches added on top of it.

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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Thursday, October 3, 2024 7:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.co=
m>
Subject: [PATCH 00/26] DC Patches October 3rd, 2024

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Improvements to seamless boot.
- Adjustments for DSC dock.
- DML improvements
- DMCUB fixes for D0/D3 and new register offset.
- Code cleanup.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Remove unnecessary assignments
  drm/amd/display: Remove redundant assignments

Aric Cyr (1):
  drm/amd/display: 3.2.304

Aurabindo Pillai (1):
  drm/amd/display: fix a memleak issue when driver is removed

Austin Zheng (6):
  drm/amd/display: Unify blank_phantom and blank_pixel_data
  drm/amd/display: Flip All Planes Under OTG Master When Flip Immediate
  drm/amd/display: Revert commit Update Interface to Check UCLK DPM
  drm/amd/display: Allow Latency Increase For Last Strategy
  drm/amd/display: Move Link Encoder Assignment Out Of
    dc_global_validate
  drm/amd/display: Update Interface to Check UCLK DPM

Charlene Liu (1):
  drm/amd/display: update sr_exit latency for z8

Dillon Varone (1):
  drm/amd/display: Remove programming outstanding updates for dcn35

Fangzhi Zuo (1):
  drm/amd/display: Skip Invalid Streams from DSC Policy

Fudongwang (2):
  drm/amd/display: skip disable CRTC in seemless bootup case
  drm/amd/display: force TBT4 dock dsc on

JinZe.Xu (1):
  drm/amd/display: Noitfy DMCUB of D0/D3 state in hardware init

Josip Pavic (1):
  drm/amd/display: Clear update flags after update has been applied

Kaitlyn Tse (2):
  drm/amd/display: Initialize replay_config var
  drm/amd/display: Initialize new backlight_level_params structure

Peterson (1):
  drm/amd/display: Fix low black values by increasing error

Roman Li (1):
  drm/amd/display: Align static screen idle worker with IPX mode

Sridevi Arvindekar (1):
  drm/amd/display: Assign socclk in dml

Taimur Hassan (1):
  drm/amd/display: Add DMUB debug offset

Yihan Zhu (1):
  drm/amd/display: calculate final viewport before TAP optimization

Zhongwei (1):
  drm/amd/display: Fix garbage or black screen when resetting otg

po-tchen (1):
  drm/amd/display: Display lost signal on playing video

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  32 +++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 +--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  13 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 103 ++++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  57 ++++------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   4 +
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  25 ++---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |  25 ++---
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c |  10 ++
 .../dc/dml/dcn20/display_mode_vba_20.c        |   3 -
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   3 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   4 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |   4 -
 .../dc/dml/dcn21/display_mode_vba_21.c        |   3 -
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   4 -
 .../dc/dml/dcn30/display_mode_vba_30.c        |   3 -
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   4 -
 .../dc/dml/dcn31/display_mode_vba_31.c        |   3 -
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   4 -
 .../dc/dml/dcn314/display_mode_vba_314.c      |   3 -
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   4 -
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   3 -
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  15 +--
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |   3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  20 +++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  46 --------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   5 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   8 +-
 .../drm/amd/display/dc/link/link_detection.c  |  12 ++
 .../dc/link/protocols/link_dp_capability.c    |   7 ++
 .../link/protocols/link_edp_panel_control.c   |  11 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +
 .../amd/display/modules/freesync/freesync.c   |  17 ++-
 46 files changed, 269 insertions(+), 239 deletions(-)

--
2.45.2

