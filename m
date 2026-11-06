Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DE606A337
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J3QZAk6d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A71C10E9D1;
	Fri,  6 Nov 2026 10:03:32 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8BD10E9D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 10:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQaS3V7bG9BrpgDLUiv3XfWq6aVyGBuIcH2VoHGBnqUry0mghHAkVejQB6+vamVjZXkVG0uMDcFlp/edx4emwvXXpfI1k8qVFHnWZLvqyE/F1zxD8+sC7Er1kpBN7b6Py2o1N3L4484SV3nSvuGpQQeVyjA65SEOHmgV5iNQ0gscXJbwqIOdTt6gOH0Ak97JOvvqvcFeV4yYB7DSdqjapoom3NAzpjwQ1kd+0ZJ0BVbViiYsUv2WH4ZGZijU8NF2ewxP7QF9kHL1b0TxVduDSq2fHDUV6p/GDHpAl2iA3qL1zmnImAbJQqAuFf30Xf2A8p7R22rh6mhUJPIO1g04mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHFly4piz39pf15wp1IyxMGydR8LXRCEQ6lHMR/veDM=;
 b=ZHiwdM4TYZxkhBSf/Lfu8O+9HBBQeRI9TbMqRlAqhSWLDonv/NnjpQh7S+lO/+siFx8ZbayBtwTnn6RHXb+POpf0AQdDF7J+gdBWqxwsbMrZByjVU5jKHpQVdM+g4FESSIJNvQWpAW41NXAUJriyLP0KSj7t/Mm96cflrKmWM21eKhFGmKWqaldgyU1CM/PyZS8Kek9IT5MQYYChm/g71UJv0sFo7EPNjQtbTE1BHXg7tmHZW0E1HHS0dwTqcpqdUziQIySEoWiXSTw1EhcnIsQ2WbkaAvwnisC/63NL59n3pADr1vjYQNXVeiAb1S6fq85HH4sHss/HaEu4P/FheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHFly4piz39pf15wp1IyxMGydR8LXRCEQ6lHMR/veDM=;
 b=J3QZAk6d1sgmzUZyneH8TDf7DTOQ2b5I+2HPciVIX93+FSb1DOnxFBQRBSr9d+VF9XaVSS51LbHuUZ5xP993H3cviVNk/NIJx7FaubxnGtrdKlAOsKZTHGNa6F+zdd2s+1ffq0xjWXf58tywUfRMXHyz/lganAlYc/wU4XcscSU=
