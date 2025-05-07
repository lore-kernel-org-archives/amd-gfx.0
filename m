Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B713C3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 09:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65C310E38B;
	Wed,  7 May 2025 09:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UyX/T4ss";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5244F10E38B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 09:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAMr4Zchpk0p+0e3nE47wxbqwejb1XlbSVrwSEjSsyryN1+9uMbmTt3cQwYAEBJrjB17+YHGHVUQVHzFPNt3/oUroscRpDvfSSkOPQYsbLqdTDxbjHadsY8LFywBOGqn0GRpBRX5dwZK3cNzTtL3U2SbAwgjIrqoESOuqf+vTLYniTgesaynCElnvSXCCBFkjrhSvIxPFa4wuVdoHIT8z1RNsxLFaUi71IWOdUS0Bq+XCPPTplW9jHTa7CkD5elYiPEglBbY9ic4WPkYXOaLaKvMCulRKuAAJr4q7iU80uZRIcRUfPj67NYMh148rOV7L19D2ij8jfZtfzYEMb2Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJV/fVujddYxe7nlOMZ5VeNo0ELex1aMAncHoKLqxZA=;
 b=UN/4Mf3Sy3Z338W08xWfk88wltY4oiVdGU2Dbx6ZHcw270B8UTW1rLfLYl51CMA/2RrMXJLB85MVWL1HuWtyKxCGcfkqQZJPd6P4QHRYNGqSkxI5LZJtSOGbHcSzf+yty9RlhQnz+cw39eLpRjUJJnQV4SuqDlclNvHIkQr0fhxGAUdIBEaD80iXBdmuiAW5K63uzPeTzPk0J8HI9XOjBgH4Jh9pLVTvRRRQPJeCBmfsLsIXsDtYLG9nR7dp7B6tFVJVomhj0i4EQkuxVbeeXauIbyzZi5X8OSw95f/ye2DfJY+okJK6l8D5rJLKy9pKr7djsUgc/DAgjYi6nD72Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJV/fVujddYxe7nlOMZ5VeNo0ELex1aMAncHoKLqxZA=;
 b=UyX/T4ssKR0vvxFeudHiTEUt2Zq8OlN7Rl5W1WftPRiSZgvZP7Drv2CPSn5QvAdUyNji56Ibjc++TaGny62LYbTqy+gCJvzFPK046Jh+2C3NjW4LrBxIYkSwLrWGFU4GjVCAxiemPoBjjRCX7bw53vY6+DV1IGP7dXSJs4aH1/I=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 7 May
 2025 09:35:36 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 09:35:36 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH v2] drm/amdgpu: fix the indentation
