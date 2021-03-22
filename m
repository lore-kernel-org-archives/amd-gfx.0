Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCD7C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0C36191F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0C36191F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D618E89D7F;
	Mon, 22 Mar 2021 13:27:43 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700088.outbound.protection.outlook.com [40.107.70.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A4F89D7F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 13:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSmNsBI6vIGWFDscrzI7a5tZPAu8tyrNj8XbIqOB++5ghZXeIDjPM04NlZAmyq1NaG/aSVsYYXqUFnN+lu1gnFKQhnf3Zsq521UcT4kOavk7ymRKJ2fZknmEnIUOy6JzWeeuy1JZEONH4j8es7hZCbXdHO8o0POPFazGX7C8rfjq8r5XHXr1W1DbBM0nkUo0J+6HUiylOuwSdLFWTTpI26D1/lSxYCgup9r66AnC9umRJ5bsoVNyre04/gSdgStQpRd60pHigzYwPtNalVVO8azksGkUI9XGNbh5ZNtvAGb0Yv3R0t0cHx+iCEQvdxXb4X2BV08nF7b2wgkk8wU8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbF9WPRSWbJyvmMocTFaIGr3jqKsPlDRKQReF3NwF/w=;
 b=ofAfmP5b6uT+wWUYQvrIGEWPhhQIZwuK9kQyA1q2f03B9PsQwDEF3snBJMG2xxFW5YxsLDWFuudh7+loPOYN5JXiqJSriFKYhxcmnoxO5qLMFr+oSDUFbWwYD1lrmUjToGNhhHLllb2MY2CbaBF0wVoh+27EZa5p/sZpiKSqTrS/DOpX2kokL4hFOHJ5deIFA9DwQ1ciRo9ftjxyIUYfs7BoGp+CeVbta19kDmgdif+CssBL7cK+ivKhHhJxr/H5Z2V2fwBkzC1KnkD39E1Tu5n5PKSTvT0FOCnlWkCJdk1dqDFrm8OhFYkgfSx/OsEk4jJH2dx705NqbSStYxbYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbF9WPRSWbJyvmMocTFaIGr3jqKsPlDRKQReF3NwF/w=;
 b=44pThBnlH5mh7mlLykzkzbIibGyrqT/po3ccK5l+LPaT26H4TzsoJtlR0viZONik4DCmJ8KMdQgkyIC1Yu+PhQoNbQfS1OnUnM0zcpxmh9tHRpNK7b7jTegFV+Mw+7coW74G09RkcGnPNibPWwfzqJD3t57nN67w6XjsJV1kKbc=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 13:27:41 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 13:27:41 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chiu, Solomon" <Solomon.Chiu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches March 22, 2021 
Thread-Topic: [PATCH 00/14] DC Patches March 22, 2021 
Thread-Index: AQHXHUAgb6c4e/FY/0iNJyT62QpgkqqQA3ug
Date: Mon, 22 Mar 2021 13:27:40 +0000
Message-ID: <DM6PR12MB352998F1DDDED2EBEB3AB1E79C659@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T13:27:39Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d88744c2-89ac-4c7c-a12b-b74209ed5fe9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.64.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 952c4895-f20a-4517-b4e3-08d8ed3644c6
x-ms-traffictypediagnostic: DM5PR1201MB2473:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2473AC785EEF95AAB7D833809C659@DM5PR1201MB2473.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Vl9/8xxxPX8RXEC4u5uyCwDF/vMbvd6JVCy73MTf83MslOeMRM1DGTdFK1AqjHS7vFTxdki7Wgqz6siVYT1wUU4C61Rl8mM2EinoXUl+k6kYuAjNFA1njzcDWCxRywMLzRDz5Sg79wSXbBqx2qcjUCu56ziw8Xk68LIACr0rj4ABUeXSQUSgc4LWIBZj72S9L+2zGghG7lNXchcPib/Frb4XkbB/rS1r4k/MtSbnhnOgPIF6GZFQ79v2vckaHRBxOalPU1fe3MqzOymAOFnPHNQt7t/Qd5tRqVakKJmnBedcsJNOVjGCDhDmWfUxM04gVDS7EqGHCsUPiBrDH7ONvzBDMzHxY4PDqkDawSrAydM6U9BzdQCHnohxbKTzL8Iw//VdJxE0pWNL6hDOEI1GEEdehuc02GhvGSZwI9eKtmeD3wP+OaiL4dv0TIO1l674NyLcOBOwkRQUPpCQN5koPxYiRLLPq9L2jirHtLI6fdtoqeJi5CPeIHv2Mq+1cWT/OWjdDiu7Q8OtXlYc5gUPY7oshv5HoKcoqsrWon6YrKaaRlfdqCI4QG4JDf9qS6eYxRYFY5eLRXL7GzvOtwPRMnulDfii4B+yYbZsfnUkRZwXnCRR5zfftl/knIkuRsj/0+yP4RJJFT7EcYIPAamsBw+B5p4UAUwlgr0ZOY369IsEWIlNreAwpv1gEAaOjCD1ZkTru5Ym7sNUdZZIFE0uA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(66476007)(66446008)(66556008)(64756008)(478600001)(76116006)(66946007)(83380400001)(45080400002)(9686003)(52536014)(5660300002)(38100700001)(33656002)(2906002)(86362001)(4743002)(966005)(6506007)(53546011)(4326008)(8676002)(110136005)(8936002)(316002)(7696005)(71200400001)(26005)(54906003)(186003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?kBZKW+ntrH0kdtSx3Vf0St4+/vbLsPiwaYCd0J1b89Lltr6Mmu8AD9Jbhw?=
 =?iso-8859-1?Q?xfzl5BEQkkw1zEfkvwniVj87PolRw9Q6Wk0qAat5jzknVkVarWBcoK/Osa?=
 =?iso-8859-1?Q?W3BlfryYUii24x4/8TWu2jJtDl3bPRX+rjin3o8X7CK3kY4AmhjGKcoyFq?=
 =?iso-8859-1?Q?Z9znObOU9tRBMJuwa84y+qp92dxi5A90c+60CbTzK/C+U3N/XV45Fj7ksX?=
 =?iso-8859-1?Q?ZMVvsYyfKakJsKautdH87+DX3935mi0eiG2r7BW28eEjAjNvVsT0ZMXWdl?=
 =?iso-8859-1?Q?eVYDfIX3ZVrOKWqRthJ8cquQ4PWFY+QOir+TxDjtjIOIUat3FWfqxbrXzC?=
 =?iso-8859-1?Q?bK+agmXK5emmm0aiqtygM2eA5+Qpn9D8I+UYsYo2iGbZ/q6a9hT5BpZtfI?=
 =?iso-8859-1?Q?OxZcmfnVhXCzj026UwR/8fywJV6g6oC9C68M22Px3dLoJaDPrjlXRe0tRz?=
 =?iso-8859-1?Q?Y8JnzvsjcilweqQILWZEx8qitvI9q6rdJjG26ZoSs8/0Y6+jDBhtfmh+a5?=
 =?iso-8859-1?Q?xw0ndDQ8R/R7JCC8h2KR1YHphBE4hEoowMJNnxmLgWUDXyjQKQ2JbsMExV?=
 =?iso-8859-1?Q?GWIvnxXwiNDeZ+p68Le7CYR06zfBfxeBX4KSuN1oiCCQUMgS1+r0YQUmd5?=
 =?iso-8859-1?Q?p+apD3HZ68KuVPll2lDKMU/oE8xLSt/zGgWCuI1p9CWiSBbZL7+XtaDJI0?=
 =?iso-8859-1?Q?y5O64LeiLN2AjxYBc4khQI4cjiRDXXuSNoZXRr2cTyoY6PcjeZmZGs+loB?=
 =?iso-8859-1?Q?KYvVMa6msraziML03AT59UqnyQnpMX4mysyWm0P4kNUQzvbm5LBDSJYQLG?=
 =?iso-8859-1?Q?oFiLhmGCvHiVMH4cA97CcO9VfJan1Y+GyEduZXQyGv97mnq9RQ/MEzSDmR?=
 =?iso-8859-1?Q?0im9MN5esg42rLyYTlsMJi9bnYtFPcB8IlDzpVaTtIOIcV7NYq0XG2XGHO?=
 =?iso-8859-1?Q?Qn2Ik0S+dwvoSXAUU56qdOjH5duldQYWH+DJ3KCckmYRHkeeEtYST/Z1Uv?=
 =?iso-8859-1?Q?jwrQuy9TRFCHgChJRAa5K53DLJhtMzhCsgKMFhJ6dWNgg9CyJvCny5hgb5?=
 =?iso-8859-1?Q?BJVTcJ1r16BN3QglUxfCuia0LqMTmqgRv5tHNsYjSo+u/FiKQuru+MZhGa?=
 =?iso-8859-1?Q?Okeqozjx0XqinquGvu0a9RdN+rgcABZBQzbgJCwq2+m3al/wF4XRV8sbML?=
 =?iso-8859-1?Q?UDCT96T7mIP/VyPMIveOQeSYH1CRuskrIavNJlLveTXAF4IwxEsEyBrAJ8?=
 =?iso-8859-1?Q?WALjXrPqdXc6kH/PSsIdEHA8k4H6XCQlbkx6SNz4YCwdd25Gx3IAFKn1G4?=
 =?iso-8859-1?Q?QifOJX//ViUIUzT5Ll3AEr2qy0ehQM4aPiDDdDnGNVmG8SM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952c4895-f20a-4517-b4e3-08d8ed3644c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 13:27:40.9226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXPRrRb0/Oq/0yURD/RSdG/zT9uai/VXcjhPVGe8rviadkey6u+mp1rw4rDS1cFzHwV29bU6FwnuUHBULg0s5w==
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
Cc: "Jacob, Anson" <Anson.Jacob@amd.com>, "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
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

[AMD Public Use]

Hi all,

This week this patchset was tested on a HP Envy 360, with Ryzen 5 4500U, on=
 the following display types (via usb-c to dp/dvi/hdmi/vga):
4k 60z, 1440p 144hz, 1680*1050 60hz, internal eDP 1080p 60hz

Tested on a Sapphire Pulse RX5700XT on the following display types (via DP):
4k60 60hz, 1440p 144hz, 1680x1050 60hz.

Also tested on a Reference AMD RX6800 on the following display types (via D=
P):
4k60 60hz, 1440p 144hz. =


Also used a MST hub at 2x 4k 30hz on all systems.

Did not see a visual impact from the patchset tested.

Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display
O=A0+(1) 905-882-2600 ext. 74665
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Solomon =
Chiu
Sent: March 19, 2021 9:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; L=
i, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd=
.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.S=
iqueira@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Au=
rabindo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R,=
 Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/14] DC Patches March 22, 2021 =


