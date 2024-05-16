Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E87C25B79
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 07:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A9D10E1DF;
	Thu, 16 May 2024 07:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yHHzHEVK";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D574A10E1DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 07:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKx7rdnucvP1vqb0nwo3+hmBo3ouaqjGHGdD6Scva8nWX7VLlGnzsg2HmJn59QeAQsihOY2+nN8i1gRLW7CDsbcI+l/h9gSjLA82EJTFb3aAfjE2LoDa2O4m4Rdjp8LLGrLa0OnXRQ7O1zgpCXk6iObV97782/dez5wXmuoY+D7C2jOqfm95fdsnOdw/3Adc5Y0cWnWHsKSiIy8p4GLc0ax5auYveiscrsYrAEqNRBijZXUd9NjJx/V4HyoMgXjrYwfDJTtR4iopYcYIZEEwb+ChRk2TYnBNiKXnn2567ZMj6Ec8+tFogp1XmOdnW0UGc3Mk3VT9VcKXrvfG23GTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOrkiLBQSYEUtbCSCYo1jO/cz7CTsk/TvrCMMwkAuRg=;
 b=ga5aqla+gqAwa/C/iQ7xnMMSZupas7u2UuwfgNtMDdt3wu9UGVcbA5SOC+wJ0UGMYXpmJ1zinXhr+zDfqKcReE4vjWd3BdeuAo6BIsIQQXTTsoywdA9ZTZJcwMc9XIqFXSmWo50+kYJZ6Bw9uLmvZeBnfEmPP6/DFAR1bQZ8tcZWOhK74zNbDdmznl4VWfBr4kDhvH2eBKBLvy/FAaNgKS5Qbal23JzCaRfKwmlKSqiLqnMz5iY0J3IWhD0NQXwxQJp6Le29t12Z7vJlNdrtP2FTJvZxwEfbvYKnDi4bOUTLOtc9FFk/cmkpNbOG6r0dER8l//9Tpa1lxyZqzDFtuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOrkiLBQSYEUtbCSCYo1jO/cz7CTsk/TvrCMMwkAuRg=;
 b=yHHzHEVKEQJOnaXotuiBhXCjHqRfYSME0PtcDpONX+ymFjbDL3UHQfKjRXfQw0eXe1RUqM9aynrTdYIIt9slq6FaLmu++rkTHXXtsFad7MLdjLmzoQyYqMOYfw+Et0ax4zALwZQzPiM7woETgWdv7CGwr5zS5d5nLUr3Pv7UDN4=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 07:20:06 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 07:20:06 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: enable thermal alert on smu 14.0.2/3
Thread-Topic: [PATCH 2/2] drm/amd/pm: enable thermal alert on smu 14.0.2/3
Thread-Index: AQHapy4HlQgHQ4OsXU+cEUhNj/Swt7GZdGhw
Date: Thu, 16 May 2024 07:20:06 +0000
Message-ID: <DM4PR12MB5181D3EF11511EBBEB5AB588EFED2@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240516011123.2112909-1-kenneth.feng@amd.com>
 <20240516011123.2112909-2-kenneth.feng@amd.com>
