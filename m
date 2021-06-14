Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75166C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 13:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356996128C
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 13:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356996128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B322489DB7;
	Mon, 14 Jun 2021 13:23:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC1689DB7
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 13:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnsvTRTb6ql2hbT6IqMWsG8ZfNzlUMdfmu2XjFQWXF/sdoSNY7ad33oV+3KV0DM+vSzV7vwVZ4UE+/Z27YYO+jm7X14lt6yErjEvd+aPvjsqOFTW4nJuYxjzz/I6zgYIVEKOXuVC7lOboKnHGtr9PvMuqRlNz/Igo+lJvSWLVwlf+JnTdckYcACeIV1Qe7yq1ssZaOZFpDRWfymYANGCBBIAo2YOmty0s8Hm470yc1YuKwi4OMSba2D+NaImv0AwpJ+7kPUCm8vuSkHWlKzPHDUJQYxFgz3iTbum+kYAglKI6Y8osVBU2tBtQx3/z0mBhaO5huJmJxN5rA7Cz8LmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YULdvRAFHdf4HynITusqUjlAGvTMVYIYSt3V1xjwN+4=;
 b=WrGzc1xVzUWGuQc3My7jSDZdUjrp5clNDuWz7LL6QRyvnko1dRFJKU1qvFeg/smbFkeMSHaVxfQl325Lp527mkNIJsOnI2/4B42ZgUarVJiZLaQ5/IN627XsYTl0qi/oWd/9RsIl7l4nbU8Par8gp4dwWBrBsx2AdTJWOzTP8dhAPYxDAc7tXPha3ceN8nLn0PjbPIn7NmstvQn09Cb2/RJyva6fNtFLPa4+xEgGmF5Kaxkx1zrJ+3Nxt8Z6AJ403mMuLYFLBpyf7E0/HvDYjY6ySbechGKucu0DLEZyF+J+/YkT/qePh3IH1zaCjsBPWG7Qc5Sk1RLQfU0wz4JLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YULdvRAFHdf4HynITusqUjlAGvTMVYIYSt3V1xjwN+4=;
 b=Jz6UTDlchL5weZPWCXdoI3RWDgQTLvhWHIESq7mYRl16Nvm86qYDfm9QZp23TmYs1j8Ad/pCITn3F2GmmNVN62K4XjPyPV8uzFH+qmyttZQX2C2P4N38G+AN41wskkEfoNJ29SmyvZBRucSQTLL0VUXbkXH9rfssP2EJQXnxo/o=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 13:23:14 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 13:23:14 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/24] DC Patches June 10, 2021
