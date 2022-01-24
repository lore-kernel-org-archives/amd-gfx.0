Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF25C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 03:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FDA10E3C0;
	Mon, 24 Jan 2022 03:01:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B4210E3C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 03:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8+UJVhdq92IivdLFpHQ4MT4cKuR0U7B/pGfgcVfFNR6rOcQvBKyNox3e8oGxaR41hR6K6YmcrBink4kfw5njzwFynVRkK71pMBtj1ksgnWH4z2mOLgBOnoeJq7IV6o1bJgdTgw1ZfqvayMTc9RAXXCZGL/jJJYzUfrIgdeQj2k1ydQnG5m2ECh/v7OEo0OrWZgD90mJrNBKoRkUVqKhMO/17K11NW4W2vIFPl59c27C4CGb9gjxXwHB3DE9GX7ul5onij9z8nNRy8Dhcl5fb8/ma10uaXPEEq3gWmwwQ5VRmc3f7srMr4eV4cSVEqw2Koc2nbvPSkU+wkYpclp8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkPOZPhSWDS48UOINh3WXOcZ5JOCFIk7g3KpJ1pp7a0=;
 b=BwYzLH3pZg4nXZmVGBtjy4DGjnYIAOa+0bkKSHnKEE0TqVoguykro2wqE0+N/sVmy9X2XLtaDf4cjbLjaNH+seiglKHiUXP/BGOxLXAxeiBI+WeWiXJnaNiNDU7daY6+kLGZEKvPlAvug4tyRzL7uPHTSLu1TKdn6wzYcaZTIsoDruzxbUdfjc+0/lH+c4hty4HFk8Gdb5kpLYW/XLIK5rOr40lJ7ffj48dfemI3l0p2tdkFYdjzxhlXdXQEWofsSik/im921gNzVRP8oV2CKXraA88aPP6jh5AKGDjf4aqXDDAtKGqn/8eYln3ihx6Sd2hLJxu3PAytDJ7HhSspkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkPOZPhSWDS48UOINh3WXOcZ5JOCFIk7g3KpJ1pp7a0=;
 b=2MLgUjMKl13iiQvnL2XCwXP3WwrLyag/qbIra9tX7kM+sZ1VW7fpfUcpXp+sCH/e0RBAMrDv4Tbf5LHPVNnrx3M24AtQ1TjcHCtPZ2myLbZkwoW3+FXs4XHGzH+Cwv4BsqnqpVRFPxz9+PxgAYxv+WIlGtISrPwzjEz8k9S0Xmo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Mon, 24 Jan 2022 03:01:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 03:01:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] amdgpu/pm: Add Error Handling to emit_clocks stack
Thread-Topic: [PATCH 3/3] amdgpu/pm: Add Error Handling to emit_clocks stack
Thread-Index: AQHYD0LCFVjAjjf1EEK4ZmtkywmSZKxxfjxw
Date: Mon, 24 Jan 2022 03:01:08 +0000
Message-ID: <DM6PR12MB2619BFBA041A2F954B619EC7E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220122034647.67925-1-darren.powell@amd.com>
 <20220122034647.67925-4-darren.powell@amd.com>
