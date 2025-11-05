Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D92ACCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 07:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9746010E099;
	Wed,  5 Nov 2025 07:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YDTpPw3h";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA9D10E099
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 07:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPzNDHy2Jzcb72tdaYA0PF70GRt0uRqD2KnGxfFhIPDSyDgjEwF3HdRbd/3NkgVPsF9yPTk0EGuo43md3b7pXEnOfWBxnOk5mOgHeyO8nF7AhYXpJ9TYZrr9+HWsG9yyBlo5kTH9V63spiUVEKUNgdymzS/t2PanF7tduO/4ADdYSYlOiJkCzor+WRVYdTyUN0G2c23C6GA3zPAm1wiOltWsj2nww9TzSrDaSTZ/ryzOoCSje0ewUlMyMmOPrj+cDjy/x6iGgrGy2ATKRliTmHmn6IImTA+I9C/aUAhC0GrNY0rvwIiNyJzho/ilyyVclbZui/x5Ep0NJqhJUDIe6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83jjKSFXGgOQ2iZ017bFxiQUlMj5UbkHblF84ZzPqdk=;
 b=FsnPaPLI7c282cQtcdqOSJr0Ld1/f1N953Za/pXtSJMIfJB6WqJlaZtLMxTciABHseUp6EFhmlgxgZnuSxoSziBuXyDtAAVdv2giwdy2Dw95PcviXklXCg3ffrGouum4OCbGqCRFJebMa8E/bQ8azwTaYycMaiQRB1ZOCyNKGmbNcESUqz0RxgiiSy06eLmkaeuagZTI/WLaByqneKVgVnoNqSLcQ50J3NeQQsRC632bFLa9BqKcfDUABI1Q0v47PApZhbqf5zrIsbhJe50A3bCkP4pq3PJgaeXtrHRS4wOCfOW7zFKYzdGGrYYzVgvicaE02XkhJLBWg+GOOVzRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83jjKSFXGgOQ2iZ017bFxiQUlMj5UbkHblF84ZzPqdk=;
 b=YDTpPw3hXlXybnGGgAvUuDESFD7TE8vbE1Vp9Ei5jH4WPwhRln5DsuIDJl8XrwL403GX1KEenIiR1k34PraHPXguB4pfLcZaHyZSQsq3P0g55Fy9uZaRbzMHPxsEwjONANjkyzp43jUE2uD+R2WVDsYJIaU6aP2GzWqu83/HEDs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 07:06:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 07:06:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling for
 PMFW manages eeprom
