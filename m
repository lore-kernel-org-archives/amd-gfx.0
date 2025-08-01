Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B08EC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 18:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055A210E8E7;
	Fri,  1 Aug 2025 18:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="szgiXiQd";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C48810E8E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 18:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzUb8cZ8nxXRhSnCKFWaPdNpfrpNZustzk29McIyV0zXcnGohi3KPH7mGYFLthmj9jh/Who/xKdZg+lWTD1VcH8M4KwaApcWpGWTNCHisLPetCpU7+nNEaxCsasKZeFKlTCAj+GRz6yViycQu7hycWkkt2xpMZyRiMPclwUMu7xX4TSAz5VMtihbSyq4I3GAAO8TaztnPTiCkuoAwN2xA97+sx3pQiRZabJZoZUQhekf+IpUuDbNSHvc+2XSVXe4vB74xKwnXPGHVlcK+l6ly+zXyJ05SB4yZT4RZPpMfq90s+e+UI+nX6efmBxOptJqQCPO8O5Vz4WpnpksgVspDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIEc5ZNxpTwWHsrOsIEc+pdCEdQ24RyKfh/SQMTG1mg=;
 b=tloV4nZCvtpMMsMQ/urLOpoDDZDq7EgntkhMIYfi/P5KdIFCc4IyKfpMk3MM8G4zwzSUg2vYB3ixMeYPtXcaeyJQC88wHS4oy7htuPD17A1S16IFbnhJCpK2KK10BM7yHYUWx7RGAn8p6BQ6NRjoyxyurGBv5ML0Lv3q1Kq86PqhzT5V4KgdfThC/AL+iXw8YmtWvcxbCLEAB0VRz5jJEMUUpsaf9ac6ZwAgue04oAtANLVsCkmeYwMJbU1DqDJqJ8eH654uWeF9QLDP9GvePZGJVZvzj2r8k/pHhtq5TeasKHoBhPF52rmNvcYNIRW2Jl80lMMnNBW1Y/3ttNzeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIEc5ZNxpTwWHsrOsIEc+pdCEdQ24RyKfh/SQMTG1mg=;
 b=szgiXiQdIpPVC58dXtgWN3SJYnf6nUKzoDFg6K+pXgWUigomunFqSMSAlADzpMHIAzxyVulfXIyy/PPrUui7taFsVxz90X3XX4xz+S5I2yUCFEL2XFuq16gIeWApwXiuoThG0TJcMpx85e7ImOXu0ht8wPcu0bqR3D0zyLveyu8=
