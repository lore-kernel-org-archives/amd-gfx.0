Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFD7C25B4E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 16:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DAB10E2B6;
	Fri, 20 Jan 2023 16:36:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930D610E2B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 16:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeMfclDzo3Fi5qC1Uo5Rm7pzvIibAxG/rpStrm259/L5369f+Xc9Q3afl5KwGl75oJMkR9LwQqBbTDOMdPm1cPjTl4sxXuWPKXcYkAS4TpL0YAnMWm50vIHI1BS8rW+0BBK9hQVAyUOV7w5r6u4MtJNwNSWZ6sQjSzxlf9on7A1Q0gerFIkzEiienGid2sd60Az5gq/QnutXb7pUmLQL5oMkUCpAMYjSbf9BC+qSt0QpMguyOYQYRptg0kWw53+aaPvr1pMkNzYVnXvnsJm6gmAn4ck6tW2Jc7lfgJDTBohlqsfaO7Vp50H+9BMVfa2/SFFBIpxfn0VrRMcTj/4WWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FR+XezC08DTCljbuYh9ZdXSWsTcyKlA3Q8wnLgOufQ=;
 b=ZBvrwp80tPWmswSKE2FsZj36fxirBqnXrtjWtgQAESwkSRS++NiLkrkF9KGqqsxxZKDENmRPI8VCPsfG85SYYqKZLIQELeJaCtQNc7+oLkFDMHbohb0/97T5PTscAC9ATUAtrFHG2SdO3vPScqFaVGM1J8wc0m/W4mNcmlao8RtAWMAFjEGNWHoHqIiZa5UmpES6JejHw4l1YRwtQr23fJFrPCVnGqleUL8607emr/M+Aet28ESnSUtUm8LHCz8k6tmts1K10CttceNOu5kfpD3vt+4GiGqehc/KdBssyK6aoRLGft3lKdJblC3F2FrDJ6Fi7bTzf8EIYC24ijFUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FR+XezC08DTCljbuYh9ZdXSWsTcyKlA3Q8wnLgOufQ=;
 b=CU3cZkUt2Wys65558+1Jgny10ZGa515Aqg6bxgtHPvpWqxvJVqKiF92XNcLh4dZVKA7d84CRudSWjRQRx6Y2yCs3kZPwwNMalCfc9DHZTGcfea47Lb8NTlctE6XLGRAuh2RFJtR/fM/jOzwyHY6o+orG79NgvN89hj80pYOaOFA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 16:35:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 16:35:58 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features disablement
 for SMU 13.0.4/11
Thread-Topic: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features disablement
 for SMU 13.0.4/11
Thread-Index: AQHZLOxoTZ/XB/XAu0+P/bz55SEkja6nf/5A
Date: Fri, 20 Jan 2023 16:35:58 +0000
Message-ID: <MN0PR12MB61011985AFE482A39D0828CFE2C59@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230120162858.1580755-1-tim.huang@amd.com>
 <20230120162858.1580755-2-tim.huang@amd.com>
