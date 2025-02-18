Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98E0C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 01:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6F710E00D;
	Tue, 18 Feb 2025 01:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwqU7XJ/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5566F10E00D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 01:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSpKkyYE8F94HSNtKNL42++243sQNHqH7PJGjWgBFraIeN7HOZJCmFAruTqrk8FPZdjc17BEr9R1L53orbEVrYVxyI7L5YsBzam8GiiZpILIXTUYbJDTZcQVLnRijJf3g6bYIaCYgFgESFtFiO7EGRh01UtsRmdcmYswY43jwc4TmlyHJ2oWMcL5Jt2CRBEuDI5zMy8+k0s/JTSG5S+kXl4Rk0H3HWfhAcS27KdL+J8/dvtGl30hgB2R0BeEaXwdmy685DOZ9/NzlNEep9oeXLhb9t48eNruRt2u/E5kVfJhFPf1d5HHiL+VNL+cLvgdHXMDNiZREwH+HeFdqBCBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjAY+Fa7qBecLoUm8zIkV6jSTNrYwGFbe/2+Nxk8R50=;
 b=TB8LjC/NmbSc0yf/BJ2hPY7g/joXDSr69G6jzM6fpwSU1Hr19qaJLVyb9AJXm1rhS9RwKs+PF7QWqyg8/sHapS7DlVNHBKeSiqkk110LRNOe1GGnUUyv7DgzzI97WnULX/6+Sn5dlh1A8dCV8DgpCegXTEvPpepC8zvtypTzJQ2wsG5RM/5oHkoNseUOpogkM3rOgxb9HExrY5F6Ot1jGygAVwnfE4HX44+8twbOaIDMgfN5hBgQ47e69JANOcMib/0L9MTGNyz7L+BczbKpJEf6bYEYJeFOpKhnoK/2n7+EcQdqInUaBfPME86CW5YWwxDhQz6pPHEhmKZL40zXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjAY+Fa7qBecLoUm8zIkV6jSTNrYwGFbe/2+Nxk8R50=;
 b=uwqU7XJ/mWUpGO1G6yN4hxrG2fyhzaLK3Wmnl25uAbFYTraEysYRKO5+W911oXi5l/uHiatiePEd6BjqVBcgSTRFNaEMUc798nBsdoeEJVp53skd27SqUJhQlv4Gqwr8AS7xy92FJsfCUA5DFV1nbwOwke/aCoEM5BEuu64nbk0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 01:21:34 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 01:21:33 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v7 1/9] drm/amdgpu/kfd: Add shared SDMA reset
 functionality with callback support
Thread-Topic: [PATCH v7 1/9] drm/amdgpu/kfd: Add shared SDMA reset
 functionality with callback support
