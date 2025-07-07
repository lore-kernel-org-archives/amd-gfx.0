Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59644C83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0314610E55A;
	Mon,  7 Jul 2025 19:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kxlWc8nl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E02210E557
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDlEosPIR1If84DgrOp8FtNJgHFZ1pfJediwMI7GBjL+XUkVIB9SfxKmCw80Mz9CqgenM19DxxteX4lZzSgZDn74ziphqkW4xwy3xbeBX6OY8D6K/HYt129/trsUaN2Tzepgo+ltZ+IiZJHBv6ZlGhEhkM1eRBtFuMa0bP0EuZvnLBdAjS8eV0HaDX3GDxP7omVXMIogpfycK/TOXUTi65FIJRlDUG9L9+3wJ4cWjDA+ckyRwlPYMPqlW/KE8jOjQwn1LdRIr5agYOcQC5PxBvg7WmYMfJjHm+zNkR+m5qmAIVleNHjW4idiNPSA/UWTmU7WGHaWpy6eAGOJ6cO85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tP11PU5z0KgO7cq9CxqRUSHDww1izpDy8pQDbL4Iyw=;
 b=IEbOSv/WE0HJEmmnO8IlYXK7tCLeFieqYlmkgncnSH3UfkJqy586bb23uMf9Po/KT1/BP0RhMZAKm/rM5sY0ycG9eYCUMpA0jm7t/5LA1oC7FlJ0l8LAXIS91ParerI//w5uIiFkhGZgDNaaPU4X+58af9JG791HuNGe+56fALzBKgvwET8L/w1197ID8GnPiH6/1caewoIshGRMaHhbKokdpFtPJN8Uj9vp/RBlzekW488UJUuQqbNnCxb5gWz8mzXdQHTA83BLJPJtsL6+3N8ySyyTq0UTeF/FPGphEc+C2LiD/Ooiu9gafn+qLcXP3pYemShcEmZoe7wthv/tug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tP11PU5z0KgO7cq9CxqRUSHDww1izpDy8pQDbL4Iyw=;
 b=kxlWc8nlCdn+CIFsskZGbCz4zlBYfiFnjZXAspTpNW8i+OGogkfmY/vRRgKRr05shuBb0AnZvuD8sjbYUUa3ksfeyuKDvAgslyjPTeMyqXV0/rdFrc5NGGzQOvStQHntgJoR3kcNcRw+FGRcX+jvVkRgDafpNv0lxK5djw1KAJM=
