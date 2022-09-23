Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70615ECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 13:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643BF10E550;
	Fri, 23 Sep 2022 13:39:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8AE10EB24
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 13:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGMcPa2Bt96CJI4T8XfJiRBuccfXmjnpnH/PPoYlM2eW11fdwFc0eh4+2Cqjls5vxtW+eZlTngW9k9X/UrJTS7x+mdTo5jEvn47li3xL2P6K08crFWdn6jVBWe5TESN6++5phoVDM/LosEj9/M3HYt+gf2kZj6l5kf+yMHkJ07Q/z+0sYHFFXi4TtcDHnblj9mqHpJTEcRIAC97oOsX8fNU89mG5/egg5l3yZKLmKhQXar0r1KkvoHS6aXvLdNvhIB+kWWRd2fCClfQRc5RHgJouslSDCdsQpjWLuRYKzTp1Y2+HMv7HZ96bHVdkoPAYP0ya+idOKaZdvjXaixJG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzeLhendoTC8L1FzFlPMoPEwpHKLGHJC7A78J2t+ico=;
 b=jNRwGsPndAf7pWNIyK8K4pqSvUb3xs4PFUNhYMHwzw//TEB1jmd6K9oN37g5BgEBTGHygV8z7gVfwSTaV+TpctWzt/LaMujTVQdvZOvWzZU4kzgWh+33c3Napa4U5fVQFbWptey7NJHs/5tkrzzaBWXyFh7hPw4Fw5o1zFx26IjrBuMSsAWDGNlUk7oQwOgU2qEXntrxdRc09qBZ+NnVZt9TafwavAR1RlnzbKWxp2HpJGFtRX/GxAIFRyPHw9KcSPSb4XqFRn+H3r7QJicpAHRM+P4zbYFHV6sIY+wWUBhMevNVKYA6JmYQBGwFGuoxFzlnHzWjGnhcoMPYob10kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzeLhendoTC8L1FzFlPMoPEwpHKLGHJC7A78J2t+ico=;
 b=XAWIGovSD8pvA960B1u7qrKETzeMjBW08Zt9IAwBRlg1RkFza0hMw+pygFs6OQkzjupaejkXlZ4vNXXKVanhLeDV81QaYruIxBAx4M6AW1M7xchjGnRlx1OgUfEcVk4SOramRh516C4DAl/KthqmqkxH/aJAoEHv8KFgTodcfnc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 13:39:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f5f8:4688:2e04:4769]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f5f8:4688:2e04:4769%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:39:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing XGMI hive registers for mmhub
 9.4.1
Thread-Topic: [PATCH] drm/amd/amdgpu: Add missing XGMI hive registers for
 mmhub 9.4.1
