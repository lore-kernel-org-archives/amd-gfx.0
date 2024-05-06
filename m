Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD82CC4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 08:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E930112214;
	Mon,  6 May 2024 08:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2CBK4rgQ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE5F112214
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 08:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2MClZhWlRf1oHl8OlbJZ72ISnwJ+pEG0DS+oDitslTm6b8n/AAqL/sG4bN95G/Dn6yJxWHEhBoXf5LLyT0UyICSzB9nOLHye65uxSI0pdYjEiYULpul7HC81wFRW0oipRxRL8RIfOpAAK5Qz87X6ywTurtby2Ku8VoeO8odfr1x+kwU+n3ToIL6sg0KbSdUmVRWFhykUTiwp6pLnnxwNRm0W/595hG987nV8jcTvodAHN8TrjRMagEfce13Ci/uYwjtI3A39YqiyQP4AtXSTXJdHtcR5jrdbD0mtyztQbG0fHzVEZY9uSJEdEfQxaZ6nXEv8xr0RQJrgEm/d/hQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfewZFLoo+n6luHL0S9SswBOo3+Y8OxwSCV1W+OR+4A=;
 b=l2r5h8pOYKDKFA67af0XtNv85+2IBBI+W6f5d9VMByQRHxB+v9ekx7s7PPlsDEd/GLClPE/5oL3TKYQEpieboxi+oiai1un9RtlAjsbr1OL6gMS0RtEhrYf6+cxDyxjju3UkxA04bMOE7KQXe0cCpOlaLLfMKy+D945B9+iaEnUb/oS+W1b3Bw/N1n+edoStK2EEJNZlcUNPyoYmNXg440vhbsZnr3JSwNzT3kwANI2pVb+GpuB0RIkjzayLJKLC7KfesCZFVi6ynouxST8CDz9zvLc49oWmKH9w4CAtcPZmeQ5BwXFlOB0l97n9pSrxwOIUWDYJi91RnbDyuKamAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfewZFLoo+n6luHL0S9SswBOo3+Y8OxwSCV1W+OR+4A=;
 b=2CBK4rgQVIDJpdfw+/1cJha+izigipnnd9YL2SwqRL1eDzTj047Vb1X1mWnpYhfBwvPjRssiB6mL4Rywx4QycyWImi2lFpYUak/7OqsXrTUvo/302Cum0HPiOfhM8tciuly66g7u3pD+ueJT4WnvgC+KQAtePDRzOxJzsrcZ11k=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:00:50 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:00:50 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Aldabagh, Maad"
 <Maad.Aldabagh@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>, "Li, Yunxiang
 (Teddy)" <Yunxiang.Li@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft
 recovery
Thread-Topic: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft
 recovery
Thread-Index: AQHamgdG1U/NBMw0XUihwQYt5KbtubF+5kjwgAr5Xf8=
Date: Mon, 6 May 2024 08:00:50 +0000
Message-ID: <DM4PR12MB593767EEC55FCBF64CE838DAE51C2@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20240429073132.12611-1-kenneth.feng@amd.com>
 <DM4PR12MB5165D1DA3E54E3C6BE20E3CB8E1B2@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165D1DA3E54E3C6BE20E3CB8E1B2@DM4PR12MB5165.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T08:13:51.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|IA1PR12MB6386:EE_
