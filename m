Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE3ACCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 04:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8035110E08F;
	Mon, 13 Oct 2025 04:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Ingw/R3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4D810E08F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 04:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBkI3OoMgSToA/IcWzMVNxackJbEC2onfLWdSsmH+5PoYHmUCIKiIFIUEJQaJL6MaFTqZaOTmmPlw66kMYJC7ifG7BUP+b8szppe6LUmm8icY6+PcOyTAT853sV+jhKx9/XKyIHhhm4T1+HVke1BXCqaP1CfAKmrXJknxr6WI60Kxkp0hBN0a5jV3FAJoHaD7UHxA47qbqdiYri2Ck+3POFrn+4CDfl/sSFjvnoHXRnTaPLI9SwmJwshf3L93R1j1mOyQ4XJle3tXTG6YuWqdiX+5J6wLxtzkJHJ9DC/p+C9CqjBveHpNqDQT06s9abYg2WCUvSL4bEP4F/JTym/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4VSoAldFfjhcOpdNpZQpdWTAySFuJFIxR9QWAb/Rc0=;
 b=IR1AoP769ZoZnxVDZn4McU0PX1uZWEEVvNz5Su38sC+62MJor82I78MkqPWGrtnY47ErlBaDkk1AMBgGGHfb1xzLPHTfFdb5IubcxdvjaWnCTIBc32z9igLzSBv6n+qsc/d3p4eoYZPhI6JNAQ42zABVKddaOdEr4pzJjvFdpVJzjpP4ZlTbCTdqfdRAKFS3aOU0P/mfDyndl70axnHLW99ieuH7TCZrFWHA5wkuxmExaSKGJmCQekTU5xXNx77mVIWKBdODaL4HGs1COE3N0JFQ8fWpYkAf0Y4uSrvMbbFn0sWciZvsA0vzzW5jo0rY87ivSvmGjZpdfAG6iezzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4VSoAldFfjhcOpdNpZQpdWTAySFuJFIxR9QWAb/Rc0=;
 b=0Ingw/R3CF3FVOn30zBGlo1vxWlFCHPg5WbYy4oga4Cdct2yznyB00yaR7Gsdil4s/pTJ9CJpK65oWkvbJkY8LpeImvWvGWrT2/MjaYqAw2YRORgIrwOQFk1VfCow0MGXJD6xD+4K4NmrsXPrkjYPtxA9OBXVCd6bLnc5QbagrU=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 04:54:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 04:54:58 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Lee, Peyton"
 <Peyton.Lee@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Subject: RE: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Thread-Topic: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Thread-Index: AQHcO60F9n0wfVQ85EWxZQ7QWAPx2rS/g0Gg
