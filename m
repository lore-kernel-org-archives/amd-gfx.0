Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6E9D4921C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 05:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62CF010E5B1;
	Tue, 19 Nov 2024 05:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RrARE1x4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A0910E16D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 05:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPTosBR6rkHD5e90wCQLNfE3kY6m4i+yInxgRXMz1Gti8o3n4h8te8Vx1yWmLvZi29LOtED8S1M9B8ohFZ6H/o+cCH+aNFfuRZikGW+IsUD0Xbhd8nQlT2+h7srLM5LaWzEkD4uZXQD0aH0un3jh3RfiBOS04eqki8SY5leoxoE8nQoy5c33iclxuFqmZf7Z8OzDjm3zbIVch6UxNwqj+efTAJ8dpg6RFn2j8u48L8ZRv28dxgYdi9X+9JGQs+faUoIAg6f8M+1nqROT99c3Etgqso72EfoHUxMbMn/UPx1gHKwvKaNwSCo/nsclx1808fE3fW97k5YnLdYAPPIv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6r8cldXLeofu/vyNYUrKeaDF4JIFWtKWaPCe80WXfQ=;
 b=hAPh7ofADJZHmcRKJp+RYesgJnUmvRveyEyiJJuN/QjC8oPZFW97nijBJFaRP/5C1xIyw6d6m7f0R8nZXx51yxUUsIj3TnsIu9NLZgKP8/MKgSIqIsadOmKLTxe3XvXV6zgCWlBK1CsNFQqQF9vI++WlhFH3UeP8dcVaa2FaltUaqijgjLLWL4BYlke/Tq8xkRpMSYyjEqBdRGocv9J1yFECddifyPb878vpSPnHVAtUmpPEky+BeYakhcvA/zfvNqUq7wkBPBiLsitJ709PVUgKXegI9NoFFDs/YePVHJLelMuumVdlT9PFYuESH2iQTa8Y+P1u1aQFyNXayVs4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6r8cldXLeofu/vyNYUrKeaDF4JIFWtKWaPCe80WXfQ=;
 b=RrARE1x4WeNAyMB4BOdhVMpey3sQpK0O/qmIca165VudzM9YMyYmlkT3E8/XzoG5w8R02QkKuXka2X6a9e5ZRe3tl5L4GMvbfwklu/+BTSHA2eQuroIvj7o9/R//hEapzHuPxrXQ/ILZEMw359I8GY5ZrDw1tUkYktuxkCU5zr0=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 05:56:14 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 05:56:14 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: disable pcie speed switching on Intel
 platform for smu v14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: disable pcie speed switching on Intel
 platform for smu v14.0.2/3
