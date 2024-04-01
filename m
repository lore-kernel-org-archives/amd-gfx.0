Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EED5CD1288
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 13:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE2010E5B7;
	Mon,  1 Apr 2024 13:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWIcfpWj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BB810E5B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 13:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2uMWvJhSKaIrpQw7yyIC96hIE0ofRMobza3ZjsRcNPcNgjg6S4T9UzrUsrfiWqE1A8vGebI1WmRooOHnZ9P+cjjeBmI/no4UzisG6dfSbPX9yaVcG4QpXZqGTGBdBgc7LKWPX0mORt+qOrbWpUgJV/S9qji4+QbIqP9wbU7YDduMJ9g7EhT7kjqQOEenSKUPw+BgK0QlJa8J5DNI5lGoR3Hy9uQXnzgfOv95+PfRHCRNOOqmuBxArxTIH+TvsX49jStWIai03ez1/9C+j9w+Gr1c/THReW0buACTYVQwFyIa+spGPEMZ13fR57pQXwomWKDGPOe86q1yKIaH5zaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM1XHzox1ptzkb1EYIkJHzY9AVwS5cNwP5kJ3rPmG3U=;
 b=Ouea6ZZM5WgdM9vjziH+R2Fw8dOi6yQhNAIGbNXsaBoq5OVdjiI0kNd6bQTxJ06Z/YHG9rQklFPudAAL8c4w0J7tGdDAtQKgsKzToOY//V4T0WixLnJui24iFeCFj75rzR+vXbhXhyJDeo7hent3tegng0yFNy48AAz7/zYYA52atTrYT8gNCsH/DUKYCNpSD/xZz0GiL6BmNWK2+OIG59FAg7OJEV05ZwzFUoVGivdfZ75ZVQB5ptRVDsNXfM+NfbXFnHk2cdU+bR6wLAmsQrBT29fL7HRL00utULS1oIrS5JfjVoqLa2PMxzv2a4EDud34gw43bLyxIL1KZQZD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM1XHzox1ptzkb1EYIkJHzY9AVwS5cNwP5kJ3rPmG3U=;
 b=JWIcfpWjYD7I0O0A/UoDMh2XDkFtQRlkQonk5Zu9K8OK3Nwl68wKh5jSPBqlxIM2vxsLZWt5hbsAXM5i+FPcqDbRKkNNAgvinI8zNytu8OnJMJr7az0hHAKENlMG734GF/wzjIZX5ya5vLD2u+l0510/3vqRkM2mBDz7kELIB9s=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:07:43 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 13:07:43 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Adhuri, Mounika"
 <Mounika.Adhuri@amd.com>, "Leung, Martin" <Martin.Leung@amd.com>
Subject: RE: [PATCH 01/43] drm/amd/display: Fix compiler redefinition warnings
 for certain configs
Thread-Topic: [PATCH 01/43] drm/amd/display: Fix compiler redefinition
 warnings for certain configs
Thread-Index: AQHagUlT2+llMsU+jke7reHZ1Zg7Q7FTZ+ag
Date: Mon, 1 Apr 2024 13:07:43 +0000
Message-ID: <DS0PR12MB6534B2F6E19F531579A839719C3F2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
 <20240328195047.2843715-2-Roman.Li@amd.com>
