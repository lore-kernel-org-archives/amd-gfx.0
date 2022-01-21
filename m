Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F36C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 01:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9329810E842;
	Fri, 21 Jan 2022 01:42:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B7E10E810
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 01:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVQ5ykCTr66oxeD4dD0Dnt3y/Kk9zhbvDlaAP4tzh+xRd1H92mw6Kx8PPqKFZI/nU9uVX2CmaN+pfUP+3ybdnLSRHZA5D2CTfMOzUbGQnfxZrA1nxMwObGdY1F0pm26hAgecmdnL6snbseOf2gYGDavynS/G2hpeSPZaAGRx4XV36guU6Y0a/aGi1LwuQRSGRItFGeifgsTWSO2SOaMgvDLkgt3W5Q00wpej7fn+GzBa1yysuXzGcZ45J+8SyCRhm6XASamLYVsgCxcjSmC4Feuat9mgZqEBXAe9c3Vf/35RtTu/W3mC9Hk0OP1NZT1MsQGMt7IAB8GORWY33iq3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts0bbxo5OUsbstHLFxeagCknmV+7b6VaunV/a9SWKAQ=;
 b=VqBIrMfSC5YZ5L6nWJFoQX0ZHQSoZJiE0d1LuQ7sVJQGDf5DYBte78Wj2JFGIJf7XqP7476TcASlqVwAK18InPZIpjvA4G+8Dml3ziidR7unHVY9tuuGIAAMORWkgzaZrw8CMm0347kfY1LDSvaCmlC8aNWHyKOlqVBU7FRGHpRz5eo40MMJW+dz80rcb0yDiNssatAql2Oox2dFxyRye9kKGQsPw+yrPo6mpx6xouJbeDzdPMGC2VUI/803avNPKyqoiu8NXH5uoQMBTWPKcsz4DD2FwYJBwEBRtFRWy086E3pFCBfybPT0lLBrdrx5HXhgTPpU0mXTU5LtDWYe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts0bbxo5OUsbstHLFxeagCknmV+7b6VaunV/a9SWKAQ=;
 b=dG+1tLMAEG/7jWjsllXm4rJCIyC1cVwiT1cNuzTlffK+ug2w4Ngyci3/u0jKA3eHQzkTjJ+HjG2aegPvYcidwVJu1q4K5qj+4SdcFW11gGU1iXz9V9619jcUg83XNwxTvl/+hs7CPk+yjkrzuZ1Rt6EXkkzK9bHZlBRBFJ4vqfc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Fri, 21 Jan 2022 01:42:42 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 01:42:41 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Disable FRU EEPROM access for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Disable FRU EEPROM access for SRIOV
