Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2716E77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 08:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B45E10E29C;
	Thu, 19 Dec 2024 08:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V9ZpilMG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BF010E29C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 08:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I49thGtmpQFx79Fkrflso7bYuZMkVXW4VqLQOYkS++1P2OL3p1fRglcjzhjQeptlP343xBlAqhKh4sJPv30zY8lKywLZnnqcjL7+7L3BdDh9KarjHV/F45ss2ilhh7VnfO5EmGepLXXDWNDhxWz2OZ+FuOx3rNYdpuQh5fhg2l1qe8+zEokZP8jqn/S5b/BQz2ubUYBFKCW20z1OCIudQX90++GRDo6IFmtcr/Df8nMLzGUvLQX0MrpLfJYFXBbGGcYNgV/ZnU8v1tjFYS1GucQBYsUx2QAzA8uSQC4MCDwwIPP5SufGSuFsYe6p7Gnu1zOTVN80KALathzS1qyLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cydRT17gDJ9OFDlhGXzKKnoflY0D9SyArNdh5tFPBEc=;
 b=i23gG7NQR94WKyehlT5MPah2hi5JLpEyG+9NUveYiOANAOGLdmOQUZsRVaAvVFOx4JYPoKN/H1BBHPI/EojPbPUPZbOfkxTZBuemwfxE/arnG5P83kN6XF/RSNLA6zj6XGI99wPsD6XHLgnGM6eBoOOzCCNdtJiL/I2MCtqTl8mdBPqdvmHtlhr3TmSFVY7uSaZuqAXmXjInck6ZspzcHOciTW+1ZvH/lonWD01nR22C8nvnciCXGEoa2s+L7X2X0J8dqup2CoBt93BXqzy0x+xvI42ewElJQCGu2ai69skXDdngofE57QRtXW5lhEQS2eUS4wmOG72Q1R5JrmIBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cydRT17gDJ9OFDlhGXzKKnoflY0D9SyArNdh5tFPBEc=;
 b=V9ZpilMGDyxvHW8Q2lub1NmVC6oR2IE5AK7Tbe1STYaV67iK93oV1PzhC84i2wnVXRkyw3vy3s582SRzAZpbCwvforiOlt7qfL2a1jSWMiZ168jqLh8WPodIDEkhSQKcjLCmim54BTMcqjEaorkxCGCN4/K5PyCisg7Oyo94l0E=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 08:31:45 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 08:31:44 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li,
 Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fixed page fault when enable MES shader
 debugger
Thread-Topic: [PATCH] drm/amdkfd: fixed page fault when enable MES shader
 debugger
