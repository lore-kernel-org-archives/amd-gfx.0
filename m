Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959FEC47DAF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 10:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3ECE10EC35;
	Mon, 22 Jan 2024 10:00:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B460710EC4C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 10:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoCyVE7boW/HpyzHTj601G5Ii1Ky3p3VaiX5D8W66Yp9Vy4E5P1uOXlk2MNPy5HMZZ790Bzkn5x8w0/C94QFxIiJog2GvDVmy5xt5YLWqiEgARdeXYHZ+oL2iKq/FQxG/dRdyQ5V6D010ys41ZX8vMbMeEMKaQSATOdcUKclZ553Jz9Wm2bcb6isL+7LTyzxp6YCOxzl8fa6nnXu1fcXxx6UjJll/ZR7G2/h3YJhiqqUB3O0R/geo9c1KrTC/gYCxyjXwTV/O2S8BqWCyMxxaEV4zLwy+DCwnxCcc53CJ7YexSHVB/INbsEQsQhScF/sXVLHmTAsnlKdcDf7QakLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdU8ILzC8cK1XCv2iokNH1zYuw/JIAzzgQ3Kvr/CRug=;
 b=L1AknqfKDchtelDYsMXyoizkRADHj8tExV4CtMc6klnoyNfpzbyG9H2vhF+8oI3LvpIjBExu1ogzSyLmiBtjma3LXpjr307O3L/yHTYzRlvv59BaFMwfGj/03Xxgv/mmWZceI8khMtOTK8/hEibvbhDlD3bhVw0FiOYtnsMfK04V6B5zVnys+uyTjxsOxYVPtFgAPngQ9ovMJqUUQhVD4ckJsgJvLbcUjbtzBpfCDMrCiuhkgQfJTHiGGj/gUf9hN7PBdsqvRHhXdL0qHJebj3JUzW4JUj8xpw+29Untaoa5H3eSSrckIJLZ5swFI0XzFLx89ftr0M4DIjPHZ9M7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdU8ILzC8cK1XCv2iokNH1zYuw/JIAzzgQ3Kvr/CRug=;
 b=LWC8wvpPHQcmQdv7CgtDbKr5mY1KIJ0jdr/yKij8HlA+VN2ZKwCB6KHqSZI8I0PY3mSHq5mjeLbKBy19+Reiw7JFAGm3Cg/sohfG5R93eySz+JrQUiBQUbs26VF1aMkhtG/MzQEXq+Y/Rho+QBJsxhtzOp0Pmob6TEdqCynucDM=
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Mon, 22 Jan
 2024 10:00:25 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:00:24 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix null pointer dereference
