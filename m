Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24823EB64DE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 02:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC6D10E29F;
	Mon,  9 Sep 2024 02:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3g11NxjA";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F1910E29F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 02:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0Aykylq2RYi20SyR++/7xQ05ExbQbRygKQCZYX/L8mfTbXW2omRUT6ITxx6BU/ApnJC9945Cke597gFPy4OXLnWpA5w9kg+1JsUTGdFO7TADQm0wUI9ays4xlE5k6OID6CN0+qv1Z6TqKH1+lyXTmtTH7b51gvRnw+d4jiVw0A1nf2n1RLi3dGM6k/vy3SiBXS9AbxU9FgbieocJRwgu/eQEcniYLo3jaMrkei1ckLb1O6K9rXHx0tWIZaZfLJQEjYNHQ1zS6DJDbSFhDyiH/ABqULzsNBLMaAc8INyk97g/trmMjQ1MgrCASTkvn7fQNLsNmHzUVmZPQEFOghYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYgNiG7S/H70YZocyvMaYHMa/BVt9B0OnQxkZW9QHNk=;
 b=XmATjJq6LnQEu7mlrAV3X8X2/ui4gWoZ9RRJ9WLcUrp947vNjVSgHB6TJAx7rSAbRK5iX7oqqc7lywfqV43nyF5n8+ZaiT9DMi2QYMIRxXeRgEY1J0v+As5/JAeyOAPwHLnpQ1MjtgGX/BFUS7dX1qjFrsRxLj2mKLlYyMhh85Gvf2z4aERi8pDARxYCjMXLKrNWkB2P4HGEjUW5ohfRVMpCmmox2Ltk+CSLJ2Hc4G7P32fTx7qZ1MQARSv1pVbotUIOLdTVDZZlvCoVkshndCibTMdYnEpgO8PpgQF9ck6Gwtrr1cJ1OrvRnOZVgJroPpA+M6Wlti+XBtLdcAIarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYgNiG7S/H70YZocyvMaYHMa/BVt9B0OnQxkZW9QHNk=;
 b=3g11NxjAdKwrl3AxsDSiqm0veZ48Wt5uRohwMp/v7qK1ftxWDweFewVv5iY6Z00vlqNjgtBY57FZ5MGuoLZyQaqochEA0G4/ZRFxJxvTD4LwGKE8Eqxq9CjRGDCKB4IkPpnkx310JI3U+fyhwjZqip+Vs7DI4b41dZ0lPu7ZTlQ=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 02:25:11 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%6]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 02:25:10 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix resource leak in riu rsetore queue
