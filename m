Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8300C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 03:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3632A10E301;
	Fri,  6 Jun 2025 03:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z2zyX+Qb";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F158E10E301
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 03:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ+Dv8z5k03Xi6gk1rREBi+b6Nkh23GjdXBk/TUtwxpQcCkm/cHP9kJ0CKI04mJwXiqCc5SKHtBFpj7uDBAQuV+ujaFlD5rNUsB/sHMr8BjmfO5KSSjqLF/cNi4S0nmU6xlzXX30shF7mFcH5QWuA7KDvU0MZdbIg2SykMbxiRCELSzzyCWYYQACXqryFUyhafz+yqbWlKOJXyh+lxmLVq9wBhWacVWnZfbg/PHb9myqNp3fxoyjP8yuZA2kHoqQ615WfzS/8T4feC74OKCIjHb9f6VctSUMQeS6+cYBkfjcucPH8mQn1FqAJEs+9LrQWDX2bC3IUR6pUnhoFtGalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vvI5677iZCYNCRrCcQqJPHKRfet8EE7MSl89ldjU2g=;
 b=Z1rASsUxLA9qkT1qHyXV8/1h5uOhcCU/rVc+jZkJK8YWPVVyYwutdQ5uGTVgpCBmn70m6gko2w/VgbulIvJRisrZK1uiB+8zrZD4gR2Bkl3Maq7TnJZGbGfjtEFSTcKXlNpHMgSpT0Bf0Xbt+VVQ+wTiAgCP4kHr5FB+4G2Ob4yVQC70iLvTnLteVFCUT4EXnwoA+RWtJpJKM/41Cn2p0EXptDOPdLsG58m33aJc9JB/xr9fjoTKZ/DnE3yfRuNFWz6JLQ4DM8Oo4mdED6ECoqRb8dK0h9S7Ern1aZarbbSlxjDURiMc64YEh+Ayc+BGw9TD9CIx5w5BPkohC690Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vvI5677iZCYNCRrCcQqJPHKRfet8EE7MSl89ldjU2g=;
 b=Z2zyX+QbQtFYF1TZcKgA8o0iR1JIWtA7c8bFLNSdOe5q5KdQB0nbwQK/YV2cl0kOPIl4z22qFyaCmTs1ryJ1g8Qli9suH3qLqOspczTEeFoJtJiWTEomggZCBPhV0PXQp1DxFV+5oIgwNwJByDFGUIx1dZ3g+8S5epo5w1zsPe8=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Fri, 6 Jun
 2025 03:52:55 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 03:52:54 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: Move the process suspend and resume out of
 full access
Thread-Topic: [PATCH v3] drm/amdkfd: Move the process suspend and resume out
 of full access
Thread-Index: AQHb1SUN+3yi4SUyqUS/BxBpvAifgLP0KinwgAFYZpA=
Date: Fri, 6 Jun 2025 03:52:54 +0000
Message-ID: <PH0PR12MB5417ABF12F9BB3D8836630608F6EA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250604074817.1444723-1-Emily.Deng@amd.com>
 <PH0PR12MB54178D04495A0F5D96B1DBA58F6FA@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54178D04495A0F5D96B1DBA58F6FA@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e283b701-15c8-4ef0-8677-b660297b1e9f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-05T07:19:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|LV3PR12MB9410:EE_