In-Reply-To: <20220122034647.67925-4-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-24T03:01:05Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=56390acd-f117-4f3e-9e6c-925d01d248b7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8d7eb54-b8a5-4e66-906c-08d9dee5c55d
x-ms-traffictypediagnostic: DM6PR12MB3914:EE_
x-microsoft-antispam-prvs: <DM6PR12MB391452B03AC85E5867B64AF6E45E9@DM6PR12MB3914.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ImGnqCAxDcVIvhcqQD/cxyxRVq6lH/6w49pbgSmEctt5bQm1AJPJtqR+jGgZdj1+aoU4Gmm5gbHuUpZ2UhBbZew/jfSOHraJgr08wvQwnQKV6yJUVw6Lv233iMDIjrcsS7TrRqMQ1jWZ7+5Baed09a+fHIfe9aydmJ9VNzXzbdT2w2RgfFweSgdgVr9EVt81beH7D5KigIVhb//qhrTkh1upWgMxYw4RvfJ+kssnRfCSv7x/0rvmbm/Qpq1TwtrksKZCA++toCxYgYv4SThshw/HLEu1SWCzpxf5H9No4zyU8hxv13SJLYLoi6r94WqeiO5SbcbucN3UxD5Uy8Zkihq3gybJfx572yZmj6Tm9B2P1qBz1u2SBSDPIxjxa1XIgwnuplO/8PkYaJsY4mE9WJTUdnKUUZI5nH3jFZmQB0d1pjU62dqLoSRpEKW1yFPsotnTxJe8Hi0DFnHj5UxqUJxyqNFIbFTU3H/OBtD3PLL8Tf3KQVJzpwMSqMEwyqKQML4MnibrxWdnC/K9oHPo1VnKRQUAgMW5tQPnXqBZG1oCg0GpzouPNjg8gYIDF2m36V4LNmzr8ydZVAkPdGmWV1K58RhsyIB35wF4ZOk7N05Uoc3q5IbljXOgDqA6AOY7IGE2jATwAkHAtz+zX03AvwDXseZYr07hVosmBFs74gOTxcTcNY8Rqp1RL362EulQjBGFE+rCSIyZ4bMC9Fl4Bg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(76116006)(38070700005)(9686003)(53546011)(7696005)(33656002)(66946007)(66556008)(186003)(66446008)(5660300002)(66476007)(38100700002)(64756008)(110136005)(55016003)(8936002)(316002)(508600001)(122000001)(8676002)(2906002)(83380400001)(6506007)(71200400001)(52536014)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x0mgqb1vllz5VJ555kSrx4e2VIuqdNXw9tCoCqfxUsqXRIDvjehkq/xlA/n6?=
 =?us-ascii?Q?kOgW2RWO4wDinGhHChEdn+yKpLF8AMnmnQUI3EEHnVao474QJ9xZ9PJ+Cykp?=
 =?us-ascii?Q?Yl1VkpFfemBawuf0cjn2DZauozqDunUiU+R9aRLBfZG0W0W17K5lkpVqe4/l?=
 =?us-ascii?Q?dK2NYzoTHIwyNlNhpzf0J/MZD0VyRZ/pvOAei+tXvliwY1AQDEXHd1WSn4Id?=
 =?us-ascii?Q?yZtrUCIkE2pb3Hbm+sukd6139tkySutdZoRpYRW6LRXlYnvu4DzAbtyD5qEd?=
 =?us-ascii?Q?vXu3b/ZhSoloVUlBRWImhlNHPJHq1RKNQeUXMHL8zMf4nvWME9kZUE5Q6UQQ?=
 =?us-ascii?Q?4/SKII7O03XT++IsSkeGp2GUh6S5zNNIvt4tANpsh31xI4goJ+L+KmVz7mdE?=
 =?us-ascii?Q?9J2RjHJx8Dy5ZCwXeekhEEwSSzz8F3QBbfqAaVFgOlZrbun9rppmLuARzehs?=
 =?us-ascii?Q?qEyjW8ol8F5NPaSymOdzLf9q9aEMtawKFBppBG0XKRLOABeQpjuL3uGblM1o?=
 =?us-ascii?Q?8csEvEoQA7f++wdJzk83i0Gz/i3Yaho8FQL/CWlBvrKn97riSL/j7/8/u/hF?=
 =?us-ascii?Q?pRbeIzPTtWBp+xBbn5rdd8Pxhd8PPlOU+JORGvgyR+HJnBRHcv8S1wj7O0PP?=
 =?us-ascii?Q?Vi5UqL9Na4tOOHrfrcrLrW84IoiZ2oDHLa50kXbaRJfiGlnj3IGvKjVKhLm1?=
 =?us-ascii?Q?wz/WvPn7/xAjA9tbVSfNThoSr5bEgwyAcnaafAbhxcMNNSKJsYK0KllmMsn3?=
 =?us-ascii?Q?i+j7meQp+yaJbemvvLthdrSaUsdr1bdFPOQf20QDO6Qa53Uxp/G/ee/Bd3pW?=
 =?us-ascii?Q?fdb3cNx+X5xodeg81H0z5ZAIyi+NHC8Pcxz+A0WWn/+7OMrOlbawO4uv6DlB?=
 =?us-ascii?Q?sGM6K/vTg95bGLDot7icTwTwn6m2YyPHggHGtFv9P9MjSZ97fiN07HOYY8Qo?=
 =?us-ascii?Q?k9dMs6gRaUNufYBiIGP9wSqpwbfnN6h9jlRfqzrE16vl7tFtrdlIzSahgUbt?=
 =?us-ascii?Q?FKYllGq14cNcHmlGNa/+e8GSaUnp7mX68tS9qtCudUf+kJUQghKBxZPkB4cv?=
 =?us-ascii?Q?6669SlafSthJtzAVQaqsFJ5KmT3vW99Vr48grlu/qubeTWiepWO+8PvhgebE?=
 =?us-ascii?Q?iNFFBpp/jgdL95y9gRpdMn9y7vgNvFJAHBHygheUUMl7s245yODeMWKxv6m9?=
 =?us-ascii?Q?y3vTCHSAo04hB/F1350Hek7d0pQ7zsu29/6PO7F+ZQ3iCENabH1oxpE4RR2M?=
 =?us-ascii?Q?Y7w+bujh8m4Z2BLq8u+OtWOTgSytJJJaQ/YVW9n8Rm9tx+fBpp+P5L8UgH/B?=
 =?us-ascii?Q?uAQ76rFKiu0UNjg6HDCXW2QrJHFhc94gO7+58ZOfkIixkEgwTZQIUynj4c+T?=
 =?us-ascii?Q?xQHajglreVh2jXACfySQWaF9c0RKtLTcdKrdqnbGPD7vfwG97rhRCPi5+1Ey?=
 =?us-ascii?Q?Q135BdjnPpfZeDffjtrFXmLaAQNGYXE8uqyyuaUpt0lTue02JFFrKucpzkM2?=
 =?us-ascii?Q?7OXbaT35BIu5c7FP8q+xpoQU77OANZsKSeTwq2QtRo8AZB6aXBQ7ck/CXIwk?=
 =?us-ascii?Q?PLgGQRQozwANtxSZSCM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d7eb54-b8a5-4e66-906c-08d9dee5c55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 03:01:08.9131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxLJ6JaiiaTnKxYGwmHDQi2HTX/1t5u4HaLUojktu8aXmtbMQ8o1oqzHeMsMI1Pg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3914
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

