Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F32EC021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 20:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B2110E758;
	Tue, 18 Feb 2025 20:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z85hQGms";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E5E10E758
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 20:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCwTDmKGSawMbXPWiJr9x64sxeTVjro5L6WdIU+wz++XTBihH30JpSOEVUyGQe+6V59oCAtu0rINYrLQ5nFINX14CRt0uPzaXpzbkMQCtG9j64zM9zg524SrEMW/HI34zMSoInZoe5K6yzxRq+MvjQfFU5U2ql7yI81WCpA3YhUYrGkJMhActRbWPVs4iF169f4DRCE9yh/TwUMO88u5/LJo/EGVupF9kHq3c/5CI0RwXOFIP72X9Jv8KybUMWSqaoMA3PpYyBDUrcwJENZZJFPbqHUo8tk/fOMiPj9ZrvAM9mP7D6vVIUYanvzalL4sh4NqjAOmXz47mg6gKb9CDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBCJrkkY1ehj3qz60RkdpnsvnAAJuCXj/uM15ox23cE=;
 b=Xk/8UtLgKiy5G8L+wfEfR8TO/Qxx+U2VUYN4nB3RV8Fs1f1WQhjjVGZ01EklA2CtC3+JSnQtbT9OtNhpb6zVrFTLw3zP7cSrGlV4Y94JzO5cdPc3OFAmeQEK6Koqzo94ce0MuePI6nC7PeTd8W1iIWQwESYi2DXwyXrQ1UBkg9Nx/PsST73OdLItwH92HRPKOOq0H2xgsH2r3syush8MtvIp+ptglFiqkpSHMfd31+FGY+LJje8W0u4O0V7EDTfcP+Hsr/U6izHbIq8k1tHLUluCgdhoAw93QXkMNcwS904yzvDK3iBdMBKdS8gvkuQl7wkFg2YJhOHOLl+nYnGi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBCJrkkY1ehj3qz60RkdpnsvnAAJuCXj/uM15ox23cE=;
 b=Z85hQGmsxRWPRziA2Xk0Qwtl8mZL9KEV9bSEYTHy7S/9pLed/R6Sjp+HsrO+oDgwFmN+f6YOpwcl6EKHRyrvgz9faSO3l+NEiZCKhuFWEVIAW/0n9YfxO+CRD/3l3nYCD/If6zTHH+MmyIzgjHDLyE469wGqqZFPByELcuWfejM=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 20:27:08 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 20:27:08 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH 1/4] drm/amdkfd: Rename grace_period to wait_times
