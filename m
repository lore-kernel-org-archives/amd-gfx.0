Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D945C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 02:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9914410E9B4;
	Tue, 19 Mar 2024 02:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mMoK9lso";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B927B10E9B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 02:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4ySKw8bFG+uL3oKoYZg8Y4iUUfYQHmYYd1lA5r1bayYE+DSPdfHQOzaKW5FT+wZP2mYEncCpstIs9GPOlTzCfvLtzGlEsjKuAZMw6q6kS/PvlUlW1GIwdpR07/A00yzHuGx5wpPRVb0YpZbTVE6ZIZUuhz0izROi0/Ld+td3s+7cpgohwIw8qXQQTQRNBMkCq9+dQ+PY/vBeRl8dysTtSGodFJ29qFHNDJTAZsD+wmjJq64nx/PzFb6dY0jzYa7fYckg76qwClat5HzeAbrBP1JYkz3U17BESz8vCaffb2RXUDA01avb8k/AAeO8WJ5eJwbyqC40bnTAXvrhpsBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOzLdnR07C7RZlM6La4l6fSJ8oYoq8mKxNqYLA2knLs=;
 b=ofzlsTiQEy2kbYpQArbQZxFvzZbEz0PNeGsx0OPpwlSlntnLdD+AEZcIhRxUnjwhwVoGmCvPePymPryoA2v/3eXCH5NanG1h7vffy6FQxyzsa5rJeCqtSxfWqAtL3Bd2ye95eUHg7q+rpfzvso2UtRef2rnjER9uHrMeUDyD69kEGebhNOjCJ0xAVhQB4iYdkrDIgnjBcH0JgPfQjeXYIEUQn7omSwtwC8jH0Pk36b8wT2Cv4BP5KghnJg5HMxFfYWYqjcOdtp+D+wK87I7zIK0dAWUejgXs2AV89nKyKwqwYcKQIJDpFVyfw2LM2kp3Vn46haGK4t14XzfrajAeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOzLdnR07C7RZlM6La4l6fSJ8oYoq8mKxNqYLA2knLs=;
 b=mMoK9lsoulFktEyYJDHJPvqQmzSq6lMiTRvGfEf6uUqEgJbW6e49qqQCqaSXglKafV1DhJ9PHleSJweiVbW73XhIek1lpe8J9tQH2WW2KGR3ZxO1oM86fyP2uvpteRa3GmZ4Rr9VeShQOzOspefCf9I1VZ02b1qQZn9TSqpxA6g=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 02:49:39 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 02:49:39 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lee, Peyton" <Peyton.Lee@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
