Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73485C77B6F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 13:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB92610E21F;
	Tue, 11 Apr 2023 13:15:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2092710E21F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 13:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+yCYx4UCjGTdetvvwDcYmMOPKVJp76A0OC5thsTUkGuPr/0jWRg4QQsZX9E6DaNoAjHkqGxD8EDlLyHi/j8ilTS3PKrAgfCnjLw3Rg1D9vLL28dtOmEbSjas+JFg09LhrYJv1lvVnX4lndTVUrJJGSTUFAILknFq/eqrKvJvzgzOZ1y5dNhk7eo3Hgc3p0iVcq+miiWHr2L5FYS6SakGUqnJEymLs2RNFyeGhq9fiHJp+3j5dDXDVM8SV/Pmwby56OxcC1Jh7mh80yRirMyEnZolaTgZZlepqYmobBfrqv6pQYaok9eboiWXBpHJOtNF3fKhSbUmLMbHLJe18zIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuf/D3r8UKAb6h6yGz7P2jmkUw2O+BFQU8SiAL4g6pM=;
 b=IZYvferuzKcnr6HS34dlIzwRKoYz+mdwz8yUOKc2xMr2we4PcqWyExg0q814jpuZJXRmCKqwQfHeUnL6s5OCBPgqjLfXIRmBSFVVvVFq1GMLzgGWgBdpboGA9UjMI1P5FoisZH6onqsazbg6P7gNSamOapQGbYSkEm61OrSUorojNUwP0n7C0WmRFCk6FIczeZCqh83iFbTlLep9iraX92+gfFkD/o6diDrZgiu4IEsPntelI002NO3F37frz/JPPFx4fotCLvedQ0Zq9UYr4wWCNqtPebru1cR8g9GKSgPGirXGvvLY4NcAL7N9DxTqekTBr7qJioBQQbXOuNO7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuf/D3r8UKAb6h6yGz7P2jmkUw2O+BFQU8SiAL4g6pM=;
 b=XthtHB0zb/kCUpNIEJjpaU/EcDWENrC/zDd/U2q/DXTJmdYq7p+7Es1TzcRGObzXpAhQLG41SPD92OGBlyL6YzZEw/g3YsBsvCooCmbLXyUGClHHtfa2y7e2V69WZVIJ1lWCzDGXbPhwroUfSu5lZna9jieOBOnqqg1+6eN7I7M=
Received: from BN8PR12MB3348.namprd12.prod.outlook.com (2603:10b6:408:47::29)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 13:15:52 +0000
Received: from BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::fd84:8c31:1afe:eb2]) by BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::fd84:8c31:1afe:eb2%4]) with mapi id 15.20.6277.034; Tue, 11 Apr 2023
 13:15:52 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: Add logging for DP link traning Test
 Pattern Seqeunces
Thread-Topic: [PATCH v2] drm/amd/display: Add logging for DP link traning Test
 Pattern Seqeunces
Thread-Index: AQHZa9JpN2Jl0vYHKECNc5lzEsQAxa8kzhuAgAFJf9A=
Date: Tue, 11 Apr 2023 13:15:52 +0000
Message-ID: <BN8PR12MB334865B88D126B89BC3BFF5BE59A9@BN8PR12MB3348.namprd12.prod.outlook.com>
References: <20230410173200.1881023-1-srinivasan.shanmugam@amd.com>
 <MN2PR12MB4128F4212F6C8EEA37044D3290959@MN2PR12MB4128.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4128F4212F6C8EEA37044D3290959@MN2PR12MB4128.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T13:15:50Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=82835e19-2457-4c7f-a387-fd5de2d3f625;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T13:15:50Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 2c1877a2-6738-45f0-8232-de543b0d003a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB3348:EE_|CH3PR12MB8849:EE_
