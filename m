Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F83C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FCC110EBE6;
	Tue, 14 Dec 2021 03:50:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF3F10EBE6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvnetXr5Rpgpc3/l7HKwKaMUG9zG9c9A33washToodOUeNzqSSyTw3DTRwGuvp/Tor/yr9RV3CJW4qGpWIRHqpiGD4GOkuN4IXV/GjuJMDIhQCSQSYmkFdcyMVPw0e+UVqLklBN1+qGQe/9RxGaCR6hVQtrFz9yaJFYHCmM1cg9P44/CjZTmgiODnAtxm4zuBEs+uhAcWsUB+f+aOnkT8ZY/fNDnyEK21APv/XAoBT6tBVLa0Q/lZnMtedVHfjdOsm9HR62EJ1l+ESiUlj463igefBGfDgZJYCUATLALN7s57h6qxFJ5owVUJjSQYevac/gytf50XN2Kyu+xV76FmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Rbci03iZ5ffMJ8hc6NnJgaeTLNNWN9nUQav4kb9gY=;
 b=ZTWBwSM6CTXK8oQzBQsTiSo0voQLd681/T5YT5ffI7g5uaclbSb9DK5CCqVjrityK6NSxlzwKVwcqx0941CYvlu370nkN3hYpjwIecwPm1C4pqr9KJwUhkLq5Jhs0K19NTuUI+ZCeNXHSHuCntkDwWpvprteMNKT9MOSbbllRZ8jJBoNAvilpVz3klKmp8aKMcx8UXSpNLD4kVOEglU3ZbMQ4n6yY0UkxHfWThAjqtwnykKZ1mArROwnVTENY3knO86zg4G5MuHe1AuVjBNeN9y6gantlfhft8OtrW7CjrtryOziGfSvBERjgRLi4OT3E2Tp+oDA6x52jAB8p48oTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Rbci03iZ5ffMJ8hc6NnJgaeTLNNWN9nUQav4kb9gY=;
 b=QrHjrHVA16A1KqQdHpJlVBvKU2+EgoWz+1GhaIuZOKz7CabF8BhQzpSwLTBOCrvCXGjz3z7H8gzptCenTYT3toDxxrJA2xtaChXwHEfM5fg/wQCmWgEo1Or0JO7i3x+5D/IAF5TEEgEmyLB4Is3Xa0dTTudXNarWtyYogkhYrEc=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 14 Dec
 2021 03:50:23 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 03:50:23 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Thread-Topic: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Thread-Index: AQHX8IrJm5u3yihkwUGn4YPxjhaPO6wxWgcAgAAAHjA=
