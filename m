Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C45D2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542D510E0AC;
	Tue, 20 Jan 2026 07:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mL+Xs16R";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654A710E0AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j55tuiLLF12zrzH7jaXdekVDmx7fV3BxZN/VtmbUdnQkttuCnILEGLFS0PZ7dvT2tBq+Lrpfxc21x3Gjciby/SjxX8jRbFXTDzhAynOw/4bZ9jTIT+HoOCVoid5REhziBaYaGbToQo7neXQSXatdsyo6EiHQo4oVUT5hCA41PU8Nkv9JMhlr7Eb6aeABGL/ylL7q+A8+OWBsPfySwQ86NSEkoQR+LnSP4xxUrVB3LXvZ8MkfaHSvurdFDFIroq190bhAewfp43TTwWj4PQAo7olfbY0eVFlZ5Grf8AdynSRzInO81RH3462LlkjKu53hT12hWsCljmCzwAVoqs3a5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpyr84UcoT56cl/s9KCY7RpI/zZfv/azFoPOwnFUb8w=;
 b=rOzv9Ih7ITsTfJkedKK6tP0NcikUQ0DuykF1OhO6YWb8D/Xl7ABRQmQEnLqpWDI0F2CzBIiSmtUJI7Ll+nGtP3COfyJ1JlCWMxkIRoi+Vpf5bo2okxz3wm3qMYrQTvNlJpAYNqlK9//y/Rx0QkpAr7of53CS7KkUt8zCOh7z5Q6WtHud0HRqzAcwiUPhYJGdfgk9vDYBxz7UGOXY50Oyg9LOLVEAJrz8LV07dJVREh6AvltwGSVpFWPAC0OsESD+d+LkaCKPe0roZVro0lWFpeYn96BbhEcYUrIb9oNtA8VccJqf0/9J0KJ7lsTZdrTe3Ihzwu+U2l4qaAsH9GWyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpyr84UcoT56cl/s9KCY7RpI/zZfv/azFoPOwnFUb8w=;
 b=mL+Xs16RyCwBXPlta65RumJFib0vIuj+JBQbbbTS9hf4TAfRaa0AmLV2frEGcAITb3jBFg8cAXcJp7fKFZt6wsHs21UnAZuHF+T0NBhJ9FomEdKfBa8fhZQcBYI9/6wlHJ3lqRE1tJoPRcKfU3FFkoXm2dMzXmS2wUPm9Tkk8cU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:23:40 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 07:23:40 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 01/10] drm/amdgpu: re-add the bad job to the pending list
 for ring resets
Thread-Topic: [PATCH 01/10] drm/amdgpu: re-add the bad job to the pending list
 for ring resets
Thread-Index: AQHciazx7GhXvK5f20ydvMTVdH1S5rVaqAbg
Date: Tue, 20 Jan 2026 07:23:40 +0000
Message-ID: <BL1PR12MB514486C45306A46FEBA22D3BE389A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
 <20260120013411.15659-2-alexander.deucher@amd.com>
