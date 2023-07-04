Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8FAEB64DA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 08:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C3210E2AF;
	Tue,  4 Jul 2023 08:13:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511FF10E2AF
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 08:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLCkLWXaXIxGTfA27FFWa6RwjholFpg0qn6DprI2wAcM/WTZY5pucOYIYQSA/y9tupLTuzxm1+a0h66DQVdxEJloOIJ4wSvdr7fjnnRCUfJOhBSCYHfJntL4w2Sl9YAv7+y0UY3xxLTcZ3a2obyek4kqUb+Nk7/idoMGiYHxGzOaOGUWqnM4y/RIqSIj5YtDracUKL97mh6cI33EPrDtrRLZTXfR7amdT8mI35KTz3hoeKKQ3DIow5U9IomB3AMz0S945D6rCjVzYT77lj12ZaobKBvvUZo0HFrbdRpnZdwodo6BDT6241LXcN3o+Ysf4L4fMfhYtQQ63QqTD3+MEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOJLqmkSIQlaqqTs2HQOkNKk/RXrtAcRBU98hAolo/8=;
 b=jVhY7p9y3AkdCd0GA9tvHBVsG0iqQHMhDK6sf5jznhgQcqq118+K84dmo0f1BQRfpr95UkVHEZEJF0KrKcqow7eGrfqfckMtOe16f1prJzWonssCCgzSjECJ91nlYXO2LkFyK2UgWmPK+EcqNV3EACL/2wBIt9nqUaEfh3W3iNJgO2Ud79hJsf2Em383/QRNQmKQdw8KUyNiTtzbJPM+i0vcizaQn/GoTw+s47JXe1/VbHNDzeH9UtYHXwjIABJaD85vUluWwNIgr87ePRWd/0KH+XFbBOTpQ55Aw05jldOZXag6cdTFl4JQbRTjVrHssN7DiwVjeWWfpvshqxExtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOJLqmkSIQlaqqTs2HQOkNKk/RXrtAcRBU98hAolo/8=;
 b=mjxj7/eOBj3CzqTnFYLB0iP6bKQgkZZmmqySi0RXkYkeYzkagV2jzI9dsYkfmeqEIpHZVgkhWGmpsK5lDufcg5cZqKR+bo5ftuB8F8hDFpJSfmnMa47EEgSG5rLWSeJ2zaoYpPgnhet8sIARUwCPCCZz8f3tS299EGUewOpEXWc=