Thread-Index: AQHYz0wCqZek/IGJkEyjLa7sIXn7RK3tBSvv
Date: Fri, 23 Sep 2022 13:39:36 +0000
Message-ID: <BL1PR12MB5144E77B736E199FD11B4716F7519@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220923125658.431117-1-tom.stdenis@amd.com>
In-Reply-To: <20220923125658.431117-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-23T13:39:35.827Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB7357:EE_
x-ms-office365-filtering-correlation-id: 3ce0ae26-fd62-470b-fd6d-08da9d690e4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4Pcx+UGq/H+gAc+hrYR7BAU3faLdQisIiNev0BWLvsXVgYs8/IpBBOqEQxYURJh/nZ/ScZlv/R1kBZGW4UNwaAHoAhGfHKzXDZtCKJ5N7jqv6Lji/vOMzqikA9Hc2KnEBctlJiS7UXwAynwghB1Aic7rFwWuSUTPm7lyuMoIWvQfZ0/8MF6oVxk43oZNrQRzdw/nkrePqeW575uhuE2WmTyCZk71eDAlzOrYiEdUPihdJoG189oW7KOk273J7jPRo2E0/kP5E/Q6baRp0sv/PpaU8t5/3HQdKEpeRgdXxposXforQ/p9ZiH/IHNw38KCyv1U8WnGdDrT2r1oXwN9Hads/1hK/hacHi5d2zFthx0J8ALce4FX9ryjY1eyRrwkEo8sJmRLGcoQwUAkwv1wZIxCk3cEK5K4fLIoIsgf4ylzT4LbUMhvsl8mp/pmT8qEQqRaw6zsS318XdRBoV0iANDbEKNVvDR7abP0o9PTJtRih3BM4G4UKappMhvpvovZ1YgYx12VpdT86y335e6TkAXCAv0I0Lt/FmDoE7x2w9DWyRE5Nznni1J6/531TXan34PJfHsxTFygkr6e2nacu1zOEkDH8IcQF90gE8FYhpivXybG8LClN+tbCTawqJgF6CBmY2+15CrtvkpevJ+EtdcsH2sqtZ24YKFkyH3MmxxYfgBZc7AMGC1XncZ7miMj6KQSIPEbTfhdpa4w9HL6n4HoZfhCJHlOPUnLQ1DO/kRQaeNhTdt4DSnaRQjr5VM2EA0rXUopFCd9Wo0NNG+oQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(83380400001)(55016003)(66446008)(66556008)(8676002)(64756008)(316002)(66946007)(66476007)(76116006)(110136005)(8936002)(71200400001)(6506007)(52536014)(5660300002)(53546011)(478600001)(86362001)(2906002)(7696005)(19627405001)(41300700001)(33656002)(38100700002)(38070700005)(122000001)(26005)(186003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/7f75xCZ1dSqJsHxbtid6XtAMD7dP/D2hUnS22l73JGz3j/X8lJ2H3X7AzYc?=
 =?us-ascii?Q?6MaHYcCY73BRSnS0mmee3cTjKoSM/NhNm7j8sItrZEvO8ZBSsyc/TLb3Wjco?=
 =?us-ascii?Q?nt4SEbP5ZMCA7gmydcEKI3LTS3BreIeYSbS9V4N79k/uUGx9SXUP0VDqalfN?=
 =?us-ascii?Q?euHSW0DZn62nTINWuG9b4mWh9mP/QgNJ0tLBJk7X3/WIWy+d4/MboRLxvzlT?=
 =?us-ascii?Q?aEgoZFWEPJEM0c8e7ZNROTPTv+vkEDs1mUwx1M0a5w9E8GMNsY7jG+6xm9G6?=
 =?us-ascii?Q?aiRiRPAtb3cQ/wPSXsoc0N2is50YMBnzLaZbWvP67UOJe9FglSnvuKWvpTl7?=
 =?us-ascii?Q?QA4SfRMlreETYQaZurPeVbJkJLJL2RnAgb1GNmTU/nZat4NnPl5ScHU15n8M?=
 =?us-ascii?Q?CVJ5v1vosMwMxHLNyMEOTCuK/dONXzloqwJJjgdJQQUj8dVv7fRJulNxa1EM?=
 =?us-ascii?Q?AOn4KY2nlfN+SMjF8sTOOzxT+tOCx7LTFKahhzRKegnEMTor/58VdHy9XVGq?=
 =?us-ascii?Q?Pmj3GBd9iFlegIzl6JM3DQlrzDZaQKY5j3tv6tdz+vufTG6vbkm76dz1RCrj?=
 =?us-ascii?Q?MDh0PN7Yu9HLrIFyMBFLVZqewDDv7r/joT8cVlyIWk9Pi08I5Bi7nRYL4s88?=
 =?us-ascii?Q?irC9C5apfLFu9FvpqRsAHOzSU3BmPj8dsNnzpQwUyPFUkMe9rJV/bFWgzzaq?=
 =?us-ascii?Q?u6si4x5QDw3pV4uNZbkrRXzsRW19BCxPe7T/YBsYOd0iavE51KMFACxqbHlu?=
 =?us-ascii?Q?0rqWegpX6GKiNR4a7XenKUcxZ1kPTo4UX/PR6eAxeXZG2Jz31G8oZVOqqZEh?=
 =?us-ascii?Q?kL25BOmjm604TwgUP3lDZdQ6dBimfEBI56zP/rHTXwrJvzFbaVFI/R+999J8?=
 =?us-ascii?Q?hcdERT6gDN75EXyBt6i0vhSuTeXCIuKPwO6P/qA+NcOuAWZ7ftE8D1mci5z6?=
 =?us-ascii?Q?Y+6wjVEuF+UGsYA522cgVrUIl6Ll2ojk07Vn/Ks1EgOzNafJvogWi9AWn67N?=
 =?us-ascii?Q?QeCPPhq7eZtvsmrEHOIrTqZE4D/HSr7VN8bI8P5LB+ZrAq0F8UnldsSxe3ST?=
 =?us-ascii?Q?RvMSUi6qn1WpGzCKiizSU7nrJOpAHpWE5XSd/Si51xr5wwp8jFinr68kQb1a?=
 =?us-ascii?Q?X7Eaip5bec+0Ah9UMKajFVUA2tqBUW311sRODH0f+l2f2O+tkKSMK1Z+xM+I?=
 =?us-ascii?Q?ylhJ7YZGJN00F7KGWoj9EaYdAL4rQSTUV/luXg59zmqFlP0zbLvjb/DtxNQn?=
 =?us-ascii?Q?Rko43cskrv0Cl3atAUr8XIjiZn+0fDOoht48W1J0E8a8bQV3IZE3JFkEllKl?=
 =?us-ascii?Q?uknllvUcd3+JW7uFsU77o+gKqb3ek+i4moozD58V72ZwKkqugqJxENKPDmVV?=
 =?us-ascii?Q?h2uH7jKQuzx0rdRxDTr6z50yUbIQsEZuMOlBqmf4FcCAImeIk/tnTbH1L9RN?=
 =?us-ascii?Q?hAGParAQYJtOyJGC04SBGOlItadbtwVc8tfzarEYYzD2nqAfOl6sMYhkBRa8?=
 =?us-ascii?Q?+E3GvGJCUjspzpTVbJHwacIH3QrhDWlI6Jk6Dtfrb+I9NPZ4LH3AJ9S6dJ61?=
 =?us-ascii?Q?Cpr5wN1hU8asMrBWiYI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E77B736E199FD11B4716F7519BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce0ae26-fd62-470b-fd6d-08da9d690e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 13:39:36.3127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWVpO9vQcmbZB6JPG/EVJsKL3bxexoVNKLbu6/umJlWU3nzJ3EDIi+jaK2AUP2TEiHO4OskBFeJrYEw2WJDOug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

--_000_BL1PR12MB5144E77B736E199FD11B4716F7519BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tom St D=
enis <tom.stdenis@amd.com>
Sent: Friday, September 23, 2022 8:56 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add missing XGMI hive registers for mmhub =
9.4.1

These are used by umr to sort the hive nodes since the kernel
initializes the nodes in order of bus enumeration not XGMI hive
enumeration.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h   | 4 ++++
 .../drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h  | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.=
h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
index d8632ccf3494..c488d4a50cf4 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
@@ -4409,6 +4409,10 @@
 #define mmVMSHAREDPF0_MC_VM_XGMI_LFB_SIZE_BASE_IDX                        =
                             1
 #define mmVMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL                           =
                             0x0af9
 #define mmVMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL_BASE_IDX                  =
                             1
+#define mmMC_VM_XGMI_LFB_CNTL                                             =
                             0x0823
+#define mmMC_VM_XGMI_LFB_CNTL_BASE_IDX                                    =
                             0
+#define mmMC_VM_XGMI_LFB_SIZE                                             =
                             0x0824
+#define mmMC_VM_XGMI_LFB_SIZE_BASE_IDX                                    =
                             0


 // addressBlock: mmhub_utcl2_vmsharedvcdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask=
.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
index 111a71b434e2..2969fbf282b7 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
@@ -26728,6 +26728,14 @@
 //VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL
 #define VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL__ENABLE_CACHEABLE_DRAM_ADDRE=
SS_APERTURE__SHIFT                  0x0
 #define VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL__ENABLE_CACHEABLE_DRAM_ADDRE=
SS_APERTURE_MASK                    0x00000001L
+//MC_VM_XGMI_LFB_CNTL
+#define MC_VM_XGMI_LFB_CNTL__PF_LFB_REGION__SHIFT                         =
                                    0x0
+#define MC_VM_XGMI_LFB_CNTL__PF_MAX_REGION__SHIFT                         =
                                    0x3
+#define MC_VM_XGMI_LFB_CNTL__PF_LFB_REGION_MASK                           =
                                    0x00000007L
+#define MC_VM_XGMI_LFB_CNTL__PF_MAX_REGION_MASK                           =
                                    0x00000038L
+//MC_VM_XGMI_LFB_SIZE
+#define MC_VM_XGMI_LFB_SIZE__PF_LFB_SIZE__SHIFT                           =
                                    0x0
+#define MC_VM_XGMI_LFB_SIZE__PF_LFB_SIZE_MASK                             =
                                    0x0000FFFFL


 // addressBlock: mmhub_utcl2_vmsharedvcdec
--
2.34.1


--_000_BL1PR12MB5144E77B736E199FD11B4716F7519BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tom St Denis &lt;tom.stdenis@=
amd.com&gt;<br>
<b>Sent:</b> Friday, September 23, 2022 8:56 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Add missing XGMI hive registers for=
 mmhub 9.4.1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">These are used by umr to sort the hive nodes since=
 the kernel<br>
initializes the nodes in order of bus enumeration not XGMI hive<br>
enumeration.<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h&nbsp;&nbsp; |=
 4 ++++<br>
&nbsp;.../drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h&nbsp; | 8 ++=
++++++<br>
&nbsp;2 files changed, 12 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.=
h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h<br>
index d8632ccf3494..c488d4a50cf4 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h<br>
@@ -4409,6 +4409,10 @@<br>
&nbsp;#define mmVMSHAREDPF0_MC_VM_XGMI_LFB_SIZE_BASE_IDX&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&nbsp;#define mmVMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x0af9<br>
&nbsp;#define mmVMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL_BASE_IDX&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
+#define mmMC_VM_XGMI_LFB_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0823<br>
+#define mmMC_VM_XGMI_LFB_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+#define mmMC_VM_XGMI_LFB_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0824<br>
+#define mmMC_VM_XGMI_LFB_SIZE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: mmhub_utcl2_vmsharedvcdec<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask=
.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h<br>
index 111a71b434e2..2969fbf282b7 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h<br>
@@ -26728,6 +26728,14 @@<br>
&nbsp;//VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL<br>
&nbsp;#define VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL__ENABLE_CACHEABLE_DRAM_=
ADDRESS_APERTURE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL__ENABLE_CACHEABLE_DRAM_=
ADDRESS_APERTURE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001L<br=
>
+//MC_VM_XGMI_LFB_CNTL<br>
+#define MC_VM_XGMI_LFB_CNTL__PF_LFB_REGION__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
+#define MC_VM_XGMI_LFB_CNTL__PF_MAX_REGION__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3<br>
+#define MC_VM_XGMI_LFB_CNTL__PF_LFB_REGION_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000007L<br>
+#define MC_VM_XGMI_LFB_CNTL__PF_MAX_REGION_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000038L<br>
+//MC_VM_XGMI_LFB_SIZE<br>
+#define MC_VM_XGMI_LFB_SIZE__PF_LFB_SIZE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
+#define MC_VM_XGMI_LFB_SIZE__PF_LFB_SIZE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000FFFFL<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: mmhub_utcl2_vmsharedvcdec<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E77B736E199FD11B4716F7519BL1PR12MB5144namp_--