Thread-Index: AQHbfdrG/SuQ1GscdEO/bmJV5U5w9LNMSvLw
Date: Tue, 18 Feb 2025 01:21:33 +0000
Message-ID: <DM4PR12MB515209CF99FAAECF3407A0CFE3FA2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9f7992ab-566b-447b-9d57-c6742570e13c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-18T01:20:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM6PR12MB4436:EE_
x-ms-office365-filtering-correlation-id: de640934-8563-4b07-5c54-08dd4fba94fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BRXx0AUpJlbRIthYuzEihHYxMaOuSR7rU0JcYkAbhq6Zza95kcj+a6SRMY55?=
 =?us-ascii?Q?ipeGjIvUY+eWjVmhhQQ/Y1iSdsiG4g9mwVDj27lNP7bqr3OEuHuBS2NVmu/w?=
 =?us-ascii?Q?H+u0/sF2D8eOy2eeRS+nnqt1pcV96OcBZEmKJG27/d3Xytjy3Zx37McicbJR?=
 =?us-ascii?Q?cOsebU2KSaCjy+AyoD4Jb2ir2KPqNKflHV8pDhJy45bSTUXq/lVpQTrygHC/?=
 =?us-ascii?Q?jvMra3+LoWrckPnZKdP7jaD6gUOiaTNPqwFd9SkKa/pVMX77++/8ksP36uYr?=
 =?us-ascii?Q?8nfdGkjpMgDZ7FhaO/F6kxaILiXrR6TR7UvBPv66a/CiytKtflWlcqZBqz/N?=
 =?us-ascii?Q?FlcPfJ0U/r+Tay6KAfzhW4bHCNJ18mHzGyT3GBDNESSY978SjpqTPJL4bqs6?=
 =?us-ascii?Q?9I8t3anQXSrsQKFLcsgzS5QOh/nFyV+4lEdy6cGUu/JzK0wYEBhi7mDV3mhW?=
 =?us-ascii?Q?PD+9OnijD+vhK7MVCCRNldUZMeuA4ER40XIU+qdmc2ARuHcpwhr+XmMJMsZX?=
 =?us-ascii?Q?7u3PqegnBdyHbLBrBBBXDRNXJCQus3vwaoDmimm+73KTS8UoCUPdYpg0GIW5?=
 =?us-ascii?Q?EZOnO4sdGFpTepZMgMgcSPEJPIp2UF8lWE+Se+vBHM1p1FDxqpSlZyQrW0vM?=
 =?us-ascii?Q?ypD0aoZCmfA1NhoznHdPtNoj7YQ3b0OVdvNMOJFQgnwJLOXVbEVSlzDZazx+?=
 =?us-ascii?Q?Wx3/zqRzQV/KNEENZFQiB+Y6jNTBVgLqe9cB0aFl/PTMvMt8wMJyebF56zQV?=
 =?us-ascii?Q?1UUJ74CmJ03MHMsWPMKM5lmpsUY4hFgbfUAPjJ5cCLu72s5Pcjyny9bS2CWt?=
 =?us-ascii?Q?aXth7bzhtDQ8NkkDii4bJpZh+9v4F9rNiFF4nDyXqRyL4+o6m5VHNPGiKo9D?=
 =?us-ascii?Q?O5WwFEktjCX0jYoubygsQPg1lzDCIlbeShM5AVHw5zj+3SpFGKiw94l2Zf5N?=
 =?us-ascii?Q?RcDnuNM2Ch/kbQIX299UEF6O5qhEMQvYROX0PlGWdHbD+FFdPhR7HQC5Kbp4?=
 =?us-ascii?Q?wlL8X1ikd0oxZ74UsVbZZd14dmZf4471j424IN8L9uYHHGn8f5B2q53lp4+7?=
 =?us-ascii?Q?MH28lfWJe1HcSxgYjSZmJ1CfvxtvnS+Sz/CVuAg8xS/PAE/onaQGp/deRwDJ?=
 =?us-ascii?Q?Zv7Ig20uhDWNSSP27BYXCWzIZhDHk9gvxmR9PVhg/yeK1vdofku6zhF9OJj7?=
 =?us-ascii?Q?RwXz8aRi0dBlF6+NNTSX0NT/cdPiPaaPZvKmdfGW4XgMno93LfcIbykn1ps9?=
 =?us-ascii?Q?UDnx3PlrbniFP01HRVlxNo0UGjEjZldzaHEWgnPtD3OZqVSbLw3sR9iR8a/F?=
 =?us-ascii?Q?FJdWrlDE+LDK7tMBB2UrKm8IhTA4jWxf5HHwILEVsCWQd3opE6GANuYGU2tb?=
 =?us-ascii?Q?nwWxVBrRhdifqAnHDOb/rRDmU+jwBrSjDJ5mRZThijj0hKwzNl06XuBXZpq/?=
 =?us-ascii?Q?wVdeYTPYApA+L7BF1O3pOu2xZ1eVnqFZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8lTkCohhaz2NWX3VBjnmToorFC+Jq/H+V5LO8bXaBn0/03iVIOIrKW1l7so4?=
 =?us-ascii?Q?jVC7oRfr7ZM9OQcXK4pWb1c+VqeFT4UfwWzNqKlF/5qcp/bpq0tgO99KvI4F?=
 =?us-ascii?Q?4KdWYEU8I3OyoFVNxTkxLyO1rL2V0JF/Kxc8CjwkXukiTlsLFbFfVp0FBqtK?=
 =?us-ascii?Q?w/uYIch9N2hZA9auXQQYqqtQROn7SM3i4RYEt3no4bdFw7at05ONi6+Y7ZrE?=
 =?us-ascii?Q?yEPVteBiBXStoDDPUuRGUlYRq8d5s/n7cS0DWhIcgHxky6QwCUBV0V0fzbut?=
 =?us-ascii?Q?eoC2pV44xt5Tsgp5+Ja3kcK3rh53158AxXIC8hUJ0rgydye9Lg2+ocx8nvjK?=
 =?us-ascii?Q?e7U1OFgl6/r/NS6vBfMF8Q+vBNPBWL0KPlSgSPTLM2+wgdeZl42P5qmw3zgS?=
 =?us-ascii?Q?R0jK3UZTc9qBfsSw2q4eVmnYEylNlz+3TqCTi56T4aN3J+Wn+51YuYI8r4o6?=
 =?us-ascii?Q?oKTyPywvfWl0xDiXA2YSW52STm0ooNyD0tT4TX+HCQfiP4J68aoLFSsLQDxr?=
 =?us-ascii?Q?OOBoLVZnA/Jx3dzIgx4YaFy2ihIOLd1U2DfX42Np0iCpe/z6F6cPjKNNg1w2?=
 =?us-ascii?Q?2VJW3JjVZl96S/Sv0FwV0ATcRgPuj+3R0Xt2INY8YG1LCmLpxrx49diuFkfb?=
 =?us-ascii?Q?dDcqWV9AXBfk8IGMlvg1aMXpBhzkrC/FL9CeN8KJpn0dQrHONtbMHemBWi7L?=
 =?us-ascii?Q?lej1qZxWCM0AqPaXT4YmBzdASraw/ZcDAF4bLC2z2F3duJ6bmGH/kAi270Gq?=
 =?us-ascii?Q?fxkFCM+pXbECIYKhh6of+bI3B7zwjuNr5HpZtuWjdlUNTZUQWpWioQyf7o9a?=
 =?us-ascii?Q?NqHExJYU9zP1Pk4AMEBJHqopufxM4jgvroeji4QAGAQbA6rRMTRxNMnoZ4Jv?=
 =?us-ascii?Q?hIo6XO3YJyLIERXsYLL3YNDrG+yDQsgF2GBAkGszr3WJ2wbiKPyve7uGuKw/?=
 =?us-ascii?Q?RM5+VyQj8JDGikYNXfpJm2IlQ+wSRCm5zrYuUvpzTF7rC6zPNnxy1vwue1EK?=
 =?us-ascii?Q?gu4rZWCTVAChQBLo8Oazbyiqy5nK5luiK5fdDgmf/pJuuo4xs1fC4NZpPKjZ?=
 =?us-ascii?Q?zhTlYYG4oAfrNUiur3y9z9rRj5XJiDGRT/i5uWLnHi5ECbnYsQyvA4qtkvEY?=
 =?us-ascii?Q?iQljbg5BligIJDxYPdqMRFhebospWw7XV8wMpMdD7t3Yybxf86JxzFyXlD47?=
 =?us-ascii?Q?V46PSpk3q49H3KSQfIdakZ6mB3RYoyulKzlQqZJw4rC8W1J/4rLyKVf3u5BQ?=
 =?us-ascii?Q?tEYSGvH9wiUpxGXSLAJQ6mmSwj9d8mv5530SGVrOfiGN+zcMX38Z68NmBTbR?=
 =?us-ascii?Q?kttU5RQG0O2l43MSOji29YLEePmkY3l++EEZEo/nwvFDeDaP9fD2hU7iHHOy?=
 =?us-ascii?Q?E5yCjHRXm3IYLnOtdlYkX6ow5gABeDAyuURTu48DMytZYi1VZ5gWQAQ2yKD8?=
 =?us-ascii?Q?6VT35dWjcUovtIABVSmipKkqrmBcQ1Ls0mMdlHzpte9Pc4JEUZr//ODiXu+v?=
 =?us-ascii?Q?7OstYJBqoRC8OxL3JLvDgzd82Sj08+PNENFQWlHhU6SVMHm/6f0Ue0hmNXcA?=
 =?us-ascii?Q?l/oo31wT4PkZDDwU72c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de640934-8563-4b07-5c54-08dd4fba94fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 01:21:33.8076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfoC+m7bLdurXNJ5h0qO/MQkdUR+EvBOinkTvQZJaXbsf1rID6IYjXxx84DNzi4hE0kSQH5uPwiGwYJR/owfYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping on this series?

