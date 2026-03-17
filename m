Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E098F33824
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 09:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B4810E2FF;
	Tue, 17 Mar 2026 09:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qZ9hG3uP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A2F10E2FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 09:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdUHSMcjsqd/mbMRoDcd4EinhGYgG1mb05HsOWsKCO44tGBjEjfKInT9ZW8w4cCNp88P68YBMmneD8F9dl+u3ABtUDN12MzP1fDEoUFAsfzCqNvvXp0JVMguCE/oWzFX5kp0yLRjlTTZC3B2Q0Yf/IvFZc0Yu8E9wOZwow25UArUgscvD2Q7DoRMxLKXF8QKl/mm9wYBOb6QbBCfZ+RlBXX4ujr60p0zP5pw26BkKC+R6NLMbrkT3IhnEcAWcdWei1WGHxyQwm7XXPQfRhq2FJecXwwEgS5wA3p1payhTOSR5hLWkOKXgb11hGTRvtOORppDD+HutKW1knbs9Qd1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5QV1ukNuEF4bXSM7rlgoe6/4DhcXvCk8JjJtqdNh8w=;
 b=mcZkJfhBMrarJs+wWqAc+nm1BHt43wojpMvjU0JC9Q8TDc5QRCC4FetZOrwSWdsPgz+5g6jsebw3VhA1Iv/6G52P+nalUn+i14WpATXPdW6dlcrtqt/6A7qi0Y8s9PqjnWd7ysC7wkG5qdcCaTvDbCszox8oNSF1sNEPkdOTsAdITHK7Np5Dk0m9aRUBBZ3cOuT/QQ7WW5KsohxB6Zy9rfnrgU7tduPHymUjiAAlCvnemZBHUSlSZbBseZKkCNT0uqk7bTt6h7ZIx7+1utya9HZn8oJLibSg2tFPqFAom2GqX6pxFcJtXzeTv0fW/QwrsePbmy4n2yY3dIxledA1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5QV1ukNuEF4bXSM7rlgoe6/4DhcXvCk8JjJtqdNh8w=;
 b=qZ9hG3uPbfeFHzQeI2mzWPOIqfEGTfF4LwfbJGqc0GRbw9ASrLNsKmupYs8+va4hJhtoAgFha8Ori3pgH+VXPB0mGpmJkqOZQ5TBz1Ziz+o/oBY4gqbAZqo+mCgR854ZYbgsFTDyugskbGSFYwCSVRaT7PRY2OTaIQWpIf4BSZk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 09:46:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 09:46:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reset ras eeprom table when it is invalid