x-ms-office365-filtering-correlation-id: 6513a2ab-baca-4361-ffe5-08dda4ad9e0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0iOALqiwqgtTqfk+MnDLYrgfvg1gQS51q/CtPXAkCSKjc6vciPwgm2/nKY4J?=
 =?us-ascii?Q?5IbOMlCdn0PUMCeFSSw33107f+kYtX1oOdbi/pFvyouTr8O8nd3N7bHx9qIa?=
 =?us-ascii?Q?N1aPO56+aQVJlIxof50sJJrDv77ER60Aa6VsP8w0lGneYvwa32D6Pq1gWhFO?=
 =?us-ascii?Q?q2yDtsfbvDcWAsOMneWcV2Ur00RqTffBq2v/CM3fc0nhgeadiZrh+EGtXp/j?=
 =?us-ascii?Q?RWQ7gT5ShPmx9T6MAGMVJvVGcfnARkL0Uq5kJq8suKJfTTfgjI8IStzLki5p?=
 =?us-ascii?Q?fuJ/wE75oak9XXp1Y9fttSvAJCmYw0MaOCAGrws6r4Kx5QoL75ZOqGb0hdFA?=
 =?us-ascii?Q?UmIvRsg1IKxxWUGnIklvQ13YmNL+fkyUbW+4pb6qME4rV3WHBXcBbeAeFHxe?=
 =?us-ascii?Q?C0ojaQU5N2hxG0u83doqicQm157RyodLy01RBS7jRq+uYBx4gayYRmrHB9YT?=
 =?us-ascii?Q?Hvd35S1aoh4JH50oLDb0dNzVWck4OdtHL9PgOp4Dmdny4f3PPTXDdHQc0TDk?=
 =?us-ascii?Q?XXEHlbLPj4QIZU+1XyqoHsJ1+aOkMKiUlMVSjgjmv6Jnfz/98VVwR/CNJyId?=
 =?us-ascii?Q?0PwHIp7Uzo8ypgOTJ2+jKRgFbyo5z93swulDRePh3OnUriV5TRjtZCAGAc22?=
 =?us-ascii?Q?0QfTbNsvPy82bddeBS1PORz8Tl2tR1xgNM6wXQWInzayguS/4S8yLyDMLs21?=
 =?us-ascii?Q?YYAZ9hiJKKrKX8i8dn+b3+FhCK7icy5VlIxBFhYc82VksqVq5EZOkajjf2WE?=
 =?us-ascii?Q?+KDBuTwCWBSF6SpadJodMbLkKXpXY+piAtq2Ygd7JunXJjo3bv5e0NVTSltY?=
 =?us-ascii?Q?yyG/uGNjL5anptP78ZMJQSkGfgd5SVACR6I2JEWTSKgAERI6YY0QpwVg0wFB?=
 =?us-ascii?Q?EeIGXnCboubDkDcNhOXMcXHPH5VEy88KSxj/VQqaIFKHTbv9cfvSwBi0T5VY?=
 =?us-ascii?Q?ofhOHa0YfYvfbtlIgDUjsWW51aA2eyD0j/4PM1FkwzF7p5bMTRiH/Y2T5VWw?=
 =?us-ascii?Q?lnk0qSoewItEz62OZABKXcl4S8iay3B3YIxQ8rSKJxv5++8biaIBEm0WoiFE?=
 =?us-ascii?Q?yWD1wI5eT/swMTwp5tg6hccm5hih0GwfWBvTI1INPqfKJJxxXfjH4L4LYD4L?=
 =?us-ascii?Q?s/nSUCZaYsR6VLHCRgsWQPODCIigUWFVdFw62/m/3xpV7KjTL/vcVJQ8jP4o?=
 =?us-ascii?Q?ZVAeRLy5Y6gaaFYrxwglvRnP2CE4HHP259dpltAWO+eUKMBuiQqk+eHHmBvp?=
 =?us-ascii?Q?JVwYKdNr1H0m9+1JmtH5QnZllXZQFGDD0CN9k784VcOKQWa7oZPKBeso3z2q?=
 =?us-ascii?Q?vTa1hfBOwyFrAczPRVE9t4CyoX2LKhETfVJTu0d8stKxvkkjSLaL2sXRPir+?=
 =?us-ascii?Q?NUvYUZNfSoMKsMGR3R2DUaEgMfxF2BIRs8JjZWF9Cv0A8TyHbw3TdhV7metx?=
 =?us-ascii?Q?ACYb5DIp+qCwauhOROwLFXrH9pbAW0dMLL+boSNVOGEz0r69Q2m/H5xlvNwF?=
 =?us-ascii?Q?VAiFOvmHb1BxZ4A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CUnC7yj8D5kLbbFjqPF9lGBlcQqy086C2tmE7Ehmr3fDvDjznQhVTygdOsSI?=
 =?us-ascii?Q?AY/T3kgeTWQAhs8597VdDTxe8PPLr7KyLLn1hgB2uqV6pu2VuID0C9xk/g+Z?=
 =?us-ascii?Q?rFKqP1lfxeluGMIWsBp37MbaYpCxTmuYw/xDnf10JGDVUCpzCDh7nito663C?=
 =?us-ascii?Q?UYQlGuIeo+uYUlqzzMvdMLSohYWdD/TuWHo6XLf5iILBjPW8KPc0T4Pwm4ai?=
 =?us-ascii?Q?YUXsFRSE4VucKr3fiPsPlK5W4ia9+yWJ8OaVLwKINpXWLCXUEq8lDZvvaBPN?=
 =?us-ascii?Q?CrRKKWS67JoFLg8F/kE1/1u1+902htwZjwQz1ItxGVvVK7tlOxKsKjT/i7e+?=
 =?us-ascii?Q?XCLKGuFL8BOgVduvLKec+Xldo4UQVuSVMa+OfbcxVuoLGJtqJuy/uwQmQ/Dy?=
 =?us-ascii?Q?lNkUljnUBxPMamka2+rI3t0+KR5dvzitkx5XuW7QJfz5DKW/YSunrx0X20GP?=
 =?us-ascii?Q?ccCmv/B2dIfFQR3i0t7sdJEVSSHSFqZTogEOt3ASJw7Jvb5QR7lWcoCXbnTI?=
 =?us-ascii?Q?lDnugoLGvyGbs3CqgQ9XK8sLTKDoHLqNbeX8bes1I8KeGHaFXrzXxGM+aFQT?=
 =?us-ascii?Q?fpXFjU9oWodeqvqxkrMcUiggminiEyYG7h38+EVjiTIxEtuTgge2bKJ4fwDA?=
 =?us-ascii?Q?YPY7FoMu8oseGylznV8AJx7Ld9Iu64LgL7mi1tOdZgW6SjBr1wDjTAajT+al?=
 =?us-ascii?Q?fjm3rlJObiceSrIxh/ERqnBixEQ+qjeceIRxRVi1XkUhmukUUVvIHO5apHJk?=
 =?us-ascii?Q?3gvPs+e2Q106bVECPUjD7VlgWYyo31ZSscTkiGZQTHaneVrgFH2bNIqRx+IT?=
 =?us-ascii?Q?plfbUl8AgNF/IYOJyda80Z6nek1Olx3CG7NEwp75Zq8Tu6P8P6wqtZZClzbq?=
 =?us-ascii?Q?ZCK7cWKXEJE3BuNmH94tSDA/m9RFZZDOwygUIgudhrJxeNDTwYNr4OvrChcT?=
 =?us-ascii?Q?aeis9FRDMuCGFWW3Kxex8QFF3CAA1nAg3dSlO5oUEZ2VsYq6ml2p8s3wIaqb?=
 =?us-ascii?Q?OvjUXOtbjUu25ohEXALMOdbC/3Njp4jzoNEItTRf7idEK+MFQ76wMU2i4Ipq?=
 =?us-ascii?Q?u1bog/PhmKsaTk5LjO62q6Pkt80jayxmJ+GSzOjcNjP+r2UM8V+OrMUhvLIG?=
 =?us-ascii?Q?yJJk2fHzoKVzen6H2cWxuCq+v7cnFh7YR4ADVLKcMR2MzSaQmSMjyVbMPtTR?=
 =?us-ascii?Q?pKOLQyKoLr1cX6D0spV63HQcWtea5WxV54TFPh679nPMXdMHJyrAwqpZEelI?=
 =?us-ascii?Q?ZX16/Pw9SlLew2iLL91TLoRFF+WVyguiZmjMUXfu2hVMVhPi2bkQLXb7/Rmm?=
 =?us-ascii?Q?bJ+jPIGIuF5E79tso0EVOXGbxk+urYHS4v98K9uTb3ILmeATV2GbfJwARwMy?=
 =?us-ascii?Q?YltQgEiJwC/d2UaaMHp3BOPq9cCE7whw1nSNIwSWcuMkYFNFE0bMftpAfATo?=
 =?us-ascii?Q?4ZiXZ/4QJOmgWysbA7n/xj8i2HCJISml6TVkZR51W91V/NkX2823OS7eFPRf?=
 =?us-ascii?Q?tZ+YT3hfZBiKm/YAw8jrEa1VmGuHvpxrcAqUhcKquPXF1NLJTLchU7e4C213?=
 =?us-ascii?Q?UDyxXTd/L5xtUuaK7ws=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6513a2ab-baca-4361-ffe5-08dda4ad9e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 03:52:54.4270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOc0V169awUMNfr5Q6t8tI5gVobtWVvsKXA0S/7u2j2uKgd/aVq7XxvSDADKCvJ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410
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