Date: Tue, 14 Dec 2021 03:50:23 +0000
Message-ID: <SA0PR12MB45102B1992F821B4D05B9D80E2759@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211214013423.801735-1-evan.quan@amd.com>
 <DM5PR12MB24697AF2CCAAFDBACF6E43C7F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24697AF2CCAAFDBACF6E43C7F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T03:49:04Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b6e49435-69b1-4ab1-8614-12eeec9f74a0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-14T03:50:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 81ffb5e4-7dae-4e97-9159-93f81c17cb92
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 983313ae-c9e5-4750-55c6-08d9beb4db91
x-ms-traffictypediagnostic: SN1PR12MB2542:EE_
x-microsoft-antispam-prvs: <SN1PR12MB2542C0A5121CB566908FD8B4E2759@SN1PR12MB2542.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iH8NaWh5DDDTyhNXQt/wry7eJt+rv2eYHuV8tYGUbFMEBoG7iS8ZOnfCgLqEDelCbQMs5d5Lalz0cGclYayRkuUxd+cPqyy+EAIgC/nhB+jBN/iq0WTxjpsdCGS0padMIzhAO4gh/B1sEq6vHcViPOMSrUXrtn39bzTnjOQSkBZW/5IJI5oeck1OHNWm5LaM2GzAG1eE/Hz0KD8dnbKxi3orn8JJ6MBxFNVvRVhblZJHaGCsAny3EPJqTpYpat8U6QbgxLZbMEdFVs9zudvUnRobF3WQbxvqtB4PDq67zkaqCeIW7Uw0s9ukgkqvk+fFRz3ZJeHWHGUixTulnWdgMeN2yhMTkQHviTAKeqYdzFQ4amnti31PKf7Ymwk0/2OSrU9QKVFJDpSlpEnNrWoYCiElW0I8x85VaN13Li7t4c5iORIrpPneku9JjYglV9nvXu8oZ3XCHaUWNDu+Eoav1h/FBiD2TZvrQ12kZCffUMELEPyEl8MiTFnD60+ub3V08E/K8+JbPTG69DMuoLYxormA0LzYjUSt7gc2PLuXPXCY9Zz4d1cAicuq8GrY2PUCG0vwuEhJr452iK1BjKQc7DxHomijZW/vpgPrv3v1XJ6kmiiR9onUvi657weDl9q9LB7Tjy3u4j8RGNuRbcXfzwTv7ou5JV3c9hTNPoVmiSr1omCOa+Kul9HHt4otsEdhI7E997wjmU9uSxZ4QRl8QKtu6WyK8Ekj9QzdeIZxdTkqjH4FtuYOdbO8CdhCTjtBgXnde5FmxIFgNMpBDbU4oS46J40Q0d8kpd5q9GwIfy8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(2906002)(64756008)(66446008)(66946007)(76116006)(38070700005)(7696005)(45080400002)(508600001)(66476007)(66556008)(52536014)(5660300002)(53546011)(8936002)(186003)(83380400001)(38100700002)(966005)(122000001)(86362001)(316002)(8676002)(33656002)(54906003)(6506007)(4326008)(55016003)(110136005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WXEQJl1dUHpJ/zO6RHA/LWGuHlu6xvylk8DTkNeUHUY/1p4Us6Vu7i3U2EG8?=
 =?us-ascii?Q?Bh56L5uClHJLHxPtfXrgzv6m5yCMPYMOWi18LvV5DH8duWxAROe/T0nFL9rw?=
 =?us-ascii?Q?S+Mu/XONQJR9ogQno3F/37X4x3Hvlo9vthsw0kPpWuh5R2b2kBptJa76wr4p?=
 =?us-ascii?Q?T4p4H2QrBzyxPFBegdmMlPdwuxf9sSD1J+XR3cohLkcVjBLijrDSV+okMfco?=
 =?us-ascii?Q?q6eVQM0QrQSoL71HCSYcB2kWFrogTwdJL9jdxC7d6KOOxj6jtbWofpGIwRLF?=
 =?us-ascii?Q?oaraT9vnsDFwrfEWXUHvzCt11IhMws20PgfqKZDu8rVTrglNI2FJDeBu1Ty7?=
 =?us-ascii?Q?9PZvrLPNSwoNTwyuu7MnwupmnmM3dHGKrrnBB8IP4BoeEo5aQ3/I1bEuoZup?=
 =?us-ascii?Q?aNsjFz9D73K2bKVn3hBoI6CvkFmb0kjlc5keLhXPkjhigSP3zdHDOVNeklBV?=
 =?us-ascii?Q?rLnlOJjExjClp09nOmNpIGbeUh0TZLaRdrkxN3SH4ukiUmA5hkFM20HaIccd?=
 =?us-ascii?Q?/ARWKmgO8u9CRasnh7k1EWQDf2FzH9n1kd7nPLMwMSb+uCkn/5XBnRam7I/Q?=
 =?us-ascii?Q?LB1Mz2nw4T5u9fdw/05XuO/gSiqDxySbeMVt5btqg3/N5fzmAwNmFVad2pym?=
 =?us-ascii?Q?2CDEE2R817A1hlKQyGAT6YFxUWraTxohr27jjpiDFKyv3skgt+m1baF6tjAp?=
 =?us-ascii?Q?AiZdCcRQKZ5YIHXjZbl2e8bYzvud42HyQCP1Z0I+aMRNjc+oYlPexY/qycm8?=
 =?us-ascii?Q?ehiXtayQ4rrjs4AIgZIau5Mxn/5g8yOz8y+v6ZM5cPQ4dO/JlVZ8mFVCV/eQ?=
 =?us-ascii?Q?DNe2605OXGaH6LLUXYz5MYut7r7Iac+qxaZZCg09jK6vd7iC2IWtwF9a7Tbm?=
 =?us-ascii?Q?8sQtUPqiiTEiddCA37YF3YdSY9cLeXH+aisvfIAWAo2rEDkM7p6+2mTImQPd?=
 =?us-ascii?Q?6KcsJV1MhGg5ArFqJAt+pgLMf5EV9J49cKt8O51CMWFs5CpET7f2JLoGthW3?=
 =?us-ascii?Q?VOIaVwywNyQjgeuXFsaq00aOl7wjzIW0hRBfNs4Kfka0ZkBjlz8lH+HSbT1z?=
 =?us-ascii?Q?pnPv9RibVDLywIiR5Fl1ePKoTs6KP5vMHDo5Y5po8CDFCG9lY6Cv8m5u+U9t?=
 =?us-ascii?Q?u+GICfTW0NdkvR4GQYv4xYCjWo3B86nOXJBbd6J/wkYkQbt/Zb9NE3+ml+jW?=
 =?us-ascii?Q?8gb+9iJFaQPQ6UuQMJIxfD4vXdGUl6TwbIr95zymcnrLccMrCiPaTvWEf9mJ?=
 =?us-ascii?Q?EFzI23UZfOViJU2OrGjwDnhMrIemNMvOJDq7FcUo9XOsNrRzPPpkYYZIPGXw?=
 =?us-ascii?Q?o4IC8JZfgLXvHckhBVusuwwgLRPX/E2LQRDyOnXTPjgvcypPv9LX2evMOJCF?=
 =?us-ascii?Q?sWc/IVvQTakBthsTlvFGGgmJGuMC6y/IFe2wQCY/3p3sZtEEZzR4nHZBynZx?=
 =?us-ascii?Q?5PJLjIRPK3iKj8CfN/voEXC6QM3sUXxXqOvem/3Ngdt5otq4O4yKTZ2zIwmY?=
 =?us-ascii?Q?UcDSRopAaZHQiD1/Ayo1Ejyh053xpg6Vj4SMEsysluTWIqvxAmzEhW8r0pnA?=
 =?us-ascii?Q?DiOa9h1moc7dZLqWmHYEAlNPralFqsbYb80WCM3cCzYsK7gLcBFYhosdey6e?=
 =?us-ascii?Q?pZM5r1JKP/8AKgzyJHVgJ4S4NQAYUfg/T7weLGGzFcJnD9uTlECwPnbPcEpg?=
 =?us-ascii?Q?In0puQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983313ae-c9e5-4750-55c6-08d9beb4db91
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 03:50:23.6164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJW6Q9X/JMSvFh7JlmbUktacy93jYB8bd/V9pNL+knMReNwWKfuV64BUE5YzFyx21HerhGxqfwoFVw2h59TdOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, December 13, 2021 21:49
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: correct the wrong cached state for GMC o=
n
> PICASSO
>=20
> [Public]
>=20
> Acked-by: Guchun Chen <guchun.chen@amd.com>
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan
> Quan
> Sent: Tuesday, December 14, 2021 9:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
> PICASSO
>=20
> Pair the operations did in GMC ->hw_init and ->hw_fini. That can help to
> maintain correct cached state for GMC and avoid unintention gate operatio=
n
> dropping due to wrong cached state.
>=20
> BUG:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1828&amp;data=3D04%7C01%7Cguchun.chen%40amd.com%7C42b
> 00d7e1c4e44c0762908d9bea1ef53%7C3dd8961fe4884e608e11a82d994e183d%
> 7C0%7C0%7C637750424983319967%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a
> mp;sdata=3DVgBDAbcKN%2FqUz8iBQby9YP8PsG2y93VlnDVhXVaGNBo%3D&amp;r
> eserved=3D0
>=20

The syntax here should be BugLink: <url>

Otherwise
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I9976672a64464b86bb45eed0c25c9599d3bb4c06
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          | 8 ++++----
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 7 ++++++-
>  3 files changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index db2ec84f7237..c7492db3e189 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1809,6 +1809,14 @@ static int gmc_v9_0_hw_fini(void *handle)
>  		return 0;
>  	}
>=20
> +	/*
> +	 * Pair the operations did in gmc_v9_0_hw_init and thus maintain
> +	 * a correct cached state for GMC. Otherwise, the "gate" again
> +	 * operation on S3 resuming will fail due to wrong cached state.
> +	 */
> +	if (adev->mmhub.funcs->update_power_gating)
> +		adev->mmhub.funcs->update_power_gating(adev, false);
> +
>  	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index b3bede1dc41d..1da2ec692057 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -301,10 +301,10 @@ static void
> mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
>  	if (amdgpu_sriov_vf(adev))
>  		return;
>=20
> -	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
> -		amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_GMC, true);
> -
> -	}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
> +		amdgpu_dpm_set_powergating_by_smu(adev,
> +						  AMD_IP_BLOCK_TYPE_GMC,
> +						  enable);
>  }
>=20
>  static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev) diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 3656a77baea4..9953a77cb987 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1167,7 +1167,12 @@ static int pp_set_powergating_by_smu(void
> *handle,
>  		pp_dpm_powergate_vce(handle, gate);
>  		break;
>  	case AMD_IP_BLOCK_TYPE_GMC:
> -		pp_dpm_powergate_mmhub(handle);
> +		/*
> +		 * For now, this is only used on PICASSO.
> +		 * And only "gate" operation is supported.
> +		 */
> +		if (gate)
> +			pp_dpm_powergate_mmhub(handle);
>  		break;
>  	case AMD_IP_BLOCK_TYPE_GFX:
>  		ret =3D pp_dpm_powergate_gfx(handle, gate);
> --
> 2.29.0
