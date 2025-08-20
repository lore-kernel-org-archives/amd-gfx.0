Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79F2CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 01:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D55710E238;
	Wed, 20 Aug 2025 01:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3T7UmiaA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3224D10E238
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 01:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIaJY8RHXy+C5u2BXnmWFfNHBYQ0/mhpDkgR3NT4+C66Y3uk01NFgtXWsvMF9lD9m7XN00+1NRalO0Jltx2diHcKrNImm2nn7CfMppBUxIDEsml6fFGPzW3ObZ3BP0gkhQhKQJeMPdCCkEJsPRsXPBHcmUDkXAgHay7F00N2BBkZZmlSEH/1FW4EIj95bDn10FWQZ8nE/HgO4kOgw+NcMB/YkdEng4PlD0i6U7lACBV5j/1v7FEk70jqvVnC4ds8mFUnyTomxN+rb7mxH3SXaS+grT+Hrg94hFqHeTdOUNhpGkwRfTOilcIgwTlepsdRtVS6A7vF8JjPjZH6+lvveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zgnHPR9nlnyd7fBtTEivW1lG4xBUk96qqczEFqKt5E=;
 b=XGikV0VLVK28zb2IHkp5wdCztvl7tTeXXSn6cvPbAmvqvhPihwO5bht6CmoRqdaxYfo/6LrVmFHF+7VHi6Dhh6WOntISu/ti2ndNYTnqxCWsu6+dFa4ueZCI4J66etssg4xnSkHavyElCX/QPaY4a4SPUceBJNAdYnlkX6CnNub8/kweIgV4BX7RwYWVCitom9cuyfjZc6qSLS05f5czDMVo+Jx+7EXp8Pb1+pQyH1A2DHL7mxFPlgYmHpuSz0Lmcq6/wjDX9bmgoJb7bB5FmA+uRwKATNoyD711M4kAMgvv9kH9L/Gs60eW0S2jGB5GStpxkxYQfZ7vJVPZ0N8RHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zgnHPR9nlnyd7fBtTEivW1lG4xBUk96qqczEFqKt5E=;
 b=3T7UmiaA7hS0DlXdbpazoUbEuEIf+ZoZwcZtKEvxx5dY6HTrc2z+8SKSpWqcyxvCJ+rn5xdFt+CALMJpmPPDitZVudGy58XeHqCNs9VYAAegDH2VChIsFHb7KoL+ZrAhaCIAGgfrCPkxJZ9ut3jKkBOwEeZW6NaXbcpC8HXqyD8=
Received: from BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Wed, 20 Aug
 2025 01:39:29 +0000
