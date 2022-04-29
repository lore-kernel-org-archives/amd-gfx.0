Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A93C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 01:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D7510EBCE;
	Fri, 29 Apr 2022 01:41:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EBF10EB8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 01:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSgFds0GK0dCoiOcP1ZtJwEue3i4aTq0mdrAyPxQ4J0RS1WNjEPrbNW1ai7w1GMUVajnjfBPWFPJE8C9BgOtUfHFboTNuVixeP+3QSaGVpfVQNvQ6iZIDP0uINpgpFuYRzYaE4YTvLsalKV9YNRcgS4UTNf71ryY79jI/TonEuKXTW+bRHQELkmEMHSriYmOtf7j3Hy1n2J4VhxkcF+Q/PWS98lDxUEpcR+OckGWodeJ30gGvgU7W6LMIV63zNinsgR3XXT1JDHxc4i1jj1zV1JisuB2xZ451xKuE9t7t+BOkETByvA+LRRQjroP8Dt9OCpQ64nX5XAe7fW/qse4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1739YHRNmDfqU+dKcRImq++lSLXxGNQZF2R2GcM353k=;
 b=WleYDIL8mBx8FkhKZeCsTCS37hrVLQgJbmp/Nu7IhVicS7Lajl4TU6pDtWn0CXqTPI2Z09/mQyuMZOxHYSIailP1NGUrb+S+6z4V0iPdW1zJCgPTkg4SXM4mpojBHbsHyuSabj5GGZokkWNW01TBD7xfDW0uHWpVlF+iDwqQU2bAG3v9VhAPuzhZKE8MYyeuyBBq7buZNLvwMaUbFZ+bzZiBOXk8eYwKdn1ffHeD6nXJdiCzNKbUf39v6kT3sgcdeohzBh/hv4l4vhv0O2NcbWbjiTu00zRa+E3qaSSIQF90KPVyjsDyUv/r7hemoaMIeJFXpf5ffOe1tUbyHj//Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1739YHRNmDfqU+dKcRImq++lSLXxGNQZF2R2GcM353k=;
 b=faluyV8n3NM3kLG+S0ljoN7Gpj8ItsFmM4HscqVz6VpCBAAQPyJSZxMCpJSlqf4AXeYWMVBe9WNYQNTnY+BzqPKPSZlwuBYuFpZJYTqN6OUS+SzhGymszDK22MXh5qv91OSEUSpbhRtkYkhVNWNvt26P0afwBiF6KZ847dRfmko=
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 01:41:35 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::68df:719a:6c7:96cc]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::68df:719a:6c7:96cc%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 01:41:35 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB
 firmware
Thread-Topic: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB
 firmware