Thread-Topic: [PATCH 00/24] DC Patches June 10, 2021
Thread-Index: AQHXXhXAr06HTqB6KkeqBIg8aGxt86sThJiw
Date: Mon, 14 Jun 2021 13:23:14 +0000
Message-ID: <DM6PR12MB3529075C315C1706971A918D9C319@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-14T13:23:10Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=904c9190-ca64-4264-9d38-a2b736286110;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [76.68.110.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a43bda0-e03d-4de8-62bb-08d92f379084
x-ms-traffictypediagnostic: DM6PR12MB4909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49092104BBCC9928FEBFC9869C319@DM6PR12MB4909.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8RMHwK1C49ooX+YvRC7oomhVEtatzRFg/8Xn9jC6JqHK8yDgBM+2UGDlUr37LA5Nm0PDEIbvWHcVl6vC9z4iDbwfjkbWb4J4zYag04E7rAtgea/s/vH55k+V75bWVCwY0UAgWvX6Vxk8/+TGUodSddia9WtgpdovGpUv2ZYJ4Hcu4EnQZwkMP1JYGcYhEWk990PlLwo3kXsmidTsUSURE4RqElfd+AVtWtbkg3L8z1hlLiPqiHUtuDNdNI3Jipl6YS3SDD40F7I3J16X9l6Spy1RMTNW81mR7yza67o3TCCZUC+zKT5QBCpBft8CCNSknhINUGbXMavqOgtcps8Ng7NMWg6W5MEck5sZc/4Xbn6x291pEMDYRSw+KpapJS0zFF8GJoe0e9mviZ7ciO3KwGxG0Nw/XPT5Ubl2HNtnGJCIPNDndNBRP4Fg3fc6T9LQNzRrfpGZW1cPJ3GVuiN9vUzqOnum2kk4GVBSbhncq3MzX2yByaFjIojcuQlRaE98tb7Boe0TztU6BjIFqfsM7dxJWfHUfoGrk1CHp/HrhMfHD8LHh7LhTiHw/zEnyD5fTH7Bm4FP+dfjOfDmWQRJDItJDg0MYxY1Ir6IvJAYG9DMxjrp6e7dQKjJmhHQGOVJOBHcORstS4KYzvSw8HKjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(478600001)(8676002)(45080400002)(186003)(71200400001)(8936002)(110136005)(9686003)(54906003)(86362001)(52536014)(26005)(55016002)(38100700002)(122000001)(76116006)(316002)(6506007)(33656002)(53546011)(66446008)(7696005)(66556008)(64756008)(66476007)(66946007)(4326008)(966005)(2906002)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I3hVm4FicsEoJC9RCKUx+j131zWQyvq5GCndW6ne/UcCsK7JPme9BEHEOa?=
 =?iso-8859-1?Q?VaYBGFWaAtiMkLa6Hw0McHqAfxZAyh6wBOZlPHY9itpL66f9v1LOCCZ+0V?=
 =?iso-8859-1?Q?JgcSwjEzMkzTLqu/EszUPc3tA/AIqA+5KZRfkzWh2uLTdKqb5xSNhUCmSX?=
 =?iso-8859-1?Q?xw7ua8bou/iIwDXtAnw/XLrEHp6jZe9DlaCAsn/AcASmfSCH9TZCtfqk4M?=
 =?iso-8859-1?Q?dvmreka7PoPX1N2yWkQ731NECjeiTbEg4BELDwivFRhVA2OISH16c7NZdm?=
 =?iso-8859-1?Q?Q9VJ+PoTu7gEXpboHF9Gp/fli8tieMkTdM/I4KJSIJiscIIyZBxYmGUMbb?=
 =?iso-8859-1?Q?oKieOoIrJ64JuuZRgqBpDOImvIkGMWrso5p3zrElmYOCLwu5CYE38+aWt6?=
 =?iso-8859-1?Q?9ujQ6ViYziXgb3nSDZQchwnq4vU5lSy+/n6R/TuCgvGJLWRi6jm7x37DwU?=
 =?iso-8859-1?Q?Xe2M59muhqx9y2fp8mLM4RYdVYI6d3/m1sj21SH3EcH8RPDKcx+sv1OiaK?=
 =?iso-8859-1?Q?XJsX52zLgVhiD2tkcMLfPi3QEm/MaklozRT9tycISHfINq9F0Mt2BSzLnY?=
 =?iso-8859-1?Q?rDVLBCe4gmQQCya2QI5zHpwA5fiEDvEHtkeQ9JpOF3aIUbKifmgrwg1hDh?=
 =?iso-8859-1?Q?knSw+QVYHD4lrkeij2nvMhENMmBJHSiqfDarsn1FdQiGMdVVUHXDMiA19Q?=
 =?iso-8859-1?Q?QKexzRihQadJzgUBEayWANnM1Me5bL/t4TMg5X7Oc/mzOvzjjQqr0fNMZw?=
 =?iso-8859-1?Q?j4Vg8h0aQQEIoW/GiBVB9ctH2g0PSVk1qVoe0tthn4NuKZGH35/hqyrNd8?=
 =?iso-8859-1?Q?+iOGR5sn6wrk+c4DpS3o9qZ41eMjyuGV6qeRk1dwCcVbDFKp3MNEv4ZNBy?=
 =?iso-8859-1?Q?CdPd9wFRp0AtRH/9iqUQ8NWj+efN48HDb9UHLVOrmPoEMaHPxTLFAqLh7Q?=
 =?iso-8859-1?Q?I50kBJvMoTC1xt8Yz3K6do/bZCeS3cfsHshColJGBoiMUPckQz578n0DuM?=
 =?iso-8859-1?Q?wf0yohnwE9WRav2csIc4EyQbWdTVhzsyhTwfvngu33JHefVmmSNrZDHTb/?=
 =?iso-8859-1?Q?IEV1rRDcoxfu/KO3lR6TL3LhqdsxFlRiQ2ofSfPvBU8dvfcORiANZ76ZlK?=
 =?iso-8859-1?Q?4D1IxE1UCi2z1E+bfd610zVfornB1ka4dBscV2PwojkdLAIMGRvmz5DQLU?=
 =?iso-8859-1?Q?j+NJeEAehs8UDa5CSHv8Cm1r2f44fbsv1G4eAlhjLl+jiVyaCf/CNG+bu+?=
 =?iso-8859-1?Q?zzn7oz8YLYu1L4MtufndM189PYvk3Tyw4uZwzWd7eit5KltiYKovPrbZmj?=
 =?iso-8859-1?Q?M2lIfZNm1373lWyzgJFN3NS0SBIQ2MIuCJhUbzrWl+zltnY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a43bda0-e03d-4de8-62bb-08d92f379084
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 13:23:14.2378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yg6luRznOlAi4u8qHpM6iMa6l/xIstAwKLY08HOWimpoFKMe/LW//4MwD0YsvrwAV/sSgeXJUaihMPCxQtjcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=A0
This week this patchset was tested on the following systems:
=A0
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
AMD Ryzen 9 5900H, with the following display types: eDP 1080p 60hz, 4k 60h=
z  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI), 1680*1050 60=
hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems.
=A0
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=A0
=A0
Thank you,
=A0
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Ja=
cob
Sent: June 10, 2021 12:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@=
amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.=
Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <=
Bindu.R@amd.com>
Subject: [PATCH 00/24] DC Patches June 10, 2021

