Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B273C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 12:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C322110E7FF;
	Thu, 18 Jul 2024 12:33:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ysQLds2F";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B85A10E7FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 12:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4/PmmeZEjaoq3xGm8Sq5u4ja2lRtsQcK8Uz9McjZMXHOll/AZylBjVfGSPfSlR3y5akI6nRjGKhOMMsMcltewzraBMYQdPvsmLdi45g54OZfHT7vQEu/VzBykdXVbx63dFrKfSb38UEp8oOJniq3/kUsPMeb4T58TzPjq5zheOFsngs3o/pt7ZF5iwlfeIjlVGsFeiOC8IBzGWwkJ+NBs4It47dzo3nstIAL4IKVYdyS+zRzBc+b672o6dABQbibtv8Hi1PIqc9eUxzXniVvun+ugQg4M1OtciYQ36gzJYoZt0eBj76JXZBsahSAsojBeX2h562Hz1RwxZL+9OoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g4WbiChaVU7EHhoo4KyX6c8vLubnVWYXQyrD0MjAec=;
 b=xQRr5MlcdcLnA0Zhw+2NHngdW2Tt+0SkG6og4hyJazwzevZjqmjTeQqUcYdfRrrtS5tAwsQcdQBf9oyTY/slqTX+CVV3vhNh9yqa4hkOsu2jBlgyF6w51k0fZGnd3aCe4mJfa/1ZqmHzHBgf4muS5qHMB6bjJq99sFMWijRNVjdIT8lhtP8hnRRjAYV5+Vi6ep3miYWlOfuxn+9o1h2R7CHx8CvS79wYzjeG6Wzq+pELksk5Py82D8OH/Ilb5Xy3BSmvbv9qR8jDN/JMCFvnystL3XJVW57gn7P4jXkT8Z7CJWF57BH4n1y6kKtjMKKbP3M7Aogh37XPo9Lzq+Mbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g4WbiChaVU7EHhoo4KyX6c8vLubnVWYXQyrD0MjAec=;
 b=ysQLds2FSPcBWa949K4N0kePmOb/h7tdPKP3HdIUk2Guu72x6B36g6k0kJIX7eBJEGnoHo5GvIcNKeMa4n+Lqc2kuJFgJBvOgCzJup+VKNERrQrtiULXonT/C6XtVz5a1kFDp6ZKZBTrp8oiQavv09pfv7pnSVxa31445Bh/Ndg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 12:33:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 12:33:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v1 6/6] drm/amdgpu: add print support for sdma_v_4_4_2
 ip_dump
Thread-Topic: [PATCH v1 6/6] drm/amdgpu: add print support for sdma_v_4_4_2
 ip_dump
Thread-Index: AQHa2Mz8fhHnyML0ckub5sCvhH5fu7H8a4CP
Date: Thu, 18 Jul 2024 12:32:59 +0000
Message-ID: <BL1PR12MB51449DCA7C56741FBE7AAA3FF7AC2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240718044250.1822051-1-sunil.khatri@amd.com>
 <20240718044250.1822051-7-sunil.khatri@amd.com>
