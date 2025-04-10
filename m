Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BB6C369A2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 07:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46BE610E076;
	Thu, 10 Apr 2025 07:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qohNd+1r";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2112410E076
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 07:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPKOq/nbr5XUAcgDiPwH9ygni+VpC+RQCY92A0aad5XEHh2xXQ3ci7/91v0hmGBULbtxOA4Saq08rDe98VjTCeZKjjyLTNHRvHOHCqCBClLOoJuDYZ+57P8KxFZZ8/k90326KIy/lcjTvMgGZWUeSvFzzGgSnpruShcopFyx0szy2Bnc9WlfOI6pkyRMWgeuCJl4qrRmtYKGIjiA/3qEmTp/BoHP4cI3VKjWPIMBxzQqjOm0qNSCK/TMQ3mClv1FkoqCQfLWWYSVDpglGEyJO7o6f554UZ7Q+rLU42RwjjB8gdy/8/zmiou1zIAu513f0J62AP5qYDJWelPfaky7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1rNMu2hIWmDEvLAkxjsdbe6A/XmainuyG0e10VPHzI=;
 b=wGzlFXhsFw37Qyz7fLt6PSjIST/LmhQ01okeFE3Pc8z4YA0rs7wlhsSMv6fgJiXanGM817gtPa9il/5aOVPcOxfUhOV7AtHcrCv4P44ABJVderwUB9ftGJQoz6Z1VyVez3WbAxTGHDy8Q4VPWuKGH23/IKerVoD0zDcNozeSnaPN/J59PM0FxOyeCfYepWWg5W4IKb6BfR+bREH0WqGSMdC64y+W512aY8TAyf8F+HB2qiA9GV5OLEKyX0iboBOA/AkTDiivSUgWrA/q8HLNGxf36twyYr6DfW9IM3bpjNwXOiSU+LT96dBZzal8LKod1E1BzAwZsYpVXzLf3017mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1rNMu2hIWmDEvLAkxjsdbe6A/XmainuyG0e10VPHzI=;
 b=qohNd+1rTq0sFtWja4oRbnPHLOX+UH3YWDHWxRu1QE6tI2Yenv3HaHByhVluhm2pLquXfHYdaIn4nXkZGYu8By5uu58W8/gO8NgpHnqbNIk/T01LKt1ySnwBuzi2+Y2lzzmRbiGaU2x9M5OEPs4DGU5UKuDg12HF/BFt1B36bjA=
