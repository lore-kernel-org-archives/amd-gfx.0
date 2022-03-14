Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3140DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 13:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCDC510E9AB;
	Mon, 14 Mar 2022 13:25:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F8A10E9AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 13:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwmNa35PGLdO5D//brULTsTne7aEk33tYzW0GoDI1UASlCCtQySY7trWgno7iLb3EeqM0go/n+u46hupDXHrVZZTq0RaBZyZSE86rHdJjwmXeDW/1qXmQxWig107htYfgDS8dMU5s8wjE/qmkApXwCLAo0aaTJdyo0OgEnF0BjvLiBnM77hVyCnX/mJPQBzbE1hYwp9DFhKEqTBZdTe6ARiGwYD79pW7BeCN2EhLiW7oKAQ+J9xt07ln47AB+LXphJiVAtVNVw/E+HvAqZqy6z/BZR7Y92zENhz48Ws8HPv6SdwAIV1S3Ntrwq0KFvXWJk1lhxjjhnWUM1dvraUW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSVbHHrDqXNYw+BkRjdZdg9GNYgAqjFCkddlRDh3LnE=;
 b=UloUVjvFj/Wyes7WQjiCGONHqGv2sYrRlRrZwHvdHCIJegWJVthNx7o2JicGvrvSeLzErw0APorv4SigzUF62cQVvfO+IhEkE0v9MUM+0fic8+14UGJaRJn/sopBIwLGjYScpFSFyKYJpytS8K9+3bt0cSvsbkzBDxeTu5MwFRR6rIEImmpzESADAkg9EUvS7bYQrP/80fINzfuPqNRv/4TgrwZn+JF/EQ2+CebTsDYxPrslnEaCd/W47+5sjLPkVHHOttnCgt5pprp2M2IEHvFM9TAOjgoqK7qG5QylK+zMsIHDzQxZwtlhGxDPwbmoZ4R4F9W+mQdrgEGLBB9NzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSVbHHrDqXNYw+BkRjdZdg9GNYgAqjFCkddlRDh3LnE=;
 b=qzbeTus3lQFTyiZZ0AIKIT7gXFyK23z4IrgW18zg5dvdiBO2QK0QLHg+LA5X/YLlpnCzUDF3wYVVFSd4bgmYcx6deaS77rsWPmWLrGYHKi0ZjxdcAEbAy7yOcPukhbyIALU+Pg0mVcY+oAsQJbC/DUpxYxwT4NUWgXjNWOjpwcQ=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 13:25:33 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d980:5095:bef2:a7d2]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d980:5095:bef2:a7d2%7]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 13:25:32 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/12] DC Patches March 10, 2022