In-Reply-To: <20240516011123.2112909-2-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c1904a92-0ff9-4457-a87e-860b34feadd4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-16T07:19:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|DS0PR12MB8070:EE_
x-ms-office365-filtering-correlation-id: fd6315ea-5289-4749-4b9d-08dc75789c84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?LVvB2o+fnxEAy+Ek7JmevW/+Vlt5sxWBdecNaHZ7tn5hZ11v6pp4JxFn+PTZ?=
 =?us-ascii?Q?nwFtlL/cSb47YfgZvvIRKuwddkKxcFPb/qSPITXLD8XqxUAkZ+IU40p+pawd?=
 =?us-ascii?Q?sTpW+TNcZhF4iGKoiGfBuvJbBmln5QxEaX5lSmpgWcV1BkR2VLR55O7FTO5X?=
 =?us-ascii?Q?U9bc6nuL3LujiUb+9srzoJ1Tx1un3ftv0v+a23ymaeEn4bn7/tU/yiSF343x?=
 =?us-ascii?Q?4NBWqCoaR/zpUSirmWIWESgADvg8pYYNuD+I6RF/DkMyiaX5FEAiGoySU/EG?=
 =?us-ascii?Q?ND9V4ZrGbk6SeEy9bmKlfyUnCFuZJfi3d1zdEf6FJugx5sV/f8gMyPgJ6RKZ?=
 =?us-ascii?Q?RJrNwN3/iyLdft+kGRNutlI22l60QdJFkrP+0ggrKQze2vEVKbuhg6kH6b5k?=
 =?us-ascii?Q?qFBvCst5jlOKoqJ7LKG5tRSkqdHCxThRFpF2ZICSXwCWZ9EQvN8ZewYk8yre?=
 =?us-ascii?Q?8KBAeB7XtmMDoWGV4eVzW4e1ct6lL/bLWchRrDxch9ffWb6i0LRCcBeMaHKK?=
 =?us-ascii?Q?diBH/EKwaP7jp5e9OId5XLPvW7HoyS1kFvALMpNqFHkjUuPvo7zXBA/ktl/5?=
 =?us-ascii?Q?7FRmBf7Znv02ysHzZgtZCocmRhOToDyHqhOR+XooJ7xdLcEC0hsBsZaqOE/+?=
 =?us-ascii?Q?ckvHyBPtMXfvP0Nm5OGYaVWj8ftrd20e4RtfjcYYwmLu2icIfVxGcheATKdM?=
 =?us-ascii?Q?2Gr/7sBjK09DUod3yewpfa5/Z7zAbuld0R9UEf6gnoxtdbLVUp/c9XjbWyF9?=
 =?us-ascii?Q?3qhqAeogTPsVuhlQETK1Gsa7N+2EMe98eW5cfasyE4M5Zsag5MjGEwBEq0jT?=
 =?us-ascii?Q?nlj3c1YZjuOmdwZdWvX6FcR81yFcotkTKYYRqFo53AsEp/d8hZJcqZP6wivA?=
 =?us-ascii?Q?AgSiSEIeWE8UMRTHWXHZbbzlFYcHrrJFDi5ZKwtAD6490PO3gtgnZ1UEsFUL?=
 =?us-ascii?Q?i23r6Jbtk7bYo/gr+5+7pCEzICrjbhr8LwavrfHKWdXRktDmN7VjvWYOqSPE?=
 =?us-ascii?Q?AuAl03WCzWqOPlF+OB+uO4kvZC0DmogUi1EI7eviQUK76hPbHpjmeitDdeVS?=
 =?us-ascii?Q?Gsnq9FXYXA+TR0+9i8vHhMbg150xT44ovo2vfPPddt/pKU432EVqFP34myvZ?=
 =?us-ascii?Q?k5e4kvsX4qZgXfTMx49EmmV+MKpJYwL0FFdMY7zKV39QEpsoN691284xxZ4o?=
 =?us-ascii?Q?hRo8ViHJgI8kk+0KSywondqZw2UwrqCbEpIFmLWh8mrM9dKs9jsJ8lQhgCCc?=
 =?us-ascii?Q?+wPE8C7sAhEIdIAqT+ilXnI6I8Ois/udJ5UvUj7560RToWN1BFUqb+YVzkA1?=
 =?us-ascii?Q?92TXS+nni+yq0d6L8ge7jawZiV4gv4t2HGuqg2WH3p1m1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rXp8Pe7+95cGTEz5kD6G+lCFgc6SzlZvB0NRW7b4B6t3D7QMmdxhxjrJqw9I?=
 =?us-ascii?Q?hgBdT75/wKkya3/G5WZMVOtJnFWmJwJYh2EwZEsaTpl1y0dn2Mtx0eROMUmE?=
 =?us-ascii?Q?iX860G6zvzm25JStAhXglDTLopWb0wqSIue07TSJWhwhY0QuDB+krId/ESZz?=
 =?us-ascii?Q?jLsetZ5oCqj+wL8r9SmzFDhRK6g8ix+KsNII3m/jIJODsMqoPW5V2Qkk1bf9?=
 =?us-ascii?Q?3a+UwzcbLGpDGu1Z/iPbBo/4vn5+n0/q3UIdCP66qOABr2J59MWa/+6TX5WR?=
 =?us-ascii?Q?8Uc9OVk/+B/UWdfi4d6h6oo7tQSBeBDXT+9IaXFudjbVaRZDdhqF5At85V+D?=
 =?us-ascii?Q?rqpnzi3TatNBUuNA0W9mu09t+re3UzwL6lnVswE/GIuixT3GN9fu3VdOv5Gg?=
 =?us-ascii?Q?uzIzpBejS3jkSb1c0ztKaCTXahHAMwTZKRPpg9m41Gbwen9YGdpP6uPVdKhS?=
 =?us-ascii?Q?pSmQDT+FYRq+l9WLNRpVLg0MpgZer0/JqugShHE/81rltPfCILHFeS+/of91?=
 =?us-ascii?Q?pZ9FpwpP2GYp45VLnRhbYMZwXfQmt+etq6ly/yyfbMZIUUE5aQDoShi7M7nY?=
 =?us-ascii?Q?aSON31NitBPAgcDz2X2dqQzuCCQbc5xH8duNxx6/OcwTeKt6Lm7jR/CSaseE?=
 =?us-ascii?Q?PiiAv1RvUY6dbxcoCW6wGPdGzkG0vlyNX5eGgTaXl33nHezi/SUrgLD0Hxv9?=
 =?us-ascii?Q?HpdNS7rmrLszTE6VmWkEMAPH/hsVUnxjxeqXV2PM1CXkLcSzy+u68gKyVVce?=
 =?us-ascii?Q?gaMLlgfmkpk2lLcuCA6jrOJVUQxgRZ/M1wASutn94H8PsCwQdFBlsXaEcBwF?=
 =?us-ascii?Q?KyHWF2F5nzw4uGX1FRt6lanPW+jj54NOlb/ZNM2SE1l3JhL7ICTIVeGGsL6v?=
 =?us-ascii?Q?dSRUavRFYZdfcmh8Lkj4HUctEWaCGei9+gMiMlCE2EvmmxZ5Bb9kIZi+547T?=
 =?us-ascii?Q?cgADzNdfTmEFJTLoI0Vrm1vbgNDwoce3fYIVsyq30ZrwhZNbIVx6qxQUvNk6?=
 =?us-ascii?Q?b/lgc2UXkJdhVbQNHdCjDWLVP2h5Pkg+EioRWCO/8mXfYPDIds5ZJNJLdIcN?=
 =?us-ascii?Q?wKqWdx7lG+IrTgiBy20Be0jLt6I1WJ9rxgJB1TDvfzrxavNOfsBUYKR54zjK?=
 =?us-ascii?Q?bLXhT0plSxYnFSz9rKyrLwk2qU3N2UeQmV0EURUab6CFCb7HJFi4L9iigsgp?=
 =?us-ascii?Q?qU7U33nNOY/xn1v/YphSNb6h4Cfn3kH6iiFPNaUc4UyRAwVHRY0mAoYElsdB?=
 =?us-ascii?Q?94WNt/PUu0DrPU5vKwYqgAkDtSavDQM/O9qYCqyRzigvycP50OiXbQg7xr1J?=
 =?us-ascii?Q?jRACiW26YoiSNjQa0S2rOb3hA+METGP6pf5DrXFtizQd2fAr57nhI/6XK3H+?=
 =?us-ascii?Q?eSV+Q5nvC35Ln3J9DzBcXlxKH+JkafbO74DqDkAliIupnEVT03ZqUI9OxbEV?=
 =?us-ascii?Q?J5RXkdIs4VZWd9kBof+pWyPUA4+f4ul4Qz2gtr/nEVjnwXms3KkLuxbB9S1c?=
 =?us-ascii?Q?nACPS8rnOHb422FzOUhMY2b9ibtMARmIhfKkivL3nkV9AEzWSr0IsqK5a9t7?=
 =?us-ascii?Q?IcIW7z6PSu9nKAvCpwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6315ea-5289-4749-4b9d-08dc75789c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 07:20:06.1835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJ9AgxDCl23IwRb2s71kK9QIDSpnW25svacq9cXMu+9jmnOICEHrjyljZTH1aPMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