Thread-Topic: [PATCH] drm/amdgpu: Fix null pointer dereference
Thread-Index: AQHaTRlosBCMTJvP/UeDF3C82OyPIbDlmR0w
Date: Mon, 22 Jan 2024 10:00:24 +0000
Message-ID: <PH7PR12MB78201130D8C1B4A992FB884E97752@PH7PR12MB7820.namprd12.prod.outlook.com>
References: <20240122095708.3759-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240122095708.3759-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b86b0c25-22c3-4ea3-a914-2e99d1a32410;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-22T09:59:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7820:EE_|DM8PR12MB5429:EE_
x-ms-office365-filtering-correlation-id: 8b42c892-b234-4bc3-9c84-08dc1b30f42c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: avijcrljauGdSvpXGxKbbM1C9yCfsiBMerxhFKA7XR1G8po3AzaAx4JH1MpiHKXYFON9Ua+YHSPgqjfHFUTC3CfhbeXyKR/5vyCX4TObEJwl/hXai2TDVknQkpBWiR/i+mxH7ClK2ciWBXFzrsYBCjZNczkzD4kExmPyjyixvkdLMhQn6BwQGQpaEcXR4yAOF1zYIxOnnSsykc74xfr8ohaekZuaX26TMeiLBG1C/YEHsdryJSXYAm/qwP5NXAw/TLzcmTpIGHFuQUA5ObROESeUxCwlT36JDPY9l9tKMFFlamWqmE4rsw6tmmoCVBralouQockiE/tFUUi5ea84zBa4+JUYvqp4afvh+/rSJ/KaPiirnnQOly1riAqgHqkG5pYCWM2deRDYwdduheNKgIuVfKMO7MumnxRS1POt5Oa0IggJmCLc+HrN0kBKQC7RNRi8KzxBC/00XpDAA7LqSd3sD75fbs4FFSmwCTnkMTLn2RFMAM2X8PU2tVH2bOysOIbq80ePdFPLjSTIEWsS4kbYAphFyqNcfEuDLJ9MVQX6ozWfZ1m4v6xCeV7j/C5dVDPpeKOsp+bAVXi5Bb6WOTNwbOebuIT3MhGtE++P4WoGflR5f2VdpTm5a/4vgPIm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(9686003)(7696005)(26005)(6506007)(53546011)(71200400001)(38100700002)(86362001)(33656002)(38070700009)(8936002)(8676002)(52536014)(2906002)(122000001)(83380400001)(5660300002)(41300700001)(316002)(478600001)(66446008)(66556008)(110136005)(66476007)(64756008)(76116006)(6636002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?52ZjPis/oJ/ehq26NDIYS2877FVmAQrJZzlZUu9q8cfRqoiyfE+JI8oQbVhJ?=
 =?us-ascii?Q?l/IeZKNLHe7QEtZ3ogijYlfP5yMvveFCY4SU9SleY7GUdGOnVF+u9IZVaVg+?=
 =?us-ascii?Q?OEGWxh6vgxMuLr4QXbf0uFrDkqMKJtuHJIISNrezE4PpSfApNX/0XmhC9fsi?=
 =?us-ascii?Q?RwRMwGPJIuYQ8y0/hUdbrT1EKI9OJRfNjIavBKwz3UPEmI9nosWJ375hQe94?=
 =?us-ascii?Q?lHDtTFpvD4aG+UcHeSK8UTvZq1wy9STqF0jFPoFCLgpd3qHzAvk3pCM+op/s?=
 =?us-ascii?Q?UWrIR+hX7O2XDf5K3EkO+QN3OstQHfPt3+J9dMh8TUXcpNJbGeMSMcs+Y2+P?=
 =?us-ascii?Q?o9DJSckdqf8RntbPXZs6YKuFcwFxQgwVNLxFCiMBhAy1zrN9Rqd89hbRW1HL?=
 =?us-ascii?Q?CbOAkQdmU1vf4goduXUn5KH4Ey/VFpLp2x/ReKsBm1j6OY6geCPktC7VUwDp?=
 =?us-ascii?Q?t756llcRXhkLI+/N1fcSVKWKdQKZ+gWUNT8hD2tWttd5Jfqm8f/MUQKlvv/f?=
 =?us-ascii?Q?+NJHxfP0qYoN+u5+CR1Yp1OGzJwQeDipUzLhoptm6oNglIPZ0NjMCpffaJlm?=
 =?us-ascii?Q?LNxJMg6ZNqTmYc9H3HMh2d1kSPpISnk4UvyR0Pp0pkMdUtTR/WfsW7YOVLtH?=
 =?us-ascii?Q?PJnS3IZc38rFQNm7luCqrTHmyswwEKDFjwkoGGMbr6qjnIRw79fbqEJoTa0f?=
 =?us-ascii?Q?aqsFf5rN+aNbPlyVuWbb7ZanWMcbw5jOnhsWfLIL/sb9yIcfv+vQj7CPbar2?=
 =?us-ascii?Q?LQW44Mnql9DSV8JUJ8UPsznYM/9pLVgBkoa9m+mhMM3UNSK5aE6CjIlOXUUk?=
 =?us-ascii?Q?q2AAH8piJWUmBEI0dX6b85xQrewtfZCpM4KoiIqCPeXdaeuYDoV7+s7Jwv7O?=
 =?us-ascii?Q?4rC05SwRIQzsTWB93FxjnLf4hpqbjais0PbMPpH6lk1dHRjSEp3cvY8cZr+f?=
 =?us-ascii?Q?GnyhI+QdfsHWC5ySBNA5LRogHQDT8sjHzbNMviGWdRg7nGHDL52rjNY521Qu?=
 =?us-ascii?Q?MkKsQrEzVpgC8Q//F+uj99dn56anrEWANeGlSJyVVM2mhLNOfVgov1TQ8Fia?=
 =?us-ascii?Q?n5axyuwKZz9YvzwVZbgR45jaYeM78/9FXyejcFDuJ6jzWEJa+PYIsP7fCP9f?=
 =?us-ascii?Q?z7LLTwue8A/Kvfmg64Oy+DS8xlnBCrOnxJDEOLsBQzg98tctio6Nqgi1sBCE?=
 =?us-ascii?Q?nmvAQzdTr6k+YcFp8NSds0sWiTNHLk9KwGnb+p+jPnFlAeEbX29Sjfr49sgV?=
 =?us-ascii?Q?1OOuDmeqtjG8NxqP78RKUI73Mvd7Xcn/i19sbq1xC5F9GtOoGGJnXi38/LsZ?=
 =?us-ascii?Q?/aDliLeJYVOeiarLzLzfR5W0G+yqk4iigbu+vElp8h2+5PpGVpIBMnNRvFYj?=
 =?us-ascii?Q?MrWYreFm9rPuF99Dnn/QtNzFPQ0TzOodf94RGzoM5ZsvGr5/r9Qv47z1zztV?=
 =?us-ascii?Q?KJlL1rGpb+4G5WPnFVBTGrrLFb3sL5S5OEAhSjLxm1Dz2V6EUNKyBxycECbO?=
 =?us-ascii?Q?dAntHdedFw7DR6AhBvQIcZuISIwqdAOajcRF6K23OdyH2I6SRh3+kCff/9Q/?=
 =?us-ascii?Q?oZl0Qy5jU7/GsLE1ar0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b42c892-b234-4bc3-9c84-08dc1b30f42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 10:00:24.8553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPUH8ilrD8zqFZhfIslUzjJnxmckOtW67II+Gwc/wxRd8WGKZRUn3QLlZJ68XCCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
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

[AMD Official Use Only - General]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, January 22, 2024 3:27 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix null pointer dereference

amdgpu_reg_state_sysfs_fini could be invoked at the time when asic_func is =
even not initialized, i.e., amdgpu_discovery_init fails for some reason.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/include/amdgpu_reg_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h b/drivers/gpu/d=
rm/amd/include/amdgpu_reg_state.h
index be519c8edf49..335980e2afbf 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
@@ -138,7 +138,7 @@ static inline size_t amdgpu_reginst_size(uint16_t num_i=
nst, size_t inst_size,  }

 #define amdgpu_asic_get_reg_state_supported(adev) \
-       ((adev)->asic_funcs->get_reg_state ? 1 : 0)
+       (((adev)->asic_funcs && (adev)->asic_funcs->get_reg_state) ? 1 : 0)

 #define amdgpu_asic_get_reg_state(adev, state, buf, size)                 =
 \
        ((adev)->asic_funcs->get_reg_state ?                               =
\
--
2.17.1

