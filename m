Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D72C636D4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 14:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171DD10E5DE;
	Mon, 13 Feb 2023 14:47:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FFCB10E5DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Feb 2023 14:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrn9MHx0DB7VXJzQkj/O7vz4Mwbyfs3ex9z8lReyX47LEgfSgwS/v/yTxLmtyQj8VOZJhWT7jc3d3srLaVqpx1YWwxDHSCbuRp6F3RM+ay+qa2HVm8HPyVYmGqC5Cgbycu25jZpNT+K8BhIMrRCNj5XSRkQRZvGkp8DTZodlyCoxczOvCKvpDYyZW33Jmwhb4iqzwHfkP7e1wTy5QnQSPqE/znbzQfN3ugdlURRGL8F3wJWSvWNOqulgbPpeuKISL1+uZ1wf6wFqZx//VvFHQjGpiQMk8bl0aO+UUprcAzsOeAPH9KdyK8i+7jRoptcSUr5+S7T/23OYzWwwckLpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq488up6c3EO2SB8PxnyXnXckL09rguo6f8tmp+trDw=;
 b=aZuDezzyO9Z5UWIEVk3xf+9eh/4ZSjzKBjSdgVmsmJGaLh6syI/5Qqd5DSZzHPRHbSLn7LK3vKOkswH3vKEJjEgIvxNFbCjcAONhlOMwtscm9nwfTtzUAMlGf6Jxqctd6MrV8k4Jfy2yxY1sZQdKj43Ac4gHf7tOF6vcGQFJgY1ZWI1zGD6w3lGyUCkhpr77qW0nCRxKBVDSHjSaHt7vzKYWnhV9GyPJyqeDkJHni3290VXMmNGdZdgjyLAy5kFjyz1U033z2ZnwRWF7rXfJr+7JZjVAnV5fQmSTo4dz6L+XQD5Ugq66FDM3TT3A1bf1g4+UqqUI+c3WkcdPJQhuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq488up6c3EO2SB8PxnyXnXckL09rguo6f8tmp+trDw=;
 b=w2XrRX7seEAUBgxJ9E5OEBTUNLuQm4PgCOyY6SArxsewhQCcAh7x6L4aJzYBmCQ/XLcRpgamgNQ6Y0LeIzV8QOYd1QSlxpF+zATMhD8Jjzu5TrlvKaOBRVCAV1pRI5I9YYXMRXteVnK3wvRU0ueSHQPT7WO6rCVzjAOfGZw5q0o=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 14:47:22 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fbe2:dc44:4197:f457]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fbe2:dc44:4197:f457%4]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 14:47:22 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/22] DC Patches Feb 13, 2023