In-Reply-To: <20240328195047.2843715-2-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d44fdc4d-7f76-44e0-b2d1-cbcdcc3c18f8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-01T13:06:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH8PR12MB6724:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: de+gYZFhTJnQiT44Rl84KEX27qXmzUDSVL3w/a7c3lPbX4lLfP5ZtUYb0dPezMMyfGcmxXEsE2fwMs93Ss/xh5daTbKJn6m/pqgLndN4nMZh+ObsiVuvvDDsjASmb7GX//kYTJTYS6bAd7c/I3XtMMuXyrZtQjrGZtPmzu1hDnZoZMA4/Vz5qCiyZjzKpJCfo/rkFHYgtjiICavwGXWt0fdLGr0vaicC1fMgzON1x08ynn2yv6PuXWKXBlaMtoP7S/PSVdon6JNdmYulHq5OXdpOdR2Lf2YK5TncsWQJzfG6eDUNsWHj2hzM5PJyv9C8GtLi3LQtQmHyuiD5afTP8dTJAqMf3uqCGOPEePX5ObNXQqbyTihJ9Z7soapJ2cVb/EsSJoq2KSpkaYYBo/6p1ILEV6CXphekLN6MXeNhG8r19688Suo9RlihdrjFOvjFRL6yQdosfMswPbtLkazgekuoht1HP3xEM53X0q9q6T4qOHrdcDa/sOCVhUVO7dSSDIFyE7mRM9RezxvdbCqwpLKmKy89mrxoQv/ZL2b5x2PWLc9oismS9e9178vZD/gYEI2bdNORJ3WeEdMi5+Vrx+WWQTAIERwkoNFN7UokqiG6hcnmxQmuojeQbFNAj1+V6oZ5DquksRXMeDFg4FNafw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W9O8vV/Chmt3nRMnDruvQZO7Ukq3PguuZvm8nZU7GfGzamHwrpr5Vs2NTScT?=
 =?us-ascii?Q?aL4E6eNttdiiLI4u47RRiKGgaLPtN9akyCiY1rIoh9Zvvmry9jWi8i0imtB8?=
 =?us-ascii?Q?7jfA/lX5e323u+EpJxX9RNuq0lOWl11ikhDl4Dr5YslnUHRpyGXEhsk1F9Hk?=
 =?us-ascii?Q?oBVG0gIkV8TOobXhWjORYBdOF9h1jVHwNwrXlscHZ1jswBdjChnTSUiyGCib?=
 =?us-ascii?Q?qfH7bzQnV/BzObassB/+JGQQUrEE94OtWsbEdDoxak1kCqP+PA3OFQiC3n6Q?=
 =?us-ascii?Q?kLevYIqN/tXEisDNqa6SCJncN+pSaPD7aR7lAOxgmj8sh97GrPZFhjGcQU/D?=
 =?us-ascii?Q?GhHrKtO4cn7+qFKgbca/nBLHjiL9CeTwXt1YvPsTbrLcgffxmfUmGyJAIvUh?=
 =?us-ascii?Q?epjBSfmcddBY7x/a1dsfmIcpDgQFOT/Q8UepvkrS0fwFJ8Xa3wnk3tcEBqib?=
 =?us-ascii?Q?LeNt7RPNml3Y69G3q2LG2w+pXGG8y9NTx4cUzJGQgtA8gFKhqqwuGmqluk8g?=
 =?us-ascii?Q?eXv4qZLIdh8g9HRnlNHxryozeghifJ9WDcctwC5bDGJJITNEFuzMi5sImeS6?=
 =?us-ascii?Q?75yuRTzx1ipVvQ6jYg3DCK7t8O7OHdS+79SgNt9wkiWxcKzSKNvxh/T55xRs?=
 =?us-ascii?Q?4Rov0muQ0CdUXXoBhRUZVLVWqsJzqK7MB/7BKZBSgdQc8bihix8KWVozjhyL?=
 =?us-ascii?Q?4uWyN8yQD7OMnk+vBgnDYuJ54uqiW9QQ88hw9B84EsPr6YLQSjDXAd0NmFn4?=
 =?us-ascii?Q?73TL2mUpMsD0VMTX0ZAn+pFqHZeLgl3AesVkktCFj4wEL+9wkMyqYlNgU1HI?=
 =?us-ascii?Q?7h2Qbn6TxhVoQQVSgzQPChkx/0aLGZ7bcX0lqsCZ4gkKUAUWgTyAwH7eEEkQ?=
 =?us-ascii?Q?YzUalhH3MUPMYxEu30rxlyrmz0307pzqDq9UVwHDl5Y/PUJtoYOWfXD1Uv6L?=
 =?us-ascii?Q?om9elA6TYBRAexKEc/7OUUEesiH1eubwoofDdLrduAYQN+dEGEaWCGPlZikS?=
 =?us-ascii?Q?dOuxt4rw44fM6pW7ZqeHJO5piL7Dw+BuhFTxWITxj6H0ziBo3crTRPkXURKO?=
 =?us-ascii?Q?fFZZAP0gwbILwqphixR87Hk2a3VbkFZgRLvEmxt1P7wB0HPtsFQAG0/+Q3RO?=
 =?us-ascii?Q?8ezD1tLVEBGkIFNsKZh0MvJ2E0GIpC5Iocz5ADnHr7jDgLPbW4YIdmLce5+k?=
 =?us-ascii?Q?+0dIf6yk9BkFS37B2lri4tnhFSe1q/EMqbfcdntr6xWNXO659yUpTOIYB4Wv?=
 =?us-ascii?Q?kOmbis62y0fUU+1uaZ9d/RSHS20LZ2WXXOsGXLWlu0GfqeiEbw//5RwuxXIT?=
 =?us-ascii?Q?BK9KyYyBsieQYX70izuCPVDQVFd0iWUb0v5CazP/zcpTEXthCQjj4xp0BSbz?=
 =?us-ascii?Q?hbPjFOrpwd7HGZ/xIX92sS7wNSnp8hB5Zs1oDzixyk4WLbtZX9KtF+O87/JZ?=
 =?us-ascii?Q?WwlxLBANgc5RtAbEdAcdadMHd1Q96qSlZEslqUUpB/9v8rWXB85ATdVIOHhh?=
 =?us-ascii?Q?jNrAXQ4AAZma2IXK7lliyr/jnANO5VCOmO+cSKPWdr8BqZEZH3UNB2e9sm38?=
 =?us-ascii?Q?8vR4ijcykWn9oDfzdcQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c841e63-0881-4426-409d-08dc524cb7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 13:07:43.4769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPtza0yV2R5Tp1XyVVGL10O6s/5lk6NsONMt9tNrnEKut9uvkM7EVIVYkIHmmTi7SHtFQb0TAtzjt0aeJ/xNVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
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

Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - a6b=
494a44fd6 drm/amd/display: Set DCN351 BB and IP the same as DCN35) with new=
 patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Thursday, March 28, 2024 3:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wentland, Harry <Harry.Wentla=