Received: from BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 07:59:32 +0000
Received: from BL1PR12MB5061.namprd12.prod.outlook.com
 ([fe80::acb3:ef8d:e8cf:438e]) by BL1PR12MB5061.namprd12.prod.outlook.com
 ([fe80::acb3:ef8d:e8cf:438e%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 07:59:32 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Clear overflow for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Clear overflow for SRIOV
Thread-Index: AQHbqeF5XVRlT4aeUEuIWzlRLveIBrOciKOQ
Date: Thu, 10 Apr 2025 07:59:31 +0000
Message-ID: <BL1PR12MB5061918092FCB2FE9076CA84E1B72@BL1PR12MB5061.namprd12.prod.outlook.com>
References: <20250410062554.573023-1-Emily.Deng@amd.com>
In-Reply-To: <20250410062554.573023-1-Emily.Deng@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5adafb39-3d89-4545-83b8-a205a311519c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-10T07:57:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5061:EE_|CY8PR12MB8215:EE_
x-ms-office365-filtering-correlation-id: 6a8cf920-7fde-40cf-ce28-08dd7805a084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NEsLrD+HXiSPop/QcUFr3e6Sgrobi16f0l0y3Dzjh/IJr7MWEmIsfJ4G/pZZ?=
 =?us-ascii?Q?HNoyFJpYKt9rLXZng0Ccng//HRAWxjq9O+MfBmjJo5bSVSrVQQTaIpyMnaHw?=
 =?us-ascii?Q?2vxVNfpKXWUNX+iMsBQaSSQWZspTF2azOf79Qq8b/rHSVpy5u5jpOCX2q/jj?=
 =?us-ascii?Q?WoV9K4HsKp3/GUhmBFvA/mo82blcbi6ppCMUopEMaw8d2znddYboWq/A85qv?=
 =?us-ascii?Q?O42Yp0ZLb6A6CdFEdFrfuEqFTuQAIeynP1hcXdtXIV6nlhvjvEEgmN1ei9IJ?=
 =?us-ascii?Q?5Z/J3CNE3RXyAv/3sbcqTucQNpsBZ06zsLLb6xeRMy/7oJfp4at/Y9KMQqh/?=
 =?us-ascii?Q?DnENmEM6ejdjefKpE2a/hhZQcyCQivvAGPQxhdEJlwlUKNCzvcVZOb64sb4M?=
 =?us-ascii?Q?tAIcyjA0TKEy6zMHabh9RVYMQf6VynSkk2QWKjZRXrTUq74DcEER2WpNbhSh?=
 =?us-ascii?Q?XMiOdi/J6+HrDeYVM8W34FgRRO05A7yLnI+sF/C7XX046Ho2CJh30eaPZEpF?=
 =?us-ascii?Q?t8ibudFLH4zqtWkFUQzfWKwuyg93QIYDrP73YmQTvOV1DnZaU1ND1tVaz3hZ?=
 =?us-ascii?Q?5sMf/4PbOHX+tU6r/InhHGDX1KD5poP1con6/IRdNIFuZaTpmdvT1mTMr93O?=
 =?us-ascii?Q?FCLGDJDg5uiixsg+AU7yO89WCIl0K3JHi6rEmPEMUa4OmzoEyFUzk2ToZMOt?=
 =?us-ascii?Q?mR5s3acP8+chL0chKSSm4bQ3uCBSeq0FoHb9gaSIMGAzyocP/KFy3c0IVv2b?=
 =?us-ascii?Q?qdw+ZRLEwrgD1oZyszvzJnAtCu6ZCH9cXLUAveuVerl8rlVDOe1Ry8FOp53E?=
 =?us-ascii?Q?f5urN0N7DIrBuU9GtRjxPPpnRuLXcqwcXbEJYJYlUQbKVA3XDuAWppi/W5Ng?=
 =?us-ascii?Q?VoWtdBsirvkdBErtL6uBWBB/Ajc6oWdLN2WMmtdsSrNijsOM65Aiy03JbB2f?=
 =?us-ascii?Q?rfomjQ5aYwBcfiQuzED9MB/KblGYpq6fhTgTcsZ25rw60HKXdCBFEcSbX72a?=
 =?us-ascii?Q?ssd34aBK8TbXd1gOrteKgQeneAj3+E7J5vo5SLcNCRSL6NP8hfm9Hh9wHnmP?=
 =?us-ascii?Q?fbiEuxMAN+Z8z4X/6lOAz88Vy9/o0egLK27UhyuGG8c8xwhCSEJF782w7EBT?=
 =?us-ascii?Q?vNA5gvrgmsFNrUYnqcR5AFRdrZGAJ1RHZx0Cc1vAFkstVqqzUIiIsixN4wS4?=
 =?us-ascii?Q?n6QjxC2yM54Tm/gLlllrtcMHoBsIsf+AP7q3r0FhNtG+KAo/C0NqcHoV5Zvc?=
 =?us-ascii?Q?0yusY5PnPx4eTxobQZWtdU31T78qOEg8iqIJubgCv54nmYzkNilB50Zz783J?=
 =?us-ascii?Q?WPZqKbEa8NFDEtlyG3STCi++grXH4em5Wek91qWfSWN4SlnPz9yjh0Qd1Hi8?=
 =?us-ascii?Q?b7IMCsp7BPlJY8NR8lUJ4Lvp4j8F/KkW/bONMhBtrgKuO7lopWomVKb6A+Uk?=
 =?us-ascii?Q?WAP+zQl2Eiu/a5gEC79CLDPpSzdBbut/sF9h4IQpL5qU0CR0RNYHWsh91EZf?=
 =?us-ascii?Q?DDDAvVzfdg/BN+s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5061.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/+R6hCxo1t5d5BjyXRey4tU7PqU2+O7O5lRO78Xzc8EMmiHE+OPbHfL+TiAA?=
 =?us-ascii?Q?pNEUe1AXJvjE1e4NEJjY971+el9Nm2r1kbpk9nch9qvRjnf/sVTLF2+7op2h?=
 =?us-ascii?Q?gcMYUtDm4uXLlSFwUFwS8eaGh+U543JZpe+kZZpaA/BLrp69hMNrmvVUz6n2?=
 =?us-ascii?Q?pimMbf6FdNEwF0kUuE/bEpmdgvtv7DeOiwG6OLd+0KU274ThbplQvkna6NHT?=
 =?us-ascii?Q?uqjNLcOSsVAatSSe8AhRQKVLQEM6LkzIyfb6jWxeuruZgZu9D+xLPNmzFelM?=
 =?us-ascii?Q?5BDYt+opxaN+rY+Ut6TnUlt2mp4Gkxl9HiAaVk9VNm/rMl6lwjHGISLiQOfE?=
 =?us-ascii?Q?vYxHQ4jt0c/Zgw7IDVMX9nULk/2lJw7rEg43EwWh1l9DW+8kto/CSnwIRByh?=
 =?us-ascii?Q?rG9dD0gZL48QZ3+1UU0F6aaZuO5tQRQOfldshyn2bbPxMFN6eVbxMi3Nekeq?=
 =?us-ascii?Q?yoXAz0+9o56txp63Zf5OE4G/KFI+tzndXwCPp2J7wgFl5LHfOytI3U7Ntdka?=
 =?us-ascii?Q?f8MaphQgO8k81BEUL1P0N1oGypryjkEN5p/42S6cef2ScwUPtgSlYMa5AfS/?=
 =?us-ascii?Q?OnU0+ZiqmKfUpsQe9ZXn55jR+qjM+Usz14vqG4nl/i2jlRPBvhiFRzkpOPwu?=
 =?us-ascii?Q?fDPUzDajGb+KLiscVUlwsrA0rBrpL3kzxYmHyLyFRTvwywqjUBLNXqvM2et4?=
 =?us-ascii?Q?Zsj/zy8+aQjkcIW+4CZGhvXVlb1CgGJMp9F0UXtB1IF7RbOD0+rS2JOmHwm4?=
 =?us-ascii?Q?3PYz2B+8rc27wt6pu6LkEKCsRRJkKQrOIQJiRvRNwjIjicV1KYPFRsi4xMef?=
 =?us-ascii?Q?p9N8hJSzRjieh9pJ2aN+mttkVMRemAeAbbUGQM6ScifPQz+ijBxLSK3wmIzY?=
 =?us-ascii?Q?tiCeuchwSXc/tekrmdIK/9HxSh4SteadHdcoMnhYPk3YuUTfnwRnqUwS6nZm?=
 =?us-ascii?Q?NPH38j9ZPpoxUnRNriCHOpG+vHwFCratvHagAEA/o4ZQEqBWGBO2LtSocXuI?=
 =?us-ascii?Q?XocbwrVgalff/Kn4L2j0+XkqRcRLnpt6sJqNA5J7rXOBxABd4D3h7YMhLerl?=
 =?us-ascii?Q?ShfJ919k0/acBLTGx/X9UIZRof2psdAyq5ccTQJg3ysAsAZ2Jqyku84Kztz+?=
 =?us-ascii?Q?or0OVrRSFhN/sCkqa6JaWQRa4+4xaY8FWhjdkBYgDMYHP6tiNVmIjUf4rGBo?=
 =?us-ascii?Q?mQL8pjg04l0TwQpICu7qg9aHT6NdRTSqaTPGtascsFsWR7EuDACLTZilblfE?=
 =?us-ascii?Q?Vl3/GWuKMt8izr1Aw0GHqWSYBllCdh0ysOB+sWrPOAlKRjCtQRl8QE/RGL5Q?=
 =?us-ascii?Q?9WTcn+gQe5MXkHVuhDP76ROu0f+sRFdTSUldZzyBUzMwwJ8SX7DyppCBNl/X?=
 =?us-ascii?Q?UVTJMmlhbcI8uGB+plpfD7gJkAaKR4WcH8pb2kqL5rY8Shfyr9D0fuqvRiPf?=
 =?us-ascii?Q?PKODQGiQbverXc9bs7wyPvW/9tUJY0cszPmTKddCj9f4/2AKbdapZla8f11y?=
 =?us-ascii?Q?aghEupcJgHfy/yhfw92ExcHDM2Zj2iD8nF+cWkUi0lPoIbBpFVNzzz50NB6D?=
 =?us-ascii?Q?QtH9nrGow7Mc+MxadBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5061.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8cf920-7fde-40cf-ce28-08dd7805a084
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 07:59:31.9344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrw+a001bWLoce/PCeLaTtpYYYDJee7gDFn8aVbB+YEPu1+VmUyIzzYDXBh253sK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
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

Tested on MI210 VF also.

Tested-by: Horace Chen <Horace.Chen@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily De=
ng
Sent: Thursday, April 10, 2025 2:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Clear overflow for SRIOV

For VF, it doesn't have the permission to clear overflow, clear the bit by =
reset.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 10 ++++++++--  drivers/gpu/drm/am=
d/amdgpu/amdgpu_ih.h |  1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ih.c
index 901f8b12c672..23bace1b457f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -227,13 +227,19 @@ int amdgpu_ih_process(struct amdgpu_device *adev, str=
uct amdgpu_ih_ring *ih)
                ih->rptr &=3D ih->ptr_mask;
        }

-       amdgpu_ih_set_rptr(adev, ih);
+       if ((!amdgpu_sriov_vf(adev)) || !ih->overflow)
+               amdgpu_ih_set_rptr(adev, ih);
+
        wake_up_all(&ih->wait_process);

        /* make sure wptr hasn't changed while processing */
        wptr =3D amdgpu_ih_get_wptr(adev, ih);
        if (wptr !=3D ih->rptr)
-               goto restart_ih;
+               if ((!amdgpu_sriov_vf(adev)) ||  !ih->overflow)
+                       goto restart_ih;
+
+       if (amdgpu_sriov_vf(adev) && ih->overflow)
+               amdgpu_amdkfd_gpu_reset(adev);

        return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ih.h
index b0a88f92cd82..7f7ea046e209 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
        /* For waiting on IH processing at checkpoint. */
        wait_queue_head_t wait_process;
        uint64_t                processed_timestamp;
+       bool overflow;
 };

 /* return true if time stamp t2 is after t1 with 48bit wrap around */ diff=
 --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/=
ih_v6_0.c
index f8a485164437..8d3ae88b96a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
                        if (ret)
                                return ret;
                }
+               ih[i]->overflow =3D false;
        }

        /* update doorbell range for ih ring 0 */ @@ -446,7 +447,10 @@ stat=
ic u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
        wptr =3D RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
        if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
                goto out;
-       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+       if (!amdgpu_sriov_vf(adev))
+               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+       else
+               ih->overflow =3D true;

        /* When a ring buffer overflow happen start parsing interrupt
         * from the last not overwritten vector (wptr + 32). Hopefully diff=
 --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgp=
u/vega20_ih.c
index e9e3b2ed4b7b..2ad209406d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *ade=
v)
                        if (ret)
                                return ret;
                }
+               ih[i]->overflow =3D false;
        }

        if (!amdgpu_sriov_vf(adev))
@@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *ad=
ev,
        if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
                goto out;

-       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+       if (!amdgpu_sriov_vf(adev))
+               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+       else
+               ih->overflow =3D true;

        /* When a ring buffer overflow happen start parsing interrupt
         * from the last not overwritten vector (wptr + 32). Hopefully
--
2.34.1

