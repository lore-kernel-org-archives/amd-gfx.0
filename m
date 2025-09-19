Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF65DCAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 07:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC0910E227;
	Fri, 19 Sep 2025 07:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y3D+hjrV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4CD10E227
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 07:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wF4NXEi73871Ns+peuLNDTyfw1JnjJhPEdXMXdC2xSQYrEKDOU00KIoPMoKlRsqIT4g05AMA1XOLdAdOP/wuRTURfAjcfTcQTCBzvn2r4wxsoRkChulPFYKOaU5t1yTb/Sbjk/CZ0e/1aFOpZEaIRyBU1KE4ph8c+JOg/tQV1R6xnPyFIxvvgQVPBLSFYV074W+erZkOT+jf9bg+JUCDpZJ+p/Wk/wXYmYi+1BV8IXUrTFGusj5+kxafYl1KFpEnA1lN8ngJfmmDdRbmT268RrwwWgvIT2UBEOKi5VatJBYzG6v6dLebNhxFjREO62a2KOR4UwtY9Bf26PsvBfAztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFc0+7VvHBlMKwqFdS04+FU/EClCMzEAy+pMOKrNkpA=;
 b=fYrbQUETiUibUcsXtgJXc2qCXnrN1iE3MYZQCrisoeq0k7sXEAvaDOR+y2LSnukJNHZj3piPqcvZP1pO1TwQrsLZ2HO8tXKUg85dJQ+Dp3krin8tmApjKbQ0kWRYbDOU38ayLWxbAvdJUMD09IBmZJW9Zr1aYpvMPNzpxlklOAuRBo4T1ICoakkhOhRVybd+lF4v+wRM3wPgyt7MrMFpXD5eW3qwud6UZBY/26/UeK62CKFcOhC+p8QTC7+bIwkTJzIMGRFq63u/8sHFynarFqT2kTvV8OGKNJgwFIFEwOWoCJr82FObebJMBEiG1ouFoWvdwM/SWGYi0NsDHBua4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFc0+7VvHBlMKwqFdS04+FU/EClCMzEAy+pMOKrNkpA=;
 b=y3D+hjrV2+rn60N6Uor2pIr4LsHPU+0FWbtYWfCLOY/pc+qOMFAu+hMwoX4Axs5dUPpRzTl3zKnmef6zQmKgpj/q/vff+jep9U8cjDfBDocqKNXLiR4DFXffs/YpvL4FUl2Cjeqq9DdE9fA7/L0j1Eds41uT4zC8YH/liiw1+M0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:31:12 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:31:12 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Topic: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Index: AQHcKSiM2Aaf1af7uUKBvjQ6W54v4rSaBlSAgAAGOoCAAAB7sIAABRYAgAAEFYCAAASLgA==
Date: Fri, 19 Sep 2025 07:31:12 +0000
Message-ID: <PH7PR12MB5997EBFCB6E732B9A5B164338211A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250919054439.3115476-1-lijo.lazar@amd.com>
 <PH7PR12MB5997B2F4AF83B9FDEAA5D0AA8211A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB780437C8C982905466CFD9179711A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB59977CF6BC44D81AA52974948211A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB78042A130EEFE0D5FB33AD199711A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS7PR12MB6071E44F8B9DE838DEAD5BB68E11A@DS7PR12MB6071.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6071E44F8B9DE838DEAD5BB68E11A@DS7PR12MB6071.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-19T06:30:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB8243:EE_