nd@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Ro=
drigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, =
Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chiu, Solomon <So=
lomon.Chiu@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Mahfoo=
z, Hamza <Hamza.Mahfooz@amd.com>; Adhuri, Mounika <Mounika.Adhuri@amd.com>;=
 Leung, Martin <Martin.Leung@amd.com>
Subject: [PATCH 01/43] drm/amd/display: Fix compiler redefinition warnings =
for certain configs

From: Mounika Adhuri <moadhuri@amd.com>

[why & how]
Modified definitions of 1 function and 2 structs to remove warnings on cert=
ain specific compiler configurations due to redefinition.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Mounika Adhuri <moadhuri@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 4 ++--
 drivers/gpu/drm/amd/display/include/grph_object_id.h      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 35c631c22934..17b404cb1155 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -249,7 +249,7 @@ static bool dce110_enable_display_power_gating(
                return false;
 }

-static void build_prescale_params(struct ipp_prescale_params *prescale_par=
ams,
+static void dce110_prescale_params(struct ipp_prescale_params
+*prescale_params,
                const struct dc_plane_state *plane_state)  {
        prescale_params->mode =3D IPP_PRESCALE_MODE_FIXED_UNSIGNED; @@ -291=
,7 +291,7 @@ dce110_set_input_transfer_func(struct dc *dc, struct pipe_ctx =
*pipe_ctx,

        tf =3D &plane_state->in_transfer_func;

-       build_prescale_params(&prescale_params, plane_state);
+       dce110_prescale_params(&prescale_params, plane_state);
        ipp->funcs->ipp_program_prescale(ipp, &prescale_params);

        if (!plane_state->gamma_correction.is_identity && diff --git a/driv=
ers/gpu/drm/amd/display/include/grph_object_id.h b/drivers/gpu/drm/amd/disp=
lay/include/grph_object_id.h
index c6bbd262f1ac..08ee0350b31f 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_id.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_id.h
@@ -226,8 +226,8 @@ enum dp_alt_mode {

 struct graphics_object_id {
        uint32_t  id:8;
-       uint32_t  enum_id:4;
-       uint32_t  type:4;
+       enum object_enum_id  enum_id;
+       enum object_type  type;
        uint32_t  reserved:16; /* for padding. total size should be u32 */ =
 };

--
2.34.1

