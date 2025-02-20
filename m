Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6A1C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 14:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3747C10E97D;
	Thu, 20 Feb 2025 14:21:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kgoAIMrc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3FB10E982
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 14:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKgrzuL450jGTK9Om4dB5O5i1sTgLCNocEQFRy3YhO3ePZ95uTJn7WeMq9lC6hvkB310VmPGKD81XALqr3cEx8FiJQPM8WM47N5IswjtZCmMjifnV/wC0DJxL/0DT7bG0d8a4RzmL7bx7uT3t9z5Ghaolzbd3JZa0gnXQFmlwfyQKnkpT1CjFugPKFquUIlb7uVwBwEFCqitlb4LyehLBnk+HWoN9Mo7ReClc8I/CcoKDlWZOX3tkEoPXwBhAe8vZV4k+SBLR8UlF8zg/iLYKc9U0PbRy2wR9TuUK65h8GOoBu/NwCseTZ6vciVl1Vjlf1BTk4QDMME8p6gDLLcvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajbFnyfGVbtNbxG46HYCc4eC3voRKDnmcjFZPAA1KhM=;
 b=hnYlxAM193U1NrFETDXBb2SoaqUJYMY611D7ULZ5pLqKH6ZUDGVaqANbB2yN8K9ZrNn8RCxKPleoe6kSoUJMPw9Ee+N77Sj1NyhbI4+h/K0hKpOd5K46c0qxhTLF2UCXb2Rz8Xbd28SKk+clxkeaPifoNNXjdT5iR4JHnVPp5HL843eQpZ+8lMG9rDCmSsN5+sqi4u4gqNfB/FykBagOdrbFAD94YdrIYK+EqQv5coc4TFi8DOqsD0sWwfBH1pveTIut8kozjJ6ephw/EoiB4mi1aLVu/wN3HFculuenwahAHc2vSducIEAKGW6GM/njjrDE5fEnOwIoY8TrWeZyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajbFnyfGVbtNbxG46HYCc4eC3voRKDnmcjFZPAA1KhM=;
 b=kgoAIMrcOhxEMucn/aUPA/sEbXltXGaIGIrYj8zbVoeAhlalcFBoNUjzRSB16ZgLXaV/P//AobRIxvLe8fkHhPtaHSsbboJ+TGS5eRb5QTKMi13tK19/4+fkhoC4Ug2cjWGX/AlBkM1Uek9+5kozvlcuEjUIB4xRF/rlEAFck6s=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 14:21:38 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 14:21:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check if
 the ring is guilty
Thread-Topic: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check
 if the ring is guilty
Thread-Index: AQHbfdrjdJb9c6apqUCwl0l8RO6zRLNPS1eggAD+FnA=
Date: Thu, 20 Feb 2025 14:21:38 +0000
Message-ID: <BL1PR12MB5144DE4C1BC16A00BFB30358F7C42@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
 <20250213054715.3121445-5-jesse.zhang@amd.com>
 <BL1PR12MB5144D07F922054085C142676F7C52@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144D07F922054085C142676F7C52@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=271f6545-f851-403c-8b75-0e96fc49bac7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-19T23:11:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB8917:EE_
