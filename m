Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC94AC7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 15:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7C110E2AF;
	Mon, 12 Jun 2023 15:48:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49FA710E2AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 15:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZzgFCIu4wEi5wPDpjGvnG+IO6NWHgbN6wE9pxS9ZoDbYfkuuPkjaNNigusl3+T0wsRZ7bGHVD2+rZY8nJmXGRVyoGZFERM4UiKh//zaHu47Y7lVzicA2j2sxp49I6Jg+9rrM7tZcytj4sz/I3csmDTF/PwSocyGWVtZxnTGB1JYbZWGOhcg7ltI0i2BZIox+mCAz7SZ5AFrlxqAuqCbBfzb36CqcgwJkqwZOVJyxi1aVQFlTQjUswelhuKNyNdlypzmrL6WwmNziFnuWSypgXy0JJOf0ecqSgI6NZEQfUP5PPMXdkIPVsH2AQrKeBnuf2aAsg0hSPwG9Pf4QEro/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3zuQpbczOmmPuMhzlLoycQNc/mi4SrEFH28hasJuos=;
 b=aLK3NHuC3bl5As4CGi8kotPDs5UI3kIUoJ8MzKRte8G3C8le/HyLfMiIR470/+pIStC10JnhIqYwlJ5B65/4tpfPMhk6jttui4QQQJrGwTQrTIU//U/86QvSLAiLU5qvk9hsSxni655O32rsS5ZgxibKumyCR011giAjCxYr3U0y+p/puFLatG/neAK0MQsmhCsFJ+VArIcTb9W5JvbfStB6d6198G1MkUxyvLUsbqZP8G2jZx/TpxoQD0iukVqK5aMY4dseaaU4VWnOt0s1sPOxB5rLic/0rAPQR4yNsv1ktXxyS6f5XowT+rzGds5zlNIk3zvfkk68ITLQV0IIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3zuQpbczOmmPuMhzlLoycQNc/mi4SrEFH28hasJuos=;
 b=coKU8dimMsdMxCPgBKP3BmPF5TxSa3R+8pMfBVj+v4KHsJM5EcN5QgJrIdBRpiEB1RkM/qXMxZVo7VnNLvVUBBq75+MS1C3P3jibT5USHZ9FAnRaYMZJ5Z24qGXcT0us5/iyLy297MRolMvHXptajnfz2KCcQ0yYJRdAHhUMQA0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 15:47:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 15:47:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: Fix missing prototypes in
 radeon_atpx_handler.c
Thread-Topic: [PATCH] drm/radeon: Fix missing prototypes in
 radeon_atpx_handler.c