Thread-Topic: [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling for
 PMFW manages eeprom
Thread-Index: AQHcTfil4rlGwJmweESVv216Eqvo5rTjqU6g
Date: Wed, 5 Nov 2025 07:06:11 +0000
Message-ID: <BN9PR12MB52574E185CFC88130D99AB07FCC5A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
 <20251105020445.1423034-8-tao.zhou1@amd.com>
In-Reply-To: <20251105020445.1423034-8-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-05T07:05:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB7600:EE_
x-ms-office365-filtering-correlation-id: fc331d61-06d7-44bc-361a-08de1c39cd81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?q+mQ2bgghZ0P8zCZlmwLz1/xHWzbY5+5xTwRmbDka2IhmWsolZ33RNRK1qup?=
 =?us-ascii?Q?UZXH9py2htaPLlkE74LLM6WSxVufhrT7j3JDl9kAnED143E0MgZlGlJImty6?=
 =?us-ascii?Q?E9dYffRdUTFnL2XokjmOslCgXpgB64yEbeig8RKxmcXS+VKaTDu+EjQgPbIC?=
 =?us-ascii?Q?HXIX9nd/VzT59+9SfPWud4LmryRuBDS++b+zq4a+2m/BrGP0cj4vMOEuslCJ?=
 =?us-ascii?Q?DXS38ixvNw68l96TZeQY+zdArduTWeZSgF6rdA/vRjsHAa02hNHdsvoMs35l?=
 =?us-ascii?Q?b4iJ02+xJrwgEfIn0ym6LwnhPn/RyXDeiYiRNcumOHTrDaHMrQ1H8H8oSyRM?=
 =?us-ascii?Q?kSK0+4mzpyagQaGZrSpZOuc+Oz0BNZx75nMK+gWAmtZYMH0e+kB9d/ZNZcK2?=
 =?us-ascii?Q?FoRLoBjO1hey3+qcVEF6AUnZR/2UfTR9Htk9nN0cH9Ip4nc0Yr90/OpmeNyn?=
 =?us-ascii?Q?NBFaQLcMuGN1f2Tfs6GYRMUp8nXtDJgTbVG5Ke2anjvJ637+4YYa0o9DhdlS?=
 =?us-ascii?Q?ohPsQLOO3ZPCbzxic5HUX8ZpuT9TvLpv3daB8av36gdkxXq/zosRc3G59KV6?=
 =?us-ascii?Q?5hzyG1CUJGfcJ2j3gl9aWZirvr0ov4k9zsHH6bAtueN5TwGx+c8vlfC6GrIG?=
 =?us-ascii?Q?jqFgZP+gjvHlVv6prL6k8yrq2RWvS0bY17eDlO04BEo9TAFb0KGBdPJmlhFR?=
 =?us-ascii?Q?8dM6ZdMZko3quHKwLZ0j07CXGkhBfiNc71zhzncrv64oPboOcwFssSiyDsHC?=
 =?us-ascii?Q?Ozwpz5ouf0cFV2R/xUV86t1nbPupTVGhsH2iA55N2/zqWYdHV7znpDa0gBwX?=
 =?us-ascii?Q?BqSwwJHTX7pP23dCGMHVQIfM/z/MfSXgdFnKV/Orkddem6RXsjyqiQrMfMac?=
 =?us-ascii?Q?ZSHPkxWwzV4usRtPy/Tuh3wM9GFivn7JCJByWtwhpkqHdGnuGYewfuUTtnDi?=
 =?us-ascii?Q?RhBElto1EZNv8vUYTt6u5ZrbMuZzqyZvyth+eZMR0y/6JjVVIXKkCOLm0nad?=
 =?us-ascii?Q?Mkzpo6GzjApodp3M9XWjSmEyLCYAN2jMDTtDAY6cDAeLqh7kMIjOLOJOQ/Kg?=
 =?us-ascii?Q?8hQpoUXMatVt0993cxvtz2rvPk2g56bsuw1mgry2k42G6jPB2Li/YZpoDuAc?=
 =?us-ascii?Q?gQvWxASuR/nMmdZhBEiwgFtxz0VgcUHuVojo3xo3tyS7lDF8pkW7poqGzBWt?=
 =?us-ascii?Q?JLS7A5pJ/FRqXIy4oKQsawchI8N4a5F0MdZnF99bxa15bEN5KTNoJc3eeXiC?=
 =?us-ascii?Q?nDgypeXROwuEu3QX1hIZZaxm7K41pWBG2JvjWYnSYgO3yiKu68vyZWNBG0tl?=
 =?us-ascii?Q?yVr0c1bqTLZiWJ3FFVlbBGUFv3q89IjmDLJMACZUSmUP11g3cYpSuyjBFvwo?=
 =?us-ascii?Q?/UfQsU/3HkgRNSrG4wMIyLpQmYaRYRN/BJL+6siHQIlmUYVoiQcMrf9+ZoH5?=
 =?us-ascii?Q?epo9yAoDTOorecC2k2eEI/f/tH4UcHlxq2gKN0b72+uDgFP2MxHaPIreyGUj?=
 =?us-ascii?Q?CxTsMzPRwWFrx73AFwJreiJwAhiuS3Qbf/Il?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PYwzusvHr5b8aJ1c/2kjVVYuHvxh+ZRQUQD2B3xyqcf2yXdh+wNVeyjZBVjH?=
 =?us-ascii?Q?FzgN1jxzgtxZ2O4MbVN3vCXjW0HviaFQu7gw0xUYQaXPPeqsaNK1GxZ/qM9n?=
 =?us-ascii?Q?kCVcoA0Lw2J6nslzu5Ozir8VCfR3+jD879lSsOXR+rsPXZS1oPJ+jHYR83jr?=
 =?us-ascii?Q?iVS3+OoBfG/uC1byQigrDA3tFgUAd6Z0TzHxkuiBgPjOya2CG2+VAoY+GrXw?=
 =?us-ascii?Q?J8W9atVnY66W0tISZs+aIQxqX7ZlUu9p2DQefpLdEHZvpDAhyjS5/feR9VnG?=
 =?us-ascii?Q?pWpSgx7opRyg17BZpGj+oAP4oye76xTZgigZxZacuJcJD4+kY27xt/qhW4a9?=
 =?us-ascii?Q?fA6F35jcLX3YZi0LFeiYg7U/Pz+2lz9RU4O2K2coFTwEHAPag8AD7ASGiB4/?=
 =?us-ascii?Q?jL3FopAgqEtS+vzXV4yRLzt+5aBZkiPhrYEzMh7dKjW2buCB5PSmkrCf2zMn?=
 =?us-ascii?Q?XVZEgjT7BNemSV0b+0mmHUyOJzas3cGCo4Sdr5z9yPRzoulDwl4kpkfPY9FT?=
 =?us-ascii?Q?wzLU06q07LWLDeZ2oA4d97ZQCon0yg0NjYDYLVVF/ciYzDhzzK0TXVy+OjrB?=
 =?us-ascii?Q?pSg+wAAZ+fR9OQev7eH5cxXLORbAkYa3sWpDZP+Yy5YCfLvZidassPpTIhs3?=
 =?us-ascii?Q?0/TjViup4qMm94CwBH90U/gfqMLt6+0A7Upa5yOmIayLTINZQ5MdAmuiBZ/6?=
 =?us-ascii?Q?D4hjWW2OpIlNYyAXR8fowvv9L9iQvgJK8mikNDtBKuNLoNwRXQN8m/4R9vxP?=
 =?us-ascii?Q?a8pYrt/XA0YxmzQCG3Q5be6YtmVRmLfcOQSwy5zHDtlOX9K7D1kEerrhNu2M?=
 =?us-ascii?Q?R0ikPixqAFlP2C6CbJVDmwqUWPRJKiv74nNbrYTOQo9RC+iLUqZ+2FSw9OMp?=
 =?us-ascii?Q?P/EM0tacXYWZuaXfhtixWtnWIUN7W89Ngu7nE1MC9xv29h2BG1ylB4GcuttM?=
 =?us-ascii?Q?UC2lqh4QHn4gFBAqQNgNJoaO0y88A/n7HEZJVYQ5lqCpUzu8Xicpvd1ihaYH?=
 =?us-ascii?Q?wXCN97xxjPRrKCTOzn4rEweJPVMWS6Hln8QUiZzw3GHtQhs9d94jvaCuH4Dr?=
 =?us-ascii?Q?l2WEJh13zJHTYyAgjN/gTfoGUi0doq1mdGHAoAU7oV3fXoiRYru9N1sFiVDa?=
 =?us-ascii?Q?gTI6zvC5QxKp4K7ZuWunkfQ78ghCEP3TKn07BKCGiBDplpvQ5JNXDLd08+G5?=
 =?us-ascii?Q?EOcJCapwSZ5zjEZwBfNcT9Nj9nABP3LerI8TBL17ewyPUeyv4fzN1hS5giah?=
 =?us-ascii?Q?eAp8D4xsAo7zSENPpLSpdIPkVrDfv0ES0TUwwCmLSoPF0aY7sgaP6WN6fOWZ?=
 =?us-ascii?Q?Kw3YuqB/9vDYu/3CoHRqbS4oVTh1MblulqYvP6nOgojg3VNBO67cKPGsIfa8?=
 =?us-ascii?Q?3c5PYxDJsstpnCDrj3m62NDkn4zMcK3vgTRq9ISX+4Hnfsa0h0WDVluMsWg+?=
 =?us-ascii?Q?d+R0JL1Nw/n70zxqQzvqJr9vlox0XXt39d7BVOrx4sv9eobYjrzAEH2+U//B?=
 =?us-ascii?Q?OA0ZwVBcPY4etYAAtEKVNDbQW85vNgtvvOiYmuL/V5/diozaxo2p+pOZRptp?=
 =?us-ascii?Q?lMi9MQZaNqQOiuPNC10=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc331d61-06d7-44bc-361a-08de1c39cd81
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 07:06:11.9404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LU6PMyOOUQHq916nVKmUBgosCL5zuwvNlE/WxXPSlbFnDK2NAZ6CYxkVFyYjr/kAtKuf3ttwj/vOhZWqaUWzdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, November 5, 2025 10:05
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling for PM=
FW manages eeprom

Check if bad page threshold is reached and take actions accordingly.

v2: remove rma message sent to smu when pmfw manages eeprom.
v3: add null pointer check for con.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index beb504cb4bfc..5768d5454a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -903,6 +903,33 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_=
ras_eeprom_control *contro
        return ret;
 }