Thread-Index: AQHYW00xlTl8dhrR1kinJN2ZG4pxl60GGzYL
Date: Fri, 29 Apr 2022 01:41:35 +0000
Message-ID: <DM4PR12MB5182C293BE9C6AF6E807A554ECFC9@DM4PR12MB5182.namprd12.prod.outlook.com>
References: <20220428221311.1030146-1-alexander.deucher@amd.com>
In-Reply-To: <20220428221311.1030146-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-29T01:41:31.894Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 1382fabb-a892-5c9a-7a92-e85da57c16be
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a824e529-e429-4a7c-e7fa-08da29816534
x-ms-traffictypediagnostic: MN2PR12MB4045:EE_
x-microsoft-antispam-prvs: <MN2PR12MB40457AB0CC50B2B2DDC52F38ECFC9@MN2PR12MB4045.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OV0tA7SSUxk7aE15y8ReinJnbMj0y0LvnO8vYmXWMiuxNIeasbaiF+yf1yQXrvyW7ZFcuM0tg6aW1FW5JaQF53zepFCboezYjuwDFIpdgQVa9/3YLRnmNVxU12u2jRsweLsbG8s0GWtSb9HAHY3o9KTgQYWhs2/5n5WkaBiz+PAoUD/cOeZW/L4Kv9ZxVID1uGpK8lIAnQg7bbfrjfKalxUe0sz/V6mi/6gWS7H3Cw557EnyQOznXuEYbUwxh9sFtVt4jbZCjXJzn8DDAGUAhs7UNrDn4qJDSDIKtmyI/noxBdLMea/zZopyK2F4rYLdYkhAxWu1WFZ4gb455GqAwqugBdLNkqNtPIvpN62u4xrLADc/4QzqfjdS9gL3PP1YAwT5A5hhF0srMPOxGnx+T9r2dm7uX0sfdHjdqp1i42ymxC7Cm/wtxiM0rBlVVun6vjglDpU2kE/c6ic8QgBMv/9w0vduY8SBlZ3D0eMLSp78i20ys0zJ4UaqC9zRYa74ePJ0UMBQX2QhhDvsTEgwElIeIHS8H/5AIfYGfs869CXlmFyhmbY4QNYXJMcdRXsxKD5BwJQQA3NHnTlxWUdDait62igIqihG5D8TO72FQjO47+VMvmcgZiV2V1Nlp2iYyRPZ8QguWeDKb/JAGjO03Pl5HFth1L4TRq6C4HahCv7XbEnLiO27Ulg6kdQ2h2iohh5H5kD1hfWVX+fMSZDImg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(186003)(55016003)(19627405001)(508600001)(52536014)(316002)(110136005)(86362001)(83380400001)(26005)(91956017)(38100700002)(38070700005)(122000001)(5660300002)(8676002)(7696005)(76116006)(9686003)(64756008)(66556008)(2906002)(71200400001)(66476007)(53546011)(66446008)(66946007)(33656002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vW4svB6AypmFrJKOKlVyfatzUueR402JPrTNclH7kXAhe8B3tz2fT9eaH9r1?=
 =?us-ascii?Q?IMwFdGC5We38uCx3y9MspvNS5nBksDtdP0pQfRUnN6IwHQchY+dbRBNYKKQV?=
 =?us-ascii?Q?5O076DqjUFaDF5jEzl9lVXfhYETkJKwmJNU5kucSfkxlUengV1HoBHYGp32C?=
 =?us-ascii?Q?Ziyv/KRZdabq+sB2NTeNWU7MUz99s4kJRU4kXdgpJPYxf3CyX9J8vJd3FvyX?=
 =?us-ascii?Q?qajfXenfLqmFCFTAVN6fSEX5iHiMUd7L9srxtPRxd0tGRGCJOtuTgU4navCw?=
 =?us-ascii?Q?/G8lCn5xfHrTFzEidV+XftAeZsCr4SLTsYq5pZglJF2LS1EjVAOmR8hgpMlY?=
 =?us-ascii?Q?5KywBoBVVxqC0xvI/ElcnxcNpsOFvXFNThC2uNig6ldoiHifiY1c7eN5EePh?=
 =?us-ascii?Q?37QpJICMJwC8pPqdg7WF0JCe1blDmKj64KyUYdWzdzFNrLBKRrvZQXdjRFht?=
 =?us-ascii?Q?3sBSmPqt4P2SV4cC0amG2IAlAkObCDw/nB8qfNzfIj9E/oqMpSpfN8XyByds?=
 =?us-ascii?Q?WtntX/xsZy48E/81d84303NZgAhSTiarx5gpbsvz9xaC8SNDDEtaxJGo6LTG?=
 =?us-ascii?Q?XdwqlDMAdK7LvFplUE9LAhjGPgX9VigcJXDIicc8ZB+kDWKWJYj4A1kGjvmt?=
 =?us-ascii?Q?e8Y12y6dRVXCqyqd5AyJRg9xf0+aHHZ9A+WCDrXDkfUqWZbnnYJQ2imSrLxy?=
 =?us-ascii?Q?/wscKlBg9+eg1+HhPMfTgTMD5USdKtme4Y3dZ+Cv/uEI9jPyR72CKbgEhXEI?=
 =?us-ascii?Q?8KcB3KxRK30rr1+TXFUpovsIngpWAcI/C1zHfwkIfj2ZouH1PzCp17gf37Z0?=
 =?us-ascii?Q?9seo6RQ0CAsbK+H6RHcoLvh57nx+xAYzz8kkq/GoTF7i8QKeZr/KQ4sS5nLB?=
 =?us-ascii?Q?Iflwmb/OgZKejvQGixa24H+Ht4vNzhRuw5xwbNhsGnf/TZ+4oE0M+4Uk7php?=
 =?us-ascii?Q?evzH1QHndGhYYmTeV/dHNw/6VnKAsr8wnoyQVy8uw/NzcGJoOWgdI/c61KAA?=
 =?us-ascii?Q?hdcwjEC9A8Ug7X4vxqNMcVlRT9O5HuRZOVIlJ8aIDrdrDBEHPK4laR2GDOy8?=
 =?us-ascii?Q?i4t/SDr01mttiXHX3SzLhK+y7SrT7OcFoPkY84Kt3CSXW83+yFz39XtTZwIm?=
 =?us-ascii?Q?xSq457+slipEGs31jOtyqtwR0qHYuDJZvE4OsgGAH+Ud2yBRuPJ+CivCAAwf?=
 =?us-ascii?Q?9lLEyUFQOnAYJQwVUjeMx4c3syOX5kStCb9kTZbIfdmBWfM2dqt6RIrheFGf?=
 =?us-ascii?Q?P5fXIDk2FIRx4olpRaHb2a9U3vTjOPSVbCpXxtrLnarunaIwdEmHbrmq4ttv?=
 =?us-ascii?Q?mXnYfzM8g+GEJdNKUoBugyPeZjPZX/wYlUPIbvI2TTIIjtFBEVUStpbS5d75?=
 =?us-ascii?Q?yK3UWTBawpGgDifx2UAGcSDL7HiQkKUjF0TikEm8hJptBf18r/YjCKFS2BOF?=
 =?us-ascii?Q?QVNNld6+wsms1SilMFQp+W/Bu8u4/jWIGU5/AyxDw8H8W6ev2Rsou5TAxzzN?=
 =?us-ascii?Q?prH9x9Oq1wDDUnCnOtzSBd1cF9ho6poNEv4m0fGSmcQKWeprZHsDUi/8X7eL?=
 =?us-ascii?Q?YO70HPKPuPwJh3fk7+nCvWSaiTfPNUSsO88V/3nq/XSORuPusJn7Bk8W4snD?=
 =?us-ascii?Q?8zZRXCbiwJJ9bxKLP1moGwTms1qATtbuVSEZ+Xc5hPXDvafDkrdhyNr5LVtI?=
 =?us-ascii?Q?cjkUuYAKutPQklSxiFIr8EVnJ7Q4LkQMzFvHdZUEgBw2J8Ed?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5182C293BE9C6AF6E807A554ECFC9DM4PR12MB5182namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a824e529-e429-4a7c-e7fa-08da29816534
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 01:41:35.1675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMlmM1ESMLLAnhlKngoYCNefmMabz71eRX3oRKJpbvELeXoIn1pw516lrZkqLiuzzi+AHsWCcrPCWr0JBLhRDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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

--_000_DM4PR12MB5182C293BE9C6AF6E807A554ECFC9DM4PR12MB5182namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

This bug previously existed, and we have a solution in place for it.

The solution we picked was to force a stall through reading back the memory=
. You'll see this implemented in dmub_srv.c and the dmub_cmd.h header - thr=
ough use of a volatile read over the region written. We do this for both th=
e initial allocation for the cache windows and on every command submission =
to ensure DMCUB doesn't wakeup before the writes are in VRAM.

The issue on dGPU is the latency through the HDP path, but on APU the issue=
 is out of order writes. We saw this problem on both DCN30/DCN21 when DMCUB=
 was first introduced.

The writes we do happen within dmub_hw_init and on every command execution,=
 but this patch adds the flush before HW init. I think the only issue this =
potentially fixes is the initial writeout in the SW PSP code to VRAM, but t=
hey already have flushes in place for that. The signature validation would =
cause firmware to fail to load if it wasn't at least.

So from a correctness perspective I don't think this patch causes any issue=
, but from a performance perspective this probably adds at least 100us to b=
oot, if not more. My recommendation is to leave things as-is for now.

Regards,
Nicholas Kazlauskas
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Thursday, April 28, 2022 6:13 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB fi=
rmware

When data is written to VRAM via the PCI BAR, the data goes
through a block called HDP which has a write queue and a
read cache.  When the driver writes to VRAM, it needs to flush
the HDP write queue to make sure all the data written has
actually hit VRAM.

When we write the DMCUB firmware to vram, we never flushed the
HDP.  In theory this could cause DMCUB errors if we try and
start the DMCUB firmware without making sure the data has hit
memory.

This doesn't fix any known issues, but is the right thing to do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a6c3e1d74124..5c1fd3a91cd5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1133,6 +1133,10 @@ static int dm_dmub_hw_init(struct amdgpu_device *ade=
v)
                 break;
         }