This DC patchset brings improvements in multiple areas. In summary, we high=
light:
 =

* Populate socclk entries for dcn2.1
* hide VGH asic specific structs
* Add kernel doc to crc_rd_wrk field
* revert max lb lines change
* Log DMCUB trace buffer events
* Fix debugfs link_settings entry
* revert max lb use by default for n10
* Deallocate IRQ handlers on amdgpu_dm_irq_fini
* Fixed Clock Recovery Sequence
* Fix UBSAN: shift-out-of-bounds warning
* [FW Promotion] Release 0.0.57
* Change input parameter for set_drr
* Use pwrseq instance to determine eDP instance


Alvin Lee (1):
  drm/amd/display: Change input parameter for set_drr

Anson Jacob (1):
  drm/amd/display: Fix UBSAN: shift-out-of-bounds warning

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.57

Aric Cyr (1):
  drm/amd/display: 3.2.128

David Galiffi (1):
  drm/amd/display: Fixed Clock Recovery Sequence

Dmytro Laktyushkin (3):
  drm/amd/display: hide VGH asic specific structs
  drm/amd/display: revert max lb lines change
  drm/amd/display: revert max lb use by default for n10

Fangzhi Zuo (1):
  drm/amd/display: Fix debugfs link_settings entry

Jake Wang (1):
  drm/amd/display: Use pwrseq instance to determine eDP instance