Thread-Index: AQHZnRi/MY6hFekroEOrpnShF34OM6+HUDQw
Date: Mon, 12 Jun 2023 15:47:53 +0000
Message-ID: <BL1PR12MB51440954A8B8425462181B51F754A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230612102859.2215988-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230612102859.2215988-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-12T15:47:53.082Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB6956:EE_
x-ms-office365-filtering-correlation-id: ac5684ed-0b4c-4986-95cc-08db6b5c62a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0AEI/EMbYhZyWxL6hwzS91jdsnjEFHJwdfE+m1aZchwmWwjmfZrIECwpuronFwtHPJxpYLOGdjZBGONreEpgNahQSPOCeZ7YaJoJZFJ35Gl1eM/ue5uF9EKB2ThIc/40ZRfUA0oILkGuxvLu4QYLhmj1CDgnOGNIbvYE5Zz7Uyu7lxoxqgu+pGa7B7+aYdf9+A5LcD0SEI7D4hehxKJGfPfp8f2OnmZhC6WaVqjw7LPzDyoyNboFkJio3FJBiYbREaENHxhddTQwKGOb4Wrpkos0yDcwAyGcpDjlIVpzk5kreEgTW7kjrnrX4OYnWxqB0DYMoRtlDyl8fQyTZG18wOjcfjZu/vxJJDW5eNKILq8QPhZcxyam1pKScsK+sDAjJNtJpvX6pynPBljhb+WhFfaj2KxXuYbvuEjM8BazHUehRxxa1EwrcGWCdBbOxzXSkyA9bcNsXvVyccoumRMstlX0u/HwqUWINqT8+N5b8bdP+mvu2dwU590kgrgL/kIe1SUPI6/cbUatA8V56qfrCDObhE+jgDGz6n1mUp+7NYPb0kEdZNU+HTNEoWq1rmLliO43EYuGLOVFUFS7cnv5HixlzwPUcE+D1MHPiX2LlU7wyebwwM5tq3l0o/PD7vF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(19627405001)(66574015)(76116006)(4326008)(66946007)(64756008)(66556008)(66446008)(66476007)(6636002)(186003)(478600001)(2906002)(110136005)(8676002)(316002)(41300700001)(86362001)(7696005)(52536014)(6506007)(33656002)(9686003)(53546011)(38070700005)(71200400001)(122000001)(8936002)(83380400001)(26005)(5660300002)(38100700002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?waIxorH4CbGFUCCb31e7dlfYuMBF+bKC9sYP92mCW4RMGR+jBuQJ8qJs?=
 =?Windows-1252?Q?pb8RaJjIT2pOOVF92mrS93N2R0AnjeUwr8mWiAw5LxY2JBzki1zjjyKB?=
 =?Windows-1252?Q?wb9JXpJBERKfuuiNCbPOqKh0fLY7yjfqUfdUBnKmZTiqYdDTsQvxQJki?=
 =?Windows-1252?Q?64wypkYnssEIM/9x+J+DS5VlG3Lhs1EmaNOtOej7XmJLAVcj+1zxmgVM?=
 =?Windows-1252?Q?ThbPN1+b5vjhsEOq6FsmascwLxLE9wVBWewfhN/pJ3VMOC4h7/i/6jBp?=
 =?Windows-1252?Q?u6IfonGrEV23gHH3GMAzjRlXR81KXKgnMuxWi5VCJXpJfVvp0Zs2sjQ4?=
 =?Windows-1252?Q?cpxx98F2iJzomvVujfAQ3OAAL/PuUXeQkWyww5aSHeW0ikU5HjhIrbEV?=
 =?Windows-1252?Q?1ioWCxxVyPpCeKqbO/Lvv+GVG1rYtxnMgtcz//BvIJfucCeYcdoilTni?=
 =?Windows-1252?Q?NaShzGvVrZbRCvd7LWZDWCbbUQ8LXnn5dJjVHo1MDY0/9rLFEcgP7Vix?=
 =?Windows-1252?Q?EKMcwz8fCB907ZYpfLOqZkXOONULcxoJ5Z8m2uQR1u9QGguOa9tHFEmz?=
 =?Windows-1252?Q?odJ+O+S2d4p2+dV4RtbC+iiySFrmZkoxDbyGmdNTxBhH4BysuYjFOEox?=
 =?Windows-1252?Q?p2TXVk5XlZMFVX8Kbqs385o70yHowLU2afLOMD0JwhH44H2VJmdOy9aR?=
 =?Windows-1252?Q?KMiJDioFz00FfQwkmddtjL4kdezRBQRTahl5FRHv94k0YxRRXlDx2D7r?=
 =?Windows-1252?Q?nwXrIEtaKaDWXXo0XycRS6ZwTPwHpH8Sny7WMnRvfq35BuHL0m9JNOLf?=
 =?Windows-1252?Q?pUUkZxa6+jvbLAEPpOKZlI6Z3pvaKB6WBo+IWQS0q6hgm1zvxNOPULFf?=
 =?Windows-1252?Q?Ub0ES2fOQ8XmU53GZAHwdI5R0SlblEak6IWfKwevlzOs6DnC4O4OKfBU?=
 =?Windows-1252?Q?nE53jgSlMyziAITB2zcQ5ztoJvyc/L8kg7zLe7/hPDqFIYTNsKrVzfV9?=
 =?Windows-1252?Q?mnQR+fgdl4HrBO8AhzE+iMtROoaTkfxJ3nAPVqtzRg8fcB3pS2yy+oh3?=
 =?Windows-1252?Q?5S+TyrEq56Eu3k7YLOcKjQQv3tfpS9c+JHLay18mKk2P5hDY0Szn6jzu?=
 =?Windows-1252?Q?0JnFWmYgqz7Tb5I4dLpPbRhCqoTt2RG5ffdCJP9fCkU3yRBPuAJk0DnO?=
 =?Windows-1252?Q?VDAdNe61V8TTfL+Pf+NYKR/Fxc1t6DvEte4Th4OXFQt934cK9sMdBq40?=
 =?Windows-1252?Q?lX9aoQY9G1bSqQ2GPBjBvWC9ZNmjBj+zN8TM+xTfK3AUnAaRfePLU2Bf?=
 =?Windows-1252?Q?nsWseE2FHohdB8UHQ4WSZ0NcW/Sl2HuS4drp60AkvfbcLP0djcz7Dxwk?=
 =?Windows-1252?Q?OiOY6MnNrrcbXmVILNKNMtdLsJM+7viFK/AQWKjSg5/U1giZTYU3ke5d?=
 =?Windows-1252?Q?1Zo1Gq2ylG15Z9HlSFZmgIhsgwonrhaD1pDzNIv41Z6BEPZyW7mPRPc8?=
 =?Windows-1252?Q?/e+O+5QAOCkH5we/hze31k8w+BYOTZ69VUU3Gcexg0Fm4kWclg11TY74?=
 =?Windows-1252?Q?b3TEC5w3+WFTEqwUPc2WX4zBkuRNWrR+134PLkuhKMpQhn6XuJ7JW2GL?=
 =?Windows-1252?Q?xA9Bdr/FRHES00URNoOsbDm0zidMRvZLttcczyh5O1C5tIybYWvbwMbH?=
 =?Windows-1252?Q?FJtTvqzXg1M=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440954A8B8425462181B51F754ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5684ed-0b4c-4986-95cc-08db6b5c62a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 15:47:53.9184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71gQA9zVldTcBg7GNy5v6ggiZ2fI9LrBGaBewQ/0+o1vGtLbbXk+WVu5ezFk8ayAZUkWwUNs5RAiBYYDEA2ufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51440954A8B8425462181B51F754ABL1PR12MB5144namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Monday, June 12, 2023 6:28 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [PATCH] drm/radeon: Fix missing prototypes in radeon_atpx_handler.=
c

Fixes the following gcc with W=3D1:

drivers/gpu/drm/radeon/radeon_atpx_handler.c:64:6: warning: no previous pro=
totype for =91radeon_has_atpx=92 [-Wmissing-prototypes]
   64 | bool 4(void) {
      |      ^~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:68:6: warning: no previous pro=
totype for =91radeon_has_atpx_dgpu_power_cntl=92 [-Wmissing-prototypes]
   68 | bool radeon_has_atpx_dgpu_power_cntl(void) {
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:72:6: warning: no previous pro=
totype for =91radeon_is_atpx_hybrid=92 [-Wmissing-prototypes]
   72 | bool radeon_is_atpx_hybrid(void) {
      |      ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:77:6: warning: no previous pro=
totype for =91radeon_atpx_dgpu_req_power_for_displays=92 [-Wmissing-prototy=
pes]
   77 | bool radeon_atpx_dgpu_req_power_for_displays(void) {
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:596:6: warning: no previous pr=
ototype for =91radeon_register_atpx_handler=92 [-Wmissing-prototypes]
  596 | void radeon_register_atpx_handler(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:614:6: warning: no previous pr=
ototype for =91radeon_unregister_atpx_handler=92 [-Wmissing-prototypes]
  614 | void radeon_unregister_atpx_handler(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:159: warning: expecting protot=
ype for radeon_atpx_validate_functions(). Prototype was for radeon_atpx_val=
idate() instead

Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_acpi.h         | 9 +++++++++
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_acpi.h b/drivers/gpu/drm/radeon/=
radeon_acpi.h
index 35202a453e66..974fbb4ce2c2 100644
--- a/drivers/gpu/drm/radeon/radeon_acpi.h
+++ b/drivers/gpu/drm/radeon/radeon_acpi.h
@@ -453,4 +453,13 @@ struct acpi_bus_event;
  * BYTE  - number of active lanes
  */

+#if defined(CONFIG_VGA_SWITCHEROO)
+void radeon_register_atpx_handler(void);
+void radeon_unregister_atpx_handler(void);
+bool radeon_has_atpx_dgpu_power_cntl(void);
+bool radeon_is_atpx_hybrid(void);
+bool radeon_has_atpx(void);
+bool radeon_atpx_dgpu_req_power_for_displays(void);
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm=
/radeon/radeon_atpx_handler.c
index 6f93f54bf651..d0b450a06506 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -147,7 +147,7 @@ static void radeon_atpx_parse_functions(struct radeon_a=
tpx_functions *f, u32 mas
 }

 /**
- * radeon_atpx_validate_functions - validate ATPX functions
+ * radeon_atpx_validate() - validate ATPX functions
  *
  * @atpx: radeon atpx struct
  *
--
2.25.1


--_000_BL1PR12MB51440954A8B8425462181B51F754ABL1PR12MB5144namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Monday, June 12, 2023 6:28 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/radeon: Fix missing prototypes in radeon_atpx_h=
andler.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes the following gcc with W=3D1:<br>
<br>
drivers/gpu/drm/radeon/radeon_atpx_handler.c:64:6: warning: no previous pro=
totype for =91radeon_has_atpx=92 [-Wmissing-prototypes]<br>
&nbsp;&nbsp; 64 | bool 4(void) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~=
~~~<br>
drivers/gpu/drm/radeon/radeon_atpx_handler.c:68:6: warning: no previous pro=
totype for =91radeon_has_atpx_dgpu_power_cntl=92 [-Wmissing-prototypes]<br>
&nbsp;&nbsp; 68 | bool radeon_has_atpx_dgpu_power_cntl(void) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~<br>
drivers/gpu/drm/radeon/radeon_atpx_handler.c:72:6: warning: no previous pro=
totype for =91radeon_is_atpx_hybrid=92 [-Wmissing-prototypes]<br>
&nbsp;&nbsp; 72 | bool radeon_is_atpx_hybrid(void) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~=
~~~~~~~~~<br>
drivers/gpu/drm/radeon/radeon_atpx_handler.c:77:6: warning: no previous pro=
totype for =91radeon_atpx_dgpu_req_power_for_displays=92 [-Wmissing-prototy=
pes]<br>
&nbsp;&nbsp; 77 | bool radeon_atpx_dgpu_req_power_for_displays(void) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
drivers/gpu/drm/radeon/radeon_atpx_handler.c:596:6: warning: no previous pr=
ototype for =91radeon_register_atpx_handler=92 [-Wmissing-prototypes]<br>
&nbsp; 596 | void radeon_register_atpx_handler(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~=
~~~~~~~~~~~~~~~~<br>
drivers/gpu/drm/radeon/radeon_atpx_handler.c:614:6: warning: no previous pr=
ototype for =91radeon_unregister_atpx_handler=92 [-Wmissing-prototypes]<br>
&nbsp; 614 | void radeon_unregister_atpx_handler(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~<br>
drivers/gpu/drm/radeon/radeon_atpx_handler.c:159: warning: expecting protot=
ype for radeon_atpx_validate_functions(). Prototype was for radeon_atpx_val=
idate() instead<br>
<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/radeon/radeon_acpi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; | 9 +++++++++<br>
&nbsp;drivers/gpu/drm/radeon/radeon_atpx_handler.c | 2 +-<br>
&nbsp;2 files changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/radeon/radeon_acpi.h b/drivers/gpu/drm/radeon/=
radeon_acpi.h<br>
index 35202a453e66..974fbb4ce2c2 100644<br>
--- a/drivers/gpu/drm/radeon/radeon_acpi.h<br>
+++ b/drivers/gpu/drm/radeon/radeon_acpi.h<br>
@@ -453,4 +453,13 @@ struct acpi_bus_event;<br>
&nbsp; * BYTE&nbsp; - number of active lanes<br>
&nbsp; */<br>
&nbsp;<br>
+#if defined(CONFIG_VGA_SWITCHEROO)<br>
+void radeon_register_atpx_handler(void);<br>
+void radeon_unregister_atpx_handler(void);<br>
+bool radeon_has_atpx_dgpu_power_cntl(void);<br>
+bool radeon_is_atpx_hybrid(void);<br>
+bool radeon_has_atpx(void);<br>
+bool radeon_atpx_dgpu_req_power_for_displays(void);<br>
+#endif<br>
+<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm=
/radeon/radeon_atpx_handler.c<br>
index 6f93f54bf651..d0b450a06506 100644<br>
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c<br>
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c<br>
@@ -147,7 +147,7 @@ static void radeon_atpx_parse_functions(struct radeon_a=
tpx_functions *f, u32 mas<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * radeon_atpx_validate_functions - validate ATPX functions<br>
+ * radeon_atpx_validate() - validate ATPX functions<br>
&nbsp; *<br>
&nbsp; * @atpx: radeon atpx struct<br>
&nbsp; *<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440954A8B8425462181B51F754ABL1PR12MB5144namp_--