Received: from DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:51:22 +0000
Received: from DM6PR12MB4371.namprd12.prod.outlook.com
 ([fe80::c9e3:9cea:d6c8:f9e4]) by DM6PR12MB4371.namprd12.prod.outlook.com
 ([fe80::c9e3:9cea:d6c8:f9e4%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 19:51:22 +0000
From: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>
Subject: Re: [PATCH 00/17] DC Patches July 7, 2025
Thread-Topic: [PATCH 00/17] DC Patches July 7, 2025
Thread-Index: AQHb73eTq6/Plpg+1kqOYE5LWsk4cLQnEd+I
Date: Mon, 7 Jul 2025 19:51:22 +0000
Message-ID: <DM6PR12MB43719D06A129B02803CF0A85E74FA@DM6PR12MB4371.namprd12.prod.outlook.com>
References: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-07T19:51:22.0020000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4371:EE_|BY5PR12MB4066:EE_
x-ms-office365-filtering-correlation-id: 3b1a3361-88be-461d-d901-08ddbd8fa647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?d55HmvNUOVoEul0RJUtsDreOkaHt4OU79EXuoIj4xSTGHDgQ8YmQHMXaU5+L?=
 =?us-ascii?Q?URCJolRuIDMjBp9WL5vlqAIonF0C2HrGWSrq90D/Tt2hWPI/NjKJY7ynqZ87?=
 =?us-ascii?Q?C15pbQ7hciUybqTav58icc0/61dJKXA45Fr+50gZDjjl2Na5FVhMZE/PoAga?=
 =?us-ascii?Q?7xDIdye3RO94jHeCRPPER9D2WM0JJXv7b2wHtuGBcEdQ7ceC16FxrLCZxCvk?=
 =?us-ascii?Q?RT4+GTgB5GK9OSFZUY0bnXcfQaq/fllBCDHJQtH8aJhjDsWq7zIUcXaY6rHQ?=
 =?us-ascii?Q?Ch5lxbzdxVNKdR2dZiCQbTpT1mDFy8BJ5a/aZAXc/V04xlgPBwB1ptmh0yPx?=
 =?us-ascii?Q?hScpqwe2B8R5wFrqqQReD+pSAMrJt0ebcs4zFDQRlUiPjfDVMZb4jzonWIBR?=
 =?us-ascii?Q?OaVrk834zZoglyaX/4Vdg4drmH6OEQSsyIAN848EwY6docnjzsbcUbSMj4fR?=
 =?us-ascii?Q?lAaw+jIAHNMjt1MruqsBIxBDJhem4/+TE/42Wgb7YXl11uUUsP5o7TWEV3v2?=
 =?us-ascii?Q?PbtcV2/0ER+SAwtDy1P2nMde8isnAfuJB0WoZfDCRhinnOB3AWvGbHxEXONp?=
 =?us-ascii?Q?zdynhoHfqpqZDt09gi0d43uO8BkjER1pieYUcTzg+JAXv1BFelfcmo8FCZCb?=
 =?us-ascii?Q?j4ny1I0UrLVT7UxTaGbJyfxLKMNov65OS6lLofxZxl9PBVMSL1fueEYG0CXt?=
 =?us-ascii?Q?0Fb13PxRj+hxYcnbtO2f4yU0W4r/elxsg+1zfD2ji2dVhV3TQZOS5TT2KSQ5?=
 =?us-ascii?Q?0MePL5G+mhX9AASB/KA0q8AAUhNcAGCUMegDv8P96FD66ITeBlEKUU+MJ7f5?=
 =?us-ascii?Q?O50xY9Jk9fgl4cYpSE5Pr7ARfYH7EB8WMGyg4Lgu0YHLdvP1HwBzXpS2+aqQ?=
 =?us-ascii?Q?VTPTMU4RDArcGkDDbM0fVMMlsEpq2ALwxSql6Byp4L45eaG4OSQLxdo0LZuK?=
 =?us-ascii?Q?0krd2asQIJ5nwM2GlyHimoqC36VKKH6uX1WX6T3zHaTTsSjUDkbpxjn9qmOr?=
 =?us-ascii?Q?+NVrOTMQv09Oecf3CSzT+NYOzOKY23LWvjXjX0ROy9XWcdsGjitbAH7n9B+b?=
 =?us-ascii?Q?eLt8QJRevIC4QpHdtoeyTAPe/BDVzwa4ZOhEF4KZLq7iYGcZLgpny2Zk/fXd?=
 =?us-ascii?Q?ik7DkpTHwDNNU05v6fqIiWMLIvLvl5okdGtYhIKwkx5yLua19/pf40q6n5Tk?=
 =?us-ascii?Q?qrCZgQhLk7tnnldCB/mq3qIgYfje7JoX41NsWAlDSKZzSi+OptPjQ71CQM/a?=
 =?us-ascii?Q?kawecb27X+d3dhrhiawGI57MnxMjsnXVeNv7UVVNOI/AN8OsltA32EkLgIn3?=
 =?us-ascii?Q?nfoZRsrzXHUMjoyZMZn9ENrI6DqiJXUTkBwAjlKcaccC5QjqddxnXhGxP+J0?=
 =?us-ascii?Q?SBSZcmSxMC+G0wQRZgXLnhCQlolXfDnf8V9GyLSgGQYjwrCw+eoOhX59Jppe?=
 =?us-ascii?Q?PbBAB7r6Za0qz384lkJDAEnQBFSdEaYq7NN/WH23p5FiS61RyfXl+Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4371.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uBOz36wBY/mI0Lj2xR7vGXnHVsitWTwL2EaE60U+nTxbffESuBLEbbJdVetE?=
 =?us-ascii?Q?vK7K+o5kOgKBnHjdnq2TaFaQramqevog36drMfC9tz1FIUzekwsVsa4g3Lrf?=
 =?us-ascii?Q?4kj5smVTx7BS7haSz1Pnkcadgqo3cXEG30bmPlYXnvBjIWXpqI4kYC+WBV6A?=
 =?us-ascii?Q?/YpOEG6NUdgrsd33sK3l73uFmJ5y0/g/oT2tfhLkul5OFelm9RFlhpWTx2zf?=
 =?us-ascii?Q?Iw7ij7OOhmZ8Mt0Z3X4KgV/J0935DDQOSX03n1YHqQ5jZWPSienYubD7szfZ?=
 =?us-ascii?Q?c7fa7DixEzsqYUcLJ5101CMSKFrdkhlbFJxzpELZJtKbL64aKbrYp3ZHD+nR?=
 =?us-ascii?Q?mE8Kyey4AsYWvuo9kAundqTlLnsoX30TUTBkK12DJmN5oD3WHpYUnQ9QaAci?=
 =?us-ascii?Q?eZ99ljByDji1z2xqFNUAAr+Sn2xFopOYx3RBlpTJpOjw8FygAVdw8LiTe8Sj?=
 =?us-ascii?Q?8o78v7SKPwEZpPS/GAzK/qPwTqPQjPjGxPR1Aef109CIUZFt60c3y6GuEmul?=
 =?us-ascii?Q?Dwx87eE4H/nYiyLBOc1thok8fFe2Cl2H0yJxmFEJekJS/g2Q5QyCLLgG6URG?=
 =?us-ascii?Q?AjHY9P5eK6l1cG3nBEugA+FLeUOd1cjRq+Ky/0DZGDuLq0I0r8fbmfJMXLBx?=
 =?us-ascii?Q?iheBT/GkFL6inGKiB+UTVWFNK49OnFsxkxQ72mOR0qqJ0FOc9dojoKwCPy6s?=
 =?us-ascii?Q?1RGF9WVR+Tkjv9fkMwdNnbB0Vcu+ViT/52enalDn178P+q5PD5edjsZ+8z23?=
 =?us-ascii?Q?af3XPfSPNKrfFCMELIY2D3np9fOf5QjkuVTB8KwtDexaEX4iVi56TxVI3/hi?=
 =?us-ascii?Q?riE37eShGDSM2C3CVFeikVFdkfgpmdcPBLrCmR02MlUYg/CpwVq/LfReA0aC?=
 =?us-ascii?Q?IxgIRGKOLTyIxAlFbWWrbNGVvDd1okwvEJlOLKRysHR2UAN+V4iMPiBk/EaY?=
 =?us-ascii?Q?Zp08UkjIVWeaQfEudYkzkKUOyIBK8X8OQ6FWRSOaVNKUkUAYvRN0nS/l2rmZ?=
 =?us-ascii?Q?Mcr4oCVtvw9ay5i7SIkSP5oLshEXycp1XnzEhURitcHR4wBfBcSHzapOC17c?=
 =?us-ascii?Q?+OlD2r7ummlKtaE2kWj35fvdzgr8ouBIHfAVGA9TP5Fh//oJdxc8lRKBkZm3?=
 =?us-ascii?Q?Vwz3/99sX0L6Ni7E2ZAgntfnJQPoP0IrjLsluZcKIZqJ/Y7gb+U3qvq8clhc?=
 =?us-ascii?Q?ql/F4hWQEyG+Fmb1lOsHYODwdupbs/am/vy9HEhNzd7wrmplW3H/ptewQH/+?=
 =?us-ascii?Q?GGHFUjJZ8tMGq37Y8c0WZDMKVpwoYKuuWfKVV0biyaev9Ahk+R322zh0lXRw?=
 =?us-ascii?Q?/wA3s6j93EsfAFPeVroyS1mC/J14kchTF6c3gLYkSH4hSzWffqeqJU6QTK2d?=
 =?us-ascii?Q?WiZVlxS8UHJSc5AfWTuen17iMJ/nnw03rz8vxOr+mhpwNvq5RismkJXp07wk?=
 =?us-ascii?Q?1A7MlKDONpe/1vgcy8p5dDWdb39ZheYGe+GnVvc32Fie9zn6BMfYHaf0OtBl?=
 =?us-ascii?Q?yY0iZIR7JFqlGHtjGntEu2UpkxndbSxwTmfcxg+3S8v3Thr4L3a0zy9UOF1n?=
 =?us-ascii?Q?v6ojnUAJG6iJYKy9QYE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB43719D06A129B02803CF0A85E74FADM6PR12MB4371namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1a3361-88be-461d-d901-08ddbd8fa647
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 19:51:22.3996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUlBirZXjX/dcGIHcBqYdRxN1/NGJhiv3eS8E45mAmQIYcqMwa2OzadU8gUMH6m9M0S8sSLA+w6plg8Z8DpPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

--_000_DM6PR12MB43719D06A129B02803CF0A85E74FADM6PR12MB4371namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

This ignore these patches.

The series were sent prematurely.
________________________________
From: IVAN.LIPSKI@amd.com <IVAN.LIPSKI@amd.com>
Sent: Monday, July 7, 2025 3:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>=
; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Subject: [PATCH 00/17] DC Patches July 7, 2025

From: Ivan Lipski <ivan.lipski@amd.com>

start from:
  261fdc003175671fbda47d94d2244ba8c22934f5
  Workaround for stuck I2C arbitrage

Stopped at:
  a69637b2e3b0ee50bd1bd10552115bbe1dfe2793
  Revert "Add DPP & HUBP reset if power gate enabled on DCN314"

Please, pay extra attention to the following patches:

1) drm/amd/display: MPC basic allocation logic and TMZ
        Changed the commit message.

2) IP_CHECK_BODY drm/amd/display: refactor DSC cap calculations
        This commit message was pointed out with IP_CHECK_BODY; however,
        everything looks fine to me. Please take extra attention to this
        patch.

