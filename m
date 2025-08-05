Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B67DC87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 16:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F372A10E6C0;
	Tue,  5 Aug 2025 16:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kyEh3oV8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EFCA10E6C0
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 16:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4DYs0HXUtgUSd514O0CDruo6b6K/4CJROTXCJ+fALY0VDnWwMr6gityLicn44KgyYHCbjczleuG7DHGWagVz/vmdswhluwQi/encRJ0h6LziVgQobosJOJq3jOsRVU4cA+HKjdkhhwtyRTLqWIjmNYGgmfdx6oLjTL/FsmR+yKLZXOsLxKM1NfbPsz907++bUy5IjE8axtFBytPVMO7IoPlfI1QzN4dhrhUXUcZjh1WO9rM6ZKpyYyRgrazIlqhEWHlDIEpz/TIJYzbjXl1uQDh5ybvUBdnS+gqHfcCvBngqY6foST7tTYvnahVu54gLyGVJFcgR6u7LxMMmam4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8RXtyCFDi2bmpTTSsQuytIkFXbSYU12h3h8w5mKlQw=;
 b=w3VsdIClPRrnh+apQNBYoJSDeF8lROct2g2azdlXDNKNyzkRm4/k0wU837hYx0VrHage+u0CRAyjfnsROc4GVsSShqv2Oy8Qg2WH2W84tJT9Gvf6TByFCPmrhUiteWCfr+yKtYk2jXtWrrRI493qL1iZTtGkcuWd51Ei3Nv59NGj1Fsegyu4/y5Q91vYh6BMZ8L9gs6J29UyWbQKZPFPOBcOLDdkM7pRHvoxc6lmdFNgtyuONYH2U2SFuFMJR+kCahj5tnEhriW5h3EqXHqNGNnib2XgnMUCNHOmuzUjq9OCu2eeel2duYBkdA6vDCt/tmLPaOPUhVcqfGn7yDdHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8RXtyCFDi2bmpTTSsQuytIkFXbSYU12h3h8w5mKlQw=;
 b=kyEh3oV8gJIVF+ZfPrlSgSBhZMoR1PpH5F3E2BJP3fT3t5KHsZAljMu9g/7G5UNL7T6nWqL1dzHIPivvdBc/7epUwXdZAx4VtSbzeFShL8ppfCZ2Qhmo7Z9j6Ieu9gPU6LH61xPaiHsU2s1L8UUx3a8Lt/Fv3oDwA3jM+nIvgnA=
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Tue, 5 Aug
 2025 16:24:10 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Tue, 5 Aug 2025
 16:24:10 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: Re: [PATCH v2] drm/amd/pm: Increase cache interval time
