Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E107C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 05:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EEF10E07A;
	Tue,  5 Aug 2025 05:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mp+/e3st";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C4910E07A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 05:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOg0AogpIh0rauZWsj8gyAhUsueRiLRIBNV7Dy+x/gxdvhFdhzP4vAOjFIZj86r62suiJFUJqGEUt33nwyCYRm+L6Nqwth0fkgqkYmlh6v7OcRuWsLsFwhB0YPWxBLHwLOpgzguvObTUV8+vNxfedtDYEmb2oFsWcjmB0XLu4LmNdFE9tRgVk0H8pxvg1XViCa1RNBSOgw0HX05XusKOAL7gL8ybPMOVbsL0Tn/HzH4APq3sfe7mzLDLWX04iXIOpRBfGx46YDNpAFEhXWyjSLrHXhdnP6CsCdrvHukoHgbGW44w9PG8APk3triFDB9zYfKTvnymaDqy9a1VwsD/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntsTzHQ1nc7220stjvYYYp9KA+eENXR6xZ6wwGfrzC0=;
 b=fsn5NDIsqMFnY1SZcMBMcgEc3EdgrZ4S/AYm15jabJL343+keGTryUYum/yBa+9ANQwFTkQG+2a0Dq+dnKkbd9AXrWSrnXR8cg1TyaJhbCdA1ZJicm7wOpyxKn3gmC4eP4ao9O+9KoyRfMDpL11s70AJ+8E5J60Kgg5K2idAew14KTomKj6eGQPRLcQ7JpIcag2mniYFRvIKc6XvfURxssdf57gsi0scIR3gNecxq/rIge+6SpTNy0yd0GggaR1GZK3iFD1x4WYjzMSpCJdw2fImurLULcgXzqLV+uPzLJOPt5g5gm7xsn9RkOd6gmQvcVxUXqO2UmPAgiPjbbVPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntsTzHQ1nc7220stjvYYYp9KA+eENXR6xZ6wwGfrzC0=;
 b=mp+/e3st8WH1In+P5rRMt3Ni80fIcdK0sImWoJoR3kRVRFEE+w8y0n5nbHSueWhCf7/+G5NJ+6+mS+fGNvd8BU+FOKCVsX4uBd6VmLEBgOweYooxUSb7Ue60AS2U5EKhK0G4+Yo9ZawycAvC5CIPQZ5SAEhSmXWoi9I1E6Nn8lA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 05:43:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 05:43:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Generate BP threshold exceed CPER once
 threshold exceeded
Thread-Topic: [PATCH] drm/amdgpu: Generate BP threshold exceed CPER once
 threshold exceeded