x-ms-office365-filtering-correlation-id: 792b7ea1-7c1e-4995-0fb3-08dc6da2a563
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?lSHqdUK8cUwxi1SKt3fuu9qTOeYP4kZKsKYwIf1rf4w8w411qjiLlZaA4Y72?=
 =?us-ascii?Q?26TfCI2RQOyzM6py+tkQVssF6aMH7y9s+asfnCl4bTLsCVbXXFL/0tTweNPV?=
 =?us-ascii?Q?L9a8jOKi5Y719wQF7JXGnUBte1CTxocMM4E4l/FlM0BiTytZdQJf+0yUhAsg?=
 =?us-ascii?Q?mxKftAtfCGApgFhee5EeCOVId0KIFXcYJRisYUvyRJX8RnXLYhZ7uQwmvzq3?=
 =?us-ascii?Q?0fjvwF8LnnMsiL381lYS9mPnIMowvmemFwGUOJSAdqphb9KdQlXmcuFdQ3tQ?=
 =?us-ascii?Q?6L5ZgGX16yvFYbEJAmkTYIBAiizTVOo2H7ztS8N/q6kdR+83we7R7HA7z3zy?=
 =?us-ascii?Q?Y8FYsdbUKsvNhqRPmeucd87OrieJxXOBf5o/Ggw4/TdzWzF2IZIsorrJ8V3I?=
 =?us-ascii?Q?CpF8ElSR/yMDU+izGHSI1MrO0rjOwHECroWFkTxGZH2cu/eqEllbd5WX48Kw?=
 =?us-ascii?Q?zCAT0A8tcgOF2K/lN3aNFfdSzliX+N0frI8XGWzWFA5Gn+vzRqz+vvu9NsEK?=
 =?us-ascii?Q?AVJg7h8bPfJ5Ue/d44ZgTVyyTRC1h1saTN8s/Pe/5tvyZLtF+6qxeGrx8rJQ?=
 =?us-ascii?Q?xBjVFzkXjc+D+0iXC9A2uA0kATSRzXrLMJi3Q/+ViAGnSN9M8oXfP5ylP0dD?=
 =?us-ascii?Q?Vr5O1BoDrvxMtsBO26VtDY4JDYLtiVfbt7rCEHaapITlaa91jpD6fHqo9bHi?=
 =?us-ascii?Q?ahXVewD3tbe0wMDKZlJX2z6reOeumb2KRoCzeidvkXi51zOIbyU3ZGjsdlkm?=
 =?us-ascii?Q?A8ZhkT4So/7WCPoXG4xr6UjqIpEFGglpX6vvbxdRWG9OzGYGay48rFlH5GNi?=
 =?us-ascii?Q?xAscZV5HSBQK1wL96qPucZTZnyDT+eG0zjJ1HpwdC5sbPZMoPgSJJ9e7Va43?=
 =?us-ascii?Q?63zmW4DWgolbT8kWp5NiR70DNhmfyUrLJDgzI7/6+VeVAUTNB0MGAxVHOJE8?=
 =?us-ascii?Q?PuSwkqgwfbprzG7kEiMUSc18JBZSMVx5JLaBXsI79TdCVSASjROhjAprEDlr?=
 =?us-ascii?Q?9VIFVqFfmm4VLNNRgYqjbshu3j9XEXYrH144c1E8RPiJHXW5hlS/S241nF1Q?=
 =?us-ascii?Q?P+jGFIWsSkey3pf7RcQsBIXOcDdHul9XFABADX7TeTh4H021rwT4pLYN6vk7?=
 =?us-ascii?Q?pIx/iw6cNX9z6rsQILe+uXNVenbFXC97yd2kTPkLHKfQL6y0INq7rZVO2FZr?=
 =?us-ascii?Q?aq8ocLBs6f829+P1JLaO6Fyg26ZH2z6Z1IGgonTd67QevjS1vjozHv3LlpN0?=
 =?us-ascii?Q?ietEdrEM4Wm7N+7neJyyjAlbX+LPzuZTz3eZq1u7d1W04kpoZ6MU6z8jR65+?=
 =?us-ascii?Q?F+n4W3Jd8S/8dzqefOmwddGq2s2GJGXbyVVSpH3dxIWaRQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LXFCYA1aCtgVXoIhQ5s3YQGmgaKCXSN6fpv0ImqfNnjgW066GytZskZKrodX?=
 =?us-ascii?Q?+tKWyNh6wNegT7JylfMdqkjy09OiDOc/uEdT+u8y9g3bv+Tltf23QS+jciHc?=
 =?us-ascii?Q?iJYnrO22MGFgX8teIRQyOvFrb1wb+fc/b3QpB8lZ7uEXkB7jFyNvCwKUkI2h?=
 =?us-ascii?Q?Rwg2LaglzhRHU2KHgS0b28xwLcyGx5WYmlctpxIGtYXjCFDBmTgGfieLAH8G?=
 =?us-ascii?Q?Igfr3Sme1rfhMHxtgA7NRzUOMZshZesEZIOemKV9PomGVbZAoMGMC0HoJ6HX?=
 =?us-ascii?Q?FNw8LSnKitgfc+3CQ1P1xnV1iFamClOz1XLqnpfWBsVvQ9LvteEeGvDenLdk?=
 =?us-ascii?Q?NKcqInh8pDlDFkZzW4A3BsSORAfQIyoXQAqR35WQCG+OtxHCJtH9Ih9kjW4S?=
 =?us-ascii?Q?Q0cD97DwAAYgscHRratwR6WLa/M56HT3GblGLrDhL1b5Ru0f4vjEw6IvpcCt?=
 =?us-ascii?Q?WFvOdvlcDGXpJDRBGwVOeBxQkCZ/lCIA5GqNS/Tl85lvzJBUGCNhv91yNGys?=
 =?us-ascii?Q?/a49Sil9LM7E1ewEmBJU0fCoCuMGKKduzggYNb2WzrX35FN/x0T0oom2Tmva?=
 =?us-ascii?Q?VNdAEwRH3aglh/XvL7TUBfTj57q+xwCAWj5sbINUwAGnK4dqgUqNsKnz99ZK?=
 =?us-ascii?Q?cjwslK600QZh+ivQcMj9gNmm78V7Ui/bgE9i9IkKDLVGSmJcKJLXLBfUdTxi?=
 =?us-ascii?Q?0UMVWC/rk3DGg8Rp8cT/G5/KJnTepEcdNlqj61YzCuQJN3tRnoAX15tbWzXq?=
 =?us-ascii?Q?Dq8TIa06VOkU1M1AcR8Olpl6lJanw2Qe/p+fIx+vFuqtuzq50+rtlhZfsDD+?=
 =?us-ascii?Q?zzY4MdIrX8H/YT3JN+dSODCJaHHtxh4e4Q0b5m53eCSkTWBzT57dzeEk9tWi?=
 =?us-ascii?Q?9f1bh/AS9FxjpZ5o7BYC/ay7gnvsLyvx4v195HtgGSbCGky04C2hc3jM0uso?=
 =?us-ascii?Q?vC9N3Aopi2DLu2oQcuRNaZvEn4Vp6+52qN13ur9RaMi3zp/h723VAwaWT5tb?=
 =?us-ascii?Q?WL3V/4lit8C4JtS6YFp0xMQTUDRl+fm8DmZZRwVhGG7x7oe4LeoQ/yQXJsK+?=
 =?us-ascii?Q?miXqfVG837HG+N/WZ2yBhLzGz/hKRqKViRHGGRewhf+Edxnm43qlhlopJn8s?=
 =?us-ascii?Q?Mw4jDl40cCDPvU63LTQZ2ua/yKPmX+pi0q3jgNkUELN72dancU8eiGoKSZYh?=
 =?us-ascii?Q?kyPi+h5DwinQmBav9lSJgn5DiEXoqdRKxmrXCh65Mscfgn0tyU4LGXzD1Pxx?=
 =?us-ascii?Q?+elqHVD8DZstq5Z1UkTXscePNu6Dz+hxLymBGeysFYxXUZENF9dyxMBPIqQF?=
 =?us-ascii?Q?uiQIo0keQ4ME5Ls7kpTpF37THRPeNgoat3iOMpeZzkiKKPIRfcsJXhRma0lB?=
 =?us-ascii?Q?XB6PkL/IdQOWh6HQQlaFIP46LfxJQ694VtlUCPQS8Y7oX8UOLFUrP+p+BDai?=
 =?us-ascii?Q?J4fqRo1LEXrcfRMZiPPuJF4C9zdD7lhX58qeBgee3en/tD++/pUMs1cWe4ac?=
 =?us-ascii?Q?nJq6WjvjqgCJ7wp9kfZvTaHzpK1np6uibkG/ACBrplVMRmFCMa6UHKgrE/uS?=
 =?us-ascii?Q?kVKM35J/7uZuRS/RGaY5PoeUunm4iLYlox8JCXo3eCVxuvSw6a+7ZgGBZeoe?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB593767EEC55FCBF64CE838DAE51C2DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792b7ea1-7c1e-4995-0fb3-08dc6da2a563
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 08:00:50.6529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYiqJDONtwcm5CLnujLZ5jqtEoYG4ID48wUtXuh+PhpNfV5/jdiYMIoWQZ8vVDzlv2G6vWGk3HWwNDy9EQK2bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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