Leo (Hanghong) Ma (1):
  drm/amd/display: Log DMCUB trace buffer events

Roman Li (1):
  drm/amd/display: Populate socclk entries for dcn2.1

Victor Lu (1):
  drm/amd/display: Deallocate IRQ handlers on amdgpu_dm_irq_fini

Wayne Lin (1):
  drm/amd/display: Add kernel doc to crc_rd_wrk field

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  48 ++++++++  .../gpu/drm/=
amd/display/amdgpu_dm/amdgpu_dm.h |  14 +++  .../amd/display/amdgpu_dm/amdg=
pu_dm_debugfs.c |  15 +--  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | =
 12 +-  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  71 +++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  21 ++++
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 116 +++++++++++++-----  ..=
./amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  13 ++
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 101 +++++++--------
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    |  28 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  10 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   9 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  14 +--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   6 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   3 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  28 ++++-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  28 ++++-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  28 ++++-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  28 ++++-
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |  28 ++++-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   9 --
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  32 ++++-  .../display/dc/=
irq/dcn30/irq_service_dcn30.c  |  32 ++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../amd/display/modules/freesync/freesync.c   |  37 ++++--
 .../amd/display/modules/inc/mod_freesync.h    |   7 +-
 35 files changed, 581 insertions(+), 197 deletions(-)

--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C6f07175d95c342eab41908d8eb57410f%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637518107284787999%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DXFDn1gjvchG61%2FxUrmWgzDpe22XKXWWktzfokHncJTw%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