In-Reply-To: <20240718044250.1822051-7-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-18T12:32:59.141Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB7195:EE_
x-ms-office365-filtering-correlation-id: b4fe01a7-c424-48e4-1e77-08dca725c298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Lh+88MBcE/wFX8tUJwnEfS5ZAsO6t9WiolMRUuctvFXh+i3D0L4iKxzDbqbU?=
 =?us-ascii?Q?F/RLXf3XaxVPxxa6Yzq3nuEAh4iLaYtEqQLso9vV2+y4dqBdIlqmrR1sTl1n?=
 =?us-ascii?Q?2aEJzI8FeyffI6HTiV9ZJmwTVesaIld8JDh5RkOw8BdO9YpAV9MxiFkZVkTb?=
 =?us-ascii?Q?aSCjY0jV9Hl6XPpcdenTZcXxTPgx2GrHQBxD7pnFM9FcYzhI9QR0Gat/u05m?=
 =?us-ascii?Q?RUpdyrq1TcoSwVoFdtyMUyy3C6K7psJAmuhwENJoEwOghEH/HgEeq/YtXN2Z?=
 =?us-ascii?Q?CwAB9/TA2MnD+UsJBhX1j1k/bQ4fRUqfbr0qNBbbmGBtmOU9kiIzE+UjuDjm?=
 =?us-ascii?Q?bhMn349U9AwewLwyJZrsqORWrdIcB8iTTgyf966FVuuOi2lb2B/Zfhwi9hns?=
 =?us-ascii?Q?cAjcvuRVnI0KS58eOzoOYnr71ky/F+dv72HFjnWMrJJEkfjMAcKeaNzh+ZEz?=
 =?us-ascii?Q?S0KpyJJd2iXngXs7/8uisUiFr2xKfAjM1RQDkJoT8awxUfyJFI0aThoN3yTu?=
 =?us-ascii?Q?duc/sq3xv5rrdfss6+K623/Fnf/TAuoxSExVKIPRxOyUyEwJftczl5bd3Ef2?=
 =?us-ascii?Q?XXaI8eUZYZ2pw3jyERxK9ZWA+mb2KTiKepLDxMDVvy1gisAqBiZeGCKs+Lnj?=
 =?us-ascii?Q?oGh2klUy9gDwcEPSfkMoFul8XSbxzclYq0M0dKdIUM0IMX3Ds955zWoxgZ3/?=
 =?us-ascii?Q?wg00WQnwz+B0N1yc1oc6U4mz9KdjbODbxsaw0iUQPzA6TBqgiaANih2KZmrF?=
 =?us-ascii?Q?+q9jDsfDeMp30wYHkr5Ho7FEdtI8tdBlJY/5UIql6dnuaEfXD8qP3+xTAPY7?=
 =?us-ascii?Q?F019n6N9AjxIZsZV/b0YrJBjFaoecUDBrEaoI9yuMeh5JR9jLcLtEEsBjc6D?=
 =?us-ascii?Q?Z9PCsCyXvcvCrsIDXueLdE5qYE6+zTaDc2+0fUMQwpGBiNrqiN9QQpgRNYhN?=
 =?us-ascii?Q?sTX0kdCTINDkHKom2Y+8/2KKB+fphiOitmNAkKgWDxUT/rviB9UfQNHM/09d?=
 =?us-ascii?Q?gnqjz8kHKQ6TDLgNMJo9UGigBP30ksScrrCZVRFSGYII7wdF46hqDu8bqpMJ?=
 =?us-ascii?Q?HDmyjvqoUvxd7JOKnrhi/w+pwghU8Dl8tsyQ8DpJAntBzgPmlHS4CQnDjH67?=
 =?us-ascii?Q?+89su7HSapJv1KngJVWiQHIqozqOSksCpxvDgvB15sHTNgzgy+WErUz8Johz?=
 =?us-ascii?Q?Qu7oN3cdQTkeTp7TNdiMj3qHgOFseK/6m/gHOz5WmVrBYuNa6Y/gDUba9iqU?=
 =?us-ascii?Q?yIftXaGBFpZbev2krcZQ1KdpJ3r8WEevLVkgE5wbQzNQtD/b3zGDTItqnoQv?=
 =?us-ascii?Q?70qTyP5y8lhuURcdvb/D/subrJW8VMbL2wlyfCwGbcXkY8jH1KG/a9EErZp9?=
 =?us-ascii?Q?pQsEwjr+872EPQq9C6TmUUTUMaFYxDi/j/EZ1fCz0+C75gvoNQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hieGhN8h68ZjdmFMZ91A1amfIJm73S7bvw1ohjVbYDKcUC1d6aak25aFmo2Y?=
 =?us-ascii?Q?/FsDF1/d7DWGS/qeEZB4avXMYHF9dh4q22L8cFulksIm7sHxAi9m1Hj77qSM?=
 =?us-ascii?Q?YnWHU8ssV1oFj4bcPErGNDRaf/vYbSoF1gGTbvVCpIWdgiNQDt9G1eEpNp4Y?=
 =?us-ascii?Q?rh5FJxzxFM0Whxa5ce3yEPgb6KnjxByI7EWdo/ZTxqBVHflDGUcqwRJaVRhk?=
 =?us-ascii?Q?4vDfHf8jDe4iQ5NlXXKSg2Hym2JC/jwe/5DDG8/0tydKXsKFJrSXWM7N+AXu?=
 =?us-ascii?Q?Z3Mz85LwNZmQBS7NuFD3ibHsIHw0cazA2d/KxqQ3KzP1Z0ayVG9X+0rAjSk+?=
 =?us-ascii?Q?dYagI1BufO8WnYse78OM07SP6E71RwJ9/5GzMuTkvPK/CVdBYbwotfRq3ZA+?=
 =?us-ascii?Q?Len/ag5bQzn981tvmB+5c9UlgS1V8meCO2DdG1bA0tR9KGYJpEwVG/6gNdIe?=
 =?us-ascii?Q?LsrlyP0gSdwzouWzUi6DJDRSzr1RoqxacAJYBhSxiVFrhRpscbTJRwMuPWyw?=
 =?us-ascii?Q?B6y4HCL3o0ErwL/UedP3+m1F0Sm7p6iXj5jJFE8W/qQl42xu6BH395wmsfRp?=
 =?us-ascii?Q?mE2s6HcOnfILeFAi1bSomKyf560lafOIG38OVvRRnOHu/69PsGL/48vJcekn?=
 =?us-ascii?Q?+ELT5PKyQZR7jFq7kPxqmvUfQK5I49ccP5CxHOks/gBDbHTX/ljGafQUCT32?=
 =?us-ascii?Q?kUVE8uIbIKOldJDetvzSXv0gerVPgAlnaIShWcmLgQn5BCVweI6g//GNjn+Q?=
 =?us-ascii?Q?8p7rRZ2DrAejXPjLm0gkWITxR7ofxsSUP37D6RAfswoSEZ0+U1KjWAAJPi9z?=
 =?us-ascii?Q?wedDPMCrFitNrjkJNQ1KppkYXjs3cZKyXq55KqOOrQJ2Zt8xIBG4/ZGsKaKX?=
 =?us-ascii?Q?pFx6EtVkzbV0CftRt9Or7Gpuj6D9NedT/IVh35Ad8hO4qxUnIjkNxhKYlNKZ?=
 =?us-ascii?Q?P8dfFk5IHQV8y6ZmfIOHpQCLwOMNiAzW3P4cX4oS39wBj2vkQyQb1M0Me/a6?=
 =?us-ascii?Q?BOGpGqaA9AQWg4i0dRbrRDYEeXffoJgJe6WNHIiMXfrArYNdMsLixDLyE7Kz?=
 =?us-ascii?Q?TTKO6PcuQ0VQuPE21wMSWGFFJ0Wt+O8LXZrOyHt/MmcM5m2Y0inU5LkTAV/x?=
 =?us-ascii?Q?qZ4vE8DdE/dUn6/oKcbWEKYBG9DJALGaT9YNt6Moocs06NcAPG87oNGA/PhN?=
 =?us-ascii?Q?LMC8y0ZbO46aYvyaVoQ548nqy5W6ZNyxFUorvyb0jE8hPJowUGKLFCtCqm9K?=
 =?us-ascii?Q?4P3/PlnUws80YRgtcTzhI8vuiU1RINL3kS9F/uODkDrK2xliE0ND4uFxGApK?=
 =?us-ascii?Q?8WlZSV2DevIpTAYUARb7dtxc5Iiv62Mh5xUP6X1CFvc7eniJJAl29fOUg8sl?=
 =?us-ascii?Q?ksEEb5MLbTPvi4NvzPYSoqsg5ifLTOxYtJBpZHjHYKm8IoR2O+51RbfTcItP?=
 =?us-ascii?Q?R0JYsphBaIc0/xrlJRvVnPGKvmY37cHXlFO1QID8F4uB4nPQ9mPYwMa1mw9v?=
 =?us-ascii?Q?ekuu56PD74to+081/WdRlL4oOz3T8iL9TnJuGFU3z07KjC1WiXJ+uRfHRdSL?=
 =?us-ascii?Q?h6mpfUkYEzqfh4plOmI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51449DCA7C56741FBE7AAA3FF7AC2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fe01a7-c424-48e4-1e77-08dca725c298
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 12:32:59.9645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtUk3IEl8pSb0qCKXHs8w1migMakq0nHjL10yvBv3Q/fTtc3odIELWyWd0/k1urhsadFDdlMDQa76dKqAM5P8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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

