Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEB0E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 01:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9359510E1F3;
	Fri, 13 Dec 2024 01:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tL9uLqAv";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4525110E1F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 01:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQWkhQF/7hyWDYOlwnbIzbcbZDjKmcUbIrqfQzED6GfI0F3pAFkMkJhxWbNsVtBRzdJU52lDsFfCicqvtoiy7vt4fYcOdC3dYREwoOnV3Amz1/fKiaivEzCqONl2zRIaY6pzvtlROUhPvyKprVsn48/x66//Uflbe115FC7lWrJvyfQ5D/sODMbTl1vtYo/yCucZ+9ETWxWEOUdcDy9IJJkr3xKm3TUZjVzmHeK+wnmDMv6t7e8ZMnIFBM6+DOmyc+i+OlNxFVbcIAXwGyMvpLAf9Hzj6HfGDF1MKDXfRr9ZvmbldHmp4Ug5TpzBXM/ZNq91aZJbzzINBXucxT/Xyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRYg2uoDJ8ZviYonjcG+1CMMGRF6j2jG+Febo9n+YM0=;
 b=DleeocMI8SeOawDzKeleECnC2iPLFCn4XgnJwNsbnm3XfUlrUGj+oVx/DAhtaNwFWcl///GJ2fZya3upxRIbWngjh5t6FQLHAIeRwqVCGTmQliEgF9pEE50Gfg96guHsHx+vFNXcZUbxWh5i00o9mYOaCw3BWgCXL8cmTqO19IMK3dr9ln1p49C8n9MPQ4FpwCNKQN+PfECJZKs3KBcbrn5j6Ws91C9i5kPuaiBRYnltjoj594/t1BIpx88pVUPa/J4E4I7y8igMwmVS9q1WJKJEwqrig/AtALcB02nUGrVk63Zzaj6YmSCgScO2fZMDXYObL7ToPfouC099DYJH0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRYg2uoDJ8ZviYonjcG+1CMMGRF6j2jG+Febo9n+YM0=;
 b=tL9uLqAv7jDli02/eNngt8IIW8Wq+29Ek72K2gmxqq5MdD2Ude2ByEkrs31a7x+5oLz/DuwJS52bjCnLNkZShuszbWDTrrTlm9XfxssADFGc7MZCSer5WFpnfBm4y/RT9/O01tpgX1cSy/zIUqZni8+gmaTdZvp6PMfVsUbucus=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 01:14:04 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 01:14:03 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/nbio7.7: fix IP version check
