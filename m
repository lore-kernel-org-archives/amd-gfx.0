Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2CFE8FDB3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD3F10E07D;
	Tue,  3 Oct 2023 20:38:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1423510E07D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juLOCnyZrCMryEEtCo6fLQhZnRp5zQE7/fV5Ve8ITsz1ZO/MXiEOoGS322ONTw82qfB9gyieh0UfTJCbOVpq0DxoUnepVYaDWcv93Gm0l1FoAL+mP0r8gkER9uyQ6UxxiVFOG6PUVBgSJVyl6M4iyA0QU3ydcOawC76h/k+WqAgibpdScYvADX45yDz6SH57uzToiO0V9lJ9p3ou8SM5Jztjrx3F9Bv8A1lzmAMSJExhi1VRqaVlSYCZPM+Ee8+PjPUyR3p00gqdXVA2SCLbJKkaBnF/xkn/YQA1rBWtSqfk+LwAcnc9ksPcPwCbeJFPMQR5nbDU7LlLMtcktixF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbzyqa0jCXNGspmHMwU9Iolozn/RimflHI3kO8kYH50=;
 b=JI9rZJGkduzp16hDTCQGZ5F7RYM2/hNPUZBlbAeJA42Ka2wSwCfm9zGBcifCEn98fidx1xWjn02YIMLHcNTMfRUGCl0+ecyeOcPYjt2dpSSm3xmE/kyrbyzMcDyJh6Hq4CJUHN/02Ssh1s7AJOHeYr1gLFYY8K0FF9UmGNLRsZZJdWBEu2YY9vtJabocg4iPPFw9tuR4UlMgoEszOi8az/kFyMYq1DtVCkpnL4NaBq+zTYFpb2FHsOBy9U9v+xghfSTaueCJYYAqLibA/tfgVND6NBKZUZ16GcjLZ+7/f+uwjQZCtm7K5LAxGt40WVabLw7zdhiXoYS0tdFZa4assA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbzyqa0jCXNGspmHMwU9Iolozn/RimflHI3kO8kYH50=;
 b=GEz40hP15HWWtvx4I+oHQVwLXCx+26UU07K0ia5RsGVfeRWfatC2vbHe3ahaayLAq4nL4bERHuOm5X4TN7B2+e/6mCnhikFGzqgxt+NS6OcfDqLq8nzM2YiyuQ+jVInDI9b8p1cUFDqnb3laiJT1/lF75J8iiTgKBgpEAN65DI8=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 20:38:35 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::4a17:b056:be46:6e58]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::4a17:b056:be46:6e58%4]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 20:38:35 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Topic: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Index: AQHZ9VihCmnTItEhi0W/ARmiJPwWwLA4LUKOgAACTICAAACuqIAABPAAgAAW99CAADTIAIAABzkT
Date: Tue, 3 Oct 2023 20:38:35 +0000
Message-ID: <PH8PR12MB72798A6AAD1F9311E7A65CD1F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20231002174754.1596197-1-ivlipski@amd.com>
 <PH8PR12MB7279E1B7634AE630985E4E2EF9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <284d3f39-071c-4451-839e-8840aecfc2a7@amd.com>
 <PH8PR12MB7279526F77BBC201BA660529F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <8fc58d31-a882-46b7-8852-c54a997af7fa@amd.com>
 <PH8PR12MB727924F9B244B9526CFC11F4F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <PH7PR12MB79396AAB927744AD01753279E7C4A@PH7PR12MB7939.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB79396AAB927744AD01753279E7C4A@PH7PR12MB7939.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T20:38:34.895Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|IA1PR12MB8221:EE_