Thread-Index: AQHbUTc0YquUsl8amUC/3ih/MYB9X7LtPi/Q
Date: Thu, 19 Dec 2024 08:31:43 +0000
Message-ID: <DM4PR12MB5152E8A1890753941154DA71E3062@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241218102541.812627-1-jesse.zhang@amd.com>
In-Reply-To: <20241218102541.812627-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=88c68b98-8ee8-43c5-b156-e87d9b8ffc1f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-19T08:30:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL1PR12MB5921:EE_
x-ms-office365-filtering-correlation-id: 05fcd4c0-e6e8-4bf3-a084-08dd200791d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Chwwn58f1mVVly9BNKE197xNgDm0NpnRQUjf3C8AJ4abxl3AaP3sWjZBKYBV?=
 =?us-ascii?Q?7kUsxD31/X+BLZ6kNgtm8OttOv7hW/L60YmY4MUZhoY7OZKrVacWj5XCV8Ei?=
 =?us-ascii?Q?0XB7t5FfQwmtlJ/AZr48GG5A8rmHw9KXoJZs6CRGNgpkS3lwjLGxTE1IN346?=
 =?us-ascii?Q?8eNMESZLIw65gOjSnJ8/gwXnOvXmz3sQgH2E6KQFbhz73Q16jjNwsKCU6A6b?=
 =?us-ascii?Q?dFt0vvqtYh4QWxNE28j4ksIOUiuIoDrrIeIqsKjUkFl6pGFDQOpJJcMDb95T?=
 =?us-ascii?Q?nQPcB5oCXVCzutF0qdVgHh/mHDeI/ZYhq2gXRzCCpEA+VD9noYX/WapRsI4Z?=
 =?us-ascii?Q?YHuLiwLNFAO1ENUAu4Ek7f3D7TLi0b+qCIxuTly196uPKoh7hLzWaGRMW98b?=
 =?us-ascii?Q?23QeDq1ZIcTQLPi7vj+DS+BPCP6C5GNcpExVZybsKyOEojTuxtPqAMRSQPiO?=
 =?us-ascii?Q?0nZmhXNlO+w6iBGfIrhpmV6p1p429MFoxfZM2msHZrhjsCcAhCo7vxBCO4dh?=
 =?us-ascii?Q?ES74Yww49aBmD9uvfArEOD4T2RwxRH8t4WWcg+k6LpdvRmYB6vq4IGWmeTzF?=
 =?us-ascii?Q?1Hr+V2ng/n2d0Iyey+nmsxJQ5IhTLERGHLPTrrsZLfAFV1X9k2JLRcqZMVB6?=
 =?us-ascii?Q?7PQ5S8txNTXnk3IjLEPZj/sNeCpX33EcdwUNrws+qOv+j4JjilECuGQ+kpuF?=
 =?us-ascii?Q?SHP8ZIbqzubuO1hRbE2TqLa87HR1LtXtsanq4MAOpfmVKIDrwenbSMfiFCRI?=
 =?us-ascii?Q?LMpI9uVkFwtm5E9CbHL5kEM+xFDjHUUqUtQq8XixPeS3RzqFVF1Ty01jVyEt?=
 =?us-ascii?Q?r1VHi1vmoXwBbW0bTmGdeVytdUln3FLbBv6Bp8ruxPlPz8ZhAgwcQWC3xTcY?=
 =?us-ascii?Q?yVQ73tWuAWEe3Ru1hyDhQ9B6P50rZt6FO+Tkvvsh4At5x9sabiJ24xz0DLbw?=
 =?us-ascii?Q?kePTCXxSWPPwByxRo0b+CdQeccikOkBhZkk5ilHLK87npl3Si5hvdqDjQpV7?=
 =?us-ascii?Q?qCN6qXYofvdGZ1L1axzyiNOxndJqLk/SnI/0FwayKcSXe1/gWRaO67zF2A0k?=
 =?us-ascii?Q?sZxCRv1hAJIdH2yV1/4zc6YtWOAik9NIs2AnE2ApQNqYuMJMMSh0b29DhCvZ?=
 =?us-ascii?Q?EAuOe1Zi7OlF66dMBh8aamAAzICK4HXJnMsLYV6L+sMJpxivtRY6L+rzF0WV?=
 =?us-ascii?Q?bST0AkSFVraIyY5f8I76WygZmW1EerJ81Z8OJufgM0Giw2BNKkpfoJiUzvKj?=
 =?us-ascii?Q?gQAU0X00Q4SW5zmkNxIxOY/qcEPGZYtv36TCN690ZzE8DXc/LI2inFVaq9sn?=
 =?us-ascii?Q?tdcp0hQOSTUbPSfA1KTi9UeZANTJY1Sym6X0zrzx27dvoKWe9/zhEU5vUBxz?=
 =?us-ascii?Q?Jbp+Mdgus+/1/Cmgbqar0l8m4khf/ROI39VFmOSRAKVTW42/wDCu7OBdNMhq?=
 =?us-ascii?Q?vHfoRc5DYX0Vgnxz4Nu2mvDCtimaCiTi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vuJ3h178EqHpfAENb4A5unpq1ri7GdnExV9HoQ/CxVLCHBZuzfdP3pEs8Wzf?=
 =?us-ascii?Q?/CdcXnWbD8z+xUR5Q96xK3rqRodtSZfqUiSQWd3dpe31fw+dme7FNy1T1tKh?=
 =?us-ascii?Q?w/bsmX2thtwyh53rovluA7a/CZ+hdIT+/7PWujuAcyamipDZ3zgIRg8VoMVm?=
 =?us-ascii?Q?tW7/kOoLWC3JVX4zfh4W8m1vRKnrJ64AsNGDs5Dh6LUNMtoTpIAxuFgy3bV+?=
 =?us-ascii?Q?VFOyoOlnksAyWvIipB4LsfZM040B28K5QwxOguXMFBZYVLRKXHyrkK5jhpQf?=
 =?us-ascii?Q?0rwYTeXXIoJeNBbYM5IpPs0p2OWasW1smRt9ZmPwWqcH/IrHnQ6O3xBsYH3v?=
 =?us-ascii?Q?Azs24CxMytt9/l5tpDSa6lJq5ofTPS/DnLKSLPleZ86fqSUlozpDaKvDOCRk?=
 =?us-ascii?Q?Kjikvn7bQ17a+Jd6b2Rwg2zwDMHIe0kdrLwxIh8ZvZk0aesPsja4uSOHmAnb?=
 =?us-ascii?Q?OTrLyn+JQyjuyZonX9RybUhCNyk0+q6tfiCnsbaeO6uS4TmmQQVEnHGb4vXx?=
 =?us-ascii?Q?rDDi/XwRO139BSU1Mq8f5zjhY7JiSg+UpRTA5P4ejLWfCl+E7k9ARJtqvaQ9?=
 =?us-ascii?Q?utPthpAijpfLamtokDKk3OA45YdhKDKz7Lw9GHZrz7HUrUzGK1qL4pbUZHsv?=
 =?us-ascii?Q?iDWDNrIK2GJRXT2vWOsdcDL53bBzz4bmz4l2hMk4Vn8M16F4YKFyVGOlQM0f?=
 =?us-ascii?Q?6xqL1miY3nQlNuxqiVf3aZW3kxZfamizF3C+UGcsiYxweuYUstcUVFwI7Yof?=
 =?us-ascii?Q?kci4deB/JwXtO1Yb9toUBmhaQOK6hLqRsNc2YUCSn03utSBGgq5qU5UAv4LZ?=
 =?us-ascii?Q?LQl4jmRVlZoZkc4QNiWJBFTBaR2reSBa8KkZnsgT6bRg2fChqc67O2fEu03E?=
 =?us-ascii?Q?e3R5PvS6Nr+Z2zw+cxsrVdc8NDie0mmUBErfbg5C1gIBkAFMiSyvTuqoae5m?=
 =?us-ascii?Q?cZOpKj3lGuJ/gsfPhVpY9K643nL6Y3SI2u7iIud82rvoHZJoRqw6cc0GHVBq?=
 =?us-ascii?Q?nR4yLGWLKyMDzhkB0MS9IdQhiLFpfK/JbwPXTam2F/exkFYdB+DD9Dic/Bbs?=
 =?us-ascii?Q?fXLMxDD0DnqhZGJg5r4OTpEr1+ybM46lMv7Xmz/ReNguKiVpvanp70uHMcS9?=
 =?us-ascii?Q?QSvxzdaKhhp3XM8xSRW4grxQWOcpbvX8J+BURWLJd3WM4l9N+HZ/I5kX2xme?=
 =?us-ascii?Q?Y7ACiDDUAxSVheeP6HZvIJ+FR/XzqH0Kns8/3gwIkLGbS1xldkZ+4Uel6UtR?=
 =?us-ascii?Q?cpjqdkq6m4dMf3Pt5nmpDUSbHmbgR583ECQHFWy4iSGTLaXd/5heW9Ndux2v?=
 =?us-ascii?Q?PUmPLXCbai30yCZRXKzdXwYOpkfVHCWmXZBSAwnp67cTcf5HifRx1rMhe2vY?=
 =?us-ascii?Q?jlg2nXx0H4o8k6a4bAnG6kvs66sUNGCJJeEKuhdhyo/K243DuxwRLPMUF7kK?=
 =?us-ascii?Q?ykean5EUeGv1UbJM0CQs6C+6BhJREnKDqeKiiDtIOoYkO0TBYZG8xbTo06GB?=
 =?us-ascii?Q?03rxcWgHfvbQ4I6zo/M6mt8imt3kuo+RgQQnfyddp5Bp0c1X68hO0Ew+Cy6f?=
 =?us-ascii?Q?xkOhmBKB/PqGublqKcU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fcd4c0-e6e8-4bf3-a084-08dd200791d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 08:31:43.9621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zrge/ebLHbIsBwJUJjp8ZJdE4JpCocdhaHvZJ6sPe1gglkcNllrq4yf2tk8ffbGe4nvGQl6JdZM1sSGhASCQFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

