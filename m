Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DE6E909AE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 15:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE1B89149;
	Tue, 17 Feb 2026 15:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EnP42RIc";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D649689149
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 15:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHo8HaHKfpT1BRevl5xypqt41KmbqYXP4ZHhpQDJsu7NjVt2XLn7i6CBQ/w1IZ/MXY5bNEDiLdjSiPu+5sYFC8nOJxN//TSlvB8oO/F1HuVyGgOfn0TBx8E2Na3iZrp3Q6b+N60bbl6xHwa5+iUXRG7kT/Ox4egT9ViMbJsH+3XWB6AMoV/3br5xdjJGSKFcz6ycCUtcNsee8kMn+Oqv6n+AkJVyJgqXKZTwuijYLz7F1RiiZDaFFxr2kLk6a5M3BZa9KgF6rXd/X9jfCmxB2JtGqokEMqps+vRvWYwocvifJyqy75Vz8yJ9SyOMCoY9KqGNCME5FLfmWCS/gv0sLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4zwjWIkp+v+XCSeDbMx0WkZCHU6CH5Pq+83l/VwjYU=;
 b=izBLDFJZhrhqulRarWYsAM2IZU39xHhzDkyuqdDhtYdJsllBVO9FlI+y7PrMScLTz4yluv72PHVimASVytFn3vsa6SobB79mR2JxnCD/SBCiLzd1JkxCsU2KNQXKDz1NQqQrYhxvUVM+VNsQsSKz0Z1+KlnOve8rMlZNz4fJNy8mG57zP5cuSaFdeS7KEjq0HJvOz+TaSBSKAvs58bybaqLrnlvunGtOOaot2n4ilTdzXRgjttAyeP4dSTsKfP5cpoaM4WJI6zhYgYHDRC9ujC/C7+ZB/F7wL5vS8FtcnVjAWs/qOvH3fTH7zGLXo9XIr+DxMh8whwTVXhySnDFIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4zwjWIkp+v+XCSeDbMx0WkZCHU6CH5Pq+83l/VwjYU=;
 b=EnP42RIcqSXRVAlQ7WxahFreaCAnfxa8ED7ZDB3dfenoEeVIx70SghCg4R6HYChTiiyYzVHAd1qR26zeevne5b+NEZPw2iIknNrIJ85NTk4puSMaaCoDrb7G9lzijCGMc3ENu5gqzHB/x5iJHv6TPNmej1zOoH3WBDb/fvKmceU=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA5PPFA403A61D8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Tue, 17 Feb
 2026 15:21:17 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 15:21:17 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wu, Ray" <Ray.Wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>