x-ms-office365-filtering-correlation-id: 44270aed-bb1a-474b-89cf-08dbc450b75f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNKIoLkd+zEsQ6/q+KeiYivlikHxfr+OSaRgYFVlC4nZDNnJrN6PXk/GPbEVQYr7GIDq57HYzozMaagLk1QQ04y0YFY84dUvDad0m3CFgp55wkRUmQOEkENwOrjfLn2JvBJq3saLDFZ3fc2DttyN7pFO/IcYyckPnyUFOAEzx8SXOJYjh4PtU3EUiNo+W6AnjofN2tcb5I8EzbqQp+n+ZheAM3eC2iLiM6SshArjrQ7F5aWBhlL7wtPrWdndDdWw2giUtX4PlhEszDIEIrocXQ2zAlexvQ2KIBYfMMqEumV1INriWypexdX3A8OLHb4/4RHYeKowtHYqZUwzmfWuPFjYXXCpkaRZvkzjSfqnlRnxIWUrf7UQ1XH6Mx0TFDC0TqQiS8ki5+IylhWbkxGXwG4CP8alR7ny97ZE9JZNRk/G5A5GgM0hiUQaqe9an6FtIiOFm5aKzmgxJAnZdsKnGhIx+KnRUzRx1qY771R+5LeB3Yeba3VfvtGR+hhj+IL7Vv8ukT1rWgFH7JEMh3lLQPLaRqqH3QAc9AgzkMCjQjWqZLnIq7+oXUYhqo/5pc9azEQhk/vLvxfHtdL7RwOt/ZAYVWEi2adsgDnwFNBBej+Hn2Oh3d3NdpZ5+GbMVqwG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(52536014)(5660300002)(9686003)(6506007)(7696005)(53546011)(86362001)(66476007)(71200400001)(66446008)(110136005)(478600001)(54906003)(91956017)(26005)(66946007)(64756008)(66556008)(76116006)(33656002)(316002)(122000001)(38070700005)(38100700002)(55016003)(83380400001)(41300700001)(4326008)(8676002)(8936002)(19627405001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6zSD0R7MLAtHbKZg4ZrEaCyAUqWPpBRpIuAQf/Zh0aQmwE5RSc14xGLyqMa5?=
 =?us-ascii?Q?eST2sEgaTPyzXP0e5NM9PDpknDQpdosQkqerE+vu+yfdOa9ixq//JXZL3Apz?=
 =?us-ascii?Q?AlY758psQVIxv0H05AL4jXYwP6Og533Y3Aex/+mszq012rYeQlNuBoh7cSj5?=
 =?us-ascii?Q?qTYgLIh0lH0pIBkeb/EuMUW/LaqCN5dvsYYsKzCfPObWjvTLSKYgXNLs5mQu?=
 =?us-ascii?Q?qIthsuyQWmMJCroyB8Zvt6bh605kv5ISYf+QX/rlmgMGlf68zXQr9TrbTCQs?=
 =?us-ascii?Q?DraQyG2H7QUZUvWJYB9H4LuN2HF+Scp2PBUFyJpFQenhKvF98wWW62kVdoHB?=
 =?us-ascii?Q?v/arppLw/DmSSaW2JXmnJiMpV8E9R+v5QLK8IDREulZ+5i1rhZgrWgyLsdTj?=
 =?us-ascii?Q?59J/Sutkg6dMRp0pPpL3uoz75jztwnASbhXXmGHLf7tQfMEZIS8Jst+v28td?=
 =?us-ascii?Q?gHwSpX2RfYsR4+9DGlZ2TKJ08SX5fS5amOS1GSF7W50Omwfz8fwwmMVazu5k?=
 =?us-ascii?Q?jTo7CIo+zJj9s9/OUOz6W+0JJCrlPmxdvLwO+UP56FprcqvmEmUcTtyRHaY6?=
 =?us-ascii?Q?+zBFrVhQ5MAH+8a9Zn1m5Dp964gaNBKwU7Figf8pbIMJrS6OAlVPl93O4e9K?=
 =?us-ascii?Q?A6unqm8XnNbbL/oSvG3W4TTXNiG2qyLA7mxqg20sac8xBv2PizltefHPj0TL?=
 =?us-ascii?Q?5h+jbDZGiQcE45wd1iByzc/xZyRZvvSKIFzd8KdBKDSghg5bgb5xGDVYONPQ?=
 =?us-ascii?Q?nuXDJWahcyamOmL0zcs0GcP/KF0x3rW4bX/ZclPQJ+zUcWhL0Pz9RMKVdl+B?=
 =?us-ascii?Q?1eytOR1AFIv+XatGCtTPhKckJzMGRaFnf8pN/SsDsc7L+UR9b++TIbc3rsjC?=
 =?us-ascii?Q?oDm+O/drZ9S2neM9TrivxY6yGaZwPcWZCsmURBFVgxYlME0edu8zPTpl1Obm?=
 =?us-ascii?Q?WLOiopAFcsAtLzVpvZ+av7xQSFklUY5Y1piHMNrQsOAlHjJgdzTA4AnFqJVn?=
 =?us-ascii?Q?RrNypAEixmTp+ELDGQQyEfcvvU4ymuLlsKyPL11aQSsmkV0hi8U+79ha/liu?=
 =?us-ascii?Q?ztwHtocEfmdUQZYc9XBckdZ0hWIEfaEVcIZyGGjkks2kP7UYqEogs1dSv6wD?=
 =?us-ascii?Q?fkQ8AWpzyjjDjgiQCcyT5g0KwJwhh59qanelissVyOSsU92QNMR+8nbsy3I7?=
 =?us-ascii?Q?6zNtLseHFPIZgXBzQoeOnpBSLF8icHaHa6oni6V6wOm5t5NgfBXmUGRwb2YZ?=
 =?us-ascii?Q?cI+lCIew7C807tzTzT6B2mM0EavlnZBRTkWJCuw6MH/RFVKEdgOcejecSKaa?=
 =?us-ascii?Q?ZVmtr5Qjl0VVLfET2rvhR2qQvsnOFHH05lTvEj/UitiPlOHpLnWjlZYwqJmB?=
 =?us-ascii?Q?gukbzmxiqu6bM1N6BNlmI+FKBZazq9p4+qlbWyOLvXdcvGGQ3IY9pqkysMFl?=
 =?us-ascii?Q?Fxcf1tRHrZifoyNVkBhbyGfDKLvGIpUndGlr6jg4P1bZH5Fgf3YPfZ2+vONH?=
 =?us-ascii?Q?nqFZ8mPlmbZNkvARakCpPqlww1AY8ETj6MSJYVcEOYdHxEXndDCi7lIFS6nJ?=
 =?us-ascii?Q?3i1UsRomcMoorgfZTg0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB72798A6AAD1F9311E7A65CD1F9C4APH8PR12MB7279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44270aed-bb1a-474b-89cf-08dbc450b75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 20:38:35.5429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +y48eD8I8IUe0/ogrPljiiynHe23QN3KUFpcMUAVZmhzUy2U2E2uUsnNHf36LYd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH8PR12MB72798A6AAD1F9311E7A65CD1F9C4APH8PR12MB7279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

You can revert it for now, but that is a bug as replay_feature_enabled shou=
ld stop all replay related calls.
________________________________
From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Sent: October 3, 2023 4:11 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Li, Sun peng (Leo) <Sun=
peng.Li@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.=
org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.c=
om>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static s=
creen use cases"


[AMD Official Use Only - General]

Setting 'replay_feature_enabled' to false did not fix the issue, and PSR co=
uld not be enabled on an eDP without Replay support (Sink support 0x03 in m=
y case).


Thank you,

Ivan Lipski



________________________________
From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Sent: October 3, 2023 1:03 PM
To: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.c=
om>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static s=
creen use cases"


[AMD Official Use Only - General]

yes, it will disable replay.
________________________________
From: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Sent: October 3, 2023 11:40 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; LIPSKI, IVAN <IVAN.LIPS=
KI@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.c=
om>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static s=
creen use cases"



On 2023-10-03 11:23, Lakha, Bhawanpreet wrote:
> [AMD Official Use Only - General]
>
>
> Why not just set replay_feature_enabled =3D true; to false?

Would that be the right fix? If so, we can send out a patch
with that instead.

- Leo

> ------------------------------------------------------------------------
> *From:* Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> *Sent:* October 3, 2023 11:20 AM
> *To:* Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; LIPSKI, IVAN
> <IVAN.LIPSKI@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza
> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>
> *Subject:* Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for
> static screen use cases"
>
>
> On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:
>> [AMD Official Use Only - General]
>>
>>
>> Any reason for reverting this instead of looking into
>> "amdgpu_dm_setup_replay()" and "replay_feature_enabled" to see why reply
>> is being enabled?
>
> It causes a regression in amd_psr. Unless there's a quick fix, we should
> revert for now. It sounds like this can break existing support for
> PSR/PSR SU.
>
> Acked-by: Leo Li <sunpeng.li@amd.com>
>
> - Leo
>
>>
>> Bhawan
>> ------------------------------------------------------------------------
>> *From:* LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> *Sent:* October 2, 2023 1:47 PM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza
>> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
>> Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
>> Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; LIPSKI, IVAN
>> <IVAN.LIPSKI@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> *Subject:* [PATCH v2] Revert "drm/amd/display: Enable Replay for static
>> screen use cases"
>> From: Ivan Lipski <ivlipski@amd.com>
>>
>> This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.
>>
>> V2: Reword commit message
>>
>> [WHY]
>> This commit caused regression in which eDP's with PSR support,
>> but no Replay support (Sink support <=3D 0x03), failed enabling PSR
>> and all IGT amd_psr tests.
>>
>> [HOW]
>> Reverted the patch.
>>
>> Signed-off-by: Ivan Lipski <ivlipskI@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
>>   drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>>   3 files changed, 1 insertion(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 32156609fbcf..f69b2e9ecd98 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -66,7 +66,6 @@
>>   #include "amdgpu_dm_debugfs.h"
>>   #endif
>>   #include "amdgpu_dm_psr.h"
>> -#include "amdgpu_dm_replay.h"
>>
>>   #include "ivsrcid/ivsrcid_vislands30.h"
>>
>> @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>           enum dc_connection_type new_connection_type =3D dc_connection_=
none;
>>           const struct dc_plane_cap *plane;
>>           bool psr_feature_enabled =3D false;
>> -       bool replay_feature_enabled =3D false;
>>           int max_overlay =3D dm->dc->caps.max_slave_planes;
>>
>>           dm->display_indexes_num =3D dm->dc->caps.max_streams;
>> @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>                   }
>>           }
>>
>> -       if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
>> -               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>> -               case IP_VERSION(3, 1, 4):
>> -               case IP_VERSION(3, 1, 5):
>> -               case IP_VERSION(3, 1, 6):
>> -               case IP_VERSION(3, 2, 0):
>> -               case IP_VERSION(3, 2, 1):
>> -               case IP_VERSION(3, 5, 0):
>> -                       replay_feature_enabled =3D true;
>> -                       break;
>> -               default:
>> -                       replay_feature_enabled =3D amdgpu_dc_feature_mas=
k
>> & DC_REPLAY_MASK;
>> -                       break;
>> -               }
>> -       }
>>           /* loops over all connectors on the board */
>>           for (i =3D 0; i < link_cnt; i++) {
>>                   struct dc_link *link =3D NULL;
>> @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>
>> amdgpu_dm_update_connector_after_detect(aconnector);
>>                                   setup_backlight_device(dm, aconnector)=
;
>>
>> -                               /*
>> -                                * Disable psr if replay can be enabled
>> -                                */
>> -                               if (replay_feature_enabled &&
>> amdgpu_dm_setup_replay(link, aconnector))
>> -                                       psr_feature_enabled =3D false;
>> -
>>                                   if (psr_feature_enabled)
>>                                           amdgpu_dm_set_psr_caps(link);
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index fb51ec4f8d31..440fc0869a34 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -29,7 +29,6 @@
>>   #include "dc.h"
>>   #include "amdgpu.h"
>>   #include "amdgpu_dm_psr.h"
>> -#include "amdgpu_dm_replay.h"
>>   #include "amdgpu_dm_crtc.h"
>>   #include "amdgpu_dm_plane.h"
>>   #include "amdgpu_dm_trace.h"
>> @@ -124,12 +123,7 @@ static void vblank_control_worker(struct
>> work_struct *work)
>>            * fill_dc_dirty_rects().
>>            */
>>           if (vblank_work->stream && vblank_work->stream->link) {
>> -               /*
>> -                * Prioritize replay, instead of psr
>> -                */
>> -               if
>> (vblank_work->stream->link->replay_settings.replay_feature_enabled)
>> -                       amdgpu_dm_replay_enable(vblank_work->stream, fal=
se);
>> -               else if (vblank_work->enable) {
>> +               if (vblank_work->enable) {
>>                           if
>> (vblank_work->stream->link->psr_settings.psr_version <
>> DC_PSR_VERSION_SU_1 &&
>>
>> vblank_work->stream->link->psr_settings.psr_allow_active)
>>
>> amdgpu_dm_psr_disable(vblank_work->stream);
>> @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct
>> *work)
>>   #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>>
>> !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
>>   #endif
>> -
>> vblank_work->stream->link->panel_config.psr.disallow_replay &&
>>
>> vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>>                           amdgpu_dm_psr_enable(vblank_work->stream);
>>                   }
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 314fd44ec018..ce75351204bb 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
>>           DC_DISABLE_LTTPR_DP2_0 =3D (1 << 6), //0x40, disabled by defau=
lt
>>           DC_PSR_ALLOW_SMU_OPT =3D (1 << 7), //0x80, disabled by default
>>           DC_PSR_ALLOW_MULTI_DISP_OPT =3D (1 << 8), //0x100, disabled by
>> default
>> -       DC_REPLAY_MASK =3D (1 << 9), //0x200, disabled by default for dc=
n
>> < 3.1.4
>>   };
>>
>>   enum DC_DEBUG_MASK {
>> @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
>>           DC_DISABLE_PSR =3D 0x10,
>>           DC_FORCE_SUBVP_MCLK_SWITCH =3D 0x20,
>>           DC_DISABLE_MPO =3D 0x40,
>> -       DC_DISABLE_REPLAY =3D 0x50,
>>           DC_ENABLE_DPIA_TRACE =3D 0x80,
>>   };
>>
>> --
>> 2.34.1
>>

--_000_PH8PR12MB72798A6AAD1F9311E7A65CD1F9C4APH8PR12MB7279namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
You can revert it for now, but that is a bug as replay_feature_enabled shou=
ld stop all replay related calls.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> LIPSKI, IVAN &lt;IVAN=
.LIPSKI@amd.com&gt;<br>
<b>Sent:</b> October 3, 2023 4:11 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Li, Sun pe=
ng (Leo) &lt;Sunpeng.Li@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-=
gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.co=
m&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsu=
an (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static screen use cases&quot;</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0000FF=
; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,Arial,Helvetic=
a,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Setting 'replay_feature_enabled' to false did not fix the issue, and PSR co=
uld not be enabled on an eDP without Replay support (Sink support 0x03 in m=
y case).<br>
</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_Signature">
<div>
<p>Thank you,</p>
<p>Ivan Lipski</p>
<p>&nbsp;</p>
</div>
</div>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lakha, Bhawanpreet =
&lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> October 3, 2023 1:03 PM<br>
<b>To:</b> Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; LIPSKI, IVAN &lt;=
IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.fr=
eedesktop.org&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.co=
m&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsu=
an (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static screen use cases&quot;</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0000FF=
; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Calibri,Arial,Helvet=
ica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
yes, it will disable replay. <br>
</div>
<div id=3D"x_x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Li, Sun peng (Leo=
) &lt;Sunpeng.Li@amd.com&gt;<br>
<b>Sent:</b> October 3, 2023 11:40 AM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; LIPSKI, IV=
AN &lt;IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.co=
m&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsu=
an (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static screen use cases&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText"><br>
<br>
On 2023-10-03 11:23, Lakha, Bhawanpreet wrote:<br>
&gt; [AMD Official Use Only - General]<br>
&gt; <br>
&gt; <br>
&gt; Why not just set replay_feature_enabled =3D true; to false?<br>
<br>
Would that be the right fix? If so, we can send out a patch<br>
with that instead.<br>
<br>
- Leo<br>
<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;<br>
&gt; *Sent:* October 3, 2023 11:20 AM<br>
&gt; *To:* Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; LIPSKI, IV=
AN <br>
&gt; &lt;IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org <br>
&gt; &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc:* Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za <br>
&gt; &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; <br>
&gt; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsuan=
 (Tom) <br>
&gt; &lt;ChiaHsuan.Chung@amd.com&gt;<br>
&gt; *Subject:* Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for <br>
&gt; static screen use cases&quot;<br>
&gt; <br>
&gt; <br>
&gt; On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:<br>
&gt;&gt; [AMD Official Use Only - General]<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; Any reason for reverting this instead of looking into <br>
&gt;&gt; &quot;amdgpu_dm_setup_replay()&quot; and &quot;replay_feature_enab=
led&quot; to see why reply <br>
&gt;&gt; is being enabled?<br>
&gt; <br>
&gt; It causes a regression in amd_psr. Unless there's a quick fix, we shou=
ld<br>
&gt; revert for now. It sounds like this can break existing support for<br>
&gt; PSR/PSR SU.<br>
&gt; <br>
&gt; Acked-by: Leo Li &lt;sunpeng.li@amd.com&gt;<br>
&gt; <br>
&gt; - Leo<br>
&gt; <br>
&gt;&gt; <br>
&gt;&gt; Bhawan<br>
&gt;&gt; ------------------------------------------------------------------=
------<br>
&gt;&gt; *From:* LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<br>
&gt;&gt; *Sent:* October 2, 2023 1:47 PM<br>
&gt;&gt; *To:* amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.=
org&gt;<br>
&gt;&gt; *Cc:* Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz,=
 Hamza <br>
&gt;&gt; &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@=
amd.com&gt;; <br>
&gt;&gt; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Deucher, Ale=
xander <br>
&gt;&gt; &lt;Alexander.Deucher@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.=
Li@amd.com&gt;; <br>
&gt;&gt; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; LIPSKI, IV=
AN <br>
&gt;&gt; &lt;IVAN.LIPSKI@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&=
gt;<br>
&gt;&gt; *Subject:* [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static <br>
&gt;&gt; screen use cases&quot;<br>
&gt;&gt; From: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
&gt;&gt; <br>
&gt;&gt; This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.<br>
&gt;&gt; <br>
&gt;&gt; V2: Reword commit message<br>
&gt;&gt; <br>
&gt;&gt; [WHY]<br>
&gt;&gt; This commit caused regression in which eDP's with PSR support,<br>
&gt;&gt; but no Replay support (Sink support &lt;=3D 0x03), failed enabling=
 PSR<br>
&gt;&gt; and all IGT amd_psr tests.<br>
&gt;&gt; <br>
&gt;&gt; [HOW]<br>
&gt;&gt; Reverted the patch.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Ivan Lipski &lt;ivlipskI@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; &nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ---=
----------------<br>
&gt;&gt;&nbsp; &nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_crtc.c&nbsp;&nbsp;=
&nbsp; |&nbsp; 9 +-------<br>
&gt;&gt;&nbsp; &nbsp;drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 2 --<br>
&gt;&gt;&nbsp; &nbsp;3 files changed, 1 insertion(+), 33 deletions(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c <br=
>
&gt;&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; index 32156609fbcf..f69b2e9ecd98 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; @@ -66,7 +66,6 @@<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_debugfs.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#endif<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
&gt;&gt; -#include &quot;amdgpu_dm_replay.h&quot;<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&gt;&gt; <br>
&gt;&gt; @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(s=
truct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_con=
nection_type new_connection_type =3D dc_connection_none;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struc=
t dc_plane_cap *plane;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool psr_fe=
ature_enabled =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool replay_feature_enabled =
=3D false;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_ove=
rlay =3D dm-&gt;dc-&gt;caps.max_slave_planes;<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;disp=
lay_indexes_num =3D dm-&gt;dc-&gt;caps.max_streams;<br>
&gt;&gt; @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(=
struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_dc_debug_mask &=
amp; DC_DISABLE_REPLAY)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 4):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 5):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 6):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 2, 0):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 2, 1):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 5, 0):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_=
feature_enabled =3D true;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_=
feature_enabled =3D amdgpu_dc_feature_mask <br>
&gt;&gt; &amp; DC_REPLAY_MASK;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* loops ov=
er all connectors on the board */<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D =
0; i &lt; link_cnt; i++) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *link =3D NULL;<br>
&gt;&gt; @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(=
struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; amdgpu_dm_update_connector_after_detect(aconnector);<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_backlight_d=
evice(dm, aconnector);<br>
&gt;&gt; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable psr if replay can =
be enabled<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (replay_feature_enabled &amp;&a=
mp; <br>
&gt;&gt; amdgpu_dm_setup_replay(link, aconnector))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; psr_feature_enabled =3D false;<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psr_feature_e=
nabled)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_set_psr_caps(link);<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.=
c <br>
&gt;&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; index fb51ec4f8d31..440fc0869a34 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; @@ -29,7 +29,6 @@<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;dc.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
&gt;&gt; -#include &quot;amdgpu_dm_replay.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_crtc.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_plane.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_trace.h&quot;<br>
&gt;&gt; @@ -124,12 +123,7 @@ static void vblank_control_worker(struct <br>
&gt;&gt; work_struct *work)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fil=
l_dc_dirty_rects().<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br=
>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vblank_=
work-&gt;stream &amp;&amp; vblank_work-&gt;stream-&gt;link) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Prioritize replay, instead of psr<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if <br>
&gt;&gt; (vblank_work-&gt;stream-&gt;link-&gt;replay_settings.replay_featur=
e_enabled)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_replay_enable(vblank_work-&gt;stream, false);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else if (vblank_work-&gt;enable) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (vblank_work-&gt;enable) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; if <br>
&gt;&gt; (vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_version &lt;=
 <br>
&gt;&gt; DC_PSR_VERSION_SU_1 &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_allow_active)=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; amdgpu_dm_psr_disable(vblank_work-&gt;stream);<br>
&gt;&gt; @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_=
struct <br>
&gt;&gt; *work)<br>
&gt;&gt;&nbsp; &nbsp;#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; !amdgpu_dm_crc_window_is_activated(&amp;vblank_work-&gt;acrtc-&gt;=
base) &amp;&amp;<br>
&gt;&gt;&nbsp; &nbsp;#endif<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;stream-&gt;link-&gt;panel_config.psr.disallow_repl=
ay &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;acrtc-&gt;dm_irq_params.allow_psr_entry) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_dm_psr_enable(vblank_work-&gt;stream);<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/include/amd_shared.h <br>
&gt;&gt; b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; index 314fd44ec018..ce75351204bb 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
LTTPR_DP2_0 =3D (1 &lt;&lt; 6), //0x40, disabled by default<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLO=
W_SMU_OPT =3D (1 &lt;&lt; 7), //0x80, disabled by default<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLO=
W_MULTI_DISP_OPT =3D (1 &lt;&lt; 8), //0x100, disabled by <br>
&gt;&gt; default<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_REPLAY_MASK =3D (1 &lt;&l=
t; 9), //0x200, disabled by default for dcn <br>
&gt;&gt; &lt; 3.1.4<br>
&gt;&gt;&nbsp; &nbsp;};<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;enum DC_DEBUG_MASK {<br>
&gt;&gt; @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
PSR =3D 0x10,<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FORCE_SU=
BVP_MCLK_SWITCH =3D 0x20,<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
MPO =3D 0x40,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_REPLAY =3D 0x50,<=
br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_ENABLE_D=
PIA_TRACE =3D 0x80,<br>
&gt;&gt;&nbsp; &nbsp;};<br>
&gt;&gt; <br>
&gt;&gt; -- <br>
&gt;&gt; 2.34.1<br>
&gt;&gt; <br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH8PR12MB72798A6AAD1F9311E7A65CD1F9C4APH8PR12MB7279namp_--