Received: from MW2PR12MB4668.namprd12.prod.outlook.com (2603:10b6:302:e::21)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:13:40 +0000
Received: from MW2PR12MB4668.namprd12.prod.outlook.com
 ([fe80::3d38:7a76:2925:91f0]) by MW2PR12MB4668.namprd12.prod.outlook.com
 ([fe80::3d38:7a76:2925:91f0%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:13:39 +0000
From: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Change golden settings for GFX v9.4.3
Thread-Topic: [PATCH] drm/amdgpu: Change golden settings for GFX v9.4.3
Thread-Index: AQHZrikusttdBMQh70mBTYMvlImZ+a+pQkSg
Date: Tue, 4 Jul 2023 08:13:39 +0000
Message-ID: <MW2PR12MB46682A7E38D08F5DF0AEA37AFD2EA@MW2PR12MB4668.namprd12.prod.outlook.com>
References: <20230704033920.2732815-1-lijo.lazar@amd.com>
In-Reply-To: <20230704033920.2732815-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3633bdc7-8f37-4fe7-a242-dc10cec3eb6e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-04T08:12:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4668:EE_|DS7PR12MB8229:EE_
x-ms-office365-filtering-correlation-id: cbd8e2c7-c75c-4ea4-3638-08db7c669298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4pWJEyKlcGMOR8LJ/SBi/kTKf+6ArkGAp4J6QLu+SI/gpOqbSinvTM6Vj7MuOnNGaaMTEALpfMHz31kFLbgJubOca0WEGL++QkzffIE9//Pyyu71U1+Oyo2K2g81ug/g84OnpWaXV1Zr2Iq6FCw3nSYLRL1pytmhLV++QVyMfUMIFEr2ZMX8VPRK5qqqYX+yhyep6NWFQQowkuh8xSH26wF/r6kAObsY19vvdGXmjjUu67sxRXoBQhOvRDaxG8N2luEzRe0OhQbCS5ZOfcQ0EV3PWlwsTpHcvK0jD55AgOEg3U0EuS89kIZJmG6NR2JkUcVjp0btNNr3SX7+KoGg2mHhmIUgBwyL7mNVnuCnY1JYhVb0IhBk9fUyvAzVbkoeEsrY7rsUWK9lVEYwpZoa+54s7+uecVVnlIOUVuk/6UkOpBwLsvRd4Z14YDEVFCapipb7OuFGc8lV2NI706OfvxsR+bHkNvKUMOCcW+vt/c6VvJrp9h5m0Sn/nyIorPtVEwq2KM60vH3roHoRfylkzcWH9e5vW0uIJGVMU6KUMIGG5kNF+pHtodUeEdob46dNqcuUD6lFBc08zeqsRLF6VmG/eiGFLtsxA1Y6wyxIHrGuA/M7QGhQf+82Nlk57ec
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4668.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(41300700001)(54906003)(7696005)(38100700002)(71200400001)(122000001)(83380400001)(6506007)(26005)(186003)(53546011)(86362001)(9686003)(55016003)(110136005)(38070700005)(478600001)(316002)(66446008)(2906002)(4326008)(66556008)(66946007)(64756008)(66476007)(76116006)(8936002)(8676002)(33656002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+hufABly9fv+I21VY6bUenAMmKmMm6T3qxmQ3y87b8ok74TRztKHPBQwGaD/?=
 =?us-ascii?Q?q1TUp1VELWlYHhGfPYUL89qdSmOCIOVnH3yJ3L23O7G1UNbq5mrBjDvUFogK?=
 =?us-ascii?Q?xqWIC/IuK9rwZlaQ/9mCmMguxUNI6U0Du2fr+5tdxvCVVJXvBmKkmHULrKCv?=
 =?us-ascii?Q?SHaNKHjooEa7g00WcdJhvxihKYvA41i8Lo3MhC/QG3J6/UAAPLu119si2RbQ?=
 =?us-ascii?Q?hX1rBMtnf6Evy00jbJaAC2N+rXryeqxi3USHKbyAbtv2KkRMNeT9BcQAMyX/?=
 =?us-ascii?Q?4gQoQVvRybkR2dwkBiNGcu/x9jlPDzvcYPL+jHIOgirOceEYg9/61eADyK3f?=
 =?us-ascii?Q?EP6ter3/lwqNIwTcgXYVdUDnubFV1QZ0h3Rp7qLKRHatW8/V54ADZYGkBGDy?=
 =?us-ascii?Q?GGz9CBzW+kro89k7Qf5gPj11rlUtvkTG724V2oBpyJNZNmUGfG0t55K5o01D?=
 =?us-ascii?Q?Ot4zpAw64NpYsT8jlgoF7yRK8ncL9HzDI31HTGvVyaUFK/9asAORE6ZiiUIB?=
 =?us-ascii?Q?sL7/1+R1w3Y0qZsT/XmJnhx3XrbOCNgkY1WmQsdlJSlzMPuNpPyOSBJW5+Xj?=
 =?us-ascii?Q?h0OGsQEBJf7wAYyw9RXKBOVigH5BXJ64pXl59VhLE3ug4HUbIqaFzFrTfwGL?=
 =?us-ascii?Q?dk7gqnnwyEMbxEwcG/jsc95aBxeXZGIsO8GZfb2ED/ClRf872nobuCc7BCZ3?=
 =?us-ascii?Q?IcaTFH2OxkjB2Wr3AOgnlFApcSW/d3G+xneSBmJhn9MDMceXFCGACsj9YvQs?=
 =?us-ascii?Q?8kfgWt498iCI57OsHexajluTEoJstW2RzoZA0/Q54HZzAA1K3/rO5SOlZO4r?=
 =?us-ascii?Q?LZWdRV1n06Z7htjctIqKtqCbsrRYoG11+jmq0Z4GcD3ogNTYJfFo1ykXgawR?=
 =?us-ascii?Q?oU0uly4JMen7EQpUPBLylyJ0xE0FKAiAZ24utkK6Q/01VnIp5OnFzFL78vdt?=
 =?us-ascii?Q?dHqep/YgER2+K92IqwNZ8WPQDZ5HACVWnMFe4Q2gsTkys0X5/bokdUqkJJJO?=
 =?us-ascii?Q?rpX4vncGrbILEPioMB7TCKcsVgHKb1o8NEttScELGu1d3DnUG+bV6Elp9NN1?=
 =?us-ascii?Q?4PaRCWr2XWZMbwrmRrVLCRI4ksEWVvTtSRj1Kx/vx2gK6ETWNwWLKcbmn9lv?=
 =?us-ascii?Q?8p0tp4ddYsg6ZqYBMdh68CYu9rrUaiRPUm4QEEVt6sNgzyDxGqaRMZJSTdZ/?=
 =?us-ascii?Q?OJL4pmtNhuvfE/m0MgU7lYut+GZ8eyzrmnCyLiuyVj01qrjxASL0y6CB1r/J?=
 =?us-ascii?Q?FcXyesgti1h3RbzNoIxEe4wh9SiU+xJnp2G4pxJrp//gdQ2ILNUkzS5FNj+z?=
 =?us-ascii?Q?VOy7g8Bkt6aiiRfoVAdVrMK4auz99Es+8KrFIGjNe8ragRHjmI5w/M2KleMx?=
 =?us-ascii?Q?R+8Ps4wmEIH7+aDbee7kOgbpgRUTmSeW9sd5RlmWldRxsL11Ykb3IYXZiFTn?=
 =?us-ascii?Q?1pd4aoJRUYYEMYsYwthTwTGP2ooVMu/IVeBmAPdARR2FpnijlhM97fFQNYs5?=
 =?us-ascii?Q?OA3GaFFwPhldTz3Uo1PVPoP/BXbKj1MrEDjGXpcoPilU+uuo3TGhnCY0I8JP?=
 =?us-ascii?Q?F0Nx/sytH7CpVHIyIuo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4668.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd8e2c7-c75c-4ea4-3638-08db7c669298
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 08:13:39.0801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2u787z9y1+PshfrjGLuC3toYfUoDAcZ3UwwJmt3d/bDvkaz+m01XaYgebj8yazssi/j/LkBu1Acj+A0FQs/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-and-tested-by: Gadre, Mangesh <Mangesh.Gadre@amd.com>

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 4, 2023 9:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>; =
Gadre, Mangesh <Mangesh.Gadre@amd.com>
Subject: [PATCH] drm/amdgpu: Change golden settings for GFX v9.4.3

Change the settings applicable for A0. GRBM_MCM_ADDR setting will be applie=
d by firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c1e3625ad136..51532d0dd7a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -195,14 +195,11 @@ static void gfx_v9_4_3_init_golden_registers(struct a=
mdgpu_device *adev)
        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
        for (i =3D 0; i < num_xcc; i++) {
                dev_inst =3D GET_INST(GC, i);
-               if (dev_inst >=3D 2)
-                       WREG32_SOC15(GC, dev_inst, regGRBM_MCM_ADDR, 0x4);

+               WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
+                            GOLDEN_GB_ADDR_CONFIG);
                /* Golden settings applied by driver for ASIC with rev_id 0=
 */
                if (adev->rev_id =3D=3D 0) {
-                       WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
-                                    GOLDEN_GB_ADDR_CONFIG);
-
                        WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1=
,
                                              REDUCE_FIFO_DEPTH_BY_2, 2);
                }
--
2.25.1