x-ms-office365-filtering-correlation-id: d0a5695e-9b16-405d-9fdb-08dd51b9e383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|4013099003|4053099003|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?UKObz52uMZa8Ps03lsmRnT6JrWHjgD09TPDutx9emjVwK9qEtbBVAVijACZG?=
 =?us-ascii?Q?7mN7BC6fm1/G6jcqj5uFrtYL/tbi7obY2yh1kExbEcEhxYGyWJ79mQNN96EP?=
 =?us-ascii?Q?XIoYInzKhTdc8JOzM2+Zib7OPcht9ZxlDLZd8YB0SffopAYDmORUGiZQAY/h?=
 =?us-ascii?Q?s145o5kMU06jhykcr/6nrQFQUhvWM9tAlG9zN5mPnQF3pPyzIwvWioucATvq?=
 =?us-ascii?Q?qOE+avs0gdhaEGTvM9JJcjX1QUS2HZTX1mfDKLsuO5u4ySsqMgC4eD/iuBPG?=
 =?us-ascii?Q?dAQbdLx2CHjpNcJ3hU/FbC7ZbTB73KWpMt5m6Q8JKLPijWH3smTy/FBsoFo2?=
 =?us-ascii?Q?XP95Jls1/n6pjbVqIJPtbxiZpsZUR8Z0TVIDM/59ARr97NpjkOpYjILZhfen?=
 =?us-ascii?Q?kmTcqiPTScH4OpI80510Dan3L6djfVtwnFS6HrraUPlYQfvYMCwaqmqp0GGr?=
 =?us-ascii?Q?8y8tw0tyAmlpXX5KPFhC5jZHArLV6evvQbkfWHMe8RDEXKV67xrF5fGt7Q+Y?=
 =?us-ascii?Q?y1byI3Sm0E9tXQVw5WeSnBng/pKl40smjswusX8uYWj+Ozb6SxI0nVH7lIvu?=
 =?us-ascii?Q?PwIgH+AseHpcbBxgJmUMzU8j9+Fa0GWNZNcGsKFUYOfm9Z625/nMUwj3dC+A?=
 =?us-ascii?Q?ni0q56hcORYB4sPJRpWlXcVHcmdtuw7ZUTyqhZEIauAzuaIg2wBLRnKERM8n?=
 =?us-ascii?Q?mvyG7s/sC/I2TGwREIQgEdUZSijcnJ9tLGICGb7eUHYofPBRm8S53qLq0fXK?=
 =?us-ascii?Q?01ShQKyZloPF6dHTLSAX0PQhJJt8E2kSMcwdgERVzRQhrOgjViyJampfqlaI?=
 =?us-ascii?Q?Z6gKlfY3MRdvbPQ9OSmEbScxso1PEU0p6ZUmL+0217xL6tkCTgCQ99E12wtO?=
 =?us-ascii?Q?aot1vOGfkUIDf6t1HPlOfFKvi9Q9foqXIhvZ/KRnPoN7AZdPAsOIo5P6NhYF?=
 =?us-ascii?Q?4UFJ2BFUWRlERkSQUTu3iXoaVTn8HyVOq4OCTqmniG6Ycaum56ZALS4s2nx+?=
 =?us-ascii?Q?lEqNxsNJNehVJgMrQThSADcOM+URLuct2JqxgpQ4IFO653NK7pGzP2kZ9m4J?=
 =?us-ascii?Q?omWMJTFGvtcR2xMlGoZM2B0Yl9SYg/YGi/LeACbBsnrF/6lb2TKOYCslvyQd?=
 =?us-ascii?Q?LtMwTw11hhKSx2qjtBq7PivY9dzFaeEe44D7Ud6QMvOzipYvBNtsDZ6gr15J?=
 =?us-ascii?Q?egRzJE7xv5F9bqJmQL2n1Ow1mFVZ0zR05cOGZIlyiv0dzVQxZn4P/7oF0Ju7?=
 =?us-ascii?Q?3xULRZUC43/7nw1NUhnY+EhqDVjixsLc1YA/KlVt/qTM5NtAhAluteLTrMZD?=
 =?us-ascii?Q?Zp950NhvziUKgA9CAsBPKJF7NKFf/XU1wl4ZfxmI9YNaSpvCVikgkwrpbBEv?=
 =?us-ascii?Q?p+cjKKqLvWoJ2qLZ4Guh2/1tWBXrwHGx/f3U0Ds2E5GLpnUVTwVRFVL9o0NF?=
 =?us-ascii?Q?lKhoZJgEAfDhyfbS6hg8/IgWoyfiRAze?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4013099003)(4053099003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cwcDLWbJlufPUQKQE1d9rTQhZ6shQwylV+yrGuh9ii891rdYC+iJy36eBSlY?=
 =?us-ascii?Q?wg9MtEERWrk91R66G39dLe6mB82aotlI+OQMrlqnYponDDaCidgiPlUJokTz?=
 =?us-ascii?Q?kha2K2VfXjgJfg20cqqFzqcVsAU8bRy7dHDb1dAQLCJPRbxgtO8zWhtpnqTq?=
 =?us-ascii?Q?HUkmGkJueQ82P1i+88gRTI4RVBW1tZ733+tqTUvcv7EUllDJ73M2IBhIqvFU?=
 =?us-ascii?Q?d1NJSTTdVXsVeOrN4VOuDIGVRtH6GudQHZMFwzNRNng8Dtf4O1D60mX/KOrp?=
 =?us-ascii?Q?L7dLNFOXXE2mXr4OIqiSUK1gtm242Ho9ujbp4dNcZ+Wy9W9jlpw2PEdf8ho4?=
 =?us-ascii?Q?UUnobwrXHhrBjz+SDNbMpeIDeyKsVOLRwBeJq/jU63higJfGMMUdCHuwNj2s?=
 =?us-ascii?Q?9Px6N85LD0Ft2n3/oCu1nf4LwaOHjg+RIox2gba2+AcuBqprjRAl0wZtey2n?=
 =?us-ascii?Q?uQC4JUhiAqI0nb7uTeAnS1Aasw4+EotRLJcAVfadawORIjehd5kfOV9N0jJC?=
 =?us-ascii?Q?u6IQ8U/N3zV9ETjwHk3ECwpO2FAW+XS48rM/DO0EkxtMRYyUSo0coGylgW/H?=
 =?us-ascii?Q?F8qDEClcYFM1+FvmPaBu0RJmZkogBq0MRZLSMD15zC2hfHbVy2hOpvnZ0nXH?=
 =?us-ascii?Q?fIYMJD7/l6Ja1JBQ5eVUofO0+7H3sc6M/5JQI5im6moRuMy7rylFe7FEjZ/L?=
 =?us-ascii?Q?ljPt0CYMgYs/AC8WcpoCYsniYfZv+GTPY4dZYjEjSeMvZZ6s2yR0AUKkMdd2?=
 =?us-ascii?Q?Nis/s6mTWCM6OPa4YmS3+VyptrFMkQ2m0vykyM909cYHbKmAea9cWM/KjluR?=
 =?us-ascii?Q?6sTHcVQXXZ4DdOynrAL22zrBDubZXbx6PUuFwnLr0lxg+SVKRABGVw19g5tW?=
 =?us-ascii?Q?ZePc73XcmPbRvn1TMS2sWYuQNQgPilh+alLFPSpWwLutPf/nf2mD2cHTsLet?=
 =?us-ascii?Q?cqV+T5uz9YSxcWwkCC+kZL8XHCVavtY6Q6i5W0hH1eDnkKrC+pAf9DgUKV0e?=
 =?us-ascii?Q?K6gXyS6/PSlBkn7dU50HxIwzMHdPJkIP3+CooQof1tHtHss7ZN7RfhgYiUfn?=
 =?us-ascii?Q?LkXRI11lgHokQaVrpRsWpkOYbmQz4vWOVrasrPee9FuJ61QCG+oWmfwTPMEA?=
 =?us-ascii?Q?f0drMZuO4DBbj9HvT0lDplZPv5JWe/OkW9q1//HhQjJkxkHS/k+NpRA7Urvv?=
 =?us-ascii?Q?Qmhr9GnQlQ0J0PwF0BlEQUE6DiNqgD3V0G2Tiqr1Hd/Pn5w7AWqBr4ccMjy2?=
 =?us-ascii?Q?qXNb+a8/Ar6L+WppCNCKE51WiD7qFWWmeuxeEXut9FVTR3LpGnkp+yvSVJFN?=
 =?us-ascii?Q?/zJlet6i+exrpjKAlfMMm3NWaTSwakua1Y17KXRAcNnyyu34wPWNksklqY4i?=
 =?us-ascii?Q?Lrh0z3Few6Et0jG3BIjnMsYFqpjDMzoer4Blnfv8VfaJngwHLwnbQOV89Dmv?=
 =?us-ascii?Q?x7nEz01q6Er3kQvwhdb9I5TNMqN7+JamdhZ0oa8aNVEQDLSND2sN9AHT3rGB?=
 =?us-ascii?Q?XIrOsLs2sfDft/No3aUyLgubk/USfA1SMY9TOBXXJd+yvjrHOLzhcUNYW56+?=
 =?us-ascii?Q?24UIQPlhwvAb1PW2UyU=3D?=
Content-Type: multipart/mixed;
 boundary="_002_BL1PR12MB5144DE4C1BC16A00BFB30358F7C42BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a5695e-9b16-405d-9fdb-08dd51b9e383
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 14:21:38.4308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzbyBEqLbVr2fWCqD3Wxt6HqndIkewJgwdKIG6ZlDSbSer5J54BrS9gA5GIgjnXVfn1fG6Ick0Esms4GZGfFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
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

--_002_BL1PR12MB5144DE4C1BC16A00BFB30358F7C42BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

> -----Original Message-----
> From: Deucher, Alexander
> Sent: Wednesday, February 19, 2025 6:27 PM
> To: jesse.zhang@amd.com; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to che=
ck
> if the ring is guilty
>
> > -----Original Message-----
> > From: jesse.zhang@amd.com <jesse.zhang@amd.com>
> > Sent: Thursday, February 13, 2025 12:47 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu,
> > Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie)
> > <Jesse.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>;
> > Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > Subject: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to
> > check if the ring is guilty
> >
> > From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> >
> > This patch updates the `amdgpu_job_timedout` function to check if the
> > ring is actually guilty of causing the timeout. If not, it skips error
> > handling and fence completion.
> >
>
> Thinking about this more, I'm not sure if this is the right approach.  If=
 we detect a