x-ms-office365-filtering-correlation-id: 64074171-cb32-432e-fee4-08ddf74e8255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CMB/d3ESUlcB+sYbbfMzqef6L8ogjj4q8lYDvh4LiCfRGEQYMwlNkN4CJZ/a?=
 =?us-ascii?Q?Wabyb0+qCb9MP8EYTnTR3GJ8R3ElWxr768+huvTUUKoenkYA23adm8TNHPUL?=
 =?us-ascii?Q?oGtsupTyg4JLkbtU/BwHxEqDzDyKv9zAJ5EoDgj7/WnV+SBs6SyHG4wLumb/?=
 =?us-ascii?Q?xhzycfQfRaQKFQwKHXph1zybsVuYt52/0vxHWolNs32xWnG1op33VO2v806x?=
 =?us-ascii?Q?TX9TuHEMjGMeH2FnodGtM6eVFNT6DY3yj6roFzWlm9QB6YWpebaUvo+XT3JC?=
 =?us-ascii?Q?HC+xEEbfINzFhNv5badIMD2KpQ75L08j0JAcanwRuvQZuTYH0jktzgCu47W0?=
 =?us-ascii?Q?0OXn7CPAN0kd1ZnyL7hJSStma0VqWQzt3p0KrOobEMPyo3dncXTn79WwSvVb?=
 =?us-ascii?Q?PgPG7+zV/+VqwTh1fSqnwrDh0MDA7jDiqdCLlDROTmvUgI6QHvsuN4UdCKpd?=
 =?us-ascii?Q?O9RsphKPjzs3+GwMjcrazuS9aD3smNo4fIyXkfTAXQyF9Ed1yPaF04BmEJ8o?=
 =?us-ascii?Q?/LQAh8OvAyp7JDCMc8u1xmBy3myciCMEMXUzf9QU+BD+VN/AXqzy6kNZQ54w?=
 =?us-ascii?Q?fDYY8Bjsedj7QQeeRNWRLiIcHgPc8wcm537Q5mSzDQGd45DkWTca/tAbiqK9?=
 =?us-ascii?Q?NFs0wFYr/s6ELhCsXgGVzG9ZLO1j06R1CTGdsqVma0Ys0Tddk/P4MQXVD5gS?=
 =?us-ascii?Q?r5fWk9JVYboEyI7cA7ZyUduPMJKqoBR9hM0DgbN0icq57CbT4+F3AbDEbsHt?=
 =?us-ascii?Q?JaOzfwf05BQU1fcfSCD4J1ibVvLswaIbjS+KJ9H1lCk+ubHXW3MstrL7CWDY?=
 =?us-ascii?Q?m83oCXG5Kc13UmRyxHpnpb2b86ykm8f8GDMipKDaZlba1gBzS2IgBxqRLL15?=
 =?us-ascii?Q?CmQVRENF7hOB7nVJ55Sg7MhXi7kBSWz3+c7fvqnyfqtaw7p6023USZHqNrmT?=
 =?us-ascii?Q?XLEG4GjcZn4HuSpIwa56EYOrvMHiCdOlSlEltvNMCabn6cZUJzB7VlPCtWe2?=
 =?us-ascii?Q?Ax9FLFk/Hfx+6ElQ91VufZupfG7D5Wg8JDG7rZij4X3IXfywhKiFB5PqZden?=
 =?us-ascii?Q?8dwNDJphlFPN4nd3vySuMpeGdB9PrOJzRCgA9T0g9vVy63d6b5PrSYoX8Of3?=
 =?us-ascii?Q?uXFkNv5TPlqQJU4AmYJ5FgjlQ30HlJmIe8nxMf/WFy3edBAvNVfBAHzWZcyZ?=
 =?us-ascii?Q?zPZ1cYeNxVSfOE0XHZrSb67sxOSrPHofU2bOREid+Nc1SDWGsS2oGKxdRWYo?=
 =?us-ascii?Q?J1F0etwbrzE19f4jGOug6SnrtfVAnkw9aRKoMAWfDsPur9qnjpE17+OBZWJS?=
 =?us-ascii?Q?oq6z6wyYx1CiI42tgc+PPv44vWazlj/gY2nAg/wtrlZb0cZMOVm9IbGObWBO?=
 =?us-ascii?Q?Og6QJW+aHyoxcrFYiJWCmDkGCL6nWUhL/MaROETmkmpKt3ZG8K59RxK269a8?=
 =?us-ascii?Q?GUMOhjkuRi8k5CTvbHhlNYlQvz7Ns7AQlynhj1c/GrdKElchTw4q2w+UrE0s?=
 =?us-ascii?Q?UQayAQ8IK8ipzYs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XDxtn0o4sVasxJ0DdETI2ZHN1x+Tm3DBUYqR4dqpwrMFeqLpRuu/XrUsPII3?=
 =?us-ascii?Q?BOnWpzprQqYtkJTE+KF2d+Mbt8jvSvmStWE77NCoeM/Dfa7V/gJhWtD8yVgn?=
 =?us-ascii?Q?qKekn45t051N3/5Z30Ov9hkvfupW7gfcjWMa49y1qhp7ISLtpBg8Dq3ao6Ox?=
 =?us-ascii?Q?TpEWyunbtqRxrYNZgWqbxpHPBLqeb4NRWQpRkDJGRhkiPCxjZYwkOeJEglZS?=
 =?us-ascii?Q?QXKM5KnJGVVLo5lE9/1Qfa3qBKcccwC6+/54rmz3sNEAkjzKy/PIXjAQPM1L?=
 =?us-ascii?Q?KCxyDDN/Zt5z+cE/IoAWCLBh/6VkyKOGMVoPaFB4fmbzEvjqV6D/tlrWJOjA?=
 =?us-ascii?Q?+OHSRVwLUuZttgh8J6m7CDP2KY0V34gGKdUpfmrA7jyLleCkIXQIpwkdGZay?=
 =?us-ascii?Q?hkcqg6lAmjJX0WdL5+E3DMuWoAHk7xMoZxNy61plRdyxJO9uynzg8w6Wvflp?=
 =?us-ascii?Q?C3VKFTl3eAjEfRN0HIjKBIhi0J7hT3hcYCtKeSI7TP6VtXQ3nOkwJhYGFQ0g?=
 =?us-ascii?Q?ryKUp6PwQyDDgBus+APetB01IiGhmRb6bg0OgbpsRdAHXK1K9VNHRs1ZcpS5?=
 =?us-ascii?Q?xN0FDOQRilQ0IDo9Ro4Eq4V9nHVQ3WHxMsj8eMqjVTUwW1LTj3CS/XWnMBOZ?=
 =?us-ascii?Q?6KG/vWCXuYN4G0weYhfN44mDtAt0Hgq8OACcE5eCybH7whRZVb+MFgPdv2Kh?=
 =?us-ascii?Q?hm2bq1ZKSV3GmTRSZn5GpO/yr6Bh8SXUsx+ZO2q9K7jPvjBkYzH26959q9MA?=
 =?us-ascii?Q?vHl0QdfF330GYP/5+Noa7KqVKCnc7zvVyNC9mLONuV8ZieCRqhSRdVgBjYmK?=
 =?us-ascii?Q?11qI3E+r74CQ1TpgGgymhAfOAr+cihLnvq6durQXiqPTWHQG5F8BYTpN3Wcv?=
 =?us-ascii?Q?cyOpnOTvW+nA1ObqLqk1AMbxq7Cn79cIIxE7z2vSy6DRoYqOMEd0/0NBaw7K?=
 =?us-ascii?Q?3Ex25uZ/R2iyaT0qhq0STa26CkZ8l3TD+kYtP90eSpGnoUcRuKcshpYHRxq5?=
 =?us-ascii?Q?zUnGmZfTUwxQc50Sza+SfTHUpFgOl1miRaVFXpvV1LU707g4FgkREbhG/+oA?=
 =?us-ascii?Q?uHh2eEJ/EkrDdaBWEoP+U8aZH1BZMt9Hhuc67jgMkFECoTm+rceOPDCycJ04?=
 =?us-ascii?Q?wrOcwbx7h+bsO62DG6eRdim9Uvr2SU9t9fnBo2xRIsg8Za9fvnIwX81I0dD9?=
 =?us-ascii?Q?q4iZ80iKakE4uZ2+kZtuoVY5VjUOY1tebJPfraPzqVgBX/pCH9fPvICM/TZB?=
 =?us-ascii?Q?+BgieNKaTr9vhCow+Dy1RlurLvXOfihf0AqD8QccYqoL9D65iicPkFIGqQ1H?=
 =?us-ascii?Q?LRCMG1o/k4PBfPWGSLjBqdPmGRd+VhV7vYXHxzzytvnNV94R9hWp6y5bri68?=
 =?us-ascii?Q?Ha7KepI6Kc6MqsouIVaumq/u5fL4wOL5U4grsp+dQtHC1t13wquEMMtnKJQw?=
 =?us-ascii?Q?AzL8h4EfantbdBp7zq0h+D7JS5hi/qybdHinWGe2ITogpMKgAMAHN2pyWrT9?=
 =?us-ascii?Q?VGzhaGU499cl7TferOYv45aQcegXU8Khu/trUPZJ9mDG7CsVnuzhBDNrUWyg?=
 =?us-ascii?Q?zk7GcS1sITgxh8GnVkI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64074171-cb32-432e-fee4-08ddf74e8255
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 07:31:12.2315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPetLpXR3lM15mijXX+tp58C4jYohiMDL21TMVLb93s2xT2HOPdFShkByOBtF7wA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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