Received: from BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 18:36:09 +0000
Received: from BL1PR12MB5192.namprd12.prod.outlook.com
 ([fe80::1827:386f:7b23:dca3]) by BL1PR12MB5192.namprd12.prod.outlook.com
 ([fe80::1827:386f:7b23:dca3%6]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 18:36:09 +0000
From: "Liu, Wenjing" <Wenjing.Liu@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lei,
 Jun" <Jun.Lei@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Strauss, 
 Michael" <Michael.Strauss@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: Re: [PATCH] drm/amd/display: Move 'audio descriptor' storage from
 'stream resource' to 'dc scratch'
Thread-Topic: [PATCH] drm/amd/display: Move 'audio descriptor' storage from
 'stream resource' to 'dc scratch'
Thread-Index: AQHcAt2oOsxdtmMDWUypVr011KV98LROIIfK
Date: Fri, 1 Aug 2025 18:36:09 +0000
Message-ID: <BL1PR12MB5192EAD1FF9F066E0E6D5C87F526A@BL1PR12MB5192.namprd12.prod.outlook.com>
References: <20250801121247.3469007-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250801121247.3469007-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-01T18:36:08.6800000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5192:EE_|SJ2PR12MB8033:EE_
x-ms-office365-filtering-correlation-id: 48f9f4b9-d487-4767-3684-08ddd12a488a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EO9jn7n4J6BaTfXc3apBnQ4QKO+cERvXi52atdaHWtZ3XVyj/pFw0vbXYc?=
 =?iso-8859-1?Q?RRz0+FjHIv5CmX6xcLQtdjr8I98r3zKqj6/+NqCua6/PkxHi1++nTBspK8?=
 =?iso-8859-1?Q?UA5XUR7fd17o9f8PW4DSL7tIFcfhsx+/AO9ELR4Dp7cR6IMLwHecKYggk2?=
 =?iso-8859-1?Q?B3xry8sUPj8WZJipjzTsGG3Tupakk6oF00Iiu0nMQzPqN0B+tHvDPgJ6uQ?=
 =?iso-8859-1?Q?R7zr8J6Whvlps4ARArMyPdoucrN2fCYEUWWN+aFJMWtZ/hfDz9siPPL2vN?=
 =?iso-8859-1?Q?WGDqPHABfc2NttxXJOAMbzVBq/DhDAYNhZu66Z+S/in/y14hnihua4mESf?=
 =?iso-8859-1?Q?K2rsfxFSgpEwGI9R9h5FE+g7Z5FsMeXwFIcIeFESE0pbn4Q3/b1lpJ2/81?=
 =?iso-8859-1?Q?OaVWNkrPriX4Gl2NdrD7UdsGKpv/8fNOidrwTidom+/f6+GgNo0N5s/5xs?=
 =?iso-8859-1?Q?/MIIzCDoKpdl0Jc0BZovC71wRy5pgxxKwhHbtjRT+2INFLwPn/dIxlFElH?=
 =?iso-8859-1?Q?Qrjv/AInZjlNa4Z44xhFCuBPaxA+HymejcaGOxxYurSza5KbnhoE4mqsXF?=
 =?iso-8859-1?Q?UKYIi+a+jfWF9vY4fW+aLCRXrNwt0CutwyrKv78gTYf+F8ZD671UPedwOr?=
 =?iso-8859-1?Q?Of0pxyg3jBtqUaQmZAGVKDiDjBeCr5Yk4IzhUyb2twZxvXvB93mCBvE7sK?=
 =?iso-8859-1?Q?TTRkVO1OpbiFrFPZMWFLyseLQ6ey/q6m4o0YWOr7o1c4t2yz6JoZiuf3gb?=
 =?iso-8859-1?Q?OYPlPIIRyjqJT97HisKyBkpaHbnmTqAwrzaW2v9lW4v1ybTzuVCdGxwn4J?=
 =?iso-8859-1?Q?7Blie6Phj8c27AKlCy8zLK6LDB2GDaxTzBUOSKhCQtFuQ30+CPGxrsLQQz?=
 =?iso-8859-1?Q?sAMKWO3K+lpmsNujXOfKI9E3YHeSOzZaUIcUqUDi/juOVFR28hqxP1Mu70?=
 =?iso-8859-1?Q?OGLGQsrb1PEoWR5ifrp3lIbGIkVsdxYkc1ApG4apwNfvKmST22d10rxYz1?=
 =?iso-8859-1?Q?7JewysnaHXQixrY2F/xSa94qR9q95vMngY2KJ8OqRJhx0eRuMzGllDU+EA?=
 =?iso-8859-1?Q?waKgLs5ROIh//hqQ4QBO/8Z3rx0I43yyrudHpEbDTlo4n7/6hx4XRk5Z0r?=
 =?iso-8859-1?Q?rKqwDPp2sQV2U8I0kLCr+w3db/VoLkDaZqcbcSSMPCEjUJTSCFg+w/YF0a?=
 =?iso-8859-1?Q?Da03dFjwQ6QsQhKHxlWQ1Uiy3xTCXsFr9oV6grL5/xRovHxaTDpslvWdtz?=
 =?iso-8859-1?Q?3+3BtEVhev150yp7mXzlftLvL3cZN0fzJ4RbCVFTklGpGa+imZ0HYGuNjm?=
 =?iso-8859-1?Q?gZ9HvNM+zkjAVdfmVIXAankhTMv5vNIijihH6ez/Vp17i0JbqKiJHumAeb?=
 =?iso-8859-1?Q?yHxDk+IBYliV96VJPMTGp+MjFVgVD05w4yJffin/UEbGLWno2HIfuFNhqs?=
 =?iso-8859-1?Q?w5+ZpmmfCI2rsI06fYPMf3WrvZCVGIlccVw9RUFq3S6V8nuc27pEWIbpBE?=
 =?iso-8859-1?Q?Qk+oNFzDcFDjiHUhuB9paDf281PNaIqWSIE8GTLpLd/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EK9xpBhTeeXfuOZsYoECtYVwZO3JYqJ3DnAYMJDkEBiHQUtMSrAoFuQ5g7?=
 =?iso-8859-1?Q?UfygItprLShDo9GkX5934vRRn39oH8+QY6ZU/Z4dbz4K4C2XR9VY3RSczO?=
 =?iso-8859-1?Q?dmHnn5yQCijW71Fb3ga5giz9KFEaWkmOqM4/UOBoMg2wrZIKJBJVphY6KN?=
 =?iso-8859-1?Q?eSFAPLjNxAtT2d/fSiLLoAb3Aa7wH3ELZFtxuwddx0QQwehVZvOTRzKMhj?=
 =?iso-8859-1?Q?FwkBdyxUZScDzCeNnrl8S7oKVCmRozIhmohzcCXuVJrE4AqA1Z5Bs38o/g?=
 =?iso-8859-1?Q?LVKeQErpwf9AWmvSzzC9NrDgi+fyeF3nw4+4OFg46UJ3Hk4qqQzgnabm0E?=
 =?iso-8859-1?Q?BV6rhkHN+7Yt7a9bt6CrAI88ovXW3xoIpu7iruVkZgLBASDmV13j01hSZZ?=
 =?iso-8859-1?Q?cLs5WTLcGI6o7cKRjXg87L6vO7ESRY6G7pFmJQMZW1WwaKORsIXYIgboSS?=
 =?iso-8859-1?Q?+Ggeq1rO7SR10dhNKJFOQuoNFlIvuMR7S56XK5nmJBo4+gicok0bGTX7TB?=
 =?iso-8859-1?Q?Vxl/HEMwFKsZRcYQJtQZio7zClMI53eYo9t7X1Rz5hHT3Sy0+VgNBwT80Z?=
 =?iso-8859-1?Q?9pjXNGGTnwV908NEZWVwFPlGMad0SbSOqwBlqaRomNNU2ryXHwohnME5gv?=
 =?iso-8859-1?Q?sstji2H5E7IH5Y4W21EnZndJ4f1bC4BhIYUuFVq53chouuR+fWFVehuc6p?=
 =?iso-8859-1?Q?7SXutwL0Px9KdDaoPvvJD3daL+KtQtEGPUvUhQFuNh6CQECjLZ0UiVP0gV?=
 =?iso-8859-1?Q?WbXsNb0QJ3yQsa+H82DjV+iUhxJXZqc4GO2hJok8smR8Cp3L6RZTOYgCgM?=
 =?iso-8859-1?Q?z09FKcF05L2RNr/FSnA24xhb0wL3OnmQGxEplHIE2YAhAR8QQU9MJ4ownb?=
 =?iso-8859-1?Q?Uv0ev8rWUwsPVLoUkQWPS29frOy1zEpdGmn/xWmbX9W0AtvkhJglv/Qfua?=
 =?iso-8859-1?Q?O9pIUK/hOx2FCC0ZIfOePqqvqVSKZCSmeNoJ0JY5Q9E8iLVcSHfUhGSUGB?=
 =?iso-8859-1?Q?pyLuV731LTtnWstH3lbAgLpgR6k8TMLa4dR/1+aiYmUEwgollDdF7H5QLh?=
 =?iso-8859-1?Q?T1aHDxOajMas0oKYzyYp95LRxZpS46kT7aIwsIMF59Zj0U3vdTtjtVFulx?=
 =?iso-8859-1?Q?IH77PQbQ6ABA5j+Rp9B0mf/7DT2Rwd8oUA/nJ2Dm8DB9gGbVH3mH5APGVW?=
 =?iso-8859-1?Q?jDcvXa0oK7CTOCkAyrgxUsvmZ14muUJjKGNFOXITh5iqsVWn2jNQh7eDH0?=
 =?iso-8859-1?Q?Laynl62tq4M8nWjIV5jXnRE/FwsS0Kxrk2fOj00aQXN8XpSPLDCK8dOjgO?=
 =?iso-8859-1?Q?YmCHm+0QU0PuFNcusW/SJiTTbg4o7zlUDjDrQwxlmUGEmR7wyeg7/oky1f?=
 =?iso-8859-1?Q?9JvAtFyIa9WfkvOYI1JP0lqZY/6EFAdAD69p8X+henFG87cflE84Jnpri3?=
 =?iso-8859-1?Q?X9oszEg+grDIUySqG2pQau2VmB4BK5NoaDvsS5O4breR4Z3tbA/wJmPnfB?=
 =?iso-8859-1?Q?/zAV30MyWkz8rNbEXfsPaKQvI/sJImpQrqPNB6RcpJI/Dm/gnPpj6u6f1i?=
 =?iso-8859-1?Q?DoEYwh2ydy3923c47KrLp17c2Pxsc4Kn6R6nGAEiHsIeZF7wS4L1kX+ISE?=
 =?iso-8859-1?Q?LPzXWUpaDlXtA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5192EAD1FF9F066E0E6D5C87F526ABL1PR12MB5192namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f9f4b9-d487-4767-3684-08ddd12a488a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 18:36:09.1782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBrUf+qTvt3qyJjmbJSfnCXjtrxmRTYg9eMmBreW19LKbhiRlDYvoKSlWQLrMGM0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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

--_000_BL1PR12MB5192EAD1FF9F066E0E6D5C87F526ABL1PR12MB5192namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>

________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Friday, August 01, 2025 8:12 AM
To: Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd=
.com>; Lei, Jun <Jun.Lei@amd.com>; Liu, Wenjing <Wenjing.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Strauss, Michael <Michael.Str=
auss@amd.com>; Lee, Alvin <Alvin.Lee2@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@a=
md.com>
Subject: [PATCH] drm/amd/display: Move 'audio descriptor' storage from 'str=
eam resource' to 'dc scratch'

The `stream_resource` structure holds hardware parts and resources that
stay active as long as the display stream or pipe is running. It
represents the hardware state.

The `audio_output` structure is temporary. It is built and used only
during operations like dc validation and link retraining. It does not
represent permanent hardware resources.

This patch moves the audio_output descriptor from stream_res to
dc_scratch_space. This keeps temporary data separate from permanent
hardware state

'Fixes: 571662266db3 ("drm/amd/display: Reduce Stack Usage by moving
'audio_output' into 'stream_res' v4")'
Cc: Michael Strauss <michael.strauss@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Suggested-by: Jun Lei <Jun.Lei@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 30 +++++++++++--------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 ++--
 .../display/dc/link/accessories/link_dp_cts.c | 13 +++++---
 .../dc/resource/dcn31/dcn31_resource.c        |  5 ++--
 .../dc/resource/dcn31/dcn31_resource.h        |  3 +-
 6 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index 5653c1673aec..c6bfde9d3e98 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,6 +47,7 @@
 #include "dmub/inc/dmub_cmd.h"

 #include "sspl/dc_spl_types.h"
+#include "audio_types.h"

 struct abm_save_restore;

@@ -1734,6 +1735,8 @@ struct dc {
                 struct dc_stream_state temp_stream; // Used so we don't ne=
ed to allocate stream on the stack
                 struct dc_link temp_link;
                 bool pipes_to_unlock_first[MAX_PIPES]; /* Any of the pipes=
 indicated here should be unlocked first */
+               /* Pre-allocated buffer for audio_output used in dp_retrain=
_link_dp_test() */
+               struct audio_output audio_output[MAX_PIPES];
         } scratch;

         struct dml2_configuration_options dml2_options;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 153d68375fa3..49ad34734cef 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1586,6 +1586,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_=
hw(
                 struct dc_state *context,
                 struct dc *dc)
 {
+       struct audio_output *audio_output;
         struct dc_stream_state *stream =3D pipe_ctx->stream;
         struct dc_link *link =3D stream->link;
         struct drr_params params =3D {0};
@@ -1595,23 +1596,23 @@ enum dc_status dce110_apply_single_controller_ctx_t=
o_hw(
         const struct link_hwss *link_hwss =3D get_link_hwss(
                         link, &pipe_ctx->link_res);

-
         if (hws->funcs.disable_stream_gating) {
                 hws->funcs.disable_stream_gating(dc, pipe_ctx);
         }

         if (pipe_ctx->stream_res.audio !=3D NULL) {
-               build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res=
.audio_output);
+               audio_output =3D &dc->scratch.audio_output[pipe_ctx->pipe_i=
dx];
+               build_audio_output(context, pipe_ctx, audio_output);

-               link_hwss->setup_audio_output(pipe_ctx, &pipe_ctx->stream_r=
es.audio_output,
+               link_hwss->setup_audio_output(pipe_ctx, audio_output,
                                 pipe_ctx->stream_res.audio->inst);

                 pipe_ctx->stream_res.audio->funcs->az_configure(
                                 pipe_ctx->stream_res.audio,
                                 pipe_ctx->stream->signal,
-                               &pipe_ctx->stream_res.audio_output.crtc_inf=
o,
+                               &audio_output->crtc_info,
                                 &pipe_ctx->stream->audio_info,
-                               &pipe_ctx->stream_res.audio_output.dp_link_=
info);
+                               &audio_output->dp_link_info);

                 if (dc->config.disable_hbr_audio_dp2)
                         if (pipe_ctx->stream_res.audio->funcs->az_disable_=
hbr_audio &&
@@ -2354,6 +2355,7 @@ static void dce110_setup_audio_dto(
                 struct dc_state *context)
 {
         unsigned int i;
+       struct audio_output *audio_output;

         /* program audio wall clock. use HDMI as clock source if HDMI
          * audio active. Otherwise, use DP as clock source
@@ -2385,7 +2387,8 @@ static void dce110_setup_audio_dto(
                 if (pipe_ctx->stream->signal !=3D SIGNAL_TYPE_HDMI_TYPE_A)
                         continue;
                 if (pipe_ctx->stream_res.audio !=3D NULL) {
-                       build_audio_output(context, pipe_ctx, &pipe_ctx->st=
ream_res.audio_output);
+                       audio_output =3D &dc->scratch.audio_output[i];
+                       build_audio_output(context, pipe_ctx, audio_output)=
;

                         if (dc->res_pool->dccg && dc->res_pool->dccg->func=
s->set_audio_dtbclk_dto) {
                                 struct dtbclk_dto_params dto_params =3D {0=
};
@@ -2396,14 +2399,14 @@ static void dce110_setup_audio_dto(
                                 pipe_ctx->stream_res.audio->funcs->wall_dt=
o_setup(
                                                 pipe_ctx->stream_res.audio=
,
                                                 pipe_ctx->stream->signal,
-                                               &pipe_ctx->stream_res.audio=
_output.crtc_info,
-                                               &pipe_ctx->stream_res.audio=
_output.pll_info);
+                                               &audio_output->crtc_info,
+                                               &audio_output->pll_info);
                         } else
                                 pipe_ctx->stream_res.audio->funcs->wall_dt=
o_setup(
                                         pipe_ctx->stream_res.audio,
                                         pipe_ctx->stream->signal,
-                                       &pipe_ctx->stream_res.audio_output.=
crtc_info,
-                                       &pipe_ctx->stream_res.audio_output.=
pll_info);
+                                       &audio_output->crtc_info,
+                                       &audio_output->pll_info);
                         break;
                 }
         }
@@ -2423,15 +2426,16 @@ static void dce110_setup_audio_dto(
                                 continue;

                         if (pipe_ctx->stream_res.audio !=3D NULL) {
+                               audio_output =3D &dc->scratch.audio_output[=
i];
                                 build_audio_output(context,
                                                    pipe_ctx,
-                                                  &pipe_ctx->stream_res.au=
dio_output);
+                                                  audio_output);

                                 pipe_ctx->stream_res.audio->funcs->wall_dt=
o_setup(
                                         pipe_ctx->stream_res.audio,
                                         pipe_ctx->stream->signal,
-                                       &pipe_ctx->stream_res.audio_output.=
crtc_info,
-                                       &pipe_ctx->stream_res.audio_output.=
pll_info);
+                                       &audio_output->crtc_info,
+                                       &audio_output->pll_info);
                                 break;
                         }
                 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/=
drm/amd/display/dc/inc/core_types.h
index 4387de044469..df0d72b2c1b0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -228,7 +228,8 @@ struct resource_funcs {
         enum dc_status (*update_dc_state_for_encoder_switch)(struct dc_lin=
k *link,
                 struct dc_link_settings *link_setting,
                 uint8_t pipe_count,
-               struct pipe_ctx *pipes);
+               struct pipe_ctx *pipes,
+               struct audio_output *audio_output);
 };

 struct audio_support{
@@ -360,8 +361,6 @@ struct stream_resource {
         uint8_t gsl_group;

         struct test_pattern_params test_pattern_params;
-
-       struct audio_output audio_output;
 };

 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c =
b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 23f41c99fa38..4af5fde2e392 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -35,6 +35,7 @@
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
 #include "clk_mgr.h"
+#include "dc.h"

 #define DC_LOGGER \
         link->ctx->logger
@@ -66,6 +67,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
                         struct dc_link_settings *link_setting,
                         bool skip_video_pattern)
 {
+       struct dc *dc =3D (struct dc *)(unsigned long)link->dc;
         struct pipe_ctx *pipes[MAX_PIPES];
         struct dc_state *state =3D link->dc->current_state;
         struct dc_stream_update stream_update =3D { 0 };
@@ -79,6 +81,9 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
         struct dc_stream_state *streams_on_link[MAX_PIPES];
         int num_streams_on_link =3D 0;

+       /* Zero out the scratch audio output array */
+       memset((void *)dc->scratch.audio_output, 0, sizeof(dc->scratch.audi=
o_output));
+
         needs_divider_update =3D (link->dc->link_srv->dp_get_encoding_form=
at(link_setting) !=3D
         link->dc->link_srv->dp_get_encoding_format((const struct dc_link_s=
ettings *) &link->cur_link_settings));

@@ -101,7 +106,7 @@ static void dp_retrain_link_dp_test(struct dc_link *lin=
k,
         if (needs_divider_update && link->dc->res_pool->funcs->update_dc_s=
tate_for_encoder_switch) {
                 link->dc->res_pool->funcs->update_dc_state_for_encoder_swi=
tch(link,
                                 link_setting, count,
-                               *pipes);
+                               *pipes, dc->scratch.audio_output);
                 for (i =3D 0; i < count; i++) {
                         pipes[i]->clock_source->funcs->program_pix_clk(
                                         pipes[i]->clock_source,
@@ -114,15 +119,15 @@ static void dp_retrain_link_dp_test(struct dc_link *l=
ink,
                                         link, &pipes[i]->link_res);

                                 link_hwss->setup_audio_output(pipes[i],
-                                                             &pipes[i]->st=
ream_res.audio_output,
+                                                             &dc->scratch.=
audio_output[i],
                                                               pipes[i]->st=
ream_res.audio->inst);

                                 pipes[i]->stream_res.audio->funcs->az_conf=
igure(
                                                 pipes[i]->stream_res.audio=
,
                                                 pipes[i]->stream->signal,
-                                               &pipes[i]->stream_res.audio=
_output.crtc_info,
+                                               &dc->scratch.audio_output[i=
].crtc_info,
                                                 &pipes[i]->stream->audio_i=
nfo,
-                                               &pipes[i]->stream_res.audio=
_output.dp_link_info);
+                                               &dc->scratch.audio_output[i=
].dp_link_info);

                                 if (link->dc->config.disable_hbr_audio_dp2=
 &&
                                                 pipes[i]->stream_res.audio=
->funcs->az_disable_hbr_audio &&
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index ca17e5d8fdc2..3ed7f50554e2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2239,7 +2239,8 @@ struct resource_pool *dcn31_create_resource_pool(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *li=
nk,
         struct dc_link_settings *link_setting,
         uint8_t pipe_count,
-       struct pipe_ctx *pipes)
+       struct pipe_ctx *pipes,
+       struct audio_output *audio_output)
 {
         struct dc_state *state =3D link->dc->current_state;
         int i;
@@ -2254,7 +2255,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_swit=
ch(struct dc_link *link,

                 // Setup audio
                 if (pipes[i].stream_res.audio !=3D NULL)
-                       build_audio_output(state, &pipes[i], &pipes[i].stre=
am_res.audio_output);
+                       build_audio_output(state, &pipes[i], &audio_output[=
i]);
         }
 #else
         /* This DCN requires rate divider updates and audio reprogramming =
to allow DP1<-->DP2 link rate switching,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index 7e8fde65528f..c32c85ef0ba4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -69,7 +69,8 @@ unsigned int dcn31_get_det_buffer_size(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *li=
nk,
         struct dc_link_settings *link_setting,
         uint8_t pipe_count,
-       struct pipe_ctx *pipes);
+       struct pipe_ctx *pipes,
+       struct audio_output *audio_output);

 /*temp: B0 specific before switch to dcn313 headers*/
 #ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
--
2.34.1


--_000_BL1PR12MB5192EAD1FF9F066E0E6D5C87F526ABL1PR12MB5192namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Wenjing Liu &lt;wenjing.liu@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt=
;<br>
<b>Sent:</b>&nbsp;Friday, August 01, 2025 8:12 AM<br>
<b>To:</b>&nbsp;Hung, Alex &lt;Alex.Hung@amd.com&gt;; Pillai, Aurabindo &lt=
;Aurabindo.Pillai@amd.com&gt;; Lei, Jun &lt;Jun.Lei@amd.com&gt;; Liu, Wenji=
ng &lt;Wenjing.Liu@amd.com&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Strau=
ss, Michael &lt;Michael.Strauss@amd.com&gt;; Lee, Alvin &lt;Alvin.Lee2@amd.=
com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amd/display: Move 'audio descriptor' stora=
ge from 'stream resource' to 'dc scratch'
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The `stream_resource` structure holds hardw=
are parts and resources that<br>
stay active as long as the display stream or pipe is running. It<br>
represents the hardware state.<br>
<br>
The `audio_output` structure is temporary. It is built and used only<br>
during operations like dc validation and link retraining. It does not<br>
represent permanent hardware resources.<br>
<br>
This patch moves the audio_output descriptor from stream_res to<br>
dc_scratch_space. This keeps temporary data separate from permanent<br>
hardware state<br>
<br>
'Fixes: 571662266db3 (&quot;drm/amd/display: Reduce Stack Usage by moving<b=
r>
'audio_output' into 'stream_res' v4&quot;)'<br>
Cc: Michael Strauss &lt;michael.strauss@amd.com&gt;<br>
Cc: Alvin Lee &lt;Alvin.Lee2@amd.com&gt;<br>
Cc: Jun Lei &lt;Jun.Lei@amd.com&gt;<br>
Cc: Wenjing Liu &lt;wenjing.liu@amd.com&gt;<br>
Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
Cc: Ivan Lipski &lt;ivan.lipski@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Suggested-by: Jun Lei &lt;Jun.Lei@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++<br>
&nbsp;.../amd/display/dc/hwss/dce110/dce110_hwseq.c | 30 +++++++++++-------=
-<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/core_types.h&nbsp;&nbsp; |&nbsp; 5 ++-=
-<br>
&nbsp;.../display/dc/link/accessories/link_dp_cts.c | 13 +++++---<br>
&nbsp;.../dc/resource/dcn31/dcn31_resource.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 5 ++--<br>
&nbsp;.../dc/resource/dcn31/dcn31_resource.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 3 +-<br>
&nbsp;6 files changed, 36 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h<br>
index 5653c1673aec..c6bfde9d3e98 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
@@ -47,6 +47,7 @@<br>
&nbsp;#include &quot;dmub/inc/dmub_cmd.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;sspl/dc_spl_types.h&quot;<br>
+#include &quot;audio_types.h&quot;<br>
&nbsp;<br>
&nbsp;struct abm_save_restore;<br>
&nbsp;<br>
@@ -1734,6 +1735,8 @@ struct dc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_stream_state temp_stream; // Used so we don=
't need to allocate stream on the stack<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_link temp_link;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bool pipes_to_unlock_first[MAX_PIPES]; /* Any of the =
pipes indicated here should be unlocked first */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Pre-allocated buffer for audio_output used in dp_retrain_link=
_dp_test() */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct audio_output audio_output[MAX_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } scratch;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_=
options dml2_options;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
index 153d68375fa3..49ad34734cef 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
@@ -1586,6 +1586,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_=
hw(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_state *context,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc *dc)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output *audio_output;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_state *st=
ream =3D pipe_ctx-&gt;stream;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *link =3D s=
tream-&gt;link;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drr_params params =
=3D {0};<br>
@@ -1595,23 +1596,23 @@ enum dc_status dce110_apply_single_controller_ctx_t=
o_hw(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct link_hwss *li=
nk_hwss =3D get_link_hwss(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link,=
 &amp;pipe_ctx-&gt;link_res);<br>
&nbsp;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hws-&gt;funcs.disable_=
stream_gating) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hws-&gt;funcs.disable_stream_gating(dc, pipe_ctx);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream_re=
s.audio !=3D NULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; build_audio_output(context, pipe_ctx, &amp;pipe_ctx-&gt;stream_r=
es.audio_output);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; audio_output =3D &amp;dc-&gt;scratch.audio_output[pipe_ctx-&gt;p=
ipe_idx];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; build_audio_output(context, pipe_ctx, audio_output);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_hwss-&gt;setup_audio_output(pipe_ctx, &amp;pipe_ctx-&gt;str=
eam_res.audio_output,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_hwss-&gt;setup_audio_output(pipe_ctx, audio_output,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&g=
t;inst);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&gt;funcs-&gt;az_config=
ure(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;signal,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stream_res.audio_output.c=
rtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output-&gt;crtc_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stream-&gt;aud=
io_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stream_res.audio_output.d=
p_link_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output-&gt;dp_link_info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dc-&gt;config.disable_hbr_audio_dp2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p=
ipe_ctx-&gt;stream_res.audio-&gt;funcs-&gt;az_disable_hbr_audio &amp;&amp;<=
br>
@@ -2354,6 +2355,7 @@ static void dce110_setup_audio_dto(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_state *context)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output *audio_output;<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* program audio wall cloc=
k. use HDMI as clock source if HDMI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * audio active. Othe=
rwise, use DP as clock source<br>
@@ -2385,7 +2387,8 @@ static void dce110_setup_audio_dto(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream-&gt;signal !=3D SIGNAL_TYPE_H=
DMI_TYPE_A)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream_res.audio !=3D NULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_outp=
ut(context, pipe_ctx, &amp;pipe_ctx-&gt;stream_res.audio_output);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; audio_output =3D=
 &amp;dc-&gt;scratch.audio_output[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_outp=
ut(context, pipe_ctx, audio_output);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (d=
c-&gt;res_pool-&gt;dccg &amp;&amp; dc-&gt;res_pool-&gt;dccg-&gt;funcs-&gt;s=
et_audio_dtbclk_dto) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dtbclk_dto_params dto_par=
ams =3D {0};<br>
@@ -2396,14 +2399,14 @@ static void dce110_setup_audio_dto(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&g=
t;funcs-&gt;wall_dto_setup(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&g=
t;stream_res.audio,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&g=
t;stream-&gt;signal,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stre=
am_res.audio_output.crtc_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_ctx-&gt;stre=
am_res.audio_output.pll_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output-&gt;=
crtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_output-&gt;=
pll_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&g=
t;funcs-&gt;wall_dto_setup(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;signal,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;pipe_ctx-&gt;stream_res.audio_output.crtc_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;pipe_ctx-&gt;stream_res.audio_output.pll_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;audio_output-&gt;crtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;audio_output-&gt;pll_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2423,15 +2426,16 @@ static void dce110_setup_audio_dto(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p=
ipe_ctx-&gt;stream_res.audio !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; audio_output =3D &amp;dc-&gt;scratch.audio_=
output[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_output(context,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; pipe_ctx,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp=
;pipe_ctx-&gt;stream_res.audio_output);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; audi=
o_output);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio-&g=
t;funcs-&gt;wall_dto_setup(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.audio,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;signal,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;pipe_ctx-&gt;stream_res.audio_output.crtc_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;pipe_ctx-&gt;stream_res.audio_output.pll_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;audio_output-&gt;crtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;audio_output-&gt;pll_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/=
drm/amd/display/dc/inc/core_types.h<br>
index 4387de044469..df0d72b2c1b0 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h<br>
@@ -228,7 +228,8 @@ struct resource_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_status (*update_dc=
_state_for_encoder_switch)(struct dc_link *link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_link_settings *link_setting,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint8_t pipe_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pipe_ctx *pipes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pipe_ctx *pipes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct audio_output *audio_output);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct audio_support{<br>
@@ -360,8 +361,6 @@ struct stream_resource {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t gsl_group;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct test_pattern_params=
 test_pattern_params;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output audio_output;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct plane_resource {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c =
b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c<br>
index 23f41c99fa38..4af5fde2e392 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c<br>
@@ -35,6 +35,7 @@<br>
&nbsp;#include &quot;dc_dmub_srv.h&quot;<br>
&nbsp;#include &quot;dce/dmub_hw_lock_mgr.h&quot;<br>
&nbsp;#include &quot;clk_mgr.h&quot;<br>
+#include &quot;dc.h&quot;<br>
&nbsp;<br>
&nbsp;#define DC_LOGGER \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link-&gt;ctx-&gt;logger<br=
>
@@ -66,6 +67,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t dc_link_settings *link_setting,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool =
skip_video_pattern)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc *dc =3D (struct dc *)(unsig=
ned long)link-&gt;dc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes[MAX=
_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *state =3D=
 link-&gt;dc-&gt;current_state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_update st=
ream_update =3D { 0 };<br>
@@ -79,6 +81,9 @@ static void dp_retrain_link_dp_test(struct dc_link *link,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_state *st=
reams_on_link[MAX_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_streams_on_link =
=3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Zero out the scratch audio output =
array */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset((void *)dc-&gt;scratch.audio_o=
utput, 0, sizeof(dc-&gt;scratch.audio_output));<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; needs_divider_update =3D (=
link-&gt;dc-&gt;link_srv-&gt;dp_get_encoding_format(link_setting) !=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link-&gt;dc-&gt;link_srv-&=
gt;dp_get_encoding_format((const struct dc_link_settings *) &amp;link-&gt;c=
ur_link_settings));<br>
&nbsp;<br>
@@ -101,7 +106,7 @@ static void dp_retrain_link_dp_test(struct dc_link *lin=
k,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (needs_divider_update &=
amp;&amp; link-&gt;dc-&gt;res_pool-&gt;funcs-&gt;update_dc_state_for_encode=
r_switch) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; link-&gt;dc-&gt;res_pool-&gt;funcs-&gt;update_dc_stat=
e_for_encoder_switch(link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_setting, count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pipes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pipes, dc-&gt;scratch.audio_output);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; count; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes=
[i]-&gt;clock_source-&gt;funcs-&gt;program_pix_clk(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipes[i]-&gt;clock_source,<br>
@@ -114,15 +119,15 @@ static void dp_retrain_link_dp_test(struct dc_link *l=
ink,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; link, &amp;pipes[i]-&gt;link_res);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_hwss-&gt;setup_audio_output=
(pipes[i],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipes[i]=
-&gt;stream_res.audio_output,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dc-&gt;s=
cratch.audio_output[i],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi=
pes[i]-&gt;stream_res.audio-&gt;inst);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&gt;stream_res.audio-&g=
t;funcs-&gt;az_configure(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&g=
t;stream_res.audio,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&g=
t;stream-&gt;signal,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipes[i]-&gt;stre=
am_res.audio_output.crtc_info,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dc-&gt;scratch.au=
dio_output[i].crtc_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipes[=
i]-&gt;stream-&gt;audio_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipes[i]-&gt;stre=
am_res.audio_output.dp_link_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dc-&gt;scratch.au=
dio_output[i].dp_link_info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;dc-&gt;config.disab=
le_hbr_audio_dp2 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes[i]-&g=
t;stream_res.audio-&gt;funcs-&gt;az_disable_hbr_audio &amp;&amp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c<br>
index ca17e5d8fdc2..3ed7f50554e2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c<br>
@@ -2239,7 +2239,8 @@ struct resource_pool *dcn31_create_resource_pool(<br>
&nbsp;enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_lin=
k *link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link_settings *l=
ink_setting,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pipe_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output *audio_output)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *state =3D=
 link-&gt;dc-&gt;current_state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
@@ -2254,7 +2255,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_swit=
ch(struct dc_link *link,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; // Setup audio<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pipes[i].stream_res.audio !=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_outp=
ut(state, &amp;pipes[i], &amp;pipes[i].stream_res.audio_output);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_audio_outp=
ut(state, &amp;pipes[i], &amp;audio_output[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This DCN requires rate =
divider updates and audio reprogramming to allow DP1&lt;--&gt;DP2 link rate=
 switching,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h<br>
index 7e8fde65528f..c32c85ef0ba4 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h<br>
@@ -69,7 +69,8 @@ unsigned int dcn31_get_det_buffer_size(<br>
&nbsp;enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_lin=
k *link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link_settings *l=
ink_setting,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pipe_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct audio_output *audio_output);<b=
r>
&nbsp;<br>
&nbsp;/*temp: B0 specific before switch to dcn313 headers*/<br>
&nbsp;#ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5192EAD1FF9F066E0E6D5C87F526ABL1PR12MB5192namp_--