[AMD Official Use Only]

It seems this patch should be combined with patch1. Rather than as a separa=
te patch.

BR
Evan
> -----Original Message-----
> From: Powell, Darren <Darren.Powell@amd.com>
> Sent: Saturday, January 22, 2022 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Powell, Darren <Darren.Powell@amd.com>
> Subject: [PATCH 3/3] amdgpu/pm: Add Error Handling to emit_clocks stack
>=20
>  Previous implementation of print_clocks required return of bytes written
>  to calling function via return value. Passing this value in by reference
>  allows us now to pass back error codes up the calling stack.
>=20
>  (v1)
>  - Errors from get_current_clk_freq, get_dpm_level_count & get_dpm_freq
>       now passed back up the stack
>  - Added -EOPNOTSUPP when encountering for OD clocks
>       !od_enabled
>       missing od_table or od_settings
>  - OD_RANGE continues to print any subset of the ODCAP settings it can fi=
nd
>       without reporting error for any missing
>  - smu_emit_ppclk returns ENOENT if emit_clk_levels is not supported by t=
he
>       device
>  - modified calling logic so fallback to print_clock_levels is only attem=
pted
>       if emit_clk_levels is not (yet) supported by the device
>=20
>  (v2)
>  - change return from amdgpu_dpm_emit_clock_levels if emit_clock_levels
> not found
>  - updated documentation of pptable_func members print_clk_levels,
> emit_clk_levels
>=20
>  =3D=3D Test =3D=3D
>  LOGFILE=3Dpp_clk.test.log
>  AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
>  AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR |
> awk '{print $9}'`
>  HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}
>=20
>  lspci -nn | grep "VGA\|Display"  > $LOGFILE
>  FILES=3D"pp_od_clk_voltage
>  pp_dpm_sclk
>  pp_dpm_mclk
>  pp_dpm_pcie
>  pp_dpm_socclk
>  pp_dpm_fclk
>  pp_dpm_dcefclk
>  pp_dpm_vclk
>  pp_dpm_dclk "
>=20
>  for f in $FILES
>  do
>    echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
>    cat $HWMON_DIR/device/$f >> $LOGFILE
>  done
>  cat $LOGFILE
>=20
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  2 +-
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 13 ++++++------
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 +++----
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 +++++-
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 +++++++++---------
> -
>  5 files changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index e45578124928..03a690a3abb7 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -915,7 +915,7 @@ int amdgpu_dpm_emit_clock_levels(struct
> amdgpu_device *adev,
>  	int ret =3D 0;
>=20
>  	if (!pp_funcs->emit_clock_levels)
> -		return 0;
> +		return -ENOENT;
>=20
>  	mutex_lock(&adev->pm.mutex);
>  	ret =3D pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 97a8dcbe6eaf..a11def0ee761 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -855,13 +855,12 @@ static ssize_t
> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  		return ret;
>  	}
>=20
> -	ret =3D amdgpu_dpm_emit_clock_levels(adev, od_clocks[0], buf,
> &size);
> -	if (ret >=3D 0) {
> -		/* Proceed with emit for other od clocks if the first call
> succeeds */
> -		for(clk_index =3D 1 ; clk_index < 6 ; clk_index++)
> -			amdgpu_dpm_emit_clock_levels(adev,
> od_clocks[clk_index], buf, &size);
> +	for(clk_index =3D 0 ; clk_index < 6 ; clk_index++) {
> +		ret =3D amdgpu_dpm_emit_clock_levels(adev,
> od_clocks[clk_index], buf, &size);
> +		if (ret)
> +			break;
>  	}
> -	else {
> +	if (ret =3D=3D -ENOENT) {
>  		size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
>  		if (size > 0) {
>  			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_MCLK, buf+size);
> @@ -1014,7 +1013,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>  	}
>=20
>  	ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
> -	if (ret < 0)
> +	if (ret =3D=3D -ENOENT)
>  		size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
>=20
>  	if (size =3D=3D 0)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d82ea7ee223f..29c101a93dc4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2454,12 +2454,10 @@ static int smu_emit_ppclk_levels(void *handle,
> enum pp_clock_type type, char *bu
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
>=20
> -	if (smu->ppt_funcs->emit_clk_levels) {
> +	if (smu->ppt_funcs->emit_clk_levels)
>  		ret =3D smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf,
> offset);
> -	}
> -	else {
> -		ret =3D -EOPNOTSUPP;
> -	}
> +	else
> +		ret =3D -ENOENT;
>=20
>  	return ret;
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 224b869eda70..1429581dca9c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -612,6 +612,7 @@ struct pptable_funcs {
>  	 *                    to buffer. Star current level.
>  	 *
>  	 * Used for sysfs interfaces.
> +	 * Return: Number of characters written to the buffer
>  	 */
>  	int (*print_clk_levels)(struct smu_context *smu, enum
> smu_clk_type clk_type, char *buf);
>=20
> @@ -621,7 +622,10 @@ struct pptable_funcs {
>  	 *
>  	 * Used for sysfs interfaces.
>  	 * &buf: sysfs buffer
> -	 * &offset: offset within buffer to start printing
> +	 * &offset: offset within buffer to start printing, which is updated by
> the
> +	 * function.
> +	 *
> +	 * Return: 0 on Success or Negative to indicate an error occurred.
>  	 */
>  	int (*emit_clk_levels)(struct smu_context *smu, enum
> smu_clk_type clk_type, char *buf, int *offset);
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 50022de5337f..4bcef7d1a0d6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1278,7 +1278,6 @@ static int navi10_emit_clk_levels(struct
> smu_context *smu,
>  		(OverDriveTable_t *)table_context->overdrive_table;
>  	struct smu_11_0_overdrive_table *od_settings =3D smu->od_settings;
>  	uint32_t min_value, max_value;
> -	int save_offset =3D *offset;
>=20
>  	switch (clk_type) {
>  	case SMU_GFXCLK:
> @@ -1292,17 +1291,17 @@ static int navi10_emit_clk_levels(struct
> smu_context *smu,
>  	case SMU_DCEFCLK:
>  		ret =3D navi10_get_current_clk_freq_by_table(smu, clk_type,
> &cur_value);
>  		if (ret)
> -			return 0;
> +			return ret;
>=20
>  		ret =3D smu_v11_0_get_dpm_level_count(smu, clk_type,
> &count);
>  		if (ret)
> -			return 0;
> +			return ret;
>=20
>  		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
>  			for (i =3D 0; i < count; i++) {
>  				ret =3D
> smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
>  				if (ret)
> -					return (*offset - save_offset);
> +					return ret;
>=20
>  				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i, value,
>  						cur_value =3D=3D value ? "*" : "");
> @@ -1311,10 +1310,10 @@ static int navi10_emit_clk_levels(struct
> smu_context *smu,
>  		} else {
>  			ret =3D smu_v11_0_get_dpm_freq_by_index(smu,
> clk_type, 0, &freq_values[0]);
>  			if (ret)
> -				return 0;
> +				return ret;
>  			ret =3D smu_v11_0_get_dpm_freq_by_index(smu,
> clk_type, count - 1, &freq_values[2]);
>  			if (ret)
> -				return 0;
> +				return ret;
>=20
>  			freq_values[1] =3D cur_value;
>  			mark_index =3D cur_value =3D=3D freq_values[0] ? 0 :
> @@ -1355,7 +1354,7 @@ static int navi10_emit_clk_levels(struct
> smu_context *smu,
>  		break;
>  	case SMU_OD_SCLK:
>  		if (!smu->od_enabled || !od_table || !od_settings)
> -			break;
> +			return -EOPNOTSUPP;
>  		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_LIMITS))
>  			break;
>  		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_SCLK:\n0: %uMhz\n1: %uMhz\n",
> @@ -1363,14 +1362,14 @@ static int navi10_emit_clk_levels(struct
> smu_context *smu,
>  		break;
>  	case SMU_OD_MCLK:
>  		if (!smu->od_enabled || !od_table || !od_settings)
> -			break;
> +			return -EOPNOTSUPP;
>  		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_UCLK_MAX))
>  			break;
>  		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_MCLK:\n1: %uMHz\n", od_table->UclkFmax);
>  		break;
>  	case SMU_OD_VDDC_CURVE:
>  		if (!smu->od_enabled || !od_table || !od_settings)
> -			break;
> +			return -EOPNOTSUPP;
>  		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_CURVE))
>  			break;
>  		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_VDDC_CURVE:\n");
> @@ -1395,7 +1394,7 @@ static int navi10_emit_clk_levels(struct
> smu_context *smu,
>  		break;
>  	case SMU_OD_RANGE:
>  		if (!smu->od_enabled || !od_table || !od_settings)
> -			break;
> +			return -EOPNOTSUPP;
>  		*offset +=3D sysfs_emit_at(buf, *offset, "%s:\n",
> "OD_RANGE");
>=20
>  		if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
> @@ -1446,7 +1445,7 @@ static int navi10_emit_clk_levels(struct
> smu_context *smu,
>  		break;
>  	}
>=20
> -	return (*offset - save_offset);
> +	return 0;
>  }
>=20
>  static int navi10_print_clk_levels(struct smu_context *smu,
> --
> 2.34.1