Thread-Topic: [PATCH] drm/amdkfd: Fix resource leak in riu rsetore queue
Thread-Index: AQHbAlaESKw21GZHbkey/K0LgPdwPrJOucnA
Date: Mon, 9 Sep 2024 02:25:10 +0000
Message-ID: <CH3PR12MB80749A2EE91427B499DA3CEDF6992@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240909012041.1433796-1-jesse.zhang@amd.com>
In-Reply-To: <20240909012041.1433796-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8523d262-7861-402a-9dbf-a636efe24809;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-09T02:24:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SJ2PR12MB8926:EE_
x-ms-office365-filtering-correlation-id: 400f559d-8e6b-4b4e-2172-08dcd076a11c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IjzP7JdjpQwfMiayYimfDg008gnLBjeT2icWiKbRBi3ADlZt7BVblCgbNE?=
 =?iso-8859-1?Q?/qt2hq5nQDy2o1jhoROVgeK0ADzmbedSGty+DtuthZ9FRK5z1INI3gtpwo?=
 =?iso-8859-1?Q?RyU3JGVnDSmfvc82EvjSDUEE3z8ST0QD2HJe/GCb9ryKMbcO7I4hwq84ev?=
 =?iso-8859-1?Q?UyMZMyr9O5MUBlr+wfJtagluUwkA298ZU65Y8wV/stSBlIDQB+6aL+3ulY?=
 =?iso-8859-1?Q?cfhEHyS61ht/OoCzUFHovJb4J4BIvmDVSZwdAcNvqA/G/LcDE5Lq9JDx+H?=
 =?iso-8859-1?Q?TEgqLx6oHZZAPR8sQVwgz/lEVXX6FKOx/kwaUVZ+CbKSQQ/9gkubdghmeN?=
 =?iso-8859-1?Q?N6fMeZc5aYebU4NEo51qvyHgzOuAVVbTxn9NDB6I1m8TXQfB9MQ7PnYP1v?=
 =?iso-8859-1?Q?ghxcf2oSh2dJRxIkB0cQDi/tPDRdriPUf2b9VTqL2FpwKuzcRHBv4++ShY?=
 =?iso-8859-1?Q?e74HgkN21IkMmSaDHBvWgvwOaAExN7T0LC36ItBXttV+6dpGBFQd6Me19M?=
 =?iso-8859-1?Q?OlZ+lgEodHROaM7fTBG5EP1TBQBo1g1VUL5h1pmmtsV8sUg2xGPmI0OukF?=
 =?iso-8859-1?Q?RYlX2rs2AodTux/8rMwAKCBBcVeFbUfCMWwPBlP8YTRgsxjQ9uDKobT83b?=
 =?iso-8859-1?Q?GJGpzHTDaGBJVRGSIalt2GKxt9AMBo8o1ToobiKSgzsNLTRGG+Ya2KIeMN?=
 =?iso-8859-1?Q?yE7k+h1UB35WcXBLPl/yiy1xjcqsdOu8ffqjOZSeF127GqNgBuJ9kO0Wtm?=
 =?iso-8859-1?Q?AVXYVcllzc4+6oZO/SucPxmd6E5KOVhmLW7D/PMk/p6AGLrUpxkM/MRlDY?=
 =?iso-8859-1?Q?aThd2Y2sldtNPOJgPUCIxL5gkAkYHOuLHiPL9iB9zm6t2/dYSpqczXiiRa?=
 =?iso-8859-1?Q?YQsVZpI8bZAO1cRyOVjkbW1tvB08+U7TQSI/oxWGJcZUGjhWoTBi5ch1v5?=
 =?iso-8859-1?Q?+BWu+RlLwby65SV3VuMT+WZ3opsH+XOToxyr1v0Zpx4xuLdlx724vOTGId?=
 =?iso-8859-1?Q?JZS1V/eeXHrgDrkZEIpTTfx71f/IKpXGFN8sIDe3b+EQsZ7xVraDQh5BxP?=
 =?iso-8859-1?Q?q1lC2y56bslMpP2afYcNCMQVy5km0ec79Xiw9hSEBhCotoYRTzD1VUG6gE?=
 =?iso-8859-1?Q?BB4A6A4YCs5/9a6AUvRh6NwEZOUwlDkoox5C5Y2CmnZgdnBkRrGhNYHcr7?=
 =?iso-8859-1?Q?hixtSaXbCa5UTW0U18VSdUl565efvAfxCfx1hgxDDCQE+qOSA3IUwU5pU7?=
 =?iso-8859-1?Q?O3k1JhTkBCAbOTo7kfmkKt1GsXYetyUQkrzwBm8oLt/mvTAJPB65c6EKOA?=
 =?iso-8859-1?Q?nxREtKdV2X86A7T/a8+HztTp+5O54Ag9BkcDySKtzCVgXKV6jdna1gAUHc?=
 =?iso-8859-1?Q?bQGINEqDcxfLIxVb1I93V96uV11aJPFdgZfL5mxouGVwqcULSpvvsl7ptS?=
 =?iso-8859-1?Q?T4yg5FG1fJI/gFeh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6OKP9yq7QA0b45jvjX5ZFvgacM3Ljl2PY1IX7a/aEIxZnT0BfeHr1Gx9vu?=
 =?iso-8859-1?Q?fF3OmcoeMkFdcn3eU/edmDJdGf58uhz0zDt49eUQz5fS2qdOFcAUNJpYjD?=
 =?iso-8859-1?Q?EvbW8DgyPhk3lsylw8d8MetUFdFaRYJJWKthLKRrClt6TS9N2dTi08fobA?=
 =?iso-8859-1?Q?ilIGi4LreURVj72tWVVM4xHOFV/pYoglH120w+71BH86f5XtogOwDd0OJe?=
 =?iso-8859-1?Q?5EpsEcYzrt6qe1GkY0VWM2UqmIfkBjzDTV082ShN8hLRwifSuTVAdzlXck?=
 =?iso-8859-1?Q?cJzlkESD/WX06vuWOqvoU5GT1HVakLlgtMYJQI48k5rKxATofkzD+A9GFJ?=
 =?iso-8859-1?Q?4ET3HgwZYS4xPVk1FfDsaNSBDKI94v+Vk4q8DHB/WJhv8CEM2MVln56XJ9?=
 =?iso-8859-1?Q?sCCkN0LWveacq045TnI4xgL+iDtVKEB3nKcSAxkoNoHAz61KKxQ2B6TAy6?=
 =?iso-8859-1?Q?VCN+qqGwZVdfUflVgtjrWsDCbiG0EPsZLfoEq15wZ+DJ4Fuhx5Bfh0G140?=
 =?iso-8859-1?Q?GQYgaaJByT17VH2xogt5XEJirDBA3VOgn5G2AxnGZAtirVKMtyPV8rUQ7w?=
 =?iso-8859-1?Q?z2kRjEPZxn8jYUbBtTD6j62/qgIJoI0/bAt5ZfYmK7rrpgILoHi0DvzWe4?=
 =?iso-8859-1?Q?a4OeGu/aU+BEyO0EgWNpenYJts59DEk1co13T/wqbKfXr39JNG2zY9oR8M?=
 =?iso-8859-1?Q?SjrWC2Ont1PZG1zdKdcu1FhfuOs2Ry/2Og2rVSWqdKslV5dlXx/7zVu/Ws?=
 =?iso-8859-1?Q?oLmn717xjmfx9MF887FRtrSiKUsuVzJw5Qv99At3Sp+YAmB+PZSfciP2H3?=
 =?iso-8859-1?Q?5hvmWPbE/VsKFQ3Nv4WESP/nfe3wUpHN+XJGBH4iHElY4Uq86VDgJTIuxe?=
 =?iso-8859-1?Q?btlG/lrLr4dELSpmKN0/N1KvOUj9FF+iSUrsOzrOD9hMxLxjfofBi682LU?=
 =?iso-8859-1?Q?apPHFoGQWY+fHMQcM3Xdw2CgAG8qjMRhWcip9Vp1T+AnOnuDxUnglTiKii?=
 =?iso-8859-1?Q?ENXOo+9FwOhCx86Hl6yLXYbJq1yR344tdEHukYLrkX2VKkZdyzmSzdJiRf?=
 =?iso-8859-1?Q?BgH6FnPP4dU08R0vtwUubM9qScjApMhEXjpKbQVO/D3OSPYV1l2MNeUppr?=
 =?iso-8859-1?Q?8aZAnGkYtgVX2440+YC2DBA+EHGcAPOX6MPlZju8T+JqiZUF87zyFQdRpM?=
 =?iso-8859-1?Q?3V9CKVVnZEH/C4DGNY9uPgvLByvOo9ZsmYHV8rIgBSClwX4GSVWAQ12lbd?=
 =?iso-8859-1?Q?5ZEgUynmLxXgroL7S1vfDEWKxTaZIgUl7AgsQmwp2A8hDq5J9PyZmOg7yj?=
 =?iso-8859-1?Q?kB6SAkoIEJrzAXvqFa/rnDrSIK2Tpk/8HLBpURdPOAxg85HNCIKzwp1ULq?=
 =?iso-8859-1?Q?JEi5FFz5q8ANcbd+ONaVtVo5ipiz6helmK3GLuLnPWSWjj3danJNlOAVq3?=
 =?iso-8859-1?Q?7hJ5QbQCZ3Qh/oAK8TB+Hj9mEBhuidgAEg7yBz/vInRDMb2xVpOv0MxpdA?=
 =?iso-8859-1?Q?kYkFdMI5WaU9uwhARabSNUytmNZjFK3jf1QHpEGzL7NWzVvp7Plktoa1fE?=
 =?iso-8859-1?Q?+iS34m2kQchGxoMh6Pr3yt/jZzGyv7YF3AOT5BWAqFeTXzMGlW6mbgRta7?=
 =?iso-8859-1?Q?sYqoBS0MvXpkI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400f559d-8e6b-4b4e-2172-08dcd076a11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 02:25:10.7053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTJQjnOccIOG9/UrsobyU43IhEQK8wseVRCVMsmQTrI8CNUjPmD/arx4q1S/1WA3oKqI2dEqCI+d+bXEbvFo5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

[Public]

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com>



> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Monday, September 9, 2024 9:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix resource leak in riu rsetore queue
>
> To avoid memory leaks, release q_extra_data when exiting the restore queu=
e.
> v2: Correct the proto (Alex)
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 20ea745729ee..b439d4d0bd84 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1046,6 +1046,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>               pr_debug("Queue id %d was restored successfully\n", queue_i=
d);
>
>       kfree(q_data);
> +     kfree(q_extra_data);
>
>       return ret;
>  }
> --
> 2.25.1

