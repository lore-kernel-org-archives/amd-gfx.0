Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9C0EDF04C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 08:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E003610E6F0;
	Thu, 12 Feb 2026 08:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HXIqs2yv";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3D210E6F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 08:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jx1KEUerpBSByiYy9tkvf0kvzkX+8oU5aZnWrVWDNcj/658awC1+pjnZMLVaA3Nn7vGCBCR07Y6VDcUFXFUbAwYtP0MJRIOTmwaxP0Bric9ht3nZLWXSTk5zvCLXVNqMKD4rvhg1ZCpPbUKrCuxCYh0xKs1fqB9VtRYjpbwL3jTqJq3eKWUgi4XnrKerf/EFadXIUCrghRMNAG03kv/A0QvvWcmpT2n6Z0x1TU03TDWmoHTxEpv8AgnGb42ktz1kM0XF62EwqoVcZaRmbYSZqZ0+5fTutVxX66ASp8DaTveYImLCiGbvU3MdOYyFdQI5Xa9lF1iZ1vaGr6APPXNy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLLQEo2h1doAUeP7cEZLwTNGCIen2gH8Gjb5610g7XQ=;
 b=ISvmVsfBT5eyb33+pLVJfEnkglCt0qSc8RAoFJUKrtPwiAF9o5Tw9fC6Huspp9CD18KikS9pTZCf9mCNrMRL0SjHVvrJUY3r7QZVNQBlN+bPMl2zDnBPH1DRajd2JnaUJsiKUo+ZaPDxZzA5PJI2Qvhhctsf+YzuKdFT9U5ZvbobZqwjrzfqpIXu+EQGEQPUz2RMA99sw6//ZTDuK/WHZucFA4iIVFwTDGxKpfHCdXsFnosUW7u1OtUoECVbI1O0NMiElIAL11V1dmVlwbZ6sINLL0vABWwcJXoGxlHsAaqqKvCRLHEqWBrxlZyRheplNQPl4mLZzByBbOIQH0p1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLLQEo2h1doAUeP7cEZLwTNGCIen2gH8Gjb5610g7XQ=;
 b=HXIqs2yvcdm58d/xxAPPYmmNF6W4OFmeEZQpKgb3BOuzX3KZ/SVe+I6cMDfaDMmTNkeMjL5wUo+Jz1OpDd5OVydQBO+MlL1hYr97RFtAm04K6W7n/+j/a/y5UU2v9CmWAnaUVk5aWfRx99lxVXXAPBpdkbbD8CdkKHmHeYCoIp0=
Received: from MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Thu, 12 Feb
 2026 08:09:58 +0000