Date: Mon, 13 Oct 2025 04:54:58 +0000
Message-ID: <DS0PR12MB78042769FD23A8C5346A561497EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251012191823.856295-1-superm1@kernel.org>
In-Reply-To: <20251012191823.856295-1-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T04:53:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DS7PR12MB5837:EE_
x-ms-office365-filtering-correlation-id: 2a84f221-fe96-4fdd-6180-08de0a14a918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ignBtbSIxdTafDO4LezYKr3TwtzV6Roee1GVxwRdBoBDUhXlau4jDuE0JZ7r?=
 =?us-ascii?Q?v97cSpf+tNsdl3Dq2dL/jF0zYRX9wFafWB/cawettzc5ZIJmdJ6qqxhhZD/H?=
 =?us-ascii?Q?RIJMb/o7izH5Yg1pS8kk2e214+LaKPvA0xD73uScG2gkdQOj7WKgEQSmUJ5T?=
 =?us-ascii?Q?jZHdbxSpXWQhfv4Ao/NroW5Np5V1K02n1vl9dmgd2Wd0F/rVGpMtwNXkWS+5?=
 =?us-ascii?Q?2iSqPxgEJ7ft+lKG9SWQ9Z+ZVXmA4dkK6FED0WvEg3i2+56JO/FEn/a9a+29?=
 =?us-ascii?Q?9+IdHelW5SLJDyXtoTxruhYAHEGMN5S/nSuYcaKOZS3LOex3NWI1/RcIRBlu?=
 =?us-ascii?Q?Jhl4j4jD4pGm+amRLNoIoUOD/2vKMx2xrlnC/UWvGRHNkapJb66Wl5AQP4Rl?=
 =?us-ascii?Q?xw0AG3SmQGD78rYYFpBhSMsHN1IlvX9VhoaWumF8UuYYzaVTE8uxsjoEotiZ?=
 =?us-ascii?Q?BBezU+Ft0xyEFUzzOlny3Iq4x95eutp1PxXoNdf/BmSQrMXjFUZ72Y9UvWrN?=
 =?us-ascii?Q?wRE83C7K6drc7rVVuF7eZt7neS3GG/kZe5euHnRz+wW/jJu0KLl4o4pghb37?=
 =?us-ascii?Q?VJRdgShgihDGPFb/VjpQGD8AeT0fTYSKFOX6RLt/UZkPUE1x2epCNPv2Q0U/?=
 =?us-ascii?Q?FB+z78B9YyG0RSbSz0cvzdliHPp9J6lbRJgQ4Sho6nWYHBGBYZEX4tIL5woo?=
 =?us-ascii?Q?vx3WTBacx8wN7R+H/cowGsUHq0o+l+MZchSXECHRSL6z9S+rBh+wEfKJcBCV?=
 =?us-ascii?Q?4BNxTzeih4SH5uU8an+Q9cNmozD1QatWzYhErCBIvQgQyaNRmUMi0vJpVQOR?=
 =?us-ascii?Q?eYyxo0y5/V5sLY9c1i1iobj/1jkJW+ffI/KRbrRM3jr7qrcZuIQohIGUBUfm?=
 =?us-ascii?Q?uaq8B9lUWDbXnGvbIft55HF3/1WyV7xBtdlGPvxPb3026mWM2287UOd6ypZd?=
 =?us-ascii?Q?93f9GOUzktQvfpTxAGpLjEHh5V8pbuYsZdlb0muaIqdPrhpokfNhOS90hdgr?=
 =?us-ascii?Q?8rPdG50PcfXtc2YtrcDYExXY/x96Q0/3qIfY9euG0M6vu9Rhg58E0PyW6m1a?=
 =?us-ascii?Q?R6u6Y8bhzvJOgjRJJAjrgLh+vkeVYD+1bRFzTvRq3mEM8+p8XR4kcmMd7HOd?=
 =?us-ascii?Q?7s3e4JdECUdQSUu4XFtzYJikf2EobodKrFffMp5noqrX1aIqwQv6R38W0tyQ?=
 =?us-ascii?Q?d0w/WvjOdcfeNGi4oRtpMBjljhSvOeLlLHu3gEvLtY36aSFN7i0TJy8bXwK0?=
 =?us-ascii?Q?NsvNKJ8kgfoBmM110SI8xBwkPFpxx5O8FBrxECDyojQhchrRsBrymAIe5YgS?=
 =?us-ascii?Q?+e/4fQtZmSRt4qWL2rSi9oXo2eejnCl9eZdQVK3/19PIr/exhbv9nh+OD/0K?=
 =?us-ascii?Q?qUeQPyI+w4uhkxn9yiXZ15PJG2xnLr+LWEGLf86SVCdVD/bWeR79jWnbixhL?=
 =?us-ascii?Q?uW8UtYJpCb/k0J03emx1L1i8tR4hPFi6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6UzUNm+jcgwnymxnBOzCUcTkCUJGTg4W2anxWjKyy+a5H8SmPsciXteBTdLE?=
 =?us-ascii?Q?rC1XwxtfYIGwKs/A0ziSnHgNK9B1p0IW/MwiUtiwLT1ESUYlwz6zQla6f52N?=
 =?us-ascii?Q?xlNbnL98J6+mDgpXY/Cauojq+zu7i+I5UKED51PARP8I8Muv6RGjfT9Vk/qn?=
 =?us-ascii?Q?ozugwJTR09n4O9+PZZ8BHYBWzMLqyYd6i95iBj3vlk8uH2iBYfsZ+LHnzd6I?=
 =?us-ascii?Q?ujmFUPkBTZOcaodS1TW5DfPakRjeWjSLa0vPDMrV3kD1WNsGKkxOBdD+4mjQ?=
 =?us-ascii?Q?CulZLFNyXDYFerRAR5Z9wRFj1eVp3pQqni3d4lBLRIQsMluadCMiaGltmHgV?=
 =?us-ascii?Q?UamD9KdTcqISYzpryzCTrNPYDmiJwtlIovAxt7n0C1WugEWQDGWlIaf/Ibj0?=
 =?us-ascii?Q?Q/yB6sYhdtWNvI60NpAb22k5K+1ArG2EqvbGFYw7P69j/RkEh1pj118aVt+j?=
 =?us-ascii?Q?tctAcfK4LzhJb9bdhm1siQb2YgTIpHwl/4T/G03CI9IWSk4OOWlThjqmG/ab?=
 =?us-ascii?Q?4QB0qeBvnmzoHHE9tV6wL+s24KWO6vR9eeKW9vh9D3bnpP0+jvMuLR+qgygi?=
 =?us-ascii?Q?xwtLwHVyHgWtZvBmNB41hub50f3IK1MojN6sarY5r/LucIDzKMIc/e3WXNYY?=
 =?us-ascii?Q?G6eaQzgaygJf9pAcYO3xh29/9tC0tKyf9nAeXgni+1SQXhuLROgfC+VYlD9F?=
 =?us-ascii?Q?bVrJO6T6VcWmvwdufc+Q4cQGNTNmOgjR8KZtTj72bQ/NTL24vgMnNmy9AlPI?=
 =?us-ascii?Q?LtSEwCeXxOiAAZCPnxBwrO+LO6y8KqYqsb36st7b/MrgaMb86FhFAOoKqPrL?=
 =?us-ascii?Q?Zd9bxXt6uS5nIuuhca8Rl5FvhL+R2MXGr17EWys442cVQGKDqJDfUmcjaqgg?=
 =?us-ascii?Q?G/SduLQ4ilBvlKxyVtDDyXV5sbLMB3M+6yqi19g9OVg04I67i0oVBQd9hk0c?=
 =?us-ascii?Q?YPlk0/b8kOBtPXI4UGrSn6jUVa0ALBqlkZjN2z14lXJRtIXkT0LgcVXkb12L?=
 =?us-ascii?Q?stVCXKmHHSry63HRSUIyFUza158N0z1ZoOGOP6tDNX0tj5v7M0y7Fa+JBLyr?=
 =?us-ascii?Q?P9cRrsK9EcMKvFUjLjL2wxcuuwSSG9DpV7k4FCDyEKGpfOF5u/YR3/Izjpc4?=
 =?us-ascii?Q?ss8wXqkjIdUMd1gK9RUPIl8DI1nO/0Z4S89SABfUUBvnDAGDWME71BpslgJe?=
 =?us-ascii?Q?uwBgnS2miXPrTSSyi0aJT2VUNcb9rek/kCH0HEUwEmH+UbabhOMV4J9vyxtG?=
 =?us-ascii?Q?mhSsEnbw5nZgYYdYd6LyWbwtnL6cUF4T1K++E7TY9oDu9hSptV+sV23Jy313?=
 =?us-ascii?Q?Aj1OEjoJiOoDMHmzwZA/Nb9cq1GKU5mo+CbWw/o00xyA08QNEMKaErOum6On?=
 =?us-ascii?Q?gm01r3C4gMcV3xofBg6psLbOHJ4MGAriNI+SyDDsNxg0CS+fA8Z7IbmfbMYK?=
 =?us-ascii?Q?adnRjQVwMxdIGC2rKwExODPqzZcNoOwZlcZlolTnZzs5Mf2pLUlHpxxQcI2E?=
 =?us-ascii?Q?TeflUH8AJevQqx8jyO4GY6Z6cpjWZaLf/NCpJB3Lrc7FGiMbhix24zr45ZHR?=
 =?us-ascii?Q?GntuK3zSLCTWNzwogk8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a84f221-fe96-4fdd-6180-08de0a14a918
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 04:54:58.5396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVTjKakDAuMCALQP4OjNfU55SXHAA4QNHqbQTOKoBU8cZtYrTlb35Wh9JNoNpc1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