Thread-Topic: [PATCH] drm/amdgpu: reset ras eeprom table when it is invalid
Thread-Index: AQHcteeFGbg1oCxacE+OAZRmwWVwBbWyedfg
Date: Tue, 17 Mar 2026 09:46:01 +0000
Message-ID: <BN9PR12MB5257E08680388435297A912FFC41A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260317082405.1725482-1-ganglxie@amd.com>
In-Reply-To: <20260317082405.1725482-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-17T09:45:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9344:EE_
x-ms-office365-filtering-correlation-id: 0fd9afd4-9c8f-49a0-096a-08de8409ffc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003|7053199007;
x-microsoft-antispam-message-info: rl6RJ94kNbT97yxaaFvqrZgwPyXa2x+YpJNGZoQDeZyhn2idd3JObgWrXjX0LdDimzP46IF59oEbgxE4c3GtoktLnP3clRrmCQZ69Ok8RlPtG1RMCEFMD0DPq/xqPLbxHD0fn+SqAusH1EVtOYk8eQXYGMYqkFD6xRv57zMhe8BbEgqc4xYU2103pIG3dqbt9vfR7+xwex7LUrysVPAYDVQCtIijbt/MwhV2qH3RIKLFiiy9hP2GQtkjv1hM0UkTYpoqyoUOlcHlkyUKC13sYiAnfUJkbz5MqyLYGDu6zVC/yPk5fp+XZDC/OqpDU1mR8UYAPaN09TzX5nb/0+ayW8wmDS+iyfxlxYD1y2KfvXEy5QX88YF3cvVAHLSZjkrm0JyOEkTBzj1mlsyt/Jx7z03AfafXMCs66JKxOrp2MtHz3QwVnRA1SXIUxVKnA8/yckM3j21U/9OUwuZ14kU3DpXkdvIhZ85JWLuYX7LQT/pO3tFqzxCdRV0K2AuPTgh2FHG7QhZqShBqMzxRqVDWZ1SytyOn6f/z+xeoWY5NJcoqEaLFODSvTafJHoUuY61xo2t9gSsrWiOmU8bSSSeAHPag4VnxSlyx35G0jeeAb07vzIMvkAvOoowtjYx7i1S3BS37Lf2H2jyKN/ph7lX29pwXk+qWa2Z9smd+8wOakU3ezDUzEkJJsfD6qv4Bdh7W5Bwd/XpMqFxKbrPyYtDS1SNSlvWW1SaVXMpsMp0y9JfZqERM+m177KfrvpZxlckyAqWgC4rftPQzIktewn9vDnh+mPKknzJP8BRtykTwbhc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y53HPKKjCtYAP6M0mYCaXYmMo4glIA6cE1SG+b2MEowldVRCbJHt9sJ6PAha?=
 =?us-ascii?Q?kCmHMzQpGobEHhlpktZBBs4dNtPIXo1J0dSrzsjU3vS/LZO3jj5EHXXW3vRW?=
 =?us-ascii?Q?pDz+4fa5NB0P+twvThbcu1qqMQRQjFvt23PYahp6YfhVT+4Alf6E9GbmIvt5?=
 =?us-ascii?Q?jl3b7DfNNuqr5tC8YU9z8DgKosmw33inuHp5YxqP+yA2jMgQDWH9LJsx67JP?=
 =?us-ascii?Q?9H3ZM0PTjSUvpGC4M9cDX9pHTjQOJhOX5pTCJpk4ebkhYyNdPubhrayRxXyQ?=
 =?us-ascii?Q?RXpyYPXc9wAax97y3IUMTZwNSKOKgpksCJxDR88LBGDdQpUURQWjr2uc0mcV?=
 =?us-ascii?Q?zWxhesG8CX8MZVQh8JMUklyjVqSZp9zM3v2zATs5zOLA2ywD0jnKithNlzNu?=
 =?us-ascii?Q?4MdjGX6YVEr6YhKuLrh5JCCt7HZ5TYycwc2CrWWxgvMkX6BFjrzGufDK6x67?=
 =?us-ascii?Q?ZNrXCdR+bOqePiZrNt886CPAJ1o8gdCbMip2tJZdFtP+fxIbw8X/Vqg7BTio?=
 =?us-ascii?Q?NSWWENWf1zFLYlqEXR9x8UD66HeVu8ZTRoqy2qnMs2Vwm7SeNv74pEqzg2ni?=
 =?us-ascii?Q?DaTUaw5y9jcStn3+7chPr3Z2S2POEb2AEawsZPMF81mmCeHyCwfpWwa8Wq1G?=
 =?us-ascii?Q?X1OwTA6YYtFFj/ZLEL97QbIMjcWpxTNoEYF/fXfqHVYnmUH0932LEQLd3Stj?=
 =?us-ascii?Q?j5lZUkXfGzz7yA5EpXx5aiRvgEmSfGuML03LKPpsTbVrolPfMgREJRbSkSnZ?=
 =?us-ascii?Q?GBqx6+8L3I6tj8T4PF4QfMBPCd5ooS3W6BhKcdWUnCP0k6q0+NwE6gVaMnUy?=
 =?us-ascii?Q?UyEa3Jkwz4dTER6JJDrw7t6kY5WQl8KfRctPhzE+dE2l6vhgQibNjeCcObzQ?=
 =?us-ascii?Q?CDyDNxbHn2wDYpn1dlBs2frPf81Auw02vflJswgL7NzUamQ/IG4KUEqp4IvX?=
 =?us-ascii?Q?pIvv2vhLS1iAZGpoRrxnh9H4awg7gjPicUUNA4IVYgUGSU+8ap6ePjsmfDLI?=
 =?us-ascii?Q?ICI/JC/kWsbv7zIgSs5o7Yp2SgOoTG2Ja0daxMxxBcVr0rQLBGR7sQYQ9CjW?=
 =?us-ascii?Q?EaeBgNQyji3Sy6APy3f/Kw5mmztQfz4GB7YWpHPPkmX3jWatAe1W7GpbjrIx?=
 =?us-ascii?Q?hDv83kXurYDex24efQzSfX8Ax5N7PfTRRLOoWPFWd66Y+5+afkgx/7Gcf7d2?=
 =?us-ascii?Q?Id6V6ZZt+uey0NfTQjAOj8XioyZJoNIToeBslmHS30xO71JqjHiCqcJmpY7a?=
 =?us-ascii?Q?XFenhvx+c9YtXCw69pGqYVNlWikOpWI7OQkEBtwLbAlAdSmSHGYk9xwLjV+B?=
 =?us-ascii?Q?GvFppMqRVV5QG5FtDwir8fFLFjbeHuWY0klr09j1WmtNiy8d9qafhia9yST2?=
 =?us-ascii?Q?6UGdm3QQx7T6B31/+Dx0dDVTeay4YLXLdII6Pkjw4JjVThhO44ZzAKFTFYbE?=
 =?us-ascii?Q?YNIsL/c3aW4d9/vaJuekXp6UFjaG+Us9m+UHoFYFtpXK6yhZnmeUorfUSkHC?=
 =?us-ascii?Q?jw64RdKvpRoGkuty5NaO9mLiSLzSqgeC5aZ/bRlTbGpBkSYnknShoXjKDXrs?=
 =?us-ascii?Q?XLGMkUPLAwTrfhb7cn7eq1KAtf0fofWwl7OGrOOpDangX2YsFOAFpTIa7R/F?=
 =?us-ascii?Q?nlKbuvSR8nFYjESv+jqs6RWbFtmwHAdYiOvaf95UqEinU4kJ4R3FIuu+fGmt?=
 =?us-ascii?Q?t8+VLD5uaT1xfD1UQ5VgaWU1kdxPHTh6SJWSTSnsdsddoofH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd9afd4-9c8f-49a0-096a-08de8409ffc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 09:46:01.4080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHgqrRYtgeJPEOtNynAD6sBcN9LKu+nxkNjSguFlgKj0rr1MZ2PCiB7o+rSI2ROMowMuxCAL4+WQwEH7MXIDxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Tuesday, March 17, 2026 4:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: reset ras eeprom table when it is invalid

reset ras eeprom table when it is invalid

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 6fba9d5b29ea..3e818b411ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1555,6 +1555,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_c=
ontrol *control)
        unsigned char buf[RAS_TABLE_HEADER_SIZE] =3D { 0 };
        struct amdgpu_ras_eeprom_table_header *hdr =3D &control->tbl_hdr;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+       int dev_var =3D adev->pdev->device & 0xF;
+       uint32_t vram_type =3D adev->gmc.vram_type;
        int res;

        if (amdgpu_ras_smu_eeprom_supported(adev))
@@ -1594,6 +1596,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control)
                return amdgpu_ras_eeprom_reset_table(control);
        }

+       if (!(adev->flags & AMD_IS_APU) && (dev_var =3D=3D 0x5) &&
+           (vram_type =3D=3D AMDGPU_VRAM_TYPE_HBM3E) &&
+           (hdr->version < RAS_TABLE_VER_V3)) {
+               return amdgpu_ras_eeprom_reset_table(control);
+       }
+
        switch (hdr->version) {
        case RAS_TABLE_VER_V2_1:
        case RAS_TABLE_VER_V3:
--
2.34.1