x-ms-office365-filtering-correlation-id: cc7aa887-873a-4f2b-67c5-08db3a8ee010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XqxmTTYjCAAawy3KXdNNI+uJ1AdNkH1Z0zhi/NKHe0+UiKOu25+x2GmhfAFqDss3xwYcM7rdKTrmKnJIHnSkgQB8QOm7v7OfqcsyQntM9zP/nz5BtOYzAleGW9DptEWTmG9p1ho0MuWKkNJs3q8oonDOz9IwOD6kuHJHukvPmHCYPXV7qU9gdJ1xPdhW189lvlbSEpmRR3Rzrlc6TEdGOCisvTMWHbafbokhBsNz4dRT8Y7jfuS2YX2V6QAKeqbzwiVK/CjJcsyPft1Yx+cip9mIFvbctxMh+slfF+MUuO+sg2NoyHftPrhmd/7mGE7LsfGWx5aeql2TMjRFHe4SbuVE07wL8ptu+tmuqNL2U4AhTtbgeWo14ppSYvne/m1zo/VISklxWw2T3McMohv2U0OmP6dANEzUI7EipYGT/5zTQOAnEQp+mscz1fpoxi+WzGIpz5Rx86w6MuzVcCkXT4VxVjxCz2FdJ53ZdCoaRxH7L4zSUmuSGH3hEph9qKpS7LYGLLplNKChyvgQXVbETFIL25eCrlAkFW25FmnqHYJmYc2MHhh1y69sM8jQs7V7fzDqxwG8gEsRTvS18DK4azPBxo5ckl34AbASExpRr3i6wsPk1wxEZTILqHF5XAF5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(71200400001)(478600001)(7696005)(33656002)(55016003)(83380400001)(122000001)(38100700002)(86362001)(38070700005)(2906002)(6636002)(110136005)(53546011)(6506007)(316002)(186003)(9686003)(26005)(5660300002)(41300700001)(64756008)(66446008)(8936002)(66476007)(8676002)(66556008)(52536014)(76116006)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TyyCyALtignNRY1KmSp2E///Bqujk4Ayjd/5DQZ+hysT94uyEM+UfuhhfGYs?=
 =?us-ascii?Q?/Cpr1vl6pBx+NH3jImWCHYuYEkLtvHSH+P3agMZKmv4J/OKY7crrxKrldGtm?=
 =?us-ascii?Q?LjedVUupXzZHhVe5J1surEewROrDNt2PwvDAOGo+IIZdWB87/XStz1rXfy6u?=
 =?us-ascii?Q?wKAJXZt0r+wH45iufpfurVeTfquuFQKwK56801jx1Bvt6fVklLk00Pi3bXMm?=
 =?us-ascii?Q?ykjeI0EZ1XSbwXiJ4xDGBhD7kJL2V23phJnK/9Wj13kc8l4ag44tBJ1Mfqq1?=
 =?us-ascii?Q?pzHl4WzeY5X6BZbvZQVv69uC9FIzniGpuDzb+68WDgjG1IozXCXeMjp/624p?=
 =?us-ascii?Q?IBI5Om3MXjkSUleHZjmn5NrjDQTrJ0Q3gCdUsZBak7rwDeCYIDm54lT93b0d?=
 =?us-ascii?Q?jify4WLBswbndRvqs1MpMYqr6VhDHa7Db32ENqkUTC+M14xLjqHhVd2PunVb?=
 =?us-ascii?Q?csU/YrM6nbWBMuVeq6RrLSQwb4//AsiItFb8AD2Z9mAz2wOkPy21LDqOuaw+?=
 =?us-ascii?Q?PjBCxOuc4LsFimL+oSByWLHA3JyHszaQjX9C0sfTCly9ZvhED8v4r6XB0ki5?=
 =?us-ascii?Q?/fURd4bTTMBomktrBwoScek8RSjl07269Rry3H4jHD1IzQeZTKHMpUA2C6Ul?=
 =?us-ascii?Q?xc/ra9R6Ohh1TQW+nxi7e44jBUDwVfn6HMVCahIzqWwTkWT38rdySD+NbMZC?=
 =?us-ascii?Q?aTTeBk4rgCCY8qHw67x+zp+GdyZZOuYLTg0pMBPwtOI6o2mvRBRZRU8Q3Q7d?=
 =?us-ascii?Q?B4yH68rOXRfTzBU+m1+AUd4iiJXIoChKtlM03N3GgpSTaF4cG/NEU8GK+/zy?=
 =?us-ascii?Q?duJQP44U9fISYLKPIsBicDqboSurh26xVQ5IXymnWnyksz1Pp1/4rOCQecm7?=
 =?us-ascii?Q?M2qctBSKHXGTm/n5fQBHGNQAtcy0MQnKq3X+a8gX6rc6J2NaeRqMn/S4YcFE?=
 =?us-ascii?Q?Shk82s0nHuRITDN0HT1zk6TjbIRF0kObQJVUzKBLGMPIpZ8iEuZVqpOS/0rw?=
 =?us-ascii?Q?r0eFVCLi5vrzgFqhC5aE2zy1FlQn7XOgxvFRalttSkd8+sXxjtXgtTLqX4Vx?=
 =?us-ascii?Q?z/rVGZ4LhHB7YwxRBrnixxrBL78OPRYE+vQAuTmjiuYd4uTCcvRg/+SMWZFl?=
 =?us-ascii?Q?HS1K31GZ/c54pr05+cUO0stR8rqZ+d0x1FIVtgUtEeht5540eSK0QDksblRL?=
 =?us-ascii?Q?cUBZ/g05mU4RWRwObr/CYNrrGd5yVJd1qYA3R66B93LzpUFHrx96SLJMHvKM?=
 =?us-ascii?Q?hva+gdLUvAZsPV8PpuB5oGkfk1i0+/BLTV3dtMslvxvZkuvxMo+HZJof6h55?=
 =?us-ascii?Q?DGm+ubhzq24swNhkXB48nrovp5aJaK440iP8BvlMsJ+yK20kfN0Fm1tP17Aa?=
 =?us-ascii?Q?e3fgDtxCn4rBLZiMSTEozvz+pg3oBmEaO11w4o0mDy0BSgObnvwbDZcvtzIQ?=
 =?us-ascii?Q?UD1gRZVAlDbOfkxmUVGac94IsTQCxMcBjTGf0W+QMgKEWNs0E8+J0erqcYom?=
 =?us-ascii?Q?BigtcGpmo/dN/hjR9Oew2Yl2lF9lx7DkxgWsdcpt9J4rreJhY5lRMvQgctmr?=
 =?us-ascii?Q?LvmQtFXditY8wRHzn2s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7aa887-873a-4f2b-67c5-08db3a8ee010
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 13:15:52.1434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRNGupYtDYLErnSKf4jWVtHlb1POppCglvsNYIwtvaMgXFYHsezvwPdGOxzpxLTM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Monday, April 10, 2023 1:36 PM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Zuo, Jerry
> <Jerry.Zuo@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH v2] drm/amd/display: Add logging for DP link traning
> Test Pattern Seqeunces
>=20
> [AMD Official Use Only - General]
>=20
>=20
>=20
> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Monday, April 10, 2023 11:02 PM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Zuo, Jerry
> <Jerry.Zuo@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>
> Subject: [PATCH v2] drm/amd/display: Add logging for DP link traning Test
> Pattern Seqeunces
>=20
> Add some more logging for DP link traning test pattern seqeunces for bett=
er
> debugging.
>=20
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>=20
>  - it is better to use : instead of \n, following the log format in defau=
lt section
> (Jerry)
>  - seems no need to print dpcd_tr_pattern if it is already mentioned in t=
he
> string (Jerry)
>=20
>  .../drm/amd/display/dc/link/protocols/link_dp_training.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git
> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> index 70fc0ddf2d7e..265233979cf8 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> @@ -212,27 +212,36 @@ enum dpcd_training_patterns
>=20
>  	switch (pattern) {
>  	case DP_TRAINING_PATTERN_SEQUENCE_1:
> +		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern
> TPS1\n",
> +__func__);
>  		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_1;
>  		break;
>  	case DP_TRAINING_PATTERN_SEQUENCE_2:
> +		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern
> TPS2\n",
> +__func__);
>  		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_2;
>  		break;
>  	case DP_TRAINING_PATTERN_SEQUENCE_3:
> +		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern
> TPS3\n",
> +__func__);
>  		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_3;
>  		break;
>  	case DP_TRAINING_PATTERN_SEQUENCE_4:
> +		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern
> TPS4\n",
> +__func__);
>  		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_4;
>  		break;
>  	case DP_128b_132b_TPS1:
> +		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b
> training pattern
> +TPS1\n", __func__);
>  		dpcd_tr_pattern =3D DPCD_128b_132b_TPS1;
>  		break;
>  	case DP_128b_132b_TPS2:
> +		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b
> training pattern
> +TPS2\n", __func__);
>  		dpcd_tr_pattern =3D DPCD_128b_132b_TPS2;
>  		break;
>  	case DP_128b_132b_TPS2_CDS:
> +		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b
> training pattern TPS2 CDS\n",
> +					__func__);
>  		dpcd_tr_pattern =3D DPCD_128b_132b_TPS2_CDS;
>  		break;
>  	case DP_TRAINING_PATTERN_VIDEOIDLE:
> +		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern
> videoidle\n",
> +__func__);
>  		dpcd_tr_pattern =3D DPCD_TRAINING_PATTERN_VIDEOIDLE;
>  		break;
>  	default:
> --
> 2.25.1