Thread-Index: AQHbOZBy/xsqPph1/UOjJRX8l7MYRLK8uZ1A
Date: Tue, 19 Nov 2024 05:56:14 +0000
Message-ID: <DM4PR12MB60123F723733D36E73C4905482202@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20241118080114.428845-1-kenneth.feng@amd.com>
In-Reply-To: <20241118080114.428845-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bd72f81c-6da9-48a2-875b-445c09a7086f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-18T08:46:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|DS0PR12MB8247:EE_
x-ms-office365-filtering-correlation-id: 09c67aff-67b3-4516-685d-08dd085ee073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hFnxS2wGex28aPsPCXDAEzQr7WOSDPW0e3L+EKUayIZXcvg9qO+9PwSPgeOu?=
 =?us-ascii?Q?4n+aLo+wCbHl6VZ8qsobL3+vVWnk+KZ/GstlIHMEF2srRoggC06kBssnXCeO?=
 =?us-ascii?Q?55p6BBPbvtUcFpR8OsDYVHJGvLajKZxvvzjct/8Y55/uLQl34fOrRj4c1XaL?=
 =?us-ascii?Q?Knic6Wis49cnyW6AGB+edfCcGtjqP/FBo2oI+AHiacsoVonJJ/nZ94UBXDMl?=
 =?us-ascii?Q?0UY5I/5gyZt42kSpCfoLYPxYlcjv3G3Oz3gv9/CCvVPeyJetzZawHqf4OY++?=
 =?us-ascii?Q?QYlGFkZiWo6M0o/AeAZLxwL+hdHdgOfvY7TY5ziQFET3ByCGdR/hohNIJsuP?=
 =?us-ascii?Q?uDElGOlb36/MDqqdXe4G7iGaB6wvTdik8Ht8o1w9UR1aB7qGNgsm481dwxne?=
 =?us-ascii?Q?9FcQl5b0XJjWhVNQg31r4Lirk0hq+jv1OniyBTJ4fY4PMS0F1qnUgbTstv9F?=
 =?us-ascii?Q?NYq8M2oWYl8vI0e9hGubdvKMZ/gWv1BdRTdVPX6bhoYS6v8/2Srxh/r2hIon?=
 =?us-ascii?Q?lBBwtqLlM7xkWvEDZOFe3C2kIHohQWXbBnnGMeHWeL5REfIV5af3i9AW6Q0g?=
 =?us-ascii?Q?r2yR7XG2+Yw9XeZFwTfaciSRZhrM+V3d5p57+RY33xNwTE3DNZqBxyPK/6zk?=
 =?us-ascii?Q?aNC7+Db0FwOwgvpsMJOSVzAzPYzNODNMzzqFZAYnCFh+Vk/iCx4mwcRazfjl?=
 =?us-ascii?Q?BLX66wBotDg/9QSySLRbMLs2h1gIUMhzv9yRvj5MlyU6PsJoKkI3lux7nrbq?=
 =?us-ascii?Q?diqqlhpSmcf0vELuVlYg0Ut7BnmzHnCCOiHu/VcbqAX3ZO4t92Y4OYP3KNCH?=
 =?us-ascii?Q?M96YucOvRadQnMS1xpF+et9rkVETNZuVXxb4ya35qJaXlDiGx/C5ny8q2Z3t?=
 =?us-ascii?Q?KA1+9kJr4ktei+cAyBJ4WZ+tthm/RgiI15hjaCeh8C4dIgQvmc+CYSXUI5z8?=
 =?us-ascii?Q?DQxVUDukIP7D9cjXNtuHTfGr/Hwve/jOv+uYe/f4YL2Bn1i/Fw6O3u7K82J7?=
 =?us-ascii?Q?BE8ihi41QtGcA/plIRg+avqptReiB294PAschVg1tiwlDJyEEblc7AQoP1Q4?=
 =?us-ascii?Q?HenzIxpnGSpLaMDN3RniB113NSakJfJ7QXWw67dP6OMf/7ndNq5nVZiprJzf?=
 =?us-ascii?Q?fw0FyZAQJlQ/e6IcBXM06Pe+p/81Iz9zk6GKkMhKBQFlLnTk+jyUT8RRzC91?=
 =?us-ascii?Q?EJxMllsR3mJXye3rQAvhMByM9MUUJV8OU64o24rbVrMarHkK8t3QZh915RUa?=
 =?us-ascii?Q?hY0rk5fJx080xUOrwATb9riEacj+ALyBPWTN6KFv/eW4/0b9/f/oZI39pNyl?=
 =?us-ascii?Q?CsjcnKumLbtWwWkP0KbsOLKlqmel15erIgLwUyytguKDifwSArVLA6TXaXqE?=
 =?us-ascii?Q?Q3t3WlE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/J4+Qp8tk9+e4MTbSqlSwOcp8irdPaUqVcS83VcvRHq9WOX8uhVa6VBDfpkI?=
 =?us-ascii?Q?MPy2nK2EWdpa+0sHuCK1ZmkKvVNeHonNbn1D+UHdAMdmBiddS+2ALNCzIXbx?=
 =?us-ascii?Q?qrB0ukBpH1L8OiuOtiMQ+oB98eY3KqT8hla5M5FJ6PSax0lUcKjZp8J+I4c+?=
 =?us-ascii?Q?pb5HQJehhfX5kqlBa6530olIr7lMFuYhOa5DN8sM8s8JxqdYicY1j8P/egvw?=
 =?us-ascii?Q?jJQJcjCqcKf6OENPZKTZUz1x0x6kbGeHK6iARzH712YlW3XKNXZw0HnviXhm?=
 =?us-ascii?Q?FMA64wX00/mok/tWJrTPEBNtascR8+QLpk0FD4nuGDL1WePjN8gUHJkb2xF9?=
 =?us-ascii?Q?m5smjAkWFeOMvy6Ed1ivLzd5aSe/PxEnRo72fL3NOQ5ihc5lGSDsQpTLOa9z?=
 =?us-ascii?Q?hPwRDw7u+eHtShEe1ebu9+XriifRzBXvzk0r16aY+mdECvTFr7NKrKNA+LLx?=
 =?us-ascii?Q?ATnOJVI89ibqRpm09AIywBKQoOIaKO62Vc3id2cbZ3wxK2l+Ysv+XAk082Wg?=
 =?us-ascii?Q?gNFvexxe+fsFl0jeOnJgaDEkodDZ0XCiT6PbJojjd4J3wdly02DvYSsWk2H7?=
 =?us-ascii?Q?FJEbvD1kWJX8EF8twONAhImu+L+NXxvV9DL17epd9uBVP/VwFsJLkFPmc4C7?=
 =?us-ascii?Q?wpaBBn1zq6IzqrQfwwKaRGYjZlGIlEb7AzwIgcTQ6uXGfDYVVi4CisHIZeoD?=
 =?us-ascii?Q?3sn9N8H7gR1LUR+RrRGtEat34Sfw2Vj6XkKA4oci9fr4UcowQRN6k/moYeLQ?=
 =?us-ascii?Q?PpFFU7mJRO8LKTcI+K5J63r3Z5jtFjVFFlkEMcH1E/c7OGWgxNy0guQH4KuG?=
 =?us-ascii?Q?9axKufLccgJydHM63ZuPXIWQPTZUNIvoHmMciXRrdhHi7D0ZbTRWPergeM5t?=
 =?us-ascii?Q?JtYUlB5sWzj3Hfh0pZbFHXEEG5lwdkKd0CdfxVWGp0vNN/pvE2rXo36hrKfS?=
 =?us-ascii?Q?nzSG4BT2IZ2csuuZrYNWpZL3RYoHVCXjbXcJmL7rUk3ZykZoSBJY1WEb4qVR?=
 =?us-ascii?Q?oQ2Pm/zrV11xOYpzYMyRnc6FXXzOAcQl45HtOOHY6J+mmODiK1ldd7FrFPSI?=
 =?us-ascii?Q?S57+naBJJ5VHEkL2a+gwzGI0GFcNUPHxC1v/uvbcv9ohXfB+fvBSTOv0NOnC?=
 =?us-ascii?Q?CjCNN5CGWWsMCHZyCZyiCmizZ5vqsB5u6si4awsO1X2Rfuc6xJ/i6R8xmniu?=
 =?us-ascii?Q?6/L5cbYC+eCwC31Mfwr8CpgFHO2WsESU48l2LDiHj0cTdhg8BKznhIDt7r8d?=
 =?us-ascii?Q?fz0U1d7funJ+nVurb7lH8W3DEOhNR27RkkR0a2C3+oCM8EdTmOP6lv8SIJI2?=
 =?us-ascii?Q?xfQI060flJ8CiAe8l8BFziNNPUqQmRYz8rW77+Ng0UtLhcV+g9Ws3cwiwJq1?=
 =?us-ascii?Q?Jn67UsoO2Gq8l8PeMq2PgUknACg3BD7GraWhGoObK+SL+YmypU023UGINSJp?=
 =?us-ascii?Q?dVu1dHUawdz0Zs9K8ZMcJJVhu2dED99+D0Ud1LVSxVG6+Zx0Uoq/mU6Ja15e?=
 =?us-ascii?Q?rC5Vi1qbLwFl71GaVqj9kOwpSFgi5LT+TVNcg39riuY/HpI/UFbEoPOUSEvF?=
 =?us-ascii?Q?hOL8RjVd3UQMewAlaFU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c67aff-67b3-4516-685d-08dd085ee073
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 05:56:14.1573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1M7IzSRUVjZzXIQ4X+NGdrWFgUQrpkzd8GpHmwjBJBlYvV2a077ngWybVGDMAlp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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

Acked-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Monday, November 18, 2024 16:01
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: disable pcie speed switching on Intel platform=
 for smu v14.0.2/3

disable pcie speed switching on Intel platform for smu v14.0.2/3 based on I=
ntel's requirement.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..337d3312ef30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1472,6 +1472,14 @@ static int smu_v14_0_2_update_pcie_parameters(struct=
 smu_context *smu,
                if (pcie_table->pcie_lane[i] > pcie_width_cap)
                        pcie_table->pcie_lane[i] =3D pcie_width_cap;

+               if (i < pcie_table->num_of_link_levels - 1 &&
+                       !(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
+                       if (pcie_table->pcie_gen[i] < pcie_gen_cap)
+                               pcie_table->pcie_gen[i] =3D pcie_gen_cap;
+                       if (pcie_table->pcie_lane[i] < pcie_width_cap)
+                               pcie_table->pcie_lane[i] =3D pcie_width_cap=
;
+               }
+
                smu_pcie_arg =3D i << 16;
                smu_pcie_arg |=3D pcie_table->pcie_gen[i] << 8;
                smu_pcie_arg |=3D pcie_table->pcie_lane[i];
--
2.34.1

