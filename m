Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C3DC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 21:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394C610E31B;
	Mon, 14 Nov 2022 21:16:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FEB10E31B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 21:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+CoWoM2egyJdRV3QoeVRxfJFUGWWiSbg5oWbekI7oVU6j3Uw95mf7aUOoLu8uFqbGlDq3T3PhnHFNDkLUZWKqXItzm9JeQ0KvmznHrJ4aF11Z8+9msBXiD9Fb5cB+MV+1ps6TV2dmOuFMp9mfLWhRXULUlSdz8ot5hP0DYo3t/5u+top3Hqt35BN6XnF5kUa19sVCgaLLGRBMGMaXDMuDRz7hatyNC5rIneoTmZkG8r6ce0DebZEvr7gPzENyo44rWNi+NYnP3OQb31Ts2qX/1S7rQBSTtDya1YKtTwKwHqc7dybMfWRr4NncpL99guJ4o3DKPpmHpzez+eLY84BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43oGyypw649aWVxZMv5tZsQ+Pn/86tyewdTqGh4KZ3U=;
 b=DZsOsOM41eJ4gTejr3kFjgYaHHiQF59W3ARaCKzFVmsJ+kt/jIHK0UOHzbtbxoBCGmXdgLhCco0jRzXzxyrkHspAQ9sKwIG5rYlTdNzfEGVq10BhOYdMdmjPO8cI6xX9LwJo1KvKrXZ6X79y61rwNhPOV/QVwT4R52n00VYW9STBNONgM7VaQmpogKNoSt7hk6NNAnpke+YLdCuIjy+0F7DB3xBLoV/S4EB3TU2RPRrdgVbW1URPk7bIeAiGJtuHfd7Bx16HfdOfYGOPvKA2CH1fQPyy/p9fAeBL47YFUDe1rALV2IizX4MSEl38VJJLTZk0sBMAlcCkjYqdgFTF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43oGyypw649aWVxZMv5tZsQ+Pn/86tyewdTqGh4KZ3U=;
 b=LLkbNCueF9UNMwl8D7FVLNPclFHfgtRnsyKx2BH205ooRn550yUC6/LfRuMO5c5SztCx+ySZcF9qQ4Mr7kJP5yhbq9fsNCAHZvVn8qArFtPAYvflDyDiaCPCGdjIZSXDo/XUBLXVA0FOnsoz9vOfxcaFBcOcM1YUD8W+Y/iOd6I=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 21:15:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 21:15:58 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Rizvi, Saaem" <SyedSaaem.Rizvi@amd.com>
Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Thread-Topic: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Thread-Index: AQHY+G0R6PmpKai7kkKRGynCK+KzHK4+6itg
Date: Mon, 14 Nov 2022 21:15:58 +0000
Message-ID: <MN0PR12MB61018FC7358247F0A2D476E9E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221114210701.23185-1-Roman.Li@amd.com>
In-Reply-To: <20221114210701.23185-1-Roman.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-14T21:10:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=db96694a-48f2-4a3b-a61c-ab539de75e9a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-11-14T21:15:56Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: bed042f1-8a73-4b44-80af-08d6458588f6
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB5748:EE_
x-ms-office365-filtering-correlation-id: c079b723-a2db-4906-b59e-08dac6856c98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlTFZXTLQdpSkVWHD8JCWVMJVOsGFJTsWIWxcufa2r7J3vnoGGQE5aHh1VLEWPTDwDF4rlSqt3dYzLEQDdTkmFnamAJPVTNCbSmSonGUAaaKbPMKdBPpjoz8W8qnyxU+rp+nYXYExwRCtd09Y1xhnAomsYUyx/tYkhlditEeuevrdy4Eg/9gwLt5t2kC3CAARtjikDlR3Ov+RT+SHH1xDOw50mZM35PMeNRGLWhczkmHYUYCvTEy5lzKZiKNWpVgn1SPQMFMSEF1He9L65CZIiB92KCZ3bB3o0CUn/4sqZXloZPtosoDHaOVLK6IoZK43rZOH/F4L/T+WWsqK2UVjy5Zx2XDVhg5lqnd7DBnEl9319lb1rovLihk/nFseQ/T3+8+90SD4YF8ZzmTlRd81uSEiEuTp36IKHbWH+/oHUU/eVtgGFxay6XLQFcaEdkqIvLWy+aNCN6Kw8xUNURbO4LyHKDyMSGd7Cctz+N5N/kd0TgsexPnZ964bV4oQVaB+cGiACMPa5Cx3G56OkTskPf3qmiirQuk7Xr/X9vX70Zz89rb+0yKBxAcZsBln4hDLJIwkUiyp14BYPEEJzpkx0Rio1C5WDOPvnqoZlin4gXPX5QEgMIAzVAdrfcGmXijAaIVQwnQD7QB4hT24cbZUnPf89Cm49/fpDier544l4SUu4riBrI5akf+WplPSgeZJkjiasXXtkTGxmIy+6UAbw62RVcKLVCKfcjHCwHQqn4hWAwXC7qGH7J7pAH0Ltopu3cxyuDQZixw5jPSLatD5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(38070700005)(6506007)(55016003)(9686003)(110136005)(86362001)(7696005)(71200400001)(4326008)(8676002)(478600001)(66946007)(76116006)(52536014)(64756008)(66556008)(66446008)(66476007)(33656002)(8936002)(5660300002)(2906002)(316002)(41300700001)(6636002)(53546011)(38100700002)(122000001)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V5+RFr/WgGP0V909WmukpBS6osvZswTYi54zCmdU8rbFEE4s6y/j6b/30Up3?=
 =?us-ascii?Q?RWPolpD2ZSnbEafmRtB+80gVQaFIlYIrajIIn4HlUrd2lQpuqzRZpF0EKOiE?=
 =?us-ascii?Q?Xmdw88+IX47BMFWMf6oJz9b3nqcO8dhrekvRb3jMAbinbvcktj+6n85hQ1rA?=
 =?us-ascii?Q?amggivqGMk/JZEwDKzryHPtTw/kA99B/V/g3Da9Ev07Uv1raAtQ9CG3P/uvk?=
 =?us-ascii?Q?UfM05XBbmEvYtoHM1Fd9C0tGOaxntLLTViSpCigttr2sbyUXybk66AzgZOGm?=
 =?us-ascii?Q?h1rwPL03y0Hz/dFVXXduzCbIFGPGSZyJozJyChf+w+fezTynzrqHQb5tYkhF?=
 =?us-ascii?Q?+8w99f0jRU0dYgpcURH388t2LF8oBS1PzkQPX1vS8NBGTVJXZnhygfvjY+dQ?=
 =?us-ascii?Q?W8o9Qd9USAAvj6nTb5pcguMc8JfVoYnLfCCSRO5hF0d2eqe97IFNhSldnYSa?=
 =?us-ascii?Q?xHeAuBr0v1po4n2Sp4nmKJyffdRq9Hgjprnl0TIBjn61COg7OF9cJ6HT5q18?=
 =?us-ascii?Q?+CWUQSBw5mZMTxdBF1Xt//vfxN0McGPU1PX/ZhtNDn399ggdwKuAMjHOOj/H?=
 =?us-ascii?Q?0S8MA2MYYPTMzZ3qyeF4QtAoFouzy200KnnfCjz2VfLgX/3zpkGDNyvSGivA?=
 =?us-ascii?Q?Slk0Wbs8iSavr2Q26IIf3odUOzJUbdNwq5VJBmEaKhornq64MmZx9PKkQNSa?=
 =?us-ascii?Q?lGSxPyOPux7y6Q7eMZvVM5pg+XTe7loNUXXHCcBWllnWSO4ejufaBisteCp9?=
 =?us-ascii?Q?Yfj9TsUhekXc5oV6Qop59FvHjps090Lud9SUvj7qd1jstYGOSXejKcWKY1Jm?=
 =?us-ascii?Q?dZlUfyCihEJUZ47xV2OtbV24C/8rDO7lthKScnEDD5alwEZkIbYe8nLFpe68?=
 =?us-ascii?Q?8zHrf1UlUf0pAg7ZZ+xv0kO4WVis5cGiYlraP5E4u+roc7WsG8LhET20JeYL?=
 =?us-ascii?Q?FrexnN6LuYS2pJl/55Gbg4UjMW61fl22tQk3WzYuzLldhdS/9Sf+MYul6cXO?=
 =?us-ascii?Q?eMGWg/pO6j9SSM6m+/X3n3rMKtvmjUZvjb6tq4g3CNYMZ5wZONiy7NKTE2ZR?=
 =?us-ascii?Q?y91Tv4U//d5X4YoZo4LML5smH5lQitC7cXdD5J7wDz1S82LPedSIPIDtR+bs?=
 =?us-ascii?Q?84rhcc42GEC7Hfpz9NN5c0/4H38SKzdp9xCDTp4MFaDi/ozjOsnqO6HT9UvT?=
 =?us-ascii?Q?NDXMB2V6q1aFd50Wd2PE3aEiwDY4goa4/99/4VS5S0+GWD1F/rA2/7djokWJ?=
 =?us-ascii?Q?PXtw1UHggDzOu923p6g1iEinusksSwzvZDahQnOwv9XdsNhXikX2BwJq7Zhf?=
 =?us-ascii?Q?mn6405VZCG1QgC49N2rBMX4g3FfQ2H103SuUYT0AUUycZ0CIP3klhnHkoql/?=
 =?us-ascii?Q?+qQsiZqb7VXuk1iMvp6vFpqcSSS3+ulevoGcNjcxaL3uMiGTf9tJVX9wYKXZ?=
 =?us-ascii?Q?wLHX0ecY1k3O0YOwNmdVw+V2VY+871FjZlOoB6Ak0eKQeU4UQO+Zh61tK1pz?=
 =?us-ascii?Q?gHypxfAs6N039wLaYpxVZFDrApaX/EXoVwFVQJsw0w4tTdFSvLAsnzYB+x70?=
 =?us-ascii?Q?3tv3I639CTOC9/1bHP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c079b723-a2db-4906-b59e-08dac6856c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 21:15:58.1087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HQrdldGjV1HqqAcp9LcH3ioH+TaYwEr3LxDVaRSwfBUSKUztDWaVt25eEmmcP9UdaENJyAOXwhHIfErW4GcZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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
