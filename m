Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A663C021B5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1836510E407;
	Mon, 24 Feb 2025 13:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BG5N6hgR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDDE10E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 04:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6D0MFRp8U3HG4KNl20uqIDpQDrbl63aWF5u6Rvkib6W4VMf+3lsF8SqCQUzG3uzyALApM/mjuMgrSVOFyANoo4gxZpRYA2s9vpGmCq0IYKxMin/LBm8dey8ox7S5ns4FMo8FTUMdR2tRMo+waVjI77XCa/2APqNk2T3ibfPpbQ1qgPrmyDoaP4YtofRJ1UWGn3c/2Darsx/8R82k8bs/TImcgijytxl9I9bU63zuxIeQjR3JSGOfPzTTfXHUXO3sRMZdMLmMKjyhEKrKLLN8YKzzMOVMbxoXvxH3LQ3atfOHCBuydkHeBlNIf0pNPLmWaaSesMIhqfuOGlAG1x2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHQpQOcgz0ed0IZE1SnP62qrDreVAQZOjRMUqGkYiUs=;
 b=Y3UEJqMQBAHId6wryGXXHUB2Rtlm8L10N9uoXP7VogrGeEOUMWF2baSNuiTZmhK4QwUq/5v8FTqVLkJfkxaL/SGgQjzz5CYpv4o+EqCKVOhY1XUwSoeVclRhNMGpMI/p0TWl1Sx4eZL49KPvP5M1vHarZVgXJE35qKV5bkPzm3rmjhcnNVKBp7wLP9CuED42JsNDrQzsYKl2mRca2dD39PWmJsKFq3QbAW0ajPIOiFODleGMRpqrcTyFf6KmsyaAny3ii1MferUiE406JTI8XzYgn1DbYNbPcoAXtuEvCBq9g47IIIT1Tyv4IqN0OFqgZInl37vgzz6XqN+89DnpeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHQpQOcgz0ed0IZE1SnP62qrDreVAQZOjRMUqGkYiUs=;
 b=BG5N6hgRh2QaAM86sMq6oxckEcvEZNosNUvohJPep+yR1dpV9XL8TXw6Vx7EjHhooGrJ8uIyORFtfN9RlbORilde7NdtaGenBFL0knKVVGHrLQgg915SyIg0dCBJmurYVjFfq4pIhYjIbwTY2b+Pe5aURI8edCCgNyeSMU2J53Q=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 04:09:40 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 04:09:40 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)