Jesse
-----Original Message-----
From: jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Thursday, February 13, 2025 1:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiad=
ong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Deucher, Alexand=
er <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH v7 1/9] drm/amdgpu/kfd: Add shared SDMA reset functionality=
 with callback support

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch introduces shared SDMA reset functionality between AMDGPU and KF=
D.
The implementation includes the following key changes:

1. Added `amdgpu_sdma_reset_queue`:
   - Resets a specific SDMA queue by instance ID.
   - Invokes registered pre-reset and post-reset callbacks to allow KFD and=
 AMDGPU
     to save/restore their state during the reset process.

2. Added `amdgpu_set_on_reset_callbacks`:
   - Allows KFD and AMDGPU to register callback functions for pre-reset and
     post-reset operations.
   - Callbacks are stored in a global linked list and invoked in the correc=
t order
     during SDMA reset.

This patch ensures that both AMDGPU and KFD can handle SDMA reset events gr=
acefully, with proper state saving and restoration. It also provides a flex=
ible callback mechanism for future extensions.

v2: fix CamelCase and put the SDMA helper into amdgpu_sdma.c (Alex)

v3: rename the `amdgpu_register_on_reset_callbacks` function to
      `amdgpu_sdma_register_on_reset_callbacks`
    move global reset_callback_list to struct amdgpu_sdma (Alex)