Thread-Topic: [PATCH 00/12] DC Patches March 10, 2022
Thread-Index: AQHYNM0rnpZ03wxLaEmn4K/6AXkYfay+5EYg
Date: Mon, 14 Mar 2022 13:25:32 +0000
Message-ID: <DM6PR12MB3529EFEDC301C795CF78AF929C0F9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-14T13:25:17Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=42b2dd99-b206-451c-a979-823575c3e60d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-14T13:25:31Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a228039e-39d9-40b5-a1e0-0fee79e627de
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5656be15-6815-4a27-b574-08da05be1db9
x-ms-traffictypediagnostic: DM5PR12MB2504:EE_
x-microsoft-antispam-prvs: <DM5PR12MB250497C9BDD360CA7B6A8BE19C0F9@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vvTLVdZXg90pRtRqI+cOB95QEFWAAaz8IA2uXNKwbPEEbgmxE8AT/LuqnwcdGgoTD9PLyvgN3n8mzEoheE5T43IPpKjbHAu3UmX7tRvETYCSWfFQyFbtvm0ALUccgIpjYuS1tmtl4NVUtmC/04iJNcACRRoEkfFzziaFKGahFALWDBBeh9RRlxrNVP5WQLsbqXXXTtsgwcO7VdHrek1BgLtcQT6DAcwQNpQ2r7/5ZkKoB8hAKwtaBbjmRntUm73sDx3bWFDDrjLD9EfCCWIdj4wWPD6sfPit9xmP+Dt0R5yK4naVXBTu/cQMsJEKWs1cLIJR6SI8PML6+SUQ5TxnNd01zpngYjFiGKus3An/BkSbk4YkzxpTLNpfSl/BplQecdlsZOlciXaCuNak6kaWzmLTl8WhkHjgrD1zMsfZ3mYxpHddioGmuDoHpfa910g2SMXX1KpVAENY3hQfCAwAW0qoBZ9/lYKPHNqrboDPAsDnWyRkA8q55+HU6EvOyX73GxJVDuplWdUvC6yY9Ra9XkxGerJzeQ3L6pLClmVMHye0Jh3mnn5LDFX6O+2cuvy+kLhCcWcM0AHeiQh0CAiuvF9/XxxPxXIDWyLP2elDMMChrbqT46u2fkt4uHbUHIL5IBrT7aRiQO2jAZM+k0OEOiXQgP0X7+Ts8ER8OV1SMJMdyodFxj3WW6xe2IGUR+EIpgPk1byBcIzEbSox7OGYMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(110136005)(316002)(33656002)(66946007)(76116006)(508600001)(38070700005)(71200400001)(55016003)(8936002)(52536014)(66476007)(5660300002)(2906002)(38100700002)(8676002)(64756008)(66446008)(4326008)(122000001)(66556008)(86362001)(26005)(9686003)(6506007)(7696005)(83380400001)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8aIqjEX6r7SBlJPVbPD564E5NJ6123X5ndp1k7kd03JCraacscd1JAMm+cma?=
 =?us-ascii?Q?Z5U00uRsab8ZpJ1BSXV+Qt6KLMLoGErJNqPCY9NhZUj840CNEd4nqiHfGET2?=
 =?us-ascii?Q?mZ9ZZZsrihoU45oNl7t48lGojz0xC6o1Hg1wrYLPeON0U2tqMa3MQubCPP7Y?=
 =?us-ascii?Q?zbznpRnseQYOKnLSdMhraOC5lnGvfzxK3X07wLc4J6vQE3HWvs+4NvT92Z5k?=
 =?us-ascii?Q?VJbvTnf6zKMwqDkuSMiezAs5MioFgeElFQsUPoaQGLrWvC/E5NA0mjRz9w36?=
 =?us-ascii?Q?rT8KB0FJAejQxy7mjB499HvooDspfPJFN6Z/LGMs/S26NQ3rdLni/1PJtTvb?=
 =?us-ascii?Q?DUpBiqIp3xVro3AFOsVW9GWnMVgnJ8BVTFji4CG9tk88zrvKUMMhD4Nvwhvj?=
 =?us-ascii?Q?/g1SbvWg6awzBtOXbjsTzX7gi7q4SiRrAPzZvK0BOtQxobu8arX6Qv+xNXp0?=
 =?us-ascii?Q?XnihP9/DacaX9Hwdla7bq59sXSSNq71iufZveEF9aRdrO7BCQY/0cpqvvfQe?=
 =?us-ascii?Q?l74+oY0d2GTXiEqu9+NJwkUBiKhJgBU068qv6K48D0rXtXRK/oIc45vgJPl+?=
 =?us-ascii?Q?uZ8RREmibpSdb6ZVcTVbm6IldVHdq21QKhj22S+Qiu69UtHl/aWuFRgWhbxW?=
 =?us-ascii?Q?LwLtjh3bzEDoyoqvyvdvs1mvaq+KVTuyS2ruAu6q7nRafR2R2oN9/S3wtB7T?=
 =?us-ascii?Q?PqDP7MYw+zv/L4Cz0mSN3ZH5ARE4Bt+8IhVn+eMyKyIpKAlVQ2BV6JPRfb+V?=
 =?us-ascii?Q?t65xM/bzBoVpH1VnQwOoNDrC4Q3fMgP5cNMiVCx4q+BmYmt8XAoSxO2xKtsK?=
 =?us-ascii?Q?0twBv6JunBM8jHfgzLik7ICUxHzKgvb8h6p0dONtc9b7Nk0mdymTTIOYLwYp?=
 =?us-ascii?Q?BjnqC19rV877bqapYdJ7RzGMhJfesvyyU6y7KTvnpXcf+nbOAJJ9yTALm7at?=
 =?us-ascii?Q?sV76dz/LJNJCJq76RfBfBJHvK7Owb13PBGoPy1Sebjt6I+xx2m7djh+RCR5U?=
 =?us-ascii?Q?eUowlNtEuJlbhdeVBwVRFEWj5IuW9Bth1LCcnFLsnpEIzsM14g7tAd0j8mH4?=
 =?us-ascii?Q?iwynr7lRR9EwDKxztwI77MRpWQ6C5p5mnvE/rj0VYfeePI20RHtN7spe1rtX?=
 =?us-ascii?Q?Nq1ysKfyJU8pKZ2b59oBobtCKKKJrzqztlnYBUCxXY7njKTi5F2RqbSaa1/t?=
 =?us-ascii?Q?LobflOHl682qetBmIhacIq8qvhvDvKoqZqO0cxkejHogk9+U/zwqEHER+lX3?=
 =?us-ascii?Q?TiMiCEfAMT2aJFILjJIDfIxy2DaZQsf56xe0l611vQGfjRR2aBAUrsfY84lr?=
 =?us-ascii?Q?jKEWIF+NrOE6Gii/NTSAAGzYHHKEhfV8Ed+eKv5uGzdxxCLT1Ra2Wxku24ov?=
 =?us-ascii?Q?3EGkIsXiskqfNwZ4DT2F5ej3o+qGBeXy3BNgXauwAn0K4GJqG9deuZ3ymG+y?=
 =?us-ascii?Q?LPvDzikJ/WO+oRGNBLhiNAsySq9GeM2L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5656be15-6815-4a27-b574-08da05be1db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 13:25:32.5575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rhi1RTOtoJqaFyghTQARPnbmiqqdJk1K3HyHtatM5FQ/aTWDWaIPnace/3F/Vms/+PURZ9CFrPb3SBT2asPgng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=20