Thread-Topic: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)
Thread-Index: AQHbhHbEC0IX1EOjt0SwgkhpAnXPtrNV2sAQ
Date: Mon, 24 Feb 2025 04:09:40 +0000
Message-ID: <DM4PR12MB5152894BD17E39A73080E8DBE3C02@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250221153901.3508931-1-alexander.deucher@amd.com>
In-Reply-To: <20250221153901.3508931-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1f378ac3-2c47-4333-87f3-ed4b2427be96;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T04:09:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PR12MB7721:EE_
x-ms-office365-filtering-correlation-id: 81990e6e-53c2-4dfe-f37e-08dd54890fa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LuClG0Ob7IqK/dyury3wgojvORt5/QRqIzIWjY8GZwolmjHsCJHcRU6jKvdN?=
 =?us-ascii?Q?UOtCkYDiVr3E/ztzRKAX5ok1/tj5QL7oDCZEYz171ojP9W6bWVhSkAJk8CzO?=
 =?us-ascii?Q?VA+k70cCGpgaZJyyDCpCkhpSRDgR6itjXLMa4iWac+iw7UGhcLDw8f0ArhaD?=
 =?us-ascii?Q?tHB9FLUAW1Ufi7XMl/s7cWVHaR0XEbivHU5XRVN6AKqNI5InNg8xuVeyLC15?=
 =?us-ascii?Q?x2M8KLrS47+/z4oig7zPHKvtZIp1TbgD/PF/R5EirsD8enj15sKXvrOsp07n?=
 =?us-ascii?Q?2ozuZEUM1KYw3GqjOqAccqAg0G/8a5l7BLSMU0U/dBdDCEjEIGeDwnwgaSAe?=
 =?us-ascii?Q?COBQ2mfazF4s6YN31rx8EtN7QCr7D8QNZIAOo9AFA69IBo6nTHBREZnzQ+LQ?=
 =?us-ascii?Q?mArw7IfYdDEP8v/Ccwk/nTMfBDn6Y01JwJkf3ygNMkERgIA+uBzybilQsYeY?=
 =?us-ascii?Q?YSdWQK60Qs+hvV2lVLAdU1XCXxjX/SdhWYbXhXPaicJ4KwfRwesTg0/10Tkk?=
 =?us-ascii?Q?ITzH5hc1CAmzOHM7ha/bKUo06mPA3u9dkOZIBLohFS/nYY30mUsfT5oew4lo?=
 =?us-ascii?Q?X/rKsB++Kp9QIHg7F7T0b77/qRgyJp05Xv25BTsGVb7p/cZW2IoBMO/C2P7l?=
 =?us-ascii?Q?+ZMB4T1xuLzgcBBJEXtpkrGAmOasOyz/iUySqRp1JhBTJxOBmJVcSvZnNYnG?=
 =?us-ascii?Q?XXQzoR8ksrJkMywuhAhBHILzEvh5U+gdU+1uOfSMaArGdw/GJ8kSaeyD2x7B?=
 =?us-ascii?Q?/rCiNHKZwLyV4ZksNIRZvtFjfv+37L+JCtIEMEOrSk6oJYaOFgoFAnJT2cKo?=
 =?us-ascii?Q?DcVI+PgePjTiKmRgmCeDOYn0q1lRe4RhmOGjAWKOwVmLlIpEQ7H0rdD9InDF?=
 =?us-ascii?Q?8fn3etKLrnJTii0fQ8VJaAkL6+Tny7xktqkZjMSb6VK1dM7Fw0rECWwBYio1?=
 =?us-ascii?Q?6fQB3PF/7oS0zLdstILWhaD2j7f6i9osfe/7rI2p+gKtaFhuEL6S+vVGegk2?=
 =?us-ascii?Q?06Fz7Bo+1IURAv588++HmXomesTHQXxmSe3OD+QuePp9s+4BtJ+XN4Fud7qi?=
 =?us-ascii?Q?D60FuR55STmxEWHlaGAxIn91ly25lIKr2g0MQSSjZB1V/i90Srv5TthTp1zH?=
 =?us-ascii?Q?x7Bfbt+ywImziUC+WLhdetdY8w3zwbUgCuuFrBSkSgc1HrcU2yq9EfHJ6Zoh?=
 =?us-ascii?Q?UDDJozVLTUjxQOUZnbArFnT8buBwrxNOKtoP2KI0wLNrEsyUZHt8v23kt9zf?=
 =?us-ascii?Q?bHjkgBl+53UY8neSppKL39D4NH7vUOnOn84O6Sm2E7wEyIwPsegcDt/rdDmW?=
 =?us-ascii?Q?4YyeCg19BUZwrhVwv4kzPDk+oyBkdYgwzd9rHIPxtYjgG/mQFDNBVmgBRY6Q?=
 =?us-ascii?Q?7AewTj2J0eta2ejIrHOA6IEFEhCggV0kZ0iML8Vv9YGYgH9zMq3zinI6WmVx?=
 =?us-ascii?Q?kC5iiTo4KTStxiyFZZFJhfoec8QfZgF4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B1atHj7gJf/cyMR43ynV8Ns1suS1QmicSQeGQXb6jmSKEpj0jSqaQP/LtgpN?=
 =?us-ascii?Q?dNc60crkC+kYwlPJd0N7Xw5oFMYyXj4qouk5X62dlE/He+Z3byDUvx9hWbkp?=
 =?us-ascii?Q?N1gai5kZm730hdq/W3MbyB5GqTKskekAxvJ+H3e+pLVnAo+LHkVFjW2uhgl/?=
 =?us-ascii?Q?kyL1PFSEQJCvlqMp1V6YHCxuw20QJ3JlmjgTeb1XhZRRwp9ty+h9l+svldCa?=
 =?us-ascii?Q?gA2zPYEDFvHp8GnfuL5R7A+PUQDcbqVuGUT0X3eoV59YgS5+HTFbMclqg4ep?=
 =?us-ascii?Q?qllp7qyOAHtqXmGZHyJ2+moMJcezXvYD3y2RKgxK+l5nziK32ladwB8yhpUS?=
 =?us-ascii?Q?EQoThrTPanPbv4uy96/wbcgCrVbY0k/QalmUEgGTGvOEMwcRdLbiDw7hA0Gv?=
 =?us-ascii?Q?J0B1ISkS1sPYftTmozAoVPrmbZ8ZAlejGFJcJJsODxrBHU1wko8v2JX9T1nX?=
 =?us-ascii?Q?FURX6zW5pb06ofgKC71a78BUXBACuQcv+YgXxeH4ByEA6SATNu3jjnTJooXy?=
 =?us-ascii?Q?IX9VPoxLvG49lA0aFLXPR8Gt5xLKMxutHXB/j/qkSudI4aOyVNr89Cp/FXFa?=
 =?us-ascii?Q?E/zh7nDgKXJbm8GpVjyDRFR8fTmHOzf5Xr1CweG+3cxlAL1A/s61XXdYAqmn?=
 =?us-ascii?Q?pPfaPIhtT6L2EKQrpAwz3XcN53jgyUansJGny476frYHI4Ve8nvfm3jOEyUQ?=
 =?us-ascii?Q?TVgkG4XohykAn0SHVvSYEwm10t5RQ00Q1crkVOQcRI9nbn/lCGEsK7ZEUy6Z?=
 =?us-ascii?Q?KKBFkZAk572WDFzjw6lLbXFQMr4Ay+4rqW66E8FvPB4uT+EkdrZF8zRTdT+/?=
 =?us-ascii?Q?04PcVO9Eqi8aeqrukOHPFDm4O2ld8DIqgrxyuuFSTXrkgO04P5eHM7BO4ALU?=
 =?us-ascii?Q?5iyvVGW+gcioYIhHXpiIig1LVs+3YR8LH6lfRETWcoEtFCEyDD8N6d3VYpqT?=
 =?us-ascii?Q?7VymjMpuoyR112z8AGx+68Cflv+7RZbtYf1YiiafrbdqYSucXBZnqzCW4Wbu?=
 =?us-ascii?Q?BwwGqqeXs6vczOP3BNhOtGBjtorwFvPH6cfuQcyrSetplyCccGxCVVo+qOr3?=
 =?us-ascii?Q?2OM02LV+ALBQGFBrNytfjJ3LEXzrt09LfVvF02KFLrRRjqiTr4cdUjCMRNSL?=
 =?us-ascii?Q?cOU0IV2UQQVFg0aO+Z9589v1roxRd+8Nm4BJGjpoaGSX9x7tLtVz0vpUB5k6?=
 =?us-ascii?Q?rYIdTWSCJCuVb8JR10lfAGjkoEHNo20COby4iKh8RrBSjn4tUYSsYLOLeexd?=
 =?us-ascii?Q?cZyYlv/6SzFy/ULtqyLq1sUK6i4UYCuM3nR/vHCQoT6Dy9hfqfN0OZR+R7DV?=
 =?us-ascii?Q?JMpMDtahthPKKavG5CcnM48leoMnODONykMeWuOlcvxixhkQmW52wUVcqSOK?=
 =?us-ascii?Q?KpfdEihO7vfJS8fuodNqhpOgY38UQf2jgLWn+vsahdomtja+wzIZ3inBdxlR?=
 =?us-ascii?Q?VWFNfHNj0smDHbLlVmvE2JIzm+gw5ydaG4Z177WHBCLiqEBmKtmqDV5TsZQZ?=
 =?us-ascii?Q?vH6V68HGsqCXfw5TADOj9Aant/qCmexx17JHVTezh1ZLL0ZAEvQQ9Dfscs83?=
 =?us-ascii?Q?BcDsDOJojPsOOSXceqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81990e6e-53c2-4dfe-f37e-08dd54890fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 04:09:40.5548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efcLj/OPc/DavXVrmjr4gJU5Z8phFouMLstkXu356izPOp5uwb17PQvtRDjfkoNBfG8WE+Qp1+HnaekbSaP2VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
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

The is
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 21, 2025 11:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)

Incrementing the gpu_reset counter needs to be in the is_guilty block.  Alo=
s move the fence error before the reset to keep the original ordering.

Fixes: f447ba2bbd48 ("drm/amdgpu: Update amdgpu_job_timedout to check if th=
e ring is guilty")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index efba509e2b5d1..c37bc683253a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -151,14 +151,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
                else
                        is_guilty =3D true;

+               if (is_guilty)
+                       dma_fence_set_error(&s_job->s_fence->finished, -ETI=
ME);
+
                r =3D amdgpu_ring_reset(ring, job->vmid);
                if (!r) {
                        if (amdgpu_ring_sched_ready(ring))
                                drm_sched_stop(&ring->sched, s_job);
-                       atomic_inc(&ring->adev->gpu_reset_counter);
                        if (is_guilty) {
+                               atomic_inc(&ring->adev->gpu_reset_counter);
                                amdgpu_fence_driver_force_completion(ring);
-                               dma_fence_set_error(&s_job->s_fence->finish=
ed, -ETIME);
                        }
                        if (amdgpu_ring_sched_ready(ring))
                                drm_sched_start(&ring->sched, 0);
--
2.48.1