Thread-Topic: [PATCH 1/4] drm/amdkfd: Rename grace_period to wait_times
Thread-Index: AQHbfZoND7WFFClF20aqnN9+U2IwArNNcO2w
Date: Tue, 18 Feb 2025 20:27:07 +0000
Message-ID: <CY8PR12MB7435665B591B0240F3BE499B85FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3f2166ed-2fb4-45f4-b346-823d7a19118a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-18T20:09:51Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MW4PR12MB6873:EE_
x-ms-office365-filtering-correlation-id: 4ae406ef-dbc8-4205-c2f8-08dd505a9db4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SDh6R69vkaCrchKJoomFPFS9DJdNaLx+VJUtg84jaV/cZJN7pdOB9mazC9dZ?=
 =?us-ascii?Q?OAAYxG3TAJiSFfEbV8spHy2+1e5KbQYRHwxf86ZxRkg0kJ14HjlFgZUiUmuT?=
 =?us-ascii?Q?UXIyryDnQBt4iOkIrdiuOZoNsNqnebpNgZctmx1qpZqFsCn1nJF6en9xmArR?=
 =?us-ascii?Q?4SXZ53LemoDPb66xqEZ6qM+C+2v+xs+ep3KJIZ+29qXqxXxl0aRRsGL6K3on?=
 =?us-ascii?Q?hnbIr3JWvYGtPsi/9rlR6inKFWZHK3b+N11ggjFxdLoOFnJrDYpUysA04Mc7?=
 =?us-ascii?Q?XWBV9G5BjN0gjDH0KZGsi2CIHJ0x3AFkcz1CxlvQV/6brelQBnD1hgXasBXc?=
 =?us-ascii?Q?T3HbaX8OCW2ZQ6UwfwPLA7WxFJdTf3cMFAoVautZwTdQmRuwiIHNGTKDm+GP?=
 =?us-ascii?Q?b7UiMePZGJ4RWBtddAvPiFYU1yowpaFZzXIJrpZvFBvlIl26SqIvhC94HqQY?=
 =?us-ascii?Q?92iUq/f+NTQF+Uxf8NZHZ89oNWcy704Z8+02NgkOIIxQk2TC0rGg+IgnoMfW?=
 =?us-ascii?Q?ji0CUu+zbdSScjlby8/ZA85SocTaocjRm8T1jj2laksGMJI0tFo2d/+z+OAK?=
 =?us-ascii?Q?wy0JZ25pinP2ednBTfYbkwDFuN2nHupfHTL+8a2I62v/bEA9rNaCk2Gysd04?=
 =?us-ascii?Q?rKm6ssTIEtAofSFIskgW/76WjiRswAXWCinuSpOMWYMkmSIidTqfYwXGhQo7?=
 =?us-ascii?Q?PLXebENaqVcAa3p0StrW+DB5mcmuzKOu+jW6vsW1sA2nK+NC41IvMMuiYMKr?=
 =?us-ascii?Q?yWjR8hugE9kztM/I2AzALxAhg4kyThOlEE6zDoEqaWrZD5GrgZOp2hb2qAa5?=
 =?us-ascii?Q?SucKfz8oiJINw7iKrie0gq2CAXfDXsd6isDT6zu81GvqpypXTKCbhxd5TtHs?=
 =?us-ascii?Q?VTDRbcOuKlhh5FoA3+zmm3ryt1+q3gjtnE2o8aFRtfTrDEaFzA6f1oxwhrhH?=
 =?us-ascii?Q?A4DOH87VmmOatWqvFLTyy2FSgjPJSwdiCryhItcVO0r3ZIlS2sFLJurtVuJD?=
 =?us-ascii?Q?kr6Vvbgf6SfsGdxmcElFMFnkp09ZhdNMli4YC32Ygrs720yOAx8U+DkVZEup?=
 =?us-ascii?Q?NXCMb1FcUzrwdOaM/0kmbLQMIdXldwfpuk+q4XSN4tKw/UA/iXhCK6G1mlud?=
 =?us-ascii?Q?ID6obwSs+Rnp3iCEM+JAgIda9QFch00g/hMcb4kxamEVGycSGj3dUPIBghfp?=
 =?us-ascii?Q?ZuOHMH8ouki2qIsUvIannlGRznSRByZ8633NWLXjVmLXnfRdKy26IR+I3Y2q?=
 =?us-ascii?Q?0Sqwj5Gna7k8we193Ee6aGGm9LG4v61XtfWrFeqQmVFPnorripnqjoNcwEPA?=
 =?us-ascii?Q?6gBsVtq+fdqlhxv8FLt46WEw2vsTJstdGl8AgZ1+kxtr986/mij37MOGx0UE?=
 =?us-ascii?Q?kALSFgh4k7hp01OSIWELV/Krm3+uIt5UrlLkNJlEkuX2LT93BHxOFtIdBhey?=
 =?us-ascii?Q?bF/RSItQdLuXZPa/y1puGJ3Eemu3z283?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bs4RPKjvTj9Zm1YI35wwYiWOhChrUpl0GAzAJYSVdLnRdntawyBruPqP92jZ?=
 =?us-ascii?Q?EPDcZVR10ut0UmU+AZWWNqCDIe1/dIwLy+6fnG+cQqDri3U/HXTnxtUtmbYJ?=
 =?us-ascii?Q?LeycmC8f54WBwR8443dCUVsinQ3ns35Q4YWYinrz53b3Fz2bD+QC6SFK5e27?=
 =?us-ascii?Q?0aUWYBPDXKMPPYuQwfysJFNHQjMvX3g5bz74+La+eg3/oobs4p2t5iuCaBcw?=
 =?us-ascii?Q?13/wr/+r6ahG194SWbRzXqdC+lAHBa87OA6hCeUqIF3i0CmlOe8vsgeLMkTZ?=
 =?us-ascii?Q?vLvyIhGYjHWbm1LAoA3Nl9AkMxlwnYVXmXPLUDZSW4hsaVm3oZ9XVxhZUloH?=
 =?us-ascii?Q?Ft6IsYybBmawrYPoEAytOcNYk0dgw9XrlCS3KEpimhStm/AY5eoKw43vPi4x?=
 =?us-ascii?Q?Fj3Km5c25L/X3xkO5v7dpl36XJdxB2qy1XimyFWdhO8ImCecwzkwe9iDE8DW?=
 =?us-ascii?Q?QEFWYs50d2OddsSX55gyf8VphHc++1rbuBsBnw2OaoHVHn5JJguA0lcixUJK?=
 =?us-ascii?Q?lPnO0UqQC1L9TOGdoD6sbO8EbI/PdYFVB7vO1delQoOzm2pud7H9PK5TSABn?=
 =?us-ascii?Q?GL2Zd/OE5xvz7c+VToUcEf1wluZI4/COjIUMF7c2WLA4fhZQRXtpEjwRjN5S?=
 =?us-ascii?Q?lvGHyuHWpA46ESGav/TTzW8Z9EG7FRZHFNAnrZFLKMoShiGQu6xzVMpQsVq3?=
 =?us-ascii?Q?Brz6qy3HSI9wPjkwcOmbJyVauvuzsBoDYDeaOK76i1dvT0MS0Zj3C6F4LF9I?=
 =?us-ascii?Q?oQNL2L+m0uDUyLeAgv2l9dIcdPj/uNfSI36nQscI19qodC4xARD3BMHobJU3?=
 =?us-ascii?Q?O2VAYxrYfI4xHaT5DSI9uoXeTqKzMLZ4fLTgOwHiYUVRo/ew26XNYO7GLrwl?=
 =?us-ascii?Q?1Zc0R7A07sVh+1b/yKNJoyV2sqW053/pYZGCEN3jRQ0j//FJEwZK53gkOojR?=
 =?us-ascii?Q?hunvEPgvpXFMhO8Zhafg8HprZs09ru6fpQ0wku61PtYtARBj7pi6DMiQhkz8?=
 =?us-ascii?Q?hZBH3tWX2BA1Nv3CRenJ9FYExET6ZHPtThX5w8L1juVRbFyRDiH1h2Q1tt+2?=
 =?us-ascii?Q?6zYppcM12lvOI40IIn80NelfiuYRQaipCkHjnjipH0GtVeBfctPd8eorvMkm?=
 =?us-ascii?Q?KRArlrn9eTnKpkQstzr4QUBDLGTjlMaQ3TZhRF1ujFIwyjJnHrfiynm7u6Jm?=
 =?us-ascii?Q?WEPWwULvpWDyRNnIjIxFYjcLVyfCVBP40x1nDa9D6kKWRw3F5xEeUP3serEy?=
 =?us-ascii?Q?bbn0SC0Ben7p4WZrB6uswpNW2H217vZXSi4QdP+yaGdrQlZopkCKHF9+IVz+?=
 =?us-ascii?Q?A/OhOEJ9pTJUunwYpgRz8ndkvjm7uUlvYRMwwnMO11OgkMp4Am6H4L1ffYD0?=
 =?us-ascii?Q?DB1QOHuMPUQ8FNnkaOXIB8b0xHCQUCr42g0sbeirKgOp0ygHHY8RP7W3LIlL?=
 =?us-ascii?Q?8K8oQ/GAk7sEdWq9o64HW41FlBjQA8VnSpcEhYBhmS5z+oWb459oTp9th27B?=
 =?us-ascii?Q?OYYSpjCB49TsIzi+24pHHUAViQpgvLQ/6v6BCgqgyYaKdCl5UlYSqEosP27G?=
 =?us-ascii?Q?Sh665G/lKvCK1KhilAo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae406ef-dbc8-4205-c2f8-08dd505a9db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 20:27:07.9191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZqlJq68f1joZRhN3ue5Oh71a8Tn1fuQZokFFhleAxdroVk38jMudbvjIwefbNQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Wednesday, February 12, 2025 5:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH 1/4] drm/amdkfd: Rename grace_period to wait_times