Received: from DS5PR12MB093474.namprd12.prod.outlook.com (2603:10b6:8:47e::24)
 by DSVPR12MB482230.namprd12.prod.outlook.com (2603:10b6:8:4ff::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 10:02:45 +0000
Received: from DS5PR12MB093474.namprd12.prod.outlook.com
 ([fe80::ac8a:80e9:b544:ddb0]) by DS5PR12MB093474.namprd12.prod.outlook.com
 ([fe80::ac8a:80e9:b544:ddb0%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 10:02:45 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fetch TOS version in PSP v15.0.8
Thread-Topic: [PATCH v2] drm/amdgpu: Fetch TOS version in PSP v15.0.8
Thread-Index: AQHdbdR78U14FlJ9YES/YjABic/g07cg0EDQ
Date: Fri, 6 Nov 2026 10:02:45 +0000
Message-ID: <DS5PR12MB0934743A0CBA986C158B326D5C8E762@DS5PR12MB093474.namprd12.prod.outlook.com>
References: <20261106095139.1328806-1-lijo.lazar@amd.com>
In-Reply-To: <20261106095139.1328806-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-06T10:02:39.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PR12MB093474:EE_|DSVPR12MB482230:EE_
x-ms-office365-filtering-correlation-id: 30d71116-55e9-474a-6543-08df3bed1b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|10067099003|38070700021|11063799006|261102123227099003|261026121527099003|56012099006|261021121427099003|261022075727099003|261021123027099003|261009223027099003;
x-microsoft-antispam-message-info: frV28es4oytHgir8p4Kz5/ac2qyHq1XkLfFhyGkGYz9S+eQmALNjaqVy6roLvNkzidrop3ZzzejTIDERzDKfjKmV7Fw75TDgi4eeGFQhCFsgRlt5esd3GQ7yDJKrePLrlxtEeD3U6emG/OLc/5VZba4GYZR9CE4+6iZU874QstvWSwUeOuylj354snrThxj1VWqC27Wp2wWl2OvKBQrJJNAeClQgiFYYkQcznvbGD15hjCQREe56Onpcg3ZJCs+xZKthM6DhPkYw1ejb3PpRvOlAitPa00N2mevwbXQ93e+m4lJekXARS03cQioQIcIQCdzCC17IX0JWA6NDCwYz7FSbV27AsfmmUEVHJ6sXDS0+7ENKx5BEk0SIsV81FjY1K1esbxXWOFwvP0yYP0M18/b78xYuDwAHCcBdr/2IXU9BAMyZ6wgIwqSaGw0cBLATUKD9WSHUUX4qqsZJ6uxBoXP0ZLT7lpgdAqcYbMGe7i4L3a0CMmNzBy+uZWCSBhCrkGssB0bKR/bQ/+v4oR8Qpd3hABIBogUgYx349fSRZWmN627RfSCqGs3hhf4nvwKJTRUsDOFrw6eEzybPnbPdpITcrFnxKArUlH5Tq5KfFA9wy+ODU+SsDAcplhdH/EGBczhjKAYjkPnukilyGIoQJVrCPCyb8HbUGbuQBmmNULTz4h9NkArAnhk1JEwZXcyXn3br/X5Hm4ytV3UlzhGJ8YzXMPF2BP7CGcz+GW+TT38=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB093474.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(261102123227099003)(261026121527099003)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Efs5Csuxg07gMCI0CY8OF9x2HclTG7QCVIRpTLxCOYotav6eaS+hT3eFfB8S?=
 =?us-ascii?Q?kt1ufxtqzMPgpaBHBUoFyYe6caICM0KYbQ7SE0DxH1RknnQv0PRHShp804nD?=
 =?us-ascii?Q?S/XmvIlXY3TsmK3zoRPfH+ibfTSzdT6d+yHhNVIYcEYyivY1/N74i76qz0xZ?=
 =?us-ascii?Q?+QV+oRxODSbiR5+m0qWrt52oFeXWy3E1ZJEU80FklLveIhV4CU7O9roIDRTe?=
 =?us-ascii?Q?8VCx7LWgld8sMTrYWyKrTnEJDQrLwmIC3VHLFav4K3EtEtMg6+Q8UFuh4ejg?=
 =?us-ascii?Q?nKOV7r6ZFK3NkgzKlv49IRbHFWfVSGyNNLd9QII1h6Dc1Wl++A5RWZKJYLo6?=
 =?us-ascii?Q?BrvnULIhzOX1i9/hYbGEoC+bu03xogITqpmHlfMlOryv+E3eMjB73In7V7MZ?=
 =?us-ascii?Q?o3k2p7VKmin01/bu2ndhbIOH3iPXpdw1phXloWzj8nS7kSqB8CPuwKejZhdi?=
 =?us-ascii?Q?s/XTi0HGhTNi9mfee+352sv6TogwEgUh/95677G5Nn6SyyuEXNKnKRrownmp?=
 =?us-ascii?Q?zX/qyMeyZ8qSTrS4Yx/osC/WcvFpruZMVLWBrG7FenSOa4P8ek677KSY2rEk?=
 =?us-ascii?Q?Xd02gdy93UEtqQDkBwzYAaogOUNOb0k0/vv1co5s0SJGfPxlRAzYjiQCKXB2?=
 =?us-ascii?Q?vj6uEq4D0JvloyVzLAoXQpfTx55FW9fEmjE4HuE0tuxfqGrMAlZWIPZyyzng?=
 =?us-ascii?Q?H+87HEox2k81MfbAiuVQn4MTw2E7JxgAxOZ1raUZByne5f57f2FuVe9E5KXu?=
 =?us-ascii?Q?PTUM7OYxHt2IkycRdRouH+35tb9z6Gk1ShOmOzbJbhDLGH+72kJjOuM5s/T5?=
 =?us-ascii?Q?TlEKSqTCntxkuNtZMNLL/5eL1L9bozZ/YLHjgS4HHY8/KcbYTwEnNVteo0vX?=
 =?us-ascii?Q?oDyF2uLIb4vgGbDX/AJ/ZDckTPqMLfStTO0PhodiRHOxHMjKhoBz5xui4dw8?=
 =?us-ascii?Q?TkUF2ta+T1V8UDatMFitodDSZTUhh9erz3jnOB6Oh7Oo7/taAnFmpsWEOvYi?=
 =?us-ascii?Q?SGwDLc04AyonNjSJ/q1xeA9BA3kdyvbtOVXmi+hqQENma+YMWVnwiUexjZcl?=
 =?us-ascii?Q?0bZ63R/Z1MqxxVcexRYFSg1Dhck1b4IX2whNsxEdqKV2zZ8GmtgrtCpKgfAv?=
 =?us-ascii?Q?LzMpLvycf6sjw5mvdl21nKF9ftjwPKTjP5CknJgkiPsDtq0tEY9mgNvXm5NJ?=
 =?us-ascii?Q?GdooJ52LdyrD7ZQ5EB5DovjwkLhf+eZArqnDedX2hTQvZOrSaGtrWBNQyvh8?=
 =?us-ascii?Q?ZF8c9XK+Mz++7L35vzOGdpx97gNaC9SMzdRya4NcaUKblwJJB0Kuz1zDb0DB?=
 =?us-ascii?Q?yoXUiFenJLam7m696KtzPhaisYBYwniNORyolHX5vjB8/QibhZS99rVrEDbl?=
 =?us-ascii?Q?JpEOxmgW7Anb5bOtxA6lplU/q85Pe/2QIaAYKdKOuFgm9309nd32bPIeaSI3?=
 =?us-ascii?Q?JN6B+MHXE5WbO2NI+TKusOSt9vGtqyWbW3sczmx3y+AZp+ghlbDJck5j0sl8?=
 =?us-ascii?Q?xRjfZemWvNembO0lt5u07JfOC5jUHbK6hCxuceBHAHaUJIMkZy9pa2vYdTeM?=
 =?us-ascii?Q?RRP9rf0+EaXkBxBFRm0ayEavI8t4RgvJ4C9JCeWTZNe8Jpzm4u+6v5cHo/di?=
 =?us-ascii?Q?ldD+6mnLV0EQzfGNxVemjZoi3TlaQ1p/ayL0XdLhlV6SGpdfYCfLhrvSIlOM?=
 =?us-ascii?Q?aQYloMDxz16J6Gss3niJzDVSwIw2WhPpdyKTyUTsX51R3rrs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB093474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d71116-55e9-474a-6543-08df3bed1b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 10:02:45.6100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHXOXjBUUoaLd3WnYFWUk+WJFqHk9wtv10Rj08yhu/aj135wfa1O7OFa8I13WMJNy88Kv9YVg3TU5S+nm0DByg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB482230
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, November 6, 2026 3:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fetch TOS version in PSP v15.0.8

For PSP v15.0.8, PSP is initialized along with VBIOS. Query and keep the ve=
rsion during early init.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

On VF this register read doesn't work, skip reading it for VF (Asad)

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  3 +--  drivers/gpu/drm/amd/amd=
gpu/psp_v15_0_8.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index c0ed3e24b684..548e017311d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -191,6 +191,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_bl=
ock)

        psp->autoload_supported =3D true;
        psp->boot_time_tmr =3D true;
+       psp->adev =3D adev;

        switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
        case IP_VERSION(9, 0, 0):
@@ -298,8 +299,6 @@ static int psp_early_init(struct amdgpu_ip_block *ip_bl=
ock)
                return -EINVAL;
        }

-       psp->adev =3D adev;
-
        adev->psp_timeout =3D 20000;

        psp_check_pmfw_centralized_cstate_management(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v15_0_8.c
index dcfc9be269b0..d64a32565d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -36,6 +36,14 @@ MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc_1.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_rl.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_ta.bin");

+static void psp_v15_0_8_init_sos_version(struct psp_context *psp) {
+       struct amdgpu_device *adev =3D psp->adev;
+       if (!amdgpu_sriov_vf(adev))
+               psp->sos.fw_version =3D
+                       RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_58); }
+
 static int psp_v15_0_8_init_microcode(struct psp_context *psp)  {
        struct amdgpu_device *adev =3D psp->adev; @@ -507,4 +515,7 @@ stati=
c const struct psp_funcs psp_v15_0_8_funcs =3D {  void psp_v15_0_8_set_psp_=
funcs(struct psp_context *psp)  {
        psp->funcs =3D &psp_v15_0_8_funcs;
+
+       /* Initialize SOS version as well */
+       psp_v15_0_8_init_sos_version(psp);
 }
--
2.49.0

