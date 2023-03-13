Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC2BC6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 13:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA5810E51C;
	Mon, 13 Mar 2023 13:23:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F2C10E51C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 13:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as+w1RrBCTE7nEqzW3sIZEbtNyN+zB9jPHWUV1x1RqerdpNZcOz2A3V1dGZAxuf8M8hrVFEBldFtWGu1SSX805AOHyhvg6gXrCj+B8Hq2xWBn5goGyPtaMfaNxysYp5SGXF62qy4XyFpt+0dYFTdx+L624UiewpelOXnxvybLlstBIKZE4ClDaPnRMuE/TNYVYGH4B6eWvh4ergtaVgEdjab5vVFRCj6chpoF06ph9fOeosR+tJd0NY3KxJSoWHzINUrKAXnztA+uDGHwIl91hBoGxTBtiDtDVIT7zW22Mi1hpIW+vuT9UtWF5yvP8HZDEWF/NMB+5ZlCtX3u6s8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw1PUM2u7f/5WI4VSk+0oBZeVtRMaLj/ykec7OwumTc=;
 b=KrDkXmJd3tVQb+lk4ac4nRgpJ97qB75TKtGAX019lCdmZi8r0+azRCd01ikgvhTLk6P2KN7tQ/GjjzkPdeU6tIsdZdLz8aSSYPDz0RhAXUl4A8vc16OxWx9SW6CTsdcbgNPTfFHahs4HqJSnh78zIhdM5+aoZMLfPo4vqZK66Px+YRI+Ml42CCENRPHE8YF7k3ev7zeCXY8fTVzPlJ9D1KGKnPWoizYZNoiHemX8DbLFaKKLnuuKjlTNcJd4RataWgoGuHQD/0Uf6+8s2pYIzBN7vb3/2XSxGaTVofLcF0PbLVtKNH5pg1rj2rxuENIpWmGSiFKDqayzhCYy7veL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw1PUM2u7f/5WI4VSk+0oBZeVtRMaLj/ykec7OwumTc=;
 b=Wey3bn/mLqDVoTeAncCwaoinfVCv3dE3iY8+LtfP+h03o5s2ddy56pTu99hfKWeZJFL5TcAOY3rXjMFm1D3EGj6/CtE+DVNQ4hB/i4g0bnH19EG+LVNqfJDxU8J3H1yB9+ewMHZ8GulReT0Cu/VzQTgd62HpQAXAc6JqpD3vXgs=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.23; Mon, 13 Mar 2023 13:23:26 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::87f1:8402:36ef:18d2]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::87f1:8402:36ef:18d2%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:23:26 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/19] DC Patches Mar 13rd, 2023