Tested on Ubuntu 20.04.3 with Kernel Version 5.16
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com =20

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Agustin =
Gutierrez
Sent: March 10, 2022 5:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;=
 Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agusti=
n.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/12] DC Patches March 10, 2022

This DC patchset brings improvements in multiple areas. In summary:

  * Fixes on lane status, zstate, engine ddc, debugfx entry.
  * Enhancements for Pollock, EDID status.
  * Amongst other.

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.108.0

Aric Cyr (1):
  drm/amd/display: 3.2.177

Becle Lee (1):
  drm/amd/display: Wait for hubp read line for Pollock

Charlene Liu (1):
  drm/amd/display: Add save/restore PANEL_PWRSEQ_REF_DIV2

Dale Zhao (1):
  drm/amd/display: Add new enum for EDID status

Eric Yang (1):
  drm/amd/display: Block zstate when more than one plane enabled

JinZe.Xu (1):
  drm/amd/display: Add I2C escape to support query device exist.

Jing Zhou (2):
  drm/amd/display: Update engine ddc
  drm/amd/display: Add null pointer filter

Leo (Hanghong) Ma (1):
  drm/amd/display: Add function to get the pipe from the stream context

Wayne Lin (2):
  drm/amd/display: Fix a few parts in debugfs entry
  drm/amd/display: Retry when fail reading lane status during LT

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +  .../gpu/drm/amd/disp=
lay/dc/core/dc_link_dp.c  | 30 +++---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 14 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  5 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  1 +  drivers/gpu/drm/amd/=
display/dc/dce/dce_i2c.c  | 26 ++++++  drivers/gpu/drm/amd/display/dc/dce/d=
ce_i2c.h  |  6 ++  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 15 +++  =
.../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  4 +  .../drm/amd/display/d=
c/dcn10/dcn10_resource.c | 15 +++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 10 ++
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  5 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 16 ++--
 .../drm/amd/display/dc/gpio/gpio_service.c    |  6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 92 ++++++++++++++++++-
 23 files changed, 253 insertions(+), 26 deletions(-)

--
2.35.1