Thread-Topic: [PATCH 00/22] DC Patches Feb 13, 2023
Thread-Index: AQHZPwOJUerOazX9h0GtQmC7mTa6o67M9dGg
Date: Mon, 13 Feb 2023 14:47:22 +0000
Message-ID: <DS0PR12MB6534A780EABF5CD2ACFA767B9CDD9@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-13T14:47:20Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b31ade7b-e19b-4258-b3a0-51bf86a93ae3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-13T14:47:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 82ba1ab5-fad4-485d-a4ab-6a2adfcb75cf
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ0PR12MB7476:EE_
x-ms-office365-filtering-correlation-id: addce0a0-20f5-4c60-30ce-08db0dd13712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: abeHzx5iqLxRVxzkIWRIH6JczZ2uZibGHLL/mtmETi3fOh+UD0Q/2GLPCD+rpKTK4Ytj/iHCKpqLSeqjFa0WECBrSNk+x1GruusvU3vqYXpt/TZDdljx7dcFI5HWxC3LQWUMJf6Euhne7zy93Fiw1q3wLida82YLHydZPLGgxE8jM8Fx5wHHnKNZFyk1m6NZXg7qZfI3r+gF43iDZArT41L3of7OZnsAPq3IJYD1sYL18Ozf+dGVSKsZSpvQBLnv3dJTXIscUmleUvvenWB8uL4wOjNboq90eeqQFtX8VTLknrYlOtlS9K2A+UlRvfTFO8DBNn/u67AomXW+M0HxiHO+goVV3jc9TXWVupdvhjTp1gAJ2Y+XAZ3CCT3w5eGhgR49H2QWSCSMtQhDU1oEUUgXm3nUX9K3AQm9hQYRXSRl+wfITFRLlp3shWRSi2r1E63OBFiar9bUU0ykNvYZGmF1DKp60SqvSRf9wWtRVdyfTTVWvH5Z6iVy+ASA8/PlRTNmsrTNNr+x4gbAJ6BuOg5RGjN8HFdCFOJLyQKmyDeGtdIdjM4Tcz3dX5wj+J8VQmfadiuXfpSumyG7GEHzA7KT1NHZHrYlg+19fe/Mqjug5MXvQx0MVgGZcecPUF+xkScwAM2lt0cum+e4jUqKh+TTZwMn78/2oH965RK6frKfUQQUjYW+0AjO2X8ccNL7iOE5j2OCsjG1kO4eQhEhGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199018)(41300700001)(110136005)(54906003)(38100700002)(38070700005)(55016003)(8936002)(5660300002)(52536014)(71200400001)(33656002)(478600001)(2906002)(9686003)(6506007)(53546011)(186003)(26005)(86362001)(7696005)(66556008)(66476007)(66446008)(76116006)(64756008)(66946007)(8676002)(4326008)(83380400001)(122000001)(316002)(66899018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?END/DlMfXk/8YpVKM87yW1mHCji43GpD/A498YOuUSKVxv72UlXYLHYXjGCy?=
 =?us-ascii?Q?38EIbJvIs4SqHxhfOISpqAJsaC3S8q6PHQAwzXldvCfnnCfXqK6bK5ENYQd2?=
 =?us-ascii?Q?wmOjzxsSZUZJrkYkCB1g/EtydZwdlWbPdbu8JRiEJnW3oT6x/+nH1VW7bTeW?=
 =?us-ascii?Q?90SMtYKakhHybipOGeZuwegTlpqeLvv7OznRU/6WCytyEimNbumaD2JnugSJ?=
 =?us-ascii?Q?L4fXZzpkPK3Kv4/BXwPGtF3xdlPW/ONTyZqdC7hoK+Ra3Z8fKia4w1HHnxYE?=
 =?us-ascii?Q?ny3wZ1ceAh7ctiw+NNMvk2zIiHQz3hz4WjRMOIwdk0TegexJcxh+prDAd2cB?=
 =?us-ascii?Q?xrqLTFqMDui2SPvPoEOgeSPvZyUcBkRxQFHp6xNM8XQlHl3kZCTi0AtO0Dlg?=
 =?us-ascii?Q?sXubSRsjoLHc3Bq1/c8BCMwUbrOwcjBbvyctZ2mOdLreP9hjH9M4JjA71hqt?=
 =?us-ascii?Q?Spb50+TSw/8jCFCOfSEmWY8egZgeX/oZgtzuF8KpsZMKCoRahjWQjpTVd6s/?=
 =?us-ascii?Q?EEIqT16BrQZIgNNdnQGDFPJ8HTurhOnBPBZJTdkZsIg01zDF8ZfVWfkiNwRk?=
 =?us-ascii?Q?VryzeKiAmd5eYxIAbVzjwXcTu/jN+2Xx269vIAbroW8SVCcv22gNxMF7Y7Yo?=
 =?us-ascii?Q?NrHhzQ0iyEB9rD0EB66I2KPsOn6jfiIsBUCUvNtm5X46fRzjveOKPbDiu6n+?=
 =?us-ascii?Q?o7lvwOWJ4py2Gd2SovS5jU4xTkBk2gaRcKpnk6jxPVJpm9uQHI17kH2ENUM9?=
 =?us-ascii?Q?NqFMbqKFEuc/kbKNDR4xb+hWSs0VvPqd1CRN45kv0xQ10esSMQmiSYscUwRv?=
 =?us-ascii?Q?4A1RZRisX6kqssdaqUrpBt7DHddykGThus4pTSrnb1Eh93wQhO0y7OGtcmgd?=
 =?us-ascii?Q?avZ4DPUhOLwvTuYOviKtTzdF9TLzJmZhcaOjHH6w3Z9OU1ah9JIi1/ayN3Fh?=
 =?us-ascii?Q?jocEI+DgIKcuJDLYvi7kFayxKhoY9WQWOpkS+nLOxpC3oCer094IRdbsmGDk?=
 =?us-ascii?Q?j+aQVzxDDGiiJRLBE/yDIBQzo5s1u0J9hyQ2jImGOMKFo/Epr2GN5AjZBjz/?=
 =?us-ascii?Q?ZLCKUpF6Ln9+uSII89uFgGZ3b8uvX1W+s2sQqlS/S9TvzoXKXy8pTjwydoNY?=
 =?us-ascii?Q?xDXKb7/oiR6gtUOWj8LdsDru7hgr9TDLb2hE+qyZFjSIiTmjN74Dyw1swrXt?=
 =?us-ascii?Q?IkeGTVmpJHFF0/8mCALeqaSUie+jYqLQR1tuSOc0zXuaqUzOXlTNvOB/c6HN?=
 =?us-ascii?Q?CpQZorGT8l7esggTeykL05//1VnG9zISBjZPp+frymtz0dJGYlwFunO3O1gE?=
 =?us-ascii?Q?MB9f7sW6KOpFXhBgW0guxhhaXH8Dztjlpq0cUq4+7rBLoodjln0NIh8ATaEl?=
 =?us-ascii?Q?jTW8ajt7AhdijS1vc3xFsKxL7493lOoKWYz+NM/0XPWfiqeD19HyZMl42XL1?=
 =?us-ascii?Q?1TX7TU2N2W3mIfBTLzAI1PYI35QEIVAs3X5SDYws2AMcYIR83sj202sDQwHb?=
 =?us-ascii?Q?kGMDWtdoHnfw32X2dMvtoysUDu9unLvnp4V5l+Ol4HmeZvm8zC2XMQOJGfj5?=
 =?us-ascii?Q?i4pI3zKbPN8hWdKugZI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addce0a0-20f5-4c60-30ce-08db0dd13712
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 14:47:22.5696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mm+u4bDDnv1TTeT3PH9cqzoZQt/ek+S57rDUcbNxW5qWzk48EfIowBv3BdOyLw38DffDZfJGgADSNGMM8QOSwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Lenovo Thinkpad T13s Gen4 with AMD Ryzen 5 6600U
Reference AMD RX6800
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120hz[6600U])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
HP Hook G2 with 1 and 2 4k60 Displays
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing
=20
The patchset consists of the amd-staging-drm-next branch (Head commit - 87b=
54ffb9424 drm/amd/pm: bump SMU 13.0.7 driver_if header version) with new pa=
tches added on top of it. This branch is used for both Ubuntu and Chrome OS=
 testing (ChromeOS on a bi-weekly basis).