--_000_BL1PR12MB51449DCA7C56741FBE7AAA3FF7AC2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Thursday, July 18, 2024 12:42 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Khatri, =
Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH v1 6/6] drm/amdgpu: add print support for sdma_v_4_4_2 ip_d=
ump

Add print support for ip dump for sdma_v_4_4_2 in
devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 917a767ebaf2..9d4091175d29 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1857,6 +1857,27 @@ static void sdma_v4_4_2_get_clockgating_state(void *=
handle, u64 *flags)
                 *flags |=3D AMD_CG_SUPPORT_SDMA_LS;
 }

+static void sdma_v4_4_2_print_ip_state(void *handle, struct drm_printer *p=
)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       int i, j;
+       uint32_t reg_count =3D ARRAY_SIZE(sdma_reg_list_4_4_2);
+       uint32_t instance_offset;
+
+       if (!adev->sdma.ip_dump)
+               return;
+
+       drm_printf(p, "num_instances:%d\n", adev->sdma.num_instances);
+       for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               instance_offset =3D i * reg_count;
+               drm_printf(p, "\nInstance:%d\n", i);
+
+               for (j =3D 0; j < reg_count; j++)
+                       drm_printf(p, "%-50s \t 0x%08x\n", sdma_reg_list_4_=
4_2[j].reg_name,
+                                  adev->sdma.ip_dump[instance_offset + j])=
;
+       }
+}
+
 static void sdma_v4_4_2_dump_ip_state(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -1895,6 +1916,7 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs =3D {
         .set_powergating_state =3D sdma_v4_4_2_set_powergating_state,
         .get_clockgating_state =3D sdma_v4_4_2_get_clockgating_state,
         .dump_ip_state =3D sdma_v4_4_2_dump_ip_state,
+       .print_ip_state =3D sdma_v4_4_2_print_ip_state,
 };

 static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs =3D {
--
2.34.1


--_000_BL1PR12MB51449DCA7C56741FBE7AAA3FF7AC2BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sunil Khatri &lt;suni=
l.khatri@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 18, 2024 12:42 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;<br>
<b>Subject:</b> [PATCH v1 6/6] drm/amdgpu: add print support for sdma_v_4_4=
_2 ip_dump</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add print support for ip dump for sdma_v_4_4_2 in<=
br>
devcoredump.<br>
<br>
Signed-off-by: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 22 ++++++++++++++++++++++<=
br>
&nbsp;1 file changed, 22 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c<br>
index 917a767ebaf2..9d4091175d29 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
@@ -1857,6 +1857,27 @@ static void sdma_v4_4_2_get_clockgating_state(void *=
handle, u64 *flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags |=3D AMD_CG_SUPPORT_SDMA_LS;<br>
&nbsp;}<br>
&nbsp;<br>
+static void sdma_v4_4_2_print_ip_state(void *handle, struct drm_printer *p=
)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)handle;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_count =3D ARRAY_SIZE(sdm=
a_reg_list_4_4_2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t instance_offset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;sdma.ip_dump)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(p, &quot;num_instances:%d\=
n&quot;, adev-&gt;sdma.num_instances);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; instance_offset =3D i * reg_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drm_printf(p, &quot;\nInstance:%d\n&quot;, i);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (j =3D 0; j &lt; reg_count; j++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(p, &q=
uot;%-50s \t 0x%08x\n&quot;, sdma_reg_list_4_4_2[j].reg_name,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ip_dump[ins=
tance_offset + j]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
&nbsp;static void sdma_v4_4_2_dump_ip_state(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -1895,6 +1916,7 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs =3D {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_state =3D=
 sdma_v4_4_2_set_powergating_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clockgating_state =3D=
 sdma_v4_4_2_get_clockgating_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dump_ip_state =3D sdma_v4=
_4_2_dump_ip_state,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_ip_state =3D sdma_v4_4_2_print=
_ip_state,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs =3D {<br=
>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51449DCA7C56741FBE7AAA3FF7AC2BL1PR12MB5144namp_--