Thread-Topic: [PATCH v2] drm/amd/pm: Increase cache interval time
Thread-Index: AQHcBiDHSr02G9WADUOjYHgPAFCHOLRUPdTW
Date: Tue, 5 Aug 2025 16:24:10 +0000
Message-ID: <PH7PR12MB78203D095018F51230B8037B9722A@PH7PR12MB7820.namprd12.prod.outlook.com>
References: <20250805155058.669805-1-asad.kamal@amd.com>
In-Reply-To: <20250805155058.669805-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-05T16:21:57.9838117Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7820:EE_|MW4PR12MB7383:EE_
x-ms-office365-filtering-correlation-id: ff8a463b-c15f-4dc8-8ff1-08ddd43c823e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OVX9erob9MP+rdt5FmOQkHE94w9Ik86BjOTV/ECNU8kbMdUIvCYAcGFK6ayz?=
 =?us-ascii?Q?be1Vn6I3BCYeAS8v+ZBtOmzKZQAFdJVR0p/ggnjIuXxl7JyQZnyhAnNKbvUy?=
 =?us-ascii?Q?EXJXnr+UGj6KN+EhZauL00wsyV6pK+Jtc1m91u/yaWGZV4H5VYtpTvnEKlfX?=
 =?us-ascii?Q?PWJQ1fnPs91gL0zythLvC5kPGav6T6+3FZN7h9uu+XuVfXzZbcdlYu20fbDJ?=
 =?us-ascii?Q?8sv9RzOeRLb/aygFyGbgSYlbQ4MXSws9w3gHHRZqtJfasukyODQcHUOW51Ak?=
 =?us-ascii?Q?qY0iIW8FKzZ8Si3ZdMFGvW0+2oFlSiWWvW8UWtveU10A17cMqfs4s8OvXN79?=
 =?us-ascii?Q?iM8GSzBviPbMvAagBOpKvFx6Otq8DbfVDh+16DuAoxZLoO3f8s/BV7tVCdVO?=
 =?us-ascii?Q?INT0KpVHuJZ79hVYuhw/d63sn0Zkc7sv2bI0lK2QKyrem1tTuFaqSS2gfAcH?=
 =?us-ascii?Q?VTMZECFoqOCclGSyH/5Ml/g8BTVmpW+WupI/hWM/oZkH6oXCcXrZPtspZJ0o?=
 =?us-ascii?Q?PVga0yTK0FuBSnU5umn08a6bZTFogJ1CYzk47y5GsGN2xWc6pN5LnVDEoLCq?=
 =?us-ascii?Q?9Yni/ZC7DU9QCG8/Oh4Jrm8IE0XAK8Z+Ah0O+GTg2vLhjoJHZrpdlX66sc6k?=
 =?us-ascii?Q?JrEJzENU19ncqNXXvqfKW/DMDDS3EXcfPCs18DQjf5tp9m0eFDnZC+P5Tjzx?=
 =?us-ascii?Q?MH++VK9BX0Oo8JW8jjRs5c2PHm3QHr8fd8Ru/DCS+BHwnb9ROqXHnOz/4Sl2?=
 =?us-ascii?Q?IwJn5wYPE8ogDpZydXigeyDKWMwJwoMccnnf3xzjo4MDKOFVlqEcSjlxLgLb?=
 =?us-ascii?Q?DATrJd0sJk/GT73W0rYITlay+Js0020RW5goOVkfYGX0R7mLkSTbp2hFhwlm?=
 =?us-ascii?Q?nYRNnba0B04i9I1nG5ZGaJ9xwfA858ITjl/ldy3nuUnE9kh5dJBE4fL3NA0W?=
 =?us-ascii?Q?x6huDGVt9gO1DECKkxwbEIFkAUhQBr1iE38WTO9CejIomj+cHFwTQYlmEgvG?=
 =?us-ascii?Q?A4AMwhefe42pEXHDvTryqP9Ec5Oj8/4uQnZp6L56ZL/4c/CrdpbJkB4bMLc4?=
 =?us-ascii?Q?QHGB9w6ExeOSWE/8owCokZvg8d5vBeO4Tl5hLWIVG/DxpSyVTyIj02MQN5Dc?=
 =?us-ascii?Q?BdCqO0mnFtQaeANCDm+WshzXSRyhtK2z1ALVu12/IY9DNxe2oNEql6KngAU8?=
 =?us-ascii?Q?Z7sJmUVxB9oVgnyRL5DJ6AYB8ZTsNLGzQ+F6NYYUS+g8XxhwIMN3doVDhK+Y?=
 =?us-ascii?Q?54yJa6sBb5duErikPzMlnwb7sduXOD/IWjoM6+08t/mLw50xD1lAUy4VK0HX?=
 =?us-ascii?Q?5Ko8rwZgCE+sheq5VPJ7sc2D9UGNS1y3TCx8ckXhHrM3PLRyPfet0M2mmFJM?=
 =?us-ascii?Q?NCbqI0bccc+DJz0CGLdeIpMkMGCSsb6guZGR4XfQyb37jX5J0J7yF8EtyEjx?=
 =?us-ascii?Q?sg1FedanR8ZQTaqNaYsRbcPtBKHol8NBkHsqt0gDxFtxZonHorOGAA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?loIcLAO1MmKXoU/V3L8MHTq08zBk0W3jfP8nZCQcLaOEn0KWA+hZHF+Lracz?=
 =?us-ascii?Q?T9zJcGw3yBFuBXik97rPyKkGVUWs16KND0aeYHfScMvFcrcTHffy5iQ5nTEB?=
 =?us-ascii?Q?wxhJ2a458DNaN28A4LYDGpVAkrdcq0SXJU3EosdgCT7B5osmViD95mSO6pZt?=
 =?us-ascii?Q?lAL2wjFWtfhcLTobuLThPMaA3zKbhZFl18OT5PMC9IdtufK+vhShvFvYmlPU?=
 =?us-ascii?Q?FcRDFg02CNv5uYxEayPCy38/k4dNv/LHJFQvP8elnYIsEMVsJrbHJ4ZxlozI?=
 =?us-ascii?Q?dl4r3hIy3XMJYwv+iEImVYWftiOHyEc1qEvRvOAvAxKeWCMXgXtcgBlG8v/T?=
 =?us-ascii?Q?EXW1qT1Ld/EyHhm9dxQKWqQrAIjMCR5VZaEwC2EU6vr6WPIlY6ZN3cyS14MV?=
 =?us-ascii?Q?n3COMBlO74htJ4aOqEfblhLiNfM1jduvH9REMi27oRoTlBYFVYh9A577Aqgt?=
 =?us-ascii?Q?rhCYhLzWaY2lppjCahYo+UeFEoetB5UpGUYwjL/Xvy+H6fABq2lf1ClYgXvi?=
 =?us-ascii?Q?XtIg9TsHJVgXscneLMuz0RzVm5XoJycW+hlblBgBjjzK78Td1eRojmD4KK1v?=
 =?us-ascii?Q?yzfTbWnjbfbNdPnrpoq3jK0qeLhH6zKCWHQh72Qv9GuxVaw7NwnQKf/2/BI8?=
 =?us-ascii?Q?km9hOMbmItTYkRy9cqwGyPtJx8Qgg5HSNdU6VNUqlczfqUZcQSfFSCnK3eI0?=
 =?us-ascii?Q?00M9UjaZ5K2QU3GazvsHw1cXJUzuj62Z6L63MlgA7ZHxbQHZfTDWBJaJ6TFD?=
 =?us-ascii?Q?3AeS6s6UrBDZf/pLJHgvcbgfGj+ISVwC83JfuercV4h/uWPu0v7IwjTkP8eA?=
 =?us-ascii?Q?SQWpGWJ8CqF12AVg9Sr0mi4O2YSeFqIzY7yTlDZCFgObSkdbHy4ytPeQ8Xl8?=
 =?us-ascii?Q?22+UD0BtEBiEUsnLtUha7pHgFlLgk5/B9jcCgBkMdIJrWOvbEoGSQ+ksBxL0?=
 =?us-ascii?Q?Ff6tSM6T85K/LInJKlHGR65uivvPMBhIU3LSTtxYhyfboWR1jB8k/jt0s7Kn?=
 =?us-ascii?Q?HIG6fcmcpCjSTwRwz3+d9J10BjrOrmwjAAXXUWX2/ZvIa4HeKpWqVzBYNZ6m?=
 =?us-ascii?Q?sPhq6/HS+XMXAMyxcip8kDrYjRKaoiEVFtwzz1+IgrzuUO+T5znghK+sihRx?=
 =?us-ascii?Q?LLp1GDUTDXL3koBFlHj+MfHf2LimeF0G7ISqWdhPNJNxzvZWOvIsHCJuhl6e?=
 =?us-ascii?Q?1OQzLYnle9J1DDKovccfGEeg1HP11YVbLgEAh3dwAieOOXbOASaaaBZ5sV2m?=
 =?us-ascii?Q?GOMG8pKL635bE3+59zrAbPsjyvYcK33dZmozaTdrKNulabrXihNXYCnY0JBu?=
 =?us-ascii?Q?SpLx2OWoCQAyrvK9fGtWxHbFVFsclQ5NNscVOkacbkiRPXUQ/SGkfRhsumiN?=
 =?us-ascii?Q?RLPrPy6hyjyLLCdAcxZJyIhS+KatB2GVhKd5ROxIvkWhWHQUJ9/7IKTLInfo?=
 =?us-ascii?Q?QnHc0OFk4akELu1wJEOF5StWcza4c52UDzpqrmqPWbvby73l+ZUl2eyg83a7?=
 =?us-ascii?Q?W+ouEmpU10cFEjcFopii+KTvpJapu8WJkI2pQc9ZEx9If6ROjlgULDWytKjm?=
 =?us-ascii?Q?/PGfwxltnGJ8iFmriZH5kfG+wDulBN8iMGY10z/7?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB78203D095018F51230B8037B9722APH7PR12MB7820namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8a463b-c15f-4dc8-8ff1-08ddd43c823e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 16:24:10.4475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shpvpyB2IdmJhcE8skYrbBoWo9ToflIyCMNIKusowvicQi10NxoNjsxq4O4//Gv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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