In-Reply-To: <20260120013411.15659-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T07:23:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6072:EE_
x-ms-office365-filtering-correlation-id: 04040109-0cda-43cb-ddc3-08de57f4d5aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?232V7KDelFD8d3uZBiBcSZ5bOGM9chU9tpynOTVGO88rJWBsBG18qmAHWsqw?=
 =?us-ascii?Q?ycSzuP+r2c9xJdyN7oEId0w2TnNvp8b85kXgWPSk/H1aYduoiR//+EF0aD4J?=
 =?us-ascii?Q?mfbOoa+kznVbIhpQTAhAcFhU2rVZ/KdhrUZgvsY9M4umXfo9RzRzSOpHr9W4?=
 =?us-ascii?Q?WrfvlahS6yDVzoZLVMeo7lQ1RIub6TSn8xEgMhkF32ivvBwPFIOBcsO0T9Ca?=
 =?us-ascii?Q?6R6QcS5XV7MA2Z3FAX6W7Nk7rIcjFjnAiF4PXKOuZ6UiiBoNSzhTjE+8hEpX?=
 =?us-ascii?Q?YD0XTpL6bQctn5D/AMr3iOYd82gOKMj9ivFYSOZ8w0c2FQYa5Bi4sc5Vio8e?=
 =?us-ascii?Q?09Iou/16/ZMX+bI+XUZR+RISYTcxXraczarWKDHeQoNNCYH/R6nM83U9kGhe?=
 =?us-ascii?Q?lGAHr5XIeA7ZBGXTepWlfFWxT0LKec6b4kASkuFHWDUpsVtLg08ehZ/U3tb7?=
 =?us-ascii?Q?sDROsdbV0hX0H1MgJItSGCwLqPpAhK5tEQ2EfcFUeTvLh5w6dA83fyncVgI+?=
 =?us-ascii?Q?R09lAT/kzLqK/uyWpZdRLfj6rwDyg7fZop6V3QeRlbblSDKdwHiWwBA6nhg0?=
 =?us-ascii?Q?QvJi39qZVSdNxOALVMt7oLU0vrLapydu1RksHWQux/qKgW4mmPFNwrkCE27A?=
 =?us-ascii?Q?hqi7AeS7ioow/kv4G7vnLSF+AdU0lH0qdqxSByIAHNo2A00aD1QNOwopy03a?=
 =?us-ascii?Q?jHNUtx3lmv8soeyaD2eipOdfy4u7bgtGBLlVqw3hguhys42hmwjU0ICAKPb6?=
 =?us-ascii?Q?7fgY/zYiceqx4dbSKSSXbskgxFPIGWqJDIAZ/7n3ygzvPc+7FXdVxnSjQvV8?=
 =?us-ascii?Q?mzdwQsQTyTXl4OK99vySziAMP/dJos8DSPY6lm8jAl3oxpApNh5NFjXXeojS?=
 =?us-ascii?Q?cdXTgKn/rW4MDLNYIMbHTfz/awt9JN9l/cn1xoL1IEStty8Kof/LXyBeFKmS?=
 =?us-ascii?Q?9Uz1+hDbpEIqZeVFql0tA3GlRtsOfJE1dP+qzcCAGNSypfEgn3fAj0rvu1O+?=
 =?us-ascii?Q?DXJhswaTNG6ddh5IguCBJz9HdDkHYYXwER8IceWVtNd+fj748uUB5xd0qbQc?=
 =?us-ascii?Q?jE+rltq7g2qAxuJWzEiL4jB0DdjEFeFGUaPwwv/XBJDX2SDKP+84KtT+udD/?=
 =?us-ascii?Q?py2CXv/dAkS48oLbsyZJDh9tDN4sK8yEi3gsW6stjPtWNfURaNPOwaiGEVHV?=
 =?us-ascii?Q?qh7KLfN3b+oaqLIwfW8AoB6e3ol495WGcsjBBBOpTODCbnASmS5XqBfxac+W?=
 =?us-ascii?Q?Mz7Mpq/BPi8DnBIdsTDU0QY8Krkkijc6G1dLbRoAx7WwSvyMfLDnfA7l6k21?=
 =?us-ascii?Q?Kg1ZzdAJDIg+KEO0iTC69HwdT/1Dd20dABmwTedjj7c5Gl3PCU8pYfIcg44u?=
 =?us-ascii?Q?A3tajLoBdWJhqE3oE4h02cSrR0tZYWiELWnwp8NcSOpBOP88NUreixD09pAF?=
 =?us-ascii?Q?F7cRKPOjI56emMSlka9hDlKRcmXFxEj5X74yCGDdPJAucf+4jWg6Xo5TyxwB?=
 =?us-ascii?Q?XKMuZyHdQ4IYoALcmqWe2x2/AxDNqGGk9nDnZm5SJJPluZrmS+nkh793IO1i?=
 =?us-ascii?Q?1BXbKyKUdsx/G2qb5xnHTo5LFyUy9wDsp0GOaQkwiaPPTTEEIliUh2sLHHe6?=
 =?us-ascii?Q?2M7nm2D/stxhebmQF1Only4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DiUq2QKyCtcnL9lw8I9APYbeiBFrVttjQXr2L7tt60rcsduMsycY3HpcKZne?=
 =?us-ascii?Q?M7KQ+uIuztxhvpynenYuAaqdE/UIIGZcQzuUbCyXq5oaJUKb+vCGzi0JFF8T?=
 =?us-ascii?Q?PQ2l4Z49HNCm84OKrXA9PYYyW+g5tu/M89zzgDeuC9rx3OOJYeu7U/w4SDzI?=
 =?us-ascii?Q?jlTOXZFQn9WWAiavBB5nfY3xp8jAQPkwri0gPuWS0N5jfsl+KNvs60Mq4680?=
 =?us-ascii?Q?Wvp4b4pgessNYsk31xu67ZYSVWuMSwT44Zrr9090pNS4+DTT9h7BffCK5rVJ?=
 =?us-ascii?Q?KEXzAOiz2cFVKMjuf6p3j7yuG74hsFcEfkInb6tjpLq104fDmJbyqLj1fl8f?=
 =?us-ascii?Q?Z9RbIjEjEe4SXzqV/MWSbx+3jyJTLvODNDEef1NT127in1TAajeLJEADAdLR?=
 =?us-ascii?Q?ZiLkf6PB3lJ2ehjWHJ78NtLOGPVsfEL0k0n8+7vBCA04cNR0f7KrogmyOPxQ?=
 =?us-ascii?Q?GH/IT8l4Tx1PKeNhtUWC0yYFIvxAShqesbo9i3xSorM7Qf96KBorwNs8r34o?=
 =?us-ascii?Q?QTyI1HMP9OZ/p3y3Oea/4uWwB0TvNSz8mYVCdF0fStcOXnf0r0EP/v4DJtcK?=
 =?us-ascii?Q?6SmnHxXhZEjqhFbg1cD7F5iIcqtDTeIk9iFrcj49W7AZV1DOFYd78MNPou89?=
 =?us-ascii?Q?EB/AQRmkJYbKxMh77kW9hK7QBrzvidWfao81au07TvO+617Mh/6kf7XQ/GTR?=
 =?us-ascii?Q?RXFR8JY6+1bUB5Pl53MbLSnyBa6fxnkgAdR25CcYonG3W5WVAC1S6wnCltF1?=
 =?us-ascii?Q?VKMIJiWusa5USqoTC51tHhVLMbsfrVL5ZkNN6GBoOv5zNUrg1bAWNR2mRt/+?=
 =?us-ascii?Q?Q8J28+kuC6llFAatxTXtSCk5bRvwajZyoryQmFX8Pwh64MALv3LH8Sw8ZidU?=
 =?us-ascii?Q?CXCqDUcClyJ+DWBL/PwtTu/PNFM099XcNCoQySGprXF40cNcsl78OMbOC4E5?=
 =?us-ascii?Q?r65vXfftpIXU2WxgwhU+BtcFUQEdxqE2UMpO1rhU/MFKl2ggiXNZuE6Ovb3R?=
 =?us-ascii?Q?I1BpalbRRaKhY3W/PHlBRb/mPekg77ISQnXlmDaid6AEDuF/OYKsCT7nY63o?=
 =?us-ascii?Q?rkKsVQuRIgNNJJspj/hCcBx3xPBgDngEBoC9A1h1IIFDHQv4wd2+QZdhevEM?=
 =?us-ascii?Q?M90z+/FlzlYpnG3/ChpmNeDYsMkqgPhuopCgUj23zuB42uYpS/YKmFhnzWNr?=
 =?us-ascii?Q?UJh+QOAYxRJO/Iy+l95Itn911Y2ANnguzUprM1X9DuDYT9BgKYAdWlHujKV8?=
 =?us-ascii?Q?hFk/b8/DwVm9tmOPjWFfi1ezF8heWjwK/yPwgzoxaVrtzhqmqO/xVa6VZ0pL?=
 =?us-ascii?Q?Y9zwGp4MDdUBfwvn/6k0k9aj6k2NXfGOK8/eIhocXCgfEydOy/lsnXHR4hvM?=
 =?us-ascii?Q?Osfo3zMmQ0da+HEg62rQ8rZaLnRRHEw/UcMLF9qPH18bp3yNfRdiETLfDkBM?=
 =?us-ascii?Q?f+crzQUZxTy5PtKkly8swmxa6kayZzrj42FCuro6aMbnBUHJWrrJmfpEdOnt?=
 =?us-ascii?Q?vZ+oZNNtVKbo34zbmc0lPy19O2BTMlfDTj1Mp3ktmFJaj0B0dLDVOmkkQv5j?=
 =?us-ascii?Q?wxbGpvGpEHu1nJSK//njbd1onBsZp0BSWZMf+9Um23PfY++zjdwQ2U2Rtu1W?=
 =?us-ascii?Q?1fGF3uNu8Tr9JZ73jdZVc9UsPW8mLgcQfQUTaU3VbN4CK0lwgoj3Oa64QV6r?=
 =?us-ascii?Q?2pIPA4Y1CjWk384Vk16pwHDIxQ+wErs5mm9TS5v7pgTTSkdf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04040109-0cda-43cb-ddc3-08de57f4d5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 07:23:40.1204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIq4klhq2fxLV/nHUMDXnTqc9T0/3VW+ORQhDklQHVI9MO0pQF3KkRup66lf3lrJ8tAGxBzPHTr52lPLVjvTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, January 20, 2026 9:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 01/10] drm/amdgpu: re-add the bad job to the pending list=
 for ring