Subject: RE: [PATCH 00/18] DC Patches Feburary 16, 2026
Thread-Topic: [PATCH 00/18] DC Patches Feburary 16, 2026
Thread-Index: AQHcmpTEmv5pxsLiOUSwJ/LSVWnetLWHC+4Q
Date: Tue, 17 Feb 2026 15:21:17 +0000
Message-ID: <DS0PR12MB6534E6DDA2137FA6DEB8FE6C9C6DA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-17T15:17:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA5PPFA403A61D8:EE_
x-ms-office365-filtering-correlation-id: 8fdb8971-265d-4778-2ef3-08de6e383276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Blq8c1O/kqD5EXSE4vesYhhuCayMTQhqMM0D5hGGw319QAuyHzDva7akNV8Y?=
 =?us-ascii?Q?NlQ7Zd15ezCW0LMl2ciN4p0QcEXIpuXD4skSswz48g+STz21PwW4o1BS9kII?=
 =?us-ascii?Q?BMakr+qA+3+Ra2RVb4LepZKcJKV1LriixIK7xFfOncCWz1wrLWuMzmNxB5wp?=
 =?us-ascii?Q?JpiuVFosvbLC2v4jz3J8J4goSvI6/CTh8ZAX6vRtVDEwS/a2d1ArfRKeFrwn?=
 =?us-ascii?Q?GxbTCYLuoYxSWPnOf8qEuwZmI1asxDa9i0eBZMLUnarJ/bWfppf+5GlaBKS8?=
 =?us-ascii?Q?9cjLiRI6FOL2ues84MxPilKpi+0JWJU4ANQlwj9xfdD3jlClwFoMJrce1vsT?=
 =?us-ascii?Q?Ek6JYBp5r/RntiOXFbf35VygrTgOehO21c/Y17j2gbJnWXAlztmLnKta8p2U?=
 =?us-ascii?Q?EepJrdqdgNx5nW8HNgFeYWAbid8S7dU0oBZ6qIDyXIngzakL+A+Nk4q0IhgN?=
 =?us-ascii?Q?XFfvzkeibwt1coOauo4XxUfovdsaOp8o72ZOduc7Em8EJt/k9AzZg00pP5UG?=
 =?us-ascii?Q?p4y9dDD3+n79oOExDOwk6vaL4cbgJqjE5Hb54etJRt1831pY4ILXtFnEFLOt?=
 =?us-ascii?Q?dBCFpztK09VQg+AR8uY8b8wITxbFSo0PMyRyec759/4aa6r15ygK57GqposT?=
 =?us-ascii?Q?V51dcb98iLYwUPRnaJF9IsvkIVmPr0SMEnj+kT3JTdOTzuvlkMB/+xCOHyYF?=
 =?us-ascii?Q?yvR66Oalyns12PpusWulKxTD50eWspFmV+sPC1KqLSfnroEwoB/powpN0ffX?=
 =?us-ascii?Q?0nm1dd6LTtDqyARdxdbN6krb6/2uBiggMHlQEhxf0BtjDdeBVRIoXl3rX21m?=
 =?us-ascii?Q?ZVxLnnsec/syIwYa7+gp2yrbocvDn3zXCQPzIIycEkcC/oFFJ+O6yoSB8PBq?=
 =?us-ascii?Q?BTZJWqWEyNTrd1uFxFP9ie1try2OXFpMtDEpgJjex6i/THxdPxGcDkJnbG3e?=
 =?us-ascii?Q?pzBy7GgyIma0EfCUeSAnYWRmjIVHRkilN7cVDJtwhx2/bM6Z4ueDfUFjwagV?=
 =?us-ascii?Q?EsOcyvubXeBz/cOZ5MHcFSjpv/ES4Nh6EC5f1mZMCtXNvTSEvtZUMuX9KEVS?=
 =?us-ascii?Q?R0GSt10QsPFXsu3XJRFjl4zV0S3ivu80LJqG4Z/BfjvlwBj0XFbdg6M9i3uX?=
 =?us-ascii?Q?t7p9wLiltusy4UsN9G33MvQhHymz1VJ91vCfuvGwuyRxerhxnNAOmGmORE09?=
 =?us-ascii?Q?T/Ea1u59s8TBKp7uScUzUm2RPGoxhibLsCRJnSwP+ezlNp6zgcQoQV+79YRP?=
 =?us-ascii?Q?XawbSYkaA+fEBXB3KZU6mGv6wSlL1L5TaFLBfttAxiE6EKZoTVRzBvzmpxGh?=
 =?us-ascii?Q?KjLuNUcRRzYFiEbx0O/91d3tl7b1Wtdnfzr9Ah6hsiWQWwml3SUdHkXN9I1h?=
 =?us-ascii?Q?sLWUFrIUdbC3YEYIDQnVv9S8qHRNn7eAUUZbWkIuHvV4y3U//U5YqRoYSO2k?=
 =?us-ascii?Q?JYlllgxAIkM0IqTOoNIZVYyTm3UhvkS/mPOdngU+jim+jwuqMsduZdL+MQlO?=
 =?us-ascii?Q?Aj+qVKY61SxPcqd+tj+pNMKE/aGbl73MCV8gSStmtBdLRrZHmzSjh5QTHzQJ?=
 =?us-ascii?Q?6xYh48xPdbs0Ih6NxHYX21eXtYxpniazdXrTJ4zo7FQ45HZox5Exy4klKnLI?=
 =?us-ascii?Q?l0R37+YRD24pYwwDKlFpnQQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VhXxEQzrGN9YEmKEhOp7s+cfxYaP3cw3Q5xKLU0Kh0SJxgMbtIgizxZfWg3c?=
 =?us-ascii?Q?PVbrVfkX2OTIEvJ3Gz3hQlii7ABC1T2jCuV+y6qFnl/j0M2WfwpAP9/8hr0m?=
 =?us-ascii?Q?wJ4EREWethfxvenzERVQjjaHQy7QMCa5wpQxxYGRuDMzushjZOsLF0DwgbrD?=
 =?us-ascii?Q?op0ZHuW0bEULe1VdG04J9xMuq8WkrAfV7k03dDhF+peEIov4xvEndClDJA6b?=
 =?us-ascii?Q?NHV5ON4a1npz5BTZGaHUqcREgPra2suA5JkcUC6n2613nPsT+eb/4937GgaO?=
 =?us-ascii?Q?y2ysp06g0SI5O98SagUa4kLuRoUr5Zq/rvidTRjMIF7uVdlNfNox+FhF18u+?=
 =?us-ascii?Q?utubbbpTKW+NVC9XdOjewN6Pi4kUBpuA3HxQxAVRjeVPYNNxRnOE6vEqLbYD?=
 =?us-ascii?Q?pwQEvqb/0M/RJiaZuNAu807utKo+LaDe7u71NjU+Yd0sNi8roIcxpnOyZmsN?=
 =?us-ascii?Q?o9YOULpyfpYZdKVvft7MhHexOh5gUqKzo5CwLqEoxzI/C4ro9jWZJyBpWoe2?=
 =?us-ascii?Q?v7mAfgOBNVLJpLCq21rSygh/rsOn6GMYqMWGfjNRXKekzkQ/sj99QrOUH38L?=
 =?us-ascii?Q?sAgRl0GkVEPAjIip/XwVSD4ASpsSAG2lopo6QnuMxB28v/T0jnH1xwH7C4zi?=
 =?us-ascii?Q?OYxEpnW2fz2CiPIMhofr8tfUCBZ7fF5k8VWavF2ErV7QxiqeTEc3o2OdDcea?=
 =?us-ascii?Q?6pvirygxDMYLqBmI6J1sZMM4C8QRbX9BPkpAGTCLcUtNPmD418fZqlkzwV33?=
 =?us-ascii?Q?dKJxnCZHb0+1+lNN/tzVw2tgm4vJkcOkt0xHMSOybdi+eoOv7W4BrihR3Czd?=
 =?us-ascii?Q?MLHYR4gaRBjvN3C/hFVveDKYv16ECM0KG2Ct04I5tF0mWPCrqRRXP7GIMMMv?=
 =?us-ascii?Q?bhZKIJpPRgnSli4WHwVZRCxqUdE4FwKkRrwgT6CWICx1FNIU6wFg8vcpIoTK?=
 =?us-ascii?Q?6PYPTyhnfs8Uf/239EBWzW53ll/63qvRiYnmin9F/AQjmSI7Nw7v2ZjSCFbc?=
 =?us-ascii?Q?6QkSESQy9mc9K/t0C6mLeT0PUirBCFUdaAryFf8hVMaCdVXRxCwSm29RRv6K?=
 =?us-ascii?Q?RZcbdY7Oh2SoN/DHJcmnv1bLwChFqECqTVoerD0J+BdddXxVFpCC+NQx2WqB?=
 =?us-ascii?Q?0Q/PB6LaBXb00U4g/6nqB396XL5RewKIJrj9zqJkhzkTRBr+T0qXXPea684k?=
 =?us-ascii?Q?NPBzQKwoiOBX8qoRbISPL2zzILi9xvQtRzBVAUyZqEIJf46vg9DvVbOtkkTl?=
 =?us-ascii?Q?e1TwPmmqo1dIEt/FrKurBuJs54HNxjzcpZgy6P/pX30vSBeZFLG82boFEeXi?=
 =?us-ascii?Q?U9JZayI2rxE9V64odK37RhGqMup+z2pAhb17DS6EBr9FAryN9m9Ha8gKJuYD?=
 =?us-ascii?Q?qnS3j523g+dpZWOZ9B7EvrxfcRI6CI2ZEFlkod7i9FNttyV2DOONBiZhOe9f?=
 =?us-ascii?Q?4NngAR+OlKT4uXYsoS1iLyNeJIjno7tCzibNJmJhroTnKqR3vg9q65td+vKm?=
 =?us-ascii?Q?51O+945H3r+OeGX/9f4v2JRG3EYNR7QZmtObtU9OC/Y4j/WdhuXb4tDiuQNM?=
 =?us-ascii?Q?xfCnKHkS9H1cBSKdJwqI15T1hsAybSWDq5OdY35BN/YJZgoFupfmNCrkHl4F?=
 =?us-ascii?Q?SE9htzQDnOc5tDWomG3RTFPcDt0WKl+qWwx9RTEP7W6AU+18mxDsaoxxSYRx?=
 =?us-ascii?Q?nBKw5UXrXSorYqcXX6/0BPOOA4Lh31zUF4EkZcDpT4Lbgh6G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdb8971-265d-4778-2ef3-08de6e383276
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 15:21:17.6831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENPV1HVjzyKZT8mUVhquZKMJoNXeCauA28L3zss8r8cFqeMks07I4RVfIenFa3l93nbd3iMKNpbdEZnAjeYDPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8
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

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 058=
df1bf2127958e3a8d0b1951a9b4420f3b6975 -> drm/amd/display: Refactor fams2 ca=
lculations) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Ray Wu <ray.wu@amd.com>
Sent: Tuesday, February 10, 2026 8:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Wu, Ray <Ray.Wu@amd.com>
Subject: [PATCH 00/18] DC Patches Feburary 16, 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Add static keyword for sharpness tables.
- Refactor fams2 calculations.
- Add gpuvm and hvm params to dml21.
- Expose functions of other dcn use.
- Extend inbox0 HW lock support to DCN35.
- Disable SR feature on eDP1 by default.
- Implement ramless idle mouse trigger.
- Migrate DCCG register access from hwseq to dccg component.
- Skip eDP detection when no sink.
- Refactor and fix link_dpms
- Correct logic check error for fastboot.
- Check return of shaper curve to HW format.
- Remove conditional for shaper 3DLUT power-on.