+ Teddy,

Ping  ...

-----Original Message-----
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Wednesday, December 18, 2024 6:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: fixed page fault when enable MES shader debugg=
er

Initialize the process context address before setting the shader debugger.

[  260.781212] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 r=
ing:32 vmid:0 pasid:0)
[  260.781236] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0=
x0000000000000000 from client 10
[  260.781255] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS=
:0x00040A40
[  260.781270] amdgpu 0000:03:00.0: amdgpu:      Faulty UTCL2 client ID: CP=
C (0x5)
[  260.781284] amdgpu 0000:03:00.0: amdgpu:      MORE_FAULTS: 0x0
[  260.781296] amdgpu 0000:03:00.0: amdgpu:      WALKER_ERROR: 0x0
[  260.781308] amdgpu 0000:03:00.0: amdgpu:      PERMISSION_FAULTS: 0x4
[  260.781320] amdgpu 0000:03:00.0: amdgpu:      MAPPING_ERROR: 0x0
[  260.781332] amdgpu 0000:03:00.0: amdgpu:      RW: 0x1
[  260.782017] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 r=
ing:32 vmid:0 pasid:0)
[  260.782039] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0=
x0000000000000000 from client 10
[  260.782058] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS=
:0x00040A41
[  260.782073] amdgpu 0000:03:00.0: amdgpu:      Faulty UTCL2 client ID: CP=
C (0x5)
[  260.782087] amdgpu 0000:03:00.0: amdgpu:      MORE_FAULTS: 0x1
[  260.782098] amdgpu 0000:03:00.0: amdgpu:      WALKER_ERROR: 0x0
[  260.782110] amdgpu 0000:03:00.0: amdgpu:      PERMISSION_FAULTS: 0x4
[  260.782122] amdgpu 0000:03:00.0: amdgpu:      MAPPING_ERROR: 0x0
[  260.782137] amdgpu 0000:03:00.0: amdgpu:      RW: 0x1
[  260.782155] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 r=
ing:32 vmid:0 pasid:0)
[  260.782166] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0=
x0000000000000000 from client 10

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_debug.c
index 312dfa84f29f..a8abc3091801 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -350,10 +350,27 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_dev=
ice *pdd, bool sq_trap_en)  {
        uint32_t spi_dbg_cntl =3D pdd->spi_dbg_override | pdd->spi_dbg_laun=
ch_mode;
        uint32_t flags =3D pdd->process->dbg_flags;
+       struct amdgpu_device *adev =3D pdd->dev->adev;
+       int r;

        if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
                return 0;

+       if (!pdd->proc_ctx_cpu_ptr) {
+                       r =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
+                               AMDGPU_MES_PROC_CTX_SIZE,
+                               &pdd->proc_ctx_bo,
+                               &pdd->proc_ctx_gpu_addr,
+                               &pdd->proc_ctx_cpu_ptr,
+                               false);
+               if (r) {
+                       dev_err(adev->dev,
+                       "failed to allocate process context bo\n");
+                       return r;
+               }
+               memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+       }
+
        return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd->proc_ctx=
_gpu_addr, spi_dbg_cntl,
                                                pdd->watch_points, flags, s=
q_trap_en);  }
--
2.25.1