>> The message is really confusing during debug, and I remember getting stu=
ck with pmfw team , to explain them its not error just a message. As Lijo p=
ointed out we have not updated interface version for 13.0.6 and 13.0.12 fro=
m long time because we are not using it. I only use this message to check p=
mfw version which is anyways available in sysfs interface.

This information was originally intended for developer use and problem iden=
tification; this change was made specifically for 13.0.6/13.0.12 but did no=
t provide any benefit.

Best Regards,
Kevin

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, September 19, 2025 3:09 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

The message is really confusing during debug, and I remember getting stuck =
with pmfw team , to explain them its not error just a message. As Lijo poin=
ted out we have not updated interface version for 13.0.6 and 13.0.12 from l=
ong time because we are not using it. I only use this message to check pmfw=
 version which is anyways available in sysfs interface.

So, from my side

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad



-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 12:24 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

First, it's not the developer who is using the system. Any mismatch informa=
tion in a dmesg log is always an alarm to the user who is not aware of the =
implementation details.

This mismatch is bound to happen when PMFW is not loaded along with the dri=
ver.  In such cases, the mechanism to ensure compatibility is only PMFW ver=
sion checks and hence some IP implementations follow the same. If there is =
an issue, the identification mechanism is the stack information which is th=
e driver version along with the all the firmware versions. The interface ve=
rsion is not the first thing that is checked; in fact, I don't remember che=
cking that at all. That is why this code is keeping the same interface vers=
ion for SMU v13.0.12 and SMU v13.0.6 and not getting noticed so far. So ins=
tead of sticking with it,  it is rather good to clean up such messages or d=
owngrade to debug (which is again useless because as mentioned earlier it's=
 not looked at all).

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 19, 2025 12:14 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