--_000_PH7PR12MB78203D095018F51230B8037B9722APH7PR12MB7820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Asad,

Sorry, after initing the cache interval time, I meant to move the cache tim=
e check logic to swsmu level and not at smu v13.0.12. I believe this was th=
e original ask from Alex.

Other SOCs can customize if required by adjusting the cache interval.

Thanks,
Lijo
________________________________
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, August 5, 2025 9:20:58 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Lazar, L=
ijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Increase cache interval time

Increase cache interval time to 50 ms while fetching system
metrics table for smu_v13_0_12 since polling interval is less frequent for
this data.

v2: Make caching interval soc independent, however customization can be
done in soc specific callbacks(Alex/Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c             | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h         | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 9 ++++-----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index dc48a1dd8be4..c62d68d7410f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1162,8 +1162,12 @@ static void smu_free_dummy_read_table(struct smu_con=
text *smu)

 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
+       struct smu_table_context *smu_table =3D &smu->smu_table;
         int ret;

+       smu_table->tables[SMU_TABLE_TEMP_METRICS].cache_interval =3D
+               AMDGPU_TEMP_METRICS_CACHE_INTERVAL;
+
         /**
          * Create smu_table structure, and init smc tables such as
          * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 611b381b9147..7a52c00c700e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -32,6 +32,8 @@
 #include "smu_types.h"
 #include "linux/firmware.h"

+#define AMDGPU_TEMP_METRICS_CACHE_INTERVAL     50
+
 #define SMU_THERMAL_MINIMUM_ALERT_TEMP          0
 #define SMU_THERMAL_MAXIMUM_ALERT_TEMP          255
 #define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES   1000
@@ -258,6 +260,7 @@ struct smu_table {
         struct amdgpu_bo *bo;
         uint32_t version;
         unsigned long  metrics_time;
+       uint32_t cache_interval;
 };

 enum smu_perf_level_designation {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index fca50f6a8ef6..5ead66375d38 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -361,18 +361,17 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_cont=
ext *smu,
         return 0;
 }

-static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, =
void *metrics_table,
-                                                bool bypass_cache)
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, =
void *metrics_table)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
         uint32_t table_size =3D smu_table->tables[SMU_TABLE_SMU_METRICS].s=
ize;
         struct smu_table *table =3D &smu_table->driver_table;
         int ret;

-       if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metr=
ics_time ||
+       if (!smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
             time_after(jiffies,
                        smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_t=
ime +
-                      msecs_to_jiffies(1))) {
+                      msecs_to_jiffies(smu_table->tables[SMU_TABLE_TEMP_ME=
TRICS].cache_interval))) {
                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetrics=
Table, NULL);
                 if (ret) {
                         dev_info(smu->adev->dev,
@@ -544,7 +543,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu=
_context *smu,
         else if (type  =3D=3D SMU_TEMP_METRIC_BASEBOARD)
                 smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics=
, 1, 0);

-       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics, false);
+       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics);
         if (ret) {
                 kfree(metrics);
                 return ret;
--
2.46.0


--_000_PH7PR12MB78203D095018F51230B8037B9722APH7PR12MB7820namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Hi Asad,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Sorry, after initing the cache interval time, I meant to move the cache tim=
e check logic to swsmu level and not at smu v13.0.12. I believe this was th=
e original ask from Alex.</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
Other SOCs can customize if required by adjusting the cache interval.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, Aptos_=
MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-si=
ze: 12pt;" dir=3D"auto">
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kamal, Asad &lt;Asad.=
Kamal@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 5, 2025 9:20:58 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Ma, Le &lt;Le.Ma@a=
md.com&gt;; Zhang, Morris &lt;Shiwu.Zhang@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH v2] drm/amd/pm: Increase cache interval time</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Increase cache interval time to 50 ms while fetchi=
ng system<br>
metrics table for smu_v13_0_12 since polling interval is less frequent for<=
br>
this data.<br>
<br>
v2: Make caching interval soc independent, however customization can be<br>
done in soc specific callbacks(Alex/Lijo)<br>
<br>
Signed-off-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 ++++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 9 ++++-----<b=
r>
&nbsp;3 files changed, 11 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index dc48a1dd8be4..c62d68d7410f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1162,8 +1162,12 @@ static void smu_free_dummy_read_table(struct smu_con=
text *smu)<br>
&nbsp;<br>
&nbsp;static int smu_smc_table_sw_init(struct smu_context *smu)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =
=3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;tables[SMU_TABLE_TEMP_M=
ETRICS].cache_interval =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMDGPU_TEMP_METRICS_CACHE_INTERVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create smu_table s=
tructure, and init smc tables such as<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TABLE_PPTABLE, TAB=
LE_WATERMARKS, TABLE_SMU_METRICS, and etc.<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index 611b381b9147..7a52c00c700e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -32,6 +32,8 @@<br>
&nbsp;#include &quot;smu_types.h&quot;<br>
&nbsp;#include &quot;linux/firmware.h&quot;<br>
&nbsp;<br>
+#define AMDGPU_TEMP_METRICS_CACHE_INTERVAL&nbsp;&nbsp;&nbsp;&nbsp; 50<br>
+<br>
&nbsp;#define SMU_THERMAL_MINIMUM_ALERT_TEMP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;#define SMU_THERMAL_MAXIMUM_ALERT_TEMP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 255<br>
&nbsp;#define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES&nbsp;&nbsp; 1000<br>
@@ -258,6 +260,7 @@ struct smu_table {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp; metric=
s_time;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cache_interval;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum smu_perf_level_designation {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
index fca50f6a8ef6..5ead66375d38 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
@@ -361,18 +361,17 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, =
void *metrics_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool bypass_cach=
e)<br>
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, =
void *metrics_table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_size =3D sm=
u_table-&gt;tables[SMU_TABLE_SMU_METRICS].size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =
=3D &amp;smu_table-&gt;driver_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bypass_cache || !smu_table-&gt;ta=
bles[SMU_TABLE_TEMP_METRICS].metrics_time ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;tables[SMU_TABLE_T=
EMP_METRICS].metrics_time ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti=
me_after(jiffies,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&=
gt;tables[SMU_TABLE_TEMP_METRICS].metrics_time +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffies(1))) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffies(smu_t=
able-&gt;tables[SMU_TABLE_TEMP_METRICS].cache_interval))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMe=
tricsTable, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo(smu-&gt;adev-&gt;dev,<br>
@@ -544,7 +543,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu=
_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (type&nbsp; =3D=3D=
 SMU_TEMP_METRIC_BASEBOARD)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_cmn_init_baseboard_temp_metrics(baseboard_temp_me=
trics, 1, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_12_get_system_metri=
cs_table(smu, metrics, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_12_get_system_metri=
cs_table(smu, metrics);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(metrics);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.46.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB78203D095018F51230B8037B9722APH7PR12MB7820namp_--