Cc: "Li, Roman" <Roman.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Conceptually makes sense to me, but please see below comments:

> -----Original Message-----
> From: Roman.Li@amd.com <Roman.Li@amd.com>
> Sent: Monday, November 14, 2022 15:07
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Rizvi, Saaem <SyedSaaem.Rizvi@amd.com>
> Cc: Li, Roman <Roman.Li@amd.com>
> Subject: [PATCH] drm/amd/display: Align dcn314_smu logging with other
> DCNs
>=20
> From: Roman Li <roman.li@amd.com>
>=20
> [Why]
> Assert on non-OK response from SMU is unnecessary.
> It was replaced with respective log message on other asics
> in the past with commit:
> "drm/amd/display: Removing assert statements for Linux"
>=20
> [How]
> Remove asert and add dbg logging as on other DCNs.
>=20
> CC: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
> Signed-off-by: Roman Li <roman.li@amd.com>
> ---
>  .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c    | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> index ef0795b14a1f..2db595672a46 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> @@ -123,9 +123,10 @@ static int
> dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
>  	uint32_t result;
>=20
>  	result =3D dcn314_smu_wait_for_response(clk_mgr, 10, 200000);
> -	ASSERT(result =3D=3D VBIOSSMC_Result_OK);

Does this flow actually happen still?  I thought the assertion should have =
gone
away as a result of 83293f7f3d15fc56e86bd5067a2c88b6b233ac3a.

Maybe we want to also undo the REG_WRITE() call there if pulling this in.

>=20
> -	smu_print("SMU response after wait: %d\n", result);
> +	if (result !=3D VBIOSSMC_Result_OK)
> +		smu_print("SMU Response was not OK. SMU response after
> wait received is: %d\n",
> +				result);
>=20
>  	if (result =3D=3D VBIOSSMC_Status_BUSY)
>  		return -1;

I think what is missing to clean up recent asserts is actually a little bit=
 further
in the code than this.  It should be part of the error flow introduced by
03ad3093c7c069d6ab4403730009ebafeea9ee37

> @@ -216,6 +217,12 @@ int dcn314_smu_set_hard_min_dcfclk(struct
> clk_mgr_internal *clk_mgr, int request
>  			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
>  			khz_to_mhz_ceil(requested_dcfclk_khz));
>=20
> +#ifdef DBG
> +	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n",
> +			actual_dcfclk_set_mhz,
> +			actual_dcfclk_set_mhz * 1000);
> +#endif
> +
>  	return actual_dcfclk_set_mhz * 1000;
>  }
>=20
> --
> 2.17.1