3) drm/amd/display: Notify display idle on D3
        The patch seems to be more related to DCN42.

4) drm/amd/display: Adding missing driver code for IPSv2.0
        The patch seems to be more related to DCN42.

5) drm/amd/display: Notify DMUB on HW Release
        The patch seems to be more related to DCN42.

6) drm/amd/display: Added static pg implementations for future use
        Changed the commit message.
        The patch seems to be more related to DCN42.

7) drm/amd/display: Free memory allocation
        Was initially SOB'd by Jenkins Infra account (sw.jenkins),
        changed it to Clayton King

8) IP_CHECK_BODY drm/amd/display: initial support for SmartMux
        Manually added 4 files:
        - dcn30m_clk_mgr.c
        - dcn30m_clk_mgr.h
        - dcn30m_clk_mgr_smu_msg.c
        - dcn30m_clk_mgr_smu_msg.h
        This commit message was pointed out with IP_CHECK_BODY; however,
        everything looks fine to me. Please take extra attention to this
        patch.


Extra Note:
1) IP_CHECK_BODY drm/amd/display: unit test framework with xmake.
        Dropped this patch.

2) PROMOTION_SUBMODULE_PREFIX-dc/sspl-END- IP_CHECK_MSG
        Dropped this patch.



Aurabindo Pillai (1):
  IP_CHECK_BODY drm/amd/display: initial support for SmartMux