>> " is not used": Actually, this is used to display information to users a=
nd developers, not the driver itself.

This "driver_if_version" is used to show what driver if source file version=
 is using on current driver, this information is used to *developers* and *=
user* from dmesg.log, not driver *itself*.

>> This interface version is not used anywhere. Driver ensures backward com=
patibility by PMFW version checks and shows the exact PMFW version in dmesg=
 log. PMFW version is a more authentic way to identify any compatibility. S=
o having a mismatch statement in the log is only leading to confusion.

Pmfw/driver_if_version is the remote(pmfw) version, while driver_if_version=
 is the local (kmd) version, Because the driver allows for their existence =
without matching, more information is needed.

They should not be confused as they do not display the same type of informa=
tion.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 2:34 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

> Hiding this information seems unreasonable unless there is another
> strong reason

This interface version is not used anywhere. Driver ensures backward compat=
ibility by PMFW version checks and shows the exact PMFW version in dmesg lo=
g. PMFW version is a more authentic way to identify any compatibility. So h=
aving a mismatch statement in the log is only leading to confusion.

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 19, 2025 11:59 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[AMD Official Use Only - AMD Internal Distribution Only]

>> PMFW interface version is not used by some IP implementations like SMU v=
13.0.6/12, instead rely on PMFW version checks. Avoid the log if interface =
version is not used.

" is not used": Actually, this is used to display information to users and =
developers, not the driver itself.

Smu 'driver_if_version': it is used to show driver source file interface ve=
rsion on kernel driver side.
Smu 'If_version': it is returned from pmfw side, that means what driver if =
version is using on pmfw side.

The most perfect aesthetic situation is using same if version between drive=
r and pmfw side, but it can still work normally even if it is not matched. =
(with limited functionality)

According to the SMU driver design, KMD will not reject interface version m=
ismatches to ensure smooth driver loading.
Preserving this information helps the driver understand the KMD/PMFW operat=
ing environment and detect problems early.
Hiding this information seems unreasonable unless there is another strong r=
eason.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 1:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

PMFW interface version is not used by some IP implementations like SMU v13.=
0.6/12, instead rely on PMFW version checks. Avoid the log if interface ver=
sion is not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h               | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1a1f2a6b2e52..a89075e25717 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -288,7 +288,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         * Considering above, we just leave user a verbal message instead
         * of halt driver loading.
         */
-       if (if_version !=3D smu->smc_driver_if_version) {
+       if (smu->smc_driver_if_version !=3D SMU_IGNORE_IF_VERSION &&
+           if_version !=3D smu->smc_driver_if_version) {
                dev_info(adev->dev, "smu driver if version =3D 0x%08x, smu =
fw if version =3D 0x%08x, "
                         "smu fw program =3D %d, smu fw version =3D 0x%08x =
(%d.%d.%d)\n",
                         smu->smc_driver_if_version, if_version, diff --git=
 a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 349b6b8be010..062f92635215 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3930,7 +3930,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *sm=
u)
        smu->feature_map =3D (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=
=3D IP_VERSION(13, 0, 12)) ?
                smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_ma=
p;
        smu->table_map =3D smu_v13_0_6_table_map;
-       smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
+       smu->smc_driver_if_version =3D SMU_IGNORE_IF_VERSION;
        smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
        smu_v13_0_set_smu_mailbox_registers(smu);
        smu_v13_0_6_set_temp_funcs(smu); diff --git a/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d588f74b98de..0ae91c8b6d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,8 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9

+#define SMU_IGNORE_IF_VERSION 0xFFFFFFFF
+
 #define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)                   \
        do {                                                             \
                typecheck(struct gpu_metrics_v##frev##_##crev *, (ptr)); \
--
2.49.0