+static int amdgpu_ras_smu_eeprom_append(struct
+amdgpu_ras_eeprom_control *control) {
+       struct amdgpu_device *adev =3D to_amdgpu_device(control);
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+       if (!amdgpu_ras_smu_eeprom_supported(adev) || !con)
+               return 0;
+
+       control->ras_num_bad_pages =3D con->bad_page_num;
+
+       if (amdgpu_bad_page_threshold !=3D 0 &&
+           control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
+               dev_warn(adev->dev,
+                       "Saved bad pages %d reaches threshold value %d\n",
+                       control->ras_num_bad_pages, con->bad_page_cnt_thres=
hold);
+
+               if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold=
_record(adev))
+                       dev_warn(adev->dev, "fail to generate bad page thre=
shold cper
+records\n");
+
+               if ((amdgpu_bad_page_threshold !=3D -1) &&
+                   (amdgpu_bad_page_threshold !=3D -2))
+                       con->is_rma =3D true;
+       }
+
+       return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure @@ -921,17 +948,14 @@ int amdgpu=
_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
                             const u32 num)
 {
        struct amdgpu_device *adev =3D to_amdgpu_device(control);
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        int res, i;
        uint64_t nps =3D AMDGPU_NPS1_PARTITION_MODE;

-       if (!__is_ras_eeprom_supported(adev) || !con)
+       if (!__is_ras_eeprom_supported(adev))
                return 0;

-       if (amdgpu_ras_smu_eeprom_supported(adev)) {
-               control->ras_num_bad_pages =3D con->bad_page_num;
-               return 0;
-       }
+       if (amdgpu_ras_smu_eeprom_supported(adev))
+               return amdgpu_ras_smu_eeprom_append(control);

        if (num =3D=3D 0) {
                dev_err(adev->dev, "will not append 0 records\n");
--
2.34.1

