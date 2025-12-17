Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990DED66B9A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 19:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A35B10E249;
	Wed, 17 Dec 2025 19:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUuMItx8";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D792410E249
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 19:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxlULTBJDzXHy631Yv9v1a2twgpwzUGf3rjeeV/MGO1O4xa6RrgEeOMPUldZzYUDlTXZHNX95JyIEXX3jdoZr4l4pWpv34HQtz4Rab+rQGFJsnR01ewShrNa/W8YzRsLWGkgcvwW5aI1fqcqvOUfFl2l1CpBGLWw9lIC6NVfPtetrQ0RTN9W7d4Owtwp2VRSwxDeGwCA/MYxp3QsbFlBTb7TCBYKTs+rLV084JhKIl3Q3jz+swmOIYNzAEGSnmvt9pVuTYOtSEAAGWFKQ8kuaqbtWXurdWyp3U9h8KJEHyf4WfgD6HHNQvFA25xkiBTtyT4IqyV7AG3vYKqtMZXkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBc74kG2cyAz896hzz308fVm+mml6CLVy7rNQUmc6b4=;
 b=k4sqys5Ci0LZIJF/eURgp05Yi0QcJTUsZunFHJrTphBTv7J86oW6fahO5G1Fn4qaoOX+7ttvtMPD7mqX5BJY5YBG51WXM66YmxyI1R/9Evqtbb7V9nY5mq442bLhP0z/KW/QHQfhHy2j9YvD+GIUYZxClcDaMHqUVQSoKBH85oOF85fUtoy5oCo7lwkm8p1+LYrrUbrDqUTz0hKMbHJrtiNOIq4n15Orx7E9bUxuwMlR2hlXOPKQ0JaOT+tsi/kiTD8tuaRSBjohtf8ExYXZQigrjIHqHr0Au8mx3u+djfu0lerMyl/65JZsMNhQ1GohR9EagJcsGta6D+hRE6Z3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBc74kG2cyAz896hzz308fVm+mml6CLVy7rNQUmc6b4=;
 b=YUuMItx8VjgK9Y96Yj395FgBHEtO1HS2E6Mik1yfWTOa+x5zfg144TbVRBPli6fE/SOc8UGaFJTHJqoUyGvOgeP1aMNPEYbhqg74a4LonFa0JWrS4pNX10wPQlzOl23RTLO9YGz+LS3FeWg4YgmlEdXff8gURmHpoQAKBI9vb+M=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 19:21:12 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 19:21:11 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/4] VCN and JPEG 5.3 support