=20
=20
Tested on Ubuntu 22.04.1 and Chrome OS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>=20
Sent: February 12, 2023 12:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/22] DC Patches Feb 13, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- Move domain power control to DMCUB for DCN314
- Enable P-state validation check for DCN314
- Add support for multiple overlay planes
- Fixes in prefetch, k1 k2 divider programming and more
- Code cleanup

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alvin Lee (2):
  drm/amd/display: Set max vratio for prefetch to 7.9 for YUV420 MPO
  drm/amd/display: Fix prefetch vratio check

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.223

Aurabindo Pillai (1):
  drm/amd/display: fix k1 k2 divider programming for phantom streams

Ayush Gupta (1):
  drm/amd/display: temporary fix for page faulting

Bhawanpreet Lakha (1):
  drm/amd/display: Add support for multiple overlay planes

Charlene Liu (1):
  drm/amd/display: add NULL pointer check

Daniel Miess (1):
  Revert "drm/amd/display: Correct bw_params population"

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix FreeSync active bit issue

Mustapha Ghaddar (1):
  drm/amd/display: upstream link_dp_dpia_bw.c

Nasir Osman (2):
  drm/amd/display: Remove stutter only configurations
  drm/amd/display: Disable unbounded request mode during rotation

Nicholas Kazlauskas (4):
  drm/amd/display: Move DCN314 DOMAIN power control to DMCUB
  drm/amd/display: Enable P-state validation checks for DCN314
  drm/amd/display: Update Z8 SR exit/enter latencies
  drm/amd/display: Disable HUBP/DPP PG on DCN314 for now

Samson Tam (1):
  drm/amd/display: enable DPG when disabling plane for phantom pipe

Tom Chung (1):
  drm/amd/display: Fix video glitch while drag window in PSR-SU

Wenjing Liu (4):
  drm/amd/display: do not set RX back to SST mode for non 0 mst stream
    count
  drm/amd/display: Extract temp drm mst deallocation wa into its own
    function
  drm/amd/display: on dp link lost event toggle dpms for master pipe
    only
  drm/amd/display: move public dc link function implementation to
    dc_link_exports

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  83 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  31 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  47 +-
 .../drm/amd/display/dc/core/dc_link_exports.c | 103 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 211 +++++----
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h |   3 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 136 ++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  60 +--
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 109 ++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  16 +-  .../drm/amd/displa=
y/dc/dcn30/dcn30_resource.c |  16 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   3 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  24 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  61 ++-
 .../amd/display/dc/dcn314/dcn314_resource.h   |   4 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   4 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   2 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   7 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  32 ++
 .../dc/dml/dcn32/display_mode_vba_32.c        |  17 +-
 .../dc/dml/dcn32/display_mode_vba_32.h        |   3 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  31 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   5 +-
 .../amd/display/dc/dml/display_mode_structs.h |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  18 +
 .../display/dc/link/accessories/link_dp_cts.c |  45 +-  .../drm/amd/displa=
y/dc/link/link_detection.c  |  51 +--
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 220 ++++++++--
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |   5 +
 .../drm/amd/display/dc/link/link_resource.c   |  41 +-
 .../drm/amd/display/dc/link/link_resource.h   |   2 +
 .../drm/amd/display/dc/link/link_validation.c |  14 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       | 413 ++++++++++++++++++
 .../dc/link/protocols/link_dp_dpia_bw.h       |  29 --
 .../dc/link/protocols/link_dp_irq_handler.c   |  46 +-
 .../display/dc/link/protocols/link_dp_phy.c   |  11 -
 .../display/dc/link/protocols/link_dp_phy.h   |   4 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  27 +-
 .../amd/display/modules/freesync/freesync.c   |  12 +-
 48 files changed, 1471 insertions(+), 511 deletions(-)  create mode 100644=
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c

--
2.25.1