Received: from BY5PR12MB4212.namprd12.prod.outlook.com
 ([fe80::c03b:dbbb:7472:fb15]) by BY5PR12MB4212.namprd12.prod.outlook.com
 ([fe80::c03b:dbbb:7472:fb15%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 01:39:28 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Topic: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Index: AQHcEMnHMj5tLlfb7EKFsgXMGo+VLLRqwuAA
Date: Wed, 20 Aug 2025 01:39:28 +0000
Message-ID: <BY5PR12MB42125F685673D0BDF0ADECBDFC33A@BY5PR12MB4212.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
 <20250819052548.124897-2-xiang.liu@amd.com>
In-Reply-To: <20250819052548.124897-2-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T01:32:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4212:EE_|PH7PR12MB6860:EE_
x-ms-office365-filtering-correlation-id: 078eeef4-93ad-4908-fc8e-08dddf8a6740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vAntsRqftmBsd9n27PI45NahaoRMrqYpSMoR23LZQrCWwBZlAwAaaisLnfOa?=
 =?us-ascii?Q?L9PRXdomm0TXKYwNROeelZcpyNLmW9od1DA7/wfssTI9OCw9yOKojB4tNf1G?=
 =?us-ascii?Q?lPT7bxxYHZqx/ATZtByxsxHdKDL0D8JPmqWWDjRBbWj5ZBE9Ggd3OQve+ZyU?=
 =?us-ascii?Q?UJQaFjLeXqE8DPms4Np4hs7zuFgjs2JUnCn40005IfxYC30JMwiKyJ6Or/nl?=
 =?us-ascii?Q?VhsnvwhbjBnKd6SQA6/TJRMtH87r+aDOR5p5gq7rcx/eiqj/gdQnGb/5t438?=
 =?us-ascii?Q?oYSwQn4zbitO/I1kvVbEfc7POM5BZwUjaISMQncPdAQL9rpHxvRpFQtfpFDj?=
 =?us-ascii?Q?aT8RaJCcRw7DJ+qSxbHVWJK16PHH4jmlcNNpHtGO96NsOc511/fk3rtiAZfH?=
 =?us-ascii?Q?5nLSTlpY6qx6GzY3OkJ0dirf+IFBKpCc35Uc/JaexdyoqK4GaOq9es7nPRUS?=
 =?us-ascii?Q?czEqJz0uKdwHRyyMRjrPoh7xexMzjvdixx84+G21Lx2JAuv/1X8O+DL3HL1D?=
 =?us-ascii?Q?sZljrUejDB2psbJmqZV4XMjCpC3I/O0XPz/tHQxqIn1FBhVphh9qpB/L+Dyq?=
 =?us-ascii?Q?H5pJNfyGCkuNz9YI7vGVPexjjVkEM32x3ZdLzzHzLqHyydzTbhC96PjbG55w?=
 =?us-ascii?Q?Wijhi+T3m2ZZcFTt7OLerziHfgY6SB2OEQaWAFx/ug3TKwpQpc2UOGsIIyu7?=
 =?us-ascii?Q?RiTtWpNOYt6U3+8FPAoYTj4VtKnvBQ3EiSBXV/VDNujXhUXmHI9rwu3h2McT?=
 =?us-ascii?Q?VTkuVrELBbQMFyyeh25AjehOtR4AIsArE0MmLBanL2+OjCfSJnIBVGm9+h1E?=
 =?us-ascii?Q?MF92as5uTRUU3EGYb9rKFYO7eFVr4OZLyP0zJuZhN2c6Mw1G5+HD838CBWkm?=
 =?us-ascii?Q?ROaWtVQCH0dZdba8MQiVj4gngrrnHpCgowApCm7SFRWL6IGn2DAAVzymSuTV?=
 =?us-ascii?Q?J61HlLjnyIrxTf9/FQGt4l1HyDIGfckEm/gYbq+CZk7yIP+R84zpK1gHgzhC?=
 =?us-ascii?Q?zmp+XxyjCafQSFIQC6DIq1mpMWWz8fGZLlVohptjHSwdLBjAC0e9ib+4q6FL?=
 =?us-ascii?Q?exg72sD/yeKqM96TpPh8j3sXEh/hDQ5RN5BAGjkHxcUoAau2he9E+7MYnVJK?=
 =?us-ascii?Q?QTPgeIU8ofQwXD7Jdq2L5yrTwz2ygop9pzuEPA1q2QdN/dPTdxDx3eoBVzr5?=
 =?us-ascii?Q?BYZ82xGn8V1y8d5BnxS6MJr/PEr9js2rRFIMZr7RewyFHA9boflM+l9zLKzZ?=
 =?us-ascii?Q?MFXlp48HWb2qkrZqQxvgtbePPAwzAGA675eSQSPOjHDJg3Wnu1+dwhrMTcNf?=
 =?us-ascii?Q?MOphtj+T7A4Bhh01/DIwmn3uftj6bweQWSfK86qJ4mUuTD/vQu1SbPgMu7b2?=
 =?us-ascii?Q?OQHXqlk95RKYbSCxd9M4xsfSE+pJMYi2v7gqn8du+nz9NAC4sqZLWgTkcz0W?=
 =?us-ascii?Q?0IkhHq4lApO12LiYgX4AODpxWOvqU8g4ifhDGj1MBW0tLtk0aZoiAlbx+XH4?=
 =?us-ascii?Q?uQOTg4tQfGce894=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kkxj6c5E5WVoSuKG1uDrPLIe99goZyK0c19H8gVDvrHhNFkey5DnDyxsnbxJ?=
 =?us-ascii?Q?8aFNz22y96hmXLkyfks8Bq6C2D6dfE9Zjn2LPF1XBcKEjxP6amS0uEsJJvLD?=
 =?us-ascii?Q?eE5rePIaf3KFGbR96+7NYzhUfbyjvwlq5K3jdmYhIktl+nK7Sa1P0IgIiR98?=
 =?us-ascii?Q?iRSqksV2xh49xOEv+dMqf/QRNgdiPaZuec8KOd28fguprPnLbZXY6gJzq/j3?=
 =?us-ascii?Q?YAyCrOTH542q7nW3t3ebESo9MR1egY3cCrOINeya/h+ype5a3atIQPDp9ZPV?=
 =?us-ascii?Q?QmauVeB+SJZ1q0FyUEE88mvrq/ICaAMDTkpiUr1gq/iMfTvO0/mfmbWAR+oy?=
 =?us-ascii?Q?LystTAV/Lyfej+zAlrXv9EtuyH/qnxCVwHXaChpJxhA8ZAuO2E4Op2IZScDN?=
 =?us-ascii?Q?vWlFvVoF1GSYE0vAtP79lEzp0NF3r2f4e9FlFcINmyK3NGvPuRPt050YXb89?=
 =?us-ascii?Q?bjBvL110QRmpyX5Ci9m7NsekNZUewi0b8stCUROa9ShYkgUL/NUyjOiMQeYg?=
 =?us-ascii?Q?im1khK2wKHq6/6emt86pEEOBFqJHc26IDvjTrl4GbcxcYO4KSMPaoXKZNyKY?=
 =?us-ascii?Q?B18BejvrUR7+1fe4SJ4P9ZS9PVHgzcS8FY+q5yxIGb8T+nCIXh/R/oK5M6fH?=
 =?us-ascii?Q?MEYSs7Rt6lNWdYqoR77F95g0Kkkovbu4sEdJE8EJpzy9XC9m9zF7O+uhZRc0?=
 =?us-ascii?Q?AWB7c7ktU3knZtYVFCLKpOnGErfQXveEKmnH38BgoowqE6/8CCDZBnPIwFnZ?=
 =?us-ascii?Q?64E8oLnvKVjxPKNcPoHp/9zwjZEKvAmCQ3mPukaNrnxQ3EppUEsLDfQMysvy?=
 =?us-ascii?Q?wK6FBh+7hDAOgzWgb9gqtQ7/vwS3uv511Z84iHK5yfw9+52UpsEQzTToxTCw?=
 =?us-ascii?Q?CIl+05jGBbInh+e7KiE6H0yU+MhXQGwR3X7UJtc3yB4ymrpZYooU8TW/0jq5?=
 =?us-ascii?Q?3z6OHCWXN5Ro3KR1ZsBapC1fGWK01WriIK9VwKxV8Rwiwq0QH5kCZapHuHEF?=
 =?us-ascii?Q?T2oOZot+wt0T4+RSAGgajvqMEBBiyZjo6zkpRl8N+z5UCbVrJA6e1xkWHXXw?=
 =?us-ascii?Q?dZctP6sA0TlZj49HbMVHC+PA1n7H4VTgDNlLh/JI4/XyDS3g+mY6Xo4mE0WP?=
 =?us-ascii?Q?yUc32N4UDFFX1+tYhLA4Kla6OhLwggH5p62oNQCM1EPqT5cfCYNBay5hm7A6?=
 =?us-ascii?Q?fHjiTj6sdR1azaddNz4y9Ohr2tX+ZeXQlmRrIizDsyxzIMRBIK1THLF5e+No?=
 =?us-ascii?Q?XTvRVl3A65sfqK/XHDYMC2TFXGreHYA/T/6ro0vh8Onl57pjwg9WUvxkOqMv?=
 =?us-ascii?Q?NyqvwkxTxHWEDrdutVxYCWac6Hk5Dn94PqLFecVROc4VPjx57mJuFRximlGE?=
 =?us-ascii?Q?ZZABi+dJhdyaiFmXaT55o60/1XBBoV/xOYj1tks9JcL2TJhzlTgLzf0uDRmx?=
 =?us-ascii?Q?/zRwfJ3K0NDH4MUcpQDqciZ5xdMRX6UqCNGTWQ364Jj77N90U4ajvSUp6WYd?=
 =?us-ascii?Q?2gMWI3zTb0pIyBzelq2ej8kkXJ5oVv1w9nPATa7GxR2osni8NIuzim5ZQOxM?=
 =?us-ascii?Q?BrKzbbvXJmRcr8madTU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078eeef4-93ad-4908-fc8e-08dddf8a6740
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 01:39:28.7183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNJ4wx/BSQHlMEbBSiSIHevckxzzexJqUoBY5HeXuz7vp6KQLLWwwwhvguFTN8X+pXJ4NLlxDPFptwH3DxsiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, August 19, 2025 1:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection

Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b00cbb927ca8..6730de574fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,
        struct amdgpu_vram_block_info blk_info;
        uint64_t page_pfns[32] =3D {0};
        int i, ret, count;
+       bool hit =3D false;

        if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
                return 0;

+       if (amdgpu_sriov_vf(adev)) {
+               if (amdgpu_virt_check_vf_critical_region(adev, address, &hi=
t))
+                       return -EPERM;
+               return hit ? -EACCES : 0;

[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,
          The VF critical address regions of guest may be also need to be c=
hecked.

+       }
+
        if ((address >=3D adev->gmc.mc_vram_size) ||
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
                return -EFAULT;
--
2.34.1