> resets
>
> Need to re-add the bad job to the pending list before we restart the sche=
duler.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 ++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 1daa9145b217e..ec8d74db62758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -135,8 +135,14 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>           ring->funcs->reset) {
>               dev_err(adev->dev, "Starting %s ring reset\n",
>                       s_job->sched->name);
> +             /* Stop the scheduler to prevent anybody else from touching=
 the ring
> buffer. */
> +             drm_sched_wqueue_stop(&ring->sched);
>               r =3D amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>               if (!r) {
> +                     /* add the job back to the pending list */
> +                     list_add(&s_job->list, &s_job->sched->pending_list)=
;
> +                     /* Start the scheduler again */
> +                     drm_sched_wqueue_start(&ring->sched);
>                       atomic_inc(&ring->adev->gpu_reset_counter);
>                       dev_err(adev->dev, "Ring %s reset succeeded\n",
>                               ring->sched.name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index b82357c657237..129ad51386535 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring=
)
> void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
>                                   struct amdgpu_fence *guilty_fence)  {
> -     /* Stop the scheduler to prevent anybody else from touching the rin=
g buffer.
> */
> -     drm_sched_wqueue_stop(&ring->sched);
>       /* back up the non-guilty commands */
>       amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);  } @@ =
-
> 895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring=
,
>                       amdgpu_ring_write(ring, ring->ring_backup[i]);
>               amdgpu_ring_commit(ring);
>       }
> -     /* Start the scheduler again */
> -     drm_sched_wqueue_start(&ring->sched);
>       return 0;
>  }
>
> --
> 2.52.0