+       /* flush HDP */
+       mb();
+       amdgpu_device_flush_hdp(adev, NULL);
+
         status =3D dmub_srv_hw_init(dmub_srv, &hw_params);
         if (status !=3D DMUB_STATUS_OK) {
                 DRM_ERROR("Error initializing DMUB HW: %d\n", status);
--
2.35.1


--_000_DM4PR12MB5182C293BE9C6AF6E807A554ECFC9DM4PR12MB5182namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt;">This bug previously existed, and we have a solution in place for =
it.</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
The solution we picked was to force a stall through reading back the memory=
. You'll see this implemented in dmub_srv.c and the dmub_cmd.h header - thr=
ough use of a volatile read over the region written. We do this for both th=
e initial allocation for the cache
 windows and on every command submission to ensure DMCUB doesn't wakeup bef=
ore the writes are in VRAM.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
The issue on dGPU is the latency through the HDP path, but on APU the issue=
 is out of order writes. We saw this problem on both DCN30/DCN21 when DMCUB=
 was first introduced.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
The writes we do happen within dmub_hw_init and on every command execution,=
 but this patch adds the flush before HW init. I think the only issue this =
potentially fixes is the initial writeout in the SW PSP code to VRAM, but t=
hey already have flushes in place
 for that. The signature validation would cause firmware to fail to load if=
 it wasn't at least.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
So from a correctness perspective I don't think this patch causes any issue=
, but from a performance perspective this probably adds at least 100us to b=
oot, if not more. My recommendation is to leave things as-is for now.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Nicholas Kazlauskas</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 28, 2022 6:13 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/display: flush the HDP when setting up D=
MCUB firmware</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When data is written to VRAM via the PCI BAR, the =
data goes<br>
through a block called HDP which has a write queue and a<br>
read cache.&nbsp; When the driver writes to VRAM, it needs to flush<br>
the HDP write queue to make sure all the data written has<br>
actually hit VRAM.<br>
<br>
When we write the DMCUB firmware to vram, we never flushed the<br>
HDP.&nbsp; In theory this could cause DMCUB errors if we try and<br>
start the DMCUB firmware without making sure the data has hit<br>
memory.<br>
<br>
This doesn't fix any known issues, but is the right thing to do.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++<br>
&nbsp;1 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index a6c3e1d74124..5c1fd3a91cd5 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1133,6 +1133,10 @@ static int dm_dmub_hw_init(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flush HDP */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_flush_hdp(adev, NULL);<=
br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D dmub_srv_hw_ini=
t(dmub_srv, &amp;hw_params);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status !=3D DMUB_STATU=
S_OK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Error initializing DMUB HW: %d\n&quot=
;, status);<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5182C293BE9C6AF6E807A554ECFC9DM4PR12MB5182namp_--
