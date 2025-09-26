Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B60CAC5B9
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 12:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D919610E0AD;
	Fri, 26 Sep 2025 12:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NVmxvZI+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0C210E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 12:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9NN9PcGkXZ1p0+9wazs8H7u53J5e/9vi5NfksJceiUJDNMP0VD8OTD/PKoUdJmN093kR8HxuTD8jZCURtLvrnF8jv04brvZ+ZUOCGRjGx8mBrXLZxHBIdZYs3HEZyPLg05P4YGtr2qaXSzfeoi72yVIj9FN4KND50FD0gwlxVBhQKw9obe38OHJYADnS2jD5jCxU5or6DbYwnJW+FCAQjdOYsDgBJ18awjwUwZmpIKZsSbwtxI8l1z8LCtuIqkgH5vfiRyze+66m6gSN+jKvoUCfYg1BA1UF26K2o2zHfNpfbAziLGiAQDwaSH5e6nU5IuoG1VO9MYhZts7FJ9MnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCRo3nYEqT0V1QGUYzxNl2wNpNCINQvtkirN4pMTgeg=;
 b=SyjB097wuFP1YWHiqo1u0KJrRYQMMWbpP9C0DZWiswP07tay1r1LP4GVLCywEnvmPE4ugUcWMS8dOGQqbVRSzaXEja0zBfpyxnkYtCmJ+94RNp8Nr4UKtcXBj6mMR3s7UO+HMVGrw84AeUlZCUqFppZgt4ndY2C+YtanxHN7OpVOCVdT9C9xJQgUaTJrAMKyXtY3xbVBASt5mfEL73gJ0IjP6yBiTGazmOFV0EVMA1AMPRseGaxCt2NEMOomDzaril3tCppRtpfFbJ+rkRsJhqZqa61OnsQlbA+Fri5o4lTa+6VYINw7HSoX7Z4oc0zy760q9DuWf1QbpRRm3tbo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCRo3nYEqT0V1QGUYzxNl2wNpNCINQvtkirN4pMTgeg=;
 b=NVmxvZI+8Og8sM/5MDdSdtTgyz/mQYzACmCqe/yi3T9WEmwjtpGAYK3ZA1JimircpVenkH2dJdfFZs2+3Uop6wF5D3CuNhhkq3pIGxWgBTNynPypz4IQfDZo+G3sz8ygvC/Pj9NdtrP/Gt/kCeYTA9iOXaibymy5coKrT0cy2Rg=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 12:15:09 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%7]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 12:15:09 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Alex
 Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs
