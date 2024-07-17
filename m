Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1F3C3DA4B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 12:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C60710E0D8;
	Wed, 17 Jul 2024 12:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XaRiwwZz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ECAB10E0D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 12:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1Ku6Ebk7ngKbkjyF0CLbQEfSOYE1HaNnZwPFblMeh+BqHPEESu8l97UYzftj8SFjrVVvV2CO9JRKcb+XjIW+rejlNH9RVm8/7GWXKrHDtj/+Mh6QWyLEV8hIdrAD9gwYgrDZwtqrR+93rD4q9NwKqoehfRr+PLQWn3GHt3VrN8W4bMATkJSBt1W4vMDWSVORLrGlk5P5LI/vcA0jykkmiUYxBZIXvZYBS9+bELWMSxxvpfj/Uudi1f5GQpnzlk1o8XhcrMU9rZMCSFS610anOGYoHN9dMAuPirEFgXrMIL2D9MPr0YcqdAY883HkxpeNPw6t3ksOqPDVoOMyCup0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEOc0WWJPixWgKROnJ0dj9vqGR0eDUxtnjWWuqw57o0=;
 b=J29StvfNV3PywnOXw58aOdptazy3wk90I3AhfhFPjiAxwZrDNrZMaVbZdDNM1qRbPatRx18K2sfJOQrGcnxDWM68EvSAet6/tDnIPgTkQ1OFR1ieOp2ye6FJ62fHbNs/FBUJCYKv6LtQ+aI0D0wLlg2Jszasryzj9uDj2SyQNZ0XqM0GjAUXi4PyFfsOMBtnFC6tDKc9j2MhpkucIWah9oo0krcR62wxED8nmK75XmFx7+904cvYDTbS1vyIuZSyvX6WdNRX4Qsa9j7sj6497Zy2kFKGwQvSLSeLc8sFOdq7HzgnLrPVYLhY6SUay1tS1BoSSmqTRNC7/5B7AhHTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEOc0WWJPixWgKROnJ0dj9vqGR0eDUxtnjWWuqw57o0=;
 b=XaRiwwZzf2Lsi4WZDJM1E+6xfnFJmiK0gev7MNkFapSLrY2sSpmD/CpQnwMTeHHjdbTfen3aCtuxU/XGinVcpIeKQqMLfGOigt49iJMrNllWNIcxTS+rCBtypvwC2w/7IGWFc2+8thKywZMozIlFVRH0h1jr0mFzlTEPzR7kCQc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Wed, 17 Jul
 2024 12:41:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 12:41:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix eeprom max record count
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix eeprom max record count
Thread-Index: AQHa2Dtjp5NdnEIQoUigBhSNT/a2LrH6273Q
Date: Wed, 17 Jul 2024 12:41:01 +0000
Message-ID: <BN9PR12MB52573BAF29AD1FEABE8123FBFCA32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240717112027.1347891-1-Stanley.Yang@amd.com>
In-Reply-To: <20240717112027.1347891-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=86231b02-a205-454b-92ea-df8ea7dc5b53;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-17T12:37:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB8016:EE_
x-ms-office365-filtering-correlation-id: d7bac5ba-97e9-471b-a7a8-08dca65db730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cEp62DBncFiCQNARSZbPhrht9tqFhNMYUZF/BCNkLZsyZrAfyc9YT1vhAk0c?=
 =?us-ascii?Q?TobYpcUEtDbGaCU7c7HKVedS8FyzuWU8yzV7rsSprtqddaJJnbuUIVE7P2I6?=
 =?us-ascii?Q?bsnKDAcDnnoxrWiVJ+B8Pw2kN5mowTjumlwYfSzz6gBgK0R5k7ZDT56XdWMB?=
 =?us-ascii?Q?ODJFoIy/MCHPRD8nVshnxfTpG7piFWX35+OekyL9PDdy368lJKvovJnrkptc?=
 =?us-ascii?Q?YW/1vNIjVlqTy2pQMSMnohy9mKD7PdTpOjJKqM+r3L2QZbDCMTEK+GxSpdLS?=
 =?us-ascii?Q?yWE4oPx+9TDKJJ3MxhVC5g7570jqgmbI6Q0jxQwhD0nd+K+Mj6+DhYiTiMlE?=
 =?us-ascii?Q?2dyHHfTyhH9QrhetwOS5kl9WnYM424qHRH0Ki+hn3dG03mhwPd/C3gtoF4En?=
 =?us-ascii?Q?lvemqhd6pU/mEPYDq77KGh4fz0+FlkymI4hdODWKt/fOe38tuCAnq0sRx+r4?=
 =?us-ascii?Q?fc1fRwnXWTVZuMczodqmrvatxGB3mzJJkX4ffIxw2ALgkv+8HEu1PYpTiLeF?=
 =?us-ascii?Q?YQBFCoYwRXnBCtlodBNBe+sDvl8Bcz5uH4yrtHocNi/1rBBOYwGGPo0xfwnY?=
 =?us-ascii?Q?usEucS6hs0n2wuvvkL2BPx7gXjR+MobZp3DMBunAVaFnDoQ+hb1yvQmmhJvR?=
 =?us-ascii?Q?n+0rZjjCqYBFFvJnWqhl2/YRWagbcNzC8LXPqdTpFX0o9AYwgCbOeFTAohcN?=
 =?us-ascii?Q?SfGOxVApM+X9lgfhD8PR6oeUpJz8kcGFQsPBTHBdXvB7j3EPeM/UrVGegRYv?=
 =?us-ascii?Q?8uaKvHpzqeM6SwVDi6iCV4uUR/TA4NUKhTp9zYX1vIY31Yt98IO9SkmbEvjD?=
 =?us-ascii?Q?oapK83sqn+WqaH/GsB/a9wYs/SoCu+EDkvrIz+NwAtqqNIUUJaKAfAmseEiP?=
 =?us-ascii?Q?LRmy6xIqHk4bb57jxJPeIiLdioXO73ty9enPavlznzNqelZeU0QXWVauxngd?=
 =?us-ascii?Q?1zYv2QKugF672gVlLINjHpl65aElhKr2Qkwcza5nT9+fgLObMMLMSJd3vpdo?=
 =?us-ascii?Q?YW84EA5qfQgeVerBj2JKG9HuJe/Ykz8yZ3WBdY1U8qf/RonXbxFDQ9bnYFEP?=
 =?us-ascii?Q?VHa/ej8zativYOo0riL5QDF5KkJDOc/PAAahVIPSJrLLO6boU0yKqO1zeQ4+?=
 =?us-ascii?Q?LH0uN3fNB67FDYh9qlUrk2bVQo/srJPzu0KTYt61dl+8wjNIeoxhMxE9zGyy?=
 =?us-ascii?Q?qD89SV3n8shw7XkVC9EVWV8r9PJT/XLiCOwQxkSfBVAUWI3AgaEvBP7ckK8V?=
 =?us-ascii?Q?L0quDyIPIs+jpU0/n0akBsqb5jdh9pVZbHJ4KIzbVftcEFK1d+1KwaRhFVfl?=
 =?us-ascii?Q?+INwOczUGS9wgUPWJHRoTLsTZ+gV+ilnPMWzcP4MRo3K0Q3pX8K7DghynhE4?=
 =?us-ascii?Q?/iX2goK1WLDRzS9S+jkYofnyYJPnA2x9ka7BLKZXQSDHn6Hufg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V4BaJtQZBW2FGfyBIGAWsSMOGMa8NOnWFxZpq7oku0q9bUh8+K/RKlMGTwVY?=
 =?us-ascii?Q?KQ+UNRZSzGzgQD9xVvmCcXkRUFIkVoflyHBxTsr6ianejKlHsrzvIwVHdaV1?=
 =?us-ascii?Q?4iRJ5RYhJ4OPIU2gfUH64Nau04qM3tix3Eia7CWy2QyBTGFz6YpTs59i93Pf?=
 =?us-ascii?Q?yKYRkFNPgnI6BdUl7gyehxUiRowdUh6eNuTkOstkt5l2DZ3LE6Ety/hgUCCp?=
 =?us-ascii?Q?Bgut29auK0SXO2HtCY4r5yomyJ4gnh9qYMEQFZ4WKQ2xXqmu8IjsXxmXaL4T?=
 =?us-ascii?Q?v90pmfDG0DBYiGohg1UAl53efQTh609Lj/uPRSImvMFrnkgNyrO8FDMGdcQf?=
 =?us-ascii?Q?nCDyMUND9Zsnj9igcW13rfgi0KDswmlSRTMaglIbl+gdf5c6egdC69istUT6?=
 =?us-ascii?Q?2k0NLBAbn81VkLcx00fZkr6raglN4r+IG3H/z07XdIaTSapaN4fq0GnksL+V?=
 =?us-ascii?Q?wNmgbGsrx4H74GJHq/8FFAsDopMt9h6R9HOKbPxJxusn3xbVQw54og1U2Yp8?=
 =?us-ascii?Q?3tB8cOsbPE6es8883U1Xe97NGhcZ/sJJpwAgiIeDek2z8QCDOBhQKHkMmDRH?=
 =?us-ascii?Q?QGVNXmWSfb/CcgOWqpCplML0LhRuoowWl87a6u+Qgt2QwL/6vptU1ACCuCGl?=
 =?us-ascii?Q?42WQsmtARvPiNWQrOU0G61iP2Y7YwV+JkzgfP0WuEcZUpaxRJOcMQAlgVLZR?=
 =?us-ascii?Q?79CqHSnfTUGm8+tWiCLNenb6J97R86vNSyZFgUyswV8jb7qxG2jQoR28e7l9?=
 =?us-ascii?Q?/T2xy8FpRdgHkaTmRlEnOzCKXeurePqd2f9+vYPZeHxc38XRjHvRYIDTYjLO?=
 =?us-ascii?Q?c2dowpXagcCAzL9MjB+FyRH7nYF2NsBcYEvllNnrEwBz2Ck+fCmyMciDfMIR?=
 =?us-ascii?Q?FOUAJvCMqYDDgVh4dGqjaFHecYAmrPWQIv5/4c5BXMYXNKhI6sYZZt1sGa/2?=
 =?us-ascii?Q?vBanc5XSF4xKMoqA9eHYAz9/CYTWzbAI+G+EX+a+r877UN62ZX5JZWHWWr09?=
 =?us-ascii?Q?bcNf52ucO+IveWaRLnp39m5s+wiX3PC/AgwKlsbRDuzPJ+4tNvgpVNNVUb7S?=
 =?us-ascii?Q?kLyJhGmkrk8e0Qy29kgKlGVgxxTOGS6aAzD5RyMqMdNAEDVc8JPlHC+CUro7?=
 =?us-ascii?Q?BjlMa+FtN8YGf4m0Phb6wUIIC7B9uDJTt5gQPIASjq58uQz6yuFbAR5Xjb6i?=
 =?us-ascii?Q?sARmU9qayYRIhCLVbrWML74ER2C3asLtipwjXXV1nFtn8ERl5d5VdTcKyUd6?=
 =?us-ascii?Q?Sbp+SkLth6J0GKqudN/XdZyMPWtDXfR/zZtKmZypRlTfxq0sB2bO162lSKFw?=
 =?us-ascii?Q?IMOHr9eEbkt1aHRrj2RNnekL2fBXlKNlsiYsfW8NyWdBtzdbzyE8DUVA3J1A?=
 =?us-ascii?Q?04e6A0Kw9njfKalU2nN6Jk3omat/Vng11ob5Fk37Q+RsaAOdJePMKZvL4V61?=
 =?us-ascii?Q?qho2aW1A3O5MbUBp4N11wtZmniKYMZTTBmtcJRlc5QH177hwu3zmmWfJg0J0?=
 =?us-ascii?Q?dahkw/Nu56AyCoM/n80UKS2Z7aIaTVvev9GZMpem5IlGYPRh1W6+uOpXXly/?=
 =?us-ascii?Q?yYjxrUAwb+1dd28OWm9q8JgF1Bh2wXllu0dzsSIU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bac5ba-97e9-471b-a7a8-08dca65db730
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 12:41:01.5051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwlFESmsLCFqSinRFq4OCA3equ0dqMo12MF5F6XFatkzsPLppWRKexnypNhEGPE7Y6KnTPcS4WtuKwZ0yH8+UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016
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