Thread-Topic: [PATCH 0/4] VCN and JPEG 5.3 support
Thread-Index: AQHcb2rV/wA3qemd50aY+3Cn1ECICrUmNXiQ
Date: Wed, 17 Dec 2025 19:21:11 +0000
Message-ID: <SJ1PR12MB6194D297F0765F6322820EDC95ABA@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20251217153521.2018841-1-alexander.deucher@amd.com>
In-Reply-To: <20251217153521.2018841-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-17T19:20:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|MN2PR12MB4304:EE_
x-ms-office365-filtering-correlation-id: 9a1efb67-3f6b-459c-04fc-08de3da17070
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EtXYhuU+oEjdfHU5ecSMR7RMCcqxfipEmkZ6h72A6N1rz7oDkyJAQkYWE1id?=
 =?us-ascii?Q?WM0hQ9QkJr8aNtXGeF8FGhL2nUtQdbnH0T9B4CKiyGwuFs/6YoswhZbRw4Mc?=
 =?us-ascii?Q?xWaGtyTrIyR1YJbOhSTzGddnMGCvzZx+jp8+WeNH63shSp3caHP/FnC1A0lQ?=
 =?us-ascii?Q?GMHNIiP1YT2MBm7LhYmfuoj6AMsX/xveTP8xOJjf8hPSBu+z7WGr1frIjXBq?=
 =?us-ascii?Q?6ibBxp7e21uidDS9OIeAK6a9wwM/7pEvpYR9DC9o3/95v/fx8Oc4dUXn4Z/p?=
 =?us-ascii?Q?JbAIJvz+/6k+j44juvTs3GIJ60ImyAbDfihgvRf9cm1Kmgi25RY0QlfxTe5Y?=
 =?us-ascii?Q?3w1vMPDKszpUFoWwySSHY23xlHAh6vMUcyKk1j0ax4prii5C9/5T3fbWh6Fb?=
 =?us-ascii?Q?RjQzfFJtAKbBydFu0BoP0o0q6EGrEbj2JLj88oqexflmOHgUI2NvdAdYbRAx?=
 =?us-ascii?Q?LhyhQe1iOptBNCkUsB/agEl75n+9laKQ2lD8OHtQfdcCF3ojt1IPQg/orKTq?=
 =?us-ascii?Q?iHfqOuI5LtiBci4QTg8SC7UqauBjEI70Of1nfATt1/xYSVW9FgBNaChda5Mc?=
 =?us-ascii?Q?x7RErssYBvi7dkMRPOGVWhsCg0GZMoekGHWuEXXHQfwgsP30mctbAUhAmuzI?=
 =?us-ascii?Q?QJsr4OhN2uoOLEaV0xE0WHz5LIZpHtSopP1pQTVnaZJ6XO2t4PKKylchV7g3?=
 =?us-ascii?Q?FWItg1P/HnQYTJ684Rrsd8lEDmxeAcQerMTn2xQDaTUcNJeZU16QSY9fCECu?=
 =?us-ascii?Q?261JuT8Owx4BqyjmCCBO0HS6UCXRPie1IX0OkfPhUN3K4SHHC3gGR2q0u3/2?=
 =?us-ascii?Q?P3kuuiDUr8C3NZNXgx7S7lrr09Eg7bmE0XisMUFCKAHOaUUM2Lq5BMNAShJH?=
 =?us-ascii?Q?WzI1nxdP4jXTzu7/pyO5c247AXdB8Jz9/kMum+HNpJ/t8T1uxW4sZlILH/DF?=
 =?us-ascii?Q?6/02fSYxliJ/d1VlxW3TJ03VJ26m3M0BfOxf21ZbLJvprH2d5IZBM0SLpjlA?=
 =?us-ascii?Q?BthFIxtAKEhnmIaMmXCFwWqzRgI5HuBthIkFOfVScQ0w32Y+v62ulIKYufUt?=
 =?us-ascii?Q?aom29Enwyyg4Ydv4hqND1DPZZeWc9vkxjwYaIWIt74HCoX+vYj8R1Lg2jKgh?=
 =?us-ascii?Q?OdE3BZ5OmjCqYDjqKgmOc34/ABlcek6BaL+kKcY6cRn6tCEdkc2ue0Sd3mYf?=
 =?us-ascii?Q?eLrHMcmLDCDCriQDZiUthKHTLAsjIOMKfoNlqK+5Gij6SNM8et5D0IvyTFYg?=
 =?us-ascii?Q?WWfofWJeyJZi/mvmA6wi2WE1uO/OT5uM9YBxlUFhxspOOKv3bgtsq8+vh/jS?=
 =?us-ascii?Q?7LQjtFsyHZ2CD+l7XevGY+8gzTGCnjX+WnhUjT8/+Twvm9rHk9rBDxYClf1c?=
 =?us-ascii?Q?srpzoNgwiNwQExrZXcmWUfbnZLpgfpBtgYv9vWnTtMyajy7lBC7D/RFUkZwN?=
 =?us-ascii?Q?XWsakMeQmrYnWrYsRMV2ibpgZNYdVLztHd01Q17a/NPwPx5/1zqXW8Afw6bw?=
 =?us-ascii?Q?SxT/HETDNVZzXEE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RP8FHZfbSysztBb9luwE+R20kGUtwtyzhQeh9Y5F9NnDjMf5djJQlyO3rzjn?=
 =?us-ascii?Q?6FbqrlpNy8SqUB/tsQuo8/s0YJZMC7wHkpRUR4MJksXc+mbokhFluoQl5CNw?=
 =?us-ascii?Q?uF6qEZpsqS9IMCeXJ23lI9jQVutoEwGXMhXVTVvoqFdL+wZ/OCFmj+vS+poh?=
 =?us-ascii?Q?9r43tzu/260xrvNsVmj7ow0/rNR6/fvedLkh2+Oh6DBi6aLUHDFTtpsip7k2?=
 =?us-ascii?Q?VhOUJf4IX2nN+66tKBwnzeKElzcJSRMdTkLwMB4fRgajCzXJfeH3hc+4eaVu?=
 =?us-ascii?Q?TD6mgPm7ICgT9RbEri+7p6Kkqtho4It8/cOaaWxuz4SU9YFTw1BpfgsXBHmP?=
 =?us-ascii?Q?D96PjbqGH96ZPBC2c+Es9k8OUD3o1WxbPSFQ73EVDEScmdNAn5gsaONf/d8F?=
 =?us-ascii?Q?P4ExKz6Et/ouKyqS+tEdMo0CjLUXNqFiyFgG/S6jToVX+X/sG6p2JH2NjBpw?=
 =?us-ascii?Q?7yANp/oDqu0nIiUY33LFHZDltw/VnVAi92+AFJ5KIPuIZpIWABUsAJGsPg7L?=
 =?us-ascii?Q?SXphxeNaIvbxLPSUtEE7/7sgKD/YWW+eJXv8b7aCr+z/fUSIhcktDA0hdOGq?=
 =?us-ascii?Q?YU2Ea+0ZfJ0BFpusN8+mMZ2Td5bF3hbLCy0creWkL6YtGGj/4ki+/JHEJt//?=
 =?us-ascii?Q?VmuTHx4RbV5L5uAz0Whi/kzdI/HeBAkziLh+aNwcUGEWldylbC3NSHo6ybox?=
 =?us-ascii?Q?xypvX5KCrrKHejghjLVgd/oaPalC5NIKP6aLBB1Y4p+528T4pQpnasakNj1s?=
 =?us-ascii?Q?z+/b79ohVbtyFQnaHJSQcz96Ujn6L3CprEVSSEhpE/mGVt/SqKpi5W8B3V6h?=
 =?us-ascii?Q?cCsSK4PuS7kTX/jujm1ppu4/EY9lM9RAD8BFDk5ztA+1ldoGylSuJEsl+ATN?=
 =?us-ascii?Q?14igaUnsBIhvcQ9ewu2UztQrXhNyF9wDvtfbjcDQ0+xn5QtCOiSbrsozahcY?=
 =?us-ascii?Q?Y33/Xf2pLe7LDVabKA6hO4nHOUFEZhQgPH3mzVcJghdoYqlb4BjlxrLJG6Zj?=
 =?us-ascii?Q?57SlfZX7XStCqVvIpX4OQyn7Z+3jvUL8t6EIdOpnf0Zkdm9cZMWPoZjkAd/n?=
 =?us-ascii?Q?bOwoGKs7G4jkDQzCtUVVt9PLjz7abNrGWSaDlLx2qVWBYlnxga7beHOCDKeN?=
 =?us-ascii?Q?l/Fj57NGKhdFrEfNSFcwM9rO2OSX9tRIpQa5bQVRIGR41+rB/jjVQkG/1DyK?=
 =?us-ascii?Q?vJx56TX1Ti/hYGknUcIjDD00mSPRYHiJ9IQuya1CINGW4dYEBtklnw1hPOrz?=
 =?us-ascii?Q?8vj7n3vvbZA/9+ENT/22eZ/ps4NSOQ3f8bcl3Ez3HvN2/kWdxYnAUeCPBUHf?=
 =?us-ascii?Q?jtqRjEW5ElGZT9EFbI0zE7yRnl7+lRPtU8ruwYJHg4V4vk113sz0nRFPquUM?=
 =?us-ascii?Q?xVno0CtuR25Bn49tZNrjr3BXIA5LSk7xtV3ZfWO+l9wfVPr3XRdaL6qDGCIr?=
 =?us-ascii?Q?rcO9TrR+zgL7hmivJ2XHwZCNDMLkp/N6y5Tuz/TZs3VDVm/EzENlp1phyk6j?=
 =?us-ascii?Q?W+Lz6u+hPQ7sBhDe7KzbBte0NJDoMqp62uh2vCsg72tt5duP8/rgEu4ZXCAo?=
 =?us-ascii?Q?7skw1u3RYTWWjED7DJI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1efb67-3f6b-459c-04fc-08de3da17070
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 19:21:11.8092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /S0Mjw0ily5Ad/kVXuQarjJz/v0FQPoN3kvcrxAhLMAwUyGBy0/zWD9rD+1zuqen
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

This series is

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, December 17, 2025 10:35 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 0/4] VCN and JPEG 5.3 support

This adds support for VCN and JPEG 5.3.  The first patch adds the register =
headers which are too large for the mailing list.

Alex Deucher (2):
  drm/amdgpu: add VCN 5.3.0 headers
  drm/amdgpu: add queue reset support for jpeg 5.3

Saleemkhan Jamadar (2):
  drm/amdgpu/jpeg: Add jpeg 5.3.0 support
  drm/amdgpu/discovery: add vcn and jpeg ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |    2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c      |  714 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h      |   35 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   39 +-
 .../include/asic_reg/vcn/vcn_5_3_0_offset.h   | 1783 ++++
 .../include/asic_reg/vcn/vcn_5_3_0_sh_mask.h  | 8262 +++++++++++++++++
 8 files changed, 10840 insertions(+), 4 deletions(-)  create mode 100644 d=
rivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_3_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_3_0_sh_m=
ask.h

--
2.52.0