Thread-Topic: [PATCH v2] drm/amdgpu: fix the indentation
Thread-Index: AQHbvzKQDm9GCt8tfE2mYM3QGyRMGLPG6EPw
Date: Wed, 7 May 2025 09:35:36 +0000
Message-ID: <BL1PR12MB575362E1780D89A61C5324D79388A@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250507092934.701120-1-sunil.khatri@amd.com>
In-Reply-To: <20250507092934.701120-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Arvind.Yadav@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b0e0b540-0f16-4cb7-a39f-89062178958a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-07T09:35:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|PH7PR12MB6810:EE_
x-ms-office365-filtering-correlation-id: b7d10008-b6ea-406f-c06e-08dd8d4a8581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zu+KubguTOy1tpRawvpjYNuucydPIClEs0sUo9xLp2bDO4FY1Z4ItPALJDaB?=
 =?us-ascii?Q?bhck+5/qNLNtnavxI91OU1X/qPGXvse7+K6gL5g9fnOw9XfVd8BeAg09w2jM?=
 =?us-ascii?Q?LBNQFlYQBLGC76vxN6gIV5fx1HDKhko7rQtZew16pnvKj8umanY+YIg6F5re?=
 =?us-ascii?Q?FBYhgQN4WTAFdMkxC2B1FXjnrwrrzvfikra9WSPO9F4TxRiUaJh8ZjhMfDwF?=
 =?us-ascii?Q?3R9IkXjEWk7q5kUaGm7SOlMxCNi7mJ6d4xcmHMAQUbNiXQzn+mNbHViUgGgw?=
 =?us-ascii?Q?6KcfFgTsQvrBlMKo3uGKHtwfhVbDmY2XQyInUyAaT6TO6OG/50DHZApfSeYe?=
 =?us-ascii?Q?FMUbJdaJ39V8oIJqdwg5hNH9oEIAv0yWHPTKT0/iCBUQfOUWXphVjstSFG0F?=
 =?us-ascii?Q?KQV/a6PdHEprotBb+aHLQoiRr12cHMTeobtUe6W/riucymnE7uTQPU+fWyGb?=
 =?us-ascii?Q?leHYRgZUnlfaw0ldI7j1rm/+oPxnSWiFedlUkusB6iEEzRLUt1zTG2ZL+QgG?=
 =?us-ascii?Q?Gq5WlQxeikEv7XhjE5pZga7XmKVNT5OJC8hXkHUSa647DXhytNtklOIhYOhu?=
 =?us-ascii?Q?BXjVey43uWyMX4INKPA70qmPly1h7x2pfE6rpH2Uhzvl+9ikzsu+eijRMkGq?=
 =?us-ascii?Q?42X5vFffw9jvBU8HPyvnTWTeJKZ+dKfxq065MQvRZU5u/g3K3S+GR0f2X7jG?=
 =?us-ascii?Q?WUCm0Bs+AjqqZPPXWZF1dCmkryWH8Xz61HfjIloIQGIWpEixH4EMv4zFRPrH?=
 =?us-ascii?Q?iJt0SKgw78yfZsAW7zD2PO2gxE11n6a8TqKWMdQ8RUXaScragmP3wDzOAK2Q?=
 =?us-ascii?Q?mUStoFvUvEpgyjL8UWgKqW09X26vU+53o1N7rs48oBZgAaRHrCfn0sG9/QDT?=
 =?us-ascii?Q?Ey1go/Zsspc5LYokZQMEbj11SNr5eBGFVipTi8XmEcI/UIwh0s2wbYfSucGl?=
 =?us-ascii?Q?XJh2kXLDjmctZeBzTGYEVQZ0VVLnvdnZTQcuzzPXuwtPRHxx69MYHlgPn7ic?=
 =?us-ascii?Q?ZlSgA4osg41N8C6eOuWrzPrWKiIEHFyXY6QBN4jBMpMDxtlIAH9E0MyiSxtu?=
 =?us-ascii?Q?NqQVHKPCHnrwZXcyp3Em9awhujlsa7ZE2dUl/ez9AeuoTPx0bmRn0vX+rFkq?=
 =?us-ascii?Q?5iXOnjnliExyO3kEpieceAELV2lPz9pXIVFketwO7gh1j6uCvn0kzjxD5kHz?=
 =?us-ascii?Q?Q8YKsk62ym1Gpw7mZWVCh2YySsO1QnDSIcN/CPizLFx1CEzt938dpAbDjJq4?=
 =?us-ascii?Q?pZBeotKICWFYcnzfgTqdnWBC16Ix/hWsJUfoIrBBoa3Q3cIqTkP1lyBAENfg?=
 =?us-ascii?Q?uC4WeRyjIII6Ze1OK0/8M0VHcBT1rg6c9MkSd9sGRiUTiHMyuoNMI/CaqDML?=
 =?us-ascii?Q?5CApurTMxasbOgxvWyPI7Rc6nauHDevC+MBmwfSzHq3H/5KASJb+OWmLIHnk?=
 =?us-ascii?Q?UKKK61vJKSGQM7SmXTh7/LOWRaAU6sdNHEradaOmRfx5JORhBycKj5VFdGNa?=
 =?us-ascii?Q?uQ5WWarAqjHnf/k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rG4abketEhq9Q7rNBmgFP4l5lV7OskI/lllcz5GYuLY1vzkYgnE60w0ptHwq?=
 =?us-ascii?Q?IhaVmlbHlB+sVfdBj5O3PZUf2NkKz36EpALbZugssVy/RwAekRh4MWBwezCg?=
 =?us-ascii?Q?loxai7O/Rs65C+j/FjBave35CNmR0T9TjygYuHOg/fKajWAg16pFJ7xagQ7j?=
 =?us-ascii?Q?EEm838mA3tutBBdYxDZeo4pxen+bk+GcvkREkohICwAb2ESn9gEXCXAXXOjN?=
 =?us-ascii?Q?UXbpyJTqYaLi8FXONG9U3m7fSWCdueBKOLtBPzQCFrXHar1eQDh/2px7bux3?=
 =?us-ascii?Q?WMXVx0cgdUTLHZIFSwo5M4EZZva5nvDQY/Ep68/yC0MjImmqycVa8ljT+4NJ?=
 =?us-ascii?Q?NCWWpWDAjGX6NE8CsxnBZ2wLULQxFiNYuHsbPBIpB4sA4D9SmutU4wOclrgZ?=
 =?us-ascii?Q?dtu7mXrqK8t17pzn8sBwrDriFsO0Ea6/9CErKcDDqSfIi/bW2sNOKHueHTkd?=
 =?us-ascii?Q?ZcfVpVBVhOoN6EUraXI0fwz7nOA4qET6Gehu4D13S3OQNv/djTEw9z3Qaef8?=
 =?us-ascii?Q?icuL8WR1A1Pqu/ah9HHXb30dV10RyCevHKilIrHc8Tl4pqhOEM9H5ya240Vh?=
 =?us-ascii?Q?jIx2zuSc8ukKpDyen2rHKHOeQm+ntv2h1NepP1O7zoB1G2ojnvgZUfpuwMhj?=
 =?us-ascii?Q?xSZiKKGe1QdjnJDa0ztQYKlRJSm04Ma8HsyV45zOrMBciVrPlzNP005O0AZP?=
 =?us-ascii?Q?n7Mr6ZsYhSDGGZB1jVrQe4DJkn+52pygCJKuB2sfFkkTz2RPIj45kIJw0Ip5?=
 =?us-ascii?Q?CWqBmbKmkIT2GaRO/Q4KXa5NGN8qe6Az19/yro+a3tZ6jrdNmK2jicRLhGdv?=
 =?us-ascii?Q?s6gQsemYFUPD0tDAFLYMz8X6Q2nPqr2JuaYCxv6WSdoZWxfy+oe09RxUk7dJ?=
 =?us-ascii?Q?Nwg5yWpkMvb6eLVeKcpLg0u6SPK6O02+yqUAk093LMuJDh7zpzepIPlD5yiS?=
 =?us-ascii?Q?d1OoB135uxxltcHIgiH/gB6i0azfZy16YLe5s0N30JK23IZmMeN3aZVgvqze?=
 =?us-ascii?Q?dg/YMcPELZa5a7iv8bbwW39xC49VwZILPTnRk0o4lR7jVpbajvV3karjJgX9?=
 =?us-ascii?Q?PymXD8lNawRsD6INQsw6/JjWxi75oxuB2EPvSD1AP4xNpevGJoe9JjZt6mQl?=
 =?us-ascii?Q?sfmr8J+Ls52v3kv/iiV/gxFe6k1IrsS2wiRFUb3f12tezPrY1NKNMB7IVSSI?=
 =?us-ascii?Q?PwfduU8pfY9dy02m1MOqxbQQBnYvijRNMrwwqy0ZrKbYqQX2UtRKhOQXz0lI?=
 =?us-ascii?Q?mhsnHVEuqhtuq50uyRlzUfqYVJls3HtJ0ckpQQtDCc4QS5IiF5NKI/pOnwvF?=
 =?us-ascii?Q?LUzN7LM2YAQnHa0TkEgNexCktF5Qtcb3O4sQk5Ddr/7YSXuzhhkALzD0fJm0?=
 =?us-ascii?Q?wdoae/s5VySmdTnD5PDe+cOB+839XfXfOJiv81r1RmN0gYMRu+NwAESvk9u+?=
 =?us-ascii?Q?LzzHsbO9nbYYHAHHgQGHKeHQ4bVVUA2QIaFcWmyc73aclvg0yN9vdPGiSRgE?=
 =?us-ascii?Q?oMtc+JejZNSGwBGtDjsknF0ZHBbiC99vqaf2Ci6llf8nMvImX13yDty5tu99?=
 =?us-ascii?Q?a55uxghxV0YTb1SB5s4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB575362E1780D89A61C5324D79388ABL1PR12MB5753namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d10008-b6ea-406f-c06e-08dd8d4a8581
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 09:35:36.2832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gP0CBH57RyWkDNQIDZboWr/gMGpqRXVZpQHZin0cFPun3/qHnae7GnHQeZHYl7c+G5k/AaR5J488OyVf3w54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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