v4: Update the reset callback function description and
   rename the reset function to amdgpu_sdma_reset_engine (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 73 ++++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 11 ++++  drivers/gpu/drm/amd/amdgp=
u/sdma_v4_4_2.c |  2 +-
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 174badca27e7..fe39198307ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -460,3 +460,76 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_d=
evice *adev)
                        device_remove_file(adev->dev, &dev_attr_sdma_reset_=
mask);
        }
 }
+
+/**
+ * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset
+callbacks
+ * @funcs: Pointer to the callback structure containing pre_reset and
+post_reset functions
+ *
+ * This function allows KFD and AMDGPU to register their own callbacks
+for handling
+ * pre-reset and post-reset operations for engine reset. These are
+needed because engine
+ * reset will stop all queues on that engine.
+ */
+void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device
+*adev, struct sdma_on_reset_funcs *funcs) {
+       if (!funcs)
+               return;
+
+       /* Initialize the list node in the callback structure */
+       INIT_LIST_HEAD(&funcs->list);
+
+       /* Add the callback structure to the global list */
+       list_add_tail(&funcs->list, &adev->sdma.reset_callback_list); }
+
+/**
+ * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
+ * @adev: Pointer to the AMDGPU device
+ * @instance_id: ID of the SDMA engine instance to reset
+ *
+ * This function performs the following steps:
+ * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to =
save their state.
+ * 2. Resets the specified SDMA engine instance.
+ * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to=
 restore their state.
+ *
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
+instance_id) {
+       struct sdma_on_reset_funcs *funcs;
+       int ret;
+
+       /* Invoke all registered pre_reset callbacks */
+       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
+               if (funcs->pre_reset) {
+                       ret =3D funcs->pre_reset(adev, instance_id);
+                       if (ret) {
+                               dev_err(adev->dev,
+                               "beforeReset callback failed for instance %=
u: %d\n",
+                                       instance_id, ret);
+                               return ret;
+                       }
+               }
+       }
+
+       /* Perform the SDMA reset for the specified instance */
+       ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+       if (ret) {
+               dev_err(adev->dev, "Failed to reset SDMA instance %u\n", in=
stance_id);
+               return ret;
+       }
+
+       /* Invoke all registered post_reset callbacks */
+       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
+               if (funcs->post_reset) {
+                       ret =3D funcs->post_reset(adev, instance_id);
+                       if (ret) {
+                               dev_err(adev->dev,
+                               "afterReset callback failed for instance %u=
: %d\n",
+                                       instance_id, ret);
+                               return ret;
+                       }
+               }
+       }
+
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.h
index 5f60736051d1..f91d75848557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -98,6 +98,13 @@ struct amdgpu_sdma_ras {
        struct amdgpu_ras_block_object ras_block;  };

+struct sdma_on_reset_funcs {
+       int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
+       int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id)=
;
+       /* Linked list node to store this structure in a list; */
+       struct list_head list;
+};
+
 struct amdgpu_sdma {
        struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
        struct amdgpu_irq_src   trap_irq;
@@ -118,6 +125,7 @@ struct amdgpu_sdma {
        struct amdgpu_sdma_ras  *ras;
        uint32_t                *ip_dump;
        uint32_t                supported_reset;
+       struct list_head        reset_callback_list;
 };

 /*
@@ -157,6 +165,9 @@ struct amdgpu_buffer_funcs {
                                 uint32_t byte_count);
 };

+void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device
+*adev, struct sdma_on_reset_funcs *funcs); int
+amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
+instance_id);
+
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_=
funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))  #define amdgpu_emit_fil=
l_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib=
), (s), (d), (b))

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 5e0066cd6c51..64c163dd708f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1477,7 +1477,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block=
 *ip_block)
        r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
        if (r)
                return r;
-
+       INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
        return r;
 }

--
2.25.1