> timeout on a kernel ring, we still want to do the reset, but we don't wan=
t to kill the job
> if it's not guilty.  This approach makes sense if we have all kernel ring=
s as we'll
> eventually get the timeout on the other ring and the reset will eventuall=
y get
> triggered.  But if the hang is on a KFD queue, it won't get noticed until=
 we attempt to
> preempt the user queues for some other reason which may take a while.  Ho=
w
> about the following instead.  We move the is_guilty check down into the q=
ueue reset
> area.  Something like this:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 100f044759435..48350d1030612 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -130,8 +130,6 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>               amdgpu_vm_put_task_info(ti);
>       }
>
> -     dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> -
>       /* attempt a per ring reset */
>       if (amdgpu_gpu_recovery &&
>           ring->funcs->reset) {
> @@ -146,13 +144,22 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>                       if (amdgpu_ring_sched_ready(ring))
>                               drm_sched_stop(&ring->sched, s_job);
>                       atomic_inc(&ring->adev->gpu_reset_counter);
> -                     amdgpu_fence_driver_force_completion(ring);
> +                     if (ring->funcs->is_guilty) {
> +                             if (ring->funcs->is_guilty(ring)) {
> +                                     dma_fence_set_error(&s_job->s_fence=
-
> >finished, -ETIME);
> +                                     amdgpu_fence_driver_force_completio=
n(ring);
> +                             }
> +                     } else {
> +                             amdgpu_fence_driver_force_completion(ring);
> +                             dma_fence_set_error(&s_job->s_fence->finish=
ed, -
> ETIME);
> +                     }
>                       if (amdgpu_ring_sched_ready(ring))
>                               drm_sched_start(&ring->sched, 0);
>                       goto exit;
>               }
>               dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.n=
ame);
>       }
> +     dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>
>       if (amdgpu_device_should_recover_gpu(ring->adev)) {
>               struct amdgpu_reset_context reset_context;
>


Actually something like the attached patch.  Need to call is_guilty before =
reset.

Alex


>
>
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > index 100f04475943..f94c876db72b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -101,6 +101,16 @@ static enum drm_gpu_sched_stat
> > amdgpu_job_timedout(struct drm_sched_job *s_job)
> >             /* Effectively the job is aborted as the device is gone */
> >             return DRM_GPU_SCHED_STAT_ENODEV;
> >     }
> > +   /* Check if the ring is actually guilty of causing the timeout.
> > +   * If not, skip error handling and fence completion.
> > +   */
> > +   if (amdgpu_gpu_recovery && ring->funcs->is_guilty) {
> > +           if (!ring->funcs->is_guilty(ring)) {
> > +                   dev_err(adev->dev, "ring %s timeout, but not guilty=
\n",
> > +                           s_job->sched->name);
> > +                   goto exit;
> > +           }
> > +   }
> >
> >     /*
> >      * Do the coredump immediately after a job timeout to get a very
> > --
> > 2.25.1


--_002_BL1PR12MB5144DE4C1BC16A00BFB30358F7C42BL1PR12MB5144namp_
Content-Type: application/octet-stream; name="is_guilty.diff"
Content-Description: is_guilty.diff
Content-Disposition: attachment; filename="is_guilty.diff"; size=1771;
	creation-date="Thu, 20 Feb 2025 14:21:12 GMT";
	modification-date="Thu, 20 Feb 2025 14:21:38 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwppbmRleCAxMDBmMDQ0NzU5NDM1
Li4yMDg1NTIzNWVmOTQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfam9iLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5j
CkBAIC0xMzAsMjkgKzEzMCw0MyBAQCBzdGF0aWMgZW51bSBkcm1fZ3B1X3NjaGVkX3N0YXQgYW1k
Z3B1X2pvYl90aW1lZG91dChzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc19qb2IpCiAJCWFtZGdwdV92
bV9wdXRfdGFza19pbmZvKHRpKTsKIAl9CiAKLQlkbWFfZmVuY2Vfc2V0X2Vycm9yKCZzX2pvYi0+
c19mZW5jZS0+ZmluaXNoZWQsIC1FVElNRSk7Ci0KIAkvKiBhdHRlbXB0IGEgcGVyIHJpbmcgcmVz
ZXQgKi8KIAlpZiAoYW1kZ3B1X2dwdV9yZWNvdmVyeSAmJgogCSAgICByaW5nLT5mdW5jcy0+cmVz
ZXQpIHsKKwkJYm9vbCBpc19ndWlsdHk7CisKIAkJZGV2X2VycihhZGV2LT5kZXYsICJTdGFydGlu
ZyAlcyByaW5nIHJlc2V0XG4iLCBzX2pvYi0+c2NoZWQtPm5hbWUpOwogCQkvKiBzdG9wIHRoZSBz
Y2hlZHVsZXIsIGJ1dCBkb24ndCBtZXNzIHdpdGggdGhlCiAJCSAqIGJhZCBqb2IgeWV0IGJlY2F1
c2UgaWYgcmluZyByZXNldCBmYWlscwogCQkgKiB3ZSdsbCBmYWxsIGJhY2sgdG8gZnVsbCBHUFUg
cmVzZXQuCiAJCSAqLwogCQlkcm1fc2NoZWRfd3F1ZXVlX3N0b3AoJnJpbmctPnNjaGVkKTsKKwor
CQkvKiBmb3IgZW5naW5lIHJlc2V0cywgd2UgbmVlZCB0byByZXNldCB0aGUgZW5naW5lLAorCQkg
KiBidXQgaW5kaXZpZHVhbCBxdWV1ZXMgbWF5IGJlIHVuYWZmZWN0ZWQuCisJCSAqIGNoZWNrIGhl
cmUgdG8gbWFrZSBzdXJlIHRoZSBhY2NvdW50aW5nIGlzIGNvcnJlY3QuCisJCSAqLworCQlpZiAo
cmluZy0+ZnVuY3MtPmlzX2d1aWx0eSkKKwkJCWlzX2d1aWx0eSA9IHJpbmctPmZ1bmNzLT5pc19n
dWlsdHkocmluZyk7CisJCWVsc2UKKwkJCWlzX2d1aWx0eSA9IHRydWU7CisKIAkJciA9IGFtZGdw
dV9yaW5nX3Jlc2V0KHJpbmcsIGpvYi0+dm1pZCk7CiAJCWlmICghcikgewogCQkJaWYgKGFtZGdw
dV9yaW5nX3NjaGVkX3JlYWR5KHJpbmcpKQogCQkJCWRybV9zY2hlZF9zdG9wKCZyaW5nLT5zY2hl
ZCwgc19qb2IpOwogCQkJYXRvbWljX2luYygmcmluZy0+YWRldi0+Z3B1X3Jlc2V0X2NvdW50ZXIp
OwotCQkJYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHJpbmcpOworCQkJaWYg
KGlzX2d1aWx0eSkgeworCQkJCWFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihy
aW5nKTsKKwkJCQlkbWFfZmVuY2Vfc2V0X2Vycm9yKCZzX2pvYi0+c19mZW5jZS0+ZmluaXNoZWQs
IC1FVElNRSk7CisJCQl9CiAJCQlpZiAoYW1kZ3B1X3Jpbmdfc2NoZWRfcmVhZHkocmluZykpCiAJ
CQkJZHJtX3NjaGVkX3N0YXJ0KCZyaW5nLT5zY2hlZCwgMCk7CiAJCQlnb3RvIGV4aXQ7CiAJCX0K
IAkJZGV2X2VycihhZGV2LT5kZXYsICJSaW5nICVzIHJlc2V0IGZhaWx1cmVcbiIsIHJpbmctPnNj
aGVkLm5hbWUpOwogCX0KKwlkbWFfZmVuY2Vfc2V0X2Vycm9yKCZzX2pvYi0+c19mZW5jZS0+Zmlu
aXNoZWQsIC1FVElNRSk7CiAKIAlpZiAoYW1kZ3B1X2RldmljZV9zaG91bGRfcmVjb3Zlcl9ncHUo
cmluZy0+YWRldikpIHsKIAkJc3RydWN0IGFtZGdwdV9yZXNldF9jb250ZXh0IHJlc2V0X2NvbnRl
eHQ7Cg==

--_002_BL1PR12MB5144DE4C1BC16A00BFB30358F7C42BL1PR12MB5144namp_--