--_000_BL1PR12MB575362E1780D89A61C5324D79388ABL1PR12MB5753namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


@Yadav, Arvind<mailto:Arvind.Yadav@amd.com>



-----Original Message-----
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Wednesday, May 7, 2025 3:00 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>; Khatri, Sunil <Sunil.Khatri@a=
md.com>
Subject: [PATCH v2] drm/amdgpu: fix the indentation



fix the indentation

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:6992 gfx_v11_ip_dump



compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

| Reported-by: kernel test robot <lkp@intel.com<mailto:lkp@intel.com>>

| Reported-by: Dan Carpenter <dan.carpenter@linaro.org<mailto:dan.carpenter=
@linaro.org>>

| Closes: https://lore.kernel.org/r/202505071619.7sHTLpNg-lkp@intel.com/



Signed-off-by: Sunil Khatri <sunil.khatri@amd.com<mailto:sunil.khatri@amd.c=
om>>

---

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---

1 file changed, 6 insertions(+), 3 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c

index 3f4ee4b3b0a4..fe21393e155d 100644

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c

@@ -7094,9 +7094,12 @@ static void gfx_v11_ip_dump(struct amdgpu_ip_block *=
ip_block)

                                               /* ME0 is for GFX so start f=
rom 1 for CP */

                                               soc21_grbm_select(adev, adev=
->gfx.me.num_me + i, j, k, 0);

                                               for (reg =3D 0; reg < reg_co=
unt; reg++) {

-                                                           if (i && gc_cp_=
reg_list_11[reg].reg_offset =3D=3D regCP_MEC_ME1_HEADER_DUMP)

-                                                           adev->gfx.ip_du=
mp_compute_queues[index + reg] =3D

-                                                                       RRE=
G32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_ME2_HEADER_DUMP));