This DC patchset brings improvements in multiple areas. In summary, we have:
* LTTPR improvements
* Backlight improvements
* eDP hotplug detection

*** BLURB HERE ***

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.70

Aric Cyr (1):
  drm/amd/display: 3.2.140

Ashley Thomas (1):
  drm/amd/display: add DMUB registers to crash dump diagnostic data.

David Galiffi (1):
  drm/amd/display: Updated variable name.

Dmytro Laktyushkin (1):
  drm/amd/display: Remove unnecessary blank lines

Josip Pavic (1):
  drm/amd/display: tune backlight ramping profiles

Po-Ting Chen (1):
  drm/amd/display: Change swizzle visual confirm reference pipe

Roman Li (1):
  drm/amd/display: move psr dm interface to separate files

Wenjing Liu (1):
  drm/amd/display: dp mst detection code refactor

Wesley Chalmers (14):
  drm/amd/display: Read LTTPR caps first on hotplug
  drm/amd/display: Move LTTPR cap read into its own function
  drm/amd/display: Read LTTPR caps first on bootup
  drm/amd/display: Set LTTPR Transparent Mode after read link cap
  drm/amd/display: Always write repeater mode regardless of LTTPR
  drm/amd/display: Improve logic for is_lttpr_present
  drm/amd/display: Enforce DPCD Address ranges
  drm/amd/display: Rename constant
  drm/amd/display: 7 retries + 50 ms timeout on AUX DEFER
  drm/amd/display: Do not count I2C DEFERs with AUX DEFERs
  drm/amd/display: Partition DPCD address space and break up
    transactions
  drm/amd/display: Add interface to get Calibrated Avg Level from FIFO
  drm/amd/display: Cover edge-case when changing DISPCLK WDIVIDER
  drm/amd/display: Extend AUX timeout for DP initial reads

Yi-Ling Chen (1):
  drm/amd/display: add config option for eDP hotplug detection

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 +----------  .../drm/a=
md/display/amdgpu_dm/amdgpu_dm_psr.c | 166 +++++++++++++  .../drm/amd/displ=
ay/amdgpu_dm/amdgpu_dm_psr.h |  37 +++
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  68 +++++-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h  |   3 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  10 +-  drivers/gpu/drm/am=
d/display/dc/core/dc_link.c | 167 ++++++--------  .../gpu/drm/amd/display/d=
c/core/dc_link_dp.c  | 170 +++++++-------
 .../drm/amd/display/dc/core/dc_link_dpcd.c    | 218 ++++++++++++++++++
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  31 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 100 +++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  23 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   5 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  24 ++
 .../display/dc/dcn20/dcn20_stream_encoder.c   |  12 +
 .../display/dc/dcn20/dcn20_stream_encoder.h   |   3 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 +
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |  12 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   4 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   2 -
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  11 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/link_dpcd.h    |  18 ++
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  14 --
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  29 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  65 +++++-  .../gpu/drm/am=
d/display/dmub/src/dmub_dcn20.h |  14 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn301.c    |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn302.c    |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn303.c    |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  10 +
 .../amd/display/modules/power/power_helpers.c |  20 +-
 .../include/asic_reg/dcn/dcn_3_0_1_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |   2 +
 include/drm/drm_dp_helper.h                   |  17 ++
 45 files changed, 1042 insertions(+), 403 deletions(-)  create mode 100644=
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C3bab580e964e468fb54a08d92c2ce15c%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637589393544509598%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DIdOfoStTgKT0SdjvMNrdFiGMJuK%2FnvPCjG%2Bw%2FO5xveM%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