>
> Rename .set_grace_period() to .set_compute_queue_wait_counts(). The
> function not only sets grace_period but also sets other compute queue
> wait times. Up until now only grace_period was set/updated, however
> other wait times also needs set/update. Change function name to reflect
> this.
>
> No functional change intended.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 46 +++++++++----------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 18 ++++++--
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 16 +++----
>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  6 +--
>  6 files changed, 52 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 195085079eb2..b88a95b5ae0d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -976,7 +976,7 @@ static int update_queue(struct device_queue_manager
> *dqm, struct queue *q,
>       if (dqm->sched_policy !=3D KFD_SCHED_POLICY_NO_HWS) {
>               if (!dqm->dev->kfd->shared_resources.enable_mes)
>                       retval =3D unmap_queues_cpsch(dqm,
> -
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD, false);
> +
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);

KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES sounds as obscure as GRACE_PERIOD.
Maybe we should change it to something that abstracts what we're really try=
ing to achieve with the new definition?
KFD_DEFAULT_DEQUEUE_WAIT_TIMES? (i.e. wait times related to dequeue request=
)

>               else if (prev_active)
>                       retval =3D remove_queue_mes(dqm, q, &pdd->qpd);
>
> @@ -1246,7 +1246,7 @@ static int evict_process_queues_cpsch(struct
> device_queue_manager *dqm,
>                                             qpd->is_debug ?
>
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
>
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> -                                           USE_DEFAULT_GRACE_PERIOD);
> +
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>
>  out:
>       dqm_unlock(dqm);
> @@ -1387,7 +1387,7 @@ static int restore_process_queues_cpsch(struct
> device_queue_manager *dqm,
>       }
>       if (!dqm->dev->kfd->shared_resources.enable_mes)
>               retval =3D execute_queues_cpsch(dqm,
> -
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD);
> +
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>       eviction_duration =3D get_jiffies_64() - pdd->last_evict_timestamp;
>       atomic64_add(eviction_duration, &pdd->evict_duration_counter);
>  vm_not_acquired:
> @@ -1788,7 +1788,7 @@ static int halt_cpsch(struct device_queue_manager *=
dqm)
>               if (!dqm->dev->kfd->shared_resources.enable_mes)
>                       ret =3D unmap_queues_cpsch(dqm,
>
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> -                             USE_DEFAULT_GRACE_PERIOD, false);
> +                             KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES,
> false);
>               else
>                       ret =3D remove_all_kfd_queues_mes(dqm);
>       }
> @@ -1815,7 +1815,7 @@ static int unhalt_cpsch(struct device_queue_manager
> *dqm)
>       if (!dqm->dev->kfd->shared_resources.enable_mes)
>               ret =3D execute_queues_cpsch(dqm,
>
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
> -                     0, USE_DEFAULT_GRACE_PERIOD);
> +                     0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>       else
>               ret =3D add_all_kfd_queues_mes(dqm);
>
> @@ -1860,7 +1860,7 @@ static int start_cpsch(struct device_queue_manager
> *dqm)
>       dqm->sched_running =3D true;
>
>       if (!dqm->dev->kfd->shared_resources.enable_mes)
> -             execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD);
> +             execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>
>       /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
>       if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_app_apu &&
> @@ -1868,7 +1868,7 @@ static int start_cpsch(struct device_queue_manager
> *dqm)
>               uint32_t reg_offset =3D 0;
>               uint32_t grace_period =3D 1;