+                                                          if (i &&

+                                                              gc_cp_reg_li=
st_11[reg].reg_offset =3D=3D

+                                                                          =
regCP_MEC_ME1_HEADER_DUMP)

+                                                                      adev=
->gfx.ip_dump_compute_queues[index + reg] =3D

+                                                                          =
        RREG32(SOC15_REG_OFFSET(GC, 0,

+                                                                          =
        regCP_MEC_ME2_HEADER_DUMP));

                                                           else

                                                                       adev=
->gfx.ip_dump_compute_queues[index + reg] =3D

                                                                           =
        RREG32(SOC15_REG_ENTRY_OFFSET(

--

2.34.1



--_000_BL1PR12MB575362E1780D89A61C5324D79388ABL1PR12MB5753namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
/* Style Definitions */
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Arial",sans-serif;
	mso-ligatures:standardcontextual;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Arial",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><a id=3D"OWAAM0C8A7562085645E28C168F950354517D" h=
ref=3D"mailto:Arvind.Yadav@amd.com"><span style=3D"font-family:&quot;Arial&=
quot;,sans-serif;text-decoration:none">@Yadav, Arvind</span></a><o:p></o:p>=
</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Sunil Khatri &lt;sunil.khatri@amd.com&gt; <br>
Sent: Wednesday, May 7, 2025 3:00 PM<br>
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander &lt;Alexander.Deucher=
@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
Cc: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;; Khatri, Sunil &lt;Sunil=
.Khatri@amd.com&gt;<br>
Subject: [PATCH v2] drm/amdgpu: fix the indentation</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">fix the indentation<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:6992 gfx_v=
11_ip_dump<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">compiler: gcc-11 (Debian 11.3.0-12) 11.3.0<o:p></=
o:p></p>
<p class=3D"MsoPlainText">| Reported-by: kernel test robot &lt;<a href=3D"m=
ailto:lkp@intel.com"><span style=3D"color:windowtext;text-decoration:none">=
lkp@intel.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">| Reported-by: Dan Carpenter &lt;<a href=3D"mailt=
o:dan.carpenter@linaro.org"><span style=3D"color:windowtext;text-decoration=
:none">dan.carpenter@linaro.org</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">| Closes: <a href=3D"https://lore.kernel.org/r/20=
2505071619.7sHTLpNg-lkp@intel.com/">
<span style=3D"color:windowtext;text-decoration:none">https://lore.kernel.o=
rg/r/202505071619.7sHTLpNg-lkp@intel.com/</span></a><o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Sunil Khatri &lt;<a href=3D"mailto=
:sunil.khatri@amd.com"><span style=3D"color:windowtext;text-decoration:none=
">sunil.khatri@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++=
---<o:p></o:p></p>
<p class=3D"MsoPlainText">1 file changed, 6 insertions(+), 3 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0=
.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 3f4ee4b3b0a4..fe21393e155d 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">@@ -7094,9 +7094,12 @@ static void gfx_v11_ip_dum=
p(struct amdgpu_ip_block *ip_block)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* ME0 is for GFX so start from 1 for CP */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; soc21_grbm_select(adev, adev-&gt;gfx.me.num_me + i, j, k, 0);<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; for (reg =3D 0; reg &lt; reg_count; reg++) {<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (i &amp;&amp; gc_cp_reg_list_11[reg].reg_offset =3D=3D regCP_MEC_ME1_HE=
ADER_DUMP)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 adev-&gt;gfx.ip_dump_compute_queues[index + reg] =3D<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RR=
EG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_ME2_HEADER_DUMP));<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i=
 &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; gc_cp_reg_list_11[reg].reg_offset =3D=3D<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; regCP_MEC_ME1_HEADER_DUMP)<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;gfx.ip_dump_compute_queues[index + reg] =3D<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32(SOC15_REG=
_OFFSET(GC, 0,<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regCP_MEC_ME2_HE=
ADER_DUMP));<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ade=
v-&gt;gfx.ip_dump_compute_queues[index + reg] =3D<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32(SOC1=
5_REG_ENTRY_OFFSET(<o:p></o:p></p>
<p class=3D"MsoPlainText">-- <o:p></o:p></p>
<p class=3D"MsoPlainText">2.34.1<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB575362E1780D89A61C5324D79388ABL1PR12MB5753namp_--
