Return-Path: <SRS0=1/L1=MS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF1C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 13:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB83160249
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 13:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB83160249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9B36EB9F;
	Mon, 26 Jul 2021 13:41:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4546E95C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 13:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFXHckEGEpyUPMXNX/k3wBukoG9PfHUIj0j/OGB6PMZtj1lWgU3e4mX06OmNjdXCLfy5IHBrnGK6VAeU8GpeClHGe5X7d2dlQPrkQMcAXduo0p1YXls18RP0fqhMCd/wuTW7W2OyFc8ittXFfgG3YEkGQEWn4jBsBCrU27KJUFZmM+mKNd48NGqxjCDt9yfnVo8hsrrEpoehFaLrGcqftT85FMkI5E0jnvjTnRPEMu67rqugccPQ1ESV1V15ky5bg1MI13iIySFkhv7n3KXoxG2PpuFcufFnpWH1tm4448nG8SbG81IxB4CJqDkqxFmGGPcq7thSPjTZWXDxRtDpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqykTTYVxtIC1khVo5h80SItuSyjticx7AKcJrh4JH4=;
 b=DiN3xGXC1A/qBonmwF1M4HosYPDqXaQPQgcVCqLkn6OKOHX5DW9aADmrGuJKYUYIskzOr+tjFX+FQJknXb0s/cpFDziXnuSISP8RtZVk1maaN2jEhp1xVfwC3HCkjpJTfnxQ1LFMw7ssxtA3+RnyxeezY5eFE8giqppIZsOhKzE9IXrwzJa9bhqzWLFQqDq9DDhvqvVtungvxkd3oXfaaeqwFlVR0YjMG36DNckJpeVphM6q/VyBLD2L2+xHQf9rozwtEbcyf9IYo94WOA/tX6+g+15h6gim8sGrEU6+/mdP5iJG+u3QgOppcR9gBPQQzd4OyhqtHtNT/n9FaBk5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqykTTYVxtIC1khVo5h80SItuSyjticx7AKcJrh4JH4=;
 b=pAKQzcuLNYX67tXY6Mplh0gZLSB11vo51ENhAHkUBx7cPOqKmLFAQKbIgNthZ0L7flabuQENaCbE2ypXypgNXIu3H0sqcyjNs+wU6AqMYXlKUdb+7R8W4S6m/iwl885x4HLa7J60FWrusa70Ji7tdfuc3yqnuKdzUvMw7e7mQWg=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 13:41:34 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 13:41:34 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chiu, Solomon" <Solomon.Chiu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches July 26, 2021