Thread-Topic: [PATCH 00/19] DC Patches Mar 13rd, 2023
Thread-Index: AQHZUzMj4SsFnlKgjECO//bSCsOY1q74tzBg
Date: Mon, 13 Mar 2023 13:23:26 +0000
Message-ID: <DS0PR12MB6534AC6883EC8C83DDF311029CB99@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-13T13:23:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1ba96b9c-72f5-4d15-9554-6329e6e734f3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-13T13:23:24Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8028bed1-1871-4304-b74c-44d2be14356c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS0PR12MB6653:EE_
x-ms-office365-filtering-correlation-id: 61e1abd9-5d3b-4bda-a653-08db23c620a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKARXraBzmralGh69TRvFTtCbibT2jZRIHlfybg7Fd3Oi3SeGJJZubtQQw/M2I6Do/OlzC2lMy202IZ5hWjm7Bk4JBScbHEWSa03F2bqG5ZLU5+U6/zxQLwaWBN7BFRzd5F24kV2gwnfAamhBSDOWveAvfzdg1F9Joof1RH2Z/llh5ECregmytxObUmfmvAgusSkAr7mRHaQgluNkFSS3MCwOvdqaJyRZ1VNaoZW0LT5afbCJGPPGzcX0vg2lQNi09Cm6JCrW+KJ+8DX98QiEoYyQOuxhd4+sCFeDEXEDC42FzGLMNr0dLtKsjAy88frN3WI7VPWrYZx3mwRf7Jo5hPnwpo2M0eIGIoyy68XhaSZYCY9r/eJlWDCrLuOTPPndt+tOoGE2FAM+1g3VCfzzRcNMlH7/gYKbPWG0fExe9LW679kXaf5hyvHmw2F+Sd4Qynnbt0yMmP69+0PYZKNtafFbB0vRjZreVjUWoQ4K/kg3DCkYBfDUdlNY5cmz5iZX0Qtbw+XxfYWM33D3L7YAPQf/Gh6GNfXJR/stfuBLqqeg6J9yICc1DeWEjdPtC7W//XbI2Ahwewsr9Hl6W3TkyQu5GazhaUAXR462KrVUP7tnYb/k/yjn249lf3iLsifpxs7N8KBOZqy4YCoTJ0R1vvMut6AfPiqBseK22oykqK3Z5XlKvBlLZWJK8OaS4VoLuMTonHL+KHpFeYQLgad1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199018)(5660300002)(4326008)(52536014)(41300700001)(8936002)(2906002)(38070700005)(86362001)(33656002)(38100700002)(122000001)(7696005)(66556008)(66446008)(71200400001)(64756008)(66476007)(66946007)(76116006)(8676002)(55016003)(83380400001)(54906003)(478600001)(110136005)(316002)(9686003)(26005)(6506007)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lUd0rIFuHpx3upzRnZJdPTKi8/xJNVao8Z3MFOC4iYRXn4e6auL8dNagqNa3?=
 =?us-ascii?Q?Wyr0Op1LHf80lPgaYshNtknrk7/UgXr7CWf6ZXOkiS5h9bNHhLMZL7YsQRI8?=
 =?us-ascii?Q?1ytT+7nqjpJ3uBLgH3zZhlwa/2SEthMctooIfpTsz20+vVw29iNnXITWEqj/?=
 =?us-ascii?Q?DtcGOOk2tBKDBfnCXVwvw6Dh+34LiuM/UCWAqzdFndTUyh9Qw9rRI/aMAb/E?=
 =?us-ascii?Q?irTvT2+iU8bJKY2YwjTOxDhOICNR+hcyZAThapdTr62c12QCRg46nlE4tyZ+?=
 =?us-ascii?Q?A/MwXSdfpMdyBkYGanu/W03gkEKWKOKhyuBcrUke5/fqLz0AcQrVKR2ys0Fx?=
 =?us-ascii?Q?vSz1bM85ZzXt7f5E+9OhrD6npl4Ycu0bubGst4lE6T/8+0+2skyEkSIpIxu7?=
 =?us-ascii?Q?/eBBPhZ0125N4+e8sLeJ8bDCBR8ofqbMRb9+Q3S0CGiI5gigcCg69hjLBVhw?=
 =?us-ascii?Q?pFcfUSYuxngLfrf7MNC0cpOTiRzhuxfxCeJu1vJSwzZoJwvkeSKbBmpaUC91?=
 =?us-ascii?Q?pzxljuGstQYv2EvcsETv7R0jaLBQ0tEl4uJ6Z01CavtjNfx7cs/rgLTc2qtD?=
 =?us-ascii?Q?XcJbIrdhG+S1TUMqxzZMUQ9v9hJvuakfRgnKIJ6CdEFM9lknI5XqJSy6rLB6?=
 =?us-ascii?Q?+8vKAPiFUi8lLjlS7M6VYVoQPF3jWLFDSDFjaIzC32qBrRFrhMY8MnRsi5E4?=
 =?us-ascii?Q?lacc+hDp1M34KgAsd8tBRF5WiFXT10jKNoeRTO9paKAsven6YSYOGzM0U2+L?=
 =?us-ascii?Q?dckdaZQsI0aVkB3sLbt5qKnT2eNCusV9+IZ42N89AhOFW3tP3kW2+fGbUMHI?=
 =?us-ascii?Q?94Qxd2vehd7vSqXGeYnLFr7qlHkB3ToMqtMkLSI0az2RTj8V6hMpq2WUqVs2?=
 =?us-ascii?Q?dkWnhfZE+y2QMi+HyD8VzunmxpijzJd0zdDWX0VpZrJ5ma4COITfDvD77Nfp?=
 =?us-ascii?Q?7jm6eY2UJLWyO9RYB9bPPGcXEhMJ34DcIlV97LvUlgUF4h99JIW9eUeJ9QOd?=
 =?us-ascii?Q?g0PJ0f84Fy+8gxrVVHxDOthnunYEHrIG7zFtDMoRYBkPaxY9dXx1M8mPAIdf?=
 =?us-ascii?Q?nso2yCEgRrd0P66zwWgh2s8si/bfYoRQ7f+GzRLDDiRf7WxvMP4vk1PJSwOQ?=
 =?us-ascii?Q?fVdRHzPjoJPCmvv+mLtXDZATv3RmvhSc6SG+7Z6ZJntx0jJVPkKQ26oUKwja?=
 =?us-ascii?Q?DOiuq8/K8O0Q8QQjRD/aNWCrIBukvF5wX45NPJwTfalyM5XHz6Ey56HRMWva?=
 =?us-ascii?Q?PT1eXRBB97B0qhfwKH413FbycMkoW+mXIJxdFI/kQ4TaDRMFm2ViS77hmJ8Z?=
 =?us-ascii?Q?/uPMqKB/EPPI3CWrwjJhDqxY/mpnvopc6cTFpU9xIpzOtE8ibxXMVrZuZTfa?=
 =?us-ascii?Q?f7TcfdnBDud+lu+j+pzzspLHQuZO+l8twca6W4f65HuTunthxtYCmA9MSjEV?=
 =?us-ascii?Q?7faG4T9COR8OtOoogS5MtNxHoQSczBpcmfcpBY1KpImONFU58lWBcuPAfAtl?=
 =?us-ascii?Q?CDddAZ39jonTy7n+VPlVy+V6oYJHnAUnVyE1DbSaE9xwG8Od2U8xnTPY19xD?=
 =?us-ascii?Q?PFu8bvUi8xpSgBgav7ZNfibhDfzfyeQhkj+ZQw5D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e1abd9-5d3b-4bda-a653-08db23c620a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 13:23:26.0786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AVXQ2xUk1jtiH+UX8L1QXIXddX82nFJvNvIxOb14osL3CQezMl2yYpurtIAB1MAgCj4nT7O6l4Dbh+IbMfS0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
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
The patchset consists of the amd-staging-drm-next branch (Head commit - c4a=
5cf85ab8c: drm/amdgpu: Optimize end of non-contig VA ranges) with new patch=
es added on top of it. This branch is used for both Ubuntu and Chrome OS te=
sting (ChromeOS on a bi-weekly basis).
=20
=20
Tested on Ubuntu 22.04.1
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
Sent: March 10, 2023 4:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/19] DC Patches Mar 13rd, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- FW Release 0.0.158.0
- Fixes to HDCP, DP MST and more
- Improvements on USB4 links and more
- Code re-architecture on link.h

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (1):
  drm/amd/display: Use DPP inst instead of pipe idx for DPP DTO
    programming

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.158.0