The series was
Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, May 16, 2024 9:11 AM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: enable thermal alert on smu 14.0.2/3

enable thermal alert on smu 14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  8 +++
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 68 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 35 +++++++++-
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v14_0.h
index 3d34b3869df6..9b97a4e95c0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -48,6 +48,10 @@

 #define SMU14_TOOL_SIZE                        0x19000

+#define CTF_OFFSET_EDGE                        5
+#define CTF_OFFSET_HOTSPOT             5
+#define CTF_OFFSET_MEM                 5
+
 extern const int decoded_link_speed[5];  extern const int decoded_link_wid=
th[7];

@@ -236,5 +240,9 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *smu=
,

 void smu_v14_0_set_smu_mailbox_registers(struct smu_context *smu);

+int smu_v14_0_enable_thermal_alert(struct smu_context *smu);
+
+int smu_v14_0_disable_thermal_alert(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index fbfe9cae0e05..8cce17d1f230 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -38,6 +38,8 @@
 #include "amdgpu_ras.h"
 #include "smu_cmn.h"

+#include "asic_reg/thm/thm_14_0_2_offset.h"
+#include "asic_reg/thm/thm_14_0_2_sh_mask.h"
 #include "asic_reg/mp/mp_14_0_2_offset.h"
 #include "asic_reg/mp/mp_14_0_2_sh_mask.h"

@@ -853,12 +855,19 @@ static int smu_v14_0_set_irq_state(struct amdgpu_devi=
ce *adev,
                                   unsigned tyep,
                                   enum amdgpu_interrupt_state state)  {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       uint32_t low, high;
        uint32_t val =3D 0;

        switch (state) {
        case AMDGPU_IRQ_STATE_DISABLE:
                /* For THM irqs */
-               // TODO
+               val =3D RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+               val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH=
_MASK, 1);
+               val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL=
_MASK, 1);
+               WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, val);
+
+               WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_ENA, 0);

                /* For MP1 SW irqs */
                if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 0) || @@ -875,7 +884,24 @@ static int smu_v14_0_set_irq_state(struct=
 amdgpu_device *adev,
                break;
        case AMDGPU_IRQ_STATE_ENABLE:
                /* For THM irqs */
-               // TODO
+               low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+                         smu->thermal_range.min / SMU_TEMPERATURE_UNITS_PE=
R_CENTIGRADES);
+               high =3D min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+                          smu->thermal_range.software_shutdown_temp);
+               val =3D RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+               val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CRE=
DIT, 5);
+               val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_H=
W_ENA, 1);
+               val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH=
_MASK, 0);
+               val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL=
_MASK, 0);
+               val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_=
INTH, (high & 0xff));
+               val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_=
INTL, (low & 0xff));
+               val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MA=
SK);
+               WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, val);
+
+               val =3D (1 << THM_THERMAL_INT_ENA__THERM_INTH_CLR__SHIFT);
+               val |=3D (1 << THM_THERMAL_INT_ENA__THERM_INTL_CLR__SHIFT);
+               val |=3D (1 << THM_THERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIF=
T);
+               WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_ENA, val);

                /* For MP1 SW irqs */
                if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 0) || @@ -1849,3 +1875,41 @@ int smu_v14_0_od_edit_dpm_table(struct =
smu_context *smu,
        return ret;
 }