Thread-Topic: [PATCH 00/14] DC Patches July 26, 2021
Thread-Index: AQHXgD8PD8i1vTL2J0K+hjCZ5W44tKtVR1Jw
Date: Mon, 26 Jul 2021 13:41:33 +0000
Message-ID: <DM6PR12MB3529FFEC3E03F5629DECB33F9CE89@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210724035003.3845158-1-solomon.chiu@amd.com>
In-Reply-To: <20210724035003.3845158-1-solomon.chiu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-26T13:41:32Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f85d2f95-1df0-4191-88e1-fb7ae2a26965;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2a5fc2b-ea98-47a9-e3cd-08d9503b155a
x-ms-traffictypediagnostic: DM5PR1201MB2473:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2473AE6D59CA53344AFD48CC9CE89@DM5PR1201MB2473.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +N7K2sQjhImQ0H5hiVflpPQFjNCtjkYFqtPnQg2hJhV/1tCo4AmhP9L8nbhZskn03MJntyk7xsAduF7JqGaIwHrc559u1TNlIKk9RZCTGVbF+u8qJFQgrpJLGOIk9E3SYYJGgG0ERZARRkEfJT+1qYGZLjjEeRr/WypFBqP1Jan+hGOom3DKvXjF+yj3GSWfg9KLzJbjVNwYrJtlE9J42jppGlXjrK70pZs6gXAl5jPe7vd0zlMkU9dKjjjh7um2BDVeYvy92R+jucMZmuojDfuc7Crx/WAZCYPTeDH18G7VhTdkUgeES50lIxrvt1tLeIOe0rOk9DicQw9rBvjePk8KVegY8btT7KS60bcAxeQjQhYyjpiMLsZ2bdImaEZX0GVrVd2Cjjl1TvmOUkFFW37K7NRAgQaGODOeF3MTVcdIJifEhaK0TPDYhfrWxHeCTB4PcCq/4zQfSVjFY45iJY8uchS6IesheWd9s3Y0yMqqnPHpiNmpELt++o0GRGkQHBGusaJuWZUr1lUrpjLE4wA6OM8C2bPgGDvqCvyQ914vbXakxF3RA9eUgHIhvDb37eItJMMRF2jzUXBHoCPDMLAzP9y2yfYuAD+oTFRALQFf0HKUrn3Aw5hYA2A5XiDHWP7eSzAHiaxMwwNn8uFebncV84AuAxxJ+X7ZYxAqAJCaNH2FZ0gOkZP0fk0ypwZSNiyjaez6AUT5zr/cWwkfRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(316002)(53546011)(8936002)(33656002)(83380400001)(7696005)(8676002)(122000001)(508600001)(186003)(45080400002)(38100700002)(110136005)(86362001)(6506007)(2906002)(52536014)(54906003)(26005)(9686003)(66946007)(71200400001)(4326008)(66556008)(66446008)(66476007)(64756008)(55016002)(5660300002)(76116006)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jyr3RTBDBsgBax/VXulyfmqhGKThgicDXVoHW4Q5k639bdx0OTKV35xPLo?=
 =?iso-8859-1?Q?WE8nCMnuTJCxU0dy1/pTvNT+lxwal6IgWTgowfS5PaseJ9j39msyuZRb81?=
 =?iso-8859-1?Q?0LPwYMfruEJ4MYHvAoDzfOvJGtbn+ecdJq2q6VJCGQN8GQNoUmC40VX9Ch?=
 =?iso-8859-1?Q?r5giWOtoHwdLX0ivenFXnLbl8WPjnUgDur7lYrdLB0hvwXrkH4/Dua6jcA?=
 =?iso-8859-1?Q?w2DKxDuIu5pxfOAr8DfmIqL2lSW+KaRjazF9ACoQGyVEuFGp+9HfCeYd1K?=
 =?iso-8859-1?Q?dHgO2f4Wyohkk54S6KhWCsgOrCPLuqxjdcjBW41SKi44XFkyhUedA6qVTR?=
 =?iso-8859-1?Q?RhtpwV0Xz5+xv5GNtj5eEqRG8SsJcpk0y0FaBhKApuhA1tlWS1X6t7Z0YO?=
 =?iso-8859-1?Q?dAtFuuhhF4/MFVJz3y3b6la2Vdw/urU8nZ7J0KcNpgSVHXywzKh4u/ByUO?=
 =?iso-8859-1?Q?+7Q0GXUBC0dm+n1ou0xY9rNSZFCYhRM9XJeVGabb1Slnry7u3lpUMBThQd?=
 =?iso-8859-1?Q?37bLc0aENoOA+LCruYAu13xw6oABNYGbYvkDDihu6rDNqaLXc7zWRno/ZL?=
 =?iso-8859-1?Q?hAaWWcam/oZiLZbhNMQcSuS/l5EJdSP5zSMuG2ct6EnRa+o3hgVeEFQS47?=
 =?iso-8859-1?Q?2sfluB9vnL1dJO0b37U2JHEJ0U4+xJHS9qkhY+dwQzOuczKyiLC3dFhq6V?=
 =?iso-8859-1?Q?x82nt5VQ8azfoQfrjTnm9nAsVkyYwBbYB3JUEpL5ifg4M1izwivezXMxa/?=
 =?iso-8859-1?Q?BdbVY4N6ABUqRBI7He3/PNp7a618cPwcf4onv2ktemQmtuwXYuhcanMZnm?=
 =?iso-8859-1?Q?zIp1CnqPZQ6mvI5L+nwANCie/SMX/DrOELNjv2GibF+HfLu28QXN3SZiyY?=
 =?iso-8859-1?Q?cesz1o7PLN2Tq3OZK27cKS3eCLouTglVa0P7ESPFTJQwCbOtLh+T4fliNe?=
 =?iso-8859-1?Q?vlWRgqgIl8ynuoB3wjtvrxqlPL2aG1edOv1Myi+5qeVeegn38Ax0arvADR?=
 =?iso-8859-1?Q?5H2yyS1riZewZqoKSLrE/PQtQLQLmF2xr/FyKWD1grOa/9k648327x1pzH?=
 =?iso-8859-1?Q?GEWfPyOvqAzfZLHDt6VjvuvbOqtOkpjjTFyaUoVFIpVtZOSU8eNjuBe1Te?=
 =?iso-8859-1?Q?DcIl8TT2c0+pGvGSwlAMIqujtJ+P8u0xVsTIJy9T4nLSN/Xp6vW81CUsJE?=
 =?iso-8859-1?Q?RQQO1AvlgjHEXzaf0OYgtQCxHAasPo0m6uW/HIjyj4mGYPsnve/vVzwDsk?=
 =?iso-8859-1?Q?QYXOiokK4M1fSRammIz5S9gQN1282G3+xnAme3b6gJudH8UO20FDIkn/2L?=
 =?iso-8859-1?Q?+46PvlsDw3uZTmMax4Fh8hjkjJw32Cx0YoMRAPjp0pFkNIY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a5fc2b-ea98-47a9-e3cd-08d9503b155a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 13:41:33.9747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0wrClljOgiIUU0BJ+7DR9hYY6bq9C3Pci0SJNLsBKDpuGMn/od2EABqt2IRESKbTcpXkmzEWz3YdpXrpKrUBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
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
Cc: "Jacob, Anson" <Anson.Jacob@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Solomon =
Chiu
Sent: July 23, 2021 11:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chiu, Solomon <Solomon.Chiu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@am=
d.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.=
Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <=
Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, =
Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/14] DC Patches July 26, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Guard DST_Y_PREFETCH register overflow in DCN21
* Add missing DCN21 IP parameter
* Fix PSR command version
* Add ETW logging for AUX failures
* Add ETW log to dmub_psr_get_state
* Fixed EdidUtility build errors
* Fix missing reg offset for the dmcub test debug registers
* Adding update authentication interface
* Remove unused functions of opm state query support
* Always wait for update lock status
* Refactor riommu invalidation wa
* Ensure dentist display clock update finished in DCN20


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.76