Shall we reuse amdgpu_ras_set_eeprom_table_version? We need to move the fun=
ction to the beginning of amdgpu_ras_recovery_init, something like this.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Wednesday, July 17, 2024 19:20
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix eeprom max record count

The eeprom table is empty before initializing, add get eeprom table version=
 function according UMC HWIP version before initializing eeprom table.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index eae0a555df3c..c30d7daab472 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -406,6 +406,21 @@ static int amdgpu_ras_eeprom_correct_header_tag(
        return res;
 }

+static uint32_t amdgpu_ras_get_eeprom_table_version(struct
+amdgpu_ras_eeprom_control *control) {
+       struct amdgpu_device *adev =3D to_amdgpu_device(control);
+
+       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
+       case IP_VERSION(8, 10, 0):
+       case IP_VERSION(12, 0, 0):
+               return RAS_TABLE_VER_V2_1;
+       default:
+               return RAS_TABLE_VER_V1;
+       }
+
+       return RAS_TABLE_VER_V1;
+}
+
 static void amdgpu_ras_set_eeprom_table_version(struct amdgpu_ras_eeprom_c=
ontrol *control)  {
        struct amdgpu_device *adev =3D to_amdgpu_device(control); @@ -1011,=
7 +1026,9 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *c=
ontrol,

 uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_contr=
ol *control)  {
-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       uint32_t tbl_version =3D amdgpu_ras_get_eeprom_table_version(contro=
l);
+
+       if (tbl_version =3D=3D RAS_TABLE_VER_V2_1)
                return RAS_MAX_RECORD_COUNT_V2_1;
        else
                return RAS_MAX_RECORD_COUNT;
--
2.25.1