Change the local var name to reflect new set call name (i.e. dequeue wait o=
r whatever you'll decide).

>
> -             retval =3D pm_update_grace_period(&dqm->packet_mgr,
> +             retval =3D pm_set_compute_queue_wait_counts(&dqm->packet_mg=
r,
>                                               grace_period);

What about renaming this to pm_set_dequeue_wait_times since you'll be setti=
ng 2 types of times?
In patch 4 for you're setting both the dequeue wave message delay as well a=
s the retry time.

Jon

>               if (retval)
>                       dev_err(dev, "Setting grace timeout failed\n");
> @@ -1916,7 +1916,7 @@ static int stop_cpsch(struct device_queue_manager
> *dqm)
>       }
>
>       if (!dqm->dev->kfd->shared_resources.enable_mes)
> -             unmap_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD, false);
> +             unmap_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);
>       else
>               remove_all_kfd_queues_mes(dqm);
>
> @@ -1959,7 +1959,7 @@ static int create_kernel_queue_cpsch(struct
> device_queue_manager *dqm,
>       increment_queue_count(dqm, qpd, kq->queue);
>       qpd->is_debug =3D true;
>       execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> -                     USE_DEFAULT_GRACE_PERIOD);
> +                     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>       dqm_unlock(dqm);
>
>       return 0;
> @@ -1974,7 +1974,7 @@ static void destroy_kernel_queue_cpsch(struct
> device_queue_manager *dqm,
>       decrement_queue_count(dqm, qpd, kq->queue);
>       qpd->is_debug =3D false;
>       execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> -                     USE_DEFAULT_GRACE_PERIOD);
> +                     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>       /*
>        * Unconditionally decrement this counter, regardless of the queue'=
s
>        * type.
> @@ -2054,7 +2054,7 @@ static int create_queue_cpsch(struct
> device_queue_manager *dqm, struct queue *q,
>
>               if (!dqm->dev->kfd->shared_resources.enable_mes)
>                       retval =3D execute_queues_cpsch(dqm,
> -
>       KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD);
> +
>       KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>               else
>                       retval =3D add_queue_mes(dqm, q, qpd);
>               if (retval)
> @@ -2294,8 +2294,8 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>       if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
>               return -EIO;
>
> -     if (grace_period !=3D USE_DEFAULT_GRACE_PERIOD) {
> -             retval =3D pm_update_grace_period(&dqm->packet_mgr,
> grace_period);
> +     if (grace_period !=3D KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES) {
> +             retval =3D pm_set_compute_queue_wait_counts(&dqm->packet_mg=
r,
> grace_period);
>               if (retval)
>                       goto out;
>       }
> @@ -2338,9 +2338,9 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>       }
>
>       /* We need to reset the grace period value for this device */
> -     if (grace_period !=3D USE_DEFAULT_GRACE_PERIOD) {
> -             if (pm_update_grace_period(&dqm->packet_mgr,
> -                                     USE_DEFAULT_GRACE_PERIOD))
> +     if (grace_period !=3D KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES) {
> +             if (pm_set_compute_queue_wait_counts(&dqm->packet_mgr,
> +
>       KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES))
>                       dev_err(dev, "Failed to reset grace period\n");
>       }
>
> @@ -2360,7 +2360,7 @@ static int reset_queues_cpsch(struct
> device_queue_manager *dqm, uint16_t pasid)
>       dqm_lock(dqm);
>
>       retval =3D unmap_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_BY_PASID,
> -                     pasid, USE_DEFAULT_GRACE_PERIOD, true);
> +                     pasid, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES,
> true);
>
>       dqm_unlock(dqm);
>       return retval;
> @@ -2468,7 +2468,7 @@ static int destroy_queue_cpsch(struct
> device_queue_manager *dqm,
>               if (!dqm->dev->kfd->shared_resources.enable_mes) {
>                       retval =3D execute_queues_cpsch(dqm,
>
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> -
> USE_DEFAULT_GRACE_PERIOD);
> +
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>                       if (retval =3D=3D -ETIME)
>                               qpd->reset_wavefronts =3D true;
>               } else {
> @@ -2763,7 +2763,7 @@ static int process_termination_cpsch(struct
> device_queue_manager *dqm,
>       }
>
>       if (!dqm->dev->kfd->shared_resources.enable_mes)
> -             retval =3D execute_queues_cpsch(dqm, filter, 0,
> USE_DEFAULT_GRACE_PERIOD);
> +             retval =3D execute_queues_cpsch(dqm, filter, 0,
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>
>       if ((retval || qpd->reset_wavefronts) &&
>           down_read_trylock(&dqm->dev->adev->reset_domain->sem)) {
> @@ -3123,7 +3123,7 @@ int reserve_debug_trap_vmid(struct
> device_queue_manager *dqm,
>       }
>
>       r =3D unmap_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> -                     USE_DEFAULT_GRACE_PERIOD, false);
> +                     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);
>       if (r)
>               goto out_unlock;
>
> @@ -3172,7 +3172,7 @@ int release_debug_trap_vmid(struct
> device_queue_manager *dqm,
>       }
>
>       r =3D unmap_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> -                     USE_DEFAULT_GRACE_PERIOD, false);
> +                     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);
>       if (r)
>               goto out_unlock;
>
> @@ -3355,7 +3355,7 @@ int resume_queues(struct kfd_process *p,
>               r =3D execute_queues_cpsch(dqm,
>
>       KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
>                                       0,
> -                                     USE_DEFAULT_GRACE_PERIOD);
> +
>       KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>               if (r) {
>                       dev_err(dev, "Failed to resume process queues\n");
>                       if (queue_ids) {
> @@ -3734,7 +3734,7 @@ int dqm_debugfs_hang_hws(struct
> device_queue_manager *dqm)
>       }
>       dqm->active_runlist =3D true;
>       r =3D execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
> -                             0, USE_DEFAULT_GRACE_PERIOD);
> +                             0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>       dqm_unlock(dqm);
>
>       return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 09ab36f8e8c6..273c04a95568 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -37,7 +37,7 @@
>
>  #define KFD_MES_PROCESS_QUANTUM              100000
>  #define KFD_MES_GANG_QUANTUM         10000
> -#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
> +#define KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES 0xffffffff
>
>  struct device_process_node {
>       struct qcm_process_device *qpd;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 4984b41cd372..8d2f63a38724 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -396,14 +396,26 @@ int pm_send_query_status(struct packet_manager *pm,
> uint64_t fence_address,
>       return retval;
>  }
>
> -int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod)
> +/* pm_set_compute_queue_wait_counts: Configure CP IQ Timer Wait Counts f=
or
> Items
> + *  Offloaded from the Compute Queues by writing to CP_IQ_WAIT_TIME2
> registers.
> + *
> + *  @wait_counts_config: Parameter overridden. Could be flag or grace_pe=
riod
> + *   Possible flag values:
> + *     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES then reset to default value
> + *
> + *   If not an above flag, Wait Count for Scheduling Wave Message (SCH_W=
AVE)
> + *      is set to wait_counts_config value.
> + *      NOTE: if 0, The CP cannot handle it and will result in
> + *      an infinite grace period being set so set to 1 to prevent this.
> + */
> +int pm_set_compute_queue_wait_counts(struct packet_manager *pm, uint32_t
> wait_counts_config)
>  {
>       struct kfd_node *node =3D pm->dqm->dev;
>       struct device *dev =3D node->adev->dev;
>       int retval =3D 0;
>       uint32_t *buffer, size;
>
> -     size =3D pm->pmf->set_grace_period_size;
> +     size =3D pm->pmf->set_compute_queue_wait_counts_size;
>
>       mutex_lock(&pm->lock);
>
> @@ -419,7 +431,7 @@ int pm_update_grace_period(struct packet_manager *pm,
> uint32_t grace_period)
>                       goto out;
>               }
>
> -             retval =3D pm->pmf->set_grace_period(pm, buffer, grace_peri=
od);
> +             retval =3D pm->pmf->set_compute_queue_wait_counts(pm, buffe=
r,
> wait_counts_config);
>               if (!retval)
>                       retval =3D kq_submit_packet(pm->priv_queue);
>               else
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d56525201155..8b693a9446e8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -297,9 +297,9 @@ static int pm_map_queues_v9(struct packet_manager *pm=
,
> uint32_t *buffer,
>       return 0;
>  }
>
> -static int pm_set_grace_period_v9(struct packet_manager *pm,
> +static int pm_set_compute_queue_wait_counts_v9(struct packet_manager *pm=
,
>               uint32_t *buffer,
> -             uint32_t grace_period)
> +             uint32_t wait_counts_config)
>  {
>       struct pm4_mec_write_data_mmio *packet;
>       uint32_t reg_offset =3D 0;
> @@ -308,11 +308,11 @@ static int pm_set_grace_period_v9(struct
> packet_manager *pm,
>       pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>                       pm->dqm->dev->adev,
>                       pm->dqm->wait_times,
> -                     grace_period,
> +                     wait_counts_config,
>                       &reg_offset,
>                       &reg_data);
>
> -     if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
> +     if (wait_counts_config =3D=3D KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES)
>               reg_data =3D pm->dqm->wait_times;
>
>       packet =3D (struct pm4_mec_write_data_mmio *)buffer;
> @@ -415,7 +415,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {
>       .set_resources          =3D pm_set_resources_v9,
>       .map_queues             =3D pm_map_queues_v9,
>       .unmap_queues           =3D pm_unmap_queues_v9,
> -     .set_grace_period       =3D pm_set_grace_period_v9,
> +     .set_compute_queue_wait_counts =3D
> pm_set_compute_queue_wait_counts_v9,
>       .query_status           =3D pm_query_status_v9,
>       .release_mem            =3D NULL,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> @@ -423,7 +423,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D sizeof(struct pm4_mec_write_data_mmio),
> +     .set_compute_queue_wait_counts_size  =3D sizeof(struct
> pm4_mec_write_data_mmio),
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D 0,
>  };
> @@ -434,7 +434,7 @@ const struct packet_manager_funcs
> kfd_aldebaran_pm_funcs =3D {
>       .set_resources          =3D pm_set_resources_v9,
>       .map_queues             =3D pm_map_queues_v9,
>       .unmap_queues           =3D pm_unmap_queues_v9,
> -     .set_grace_period       =3D pm_set_grace_period_v9,
> +     .set_compute_queue_wait_counts =3D
> pm_set_compute_queue_wait_counts_v9,
>       .query_status           =3D pm_query_status_v9,
>       .release_mem            =3D NULL,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process_aldeb=
aran),
> @@ -442,7 +442,7 @@ const struct packet_manager_funcs
> kfd_aldebaran_pm_funcs =3D {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D sizeof(struct pm4_mec_write_data_mmio),
> +     .set_compute_queue_wait_counts_size  =3D sizeof(struct
> pm4_mec_write_data_mmio),
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D 0,
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index 347c86e1c378..de28fc585296 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -304,7 +304,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs =3D=
 {
>       .set_resources          =3D pm_set_resources_vi,
>       .map_queues             =3D pm_map_queues_vi,
>       .unmap_queues           =3D pm_unmap_queues_vi,
> -     .set_grace_period       =3D NULL,
> +     .set_compute_queue_wait_counts  =3D NULL,
>       .query_status           =3D pm_query_status_vi,
>       .release_mem            =3D pm_release_mem_vi,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> @@ -312,7 +312,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs =3D=
 {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D 0,
> +     .set_compute_queue_wait_counts_size     =3D 0,
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D sizeof(struct pm4_mec_release_mem)
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 59619f794b6b..ae58d50b8eb9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1417,7 +1417,7 @@ struct packet_manager_funcs {
>       int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
>                       enum kfd_unmap_queues_filter mode,
>                       uint32_t filter_param, bool reset);
> -     int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer=
,
> +     int (*set_compute_queue_wait_counts)(struct packet_manager *pm, uin=
t32_t
> *buffer,
>                       uint32_t grace_period);
>       int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>                       uint64_t fence_address, uint64_t fence_value);
> @@ -1429,7 +1429,7 @@ struct packet_manager_funcs {
>       int set_resources_size;
>       int map_queues_size;
>       int unmap_queues_size;
> -     int set_grace_period_size;
> +     int set_compute_queue_wait_counts_size;
>       int query_status_size;
>       int release_mem_size;
>  };
> @@ -1452,7 +1452,7 @@ int pm_send_unmap_queue(struct packet_manager *pm,
>
>  void pm_release_ib(struct packet_manager *pm);
>
> -int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod);
> +int pm_set_compute_queue_wait_counts(struct packet_manager *pm, uint32_t
> wait_counts_config);
>
>  /* Following PM funcs can be shared among VI and AI */
>  unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size=
);
> --
> 2.34.1