Aric Cyr (1):
  drm/amd/display: 3.2.227

Ayush Gupta (1):
  drm/amd/display: disconnect MPCC only on OTG change

Bhawanpreet Lakha (1):
  drm/amd/display: Fix HDCP failing to enable after suspend

Cruise Hung (1):
  drm/amd/display: Fix DP MST sinks removal issue

Fangzhi Zuo (2):
  drm/amd/display: Add DSC Support for Synaptics Cascaded MST Hub
  drm/amd/display: Take FEC Overhead into Timeslot Calculation

Mustapha Ghaddar (1):
  drm/amd/display: Add Validate BW for USB4 Links

Robin Chen (1):
  drm/amd/display: hpd rx irq not working with eDP interface

Saaem Rizvi (1):
  drm/amd/display: Remove OTG DIV register write for Virtual signals.

Samson Tam (2):
  drm/amd/display: reallocate DET for dual displays with high pixel rate
    ratio
  drm/amd/display: fix assert condition

Stylon Wang (1):
  drm/amd/display: Clearly states if long or short HPD event in dmesg
    logs

Swapnil Patel (1):
  drm/amd/display: default values for luminance range if they are 0

Wenjing Liu (1):
  drm/amd/display: convert link.h functions to function pointer style

Wesley Chalmers (2):
  drm/amd/display: Do not set DRR on pipe Commit
  drm/amd/display: Make DCN32 functions available to future DCNs

Zhikai Zhai (1):
  drm/amd/display: reset the scaler boundary mode

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  51 ++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  15 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  38 ++-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h  |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   2 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |  34 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_resource.c |  13 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  15 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  60 ++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h  |   4 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |   4 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   6 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   7 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  14 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   9 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   3 +-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |   4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   5 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   9 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   9 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   9 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  10 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   2 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  15 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |   8 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h  |  13 +  .../drm/amd/display=
/dc/dcn32/dcn32_resource.c |  15 +-  .../display/dc/dcn32/dcn32_resource_he=
lpers.c |  43 ++-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   9 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  53 +++
 drivers/gpu/drm/amd/display/dc/inc/link.h     | 314 ++++++++++-------
 .../display/dc/link/accessories/link_dp_cts.c |   1 +
 .../dc/link/accessories/link_dp_trace.c       |   8 +-
 .../dc/link/accessories/link_dp_trace.h       |   5 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  22 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   8 +-
 .../drm/amd/display/dc/link/link_detection.c  |  10 +-
 .../drm/amd/display/dc/link/link_detection.h  |   9 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  43 +--
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |  23 +-
 .../drm/amd/display/dc/link/link_factory.c    | 322 ++++++++++++++----
 .../drm/amd/display/dc/link/link_factory.h    |   2 +
 .../drm/amd/display/dc/link/link_resource.h   |   4 +
 .../drm/amd/display/dc/link/link_validation.c |   5 +-
 .../drm/amd/display/dc/link/link_validation.h |   7 +
 .../amd/display/dc/link/protocols/link_ddc.h  |  28 ++
 .../dc/link/protocols/link_dp_capability.c    |  10 +-
 .../dc/link/protocols/link_dp_capability.h    |   9 +
 .../dc/link/protocols/link_dp_dpia_bw.c       |  34 ++
 .../dc/link/protocols/link_dp_dpia_bw.h       |  14 +
 .../display/dc/link/protocols/link_dp_phy.h   |   5 +
 .../dc/link/protocols/link_dp_training.c      |   6 +-
 .../link/protocols/link_edp_panel_control.c   |  20 +-
 .../link/protocols/link_edp_panel_control.h   |  10 +
 .../amd/display/dc/link/protocols/link_hpd.h  |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 66 files changed, 1067 insertions(+), 421 deletions(-)

--
2.34.1