Thread-Index: AQHcLb3s6UL7shuXbUi44aqAy82marSlYthg
Date: Fri, 26 Sep 2025 12:15:08 +0000
Message-ID: <CH0PR12MB5372C777CC9FAC5F2140E4AEF41EA@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250925014352.338578-1-shaoyun.liu@amd.com>
In-Reply-To: <20250925014352.338578-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-26T12:14:53.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS0PR12MB8562:EE_
x-ms-office365-filtering-correlation-id: e6b94277-c51f-4a6c-f469-08ddfcf655f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021|3613699012; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8QcnSwi+IJ3kJH0MHhWmqNSjJh6oSY4Xh63KGu+te61zM0MvfDmobwt2VLft?=
 =?us-ascii?Q?BzQW9fzmoh272exB63GqyqrS9RHBBLL5GzBqxGWd/hrTOX2hdmAmZFSiOv84?=
 =?us-ascii?Q?utN7Dv1q2AobHpOB1Bq9/uEUY+XL/jzPIXZd/XaTUoOYpxZoJxhD7WIbTRht?=
 =?us-ascii?Q?QETWE2wb6SLnaJKirsueqHX/MF2byEEgvgiVGu4Vkm9gHYeCaaVtAVtZ1GCY?=
 =?us-ascii?Q?NfpTGcDn/gYd/euDo3yUrfeddFdLipIDfxIL/peOEkAgtrhTRLuf1N1KupKc?=
 =?us-ascii?Q?WC4JRzpb1YY0XRlkFSKvVkUz7xx26tXyiVO9rqLd4rsZxhyPUsBuZ1upvKEO?=
 =?us-ascii?Q?82eGmSJjqWnHOZ3dmA0agLlB3MxJlEc5yNZm4K4qWWmdnVXzpyJBZSBWYb8v?=
 =?us-ascii?Q?/jO93zx3IJfVRdpMC7w2IUV4KttP0z/azcP9H9vvB+cfSLsKfdZHhREL0WJk?=
 =?us-ascii?Q?ef+vCR/+UD+oi14QEPAz5nB4fxlYcurCZm8BHY2R7e1+Uh5ql61IgVb18qhr?=
 =?us-ascii?Q?1jf8T2Z9Sw4Aw+C7hmZhP42lsQ6GF2rloo0Lx/iKMLF4uDWF3A2m0c9FD3LO?=
 =?us-ascii?Q?39M90PnwKM1CD4U878xmtYUZHx6iAygSzryHDH9Z+x6Ot8stObcxQ71zXXYC?=
 =?us-ascii?Q?U15nlA3X0NW/2rAJLs0wknnZdKlhbMkmst0WISLB0Q2PLbmExuEsGAQggedX?=
 =?us-ascii?Q?HvL2tvBBtcWXQD0i2F0xm/V5ZC1QU04oEqOSBN+IPD4va1UnwfXIB89YYUbG?=
 =?us-ascii?Q?ULRYX5QuntWs1wnyVHChbVInRDGBEqvKXQukak179yYfwT1ytU7NtzPoYbz3?=
 =?us-ascii?Q?iOMGPS1y2gfG3CNFrPploLze/lzwm2n52XWr/F1rYD5VYtNhC3WYI2eHTAnq?=
 =?us-ascii?Q?Wpj7FkLHoUsKjWb1BgzaLtoDvW3ZsQelL1wLN3BM8JIRmxWHzvCb4mKqizMQ?=
 =?us-ascii?Q?EYR6ih4/X2XuOOoZJUPBAUv1f0UIBtxKMalHnS0D9oKRPH9BzpuiOvu6maN3?=
 =?us-ascii?Q?XVkZ/7nOKv1Dj7HuNO610S/jBlNz50LnkiHtkRVc/+XvGY/nLixnOOZkjZna?=
 =?us-ascii?Q?qGBo8aEVLVQZkZ+YRpxOjpKIKkTZ7iBv58tIHT2oBjHrqIia5DDO5hMYp0eo?=
 =?us-ascii?Q?hd1YD3ZSgYyGGb9yVN4jaUz6cPQ3ePqToqugHnY+lV5uaZK07q7K8/s7TKXU?=
 =?us-ascii?Q?SJMOv9jcsTMOK1AxS+CDOLd8et1G4Y0i/z/VnVWbeBBJREuEpjWnHZG31lab?=
 =?us-ascii?Q?WK7akmmn/Sj0HjoC8tAOkrmshAZmZFVJh5YelhEpJXF0vEW8SKjjQRayWlUI?=
 =?us-ascii?Q?ZDklkpRPX84qFkJw8QuBUZ5hTwFE2ogcAW699vD1t+6e/cV1zLjl1ijm/oAF?=
 =?us-ascii?Q?mo4YamHzjhznLpuNplJXD5CZmYdoIwiBUHkcO7CgCIqTHmvSsFFqJSYgnA6x?=
 =?us-ascii?Q?zSZq6irr5+g2bmpCbniob4Tjo+Y2SwwhD6MVauK1BcUpnSdk6GGXGpKopF3J?=
 =?us-ascii?Q?by/OMuj9hdi3jzoxb2cU/wWUxEXE5V9Camz8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021)(3613699012);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hSCaQNlXaJx0wR9hyd2zfuZiGoOntvVF4ecLq8gGl0Xmukv32wAFEXdlPKK3?=
 =?us-ascii?Q?fzjMZg/yE1ey6l5GF4eNbEEz7LDEswnAd94GRDH2/HKJ/qI9nqBGKLR8oKhA?=
 =?us-ascii?Q?Fi6iE/BWFq5WbfYrTb7VSnuLdZitZsdpbInlRQBhUz7+/YKFmYz6+fCI8+k1?=
 =?us-ascii?Q?5nmw7HtTGD65RiswaKI6uVJe83YSxX5+6wKV7ujzf+RTc1f85YdeoN5Pqr4A?=
 =?us-ascii?Q?FGmpjfD9a0X0BiS0bpg2DZCfUWW2Pq1+ALwlmSIfZAXnFDoXHmPr/4OAY+fe?=
 =?us-ascii?Q?rff7YBja7b2mvQEbHWq6Zw8VzT2U9P84B85yJkYSapD2HgceHX4HPAK4SnSh?=
 =?us-ascii?Q?rqAHfV7i6sfpdXKwqhJsKc6seb3aegY/obH9UvCxho9+3SeK/P4vwqFFSIlc?=
 =?us-ascii?Q?XnLwulGALJUlmhJzDUxCInaegZmE8PmUq5fVyykecxVrmW1mL1LI812pGYN5?=
 =?us-ascii?Q?5+VbjnfoSy2Oan70wC7sugfXJnn3WTvkBQrTDO+r5kpNm0ZjRfG+xeCwSjtH?=
 =?us-ascii?Q?5+nTK0+/DKAhIY8h4Q26xImEzNJBbmiBobLSF7yjwc94FGxjdh+dlynIZ/HJ?=
 =?us-ascii?Q?VG5lNIni9ezgQzVL7vhMd9a/kBO954tiyGT4tg1fm3New3avFfdH+m1ZLbFy?=
 =?us-ascii?Q?TbVzo4MaSS/D4YfqEFOEMTZX1WK/KqRnpmFlLyxyMq10UaWWYxU9TXgOP/SJ?=
 =?us-ascii?Q?+jlwowzXOxURP9A691K4CUHklliySrAyJLTt9xnJgolWQ/DWys06f/1cdWFe?=
 =?us-ascii?Q?gLWmgs7PyFRTHMAQiUDBD2zHEz5JQjxiOKX5jCO89EPy03H+bk97C3HgUBdO?=
 =?us-ascii?Q?SUjP4xxUDfVMHwB32yDviDXMYF+Of7jCAIVZo0jIXuugKJqmn/5luusckYpa?=
 =?us-ascii?Q?NK1M90yCnYp1YDtYiriUnpAMUStN3oKCOS69YD28q4Jw2ZOQffyAIHPjj4S9?=
 =?us-ascii?Q?aa0JoaOdrC5cqvOrzrOxdVfmGCoKMCYONUXF6ejF1fwKMMvgVGZqWNLQtEUG?=
 =?us-ascii?Q?5kKNptmU1yWMKacZVnAnUyI9mlEBE2bNGlDScPCQ0cpA11bojuDhB4vy1o03?=
 =?us-ascii?Q?ZuOsCFTwj72iVLWHgyBl33JYRfmIUaLpRR7C7VjH79MfwqD0US6JKRyG9bFa?=
 =?us-ascii?Q?JnBpkSl1eu2LmR9ag0LwR6WCGrY3mUJtWWTmi2hHAAEjMWT4677Rv5HnkSob?=
 =?us-ascii?Q?YOvbOYnrcE+RlsiZBVtq/acvlCAL+RveBcEcgQ2LW9YSXyDoycsBZ+ki0Spg?=
 =?us-ascii?Q?mGtD6Tf/FzB/jumyTPgKpbmyBctpE8ESCzvAdVYs40375zc7qa6jueGP8658?=
 =?us-ascii?Q?daFRgxsW9ctNFW2cPuobYrbsMkAtEB5q0gCEbwcqg9RcZLCVAwhd3kQ7tskY?=
 =?us-ascii?Q?F0CbdZ+VaPbKS8p84irGjxzet+MoiV0vDrPmAdOsvmBTF/AhVjZfTOlWsGxm?=
 =?us-ascii?Q?metzCO8LMbaKRbakVNnqHFTSqQeBnZTkM+s2dFX4htI8VHXF3kBpZZFEgIYj?=
 =?us-ascii?Q?I4GTqCPxG6aEHJR1Is3E4oBuKVegzHxnFFTEsFdUt6bMsVPr1KnVNV9m+1Fc?=
 =?us-ascii?Q?LZSO/Pppb/QVjW9WIAA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b94277-c51f-4a6c-f469-08ddfcf655f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 12:15:09.0434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pnJjkBLIQr79AwA1fIKxZP6Cj+bPuiapExjQW1gsk2HLSZZKOgU72prUByKRdj2ubgh8DNxRSoXO+vqncmiMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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

ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Wednesday, September 24, 2025 9:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs

MES version 0x83 is not stable to use the inv_tlbs API. Defer it to 0x84 ve=
rtsion.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 404cc8c2ff2c..f4a19357ccbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -337,7 +337,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
        int vmid, i;

        if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].s=
ched.ready &&
-           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x83) =
{
+           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x84) =
{
                struct mes_inv_tlbs_pasid_input input =3D {0};
                input.pasid =3D pasid;
                input.flush_type =3D flush_type;
--
2.34.1