+static int smu_v14_0_allow_ih_interrupt(struct smu_context *smu) {
+       return smu_cmn_send_smc_msg(smu,
+                                   SMU_MSG_AllowIHHostInterrupt,
+                                   NULL);
+}
+
+static int smu_v14_0_process_pending_interrupt(struct smu_context *smu)
+{
+       int ret =3D 0;
+
+       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
+               ret =3D smu_v14_0_allow_ih_interrupt(smu);
+
+       return ret;
+}
+
+int smu_v14_0_enable_thermal_alert(struct smu_context *smu) {
+       int ret =3D 0;
+
+       if (!smu->irq_source.num_types)
+               return 0;
+
+       ret =3D amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+       if (ret)
+               return ret;
+
+       return smu_v14_0_process_pending_interrupt(smu);
+}
+
+int smu_v14_0_disable_thermal_alert(struct smu_context *smu) {
+       if (!smu->irq_source.num_types)
+               return 0;
+
+       return amdgpu_irq_put(smu->adev, &smu->irq_source, 0); }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 1fbceb85d319..2b874e1ba4ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1276,10 +1276,41 @@ static int smu_v14_0_2_update_pcie_parameters(struc=
t smu_context *smu,
        return 0;
 }

+static const struct smu_temperature_range smu14_thermal_policy[] =3D {
+       {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 990=
00},
+       { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,
+120000}, };
+
 static int smu_v14_0_2_get_thermal_temperature_range(struct smu_context *s=
mu,
                                                     struct smu_temperature=
_range *range)  {
-       // TODO
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       struct smu_14_0_2_powerplay_table *powerplay_table =3D
+               table_context->power_play_table;
+       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
+
+       if (amdgpu_sriov_vf(smu->adev))
+               return 0;
+
+       if (!range)
+               return -EINVAL;
+
+       memcpy(range, &smu14_thermal_policy[0], sizeof(struct
+smu_temperature_range));
+
+       range->max =3D pptable->CustomSkuTable.TemperatureLimit[TEMP_EDGE] =
*
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->edge_emergency_max =3D (pptable->CustomSkuTable.TemperatureL=
imit[TEMP_EDGE] + CTF_OFFSET_EDGE) *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->hotspot_crit_max =3D pptable->CustomSkuTable.TemperatureLimi=
t[TEMP_HOTSPOT] *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->hotspot_emergency_max =3D (pptable->CustomSkuTable.Temperatu=
reLimit[TEMP_HOTSPOT] + CTF_OFFSET_HOTSPOT) *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->mem_crit_max =3D pptable->CustomSkuTable.TemperatureLimit[TE=
MP_MEM] *
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->mem_emergency_max =3D (pptable->CustomSkuTable.TemperatureLi=
mit[TEMP_MEM] + CTF_OFFSET_MEM)*
+               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+       range->software_shutdown_temp =3D powerplay_table->software_shutdow=
n_temp;
+       range->software_shutdown_temp_offset =3D
+pptable->CustomSkuTable.FanAbnormalTempLimitOffset;

        return 0;
 }
@@ -1866,6 +1897,8 @@ static const struct pptable_funcs smu_v14_0_2_ppt_fun=
cs =3D {
        .update_pcie_parameters =3D smu_v14_0_2_update_pcie_parameters,
        .get_thermal_temperature_range =3D smu_v14_0_2_get_thermal_temperat=
ure_range,
        .register_irq_handler =3D smu_v14_0_register_irq_handler,
+       .enable_thermal_alert =3D smu_v14_0_enable_thermal_alert,
+       .disable_thermal_alert =3D smu_v14_0_disable_thermal_alert,
        .notify_memory_pool_location =3D smu_v14_0_notify_memory_pool_locat=
ion,
        .set_soft_freq_limited_range =3D smu_v14_0_set_soft_freq_limited_ra=
nge,
        .init_pptable_microcode =3D smu_v14_0_init_pptable_microcode,
--
2.34.1