Cc: Dan Wheeler <daniel.wheeler@amd.com>


Alex Hung (2):
  drm/amd/display: Check return of shaper curve to HW format
  drm/amd/display: Remove conditional for shaper 3DLUT power-on

Bhuvanachandra Pinninti (1):
  drm/amd/display: Migrate DCCG registers access from hwseq to dccg
    component.

Charlene Liu (2):
  drm/amd/display: Disable SR feature on eDP1 by default
  drm/amd/display: Correct logic check error for fastboot

Dillon Varone (1):
  drm/amd/display: Refactor fams2 calculations

Dmytro Laktyushkin (2):
  drm/amd/display: Add gpuvm and hvm params to dml21
  drm/amd/display: Expose functions of other dcn use

Dominik Kaszewski (2):
  drm/amd/display: Refactor and fix link_dpms I2C
  drm/amd/display: Refactor and fix link_dpms info

Muaaz Nisar (1):
  drm/amd/display: Implementing ramless idle mouse trigger

Nicholas Carbones (3):
  Revert "drm/amd/display: Add Handling for gfxversion DcGfxBase"
  Revert "drm/amd/display: Correct hubp GfxVersion verification"
  Revert "drm/amd/display: Add Gfx Base Case For Linear Tiling Handling"

Saidireddy Yenugu (1):
  drm/amd/display: Skip eDP detection when no sink