Thread-Index: AQHYDhVG+mnkIss2bUu8fBlj6YEstqxstBjQ
Date: Fri, 21 Jan 2022 01:42:41 +0000
Message-ID: <DM5PR12MB2469A484021FF00194DB035DF15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220120154851.22223-1-shaoyun.liu@amd.com>
In-Reply-To: <20220120154851.22223-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-21T01:42:35Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7bd55415-bf43-4a62-ac3a-b0588b9d8cd0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-21T01:42:39Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 030b0380-00f5-4dc4-9283-5bce7d30da60
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63a591fb-51e5-4550-2186-08d9dc7f507a
x-ms-traffictypediagnostic: BYAPR12MB3319:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3319E04F6B77CCBEF32624BFF15B9@BYAPR12MB3319.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bD2Ws0uap/nJLjSFPu36IBtjgJfGdBp03r3hLmAGwFlYVT6ol2HIxxLsq5P1LM/heQ9hsOlr9mIL9upVyZ0+x2Xgv881PeI9N01XcKHbOgk+oRDIDXhQXWUoLoDuV+krW+M5k0m8ZYrKXULEwpU9c4UY1Q63t7F6I0xuM9S8BvelfDBGjLaVCqg0qLTSeTqK8hPCCzKSRgt2BlW2ab0e/C09oXBl7wiZGcQ2qFgsau/Ea6WVeg0g43zFxPsnlzZsxslgzXneXpwEpFhAEQfQFWLku/ssjQFpWuJW6GwxI1ZtaKKU7X160m/sIM9mVkEr0aS+40cItrhIJM2rmVPqAyntKaojPfIN21zx3rzYobm5m8WkD3eBlqnBNpHJqqv/5ajXJ/BS4qpaYkmAyJjr3REqO2IKPMDS7+rrybQLiHB+Thv/4Lr4LXc7Xj5apG/uqRz4RcdSSW72qqiv9WehNCW4ZJzkzQG9pjE9fGwOdySNEspneTWdU0G+m51isecWEhRz6TPQKk2/cYTdy6Cm8HFPX7/H/p4g0jV0I+MGRdua72Fq0aYZRbYrbhKTkSBFNhVoUa/jS79Fzbnodol8nmyeeMMPfZpm100rSha+/wXp5pujfMjwHbw40cNNJ7oefpJ6eVu3m9Dus/mAeNaQegVMZpUu1TVwdXkeiD+fXXJZjeeOrBks7inONDEnlBKJ77MeUxJMiLdkqLjucV/MYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(83380400001)(8936002)(26005)(186003)(7696005)(9686003)(122000001)(38100700002)(508600001)(86362001)(71200400001)(8676002)(4326008)(38070700005)(6506007)(53546011)(64756008)(110136005)(66946007)(316002)(76116006)(66476007)(2906002)(33656002)(66446008)(55016003)(52536014)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Jena89DsjphMPIYeWUoNma86G5J7KVxklXqcNMqKOzDnUMjBO+G0dwEAuJm?=
 =?us-ascii?Q?sKsuP1suCwi4kgI7PcUO1zfljxTKVCVw54ZDegh8zHYwiqDdgPFUvPuvae9P?=
 =?us-ascii?Q?oG1xYrQt2I86f3vUhxTNOVNw0WJA6cJsQSRdRrh9YkYKPmm+qARs0PWLOL+P?=
 =?us-ascii?Q?hu9uxWBXDZfxwFLjgMvK/7ZjKh8nTcg9U4QgxfPv/84nzCkvwdpF/5a1j/5T?=
 =?us-ascii?Q?8m7+pIvj7nJrHNQgVgIzK/Iuouv2YQXDa+06+ixsiF4Ot+avhyyqCA5+UbBZ?=
 =?us-ascii?Q?8IGB/GqYe9TubnNeUgnNkBOfsYDlZe4HiyWrv5wjekF2XDbFaX51sly5UxK7?=
 =?us-ascii?Q?G99tQ34onOtkWol/yBKFK9Trv8dSZ9IoEHgmizan/3vlRAOcvOjM1rS6dR6u?=
 =?us-ascii?Q?CsHW3FLiFr3ZTx7oSvJFltsZIyHT6KWsJkAJiLsM+IjMRFpihru1VmAwb5cY?=
 =?us-ascii?Q?wuJS3bffYLmHmKXy8PnnezDWjFo8kiWWu3l+9V2lNZRcWiNPhtbbjfJNbdgz?=
 =?us-ascii?Q?pfQ3f5CF2Q1pncP6pNxjbIPTTBoLK7jvGwAUiao6jLIGeAJPgcQb96nv68SP?=
 =?us-ascii?Q?evAKpPNH1OpYTR5Bfu4EIvSOq9IGqgAACgXwokJZEUHGmAYn2IKLO3s789mz?=
 =?us-ascii?Q?IR4BeZQMQFZnR6pmv2pHXlPUpw8w0AujFTpTf865s6ULQAvjTiyxfcIDEQIv?=
 =?us-ascii?Q?Qmn+izYbzBYUBve1SRW2Hw5OfpMBLaSec/YPlNKpRZktniFBcv7hVobVK5hd?=
 =?us-ascii?Q?WlkXvMKOnRg7ef76xcCYYVIVvYhqvGZJiGC0pKGmw6hQTAW8mDqnpb83M5od?=
 =?us-ascii?Q?w9/fJAdccSIpY3oEZ8/NDmGM26cwe3kDGZNwYLraBZJcQjFTq8M16/tnPUlI?=
 =?us-ascii?Q?KrJ+AS7CSGzXWne2zyPus55dTeCbrOszLnfTFf3KeBBDHey01PFlXMad+MTE?=
 =?us-ascii?Q?tTcsD5yla6t3SDy/kfhUMqHvS/SHnTYGtn65bn/riiN/hhEVsYMJMyGIS1m1?=
 =?us-ascii?Q?a0pvJbqX5dBhKAqk0rzM6ft0cpEOS7fdMz6YuWqtmtGJYE5q+XQEMCEZX8gz?=
 =?us-ascii?Q?nO6KHrFtu+VfjeDoCyz/53XinzztnNuu2V9drdvN07fu5HonK4kmsd7kEokO?=
 =?us-ascii?Q?DkX+NIU4M4kVkgTa1/q+OfiJ3NlwxaEWFJB2Y+r5ObuUUTbvSD29eAFdOL0R?=
 =?us-ascii?Q?z06EkElYo5mFpO7bf5YQTDNxE64dEjxZLmvpUBkj9dcxTRy6ppnYYQh+kbOv?=
 =?us-ascii?Q?YcZgjgzWvQpOjYIL1Idb9c63wRV6V4P9TDZQ0csJ05XqU9gC0V+9LAjg1cjN?=
 =?us-ascii?Q?34K+pLppYLfJeAmLpN8XRdsZdEMbSGI4Ik3FeIt2YrYDFUijxVCU/xJeqRlU?=
 =?us-ascii?Q?+BHLTlTWw9kc39SDRfmjs0N8OPWbbSdiOE+3yqIQbIgKQgSo6thgCggpvpjW?=
 =?us-ascii?Q?ankCyn2pGun9rP//pijMOHUtFwFjSVJ68CU6T/ds+x3EuQHl1ioFN4/UcoCA?=
 =?us-ascii?Q?DkvItt/Hzh+EGPAkcPXjc85IzFI4GzRiMYd0lx16Ualx7YzbrT+AaA7uP9PP?=
 =?us-ascii?Q?3OMjCHNXnGwimgOOninTTA7PLhr5fktWAyu+KAHEGNQggXHwqjeMAlhmnh37?=
 =?us-ascii?Q?FbsFb7LKxNc0Xkj4IC+qNpc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a591fb-51e5-4550-2186-08d9dc7f507a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 01:42:41.7680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkKZE0M+GzN4DYW1HedKXHj5ylqS9meMKZ1VPsZybsWGDTWcw1Pe4wmXzxB6vvnVduU8koGH6sx9WlG8Yw1aIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Thursday, January 20, 2022 11:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Disable FRU EEPROM access for SRIOV

VF acces the EEPROM is blocked by security policy, we might need other way =
to get SKUs info for VF

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 2a786e788627..0548e279cc9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -40,6 +40,12 @@ static bool is_fru_eeprom_supported(struct amdgpu_device=
 *adev)
 	 */
 	struct atom_context *atom_ctx =3D adev->mode_info.atom_context;
=20
+	/* The i2c access is blocked on VF
+	 * TODO: Need other way to get the info
+	 */ =20
+	if (amdgpu_sriov_vf(adev)
+		return false;
+
 	/* VBIOS is of the format ###-DXXXYY-##. For SKU identification,
 	 * we can use just the "DXXX" portion. If there were more models, we
 	 * could convert the 3 characters to a hex integer and use a switch
--
2.17.1