Hi Lijo,
    Could you help to review the patch again? Thanks.

Emily Deng
Best Wishes



>-----Original Message-----
>From: Deng, Emily
>Sent: Thursday, June 5, 2025 3:21 PM
>To: Chen, Horace <Horace.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
>Cc: Emily Deng <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
>Owen(SRDC) <Owen.Zhang2@amd.com>
>Subject: RE: [PATCH v3] drm/amdkfd: Move the process suspend and resume ou=
t of
>full access
>
>@Lazar, Lijo and @Chen, Horace
> Could you help to review again, thanks?
>
>Emily Deng
>Best Wishes
>
>
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Wednesday, June 4, 2025 3:48 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH v3] drm/amdkfd: Move the process suspend and resume out
>>of full access
>>
>>For the suspend and resume process, exclusive access is not required.
>>Therefore, it can be moved out of the full access section to reduce the
>>duration of exclusive access.
>>
>>v3:
>>Move suspend processes before hardware fini.
>>Remove twice call for bare metal.
>>
>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>>drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>>drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +++--
>> drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
>> 4 files changed, 67 insertions(+), 11 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>index d8ac4b1051a8..0a8e7835d0fc 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>@@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device
>>*adev, bool run_pm)
>>      return r;
>> }
>>
>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>+run_pm) {
>>+     if (adev->kfd.dev)
>>+             kgd2kfd_suspend_process(adev->kfd.dev, run_pm); }
>>+
>>+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool
>>+run_pm) {
>>+     int r =3D 0;
>>+
>>+     if (adev->kfd.dev)
>>+             r =3D kgd2kfd_resume_process(adev->kfd.dev, run_pm);
>>+
>>+     return r;
>>+}
>>+
>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>>                          struct amdgpu_reset_context *reset_context)  { =
diff --git
>>a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>index b6ca41859b53..841ae8b75ab1 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>@@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>>
>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>+run_pm); int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev,
>>+bool run_pm);
>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>                      const void *ih_ring_entry);
>> void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -413,6
>>+415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void
>>kgd2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct
>>kfd_dev *kfd, bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd,
>>bool run_pm);
>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm); int
>>+kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
>> int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>                    struct amdgpu_reset_context *reset_context);  int
>>kgd2kfd_post_reset(struct kfd_dev *kfd); @@ -463,6 +467,15 @@ static
>>inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>      return 0;
>> }
>>
>>+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool
>>+run_pm) { }
>>+
>>+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool
>>+run_pm) {
>>+     return 0;
>>+}
>>+
>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>                                  struct amdgpu_reset_context *reset_cont=
ext)  { diff --
>git
>>a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>index 5289400879ec..08ff9917c62f 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>@@ -5061,6 +5061,8 @@ int amdgpu_device_suspend(struct drm_device *dev,
>>bool
>>notify_clients)
>>      adev->in_suspend =3D true;
>>
>>      if (amdgpu_sriov_vf(adev)) {
>>+             if (!adev->in_s0ix)
>>+                     amdgpu_amdkfd_suspend_process(adev, adev->in_runpm)=
;
>>              amdgpu_virt_fini_data_exchange(adev);
>>              r =3D amdgpu_virt_request_full_gpu(adev, false);
>>              if (r)
>>@@ -5080,7 +5082,7 @@ int amdgpu_device_suspend(struct drm_device *dev,
>>bool
>>notify_clients)
>>      amdgpu_device_ip_suspend_phase1(adev);
>>
>>      if (!adev->in_s0ix) {
>>-             amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>+             amdgpu_amdkfd_suspend(adev, amdgpu_sriov_vf(adev) || adev-
>>>in_runpm);
>>              amdgpu_userq_suspend(adev);
>>      }
>>
>>@@ -5178,7 +5180,7 @@ int amdgpu_device_resume(struct drm_device *dev,
>>bool
>>notify_clients)
>>      }
>>
>>      if (!adev->in_s0ix) {
>>-             r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
>>+             r =3D amdgpu_amdkfd_resume(adev, amdgpu_sriov_vf(adev) ||
>>+adev->in_runpm);
>>              if (r)
>>                      goto exit;
>>
>>@@ -5197,6 +5199,9 @@ int amdgpu_device_resume(struct drm_device *dev,
>>bool
>>notify_clients)
>>      if (amdgpu_sriov_vf(adev)) {
>>              amdgpu_virt_init_data_exchange(adev);
>>              amdgpu_virt_release_full_gpu(adev, true);
>>+
>>+             if (!adev->in_s0ix && !r)
>>+                     r =3D amdgpu_amdkfd_resume_process(adev, adev->in_r=
unpm);
>>      }
>>
>>      if (r)
>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>index bf0854bd5555..22c6ef7c42b6 100644
>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>@@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool
>run_pm)
>>      if (!kfd->init_complete)
>>              return;
>>
>>-     /* for runtime suspend, skip locking kfd */
>>-     if (!run_pm) {
>>-             mutex_lock(&kfd_processes_mutex);
>>-             /* For first KFD device suspend all the KFD processes */
>>-             if (++kfd_locked =3D=3D 1)
>>-                     kfd_suspend_all_processes();
>>-             mutex_unlock(&kfd_processes_mutex);
>>-     }
>>-
>>+     kgd2kfd_suspend_process(kfd, run_pm);
>>      for (i =3D 0; i < kfd->num_nodes; i++) {
>>              node =3D kfd->nodes[i];
>>              node->dqm->ops.stop(node->dqm);
>>@@ -1055,6 +1047,36 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_p=
m)
>>                      return ret;
>>      }
>>
>>+     ret =3D kgd2kfd_resume_process(kfd, run_pm);
>>+
>>+     return ret;
>>+}
>>+
>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm) {
>>+     struct kfd_node *node;
>>+     int i;
>>+
>>+     if (!kfd->init_complete)
>>+             return;
>>+
>>+     /* for runtime suspend, skip locking kfd */
>>+     if (!run_pm) {
>>+             mutex_lock(&kfd_processes_mutex);
>>+             /* For first KFD device suspend all the KFD processes */
>>+             if (++kfd_locked =3D=3D 1)
>>+                     kfd_suspend_all_processes();
>>+             mutex_unlock(&kfd_processes_mutex);
>>+     }
>>+}
>>+
>>+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm) {
>>+     int ret, i;
>>+
>>+     if (!kfd->init_complete)
>>+             return 0;
>>+
>>      /* for runtime resume, skip unlocking kfd */
>>      if (!run_pm) {
>>              mutex_lock(&kfd_processes_mutex);
>>--
>>2.34.1