In-Reply-To: <20230120162858.1580755-2-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-20T16:35:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7255148b-4bc8-4143-a207-365f1ace7ceb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-20T16:35:56Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 844400c5-13eb-4419-86ff-9500cae96a2e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB6157:EE_
x-ms-office365-filtering-correlation-id: f72ee4c2-60f7-48a7-77ec-08dafb0468f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayeV+WIGFVHan3GECSQ+nIXlwe4vjP/GRXa6gYJSGA0MJHL0bugbYwGCPtWevmUilrnwE7ijjI/0kfwrXtxp4Eiry80Fj9BCiCoXFDbK0Dr1UQK4A9OOZjl/IcO6NbiW+j1aIHURTwGAbXoiyhlYrHYcTbOJwMHIumvfPE5sizR+o9j6Kb4WLz7sD74FZE2cWpuKMbniKBE4lnY2QX/eDKo5CnHobsQlqSRGc8X+gurTCr/3U0Sfr8iqDdj6azQN8cGPejM9FINXNe8fJeVCg54Yqq3Gmj3LkAiKJoHyLZGH+0IVvYcC1H+84ue8Rx7MgRHukbYjG4Ie8qCnZ3zh7b6pTN0dDXpvavSrRn7L4oNZIoSHttoA/gRy9qAeHlGpnUvveVFq+w/BFBwUdC4ueeE8blirnNBNqwlyPLCwQH+QkQ/0T+h5d/zTLil07rJvu3dae6atkRtsXNcpVfcB0tk5TIixYIpkWWR3lpWui4duaaCEd5AbjsthDc4KTDZDo5zhAcNe5iTLjN3HNNmHXI+hwALXUT5W1w5oy+oP3DyC52Wrno7y2tWusjqiruqubbQI9aB5546djOyzK1sef6gaOJj7dSTF0D8FakeIDRX6YX0cOKzpjPP5F/oRFDUaRjMB9GNghFByWZ843MZuKgz0hMOEtvyQ3+XhS9NQ1+q3UsOePiV36tCSJZMwEVi5StN8P72EHUhYWrRMsdYwjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(5660300002)(8936002)(4326008)(66556008)(66446008)(66476007)(64756008)(8676002)(66946007)(52536014)(76116006)(71200400001)(38100700002)(122000001)(6506007)(26005)(186003)(2906002)(110136005)(9686003)(54906003)(316002)(7696005)(478600001)(53546011)(83380400001)(41300700001)(38070700005)(55016003)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bNePd4TeQ5uOsfBVeSXuFZp+2fDffRfduE4kq2xIIR1CgJABQr/lQZ//dVEP?=
 =?us-ascii?Q?N8AYjBYK4AmVG1vS8SKu9wkd/g/jCMzg0fmhHBdJwVU1thoTriNylz01z/Sg?=
 =?us-ascii?Q?Mv6ivhAZWEEDmtQBWa4RW8vEKyXk4z+uz9aedTLLnFOWIfGmhjTjGArA/Bhe?=
 =?us-ascii?Q?B7iGHIqS7c42pt2NUkEtOS1a8+sdImyhfH7Ncm9xX8BNAzzVFnj5ZvsLccCh?=
 =?us-ascii?Q?JYuaJmtwjetqekWjy8ehHxwsRlt/z7NPgzNH3SxlGN1UiXxAsi+BRjSdOVyl?=
 =?us-ascii?Q?SYVp/aKpOUMylDojo0O0euN7F36CLd8ucYu1NCWHAVKQGoATISkD2chhKZrU?=
 =?us-ascii?Q?+oBpcWM28na4Ul9qT9N8oul9HjMN8+50eteJtOkJYgZQovlxnMZ2V+J/EUan?=
 =?us-ascii?Q?Vaqu10KE9molOteoONsUlLouCMDtTHJWfT4bC9jGRHOCNVIJ6bMFfoyCRRNZ?=
 =?us-ascii?Q?e5N2nZgWkpnr+d5LuHGMsidkBUmDPDTAIsOumrCwzSV6nx8Jx2QRMHWCvE1+?=
 =?us-ascii?Q?BCER1xSvBj8f/2GiY6dhARZP8nyQtAQ/WJe7hi/VhieM4WucpwjHdiP+HQFM?=
 =?us-ascii?Q?/hl5gBhlnwm5jkxfzh5pig78XHaVwdgHYN2wB8cnPkctOK8UNHY+V9z76f34?=
 =?us-ascii?Q?9lqLgdcb9V2latPLqd9sGsDkODzpkCMKTY4KcIznCrnlYkae1qrrcLQ36wO3?=
 =?us-ascii?Q?QsX/w+KG7R1Sa+0QQOLzdyPDKmx3WThqQYznhb6HxVx76QDfAq16LX1u2/hM?=
 =?us-ascii?Q?T0h4Twtae1AF8EXwCZ4leTC2aj+pFGn4+GEabZv5rCmlx8PG9bbnhRAQ0t/G?=
 =?us-ascii?Q?Vokjj5eAbadfJxFu3jikeecfgZpjKpfxBTfveQUP6CSJYq86s4jkEvD0RKVa?=
 =?us-ascii?Q?HpLn7cryaDFZP+oigwjdkQmddWtutlM8G9OuXpLZTbyTGqzLbSsB8C9vPgkx?=
 =?us-ascii?Q?O/6mnCAlvjvWbJLvkbAlXD2sy7IHBF9kLe2PhMTusmouiOWELdhziiq5Ff6D?=
 =?us-ascii?Q?NZQFy8WQinsMwsYCis4VIPwiiomGiUdiZjWqlq7VaUAQSIle+Eh1CLvGAn8H?=
 =?us-ascii?Q?3XEQ5840/H0sk11ladb0IgkhnAmNie6EmHhQ52o7XvGva8pmkxYvj/m0dI6h?=
 =?us-ascii?Q?q5V3fD5EnIJagpY9LI2qgKZ9D31GQdQNksUHFbtKyL5MkW+J3Oqs3Ii1NOSK?=
 =?us-ascii?Q?Mv7gsY/YeNctEqIscl8sG0EVMkCH1p2qq28DlGqkftVYCokjSaKU0TpDRSur?=
 =?us-ascii?Q?MC3DAxFrOTS8q0uxumV8RnJO74Qb5EZNU5gdFURH0/wwD393kJyIEYfeJRUt?=
 =?us-ascii?Q?+thTDG1J8koszBN6VtxDXTiFPxhDkIavwNjAZZAyBimwAEj8Png2IuG+aeRB?=
 =?us-ascii?Q?yMos9ziUcjPXV3Fuk5raFvo25CN0C9deWWB23XSpIC/m7/1PGWAbcZbWUprR?=
 =?us-ascii?Q?jdD9mKSG2cLvmtryLerUPA1xi5cH3bKaNGGl/p7tvdi+6tUWLewSJcSzYm8f?=
 =?us-ascii?Q?6ua/TiFoRJxQ8wPI+MLBygcoPwt/RYaNl3zrr+qwdXr5Qt31ys3HCD9azRLE?=
 =?us-ascii?Q?K+lOORH/bOMvR0uZfYU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72ee4c2-60f7-48a7-77ec-08dafb0468f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 16:35:58.5221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEh/+GMmN34k89XHG7R3dTm4HVKjhUCkVPUku15R6bVQZYyadmHMQQ4fMxidzYREeoAM34/O1jAbtaDMXQWL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Friday, January 20, 2023 10:29
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li
> <Li.Ma@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features
> disablement for SMU 13.0.4/11
>=20
> PMFW will handle that properly. Driver involvement may cause some
> unexpected issues.
>=20
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ec52830dde24..800eb5ad1dcb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1448,6 +1448,8 @@ static int smu_disable_dpms(struct smu_context
> *smu)
>  	case IP_VERSION(13, 0, 0):
>  	case IP_VERSION(13, 0, 7):
>  	case IP_VERSION(13, 0, 10):
> +	case IP_VERSION(13, 0, 4):

To keep a consistent ordering scheme, I think IP_VERSION(13, 0, 4) should c=
ome after IP_VERION(13, 0, 0).

w/ that fixed:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

6.1 is used for IP_VERSION(13, 0, 4), so please also include
Cc: stable@vger.kernel.org #6.1

> +	case IP_VERSION(13, 0, 11):
>  		return 0;
>  	default:
>  		break;
> --
> 2.25.1