Received: from MW6PR12MB8706.namprd12.prod.outlook.com
 ([fe80::6981:503f:a672:5f92]) by MW6PR12MB8706.namprd12.prod.outlook.com
 ([fe80::6981:503f:a672:5f92%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 08:09:58 +0000
From: "Su, Joe" <Jinzhou.Su@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2] drm/amd/ras: use dedicated memory as vf ras command
 buffer
Thread-Topic: [PATCH V2] drm/amd/ras: use dedicated memory as vf ras command
 buffer
Thread-Index: AQHcm+ZwaPZkjDD62UG8z5U4iX/SzLV+tYEA
Date: Thu, 12 Feb 2026 08:09:58 +0000
Message-ID: <MW6PR12MB8706EB9BAFDF98F034B0F1959060A@MW6PR12MB8706.namprd12.prod.outlook.com>
References: <20260212060702.4153469-1-YiPeng.Chai@amd.com>
In-Reply-To: <20260212060702.4153469-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-12T08:07:38.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8706:EE_|MW4PR12MB5665:EE_
x-ms-office365-filtering-correlation-id: 694566c6-9024-4095-731f-08de6a0e1d36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rAa9PtHafcOte1IrI33P81up7cSy2FrfBxRz39oGvybQNgyEg0m3dT0jwuty?=
 =?us-ascii?Q?9mIWNAJYdrTwlGVdmCSLOEc38F7fUgu4GWUBslhs1RAjHSPmjI5pp6qw2VOf?=
 =?us-ascii?Q?47nBOp25Ylg5F71MXZ9yfEfmJSB5nm8mw0B5g1a/62PI/gX4biTbgG885Nom?=
 =?us-ascii?Q?CJh9MlkGf09ZNy4hEeVptumOYJOmn91oR1d9edp8XRbcFsi2qGBmgyxQA6mi?=
 =?us-ascii?Q?B/wV1XLI/F5K5GbXWyv/3eReuNzUtORLyKlLcf4hTVRilLzeWMVsGmYyxymf?=
 =?us-ascii?Q?CctDSAd8pyGQn5ySg4UO2pX2wU1+oKMXwnmWPIH7onn5NN82wfz0pPPzs5Tp?=
 =?us-ascii?Q?4W/tQae83ajlM8eM+cDFDP6TqbqqXUbJhGq6LGimCn4t5u0MvRwxUD9/9vYQ?=
 =?us-ascii?Q?ir8EX4bBSOiSqF/dkhNp3i73MZsh6ZBW+fQxYdRdZC8LTxUT0AQW/BAAAxmK?=
 =?us-ascii?Q?cK3fKXidgyzEMzsaLS8c5lpfn9owaOFT+2zpBRHoy0nej8f6nbYSodYSFGr+?=
 =?us-ascii?Q?4jGoMHf6LdS0RJjT94rVzV+E8Mu+3yuUVNTrRpULQpKFIq1QB0xZnUItZRy/?=
 =?us-ascii?Q?Eg7EAJEjaGoZYwWkIp54Yp+7xwIXHUYUK235yNxe1uirLJ+XhYRDugeVNXU4?=
 =?us-ascii?Q?da8gv2YLntFWlcW4cpK/CftlrpQVIBWA8667yBCTlpplWBCuPDd4HxPWOvJ7?=
 =?us-ascii?Q?j82G4pwApPlIq9se24gWNR5aSuBnfKyIUu/Rk0yaKPiriN6Zf4fhy3+kiTfK?=
 =?us-ascii?Q?3zwVP1So6HHASbReP0wPP2/cUew5JuSabx0o+ytE6EBQ10JToRPMslbojbEm?=
 =?us-ascii?Q?2RdsaI8c4yL/OeO9JLxvFfQGdeor3UWc2F8g65pHTaBhor9Gib1VyUN3Zx6D?=
 =?us-ascii?Q?ITxbhEgwfeqaqe9kVt9Q/u+ENlOjQ17ldDDKoCRI8zuAWZiQ/aKm902AZSoM?=
 =?us-ascii?Q?uhyqNRaWa6ElSU4gotkoNeKs6zvkz1VS3tF/MJqmrA5AqaIcng4L3nsIFrdy?=
 =?us-ascii?Q?ofiTXorc0ngNsotGG1Une3niR8J9ROkoIH9S1fjBAz9NXR5TTomPAs1/Vu/h?=
 =?us-ascii?Q?/x8w5FHzoJ/UENXleDvbTFu/Xb/CPOUU/a6JZ2VJXoPKDTHSaUrOChqENjTZ?=
 =?us-ascii?Q?BdKZZ6I31Ke9ZsmCpk8aXhWCc3G2Ab3sRIPJwOj1fZPvnbrOBlCNfYsJ25S/?=
 =?us-ascii?Q?eaU27eJlfm1HOUyJ1uTCNmf2XElEV3FfdDkwFflqSWNt81TioOcW9lijkmJ8?=
 =?us-ascii?Q?ar2e+X1rCB6Vjs0pOPYPx7/mEqRnUj5wIPmbH3D7ynGcWXKy6p19+aoOblRV?=
 =?us-ascii?Q?s1hGgpUn/NR5tTOEGOYFj9iCVz/2o8Y+GDRd8TVyz3aI1gGWN7Sj+Gu1SKVu?=
 =?us-ascii?Q?Yxi+nzHK11EpJrkXPcOOlMV9RcpDZJ1a8h1QjguLNkJ5S3oITwD3G7hFTSB+?=
 =?us-ascii?Q?Onc0gBHaDql95wjnBm40XKC0pBpYNjzv+1zNU154Il/uQWrLV5Y/tbVvUw/w?=
 =?us-ascii?Q?UG+jWVeE139izWxP8Bxf1vKvsjp7ZVz0Cdws5aDWNwZsFNxpt7Q5nJTFV/J0?=
 =?us-ascii?Q?I+FM6Nt9FAeuCjG/CLe4LwyAM5AAT/UhzEGwlbGERhTT9pZdoi4b/KhioVho?=
 =?us-ascii?Q?4LEDR+mq7Fjg1NVfiF0m4IU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8706.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rCNHM+bArjwjsOcg4UkZL5v5ucD4PENeMPM/EdZZ4jvQD3F5fJACVMI5J7+j?=
 =?us-ascii?Q?nSjrtFsbNFA6RWWdgZF16mdtPtYev56ACtUz8DjH5rLpOwzdPcM72eSky1Yh?=
 =?us-ascii?Q?W3KwtCVQpwQRRybAEULs2cdxLMNyMAMcJjVVyB8myYNrYBvi1pg0iDBxVFgR?=
 =?us-ascii?Q?D9k4aTbGGpHP+jyI28+zFsTfroWdc137xohXahM5S050m1ViVKXfvstAXnRE?=
 =?us-ascii?Q?4sVdetN7ZWewLFnwVILMtFmeckTVLBi28/uk99LIFYcT9vYXparGIYedgZmv?=
 =?us-ascii?Q?O46gSJ4tmSCN0jd909kMZUvbzJL+YMz5hsVs1TvZu799iUGA7Epu/SQZeseQ?=
 =?us-ascii?Q?2TMFJlYz27QH0sl7QNzpWfXakrLefLaAL1A3ukWD19JjVCdhYL+JEgqYsu/g?=
 =?us-ascii?Q?CTh2jGlbXmmplnSeZvzK9kxV6hrd9MXG6ZOn0LfI7sT2PBmFl9aekdTs7b0e?=
 =?us-ascii?Q?/+Grmev+AG6SK4WQsEPngs9CtO3ciowq2Mjj527y6q+V/UlrgYI8ZXrRE3BG?=
 =?us-ascii?Q?jqlpm5kzcup0h+OZIueeGQWfM2ZDdF+iobvOLRoSE078eEVNao2lXVljYeMD?=
 =?us-ascii?Q?MzwdYA1fYOuJ3YKTuWvIXSuR/igOZKHuKckeuNWdhrmkHD9D2K5OkUk5d5m1?=
 =?us-ascii?Q?Zdd9wsFB93Uwfm4bb262R6s8vHJ+l8uHzqXebRm9HljzxHlazE/2ouW38QAx?=
 =?us-ascii?Q?0BGZweJMcxzX9cH8RISBC146et7N58gx9qBKkWy7HS1eQeSEddnBi6BaS/Os?=
 =?us-ascii?Q?T5emkYOQkfam+FTAxoO75cnyY8NojwkZWuxXrLAmN8wTj1oYhewLyROx2/P2?=
 =?us-ascii?Q?VvCzDFpYhBXrdWgmaZJhGWFD63CzUCi9FQtZIIlq/oK0X9N6+ccWP/9F+dyv?=
 =?us-ascii?Q?p5kZBxijbIcE5ogYP2wC33BFhm/7DlrlBxnNKj0cA2VbEmMumADCGKRgFSvd?=
 =?us-ascii?Q?ezdoRalbx4FbBH5J1Tk1vKAUrM7Q/KiGA4NFf6ySVtVIM/hqJ2Xb9RvcHv7R?=
 =?us-ascii?Q?9j3mChTBrRa9HGKjgZs8Fd2gQRnqs2tMP2IW1BalxOYxvnjOg4E3Xs2qe0TD?=
 =?us-ascii?Q?9NuMxevLhPrkpX5WSb+BTO1/BHXuc6BdY7X+9aqMVKRpWOTapXR6RFcMJjbw?=
 =?us-ascii?Q?NKG0tXaN+r64k/TtklkSqyKH90sqO6QoVnRklUOVd7TTonjSlB9wDGyMeXjd?=
 =?us-ascii?Q?BrSlzqPVsmlvGfV0q5rXn0C/5rnMSZm3IqPfCtH6Wo+DVdSxHZXCMe4ws3NS?=
 =?us-ascii?Q?GRUdsODI2pOTU1k65VIrywjgGp7Pc4F0rzbd2ZK5LXwYGvLzWVRVTok5iKoj?=
 =?us-ascii?Q?L3wSbWdiwrGDvsxFI1XY4hiI2XpZ3S0T1yetAl+guHabObgxRfiCVJsEyO+B?=
 =?us-ascii?Q?LCRYwS0s5+/FZ3bUpoEVsTb3xBY2usPWUlcvUpYk7O6ffZi7HFlA9zc2GVBF?=
 =?us-ascii?Q?O0PUcixit6QdqNJPk67k1gV0u/DLw5Fr7OQd/vxuAoC/Rb1Hg8WT27lk8/Ba?=
 =?us-ascii?Q?EFf/A0HQnzgOXwudPn32PJxXeLWRJOOaDEQ75ErIBKp4wtZXuvj29jmEnf5v?=
 =?us-ascii?Q?jovR/saHOsgaGJMQUQaGGvAkYMFfiaczVCYV8axQoTT/PNYNMbKD6zD+5APF?=
 =?us-ascii?Q?ampM8VWAY4a6+NI55PCG/b1G94v2Q53vIO+LzqiuCTHTLn77puA0y+Tjbu4u?=
 =?us-ascii?Q?C+jsMm9KdxbQxt1oAn8uHuhEIa65z1ErgYGOYwEoCHj0NGRX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8706.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694566c6-9024-4095-731f-08de6a0e1d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 08:09:58.5018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLwYLyMtNDdyzbhnUD5kk0rmMn4hxdvW29zgVtaPRMfSpsFe+Gf1VD+oyXuhIo4osy40dpFCctnxkTaQLBew/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-and-tested-by: Jinzhou Su <jinzhou.su@amd.com>

Regards
Joe
> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, February 12, 2026 2:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH V2] drm/amd/ras: use dedicated memory as vf ras command
> buffer
>
> Use dedicated memory as vf ras command buffer.
>
> V2:
>   Add lock to ensure serialization of sending vf ras commands.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  24 +++-
>  .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 120 +++++++++++++-----
>   .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |  10 +-
>  3 files changed, 114 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index c20d10263492..aa8871515212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -498,14 +498,22 @@ struct amd_sriov_ras_chk_criti {
>       uint32_t hit;
>  };
>
> +union amd_sriov_ras_host_push {
> +     struct amd_sriov_ras_telemetry_error_count error_count;
> +     struct amd_sriov_ras_cper_dump cper_dump;
> +     struct amd_sriov_ras_chk_criti chk_criti; };
> +
> +#define AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (PAGE_SIZE * 13) struct
> +amd_sriov_uniras_shared_mem {
> +     uint8_t blocks_ecc_buf[PAGE_SIZE];
> +     uint8_t cmd_buf[AMD_SRIOV_UNIRAS_CMD_MAX_SIZE];
> +};
> +
>  struct amdsriov_ras_telemetry {
>       struct amd_sriov_ras_telemetry_header header;
> -
> -     union {
> -             struct amd_sriov_ras_telemetry_error_count error_count;
> -             struct amd_sriov_ras_cper_dump cper_dump;
> -             struct amd_sriov_ras_chk_criti chk_criti;
> -     } body;
> +     union amd_sriov_ras_host_push body;
> +     struct amd_sriov_uniras_shared_mem uniras_shared_mem;
>  };
>
>  /* version data stored in MAILBOX_MSGBUF_RCV_DW1 for future expansion
> */ @@ -538,6 +546,10 @@
> _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 =3D=3D 0,
> _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE >
> AMD_SRIOV_UCODE_ID__MAX,
>              "AMD_SRIOV_MSG_RESERVE_UCODE must be bigger than
> AMD_SRIOV_UCODE_ID__MAX");
>
> +_Static_assert(
> +     sizeof(struct amdsriov_ras_telemetry) <=3D
> +AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10,
> "amdsriov_ras_telemetry
> +must be " stringification(AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1) "
> +KB");
> +
>  #undef _stringification
>  #undef stringification
>  #endif
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index a75479593864..c101743b6299 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -30,28 +30,83 @@
>  #include "amdgpu_virt_ras_cmd.h"
>  #include "amdgpu_ras_mgr.h"
>
> +static int amdgpu_virt_ras_get_cmd_shared_mem(struct ras_core_context
> *ras_core,
> +             uint32_t cmd, uint32_t mem_size, struct
> amdgpu_virt_shared_mem
> +*shared_mem) {
> +     struct amdgpu_device *adev =3D ras_core->dev;
> +     struct amdsriov_ras_telemetry *ras_telemetry_cpu;
> +     struct amdsriov_ras_telemetry *ras_telemetry_gpu;
> +     uint64_t fw_vram_usage_start_offset =3D 0;
> +     uint64_t ras_telemetry_offset =3D 0;
> +
> +     if (!adev->virt.fw_reserve.ras_telemetry)
> +             return -EINVAL;
> +
> +     if (adev->mman.fw_vram_usage_va &&
> +         adev->mman.fw_vram_usage_va <=3D adev-
> >virt.fw_reserve.ras_telemetry) {
> +             fw_vram_usage_start_offset =3D adev-
> >mman.fw_vram_usage_start_offset;
> +             ras_telemetry_offset =3D (uintptr_t)adev-
> >virt.fw_reserve.ras_telemetry -
> +                             (uintptr_t)adev->mman.fw_vram_usage_va;
> +     } else if (adev->mman.drv_vram_usage_va &&
> +             adev->mman.drv_vram_usage_va <=3D adev-
> >virt.fw_reserve.ras_telemetry) {
> +             fw_vram_usage_start_offset =3D adev-
> >mman.drv_vram_usage_start_offset;
> +             ras_telemetry_offset =3D (uintptr_t)adev-
> >virt.fw_reserve.ras_telemetry -
> +                             (uintptr_t)adev->mman.drv_vram_usage_va;
> +     } else {
> +             return -EINVAL;
> +     }
> +
> +     ras_telemetry_cpu =3D
> +             (struct amdsriov_ras_telemetry *)adev-
> >virt.fw_reserve.ras_telemetry;
> +     ras_telemetry_gpu =3D
> +             (struct amdsriov_ras_telemetry
> *)(fw_vram_usage_start_offset +
> +                             ras_telemetry_offset);
> +
> +     if (cmd =3D=3D RAS_CMD__GET_ALL_BLOCK_ECC_STATUS) {
> +             if (mem_size > PAGE_SIZE)
> +                     return -ENOMEM;
> +
> +             shared_mem->cpu_addr =3D ras_telemetry_cpu-
> >uniras_shared_mem.blocks_ecc_buf;
> +             shared_mem->gpa =3D
> +                     (uintptr_t)ras_telemetry_gpu-
> >uniras_shared_mem.blocks_ecc_buf -
> +                                     adev->gmc.vram_start;
> +             shared_mem->size =3D mem_size;
> +     } else {
> +             if (mem_size > AMD_SRIOV_UNIRAS_CMD_MAX_SIZE)
> +                     return -ENOMEM;
> +
> +             shared_mem->cpu_addr =3D ras_telemetry_cpu-
> >uniras_shared_mem.cmd_buf;
> +             shared_mem->gpa =3D
> +                     (uintptr_t)ras_telemetry_gpu-
> >uniras_shared_mem.cmd_buf -
> +                                     adev->gmc.vram_start;
> +             shared_mem->size =3D mem_size;
> +     }
> +
> +     return 0;
> +}
> +
>  static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context
> *ras_core,
>                       struct ras_cmd_ctx *cmd, void *output_data, uint32_=
t
> output_size)  {
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core-
> >dev;
> +     struct amdgpu_ras_mgr *ras_mgr =3D
> amdgpu_ras_mgr_get_context(ras_core->dev);
> +     struct amdgpu_virt_ras_cmd *virt_ras =3D ras_mgr->virt_ras_cmd;
>       uint32_t mem_len =3D ALIGN(sizeof(*cmd) + output_size,
> AMDGPU_GPU_PAGE_SIZE);
>       struct ras_cmd_ctx *rcmd;
> -     struct amdgpu_bo *rcmd_bo =3D NULL;
> -     uint64_t mc_addr =3D 0;
> -     void *cpu_addr =3D NULL;
> +     struct amdgpu_virt_shared_mem shared_mem =3D {0};
>       int ret =3D 0;
>
> -     ret =3D amdgpu_bo_create_kernel(adev, mem_len, PAGE_SIZE,
> -                     AMDGPU_GEM_DOMAIN_VRAM, &rcmd_bo,
> &mc_addr, (void **)&cpu_addr);
> +     mutex_lock(&virt_ras->remote_access_lock);
> +
> +     ret =3D amdgpu_virt_ras_get_cmd_shared_mem(ras_core, cmd-
> >cmd_id,
> +mem_len, &shared_mem);
>       if (ret)
> -             return ret;
> +             goto out;
>
> -     rcmd =3D (struct ras_cmd_ctx *)cpu_addr;
> +     rcmd =3D (struct ras_cmd_ctx *)shared_mem.cpu_addr;
>       memset(rcmd, 0, mem_len);
>       memcpy(rcmd, cmd, sizeof(*cmd));
>
>       ret =3D amdgpu_virt_send_remote_ras_cmd(ras_core->dev,
> -                             mc_addr - adev->gmc.vram_start, mem_len);
> +                             shared_mem.gpa, mem_len);
>       if (!ret) {
>               if (rcmd->cmd_res) {
>                       ret =3D rcmd->cmd_res;
> @@ -65,8 +120,7 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct
> ras_core_context *ras_core,
>       }
>
>  out:
> -     amdgpu_bo_free_kernel(&rcmd_bo, &mc_addr, &cpu_addr);
> -
> +     mutex_unlock(&virt_ras->remote_access_lock);
>       return ret;
>  }
>
> @@ -77,6 +131,9 @@ static int amdgpu_virt_ras_send_remote_cmd(struct
> ras_core_context *ras_core,
>       struct ras_cmd_ctx rcmd =3D {0};
>       int ret;
>
> +     if (input_size > RAS_CMD_MAX_IN_SIZE)
> +             return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
> +
>       rcmd.cmd_id =3D cmd_id;
>       rcmd.input_size =3D input_size;
>       memcpy(rcmd.input_buff_raw, input_data, input_size); @@ -146,7
> +203,7 @@ static int amdgpu_virt_ras_get_batch_records(struct
> ras_core_context *ras_core,
>       struct ras_cmd_batch_trace_record_rsp *rsp =3D rsp_cache;
>       struct batch_ras_trace_info *batch;
>       int ret =3D 0;
> -     uint8_t i;
> +     uint32_t i;
>
>       if (!rsp->real_batch_num || (batch_id < rsp->start_batch_id) ||
>               (batch_id >=3D  (rsp->start_batch_id + rsp->real_batch_num)=
))
> { @@ -249,14 +306,14 @@ static int __fill_get_blocks_ecc_cmd(struct
> amdgpu_device *adev,  {
>       struct ras_cmd_ctx *rcmd;
>
> -     if (!blks_ecc || !blks_ecc->bo || !blks_ecc->cpu_addr)
> +     if (!blks_ecc || !blks_ecc->shared_mem.cpu_addr)
>               return -EINVAL;
>
> -     rcmd =3D (struct ras_cmd_ctx *)blks_ecc->cpu_addr;
> +     rcmd =3D (struct ras_cmd_ctx *)blks_ecc->shared_mem.cpu_addr;
>
>       rcmd->cmd_id =3D RAS_CMD__GET_ALL_BLOCK_ECC_STATUS;
>       rcmd->input_size =3D sizeof(struct ras_cmd_blocks_ecc_req);
> -     rcmd->output_buf_size =3D blks_ecc->size - sizeof(*rcmd);
> +     rcmd->output_buf_size =3D blks_ecc->shared_mem.size - sizeof(*rcmd)=
;
>
>       return 0;
>  }
> @@ -305,15 +362,15 @@ static int amdgpu_virt_ras_get_block_ecc(struct
> ras_core_context *ras_core,
>
>       if (!virt_ras->blocks_ecc.auto_update_actived) {
>               ret =3D __set_cmd_auto_update(adev,
> RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
> -                             blks_ecc->mc_addr - adev->gmc.vram_start,
> -                             blks_ecc->size, true);
> +                             blks_ecc->shared_mem.gpa,
> +                             blks_ecc->shared_mem.size, true);
>               if (ret)
>                       return ret;
>
>               blks_ecc->auto_update_actived =3D true;
>       }
>
> -     blks_ecc_cmd_ctx =3D blks_ecc->cpu_addr;
> +     blks_ecc_cmd_ctx =3D blks_ecc->shared_mem.cpu_addr;
>       blks_ecc_rsp =3D (struct ras_cmd_blocks_ecc_rsp *)blks_ecc_cmd_ctx-
> >output_buff_raw;
>
>       output_data->ce_count =3D blks_ecc_rsp->blocks[input_data-
> >block_id].ce_count;
> @@ -364,18 +421,24 @@ int amdgpu_virt_ras_handle_cmd(struct
> ras_core_context *ras_core,  int amdgpu_virt_ras_sw_init(struct
> amdgpu_device *adev)  {
>       struct amdgpu_ras_mgr *ras_mgr =3D
> amdgpu_ras_mgr_get_context(adev);
> +     struct amdgpu_virt_ras_cmd *virt_ras_cmd;
>
>       ras_mgr->virt_ras_cmd =3D kzalloc(sizeof(struct amdgpu_virt_ras_cmd=
),
> GFP_KERNEL);
>       if (!ras_mgr->virt_ras_cmd)
>               return -ENOMEM;
>
> +     virt_ras_cmd =3D ras_mgr->virt_ras_cmd;
> +     mutex_init(&virt_ras_cmd->remote_access_lock);
> +
>       return 0;
>  }
>
>  int amdgpu_virt_ras_sw_fini(struct amdgpu_device *adev)  {
>       struct amdgpu_ras_mgr *ras_mgr =3D
> amdgpu_ras_mgr_get_context(adev);
> +     struct amdgpu_virt_ras_cmd *virt_ras_cmd =3D ras_mgr->virt_ras_cmd;
>
> +     mutex_destroy(&virt_ras_cmd->remote_access_lock);
>       kfree(ras_mgr->virt_ras_cmd);
>       ras_mgr->virt_ras_cmd =3D NULL;
>
> @@ -392,11 +455,9 @@ int amdgpu_virt_ras_hw_init(struct amdgpu_device
> *adev)
>       amdgpu_virt_get_ras_capability(adev);
>
>       memset(blks_ecc, 0, sizeof(*blks_ecc));
> -     blks_ecc->size =3D PAGE_SIZE;
> -     if (amdgpu_bo_create_kernel(adev, blks_ecc->size,
> -                     PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
> -                     &blks_ecc->bo, &blks_ecc->mc_addr,
> -                     (void **)&blks_ecc->cpu_addr))
> +     if (amdgpu_virt_ras_get_cmd_shared_mem(ras_mgr->ras_core,
> +                     RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
> +                     PAGE_SIZE, &blks_ecc->shared_mem))
>               return -ENOMEM;
>
>       return 0;
> @@ -409,18 +470,15 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device
> *adev)
>                       (struct amdgpu_virt_ras_cmd *)ras_mgr-
> >virt_ras_cmd;
>       struct vram_blocks_ecc *blks_ecc =3D &virt_ras->blocks_ecc;
>
> -     if (blks_ecc->bo) {
> +     if (blks_ecc->shared_mem.cpu_addr) {
>               __set_cmd_auto_update(adev,
>                       RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
> -                     blks_ecc->mc_addr - adev->gmc.vram_start,
> -                     blks_ecc->size, false);
> +                     blks_ecc->shared_mem.gpa,
> +                     blks_ecc->shared_mem.size, false);
>
> -             memset(blks_ecc->cpu_addr, 0, blks_ecc->size);
> -             amdgpu_bo_free_kernel(&blks_ecc->bo,
> -                     &blks_ecc->mc_addr, &blks_ecc->cpu_addr);
> -
> -             memset(blks_ecc, 0, sizeof(*blks_ecc));
> +             memset(blks_ecc->shared_mem.cpu_addr, 0, blks_ecc-
> >shared_mem.size);
>       }
> +     memset(blks_ecc, 0, sizeof(*blks_ecc));
>
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
> index 53b0f3f60103..482a5fda72ab 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
> @@ -30,11 +30,14 @@ struct remote_batch_trace_mgr {
>       struct ras_cmd_batch_trace_record_rsp  batch_trace;  };
>
> -struct vram_blocks_ecc {
> -     struct amdgpu_bo *bo;
> -     uint64_t mc_addr;
> +struct amdgpu_virt_shared_mem {
> +     uint64_t gpa;
>       void *cpu_addr;
>       uint32_t size;
> +};
> +
> +struct vram_blocks_ecc {
> +     struct amdgpu_virt_shared_mem shared_mem;
>       bool auto_update_actived;
>  };
>
> @@ -42,6 +45,7 @@ struct amdgpu_virt_ras_cmd {
>       bool remote_uniras_supported;
>       struct remote_batch_trace_mgr batch_mgr;
>       struct vram_blocks_ecc blocks_ecc;
> +     struct mutex remote_access_lock;
>  };
>
>  int amdgpu_virt_ras_sw_init(struct amdgpu_device *adev);
> --
> 2.43.0