Samson Tam (1):
  drm/amd/display: Add static keyword for sharpness tables

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.370

Webb Chen (1):
  drm/amd/display: Extend inbox0 HW lock support to DCN35

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   8 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   7 -
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   1 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  15 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   9 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    |  54 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  14 +-
 .../amd/display/dc/dccg/dcn201/dcn201_dccg.c  |   7 +-
 .../amd/display/dc/dccg/dcn21/dcn21_dccg.c    |   6 +-
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |   6 +-
 .../amd/display/dc/dccg/dcn301/dcn301_dccg.c  |   6 +-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   5 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   7 +-
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   5 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  11 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  17 +-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   3 -
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   5 +
 .../display/dc/dce110/dce110_mem_input_v.c    |   3 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   1 -
 .../dml2_0/dml21/dml21_translation_helper.c   |  11 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c | 205 +++---
 .../amd/display/dc/dml2_0/dml21/dml21_utils.h |   1 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   2 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |   1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  10 +-  .../display/dc/hub=
bub/dcn401/dcn401_hubbub.h  |  10 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  33 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  26 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  26 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   7 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   4 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  29 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   9 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  48 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 640 +++++++-----------
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   3 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   6 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |   9 +
 .../resource/dcn32/dcn32_resource_helpers.c   |   3 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   3 +-
 59 files changed, 698 insertions(+), 663 deletions(-)

--
2.43.0