Charlene Liu (1):
  drm/amd/display: limit clear_update_flags to dcn32 and above

Dillon Varone (1):
  IP_CHECK_BODY drm/amd/display: refactor DSC cap calculations

Duncan Ma (2):
  drm/amd/display: Notify display idle on D3
  drm/amd/display: Notify DMUB on HW Release

Fudongwang (1):
  drm/amd/display: Monitor patch to ignore EDID audio SAB check

Ilya Bakoulin (1):
  drm/amd/display: Add definitions to support DID Type5 descriptors

Ivan Lipski (1):
  drm/amd/display: Revert "Add DPP & HUBP reset if power gate enabled on
    DCN314"

Jenkins, Sw (1):
  drm/amd/display: Free memory allocation

Karthi Kandasamy (1):
  drm/amd/display: prepare for new platform

Leo Chen (3):
  drm/amd/display: Adding missing driver code for IPSv2.0
  drm/amd/display: Added static pg implementations for future use
  drm/amd/display: New Behavior for debug option disable_ips_in_vpb

Michael Strauss (1):
  drm/amd/display: Fix FIXED_VS retimer clock gen source override

Ovidiu Bunea (2):
  drm/amd/display: Add support for Panel Replay on DP1 eDP
    (panel_inst=3D1)
  drm/amd/display: Add HPO encoder support to Replay