--_000_DM4PR12MB593767EEC55FCBF64CE838DAE51C2DM4PR12MB5937namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi @Deucher, Alexander<mailto:Alexander.Deucher@amd.com> and @Koenig, Chris=
tian<mailto:Christian.Koenig@amd.com>

Could you help review this patch? Customer needs this toggle to turn off so=
ftware recovery and use mode2 reset directly. This toggle is also needed wh=
en we test mode2 reset using quark tool.

Thanks
Sam

From: Feng, Kenneth <Kenneth.Feng@amd.com>
Date: Monday, April 29, 2024 at 16:14
To: Feng, Kenneth <Kenneth.Feng@amd.com>, amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>, Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>, Aldabagh, Maad <Maad.Aldabagh@=
amd.com>, Ma, Qing (Mark) <Qing.Ma@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft =
recovery
[AMD Official Use Only - General]

+@Zhang, GuoQing (Sam)

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Monday, April 29, 2024 3:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>; Aldabagh, Maad <Maad.Aldabagh@=
amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>; Feng, Kenneth <Kenneth.Feng@am=
d.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft reco=
very

customized the reset to skip soft recovery

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/amdgpu_job.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index ea14f1c8f430..65c3a387fec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -548,7 +548,7 @@ module_param_named(compute_multipipe, amdgpu_compute_mu=
ltipipe, int, 0444);
  * DOC: gpu_recovery (int)
  * Set to enable GPU recovery mechanism (1 =3D enable, 0 =3D disable). The=
 default is -1 (auto, disabled except SRIOV).
  */
-MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =3D enab=
le, 0 =3D disable, -1 =3D auto)");
+MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =3D
+enable, 0 =3D disable, -1 =3D auto, 2 =3D customized)");
 module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index e4742b65032d..5c75993698a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -51,7 +51,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct=
 drm_sched_job *s_job)

        adev->job_hang =3D true;

-       if (amdgpu_gpu_recovery &&
+       if (amdgpu_gpu_recovery && amdgpu_gpu_recovery !=3D 2 &&
            amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->pare=
nt)) {
                DRM_ERROR("ring %s timeout, but soft recovered\n",
                          s_job->sched->name);
--
2.34.1

--_000_DM4PR12MB593767EEC55FCBF64CE838DAE51C2DM4PR12MB5937namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
</span><span style=3D"font-family:&quot;Aptos&quot;,sans-serif"><a id=3D"OW=
AAMF8548CD07BB205478DF776E1014D2B98" href=3D"mailto:Alexander.Deucher@amd.c=
om"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration=
:none">@Deucher, Alexander</span></a></span><span lang=3D"EN-US" style=3D"f=
ont-family:&quot;Aptos&quot;,sans-serif">
 and <a id=3D"OWAAM645E9576D2BF254CB415F66326EABD7B" href=3D"mailto:Christi=
an.Koenig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Could you help review this patch? Customer needs this t=
oggle to turn off software recovery and use mode2 reset directly. This togg=
le is also needed when we test mode2 reset using
 quark tool.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Date: </b>Monday, April 29, 2024 at 16:14<br>
<b>To: </b>Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;, amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;, Zhang, GuoQing (Sam) &lt;G=
uoQing.Zhang@amd.com&gt;<br>
<b>Cc: </b>Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;, Aldabagh, Maad &l=
t;Maad.Aldabagh@amd.com&gt;, Ma, Qing (Mark) &lt;Qing.Ma@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH 1/2] drm/amd/amdgpu: customized the reset to ski=
p soft recovery</span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-family:&quot;Times New Roman&quot;,serif">[AMD Offi=
cial Use Only - General]<br>
<br>
+@Zhang, GuoQing (Sam)<br>
<br>
-----Original Message-----<br>
From: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
Sent: Monday, April 29, 2024 3:32 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;; Aldabagh, Maad &lt;Maad.=
Aldabagh@amd.com&gt;; Ma, Qing (Mark) &lt;Qing.Ma@amd.com&gt;; Feng, Kennet=
h &lt;Kenneth.Feng@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft reco=
very<br>
<br>
customized the reset to skip soft recovery<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-&nbsp; drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c | 2 +-<br>
&nbsp;2 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index ea14f1c8f430..65c3a387fec7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -548,7 +548,7 @@ module_param_named(compute_multipipe, amdgpu_compute_mu=
ltipipe, int, 0444);<br>
&nbsp; * DOC: gpu_recovery (int)<br>
&nbsp; * Set to enable GPU recovery mechanism (1 =3D enable, 0 =3D disable)=
. The default is -1 (auto, disabled except SRIOV).<br>
&nbsp; */<br>
-MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (1 =3D=
 enable, 0 =3D disable, -1 =3D auto)&quot;);<br>
+MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (1 =3D=
<br>
+enable, 0 =3D disable, -1 =3D auto, 2 =3D customized)&quot;);<br>
&nbsp;module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);<br>
<br>
&nbsp;/**<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c<br>
index e4742b65032d..5c75993698a5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
@@ -51,7 +51,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct=
 drm_sched_job *s_job)<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;job_hang =3D true;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gpu_recovery &amp;&amp;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gpu_recovery &amp;&amp; am=
dgpu_gpu_recovery !=3D 2 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_r=
ing_soft_recovery(ring, job-&gt;vmid, s_job-&gt;s_fence-&gt;parent)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_ERROR(&quot;ring %s timeout, but soft recovered\n&quot;=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 s_job-&gt;sched-&gt;name);<br>
--<br>
2.34.1</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB593767EEC55FCBF64CE838DAE51C2DM4PR12MB5937namp_--