Thread-Topic: [PATCH 1/2] drm/amdgpu/nbio7.7: fix IP version check
Thread-Index: AQHbTOBolYeemEHdz0qId7eQcqWJprLjXq8g
Date: Fri, 13 Dec 2024 01:14:03 +0000
Message-ID: <PH7PR12MB5997CF830FDEAB62DB19953D82382@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241212215352.770069-1-alexander.deucher@amd.com>
In-Reply-To: <20241212215352.770069-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6bfc8e14-fab4-438f-b66e-166aa6b7f3ba;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-13T01:13:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH0PR12MB7885:EE_
x-ms-office365-filtering-correlation-id: 60918633-6051-4224-d4f3-08dd1b136ef7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rD6+Zt03MhHp5zBXmcIMe5tbICkmLQuxrO/L9uB2RiPNttL0kR1ZQtuLfHrj?=
 =?us-ascii?Q?zluZeDwkJ2sW/oX26UpetvMJ5Qspx+LikcjmKUkeRlKwt3HkoVzA5IO2kTXH?=
 =?us-ascii?Q?8VIENoqhXmwigSHbnBUEZs5nPOzHYWDE+9mjhAn29ajiQbc8U9744qt+1DbF?=
 =?us-ascii?Q?LumzF+X1YjPHH16oI7RbfY28Ct1G8Uqjdv36mTqDb9hL1oeEQG2frNCgKYt8?=
 =?us-ascii?Q?0/DJH242OeGsyx0qpdcrCn5+PYxkYiXU30bq4Chm6F8OS8LLT82jQ+RO8J8m?=
 =?us-ascii?Q?bbJGI3vLC3ENbdWzVQWLLwY3SGH7cuKJRxZQZx6sO36L87YJQdTV9S/F8UGK?=
 =?us-ascii?Q?sYp6gQ7pRItETDY43A3fFW48FKAT7axkO0b5X0SvJIyFeln/0lSvV5uabslH?=
 =?us-ascii?Q?o7gF/JTBk2UEBdfeA7oR+1942EER1UiB6di+lHQAkAFQy6RCN6Y6fYCRiIwg?=
 =?us-ascii?Q?KiSjXIEUyK7gDx7EMoBVx+87pXNx2wWn67CS/WJvx22bZu8PRpN9F8vB7oUT?=
 =?us-ascii?Q?wUmwcWpjh4J+R5GV8MYMEjiicn5XJ5qrhxDXTOWDoQ8qJ2oXLBw7DQqoZ+wb?=
 =?us-ascii?Q?KN3QigpDjnW/xGKzyQfOtRzPAQvn3ciKuDq1GPmzknqLKhehaPaCOMzUsCgm?=
 =?us-ascii?Q?7RlT9+2+0L8g65F7e0Aeiw9xQuCENbiZsMTExlHIGF1GEUGgR9sZMoZjsrmC?=
 =?us-ascii?Q?X9c90poXzGRRNZLiT+rLruWbT2DQJO5EdYvVZ4T12XgRIdBOn242EPKlm3CJ?=
 =?us-ascii?Q?AD9c/JVR8rqi3nCePFHq1pwzbFqrBlydBCV1jcpSWHT6/ixuuT68yAHNdMap?=
 =?us-ascii?Q?UQhXq2d/l2BfshkOnkbDtTghVkoKzdub8ssguYInnYYhr8DIGqkr1Cs5rdPk?=
 =?us-ascii?Q?4f1J+RBDeonVGIUEg9+U3HIg3mSfZg7HJgoxBU8bhj9bhzrQQy+IcvwGYrJW?=
 =?us-ascii?Q?U/ajF3/LRGNhPkWLVJuSARpW2ALVWuIEZLbNWLyxHH5lFYWBZ6WFLCmoRbjk?=
 =?us-ascii?Q?jFPZe92nBfff/TJcVu9ShyFZQkROCI4fvuqcpOxkLw0NddOiJs+pyZpvd476?=
 =?us-ascii?Q?g7rrNZiOCJrCZ3hB7hITc74717NpdxnPa885EqS7VBXzZLIKZXf3MCcTrdYP?=
 =?us-ascii?Q?BZ5HQ6n9WFYj+FD+2fjNam9h3h/e1Q4Ep1MM/eDyF2ufFGN+cWRW9um3lxGb?=
 =?us-ascii?Q?xl4UPO4rYB8MpoCBLZoBr8N8an2XgQc3DYIC1EastDIAzmZVmgQfmVghPMr3?=
 =?us-ascii?Q?Uxk+F+I0n7FBSlsYOY2rIgpxG/jV9WM/+6s0rJyFvA1BKTRHtaUBvpj34nkZ?=
 =?us-ascii?Q?6n33Tk4WCyWZQFv2p9S7byhsT7Iip9ngTYAvApxcLtYLhgQ8LRKaMjc9iWO0?=
 =?us-ascii?Q?Qq5+KAcdP3bu6czAqU6KZzVhgBEGPBG8Kj8/ZWOxTJXVISFycA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WsGrxM5gJK+I5zWSehERbiW4I7wOlvCAF3Re3ZeKLPqB2M1aT+IHhC0gM6oS?=
 =?us-ascii?Q?GWxMKu5jgetdKo4zvD/gbhuMpdSUfsdjC+W7c886HJvoa1BIFP2SMxEM2jPw?=
 =?us-ascii?Q?pVxsNHjzMWPEypjrQ/5yUgahRUqvwMO6yorlZGmeZTHfQv1zdlMO+F2RMgN8?=
 =?us-ascii?Q?ulkpNCnNoMJ+dw6mrR4wD8ROb/cWg+t+ec1lWq1PwPDVFljnzca6hptVDy/p?=
 =?us-ascii?Q?vBXaWmHVmJ+cFoPplYxNosEsl2Pot/8GtdAjSJvauieFS+nJZ24KWzNRjSq9?=
 =?us-ascii?Q?3lNsHp9jFxUEIqlaQeRpEJHcZC5fZUxlDOPxYwWv7MxYDIDmv5rEN9ad+KGI?=
 =?us-ascii?Q?neoWdan8NpMJf2v9yJ/RlB8ns7gVVVLdJb4HTYxBRprbw0EXLdFz4y+xKYMV?=
 =?us-ascii?Q?GVCgQ3ie8khZSh6ee7SPYagRheuguPAvMATtocKjErh3LkN7UH+izUjT2bkN?=
 =?us-ascii?Q?/zsAXUELR/4kR0DLRB4FYQ0hPZ4YDpx7SDO93Rx790bof+c2rVZdUrcdrJl5?=
 =?us-ascii?Q?/YXf+A7P+jW7P39HzMq0XLsZGRV6mfOLqnLjI1v0n9S7kEQuzGaLhdpb+FFG?=
 =?us-ascii?Q?weDORVNUXxNnpPBN9JkhExPqiQbzfHAhLfeC+BEZim1zg4FY5weJvdTRqAQE?=
 =?us-ascii?Q?ukbJ2OdjDoDC9QxJ8il6Gdi7GUF8WuhO8p+fs6rYl1Qin7X6GWnsfg4wr5Yv?=
 =?us-ascii?Q?1gPxu5Rw4gIbWU4UColN23bTYnBcJmvtW0asWa0Gx4wAa9Y1ngRzgCGe8+Jf?=
 =?us-ascii?Q?84hHHzobyWW+sJKP/tyWODRbQTnOLie+Mw66WJdO+bNO2jxpzMbqSfJE6alh?=
 =?us-ascii?Q?gNSdBy5RGNLwUtk6zpUoZV76j9Ul6mi7YQXscjVGKmbWaSaB8VkYAACxsCxo?=
 =?us-ascii?Q?mHr8yYSiMwjA2Ud7MQo4X/SLn3V/cqDfqqUyjXMXBEnQFdFgeVGOceeR8FTt?=
 =?us-ascii?Q?eFTfzajh4Zi4YL4h7H3VB8Ll++goS8wIxN4Ohz3Y3SKUL7ny1yyWL4JLmZe0?=
 =?us-ascii?Q?HS5372taRIf/KJnWVeNniUGXclKQz8nr7hyUVg1dkzvi6jxitJQKY5AMU37Y?=
 =?us-ascii?Q?RKBMhb/jfJUw6u5kQHfSd/JB/lokL/4jS6wUMhKM/o8gVo7TnijKOj8NHCQm?=
 =?us-ascii?Q?DUCgs/v/h3Z/vTkeslvaiyGLijLiG3jKhUtPloH0mKVOBS0QCwnCdH2RqGSS?=
 =?us-ascii?Q?VBQVP0ZMHjZYUhi/Uwh7hsPc0YCuQwjCGkhrcHzJl6Dv8GJIWEndBMtdT+h7?=
 =?us-ascii?Q?uBSCPX3/2TtX1lHges/L0dSKx7QmqnRFP1ZkyLgjQHs9kru6Y//I3pPTeC+I?=
 =?us-ascii?Q?+ArxSgaWmSbAzpeoHfhGllymtUf5Dt60I+HjsWdjRDXk3pn4R7yc/18BNSXJ?=
 =?us-ascii?Q?tCERwuH05nOBfnN+8YV69V7Oa9UH1MZ91pJzWzTe2wkyhEpMuTFCLDfusGiv?=
 =?us-ascii?Q?ikesRI4Z7SEzXXmtYstTukxeqCX1Qxj61sP9KNI3InShacJiwOQRg16K8gS8?=
 =?us-ascii?Q?rW06UuX7SuGAYpgeMSXu4DkZOQLLFoyfrp+NE9IjHmjXLLyLvbsZlr0Bfe/0?=
 =?us-ascii?Q?Wso2OADQFlPH57PPOzQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60918633-6051-4224-d4f3-08dd1b136ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 01:14:03.6062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIi4GSMEDT5FDnSJs/EJ1QM+KjMTYWa0j6aragTsMVWIqzV6Q9FCzCwbf17qJJuI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, December 13, 2024 05:54
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/nbio7.7: fix IP version check

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_7.c
index 1ac730328516f..3fb6d2aa7e3b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -247,7 +247,7 @@ static void nbio_v7_7_init_registers(struct amdgpu_devi=
ce *adev)
        if (def !=3D data)
                WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);

-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
        case IP_VERSION(7, 7, 0):
                data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) & ~=
BIT(23);
                WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
--
2.47.1