Doesn't this translate to just a higher idle timeout (VPE_IDLE_TIMEOUT ) fo=
r the particular VPE version?

Thanks,
Lijo
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>Limonciello (AMD)
>Sent: Monday, October 13, 2025 12:48 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Lee, Peyton
><Peyton.Lee@amd.com>; Sultan Alsawaf <sultan@kerneltoast.com>
>Subject: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
>handler
>
>From: Mario Limonciello <mario.limonciello@amd.com>
>
>[Why]
>Newer VPE microcode has functionality that will decrease DPM level only wh=
en
>a workload has run for 2 or more seconds.  If VPE is turned off before thi=
s DPM
>decrease, the SOC can get stuck with a higher DPM level.
>
>This can happen from amdgpu's ring buffer test because it's a short quick
>workload for VPE and VPE is turned off after 1s.
>
>[How]
>In idle handler besides checking fences are drained check that VPE DPM lev=
el is
>really is at DPM0. If not, schedule delayed work again until it is.
>
>Cc: Peyton.Lee@amd.com
>Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
>Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
>Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>---
>v3:
> * Use label to avoid a register read if fences active
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 15 ++++++++++++---
> 1 file changed, 12 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>index 474bfe36c0c2f..e8e512de5992a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>@@ -326,14 +326,23 @@ static void vpe_idle_work_handler(struct
>work_struct *work)  {
>       struct amdgpu_device *adev =3D
>               container_of(work, struct amdgpu_device,
>vpe.idle_work.work);
>+      struct amdgpu_vpe *vpe =3D &adev->vpe;
>       unsigned int fences =3D 0;
>+      uint32_t dpm_level;
>
>       fences +=3D amdgpu_fence_count_emitted(&adev->vpe.ring);
>+      if (fences)
>+              goto reschedule;
>
>-      if (fences =3D=3D 0)
>+      dpm_level =3D adev->pm.dpm_enabled ?
>+                  RREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>regs.dpm_request_lv)) : 0;
>+      if (!dpm_level) {
>               amdgpu_device_ip_set_powergating_state(adev,
>AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
>-      else
>-              schedule_delayed_work(&adev->vpe.idle_work,
>VPE_IDLE_TIMEOUT);
>+              return;
>+      }
>+
>+reschedule:
>+      schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> }
>
> static int vpe_common_init(struct amdgpu_vpe *vpe)
>--
>2.43.0