Yihan Zhu (1):
  drm/amd/display: MPC basic allocation logic and TMZ

 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 .../drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h |   3 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c |  36 ++++
 .../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h |  31 +++
 .../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c | 118 +++++++++++
 .../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h |  34 ++++
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  33 ++-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  16 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  26 +++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   2 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  67 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  23 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  75 +++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  43 +++-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 192 +++++++++++++++---
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  24 +--
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   1 -
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 +++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  13 ++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  37 +---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  14 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  14 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   2 +
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  19 +-
 .../drm/amd/display/dc/link/link_factory.c    |   8 +-
 .../dc/link/protocols/link_dp_capability.c    |  19 ++
 .../link/protocols/link_edp_panel_control.c   |  19 +-
 .../link/protocols/link_edp_panel_control.h   |   1 +
 .../dc/resource/dcn20/dcn20_resource.c        |   2 +
 .../dc/resource/dcn201/dcn201_resource.c      |   2 +
 .../dc/resource/dcn21/dcn21_resource.c        |   2 +
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +
 .../dc/resource/dcn301/dcn301_resource.c      |   2 +
 .../dc/resource/dcn302/dcn302_resource.c      |   2 +
 .../dc/resource/dcn303/dcn303_resource.c      |   2 +
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn314/dcn314_resource.c      |   2 +
 .../dc/resource/dcn315/dcn315_resource.c      |   2 +
 .../dc/resource/dcn316/dcn316_resource.c      |   2 +
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +
 .../dc/resource/dcn36/dcn36_resource.c        |   2 +
 .../dc/resource/dcn401/dcn401_resource.c      |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  36 +++-
 .../amd/display/modules/power/power_helpers.h |   2 +
 66 files changed, 902 insertions(+), 124 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk=
_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk=
_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk=
_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk=
_mgr_smu_msg.h

--
2.43.0


--_000_DM6PR12MB43719D06A129B02803CF0A85E74FADM6PR12MB4371namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This ignore these patches.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The series were sent prematurely.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> IVAN.LIPSKI@amd.com &=
lt;IVAN.LIPSKI@amd.com&gt;<br>
<b>Sent:</b> Monday, July 7, 2025 3:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.c=
om&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.co=
m&gt;; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; Zuo,
 Jerry &lt;Jerry.Zuo@amd.com&gt;; Wheeler, Daniel &lt;Daniel.Wheeler@amd.co=
m&gt;; Wu, Ray &lt;Ray.Wu@amd.com&gt;; Hung, Alex &lt;Alex.Hung@amd.com&gt;=
; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<br>
<b>Subject:</b> [PATCH 00/17] DC Patches July 7, 2025</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Ivan Lipski &lt;ivan.lipski@amd.com&gt;<br>
<br>
start from:<br>
&nbsp; 261fdc003175671fbda47d94d2244ba8c22934f5<br>
&nbsp; Workaround for stuck I2C arbitrage<br>
<br>
Stopped at:<br>
&nbsp; a69637b2e3b0ee50bd1bd10552115bbe1dfe2793<br>
&nbsp; Revert &quot;Add DPP &amp; HUBP reset if power gate enabled on DCN31=
4&quot;<br>
<br>
Please, pay extra attention to the following patches:<br>
<br>
1) drm/amd/display: MPC basic allocation logic and TMZ<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Changed the commit message.<br>
<br>
2) IP_CHECK_BODY drm/amd/display: refactor DSC cap calculations<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This commit message was pointed =
out with IP_CHECK_BODY; however,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; everything looks fine to me. Ple=
ase take extra attention to this<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; patch.<br>
<br>
3) drm/amd/display: Notify display idle on D3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The patch seems to be more relat=
ed to DCN42.<br>
<br>
4) drm/amd/display: Adding missing driver code for IPSv2.0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The patch seems to be more relat=
ed to DCN42.<br>
<br>
5) drm/amd/display: Notify DMUB on HW Release<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The patch seems to be more relat=
ed to DCN42.<br>
<br>
6) drm/amd/display: Added static pg implementations for future use<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Changed the commit message.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The patch seems to be more relat=
ed to DCN42.<br>
<br>
7) drm/amd/display: Free memory allocation<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Was initially SOB'd by Jenkins I=
nfra account (sw.jenkins),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; changed it to Clayton King<br>
<br>
8) IP_CHECK_BODY drm/amd/display: initial support for SmartMux<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manually added 4 files:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - dcn30m_clk_mgr.c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - dcn30m_clk_mgr.h<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - dcn30m_clk_mgr_smu_msg.c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - dcn30m_clk_mgr_smu_msg.h<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This commit message was pointed =
out with IP_CHECK_BODY; however,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; everything looks fine to me. Ple=
ase take extra attention to this<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; patch.<br>
<br>
<br>
Extra Note:<br>
1) IP_CHECK_BODY drm/amd/display: unit test framework with xmake.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dropped this patch.<br>
<br>
2) PROMOTION_SUBMODULE_PREFIX-dc/sspl-END- IP_CHECK_MSG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dropped this patch.<br>
<br>
<br>
<br>
Aurabindo Pillai (1):<br>
&nbsp; IP_CHECK_BODY drm/amd/display: initial support for SmartMux<br>
<br>
Charlene Liu (1):<br>
&nbsp; drm/amd/display: limit clear_update_flags to dcn32 and above<br>
<br>
Dillon Varone (1):<br>
&nbsp; IP_CHECK_BODY drm/amd/display: refactor DSC cap calculations<br>
<br>
Duncan Ma (2):<br>
&nbsp; drm/amd/display: Notify display idle on D3<br>
&nbsp; drm/amd/display: Notify DMUB on HW Release<br>
<br>
Fudongwang (1):<br>
&nbsp; drm/amd/display: Monitor patch to ignore EDID audio SAB check<br>
<br>
Ilya Bakoulin (1):<br>
&nbsp; drm/amd/display: Add definitions to support DID Type5 descriptors<br=
>
<br>
Ivan Lipski (1):<br>
&nbsp; drm/amd/display: Revert &quot;Add DPP &amp; HUBP reset if power gate=
 enabled on<br>