Thread-Topic: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
Thread-Index: AQHadTtmBzyF9l2jTEyG3dN6M/a1u7E+ZX8g
Date: Tue, 19 Mar 2024 02:49:39 +0000
Message-ID: <MW6PR12MB88984AD69C1F0CD080C4CC9EFB2C2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240313114451.1592772-1-peytolee@amd.com>
In-Reply-To: <20240313114451.1592772-1-peytolee@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9cb93732-0c12-4062-a7df-55f7298fb79a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-19T02:49:32Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|DM3PR12MB9434:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cv66m0pSXAn1UUlrEiLG9hIeym1ksjiIZsD0dS8HPEKAt6gQJlj8HjyzlZAybapWJVAQiDDBPk+t2YJjSr1Cmg9stDMCSEzQrCjBbbv7jiQlaGdIcvusPwsYtM41gM+lK6Ze7r7ZbdlalBuwd0G9yOQRSWAHSAUVHxoSg+Mwfzzu2K+hlQpbE80tjqVBbiUNS3EHefmmjhx3sq4I0vxIKO0fAF9IJNG8RlPZ6Nr2SPCt7LMqQiAZ6l0wYOPlOKHu0lOS+nCTk6fqsViuDT4q0UDZOaoCOd6stnMDCm5FAg7xHRfEg9bjwKNkn+LrWA08a9qYVtcg9c/zIIWzusa1tQZsmLTsgCw/o2FI/eH1C/F9Eoy5IAhe6rRRba0kk8OK9UYLBAzrChebS+PuJnXX2JTtVsqhY7Temq/xOW6TQsN+YO/KYHTI5mkmQf0E3najkGsarCjAnewJq6PCRcZKOmY/ZoEj1huUpfEf1Rp2aAeh14+r0aIprvzsnFPlmSRgrVzLHiMk3cjGk6fFIOat5bF5VXeGnBB4jcErRWg16J7sGr00W0ECdZ/cVCrO6zXLzCAum9ZWr7eVx9VYI7ZicP+Xerkbi0V1WBDlRzepQeMFW4Yvxtl+1vyEQDE1WiG4m6GQQdv2KT9r2RJI6gTNMgmMhpL+4MsraQmdmHl8JLY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m5+c4Xk+ZogmIxd6OdTN5j13hQjaCMzF4zxLEzsU1rQD2KRshDOtZIbb6iZb?=
 =?us-ascii?Q?I9iVnx2/rPn/mFDUjyFDQ4AKcuFiASKAsAli4TH3d5FXltw75Eg/C5aIu9ah?=
 =?us-ascii?Q?3qwOA3M14QQm40+2OMVctfdNwuqmOmbXOIQJlX/PP1hSKgtw8Dye1dFZvCsI?=
 =?us-ascii?Q?OXy/PafOME/4WPcGhe0P+Xie/Dxc8+78mEcnlkyP3gtPoNBB4qINK3cZwRYR?=
 =?us-ascii?Q?ZDJuwI3pqAutkWhku/5zMIwWUcdKDBAB7U2fkK1aSigGK/eWaQRZRBzBCf8P?=
 =?us-ascii?Q?e2uQ4DVamgtvfoCyaq0C+y/L/VCtQDWqchDXzMCTg0p3M2uKJrH9ppE4Wm/d?=
 =?us-ascii?Q?RghkCUyWQMtxfO9DI+Z5EnzlQUak512uGDA7RVPdH8L9OIdE5vKLiwsnz6JY?=
 =?us-ascii?Q?W2gh2qmKwT7jClwhJE/N0HGL7EOgEnBjv/XHa2NohOBFcgBDjZGmoaAhG+mR?=
 =?us-ascii?Q?I6rbtaCT42L1Y2NyMiMh0g4v+5Q12kf9TCHy8VWahzzE7KbjaJqkqd0YIn5l?=
 =?us-ascii?Q?c+fs2fgia+Jus5ckxaSl1YAy6B0mZSQjQVExvdx0BxV9bcMEb5CBBH52XhmK?=
 =?us-ascii?Q?wz8NbjUymIlKXP6fTBXlXdzk78bWjM9DeCasErxDly+iu8VVfU7PnS/n1R75?=
 =?us-ascii?Q?Pjv/RefHgg+izETKf8qVlle/ZL26kpfXclH10GfU/SNMwNbOzNffsB+VYrcp?=
 =?us-ascii?Q?4tTo1GqSHSP6t6Ne61j6uhj62Y1uC4ycRpgA8NBXAq1w3ELe4BoYLhW/NuS+?=
 =?us-ascii?Q?o8p7AnckFY/tNsZGgqIoqzfDWZOrqT/qnV9kbBm82EhPxh5uABjJpY9tGfd8?=
 =?us-ascii?Q?7+Lm76AUOFRPf+IQhxKKCqC5/re8FFqrgX4fdMotcyhC+uzpHdEC67bOtPH6?=
 =?us-ascii?Q?EW/dma9QUEqDVfXiKeBohMs665VWLCNpVGQVwACJmejdJgfpMnHINBe2cwU3?=
 =?us-ascii?Q?Xunk65klHltwCPDPI3ONjs/5hTdQSm5Utt/IHLChkZdvDCftvru6MnEheZkf?=
 =?us-ascii?Q?AHhcOJN69dLO+Z0dluOSgJCjrDgK+wOj6U5488PrC6BQkcrGXbumGrVaY/gg?=
 =?us-ascii?Q?vnKOfwKov88YRQMkCkHka5aVjp270buhYn97Lx/q+RKqaeR6CW0xJeWRYWh6?=
 =?us-ascii?Q?8qhbXiUcxQcSlJDAsSV5DpEYivXide+feMWbIq4AqECMGnRyzeyCtvKk8x7y?=
 =?us-ascii?Q?LH8ZcPk5+LPZi9YxeNu26xsRZvQLbYTWslMVt2EZ5MiH6ANH9JqRbKwyWyXI?=
 =?us-ascii?Q?AgVAWVOWqpUkZACk4Ly7HtmQAm9vfMCWmPJvCUss5E6XZurKZVT8h2YXvjzV?=
 =?us-ascii?Q?r9cuKZoRS8LafmeRbFoHBlGAZU+ho7SP4hVAGAz+Nq8W6FV5JOeyRzG/qJEU?=
 =?us-ascii?Q?4WqhIYEddnJwlHjnnh+lIWHrPSnSIz2Fz9NOQXdbJ2ZZIy9YpcsaX7QqCNf8?=
 =?us-ascii?Q?nXJrOkYU4ekqS7ItzreZ9NLL/K3yn4SODifVwiumJT21lEtLvOzKVXqb0e7L?=
 =?us-ascii?Q?kwgUUdYcGkFVo4R1isWjwcZsFdYuDQnrbnykt9vs4uvZY6+U6WBMJTJZKvE3?=
 =?us-ascii?Q?QcQhHDOYtyQawMFRbLg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3138f1-90e5-4673-e3e4-08dc47bf3897
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 02:49:39.3430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEKO6woKB/wIfs+x9Yep2dLqezW6vLofJM0A+QdG+n7y/u4ymonFz86QaQZ/sznhTSKblP90e+P/tGuZ3zljiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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

Reviewed-by: Lang Yu <lang.yu@amd.com>

>-----Original Message-----
>From: Lee, Peyton <Peyton.Lee@amd.com>
>Sent: Wednesday, March 13, 2024 7:45 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
><Yifan1.Zhang@amd.com>; Ma, Li <Li.Ma@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Lee, Peyton <Peyton.Lee@amd.com>
>Subject: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
>
>To fix mode2 reset failure.
>Should power on VPE when hw_init.
>
>Signed-off-by: Peyton Lee <peytolee@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>index 70c5cc80ecdc..ecfe0f36e83e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>@@ -396,6 +396,12 @@ static int vpe_hw_init(void *handle)
>       struct amdgpu_vpe *vpe =3D &adev->vpe;
>       int ret;
>
>+      /* Power on VPE */
>+      ret =3D amdgpu_device_ip_set_powergating_state(adev,
>AMD_IP_BLOCK_TYPE_VPE,
>+                                                   AMD_PG_STATE_UNGATE);
>+      if (ret)
>+              return ret;
>+
>       ret =3D vpe_load_microcode(vpe);
>       if (ret)
>               return ret;
>--
>2.34.1