Aric Cyr (1):
  drm/amd/display: 3.2.146

Dale Zhao (1):
  drm/amd/display: ensure dentist display clock update finished in DCN20

Eric Bernstein (1):
  drm/amd/display: Always wait for update lock status

Eric Yang (2):
  drm/amd/display: fix missing reg offset
  drm/amd/display: refactor riommu invalidation wa

Mark Morra (1):
  drm/amd/display: Fixed EdidUtility build errors

Mikita Lipski (1):
  drm/amd/display: Fix PSR command version

Victor Lu (2):
  drm/amd/display: Guard DST_Y_PREFETCH register overflow in DCN21
  drm/amd/display: Add missing DCN21 IP parameter

Wenjing Liu (2):
  drm/amd/display: add update authentication interface
  drm/amd/display: remove unused functions

Wyatt Wood (2):
  drm/amd/display: Add ETW logging for AUX failures
  drm/amd/display: Add ETW log to dmub_psr_get_state

 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   4 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 108 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 120 +++---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  81 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   8 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  21 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   8 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  48 ++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  17 -
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 -
 .../dc/dml/dcn21/display_mode_vba_21.c        |   3 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 393 ++++++++++--------
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   3 -
 .../amd/display/dc/inc/hw_sequencer_private.h |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  70 +++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   2 -
 .../display/modules/hdcp/hdcp1_execution.c    |   6 -
 .../display/modules/hdcp/hdcp2_execution.c    |   3 -
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  53 +--
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  12 +-
 26 files changed, 538 insertions(+), 444 deletions(-)

-- =

2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Cfcb862bed28a483465e208d94e562fa6%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637626954357632293%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=
=3DzIUbuLeeHgoQor4tdnO%2FK7IcHZrKgmE2VZqG4NhweJc%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