&nbsp;&nbsp;&nbsp; DCN314&quot;<br>
<br>
Jenkins, Sw (1):<br>
&nbsp; drm/amd/display: Free memory allocation<br>
<br>
Karthi Kandasamy (1):<br>
&nbsp; drm/amd/display: prepare for new platform<br>
<br>
Leo Chen (3):<br>
&nbsp; drm/amd/display: Adding missing driver code for IPSv2.0<br>
&nbsp; drm/amd/display: Added static pg implementations for future use<br>
&nbsp; drm/amd/display: New Behavior for debug option disable_ips_in_vpb<br=
>
<br>
Michael Strauss (1):<br>
&nbsp; drm/amd/display: Fix FIXED_VS retimer clock gen source override<br>
<br>
Ovidiu Bunea (2):<br>
&nbsp; drm/amd/display: Add support for Panel Replay on DP1 eDP<br>
&nbsp;&nbsp;&nbsp; (panel_inst=3D1)<br>
&nbsp; drm/amd/display: Add HPO encoder support to Replay<br>
<br>
Yihan Zhu (1):<br>
&nbsp; drm/amd/display: MPC basic allocation logic and TMZ<br>
<br>
&nbsp;.../gpu/drm/amd/display/dc/clk_mgr/Makefile&nbsp;&nbsp; |&nbsp;&nbsp;=
 2 +-<br>