Thread-Index: AQHcBbtBrGJY2dsdnUCj8l1R74kRkrRTjB2w
Date: Tue, 5 Aug 2025 05:43:28 +0000
Message-ID: <BN9PR12MB525714C576F42849B84E873BFC22A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250805034413.102087-1-xiang.liu@amd.com>
In-Reply-To: <20250805034413.102087-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-05T05:42:53.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7827:EE_
x-ms-office365-filtering-correlation-id: 6a142d54-eaf9-4ea3-33c9-08ddd3e300d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mQkIz1TByRQb9Ur+qHL3aQ6UyI3R5ULSIB91KqVwjkt7PnVZNp+V6CsFwn9M?=
 =?us-ascii?Q?sJkG4Kx0UJkcwwi+6Qyu3hdr2WfBJ2dXc1gm1/he8H/5Ip6SB3yzGag7lH2C?=
 =?us-ascii?Q?A7IGV+Uv+fhc/NEnv2OU6V47OrL12hQpfNqbJGRyTMuRhP8j/DhYxbacG0JN?=
 =?us-ascii?Q?Cbo4MouVD5JYrnP80dGhwuUETiJBYgDGWivrtkpxTF4rPtbpN20NE5tM5EKR?=
 =?us-ascii?Q?H04/ahJ340DNXJYKKDkTTa+gnhBVA3q4v0SA1iRbTo/qHTaFoU5yK2Y1ug+c?=
 =?us-ascii?Q?RAJ30cMU0F33/cf+O3toQcy/zDpfpOo+fCSsiQ+mU8NJ8qj+CsxtNsIWjUHS?=
 =?us-ascii?Q?hFPXdmcN4lhgLctdImEXJOaJIb4IgZdtHE6GupN8dgXlaIjEa7Kf7+h3D2mO?=
 =?us-ascii?Q?hmF8Kx0u9pcf3td/+brMbxWc7Mfs6wMti6Y6psUkwzpuLnRkZuY3Bzs2CTJ0?=
 =?us-ascii?Q?r6ZYKasPD/kXiDEswOKpWihJjJJmygXjtzYbn2EorbrX2Z3cifGzUc3DJXv9?=
 =?us-ascii?Q?45wUJY6O7aEfRLw5rRTU5h4ZdBnNJw6LIw92ILzghZQRhS+xodpkfKVMhtNE?=
 =?us-ascii?Q?h+dwh14c/E/uJ3PqXrH9F6at0Wg60bmTQhMmJ6QD1tPswqjlLUwnxjmNULvm?=
 =?us-ascii?Q?DtcJezubkOfgTwPUWZxhzvK7ebFl0GijfazmJ+LXW34cdSomh/fdMSTrfkX2?=
 =?us-ascii?Q?31AyY55/WYfY/AWqf/SPC5r1/NcIPTWZ8XAcSwkIeSg4BanQ4zWoln1M3M/4?=
 =?us-ascii?Q?T94twif7Msoax8Ojcl6r6ky87VQd4kRzD1wstliuTTI1JuTqRY2Zr5cHNFgv?=
 =?us-ascii?Q?Tokl199S13FijCe0GfJmGT08MQtL4PJy1/x/QxEUe8AHJgPWjEq7rXptKJPT?=
 =?us-ascii?Q?/HFoxCgD/NFbSroqg+ewGRxW0Uw4CQoqXLZ3j+zuZ4TSrLSgAoRnxG7Ukkv+?=
 =?us-ascii?Q?53EagpdFyP38zwdKvXAFNm2vl/7OIqv7e7zcgnqWqdUd/yL94k8+QDlRM3st?=
 =?us-ascii?Q?nlzC+7HvrQXfc2GJZmoNQmchywqOhMzJeFnxLHrDbtIjX8mrxQD8oo5+daWj?=
 =?us-ascii?Q?ynJgyIjbAfFEYlB00d78NX1WhXRtlXKD6KDoHsNjUwEJSwzt/RTF7XMnfHk9?=
 =?us-ascii?Q?yVg6XefxbmTpbiUkcFCmnSX0nWcZnIIwqnpY8qABK4mt0g4fwi4NyBgHAYu+?=
 =?us-ascii?Q?haMFDZ64afSNHv47yMokBFwVBoAWwFy61ZNxIbbEKvDf0vuZOv/l1LSgpdeT?=
 =?us-ascii?Q?HV9CiSJ+A/M+xm02CgR7RiW6nqWH6nM6nzp46YZAXxdVw+RB/UCRfqIAraCT?=
 =?us-ascii?Q?zEGdhnFUJslbgmU3Tgh6ABOjqSVQaaZJPpGQT0/yW8V1/XckkTpkLQW02bsb?=
 =?us-ascii?Q?ZbUqOO7Z7ymdF9hMuUsciJSK7s263ZJnMUxSZL0u5WppD2CohyAvMdtuS9aH?=
 =?us-ascii?Q?oF9skBt2C4dSGYyL8oClnw3slgR8EtnvbfQT0c9G7R/pG08v2iQA1VaRUVJX?=
 =?us-ascii?Q?5GuH19w4ooZMYu4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RGJ9MihR9a1j1/HqJPWK5aDvwk9+CcfC5I+voz+Xg002EjIc6vAGGPEFTkB0?=
 =?us-ascii?Q?Fk2+uWDyGgogQ9gFY8WbKgvW4+2Oop1T35VF+IyXp1ZdcQyn5xDREnNadxYR?=
 =?us-ascii?Q?TeygmBOP2/70vCAH0Wn++KcpVpGA9v9JYUOL4jV0hGmfnUifC5fRcSOdLL3n?=
 =?us-ascii?Q?w3xxnItFN+ZhhLRrZfdmyceWo6HnRhpriYn5jPrYDGNNO8nLaGBAY6p2UI2K?=
 =?us-ascii?Q?CczDRCJ9LDcrdPHmH/mPgEjytoKJ+asXndqVTDQvONy7hADz+e07DRFUrk/Z?=
 =?us-ascii?Q?GnfrDUeS3DQg3QrkfQzrLPipo/tfVpuXgTGCw8Im/3+/wCnlRZtAQyUxORx/?=
 =?us-ascii?Q?YeOQrU3q1OxRxYvd3xIj5uWl9XmexCitXsuopwupWK2zhmlYRUcg9Up9EAcY?=
 =?us-ascii?Q?jaVt7abmvZCPVLMNfWfHHIRpPqLOPpw9gDeEoPSPob4sIu+aNwzD6MSUChZx?=
 =?us-ascii?Q?fRl85Z0R11l0bA7d6mvt/H7unmckahGkbIpAgesEFMyj288tGJ5sAKSW5n1s?=
 =?us-ascii?Q?i8EKaGfTKFAeMvUKLxDkjZ+mKkoObscLKL7hi+gbkCVmVlnEO/jTRbFUCx78?=
 =?us-ascii?Q?/DgxZYUUM5m6XQsnqhI9gcUTUSTSKVTIC5rH91rUNHvi7ANXse/n2P7GhMbh?=
 =?us-ascii?Q?9e9H4YXt1BTc7nWGnDODEJ9kdAo+DYExkZNVyfBODD/X+k3JaeG7VednMvG1?=
 =?us-ascii?Q?xPz9xEGguunc8Tac7zettmaRDE8djiPmwsLMX8hlMutYBRQ6geSlIZ98VTgm?=
 =?us-ascii?Q?WbbX+NoibS2H3Y3wgmt6oJpp/hMJdQvV9RQP1U4VeyRHQNfKaClvGj/VAIey?=
 =?us-ascii?Q?dmpwIjKeBQ7k7zURcSu8X58ucgUAqU3dDxs0l0rDmMz3CBeC862Efx/vzeVm?=
 =?us-ascii?Q?0/d/HXDJZ8nIT1geWTNlvGKK5WLGPqFojR+Sq7+hPoFwEG0SKTqdCiE4+HZS?=
 =?us-ascii?Q?OVI1pUBPFIzqLGvaSevNm5+dXupTcew3j/Mkhqi8fAj5m5/6xw2lObez2Wk5?=
 =?us-ascii?Q?CaRdQAw1m3Na0Si1Mn5drYfoVwmpUeXyNCVZL9EkNuywbea4+XU+wUc3ZGWy?=
 =?us-ascii?Q?cnOAP73kd1sBBCkCGZIIwV5mymiTEGRDFxrUaVyYITT6UvrB0H+SdmeAuSOo?=
 =?us-ascii?Q?ze/sX0wDmRh1KWEWRTpmVy0oH9K3eE6JahTU8rVHzvxh2AuPE9gUgVZ1bnZf?=
 =?us-ascii?Q?KTh3+DUHoCdtZlI2q32hB+d9dX4Euc4ZWvRsBv7sw66kj7qif8oaYNJJsXkp?=
 =?us-ascii?Q?ydgMWfHZiiBvv+tiXdQS+ieVt1ItKMGORWL+WuMpy2jtfmyAr6guCExBdjyi?=
 =?us-ascii?Q?56FiHeQj8xEZrF/SICNd5i+Tz0mcUFtb1ya5JXCFxw4mLVi9TGisXeSyEwsp?=
 =?us-ascii?Q?iKwA7JKSAYrzl5s7ZPCJSgY3eDmW+lxYWTxoOCubhcVWCbh1rEbyheYmR8wO?=
 =?us-ascii?Q?dxpqK01jE/q8oxJrsV+5JYJLTE3ZtRovMH+n4MOJE1DvhdagsujTMWGlJSR7?=
 =?us-ascii?Q?D0G9IUIwXLWUVvegbakq/kTAyiIq+qNGKafLfc5/i3+bd9wN1J5g5GSpfHlf?=
 =?us-ascii?Q?PkCy0h5KAfLXAHz5iZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a142d54-eaf9-4ea3-33c9-08ddd3e300d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 05:43:28.1375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Myfj0qR+scjsrufcY+2Q1QzsrxT5wxDVr4tzxHR/KsT2GbXEslvTi0MecqyKu9JMKnuTIbER8vPRB9wVy0DRFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, August 5, 2025 11:44
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Generate BP threshold exceed CPER once thresho=
ld exceeded

The bad pages threshold exceed CPER should be generated once threshold exce=
eded, no matter the bad_page_threshold setted or not.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index b66e09ad0cc9..e3d7071b5853 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -763,6 +763,10 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepr=
om_control *control)
                dev_warn(adev->dev,
                        "Saved bad pages %d reaches threshold value %d\n",
                        control->ras_num_bad_pages, ras->bad_page_cnt_thres=
hold);
+
+               if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold=
_record(adev))
+                       dev_warn(adev->dev, "fail to generate bad page thre=
shold cper
+records\n");
+
                if ((amdgpu_bad_page_threshold !=3D -1) &&
                    (amdgpu_bad_page_threshold !=3D -2)) {
                        control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD; diff=
 --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgp=
u_dpm.c
index 0d94cc04e322..607e3048eacb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -764,10 +764,6 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *a=
dev)
        ret =3D smu_send_rma_reason(smu);
        mutex_unlock(&adev->pm.mutex);

-       if (adev->cper.enabled)
-               if (amdgpu_cper_generate_bp_threshold_record(adev))
-                       dev_warn(adev->dev, "fail to generate bad page thre=
shold cper records\n");
-
        return ret;
 }

--
2.34.1