&nbsp;.../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c&nbsp; |&nbsp;&nbsp; 2 +-=
<br>
&nbsp;.../drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h |&nbsp;&nbsp; 3 +-<br>
&nbsp;.../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c&nbsp; |&nbsp;&nbsp; 4 +-=
<br>
&nbsp;.../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c |&nbsp; 36 ++++<br>
&nbsp;.../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h |&nbsp; 31 +++<br>
&nbsp;.../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c | 118 +++++++++++<br>
&nbsp;.../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h |&nbsp; 34 ++++<br>
&nbsp;.../dc/clk_mgr/dcn401/dcn401_clk_mgr.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 33 ++-<br>
&nbsp;.../dc/clk_mgr/dcn401/dcn401_clk_mgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 16 +-<br>
&nbsp;.../drm/amd/display/dc/core/dc_hw_sequencer.c |&nbsp; 26 +++<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_resource.c |&nbsp;&nbsp; 4 +-<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_state.c&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 2 +<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_stream.c&nbsp;&nbsp; |&nbsp; 67 ++=
++++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 23 +++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c&nbsp; |&nbsp; 75 +++++--=
<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h&nbsp; |&nbsp;&nbsp; 6 +<=
br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_stream.h&nbsp;&nbsp;&nbsp; |&nbsp; =
11 +<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_types.h&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 3 +<br>
&nbsp;.../gpu/drm/amd/display/dc/dce/dmub_replay.c&nbsp; |&nbsp; 43 +++-<br=
>
&nbsp;.../gpu/drm/amd/display/dc/dce/dmub_replay.h&nbsp; |&nbsp;&nbsp; 2 +-=
<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c&nbsp;&nbsp; | 192 +++++++=
++++++++---<br>
&nbsp;.../amd/display/dc/dsc/dcn401/dcn401_dsc.c&nbsp;&nbsp;&nbsp; |&nbsp; =
24 +--<br>
&nbsp;.../amd/display/dc/dsc/dcn401/dcn401_dsc.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dsc/dsc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 1 +<br>
&nbsp;.../amd/display/dc/hubp/dcn401/dcn401_hubp.c&nbsp; |&nbsp;&nbsp; 4 +-=
<br>
&nbsp;.../amd/display/dc/hubp/dcn401/dcn401_hubp.h&nbsp; |&nbsp;&nbsp; 2 +-=
<br>
&nbsp;.../amd/display/dc/hwss/dce110/dce110_hwseq.c |&nbsp; 24 +++<br>
&nbsp;.../amd/display/dc/hwss/dcn10/dcn10_hwseq.c&nbsp;&nbsp; |&nbsp;&nbsp;=
 2 +-<br>
&nbsp;.../amd/display/dc/hwss/dcn31/dcn31_hwseq.c&nbsp;&nbsp; |&nbsp; 13 ++=
<br>
&nbsp;.../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |&nbsp; 37 +---<br>
&nbsp;.../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |&nbsp;&nbsp; 2 -<br>
&nbsp;.../amd/display/dc/hwss/dcn314/dcn314_init.c&nbsp; |&nbsp;&nbsp; 2 +-=
<br>
&nbsp;.../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |&nbsp; 14 +-<br>
&nbsp;.../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |&nbsp;&nbsp; 1 +<br>
&nbsp;.../drm/amd/display/dc/hwss/hw_sequencer.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 3 +<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/core_types.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 3 +<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h&nbsp;&nbsp; |&nbsp; 14 ++=
<br>
&nbsp;drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h&nbsp; |&nbsp;&nbsp; 2 +-=
<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 2 +<br>
&nbsp;.../link_hwss_hpo_fixed_vs_pe_retimer_dp.c&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 2 +-<br>
&nbsp;.../gpu/drm/amd/display/dc/link/link_dpms.c&nbsp;&nbsp; |&nbsp; 19 +-=
<br>
&nbsp;.../drm/amd/display/dc/link/link_factory.c&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 8 +-<br>
&nbsp;.../dc/link/protocols/link_dp_capability.c&nbsp;&nbsp;&nbsp; |&nbsp; =
19 ++<br>
&nbsp;.../link/protocols/link_edp_panel_control.c&nbsp;&nbsp; |&nbsp; 19 +-=
<br>
&nbsp;.../link/protocols/link_edp_panel_control.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 1 +<br>
&nbsp;.../dc/resource/dcn20/dcn20_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn201/dcn201_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn21/dcn21_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn30/dcn30_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn301/dcn301_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn302/dcn302_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn303/dcn303_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn31/dcn31_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn314/dcn314_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn315/dcn315_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn316/dcn316_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn32/dcn32_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn321/dcn321_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn35/dcn35_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn351/dcn351_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn36/dcn36_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../dc/resource/dcn401/dcn401_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 +<br>
&nbsp;.../gpu/drm/amd/display/dmub/inc/dmub_cmd.h&nbsp;&nbsp; |&nbsp; 36 ++=
+-<br>
&nbsp;.../amd/display/modules/power/power_helpers.h |&nbsp;&nbsp; 2 +<br>
&nbsp;66 files changed, 902 insertions(+), 124 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30=
m_clk_mgr.c<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30=
m_clk_mgr.h<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30=
m_clk_mgr_smu_msg.c<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30=
m_clk_mgr_smu_msg.h<br>
<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB43719D06A129B02803CF0A85E74FADM6PR12MB4371namp_--
